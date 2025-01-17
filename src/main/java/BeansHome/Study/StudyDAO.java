package BeansHome.Study;

// ═════════════════════════════════════════════════════════════════════════════════════════
// 사용자정의 클래스 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
 * StudyDAO		    : 학습 진행 기록 DAO 클래스<br>
 * Inheritance	    : None
 ***********************************************************************/
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StudyDAO {
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역변수 관리 - 필수영역(인스턴스변수)
    // —————————————————————————————————————————————————————————————————————————————————————
    private Connection connection;

    // —————————————————————————————————————————————————————————————————————————————————————
    // 생성자 관리 - 필수영역(인스턴스함수)
    
    // —————————————————————————————————————————————————————————————————————————————————————
    /***********************************************************************
     * StudyDAO()       :  기본 생성자
     * @param connection: 데이터베이스 연결 객체
     ***********************************************************************/
    public StudyDAO(Connection connection) {
        this.connection = connection;
    }

    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역함수 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /***********************************************************************
     * getStudyData()   :  유저 ID로 학습 기록을 가져오는 함수
     * @param userId    :  유저 ID
     * @return StudyDTO :  학습 기록 DTO 객체
     * @throws SQLException : SQL 예외 처리
     ***********************************************************************/
    public StudyDTO getStudyData(int userId, int study_id) throws SQLException {
    	StudyDTO studyDTO = null;
        String query = "SELECT * FROM Tb_study WHERE user_id = ? and study_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, study_id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    studyDTO = new StudyDTO();
                    
                    studyDTO.setStudyId(rs.getInt("study_id"));
                    studyDTO.setUserId(rs.getInt("user_id"));
                    studyDTO.setWordsId(rs.getInt("words_id"));
                    studyDTO.setJapaneseId(rs.getInt("japanese_id"));
                    studyDTO.setStudyDate(rs.getDate("study_date"));
                    studyDTO.setStudyCount(rs.getInt("study_count"));
                }
            }
        }
        
        return studyDTO;
    }
}
