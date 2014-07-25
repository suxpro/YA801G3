package back.sosorder.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Employee;

public class SosorderJDBCDAO implements SosorderDAO_interface {

	String driver="oracle.jdbc.driver.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:orcl";
	String userid="renter";
	String password="renter";

	private static final String INSERT_STMT = 
		"INSERT INTO sosorder (sos_no, sos_mno, sos_name, sos_desc, sos_pay, sos_days, sos_onsd, sos_ofsd, sos_pic, sos_format) VALUES (sosorder_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT sos_no, sos_mno, sos_name, sos_desc, sos_pay, sos_days, sos_onsd, sos_ofsd, sos_pic, sos_format FROM sosorder order by sos_no";
	private static final String GET_ONE_STMT = 
		"SELECT sos_no, sos_mno, sos_name, sos_desc, sos_pay, sos_days, sos_onsd, sos_ofsd, sos_pic, sos_format FROM sosorder where sos_no = ?";
	private static final String DELETE = 
		"DELETE FROM sosorder where sos_no = ?";
	private static final String UPDATE = 
		"UPDATE sosorder set sos_mno=?, sos_name=?, sos_desc=?, sos_pay=?, sos_days=?, sos_onsd=?, sos_ofsd=?, sos_pic=?, sos_format=? where sos_no = ?";
	
	@Override
	public void insert(SosorderVO sosorderVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);
			
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, sosorderVO.getSos_mno());
			pstmt.setString(2, sosorderVO.getSos_name());
			pstmt.setString(3, sosorderVO.getSos_desc());
			pstmt.setInt(4, sosorderVO.getSos_pay());
			pstmt.setInt(5, sosorderVO.getSos_days());
			pstmt.setTimestamp(6, sosorderVO.getSos_onsd());
			pstmt.setTimestamp(7, sosorderVO.getSos_ofsd());
			pstmt.setBytes(8, sosorderVO.getSos_pic());
			pstmt.setString(9, sosorderVO.getSos_format());

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
	public void update(SosorderVO sosorderVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);
			
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, sosorderVO.getSos_mno());
			pstmt.setString(2, sosorderVO.getSos_name());
			pstmt.setString(3, sosorderVO.getSos_desc());
			pstmt.setInt(4, sosorderVO.getSos_pay());
			pstmt.setInt(5, sosorderVO.getSos_days());
			pstmt.setTimestamp(6, sosorderVO.getSos_onsd());
			pstmt.setTimestamp(7, sosorderVO.getSos_ofsd());
			pstmt.setBytes(8, sosorderVO.getSos_pic());
			pstmt.setString(9, sosorderVO.getSos_format());
			pstmt.setString(10, sosorderVO.getSos_no());

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
	public void delete(String sos_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);
			
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, sos_no);

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
	public SosorderVO findByPrimaryKey(String sos_no) {

		SosorderVO sosorderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);
			
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, sos_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// sosorderVO 也稱為 Domain objects
				sosorderVO = new SosorderVO();
				sosorderVO.setSos_no(rs.getString("sos_no"));
				sosorderVO.setSos_mno(rs.getString("sos_mno"));
				sosorderVO.setSos_name(rs.getString("sos_name"));
				sosorderVO.setSos_desc(rs.getString("sos_desc"));
				sosorderVO.setSos_pay(rs.getInt("sos_pay"));
				sosorderVO.setSos_days(rs.getInt("sos_days"));
				sosorderVO.setSos_onsd(rs.getTimestamp("sos_onsd"));
				sosorderVO.setSos_ofsd(rs.getTimestamp("sos_ofsd"));
				sosorderVO.setSos_pic(rs.getBytes("sos_pic"));
				sosorderVO.setSos_format(rs.getString("sos_format"));
				
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
		return sosorderVO;
	}

	@Override
	public List<SosorderVO> getAll() {
		List<SosorderVO> list = new ArrayList<SosorderVO>();
		SosorderVO sosorderVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);
			
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// sosorderVO 也稱為 Domain objects
				sosorderVO = new SosorderVO();
				sosorderVO.setSos_no(rs.getString("sos_no"));
				sosorderVO.setSos_mno(rs.getString("sos_mno"));
				sosorderVO.setSos_name(rs.getString("sos_name"));
				sosorderVO.setSos_desc(rs.getString("sos_desc"));
				sosorderVO.setSos_pay(rs.getInt("sos_pay"));
				sosorderVO.setSos_days(rs.getInt("sos_days"));
				sosorderVO.setSos_onsd(rs.getTimestamp("sos_onsd"));
				sosorderVO.setSos_ofsd(rs.getTimestamp("sos_ofsd"));
				sosorderVO.setSos_pic(rs.getBytes("sos_pic"));
				sosorderVO.setSos_format(rs.getString("sos_format"));
				list.add(sosorderVO); // Store the row in the vector
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
	public List<SosorderVO> getAll(Map<String, String[]> map) {
		List<SosorderVO> list = new ArrayList<SosorderVO>();
		SosorderVO sosorderVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			
			Class.forName(driver);
			con=DriverManager.getConnection(url,userid,password);
			
			String finalSQL = "select * from Employee "
		          + jdbcUtil_CompositeQuery_Employee.get_WhereCondition(map)
		          + "order by sos_no";
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("●●finalSQL(by DAO) = "+finalSQL);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				sosorderVO = new SosorderVO();
				sosorderVO.setSos_no(rs.getString("sos_no"));
				sosorderVO.setSos_mno(rs.getString("sos_mno"));
				sosorderVO.setSos_name(rs.getString("sos_name"));
				sosorderVO.setSos_desc(rs.getString("sos_desc"));
				sosorderVO.setSos_pay(rs.getInt("sos_pay"));
				sosorderVO.setSos_days(rs.getInt("sos_days"));
				sosorderVO.setSos_onsd(rs.getTimestamp("sos_onsd"));
				sosorderVO.setSos_ofsd(rs.getTimestamp("sos_ofsd"));
				sosorderVO.setSos_pic(rs.getBytes("sos_pic"));
				sosorderVO.setSos_format(rs.getString("sos_format"));
				list.add(sosorderVO); // Store the row in the List
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
		
		SosorderJDBCDAO dao=new SosorderJDBCDAO();

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
		
		List<SosorderVO>list=dao.getAll();
		for(SosorderVO sos:list){

			System.out.print(sos.getSos_no() + ",");
			System.out.print(sos.getSos_mno() + ",");
			System.out.print(sos.getSos_name() + ",");
			System.out.print(sos.getSos_desc() + ",");
			System.out.print(sos.getSos_pay() + ",");
			System.out.print(sos.getSos_days() + ",");
			System.out.print(sos.getSos_onsd() + ",");
			System.out.print(sos.getSos_ofsd() + ",");
			System.out.print(sos.getSos_pic() + ",");
			System.out.print(sos.getSos_format() + "\n");
		}
		
	}
	
}