CREATE OR REPLACE PROCEDURE SP_USER_LOGIN
(
    iEmail      IN  VARCHAR2,        -- 이메일
    iPassword   IN  VARCHAR2,        -- 비밀번호
    iCursor     OUT SYS_REFCURSOR    -- 결과 커서
)
IS
BEGIN
    -- 사용자 정보 조회
    OPEN iCursor FOR
    SELECT  USER_ID,
            EMAIL,
            PASSWORD,
            NAME,
            NICKNAME,
            INTRO,
            STUDY_DATE,
            STUDY_TIME,
            STUDY_DAY,
            QUIZ_COUNT,
            QUIZ_RIGHT,
            POINT,
            TOTAL_POINT
    FROM    TB_USER
    WHERE   EMAIL = iEmail;
END SP_USER_LOGIN;