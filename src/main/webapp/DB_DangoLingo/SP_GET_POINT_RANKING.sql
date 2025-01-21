create or replace PROCEDURE SP_GET_POINT_RANKING
(
    p_user_id IN NUMBER,         -- 입력: 사용자 ID
    p_result OUT SYS_REFCURSOR   -- 출력: 결과 커서
)
IS
    v_rank NUMBER;               -- 랭킹 저장 변수
BEGIN
    -- 사용자의 포인트 랭킹 조회
SELECT rank
INTO v_rank
FROM (
         SELECT
             user_id,
             DENSE_RANK() OVER (ORDER BY point DESC) as rank
         FROM TB_USER
     )
WHERE user_id = p_user_id;

-- 결과 커서 생성
OPEN p_result FOR
SELECT
    v_rank as rank,
    user_id,
    nickname,
    intro,
    point as score,
    'points' as type
FROM TB_USER
WHERE user_id = p_user_id;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- 사용자를 찾을 수 없는 경우
        OPEN p_result FOR
SELECT
    0 as rank,
    p_user_id as user_id,
    NULL as nickname,
    NULL as intro,
    0 as score,
    'points' as type
FROM DUAL;
WHEN OTHERS THEN
        -- 기타 예외 처리
        RAISE_APPLICATION_ERROR(-20001, 'SP_GET_POINT_RANKING 오류: ' || SQLERRM);
END;
