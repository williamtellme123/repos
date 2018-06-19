package etl.bt.spark

// see original imports below


import java.text.SimpleDateFormat
import java.util.Locale

import com.esri.core.geometry.Point
import etl.bt.spark.GeoJsonProtocol._
import org.apache.log4j.{Level, Logger}
import org.apache.spark.rdd.RDD
import org.apache.spark.util.StatCounter
import org.apache.spark.{HashPartitioner, Partitioner, SparkConf, SparkContext}
import org.joda.time.{DateTime, Duration}
import spray.json._

import scala.collection.mutable.ArrayBuffer
import scala.reflect.ClassTag


case class Trip(
                 pickupTime: DateTime,
                 dropoffTime: DateTime,
                 pickupLoc: Point,
                 dropoffLoc: Point)

object RunGeoTime extends Serializable {

  val formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH)

  def main(args: Array[String]): Unit = {

        val rootLogger = Logger.getRootLogger()
        rootLogger.setLevel(Level.ERROR)

    // -----------------------------------------------------------------------------
    // Taxi Bad
    var mainstartTime = java.time.Instant.now()
    var startTime = java.time.Instant.now()
    System.out.println("")
    System.out.println("")
    System.out.println("")
    System.out.println("-----------------------------------------------")
    System.out.println("StartTime = " + startTime)
    System.out.println("-----------------------------------------------")
    System.out.println("")
    System.out.println("")
    val sc = new SparkContext(new SparkConf()
      .setAppName("GeoTime")
     //      .setMaster("yarn-client"))
        .setMaster("local"))


    //    val taxiRaw = sc.textFile("/Users/billy/repos/spark/aas/taxidata100.csv")
    val taxiRaw = sc.textFile("taxidata100.csv")
    val safeParse = safe(parse)
    val taxiParsed = taxiRaw.map(safeParse)
    taxiParsed.cache()
    val taxiBad = taxiParsed.collect({
      case t if t.isRight => t.right.get
    })
    System.out.println("")
    System.out.println("")
    System.out.println("")
    System.out.println("taxiBad---------------------------------------------")
    taxiBad.collect().foreach(println)
    System.out.println("taxiBad---------------------------------------------")
    var endTime = java.time.Instant.now()
    var between = java.time.Duration.between(startTime, endTime)
    var seconds = between.getSeconds()
    var tbseconds = seconds % 60
    var tbminutes = seconds / 60
    System.out.println("Seconds: " + seconds)
    System.out.println("Elapsed time taxiBad: " + tbminutes +" minutes   "+ tbseconds + " seconds" )
    System.out.println("")
    System.out.println("")
    System.out.println("")


    // -----------------------------------------------------------------------------
    // Taxi Good
    startTime = java.time.Instant.now()
    val taxiGood = taxiParsed.collect({
      case t if t.isLeft => t.left.get
    })
    taxiGood.cache()
    System.out.println("")
    System.out.println("")
    System.out.println("")
    System.out.println("taxiGood---------------------------------------------")
    def hours(trip: Trip): Long = {
      val d = new Duration(trip.pickupTime, trip.dropoffTime)
      d.getStandardHours
    }
    taxiGood.values.map(hours).countByValue().toList.sorted.foreach(println)
    System.out.println("taxiGood---------------------------------------------")
    endTime = java.time.Instant.now()
    between = java.time.Duration.between(startTime, endTime)
    seconds = between.getSeconds()
    var tgseconds = seconds % 60
    var tgminutes = seconds / 60
    System.out.println("Seconds: " + seconds)
    var totsecs = (tbseconds+ tgseconds) % 60
    var totmins =  (tbminutes + tgminutes) + ((tbseconds+ tgseconds) / 60)
    System.out.println("Elapsed time taxiBad: " + tbminutes +" minutes   "+ tbseconds + " seconds" )
    System.out.println("Elapsed time taxiGood: " + tgminutes +" minutes   "+ tgseconds + " seconds" )
    System.out.println("--------------------------------------------------------")
    System.out.println("Total: " + totmins + " minutes   "+ totsecs + " seconds" )
    System.out.println("")
    System.out.println("")
    System.out.println("")


    // -----------------------------------------------------------------------------
    // Taxi Clean
    startTime = java.time.Instant.now()
    val taxiClean = taxiGood.filter {
      case (lic, trip) => {
        val hrs = hours(trip)
        0 <= hrs && hrs < 3
      }
    }
    val geojson = scala.io.Source.fromURL(getClass.getResource("/nyc-boroughs.geojson")).mkString
    val features = geojson.parseJson.convertTo[FeatureCollection]
    val areaSortedFeatures = features.sortBy(f => {
      val borough = f("boroughCode").convertTo[Int]
      (borough, -f.geometry.area2D())
    })
    val bFeatures = sc.broadcast(areaSortedFeatures)
    def borough(trip: Trip): Option[String] = {
      val feature: Option[Feature] = bFeatures.value.find(f => {
        f.geometry.contains(trip.dropoffLoc)
      })
      feature.map(f => {
        f("borough").convertTo[String]
      })
    }
    System.out.println("")
    System.out.println("")
    System.out.println("")
    System.out.println("taxiClean---------------------------------------------")
    taxiClean.values.map(borough).countByValue().foreach(println)
    System.out.println("taxiClean---------------------------------------------")
    endTime = java.time.Instant.now()
    between = java.time.Duration.between(startTime, endTime)
    seconds = between.getSeconds()
    var tcseconds = seconds % 60
    var tcminutes = seconds / 60
    System.out.println("Seconds: " + seconds)
    totsecs = (tbseconds + tgseconds + tcseconds) % 60
    totmins =  (tbminutes + tgminutes + tcminutes) + ((tbseconds + tgseconds + tcseconds) / 60)
    System.out.println("Elapsed time taxiBad: " + tbminutes +" minutes   "+ tbseconds + " seconds" )
    System.out.println("Elapsed time taxiGood: " + tgminutes +" minutes   "+ tgseconds + " seconds" )
    System.out.println("Elapsed time taxiClean: " + tcminutes + "  seconds: " + tcseconds + " seconds" )
    System.out.println("--------------------------------------------------------")
    System.out.println("Total: " + totmins + " minutes   "+ totsecs + " seconds" )
    System.out.println("")
    System.out.println("")
    System.out.println("")


    // -----------------------------------------------------------------------------
    // Taxi Done
    startTime = java.time.Instant.now()
    def hasZero(trip: Trip): Boolean = {
      val zero = new Point(0.0, 0.0)
      (zero.equals(trip.pickupLoc) || zero.equals(trip.dropoffLoc))
    }
    val taxiDone = taxiClean.filter {
      case (lic, trip) => !hasZero(trip)
    }.cache()
    System.out.println("")
    System.out.println("")
    System.out.println("")
    System.out.println("taxiDone---------------------------------------------")
    taxiDone.values.map(borough).countByValue().foreach(println)
    System.out.println("taxiDone---------------------------------------------")
    endTime = java.time.Instant.now()
    between = java.time.Duration.between(startTime, endTime)
    seconds = between.getSeconds()
    var tdseconds = seconds % 60
    var tdminutes = seconds / 60
    System.out.println("Seconds: " + seconds)
    totsecs = (tbseconds + tgseconds + tcseconds + tdseconds) % 60
    totmins =  (tbminutes + tgminutes + tcminutes + tdminutes) + ((tbseconds+ tgseconds + tcseconds + tdseconds) / 60)
    System.out.println("Elapsed time taxiBad: " + tbminutes +" minutes   "+ tbseconds + " seconds" )
    System.out.println("Elapsed time taxiGood: " + tgminutes +" minutes   "+ tgseconds + " seconds" )
    System.out.println("Elapsed time taxiClean: " + tcminutes + "  seconds: " + tcseconds + " seconds" )
    System.out.println("Elapsed time taxiDone: " + tdminutes + "  seconds: " + tdseconds + " seconds" )
    System.out.println("--------------------------------------------------------")
    System.out.println("Total: " + totmins + " minutes   "+ totsecs + " seconds" )
    System.out.println("")
    System.out.println("")
    System.out.println("")


    // -----------------------------------------------------------------------------
    // Borough Durations
    startTime = java.time.Instant.now()
    def secondaryKeyFunc(trip: Trip) = trip.pickupTime.getMillis
    val sessions = groupByKeyAndSortValues(taxiDone, secondaryKeyFunc, split, 30)
    sessions.cache()
    def boroughDuration(t1: Trip, t2: Trip): (Option[String], Duration) = {
      val b = borough(t1)
      val d = new Duration(t1.dropoffTime, t2.pickupTime)
      (b, d)
    }
    val boroughDurations: RDD[(Option[String], Duration)] =
      sessions.values.flatMap(trips => {
        val iter: Iterator[Seq[Trip]] = trips.sliding(2)
        val viter = iter.filter(_.size == 2)
        viter.map(p => boroughDuration(p(0), p(1)))
      }).cache()
    System.out.println("")
    System.out.println("")
    System.out.println("")
    System.out.println("boroughDurations---------------------------------------------")
    boroughDurations.values.map(_.getStandardHours).countByValue().toList.sorted.foreach(println)
    System.out.println("boroughDurations---------------------------------------------")
    endTime = java.time.Instant.now()
    between = java.time.Duration.between(startTime, endTime)
    seconds = between.getSeconds()
    val bdseconds = seconds % 60
    val bdminutes = seconds / 60
    System.out.println("Seconds: " + seconds)
    totsecs = (tbseconds + tgseconds + tcseconds + tdseconds + bdseconds) % 60
    totmins =  (tbminutes + tgminutes + tcminutes + tdminutes + bdminutes) + ((tbseconds+ tgseconds + tcseconds + tdseconds + bdseconds) / 60)
    System.out.println("Elapsed time taxiBad: " + tbminutes +" minutes   "+ tbseconds + " seconds" )
    System.out.println("Elapsed time taxiGood: " + tgminutes +" minutes   "+ tgseconds + " seconds" )
    System.out.println("Elapsed time taxiClean: " + tcminutes + "  seconds: " + tcseconds + " seconds" )
    System.out.println("Elapsed time taxiDone: " + tdminutes + "  seconds: " + tdseconds + " seconds" )
    System.out.println("Elapsed time BoroughDurations: " + bdminutes + "  seconds: " + bdseconds + " seconds" )
    System.out.println("--------------------------------------------------------")
    System.out.println("Total: " + totmins + " minutes   "+ totsecs + " seconds" )
    System.out.println("")
    System.out.println("")
    System.out.println("")


    // -----------------------------------------------------------------------------
    // Borough Duration Filter
    startTime = java.time.Instant.now()
    System.out.println("")
    System.out.println("")
    System.out.println("")
    System.out.println("boroughDurations.filter---------------------------------------------")
    boroughDurations.filter {
      case (b, d) => d.getMillis >= 0
    }.mapValues(d => {
      val s = new StatCounter()
      s.merge(d.getStandardSeconds)
    }).reduceByKey((a, b) => a.merge(b)).collect().foreach(println)
    System.out.println("boroughDurations.filter---------------------------------------------")
    endTime = java.time.Instant.now()
    between = java.time.Duration.between(startTime, endTime)
    seconds = between.getSeconds()
    var bfseconds = seconds % 60
    var bfminutes = seconds / 60
    System.out.println("Seconds: " + seconds)
    totsecs = (tbseconds + tgseconds+ tcseconds + tdseconds + bdseconds + bfseconds) % 60
    totmins =  (tbminutes + tgminutes + tcminutes + tdminutes + bdminutes + bfminutes) + ((tbseconds + tgseconds + tcseconds + tdseconds + bdseconds + bfseconds) / 60)
    System.out.println("Elapsed time taxiBad: " + tbminutes +" minutes   "+ tbseconds + " seconds" )
    System.out.println("Elapsed time taxiGood: " + tgminutes +" minutes   "+ tgseconds + " seconds" )
    System.out.println("Elapsed time taxiClean: " + tcminutes + "  seconds: " + tcseconds + " seconds" )
    System.out.println("Elapsed time taxiDone: " + tdminutes + "  seconds: " + tdseconds + " seconds" )
    System.out.println("Elapsed time BoroughDurations: " + bdminutes + "  seconds: " + bdseconds + " seconds" )
    System.out.println("Elapsed time BoroughDurations.filter: " + bfminutes + "  seconds: " + bfseconds + " seconds")
    System.out.println("--------------------------------------------------------")
    System.out.println("Total: " + totmins + " minutes   "+ totsecs + " seconds" )
    System.out.println("")
    System.out.println("")
    System.out.println("")


    // -----------------------------------------------------------------------------
    System.out.println("")
    System.out.println("")
    System.out.println("")
    System.out.println("Final Checksum---------------------------------------------")
    endTime = java.time.Instant.now()
    between = java.time.Duration.between(mainstartTime, endTime)
    seconds = between.getSeconds()

    var finalSeconds = seconds % 60
    var finalMinutes = seconds / 60
    System.out.println("Final Seconds: " + seconds)
    System.out.println("Final Checksum: " + finalMinutes + "  seconds: " + finalSeconds)
    System.out.println("-------------------------------------------------------------")


  } // eom

  def point(longitude: String, latitude: String): Point = {
    new Point(longitude.toDouble, latitude.toDouble)
  }

  def parse(line: String): (String, Trip) = {
    val fields = line.split(',')
    val license = fields(1)
    val pickupTime = new DateTime(formatter.parse(fields(5)))
    val dropoffTime = new DateTime(formatter.parse(fields(6)))
    val pickupLoc = point(fields(10), fields(11))
    val dropoffLoc = point(fields(12), fields(13))

    val trip = Trip(pickupTime, dropoffTime, pickupLoc, dropoffLoc)
    (license, trip)
  }

  def safe[S, T](f: S => T): S => Either[T, (S, Exception)] = {
    new Function[S, Either[T, (S, Exception)]] with Serializable {
      def apply(s: S): Either[T, (S, Exception)] = {
        try {
          Left(f(s))
        } catch {
          case e: Exception => Right((s, e))
        }
      }
    }
  }

  def split(t1: Trip, t2: Trip): Boolean = {
    val p1 = t1.pickupTime
    val p2 = t2.pickupTime
    val d = new Duration(p1, p2)
    d.getStandardHours >= 4
  }

  def groupByKeyAndSortValues[K : Ordering : ClassTag, V : ClassTag, S : Ordering](
                                                                                    rdd: RDD[(K, V)],
                                                                                    secondaryKeyFunc: (V) => S,
                                                                                    splitFunc: (V, V) => Boolean,
                                                                                    numPartitions: Int): RDD[(K, List[V])] = {
    val presess = rdd.map {
      case (lic, trip) => {
        ((lic, secondaryKeyFunc(trip)), trip)
      }
    }
    val partitioner = new FirstKeyPartitioner[K, S](numPartitions)
    presess.repartitionAndSortWithinPartitions(partitioner).mapPartitions(groupSorted(_, splitFunc))
  }

  def groupSorted[K, V, S](
                            it: Iterator[((K, S), V)],
                            splitFunc: (V, V) => Boolean): Iterator[(K, List[V])] = {
    val res = List[(K, ArrayBuffer[V])]()
    it.foldLeft(res)((list, next) => list match {
      case Nil => {
        val ((lic, _), trip) = next
        List((lic, ArrayBuffer(trip)))
      }
      case cur :: rest => {
        val (curLic, trips) = cur
        val ((lic, _), trip) = next
        if (!lic.equals(curLic) || splitFunc(trips.last, trip)) {
          (lic, ArrayBuffer(trip)) :: list
        } else {
          trips.append(trip)
          list
        }
      }
    }).map { case (lic, buf) => (lic, buf.toList) }.iterator
  }
} // end of object

class FirstKeyPartitioner[K1, K2](partitions: Int) extends Partitioner {
  val delegate = new HashPartitioner(partitions)
  override def numPartitions = delegate.numPartitions
  override def getPartition(key: Any): Int = {
    val k = key.asInstanceOf[(K1, K2)]
    delegate.getPartition(k._1)
  }
}




/**
  **

  import java.text.SimpleDateFormat
  import java.util.Locale

  import scala.collection.mutable.ArrayBuffer
  import scala.reflect.ClassTag

  import org.apache.spark.{HashPartitioner, Partitioner, SparkConf, SparkContext}
  import org.apache.spark.SparkContext._
  import org.apache.spark.rdd.RDD
  import org.apache.spark.util.StatCounter

  import com.esri.core.geometry.Point
  import org.joda.time.{DateTime, Duration}
  import spray.json._
  import com.cloudera.datascience.geotime.GeoJsonProtocol._


  */
