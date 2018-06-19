object examples{

  def expr = {
    val x = { println("x"); 1}
    lazy val y = { print("y"); 2}
    def z = { print("z"); 3}
    z + y + x + z + y + x
    println("-----------------")
  }

  expr
  print("a")

}
