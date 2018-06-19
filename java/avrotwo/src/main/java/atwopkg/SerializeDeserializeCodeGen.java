package atwopkg;

import java.io.IOException;
import java.io.File;

import avrotwo.atwo.Book;

import org.apache.avro.file.DataFileReader;
import org.apache.avro.file.DataFileWriter;

import org.apache.avro.io.DatumReader;
import org.apache.avro.io.DatumWriter;

import org.apache.avro.specific.SpecificDatumReader;
import org.apache.avro.specific.SpecificDatumWriter;


public class SerializeDeserializeCodeGen {


    SerializeDeserializeCodeGen(){

    }
    void testSerializeBooks() throws IOException {
        Book book1 = Book.newBuilder().setId(123).setName("Programming is fun").setCategory("Fiction").build();
        Book book2 = new Book("Some book", 456, "Horror");
        Book book3 = new Book();
        book3.setName("And another book");
        book3.setId(789);
        File store = new File("/Users/billy/repos/javawork/avroone/log");
        // serializing
        System.out.println("serializing books to temp file: " + store.getPath());
        DatumWriter<Book> bookDatumWriter = new SpecificDatumWriter<Book>(Book.class);
        DataFileWriter<Book> bookFileWriter = new DataFileWriter<Book>(bookDatumWriter);
        bookFileWriter.create(book1.getSchema(), store);
        bookFileWriter.append(book1);
        bookFileWriter.append(book2);
        bookFileWriter.append(book3);
        bookFileWriter.close();
    }
    void testDeSerializeBooks() throws IOException {
        // deserializing

        DatumReader<Book> bookDatumReader = new SpecificDatumReader<>(Book.class);
        File store = new File("/Users/billy/repos/javawork/avroone/log");
        DataFileReader<Book> dataFileReader = new DataFileReader<Book>(store,bookDatumReader);
        Book b = null;
        while (dataFileReader.hasNext())
        {
            Book b1 = dataFileReader.next();
            System.out.println("deserialized from file: " + b1);
        }
        dataFileReader.close();
    }

    public void genCode(){
        System.out.println("Serialize and Deserialize by generating code");

        try {
            this.testSerializeBooks();
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("Serialized!");
        try {
            this.testDeSerializeBooks();

        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("DeSerialized!");
    }




}


