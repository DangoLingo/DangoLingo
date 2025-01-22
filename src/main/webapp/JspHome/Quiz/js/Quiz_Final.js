// -----------------------------------------------------------------
// [ 정답 및 문제 개수 로드 ]
// -----------------------------------------------------------------
document.getElementById('quiz_right').value = localStorage.getItem('correctAnswerCnt')
document.getElementById('quiz_count').value = localStorage.getItem('quizCount')
// -----------------------------------------------------------------
// [ 도넛 차트 ]
// -----------------------------------------------------------------
const chartBar = document.querySelector('.chart-bar'); // 차트 바 요소
const chartText = document.querySelector('.chart-text'); // 차트 텍스트 요소

// localStorage에서 정답, 오답 개수 가져오기
var correctAnswerCnt = parseInt(localStorage.getItem('correctAnswerCnt'), 10) || 0;
var wrongAnswerCnt = parseInt(localStorage.getItem('wrongAnswerCnt'), 10) || 0;
var totalAnswersCnt = correctAnswerCnt + wrongAnswerCnt;

// 도넛 차트의 비율 및 각도 계산
const percentage = (correctAnswerCnt / totalAnswersCnt) * 100 || 0;
const targetDegree = (percentage / 100) * 360;

// 차트 애니메이션 함수
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

// 차트 애니메이션 실행
animateChart(targetDegree);


// 결과 텍스트를 동적으로 업데이트
chartText.innerText = correctAnswerCnt + '/' + totalAnswersCnt;

// -----------------------------------------------------------------
// [ 시간 경과 표시 ]
// -----------------------------------------------------------------
var timePassed = localStorage.getItem('timePassed'); // 경과 시간 가져오기
document.getElementById("timePassed").textContent = timePassed; // 화면에 경과 시간 표시

// -----------------------------------------------------------------
// [ 오답 목록 표시]
// -----------------------------------------------------------------
var wrongAnswerIdArray = JSON.parse(localStorage.getItem('wrongAnswerIdArray')); // 오답 ID 배열 가져오기
var words_id = document.getElementById("words_id").value;
// wrongAnswerIdArray가 비어있지 않으면 AJAX 요청
if (wrongAnswerIdArray && wrongAnswerIdArray.length > 0) {
	// AJAX 요청 (서버에서 데이터를 가져옴)
	$.ajax({
		url: 'QuizRandomJson.jsp', // 데이터 요청 URL
		type: 'GET',
		dataType: 'json',
		data: {
			words_id: words_id
		},
		success: function(data) {
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
		error: function() {
			alert('데이터를 불러오는 데 실패했습니다.');
		}
	});
} else {
	// wrongAnswerIdArray가 비어있으면 '오답이 없습니다' 메시지 표시
	var noDataElement = '<div class="wrong">오답이 없습니다</div>';
	$('.wrong-box').append(noDataElement);
}

// -----------------------------------------------------------------
// [ 나가기 버튼 클릭 시 Quiz_Choose.jsp 로 리다이렉트]
// -----------------------------------------------------------------
document.querySelector('.retry').addEventListener('click', function() {
	const redirectUrl = 'Quiz_Choose.jsp?wordsId=' + words_id;
	window.location.href = redirectUrl;
});