package main.java.java8readwrite;

import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Copy
{
    public static void main(String[] args)
    {

        //    2.27 GB File Copy
        //    elapsedTime minutes: 100  seconds: 47

        Date date = new Date();
        String strDateFormat = "hh:mm:ss a";
        DateFormat dateFormat = new SimpleDateFormat(strDateFormat);
        String formattedDate = dateFormat.format(date);
        System.out.println("Current time: " + formattedDate);
        long startTime = System.currentTimeMillis();
        System.out.println("startTime: " + startTime);
//        if (args.length != 2)
//        {
//            System.err.println("usage: java Copy srcfile dstfile");
//            return;
//        }

        FileInputStream fis = null;
        FileOutputStream fos = null;
        try
        {
            fis = new FileInputStream("Twitter.data");
            fos = new FileOutputStream("Twitter2.data_copy");
//            fis = new FileInputStream(args[0]);
//            fos = new FileOutputStream(args[1]);
            int b;
            while ((b = fis.read()) != -1)
                fos.write(b);
        }
        catch (FileNotFoundException fnfe)
        {
            System.err.println(args[0] + " could not be opened for input, or "
                    + args[1] + " could not be created for output");
        }
        catch (IOException ioe)
        {
            System.err.println("I/O error: " + ioe.getMessage());
        }
        finally {
            if (fis != null)
                try {fis.close();}
                catch (IOException ioe) {assert false;} // shouldn't happen }
            if (fos != null)
                try {fos.close();}
                catch (IOException ioe) {assert false;} // shouldn't happen }
        }

        long elapsedTime = System.currentTimeMillis() - startTime;
        int seconds = (int) ((elapsedTime / 1000) % 60);
        int minutes = (int) ((elapsedTime / 1000) / 60);
        System.out.println("elapsedTime minutes: " + minutes + "  seconds: " + seconds);
    } // eom
} // eoc