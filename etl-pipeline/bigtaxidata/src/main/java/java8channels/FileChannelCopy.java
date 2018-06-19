package java8channels;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.nio.file.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 *     2.27 GB File Copy
 *
 *     elapsedTime minutes: 0  seconds: 4
 *
 *
 */


public class FileChannelCopy {

    public static void main(String[] args) {
        Date date = new Date();
        String strDateFormat = "hh:mm:ss a";
        DateFormat dateFormat = new SimpleDateFormat(strDateFormat);
        String formattedDate = dateFormat.format(date);
        System.out.println("Current time: " + formattedDate);
        long startTime = System.currentTimeMillis();
        System.out.println("startTime: " + startTime);

        Path fileOut = Paths.get("Twitter.data_copy");

        try {
            Files.deleteIfExists(fileOut);
            System.out.println("Existing file deleted.");
        } catch (NoSuchFileException x) {
            System.err.format("%s: no such" + " file or directory%n", fileOut);
        } catch (DirectoryNotEmptyException x) {
            System.err.format("%s not empty%n", fileOut);
        } catch (IOException x) {
            // File permission problems are caught here.
            System.err.println(x);
        }


        File file1 = new File("./bigtaxidata/src/main/resources/Twitter.data");
        File file2 = new File("./bigtaxidata/src/main/resources/Twitter.data_copy");
        try {
            fileCopy(file1, file2);
        } catch (IOException e) {
            e.printStackTrace();
        }
        long elapsedTime = System.currentTimeMillis() - startTime;
        int seconds = (int) ((elapsedTime / 1000) % 60);
        int minutes = (int) ((elapsedTime / 1000) / 60);
        System.out.println("elapsedTime minutes: " + minutes + "  seconds: " + seconds);
    } //eom

    // Fastest way to Copy file in Java
    //@SuppressWarnings("resource")
    public static void fileCopy(File in, File out) throws IOException {
        FileChannel inChannel = new FileInputStream(in).getChannel();
        FileChannel outChannel = new FileOutputStream(out).getChannel();
        try {
            // Try to change this but this is the number I tried.. for Windows, 64Mb - 32Kb)
            int maxCount = (64 * 1024 * 1024) - (32 * 1024);
//            int maxCount = (128 * 1024 * 1024) - (64 * 1024);
            long size = inChannel.size();
            long position = 0;
            while (position < size) {
                position += inChannel.transferTo(position, maxCount, outChannel);
            }
            System.out.println("File Successfully Copied..");
        } finally {
            if (inChannel != null) {
                inChannel.close();
            }
            if (outChannel != null) {
                outChannel.close();
            }
        }
    }
}