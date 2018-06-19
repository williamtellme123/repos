package net.datetl.scala


import java.text.SimpleDateFormat
import java.util.Locale

import kafka.serializer.StringDecoder
import org.apache.spark.streaming.kafka.KafkaUtils
import org.apache.spark.streaming.{Seconds, StreamingContext}
import org.apache.spark.{SparkConf, SparkContext}

/**
  * https://github.com/apache/spark/blob/master/docs/streaming-programming-guide.md
  */

object SimpleScalaSparkStreamingStringConsumer {


  def main(args: Array[String]): Unit = {
    val formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH)
    System.out.println("----------------------------------------------------------------------------")
    System.out.println("---------------------------------------1. Start Simple Consumer")

    System.out.println("----------------------------------------------------------------------------")
    System.out.println("---------------------------------------2. SparkContext Object")

    val sc = new SparkContext(new SparkConf()
      .setAppName("GeoTime")
      .setMaster("local[*]"))


    System.out.println("----------------------------------------------------------------------------")
    System.out.println("---------------------------------------3. StreamingContext Object")
    val ssc = new StreamingContext(sc, Seconds(2))

    System.out.println("----------------------------------------------------------------------------")
    System.out.println("---------------------------------------5. Init KafkaParams")
    System.out.println("---------------------------------------    a. Broker and port")
    System.out.println("---------------------------------------    b. Provide existing Topic")
    System.out.println("---------------------------------------    c. Provide types")
    System.out.println("---------------------------------------    d. Deserializers for key/value")

//    val kafkaParams = Map[String, String]("metadata.broker.list" -> "localhost:9092",
//      "group.id" -> "myGroup")
    val kafkaParams = Map[String, String]("metadata.broker.list" -> "localhost:9092")

    System.out.println("----------------------------------------------------------------------------")
    System.out.println("---------------------------------------6. Link to mytopic to consume")

    val topics = Array("mytopic").toSet

    System.out.println("----------------------------------------------------------------------------")
    System.out.println("---------------------------------------7. Create KafkaDirectStream Object")
    System.out.println("---------------------------------------     a. Use JavaStreamingContext (No. 3) above")
    System.out.println("---------------------------------------     b. Use KafkaParams (No. 4) above")
    System.out.println("---------------------------------------     c. Use topics (No. 5) above")

    val directKafkaStream = KafkaUtils.createDirectStream[String, String, StringDecoder, StringDecoder](
                              ssc,
                              kafkaParams,
                              topics)
    System.out.println("----------------------------------------------------------------------------")
    System.out.println("---------------------------------------8. Set up Consume Records Process")
    directKafkaStream.foreachRDD( rdd => {
      System.out.println("--- New RDD with " + rdd.partitions.size
        + " partitions and " + rdd.count() + " records")
      rdd.foreach(record => System.out.println(record._2))
    })

    System.out.println("----------------------------------------------------------------------------")
    System.out.println("---------------------------------------9. Start StreamingContext and keep application alive")
    ssc.start
    ssc.awaitTermination


  } // eom

}
