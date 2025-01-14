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
    private static final DBOracleMgr db = new DBOracleMgr();
    
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
        String sql = "SELECT STUDY_DATE, COUNT(*) as STUDY_COUNT " +
                     "FROM TB_STUDY " +
                     "WHERE USER_ID = ? " +
                     "GROUP BY STUDY_DATE " +
                     "ORDER BY STUDY_DATE DESC";
        
        Object[] params = new Object[]{userId};
        
        try {
            if (db.RunQuery(sql, params, 0, true)) {
                ResultSet rs = db.Rs;
                while (rs.next()) {
                    StudyDTO study = new StudyDTO();
                    study.setStudyDate(rs.getDate("STUDY_DATE"));
                    study.setStudyCount(rs.getInt("STUDY_COUNT"));
                    streaks.add(study);
                }
            }
        } catch (Exception Ex) {
            ExceptionMgr.DisplayException(Ex);
            throw Ex;
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
        String sql = "INSERT INTO TB_STUDY (USER_ID, STUDY_DATE, STUDY_COUNT, STUDY_LEVEL) " +
                     "VALUES (?, ?, ?, ?)";
        
        Object[] params = new Object[]{
            study.getUserId(),
            study.getStudyDate(),
            study.getStudyCount(),
            study.getStudyLevel()
        };
        
        try {
            return db.RunQuery(sql, params, 0, false); // false는 INSERT 쿼리임을 의미
        } catch (Exception Ex) {
            ExceptionMgr.DisplayException(Ex);
            throw Ex;
        }
    }
}
//#################################################################################################
//<END>
//#################################################################################################