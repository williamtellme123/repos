package database;


import model.Message;
import model.Profile;

import java.util.HashMap;
import java.util.Map;

// stub in Memory database
// any object can access this
public class DatabaseClass {



    private static Map<Long, Message> messages = new HashMap();
    private static Map<String, Profile> profiles = new HashMap();


    public static Map<Long, Message> getMessages(){
        return messages;
    }

    public static Map<String, Profile> getProfiles(){
        return profiles;
    }


}
