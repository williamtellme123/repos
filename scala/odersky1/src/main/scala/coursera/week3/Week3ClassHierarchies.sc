

abstract class IntSet {
  // incl means add to the tree
  def incl(x: Int): IntSet

  def contains(x: Int): Boolean

  def union(other: IntSet): IntSet
}

object Empty extends IntSet {
  // means singleton
  // class Empty extends IntSet {
  def contains(x: Int): Boolean = false

  // def incl(x: Int): IntSet = new NonEmpty(x, new Empty, new Empty)
  def incl(x: Int): IntSet = new NonEmpty(x, Empty, Empty)

  override def toString = "."

  def union(other: IntSet): IntSet = other
}

// If using new the call can be anywhere is worksheet
// If singleton then must be created first so reference must follow
// here: NonEmpty is below
// here: Empty must be above

// test just the include (add node)
val t1 = new NonEmpty(3, Empty, Empty)
val t2 = t1 incl 4

// test the union
val m1 = new NonEmpty(5, Empty, Empty)
val m2 = new NonEmpty(12, Empty, Empty)
m1.union(m2)

class NonEmpty(elem: Int, left: IntSet, right: IntSet) extends IntSet {

  def contains(x: Int): Boolean =
    if (x < elem) left contains x
    else if (x > elem) right contains x
    else true

  def incl(x: Int): IntSet =
    if (x < elem) new NonEmpty(elem, left incl x, right)
    else if (x > elem) new NonEmpty(elem, left, right incl x)
    else this

  override def toString = "{" + left + elem + right + "}"

  def union(other: IntSet): IntSet =
  // What about termination step
  // every call to union is on something smaller then set we started with
  ((left union right) union other) incl elem
}

// -----------------------------------------------------------
abstract class Base {
  def foo = 1

  def bar: Int
}

class Sub extends Base {
  override def foo = 2

  def bar = 3
}

// -----------------------------------------------------------
