Object Scope {
  val x = new Rational(1, 3)
  val y = new Rational(5, 7)
  val z = new Rational(3, 2)
  x.sub(y).sub(z)
  x.add(y)
  x.sub(y)
  x.add(y).mul(z)

  // assert(new Rational(3,0) == "denominator must be zero")  // check code of function itself
}

class Rational(x: Int, y: Int) {
  require(y != 0 , "denominator must be zero") // built in enforce precondition

  // a second constructor
  def this(x: Int) = this(x,1)

  private def gcd(a: Int,b: Int): Int = {
    if(b == 0) a else gcd(b, a % b)
  }
  private val g = gcd(x,y)
  def numerator = x / g
  def denominator = y / g

  def add(thisR: Rational) =
    new Rational(numerator * thisR.denominator + thisR.numerator * denominator, denominator * thisR.denominator)

  //  do not repeat
  //  def sub(thisR: Rational) =
  //    new Rational(numerator * thisR.denominator - thisR.numerator * denominator, denominator * thisR.denominator)
  //
  // reuse
  def sub(thisR: Rational) = add(thisR.neg)

  def mul(thisR: Rational) =
    new Rational(numerator * thisR.denominator, denominator * thisR.denominator)

  def neg: Rational = new Rational(-numerator, denominator)

  override def toString = numerator + "/" + denominator
}


