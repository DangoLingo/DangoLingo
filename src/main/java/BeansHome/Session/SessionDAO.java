//#################################################################################################
//UserDAO.java - 사용자 DAO 모듈
//#################################################################################################
//═════════════════════════════════════════════════════════════════════════════════════════
//외부모듈 영역
//═════════════════════════════════════════════════════════════════════════════════════════
package BeansHome.Session;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import BeansHome.User.UserDAO;
import BeansHome.User.UserDTO;
import Common.ComMgr;
import Common.ExceptionMgr;
import DAO.DBOracleMgr;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.io.StringWriter;
import java.io.PrintWriter;
import oracle.jdbc.internal.OracleTypes;
import java.util.logging.ConsoleHandler;

//═════════════════════════════════════════════════════════════════════════════════════════
//사용자정의 클래스 영역
//═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
 * SessionDAO    : 사용자 DAO 클래스<br>
 * Inheritance : None
 ***********************************************************************/
public class SessionDAO {
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역상수 관리 - 필수영역
    // —————————————————————————————————————————————————————————————————————————————————————
    private static final Logger logger = Logger.getLogger(UserDAO.class.getName());
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역변수 관리 - 필수영역(인스턴스변수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /** DBMgr : 오라클 데이터베이스 DAO 객체 선언 */
    public DAO.DBOracleMgr DBMgr = null;
    // —————————————————————————————————————————————————————————————————————————————————————
    // 생성자 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /***********************************************************************
     * SessionDAO()    : 생성자
     * @param void  : None
     ***********************************************************************/
    public SessionDAO() {
        try
        {
            // -----------------------------------------------------------------------------
            // 로거 설정
            // -----------------------------------------------------------------------------
            logger.setLevel(Level.ALL);
            ConsoleHandler handler = new ConsoleHandler();
            handler.setLevel(Level.ALL);
            logger.addHandler(handler);

            logger.info("\n=== SessionDAO Initialization ===");
            // -----------------------------------------------------------------------------
            // 초기화 작업 관리
            // -----------------------------------------------------------------------------
            ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);

            this.DBMgr = new DAO.DBOracleMgr();								// DAO 객체 생성
            this.DBMgr.SetConnectionStringFromProperties("db.properties");	// DB 연결문자열 읽기

            // -----------------------------------------------------------------------------
        }
        catch (Exception Ex)
        {
            logger.severe("Error in constructor: " + Ex.getMessage());
            ExceptionMgr.DisplayException(Ex);	// 예외처리(콘솔)
        }
    }

    /***********************************************************************
     * ReadSessionList()	: 오라클 데이터베이스에서 특정 유저의 정보 읽기
     * @param  userId	: 유저 번호(조건용)
     * @param  friends	: 사원정보 DTO(결과 반환용)
     * @return boolean	: 사원정보 검색 처리 여부(true|false)
     * @throws Exception
     ***********************************************************************/
    public int readSession(int userId) throws Exception
    {
        String sSql = null;						// DML 문장
        Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
        int result = 0;

        try
        {
            // -----------------------------------------------------------------------------
            // 사원정보 읽기
            // -----------------------------------------------------------------------------
            if (this.DBMgr.DbConnect() == true)
            {
                logger.info("userId: " + userId);
                // 사원정보 읽기
                sSql = "BEGIN SP_SESSION_COUNT_R(?,?); END;";

                // IN 파라미터 만큼만 할당
                oPaValue = new Object[1];

                oPaValue[0] = userId;

                if (this.DBMgr.RunQuery(sSql, oPaValue, 2, true) == true)
                {
                    while(this.DBMgr.Rs.next() == true)
                    {
                        result = this.DBMgr.Rs.getInt("STUDY_WORDS");
                    }

                }
            }
            // -----------------------------------------------------------------------------
        }
        catch (Exception Ex)
        {
            Common.ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
        } finally {
            this.DBMgr.DbDisConnect();
        }
        return result;
    }

}