﻿package back.loc.model;

import java.util.*;
import java.sql.*;

public class LocJDBCDAO implements LocDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String userid = "sam";
	String passwd = "tiger";

	private static final String INSERT_STMT = 
		"INSERT INTO loc (loc_no,loc_desc) VALUES ('L'||TO_CHAR(loc_seq.NEXTVAL), ?)";
	private static final String GET_ALL_STMT = 
		"SELECT loc_no,loc_desc FROM loc order by loc_no";
	private static final String GET_ONE_STMT = 
		"SELECT loc_no,loc_desc FROM loc where loc_no = ?";
	private static final String DELETE = 
		"DELETE FROM loc where loc_no = ?";
	private static final String UPDATE = 
		"UPDATE loc set loc_desc=? where loc_no = ?";

	@Override
	public void insert(LocVO locVO) {
		int updateCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, locVO.getLoc_desc());

			updateCount = pstmt.executeUpdate();

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
//		return updateCount;
	}

	@Override
	public void update(LocVO locVO) {
		int updateCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, locVO.getLoc_desc());
			pstmt.setString(2, locVO.getLoc_no());

			updateCount = pstmt.executeUpdate();

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
//		return updateCount;
	}

	@Override
	public void delete(String loc_no) {
		int updateCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, loc_no);
			
			updateCount = pstmt.executeUpdate();

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
//		return updateCount;
	}

	@Override
	public LocVO findByPrimaryKey(String loc_no) {

		LocVO locVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, loc_no);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				locVO = new LocVO();
				locVO.setLoc_no(rs.getString("loc_no"));
				locVO.setLoc_desc(rs.getString("loc_desc"));
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
		return locVO;
	}

	@Override
	public List<LocVO> getAll() {
		List<LocVO> list = new ArrayList<LocVO>();
		LocVO locVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				locVO = new LocVO();
				locVO.setLoc_no(rs.getString("loc_no"));
				locVO.setLoc_desc(rs.getString("loc_desc"));
				list.add(locVO); // Store the row in the vector
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

	public static void main(String[] args) {

		LocJDBCDAO dao = new LocJDBCDAO();

		 //新增
//		 LocVO locVO1 = new LocVO();
//		 locVO1.setLoc_desc("大河市");
//		 dao.insert(locVO1);
//			

		 //修改
//		 LocVO locVO2 = new LocVO();
//		 locVO2.setLoc_no("L10016");
//		 locVO2.setLoc_desc("花媽市");
//       dao.update(locVO2);


		 //刪除
//         dao.delete("L10001");


//		// 查詢
//		LocVO locVO3 = dao.findByPrimaryKey("L10001");
//		System.out.print(locVO3.getLoc_no() + ",");
//		System.out.print(locVO3.getLoc_desc());
//		System.out.println("---------------------");
//
//		// 查詢
//		List<LocVO> list = dao.getAll();
//		for (LocVO aLoc : list) {
//			System.out.print(aLoc.getLoc_no() + ",");
//			System.out.print(aLoc.getLoc_desc());
//			System.out.println();
//		}
	}
}
