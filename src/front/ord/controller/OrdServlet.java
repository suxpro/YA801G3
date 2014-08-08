package front.ord.controller;

import java.io.*;
import java.sql.Timestamp;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import front.rent.model.*;
import front.ord.model.*;
import front.member.model.*;

public class OrdServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		// if ("insert".equals(action)) { // 來自addOrd.jsp的請求
		//
		// Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
		// req.setAttribute("errorMsgs", errorMsgs);
		//
		// RentService rentSvc = new RentService();
		// RentVO rentVO = new RentVO();
		//
		// try {
		// /***********************1.接收請求參數 -
		// 輸入格式的錯誤處理*************************/
		//
		// //rent_no
		// String rent_no = req.getParameter("rent_no");
		// String rent_noReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
		// if (rent_no == null || rent_no.trim().length() == 0) {
		// errorMsgs.put("rent_no","租物編號請勿空白");
		// } else if(!rent_no.trim().matches(rent_noReg)) {
		// //以下練習正則(規)表示式(regular-expression)
		// errorMsgs.put("rent_no","租物編號只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
		// }
		// else{
		// rentVO = rentSvc.getOneRent(rent_no);
		// }
		//
		// //les_no
		// String ten_no = req.getParameter("ten_no").trim();
		// if (ten_no == null || ten_no.trim().length() == 0) {
		// errorMsgs.put("ten_no","承租會員編號請勿空白");
		// }
		// //ten_no
		// String ten_no = req.getParameter("ten_no").trim();
		// if (ten_no == null || ten_no.trim().length() == 0) {
		// errorMsgs.put("ten_no","承租會員編號請勿空白");
		// }
		//
		// //ord_sta
		// String ord_sta = "W_APR";
		// // String que_sta = req.getParameter("que_sta").trim();
		// // if (que_sta == null || que_sta.trim().length() == 0) {
		// // errorMsgs.put("que_sta","問題狀態請勿空白");
		// // }
		//
		// //tra_mode
		// String tra_mode = req.getParameter("tra_mode").trim();
		// if (tra_mode == null || tra_mode.trim().length() == 0) {
		// errorMsgs.put("tra_mode","交易方式請勿空白");
		// }
		//
		// //freight
		// Integer freight = null;
		// try {
		// freight = Integer.parseInt(req.getParameter("freight")
		// .trim());
		// } catch (NumberFormatException e) {
		// errorMsgs.put("freight", "運費請勿空白,或輸入非數字");
		// }
		//
		// //ten_date
		// java.sql.Date ten_date = null;
		// try {
		// ten_date =
		// java.sql.Date.valueOf(req.getParameter("ten_date").trim());
		// } catch (IllegalArgumentException e) {
		// errorMsgs.put("ten_date","承租日期請勿空白");
		// }
		//
		// //exp_date
		// java.sql.Date exp_date = null;
		// try {
		// exp_date =
		// java.sql.Date.valueOf(req.getParameter("exp_date").trim());
		// } catch (IllegalArgumentException e) {
		// errorMsgs.put("exp_date","到期日期請勿空白");
		// }
		//
		// //ten_days
		// Integer ten_days = null;
		// try {
		// ten_days = Integer.parseInt(req.getParameter("ten_days")
		// .trim());
		// } catch (NumberFormatException e) {
		// errorMsgs.put("ten_days", "承租天數請勿空白,或輸入非數字");
		// }
		//
		// //rent_total
		// Integer rent_total = null;
		// try {
		// rent_total = ten_days * rentVO.getUnit_price();
		// } catch (Exception e) {
		// errorMsgs.put("rent_total", "總租金錯誤");
		// }
		//
		// //ot_days
		// Integer ot_days = 0;
		//
		// //init_dps
		// Integer init_dps = null;
		// try {
		// init_dps = rentVO.getRent_dps();
		// } catch (Exception e) {
		// errorMsgs.put("init_dps", "初始押金錯誤");
		// }
		//
		// //real_dps
		// Integer real_dps = null;
		// try {
		// real_dps = init_dps;
		// } catch (Exception e) {
		// errorMsgs.put("real_dps", "實際押金錯誤");
		// }
		//
		// //tra_total
		// Integer tra_total = null;
		// try {
		// tra_total = init_dps.intValue()
		// + rent_total.intValue()
		// + freight.intValue();
		// } catch (Exception e) {
		// errorMsgs.put("tra_total", "交易總額錯誤");
		// }
		//
		// // loc_no
		// String loc_no = req.getParameter("loc_no").trim();
		// if (loc_no == null || loc_no.trim().length() == 0) {
		// errorMsgs.put("loc_no", "地區請勿空白");
		// }
		//
		// // rec_addr
		// String rec_addr = req.getParameter("rec_addr").trim();
		// if (rec_addr == null || rec_addr.trim().length() == 0) {
		// errorMsgs.put("rec_addr", "收貨地址請勿空白");
		// }
		//
		//
		// // Send the use back to the form, if there were errors
		// if (!errorMsgs.isEmpty()) {
		// RequestDispatcher failureView = req
		// .getRequestDispatcher("/front/ord/addOrd.jsp");
		// failureView.forward(req, res);
		// return;
		// }
		//
		// /***************************2.開始新增資料***************************************/
		// OrdService ordSvc = new OrdService();
		// ordSvc.addOrd(rent_no, ten_no, ord_sta, tra_mode, freight, ten_date,
		// exp_date, ten_days,
		// rent_total, ot_days, init_dps, real_dps, tra_total, loc_no,
		// rec_addr);
		//
		// /***************************3.新增完成,準備轉交(Send the Success
		// view)***********/
		// String url = "/front/ord/listAllOrd.jsp";
		// RequestDispatcher successView = req.getRequestDispatcher(url); //
		// 新增成功後轉交listAllQue.jsp
		// successView.forward(req, res);
		//
		// /***************************其他可能的錯誤處理**********************************/
		// } catch (Exception e) {
		// errorMsgs.put("Exception","other errors");
		// RequestDispatcher failureView = req
		// .getRequestDispatcher("/front/ord/addOrd.jsp");
		// failureView.forward(req, res);
		// }
		// }

		if ("delete".equals(action)) { // 來自listAllQue.jsp

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			OrdService ordSvc = new OrdService();
			OrdVO ordVO = new OrdVO();

			try {
				/*************************** 1.接收請求參數 ***************************************/
				// ord_no
				String ord_no = req.getParameter("ord_no");
				String ord_noReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (ord_no == null || ord_no.trim().length() == 0) {
					errorMsgs.put("ord_no", "訂單編號請勿空白");
				} else if (!ord_no.trim().matches(ord_no)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("ord_no", "訂單編號只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				} else {
					 ordVO = ordSvc.getOneOrd(ord_no);
				}
				
				//檢查訂單狀態是否仍是待核准
				String ord_sta = ordVO.getOrd_sta();
				if(!ord_sta.equals("W_APR")){
					errorMsgs.put("rent_no","訂單狀態非[待核准],無法取消訂單");
				}

				// ord_cc_cause
				String ord_cc_cause = req.getParameter("ord_cc_cause").trim();
				if (ord_cc_cause == null || ord_cc_cause.trim().length() == 0) {
					errorMsgs.put("ord_cc_cause", "取消原因請勿空白");
				} else {
					 ordVO.setOrd_cc_cause(ord_cc_cause);
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/ord/listAllOrd.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始刪除資料 ***************************************/

//				ordSvc.deleteOrd(ord_no, ord_cc_cause);
				ordSvc.deleteOrd(ordVO);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/front/ord/listAllOrd.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/ord/listAllOrd.jsp");
				failureView.forward(req, res);
			}
		}

		// if ("getOne_For_Update".equals(action)) {
		// Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
		// req.setAttribute("errorMsgs", errorMsgs);
		//
		// try {
		// /***************************1.接收請求參數****************************************/
		// String ord_no= req.getParameter("ord_no");
		// if (ord_no == null || ord_no.trim().length() == 0) {
		// errorMsgs.put("ord_no","訂單編號不能為空");
		// }
		//
		// // Send the use back to the form, if there were errors
		// if (!errorMsgs.isEmpty()) {
		// RequestDispatcher failureView = req
		// .getRequestDispatcher("/front/ord/listAllOrd.jsp");
		// failureView.forward(req, res);
		// return;
		// }
		//
		// /***************************2.開始查詢資料****************************************/
		// OrdService ordSvc = new OrdService();
		// OrdVO ordVO = ordSvc.getOneOrd(ord_no);
		//
		// /***************************3.查詢完成,準備轉交(Send the Success
		// view)************/
		// req.setAttribute("ordVO", ordVO); // 資料庫取出的ordVO物件,存入req
		// String url = "/front/ord/update_ord_input.jsp";
		// RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交
		// update_ord_input.jsp
		// successView.forward(req, res);
		//
		// /***************************其他可能的錯誤處理**********************************/
		// } catch (Exception e) {
		// errorMsgs.put("Exception","無法取得要修改的資料:" + e.getMessage());
		// RequestDispatcher failureView = req
		// .getRequestDispatcher("/front/ord/listAllOrd.jsp");
		// failureView.forward(req, res);
		// }
		// }
		
		//承租人遞交訂單
		if ("insert".equals(action)) { // 來自cartToOrd.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			RentService rentSVC = new RentService();
			RentVO rentVO =new RentVO();
			
			MemberService memberSVC = new MemberService();
			MemberVO memberVO = new MemberVO();
			
			OrdService ordSvc = new OrdService();
			OrdVO ordVO = new OrdVO();
			// 取的租物車中的清單
			HttpSession session = req.getSession();
			Vector<String> rentList = (Vector<String>) session.getAttribute("rentList");

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				// ord_no
				// String ord_no = req.getParameter("ord_no");
				// String ord_noReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				// if (ord_no == null || ord_no.trim().length() == 0) {
				// errorMsgs.put("ord_no","訂單編號請勿空白");
				// } else if(!ord_no.trim().matches(ord_noReg)) {
				// //以下練習正則(規)表示式(regular-expression)
				// errorMsgs.put("ord_no","訂單編號只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				// } else{
				// ordVO = ordSvc.getOneOrd(ord_no);
				// }

				// rent_no
				String rent_no = req.getParameter("rent_no");
				String rent_noReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (rent_no == null || rent_no.trim().length() == 0) {
					errorMsgs.put("rent_no", "租物編號請勿空白");
				} else if (!rent_no.trim().matches(rent_noReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("rent_no","租物編號只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				} else {
					ordVO.setRent_no(rent_no);
				}
				
				//再檢查一次租物狀態為待出租
				rentVO = rentSVC.getOneRent(rent_no);
				String rent_sta = rentVO.getRent_sta();				
				if (!rent_sta.equals("W_RENT")){
					errorMsgs.put("rent_no","租物狀態非[待出租],無法產生訂單");
				}
				
				// les_no
				String les_no = req.getParameter("les_no").trim();
				if (les_no == null || les_no.trim().length() == 0) {
					errorMsgs.put("les_no", "出租會員編號請勿空白");
				} else {
					ordVO.setLes_no(les_no);
				}
				
				// ten_no
				String ten_no = req.getParameter("ten_no").trim();
				if (ten_no == null || ten_no.trim().length() == 0) {
					errorMsgs.put("ten_no", "承租會員編號請勿空白");
				} else {
					ordVO.setTen_no(ten_no);
					//取得承租者資料
					memberVO = memberSVC.getOneMember(ten_no);
				}
				
				//避免自己承租到自己出租的租物
				if(les_no.equals(ten_no)){
					errorMsgs.put("ten_no", "請注意不要出租與承租同一租物!");
				}

				// ord_sta
				String ord_sta = "W_APR";
				// String ord_sta = req.getParameter("ord_sta").trim();
				if (ord_sta == null || ord_sta.trim().length() == 0) {
					errorMsgs.put("ord_sta", "訂單狀態請勿空白");
				} else {
					ordVO.setOrd_sta(ord_sta);
				}

				// tra_mode
				String tra_mode = req.getParameter("tra_mode").trim();
				if (tra_mode == null || tra_mode.trim().length() == 0) {
					errorMsgs.put("tra_mode", "交易方式請勿空白");
				} else {
					ordVO.setTra_mode(tra_mode);
				}

				// freight
				Integer freight = null;
				try {
					freight = Integer.parseInt(req.getParameter("freight")
							.trim());
					ordVO.setFreight(freight);
				} catch (NumberFormatException e) {
					errorMsgs.put("freight", "運費請勿空白,或輸入非數字");
				}

				// ten_date
				java.sql.Date ten_date = null;
				try {
					ten_date = java.sql.Date.valueOf(req.getParameter(
							"ten_date").trim());
					ordVO.setTen_date(ten_date);
				} catch (IllegalArgumentException e) {
					errorMsgs.put("ten_date", "承租日期請勿空白");
				}

				// exp_date
				java.sql.Date exp_date = null;
				try {
					exp_date = java.sql.Date.valueOf(req.getParameter(
							"exp_date").trim());
					ordVO.setExp_date(exp_date);
				} catch (IllegalArgumentException e) {
					errorMsgs.put("exp_date", "到期日期請勿空白");
				}

				// ten_days
				Integer ten_days = null;
				try {
					ten_days = Integer.parseInt(req.getParameter("ten_days")
							.trim());
					if (ten_days <= 0)
						errorMsgs.put("ten_days", "承租天數不可小於等於零");
					ordVO.setTen_days(ten_days);
				} catch (NumberFormatException e) {
					errorMsgs.put("ten_days", "承租天數請勿空白,或輸入非數字");
				}

				// rent_total
				Integer rent_total = null;
				try {
					rent_total = Integer.parseInt(req
							.getParameter("rent_total").trim());
					ordVO.setRent_total(rent_total);
				} catch (Exception e) {
					errorMsgs.put("rent_total", "總租金請勿空白,或非數字");
				}

				// ot_days
				Integer ot_days = null;
				// try {
				ot_days = 0;
				ordVO.setOt_days(ot_days);
				// } catch (Exception e) {
				// errorMsgs.put("rent_total", "總租金請勿空白,或非數字");
				// }

				// tra_total
				Integer tra_total = null;
				try {
					tra_total = Integer.parseInt(req.getParameter("tra_total").trim());
					
					//比較會員餘額是否可以負擔這筆訂單的總費用
					double mbalance = memberVO.getMbalance();
					if (tra_total > mbalance){
						errorMsgs.put("tra_total", "帳戶餘額不足,無法完成扣款");
					}
					
					ordVO.setTra_total(tra_total);
				} catch (Exception e) {
					errorMsgs.put("tra_total", "交易總額請勿空白,或非數字");
				}

				// init_dps
				Integer init_dps = null;
				try {
					init_dps = Integer.parseInt(req.getParameter("init_dps").trim());
					ordVO.setInit_dps(init_dps);
				} catch (Exception e) {
					errorMsgs.put("init_dps", "原始押金請勿空白,或非數字");
				}

				// real_dps = real_dps
				Integer real_dps = null;
				try {
					real_dps = Integer.parseInt(req.getParameter("init_dps")
							.trim());
					ordVO.setReal_dps(real_dps);
				} catch (Exception e) {
					errorMsgs.put("real_dps", "實際租金請勿空白,或非數字");
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
							.getRequestDispatcher("/front/cart/cartToOrd.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				// OrdService ordSvc = new OrdService();
				// ordSvc.updateOrd(ord_no,tra_mode,freight,ten_date,exp_date,ten_days,rent_total,tra_total,loc_no,rec_addr);
				ordSvc.addOrd(ordVO);
				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				// 移除租物車中該筆租物編號
				int index = 0;
				int del = 0;

				for (String rent : rentList) {
					if (rent_no.equals(rent)) {
						del = index;
					}
					index++;
				}
				rentList.removeElementAt(del);
				session.setAttribute("rentList", rentList);

				// req.setAttribute("ordVO", ordVO); //
				// 資料庫update成功後,正確的的ordVO物件,存入req
				String url = "/front/cart/cart.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneOrd.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處+理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "新增訂單資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/cart/cartToOrd.jsp");
				failureView.forward(req, res);
			}
		}

		// if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求
		//
		// List<String> errorMsgs = new LinkedList<String>();
		// // Store this set in the request scope, in case we need to
		// // send the ErrorPage view.
		// req.setAttribute("errorMsgs", errorMsgs);
		//
		// try {
		// /***************************1.接收請求參數 -
		// 輸入格式的錯誤處理**********************/
		// String str = req.getParameter("empno");
		// if (str == null || (str.trim()).length() == 0) {
		// errorMsgs.add("請輸入員工編號");
		// }
		// // Send the use back to the form, if there were errors
		// if (!errorMsgs.isEmpty()) {
		// RequestDispatcher failureView = req
		// .getRequestDispatcher("/emp/select_page.jsp");
		// failureView.forward(req, res);
		// return;//程式中斷
		// }
		//
		// Integer empno = null;
		// try {
		// empno = new Integer(str);
		// } catch (Exception e) {
		// errorMsgs.add("員工編號格式不正確");
		// }
		// // Send the use back to the form, if there were errors
		// if (!errorMsgs.isEmpty()) {
		// RequestDispatcher failureView = req
		// .getRequestDispatcher("/emp/select_page.jsp");
		// failureView.forward(req, res);
		// return;//程式中斷
		// }
		//
		// /***************************2.開始查詢資料*****************************************/
		// EmpService empSvc = new EmpService();
		// EmpVO empVO = empSvc.getOneEmp(empno);
		// if (empVO == null) {
		// errorMsgs.add("查無資料");
		// }
		// // Send the use back to the form, if there were errors
		// if (!errorMsgs.isEmpty()) {
		// RequestDispatcher failureView = req
		// .getRequestDispatcher("/emp/select_page.jsp");
		// failureView.forward(req, res);
		// return;//程式中斷
		// }
		//
		// /***************************3.查詢完成,準備轉交(Send the Success
		// view)*************/
		// req.setAttribute("empVO", empVO); // 資料庫取出的empVO物件,存入req
		// String url = "/emp/listOneEmp.jsp";
		// RequestDispatcher successView = req.getRequestDispatcher(url); //
		// 成功轉交 listOneEmp.jsp
		// successView.forward(req, res);
		//
		// /***************************其他可能的錯誤處理*************************************/
		// } catch (Exception e) {
		// errorMsgs.add("無法取得資料:" + e.getMessage());
		// RequestDispatcher failureView = req
		// .getRequestDispatcher("/emp/select_page.jsp");
		// failureView.forward(req, res);
		// }
		// }

	}
}
