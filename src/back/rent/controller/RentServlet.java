package back.rent.controller;

import java.io.*;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.UnavailableException;
import javax.servlet.http.*;
import javax.sql.DataSource;

import back.rent.model.*;

import com.oreilly.servlet.MultipartRequest;

public class RentServlet extends HttpServlet {
	Connection con;

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		// 20140804 - 為了給租物上架審核查詢單一會員資料
		if (req.getParameter("action") != null
				&& req.getParameter("action").equals("getOne_For_Display")) {
			doPost(req, res);
			return;
		}

		// doPost(req, res);

		// 用請求參數讀取圖片
		req.setCharacterEncoding("UTF-8");
		res.setContentType("image/jpeg");
		ServletOutputStream out = res.getOutputStream();// 推出2進位資料流

		String rent_no = "";
		try {
			rent_no = req.getParameter("rent_no");
			rent_no = new String(rent_no.getBytes("ISO-8859-1"), "UTF-8");
		} catch (NullPointerException e) {
			System.out.println("rent_no: " + rent_no + " fail!");
		}
		try {

			String pic = req.getParameter("pic");
			pic = new String(pic.getBytes("ISO-8859-1"), "UTF-8");

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT " + pic
					+ " FROM rent WHERE rent_no = '" + rent_no + "'");

			if (rs.next()) {
				if (rs.getBinaryStream(pic) != null) {
					BufferedInputStream in = new BufferedInputStream(
							rs.getBinaryStream(pic));
					byte[] buf = new byte[4 * 1024]; // 4K buffer
					int len;
					while ((len = in.read(buf)) != -1) {
						out.write(buf, 0, len);
					}
					in.close();
				}
			} else {
				res.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
			rs.close();
			stmt.close();
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	@SuppressWarnings("unchecked")
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String ct = req.getContentType();// 取得ContentType的形式

		String action = null;
		MultipartRequest multi = null;

		if (ct != null && ct.startsWith("multipart/form-data")) {
			multi = new MultipartRequest(req, getServletContext().getRealPath(
					"/back/rent/images"), 5 * 1024 * 1024, "UTF-8");
			action = multi.getParameter("action");
		} else {
			action = req.getParameter("action");
		}

		if ("pass".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				String rent_no = req.getParameter("rent_no");
				if (rent_no == null || rent_no.trim().length() == 0) {
					errorMsgs.put("rent_no", "租物編號不能為空");
				}

				/*************************** 2.開始刪除資料 ***************************************/
				RentService rentSvc = new RentService();
				rentSvc.onShelf_pass(rent_no);

				/*************************** 3.更新完成,準備轉交(Send the Success view) ***********/
				String url = "/back/rent/waiting_onShelf_rent.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);//
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "更新資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/rent/waiting_onShelf_rent.jsp");
				failureView.forward(req, res);
			}
		}


		if ("fail".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				String rent_no = req.getParameter("rent_no");
				if (rent_no == null || rent_no.trim().length() == 0) {
					errorMsgs.put("rent_no", "租物編號不能為空");
				}
				
				String cause = req.getParameter("cause");
				if (rent_no == null || rent_no.trim().length() == 0) {
					errorMsgs.put("rent_no", "不通過的原因不能為空");
				}

				/*************************** 2.開始刪除資料 ***************************************/
				RentService rentSvc = new RentService();
				rentSvc.onShelf_fail(rent_no ,cause);

				/*************************** 3.更新完成,準備轉交(Send the Success view) ***********/
				String url = "/back/rent/waiting_onShelf_rent.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);//
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "更新資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/rent/waiting_onShelf_rent.jsp");
				failureView.forward(req, res);
			}
		}


		if ("getOne_For_Display".equals(action)) { 

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String rent_no = req.getParameter("rent_no");
				// if (que_no == null || que_no.trim().length() == 0) {
				// errorMsgs.put("que_no","問題編號不能為空");
				// }

				/*************************** 2.開始查詢資料 ****************************************/
				RentService rentSvc = new RentService();
				RentVO rentVO = rentSvc.getOneRent(rent_no);

				/*************************** 3.查詢完成,準備轉交(Send the Successview) ************/
				req.setAttribute("rentVO", rentVO); // 資料庫取出的rentVO物件,存入req
				String url = "/back/rent/listOneRent.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交
																				
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/rent/waiting_onShelf_rent.jsp");
				failureView.forward(req, res);
			}
		}

	}

	public void init() throws ServletException {
		try {
			Context ctx = new javax.naming.InitialContext();
			DataSource ds = (DataSource) ctx
					.lookup("java:comp/env/jdbc/renterDB");
			con = ds.getConnection();
		} catch (NamingException e) {
			throw new UnavailableException("Couldn't not find connect pool");
		} catch (SQLException e) {
			throw new UnavailableException("Couldn't get db connection");
		}
	}

	public void destroy() {
		try {
			if (con != null)
				con.close();
		} catch (SQLException e) {
			System.out.println(e);
		}
	}
}
