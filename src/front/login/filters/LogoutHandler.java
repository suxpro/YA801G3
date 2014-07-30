package front.login.filters;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

public class LogoutHandler extends HttpServlet {
		  
	  public void doPost(HttpServletRequest req, HttpServletResponse res)
	                                throws ServletException, IOException {
//	    req.setCharacterEncoding("UTF-8");               //已由filters.SetCharacterEncodingFilter處理
	    res.setContentType("text/html; charset=UTF-8");  //已由filters.SetContentTypeFilter處理 (測試用)

	    if("logout".equals(req.getParameter("action")))
	    {
	    	HttpSession session = req.getSession();
	    	session.invalidate();
	    }//end if
	    res.sendRedirect(req.getContextPath()+"/front/index.jsp");           //*工作3: (-如無: 無來源網頁, 則重導至index.jsp網頁)
	    //res.sendRedirect(req.getContextPath()+"/index.jsp");  //額外測試
	    
	  }

}
