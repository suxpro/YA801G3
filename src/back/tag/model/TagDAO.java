package back.tag.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class TagDAO implements TagDAO_interface {

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
	
	private static final String INSERT_STMT = 
			"INSERT INTO tag (tag_no,tag_desc) VALUES ('T'||TO_CHAR(TAG_SEQ.NEXTVAL), ?)";
	private static final String UPDATE_STMT = 
			"UPDATE tag SET tag_desc = ? where tag_no = ?";
	private static final String DELETE_STMT = 
			"DELETE FROM tag WHERE tag_no = ?";
	private static final String GET_ALL_STMT = 
			"SELECT tag_no,tag_desc FROM tag ORDER BY tag_no";
	private static final String GET_ONE_STMT = 
			"SELECT tag_no,tag_desc FROM tag WHERE tag_no = ?";
	//private static final String GET_ONE_STMT_BYDESC = "SELECT tag_no,tag_desc FROM tag where tag_desc = ?";

	@Override
	public void insert(TagVO tagVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, tagVO.getTag_desc());

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
	public void update(TagVO tagVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);
			
			pstmt.setString(1, tagVO.getTag_desc());
			pstmt.setString(2, tagVO.getTag_no());
			
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
	public void delete(String tag_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_STMT);

			pstmt.setString(1, tag_no);

			pstmt.executeUpdate();

			// Handle any driver errors
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
	public TagVO findByPrimaryKey(String tag_no) {

		TagVO tagVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, tag_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				tagVO = new TagVO();
				tagVO.setTag_no(rs.getString("tag_no"));
				tagVO.setTag_desc(rs.getString("tag_desc"));
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
		return tagVO;
	}	

	@Override
	public List<TagVO> getAll() {
		List<TagVO> list = new ArrayList<TagVO>();
		TagVO tagVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// TagVO 也稱為 Domain objects
				tagVO = new TagVO();
				tagVO.setTag_no(rs.getString("tag_no"));
				tagVO.setTag_desc(rs.getString("tag_desc"));
				list.add(tagVO);
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
    	List<TagVO> tagList = new ArrayList<TagVO>();
    	
    	TagDAO tagDAO = new TagDAO();
    	TagVO tag = new TagVO();  
    	//String tag_no;
    	
    	tag.setTag_no("T10001");
    	
    	//tag.setTag_desc("其它");

        try {
        	//tagDAO.insert(tag);
        	//tagDAO.update(tag);
            //tagDAO.delete(tag.getTag_no());
            tag = tagDAO.findByPrimaryKey(tag.getTag_no());
        	//tagList = tagDAO.getAll();
        	//tag = tagDAO.findTag(tag.getTag_no());
        	
        	System.out.print( "Tag_no: " + tag.getTag_no() + " Tag_desc: " + tag.getTag_desc() + "\n");
            
            
            //for(TagVO tagVO1 : tagList){
            //	System.out.print( "Tag_no: " + tagVO1.getTag_no() + " Tag_desc: " + tagVO1.getTag_desc() + "\n");
            //}
            

        }catch (Exception ex) {
            System.err.println("Exception: " + ex.getMessage());
        }
    }
 */

}