/*------------------------------------------------------------------------------------
 1 테이블명		: TB_SESSION
 2 기능 및 설명	: 학습 기록 테이블
 3 관련 스토어드	: SP_SESSION

	DROP TABLE TB_SESSION;
	DROP INDEX IX1_SESSION;
	SELECT * FROM TB_SESSION;
------------------------------------------------------------------------------------*/
	CREATE TABLE TB_SESSION
	(
		study_id		NUMBER			NOT NULL,		-- 학습 기록 번호
		japanese_id		NUMBER			NOT NULL,		-- 일본어 번호
		is_learned		CHAR(1)			NOT NULL		-- 학습 여부
	);
	
  ------------------------------------------------------------------------------------
  --  Constraints for Table TB_SESSION
  ------------------------------------------------------------------------------------
	ALTER TABLE TB_SESSION ADD CONSTRAINT PK_SESSION PRIMARY KEY(study_id, japanese_id);
	ALTER TABLE TB_SESSION ADD CONSTRAINT CK_IS_LEARNED CHECK(is_learned IN('Y', 'N'));
	
/*------------------------------------------------------------------------------------
	END
------------------------------------------------------------------------------------*/