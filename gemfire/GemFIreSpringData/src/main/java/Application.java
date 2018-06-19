package src.main.java;

import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.core.io.ClassPathResource;

import java.io.File;
import java.util.Iterator;

public class Application {


    public static void main(String[] args) {

        final File f = new File(Application.class.getProtectionDomain().getCodeSource().getLocation().getPath());
        System.out.println("f " + f);
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext();
        context.setConfigLocation(new ClassPathResource("/gfshBean.xml").getPath());
        context.refresh();

        src.main.java.RecordRepository recordRepository = context.getBean(RecordRepository.class);
        RecordBean recordBean = new RecordBean("1", "One");
        recordRepository.save(recordBean);
        recordBean = new RecordBean("2", "Two");
        recordRepository.save(recordBean);
        recordBean = new RecordBean("3", "Three");
        recordRepository.save(recordBean);
        System.out.println("Successful run!!");

        RecordBean recordBeanFetched = recordRepository.findByRecordId("2");
        System.out.println("The Fetched record bean is " + recordBeanFetched);

        Iterable<RecordBean> recordCollection = recordRepository.myFindAll();
        System.out.println("RecordBeans List : ");
        for (Iterator<RecordBean> iterator = recordCollection.iterator(); iterator.hasNext(); ) {
            RecordBean recordBeannew = (RecordBean) iterator.next();
            System.out.println(recordBeannew);

        }
    }
}
