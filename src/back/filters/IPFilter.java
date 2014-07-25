package back.filters;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class IPFilter implements Filter {
	
	String permission=null;
	
	public void init(FilterConfig config){
		permission=config.getInitParameter("permission");
	}
	
	public void destroy(){
	}
    
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws ServletException, IOException{
		
		String remoteAddress=request.getRemoteAddr();
		System.out.println("remoteAddress="+remoteAddress);
		if(remoteAddress.startsWith(permission)){
			chain.doFilter(request,response);
		}else{
			RequestDispatcher rDispatcher=request.getRequestDispatcher("/IPForbiddenServlet");
			rDispatcher.forward(request,response);
		}
  }
}
