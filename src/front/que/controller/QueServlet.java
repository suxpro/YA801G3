package front.que.controller;

import java.io.*;
import java.sql.Timestamp;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import front.que.model.*;

public class QueServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

        if ("insert".equals(action)) { // 來自addQue.jsp的請求  
			
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);

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
				
				//que_mem
				String que_mem = req.getParameter("que_mem").trim();
				if (que_mem == null || que_mem.trim().length() == 0) {
					errorMsgs.put("que_mem","會員編號請勿空白");
				}
				
				//que_sta
				String que_sta = "IN_ASK";
//				String que_sta = req.getParameter("que_sta").trim();
//				if (que_sta == null || que_sta.trim().length() == 0) {
//					errorMsgs.put("que_sta","問題狀態請勿空白");
//				}				
				
				//que_time
				java.sql.Timestamp que_time = null;
				try {
					que_time = java.sql.Timestamp.valueOf(req.getParameter("que_time").trim());
				} catch (IllegalArgumentException e) {
					errorMsgs.put("que_time","請輸入發問日期時間");
				}
				
				//que_desc
				String que_desc = req.getParameter("que_desc").trim();
				if (que_desc == null || que_desc.trim().length() == 0) {
					errorMsgs.put("que_desc","問題描述請勿空白");
				}	

//				//ans_time
//				java.sql.Timestamp ans_time = null;
//				try {
//					ans_time = java.sql.Timestamp.valueOf(req.getParameter("ans_time").trim());
//				} catch (IllegalArgumentException e) {
//					errorMsgs.put("ans_time","請輸入回覆日期時間");
//				}
//				
//				//ans_desc
//				String ans_desc = req.getParameter("ans_desc").trim();
//				if (ans_desc == null || ans_desc.trim().length() == 0) {
//					errorMsgs.put("ans_desc","回答描述請勿空白");
//				}	
								

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					//add rentVO
					RequestDispatcher failureView = req
							.getRequestDispatcher("/que/addQue.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				QueService queSvc = new QueService();
				queSvc.addQue(rent_no, que_mem, que_sta, que_time, que_desc);

//				queSvc.addQue(rent_no, que_mem, que_sta, que_time, que_desc,
//						 ans_time, ans_desc);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/que/listAllQue.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllQue.jsp
				successView.forward(req, res);				
				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception","other errors");
				RequestDispatcher failureView = req
						.getRequestDispatcher("/que/addQue.jsp");
				failureView.forward(req, res);
			}
		}
        
        
		if ("delete".equals(action)) { // 來自listAllQue.jsp

			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				String que_no = req.getParameter("que_no");
				if (que_no == null || que_no.trim().length() == 0) {
					errorMsgs.put("que_no","問題編號不能為空");
				}
				
				/***************************2.開始刪除資料***************************************/
				QueService queSvc = new QueService();
				queSvc.deleteQue(que_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/que/listAllQue.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {			
				errorMsgs.put("Exception","刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("listAllQue.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { 
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				String que_no= req.getParameter("que_no");
//				if (que_no == null || que_no.trim().length() == 0) {
//					errorMsgs.put("que_no","問題編號不能為空");
//				}
				
				/***************************2.開始查詢資料****************************************/
				QueService queSvc = new QueService();
				QueVO queVO = queSvc.getOneQue(que_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("queVO", queVO);         // 資料庫取出的queVO物件,存入req
				String url = "/que/update_que_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_que_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {				
				errorMsgs.put("Exception","無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("listAllQue.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { // 來自update_que_input.jsp的請求
			
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String que_no = req.getParameter("que_no").trim();
				if (que_no == null || que_no.trim().length() == 0) {
					errorMsgs.put("que_no","問題編號不能為空");
				}
				String rent_no = req.getParameter("rent_no").trim();
				if (rent_no == null || rent_no.trim().length() == 0) {
					errorMsgs.put("rent_no","租物編號不能為空");
				}
				String que_mem = req.getParameter("que_mem").trim();
				if (que_mem == null || que_mem.trim().length() == 0) {
					errorMsgs.put("que_mem","會員編號不能為空");
				}
				String que_sta = "COM_REPLY";

//				String que_sta = req.getParameter("que_sta").trim();
//				if (que_sta == null || que_sta.trim().length() == 0) {
//					errorMsgs.put("que_sta","問題狀態不能為空");
//				}
//				
				java.sql.Timestamp que_time = null;
				try {
					que_time = java.sql.Timestamp.valueOf(req.getParameter("que_time").trim());
				} catch (IllegalArgumentException e) {
					que_time = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.put("que_time","輸入發問日期時間!");
				}
                
				String que_desc = req.getParameter("que_desc").trim();
				if (que_desc == null || que_desc.trim().length() == 0) {
					errorMsgs.put("que_desc","問題描述不能為空");
				}

				java.sql.Timestamp ans_time = null;
				try {
					ans_time = java.sql.Timestamp.valueOf(req.getParameter("ans_time").trim());
				} catch (IllegalArgumentException e) {
					ans_time = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.put("ans_time","輸入回覆日期時間!");
				}
                
				String ans_desc = req.getParameter("ans_desc").trim();
				if (ans_desc == null || ans_desc.trim().length() == 0) {
					errorMsgs.put("ans_desc","回覆描述不能為空");
				}

				QueVO queVO = new QueVO();
				queVO.setQue_no(que_no);
				queVO.setRent_no(rent_no);
				queVO.setQue_mem(que_mem);
				queVO.setQue_sta(que_sta);
				queVO.setQue_time(que_time);
				queVO.setQue_desc(que_desc);
				queVO.setAns_time(ans_time);
				queVO.setAns_desc(ans_desc);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("queVO", queVO); // 含有輸入格式錯誤的queVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/que/update_que_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				QueService queSvc = new QueService();
				queSvc.updateQue(que_no,rent_no,que_mem,que_sta, que_time, que_desc,ans_time, ans_desc);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("queVO", queVO); // 資料庫update成功後,正確的的queVO物件,存入req
				String url = "/que/listAllQue.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneQue.jsp
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
