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
<body class="has-navbar">
    <%@ include file="../Common/Navbar.jsp"%>
    
    <main class="main-container">
        <section class="progress-section">
            <h2>당고 도감</h2>
            <p><%=userDangoCount %> / <%=todalDangoCount %></p>
            <button class="modal_btn" type="button" onclick="ShowModalWindow('Dango_Pick.jsp')">뽑기</button>       
        </section>
        
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
