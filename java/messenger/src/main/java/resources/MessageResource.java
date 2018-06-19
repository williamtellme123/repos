package resources;

import model.Message;
import services.MessageService;

import javax.ws.rs.*;
import javax.ws.rs.core.*;
import java.net.URI;
import java.net.URISyntaxException;


 // REST API URI maps to the class
// JERSEY Gets the path of the class first.
// THen searches for HTTP method and concatenates the path from that method
@Path("/messages")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class MessageResource {

    MessageService messageService = new MessageService();

    private String getUriForComments(UriInfo uriInfo, Message message) {
         URI uri = uriInfo.getBaseUriBuilder()
                .path(MessageResource.class)
                // takes 2 parameters
                // className       and     methodname
                .path(MessageResource.class, "getCommentResource")
                .path(CommentResource.class)
                //.resolveTemplate("messageId", message.getId())
                .build();
        return uri.toString();
    }

    // Comments are sub resources so must handle differently
//    private String gerUriForComments(UriInfo uriInfo, Message message){
//            /*
//                so what we need is what Jersey does when it maps to comments
//                start by getting the root resource
//                @Path("/messages")
//                then we need the Uri that is mapped to the method
//
//                        @Path("/{messageId}/comments")
//                        public CommentResource getCommentResource(){
//                        return new CommentResource();
//            */
//
//        URI uri = uriInfo.getAbsolutePathBuilder()
//                .path(MessageResource.class)
//                .path(MessageResource.class, "getCommentResource")
//                .path(CommentResource.class)
//                .resolveTemplate("messageId", message.getId())
//                .build();
//        return uri.toString();
//    }




//            String uri  = uriInfo.getBaseUriBuilder()
//                    //         http://localhost:8080/messenger/webresources/
//                    // CLASS Level
//                    .path(MessageResource.class)
//                            // Gives what is annotated at class MessageResource REMEMBER THIS IS SUBRESOURCE NOT ROOT RESOURCE
//                            //
//                            // find the path to the class and the method
//                    // METHOD LEVEL     BUT THIS CONTAINS A {MessageID} variable
//                    // In order to do this use a method called RESOLVE TEMPLATE
//                    .path(MessageResource.class, "getCommentResource")
//                    // SUB RESOURCE LEVEL
//                    .path(CommentResource.class)
//                    .resolveTemplate("messageId", message.getId())
//                    .build()
//                    .toString();
//            return uri;
//}


    //    --------------------------------------------------------------------------
    //    KNOWN AS CONTROLLER METHOD RETURN NAVIGABLE JSON
    //    --------------------------------------------------------------------------
    //    http://localhost:8080/messenger/webresources/messages/1    GET
        @GET
        @Path("/{messageId}")
        public Message getMessage(@PathParam("messageId") long Id,
                                  @Context UriInfo uriInfo)
        {
            Message message = messageService.getMessage(Id);
            message.addLink(gerUriForSelf(uriInfo, message) ,"self");
            message.addLink(gerUriForProfile(uriInfo, message) ,"profile");
            // give a link so user can find all comments to this message
            message.addLink(getUriForComments(uriInfo, message), "comments");
            return message;
        }



        private String gerUriForSelf(UriInfo uriInfo, Message message)
        {
            String uri =

                    uriInfo.getBaseUriBuilder()
                            //         http://localhost:8080/messenger/webresources/
                            .path(MessageResource.class)
                                    // Gives what is annotated at class ProfileResource
                                    //                                                     /messages
                            .path(Long.toString(message.getId()))
                                    //                                                         /{authorName}
                            .build()
                            .toString();
            return uri;
        }

        private String gerUriForProfile(UriInfo uriInfo, Message message)
        {
                String uri =

                         uriInfo.getBaseUriBuilder()
                                 //         http://localhost:8080/messenger/webresources/
                                 .path(ProfileResource.class)
                                 // Gives what is annotated at class MessageResource
                                 //                                                     /profiles
                                 .path(message.getAuthor())
                                 //                                                             /{messageageID}
                                 .build()
                                .toString();
                return uri;
        }







    //    --------------------------------------------------------------------------
    //    KNOWN AS CONTROLLER METHOD RETURN SINGLE ELEMENT: ORIGINAL
    //    --------------------------------------------------------------------------
    //    http://localhost:8080/messenger/webresources/messages/1    GET
    //    @GET
    //    @Path("/{messageId}")
    //    public Message getMessage(@PathParam("messageId") long Id){
    //        Message message = messageService.getMessage(Id);
    //        return message;
    //    }



        //    --------------------------------------------------------------------------
        //    KNOWN AS CONTROLLER METHODS THAT USING A MessageFilterBean
        //    --------------------------------------------------------------------------
        //    @GET
        //    public List<Message> getMessages(@BeanParam MessageFilterBean filterBean)
        //
        //    {
        //        if (filterBean.getYear() > 0)
        //        {
        //            return messageService.getAllMessagesForYear(filterBean.getYear());
        //        }
        //        if (filterBean.getStart()>0 && filterBean.getSize() >= 0)
        //        {
        //            return messageService.getAllMessagesPaginated(filterBean.getStart(), filterBean.getSize());
        //
        //        }
        //        return messageService.getAllMessages();
        //    }

        //    --------------------------------------------------------------------------
        //    KNOWN AS CONTROLLER METHODS THAT CAN INTERPRET QueryParam
        //    --------------------------------------------------------------------------
        //    http://localhost:8080/messenger/webresources/messages?year=2014
        //    http://localhost:8080/messenger/webresources/messages?start=0&size=2
        //
        //    @GET
        //    public List<Message> getMessages(@QueryParam("year") int year,
        //                                     @QueryParam("start") int start,
        //                                     @QueryParam("size") int size)
        //    {
        //        if (year > 0)
        //        {
        //            System.out.println("year > 0");
        //            return messageService.getAllMessagesForYear(year);
        //        }
        //        else if (start>= 0 && size > 0)
        //        {
        //            System.out.println("start = " + start + "size = " + size);
        //            return messageService.getAllMessagesPaginated(start, size);
        //
        //        }
        //        else return messageService.getAllMessages();
        //    }

    //    --------------------------------------------------------------------------
    //    KNOWN AS CONTROLLER METHODS NO PARAMS
    //    --------------------------------------------------------------------------
    //    http://localhost:8080/messenger/webresources/messages
    //
    //        @GET
    //        public List<Message> getMessages()
    //        {
    //            return messageService.getAllMessages();
    //        }


    //    --------------------------------------------------------------------------
    //    KNOWN AS CONTROLLER METHODS ONE PARAM
    //    --------------------------------------------------------------------------
    //    http://localhost:8080/messenger/webresources/messages?year=2014
    //
    //    @GET
    //    public List<Message> getMessages(@QueryParam("year") int year)
    //    {
    //        if (year > 0)
    //        {
    //            return messageService.getAllMessagesForYear(year);
    //        }
    //        return messageService.getAllMessages();
    //    }



    //    --------------------------------------------------------------------------
    //    SUB RESOURCE get all Comments on a message
    //    --------------------------------------------------------------------------
    //    http://localhost:8080/messenger/webresources/messages/1/comments    GET
    //    But this is messy
    //    @GET
    //    @Path("/{messageId}/comments")
    //    public Message deleteMessage(@PathParam("messageId") Long Id) {
    //      return messageService.removeMessage(Id);
    //    }
    //    Instead when someone wants all the comments on a message
    //    we pass the control to the CommentResource instead of executing method here



    //    --------------------------------------------------------------------------
    //    KNOWN AS CONTROLLER METHOD CREATE NEW ELEMENT
    //    --------------------------------------------------------------------------
    //    http://localhost:8080/messenger/webresources/messages/1    POST
    //    Place json element in raw
    //    Choose Header and insert Content-Type
    //    Choose Value and insert application/json
    //    ensure you choose POST
    //    and in Raw place a new json message
    //    {
    //        "author": "Billy",
    //        "created": "2014-06-02T14:33:00.866-05:00",
    //        "message": "Hokums Pokums"
    //    }
    // Typical POST
    //    @POST
    //    public Message addMessage(Message message){
    //        messageService.addMessage(message);
    //        return message;
    //    }
    //
    //
    //  REST Web Services 26 - Sending Status Codes and Location Headers
    //  IF YOU Want to return a location, entity or build
    //  https://www.youtube.com/watch?v=HEabElNrfbo
    @POST
    public Response addMessage(Message message, @Context UriInfo uriInfo) throws URISyntaxException {
        Message newMessage = messageService.addMessage(message);
        String newId = String.valueOf(newMessage.getId());
        URI uri = uriInfo.getAbsolutePathBuilder().path(newId).build();
        return Response.created(uri)
                       .entity(newMessage)
                       .build();
    }


    //    --------------------------------------------------------------------------
    //    KNOWN AS CONTROLLER METHOD UPDATE EXISTING ELEMENT
    //    --------------------------------------------------------------------------
    //    http://localhost:8080/messenger/webresources/messages/1    PUT
    //    Place json element in raw
    @PUT
    @Path("/{messageId}")
    public Message updateMessage(@PathParam("messageId") long Id, Message message)
    {
        message.setId(Id);
        return messageService.updateMessage(message);
    }

    //    --------------------------------------------------------------------------
    //    KNOWN AS CONTROLLER METHOD DELETE EXISTING ELEMENT
    //    --------------------------------------------------------------------------
    //    http://localhost:8080/messenger/webresources/messages/1    DELETE
    //    Place json element in raw
    @DELETE
    @Path("/{messageId}")
    public Message deleteMessage(@PathParam("messageId") Long Id) {
        return messageService.removeMessage(Id);
    }

    // NO HTTP Method means all HTTP methods IFF the path matches
    // So this passes the control to the CommentResource and
    // all comment methods are in their own place
    @Path("/{messageId}/comments")
    public CommentResource getCommentResource() {

        return new CommentResource();
    }
} // End of public class MessageResource


