
import java.time.LocalDate;
import java.time.Month;
import java.time.Period;
import java.util.ArrayList;
import java.util.List;

public class Person {

    String name;
    LocalDate birthday;
    Sex gender;
    String emailAddress;

    public enum Sex {
        MALE, FEMALE
    }

    public Person(String name, LocalDate birthday, Sex gender, String emailAddress) {
        this.name = name;
        this.birthday = birthday;
        this.gender = gender;
        this.emailAddress = emailAddress;
    }

    public static List<Person> createRoster() {
        List<Person> persons = new ArrayList<Person>();

        persons.add(new Person("Jake", LocalDate.of(1991, Month.APRIL, 22), Sex.MALE,"jake_stone@meekness.com"));
        persons.add(new Person("Janis", LocalDate.of(1995, Month.JUNE, 10), Sex.FEMALE,"Janis.ca-tech@dps.centrin.net.id"));
        persons.add(new Person("Josh", LocalDate.of(1996, Month.JANUARY, 15), Sex.MALE,"Josh@telkomsel.co.id"));
        persons.add(new Person("Janet", LocalDate.of(1993, Month.JULY, 4), Sex.FEMALE,"Janet@astonrasuna.com"));
        persons.add(new Person("Jimmy", LocalDate.of(1994, Month.AUGUST, 15), Sex.MALE,"Jimmy.amartabali@dps.centrin.net.id"));
        return persons;
    }

    public int getAge() {
        LocalDate today = LocalDate.now();
        Period p = Period.between(birthday, today);
        return p.getYears();
    }

    public Sex getGender() {
        return gender;
    }
    public String getEmailAddress() {
        return emailAddress;
    }

    public void printPerson() {
        System.out.println(name);
    }
    public void printPersonAndAge() {
        System.out.println(name + " " + this.getAge());
    }
}