CREATE OR REPLACE PROCEDURE SP_BUILDDATA_WORDS AS 
BEGIN
  DECLARE
		mLevel			NUMBER;					-- 급수				
		mDay			NUMBER;					-- 일자
		mWordsId		NUMBER;					-- 단어장 번호
		mWordsName		VARCHAR2(50 BYTE);		-- 단어장 이름
	BEGIN
		FOR mLevel IN 1..5
		LOOP
			FOR mDay IN 1..10
			LOOP
				mWordsId	:= mLevel * 100 + mDay;
				mWordsName	:= 'N' || mLevel || ' Day ' || LPAD(mDay, 2, '0');
				INSERT INTO TB_WORDS
				VALUES (mWordsId, mWordsName);
			END LOOP;
		END LOOP;		
	END;
END SP_BUILDDATA_WORDS;