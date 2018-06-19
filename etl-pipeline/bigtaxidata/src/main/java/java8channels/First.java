package java8channels;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.*;
import java.nio.file.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;


/**
 *
 *     2.27 GB File Copy
 *
 *     elapsedTime minutes: 0  seconds: 0  ms: 11
 *
 *
 */

public class First {

    public static void main(String[] args) throws IOException {


        Date date = new Date();
        String strDateFormat = "hh:mm:ss a";
        DateFormat dateFormat = new SimpleDateFormat(strDateFormat);
        String formattedDate = dateFormat.format(date);
        System.out.println("Current time: " + formattedDate);
        long startTime = System.currentTimeMillis();
        System.out.println("startTime: " + startTime);


        // File copy using Buffered streams
        Path fileOut2 = Paths.get("Twitter.data_copy");
        try {
            Files.deleteIfExists(fileOut2);
        } catch (NoSuchFileException ex1) {
            System.err.format("%s: no such" + " file or directory%n", ex1);
        } catch (DirectoryNotEmptyException ex2) {
            System.err.format("%s not empty%n", ex2);
        } catch (IOException x) {
            System.err.println(x);
        }

        ScatteringByteChannel src;
        FileInputStream fis = new FileInputStream("./bigtaxidata/src/main/resources/Twitter.data");
        src = (ScatteringByteChannel) Channels.newChannel(fis);
        ByteBuffer buffer1 = ByteBuffer.allocateDirect(5);
        ByteBuffer buffer2 = ByteBuffer.allocateDirect(3);
        ByteBuffer[] buffers = {buffer1, buffer2};
        src.read(buffers);

        buffer1.flip();
        while (buffer1.hasRemaining())
            System.out.println(buffer1.get());
        System.out.println();
        buffer2.flip();
        while (buffer2.hasRemaining())
            System.out.println(buffer2.get());
        buffer1.rewind();
        buffer2.rewind();
        GatheringByteChannel dest;
        FileOutputStream fos = new FileOutputStream("./bigtaxidata/src/main/resources/Twitter.data_copy");
        dest = (GatheringByteChannel) Channels.newChannel(fos);
        buffers[0] = buffer2;
        buffers[1] = buffer1;
        dest.write(buffers);

        long elapsedTime = System.currentTimeMillis() - startTime;
        int seconds = (int) ((elapsedTime / 1000) % 60);
        int minutes = (int) ((elapsedTime / 1000) / 60);
        System.out.println("elapsedTime minutes: " + minutes + "  seconds: " + seconds);

        System.out.println("elapsedTime  " + elapsedTime + " ms");


//    static void copy(ReadableByteChannel src, WritableByteChannel dest)
//            throws IOException
//    {
//        ByteBuffer buffer = ByteBuffer.allocateDirect(2048);
//        while (src.read(buffer) != -1)
//        {
//            buffer.flip();
//            dest.write(buffer);
//            buffer.compact();
//        }
//        buffer.flip();
//        while (buffer.hasRemaining())
//            dest.write(buffer);
//    }
//    static void copyAlt(ReadableByteChannel src, WritableByteChannel dest)
//            throws IOException {
//        ByteBuffer buffer = ByteBuffer.allocateDirect(2048);
//        while (src.read(buffer) != -1)
//    }
    }// eom
}//eoc