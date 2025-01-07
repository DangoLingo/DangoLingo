// #################################################################################################
// UserDTO.java - 유저 DTO 모듈
// #################################################################################################
// ═════════════════════════════════════════════════════════════════════════════════════════
// 외부모듈 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
package BeansHome.User;

import Common.ExceptionMgr;
import java.sql.Date;
import java.sql.Timestamp;

// ═════════════════════════════════════════════════════════════════════════════════════════
// 사용자정의 클래스 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
 * UserDTO			: 유저 DTO 클래스<br>
 * Inheritance		: None
 ***********************************************************************/
public class UserDTO {
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역상수 관리 - 필수영역
    // —————————————————————————————————————————————————————————————————————————————————————

    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역변수 관리 - 필수영역(정적변수)
    // —————————————————————————————————————————————————————————————————————————————————————

    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역변수 관리 - 필수영역(인스턴스변수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /** userId        : 유저 번호 */
    private int userId;
    /** email         : 이메일 */
    private String email;
    /** password      : 비밀번호 */
    private String password;
    /** name          : 이름 */
    private String name;
    /** nickname      : 닉네임 */
    private String nickname;
    /**  intro         : 소개글 */
    private String intro;
    /** studyDate     : 마지막 학습 일자 */
    private Date studyDate;
    /** studyTime     : 총 학습 시간 */
    private Timestamp studyTime;
    /** studyDay      : 연속 학습일 */
    private int studyDay;
    /** quizCount     : 퀴즈 문제 수 */
    private int quizCount;
    /** quizRight     : 퀴즈 정답 횟수 */
    private int quizRight;
    /** point         : 포인트 */
    private int point;

    // —————————————————————————————————————————————————————————————————————————————————————
    // 생성자 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————

    /***********************************************************************
     * UserDTO()		: 기본 생성자
     * @param void		: None
     ***********************************************************************/
    public UserDTO() {
        try {
            // -----------------------------------------------------------------------------
            // 기타 초기화 작업 관리
            // -----------------------------------------------------------------------------
            ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);
            // -----------------------------------------------------------------------------
        } catch (Exception Ex) {
            ExceptionMgr.DisplayException(Ex);        // 예외처리(콘솔)
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro;
    }

    public Date getStudyDate() {
        return studyDate;
    }

    public void setStudyDate(Date studyDate) {
        this.studyDate = studyDate;
    }

    public Timestamp getStudyTime() {
        return studyTime;
    }

    public void setStudyTime(Timestamp studyTime) {
        this.studyTime = studyTime;
    }

    public int getStudyDay() {
        return studyDay;
    }

    public void setStudyDay(int studyDay) {
        this.studyDay = studyDay;
    }

    public int getQuizCount() {
        return quizCount;
    }

    public void setQuizCount(int quizCount) {
        this.quizCount = quizCount;
    }

    public int getQuizRight() {
        return quizRight;
    }

    public void setQuizRight(int quizRight) {
        this.quizRight = quizRight;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }
    // —————————————————————————————————————————————————————————————————————————————————————
}
// #################################################################################################
// <END>
// #################################################################################################