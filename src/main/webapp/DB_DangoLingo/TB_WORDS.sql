/*------------------------------------------------------------------------------------
 1 테이블명		: TB_WORDS
 2 기능 및 설명	: 단어장 정보 테이블
 3 관련 스토어드	: SP_WORDS

	DROP TABLE TB_WORDS;
	DROP INDEX IX1_WORDS;
	SELECT * FROM TB_WORDS;
------------------------------------------------------------------------------------*/
	CREATE TABLE TB_WORDS
	(
		words_id		NUMBER				PRIMARY KEY,		-- 단어장 번호
		words_name		VARCHAR2(50 BYTE)	NOT NULL			-- 단어장 이름
	);
	
  ------------------------------------------------------------------------------------
  --  Constraints for Table TB_WORDS
  ------------------------------------------------------------------------------------
	
/*------------------------------------------------------------------------------------
	END
------------------------------------------------------------------------------------*/