//#################################################################################################
//StudyDAO.java - 학습 진행 기록 DAO 모듈
//#################################################################################################
//═════════════════════════════════════════════════════════════════════════════════════════
//외부모듈 영역
//═════════════════════════════════════════════════════════════════════════════════════════
package BeansHome.Study;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.ConsoleHandler;
import java.util.logging.Level;

import BeansHome.User.UserDAO;
import BeansHome.User.UserDTO;
import Common.ExceptionMgr;
import DAO.DBOracleMgr;


//═════════════════════════════════════════════════════════════════════════════════════════
//사용자정의 클래스 영역
//═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
* StudyDAO   : 학습 진행 기록 DAO 클래스<br>
* Inheritance : None
***********************************************************************/
public class StudyDAO {
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역상수 관리 - 필수영역
    // —————————————————————————————————————————————————————————————————————————————————————
    private static final DBOracleMgr db = new DBOracleMgr();
    private static final Logger logger = Logger.getLogger(UserDAO.class.getName());

    // —————————————————————————————————————————————————————————————————————————————————————
    // 생성자 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /***********************************************************************
    * StudyDAO()   : 생성자
    * @param void  : None
    ***********************************************************************/
    public StudyDAO() {
        try {
            // 로거 설정
            logger.setLevel(Level.ALL);
            ConsoleHandler handler = new ConsoleHandler();
            handler.setLevel(Level.ALL);
            logger.addHandler(handler);

            logger.info("\n=== UserDAO Initialization ===");
            ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);

            // DB 연결 설정
            db.SetConnectionStringFromProperties("db.properties");
        } catch (Exception Ex) {
            logger.severe("Error in constructor: " + Ex.getMessage());
            ExceptionMgr.DisplayException(Ex);
        }
    }

    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역함수 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /***********************************************************************
     * readCurrentStudy()   : 등급별 가장 최근 학습한 단어장 읽어오기
     * @param user          : 사용자 DTO
     * @return boolean      : 업데이트 성공 여부
     * @throws Exception
     ***********************************************************************/
    public boolean readCurrentStudy(int userId, int wordsId, int totalCheck, StudyDTO study) throws Exception {
        String sql = "BEGIN SP_STUDY_RECENT_R(?,?,?,?); END;";
        Object[] params = new Object[]{
                userId,
                wordsId,
                totalCheck
        };

        try {
            logger.info("Attempting database connection...");
            if (!db.DbConnect()) {
                logger.severe("Failed to connect to database");
                throw new Exception("데이터베이스 연결에 실패했습니다.");
            }
            logger.info("Database connected successfully");

            if (db.RunQuery(sql, params, 4, true)) {
                ResultSet rs = db.Rs;
                if (rs.next()) {
                    study.setWordsId(rs.getInt("WORDS_ID"));
                    study.setStudyDate(rs.getDate("STUDY_DATE"));
                   logger.info("Study found: " + study.getWordsId());
                } else {
                    logger.warning("No study found with ID: " + userId);
                }

                return true;
            }
            logger.severe("Failed to execute update procedure");
            return false;
        } catch (Exception e) {
            logger.severe("Error during select: " + e.getMessage());
            Common.ExceptionMgr.DisplayException(e);		// 예외처리(콘솔)
        } finally {
            try {
                db.DbDisConnect();
                logger.info("Database connection closed");
            } catch (Exception e) {
                logger.warning("Error closing database connection: " + e.getMessage());
            }
            return false;
        }
    }

    /***********************************************************************
     * readCurrentStudy()   : 등급별 가장 최근 학습한 단어장 읽어오기
     * @param user          : 사용자 DTO
     * @return boolean      : 업데이트 성공 여부
     * @throws Exception
     ***********************************************************************/
    public boolean readStudyCounts(int userId, int wordsId, ArrayList<StudyDTO> studyCounts) throws Exception {
        String sql = "BEGIN SP_STUDY_COUNT_R(?,?,?); END;";
        ArrayList<StudyDTO> temp = new ArrayList<>();
        Object[] params = new Object[]{
                userId,
                wordsId
        };

        try {
            logger.info("Attempting database connection...");
            if (!db.DbConnect()) {
                logger.severe("Failed to connect to database");
                throw new Exception("데이터베이스 연결에 실패했습니다.");
            }
            logger.info("Database connected successfully");

            if (db.RunQuery(sql, params, 3, true)) {
                ResultSet rs = db.Rs;
                while(rs.next() == true)
                {
                    StudyDTO tmpStudy = new StudyDTO();

                    tmpStudy.setWordsId(rs.getInt("WORDS_ID"));
                    if(rs.getInt("STUDY_COUNT") > 50) {
                        tmpStudy.setStudyCount(50);
                    } else {
                        tmpStudy.setStudyCount(rs.getInt("STUDY_COUNT"));
                    }
                    logger.info("TMP STUDY ID: " + tmpStudy.getWordsId());
                    temp.add(tmpStudy);
                }
                logger.info("Temp size: " + temp.size());

                for(int i = 1, j = 0; i < 11; i++) {
                    StudyDTO study = new StudyDTO();
                    if(temp.size() > j && temp.get(j).getWordsId() % 100 == i) {
                        study.setWordsId(temp.get(j).getWordsId());
                        study.setStudyCount(temp.get(j++).getStudyCount());
                    } else {
                        study.setWordsId(wordsId * 100 + i);
                        study.setStudyCount(0);
                    }
                    logger.info("STUDY ID: " + study.getWordsId());
                    studyCounts.add(study);
                }
                return true;
            } else {
            	for(int i = 1; i < 11; i++) {
                    StudyDTO study = new StudyDTO();
                    study.setWordsId(wordsId * 100 + i);
                    study.setStudyCount(0);
                    studyCounts.add(study);
                }
                return true;
            }
        } catch (Exception e) {
            logger.severe("Error during select: " + e.getMessage());
            Common.ExceptionMgr.DisplayException(e);		// 예외처리(콘솔)
        } finally {
            try {
                db.DbDisConnect();
                logger.info("Database connection closed");
            } catch (Exception e) {
                logger.warning("Error closing database connection: " + e.getMessage());
            }
            return false;
        }
    }

    /***********************************************************************
    * insertStudyRecord() : 학습 기록 추가
    * @param study        : 학습 기록 DTO
    * @return boolean     : 추가 성공 여부
    * @throws Exception
    ***********************************************************************/
    public boolean insertStudyRecord(StudyDTO study) throws Exception {
        String sql = "INSERT INTO TB_STUDY (USER_ID, STUDY_DATE, STUDY_COUNT, STUDY_LEVEL) " +
                     "VALUES (?, ?, ?, ?)";
        
        Object[] params = new Object[]{
            study.getUserId(),
            study.getStudyDate(),
            study.getStudyCount(),
            study.getStudyLevel()
        };
        
        try {
            return db.RunQuery(sql, params, 0, false); // false는 INSERT 쿼리임을 의미
        } catch (Exception Ex) {
            ExceptionMgr.DisplayException(Ex);
            throw Ex;
        }
    }
}
//#################################################################################################
//<END>
//#################################################################################################

