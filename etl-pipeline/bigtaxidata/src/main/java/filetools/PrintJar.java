package filetools;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Optional;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;


public class PrintJar {
    public static void main(String[] args) throws Exception {
          System.out.println("Working Directory = " +
                 System.getProperty("user.dir"));

        // Search given name in a jar
        // JarFile jarFile = new JarFile(args[0]);

        final String searchName = (args.length >= 2) ? args[1] : "META-INF/MANIFEST.MF";

        // TO RUN IT FROM INTELLIJ
        //        JarFile jarFile =  new JarFile(System.getProperty("user.dir")+ "//connect-runtime-0.9.0.0-cp1.jar");
        JarFile jarFile =  new JarFile(System.getProperty("user.dir")+ "/bigtaxidata/src/main/resources/connect-runtime-0.9.0.0-cp1.jar");



        // final String searchName = (args.length >= 2) ? args[1] :"org/apache/kafka/connect/cli/ConnectDistributed.class";
        // final String searchName = (args.length >= 2) ? args[1] :"SourceFile";

        Optional<JarEntry> searchResult = jarFile
                .stream()
                .filter(e -> e.getName().equals(searchName))
                .findFirst();

        if (!searchResult.isPresent())
            throw new RuntimeException(searchName + " not found!");

        // Print the JarEntry
        JarEntry entry = searchResult.get();
        // try-with-resources statement that declares one or more resources.
        // A resource is an object that must be closed after the program is finished with it.
        // The try-with-resources statement ensures that each resource is closed at the end of the statement.
        // Any object that implements java.lang.AutoCloseable, which includes all objects which implement
        // java.io.Closeable, can be used as a resource.

        try (InputStream instream = jarFile.getInputStream(entry) )
                {
                    BufferedReader reader = new BufferedReader(new InputStreamReader(instream));
                    reader.lines().forEach(line -> System.out.println(line));
                }
    }
}