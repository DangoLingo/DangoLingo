package DAO;

import model.RankingDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RankingDAO {
    private static final DBOracleMgr db = DBOracleMgr.getInstance();
    
    // 전체 랭킹 조회
    public List<RankingDTO> getRankings(String type, int limit) {
        List<RankingDTO> rankings = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String query = switch (type) {
            case "words" -> "RANKING.SELECT_WORDS";
            case "points" -> "RANKING.SELECT_POINTS";
            case "dangos" -> "RANKING.SELECT_DANGOS";
            default -> "RANKING.SELECT_POINTS";
        };
        
        try {
            conn = db.getConnection();
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
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close(rs);
            db.close(pstmt);
            db.close(conn);
        }
        
        return rankings;
    }
    
    // 사용자 랭킹 조회
    public RankingDTO getUserRanking(int userId, String type) {
        RankingDTO ranking = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = db.getConnection();
            pstmt = db.getPreparedStatement(conn, "RANKING.SELECT_USER_RANK");
            pstmt.setString(1, type);
            pstmt.setInt(2, userId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                ranking = new RankingDTO();
                ranking.setRank(rs.getInt("rank"));
                ranking.setUserId(userId);
                ranking.setNickname(rs.getString("nickname"));
                ranking.setProfileImage(rs.getString("profile_image"));
                ranking.setScore(getScoreByType(rs, type));
                ranking.setType(type);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close(rs);
            db.close(pstmt);
            db.close(conn);
        }
        
        return ranking;
    }
    
    private int getScoreByType(ResultSet rs, String type) throws SQLException {
        return switch (type) {
            case "words" -> rs.getInt("quiz_right");
            case "dangos" -> rs.getInt("dangos");
            default -> rs.getInt("point");
        };
    }
} 