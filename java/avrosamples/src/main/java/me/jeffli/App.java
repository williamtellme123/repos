package me.jeffli;


import java.io.IOException;

public class App
{




    public static void main( String[] args )
    {

        System.out.println( "Hello World!" );
        TestAvro t = new TestAvro();

        try {
            t.testSerializeLogEntries();
        } catch (IOException e) {
            e.printStackTrace();
        }

        try {
            t.testDeSerializeLogEntries();
        } catch (IOException e) {
            e.printStackTrace();
        }


    }
}
