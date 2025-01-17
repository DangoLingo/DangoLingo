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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 로거 먼저 생성
    Logger logger = Logger.getLogger("Main_SignIn.jsp");
    logger.setLevel(Level.ALL);

    StudyDAO studyDAO = new StudyDAO();
    UserDTO currentUser = (UserDTO) session.getAttribute("user");

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
<%------------------------------------------------------------------
    학습 기록 카드 영역
----------------------------------------------------------------------%>
<section class="history-section">
    <article class="history-card">
        <div class="history-title">외운 단어 수</div>
        <div><%= 103 %> 단어</div>
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