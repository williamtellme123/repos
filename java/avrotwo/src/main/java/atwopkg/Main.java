package atwopkg;


public class Main {


    public static void main(String[] args) {

        // WITH CODE GENERATED
        // Serialize and Deserialize after using mvn to create the code based on
        // a svsc schema file in the package
        // this is with code generation
        //      SerializeDeserializeCodeGen withCodeGeneration = new SerializeDeserializeCodeGen();
        //      withCodeGeneration.genCode();



        // WITHOUT CODE GENERATION
        // SerializationDeserializationNoCodeGen withOutCodeGeneration = new SerializationDeserializationNoCodeGen();

        // 1. Use String to create schema
        //        try {
        //            withOutCodeGeneration.testGetSchemaFromJsonFileOnDiskThenDeSerializeBinaryFile();
        //        } catch (IOException e) {
        //            e.printStackTrace();
        //        }

        // 2. Use Class to create schema
        //        withOutCodeGeneration.testGetSchemaFromClassThenDeSerializeBinaryFile();

        // SERIALIZE TO JSON DATA NOT MY PLAN BUT WAS SHOWN IN EXAMPLE
        // SerializeDeserializeToJsonData s = new SerializeDeserializeToJsonData();
        // 1. SERIALIZE TO JSON
        //            try {
        //                s.testSerializeToJson();
        //            } catch (Exception e) {
        //                e.printStackTrace();
        //            }
        //            try {
        //                s.testDeserializeFromJson();
        //            } catch (Exception e) {
        //                e.printStackTrace();
        //            }
        // 2. SERIALIZE TO ARRAY
        //                try {
        //                    s.testSerializeArray();
        //                } catch (IOException e) {
        //                    e.printStackTrace();
        //                }
        //                try {
        //                    s.testDeserializeJsonStream();
        //                } catch (Exception e) {
        //                    e.printStackTrace();
        //                }

        DeserializeUsingAvroBinaryForSchema d = new DeserializeUsingAvroBinaryForSchema();
        try {
            d.testDeserializeAvroBinary();
        } catch (Exception e) {
            e.printStackTrace();
        }

        GenericDatumReader gdr = new GenericDatumReader();


    }
}
