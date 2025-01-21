<%@ page import="BeansHome.Dango.DangoDAO" %>
<%@ page import="BeansHome.Ranking.RankingDTO" %>
<%@ page import="BeansHome.Dango.DangoDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    DangoDAO dangoDAO = new DangoDAO();
    DangoDTO profileDango = new DangoDTO();
    String userNickname = (String) session.getAttribute("userNickname");
    boolean isLoggedIn = userNickname != null;
    if (isLoggedIn) {
        Integer userId = (Integer) session.getAttribute("userId");
        dangoDAO.ReadProfileDango(userId, profileDango);
    }
%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Common/css/navbar.css">

<div class="header">
    <div class="header-content">
        <div class="header-left">
            <button class="hamburger" id="hamburgerBtn" aria-label="메뉴 열기">
                <span></span>
                <span></span>
                <span></span>
            </button>
            <a href="${pageContext.request.contextPath}/JspHome/Main/Main.jsp" class="logo-link">
                <div class="logo">당고링고</div>
            </a>
            <% if (isLoggedIn) { %>
                <nav class="nav-menu" id="navMenu">
                    <a href="${pageContext.request.contextPath}/JspHome/Dango/Dango.jsp" class="nav-item">당고</a>
                    <a href="${pageContext.request.contextPath}/JspHome/Words/Words.jsp" class="nav-item">단어장</a>
                    <a href="${pageContext.request.contextPath}/JspHome/Ranking/Ranking.jsp" class="nav-item">랭킹</a>
                </nav>
            <% } %>
        </div>
        <div class="auth-buttons">
            <% if (!isLoggedIn) { %>
                <button class="auth-button">로그인</button>
                <button class="auth-button">회원가입</button>
            <% } else { %>
                <div class="profile-menu">
                    <img src="<%= profileDango.getLocationImg() %>" alt="프로필" onClick="location.href='${pageContext.request.contextPath}/JspHome/User/MyPage.jsp'" class="profile-image">
                    <button class="auth-button" onclick="handleLogout()">로그아웃</button>
                </div>
            <% } %>
        </div>
    </div>
</div>

<script>
    document.getElementById('hamburgerBtn').addEventListener('click', function() {
        document.getElementById('navMenu').classList.toggle('show');
        this.classList.toggle('active');
    });

    function handleLogout() {
        console.log('로그아웃 버튼 클릭됨');
        if (confirm('로그아웃 하시겠습니까?')) {
            console.log('로그아웃 확인');
            window.location.href = '${pageContext.request.contextPath}/JspHome/Main/Main.jsp?action=logout';
            console.log('로그아웃 페이지로 이동');
        } else {
            console.log('로그아웃 취소');
        }
    }
</script> 