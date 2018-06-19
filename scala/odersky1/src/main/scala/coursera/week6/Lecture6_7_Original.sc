import scala.io.Source

object x {

  val in = Source.fromURL("http://lamp.epfl.ch/files/content/sites/lamp/files/teaching/progfun/linuxwords.txt").getLines

  // convert iterator.toList
  // drop hyphenated words from dictionary
  val words = in.toList filter (_ forall (_.isLetter))

  val mnem = Map(
    '2' -> "ABC", '3' -> "DEF", '4' -> "GHI", '5' -> "JKL",
    '6' -> "MNO", '7' -> "PQRS", '8' -> "TUV", '9' -> "WXYZ")

  // 'A' -> '2'  etc
  val charCode: Map[Char, Char] =
    for ((digit, str) <- mnem; ltr <- str) yield (ltr -> digit)

  // "Java" -> "5282"
  def wordCode(word: String): String =
  // apply same op on every character :: use map as a function of a map method
    word.toUpperCase map charCode

  wordCode("scalaisfun")
  wordCode("JAVA")

  // convert dictionary to
  // Map(63972278 -> List(newscast), 29237638427 -> List(cybernetics), 782754448 -> List(starlight), ...
  // 5282 -> List("Java", "Kata", "Lava", ...)
  val wordsForNum: Map[String, Seq[String]] =
  // since 7 is not associated with a word
  // pass default value to prevent exception
    words groupBy wordCode withDefaultValue List()


  // 5282 ->
  def encode(number: String): Set[List[String]] = {
    if (number.isEmpty) Set(List())
    else {
      for {
      // determine length of number
        split <- 1 to number.length
        first <- wordsForNum(number take split)
        rest <- encode(number drop split)
      } yield first :: rest
    }.toSet
  }

  encode("7225247386")

  // translate set of lists into phrases of strings
  def translate(number: String) :Set[String] =
    encode(number) map (_ mkString " ")

  translate("7225247386")
}