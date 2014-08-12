package front.prerent.controller;

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
import front.prerent.model.*;
/**
 * Servlet implementation class PrentServletF
 */
@WebServlet("/PrentServletF")
public class PrentServletF extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PrentServletF() {
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
					"/front/prent/images"), 5 * 1024 * 1024, "UTF-8");
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
				String str = req.getParameter("prent_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.put("prent_no", "請輸入預租編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/prent/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				String prent_no = null;
				try {
					prent_no = new String(str);
				} catch (Exception e) {
					errorMsgs.put("prent_no", "預租編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/prent/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				PrentDAO dao = new PrentDAO();
				PrentVO prentVO = dao.findByPrimaryKey(prent_no);
				if (prentVO == null) {
					errorMsgs.put("prent_no", "查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/prent/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("prentVO", prentVO); // 資料庫取出的empVO物件,存入req
				String url = "/front/prent/listOnePrent.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交
																				// listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/prent/select_page.jsp");
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
				String prent_no = req.getParameter("prent_no");

				/*************************** 2.開始查詢資料 ****************************************/
				PrentService prentSvc = new PrentService();
				PrentVO prentVO = prentSvc.getOnePrent(prent_no);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("prentVO", prentVO); // 資料庫取出的empVO物件,存入req
				String url = "/front/prent/update_prent_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交
																				// update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}

//		if ("update".equals(action)) { // 來自update_prent_input.jsp的請求
//
//			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//			
//			String requestURL = multi.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】
//			req.setAttribute("requestURL", requestURL); // 送出修改的來源網頁路徑, 存入req
//			
//			String whichPage = multi.getParameter("whichPage"); // 送出修改的來源網頁的第幾頁(只用於:istAllEmp.jsp)
//			req.setAttribute("whichPage", whichPage);   // 送出修改的來源網頁的第幾頁, 存入req(只用於:istAllEmp.jsp)
//
//			try {
//				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
//				String prent_no = multi.getParameter("prent_no").trim();
//				String rent_no = multi.getParameter("rent_no").trim();
//				String ten_no = multi.getParameter("ten_no").trim();
//				java.sql.Date prent_time = null;
//				try {
//					prent_time = java.sql.Date.valueOf(multi.getParameter(
//							"prent_time").trim());
//				} catch (IllegalArgumentException e) {
//					prent_time = new java.sql.Date(System.currentTimeMillis());
//					errorMsgs.put("prent_time", "請輸入日期!");
//				}
//				Integer prent_days = null;
//				try {
//					prent_days = new Integer(multi.getParameter("prent_days")
//							.trim());
//				} catch (NumberFormatException e) {
//					prent_days = 0;
//					errorMsgs.put("prent_days", "預租天數請填數字.");
//				}
//				String prent_flag = multi.getParameter("prent_flag").trim();
//				String ord_no = multi.getParameter("ord_no").trim();
//
//				PrentVO prentVO = new PrentVO();
//				prentVO.setPrent_no(prent_no);
//				prentVO.setRent_no(rent_no);
//				prentVO.setTen_no(ten_no);
//				prentVO.setPrent_time(prent_time);
//				prentVO.setPrent_days(prent_days);
//				prentVO.setPrent_flag(prent_flag);
//				prentVO.setOrd_no(ord_no);
//
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("prentVO", prentVO); // 含有輸入格式錯誤的empVO物件,也存入req
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front/prent/update_prent_input.jsp");
//					failureView.forward(req, res);
//					return; // 程式中斷
//				}
//
//				/*************************** 2.開始修改資料 *****************************************/
//				PrentService prentSvc = new PrentService();
//				prentVO = prentSvc.updatePrent(prent_no, rent_no, ten_no, prent_time,
//						 prent_days, prent_flag, ord_no);
//
//				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
//				req.setAttribute("prentVO", prentVO); // 資料庫update成功後,正確的的empVO物件,存入req
//				
//				String url = requestURL+"?whichPage="+whichPage+"&prent_no="+prent_no; // 送出修改的來源網頁的第幾頁(只用於:istAllEmp.jsp)和修改的是哪一筆
//				
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
//				successView.forward(req, res);
//
//				/*************************** 其他可能的錯誤處理 *************************************/
//			} catch (Exception e) {
//				errorMsgs.put("Exception", "修改資料失敗:" + e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front/prent/update_prent_input.jsp");
//				failureView.forward(req, res);
//			}
//		}

		if ("insert".equals(action)) { // 來自addEmp.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/

				String rent_no = multi.getParameter("rent_no").trim();
				String ten_no = multi.getParameter("ten_no").trim();
			    //萬思賢修改
//				java.sql.Date prent_time = null;
//				try {
//					prent_time = java.sql.Date.valueOf(multi.getParameter(
//							"prent_time").trim());
//				} catch (IllegalArgumentException e) {
//					prent_time = new java.sql.Date(System.currentTimeMillis());
//					errorMsgs.put("prent_time", "請輸入日期!");
//				}

				Integer prent_days = null;
				try {
					prent_days = new Integer(multi.getParameter("prent_days")
							.trim());
				} catch (NumberFormatException e) {
					prent_days = 0;
					errorMsgs.put("prent_days", "預租天數請填數字.");
				}

				String prent_flag = multi.getParameter("prent_flag").trim();
				String ord_no = multi.getParameter("ord_no").trim();

				PrentVO prentVO = new PrentVO();

				prentVO.setRent_no(rent_no);
				prentVO.setTen_no(ten_no);
				// 時間由資料庫自己寫入
//				prentVO.setPrent_time(prent_time);
				prentVO.setPrent_days(prent_days);
				prentVO.setPrent_flag(prent_flag);
				prentVO.setOrd_no(ord_no);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("prentVO", prentVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/prent/addPrent.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				PrentService prentSvc = new PrentService();
				prentSvc.addPrent(prentVO);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front/prent/listAllPrent.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/prent/addPrent.jsp");
				failureView.forward(req, res);
			}
		}

		if ("delete".equals(action)) { 

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/*************************** 1.接收請求參數 ***************************************/
				String prent_no = req.getParameter("prent_no");

				/*************************** 2.開始刪除資料 ***************************************/
				PrentService prentSvc = new PrentService();
				prentSvc.deletePrent(prent_no);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/front/prent/preRentList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/prent/preRentList.jsp");
				failureView.forward(req, res);
			}
		}
	}

}
