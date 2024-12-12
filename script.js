// 단어 데이터베이스
const wordDatabase = {
    'N5': [
        { japanese: '犬', reading: 'いぬ', meaning: '개' },
        { japanese: '猫', reading: 'ねこ', meaning: '고양이' },
        { japanese: '本', reading: 'ほん', meaning: '책' },
        // 더 많은 N5 단어들을 추가할 수 있습니다
    ],
    'N4': [
        { japanese: '約束', reading: 'やくそく', meaning: '약속' },
        { japanese: '急', reading: 'いそ（ぐ）', meaning: '서두르다' },
        { japanese: '結婚', reading: 'けっこん', meaning: '결혼' },
        // 더 많은 N4 단어들을 추가할 수 있습니다
    ],
    'N3': [
        { japanese: '我慢', reading: 'がまん', meaning: '참다' },
        { japanese: '経験', reading: 'けいけん', meaning: '경험' },
        { japanese: '説明', reading: 'せつめい', meaning: '설명' },
        // 더 많은 N3 단어들을 추가할 수 있습니다
    ]
};

let currentLevel = 'N5';
let currentWords = [...wordDatabase['N5']];
let currentIndex = 0;

// 레벨 선택 함수
function selectLevel(level) {
    currentLevel = level;
    currentWords = [...wordDatabase[level]];
    shuffleArray(currentWords);
    currentIndex = 0;
    displayWord();
}

// 배열을 섞는 함수
function shuffleArray(array) {
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
}

// 단어 표시 함수
function displayWord() {
    const word = currentWords[currentIndex];
    document.getElementById('japanese').textContent = word.japanese;
    document.getElementById('reading').textContent = word.reading;
    document.getElementById('meaning').textContent = word.meaning;
    document.getElementById('meaning').classList.add('hidden');
    updateStudyProgress(word);
}

// 뜻 보기/숨기기 토글 함수
function toggleMeaning() {
    const meaning = document.getElementById('meaning');
    meaning.classList.toggle('hidden');
}

// 다음 단어로 넘어가는 함수
function nextWord() {
    currentIndex = (currentIndex + 1) % currentWords.length;
    displayWord();
}

// 사용자 관리
let currentUser = null;

// 인증 관련 함수들
function toggleAuth() {
    document.getElementById('loginBox').classList.toggle('hidden');
    document.getElementById('registerBox').classList.toggle('hidden');
}

function login() {
    const email = document.getElementById('loginEmail').value;
    const password = document.getElementById('loginPassword').value;
    
    if (!email || !password) {
        alert('이메일과 비밀번호를 입력해주세요.');
        return;
    }
    
    // 임시 로그인 처리
    currentUser = { email };
    
    // UI 업데이트
    document.getElementById('userEmail').textContent = email;
    document.getElementById('userDisplayName').textContent = email.split('@')[0];
    document.getElementById('navGuest').classList.add('hidden');
    document.getElementById('navUser').classList.remove('hidden');
    
    // 모달 닫기
    closeAuthModal();
    
    // 인트로 섹션 숨기기
    document.getElementById('introSection').classList.add('hidden');
    
    // 대시보드 표시 및 업데이트
    document.getElementById('dashboardSection').classList.remove('hidden');
    updateProgress();
    
    // 저장된 데이터 불러오기
    loadUserData();
}

// 사용자 데이터 불러오기 함수
function loadUserData() {
    // 저장된 진도 불러오기
    const savedProgress = localStorage.getItem('userProgress');
    if (savedProgress) {
        userProgress = JSON.parse(savedProgress);
    }
    
    // 총 단어 수 업데이트
    const totalWords = Object.values(wordDatabase).reduce((sum, level) => sum + level.length, 0);
    document.getElementById('totalWords').textContent = totalWords;
    
    // 학습한 단어 수 업데이트
    const totalStudied = Object.values(userProgress).reduce((sum, level) => {
        if (level.studied) return sum + level.studied.length;
        return sum;
    }, 0);
    document.getElementById('totalStudiedWords').textContent = totalStudied;
    
    // 원형 프로그레스 바 업데이트
    const totalProgress = (totalStudied / totalWords) * 100;
    const progressCircle = document.getElementById('totalProgressCircle');
    progressCircle.style.setProperty('--progress', `${totalProgress * 3.6}deg`);
    
    updateProgress();
}

function register() {
    const email = document.getElementById('registerEmail').value;
    const password = document.getElementById('registerPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    
    if (!email || !password || !confirmPassword) {
        alert('모든 필드를 입력해주세요.');
        return;
    }
    
    if (password !== confirmPassword) {
        alert('비밀번호가 일치하지 않습니다.');
        return;
    }
    
    // 임시 회원가입 처리
    login();
}

function logout() {
    currentUser = null;
    
    // UI 업데이트
    document.getElementById('navGuest').classList.remove('hidden');
    document.getElementById('navUser').classList.add('hidden');
    
    // 인트로 페이지로 이동
    document.getElementById('dashboardSection').classList.add('hidden');
    document.getElementById('mainSection').classList.add('hidden');
    document.getElementById('introSection').classList.remove('hidden');
}

// 모드 전환
function switchMode(mode) {
    if (mode === 'study') {
        document.getElementById('studySection').classList.remove('hidden');
        document.getElementById('quizSection').classList.add('hidden');
    } else {
        document.getElementById('studySection').classList.add('hidden');
        document.getElementById('quizSection').classList.remove('hidden');
        startQuiz();
    }
}

// 퀴즈 관련 변수와 함수들
let currentQuiz = null;
let quizWords = [];

function startQuiz() {
    quizWords = [...currentWords];
    nextQuiz();
}

function createQuiz() {
    const correctWord = quizWords[currentIndex];
    const options = [correctWord.meaning];
    
    // 3개의 다른 보기 추가
    while (options.length < 4) {
        const randomLevel = Object.keys(wordDatabase)[Math.floor(Math.random() * Object.keys(wordDatabase).length)];
        const randomWords = wordDatabase[randomLevel];
        const randomWord = randomWords[Math.floor(Math.random() * randomWords.length)];
        
        if (!options.includes(randomWord.meaning)) {
            options.push(randomWord.meaning);
        }
    }
    
    // 보기 섞기
    shuffleArray(options);
    
    return {
        question: correctWord.japanese,
        reading: correctWord.reading,
        options: options,
        correctAnswer: options.indexOf(correctWord.meaning)
    };
}

function nextQuiz() {
    currentQuiz = createQuiz();
    document.getElementById('quizQuestion').textContent = 
        `${currentQuiz.question}\n(${currentQuiz.reading})`;
    
    for (let i = 0; i < 4; i++) {
        const btn = document.getElementById(`option${i}`);
        btn.textContent = currentQuiz.options[i];
        btn.className = 'quiz-btn';
    }
    
    document.getElementById('quizResult').classList.add('hidden');
}

// 오답 노트 관리
let wrongAnswers = [];
let correctCount = 0;
let wrongCount = 0;

// 음성 합성 함수
function speak(text) {
    const utterance = new SpeechSynthesisUtterance(text);
    utterance.lang = 'ja-JP';
    speechSynthesis.speak(utterance);
}

// 음 듣기 함수
function playAudio() {
    const word = currentWords[currentIndex];
    speak(word.reading);
}

function playQuizAudio() {
    speak(currentQuiz.reading);
}

// 오답 노트에 추가
function addToWrongAnswers(word, userAnswer) {
    const wrongAnswer = {
        japanese: word.question,
        reading: word.reading,
        meaning: word.options[word.correctAnswer],
        userAnswer: userAnswer
    };
    
    // 중복 제거
    if (!wrongAnswers.some(item => item.japanese === wrongAnswer.japanese)) {
        wrongAnswers.push(wrongAnswer);
    }
    
    // localStorage에 저장
    localStorage.setItem('wrongAnswers', JSON.stringify(wrongAnswers));
}

// 오답 노트 표시
function showWrongAnswers() {
    document.getElementById('studySection').classList.add('hidden');
    document.getElementById('quizSection').classList.add('hidden');
    document.getElementById('wrongAnswersSection').classList.remove('hidden');
    
    const wrongAnswersList = document.getElementById('wrongAnswersList');
    wrongAnswersList.innerHTML = '';
    
    wrongAnswers.forEach(item => {
        const div = document.createElement('div');
        div.className = 'wrong-answer-item';
        div.innerHTML = `
            <p class="japanese">${item.japanese}</p>
            <p class="reading">${item.reading}</p>
            <p class="meaning">정답: ${item.meaning}</p>
            <p class="user-answer">내 답: ${item.userAnswer}</p>
            <button onclick="speak('${item.reading}')" class="audio-btn">🔊 발음 듣기</button>
        `;
        wrongAnswersList.appendChild(div);
    });
}

// 기존 checkAnswer 함수 수정
function checkAnswer(selectedIndex) {
    const resultElement = document.getElementById('quizResult');
    const buttons = document.querySelectorAll('.quiz-btn');
    
    buttons.forEach(btn => btn.disabled = true);
    
    if (selectedIndex === currentQuiz.correctAnswer) {
        resultElement.textContent = '정답입니다!';
        resultElement.className = 'quiz-result correct';
        buttons[selectedIndex].classList.add('correct');
        correctCount++;
        document.getElementById('correctCount').textContent = correctCount;
    } else {
        resultElement.textContent = '틀렸습니다. 정답은 ' + 
            currentQuiz.options[currentQuiz.correctAnswer] + ' 입니다.';
        resultElement.className = 'quiz-result wrong';
        buttons[selectedIndex].classList.add('wrong');
        buttons[currentQuiz.correctAnswer].classList.add('correct');
        wrongCount++;
        document.getElementById('wrongCount').textContent = wrongCount;
        
        // 오답 노트에 추가
        addToWrongAnswers(currentQuiz, currentQuiz.options[selectedIndex]);
    }
    
    resultElement.classList.remove('hidden');
}

// 학습 진도 관리
let userProgress = {
    N5: { studied: [], total: wordDatabase['N5'].length },
    N4: { studied: [], total: wordDatabase['N4'].length },
    N3: { studied: [], total: wordDatabase['N3'].length },
    lastStudy: null,
    lastLevel: null
};

// 진도율 계산 및 표시
function updateProgress() {
    // 각 레벨별 진도율 계산
    const n5Rate = (userProgress.N5.studied.length / userProgress.N5.total) * 100;
    const n4Rate = (userProgress.N4.studied.length / userProgress.N4.total) * 100;
    const n3Rate = (userProgress.N3.studied.length / userProgress.N3.total) * 100;
    
    // 전체 진도율 계산
    const totalStudied = userProgress.N5.studied.length + 
                        userProgress.N4.studied.length + 
                        userProgress.N3.studied.length;
    const totalWords = userProgress.N5.total + 
                      userProgress.N4.total + 
                      userProgress.N3.total;
    const totalRate = (totalStudied / totalWords) * 100;

    // 진도바 업데이트
    document.getElementById('totalProgress').style.width = `${totalRate}%`;
    document.getElementById('n5Progress').style.width = `${n5Rate}%`;
    document.getElementById('n4Progress').style.width = `${n4Rate}%`;
    document.getElementById('n3Progress').style.width = `${n3Rate}%`;

    // 텍스트 업데이트
    document.getElementById('totalProgressText').textContent = `${Math.round(totalRate)}%`;
    document.getElementById('n5ProgressText').textContent = `${Math.round(n5Rate)}%`;
    document.getElementById('n4ProgressText').textContent = `${Math.round(n4Rate)}%`;
    document.getElementById('n3ProgressText').textContent = `${Math.round(n3Rate)}%`;

    // 통계 업데이트
    document.getElementById('dashboardCorrect').textContent = correctCount;
    document.getElementById('dashboardWrong').textContent = wrongCount;
    const accuracyRate = correctCount + wrongCount === 0 ? 0 : 
        Math.round((correctCount / (correctCount + wrongCount)) * 100);
    document.getElementById('accuracyRate').textContent = `${accuracyRate}%`;

    // 최근 학습 정보 업데이트
    if (userProgress.lastStudy) {
        document.getElementById('lastStudyDate').textContent = 
            new Date(userProgress.lastStudy).toLocaleDateString();
        document.getElementById('lastStudyLevel').textContent = 
            userProgress.lastLevel || '없음';
    }
}

// 학습 시 함수
function startLearning() {
    if (currentUser) {
        // 이미 로그인된 경우 대시보드로 이동
        showDashboard();
    } else {
        // 로그인되지 않은 경우 로그인 모달 표시
        showLoginForm();
    }
}

// 학습 계속하기 함수
function continueStudy() {
    document.getElementById('dashboardSection').classList.add('hidden');
    document.getElementById('mainSection').classList.remove('hidden');
}

// 단어 학습 시 진도 업데이트
function updateStudyProgress(word) {
    if (!userProgress[currentLevel].studied.includes(word.japanese)) {
        userProgress[currentLevel].studied.push(word.japanese);
        userProgress.lastStudy = new Date().toISOString();
        userProgress.lastLevel = currentLevel;
        localStorage.setItem('userProgress', JSON.stringify(userProgress));
        updateProgress();
    }
}

// 모달 관련 함수들
function showLoginForm() {
    document.getElementById('authModal').classList.remove('hidden');
    document.getElementById('loginForm').classList.remove('hidden');
    document.getElementById('registerForm').classList.add('hidden');
}

function showRegisterForm() {
    document.getElementById('authModal').classList.remove('hidden');
    document.getElementById('registerForm').classList.remove('hidden');
    document.getElementById('loginForm').classList.add('hidden');
}

function closeAuthModal() {
    document.getElementById('authModal').classList.add('hidden');
}

function toggleAuthForm() {
    document.getElementById('loginForm').classList.toggle('hidden');
    document.getElementById('registerForm').classList.toggle('hidden');
}

// 대시보드 표시 함수
function showDashboard() {
    document.getElementById('introSection').classList.add('hidden');
    document.getElementById('dashboardSection').classList.remove('hidden');
    updateProgress();
}

// 초기 단어 표시
window.onload = () => {
    shuffleArray(currentWords);
    displayWord();
    
    // 로그인 상태가 아니면 인증 섹션 표시
    if (!currentUser) {
        document.getElementById('authSection').classList.remove('hidden');
        document.getElementById('mainSection').classList.add('hidden');
    }
    
    // 오답 노트 불러오기
    const savedWrongAnswers = localStorage.getItem('wrongAnswers');
    if (savedWrongAnswers) {
        wrongAnswers = JSON.parse(savedWrongAnswers);
    }
    
    // 점수 불러오기
    const savedCorrectCount = localStorage.getItem('correctCount');
    const savedWrongCount = localStorage.getItem('wrongCount');
    if (savedCorrectCount) correctCount = parseInt(savedCorrectCount);
    if (savedWrongCount) wrongCount = parseInt(savedWrongCount);
    
    document.getElementById('correctCount').textContent = correctCount;
    document.getElementById('wrongCount').textContent = wrongCount;
    
    // 로그인 상태에 따라 적절한 화면 표시
    if (currentUser) {
        document.getElementById('introSection').classList.remove('hidden');
    } else {
        document.getElementById('introSection').classList.remove('hidden');
    }
    
    // 저장된 진도 불러오기
    const savedProgress = localStorage.getItem('userProgress');
    if (savedProgress) {
        userProgress = JSON.parse(savedProgress);
        updateProgress();
    }
    
    // 로그인 상태에 따라 네비게이션 UI 업데이트
    if (currentUser) {
        document.getElementById('navGuest').classList.add('hidden');
        document.getElementById('navUser').classList.remove('hidden');
        document.getElementById('userEmail').textContent = currentUser.email;
    } else {
        document.getElementById('navGuest').classList.remove('hidden');
        document.getElementById('navUser').classList.add('hidden');
    }
}; 