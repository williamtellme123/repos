object newtonSqRt_2 {

  def sqrt(x: Double) = {
    def abs(x: Double) = if (x < 0) -x else x

    def sqrt_iterator_recursive(guess: Double, x: Double): Double =
      if (isGoodEnough(guess, x)) guess
      else sqrt_iterator_recursive(improve(guess, x), x)

    def isGoodEnough(guess: Double, x: Double) =
      abs(guess * guess - x) / x < 0.001

    def improve(guess: Double, x: Double) =
      (guess + x / guess) / 2

    sqrt_iterator_recursive(1.0, x)
  }

  //sqrt(2)
  //sqrt(4)
  sqrt(4)
}