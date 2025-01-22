<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="BeansHome.User.UserDAO" %>
<%@ page import="BeansHome.User.UserDTO" %>
<%@ page import="BeansHome.Ranking.RankingDAO" %>
<%@ page import="BeansHome.Ranking.RankingDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="BeansHome.Dango.DangoDAO" %>
<%@ page import="BeansHome.Dango.DangoDTO" %>
<%@ page import="java.util.ArrayList" %>

<%
    request.setCharacterEncoding("UTF-8");

    // DAO 객체 생성
    UserDAO userDAO = new UserDAO();
    RankingDAO rankingDAO = new RankingDAO();
    DangoDAO dangoDAO = new DangoDAO();
    DangoDTO userProfile = new DangoDTO();
    DangoDTO tempProfile = null;
    ArrayList<DangoDTO> dangoProfiles = new ArrayList<>();

    // 세션에서 현재 사용자 정보 가져오기
    Integer userId = (Integer) session.getAttribute("userId");
    UserDTO currentUser = null;
    if (userId != null) {
        currentUser = userDAO.getUserById(userId);
    }

    // 랭킹 목록과 현재 사용자의 랭킹 정보 조회
    List<RankingDTO> rankings = rankingDAO.getRankings();
    RankingDTO userRanking = null;
    if (currentUser != null) {
        userRanking = rankingDAO.getUserRanking(currentUser.getUserId());
    }
    dangoDAO.ReadProfileDango(userId, userProfile);

    // 디버깅 출력 추가
    System.out.println("Rankings size: " + (rankings != null ? rankings.size() : "null"));
    System.out.println("User ranking: " + (userRanking != null ? userRanking.getRank() : "null"));

    if (rankings != null) {
        for (RankingDTO rank : rankings) {
            tempProfile = new DangoDTO();
            dangoDAO.ReadProfileDango(rank.getUserId(), tempProfile);
            System.out.println("Rank: " + rank.getRank() +
                    ", User: " + rank.getNickname() +
                    ", Point: " + rank.getPoint() +
                    ", DangoId: " + tempProfile.getDangoId() +
                    ", LocationImg: " + tempProfile.getLocationImg());
            dangoProfiles.add(tempProfile);
        }
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="../images/favicon-96x96.png" type="image/png" sizes="96x96">
    <title>당고링고</title>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-jp.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Ranking/css/ranking.css">
</head>
<body>
<header>
    <jsp:include page="../Common/Navbar.jsp" />
</header>

<main class="ranking-container">
    <section class="ranking-header">
        <h1>포인트 랭킹</h1>
    </section>

    <section class="top-rankers">
        <% for (int i = 0; i < Math.min(3, rankings.size()); i++) {
            RankingDTO user = rankings.get(i);
            DangoDTO profileUser = dangoProfiles.get(i);
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
            <img src="<%= profileUser.getLocationImg() %>"
                 alt="<%= user.getNickname() %>님의 프로필" class="profile-image">
            <div class="user-name"><%= user.getNickname() %></div>
            <div class="user-intro"><%= user.getIntro() %></div>
            <div class="point"><%= user.getPoint() %>P</div>
        </div>
        <% } %>
    </section>

    <section class="ranking-list">
        <% if (currentUser != null && userRanking != null) { %>
        <div class="my-rank">
            <div class="rank-info">
                <span class="rank-number"><%= userRanking.getRank() %></span>
                <span class="rank-total">위</span>
            </div>
            <div class="user-info">
                <img src="<%= userProfile.getLocationImg() %>"
                     alt="<%= currentUser.getNickname() %>님의 프로필" class="profile-image">
                <span class="nickname"><%= currentUser.getNickname() %></span>
            </div>
            <div class="point"><%= userRanking.getPoint() %>P</div>
        </div>
        <% } %>

        <div class="ranking-table">
            <% for (int i = 0; i < 10; i++) {
                RankingDTO user = rankings.get(i);
                DangoDTO profileUser = dangoProfiles.get(i);
            %>
            <div class="rank-row <%= user.getUserId() == currentUser.getUserId() ? "current-user" : "" %>">
                <div class="rank-number"><%= user.getRank() %></div>
                <div class="user-info">
                    <img src="<%= profileUser.getLocationImg() %>"
                         alt="<%= user.getNickname() %>님의 프로필" class="profile-image">
                    <div class="user-details">
                        <div class="nickname"><%= user.getNickname() %></div>
                        <div class="intro"><%= user.getIntro() %></div>
                    </div>
                </div>
                <div class="point"><%= user.getPoint() %>P</div>
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