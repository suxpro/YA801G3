package back.func.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import back.competence.model.CompetenceService;
import back.competence.model.CompetenceVO;
import back.func.model.FuncService;
import back.func.model.FuncVO;

import com.oreilly.servlet.MultipartRequest;

public class FuncServlet extends HttpServlet {
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
			System.out.println("funcServlet.40");
			multi = new MultipartRequest(req, getServletContext().getRealPath(
					"/back/func/images"), 5 * 1024 * 1024, "UTF-8");
			System.out.println("funcServlet.43");
			action = multi.getParameter("action");
		} else {
			action = req.getParameter("action");
		}

		if ("getFunc".equals(action)) { // 來自addCom.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String emp_no = req.getParameter("emp_no").trim();

				System.out.println("funcServlet.60." + emp_no);
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
				List<CompetenceVO> comVOList = comSvc.getAll();
				FuncService funcSvc = new FuncService();
				List<FuncVO> funcVOList = funcSvc.getAll();
				List<FuncVO> getFunc = new ArrayList<FuncVO>();
				Boolean hasFunc = false;
				for (FuncVO funcVO : funcVOList) {
					for (CompetenceVO comVO : comVOList) {
						if (emp_no.equals(comVO.getEmp_no())) {
							if (comVO.getFunc_no().equals(funcVO.getFunc_no())) {
								hasFunc = true;
							}
						}
					}
					if (hasFunc == false) {
						getFunc.add(funcVO);
					} else {
						hasFunc = false;
					}
				}
				
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String resJson = "{\"resJson\" : [";
				if(getFunc.size() != 0){
					for (FuncVO funcVO : getFunc) {
						resJson += "\""+funcVO.getFunc_no()+"\",";
					}
				} else
					resJson += "\"none\",";
				resJson = resJson.substring(0,resJson.length() - 1) + "]}";
//			    System.out.println("RentServlet.642."+resJson);
			    PrintWriter out = res.getWriter();
			    out.write(resJson);
			    out.flush();
			    out.close();

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/competence/addCom.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
