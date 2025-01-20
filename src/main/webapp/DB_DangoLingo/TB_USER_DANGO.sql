/*------------------------------------------------------------------------------------
 1 테이블 명		: TB_USER_DANGO
 2 기능 및 설명	: 유저 당고 정보 테이블
 3 관련 스토어드	: SP_USER_DANGO

	DROP TABLE TB_USER_DANGO;
	DROP INDEX IX1_USER_DANGO;
	SELECT * FROM TB_USER_DANGO;
------------------------------------------------------------------------------------*/
	CREATE TABLE TB_USER_DANGO
	(
		user_id			NUMBER			NOT NULL,			-- 유저 번호
		dango_id		NUMBER			NOT NULL,			-- 당고 번호
        is_profile		CHAR(1)			NOT NULL			-- 구매 일자
	);
	
  ------------------------------------------------------------------------------------
  --  Constraints for Table TB_USER_DANGO
  ------------------------------------------------------------------------------------
	ALTER TABLE TB_USER_DANGO ADD CONSTRAINT PK_USER_DANGO PRIMARY KEY(user_id, dango_id);
    ALTER TABLE TB_USER_DANGO ADD CONSTRAINT CK_IS_PROFILE CHECK(is_profile IN('T', 'F'));
/*------------------------------------------------------------------------------------
	END
------------------------------------------------------------------------------------*/