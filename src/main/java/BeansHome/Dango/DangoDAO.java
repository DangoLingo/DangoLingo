//#################################################################################################
//UserDAO.java - 사용자 DAO 모듈
//#################################################################################################
//═════════════════════════════════════════════════════════════════════════════════════════
//외부모듈 영역
//═════════════════════════════════════════════════════════════════════════════════════════
package BeansHome.Dango;

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
 * DangoDAO    : 사용자 DAO 클래스<br>
 * Inheritance : None
 ***********************************************************************/
public class DangoDAO {
    private static final Logger logger = Logger.getLogger(DangoDAO.class.getName());
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역상수 관리 - 필수영역
    // —————————————————————————————————————————————————————————————————————————————————————
	
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역변수 관리 - 필수영역(인스턴스변수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /** DBMgr : 오라클 데이터베이스 DAO 객체 선언 */
    public DAO.DBOracleMgr DBMgr = null;
    // —————————————————————————————————————————————————————————————————————————————————————
    // 생성자 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /***********************************************************************
     * DangoDAO()    : 생성자
     * @param void  : None
     ***********************************************************************/
    public DangoDAO() 
    {
		try
		{
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
			ExceptionMgr.DisplayException(Ex);	// 예외처리(콘솔)
		}
	}
    /***********************************************************************
     * ReadBoardList()	: 오라클 데이터베이스에서 당고 정보 읽기
     * @param  userId	: 유저 번호(조건용)
     * @return boolean	: 사원정보 검색 처리 여부(true|false)
     * @throws Exception
     ***********************************************************************/
    public boolean ReadBoardList(Integer userId) throws Exception
    {
        String sSql = null;
        Object[] oPaValue = null;
        boolean bResult = false;

        try {
            if (this.DBMgr.DbConnect()) {
                // SP_IMG_R 프로시저 호출 준비
                sSql = "{call SP_IMG_R(?, ?)}";  // 저장 프로시저 호출 구문 수정
                
                // 파라미터 설정 (IN: userId, OUT: cursor)
                oPaValue = new Object[1];
                oPaValue[0] = userId;                   // IN parameter

                // 프로시저 실행 (2개 파라미터, OUT 파라미터 있음)
                if (this.DBMgr.RunQuery(sSql, oPaValue, 2, true)) {
                    // ResultSet 가져오기
                    if (this.DBMgr.Rs != null) {
                        bResult = true;
                    }
                }
            }
        } catch (Exception Ex) {
            logger.severe("Error in ReadBoardList: " + Ex.getMessage());
            ExceptionMgr.DisplayException(Ex);
        }
        return bResult;
    }
    
    /***********************************************************************
     * UpdatePoint()	: 오라클 데이터베이스에서 point 수정하기
     * @param  userId	: 유저 번호(조건용)
     * @param  Deduction: 차감 point 
     * @return boolean	: point 수정 처리 여부(true|false)
     * @throws Exception
     ***********************************************************************/
    public boolean UpdatePoint(Integer userId,Integer Deduction) throws Exception
    {
        String sSql = null;						// DML 문장
        Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
        boolean bResult = false;

        try
        {
            // -----------------------------------------------------------------------------
            // 데이터베이스에서 point 수정하기
            // -----------------------------------------------------------------------------
            if (this.DBMgr.DbConnect() == true)
            {
                // 사원정보 읽기
                sSql = "BEGIN SP_UPDATE_USER_POINTS(?,?,?); END;";

                // IN 파라미터 만큼만 할당
                oPaValue = new Object[2];

                oPaValue[0] = userId;
                oPaValue[1] = Deduction;

                if (this.DBMgr.RunQuery(sSql, oPaValue, 3, true) == true)
                {
                    bResult = true;
                }
            }
            // -----------------------------------------------------------------------------
        }
        catch (Exception Ex)
        {
            Common.ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
        }
        return bResult;
    }
    
    /***********************************************************************
     * RandomImg()		: 오라클 데이터베이스에서 이미지 데이터 뽑기
     * @return boolean	: 사원정보 검색 처리 여부(true|false)
     * @throws Exception
     ***********************************************************************/
    public boolean RandomImg() throws Exception
    {
        String sSql = null;						// DML 문장
        Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
        boolean bResult = false;

        try
        {
            // -----------------------------------------------------------------------------
            // 데이터베이스에서 이미지 데이터 뽑기
            // -----------------------------------------------------------------------------
            if (this.DBMgr.DbConnect() == true)
            {
                // 사원정보 읽기
                sSql = "BEGIN SP_IMG_RANDOM(?); END;";

                // IN 파라미터 만큼만 할당
                oPaValue = new Object[0];

                if (this.DBMgr.RunQuery(sSql, oPaValue, 1, true) == true)
                {
                    bResult = true;
                }
            }
            // -----------------------------------------------------------------------------
        }
        catch (Exception Ex)
        {
            Common.ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
        }
        return bResult;
    }

    /***********************************************************************
     * InsertDango()		: 오라클 데이터베이스에서 당고 데이터 뽑기
     * @param  userId		: 유저 번호(조건용)
     * @param  dangoId		: 당고 ID (추가 요소) 
     * @return boolean		: 사원정보 검색 처리 여부(true|false)
     * @throws Exception
     ***********************************************************************/
    public boolean InsertDango(Integer userId, Integer dangoId) throws Exception
    {
        String sSql = null;						// DML 문장
        Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
        boolean bResult = false;

        try
        {
            // -----------------------------------------------------------------------------
            // 당고정보 읽기
            // -----------------------------------------------------------------------------
            if (this.DBMgr.DbConnect() == true)
            {
                // 사원정보 읽기
                sSql = "BEGIN SP_INSERT_PICK_DANGO_ID(?,?,?); END;";

                // IN 파라미터 만큼만 할당
                oPaValue = new Object[2];
                
                oPaValue[0] = userId;
                oPaValue[1] = dangoId;

                if (this.DBMgr.RunQuery(sSql, oPaValue, 3, true) == true)
                {
                    bResult = true;
                }
            }
            // -----------------------------------------------------------------------------
        }
        catch (Exception Ex)
        {
            Common.ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
        }
        return bResult;
    }

    /***********************************************************************
     * ReadProfileDango()	: 오라클 데이터베이스에서 프로필 당고 데이터 뽑기
     * @param  userId		: 유저 번호(조건용)
     * @param  dangoDTO	    : 프로필 당고 DTO(결과용)
     * @return boolean		: 프로필 당고 이미지 검색 처리 여부(true|false)
     * @throws Exception
     ***********************************************************************/
    public boolean ReadProfileDango(Integer userId, DangoDTO dangoDTO) throws Exception
    {
        String sSql = null;						// DML 문장
        Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
        boolean bResult = false;

        try
        {
            // -----------------------------------------------------------------------------
            // 당고정보 읽기
            // -----------------------------------------------------------------------------
            if (this.DBMgr.DbConnect() == true)
            {
                // 사원정보 읽기
                sSql = "BEGIN SP_GET_DANGO_PROFILE(?,?); END;";

                // IN 파라미터 만큼만 할당
                oPaValue = new Object[1];

                oPaValue[0] = userId;

                if (this.DBMgr.RunQuery(sSql, oPaValue, 2, true) == true)
                {
                    if (this.DBMgr.Rs.next()) {
                        dangoDTO.setDangoId(this.DBMgr.Rs.getInt("DANGO_ID"));
                        dangoDTO.setDangoName(this.DBMgr.Rs.getString("DANGO_NAME"));
                        dangoDTO.setLocationImg(this.DBMgr.Rs.getString("LOCATION_IMG"));
                        dangoDTO.setRarity(this.DBMgr.Rs.getString("RARITY").charAt(0));
                        bResult = true;
                    } else {
                        bResult = false;
                    }
                }
            }
            // -----------------------------------------------------------------------------
        }
        catch (Exception Ex)
        {
            Common.ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
        }
        return bResult;
    }

    /***********************************************************************
     * UpdateProfileDango()	: 오라클 데이터베이스에서 당고 프로필 수정
     * @param  userId		: 유저 번호(조건용)
     * @param  dangoId		: 당고 ID (조건용)
     * @return boolean		: 당고 프로필 수정 처리 여부(true|false)
     * @throws Exception
     ***********************************************************************/
    public boolean UpdateProfileDango(Integer userId, Integer dangoId) throws Exception
    {
        String sSql = null;						// DML 문장
        Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
        boolean bResult = false;

        try
        {
            // -----------------------------------------------------------------------------
            // 당고정보 읽기
            // -----------------------------------------------------------------------------
            if (this.DBMgr.DbConnect() == true)
            {
                // 사원정보 읽기
                sSql = "BEGIN SP_SET_DANGO_PROFILE(?,?,?); END;";

                // IN 파라미터 만큼만 할당
                oPaValue = new Object[2];

                oPaValue[0] = userId;
                oPaValue[1] = dangoId;

                if (this.DBMgr.RunQuery(sSql, oPaValue, 3, true) == true)
                {
                    bResult = true;
                }
            }
            // -----------------------------------------------------------------------------
        }
        catch (Exception Ex)
        {
            Common.ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
        }
        return bResult;
    }
    
}