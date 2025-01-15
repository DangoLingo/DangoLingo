CREATE OR REPLACE PROCEDURE SP_BUILDDATA_USERDANGO
(
	iCount		IN NUMBER		-- 유저 레코드 수
)
IS
BEGIN
	DECLARE
        mKey			NUMBER;
		mCount			NUMBER;
		mUserId			NUMBER;						-- 유저 번호
		mDangoId		NUMBER;						-- 당고 번호
		mBuyDate		DATE;						-- 구매 일자
    BEGIN
		mKey := 1;
		DELETE  TB_USER_DANGO;

        WHILE mKey <= iCount
		LOOP
			mUserId		:= mKey;
            FOR mDangoId IN 1..ROUND(DBMS_RANDOM.VALUE(1, 60), 0)
			LOOP
				mBuyDate	:= 	ROUND(DBMS_RANDOM.VALUE(2023, 2024), 0) || '/' ||
								LPAD(ROUND(DBMS_RANDOM.VALUE(1, 12), 0), 2, '0') || '/' ||
								LPAD(ROUND(DBMS_RANDOM.VALUE(1, 28), 0), 2, '0');
                INSERT INTO TB_USER_DANGO
                VALUES (mUserId, mDangoId, mBuyDate);
            END LOOP;
            mKey := mKey + 1;
        END LOOP;
    END;
END SP_BUILDDATA_USERDANGO;