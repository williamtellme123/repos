package coursera.week4.idealized.scala
// separate from normal Boolean

abstract class Boolean {
  // treated just like objects
  // create 1 abstract paramterized method
  // accepts t (then)
  // accepts e (else)
  def ifThenElse[T](t: => T, e: => T) : T
  // typical boolean expression
  //  if (condition) thenExpression
  //  else elseExpression
  // This class though would be called
  // condition.ifThenElse(thenExpression, elseExpression)

  def && (x: => Boolean) = ifThenElse(x,false)
  // accepts boolean expression (evaluated in short-circuited fashion)

  def || (x :Boolean) = ifThenElse(true,x)
  def unary_! = ifThenElse(false, true)
  def == (x :Boolean)  = ifThenElse(x, x.unary_!)
  def != (x :Boolean) = ifThenElse(x.unary_!,x)
  def < (x :Boolean) = ifThenElse(false,true)
}

object True extends Boolean {
  def ifThenElse[T](t: => T, e: => T) = t
}

object False extends Boolean {
  def ifThenElse[T](t: => T, e: => T) = e
}