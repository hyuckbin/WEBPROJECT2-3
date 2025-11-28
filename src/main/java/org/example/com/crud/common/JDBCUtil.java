package org.example.com.crud.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class JDBCUtil {
    private static Connection con = null;

    public static Connection getConnection() {
        try {
            if (con == null || con.isClosed()) {
                Class.forName("org.mariadb.jdbc.Driver");
                String url = "jdbc:mariadb://walab.handong.edu:3306/W25_22200029";
                String user = "W25_22200029";
                String pwd = "quie3A";

                con = DriverManager.getConnection(url, user, pwd);
            }
        } catch (Exception e) {
            System.out.println("DB 연결 실패: " + e);
            e.printStackTrace();
        }
        return con;
    }

    public static void close(Connection conn) {
        if (conn != null) { try { conn.close(); } catch (Exception e) { e.printStackTrace(); } }
    }

    public static void close(PreparedStatement stmt, Connection conn) {
        if (stmt != null) { try { stmt.close(); } catch (Exception e) { e.printStackTrace(); } }
        if (conn != null) { try { conn.close(); } catch (Exception e) { e.printStackTrace(); } }
    }

    public static void close(ResultSet rs, PreparedStatement stmt, Connection conn) {
        if (rs != null) { try { rs.close(); } catch (Exception e) { e.printStackTrace(); } }
        if (stmt != null) { try { stmt.close(); } catch (Exception e) { e.printStackTrace(); } }
        if (conn != null) { try { conn.close(); } catch (Exception e) { e.printStackTrace(); } }
    }

    public static void main(String[] args) {
        Connection con = JDBCUtil.getConnection();
        if(con != null){
            System.out.println("연결 성공");
        }
    }
}