package camelinaction;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

import java.net.URL;
import java.net.URLClassLoader;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class SpringJdbcTemplateQueryExample {
    private JdbcTemplate jdbcTemplate;

    public static void main(String[] args) throws SQLException {
        ClassLoader cl = ClassLoader.getSystemClassLoader();

        URL[] urls = ((URLClassLoader)cl).getURLs();
        System.out.println("-----------------------------");
        for(URL url: urls){
            System.out.println(url.getFile());
        }
        System.out.println("-----------------------------");

        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");


//        SpringJdbcTemplateQueryExample stmtQueryExample = (SpringJdbcTemplateQueryExample) context.getBean("springJtQueryExample");
//        stmtQueryExample.queryEmployee();
        System.out.println("I AM HERE NOW");
    }

    public void queryEmployee() throws SQLException {
        String sql = "SELECT ID, NAME, AGE FROM EMPLOYEE";
        List<Map<String, Object>> list = getJdbcTemplate().queryForList(sql);
        for (Map<String, Object> row : list) {
            System.out.println(row.get("name"));
        }
    }


//
//    public void queryEmployee() throws SQLException {
//        String sql = "SELECT ID, NAME, AGE FROM EMPLOYEE";
//        List<Map<String, Object>> list = getJdbcTemplate().queryForList(sql);
//        for (Map<String, Object> row : list) {
//            System.out.println(row.get("name"));
//        }
//
//        List<Employee> empList = getJdbcTemplate().query(sql, new ResultSetExtractor<List<Employee>>(){
//
//            public List<Employee> extractData(ResultSet rs) throws SQLException,
//                    DataAccessException {
//                List<Employee> empList = new ArrayList<Employee>();
//                while(rs.next()) {
//                    Employee emp = new Employee(rs.getInt("ID"), rs.getString("NAME"), rs.getInt("AGE"));
//                    empList.add(emp);
//                }
//                return empList;
//            }});
//
//        System.out.println(empList);
//
//        empList = getJdbcTemplate().query(sql, new RowMapper<Employee>(){
//
//            public Employee mapRow(ResultSet rs, int rowNum)
//                    throws SQLException {
//                Employee emp = new Employee(rs.getInt("ID"), rs.getString("NAME"), rs.getInt("AGE"));
//                return emp;
//            }});
//
//        System.out.println(empList);
//    }
//
    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }
//
//    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
//        this.jdbcTemplate = jdbcTemplate;
//    }
}
