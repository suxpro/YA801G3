package front.report.controller;

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
import front.report.model.*;
/**
 * Servlet implementation class ReportServletF
 */
@WebServlet("/ReportServletF")
public class ReportServletF extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportServletF() {
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
					"/front/report/images"), 5 * 1024 * 1024, "UTF-8");
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
					errorMsgs.put("rno","請輸入檢舉編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/report/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				String rno = null;
				try {
					rno = new String(str);
				} catch (Exception e) {
					errorMsgs.put("rno","檢舉編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/report/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				ReportDAO dao = new ReportDAO();
				ReportVO reportVO = dao.findByPrimaryKey(rno);
				if (reportVO == null) {
					errorMsgs.put("rno","查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/report/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("reportVO", reportVO); // 資料庫取出的empVO物件,存入req
				String url = "/front/report/listOneReport.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交
																				// listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception","無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/report/select_page.jsp");
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
				ReportService reportSvc = new ReportService();
				ReportVO reportVO = reportSvc.getOneReport(rno);
				
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("reportVO", reportVO); // 資料庫取出的empVO物件,存入req
				String url = "/front/report/update_report_input.jsp";
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

		if ("update".equals(action)) { // 來自update_report_input.jsp的請求

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
				String rm_p = multi.getParameter("rm_p").trim();
				String rr_no = multi.getParameter("rr_no").trim();
				String rm_byp = multi.getParameter("rm_byp").trim();
				java.sql.Date rtime = null;
				try {
					rtime = java.sql.Date.valueOf(multi.getParameter("rtime")
							.trim());
				} catch (IllegalArgumentException e) {
					rtime = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("rtime","請輸入日期!");
				}
				
				String rcuz = multi.getParameter("rcuz").trim();
				if (rcuz == null || (rcuz.trim()).length() == 0) {
					errorMsgs.put("rcuz", "請輸入檢舉原因");
				}

				String re_chk = multi.getParameter("re_chk").trim();
				String rsol = multi.getParameter("rsol").trim();

				java.sql.Date rsolt = null;
				try {
					rsolt = java.sql.Date.valueOf(multi.getParameter("rsolt")
							.trim());
				} catch (IllegalArgumentException e) {
					rtime = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("rsolt","請輸入日期!");
				}
				String rsold = multi.getParameter("rsold").trim();
				if (rsold == null || (rsold.trim()).length() == 0) {
					errorMsgs.put("rsold", "請輸入結果描述");
				}
				
				ReportVO reportVO = new ReportVO();
				reportVO.setRno(rno);
				reportVO.setRm_p(rm_p);
				reportVO.setRr_no(rr_no);
				reportVO.setRm_byp(rm_byp);
				reportVO.setRtime(rtime);
				reportVO.setRcuz(rcuz);
				reportVO.setRe_chk(re_chk);
				reportVO.setRsol(rsol);
				reportVO.setRsolt(rsolt);
				reportVO.setRsold(rsold);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("reportVO", reportVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/report/update_report_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				ReportService reportSvc = new ReportService();
				reportVO = reportSvc.updateReport(rno, rm_p, rr_no, rm_byp,
						rtime, rcuz, re_chk, rsol, rsolt, rsold);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("reportVO", reportVO); // 資料庫update成功後,正確的的empVO物件,存入req
				
				String url = requestURL+"?whichPage="+whichPage+"&rno="+rno; // 送出修改的來源網頁的第幾頁(只用於:istAllEmp.jsp)和修改的是哪一筆
				
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception","修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/report/update_report_input.jsp");
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
				String rm_p = multi.getParameter("rm_p").trim();
				String rr_no = multi.getParameter("rr_no").trim();
				String rm_byp = multi.getParameter("rm_byp").trim();
				java.sql.Date rtime = null;
				try {
					rtime = java.sql.Date.valueOf(multi.getParameter("rtime")
							.trim());
				} catch (IllegalArgumentException e) {
					rtime = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("rtime","請輸入日期!");
				}

				String rcuz = multi.getParameter("rcuz").trim();
				if (rcuz == null || (rcuz.trim()).length() == 0) {
					errorMsgs.put("rcuz", "請輸入檢舉原因");
				}
				String re_chk = multi.getParameter("re_chk").trim();
				String rsol = multi.getParameter("rsol").trim();

				java.sql.Date rsolt = null;
				try {
					rsolt = java.sql.Date.valueOf(multi.getParameter("rsolt")
							.trim());
				} catch (IllegalArgumentException e) {
					rtime = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("rsolt","請輸入日期!");
				}
				
				String rsold = multi.getParameter("rsold").trim();
				if (rsold == null || (rsold.trim()).length() == 0) {
					errorMsgs.put("rsold", "請輸入結果描述");
				}

				ReportVO reportVO = new ReportVO();
			
				reportVO.setRm_p(rm_p);
				reportVO.setRr_no(rr_no);
				reportVO.setRm_byp(rm_byp);
				reportVO.setRtime(rtime);
				reportVO.setRcuz(rcuz);
				reportVO.setRe_chk(re_chk);
				reportVO.setRsol(rsol);
				reportVO.setRsolt(rsolt);
				reportVO.setRsold(rsold);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("reportVO", reportVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/report/addReport.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				ReportService reportSvc = new ReportService();
				reportVO = reportSvc.addReport(rm_p, rr_no, rm_byp,
						rtime, rcuz, re_chk, rsol, rsolt, rsold);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front/report/listAllReport.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/report/addReport.jsp");
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
				ReportService reportSvc = new ReportService();
				reportSvc.deleteReport(rno);

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
