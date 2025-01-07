package model;

import java.util.Date;

public class UserDTO {
    private int userId;
    private String email;
    private String password;
    private String name;
    private String nickname;
    private String intro;
    private String profileImage;
    private Date studyDate;
    private Date studyTime;
    private int studyDay;
    private int quizCount;
    private int quizRight;
    private int point;
    private int dangos;

    // 생성자
    public UserDTO() {}
    
    // Getter와 Setter
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }

    public String getIntro() { return intro; }
    public void setIntro(String intro) { this.intro = intro; }

    public String getProfileImage() { return profileImage; }
    public void setProfileImage(String profileImage) { this.profileImage = profileImage; }

    public Date getStudyDate() { return studyDate; }
    public void setStudyDate(Date studyDate) { this.studyDate = studyDate; }

    public Date getStudyTime() { return studyTime; }
    public void setStudyTime(Date studyTime) { this.studyTime = studyTime; }

    public int getStudyDay() { return studyDay; }
    public void setStudyDay(int studyDay) { this.studyDay = studyDay; }

    public int getQuizCount() { return quizCount; }
    public void setQuizCount(int quizCount) { this.quizCount = quizCount; }

    public int getQuizRight() { return quizRight; }
    public void setQuizRight(int quizRight) { this.quizRight = quizRight; }

    public int getPoint() { return point; }
    public void setPoint(int point) { this.point = point; }

    public int getDangos() { return dangos; }
    public void setDangos(int dangos) { this.dangos = dangos; }
} 