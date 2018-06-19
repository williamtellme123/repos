object exercise {




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

  def + (r: Rational) =                       // add
    new Rational(numerator * r.denominator + r.numerator * denominator, denominator * r.denominator)
  def -(r: Rational) = this + -r              // reuse
  def < (r: Rational) =                       // less
    this.numerator * r.denominator < r.numerator * this.denominator
  def unary_- : Rational = new Rational(-numerator, denominator)   // neg

  def * (r: Rational) =
    new Rational(numerator * r.denominator, denominator * r.denominator)
  def max (r: Rational) = if (this < r) r else this

  override def toString = numerator + "/" + denominator
}