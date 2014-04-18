package kr.co.mycom.code;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CodeDAO {
	
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
	
	public List<CodeDTO> search_code2(String table_name) {
		List<CodeDTO> lists = new ArrayList<CodeDTO>();

		String sql = "select * from " + table_name;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			if(table_name.equals("l_code1")){
				sql = "SELECT `l_code1`.`l_code1`, `l_code1`.`l_name`, `m_code1`.`m_name` `l_company`,`l_code1`.`l_detail`,`l_code1`.`l_enable` FROM `l_code1` INNER JOIN `m_code1` WHERE `l_code1`.`l_company` = `m_code1`.`m_code1`";
			}
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while(rs.next()) { // 결과가 있으면
				CodeDTO dto = new CodeDTO();

				if(table_name.equals("l_code1")){
					dto = new CodeDTO();
					
					dto.setM_code(rs.getString(table_name));
					dto.setM_name(rs.getString(table_name.substring(0,1) + "_name"));
					dto.setM_enable(rs.getString(table_name.substring(0,1) + "_enable"));
					dto.setL_detail(rs.getString("l_detail"));
					dto.setL_company(rs.getString("l_company"));
				} else{
					dto = new CodeDTO();
					
					dto.setM_code(rs.getString(table_name));
					dto.setM_name(rs.getString(table_name.substring(0,1) + "_name"));
					dto.setM_enable(rs.getString(table_name.substring(0,1) + "_enable"));
				}
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
	
	public boolean insertCode1(CodeDTO dto) throws UnsupportedEncodingException { 
		boolean ok = false;
		
		String sql_type = null;
		String sql_ch = null;
		String insert_code = null;
		
		if(dto.getCboCode1().equals("m_code")){
			sql_type = "m_code1";
			sql_ch = "m";
			}
		else{
			sql_type = dto.getCboCode1() + "1";
			sql_ch = dto.getCboCode1().substring(0,1);
		}

		String sql = "INSERT INTO " + sql_type + " (" + sql_type + ", " + sql_ch + "_name, " 
					+ sql_ch + "_enable";
		if(sql_ch.equals("l")){
			sql = sql + ", l_detail, l_company) VALUES (?, ?, ?, ?, ?)"; 
		} else{
			sql = sql + ") VALUES (?, ?, ?)" ;
		}

		String check_sql = "SELECT " + sql_type + " FROM "+ sql_type + " ORDER BY `" + sql_type + "` DESC;";
		
		String code_enable = "1";
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(check_sql);
			rs = ps.executeQuery();
			if(rs.next()){
				String check_part_forsplit = rs.getString(sql_type).substring(0,1);
				String code_split[] = rs.getString(sql_type).split("_");
				
				if(check_part_forsplit.equals("C")){
					int temp = Integer.parseInt(code_split[1]);
					temp++;
					insert_code = code_split[0] +"_"+ String.format("%05d", temp);
				} else{
					int temp = Integer.parseInt(code_split[1]);
					temp++;
					insert_code = code_split[0] +"_"+ String.format("%04d", temp);
				}
				
				if(dto.getCode_enable() == null){
					code_enable = "0";
				} 
			}
			
			ps = con.prepareStatement(sql);
			if(sql_ch.equals("l")){
			ps.setString(1, insert_code);
			ps.setString(2, dto.getCode_name());
			ps.setString(3, code_enable);
			ps.setString(4, dto.getL_detail());
			ps.setString(5, dto.getL_company());
			} else{
			ps.setString(1, insert_code);
			ps.setString(2, dto.getCode_name());
			ps.setString(3, code_enable);
			}
			
			int cnt = ps.executeUpdate();
		
			if (cnt == 1) ok = true;
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
	
	public boolean insertCode2(CodeDTO dto) throws UnsupportedEncodingException { 
		boolean ok = false;
		
		String sql_type1 = null;
		String sql_type2 = null;
		String sql_ch = null;
		String insert_code = null;
		
		if(dto.getCboCode1().equals("a_code") || dto.getCboCode1().equals("o_code")){
			sql_type1 = dto.getCboCode1() + "1";
			sql_type2 = dto.getCboCode1() + "2";
			sql_ch = dto.getCboCode1().substring(0,1);
		}
		else{
			sql_type1 = "m_code1";
			sql_type2 = "m_code2";
			sql_ch = "m";
		}

		String sql = "INSERT INTO " + sql_type2 + " (" + sql_type1 + ", " + sql_type2 + ", " + sql_ch + "_name, " 
					+ sql_ch + "_enable) VALUES (?, ?, ?, ?)" ;

		String check_sql = "SELECT " + sql_type2 + " FROM "+ sql_type2 + " ORDER BY `" + sql_type2 + "` DESC;";
		
		//String code_name = new String(dto.getCode_name().getBytes("Cp1252"), "EUC-KR");
		String code_enable = "1";
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(check_sql);
			rs = ps.executeQuery();
			if(rs.next()){
				String check_part_forsplit = rs.getString(sql_type2).substring(0,1);
				String code_split[] = rs.getString(sql_type2).split("_");
				
				if(check_part_forsplit.equals("A") || check_part_forsplit.equals("O")){
					int temp = Integer.parseInt(code_split[1]);
					temp++;
					insert_code = code_split[0] +"_"+ String.format("%04d", temp);
				} else{
					int temp = Integer.parseInt(code_split[1]);
					temp++;
					insert_code = code_split[0] +"_"+ String.format("%05d", temp);
				}
				
				if(dto.getCode_enable() == null){
					code_enable = "0";
				} 
			}
			
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getCboCode2());
			ps.setString(2, insert_code);
			ps.setString(3, dto.getCode_name());
			ps.setString(4, code_enable);
			
			int cnt = ps.executeUpdate();
		
			if (cnt == 1) ok = true;
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
	
	public boolean insertCode3(CodeDTO dto) throws UnsupportedEncodingException { 
		boolean ok = false;
		
		String sql_type1 = null;
		String sql_type2 = null;
		String sql_ch = null;
		String insert_code = null;
		
		if(dto.getCboCode1().equals("a_code")){
			sql_type1 = dto.getCboCode1() + "2";
			sql_type2 = dto.getCboCode1() + "3";
			sql_ch = dto.getCboCode1().substring(0,1);
		}
		else{
			sql_type1 = "m_code2";
			sql_type2 = "m_code3";
			sql_ch = "m";
		}

		String sql = "INSERT INTO " + sql_type2 + " (" + sql_type1 + ", " + sql_type2 + ", " + sql_ch + "_name, " 
					+ sql_ch + "_enable) VALUES (?, ?, ?, ?)" ;

		String check_sql = "SELECT " + sql_type2 + " FROM "+ sql_type2 + " ORDER BY `" + sql_type2 + "` DESC;";
		
		//String code_name = new String(dto.getCode_name().getBytes("Cp1252"), "EUC-KR");
		String code_enable = "1";
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(check_sql);
			rs = ps.executeQuery();
			if(rs.next()){
				String check_part_forsplit = rs.getString(sql_type2).substring(0,1);
				String code_split[] = rs.getString(sql_type2).split("_");
				
				if(check_part_forsplit.equals("A")){
					int temp = Integer.parseInt(code_split[1]);
					temp++;
					insert_code = code_split[0] +"_"+ String.format("%04d", temp);
				} else{
					int temp = Integer.parseInt(code_split[1]);
					temp++;
					insert_code = code_split[0] +"_"+ String.format("%05d", temp);
				}
				
				if(dto.getCode_enable() == null){
					code_enable = "0";
				} 
			}
			
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getCboCode3());
			ps.setString(2, insert_code);
			ps.setString(3, dto.getCode_name());
			ps.setString(4, code_enable);
			
			int cnt = ps.executeUpdate();
		
			if (cnt == 1) ok = true;
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
	
	public CodeDTO search_code(String part_name, String table_name, String code_name) {
		CodeDTO dto = new CodeDTO();
		String start_ch = part_name.substring(0,1); 
		String end_ch = table_name.substring(6,7);

		String sql = "SELECT * FROM " + table_name + " WHERE " + table_name + " = '" + code_name + "'";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			if(rs.next()) { // 결과가 있으면
				if(end_ch.equals("1")){
					if(start_ch.equals("l"))
					{dto.setCboCode1(part_name + "1");
					dto.setCode_name(start_ch + "_name");
					dto.setL_detail(start_ch + "_detail");
					dto.setCode_enable(start_ch + "_enable");
					}else{
					dto.setCboCode1(part_name + "1");
					dto.setCode_name(start_ch + "_name");
					dto.setCode_enable(start_ch + "_enable");
					}
				}else if(end_ch.equals("2")){
					dto.setCboCode1(part_name + "1");
					dto.setCboCode2(part_name + "2");
					dto.setCode_name(start_ch + "_name");
					dto.setCode_enable(start_ch + "_enable");
				}else{
					// 여기에 dto.setCboCode1을 받는 거만 만들면 된다
					dto.setCboCode2(part_name + "2");
					dto.setCboCode3(part_name + "3");
					dto.setCode_name(start_ch + "_name");
					dto.setCode_enable(start_ch + "_enable");
				}
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
	
	public boolean updateCode1(CodeDTO dto) { 
		
		boolean ok = false;
		
		String sql_type = null;
		String sql_ch = null;
		
		if(dto.getCboCode1().equals("m_code")){
			sql_type = "m_code1";
			sql_ch = "m";
		}
		else{
			sql_type = dto.getCboCode1() + "1";
			sql_ch = dto.getCboCode1().substring(0,1);
		}
		String code_enable = "1";

		if(dto.getCode_enable() == null){
			code_enable = "0";
		} 
		String Code_name = dto.getCode_name() + " ";
		String sql = "UPDATE " + sql_type + " SET " + sql_ch + "_name = '" +Code_name 
					+ "', " + sql_ch+ "_enable = '" + code_enable + "'";
		if(sql_ch.equals("l")){
			sql = sql + ", l_detail = '" + dto.getL_detail() + "', l_company = '" + dto.getL_company() + "'";
		}
		sql = sql +	" WHERE " + sql_type + " = '" + dto.getM_code() + "'";

		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			int cnt = ps.executeUpdate();
		
			if (cnt == 1) ok = true;
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
	
	public boolean updateCode2(CodeDTO dto) { 
		
		boolean ok = false;
		
		String sql_type1 = null;
		String sql_type2 = null;
		String sql_ch = null;
		
		if(dto.getCboCode1().equals("m_code")){
			sql_type1 = "m_code1";
			sql_type2 = "m_code2";
			sql_ch = "m";
		}
		else{
			sql_type1 = dto.getCboCode1() + "1";
			sql_type2 = dto.getCboCode1() + "2";
			sql_ch = dto.getCboCode1().substring(0,1);
		}
		String code_enable = "1";

		if(dto.getCode_enable() == null){
			code_enable = "0";
		} 
		
		String sql = "UPDATE " + sql_type2 + " SET " + sql_ch + "_name = '" + dto.getCode_name() 
					+ "', " + sql_ch+ "_enable = '" + code_enable + "' WHERE " + sql_type2 + " = '" + dto.getM_code() + "'";

		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			int cnt = ps.executeUpdate();
		
			if (cnt == 1) ok = true;
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
	
	public boolean updateCode3(CodeDTO dto) { 
		
		boolean ok = false;
		
		String sql_type1 = null;
		String sql_type2 = null;
		String sql_ch = null;
		
		if(dto.getCboCode1().equals("a_code") || dto.getCboCode1().equals("o_code")){
			sql_type1 = dto.getCboCode1() + "2";
			sql_type2 = dto.getCboCode1() + "3";
			sql_ch = dto.getCboCode1().substring(0,1);
		}
		else{
			sql_type1 = "m_code2";
			sql_type2 = "m_code3";
			sql_ch = "m";
		}
		String code_enable = "1";

		if(dto.getCode_enable() == null){
			code_enable = "0";
		} 
		
		String sql = "UPDATE " + sql_type2 + " SET " + sql_ch + "_name = '" + dto.getCode_name() 
					+ "', " + sql_ch+ "_enable = '" + code_enable + "' WHERE " + sql_type2 + " = '" + dto.getM_code() + "'";

		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			int cnt = ps.executeUpdate();
		
			if (cnt == 1) ok = true;
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
	
	public boolean deleteCode1(CodeDTO dto) { 
		
		boolean ok = false;
		
		String sql_type = null;
		String sql_ch = null;
		
		if(dto.getCboCode1().equals("m_code")){
			sql_type = "m_code1";
			sql_ch = "m";
		}
		else{
			sql_type = dto.getCboCode1() + "1";
			sql_ch = dto.getCboCode1().substring(0,1);
		}
		String code_enable = "1";

		if(dto.getCode_enable() == null){
			code_enable = "0";
		} 
		
		String sql = "UPDATE " + sql_type + " SET " + sql_ch+ "_enable = '" 
				+ code_enable + "' WHERE " + sql_type + " = '" + dto.getM_code() + "'";

		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			int cnt = ps.executeUpdate();
		
			if (cnt == 1) ok = true;
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
	
	public boolean deleteCode2(CodeDTO dto) { 
		
		boolean ok = false;
		
		String sql_type1 = null;
		String sql_type2 = null;
		String sql_ch = null;
		
		if(dto.getCboCode1().equals("a_code") || dto.getCboCode1().equals("o_code")){
			sql_type1 = dto.getCboCode1() + "1";
			sql_type2 = dto.getCboCode1() + "2";
			sql_ch = dto.getCboCode1().substring(0,1);
		}
		else{
			sql_type1 = "m_code1";
			sql_type2 = "m_code2";
			sql_ch = "m";
		}
		String code_enable = "1";

		if(dto.getCode_enable() == null){
			code_enable = "0";
		} 
		
		String sql = "UPDATE " + sql_type2 + " SET " + sql_ch+ "_enable = '" 
				+ code_enable + "' WHERE " + sql_type2 + " = '" + dto.getM_code() + "'";

		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			int cnt = ps.executeUpdate();
		
			if (cnt == 1) ok = true;
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
	
	public boolean deleteCode3(CodeDTO dto) { 
		
		boolean ok = false;
		
		String sql_type1 = null;
		String sql_type2 = null;
		String sql_ch = null;
		
		if(dto.getCboCode1().equals("a_code") || dto.getCboCode1().equals("o_code")){
			sql_type1 = dto.getCboCode1() + "2";
			sql_type2 = dto.getCboCode1() + "3";
			sql_ch = dto.getCboCode1().substring(0,1);
		}
		else{
			sql_type1 = "m_code2";
			sql_type2 = "m_code3";
			sql_ch = "m";
		}
		String code_enable = "1";

		if(dto.getCode_enable() == null){
			code_enable = "0";
		} 
		
		String sql = "UPDATE " + sql_type2 + " SET " + sql_ch+ "_enable = '"
				+ code_enable + "' WHERE " + sql_type2 + " = '" + dto.getM_code() + "'";

		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			int cnt = ps.executeUpdate();
		
			if (cnt == 1) ok = true;
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

	public CodeDTO search_lcode1(String l_code1) {
		CodeDTO dto = new CodeDTO();

		String sql = "select * from l_code1 where l_code1 = '" + l_code1 + "'";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			if(rs.next()) { // 결과가 있으면
				dto.setL_code1(rs.getString("l_code1"));
				dto.setL_name(rs.getString("l_name"));
				dto.setL_enable(rs.getString("l_enable"));
				dto.setL_detail(rs.getString("l_detail"));
				dto.setL_company(rs.getString("l_company"));
				
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
	

	public List<CodeDTO> search_code3(String table_name, String part_name) {
		List<CodeDTO> lists = new ArrayList<CodeDTO>();

		String sql = "select * from " + table_name + "2 where " + table_name + "1 = '" + part_name + "'";
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			if(table_name.equals("l_code")){
				sql = "SELECT `l_code1`.`l_code1`, `l_code1`.`l_name`, `m_code1`.`m_name` `l_company`,`l_code1`.`l_detail`,`l_code1`.`l_enable` FROM `l_code1` INNER JOIN `m_code1` WHERE `l_code1`.`l_company` = `m_code1`.`m_code1` AND `l_code1`.`l_company` = '" + part_name + "'";
			}
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while(rs.next()) { // 결과가 있으면
				CodeDTO dto = new CodeDTO();

				if(table_name.equals("l_code")){
					dto = new CodeDTO();
					
					dto.setM_code(rs.getString(table_name+"1"));
					dto.setM_name(rs.getString(table_name.substring(0,1) + "_name"));
					dto.setM_enable(rs.getString(table_name.substring(0,1) + "_enable"));
					dto.setL_detail(rs.getString("l_detail"));
					dto.setL_company(rs.getString("l_company"));
				} else{
					dto = new CodeDTO();
					
					dto.setM_code(rs.getString(table_name+"2"));
					dto.setM_name(rs.getString(table_name.substring(0,1) + "_name"));
					dto.setM_enable(rs.getString(table_name.substring(0,1) + "_enable"));
				}
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
	
	public List<CodeDTO> search_code4(String table_name, String part_name) {
		List<CodeDTO> lists = new ArrayList<CodeDTO>();

		String sql = "select * from " + table_name + "3 where " + table_name + "2 = '" + part_name + "'";
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while(rs.next()) { // 결과가 있으면
				CodeDTO dto = new CodeDTO();

				if(table_name.equals("l_code2")){
					dto = new CodeDTO();
					
					dto.setM_code(rs.getString(table_name+"3"));
					dto.setM_name(rs.getString(table_name.substring(0,1) + "_name"));
					dto.setM_enable(rs.getString(table_name.substring(0,1) + "_enable"));
					dto.setL_detail(rs.getString("l_detail"));
					dto.setL_company(rs.getString("l_company"));
				} else{
					dto = new CodeDTO();
					
					dto.setM_code(rs.getString(table_name+"3"));
					dto.setM_name(rs.getString(table_name.substring(0,1) + "_name"));
					dto.setM_enable(rs.getString(table_name.substring(0,1) + "_enable"));
				}
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


	public List<CodeDTO> getLCode1List() {
		List<CodeDTO> lists = new ArrayList<CodeDTO>();

		String sql = "SELECT l_code1.l_code1, l_code1.l_name, l_code1.l_company FROM l_code1 WHERE l_enable='1'";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				CodeDTO dto = new CodeDTO();
				
				dto.setL_code1(rs.getString("l_code1.l_code1"));
				dto.setL_name(rs.getString("l_code1.l_name"));
				dto.setL_company(rs.getString("l_code1.l_company"));

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
/////////////////////////////////////거니거니
	public List<CodeDTO> getGrade(){
		List<CodeDTO> lists = new ArrayList<CodeDTO>();
		String sql = "SELECT * FROM l_code1";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while(rs.next()) { // 결과가 있으면
				CodeDTO dto = new CodeDTO();
				dto.setL_code1(rs.getString("l_code1"));
				dto.setL_name(rs.getString("l_name"));
				dto.setL_company(rs.getString("l_company"));
				
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
}
