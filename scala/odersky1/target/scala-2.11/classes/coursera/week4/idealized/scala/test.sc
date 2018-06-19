import coursera.week4.idealized.scala._
object test{
  println("Hello")
  True.ifThenElse(println("True is true"), println("no"))
  False.ifThenElse(println("yes"), println("False is not true ever !"))
  True.unary_!
  False.unary_!
  println("123")
  //(True || False).ifThenElse(println("yes"), println("no"))
  println("-----------")
  False.ifThenElse(println("yes"), println("no"))
  //(True || False).ifThenElse(println("yes"), println("no"))
  //(True && True == True).ifThenElse(println("yes"), println("no"))
  //(False || True != True).ifThenElse(println("yes"), println("no"))
}