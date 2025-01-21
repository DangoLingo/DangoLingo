	// -----------------------------------------------------------------
	// [ 타이머 ]
	// -----------------------------------------------------------------
	// 타이머 시작
    function startTimer() {
        const timeContainer = document.getElementById("timePassed");
        let elapsedTime = 0; // 시작 시점

        setInterval(() => {
            elapsedTime++; // 14초씩 증가
            const minutes = Math.floor(elapsedTime / 60);
            const seconds = elapsedTime % 60;
            timeContainer.textContent = minutes + "분 " + seconds + "초";
        }, 1000);
    }
		
 	// 페이지 로드 시 타이머 시작
    window.onload = function () {
        startTimer();
    };
    

$(document).ready(function() {
    // -----------------------------------------------------------------
    // [ JSON 데이터 받아오기 ]
    // -----------------------------------------------------------------
    var quizCount = $("#quizCount").val();
    var words_id = $("#words_id").val();
    var quizType = $("#quizType").val();
    
    var wrongAnswerIdArray = []
    var currentIndex =0;
    
    var correctAnswerCnt = 0;
    var question = null; //문제
    
    
    
    // AJAX 요청으로 DBTestingJson.jsp에서 JSON 데이터 받아오기
    $.ajax({
        url: 'QuizRandomJson.jsp', // JSON 데이터를 반환하는 JSP 페이지
        type: 'GET',
        dataType: 'json',
        data: {
            words_id: words_id  // 서버로 단어장명 전달
        },
        success: function(data) {
            
            // 전체 답지 들어간 배열 선언, 값 넣음
            var allAnswerArray = [];
            data.forEach(function(item) {
            	
            	//퀴즈 종류에 따라 답지 배열 종류 
                switch (quizType) {
                case 'ktoh':  //답지 히라가나로 표시
                case 'mtoh': 
                	allAnswerArray.push(item.hiragana);  break;
                case 'ktom': // 답지 한글뜻으로 표시
                    allAnswerArray.push(item.kanjiKr);  break;
                case 'mtok': // 답지 한자로 표시 
                    allAnswerArray.push(item.kanji);  break;

            }
           });
            
            function displayQuiz(quizType) {
            	console.log(quizType);
                if (currentIndex < quizCount) {
                    var quizItem = data[currentIndex];
					var correctAnswer =null;
                    
                    //퀴즈 종류에 따라 문제 한자 or 뜻으로 display 하게 
                    switch(quizType){
                    case 'ktoh':
                    	$('.word-display').html(quizItem.kanji);
                    	correctAnswer = quizItem.hiragana; break;
                    case 'ktom':
                    	$('.word-display').html(quizItem.kanji);
                    	correctAnswer = quizItem.kanjiKr; break;
                    case 'mtoh':
                    	$('.word-display').html(quizItem.kanjiKr);
                    	correctAnswer = quizItem.hiragana; break;
                    case 'mtok':
                    	$('.word-display').html(quizItem.kanjiKr); 
                    	correctAnswer = quizItem.kanji; break;
                    }
                    
                    $('.currentIndex').html(currentIndex + 1);
                    $('#btnCorrectAnswer').html(correctAnswer);
                    
                    // 오답 넣을 배열 선언
                    var wrongAnswerArray = [];
                    wrongAnswerArray = getRandomAnswersExcluding(allAnswerArray, correctAnswer);
                    
                    $('#btn2').html(wrongAnswerArray[0]);
                    $('#btn3').html(wrongAnswerArray[1]);
                    $('#btn4').html(wrongAnswerArray[2]);
                    
                   
                    
                 // 버튼 클릭 이벤트 통합
                    $('.button').on('click', function () {
                        const clickedButton = $(this); // 클릭한 버튼 저장

                        if (clickedButton.attr('id') === 'btnCorrectAnswer') {
                            correctAnswerCnt++; // 정답 클릭 시 카운트 증가

                            // 화면 전체 배경색 초록색으로 변경
                            $('body').css('background-color', 'rgba(0, 128, 0, 0.5)');
                            clickedButton.css('background-color', 'rgba(0, 128, 0, 0.5)');

                        } else {
                            // 오답 클릭 시 처리
                            wrongAnswerIdArray.push(data[currentIndex].japaneseId); // 오답 추가

                            // 화면 전체 배경색 빨간색으로 변경
                            $('body').css('background-color', 'rgba(255, 0, 0, 0.5)');
                            clickedButton.css('background-color', 'rgba(255, 0, 0, 0.5)');
                        }

                        // 0.6초 대기 후 초기화
                        setTimeout(function () {
                            $('body').css('background-color', '#F6F7F5'); // 화면 배경 초기화
                            clickedButton.css('background-color', ''); // 버튼 배경 초기화
                            currentIndex++;
                            shuffleButtons(); // 버튼 섞기
                            displayQuiz(quizType); // 다음 문제 표시
                        }, 600);
                    });


                } else {
                    // -----------------------------------------------------------------
                    // [ 퀴즈 끝났을 때 ]
                    // -----------------------------------------------------------------
                	// correctAnswerCnt 값을 localStorage에 저장
                	localStorage.setItem("quizCount", quizCount);
                	localStorage.setItem("correctAnswerCnt", correctAnswerCnt);
                	localStorage.setItem("wrongAnswerCnt", quizCount-correctAnswerCnt);
                	localStorage.setItem("timePassed", document.getElementById("timePassed").textContent);
                	localStorage.setItem('wrongAnswerIdArray', JSON.stringify(wrongAnswerIdArray));                    	
                	
                	// 퀴즈 끝났을 때 Quiz_Final.jsp로 리디렉션
                    window.location.href = 'Quiz_Final.jsp?words_id=' + words_id; // Quiz_Final.jsp로 이동

                }
            }

            // 첫 번째 퀴즈 표시
            displayQuiz(quizType);
        },
        error: function() {
            alert('Failed to load quiz data.');
        }
    });

    // -----------------------------------------------------------------
    // [ 버튼들 랜덤으로 순서 바꾸기 ]
    // -----------------------------------------------------------------
    function shuffleButtons() {
        var buttons = $(".button");

        // 버튼들을 랜덤하게 섞음
        buttons.sort(function() {
            return Math.random() - 0.5;
        });

        // .buttons 안에서 순서대로 배치
        $(".buttons").empty().append(buttons);
    }
    
});

// wrongAnswerArray에서 주어진 값 제외하고 랜덤으로 3개 값 뽑기
function getRandomAnswersExcluding(array, excludeValue) {
    // 주어진 값(excludeValue)을 제외한 새로운 배열 생성
    var filteredArray = array.filter(function(item) {
        return item !== excludeValue; // excludeValue를 제외
    });

    // 필터링된 배열을 랜덤하게 섞음
    var shuffledArray = filteredArray.sort(function() {
        return Math.random() - 0.5;
    });

    // 섞은 배열에서 원하는 개수만큼 잘라서 반환
    return shuffledArray.slice(0, 3);
}

// -----------------------------------------------------------------
// [ 나가기 버튼 클릭시 단어장 페이지로 리다이렉트 ]
// -----------------------------------------------------------------
document.querySelector('.exit').addEventListener('click', function () {
    window.location.href = '../Words/Words.jsp'; // 리디렉션할 페이지 경로
});
