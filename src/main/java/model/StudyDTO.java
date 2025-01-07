package model;

import java.util.Date;

public class StudyDTO {
    private int studyId;
    private int userId;
    private Date studyDate;
    private int studyCount;  // 해당 날짜의 학습 횟수
    private int studyLevel;  // 학습 레벨 (0-4)
    
    // 생성자
    public StudyDTO() {}
    
    // Getter/Setter
    public int getStudyId() { return studyId; }
    public void setStudyId(int studyId) { this.studyId = studyId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public Date getStudyDate() { return studyDate; }
    public void setStudyDate(Date studyDate) { this.studyDate = studyDate; }
    
    public int getStudyCount() { return studyCount; }
    public void setStudyCount(int studyCount) { this.studyCount = studyCount; }
    
    public int getStudyLevel() { return studyLevel; }
    public void setStudyLevel(int studyLevel) { this.studyLevel = studyLevel; }
} 