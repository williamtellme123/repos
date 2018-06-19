
import java.util.List;
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.Comparator;
import java.util.function.Predicate;
import java.lang.Iterable;
import java.time.chrono.IsoChronology;

public class RosterTest {

    interface CheckPerson {
        boolean test(Person p);
    }

    // Approach 1: Naive approach Search to Match One Characteristic
    // Potentially brittle if change Person class (measures ages with different data type or algorithm)
    // You would have to rewrite a lot of your API to accommodate this change
    // Also restrictive; if you wanted print members younger than a certain age
    public static void printPersonsOlderThan(List<Person> roster, int age) {
        for (Person p : roster) {
            if (p.getAge() >= age) {
                p.printPersonAndAge();
            }
        }
    }

    // Approach 2: More Generalized: matches range
    public static void printPersonsWithinAgeRange(
            List<Person> roster, int low, int high) {
        for (Person p : roster) {
            if (low <= p.getAge() && p.getAge() < high) {
                p.printPersonAndAge();
            }
        }
    }

    // But what if want gender, or gender/age
    // What if add relationship status or geographical location
    // More generic than printPersonsOlderThan
    // A separate method for each possible search query can still lead to brittle code
    // Instead separate criteria code into a different class

    // Specify Search Criteria Code in a
    // Approach 3: Local Class
    // Approach 4: Anonymous Class
    // Approach 5: Lambda Expression

    // Method checks List for criteria in CheckPerson parameter tester by invoking the method tester.test.
    // If tester.test returns true, then method printPersons is invoked on the Person instance
    // See CheckPerson interface

    // 2nd param object must implement CheckPerson which means must implement (define) test
    public static void printPersons(List<Person> roster, CheckPerson tester) {
        for (Person p : roster) {
            if (tester.test(p)) {
                p.printPerson();
            }
        }
    }
    // Approach 3: must be cloned for every type of search
    /* from main:
                    class CheckPersonEligibleForSelectiveService implements CheckPerson {
                        public boolean test(Person p) {
                            boolean result;
                            result = p.getGender() == Person.Sex.MALE
                                    && p.getAge() >= 18
                                    && p.getAge() <= 25;
                            return result
                        }
                    }
                    printPersons(roster, new CheckPersonEligibleForSelectiveService()); */

    // Approach 4: Anonymous Class


    // Approach 6: Use Standard Functional Interfaces with Lambda Expressions
    public static void printPersonsWithPredicate(
            List<Person> roster, Predicate<Person> tester) {
        for (Person p : roster) {
            if (tester.test(p)) {
                p.printPerson();
            }
        }
    }

    // Approach 7: Use Lambda Expressions Throughout Your Application
    public static void processPersons(
            List<Person> roster,
            Predicate<Person> tester,
            Consumer<Person> block) {
        for (Person p : roster) {
            if (tester.test(p)) {
                block.accept(p);
            }
        }
    }

    // Approach 7, second example
    public static void processPersonsWithFunction(
            List<Person> roster,
            Predicate<Person> tester,
            Function<Person, String> mapper,
            Consumer<String> block) {
        for (Person p : roster) {
            if (tester.test(p)) {
                String data = mapper.apply(p);
                block.accept(data);
            }
        }
    }

    // Approach 8: Use Generics More Extensively
    public static <X, Y> void processElements(
            Iterable<X> source,
            Predicate<X> tester,
            Function<X, Y> mapper,
            Consumer<Y> block) {
        for (X p : source) {
            if (tester.test(p)) {
                Y data = mapper.apply(p);
                block.accept(data);
            }
        }
    }

    public static void main(String... args) {
        List<Person> roster = Person.createRoster();

        System.out.println("-------------------");
        System.out.println("ALL ---------------");
        System.out.println("-------------------");
        for (Person p : roster) {
            p.printPerson();
        }
        System.out.println("-------------------");
        // Approach 1: Create Methods that Search for Persons that Match One
        // Characteristic
        System.out.println("Age > 20 ----------");
        System.out.println("-------------------");
        printPersonsOlderThan(roster, 20);
        System.out.println("-------------------");

        // Approach 2: Create More Generalized Search Methods
        System.out.println("14 < Age > 30 ----");
        System.out.println("-------------------");
        printPersonsWithinAgeRange(roster, 14, 30);
        System.out.println("-------------------");

        // Approach 3: Specify Search Criteria Code in a Local Class
        System.out.println("18-25 Local Class --");
        System.out.println("-------------------");
        class CheckPersonEligibleForSelectiveService implements CheckPerson {
            public boolean test(Person p) {
                boolean result;
                result = p.getGender() == Person.Sex.MALE
                        && p.getAge() >= 18
                        && p.getAge() <= 25;
                return result;
            }
        }
        printPersons(roster, new CheckPersonEligibleForSelectiveService());
        System.out.println("-------------------");

        // Approach 4: Specify Search Criteria Code in an Anonymous Class (used in parameter to method)
        /* Remember anonymous class expression consists of:
            New interfaceName() here CheckPerson When implement interface, no constructor, so empty ()
            Class body with test method declaration & no statements

            Reduces code (no new class for each search)that you want to perform.
            But bulky
        */
        System.out.println("18-25 " + "anon class----");
        System.out.println("-------------------");
        printPersons(
                roster,
                new CheckPerson() {
                    public boolean test(Person p) {
                        return p.getGender() == Person.Sex.MALE
                                && p.getAge() >= 18
                                && p.getAge() <= 25;
                    }
                }
        );
        System.out.println("-------------------");
        // Approach 5: Specify Search Criteria Code with a Lambda Expression
        System.out.println("18-25 " + "(lambda expression):");
        System.out.println("-------------------");
        printPersons(
                roster,
                (Person p) -> p.getGender() == Person.Sex.MALE
                        && p.getAge() >= 18
                        && p.getAge() <= 25
        );

        System.out.println("-------------------");
        // Approach 6: Use Std Fn Interfaces with Lambda Expressions
        System.out.println("18-25 " +  "(with Predicate parameter):");
        System.out.println("-------------------");
        printPersonsWithPredicate(
                roster,
                p -> p.getGender() == Person.Sex.MALE
                        && p.getAge() >= 18
                        && p.getAge() <= 25
        );
        System.out.println("-------------------");
        // Approach 7: Use Lamba Expressions Throughout Your Application
        System.out.println("18-25 " +  "(with Predicate & Consumer params):");
        System.out.println("-------------------");
        processPersons(
                roster,
                p -> p.getGender() == Person.Sex.MALE
                        && p.getAge() >= 18
                        && p.getAge() <= 25,
                p -> p.printPerson()
        );
        System.out.println("-------------------");

        // Approach 7, second example
        System.out.println("18-25 " +  "(with Predicate, Fn & Consumer params):");
        System.out.println("-------------------");
        processPersonsWithFunction(
                roster,
                p -> p.getGender() == Person.Sex.MALE
                        && p.getAge() >= 18
                        && p.getAge() <= 25,
                p -> p.getEmailAddress(),
                email -> System.out.println(email)
        );
        System.out.println("-------------------");
        // Approach 8: Use Generics More Extensively
        System.out.println("18-25 " + "(generic version):");
        System.out.println("-------------------");
        processElements(
                roster,
                p -> p.getGender() == Person.Sex.MALE
                        && p.getAge() >= 18
                        && p.getAge() <= 25,
                p -> p.getEmailAddress(),
                email -> System.out.println(email)
        );
        System.out.println("-------------------");
        // Approach 9: Use Bulk Data Ops That Accept Lambda Expressions as Parameters
        System.out.println("Persons who are eligible for Selective Service " +
                "(with bulk data operations):");
        System.out.println("-------------------");
        roster
                .stream()
                .filter(
                        p -> p.getGender() == Person.Sex.MALE
                                && p.getAge() >= 18
                                && p.getAge() <= 25)
                .map(p -> p.getEmailAddress())
                .forEach(email -> System.out.println(email));
        System.out.println("-------------------");
        System.out.println("  THATS ALL FOLKS ");
        System.out.println("-------------------");
    }
}
