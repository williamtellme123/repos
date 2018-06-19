package atwopkg;


import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.apache.avro.Schema;
import org.apache.avro.file.DataFileReader;
import org.apache.avro.file.SeekableFileInput;
import org.apache.avro.generic.GenericDatumReader;
import org.apache.avro.generic.GenericRecord;
import org.apache.avro.io.DatumReader;

import java.io.File;
import java.io.FileDescriptor;
import java.io.RandomAccessFile;

public class DeserializeUsingAvroBinaryForSchema {
    public DeserializeUsingAvroBinaryForSchema() {
    }


    // Prettify JSON Utility
    public static String crunchifyPrettyJSONUtility(String simpleJSON) {
        JsonParser crunhifyParser = new JsonParser();
        JsonObject json = crunhifyParser.parse(simpleJSON).getAsJsonObject();

        Gson prettyGson = new GsonBuilder().setPrettyPrinting().create();
        String prettyJson = prettyGson.toJson(json);

        return prettyJson;
    }

    public void testDeserializeAvroBinary() throws Exception {
        RandomAccessFile raf = new RandomAccessFile("/Users/billy/repos/javawork/avrotwo/logonthefly.avro", "rw");
        FileDescriptor fd = raf.getFD();
        DataFileReader<GenericRecord> reader = new DataFileReader<GenericRecord>(new SeekableFileInput(fd), new GenericDatumReader<GenericRecord>());
        Schema schema = reader.getSchema();

        String prettyJson = crunchifyPrettyJSONUtility(schema.toString());
        System.out.println("\nPretty JSON Result:\n" + prettyJson);


        DatumReader<GenericRecord> datumReader = new GenericDatumReader<>(schema);
        File file = new File("/Users/billy/repos/javawork/avrotwo/logonthefly.avro");
        DataFileReader<GenericRecord> dataFileReader = new DataFileReader<>(file, datumReader);
        String prettyJRecord = null;
        GenericRecord entry = null;
        while (dataFileReader.hasNext()) {
            entry = dataFileReader.next(entry);
            prettyJRecord = crunchifyPrettyJSONUtility(entry.toString());
            System.out.println(prettyJRecord);
        }
        dataFileReader.close();
    }


}
