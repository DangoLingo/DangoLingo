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
<<<<<<< HEAD
=======
import java.io.PrintWriter;
import java.io.StringWriter;
import oracle.jdbc.internal.OracleTypes;
import java.util.logging.ConsoleHandler;
>>>>>>> dev

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
<<<<<<< HEAD

=======
    
>>>>>>> dev
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
<<<<<<< HEAD
            logger.setLevel(Level.ALL);
=======
            // 로거 설정
            logger.setLevel(Level.ALL);
            ConsoleHandler handler = new ConsoleHandler();
            handler.setLevel(Level.ALL);
            logger.addHandler(handler);
            
            logger.info("\n=== RankingDAO Initialization ===");
>>>>>>> dev
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
     * getRankings()      : 포인트 기반 랭킹 목록 조회
     * @param limit       : 조회할 랭킹 수
     * @return List<RankingDTO> : 랭킹 목록
     ***********************************************************************/
    public List<RankingDTO> getRankings() {
        List<RankingDTO> rankings = new ArrayList<>();
<<<<<<< HEAD

        String sql;
        switch (type) {
            case "words":
                sql = "SELECT * FROM (" +
                        "SELECT u.*, DENSE_RANK() OVER (ORDER BY quiz_right DESC) as rank " +
                        "FROM TB_USER u) WHERE rank <= ?";
                break;
            case "points":
                sql = "SELECT * FROM (" +
                        "SELECT u.*, DENSE_RANK() OVER (ORDER BY point DESC) as rank " +
                        "FROM TB_USER u) WHERE rank <= ?";
                break;
            case "dangos":
                sql = "SELECT * FROM (" +
                        "SELECT u.*, DENSE_RANK() OVER (ORDER BY dangos DESC) as rank " +
                        "FROM TB_USER u) WHERE rank <= ?";
                break;
            default:
                sql = "SELECT * FROM (" +
                        "SELECT u.*, DENSE_RANK() OVER (ORDER BY point DESC) as rank " +
                        "FROM TB_USER u) WHERE rank <= ?";
                break;
        }


        Object[] params = new Object[]{limit};

=======
        String sql = "{call SP_GET_POINT_RANKINGS(?)}";
        Object[] params = new Object[0]; // 파라미터 없음
        
>>>>>>> dev
        try {
            logger.info("\n=== Getting Point Rankings ===");
            
            if (db.DbConnect()) {
                // OUT 파라미터의 위치를 1로 지정 (이제 IN 파라미터가 없음)
                if (db.RunQuery(sql, params, 1, true)) {
                    ResultSet rs = db.Rs;
                    logger.info("\n=== Query executed successfully ===");
                    
                    while (rs != null && rs.next()) {
                        RankingDTO ranking = new RankingDTO();
                        ranking.setRank(rs.getInt("rank"));
                        ranking.setUserId(rs.getInt("user_id"));
                        ranking.setNickname(rs.getString("nickname"));
                        ranking.setIntro(rs.getString("intro"));
                        ranking.setPoint(rs.getInt("score"));
                        
                        rankings.add(ranking);
                        logger.info("Added ranking - Rank: " + ranking.getRank() + 
                                  ", User: " + ranking.getNickname() + 
                                  ", Point: " + ranking.getPoint());
                    }
                } else {
                    logger.warning("Failed to execute rankings query");
                }
            }
        } catch (Exception e) {
            logger.severe("Error getting rankings: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                db.DbDisConnect();
            } catch (Exception e) {
                logger.warning("Error closing database connection: " + e.getMessage());
            }
        }

        return rankings;
    }

    /***********************************************************************
     * getUserRanking()    : 사용자의 포인트 랭킹 정보 조회
     * @param userId       : 사용자 ID
<<<<<<< HEAD
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
        int result;
        switch (type) {
            case "words":
                result = rs.getInt("quiz_right");
                break;
            case "dangos":
                result = rs.getInt("dangos");
                break;
            default:
                result = rs.getInt("point");
                break;
=======
     * @return RankingDTO  : 랭킹 정보
     ***********************************************************************/
    public RankingDTO getUserRanking(int userId) {
        RankingDTO ranking = null;
        String sql = "{call SP_GET_USER_POINT_RANKING(?, ?)}";
        Object[] params = new Object[1];
        
        try {
            logger.info("\n=== Getting User Ranking Info ===");
            logger.info("User ID: [" + userId + "]");
            
            if (db.DbConnect()) {
                params[0] = userId;
                
                if (db.RunQuery(sql, params, 2, true)) {
                    ResultSet rs = db.Rs;
                    logger.info("\n=== Query executed successfully ===");
                    
                    if (rs != null && rs.next()) {
                        ranking = new RankingDTO();
                        ranking.setRank(rs.getInt("rank"));
                        ranking.setUserId(rs.getInt("user_id"));
                        ranking.setNickname(rs.getString("nickname"));
                        ranking.setIntro(rs.getString("intro"));
                        ranking.setPoint(rs.getInt("score"));
                        
                        logger.info("Found ranking: " + ranking.getRank() + " for user: " + ranking.getNickname());
                    }
                }
            }
        } catch (Exception e) {
            logger.severe("Error getting user ranking: " + e.getMessage());
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            logger.severe("Stack trace: " + sw.toString());
        } finally {
            try {
                db.DbDisConnect();
            } catch (Exception e) {
                logger.warning("Error closing database connection: " + e.getMessage());
            }
>>>>>>> dev
        }
        return result;

    }
}
// #################################################################################################
// <END>
// ################################################################################################# 