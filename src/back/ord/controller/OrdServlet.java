package back.ord.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import back.ord.model.*;


public class OrdServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOrdList".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				
				/***************************1.將輸入資料轉為Map**********************************/ 
				//採用Map<String,String[]> getParameterMap()的方法 
				//注意:an immutable java.util.Map 
				Map<String, String[]> map = req.getParameterMap();
				
				/***************************2.開始複合查詢***************************************/
				OrdService ordSvc = new OrdService();
				List<OrdVO> ordList  = ordSvc.getAll(map);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("ordList", ordList); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/back/ord/showOrdList.jsp"); 
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/ord/queryOrdList.jsp");
				failureView.forward(req, res);
			}
		}	

//		if ("getOrdListByMno".equals(action)) { 
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				
//				/***************************1.將輸入資料轉存為查詢的參數**********************************/ 
//				
//				//mno
//				String mno = req.getParameter("mno");
//				if (mno == null || mno.trim().length() == 0) {
//					errorMsgs.add("會員編號請勿空白");
//				} else {
//					mno = mno.trim();
//				}				
//				
//				/***************************2.開始複合查詢***************************************/
//				OrdService ordSvc = new OrdService();
//				List<OrdVO> ordList  = ordSvc.getAllByMno(mno);
//				
//				/***************************3.查詢完成,準備轉交(Send the Success view)************/
//				req.setAttribute("ordList", ordList); // 資料庫取出的list物件,存入request
//				RequestDispatcher successView = req.getRequestDispatcher("/back/ord/showOrdList.jsp"); 
//				successView.forward(req, res);
//				
//				/***************************其他可能的錯誤處理**********************************/
//			} catch (Exception e) {
//				errorMsgs.add(e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/back/ord/queryOrdList.jsp");
//				failureView.forward(req, res);
//			}
//		}
		
	}
}
