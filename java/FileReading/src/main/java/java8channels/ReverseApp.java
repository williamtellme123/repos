package main.java.java8channels;

import java.io.*;


public class ReverseApp {
    public static void main(String[] args) throws IOException {
//        File file = new File("/Users/<username>/Documents/file1.txt");
//        RandomAccessFile raf = new RandomAccessFile(file, "rw");
//        for (int i = 0; i <= 10; i++) {
//            // Adding line from 1 to 10
//            raf.writeBytes("Adding Line " + i + "\n");
//        }
//        raf.close();

        // Simple way to read file without Reversing
        FileReader logReader = new FileReader("/Users/<username>/Documents/file1.txt");
        BufferedReader buffer = new BufferedReader(logReader);
        System.out.println("Simple way to read file without Reversing - from 1 to 10");
        for (String line1 = buffer.readLine(); line1 != null; line1 = buffer.readLine()) {
            System.out.println(line1);
        }

//        // Reading file in reverse order.. Will return line from 10 to 1
//        ReverseLineReader reader = new ReverseLineReader
//                file, "UTF-8");
//        String line;
//        System.out.print("\nReading file in reverse order - from 10 to 1");
//        while ((line = reader.readLine()) != null) {
//            System.out.println(line);
//        }
    }
}
