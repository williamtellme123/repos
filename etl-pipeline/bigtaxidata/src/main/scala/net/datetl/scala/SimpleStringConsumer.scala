package net.datetl.scala

import java.text.SimpleDateFormat
import java.util.{Arrays, Locale, Properties}

import org.apache.kafka.clients.consumer.{ConsumerRecords, KafkaConsumer};


object SimpleStringConsumer {


  def main(args: Array[String]): Unit = {

    val formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH)
    System.out.println("----------------------------------------------------------------------------")
    System.out.println("---------------------------------------1. Start Simple Consumer")

    val props: Properties = new Properties
    System.out.println("----------------------------------------------------------------------------")
    System.out.println("---------------------------------------2. Configure Properties")
    System.out.println("---------------------------------------    a. KAFKA SERVER bootstrap.servers is the host and port to our Kafka server")
    System.out.println("---------------------------------------    b. KEY DESERIALIZER String.Deserializer")
    System.out.println("---------------------------------------    c. CONSUMERs BELONG TO GROUP" + "\n" +
      "                                                      Each consumer in group receives subset of messages." + "\n" +
      "                                                      Therefore sharing the load.")
    props.put("bootstrap.servers", "localhost:9092")
    props.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer")
    props.put("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer")
    props.put("group.id", "mygroup")
    System.out.println("---------------------------------------3. Create Consumer")
    val consumer = new KafkaConsumer[String, String](props)


    System.out.println("---------------------------------------4. Subscribe to topic")
    consumer.subscribe(Arrays.asList("mytopic"))
    System.out.println("---------------------------------------5. Consumer Polls" + "\n" +
      "                                                      Poll queries topic, with Timeout in ms" + "\n" +
      "                                                      Returns list of ConsumerRecords (each with key/value which has been deserialized using prop above")
    val running: Boolean = true
    while (running) {
      {
        val records: ConsumerRecords[String, String] = consumer.poll(100)
        import scala.collection.JavaConversions._
        for (record <- records) {
          System.out.println(record.value)
        }
      }
    }

 }//eom

}