package back.employee.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import back.employee.model.EmployeeDAO;
import back.employee.model.EmployeeVO;

public class LoginHandler extends HttpServlet {
	// 【檢查使用者輸入的帳號(account) 密碼(password)是否有效】
	// 【實際上應至資料庫搜尋比對】
	protected String allowUser(String account, String password) {
			EmployeeVO getEmpVo = new EmployeeDAO().findPwdByEmpId(account);
			System.out.println("LoginHandler.16."+getEmpVo.getEmp_pwd());
			System.out.println("LoginHandler.17."+getEmpVo.getEmp_pwd().equals(password));
		    if (getEmpVo.getEmp_pwd().equals(password))
		        return getEmpVo.getEmp_job();
		      else
		        return "false";
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		// req.setCharacterEncoding("UTF-8");
		// //已由filters.SetCharacterEncodingFilter處理
		
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();

		// 【取得使用者 帳號(account) 密碼(password)】
		String accountBack = req.getParameter("accountBack");
		String passwordBack = req.getParameter("passwordBack");
		String allowUser = allowUser(accountBack, passwordBack);
		System.out.println("LoginHandler.34."+accountBack);
		System.out.println("LoginHandler.35."+passwordBack);
		System.out.println("LoginHandler.35."+allowUser);
		
		// 【檢查該帳號 , 密碼是否有效】
		if ("false".equals(allowUser)) { // 【帳號 , 密碼無效時】
			req.setAttribute("dashboard_login_error", "帳號或密碼錯誤,請重新登入!");
			
			RequestDispatcher failureView = req
					.getRequestDispatcher("/back/dashboard_login.jsp");
			failureView.forward(req, res);
//			res.sendRedirect(req.getContextPath()+"/back/dashboard_login.jsp");
			return;
			
		} else { // 【帳號 , 密碼有效時, 才做以下工作】
			HttpSession session = req.getSession();
			session.setAttribute("accountBack", accountBack); // *工作1:
			session.setAttribute("accountBackJob", allowUser); // *工作1:
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

			res.sendRedirect(req.getContextPath()+"/back/dashboard.jsp"); // *工作3: (-如無: 無來源網頁,
											// 則重導至index.jsp網頁)
		}
	}
}
