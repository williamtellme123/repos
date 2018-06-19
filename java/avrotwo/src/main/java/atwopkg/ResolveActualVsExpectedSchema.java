package atwopkg;

public class ResolveActualVsExpectedSchema {


/*
    http://avro.apache.org/docs/1.7.5/api/java/org/apache/avro/generic/GenericDatumReader.html
    http://www.programcreek.com/java-api-examples/index.php?api=org.apache.avro.io.ResolvingDecoder
    imported above: https://github.com/justinsb/avro/blob/master/src/java/org/apache/avro/generic/GenericDatumReader.java
    http://www.programcreek.com/java-api-examples/index.php?api=org.apache.avro.Schema
 */
//
//    //
//    public ResolvingDecoder getResolver(Schema actual,Schema expected) throws IOException {
//        Thread currThread=Thread.currentThread();
//        ResolvingDecoder resolver;
//        // must get these form environment
//        Thread creator;
//        ResolvingDecoder creatorResolver = null;
//        if (currThread == creator && creatorResolver != null) {
//            return creatorResolver;
//        }
//        Map<Schema,ResolvingDecoder> cache=RESOLVER_CACHE.get().get(actual);
//        if (cache == null) {
//            cache=new WeakIdentityHashMap<Schema,ResolvingDecoder>();
//            RESOLVER_CACHE.get().put(actual,cache);
//        }
//        resolver=cache.get(expected);
//        if (resolver == null) {
//            resolver= DecoderFactory.get().resolvingDecoder(Schema.applyAliases(actual,expected),expected,null);
//            cache.put(expected,resolver);
//        }
//        if (currThread == creator) {
//            creatorResolver=resolver;
//        }
//        return resolver;
//    }

}
