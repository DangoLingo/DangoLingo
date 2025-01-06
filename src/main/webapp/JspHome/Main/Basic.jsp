<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
    request.setCharacterEncoding("UTF-8");
    
    // 테스트를 위한 임시 세션 설정
    session.setAttribute("userNickname", "테스트사용자");
    
    // 세션에서 사용자 정보 가져오기
    String userNickname = (String) session.getAttribute("userNickname");
    boolean isLoggedIn = userNickname != null;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>당고링고</title>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-jp.css" />
    <link rel="stylesheet" href="./css/main.css">
</head>
<body>
    <header>
        <jsp:include page="../Common/Navbar.jsp" />
    </header>

    <main class="main-container">
        <% if (!isLoggedIn) { %>
            <!-- 비로그인 상태일 때 표시될 내용 -->
            <section class="hero-section">
                <article class="hero-content">
                    <h1 class="main-title">달콤한 일본어 학습 파트너,<br>당고링고</h1>
                    <p class="sub-text">일본어 학습을 통해<br>나만의 당고를 만들어보세요.</p>
                    <button class="start-button">시작하기</button>
                </article>
                <figure class="hero-image">
                    <img src="images/dango-logo.png" alt="당고 캐릭터" class="dango-image">
                </figure>
            </section>

            <section class="features">
                <article class="feature-item">
                    <h3>당고 꾸미기</h3>
                    <p>포인트를 모아<br>당고를 꾸며 보세요.</p>
                </article>
                <article class="feature-item">
                    <h3>단어 학습</h3>
                    <p>퀴즈를 풀면서<br>일본어 단어를 외워 보세요.</p>
                </article>
                <article class="feature-item">
                    <h3>랭킹 시스템</h3>
                    <p>친구들과 함께<br>경쟁해 보세요.</p>
                </article>
            </section>
        <% } else { %>
            <!-- 로그인 상태일 때 표시될 내용 -->
            <section class="dashboard">
                <article class="user-profile">
                    <div class="profile-image-container">
                        <img src="images/dango-profile.png" alt="프로필 이미지">
                    </div>
                    <header class="profile-header">
                        <h2>안녕하세요, <%= userNickname %>님</h2>
                        <p>오늘도 당고링고와 함께 달콤한 하루되세요.</p>
                        <button class="study-button">학습하기</button>
                    </header>
                </article>
                
                <section class="statistics">
                    <article class="stat-item">
                        <h3>학습 단어</h3>
                        <p class="stat-number">100개</p>
                    </article>
                    <article class="stat-item">
                        <h3>연속 학습</h3>
                        <p class="stat-number">10일</p>
                    </article>
                    <article class="stat-item">
                        <h3>학습 포인트</h3>
                        <p class="stat-number">1,300점</p>
                    </article>
                    <article class="stat-item">
                        <h3>랭킹</h3>
                        <p class="stat-number">13위</p>
                    </article>
                </section>
                
                <section class="streak-tracker">
                    <h3>스트릭</h3>
                    <div class="streak-chart">
                        <div class="streak-days">
                            <span>Mon</span>
                            <span>Tue</span>
                            <span>Wed</span>
                            <span>Thu</span>
                            <span>Fri</span>
                            <span>Sat</span>
                            <span>Sun</span>
                        </div>
                        <% 
                        // 52주 그리드 생성
                        for(int week = 0; week < 52; week++) { 
                        %>
                            <div class="streak-grid">
                                <% 
                                // 각 주의 7일 생성
                                for(int day = 0; day < 7; day++) {
                                    // 임시로 랜덤한 레벨 할당 (실제로는 DB에서 데이터를 가져와야 함)
                                    int level = (int)(Math.random() * 5);
                                    int count = level * 2;  // 임시 학습 횟수
                                %>
                                    <div class="streak-cell level-<%= level %>" data-count="<%= count %>회 학습"></div>
                                <% } %>
                            </div>
                        <% } %>
                    </div>
                </section>
            </section>
        <% } %>
    </main>

    <footer>
        <jsp:include page="../Common/Footer.jsp" />
    </footer>
</body>
</html>
