package net.datetl.java;


import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;

import java.util.Arrays;
import java.util.Properties;

public class SimpleJavaStringConsumer {

    public static void main(String[] args) {

        System.out.println("----------------------------------------------------------------------------");
        System.out.println("---------------------------------------1. Start Simple Consumer");
        Properties props = new Properties();
        System.out.println("----------------------------------------------------------------------------");
        System.out.println("---------------------------------------2. Configure Properties");
        System.out.println("---------------------------------------    a. KAFKA SERVER bootstrap.servers is the host and port to our Kafka server");
        props.put("bootstrap.servers", "localhost:9092");
        System.out.println("---------------------------------------    b. KEY DESERIALIZER String.Deserializer");
        props.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
        props.put("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
        System.out.println("---------------------------------------    c. CONSUMERs BELONG TO GROUP" + "\n" +
                "                                                      Each consumer in group receives subset of messages." + "\n" +
                "                                                      Therefore sharing the load.");
        props.put("group.id", "mygroup");
        System.out.println("---------------------------------------3. Create Consumer");
        KafkaConsumer<String, String> consumer = new KafkaConsumer<>(props);


        System.out.println("---------------------------------------4. Subscribe to topic");
        consumer.subscribe(Arrays.asList("mytopic"));
        //consumer.subscribe("mytopic");
        System.out.println("---------------------------------------5. Consumer Polls" + "\n" +
                "                                                      Poll queries topic, with Timeout in ms" + "\n" +
                "                                                      Returns list of ConsumerRecords (each with key/value which has been deserialized using prop above");

        boolean running = true;
        while (running) {
            ConsumerRecords<String, String> records = consumer.poll(100);
            for (ConsumerRecord<String, String> record : records) {
                System.out.println(record.value());
            }
        }

        consumer.close();
    }
}