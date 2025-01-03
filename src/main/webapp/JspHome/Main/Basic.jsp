<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
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
    <jsp:include page="../Common/Navbar.jsp" />

    <div class="main-container">
        <div class="content-box">
            <div class="content-left">
                <h1 class="main-title">달콤한 일본어 학습 파트너,<br>당고링고</h1>
                <p class="sub-text">일본어 학습을 통해<br>나만의 당고를 만들어보세요.</p>
                <button class="start-button">시작하기</button>
            </div>
            <img src="images/dango-logo.png" alt="당고 캐릭터" class="dango-image">
        </div>

        <div class="feature-cards">
            <div class="feature-card">
                <h3>당고 꾸미기</h3>
                <p>포인트를 모아<br>당고를 꾸며 보세요.</p>
            </div>
            <div class="feature-card">
                <h3>단어 학습</h3>
                <p>퀴즈를 풀면서<br>일본어 단어를 외워 보세요.</p>
            </div>
            <div class="feature-card">
                <h3>랭킹 시스템</h3>
                <p>친구들과 함께<br>경쟁해 보세요.</p>
            </div>
        </div>
    </div>

    <jsp:include page="../Common/Footer.jsp" />
</body>
</html>
