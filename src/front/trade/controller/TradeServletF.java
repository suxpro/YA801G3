package front.trade.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import front.trade.model.*;
/**
 * Servlet implementation class TradeServletF
 */
@WebServlet("/TradeServletF")
public class TradeServletF extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TradeServletF() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
		}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String contentType = req.getContentType();
		// String action = req.getParameter("action");

		MultipartRequest multi = null;
		String action = null;
		if (contentType != null
				&& contentType.startsWith("multipart/form-data")) {
			multi = new MultipartRequest(req, getServletContext().getRealPath(
					"/front/trade/images"), 5 * 1024 * 1024, "UTF-8");
			action = multi.getParameter("action");
		} else {
			action = req.getParameter("action");
		}

		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("tno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.put("tno", "請輸入交易編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/trade/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				String tno = null;
				try {
					tno = new String(str);
				} catch (Exception e) {
					errorMsgs.put("tno", "交易編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/trade/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				TradeDAO dao = new TradeDAO();
				TradeVO tradeVO = dao.findByPrimaryKey(tno);
				if (tradeVO == null) {
					errorMsgs.put("tno", "查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/trade/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("tradeVO", tradeVO); // 資料庫取出的empVO物件,存入req
				String url = "/front/trade/listOneTrade.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交
																				// listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/trade/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】
			req.setAttribute("requestURL", requestURL); // 送出修改的來源網頁路徑, 存入req (是為了給update_emp_input.jsp)
			
			String whichPage = req.getParameter("whichPage");
			req.setAttribute("whichPage", whichPage);   // 送出修改的來源網頁的第幾頁, 存入req(只用於:istAllEmp.jsp)
			try {
				/*************************** 1.接收請求參數 ****************************************/
				String tno = req.getParameter("tno");

				/*************************** 2.開始查詢資料 ****************************************/
				TradeService tradeSvc = new TradeService();
				TradeVO tradeVO = tradeSvc.getOneTrade(tno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("tradeVO", tradeVO); // 資料庫取出的empVO物件,存入req
				String url = "/front/trade/update_trade_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_trade_input.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = multi.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】
			req.setAttribute("requestURL", requestURL); // 送出修改的來源網頁路徑, 存入req
			
			String whichPage = multi.getParameter("whichPage"); // 送出修改的來源網頁的第幾頁(只用於:istAllEmp.jsp)
			req.setAttribute("whichPage", whichPage);   // 送出修改的來源網頁的第幾頁, 存入req(只用於:istAllEmp.jsp)
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String tno = multi.getParameter("tno").trim();
				String mno = multi.getParameter("mno").trim();
				String tmid = multi.getParameter("tmid").trim();
				if (tmid == null || (tmid.trim()).length() == 0) {
					errorMsgs.put("tmid", "請輸入金融會員帳號16個數字");
				}

				java.sql.Date tdate = null;
				try {
					tdate = java.sql.Date.valueOf(multi.getParameter("tdate")
							.trim());
				} catch (IllegalArgumentException e) {
					tdate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("tdate", "請輸入日期!");
				}
				String tstas = multi.getParameter("tstas").trim();
				Double tfunds = null;
				try {
					tfunds = new Double(multi.getParameter("tfunds").trim());
				} catch (NumberFormatException e) {
					tfunds = 0.0;
					errorMsgs.put("tfunds", "交易款項請填數字.");
				}
				
				String tin = multi.getParameter("tin").trim();

				TradeVO tradeVO = new TradeVO();
				tradeVO.setTno(tno);
				tradeVO.setMno(mno);
				tradeVO.setTmid(tmid);
				tradeVO.setTdate(tdate);
				tradeVO.setTstas(tstas);
				tradeVO.setTfunds(tfunds);
				tradeVO.setTin(tin);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("tradeVO", tradeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/trade/update_trade_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				TradeService tradeSvc = new TradeService();
				tradeVO = tradeSvc.updateTrade(tno, mno, tmid, tdate, tstas,
						tfunds, tin);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("tradeVO", tradeVO); // 資料庫update成功後,正確的的empVO物件,存入req
				
				String url = requestURL+"?whichPage="+whichPage+"&tno="+tno; // 送出修改的來源網頁的第幾頁(只用於:istAllEmp.jsp)和修改的是哪一筆
				
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/trade/update_trade_input.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) { // 來自addEmp.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String mno = multi.getParameter("mno").trim();
				String tmid = multi.getParameter("tmid").trim();
				if (tmid == null || (tmid.trim()).length() == 0) {
					errorMsgs.put("tmid", "請輸入金融會員帳號16個數字");
				}
				java.sql.Date tdate = null;
				try {
					tdate = java.sql.Date.valueOf(multi.getParameter("tdate")
							.trim());
				} catch (IllegalArgumentException e) {
					tdate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("tdate", "請輸入日期!");
				}
				String tstas = multi.getParameter("tstas").trim();
				Double tfunds = null;
				try {
					tfunds = new Double(multi.getParameter("tfunds").trim());
				} catch (NumberFormatException e) {
					tfunds = 0.0;
					errorMsgs.put("tfunds", "交易款項請填數字.");
				}
				
				String tin = multi.getParameter("tin").trim();

				TradeVO tradeVO = new TradeVO();
				tradeVO.setMno(mno);
				tradeVO.setTmid(tmid);
				tradeVO.setTdate(tdate);
				tradeVO.setTstas(tstas);
				tradeVO.setTfunds(tfunds);
				tradeVO.setTin(tin);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("tradeVO", tradeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/trade/addTrade.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				TradeService tradeSvc = new TradeService();
				tradeVO = tradeSvc.addTrade(mno, tmid, tdate, tstas, tfunds,
						tin);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front/trade/listAllTrade.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/trade/addTrade.jsp");
				failureView.forward(req, res);
			}
		}

		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出刪除的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】

			try {
				/*************************** 1.接收請求參數 ***************************************/
				String tno = req.getParameter("tno");

				/*************************** 2.開始刪除資料 ***************************************/
				TradeService tradeSvc = new TradeService();
				tradeSvc.deleteTrade(tno);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				
				
//				String url = "/trade/listAllTrade.jsp";
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "刪除資料失敗:" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/trade/listAllTrade.jsp");
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
	}

}
