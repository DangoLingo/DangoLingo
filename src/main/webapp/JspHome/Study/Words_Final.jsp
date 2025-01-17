<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="BeansHome.Study.StudyDAO"%>
<%@page import="BeansHome.Study.StudyDTO"%>
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
    <title>Words_Final</title>
	<%----------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	[외부 스타일쉬트 연결 : <link rel="stylesheet" href="Hello.css?version=1.1"/>]
	--------------------------------------------------------------------------%>
	<link rel="stylesheet" href="CSS/words_final.css" />
	<style type="text/css">
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
	// 세션에서 user_id 가져오기 / 없으면 기본값 5 설정
Integer userId = (Integer) session.getAttribute("userId"); // 세션에서 user_id 가져오기
if (userId == null) {
    userId = 4; // 기본값 설정
    out.println("기본값으로 설정된 사용자 ID: " + userId); // 기본값 출력
} else {
    out.println("현재 사용자 ID: " + userId);
}

	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 데이터베이스 파라미터]
	// ---------------------------------------------------------------------
	String url = "jdbc:oracle:thin:@cobyserver.iptime.org:1521:xe";
	String user = "dango";
	String password = "lingo";
	Connection connection = null;
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		connection = DriverManager.getConnection(url, user, password);
		// DAO and DTO code has been removed.
	} catch (ClassNotFoundException | SQLException e) {
		e.printStackTrace();
	} finally {
		if (connection != null) {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 일반 변수]
	// ---------------------------------------------------------------------
	String timer = request.getParameter("timer");
	if (timer == null) {
		timer = "0분 0초";
	}

	
	String memorizedCountParam = request.getParameter("memorizedCount");
	int memorizedCount = memorizedCountParam != null ? Integer.parseInt(memorizedCountParam) : 0;

	String forgotCountParam = request.getParameter("forgotCount");
	int forgotCount = forgotCountParam != null ? Integer.parseInt(forgotCountParam) : 0;

	// Add japaneseId to the parameters being read
	String japaneseIdParam = request.getParameter("japaneseId");
	int japaneseId = japaneseIdParam != null ? Integer.parseInt(japaneseIdParam) : 1;

	// Retrieve words_id from the URL and store it in wordsId
	String wordsIdParam = request.getParameter("words_id");
	int wordsId = (wordsIdParam != null) ? Integer.parseInt(wordsIdParam) : 101;
	// ---------------------------------------------------------------------
	// [웹 페이지 get/post 파라미터 조건 필터링]
	// ---------------------------------------------------------------------
	
	// ---------------------------------------------------------------------
	// [일반 변수 조건 필터링]
	// ---------------------------------------------------------------------
	// ---------------------------------------------------------------------
%>
<%--------------------------------------------------------------------------
[Beans/DTO 선언 및 속성 지정 영역]
------------------------------------------------------------------------------%>
	<%----------------------------------------------------------------------
	Beans 객체 사용 선언	: id	- 임의의 이름 사용 가능(클래스 명 권장)
						: class	- Beans 클래스 명
 						: scope	- Beans 사용 기간을 request 단위로 지정 BeansHome.Study.StudyDTO 
	------------------------------------------------------------------------
	<jsp:useBean id="StudyDTO" class="BeansHome.Study.StudyDTO" scope="request"></jsp:useBean>
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
	<jsp:setProperty name="StudyDTO" property="*"/>
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
	<jsp:setProperty name="StudyDTO" property="data1"/>
	<jsp:setProperty name="StudyDTO" property="data2"/>
	--%>
	<%----------------------------------------------------------------------
	Beans 속성 지정 방법3	: Beans 메서드 직접 호출
						:---------------------------------------------------
						: Beans 메서드를 각각 직접 호출 해야함!
	--------------------------------------------------------------------------%>
<%
	// StudyDTO.setData1(request.getParameter("data1"));
%>
<%--------------------------------------------------------------------------
[Beans DTO 읽기 및 로직 구현 영역]
------------------------------------------------------------------------------%>

<body class="Body">
	<%----------------------------------------------------------------------
	[HTML Page - FORM 디자인 영역]
	--------------------------------------------------------------------------%>
		<%------------------------------------------------------------------
			타이틀
		----------------------------------------------------------------------%>
	   <header>
	      <%@ include file="../Common/Navbar.jsp"%>
	   </header>
		<%------------------------------------------------------------------
			메인 콘텐츠
		----------------------------------------------------------------------%>
	   <main class="content">
	      <div class="result-box">
	         <!-- 학습 결과 제목 -->
	         <h2>학습 결과</h2>
	
	         <!-- 차트 섹션 -->
	         <div class="result-chart">
	            <div class="chart">
	               <div class="chart-bar"></div>
	               <div class="chart-result">32/50</div>
	            </div>
	         </div>
	
	         <!-- 결과 상세 정보 -->
	         <ul class="result-details">
	            <li><span>학습 시간:</span> <span class="value"><%= timer %></span></li>
	            <li><span>외운 단어:</span> <span class="value"><%= memorizedCount %>개</span></li>
	            <li><span>모르는 단어:</span> <span class="value"><%= forgotCount %>개</span></li>
	         </ul>
	
	         <!-- 버튼 섹션 -->
	         <div class="buttons">
	            <button class="retry">다시하기</button>
	            <button class="exit">나가기</button>
	         </div>
	      </div>
	   </main>
		<%------------------------------------------------------------------
			푸터
		----------------------------------------------------------------------%>
		<footer>
			<%@ include file="../Common/Footer.jsp"%>
		</footer>
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
    // 도넛 차트 관련 코드
    const chartBar = document.querySelector('.chart-bar');
    const chartResult = document.querySelector('.chart-result');

    // 정답 개수와 총 문제 수를 설정합니다.
    const correctAnswers = <%= memorizedCount %>; // 정답 개수
    const totalAnswers = 50; // 총 문제 수
    const percentage = (correctAnswers / totalAnswers) * 100; // 정답 비율 계산
    const degree = (percentage / 100) * 360; // 도넛 차트 각도 계산

    // 도넛 차트의 각도를 설정합니다.
    chartBar.style.setProperty('--deg', degree + 'deg');
    // 도넛 차트 결과 텍스트를 설정합니다.
    chartResult.innerText = correctAnswers + "/" + totalAnswers;

    // 버튼 이벤트 핸들러 추가
    document.querySelector('.retry').addEventListener('click', () => {
        // 다시하기 버튼 클릭 시 Words_Study 페이지로 이동
    	window.location.href = '<%= request.getContextPath() %>/JspHome/Study/Words_Study.jsp'
    });

    document.querySelector('.exit').addEventListener('click', () => {
        const timer = '<%= timer %>'; // "00분00초" 형식
        const userId = <%= userId %>;  // 사용자 ID 추가
        const wordsId = <%= wordsId %>;  // 단어장 ID 추가
        const japaneseId = <%= japaneseId %>;  // 일본어 ID 추가

        // 디버깅: 변수 값 확인
        console.log("Timer (원본):", timer);
        console.log("User ID:", userId);

        // 'timer' 값을 숫자로 변환 (분 단위)
        let minutes = 10; // 기본값 10 설정
        try {
            if (timer && timer.includes('분')) {
                minutes = parseInt(timer.split('분')[0], 10); // "00분"에서 숫자 추출
            }
            if (isNaN(minutes) || minutes === 0) {
                minutes = 10; // 변환 실패 또는 0인 경우 기본값 설정
            }
        } catch (error) {
            console.error("Timer 변환 오류:", error);
            minutes = 10; // 변환 중 오류 발생 시 기본값 설정
        }

        // 최종 변환된 timer 값 확인
        console.log("변환된 Timer (minutes):", minutes);

        // AJAX 요청 보내기
        const xhr = new XMLHttpRequest();
        xhr.open('POST', '<%= request.getContextPath() %>/UpdateStudyInfo', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    console.log('서버 응답:', xhr.responseText);
                    setTimeout(() => {
                        window.location.href = '<%= request.getContextPath() %>/JspHome/Words/Words.jsp';
                    }, 500); // 0.5초 지연 후 페이지 이동
                } else {
                    console.error("AJAX 요청 실패:", xhr.status, xhr.statusText);
                }
            }
        };

        // AJAX 요청 데이터
		const params = "timer=" + minutes + "&userId=" + userId + "&wordsId=" + wordsId + "&japaneseId=" + japaneseId;
        console.log("AJAX 요청 데이터:", params);
        xhr.send(params);
    });

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

</body>
</html>
