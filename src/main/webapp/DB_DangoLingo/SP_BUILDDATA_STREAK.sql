CREATE OR REPLACE PROCEDURE SP_BUILDDATA_STREAK
(
	iUserId		IN NUMBER,		-- 데이터를 넣을 유저 번호
	iCount		IN NUMBER		-- 생성할 스트릭 레코드 수
)
IS
BEGIN
	DECLARE
        mKey			NUMBER;
		mUserId			NUMBER;						-- 유저 번호
		mStreakDate		DATE;						-- 스트릭 일자
		mPoint			NUMBER;						-- 획득 포인트
		mStreakCnt		NUMBER;						-- 스트릭 보유 여부
BEGIN

		mKey := 1;

		DELETE  TB_STREAK;

		WHILE mKey <= iCount
		LOOP
			mUserId	:= iUserId;
			mStreakDate	:= ROUND(DBMS_RANDOM.VALUE(21, 25), 0) || '/' ||
						LPAD(ROUND(DBMS_RANDOM.VALUE(1, 12), 0), 2, '0') || '/' ||
						LPAD(ROUND(DBMS_RANDOM.VALUE(1, 28), 0), 2, '0');
			mPoint := ROUND(DBMS_RANDOM.VALUE(1, 500), 0);

            BEGIN
            SELECT 	COUNT(*)INTO mStreakCnt
            FROM 	TB_STREAK
            WHERE 	user_id = mUserId AND
                    TO_CHAR(streak_date, 'YY/MM/DD') = mStreakDate;
            EXCEPTION WHEN
					NO_DATA_FOUND THEN
					mStreakCnt := 0;
            END;

			IF
                mStreakCnt = 0
			THEN
			    INSERT INTO TB_STREAK
			    VALUES (mUserId, TO_DATE(mStreakDate, 'YY/MM/DD'), mPoint);
            END IF;

			mKey := mKey + 1;
        END LOOP;
    END;
END SP_BUILDDATA_STREAK;