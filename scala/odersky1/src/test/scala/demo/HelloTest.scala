package demo

import coursera.demo.Hello
import org.scalatest.FunSuite

/**
 * Created by billy on 10/12/15.
 */
class HelloTest extends FunSuite {
  test("sayHello method works correctly") {
    val hello = new Hello
    assert(hello.sayHello("Scala") == "Hello, Scala!")
  }
}
