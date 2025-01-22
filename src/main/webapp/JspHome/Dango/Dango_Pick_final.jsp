<%@page import="BeansHome.Dango.DangoDAO"%>
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
    <title>JSP-Basic Page</title>
	<%----------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	--------------------------------------------------------------------------%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Dango/css/pick.css">
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
	public DangoDAO dangoDAO = new DangoDAO();
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
	
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 데이터베이스 파라미터]
	// ---------------------------------------------------------------------
	
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 일반 변수]
	// ---------------------------------------------------------------------
	Boolean bContinue		= false;			// 당고 검색 유무	
	Integer userId			= null;
	Integer deduction 		= null;
	Integer currentPoint    = null;
	Integer dangoId         = null;
	String  dangoName       = null;
	String  dangoImgPath    = null;
	// ---------------------------------------------------------------------
	// [웹 페이지 get/post 파라미터 조건 필터링]
	// ---------------------------------------------------------------------
	
	// ---------------------------------------------------------------------
	// [일반 변수 조건 필터링]
	// ---------------------------------------------------------------------
	userId    = (Integer) session.getAttribute("userId");
	deduction = 100;
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
	if (this.dangoDAO.UpdatePoint(userId, deduction) == true)
	{
		if (this.dangoDAO.DBMgr != null && this.dangoDAO.DBMgr.Rs != null)
		{
			bContinue = true;
		}
	}	
%>
<%
	while (bContinue == true && this.dangoDAO.DBMgr.Rs.next())
	{
		currentPoint = 	this.dangoDAO.DBMgr.Rs.getInt("POINT");
	}

	bContinue = false;
%>

<%
	if (this.dangoDAO.RandomImg() == true)
	{
		if (this.dangoDAO.DBMgr != null && this.dangoDAO.DBMgr.Rs != null)
		{
			bContinue = true;
		}
	}

%>
<%
	while (bContinue == true && this.dangoDAO.DBMgr.Rs.next())
	{
		dangoId = this.dangoDAO.DBMgr.Rs.getInt("DANGO_ID");
		dangoName = this.dangoDAO.DBMgr.Rs.getString("DANGO_NAME");
		dangoImgPath = this.dangoDAO.DBMgr.Rs.getString("LOCATION_IMG");
	}
	bContinue = false;
%>

<%
	if (this.dangoDAO.InsertDango(userId, dangoId) == true)
	{
		if (this.dangoDAO.DBMgr != null && this.dangoDAO.DBMgr.Rs != null)
		{
			bContinue = true;
		}
	}
	bContinue = false;
%>

<body class="Body">
	<div class="pick-container">
		<form name="form1" action="" method="post">
			<img alt="당고 뽑기 결과" src=<%=dangoImgPath %>>
			<span class="dangoname"><%=dangoName %></span>
			<p>보유포인트: <%=currentPoint %>pt</p>
			<button type="button" 
					onclick="location.href='Dango_Pick_final.jsp'" 
					<%=currentPoint < 100 ? "disabled" : ""%>>
				뽑기 (100pt 차감)
			</button>	
		</form>
	</div>
	<%----------------------------------------------------------------------
	[HTML Page - END]
	--------------------------------------------------------------------------%>
	<%----------------------------------------------------------------------
	[HTML Page - 자바스크립트 구현 영역 (하단)]
	[외부 자바스크립트 연결 (각각) : <script type="text/javascript" src="Hello.js"></script>]
	--------------------------------------------------------------------------%>
	<script type="text/javascript">
		// -----------------------------------------------------------------
		// [사용자 함수 및 로직 구현]
		// -----------------------------------------------------------------

		// -----------------------------------------------------------------
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
