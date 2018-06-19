
object scope {

  def square(x: Int): Int = x * x

  def cube(x: Int): Int = x * x * x

  def fact(x: Int): Int = if (x == 1) 1 else x * fact(x - 1)

  def sumAGivenFnTwice(f: Int => Int): (Int, Int) => Int = {

    def sumFn(a: Int, b: Int): Int = {
      if (a > b) 0
      else f(a) + sumFn(a + 1, b)
    }
    sumFn
  }

  def sumSquares = sumAGivenFnTwice(x => x * x)
  def sumCubes = sumAGivenFnTwice(x => x * x * x)
  def sumFacts = sumAGivenFnTwice(fact)

  sumSquares(3, 4) // 25
  sumCubes(2, 3) // 35
  sumFacts(3, 4) // 30

  sumAGivenFnTwice (square)(3,4)
  sumAGivenFnTwice (cube)(2,3)
  sumAGivenFnTwice (square)(3,4)
}