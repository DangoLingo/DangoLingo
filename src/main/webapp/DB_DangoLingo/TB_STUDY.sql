/*------------------------------------------------------------------------------------
 1 테이블명		: TB_STUDY
 2 기능 및 설명	: 학습 기록 정보 테이블
 3 관련 스토어드	: SP_STUDY

	DROP TABLE TB_STUDY;
	DROP INDEX IX1_STUDY;
	SELECT * FROM TB_STUDY;
	DROP SEQUENCE SQ_STUDY_ID;
------------------------------------------------------------------------------------*/
	CREATE TABLE TB_STUDY
	(
		study_id		NUMBER			PRIMARY KEY,		-- 학습 기록 번호
		user_id			NUMBER			NOT NULL,			-- 유저 번호
		words_id		NUMBER			NOT NULL,			-- 단어장 번호
		japanese_id		NUMBER			NOT NULL,			-- 마지막 본 일본어 번호
		study_date		DATE			DEFAULT SYSDATE,	-- 학습 일자
		study_count		NUMBER			DEFAULT 0			-- 총 학습 단어 개수
	);
	
  ------------------------------------------------------------------------------------
  --  Sequences for Table TB_STUDY
  ------------------------------------------------------------------------------------
	CREATE SEQUENCE SQ_STUDY_ID START WITH 1 INCREMENT BY 1 NOMAXVALUE ORDER;
	
  ------------------------------------------------------------------------------------
  --  Constraints for Table TB_STUDY
  ------------------------------------------------------------------------------------
	ALTER TABLE TB_STUDY ADD CONSTRAINT FK_USER_ID FOREIGN KEY(user_id) REFERENCES TB_USER(user_id);
	ALTER TABLE TB_STUDY ADD CONSTRAINT FK_WORDS_ID FOREIGN KEY(words_id) REFERENCES TB_WORDS(words_id);

/*------------------------------------------------------------------------------------
	END
------------------------------------------------------------------------------------*/