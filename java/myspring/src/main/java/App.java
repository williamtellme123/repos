import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

public class App {

    public static void main(String[] args){

        // Bean container fetch beans
        // lower level of BeanFactory
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("resources/gfshBean.xml");
        ApplicationContext context1 = new FileSystemXmlApplicationContext("beans.xml");


        // Person p = new Person();
        Person p = (Person)context.getBean("person");
        p.speak();
        //Address a = (Address)context.getBean("address");

        System.out.println(p);
        //System.out.println(a);

        ((FileSystemXmlApplicationContext)context1).close();
    }
}
