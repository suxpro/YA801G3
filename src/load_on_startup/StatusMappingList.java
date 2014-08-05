package load_on_startup;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StatusMappingList extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	// 九種status map 
	Map<String, String> rent_staMap = new LinkedHashMap<String, String>();
	Map<String, String> que_staMap = new LinkedHashMap<String, String>();
	Map<String, String> mem_staMap = new LinkedHashMap<String, String>();
	Map<String, String> ord_staMap = new LinkedHashMap<String, String>();
	Map<String, String> rem_staMap = new LinkedHashMap<String, String>();
	Map<String, String> trad_staMap = new LinkedHashMap<String, String>();
	Map<String, String> tra_staMap = new LinkedHashMap<String, String>();
	Map<String, String> loc_staMap = new LinkedHashMap<String, String>();
	Map<String, String> tag_staMap = new LinkedHashMap<String, String>();
	
	ServletContext context = null;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StatusMappingList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
	
	
	public void init() throws ServletException {
		context = getServletContext();
		// 租物狀態
		rent_staMap.put("W_RENT", "待出租");
		rent_staMap.put("A_RENT", "已出租");
		rent_staMap.put("IN_REP", "檢舉中");
		rent_staMap.put("W_CHECK", "待審核");
		rent_staMap.put("C_RENT", "已下架");
		rent_staMap.put("W_REVIEW", "待複審");
		
		context.setAttribute("rent_staMap", rent_staMap);

		// Q&A狀態
		que_staMap.put("IN_ASK", "發問中");
		que_staMap.put("COM_REPLY", "回覆完成");
		que_staMap.put("CC_ASK", "刪除發問");
		
		context.setAttribute("que_staMap", que_staMap);

		// 會員等級
		mem_staMap.put("G", "一般");
		mem_staMap.put("V", "VIP");
		mem_staMap.put("S", "停權");
		
		mem_staMap.put("M", "男");
		mem_staMap.put("F", "女");
		
		mem_staMap.put("Y", "已驗證");
		mem_staMap.put("N", "未驗證");
		
		context.setAttribute("mem_staMap", mem_staMap);

		// 訂單狀態
		ord_staMap.put("W_APR", "待核准");
		ord_staMap.put("W_SHIP", "待出貨");
		ord_staMap.put("DTBT", "配送中");
		ord_staMap.put("REC_COM", "收貨完成");
		ord_staMap.put("RENT_EXP", "租約到期");
		ord_staMap.put("RT", "回收中");
		ord_staMap.put("RT_COM", "回收完成");
		ord_staMap.put("CLS", "結案");
		ord_staMap.put("CC_ORD", "取消訂單");
		ord_staMap.put("AB_CLS", "異常結案");
		
		context.setAttribute("ord_staMap", ord_staMap);

		// 提醒類型
		rem_staMap.put("SCES_RENT", "成功出租");
		rem_staMap.put("SCES_TEN", "成功承租");
		rem_staMap.put("CF_RENT", "出租確認");
		rem_staMap.put("PRENT", "預約");
		rem_staMap.put("NTC_SHIP", "出貨通知");
		rem_staMap.put("NTC_LEASE", "租期通知");
		rem_staMap.put("NTC_RETR", "歸還通知");
		rem_staMap.put("ANN_BRENT", "求租公告");
		rem_staMap.put("LM_QA", "Q&A留言");
		rem_staMap.put("ASES", "評價");
		rem_staMap.put("OT", "逾期通知");
		
		context.setAttribute("rem_staMap", rem_staMap);

		// 點數交易類型
		trad_staMap.put("M_IMPT", "金錢匯入");
		trad_staMap.put("M_EXPT", "金錢匯出");
		trad_staMap.put("P_INCM", "點數收入");
		trad_staMap.put("P_OTLY", "點數支出");
		trad_staMap.put("P_REFD", "點數退還");
		trad_staMap.put("P_OT_INCM", "點數逾期收入");
		trad_staMap.put("P_OT_OTLY", "點數逾期支出");
		trad_staMap.put("P_VIP_OTLY", "VIP點數支出");
		
		context.setAttribute("trad_staMap", trad_staMap);

		// 租物交易方式
		tra_staMap.put("FORWARDER", "宅配");
		tra_staMap.put("BUNG_OVER", "面交");
		
		context.setAttribute("tra_staMap", tra_staMap);

		// 地區編碼
		loc_staMap.put("L10001", "基隆市");
		loc_staMap.put("L10002", "台北市");
		loc_staMap.put("L10003", "新北市");
		loc_staMap.put("L10004", "桃園縣");
		loc_staMap.put("L10005", "新竹市");
		loc_staMap.put("L10006", "新竹縣");
		loc_staMap.put("L10007", "苗栗縣");
		loc_staMap.put("L10008", "台中市");
		loc_staMap.put("L10009", "台中縣");
		loc_staMap.put("L10010", "彰化縣");
		loc_staMap.put("L10011", "南投縣");
		loc_staMap.put("L10012", "雲林縣");
		loc_staMap.put("L10013", "嘉義市");
		loc_staMap.put("L10014", "嘉義縣");
		loc_staMap.put("L10015", "台南市");
		loc_staMap.put("L10016", "台南縣");
		loc_staMap.put("L10017", "高雄市");
		loc_staMap.put("L10018", "高雄縣");
		loc_staMap.put("L10019", "屏東縣");
		loc_staMap.put("L10020", "宜蘭縣");
		loc_staMap.put("L10021", "花蓮縣");
		loc_staMap.put("L10022", "台東縣");
		loc_staMap.put("L10023", "澎湖縣");
		loc_staMap.put("L10024", "金門縣");
		loc_staMap.put("L10025", "連江縣");
		
		context.setAttribute("loc_staMap", loc_staMap);

		// 租物分類
		tag_staMap.put("T10001", "電腦與周邊設備");
		tag_staMap.put("T10002", "3C家電");
		tag_staMap.put("T10003", "休閒娛樂");
		tag_staMap.put("T10004", "服飾、配件");
		tag_staMap.put("T10005", "旅行、活動用品");
		tag_staMap.put("T10006", "場地空間");
		tag_staMap.put("T10007", "家具、五金工具");
		tag_staMap.put("T10008", "其它");
		
		context.setAttribute("tag_staMap", tag_staMap);
		
		//系統參數
		//運費
		String freight = "200";		
		context.setAttribute("freight", freight);

	}


	public void destroy() {
		//卸載
		context.removeAttribute("rent_staMap");
		context.removeAttribute("que_staMap");
		context.removeAttribute("mem_staMap");
		context.removeAttribute("ord_staMap");
		context.removeAttribute("rem_staMap");
		context.removeAttribute("trad_staMap");
		context.removeAttribute("tra_staMap");
		context.removeAttribute("loc_staMap");
		context.removeAttribute("tag_staMap");
		
		context.removeAttribute("freight");
	}

}
