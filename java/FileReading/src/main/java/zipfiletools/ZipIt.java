package zipfiletools;

/**
 * http://santoshsorab.blogspot.com/
 */
import com.google.common.collect.Lists;

import java.io.File;
import java.io.FilenameFilter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class ZipIt {

    public static void main(String[] args){



        try {

            File dir=new File("<DIR PATH>");
            File[] xmlFiles=null;
            if (dir.isDirectory()) {
                xmlFiles = dir.listFiles(new FilenameFilter() {
                    @Override
                    public boolean accept(File folder, String name) {
                        return name.toLowerCase().endsWith(".xml");
                    }
                });
            }
            ExecutorService executorService = Executors.newScheduledThreadPool(60);
            List<List<File>> smallerLists = Lists.partition(Arrays.asList(xmlFiles), 60);
            List<Future<Integer>> futures=null;
            //20 independent threads used to generate 20 images.
            List<Callable<Integer>> callables = new ArrayList<Callable<Integer>>();

            for (List<File> list : smallerLists) {
                callables.add(new ZipFilesThread(list));
            }

            try {
                futures = executorService.invokeAll(callables);

            } finally {
                executorService.shutdown();
            }


            for (Future<Integer> future : futures) {

                System.out.println("File converted to Zip:"+future.isDone());
            }


        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

}