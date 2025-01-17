<%@page import="BeansHome.Study.QuizDAO"%>
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
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="pragma" content="no-cache" />
<meta name="Description" content="검색 엔진을 위해 웹 페이지에 대한 설명을 명시" />
<meta name="keywords" content="검색 엔진을 위해 웹 페이지와 관련된 키워드 목록을 콤마로 구분해서 명시" />
<meta name="Author" content="문서의 저자를 명시" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>당고링고</title>
<%----------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	--------------------------------------------------------------------------%>
<link rel="stylesheet" href="../Quiz/css/Quiz_Final.css?ver=220610" />
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
	<%----------------------------------------------------------------------
	[HTML Page - FORM 디자인 영역]
	--------------------------------------------------------------------------%>
	<header>
		<%@ include file="../Common/Navbar.jsp"%>
	</header>
	<main>
		<form action="QuizResultUpdate.jsp" method="POST">
			<%----------------------------------------------------------------------
		[ 1) 퀴즈 결과]
		--------------------------------------------------------------------------%>
			<%
			String correctAnswerCnt = "<script>document.write(localStorage.getItem('correctAnswerCnt'));</script>";
			String wrongAnswerCnt = "<script>document.write(localStorage.getItem('wrongAnswerCnt'));</script>";
			%>
			<p class="heading">퀴즈 결과</p>
			<div class="result-box">
				<%----------------------------------------------------------------------
				[ 퀴즈 결과 : 도넛차트 ]
				--------------------------------------------------------------------------%>
				<div class="result-chart">
					<div class="chart">
						<div class="chart-bar"></div>
						<div class="chart-text"></div>
					</div>
				</div>
				<%----------------------------------------------------------------------
				[ 퀴즈 결과 : 텍스트 ]
				--------------------------------------------------------------------------%>
				<ul class="result-details">
					<li><span>풀이 시간:</span> <span class="value" id="timePassed"></span></li>
					<li><span>맞춘 퀴즈:</span> <span class="value"><%=correctAnswerCnt%>개</span></li>
					<li><span>틀린 퀴즈:</span> <span class="value"><%=wrongAnswerCnt%>개</span></li>
				</ul>
			</div>
			<%----------------------------------------------------------------------
		[ 2) 오답 목록 ]
		--------------------------------------------------------------------------%>
			<p class="heading">오답 목록</p>
			<div class="wrong-box"></div>
			<%----------------------------------------------------------------------
		[ 3) 하단 다시하기, 나가기 버튼 ]
		--------------------------------------------------------------------------%>
			<div class="buttons">
				<button type="button" class="retry">다시하기</button>
				<input type="hidden" name="user_id" value="1"><%--**추후 세션에서 받아오는 걸로 변경 --%>
				<input type="hidden" name="quiz_count" id="quiz_count"> 
				<input type="hidden" name="quiz_right" id="quiz_right">
				<button type="submit" class="exit">나가기</button>
			</div>

		</form>
	</main>
	<%@ include file="../Common/Footer.jsp"%>
	<%----------------------------------------------------------------------
	[HTML Page - END]  
	--------------------------------------------------------------------------%>
	<%----------------------------------------------------------------------
	[HTML Page - 자바스크립트 구현 영역 (하단)]
	[외부 자바스크립트 연결 (각각) : <script type="text/javascript" src="Hello.js"></script>]
	--------------------------------------------------------------------------%>
	<script type="text/javascript">
	document.getElementById('quiz_right').value = localStorage.getItem('correctAnswerCnt')
	document.getElementById('quiz_count').value = localStorage.getItem('quizCount')
		// -----------------------------------------------------------------
		// [ 도넛 차트 ]
		// -----------------------------------------------------------------
		const chartBar = document.querySelector('.chart-bar');
const chartText = document.querySelector('.chart-text');

// localStorage에서 값 가져오기
var correctAnswerCnt = parseInt(localStorage.getItem('correctAnswerCnt'), 10) || 0;
var wrongAnswerCnt = parseInt(localStorage.getItem('wrongAnswerCnt'), 10) || 0;
var totalAnswersCnt = correctAnswerCnt + wrongAnswerCnt;

// 비율 계산
const percentage = (correctAnswerCnt / totalAnswersCnt) * 100 || 0;
const targetDegree = (percentage / 100) * 360;

// 애니메이션 함수
function animateChart(targetDegree) {
  let currentDegree = 0;
  const duration = 1000; // 애니메이션 지속 시간 (ms)
  const startTime = performance.now();

  function updateAnimation(currentTime) {
    const elapsedTime = currentTime - startTime;
    const progress = Math.min(elapsedTime / duration, 1); // 진행 비율 (0~1)

    currentDegree = targetDegree * progress;
    chartBar.style.setProperty('--deg', currentDegree + 'deg');
    chartText.textContent = Math.round((currentDegree / 360) * 100) + '%';

    if (progress < 1) {
      requestAnimationFrame(updateAnimation);
    }
  }

  requestAnimationFrame(updateAnimation);
}

// 애니메이션 실행
animateChart(targetDegree);


		// 결과 텍스트를 동적으로 업데이트
		chartText.innerText = correctAnswerCnt + '/' + totalAnswersCnt;

		// -----------------------------------------------------------------
		// [ 시간 경과 표시 ]
		// -----------------------------------------------------------------
		var timePassed = localStorage.getItem('timePassed');
		document.getElementById("timePassed").textContent = timePassed;

		// -----------------------------------------------------------------
		// [ 오답 목록 표시]
		// -----------------------------------------------------------------
		var wrongAnswerIdArray = JSON.parse(localStorage.getItem('wrongAnswerIdArray'));

		// wrongAnswerIdArray가 비어있지 않으면 AJAX 요청
		if (wrongAnswerIdArray && wrongAnswerIdArray.length > 0) {
			// AJAX 요청 (서버에서 데이터를 가져옴)
			$.ajax({
				url : 'QuizRandomJson.jsp', // 데이터 요청 URL
				type : 'GET',
				dataType : 'json',
				data : {
					words_id : 103
				// 서버로 단어장명 전달. ***추후에 변경필요
				},
				success : function(data) {
					// 서버로부터 받은 데이터에서, wrongAnswerIdArray에 있는 japaneseId만 필터링
					var filteredData = data.filter(function(item) {
						return wrongAnswerIdArray.includes(item.japaneseId); // 배열에 해당 japaneseId가 있는지 확인
					});

					// 화면에 데이터를 하나씩 출력
					filteredData.forEach(function(item) {
						var wrongElement = '<div class="wrong">' + '<span>'
								+ item.kanji + ' (' + item.hiragana
								+ ')</span>' + '<span class="meaning">'
								+ item.kanjiKr + '</span>' + '</div>';
						// #quizContainer에 추가하는 대신, .wrong-box에 추가
						$('.wrong-box').append(wrongElement);
					});
				},
				error : function() {
					alert('데이터를 불러오는 데 실패했습니다.');
				}
			});
		} else {
			// wrongAnswerIdArray가 비어있으면 '데이터가 없습니다' 메시지 표시
			var noDataElement = '<div class="wrong">데이터가 없습니다</div>';
			$('.wrong-box').append(noDataElement);
		}

		// -----------------------------------------------------------------
		// [ 나가기 버튼 클릭 시 Quiz_Choose.jsp 로 리다이렉트]
		// -----------------------------------------------------------------
		document.querySelector('.retry').addEventListener('click', function () {
		    const redirectUrl = 'Quiz_Choose.jsp';
		    window.location.href = redirectUrl;
		});
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
