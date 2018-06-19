object newtonSqRt_1 {
  // find square root of x
  // confirm session is working
  2 + 3
  def abs(x: Double) = if (x < 0) -x else x
  abs(-1.23456)
  // Newtons successive means (approximations) of sqrt x
  // 1. start with estimation y = 1
  // 2. check if estimate is good enough
  //    if abs(x - y*y) <= .00005 then y (estimate)
  // 3. else try again with new estimate
  //    y = (y + x/y)/2
  //
  // my version
  def sqrt_driver(x:Double) =
    mysqrt(0, 1, x)
  def mysqrt(last:Double, est:Double, x:Double):Double =
    if (abs(est * est - x) / x <= 0.001) est
    else mysqrt(est, (est + x / est) / 2, x)

  for (i <- 1 to 25) print("---")
  print("2                                                  ")
  sqrt_driver(2)
  for (i <- 1 to 25) print("---")
  print("4                                                  ")
  sqrt_driver(4)
  for (i <- 1 to 25) print("---")
  print("100                                                 ")
  sqrt_driver(100)
  for (i <- 1 to 25) print("---")
  print(".001                                                  ")
  sqrt_driver(.001)
  for (i <- 1 to 25) print("---")
  print("1e-6                                                  ")
  sqrt_driver(1e-6)
  for (i <- 1 to 25) print("---")
  print("1e60                                                  ")
  sqrt_driver(1e60)
  for (i <- 1 to 25) print("---")
  print("1e50                                                  ")
  sqrt_driver(1e50)
  for (i <- 1 to 25) print("---")
  // odersky's version
  def sqrt_iterator_recursive(guess: Double, x: Double): Double =
    if (isGoodEnough(guess, x)) guess
    else sqrt_iterator_recursive(improve(guess, x), x)
  def isGoodEnough(guess: Double, x: Double) =
    abs(guess * guess - x) / x < 0.001
  def improve(guess: Double, x: Double) =
    (guess + x / guess) / 2
  def sqrt(x: Double) =
    sqrt_iterator_recursive(1.0, x)
  //sqrt(2)
  //sqrt(4)
  sqrt(1e-6)
}

