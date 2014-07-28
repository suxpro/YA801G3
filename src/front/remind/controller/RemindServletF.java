package front.remind.controller;

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
import front.remind.model.*;
/**
 * Servlet implementation class RemindServletF
 */
@WebServlet("/RemindServletF")
public class RemindServletF extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemindServletF() {
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
					"/front/remind/images"), 5 * 1024 * 1024, "UTF-8");
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
				String str = req.getParameter("rno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.put("rno","請輸入提醒編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/remind/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				String rno = null;
				try {
					rno = new String(str);
				} catch (Exception e) {
					errorMsgs.put("rno","提醒編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/remind/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				RemindDAO dao = new RemindDAO();
				RemindVO remindVO = dao.findByPrimaryKey(rno);
				if (remindVO == null) {
					errorMsgs.put("rno","查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/remind/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("remindVO", remindVO); // 資料庫取出的empVO物件,存入req
				String url = "/front/remind/listOneRemind.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交
																				// listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception","無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/remind/select_page.jsp");
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
				String rno = req.getParameter("rno");

				/*************************** 2.開始查詢資料 ****************************************/
				RemindService remindSvc = new RemindService();
				RemindVO remindVO = remindSvc.getOneRemind(rno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("remindVO", remindVO); // 資料庫取出的empVO物件,存入req
				String url = "/front/remind/update_remind_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交
																				// update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception","無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_remind_input.jsp的請求

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
				String rno = multi.getParameter("rno").trim();
				String mno = multi.getParameter("mno").trim();
				String rtno = multi.getParameter("rtno").trim();
				java.sql.Date rtime = null;
				try {
					rtime = java.sql.Date.valueOf(multi.getParameter("rtime")
							.trim());
				} catch (IllegalArgumentException e) {
					rtime = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("rtime","請輸入日期!");
				}
				String rstas = multi.getParameter("rstas").trim();
				String rflag = multi.getParameter("rflag").trim();

				RemindVO remindVO = new RemindVO();
				remindVO.setRno(rno);
				remindVO.setMno(mno);
				remindVO.setRtno(rtno);
				remindVO.setRtime(rtime);
				remindVO.setRstas(rstas);
				remindVO.setRflag(rflag);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("remindVO", remindVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/remind/update_remind_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				RemindService remindSvc = new RemindService();
				remindVO = remindSvc.updateRemind(rno, mno, rtno, rtime, rstas,
						rflag);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("remindVO", remindVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = requestURL+"?whichPage="+whichPage+"&rno="+rno; // 送出修改的來源網頁的第幾頁(只用於:istAllEmp.jsp)和修改的是哪一筆
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception","修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/remind/update_remind_input.jsp");
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
				String rtno = multi.getParameter("rtno").trim();
				java.sql.Date rtime = null;
				try {
					rtime = java.sql.Date.valueOf(multi.getParameter("rtime")
							.trim());
				} catch (IllegalArgumentException e) {
					rtime = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("rtime","請輸入日期!");
				}
				String rstas = multi.getParameter("rstas").trim();
				String rflag = multi.getParameter("rflag").trim();

				RemindVO remindVO = new RemindVO();

				remindVO.setMno(mno);
				remindVO.setRtno(rtno);
				remindVO.setRtime(rtime);
				remindVO.setRstas(rstas);
				remindVO.setRflag(rflag);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("remindVO", remindVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/remind/addRemind.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				RemindService remindSvc = new RemindService();
				remindVO = remindSvc.addRemind(mno, rtno, rtime, rstas,
						rflag);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front/remind/listAllRemind.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/remind/addRemind.jsp");
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
				String rno = req.getParameter("rno");

				/*************************** 2.開始刪除資料 ***************************************/
				RemindService remindSvc = new RemindService();
				remindSvc.deleteRemind(rno);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception","刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
	}

}
