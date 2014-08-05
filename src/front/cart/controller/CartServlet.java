package front.cart.controller;
import java.util.*;
import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;


public class CartServlet extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		// res.setContentType("text/html; charset=UTF-8");
		// PrintWriter out = res.getWriter();

		HttpSession session = req.getSession();
		Vector<String> rentList = (Vector<String>) session.getAttribute("rentList");
		
		String action = req.getParameter("action");

		if (!action.equals("checkout")) {
			
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑(某個租物介紹的頁面)
			req.setAttribute("requestURL", requestURL); // 送出修改的來源網頁路徑, 存入req (是為了給導回時使用)
			
			// 取得後來新增的租物編號
			String newRent_no = req.getParameter("rent_no");

			// 刪除租物車中的租物編號
			if (action.equals("delete")) {
				String del = req.getParameter("del");
				int d = Integer.parseInt(del);
				rentList.removeElementAt(d);
				
				session.setAttribute("rentList", rentList);
				//返回租物車清單
				String url = "/front/cart/cart.jsp";
				RequestDispatcher rd = req.getRequestDispatcher(url);
				rd.forward(req, res);
			}
			
			// 新增租物編號至租物車中
			if (action.equals("add")) {
				boolean match = false;

				// 新增第一個租物編號至租物車時
				if (rentList == null) {
					rentList = new Vector<String>();
					rentList.add(newRent_no);
				} else {
					for (int i = 0; i < rentList.size(); i++) {
						
						String rent_no = rentList.get(i);
						// 假若新增的租物和租物車的租物編號一樣時
						if (rent_no.equals(newRent_no)) {
							errorMsgs.put("alert", "租物已存租物車中");
							match = true;
						} 
					} 

					// 假若新增的租物編號和租物車內的不一樣時
					if (!match)
						rentList.add(newRent_no);
				}
				
				session.setAttribute("rentList", rentList);
				//重新導回租物頁面
				String url = requestURL+"?&rent_no="+newRent_no; 
				RequestDispatcher rd = req.getRequestDispatcher(url);
				rd.forward(req, res);								
			}
		
		}

		// 結帳，計算購物車書籍價錢總數
//		if (action.equals("checkout")) {
//			float total = 0;
//			for (int i = 0; i < rentList.size(); i++) {
//				BOOK order = rentList.get(i);
//				float price = order.getPrice();
//				int quantity = order.getQuantity();
//				total += (price * quantity);
//			}
//
//			String amount = String.valueOf(total);
//			req.setAttribute("amount", amount);
//			String url = "/Checkout.jsp";
//			RequestDispatcher rd = req.getRequestDispatcher(url);
//			rd.forward(req, res);
//		}
	}

//	private BOOK getBook(HttpServletRequest req) {
//
//		String quantity = req.getParameter("quantity");
//		String name = req.getParameter("name");
//		String author = req.getParameter("author");
//		String publisher = req.getParameter("publisher");
//		String price = req.getParameter("price");
//
//		BOOK bk = new BOOK();
//
//		bk.setName(name);
//		bk.setAuthor(author);
//		bk.setPublisher(publisher);
//		bk.setPrice((new Float(price)).floatValue());
//		bk.setQuantity((new Integer(quantity)).intValue());
//		return bk;
//	}
}
