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
            // -----------------------------------------------------------------------------
            // 사용자 정보 조회
            // -----------------------------------------------------------------------------
            conn = db.getConnection();
            pstmt = db.getPreparedStatement(conn, "USER.SELECT_BY_ID");
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new UserDTO();
                user.setUserId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setName(rs.getString("name"));
                user.setNickname(rs.getString("nickname"));
                user.setIntro(rs.getString("intro"));
                user.setProfileImage(rs.getString("profile_image"));
                user.setStudyDate(rs.getDate("study_date"));
                user.setStudyTime(rs.getTimestamp("study_time"));
                user.setStudyDay(rs.getInt("study_day"));
                user.setQuizCount(rs.getInt("quiz_count"));
                user.setQuizRight(rs.getInt("quiz_right"));
                user.setPoint(rs.getInt("point"));
                user.setDangos(rs.getInt("dangos"));
            }
            // -----------------------------------------------------------------------------
        } catch (Exception Ex) {
            ExceptionMgr.DisplayException(Ex);
            throw Ex;
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
            pstmt = db.getPreparedStatement(conn, "USER.UPDATE_STATS");
            
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
}
//#################################################################################################
//<END>
//################################################################################################# 