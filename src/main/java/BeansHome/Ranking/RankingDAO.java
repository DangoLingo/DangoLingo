// #################################################################################################
// RankingDAO.java - 랭킹 DAO 모듈
// #################################################################################################
// ═════════════════════════════════════════════════════════════════════════════════════════
// 외부모듈 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
package BeansHome.Ranking;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Common.ExceptionMgr;
import DAO.DBOracleMgr;
import java.util.logging.Logger;
import java.util.logging.Level;

// ═════════════════════════════════════════════════════════════════════════════════════════
// 사용자정의 클래스 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
 * RankingDAO  : 랭킹 DAO 클래스<br>
 * Inheritance : None
 ***********************************************************************/
public class RankingDAO {
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역상수 관리 - 필수영역
    // —————————————————————————————————————————————————————————————————————————————————————
    private static final DBOracleMgr db = new DBOracleMgr();
    private static final Logger logger = Logger.getLogger(RankingDAO.class.getName());
    
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역변수 관리 - 필수영역(정적변수)
    // —————————————————————————————————————————————————————————————————————————————————————
    
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역변수 관리 - 필수영역(인스턴스변수)
    // —————————————————————————————————————————————————————————————————————————————————————
    
    // —————————————————————————————————————————————————————————————————————————————————————
    // 생성자 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /***********************************************************************
     * RankingDAO() : 생성자
     * @param void  : None
     ***********************************************************************/
    public RankingDAO() {
        try {
            logger.setLevel(Level.ALL);
            ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);
            db.SetConnectionStringFromProperties("db.properties");
        } catch (Exception Ex) {
            logger.severe("Error in constructor: " + Ex.getMessage());
            ExceptionMgr.DisplayException(Ex);
        }
    }
    
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역함수 관리 - 필수영역(정적함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역함수 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /***********************************************************************
     * getRankings()  : 전체 랭킹 조회
     * @param type    : 랭킹 타입 (words/points/dangos)
     * @param limit   : 조회할 랭킹 수
     * @return List<RankingDTO> : 랭킹 목록
     ***********************************************************************/
    public List<RankingDTO> getRankings(String type, int limit) throws Exception {
        List<RankingDTO> rankings = new ArrayList<>();
        
        String sql = switch (type) {
            case "words" -> "SELECT * FROM (" +
                           "SELECT u.*, DENSE_RANK() OVER (ORDER BY quiz_right DESC) as rank " +
                           "FROM TB_USER u) WHERE rank <= ?";
            case "points" -> "SELECT * FROM (" +
                            "SELECT u.*, DENSE_RANK() OVER (ORDER BY point DESC) as rank " +
                            "FROM TB_USER u) WHERE rank <= ?";
            case "dangos" -> "SELECT * FROM (" +
                            "SELECT u.*, DENSE_RANK() OVER (ORDER BY dangos DESC) as rank " +
                            "FROM TB_USER u) WHERE rank <= ?";
            default -> "SELECT * FROM (" +
                      "SELECT u.*, DENSE_RANK() OVER (ORDER BY point DESC) as rank " +
                      "FROM TB_USER u) WHERE rank <= ?";
        };
        
        Object[] params = new Object[]{limit};
        
        try {
            if (db.RunQuery(sql, params, 0, true)) {
                ResultSet rs = db.Rs;
                while (rs.next()) {
                    RankingDTO ranking = new RankingDTO();
                    ranking.setRank(rs.getInt("rank"));
                    ranking.setUserId(rs.getInt("user_id"));
                    ranking.setNickname(rs.getString("nickname"));
                    ranking.setScore(getScoreByType(rs, type));
                    ranking.setType(type);
                    rankings.add(ranking);
                }
            }
        } catch (Exception Ex) {
            ExceptionMgr.DisplayException(Ex);
            throw Ex;
        }
        
        return rankings;
    }

    /***********************************************************************
     * getUserRanking()    : 사용자의 포인트 랭킹 정보 조회
     * @param userId       : 사용자 ID
     * @param type        : 랭킹 타입 (points)
     * @return RankingDTO : 랭킹 정보
     ***********************************************************************/
    public RankingDTO getUserRanking(int userId, String type) {
        RankingDTO ranking = null;
        String sql = "{ call SP_GET_POINT_RANKING(?, ?) }";
        Object[] params = new Object[]{ userId };
        
        try {
            logger.info("Getting ranking for user ID: " + userId);
            
            if (db.DbConnect()) {
                if (db.RunQuery(sql, params, 2, true)) {
                    ResultSet rs = db.Rs;
                    if (rs != null && rs.next()) {
                        ranking = new RankingDTO();
                        ranking.setRank(rs.getInt("rank"));
                        ranking.setUserId(rs.getInt("user_id"));
                        ranking.setNickname(rs.getString("nickname"));
                        ranking.setIntro(rs.getString("intro"));
                        ranking.setScore(rs.getInt("score"));
                        ranking.setType(rs.getString("type"));
                        
                        logger.info("Found ranking: " + ranking.getRank() + " for user: " + ranking.getNickname());
                    }
                }
            }
        } catch (Exception e) {
            logger.severe("Error getting user ranking: " + e.getMessage());
        } finally {
            try {
                db.DbDisConnect();
            } catch (Exception e) {
                logger.warning("Error closing database connection: " + e.getMessage());
            }
        }
        
        return ranking;
    }

    /***********************************************************************
     * getScoreByType()  : 랭킹 타입별 점수 조회
     * @param rs         : ResultSet 객체
     * @param type       : 랭킹 타입 (words/points/dangos)
     * @return int       : 점수
     * @throws SQLException
     ***********************************************************************/
    private int getScoreByType(ResultSet rs, String type) throws SQLException {
        return switch (type) {
            case "words" -> rs.getInt("quiz_right");
            case "dangos" -> rs.getInt("dangos");
            default -> rs.getInt("point");
        };
    }
}
// #################################################################################################
// <END>
// ################################################################################################# 