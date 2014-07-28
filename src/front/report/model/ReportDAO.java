package front.report.model;

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

public class ReportDAO implements ReportDAO_interface{
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
	
	private static final String INSERT_STMT = "INSERT INTO report (rep_no, rep_mem_p, rep_rent_no, rep_mem_byp, rep_time, rep_cuz, rep_emp_chk, rep_sol, rep_solt, rep_sold) VALUES ('H'||TO_CHAR(report_seq.NEXTVAL), ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT rep_no, rep_mem_p, rep_rent_no, rep_mem_byp, to_char(rep_time,'yyyy-mm-dd') rep_time, rep_cuz, rep_emp_chk, rep_sol, to_char(rep_solt,'yyyy-mm-dd') rep_solt, rep_sold FROM report order by rep_no";
	private static final String GET_ONE_STMT = "SELECT rep_no, rep_mem_p, rep_rent_no, rep_mem_byp, to_char(rep_time,'yyyy-mm-dd') rep_time, rep_cuz, rep_emp_chk, rep_sol, to_char(rep_solt,'yyyy-mm-dd') rep_solt, rep_sold FROM report where rep_no = ?";
	private static final String DELETE = "DELETE FROM report where rep_no = ?";
	private static final String UPDATE = "UPDATE report set rep_mem_p=?, rep_rent_no=?, rep_mem_byp=?, rep_time=?, rep_cuz=?, rep_emp_chk=?, rep_sol=?, rep_solt=?, rep_sold=? where rep_no=?";

	

	@Override
	public void insert(ReportVO reportVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, reportVO.getRm_p());
			pstmt.setString(2, reportVO.getRr_no());
			pstmt.setString(3, reportVO.getRm_byp());
			pstmt.setDate(4, reportVO.getRtime());
			pstmt.setString(5, reportVO.getRcuz());
			pstmt.setString(6, reportVO.getRe_chk());
			pstmt.setString(7, reportVO.getRsol());
			pstmt.setDate(8, reportVO.getRsolt());
			pstmt.setString(9, reportVO.getRsold());

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
	public void update(ReportVO reportVO) {


		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, reportVO.getRm_p());
			pstmt.setString(2, reportVO.getRr_no());
			pstmt.setString(3, reportVO.getRm_byp());
			pstmt.setDate(4, reportVO.getRtime());
			pstmt.setString(5, reportVO.getRcuz());
			pstmt.setString(6, reportVO.getRe_chk());
			pstmt.setString(7, reportVO.getRsol());
			pstmt.setDate(8, reportVO.getRsolt());
			pstmt.setString(9, reportVO.getRsold());
			pstmt.setString(10, reportVO.getRno());
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
	public ReportVO findByPrimaryKey(String rno) {

		ReportVO reportVO = null;
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
				reportVO = new ReportVO();
				reportVO.setRno(rs.getString("rep_no"));
				reportVO.setRm_p(rs.getString("rep_mem_p"));
				reportVO.setRr_no(rs.getString("rep_rent_no"));
				reportVO.setRm_byp(rs.getString("rep_mem_byp"));
				reportVO.setRtime(rs.getDate("rep_time"));
				reportVO.setRcuz(rs.getString("rep_cuz"));
				reportVO.setRe_chk(rs.getString("rep_emp_chk"));
				reportVO.setRsol(rs.getString("rep_sol"));
				reportVO.setRsolt(rs.getDate("rep_solt"));
				reportVO.setRsold(rs.getString("rep_sold"));				
							
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
		return reportVO;
	}

	@Override
	public List<ReportVO> getAll() {
		List<ReportVO> list = new ArrayList<ReportVO>();
		ReportVO reportVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// remindVo 也稱為 Domain objects			
				reportVO = new ReportVO();
				reportVO.setRno(rs.getString("rep_no"));
				reportVO.setRm_p(rs.getString("rep_mem_p"));
				reportVO.setRr_no(rs.getString("rep_rent_no"));
				reportVO.setRm_byp(rs.getString("rep_mem_byp"));
				reportVO.setRtime(rs.getDate("rep_time"));
				reportVO.setRcuz(rs.getString("rep_cuz"));
				reportVO.setRe_chk(rs.getString("rep_emp_chk"));
				reportVO.setRsol(rs.getString("rep_sol"));
				reportVO.setRsolt(rs.getDate("rep_solt"));
				reportVO.setRsold(rs.getString("rep_sold"));			
				list.add(reportVO);				
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

		ReportJDBCDAO dao = new ReportJDBCDAO();

//		// 新增
//		ReportVO ReportVO1 = new ReportVO();
//		ReportVO1.setRm_p("M10002");
//		ReportVO1.setRr_no("R10002");
//		ReportVO1.setRm_byp("M10003");
//		ReportVO1.setRtime(java.sql.Date.valueOf("2014-02-01"));
//		ReportVO1.setRcuz("價錢廉價");
//		ReportVO1.setRe_chk("E10002");
//		ReportVO1.setRsol("Y");
//		ReportVO1.setRsolt(java.sql.Date.valueOf("2014-02-01"));
//		ReportVO1.setRsold("我同意!");	
//		dao.insert(ReportVO1);
		
//		// 修改
//		ReportVO ReportVO2 = new ReportVO();
//		ReportVO2.setRno("H10001");
//		ReportVO2.setRm_p("M10002");
//		ReportVO2.setRr_no("R10002");
//		ReportVO2.setRm_byp("M10003");
//		ReportVO2.setRtime(java.sql.Date.valueOf("2014-02-01"));
//		ReportVO2.setRcuz("價錢廉價");
//		ReportVO2.setRe_chk("E10002");
//		ReportVO2.setRsol("Y");
//		ReportVO2.setRsolt(java.sql.Date.valueOf("2014-02-01"));
//		ReportVO2.setRsold("我同意!");	
//		dao.update(ReportVO2);
		
		

//		// 刪除
//		dao.delete("H10004");

//		// 查詢
//		ReportVO ReportVO3 = dao.findByPrimaryKey("H10002");
//		System.out.print(ReportVO3.getRno() + ",");
//		System.out.print(ReportVO3.getRm_p() + ",");
//		System.out.print(ReportVO3.getRr_no() + ",");
//		System.out.print(ReportVO3.getRm_byp() + ",");
//		System.out.print(ReportVO3.getRtime() + ",");
//		System.out.print(ReportVO3.getRcuz() + ",");
//		System.out.print(ReportVO3.getRe_chk() + ",");
//		System.out.print(ReportVO3.getRsol() + ",");
//		System.out.print(ReportVO3.getRsolt() + ",");
//		System.out.print(ReportVO3.getRsold() + ",");			
//		System.out.println("---------------------");
		
//		// 查詢
//		List<ReportVO> list = dao.getAll();
//		for (ReportVO aReport : list) {
//		System.out.print(aReport.getRno() + ",");
//		System.out.print(aReport.getRm_p() + ",");
//		System.out.print(aReport.getRr_no() + ",");
//		System.out.print(aReport.getRm_byp() + ",");
//		System.out.print(aReport.getRtime() + ",");
//		System.out.print(aReport.getRcuz() + ",");
//		System.out.print(aReport.getRe_chk() + ",");
//		System.out.print(aReport.getRsol() + ",");
//		System.out.print(aReport.getRsolt() + ",");
//		System.out.print(aReport.getRsold() + ",");
//		System.out.println("");
//		}		
	}


}
