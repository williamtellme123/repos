object scope {

  def fact0(x: Int): Int = if (x == 1) 1 else x * fact0(x - 1)

  def sumOfAny(f: Int => Int): (Int, Int) => Int = {
    def sumF(a: Int, b: Int): Int =
      if (a > b) 0
      else f(a) + sumF(a + 1, b)
    sumF
  }

  def newSumCubes = sumOfAny(x => x * x * x)

  newSumCubes(2, 3)
  // transforms evaluation of a Fn which takes a tuple of arguments
  // into series of evaluations of single arguments
  val mySum: (Int, Int) => Int = _ + _
  mySum(2, 3)

  // val sumCurried: Int => Int => Int = mySum.curried

  def add(x: Int) = (y: Int) => x + y

  add(2)(3)

  // Currying tx fn requires 2 args
  // into new fn object constructor
  //      a. that requires only 1 arg
  //      b. returns a function which requires second
  //      c. allows chain of fns

  /* EXERCISE
        1. Write product fn
            i.  That calculates product of values of a fn
            ii  For points on on given interval
        2. Write myFact using myProduct
        3. Find fn that generalize both sum and product Parameters
             i.   type of mapping f: Int => Int (original function)
             i.   bounds x, y (original parameters)
            11.   unit (terminating value) 0 for add 1 for mult
            iii.  need operator (combining function)

            NOTE: this is version of Map Reduce
                map values in the interval to new values
                    then reducing would combine them
  */

  // 1. -----------------------------------------------------------------
  def prodOfAny(f: Int => Int): (Int, Int) => Int = {
    def mult(a: Int, b: Int): Int =
      if (a > b) 1
      else f(a) * mult(a + 1, b)
    mult
  }

  // 2. -----------------------------------------------------------------
  def newProduct = prodOfAny(x => x * x)
  newProduct(3, 4)
  def fact1(x: Int): Int = prodOfAny(x => x)(1, x)
  fact1(5)

  //def fact2(x: Int): Int = factProduct(1,x)
  def factProduct = prodOfAny(x => x)
  def myFact(x: Int): Int = factProduct(1, x)
  myFact(5)


  // 3. -----------------------------------------------------------------
  // these use mapReduce shown below.
  // this is for multiplication
  def prodOfAnyUsingMR(f: Int => Int)(a: Int, b: Int): Int = mapReduce(f, (x, y) => x * y, 1)(a: Int, b: Int)
  prodOfAnyUsingMR(x => x * x)(3, 4)
  // 9 * 16 = 144

  // this is for addition
  def sumOfAnyUsingMR(f: Int => Int)(a: Int, b: Int): Int = mapReduce(f, (x, y) => x + y, 0)(a: Int, b: Int)
  sumOfAnyUsingMR(x => x * x)(1, 4)
  // 9 + 16 = 25

  // one version of mapReduce (mapping, bounds, unit value and combine)
  // function f would map would map values in the interval to new values
  // reduce would combine them

  //            org fn         mult or sum                 unit value
  def mapReduce(f: Int => Int, combine: (Int, Int) => Int, zero: Int)(a: Int, b: Int): Int =
    if (a > b) zero
    else combine(f(a), mapReduce(f, combine, zero)(a + 1, b))

  




}