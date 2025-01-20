<%@ page import="BeansHome.Study.StudyDTO" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="BeansHome.Study.StudyDAO" %>
<%@ page import="BeansHome.User.UserDTO" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="BeansHome.User.UserDAO" %>
<%@ page import="java.util.logging.*"%>
<%@ page import="BeansHome.Ranking.RankingDAO" %>
<%@ page import="BeansHome.Streak.StreakDAO" %>
<%@ page import="BeansHome.Ranking.RankingDTO" %>
<%@ page import="BeansHome.Streak.StreakDTO" %>
<%@ page import="BeansHome.Session.SessionDAO" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 로거 먼저 생성
    Logger logger = Logger.getLogger("Main_SignIn.jsp");
    logger.setLevel(Level.ALL);

    UserDAO userDAO = new UserDAO();
    StudyDAO studyDAO = new StudyDAO();
    StreakDAO streakDAO = new StreakDAO();
    SessionDAO sessionDAO = new SessionDAO();
    List<StreakDTO> userStreaks = null;
    // 세션에 사용자가 있는 경우 사용자 정보 업데이트
    UserDTO currentUser = new UserDTO();
    Integer userId = (Integer) session.getAttribute("userId");
    Integer totalStudyCount = 0;

    try {

        // 현재 사용자 정보 조회
        logger.info("Retrieved user info: " + (currentUser != null ? currentUser.getNickname() : "null"));
        if(userDAO.readUser(userId, currentUser)) {
            session.setAttribute("user", currentUser);
        }

        totalStudyCount = sessionDAO.readSession(userId);
        // 현재 사용자의 스트릭 정보 조회
        userStreaks = streakDAO.getUserStreaks(currentUser.getUserId());
        logger.info("Retrieved streak info: " + (userStreaks != null ? userStreaks.size() + " records" : "null"));

    } catch (Exception e) {
        logger.log(Level.SEVERE, "Error retrieving user information", e);
        e.printStackTrace();
    }


%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/User/css/History.css">
<%----------------------------------------------------------------------
[HTML Component - 학습 기록 디자인 영역]
--------------------------------------------------------------------------%>
<%------------------------------------------------------------------
    스트릭 영역
----------------------------------------------------------------------%>
<section class="streak-tracker">
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
                     title="<%= dateStr %> : <%= point %>포인트"
                     data-point="<%= point %>포인트"
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
<%------------------------------------------------------------------
    학습 기록 카드 영역
----------------------------------------------------------------------%>
<section class="history-section">
    <article class="history-card">
        <div class="history-title">외운 단어 수</div>
        <div><%= totalStudyCount %> 단어</div>
    </article>
    <article class="history-card">
        <div class="history-title">퀴즈 정답률</div>
        <div><%= Math.round (currentUser.getQuizRight() / (double)currentUser.getQuizCount() * 1000) / 10.0 %>%</div>
    </article>
    <article class="history-card">
        <div class="history-title">총 학습 시간</div>
        <div><%= (currentUser.getStudyTime() / 60) %>시간&nbsp;&nbsp;<%= (currentUser.getStudyTime() % 60) %>분</div>
    </article>
    <article class="history-card">
        <div class="history-title"> 포인트</div>
        <div><fmt:formatNumber value="<%= currentUser.getTotalPoint() %>" pattern="#,###,###"/></div>
    </article>
</section>
<%----------------------------------------------------------------------
[HTML Component - END]
--------------------------------------------------------------------------%>