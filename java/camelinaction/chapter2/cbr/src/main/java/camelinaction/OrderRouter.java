/**
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package camelinaction;

import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.camel.CamelContext;
import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.component.jms.JmsComponent;
import org.apache.camel.impl.DefaultCamelContext;

import javax.jms.ConnectionFactory;

/**
 * A set of routes that watches a directory for new orders, reads them, converts the order 
 * file into a JMS Message and then sends it to the JMS incomingOrders queue hosted 
 * on an embedded ActiveMQ broker instance.
 * 
 * From there a content-based router is used to send the order to either the
 * xmlOrders or csvOrders queue.
 *
 * @author janstey
 *
 */
public class OrderRouter {

    public static void main(String args[]) throws Exception {
        // create CamelContext
        CamelContext context = new DefaultCamelContext();
        
        // connect to embedded ActiveMQ JMS broker
        ConnectionFactory connectionFactory = 
            new ActiveMQConnectionFactory("vm://localhost");
        context.addComponent("jms",
            JmsComponent.jmsComponentAutoAcknowledge(connectionFactory));

        // add our route to the CamelContext
        context.addRoutes(new RouteBuilder() {
            @Override
            public void configure() {
                // load file orders from src/data into the JMS queue
                from("file:src/data?noop=true").to("jms:incomingOrders");
        
                // content-based router
                from("jms:incomingOrders")
                .choice()
                    .when(header("CamelFileName").endsWith(".xml"))
                        .to("jms:xmlOrders")  
                    .when(header("CamelFileName").endsWith(".csv"))
                        .to("jms:csvOrders")
                    .when(header("CamelFileName").endsWith(".csl"))
                        .to("jms:csvOrders")
                    .otherwise()
                        .to("jms:badFiles");

                // TRANSFORMING USING CUSTOM PROCESSOR
                // USING BEANS
                // 1. Use Quartz schedule job run at 6 a.m.
                // 2. Then invokes the HTTP service  to retrieve yesterday's orders in custom format
                // 3. Next, it uses OrderToCSVProcessor to map from custom format to CSV format
                // 4. Writes result to a file
//                from("quartz://report?cron=0+0+6+*+*+?")
//                        .to("http://riders.com/orders/cmd=received&date=yesterday")
//                        .bean(new OrderToCsvBean())
//                        .to("file://riders/orders?fileName=report-${header.Date}.csv");

                // TRANSFORMING USING TRANSFORM
                from("direct:start")
                        .transform(body().regexReplaceAll("\n", "<br/>"))
                        .to("mock:result");


                // SENT HERE FROM THE TOs above
                from("jms:xmlOrders").process(new Processor() {
                    public void process(Exchange exchange) throws Exception {
                        System.out.println("Received XML order: " 
                                + exchange.getIn().getHeader("CamelFileName"));   
                    }
                });                
                from("jms:csvOrders").process(new Processor() {
                    public void process(Exchange exchange) throws Exception {
                       System.out.println("Received CSV order: "
                                + exchange.getIn().getHeader("CamelFileName"));   
                    }
                });
                from("jms:cslOrders").process(new Processor() {
                    public void process(Exchange exchange) throws Exception {
                        System.out.println("Received CSL order: "
                                + exchange.getIn().getHeader("CamelFileName"));
                    }
                });
                from("jms:badFiles").process(new Processor() {
                    public void process(Exchange exchange) throws Exception {
                        System.out.println("Received Bad File: "
                                + exchange.getIn().getHeader("CamelFileName"));
                    }
                });





            }
        });

        // start the route and let it do its work
        context.start();
        Thread.sleep(10000);

        // stop the CamelContext
        context.stop();
    }
}
