package back.trade.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class TradeDAO implements TradeDAO_interface {
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
	
	private static final String INSERT_STMT = "INSERT INTO trade (tra_no, mem_no, tra_mem_id, tra_time, tra_stas, tra_funds, tra_in) VALUES ('T'||TO_CHAR(trade_seq.NEXTVAL), ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT tra_no, mem_no, tra_mem_id, tra_time, tra_stas, tra_funds, tra_in FROM trade order by tra_no";
	private static final String GET_ONE_STMT = "SELECT tra_no, mem_no, tra_mem_id, tra_time, tra_stas, tra_funds, tra_in FROM trade where tra_no = ?";
	private static final String DELETE = "DELETE FROM trade where tra_no = ?";
	private static final String UPDATE = "UPDATE trade set mem_no=?, tra_mem_id=?, tra_time=?, tra_stas=?, tra_funds=?, tra_in=? where tra_no=?";

	

	@Override
	public void insert(TradeVO tradeVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, tradeVO.getMno());
			pstmt.setString(2, tradeVO.getTmid());
			pstmt.setTimestamp(3, tradeVO.getTdate());
			pstmt.setString(4, tradeVO.getTstas());
			pstmt.setDouble(5, tradeVO.getTfunds());
			pstmt.setString(6, tradeVO.getTin());



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
	public void update(TradeVO tradeVO) {


		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, tradeVO.getMno());
			pstmt.setString(2, tradeVO.getTmid());
			pstmt.setTimestamp(3, tradeVO.getTdate());
			pstmt.setString(4, tradeVO.getTstas());
			pstmt.setDouble(5, tradeVO.getTfunds());
			pstmt.setString(6, tradeVO.getTin());
			pstmt.setString(7, tradeVO.getTno());

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
	public void delete(String tno) {


		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, tno);

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
	public TradeVO findByPrimaryKey(String tno) {

		TradeVO tradeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, tno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// tradeVo 也稱為 Domain objects			
				tradeVO = new TradeVO();
				tradeVO.setTno(rs.getString("tra_no"));
				tradeVO.setMno(rs.getString("mem_no"));
				tradeVO.setTmid(rs.getString("tra_mem_id"));
				tradeVO.setTdate(rs.getTimestamp("tra_time"));
				tradeVO.setTstas(rs.getString("tra_stas"));
				tradeVO.setTfunds(rs.getDouble("tra_funds"));
				tradeVO.setTin(rs.getString("tra_in"));
								
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
		return tradeVO;
	}



	@Override
	public List<TradeVO> getAll() {
		List<TradeVO> list = new ArrayList<TradeVO>();
		TradeVO tradeVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// tradeVo 也稱為 Domain objects			
				tradeVO = new TradeVO();
				tradeVO.setTno(rs.getString("tra_no"));
				tradeVO.setMno(rs.getString("mem_no"));
				tradeVO.setTmid(rs.getString("tra_mem_id"));
				tradeVO.setTdate(rs.getTimestamp("tra_time"));
				tradeVO.setTstas(rs.getString("tra_stas"));
				tradeVO.setTfunds(rs.getDouble("tra_funds"));
				tradeVO.setTin(rs.getString("tra_in"));
				list.add(tradeVO);				
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

		TradeJDBCDAO dao = new TradeJDBCDAO();

//		// 新增
//		TradeVO tradeVO1 = new TradeVO();
//		tradeVO1.setMno("M10005");
//		tradeVO1.setTmid("1596258445612365");
//		tradeVO1.setTdate(java.sql.Date.valueOf("2012-07-01"));
//		tradeVO1.setTstas("點數收入");
//		tradeVO1.setTfunds(new Double(2500));
//		tradeVO1.setTin("Y");	
//		dao.insert(tradeVO1);
		
//		// 修改
//		TradeVO tradeVO2 = new TradeVO();
//		tradeVO2.setTno("T10000");
//		tradeVO2.setMno("M10002");
//		tradeVO2.setTmid("1258452612351238");
//		tradeVO2.setTdate(java.sql.Date.valueOf("2014-02-02"));
//		tradeVO2.setTstas("金錢匯入");
//		tradeVO2.setTfunds(new Double(2500));
//		tradeVO2.setTin("Y");
//		dao.update(tradeVO2);
		
		

//		// 刪除
//		dao.delete("T10004");

//		// 查詢
//		TradeVO tradeVO3 = dao.findByPrimaryKey("T10002");
//		System.out.print(tradeVO3.getTno() + ",");
//		System.out.print(tradeVO3.getMno() + ",");
//		System.out.print(tradeVO3.getTmid() + ",");
//		System.out.print(tradeVO3.getTdate() + ",");
//		System.out.print(tradeVO3.getTstas() + ",");
//		System.out.print(tradeVO3.getTfunds() + ",");
//		System.out.print(tradeVO3.getTin() + ",");				
//		System.out.println("---------------------");
		
//		// 查詢
//		List<TradeVO> list = dao.getAll();
//		for (TradeVO aTrade : list) {
//		System.out.print(aTrade.getTno() + ",");
//		System.out.print(aTrade.getMno() + ",");
//		System.out.print(aTrade.getTmid() + ",");
//		System.out.print(aTrade.getTdate() + ",");
//		System.out.print(aTrade.getTstas() + ",");
//		System.out.print(aTrade.getTfunds() + ",");
//
//		System.out.println("");
//		}		
	}



}
