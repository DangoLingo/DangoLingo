// #################################################################################################
// RankingDTO.java - 랭킹 DTO 모듈
// #################################################################################################
// ═════════════════════════════════════════════════════════════════════════════════════════
// 외부모듈 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
package BeansHome.Ranking;

import Common.ExceptionMgr;

// ═════════════════════════════════════════════════════════════════════════════════════════
// 사용자정의 클래스 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
 * RankingDTO     : 랭킹 DTO 클래스<br>
 * Inheritance    : None
 ***********************************************************************/
public class RankingDTO {
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역변수 관리 - 필수영역(인스턴스변수)
    // —————————————————————————————————————————————————————————————————————————————————————
    private int rank;           // 순위
    private int userId;         // 사용자 ID
    private String nickname;    // 닉네임
    private String intro;       // 소개글
<<<<<<< HEAD
    private int score;         // 점수 (포인트)
    private String type;       // 랭킹 타입 (points)

=======
    private int point;         // 포인트
    
>>>>>>> dev
    // —————————————————————————————————————————————————————————————————————————————————————
    // 생성자 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /***********************************************************************
     * RankingDTO()  : 생성자
     * @param void   : None
     ***********************************************************************/
    public RankingDTO() {
        try {
            ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);
        } catch (Exception Ex) {
            ExceptionMgr.DisplayException(Ex);
        }
    }

    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역함수 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    public int getRank() { return rank; }
    public void setRank(int rank) { this.rank = rank; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }

    public String getIntro() { return intro; }
    public void setIntro(String intro) { this.intro = intro; }
<<<<<<< HEAD

    public int getScore() { return score; }
    public void setScore(int score) { this.score = score; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
=======
    
    public int getPoint() { return point; }
    public void setPoint(int point) { this.point = point; }
>>>>>>> dev
}
// #################################################################################################
// <END>
// ################################################################################################# 