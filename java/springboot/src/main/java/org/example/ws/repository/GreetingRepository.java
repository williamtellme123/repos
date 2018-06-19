package org.example.ws.repository;

import org.example.ws.model.Greeting;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


// Our repository interface extends the JPA repository interface from the
// Spring data JPA Framework
//
// JPA Repository is a generic interface
// so needs to know about our entity: It's Class and PK
//
// Annotate with @Repository stereotype so spring registers
// the repository component when the app starts

@Repository
public interface GreetingRepository extends JpaRepository<Greeting, Integer> {


}
