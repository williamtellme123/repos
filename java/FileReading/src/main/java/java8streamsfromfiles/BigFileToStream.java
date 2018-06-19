package java8streamsfromfiles;

import java.io.*;
import java.nio.file.Files;

public class BigFileToStream {



    public static void main(String[] args) throws IOException {
/**
        String fileName = "data.txt";
        List<String> list = new ArrayList<>();

        try (BufferedReader br = Files.newBufferedReader(Paths.get(fileName))) {
            //br returns as stream and convert it into a List
            list = br.lines().collect(Collectors.toList());
        } catch (IOException e) {
            e.printStackTrace();
        }
        list.forEach(System.out::println);


        try (Stream<String> stream = Files.lines(Paths.get(fileName))) {
            list = stream
                    .filter(line -> !line.startsWith("line3"))
                    .map(String::toUpperCase)
                    .collect(Collectors.toList());

        } catch (IOException e) {
            e.printStackTrace();
        }

        list.forEach(System.out::println);

        // READ FILE USING LINEs() & STREAM APPROACH
        Stream<String> myStream = null;
        try{
            myStream = Files.lines(Paths.get("data.txt"));
        } catch (IOException e){
            e.printStackTrace();
        }
        myStream.forEach(System.out::println);

        List<String> myList = new ArrayList<>();
        BufferedReader myBufferredReader = null;
        try{
            // new BffferredReader opens file for reading
            myBufferredReader = Files.newBufferedReader(Paths.get("Twitter.data"));
        } catch (IOException e){
            e.printStackTrace();
        }
        myList = myBufferredReader.lines().collect(Collectors.toList());
        // forEach: performs the given action for each element of the Iterable until all elements have been processed or the
        // action throws an exception.
        myList.forEach(System.out::println);

 */
        // File copy using Buffered streams
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        FileInputStream fis = null;
        FileOutputStream fos = null;

        try {

            fis = new FileInputStream("Twitter.data");
            bis = new BufferedInputStream( fis);
            fos = new FileOutputStream("Twitter.data_copy");
            bos = new BufferedOutputStream(fos);
            int b;
            while ((b = bis.read()) != -1) {

                bos.write(b);
            }
            bos.flush();
        }
        catch(IOException ex) {
            System.err.println(ex.getMessage());
        }
        finally {
            if(fis!=null) fis.close();
            if(bis!=null) bis.close();
            if(fos!=null) fos.close();
            if(bos!=null) bos.close();
        }

//        Files.lines(new File("exchange1970-1995.csv").toPath())
//                .map(s -> s.trim())
//                .filter(s -> !s.isEmpty())
//                .limit(10)
//                .forEach(System.out::println);
//
//        Files.lines(new File("Twitter.data").toPath())
//                .map(s -> s.trim())
//                .filter(s -> !s.isEmpty())
//                .limit(10)
//                .forEach(System.out::println);




    } // end of main
}
