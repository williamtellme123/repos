package net.datetl.scala

import net.datetl.java.JavaPerson
import java.io.BufferedReader
import java.io.File
import java.io.FileReader
import java.util.ArrayList
import java.util.List
import java.util.stream.Collectors

import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.rdd.RDD


case class Person(first: String,last: String, age: Integer, state: String)

class ScalaData() {


  val sc = new SparkContext(new SparkConf()
              .setAppName("GeoTime")
              .setMaster("local[*]"))
    val myrddText = sc.textFile("data.csv")


      myrddText.map(line => {
                           val parts = line.split(",")
                           Person(parts(0), parts(1), Integer.parseInt(parts(2)), parts(3))
                           }

    def sampleDataAsStrings: List[String] = {
      val ret: List[_] = new ArrayList[String]
      val r: BufferedReader = new BufferedReader(new FileReader(new File("data.csv")))
      var line: String = null
      while ((line = r.readLine) != null) {
        {
          ret.add(line)
        }
      }
      r.close
      return ret
    }

}
