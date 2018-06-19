//import math.Ordering

object Merge {
  // MERGE SORT
  // separate the list into 2 shorter (~half) lists
  // sort each half-list by itself
  // merge them into one
  def msort1[T](xs: List[Int]) : List[Int] = {
    val n = xs.length / 2
    if (n == 0) xs
    else {
      def merge1(xs: List[Int], ys: List[Int]): List[Int] =
        xs match {
          case Nil => ys
          case x :: xs1 =>
            ys match {
              case Nil => xs
              case y :: ys1 =>
                if (x < y) x :: merge1(xs1, ys)
                else y :: merge1(xs, ys1)
            }
        }
      val (fst, snd) = xs splitAt n
      merge1(msort1(fst), msort1(snd))
    }
  }
  val nums1 = List(2, -4, 5, 7, 1)
  msort1(nums1)

  def msort2(xs: List[Int]): List[Int] = {
    val n = xs.length / 2
    if (n == 0) xs
    else {
      def merge2(xs: List[Int], ys: List[Int]): List[Int] = (xs, ys) match {
        case (Nil, ys) => ys
        case (xs, Nil) => xs
        case (x :: xs1, y :: ys1) =>
          if (x < y) x :: merge2(xs1, ys)
          else y :: merge2(xs, ys1)
      }
      val (fst, snd) = xs splitAt n
      merge2(msort2(fst), msort2(snd))
    }

    val nums2 = List(2, -4, 5, 7, 1)
    msort2(nums2)
  }

  def msort3[T](xs: List[T])(implicit ord: Ordering[T]): List[T] = {
    val n = xs.length / 2
    if (n == 0) xs
    else {

      def merge3(xs: List[T], ys: List[T]): List[T] = (xs, ys) match {
        case (Nil, ys) => ys
        case (xs, Nil) => xs
        case (x :: xs1, y :: ys1) =>
          if (ord.lt(x, y)) x :: merge3(xs1, ys)
          else y :: merge3(xs, ys1)
      }

      val (fst, snd) = xs splitAt n
      merge3(msort3(fst), msort3(snd))
    }
  }

  val nums3 = List(2, -4, 5, 7, 1)
  val fruits3 = List("apples", "pineapple", "orange", "banana")

  msort3(nums3)
  msort3(fruits3)


}

