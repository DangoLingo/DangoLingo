<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.naming.java.javaURLContextFactory"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="BeansHome.User.*"%>
<% request.setCharacterEncoding("UTF-8");%>

<%
    // 회원가입 처리 로직
    String email = request.getParameter("email");
    String nickname = request.getParameter("nickname");
    String password = request.getParameter("password");
    String password2 = request.getParameter("password2");
    String errorMessage = "";
    
    if (request.getMethod().equals("POST")) {
        if (email == null || email.trim().isEmpty() ||
            nickname == null || nickname.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            password2 == null || password2.trim().isEmpty()) {
            errorMessage = "모든 필드를 입력해주세요.";
        } else if (!password.equals(password2)) {
            errorMessage = "비밀번호가 일치하지 않습니다.";
        } else {
            UserDAO userDAO = new UserDAO();
            UserDTO newUser = new UserDTO();
            newUser.setEmail(email);
            newUser.setPassword(password);
            newUser.setNickname(nickname);
            
            try {
                if (userDAO.register(newUser)) {
                    // 회원가입 성공 - 로그인 페이지로 리다이렉트
                    response.sendRedirect("Main_SignIn.jsp?registered=true");
                    return;
                } else {
                    errorMessage = "이미 사용중인 이메일입니다.";
                }
            } catch (Exception e) {
                errorMessage = "회원가입 처리 중 오류가 발생했습니다.";
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
                <input type="email" name="email" placeholder="이메일" 
                       required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
                       value="<%= email != null ? email : "" %>">
                       
                <input type="text" name="nickname" placeholder="닉네임" 
                       required minlength="2" maxlength="20"
                       value="<%= nickname != null ? nickname : "" %>">
                       
                <input type="password" name="password" id="password1" 
                       placeholder="비밀번호" required minlength="8">
                       
                <input type="password" name="password2" id="password2" 
                       placeholder="비밀번호 확인" required minlength="8">
                
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
        
        return true;
    }
</script>
</body>
</html>
