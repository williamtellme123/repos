package org.example.ws.dao;

import org.example.ws.model.Circle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

// Spring Bean automatically registered as BEAN name JdbcDaoImpl
@Component
public class JdbcDaoImpl {

    @Autowired
    private DataSource dataSource;


    // CREATE LOCAL JDBCTEMPLATE
    private JdbcTemplate jdbcTemplate;
    // NAMED PARAMETERS
    private NamedParameterJdbcTemplate namewdParameterjdbcTemplate;


    // SPRING PROVIDES GENERIC DAO Class that each our dao extends

    // Provide datasource to jdbcTemplate
    @Autowired
    public void setDataSource(DataSource dataSource)
    {
        // use one or the other: JdbcTemplate or NamedParameterJdbcTemplate
        // NamedParameter that extends NamedParameterJdbcTemplate
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.namewdParameterjdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    public DataSource getDataSource() { return dataSource;}


    // NAMED PARAMETERS
    public void insertCircle2(Circle circle){
        String sql  = "insert into circle (id, name) values (:id,:name)";
        // MapSqlParameterSource() implementation of interface SqlParameterSource
        SqlParameterSource namedParameter =
                new MapSqlParameterSource("id", circle.getId())
                        .addValue("name", circle.getName());
        namewdParameterjdbcTemplate.update(sql,namedParameter);
    }


    // RETURN primary type int
    public int getCircleCount(){
        String sql = "select count(*) from circle";
        return jdbcTemplate.queryForObject(sql, new Object[] {}, Integer.class).intValue();
    }
    // RETURN primary type string
    public String getCircleName(int circleId){
        String sql = "select name from circle where id = ? ";
        // queryForObject(sql, new Object[] args, ReturnType);
        return jdbcTemplate.queryForObject(sql, new Object[]{circleId}, String.class);
    }
    // RETURN ONE OBJECT FROM JDBCTemplate :: jdbcTemplate.queryForObject
    public Circle getCircleFromId(int circleId){
        String sql = "Select * from circle where id = ?";
        // calls the mapRow for each record in rs
        return jdbcTemplate.queryForObject(sql, new Object[]{circleId}, new CircleRowMapper());
    }
    // RETURN LIST OF OBJECTS FROM JDBCTemplate :: jdbcTemplate.query
    public List<Circle> getAllCircles(){
        String sql  = "select * from circle";
        return jdbcTemplate.query(sql, new CircleRowMapper());
    }

    // INSERT A Circle JDBCTemplate :: jdbcTemplate.query
    // Later check to make sure this successful
    // add Cache block where it returns false?
    public void insertCircle(Circle circle ){
        String sql  = "insert into circle (id, name) values (?,?)";
        jdbcTemplate.update(sql, new Object[]{circle.getId(), circle.getName()});
    }
    // UPDATE Circle JDBCTemplate :: jdbcTemplate.query
    public void updateCircle(int i, String n ){
        String sql  = "update circle set name = ? where id = ?";
        jdbcTemplate.update(sql, new Object[]{n, i});
    }
    // DELETE Circle JDBCTemplate :: jdbcTemplate.query
    public void deleteCircle(int i){
        String sql  = "delete from circle where id = ?";
        jdbcTemplate.update(sql, new Object[]{i});
    }

    // DELETE Circle JDBCTemplate :: jdbcTemplate.query
    public void createTableTraiangle(){
        String sql  = "create table triangle (id INTEGER, name text)";
        jdbcTemplate.execute(sql);
    }


// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------
            // RowMapper class
            // mapRows called the classes CALL BACK method
            // it maps rs values to objects
            // InnerClass because only for each model
            private static final class CircleRowMappepackage src.main.java;r implements RowMapper<Circle>
            {
                // MapRow called "callback method" called once for each row
                // ( ResultSet (is JdbcTemplate query results),
                //   rowNum (of ResultSet))
                //   Calls mapRow for each record in rs
                //   Returns circle object
                @Override
                public Circle mapRow(ResultSet resultSet, int rowNum) throws SQLException {
                    Circle circle  = new Circle();
                    circle.setId(resultSet.getInt("ID"));
                    circle.setName(resultSet.getString("NAME"));
                    return circle;
                }
            }
// -----------------------------------------------------------------------------------


}

// Get & Set jdbcTemplate
//    public JdbcTemplate getJdbcTemplate() {
//        return jdbcTemplate;
//    }
//    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
//        this.jdbcTemplate = jdbcTemplate;
//    }

// first example uses jdbc not jdbcTemplate which uses lots of additional code
//    public Circle getCircle(int circleId) throws ClassNotFoundException, IllegalAccessException, InstantiationException, SQLException {
//        // Connection
//        //        String url = "jdbc:postgresql://localhost/fairbanks";
//        //        Properties props = new Properties();
//        //        props.setProperty("user","postgres");
//        //        props.setProperty("password","pop1234");
//        //        Connection conn = DriverManager.getConnection(url, props);
//        Connection conn = null;
//        conn = dataSource.getConnection();
//        // create prepared statement
//        PreparedStatement ps = conn.prepareStatement("Select * from circle where id = ?");
//        ps.setInt(1,circleId);
//        Circle circle = null;
//        ResultSet rs = ps.executeQuery();
//        if (rs.next()){
//            circle = new Circle(circleId, rs.getString("name"));
//        }
//        rs.close();
//        ps.close();
//        conn.close();
//        return circle;
//    }