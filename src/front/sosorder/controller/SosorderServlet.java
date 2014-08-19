package front.sosorder.controller;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SosorderServlet extends HttpServlet {
	Connection con;

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		// doPost(req, res); 

		// 20140804 - 為了給租物上架審核查詢單一會員資料 
//		if (req.getParameter("action") != null
//				&& req.getParameter("action").equals("getOne_For_Display")) {
//			doPost(req, res);
//			return;
//		}

		// 用請求參數讀取圖片
		req.setCharacterEncoding("UTF-8");
		res.setContentType("image/jpeg");
		ServletOutputStream out = res.getOutputStream();// 推出2進位資料流
		
		
		String sos_no = "";
		try {
			sos_no = req.getParameter("sos_no");
			sos_no = new String(sos_no.getBytes("ISO-8859-1"), "UTF-8");
		} catch (NullPointerException e) {
			System.out.println("sos_no: " + sos_no + " fail!");
		}
		try {
			
			String pic = req.getParameter("pic");
			pic = new String(pic.getBytes("ISO-8859-1"), "UTF-8");
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT " + pic
					+ " FROM sosorder WHERE sos_no = '" + sos_no + "'");

			if (rs.next()) {
				if(rs.getBinaryStream(pic) != null){
					BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream(pic));
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
//			System.out.println(e);
		}
	}
}
