<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.naming.java.javaURLContextFactory"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html lang="ko">
<head>
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
	<link rel="stylesheet" href="../Quiz/css/Quiz_Final.css"/>
</head>
<body>
	<%@ include file="../Common/Navbar.jsp"%>
	<div class="container">
		<main class="main-container">
			<div class="quiz-box">
				<form action="#" method="POST">
					<p class="heading">퀴즈 결과</p>
					<div class="result-box">
						<div class="result-chart">
							<div class="chart">
								<div class="chart-bar"></div>
								<div class="chart-text"></div>
							</div>
						</div>
						<ul class="result-details">
							<li><span>풀이 시간:</span> <span class="value">30분 45초</span></li>
							<li><span>맞춘 퀴즈:</span> <span class="value">9개</span></li>
							<li><span>틀린 퀴즈:</span> <span class="value">1개</span></li>
						</ul>
					</div>
					<p class="heading">오답 목록</p>
					<div class="wrong-box">
						<div class="wrong">
							<span>食べる (たべる)</span>
							<span class="meaning">먹다</span>
						</div>
						<div class="wrong">
							<span>飲む (のむ)</span>
							<span class="meaning">마시다</span>
						</div>
					</div>
					<div class="buttons">
						<button type="button" class="retry" onclick="location.href='${pageContext.request.contextPath}/JspHome/Quiz/Quiz_Play.jsp'">다시하기</button>
						<button type="button" class="exit" onclick="location.href='${pageContext.request.contextPath}/JspHome/Words/Words.jsp'">나가기</button>
					</div>
				</form>
			</div>
		</main>
	</div>
	<%@ include file="../Common/Footer.jsp"%>
	
	<script type="text/javascript">
		// 도넛 차트를 위한 JavaScript
		const chartBar = document.querySelector('.chart-bar');
		const chartText = document.querySelector('.chart-text');

		// 예시: 이 비율과 결과를 동적으로 조정
		const correctAnswers = 9;
		const totalAnswers = 10;
		const percentage = (correctAnswers / totalAnswers) * 100;
		const degree = (360 * percentage) / 100;
		
		// 차트의 각도를 동적으로 업데이트
		chartBar.style.setProperty('--deg', degree + 'deg');

		// 결과 텍스트를 동적으로 업데이트
		chartText.innerText = correctAnswers+'/'+totalAnswers;
	</script>
</body>
</html>
