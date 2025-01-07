<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userNickname = (String) session.getAttribute("userNickname");
    boolean isLoggedIn = userNickname != null;
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
            <a href="${pageContext.request.contextPath}/JspHome/Main/Basic.jsp" class="logo-link">
                <div class="logo">당고링고</div>
            </a>
            <% if (isLoggedIn) { %>
                <nav class="nav-menu" id="navMenu">
                    <a href="${pageContext.request.contextPath}/JspHome/Dango/Basic.jsp" class="nav-item">당고</a>
                    <a href="${pageContext.request.contextPath}/JspHome/Words/Basic.jsp" class="nav-item">단어장</a>
                    <a href="${pageContext.request.contextPath}/JspHome/Ranking/Basic.jsp" class="nav-item">랭킹</a>
                </nav>
            <% } %>
        </div>
        <div class="auth-buttons">
            <% if (!isLoggedIn) { %>
                <button class="auth-button">로그인</button>
                <button class="auth-button">회원가입</button>
            <% } else { %>
                <div class="profile-menu">
                    <img src="../Main/images/dango-profile.png" alt="프로필" class="profile-image">
                    <button class="auth-button">로그아웃</button>
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
</script> 