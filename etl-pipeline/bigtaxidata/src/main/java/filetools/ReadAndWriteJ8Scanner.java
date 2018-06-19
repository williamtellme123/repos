package filetools;


import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

/**
 *

 Scanner is used for parsing tokens from the contents of the stream while BufferedReader just reads the stream and does not do any special parsing.

 In fact you can pass a BufferedReader to a scanner as the source of characters to parse.




*/

public class ReadAndWriteJ8Scanner {

    public static void main(String args[]) throws FileNotFoundException {

        System.out.println("Working Directory = " +
                System.getProperty("user.dir"));
        // Create the file object
        File fileObj = new File("./bigtaxidata/src/main/resources/data.txt");

        // Scanner object for reading the file
        Scanner scnr = new Scanner(fileObj);


        // Reading each line of file using Scanner class
        while(scnr.hasNextLine()){
            String strLine = scnr.nextLine();
            //print data on console
            System.out.println(strLine);
        }
    }

}