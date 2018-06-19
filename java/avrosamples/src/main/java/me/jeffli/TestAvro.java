package me.jeffli;

import me.jeffli.avrosamples.model.LogEntry;

import org.apache.avro.file.DataFileWriter;
import org.apache.avro.file.DataFileReader;

import org.apache.avro.io.DatumWriter;
import org.apache.avro.io.DatumReader;

import org.apache.avro.specific.SpecificDatumWriter;
import org.apache.avro.specific.SpecificDatumReader;

import java.io.File;
import java.io.IOException;

public class TestAvro {

    TestAvro(){}

    void testSerializeLogEntries() throws IOException {
        LogEntry entry1 = new LogEntry();
        entry1.setName("Jeff");
        entry1.setResource("readme.txt");
        entry1.setIp("192.168.1.1");

        LogEntry entry2 = new LogEntry();
        entry2.setName("John");
        entry2.setResource("readme.md");
        entry2.setIp("192.168.1.2");

        DatumWriter<LogEntry> logEntryDatumWriter = new SpecificDatumWriter<>(LogEntry.class);
        DataFileWriter<LogEntry> dataFileWriter = new DataFileWriter<>(logEntryDatumWriter);
        File file = new File("/Users/billy/repos/javawork/avrosamples/log");
        dataFileWriter.create(entry1.getSchema(), file);

        dataFileWriter.append(entry1);
        dataFileWriter.append(entry2);

        dataFileWriter.close();
    }


    void testDeSerializeLogEntries() throws IOException {
        DatumReader<LogEntry> logEntryDatumReader = new SpecificDatumReader<>(LogEntry.class);
        File file = new File("/Users/billy/repos/javawork/avrosamples/log");
        DataFileReader<LogEntry> dataFileReader = new DataFileReader<>(file, logEntryDatumReader);
        LogEntry entry = null;
        while (dataFileReader.hasNext()) {
            entry = dataFileReader.next(entry);
            System.out.println(entry);
        }
    }

}
