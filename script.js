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

// 로그인 함수 수정
async function login() {
    const email = document.getElementById('loginEmail').value;
    const password = document.getElementById('loginPassword').value;
    
    if (!email || !password) {
        alert('이메일과 비밀번호를 입력해주세요.');
        return;
    }
    
    // 임시 로그인 처리
    currentUser = { email };
    localStorage.setItem('currentUser', JSON.stringify(currentUser));
    
    // UI 업데이트
    document.getElementById('userEmail').textContent = email;
    document.getElementById('navGuest').classList.add('hidden');
    document.getElementById('navUser').classList.remove('hidden');
    
    // 모달 닫기
    closeAuthModal();
    
    // 대시보드로 이동
    await showDashboard();
}

// 로그아웃 함수 수정
async function logout() {
    stopStudyTimer();
    currentUser = null;
    localStorage.removeItem('currentUser');
    
    // UI 업데이트
    document.getElementById('navGuest').classList.remove('hidden');
    document.getElementById('navUser').classList.add('hidden');
    
    // 인트로 페이지로 이동
    await loadPage('intro');
}

// 학습 시작 함수 수정
async function startLearning() {
    if (currentUser) {
        await showDashboard();
        startStudyTimer();
    } else {
        showLoginForm();
    }
}

// 사용자 데이터 불러오�� 함수
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
        startStudyTimer(); // 학습 시작 시 타이머 시작
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
    if (!currentUser) {
        showIntro();
        return;
    }
    hideAllSections();
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

// 섹션 표시 관련 함수들
function showQuiz() {
    if (!currentUser) {
        showIntro();
        return;
    }
    // URL 변경
    window.location.href = '/quiz.html';
}

function showMyPage() {
    if (!currentUser) {
        showIntro();
        return;
    }
    hideAllSections();
    document.getElementById('mypageSection').classList.remove('hidden');
    loadUserProfile();
}

function showIntro() {
    hideAllSections();
    document.getElementById('introSection').classList.remove('hidden');
}

// 퀴즈 관련 변수들
let currentQuestion = 0;
let questions = [];
let score = 0;

// 퀴즈 시작 함수
function startQuiz() {
    const level = document.getElementById('quizLevel').value;
    // 여기서 선택된 레벨에 따른 문제를 가져옵니다
    loadQuizQuestions(level);
    
    document.getElementById('quizContainer').classList.remove('hidden');
    document.querySelector('.quiz-controls').classList.add('hidden');
    showQuestion();
}

// 문제 표시 함수
function showQuestion() {
    if (currentQuestion >= questions.length) {
        showQuizResult();
        return;
    }

    const question = questions[currentQuestion];
    document.getElementById('questionWord').textContent = question.word;
    document.getElementById('questionHint').textContent = question.hint;
    
    // 보기 버튼들 업데이트
    const optionButtons = document.querySelectorAll('.option-btn');
    question.options.forEach((option, index) => {
        optionButtons[index].textContent = option;
        optionButtons[index].className = 'option-btn';
    });

    // 진행 상황 업데이트
    document.getElementById('questionCounter').textContent = 
        `${currentQuestion + 1}/${questions.length}`;
    updateProgressBar();
}

// 답안 체크 함수
function checkAnswer(index) {
    const question = questions[currentQuestion];
    const buttons = document.querySelectorAll('.option-btn');
    
    buttons.forEach(btn => btn.disabled = true);
    
    if (index === question.correctIndex) {
        buttons[index].classList.add('correct');
        score++;
    } else {
        buttons[index].classList.add('wrong');
        buttons[question.correctIndex].classList.add('correct');
    }

    setTimeout(() => {
        currentQuestion++;
        showQuestion();
    }, 1500);
}

// 퀴즈 결과 표시 함수
function showQuizResult() {
    document.getElementById('quizContainer').classList.add('hidden');
    document.getElementById('quizResult').classList.remove('hidden');
    
    const accuracy = Math.round((score / questions.length) * 100);
    document.getElementById('correctAnswers').textContent = score;
    document.getElementById('wrongAnswers').textContent = questions.length - score;
    document.getElementById('quizAccuracy').textContent = `${accuracy}%`;
    
    // 100% 정답 업적 체크
    if (accuracy === 100) {
        userProgress.perfectQuiz = true;
        localStorage.setItem('userProgress', JSON.stringify(userProgress));
        checkAchievements();
    }
}

// 프로필 관련 함수
function loadUserProfile() {
    // 사용자 정보를 가져와서 프로필을 업데이트합니다
    const user = getCurrentUser(); // 이 함수는 현재 로그인된 사용자 정보를 반환해야 합니
    
    document.getElementById('profileName').textContent = user.name || '사용자';
    document.getElementById('profileEmail').textContent = user.email;
    
    // 학습 이력 업데이트
    updateStudyHistory(user);
}

function editProfile() {
    // 프로필 수정 모달을 표시합니다
    // 구현 필요
}

// 모든 섹션 숨기기
function hideAllSections() {
    const sections = [
        'introSection',
        'dashboardSection',
        'quizSection',
        'mypageSection'
    ];
    sections.forEach(id => {
        document.getElementById(id).classList.add('hidden');
    });
}

// 퀴즈 문제 로드
function loadQuizQuestions(level) {
    // 선택된 레벨의 단어들을 가져옵니다
    const words = wordDatabase[level];
    questions = [];
    currentQuestion = 0;
    score = 0;

    // 10개의 문제를 만듭니다
    const selectedWords = [...words]
        .sort(() => Math.random() - 0.5)
        .slice(0, 10);

    selectedWords.forEach(word => {
        // 오답 보기를 만듭니다
        const otherWords = words.filter(w => w !== word);
        const wrongOptions = otherWords
            .sort(() => Math.random() - 0.5)
            .slice(0, 3)
            .map(w => w.meaning);

        // 모든 보기를 ��치고 섞습니다
        const options = [...wrongOptions, word.meaning]
            .sort(() => Math.random() - 0.5);

        questions.push({
            word: word.japanese,
            hint: word.reading,
            options: options,
            correctIndex: options.indexOf(word.meaning)
        });
    });
}

// 진행 바 업데이트
function updateProgressBar() {
    const progress = (currentQuestion / questions.length) * 100;
    document.getElementById('quizProgressFill').style.width = `${progress}%`;
}

// 퀴즈 재시도
function retryQuiz() {
    const level = document.getElementById('quizLevel').value;
    loadQuizQuestions(level);
    
    document.getElementById('quizResult').classList.add('hidden');
    document.getElementById('quizContainer').classList.remove('hidden');
    showQuestion();
}

// 사용자 정보 가져오기
function getCurrentUser() {
    return currentUser || {
        email: '게스트',
        name: '게스트',
        studyHistory: {
            lastStudyDate: new Date().toISOString(),
            totalStudyTime: 0,
            studyStreak: 0
        }
    };
}

// 학습 이력 업데이트
function updateStudyHistory(user) {
    // 최근 학습 날짜
    const lastStudyDate = new Date(userProgress.lastStudy || new Date());
    document.getElementById('lastStudyDate').textContent = 
        lastStudyDate.toLocaleDateString();

    // 학습한 단어 수
    const totalStudied = Object.values(userProgress).reduce((sum, level) => {
        if (level.studied) return sum + level.studied.length;
        return sum;
    }, 0);
    document.getElementById('lastStudyWords').textContent = totalStudied;

    // 총 학습 시간 (임시 데이터)
    const totalStudyTime = Math.floor(Math.random() * 100);
    document.getElementById('totalStudyTime').textContent = totalStudyTime;

    // 연속 학습 일수 계산
    let streak = calculateStudyStreak();
    document.getElementById('studyStreak').textContent = streak;
}

// 연속 학습 일수 계산
function calculateStudyStreak() {
    if (!userProgress.lastStudy) return 0;

    const lastStudy = new Date(userProgress.lastStudy);
    const today = new Date();
    const diffTime = Math.abs(today - lastStudy);
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

    // 하루가 지났으면 연속 학습 초기화
    if (diffDays > 1) {
        userProgress.streak = 0;
    } else if (diffDays === 1) {
        // 어제 학습했으면 연속 학 유지
        userProgress.streak = (userProgress.streak || 0) + 1;
    }

    return userProgress.streak || 0;
}

// 학습 시간 관리를 위한 변수들
let studyStartTime = null;
let totalStudyTime = 0;
let studyTimer = null;

// 학습 시간 측정 시작
function startStudyTimer() {
    studyStartTime = new Date();
    studyTimer = setInterval(() => {
        const now = new Date();
        const elapsed = Math.floor((now - studyStartTime) / 1000); // 초 단위
        totalStudyTime = (userProgress.totalStudyTime || 0) + elapsed;
        
        // 시간 형식으로 변환 (시:분:초)
        const hours = Math.floor(totalStudyTime / 3600);
        const minutes = Math.floor((totalStudyTime % 3600) / 60);
        const seconds = totalStudyTime % 60;
        
        document.getElementById('totalStudyTime').textContent = 
            `${hours}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
    }, 1000);
}

// 학습 시간 측정 종료
function stopStudyTimer() {
    if (studyTimer) {
        clearInterval(studyTimer);
        studyTimer = null;
        
        // 총 학습 시간 저장
        userProgress.totalStudyTime = totalStudyTime;
        localStorage.setItem('userProgress', JSON.stringify(userProgress));
    }
}

// 업적 정의
const achievements = {
    firstStudy: {
        id: 'firstStudy',
        title: '첫 학습 완료',
        description: '첫 번째 학습을 완료했습니다!',
        icon: 'fa-star',
        condition: (progress) => progress.N5.studied.length > 0
    },
    weekStreak: {
        id: 'weekStreak',
        title: '7일 연속 학습',
        description: '7일 연속으로 학습을 완료하세요',
        icon: 'fa-calendar-check',
        condition: (progress) => progress.streak >= 7
    },
    hundredWords: {
        id: 'hundredWords',
        title: '단어 마스터 100',
        description: '100개의 단어를 학습하세요',
        icon: 'fa-book',
        condition: (progress) => {
            const totalStudied = Object.values(progress).reduce((sum, level) => {
                if (level.studied) return sum + level.studied.length;
                return sum;
            }, 0);
            return totalStudied >= 100;
        }
    },
    perfectQuiz: {
        id: 'perfectQuiz',
        title: '퀴즈 완벽주의자',
        description: '퀴즈에서 100% 정답을 기록하세요',
        icon: 'fa-crown',
        condition: (progress) => progress.hasOwnProperty('perfectQuiz')
    },
    studyTime: {
        id: 'studyTime',
        title: '열정적인 학습자',
        description: '총 학습 시간 10시간 달성',
        icon: 'fa-clock',
        condition: (progress) => (progress.totalStudyTime || 0) >= 36000 // 10시간 = 36000초
    }
};

// 업적 체크 함수 ���데이트
function checkAchievements() {
    const achievementGrid = document.querySelector('.achievement-grid');
    achievementGrid.innerHTML = ''; // 기존 업적 초기화
    
    Object.values(achievements).forEach(achievement => {
        const achieved = achievement.condition(userProgress);
        const card = document.createElement('div');
        card.className = `achievement-card ${achieved ? '' : 'locked'}`;
        
        card.innerHTML = `
            <i class="fas ${achievement.icon}"></i>
            <h3>${achievement.title}</h3>
            <p>${achievement.description}</p>
        `;
        
        achievementGrid.appendChild(card);
    });
}

// 프로필 드롭다운 관련 이벤트 리스너
document.addEventListener('DOMContentLoaded', function() {
    const profileBtn = document.querySelector('.profile-btn');
    const profileDropdown = document.querySelector('.profile-dropdown');

    profileBtn.addEventListener('click', function(e) {
        e.preventDefault();
        e.stopPropagation(); // 이벤트 전파 중단
        profileDropdown.classList.toggle('hidden');
    });

    // 드롭다운 외부 클릭시 닫기
    document.addEventListener('click', function(e) {
        if (!profileBtn.contains(e.target) && !profileDropdown.contains(e.target)) {
            profileDropdown.classList.add('hidden');
        }
    });

    // 드롭다운 내부 클릭 시 이벤트 전파 중단
    profileDropdown.addEventListener('click', function(e) {
        e.stopPropagation();
    });
}); 