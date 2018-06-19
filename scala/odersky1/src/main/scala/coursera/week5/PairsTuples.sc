


object PairAndTuples {
  val xs = List(22, -1, 3, 16, 12, 7)

  // returned as pair
  val (a, b) = xs splitAt 3
  // form a pair
  val myPair = ("TheAnswerToEverything", 42)
  // decompose a pair
  val(thisLabel, thisValue) = myPair
  val thisLabel2 = myPair._1
  val thisValue2 = myPair._2
  // All Tuples(n) classes rare modeled after this pattern
  /*
    case class Tuple2[T1,T2](_1: +T1, _2: +T2) {
      override def toString = "(" + _1 + "," + _2 + ")"
    }
  */

}