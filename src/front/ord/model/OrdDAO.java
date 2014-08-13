package front.ord.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import front.member.model.MemberDAO;
import front.member.model.MemberVO;
import front.prerent.model.PrentDAO;
import front.remind.model.RemindDAO;
import front.remind.model.RemindVO;
import front.rent.model.RentDAO;
import front.rent.model.RentVO;
import front.trade.model.TradeDAO;
import front.trade.model.TradeVO;

public class OrdDAO implements OrdDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/renterDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO ord (ord_no, rent_no, les_no, ten_no, ord_sta, tra_mode, "
			+ "freight, ten_date, exp_date, ten_days, rent_total, "
			+ "ot_days, init_dps, real_dps, tra_total, loc_no, "
			+ "rec_addr, w_apr_time) "
			+ "VALUES ('O'||TO_CHAR(ord_seq.NEXTVAL), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";

	private static final String RENEW_STMT ="INSERT INTO ord (ord_no, rent_no, les_no,  ten_no, ord_sta, tra_mode, "
			+ "freight, ten_date, exp_date, ten_days, rent_total, "
			+ "ot_days, init_dps, real_dps, tra_total, loc_no, "
			+ "rec_addr, les_ases, les_ases_ct, ten_ases, ten_ases_ct, "
			+ "w_apr_time, w_ship_time, dtbt_time, rec_com_time, rent_exp_time, "
			+ "rt_time, rt_com_time, cls_time, cc_ord_time, ord_cc_cause) "
			+ "VALUES ('O'||TO_CHAR(ord_seq.NEXTVAL), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, SYSDATE, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	private static final String GET_ALL_STMT = "SELECT * FROM ord WHERE ord_sta NOT IN ('CC_ORD','CLS','AB_CLS') ORDER BY ord_no";
	private static final String GET_ONE_STMT = "SELECT * FROM ord WHERE ord_no = ?";
	private static final String GET_LIVE_ORD_STMT = "SELECT ord_no FROM ord WHERE rent_no=? AND ord_sta IN ('W_SHIP','DTBT','REC_COM','RENT_EXP','RT','RT_COM')";
	private static final String GET_RENEW_ORD_STMT = "SELECT ord_no FROM ord WHERE ord_sta = 'RE_ORD' AND rent_no=? ";
	//鈞彥,找出會員的所有歷史訂單
	private static final String GET_ALL_ORD_MEMBER = "SELECT * FROM(SELECT * FROM ord WHERE ord_sta IN ('CLS','AB_CLS') AND les_no = ? UNION SELECT * FROM ord WHERE ord_sta IN ('CLS','AB_CLS') AND  ten_no = ?) a　ORDER BY cls_time DESC";
	
	private static final String UPDATE_W_SHIP = "UPDATE ord SET ord_sta='W_SHIP', W_SHIP_TIME=SYSDATE WHERE ord_no=?";
	private static final String UPDATE_REC_COM = "UPDATE ord SET ord_sta='REC_COM', REC_COM_TIME=SYSDATE WHERE ord_no=?";
	private static final String UPDATE_RENT_EXP = "UPDATE ord SET ord_sta='RENT_EXP', RENT_EXP_TIME=SYSDATE WHERE ord_no=?"; //小豬加,排程器跑租約到期
	private static final String UPDATE_OT_DAYS = "UPDATE ord SET ot_days=? WHERE ord_no=?"; //小豬加,排程器跑租約逾期1天,OT_DAYS+1
	private static final String UPDATE_RT_COM = "UPDATE ord SET ord_sta='RT_COM', RT_COM_TIME=SYSDATE WHERE ord_no=?";
	private static final String UPDATE_CLS = "UPDATE ord SET ord_sta='CLS', CLS_TIME=SYSDATE WHERE ord_no=?";
	private static final String UPDATE_APP_RENEW = "UPDATE ord SET ord_sta=? WHERE ord_no=?";
//	private static final String UPDATE = "UPDATE ord SET rent_no=?, ten_no=?, ord_sta=?, tra_mode=?, freight=?, ten_date=?, exp_date=?, ten_days=?, rent_total=?, ot_days=?, init_dps=?, real_dps=?, tra_total=?, loc_no=?, rec_addr=?, les_ases=?, les_ases_ct=?, ten_ases=?, ten_ases_ct=?, w_apr_time=?, w_ship_time=?, dtbt_time=?, rec_com_time=?, rent_exp_time=?, rt_time=?, rt_com_time=?, cls_time=?, cc_ord_time=?, ord_cc_cause=? where ord_no=?";

	private static final String DELETE = "UPDATE ord SET ord_sta='CC_ORD', CC_ORD_TIME=SYSDATE, ORD_CC_CAUSE=? WHERE ord_no=?";
	
	
	@Override
	public List<OrdVO> getAllOrdByMember(String mno) {

		List<OrdVO> list = new ArrayList<OrdVO>();
		OrdVO ordVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_ORD_MEMBER);

			pstmt.setString(1, mno);
			pstmt.setString(2, mno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ordVO = new OrdVO();
				ordVO.setRent_no(rs.getString("rent_no"));
				ordVO.setLes_no(rs.getString("les_no"));
				ordVO.setTen_no(rs.getString("ten_no"));
				ordVO.setOrd_sta(rs.getString("ord_sta"));
				ordVO.setTra_mode(rs.getString("tra_mode"));
				ordVO.setFreight(rs.getInt("freight"));
				ordVO.setTen_date(rs.getDate("ten_date"));
				ordVO.setExp_date(rs.getDate("exp_date"));
				ordVO.setTen_days(rs.getInt("ten_days"));
				ordVO.setRent_total(rs.getInt("rent_total"));
				ordVO.setOt_days(rs.getInt("ot_days"));
				ordVO.setInit_dps(rs.getInt("init_dps"));
				ordVO.setReal_dps(rs.getInt("real_dps"));
				ordVO.setTra_total(rs.getInt("tra_total"));
				ordVO.setLoc_no(rs.getString("loc_no"));
				ordVO.setRec_addr(rs.getString("rec_addr"));
				ordVO.setLes_ases(rs.getInt("les_ases"));
				ordVO.setLes_ases_ct(rs.getString("les_ases_ct"));
				ordVO.setTen_ases(rs.getInt("ten_ases"));
				ordVO.setTen_ases_ct(rs.getString("ten_ases_ct"));
				ordVO.setW_apr_time(rs.getTimestamp("w_apr_time"));
				ordVO.setW_ship_time(rs.getTimestamp("w_ship_time"));
				ordVO.setDtbt_time(rs.getTimestamp("dtbt_time"));
				ordVO.setRec_com_time(rs.getTimestamp("rec_com_time"));
				ordVO.setRent_exp_time(rs.getTimestamp("rent_exp_time"));
				ordVO.setRt_time(rs.getTimestamp("rt_time"));
				ordVO.setRt_com_time(rs.getTimestamp("rt_com_time"));
				ordVO.setCls_time(rs.getTimestamp("cls_time"));
				ordVO.setCc_ord_time(rs.getTimestamp("cc_ord_time"));
				ordVO.setOrd_cc_cause(rs.getString("ord_cc_cause"));
				ordVO.setOrd_no(rs.getString("ord_no"));
				list.add(ordVO);
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	
	}


	@Override
	public void insert(OrdVO ordVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);

			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, ordVO.getRent_no());
			pstmt.setString(2, ordVO.getLes_no());
			pstmt.setString(3, ordVO.getTen_no());
			pstmt.setString(4, ordVO.getOrd_sta());
			pstmt.setString(5, ordVO.getTra_mode());
			pstmt.setInt(6, ordVO.getFreight());
			pstmt.setDate(7, ordVO.getTen_date());
			pstmt.setDate(8, ordVO.getExp_date());
			pstmt.setInt(9, ordVO.getTen_days());
			pstmt.setInt(10, ordVO.getRent_total());
			pstmt.setInt(11, ordVO.getOt_days());
			pstmt.setInt(12, ordVO.getInit_dps());
			pstmt.setInt(13, ordVO.getReal_dps());
			pstmt.setInt(14, ordVO.getTra_total());
			pstmt.setString(15, ordVO.getLoc_no());
			pstmt.setString(16, ordVO.getRec_addr());

			pstmt.executeUpdate();

			// 修改租物狀態
			RentDAO rentDAO = new RentDAO();
			RentVO rentVO = rentDAO.findByPrimaryKey(ordVO.getRent_no());
			rentVO.setRent_sta("A_RENT"); // 更改租物狀態為已出租
			rentDAO.updateRent_sta(rentVO, con);

			// 扣除會員帳戶餘額
			MemberDAO memberDAO = new MemberDAO();
			MemberVO memberVO = memberDAO.findByPrimaryKey(ordVO.getTen_no());
			Double mbalance = memberVO.getMbalance();
			mbalance = mbalance - ordVO.getTra_total(); // 餘額扣除訂單費用
			memberVO.setMbalance(mbalance);
			memberDAO.updateMem_mbl(memberVO, con);

			// 新增交易紀錄
			TradeDAO tradeDAO = new TradeDAO();
			TradeVO tradeVO = new TradeVO();
			tradeVO.setMno(memberVO.getMno());
			tradeVO.setTstas("點數支出");
			tradeVO.setTfunds(ordVO.getTra_total().doubleValue());
			tradeDAO.insertForOrd(tradeVO, con);

			// 新增提醒記錄
			RemindDAO remindDAO = new RemindDAO();
			RemindVO remindVO = new RemindVO();
			remindVO.setMno(rentVO.getLes_no());// 注意:該提醒的是出租方
			remindVO.setRno(ordVO.getRent_no());
			remindVO.setRstas("出租確認");
			remindVO.setRdes("您有一筆新的訂單需確認(" + rentVO.getRent_name() + ") !");
			remindDAO.insertForOrd(remindVO, con);

			// 完成所有資料修改
			con.commit();
			con.setAutoCommit(true);

			// Handle any driver errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-member");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public void update(OrdVO ordVO, String sta) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);
			//依照訂單要更新的狀態
			if(sta.equals("W_SHIP")){
				
				pstmt = con.prepareStatement(UPDATE_W_SHIP);
				pstmt.setString(1, ordVO.getOrd_no());
				pstmt.executeUpdate();
				
			}else if (sta.equals("APP_RENEW")){
				//找尋原先訂單的紀錄
				String pOrd_no = ordVO.getOrd_cc_cause();
				OrdVO pOrdVO = findByPrimaryKey(pOrd_no);
				//取得原先訂單的最新狀態 - parent
				String pOrd_sta = pOrdVO.getOrd_sta();
				
				pstmt = con.prepareStatement(UPDATE_APP_RENEW);
				//讓新訂單繼承原訂單的狀態
				pstmt.setString(1, pOrd_sta);
				pstmt.setString(2, ordVO.getOrd_no());
				pstmt.executeUpdate();
				
				//報廢原先訂單
				pOrdVO.setOrd_cc_cause("訂單["+ ordVO.getOrd_no() +"]續約成功,報廢原訂單");
				//由系統呼叫取消訂單
				delete(pOrdVO, "sys");
				
			}else if(sta.equals("REC_COM")){ 
				
				pstmt = con.prepareStatement(UPDATE_REC_COM);
				pstmt.setString(1, ordVO.getOrd_no());
				pstmt.executeUpdate();
				
			}else if(sta.equals("RENT_EXP")){ //小豬加,排程器跑租約到期
				
				pstmt = con.prepareStatement(UPDATE_RENT_EXP);
				pstmt.setString(1, ordVO.getOrd_no());
				pstmt.executeUpdate();
				
				//報廢未核准的續約訂單  add by思賢
				Set<String> set = findRenewOrdByRentNo(ordVO.getRent_no());
				
				for (String ord_no : set){	
					
					OrdVO reOrdVO = findByPrimaryKey(ord_no);
					reOrdVO.setOrd_cc_cause("訂單["+ ordVO.getOrd_no() +"]的租約已到期, 系統報廢未核准的續約訂單");
					//由系統報廢 續約訂單
					delete(reOrdVO, "sys");
				}	
				
			}else if(sta.equals("RT_COM")){ 
				
				pstmt = con.prepareStatement(UPDATE_RT_COM);
				pstmt.setString(1, ordVO.getOrd_no());
				pstmt.executeUpdate();
				
			}else if(sta.equals("CLS")){ 
				
				pstmt = con.prepareStatement(UPDATE_CLS);
				pstmt.setString(1, ordVO.getOrd_no());
				pstmt.executeUpdate();
				
			}else if(sta.equals("OT_DAYS")){ //小豬加,排程器跑租約逾期1天,OT_DAYS+1
				
				pstmt = con.prepareStatement(UPDATE_OT_DAYS);
				pstmt.setInt(1, ordVO.getOt_days());
				pstmt.setString(2, ordVO.getOrd_no());
				pstmt.executeUpdate();
				
			}

			
			RentDAO rentDAO = new RentDAO();
			RentVO rentVO = rentDAO.findByPrimaryKey(ordVO.getRent_no());
			
			if(sta.equals("CLS")){ 
				// 修改租物狀態
				rentVO.setRent_sta("W_RENT"); // 更改租物狀態為待出租
				rentDAO.updateRent_sta(rentVO, con);	
				
				// 出租方 租金收入 更新帳戶餘額
				MemberDAO lesDAO = new MemberDAO();
				MemberVO lesVO = lesDAO.findByPrimaryKey(ordVO.getLes_no());
				Double les_mbl = lesVO.getMbalance();
				les_mbl = les_mbl + ordVO.getRent_total(); // 餘額加上租金總額(未來可以從中抽取平台服務費)
				lesVO.setMbalance(les_mbl);
				lesDAO.updateMem_mbl(lesVO, con);

				// 出租方的交易紀錄
				TradeDAO tLesDAO = new TradeDAO();
				TradeVO tLesVO = new TradeVO();
				tLesVO.setMno(ordVO.getLes_no());
				tLesVO.setTstas("點數收入");
				tLesVO.setTfunds(ordVO.getRent_total().doubleValue());
				tLesDAO.insertForOrd(tLesVO, con);
				
				
				// 承租方 押金退還 更新帳戶餘額
				MemberDAO tenDAO = new MemberDAO();
				MemberVO tenVO = tenDAO.findByPrimaryKey(ordVO.getTen_no());
				Double ten_mbl = tenVO.getMbalance();
				ten_mbl = ten_mbl + ordVO.getReal_dps(); // 實際押金加回承租方餘額
				tenVO.setMbalance(ten_mbl);
				tenDAO.updateMem_mbl(tenVO, con);

				// 承租方的交易紀錄
				TradeDAO tTenDAO = new TradeDAO();
				TradeVO tTenVO = new TradeVO();
				tTenVO.setMno(ordVO.getTen_no());
				tTenVO.setTstas("點數退還");
				tTenVO.setTfunds(ordVO.getReal_dps().doubleValue());
				tTenDAO.insertForOrd(tTenVO, con);
								
			}

			// 新增提醒記錄	
			if(sta.equals("W_SHIP")){		
				
				RemindDAO remindDAO = new RemindDAO();
				RemindVO remindVO = new RemindVO();			
				remindVO.setMno(ordVO.getTen_no());// 注意:該提醒的是承租方
				remindVO.setRno(ordVO.getRent_no());
				remindVO.setRstas("成功承租");	
				remindVO.setRdes("您有一筆訂單已核准(" + (rentVO.getRent_name()) + ")!");
				remindDAO.insertForOrd(remindVO, con);
				
			}else if(sta.equals("APP_RENEW")){
				
				RemindDAO remindDAO = new RemindDAO();
				RemindVO remindVO = new RemindVO();			
				remindVO.setMno(ordVO.getTen_no());// 注意:該提醒的是承租方
				remindVO.setRno(ordVO.getRent_no());
				remindVO.setRstas("成功承租");	
				remindVO.setRdes("您有一筆續約訂單已核准(" + (rentVO.getRent_name()) + ")!");
				remindDAO.insertForOrd(remindVO, con);
				
			} else if(sta.equals("CLS")){
				
				// 提醒出租方 訂單結案 租金匯入
				RemindDAO rLesDAO = new RemindDAO();
				RemindVO rLesVO = new RemindVO();			
				rLesVO.setMno(ordVO.getLes_no());// 注意:該提醒的是出租方
				rLesVO.setRno(ordVO.getRent_no());
				rLesVO.setRstas("訂單結案");	
				rLesVO.setRdes("您有一筆訂單已結案(" + (rentVO.getRent_name()) + "), 已存入租金所得[" + ordVO.getRent_total() + "].");
				rLesDAO.insertForOrd(rLesVO, con);
						
				// 提醒承租方 訂單結案 押金退回
				RemindDAO rTenDAO = new RemindDAO();
				RemindVO rTenVO = new RemindVO();			
				rTenVO.setMno(ordVO.getTen_no());// 注意:該提醒的是承租方
				rTenVO.setRno(ordVO.getRent_no());
				rTenVO.setRstas("訂單結案");	
				rTenVO.setRdes("您有一筆訂單已結案(" + (rentVO.getRent_name()) + "), 已退還租物押金[" + ordVO.getReal_dps() + "].");
				rTenDAO.insertForOrd(rTenVO, con);						
				
				// 提醒 追蹤的所有人 租物又重新開放出租
				PrentDAO prentDAO = new PrentDAO();
				Set<String> set = prentDAO.getAllByRent(ordVO.getRent_no());
				// 取得租物的追蹤會員編號
				for (String mno : set){
					
					if(!mno.equals(ordVO.getTen_no())){ //過濾掉這筆訂單的已承租的會員編號
						
						RemindDAO rPrentDAO = new RemindDAO();
						RemindVO rPrentVO = new RemindVO();			
						rPrentVO.setMno(mno);// 注意:該提醒的是承租方
						rPrentVO.setRno(ordVO.getRent_no());
						rPrentVO.setRstas("追蹤提醒 ");	
						rPrentVO.setRdes("您有一個追蹤中的租物(" + (rentVO.getRent_name()) + "), 已重新開放出租.");
						rPrentDAO.insertForOrd(rPrentVO, con);	
					}
					
				}
						
			}


			// 完成所有資料修改
			con.commit();
			con.setAutoCommit(true);

			// Handle any driver errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-member");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	// 取消訂單
	@Override
	public void delete(OrdVO ordVO, String role) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		OrdVO oOrdVO = findByPrimaryKey(ordVO.getOrd_no()); //取得訂單做廢前的"資料庫"紀錄
		String oOrd_sta = oOrdVO.getOrd_sta(); //原訂單現今在資料庫的狀態
		try {

			con = ds.getConnection();
			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);
            // 取消訂單 並寫入取消原因
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, ordVO.getOrd_cc_cause());
			pstmt.setString(2, ordVO.getOrd_no());
			pstmt.executeUpdate();

			// 修改租物狀態 當待核准的訂單被 承租會員或是出租會員所取消
			RentDAO rentDAO = new RentDAO();
			RentVO rentVO = rentDAO.findByPrimaryKey(ordVO.getRent_no());
			// 只有當訂單狀態為待核准 而且取消的腳色不是系統自動執行(由會員執行)
			if (oOrd_sta.equals("W_APR") && !role.equals("sys")){ 
				
				rentVO.setRent_sta("W_RENT"); // 更改租物狀態為待出租
				rentDAO.updateRent_sta(rentVO, con);
			}
			
			// 回復會員帳戶餘額
			MemberDAO memberDAO = new MemberDAO();
			MemberVO memberVO = memberDAO.findByPrimaryKey(ordVO.getTen_no());
			Double mbalance = memberVO.getMbalance();
			// 只有當訂單狀態為待核准 而且取消的腳色不是系統自動執行(由會員執行)
			if (oOrd_sta.equals("W_APR") && !role.equals("sys")){
				
				mbalance = mbalance + ordVO.getTra_total(); // 餘額加回被訂單扣除的費用
				memberVO.setMbalance(mbalance);
				memberDAO.updateMem_mbl(memberVO, con);
				
			} else if (oOrd_sta.equals("W_APR") && role.equals("sys")){ 
				//續約成立 系統自動報廢原訂單  不做任何動作修改餘額
			
			} else if (oOrd_sta.equals("RE_ORD")){
				// 餘額加回續約扣除的需補差額                                                                      // 取得續約前訂單的交易總吳
				mbalance = mbalance + oOrdVO.getTra_total() - (findByPrimaryKey(oOrdVO.getOrd_cc_cause()).getTra_total()); 
				memberVO.setMbalance(mbalance);
				memberDAO.updateMem_mbl(memberVO, con);				
			}

			// 新增交易紀錄
			TradeDAO tradeDAO = new TradeDAO();
			TradeVO tradeVO = new TradeVO();
			tradeVO.setMno(memberVO.getMno());
			tradeVO.setTstas("點數退還");
			// 只有當訂單狀態為待核准 而且取消的腳色不是系統自動執行(由會員執行)
			if (oOrd_sta.equals("W_APR") && !role.equals("sys")){ 
				
				tradeVO.setTfunds(ordVO.getTra_total().doubleValue());
				tradeDAO.insertForOrd(tradeVO, con);
				
			} else if (oOrd_sta.equals("W_APR") && role.equals("sys")){ 
				//續約成立 系統自動報廢原訂單  不做任何動作修改餘額
							
			} else if (oOrd_sta.equals("RE_ORD")){
				// 續約扣除的需補差額
				tradeVO.setTfunds(oOrdVO.getTra_total() - (findByPrimaryKey(oOrdVO.getOrd_cc_cause()).getTra_total()).doubleValue()); 
				tradeDAO.insertForOrd(tradeVO, con);	
				
			}

			// 新增提醒記錄
			RemindDAO remindDAO = new RemindDAO();
			RemindVO remindVO = new RemindVO();
			if (role.equals("ten")){				
				remindVO.setMno(ordVO.getLes_no());// 注意:該提醒的是出租方
			} else if (role.equals("les")){				
				remindVO.setMno(ordVO.getTen_no());// 注意:該提醒的是承租方
			} else if (role.equals("sys")){				
				remindVO.setMno(ordVO.getTen_no());// 注意:該提醒的是承租方
			}
			
			//只有當原訂單狀態為待核准且取消的人不是系統自動(由會員執行)
			if (oOrd_sta.equals("W_APR") && !role.equals("sys")){ 
				
				remindVO.setRno(ordVO.getRent_no());
				remindVO.setRstas("取消訂單");
				remindVO.setRdes("您有一筆訂單已被取消(" + rentVO.getRent_name() + ")! 取消原因為: " + ordVO.getOrd_cc_cause());
				remindDAO.insertForOrd(remindVO, con);
				
			} else if (oOrd_sta.equals("W_APR") && role.equals("sys")){ 
				//續約成立 系統自動報廢原訂單  不做任何動作修改餘額
							
			} else if (oOrd_sta.equals("RE_ORD")){
				
				remindVO.setRno(ordVO.getRent_no());
				remindVO.setRstas("取消訂單");
				remindVO.setRdes("您有一筆續約訂單已被取消(" + rentVO.getRent_name() + ")! 取消原因為: " + ordVO.getOrd_cc_cause());
				remindDAO.insertForOrd(remindVO, con);		
			} 

			// 完成所有資料修改
			con.commit();
			con.setAutoCommit(true);

			// Handle any driver errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-member");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public OrdVO findByPrimaryKey(String ord_no) {

		OrdVO ordVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, ord_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo �]�٬� Domain objects
				ordVO = new OrdVO();
				ordVO.setOrd_no(rs.getString("ord_no"));
				ordVO.setRent_no(rs.getString("rent_no"));
				ordVO.setLes_no(rs.getString("les_no"));
				ordVO.setTen_no(rs.getString("ten_no"));
				ordVO.setOrd_sta(rs.getString("ord_sta"));
				ordVO.setTra_mode(rs.getString("tra_mode"));
				ordVO.setFreight(rs.getInt("freight"));
				ordVO.setTen_date(rs.getDate("ten_date"));
				ordVO.setExp_date(rs.getDate("exp_date"));
				ordVO.setTen_days(rs.getInt("ten_days"));
				ordVO.setRent_total(rs.getInt("rent_total"));
				ordVO.setOt_days(rs.getInt("ot_days"));
				ordVO.setInit_dps(rs.getInt("init_dps"));
				ordVO.setReal_dps(rs.getInt("real_dps"));
				ordVO.setTra_total(rs.getInt("tra_total"));
				ordVO.setLoc_no(rs.getString("loc_no"));
				ordVO.setRec_addr(rs.getString("rec_addr"));
				ordVO.setLes_ases(rs.getInt("les_ases"));
				ordVO.setLes_ases_ct(rs.getString("les_ases_ct"));
				ordVO.setTen_ases(rs.getInt("ten_ases"));
				ordVO.setTen_ases_ct(rs.getString("ten_ases_ct"));
				ordVO.setW_apr_time(rs.getTimestamp("w_apr_time"));
				ordVO.setW_ship_time(rs.getTimestamp("w_ship_time"));
				ordVO.setDtbt_time(rs.getTimestamp("dtbt_time"));
				ordVO.setRec_com_time(rs.getTimestamp("rec_com_time"));
				ordVO.setRent_exp_time(rs.getTimestamp("rent_exp_time"));
				ordVO.setRt_time(rs.getTimestamp("rt_time"));
				ordVO.setRt_com_time(rs.getTimestamp("rt_com_time"));
				ordVO.setCls_time(rs.getTimestamp("cls_time"));
				ordVO.setCc_ord_time(rs.getTimestamp("cc_ord_time"));
				ordVO.setOrd_cc_cause(rs.getString("ord_cc_cause"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return ordVO;
	}

	@Override
	public List<OrdVO> getAll() {
		List<OrdVO> list = new ArrayList<OrdVO>();
		OrdVO ordVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ordVO = new OrdVO();
				ordVO.setRent_no(rs.getString("rent_no"));
				ordVO.setLes_no(rs.getString("les_no"));
				ordVO.setTen_no(rs.getString("ten_no"));
				ordVO.setOrd_sta(rs.getString("ord_sta"));
				ordVO.setTra_mode(rs.getString("tra_mode"));
				ordVO.setFreight(rs.getInt("freight"));
				ordVO.setTen_date(rs.getDate("ten_date"));
				ordVO.setExp_date(rs.getDate("exp_date"));
				ordVO.setTen_days(rs.getInt("ten_days"));
				ordVO.setRent_total(rs.getInt("rent_total"));
				ordVO.setOt_days(rs.getInt("ot_days"));
				ordVO.setInit_dps(rs.getInt("init_dps"));
				ordVO.setReal_dps(rs.getInt("real_dps"));
				ordVO.setTra_total(rs.getInt("tra_total"));
				ordVO.setLoc_no(rs.getString("loc_no"));
				ordVO.setRec_addr(rs.getString("rec_addr"));
				ordVO.setLes_ases(rs.getInt("les_ases"));
				ordVO.setLes_ases_ct(rs.getString("les_ases_ct"));
				ordVO.setTen_ases(rs.getInt("ten_ases"));
				ordVO.setTen_ases_ct(rs.getString("ten_ases_ct"));
				ordVO.setW_apr_time(rs.getTimestamp("w_apr_time"));
				ordVO.setW_ship_time(rs.getTimestamp("w_ship_time"));
				ordVO.setDtbt_time(rs.getTimestamp("dtbt_time"));
				ordVO.setRec_com_time(rs.getTimestamp("rec_com_time"));
				ordVO.setRent_exp_time(rs.getTimestamp("rent_exp_time"));
				ordVO.setRt_time(rs.getTimestamp("rt_time"));
				ordVO.setRt_com_time(rs.getTimestamp("rt_com_time"));
				ordVO.setCls_time(rs.getTimestamp("cls_time"));
				ordVO.setCc_ord_time(rs.getTimestamp("cc_ord_time"));
				ordVO.setOrd_cc_cause(rs.getString("ord_cc_cause"));
				ordVO.setOrd_no(rs.getString("ord_no"));
				list.add(ordVO);
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

	// 小豬加,找尋訂單資料是否該筆ord_no是否有人正在租
	@Override
	public String findLiveOrdByRentNo(String rent_no) {

		String ord_no = "";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// System.out.println("OrdDAO.391."+rent_no);
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_LIVE_ORD_STMT);

			pstmt.setString(1, rent_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo �]�٬� Domain objects
				ord_no = rs.getString("ord_no");
				// System.out.println("OrdDAO.404."+ord_no);
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return ord_no;
	}

	@Override
	public Set<String> findRenewOrdByRentNo(String rent_no) {

		Set<String> set = new HashSet<String>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_RENEW_ORD_STMT);
			pstmt.setString(1, rent_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				set.add(rs.getString("ord_no"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return set;
	}	
	
	@Override
	public void renew(OrdVO ordVO, Integer dif_price) {
		Connection con = null;
		PreparedStatement pstmt = null;
		//先取的原先的訂單號碼
		String oOrd_no = ordVO.getOrd_no();

		try {

			con = ds.getConnection();
			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);

			pstmt = con.prepareStatement(RENEW_STMT);
			
			pstmt.setString(1, ordVO.getRent_no());
			pstmt.setString(2, ordVO.getLes_no());
			pstmt.setString(3, ordVO.getTen_no());
			pstmt.setString(4, ordVO.getOrd_sta());
			pstmt.setString(5, ordVO.getTra_mode());
			pstmt.setInt(6, ordVO.getFreight());
			pstmt.setDate(7, ordVO.getTen_date());
			pstmt.setDate(8, ordVO.getExp_date());
			pstmt.setInt(9, ordVO.getTen_days());
			pstmt.setInt(10, ordVO.getRent_total());
			pstmt.setInt(11, ordVO.getOt_days());
			pstmt.setInt(12, ordVO.getInit_dps());
			pstmt.setInt(13, ordVO.getReal_dps());
			pstmt.setInt(14, ordVO.getTra_total());
			pstmt.setString(15, ordVO.getLoc_no());
			pstmt.setString(16, ordVO.getRec_addr());
			pstmt.setInt(17, ordVO.getLes_ases());
			pstmt.setString(18, ordVO.getLes_ases_ct());
			pstmt.setInt(19, ordVO.getTen_ases());
			pstmt.setString(20, ordVO.getTen_ases_ct());
			//pstmt.setTimestamp(20, ordVO.getW_apr_time());
			pstmt.setTimestamp(21, ordVO.getW_ship_time());
			pstmt.setTimestamp(22, ordVO.getDtbt_time());
			pstmt.setTimestamp(23, ordVO.getRec_com_time());
			pstmt.setTimestamp(24, ordVO.getRent_exp_time());
			pstmt.setTimestamp(25, ordVO.getRt_time());
			pstmt.setTimestamp(26, ordVO.getRt_com_time());
			pstmt.setTimestamp(27, ordVO.getCls_time());
			pstmt.setTimestamp(28, ordVO.getCc_ord_time());
			//先將取消原因欄位 先放置原先訂單編號 一旦續約被取消可以拿來使用
			pstmt.setString(29, oOrd_no); 

			pstmt.executeUpdate();
			
			// 修改租物狀態
			RentDAO rentDAO = new RentDAO();
			RentVO rentVO = rentDAO.findByPrimaryKey(ordVO.getRent_no());
//			rentVO.setRent_sta("A_RENT"); // 更改租物狀態為已出租
//			rentDAO.updateRent_sta(rentVO, con);

			// 扣除會員帳戶餘額
			MemberDAO memberDAO = new MemberDAO();
			MemberVO memberVO = memberDAO.findByPrimaryKey(ordVO.getTen_no());
			Double mbalance = memberVO.getMbalance();
			mbalance = mbalance - dif_price; // 餘額扣除需補差額
			memberVO.setMbalance(mbalance);
			memberDAO.updateMem_mbl(memberVO, con);

			// 新增交易紀錄
			TradeDAO tradeDAO = new TradeDAO();
			TradeVO tradeVO = new TradeVO();
			tradeVO.setMno(memberVO.getMno());
			tradeVO.setTstas("點數支出");
			tradeVO.setTfunds(dif_price.doubleValue());
			tradeDAO.insertForOrd(tradeVO, con);

			// 新增提醒記錄
			RemindDAO remindDAO = new RemindDAO();
			RemindVO remindVO = new RemindVO();
			remindVO.setMno(rentVO.getLes_no());// 注意:該提醒的是出租方
			remindVO.setRno(ordVO.getRent_no());
			remindVO.setRstas("出租確認");
			remindVO.setRdes("您有一筆新的續租訂單需確認(" + rentVO.getRent_name() + ") !");
			remindDAO.insertForOrd(remindVO, con);

			// 完成所有資料修改
			con.commit();
			con.setAutoCommit(true);

			// Handle any driver errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-member");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

}
