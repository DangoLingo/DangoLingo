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
    private static final DBOracleMgr db = DBOracleMgr.getInstance();
    
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
            ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);
        } catch (Exception Ex) {
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
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = db.getConnection();
            String query = switch (type) {
                case "words" -> "RANKING.SELECT_WORDS";
                case "points" -> "RANKING.SELECT_POINTS";
                case "dangos" -> "RANKING.SELECT_DANGOS";
                default -> "RANKING.SELECT_POINTS";
            };
            
            pstmt = db.getPreparedStatement(conn, query);
            pstmt.setInt(1, limit);
            rs = pstmt.executeQuery();
            
            int rank = 1;
            while (rs.next()) {
                RankingDTO ranking = new RankingDTO();
                ranking.setRank(rank++);
                ranking.setUserId(rs.getInt("user_id"));
                ranking.setNickname(rs.getString("nickname"));
                ranking.setProfileImage(rs.getString("profile_image"));
                ranking.setScore(getScoreByType(rs, type));
                ranking.setType(type);
                rankings.add(ranking);
            }
        } catch (Exception Ex) {
            ExceptionMgr.DisplayException(Ex);
            throw Ex;
        } finally {
            db.close(rs, pstmt, conn);
        }
        
        return rankings;
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

    public RankingDTO getUserRanking(int userId, String type) throws Exception {
        RankingDTO ranking = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = db.getConnection();
            pstmt = db.getPreparedStatement(conn, "RANKING.SELECT_USER_RANK");
            pstmt.setString(1, type);
            pstmt.setString(2, type);
            pstmt.setInt(3, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                ranking = new RankingDTO();
                ranking.setUserId(rs.getInt("user_id"));
                ranking.setNickname(rs.getString("nickname"));
                ranking.setProfileImage(rs.getString("profile_image"));
                ranking.setScore(rs.getInt("score"));
                ranking.setRank(rs.getInt("rank"));
                ranking.setType(type);
            }
        } catch (Exception Ex) {
            ExceptionMgr.DisplayException(Ex);
            throw Ex;
        } finally {
            db.close(rs, pstmt, conn);
        }

        return ranking;
    }
}
// #################################################################################################
// <END>
// ################################################################################################# 