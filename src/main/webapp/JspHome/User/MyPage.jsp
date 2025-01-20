<%@ page import="org.apache.naming.java.javaURLContextFactory"%>
<%@ page import="BeansHome.Study.StudyDAO" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="BeansHome.User.UserDTO" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="BeansHome.Ranking.RankingDAO" %>
<%@ page import="BeansHome.Ranking.RankingDTO" %>
<%@ page import="BeansHome.User.UserDAO" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/User/css/MyPage.css">
    <style>

    </style>

    <script type="text/javascript">
        // -----------------------------------------------------------------
        // [브라우저 갱신 완료 시 호출 할 이벤트 핸들러 연결 - 필수]
        // -----------------------------------------------------------------
        // window.onload = function () { DocumentInit('페이지가 모두 로드되었습니다!'); }
        // -----------------------------------------------------------------
        // [브라우저 갱신 완료 및 초기화 구현 함수 - 필수]
        // -----------------------------------------------------------------
        // 브라우저 갱신 완료 까지 기다리는 함수 - 필수
        // 일반적인 방식 : setTimeout(()=>alert('페이지가 모두 로드되었습니다!'), 50);
        function DocumentInit(Msg)
        {
            requestAnimationFrame(function() {
                requestAnimationFrame(function() {
                    alert(Msg);
                });
            });
        }

        window.addEventListener("load", (event) => {
            <%
            Integer userId = (Integer) session.getAttribute("userId");
            UserDAO userDAO = new UserDAO();
            UserDTO currentUser = new UserDTO();
            if(userDAO.readUser(userId, currentUser)) {
                session.setAttribute("user", currentUser);
            }
            %>
        });
        // -----------------------------------------------------------------
        // [사용자 함수 및 로직 구현]
        // -----------------------------------------------------------------

        // -----------------------------------------------------------------
    </script>
        <%
            // 로거 먼저 생성
            Logger logger = Logger.getLogger("Main_SignIn.jsp");
            logger.setLevel(Level.ALL);

            request.setCharacterEncoding("UTF-8");

            StudyDAO studyDAO = new StudyDAO();
            RankingDAO rankingDAO = new RankingDAO();
            RankingDTO userRanking = null;

            if(userDAO.readUser(userId, currentUser)) {
                session.setAttribute("user", currentUser);
            }
            userRanking = rankingDAO.getUserRanking(userId, "points");

        %>
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
        <section class="profile-section">
            <div class="profile-header">
                <img src="../images/dango-profile-1.png" alt="프로필 이미지" class="profile-card-image">
                <div class="profile-info">
                    <div class="profile-name">
                        <p class="profile-title"><%= currentUser.getNickname() %></p>
                        <p class="profile-email"><%= currentUser.getEmail() %></p>
                    </div>
                    <p class="profile-bio"><%= currentUser.getIntro() %></p>
                    <p class="profile-date">최근 학습한 날짜 : <fmt:formatDate value="<%= currentUser.getStudyDate() %>" pattern="yyyy년 MM월 dd일" /></p>
                </div>
                <div class =profile-record>
                    <div class="profile-point"><h3 class="profile-title">포인트</h3><div><fmt:formatNumber value="<%= currentUser.getPoint() %>" pattern="#,###,###"/></div></div>
                    <div class="profile-rank"><h3 class="profile-title">랭킹</h3><div><%= userRanking != null ? String.format("%,d", userRanking.getRank()) : "-" %>위</div></div>
                </div>
            </div>
        </section>
        <section class="content-section">
            <ul class="nav-list">
                <li class="nav-item active">정보 수정</li>
                <li class="nav-item">학습 이력</li>
                <li class="nav-item">친구 관리</li>
            </ul>
            <section id="nav-section">
                <div id="info">
                    <jsp:include page="Info.jsp"/>
                </div>
                <div id="history">
                    <jsp:include page="History.jsp"/>
                </div>
                <div id="friend">
                    <jsp:include page="Friend.jsp"/>
                </div>
            </section>
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
<script type="text/javascript">

    const info = document.getElementById("info").style;
    const history = document.getElementById("history").style;
    const friend = document.getElementById("friend").style;

    info.display="block";
    history.display="none";
    friend.display="none";

    // 네비게이션 활성화
    document.querySelectorAll('.nav-item').forEach(item => {
        item.addEventListener('click', function() {
            document.querySelectorAll('.nav-item').forEach(i => i.classList.remove('active'));
            this.classList.add('active');
            // 여기에 페이지 전환 로직 추가
            const info = document.getElementById("info").style;
            const history = document.getElementById("history").style;
            const friend = document.getElementById("friend").style;

            if(item.innerHTML == "학습 이력") {
                info.display="none";
                history.display="block";
                friend.display="none";
            } else if (item.innerHTML == "정보 수정") {
                info.display="block";
                history.display="none";
                friend.display="none";
            } else {
                info.display="none";
                history.display="none";
                friend.display="block";
            }
        });
    });

</script>
</body>
</html>