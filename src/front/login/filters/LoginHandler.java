package front.login.filters;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import front.member.model.*;

public class LoginHandler extends HttpServlet {
		MemberVO memberVO = null;
   //【檢查使用者輸入的帳號(account) 密碼(password)是否有效】
   //【實際上應至資料庫搜尋比對】
  protected boolean allowUser(String mid, String mpwd) {
	  MemberService memberSvc = new MemberService();

		memberVO = memberSvc.getAccountMember(mid);
	  
		if (memberVO == null){
			return false;
		} else if (!memberVO.getMpwd().equals(mpwd)){
			return false;
		}
		else {

			return true;

		}
  }
  
  public void doPost(HttpServletRequest req, HttpServletResponse res)
                                throws ServletException, IOException {
//    req.setCharacterEncoding("UTF-8");               //已由filters.SetCharacterEncodingFilter處理
    res.setContentType("text/html; charset=UTF-8");  //已由filters.SetContentTypeFilter處理 (測試用)
    
    PrintWriter out = res.getWriter();

    // 【取得使用者 帳號(account) 密碼(password)】
    String mid = req.getParameter("mid");
    String mpwd = req.getParameter("mpwd");

    // 【檢查該帳號 , 密碼是否有效】
    if (!allowUser(mid, mpwd)) {         //【帳號 , 密碼無效時】
      out.println("<HTML><HEAD><TITLE>Access Denied</TITLE></HEAD>");
      out.println("<BODY>你的帳號 , 密碼無效!<BR>");
      //out.println("請按此重新登入 <A HREF=\"/login.html\">重新登入</A>");
      out.println("請按此重新登入 <A HREF="+req.getContextPath()+"/front/index_login.jsp>重新登入</A>");
      out.println("</BODY></HTML>");
    	
//    	session.setAttribute("error", "error");
//		res.sendRedirect(req.getContextPath() + "/front/login.jsp");
    }else {                                     //【帳號 , 密碼有效時, 才做以下工作】
      HttpSession session = req.getSession();
      session.setAttribute("mid", mid);   //*工作1: 才在session內做已經登入過的標識
      session.setAttribute("memberVO", memberVO);
      
       try {                                      //*工作2: 看看有無來源網頁 (-如有:則重導之)                  
         String location = (String) session.getAttribute("location");
         if (location != null) {
           session.removeAttribute("location");
           res.sendRedirect(location);            
           return;
         }
       }catch (Exception ignored) { }

      res.sendRedirect(req.getContextPath() + "/front/index.jsp");           //*工作3: (-如無: 無來源網頁, 則重導至index.jsp網頁)
      //res.sendRedirect(req.getContextPath()+"/index.jsp");  //額外測試
    }
  }
}
