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
	String Subject      = "JustRent!�|���b���ҰʫH";
//   	String messageText  = "Hello! " + mname + " ���԰O���K�X: " + mpwd +"\n" +" (�w�g�ҥ�)";        
  	String messageText  = "Hello�I  " + mname + "\n" + "\n" 
	+"  �w��[�JJustRent!�����|���A�b��w���U�����C" + "\n" +"  �z���b��: " + mid + " �K�X: " + mpwd + " ���԰O�C" 
  	+ "\n" + "\n" + "\n" 
	+"���I���H�U�s���ӱҰʱz���|���b��A�Ұʫ�H�b���K�X�n�JJustRent!�N�ɦ�����|���\��A���¡I" 
  	+ "\n" + "http://localhost:8081"+justrent+"/front/login/activate.jsp?code=" + code.enCrypt(mid, strKey) 
  	+ "\n"+"\n"+"\n"+"\n"
  	+"* �p�G�A�S�����U�LJustRent!�|���A�i��O���H���եΧA��Email�ӵ��U�A�Щ������H��C"+"\n"
  	+"* �p�W�L48�p�ɥ��Ұʱb���A�ӳs���N�۰ʥ��ġC"+"\n"
  	+"* �����h��T�A�Ц�  " + "http://localhost:8081"+ justrent+"/front/index.jsp" + " �x����� JustRent! �ΨӫHjustrent.service@gmail.com�C";
        boolean sessionDebug = false;

try {

  // �]�w�ҭn�Ϊ�Mail ���A���M�ҨϥΪ��ǰe��w
  java.util.Properties props = System.getProperties();
  props.put("mail.host",mailserver);
  props.put("mail.transport.protocol","smtp");
  
  // ���ͷs��Session �A��
  javax.mail.Session mailSession = javax.mail.Session.getDefaultInstance(props,null);
  mailSession.setDebug(sessionDebug);
	
  Message msg = new MimeMessage(mailSession);
  
  // �]�w�ǰe�l�󪺵o�H�H
  msg.setFrom(new InternetAddress(From));
  
  // �]�w�ǰe�l��ܦ��H�H���H�c
  address = InternetAddress.parse(to,false);
  msg.setRecipients(Message.RecipientType.TO, address);
  
  // �]�w�H�����D�D 
  msg.setSubject(Subject);
  // �]�w�e�H���ɶ�
  msg.setSentDate(new Date());
  
  // �]�w�ǰe�H��MIME Type
  msg.setText(messageText);
  
  // �e�H
  Transport.send(msg);

      //response.sendRedirect("emp_select.jsp?msg=Y");
    System.out.println("�ǰe���\!");
    out.println("<script >document.open('mail_ok.jsp', '' ,'height=110,width=390,left=200,top=120,resizable=no')</script>");	
}
    catch (MessagingException mex) {
      //response.sendRedirect("emp_select.jsp?msg=N");
    System.out.println("�ǰe����!");
    out.println("<script >document.open('mail_error.jsp', '' ,'height=110,width=390,left=200,top=120,resizable=no')</script>");  
      //mex.printStackTrace();
    }
 
%>