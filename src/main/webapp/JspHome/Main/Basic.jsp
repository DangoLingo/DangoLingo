<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="mock.*" %>
<%@ page import="model.*" %>
<% 
    request.setCharacterEncoding("UTF-8");
    
    // ---------------------------------------------------------------------
    // [JSP 지역 변수 선언 : 세션 관련 변수]
    // ---------------------------------------------------------------------
    // 목업 데이터 매니저에서 현재 사용자 정보 가져오기
    MockDataManager mockManager = MockDataManager.getInstance();
    UserDTO currentUser = mockManager.getCurrentUser();
    
    // 세션에 사용자 정보 설정
    session.setAttribute("userNickname", currentUser.getNickname());
    String userNickname = currentUser.getNickname();
    boolean isLoggedIn = true;
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
</head>
<body>
    <%----------------------------------------------------------------------
    [HTML Page - 헤더 영역]
    --------------------------------------------------------------------------%>
    <header>
        <jsp:include page="../Common/Navbar.jsp" />
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
                        <a href="${pageContext.request.contextPath}/JspHome/Words/Basic.jsp" class="study-button">학습하기</a>
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
                        <p class="stat-number"><%= mockManager.getUserRank(currentUser.getUserId(), "point") %>위</p>
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
                            List<StudyDTO> streaks = mockManager.getStudyStreak(currentUser.getUserId());
                            
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
                                            study.setStudyDate(cal.getTime());
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
        <jsp:include page="../Common/Footer.jsp" />
    </footer>
</body>
</html>
