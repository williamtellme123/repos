object scope {

  def sqrt(x: Double) = {
    // x is in scope 
    def abs(x: Double) = if (x < 0) -x else x

    def sqrt_iterator_recursive(guess: Double): Double =
      if (isGoodEnough(guess)) guess
      else sqrt_iterator_recursive(improve(guess))

    def isGoodEnough(guess: Double) =
      abs(guess * guess - x) / x < 0.001

    def improve(guess: Double) =
      (guess + x / guess) / 2

    sqrt_iterator_recursive(1.0)
  }

  sqrt(4)

}

