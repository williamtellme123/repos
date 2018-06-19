package filetools;


import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;

/**
 INPUT STREAM
        Target thread receives data on PipedInputStream(Synchrponized) sends on PipedOutputStream
 FILTER STREAMS
        Agg bytes into meaningful primitive-type units
 DATA STREAMS
        DataInputStream fast readBoolean, readInt ...
        DataInputStream writeBooolean, writeInt ...
 BUFFERRED STREAMS
        I/O Enhancement
        Has flush method

 BUFFEREDREADER (larger buffer than scanner)
        Simple character stream I/O

        USE CASE
            Simple log reader
            Accept user input line-by-line to add to file

        CONSTRUCTOR
            By default buffer size of 8192 chars for reading data into buffer
            Bufferize can be used to read data like characters, arrays and lines
            Construct BufferedReader w/ DataInputStream arrg
                 BufferedReader(Reader in) is used for the default buffer size
                 BufferedReader(Reader in, int sz) takes the buffer size as parameter

        METHODS
            java.io.BufferedReader.read()       : next one character
            java.io.BufferedReader.readline()   : next one line


        NOTES:
            Each invocation of read() or readLine() would otherwise cause bytes to be
                    Read directly from the file
                    Converted into characters
                    Then returned

            Efficiency wrap FileReader in BufferedReader
            Synchronized so threadsafe

     SCANNER
        Keyboard, file, disk
        Scanner in = new Scanner(System.in)

        USE CASE
            XML parser
            Accept user input as cmd w/ n-options for diff operations

        CONSTRUCTOR
            Scanner(File source)
            Scanner(File source, String charsetName)
            Scanner(InputStream source)
            Scanner(InputStream source, String charsetName)
            Scanner(Readable source)
            Scanner(ReadableByteChannel source)
            Scanner(ReadableByteChannel source, String charsetName)

            Scanner(String source): values scanned from specified string

        METHODS
            nextline:      line
            next:          word
            nextDouble:    double
            hasNext():     boolean
            findInLine(P): ignores delimiter
            findInLine(S): ignores delimiter
            findInHorizon: ignores delimiter

            Same as BufferedReader plus

            PARSES (w/ regex) : Stream for primitive types/strings
            TOKENIZES : Delimiter of your choice
            FORWARDS : scanning of stream disregarding the delimiter

        NOTES:
            Scanner NOT THREAD SAFE, IT HAS TO BE EXTERNALLY SYNCHRONIZED
 */

public class ReadAndWriteJ8BufferedReader {
    public static void main(String[] args) throws Exception {

        try{
            //Open input stream for reading the text file MyTextFile.txt
            InputStream is = new FileInputStream("./bigtaxidata/src/main/resources/data.txt");

            // create new input stream reader
            InputStreamReader instrm = new InputStreamReader(is);

            // Create the object of BufferedReader object
            BufferedReader br = new BufferedReader(instrm);

            String strLine;

            // Read one line at a time
            while((strLine = br.readLine()) != null)
            {
                // Print line
                System.out.println(strLine);
            }

        }catch(Exception e){
            e.printStackTrace();
        }
    }
}