<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.naming.java.javaURLContextFactory"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="BeansHome.User.UserDAO" %>
<%@ page import="BeansHome.Study.StudyDAO" %>
<%@ page import="BeansHome.Streak.StreakDAO" %>
<%@ page import="BeansHome.Session.SessionDAO" %>
<%@ page import="BeansHome.Streak.StreakDTO" %>
<%@ page import="BeansHome.User.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="BeansHome.Study.StudyDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%----------------------------------------------------------------------
    [HTML Page - 헤드 영역]
    --------------------------------------------------------------------------%>
    <%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"/>
    <meta http-equiv="Expires" content="0"/>
    <meta http-equiv="pragma" content="no-cache"/>
    <meta name="Description" content="검색 엔진을 위해 웹 페이지에 대한 설명을 명시"/>
    <meta name="keywords" content="검색 엔진을 위해 웹 페이지와 관련된 키워드 목록을 콤마로 구분해서 명시"/>
    <meta name="Author" content="문서의 저자를 명시"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="icon" href="../images/favicon-96x96.png" type="image/png" sizes="96x96">
    <title>당고링고</title>
    <%----------------------------------------------------------------------
    [HTML Page - 스타일쉬트 구현 영역]
    [외부 스타일쉬트 연결 : <link rel="stylesheet" href="Hello.css?version=1.1"/>]
    --------------------------------------------------------------------------%>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-jp.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Words/CSS/Words.css">
    <%----------------------------------------------------------------------
    [HTML Page - 자바스크립트 구현 영역 (상단)]
    [외부 자바스크립트 연결 (각각) : <script type="text/javascript" src="Hello.js"></script>]
    --------------------------------------------------------------------------%>
    <script>
        <%
            Logger logger = Logger.getLogger("Words.jsp");
            logger.setLevel(Level.ALL);

            UserDAO userDAO = new UserDAO();
            StudyDAO studyDAO = new StudyDAO();
            SessionDAO sessionDAO = new SessionDAO();
            UserDTO currentUser = new UserDTO();
            StudyDTO currentStudy = new StudyDTO();
            ArrayList<StudyDTO> studyCounts = new ArrayList<>();
            Integer userId = (Integer) session.getAttribute("userId");
            String visible = "visible";

            // 기본값 설정
            Integer selectedNLevel = 5;  // 기본 N5
            Integer currentDay = 1;     // 기본 Day 1
            Integer wordsId = 1;
            boolean flag = false;
            if (request.getParameter("level") != null) {
            	flag = true;
            	selectedNLevel = Integer.parseInt(request.getParameter("level"));
            }

            try {

                if (flag) {
	              	// 현재 학습 중인 단어장 정보 조회 (최근 학습 정보)
					studyDAO.readCurrentStudy(userId, selectedNLevel, 0, currentStudy);
					wordsId = currentStudy.getWordsId();
					// 예: wordsId가 104라면 N1의 Day 04를 의미

					currentDay = wordsId % 100;     // 나머지 두 자리 (Day)

	                // 일자별 학습한 단어 정보 조회
	                studyDAO.readStudyCounts(userId, selectedNLevel, studyCounts);
                } else {

                	// 현재 학습 중인 단어장 정보 조회 (최근 학습 정보)
    				studyDAO.readCurrentStudy(userId, 1, 1, currentStudy);
    				wordsId = currentStudy.getWordsId();
    				// 예: wordsId가 104라면 N1의 Day 04를 의미

    				// URL에서 레벨이 지정되지 않은 경우에만 현재 학습 중인 레벨을 사용
    				selectedNLevel = wordsId / 100;  // 첫 자리 (N레벨)

    				currentDay = wordsId % 100;     // 나머지 두 자리 (Day)

                    // 일자별 학습한 단어 정보 조회
                    studyDAO.readStudyCounts(userId, selectedNLevel, studyCounts);

                }

            } catch (Exception e) {
                logger.log(Level.SEVERE, "Error retrieving information", e);
            }

            if(studyCounts.size() == 0) {
            	for(int i = 0; i < 10; i++) {
                    StudyDTO study = new StudyDTO();
                    study.setWordsId(selectedNLevel * 100 + i);
                    study.setStudyCount(0);
                    studyCounts.add(study);
                }
            }

        %>

        // N레벨 변경 함수
        function changeLevel(level) {
            // URL에 선택한 레벨을 파라미터로 추가하고 페이지 새로고침
            window.location.href = '${pageContext.request.contextPath}/JspHome/Words/Words.jsp?level=' + level;
        }

        document.addEventListener('DOMContentLoaded', function() {

            const levelButton = document.querySelector('.label');
            levelButton.textContent = 'N<%= selectedNLevel %>';

            const options = document.querySelectorAll('.option-item');
            options.forEach(option => {
                if(option.textContent === 'N<%= selectedNLevel %>') {
                    option.classList.add('active');
                }
            });

        });
    </script>
</head>
<body class="Body">
<%----------------------------------------------------------------------
[HTML Page - Header 영역]
--------------------------------------------------------------------------%>
<jsp:include page="../Common/Navbar.jsp" />
<%----------------------------------------------------------------------
[HTML Page - Main 디자인 영역]
--------------------------------------------------------------------------%>
<main class="main-container">
    <%------------------------------------------------------------------
        단어장 급수 선택 카드 영역
    ----------------------------------------------------------------------%>
    <section class="nav-card">
        <header class="nav-card-header">
            <div class="nav-card-left">
                <span class="nav-card-title">JLPT</span>
                <div class="nav-dropdown">
                    <button class="label">N<%= selectedNLevel %></button>
                    <ul class="option-list">
                        <li name="1" class="option-item" onclick="changeLevel(1)">N1</li>
                        <li name="2" class="option-item" onclick="changeLevel(2)">N2</li>
                        <li name="3" class="option-item" onclick="changeLevel(3)">N3</li>
                        <li name="4" class="option-item" onclick="changeLevel(4)">N4</li>
                        <li name="5" class="option-item" onclick="changeLevel(5)">N5</li>
                    </ul>
                </div>
            </div>
            <div class="nav-card-right">
                <time class="nav-card-date">최근 학습 날짜: <fmt:formatDate value="<%= currentStudy.getStudyDate() %>" pattern="yyyy년 MM월 dd일" /></time>
            </div>
        </header>
    </section>
    <%------------------------------------------------------------------
        단어장 일자별 선택 카드 영역
    ----------------------------------------------------------------------%>
    <section class="day-cards">
        <% for (int i = 1; i <= 10; i++) { %>
        <article class="card">
            <%-- 현재 선택된 N레벨과 Day가 모두 일치할 때만 북마크 표시 --%>
            <%
                // 현재 카드의 wordsId 계산 (예: N1의 Day 04는 104)
                int cardWordsId = (selectedNLevel * 100) + i;

                // 현재 학습 중인 단어장과 비교 (정수형으로 비교)
                boolean isCurrentStudy = (wordsId == cardWordsId);

                // 디버깅을 위한 로그
                logger.info("Comparing - Current Study ID: " + studyCounts.get(i - 1).getWordsId() +
                        ", Card ID: " + cardWordsId +
                        ", Is Current: " + isCurrentStudy);
            %>

            <% if (isCurrentStudy) { %>
            <div class="bookmark"></div>
            <% } %>
            <div class="card-title-container">
                <% if (i < 10) { %>
                <h2 class="card-title">Day 0<%= i %></h2>
                <% } else { %>
                <h2 class="card-title">Day <%= i %></h2>
                <% } %>
                <% if (isCurrentStudy) { %>
                <p class="card-subtitle">최근 학습한 단어장</p>
                <% } else { %>
                <p style="visibility: hidden;" class="card-subtitle">최근 학습한 단어장</p>
                <% } %>
            </div>
            <div class="progress-bar-container">
                <p class="progress-text"><%= studyCounts.get(i-1).getStudyCount() %>/50</p>
                <progress class="progress-bar" value="<%= studyCounts.get(i-1).getStudyCount() %>" min="0" max="50">
                </progress>
            </div>
            <div class="button-container">
                <button class="button" type="button" onclick="location.href='${pageContext.request.contextPath}/JspHome/Quiz/Quiz_Choose.jsp?wordsId=<%= cardWordsId %>'">퀴즈</button>
                <button class="button" type="button" onclick="location.href='${pageContext.request.contextPath}/JspHome/Study/Words_Study.jsp?wordsId=<%= cardWordsId %>'">학습</button>
            </div>
        </article>
        <% } %>
    </section>
</main>
<%----------------------------------------------------------------------
[HTML Page - Footer 영역]
--------------------------------------------------------------------------%>
<jsp:include page="../Common/Footer.jsp" />
<%----------------------------------------------------------------------
[HTML Page - END]
--------------------------------------------------------------------------%>
<%----------------------------------------------------------------------
[HTML Page - 자바스크립트 구현 영역 (하단)]
[외부 자바스크립트 연결 (각각) : <script type="text/javascript" src="Hello.js"></script>]
--------------------------------------------------------------------------%>
<script type="text/javascript" src="${pageContext.request.contextPath}/JspHome/Words/JS/Words.js"></script>
</body>
</html>