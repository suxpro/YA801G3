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


		if ("cancel".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			Map<String, String> alertMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("alertMsgs", alertMsgs);

			OrdService ordSvc = new OrdService();
			OrdVO ordVO = new OrdVO();
			String url = null;
			
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
				if(!ord_sta.equals("W_APR") && !ord_sta.equals("RE_ORD") ){
					//errorMsgs.put("ord_sta","訂單狀態非[待核准],無法取消訂單");
					errorMsgs.put("alert","訂單狀態非[待核准或待續約],無法取消訂單");
				}

				// ord_cc_cause
				String ord_cc_cause = req.getParameter("ord_cc_cause").trim();
				if (ord_cc_cause == null || ord_cc_cause.trim().length() == 0) {
					errorMsgs.put("ord_cc_cause", "取消原因請勿空白");
				} else {
					 ordVO.setOrd_cc_cause(ord_cc_cause);
				}
				
				// role 判斷是出租者還是承租者取消的
				String role = req.getParameter("role").trim();
				if (role == null || role.trim().length() == 0) {
					errorMsgs.put("role", "角色請勿空白");
				} 

				//判定原先頁面
				if(role.equals("les")){
					url = "/front/ord/lesOrdList.jsp";
				}
				else{
					url = "/front/ord/tenOrdList.jsp";
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher(url);
					failureView.forward(req, res);
					return;
				}
//				// Send the use back to the form, if there were errors
//				if (!alertMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front/ord/tenOrdList.jsp");
//					failureView.forward(req, res);
//					return;
//				}
				/*************************** 2.開始刪除資料 ***************************************/
//				ordSvc.deleteOrd(ord_no, ord_cc_cause);
				ordSvc.deleteOrd(ordVO, role);
				alertMsgs.put("alert", "訂單[" + ord_no + "]刪除成功");
				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(url);
				failureView.forward(req, res);
			}
		}
		
		//新增續約
		if ("renew".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			Map<String, String> alertMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("alertMsgs", alertMsgs);

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
				
				// ord_sta
				String ord_sta = "RE_ORD";
				if (ord_sta == null || ord_sta.trim().length() == 0) {
					errorMsgs.put("ord_sta", "更新的狀態請勿空白");
				}else{
					ordVO.setOrd_sta(ord_sta);
				}
					
				// exp_date (new)
				java.sql.Date exp_date = null;
				try {
					exp_date = java.sql.Date.valueOf(req.getParameter("nexp_date").trim());
					ordVO.setExp_date(exp_date);
				} catch (IllegalArgumentException e) {
					errorMsgs.put("exp_date", "承租日期請勿空白");
				}
				
				// ten_days
				Integer ten_days = null;
				Integer ext_days = null;
				try {
					ext_days = Integer.parseInt(req.getParameter("ext_days").trim());
					if (ext_days <= 0)
						errorMsgs.put("ext_days", "續約天數不可小於等於零");
					ten_days = ordVO.getTen_days();
					ten_days = ten_days + ext_days;
					ordVO.setTen_days(ten_days);
				} catch (NumberFormatException e) {
					errorMsgs.put("ext_days", "續約天數請勿空白,或輸入非數字");
				}
				
				// rent_total
				Integer rent_total = null;
				Integer dif_price = null;
				try {
					dif_price = Integer.parseInt(req.getParameter("dif_price").trim());
					if (dif_price <= 0)
						errorMsgs.put("dif_price", "需補差額不可小於等於零");
					rent_total = ordVO.getRent_total();
					rent_total = rent_total + dif_price;
					ordVO.setRent_total(rent_total);
				} catch (NumberFormatException e) {
					errorMsgs.put("dif_price", "需補差額請勿空白,或輸入非數字");
				}				
				
				//比較會員餘額是否可以負擔這筆訂單的差額	
				MemberService memberSVC = new MemberService();
				MemberVO memberVO = memberSVC.getOneMember(ordVO.getTen_no());
				double mbalance = memberVO.getMbalance();
				if (dif_price > mbalance){
					errorMsgs.put("tra_total", "帳戶餘額不足,無法完成扣款");
				}
				
				// tra_total
				Integer tra_total = null;
				try {
					tra_total = ordVO.getTra_total();
					tra_total = tra_total + dif_price;
					ordVO.setTra_total(tra_total);
				} catch (NullPointerException e) {
					errorMsgs.put("tra_total", "交易總額請勿空白,或輸入非數字");
				}					
								
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/ord/tenOrdList.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				ordSvc.renew(ordVO, dif_price);
				alertMsgs.put("alert", "訂單[" + ord_no + "]續約請求送出");
				/*************************** 3./新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front/ord/tenOrdList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 更新成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "新增資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/ord/tenOrdList.jsp");
				failureView.forward(req, res);
			}
		}
		
		//更新訂單狀態
		if ("update".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			Map<String, String> alertMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("alertMsgs", alertMsgs);

			OrdService ordSvc = new OrdService();
			OrdVO ordVO = new OrdVO();
			
			String reqURL = null;

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
				
				//ord_sta
//				String ord_sta = ordVO.getOrd_sta();
				
				// sta
				String sta = req.getParameter("sta").trim();
				if (sta == null || sta.trim().length() == 0) {
					errorMsgs.put("sta", "更新的狀態請勿空白");
				}
				
				// 如果sta = "CLS" 在訂單結案前  系統先檢查 雙方 評價分數是否已填寫
				if (sta.equals("CLS")) {					
					if(ordVO.getLes_ases_ct() == null && ordVO.getTen_ases_ct() == null){
						errorMsgs.put("ases", "出租會員與承租會員皆未完成評價動作");
					} else if(ordVO.getLes_ases_ct() == null){
						errorMsgs.put("ases", "承租會員尚未完成評價動作");
					} else if(ordVO.getTen_ases_ct() == null){
						errorMsgs.put("ases", "出租會員尚未完成評價動作");
					}					
				} 
				
				// reqURL
				reqURL = req.getParameter("reqURL").trim();
				if (reqURL == null || reqURL.trim().length() == 0) {
					errorMsgs.put("reqURL", "來源網址請勿空白");
				}
				
				//檢查訂單狀態是否仍是待核准
//				String ord_sta = ordVO.getOrd_sta();
//				if(!ord_sta.equals("W_APR")){
//					//errorMsgs.put("ord_sta","訂單狀態非[待核准],無法取消訂單");
//					errorMsgs.put("alert","訂單狀態非[待核准],無法取消訂單");
//				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher(reqURL);
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始更新資料 ***************************************/
				ordSvc.updateOrd(ordVO, sta);
				
				//回傳頁面alert
				if(sta.equals("APP_RENEW")){
					alertMsgs.put("alert", "續約訂單[" + ord_no + "]核准成功");
				} else if(sta.equals("W_SHIP")){
					alertMsgs.put("alert", "訂單[" + ord_no + "]核准成功");
				} else if(sta.equals("REC_COM")){
					alertMsgs.put("alert", "訂單[" + ord_no + "]狀態已更新為收貨完成");
				} else if(sta.equals("RT_COM")){
					alertMsgs.put("alert", "訂單[" + ord_no + "]狀態已更新為回收完成");
				} else if(sta.equals("CLS")){
					alertMsgs.put("alert", "訂單[" + ord_no + "]狀態已更新為結案");
				}
				
				/*************************** 3./更新完成,準備轉交(Send the Success view) ***********/
				RequestDispatcher successView = req.getRequestDispatcher(reqURL);// 更新成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "更新資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(reqURL);
				failureView.forward(req, res);
			}
		}

		//更新訂單狀態
		if ("update_ases".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			Map<String, String> alertMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("alertMsgs", alertMsgs);

			OrdService ordSvc = new OrdService();
			OrdVO ordVO = new OrdVO();
			
			String reqURL = null;

//			try {
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
				
				//ord_sta
//				String ord_sta = ordVO.getOrd_sta();
				
				// role 判斷是出租者還是承租者取消的
				String role = req.getParameter("role").trim();
				if (role == null || role.trim().length() == 0) {
					errorMsgs.put("role", "角色請勿空白");
				} 

				// ases 評價等級
				Integer ases = null;
				try {
					ases = Integer.parseInt(req.getParameter("ases").trim());
				} catch (Exception e) {
					errorMsgs.put("ases", "評價等級為必須點選");
				}
				
				// ases_ct 評價內容
				String ases_ct = req.getParameter("ases_ct").trim();
				if (ases_ct == null || ases_ct.trim().length() == 0) {
					ases_ct="沒有任何意見";
//					errorMsgs.put("ases_ct", "評價內容請勿空白");
				} 
				
				// 避免重複發送評價
				if(role.equals("ten")){
					if(ordVO.getLes_ases_ct() != null){
						errorMsgs.put("ases", "先前已完成評價動作");
					} else{
						ordVO.setLes_ases(ases);
						ordVO.setLes_ases_ct(ases_ct);
					}

				} else if(role.equals("les")) {				
					if(ordVO.getTen_ases_ct() != null){
						errorMsgs.put("ases", "先前已完成評價動作");
					} else{
						ordVO.setTen_ases(ases);
						ordVO.setTen_ases_ct(ases_ct);
					}
				}
				
				// reqURL
				reqURL = req.getParameter("reqURL").trim();
				if (reqURL == null || reqURL.trim().length() == 0) {
					errorMsgs.put("reqURL", "來源網址請勿空白");
				}
				
				//檢查訂單狀態是否仍是待核准
//				String ord_sta = ordVO.getOrd_sta();
//				if(!ord_sta.equals("W_APR")){
//					//errorMsgs.put("ord_sta","訂單狀態非[待核准],無法取消訂單");
//					errorMsgs.put("alert","訂單狀態非[待核准],無法取消訂單");
//				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher(reqURL);
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始更新資料 ***************************************/
				ordSvc.updateAses(ordVO, role);
				
				alertMsgs.put("alert", "送出評價成功");
								
				/*************************** 3./更新完成,準備轉交(Send the Success view) ***********/
				RequestDispatcher successView = req.getRequestDispatcher(reqURL);// 更新成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
//			} catch (Exception e) {
//				errorMsgs.put("Exception", "更新資料失敗:" + e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher(reqURL);
//				failureView.forward(req, res);
//			}
		}		
		
		// for listOneOrd.jsp using
		if ("getOne_For_Display".equals(action)) {
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數****************************************/
				String ord_no= req.getParameter("ord_no");
				if (ord_no == null || ord_no.trim().length() == 0) {
					errorMsgs.put("ord_no","訂單編號不能為空");
				}
		
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front/ord/listOneOrd.jsp");
					failureView.forward(req, res);
					return;
				}
		
				/***************************2.開始查詢資料****************************************/
				OrdService ordSvc = new OrdService();
				OrdVO ordVO = ordSvc.getOneOrd(ord_no);
		
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("ordVO", ordVO); // 資料庫取出的ordVO物件,存入req
				String url = "/front/ord/listOneOrd.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_ord_input.jsp
				successView.forward(req, res);
		
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception","無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front/ord/listOneOrd.jsp");
				failureView.forward(req, res);
			}
		 }
		
		//承租人遞交訂單
		if ("insert".equals(action)) { // 來自cartToOrd.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			Map<String, String> alertMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("alertMsgs", alertMsgs);

			RentService rentSVC = new RentService();
			RentVO rentVO =new RentVO();
			
			MemberService memberSVC = new MemberService();
			MemberVO memberVO = new MemberVO();
			
			OrdService ordSvc = new OrdService();
			OrdVO ordVO = new OrdVO();
			// 取的租物車中的清單
			HttpSession session = req.getSession();
			Vector<String> rentList = (Vector<String>) session.getAttribute("rentList");
			
			String requestURL = null;

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
				
				// requestURL
				requestURL = req.getParameter("requestURL").trim();
				if (requestURL == null || requestURL.trim().length() == 0) {
					errorMsgs.put("requestURL", "來源網址請勿空白");
				} 

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("ordVO", ordVO); // 含有輸入格式錯誤的ordVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/ord/addOrd.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				// OrdService ordSvc = new OrdService();
				// ordSvc.updateOrd(ord_no,tra_mode,freight,ten_date,exp_date,ten_days,rent_total,tra_total,loc_no,rec_addr);
				ordSvc.addOrd(ordVO);
				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				if(requestURL.equals("/front/cart/cart.jsp"))
				{
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
				}
				
				//成功提示
				alertMsgs.put("alert", "訂單產生成功");
				// req.setAttribute("ordVO", ordVO); //
				// 資料庫update成功後,正確的的ordVO物件,存入req
				RequestDispatcher successView = req.getRequestDispatcher(requestURL); // 修改成功後,轉交listOneOrd.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處+理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "新增訂單資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}


//		if ("getOne_For_Display".equals(action)) { 
//			
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//		
//			try {
//				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//				String str = req.getParameter("ord");
//				if (str == null || (str.trim()).length() == 0) {
//					errorMsgs.add("請輸入員工編號");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req.getRequestDispatcher("/emp/select_page.jsp");
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
//					RequestDispatcher failureView = req.getRequestDispatcher("/emp/select_page.jsp");
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
//					RequestDispatcher failureView = req.getRequestDispatcher("/emp/select_page.jsp");
//					failureView.forward(req, res);
//					return;//程式中斷
//				}
//		
//				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
//				req.setAttribute("empVO", empVO); // 資料庫取出的empVO物件,存入req
//				String url = "/emp/listOneEmp.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); //
//				成功轉交 listOneEmp.jsp
//				successView.forward(req, res);
//		
//			/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法取得資料:" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/emp/select_page.jsp");
//				failureView.forward(req, res);
//			}
//		 }

	}
}
