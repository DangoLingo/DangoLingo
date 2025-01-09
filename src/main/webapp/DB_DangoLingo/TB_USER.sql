/*------------------------------------------------------------------------------------
 1 테이블 명		: TB_USER
 2 기능 및 설명	: 유저 정보 테이블
 3 관련 스토어드	: SP_USER

	DROP TABLE TB_USER;
	DROP INDEX IX1_USER;
	SELECT * FROM TB_USER;
	DROP SEQUENCE SQ_USER_ID;
------------------------------------------------------------------------------------*/
	CREATE TABLE TB_USER
	(
		user_id			NUMBER				PRIMARY KEY,		-- 유저 번호
		email			VARCHAR2(20 CHAR)	NOT NULL,			-- 이메일
		password		VARCHAR2(20 CHAR)	NOT NULL,			-- 비밀번호
		name			VARCHAR2(20 CHAR)	NOT NULL,			-- 이름
		nickname		VARCHAR2(20 CHAR)	NOT NULL UNIQUE,	-- 닉네임
		intro			VARCHAR2(20 CHAR)	NULL,				-- 소개글
		study_date		DATE				NULL,				-- 마지막 학습 일자
		study_time		NUMBER  			DEFAULT		0,				-- 총 학습 시간(분 단위)
		study_day		NUMBER				DEFAULT		0,		-- 연속 학습일
		quiz_count		NUMBER				DEFAULT		0,		-- 퀴즈 문제 수
		quiz_right		NUMBER				DEFAULT		0,		-- 퀴즈 정답 횟수
		point			NUMBER(*, 0)		DEFAULT		0		-- 포인트
	);
	
  ------------------------------------------------------------------------------------
  --  Sequences for Table TB_USER
  ------------------------------------------------------------------------------------
	CREATE SEQUENCE SQ_USER_ID START WITH 1 INCREMENT BY 1 NOMAXVALUE ORDER;
	
  ------------------------------------------------------------------------------------
  --  Constraints for Table TB_USER
  ------------------------------------------------------------------------------------

/*------------------------------------------------------------------------------------
	END
------------------------------------------------------------------------------------*/