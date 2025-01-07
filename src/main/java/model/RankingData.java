package model;

public class RankingData {
    private String name;
    private String subtitle;
    private int words;
    private int points;
    private int dangos;
    
    public RankingData(String name, String subtitle, int words, int points, int dangos) {
        this.name = name;
        this.subtitle = subtitle;
        this.words = words;
        this.points = points;
        this.dangos = dangos;
    }
    
    public String getName() { return name; }
    public String getSubtitle() { return subtitle; }
    public int getWords() { return words; }
    public int getPoints() { return points; }
    public int getDangos() { return dangos; }
    
    public int getValue(String type) {
        switch(type) {
            case "words": return words;
            case "points": return points;
            case "dangos": return dangos;
            default: return 0;
        }
    }
} 