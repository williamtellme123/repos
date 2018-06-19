/*
    COMBINE SETS AND FOR EXPRESSIONS
    nQueens: place n queens on n x n board without checking any queen
            Odersky simplified technique
              GENERAL
              1. Place n-1 queens on next row (default: row never a conflict)
              2. for each proposed column start = 0
              3.     for each previously placed queen
                        confirm proposed row not required
                        confirm proposed column != previous column
                        confirm proposed square not on diagonal of previous
                            proposed column - previous column    !=
                            proposed row - previous row

              3. One solution nQeens(4) = List(2, 0, 3, 1)
                    Index is (rowInReverse, column)
                    List[0] : (3,2)
                    List[1] : (2,0)
                    List[2] : (1,3)
                    List[3] : (0,1)
                    ----------------------------------
                    So Soln queens(4) => recursively
                    List (1)
                    List (3,1)
                    List (0,3,1)
                    List (2,0,3,1)
                    equivalent to queens in squares  3,2   2,0   1,3   0,1

      Q: what about corners?

 */
object nQueens {

  def queens(rows: Int): Set[List[Int]] = {
    def placeQueens(next: Int): Set[List[Int]] =
      if (next == 0) Set(List())
      else
        for {
          // partial solution for (n-1)
          queens <- placeQueens(next - 1)
          // try all columns
          col <- 0 until rows
          // if col safe with previously placed queens
          if isSafe(col, queens)
        } yield col :: queens

    // take (proposed col, partial sn queens where row = queens.length)
    def isSafe(col: Int, queens: List[Int]): Boolean = {
      val row = queens.length
      // create list of existing squares
      // ((r2, c1),(r1, c2),(r0, c3)) existing squares rows 3, 2, 1
      val queensWithRow = (row - 1 to 0 by -1) zip queens
      queensWithRow forall {                            // not in check
        case (r, c) =>  col != c &&                     // columns not equal
                        math.abs(col - c)  != row - r   // not on diagonal
      }
    }
    placeQueens(rows)
  }

  def showSolution(solution: List[Int]) = {
    val lines =
      for (col <- solution.reverse)
        yield Vector.fill(solution.length)("* ").updated(col, "X ").mkString
    "\n" + (lines mkString "\n")
  }

  // lines
  // Set(List(* * X * , X * * * , * * * X , * X * * ), List(* X * * , * * * X , X * * * , * * X * ))

  //  (queens(8) take 3 map displayResult) mkString "\n"

  /*  val thisRow = 3
  val thisCol = 0
  val thisQueensPartial = List (0,3,1)
  val thisQueensPartialWithRow = (thisRow - 1 to 0 by -1) zip thisQueensPartial
  thisQueensPartialWithRow forall {
    case (r, c) => thisCol != c && math.abs(thisCol - c) != thisRow - r
  }
  var a = List(1,2,3)
  var b = List(10,20,30)
  var c = a zip b */
  (queens(4) map showSolution) mkString "\n"
  (queens(8) take 3 map showSolution) mkString "\n"
//  for (col <- List(2,0,3,1).reverse)
//    yield col
//  Vector.fill(4)("* ").updated(2,"X ").mkString
//  Vector.fill(4)("* ").updated(0,"X ").mkString
//  Vector.fill(4)("* ").updated(3,"X ").mkString
//  Vector.fill(4)("* ").updated(1,"X ").mkString
}
