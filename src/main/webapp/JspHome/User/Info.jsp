<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.logging.LogManager" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="BeansHome.User.UserDAO" %>
<%@ page import="BeansHome.User.UserDTO" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.logging.ConsoleHandler" %>
<%@ page import="BeansHome.Study.StudyDAO" %>
<%@ page import="BeansHome.Streak.StreakDAO" %>
<%@ page import="BeansHome.Session.SessionDAO" %>
<%@ page import="BeansHome.Streak.StreakDTO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/User/css/Info.css">
<%
    // 로거 먼저 생성
    Logger logger = Logger.getLogger("Main_SignIn.jsp");
    logger.setLevel(Level.ALL);

    UserDAO userDAO = new UserDAO();

    // 세션에 사용자가 있는 경우 사용자 정보 업데이트
    UserDTO currentUser = new UserDTO();
    Integer userId = (Integer) session.getAttribute("userId");

    try {
        // 현재 사용자 정보 조회
        if(userDAO.readUser(userId, currentUser)) {
            session.setAttribute("user", currentUser);
        }
    } catch (Exception e) {
        logger.log(Level.SEVERE, "Error retrieving user information", e);
        e.printStackTrace();
    }

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