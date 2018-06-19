package atwopkg;


import org.apache.avro.Schema;
import org.apache.avro.file.DataFileReader;
import org.apache.avro.file.DataFileWriter;
import org.apache.avro.generic.GenericData;
import org.apache.avro.generic.GenericDatumReader;
import org.apache.avro.generic.GenericDatumWriter;
import org.apache.avro.generic.GenericRecord;
import org.apache.avro.io.DatumReader;
import org.apache.avro.io.DatumWriter;
import org.apache.avro.reflect.ReflectData;

import java.io.File;
import java.io.IOException;


public class SerializationDeserializationNoCodeGen {


    SerializationDeserializationNoCodeGen(){}

    // From the example, we can see that we don’t need to define any external
    // schema file and no external Java classed are generated
    public void testSerializeOnFly(String schemaDesc) throws IOException {
        Schema schema = new Schema.Parser().parse(schemaDesc);
        GenericRecord entry1 = new GenericData.Record(schema);
        entry1.put("name", "Jeffrey");
        entry1.put("resource", "README");
        entry1.put("ip", "192.168.2.1");

        GenericRecord entry2 = new GenericData.Record(schema);
        entry2.put("name", "Johnson");
        entry2.put("resource", "readme.markdown");
        entry2.put("ip", "192.168.2.2");

        DatumWriter<GenericRecord> datumWriter = new GenericDatumWriter<>(schema);
        DataFileWriter<GenericRecord> dataFileWriter = new DataFileWriter<>(datumWriter);
        File file = new File("/Users/billy/repos/javawork/avrotwo/logonthefly");
        dataFileWriter.create(schema, file);

        dataFileWriter.append(entry1);
        dataFileWriter.append(entry2);
        dataFileWriter.close();
    }

    void testGetSchemaFromJsonFileOnDiskThenDeSerializeBinaryFile() throws IOException {
        // deserializing
        Schema schema = new Schema.Parser().parse(new File("/Users/billy/repos/javawork/avrotwo/LogEntry2.avsc"));
        DatumReader<GenericRecord> datumReader = new GenericDatumReader<>(schema);
        File file = new File("/Users/billy/repos/javawork/avrotwo/logonthefly");
        DataFileReader<GenericRecord> dataFileReader = new DataFileReader<>(file, datumReader);
        GenericRecord entry = null;
        while (dataFileReader.hasNext()) {
            entry = dataFileReader.next(entry);
            System.out.println(entry);
        }
        dataFileReader.close();
    }

    public void testGetSchemaFromClassThenDeSerializeBinaryFile(){

        Schema schema = ReflectData.get().getSchema(LogEntry3.class);

        DatumReader<GenericRecord> datumReader = new GenericDatumReader<>(schema);
        File file = new File("/Users/billy/repos/javawork/avrotwo/logonthefly");
        DataFileReader<GenericRecord> dataFileReader = null;
        GenericRecord entry = null;
        try {
            dataFileReader = new DataFileReader<>(file, datumReader);
        } catch (IOException e) {
            e.printStackTrace();
        }

        while (dataFileReader.hasNext()) {
            try {
                entry = dataFileReader.next(entry);
            } catch (IOException e) {
                e.printStackTrace();
            }
            System.out.println(entry);
        }
        try {
            dataFileReader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


}
