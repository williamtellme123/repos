package filetools;

import java.io.File;

/**
 * Created by billy on 4/13/16.
 */
public class ListFiles {
    public static void main(String[] argv) {

        System.out.println("-------- Get list of local directory ------------");
        System.out.println("This is the list");

        File directory = new File("./etc");
        //get all the files from a directory
        File[] fList = directory.listFiles();
        for (File file : fList) {
            System.out.println(file.getName());
        }

    }
}
