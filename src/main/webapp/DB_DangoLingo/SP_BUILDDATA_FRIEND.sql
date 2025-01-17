CREATE OR REPLACE PROCEDURE SP_BUILDDATA_FRIEND AS
BEGIN
    DECLARE
        mUserId			NUMBER;					-- 유저 번호
        mFollowingId	NUMBER;					-- 친구 번호
    BEGIN
        DELETE  TB_FRIEND;
        FOR mUserId IN 1..50
        LOOP
            FOR mFollowingId IN 51..100
            LOOP
                INSERT INTO TB_FRIEND
                VALUES (mUserId, mFollowingId);
            END LOOP;
        END LOOP;
    END;
END SP_BUILDDATA_FRIEND;