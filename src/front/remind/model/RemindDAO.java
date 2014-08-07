package front.remind.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class RemindDAO implements RemindDAO_interface{
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
	
	private static final String INSERT_STMT = "INSERT INTO remind (rem_no, mem_no, rent_no, rem_time, rem_stas, rem_des, rem_flag) VALUES ('D'||TO_CHAR(remind_seq.NEXTVAL), ?, ?, ?, ?, ?, ?)";
	//新增一筆提醒記錄for Ord
	private static final String INSERT_forORD_STMT = "INSERT INTO remind (rem_no, mem_no, rent_no, rem_time, rem_stas, rem_des, rem_flag) VALUES ('D'||TO_CHAR(remind_seq.NEXTVAL), ?, ?, SYSDATE, ?, ?, 'Y')";
	
	private static final String GET_ALL_STMT = "SELECT rem_no, mem_no, rent_no, to_char(rem_time,'yyyy-mm-dd') rem_time, rem_stas, rem_des, rem_flag FROM remind order by rem_no";
	private static final String GET_ONE_STMT = "SELECT rem_no, mem_no, rent_no, to_char(rem_time,'yyyy-mm-dd') rem_time, rem_stas, rem_des, rem_flag FROM remind where rem_no = ?";
	private static final String DELETE = "DELETE FROM remind where rem_no = ?";
	private static final String UPDATE = "UPDATE remind set mem_no=?, rent_no=?, rem_time=?, rem_stas=?, rem_des=?, rem_flag=? where rem_no=?";

	

	@Override
	public void insert(RemindVO remindVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, remindVO.getMno());
			pstmt.setString(2, remindVO.getRtno());
			pstmt.setDate(3, remindVO.getRtime());
			pstmt.setString(4, remindVO.getRstas());
			pstmt.setString(5, remindVO.getRdes());
			pstmt.setString(6, remindVO.getRflag());

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

		
	}

	@Override
	public void update(RemindVO remindVO) {


		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, remindVO.getMno());
			pstmt.setString(2, remindVO.getRtno());
			pstmt.setDate(3, remindVO.getRtime());
			pstmt.setString(4, remindVO.getRstas());
			pstmt.setString(5, remindVO.getRdes());
			pstmt.setString(6, remindVO.getRflag());
			pstmt.setString(7, remindVO.getRno());
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

	
		
	}

	@Override
	public void delete(String rno) {


		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, rno);

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

	
		
	}

	@Override
	public RemindVO findByPrimaryKey(String rno) {

		RemindVO remindVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, rno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// remindVo 也稱為 Domain objects			
				remindVO = new RemindVO();
				remindVO.setRno(rs.getString("rem_no"));
				remindVO.setMno(rs.getString("mem_no"));
				remindVO.setRtno(rs.getString("rent_no"));
				remindVO.setRtime(rs.getDate("rem_time"));
				remindVO.setRstas(rs.getString("rem_stas"));
				remindVO.setRdes(rs.getString("rem_des"));
				remindVO.setRflag(rs.getString("rem_flag"));								
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
		return remindVO;
	}

	@Override
	public List<RemindVO> getAll() {
		List<RemindVO> list = new ArrayList<RemindVO>();
		RemindVO remindVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// remindVo 也稱為 Domain objects			
				remindVO = new RemindVO();
				remindVO.setRno(rs.getString("rem_no"));
				remindVO.setMno(rs.getString("mem_no"));
				remindVO.setRtno(rs.getString("rent_no"));
				remindVO.setRtime(rs.getDate("rem_time"));
				remindVO.setRstas(rs.getString("rem_stas"));
				remindVO.setRdes(rs.getString("rem_des"));
				remindVO.setRflag(rs.getString("rem_flag"));	
				list.add(remindVO);				
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

		RemindJDBCDAO dao = new RemindJDBCDAO();

//		// 新增
//		RemindVO remindVO1 = new RemindVO();
//		remindVO1.setMno("M10005");
//		remindVO1.setRtno("A10002");
//		remindVO1.setRtime(java.sql.Date.valueOf("2014-02-01"));
//		remindVO1.setRstas("Q&A留言");
//		remindVO1.setRflag("Y");	
//		dao.insert(remindVO1);
		
//		// 修改
//		RemindVO remindVO2 = new RemindVO();
//		remindVO2.setRno("D10005");
//		remindVO2.setMno("M10006");
//		remindVO2.setRtno("A10001");
//		remindVO2.setRtime(java.sql.Date.valueOf("2013-12-01"));
//		remindVO2.setRstas("Q&A留言");
//		remindVO2.setRflag("Y");
//		dao.update(remindVO2);
		
		

//		// 刪除
//		dao.delete("D10004");

//		// 查詢
//		RemindVO RemindVO3 = dao.findByPrimaryKey("D10002");
//		System.out.print(RemindVO3.getRno() + ",");
//		System.out.print(RemindVO3.getMno() + ",");
//		System.out.print(RemindVO3.getRtno() + ",");
//		System.out.print(RemindVO3.getRtime() + ",");
//		System.out.print(RemindVO3.getRstas() + ",");
//		System.out.print(RemindVO3.getRflag() + ",");			
//		System.out.println("---------------------");
		
		// 查詢
		List<RemindVO> list = dao.getAll();
		for (RemindVO aRemind : list) {
		System.out.print(aRemind.getRno() + ",");
		System.out.print(aRemind.getMno() + ",");
		System.out.print(aRemind.getRtno() + ",");
		System.out.print(aRemind.getRtime() + ",");
		System.out.print(aRemind.getRstas() + ",");
		System.out.print(aRemind.getRflag() + ",");
		System.out.println("");
		}		
	}

	@Override
	public void insertForOrd(RemindVO remindVO, Connection con) {
		PreparedStatement pstmt = null;
		try {
			pstmt = con.prepareStatement(INSERT_forORD_STMT);

			pstmt.setString(1, remindVO.getMno());
			pstmt.setString(2, remindVO.getRno());
			pstmt.setString(3, remindVO.getRstas());
			pstmt.setString(4, remindVO.getRdes());
			
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-trade");
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
		}
		
	}


}
