create or replace PROCEDURE SP_INSERT_PICK_DANGO_ID
(
    iUserId     IN      NUMBER,         
    iDangoId    IN      NUMBER,
    oCur        OUT     SYS_REFCURSOR   -- 결과 반환용 커서
)
IS
    Mcount int;
BEGIN
    -- 먼저 존재 여부를 확인하는 쿼리를 커서로 반환합니다.
    OPEN oCur FOR
        SELECT COUNT(*)
        FROM tb_user_dango a
        WHERE a.dango_id = iDangoId AND a.user_id = iUserId;

    -- 커서에서 조회한 결과를 Mcount에 할당합니다.
    FETCH oCur INTO Mcount;

    -- 결과가 없으면 데이터 삽입
    IF Mcount = 0 THEN
        INSERT INTO TB_USER_DANGO(USER_ID, DANGO_ID, IS_PROFILE) 
        VALUES(iUserId, iDangoId, 'F');
    END IF;

    COMMIT;
END SP_INSERT_PICK_DANGO_ID;