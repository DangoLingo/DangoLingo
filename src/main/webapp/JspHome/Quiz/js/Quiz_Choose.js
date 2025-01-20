// -----------------------------------------------------------------
// [ 퀴즈 개수 버튼 선택 시 배경색 초록색으로 + 선택된 버튼 값 넘기기 ]
// -----------------------------------------------------------------
document.querySelectorAll('.button').forEach(function(button) {
	button.addEventListener('click', function() {
		// button 기본 동작 (submit되려고 하는 점) 방지
		event.preventDefault();
		// 기존에 checkedBtn 클래스를 가진 버튼에서 클래스 제거
		document.querySelectorAll('.checkedBtn').forEach(function(checkedButton) {
			checkedButton.classList.remove('checkedBtn');
		});
		// 클릭된 버튼에 checkedBtn 클래스 추가
		button.classList.add('checkedBtn');

		// 선택된 버튼의 값을 hidden input에 설정
		const count = button.value;
		document.getElementById('quizCount').value = count;
	});
});

// -----------------------------------------------------------------
// [라디오 버튼 선택 이벤트 ]
// -----------------------------------------------------------------
document.querySelectorAll('input[type="radio"]').forEach(function(radio) {
	radio.addEventListener('change', function() {
		// 모든 radio-icon을 기본 상태로 되돌림
		document.querySelectorAll('.radio-icon').forEach(function(icon) {
			icon.innerHTML = ''; // 기존의 SVG 제거
		});

		// 선택된 radio 버튼에만 SVG 표시
		const radioIcon = radio.nextElementSibling; // span.radio-icon
		if (radioIcon && radioIcon.classList.contains('radio-icon')) {
			radioIcon.innerHTML = `
		        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20" fill="none">
		          <path d="M20 10C20 15.5228 15.5228 20 10 20C4.47715 20 0 15.5228 0 10C0 4.47715 4.47715 0 10 0C15.5228 0 20 4.47715 20 10ZM6 10C6 12.2091 7.79086 14 10 14C12.2091 14 14 12.2091 14 10C14 7.79086 12.2091 6 10 6C7.79086 6 6 7.79086 6 10Z" fill="#324931"/>
		        </svg>
		      `;
		}
	});
});

// 페이지 로드 시 첫 번째 라디오 버튼에 SVG 추가
window.addEventListener('DOMContentLoaded', function() {
	const firstRadio = document.querySelector('input[type="radio"]:checked');
	if (firstRadio) {
		const firstRadioIcon = firstRadio.nextElementSibling;
		if (firstRadioIcon && firstRadioIcon.classList.contains('radio-icon')) {
			firstRadioIcon.innerHTML = `
		        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20" fill="none">
		          <path d="M20 10C20 15.5228 15.5228 20 10 20C4.47715 20 0 15.5228 0 10C0 4.47715 4.47715 0 10 0C15.5228 0 20 4.47715 20 10ZM6 10C6 12.2091 7.79086 14 10 14C12.2091 14 14 12.2091 14 10C14 7.79086 12.2091 6 10 6C7.79086 6 6 7.79086 6 10Z" fill="#324931"/>
		        </svg>
		      `;
		}
	}
});

