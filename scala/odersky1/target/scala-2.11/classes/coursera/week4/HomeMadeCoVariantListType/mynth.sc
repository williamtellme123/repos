import coursera.week4.HomeMadeListType.{Cons, Nil}

object mynth {
  // return the nth element of List[T]
  def nth[T](n: Int, xs: List[T]): T =
      if (xs.isEmpty) throw new IndexOutOfBoundsException
      else if (n == 0) xs.head
      else nth(n-1,xs.tail)

  val list = new Cons(1, new Cons(2, new Cons(3, new Nil)))

  nth(2, list)
  nth(1, list)
  nth(0, list)
  // thes next two throw the error we specified IndexOutOfBoundsException
  // nth(4, list)
  // nth(-1,list)

  // functions can also have type paramters
  def singleton[T](elem: T) = new Cons[T](elem, new Nil[T])

  singleton[Int](1)
  singleton[Boolean](true)
  // scala can infer type
  singleton(1)
  singleton(true)
}


