// BLOCK 4 ------------------------------------------
val xs = List(21, -1, 3, 16, 12, 7)
val (a,b) = xs splitAt 3




// BLOCK 3 ------------------------------------------
//val xs = List(1,3,5,7)
//val ys = List (2,4,6,8)
//// prepends xs onto ys
//xs ::: ys          // concat ys to xs
//// prepends xs to reciever ys.
//ys. ::: (xs)    //
//// up until now we have created Fns on one list so that
//// was used in match and we constructed lists from left to right
////
//// Now we have two lists first element of result set is xs so match on that
//def concat[T](xs:List[T],ys:List[T]): List [T] = xs match {
//  case List()  => ys
//  case z :: zs => z :: concat(zs,ys)
//}
//// Need a call for each elem of left list so
//// complexity is length of xs or |xs|
//
//def reverse[T](xs:List[T]): List [T] = xs match {
//  case List()  => xs
//  case y :: ys => reverse(ys) ++ List(y)
//}
//// complexity:
////      ++ (concat) is linear grows as xs grows n-1
////      reverse is n
//// total is n * n :: quadratic so not good
//
//def removeAt[T](n: Int, xs: List[T]) = {
//  // remove nth element of xs (or if outOfBounds return xs)
//  // usage removeAt(1, List('a', 'b', 'c', 'd'))  // List(a, c, d)
//  (xs take n) ::: (xs drop n + 1)
//}
//ys
//removeAt(2,ys)
//def flatten(xs: List[Any]): List[Any] = xs match {
//  case Nil => Nil
//  case (head: List[_]) :: tail => flatten(head) ::: flatten(tail)
//  case head :: tail => head :: flatten(tail)
//}
//flatten(List(List(1, 1), 2, List(3, List(5, 8))))
//
//// call flatten(List(List(1, 1), 2, List(3, List(5, 8))))
//// gives List(1, 1, 2, 3, 5, 8)




// BLOCK 1 ------------------------------------------
//val xs = List (9,3,5,11,7,1)
//def insert (x: Int, xs: List[Int]): List[Int] = xs match {
//  case List() => List(x)
//  case y :: ys  => if (x <= y) x :: xs
//                   else y :: insert(x, ys)
//} // proportional to n
//def isort(xs: List[Int]): List[Int] = xs match {
//  case List() => List()
//  case y :: ys  => insert(y, isort(ys))
//} // proportional to n
//// isort(a) // Proportional to n * n
// BLOCK 2 ------------------------------------------
//val xs = List(1,3,5,7); val ys = List (2,4,6,8)
//xs.length           // length
//xs.last             // last element
//xs.init             // all but last
//xs take 2           // return first 2
//xs drop 2           // drop first 2
//xs(3)               // return index(3)
//xs ++ ys            // concat (1,3,5,7,2,4,6,8)
//xs.reverse          //
//xs.updated(2,100)   // replace index 2 with 100
//xs indexOf 7        //
//xs contains 7       //
// xs ::: ys          // concat
// ys. ::: (xs)       //

//def last[T](xs: List[T]): T = xs match {
//  case List() => throw new Error("last of empty list")
//  case List(x) => x
//  case y :: ys => last(ys)
//} // takes steps proportional to legnth of xs
//last(xs)
//def init[T](xs: List[T]): List[T] = xs match{
//  case List()  => throw new Error("init of empty list")
//  case List(x) => List()
//  case y :: ys => y :: init(ys)
//}
//init(xs)
