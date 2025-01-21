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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 <link rel="icon" href="../images/favicon-96x96.png" type="image/png" sizes="96x96">
<title>당고링고</title>
<%----------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	--------------------------------------------------------------------------%>
<link rel="stylesheet" href="../Quiz/css/Quiz_Play.css?ver=220610"/>
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
	<main>
		<%----------------------------------------------------------------------
		[ 1) 상단 진행 상황 ]
		--------------------------------------------------------------------------%>
		<div class="progress">
		<% 
	        // 현재 단어장명과 퀴즈 개수 받아오기
	        String quizCount = request.getParameter("quizCount");
	        String words_id = request.getParameter("words_id");
	        String quizType = request.getParameter("quizType");
		%>
			<!-- hidden input 필드로 값 설정 -->
			<input type="hidden" id="quizCount" value="<%= quizCount %>">
			<input type="hidden" id="quizType" value="<%= quizType %>">
			<input type="hidden" id="words_id" value="<%= words_id %>">
					
			<span><span class="currentIndex">1</span>/<%=quizCount %></span> 
			<span class="time-container"> 
				<span id="timePassed">0분 0초</span> 
				<svg class="exit" xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 40 40" fill="none">
	   			    <circle cx="20" cy="20" r="20" fill="#324931" />
	   			    <svg xmlns="http://www.w3.org/2000/svg" x="8" y="8" width="24" height="24" viewBox="0 0 24 24" fill="none">
		     		    <g clip-path="url(#clip0_405_1299)">
		        			<path d="M10.09 15.59L11.5 17L16.5 12L11.5 7L10.09 8.41L12.67 11H3V13H12.67L10.09 15.59ZM19 3H5C3.89 3 3 3.9 3 5V9H5V5H19V19H5V15H3V19C3 20.1 3.89 21 5 21H19C20.1 21 21 20.1 21 19V5C21 3.9 20.1 3 19 3Z" fill="white" />
		     			</g>
	    			</svg>
 			     </svg>
			</span>
		</div>
		<%----------------------------------------------------------------------
		[ 2) 문제 제시 ]
		--------------------------------------------------------------------------%>
		<div class="word-display"></div>
		<%----------------------------------------------------------------------
		[ 3) 단어 선택 버튼 ]
		--------------------------------------------------------------------------%>
		<div class="buttons">
			<button class="button" id="btnCorrectAnswer"></button>
			<button class="button btnWrongAnswer" id="btn2"></button>
			<button class="button btnWrongAnswer" id="btn3"></button>
			<button class="button btnWrongAnswer" id="btn4"></button>
		</div>
	</main>
		 <%@ include file="../Common/Footer.jsp"%>
	
	<!-- 반투명 레이어 - 정답 오답 체크시 표시용 -->
    
	<%----------------------------------------------------------------------
	[HTML Page - END]
	--------------------------------------------------------------------------%>
	<%----------------------------------------------------------------------
	[HTML Page - 자바스크립트 구현 영역 (하단)]
	[외부 자바스크립트 연결 (각각) : <script type="text/javascript" src="Hello.js"></script>]
	--------------------------------------------------------------------------%>
	<script  src="../Quiz/js/Quiz_Play.js" type="text/javascript">
</script>
	<%------------------------------------------------------------------
	[JSP 페이지에서 바로 이동(바이패스)]
	----------------------------------------------------------------------%>
	<%------------------------------------------------------------------
	바이패스 방법1	: JSP forward 액션을 사용 한 페이지 이동
				:-------------------------------------------------------
				: page	- 이동 할 새로운 페이지 주소
				: name	- page 쪽에 전달 할 파라미터 명칭
				: value	- page 쪽에 전달 할 파라미터 데이터
				:		- page 쪽에서 request.getParameter("name1")로 읽음
				:-------------------------------------------------------
				: 이 방법은 기다리지 않고 바로 이동하기 때문에 현재 화면이 표시되지 않음
				: 브라우저 Url 주소는 현재 페이지로 유지 됨
	--------------------------------------------------------------------
	<jsp:forward page="Hello.jsp">
		<jsp:param name="name1" value='value1'/>
		<jsp:param name="name2" value='value2'/>
	</jsp:forward>
	--%>
	<%
	// -----------------------------------------------------------------
	//	바이패스 방법2	: RequestDispatcher을 사용 한 페이지 이동
	//				:---------------------------------------------------
	//				: sUrl	- 이동 할 새로운 페이지 주소
	//				:		- sUrl 페이지 주소에 GET 파라미터 전달 가능
	//				:		- sUrl 페이지가 갱신됨 즉,
	//				:		- sUrl 페이지 주소에 GET 파라미터 유무에 상관없이
	//				:		- sUrl 페이지 쪽에서 request.getParameter() 사용가능
	//				:-------------------------------------------------------
	//				: 이 방법은 기다리지 않고 바로 이동하기 때문에 현재 화면이 표시되지 않음
	//				: 브라우저 Url 주소는 현재 페이지로 유지 됨
	// -----------------------------------------------------------------
	// String sUrl = "Hello.jsp?name1=value1&name2=value2";
	//
	// RequestDispatcher dispatcher = request.getRequestDispatcher(sUrl);
	// dispatcher.forward(request, response);
	// -----------------------------------------------------------------
	//	바이패스 방법3	: response.sendRedirect을 사용 한 페이지 이동
	//				:---------------------------------------------------
	//				: sUrl	- 이동 할 새로운 페이지 주소
	//				:		- sUrl 페이지에 GET 파라미터만 전달 가능
	//				:		- sUrl 페이지 갱신 없음 즉,
	//				:		- sUrl 페이지 주소에 GET 파라미터 있는 경우만
	//				:		- sUrl 페이지 쪽에서 request.getParameter() 사용가능
	//				:-------------------------------------------------------
	//				: 이 방법은 기다리지 않고 바로 이동하기 때문에 현재 화면이 표시되지 않음
	//				: 브라우저의 Url 주소는 sUrl 페이지로 변경 됨
	// -----------------------------------------------------------------
	//String sUrl = "Hello.jsp?name1=value1&name2=value2";
	//
	//response.sendRedirect(sUrl);
	// -----------------------------------------------------------------
	%>
</body>
</html>
