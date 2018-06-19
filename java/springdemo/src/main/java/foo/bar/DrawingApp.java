package foo.bar;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;


public class DrawingApp {

    public static void main(String[] args) {

        ApplicationContext context = new ClassPathXmlApplicationContext("spring-config.xml");
        // ask Application Context
        // similar to a bean factory
        Triangle t = (Triangle) context.getBean("triangle");
        t.draw();

    }
}
