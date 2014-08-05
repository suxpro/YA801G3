package back.employee.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import back.employee.model.EmployeeDAO;

public class LogoutHandler extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		// req.setCharacterEncoding("UTF-8");
		// //已由filters.SetCharacterEncodingFilter處理
		
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();

		// 【取得使用者 帳號(account)】
		HttpSession session = req.getSession();
		String accountBack = (String) session.getAttribute("accountBack");
		System.out.println("LogoutHandler.35."+accountBack);
		
		session.removeAttribute("accountBack");
		
		res.sendRedirect(req.getContextPath()+"/back/dashboard_login.jsp");

		return;
	}
}
