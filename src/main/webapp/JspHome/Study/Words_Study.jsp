<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="BeansHome.Study.StudyDAO"%>
<%@page import="BeansHome.Study.StudyDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 학습한 단어 개수를 초기화
int learnedWordsCount = 0;
String learnedWordsCountParam = request.getParameter("learnedWordsCount");
if (learnedWordsCountParam != null) {
  learnedWordsCount = Integer.parseInt(learnedWordsCountParam);
}

// 데이터베이스 연결 정보 설정
String user = "dango"; // DB 사용자명
String password = "lingo"; // DB 비밀번호
Connection connection = null;
StudyDTO studyDTO = null;
List<String[]> wordsList = new ArrayList<>();
int japaneseId = 1;

// words_id 파라미터 가져오기
String wordsIdParam = request.getParameter("wordsId");
int wordsId = Integer.parseInt(wordsIdParam);//(wordsIdParam != null) ? Integer.parseInt(wordsIdParam) : 101;

// 세션에서 user_id 가져오기 / 없으면 기본값 4 설정
Integer userId = (Integer) session.getAttribute("userId"); // 세션에서 user_id 가져오기
if (userId == null) {
    //userId = 4; // 기본값 설정
    out.println("기본값으로 설정된 사용자 ID: " + userId); // 기본값 출력
} else {
    out.println("현재 사용자 ID: " + userId);
}


try {
    // Oracle JDBC 드라이버 로드 및 DB 연결
    Class.forName("oracle.jdbc.driver.OracleDriver");
    connection = DriverManager.getConnection("jdbc:oracle:thin:@cobyserver.iptime.org:1521:xe", user, password);

    // 일본어 단어 데이터 조회 쿼리 실행
    String query = "SELECT japanese_id, kanji, hiragana, kanji_kr, example, example_kr FROM tb_japanese WHERE words_id = ? ORDER BY japanese_id";
    try (PreparedStatement stmt = connection.prepareStatement(query)) {
        stmt.setInt(1, wordsId);
        try (ResultSet rs = stmt.executeQuery()) {
            wordsList.clear();
            while (rs.next()) {
                String[] wordData = new String[6];
                wordData[0] = rs.getString("kanji");
                wordData[1] = rs.getString("hiragana");
                wordData[2] = rs.getString("kanji_kr");
                wordData[3] = rs.getString("example");
                wordData[4] = rs.getString("example_kr");
                wordData[5] = String.valueOf(rs.getInt("japanese_id")); // store japanese_id as string
                wordsList.add(wordData);
            }
        }
    }
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
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="pragma" content="no-cache" />
<meta name="Description" content="검색 엔진을 위해 웹 페이지에 대한 설명을 명시" />
<meta name="keywords" content="검색 엔진을 위해 웹 페이지와 관련된 키워드 목록을 콤마로 구분해서 명시" />
<meta name="Author" content="문서의 저자를 명시" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>당고링고</title>
<link rel="stylesheet" href="CSS/words_study.css" />
<style type="text/css">
/* 스타일시트 */
</style>
<script type="text/javascript">
  // 페이지 초기화 함수 (예: 페이지 로드 완료 시 호출)
</script>
<script type="text/javascript" src="JS/Basic.js"></script>
</head>
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
         입력필드
----------------------------------------------------------------------%>
<main class="content">
   <div class="result-box">
      <div class="progress">
         <!-- 학습한 단어 수와 타이머 표시 -->
         <span id="learnedWordsCount"><%= learnedWordsCount %>/50</span> <span id="timer">0분 0초</span>
         <div class="Exit_button" onclick="goBack()">
            <!-- 뒤로가기 버튼 아이콘 -->
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18" fill="none">
               <path d="M7.09 12.59L8.5 14L13.5 9L8.5 4L7.09 5.41L9.67 8H0V10H9.67L7.09 12.59ZM16 0H2C0.89 0 0 0.9 0 2V6H2V2H16V16H2V12H0V16C0 17.1 0.89 18 2 18H16C17.1 18 18 17.1 18 16V2C18 0.9 17.1 0 16 0Z" fill="white" />
            </svg>
         </div>
      </div>
      <% if (!wordsList.isEmpty()) { %>
      <!-- 첫 번째 단어 표시 -->
      <div class="kangji" id="kanji"><%= wordsList.get(0)[0] %></div>
      <div class="hurigana invisible" id="hiragana"><%= wordsList.get(0)[1] %></div>
      <div class="kangi_kr invisible" id="kanjiKr"><%= wordsList.get(0)[2] %></div>
      <div class="example invisible" id="example"><%= wordsList.get(0)[3] %></div>
      <div class="example_kr invisible" id="exampleKr"><%= wordsList.get(0)[4] %></div>
      <% } else { %>
      <!-- 기본 단어 표시 (단어 목록이 비어 있을 경우) -->
      <div class="kangji" id="kanji">食べる</div>
      <div class="hurigana invisible" id="hiragana">たべる</div>
      <div class="kangi_kr invisible" id="kanjiKr">먹다</div>
      <div class="example invisible" id="example">ご飯を食べる</div>
      <div class="example_kr invisible" id="exampleKr">밥을 먹다</div>
      <% } %>
      <div class="buttons">
         <!-- Update button classes -->
         <button class="study-toggle-btn" onclick="toggleVisibility('hurigana')">あ</button>
         <button class="study-toggle-btn" onclick="toggleVisibility('kangi_kr')">韓</button>
         <button class="study-toggle-btn" onclick="toggleVisibility('example', 'example_kr')">例</button>
      </div>
      <div class="memorized-buttons">
         <!-- 학습 상태 변경 버튼 -->
         <button type="button" class="forgot" onclick="handleForgot()">몰라요</button>
         <button type="button" class="memorized" onclick="handleMemorized()">외웠어요</button>
      </div>
      <div class="Play_Sound" onclick="playSound()">
         <!-- 소리 재생 버튼 아이콘 -->
         <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 32 32" fill="none">
            <path d="M4 12V20H9.33333L16 26.6666V5.33331L9.33333 12H4ZM22 16C22 13.64 20.64 11.6133 18.6667 10.6266V21.36C20.64 20.3866 22 18.36 22 16ZM18.6667 4.30664V7.05331C22.52 8.19997 25.3333 11.7733 25.3333 16C25.3333 20.2266 22.52 23.8 18.6667 24.9466V27.6933C24.0133 26.48 28 21.7066 28 16C28 10.2933 24.0133 5.51997 18.6667 4.30664Z" fill="black" />
         </svg>
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
   [자바스트립트 코드 - START]
--------------------------------------------------------------------------%>
<script type="text/javascript">
  // 학습 상태를 추적하는 변수 초기화
  let forgotCount = 0;
  let memorizedCount = 0;
  let currentIndex = 0;
  const totalWords = 50;
  // 1) Declare the array before referencing it
  const wordsList = [
    <% for (String[] word : wordsList) { %>
      ["<%= word[0] %>", "<%= word[1] %>", "<%= word[2] %>", "<%= word[3] %>", "<%= word[4] %>", <%= word[5] %>],
    <% } %>
  ];
  // 2) Now use wordsList safely
  let localJapaneseId = wordsList.length ?  parseInt(<%= wordsId %>) : 1; // Example or any default

//학습 단어 수를 업데이트하고 목표 달성 여부 확인
  /**
   * updateLearnedWordsCount: 학습 단어 개수를 업데이트하고 목표치 도달 시 처리 로직을 수행합니다.
   */
  function updateLearnedWordsCount() {
    const learnedWordsCount = forgotCount + memorizedCount;
    document.getElementById('learnedWordsCount').innerText = learnedWordsCount + '/50';
    if (learnedWordsCount >= 50) {
      disableButtons();
      navigateToFinalPage();
    }
  }

  // 단어 상태 변경 버튼 비활성화
  /**
   * 단어 상태 변경 버튼을 비활성화하여 더 이상 클릭할 수 없도록 합니다.
   */
  function disableButtons() {
    document.querySelectorAll('.forgot, .memorized').forEach(button => {
      button.disabled = true;
    });
  }

  // 사용자가 단어를 잊었을 때 처리
  /**
   * handleForgot: 사용자가 '몰라요' 버튼을 눌렀을 때 학습 상태를 저장하고 다음 단어로 이동합니다.
   */
  function handleForgot() {
    updateSession('N'); // Add session update with 'N'
    forgotCount++;
    updateLearnedWordsCount();
    currentIndex++;
    document.querySelector('.hurigana').classList.add('invisible');
    document.querySelector('.kangi_kr').classList.add('invisible');
    document.querySelector('.example').classList.add('invisible');
    document.querySelector('.example_kr').classList.add('invisible');
    if (currentIndex < wordsList.length) {
      displayWord(currentIndex);
    } else {
      // ...no more words, handle finish...
    }
  }

  // 사용자가 단어를 암기했을 때 처리
  /**
   * handleMemorized: 사용자가 '외웠어요' 버튼을 눌렀을 때 학습 상태를 저장하고 다음 단어로 이동합니다.
   */
  function handleMemorized() {
    updateSession('Y'); // Add session update with 'Y'
    memorizedCount++;
    updateLearnedWordsCount();
    currentIndex++;
    document.querySelector('.hurigana').classList.add('invisible');
    document.querySelector('.kangi_kr').classList.add('invisible');
    document.querySelector('.example').classList.add('invisible');
    document.querySelector('.example_kr').classList.add('invisible');
    if (currentIndex < wordsList.length) {
      displayWord(currentIndex);
    } else {
      // ...no more words, handle finish...
    }
  }



  // 학습 세션 종료 시 최종 페이지로 이동
  function navigateToFinalPage() {
    const timerText = document.getElementById('timer').innerText;
    window.location.href = 'Words_Final.jsp?timer=' + encodeURIComponent(timerText) + 
                           '&memorizedCount=' + memorizedCount + 
                           '&forgotCount=' + forgotCount +
                           '&japaneseId=' + wordsList[currentIndex][5]; // Add localJapaneseId to URL parameters
  }

  // 현재 단어를 화면에 표시
  function displayWord(index) {
    document.getElementById('kanji').innerText = wordsList[index][0];
    document.getElementById('hiragana').innerText = wordsList[index][1];
    document.getElementById('kanjiKr').innerText = wordsList[index][2];
    document.getElementById('example').innerText = wordsList[index][3];
    document.getElementById('exampleKr').innerText = wordsList[index][4];
  }

  // 이전 페이지로 돌아가기
  function goBack() {
    window.location.href = '<%= request.getContextPath() %>/JspHome/Words/Words.jsp';
  }

  // 특정 클래스의 요소 가시성 토글
  function toggleVisibility(...classNames) {
    classNames.forEach(className => {
      const element = document.querySelector('.' + className);
      if (element) {
        element.classList.toggle('invisible');
      }
    });
  }

  // 텍스트-음성 변환(TTS)으로 한자 발음 재생
  function playSound() {
    const kanjiText = document.getElementById('kanji').innerText;
    const utterance = new SpeechSynthesisUtterance(kanjiText);
    utterance.lang = 'ja-JP'; 
    window.speechSynthesis.speak(utterance);
  }

  // 학습 세션 타이머 설정
  let timerInterval;
  let minutes = 0;
  let seconds = 0;

  // 페이지 로드 시 타이머 시작
  function startTimer() {
    timerInterval = setInterval(() => {
      seconds++;
      if (seconds === 60) {
        seconds = 0;
        minutes++;
      }
      document.getElementById('timer').innerText = minutes + '분 ' + seconds + '초';
    }, 1000);
  }

  // Add function to update TB_SESSION
  /**
   * updateSession: 현재 학습 상태(N/Y)를 서버 서블릿에 전달하여 DB를 갱신합니다.
   */
  function updateSession(status) {
    const userId = <%=userId %>; // Replace with actual user ID
    const wordsId = <%=wordsId %>; // Replace with actual words ID
    const currentJapaneseId = wordsList[currentIndex][5];

    const xhr = new XMLHttpRequest();
    xhr.open('POST', '<%= request.getContextPath() %>/UpdateSession', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                console.log('Study session updated successfully');
            } else {
                console.error('Error updating study session');
            }
        }
    };

    const params = "userId=" + userId + 
                  "&wordsId=" + wordsId + 
                  "&japaneseId=" + currentJapaneseId + 
                  "&status=" + status;
    xhr.send(params);
  }

  window.onload = function() {
    startTimer();
  }
</script>
<%----------------------------------------------------------------------
   [자바스크립트 Code - END]
--------------------------------------------------------------------------%>
</body>
</html>
