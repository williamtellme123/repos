package demo.web.api;

import demo.model.Greeting;
import demo.service.GreetingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;


// WEBSERVICE CONTROLLER LAYER
// USES THE BUSINESS SERVICE LAYER METHODS
// Integrate controller and service

@RestController
// Extends the standard spring stereotype annotation AddController
// RestController informs spring that is should convert the returned objects
// from the controller methods  into XML or JSON responses

public class GreetingController {

    // INJECT INTERFACE INTO CONTROLLER
    @Autowired
    public GreetingService greetingService;
    // Use autowired to tell Spring to inject an instance of GreetingService Interface into the
    // controller class

    // ALWAYS USE THE INTERFACE TYPE FOR DEPENDENCY INJECTION
    // RATHER THAN THE IMPLEMENTATION CLASS

    // Follows the programming by contract model and ensures
    // that only the public methods exposed by the GreetingService interface
    // are available to the service client


    public GreetingController(){}

    // @RequestMapping this
    // this is the 1st web service endpoint: getGreeting
    // it returns a class ResponseEntity which is a wrapper which spring will convert into an
    // HTTP response from the controller method

    // The type of the return object is the type of java object which will be converted into the http response body
    //  in this case it is a collection of Greeting objects 251
    //
    // annotation informs spring that this method should rec http requests
    // the elements within the requestMapping informs spring which http request to map to this method
    // value contains the context path to which this method is mapped

    // value contains the context path to which this method is mapped
    // method informs spring this method should only be invoked with inbound get requests
    // produces informs spring to convert the collection of Greetings into a JSON response
   @RequestMapping( value = "/api/greetings", 
                    method = RequestMethod.GET,
                    produces = MediaType.APPLICATION_JSON_VALUE)
   public ResponseEntity<Collection<Greeting>> getGreetings(){

          Collection<Greeting> greetings = greetingService.findAll();
          return new ResponseEntity<Collection<Greeting>>(greetings, HttpStatus.OK);

    }

    // WS service endpoint find Greeting(PK)
    // If found, Greeting returned: JSON & HTTP status:200
    // else return empty response body & HTTP status: 404
    // @param id A Long URL path variable containing the Greeting primary key         identifier.
    // @return A ResponseEntity containing a single Greeting object
    // @throws Exception Thrown if a problem occurs completing the request
    // path variable is a parameter to the request that can be annotated by @PathVariable
    // capture this from the URL path and make it available to method as parameter
    @RequestMapping(
            value = "/api/greetings/{id}",
            method = RequestMethod.GET,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Greeting> getGreeting(@PathVariable("id") Long id) {
        Greeting greeting = greetingService.findOne(id);
        if (greeting == null) {
            return new ResponseEntity<Greeting>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<Greeting>(greeting, HttpStatus.OK);
    }


     /**
     * endpoint create Greeting entity http request body contains Greeting object in JSON format
     * If successful see greeting & HTTP status 201.
     * else empty greeting & HTTP status 500
     * @param greeting The Greeting object to be created.
     * @return A ResponseEntity Greeting object
     * @throws Exception Thrown if a problem occurs completing the request.
     */
    @RequestMapping(
            value = "/api/greetings",
            method = RequestMethod.POST,
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Greeting> createGreeting(
            @RequestBody Greeting greeting) {

        Greeting savedGreeting = greetingService.create(greeting);

        return new ResponseEntity<Greeting>(savedGreeting, HttpStatus.CREATED);
    }
    /**
     * endpoint update POST JSON
     * If success Greeting & HTTP status 200
     * else not found == empty & HTTP status 404
     * If error empty response body & HTTP status 500
     * @param greeting The Greeting object to be updated.
     * @return A ResponseEntity
     * @throws Exception Thrown if a problem occurs completing the request.
     */
    @RequestMapping(
            value = "/api/greetings",
            method = RequestMethod.PUT,
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Greeting> updateGreeting(@RequestBody Greeting greeting) {

        Greeting updatedGreeting = greetingService.update(greeting);
        if (updatedGreeting == null) {
            return new ResponseEntity<Greeting>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return new ResponseEntity<Greeting>(updatedGreeting, HttpStatus.OK);
    }

    //
    //  Delete
    //  If success returns empty response & HTTP status 204.
    //  If not deleted successfully, the service returns an empty response body
    //  else not found == empty & HTTP status 500
    //  @param id URL path variable (PK)
    //  @return A ResponseEntity with an empty response
    //  @throws Exception Throw if a problem occurs completing the request.
    // /


    @RequestMapping(
            value = "/api/greetings/{id}",
            method = RequestMethod.DELETE,
            consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Greeting> deleteGreeting(@PathVariable("id") Long id, @RequestBody Greeting greeting)
            throws Exception {

        greetingService.delete(id);

        return new ResponseEntity<Greeting>(HttpStatus.NO_CONTENT);
    }


}
