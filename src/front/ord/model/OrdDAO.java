package front.ord.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import front.member.model.MemberDAO;
import front.member.model.MemberVO;
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

	private static final String INSERT_STMT = "INSERT INTO ord (ord_no, rent_no, ten_no, ord_sta, tra_mode, "
			+ "freight, ten_date, exp_date, ten_days, rent_total, "
			+ "ot_days, init_dps, real_dps, tra_total, loc_no, "
			+ "rec_addr, w_apr_time) "
			+ "VALUES ('O'||TO_CHAR(ord_seq.NEXTVAL), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,  SYSDATE)";
	// Old
	// "INSERT INTO ord (ord_no, rent_no, ten_no, ord_sta, tra_mode, "
	// + "freight, ten_date, exp_date, ten_days, rent_total, "
	// + "ot_days, init_dps, real_dps, tra_total, loc_no, "
	// + "rec_addr, les_ases, les_ases_ct, ten_ases, ten_ases_ct, "
	// + "w_apr_time, w_ship_time, dtbt_time, rec_com_time, rent_exp_time, "
	// + "rt_time, rt_com_time, cls_time, cc_ord_time, ord_cc_cause) "
	// +
	// "VALUES ('O'||TO_CHAR(ord_seq.NEXTVAL), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "
	// + "?, ?, ?, ?, SYSDATE, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	private static final String GET_ALL_STMT = "SELECT * FROM ord WHERE ord_sta NOT IN ('CC_ORD','CLS','AB_CLS') ORDER BY ord_no";
	private static final String GET_ONE_STMT = "SELECT * FROM ord WHERE ord_no = ?";
	// private static final String DELETE =
	// "DELETE FROM ord where ord_no = ?";
	private static final String DELETE = "UPDATE ord SET ord_sta='CC_ORD', CC_ORD_TIME=SYSDATE, ORD_CC_CAUSE=? WHERE ord_no=?";
	private static final String UPDATE = "UPDATE ord SET rent_no=?, ten_no=?, ord_sta=?, tra_mode=?, freight=?, ten_date=?, exp_date=?, ten_days=?, rent_total=?, ot_days=?, init_dps=?, real_dps=?, tra_total=?, loc_no=?, rec_addr=?, les_ases=?, les_ases_ct=?, ten_ases=?, ten_ases_ct=?, w_apr_time=?, w_ship_time=?, dtbt_time=?, rec_com_time=?, rent_exp_time=?, rt_time=?, rt_com_time=?, cls_time=?, cc_ord_time=?, ord_cc_cause=? where ord_no=?";
	private static final String GET_LIVE_ORD_STMT = "SELECT ord_no FROM ord WHERE rent_no=? AND ord_sta IN ('W_SHIP','DTBT','REC_COM','RENT_EXP','RT','RT_COM')";

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
			pstmt.setString(2, ordVO.getTen_no());
			pstmt.setString(3, ordVO.getOrd_sta());
			pstmt.setString(4, ordVO.getTra_mode());
			pstmt.setInt(5, ordVO.getFreight());
			pstmt.setDate(6, ordVO.getTen_date());
			pstmt.setDate(7, ordVO.getExp_date());
			pstmt.setInt(8, ordVO.getTen_days());
			pstmt.setInt(9, ordVO.getRent_total());
			pstmt.setInt(10, ordVO.getOt_days());
			pstmt.setInt(11, ordVO.getInit_dps());
			pstmt.setInt(12, ordVO.getReal_dps());
			pstmt.setInt(13, ordVO.getTra_total());
			pstmt.setString(14, ordVO.getLoc_no());
			pstmt.setString(15, ordVO.getRec_addr());

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
	public void update(OrdVO ordVO) {
		// Connection con = null;
		// PreparedStatement pstmt = null;
		//
		// try {
		//
		// con = ds.getConnection();
		// pstmt = con.prepareStatement(UPDATE);
		//
		// pstmt.setString(1, ordVO.getRent_no());
		// pstmt.setString(2, ordVO.getTen_no());
		// pstmt.setString(3, ordVO.getOrd_sta());
		// pstmt.setString(4, ordVO.getTra_mode());
		// pstmt.setInt(5, ordVO.getFreight());
		// pstmt.setDate(6, ordVO.getTen_date());
		// pstmt.setDate(7, ordVO.getExp_date());
		// pstmt.setInt(8, ordVO.getTen_days());
		// pstmt.setInt(9, ordVO.getRent_total());
		// pstmt.setInt(10, ordVO.getOt_days());
		// pstmt.setInt(11, ordVO.getInit_dps());
		// pstmt.setInt(12, ordVO.getReal_dps());
		// pstmt.setInt(13, ordVO.getTra_total());
		// pstmt.setString(14, ordVO.getLoc_no());
		// pstmt.setString(15, ordVO.getRec_addr());
		// pstmt.setInt(16, ordVO.getLes_ases());
		// pstmt.setString(17, ordVO.getLes_ases_ct());
		// pstmt.setInt(18, ordVO.getTen_ases());
		// pstmt.setString(19, ordVO.getTen_ases_ct());
		// pstmt.setTimestamp(20, ordVO.getW_apr_time());
		// pstmt.setTimestamp(21, ordVO.getW_ship_time());
		// pstmt.setTimestamp(22, ordVO.getDtbt_time());
		// pstmt.setTimestamp(23, ordVO.getRec_com_time());
		// pstmt.setTimestamp(24, ordVO.getRent_exp_time());
		// pstmt.setTimestamp(25, ordVO.getRt_time());
		// pstmt.setTimestamp(26, ordVO.getRt_com_time());
		// pstmt.setTimestamp(27, ordVO.getCls_time());
		// pstmt.setTimestamp(28, ordVO.getCc_ord_time());
		// pstmt.setString(29, ordVO.getOrd_cc_cause());
		// pstmt.setString(30, ordVO.getOrd_no());
		//
		// pstmt.executeUpdate();
		//
		// // Handle any driver errors
		// } catch (SQLException se) {
		// throw new RuntimeException("A database error occured. "
		// + se.getMessage());
		// // Clean up JDBC resources
		// } finally {
		// if (pstmt != null) {
		// try {
		// pstmt.close();
		// } catch (SQLException se) {
		// se.printStackTrace(System.err);
		// }
		// }
		// if (con != null) {
		// try {
		// con.close();
		// } catch (Exception e) {
		// e.printStackTrace(System.err);
		// }
		// }
		// }

	}

	@Override
	public void delete(OrdVO ordVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);

			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, ordVO.getOrd_cc_cause());
			pstmt.setString(2, ordVO.getOrd_no());

			pstmt.executeUpdate();

			// 修改租物狀態
			RentDAO rentDAO = new RentDAO();
			RentVO rentVO = rentDAO.findByPrimaryKey(ordVO.getRent_no());
			rentVO.setRent_sta("W_RENT"); // 更改租物狀態為待出租
			rentDAO.updateRent_sta(rentVO, con);

			// 回復會員帳戶餘額
			MemberDAO memberDAO = new MemberDAO();
			MemberVO memberVO = memberDAO.findByPrimaryKey(ordVO.getTen_no());
			Double mbalance = memberVO.getMbalance();
			mbalance = mbalance + ordVO.getTra_total(); // 餘額加回被訂單扣除費用
			memberVO.setMbalance(mbalance);
			memberDAO.updateMem_mbl(memberVO, con);

			// 新增交易紀錄
			TradeDAO tradeDAO = new TradeDAO();
			TradeVO tradeVO = new TradeVO();
			tradeVO.setMno(memberVO.getMno());
			tradeVO.setTstas("點數退還");
			tradeVO.setTfunds(ordVO.getTra_total().doubleValue());
			tradeDAO.insertForOrd(tradeVO, con);

			// 新增提醒記錄
			RemindDAO remindDAO = new RemindDAO();
			RemindVO remindVO = new RemindVO();
			remindVO.setMno(rentVO.getLes_no());// 注意:該提醒的是出租方
			remindVO.setRno(ordVO.getRent_no());
			remindVO.setRstas("取消訂單");
			remindVO.setRdes("您有一筆訂單已被取消(" + rentVO.getRent_name() + ") !");
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

}
