package BeansHome;

public class RankingDTO {
    private int rank;           // 순위
    private int userId;         // 사용자 ID
    private String nickname;    // 닉네임
    private String profileImage;// 프로필 이미지
    private int score;         // 점수 (포인트/학습일수/퀴즈정답)
    private String type;       // 랭킹 타입 (words/points/dangos)
    
    // 생성자
    public RankingDTO() {}
    
    // Getter/Setter
    public int getRank() { return rank; }
    public void setRank(int rank) { this.rank = rank; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }
    
    public String getProfileImage() { return profileImage; }
    public void setProfileImage(String profileImage) { this.profileImage = profileImage; }
    
    public int getScore() { return score; }
    public void setScore(int score) { this.score = score; }
    
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
} 