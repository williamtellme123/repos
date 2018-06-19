object Examples {

  /*
  COMBINATORIAL SEARCH AND FOR EXPRESSIONS

  Higher order functions replace nested loops in imperative lang

  until => generates range
  map => results
  flatten => collection of collections into 1 collection
  flatmap => applies collection fn each element combines results
  filter => applies boolean fn to collection returns results

  for (s) yield e => sequence of generators & filters yield collection e
    s = generators (p <- e) pattern <- collection
        filters (boolean expr)

  for {s) yield e  => allow n lines without ;  */

  // --------------------------------------------------------------------
  // UNTIL & MAP
  (1 until 5) map (i => i * 10)
        // Vector(10,20,30,40)
  val n = 7
  (1 until n) map (i =>
    (1 until i) map (j => (i, j)))
        /* scala.collection.immutable.IndexedSeq[(Int, Int)] =
            Vector(
              Vector(),
              Vector((2,1)),
              Vector((3,1), (3,2)),
              Vector((4,1), (4,2), (4,3)),
              Vector((5,1), (5,2), (5,3), (5,4)),
              Vector((6,1), (6,2), (6,3), (6,4), (6,5)))

              because indexed sequence between range and iterable
              whose canonical implimentation is vector  */
  // --------------------------------------------------------------------
  // FLATTEN : collection of collections into 1 collection
  ((1 until n) map (i =>
    (1 until i) map (j => (i, j)))).flatten
  // Vector( (2,1), (3,1), (3,2), (4,1), (4,2), (4,3), (5,1), (5,2),
  //          (5,3), (5,4), (6,1),(6,2), (6,3), (6,4), (6,5))
  // --------------------------------------------------------------------
  // FLATMAP : Useful law
  // replace map followed by flatten with flatMap
  ((1 until n) flatMap (i =>
    (1 until i) map (j => (i, j))))


  // --------------------------------------------------------------------
  // FILTER
  def isPrime(n: Int): Boolean =
    (2 until n) forall (n % _ != 0)

  ((1 until n) flatMap (i =>
      (1 until i) map (j => (i, j)))) filter (pair =>
                                      isPrime(pair._1 + pair._2))
  // Hard to read
  // --------------------------------------------------------------------
  // FOR EXPRESSION
  case class Person(name: String, age: Int)

  val persons = List(Person("joe",21),Person("jane",22))
  for (p <- persons if p.age > 20) yield p.name // same as
  persons filter (p => p.age > 20) map (p => p.name)
  // for (s sequence of genrators and filters) yield e expression returned by iteration
  // generator p <- e
  // p = pattern      e is collection
  // filter   if f    f is boolean expr

  for {
    i <- 1 until n
    j <- 1 until i
    if isPrime(i + j)
  } yield (i,j)

  // Redfine scalarProduct using for expression
  def scalarProduct(xs: List[Double], ys: List[Double]): Double =
    (for ((x, y) <- xs zip ys) yield x * y).sum
  val a = List (1.0,2.0,3.0)
  val b = List (10.0,20.0,30.0)
  scalarProduct(a,b)

}

