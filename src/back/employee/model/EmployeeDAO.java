package back.employee.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Employee;

public class EmployeeDAO implements EmployeeDAO_interface {

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

	private static final String INSERT_STMT = "INSERT INTO employee (emp_no, emp_id, emp_pwd, emp_name, emp_sex, emp_tel, emp_cell, emp_mail, emp_addr, emp_job, emp_sal, emp_tod, emp_lod, emp_ecp, emp_ecell, emp_pic, emp_format) VALUES ('E'||TO_CHAR(employee_seq.NEXTVAL), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT emp_no, emp_id, emp_pwd, emp_name, emp_sex, emp_tel, emp_cell, emp_mail, emp_addr, emp_job, emp_sal, to_char(emp_tod,'yyyy-mm-dd') emp_tod, to_char(emp_lod,'yyyy-mm-dd') emp_lod, emp_ecp, emp_ecell, emp_pic, emp_format FROM employee order by emp_no";
	private static final String GET_ONE_STMT = "SELECT emp_no, emp_id, emp_pwd, emp_name, emp_sex, emp_tel, emp_cell, emp_mail, emp_addr, emp_job, emp_sal, to_char(emp_tod,'yyyy-mm-dd') emp_tod, to_char(emp_lod,'yyyy-mm-dd') emp_lod, emp_ecp, emp_ecell, emp_pic, emp_format FROM employee where emp_no = ?";
	private static final String DELETE = "DELETE FROM employee where emp_no = ?";
	private static final String UPDATE = "UPDATE employee set emp_id=?, emp_pwd=?, emp_name=?, emp_sex=?, emp_tel=?, emp_cell=?, emp_mail=?, emp_addr=?, emp_job=?, emp_sal=?, emp_tod=?, emp_lod=?, emp_ecp=?, emp_ecell=?, emp_pic=?, emp_format=? where emp_no = ?";
	private static final String GET_ONE_STMT_ById = "SELECT emp_no, emp_id, emp_pwd, emp_name, emp_sex, emp_tel, emp_cell, emp_mail, emp_addr, emp_job, emp_sal, to_char(emp_tod,'yyyy-mm-dd') emp_tod, to_char(emp_lod,'yyyy-mm-dd') emp_lod, emp_ecp, emp_ecell, emp_pic, emp_format FROM employee where emp_id = ?";

	@Override
	public void insert(EmployeeVO employeeVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, employeeVO.getEmp_id());
			pstmt.setString(2, employeeVO.getEmp_pwd());
			pstmt.setString(3, employeeVO.getEmp_name());
			pstmt.setString(4, employeeVO.getEmp_sex());
			pstmt.setString(5, employeeVO.getEmp_tel());
			pstmt.setString(6, employeeVO.getEmp_cell());
			pstmt.setString(7, employeeVO.getEmp_mail());
			pstmt.setString(8, employeeVO.getEmp_addr());
			pstmt.setString(9, employeeVO.getEmp_job());
			pstmt.setInt(10, employeeVO.getEmp_sal());
			pstmt.setDate(11, employeeVO.getEmp_tod());
			pstmt.setDate(12, employeeVO.getEmp_lod());
			pstmt.setString(13, employeeVO.getEmp_ecp());
			pstmt.setString(14, employeeVO.getEmp_ecell());
			pstmt.setBytes(15, employeeVO.getEmp_pic());
			pstmt.setString(16, employeeVO.getEmp_format());

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
	public void update(EmployeeVO employeeVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, employeeVO.getEmp_id());
			pstmt.setString(2, employeeVO.getEmp_pwd());
			pstmt.setString(3, employeeVO.getEmp_name());
			pstmt.setString(4, employeeVO.getEmp_sex());
			pstmt.setString(5, employeeVO.getEmp_tel());
			pstmt.setString(6, employeeVO.getEmp_cell());
			pstmt.setString(7, employeeVO.getEmp_mail());
			pstmt.setString(8, employeeVO.getEmp_addr());
			pstmt.setString(9, employeeVO.getEmp_job());
			pstmt.setInt(10, employeeVO.getEmp_sal());
			pstmt.setDate(11, employeeVO.getEmp_tod());
			pstmt.setDate(12, employeeVO.getEmp_lod());
			pstmt.setString(13, employeeVO.getEmp_ecp());
			pstmt.setString(14, employeeVO.getEmp_ecell());
			pstmt.setBytes(15, employeeVO.getEmp_pic());
			pstmt.setString(16, employeeVO.getEmp_format());
			pstmt.setString(17, employeeVO.getEmp_no());

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
	public void delete(String emp_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, emp_no);

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
	public EmployeeVO findByPrimaryKey(String emp_no) {

		EmployeeVO employeeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, emp_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// EmployeeVo 也稱為 Domain objects
				employeeVO = new EmployeeVO();
				employeeVO.setEmp_no(rs.getString("emp_no"));
				employeeVO.setEmp_id(rs.getString("emp_id"));
				employeeVO.setEmp_pwd(rs.getString("emp_pwd"));
				employeeVO.setEmp_name(rs.getString("emp_name"));
				employeeVO.setEmp_sex(rs.getString("emp_sex"));
				employeeVO.setEmp_tel(rs.getString("emp_tel"));
				employeeVO.setEmp_cell(rs.getString("emp_cell"));
				employeeVO.setEmp_mail(rs.getString("emp_mail"));
				employeeVO.setEmp_addr(rs.getString("emp_addr"));
				employeeVO.setEmp_job(rs.getString("emp_job"));
				employeeVO.setEmp_sal(rs.getInt("emp_sal"));
				employeeVO.setEmp_tod(rs.getDate("emp_tod"));
				employeeVO.setEmp_lod(rs.getDate("emp_lod"));
				employeeVO.setEmp_ecp(rs.getString("emp_ecp"));
				employeeVO.setEmp_ecell(rs.getString("emp_ecell"));
				employeeVO.setEmp_pic(rs.getBytes("emp_pic"));
				employeeVO.setEmp_format(rs.getString("emp_format"));
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
		return employeeVO;
	}

	@Override
	public List<EmployeeVO> getAll() {
		List<EmployeeVO> list = new ArrayList<EmployeeVO>();
		EmployeeVO employeeVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// EmployeeVO 也稱為 Domain objects
				employeeVO = new EmployeeVO();
				employeeVO.setEmp_no(rs.getString("emp_no"));
				employeeVO.setEmp_id(rs.getString("emp_id"));
				employeeVO.setEmp_pwd(rs.getString("emp_pwd"));
				employeeVO.setEmp_name(rs.getString("emp_name"));
				employeeVO.setEmp_sex(rs.getString("emp_sex"));
				employeeVO.setEmp_tel(rs.getString("emp_tel"));
				employeeVO.setEmp_cell(rs.getString("emp_cell"));
				employeeVO.setEmp_mail(rs.getString("emp_mail"));
				employeeVO.setEmp_addr(rs.getString("emp_addr"));
				employeeVO.setEmp_job(rs.getString("emp_job"));
				employeeVO.setEmp_sal(rs.getInt("emp_sal"));
				employeeVO.setEmp_tod(rs.getDate("emp_tod"));
				employeeVO.setEmp_lod(rs.getDate("emp_lod"));
				employeeVO.setEmp_ecp(rs.getString("emp_ecp"));
				employeeVO.setEmp_ecell(rs.getString("emp_ecell"));
				employeeVO.setEmp_pic(rs.getBytes("emp_pic"));
				employeeVO.setEmp_format(rs.getString("emp_format"));
				list.add(employeeVO); // Store the row in the vector
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

	@Override
	public List<EmployeeVO> getAll(Map<String, String[]> map) {
		List<EmployeeVO> list = new ArrayList<EmployeeVO>();
		EmployeeVO employeeVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			String finalSQL = "select * from Employee "
					+ jdbcUtil_CompositeQuery_Employee.get_WhereCondition(map)
					+ "order by emp_no";
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("●●finalSQL(by DAO) = " + finalSQL);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				employeeVO = new EmployeeVO();
				employeeVO.setEmp_no(rs.getString("emp_no"));
				employeeVO.setEmp_id(rs.getString("emp_id"));
				employeeVO.setEmp_pwd(rs.getString("emp_pwd"));
				employeeVO.setEmp_name(rs.getString("emp_name"));
				employeeVO.setEmp_sex(rs.getString("emp_sex"));
				employeeVO.setEmp_tel(rs.getString("emp_tel"));
				employeeVO.setEmp_cell(rs.getString("emp_cell"));
				employeeVO.setEmp_mail(rs.getString("emp_mail"));
				employeeVO.setEmp_addr(rs.getString("emp_addr"));
				employeeVO.setEmp_job(rs.getString("emp_job"));
				employeeVO.setEmp_sal(rs.getInt("emp_sal"));
				employeeVO.setEmp_tod(rs.getDate("emp_tod"));
				employeeVO.setEmp_lod(rs.getDate("emp_lod"));
				employeeVO.setEmp_ecp(rs.getString("emp_ecp"));
				employeeVO.setEmp_ecell(rs.getString("emp_ecell"));
				employeeVO.setEmp_pic(rs.getBytes("emp_pic"));
				employeeVO.setEmp_format(rs.getString("emp_format"));
				list.add(employeeVO); // Store the row in the List
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
	public EmployeeVO findPwdByEmpId(String emp_id) {
		// TODO Auto-generated method stub
		EmployeeVO employeeVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT_ById);

			pstmt.setString(1, emp_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// EmployeeVo 也稱為 Domain objects
				employeeVO = new EmployeeVO();
				employeeVO.setEmp_no(rs.getString("emp_no"));
				employeeVO.setEmp_id(rs.getString("emp_id"));
				employeeVO.setEmp_pwd(rs.getString("emp_pwd"));
				employeeVO.setEmp_name(rs.getString("emp_name"));
				employeeVO.setEmp_sex(rs.getString("emp_sex"));
				employeeVO.setEmp_tel(rs.getString("emp_tel"));
				employeeVO.setEmp_cell(rs.getString("emp_cell"));
				employeeVO.setEmp_mail(rs.getString("emp_mail"));
				employeeVO.setEmp_addr(rs.getString("emp_addr"));
				employeeVO.setEmp_job(rs.getString("emp_job"));
				employeeVO.setEmp_sal(rs.getInt("emp_sal"));
				employeeVO.setEmp_tod(rs.getDate("emp_tod"));
				employeeVO.setEmp_lod(rs.getDate("emp_lod"));
				employeeVO.setEmp_ecp(rs.getString("emp_ecp"));
				employeeVO.setEmp_ecell(rs.getString("emp_ecell"));
				employeeVO.setEmp_pic(rs.getBytes("emp_pic"));
				employeeVO.setEmp_format(rs.getString("emp_format"));
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
		return employeeVO;
	}
}