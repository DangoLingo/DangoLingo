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
   [외부 스타일쉬트 연결 : <link rel="stylesheet" href="Hello.css?version=1.1"/>]
   --------------------------------------------------------------------------%>
   <style type="text/css">
		/* -----------------------------------------------------------------
		         당고도감
		----------------------------------------------------------------- */
		
		
		body {
		    font-family: 'Pretendard JP', sans-serif;
		    display: flex;
		    height: 100%;
		    flex-direction: column;
		    min-height: 100vh;
		    background-color: #F6F7F5;
			margin: 0;
		}
		
		.progress-section {
		   margin-top: 84px;
		   width: 1060px;
		   height: 80px;
		   border-radius: 16px;
		   background-color: #fff;
		   margin: 84px auto 12px auto;
		   display: flex;   
		}
		
		
		
		.progress-section h2 {
		    width: 92px;
		   height: 25px;
		    font-size: 24px;
		    justify-content: center;
		    padding: 27.5px 15px 27.5px 32px;
		    margin: 0;
		}
		
		.progress-section p {
		    font-size: 20px;
		    height:20px;
		    width: 80px;
		    margin: 32px 15px 32px 0px;
		}
		
		.modal_btn {   
		    width: 60px;
		    height: 40px;
		    border-radius: 30px;
		    margin: 20px 32px 20px auto;
		    background-color: #324931;   
		    color: white;
		    text-align: center;
		    border: none;
		    cursor: pointer;
		}
		
		.grid-section {
		    display: flex;
		    justify-content: center;
		}
		
		.grid-container {
		    display: grid;
		    grid-template-columns: repeat(6, 1fr);
		    justify-content: center;
		    gap: 15px;
		    width: 1060px;
		}
		
		.grid-item {
		   width: 125px;
		   height: 150px;
		   border-radius: 16px;
		   gap: 16px;
		   justify-content: center;
		   text-align: center;
		   padding: 18px;
		   background-color: #fff;
		}
		
		.grid-image {
		   width: 100px;
		   height: 100px;
		   border-radius: 10000px;
		   object-fit:cover;
		   border: solid;
		   border-color: #E8E8E9;
		}
		
		.grid-image.locked {
		    filter: blur(5px);
		    -webkit-filter: blur(5px);   /* 잠금 상태 */
		}
		
		.dangoname{
		   font-size: 18px;
		}
		
		.rarity{
		   border-radius: 30px;
		   padding:0px 7px;
		   font-size: 12px;
		   color: #ffffff;
		}
		
		.rarity_unique{
		   background-color: #324931;
		}
		
		.rarity_rare{
		   background-color: #5C8B6C;
		}
		
		.rarity_common{
		   background-color: #9ECE9C;
		}
		
		/* -----------------------------------------------------------------
			Modal 창 스타일시트
		   ----------------------------------------------------------------- */
		.Modal-Frame {
			background-color: rgba(0,0,0,0.3);				/* 배경 흐릿하게 처리 */
			display: none;									/* 기본적으로 숨김 */
		    height: 100%;									/* 브라우저 전체 높이 */
			left: 0; top: 0;								/* 모달창 프레임 좌측, 상단 위치 */
			overflow: auto;									/* 모달창이 넘치면 내부에서 스크롤 */
			position: fixed;								/* 모달창 프레임을 고정 : 부모창 disabled */
			width: 100%;									/* 모달창 프레임을 브라우저 폭으로 */
			z-index: 1;										/* 모달창 프레임을 위로 */
		}
		
		.Modal-Content {
			background-color: #fefefe;						/* 모달창 배경색 */
			height: 500px;									/* 모달창 높이 */
			position: absolute;								/* 모달창 위치 속성 */
			top: 50%; left: 50%;							/* 모달창 상단, 좌측 위치 */
			transform: translate(-50%, -50%);				/* 모달창 x, y 만큼 이동 */
			width: 500px;									/* 모달창 넓이 */
			border-radius: 16px;							/* 모달창 모서리 */
			font-family: "Pretendard JP";
			text-align: center;
			justify-content: center;							
		}
		
		.Modal-Window {
			border: none;									/* 모달창 페이지(iframe) 테두리 */
			height: 100%;									/* 모달창 페이지(iframe) 높이를 Modal-Content 높이로 */
			width: 100%;									/* 모달창 페이지(iframe) 넓이를 Modal-Content 넓이로 */
		}
		
		.Modal-Close {
			color: #aaa;									/* 모달창 닫기 버튼 색상 */
		    float: right;									/* 모달창 닫기 버튼 위치 정렬을 오른쪽 으로 */
			font-size: 30px; font-weight: bold;				/* 모달창 닫기 버튼 폰트, 폰트두께 */
			margin: 16px 16px 0px 0px;
		}
		
		.Modal-Close:hover,
		.Modal-Close:focus {
			color: black;									/* 모달창 닫기 버튼 마우스 호버 색상 */
			cursor: pointer;								/* 모달창 닫기 버튼 마우스 호버 포인트 */
			text-decoration: none;							/* 모달창 닫기 버튼 텍스트 꾸미기 없음 */
		}
		      
		.Modal-Parent-Background {
			filter: blur(5px);								/* 모달 창 아래 부모 배경 흐리게 처리 */
		}
		
		.Modal-Content h2{
			font-family: "Pretendard JP";
			font-size: 28px;
			margin-left: 32px;
			margin-top: 48px;
		}
   </style>
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
   // 당고정보 검색용 DAO 객체
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
   Integer nUserId = null;
   // ---------------------------------------------------------------------
   // [JSP 지역 변수 선언 : 데이터베이스 파라미터]
   // ---------------------------------------------------------------------
   
   // ---------------------------------------------------------------------
   // [JSP 지역 변수 선언 : 일반 변수]
   // ---------------------------------------------------------------------
   Boolean bContinue		= false;			// 당고 검색 유무
   String sRarityName		= null;				// 등급명
   String sRarityColor		= null;				// 등급명 색상
   String sLockState		= null;				// 잠금상태
   Integer userDangoCount   = 0;
   Integer todalDangoCount  = 0;
   // ---------------------------------------------------------------------
   // [웹 페이지 get/post 파라미터 조건 필터링]
   // ---------------------------------------------------------------------
   
   // ---------------------------------------------------------------------
   // [일반 변수 조건 필터링]
   // ---------------------------------------------------------------------
   nUserId = (Integer) session.getAttribute("userId");// 세션값을 받아서 넣어줌
   // ---------------------------------------------------------------------
%>
<%--------------------------------------------------------------------------
[Beans DTO 읽기 및 로직 구현 영역]
------------------------------------------------------------------------------%>
<%
	
   // bJobProcess 작업처리 허용	
	// 당고정보 검색
	if (this.dangoDAO.ReadBoardList(nUserId) == true)
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
		todalDangoCount ++;
	
		if (this.dangoDAO.DBMgr.Rs.getInt("LOCKSTATE") != -1)	userDangoCount++;
	}
	bContinue = false;
%>


<%
   // bJobProcess 작업처리 허용	
	// 당고정보 검색
	if (this.dangoDAO.ReadBoardList(nUserId) == true)
	{
		if (this.dangoDAO.DBMgr != null && this.dangoDAO.DBMgr.Rs != null)
		{
			bContinue = true;
		}
	}
%>
<body class="Body">
	<%----------------------------------------------------------------------
	[HTML Page - FORM 디자인 영역]
	--------------------------------------------------------------------------%>
	
	<%------------------------------------------------------------------
		네비게이션 바
	----------------------------------------------------------------------%>
	<%@ include file="../Common/Navbar.jsp"%>
	<%------------------------------------------------------------------
	      당고 도감 제목
	   ----------------------------------------------------------------------%>
	<form name="form1" action="" method="post">
		<section class="progress-section">
				<h2>당고 도감</h2>
			<p><%=userDangoCount %> / <%=todalDangoCount %> </p>
			<button class="modal_btn" type="button" onclick="ShowModalWindow('Dango_Pick.jsp')">뽑기</button>       
		</section>
		
		<section class="grid-section">
			<div class="grid-container">
			<%
		    	while (bContinue == true && this.dangoDAO.DBMgr.Rs.next())
		    	{
		    		switch (this.dangoDAO.DBMgr.Rs.getString("RARITY"))
		    		{
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
		    		
		    	if (this.dangoDAO.DBMgr.Rs.getInt("LOCKSTATE") == -1)	sLockState = "locked";

		    	else 		    		sLockState = "";		
		    		
		  
		    %>
				<div class="grid-item">
					<img class="grid-image <%=sLockState%>"
											alt="<%=this.dangoDAO.DBMgr.Rs.getString("DANGO_NAME")%>"
											src="<%=this.dangoDAO.DBMgr.Rs.getString("LOCATION_IMG")%>"><br>
					<a class="rarity <%=sRarityColor %>"><%=sRarityName%></a><br>
					<a class="dangoname"><%=this.dangoDAO.DBMgr.Rs.getString("DANGO_NAME")%></a>
		         </div>
			<%
				}         	
			%>
			</div>
			
		</section>
		<%------------------------------------------------------------------
		[모달 창 페이지 - START]
		----------------------------------------------------------------------%>
		<div class="Modal-Frame" id="divModalFrame">
	        <div class="Modal-Content">
	            <span class="Modal-Close" id="btnClose">&times;&nbsp;</span>
	            <h2>당고뽑기</h2> 
	            <iframe class="Modal-Window" id="ifModalWindow"></iframe>
	        </div>
        </div>
    </form>
   <%------------------------------------------------------------------
         footer
      ----------------------------------------------------------------------%>
   <%@ include file="../Common/Footer.jsp"%>
   <%----------------------------------------------------------------------
   [HTML Page - END]
   --------------------------------------------------------------------------%>

   <%----------------------------------------------------------------------
   [HTML Page - 자바스크립트 구현 영역 (하단)]
   [외부 자바스크립트 연결 (각각) : <script type="text/javascript" src="Hello.js"></script>]
   --------------------------------------------------------------------------%>
</body>
</html>
