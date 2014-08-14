package front.member.model;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import front.trade.model.*;

public class MemberDAO implements MemberDAO_interface {
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

	private static final String INSERT_STMT = "INSERT INTO member (mem_no, mem_id, mem_pwd, mem_pic, mem_name, mem_sex, mem_cell, mem_mail, loc_no, mem_adrs, mem_lev, mem_mbl, mem_ileg, mem_ases, mem_ver, mem_date, mem_pic_info, mem_vpic, mem_vpic_info) VALUES ('M'||TO_CHAR(member_seq.NEXTVAL), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT mem_no, mem_id, mem_pwd, mem_pic, mem_name, mem_sex, mem_cell, mem_mail, loc_no, mem_adrs, mem_lev, mem_mbl, mem_ileg, mem_ases, mem_ver, to_char(mem_date,'yyyy-mm-dd') mem_date, mem_pic_info, mem_vpic, mem_vpic_info FROM member order by mem_no";
	private static final String GET_ONE_STMT = "SELECT mem_no, mem_id, mem_pwd, mem_pic, mem_name, mem_sex, mem_cell, mem_mail, loc_no, mem_adrs, mem_lev, mem_mbl, mem_ileg, mem_ases, mem_ver, to_char(mem_date,'yyyy-mm-dd') mem_date, mem_pic_info, mem_vpic, mem_vpic_info FROM member where mem_no = ?";
	private static final String GET_IDPWD_STMT = "SELECT mem_no, mem_id, mem_pwd, mem_pic, mem_name, mem_sex, mem_cell, mem_mail, loc_no, mem_adrs, mem_lev, mem_mbl, mem_ileg, mem_ases, mem_ver, to_char(mem_date,'yyyy-mm-dd') mem_date, mem_pic_info, mem_vpic, mem_vpic_info FROM member where mem_id = ?";
	private static final String DELETE = "DELETE FROM member where mem_no = ?";
	private static final String UPDATE = "UPDATE member set mem_id=?, mem_pwd=?, mem_pic=?, mem_name=?, mem_sex=?, mem_cell=?, mem_mail=?, loc_no=?, mem_adrs=?, mem_lev=?, mem_mbl=?, mem_ileg=?, mem_ases=?, mem_ver=?, mem_date=?, mem_pic_info=?, mem_vpic=?, mem_vpic_info=? where mem_no = ?";
	private static final String UPDATE_INFO = "UPDATE member set mem_pwd=?, mem_pic=?, mem_name=?, mem_sex=?, mem_cell=?, mem_mail=?, loc_no=?, mem_adrs=?, mem_pic_info=?, mem_vpic=?, mem_vpic_info=? where mem_no = ?";
	private static final String UPDATE_VIP = "UPDATE member set mem_lev=? , mem_mbl=? where mem_no = ?";
	private static final String UPDATE_SUSPENDED = "UPDATE member set mem_lev=? where mem_no = ?";
	private static final String UPDATE_ASES = "UPDATE member set mem_ases=? where mem_no = ?";	
	private static final String STORED_MOMEY = "UPDATE member set mem_mbl=? where mem_no=?";
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.member.model.MemberDAO_interface#insert(com.member.model.MemberVO)
	 */
	@Override
	public MemberVO findByAccount(String mid) {

		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_IDPWD_STMT);

			pstmt.setString(1, mid);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// memberVo 也稱為 Domain objects
				memberVO = new MemberVO();
				memberVO.setMno(rs.getString("mem_no"));
				memberVO.setMid(rs.getString("mem_id"));
				memberVO.setMpwd(rs.getString("mem_pwd"));
				memberVO.setMpic(rs.getBytes("mem_pic"));
				memberVO.setMname(rs.getString("mem_name"));
				memberVO.setMsex(rs.getString("mem_sex"));
				memberVO.setMcell(rs.getString("mem_cell"));
				memberVO.setMmail(rs.getString("mem_mail"));
				memberVO.setLocno(rs.getString("loc_no"));
				memberVO.setMadrs(rs.getString("mem_adrs"));
				memberVO.setMlev(rs.getString("mem_lev"));
				memberVO.setMbalance(rs.getDouble("mem_mbl"));
				memberVO.setMillegal(rs.getInt("mem_ileg"));
				memberVO.setMassess(rs.getInt("mem_ases"));
				memberVO.setMverification(rs.getString("mem_ver"));
				memberVO.setMdate(rs.getDate("mem_date"));
				memberVO.setMpic_info(rs.getString("mem_pic_info"));
				memberVO.setMvpic(rs.getBytes("mem_vpic"));
				memberVO.setMvpic_info(rs.getString("mem_vpic_info"));

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
		return memberVO;
	}

	@Override
	public void insert(MemberVO memberVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			// pstmt.setString(1, memberVO.getMno());
			pstmt.setString(1, memberVO.getMid());
			pstmt.setString(2, memberVO.getMpwd());
			pstmt.setBytes(3, memberVO.getMpic());
			pstmt.setString(4, memberVO.getMname());
			pstmt.setString(5, memberVO.getMsex());
			pstmt.setString(6, memberVO.getMcell());
			pstmt.setString(7, memberVO.getMmail());
			pstmt.setString(8, memberVO.getLocno());
			pstmt.setString(9, memberVO.getMadrs());
			pstmt.setString(10, memberVO.getMlev());
			pstmt.setDouble(11, memberVO.getMbalance());
			pstmt.setInt(12, memberVO.getMillegal());
			pstmt.setInt(13, memberVO.getMassess());
			pstmt.setString(14, memberVO.getMverification());
//			pstmt.setDate(15, memberVO.getMdate());
			pstmt.setString(15, memberVO.getMpic_info());
			pstmt.setBytes(16, memberVO.getMvpic());
			pstmt.setString(17, memberVO.getMvpic_info());

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
	public void update(MemberVO memberVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, memberVO.getMid());
			pstmt.setString(2, memberVO.getMpwd());
			pstmt.setBytes(3, memberVO.getMpic());
			pstmt.setString(4, memberVO.getMname());
			pstmt.setString(5, memberVO.getMsex());
			pstmt.setString(6, memberVO.getMcell());
			pstmt.setString(7, memberVO.getMmail());
			pstmt.setString(8, memberVO.getLocno());
			pstmt.setString(9, memberVO.getMadrs());
			pstmt.setString(10, memberVO.getMlev());
			pstmt.setDouble(11, memberVO.getMbalance());
			pstmt.setInt(12, memberVO.getMillegal());
			pstmt.setInt(13, memberVO.getMassess());
			pstmt.setString(14, memberVO.getMverification());
			pstmt.setDate(15, memberVO.getMdate());			
			pstmt.setString(16, memberVO.getMpic_info());
			pstmt.setBytes(17, memberVO.getMvpic());
			pstmt.setString(18, memberVO.getMvpic_info());
			pstmt.setString(19, memberVO.getMno());

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
	public void updateInfo(MemberVO memberVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_INFO);
			
//			pstmt.setString(1, memberVO.getMid());
			pstmt.setString(1, memberVO.getMpwd());
			pstmt.setBytes(2, memberVO.getMpic());
			pstmt.setString(3, memberVO.getMname());
			pstmt.setString(4, memberVO.getMsex());
			pstmt.setString(5, memberVO.getMcell());
			pstmt.setString(6, memberVO.getMmail());
			pstmt.setString(7, memberVO.getLocno());
			pstmt.setString(8, memberVO.getMadrs());					
			pstmt.setString(9, memberVO.getMpic_info());
			pstmt.setBytes(10, memberVO.getMvpic());
			pstmt.setString(11, memberVO.getMvpic_info());
			pstmt.setString(12, memberVO.getMno());

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
	public void updateVIP(MemberVO memberVO , List<TradeVO> list) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			// 1●設定於 pstm.executeUpdate()之前
    		con.setAutoCommit(false);
    		
    		// 先新增部門
//    		String cols[] = {"MNO"};
			pstmt = con.prepareStatement(UPDATE_VIP);
			
			pstmt.setString(1, memberVO.getMlev());
			pstmt.setDouble(2, memberVO.getMbalance());
			pstmt.setString(3, memberVO.getMno());

			pstmt.executeUpdate();
			
			TradeDAO trade_dao = new TradeDAO();
			TradeVO tradeVO = list.get(0);
			trade_dao.insertWithVIP(tradeVO, con);
			
//			//掘取對應的自增主鍵值
//			String next_mno = null;
//			ResultSet rs = pstmt.getGeneratedKeys();
//			if (rs.next()) {
//				next_mno = rs.getString(1);
//				System.out.println("自增主鍵值= " + next_mno +"(剛新增成功的部門編號)");
//			} else {
//				System.out.println("未取得自增主鍵值");
//			}
//			rs.close();
//			
//			// 再同時新增員工
//			TradeDAO dao = new TradeDAO();
//			System.out.println("list.size()-A="+list.size());
//			for (TradeVO aTrade : list) {
//				aTrade.setMno(next_mno) ;
//				dao.insertWithVIP(aTrade, con);
//			}
//			
//			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
//			System.out.println("list.size()-B="+list.size());
//			System.out.println("新增部門編號" + next_mno + "時,共有員工" + list.size()+ "人同時被新增");


			// Handle any driver errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-member");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
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
	public void storedMoney(MemberVO memberVO , List<TradeVO> list) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			// 1●設定於 pstm.executeUpdate()之前
    		con.setAutoCommit(false);
    		
			pstmt = con.prepareStatement(STORED_MOMEY);
			
			pstmt.setDouble(1, memberVO.getMbalance());
			pstmt.setString(2, memberVO.getMno());

			pstmt.executeUpdate();
			
			TradeDAO trade_dao = new TradeDAO();
			TradeVO tradeVO = list.get(0);
			trade_dao.insertWithVIP(tradeVO, con);
			
			con.commit();
			con.setAutoCommit(true);

			// Handle any driver errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-member");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
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
	public void delete(String mno) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, mno);

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
	public MemberVO findByPrimaryKey(String mno) {

		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, mno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// memberVo 也稱為 Domain objects
				memberVO = new MemberVO();
				memberVO.setMno(rs.getString("mem_no"));
				memberVO.setMid(rs.getString("mem_id"));
				memberVO.setMpwd(rs.getString("mem_pwd"));
				memberVO.setMpic(rs.getBytes("mem_pic"));
				memberVO.setMname(rs.getString("mem_name"));
				memberVO.setMsex(rs.getString("mem_sex"));
				memberVO.setMcell(rs.getString("mem_cell"));
				memberVO.setMmail(rs.getString("mem_mail"));
				memberVO.setLocno(rs.getString("loc_no"));
				memberVO.setMadrs(rs.getString("mem_adrs"));
				memberVO.setMlev(rs.getString("mem_lev"));
				memberVO.setMbalance(rs.getDouble("mem_mbl"));
				memberVO.setMillegal(rs.getInt("mem_ileg"));
				memberVO.setMassess(rs.getInt("mem_ases"));
				memberVO.setMverification(rs.getString("mem_ver"));
				memberVO.setMdate(rs.getDate("mem_date"));
				memberVO.setMpic_info(rs.getString("mem_pic_info"));
				memberVO.setMvpic(rs.getBytes("mem_vpic"));
				memberVO.setMvpic_info(rs.getString("mem_vpic_info"));

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
		return memberVO;
	}

	@Override
	public List<MemberVO> getAll() {
		List<MemberVO> list = new ArrayList<MemberVO>();
		MemberVO memberVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// memberVo 也稱為 Domain objects
				memberVO = new MemberVO();
				memberVO.setMno(rs.getString("mem_no"));
				memberVO.setMid(rs.getString("mem_id"));
				memberVO.setMpwd(rs.getString("mem_pwd"));
				memberVO.setMpic(rs.getBytes("mem_pic"));
				memberVO.setMname(rs.getString("mem_name"));
				memberVO.setMsex(rs.getString("mem_sex"));
				memberVO.setMcell(rs.getString("mem_cell"));
				memberVO.setMmail(rs.getString("mem_mail"));
				memberVO.setLocno(rs.getString("loc_no"));
				memberVO.setMadrs(rs.getString("mem_adrs"));
				memberVO.setMlev(rs.getString("mem_lev"));
				memberVO.setMbalance(rs.getDouble("mem_mbl"));
				memberVO.setMillegal(rs.getInt("mem_ileg"));
				memberVO.setMassess(rs.getInt("mem_ases"));
				memberVO.setMverification(rs.getString("mem_ver"));
				memberVO.setMdate(rs.getDate("mem_date"));
				memberVO.setMpic_info(rs.getString("mem_pic_info"));
				memberVO.setMvpic(rs.getBytes("mem_vpic"));
				memberVO.setMvpic_info(rs.getString("mem_vpic_info"));
				list.add(memberVO);
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
	
    //會員停權 排程器 - by小豬
	//會員評價到300自動升級VIP
	//會員積分達到-10 停權 還是被檢舉超過10次成立就停權 停權是終身停權
	@Override
	public void updateTimer(MemberVO memberVO, String action) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_SUSPENDED);
			if("SUSPENDED".equals(action))
				pstmt.setString(1, "S");
			else if("VIP".equals(action))
				pstmt.setString(1, "V");
			pstmt.setString(2, memberVO.getMno());

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
	
	
	
	public static void main(String[] args) throws IOException {

//		MemberDAO dao = new MemberDAO();

		// File pic = new File("C:\\Users\\cuser\\Desktop\\CpuPJV6.jpg");
		// FileInputStream fins1 = new FileInputStream(pic);
		// int len1= fins1.available();
		// byte[] b1= new byte[len1];
		// fins1.read(b1);
		// fins1.close();
		
		 // 新增 自增值
//		 MemberVO memberVO1 = new MemberVO();
//		 memberVO1.setMlev("V");
//		 memberVO1.setMbalance(new Double(88888));
//		 
//			List<TradeVO> VIPList = new ArrayList<TradeVO>(); // 準備置入員工數人
//			TradeVO tradeVOxx = new TradeVO();   // 員工POJO1
//			tradeVOxx.setMno("M10005");
//			tradeVOxx.setTmid("1596258445612365");
//			tradeVOxx.setTstas("VIP點數支出");
//			tradeVOxx.setTfunds(new Double(3000));
//			tradeVOxx.setTin("Y");
//			
//			VIPList.add(tradeVOxx);
//			
//			dao.updateVIP(memberVO1 , VIPList);
		
		// // 新增
		// MemberVO memberVO1 = new MemberVO();
		// memberVO1.setMid("hahadamn");
		// memberVO1.setMpwd("11f1");
		// // memberVO1.setMpic(b1);
		// memberVO1.setMname("LEO");
		// memberVO1.setMsex("M");
		// memberVO1.setMcell("0925555123");
		// memberVO1.setMmail("higgoo@gmail.com");
		// memberVO1.setLocno("L10001");
		// memberVO1.setMadrs("桃園市信義區市府路45號");
		// memberVO1.setMlev("V");
		// memberVO1.setMbalance(new Double(88888));
		// memberVO1.setMillegal(new Integer(20));
		// memberVO1.setMassess(new Integer(200));
		// memberVO1.setMverification("Y");
		// memberVO1.setMdate(java.sql.Date.valueOf("2002-01-01"));
		// memberVO1.setMpic_info("png");
		// // memberVO1.setMvpic(b1);
		// memberVO1.setMvpic_info("png");
		// dao.insert(memberVO1);

//		  // 修改
//		 MemberVO memberVO2 = new MemberVO();
//		 memberVO2.setMno("M10001");
//		 memberVO2.setMid("BEETALK");
//		 memberVO2.setMpwd("Aa1211");
//		 // memberVO2.setMpic(b1);
//		 memberVO2.setMname("洨詹詹c333");
//		 memberVO2.setMsex("F");
//		 memberVO2.setMcell("0915952125");
//		 memberVO2.setMmail("david7966@gmail.com");
//		 memberVO2.setLocno("L10002");
//		 memberVO2.setMadrs("桃園市信義區市府路45號");
//		 memberVO2.setMlev("V");
//		 memberVO2.setMbalance(new Double(4588));
//		 memberVO2.setMassess(new Integer(232));
//		 memberVO2.setMverification("N");
//		 memberVO2.setMdate(java.sql.Date.valueOf("2012-07-02"));
//		 memberVO2.setMillegal(new Integer(12));
//		 memberVO2.setMpic_info("png");
//		 // memberVO2.setMvpic(b1);
//		 memberVO2.setMvpic_info("png");
//		 dao.update(memberVO2);
		
//		  // 個人修改
//		 MemberVO memberVO2 = new MemberVO();
//		 memberVO2.setMno("M10001");
//		 memberVO2.setMid("BEETALK");
//		 memberVO2.setMpwd("Aa1211");
//		 // memberVO2.setMpic(b1);
//		 memberVO2.setMname("洨詹詹c333");
//		 memberVO2.setMsex("F");
//		 memberVO2.setMcell("0915952125");
//		 memberVO2.setMmail("david7966@gmail.com");
//		 memberVO2.setLocno("L10002");
//		 memberVO2.setMadrs("桃園市信義區市府路45號");
//		 memberVO2.setMpic_info("png");
//		 // memberVO2.setMvpic(b1);
//		 memberVO2.setMvpic_info("png");
//		 dao.updateInfo(memberVO2);

		// // 刪除
		// dao.delete("M10004");

		// // 查詢
		// MemberVO memberVO3 = dao.findByPrimaryKey("M10005");
		// System.out.print(memberVO3.getMno() + ",");
		// System.out.print(memberVO3.getMid() + ",");
		// System.out.print(memberVO3.getMpwd() + ",");
		// System.out.print(memberVO3.getMpic() + ",");
		// System.out.print(memberVO3.getMname() + ",");
		// System.out.print(memberVO3.getMsex() + ",");
		// System.out.print(memberVO3.getMcell() + ",");
		// System.out.print(memberVO3.getMmail() + ",");
		// System.out.print(memberVO3.getLocno() + ",");
		// System.out.print(memberVO3.getMadrs() + ",");
		// System.out.print(memberVO3.getMlev() + ",");
		// System.out.print(memberVO3.getMaccount() + ",");
		// System.out.print(memberVO3.getMbalance() + ",");
		// System.out.print(memberVO3.getMillegal() + ",");
		// System.out.print(memberVO3.getMassess() + ",");
		// System.out.print(memberVO3.getMverification() + ",");
		// System.out.print(memberVO3.getMdate() + ",");
		// System.out.print(memberVO3.getMpic_info() + ",");
		// System.out.print(memberVO3.getMvpic() + ",");
		// System.out.println(memberVO3.getMvpic_info());
		// System.out.println("---------------------");

		// // 查詢
		// List<MemberVO> list = dao.getAll();
		// for (MemberVO aMember : list) {
		// System.out.print(aMember.getMno() + ",");
		// System.out.print(aMember.getMid() + ",");
		// System.out.print(aMember.getMpwd() + ",");
		// System.out.print(aMember.getMpic() + ",");
		// System.out.print(aMember.getMname() + ",");
		// System.out.print(aMember.getMsex() + ",");
		// System.out.print(aMember.getMcell() + ",");
		// System.out.print(aMember.getMmail() + ",");
		// System.out.print(aMember.getLocno() + ",");
		// System.out.print(aMember.getMadrs() + ",");
		// System.out.print(aMember.getMlev() + ",");
		// System.out.print(aMember.getMbalance() + ",");
		// System.out.print(aMember.getMillegal() + ",");
		// System.out.print(aMember.getMassess() + ",");
		// System.out.print(aMember.getMverification() + ",");
		// System.out.print(aMember.getMdate() + ",");
		// System.out.print(aMember.getMpic_info() + ",");
		// System.out.print(aMember.getMvpic() + ",");
		// System.out.println(aMember.getMvpic_info());
		//
		// System.out.println("");
		// }
	}

	@Override
	public void updateMem_mbl(MemberVO memberVO, Connection con) {

		PreparedStatement pstmt = null;
		try {   		
			pstmt = con.prepareStatement(STORED_MOMEY);
			pstmt.setDouble(1, memberVO.getMbalance());
			pstmt.setString(2, memberVO.getMno());
			pstmt.executeUpdate();
			
			// Handle any driver errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-member");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
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
		}		
	}

	@Override
	public void updateMem_ases(MemberVO memberVO, Connection con) {

		PreparedStatement pstmt = null;
		try {   		
			pstmt = con.prepareStatement(UPDATE_ASES);
			pstmt.setInt(1, memberVO.getMassess());
			pstmt.setString(2, memberVO.getMno());
			pstmt.executeUpdate();
			
			// Handle any driver errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-member");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
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
		}		
	}	
	
}
