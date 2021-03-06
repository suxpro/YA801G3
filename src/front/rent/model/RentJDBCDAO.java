package front.rent.model;

import java.util.*;
import java.io.File;
import java.io.FileInputStream;
import java.sql.*;

public class RentJDBCDAO implements RentDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String userid = "user2";
	String passwd = "u222";

	/*
	 * RENT_NO, RENT_NAME, RENT_DESC, LES_NO, RENT_STA, TAG_NO, RENT_DPS,
	 * UNIT_PRICE, RESET_DAYS, LOC_NO, RENT_ADDR, POP_FLAG, PRENT_FLAG,
	 * REPORT_FLAG, OFFSHELF_FLAG, LAST_STA_TIME, LAST_ONSHELF_TIME,
	 * LAST_MOD_TIME, PIC1, PIC1_FORMAT, PIC2, PIC2_FORMAT, PIC3, PIC3_FORMAT,
	 * PIC4, PIC4_FORMAT, PIC5, PIC5_FORMAT
	 */
 
	private static final String INSERT_STMT = "INSERT INTO rent (rent_no, rent_name, rent_desc, les_no, rent_sta, "
			+ "tag_no, rent_dps, unit_price, reset_days, loc_no, "
			+ "rent_addr, pop_flag, prent_flag, report_flag, offshelf_flag, "
			+ "last_sta_time, last_onshelf_time, last_mod_time, pic1, pic1_format, "
			+ "pic2, pic2_format, pic3, pic3_format, pic4, pic4_format, pic5, pic5_format) "
			+ " VALUES ('R'||TO_CHAR(RENT_SEQ.NEXTVAL),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	private static final String UPDATE_STMT = "UPDATE rent SET rent_name=?, rent_desc=?, les_no=?, rent_sta=?, "
			+ "tag_no=?, rent_dps=?, unit_price=?, reset_days=?, loc_no=?, "
			+ "rent_addr=?, pop_flag=?, prent_flag=?, report_flag=?, offshelf_flag=?, "
			+ "last_sta_time=?, last_onshelf_time=?, last_mod_time=?, pic1=?, pic1_format=?, "
			+ "pic2=?, pic2_format=?, pic3=?, pic3_format=?, pic4=?, pic4_format=?, pic5=?, pic5_format=? "
			+ "WHERE rent_no =? ";
	private static final String DELETE_STMT = "DELETE FROM rent where rent_no = ?";
	private static final String GET_ALL_STMT = "SELECT * FROM rent order by rent_no";
	private static final String GET_ONE_STMT = "SELECT * FROM rent where rent_no = ?";

	//小豬加
	private static final String GET_BODY_RENT_STMT = "SELECT * FROM rent WHERE offshelf_flag <> 'Y' AND rent_sta ='W_RENT','A_RENT' order by rent_no";

	@Override
	public void insert(RentVO rentVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, rentVO.getRent_name());
			pstmt.setString(2, rentVO.getRent_desc());
			pstmt.setString(3, rentVO.getLes_no());
			pstmt.setString(4, rentVO.getRent_sta());
			pstmt.setString(5, rentVO.getTag_no());

			pstmt.setInt(6, rentVO.getRent_dps());
			pstmt.setInt(7, rentVO.getUnit_price());
			pstmt.setInt(8, rentVO.getReset_days());
			pstmt.setString(9, rentVO.getLoc_no());
			pstmt.setString(10, rentVO.getRent_addr());

			pstmt.setString(11, rentVO.getPop_flag());
			pstmt.setString(12, rentVO.getPrent_flag());
			pstmt.setString(13, rentVO.getReport_flag());
			pstmt.setString(14, rentVO.getOffshelf_flag());
			pstmt.setTimestamp(15, rentVO.getLast_sta_time());

			pstmt.setTimestamp(16, rentVO.getLast_onshelf_time());
			pstmt.setTimestamp(17, rentVO.getLast_mod_time());
			pstmt.setBytes(18, rentVO.getPic1());
			pstmt.setString(19, rentVO.getPic1_format());
			pstmt.setBytes(20, rentVO.getPic2());

			pstmt.setString(21, rentVO.getPic2_format());
			pstmt.setBytes(22, rentVO.getPic3());
			pstmt.setString(23, rentVO.getPic3_format());
			pstmt.setBytes(24, rentVO.getPic4());
			pstmt.setString(25, rentVO.getPic4_format());

			pstmt.setBytes(26, rentVO.getPic5());
			pstmt.setString(27, rentVO.getPic5_format());

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
	public void update(RentVO rentVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, rentVO.getRent_name());
			pstmt.setString(2, rentVO.getRent_desc());
			pstmt.setString(3, rentVO.getLes_no());
			pstmt.setString(4, rentVO.getRent_sta());
			pstmt.setString(5, rentVO.getTag_no());

			pstmt.setInt(6, rentVO.getRent_dps());
			pstmt.setInt(7, rentVO.getUnit_price());
			pstmt.setInt(8, rentVO.getReset_days());
			pstmt.setString(9, rentVO.getLoc_no());
			pstmt.setString(10, rentVO.getRent_addr());

			pstmt.setString(11, rentVO.getPop_flag());
			pstmt.setString(12, rentVO.getPrent_flag());
			pstmt.setString(13, rentVO.getReport_flag());
			pstmt.setString(14, rentVO.getOffshelf_flag());
			pstmt.setTimestamp(15, rentVO.getLast_sta_time());

			pstmt.setTimestamp(16, rentVO.getLast_onshelf_time());
			pstmt.setTimestamp(17, rentVO.getLast_mod_time());
			pstmt.setBytes(18, rentVO.getPic1());
			pstmt.setString(19, rentVO.getPic1_format());
			pstmt.setBytes(20, rentVO.getPic2());

			pstmt.setString(21, rentVO.getPic2_format());
			pstmt.setBytes(22, rentVO.getPic3());
			pstmt.setString(23, rentVO.getPic3_format());
			pstmt.setBytes(24, rentVO.getPic4());
			pstmt.setString(25, rentVO.getPic4_format());

			pstmt.setBytes(26, rentVO.getPic5());
			pstmt.setString(27, rentVO.getPic5_format());
			pstmt.setString(28, rentVO.getRent_no());

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
	public void delete(String rent_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE_STMT);

			pstmt.setString(1, rent_no);

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
	public RentVO findByPrimaryKey(String rent_no) {

		RentVO rentVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, rent_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				rentVO = new RentVO();

				rentVO.setRent_no(rs.getString("rent_no"));
				rentVO.setRent_name(rs.getString("rent_name"));
				rentVO.setRent_desc(rs.getString("rent_desc"));
				rentVO.setLes_no(rs.getString("les_no"));
				rentVO.setRent_sta(rs.getString("rent_sta"));

				rentVO.setTag_no(rs.getString("Tag_no"));
				rentVO.setRent_dps(rs.getInt("rent_dps"));
				rentVO.setUnit_price(rs.getInt("unit_price"));
				rentVO.setReset_days(rs.getInt("reset_days"));
				rentVO.setLoc_no(rs.getString("loc_no"));

				rentVO.setRent_addr(rs.getString("rent_addr"));
				rentVO.setPop_flag(rs.getString("pop_flag"));
				rentVO.setPrent_flag(rs.getString("prent_flag"));
				rentVO.setReport_flag(rs.getString("report_flag"));
				rentVO.setOffshelf_flag(rs.getString("offshelf_flag"));

				rentVO.setLast_sta_time(rs.getTimestamp("last_sta_time"));
				rentVO.setLast_onshelf_time(rs
						.getTimestamp("last_onshelf_time"));
				rentVO.setLast_mod_time(rs.getTimestamp("last_mod_time"));
				rentVO.setPic1(rs.getBytes("pic1"));
				rentVO.setPic1_format(rs.getString("pic1_format"));

				rentVO.setPic2(rs.getBytes("pic2"));
				rentVO.setPic2_format(rs.getString("pic2_format"));
				rentVO.setPic3(rs.getBytes("pic3"));
				rentVO.setPic3_format(rs.getString("pic3_format"));
				rentVO.setPic4(rs.getBytes("pic4"));

				rentVO.setPic4_format(rs.getString("pic4_format"));
				rentVO.setPic5(rs.getBytes("pic5"));
				rentVO.setPic5_format(rs.getString("pic5_format"));

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
		return rentVO;
	}

	@Override
	public List<RentVO> getAll() {
		List<RentVO> list = new ArrayList<RentVO>();
		RentVO rentVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				rentVO = new RentVO();

				rentVO.setRent_no(rs.getString("rent_no"));
				rentVO.setRent_name(rs.getString("rent_name"));
				rentVO.setRent_desc(rs.getString("rent_desc"));
				rentVO.setLes_no(rs.getString("les_no"));
				rentVO.setRent_sta(rs.getString("rent_sta"));

				rentVO.setTag_no(rs.getString("Tag_no"));
				rentVO.setRent_dps(rs.getInt("rent_dps"));
				rentVO.setUnit_price(rs.getInt("unit_price"));
				rentVO.setReset_days(rs.getInt("reset_days"));
				rentVO.setLoc_no(rs.getString("loc_no"));

				rentVO.setRent_addr(rs.getString("rent_addr"));
				rentVO.setPop_flag(rs.getString("pop_flag"));
				rentVO.setPrent_flag(rs.getString("prent_flag"));
				rentVO.setReport_flag(rs.getString("report_flag"));
				rentVO.setOffshelf_flag(rs.getString("offshelf_flag"));

				rentVO.setLast_sta_time(rs.getTimestamp("last_sta_time"));
				rentVO.setLast_onshelf_time(rs
						.getTimestamp("last_onshelf_time"));
				rentVO.setLast_mod_time(rs.getTimestamp("last_mod_time"));
				rentVO.setPic1(rs.getBytes("pic1"));
				rentVO.setPic1_format(rs.getString("pic1_format"));

				rentVO.setPic2(rs.getBytes("pic2"));
				rentVO.setPic2_format(rs.getString("pic2_format"));
				rentVO.setPic3(rs.getBytes("pic3"));
				rentVO.setPic3_format(rs.getString("pic3_format"));
				rentVO.setPic4(rs.getBytes("pic4"));

				rentVO.setPic4_format(rs.getString("pic4_format"));
				rentVO.setPic5(rs.getBytes("pic5"));
				rentVO.setPic5_format(rs.getString("pic5_format"));

				list.add(rentVO);
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


	//小豬加,租物區只顯示待出租跟已出租
	@Override
	public List<RentVO> getBodyRent() {
		List<RentVO> list = new ArrayList<RentVO>();
		RentVO rentVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_BODY_RENT_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				rentVO = new RentVO();

				rentVO.setRent_no(rs.getString("rent_no"));
				rentVO.setRent_name(rs.getString("rent_name"));
				rentVO.setRent_desc(rs.getString("rent_desc"));
				rentVO.setLes_no(rs.getString("les_no"));
				rentVO.setRent_sta(rs.getString("rent_sta"));

				rentVO.setTag_no(rs.getString("Tag_no"));
				rentVO.setRent_dps(rs.getInt("rent_dps"));
				rentVO.setUnit_price(rs.getInt("unit_price"));
				rentVO.setReset_days(rs.getInt("reset_days"));
				rentVO.setLoc_no(rs.getString("loc_no"));

				rentVO.setRent_addr(rs.getString("rent_addr"));
				rentVO.setPop_flag(rs.getString("pop_flag"));
				rentVO.setPrent_flag(rs.getString("prent_flag"));
				rentVO.setReport_flag(rs.getString("report_flag"));
				rentVO.setOffshelf_flag(rs.getString("offshelf_flag"));

				rentVO.setLast_sta_time(rs.getTimestamp("last_sta_time"));
				rentVO.setLast_onshelf_time(rs
						.getTimestamp("last_onshelf_time"));
				rentVO.setLast_mod_time(rs.getTimestamp("last_mod_time"));
				rentVO.setPic1(rs.getBytes("pic1"));
				rentVO.setPic1_format(rs.getString("pic1_format"));

				rentVO.setPic2(rs.getBytes("pic2"));
				rentVO.setPic2_format(rs.getString("pic2_format"));
				rentVO.setPic3(rs.getBytes("pic3"));
				rentVO.setPic3_format(rs.getString("pic3_format"));
				rentVO.setPic4(rs.getBytes("pic4"));

				rentVO.setPic4_format(rs.getString("pic4_format"));
				rentVO.setPic5(rs.getBytes("pic5"));
				rentVO.setPic5_format(rs.getString("pic5_format"));

				list.add(rentVO);
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	
	public static void main(String argv[]) throws Exception {

		// List<RentVO> rentList = new ArrayList<RentVO>();
		RentJDBCDAO rentDAO = new RentJDBCDAO();
		RentVO rentVO = new RentVO();

		File f1 = new File("C:/images/1.jpg");
		FileInputStream fins1 = new FileInputStream(f1);
		int len1 = fins1.available();
		byte[] b1 = new byte[len1];
		fins1.read(b1);
		fins1.close();

		File f2 = new File("C:/images/2.jpg");
		FileInputStream fins2 = new FileInputStream(f2);
		int len2 = fins2.available();
		byte[] b2 = new byte[len2];
		fins2.read(b2);
		fins2.close();

		// rentVO.setRent_no("R10001");

		try {
			// rentVO = rentDAO.findByPrimaryKey(rentVO.getRent_no());
			// rentList = rentDAO.getAll();
            
			rentVO.setRent_no("R10006");
//			rentVO.setRent_name("超級電風扇");
//			rentVO.setRent_name("超級電風扇");
//			rentVO.setRent_desc("無堅不摧的電風扇");
//			rentVO.setLes_no("M10003");
//			rentVO.setRent_sta("W_RENT");
//			rentVO.setTag_no("T10001");
//			rentVO.setRent_dps(3000);
//			rentVO.setUnit_price(100);
//			rentVO.setReset_days(1);
//			rentVO.setLoc_no("L10005");
//			rentVO.setRent_addr("桃園縣中壢市中央路73號");
//			rentVO.setPop_flag("N");
//			rentVO.setPrent_flag("N");
//			rentVO.setReport_flag("N");
//			rentVO.setOffshelf_flag("N");
//			rentVO.setLast_sta_time(java.sql.Timestamp
//					.valueOf("2014-5-3 00:00:01.0"));
//			rentVO.setLast_onshelf_time(java.sql.Timestamp
//					.valueOf("2014-5-3 00:00:02.0"));
//			rentVO.setLast_mod_time(java.sql.Timestamp
//					.valueOf("2014-5-3 00:00:03.0"));
//			rentVO.setPic1(b1);
//			rentVO.setPic1_format("jpg");
//			rentVO.setPic2(b2);
//			rentVO.setPic2_format("jpg");
			
			/*
			 * rentVO.setPic3(null) ; rentVO.setPic3_format(null) ;
			 * rentVO.setPic4(null) ; rentVO.setPic4_format(null) ;
			 * rentVO.setPic5(null) ; rentVO.setPic5_format(null) ;
			 */

			//rentDAO.insert(rentVO);
			//rentDAO.update(rentVO);
			rentDAO.delete(rentVO.getRent_no());

			// que = queDAO.findTag(que.getQue_no());

			/*
			 * for(RentVO rentVO : rentList){
			 * System.out.print("--new rent-------------------------------------\n"
			 * ); System.out.print("1 : " + rentVO.getRent_no() + " \n" + "2 : "
			 * + rentVO.getRent_name() + " \n" + "3 : " + rentVO.getRent_desc()
			 * + " \n" + "4 : " + rentVO.getLes_no() + " \n" + "5 : " +
			 * rentVO.getRent_sta() + " \n" + "6 : " + rentVO.getTag_no() +
			 * " \n" + "7 : " + rentVO.getRent_dps() + " \n" + "8 : " +
			 * rentVO.getUnit_price() + " \n" + "9 : " + rentVO.getReset_days()
			 * + " \n" + "10: " + rentVO.getLoc_no() + " \n" + "11: " +
			 * rentVO.getRent_addr() + " \n" + "12: " + rentVO.getPop_flag() +
			 * " \n" + "13: " + rentVO.getPrent_flag() + " \n" + "14: " +
			 * rentVO.getReport_flag() + " \n" + "15: " +
			 * rentVO.getOffshelf_flag() + " \n" + "16: " +
			 * rentVO.getLast_sta_time() + " \n" + "17: " +
			 * rentVO.getLast_onshelf_time() + " \n" + "18: " +
			 * rentVO.getLast_mod_time() + " \n" + "19: " + rentVO.getPic1() +
			 * " \n" + "20: " + rentVO.getPic1_format() + " \n" + "21: " +
			 * rentVO.getPic2() + " \n" + "22: " + rentVO.getPic2_format() +
			 * " \n" + "23: " + rentVO.getPic3() + " \n" + "24: " +
			 * rentVO.getPic3_format() + " \n" + "25: " + rentVO.getPic4() +
			 * " \n" + "26: " + rentVO.getPic4_format() + " \n" + "27: " +
			 * rentVO.getPic5() + " \n" + "28: " + rentVO.getPic5_format() +
			 * " \n"); }
			 */

		} catch (Exception ex) {
			System.err.println("Exception: " + ex.getMessage());
		}
	}

	@Override
	public void updateRent_sta(RentVO rentVO, Connection con) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<RentVO> getAllByMno(String mno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public RentVO findByPrimaryKey2(String rent_no) {
		// TODO Auto-generated method stub
		return null;
	}



}