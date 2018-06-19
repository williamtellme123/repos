package java8inaction;

//              JAVA 8 IN ACTION
//import org.apache.commons.io.FileUtils;
//import java.io.File;

import java.io.IOException;

// import java.nio.charset.Charset;
// https://www.google.com/?gws_rd=ssl#tbs=qdr:m&q=%22read+large+file%22+%22Java+8%22
// http://www.code4copy.com/java/best-to-read-text-file-in-java/



public class WorkingWithStreams {



    public static void main(String[] args) throws IOException {
        /**
         List<Dish> menu = Arrays.asList(
            new Dish("pork", false, 800, Dish.Type.MEAT),
                new Dish("beef", false, 700, Dish.Type.MEAT),
                new Dish("chicken", false, 400, Dish.Type.MEAT),
                new Dish("french fries", true, 530, Dish.Type.OTHER),
                new Dish("rice", true, 350, Dish.Type.OTHER),
                new Dish("season fruit", true, 120, Dish.Type.OTHER),
                new Dish("pizza", true, 550, Dish.Type.OTHER),
                new Dish("prawns", false, 300, Dish.Type.FISH),
                new Dish("salmon", false, 450, Dish.Type.FISH) );


        List<String> names =
                menu.stream()
                        .filter(d -> {
                                    System.out.println("filtering " + d.getName());
                                    return d.getCalories() > 300;
                                    }
                                )
                        .map( d -> {
                                    System.out.println("mapping " + d.getName());
                                    return d.getName();
                                    }
                            )
                        .limit(3)
                        .collect(toList());
        System.out.println(names);

        // WORKING WITH STREAMS


        // -----------------------------------------------------------------
        // FILTER DISTINCT
        System.out.println("================================================");
        List<Dish> vegetarianDishes =
                menu.stream()
                        .filter(Dish::isVegetarian)
                        .collect(toList());
        System.out.println("Vegetarian dishes are: ");
        System.out.println(vegetarianDishes);
        System.out.println("================================================");
        List<Integer> numbers = Arrays.asList(1, 2, 1, 3, 3, 2, 4);
        System.out.println("Even numbers are: ");
        numbers.stream()
                .filter(i -> i % 2 == 0)
                .distinct()                                 // remove dupes
                .forEach(System.out::println);

        // -----------------------------------------------------------------
        // FILTER STREAM W/PREDICATE & LIMIT
        System.out.println("================================================");
        List<Dish> lowcalDishes = menu.stream()
                .filter(d -> d.getCalories() > 300)
                .limit(3)                                   // works on sets
                .collect(toList());                         // so not assume order
                // .skip(2)                                 // can skip
        System.out.println("High calories are: ");
        System.out.println(lowcalDishes);
        System.out.println("================================================");
        List<String> words = Arrays.asList("Java8", "Lambdas", "In", "Action");
        List<Integer> wordLengths = words.stream()
                .map(String::length)                        // returns Stream<Integer>
                .collect(toList());
        System.out.println("Word lengths are: ");
        System.out.println(wordLengths);
        System.out.println("================================================");
        List<Dish> meatDishes =
                menu.stream()
                        .filter(d -> d.getType() == Dish.Type.MEAT)
                        .limit(2)
                        .collect(toList());
        System.out.println("First 2 Meat Dishes are: ");
        System.out.println(meatDishes);

        // -----------------------------------------------------------------
        // MAP FN TO EACH E IN STREAM
        System.out.println("================================================");
        List<String> dishNames = menu.stream()
                    .map(Dish::getName)                       // returns Stream<String>
                    .collect(toList());
        System.out.println("Function called on each E: ");
        System.out.println(dishNames);

        System.out.println("================================================");
        List<Integer> dishNameLengths = menu.stream()
                .map(Dish::getName)                           // returns Stream<String>
                .map(String::length)                          // returns Stream<Integer>
                .collect(toList());
        System.out.println("Length of each dish Name: ");
        System.out.println(dishNameLengths);


        // -----------------------------------------------------------------
        // FLAT MAP ARRAY to STREAM
        // -----------------------------------------------------------------
        //   PROBLEM: Find distinct letters in stream of words
        //
        //   1.  .map(w -> w.split(""))                    => Stream<String[eachWordArray]>
        //
        //   2.  .map(w -> w.split("").map(Arrays::stream)     => Stream<Stream<String>>
        //
        //   SOLUTION: flatMap
        //   3.  .map(w -> w.split("").flatMap(Arrays::stream) => Stream<String>
        System.out.println("================================================");
        String[] arrayOfWords = {"Goodbye", "World"};
        Stream<String> streamOfwords = Arrays.stream(arrayOfWords);
        List<String>  UniqueLetters = streamOfwords
                        .map(w -> w.split(""))          // each word => Array
                        .flatMap(Arrays::stream)        // stream<arrays>
                        .distinct()                     // flattens => single stream
                        .collect(Collectors.toList());
        System.out.println("UniqueLetters are");
        System.out.println(UniqueLetters);

        // PROBLEM: List of squares
        System.out.println("================================================");
        System.out.println("Squares : ");
        List<Integer> newnumbers = Arrays.asList(1, 2, 1, 3, 3, 2, 4);
        System.out.println("Even numbers are: ");
        newnumbers.stream()
                .filter(i -> i % 2 == 0)
                .forEach(System.out::print); System.out.println("");

        System.out.println("Numbers squared are: ");
        newnumbers.stream()
                .map(i -> i * i)
                .forEach(System.out::print);System.out.println("");


        // PROBLEM: List all combinations of two lists
        System.out.println("================================================");
        List<Integer> numbers1 = Arrays.asList(1, 2, 3);
        List<Integer> numbers2 = Arrays.asList(3, 4);
        List<int[]> pairs =
                numbers1.stream()
                        .flatMap(i -> numbers2.stream()
                                .map(j -> new int[]{i, j})
                        )
                        .collect(Collectors.toList());
        System.out.println("Combinations are:");
        for(int[] i : pairs){
            for(int j : i ){
                System.out.print(j + " ");
            }
            System.out.println("");
        }
        System.out.println("");

        // PROBLEM: List all combinations of two lists addition % 3 == 0
        System.out.println("================================================");
        List<Integer> numbers3 = Arrays.asList(1, 2, 3);
        List<Integer> numbers4 = Arrays.asList(3, 4);
        List<int[]> pairs2 =
                numbers3.stream()
                        .flatMap(i ->
                                numbers4.stream()
                                .filter(j -> (i+j) % 3 == 0)
                                .map(j -> new int[]{i, j})
                        )
                        .collect(Collectors.toList());
        System.out.println("Combinations are:");
        for(int[] i : pairs2){
            for(int j : i ){
                System.out.print(j + " ");
            }
            System.out.println("");
        }
        System.out.println("");

        // -----------------------------------------------------------------
        // MATCHING

        // PROBLEM: Finding one e
        System.out.println("================================================");
        boolean isHealthy =
                            menu.stream()
                            .anyMatch(d -> d.getCalories() < 1000);
        System.out.println("The menu has some dishes under 1000 calories: " + isHealthy);
        // PROBLEM: Finding all e is true
        System.out.println("================================================");
        boolean isNotHealthy =
                menu.stream()
                        .allMatch(d -> d.getCalories() >= 1000);
        System.out.println("The entire is under 1000 calories: " + isNotHealthy);
        // PROBLEM: Finding no e is true
        System.out.println("================================================");
        boolean isNoneHealthy =
                menu.stream()
                        .noneMatch(d -> d.getCalories() >= 1000);
        System.out.println("The entire menu has some over 1000 calories: " + isNoneHealthy);


        // -----------------------------------------------------------------
        // FINDING and SHORT CIRCUITING
        // Optional is broken in Java 8
        //        Optional<Other> result =
        //                things.stream()
        //                        .map(this::resolve)
        //                        .flatMap(Optional::stream)
        //                        .findFirst();
        //
        // Turns an Optional<T> into a Stream<T> of length zero or one depending upon
        // whether a value is present.
        //
        // http://stackoverflow.com/questions/22725537/using-java-8s-optional-with-streamflatmap
        // JDK 9 Has this
        //
        // Turns an Optional<T> into a Stream<T> of length zero or one depending upon
        // whether a value is present.
        System.out.println("================================================");
        Optional<Dish> myDishes =
                    menu
                     .stream()
                     .filter(Dish::isVegetarian)
                     //.findFirst()                     // WORKS
                     .findAny()                         // WORKS    Best for parallelism
                     // .ifPresent(System.out.println())   // DOES NOT WORK
                  ;
        System.out.println("The first Vegetarian dish: " + myDishes);

        System.out.println("================================================");
        List<Integer> someNumbers = Arrays.asList(1, 2, 3, 4, 5);
        Optional<Integer> firstSquareDivisibleByThree =
                someNumbers.stream()
                        .map(x -> x * x)
                        .filter(x -> x % 3 == 0)
                        .findFirst(); // 9
        System.out.println("The firstSquareDivisibleByThree: " + firstSquareDivisibleByThree);

        // -----------------------------------------------------------------
        // REDUCING
        System.out.println("================================================");
        List<Integer> someMoreNumbers = Arrays.asList(1, 2, 3, 4, 5);
        int sum = someMoreNumbers.stream().reduce(0, (a, b) -> a + b);
        int prod = someMoreNumbers.stream().reduce(1, (a, b) -> a * b);
        Optional<Integer> max = someMoreNumbers.stream().reduce(Integer::max);
        Optional<Integer> min = someMoreNumbers.stream().reduce(Integer::min);

        System.out.println("The sum: " + sum);
        System.out.println("The prod: " + prod);
        System.out.println("The max: " + max);
        System.out.println("The min: " + min);

        // -----------------------------------------------------------------
        // REDUCING IN PARALLELISM
        // partition input :: sum partitions :: combine sums
        // lambda must be associative (any order)
        int sum2 = someMoreNumbers.parallelStream().reduce(0, (a, b) -> a + b + 5);
        System.out.println("The sum2: " + sum2);


        // -----------------------------------------------------------------
        // EXAMPLES
        Trader raoul = new Trader("Raoul", "Cambridge");
        Trader mario = new Trader("Mario","Milan");
        Trader alan = new Trader("Alan","Cambridge");
        Trader brian = new Trader("Brian","Cambridge");
        List<Transaction> transactions = Arrays.asList(
                new Transaction(brian, 2011, 300),
                new Transaction(raoul, 2012, 1000),
                new Transaction(raoul, 2011, 400),
                new Transaction(mario, 2012, 710),
                new Transaction(mario, 2012, 700),
                new Transaction(alan, 2012, 950)
        );
        // ---------------------
        // 1. Find all transactions in 2011/sort asc
        List<Transaction> Tx2011 = transactions
                .stream()
                .filter(t -> t.getYear() == 2011)
                .sorted(comparing(Transaction::getValue))
                .collect(toList());
        System.out.println("The Tx2001: " + Tx2011);
        // ---------------------
        // 2. List unique cities where the traders work?
        List<String> cities = transactions
                .stream()
                .map(tx -> tx.getTrader().getCity())
                .distinct()
                .collect(Collectors.toList());
        System.out.println("The cities: " + cities);
        // ---------------------
        // 3. Find all traders from Cambridge and sort them by name
        List<Trader> cambridgeTraders = transactions
                .stream()
                .map(Transaction::getTrader)
                .filter(td -> td.getCity().equals("Cambridge"))
                .distinct()
                .sorted(comparing(Trader::getName))
                .collect(toList());
        System.out.println("The cambridgeTraders sorted: " + cambridgeTraders);
        // ---------------------
        // 4. Return a string of all traders’ names sorted alphabetically
        String AllTraders = transactions
                .stream()
                .map(tx -> tx.getTrader().getName())
                .distinct()
                .sorted()
                .reduce("",(n1,n2) -> n1 + n2);
        System.out.println("All Traders alphabetically: " + AllTraders);
        // ---------------------
        // StringBuilder
        String traderStr =
                transactions.stream()
                        .map(transaction -> transaction.getTrader().getName())
                        .distinct()
                        .sorted()
                        .collect(joining());
        System.out.println("All Traders alphabetically: " + traderStr);
        // ---------------------
        // 5. Are any traders based in Milan?
        Boolean milanBased = transactions
                .stream()
                .anyMatch(tx -> tx.getTrader().getCity().equals("Milan"));
        System.out.println("There are traders in Milan: " + milanBased);
        // ---------------------
        // 6. Print all transactions’ values from the traders living in Cambridge.
        List<Transaction> TxValues = transactions
                .stream()
                .filter(tx -> tx.getTrader().getCity().equals("Cambridge"))
                .distinct()
                .collect(toList());
        System.out.println("The Transaction Values from Cambridge: " + TxValues);
        System.out.println("Another technique to list Transaction Values from Cambridge follows. ");
            transactions
                .stream()
                .filter(tx -> tx.getTrader().getCity().equals("Cambridge"))
                // .filter(tx -> "Cambridge".equals(tx.getTrader().getCity()))
                .map(Transaction::getValue)
                .forEach(System.out::println);
        // ---------------------
        // 7. What’s the max value of all the transactions?
        Optional<Integer> max = transactions
                .stream()
                .map(t -> t.getValue())
                .reduce(Integer::max);
        System.out.println("The max Value: " + max);
        // ---------------------
        // 8. What’s the min value of all the transactions?
        Optional<Integer> min = transactions
                .stream()
                .map(t -> t.getValue())
                .reduce(Integer::min);
        System.out.println("The min Value: " + min);
        // ---------------------
        System.out.println("Another technique to get Min follows. ");
        Optional<Transaction> smallesTx = transactions
                .stream()
                .reduce((t1,t2) -> t1.getValue() < t2.getValue() ? t1 : t2);
        System.out.println("The smallesTx Value: " + smallesTx);
         */

    } // end of main

}



//  REFRESHER :: SPLIT & LOOP
//    // GetClass
//    String whoo = "Hello";
//    String newwords[] = whoo.split("");
//    for(String s: newwords){
//        System.out.print("s = " + s + "     ");
//    }
//    System.out.println("");
// System.out.println("newwords.getTypeName() " + newwords.getClass());
