package front.sosorder.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.UnavailableException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import back.employee.model.EmployeeService;
import back.employee.model.EmployeeVO;

import com.oreilly.servlet.MultipartRequest;

import front.member.model.MemberVO;
import front.rent.model.RentService;
import front.rent.model.RentVO;
import front.sosorder.model.SosorderService;
import front.sosorder.model.SosorderVO;

public class SosorderServlet extends HttpServlet {
	Connection con;

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		// doPost(req, res); 

		// 20140804 - 為了給租物上架審核查詢單一會員資料 
//		if (req.getParameter("action") != null
//				&& req.getParameter("action").equals("getOne_For_Display")) {
//			doPost(req, res);
//			return;
//		}

		// 用請求參數讀取圖片
		req.setCharacterEncoding("UTF-8");
		res.setContentType("image/jpeg");
		ServletOutputStream out = res.getOutputStream();// 推出2進位資料流
		
		
		String sos_no = "";
		try {
			sos_no = req.getParameter("sos_no");
			sos_no = new String(sos_no.getBytes("ISO-8859-1"), "UTF-8");
		} catch (NullPointerException e) {
			System.out.println("sos_no: " + sos_no + " fail!");
		}
		try {
			
			String pic = req.getParameter("pic");
			pic = new String(pic.getBytes("ISO-8859-1"), "UTF-8");
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT " + pic
					+ " FROM sosorder WHERE sos_no = '" + sos_no + "'");

			if (rs.next()) {
				if(rs.getBinaryStream(pic) != null){
					BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream(pic));
					byte[] buf = new byte[4 * 1024]; // 4K buffer
					int len;
					while ((len = in.read(buf)) != -1) {
					out.write(buf, 0, len);
					}
					in.close();
				}
			} else {
				res.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
			rs.close();
			stmt.close();
		} catch (Exception e) {
//			System.out.println(e);
		}
	}
	
	@SuppressWarnings("unchecked")
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String ct = req.getContentType();// 取得ContentType的形式

		String action = null;
		MultipartRequest multi = null;

		if (ct!=null && ct.startsWith("multipart/form-data")) {
			multi = new MultipartRequest(req, getServletContext().getRealPath(
					"/front/sosorder/images"), 5 * 1024 * 1024, "UTF-8");
			action = multi.getParameter("action");
		} else {
			action = req.getParameter("action");
		}
		
//		小豬加,租物區show租物資料
		if ("addSos".equals(action)) { // 來自addEmp.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			// 抓取session現在登入的member
			HttpSession session = req.getSession();
			String memID = (String) session.getAttribute("mid");
			MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");

			if(memID != null){
				try {
					/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
					String sos_mno = memberVO.getMno();
					
					String sos_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
					String sos_name = multi.getParameter("addSosName").trim();
					if (sos_name == null || sos_name.trim().length() == 0) {
						errorMsgs.put("sos_name", "姓名: 請勿空白");
					} else if (!sos_name.trim().matches(sos_nameReg)) { // 以下正則(規)表示式(regular-expression)
						errorMsgs.put("emp_name",
								"姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
					}
					
					String sos_desc = multi.getParameter("addSosDesc").trim();

					Integer sos_pay = null;
					try {
						sos_pay = new Integer(multi.getParameter("addSosPay").trim());
					} catch (NumberFormatException e) {
						errorMsgs.put("sos_pay", "金額請填數字");
					}
					
					Integer sos_days = null;
					try {
						sos_days = new Integer(multi.getParameter("addSosDays").trim());
					} catch (NumberFormatException e) {
						errorMsgs.put("sos_days", "天數請填數字");
					}
					
					Timestamp sos_onsd = null;
					try {
						sos_onsd = new Timestamp(Calendar.getInstance().getTime().getTime());//取得現在時間Timestamp
					} catch (IllegalArgumentException e) {
						errorMsgs.put("sos_onsd", "SOS上架日: 請輸入日期");
					}

					Timestamp sos_ofsd = null;
					
					byte[] sos_pic = null;
					File file = null;
					try {
						file = multi.getFile("addSosPic");
						FileInputStream fis = new FileInputStream(file);
						int len = fis.available();
						sos_pic = new byte[len];
						fis.read(sos_pic);
						fis.close();
					} catch (NullPointerException e) { //若沒上傳圖片
//						System.out.println(getServletContext().getRealPath("/front/img/default.png"));
						file = new File(getServletContext().getRealPath("/front/img/default.png"));
						FileInputStream fis = new FileInputStream(file);
						int len = fis.available();
						sos_pic = new byte[len];
						fis.read(sos_pic);
						fis.close();
//						errorMsgs.put("sos_pic", "圖片: 上傳錯誤");
					}
					
					String sos_format = null;
					
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						System.out.println("有errorMsgs");
						RequestDispatcher failureView = req
								.getRequestDispatcher("/index.jsp");
						failureView.forward(req, res);
						return;
					}

					/*************************** 2.開始新增資料 ***************************************/
					SosorderService sosSvc = new SosorderService();
					SosorderVO sosorderVO = sosSvc.addSosorder(sos_mno, sos_name, sos_desc, sos_pay, sos_days, sos_onsd, sos_ofsd, sos_pic, sos_format);
					
					/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
					List<SosorderVO> sosList = sosSvc.getAll();
					res.setContentType("text/html;charset=utf-8");
					res.setHeader("Cache-Control", "no-cache");
					String resJson = "{\"resJson\" : [";
					for (SosorderVO sosVO : sosList) {
						resJson += "\""+sosVO.getSos_no()+"\",";
					}
					resJson = resJson.substring(0,resJson.length() - 1) + "]}";
//				    System.out.println("RentServlet.642."+resJson);
				    PrintWriter out = res.getWriter();
				    out.write(resJson);
				    out.flush();
				    out.close();

					/*************************** 其他可能的錯誤處理 **********************************/
				} catch (Exception e) {
					errorMsgs.put("Exception", e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/index.jsp");
					failureView.forward(req, res);
				}
			} else {
				res.setContentType("text/html;charset=utf-8");
				res.setHeader("Cache-Control", "no-cache");
				System.out.println("SosorderServlet.219.尚未登入,不能新增Sos租物");
				String resJson = "{\"resJson\" : [";
//				for (SosorderVO sosVO : sosList) {
					resJson += "\"尚未登入\",";
//				}
				resJson = resJson.substring(0,resJson.length() - 1) + "]}";
//			    System.out.println("RentServlet.642."+resJson);
			    PrintWriter out = res.getWriter();
			    out.write(resJson);
			    out.flush();
			    out.close();
			}

		}
		
//		
////		小豬加,使用者增加租物至Cart,存session
//		if ("addRentToCart".equals(action)) {
//			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
//			req.setAttribute("errorMsgs", errorMsgs);
//			// 【取得 session】
//			HttpSession session = req.getSession();
//		    
//			try {
//				/*************************** 1.接收請求參數 ****************************************/
//				String sos_no = req.getParameter("sos_no");
//				String rent_state = req.getParameter("rent_state");
//				
//				/*************************** 2.開始判斷與塞資料 ****************************************/
//			    Vector<String> rentList = (Vector<String>)session.getAttribute("rentList");
//				if(rentList == null)
//					rentList = new Vector<String>();
//				
//				Boolean hasRent = false;
//				for (String rentStr : rentList)
//				    if(rentStr.equals(sos_no))
//				    	hasRent = true;
//				
//				if(!hasRent){
//					rentList.add(sos_no);
//					System.out.println("RentServlet.639.增加租物"+sos_no+"存session");
//				} else 
//					System.out.println("RentServlet.641.已有租物"+sos_no+"在session");
//				
////				if("A_RENT".equals(rent_state)){
////				//以下新增資料至預租Table
////					String ten_no = ((MemberVO)session.getAttribute("memberVO")).getMno();
////					
////					java.sql.Date prent_time = new java.sql.Date(System.currentTimeMillis());
////	
////					Integer prent_days = 0;
////	
////					String prent_flag = "Y";
////					String ord_no = "";
////					PrentService prentSvc = new PrentService();
////					PrentVO prentVO = prentSvc.addPrent(sos_no, ten_no, prent_time,
////							prent_days, prent_flag, ord_no);
////				}
//				
//				/*************************** 3.塞資料完成,準備轉交(Send the Successview) ************/
//				session.setAttribute("rentList", rentList);
//				
//				/*************************** 4.json測試,前端AJAX console.log接 ****************************/
//				String resJson = "{\"resJson\" : [";
//				for (String rentStr : rentList) {
//					resJson += "\""+rentStr+"\",";
//				}
//				resJson = resJson.substring(0,resJson.length() - 1) + "]}";
////			    System.out.println("RentServlet.642."+resJson);
//			    PrintWriter out = res.getWriter();
//			    out.write(resJson);
//			    out.flush();
//			    out.close();
//
//				/*************************** 其他可能的錯誤處理 **********************************/
//			} catch (Exception e) {
//				errorMsgs.put("Exception", "無法取得要修改的資料:" + e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front/rent/infoRent.jsp");
//				failureView.forward(req, res);
//			}
//		}
		
		
		
	}

	public void init() throws ServletException {
		try {
			Context ctx = new javax.naming.InitialContext();
			DataSource ds = (DataSource) ctx
					.lookup("java:comp/env/jdbc/renterDB");
			con = ds.getConnection();
		} catch (NamingException e) {
			throw new UnavailableException("Couldn't not find connect pool");
		} catch (SQLException e) {
			throw new UnavailableException("Couldn't get db connection");
		}
	}
 
	public void destroy() {
		try {
			if (con != null)
				con.close();
		} catch (SQLException e) {
			System.out.println(e);
		}
	}
}
