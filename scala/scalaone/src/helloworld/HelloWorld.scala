package helloworld

import scala.math.BigInt.int2bigInt



/**
 * Created by billy on 6/24/15.
 */
object HelloWorld extends App{

    override def main(args: Array[String]) {
        println("Hello World")

        // If Scala type-aware highlighting methods added via implicit conversions = grey underline
        // If Scala type-aware highlighting  is enabled then IntelliJ IDEA highlights methods that are added via implicit conversions with a grey underline:
        // If IntelliJ IDEA cannot find implicit conversion or finds more than one
        //      then the list Introduce Variable opens
        // select then ctrl-Q     alt-Enter

        // make explicit
        // imports scala.math
        val x:BigInt = math.BigInt.int2bigInt(1)

        // make explicit (import method)
        // imports scala.math.BigInt.int2bigInt
        val y: BigInt = int2bigInt(1)

        // lets you make the code easier to read
        // typical scala style : easier for writer not reader

        implicit val s : String = "text"
        implicit def foo (implicit s: String): Int = 123

        def goo(implicit i: Int) = i

        println("goo(5) --> " + goo(5))
    }
}

object ShowTypeofAction{
  val a = 123
  val ab = "Text"
  val f: Int = 1+1+1

}
