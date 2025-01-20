<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.naming.java.javaURLContextFactory"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="BeansHome.User.*"%>
<%@page import="java.util.logging.*"%>
<%@ page import="java.io.*" %>
<% 
    // 로깅 설정
    try {
        InputStream logConfig = application.getResourceAsStream("/WEB-INF/classes/logging.properties");
        if (logConfig != null) {
            LogManager.getLogManager().readConfiguration(logConfig);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    Logger logger = Logger.getLogger("Main_SignUp.jsp");
    logger.setLevel(Level.ALL);
    
    request.setCharacterEncoding("UTF-8");
    
    // 세션에 사용자가 있는 경우 사용자 정보 업데이트
    UserDTO currentUser = (UserDTO) session.getAttribute("user");
    if (currentUser != null) {
        try {
            UserDAO userDAO = new UserDAO();
            UserDTO updatedUser = userDAO.getUserById(currentUser.getUserId());
            if (updatedUser != null) {
                session.setAttribute("user", updatedUser);
                logger.info("User session updated for user ID: " + currentUser.getUserId());
            }
        } catch (Exception e) {
            logger.severe("Error updating user session: " + e.getMessage());
            e.printStackTrace();
        }
    }
%>

<%
    // 변수 초기화
    String email = "";
    String name = "";
    String nickname = "";
    String errorMessage = "";

    if (request.getMethod().equals("POST")) {
        request.setCharacterEncoding("UTF-8");
        
        // POST 요청에서 파라미터 가져오기
        email = request.getParameter("email");
        String password = request.getParameter("password");
        name = request.getParameter("name");
        nickname = request.getParameter("nickname");
        
        // 입력값 검증
        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            name == null || name.trim().isEmpty() ||
            nickname == null || nickname.trim().isEmpty()) {
            errorMessage = "모든 필드를 입력해주세요.";
        } else {
            UserDAO userDAO = new UserDAO();
            UserDTO userDTO = new UserDTO();
            
            try {
                userDTO.setEmail(email.trim());
                userDTO.setPassword(password);
                userDTO.setName(name.trim());
                userDTO.setNickname(nickname.trim());
                
                logger.info("Attempting to register user - Email: " + email + ", Name: " + name + ", Nickname: " + nickname);
                
                if (userDAO.register(userDTO)) {
                    logger.info("Registration successful for: " + email);
                    response.sendRedirect("Main_SignIn.jsp?registered=true");
                    return;
                }
            } catch (Exception e) {
                logger.severe("Error during registration: " + e.getMessage());
                e.printStackTrace();
                errorMessage = e.getMessage();
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>회원가입 - 당고링고</title>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-jp.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Main/css/auth.css">
</head>
<body>
<div class="container">
    <main>
        <div class="card signup-card">
            <h1><a href="../Main/Main.jsp" style="text-decoration: none; color: inherit;">당고링고</a></h1>
            <form method="post" action="Main_SignUp.jsp" onsubmit="return validateForm()">
                <input type="email" 
                       name="email" 
                       placeholder="이메일" 
                       required
                       value="<%= email %>">
                       
                <input type="text" 
                       name="name" 
                       placeholder="이름" 
                       required 
                       minlength="2" 
                       maxlength="20"
                       pattern="[가-힣A-Za-z]+"
                       title="한글, 영문만 사용 가능합니다"
                       value="<%= name %>">
                       
                <input type="text" 
                       name="nickname" 
                       placeholder="닉네임" 
                       required 
                       minlength="2" 
                       maxlength="20"
                       pattern="[가-힣A-Za-z0-9]+"
                       title="한글, 영문, 숫자만 사용 가능합니다"
                       value="<%= nickname %>">
                       
                <input type="password" 
                       name="password" 
                       id="password1" 
                       placeholder="비밀번호" 
                       required 
                       minlength="8">
                <div id="passwordValidation" class="password-validation"></div>
                       
                <input type="password" 
                       name="password2" 
                       id="password2" 
                       placeholder="비밀번호 확인" 
                       required 
                       minlength="8">
                <div id="passwordMatch" class="password-match"></div>
                
                <% if (!errorMessage.isEmpty()) { %>
                    <p class="error-message"><%= errorMessage %></p>
                <% } %>
                
                <a href="Main_SignIn.jsp" class="login-link">이미 계정이 있으신가요? 로그인하기</a>
                <button type="submit">회원가입</button>
            </form>
        </div>
    </main>
</div>

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
</body>
</html>
