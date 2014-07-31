package front.ord.controller;

import java.io.*;
import java.sql.Timestamp;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.rent.model.*;

import front.ord.model.*;

public class OrdServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

        if ("insert".equals(action)) { // 來自addOrd.jsp的請求  
			
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			RentService rentSvc = new RentService();
			RentVO rentVO = new RentVO();

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				
				//rent_no
				String rent_no = req.getParameter("rent_no");
				String rent_noReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (rent_no == null || rent_no.trim().length() == 0) {
					errorMsgs.put("rent_no","租物編號請勿空白");
				} else if(!rent_no.trim().matches(rent_noReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("rent_no","租物編號只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            }
				else{
					rentVO = rentSvc.getOneRent(rent_no);	
				}
				
				//ten_no
				String ten_no = req.getParameter("ten_no").trim();
				if (ten_no == null || ten_no.trim().length() == 0) {
					errorMsgs.put("ten_no","承租會員編號請勿空白");
				}
				
				//ord_sta
				String ord_sta = "W_APR";
//				String que_sta = req.getParameter("que_sta").trim();
//				if (que_sta == null || que_sta.trim().length() == 0) {
//					errorMsgs.put("que_sta","問題狀態請勿空白");
//				}

				//tra_mode
				String tra_mode = req.getParameter("tra_mode").trim();
				if (tra_mode == null || tra_mode.trim().length() == 0) {
					errorMsgs.put("tra_mode","交易方式請勿空白");
				}	
				
				//freight   
				Integer freight = null;
				try {
					freight = Integer.parseInt(req.getParameter("freight")
							.trim());
				} catch (NumberFormatException e) {
					errorMsgs.put("freight", "運費請勿空白,或輸入非數字");
				}
				
				//ten_date 
				java.sql.Date ten_date = null;
				try {
					ten_date = java.sql.Date.valueOf(req.getParameter("ten_date").trim());
				} catch (IllegalArgumentException e) {
					errorMsgs.put("ten_date","承租日期請勿空白");
				}

				//exp_date 
				java.sql.Date exp_date = null;
				try {
					exp_date = java.sql.Date.valueOf(req.getParameter("exp_date").trim());
				} catch (IllegalArgumentException e) {
					errorMsgs.put("exp_date","到期日期請勿空白");
				}
				
				//ten_days   
				Integer ten_days = null;
				try {
					ten_days = Integer.parseInt(req.getParameter("ten_days")
							.trim());
				} catch (NumberFormatException e) {
					errorMsgs.put("ten_days", "承租天數請勿空白,或輸入非數字");
				}
								
				//rent_total  
				Integer rent_total = null;
				try {
					rent_total =  ten_days * rentVO.getUnit_price();
				} catch (Exception e) {
					errorMsgs.put("rent_total", "總租金錯誤");
				}

				//ot_days  
				Integer ot_days = 0;
		
				//init_dps   
				Integer init_dps = null;
				try {
					init_dps = rentVO.getRent_dps();
				} catch (Exception e) {
					errorMsgs.put("init_dps", "初始押金錯誤");
				}

				//real_dps   
				Integer real_dps = null;
				try {
					real_dps = init_dps;
				} catch (Exception e) {
					errorMsgs.put("real_dps", "實際押金錯誤");
				}				
				
				//tra_total  
				Integer tra_total = null;
				try {
					tra_total = init_dps.intValue() 
							+ rent_total.intValue() 
							+ freight.intValue();
				} catch (Exception e) {
					errorMsgs.put("tra_total", "交易總額錯誤");
				}						
				
				// loc_no
				String loc_no = req.getParameter("loc_no").trim();
				if (loc_no == null || loc_no.trim().length() == 0) {
					errorMsgs.put("loc_no", "地區請勿空白");
				}

				// rec_addr
				String rec_addr = req.getParameter("rec_addr").trim();
				if (rec_addr == null || rec_addr.trim().length() == 0) {
					errorMsgs.put("rec_addr", "收貨地址請勿空白");
				}
												

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					//add rentVO
					RequestDispatcher failureView = req
							.getRequestDispatcher("/ord/addOrd.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				OrdService ordSvc = new OrdService();
				ordSvc.addOrd(rent_no, ten_no, ord_sta, tra_mode, freight, ten_date, exp_date, ten_days, 
						      rent_total, ot_days, init_dps, real_dps, tra_total, loc_no, rec_addr);

				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/ord/listAllOrd.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllQue.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception","other errors");
				RequestDispatcher failureView = req
						.getRequestDispatcher("/ord/addOrd.jsp");
				failureView.forward(req, res);
			}
		}
        
        
		if ("delete".equals(action)) { // 來自listAllQue.jsp

			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			OrdService ordSvc = new OrdService();
//			OrdVO ordVO = new OrdVO();
	
			try {
				/***************************1.接收請求參數***************************************/
				//ord_no
				String ord_no = req.getParameter("ord_no");
				String ord_noReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (ord_no == null || ord_no.trim().length() == 0) {
					errorMsgs.put("ord_no","訂單編號請勿空白");
				} else if(!ord_no.trim().matches(ord_no)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("ord_no","訂單編號只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            } else{
//	                ordVO = ordSvc.getOneOrd(ord_no);		
				}	
				
				// ord_cc_cause
				String ord_cc_cause = req.getParameter("ord_cc_cause").trim();
				if (ord_cc_cause == null || ord_cc_cause.trim().length() == 0) {
					errorMsgs.put("ord_cc_cause", "取消原因請勿空白");
				}
				else{
//					ordVO.setOrd_cc_cause(ord_cc_cause);
				}
				
				/***************************2.開始刪除資料***************************************/

				ordSvc.deleteOrd(ord_no,ord_cc_cause);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/ord/listAllOrd.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {			
				errorMsgs.put("Exception","刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("listAllOrd.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { 
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				String ord_no= req.getParameter("ord_no");
				if (ord_no == null || ord_no.trim().length() == 0) {
					errorMsgs.put("ord_no","訂單編號不能為空");
				}
				
				/***************************2.開始查詢資料****************************************/
				OrdService ordSvc = new OrdService();
				OrdVO ordVO = ordSvc.getOneOrd(ord_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("ordVO", ordVO);         // 資料庫取出的ordVO物件,存入req
				String url = "/ord/update_ord_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_ord_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {				
				errorMsgs.put("Exception","無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("listAllOrd.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { // 來自update_ord_input.jsp的請求
			
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			OrdService ordSvc = new OrdService();
			OrdVO ordVO = new OrdVO();
				
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/

				//ord_no
				String ord_no = req.getParameter("ord_no");
				String ord_noReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (ord_no == null || ord_no.trim().length() == 0) {
					errorMsgs.put("ord_no","訂單編號請勿空白");
				} else if(!ord_no.trim().matches(ord_no)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("ord_no","訂單編號只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            } else{
	                ordVO = ordSvc.getOneOrd(ord_no);		
				}				
				
				//rent_no
//				String rent_no = req.getParameter("rent_no");
//				String rent_noReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
//				if (rent_no == null || rent_no.trim().length() == 0) {
//					errorMsgs.put("rent_no","租物編號請勿空白");
//				} else if(!rent_no.trim().matches(rent_noReg)) { //以下練習正則(規)表示式(regular-expression)
//					errorMsgs.put("rent_no","租物編號只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
//	            }
				
				//ord_sta
//				String ord_sta = "W_APR";
//				String que_sta = req.getParameter("que_sta").trim();
//				if (que_sta == null || que_sta.trim().length() == 0) {
//					errorMsgs.put("que_sta","問題狀態請勿空白");
//				}

				//tra_mode
				String tra_mode = req.getParameter("tra_mode").trim();
				if (tra_mode == null || tra_mode.trim().length() == 0) {
					errorMsgs.put("tra_mode","交易方式請勿空白");
				} else{
					ordVO.setTra_mode(tra_mode);
				}
				
				//freight   
				Integer freight = null;
				try {
					freight = Integer.parseInt(req.getParameter("freight").trim());
					ordVO.setFreight(freight);
					
				} catch (NumberFormatException e) {
					errorMsgs.put("freight", "運費請勿空白,或輸入非數字");
				}
				
				//ten_date 
				java.sql.Date ten_date = null;
				try {
					ten_date = java.sql.Date.valueOf(req.getParameter("ten_date").trim());
					ordVO.setTen_date(ten_date);
				} catch (IllegalArgumentException e) {
					errorMsgs.put("ten_date","承租日期請勿空白");
				}

				//exp_date 
				java.sql.Date exp_date = null;
				try {
					exp_date = java.sql.Date.valueOf(req.getParameter("exp_date").trim());
					ordVO.setExp_date(exp_date);
				} catch (IllegalArgumentException e) {
					errorMsgs.put("exp_date","到期日期請勿空白");
				}
				
				//ten_days   
				Integer ten_days = null;
				try {
					ten_days = Integer.parseInt(req.getParameter("ten_days").trim());
					if(ten_days <= 0) errorMsgs.put("ten_days", "承租天數不可小於等於零");
					ordVO.setTen_days(ten_days);	
				} catch (NumberFormatException e) {
					errorMsgs.put("ten_days", "承租天數請勿空白,或輸入非數字");
				}
								
				//rent_total  
				Integer rent_total = null;
				try {
					rent_total = Integer.parseInt(req.getParameter("rent_total").trim());
					ordVO.setRent_total(rent_total);
				} catch (Exception e) {
					errorMsgs.put("rent_total", "總租金請勿空白,或非數字");
				}
			
				//tra_total  
				Integer tra_total = null;
				try {
					tra_total = Integer.parseInt(req.getParameter("tra_total").trim());
					ordVO.setTra_total(tra_total);
				} catch (Exception e) {
					errorMsgs.put("tra_total", "交易總額請勿空白,或非數字");
				}
				
				// loc_no
				String loc_no = req.getParameter("loc_no").trim();
				if (loc_no == null || loc_no.trim().length() == 0) {
					errorMsgs.put("loc_no", "地區請勿空白");
				} else {
					ordVO.setLoc_no(loc_no);
				}

				// rec_addr
				String rec_addr = req.getParameter("rec_addr").trim();
				if (rec_addr == null || rec_addr.trim().length() == 0) {
					errorMsgs.put("rec_addr", "收貨地址請勿空白");
				} else {
					ordVO.setRec_addr(rec_addr);
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("ordVO", ordVO); // 含有輸入格式錯誤的ordVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/prd/update_ord_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
//				OrdService ordSvc = new OrdService();
//				ordSvc.updateOrd(ord_no,tra_mode,freight,ten_date,exp_date,ten_days,rent_total,tra_total,loc_no,rec_addr);
				ordSvc.updateOrd(ordVO);
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("ordVO", ordVO); // 資料庫update成功後,正確的的ordVO物件,存入req
				String url = "/ord/listAllOrd.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneOrd.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處+理*************************************/
			} catch (Exception e) {				
				errorMsgs.put("Exception","修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("update_que_input.jsp");
				failureView.forward(req, res);
			}
		}
	
		
//		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求
//
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//				String str = req.getParameter("empno");
//				if (str == null || (str.trim()).length() == 0) {
//					errorMsgs.add("請輸入員工編號");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/emp/select_page.jsp");
//					failureView.forward(req, res);
//					return;//程式中斷
//				}
//				
//				Integer empno = null;
//				try {
//					empno = new Integer(str);
//				} catch (Exception e) {
//					errorMsgs.add("員工編號格式不正確");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/emp/select_page.jsp");
//					failureView.forward(req, res);
//					return;//程式中斷
//				}
//				
//				/***************************2.開始查詢資料*****************************************/
//				EmpService empSvc = new EmpService();
//				EmpVO empVO = empSvc.getOneEmp(empno);
//				if (empVO == null) {
//					errorMsgs.add("查無資料");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/emp/select_page.jsp");
//					failureView.forward(req, res);
//					return;//程式中斷
//				}
//				
//				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
//				req.setAttribute("empVO", empVO); // 資料庫取出的empVO物件,存入req
//				String url = "/emp/listOneEmp.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
//				successView.forward(req, res);
//
//				/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法取得資料:" + e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/emp/select_page.jsp");
//				failureView.forward(req, res);
//			}
//		}
		
		

        
	}
}
