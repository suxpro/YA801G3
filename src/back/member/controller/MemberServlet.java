package back.member.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import back.member.model.*;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class MemberServlet
 */
@WebServlet("/MemberServlet")
public class MemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
		res.setCharacterEncoding("Big5");
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		try {
			
			
			MemberService srv = new MemberService();
			String mno = req.getParameter("mno");
			MemberVO memberVO = srv.getOneMember(mno);
			if (memberVO != null) {

				out.write(memberVO.getMpic());
				out.write(memberVO.getMvpic());

			} else {
				res.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		} catch (Exception e) {
			// System.out.println("無此圖片！");
		}
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
					"/back/member/images"), 5 * 1024 * 1024, "UTF-8");
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
				String str = req.getParameter("mno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.put("mno", "請輸入會員編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/member/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				String mno = null;
				try {
					mno = new String(str);
				} catch (Exception e) {
					errorMsgs.put("mno", "會員編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/member/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				MemberDAO dao = new MemberDAO();
				MemberVO memberVO = dao.findByPrimaryKey(mno);
				if (memberVO == null) {
					errorMsgs.put("mno", "查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/member/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("memberVO", memberVO); // 資料庫取出的empVO物件,存入req
				String url = "/back/member/listOneMember.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交
																				// listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/member/select_page.jsp");
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
				String mno = new String(req.getParameter("mno"));

				/*************************** 2.開始查詢資料 ****************************************/
				MemberService memberSvc = new MemberService();
				MemberVO memberVO = memberSvc.getOneMember(mno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("memberVO", memberVO); // 資料庫取出的empVO物件,存入req
				String url = "/back/member/update_member_input.jsp";
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

		if ("update".equals(action)) { // 來自update_member_input.jsp的請求

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
				String mno = multi.getParameter("mno").trim();
				String mid = multi.getParameter("mid").trim();

				String mpwd = multi.getParameter("mpwd").trim();
				String mpwdReg = "^(?=^.{6,10}$)((?=.*[A-Za-z0-9])(?=.*[A-Z])(?=.*[a-z]))^.*$";
				if (mpwd == null || (mpwd.trim()).length() == 0) {
					errorMsgs.put("mpwd", "請輸入密碼");
				} else if (!mpwd.trim().matches(mpwdReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("mpwd",
							"密碼必須包含至少一個小寫字母與一個大寫字母和一個數字,長度在6到10之間");
				}

				File f1 = null;
				byte mpic[] = null;

				try {
					f1 = multi.getFile("mpic");
					FileInputStream fis1 = new FileInputStream(f1);
					int len = fis1.available();
					mpic = new byte[len];
					fis1.read(mpic);
					fis1.close();
				} catch (NullPointerException e) {
					errorMsgs.put("mpic", "請選擇圖片1.");
				}

				String mname = multi.getParameter("mname").trim();
				if (mname == null || (mname.trim()).length() == 0) {
					errorMsgs.put("mname", "請輸入姓名");
				}

				String msex = multi.getParameter("msex").trim();

				String mcell = multi.getParameter("mcell").trim();
				if (mcell == null || (mcell.trim()).length() == 0) {
					errorMsgs.put("mcell", "請輸入手機電話");
				}

				String mmail = multi.getParameter("mmail").trim();
				String mmailReg = "^[_a-z0-9-]+([.][_a-z0-9-]+)*@[a-z0-9-]+([.][a-z0-9-]+)*$";
				if (mmail == null || (mmail.trim()).length() == 0) {
					errorMsgs.put("mmail", "請輸入Email");
				} else if (!mmail.trim().matches(mmailReg)) {
					errorMsgs.put("mmail", "Email格式有誤");
				}

				String locno = multi.getParameter("locno").trim();

				String madrs = multi.getParameter("madrs").trim();

				String mlev = multi.getParameter("mlev").trim();

				Double mbalance = null;
				try {
					mbalance = new Double(multi.getParameter("mbalance").trim());
				} catch (NumberFormatException e) {
					mbalance = 0.0;
					errorMsgs.put("mbalance", "帳戶餘額請填數字.");
				}

				Integer milligal = null;
				try {
					milligal = new Integer(multi.getParameter("millegal")
							.trim());
				} catch (NumberFormatException e) {
					milligal = 0;
					errorMsgs.put("milligal", "違規次數請填數字.");
				}

				Integer massess = null;
				try {
					massess = new Integer(multi.getParameter("massess").trim());
				} catch (NumberFormatException e) {
					massess = 0;
					errorMsgs.put("massess", "評價次數請填數字.");
				}

				String mverification = multi.getParameter("mverification")
						.trim();

				java.sql.Date mdate = null;
				try {
					mdate = java.sql.Date.valueOf(multi.getParameter("mdate")
							.trim());
				} catch (IllegalArgumentException e) {
					mdate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("mdate", "請輸入日期!");
				}

				String mpic_info = multi.getParameter("mpic_info");

				File f2 = null;
				byte mvpic[] = null;
				try {
					f2 = multi.getFile("mvpic");
					FileInputStream fis2 = new FileInputStream(f2);
					int len = fis2.available();
					mvpic = new byte[len];
					fis2.read(mvpic);
					fis2.close();
				} catch (NullPointerException e) {
					errorMsgs.put("mvpic", "請選擇圖片2.");
				}
				String mvpic_info = multi.getParameter("mvpic_info");

				MemberVO memberVO = new MemberVO();
				memberVO.setMno(mno);
				memberVO.setMid(mid);
				memberVO.setMpwd(mpwd);
				memberVO.setMpic(mpic);
				memberVO.setMname(mname);
				memberVO.setMsex(msex);
				memberVO.setMcell(mcell);
				memberVO.setMmail(mmail);
				memberVO.setLocno(locno);
				memberVO.setMadrs(madrs);
				memberVO.setMlev(mlev);
				memberVO.setMbalance(mbalance);
				memberVO.setMillegal(milligal);
				memberVO.setMassess(massess);
				memberVO.setMverification(mverification);
				memberVO.setMdate(mdate);
				memberVO.setMpic_info(mpic_info);
				memberVO.setMvpic(mvpic);
				memberVO.setMvpic_info(mvpic_info);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memberVO", memberVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/member/update_member_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				MemberService memberSvc = new MemberService();
				memberVO = memberSvc.updateMember(mno, mid, mpwd, mpic, mname,
						msex, mcell, mmail, locno, madrs, mlev, mbalance,
						milligal, massess, mverification, mdate, mpic_info,
						mvpic, mvpic_info);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("memberVO", memberVO); // 資料庫update成功後,正確的的empVO物件,存入req
				
				String url = requestURL+"?whichPage="+whichPage+"&mno="+mno; // 送出修改的來源網頁的第幾頁(只用於:istAllEmp.jsp)和修改的是哪一筆
				
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/member/update_member_input.jsp");
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
				String mid = multi.getParameter("mid").trim();

				String mpwd = multi.getParameter("mpwd").trim();
				String mpwdReg = "^(?=^.{6,10}$)((?=.*[A-Za-z0-9])(?=.*[A-Z])(?=.*[a-z]))^.*$";
				if (mpwd == null || (mpwd.trim()).length() == 0) {
					errorMsgs.put("mpwd", "請輸入密碼");
				} else if (!mpwd.trim().matches(mpwdReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("mpwd",
							"密碼必須包含至少一個小寫字母與一個大寫字母和一個數字,長度在6到10之間");
				}

				File f1 = null;
				byte mpic[] = null;

				try {
					f1 = multi.getFile("mpic");
					FileInputStream fis = new FileInputStream(f1);
					int len = fis.available();
					mpic = new byte[len];
					fis.read(mpic);
					fis.close();
				} catch (NullPointerException e) {
					errorMsgs.put("mpic", "請選擇圖片1.");
				}

				String mname = multi.getParameter("mname").trim();
				String mnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (mname == null || mname.trim().length() == 0) {
					errorMsgs.put("mname", "員工姓名: 請勿空白");
				} else if (!mname.trim().matches(mnameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("mname",
							"員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}

				String msex = multi.getParameter("msex").trim();

				String mcell = multi.getParameter("mcell").trim();
				if (mcell == null || (mcell.trim()).length() == 0) {
					errorMsgs.put("mcell", "請輸入手機電話");
				}

				String mmail = multi.getParameter("mmail").trim();
				String mmailReg = "^[_a-z0-9-]+([.][_a-z0-9-]+)*@[a-z0-9-]+([.][a-z0-9-]+)*$";
				if (mmail == null || (mmail.trim()).length() == 0) {
					errorMsgs.put("mmail", "請輸入Email");
				} else if (!mmail.trim().matches(mmailReg)) {
					errorMsgs.put("mmail", "Email格式有誤");
				}

				String locno = multi.getParameter("locno").trim();

				String madrs = multi.getParameter("madrs").trim();

				String mlev = multi.getParameter("mlev").trim();

				Double mbalance = null;
				try {
					mbalance = new Double(multi.getParameter("mbalance").trim());
				} catch (NumberFormatException e) {
					mbalance = 0.0;
					errorMsgs.put("mbalance", "帳戶餘額請填數字.");
				}

				Integer milligal = null;
				try {
					milligal = new Integer(multi.getParameter("millegal")
							.trim());
				} catch (NumberFormatException e) {
					milligal = 0;
					errorMsgs.put("milligal", "違規次數請填數字.");
				}

				Integer massess = null;
				try {
					massess = new Integer(multi.getParameter("massess").trim());
				} catch (NumberFormatException e) {
					massess = 0;
					errorMsgs.put("massess", "評價次數請填數字.");
				}

				String mverification = multi.getParameter("mverification")
						.trim();

				java.sql.Date mdate = null;
				try {
					mdate = java.sql.Date.valueOf(multi.getParameter("mdate")
							.trim());
				} catch (IllegalArgumentException e) {
					mdate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("mdate", "請輸入日期!");
				}

				String mpic_info = multi.getParameter("mpic_info");

				File f2 = null;
				byte mvpic[] = null;
				try {
					f2 = multi.getFile("mvpic");
					FileInputStream fis = new FileInputStream(f2);
					int len = fis.available();
					mvpic = new byte[len];
					fis.read(mvpic);
					fis.close();
				} catch (NullPointerException e) {
					errorMsgs.put("mvpic", "請選擇圖片2.");
				}
				String mvpic_info = multi.getParameter("mvpic_info");

				MemberVO memberVO = new MemberVO();
				memberVO.setMid(mid);
				memberVO.setMpwd(mpwd);
				memberVO.setMpic(mpic);
				memberVO.setMname(mname);
				memberVO.setMsex(msex);
				memberVO.setMcell(mcell);
				memberVO.setMmail(mmail);
				memberVO.setLocno(locno);
				memberVO.setMadrs(madrs);
				memberVO.setMlev(mlev);
				memberVO.setMbalance(mbalance);
				memberVO.setMillegal(milligal);
				memberVO.setMassess(massess);
				memberVO.setMverification(mverification);
				memberVO.setMdate(mdate);
				memberVO.setMpic_info(mpic_info);
				memberVO.setMvpic(mvpic);
				memberVO.setMvpic_info(mvpic_info);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memberVO", memberVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/member/addMember.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				MemberService memberSvc = new MemberService();
				memberVO = memberSvc.addMember(mid, mpwd, mpic, mname, msex,
						mcell, mmail, locno, madrs, mlev, mbalance, milligal,
						massess, mverification, mdate, mpic_info, mvpic,
						mvpic_info);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back/member/listAllMember.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "新增資料失敗" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/member/addMember.jsp");
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
				String mno = new String(req.getParameter("mno"));

				/*************************** 2.開始刪除資料 ***************************************/
				MemberService memberSvc = new MemberService();
				memberSvc.deleteMember(mno);

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
