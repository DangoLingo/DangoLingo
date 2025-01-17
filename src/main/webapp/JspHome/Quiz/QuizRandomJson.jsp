<%@page import="com.google.gson.Gson"%>
<%@page import="BeansHome.Study.QuizDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="BeansHome.Japanese.JapaneseDTO" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// quizCount와 words_id를 요청 파라미터로 받기
	String words_id = "103";
    // quizList를 담을 ArrayList 생성
    ArrayList<JapaneseDTO> quizList = new ArrayList<>();
    QuizDAO dao = new QuizDAO();

    try {
        int id = Integer.parseInt(words_id);
        // 데이터 읽기
        boolean result = dao.ReadQuizList(id, 50, quizList);
        if (result) {
            // Gson 객체를 생성하여 quizList를 JSON으로 변환
            Gson gson = new Gson();
            String jsonData = gson.toJson(quizList);
            
            // JSON 데이터를 파일로 저장하거나, 특정 URL로 반환
            response.setContentType("application/json; charset=UTF-8");
            response.getWriter().write(jsonData);  // 직접 JSON을 반환하는 방식
        } else {
            out.println("Failed to load quiz list.");
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
