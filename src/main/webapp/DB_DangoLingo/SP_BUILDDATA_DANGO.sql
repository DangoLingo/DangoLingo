CREATE OR REPLACE PROCEDURE SP_BUILDDATA_DANGO AS
BEGIN
    DECLARE
        mKey			NUMBER;					-- 반복 횟수
        mDangoId		NUMBER;					-- 당고 번호
        mDangoName		VARCHAR2(20 CHAR);		-- 당고 이름
        mRarity			CHAR(1);				-- 당고 등급
        mLocationImg	VARCHAR2(50 CHAR);		-- 당고 이미지 위치
BEGIN
        DELETE  TB_DANGO;
        FOR mKey IN 1..50
        LOOP
            mDangoId		:= mKey;
            mDangoName		:= 'dango' || mKey;
            IF
                mKey < 31
            THEN
                mRarity		:= 'C';
            ELSIF
                mKey < 46
            THEN
                mRarity		:= 'R';
            ELSE
                mRarity		:= 'U';
            END IF;
            mLocationImg	:= '../images/dango-' || mKey || '.svg';
            INSERT INTO TB_DANGO
            VALUES (mDangoId, mDangoName, mRarity, mLocationImg);
        END LOOP;
    END;
END SP_BUILDDATA_DANGO;