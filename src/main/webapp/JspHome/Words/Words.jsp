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
            // 로거 먼저 생성
            Logger logger = Logger.getLogger("Main_SignIn.jsp");
            logger.setLevel(Level.ALL);

            UserDAO userDAO = new UserDAO();
            StudyDAO studyDAO = new StudyDAO();
            SessionDAO sessionDAO = new SessionDAO();
            // 세션에 사용자가 있는 경우 사용자 정보 업데이트
            UserDTO currentUser = new UserDTO();
            StudyDTO currentStudy = new StudyDTO();
            Integer userId = (Integer) session.getAttribute("userId");
            Integer defaultLevel = 5;
            Integer bookmarkIdx;

            try {

                // 현재 사용자 정보 조회
                logger.info("Retrieved user info: " + (currentUser != null ? currentUser.getNickname() : "null"));
                if(userDAO.readUser(userId, currentUser)) {
                    session.setAttribute("user", currentUser);
                }

                //if(studyDAO.readCurrentStudy(userId, 1, 1, currentStudy)) {
                    //defaultLevel = currentStudy.getWordsId();
                //    String def = Integer.toString(defaultLevel).substring(0, 1);
                %>
                //  여기서 def랑 name 같은 li를 active 해줘야 하는데 어케 하는걸까...;;
                // 그 다음엔 class="nav-card-date" 인 태그 안에 value를
                // 최근 학습 날짜: 2024년 12월 25일 이런식으로 바꿔줘야함 키키;;;

                // ++ 추가로 드롭다운 선택해서 값 바뀔 때 마다 그거 name 값 가져와서
                // 변수에 집어 넣고 그 값으로 아래에서 readCurrentStudy 호출해서 북마크 찍어줘야 함

                <%
                //    defaultLevel = currentStudy.getWordsId();
                //}

                if(studyDAO.readCurrentStudy(userId, 1, 0, currentStudy)) {
                    bookmarkIdx = Integer.parseInt(Integer.toString(currentStudy.getWordsId()).substring(1, 2));
                }

            } catch (Exception e) {
                logger.log(Level.SEVERE, "Error retrieving user information", e);
                e.printStackTrace();
            }
        %>
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
                    <span class="nav-card-title">JLPT<%currentStudy.getWordsId();%><%currentStudy.getStudyDate();%></span>
                    <div class="nav-dropdown">
                        <!-- DB 연동 후 수정 필요 -->
                        <button class="label">N5</button>
                        <ul class="option-list">
                            <li name="1" class="option-item">N1</li>
                            <li name="2" class="option-item">N2</li>
                            <li name="3" class="option-item">N3</li>
                            <li name="4" class="option-item">N4</li>
                            <li name="5" class="option-item">N5</li>
                        </ul>
                    </div>
                </div>
                <div class="nav-card-right">
                    <!-- DB 연동 후 수정 필요 -->
                    <time class="nav-card-date">최근 학습 날짜: 2024년 12월 25일</time>
                </div>
            </header>
        </section>
        <%------------------------------------------------------------------
            단어장 일자별 선택 카드 영역
        ----------------------------------------------------------------------%>
        <section class="day-cards">
            <!-- JSP 반복문을 활용해 Day 카드 출력 -->
            <% for (int i = 1; i <= 10; i++) {
                // 북마크 표시 조건 - DB 연동 후 수정 필요
                boolean isBookmarked = ( i == 2);// (Integer.parseInt(Integer.toString(currentStudy.getWordsId()).substring(1, 3)) == 2);
            %>
            <article class="card">
                <% if (isBookmarked) { %>
                <div class="bookmark"></div>
                <% } %>
                <div class="card-title-container">
                    <% if (i < 10) { %>
                    <h2 class="card-title">Day 0<%= i %></h2>
                    <% } else { %>
                    <h2 class="card-title">Day <%= i %></h2>
                    <% } %>
                    <% if (isBookmarked) { %>
                    <p class="card-subtitle">최근 학습한 단어장</p>
                    <% } else { %>
                    <p style="visibility: hidden;" class="card-subtitle">최근 학습한 단어장</p>
                    <% } %>
                </div>
                <div class="progress-bar-container">
                    <!-- DB 연동 후 수정 필요 -->
                    <p class="progress-text"><% currentStudy.getStudyCount(); %>/50</p>
                    <progress class="progress-bar" value="<% currentStudy.getStudyCount(); %>" min="0" max="50">
                    </progress>
                </div>
                <div class="button-container">
                    <!-- 페즈 버튼에 Quiz_Choose.jsp 링크 추가 -->
                    <button class="button" type="button" onclick="location.href='${pageContext.request.contextPath}/JspHome/Quiz/Quiz_Choose.jsp?wordsId=<%currentStudy.getWordsId();%>'">퀴즈</button>
                    <button class="button" type="button" onclick="location.href='${pageContext.request.contextPath}/JspHome/Study/Words_Study.jsp?wordsId=<%currentStudy.getWordsId();%>'">학습</button>
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