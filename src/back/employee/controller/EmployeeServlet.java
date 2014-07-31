package back.employee.controller;

import java.io.*;
import java.sql.Date;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import back.employee.model.*;
import back.member.model.MemberService;

import com.oreilly.servlet.MultipartRequest;

public class EmployeeServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		EmployeeService srv = new EmployeeService();
		res.setCharacterEncoding("Big5");
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		
		try {
			String emp_no = req.getParameter("emp_no");
			EmployeeVO employeeVO = srv.getOneEmp(emp_no);
			if (employeeVO != null) {
				
				out.write(employeeVO.getEmp_pic());
				
			} else {
				res.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		} catch (Exception e) {
			System.out.println("沒有圖拉!");
		}
		
//		doPost(req, res);
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
			System.out.println("EmployeeServlet.51");
			multi = new MultipartRequest(req, getServletContext().getRealPath(
					"/back/employee/images"), 5 * 1024 * 1024, "UTF-8");
			System.out.println("EmployeeServlet.54");
			action = multi.getParameter("action");
		} else {
			action = req.getParameter("action");
		}

		if ("addEmp".equals(action)) { // 來自addEmp.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String emp_id_pwd_Reg = "^[(a-zA-Z0-9_)]{2,10}$";

				String emp_id = multi.getParameter("addEmpAccount").trim();
				if (emp_id == null || emp_id.trim().length() == 0) {
					errorMsgs.put("emp_id", "帳號: 請勿空白");
					System.out.println("帳號: 請勿空白");
				} else if (!emp_id.trim().matches(emp_id_pwd_Reg)) { // 以下正則(規)表示式(regular-expression)
					errorMsgs.put("emp_id",
							"帳號: 只能是英文字母、數字和_ , 且長度必需在2到10之間");
				}
				
				String emp_pwd = multi.getParameter("addEmpPassword").trim();
				if (emp_pwd == null || emp_pwd.trim().length() == 0) {
					errorMsgs.put("emp_pwd", "密碼: 請勿空白");
				} else if (!emp_pwd.trim().matches(emp_id_pwd_Reg)) { // 以下正則(規)表示式(regular-expression)
					errorMsgs.put("emp_pwd",
							"密碼: 只能是英文字母、數字和_ , 且長度必需在2到10之間");
				}

				String emp_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				String emp_name = multi.getParameter("addEmpName").trim();
				if (emp_name == null || emp_name.trim().length() == 0) {
					errorMsgs.put("emp_name", "姓名: 請勿空白");
				} else if (!emp_name.trim().matches(emp_nameReg)) { // 以下正則(規)表示式(regular-expression)
					errorMsgs.put("emp_name",
							"姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}
				
				String emp_sex = multi.getParameter("addEmpSex").trim();
				
				String emp_tel = multi.getParameter("addEmpTel").trim();
				
				String emp_cell = multi.getParameter("addEmpCell").trim();
				if (emp_cell == null || emp_cell.trim().length() == 0) {
					errorMsgs.put("emp_cell", "手機: 請勿空白");
				}
				
				String emp_mail = multi.getParameter("addEmpEmail").trim();
				
				String emp_addr = multi.getParameter("addEmpAddress").trim();
				if (emp_addr == null || emp_addr.trim().length() == 0) {
					errorMsgs.put("emp_addr", "地址: 請勿空白");
				}
				
				String emp_job = multi.getParameter("addEmpJob").trim();
				
				Integer emp_sal = null;
				try {
					emp_sal = new Integer(multi.getParameter("addEmpSal").trim());
				} catch (NumberFormatException e) {
					errorMsgs.put("emp_sal", "薪水請填數字");
				}
				
				Date emp_tod = null;
				try {
					emp_tod = Date.valueOf(multi.getParameter("addEmpTOD"));
				} catch (IllegalArgumentException e) {
					errorMsgs.put("emp_tod", "到職日: 請輸入日期");
				}

				Date emp_lod = null;

				String emp_ecp = multi.getParameter("addEmpECP");
				if (emp_ecp == null || emp_ecp.trim().length() == 0) {
					errorMsgs.put("emp_ecp", "緊急聯絡人: 請勿空白");
				}
				
				String emp_ecell = multi.getParameter("addEmpECell");
				if (emp_ecell == null || emp_ecell.trim().length() == 0) {
					errorMsgs.put("emp_ecell", "緊急聯絡人電話: 請勿空白");
				}
				
				byte[] emp_pic = null;
				File file = null;
				try {
					file = multi.getFile("addEmpPic");
					FileInputStream fis = new FileInputStream(file);
					int len = fis.available();
					emp_pic = new byte[len];
					fis.read(emp_pic);
					fis.close();
				} catch (NullPointerException e) {
					errorMsgs.put("emp_pic", "圖片: 上傳錯誤");
				}
				
				String emp_format = null;
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					System.out.println("有errorMsgs");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/employee/addEmp.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				EmployeeService empSvc = new EmployeeService();
				empSvc.addEmployee(emp_id, emp_pwd, emp_name, emp_sex, emp_tel,
						emp_cell, emp_mail, emp_addr, emp_job, emp_sal,
						emp_tod, emp_lod, emp_ecp, emp_ecell, emp_pic,
						emp_format);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back/employee/listAllEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/employee/addEmp.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // 來自listAllEmp.jsp

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			EmployeeVO empVO = new EmployeeService().getOneEmp(multi.getParameter("empNo"));
			
			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				//先從資料庫取值以防出錯
				String emp_no = empVO.getEmp_no();
				String emp_id = empVO.getEmp_id();
				String emp_pwd = empVO.getEmp_pwd();
				String emp_name = empVO.getEmp_name();
				String emp_sex = empVO.getEmp_sex();
				String emp_tel = empVO.getEmp_tel();
				String emp_cell = empVO.getEmp_cell();
				String emp_mail = empVO.getEmp_mail();
				String emp_addr = empVO.getEmp_addr();
				String emp_job = empVO.getEmp_job();
				Integer emp_sal = empVO.getEmp_sal();
				Date emp_tod = empVO.getEmp_tod();
				Date emp_lod = empVO.getEmp_lod();
				String emp_ecp = empVO.getEmp_ecp();
				String emp_ecell = empVO.getEmp_ecell();
				byte[] emp_pic = empVO.getEmp_pic();
				String emp_format = empVO.getEmp_format();
				
				System.out.println(emp_no+","+emp_id+","+emp_pwd+","+emp_name+","+emp_sex+","+
						emp_tel+","+emp_cell+","+emp_mail+","+emp_addr+","+emp_job+","+emp_sal+","+
						emp_tod+","+emp_lod+","+emp_ecp+","+emp_ecell);			
				
				String emp_id_pwd_Reg = "^[(a-zA-Z0-9_)]{2,10}$";

				emp_id = multi.getParameter("empId").trim();
				if (emp_id == null || emp_id.trim().length() == 0) {
					errorMsgs.put("emp_id", "帳號: 請勿空白");
					System.out.println("帳號: 請勿空白");
				} else if (!emp_id.trim().matches(emp_id_pwd_Reg)) { // 以下正則(規)表示式(regular-expression)
					errorMsgs.put("emp_id",
							"帳號: 只能是英文字母、數字和_ , 且長度必需在2到10之間");
				}

//				emp_pwd = multi.getParameter("addEmpPassword").trim();
//				if (emp_pwd == null || emp_pwd.trim().length() == 0) {
//					errorMsgs.put("emp_pwd", "密碼: 請勿空白");
//				} else if (!emp_pwd.trim().matches(emp_id_pwd_Reg)) { // 以下正則(規)表示式(regular-expression)
//					errorMsgs.put("emp_pwd",
//							"密碼: 只能是英文字母、數字和_ , 且長度必需在2到10之間");
//				}
				
				String emp_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				emp_name = multi.getParameter("empName").trim();
				if (emp_name == null || emp_name.trim().length() == 0) {
					errorMsgs.put("emp_name", "姓名: 請勿空白");
				} else if (!emp_name.trim().matches(emp_nameReg)) { // 以下正則(規)表示式(regular-expression)
					errorMsgs.put("emp_name",
							"姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}
				
				emp_sex = multi.getParameter("empSex").trim();
				
				emp_tel = multi.getParameter("empTel").trim();
				
				emp_cell = multi.getParameter("empCell").trim();
				if (emp_cell == null || emp_cell.trim().length() == 0) {
					errorMsgs.put("emp_cell", "手機: 請勿空白");
				}
				
				emp_mail = multi.getParameter("empMail").trim();
				
				emp_addr = multi.getParameter("empAddr").trim();
				if (emp_addr == null || emp_addr.trim().length() == 0) {
					errorMsgs.put("emp_addr", "地址: 請勿空白");
				}
				
				emp_job = multi.getParameter("empJob").trim();
				
				try {
					emp_sal = new Integer(multi.getParameter("empSal").trim());
				} catch (NumberFormatException e) {
					errorMsgs.put("emp_sal", "薪水請填數字");
				}

				try {
					emp_tod = Date.valueOf(multi.getParameter("empTod"));
				} catch (IllegalArgumentException e) {
					errorMsgs.put("emp_tod", "到職日: 請輸入日期");
				}

//				emp_lod = null;

				emp_ecp = multi.getParameter("empEcp");
				if (emp_ecp == null || emp_ecp.trim().length() == 0) {
					errorMsgs.put("emp_ecp", "緊急聯絡人: 請勿空白");
				}
				
				emp_ecell = multi.getParameter("empEcell");
				if (emp_ecell == null || emp_ecell.trim().length() == 0) {
					errorMsgs.put("emp_ecell", "緊急聯絡人電話: 請勿空白");
				}
				
//				emp_pic = null;
//				File file = null;
//				try {
//					file = multi.getFile("addEmpPic");
//					FileInputStream fis = new FileInputStream(file);
//					int len = fis.available();
//					emp_pic = new byte[len];
//					fis.read(emp_pic);
//					fis.close();
//				} catch (NullPointerException e) {
//					errorMsgs.put("emp_pic", "圖片: 上傳錯誤");
//				}
				
//				emp_format = null;
				
				System.out.println(emp_no+","+emp_id+","+emp_pwd+","+emp_name+","+emp_sex+","+
						emp_tel+","+emp_cell+","+emp_mail+","+emp_addr+","+emp_job+","+emp_sal+","+
						emp_tod+","+emp_lod+","+emp_ecp+","+emp_ecell);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					System.out.println("有errorMsgs");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/employee/addEmp.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				EmployeeService empSvc = new EmployeeService();
				empSvc.updateEmployee(emp_no, emp_id, emp_pwd, emp_name, emp_sex,
						emp_tel, emp_cell, emp_mail, emp_addr, emp_job, emp_sal,
						emp_tod, emp_lod, emp_ecp, emp_ecell, emp_pic, emp_format);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back/employee/listAllEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/employee/addEmp.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = "/back/employee/listAllEmp.jsp"; // 送出刪除的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】

			try {
				/*************************** 1.接收請求參數 ***************************************/
				String emp_no = new String(req.getParameter("emp_no"));

				System.out.println("EmployeeServlet.198."+emp_no+"刪除!");
				/*************************** 2.開始刪除資料 ***************************************/
				EmployeeService empSvc = new EmployeeService();
				empSvc.deleteEmp(emp_no);

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
