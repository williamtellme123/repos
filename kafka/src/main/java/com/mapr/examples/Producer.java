package com.mapr.examples;

import com.google.common.io.Resources;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 *  https://github.com/mapr-demos/kafka-sample-programs/tree/master/src/main/java/com/mapr/examples
 *
 *  This producer sends all messages to topic "fast-messages"
 *      on the mod sends to both "fast" and "summary-markers" (multiple topics
 *
 *      We see both kinds of messages and also how two topics aren't really synchronized
 *
 *
 */
public class Producer {

    public static void main(String[] args) throws IOException {

        // INITIALIZE AND CONFIGURE A PRODUCER
        KafkaProducer<String, String> producer;
        try (InputStream props = Resources.getResource("producer.props").openStream()) {
            Properties properties = new Properties();
            properties.load(props);
            producer = new KafkaProducer<>(properties);
        }

        try {
            for (int i = 0; i <= 1000; i++) {
                // SEND LOTS OF MESSAGES
                producer.send(new ProducerRecord<String, String>(
                        "fast-messages",
                        String.format("{\"type\":\"test\", \"t\":%.3f, \"k\":%d}", System.nanoTime() * 1e-9, i)));
                        System.out.println("EVERY ---------------------------------------------------------------------- >"+ i);

                // EVERY SO OFTEN SEND TO A DIFFERENT TOPIC
                if (i % 100 == 0) {
                    producer.send(new ProducerRecord<String, String>(
                            "fast-messages",
                                String.format("{\"type\":\"marker\", \"t\":%.3f, \"k\":%d}", System.nanoTime() * 1e-9, i)));
                                System.out.println("Fast --------------> " + i);
                    producer.send(new ProducerRecord<String, String>(
                            "summary-markers",
                            String.format("{\"type\":\"other\", \"t\":%.3f, \"k\":%d}", System.nanoTime() * 1e-9, i)));
                            System.out.println("Sent msg number Summary ----------------------> " + i);
                    producer.flush();
                }
            }
        } catch (Throwable throwable) {
            System.out.printf("%s", throwable.getStackTrace());
        } finally {
            producer.close();
        }

    }
}


//   cd /usr/local/kafka
//
//// START ZOOKEEPER
//        Note starts Zookeeper background. To stop bring it fg and ctrl-C
//        bin/zookeeper-server-start.sh config/zookeeper.properties &
//
//
//// START KAFKA
//        bin/kafka-server-start.sh config/server.properties
//
//// CREATE TOPICS
//// msgs organized by topics
//// Producers post messages to topic
//// Consumers read messages from topic
//// Following code creates topics: fast-messages, summary-markers
//
//        bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic fast-messages
//        bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic summary-markers
//
//
//// LIST TOPICS
//        bin/kafka-topics.sh --list --zookeeper localhost:2181