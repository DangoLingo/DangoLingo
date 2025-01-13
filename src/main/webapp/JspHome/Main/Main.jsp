<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="BeansHome.User.UserDAO" %>
<%@ page import="BeansHome.User.UserDTO" %>
<%@ page import="BeansHome.Study.StudyDAO" %>
<%@ page import="BeansHome.Study.StudyDTO" %>
<%@ page import="BeansHome.Ranking.RankingDAO" %>
<%@ page import="BeansHome.Ranking.RankingDTO" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="java.util.logging.Level" %>
<% 
    // 로거 설정
    Logger logger = Logger.getLogger("Main.jsp");
    
    request.setCharacterEncoding("UTF-8");
    
    // 로그아웃 처리
    String action = request.getParameter("action");
    if ("logout".equals(action)) {
        session.invalidate();
        response.sendRedirect("Main.jsp");
        return;
    }
    
    // 세션에서 로그인 상태 확인
    String userNickname = (String) session.getAttribute("userNickname");
    boolean isLoggedIn = userNickname != null;
    
    logger.info("Session check - userNickname: " + userNickname);
    logger.info("isLoggedIn: " + isLoggedIn);
    
    // 로그인된 경우에만 사용자 정보 조회
    UserDAO userDAO = new UserDAO();
    StudyDAO studyDAO = new StudyDAO();
    RankingDAO rankingDAO = new RankingDAO();
    UserDTO currentUser = null;
    RankingDTO userRanking = null;
    
    if (isLoggedIn) {
        try {
            Integer userId = (Integer) session.getAttribute("userId");
            logger.info("Attempting to get user info for userId: " + userId);
            
            // 현재 사용자 정보 조회
            currentUser = userDAO.getUserById(userId);
            logger.info("Retrieved user info: " + (currentUser != null ? currentUser.getNickname() : "null"));
            
            // 현재 사용자의 랭킹 정보 조회
            userRanking = rankingDAO.getUserRanking(userId, "points");
            logger.info("Retrieved ranking info: " + (userRanking != null ? userRanking.getRank() : "null"));
            
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
<body class="<%= isLoggedIn ? "logged-in" : "" %>">
    <%----------------------------------------------------------------------
    [HTML Page - 헤더 영역]
    --------------------------------------------------------------------------%>
    <header>
        <% if (isLoggedIn) { %>
            <jsp:include page="../Common/Navbar.jsp" />
        <% } %>
    </header>

    <%----------------------------------------------------------------------
    [HTML Page - 메인 컨텐츠 영역]
    --------------------------------------------------------------------------%>
    <main class="main-container">
        <% if (!isLoggedIn) { %>
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
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/<%= currentUser.getProfileImage() %>" 
                             alt="<%= currentUser.getNickname() %>님의 프로필">
                    </div>
                    <header class="profile-header">
                        <h2>안녕하세요, <%= currentUser.getNickname() %>님</h2>
                        <p><%= currentUser.getIntro() %></p>
                        <a href="${pageContext.request.contextPath}/JspHome/Words/Words.jsp" class="study-button">학습하기</a>
                    </header>
                </article>
                
                <section class="statistics">
                    <article class="stat-item">
                        <h3>학습 단어</h3>
                        <p class="stat-number"><%= currentUser.getQuizRight() %>개</p>
                    </article>
                    <article class="stat-item">
                        <h3>연속 학습</h3>
                        <p class="stat-number"><%= currentUser.getStudyDay() %>일</p>
                    </article>
                    <article class="stat-item">
                        <h3>학습 포인트</h3>
                        <p class="stat-number"><%= String.format("%,d", currentUser.getPoint()) %>점</p>
                    </article>
                    <article class="stat-item">
                        <h3>포인트 랭킹</h3>
                        <p class="stat-number"><%= userRanking != null ? userRanking.getRank() : "-" %>위</p>
                    </article>
                </section>
                
                <section class="streak-tracker">
                    <h3>학습 기록</h3>
                    <div class="streak-container">
                        <div class="streak-chart">
                            <div class="streak-days">
                                <span>월</span>
                                <span>화</span>
                                <span>수</span>
                                <span>목</span>
                                <span>금</span>
                                <span>토</span>
                                <span>일</span>
                            </div>
                            <% 
                            // 현재 사용자의 스트릭 데이터 조회
                            List<StudyDTO> streaks = studyDAO.getStudyStreak(currentUser.getUserId());
                            
                            // 첫 번째 날짜의 요일 확인
                            Calendar cal = Calendar.getInstance();
                            cal.add(Calendar.DATE, -363);  // 52주 전부터 시작
                            cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);  // 월요일부터 시작
                            
                            Map<String, StudyDTO> studyMap = new HashMap<>();
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            
                            // 스트릭 데이터를 Map으로 변환
                            for (StudyDTO study : streaks) {
                                studyMap.put(sdf.format(study.getStudyDate()), study);
                            }
                            
                            for(int week = 0; week < 52; week++) { 
                            %>
                                <div class="streak-grid">
                                    <% 
                                    // 각 주의 7일 생성
                                    for(int day = 0; day < 7; day++) {
                                        String dateStr = sdf.format(cal.getTime());
                                        StudyDTO study = studyMap.get(dateStr);
                                        
                                        if (study == null) {
                                            study = new StudyDTO();
                                            study.setStudyLevel(0);
                                            study.setStudyCount(0);
                                            study.setStudyDate(new java.sql.Date(cal.getTimeInMillis()));
                                        }
                                        
                                        int level = study.getStudyLevel();
                                        int count = study.getStudyCount();
                                    %>
                                        <div class="streak-cell level-<%= level %>" 
                                             data-count="<%= count %>회 학습"
                                             data-date="<%= dateStr %>">
                                        </div>
                                    <% 
                                        cal.add(Calendar.DATE, 1);  // 다음 날짜로
                                    } %>
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
        <% if (isLoggedIn) { %>
            <jsp:include page="../Common/Footer.jsp" />
        <% } %>
    </footer>

    <!-- JavaScript 추가 -->
    <script>
    function handleLogout() {
        if (confirm('로그아웃 하시겠습니까?')) {
            // AJAX를 사용하여 로그아웃 처리
            fetch('Logout.jsp')
                .then(response => {
                    // 페이지 새로고침
                    window.location.reload();
                })
                .catch(error => {
                    console.error('로그아웃 중 오류 발생:', error);
                });
        }
    }
    </script>
</body>
</html>
