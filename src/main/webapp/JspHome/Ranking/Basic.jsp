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
        // 랭킹 데이터를 저장할 객체
        const rankingData = {
            words: [], // 학습 단어 랭킹 데이터
            points: [], // 누적 포인트 랭킹 데이터
            dangos: []  // 당고 수집 랭킹 데이터
        };

        // 초기 데이터 로드
        function loadRankingData() {
            // 목업 데이터
            const mockData = [
                { name: "하리보", subtitle: "공부는 이제 그만", words: 2483, points: 2483, dangos: 2483 },
                { name: "헤나뼈", subtitle: "일본 여행 좋아~", words: 2179, points: 2179, dangos: 2179 },
                { name: "김초심", subtitle: "초심을 되찾자", words: 2135, points: 2135, dangos: 2135 },
                { name: "암기왕", subtitle: "다 외울 때까지 숨 참음", words: 1924, points: 1924, dangos: 1924 },
                { name: "원피스", subtitle: "보물 찾기 동료 구함", words: 1897, points: 1897, dangos: 1897 },
                { name: "당고마스터", subtitle: "당고를 먹으며 공부중", words: 1756, points: 1756, dangos: 1756 },
                { name: "일본어초보", subtitle: "열심히 배우는 중", words: 1634, points: 1634, dangos: 1634 },
                { name: "애니매니아", subtitle: "자막없이 보는 그날까지", words: 1589, points: 1589, dangos: 1589 },
                { name: "도쿄여행러", subtitle: "여행 준비중", words: 1445, points: 1445, dangos: 1445 },
                { name: "JLPT고수", subtitle: "N1 준비중", words: 1398, points: 1398, dangos: 1398 },
                { name: "만화책읽는중", subtitle: "원서 정복!", words: 1287, points: 1287, dangos: 1287 },
                { name: "일본문화러버", subtitle: "문화로 배우는 일본어", words: 1156, points: 1156, dangos: 1156 },
                { name: "게임번역가", subtitle: "게임으로 배우는 중", words: 1089, points: 1089, dangos: 1089 },
                { name: "오사카여행", subtitle: "타코야키 먹으러 갈래요", words: 987, points: 987, dangos: 987 },
                { name: "일드매니아", subtitle: "드라마로 배우는 일본어", words: 923, points: 923, dangos: 923 },
                { name: "스시좋아", subtitle: "먹방으로 배우는 일본어", words: 867, points: 867, dangos: 867 },
                { name: "교토구경", subtitle: "전통문화 탐방중", words: 812, points: 812, dangos: 812 },
                { name: "J팝러버", subtitle: "노래로 배우는 일본어", words: 756, points: 756, dangos: 756 },
                { name: "라멘마스터", subtitle: "라멘집 투어중", words: 701, points: 701, dangos: 701 },
                { name: "후지산등반", subtitle: "정상에서 만나요", words: 645, points: 645, dangos: 645 }
            ];

            // 각 카테고리별로 데이터 복사 및 정렬
            rankingData.words = [...mockData].sort((a, b) => b.words - a.words);
            rankingData.points = [...mockData].sort((a, b) => b.points - a.points);
            rankingData.dangos = [...mockData].sort((a, b) => b.dangos - a.dangos);
        }

        // 단위 표시 함수
        function getUnit(type) {
            switch(type) {
                case 'words': return '단어';
                case 'points': return 'pt';
                case 'dangos': return '개';
                default: return '';
            }
        }

        // 랭킹 섹션 업데이트
        function updateRankingSection(type) {
            const data = rankingData[type];
            const section = document.getElementById(`${type}-ranking`);
            const unit = getUnit(type);
            
            // 상위 3등 업데이트
            const topRankersHtml = `
                <div class="top-rank second">
                    <div class="crown">🥈</div>
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                    <div class="user-details">
                        <div class="user-name">${data[1].name}</div>
                        <div class="user-subtitle">${data[1].subtitle}</div>
                        <div class="user-points">${data[1][type].toLocaleString()} ${unit}</div>
                    </div>
                </div>
                <div class="top-rank first">
                    <div class="crown">👑</div>
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                    <div class="user-details">
                        <div class="user-name">${data[0].name}</div>
                        <div class="user-subtitle">${data[0].subtitle}</div>
                        <div class="user-points">${data[0][type].toLocaleString()} ${unit}</div>
                    </div>
                </div>
                <div class="top-rank third">
                    <div class="crown">🥉</div>
                    <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                    <div class="user-details">
                        <div class="user-name">${data[2].name}</div>
                        <div class="user-subtitle">${data[2].subtitle}</div>
                        <div class="user-points">${data[2][type].toLocaleString()} ${unit}</div>
                    </div>
                </div>
            `;
            section.querySelector('.top-rankers').innerHTML = topRankersHtml;

            // 나머지 순위 업데이트 (4-20등)
            const rankingListHtml = data.slice(3).map((user, index) => `
                <div class="ranking-item">
                    <div class="rank-number">${index + 4}</div>
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/JspHome/Main/images/dango-profile.png" alt="프로필" class="profile-image">
                        <div class="user-details">
                            <div class="user-name">${user.name}</div>
                            <div class="user-subtitle">${user.subtitle}</div>
                        </div>
                    </div>
                    <div class="user-points">${user[type].toLocaleString()} ${unit}</div>
                </div>
            `).join('');
            section.querySelector('.ranking-list').innerHTML = rankingListHtml;
        }

        // 페이지 로드 시 초기 데이터 로드 및 표시
        window.addEventListener('load', () => {
            loadRankingData();
            updateRankingSection('words');
        });

        // 탭 전환 이벤트
        document.querySelectorAll('.tab-button').forEach(button => {
            button.addEventListener('click', () => {
                const type = button.dataset.tab;
                
                document.querySelectorAll('.tab-button').forEach(btn => {
                    btn.classList.remove('active');
                });
                button.classList.add('active');

                document.querySelectorAll('.ranking-section').forEach(section => {
                    section.classList.remove('active');
                });
                document.getElementById(`${type}-ranking`).classList.add('active');

                updateRankingSection(type);
            });
        });
    </script>
</body>
</html>
