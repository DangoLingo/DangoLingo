<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.naming.java.javaURLContextFactory"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%----------------------------------------------------------------------
	[HTML Page - 헤드 영역]
	--------------------------------------------------------------------------%>
<%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-ompatible" content="IE=edge,chrome=1" />
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="pragma" content="no-cache" />
<meta name="Description" content="검색 엔진을 위해 웹 페이지에 대한 설명을 명시" />
<meta name="keywords" content="검색 엔진을 위해 웹 페이지와 관련된 키워드 목록을 콤마로 구분해서 명시" />
<meta name="Author" content="문서의 저자를 명시" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>당고링고</title>
<%----------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	--------------------------------------------------------------------------%>
<link rel="stylesheet" href="../Quiz/css/Quiz_Play.css"/>
<%----------------------------------------------------------------------
	[HTML Page - 자바스크립트 구현 영역 (상단)]
	[외부 자바스크립트 연결 (각각) : <script type="text/javascript" src="Hello.js"></script>]
	--------------------------------------------------------------------------%>
<script type="text/javascript">
	// -----------------------------------------------------------------
	// [브라우저 갱신 완료 시 호출 할 이벤트 핸들러 연결 - 필수]
	// -----------------------------------------------------------------
	// window.onload = function () { DocumentInit('페이지가 모두 로드되었습니다!'); }
	// -----------------------------------------------------------------
	// [브라우저 갱신 완료 및 초기화 구현 함수 - 필수]
	// -----------------------------------------------------------------
	// 브라우저 갱신 완료 까지 기다리는 함수 - 필수
	// 일반적인 방식 : setTimeout(()=>alert('페이지가 모두 로드되었습니다!'), 50);
	function DocumentInit(Msg) {
		requestAnimationFrame(function() {
			requestAnimationFrame(function() {
				alert(Msg);
			});
		});
	}
	// -----------------------------------------------------------------
	// [사용자 함수 및 로직 구현]
	// -----------------------------------------------------------------

	// -----------------------------------------------------------------
</script>
<script type="text/javascript" src="JS/Basic.js"></script>
</head>
<%--------------------------------------------------------------------------
[JSP 전역 변수/함수 선언 영역 - 선언문 영역]
	- this 로 접근 가능 : 같은 페이지가 여러번 갱신 되더라도 변수/함수 유지 됨
	- 즉 현재 페이지가 여러번 갱신 되는 경우 선언문은 한번만 실행 됨
------------------------------------------------------------------------------%>
<%!// ---------------------------------------------------------------------
	// [JSP 전역 변수/함수 선언]
	// ---------------------------------------------------------------------

	// ---------------------------------------------------------------------%>
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
String Date = "20231231 121212";

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
<body>
    <%@ include file="../Common/Navbar.jsp"%>
    <div class="container">
        <main class="main-container">
            <div class="quiz-box">
                <div class="progress">
                    <span>13/50</span> 
                    <span class="time-container"> 
                        <span id="timePassed">30분 12초</span> 
                        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 40 40" fill="none" 
                             onclick="location.href='${pageContext.request.contextPath}/JspHome/Quiz/Quiz_Final.jsp'" 
                             style="cursor: pointer;">
                            <circle cx="20" cy="20" r="20" fill="#324931" />
                            <svg xmlns="http://www.w3.org/2000/svg" x="8" y="8" width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <g clip-path="url(#clip0_405_1299)">
                                    <path d="M10.09 15.59L11.5 17L16.5 12L11.5 7L10.09 8.41L12.67 11H3V13H12.67L10.09 15.59ZM19 3H5C3.89 3 3 3.9 3 5V9H5V5H19V19H5V15H3V19C3 20.1 3.89 21 5 21H19C20.1 21 21 20.1 21 19V5C21 3.9 20.1 3 19 3Z" fill="white" />
                                </g>
                            </svg>
                        </svg>
                    </span>
                </div>
                <div class="word-display">食べる</div>
                <div class="buttons">
                    <button class="button">잠자다</button>
                    <button class="button">먹다</button>
                    <button class="button">달리다</button>
                    <button class="button">훔치다</button>
                </div>
            </div>
        </main>
    </div>
    <%@ include file="../Common/Footer.jsp"%>
</body>
</html>
