package com.gnjk.post;

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
 
            String sql = "SELECT p_idx, member_idx, p_date, p_title, p_content, p_thumbnail FROM POST";
 
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                
                int p_idx = rs.getInt("p_idx");
                int member_idx = rs.getInt("member_idx");
                Timestamp p_date = rs.getTimestamp("p_date");
                String p_title = rs.getString("p_title");
                String p_content = rs.getString("p_content");
                String p_thumbnail = rs.getString("p_thumbnail");
 
                System.out.print("p_idx : " + p_idx + ", ");
                System.out.print("member_idx: " + member_idx + ", ");
                System.out.print("p_date: " + p_date + ", ");
                System.out.print("p_title: " + p_title + ", ");
                System.out.print("p_content: " + p_content + ", ");
                System.out.println("p_thumbnail: " + p_thumbnail);
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
