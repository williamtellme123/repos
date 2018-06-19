
object ListHighOrderFun {

  // MAPPING
  val nums = List(2, -4, 6)
  val fruits = List("apples", "pineapple", "orange", "banana")
  nums filter (x => x > 0)        //
  nums filterNot (x => x > 0)     //
  nums partition (x => x > 0)     // Same as (x filter p) (x filterNot p)
                                  // not recursive : traverses lst once
  nums takeWhile (x => x > 0)     // from beginning take until fail p
  nums dropWhile (x => x > 0)     // from beginning drop until fail p
  nums span (x => x > 0)          // Same as (takeWhile p) (dropWhile p)
                                  // not recursive : traverses lst once
  val duplicates = List("a", "a", "a", "b", "c", "c", "a")
  duplicates span (y => y == duplicates.head)
  // (List(a, a, a),List(b, c, c, a))
  // packs consecutive duplicates into sublists
  def pack[T](xs: List[T]): List[List[T]] = xs match {
    case Nil      => Nil
    case x :: xs1 => {
      val (first, rest) = xs span (y => y == x)
      // span returns pair of lists
      // firstList = match
      // secondList = All the rest
      first :: pack(rest)
    }
  }
  pack(duplicates)
  // returns: List("a","a","a") List("b") List("c","c") List("a")

  // run-length encoding
  // commonly used in compression of images and other files
  // find first unique value then count how many consecutive values equal it
  // encode(duplicates) gives
  // List (("a",3),("b",1),("c",2),("a",1))
  def encode[T](xs: List[T]): List[(T, Int)] =
    // takes a list
    // returns a list of pairs [(T, Int)]  a typed value of the list and its count
    pack(xs) map (ys => (ys.head, ys.length))

  encode(duplicates)

  // REDUCTION (aka folding)
  def sum(xs: List[Int]): Int = xs match {
    case Nil => 0
    case y :: ys => y + sum(ys)
  }
  sum(nums)
  def product(xs: List[Int]): Int = xs match {
    case Nil => 1
    case y :: ys => y * product(ys)
  }
  product(nums)

  // GENERALIZE REDUCTION
  //
  // ---------------------------------------------------------------------------
  // reduceLeft
  //
  // places a given binary operator between adjacent E of List (List cannot be empty)
  // Rewrite SUM
  def sum2(xs : List[Int]) = (0::nums) reduceLeft((x,y) => x + y)
  def sum3(xs : List[Int]) = (0::nums) reduceLeft(_ + _)
  // prepend list with zero then start adding
  sum2(nums)
  sum3(nums)

  // Rewrite PRODUCT
  def product2(xs : List[Int]) = (1::nums) reduceLeft((x,y) => x * y)
  def product3(xs : List[Int]) = (1::nums) reduceLeft(_ * _)
  // prepend list with zero then start adding
  product2(nums)
  product3(nums)
  // ---------------------------------------------------------------------------
  //
  // foldLeft
  //
  // places a given binary operator between adjacent E of List (List can be empty)
  // takes another param z which is accumulator that is returned if list is empoty
  // Rewrite SUM
  def sum4(xs : List[Int]) = (xs foldLeft(0)) (_ + _)
  sum4(nums)

  // Rewrite PRODUCT
  def product4(xs : List[Int]) = (xs foldLeft 1) (_ * _)
  product4(nums)


/*
  // UTILIZE IN CLASS LIST
  abstract class List[T]{
    def reduceLeft(op: T,T) => T ) = this match {
        case Nil => throw new Error("Nil.reduceLeft")
        case x :: xs => (xs foldLeft x)(op)
    }
    def foldLeft[U](z: U)(op: (U,T) => U): U = this match {
        case Nil => z
        case x :: xs => (xs foldLeft op(z,x))(op)
    }

    def reduceRight(op: T,T) => T ) = this match {
        case Nil => throw new Error("Nil.reduceRight")
        case x :: Nil => x
        case x :: xs => op(x, xs.reduceRight(op))
    }
    def foldRight[U](z: U)(op: (T,U) => U): U = this match {
        case Nil => z
        case x :: xs => op(x, (xs foldRight z)(op))
    }
  }
*/
  // UTILIZE IN CONCAT
  def myConcat[T](xs : List[T], ys: List[T]): List[T] = (xs foldRight ys) (_ :: _)
  // def myConcat[T](xs : List[T], ys: List[T]): List[T] = (xs foldLeft ys) (_ :: _)
  // :: not a member of type paramter T
  val myList1 = List("apple","berry")
  val myList2 = List("pork","chicken")

  myConcat(myList1,myList2)


}