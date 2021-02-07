package com.gnjk.peeps;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

import org.junit.Test;

public class MySQLConnectionTest {
	 
    static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String URL = "jdbc:log4jdbc:mysql://localhost:3306/open?serverTimezone=UTC";
    static final String USERNAME = "aia";
    static final String PASSWORD = "aia";
 
    @Test
    public void getMySQLConnectionTest() {
        
        Connection conn = null;
        Statement stmt = null;
        
        try {
            
            System.out.println("==================== MySQL Connection START ====================");
            
            Class.forName(DRIVER);
            
            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            stmt = conn.createStatement();
 
            String sql = "SELECT gidx, gwriter, gdate, gmessage, gphoto FROM guestbook";
 
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                
                int gidx = rs.getInt("gidx");
                String gwriter = rs.getString("gwriter");
                Timestamp gdate = rs.getTimestamp("gdate");
                String gmessage = rs.getString("gmessage");
                String gphoto = rs.getString("gphoto");
            
 
                System.out.print("gidx : " + gidx + ", ");
                System.out.print("gwriter: " + gwriter + ", ");
                System.out.print("gdate: " + gdate + ", ");
                System.out.print("gmessage: " + gmessage + ", ");
                System.out.print("gphoto: " + gphoto + ", ");
              
            }
 
            rs.close();
            stmt.close();
            conn.close();
 
        } catch (SQLException se1) {
            se1.printStackTrace();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
        
        System.out.println("==================== MySQL Connection END ====================");
    }
}
