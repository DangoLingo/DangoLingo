<%@page import="com.google.gson.Gson"%>
<%@page import="BeansHome.Study.QuizDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="BeansHome.Japanese.JapaneseDTO" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
		//form에서 넘어온 파라미터 세 개 
		Integer userId = (Integer)session.getAttribute("userId");
	    String quizCount = request.getParameter("quiz_count");
	    String quizRight = request.getParameter("quiz_right");
	    
	    QuizDAO dao = new QuizDAO();
	    boolean result = false;
	
	    try {
	    	result = dao.updateUserStats(
	                userId,
	                Integer.parseInt(quizCount),
	                Integer.parseInt(quizRight)
	         );
	    	
	    	if (result) {
	            response.sendRedirect("../Words/Words.jsp"); // 성공 시 이동할 페이지
	        } else {
	        	//실패 시 이동할 페이지.. 어디로 가지? 걍 그대로 있을까?..
	        }
	    } catch (Exception e) {
	        out.println("Error: " + e.getMessage());
	    }
	%>
