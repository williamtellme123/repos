package org.example.ws.dao;

import org.springframework.jdbc.core.support.JdbcDaoSupport;


/**
 * Created by billy on 6/20/15.
 */

//public class JdbcTemplateDaoImpl  extends NamedParameterJdbcTemplate{
//    public JdbcTemplateDaoImpl(DataSource dataSource) {
//        super(dataSource);
//    }
//
//    public JdbcTemplateDaoImpl(JdbcOperations classicJdbcTemplate) {
//        super(classicJdbcTemplate);
//    }
//}

//this.getJdbcTemplate().query(sql, new Object[]{}, Integer.class).intValue();



public class JdbcTemplateDaoImpl  extends JdbcDaoSupport {
        // Has no abstract methods No need implement anything
        // Has JdbcTemplate as a member variable


        // We do not have access to parent code to annotate
        // i.e. Autowire
        // so we move the dependency injection into XML
        // providing a single location to set the data source

        //    <bean id="JdbcTemplateDaoImpl" class="org.example.ws.dao.JdbcTemplateDaoImpl">
        //          <property name="dataSource" ref="dataSource"></property>
        //    </bean>

        public int getCircleCount() {
            String sql = "select count(*) from circle";
            return getJdbcTemplate().queryForObject(sql, Integer.class);

        }
}

