package services;

import database.DatabaseClass;
import model.Profile;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

        // private long id;
        // private String profileName;
        // private String firstName;
        // private String lastName;
        // private Date dateCreated;

public class ProfileService {

    private Map<String, Profile> profiles = DatabaseClass.getProfiles();

    public ProfileService() {
        profiles.put("Billy", new Profile(1L,"BRockets", "billy", "rockets", new Date()));
        profiles.put("Ellie", new Profile(2L,"Ellanorita", "ellie", "rogers", new Date()));
        profiles.put("EE", new Profile(3L,"ee", "elaine", "ponchione", new Date()));
        profiles.put("Toto", new Profile(4L,"Bones", "Ron", "ponchione" , new Date()));
    }

    public List<Profile> getAllProfiles(){

        return new ArrayList<Profile>(profiles.values());
    }

    public Profile getProfile(String profileName){
        return profiles.get(profileName);

    }

    public Profile addProfile(Profile profile){
        profile.setId(profiles.size() + 1);
        profiles.put(profile.getProfileName(),profile);
        return profile;
    }

    public Profile updateProfile(Profile profile){
        if (profile.getId() <= 0 ) {
            return null;
        }
        profiles.put(profile.getProfileName(),profile);
        return profile;
    }

    public Profile removeProfile(String profileName){

        return profiles.remove(profileName);
    }
}




