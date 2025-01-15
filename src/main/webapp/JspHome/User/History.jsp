<%@ page import="BeansHome.Study.StudyDTO" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./css/History.css">
<%----------------------------------------------------------------------
[HTML Component - 학습 기록 디자인 영역]
--------------------------------------------------------------------------%>
<%------------------------------------------------------------------
    스트릭 영역
----------------------------------------------------------------------%>
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
<%------------------------------------------------------------------
    학습 기록 카드 영역
----------------------------------------------------------------------%>
<section class="history-section">
    <article class="history-card">
        <div class="history-title">외운 단어 수</div>
        <div>여기는 학습 기록에서 떼와~</div>
    </article>
    <article class="history-card">
        <div class="history-title">퀴즈 정답률</div>
        <div><%= (currentUser.getQuizRight() / currentUser.getQuizCount()) * 100 %></div>
    </article>
    <article class="history-card">
        <div class="history-title">총 학습 시간</div>
        <div><%= (currentUser.getStudyTime() / 60) %>시간<%= (currentUser.getStudyTime() % 60) %>분</div>
    </article>
    <article class="history-card">
        <div class="history-title">누적 포인트</div>
        <div>10,035 point</div>
    </article>
</section>
<%----------------------------------------------------------------------
[HTML Component - END]
--------------------------------------------------------------------------%>