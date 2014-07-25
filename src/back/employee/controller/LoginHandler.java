package back.employee.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import back.employee.model.EmployeeDAO;

public class LoginHandler extends HttpServlet {
	// 【檢查使用者輸入的帳號(account) 密碼(password)是否有效】
	// 【實際上應至資料庫搜尋比對】
	protected boolean allowUser(String account, String password) {
			String getPwd = new EmployeeDAO().findPwdByEmpno(account);

		    if (getPwd.equals(password))
		        return true;
		      else
		        return false;
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		// req.setCharacterEncoding("UTF-8");
		// //已由filters.SetCharacterEncodingFilter處理
		
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();

		// 【取得使用者 帳號(account) 密碼(password)】
		String account = req.getParameter("account");
		String password = req.getParameter("password");

		// 【檢查該帳號 , 密碼是否有效】
		if (!allowUser(account, password)) { // 【帳號 , 密碼無效時】
			req.setAttribute("dashboard_login_error", "帳號或密碼錯誤,請重新登入!");
			
			RequestDispatcher failureView = req
					.getRequestDispatcher("/dashboard_login.jsp");
			failureView.forward(req, res);
			return;
			
		} else { // 【帳號 , 密碼有效時, 才做以下工作】
			HttpSession session = req.getSession();
			session.setAttribute("account", account); // *工作1:
														// 才在session內做已經登入過的標識

			try { // *工作2: 看看有無來源網頁 (-如有:則重導之)
				String location = (String) session.getAttribute("location");
				if (location != null) {
					session.removeAttribute("location");
					res.sendRedirect(location);
					return;
				}
			} catch (Exception ignored) {
			}

			res.sendRedirect(req.getContextPath()+"/dashboard.jsp"); // *工作3: (-如無: 無來源網頁,
											// 則重導至index.jsp網頁)
		}
	}
}
