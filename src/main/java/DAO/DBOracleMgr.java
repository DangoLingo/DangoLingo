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
import java.util.logging.Logger;
import java.util.logging.Level;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.io.StringWriter;

public class DBOracleMgr {
    private static final Logger logger = Logger.getLogger(DBOracleMgr.class.getName());
    private static DBOracleMgr instance = new DBOracleMgr();
    private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
    private String url;
    private String user;
    private String password;
    private Properties sqlProperties;

    private DBOracleMgr() {
        try {
            logger.info("Initializing DBOracleMgr...");
            Class.forName(DRIVER);
            logger.info("JDBC Driver loaded successfully");
            loadProperties();
        } catch (Exception e) {
            logger.severe("Error initializing DBOracleMgr: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void loadProperties() {
        sqlProperties = new Properties();
        try {
            String path = DBOracleMgr.class.getResource("db.properties").getPath();
            logger.info("=== Loading Properties ===");
            logger.info("Attempting to load properties from path: " + path);
            
            File file = new File(path);
            if (!file.exists()) {
                logger.severe("Properties file does not exist at path: " + path);
                throw new FileNotFoundException("Properties file not found");
            }
            
            sqlProperties.load(new FileInputStream(path));
            
            // DB 연결 정보 설정
            String serverIp = sqlProperties.getProperty("Oracle.ServerIp");
            String port = sqlProperties.getProperty("Oracle.Port");
            String sid = sqlProperties.getProperty("Oracle.SId");
            this.user = sqlProperties.getProperty("Oracle.UserId");
            this.password = sqlProperties.getProperty("Oracle.Password");
            
            // 설정값 로깅
            logger.info("=== Database Configuration ===");
            logger.info("Server IP: " + serverIp);
            logger.info("Port: " + port);
            logger.info("SID: " + sid);
            logger.info("User ID: " + user);
            logger.info("Password length: " + (password != null ? password.length() : 0));
            
            // JDBC URL 구성
            this.url = String.format("jdbc:oracle:thin:@%s:%s:%s", serverIp, port, sid);
            logger.info("Complete JDBC URL: " + url);
            
            // SQL 프로퍼티 로깅
            logger.info("=== SQL Properties ===");
            for (String key : sqlProperties.stringPropertyNames()) {
                if (!key.startsWith("Oracle.")) {  // DB 접속 정보는 제외하고 로깅
                    logger.info(key + ": " + sqlProperties.getProperty(key));
                }
            }
            
        } catch (Exception e) {
            logger.severe("=== Error Loading Properties ===");
            logger.severe("Error type: " + e.getClass().getName());
            logger.severe("Error message: " + e.getMessage());
            logger.severe("Stack trace:");
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            logger.severe(sw.toString());
        }
    }

    public static DBOracleMgr getInstance() {
        return instance;
    }

    public Connection getConnection() throws SQLException {
        try {
            logger.info("=== Database Connection Attempt ===");
            logger.info("JDBC Driver: " + DRIVER);
            logger.info("URL: " + url);
            logger.info("User: " + user);
            logger.info("Attempting to connect to database...");
            
            Connection conn = DriverManager.getConnection(url, user, password);
            
            // 자동 커밋 비활성화 (트랜잭션 수동 관리)
            conn.setAutoCommit(false);
            
            logger.info("=== Connection Successful ===");
            logger.info("Connection valid: " + conn.isValid(5));
            logger.info("AutoCommit set to: " + conn.getAutoCommit());
            logger.info("Transaction isolation level: " + conn.getTransactionIsolation());
            
            return conn;
        } catch (SQLException e) {
            logger.severe("=== Database Connection Error ===");
            logger.severe("Error type: " + e.getClass().getName());
            logger.severe("Error code: " + e.getErrorCode());
            logger.severe("SQL State: " + e.getSQLState());
            logger.severe("Message: " + e.getMessage());
            
            // 네트워크 연결 테스트
            try {
                logger.info("Attempting to ping server: " + sqlProperties.getProperty("Oracle.ServerIp"));
                Process process = Runtime.getRuntime().exec("ping -c 1 " + sqlProperties.getProperty("Oracle.ServerIp"));
                int exitCode = process.waitFor();
                logger.info("Ping result: " + (exitCode == 0 ? "Success" : "Failed"));
            } catch (Exception pingEx) {
                logger.severe("Failed to ping server: " + pingEx.getMessage());
            }
            
            throw e;
        }
    }

    public PreparedStatement getPreparedStatement(Connection conn, String key) throws SQLException {
        try {
            String sql = sqlProperties.getProperty(key);
            if (sql == null) {
                logger.warning("SQL query not found for key: " + key);
                throw new SQLException("SQL query not found for key: " + key);
            }
            logger.info("Preparing statement for key: " + key);
            logger.info("SQL: " + sql);
            return conn.prepareStatement(sql);
        } catch (SQLException e) {
            logger.severe("Error preparing statement: " + e.getMessage());
            throw e;
        }
    }

    public void close(AutoCloseable... resources) {
        for (AutoCloseable resource : resources) {
            if (resource != null) {
                try {
                    resource.close();
                    logger.info("Resource closed successfully");
                } catch (Exception e) {
                    logger.warning("Error closing resource: " + e.getMessage());
                    e.printStackTrace();
                }
            }
        }
    }
}
// #################################################################################################
// <END>
// #################################################################################################
