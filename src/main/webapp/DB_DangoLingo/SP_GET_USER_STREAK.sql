create or replace PROCEDURE SP_GET_USER_STREAK
(
    p_user_id IN NUMBER,         -- 입력: 사용자 ID
    p_result OUT SYS_REFCURSOR   -- 출력: 결과 커서
)
IS
BEGIN
    -- 최근 1년간의 스트릭 정보 조회 (오늘 포함)
    OPEN p_result FOR
        SELECT
            user_id,
            streak_date,
            point
        FROM TB_STREAK
        WHERE user_id = p_user_id
        AND streak_date >= TRUNC(SYSDATE) - 365  -- 1년 전부터
        AND streak_date <= TRUNC(SYSDATE)        -- 오늘까지
        ORDER BY streak_date;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- 데이터가 없는 경우 빈 커서 반환
        OPEN p_result FOR
            SELECT
                p_user_id as user_id,
                CAST(NULL AS DATE) as streak_date,
                0 as point
            FROM DUAL
            WHERE 1 = 0;  -- 빈 결과셋 반환
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'SP_GET_USER_STREAK 오류: ' || SQLERRM);
END;
