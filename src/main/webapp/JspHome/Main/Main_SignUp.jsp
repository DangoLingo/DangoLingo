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
%>

<%
    // 회원가입 처리 로직
    String email = request.getParameter("email");
    String name = request.getParameter("name");
    String nickname = request.getParameter("nickname");
    String password = request.getParameter("password");
    String password2 = request.getParameter("password2");
    String errorMessage = "";
    
    if (request.getMethod().equals("POST")) {
        logger.info("Processing signup request - Email: " + email + ", Name: " + name + ", Nickname: " + nickname);
        
        // 각 필드의 값을 로깅하여 디버깅
        logger.info("Email: [" + email + "]");
        logger.info("Name: [" + name + "]");
        logger.info("Nickname: [" + nickname + "]");
        logger.info("Password length: " + (password != null ? password.length() : "null"));
        logger.info("Password2 length: " + (password2 != null ? password2.length() : "null"));

        // trim()을 적용하기 전에 null 체크
        boolean isEmailEmpty = email == null || email.trim().isEmpty();
        boolean isNameEmpty = name == null || name.trim().isEmpty();
        boolean isNicknameEmpty = nickname == null || nickname.trim().isEmpty();
        boolean isPasswordEmpty = password == null || password.trim().isEmpty();
        boolean isPassword2Empty = password2 == null || password2.trim().isEmpty();

        if (isEmailEmpty || isNameEmpty || isNicknameEmpty || isPasswordEmpty || isPassword2Empty) {
            errorMessage = "모든 필드를 입력해주세요.";
            logger.warning("Empty fields detected - " +
                         "Email empty: " + isEmailEmpty +
                         ", Name empty: " + isNameEmpty +
                         ", Nickname empty: " + isNicknameEmpty +
                         ", Password empty: " + isPasswordEmpty +
                         ", Password2 empty: " + isPassword2Empty);
        } else if (!password.equals(password2)) {
            errorMessage = "비밀번호가 일치하지 않습니다.";
            logger.warning("Password mismatch detected");
        } else {
            try {
                UserDAO userDAO = new UserDAO();
                UserDTO newUser = new UserDTO();
                
                // trim() 적용하여 공백 제거
                newUser.setEmail(email.trim());
                newUser.setName(name.trim());
                newUser.setNickname(nickname.trim());
                newUser.setPassword(password);  // 비밀번호는 trim하지 않음
                
                logger.info("Attempting to register user with Email: " + newUser.getEmail() + 
                           ", Name: " + newUser.getName() + 
                           ", Nickname: " + newUser.getNickname());

                if (userDAO.register(newUser)) {
                    logger.info("User registration successful: " + newUser.getEmail());
                    response.sendRedirect("Main_SignIn.jsp?registered=true");
                    return;
                } else {
                    errorMessage = "이미 사용중인 이메일입니다.";
                    logger.warning("Duplicate email detected: " + newUser.getEmail());
                }
            } catch (Exception e) {
                errorMessage = "회원가입 처리 중 오류가 발생했습니다: " + e.getMessage();
                logger.severe("Error during registration: " + e.getMessage());
                e.printStackTrace();
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
                       value="<%= email != null ? email : "" %>">
                       
                <input type="text" 
                       name="name" 
                       placeholder="이름" 
                       required 
                       minlength="2" 
                       maxlength="20"
                       pattern="[가-힣A-Za-z]+"
                       title="한글, 영문만 사용 가능합니다"
                       value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>">
                       
                <input type="text" 
                       name="nickname" 
                       placeholder="닉네임" 
                       required 
                       minlength="2" 
                       maxlength="20"
                       pattern="[가-힣A-Za-z0-9]+"
                       title="한글, 영문, 숫자만 사용 가능합니다"
                       value="<%= nickname != null ? nickname : "" %>">
                       
                <input type="password" 
                       name="password" 
                       id="password1" 
                       placeholder="비밀번호" 
                       required 
                       minlength="8"
                       pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"
                       title="최소 8자, 영문과 숫자 조합이 필요합니다">
                       
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
                
                <a href="../Main/Main_SignIn.jsp" class="login-link">이미 계정이 있으신가요? 로그인하기</a>
                <button type="submit">회원가입</button>
            </form>
        </div>
    </main>
</div>

<script>
    // 비밀번호 일치 여부 실시간 체크
    document.getElementById('password2').addEventListener('input', function() {
        var password1 = document.getElementById('password1').value;
        var password2 = this.value;
        var matchDiv = document.getElementById('passwordMatch');
        
        if (password2.length > 0) {
            if (password1 === password2) {
                matchDiv.textContent = '비밀번호가 일치합니다.';
                matchDiv.className = 'password-match match';
            } else {
                matchDiv.textContent = '비밀번호가 일치하지 않습니다.';
                matchDiv.className = 'password-match not-match';
            }
        } else {
            matchDiv.textContent = '';
        }
    });
    
    // 폼 제출 전 유효성 검사
    function validateForm() {
        var password1 = document.getElementById('password1').value;
        var password2 = document.getElementById('password2').value;
        
        if (password1 !== password2) {
            alert('비밀번호가 일치하지 않습니다.');
            return false;
        }
        
        // 폼 제출을 막고 수동으로 AJAX 요청
        var form = document.querySelector('form');
        var formData = new FormData(form);
        
        // 폼 데이터 로깅
        console.log('Form submission attempt with:');
        for (var pair of formData.entries()) {
            console.log(pair[0] + ': ' + pair[1]);
        }
        
        // AJAX 요청
        fetch(form.action, {
            method: 'POST',
            body: formData
        })
        .then(response => response.text())
        .then(html => {
            console.log('Server response received');
            // 응답 내용에서 에러 메시지 확인
            if (html.includes('error-message')) {
                console.log('Error occurred during registration');
                document.body.innerHTML = html;
            } else {
                console.log('Registration successful');
                window.location.href = 'Main_SignIn.jsp?registered=true';
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
        
        return false; // 폼의 기본 제출을 막음
    }
</script>
</body>
</html>
