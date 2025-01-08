<%--
  Created by IntelliJ IDEA.
  User: ha110
  Date: 2025-01-03
  Time: 오후 1:04
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.naming.java.javaURLContextFactory"%>
<%@ page import="java.text.SimpleDateFormat" %>
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
    <title>당고링고</title>
    <%----------------------------------------------------------------------
    [HTML Page - 스타일쉬트 구현 영역]
    [외부 스타일쉬트 연결 : <link rel="stylesheet" href="Hello.css?version=1.1"/>]
    --------------------------------------------------------------------------%>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-jp.css" />
    <link rel="stylesheet" href="CSS/Basic.css?version=1.1"/>
    <link rel="stylesheet" href="./CSS/Words.css">
    <%----------------------------------------------------------------------
    [HTML Page - 자바스크립트 구현 영역 (상단)]
    [외부 자바스크립트 연결 (각각) : <script type="text/javascript" src="Hello.js"></script>]
    --------------------------------------------------------------------------%>

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

    // ---------------------------------------------------------------------
%>
<%--------------------------------------------------------------------------
[JSP 지역 변수 선언 및 로직 구현 영역 - 스크립트릿 영역]
	- this 로 접근 불가 : 같은 페이지가 여러번 갱신되면 변수/함수 유지 안 됨
	- 즉 현재 페이지가 여러번 갱신 될 때마다 스크립트릿 영역이 다시 실행되어 모두 초기화 됨
------------------------------------------------------------------------------%>
<%
    // ---------------------------------------------------------------------
    // [JSP 지역 변수 선언 : 웹 페이지 get/post 파라미터]
    // ---------------------------------------------------------------------
    String txtData1 = "";
    String txtData2 = "";
    // ---------------------------------------------------------------------
    // [JSP 지역 변수 선언 : 데이터베이스 파라미터]
    // ---------------------------------------------------------------------

    // ---------------------------------------------------------------------
    // [JSP 지역 변수 선언 : 일반 변수]
    // ---------------------------------------------------------------------

    // ---------------------------------------------------------------------
    // [웹 페이지 get/post 파라미터 조건 필터링]
    // ---------------------------------------------------------------------

    // ---------------------------------------------------------------------
    // [일반 변수 조건 필터링]
    // ---------------------------------------------------------------------
    if (request.getParameter("txtData1") != null)
        txtData1 = request.getParameter("txtData1");

    if (request.getParameter("txtData2") != null)
        txtData2 = request.getParameter("txtData2");

    // session & application 변수 등록
    session.setAttribute("HelloSession", "Session-OK!");
    application.setAttribute("HelloApplication", "Application-OK!");

    // 현재 날짜 / 시간 구하기
    SimpleDateFormat Sdf = null;
    String Date  = "20231231 121212";

    Date CurDate = new Date();
    String Date1 = String.format("%tF %tT 입니다.", CurDate, CurDate);

    Sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분 ss초 입니다.");
    String Date2 = Sdf.format(CurDate);

    Sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss 입니다.");
    String Date3 = Sdf.format(new SimpleDateFormat("yyyyMMdd hhmmss").parse(Date));
    // ---------------------------------------------------------------------
%>
<%--------------------------------------------------------------------------
[Beans/DTO 선언 및 속성 지정 영역]
------------------------------------------------------------------------------%>
<%----------------------------------------------------------------------
Beans 객체 사용 선언	: id	- 임의의 이름 사용 가능(클래스 명 권장)
                    : class	- Beans 클래스 명
                    : scope	- Beans 사용 기간을 request 단위로 지정 Hello.HelloDTO
------------------------------------------------------------------------
<jsp:useBean id="HelloDTO" class="Hello.HelloDTO" scope="request"></jsp:useBean>
--%>
<%----------------------------------------------------------------------
Beans 속성 지정 방법1	: Beans Property에 * 사용
                    :---------------------------------------------------
                    : name		- <jsp:useBean>의 id
                    : property	- HTML 태그 입력양식 객체 전체
                    :---------------------------------------------------
주의사항				: HTML 태그의 name 속성 값은 소문자로 시작!
                    : HTML 태그에서 데이터 입력 없는 경우 null 입력 됨!
------------------------------------------------------------------------
<jsp:setProperty name="HelloDTO" property="*"/>
--%>
<%----------------------------------------------------------------------
Beans 속성 지정 방법2	: Beans Property에 HTML 태그 name 사용
                    :---------------------------------------------------
                    : name		- <jsp:useBean>의 id
                    : property	- HTML 태그 입력양식 객체 name
                    :---------------------------------------------------
주의사항				: HTML 태그의 name 속성 값은 소문자로 시작!
                    : HTML 태그에서 데이터 입력 없는 경우 null 입력 됨!
                    : Property를 각각 지정 해야 함!
------------------------------------------------------------------------
<jsp:setProperty name="HelloDTO" property="data1"/>
<jsp:setProperty name="HelloDTO" property="data2"/>
--%>
<%----------------------------------------------------------------------
Beans 속성 지정 방법3	: Beans 메서드 직접 호출
                    :---------------------------------------------------
                    : Beans 메서드를 각각 직접 호출 해야함!
--------------------------------------------------------------------------%>
<%
    // HelloDTO.setData1(request.getParameter("data1"));
%>
<%--------------------------------------------------------------------------
[Beans DTO 읽기 및 로직 구현 영역]
------------------------------------------------------------------------------%>
<%

%>
<body class="Body">
    <%----------------------------------------------------------------------
    [HTML Page - Header 영역]
    --------------------------------------------------------------------------%>
    <jsp:include page="../Common/Navbar.jsp" />
    <%----------------------------------------------------------------------
    [HTML Page - Main 디자인 영역]
    --------------------------------------------------------------------------%>
    <main>
        <%------------------------------------------------------------------
            단어장 급수 선택 카드 영역
        ----------------------------------------------------------------------%>
        <section class="nav-card">
            <header class="nav-card-header">
                <div class="nav-card-left">
                    <span class="nav-card-title">JLPT</span>
                    <div class="nav-dropdown">
                        <!-- DB 연동 후 수정 필요 -->
                        <button class="label">N5</button>
                        <ul class="option-list">
                            <li class="option-item">N1</li>
                            <li class="option-item">N2</li>
                            <li class="option-item">N3</li>
                            <li class="option-item">N4</li>
                            <li class="option-item">N5</li>
                        </ul>
                    </div>
                </div>
                <div class="nav-card-right">
                    <!-- DB 연동 후 수정 필요 -->
                    <time class="nav-card-date">최근 학습 날짜: 2024년 12월 25일</time>
                </div>
            </header>
        </section>
        <%------------------------------------------------------------------
            단어장 일자별 선택 카드 영역
        ----------------------------------------------------------------------%>
        <section class="day-cards">
            <!-- JSP 반복문을 활용해 Day 카드 출력 -->
            <% for (int i = 1; i <= 10; i++) {
                // 북마크 표시 조건 - DB 연동 후 수정 필요
                boolean isBookmarked = (i == 2);
            %>
            <article class="card">
                <% if (isBookmarked) { %>
                <div class="bookmark"></div>
                <% } %>
                <div class="card-title-container">
                    <% if (i < 10) { %>
                    <h2 class="card-title">Day 0<%= i %></h2>
                    <% } else { %>
                    <h2 class="card-title">Day <%= i %></h2>
                    <% } %>
                    <% if (isBookmarked) { %>
                    <p class="card-subtitle">최근 학습한 단어장</p>
                    <% } else { %>
                    <p style="visibility: hidden;" class="card-subtitle">최근 학습한 단어장</p>
                    <% } %>
                </div>
                <div class="progress-bar-container">
                    <!-- DB 연동 후 수정 필요 -->
                    <p class="progress-text">13/50</p>
                    <progress class="progress-bar" value="13" min="0" max="50">
                    </progress>
                </div>
                <div class="button-container">
                    <!-- 페이지 개발 완료 후 연동 필요 -->
                    <button class="button" type="button">퀴즈</button>
                    <button class="button" type="button">학습</button>
                </div>
            </article>
            <% } %>
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
<script type="text/javascript" src="./JS/Words.js"></script>
</body>
</html>