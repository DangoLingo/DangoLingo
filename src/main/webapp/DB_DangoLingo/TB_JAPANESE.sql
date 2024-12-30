/*------------------------------------------------------------------------------------
 1 테이블명		: TB_JAPANESE
 2 기능 및 설명	: 일본어 정보 테이블
 3 관련 스토어드	: SP_JAPANESE

	DROP TABLE TB_JAPANESE;
	DROP INDEX IX1_JAPANESE;
	SELECT * FROM TB_JAPANESE;
	DROP SEQUENCE SQ_JAPANESE_ID;
------------------------------------------------------------------------------------*/
	CREATE TABLE TB_JAPANESE
	(
		japanese_id		NUMBER				PRIMARY KEY,		-- 일본어 번호
		words_id		NUMBER				NOT NULL,			-- 단어장 번호
		kanji			VARCHAR2(50 CHAR)	NOT NULL,			-- 한자
		hiragana		VARCHAR2(50 CHAR)	NOT NULL,			-- 히라가나
		kanji_kr		VARCHAR2(50 CHAR)	NOT NULL,			-- 한자 한글 뜻
		example			VARCHAR2(50 CHAR)	NOT NULL,			-- 예문 일본어
		example_kr		VARCHAR2(50 CHAR)	NOT NULL			-- 예문 한글 뜻
	);
	
  ------------------------------------------------------------------------------------
  --  Sequences for Table TB_JAPANESE
  ------------------------------------------------------------------------------------
	CREATE SEQUENCE SQ_JAPANESE_ID START WITH 1 INCREMENT BY 1 NOMAXVALUE ORDER;
	
  ------------------------------------------------------------------------------------
  --  Constraints for Table TB_JAPANESE
  ------------------------------------------------------------------------------------
	ALTER TABLE TB_JAPANESE ADD CONSTRAINT FK_WORDS_ID FOREIGN KEY(words_id) REFERENCES TB_WORDS(words_id);

/*------------------------------------------------------------------------------------
	END
------------------------------------------------------------------------------------*/