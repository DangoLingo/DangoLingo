<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.logging.LogManager" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="BeansHome.User.UserDAO" %>
<%@ page import="BeansHome.User.UserDTO" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.logging.ConsoleHandler" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/User/css/Info.css">
<%
    Logger logger = Logger.getLogger("Main_SignUp.jsp");
    UserDTO currentUser = (UserDTO) session.getAttribute("user");
    logger.setLevel(Level.ALL);

    request.setCharacterEncoding("UTF-8");

    // 로깅 설정
    try {
        Logger rootLogger = Logger.getLogger("");
        rootLogger.setLevel(Level.ALL);

        // 콘솔 핸들러 추가
        ConsoleHandler consoleHandler = new ConsoleHandler();
        consoleHandler.setLevel(Level.ALL);
        rootLogger.addHandler(consoleHandler);

        // 기존 로깅 설정 파일 로드
        InputStream logConfig = application.getResourceAsStream("/WEB-INF/classes/logging.properties");
        if (logConfig != null) {
            LogManager.getLogManager().readConfiguration(logConfig);
            logger.info("Logging configuration loaded successfully");
        } else {
            logger.warning("Could not find logging.properties");
        }
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("Error setting up logging: " + e.getMessage());
    }

    // 요청 정보 로깅
    logger.info("\n\n=== Update User Request ===");
    logger.info("Request Method: " + request.getMethod());
    logger.info("Remote Address: " + request.getRemoteAddr());

    // 변수 초기화
    String nickname = currentUser.getNickname();
    String intro = currentUser.getIntro();
    String password = currentUser.getPassword();
    String errorMessage = "";

    if (request.getMethod().equals("POST")) {
        request.setCharacterEncoding("UTF-8");

        // POST 요청에서 파라미터 가져오기
        intro = request.getParameter("intro");
        password = request.getParameter("password");
        nickname = request.getParameter("nickname");

        // 입력값 검증
        if (intro == null || intro.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            nickname == null || nickname.trim().isEmpty()) {
            errorMessage = "모든 필드를 입력해주세요.";
        } else {
            UserDAO userDAO = new UserDAO();
            UserDTO user = new UserDTO();

            try {
                logger.info("Attempting to register user - Intro: " + intro + ", Nickname: " + nickname);

                if (userDAO.updateUser(currentUser.getUserId(), nickname.trim(), intro, password) && userDAO.readUser(currentUser.getUserId(), user)) {
                    session.removeAttribute("userNickname");
                    session.removeAttribute("user");
                    session.setAttribute("userNickname", user.getNickname());
                    session.setAttribute("user", user);

                    logger.info("update successful for: " + intro);

                    response.sendRedirect("MyPage.jsp?update=true");
                    return;
                }
            } catch (Exception e) {
                logger.severe("Error during update: " + e.getMessage());
                e.printStackTrace();
                errorMessage = e.getMessage();
            }
        }
    }
%>
<style>
    .info-section {
        display: flex;
        flex-direction: row;
        padding-top: 16px;
        justify-content: center;
    }

    .card {
        width: 500px;
        background-color: white;
        border-radius: 16px;
        text-align: center;
        box-sizing: border-box;
        padding: 0 50px;
    }

    .login-card {
        height: auto;
        min-height: 400px;
        padding: 40px 50px;
    }

    .signup-card {
        height: auto;
        padding: 0 50px;
        position: relative;
    }

    .card h1 {
        font-size: 28px;
        font-weight: bold;
        margin-top: 50px;
        margin-bottom: 40px;
        text-align: left;
        width: 100%;
        padding-left: 0;
        font-family: "LaundryGothicOTF";
        color: #000000;
    }

    .card input {
        width: 100%;
        height: 48px;
        padding: 0 16px;
        margin-bottom: 16px;
        border-radius: 16px;
        border: 1px solid rgba(112, 115, 124, 0.22);
        font-family: "Pretendard JP";
        font-size: 16px;
        box-sizing: border-box;
        transition: all 0.2s ease;
        background-color: white;
    }

    .card input:focus {
        border: 2px solid #5C8B6C;
        outline: none;
        box-shadow: 0 0 0 2px rgba(92, 139, 108, 0.1);
    }

    .card .links {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
        margin: 0 auto;
        font-size: 14px;
        font-family: "Pretendard JP";
        gap: 0;
        letter-spacing: -0.3px;
    }

    .card .links a {
        text-decoration: none;
        color: #324931;
        width: 110px;
        text-align: center;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 24px;
        font-weight: 400;
    }

    .card .links .divider {
        color: rgba(50, 73, 49, 0.4);
        font-family: "Pretendard JP";
        font-size: 12px;
        transform: scaleY(0.8);
        padding: 0 40px;
    }

    .card button {
        width: 100%;
        height: 48px;
        background-color: #5C8B6C;
        color: white;
        border-radius: 16px;
        border: none;
        text-align: center;
        cursor: pointer;
        margin: 20px 0 30px;
        font-family: "Pretendard JP";
        font-size: 16px;
    }

    .card button:hover {
        background-color: #4a7058;
    }

    /* 에러/성공 메시지 스타일 */
    .error-message {
        color: #e03131;
        font-size: 14px;
        margin: 8px 0 16px;
        text-align: center;
        background-color: #fff5f5;
        padding: 8px 12px;
        border-radius: 8px;
        border: 1px solid #ffc9c9;
    }

    .success-message {
        color: #4CAF50;
        font-size: 14px;
        margin: 8px 0 16px;
        text-align: center;
    }

    /* 비밀번호 일치 여부 표시 */
    .password-match {
        font-size: 12px;
        margin-top: -12px;
        margin-bottom: 12px;
        text-align: left;
        padding-left: 16px;
    }

    .match {
        color: #4CAF50;
    }

    .not-match {
        color: #ff4444;
    }

    /* 모바일 반응형 스타일 */
    @media screen and (max-width: 768px) {
        .card {
            width: 90%;
            height: auto;
            padding: 20px 30px;
            margin: 0 10px;
        }

        .card h1 {
            font-size: 24px;
            margin-top: 30px;
            margin-bottom: 30px;
        }

        .card input {
            margin-bottom: 12px;
            font-size: 14px;
        }

        .card .links {
            width: 100%;
        }

        .card .links a {
            width: 90px;
        }

        .card .links .divider {
            font-size: 11px;
            padding: 0 32px;
        }

        .signup-card {
            height: auto;
            min-height: 580px;
            padding: 20px 30px 40px;
            margin: 20px 10px 40px;
        }

        .login-card {
            min-height: 380px;
            padding: 20px 30px;
        }
    }

    /* 로그인 링크 스타일 */
    .login-link {
        display: block;
        text-decoration: none;
        color: #324931;
        font-size: 14px;
        font-family: "Pretendard JP";
        margin: 24px 0;
        opacity: 0.8;
        transition: opacity 0.2s ease;
    }

    .login-link:hover {
        opacity: 1;
    }

    /* 비밀번호 유효성 표시 */
    .password-validation {
        font-size: 12px;
        margin-top: -12px;
        margin-bottom: 12px;
        text-align: left;
        padding-left: 16px;
    }

    .valid {
        color: #40c057;
    }

    .invalid {
        color: #e03131;
    }

    /* 하단 버튼 영역 고정 */
    .signup-card .login-link {
        margin: 16px 0 8px;
    }

    .signup-card button[type="submit"] {
        margin: 8px 0 16px;
    }
</style>
<%----------------------------------------------------------------------
[HTML Component - 정보 수정 디자인 영역]
--------------------------------------------------------------------------%>
<%------------------------------------------------------------------
    스트릭 영역
----------------------------------------------------------------------%>
<section class="info-section">
    <div class="card signup-card">
        <form method="post" action="MyPage.jsp" onsubmit="return validateForm()">

            <input type="text"
                   name="nickname"
                   placeholder="닉네임"
                   required
                   minlength="2"
                   maxlength="20"
                   pattern="[가-힣A-Za-z0-9]+"
                   title="한글, 영문, 숫자만 사용 가능합니다"
                   value="<%= nickname %>">

            <input type="text"
                   name="intro"
                   placeholder="소개글"
                   required
                   minlength="1"
                   maxlength="50"
                   value="<%= intro %>">

            <input type="password"
                   name="password"
                   id="password1"
                   placeholder="비밀번호"
                   value="<%= password %>"
                   required
                   minlength="8">
            <div id="passwordValidation" class="password-validation"></div>

            <input type="password"
                   name="password2"
                   id="password2"
                   placeholder="비밀번호 확인"
                   value="<%= password %>"
                   required
                   minlength="8">
            <div id="passwordMatch" class="password-match"></div>

            <% if (!errorMessage.isEmpty()) { %>
            <p class="error-message"><%= errorMessage %></p>
            <% } %>

            <button type="submit">정보 수정</button>
        </form>
    </div>
</section>
<%----------------------------------------------------------------------
[HTML Component - END]
--------------------------------------------------------------------------%>
<script>
    const password1 = document.getElementById('password1');
    const password2 = document.getElementById('password2');
    const validationDiv = document.getElementById('passwordValidation');
    const matchDiv = document.getElementById('passwordMatch');

    function validatePassword(password) {
        const hasLetter = /[A-Za-z]/.test(password);
        const hasNumber = /\d/.test(password);
        const isLongEnough = password.length >= 8;
        return hasLetter && hasNumber && isLongEnough;
    }

    password1.addEventListener('input', function() {
        const password = this.value;
        if (password.length > 0) {
            const isValid = validatePassword(password);
            validationDiv.textContent = isValid ?
                '사용 가능한 비밀번호입니다.' :
                '비밀번호는 8자 이상의 영문과 숫자 조합이어야 합니다.';
            validationDiv.className = 'password-validation ' + (isValid ? 'valid' : 'invalid');
        } else {
            validationDiv.textContent = '';
        }
    });

    password2.addEventListener('input', function() {
        const isMatch = this.value === password1.value;
        if (this.value.length > 0) {
            matchDiv.textContent = isMatch ?
                '비밀번호가 일치합니다.' :
                '비밀번호가 일치하지 않습니다.';
            matchDiv.className = 'password-match ' + (isMatch ? 'valid' : 'invalid');
        } else {
            matchDiv.textContent = '';
        }
    });

    function validateForm() {
        const password = password1.value;

        if (!validatePassword(password)) {
            alert('비밀번호는 8자 이상의 영문과 숫자 조합이어야 합니다.');
            password1.focus();
            return false;
        }

        if (password !== password2.value) {
            alert('비밀번호가 일치하지 않습니다.');
            password2.focus();
            return false;
        }

        return true;
    }
</script>