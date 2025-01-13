//#################################################################################################
//StudyDAO.java - 학습 진행 기록 DAO 모듈
//#################################################################################################
//═════════════════════════════════════════════════════════════════════════════════════════
//외부모듈 영역
//═════════════════════════════════════════════════════════════════════════════════════════
package BeansHome.Study;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Common.ExceptionMgr;
import DAO.DBOracleMgr;

//═════════════════════════════════════════════════════════════════════════════════════════
//사용자정의 클래스 영역
//═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
* StudyDAO   : 학습 진행 기록 DAO 클래스<br>
* Inheritance : None
***********************************************************************/
public class StudyDAO {
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역상수 관리 - 필수영역
    // —————————————————————————————————————————————————————————————————————————————————————
    private static final DBOracleMgr db = DBOracleMgr.getInstance();
    
    // —————————————————————————————————————————————————————————————————————————————————————
    // 생성자 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /***********************************************************************
    * StudyDAO()   : 생성자
    * @param void  : None
    ***********************************************************************/
    public StudyDAO() {
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
    * getStudyStreak()    : 학습 스트릭 조회
    * @param userId       : 사용자 ID
    * @return List<StudyDTO> : 학습 스트릭 목록
    * @throws Exception
    ***********************************************************************/
    public List<StudyDTO> getStudyStreak(int userId) throws Exception {
        List<StudyDTO> streaks = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = db.getConnection();
            pstmt = db.getPreparedStatement(conn, "STUDY.SELECT_STREAK");
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                StudyDTO study = new StudyDTO();
                study.setStudyDate(rs.getDate("STUDY_DATE"));
                study.setStudyCount(rs.getInt("STUDY_COUNT"));
                streaks.add(study);
            }
        } catch (Exception Ex) {
            ExceptionMgr.DisplayException(Ex);
            throw Ex;
        } finally {
            db.close(rs, pstmt, conn);
        }

        return streaks;
    }

    /***********************************************************************
    * insertStudyRecord() : 학습 기록 추가
    * @param study        : 학습 기록 DTO
    * @return boolean     : 추가 성공 여부
    * @throws Exception
    ***********************************************************************/
    public boolean insertStudyRecord(StudyDTO study) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;

        try {
            // -----------------------------------------------------------------------------
            // 학습 기록 추가
            // -----------------------------------------------------------------------------
            conn = db.getConnection();
            pstmt = db.getPreparedStatement(conn, "STUDY.INSERT");
            
            pstmt.setInt(1, study.getUserId());
            pstmt.setDate(2, study.getStudyDate());
            pstmt.setInt(3, study.getStudyCount());
            pstmt.setInt(4, study.getStudyLevel());

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