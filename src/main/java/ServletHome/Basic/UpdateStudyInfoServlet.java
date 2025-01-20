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

/**
 * 서블릿 클래스: 학습 횟수, 포인트 등을 업데이트하는 서블릿입니다.
 */
@WebServlet("/UpdateStudyInfo")
public class UpdateStudyInfoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * doPost 메서드: 클라이언트에서 받은 학습 정보를 분석하여
     * TB_STUDY, TB_USER 테이블에 반영합니다.
     *
     * @param request  HttpServletRequest 객체
     * @param response HttpServletResponse 객체
     * @throws ServletException 서블릿 예외
     * @throws IOException      입출력 예외
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = "jdbc:oracle:thin:@cobyserver.iptime.org:1521:xe";
        String user = "dango";
        String password = "lingo";
        Connection connection = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            connection = DriverManager.getConnection(url, user, password);
            connection.setAutoCommit(false); // Start transaction

            // Parse all parameters
            int studyMinutes = Integer.parseInt(request.getParameter("timer"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            int wordsId = Integer.parseInt(request.getParameter("wordsId"));
            int japaneseId = Integer.parseInt(request.getParameter("japaneseId"));

            // Debugging log: Check existing study_date
            String debugQuery = "SELECT study_date FROM TB_USER WHERE user_id = ?";
            try (PreparedStatement debugStmt = connection.prepareStatement(debugQuery)) {
                debugStmt.setInt(1, userId);
                try (ResultSet rs = debugStmt.executeQuery()) {
                    while (rs.next()) {
                        response.getWriter().println("Existing study_date: " + rs.getDate("study_date"));
                    }
                }
            }

            // Update study_day
            String updateStudyDayQuery = "UPDATE TB_USER SET study_day = CASE " +
                                         "WHEN TRUNC(study_date) = TRUNC(SYSDATE) - 1 THEN study_day + 1 " +
                                         "WHEN TRUNC(study_date) < TRUNC(SYSDATE) - 1 THEN 0 " +
                                         "ELSE study_day END WHERE user_id = ?";
            try (PreparedStatement pstmt1 = connection.prepareStatement(updateStudyDayQuery)) {
                pstmt1.setInt(1, userId);
                int rowsAffected = pstmt1.executeUpdate();
                response.getWriter().println("study_day update affected rows: " + rowsAffected);
            }

            // Check if study record exists
            String checkStudyQuery = "SELECT study_id FROM TB_STUDY WHERE user_id = ? AND words_id = ?";
            try (PreparedStatement checkStmt = connection.prepareStatement(checkStudyQuery)) {
                checkStmt.setInt(1, userId);
                checkStmt.setInt(2, wordsId);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    // Update existing record
                    String updateStudyQuery = "UPDATE TB_STUDY SET japanese_id = ?, study_date = CURRENT_DATE, " +
                                            "study_count = study_count + 50 WHERE user_id = ? AND words_id = ?";
                    try (PreparedStatement pstmt = connection.prepareStatement(updateStudyQuery)) {
                        pstmt.setInt(1, japaneseId);
                        pstmt.setInt(2, userId);
                        pstmt.setInt(3, wordsId);
                        pstmt.executeUpdate();
                    }
                } else {
                    // Insert new record
                    String insertStudyQuery = "INSERT INTO TB_STUDY (study_id, user_id, words_id, japanese_id, study_count, study_date) " +
                                            "VALUES (SQ_STUDY_ID.NEXTVAL, ?, ?, ?, 50, CURRENT_DATE)";
                    try (PreparedStatement pstmt = connection.prepareStatement(insertStudyQuery)) {
                        pstmt.setInt(1, userId);
                        pstmt.setInt(2, wordsId);
                        pstmt.setInt(3, japaneseId);
                        pstmt.executeUpdate();
                    }
                }
            }

            // Update TB_USER
            String updateUserQuery = "UPDATE TB_USER SET study_date = CURRENT_DATE, study_time = study_time + ?, point = point + 50, total_point = total_point + 50 WHERE user_id = ?";
            try (PreparedStatement pstmt3 = connection.prepareStatement(updateUserQuery)) {
                pstmt3.setInt(1, studyMinutes);
                pstmt3.setInt(2, userId);
                pstmt3.executeUpdate();
            }

            connection.commit(); // Commit transaction
            response.getWriter().println("Update and cleanup successful.");

        } catch (ClassNotFoundException e) {
            response.getWriter().println("JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback(); // Rollback transaction on error
                } catch (SQLException rollbackEx) {
                    response.getWriter().println("Rollback failed: " + rollbackEx.getMessage());
                }
            }
            response.getWriter().println("Database error: " + e.getMessage());
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    response.getWriter().println("Failed to close connection: " + e.getMessage());
                }
            }
        }
    }
}
