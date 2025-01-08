// #################################################################################################
// FriendDTO.java - 친구 관계 DTO 모듈
// #################################################################################################
// ═════════════════════════════════════════════════════════════════════════════════════════
// 외부모듈 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
package BeansHome.Friend;

import Common.ExceptionMgr;

// ═════════════════════════════════════════════════════════════════════════════════════════
// 사용자정의 클래스 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
 * FriendDTO		: 친구 관계 DTO 클래스<br>
 * Inheritance	    : None
 ***********************************************************************/
public class FriendDTO
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
    /** userId       : 유저 번호 (팔로워) */
    private int userId;
    /** followingId  : 유저 번호 (팔로잉) */
    private int followingId;

    // —————————————————————————————————————————————————————————————————————————————————————
    // 생성자 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /***********************************************************************
     * FriendDTO()       :  기본 생성자
     * @param void      : None
     ***********************************************************************/
    public FriendDTO()
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

    public int getFollowingId() {
        return followingId;
    }

    public void setFollowingId(int followingId) {
        this.followingId = followingId;
    }
    // —————————————————————————————————————————————————————————————————————————————————————
}
// #################################################################################################
// <END>
// #################################################################################################