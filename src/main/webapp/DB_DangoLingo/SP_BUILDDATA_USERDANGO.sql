create or replace PROCEDURE SP_BUILDDATA_USERDANGO
(
	iCount		IN NUMBER		-- 생성할 유저 레코드 수
)
IS
BEGIN
    DECLARE
        mKey			NUMBER;
        mCount			NUMBER;
        mUserId			NUMBER;						-- 유저 번호
        mDangoId		NUMBER;						-- 당고 번호
        mIsProfile		CHAR(1);					-- 프로필 설정 여부
    BEGIN
        mKey := 1;

        DELETE  TB_USER_DANGO;
        WHILE mKey <= iCount
        LOOP
            mUserId		:= mKey;
            FOR mDangoId IN 1..50
            LOOP
                IF
                mDangoId = 1
                THEN
                    mIsProfile := 	'T';
                ELSE
                    mIsProfile := 	'F';
                END IF;
                INSERT INTO TB_USER_DANGO
                VALUES (mUserId, mDangoId, mIsProfile);
            END LOOP;
            mKey := mKey + 1;
        END LOOP;
    END;
END SP_BUILDDATA_USERDANGO;