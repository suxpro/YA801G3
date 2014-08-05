package back.employee.model;

import java.util.*;
import java.sql.*;
import java.sql.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Employee;

public class EmployeeJDBCDAO implements EmployeeDAO_interface {

	String driver="oracle.jdbc.driver.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:orcl";
	String userid="renter";
	String password="renter";
	
	private static final String INSERT_STMT = 
		"INSERT INTO employee (emp_no, emp_id, emp_pwd, emp_name, emp_sex, emp_tel, emp_cell, emp_mail, emp_addr, emp_job, emp_sal, emp_tod, emp_lod, emp_ecp, emp_ecell, emp_pic, emp_format) VALUES ('E'||TO_CHAR(employee_seq.NEXTVAL), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT emp_no, emp_id, emp_pwd, emp_name, emp_sex, emp_tel, emp_cell, emp_mail, emp_addr, emp_job, emp_sal, to_char(emp_tod,'yyyy-mm-dd') emp_tod, to_char(emp_lod,'yyyy-mm-dd') emp_lod, emp_ecp, emp_ecell, emp_pic, emp_format FROM employee order by emp_no";
	private static final String GET_ONE_STMT = 
		"SELECT emp_no, emp_id, emp_pwd, emp_name, emp_sex, emp_tel, emp_cell, emp_mail, emp_addr, emp_job, emp_sal, to_char(emp_tod,'yyyy-mm-dd') emp_tod, to_char(emp_lod,'yyyy-mm-dd') emp_lod, emp_ecp, emp_ecell, emp_pic, emp_format FROM employee where emp_no = ?";
	private static final String DELETE = 
		"DELETE FROM employee where emp_no = ?";
	private static final String UPDATE = 
		"UPDATE employee set emp_id=?, emp_pwd=?, emp_name=?, emp_sex=?, emp_tel=?, emp_cell=?, emp_mail=?, emp_addr=?, emp_job=?, emp_sal=?, emp_tod=?, emp_lod=?, emp_ecp=?, emp_ecell=?, emp_pic=?, emp_format=? where emp_no = ?";
	private static final String GET_PWD_STMT = 
			"SELECT emp_pwd FROM employee where emp_id = ?";
	
	@Override
	public void insert(EmployeeVO EmployeeVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);

			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, EmployeeVO.getEmp_id());
			pstmt.setString(2, EmployeeVO.getEmp_pwd());
			pstmt.setString(3, EmployeeVO.getEmp_name());
			pstmt.setString(4, EmployeeVO.getEmp_sex());
			pstmt.setString(5, EmployeeVO.getEmp_tel());
			pstmt.setString(6, EmployeeVO.getEmp_cell());
			pstmt.setString(7, EmployeeVO.getEmp_mail());
			pstmt.setString(8, EmployeeVO.getEmp_addr());
			pstmt.setString(9, EmployeeVO.getEmp_job());
			pstmt.setInt(10, EmployeeVO.getEmp_sal());
			pstmt.setDate(11, EmployeeVO.getEmp_tod());
			pstmt.setDate(12, EmployeeVO.getEmp_lod());
			pstmt.setString(13, EmployeeVO.getEmp_ecp());
			pstmt.setString(14, EmployeeVO.getEmp_ecell());
			pstmt.setBytes(15, EmployeeVO.getEmp_pic());
			pstmt.setString(16, EmployeeVO.getEmp_format());

			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	public void update(EmployeeVO EmployeeVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);

			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, EmployeeVO.getEmp_id());
			pstmt.setString(2, EmployeeVO.getEmp_pwd());
			pstmt.setString(3, EmployeeVO.getEmp_name());
			pstmt.setString(4, EmployeeVO.getEmp_sex());
			pstmt.setString(5, EmployeeVO.getEmp_tel());
			pstmt.setString(6, EmployeeVO.getEmp_cell());
			pstmt.setString(7, EmployeeVO.getEmp_mail());
			pstmt.setString(8, EmployeeVO.getEmp_addr());
			pstmt.setString(9, EmployeeVO.getEmp_job());
			pstmt.setInt(10, EmployeeVO.getEmp_sal());
			pstmt.setDate(11, EmployeeVO.getEmp_tod());
			pstmt.setDate(12, EmployeeVO.getEmp_lod());
			pstmt.setString(13, EmployeeVO.getEmp_ecp());
			pstmt.setString(14, EmployeeVO.getEmp_ecell());
			pstmt.setBytes(15, EmployeeVO.getEmp_pic());
			pstmt.setString(16, EmployeeVO.getEmp_format());
			pstmt.setString(17, EmployeeVO.getEmp_no());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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

			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);

			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, emp_no);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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

		EmployeeVO EmployeeVO = null;
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

				EmployeeVO = new EmployeeVO();
				EmployeeVO.setEmp_no(rs.getString("emp_no"));
				EmployeeVO.setEmp_id(rs.getString("emp_id"));
				EmployeeVO.setEmp_pwd(rs.getString("emp_pwd"));
				EmployeeVO.setEmp_name(rs.getString("emp_name"));
				EmployeeVO.setEmp_sex(rs.getString("emp_sex"));
				EmployeeVO.setEmp_tel(rs.getString("emp_tel"));
				EmployeeVO.setEmp_cell(rs.getString("emp_cell"));
				EmployeeVO.setEmp_mail(rs.getString("emp_mail"));
				EmployeeVO.setEmp_addr(rs.getString("emp_addr"));
				EmployeeVO.setEmp_job(rs.getString("emp_job"));
				EmployeeVO.setEmp_sal(rs.getInt("emp_sal"));
				EmployeeVO.setEmp_tod(rs.getDate("emp_tod"));
				EmployeeVO.setEmp_lod(rs.getDate("emp_lod"));
				EmployeeVO.setEmp_ecp(rs.getString("emp_ecp"));
				EmployeeVO.setEmp_ecell(rs.getString("emp_ecell"));
				EmployeeVO.setEmp_pic(rs.getBytes("emp_pic"));
				EmployeeVO.setEmp_format(rs.getString("emp_format"));
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		return EmployeeVO;
	}

	@Override
	public List<EmployeeVO> getAll() {
		List<EmployeeVO> list = new ArrayList<EmployeeVO>();
		EmployeeVO EmployeeVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);

			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				EmployeeVO = new EmployeeVO();
				EmployeeVO.setEmp_no(rs.getString("emp_no"));
				EmployeeVO.setEmp_id(rs.getString("emp_id"));
				EmployeeVO.setEmp_pwd(rs.getString("emp_pwd"));
				EmployeeVO.setEmp_name(rs.getString("emp_name"));
				EmployeeVO.setEmp_sex(rs.getString("emp_sex"));
				EmployeeVO.setEmp_tel(rs.getString("emp_tel"));
				EmployeeVO.setEmp_cell(rs.getString("emp_cell"));
				EmployeeVO.setEmp_mail(rs.getString("emp_mail"));
				EmployeeVO.setEmp_addr(rs.getString("emp_addr"));
				EmployeeVO.setEmp_job(rs.getString("emp_job"));
				EmployeeVO.setEmp_sal(rs.getInt("emp_sal"));
				EmployeeVO.setEmp_tod(rs.getDate("emp_tod"));
				EmployeeVO.setEmp_lod(rs.getDate("emp_lod"));
				EmployeeVO.setEmp_ecp(rs.getString("emp_ecp"));
				EmployeeVO.setEmp_ecell(rs.getString("emp_ecell"));
				EmployeeVO.setEmp_pic(rs.getBytes("emp_pic"));
				EmployeeVO.setEmp_format(rs.getString("emp_format"));
				list.add(EmployeeVO); // Store the row in the vector
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		EmployeeVO EmployeeVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			
			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);

			String finalSQL = "select * from Employee "
		          + jdbcUtil_CompositeQuery_Employee.get_WhereCondition(map)
		          + "order by emp_no";
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("●●finalSQL(by DAO) = "+finalSQL);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				EmployeeVO = new EmployeeVO();
				EmployeeVO.setEmp_no(rs.getString("emp_no"));
				EmployeeVO.setEmp_id(rs.getString("emp_id"));
				EmployeeVO.setEmp_pwd(rs.getString("emp_pwd"));
				EmployeeVO.setEmp_name(rs.getString("emp_name"));
				EmployeeVO.setEmp_sex(rs.getString("emp_sex"));
				EmployeeVO.setEmp_tel(rs.getString("emp_tel"));
				EmployeeVO.setEmp_cell(rs.getString("emp_cell"));
				EmployeeVO.setEmp_mail(rs.getString("emp_mail"));
				EmployeeVO.setEmp_addr(rs.getString("emp_addr"));
				EmployeeVO.setEmp_job(rs.getString("emp_job"));
				EmployeeVO.setEmp_sal(rs.getInt("emp_sal"));
				EmployeeVO.setEmp_tod(rs.getDate("emp_tod"));
				EmployeeVO.setEmp_lod(rs.getDate("emp_lod"));
				EmployeeVO.setEmp_ecp(rs.getString("emp_ecp"));
				EmployeeVO.setEmp_ecell(rs.getString("emp_ecell"));
				EmployeeVO.setEmp_pic(rs.getBytes("emp_pic"));
				EmployeeVO.setEmp_format(rs.getString("emp_format"));
				list.add(EmployeeVO); // Store the row in the List
			}
	
			// Handle any SQL errors
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	
	public static void main(String[] args){
		
		EmployeeJDBCDAO dao=new EmployeeJDBCDAO();

		//insert
//		EmployeeVO employeeVO=new EmployeeVO();
//		employeeVO.setEmp_no("");
//		employeeVO.setEmp_id("test");
//		employeeVO.setEmp_pwd("1111");
//		employeeVO.setEmp_name("海森堡先生");
//		employeeVO.setEmp_sex("M");
//		employeeVO.setEmp_tel("(03)6234985");
//		employeeVO.setEmp_cell("(09)58302947");
//		employeeVO.setEmp_mail("test@justrent.com");
//		employeeVO.setEmp_addr("123");
//		employeeVO.setEmp_job("test");
//		employeeVO.setEmp_sal(88888);
//		employeeVO.setEmp_tod(Date.valueOf("2014-01-01"));
//		employeeVO.setEmp_lod(Date.valueOf("2014-12-25"));
//		employeeVO.setEmp_ecp("A先生");
//		employeeVO.setEmp_ecell("(09)74235832");
//		employeeVO.setEmp_pic(null);
//		employeeVO.setEmp_format(null);
//		dao.insert(employeeVO);
		
		//update
//		EmployeeVO employeeVO=new EmployeeVO();
//		employeeVO=dao.findByPrimaryKey("E10006");
//		employeeVO.setEmp_no("E10006");
//		employeeVO.setEmp_name("QAQ");
//		employeeVO.setEmp_sal(66666);
//		employeeVO.setEmp_tod(Date.valueOf("2014-05-05"));
//		employeeVO.setEmp_lod(Date.valueOf("2014-07-25"));
//		dao.update(employeeVO);
//		System.out.println(employeeVO.getEmp_no());
//		System.out.println(employeeVO.getEmp_addr());
//		System.out.println(employeeVO.getEmp_mail());
//		System.out.println(employeeVO.getEmp_lod());
		
		//delete
//		dao.delete("E10007");
		
		//search
//		EmployeeVO employeeVO=dao.findByPrimaryKey("E10006");
//		System.out.println(employeeVO.getEmp_no());
//		System.out.println(employeeVO.getEmp_addr());
//		System.out.println(employeeVO.getEmp_mail());
//		System.out.println(employeeVO.getEmp_lod());
		
		List<EmployeeVO>list=dao.getAll();
		for(EmployeeVO emp:list){

			System.out.print(emp.getEmp_no() + ",");
			System.out.print(emp.getEmp_id() + ",");
			System.out.print(emp.getEmp_name() + ",");
			System.out.print(emp.getEmp_sex() + ",");
			System.out.print(emp.getEmp_tel() + ",");
			System.out.print(emp.getEmp_cell() + ",");
			System.out.print(emp.getEmp_mail() + ",");
			System.out.print(emp.getEmp_addr() + ",");
			System.out.print(emp.getEmp_job() + ",");
			System.out.print(emp.getEmp_sal() + ",");
			System.out.print(emp.getEmp_tod() + ",");
			System.out.print(emp.getEmp_tel() + ",");
			System.out.print(emp.getEmp_ecp() + ",");
			System.out.print(emp.getEmp_ecell() + ",");
			System.out.print(emp.getEmp_pic() + ",");
			System.out.print(emp.getEmp_format() + "\n");
		}
		
	}

	@Override
	public EmployeeVO findPwdByEmpId(String emp_id) {
		// TODO Auto-generated method stub
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);
			pstmt = con.prepareStatement(GET_PWD_STMT);

			pstmt.setString(1, emp_id);

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return (EmployeeVO)rs;
			} else {
				return null;
			}
//			return rs.getString("emp_pwd");
			
			// Handle any driver errors
		} catch (SQLException | ClassNotFoundException se) {
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
	}
}