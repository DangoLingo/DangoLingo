/*--------------------------------------------------------------------------
 1 테이블 명		: TB_USER
 2 기능 및 설명	: 유저 정보 테이블
 3 관련 스토어드	: SP_USER

	DROP TABLE TB_USER;
	DROP INDEX IX1_USER;
	SELECT * FROM TB_USER;
---------------------------------------------------------------------------*/
	CREATE TABLE TB_USER 
	(
		user_id			NUMBER			NOT NULL,		-- 유저 번호
		email			VARCHAR2(20)	NOT NULL,		-- 이메일
		password		VARCHAR2(20)	NOT NULL,		-- 비밀번호
		name			VARCHAR2(20)	NOT NULL,		-- 이름
		nickname		VARCHAR2(20)	NOT NULL,		-- 닉네임
		intro			VARCHAR2(20)	NULL,			-- 소개글
		study_date		DATE			NULL,			-- 마지막 학습 일자
		study_time		TIME			NULL,			-- 총 학습 시간
		study_day		NUMBER			DEFAULT		0,	-- 연속 학습일
		point			NUMBER			DEFAULT		0	-- 포인트
	);
/*--------------------------------------------------------------------------
	END
---------------------------------------------------------------------------*/