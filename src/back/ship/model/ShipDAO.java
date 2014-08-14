package back.ship.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Ship;

public class ShipDAO {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/renterDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	public List<ShipVO> getAll(Map<String, String[]> map) {
		List<ShipVO> list = new ArrayList<ShipVO>();
		ShipVO shipVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			String finalSQL = "select * from ship "
					+ jdbcUtil_CompositeQuery_Ship.get_WhereCondition(map)
					+ "order by start_time";
			pstmt = con.prepareStatement(finalSQL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				shipVO = new ShipVO();
				shipVO.setOrd_no(rs.getString("ord_no"));
				shipVO.setRent_no(rs.getString("rent_no"));
				shipVO.setRent_name(rs.getString("rent_name"));
				shipVO.setTag_no(rs.getString("tag_no"));
				shipVO.setStart_time(rs.getTimestamp("start_time"));
				shipVO.setRec_mem(rs.getString("rec_mem"));
				shipVO.setRec_cell(rs.getString("rec_cell"));
				shipVO.setRec_loc(rs.getString("rec_loc"));
				shipVO.setRec_addr(rs.getString("rec_addr"));
				shipVO.setDest_mem(rs.getString("dest_mem"));
				shipVO.setDest_cell(rs.getString("dest_cell"));
				shipVO.setDest_loc(rs.getString("dest_loc"));
				shipVO.setDest_addr(rs.getString("dest_addr"));
				list.add(shipVO); // Store the row in the List
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
}