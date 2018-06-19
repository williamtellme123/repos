package filetools;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class ReadAndWriteBinary {
    public static void main(String[] args) throws IOException {

        FileInputStream fileInputStream = null;
        FileOutputStream fileOutputStream = null;

        try
        {
            //Open the input and out files for the streams
            fileInputStream = new FileInputStream("kitten.jpg");
            fileOutputStream = new FileOutputStream("kitten_copy.jpg");
            int data;

            //Read each byte and write it to the output file
            //value of -1 means end of file
            while ((data = fileInputStream.read()) != -1) {
                fileOutputStream.write(data);
            }
        }
        catch (IOException e)
        {
            //Display or throw the error
            System.out.println("Eorr while execting the program: " + e.getMessage());
        }
        finally
        {
            //Close the resources correctly
            if (fileInputStream != null)
            {
                fileInputStream.close();
            }
            if (fileInputStream != null)
            {
                fileOutputStream.close();
            }
        }

    }

}