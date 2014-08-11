package load_on_startup;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.*;

import front.member.model.MemberVO;

import java.util.*;

public class ScheduleServlet extends HttpServlet {
   
    
    Timer timer;
 	Send sendMessage = new Send();
    int count=0;
   
    public void init() throws ServletException {
      TimerTask task = new TimerTask(){ 
	        public void run() {
                count++;   
	        	System.out.println("第"+count+"次執行時間="+new Date());
//                System.out.println("工作排定的時間 = " + new Date(scheduledExecutionTime()));
//                System.out.println("工作執行的時間 = " + new Date() + "\n"); 
	        } 
      };
      timer = new Timer();
      timer.scheduleAtFixedRate(task, new Date(), 10*1000); //每10秒執行一次
      System.out.println("已建立排程!");
      
//      String[] tel ={"0989936902"};
//      String message = "排程訊息測試-QAQ....";
//      sendMessage.sendMessage(tel , message);
//      System.out.println("已建立簡訊發送排程!");
    }
    

    public void doPost(HttpServletRequest req, HttpServletResponse res)
                               throws ServletException, IOException {
    	HttpSession session = req.getSession();
        String memID = (String) session.getAttribute("mid");
        MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
        System.out.println(memID);
    }                           	

    public void destroy() {
        timer.cancel();
        System.out.println("已移除排程!");
    }
    
}