package org.example.ws.service;
//import javax.persistence.EntityExistsException;
//import javax.persistence.NoResultException;
//import com.leanstacks.ws.repository.GreetingRepository;
//import org.springframework.boot.actuate.metrics.CounterService;
//import org.springframework.transaction.annotation.Transactional;

import org.example.ws.model.Greeting;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;


// BUSINESS SERVICE LAYER

// GreetingServiceBean encapsulates all business logic on Greetings
// when the application starts spring scans the classes
// and automatically manages classes annotated with @Service
@Service
public class GreetingServiceBeanOriginal implements GreetingServiceOriginal {

    private static Integer nextId;
    private static Map<Integer, Greeting> greetingMap;


    // HELPER METHODS LATER REPLACED WITH DATA FROM A SPRING SERVICES REPOSITORY
    private static Greeting save(Greeting greeting){
        if (greetingMap == null) {
            greetingMap = new HashMap<Integer, Greeting>();
            if (nextId == null){
                nextId = 1;
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
    private static boolean remove(Integer id) {
        Greeting deletedGreeting = greetingMap.remove(id);
        if (deletedGreeting == null)  {
            return false;
        }
        return true;
    }

    // static code block to create some greetings
    static {
        Greeting g1 = new Greeting();
        g1.setText("Hello World");
        save(g1);

        Greeting g2 = new Greeting();
        g2.setText("Hola Munda");
        save(g2);
    }
    // FIND ALL -----------------------------------------
    @Override
    public Collection<Greeting> findAll() {
//        logger.info("> findAll");

//        counterService.increment("method.invoked.greetingServiceBean.findAll");
//        Collection<Greeting> greetings = greetingRepository.findAll();
        Collection<Greeting> greetings = greetingMap.values();
//        logger.info("< findAll");
        return greetings;
    }

    // FIND ONE -----------------------------------------
//    @Cacheable(
//            value = "greetings",
//            key = "#id")
    @Override
    public Greeting findOne(Integer id) {
//        logger.info("> findOne {}", id);

//        counterService.increment("method.invoked.greetingServiceBean.findOne");
//        Greeting greeting = greetingRepository.findOne(id);
        Greeting greeting = greetingMap.get(id);

//        logger.info("< findOne {}", id);
        return greeting;
    }

    // CREATE -----------------------------------------
    //    @CachePut(
    //            value = "greetings",
    //            key = "#result.id")
    //    @Transactional
    @Override
    public Greeting create(Greeting greeting) {
    //        logger.info("> create");

    //        counterService.increment("method.invoked.greetingServiceBean.create");
    //
    //        // Ensure the entity object to be created does NOT exist in the
    //        // repository. Prevent the default behavior of save() which will update
    //        // an existing entity if the entity matching the supplied id exists.
    //        if (greeting.getId() != null) {
    //            logger.error("Attempted to create a Greeting, but id attribute was not null.");
    //            logger.info("< create");
    //            throw new EntityExistsException(
    //                    "Cannot create new Greeting with supplied id.  The id attribute must be null to create an entity.");
    //        }
    //        Greeting savedGreeting = greetingRepository.save(greeting);
        Greeting savedGreeting = save(greeting);
    //        logger.info("< create");
        return savedGreeting;
    }

    // UPDATE -----------------------------------------
    //    @CachePut(
    //            value = "greetings",
    //            key = "#greeting.id")
    //    @Transactional
    @Override
    public Greeting update(Greeting greeting) {
    //        logger.info("> update {}", greeting.getId());

    //        counterService.increment("method.invoked.greetingServiceBean.update");
    //
    //        // Ensure the entity object to be updated exists in the repository to
    //        // prevent the default behavior of save() which will persist a new
    //        // entity if the entity matching the id does not exist
    //        Greeting greetingToUpdate = findOne(greeting.getId());
    //        if (greetingToUpdate == null) {
    //            logger.error("Attempted to update a Greeting, but the entity does not exist.");
    //            logger.info("< update {}", greeting.getId());
    //            throw new NoResultException("Requested Greeting not found.");
    //        }
    //
    //        Greeting updatedGreeting = greetingRepository.save(greeting);
        Greeting updatedGreeting = save(greeting);
    //        logger.info("< update {}", greeting.getId());
        return updatedGreeting;
    }

    // REMOVE (aka DELETE) -----------------------------------------
    //    @CacheEvict(
    //            value = "greetings",
    //            key = "#id")
    //    @Transactional
    @Override
    public void delete(Integer id) {
    //        logger.info("> remove {}", id);
    //
    //        counterService.increment("method.invoked.greetingServiceBean.delete");
    //        greetingRepository.delete(id);
          remove(id);

    //        logger.info("< delete {}", id);
    }

    // EVICT CACHE  -----------------------------------------
    //    @CacheEvict(
    //            value = "greetings",
    //            allEntries = true)
    //    @Override
    //    public void evictCache() {
    //        logger.info("> evictCache");
    //
    //        counterService.increment("method.invoked.greetingServiceBean.evictCache");
    //
    //        logger.info("< evictCache");
    //    }
    //
    //    private Logger logger = LoggerFactory.getLogger(this.getClass());
    //    /**
    //     * The <code>CounterService</code> captures metrics for Spring Actuator.
    //     */
    //    @Autowired
    //    private CounterService counterService;
    //
    //    /**
    //     * The Spring Data repository for Greeting entities.
    //     */
    //    @Autowired
    //    private GreetingRepository greetingRepository;
}
