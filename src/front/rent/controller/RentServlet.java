package front.rent.controller;

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

import front.rent.model.*;

import com.oreilly.servlet.MultipartRequest;

public class RentServlet extends HttpServlet {
	Connection con;

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		// doPost(req, res); 

		// 20140804 - 為了給租物上架審核查詢單一會員資料 
		if (req.getParameter("action") != null
				&& req.getParameter("action").equals("getOne_For_Display")) {
			doPost(req, res);
			return;
		}

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

		if (ct!=null && ct.startsWith("multipart/form-data")) {
			multi = new MultipartRequest(req, getServletContext().getRealPath(
					"/front/rent/images"), 5 * 1024 * 1024, "UTF-8");
			action = multi.getParameter("action");
		} else {
			action = req.getParameter("action");
		}
		
		if ("insert".equals(action)) { 

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/

				// rent_name
				String rent_name = multi.getParameter("rent_name").trim();
				if (rent_name == null || rent_name.trim().length() == 0) {
					errorMsgs.put("rent_name", "租物名稱請勿空白");
				}

				// rent_desc
				String rent_desc = multi.getParameter("rent_desc").trim();
				if (rent_desc == null || rent_desc.trim().length() == 0) {
					errorMsgs.put("rent_desc", "租物描述請勿空白");
				}

				// les_no
				String les_no = multi.getParameter("les_no").trim();
				if (les_no == null || les_no.trim().length() == 0) {
					errorMsgs.put("les_no", "出租會員編號請勿空白");
				}

				// rent_sta
				String rent_sta = "W_CHECK";
				// String rent_sta = req.getParameter("rent_sta").trim();
				// if (rent_sta == null || rent_sta.trim().length() == 0) {
				// errorMsgs.put("rent_sta","租物狀態請勿空白");
				// }

				// tag_no
				String tag_no = multi.getParameter("tag_no").trim();
				if (tag_no == null || tag_no.trim().length() == 0) {
					errorMsgs.put("tag_no", "租物分類請勿空白");
				}

				// rent_dps
				Integer rent_dps = null;
				try {
					rent_dps = Integer.parseInt(multi.getParameter("rent_dps")
							.trim());
				} catch (NumberFormatException e) {
					errorMsgs.put("rent_dps", "租物押金請勿空白,或輸入非數字");
				}

				// unit_price
				Integer unit_price = null;
				try {
					unit_price = Integer.parseInt(multi.getParameter(
							"unit_price").trim());
				} catch (NumberFormatException e) {
					errorMsgs.put("unit_price", "每日租金請勿空白,或非數字");
				}

				// reset_days
				Integer reset_days = null;
				try {
					reset_days = Integer.parseInt(multi.getParameter(
							"reset_days").trim());
				} catch (NumberFormatException e) {
					errorMsgs.put("reset_days", "重整天數請勿空白,或非數字");
				}

				// loc_no
				String loc_no = multi.getParameter("loc_no").trim();
				if (loc_no == null || loc_no.trim().length() == 0) {
					errorMsgs.put("loc_no", "地區請勿空白");
				}

				// rent_addr
				String rent_addr = multi.getParameter("rent_addr").trim();
				if (rent_addr == null || rent_addr.trim().length() == 0) {
					errorMsgs.put("rent_addr", "租物地址請勿空白");
				}

				Map pics = new LinkedHashMap<String, byte[]>();
				Map pics_format = new LinkedHashMap<String, String>();
				// ArrayList<byte[]> pics = new ArrayList<byte[]>();
				// ArrayList<String> pics_format = new ArrayList<String>();
				Enumeration files = multi.getFileNames();
				int count = 0;
				try {
					while (files.hasMoreElements()) {
						byte[] pic_byte = null;
						String name = (String) files.nextElement();
						String fileName = multi.getFilesystemName(name);
						File file = multi.getFile(name);
						// 避免未上傳三張圖時 會異常發生
						if (file != null) {
							int dotPos = fileName.indexOf('.');
							String pic_format = fileName.substring(dotPos + 1);
							// String type = multi.getContentType(name);
							FileInputStream fis = new FileInputStream(file);
							int fin = fis.available();
							pic_byte = new byte[fin];
							fis.read(pic_byte);
							fis.close();
							file.delete(); // 寫入記憶體後 檔案刪除
							count++;
							pics.put(name, pic_byte); // hasMoreElements 會將後進先出
														// 所以使用map格式 且key值等於
														// name
							pics_format.put(name, pic_format); // hasMoreElements
																// 會將後進先出
																// 所以使用map格式
																// 且key值等於 name
						}
					}
				} catch (Exception e) {
					errorMsgs.put("pics", "請上傳不重複的租物圖片");
				}
				if (count != 3)
					errorMsgs.put("pics", "請上傳三張不同的租物圖片");

				byte[] pic1 = (byte[]) pics.get("pic1");
				String pic1_format = (String) pics_format.get("pic1");

				byte[] pic2 = (byte[]) pics.get("pic2");
				String pic2_format = (String) pics_format.get("pic2");

				byte[] pic3 = (byte[]) pics.get("pic3");
				String pic3_format = (String) pics_format.get("pic3");

				byte[] pic4 = (byte[]) pics.get("pic4");
				String pic4_format = (String) pics_format.get("pic4");

				byte[] pic5 = (byte[]) pics.get("pic5");
				String pic5_format = (String) pics_format.get("pic5");

				RentVO rentVO = new RentVO();
				rentVO.setRent_name(rent_name);
				rentVO.setRent_desc(rent_desc);
				rentVO.setLes_no(les_no);
				rentVO.setRent_sta(rent_sta);
				rentVO.setTag_no(tag_no);
				rentVO.setRent_dps(rent_dps);
				rentVO.setUnit_price(unit_price);
				rentVO.setReset_days(reset_days);
				rentVO.setLoc_no(loc_no);
				rentVO.setRent_addr(rent_addr);
				rentVO.setPic1(pic1);
				rentVO.setPic1_format(pic1_format);
				rentVO.setPic2(pic2);
				rentVO.setPic2_format(pic2_format);
				rentVO.setPic3(pic3);
				rentVO.setPic3_format(pic3_format);
				rentVO.setPic4(pic4);
				rentVO.setPic4_format(pic4_format);
				rentVO.setPic5(pic5);
				rentVO.setPic5_format(pic5_format);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("rentVO", rentVO); // 含有輸入格式錯誤的rentVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/rent/addRent.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				RentService rentSvc = new RentService();
				rentSvc.addRent(rent_name, rent_desc, les_no, rent_sta, tag_no,
						rent_dps, unit_price, reset_days, loc_no, rent_addr,
						pic1, pic1_format, pic2, pic2_format, pic3,
						pic3_format, pic4, pic4_format, pic5, pic5_format);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front/rent/listAllRent.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "other errors");
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/rent/addRent.jsp");
				failureView.forward(req, res);
			}
		}

		if ("delete".equals(action)) {

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
				rentSvc.deleteRent(rent_no);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/front/rent/listAllRent.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);//
				// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/rent/listAllRent.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) {
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
				String url = "/front/rent/update_rent_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交
																				// update_rent_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/rent/listAllRent.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);
		
			RentService rentSvc = new RentService();
			RentVO rentVO = new RentVO();

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				// rent_no
				String rent_no = multi.getParameter("rent_no").trim();
				String rent_noReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (rent_no == null || rent_no.trim().length() == 0) {
					errorMsgs.put("rent_no", "租物編號請勿空白");
				} else if(!rent_no.trim().matches(rent_noReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("rent_no","租物編號只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            } else{
	                rentVO = rentSvc.getOneRent(rent_no);		
				}	

				// rent_name
				String rent_name = multi.getParameter("rent_name").trim();
				if (rent_name == null || rent_name.trim().length() == 0) {
					errorMsgs.put("rent_name", "租物名稱請勿空白");
				} else{
					rentVO.setRent_name(rent_name);
				}

				// rent_desc
				String rent_desc = multi.getParameter("rent_desc").trim();
				if (rent_desc == null || rent_desc.trim().length() == 0) {
					errorMsgs.put("rent_desc", "租物描述請勿空白");
				} else{
					rentVO.setRent_desc(rent_desc);
				}

				// les_no
				String les_no = multi.getParameter("les_no").trim();
				if (les_no == null || les_no.trim().length() == 0) {
					errorMsgs.put("les_no", "出租人編號請勿空白");
				} else {
					rentVO.setLes_no(les_no);
				}

				// rent_sta
				 String rent_sta = multi.getParameter("rent_sta").trim();
				 if (rent_sta == null || rent_sta.trim().length() == 0) {
					 errorMsgs.put("rent_sta","租物狀態請勿空白");
				 }else if(rent_sta.equals("W_RENT") || rent_sta.equals("W_CHECK")){
					 rent_sta = "W_CHECK";
					 rentVO.setRent_sta(rent_sta);
				 }else{
					 //租物狀態不對
					 errorMsgs.put("alert","租物狀態只有在待審核或未出租時才可以編輯");
				 }
//				 String rent_sta = "W_CHECK";
//				 rentVO.setRent_sta(rent_sta);
				
				// tag_no
				String tag_no = multi.getParameter("tag_no").trim();
				if (tag_no == null || tag_no.trim().length() == 0) {
					errorMsgs.put("tag_no", "租物分類請勿空白");
				} else {
					rentVO.setTag_no(tag_no);
				}

				// rent_dps
				Integer rent_dps = null;
				try {
					rent_dps = Integer.parseInt(multi.getParameter("rent_dps").trim());
					rentVO.setRent_dps(rent_dps);
				} catch (NumberFormatException e) {
					errorMsgs.put("rent_dps", "租物押金請勿空白,或輸入非數字");
				}

				// unit_price
				Integer unit_price = null;
				try {
					unit_price = Integer.parseInt(multi.getParameter("unit_price").trim());
					rentVO.setUnit_price(unit_price);
				} catch (NumberFormatException e) {
					errorMsgs.put("unit_price", "每日租金請勿空白,或輸入非數字");
				}

				// reset_days
				Integer reset_days = null;
				try {
					reset_days = Integer.parseInt(multi.getParameter("reset_days").trim());
					rentVO.setReset_days(reset_days);
				} catch (NumberFormatException e) {
					errorMsgs.put("reset_days", "重整天數請勿空白,或輸入非數字");
				}

				// loc_no
				String loc_no = multi.getParameter("loc_no").trim();
				if (loc_no == null || loc_no.trim().length() == 0) {
					errorMsgs.put("loc_no", "地區請勿空白");
				} else{
					rentVO.setLoc_no(loc_no);
				}

				// rent_addr
				String rent_addr = multi.getParameter("rent_addr").trim();
				if (rent_addr == null || rent_addr.trim().length() == 0) {
					errorMsgs.put("rent_addr", "租物地址請勿空白");
				} else{
					rentVO.setRent_addr(rent_addr);
				}


				Enumeration files = multi.getFileNames();
				try {
					while (files.hasMoreElements()) {
						byte[] pic_byte = null;
						String name = (String) files.nextElement();
						String fileName = multi.getFilesystemName(name);
						File file = multi.getFile(name);
						// 避免null時 會有異常發生
						if (file != null) {
							int dotPos = fileName.indexOf('.');
							String pic_format = fileName.substring(dotPos + 1);
							// String type = multi.getContentType(name);
							FileInputStream fis = new FileInputStream(file);
							int fin = fis.available();
							pic_byte = new byte[fin];
							fis.read(pic_byte);
							fis.close();
							file.delete(); // 寫入記憶體後 檔案刪除
							
							if(name.equals("pic1")){	
								rentVO.setPic1(pic_byte);
								rentVO.setPic1_format(pic_format);						
							}else if(name.equals("pic2")){
								rentVO.setPic2(pic_byte);
								rentVO.setPic2_format(pic_format);							
							}else if(name.equals("pic3")){
								rentVO.setPic3(pic_byte);
								rentVO.setPic3_format(pic_format);	
							}

						}

					}
				} catch (Exception e) {
					errorMsgs.put("pics", "請上傳不重複的租物圖片");
				}


//				RentVO rentVO = new RentVO();
//				rentVO.setRent_no(rent_no);
//				rentVO.setRent_name(rent_name);
//				rentVO.setRent_desc(rent_desc);
//				rentVO.setLes_no(les_no);
//				rentVO.setRent_sta(rent_sta);
//				rentVO.setTag_no(tag_no);
//				rentVO.setRent_dps(rent_dps);
//				rentVO.setUnit_price(unit_price);
//				rentVO.setReset_days(reset_days);
//				rentVO.setLoc_no(loc_no);
//				rentVO.setRent_addr(rent_addr);

//				rentVO.setPic1(pic1);
//				rentVO.setPic1_format(pic1_format);
//				rentVO.setPic2(pic2);
//				rentVO.setPic2_format(pic2_format);
//				rentVO.setPic3(pic3);
//				rentVO.setPic3_format(pic3_format);
//				rentVO.setPic4(pic4);
//				rentVO.setPic4_format(pic4_format);
//				rentVO.setPic5(pic5);
//				rentVO.setPic5_format(pic5_format);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("rentVO", rentVO); 
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/rent/update_rent_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
//				RentService rentSvc = new RentService();
//				rentSvc.updateRent(rent_no, rent_name, rent_desc, les_no,
//						rent_sta, tag_no, rent_dps, unit_price, reset_days,
//						loc_no, rent_addr, pic1, pic1_format, pic2,
//						pic2_format, pic3, pic3_format, pic4, pic4_format,
//						pic5, pic5_format);
				
				rentSvc.updateRent(rentVO);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
//				req.setAttribute("rentVO", rentVO); // 資料庫update成功後,正確的的rentVO物件,存入req
				String url = "/front/rent/listAllRent.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/rent/update_rent_input.jsp");
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
				String url = "/front/rent/listOneRent.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交
																				
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/rent/waiting_onShelf_rent.jsp");
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
