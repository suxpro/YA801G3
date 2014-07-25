package back.func.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import back.competence.model.CompetenceVO;

public class FuncDAO implements FuncDAO_interface {

	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO func (func_no, func_desc) VALUES (func_seq.NEXTVAL, ?)";
	private static final String GET_ALL_STMT = "SELECT func_no, func_desc FROM func";
	private static final String GET_ONE_STMT = "SELECT func_no, func_desc FROM func where func_no = ?";
	private static final String GET_COMPETENCE_ByFuncno_STMT = "SELECT emp_no,func_no FROM competence where func_no = ? order by emp_no";
	
	private static final String DELETE_COMPETENCE = "DELETE FROM competence where func_no = ?";
	private static final String DELETE_FUNC = "DELETE FROM func where func_no = ?";	
	
	private static final String UPDATE = "UPDATE func set func_desc=? where func_no = ?";

	@Override
	public void insert(FuncVO funcVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, funcVO.getFunc_desc());

			pstmt.executeUpdate();

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

	}

	@Override
	public void update(FuncVO funcVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, funcVO.getFunc_desc());
			pstmt.setString(2, funcVO.getFunc_no());

			pstmt.executeUpdate();

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

	}

	@Override
	public void delete(String func_no) {
		int updateCount_COMPETENCE = 0;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();

			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);

			// 先刪除員工
			pstmt = con.prepareStatement(DELETE_COMPETENCE);
			pstmt.setString(1, func_no);
			updateCount_COMPETENCE = pstmt.executeUpdate();
			// 再刪除部門
			pstmt = con.prepareStatement(DELETE_FUNC);
			pstmt.setString(1, func_no);
			pstmt.executeUpdate();

			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
			System.out.println("刪除權限編號" + func_no + "時,共有員工" + updateCount_COMPETENCE
					+ "人同時被刪除");
			
			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public FuncVO findByPrimaryKey(String func_no) {

		FuncVO funcVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, func_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// funcVO 也稱為 Domain objects
				funcVO = new FuncVO();
				funcVO.setFunc_no(rs.getString("func_no"));
				funcVO.setFunc_desc(rs.getString("func_desc"));
			}

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
		return funcVO;
	}

	@Override
	public List<FuncVO> getAll() {
		List<FuncVO> list = new ArrayList<FuncVO>();
		FuncVO funcVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				funcVO = new FuncVO();
				funcVO.setFunc_no(rs.getString("func_no"));
				funcVO.setFunc_desc(rs.getString("func_desc"));
				list.add(funcVO); // Store the row in the list
			}

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public Set<CompetenceVO> getCompetencesByFuncno(String func_no) {
		Set<CompetenceVO> set = new LinkedHashSet<CompetenceVO>();
		CompetenceVO competenceVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_COMPETENCE_ByFuncno_STMT);
			pstmt.setString(1, func_no);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				competenceVO = new CompetenceVO();
				competenceVO.setEmp_no(rs.getString("emp_no"));
				competenceVO.setFunc_no(rs.getString("func_no"));
				set.add(competenceVO); // Store the row in the vector
			}
	
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
}