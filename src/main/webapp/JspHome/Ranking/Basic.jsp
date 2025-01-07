<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="mock.MockDataManager" %>
<%@ page import="model.UserDTO" %>
<% 
    request.setCharacterEncoding("UTF-8");
    
    // 목업 데이터 매니저
    MockDataManager mockManager = MockDataManager.getInstance();
    UserDTO currentUser = mockManager.getCurrentUser();
    
    // 랭킹 타입 (기본값: points)
    String rankingType = request.getParameter("type");
    if (rankingType == null) rankingType = "points";
    
    // 랭킹 목록 조회 (상위 10명)
    List<UserDTO> rankings = mockManager.getRankingList(rankingType, 10);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>랭킹 - 당고링고</title>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-jp.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Ranking/css/ranking.css">
</head>
<body>
    <header>
        <jsp:include page="../Common/Navbar.jsp" />
    </header>

    <main class="ranking-container">
        <section class="ranking-header">
            <h1>랭킹</h1>
            <div class="ranking-tabs">
                <a href="?type=words" class="tab <%= rankingType.equals("words") ? "active" : "" %>">학습 단어</a>
                <a href="?type=points" class="tab <%= rankingType.equals("points") ? "active" : "" %>">누적 포인트</a>
                <a href="?type=dangos" class="tab <%= rankingType.equals("dangos") ? "active" : "" %>">당고 수집</a>
            </div>
        </section>

        <section class="ranking-list">
            <div class="my-rank">
                <div class="rank-info">
                    <span class="rank-number"><%= mockManager.getUserRank(currentUser.getUserId(), rankingType) %></span>
                    <span class="rank-total">/ <%= mockManager.getTotalUsers() %></span>
                </div>
                <div class="user-info">
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/<%= currentUser.getProfileImage() %>" 
                         alt="<%= currentUser.getNickname() %>님의 프로필" class="profile-image">
                    <span class="nickname"><%= currentUser.getNickname() %></span>
                </div>
                <div class="score">
                    <%= getScoreByType(currentUser, rankingType) %>
                    <%= getScoreUnit(rankingType) %>
                </div>
            </div>

            <div class="ranking-table">
                <% for (int i = 0; i < rankings.size(); i++) { 
                    UserDTO user = rankings.get(i);
                %>
                    <div class="rank-row <%= user.getUserId() == currentUser.getUserId() ? "current-user" : "" %>">
                        <div class="rank-number"><%= i + 1 %></div>
                        <div class="user-info">
                            <img src="${pageContext.request.contextPath}/JspHome/Main/images/<%= user.getProfileImage() %>" 
                                 alt="<%= user.getNickname() %>님의 프로필" class="profile-image">
                            <span class="nickname"><%= user.getNickname() %></span>
                        </div>
                        <div class="score">
                            <%= getScoreByType(user, rankingType) %>
                            <%= getScoreUnit(rankingType) %>
                        </div>
                    </div>
                <% } %>
            </div>
        </section>
    </main>

    <footer>
        <jsp:include page="../Common/Footer.jsp" />
    </footer>
</body>
</html>

<%!
    // 랭킹 타입에 따른 점수 반환
    private int getScoreByType(UserDTO user, String type) {
        return switch (type) {
            case "words" -> user.getQuizRight();
            case "dangos" -> user.getDangos();
            default -> user.getPoint();
        };
    }
    
    // 랭킹 타입에 따른 단위 반환
    private String getScoreUnit(String type) {
        return switch (type) {
            case "words" -> "개";
            case "points" -> "P";
            case "dangos" -> "개";
            default -> "";
        };
    }
%>
