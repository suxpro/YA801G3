package load_on_startup;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.*;

import front.remind.model.RemindService;
import front.remind.model.RemindVO;
import front.rent.model.RentService;
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
					if ("W_APR".equals(ordVO.getOrd_sta()) || "W_SHIP".equals(ordVO.getOrd_sta()) || "REC_COM".equals(ordVO.getOrd_sta())) {
						java.util.Date nowDate = new java.util.Date(); // 當前時間
						Date ordDate = ordVO.getExp_date(); // 租物期限
						if ((nowDate.getTime() - ordDate.getTime()) >= 0) { // 如果當前時間超過租物期限,則為租約到期
							ordSvc.updateOrd(ordVO, "RENT_EXP");
							System.out
									.println("訂單:"+ordVO.getOrd_no()+"租約到期\n"
											+ "時間:" + nowDate
											+ "\n修改訂單狀態至\"RENT_EXP租約到期\"");
							// System.out.println("nowDate = " + nowDate);
							// System.out.println("ordDate = "+ordDate);
						}
					} else if ("RENT_EXP".equals(ordVO.getOrd_sta())) {
						java.util.Date nowDate = new java.util.Date(); // 當前時間
						Date ordDate = ordVO.getExp_date(); // 租物期限
						if ((nowDate.getTime() - ordDate.getTime()) >= (ordVO.getOt_days() + 1)*24*60*60*1000L) { // 如果當前時間超過租物期限1天,則為租約逾期1天
							//逾期天數+1
							ordVO.setOt_days(ordVO.getOt_days() + 1);
							ordSvc.updateOrd(ordVO, "OT_DAYS");
							
							//發簡訊提醒
							MemberService memSvc = new MemberService();
							RentService rentSvc = new RentService();
							MemberVO memVO = memSvc.getOneMember(ordVO.getTen_no());
							String Mcell = memVO.getMcell();
							String Mname = memVO.getMname();
							// 發送簡訊
							String messageSend =
									Mname + " 您好!\nJustRent提醒:\n"
									+ "您的租物:" + rentSvc.getOneRent(ordVO.getRent_no()).getRent_name()
									+ "已逾期" + ordVO.getOt_days() + "天\n請盡速歸還."
									+ "\n時間:" + nowDate + ".\n";
							System.out.println("Mcell = " + Mcell);
							System.out.println("messageSend = " + messageSend);

							String[] tel ={Mcell};
							String message = messageSend;
							sendMessage.sendMessage(tel , message);
						}
					}
				}
			}
		};
		timer1 = new Timer();
		Calendar cal = new GregorianCalendar(2014, Calendar.AUGUST, 12, 0, 0, 0);
		timer1.scheduleAtFixedRate(task1, cal.getTime(), 1 * 24 * 60 * 60 * 1000L); // 每1天執行一次
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
						String messageSend =
								Mname + "您好!\nJustRent提醒:\n"
								+ remindVO.getRdes() + "\n時間:"
								+ new java.util.Date() + ".\n";
						System.out.println("Mcell = " + Mcell);
						System.out.println("messageSend = " + messageSend);
						
						String[] tel ={Mcell};
						String message = messageSend;
						sendMessage.sendMessage(tel , message);

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
		timer2.scheduleAtFixedRate(task2, new java.util.Date(), 10 * 1000); // 每10秒執行一次
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

			// 抓取session現在登入的member
			HttpSession session = req.getSession();
			String memID = (String) session.getAttribute("mid");
			MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
//			System.out.println("ScheduleServlet.135.現在登入的memberVO.getMno():\n"+memberVO.getMno());

			RemindService remindSvc = new RemindService();
			List<RemindVO> listRemindVO = new ArrayList<RemindVO>();
			listRemindVO = remindSvc.ajaxGetMemRemind(
					memberVO.getMno(), "N");
			if(listRemindVO.size() != 0){
			ArrayList<String> arrayRemind = new ArrayList<String>();
			arrayRemind.add("成功出租");
			arrayRemind.add("成功承租");
			arrayRemind.add("出租確認");
			arrayRemind.add("預約");
			arrayRemind.add("出貨通知");
			arrayRemind.add("租期通知");
			arrayRemind.add("歸還通知");
			arrayRemind.add("求租公告");
			arrayRemind.add("Q&A留言");
			arrayRemind.add("評價");
			arrayRemind.add("逾期通知");
			arrayRemind.add("取消訂單");
			arrayRemind.add("上架通過");
			arrayRemind.add("上架不通過");
			arrayRemind.add("訂單結案");
			arrayRemind.add("追蹤提醒");
			
			// 用JSON存提醒數字,回傳呼叫的AJAX
			Map<String, Integer> map = new LinkedHashMap<String, Integer>();
			for(String strRemind : arrayRemind){
				map.put(strRemind, 0);
			}
			
			JSONObject jsonObj = new JSONObject(map);
			for (RemindVO remindVO : listRemindVO) {
				try {
					for(String strRemind : arrayRemind){
						if (strRemind.equals(remindVO.getRstas())) {
							jsonObj.put(strRemind, (Integer) jsonObj.get(strRemind) + 1);
						}
					}
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			res.setContentType("text/html;charset=utf-8");
			res.setHeader("Cache-Control", "no-cache");
			PrintWriter out = res.getWriter();
//			System.out.println("ScheduleServlet.208.jsonObj:\n" + jsonObj);
			out.write(jsonObj.toString());
			out.flush();
			out.close();
				
			}
		} // end remindHeaderNum

	}

	public void destroy() {
		timer1.cancel();
		timer2.cancel();
		timer3.cancel();
		System.out.println("已移除所有排程!");
	}

}
