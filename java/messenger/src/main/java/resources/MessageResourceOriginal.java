/*
package resources;


import model.Message;
import services.MessageServiceOriginal;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

//URI maps to the class
@Path("/messages")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class MessageResourceOriginal {

    MessageServiceOriginal messageService = new MessageServiceOriginal();

    // method maps to an HTTP method
    // describes type
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Message> getMessages()
    {
        return messageService.getAllMessages();
    }

    @GET
    @Path("/{messageId}")
    public Message getMessage(@PathParam("messageId") long Id){
        Message message = messageService.getMessage(Id);
        return message;
    }

    @POST
    public Message addMessage(Message message){
        messageService.addMessage(message);
        return message;
    }

    @PUT
    @Path("/{messageId}")
    public Message updateMessage(@PathParam("messageId") long Id, Message message){
        message.setId(Id);
        return messageService.updateMessage(message);
    }

    @DELETE
    @Path("/{messageId}")
    public Message deleteMessage(@PathParam("messageId") long Id) {
        return messageService.removeMessage(Id);

    }
}
*/