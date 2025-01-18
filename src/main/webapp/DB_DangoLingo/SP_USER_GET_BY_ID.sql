create or replace PROCEDURE SP_USER_GET_BY_ID (
    p_user_id IN NUMBER,
    p_result OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_result FOR
    SELECT 
        USER_ID,
        EMAIL,
        NAME,
        NICKNAME,
        INTRO,
        STUDY_DATE,
        STUDY_TIME,
        STUDY_DAY,
        QUIZ_COUNT,
        QUIZ_RIGHT,
        POINT
    FROM TB_USER
    WHERE USER_ID = p_user_id;
END;
