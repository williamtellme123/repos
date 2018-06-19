package demo

import java.util.NoSuchElementException

trait List[T] {
  // is it the cons cell or empty
  def isEmpty: Boolean
  def head: T
  def tail: List [T]
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

class Nil[T] extends List[T]{
  def isEmpty = true
  def head: Nothing = throw new NoSuchElementException("Nill.Head")
  def tail: Nothing = throw new NoSuchElementException("Nill.Tail")
}

object List {

  // want to be able to List()  create empty list
  def apply[T]() : List[T] =
    new Nil

  // want to be able to List(1)  create single element list
  def apply[T](x: T) : List[T] =
    new Cons(x, new Nil)

  // want to be able to List(1,2) create 2 element list
  // meaning List.apply(1,2)
  def apply[T](x1: T, x2: T) : List[T] =
    new Cons(x1, new Cons(x2, new Nil))

}