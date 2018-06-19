package resources;

import model.Profile;
import services.ProfileService;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

//URI maps to the class
@Path("/profiles")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class ProfileResource {

    ProfileService profileService = new ProfileService();

    // method maps to an HTTP method
    // describes type
    @GET
    public List<Profile> getProfiles()
    {
        return profileService.getAllProfiles();
    }
    @GET
    @Path("/{profileName}")
    public Profile getProfile(@PathParam("profileName") String profileName){
        return profileService.getProfile(profileName); }
    @POST
    public Profile addProfile(Profile profile){
        return profileService.addProfile(profile); }
    @PUT
    @Path("/{profileName}")
    public Profile updateMessage(@PathParam("profileName") String profileName, Profile profile){
        profile.setProfileName(profileName);
        return profileService.updateProfile(profile); }
    @DELETE
    @Path("/{profileName}")
    public void deleteMessage(@PathParam("profileName") String profileName) {
        profileService.removeProfile(profileName); }
}
