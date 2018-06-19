package coursera.week4.idealized.scala

abstract class Int {
  def + (that: Double): Double      // 1 + 2.1
  def + (that: Float): Float
  def + (that: Long): Long
  def + (that: Int): Int           // same for -, *, /, %

  // left shift operation
  def << (shiftCount: Int): Int   // same for >>, >>>  */

  // bitwise & operations
  def & (that: Long): Long
  def & (that: Int): Int // same for |, ^ */


  def == (that: Double): Boolean
  def == (that: Float): Boolean
  def == (that: Long): Boolean

}