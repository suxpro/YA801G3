package back.competence.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import back.competence.model.CompetenceService;
import back.competence.model.CompetenceVO;

import com.oreilly.servlet.MultipartRequest;

public class CompetenceServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {	
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String contentType = req.getContentType();
		// String action = req.getParameter("action");

		MultipartRequest multi = null;
		String action = null;
		if (contentType != null
				&& contentType.startsWith("multipart/form-data")) {
			System.out.println("competenceServlet.51");
			multi = new MultipartRequest(req, getServletContext().getRealPath(
					"/back/competence/images"), 5 * 1024 * 1024, "UTF-8");
			System.out.println("competenceServlet.54");
			action = multi.getParameter("action");
		} else {
			action = req.getParameter("action");
		}

		if ("addCom".equals(action)) { // 來自addCom.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String emp_no = multi.getParameter("addComEmpNo").trim();
				
				String func_no = multi.getParameter("addComFuncNo").trim();
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					System.out.println("有errorMsgs");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/competence/addCom.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				CompetenceService comSvc = new CompetenceService();
				comSvc.addCompetence(emp_no, func_no);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back/competence/listAllCompetence.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/competence/addCom.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // 來自listAllEmp.jsp

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			CompetenceVO empVO = new CompetenceService().getOneCompetence(multi.getParameter("empNo"));
			
			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				//先從資料庫取值以防出錯
				String emp_no = empVO.getEmp_no();
				String func_no = empVO.getFunc_no();
				
				System.out.println("competenceServlet.100.update前:"+emp_no+","+func_no);
				
				emp_no = multi.getParameter("addComEmpNo").trim();
				
				func_no = multi.getParameter("addComFuncNo").trim();
				
				System.out.println("competenceServlet.106.update後:"+emp_no+","+func_no);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					System.out.println("有errorMsgs");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/competence/addCom.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				CompetenceService comSvc = new CompetenceService();
				comSvc.updateCompetence(emp_no, func_no);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back/competence/listAllCompetence.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllCompetence.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/competence/addCom.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("delete".equals(action)) { // 來自listAllCompetence.jsp

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = "/back/competence/listAllCompetence.jsp"; // 送出刪除的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】

			try {
				/*************************** 1.接收請求參數 ***************************************/
				String emp_no = new String(req.getParameter("emp_no"));

				System.out.println("competenceServlet.148."+emp_no+"刪除!");
				/*************************** 2.開始刪除資料 ***************************************/
				CompetenceService empSvc = new CompetenceService();
				empSvc.deleteCompetence(emp_no);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
		

	}
}
