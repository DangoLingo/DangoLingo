CREATE OR REPLACE PROCEDURE SP_BUILDDATA_USER
(
	iCount		IN NUMBER		-- 생성할 유저 레코드 수
)
IS
BEGIN
  	DECLARE
		mKey			NUMBER;							
		mUserId			NUMBER;						-- 유저 번호
		mEmail			VARCHAR2(20 CHAR);			-- 이메일
		mPassword		VARCHAR2(20 CHAR);			-- 비밀번호
		mName			VARCHAR2(20 CHAR);			-- 이름
		mNickName		VARCHAR2(20 CHAR);			-- 닉네임
		mIntro			VARCHAR2(20 CHAR);			-- 소개글
		mStudyDate		DATE;						-- 마지막 학습 일자
		mStudyTime		TIMESTAMP;					-- 총 학습 시간
		mStudyDay		NUMBER;						-- 연속 학습일
		mPoint			NUMBER;						-- 포인트
	BEGIN
		mKey := 1;

		DELETE  TB_USER;

		WHILE mKey <= iCount
		LOOP
			mUserId	:= mKey;
			mEmail	:= 'email' || mKey || '@naver.com';
			mPassword	:= 'password';
			mName	:= '성명' || mKey;
			mNickName	:= '닉네임' || mKey;
			mIntro	:= '소개글' || mKey;
			mStudyDate	:= ROUND(DBMS_RANDOM.VALUE(2023, 2024), 0) || '/' ||
						LPAD(ROUND(DBMS_RANDOM.VALUE(1, 12), 0), 2, '0') || '/' ||
						LPAD(ROUND(DBMS_RANDOM.VALUE(1, 28), 0), 2, '0');
			mStudyTime	:= SYSTIMESTAMP;
			mStudyDay	:= ROUND(DBMS_RANDOM.VALUE(1, 300), 0);
			mPoint := ROUND(DBMS_RANDOM.VALUE(1, 25000), 0);

			INSERT INTO TB_USER
			VALUES (mUserId, mEmail, mPassword, mName, mNickName, mIntro, mStudyDate, mStudyTime, mStudyDay, mPoint);

			mKey := mKey + 1;
		END LOOP;
	END;
END SP_BUILDDATA_USER;