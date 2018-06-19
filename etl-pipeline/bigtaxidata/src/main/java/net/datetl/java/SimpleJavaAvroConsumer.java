package net.datetl.java;

import com.twitter.bijection.Injection;
import com.twitter.bijection.avro.GenericAvroCodecs;
import kafka.serializer.DefaultDecoder;
import kafka.serializer.StringDecoder;
import org.apache.avro.Schema;
import org.apache.avro.generic.GenericRecord;
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
    SimpleJavaStringConsumer
        Replace StringDecoder with the DefaultDecoder => SimpleJavaAvroProducer (value only)
        This results raw array of bytes
 */
public class SimpleJavaAvroConsumer {


    // Create Injection object :: 1 per JVM therefore 1 per Spark worker
    private static Injection<GenericRecord, byte[]> recordInjection;

    // Parse Schema using lambda expr (static init block)
    static {
        Schema.Parser parser = new Schema.Parser();
        Schema schema = parser.parse(SimpleJavaAvroProducer.USER_SCHEMA);
        recordInjection = GenericAvroCodecs.toBinary(schema);
    }


    public static void main(String[] args) {
        // If we place Create Injection object and Parse Schema in main()
        // The recordInjection would be serialized and sent to all workers
        // Exception in thread "main" org.apache.spark.SparkException: Task not serializable
        //
        // Instead :: Static init block creates one per JVM therefore one per Spark worker


        SparkConf conf = new SparkConf()
                .setAppName("kafka-sandbox")
                .setMaster("local[*]");
        JavaSparkContext sc = new JavaSparkContext(conf);
        JavaStreamingContext ssc = new JavaStreamingContext(sc, new Duration(2000));

        Set<String> topics = Collections.singleton("mytopic");
        Map<String, String> kafkaParams = new HashMap<>();
        kafkaParams.put("metadata.broker.list", "localhost:9092");

        JavaPairInputDStream<String, byte[]> directKafkaStream = KafkaUtils.createDirectStream(ssc,
                String.class, byte[].class, StringDecoder.class, DefaultDecoder.class, kafkaParams, topics);

        directKafkaStream.foreachRDD(rdd -> {
            rdd.foreach(avroRecord -> {
                Schema.Parser parser = new Schema.Parser();
                Schema schema = parser.parse(SimpleJavaAvroProducer.USER_SCHEMA);
                Injection<GenericRecord, byte[]> recordInjection = GenericAvroCodecs.toBinary(schema);
                GenericRecord record = recordInjection.invert(avroRecord._2).get();

                System.out.println("str1= " + record.get("str1")
                        + ", str2= " + record.get("str2")
                        + ", int1=" + record.get("int1"));
            });
        });

        ssc.start();
        ssc.awaitTermination();
    }
}