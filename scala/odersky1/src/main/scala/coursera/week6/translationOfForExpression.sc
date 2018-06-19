object examples {

  // for expressions syntatic sugar for map, flatMap, withFilter

  // for can be used for any type as long as
  // map, flatmap, withFilter are written for that type
  // arrays, iterators, XML data optional values, parsers, etc
  // or DB as long as the API defines these 3
  // see Scala database connection frameworks Slick and ScalQuery

  case class Book(title: String, authors: List[String])
  val booksL : List[Book] = List(
  Book(title    = "A Structure",
      authors  = List("Abelson","Sussman")),
    Book(title    = "B Functional Programming",
      authors     = List("Bird","Wadler")),
    Book(title    = "C Effective Java",
      authors  =  List("Bloch","Seedhom")),
    Book(title    = "D Java Puzzlers",
      authors  = List("Bloch","Teller")),
    Book(title    = "E Program in Scala",
      authors  = List("Odersky","Martin")),
    Book(title    = "F Java 2",
      authors  =  List("Bloch","Spinner"))
  )
  val booksS : Set[Book] = Set(
    Book(title    = "A Structure",
      authors  = List("Abelson","Sussman")),
    Book(title    = "B Functional Programming",
      authors     = List("Bird","Wadler")),
    Book(title    = "C Effective Java",
      authors  =  List("Bloch","Seedhom")),
    Book(title    = "D Java Puzzlers",
      authors  = List("Bloch","Teller")),
    Book(title    = "E Program in Scala",
      authors  = List("Odersky","Martin")),
    Book(title    = "F Java 2",
      authors  =  List("Bloch","Spinner"))
  )
//  // find titles by Bloch
//  for {
//    b <- booksL
//    a <- b.authors
//    if a startsWith "Bloch"
//  } yield b.title
//
//  // find titles containing Program
//  for (b <- booksL if b.title.indexOf("Program") >= 0) yield b.title
//
//  // distinct author of at least 2 books
//  for {
//    b1 <- booksL         // 1st iterator (aka generator)
//    b2 <- booksL         // 2nd iterator (aka generator)
//    if b1 != b2         // ensure different
//    a1 <- b1.authors   // range over authors
//    a2 <- b2.authors   // range over authors
//    if a1 == a2
//  } yield a1
//  println("------------")
//  // this gives us Bloch twice because he is in both generators
//  // so instead compare titles get 1
//  // distinct author of at least 3 books
//  for {
//    b1 <- booksL         // 1st iterator (aka generator)
//    b2 <- booksL         // 2nd iterator (aka generator)
//    if b1.title < b2.title         // ensure different
//    a1 <- b1.authors   // range over authors
//    a2 <- b2.authors   // range over authors
//    if a1 == a2
//  } yield a1
//  println("------------")
//  // this gives us Bloch three times because there are three combinations true
//  // so instead use distinct
//
//  // distinct author of at least 3 books
//  {
//    for {
//      b1 <- booksL // 1st iterator (aka generator)
//      b2 <- booksL // 2nd iterator (aka generator)
//      if b1 != b2 // ensure different
//      if b1.title < b2.title // ensure different
//      a1 <- b1.authors // range over authors
//      a2 <- b2.authors // range over authors
//      if a1 == a2
//    } yield a1
//  }.distinct
//  // however change the List (simulating the database to a set
//  // and the set automatically reduces dupes
//  for {
//    b1 <- booksS // 1st iterator (aka generator)
//    b2 <- booksS // 2nd iterator (aka generator)
//    if b1.title < b2.title // ensure different
//    a1 <- b1.authors // range over authors
//    a2 <- b2.authors // range over authors
//    if a1 == a2
//  } yield a1
//  for {
//    b <- booksL
//    a <- b.authors
//    if a startsWith "Bloch"
//  } yield b.title
//
//
//  // rewrite without for loop
//  for {
//    b <- booksL
//    a <- b.authors
//    if a startsWith "Bloch"
//  } yield b.title
//

  // TRANSLATE FOR INTO HIGHER ORDER FUNCTIONS (no for expr)
  // find titles by Bloch
  println("0 ---------------")
  for (b <- booksL; a <- b.authors if a startsWith "Bloch") yield b.title
  // STEP 1
  // original has 2 leading generators so use flatMap
  // function takes the value (b) from the left of the generator
  // followed by a for expr that contains the rest
  println("1 ---------------")
  booksL flatMap (b =>
    for (a <- b.authors if a startsWith "Bloch") yield b.title)
  // STEP 2 now translate 2nd for expr
  // has a generator followed by a filter so pull filter into generator
  println("2 ---------------")
  booksL flatMap (b =>
      for (a <- b.authors withFilter (a => a startsWith "Bloch")) yield b.title)
  // STEP 3 now translate 3rd for expr
  // has a single generator so translates to a map
  println("3 ---------------")
  booksL flatMap (b =>
          b.authors withFilter (a => a startsWith "Bloch") map (y => b.title))

  // Flatmap followed by a map of a generator that contains a filter
  // --------------------------------------------------------------------------------------------
  // OTHER EXAMPLES
  //  val l = List(1,2,3)
  //  l.map(x => x * 2)
  //
  //  def g(v: Int) = List (v-1, v, v+1)
  //  l.map(x => g(x))
  //
  //  l.flatMap(x => g(x))
  //
  //  g(2)

  //  val fruits = Seq("apple","berry","cherry")
  //  fruits.map(_.toUpperCase)
  //
  //  val mapResult = fruits.map(_.toUpperCase)
  //  val flattenResult = mapResult.flatten
  //
  //  fruits.flatMap(_.toUpperCase)
  //
  //  for {
  //    b <- books
  //    a <- b.authors
  //    if a startsWith "Bloch"
  //  } yield b.title
  //
  //
  //  books flatMap(b => for (a <- b.authors if a startsWith "Bloch") yield b.title )

  //  def isPrime(n: Int): Boolean =
  //    (2 until n) forall (n % _ != 0)
  //  val n = 3
  //
  //  for {
  //    i <- 1 until n
  //    j <- 1 until i
  //    if isPrime(i+j)
  //  } yield (i,j)
  //
  //  (1 until n) flatMap(i =>
  //    (1 until i) withFilter(j =>
  //      isPrime(i+j))
  //        map(j => (i,j)))
  //
  //  (1 until n).flatMap(i =>
  //    (1 until i).withFilter(j =>
  //      isPrime(i+j)).map(j => (i,j)))

  // 1. MAP            map [B](f : (A) => B) : List[B]
  // applies function to each element
  // var a = List(1,2,3)
  // a map { num => "I like to count: "+num }
  //        Here map Int to String
  //        takes list of Ints returns list of Strings

  // 2. FLATMAP        flatMap [B](f : (A) => Iterable[B]) : List[B]
  //    takes function of type A and returns Iterable[B]
  // booksL flatMap (b =>

  //  for ( x <- expr1;
  //        y <- expr2;
  //        seq
  //      ) yield expr3
  //
  //  expr1.flatMap(x => for (y <- expr2; seq)
  //      yield expr3)

}