<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>당고링고 - 랭킹</title>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-jp.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/JspHome/Ranking/css/ranking.css">
</head>
<body>
    <header>
        <jsp:include page="../Common/Navbar.jsp" />
    </header>

    <main class="main-container">
        <!-- 탭 버튼 -->
        <div class="ranking-tabs">
            <button class="tab-button active" data-tab="words">학습 단어</button>
            <button class="tab-button" data-tab="points">누적 포인트</button>
            <button class="tab-button" data-tab="dangos">당고 수집</button>
        </div>

        <!-- 학습 단어 랭킹 -->
        <section class="ranking-section active" id="words-ranking">
            <h2 class="ranking-title">학습 단어</h2>
            <!-- 상위 3등 -->
            <div class="top-rankers">
                <!-- 2등 -->
                <div class="top-rank second">
                    <div class="crown">🥈</div>
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                    <div class="user-details">
                        <div class="user-name">헤나뼈</div>
                        <div class="user-subtitle">일본 여행 좋아~</div>
                        <div class="user-points">2,179 단어</div>
                    </div>
                </div>
                <!-- 1등 -->
                <div class="top-rank first">
                    <div class="crown">👑</div>
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                    <div class="user-details">
                        <div class="user-name">하리보</div>
                        <div class="user-subtitle">공부는 이제 그만</div>
                        <div class="user-points">2,483 단어</div>
                    </div>
                </div>
                <!-- 3등 -->
                <div class="top-rank third">
                    <div class="crown">🥉</div>
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                    <div class="user-details">
                        <div class="user-name">김초심</div>
                        <div class="user-subtitle">초심을 되찾자</div>
                        <div class="user-points">2,135 단어</div>
                    </div>
                </div>
            </div>
            <!-- 나머지 순위 -->
            <div class="ranking-list">
                <!-- 4-5등은 유지하고 6-20등 추가 -->
                <div class="ranking-item">
                    <div class="rank-number">6</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">당고마스터</div>
                            <div class="user-subtitle">당고를 먹으며 공부중</div>
                        </div>
                    </div>
                    <div class="user-points">1,756 단어</div>
                </div>

                <div class="ranking-item">
                    <div class="rank-number">7</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">일본어초보</div>
                            <div class="user-subtitle">열심히 배우는 중</div>
                        </div>
                    </div>
                    <div class="user-points">1,634 단어</div>
                </div>

                <div class="ranking-item">
                    <div class="rank-number">8</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">애니매니아</div>
                            <div class="user-subtitle">자막없이 보는 그날까지</div>
                        </div>
                    </div>
                    <div class="user-points">1,589 단어</div>
                </div>

                <!-- 9-20등 추가 -->
                <div class="ranking-item">
                    <div class="rank-number">9</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">도쿄여행러</div>
                            <div class="user-subtitle">여행 준비중</div>
                        </div>
                    </div>
                    <div class="user-points">1,445 단어</div>
                </div>

                <div class="ranking-item">
                    <div class="rank-number">10</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">JLPT고수</div>
                            <div class="user-subtitle">N1 준비중</div>
                        </div>
                    </div>
                    <div class="user-points">1,398 단어</div>
                </div>

                <!-- 11-20등 -->
                <div class="ranking-item">
                    <div class="rank-number">11</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">만화책읽는중</div>
                            <div class="user-subtitle">원서 정복!</div>
                        </div>
                    </div>
                    <div class="user-points">1,287 단어</div>
                </div>

                <!-- 12-20등 추가 -->
                <div class="ranking-item">
                    <div class="rank-number">12</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">일본문화러버</div>
                            <div class="user-subtitle">문화로 배우는 일본어</div>
                        </div>
                    </div>
                    <div class="user-points">1,156 단어</div>
                </div>

                <div class="ranking-item">
                    <div class="rank-number">13</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">게임번역가</div>
                            <div class="user-subtitle">게임으로 배우는 중</div>
                        </div>
                    </div>
                    <div class="user-points">1,089 단어</div>
                </div>

                <div class="ranking-item">
                    <div class="rank-number">14</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">오사카여행</div>
                            <div class="user-subtitle">타코야키 먹으러 갈래요</div>
                        </div>
                    </div>
                    <div class="user-points">987 단어</div>
                </div>

                <div class="ranking-item">
                    <div class="rank-number">15</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">일드매니아</div>
                            <div class="user-subtitle">드라마로 배우는 일본어</div>
                        </div>
                    </div>
                    <div class="user-points">923 단어</div>
                </div>

                <div class="ranking-item">
                    <div class="rank-number">16</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">스시좋아</div>
                            <div class="user-subtitle">먹방으로 배우는 일본어</div>
                        </div>
                    </div>
                    <div class="user-points">867 단어</div>
                </div>

                <div class="ranking-item">
                    <div class="rank-number">17</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">교토구경</div>
                            <div class="user-subtitle">전통문화 탐방중</div>
                        </div>
                    </div>
                    <div class="user-points">812 단어</div>
                </div>

                <div class="ranking-item">
                    <div class="rank-number">18</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">J팝러버</div>
                            <div class="user-subtitle">노래로 배우는 일본어</div>
                        </div>
                    </div>
                    <div class="user-points">756 단어</div>
                </div>

                <div class="ranking-item">
                    <div class="rank-number">19</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">라멘마스터</div>
                            <div class="user-subtitle">라멘집 투어중</div>
                        </div>
                    </div>
                    <div class="user-points">701 단어</div>
                </div>

                <div class="ranking-item">
                    <div class="rank-number">20</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">후지산등반</div>
                            <div class="user-subtitle">정상에서 만나요</div>
                        </div>
                    </div>
                    <div class="user-points">645 단어</div>
                </div>
            </div>
        </section>

        <!-- 누적 포인트 랭킹 -->
        <section class="ranking-section" id="points-ranking">
            <h2 class="ranking-title">누적 포인트</h2>
            <div class="top-rankers">
                <!-- 2등 -->
                <div class="top-rank second">
                    <div class="crown">🥈</div>
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                    <div class="user-details">
                        <div class="user-name">헤나뼈</div>
                        <div class="user-subtitle">일본 여행 좋아~</div>
                        <div class="user-points">2,179 pt</div>
                    </div>
                </div>
                <!-- 1등 -->
                <div class="top-rank first">
                    <div class="crown">👑</div>
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                    <div class="user-details">
                        <div class="user-name">하리보</div>
                        <div class="user-subtitle">공부는 이제 그만</div>
                        <div class="user-points">2,483 pt</div>
                    </div>
                </div>
                <!-- 3등 -->
                <div class="top-rank third">
                    <div class="crown">🥉</div>
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                    <div class="user-details">
                        <div class="user-name">김초심</div>
                        <div class="user-subtitle">초심을 되찾자</div>
                        <div class="user-points">2,135 pt</div>
                    </div>
                </div>
            </div>
            <!-- 나머지 순위 -->
            <div class="ranking-list">
                <div class="ranking-item">
                    <div class="rank-number">4</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">암기왕</div>
                            <div class="user-subtitle">다 외울 때까지 숨 참음</div>
                        </div>
                    </div>
                    <div class="user-points">1,924 pt</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">5</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">원피스</div>
                            <div class="user-subtitle">보물 찾기 동료 구함</div>
                        </div>
                    </div>
                    <div class="user-points">1,897 pt</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">6</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">당고마스터</div>
                            <div class="user-subtitle">당고를 먹으며 공부중</div>
                        </div>
                    </div>
                    <div class="user-points">1,756 pt</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">7</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">일본어초보</div>
                            <div class="user-subtitle">열심히 배우는 중</div>
                        </div>
                    </div>
                    <div class="user-points">1,634 pt</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">8</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">애니매니아</div>
                            <div class="user-subtitle">자막없이 보는 그날까지</div>
                        </div>
                    </div>
                    <div class="user-points">1,589 pt</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">9</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">도쿄여행러</div>
                            <div class="user-subtitle">여행 준비중</div>
                        </div>
                    </div>
                    <div class="user-points">1,445 pt</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">10</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">JLPT고수</div>
                            <div class="user-subtitle">N1 준비중</div>
                        </div>
                    </div>
                    <div class="user-points">1,398 pt</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">11</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">만화책읽는중</div>
                            <div class="user-subtitle">원서 정복!</div>
                        </div>
                    </div>
                    <div class="user-points">1,287 pt</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">12</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">일본문화러버</div>
                            <div class="user-subtitle">문화로 배우는 일본어</div>
                        </div>
                    </div>
                    <div class="user-points">1,156 pt</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">13</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">게임번역가</div>
                            <div class="user-subtitle">게임으로 배우는 중</div>
                        </div>
                    </div>
                    <div class="user-points">1,089 pt</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">14</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">오사카여행</div>
                            <div class="user-subtitle">타코야키 먹으러 갈래요</div>
                        </div>
                    </div>
                    <div class="user-points">987 pt</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">15</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">일드매니아</div>
                            <div class="user-subtitle">드라마로 배우는 일본어</div>
                        </div>
                    </div>
                    <div class="user-points">923 pt</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">16</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">스시좋아</div>
                            <div class="user-subtitle">먹방으로 배우는 일본어</div>
                        </div>
                    </div>
                    <div class="user-points">867 pt</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">17</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">교토구경</div>
                            <div class="user-subtitle">전통문화 탐방중</div>
                        </div>
                    </div>
                    <div class="user-points">812 pt</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">18</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">J팝러버</div>
                            <div class="user-subtitle">노래로 배우는 일본어</div>
                        </div>
                    </div>
                    <div class="user-points">756 pt</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">19</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">라멘마스터</div>
                            <div class="user-subtitle">라멘집 투어중</div>
                        </div>
                    </div>
                    <div class="user-points">701 pt</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">20</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">후지산등반</div>
                            <div class="user-subtitle">정상에서 만나요</div>
                        </div>
                    </div>
                    <div class="user-points">645 pt</div>
                </div>
            </div>
        </section>

        <!-- 당고 수집 랭킹 -->
        <section class="ranking-section" id="dangos-ranking">
            <h2 class="ranking-title">당고 수집</h2>
            <div class="top-rankers">
                <!-- 2등 -->
                <div class="top-rank second">
                    <div class="crown">🥈</div>
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                    <div class="user-details">
                        <div class="user-name">헤나뼈</div>
                        <div class="user-subtitle">일본 여행 좋아~</div>
                        <div class="user-points">2,179 개</div>
                    </div>
                </div>
                <!-- 1등 -->
                <div class="top-rank first">
                    <div class="crown">👑</div>
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                    <div class="user-details">
                        <div class="user-name">하리보</div>
                        <div class="user-subtitle">공부는 이제 그만</div>
                        <div class="user-points">2,483 개</div>
                    </div>
                </div>
                <!-- 3등 -->
                <div class="top-rank third">
                    <div class="crown">🥉</div>
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                    <div class="user-details">
                        <div class="user-name">김초심</div>
                        <div class="user-subtitle">초심을 되찾자</div>
                        <div class="user-points">2,135 개</div>
                    </div>
                </div>
            </div>
            <!-- 나머지 순위 -->
            <div class="ranking-list">
                <div class="ranking-item">
                    <div class="rank-number">4</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">암기왕</div>
                            <div class="user-subtitle">다 외울 때까지 숨 참음</div>
                        </div>
                    </div>
                    <div class="user-points">1,924 개</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">5</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">원피스</div>
                            <div class="user-subtitle">보물 찾기 동료 구함</div>
                        </div>
                    </div>
                    <div class="user-points">1,897 개</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">6</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">당고마스터</div>
                            <div class="user-subtitle">당고를 먹으며 공부중</div>
                        </div>
                    </div>
                    <div class="user-points">1,756 개</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">7</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">일본어초보</div>
                            <div class="user-subtitle">열심히 배우는 중</div>
                        </div>
                    </div>
                    <div class="user-points">1,634 개</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">8</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">애니매니아</div>
                            <div class="user-subtitle">자막없이 보는 그날까지</div>
                        </div>
                    </div>
                    <div class="user-points">1,589 개</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">9</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">도쿄여행러</div>
                            <div class="user-subtitle">여행 준비중</div>
                        </div>
                    </div>
                    <div class="user-points">1,445 개</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">10</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">JLPT고수</div>
                            <div class="user-subtitle">N1 준비중</div>
                        </div>
                    </div>
                    <div class="user-points">1,398 개</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">11</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">만화책읽는중</div>
                            <div class="user-subtitle">원서 정복!</div>
                        </div>
                    </div>
                    <div class="user-points">1,287 개</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">12</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">일본문화러버</div>
                            <div class="user-subtitle">문화로 배우는 일본어</div>
                        </div>
                    </div>
                    <div class="user-points">1,156 개</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">13</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">게임번역가</div>
                            <div class="user-subtitle">게임으로 배우는 중</div>
                        </div>
                    </div>
                    <div class="user-points">1,089 개</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">14</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">오사카여행</div>
                            <div class="user-subtitle">타코야키 먹으러 갈래요</div>
                        </div>
                    </div>
                    <div class="user-points">987 개</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">15</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">일드매니아</div>
                            <div class="user-subtitle">드라마로 배우는 일본어</div>
                        </div>
                    </div>
                    <div class="user-points">923 개</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">16</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">스시좋아</div>
                            <div class="user-subtitle">먹방으로 배우는 일본어</div>
                        </div>
                    </div>
                    <div class="user-points">867 개</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">17</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">교토구경</div>
                            <div class="user-subtitle">전통문화 탐방중</div>
                        </div>
                    </div>
                    <div class="user-points">812 개</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">18</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">J팝러버</div>
                            <div class="user-subtitle">노래로 배우는 일본어</div>
                        </div>
                    </div>
                    <div class="user-points">756 개</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">19</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">라멘마스터</div>
                            <div class="user-subtitle">라멘집 투어중</div>
                        </div>
                    </div>
                    <div class="user-points">701 개</div>
                </div>
                <div class="ranking-item">
                    <div class="rank-number">20</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">후지산등반</div>
                            <div class="user-subtitle">정상에서 만나요</div>
                        </div>
                    </div>
                    <div class="user-points">645 개</div>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <jsp:include page="../Common/Footer.jsp" />
    </footer>

    <script>
        document.querySelectorAll('.tab-button').forEach(button => {
            button.addEventListener('click', () => {
                // 모든 탭 버튼에서 active 클래스 제거
                document.querySelectorAll('.tab-button').forEach(btn => {
                    btn.classList.remove('active');
                });
                // 클릭된 탭 버튼에 active 클래스 추가
                button.classList.add('active');

                // 모든 랭킹 섹션 숨기기
                document.querySelectorAll('.ranking-section').forEach(section => {
                    section.classList.remove('active');
                });
                // 선택된 랭킹 섹션 보이기
                document.getElementById(`${button.dataset.tab}-ranking`).classList.add('active');
            });
        });
    </script>
</body>
</html>
