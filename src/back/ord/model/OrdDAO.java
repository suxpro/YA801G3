package back.ord.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Ord;


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

	private static final String GET_LES_NO_STMT =	"SELECT DISTINCT les_no FROM ord ORDER BY les_no";
	private static final String GET_TEN_NO_STMT =	"SELECT DISTINCT ten_no FROM ord ORDER BY ten_no";
	private static final String GET_RENT_NO_STMT =	"SELECT DISTINCT rent_no FROM ord ORDER BY rent_no";
	private static final String GET_ORD_NO_STMT =	"SELECT DISTINCT ord_no FROM ord ORDER BY ord_no";
	//鈞彥,找出會員的所有歷史訂單
	private static final String GET_ALL_ORD_MEMBER = "SELECT * FROM(SELECT * FROM ord WHERE ord_sta IN ('CLS','AB_CLS') AND les_no = ? UNION SELECT * FROM ord WHERE ord_sta IN ('CLS','AB_CLS') AND  ten_no = ?) a　ORDER BY cls_time DESC";


	@Override
	public List<OrdVO> getAll(Map<String, String[]> map) {
		List<OrdVO> list = new ArrayList<OrdVO>();
		OrdVO ordVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			
			con = ds.getConnection();
			String finalSQL = "select * from ord "
					+ jdbcUtil_CompositeQuery_Ord.get_WhereCondition(map)
					+ "ORDER BY ord_no ";
			
			String orderBy = null;
			orderBy = map.get("orderBy")[0];
			if (orderBy.equals("desc")){
				finalSQL = finalSQL + "DESC";
			}
				
			pstmt = con.prepareStatement(finalSQL);
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


//	@Override
//	public Set<String> getOrdNoSet(String field_name) {
//
//		Set<String> set = new HashSet<String>();
//		
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		try {
//
//			con = ds.getConnection();
//			if(field_name.equals("les_no")){
//				pstmt = con.prepareStatement(GET_LES_NO_STMT);
//			} else if(field_name.equals("ten_no")){
//				pstmt = con.prepareStatement(GET_TEN_NO_STMT);			
//			} else if(field_name.equals("rent_no")){
//				pstmt = con.prepareStatement(GET_RENT_NO_STMT);				
//			} else if(field_name.equals("ord_no")){
//				pstmt = con.prepareStatement(GET_ORD_NO_STMT);
//			}
//				
//			rs = pstmt.executeQuery();
//
//			while (rs.next()) {
//				set.add(rs.getString(1));
//			}
//
//			// Handle any driver errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		} finally {
//			if (rs != null) {
//				try {
//					rs.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
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
//		return set;
//	}	

//	@Override
//	public List<OrdVO> getAllOrdByMno(String mno) {
//
//		List<OrdVO> list = new ArrayList<OrdVO>();
//		OrdVO ordVO = null;
//
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		try {
//
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(GET_ALL_ORD_MEMBER);
//
//			pstmt.setString(1, mno);
//			pstmt.setString(2, mno);
//			rs = pstmt.executeQuery();
//
//			while (rs.next()) {
//				ordVO = new OrdVO();
//				ordVO.setRent_no(rs.getString("rent_no"));
//				ordVO.setLes_no(rs.getString("les_no"));
//				ordVO.setTen_no(rs.getString("ten_no"));
//				ordVO.setOrd_sta(rs.getString("ord_sta"));
//				ordVO.setTra_mode(rs.getString("tra_mode"));
//				ordVO.setFreight(rs.getInt("freight"));
//				ordVO.setTen_date(rs.getDate("ten_date"));
//				ordVO.setExp_date(rs.getDate("exp_date"));
//				ordVO.setTen_days(rs.getInt("ten_days"));
//				ordVO.setRent_total(rs.getInt("rent_total"));
//				ordVO.setOt_days(rs.getInt("ot_days"));
//				ordVO.setInit_dps(rs.getInt("init_dps"));
//				ordVO.setReal_dps(rs.getInt("real_dps"));
//				ordVO.setTra_total(rs.getInt("tra_total"));
//				ordVO.setLoc_no(rs.getString("loc_no"));
//				ordVO.setRec_addr(rs.getString("rec_addr"));
//				ordVO.setLes_ases(rs.getInt("les_ases"));
//				ordVO.setLes_ases_ct(rs.getString("les_ases_ct"));
//				ordVO.setTen_ases(rs.getInt("ten_ases"));
//				ordVO.setTen_ases_ct(rs.getString("ten_ases_ct"));
//				ordVO.setW_apr_time(rs.getTimestamp("w_apr_time"));
//				ordVO.setW_ship_time(rs.getTimestamp("w_ship_time"));
//				ordVO.setDtbt_time(rs.getTimestamp("dtbt_time"));
//				ordVO.setRec_com_time(rs.getTimestamp("rec_com_time"));
//				ordVO.setRent_exp_time(rs.getTimestamp("rent_exp_time"));
//				ordVO.setRt_time(rs.getTimestamp("rt_time"));
//				ordVO.setRt_com_time(rs.getTimestamp("rt_com_time"));
//				ordVO.setCls_time(rs.getTimestamp("cls_time"));
//				ordVO.setCc_ord_time(rs.getTimestamp("cc_ord_time"));
//				ordVO.setOrd_cc_cause(rs.getString("ord_cc_cause"));
//				ordVO.setOrd_no(rs.getString("ord_no"));
//				list.add(ordVO);
//			}
//
//			// Handle any driver errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		} finally {
//			if (rs != null) {
//				try {
//					rs.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
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
//		return list;
//	
//	}
	

}
