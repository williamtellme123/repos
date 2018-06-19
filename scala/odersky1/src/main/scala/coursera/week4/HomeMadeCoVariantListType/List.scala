package coursera.week4.HomeMadeCoVariantListType

import java.util.NoSuchElementException

trait List[+T] {
  // is it the cons cell or empty
  def isEmpty: Boolean
  def head: T
  def tail: List [T]
  // ------------------------------- COVARAIANCE TRY 1
  // Try this: prepend
  // def prepend1(elem: T): List[T] = new Cons(elem,this)
  // Covaraiant type T occurs in contravariant position in type T of elem
  // remember covariant T can not be used as method parameter
  // designed to prevent mutation methods in covaraiant classes

  // however this is not mutation, so why fail?
  // However it violates Liskov Substitution Principle
  /*
        THIS WILL WORK BCZ Empty is subset of IntSet
        val xs: List[IntSet]
        xs.prepend(Empty)

        NOT WORK BCZ Empty is NOT subset of NonEmpty therefore type mismatch
        val ys: List[NonEmpty]
        xs.prepend(Empty)

        THEREFORE
        List[NonEmpty] is NOT <:  List[IntSet]
  */
  // ------------------------------- COVARAIANCE TRY 2
  // Try again
  // Use lower bound on parameter U
  // this method is typed to accept only superclass of T
  // elem is now that given type U (which is acceptable)
  def prepend2 [U >: T] (elem: U): List[U] = new Cons(elem,this)
  // // ------------------------------- COVARAIANCE RULES
  // Covariant parameters OK in lower bounds of method
  // Contravaraiant parameters OK in upper bound of method


}

class Cons[T](val head: T, val tail : List[T]) extends List[T] {
  // the parameters here (head, tail) are legal implementations of base trait
  // special case of methods which override abstract methods and traits
  // val vs. def
  //    val is evaluated when initialized
  //    def is evaluated each time it is referenced
  // however we will refine below

  // is it the cons cell or empty
  // the cons list is never empty
  override def isEmpty: Boolean = false
}

// class Nil[T] extends List[T]{
// change class to object
// remove Nil[T] change List[T] = List[Nothing]
// Nothing is subtype of all types
object Nil extends List[Nothing]{
  def isEmpty = true
  def head: Nothing = throw new NoSuchElementException("Nill.Head")
  def tail: Nothing = throw new NoSuchElementException("Nill.Tail")
}


// To test prepend lets bring in list types
abstract class IntSet {
  // incl means add to the tree
  def incl(x: Int): IntSet
  def contains(x: Int): Boolean
  def union(other: IntSet): IntSet
}
class Empty extends IntSet {
  // means singleton
  // class Empty extends IntSet {
  def contains(x: Int): Boolean = false
  // def incl(x: Int): IntSet = new NonEmpty(x, new Empty, new Empty)
  def incl(x: Int): IntSet = new NonEmpty(x, new Empty, new Empty)
  override def toString = "."
  def union(other: IntSet): IntSet = other
}
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
object Test {
  // Expression of type Nil does not confirm to expected type List[String]
  // val x: List[String] = Nil
  // therefore trait List[T] should be covaraiant trait List[+T]
  val x1: List[String] = Nil
  // Now it works
  //    Nil is a list[Nothing]
  //    Nothing is subtype of String
  //    List is CoVariant
  val x2: List[NonEmpty] = Nil
  println("------------------------")

  // Test new prepend
  val listNotEmpty: List[NonEmpty] = Nil
  var listEmpty = new Empty

  def f(xs: List[NonEmpty], x: Empty) = xs.prepend2(x)

  // Add type annotation to function results in this
  def myF(xs: List[NonEmpty], x: Empty): List[IntSet] = xs.prepend2(x)

  val a: List[IntSet] = myF(listNotEmpty,listEmpty)

}



//object List {
//  // want to be able to List()  create empty list
//  def apply[T]() : List[T] =
//    new Nil
//
//  // want to be able to List(1)  create single element list
//  def apply[T](x: T) : List[T] =
//    new Cons(x, new Nil)
//
//  // want to be able to List(1,2) create 2 element list
//  // meaning List.apply(1,2)
//  def apply[T](x1: T, x2: T) : List[T] =
//    new Cons(x1, new Cons(x2, new Nil))
//
//}