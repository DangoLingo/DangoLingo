<%@page import="BeansHome.Dango.DangoDAO"%>
<%@page import="BeansHome.Dango.DangoDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.naming.java.javaURLContextFactory"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Dango/css/dango.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Dango/css/modal.css">
    <%----------------------------------------------------------------------
    [HTML Page - 자바스크립트 구현 영역 (상단)]
    [외부 자바스크립트 연결 (각각) : <script type="text/javascript" src="Hello.js"></script>]
    --------------------------------------------------------------------------%>
    <script type="text/javascript">
        // -----------------------------------------------------------------
        // [사용자 함수 및 로직 구현]
        // -----------------------------------------------------------------

        // -----------------------------------------------------------------
        // [브라우저 모달 창 함수 및 로직 구현 - 필수]
        // -----------------------------------------------------------------
        function ShowModalWindow(ModalSrc)
        {
            let divModalParent = document.getElementById("divModalParent");	// 모달 창 아래 부모
            let divModalFrame  = document.getElementById("divModalFrame");	// 모달 창 프레임
            let ifModalWindow  = document.getElementById("ifModalWindow");	// 모달 창
            let btnClose = document.getElementById("btnClose");				// 모달 창 내부 닫기 버튼

            // 모달 창 아래 메인 배경 흐리게 처리(브라우저에서 속도저하 발생할 수 있음)
            // divModalParent.classList.add("Modal-Parent-Background");

            // 모달 창 프레임 열기
            divModalFrame.style.display = "block";

            // 모달 창 src(소스경로) 연결
            ifModalWindow.src = ModalSrc;

            // 모달 창 내부 닫기 버튼 이벤트 핸들러
            btnClose.onclick = HideModalWindow;
        }
        function HideModalWindow()
        {
            // 모달 창 프레임 닫기
            divModalFrame.style.display = "none";
            location.reload(true);
        }
        // -----------------------------------------------------------------
    </script>
    <script type="text/javascript" src="JS/Basic.js"></script>
    <script src="${pageContext.request.contextPath}/JspHome/Dango/js/modal.js"></script>
</head>
<%--------------------------------------------------------------------------
[JSP 전역 변수/함수 선언 영역 - 선언문 영역]
   - this 로 접근 가능 : 같은 페이지가 여러번 갱신 되더라도 변수/함수 유지 됨
   - 즉 현재 페이지가 여러번 갱신 되는 경우 선언문은 한번만 실행 됨
------------------------------------------------------------------------------%>
<%!
    // ---------------------------------------------------------------------
    // [JSP 전역 변수/함수 선언]
    // ---------------------------------------------------------------------
    // Navbar.jsp에서 이미 선언된 dangoDAO 사용
    // ---------------------------------------------------------------------
%>
<body class="has-navbar">
<%@ include file="../Common/Navbar.jsp"%>
<%
    // ---------------------------------------------------------------------
    // [JSP 지역 변수 선언 및 초기화]
    // ---------------------------------------------------------------------
    Boolean bContinue = false;
    Integer userDangoCount = 0;
    Integer todalDangoCount = 0;
    String sRarityName = null;
    String sRarityColor = null;
    String sLockState = null;
    Integer nUserId = (Integer)session.getAttribute("userId");
    
    // 프로필 당고 설정 처리
    String setProfile = request.getParameter("setProfile");
    if (setProfile != null && isLoggedIn) {
        int dangoId = Integer.parseInt(setProfile);
        if (dangoDAO.UpdateProfileDango(nUserId, dangoId)) {
            response.sendRedirect("Dango.jsp");
            return;
        }
    }

    // 첫 번째 쿼리 실행 - 카운트 계산
    if (dangoDAO.ReadBoardList(nUserId)) {
        if (dangoDAO.DBMgr != null && dangoDAO.DBMgr.Rs != null) {
            while (dangoDAO.DBMgr.Rs.next()) {
                todalDangoCount++;
                if (dangoDAO.DBMgr.Rs.getInt("LOCKSTATE") != -1) {
                    userDangoCount++;
                }
            }
        }
    }

    // 두 번째 쿼리 실행 - 이미지 표시용
    bContinue = false;
    if (dangoDAO.ReadBoardList(nUserId)) {
        if (dangoDAO.DBMgr != null && dangoDAO.DBMgr.Rs != null) {
            bContinue = true;
        }
    }
%>

<script type="text/javascript">
    function setProfileDango(dangoId) {
        if (confirm('이 당고를 프로필로 설정하시겠습니까?')) {
            location.href = 'Dango.jsp?setProfile=' + dangoId;
        }
    }
</script>

<main class="main-container">
    <section class="progress-section">
        <h2>당고 도감</h2>
        <p><%=userDangoCount %> / <%=todalDangoCount %></p>
        <button class="modal_btn" type="button" onclick="ShowModalWindow('Dango_Pick.jsp')">뽑기</button>
    </section>

    <div class="grid-container">
        <%
            while (bContinue && dangoDAO.DBMgr.Rs.next()) {
                // 등급에 따른 표시 설정
                switch (dangoDAO.DBMgr.Rs.getString("RARITY")) {
                    case "U":
                        sRarityName = "UNIQUE";
                        sRarityColor = "rarity_unique";
                        break;
                    case "R":
                        sRarityName = "RARE";
                        sRarityColor = "rarity_rare";
                        break;
                    case "C":
                        sRarityName = "COMMON";
                        sRarityColor = "rarity_common";
                        break;
                }

                // 잠금 상태 설정
                sLockState = (dangoDAO.DBMgr.Rs.getInt("LOCKSTATE") == -1) ? "locked" : "";
                int currentDangoId = dangoDAO.DBMgr.Rs.getInt("DANGO_ID");
                boolean isProfileDango = profileDango != null && 
                                      profileDango.getDangoId() == currentDangoId;
        %>
        <div class="grid-item <%=dangoDAO.DBMgr.Rs.getInt("LOCKSTATE") == -1 ? "" : "clickable"%>" 
             <%=dangoDAO.DBMgr.Rs.getInt("LOCKSTATE") == -1 ? "" : 
               "onclick=\"setProfileDango(" + currentDangoId + ")\""%>>
            <div class="image-wrapper <%=isProfileDango ? "profile-dango" : ""%>">
                <img class="grid-image <%=sLockState%>"
                     alt="<%=dangoDAO.DBMgr.Rs.getString("DANGO_NAME")%>"
                     src="<%=dangoDAO.DBMgr.Rs.getString("LOCATION_IMG")%>">
            </div>
            <a class="rarity <%=sRarityColor %>"><%=sRarityName%></a>
            <a class="dangoname"><%=dangoDAO.DBMgr.Rs.getString("DANGO_NAME")%></a>
        </div>
        <%
            }
        %>
    </div>
</main>

<!-- 모달 -->
<div class="Modal-Frame" id="divModalFrame">
    <div class="Modal-Content">
        <span class="Modal-Close" id="btnClose">&times;&nbsp;</span>
        <h2>당고뽑기</h2>
        <iframe class="Modal-Window" id="ifModalWindow"></iframe>
    </div>
</div>

<%@ include file="../Common/Footer.jsp"%>
</body>
</html>