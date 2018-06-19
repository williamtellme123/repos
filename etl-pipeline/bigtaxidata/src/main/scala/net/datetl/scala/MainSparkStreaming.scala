package net.datetl.scala

import org.apache.spark.SparkConf
import org.apache.spark.rdd.RDD
import org.apache.spark.streaming.{Duration, Seconds, StreamingContext}

//import org.apache.spark.api.java.JavaSparkContext
//import org.apache.spark.streaming.api.java.JavaStreamingContext;

/**
   Thanks to Alexis Seigneurin www.ipponusa.com

    SPARK STREAMING  : DIRECT (NOT RECEIVER-BASED)
    -----------------------------------
        1-to-1 mapping btw Kafka partition (topic) and a Spark partition (RDD)
     SPARK STREAMING SCALA
    -----------------------------------
        1. Initialize SparkContext
        2. Initialize StreamingContext with duration
        3. Describe processing pipeline
        4. Start the StreamingContext and keep the application alive


  SimpleJavaStringProducer
      Writes to the topic every 250 ms (4 times/second)
  SimpleJavaStringConsumer
      Read from topic a Discretized Streams (DStream) every 2 seconds
      This consumes about 8 messages every read

*/



object MainSparkStreaming {


  val sparkConf = new SparkConf()
    .setMaster("local[*]")
    .setAppName("spark-streaming-testing-example")

  val ssc = new StreamingContext(sparkConf, new Duration(2000))

  def main(args: Array[String]): Unit = {

    var kafkaParams = scala.collection.mutable.Map[String, String]()

//    kafkaParams = "metadata.broker.list"
//
//
//
//      , "localhost:9092")
//    Set topics = Collections.singleton("mytopic")
//
//    JavaPairInputDStream<String, String> directKafkaStream = KafkaUtils.createDirectStream(ssc,
//
//      String.class, String.class, StringDecoder.class, StringDecoder.class, kafkaParams, topics);



    val rddQueue = new scala.collection.mutable.Queue[RDD[Char]]()

    ssc.queueStream(rddQueue)
      .map(_.toUpper)
      .window(windowDuration = Seconds(3), slideDuration = Seconds(2))
      .print()

    ssc.start()

    for (c <- 'a' to 'z') {
      rddQueue += ssc.sparkContext.parallelize(List(c))
    }

    ssc.awaitTermination()
  }
}

