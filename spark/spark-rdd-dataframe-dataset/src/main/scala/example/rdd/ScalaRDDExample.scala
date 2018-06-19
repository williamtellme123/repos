package example.rdd

import java.text.SimpleDateFormat
import java.util.Locale

import example.common.ScalaData
import org.apache.log4j.{Level, Logger}
import org.apache.spark.{SparkConf, SparkContext}


object ScalaRDDExample {

  val formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH)
  def main(arg: Array[String]): Unit = {

    val rootLogger = Logger.getRootLogger()
    rootLogger.setLevel(Level.WARN)


    val conf = new SparkConf()
      .setAppName("Example")
      .setMaster("local[*]")

    val sc = new SparkContext(conf)

    // load initial RDD
    val rdd = sc.parallelize(ScalaData.sampleData())

    // example transformations

    // verbose syntax
    println("Under 21")
    rdd.filter(p => p.age < 21).foreach(println(_))

    // concise syntax
    println("Over 21")
    rdd.filter(_.age > 21).foreach(println(_))

  }

}








