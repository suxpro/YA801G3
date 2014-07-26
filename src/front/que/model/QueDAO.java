package front.que.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import back.tag.model.TagJDBCDAO;
import back.tag.model.TagVO;

public class QueDAO implements QueDAO_interface {
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/renterDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO que (que_no, rent_no, que_mem, que_sta, que_time, que_desc, ans_time, ans_desc)"
			+ " VALUES ('Q'||TO_CHAR(QUE_SEQ.NEXTVAL), ?, ?, ?, ?, ?, null, null)";
	private static final String UPDATE_STMT = "UPDATE que set rent_no= ?,que_mem= ?,que_sta= ?,que_time= ?,que_desc= ?,ans_time= ?,ans_desc= ? WHERE que_no = ? ";
	// private static final String UPDATE_STMT =
	// "UPDATE que set rent_no= ?, que_mem= ?, que_sta= ?, que_time= ?, que_desc= ?, ans_time= ?, ans_desc= ? where que_no = ? ";
	private static final String DELETE_STMT = "UPDATE que set que_sta= 'CC_ASK' WHERE que_no = ?";
	//private static final String DELETE_STMT = "DELETE FROM que WHERE que_no = ?";
	private static final String GET_ALL_STMT = "SELECT que_no, rent_no, que_mem, que_sta, que_time, que_desc, ans_time, ans_desc FROM que WHERE que_sta <> 'CC_ASK' ORDER BY que_no";
	private static final String GET_ONE_STMT = "SELECT que_no, rent_no, que_mem, que_sta, que_time, que_desc, ans_time, ans_desc FROM que WHERE que_no = ?";

	@Override
	public void insert(QueVO queVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			// rent_no, que_mem, que_sta, que_time, que_desc, ans_time, ans_desc
			pstmt.setString(1, queVO.getRent_no());
			pstmt.setString(2, queVO.getQue_mem());
			pstmt.setString(3, queVO.getQue_sta());
			pstmt.setTimestamp(4, queVO.getQue_time());
			pstmt.setString(5, queVO.getQue_desc());
			//pstmt.setTimestamp(6, queVO.getAns_time());
			//pstmt.setString(7, queVO.getAns_desc());
			
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
	public void update(QueVO queVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);
		

			pstmt.setString(1, queVO.getRent_no());
			pstmt.setString(2, queVO.getQue_mem());
			pstmt.setString(3, queVO.getQue_sta());
			pstmt.setTimestamp(4, queVO.getQue_time());
			pstmt.setString(5, queVO.getQue_desc());
			pstmt.setTimestamp(6, queVO.getAns_time());
			pstmt.setString(7, queVO.getAns_desc());
			pstmt.setString(8, queVO.getQue_no());
			
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
	public void delete(String que_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_STMT);

			pstmt.setString(1, que_no);

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
	public QueVO findByPrimaryKey(String que_no) {

		QueVO queVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, que_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// que_no, rent_no, que_mem, que_sta, que_time, que_desc,
				// ans_time, ans_desc
				queVO = new QueVO();
				queVO.setQue_no(rs.getString("que_no"));
				queVO.setRent_no(rs.getString("rent_no"));
				queVO.setQue_mem(rs.getString("que_mem"));
				queVO.setQue_sta(rs.getString("que_sta"));
				queVO.setQue_time(rs.getTimestamp("que_time"));
				queVO.setQue_desc(rs.getString("que_desc"));
				queVO.setAns_time(rs.getTimestamp("ans_time"));
				queVO.setAns_desc(rs.getString("ans_desc"));
                
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
		return queVO;
	}	

	@Override
	public List<QueVO> getAll() {
		List<QueVO> list = new ArrayList<QueVO>();
		QueVO queVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// que_no, rent_no, que_mem, que_sta, que_time, que_desc,
				// ans_time, ans_desc
				queVO = new QueVO();
				queVO.setQue_no(rs.getString("que_no"));
				queVO.setRent_no(rs.getString("rent_no"));
				queVO.setQue_mem(rs.getString("que_mem"));
				queVO.setQue_sta(rs.getString("que_sta"));
				queVO.setQue_time(rs.getTimestamp("que_time"));
				queVO.setQue_desc(rs.getString("que_desc"));
				queVO.setAns_time(rs.getTimestamp("ans_time"));
				queVO.setAns_desc(rs.getString("ans_desc"));
				
				list.add(queVO);
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

/*	
	public static void main(String argv[]) {
		List<QueVO> queList = new ArrayList<QueVO>();

		QueDAO queDAO = new QueDAO();
		QueVO queVO = new QueVO();

		queVO.setQue_no("Q10015");

		// tag.setTag_desc("�䥦");

		try {
			// queDAO.insert(queVO);
			// tagDAO.update(queVO);
			// tagDAO.delete(queVO.getTag_no());
			//queVO = queDAO.findByPrimaryKey(queVO.getQue_no());
			 queList = queDAO.getAll();
			// que = queDAO.findTag(que.getQue_no());

//			System.out.print("Que_no: " + queVO.getQue_no() + ", Rent_no: " + queVO.getRent_no() + 
//					         ", Que_mem: " + queVO.getQue_mem() + ", Que_sta: " + queVO.getQue_sta() +
//					         ", Que_time: " + queVO.getQue_time() + ", Que_desc: " + queVO.getQue_desc() + 
//					         ", Ans_time: " + queVO.getAns_time() + ", Ans_desc: " + queVO.getAns_desc() + "\n");

			
			 for(QueVO queVO1 : queList){
					System.out.print("Que_no: " + queVO1.getQue_no() + ", Rent_no: " + queVO1.getRent_no() + 
					         ", Que_mem: " + queVO1.getQue_mem() + ", Que_sta: " + queVO1.getQue_sta() +
					         ", Que_time: " + queVO1.getQue_time() + ", Que_desc: " + queVO1.getQue_desc() + 
					         ", Ans_time: " + queVO1.getAns_time() + ", Ans_desc: " + queVO1.getAns_desc() + "\n");
			 }
			

		} catch (Exception ex) {
			System.err.println("Exception: " + ex.getMessage());
		}
	}
*/
}