package org.example.ws;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;



//@SpringBootApplication
// this annotation is equivalent to
//      @Configuration
//      @EnableAutoConfiguration
//      @ComponentScan

@SpringBootApplication
public class Application
{
    public static void main( String[] args ) throws Exception
    {


        SpringApplication.run(Application.class, args);

         /*

        // Application Context
        ApplicationContext ctx = new ClassPathXmlApplicationContext("spring-config.xml");
        JdbcDaoImpl dao  = ctx.getBean("jdbcDaoImpl",JdbcDaoImpl.class);
        JdbcDaoImpl dao2 = ctx.getBean("jdbcDaoImpl",JdbcDaoImpl.class);

        JdbcTemplateDaoImpl dao3 = ctx.getBean("JdbcTemplateDaoImpl",JdbcTemplateDaoImpl.class);

        // INSERTING using JDBCTemplate
        //        Circle newCircle = new Circle(9,"Of Life");
        //        dao.insertCircle(newCircle);

        // UPDATING using JDBCTemplate
        // dao.updateCircle(9, " Wheel");
        // dao.deleteCircle(19);
        // dao.createTableTraiangle();

        int currentCircleCount = dao2.getCircleCount();

        Circle newCircle2 = new Circle(currentCircleCount+1,"Lama");
        dao2.insertCircle2(newCircle2);

        // FETCHING using JDBCTemplate
        System.out.println(dao.getCircleFromId(5).getName());
        List<Circle> circles = new ArrayList<>();
        circles = dao2.getAllCircles();
        // iterate via "for loop"
        System.out.println("==> For Loop Example.");
        for (int i = 0; i < circles.size(); i++) {
            System.out.println(circles.get(i));
        }

        // iterate via "New way to loop"
        System.out.println("\n==> Advance For Loop Example..");
        for (Circle temp : circles) {
                System.out.println("id -->" + temp.getId()+ " and name is " + temp.getName());
        }

        // iterate via "iterator loop"
        System.out.println("\n==> Iterator Example...");
        Iterator<Circle> CircleIterator = circles.iterator();
        while (CircleIterator.hasNext()) {
                System.out.println("id *** >" +  CircleIterator.next().getId() + " and name is " + CircleIterator.next().getName());
        }

        Circle t = new Circle();
        // iterate via "while loop"
        System.out.println("\n==> While Loop Example....");
        int i = 0;
        while (i < circles.size()) {
            t = circles.get(i);
            System.out.println("id -->" + t.getId()+ " and name is " + t.getName());
            i++;
        }

        System.out.println("dao3.getCircleCount(); --> " + dao3.getCircleCount());
    */
    }


}
// Uses original jdbc code which has been commented out
//      Circle circle = dao.getCircle(1);
//      System.out.println("circle.getname -->" + circle.getName());
//      System.out.println(dao.getCircleCount());
//      System.out.println(dao.getCircleName(5));