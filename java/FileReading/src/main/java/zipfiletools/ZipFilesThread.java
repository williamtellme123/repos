package zipfiletools;

/**
 * Created by billy on 3/3/16.
 */
import java.io.File;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.logging.Logger;

// import com.mercuria.etl.util.ZipUtil;

public class ZipFilesThread implements Callable<Integer> {


    List<File> files;


    private static Logger logger = Logger.getLogger(ZipFilesThread.class.getName());

    public ZipFilesThread(List<File> files) {
        super();
        this.files=files;

    }

    @Override
    public Integer call() throws Exception {

        for (File xmlFile : files) {
            // ZipUtil.zipFile(xmlFile.getAbsolutePath());
            xmlFile.delete();
        }
        return files.size();

    }




}