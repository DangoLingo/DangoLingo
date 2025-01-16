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
import oracle.jdbc.internal.OracleTypes;
import java.util.logging.ConsoleHandler;

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
    private static final DBOracleMgr db = new DBOracleMgr();
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
            // 로거 설정
            logger.setLevel(Level.ALL);
            ConsoleHandler handler = new ConsoleHandler();
            handler.setLevel(Level.ALL);
            logger.addHandler(handler);
            
            logger.info("\n=== UserDAO Initialization ===");
            ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);
            
            // DB 연결 설정
            db.SetConnectionStringFromProperties("db.properties");
        } catch (Exception Ex) {
            logger.severe("Error in constructor: " + Ex.getMessage());
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
        String sql = "SELECT * FROM TB_USER WHERE USER_ID = ?";
        Object[] params = new Object[]{userId};
        
        try {
            logger.info("Attempting to get user by ID: " + userId);
            if (db.RunQuery(sql, params, 0, true)) { // 0은 OUT parameter가 없음을 의미, true는 SELECT 쿼리임을 의미
                ResultSet rs = db.Rs;
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
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting user by ID: " + userId, e);
            throw e;
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
        String sql = "UPDATE TB_USER SET STUDY_DAY = ?, QUIZ_COUNT = ?, QUIZ_RIGHT = ?, POINT = ? WHERE USER_ID = ?";
        Object[] params = new Object[]{
            user.getStudyDay(),
            user.getQuizCount(),
            user.getQuizRight(),
            user.getPoint(),
            user.getUserId()
        };
        
        try {
            return db.RunQuery(sql, params, 0, false); // false는 UPDATE 쿼리임을 의미
        } catch (Exception e) {
            logger.severe("Error updating user stats: " + e.getMessage());
            throw e;
        }
    }

    /***********************************************************************
    * login()         : 로그인 처리
    * @param email    : 사용자 이메일
    * @param password : 사용자 비밀번호
    * @return UserDTO : 로그인 성공시 사용자 정보, 실패시 null
    ***********************************************************************/
    public UserDTO login(String email, String password) throws Exception {
        UserDTO user = null;
        String sql = "{call SP_USER_LOGIN(?, ?, ?)}";  // 일반적인 프로시저 호출 형식
        Object[] params = new Object[2];
        
        try {
            logger.info("\n=== Login Process Start ===");
            logger.info("Email: [" + email + "]");
            
            if (db.DbConnect()) {
                params[0] = email;               // IN parameter
                params[1] = password;            // IN parameter
                
                // RunQuery 호출 시 OUT parameter 위치를 3으로 지정
                if (db.RunQuery(sql, params, 3, true)) {
                    ResultSet rs = db.Rs;
                    logger.info("\n=== Query executed successfully ===");
                    if (rs != null && rs.next()) {
                        user = new UserDTO();
                        user.setUserId(rs.getInt("USER_ID"));
                        user.setEmail(rs.getString("EMAIL"));
                        user.setPassword(rs.getString("PASSWORD"));
                        user.setName(rs.getString("NAME"));
                        user.setNickname(rs.getString("NICKNAME"));
                        user.setIntro(rs.getString("INTRO"));
                        user.setStudyDate(rs.getDate("STUDY_DATE"));
                        user.setStudyTime(rs.getInt("STUDY_TIME"));
                        user.setStudyDay(rs.getInt("STUDY_DAY")); 
                        user.setQuizCount(rs.getInt("QUIZ_COUNT"));
                        user.setQuizRight(rs.getInt("QUIZ_RIGHT"));
                        user.setPoint(rs.getInt("POINT"));
                        user.setTotalPoint(rs.getInt("TOTAL_POINT"));

                        // 비밀번호 검증
                        if (!password.equals(user.getPassword())) {
                            logger.warning("Invalid password for user: " + email);
                            user = null;
                        } else {
                            logger.info("Login successful for user: " + email);
                        }
                    } else {
                        logger.warning("No user found with email: " + email);
                    }
                } else {
                    logger.warning("Failed to execute login query");
                }
            }
        } catch (Exception e) {
            logger.severe("Login error: " + e.getMessage());
            throw e;
        } finally {
            db.DbDisConnect();
        }
        
        return user;
    }

    /***********************************************************************
    * register()      : 회원가입 처리
    * @param user     : 등록할 사용자 정보
    * @return boolean : 등록 성공 여부
    ***********************************************************************/
    public boolean register(UserDTO user) throws Exception {
        String sql = "{ call SP_USER_REGISTER(?, ?, ?, ?, ?) }";
        Object[] params = new Object[]{
            user.getEmail(),
            user.getPassword(),
            user.getName(),
            user.getNickname()
        };
        
        try {
            logger.info("Attempting database connection...");
            if (!db.DbConnect()) {
                logger.severe("Failed to connect to database");
                throw new Exception("데이터베이스 연결에 실패했습니다.");
            }
            logger.info("Database connected successfully");
            
            logger.info("Executing registration procedure with parameters:");
            logger.info("Email: " + user.getEmail());
            logger.info("Name: " + user.getName());
            logger.info("Nickname: " + user.getNickname());
            
            if (db.RunQuery(sql, params, 5, true)) {
                ResultSet rs = db.Rs;
                if (rs != null && rs.next()) {
                    int result = rs.getInt("RESULT");
                    String errorMsg = rs.getString("ERROR_MSG");
                    logger.info("Registration result code: " + result);
                    logger.info("Error message: " + errorMsg);
                    
                    switch (result) {
                        case 1:
                            logger.info("Registration successful");
                            return true;
                        case 0:
                            logger.warning("Email already exists: " + user.getEmail());
                            throw new Exception(errorMsg);
                        case -1:
                            logger.warning("Nickname already exists: " + user.getNickname());
                            throw new Exception(errorMsg);
                        default:
                            logger.severe("Unknown error during registration");
                            throw new Exception(errorMsg);
                    }
                }
            }
            logger.severe("Failed to execute registration procedure");
            return false;
        } catch (Exception e) {
            logger.severe("Error during registration: " + e.getMessage());
            throw e;
        } finally {
            try {
                db.DbDisConnect();
                logger.info("Database connection closed");
            } catch (Exception e) {
                logger.warning("Error closing database connection: " + e.getMessage());
            }
        }
    }
}
//#################################################################################################
//<END>
//################################################################################################# 