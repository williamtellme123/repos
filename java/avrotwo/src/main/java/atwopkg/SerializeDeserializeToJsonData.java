package atwopkg;


import org.apache.avro.Schema;
import org.apache.avro.generic.GenericData;
import org.apache.avro.generic.GenericDatumReader;
import org.apache.avro.generic.GenericRecord;
import org.apache.avro.io.*;
import org.apache.avro.reflect.ReflectData;
import org.apache.avro.reflect.ReflectDatumWriter;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.EOFException;
import java.io.IOException;

import static junit.framework.Assert.assertEquals;

public class SerializeDeserializeToJsonData{
    public SerializeDeserializeToJsonData() {
    }

    public void testSerializeToJson() throws Exception {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        Schema schema = ReflectData.get().getSchema(LogEntry3.class);

        Encoder encoder = new EncoderFactory().jsonEncoder(schema, outputStream);
        DatumWriter<LogEntry3> writer = new ReflectDatumWriter<>(schema);

        LogEntry3 entry1 = new LogEntry3("Jeff", "readme.md", "192.168.4.1");
        LogEntry3 entry2 = new LogEntry3("John", "readme.txt", "192.168.4.2");

        writer.write(entry1, encoder);
        writer.write(entry2, encoder);
        encoder.flush();
        System.out.println("");

        System.out.println(new String(outputStream.toByteArray()));
    }



    //    First, there is no explicit separator between every JSON record.
    //          The Avro JSON decoder can decode the JSON data in the form of stream.
    //          Very helpful if need to deserialize a whole bunch of JSON records
    //          without any explicit separator between records.

    //    Second, when parsing the JSON data, the generic reader
    //          DatumReader<GenericRecord> instead of specific reader must be used:
    //          DatumReader<LogEntry3>.

    public void testDeserializeFromJson() throws Exception {
        String input = "{\"name\":\"JacksonianTwoTone\",\"resource\":\"readme.md\",\"ip\":\"192.168.4.1\"}" +
                "{\"name\":\"CharlieBrown\",\"resource\":\"readme.txt\",\"ip\":\"192.168.4.2\"}";

        ByteArrayInputStream inputStream = new ByteArrayInputStream(input.getBytes());
        Schema schema = ReflectData.get().getSchema(LogEntry3.class);

        JsonDecoder decoder = new DecoderFactory().jsonDecoder(schema, inputStream);
        DatumReader<GenericRecord> reader = new GenericDatumReader<>(schema);
        GenericRecord entry;
        while (true) {
            try {
                entry = reader.read(null, decoder);
                System.out.println(entry);
            } catch (EOFException exception) {
                break;
            }
        }
    }
    public void testSerializeArray() throws IOException {
        Schema schema = Schema.createArray(ReflectData.get().getSchema(LogEntry3.class));
        GenericData.Array<LogEntry3> logs = new GenericData.Array<>(2, schema);
        logs.add(new LogEntry3("LarryTheLip", "Longtimenohearbucko", "192.168.5.1"));
        logs.add(new LogEntry3("TinyTimbornia", "Thereisaflyinmysoup", "192.168.5.2"));

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        Encoder encoder = new EncoderFactory().jsonEncoder(schema, outputStream);
        DatumWriter<GenericData.Array<LogEntry3>> writer = new ReflectDatumWriter<>(schema);
        writer.write(logs, encoder);
        encoder.flush();
        System.out.println("testSerializeArray");
        System.out.println(new String(outputStream.toByteArray()));
    }

    public void testDeserializeArray() throws Exception {
        Schema schema = Schema.createArray(ReflectData.get().getSchema(LogEntry3.class));
        String input = "[{\"name\":\"JockstrapJimmy\",\"resource\":\"daheckIwill\",\"ip\":\"192.168.5.1\"},{\"name\":\"DowntownJohnnny\",\"resource\":\"Waddyagonnado\",\"ip\":\"192.168.5.2\"}]";
        Decoder decoder = new DecoderFactory().jsonDecoder(schema, input);
        DatumReader<GenericData.Array<GenericData.Record>> reader = new GenericDatumReader<>(schema);
        GenericData.Array<GenericData.Record> logs = reader.read(null, decoder);
        GenericData.Record entry = logs.get(0);
        System.out.println("testDeserializeArray");
        System.out.println(entry);

    }

    public void testDeserializeJsonStream() throws Exception {
        Schema schema = Schema.createArray(ReflectData.get().getSchema(LogEntry3.class));
        String inputLikeStream = "[{\"name\":\"Jeff\",\"resource\":\"readme.md\",\"ip\":\"192.168.5.1\"},{\"name\":\"John\",\"resource\":\"readme.txt\",\"ip\":\"192.168.5.2\"}][{\"name\":\"Joe\",\"resource\":\"readme.md\",\"ip\":\"192.168.5.3\"},{\"name\":\"James\",\"resource\":\"readme.txt\",\"ip\":\"192.168.5.4\"}]";
        Decoder decoder = new DecoderFactory().jsonDecoder(schema, inputLikeStream);
        DatumReader<GenericData.Array<LogEntry3>> reader = new GenericDatumReader<>(schema);
        GenericData.Array<LogEntry3> parsedRecords;
        int count = 0;
        while (true) {
            try {
                // We can iterate the parsedRecords to get every individual record
                parsedRecords = reader.read(null, decoder);
                System.out.println("parsedRecords------->" + parsedRecords);
                count += parsedRecords.size();
                System.out.println("count "+ count);
            } catch (EOFException e) {
                break;
            }
        }
        assertEquals(count, 4);
    }


}
