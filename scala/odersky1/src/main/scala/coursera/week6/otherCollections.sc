

object sequeneceOperations {
  // SEQUENCE OPs
  //  str exists p
  //  str forall p
  //  xs zip ys
  //  xs.unzip
  //  xs.flatmap f
  //  xs.sum
  //  xs.product
  //  xs.max
  //  xs.min
  // --------------------------------------------------
  // ARRAYS AND STRINGS
  // you can leave off type
  // val xs:Array[Int] = Array(1, 2, 3, 44)
  val xs = Array(1, 2, 3, 44)
  xs map (x => x * 2)

  // val s:Array[String] = "Hello World"
  val str = "Hello World"
  str filter (c => c.isUpper)
  // DO NOT USE s AS VARAIBLE NAME
  // --------------------------------------------------
  // RANGE
  var myR: Range = 1 until 5
  var myS: Range = 1 to 5
  1 to 10 by 3
  6 to 1 by -2
  // -----------------------------------
  //  str exists p
  //  str forall p
  str exists (c => c.isUpper)   // returns true
  str forall (c => c.isUpper)   // returns false
  // -----------------------------------
  //  xs zip ys
  //  xs.unzip
  // Zip:  two lists zip into pairs
  val pairs = List(1,2,3) zip myS
  pairs unzip
  // -----------------------------------
  //  xs.flatmap f
  //    1. apply f to every char
  //    2. concat all results
  val str2 = "Hello World"
  str2 flatMap (c => List('.', c))
  //   .H.e.l.l.o. .W.o.r.l.d
  // -----------------------------------
  //  xs.sum
  //  xs.product
  //  xs.max
  //  xs.min
  myR.sum
  myR.max
  myR.product

  // -----------------------------------
  // EXAMPLE forall         Combinations
  // list all combinations of numbers x and y
  // x comes from 1..M
  // y comes from 1..N
  val M = 3
  val N = 5
  (1 to M) flatMap (x => (1 to N) map (y => (x,y)))


  // -----------------------------------
  // EXAMPLE forall               isPrime
  def isPrime(n: Int): Boolean =
    (2 until n) forall (n % _ != 0)

  def isPrime2(n: Int): Boolean =
    (2 until n) forall (d => n % d != 0)

  isPrime(7)
  isPrime(10)
  isPrime(73)
  isPrime(45)

  // -----------------------------------
  // EXAMPLE filter, map, flatmap
  def primeSumOfPairs(n: Int) =
    (1 until n) flatMap (i =>
      (1 until i) map (j => (i, j))) filter
      (pair => isPrime(pair._1 + pair._2))

  primeSumOfPairs(3)

  // -----------------------------------
  // EXAMPLE for, zip, yield
  def scalarProduct(xs: List[Double], ys: List[Double]): Double =
    (for((x,y) <- xs zip ys) yield x * y).sum
  var myL1 = List(1.0,3.0,5.0)
  var myL2 = List(2.0,4.0,6.0)
  scalarProduct(myL1,myL2)


  def scalarProductMO(xs: Vector[Double], ys: Vector[Double]): Double =
    (xs zip ys).map(xy=>xy._1 * xy._2 ).sum
  var myV1 = Vector(1.0,3.0,5.0)
  var myV2 = Vector(2.0,4.0,6.0)
  scalarProductMO(myV1,myV2)

  def scalarProductMO2(xs: Vector[Double], ys: Vector[Double]): Double =
    (xs zip ys).map{ case (x,y) => x * y}.sum
  scalarProductMO2(myV1,myV2)
}

