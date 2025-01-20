create or replace PROCEDURE SP_UPDATE_USER_POINTS (
    
    iUserId             IN NUMBER,        -- 사용자 ID
    iDeduction          IN NUMBER,          -- 차감할 포인트 값
    oCur		        OUT	SYS_REFCURSOR	-- 결과 반환용 커서
)
IS
    CurrentPoint        NUMBER;             -- 현재 포인트 저장 변수
BEGIN
    -- 현재 포인트 조회
    SELECT a.POINT INTO CurrentPoint 
    FROM TB_USER a
    WHERE a.User_Id = iUserId;

    -- 포인트가 충분한지 확인
    IF CurrentPoint >= iDeduction THEN
        -- 포인트 차감
        UPDATE TB_USER a
        SET a.POINT = a.POINT - iDeduction 
        WHERE a.User_Id = iUserId;

        COMMIT; -- 변경 사항 저장
    END IF;

    OPEN oCur FOR
    SELECT a.* 
    FROM TB_USER a
    WHERE a.User_Id = iUserId;

END SP_UPDATE_USER_POINTS;