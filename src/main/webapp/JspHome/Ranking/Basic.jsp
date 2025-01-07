<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mock.MockDataManager" %>
<%@ page import="model.UserDTO" %>
<%@ page import="java.util.List" %>
<%
    MockDataManager mockManager = MockDataManager.getInstance();
    
    // 각 랭킹 유형별 상위 10명 데이터 조회
    List<UserDTO> pointRanking = mockManager.getRankingList("point", 10);
    List<UserDTO> studyRanking = mockManager.getRankingList("study", 10);
    List<UserDTO> quizRanking = mockManager.getRankingList("quiz", 10);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%----------------------------------------------------------------------
    [HTML Page - 헤드 영역]
    --------------------------------------------------------------------------%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>당고링고 - 랭킹</title>
    <%----------------------------------------------------------------------
    [HTML Page - 스타일쉬트 구현 영역]
    --------------------------------------------------------------------------%>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-jp.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Ranking/css/ranking.css">
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
        <%------------------------------------------------------------------
        탭 버튼 영역
        -------------------------------------------------------------------%>
        <div class="ranking-tabs">
            <button class="tab-button active" data-tab="points">포인트</button>
            <button class="tab-button" data-tab="study">학습일수</button>
            <button class="tab-button" data-tab="quiz">정답수</button>
        </div>

        <%------------------------------------------------------------------
        랭킹 섹션 영역
        -------------------------------------------------------------------%>
        <section class="ranking-section active" id="points-ranking">
            <div class="top-rankers">
                <!-- 2등 -->
                <div class="top-rank second">
                    <div class="crown">🥈</div>
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                    <div class="user-details">
                        <div class="user-name"><%= pointRanking.get(1).getNickname() %></div>
                        <div class="user-subtitle"><%= pointRanking.get(1).getIntro() %></div>
                        <div class="user-points"><%= String.format("%,d", pointRanking.get(1).getPoint()) %> pt</div>
                    </div>
                </div>
                <!-- 1등 -->
                <div class="top-rank first">
                    <div class="crown">👑</div>
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                    <div class="user-details">
                        <div class="user-name"><%= pointRanking.get(0).getNickname() %></div>
                        <div class="user-subtitle"><%= pointRanking.get(0).getIntro() %></div>
                        <div class="user-points"><%= String.format("%,d", pointRanking.get(0).getPoint()) %> pt</div>
                    </div>
                </div>
                <!-- 3등 -->
                <div class="top-rank third">
                    <div class="crown">🥉</div>
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                    <div class="user-details">
                        <div class="user-name"><%= pointRanking.get(2).getNickname() %></div>
                        <div class="user-subtitle"><%= pointRanking.get(2).getIntro() %></div>
                        <div class="user-points"><%= String.format("%,d", pointRanking.get(2).getPoint()) %> pt</div>
                    </div>
                </div>
            </div>

            <!-- 4-10등 -->
            <div class="ranking-list">
                <% for(int i = 3; i < pointRanking.size(); i++) { %>
                    <div class="ranking-item">
                        <div class="rank-number"><%= i + 1 %></div>
                        <div class="user-info">
                            <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                            <div class="user-details">
                                <div class="user-name"><%= pointRanking.get(i).getNickname() %></div>
                                <div class="user-subtitle"><%= pointRanking.get(i).getIntro() %></div>
                            </div>
                        </div>
                        <div class="user-points"><%= String.format("%,d", pointRanking.get(i).getPoint()) %> pt</div>
                    </div>
                <% } %>
            </div>
        </section>

        <!-- 학습일수와 정답수 랭킹도 비슷한 방식으로 구현 -->
    </main>

    <%----------------------------------------------------------------------
    [HTML Page - 푸터 영역]
    --------------------------------------------------------------------------%>
    <footer>
        <jsp:include page="../Common/Footer.jsp" />
    </footer>

    <%----------------------------------------------------------------------
    [HTML Page - 자바스크립트 구현 영역]
    --------------------------------------------------------------------------%>
    <script>
        // ---------------------------------------------------------------------
        // [탭 전환 이벤트 처리]
        // ---------------------------------------------------------------------
        document.querySelectorAll('.tab-button').forEach(button => {
            button.addEventListener('click', () => {
                const type = button.dataset.tab;
                
                // 탭 버튼 활성화 상태 변경
                document.querySelectorAll('.tab-button').forEach(btn => {
                    btn.classList.remove('active');
                });
                button.classList.add('active');

                // 랭킹 섹션 표시 상태 변경
                document.querySelectorAll('.ranking-section').forEach(section => {
                    section.classList.remove('active');
                });
                document.getElementById(`${type}-ranking`).classList.add('active');
            });
        });
    </script>
</body>
</html>
