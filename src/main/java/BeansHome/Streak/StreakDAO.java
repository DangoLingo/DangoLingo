// #################################################################################################
// StreakDAO.java - 스트릭 DAO 모듈
// #################################################################################################
// ═════════════════════════════════════════════════════════════════════════════════════════
// 외부모듈 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
package BeansHome.Streak;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Common.ExceptionMgr;
import DAO.DBOracleMgr;

// ═════════════════════════════════════════════════════════════════════════════════════════
// 사용자정의 클래스 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
 * StreakDAO    : 스트릭 DAO 클래스<br>
 * Inheritance : None
 ***********************************************************************/
public class StreakDAO {
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역상수 관리 - 필수영역
    // —————————————————————————————————————————————————————————————————————————————————————
    private static final DBOracleMgr db = new DBOracleMgr();

    // —————————————————————————————————————————————————————————————————————————————————————
    // 생성자 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /***********************************************************************
     * StreakDAO()    : 생성자
     * @param void    : None
     ***********************************************************************/
    public StreakDAO() {
        try {
            ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);
            db.SetConnectionStringFromProperties("db.properties");
        } catch (Exception Ex) {
            ExceptionMgr.DisplayException(Ex);
        }
    }

    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역함수 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /***********************************************************************
     * getUserStreaks()     : 사용자의 최근 1년간 스트릭 정보 조회
     * @param userId       : 사용자 ID
     * @return List<StreakDTO> : 스트릭 정보 목록
     ***********************************************************************/
    public List<StreakDTO> getUserStreaks(int userId) {
        List<StreakDTO> streaks = new ArrayList<>();
        String sql = "{call SP_GET_USER_STREAK(?, ?)}";
        Object[] params = new Object[]{userId};
        
        try {
            if (db.DbConnect()) {
                if (db.RunQuery(sql, params, 2, true)) {
                    ResultSet rs = db.Rs;
                    
                    while (rs != null && rs.next()) {
                        StreakDTO streak = new StreakDTO();
                        streak.setUserId(rs.getInt("user_id"));
                        streak.setStreakDate(rs.getDate("streak_date"));
                        streak.setPoint(rs.getInt("point"));
                        streaks.add(streak);
                    }
                }
            }
        } catch (Exception Ex) {
            ExceptionMgr.DisplayException(Ex);
        } finally {
            try {
                db.DbDisConnect();
            } catch (Exception Ex) {
                ExceptionMgr.DisplayException(Ex);
            }
        }
        
        return streaks;
    }
}
// #################################################################################################
// <END>
// ################################################################################################# 