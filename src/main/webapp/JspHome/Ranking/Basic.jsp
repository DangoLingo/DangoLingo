<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // ---------------------------------------------------------------------
    // [JSP 지역 변수 선언 : 랭킹 관련 클래스 정의]
    // ---------------------------------------------------------------------
    class RankingData {
        String name;
        String subtitle;
        int value;
        
        RankingData(String name, String subtitle, int value) {
            this.name = name;
            this.subtitle = subtitle;
            this.value = value;
        }
    }

    // ---------------------------------------------------------------------
    // [JSP 지역 변수 선언 : 목업 데이터 생성]
    // ---------------------------------------------------------------------
    // 랭킹 데이터 생성
    RankingData[] rankingData = {
        new RankingData("하리보", "공부는 이제 그만", 2483),
        new RankingData("헤나뼈", "일본 여행 좋아~", 2179),
        new RankingData("김초심", "초심을 되찾자", 2135),
        new RankingData("암기왕", "다 외울 때까지 숨 참음", 1924),
        new RankingData("원피스", "보물 찾기 동료 구함", 1897),
        new RankingData("당고마스터", "당고를 먹으며 공부중", 1756),
        new RankingData("일본어초보", "열심히 배우는 중", 1634),
        new RankingData("애니매니아", "자막없이 보는 그날까지", 1589),
        new RankingData("도쿄여행러", "여행 준비중", 1445),
        new RankingData("JLPT고수", "N1 준비중", 1398)
    };

    // ---------------------------------------------------------------------
    // [JSP 지역 변수 선언 : 탭 관련 클래스 정의]
    // ---------------------------------------------------------------------
    class TabInfo {
        String id;
        String title;
        String unit;
        
        TabInfo(String id, String title, String unit) {
            this.id = id;
            this.title = title;
            this.unit = unit;
        }
    }

    // ---------------------------------------------------------------------
    // [JSP 지역 변수 선언 : 탭 데이터 생성]
    // ---------------------------------------------------------------------
    TabInfo[] tabs = {
        new TabInfo("words", "학습 단어", "단어"),
        new TabInfo("points", "누적 포인트", "pt"),
        new TabInfo("dangos", "당고 수집", "개")
    };
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%----------------------------------------------------------------------
    [HTML Page - 헤드 영역]
    --------------------------------------------------------------------------%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>당고링고 - 랭킹</title>
    <%----------------------------------------------------------------------
    [HTML Page - 스타일쉬트 구현 영역]
    --------------------------------------------------------------------------%>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-jp.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Ranking/css/ranking.css">
</head>
<body>
    <%----------------------------------------------------------------------
    [HTML Page - 헤더 영역]
    --------------------------------------------------------------------------%>
    <header>
        <jsp:include page="../Common/Navbar.jsp" />
    </header>

    <%----------------------------------------------------------------------
    [HTML Page - 메인 컨텐츠 영역]
    --------------------------------------------------------------------------%>
    <main class="main-container">
        <%------------------------------------------------------------------
        탭 버튼 영역
        -------------------------------------------------------------------%>
        <div class="ranking-tabs">
            <% for(TabInfo tab : tabs) { %>
                <button class="tab-button <%= tab.id.equals("words") ? "active" : "" %>" 
                        data-tab="<%= tab.id %>"><%= tab.title %></button>
            <% } %>
        </div>

        <%------------------------------------------------------------------
        랭킹 섹션 영역
        -------------------------------------------------------------------%>
        <% for(TabInfo tab : tabs) { %>
            <section class="ranking-section <%= tab.id.equals("words") ? "active" : "" %>" 
                     id="<%= tab.id %>-ranking">
                <%------------------------------------------------------------------
                상위 3등 표시 영역
                -------------------------------------------------------------------%>
                <div class="top-rankers">
                    <!-- 2등 -->
                    <div class="top-rank second">
                        <div class="crown">🥈</div>
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name"><%= rankingData[1].name %></div>
                            <div class="user-subtitle"><%= rankingData[1].subtitle %></div>
                            <div class="user-points"><%= String.format("%,d", rankingData[1].value) %> <%= tab.unit %></div>
                        </div>
                    </div>
                    <!-- 1등 -->
                    <div class="top-rank first">
                        <div class="crown">👑</div>
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name"><%= rankingData[0].name %></div>
                            <div class="user-subtitle"><%= rankingData[0].subtitle %></div>
                            <div class="user-points"><%= String.format("%,d", rankingData[0].value) %> <%= tab.unit %></div>
                        </div>
                    </div>
                    <!-- 3등 -->
                    <div class="top-rank third">
                        <div class="crown">🥉</div>
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name"><%= rankingData[2].name %></div>
                            <div class="user-subtitle"><%= rankingData[2].subtitle %></div>
                            <div class="user-points"><%= String.format("%,d", rankingData[2].value) %> <%= tab.unit %></div>
                        </div>
                    </div>
                </div>

                <%------------------------------------------------------------------
                4-10등 표시 영역
                -------------------------------------------------------------------%>
                <div class="ranking-list">
                    <% for(int i = 3; i < rankingData.length; i++) { %>
                        <div class="ranking-item">
                            <div class="rank-number"><%= i + 1 %></div>
                            <div class="user-info">
                                <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                                <div class="user-details">
                                    <div class="user-name"><%= rankingData[i].name %></div>
                                    <div class="user-subtitle"><%= rankingData[i].subtitle %></div>
                                </div>
                            </div>
                            <div class="user-points"><%= String.format("%,d", rankingData[i].value) %> <%= tab.unit %></div>
                        </div>
                    <% } %>
                </div>
            </section>
        <% } %>
    </main>

    <%----------------------------------------------------------------------
    [HTML Page - 푸터 영역]
    --------------------------------------------------------------------------%>
    <footer>
        <jsp:include page="../Common/Footer.jsp" />
    </footer>

    <%----------------------------------------------------------------------
    [HTML Page - 자바스크립트 구현 영역]
    --------------------------------------------------------------------------%>
    <script>
        // ---------------------------------------------------------------------
        // [탭 전환 이벤트 처리]
        // ---------------------------------------------------------------------
        document.querySelectorAll('.tab-button').forEach(button => {
            button.addEventListener('click', () => {
                const type = button.dataset.tab;
                
                // 탭 버튼 활성화 상태 변경
                document.querySelectorAll('.tab-button').forEach(btn => {
                    btn.classList.remove('active');
                });
                button.classList.add('active');

                // 랭킹 섹션 표시 상태 변경
                document.querySelectorAll('.ranking-section').forEach(section => {
                    section.classList.remove('active');
                });
                document.getElementById(`${type}-ranking`).classList.add('active');
            });
        });
    </script>
</body>
</html>
