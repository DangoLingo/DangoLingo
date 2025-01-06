/*------------------------------------------------------------------------------------
 1 테이블명		: TB_FRIEND
 2 기능 및 설명	: 친구 테이블
 3 관련 스토어드	: SP_FRIEND

	DROP TABLE TB_FRIEND;
	DROP INDEX IX1_FRIEND;
	SELECT * FROM TB_FRIEND;
------------------------------------------------------------------------------------*/
	CREATE TABLE TB_FRIEND
	(
		user_id			NUMBER			NOT NULL,		-- 유저 번호(팔로워)
		following_id	NUMBER			NOT NULL		-- 유저 번호(팔로잉)
	);
	
  ------------------------------------------------------------------------------------
  --  Constraints for Table TB_FRIEND
  ------------------------------------------------------------------------------------
	ALTER TABLE TB_FRIEND ADD CONSTRAINT PK_FRIEND PRIMARY KEY(user_id, following_id);
	
/*------------------------------------------------------------------------------------
	END
------------------------------------------------------------------------------------*/