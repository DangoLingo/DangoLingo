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
   <link rel="stylesheet" href="CSS/Basic.css?version=1.1"/>
   <style type="text/css">
   
  /* 공통 스타일 */
   body 
   {   
      margin: 0;
      font-family: 'Pretendard JP', sans-serif;
      background-color: #F6F7F5;
    }

   .container 
   {
         display: flex;
         flex-direction: column;
         justify-content: space-between;
         min-height: 100vh;
         
   }

   
   /* ========================== 네비게이션 바 스타일 ========================== */

   /* -----------------------------------------------------------------
      HTML Page 스타일시트
   ----------------------------------------------------------------- */
           
      main {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-grow: 1;
        }

        .card {
            width: 500px;
            height: 400px;
            background-color: white;
            border-radius: 16px;           
            text-align: center;
            box-sizing: border-box;
            padding: 0 50px;
        }

        .card h1 {
            font-size: 28px;
            font-weight: bold;
            margin-top: 50px;
            margin-bottom: 40px;         
            text-align: left;
            width: 100%;
            padding-left: 0;
            font-family: "LaundryGothicOTF";
            color: #000000;
        }

        .card input {
            width: 100%;
            height: 48px;
            padding: 0 16px;
            margin-bottom: 16px;
            border-radius: 16px;
            border: 1px solid rgba(112, 115, 124, 0.22);
            font-family: "Pretendard JP";
            font-size: 16px;
            box-sizing: border-box;
            transition: all 0.2s ease;
            background-color: white;
        }

        .card input:focus {
            border: 2px solid #324931;
            outline: none;
            box-shadow: 0 0 0 1px rgba(50, 73, 49, 0.1);
            background-color: rgba(50, 73, 49, 0.02);
        }

        .card .links {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            margin: 0 auto;
            font-size: 14px;
            font-family: "Pretendard JP";
            gap: 0;
            letter-spacing: -0.3px;
        }
        
        .card .links a {
            text-decoration: none;
            color: #324931;
            width: 110px;
            text-align: center;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 24px;
            font-weight: 400;
        }

        .card .links .divider {
            color: rgba(50, 73, 49, 0.4);
            font-family: "Pretendard JP";
            font-size: 12px;
            transform: scaleY(0.8);
            padding: 0 40px;
        }

        /* 불필요한 visited 상태 제거 - 기본 색상으로 통일 */

        .card button {
            width: 100%;
            height: 48px;
            background-color: #5C8B6C;
            color: white;
            border-radius: 16px;
            border: none;
            text-align: center;
            cursor: pointer;
            margin-top: 20px;
            font-family: "Pretendard JP";
            font-size: 16px;
        }
        
        .card button:hover {
            background-position: right center;
        }
        
          .card input:focus {
             border:2px solid #324931;
             outline: none;
      }
      
        /* 모바일 반응형 스타일 */
        @media screen and (max-width: 768px) {
            .card {
                width: 90%;
                height: auto;
                padding: 20px 30px;
                margin: 0 10px;
            }

            .card h1 {
                font-size: 24px;
                margin-top: 30px;
                margin-bottom: 30px;
            }

            .card input {
                width: 100%;
                margin-bottom: 12px;
                font-size: 14px;
            }

            .card .links {
                width: 100%;
            }
            
            .card .links a {
                width: 90px;
            }
            
            .card .links .divider {
                font-size: 11px;
                padding: 0 32px;
            }
        }
        
        /* -----------------------------------------------------------------
           HTML Page 스타일시트
           ----------------------------------------------------------------- */   
        /* ----------------------------------------------------------------- */
   </style>
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
      function DocumentInit(Msg)
      {
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
   Beans 객체 사용 선언   : id   - 임의의 이름 사용 가능(클래스 명 권장)
                  : class   - Beans 클래스 명
                   : scope   - Beans 사용 기간을 request 단위로 지정 Hello.HelloDTO 
   ------------------------------------------------------------------------
   <jsp:useBean id="HelloDTO" class="Hello.HelloDTO" scope="request"></jsp:useBean>
   --%>
   <%----------------------------------------------------------------------
   Beans 속성 지정 방법1   : Beans Property에 * 사용
                  :---------------------------------------------------
                  : name      - <jsp:useBean>의 id
                  : property   - HTML 태그 입력양식 객체 전체
                  :---------------------------------------------------
   주의사항            : HTML 태그의 name 속성 값은 소문자로 시작!
                  : HTML 태그에서 데이터 입력 없는 경우 null 입력 됨!
   ------------------------------------------------------------------------
   <jsp:setProperty name="HelloDTO" property="*"/>
   --%>
   <%----------------------------------------------------------------------
   Beans 속성 지정 방법2   : Beans Property에 HTML 태그 name 사용
                  :---------------------------------------------------
                  : name      - <jsp:useBean>의 id
                  : property   - HTML 태그 입력양식 객체 name
                  :---------------------------------------------------
   주의사항            : HTML 태그의 name 속성 값은 소문자로 시작!
                  : HTML 태그에서 데이터 입력 없는 경우 null 입력 됨!
                  : Property를 각각 지정 해야 함!
   ------------------------------------------------------------------------
   <jsp:setProperty name="HelloDTO" property="data1"/>
   <jsp:setProperty name="HelloDTO" property="data2"/>
   --%>
   <%----------------------------------------------------------------------
   Beans 속성 지정 방법3   : Beans 메서드 직접 호출
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
<div class="container">
   <%----------------------------------------------------------------------
   [HTML Page - FORM 디자인 영역]
   --------------------------------------------------------------------------%>
<!--    <form name="form1" action="Basic.jsp" method="post"> -->
      <%------------------------------------------------------------------
         네비게이션바
      ----------------------------------------------------------------------%>
      <%------------------------------------------------------------------
         로그인
      ----------------------------------------------------------------------%>
      <main>      
           <div class="card"> 
           <h1><a href="../Main/Main.jsp" style="text-decoration: none; color: inherit;">당고링고</a></h1>
               <input type="email" placeholder="이메일">         
               <input type="password" placeholder="비밀번호">
               <!-- 회원가입/비밀번호 찾기 링크 -->
            <div class="links">
                <a href="../Main/Main_SignUp.jsp">회원가입</a>
                <span class="divider">|</span>
                <a href="#">비밀번호 찾기</a>
            </div>
            <button>로그인</button>
         </div>
      </main>
      <%------------------------------------------------------------------
         [HTML Page - END]
      ----------------------------------------------------------------------%>
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
   바이패스 방법1   : JSP forward 액션을 사용 한 페이지 이동
            :-------------------------------------------------------
            : page   - 이동 할 새로운 페이지 주소
            : name   - page 쪽에 전달 할 파라미터 명칭
            : value   - page 쪽에 전달 할 파라미터 데이터
            :      - page 쪽에서 request.getParameter("name1")로 읽음
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
      //   바이패스 방법2   : RequestDispatcher을 사용 한 페이지 이동
      //            :---------------------------------------------------
      //            : sUrl   - 이동 할 새로운 페이지 주소
      //            :      - sUrl 페이지 주소에 GET 파라미터 전달 가능
      //            :      - sUrl 페이지가 갱신됨 즉,
      //            :      - sUrl 페이지 주소에 GET 파라미터 유무에 상관없이
      //            :      - sUrl 페이지 쪽에서 request.getParameter() 사용가능
      //            :-------------------------------------------------------
      //            : 이 방법은 기다리지 않고 바로 이동하기 때문에 현재 화면이 표시되지 않음
      //            : 브라우저 Url 주소는 현재 페이지로 유지 됨
      // -----------------------------------------------------------------
      // String sUrl = "Hello.jsp?name1=value1&name2=value2";
      //
      // RequestDispatcher dispatcher = request.getRequestDispatcher(sUrl);
      // dispatcher.forward(request, response);
      // -----------------------------------------------------------------
      //   바이패스 방법3   : response.sendRedirect을 사용 한 페이지 이동
      //            :---------------------------------------------------
      //            : sUrl   - 이동 할 새로운 페이지 주소
      //            :      - sUrl 페이지에 GET 파라미터만 전달 가능
      //            :      - sUrl 페이지 갱신 없음 즉,
      //            :      - sUrl 페이지 주소에 GET 파라미터 있는 경우만
      //            :      - sUrl 페이지 쪽에서 request.getParameter() 사용가능
      //            :-------------------------------------------------------
      //            : 이 방법은 기다리지 않고 바로 이동하기 때문에 현재 화면이 표시되지 않음
      //            : 브라우저의 Url 주소는 sUrl 페이지로 변경 됨
      // -----------------------------------------------------------------
      //String sUrl = "Hello.jsp?name1=value1&name2=value2";
      //
      //response.sendRedirect(sUrl);
      // -----------------------------------------------------------------
   %>
   </div>
   
</body>
</html>
