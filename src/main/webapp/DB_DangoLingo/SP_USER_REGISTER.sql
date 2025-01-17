CREATE OR REPLACE PROCEDURE SP_USER_REGISTER
(
    iEmail      IN  VARCHAR2,        -- 이메일
    iPassword   IN  VARCHAR2,        -- 비밀번호
    iName       IN  VARCHAR2,        -- 이름
    iNickname   IN  VARCHAR2,        -- 닉네임
    oCursor     OUT SYS_REFCURSOR    -- 결과 커서
)
IS
    vCount NUMBER;                   -- 중복 체크용 변수
    vErrorMsg VARCHAR2(4000);        -- 에러 메시지 변수
    vCleanedNickname VARCHAR2(50);   -- 정리된 닉네임
    vCleanedEmail VARCHAR2(50);      -- 정리된 이메일
BEGIN
    -- 입력 데이터 정리 (공백 제거 및 대소문자 통일)
    vCleanedNickname := TRIM(UPPER(iNickname));
    vCleanedEmail := TRIM(UPPER(iEmail));

    -- 이메일 중복 체크
    SELECT COUNT(*) INTO vCount
    FROM TB_USER
    WHERE UPPER(TRIM(EMAIL)) = vCleanedEmail;

    IF vCount > 0 THEN
        OPEN oCursor FOR
        SELECT 0 AS RESULT, '이미 사용 중인 이메일입니다.' AS ERROR_MSG FROM DUAL;
        RETURN;
    END IF;

    -- 닉네임 중복 체크
    SELECT COUNT(*) INTO vCount
    FROM TB_USER
    WHERE UPPER(TRIM(NICKNAME)) = vCleanedNickname;

    IF vCount > 0 THEN
        OPEN oCursor FOR
        SELECT -1 AS RESULT, '이미 사용 중인 닉네임입니다.' AS ERROR_MSG FROM DUAL;
        RETURN;
    END IF;

    -- 회원 등록
    BEGIN
        INSERT INTO TB_USER (
            USER_ID,
            EMAIL,
            PASSWORD,
            NAME,
            NICKNAME,
            INTRO,
            STUDY_DATE,
            STUDY_TIME,
            STUDY_DAY,
            QUIZ_COUNT,
            QUIZ_RIGHT,
            POINT
        ) VALUES (
            SQ_USER_ID.NEXTVAL,   -- USER_ID: 자동 증가
            iEmail,               -- EMAIL
            iPassword,            -- PASSWORD
            iName,                -- NAME
            iNickname,            -- NICKNAME
            NULL,                 -- INTRO: 기본 NULL
            NULL,                 -- STUDY_DATE: 기본 NULL
            0,                    -- STUDY_TIME: 기본값 0
            0,                    -- STUDY_DAY: 기본값 0
            0,                    -- QUIZ_COUNT: 기본값 0
            0,                    -- QUIZ_RIGHT: 기본값 0
            0                     -- POINT: 기본값 0
        );

        -- 커밋 및 성공 메시지 반환
        COMMIT;
        OPEN oCursor FOR
        SELECT 1 AS RESULT, '회원가입이 완료되었습니다.' AS ERROR_MSG FROM DUAL;

    EXCEPTION
        -- UNIQUE 제약 조건 위반 처리
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            OPEN oCursor FOR
            SELECT -1 AS RESULT, '닉네임 또는 이메일이 중복됩니다.' AS ERROR_MSG FROM DUAL;
        -- 기타 예외 처리
        WHEN OTHERS THEN
            ROLLBACK;
            vErrorMsg := SQLERRM;
            OPEN oCursor FOR
            SELECT -2 AS RESULT, '회원 등록 중 오류: ' || vErrorMsg AS ERROR_MSG FROM DUAL;
    END;

END SP_USER_REGISTER;
