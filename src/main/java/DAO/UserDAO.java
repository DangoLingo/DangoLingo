package DAO;

import model.UserDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private static final DBOracleMgr db = DBOracleMgr.getInstance();
    
    // 사용자 조회 (ID)
    public UserDTO getUserById(int userId) {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = db.getConnection();
            pstmt = db.getPreparedStatement(conn, "USER.SELECT_BY_ID");
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                user = createUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close(rs);
            db.close(pstmt);
            db.close(conn);
        }
        
        return user;
    }
    
    // 사용자 조회 (이메일)
    public UserDTO getUserByEmail(String email) {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = db.getConnection();
            pstmt = db.getPreparedStatement(conn, "USER.SELECT_BY_EMAIL");
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                user = createUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close(rs);
            db.close(pstmt);
            db.close(conn);
        }
        
        return user;
    }
    
    // 사용자 등록
    public boolean insertUser(UserDTO user) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = db.getConnection();
            pstmt = db.getPreparedStatement(conn, "USER.INSERT");
            pstmt.setString(1, user.getEmail());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getName());
            pstmt.setString(4, user.getNickname());
            pstmt.setString(5, user.getIntro());
            pstmt.setString(6, user.getProfileImage());
            
            success = pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close(pstmt);
            db.close(conn);
        }
        
        return success;
    }
    
    // 사용자 정보 수정
    public boolean updateUser(UserDTO user) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = db.getConnection();
            pstmt = db.getPreparedStatement(conn, "USER.UPDATE");
            pstmt.setString(1, user.getPassword());
            pstmt.setString(2, user.getName());
            pstmt.setString(3, user.getNickname());
            pstmt.setString(4, user.getIntro());
            pstmt.setInt(5, user.getUserId());
            
            success = pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close(pstmt);
            db.close(conn);
        }
        
        return success;
    }
    
    // 학습 통계 업데이트
    public boolean updateUserStats(int userId, int studyDay, int quizCount, int quizRight, int point) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = db.getConnection();
            pstmt = db.getPreparedStatement(conn, "USER.UPDATE_STATS");
            pstmt.setInt(1, studyDay);
            pstmt.setInt(2, quizCount);
            pstmt.setInt(3, quizRight);
            pstmt.setInt(4, point);
            pstmt.setInt(5, userId);
            
            success = pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close(pstmt);
            db.close(conn);
        }
        
        return success;
    }
    
    // 랭킹 목록 조회
    public List<UserDTO> getRankingList(String type, int limit) {
        List<UserDTO> users = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String query = switch (type) {
            case "words" -> "USER.SELECT_RANKING_WORDS";
            case "dangos" -> "USER.SELECT_RANKING_DANGOS";
            default -> "USER.SELECT_RANKING_POINTS";
        };
        
        try {
            conn = db.getConnection();
            pstmt = db.getPreparedStatement(conn, query);
            pstmt.setInt(1, limit);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                users.add(createUserFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close(rs);
            db.close(pstmt);
            db.close(conn);
        }
        
        return users;
    }
    
    // ResultSet에서 UserDTO 객체 생성 (중복 코드 제거)
    private UserDTO createUserFromResultSet(ResultSet rs) throws SQLException {
        UserDTO user = new UserDTO();
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
        return user;
    }
} 