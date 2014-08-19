<%@ page language="java" import="java.util.*,java.io.*" contentType="text/html;charset=Big5" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="front.member.model.*"  %>
<%@ page import="front.member.controller.code"  %>
<%@ page import="java.security.MessageDigest"  %>
<%@ page import="java.security.NoSuchAlgorithmException"  %>
<%@ page import="javax.servlet.ServletRequest"  %>


<%!
	InternetAddress[] address = null ;
	
%>

<%

    MemberVO memberVOadd = (MemberVO)request.getAttribute("memberVOadd");
	String justrent = request.getContextPath();
	String mid = memberVOadd.getMid();
	String mname = memberVOadd.getMname();
	String mpwd = memberVOadd.getMpwd();
	String strKey = null;
		
	String mailserver   = "140.115.236.9";
	String From         = "justrent.server@gmail.com";
	String to           = "justrent.service@gmail.com";  //String to = request.getParameter("email");
	String Subject      = "JustRent!會員帳號啟動信";
//   	String messageText  = "Hello! " + mname + " 請謹記此密碼: " + mpwd +"\n" +" (已經啟用)";        
  	String messageText  = "Hello！  " + mname + "\n" + "\n" 
	+"  歡迎加入JustRent!網站會員，帳戶已註冊完畢。" + "\n" +"  您的帳號: " + mid + " 密碼: " + mpwd + " 請謹記。" 
  	+ "\n" + "\n" + "\n" 
	+"請點擊以下連結來啟動您的會員帳戶，啟動後以帳號密碼登入JustRent!將享有完整會員功能，謝謝！" 
  	+ "\n" + "http://localhost:8081"+justrent+"/front/login/activate.jsp?code=" + code.enCrypt(mid, strKey) 
  	+ "\n"+"\n"+"\n"+"\n"
  	+"* 如果你沒有註冊過JustRent!會員，可能是有人嘗試用你的Email來註冊，請忽略本信件。"+"\n"
  	+"* 如超過48小時未啟動帳號，該連結將自動失效。"+"\n"
  	+"* 獲取更多資訊，請至  " + "http://localhost:8081"+ justrent+"/front/index.jsp" + " 官方網站 JustRent! 或來信justrent.service@gmail.com。";
        boolean sessionDebug = false;

try {

  // 設定所要用的Mail 伺服器和所使用的傳送協定
  java.util.Properties props = System.getProperties();
  props.put("mail.host",mailserver);
  props.put("mail.transport.protocol","smtp");
  
  // 產生新的Session 服務
  javax.mail.Session mailSession = javax.mail.Session.getDefaultInstance(props,null);
  mailSession.setDebug(sessionDebug);
	
  Message msg = new MimeMessage(mailSession);
  
  // 設定傳送郵件的發信人
  msg.setFrom(new InternetAddress(From));
  
  // 設定傳送郵件至收信人的信箱
  address = InternetAddress.parse(to,false);
  msg.setRecipients(Message.RecipientType.TO, address);
  
  // 設定信中的主題 
  msg.setSubject(Subject);
  // 設定送信的時間
  msg.setSentDate(new Date());
  
  // 設定傳送信的MIME Type
  msg.setText(messageText);
  
  // 送信
  Transport.send(msg);

      //response.sendRedirect("emp_select.jsp?msg=Y");
    System.out.println("傳送成功!");
    out.println("<script >document.open('mail_ok.jsp', '' ,'height=110,width=390,left=200,top=120,resizable=no')</script>");	
}
    catch (MessagingException mex) {
      //response.sendRedirect("emp_select.jsp?msg=N");
    System.out.println("傳送失敗!");
    out.println("<script >document.open('mail_error.jsp', '' ,'height=110,width=390,left=200,top=120,resizable=no')</script>");  
      //mex.printStackTrace();
    }
 
%>