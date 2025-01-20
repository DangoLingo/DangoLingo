create or replace PROCEDURE SP_GET_POINT_RANKINGS
(
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
        SELECT 
            RANK() OVER (ORDER BY point DESC) as rank,
            user_id,
            nickname,
            intro,
            point as score,
            'points' as type
        FROM TB_USER
        ORDER BY point DESC;
END;
