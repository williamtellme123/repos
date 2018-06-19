package net.datetl.java;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;

import java.util.Properties;

/**
 *
 Thanks to Alexis Seigneurin www.ipponusa.com
 https://github.com/apache/spark/blob/master/docs/streaming-programming-guide.md
 SimpleJavaStringProducer
     1. Create/Set props object
            i.      bootstrap.servers, localhost:9092
                        key             value
            ii.     key.serializer, org.apache.kafka.common.serialization.StringSerializer
                        key             value
            ii.     value.serializer, org.apache.kafka.common.serialization.StringSerializer
                        key             value
    2. Create producer object with props object
            KafkaProducer<String, String> myProducer =
                new KafkaProducer<>(props)

    3. Create and send messages
            for (int i = 0; i < 100; i++){
                ProducerRecord <String, String> thisRecord =
                        new ProducerRecord<>("mytopic","value-"+ i);
                myProducer.send(thisRecord);
             }
 */


public class SimpleJavaStringProducer {

    public static void main(String[] args) {
        System.out.println("----------------------------------------------------------------------------");
        System.out.println("---------------------------------------1. Start Simple Producer");
        Properties props = new Properties();



        System.out.println("----------------------------------------------------------------------------");
        System.out.println("---------------------------------------2. Configure Properties");
        System.out.println("---------------------------------------    a. Kafka server bootstrap.servers is the host and port to our Kafka server");
        System.out.println("---------------------------------------    b. key.serializer is class name to serialize key " + "\n" +
                    "                                                      even though the key is optional, serializer must be provided");
        System.out.println("---------------------------------------    c. value.serializer is class name to serialize value");
        props.put("bootstrap.servers", "localhost:9092");
        props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");



        System.out.println("----------------------------------------------------------------------------");
        System.out.println("---------------------------------------3. Create Producer");
        System.out.println("---------------------------------------    a. Using properties above");
        KafkaProducer<String, String> producer = new KafkaProducer<>(props);



        System.out.println("----------------------------------------------------------------------------");
        System.out.println("---------------------------------------4. Produce (send) 100 Messages");
        System.out.println("---------------------------------------    a. Message type : ProducerRecord");
        System.out.println("---------------------------------------    b. Parameters: Generic parameters: key/value");
        System.out.println("---------------------------------------    c. Specify topicName, Value (omitting the key)");
        System.out.println("---------------------------------------    d. Sleep 250ms so write 4 records/second)");
        for (int i = 0; i < 100; i++) {
            ProducerRecord<String, String> record = new ProducerRecord<>("mytopic", "value-" + i);
            producer.send(record);
            /**
             1. Start this Spark Streaming
             2. Edit SimpleJavaStringProducer so it posts message to mytopic every 250 ms

             */
            try {
                Thread.sleep(250) ;
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

        }

        producer.close();
    }
}