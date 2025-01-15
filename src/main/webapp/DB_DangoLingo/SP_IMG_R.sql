CREATE OR REPLACE PROCEDURE SP_IMG_R
(
    iUserID     IN  NUMBER,
	oCur		OUT	SYS_REFCURSOR	-- 결과 반환용 커서
)
IS
    BEGIN
    OPEN oCur FOR
    SELECT	a.*,
              NVL((   SELECT  b.DANGO_ID
                      FROM    TB_USER_DANGO b
                      WHERE   a.DANGO_ID  = b.DANGO_ID AND
                              b.USER_ID   = iUserID
                  ), -1) AS LOCKSTATE
    FROM	TB_DANGO a
    ORDER BY a.DANGO_Id;
END SP_IMG_R;