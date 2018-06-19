package org.example.ws.service;
//import javax.persistence.EntityExistsException;
//import javax.persistence.NoResultException;
//import com.leanstacks.ws.repository.GreetingRepository;
//import org.springframework.boot.actuate.metrics.CounterService;
//import org.springframework.transaction.annotation.Transactional;

import org.example.ws.model.Greeting;
import org.example.ws.repository.GreetingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.Map;


// BUSINESS SERVICE LAYER

// GreetingServiceBean encapsulates all business logic on Greetings
// when the application starts spring scans the classes
// and automatically manages classes annotated with @Service
@Service
public class GreetingServiceBean implements GreetingService {

    private static Integer nextId;
    private static Map<Integer, Greeting> greetingMap;

    // Inject instance of repository into the GreetingServiceBean
    @Autowired
    private GreetingRepository greetingRepository;


    // FIND ALL -----------------------------------------
    @Override
    public Collection<Greeting> findAll() {
//        logger.info("> findAll");

//        counterService.increment("method.invoked.greetingServiceBean.findAll");
        Collection<Greeting> greetings = greetingRepository.findAll();
//        Collection<Greeting> greetings = greetingMap.values();
//        logger.info("< findAll");
        return greetings;
    }

    // FIND ONE -----------------------------------------
//    @Cacheable(
//            value = "greetings",
//            key = "#id")
    @Override
    public Greeting findOne(Integer id) {
//        counterService.increment("method.invoked.greetingServiceBean.findOne");
        Greeting greeting = greetingRepository.findOne(id);
//        Greeting greeting = greetingMap.get(id);
        return greeting;
    }

    // CREATE -----------------------------------------
    //    @CachePut(
    //            value = "greetings",
    //            key = "#result.id")
    //    @Transactional
    @Override
    public Greeting create(Greeting greeting) {
    //        counterService.increment("method.invoked.greetingServiceBean.create");
    //
    // JpaRepository exposes single method to update and create
    // Ensure the entity object to be updated exists in the repository to
    // prevent the default behavior of save() which will persist a new
    // entity if the entity matching the id does not exist

        if (greeting.getId() != null) {
            // Cannot create new Greeting with existing pk
            // id attribute must be null create new entity(pk)
            return null;
        }
        Greeting savedGreeting = greetingRepository.save(greeting);
        return savedGreeting;
    }

    // UPDATE -----------------------------------------
    //    @CachePut(
    //            value = "greetings",
    //            key = "#greeting.id")
    //    @Transactional
    @Override
    public Greeting update(Greeting greeting) {
        Greeting greetingPersisted = findOne(greeting.getId());
        if (greetingPersisted == null) {
        //      logger.error("Attempted to update a Greeting, but the entity does not exist.");
        //      logger.info("< update {}", greeting.getId());
        //             throw new NoResultException("Requested Greeting not found.");

            // Likewise if this Id does not already exist
            // we cannot update it
            return null;
        }
        Greeting updatedGreeting = greetingRepository.save(greeting);
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
        greetingRepository.delete(id);
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
