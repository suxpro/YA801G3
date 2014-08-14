package front.ord.model;

import java.sql.*;
import java.util.*;



public class OrdJDBCDAO implements OrdDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String userid = "user2";
	String passwd = "u222";

	private static final String INSERT_STMT = 
		"INSERT INTO ord (ord_no, rent_no, les_no, ten_no, ord_sta, tra_mode, freight, ten_date, exp_date, ten_days, rent_total, ot_days, init_dps, real_dps, tra_total, loc_no, rec_addr, les_ases, les_ases_ct, ten_ases, ten_ases_ct, w_apr_time, w_ship_time, dtbt_time, rec_com_time, rent_exp_time, rt_time, rt_com_time, cls_time, cc_ord_time, ord_cc_cause) VALUES ('O'||TO_CHAR(ord_seq.NEXTVAL), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT * FROM ord ORDER BY ord_no";
	private static final String GET_ONE_STMT = 
		"SELECT * FROM ord WHERE ord_no = ?";
//	private static final String DELETE = 
//		"DELETE FROM ord where ord_no = ?";
	private static final String DELETE = 
		"UPDATE ord SET ord_sta='CC_ORD', CC_ORD_TIME=SYSDATE, ORD_CC_CAUSE=? WHERE ord_no=?";
	private static final String UPDATE = 
		"UPDATE ord SET rent_no=?, les_no=?, ten_no=?, ord_sta=?, tra_mode=?, freight=?, ten_date=?, exp_date=?, ten_days=?, rent_total=?, ot_days=?, init_dps=?, real_dps=?, tra_total=?, loc_no=?, rec_addr=?, les_ases=?, les_ases_ct=?, ten_ases=?, ten_ases_ct=?, w_apr_time=?, w_ship_time=?, dtbt_time=?, rec_com_time=?, rent_exp_time=?, rt_time=?, rt_com_time=?, cls_time=?, cc_ord_time=?, ord_cc_cause=? where ord_no=?";

	



	@Override
	public List<OrdVO> getAllOrdByMember(String mno) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public void insert(OrdVO ordVO) {
		int updateCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
			pstmt.setInt(17, ordVO.getLes_ases());
			pstmt.setString(18, ordVO.getLes_ases_ct());
			pstmt.setInt(19, ordVO.getTen_ases());
			pstmt.setString(20, ordVO.getTen_ases_ct());
			pstmt.setTimestamp(21, ordVO.getW_apr_time());
			pstmt.setTimestamp(22, ordVO.getW_ship_time());
			pstmt.setTimestamp(23, ordVO.getDtbt_time());
			pstmt.setTimestamp(24, ordVO.getRec_com_time());
			pstmt.setTimestamp(25, ordVO.getRent_exp_time());
			pstmt.setTimestamp(26, ordVO.getRt_time());
			pstmt.setTimestamp(27, ordVO.getRt_com_time());
			pstmt.setTimestamp(28, ordVO.getCls_time());
			pstmt.setTimestamp(29, ordVO.getCc_ord_time());
			pstmt.setString(30, ordVO.getOrd_cc_cause());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
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
		//return updateCount;
	}


	public void update(OrdVO ordVO) {
		int updateCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

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
			pstmt.setTimestamp(21, ordVO.getW_apr_time());
			pstmt.setTimestamp(22, ordVO.getW_ship_time());
			pstmt.setTimestamp(23, ordVO.getDtbt_time());
			pstmt.setTimestamp(24, ordVO.getRec_com_time());
			pstmt.setTimestamp(25, ordVO.getRent_exp_time());
			pstmt.setTimestamp(26, ordVO.getRt_time());
			pstmt.setTimestamp(27, ordVO.getRt_com_time());
			pstmt.setTimestamp(28, ordVO.getCls_time());
			pstmt.setTimestamp(29, ordVO.getCc_ord_time());
			pstmt.setString(30, ordVO.getOrd_cc_cause());
			pstmt.setString(31, ordVO.getOrd_no());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
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
		//return updateCount;
	}

//	@Override
//	public void delete(String ord_no, String ord_cc_cause) {
//		int updateCount = 0;
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		try {
//
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
//			pstmt = con.prepareStatement(DELETE);
//			
//			pstmt.setString(1, ord_cc_cause);
//			pstmt.setString(2, ord_no);
//			
//			pstmt.executeUpdate();
//
//			// Handle any driver errors
//		} catch (ClassNotFoundException e) {
//			throw new RuntimeException("Couldn't load database driver. "
//					+ e.getMessage());
//			// Handle any SQL errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		} finally {
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}
//		//return updateCount;
//	}

	@Override
	public OrdVO findByPrimaryKey(String ord_no) {

		OrdVO ordVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
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

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
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

	//小豬加,找尋訂單資料是否該筆ord_no是否有人正在租
	@Override
	public String findLiveOrdByRentNo(String rent_no) {

		String ord_no = "";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, rent_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo �]�٬� Domain objects
				ord_no = rs.getString("ord_no");
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
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
	
	public static void main(String[] args) {

		OrdJDBCDAO dao = new OrdJDBCDAO();

		 //�s�W
//		OrdVO ordVO1 = new OrdVO();
//		 ordVO1.setRent_no("R10034");
//		 ordVO1.setles_no("T10033");
//		 ordVO1.setTen_no("T10034");
//		 ordVO1.setOrd_sta("w_ship");
//		 ordVO1.setTra_mode("����");
//		 ordVO1.setFreight(new Integer(200));
//		 ordVO1.setTen_date(java.sql.Date.valueOf("2013-01-08"));
//		 ordVO1.setExp_date(java.sql.Date.valueOf("2013-01-15"));
//		 ordVO1.setTen_days(new Integer(7));
//		 ordVO1.setRent_total(new Integer(900));
//		 ordVO1.setOt_days(new Integer(0));
//		 ordVO1.setInit_dps(new Integer(1000));
//		 ordVO1.setReal_dps(new Integer(1000));
//		 ordVO1.setTra_total(new Integer(1900));
//		 ordVO1.setLes_ases(new Integer(101));
//		 ordVO1.setLoc_no("L10034");
//		 ordVO1.setRec_addr("���c�����j��300��");
//		 ordVO1.setLes_ases_ct("������t�ȱo����");
//		 ordVO1.setTen_ases(new Integer(201));
//		 ordVO1.setTen_ases_ct("������t�ȱo����");
//		 ordVO1.setW_apr_time(java.sql.Timestamp.valueOf("2013-01-03 22:37:16"));
//		 ordVO1.setW_ship_time(java.sql.Timestamp.valueOf("2013-01-06 22:37:16"));
//		 ordVO1.setDtbt_time(java.sql.Timestamp.valueOf("2013-01-07 22:37:16"));
//		 ordVO1.setRec_com_time(java.sql.Timestamp.valueOf("2013-01-15v"));
//		 ordVO1.setRent_exp_time(java.sql.Timestamp.valueOf("2013-01-15 22:37:16"));
//		 ordVO1.setRt_time(java.sql.Timestamp.valueOf("2013-01-15 22:37:16"));
//		 ordVO1.setRt_com_time(java.sql.Timestamp.valueOf("2013-01-15 22:37:16"));
//		 ordVO1.setCls_time(java.sql.Timestamp.valueOf("2013-01-15 22:37:16"));	
//		 ordVO1.setCc_ord_time(null);	
//		 ordVO1.setOrd_cc_cause(null);	
//		 int updateCount_insert = dao.insert(ordVO1);
//		 System.out.println(updateCount_insert);
				

//		 �ק�
//		 OrdVO ordVO2 = new OrdVO();
//		 ordVO2.setOrd_no("O10001");
//		 ordVO2.setRent_no("R10035");
//		 ordVO2.setLes_no("T10034");
//		 ordVO2.setTen_no("T10035");
//		 ordVO2.setOrd_sta("w_ship");
//		 ordVO2.setTra_mode("����");
//		 ordVO2.setFreight(new Integer(200));
//		 ordVO2.setTen_date(java.sql.Date.valueOf("2013-01-08"));
//		 ordVO2.setExp_date(java.sql.Date.valueOf("2013-01-15"));
//		 ordVO2.setTen_days(new Integer(7));
//		 ordVO2.setRent_total(new Integer(900));
//		 ordVO2.setOt_days(new Integer(0));
//		 ordVO2.setInit_dps(new Integer(1000));
//		 ordVO2.setReal_dps(new Integer(1000));
//		 ordVO2.setTra_total(new Integer(1900));
//		 ordVO2.setLes_ases(new Integer(101));
//		 ordVO2.setLoc_no("L10035");
//		 ordVO2.setRec_addr("���c�����j��300��");
//		 ordVO2.setLes_ases_ct("������t�ȱo����");
//		 ordVO2.setTen_ases(new Integer(201));
//		 ordVO2.setTen_ases_ct("������t�ȱo����");
//		 ordVO2.setW_apr_time(java.sql.Timestamp.valueOf("2014-06-08 22:37:16"));
//		 ordVO2.setW_ship_time(java.sql.Timestamp.valueOf("2013-01-06 22:37:16"));
//		 ordVO2.setDtbt_time(java.sql.Timestamp.valueOf("2013-01-07 22:37:16"));
//		 ordVO2.setRec_com_time(java.sql.Timestamp.valueOf("2013-01-15 22:37:16"));
//		 ordVO2.setRent_exp_time(java.sql.Timestamp.valueOf("2013-01-15 22:37:16"));
//		 ordVO2.setRt_time(java.sql.Timestamp.valueOf("2013-01-15 22:37:16"));
//		 ordVO2.setRt_com_time(java.sql.Timestamp.valueOf("2013-01-15 22:37:16"));
//		 ordVO2.setCls_time(java.sql.Timestamp.valueOf("2013-01-15 22:37:16"));	
//		 ordVO2.setCc_ord_time(null);	
//		 ordVO2.setOrd_cc_cause(null);
//		 int updateCount_update = dao.update(ordVO2);
//		 System.out.println(updateCount_update);
				

		 //�R��
//		 int updateCount_delete = dao.delete("O10002");
//		 System.out.println(updateCount_delete);

//		// �d��
//		OrdVO ordVO3 = dao.findByPrimaryKey("O10001");
//		System.out.print(ordVO3.getOrd_no() + ",");
//    	System.out.print(ordVO3.getRent_no() + ",");
//	    System.out.print(ordVO3.getLes_no() + ",");
//	    System.out.print(ordVO3.getTen_no() + ",");
//     	System.out.print(ordVO3.getOrd_sta() + ",");
//	    System.out.print(ordVO3.getTra_mode() + ",");
//	    System.out.print(ordVO3.getFreight() + ",");
//		System.out.print(ordVO3.getTen_date() + ",");
//    	System.out.print(ordVO3.getExp_date() + ",");
//	    System.out.print(ordVO3.getTen_days() + ",");
//     	System.out.print(ordVO3.getRent_total() + ",");
//	    System.out.print(ordVO3.getOt_days() + ",");
//	    System.out.print(ordVO3.getInit_dps() + ",");
//		System.out.print(ordVO3.getReal_dps() + ",");
//    	System.out.print(ordVO3.getTra_total() + ",");
//	    System.out.print(ordVO3.getLes_ases() + ",");
//     	System.out.print(ordVO3.getLoc_no() + ",");
//	    System.out.print(ordVO3.getRec_addr() + ",");
//	    System.out.print(ordVO3.getLes_ases_ct() + ",");
//		System.out.print(ordVO3.getTen_ases() + ",");
//    	System.out.print(ordVO3.getTen_ases_ct() + ",");
//	    System.out.print(ordVO3.getW_apr_time() + ",");
//     	System.out.print(ordVO3.getW_ship_time() + ",");
//	    System.out.print(ordVO3.getDtbt_time() + ",");
//	    System.out.print(ordVO3.getRec_com_time() + ",");
//		System.out.print(ordVO3.getRent_exp_time() + ",");
//    	System.out.print(ordVO3.getRt_time() + ",");
//	    System.out.print(ordVO3.getRt_com_time() + ",");
//     	System.out.print(ordVO3.getCls_time() + ",");
//	    System.out.print(ordVO3.getCc_ord_time() + ",");
//	    System.out.print(ordVO3.getOrd_cc_cause());	

//
//		// �d��
		List<OrdVO> list = dao.getAll();
		for (OrdVO aOrd : list) {
			System.out.print(aOrd.getOrd_no() + ",");
	    	System.out.print(aOrd.getRent_no() + ",");
	    	System.out.print(aOrd.getLes_no() + ",");
		    System.out.print(aOrd.getTen_no() + ",");
	     	System.out.print(aOrd.getOrd_sta() + ",");
		    System.out.print(aOrd.getTra_mode() + ",");
		    System.out.print(aOrd.getFreight() + ",");
			System.out.print(aOrd.getTen_date() + ",");
	    	System.out.print(aOrd.getExp_date() + ",");
		    System.out.print(aOrd.getTen_days() + ",");
	     	System.out.print(aOrd.getRent_total() + ",");
		    System.out.print(aOrd.getOt_days() + ",");
		    System.out.print(aOrd.getInit_dps() + ",");
			System.out.print(aOrd.getReal_dps() + ",");
	    	System.out.print(aOrd.getTra_total() + ",");
		    System.out.print(aOrd.getLes_ases() + ",");
	     	System.out.print(aOrd.getLoc_no() + ",");
		    System.out.print(aOrd.getRec_addr() + ",");
		    System.out.print(aOrd.getLes_ases_ct() + ",");
			System.out.print(aOrd.getTen_ases() + ",");
	    	System.out.print(aOrd.getTen_ases_ct() + ",");
		    System.out.print(aOrd.getW_apr_time() + ",");
	     	System.out.print(aOrd.getW_ship_time() + ",");
		    System.out.print(aOrd.getDtbt_time() + ",");
		    System.out.print(aOrd.getRec_com_time() + ",");
			System.out.print(aOrd.getRent_exp_time() + ",");
	    	System.out.print(aOrd.getRt_time() + ",");
		    System.out.print(aOrd.getRt_com_time() + ",");
	     	System.out.print(aOrd.getCls_time() + ",");
		    System.out.print(aOrd.getCc_ord_time() + ",");
		    System.out.print(aOrd.getOrd_cc_cause());						
			System.out.println();
		}
	}


	@Override
	public void update(OrdVO ordVO, String sta) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(OrdVO ordVO, String role) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void renew(OrdVO ordVO, Integer dif_price) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public Set<String> findRenewOrdByRentNo(String rent_no) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public void updateAses(OrdVO ordVO, String role) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public List<OrdVO> getAllByMno(String role, String mno) {
		// TODO Auto-generated method stub
		return null;
	}
}
