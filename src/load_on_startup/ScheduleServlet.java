package load_on_startup;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.*;

import front.remind.model.RemindService;
import front.remind.model.RemindVO;
import front.member.model.MemberVO;
import front.member.model.MemberService;
import front.ord.model.OrdService;
import front.ord.model.OrdVO;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.*;

import org.json.*;

import com.oreilly.servlet.MultipartRequest;

public class ScheduleServlet extends HttpServlet {

	Timer timer1; // 租約到期塞提醒資料表且改訂單狀態為租約到期
	Timer timer2; // 搜尋提醒資料表的提醒flag是Y的發簡訊提醒後改flag為N
	Timer timer3; // SOS一天過後刪除 //會員評價到300自動升級VIP //會員積分達到-10 停權 還是被檢舉超過10次成立就停權
					// 停權是終身停權
	Send sendMessage = new Send();
	int count = 0;

	public void init() throws ServletException {
		// 租約到期塞提醒資料表且改訂單狀態為租約到期
		TimerTask task1 = new TimerTask() {
			public void run() {
				count++;
				// System.out.println("第" + count + "次執行時間="
				// + new Date(scheduledExecutionTime()));
				// System.out.println("工作排定的時間 = " + new
				// Date(scheduledExecutionTime()));
				// System.out.println("工作執行的時間 = " + new Date() + "\n");

				OrdService ordSvc = new OrdService();
				List<OrdVO> listOrdVO = ordSvc.getAll();
				for (OrdVO ordVO : listOrdVO) {
					if ("REC_COM".equals(ordVO.getOrd_sta())) {
						java.util.Date nowDate = new java.util.Date(); // 當前時間
						Date ordDate = ordVO.getExp_date(); // 租物期限
						if ((nowDate.getTime() - ordDate.getTime()) >= 0) { // 如果當前時間超過租物期限,則為租約到期
							ordSvc.updateOrd(ordVO, "RENT_EXP");
							System.out
									.println(ordVO.getOrd_no()
											+ "租約到期,修改訂單狀態從\"REC_COM收貨完成\"至\"RENT_EXP租約到期\"");
							System.out.println("nowDate = " + nowDate);
							// System.out.println("ordDate = "+ordDate);
						}
					}
				}
			}
		};
		timer1 = new Timer();
		Calendar cal = new GregorianCalendar(2014, Calendar.AUGUST, 12, 0, 0, 0);
		timer1.scheduleAtFixedRate(task1, cal.getTime(), 1 * 1 * 60 * 1000); // 每60秒執行一次
		System.out.println("已建立租約到期排程timer1!");

		// 搜尋提醒資料表的提醒flag是Y的發簡訊提醒後改flag為N
		TimerTask task2 = new TimerTask() {
			public void run() {
				RemindService remindSvc = new RemindService();
				List<RemindVO> listRemindVO = remindSvc.getAll();
				for (RemindVO remindVO : listRemindVO) {
					if ("Y".equals(remindVO.getRflag())) {
						MemberService memSvc = new MemberService();
						MemberVO memVO = memSvc.getOneMember(remindVO.getMno());
						String Mcell = memVO.getMcell();
						String Mname = memVO.getMname();
						// 發送簡訊
						System.out.println("Mcell = " + Mcell);
						System.out.println(Mname + " 您好!\nJustRent提醒:\n "
								+ remindVO.getRdes() + "\n時間:"
								+ remindVO.getRtime() + ".\n");
						// String[] tel ={Mcell};
						// String message = Mname+" 您好!\nJustRent提醒:\n " +
						// remindVO.getRdes()+"\n時間:"+remindVO.getRtime()+".\n";
						// sendMessage.sendMessage(tel , message);

						// 修改flag為N
						remindSvc.updateRemind(remindVO.getRno(),
								remindVO.getMno(), remindVO.getRtno(),
								remindVO.getRtime(), remindVO.getRstas(),
								remindVO.getRdes(), "N");
					}
				}
			}
		};
		timer2 = new Timer();
		timer2.scheduleAtFixedRate(task2, new java.util.Date(), 60 * 1000); // 每60秒執行一次
		System.out.println("已建立簡訊發送排程timer2!");

		// 其他排程器要做的事
		TimerTask task3 = new TimerTask() {
			public void run() {
				// SOS一天過後刪除

				// 會員評價到300自動升級VIP
				// 會員積分達到-10 停權 還是被檢舉超過10次成立就停權 停權是終身停權
				MemberService memSvc = new MemberService();
				List<MemberVO> listMemVO = memSvc.getAll();
				for (MemberVO memVO : listMemVO) {
					if ((memVO.getMillegal() > 10 || memVO.getMassess() < -10)
							&& !"S".equals(memVO.getMlev())) {
						memSvc.updateTimer(memVO, "SUSPENDED");
						System.out.println(memVO.getMno()
								+ "已被停權,MEM_LEV改為\"S\"");
					} else if (memVO.getMassess() >= 300
							&& "G".equals(memVO.getMlev())) {
						memSvc.updateTimer(memVO, "VIP");
						System.out.println(memVO.getMno()
								+ "已被升級VIP,MEM_LEV改為\"V\"");
					}
				}
			}
		};
		timer3 = new Timer();
		timer3.scheduleAtFixedRate(task3, new java.util.Date(), 60 * 1000); // 每60秒執行一次
		System.out.println("已建立其他排程timer3!");

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
			multi = new MultipartRequest(req, getServletContext().getRealPath(
					"/front/remind/images"), 5 * 1024 * 1024, "UTF-8");
			action = multi.getParameter("action");
		} else {
			action = req.getParameter("action");
		}
		
		if ("remindHeaderNum".equals(action)) {
			//抓取session現在登入的member
			HttpSession session = req.getSession();
			String memID = (String) session.getAttribute("mid");
			MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
//			System.out.println("ScheduleServlet.135.現在登入的memID:\n"+memID);
	
			RemindService remindSvc = new RemindService();
			List<RemindVO> listRemindVO = remindSvc.ajaxGetMemRemind(
					memberVO.getMno(), "N");
			
			//用JSON存提醒數字,回傳呼叫的AJAX
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("成功出租", 0);
			map.put("成功承租", 0);
			map.put("出租確認", 0);
			map.put("預約", 0);
			map.put("出貨通知", 0);
			map.put("租期通知", 0);
			map.put("歸還通知", 0);
			map.put("求租公告", 0);
			map.put("Q&A留言", 0);
			map.put("評價", 0);
			map.put("逾期通知", 0);
			map.put("取消訂單", 0);
			map.put("上架通過", 0);
			map.put("上架不通過", 0);
			JSONObject jsonObj = new JSONObject(map);
			for (RemindVO remindVO : listRemindVO) {
				try {
					if ("成功出租".equals(remindVO.getRstas())) {
						jsonObj.put("成功出租", (Integer) jsonObj.get("成功出租") + 1);
	
					} else if ("成功承租".equals(remindVO.getRstas())) {
						jsonObj.put("成功承租", (Integer) jsonObj.get("成功承租") + 1);
	
					} else if ("出租確認".equals(remindVO.getRstas())) {
						jsonObj.put("出租確認", (Integer) jsonObj.get("出租確認") + 1);
	
					} else if ("預約".equals(remindVO.getRstas())) {
						jsonObj.put("預約", (Integer) jsonObj.get("預約") + 1);
	
					} else if ("出貨通知".equals(remindVO.getRstas())) {
						jsonObj.put("出貨通知", (Integer) jsonObj.get("出貨通知") + 1);
	
					} else if ("租期通知".equals(remindVO.getRstas())) {
						jsonObj.put("租期通知", (Integer) jsonObj.get("租期通知") + 1);
	
					} else if ("歸還通知".equals(remindVO.getRstas())) {
						jsonObj.put("歸還通知", (Integer) jsonObj.get("歸還通知") + 1);
	
					} else if ("求租公告".equals(remindVO.getRstas())) {
						jsonObj.put("求租公告", (Integer) jsonObj.get("求租公告") + 1);
	
					} else if ("Q&A留言".equals(remindVO.getRstas())) {
						jsonObj.put("Q&A留言", (Integer) jsonObj.get("Q&A留言") + 1);
	
					} else if ("評價".equals(remindVO.getRstas())) {
						jsonObj.put("評價", (Integer) jsonObj.get("評價") + 1);
	
					} else if ("逾期通知".equals(remindVO.getRstas())) {
						jsonObj.put("逾期通知", (Integer) jsonObj.get("逾期通知") + 1);
	
					} else if ("取消訂單".equals(remindVO.getRstas())) {
						jsonObj.put("取消訂單", (Integer) jsonObj.get("取消訂單") + 1);
	
					} else if ("上架通過".equals(remindVO.getRstas())) {
						jsonObj.put("上架通過", (Integer) jsonObj.get("上架通過") + 1);
	
					} else if ("上架不通過".equals(remindVO.getRstas())) {
						jsonObj.put("上架不通過", (Integer) jsonObj.get("上架不通過") + 1);
	
					}
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
//			System.out.println("ScheduleServlet.208.jsonObj:\n" + jsonObj);
            res.setContentType("text/html;charset=utf-8");
//            res.setHeader("Cache-Control", "no-cache");
			PrintWriter out = res.getWriter();
			out.write(jsonObj.toString());
			out.flush();
			out.close();
		}
		//end remindHeaderNum
		
		
		
		
	}

	public void destroy() {
		timer1.cancel();
		timer2.cancel();
		timer3.cancel();
		System.out.println("已移除所有排程!");
	}

}