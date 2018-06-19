
/*
      MAP
          Map is an immutable iterable datatype
          Also a partial function
            return value or
            return exception if not found

          Total Function
            add withDefaultValue

          Supports
              map
              flatMap
              withFilter        // therefore for expressions

              ~order by
              sortWith(_.length < _.length
              sorted

              groupBy           // partitions collections
                                // into map of collections


      OPTION VALUES

      trait option[+A]
      case class Some[+A](value: A) extends Option[A]
      object None extends Option[Nothing]

      Expression map get key returns
        None
        Some(value) if map associates given key to value
      Since options are case classes can decompose using pattern matching






*/

object usingMaps {

  // DATA STRUCTURE
  // Key value pairs
  val romanNumerals = Map("I" -> 1, "V" -> 5, "X" -> 10)
  val capitalOfCountry = Map("US" -> "Washington", "Poland" -> "Warsaw") withDefaultValue "unknown"


  // AS FUNCTION
  romanNumerals("I")
  // romanNumerals.->"I"
  capitalOfCountry("US")

  // USING GET
  // returns Option Values (Some or None)
  romanNumerals get "I"
  // Option Type Some(1)
  romanNumerals get "Y"
  // Option Type None
  capitalOfCountry get "US"
  // Option Type Some(Washington)
  capitalOfCountry("Korea")  // exception unless you add withDefaultValue "unknown"
  capitalOfCountry get "Korea"
  // Option Type None

  // SORTWITH
  val fruit = List("apple", "pear", "pineapple", "pumkin")
  fruit sortWith(_.length < _.length)
  val veg = List("potatoe", "sqaush", "brocolli","avocado")
  veg.sorted

  // GROUPBY
  fruit groupBy (_.head)

  // BIGGER EXAMPLE Polynomial
  // map exponent to coefficient





}