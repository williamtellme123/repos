object scope {

  def square(x:Int): Int =
    x * x

  def cube(x:Int): Int =
    x * x * x

  def myfact(a:Int): Int = {
    def loop(a: Int, next:Int, acc:Int): Int = {
      if (next > a) acc
      else loop(a, next+1, next*acc)
    }
    loop(a,1,1)
  }

  def fact(x:Int):Int = if (x==1) 1 else x * fact(x - 1)

  def sumOfAnyFn(f:Int => Int, a :Int, b: Int): Int = {
    def loop(a: Int, acc: Int): Int = {
      if (a>b) acc
      else f(a) + loop(a+1, acc)
    }

    loop(a,0)

  }
  myfact(4)
  fact(4)
  sumOfAnyFn(square, 1,3)
  sumOfAnyFn(x => x * x, 3, 5)
  sumOfAnyFn(cube, 1,3)
  sumOfAnyFn(x => x * x * x, 3, 5)
  sumOfAnyFn(myfact, 2,3)
  sumOfAnyFn(fact, 3, 4)
}



