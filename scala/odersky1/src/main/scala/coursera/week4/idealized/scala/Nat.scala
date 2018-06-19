

abstract class Nat {
  def isZero: Boolean
  def predecessor : Nat
  // successor same for zero and all postive numbers
  def successor = new Succ(this)

  def + (that: Nat): Nat
  def - (that: Nat): Nat
}

// This is for the number zero
object Zero extends Nat {
  def isZero = true
  def predecessor = throw new Error("Zero has no predecessor")
  def + (that: Nat) = that
  def - (that: Nat) = if (that.isZero) this else throw new Error("Answers can have no negative numbers")
}

// this is for strictly positive numbers
class Succ(n: Nat) extends Nat{
  def isZero = false
  def predecessor = n
  def + (that: Nat): Nat = new Succ(n + that)
  def - (that: Nat) = if (that.isZero) this else n - that.predecessor
}