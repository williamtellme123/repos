package resources;


import model.Comment;
import services.CommentService;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;


// SUB RESOURCE
@Path("/")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class CommentResource {

    private CommentService commentService = new CommentService();

//    Calendar cal = Calendar.getInstance();
//    Date d15 = new Date();
//    Date d14 = new Date();
//    cal.setTime(d14);
//    cal.add(Calendar.DATE, -365); // add 1 years
//    d14 = cal.getTime();
//    System.out.println("d14 = " + d14);
//    System.out.println("d15 = "+ d15);
//    messages.put(1L, new Message(1, "Hokums Pokums", d14, "Billy"));
//    messages.put(2L, new Message(2, "Frikas Frekus", d15, "Ellie"));
//    messages.put(3L, new Message(3, "Whos there", d14, "Ellie"));
//    messages.put(4L, new Message(4, "Tennis Anyone", d15, "Billy"));
//    messages.put(5L, new Message(5, "Anyone Home", new Date(), "Ellie"));
@GET
public List<Comment> getAllComments(@PathParam("messageId") long messageId) {
    return commentService.getAllComments(messageId);
}

    @POST
    public Comment addComment(@PathParam("messageId") long messageId, Comment comment) {
        return commentService.addComment(messageId, comment);
    }

    @PUT
    @Path("/{commentId}")
    public Comment updateComment(@PathParam("messageId") long messageId, @PathParam("commentId") long id, Comment comment) {
        comment.setId(id);
        return commentService.updateComment(messageId, comment);
    }

    @DELETE
    @Path("/{commentId}")
    public void deleteComment(@PathParam("messageId") long messageId, @PathParam("commentId") long commentId) {
        commentService.removeComment(messageId, commentId);
    }


    @GET
    @Path("/{commentId}")
    public Comment getMessage(@PathParam("messageId") long messageId, @PathParam("commentId") long commentId) {
        return commentService.getComment(messageId, commentId);
    }

}
