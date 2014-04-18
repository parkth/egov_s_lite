package kr.co.mycom.excel;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import kr.co.mycom.asset.AssetDTO;

public class ExcelDAO {
	
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
	
	public List<ExcelDTO> readDB(String my_id) throws UnsupportedEncodingException {
		List<ExcelDTO> lists = new ArrayList<ExcelDTO>();

		String sql = "select * from asset_temp where a_addid = '" + my_id + "';";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while(rs.next()) { // 결과가 있으면
				ExcelDTO dto = new ExcelDTO();
				
				dto.setA_gnum(rs.getString("a_gnum"));
				dto.setA_company(rs.getString("a_company"));
				dto.setA_place(rs.getString("a_place"));
				dto.setA_dept(rs.getString("a_dept"));
				dto.setA_locate(rs.getString("a_locate"));
				dto.setA_id(rs.getString("a_id"));
				dto.setA_name(rs.getString("a_name"));
				dto.setA_getdate(rs.getString("a_getdate"));
				dto.setA_adddate(rs.getString("a_adddate"));
				dto.setA_code1(rs.getString("a_code1"));
				dto.setA_code2(rs.getString("a_code2"));
				dto.setA_code3(rs.getString("a_code3"));
				dto.setA_aname(rs.getString("a_aname"));
				dto.setA_amodel(rs.getString("a_amodel"));
				dto.setA_vendorname(rs.getString("a_vendorname"));
				dto.setA_bigo(rs.getString("a_bigo"));
				dto.setA_spec(rs.getString("a_spec"));
				dto.setA_enable(Integer.parseInt(rs.getString("a_enable")));
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
	
	
	public boolean insertAsset(String my_id) throws UnsupportedEncodingException { // 저장 성공시 true 실패시 false (이걸		

		boolean ok = false;
		String sql = "INSERT INTO assets (a_gnum, a_anum, a_company, a_place, a_dept, a_locate, a_id, a_name, a_getdate, " +
				"a_adddate, a_code1, a_code2, a_code3, a_aname, a_amodel, a_vendorname, a_bigo, a_spec, a_enable) " +
				"VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";	// TOOL
		
		String sql_temp = "SELECT * FROM asset_temp";
		String sql_anum = "SELECT a_anum FROM assets WHERE `a_anum` LIKE 'A%' ORDER BY `a_anum` DESC;";
		String sql_delete_temp = "DELETE FROM asset_temp WHERE a_addid = ?;";

		Connection con = null;
		PreparedStatement ps = null; // 준비된 명령 무엇이? 위에 ??들을 채우겠다.
		ResultSet rs = null;
		
		Connection con_number = null;
		PreparedStatement ps_number = null; // 준비된 명령 무엇이? 위에 ??들을 채우겠다.
		ResultSet rs_number = null;

		Connection con_delete = null;
		PreparedStatement ps_delete = null; // 준비된 명령 무엇이? 위에 ??들을 채우겠다.
		
		String confirm_anum = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql_temp);
			rs = ps.executeQuery();
			con_number = getCon();
						
			while(rs.next())
			{
				ps = con.prepareStatement(sql);
				// ?에 값들을 채운다.
				ps_number = con_number.prepareStatement(sql_anum);
				rs_number = ps_number.executeQuery();
				
				int temp = 0;
				
				if (rs_number.next()) { // 결과가 있으면
					confirm_anum = rs_number.getString("a_anum");
					String[] split_anum = confirm_anum.split("_");
					temp = Integer.parseInt(split_anum[1]);
					temp++;
				}
				
				confirm_anum = "A_"+ String.format("%07d", temp);
				
				ps.setString(1, "LDCC");
				ps.setString(2, confirm_anum);
				ps.setString(3, rs.getString("a_company"));
				ps.setString(4, rs.getString("a_place"));
				ps.setString(5, rs.getString("a_dept"));
				ps.setString(6, rs.getString("a_locate"));
				ps.setString(7, rs.getString("a_id"));
				ps.setString(8, rs.getString("a_name"));
				ps.setString(9, rs.getString("a_getdate"));
				ps.setString(10, rs.getString("a_adddate"));
				ps.setString(11, rs.getString("a_code1"));
				ps.setString(12, rs.getString("a_code2"));
				ps.setString(13, rs.getString("a_code3"));
				ps.setString(14, rs.getString("a_aname"));
				ps.setString(15, rs.getString("a_amodel"));
				ps.setString(16, rs.getString("a_vendorname"));
				ps.setString(17, rs.getString("a_bigo"));
				ps.setString(18, rs.getString("a_spec"));
				ps.setString(19, rs.getString("a_enable"));
				
			
				if(my_id.equals(rs.getString("a_addid")))
					ps.executeUpdate();
			}
			
			con_delete = getCon();
			ps_delete = con_delete.prepareStatement(sql_delete_temp);
			ps_delete.setString(1, my_id);
			
			ps_delete.executeUpdate();
			
			ok = true;
			
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
	
	public ArrayList<String> insertTemp(String excelTemp[][], String my_id){
		ArrayList <String> errData = new ArrayList<String>();
		Connection con = null;
		PreparedStatement ps = null; // 준비된 명령 무엇이? 위에 ??들을 채우겠다.
		ResultSet rs = null;
		
		
		
		try {
			//     개발실 DB 접속 
			con = getCon();
			//      Record를 읽어 배열로 저장
			for (int i = 0; i < excelTemp.length; i++) // 수동 : 테이블 형태의 방식
			{
				
				String sql = "insert into asset_temp(a_gnum, a_company, a_place, a_dept, a_locate, a_id, a_name, a_getdate, a_adddate,";
					   sql += " a_code1, a_code2, a_code3, a_aname, a_amodel, a_vendorname, a_bigo, a_spec, a_enable, a_addid)";
					   sql += " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";

				ps = con.prepareStatement(sql);
				try{
					ps.setString(1, "LDCC");			
					ps.setString(2, excelTemp[i][0]);
					ps.setString(3, excelTemp[i][1]);
					ps.setString(4, excelTemp[i][2]);
					ps.setString(5, excelTemp[i][3]);
					ps.setString(6, excelTemp[i][4]);
					ps.setString(7, excelTemp[i][5]);
					ps.setString(8, excelTemp[i][6]);
					ps.setString(9, new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
					ps.setString(10, excelTemp[i][7]);
					ps.setString(11, excelTemp[i][8]);
					ps.setString(12, excelTemp[i][9]);
					
					ps.setString(13, excelTemp[i][10]);
				
					ps.setString(14, excelTemp[i][11]);
					ps.setString(15, excelTemp[i][12]);
					ps.setString(16, excelTemp[i][13]);
					ps.setString(17, excelTemp[i][14]);
					ps.setInt(18, 1);
					ps.setString(19, my_id);
					ps.executeUpdate();
					ps.clearParameters();
				}catch(Exception e){
					errData.add(i + "");
					errData.add("LDCC");			
					errData.add(excelTemp[i][0]);
					errData.add(excelTemp[i][1]);
					errData.add(excelTemp[i][2]);
					errData.add(excelTemp[i][3]);
					errData.add(excelTemp[i][4]);
					errData.add(excelTemp[i][5]);
					errData.add(excelTemp[i][6]);
					errData.add(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
					errData.add(excelTemp[i][7]);
					errData.add(excelTemp[i][8]);
					errData.add(excelTemp[i][9]);
					errData.add(excelTemp[i][10]);
					errData.add(excelTemp[i][11]);
					errData.add(excelTemp[i][12]);
					errData.add(excelTemp[i][13]);
					errData.add(excelTemp[i][14]);
					errData.add("1");
					errData.add(my_id);
					continue;
				}
			}
		ps.close();
		} catch (Exception e) {
			e.printStackTrace();
		//	conn.rollback();

		}
		if(errData.size()>0)
			tempDel(my_id);
		return errData;
		
	}
	public void tempDel(String my_id){
		String sql_delete_temp = "DELETE FROM asset_temp WHERE a_addid = ?;";
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql_delete_temp);
			ps.setString(1, my_id);
			ps.executeUpdate();
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
	}
}

