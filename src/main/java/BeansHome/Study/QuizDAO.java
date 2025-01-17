//#################################################################################################
//QuizDAO.java - 퀴즈 DAO 모듈
//#################################################################################################
//═════════════════════════════════════════════════════════════════════════════════════════
//외부모듈 영역
//═════════════════════════════════════════════════════════════════════════════════════════
package BeansHome.Study;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import BeansHome.Japanese.JapaneseDTO;
import Common.ExceptionMgr;
import DAO.DBOracleMgr;

//═════════════════════════════════════════════════════════════════════════════════════════
//사용자정의 클래스 영역
//═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
 * QuizDAO : 퀴즈 DAO 클래스<br>
 * Inheritance : None | 부모 클래스 명
 ***********************************************************************/
public class QuizDAO {
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역변수 관리 - 필수영역(인스턴스변수)
	// —————————————————————————————————————————————————————————————————————————————————————
	/** DBMgr : 오라클 데이터베이스 DAO 객체 */
	public DBOracleMgr DBMgr = null;

	// —————————————————————————————————————————————————————————————————————————————————————
	// 생성자 관리 - 필수영역(인스턴스함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	/***********************************************************************
	 * QuizDAO() : 생성자
	 * 
	 * @param void : None
	 ***********************************************************************/
	public QuizDAO() {
		try {
			// -----------------------------------------------------------------------------
			// 기타 초기화 작업 관리
			// -----------------------------------------------------------------------------
			ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);

			this.DBMgr = new DBOracleMgr();

			this.DBMgr.SetConnectionString("cobyserver.iptime.org", 1521, "dango", "lingo", "XE");
			// -----------------------------------------------------------------------------
		} catch (Exception Ex) {
			ExceptionMgr.DisplayException(Ex); // 예외처리(콘솔)
		}
	}

	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역함수 관리 - 필수영역(인스턴스함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	/***********************************************************************
	 * readJapaneseList() : 랜덤 단어 리스트 읽기
	 * 
	 * @param words_id  : 단어장 종류 (조건용)
	 * @param row_count : 가져올 단어 개수 (조건용)
	 * @return String : 결과 문자열
	 * @throws Exception
	 ***********************************************************************/
	public boolean ReadQuizList(int words_id, int rowCount, ArrayList<JapaneseDTO> quizList) throws Exception {
		String sSql = null; // DML 문장
		Object[] oPaValue = null; // DML 문장에 필요한 파라미터 객체
		boolean bResult = false;

		try {
			// -----------------------------------------------------------------
			// 퀴즈 정보 읽기
			// -----------------------------------------------------------------
			if (this.DBMgr.DbConnect() == true) {
				// 프로시저 호출 SQL
				sSql = "BEGIN sp_get_random_words(?, ?, ?); END;";

				// IN 파라미터 값 설정 (3번째는 OUT 파라미터)
				oPaValue = new Object[2]; // 3번째 OUT 파라미터는 커서로 처리되므로 2로 설정
				oPaValue[0] = words_id; // Example: 특정 words_id
				oPaValue[1] = rowCount; // Example: 가져올 행 개수

				// PaValue의 null 값을 처리 (null이면 빈 문자열로 대체)
				for (int i = 0; i < oPaValue.length; i++) {
					if (oPaValue[i] == null) {
						oPaValue[i] = ""; // null이면 빈 문자열로 처리
					}
				}

				// 프로시저 실행
				if (this.DBMgr.RunQuery(sSql, oPaValue, 3, true) == true) {
					// 결과 커서 읽기
					while (this.DBMgr.Rs.next()) {
						JapaneseDTO word = new JapaneseDTO();

						// DTO에 값 설정
						word.setJapaneseId(this.DBMgr.Rs.getInt("japanese_id")); // JAPANESE_ID 컬럼 추가
						word.setWordsId(this.DBMgr.Rs.getInt("words_id"));
						word.setKanji(this.DBMgr.Rs.getString("kanji"));
						word.setHiragana(this.DBMgr.Rs.getString("hiragana"));
						word.setKanjiKr(this.DBMgr.Rs.getString("kanji_kr"));
						word.setExample(this.DBMgr.Rs.getString("example")); // EXAMPLE 컬럼 추가
						word.setExampleKr(this.DBMgr.Rs.getString("example_kr")); // EXAMPLE_KR 컬럼 추가

						// 리스트에 추가
						quizList.add(word); // quizList에 word 추가
					}

					bResult = true;
				}
			}
			// -----------------------------------------------------------------
		} catch (Exception Ex) {
			Common.ExceptionMgr.DisplayException(Ex); // 예외처리(콘솔)
		}

		return bResult;
	}

	public boolean updateUserStats(int user_id, int quiz_count, int quiz_right) throws Exception {
	    String sSql = null; // DML 문장
	    Object[] oPaValue = null; // DML 문장에 필요한 파라미터 객체
	    boolean bResult = false;

	    try {
	        // -----------------------------------------------------------------
	        // 사용자 통계 업데이트
	        // -----------------------------------------------------------------
	        if (this.DBMgr.DbConnect()) {
	            // 프로시저 호출 SQL (sp_update_quiz_stats 프로시저 호출)
	            sSql = "BEGIN sp_update_quiz_stats(?, ?, ?); END;"; // 프로시저 사용

	            // IN 파라미터 값 설정
	            oPaValue = new Object[3]; // userId, quiz_count, quiz_right
	            oPaValue[0] = user_id; // 사용자 ID
	            oPaValue[1] = quiz_count; // 퀴즈 개수만큼 더하기
	            oPaValue[2] = quiz_right; // 오답 개수만큼 더하기 

	            // 프로시저 실행
	            if (this.DBMgr.RunQuery(sSql, oPaValue, 0, true)) {
	                bResult = true; // 성공
	                System.out.println("update프로시저 성공");
	            }
	        }
	        // -----------------------------------------------------------------
	    } catch (Exception Ex) {
	        Common.ExceptionMgr.DisplayException(Ex); // 예외 처리
	    }

	    return bResult;
	}



}
