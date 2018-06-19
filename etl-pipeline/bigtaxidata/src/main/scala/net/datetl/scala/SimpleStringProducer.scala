package net.datetl.scala

import java.text.SimpleDateFormat
import java.util.{Locale, Properties}

import org.apache.kafka.clients.producer.{KafkaProducer, ProducerRecord}


object SimpleStringProducer {
  /**
    * https://github.com/apache/spark/blob/master/docs/streaming-programming-guide.md

    */

  def main(args: Array[String]): Unit = {
    val formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH)
    System.out.println("----------------------------------------------------------------------------")
    System.out.println("---------------------------------------1. Start Simple Producer")
    val props: Properties = new Properties
    System.out.println("----------------------------------------------------------------------------")
    System.out.println("---------------------------------------2. Configure Properties")
    System.out.println("---------------------------------------    a. KAFKA SERVER bootstrap.servers is the host and port to our Kafka server")
    props.put("bootstrap.servers", "localhost:9092")
    System.out.println("---------------------------------------    b. MESSAGE KEY key.serializer is the name of the class to serialize the key of the messages " + "\n" + "                                                      messages have a key and value, but even though the key is optional, a serializer needs to be provided")
    props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer")
    System.out.println("---------------------------------------    c. MESSAGE VALUE value.serializer is the name of the class to serialize the value of the message." + "\n" + "                                                      We’re going to send strings, hence the StringSerializer.")
    props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer")
    System.out.println("----------------------------------------------------------------------------")
    System.out.println("---------------------------------------3. Create Producer")
    System.out.println("---------------------------------------    a. KEY AS GENERIC PARAMETER")
    System.out.println("---------------------------------------    b. VALUE AS GENERIC PARAMETER")
    System.out.println("---------------------------------------    c. PROPERTIES OBJECT")


    val producer: KafkaProducer[String, String] = new KafkaProducer[String, String](props)
    System.out.println("----------------------------------------------------------------------------")
    System.out.println("---------------------------------------4. Send Messages")
    System.out.println("---------------------------------------    a. MESSAGE TYPE : ProducerRecord")
    System.out.println("---------------------------------------    b. PARAMETERS: Generic parameters: key/value")
    System.out.println("---------------------------------------    c. SPECIFY topicName, Value (omitting the key)")
    var i: Int = 0
    while (i < 1000) {
      {
        val record: ProducerRecord[String, String] = new ProducerRecord[String, String]("mytopic", "new value-" + i)
        producer.send(record)
        Thread.sleep(250)
      }
      ({
        i += 1; i - 1
      })
    }

    producer.close

  } //eom
}
