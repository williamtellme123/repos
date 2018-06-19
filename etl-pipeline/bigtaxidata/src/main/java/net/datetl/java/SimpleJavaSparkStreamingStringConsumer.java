package net.datetl.java;

import kafka.serializer.StringDecoder;
import org.apache.spark.SparkConf;

import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.streaming.Duration;
import org.apache.spark.streaming.api.java.JavaPairInputDStream;
import org.apache.spark.streaming.api.java.JavaStreamingContext;
import org.apache.spark.streaming.kafka.KafkaUtils;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;


 /**
 Thanks to Alexis Seigneurin www.ipponusa.com
  https://github.com/apache/spark/blob/master/docs/streaming-programming-guide.md
    SimpleJavaStringProducer
        1. Create Spark Context

        2. Create JavaSparkContext

        3. Create JavaStreamingContext

        4. Init KafkaParams

        5. Link to mytopic to consume

        6. Create KafkaDirectStream

        7. Set up Consume Records Process
                  directKafkaStream.foreachRDD(  rdd ->
                        {
                            System.out.println("--- New RDD with " + rdd.partitions().size()
                                        + " partitions and " + rdd.count() + " records");
                            rdd.foreach(record -> System.out.println(record._2));
                        };

        8. Start StreamingContext

        9. Use SimpleJavaStringProducer

  https://github.com/aseigneurin/spark-kafka-writer
  To write a Java DStream to Kafka:

  JavaDStreamKafkaWriter<String> writer = JavaDStreamKafkaWriterFactory.fromJavaDStream(instream);
  writer.writeToKafka(producerConf, new ProcessingFunc());

  Equivalently, a Java RDD can be written to Kafka in the following format:

  JavaRDDKafkaWriter<String> writer = JavaRDDKafkaWriterFactory.fromJavaRDD(inrdd);
  writer.writeToKafka(producerConf, new ProcessingFunc());

 */



public class SimpleJavaSparkStreamingStringConsumer {

    public static void main(String[] args) {

        System.out.println("----------------------------------------------------------------------------");
        System.out.println("---------------------------------------1. SparkContext Object");
        SparkConf conf = new SparkConf()
                .setAppName("kafka-sandbox")
                .setMaster("local[*]");

        System.out.println("----------------------------------------------------------------------------");
        System.out.println("---------------------------------------2. JavaSparkContext Object");
        JavaSparkContext sc = new JavaSparkContext(conf);


        System.out.println("----------------------------------------------------------------------------");
        System.out.println("---------------------------------------3. JavaStreamingContext");
        System.out.println("---------------------------------------    a. Use No. 2 above");
        JavaStreamingContext ssc = new JavaStreamingContext(sc, new Duration(2000));


        System.out.println("----------------------------------------------------------------------------");
        System.out.println("---------------------------------------4. Init KafkaParams");
        System.out.println("---------------------------------------    a. Broker and port");
        System.out.println("---------------------------------------    b. Provide existing Topic");
        System.out.println("---------------------------------------    c. Provide types");
        System.out.println("---------------------------------------    d. Deserializers for key/value");
        Map<String, String> kafkaParams = new HashMap<>();
        kafkaParams.put("metadata.broker.list", "localhost:9092");

        System.out.println("----------------------------------------------------------------------------");
        System.out.println("---------------------------------------5. Link to mytopic to consume");
        Set<String> topics = Collections.singleton("mytopic");

        System.out.println("----------------------------------------------------------------------------");
        System.out.println("---------------------------------------6. Create KafkaDirectStream Object");
        System.out.println("---------------------------------------     a. Use JavaStreamingContext (No. 3) above");
        System.out.println("---------------------------------------     b. Use KafkaParams (No. 4) above");
        System.out.println("---------------------------------------     c. Use topics (No. 5) above");
        JavaPairInputDStream<String, String> directKafkaStream =
                     KafkaUtils.createDirectStream(
                             ssc,                                           //  JavaStreamingContext
                             String.class,                                  //  Data type key
                             String.class,                                  //  Data type value
                             StringDecoder.class,                           //  Deserializer for key
                             StringDecoder.class,                           //  Deserializer for value
                             kafkaParams,                                   //  Broker list and server
                             topics);                                       //  Pre-defined topic


        System.out.println("----------------------------------------------------------------------------");
        System.out.println("---------------------------------------7. Set up Consume Records Process");
        directKafkaStream.foreachRDD(   rdd -> {
            System.out.println("--- New RDD with " + rdd.partitions().size()
                    + " partitions and " + rdd.count() + " records");
            rdd.foreach(record -> System.out.println(record._2));
        });

        System.out.println("----------------------------------------------------------------------------");
        System.out.println("---------------------------------------8. Start StreamingContext and keep application alive");
        ssc.start();
        ssc.awaitTermination();

    }
}