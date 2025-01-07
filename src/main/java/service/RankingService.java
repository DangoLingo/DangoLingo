package service;

import model.RankingData;
import java.util.*;

public class RankingService {
    public List<RankingData> getRankingData() {
        List<RankingData> data = new ArrayList<>();
        
        // 목업 데이터 추가
        data.add(new RankingData("하리보", "공부는 이제 그만", 2483, 2100, 89));
        data.add(new RankingData("헤나뼈", "일본 여행 좋아~", 2179, 3200, 142));
        data.add(new RankingData("김초심", "초심을 되찾자", 2135, 1800, 95));
        data.add(new RankingData("암기왕", "다 외울 때까지 숨 참음", 1924, 2400, 110));
        data.add(new RankingData("원피스", "보물 찾기 동료 구함", 1897, 2900, 128));
        data.add(new RankingData("포인트킹", "포인트는 나의 힘", 1756, 3500, 115));
        data.add(new RankingData("열공맨", "매일매일 성장중", 1634, 3300, 108));
        data.add(new RankingData("애니매니아", "자막없이 보는 그날까지", 1589, 3100, 132));
        data.add(new RankingData("도쿄여행러", "여행 준비중", 1445, 3000, 95));
        data.add(new RankingData("JLPT고수", "N1 준비중", 1398, 2800, 90));
        
        return data;
    }
    
    public List<RankingData> getSortedData(String type, List<RankingData> data) {
        List<RankingData> sorted = new ArrayList<>(data);
        sorted.sort((a, b) -> b.getValue(type) - a.getValue(type));
        return sorted;
    }
} 