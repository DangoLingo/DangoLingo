<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="BeansHome.User.*" %>
<%@ page import="BeansHome.Study.*" %>
<%@ page import="BeansHome.Ranking.*" %>
<%@ page import="BeansHome.Streak.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="BeansHome.Dango.DangoDAO" %>
<%@ page import="BeansHome.Dango.DangoDTO" %>
<% 
    // 캐시 제어
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setHeader("Expires", "0"); // Proxies
    
    // 로거 설정
    Logger logger = Logger.getLogger("Main.jsp");
    
    request.setCharacterEncoding("UTF-8");
    
    // DAO 객체들 초기화
    UserDAO userDAO = new UserDAO();
    StudyDAO studyDAO = new StudyDAO();
    RankingDAO rankingDAO = new RankingDAO();
    StreakDAO streakDAO = new StreakDAO();
    DangoDAO dangoDAO = new DangoDAO();
    RankingDTO userRanking = null;
    DangoDTO profileDango = new DangoDTO();
    List<StreakDTO> userStreaks = null;
    
    // 로그아웃 처리
    String action = request.getParameter("action");
    if ("logout".equals(action)) {
        session.invalidate();
        response.sendRedirect("Main.jsp");
        return;
    }
    
    // 세션 체크
    UserDTO currentUser = null;
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId != null) {
        try {
            currentUser = userDAO.getUserById(userId);
            dangoDAO.ReadProfileDango(userId, profileDango);
            // 세션 업데이트
            session.setAttribute("user", currentUser);
        } catch (Exception e) {
            logger.severe("Error refreshing user data: " + e.getMessage());
        }
    }
    
    logger.info("Session check - userNickname: " + (currentUser != null ? currentUser.getNickname() : "Not logged in"));
    logger.info("isLoggedIn: " + (currentUser != null));
    
    // 로그인된 경우에만 사용자 정보 조회
    if (currentUser != null) {
        try {
            logger.info("Attempting to get user info for userId: " + userId);
            
            // 현재 사용자 정보 조회
            logger.info("Retrieved user info: " + (currentUser != null ? currentUser.getNickname() : "null"));
            
            // 현재 사용자의 랭킹 정보 조회
            userRanking = rankingDAO.getUserRanking(currentUser.getUserId());
            logger.info("Retrieved ranking info: " + (userRanking != null ? userRanking.getRank() : "null"));
            
            // 현재 사용자의 스트릭 정보 조회
            userStreaks = streakDAO.getUserStreaks(currentUser.getUserId());
            logger.info("Retrieved streak info: " + (userStreaks != null ? userStreaks.size() + " records" : "null"));
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error retrieving user information", e);
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%----------------------------------------------------------------------
    [HTML Page - 헤드 영역]
    --------------------------------------------------------------------------%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="../images/favicon-96x96.png" type="image/png" sizes="96x96">
    <title>당고링고</title>
    <%----------------------------------------------------------------------
    [HTML Page - 스타일쉬트 구현 영역]
    --------------------------------------------------------------------------%>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-jp.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Main/css/main.css">
    <!-- 소개 페이지 스타일 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Main/css/intro/hero.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Main/css/intro/features.css">
    <!-- 대시보드 스타일 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Main/css/dashboard/profile.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Main/css/dashboard/statistics.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Main/css/dashboard/streak.css">
</head>
<body class="<%= currentUser != null ? "logged-in" : "" %>">
    <%----------------------------------------------------------------------
    [HTML Page - 헤더 영역]
    --------------------------------------------------------------------------%>
    <header>
        <% if (currentUser != null) { %>
            <jsp:include page="../Common/Navbar.jsp" />
        <% } %>
    </header>

    <%----------------------------------------------------------------------
    [HTML Page - 메인 컨텐츠 영역]
    --------------------------------------------------------------------------%>
    <main class="<%= currentUser != null ? "main-container" : "intro-container" %>">
        <% if (currentUser == null) { %>
            <%------------------------------------------------------------------
            비로그인 상태일 때 표시될 내용
            -------------------------------------------------------------------%>
            <section class="hero-section">
                <article class="hero-content">
                    <h1 class="main-title">달콤한 일본어 학습,<br>당고링고와 함께</h1>
                    <p class="sub-text">재미있게 배우는 일본어,<br>지금 시작해보세요</p>
                    <button class="start-button" onclick="location.href='../Main/Main_SignIn.jsp'">시작하기</button>
                </article>
                <figure class="hero-image">
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango.svg" alt="당고 캐릭터" class="dango-image">
                </figure>
            </section>

            <section class="features-section">
                <h2 class="section-title">당고링고만의 특별한 학습</h2>
                <p class="section-description">게임처럼 재미있게, 효과적으로 일본어를 배워보세요</p>
                
                <div class="features-container">
                    <article class="feature-card">
                        <div class="feature-icon-wrapper">
                            <img src="${pageContext.request.contextPath}/JspHome/Main/images/customize-icon.svg" alt="커스터마이즈 아이콘" class="feature-icon">
                        </div>
                        <div class="feature-content">
                            <h3>나만의 당고</h3>
                            <p>학습하면서 모은 포인트로<br>귀여운 당고를 꾸며보세요</p>
                        </div>
                    </article>
                    
                    <article class="feature-card">
                        <div class="feature-icon-wrapper">
                            <img src="${pageContext.request.contextPath}/JspHome/Main/images/study-icon.svg" alt="학습 아이콘" class="feature-icon">
                        </div>
                        <div class="feature-content">
                            <h3>스마트 학습</h3>
                            <p>게임처럼 재미있게<br>일본어 단어를 마스터하세요</p>
                        </div>
                    </article>
                    
                    <article class="feature-card">
                        <div class="feature-icon-wrapper">
                            <img src="${pageContext.request.contextPath}/JspHome/Main/images/ranking-icon.svg" alt="랭킹 아이콘" class="feature-icon">
                        </div>
                        <div class="feature-content">
                            <h3>함께 성장</h3>
                            <p>친구들과 함께<br>즐겁게 경쟁하며 배워요</p>
                        </div>
                    </article>
                </div>
            </section>
        <% } else { %>
            <%------------------------------------------------------------------
            로그인 상태일 때 표시될 내용
            -------------------------------------------------------------------%>
            <section class="dashboard">
                <article class="user-profile">
                    <div class="profile-image-container">
                        <img src="<%= profileDango.getLocationImg() %>"
                             alt="프로필 이미지">
                    </div>
                    <header class="profile-header">
                        <h2><%= currentUser.getNickname() %></h2>
                        <p class="user-intro"><%= currentUser.getIntro() != null ? currentUser.getIntro() : "소개글이 없습니다." %></p>
                    </header>
                </article>
                
                <section class="statistics">
                    <article class="stat-item">
                        <h3>퀴즈 풀이</h3>
                        <p class="stat-number"><%= currentUser.getQuizRight() %>개</p>
                    </article>
                    <article class="stat-item">
                        <h3>연속 학습</h3>
                        <p class="stat-number"><%= userStreaks != null && !userStreaks.isEmpty() ? userStreaks.get(0).getPoint() : "0" %>일</p>
                    </article>
                    <article class="stat-item">
                        <h3>학습 포인트</h3>
                        <p class="stat-number"><%= String.format("%,d", currentUser.getPoint()) %>점</p>
                    </article>
                    <article class="stat-item">
                        <h3>포인트 랭킹</h3>
                        <p class="stat-number"><%= userRanking != null ? String.format("%,d", userRanking.getRank()) : "-" %>위</p>
                    </article>
                </section>
                
                <section class="streak-tracker">
                    <h3>학습 기록</h3>
                    <div class="streak-container">
                        <div class="streak-chart">
                            <div class="streak-days">
                                <span>일</span>
                                <span>월</span>
                                <span>화</span>
                                <span>수</span>
                                <span>목</span>
                                <span>금</span>
                                <span>토</span>
                            </div>
                            <% 
                            // 스트릭 데이터를 Map으로 변환
                            Map<String, StreakDTO> streakMap = new HashMap<>();
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            
                            if (userStreaks != null) {
                                for (StreakDTO streak : userStreaks) {
                                    streakMap.put(sdf.format(streak.getStreakDate()), streak);
                                }
                            }
                            
                            // 오늘 날짜 기준으로 계산
                            Calendar today = Calendar.getInstance();
                            Calendar cal = Calendar.getInstance();
                            Calendar yearAgo = Calendar.getInstance();
                            yearAgo.add(Calendar.YEAR, -1); // 1년 전 날짜
                            
                            // 정확히 1년 전으로 이동
                            cal.add(Calendar.YEAR, -1);
                            
                            // 시작일이 일요일이 되도록 조정 (깃허브 스타일)
                            while (cal.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY) {
                                cal.add(Calendar.DATE, -1);
                            }
                            
                            // 총 주 수 계산 (정확히 53주)
                            int totalWeeks = 53;
                            
                            for(int week = 0; week < totalWeeks; week++) {
                                %>
                                <div class="streak-grid">
                                    <% 
                                    // 각 주의 7일 생성
                                    for(int day = 0; day < 7; day++) {
                                        String dateStr = sdf.format(cal.getTime());
                                        
                                        // 1년 이전이거나 미래의 날짜는 빈 공간으로 처리
                                        if (cal.before(yearAgo) || cal.after(today)) {
                                            %><div class="streak-cell empty"></div><%
                                        } else {
                                            StreakDTO streak = streakMap.get(dateStr);
                                            
                                            // 스트릭 레벨 계산 (포인트에 따라)
                                            int level = 0;
                                            int point = 0;
                                            if (streak != null) {
                                                point = streak.getPoint();
                                                if (point > 300) level = 4;
                                                else if (point > 200) level = 3;
                                                else if (point > 100) level = 2;
                                                else if (point > 0) level = 1;
                                            }
                                            %>
                                            <div class="streak-cell level-<%= level %>" 
                                                 title="<%= dateStr %> : <%= point %>점"
                                                 data-point="<%= point %>점"
                                                 data-date="<%= dateStr %>">
                                            </div>
                                            <%
                                        }
                                        cal.add(Calendar.DATE, 1);  // 다음 날짜로
                                    } 
                                    %>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </section>
            </section>
        <% } %>
    </main>

    <%----------------------------------------------------------------------
    [HTML Page - 푸터 영역]
    --------------------------------------------------------------------------%>
    <footer>
        <% if (currentUser != null) { %>
            <jsp:include page="../Common/Footer.jsp" />
        <% } %>
    </footer>

    <!-- JavaScript 추가 -->
    <script>
    function handleLogout() {
        if (confirm('로그아웃 하시겠습니까?')) {
            window.location.href = 'Main.jsp?action=logout';
        }
    }
    </script>
    <script src="${pageContext.request.contextPath}/JspHome/Main/js/tooltip.js"></script>
</body>
</html>