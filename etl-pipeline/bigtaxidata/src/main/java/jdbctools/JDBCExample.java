package jdbctools;

import java.sql.*;

public class JDBCExample {

    public static void main(String[] argv) {

        System.out.println("-------- PostgreSQL JDBC Connection Testing ------------");

        String url = "jdbc:postgresql://localhost:5432/etl_stage";
        final String user = "postgres";
        final String password = "pop1234";

        Connection conn = null;
        try {
            conn = DriverManager.getConnection(url, user, password);
            System.out.println("Connected to the PostgreSQL server successfully.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        getPeople(conn);
    } // eom

    public static void getPeople(Connection c){
        String SQL = "SELECT tid,name, date_in FROM people";

        Statement stmt = null;
        try {
            stmt = c.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try (ResultSet rs = stmt.executeQuery(SQL)) {
            // display actor information
            displayPeople(rs);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public static void displayPeople(ResultSet rs) throws SQLException {
        while (rs.next()) {
            System.out.println(rs.getString("tid") + "\t"
                    + rs.getString("name") + "\t"
                    + rs.getString("date_in"));

        }
    }

} //eoc


