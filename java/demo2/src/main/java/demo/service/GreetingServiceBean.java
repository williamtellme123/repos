package demo.service;
//import javax.persistence.EntityExistsException;
//import javax.persistence.NoResultException;
//import com.leanstacks.ws.repository.GreetingRepository;
//import org.springframework.boot.actuate.metrics.CounterService;
//import org.springframework.transaction.annotation.Transactional;

import demo.model.Greeting;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

// BUSINESS SERVICE LAYER

// GreetingServiceBean encapsulates all business logic on Greetings
// when the application starts spring scans the classes
// and automatically manages classes annotated with @Service
@Service
public class GreetingServiceBean implements GreetingService {

    private static Long nextId;
    private static Map<Long, Greeting> greetingMap;


    // HELPER METHODS LATER REPLACED WITH DATA FROM A SPRING SERVICES REPOSITORY
    private static Greeting save(Greeting greeting){
        if (greetingMap == null) {
            greetingMap = new HashMap<Long, Greeting>();
            if (nextId == null){
                nextId = 1L;
            }
            else nextId += 1;
        }
        // If Update ...
        if (greeting.getId() != null)
        {
            Greeting oldGreeting = greetingMap.get(greeting.getId());
            if (oldGreeting == null)
            {
                return null;
            }
            greetingMap.remove(greeting.getId());
            greetingMap.put(greeting.getId(), greeting);
            return greeting;
        }

        // If Create ..
        greeting.setId(nextId);
        nextId += 1;
        greetingMap.put(greeting.getId(),greeting);
        return greeting;
    }

    // this helper method
    private static boolean remove(Long id) {
        Greeting deletedGreeting = greetingMap.remove(id);
        if (deletedGreeting == null)  {
            return false;
        }
        return true;
    }

    // static code block to create some greetings
    static {
        Greeting g1 = new Greeting();
        g1.setText("Hello Worlkd");
        save(g1);

        Greeting g2 = new Greeting();
        g2.setText("Hola Munda");
        save(g2);
    }
    // FIND ALL -----------------------------------------
    @Override
    public Collection<Greeting> findAll() {
        Collection<Greeting> greetings = greetingMap.values();
        return greetings;
    }

    // FIND ONE -----------------------------------------
    @Override
    public Greeting findOne(Long id) {
        Greeting greeting = greetingMap.get(id);
        return greeting;
    }

    // CREATE -----------------------------------------
    @Override
    public Greeting create(Greeting greeting) {
        Greeting savedGreeting = save(greeting);
        return savedGreeting;
    }

    // UPDATE -----------------------------------------
    @Override
    public Greeting update(Greeting greeting) {
        Greeting updatedGreeting = save(greeting);
        return updatedGreeting;
    }

    // REMOVE (aka DELETE) -----------------------------------------
    @Override
    public void delete(Long id) {
          remove(id);
    }
}
