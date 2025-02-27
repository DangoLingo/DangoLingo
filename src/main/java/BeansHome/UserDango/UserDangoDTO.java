// #################################################################################################
// UserDangoDTO.java - 유저 당고 DTO 모듈
// #################################################################################################
// ═════════════════════════════════════════════════════════════════════════════════════════
// 외부모듈 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
package BeansHome.UserDango;

import Common.ExceptionMgr;
import java.sql.Date;

// ═════════════════════════════════════════════════════════════════════════════════════════
// 사용자정의 클래스 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
 * UserDangoDTO		: 유저 당고 DTO 클래스<br>
 * Inheritance	    : None
 ***********************************************************************/
public class UserDangoDTO
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
    /** userId       : 유저 번호 */
    private int userId;
    /** dangoId      : 당고 번호 */
    private int dangoId;
    /** buyDate      : 구매 일자 */
    private Date buyDate;

    // —————————————————————————————————————————————————————————————————————————————————————
    // 생성자 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /***********************************************************************
     * UserDangoDTO()       :  기본 생성자
     * @param void      : None
     ***********************************************************************/
    public UserDangoDTO()
    {
        try
        {
            // -----------------------------------------------------------------------------
            // 기타 초기화 작업 관리
            // -----------------------------------------------------------------------------
            ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);
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
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getDangoId() {
        return dangoId;
    }

    public void setDangoId(int dangoId) {
        this.dangoId = dangoId;
    }

    public Date getBuyDate() {
        return buyDate;
    }

    public void setBuyDate(Date buyDate) {
        this.buyDate = buyDate;
    }
    // —————————————————————————————————————————————————————————————————————————————————————
}
// #################################################################################################
// <END>
// #################################################################################################