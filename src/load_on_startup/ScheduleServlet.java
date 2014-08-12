package load_on_startup;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.*;

import front.member.model.MemberVO;
import front.ord.model.OrdService;
import front.ord.model.OrdVO;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.*;

public class ScheduleServlet extends HttpServlet {
   
    
    Timer timer;
 	Send sendMessage = new Send();
    int count=0;
    
    OrdService ordSvc = null;
    List<OrdVO> listOrdVO = null;
    
    public void init() throws ServletException {
      TimerTask task = new TimerTask(){ 
	        public void run() {
                count++;   
//	        	System.out.println("第"+count+"次執行時間="+new Date(scheduledExecutionTime()));
//                System.out.println("工作排定的時間 = " + new Date(scheduledExecutionTime()));
//                System.out.println("工作執行的時間 = " + new Date() + "\n");
	        	
	            //租約到期塞提醒資料表且改訂單狀態為租約到期
	            ordSvc = new OrdService();
	            listOrdVO = ordSvc.getAll();
	            for (OrdVO ordVO : listOrdVO) {
	            	java.util.Date nowDate = new java.util.Date(); //當前時間
	            	Date ordDate = ordVO.getExp_date(); //租物期限
		        	if((nowDate.getTime()-ordDate.getTime()) >= 0){ //如果當前時間超過租物期限,則為租約到期
//		        		System.out.println(ordVO.getOrd_no()+"租約到期");
//		        		System.out.println("nowDate = "+nowDate);
//		        		System.out.println("ordDate = "+ordDate);
		        	}
	    		}
	            
	            //搜尋提醒資料表的提醒flag是Y的發簡訊提醒後改flag為N
	            
	            
	            //SOS一天過後刪除
	            
	            
	            //會員評價到300自動升級VIP
	            
	            
	            //會員積分達到-10 停權 還是被檢舉超過10次成立就停權 停權是終身停權 
	            //背後執行序 如果抓到 評分為-10的自動將會員終身停權
	            
	            
	        } 
      };
      timer = new Timer();
      timer.scheduleAtFixedRate(task, new java.util.Date(), 10*1000); //每10秒執行一次
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
//        System.out.println(memID);
        
		String resJson = "{\"resJson\" : [";
//		for (String rentStr : rentList) {
//			resJson += "\""+rentStr+"\",";
//		}
		resJson += "\""+memID+"\",";
		resJson = resJson.substring(0,resJson.length() - 1) + "]}";
	    System.out.println("RentServlet.642."+resJson);
	    PrintWriter out = res.getWriter();
	    out.write(resJson);
	    out.flush();
	    out.close();
    }                           	

    public void destroy() {
        timer.cancel();
        System.out.println("已移除排程!");
    }
    
}