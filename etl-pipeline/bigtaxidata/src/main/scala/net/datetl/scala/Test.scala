package net.datetl.scala



object Test {

  def main(args: Array[String]): Unit = {

    val list = List(1,2,3,4,5)
    def g(v:Int) = List(v-1, v, v+1)

    list.map(x => g(x))

    list.flatMap(x => g(x))

  }
}
