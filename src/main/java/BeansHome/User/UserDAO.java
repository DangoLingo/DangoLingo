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
import oracle.jdbc.OracleTypes;
import java.sql.Types;

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
        CallableStatement cstmt = null;
        ResultSet rs = null;

        try {
            // -----------------------------------------------------------------------------
            // 로그인 처리
            // -----------------------------------------------------------------------------
            if (email != null && password != null) {
                logger.info("\n=== Login Process Start ===");
                logger.info("Attempting login for email: [" + email + "]");
                
                conn = db.getConnection();
                if (conn != null) {
                    // 로그인 프로시저 호출
                    String loginSql = "BEGIN SP_USER_LOGIN(?, ?, ?); END;";
                    logger.info("\n=== SQL Query ===");
                    logger.info("Procedure: SP_USER_LOGIN");
                    
                    cstmt = conn.prepareCall(loginSql);
                    cstmt.setString(1, email);
                    cstmt.setString(2, password);
                    cstmt.registerOutParameter(3, OracleTypes.CURSOR);
                    
                    logger.info("\n=== Executing Procedure ===");
                    cstmt.execute();
                    
                    rs = (ResultSet)cstmt.getObject(3);
                    
                    if (rs.next()) {
                        String storedPassword = rs.getString("PASSWORD");
                        
                        if (password.equals(storedPassword)) {
                            user = new UserDTO();
                            user.setUserId(rs.getInt("USER_ID"));
                            user.setEmail(rs.getString("EMAIL"));
                            user.setName(rs.getString("NAME"));
                            user.setNickname(rs.getString("NICKNAME"));
                            user.setIntro(rs.getString("INTRO"));
                            user.setStudyDate(rs.getDate("STUDY_DATE"));
                            user.setStudyTime(rs.getInt("STUDY_TIME"));
                            user.setStudyDay(rs.getInt("STUDY_DAY"));
                            user.setQuizCount(rs.getInt("QUIZ_COUNT"));
                            user.setQuizRight(rs.getInt("QUIZ_RIGHT"));
                            user.setPoint(rs.getInt("POINT"));
                            
                            logger.info("Login successful for user: " + user.getEmail());
                        }
                    }
                }
            }
            // -----------------------------------------------------------------------------
        } catch (Exception Ex) {
            ExceptionMgr.DisplayException(Ex);
            throw Ex;
        } finally {
            db.close(rs, cstmt, conn);
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
        CallableStatement cstmt = null;
        boolean success = false;

        try {
            // -----------------------------------------------------------------------------
            // 회원가입 처리
            // -----------------------------------------------------------------------------
            if (user != null) {
                logger.info("\n=== Registration Process Start ===");
                logger.info("User details:");
                logger.info("Email: [" + user.getEmail() + "]");
                logger.info("Name: [" + user.getName() + "]");
                logger.info("Nickname: [" + user.getNickname() + "]");
                logger.info("Password length: [" + user.getPassword().length() + "]");
                
                conn = db.getConnection();
                if (conn != null) {
                    // 회원가입 프로시저 호출 - Oracle 방식으로 변경
                    String registerSql = "BEGIN SP_USER_REGISTER(?, ?, ?, ?, ?); END;";
                    logger.info("\n=== SQL Query ===");
                    logger.info("Procedure: SP_USER_REGISTER");
                    
                    cstmt = conn.prepareCall(registerSql);
                    
                    // IN 파라미터 설정
                    cstmt.setString(1, user.getEmail());
                    cstmt.setString(2, user.getPassword());
                    cstmt.setString(3, user.getName());
                    cstmt.setString(4, user.getNickname());
                    
                    // OUT 파라미터 설정
                    cstmt.registerOutParameter(5, Types.INTEGER);
                    
                    logger.info("\n=== Executing Procedure ===");
                    cstmt.execute();
                    
                    // 결과 확인
                    int result = cstmt.getInt(5);
                    logger.info("Procedure result: " + result);
                    
                    switch (result) {
                        case 1:  // 성공
                            success = true;
                            logger.info("Registration successful");
                            break;
                        case 0:  // 이메일 중복
                            logger.warning("Email already exists");
                            break;
                        case -1: // 기타 오류
                            logger.severe("Registration failed");
                            break;
                    }
                }
            }
            // -----------------------------------------------------------------------------
        } catch (Exception Ex) {
            logger.severe("Error during registration: " + Ex.getMessage());
            ExceptionMgr.DisplayException(Ex);
            throw Ex;
        } finally {
            db.close(cstmt, conn);
        }
        
        return success;
    }
}
//#################################################################################################
//<END>
//################################################################################################# 