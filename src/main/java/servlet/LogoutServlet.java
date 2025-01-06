package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 세션 가져오기
        HttpSession session = request.getSession(false);
        
        // 세션이 존재하면 무효화
        if(session != null) {
            session.invalidate();
        }
        
        // Basic.jsp로 리다이렉트 (세션이 없어져서 자동으로 소개 페이지가 표시됨)
        response.sendRedirect(request.getContextPath() + "/JspHome/Main/Basic.jsp");
    }
} 