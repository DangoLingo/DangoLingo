//#################################################################################################
//UserDAO.java - 사용자 DAO 모듈
//#################################################################################################
//═════════════════════════════════════════════════════════════════════════════════════════
//외부모듈 영역
//═════════════════════════════════════════════════════════════════════════════════════════
package BeansHome.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Common.ExceptionMgr;
import DAO.DBOracleMgr;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.io.StringWriter;
import java.io.PrintWriter;

//═════════════════════════════════════════════════════════════════════════════════════════
//사용자정의 클래스 영역
//═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
* UserDAO    : 사용자 DAO 클래스<br>
* Inheritance : None
***********************************************************************/
public class UserDAO {
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역상수 관리 - 필수영역
    // —————————————————————————————————————————————————————————————————————————————————————
    private static final DBOracleMgr db = DBOracleMgr.getInstance();
    private static final Logger logger = Logger.getLogger(UserDAO.class.getName());
    
    // —————————————————————————————————————————————————————————————————————————————————————
    // 생성자 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /***********************************************************************
    * UserDAO()    : 생성자
    * @param void  : None
    ***********************************************************************/
    public UserDAO() {
        try {
            ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);
        } catch (Exception Ex) {
            ExceptionMgr.DisplayException(Ex);
        }
    }

    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역함수 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /***********************************************************************
    * getUserById()    : 사용자 정보 조회
    * @param userId    : 사용자 ID
    * @return UserDTO  : 사용자 정보 DTO
    * @throws Exception
    ***********************************************************************/
    public UserDTO getUserById(int userId) throws Exception {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            logger.info("Attempting to get user by ID: " + userId);
            conn = db.getConnection();
            String sql = "SELECT * FROM TB_USER WHERE USER_ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            
            logger.info("Executing SQL query: " + sql);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                user = new UserDTO();
                user.setUserId(rs.getInt("USER_ID"));
                user.setEmail(rs.getString("EMAIL"));
                user.setName(rs.getString("NAME"));
                user.setNickname(rs.getString("NICKNAME"));
                user.setIntro(rs.getString("INTRO"));
                user.setStudyDate(rs.getDate("STUDY_DATE"));
                // Timestamp를 int로 변환 (초 단위로)
                Timestamp ts = rs.getTimestamp("STUDY_TIME");
                user.setStudyTime(ts != null ? (int)(ts.getTime() / 1000) : 0);
                user.setStudyDay(rs.getInt("STUDY_DAY"));
                user.setQuizCount(rs.getInt("QUIZ_COUNT"));
                user.setQuizRight(rs.getInt("QUIZ_RIGHT"));
                user.setPoint(rs.getInt("POINT"));
                logger.info("User found: " + user.getNickname());
            } else {
                logger.warning("No user found with ID: " + userId);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting user by ID: " + userId, e);
            e.printStackTrace();
        } finally {
            db.close(rs, pstmt, conn);
        }

        return user;
    }

    /***********************************************************************
    * updateUserStats()    : 사용자 통계 정보 업데이트
    * @param user          : 사용자 DTO
    * @return boolean      : 업데이트 성공 여부
    * @throws Exception
    ***********************************************************************/
    public boolean updateUserStats(UserDTO user) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;

        try {
            // -----------------------------------------------------------------------------
            // 사용자 통계 정보 업데이트
            // -----------------------------------------------------------------------------
            conn = db.getConnection();
            String updateSql = "UPDATE TB_USER SET " +
                              "STUDY_DAY = ?, QUIZ_COUNT = ?, QUIZ_RIGHT = ?, POINT = ? " +
                              "WHERE USER_ID = ?";
            pstmt = conn.prepareStatement(updateSql);
            
            pstmt.setInt(1, user.getStudyDay());
            pstmt.setInt(2, user.getQuizCount());
            pstmt.setInt(3, user.getQuizRight());
            pstmt.setInt(4, user.getPoint());
            pstmt.setInt(5, user.getUserId());

            success = pstmt.executeUpdate() > 0;
            if (success) {
                conn.commit();
            }
            // -----------------------------------------------------------------------------
        } catch (Exception Ex) {
            if (conn != null) conn.rollback();
            ExceptionMgr.DisplayException(Ex);
            throw Ex;
        } finally {
            db.close(pstmt, conn);
        }

        return success;
    }

    /***********************************************************************
    * login()         : 로그인 처리
    * @param email    : 사용자 이메일
    * @param password : 사용자 비밀번호
    * @return UserDTO : 로그인 성공시 사용자 정보, 실패시 null
    ***********************************************************************/
    public UserDTO login(String email, String password) throws Exception {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            logger.info("\n=== Login Process Start ===");
            logger.info("Attempting login for email: [" + email + "]");
            
            conn = db.getConnection();
            String loginSql = "SELECT * FROM TB_USER WHERE EMAIL = ?";
            logger.info("\n=== SQL Query ===");
            logger.info("Query: " + loginSql);
            logger.info("Parameters:");
            logger.info("1. Email = [" + email + "]");
            
            pstmt = conn.prepareStatement(loginSql);
            pstmt.setString(1, email);
            
            logger.info("\n=== Executing Query ===");
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                logger.info("\n=== User Found ===");
                logger.info("User ID: " + rs.getInt("USER_ID"));
                logger.info("Email: " + rs.getString("EMAIL"));
                logger.info("Nickname: " + rs.getString("NICKNAME"));
                
                String storedPassword = rs.getString("PASSWORD");
                logger.info("Stored password length: " + (storedPassword != null ? storedPassword.length() : "null"));
                logger.info("Input password length: " + (password != null ? password.length() : "null"));
                
                // 비밀번호 검증 (실제 환경에서는 암호화된 비밀번호를 비교해야 함)
                if (password.equals(storedPassword)) {
                    logger.info("Password match successful");
                    user = new UserDTO();
                    user.setUserId(rs.getInt("USER_ID"));
                    user.setEmail(rs.getString("EMAIL"));
                    user.setNickname(rs.getString("NICKNAME"));
                    user.setName(rs.getString("NAME"));
                    
                    logger.info("\n=== Login Successful ===");
                    logger.info("User details:");
                    logger.info("- User ID: " + user.getUserId());
                    logger.info("- Email: " + user.getEmail());
                    logger.info("- Nickname: " + user.getNickname());
                } else {
                    logger.warning("\n=== Password Mismatch ===");
                    logger.warning("Stored password: [" + storedPassword + "]");
                    logger.warning("Input password: [" + password + "]");
                }
            } else {
                logger.warning("\n=== User Not Found ===");
                logger.warning("No user found with email: " + email);
                
                // 디버깅을 위해 테이블의 모든 이메일 주소 조회
                Statement stmt = conn.createStatement();
                ResultSet debugRs = stmt.executeQuery("SELECT EMAIL FROM TB_USER");
                logger.info("\n=== Existing Emails in Database ===");
                while (debugRs.next()) {
                    logger.info("- " + debugRs.getString("EMAIL"));
                }
                debugRs.close();
                stmt.close();
            }
        } catch (SQLException e) {
            logger.severe("\n=== SQL Error ===");
            logger.severe("Error type: " + e.getClass().getName());
            logger.severe("Error code: " + e.getErrorCode());
            logger.severe("SQL State: " + e.getSQLState());
            logger.severe("Message: " + e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.severe("\n=== Unexpected Error ===");
            logger.severe("Error type: " + e.getClass().getName());
            logger.severe("Message: " + e.getMessage());
            logger.severe("Stack trace:");
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            logger.severe(sw.toString());
            throw e;
        } finally {
            logger.info("\n=== Cleanup ===");
            db.close(rs, pstmt, conn);
            logger.info("Resources closed");
        }

        return user;
    }

    /***********************************************************************
    * register()      : 회원가입 처리
    * @param user     : 등록할 사용자 정보
    * @return boolean : 등록 성공 여부
    ***********************************************************************/
    public boolean register(UserDTO user) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;

        try {
            logger.info("=== Starting Registration Process ===");
            logger.info("User details:");
            logger.info("Email: " + user.getEmail());
            logger.info("Name: " + user.getName());
            logger.info("Nickname: " + user.getNickname());
            logger.info("Password length: " + user.getPassword().length());

            logger.info("Getting database connection...");
            conn = db.getConnection();
            logger.info("Database connection obtained");

            // 트랜잭션 설정 확인
            logger.info("Transaction settings - AutoCommit: " + conn.getAutoCommit());
            
            // 이메일 중복 체크
            logger.info("=== Checking Email Duplication ===");
            String checkEmailSql = "SELECT USER_ID FROM TB_USER WHERE EMAIL = ?";
            logger.info("Email check SQL: " + checkEmailSql);
            logger.info("Email parameter: " + user.getEmail());
            
            pstmt = conn.prepareStatement(checkEmailSql);
            pstmt.setString(1, user.getEmail());
            
            logger.info("Executing email check query...");
            ResultSet rs = pstmt.executeQuery();
            boolean emailExists = rs.next();
            logger.info("Email exists: " + emailExists);
            
            if (emailExists) {
                logger.warning("Email already exists: " + user.getEmail());
                return false;
            }
            rs.close();
            pstmt.close();

            // 시퀀스 체크
            logger.info("=== Checking Sequence ===");
            try {
                Statement stmt = conn.createStatement();
                logger.info("Checking USER_SEQ existence...");
                ResultSet seqRs = stmt.executeQuery("SELECT sequence_name FROM user_sequences WHERE sequence_name = 'USER_SEQ'");
                boolean seqExists = seqRs.next();
                logger.info("USER_SEQ exists: " + seqExists);
                
                if (!seqExists) {
                    logger.info("Creating USER_SEQ sequence...");
                    stmt.execute("CREATE SEQUENCE USER_SEQ START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE");
                    logger.info("USER_SEQ created successfully");
                }
                stmt.close();
            } catch (SQLException seqEx) {
                logger.severe("Error handling sequence: " + seqEx.getMessage());
                throw seqEx;
            }

            // 회원 등록
            logger.info("=== Inserting New User ===");
            String insertSql = "INSERT INTO TB_USER (USER_ID, EMAIL, PASSWORD, NAME, NICKNAME, INTRO) VALUES (USER_SEQ.NEXTVAL, ?, ?, ?, ?, ?)";
            logger.info("Insert SQL: " + insertSql);
            
            pstmt = conn.prepareStatement(insertSql);

            // 파라미터 바인딩 전 값 확인
            logger.info("Parameter values:");
            logger.info("1. Email: [" + user.getEmail() + "]");
            logger.info("2. Password: [length=" + user.getPassword().length() + "]");
            logger.info("3. Name: [" + user.getName() + "]");
            logger.info("4. Nickname: [" + user.getNickname() + "]");
            logger.info("5. Intro: []");

            // 파라미터 바인딩
            pstmt.setString(1, user.getEmail());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getName());
            pstmt.setString(4, user.getNickname());
            pstmt.setString(5, "");

            try {
                logger.info("Executing insert query...");
                int rowsAffected = pstmt.executeUpdate();
                logger.info("Insert query executed. Rows affected: " + rowsAffected);
                
                if (rowsAffected > 0) {
                    logger.info("Insert successful, committing transaction");
                    conn.commit();
                    logger.info("Transaction committed");
                    success = true;
                } else {
                    logger.warning("No rows affected by insert");
                    conn.rollback();
                    logger.info("Transaction rolled back");
                }
            } catch (SQLException e) {
                logger.severe("SQL Error during insert:");
                logger.severe("Error code: " + e.getErrorCode());
                logger.severe("SQL State: " + e.getSQLState());
                logger.severe("Message: " + e.getMessage());
                throw e;
            }
            
        } catch (Exception e) {
            logger.severe("=== Error During Registration ===");
            logger.severe("Error type: " + e.getClass().getName());
            logger.severe("Error message: " + e.getMessage());
            logger.severe("Stack trace:");
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            logger.severe(sw.toString());
            
            if (conn != null) {
                try {
                    conn.rollback();
                    logger.info("Transaction rolled back after error");
                } catch (SQLException ex) {
                    logger.severe("Error during rollback: " + ex.getMessage());
                }
            }
            throw e;
        } finally {
            logger.info("=== Cleanup ===");
            db.close(pstmt, conn);
            logger.info("Resources closed");
        }

        return success;
    }
}
//#################################################################################################
//<END>
//################################################################################################# 