import math.abs

object exercise {
  val tolerance = 0.0001

  def isCloseEnough(x: Double, y: Double) =
    abs((x - y) / x) / x < tolerance

  def fixedPoint(f: Double => Double)(firstGuess: Double) = {

    def iterate(guess: Double): Double = {
      println("Guess = " + guess)
      val next = f(guess)
      if (isCloseEnough(guess, next)) next
      else iterate(next)
    }
    iterate(firstGuess)
  }

  fixedPoint(x => 1 + x / 2)(1)

  // 1. This oscillates between 1 and 2
  def sqrt1(x: Double) = fixedPoint(y => x / y)(1)

  // sqrt1(2)
  // 2. this fixes the oscillation
  def sqrt2(x: Double) = fixedPoint(y => (x + x / y) / 2)(1)

  // sqrt2(2)
  // 3. extract this pattern out to its own fucntion
  def averageDamp(f: Double => Double)(x: Double) = (x + f(x)) / 2
  //                             run the damp on this fn y => x / y
  def sqrt3(x: Double) = fixedPoint(averageDamp(y => x / y))(1)

  sqrt3(2)

}