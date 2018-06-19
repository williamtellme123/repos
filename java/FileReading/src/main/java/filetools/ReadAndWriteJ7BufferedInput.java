package filetools;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.File;
import java.io.BufferedInputStream;
import java.io.InputStream;

public class ReadAndWriteJ7BufferedInput {

    public static void main(String[] args) throws IOException {

        // find the file size
        File fileHandle = new File("test.jpg");
        long length = fileHandle.length();


        try (

                // Open the input and out files for the streams
                InputStream fileInputStream = new BufferedInputStream(new FileInputStream("kitten.jpg"));
                FileOutputStream fileOutputStream = new FileOutputStream("kitten_copyj8.jpg");
        )
        {
            int data;

            // Read data into buffer and then write to the output file
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileInputStream.read(buffer)) != -1)
            {
                fileOutputStream.write(buffer, 0, bytesRead);
            }

        } // try-with-resource
    }

}
