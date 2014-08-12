package front.prerent.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class PrentDAO implements PrentDAO_interface {
	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/renterDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = 
		"INSERT INTO prerent (prent_no, rent_no, ten_no, prent_time, prent_days, prent_flag, ord_no) VALUES ('P'||TO_CHAR(prerent_seq.NEXTVAL), ?, ?, SYSDATE, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT * FROM prerent WHERE prent_flag='Y' AND ten_no =? order by prent_no";
	private static final String GET_ONE_STMT = 
		"SELECT * FROM prerent WHERE prent_flag='Y' and prent_no =?";
//	private static final String DELETE = 
//		"DELETE FROM prerent where prent_no = ?";
	private static final String DELETE = 
			"UPDATE prerent SET prent_flag='N' WHERE prent_no = ?";
	private static final String UPDATE = 
		"UPDATE prerent set rent_no=?, ten_no=?, prent_time=?, prent_days=?, prent_flag=?, ord_no=? where prent_no = ?";

	@Override
	public void insert(PrentVO prentVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, prentVO.getRent_no());
			pstmt.setString(2, prentVO.getTen_no());
			//pstmt.setTimestamp(3, prentVO.getPrent_time());
			pstmt.setInt(3, prentVO.getPrent_days());
			pstmt.setString(4, prentVO.getPrent_flag());
			pstmt.setString(5, prentVO.getOrd_no());
	
			pstmt.executeUpdate();

			// Handle any driver errors
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
//		return updateCount;
	}

	@Override
	public void update(PrentVO prentVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, prentVO.getRent_no());
			pstmt.setString(2, prentVO.getTen_no());
			pstmt.setTimestamp(3, prentVO.getPrent_time());
			pstmt.setInt(4, prentVO.getPrent_days());
			pstmt.setString(5, prentVO.getPrent_flag());
			pstmt.setString(6, prentVO.getOrd_no());
			pstmt.setString(7, prentVO.getPrent_no());

			pstmt.executeUpdate();

			// Handle any driver errors
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
//		return updateCount;
	}

	@Override
	public void delete(String prent_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, prent_no);
			
			pstmt.executeUpdate();

			// Handle any driver errors
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
//		return updateCount;
	}

	@Override
	public PrentVO findByPrimaryKey(String prent_no) {

		PrentVO prentVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, prent_no);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				prentVO = new PrentVO();
				prentVO.setPrent_no(rs.getString("prent_no"));
				prentVO.setRent_no(rs.getString("rent_no"));
				prentVO.setTen_no(rs.getString("ten_no"));
				prentVO.setPrent_time(rs.getTimestamp("prent_time"));
				prentVO.setPrent_days(rs.getInt("prent_days"));
				prentVO.setPrent_flag(rs.getString("prent_flag"));
				prentVO.setOrd_no(rs.getString("ord_no"));
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
		return prentVO;
	}

	@Override
	public List<PrentVO> getAll(String mno) {
		List<PrentVO> list = new ArrayList<PrentVO>();
		PrentVO prentVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			pstmt.setString(1, mno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				prentVO = new PrentVO();
				prentVO.setPrent_no(rs.getString("prent_no"));
				prentVO.setRent_no(rs.getString("rent_no"));
				prentVO.setTen_no(rs.getString("ten_no"));
				prentVO.setPrent_time(rs.getTimestamp("prent_time"));
				prentVO.setPrent_days(rs.getInt("prent_days"));
				prentVO.setPrent_flag(rs.getString("prent_flag"));
				prentVO.setOrd_no(rs.getString("ord_no"));
				list.add(prentVO); // Store the row in the vector
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

	public static void main(String[] args) {

		PrentDAO dao = new PrentDAO();

		 //新增
//		PrentVO prentVO1 = new PrentVO();
//		prentVO1.setRent_no("R10033");
//		prentVO1.setTen_no("T10033");
//		prentVO1.setPrent_time(java.sql.Date.valueOf("2013-01-08 11:23:47"));
//		prentVO1.setPrent_days(new Integer(3));
//		prentVO1.setPrent_flag("Y");
//		prentVO1.setOrd_no("O10033");		
//		 int updateCount_insert = dao.insert(prentVO1);
//		 System.out.println(updateCount_insert);
				

		 //修改
//		 PrentVO prentVO2 = new PrentVO();
//		 prentVO2.setPrent_no("P10001");
//		 prentVO2.setRent_no("R10035");
//		 prentVO2.setTen_no("T10035");
//		 prentVO2.setPrent_time(java.sql.Date.valueOf("2013-01-08 11:23:47"));
//		 prentVO2.setPrent_days(new Integer(3));
//		 prentVO2.setPrent_flag("Y");
//		 prentVO2.setOrd_no("O10035");
//		 int updateCount_update = dao.update(prentVO2);
//		 System.out.println(updateCount_update);
				

		 //刪除
//		 int updateCount_delete = dao.delete("P10003");
//		 System.out.println(updateCount_delete);

//		// 查詢
//		PrentVO prentVO3 = dao.findByPrimaryKey("P10001");
//		System.out.println("---------------------");
//		System.out.print(prentVO3.getPrent_no() + ",");
//		System.out.print(prentVO3.getRent_no() + ",");
//		System.out.print(prentVO3.getTen_no() + ",");
//		System.out.print(prentVO3.getPrent_time() + ",");
//		System.out.print(prentVO3.getPrent_days() + ",");
//		System.out.print(prentVO3.getPrent_flag() + ",");
//		System.out.print(prentVO3.getOrd_no());

//
//		// 查詢
//		List<PrentVO> list = dao.getAll();
//		for (PrentVO aPrent : list) {
//			System.out.print(aPrent.getPrent_no() + ",");
//	    	System.out.print(aPrent.getRent_no() + ",");
//		    System.out.print(aPrent.getTen_no() + ",");
//	     	System.out.print(aPrent.getPrent_time() + ",");
//		    System.out.print(aPrent.getPrent_days() + ",");
//		    System.out.print(aPrent.getPrent_flag() + ",");
//			System.out.print(aPrent.getOrd_no());
//			System.out.println();
//		}
	}
}
