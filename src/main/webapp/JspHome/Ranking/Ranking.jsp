<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="BeansHome.User.UserDAO" %>
<%@ page import="BeansHome.User.UserDTO" %>
<%@ page import="BeansHome.Ranking.RankingDAO" %>
<%@ page import="BeansHome.Ranking.RankingDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<% 
    request.setCharacterEncoding("UTF-8");
    
    // DAO 객체 생성
    UserDAO userDAO = new UserDAO();
    RankingDAO rankingDAO = new RankingDAO();
    
    // 임시로 userId=1인 사용자 정보 가져오기 (나중에 세션에서 가져와야 함)
    UserDTO currentUser = userDAO.getUserById(1);
    
    // 랭킹 타입 (기본값: points)
    String rankingType = request.getParameter("type");
    if (rankingType == null) rankingType = "points";
    
    // 랭킹 목록 조회 (상위 10명)
    List<RankingDTO> rankings = rankingDAO.getRankings(rankingType, 10);
    
    // 현재 사용자의 랭킹 정보 조회
    RankingDTO userRanking = rankingDAO.getUserRanking(currentUser.getUserId(), rankingType);

    // 목업 데이터 매니저 주석 처리
    // MockDataManager mockManager = MockDataManager.getInstance();
    // UserDTO currentUser = mockManager.getCurrentUser();
    // List<UserDTO> rankings = mockManager.getRankingList(rankingType, 10);
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
            <div class="ranking-tabs">
                <a href="?type=words" class="tab <%= rankingType.equals("words") ? "active" : "" %>">학습 단어</a>
                <a href="?type=points" class="tab <%= rankingType.equals("points") ? "active" : "" %>">누적 포인트</a>
                <a href="?type=dangos" class="tab <%= rankingType.equals("dangos") ? "active" : "" %>">당고 수집</a>
            </div>
        </section>

        <section class="top-rankers">
            <% for (int i = 0; i < Math.min(3, rankings.size()); i++) { 
                RankingDTO user = rankings.get(i);
                String rankClass = i == 0 ? "first" : i == 1 ? "second" : "third";
            %>
                <div class="top-rank <%= rankClass %>">
                    <% if (i == 0) { %>
                        <span class="medal">🥇</span>
                    <% } else if (i == 1) { %>
                        <span class="medal">🥈</span>
                    <% } else if (i == 2) { %>
                        <span class="medal">🥉</span>
                    <% } %>
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/<%= user.getProfileImage() %>" 
                         alt="<%= user.getNickname() %>님의 프로필" class="profile-image">
                    <div class="user-name"><%= user.getNickname() %></div>
                    <div class="user-intro"><%= user.getIntro() %></div>
                    <div class="score">
                        <%= user.getScore() %>
                        <%= getScoreUnit(rankingType) %>
                    </div>
                </div>
            <% } %>
        </section>

        <section class="ranking-list">
            <div class="my-rank">
                <div class="rank-info">
                    <span class="rank-number"><%= userRanking.getRank() %></span>
                    <span class="rank-total">/ <%= rankings.size() %></span>
                </div>
                <div class="user-info">
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/<%= currentUser.getProfileImage() %>" 
                         alt="<%= currentUser.getNickname() %>님의 프로필" class="profile-image">
                    <span class="nickname"><%= currentUser.getNickname() %></span>
                </div>
                <div class="score">
                    <%= userRanking.getScore() %>
                    <%= getScoreUnit(rankingType) %>
                </div>
            </div>

            <div class="ranking-table">
                <% for (int i = 0; i < rankings.size(); i++) { 
                    RankingDTO user = rankings.get(i);
                %>
                    <div class="rank-row <%= user.getUserId() == currentUser.getUserId() ? "current-user" : "" %>">
                        <div class="rank-number"><%= i + 1 %></div>
                        <div class="user-info">
                            <img src="${pageContext.request.contextPath}/JspHome/Main/images/<%= user.getProfileImage() %>" 
                                 alt="<%= user.getNickname() %>님의 프로필" class="profile-image">
                            <div class="user-details">
                                <div class="nickname"><%= user.getNickname() %></div>
                                <div class="intro"><%= user.getIntro() %></div>
                            </div>
                        </div>
                        <div class="score">
                            <%= user.getScore() %>
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
        switch (type) {
            case "words": return user.getQuizRight();
            case "dangos": return user.getDangos();
            default: return user.getPoint();
        }
    }
    
    // 랭킹 타입에 따른 단위 반환
    private String getScoreUnit(String type) {
        switch (type) {
            case "words": return "개";
            case "points": return "P";
            case "dangos": return "개";
            default: return "";
        }
    }
%>
