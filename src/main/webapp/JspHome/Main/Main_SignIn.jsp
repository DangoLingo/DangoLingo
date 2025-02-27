<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.naming.java.javaURLContextFactory"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="BeansHome.User.*"%>
<%@page import="java.util.logging.*"%>
<%@page import="java.io.*"%>

<% 
    // 로거 먼저 생성
    Logger logger = Logger.getLogger("Main_SignIn.jsp");
    logger.setLevel(Level.ALL);
    
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
    logger.info("\n\n=== New Login Request ===");
    logger.info("Request Method: " + request.getMethod());
    logger.info("Remote Address: " + request.getRemoteAddr());
    
    request.setCharacterEncoding("UTF-8");
    
    // 로그인 처리 로직
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String errorMessage = "";
    
    if (request.getMethod().equals("POST")) {
        logger.info("=== Processing Login Request ===");
        logger.info("Email: [" + email + "]");
        logger.info("Password length: " + (password != null ? password.length() : "null"));
        
        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            errorMessage = "이메일과 비밀번호를 입력해주세요.";
            logger.warning("Empty fields detected - Email: " + (email == null) + ", Password: " + (password == null));
        } else {
            try {
                logger.info("\n=== Login Request ===");
                logger.info("Email: [" + email + "]");
                logger.info("Password length: " + password.length());
                
                UserDAO userDAO = new UserDAO();
                UserDTO user = userDAO.login(email.trim(), password);
                
                logger.info("Login result - User: " + (user != null ? user.getEmail() : "null"));
                
                if (user != null) {
                    logger.info("Setting session attributes...");
                    session.setAttribute("userId", user.getUserId());
                    session.setAttribute("userEmail", user.getEmail());
                    session.setAttribute("userNickname", user.getNickname());
                    session.setAttribute("user", user);
                    logger.info("User logged in successfully: " + user.getEmail());
                    
                    logger.info("Session attributes set successfully");
                    logger.info("Redirecting to Main.jsp");
                    
                    response.sendRedirect("Main.jsp");
                    return;
                } else {
                    errorMessage = "이메일 또는 비밀번호가 올바르지 않습니다.";
                    logger.warning("Login failed - Invalid credentials for email: " + email);
                }
            } catch (Exception e) {
                errorMessage = "로그인 처리 중 오류가 발생했습니다: " + e.getMessage();
                logger.severe("Error during login process: " + e.getMessage());
                StringWriter sw = new StringWriter();
                e.printStackTrace(new PrintWriter(sw));
                logger.severe("Stack trace: " + sw.toString());
            }
        }
    }
    
    // 회원가입 완료 메시지 처리
    String registered = request.getParameter("registered");
    if (registered != null && registered.equals("true")) {
        errorMessage = "회원가입이 완료되었습니다. 로그인해주세요.";
        logger.info("Showing registration success message");
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="icon" href="../images/favicon-96x96.png" type="image/png" sizes="96x96">
    <title>당고링고</title>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-jp.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Main/css/auth.css">
</head>
<body>
<div class="container">
    <main>      
        <div class="card login-card"> 
            <h1><a href="../Main/Main.jsp" style="text-decoration: none; color: inherit;">당고링고</a></h1>
            <form method="post" action="Main_SignIn.jsp" onsubmit="return handleLogin(event)">
                <input type="email" name="email" placeholder="이메일" required 
                       value="<%= email != null ? email : "" %>">         
                <input type="password" name="password" placeholder="비밀번호" required>
                
                <% if (!errorMessage.isEmpty()) { %>
                    <p class="<%= registered != null ? "success-message" : "error-message" %>">
                        <%= errorMessage %>
                    </p>
                <% } %>
                
                <div class="links">
                    <a href="../Main/Main_SignUp.jsp">회원가입</a>
                    <span class="divider">|</span>
                    <a href="#">비밀번호 찾기</a>
                </div>
                <button type="submit">로그인</button>
            </form>
        </div>
    </main>
</div>

<script>
function handleLogin(event) {
    event.preventDefault(); // 폼 제출 막기
    
    // 폼 데이터 로깅
    var form = event.target;
    var formData = new FormData(form);
    console.log('Login attempt with:');
    for (var pair of formData.entries()) {
        console.log(pair[0] + ': ' + (pair[0] === 'password' ? '[HIDDEN]' : pair[1]));
    }
    
    // 폼 수동 제출
    form.submit();
    return false;
}
</script>
</body>
</html>
