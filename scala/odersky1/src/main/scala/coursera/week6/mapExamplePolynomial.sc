/*  MAP EXAMPLE  polynomial
    Exponents map to Coefficients

    x^3 - 2x + 5
    Map(0 -> 5, 1 -> -2, 3 -> 1)
    need functions
      +
      toString
 */

object polynomials {

  class Poly(terms0: Map[Int, Double]) {

    // all polynominals now have default value
    val terms = terms0 withDefaultValue 0.0

    // auxilliary constructor (arbitrary # parameters)
    def this(bindings: (Int, Double)*) =
      this(bindings.toMap)

    // add like terms
    def adjust(term: (Int, Double)): (Int, Double) = {
      val (exp, coeff) = term
      exp -> (coeff + terms(exp))  // add coefficients of 2nd map to 1st map
    }

    def inefficientAdd (other: Poly) =
      new Poly(terms ++ (other.terms map adjust))


    //  def + (other: Poly) =
    //      new Poly(terms ++ (other.terms map adjust))
    //  rewrite + with foldLeft
    def + (other: Poly) =
      new Poly((other.terms foldLeft terms)(addTerm))

    def addTerm(terms: Map[Int, Double], term: (Int, Double)): Map[Int, Double] = {
      val (exp, coeff) = term
      terms + (exp -> (coeff + terms(exp)))
    }

    override def toString =
      (for ((exp, coeff) <- terms.toList.sorted.reverse)
        yield (exp match {
          case 0 => coeff
          case 1 => coeff + "x"
          case _ => coeff + "x^" + exp
        })) mkString " + "
  }


  // p1 = 6.2^5 + 4.0x^3 - 2.0x
  // p2 = 7.0x^3 + 3.0x

  val p1 = new Poly(Map(1 -> 2.0, 3 -> 4.0, 5 -> 6.2))

  // Varying # parameters (use repeated parameters) with auxilliary constructor
  val p2 = new Poly(0 -> 3.0, 3 -> 7.0)

  p1 + p2
  p1.terms(1)
  p1.terms(2)
}