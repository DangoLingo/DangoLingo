//#################################################################################################
//SawonDAO.java - 사원검색 DAO 모듈
//#################################################################################################
//═════════════════════════════════════════════════════════════════════════════════════════
//외부모듈 영역
//═════════════════════════════════════════════════════════════════════════════════════════
package BeansHome.User;

import java.util.ArrayList;

import Common.ExceptionMgr;
import DAO.DBOracleMgr;
//═════════════════════════════════════════════════════════════════════════════════════════
//사용자정의 클래스 영역
//═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
* SawonDAO		: 사원검색 DAO 클래스<br>
* Inheritance	: None | 부모 클래스 명
***********************************************************************/
public class UserDAO
{
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역상수 관리 - 필수영역
	// —————————————————————————————————————————————————————————————————————————————————————
	
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역변수 관리 - 필수영역(정적변수)
	// —————————————————————————————————————————————————————————————————————————————————————
	
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역변수 관리 - 필수영역(인스턴스변수)
	// —————————————————————————————————————————————————————————————————————————————————————
	/** DBMgr : 오라클 데이터베이스 DAO 객체 */
	public DBOracleMgr DBMgr = null;
	// —————————————————————————————————————————————————————————————————————————————————————
	// 생성자 관리 - 필수영역(인스턴스함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	/***********************************************************************
	 * SawonDAO()	: 생성자
	 * @param void	: None
	 ***********************************************************************/
	public UserDAO()
	{
		try
		{
			// -----------------------------------------------------------------------------
			// 기타 초기화 작업 관리
			// -----------------------------------------------------------------------------
			ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);
			
			this.DBMgr = new DBOracleMgr();
			
			this.DBMgr.SetConnectionString("localhost", 1521, "educ", "educ", "XE");
			// -----------------------------------------------------------------------------
		}
		catch (Exception Ex)
		{
			ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
		}
	}
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역함수 관리 - 필수영역(정적함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역함수 관리 - 필수영역(인스턴스함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	/***********************************************************************
	 * ReadSawonList()	: 사원정보 읽기
	 * @param sawonDTO	: 사원정보 DTO(조건용)
	 * @return boolean	: 쿼리 실행 여부(true|false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean ReadSawonList(SawonDTO sawonDTO) throws Exception
	{
		String sSql = null;				// DML 문장
		Object[] oPaValue = null;		// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		
		try
		{
			// -----------------------------------------------------------------------------
			// 사원정보 읽기
			// -----------------------------------------------------------------------------
			if (sawonDTO.getAge() != null &&
				sawonDTO.getGender() != null &&
				sawonDTO.getDept() != null)
			{
				if (this.DBMgr.DbConnect() == true)
				{
					// 사원정보 읽기 DML
					sSql = "BEGIN SP_MAN_R(?,?,?,?,?,?); END;";
					
					// IN 파라미터 만큼 메모리 할당
					oPaValue = new Object[5];
					
					oPaValue[0] = "0";
					oPaValue[1] = "-1";
					oPaValue[2] = sawonDTO.getAge();
					oPaValue[3] = sawonDTO.getGender();
					oPaValue[4] = sawonDTO.getDept();
					
					// DML 문장 실행
					if (this.DBMgr.RunQuery(sSql, oPaValue, 6, true) == true)
					{
						bResult = true;
					}
				}
			}
			
			// -----------------------------------------------------------------------------
		}
		catch (Exception Ex)
		{
			ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
		}
		
		return bResult;
	}
	/***********************************************************************
	 * ReadSawonList()	: 사원정보 읽기
	 * @param sawonDTO	: 사원정보 DTO(조건용)
	 * @param Sawons	: 사원정보 DTO(결과 반환용)
	 * @return boolean	: 쿼리 실행 여부(true|false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean ReadSawonList(SawonDTO sawonDTO, ArrayList<SawonDTO> Sawons) throws Exception
	{
		String sSql = null;				// DML 문장
		Object[] oPaValue = null;		// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		
		try
		{
			// -----------------------------------------------------------------------------
			// 사원정보 읽기
			// -----------------------------------------------------------------------------
			if (sawonDTO.getAge() != null &&
				sawonDTO.getGender() != null &&
				sawonDTO.getDept() != null)
			{
				if (this.DBMgr.DbConnect() == true)
				{
					// 사원정보 읽기 DML
					sSql = "BEGIN SP_MAN_R(?,?,?,?,?,?); END;";
					
					// IN 파라미터 만큼 메모리 할당
					oPaValue = new Object[5];
					
					oPaValue[0] = "0";
					oPaValue[1] = "-1";
					oPaValue[2] = sawonDTO.getAge();
					oPaValue[3] = sawonDTO.getGender();
					oPaValue[4] = sawonDTO.getDept();
					
					// DML 문장 실행
					if (this.DBMgr.RunQuery(sSql, oPaValue, 6, true) == true)
					{
						while(this.DBMgr.Rs.next() == true)
						{
							SawonDTO Sawon = new SawonDTO();
							
							Sawon.setSabun(this.DBMgr.Rs.getInt("Sabun"));
							Sawon.setName(this.DBMgr.Rs.getString("Name"));
							Sawon.setAge(this.DBMgr.Rs.getInt("Age"));
							Sawon.setGender(this.DBMgr.Rs.getString("Gender"));
							Sawon.setTel(this.DBMgr.Rs.getString("Tel"));
							Sawon.setDept(this.DBMgr.Rs.getString("Dept"));
							Sawon.setDeptname(this.DBMgr.Rs.getString("DeptName"));
							Sawon.setStcd(this.DBMgr.Rs.getString("StCd"));
							Sawon.setStcdname(this.DBMgr.Rs.getString("StCdName"));
							Sawon.setBdate(this.DBMgr.Rs.getString("BDate"));
							Sawon.setAddress(this.DBMgr.Rs.getString("Address"));
							
							Sawons.add(Sawon);
						}
						
						bResult = true;
					}
				}
			}
			
			// -----------------------------------------------------------------------------
		}
		catch (Exception Ex)
		{
			ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
		}
		
		return bResult;
	}
	// —————————————————————————————————————————————————————————————————————————————————————
}
//#################################################################################################
//<END>
//#################################################################################################
