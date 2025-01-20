package Mock;

import BeansHome.Ranking.RankingDTO;
import BeansHome.User.UserDTO;
import BeansHome.Study.StudyDTO;

import java.util.*;
import java.util.Calendar;
import java.sql.Date;

// ═════════════════════════════════════════════════════════════════════════════════════════
// 사용자정의 클래스 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
 * MockDataManager : 목업 데이터 관리 클래스<br>
 * Inheritance    : None
 ***********************************************************************/
public class MockDataManager {
    private static final MockDataManager instance = new MockDataManager();
    private List<UserDTO> mockUsers;
    private Map<Integer, List<StudyDTO>> mockStreaks;
    
    private MockDataManager() {
        initializeMockData();
        initializeStreakData();
    }
    
    public static MockDataManager getInstance() {
        return instance;
    }
    
    private void initializeMockData() {
        mockUsers = new ArrayList<>();
        
        // 목업 사용자 데이터 생성
        String[] nicknames = {"하리보", "헤나뼈", "김초심", "암기왕", "원피스", "당고마스터", "일본어초보", "애니매니아", "도쿄여행러", "JLPT고수"};
        String[] intros = {
            "공부는 이제 그만", "일본 여행 좋아~", "초심을 되찾자", "다 외울 때까지 숨 참음",
            "보물 찾기 동료 구함", "당고를 먹으며 공부중", "열심히 배우는 중", "자막없이 보는 그날까지",
            "여행 준비중", "N1 준비중"
        };
        String[] profileImages = {
            "dango-profile-1.png", "dango-profile-2.png", "dango-profile-3.png", "dango-profile-4.png", "dango-profile-5.png",
            "dango-profile-6.png", "dango-profile-7.png", "dango-profile-8.png", "dango-profile-9.png", "dango-profile-10.png"
        };
        
        for (int i = 0; i < 10; i++) {
            UserDTO user = new UserDTO();
            user.setUserId(i + 1);
            user.setEmail("user" + (i + 1) + "@example.com");
            user.setName("사용자" + (i + 1));
            user.setNickname(nicknames[i]);
            user.setIntro(intros[i]);
            user.setStudyDay(30 - i);
            user.setQuizCount(100 + (i * 10));
            user.setQuizRight(80 + (i * 8));
            user.setPoint(1000 + (i * 100));
            
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DAY_OF_MONTH, -i);
            
            // studyTime을 초 단위로 설정 (현재 시간 - i시간)
            cal.add(Calendar.HOUR, -i);
            user.setStudyTime((int)(cal.getTimeInMillis() / 1000));
            
            // 오늘 날짜로 설정
            user.setStudyDate(new Date(cal.getTimeInMillis()));
            
            mockUsers.add(user);
        }
    }
    
    private void initializeStreakData() {
        mockStreaks = new HashMap<>();
        
        // 각 사용자별로 최근 52주 데이터 생성
        for (UserDTO user : mockUsers) {
            List<StudyDTO> userStreaks = new ArrayList<>();
            Calendar cal = Calendar.getInstance();
            
            // 52주 x 7일 데이터 생성
            for (int i = 364; i >= 0; i--) {
                StudyDTO study = new StudyDTO();
                study.setUserId(user.getUserId());
                
                cal.add(Calendar.DAY_OF_YEAR, -1);
                study.setStudyDate(new Date(cal.getTimeInMillis()));
                
                // 랜덤하게 학습 데이터 생성
                if (Math.random() < 0.7) {  // 70% 확률로 학습함
                    int count = (int)(Math.random() * 5) + 1;  // 1-5회
                    study.setStudyCount(count);
                    study.setStudyLevel(Math.min((count-1), 4));  // 0-4 레벨
                } else {
                    study.setStudyCount(0);
                    study.setStudyLevel(0);
                }
                
                userStreaks.add(study);
            }
            
            mockStreaks.put(user.getUserId(), userStreaks);
        }
    }
    
    public List<StudyDTO> getStudyStreak(int userId) {
        return mockStreaks.getOrDefault(userId, new ArrayList<>());
    }
    
    public UserDTO getCurrentUser() {
        return mockUsers.get(0);
    }
    
    public int getUserRank(int userId, String type) {
        List<UserDTO> rankings = getRankingList(type, mockUsers.size());
        for (int i = 0; i < rankings.size(); i++) {
            if (rankings.get(i).getUserId() == userId) {
                return i + 1;
            }
        }
        return rankings.size();
    }
    
    public int getTotalUsers() {
        return mockUsers.size();
    }
    
    public List<UserDTO> getRankingList(String type, int limit) {
        List<UserDTO> sortedUsers = new ArrayList<>(mockUsers);

        Comparator<UserDTO> comparator;
        switch (type) {
            case "words":
                comparator = Comparator.comparing(UserDTO::getQuizRight).reversed();
                break;
            case "points":
                comparator = Comparator.comparing(UserDTO::getPoint).reversed();
                break;
            default:
                comparator = Comparator.comparing(UserDTO::getPoint).reversed();
                break;
        }


        sortedUsers.sort(comparator);
        return sortedUsers.subList(0, Math.min(limit, sortedUsers.size()));
    }
    
    // 랭킹 목록 조회
    public List<RankingDTO> getRankings(String type, int limit) {
        List<RankingDTO> rankings = new ArrayList<>();
        List<UserDTO> users = getRankingList(type, limit);
        
        for (int i = 0; i < users.size(); i++) {
            UserDTO user = users.get(i);
            RankingDTO ranking = new RankingDTO();
            ranking.setRank(i + 1);
            ranking.setUserId(user.getUserId());
            ranking.setNickname(user.getNickname());
            ranking.setIntro(user.getIntro());
            ranking.setScore(getScoreByType(user, type));
            ranking.setType(type);
            rankings.add(ranking);
        }
        
        return rankings;
    }
    
    private int getScoreByType(UserDTO user, String type) {
        int result;
        switch (type) {
            case "words":
                result = user.getQuizRight();
                break;
            case "points":
                result = user.getPoint();
                break;
            default:
                result = user.getPoint();
                break;
        }
        return result;

    }
} 