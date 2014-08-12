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

public class ScheduleServlet extends HttpServlet {

	Timer timer1; // 租約到期塞提醒資料表且改訂單狀態為租約到期
	Timer timer2; // 搜尋提醒資料表的提醒flag是Y的發簡訊提醒後改flag為N
	Timer timer3; // SOS一天過後刪除 //會員評價到300自動升級VIP //會員積分達到-10 停權 還是被檢舉超過10次成立就停權
					// 停權是終身停權 背後執行序 如果抓到 評分為-10的自動將會員終身停權
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
		timer1.scheduleAtFixedRate(task1, cal.getTime(), 1 * 1 * 30 * 1000); // 每30秒執行一次
		System.out.println("已建立租約到期排程!");
		
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
						//發送簡訊
						System.out.println("Mcell = " + Mcell);
						System.out.println(Mname+" 您好!\nJustRent提醒:\n " + remindVO.getRdes()+"\n時間:"+remindVO.getRtime()+".\n");
//						String[] tel ={Mcell};
//						String message = Mname+" 您好!\nJustRent提醒:\n " + remindVO.getRdes()+"\n時間:"+remindVO.getRtime()+".\n";
//						sendMessage.sendMessage(tel , message);
						
						//修改flag為N
						remindSvc.updateRemind(remindVO.getRno(), remindVO.getMno(), remindVO.getRtno(), remindVO.getRtime(), remindVO.getRstas(), remindVO.getRdes(), "N");
					}
				}
			}
		};
		timer2 = new Timer();
		timer2.scheduleAtFixedRate(task2, new java.util.Date(), 60 * 1000); // 每60秒執行一次
		System.out.println("已建立簡訊發送排程!");
		
		//其他排程器要做的事
		TimerTask task3 = new TimerTask() {
			public void run() {
				// SOS一天過後刪除

				// 會員評價到300自動升級VIP

				// 會員積分達到-10 停權 還是被檢舉超過10次成立就停權 停權是終身停權
				// 背後執行序 如果抓到 評分為-10的自動將會員終身停權

			}
		};
		timer3 = new Timer();
		timer3.scheduleAtFixedRate(task3, new java.util.Date(), 10 * 1000); // 每10秒執行一次

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		String memID = (String) session.getAttribute("mid");
		MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
		// System.out.println(memID);

		String resJson = "{\"resJson\" : [";
		// for (String rentStr : rentList) {
		// resJson += "\""+rentStr+"\",";
		// }
		resJson += "\"" + memID + "\",";
		resJson = resJson.substring(0, resJson.length() - 1) + "]}";
		System.out.println("RentServlet.642." + resJson);
		PrintWriter out = res.getWriter();
		out.write(resJson);
		out.flush();
		out.close();
	}

	public void destroy() {
		timer1.cancel();
		timer2.cancel();
		timer3.cancel();
		System.out.println("已移除排程!");
	}

}