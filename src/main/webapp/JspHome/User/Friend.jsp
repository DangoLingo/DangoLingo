<%@ page import="BeansHome.User.UserDTO" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="BeansHome.Study.StudyDAO" %>
<%@ page import="BeansHome.Friend.FriendDAO" %>
<%@ page import="BeansHome.Study.StudyDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.logging.Level" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    // 로거 먼저 생성
    Logger logger = Logger.getLogger("Main_SignIn.jsp");
    logger.setLevel(Level.ALL);

    FriendDAO friendDAO = new FriendDAO();
    UserDTO currentUser = (UserDTO) session.getAttribute("user");
    ArrayList<UserDTO> friends = new ArrayList<>();
    try {
        friendDAO.readFriendList(currentUser.getUserId(), friends);
        session.setAttribute("user", currentUser);
    } catch (Exception e) {
        throw new RuntimeException(e);
    }
%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/User/css/Friend.css">
<%----------------------------------------------------------------------
[HTML Component - 친구 목록 디자인 영역]
--------------------------------------------------------------------------%>
<%------------------------------------------------------------------
    스트릭 영역
----------------------------------------------------------------------%>
<section>
    <div class="friend-list">
        <% for (UserDTO user : friends) { %>
        <div class="friend-card">
            <img src="../images/dango-profile-1.png" alt="친구 프로필">
            <div class="friend-info">
                <h3><%= user.getNickname() %></h3>
                <p><%= user.getIntro() %></p>
                <p><%= user.getPoint() %></p>
                <p>최근 학습한 날짜 : <fmt:formatDate value="<%= user.getStudyDate() %>" pattern="yyyy년 MM월 dd일" /></p>
            </div>
            <button class="delete-friend" onclick="deleteFriend(this)">×</button>
        </div>
        <% } %>
    </div>
</section>
<%----------------------------------------------------------------------
[HTML Component - END]
--------------------------------------------------------------------------%>
<%----------------------------------------------------------------------
[HTML Page - 자바스크립트 구현 영역 (하단)]
[외부 자바스크립트 연결 (각각) : <script type="text/javascript" src="Hello.js"></script>]
--------------------------------------------------------------------------%>
<script>
    function deleteFriend(button) {
        if (confirm('정말로 이 친구를 삭제하시겠습니까?')) {
            button.closest('.friend-card').remove();
        }
    }
</script>