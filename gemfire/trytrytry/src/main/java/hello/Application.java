
package hello;

import com.gemstone.gemfire.cache.GemFireCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.gemfire.CacheFactoryBean;
import org.springframework.data.gemfire.LocalRegionFactoryBean;
import org.springframework.data.gemfire.repository.config.EnableGemfireRepositories;

import java.io.IOException;

@Configuration
@EnableGemfireRepositories
public class Application implements CommandLineRunner {

    @Bean
    CacheFactoryBean cacheFactoryBean() {
        return new CacheFactoryBean();
    }

    @Bean
    LocalRegionFactoryBean<String, Person> localRegionFactory(final GemFireCache cache) {
        return new LocalRegionFactoryBean<String, Person>() {

            {
                setCache(cache);
                setName("hello");
                setClose(false);
            }
        };
    }

    @Autowired
    PersonRepository personRepository;

    @Override
    public void run(String... strings) throws Exception {
        Person alice = new Person("Alice", 40);
        Person bob = new Person("Baby Bob", 1);
        Person carol = new Person("Teen Carol", 13);
        Person grandpa = new Person("GrandPa Joe", 73);

        System.out.println("Before linking up with Gemfire...");
        for (Person person : new Person[] { alice, bob, carol, grandpa }) {
            System.out.println("\t" + person);
        }

        personRepository.save(alice);
        personRepository.save(bob);
        personRepository.save(carol);
        personRepository.save(grandpa);

        System.out.println("Lookup each person by name...");
        for (String name : new String[] { alice.name, bob.name, carol.name , grandpa.name}) {
            System.out.println("\t" + personRepository.findByName(name));
        }

        System.out.println("Adults (over 18):");
        for (Person person : personRepository.findByAgeGreaterThan(18)) {
            System.out.println("\t" + person);
        }

        System.out.println("Babies (less than 5):");
        for (Person person : personRepository.findByAgeLessThan(5)) {
            System.out.println("\t" + person);
        }

        System.out.println("Teens (between 12 and 20):");
        for (Person person : personRepository.findByAgeGreaterThanAndAgeLessThan(12, 20)) {
            System.out.println("\t" + person);
        }
    }

    public static void main(String[] args) throws IOException {
        SpringApplication.run(Application.class, args);
    }
}
