package kr.co.mycom.asset;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import kr.co.mycom.obstacle.ObstacleDTO;

public class AssetDAO {
	public Connection getCon() {
		Connection con = null;
		Context initContext = null;
		DataSource ds = null;

		try {
			initContext = new InitialContext();
			ds = (DataSource) initContext.lookup("java:comp/env/jdbc/s-lite");
			con = ds.getConnection();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	} // getCon

	public boolean insertAsset(AssetDTO dto) throws UnsupportedEncodingException { // 저장 성공시 true 실패시 false (이걸		

		boolean ok = false;
		String sql = "INSERT INTO assets (a_gnum, a_anum, a_company, a_place, a_dept, a_locate, a_id, a_name, a_getdate, " +
				"a_adddate, a_code1, a_code2, a_code3, a_aname, a_amodel, a_vendorname, a_bigo, a_spec, a_attachment, a_enable) " +
				"VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";	// TOOL

		String sql_anum = "SELECT a_anum FROM assets WHERE `a_anum` LIKE 'A%' ORDER BY `a_anum` DESC;";

		Connection con = null;
		PreparedStatement ps = null; // 준비된 명령 무엇이? 위에 ??들을 채우겠다.
		ResultSet rs = null;
		String confirm_anum = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql_anum);
			rs = ps.executeQuery();
			if (rs.next()) { // 결과가 있으면
				confirm_anum = rs.getString("a_anum");
				String[] split_anum = confirm_anum.split("_");
				int temp = Integer.parseInt(split_anum[1]);
				temp++;
				confirm_anum = "A_"+ String.format("%07d", temp);
			}else{
				confirm_anum = "A_0000001";
			}
				
			
			ps = con.prepareStatement(sql);
			
			// ?에 값들을 채운다.
			ps.setString(1, "LDCC");
			ps.setString(2, confirm_anum);
			ps.setString(3, dto.getA_company());
			ps.setString(4, dto.getA_place());
			ps.setString(5, dto.getA_dept());
			ps.setString(6, dto.getA_locate());
			ps.setString(7, dto.getA_id());
			ps.setString(8, dto.getA_name());
			ps.setString(9, dto.getA_getdate());
			ps.setString(10, dto.getA_adddate());
			ps.setString(11, dto.getA_code1());
			ps.setString(12, dto.getA_code2());
			ps.setString(13, dto.getA_code3());
			ps.setString(14, dto.getA_aname());
			ps.setString(15, dto.getA_amodel());
			ps.setString(16, dto.getA_vendorname());
			ps.setString(17, dto.getA_bigo());
			ps.setString(18, dto.getA_spec());
			ps.setString(19, dto.getA_attachment());
			ps.setString(20, "1");
			
			int cnt = ps.executeUpdate(); // insert, update, delete, select :
			// executeQuery() 메소드 사용
			if (cnt == 1)
				ok = true; // executeUpdate 가 성공하면 1을 반환한다.
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return ok; // 성공하면 true, 실패하면 false 리턴
	}
	

	public List<AssetDTO> search_mcode1() {
		List<AssetDTO> lists = new ArrayList<AssetDTO>();

		String sql = "select * from m_code1 ";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while(rs.next()) { // 결과가 있으면
				AssetDTO dto = new AssetDTO();
				
				dto.setM_code1(rs.getString("m_code1"));
				dto.setM_name(rs.getString("m_name"));
				dto.setM_enable(rs.getString("m_enable"));
			
				lists.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}

	public List<AssetDTO> search_mcode2() {
		List<AssetDTO> lists = new ArrayList<AssetDTO>();

		String sql = "select * from m_code2";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while(rs.next()) { // 결과가 있으면
				AssetDTO dto = new AssetDTO();
				
				dto.setM_code1(rs.getString("m_code1"));
				dto.setM_code2(rs.getString("m_code2"));
				dto.setM_name(rs.getString("m_name"));
				dto.setM_enable(rs.getString("m_enable"));
			
				lists.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}
	
	public List<AssetDTO> search_mcode3() {
		List<AssetDTO> lists = new ArrayList<AssetDTO>();

		String sql = "select * from m_code3 ";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while(rs.next()) { // 결과가 있으면
				AssetDTO dto = new AssetDTO();
				
				dto.setM_code1(rs.getString("m_code2"));
				dto.setM_code2(rs.getString("m_code3"));
				dto.setM_name(rs.getString("m_name"));
				dto.setM_enable(rs.getString("m_enable"));
			
				lists.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}
	
	
	
	public List<AssetDTO> search_acode1() {
		List<AssetDTO> lists = new ArrayList<AssetDTO>();

		String sql = "select * from a_code1";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while(rs.next()) { // 결과가 있으면
				AssetDTO dto = new AssetDTO();
				
				dto.setA_code1(rs.getString("a_code1"));
				dto.setA_name(rs.getString("a_name"));
				dto.setA_enable(rs.getString("a_enable"));
				lists.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}
	
	public List<AssetDTO> search_acode2() {
		List<AssetDTO> lists = new ArrayList<AssetDTO>();

		String sql = "select * from a_code2";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while(rs.next()) { // 결과가 있으면
				AssetDTO dto = new AssetDTO();
				
				dto.setA_code1(rs.getString("a_code1"));
				dto.setA_code2(rs.getString("a_code2"));
				dto.setA_name(rs.getString("a_name"));
				dto.setA_enable(rs.getString("a_enable"));
				
				lists.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}
	
	public List<AssetDTO> search_acode3() {
		List<AssetDTO> lists = new ArrayList<AssetDTO>();

		String sql = "select * from a_code3";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while(rs.next()) { // 결과가 있으면
				AssetDTO dto = new AssetDTO();
				
				dto.setA_code1(rs.getString("a_code2"));
				dto.setA_code2(rs.getString("a_code3"));
				dto.setA_name(rs.getString("a_name"));
				dto.setA_enable(rs.getString("a_enable"));
			
				lists.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}
	
	public List<AssetDTO> search_ocode1() {
		List<AssetDTO> lists = new ArrayList<AssetDTO>();

		String sql = "select * from o_code1";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while(rs.next()) { // 결과가 있으면
				AssetDTO dto = new AssetDTO();
				
				dto.setO_code1(rs.getString("o_code1"));
				dto.setO_name(rs.getString("o_name"));
			
				lists.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}
	
	public List<AssetDTO> search_ocode2() {
		List<AssetDTO> lists = new ArrayList<AssetDTO>();

		String sql = "select * from o_code2";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while(rs.next()) { // 결과가 있으면
				AssetDTO dto = new AssetDTO();
				
				dto.setO_code1(rs.getString("o_code1"));
				dto.setO_code2(rs.getString("o_code2"));
				dto.setO_name(rs.getString("o_name"));
			
				lists.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}
	
	public List<AssetDTO> search_lcode1() {
		List<AssetDTO> lists = new ArrayList<AssetDTO>();
		String sql = "select * from l_code1";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while(rs.next()) { // 결과가 있으면
				AssetDTO dto = new AssetDTO();
				
				dto.setL_code1(rs.getString("l_code1"));
				dto.setL_name(rs.getString("l_name"));
			
				lists.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}

	public List<AssetDTO> searchcode(AssetDTO add_dto) throws UnsupportedEncodingException {

	//	String a_name = null;
	//	String a_locate = null;
	//	String a_aname = null;
	//	String a_amodel = null;
	//	String a_vendorname = null;
		String getdate = add_dto.getA_getdate();
		String adddate = add_dto.getA_adddate();
		
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM");
		String time_in = dayTime.format(new Date(time)); //시간까지 모두 출력
				
		if(getdate == null){
			getdate = time_in;
			adddate = time_in;
		}
		 
		List<AssetDTO> lists = new ArrayList<AssetDTO>();
		String sql_condition = "SELECT assets.a_gnum, assets.a_anum, m_code1.m_name, m_code2.m_name, m_code3.m_name, " +
				"assets.a_locate, assets.a_id, assets.a_name, assets.a_getdate, assets.a_adddate, a_code1.a_name, " +
				"a_code2.a_name, a_code3.a_name, assets.a_aname, assets.a_amodel, assets.a_vendorname, assets.a_bigo, " +
				"assets.a_spec, assets.a_attachment, assets.a_enable FROM (assets INNER JOIN (m_code1 INNER JOIN " +
				"(m_code2 INNER JOIN m_code3 ON m_code2.m_code2 = m_code3.m_code2) ON m_code1.m_code1 = m_code2.m_code1)" +
				" ON assets.a_dept = m_code3.m_code3) INNER JOIN (a_code1 INNER JOIN (a_code2 INNER JOIN a_code3 " +
				"ON a_code2.a_code2 = a_code3.a_code2) ON a_code1.a_code1 = a_code2.a_code1) ON assets.a_code3 = a_code3.a_code3 " +
				"where a_getdate BETWEEN '" + getdate + "-01' AND '"
								+ getdate + "-31' AND a_adddate BETWEEN '" + adddate + "-01' AND '"
								+ adddate + "-31'";

// 조건문 시작
		if(add_dto.getA_name() != null && !add_dto.getA_name().equals("null")){
		//	a_name = new String(add_dto.getA_name().getBytes("8859_1"), "EUC-KR");
			sql_condition = sql_condition + " AND ";
			sql_condition = sql_condition + "assets.a_name = " + "'" + add_dto.getA_name() + "'"; 

		}
		if(add_dto.getA_locate() != null && !add_dto.getA_locate().equals("null")){
		//	a_locate = new String(add_dto.getA_locate().getBytes("8859_1"), "EUC-KR");
			sql_condition = sql_condition + " AND ";
			sql_condition = sql_condition + "a_locate like " + "'%" + add_dto.getA_locate() + "%'"; 

		}
		if(add_dto.getA_amodel() != null && !add_dto.getA_amodel().equals("null")){
		//	a_amodel = new String(add_dto.getA_amodel().getBytes("8859_1"), "EUC-KR");
			sql_condition = sql_condition + " AND ";
			sql_condition = sql_condition + "a_amodel like " + "'%" + add_dto.getA_amodel() + "%'"; 

		}
		if(add_dto.getA_aname() != null && !add_dto.getA_aname().equals("null")){
		//	a_aname = new String(add_dto.getA_aname().getBytes("8859_1"), "EUC-KR");
			sql_condition = sql_condition + " AND ";
			sql_condition = sql_condition + "a_aname like " + "'%" + add_dto.getA_aname() + "%'"; 

		}
		if(add_dto.getA_vendorname() != null && !add_dto.getA_vendorname().equals("null")){
		//	a_vendorname = new String(add_dto.getA_vendorname().getBytes("8859_1"), "EUC-KR");
			sql_condition = sql_condition + " AND ";
			sql_condition = sql_condition + "a_vendorname like " + "'%" + add_dto.getA_vendorname() + "%'"; 

		}
		if(add_dto.getA_anum() != null && !add_dto.getA_anum().equals("null")){
			sql_condition = sql_condition + " AND ";
			sql_condition = sql_condition + "a_anum = " + "'" + add_dto.getA_anum() + "'"; 

		}
		if(add_dto.getA_gnum() != null && !add_dto.getA_gnum().equals("null")){
			sql_condition = sql_condition + " AND ";
			sql_condition = sql_condition + "a_gnum = " + "'" + add_dto.getA_gnum() + "'"; 

		}
		if(add_dto.getA_id() != null && !add_dto.getA_id().equals("null")){
			sql_condition = sql_condition + " AND ";
			sql_condition = sql_condition + "a_id = " + "'" + add_dto.getA_id() + "'"; 

		}
		if(add_dto.getA_company() != null && !add_dto.getA_company().equals("null") && !add_dto.getA_company().equals("C_00000")){
			sql_condition = sql_condition + " AND ";
			sql_condition = sql_condition + "m_code1.m_code1 = " + "'" + add_dto.getA_company() + "'"; 

		}
		if(add_dto.getA_place() != null && !add_dto.getA_place().equals("null") && !add_dto.getA_place().equals("P_00000")){
			sql_condition = sql_condition + " AND ";
			sql_condition = sql_condition + "m_code2.m_code2 = " + "'" + add_dto.getA_place() + "'"; 

		}
		if(add_dto.getA_dept() != null && !add_dto.getA_dept().equals("null") && !add_dto.getA_dept().equals("D_00000")){
			sql_condition = sql_condition + " AND ";
			sql_condition = sql_condition + "m_code3.m_code3 = " + "'" + add_dto.getA_dept() + "'"; 

		}
		if(add_dto.getA_code1() != null && !add_dto.getA_code1().equals("null") && !add_dto.getA_code1().equals("A1_0000")){
			sql_condition = sql_condition + " AND ";
			sql_condition = sql_condition + "assets.a_code1 = " + "'" + add_dto.getA_code1() + "'"; 

		}
		if(add_dto.getA_code2() != null && !add_dto.getA_code2().equals("null") && !add_dto.getA_code2().equals("A2_0000")){
			sql_condition = sql_condition + " AND ";
			sql_condition = sql_condition + "assets.a_code2 = " + "'" + add_dto.getA_code2() + "'"; 

		}
		if(add_dto.getA_code3() != null && !add_dto.getA_code3().equals("null") && !add_dto.getA_code3().equals("A3_0000")){
			sql_condition = sql_condition + " AND ";
			sql_condition = sql_condition + "assets.a_code3 = " + "'" + add_dto.getA_code3() + "'"; 

		}
	
		sql_condition = sql_condition + "GROUP BY assets.a_anum ";
		sql_condition = sql_condition + "ORDER BY assets.a_getdate DESC ";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql_condition);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				AssetDTO dto = new AssetDTO();
				dto.setA_gnum(rs.getString("a_gnum"));
				dto.setA_anum(rs.getString("a_anum"));
				dto.setA_company(rs.getString("m_code1.m_name"));
				dto.setA_place(rs.getString("m_code2.m_name"));
				dto.setA_dept(rs.getString("m_code3.m_name"));
				dto.setA_locate(rs.getString("a_locate"));
				dto.setA_id(rs.getString("a_id"));
				dto.setA_name(rs.getString("a_name"));
				dto.setA_getdate(rs.getString("a_getdate"));
				dto.setA_code1(rs.getString("a_code1.a_name"));
				dto.setA_code2(rs.getString("a_code2.a_name"));
				dto.setA_code3(rs.getString("a_code3.a_name"));
				dto.setA_aname(rs.getString("a_aname"));
				dto.setA_amodel(rs.getString("a_amodel"));
				dto.setA_vendorname(rs.getString("a_vendorname"));
				dto.setA_bigo(rs.getString("a_bigo"));
				dto.setA_spec(rs.getString("a_spec"));
				dto.setA_attachment(rs.getString("a_attachment"));
				dto.setA_enable(rs.getString("a_enable"));
				
				lists.add(dto);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}
	
	public AssetDTO search_detail(String anum) {
		AssetDTO dto = new AssetDTO();
				
		String sql = "SELECT assets.a_gnum, assets.a_anum, m_code1.m_name, m_code2.m_name, m_code3.m_name, " +
				"assets.a_locate, assets.a_id, assets.a_name, assets.a_getdate, assets.a_adddate, a_code1.a_name, " +
				"a_code2.a_name, a_code3.a_name, assets.a_aname, assets.a_amodel, assets.a_vendorname, assets.a_bigo, " +
				"assets.a_spec, assets.a_attachment, assets.a_enable FROM (assets INNER JOIN (m_code1 INNER JOIN " +
				"(m_code2 INNER JOIN m_code3 ON m_code2.m_code2 = m_code3.m_code2) ON m_code1.m_code1 = m_code2.m_code1)" +
				" ON assets.a_company = m_code1.m_code1) INNER JOIN (a_code1 INNER JOIN (a_code2 INNER JOIN a_code3 " +
				"ON a_code2.a_code2 = a_code3.a_code2) ON a_code1.a_code1 = a_code2.a_code1) ON assets.a_code1 = a_code1.a_code1 " +
				"where a_anum = ?";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			ps.setString(1, anum);
			rs = ps.executeQuery();
			
			sql = sql + " GROUP BY assets.a_anum";

			if(rs.next()) { // 결과가 있으면
				
				dto.setA_anum(rs.getString("a_anum"));
				dto.setA_gnum(rs.getString("a_gnum"));
				dto.setA_company(rs.getString("m_code1.m_name"));
				dto.setA_place(rs.getString("m_code2.m_name"));
				dto.setA_dept(rs.getString("m_code3.m_name"));
				dto.setA_code1(rs.getString("a_code1.a_name"));
				dto.setA_code2(rs.getString("a_code2.a_name"));
				dto.setA_code3(rs.getString("a_code3.a_name"));
				dto.setA_locate(rs.getString("a_locate"));
				dto.setA_name(rs.getString("a_name"));
				dto.setA_id(rs.getString("a_id"));
				dto.setA_aname(rs.getString("a_aname"));
				dto.setA_amodel(rs.getString("a_amodel"));
				dto.setA_vendorname(rs.getString("a_vendorname"));
				dto.setA_getdate(rs.getString("a_getdate"));
				dto.setA_adddate(rs.getString("a_adddate"));
				dto.setA_bigo(rs.getString("a_bigo"));
				dto.setA_spec(rs.getString("a_spec"));
				dto.setA_attachment(rs.getString("a_attachment"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return dto;
	}
	
	public AssetDTO search_detail_admin(String anum) {
		AssetDTO dto = new AssetDTO();
				
		String sql = "SELECT * from assets where a_anum = '" + anum + "'";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if(rs.next()) { // 결과가 있으면
				
				dto.setA_anum(rs.getString("a_anum"));
				dto.setA_gnum(rs.getString("a_gnum"));
				dto.setA_company(rs.getString("a_company"));
				dto.setA_place(rs.getString("a_place"));
				dto.setA_dept(rs.getString("a_dept"));
				dto.setA_code1(rs.getString("a_code1"));
				dto.setA_code2(rs.getString("a_code2"));
				dto.setA_code3(rs.getString("a_code3"));
				dto.setA_locate(rs.getString("a_locate"));
				dto.setA_name(rs.getString("a_name"));
				dto.setA_id(rs.getString("a_id"));
				dto.setA_aname(rs.getString("a_aname"));
				dto.setA_amodel(rs.getString("a_amodel"));
				dto.setA_vendorname(rs.getString("a_vendorname"));
				dto.setA_getdate(rs.getString("a_getdate"));
				dto.setA_adddate(rs.getString("a_adddate"));
				dto.setA_bigo(rs.getString("a_bigo"));
				dto.setA_spec(rs.getString("a_spec"));
				dto.setA_attachment(rs.getString("a_attachment"));
				dto.setA_enable(rs.getString("a_enable"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return dto;
	}
	
	public boolean updateAsset(AssetDTO dto) { // 저장 성공시 true 실패시 false (이걸		

		boolean ok = false;
		String sql = "UPDATE assets SET a_gnum = ?, a_company = ?, a_place = ?, a_dept = ?, a_locate = ?," +
				" a_id = ?, a_name = ?, a_getdate = ?, a_adddate = ?, a_code1 = ?, a_code2 = ?, a_code3 = ?, a_aname = ?," +
				" a_amodel = ?, a_vendorname = ?, a_bigo = ?, a_spec = ?, a_attachment = ?, a_enable = ? where a_anum = '" + dto.getA_anum() + "'";
		
		Connection con = null;
		PreparedStatement ps = null; // 준비된 명령 무엇이? 위에 ??들을 채우겠다.

		try {
			con = getCon();
			ps = con.prepareStatement(sql);

			ps.setString(1, dto.getA_gnum());
			ps.setString(2, dto.getA_company());
			ps.setString(3, dto.getA_place());
			ps.setString(4, dto.getA_dept());
			ps.setString(5, dto.getA_locate());
			ps.setString(6, dto.getA_id());
			ps.setString(7, dto.getA_name());
			ps.setString(8, dto.getA_getdate());
			ps.setString(9, dto.getA_adddate());
			ps.setString(10, dto.getA_code1());
			ps.setString(11, dto.getA_code2());
			ps.setString(12, dto.getA_code3());
			ps.setString(13, dto.getA_aname());
			ps.setString(14, dto.getA_amodel());
			ps.setString(15, dto.getA_vendorname());
			ps.setString(16, dto.getA_bigo());
			ps.setString(17, dto.getA_spec());
			ps.setString(18, dto.getA_attachment());
			if(dto.getA_enable() == null){
				ps.setString(19, "0");
			} else ps.setString(19, "1");
			
			int cnt = ps.executeUpdate(); // insert, update, delete, select :
			// executeQuery() 메소드 사용
			
			if (cnt == 1)
				ok = true; // executeUpdate 가 성공하면 1을 반환한다.
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return ok; // 성공하면 true, 실패하면 false 리턴
	}
	
	public boolean deleteAsset(String anum) { // 저장 성공시 true 실패시 false (이걸		

		boolean ok = false;
		String sql = "UPDATE assets SET a_enable = ? where a_anum = '" + anum + "'";

		Connection con = null;
		PreparedStatement ps = null; // 준비된 명령 무엇이? 위에 ??들을 채우겠다.

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			ps.setString(1, "0");

			int cnt = ps.executeUpdate(); // insert, update, delete, select :
			// executeQuery() 메소드 사용
			if (cnt == 1)
				ok = true; // executeUpdate 가 성공하면 1을 반환한다.
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return ok; // 성공하면 true, 실패하면 false 리턴
	}
	
	// Jinyoung
	public List<AssetDTO> getAssetList(AssetDTO assetInfo) throws UnsupportedEncodingException {
		List<AssetDTO> lists = new ArrayList<AssetDTO>();

		String sql = "SELECT assets.a_anum, a_code1.a_code1, a_code2.a_code2, a_code3.a_code3, ";
		sql += "a_code1.a_name, a_code2.a_name, a_code3.a_name, assets.a_amodel, ";
		sql += "m_code1.m_name, m_code2.m_name, m_code3.m_name, assets.a_aname, assets.a_name ";
		sql += "FROM (assets INNER JOIN (m_code1 INNER JOIN (m_code2 INNER JOIN m_code3 ";
		sql += "ON m_code2.m_code2 = m_code3.m_code2) ON m_code1.m_code1 = m_code2.m_code1) ";
		sql += "ON assets.a_dept = m_code3.m_code3) INNER JOIN (a_code1 INNER JOIN ";
		sql += "(a_code2 INNER JOIN a_code3 ON a_code2.a_code2 = a_code3.a_code2) ";
		sql += "ON a_code1.a_code1 = a_code2.a_code1) ON assets.a_code3 = a_code3.a_code3 ";
		sql += "WHERE assets.a_enable = '1' ";
		
		if(assetInfo.getA_company() != null && !assetInfo.getA_company().equals("null") && !assetInfo.getA_company().equals("C_00000")){
			sql += "AND m_code1.m_code1 = '"+assetInfo.getA_company()+"' ";
		}
		if(assetInfo.getA_place() != null && !assetInfo.getA_place().equals("null") && !assetInfo.getA_place().equals("P_00000")){
			sql += "AND m_code2.m_code2 = '"+assetInfo.getA_place()+"' ";
		}
		if(assetInfo.getA_dept() != null && !assetInfo.getA_dept().equals("null") && !assetInfo.getA_dept().equals("D_00000")){
			sql += "AND m_code3.m_code3 = '"+assetInfo.getA_dept()+"' ";
		}
		if(assetInfo.getA_code1() != null && !assetInfo.getA_code1().equals("null") && !assetInfo.getA_code1().equals("A1_0000")){
			sql += "AND assets.a_code1 = '"+assetInfo.getA_code1()+"' ";
		}
		if(assetInfo.getA_code2() != null && !assetInfo.getA_code2().equals("null") && !assetInfo.getA_code2().equals("A2_0000")){
			sql += "AND assets.a_code2 = '"+assetInfo.getA_code2()+"' ";
		}
		if(assetInfo.getA_code3() != null && !assetInfo.getA_code3().equals("null") && !assetInfo.getA_code3().equals("A3_0000")){
			sql += "AND assets.a_code3 = '"+assetInfo.getA_code3()+"' ";
		}
		if(assetInfo.getA_amodel() != null && !assetInfo.getA_amodel().equals("null") && !assetInfo.getA_amodel().equals("")){
			sql += "AND assets.a_amodel = '"+assetInfo.getA_amodel()+"' ";
		}
		if(assetInfo.getA_name() != null && !assetInfo.getA_name().equals("null") && !assetInfo.getA_name().equals("")){
			sql += "AND assets.a_name = '"+assetInfo.getA_name()+"' ";
		}
		
		sql += "GROUP BY assets.a_anum";

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				AssetDTO dto = new AssetDTO();
				
				dto.setA_anum(rs.getString("assets.a_anum"));	   // 자산번호
				
				dto.setA_code1(rs.getString("a_code1.a_code1"));   // 자산구분코드
				dto.setA_code2(rs.getString("a_code2.a_code2"));   // 자산종류
				dto.setA_code3(rs.getString("a_code3.a_code3"));   // 자산유형
				
				dto.setA_code1_name(rs.getString("a_code1.a_name"));   // 자산구분이름
				dto.setA_code2_name(rs.getString("a_code2.a_name"));   // 자산종류
				dto.setA_code3_name(rs.getString("a_code3.a_name"));   // 자산유형(장비명)
				
				dto.setA_aname(rs.getString("assets.a_aname"));   // 자산등록시 사용자 입력 품명
				dto.setA_amodel(rs.getString("assets.a_amodel")); // 모델명
				
				dto.setA_company(rs.getString("m_code1.m_name")); // 회사이름
				dto.setA_place(rs.getString("m_code2.m_name"));   // 사업장
				dto.setA_dept(rs.getString("m_code3.m_name"));    // 부서
				
				dto.setA_name(rs.getString("assets.a_name"));     // 자산소유자이름
				
				lists.add(dto);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		
		return lists;
	}
	
//////////////////////////////////////////////거니거니//////////////////////
	public String getAssetName(String a_anum) {
		String anum="";

		String sql = "SELECT a_aname from assets where a_anum=?";
		
		//"SELECT a_code3.a_code3, a_code3.a_name FROM a_code3 WHERE a_enable='1'";
		Connection con = null;
		PreparedStatement ps = null;
		
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			ps.setString(1, a_anum);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				anum=rs.getString("a_aname");
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return anum;
	}
	
	public String getAssetCode(String a_anum) {
		String acode="";

		String sql = "SELECT a_code3 FROM assets WHERE a_anum=? AND a_enable='1'";
		
		Connection con = null;
		PreparedStatement ps = null;
		
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			ps.setString(1, a_anum);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				acode=rs.getString("a_code3");
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return acode;
	}
	
	public boolean update_Asset(String FilePath,String anum) {
		boolean result = false;
		
		String sql = "UPDATE assets SET a_attachment=? WHERE a_anum=?";
	
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
		
			ps.setString(1, FilePath);
			ps.setString(2, anum);
			
			int cnt =ps.executeUpdate();	
			if(cnt==1) result = true; // 저장 ok
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
	
		return result;
	}
	
	public List<AssetDTO> getA_history(String anum) {
		List<AssetDTO> lists = new ArrayList<AssetDTO>();

		String sql = "SELECT a_history.a_anum, a_history.a_id, member.m_name, m_code1.m_name, m_code2.m_name, m_code3.m_name,";
		sql += " a_history.a_getdate FROM a_history INNER JOIN (member INNER JOIN (m_code1 INNER JOIN ";
		sql += "(m_code2 INNER JOIN m_code3 ON m_code2.m_code2 = m_code3.m_code2) ON m_code1.m_code1 = m_code2.m_code1)";
		sql += " ON member.m_dept = m_code3.m_code3) ON a_history.a_id = member.m_id WHERE a_history.a_anum = ?";
		sql += " ORDER BY a_anum, a_getdate;";
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			ps.setString(1, anum);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				AssetDTO dto = new AssetDTO();
				
				dto.setA_anum(rs.getString("a_history.a_anum"));	   // 자산번호
				dto.setA_id(rs.getString("a_history.a_id")); //소유자 ID
				dto.setM_name(rs.getString("member.m_name")); // 소유자 이름
				
				dto.setA_company(rs.getString("m_code1.m_name")); // 회사이름
				dto.setA_place(rs.getString("m_code2.m_name"));   // 사업장
				dto.setA_dept(rs.getString("m_code3.m_name"));    // 부서
				
				dto.setA_getdate(rs.getString("a_getdate")); //날짜
								
				lists.add(dto);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		
		return lists;
	}
	
	public boolean insertA_history(AssetDTO dto) throws UnsupportedEncodingException { // 저장 성공시 true 실패시 false (이걸		

		boolean ok = false;
		String sql = "INSERT INTO a_history (a_gnum, a_anum, a_getdate, a_id)";
			   sql += "VALUE (?, ?, ?, ?)";	// TOOL

		Connection con = null;
		PreparedStatement ps = null; // 준비된 명령 무엇이? 위에 ??들을 채우겠다.
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			// ?에 값들을 채운다.
			ps.setString(1, "LDCC");
			ps.setString(2, dto.getA_anum());
			ps.setString(3, dto.getA_getdate());
			ps.setString(4, dto.getA_id());
			
			int cnt = ps.executeUpdate(); // insert, update, delete, select :
			// executeQuery() 메소드 사용
			if (cnt == 1)
				ok = true; // executeUpdate 가 성공하면 1을 반환한다.
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return ok; // 성공하면 true, 실패하면 false 리턴
	}
	
}
