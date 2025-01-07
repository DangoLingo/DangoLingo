package DAO;

import model.StudyDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudyDAO {
    private static final DBOracleMgr db = DBOracleMgr.getInstance();
    
    // 학습 기록 추가
    public boolean addStudy(StudyDTO study) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = db.getConnection();
            pstmt = db.getPreparedStatement(conn, "STUDY.INSERT");
            pstmt.setInt(1, study.getUserId());
            pstmt.setDate(2, new java.sql.Date(study.getStudyDate().getTime()));
            pstmt.setInt(3, study.getStudyCount());
            pstmt.setInt(4, study.getStudyLevel());
            
            success = pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close(pstmt);
            db.close(conn);
        }
        
        return success;
    }

    // 특정 기간의 학습 기록 조회
    public List<StudyDTO> getStudiesByPeriod(int userId, Date startDate, Date endDate) {
        List<StudyDTO> studies = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = db.getConnection();
            pstmt = db.getPreparedStatement(conn, "STUDY.SELECT_BY_PERIOD");
            pstmt.setInt(1, userId);
            pstmt.setDate(2, new java.sql.Date(startDate.getTime()));
            pstmt.setDate(3, new java.sql.Date(endDate.getTime()));
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                StudyDTO study = new StudyDTO();
                study.setStudyId(rs.getInt("study_id"));
                study.setUserId(rs.getInt("user_id"));
                study.setStudyDate(rs.getDate("study_date"));
                study.setStudyCount(rs.getInt("study_count"));
                study.setStudyLevel(rs.getInt("study_level"));
                studies.add(study);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close(rs);
            db.close(pstmt);
            db.close(conn);
        }
        
        return studies;
    }

    // 사용자의 최근 52주 학습 기록 조회
    public List<StudyDTO> getStudyStreak(int userId) {
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
                study.setStudyId(rs.getInt("study_id"));
                study.setUserId(rs.getInt("user_id"));
                study.setStudyDate(rs.getDate("study_date"));
                study.setStudyCount(rs.getInt("study_count"));
                study.setStudyLevel(rs.getInt("study_level"));
                streaks.add(study);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close(rs);
            db.close(pstmt);
            db.close(conn);
        }
        
        return streaks;
    }
} 