package ServletHome.Basic;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 코드 기능: 단어 학습 세션 정보를 DB에 기록하여 학습 상태를 관리합니다.

@WebServlet("/UpdateSession")
public class UpdateSessionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * doPost 메서드: 요청에서 파라미터를 추출하여 TB_SESSION, TB_STUDY를 업데이트합니다.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection connection = null;

		try {
			String url = "jdbc:oracle:thin:@cobyserver.iptime.org:1521:xe";
			String user = "dango";
			String password = "lingo";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			connection = DriverManager.getConnection(url, user, password);

			// Get parameters
			int userId = Integer.parseInt(request.getParameter("userId"));
			int wordsId = Integer.parseInt(request.getParameter("wordsId"));
			int japaneseId = Integer.parseInt(request.getParameter("japaneseId"));
			String status = request.getParameter("status");

			connection.setAutoCommit(false);

			// First, try to get existing study_id
			int studyId = getOrCreateStudyId(connection, userId, wordsId, japaneseId);

			// Insert into TB_SESSION
			insertSessionRecord(connection, studyId, japaneseId, status, wordsId);

			connection.commit();
			response.setStatus(HttpServletResponse.SC_OK);

		} catch (Exception e) {
			if (connection != null) {
				try {
					connection.rollback();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		} finally {
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	/**
	 * getOrCreateStudyId 메서드: 기존 학습 데이터가 있는지 확인하고, 없으면 새로 생성하여 study_id를 반환합니다.
	 */
	private int getOrCreateStudyId(Connection conn, int userId, int wordsId, int japaneseId) throws SQLException {
		// Try to get existing study_id
		String selectSql = "SELECT study_id FROM TB_STUDY WHERE user_id = ? AND words_id = ?";
		try (PreparedStatement stmt = conn.prepareStatement(selectSql)) {
			stmt.setInt(1, userId);
			stmt.setInt(2, wordsId);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				return rs.getInt("study_id");
			}
		}

		// If no existing record, create new one
		String insertSql = "INSERT INTO TB_STUDY (study_id, user_id, words_id, japanese_id, study_count, study_date) "
				+ "VALUES (SQ_STUDY_ID.NEXTVAL, ?, ?, ?, 0, CURRENT_DATE)";
		try (PreparedStatement stmt = conn.prepareStatement(insertSql, new String[] { "study_id" })) {
			stmt.setInt(1, userId);
			stmt.setInt(2, wordsId);
			stmt.setInt(3, japaneseId);
			stmt.executeUpdate();

			ResultSet rs = stmt.getGeneratedKeys();
			if (rs.next()) {
				return rs.getInt(1);
			}
		}

		throw new SQLException("Failed to create new study record");
	}

	/**
	 * TB_SESSION 테이블에 새로운 레코드 삽입 또는 기존 레코드 업데이트
	 *
	 * @param conn       데이터베이스 연결 객체
	 * @param studyId    학습 ID
	 * @param japaneseId 일본어 ID
	 * @param status     학습 상태 (예: 'Y' 또는 'N')
	 * @throws SQLException 데이터베이스 관련 예외 처리
	 */
	private void insertSessionRecord(Connection conn, int studyId, int japaneseId, String status, int wordsId) throws SQLException {
		// 기존 기록 확인
		String checkSql = "SELECT is_learned FROM TB_SESSION WHERE study_id = ? AND japanese_id = ?";
		try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
			checkStmt.setInt(1, studyId);
			checkStmt.setInt(2, japaneseId);
			ResultSet rs = checkStmt.executeQuery();

			if (rs.next()) {
				// 기존 기록 업데이트
				String updateSql = "UPDATE TB_SESSION SET is_learned = ? WHERE study_id = ? AND japanese_id = ?";
				try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
					updateStmt.setString(1, status);
					updateStmt.setInt(2, studyId);
					updateStmt.setInt(3, japaneseId);
					updateStmt.executeUpdate();
				}
			} else {
				// 새로운 기록 삽입
				String insertSql = "INSERT INTO TB_SESSION (study_id, japanese_id, is_learned) VALUES (?, ?, ?)";
				try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
					insertStmt.setInt(1, studyId);
					insertStmt.setInt(2, japaneseId);
					insertStmt.setString(3, status);
					insertStmt.executeUpdate();
				}
			}
		}

		// TB_STUDY 테이블 업데이트 (is_learned = 'Y' 개수로 study_count 계산)
		String updateStudySql = "UPDATE TB_STUDY " + "   SET japanese_id = ?, " + "       study_date = CURRENT_DATE, "
				+ "       study_count = (" + "           SELECT COUNT(*) " + "           FROM TB_SESSION "
				+ "           WHERE study_id = ? " + "             AND is_learned = 'Y'" + "       ) "
				+ " WHERE study_id = ? AND words_id = ?"; // Added words_id condition
		try (PreparedStatement stmt = conn.prepareStatement(updateStudySql)) {
			stmt.setInt(1, japaneseId);
			stmt.setInt(2, studyId);
			stmt.setInt(3, studyId);
			stmt.setInt(4, wordsId); // Set words_id parameter
			stmt.executeUpdate();
		}
	}

}
