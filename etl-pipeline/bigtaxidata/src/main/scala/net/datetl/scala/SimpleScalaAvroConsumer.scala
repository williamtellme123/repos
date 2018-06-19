package net.datetl.scala

import com.twitter.bijection.Injection
import com.twitter.bijection.avro.GenericAvroCodecs
import kafka.serializer.{DefaultDecoder, StringDecoder}
import org.apache.avro.Schema
import org.apache.avro.generic.GenericRecord
import org.apache.spark.streaming.kafka.KafkaUtils
import org.apache.spark.streaming.{Seconds, StreamingContext}
import org.apache.spark.{SparkConf, SparkContext}


/**
  * Thanks to Alexis Seigneurin www.ipponusa.com
  * https://github.com/apache/spark/blob/master/docs/streaming-programming-guide.md
  * http://aseigneurin.github.io/2016/03/04/kafka-spark-avro-producing-and-consuming-avro-messages.html
  **
  *SimpleJavaStringConsumer
  *Replace StringDecoder with the DefaultDecoder => SimpleJavaAvroProducer (value only)
  *This results raw array of bytes
  */

object SimpleScalaAvroConsumer {


  val parser = new Schema.Parser()
  val schema = parser.parse(net.datetl.scala.SimpleScalaAvroProducer.USER_SCHEMA)
  val recordInjection : Injection[GenericRecord, Array[Byte]]  = GenericAvroCodecs.toBinary[GenericRecord](schema)

  def main(args: Array[String]): Unit = {

    // val formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH)

    val sc = new SparkContext(new SparkConf()
      .setAppName("GeoTime")
      .setMaster("local[*]"))

    val ssc = new StreamingContext(sc, Seconds(2))

    System.out.println("----------------------------------------------------------------------------")
    System.out.println("---------------------------------------1. Start Simple Consumer")

    val kafkaParams = Map[String, String]("metadata.broker.list" -> "localhost:9092")
    val topics = Array("mytopic").toSet

    System.out.println("----------------------------------------------------------------------------")
    System.out.println("---------------------------------------2. Create Direct Stream")
    val directKafkaStream = KafkaUtils.createDirectStream[String, Array[Byte], StringDecoder,DefaultDecoder](
                    ssc,
                    kafkaParams,
                    topics)
    val lines = directKafkaStream.map(record => recordInjection.invert(record._2).get)
    lines.foreachRDD( thisRDD => {
      thisRDD.foreach(x =>{
              println(x)
              System.out.println("x.getClass:  " + x.getClass)

//        x.getClass:  class org.apache.avro.generic.GenericData$Record

        //              val json = Json.toJson(x)
//              Json.prettyPrint(json)


                    System.out.println("str1= " + x.get("str1") +
                    ", str2= " + x.get("str2") +
                    ", int1=" + x.get("int1"))

      })
        }
      )
    ssc.start
    ssc.awaitTermination

 }//eom

}