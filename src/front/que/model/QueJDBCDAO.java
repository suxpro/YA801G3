package front.que.model;

import java.util.*;
import java.sql.*;

import back.tag.model.TagJDBCDAO;
import back.tag.model.TagVO;

public class QueJDBCDAO implements QueDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String userid = "user2";
	String passwd = "u222";

	private static final String INSERT_STMT = "INSERT INTO que (que_no, rent_no, que_mem, que_sta, que_time, que_desc, ans_time, ans_desc)"
			                                        + " VALUES ('Q'||TO_CHAR(QUE_SEQ.NEXTVAL), ?, ?, ?, ?, ?, ?, ?)";
			//old + " VALUES ('Q'||TO_CHAR(QUE_SEQ.NEXTVAL), ?, ?, ?, ?, ?, null, null)";
	private static final String UPDATE_STMT = "UPDATE que set rent_no= ?, que_mem= ?, que_sta= ?, que_time= ?, que_desc= ?, ans_time= ?, ans_desc= ? where que_no = ? ";
	private static final String DELETE_STMT = "DELETE FROM que where que_no = ?";
	private static final String GET_ONE_STMT = "SELECT que_no, rent_no, que_mem, que_sta, que_time, que_desc, ans_time, ans_desc FROM que where que_no = ?";
	private static final String GET_ALL_STMT = "SELECT que_no, rent_no, que_mem, que_sta, que_time, que_desc, ans_time, ans_desc FROM que order by que_no";
	

	@Override
	public void insert(QueVO queVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			// rent_no, que_mem, que_sta, que_time, que_desc, ans_time, ans_desc
			pstmt.setString(1, queVO.getRent_no());
			pstmt.setString(2, queVO.getQue_mem());
			pstmt.setString(3, queVO.getQue_sta());
			pstmt.setTimestamp(4, queVO.getQue_time());
			pstmt.setString(5, queVO.getQue_desc());
			pstmt.setTimestamp(6, queVO.getAns_time());
			pstmt.setString(7, queVO.getAns_desc());
			
            /* old
			// rent_no, que_mem, que_sta, que_time, que_desc
			pstmt.setString(1, queVO.getRent_no());
			pstmt.setString(2, queVO.getQue_mem());
			pstmt.setString(3, queVO.getQue_sta());
			pstmt.setTimestamp(4, queVO.getQue_time());
			pstmt.setString(5, queVO.getQue_desc());
			*/

			pstmt.executeUpdate();

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
	}

	@Override
	public void update(QueVO queVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_STMT);

			// rent_no, que_mem, que_sta, que_time, que_desc, ans_time, ans_desc, que_no
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
	}

	@Override
	public void delete(String que_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE_STMT);

			pstmt.setString(1, que_no);

			pstmt.executeUpdate();

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
	}

	@Override
	public QueVO findByPrimaryKey(String que_no) {

		QueVO queVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, que_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				queVO = new QueVO();
				// que_no, rent_no, que_mem, que_sta, que_time, que_desc, ans_time, ans_desc
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

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				queVO = new QueVO();
				// que_no, rent_no, que_mem, que_sta, que_time, que_desc, ans_time, ans_desc
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

	public static void main(String argv[]) {
		List<QueVO> queList = new ArrayList<QueVO>();
		QueJDBCDAO queDAO = new QueJDBCDAO();
		QueVO queVO = new QueVO();

		try {
						
			//queVO = queDAO.findByPrimaryKey(queVO.getQue_no());
			//queList = queDAO.getAll();
			
			queVO.setRent_no("R10001");
			queVO.setQue_mem("M10002");
			queVO.setQue_sta("IN_ASK");
			queVO.setQue_time(java.sql.Timestamp.valueOf("2014-8-3 00:00:01.0"));
			queVO.setQue_desc("好吃嗎?");
			queVO.setAns_time(java.sql.Timestamp.valueOf("2014-8-3 00:00:05.0"));
			queVO.setAns_desc("不好吃...");
			
			queVO.setQue_no("Q10008");
			
			queDAO.insert(queVO);
		    //queDAO.update(queVO);
			//queDAO.delete(queVO.getQue_no());
			
			// que = queDAO.findTag(que.getQue_no());
            
			//for(QueVO queVO : queList){
		    //System.out.print("--new que--------------------------\n");	
			//System.out.print("Que_no: " + queVO.getQue_no() + " Rent_no: " + queVO.getRent_no() + 
			//		        " Que_mem: " + queVO.getQue_mem() + " Que_sta: " + queVO.getQue_sta() +
			//		        " Que_time: " + queVO.getQue_time() + " Que_desc: " + queVO.getQue_desc() + 
			//		        " Ans_time: " + queVO.getAns_time() + " Ans_desc: " + queVO.getAns_desc() + "\n");
			//}

		} catch (Exception ex) {
			System.err.println("Exception: " + ex.getMessage());
		}
	}

}