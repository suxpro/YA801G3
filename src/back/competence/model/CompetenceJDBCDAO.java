package back.competence.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import back.employee.model.EmployeeVO;

public class CompetenceJDBCDAO implements CompetenceDAO_interface {

	String driver="oracle.jdbc.driver.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:orcl";
	String userid="renter";
	String password="renter";

	private static final String INSERT_STMT = "INSERT INTO competence (emp_no, func_no) VALUES (?, ?)";
	private static final String GET_ALL_STMT = "SELECT emp_no, func_no FROM competence";
	private static final String GET_ONE_STMT = "SELECT emp_no, func_no FROM competence where emp_no = ?";
	
	private static final String DELETE_ALL = "DELETE FROM competence where emp_no = ?";
	private static final String DELETE_ONE = "DELETE FROM competence where emp_no = ? AND func_no=?";
	
	private static final String UPDATE = "UPDATE competence set func_no=? where emp_no = ?";

	@Override
	public void insert(CompetenceVO competenceVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			
			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);

			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, competenceVO.getEmp_no());
			pstmt.setString(2, competenceVO.getFunc_no());

			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  catch (SQLException se) {
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
	public void update(CompetenceVO competenceVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			
			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);

			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, competenceVO.getFunc_no());
			pstmt.setString(2, competenceVO.getEmp_no());

			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  catch (SQLException se) {
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
	
    //刪除此員工所擁有的所有權限
	@Override
	public void delete(String emp_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);
			
			pstmt = con.prepareStatement(DELETE_ALL);

			pstmt.setString(1, emp_no);

			pstmt.executeUpdate();
			
			// Handle any SQL errors
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  catch (SQLException se) {
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

    //刪除此員工所擁有的單一權限
	@Override
	public void delete(String emp_no, String func_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);
			
			pstmt = con.prepareStatement(DELETE_ONE);

			pstmt.setString(1, emp_no);
			pstmt.setString(2, func_no);

			pstmt.executeUpdate();
			
			// Handle any SQL errors
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  catch (SQLException se) {
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
	public CompetenceVO findByPrimaryKey(String emp_no) {

		CompetenceVO competenceVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);
			
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, emp_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// competenceVO 也稱為 Domain objects
				competenceVO = new CompetenceVO();
				competenceVO.setEmp_no(rs.getString("emp_no"));
				competenceVO.setFunc_no(rs.getString("func_no"));
			}

			// Handle any SQL errors
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  catch (SQLException se) {
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
		return competenceVO;
	}

	@Override
	public List<CompetenceVO> getAll() {
		List<CompetenceVO> list = new ArrayList<CompetenceVO>();
		CompetenceVO competenceVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);
			
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				competenceVO = new CompetenceVO();
				competenceVO.setEmp_no(rs.getString("emp_no"));
				competenceVO.setFunc_no(rs.getString("func_no"));
				list.add(competenceVO); // Store the row in the list
			}

			// Handle any SQL errors
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  catch (SQLException se) {
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
	
}