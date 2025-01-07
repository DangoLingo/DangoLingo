// #################################################################################################
// DBOracleMgr.java - 오라클 데이터베이스 DAO 모듈
// #################################################################################################
// ═════════════════════════════════════════════════════════════════════════════════════════
// 외부모듈 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
package DAO;

import java.io.FileInputStream;
import java.sql.*;
import java.util.Properties;

public class DBOracleMgr {
    private static DBOracleMgr instance = new DBOracleMgr();
    private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
    private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String USER = "dangolingo";
    private static final String PASSWORD = "dangolingo";
    private Properties sqlProperties;

    private DBOracleMgr() {
        try {
            Class.forName(DRIVER);
            loadSQLProperties();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void loadSQLProperties() {
        sqlProperties = new Properties();
        try {
            String path = DBOracleMgr.class.getResource("db.properties").getPath();
            sqlProperties.load(new FileInputStream(path));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static DBOracleMgr getInstance() {
        return instance;
    }

    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public PreparedStatement getPreparedStatement(Connection conn, String key) throws SQLException {
        String sql = sqlProperties.getProperty(key);
        return conn.prepareStatement(sql);
    }

    public void close(AutoCloseable... resources) {
        for (AutoCloseable resource : resources) {
            if (resource != null) {
                try {
                    resource.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
// #################################################################################################
// <END>
// #################################################################################################
