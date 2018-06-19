import scala.io.Source

// Convert telephone numbers to words
// 7225247386   -> scala is fun (1 of many)
//  find any words for
//    7
//    72
//    722 .....

object phoneToWords {

    val in = Source.fromURL("http://lamp.epfl.ch/files/content/sites/lamp/files/teaching/progfun/linuxwords.txt").getLines

    // convert iterator.toList
    // drop hyphenated words from dictionary
    val words = in.toList filter (_ forall (_.isLetter))

  val keyPad = Map(
    '2' -> "ABC", '3' -> "DEF", '4' -> "GHI", '5' -> "JKL",
    '6' -> "MNO", '7' -> "PQRS", '8' -> "TUV", '9' -> "WXYZ")

  // Invert letters to digits  A -> 2
  val letterToDigit: Map[Char, Char] =
    for ((digit, str) <- keyPad; ltr <- str) yield (ltr -> digit)


  // Java -> 5282
  def wordToDigits(word: String): String =
  // apply same op on every character :: use map as a function of a map method
    word.toUpperCase.map(letterToDigit)

  wordToDigits("scalaisfun")
  wordToDigits("JAVA")

  // group dictionary by numbers
  // Map(63972278 -> List(newscast), 29237638427 -> List(cybernetics), 782754448 -> List(starlight), ...
  // 5282 -> List("Java", "Kata", "Lava", ...)
   val digitsToWords: Map[String, Seq[String]] =
    // since 7 is not associated with a word
    // pass default value to prevent exception
    words groupBy wordToDigits withDefaultValue List()

  // A map from "5282" -> List("Java", "Kata", "Lava", ...)
  // Missing number maps to empty set, e.g. "1111" -> List()
  // val digitsToWords: Map[String, Seq[String]] =
  //    words groupBy wordToDigits withDefaultValue List()

  // Return all ways to decode number into words
  def decode(number: String): Set[List[String]] = {
    if (number.isEmpty) Set(List())
    else {
      for {
        split <- 1 to number.length
        first <- digitsToWords(number take split)
        rest <- decode(number drop split)
      } yield first :: rest
    }.toSet
  }

  decode("7225247386")

  // translate set of lists into phrases of strings
  def translate(number: String) :Set[String] =
    decode(number) map (_ mkString " ")

  translate("7225247386")

}