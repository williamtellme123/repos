
package mymessenger;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;


@Path("/myresource")
public class MyResource {

    // GET         http://localhost:8080/messenger/webresources/myresource
    @GET
    @Produces("text/plain")
    public String getIt() {
        return "Hi there!";
    }
}
