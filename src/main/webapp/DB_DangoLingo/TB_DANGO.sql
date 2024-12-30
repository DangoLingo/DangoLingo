/*------------------------------------------------------------------------------------
 1 테이블 명		: TB_DANGO
 2 기능 및 설명	: 당고 정보 테이블
 3 관련 스토어드	: SP_DANGO

	DROP TABLE TB_DANGO;
	DROP INDEX IX1_DANGO;
	SELECT * FROM TB_DANGO;
	DROP SEQUENCE SQ_DANGO_ID;
------------------------------------------------------------------------------------*/
	CREATE TABLE TB_DANGO
	(
		dango_id		NUMBER				PRIMARY KEY,		-- 당고 번호
		dango_name		VARCHAR2(20 CHAR)	NOT NULL,			-- 당고 이름
		rarity			CHAR(1)				NOT NULL,			-- 당고 등급
		location_img	VARCHAR2(50 CHAR)	NOT NULL			-- 당고 이미지 위치
	);
	
  ------------------------------------------------------------------------------------
  --  Sequences for Table TB_DANGO
  ------------------------------------------------------------------------------------
	CREATE SEQUENCE SQ_DANGO_ID START WITH 1 INCREMENT BY 1 NOMAXVALUE ORDER;
	
  ------------------------------------------------------------------------------------
  --  Constraints for Table TB_DANGO
  ------------------------------------------------------------------------------------
	ALTER TABLE TB_DANGO ADD CONSTRAINT CK_RARITY CHECK(rarity IN('U', 'R', 'C'));
	
/*------------------------------------------------------------------------------------
	END
------------------------------------------------------------------------------------*/