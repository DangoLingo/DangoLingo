create or replace PROCEDURE SP_IMG_RANDOM
(
    oCur         OUT     SYS_REFCURSOR   -- 결과 반환용 커서
)
IS
BEGIN
    OPEN oCur FOR
    -- 당고 랜덤 추출
    SELECT a.DANGO_ID, a.DANGO_NAME, a.LOCATION_IMG
    FROM (SELECT b.*
          FROM TB_DANGO b
          ORDER BY DBMS_RANDOM.VALUE
         ) a
    WHERE ROWNUM <= 1;

END SP_IMG_RANDOM;