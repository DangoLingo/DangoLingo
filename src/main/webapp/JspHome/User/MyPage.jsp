<%@ page import="org.apache.naming.java.javaURLContextFactory"%>
<%@ page import="BeansHome.Study.StudyDAO" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="BeansHome.User.UserDTO" %>
<%@ page import="java.util.logging.Level" %>
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
        body {
            font-family: 'Pretendard JP', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            flex-direction: column;
            min-height: 100vh;
            background-color: #F6F7F5;
            margin: 0;
        }

        main {
            width: 1060px;
            margin: 0 auto;
            padding: 84px 24px;
            min-height: calc(100vh - 120px);
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        .profile-section {
            background-color: #FFFFFF;
            border-radius: 12px;
            padding: 20px 32px;
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 40px;
        }

        .profile-card-image {
            width: 100px;
            height: 100px;
            border-radius: 50px;
            margin: 0 20px;
            object-fit: cover;
            border: 1px solid #5C8B6C;
        }

        .profile-info {
            flex-grow: 1;
            margin-top: 0px;
        }

        .profile-title {
            font-weight: 700;
            font-size: 20px;
            color: #171719;
            margin: 0 0 12px 0;
            height: 30px;
        }

        .profile-email {
            height: 20px;
            margin-bottom:10px;
        }

        .profile-name {
            display: flex;
            align-items: center;
            gap : 10px;
            height: 20px;
        }

        .profile-record {
            display: flex;
            align-items: center;
        }

        .profile-point, .profile-rank {
            margin: 0 50px;
            text-align: center;
        }

        .profile-date {
            color: #495057;
            font-size: 14px;
            line-height: 0.5;
            margin-top: 10px;
        }

        .profile-bio {
            color: #171719;
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 0px;
        }

        .content-section {
            background-color: #FFFFFF;
            border-radius: 12px;
            padding: 32px;
            flex-grow: 1;
        }

        .nav-list {
            display: flex;
            list-style: none;
            padding: 0;
            margin: 0 0 12px 0;
            border-bottom: 1px solid #E9ECEF;
        }

        .nav-item {
            color: #868E96;
            cursor: pointer;
            padding: 12px 24px;
            font-size: 14px;
            font-weight: 500;
            text-align: center;
            width: 80px;
            position: relative;
        }

        .nav-item.active {
            color: #5C8B6C;
            font-weight: 600;
        }

        .nav-item.active::after {
            content: '';
            position: absolute;
            bottom: -1px;
            left: 0;
            width: 100%;
            height: 2px;
            background-color: #5C8B6C;
        }

        .edit-button {
            background-color: #5C8B6C;
            color: white;
            border: none;
            padding: 6px 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.2s;
            width: 100px;
            font-size: 14px;
        }

        .edit-button:hover {
            background-color: #324931;
        }
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
        // -----------------------------------------------------------------
        // [사용자 함수 및 로직 구현]
        // -----------------------------------------------------------------

        // -----------------------------------------------------------------
    </script>
        <%
            // 로거 먼저 생성
            Logger logger = Logger.getLogger("Main_SignIn.jsp");
            logger.setLevel(Level.ALL);

            StudyDAO studyDAO = new StudyDAO();
            UserDTO currentUser = (UserDTO) session.getAttribute("user");

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
                    <div class="profile-rank"><h3 class="profile-title">랭킹</h3><div>-위</div></div>
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
                    정보 수정
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