package kr.co.mycom.obstacle;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class ObstacleDAO {
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
	
	public List<ObstacleDTO> getSearch(String SearchStartDay, String SearchEndDay, String grade, String state, String a_company,String a_place,String a_dept, String code1, String o_rnum, String o_name){
		String sql="";
		List<ObstacleDTO> lists = new ArrayList<ObstacleDTO>();
		String o_rnumQuery="SELECT obstacle.o_rnum, m_code3.m_name, obstacle.o_title, obstacle.o_occurrencetime, obstacle.o_ograde, obstacle.o_state, obstacle.o_requesttime, obstacle.o_solvingtime, obstacle.o_solvedtime, obstacle.o_finishtime, obstacle.a_id, obstacle.a_name, obstacle.a_linenum, obstacle.a_anum FROM (((m_code3 JOIN obstacle ON m_code3.m_code3=obstacle.o_dept) JOIN o_code1 ON o_code1.o_code1=obstacle.o_code1) JOIN o_code2 ON obstacle.o_code2=o_code2.o_code2 ) WHERE obstacle.o_rnum = ";
	
		if(o_rnum!=""){
			sql=o_rnumQuery+"'"+o_rnum+"'";
		}
		else if(o_rnum=="" && SearchStartDay!=""){
			 sql= "SELECT obstacle.o_rnum, m_code3.m_name, obstacle.o_title, obstacle.o_occurrencetime, obstacle.o_ograde, obstacle.o_state, obstacle.o_requesttime, obstacle.o_solvingtime, obstacle.o_solvedtime, obstacle.o_finishtime, obstacle.a_id, obstacle.a_name, obstacle.a_linenum, obstacle.a_anum  FROM (((m_code3 INNER JOIN obstacle ON m_code3.m_code3=obstacle.o_dept) LEFT JOIN o_code1 ON o_code1.o_code1=obstacle.o_code1) LEFT JOIN o_code2 ON obstacle.o_code2=o_code2.o_code2 ) WHERE ";
			if(SearchStartDay!="" && SearchEndDay!="")
				sql+=" DATE_FORMAT(o_occurrencetime,'%Y%m%d') BETWEEN "+SearchStartDay+"01" + " AND " + SearchEndDay+"31";
			if(!grade.equals("L1_000"))
				sql+= " AND obstacle.o_ograde="+"'"+grade+"'";
			if(!state.equals("S_00000")) 
				sql+= " AND obstacle.o_state="+"'"+state+"'";
			if(!code1.equals("O1_0000"))
				sql+=" AND obstacle.o_code1="+"'"+code1+"'";
			if (a_company.equals("C_00000") && a_place.equals("P_00000")
					&& a_dept.equals("D_00000")) {
			} else if ((!a_company.equals("C_00000")) && a_place.equals("P_00000")) {
				sql += " AND obstacle.o_company= " + "'" + a_company + "'";
			} else if ((!a_company.equals("C_00000"))
					&& (!a_place.equals("P_00000")) && (a_dept.equals("D_00000"))) {
				sql += " AND obstacle.o_company= " + "'" + a_company + "'" + "AND obstacle.o_place= "
						+ "'" + a_place + "'";
			} else {
				sql += " AND o_company= " + "'" + a_company + "'"+" AND o_place= "
				+ "'" + a_place + "'" + " AND o_dept= "
						+ "'" + a_dept + "'"  ;
			}
			if(o_name.length() != 0) 
				sql+= " AND obstacle.o_name="+"'"+o_name+"'";
			
			sql += " order by obstacle.o_requesttime DESC";
		}
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String State="";
		String solvedtime="";
		String solvingtime="";
		String finishtime="";
		String o_ograde="";
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			
			System.out.println(ps);
			rs = ps.executeQuery();
			while (rs.next()) { // 결과가 있으면
				ObstacleDTO dto = new ObstacleDTO();
				lists.add(dto);
				dto.setO_rnum(rs.getString("o_rnum")); //일련번호
				dto.setM_code3_m_name(rs.getString("m_code3.m_name")); //부서
				dto.setO_title(rs.getString("o_title"));//제목
				dto.setO_occurrencetime(rs.getString("o_occurrencetime"));
				if((rs.getString("o_ograde")==null)) { //등급
					o_ograde="";
					dto.setO_ograde(o_ograde);
				}
				else {dto.setO_ograde(rs.getString("o_ograde"));}
				
				//dto.setO_ograde(rs.getString("o_ograde"));
				if(rs.getString("o_state").equals("0")) State="요청"; //상태
				if(rs.getString("o_state").equals("1")) State="해결중";
				if(rs.getString("o_state").equals("2")) State="해결";
				if(rs.getString("o_state").equals("3")) State="종료";
				dto.setO_state(State);
				dto.setO_requesttime(rs.getString("o_requesttime")); //요청
				if((rs.getString("o_solvedtime")==null)) { //접수
					solvedtime="";
					dto.setO_solvedtime(solvedtime);
				}
				else {dto.setO_solvedtime(rs.getString("o_solvedtime"));}
				
				if((rs.getString("o_solvingtime")==null)) { //해결
					solvingtime="";
					dto.setO_solvingtime(solvingtime);
				}
				else {dto.setO_solvingtime(rs.getString("o_solvingtime"));}
				
				if((rs.getString("o_finishtime")==null)) { //완료
					finishtime="";
					dto.setO_finishtime(finishtime);
				}
				else {dto.setO_finishtime(rs.getString("o_finishtime"));}
				
				if((rs.getString("a_id")==null)) { //담당자id
					dto.setA_id("");
				}
				else {dto.setA_id(rs.getString("a_id"));}
				if((rs.getString("a_name")==null)) {
					dto.setA_name("");
				}
				else {dto.setA_name(rs.getString("a_name"));} //담당자이름
				if((rs.getString("a_linenum")==null)) {
					dto.setA_linenum("");
				}
				else {dto.setA_linenum(rs.getString("a_linenum"));} //전번
				if((rs.getString("a_anum")==null)) { //장비
					dto.setA_anum("");
				}
				else {dto.setA_anum(rs.getString("a_anum"));} 
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
	
	public ObstacleDTO getData(String o_rnum){
		String sql="SELECT obstacle.o_rnum, obstacle.o_title, obstacle.o_ograde, ";
		sql += "o_code1.o_name, o_code1.o_code1, o_code2.o_name, o_code2.o_code2, ";
		sql += "obstacle.o_opath, obstacle.o_vendorname, obstacle.o_a_name, obstacle.o_a_namecode, ";
		sql += "obstacle.o_occurrencetime, obstacle.o_requesttime, ";
		sql += "m_code1.m_name, m_code1.m_code1, m_code2.m_name, m_code2.m_code2, ";
		sql += "m_code3.m_name, m_code3.m_code3, obstacle.o_linenum, obstacle.o_name, ";
		sql += "obstacle.o_detail, obstacle.o_attachment, obstacle.o_state, ";
		sql += "obstacle.o_reason, obstacle.o_resolvedetail, obstacle.o_engineer, ";
		sql += "obstacle.o_requestdetail, obstacle.o_attachment_engineer, ";
		sql += "obstacle.a_name, obstacle.a_linenum, obstacle.a_anum ";
		
		sql += "FROM (((((m_code3 INNER JOIN obstacle ON m_code3.m_code3=obstacle.o_dept) JOIN m_code1 ON obstacle.o_company=m_code1.m_code1) JOIN m_code2 ON obstacle.o_place = m_code2.m_code2) LEFT JOIN o_code1 ON o_code1.o_code1=obstacle.o_code1) LEFT JOIN o_code2 ON obstacle.o_code2=o_code2.o_code2 ) ";	
		sql += "WHERE o_rnum=?";
		
		ObstacleDTO dto = new ObstacleDTO();
		String State="";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			ps.setString(1, o_rnum);
			rs = ps.executeQuery();
			

			if (rs.next()) { // 결과가 있으면
				dto.setO_rnum(rs.getString("obstacle.o_rnum"));
				dto.setM_code3_m_name(rs.getString("m_code3.m_name"));
				dto.setO_title(rs.getString("obstacle.o_title"));
				if((rs.getString("obstacle.o_ograde")==null)) {
					dto.setO_ograde("");
				}
				else{
					dto.setO_ograde(rs.getString("obstacle.o_ograde")+" ");
				}
				if((rs.getString("o_code1.o_name")==null)) {
					dto.setCode1_m_name("");
					dto.setO_code1("");
				}
				else{
					dto.setCode1_m_name(rs.getString("o_code1.o_name"));
					dto.setO_code1(rs.getString("o_code1.o_code1"));
				}
				if((rs.getString("o_code2.o_name")==null)) {
					dto.setCode2_m_name("");
					dto.setO_code2("");
				}
				else{
					dto.setCode2_m_name(rs.getString("o_code2.o_name"));
					dto.setO_code2(rs.getString("o_code2.o_code2"));
				}
				dto.setO_opath(rs.getString("obstacle.o_opath"));
				
				if((rs.getString("obstacle.o_vendorname")==null)) {
					dto.setO_vendorname("");
				}
				else{
					dto.setO_vendorname(rs.getString("obstacle.o_vendorname"));
				}
			
				if((rs.getString("obstacle.o_a_name")==null)) {
					dto.setO_a_name("");
				}
				else{
					dto.setO_a_name(rs.getString("obstacle.o_a_name"));
				}
				if((rs.getString("obstacle.o_a_namecode")==null)) {
					dto.setO_a_namecode("");
				}
				else{
					dto.setO_a_namecode(rs.getString("obstacle.o_a_namecode"));
				}
				if((rs.getString("obstacle.a_anum")==null)) {
					dto.setA_anum("");
				}
				else{
					dto.setA_anum(rs.getString("obstacle.a_anum"));
				}	
					
				dto.setO_occurrencetime(rs.getString("obstacle.o_occurrencetime"));
				dto.setO_requesttime(rs.getString("obstacle.o_requesttime"));
				dto.setM_code1_m_name(rs.getString("m_code1.m_name"));
				dto.setM_code1(rs.getString("m_code1.m_code1"));
				dto.setM_code2_m_name(rs.getString("m_code2.m_name"));
				dto.setM_code2(rs.getString("m_code2.m_code2"));
				dto.setM_code3_m_name(rs.getString("m_code3.m_name"));
				dto.setM_code3(rs.getString("m_code3.m_code3"));
				dto.setO_linenum(rs.getString("obstacle.o_linenum"));
				dto.setMember_name(rs.getString("obstacle.o_name"));
				dto.setO_detail(rs.getString("obstacle.o_detail"));
				dto.setO_attachment(rs.getString("obstacle.o_attachment"));
				
				if(rs.getString("o_state").equals("0")) State="요청";
				if(rs.getString("o_state").equals("1")) State="해결중";
				if(rs.getString("o_state").equals("2")) State="해결";
				if(rs.getString("o_state").equals("3")) State="종료";
				dto.setO_state(State);
		
				// null이면 빈공백 삽입
				dto.setO_reason((rs.getString("obstacle.o_reason") == null) ? "" : rs.getString("obstacle.o_reason"));
				dto.setO_resolvedetail((rs.getString("obstacle.o_resolvedetail") == null) ? "" : rs.getString("obstacle.o_resolvedetail"));
				dto.setO_engineer((rs.getString("obstacle.o_engineer") == null) ? "" : rs.getString("obstacle.o_engineer"));
				dto.setO_requestdetail((rs.getString("obstacle.o_requestdetail") == null) ? "" : rs.getString("obstacle.o_requestdetail"));
			
				dto.setO_attachment_engineer(rs.getString("obstacle.o_attachment_engineer"));
				
				// 장애담당자
				dto.setA_name((rs.getString("obstacle.a_name") == null) ? "" : rs.getString("obstacle.a_name"));
				dto.setA_linenum((rs.getString("obstacle.a_linenum") == null) ? "" : rs.getString("obstacle.a_linenum"));
				
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
	
	public ObstacleDTO getTime(String o_rnum){
		String sql="SELECT obstacle.o_solvingtime, obstacle.o_solvedtime, obstacle.o_finishtime ";
		sql += "FROM obstacle WHERE o_rnum=?";
		
		ObstacleDTO dto = new ObstacleDTO();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			ps.setString(1, o_rnum);
			
			rs = ps.executeQuery();

			if (rs.next()) { // 결과가 있으면		

				dto.setO_solvingtime((rs.getString("obstacle.o_solvingtime")));
				dto.setO_solvedtime((rs.getString("obstacle.o_solvedtime")));
				dto.setO_finishtime((rs.getString("obstacle.o_finishtime")));
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
	
	private String getPersonInChargeId(String o_rnum){
		String sql="SELECT a_id FROM obstacle WHERE o_rnum=?";
		
		String id = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			ps.setString(1, o_rnum);
			
			rs = ps.executeQuery();

			if (rs.next()) { // 결과가 있으면		
				
				id = rs.getString("a_id");
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

		return id;
	}
	
	public ObstacleDTO getPersonInChargeInfo(String o_rnum){
		
		String a_id = getPersonInChargeId(o_rnum);
		ObstacleDTO dto = new ObstacleDTO();
		
		if (a_id == null || a_id.equals("null") || a_id.equals("")) return dto;
		
		String sql="SELECT * FROM member WHERE m_id=? AND m_enable='1' AND m_master='1'";
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			ps.setString(1, a_id);
			
			rs = ps.executeQuery();

			if (rs.next()) { // 결과가 있으면	
				
				dto.setA_id(rs.getString("m_id"));
				dto.setA_name(rs.getString("m_name"));
				dto.setA_linenum(rs.getString("m_linenum"));

				dto.setM_code1(rs.getString("m_company"));
				dto.setM_code2(rs.getString("m_place"));
				dto.setM_code3(rs.getString("m_dept"));
				
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
	
	public List<ObstacleDTO> searchCode() {
		List<ObstacleDTO> lists = new ArrayList<ObstacleDTO>();

		String sql = "SELECT * FROM M_CODE3";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		//String deptCheck = code + "%";
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			//ps.setString(1, deptCheck);
			rs = ps.executeQuery();
			while (rs.next()) { // 결과가 있으면
				ObstacleDTO dto = new ObstacleDTO();
				dto.setDept(rs.getString("m_code3"));
				dto.setDept_name(rs.getString("m_name"));
				dto.setEnable(rs.getString("m_enable"));
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
	public List<ObstacleDTO> searchO_Code() {
		List<ObstacleDTO> lists = new ArrayList<ObstacleDTO>();
		String sql = "SELECT * FROM O_CODE1 where o_enable='1'";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		//String deptCheck = code + "%";
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) { // 결과가 있으면
				ObstacleDTO dto = new ObstacleDTO();
				dto.setO_code1(rs.getString("O_code1"));
				dto.setO_name(rs.getString("O_name"));
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
	
	// Jinyoung
	
	public List<ObstacleDTO> getOCode1List() {
		List<ObstacleDTO> lists = new ArrayList<ObstacleDTO>();

		String sql = "SELECT * FROM o_code1 WHERE `o_code1` LIKE 'O1%' AND o_enable='1'";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				ObstacleDTO dto = new ObstacleDTO();
				dto.setO_code1(rs.getString("o_code1"));
				dto.setCode1_m_name(rs.getString("o_name"));
				
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
	
	public List<ObstacleDTO> getOCode2List() {
		List<ObstacleDTO> lists = new ArrayList<ObstacleDTO>();

		String sql = "SELECT * FROM o_code2 where o_enable='1'";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				ObstacleDTO dto = new ObstacleDTO();
				dto.setO_code1(rs.getString("o_code1"));
				dto.setO_code2(rs.getString("o_code2"));
				dto.setCode2_m_name(rs.getString("o_name"));
				
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
	
	public List<ObstacleDTO> getMCode1List() {
		List<ObstacleDTO> lists = new ArrayList<ObstacleDTO>();

		String sql = "SELECT m_code1, m_name FROM m_code1 WHERE m_enable='1'";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				ObstacleDTO dto = new ObstacleDTO();
				dto.setM_code1(rs.getString("m_code1"));
				dto.setM_code1_m_name(rs.getString("m_name"));
				
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
	
	public List<ObstacleDTO> getMCode2List() {
		List<ObstacleDTO> lists = new ArrayList<ObstacleDTO>();

		String sql = "SELECT m_code1.m_code1, m_code1.m_name, m_code2.m_code2, m_code2.m_name FROM m_code1 INNER JOIN m_code2 ON m_code1.m_code1 = m_code2.m_code1;";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				ObstacleDTO dto = new ObstacleDTO();
				dto.setM_code1(rs.getString("m_code1.m_code1"));
				dto.setM_code1_m_name(rs.getString("m_code1.m_name"));
				dto.setM_code2(rs.getString("m_code2.m_code2"));
				dto.setM_code2_m_name(rs.getString("m_code2.m_name"));
				
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
	
	public List<ObstacleDTO> getMCode3List() {
		List<ObstacleDTO> lists = new ArrayList<ObstacleDTO>();

		String sql = "SELECT m_code1.m_code1, m_code1.m_name, m_code2.m_code2, m_code2.m_name, m_code3.m_code3, m_code3.m_name FROM m_code1 INNER JOIN (m_code2 INNER JOIN m_code3 ON m_code2.m_code2 = m_code3.m_code2) ON m_code1.m_code1 = m_code2.m_code1;";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				ObstacleDTO dto = new ObstacleDTO();
				dto.setM_code1(rs.getString("m_code1.m_code1"));
				dto.setM_code1_m_name(rs.getString("m_code1.m_name"));
				dto.setM_code2(rs.getString("m_code2.m_code2"));
				dto.setM_code2_m_name(rs.getString("m_code2.m_name"));
				dto.setM_code3(rs.getString("m_code3.m_code3"));
				dto.setM_code3_m_name(rs.getString("m_code3.m_name"));
				
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
	
	public List<ObstacleDTO> getANameList() {
		List<ObstacleDTO> lists = new ArrayList<ObstacleDTO>();

		String sql = "SELECT m_id, m_name, m_linenum, m_dept FROM member WHERE m_master='1' AND m_enable='1'";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				ObstacleDTO dto = new ObstacleDTO();
				dto.setA_name(rs.getString("m_name"));
				dto.setA_id(rs.getString("m_id"));
				dto.setA_linenum(rs.getString("m_linenum"));
				dto.setM_code3(rs.getString("m_dept"));
				
				
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
	
	/**
	 * 같은 자산번호를 가진 장애목록 반환
	 * @param a_anum
	 * @return
	 */
	public List<ObstacleDTO> getAnumObstacleList(String a_anum, String o_rnum){
		List<ObstacleDTO> lists = new ArrayList<ObstacleDTO>();
		String State = "";

		String sql = "SELECT obstacle.o_rnum, obstacle.o_state, obstacle.o_title, obstacle.o_a_namecode, obstacle.o_a_name, obstacle.o_occurrencetime ";
		sql += "FROM obstacle WHERE o_enable='1' AND a_anum LIKE '%" + a_anum +"%' AND o_rnum != ?";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			ps.setString(1, o_rnum);
			rs = ps.executeQuery();		

			while (rs.next()) { // 결과가 있으면
				ObstacleDTO dto = new ObstacleDTO();
				dto.setO_rnum(rs.getString("o_rnum"));
				dto.setO_title(rs.getString("o_title"));
				
				dto.setO_a_name(rs.getString("o_a_name"));
				dto.setO_a_namecode(rs.getString("o_a_namecode"));
				dto.setO_occurrencetime(rs.getString("o_occurrencetime"));
				
				if(rs.getString("o_state").equals("0")) State="요청";
				if(rs.getString("o_state").equals("1")) State="해결중";
				if(rs.getString("o_state").equals("2")) State="해결";
				if(rs.getString("o_state").equals("3")) State="종료";
				dto.setO_state(State);
				
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

	public boolean insertObstacle(ObstacleDTO dto) {
		boolean result = false;
		/*
		 * o_rnum 생성, o_state = 0, o_id는 현재 로그인한 사용자 아이디,  
		 */
		
		String sql = "INSERT INTO obstacle(o_rnum, o_state, o_title, o_code1, o_code2, ";
		sql += "o_a_name, o_ograde, o_opath, o_vendorname, o_occurrencetime, o_requesttime, ";
		sql += "o_id, o_name, o_company, o_place, o_dept, o_linenum, o_detail, o_attachment,o_engineer,o_solvingtime, o_enable) ";
		sql += "VALUES (?, '1', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?, '1');"; 

		String sql_rnum = "SELECT o_rnum FROM obstacle ORDER BY o_rnum DESC;";
		String o_rnum = null;
		
		Connection con = null;
		PreparedStatement ps = null; // 준비된 명령 무엇이? 위에 ??들을 채우겠다.
		ResultSet rs = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql_rnum);
			rs = ps.executeQuery();

			if (rs.next()) { // 결과가 있으면
				o_rnum = rs.getString("o_rnum");
				String[] split_code = o_rnum.split("_");
				int temp = Integer.parseInt(split_code[1]);
				temp++;
				o_rnum = split_code[0] + "_" + String.format("%08d", temp);
			} else
				o_rnum = "O_00000001";

			
			/* ? 순서 : 총 18개
			   접수번호, 제목, 대분류, 중분류, 자산명, 장애등급, 
			   접수경로, 벤더명, 발생시간, 요청시간, id, 요청고객명,
			   고객사, 사업장, 부서, 고객연락처, 장애현상, 첨부파일경로
			 */			
			ps = con.prepareStatement(sql);
			ps.setString(1, o_rnum);
			ps.setString(2, dto.getO_title());
			ps.setString(3, dto.getO_code1());
			ps.setString(4, dto.getO_code2());
			ps.setString(5, dto.getO_a_name());
			ps.setString(6, dto.getO_ograde());
			ps.setString(7, dto.getO_opath());
			ps.setString(8, dto.getO_vendorname());
			ps.setString(9, dto.getO_occurrencetime());
			ps.setString(10, dto.getO_requesttime());
			ps.setString(11, dto.getO_id());
			ps.setString(12, dto.getMember_name());
			ps.setString(13, dto.getM_code1());
			ps.setString(14, dto.getM_code2());
			ps.setString(15, dto.getM_code3());
			ps.setString(16, dto.getO_linenum());
			ps.setString(17, dto.getO_detail());
			ps.setString(18, dto.getO_attachment());
			ps.setString(19, dto.getO_engineer());
			ps.setString(20, dto.getO_solvingtime());
			
			
			int cnt = ps.executeUpdate();
			if (cnt == 1)
				result = true; // executeUpdate 가 성공하면 1을 반환한다.
			
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
		
		return result;
	}
	
	public boolean updateObstacle(ObstacleDTO dto) {
		boolean result = false;
		
		String sql = "UPDATE obstacle SET o_title=?, o_code1=?, o_code2=?, o_ograde=?, o_opath=?, ";
		sql += "o_a_name=?, o_vendorname=?, o_company=?, o_dept=?, o_name=?, o_linenum=?, o_occurrencetime=?, ";
		sql += "o_detail=?, o_engineer=?, o_reason=?, o_resolvedetail=?, o_requestdetail=?, o_attachment_engineer=?, o_a_namecode=?, ";
		sql += "a_id=?, a_name=?, a_linenum=?, a_anum=? ";
		
		if (dto.getO_state().equals("해결중")) {
			sql += ", o_state=?";
			sql += ", o_solvingtime=? ";
		}
		else if (dto.getO_state().equals("해결")) {
			sql += ", o_state=?";
			sql += ", o_solvedtime=? ";
		}
		else if (dto.getO_state().equals("종료")) {
			sql += ", o_state=?";
			sql += ", o_finishtime=? ";
		}
		
		sql += "WHERE o_rnum=?"; 
		
		Connection con = null;
		PreparedStatement ps = null;
		
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			
			/* parameter 순서. 공통부분 23개
			 제목, 대분류, 중분류, 장애등급, 접수경로,
			 장비명, 벤더명, 고객사, 부서, 요청고객명, 
			 고객연락처, 장애발생시간, 장애현상, 장애접수자, 장애원인, 
			 장애조치내역, 지원요청사항, 관리자첨부파일, 장비명code, 담당자id,
			 담당자이름, 담당자전화번호, 자산번호 */

			/* state 변화에 따라 추가부분. 2개
			 진행상태, {solvingtime | solvedtime | finishtime } *?

			/* 마지막 parameter 접수번호 */
		
			ps.setString(1, dto.getO_title());
			ps.setString(2, dto.getO_code1());
			ps.setString(3, dto.getO_code2());
			ps.setString(4, dto.getO_ograde());
			ps.setString(5, dto.getO_opath());
			
			ps.setString(6, dto.getO_a_name());
			ps.setString(7, dto.getO_vendorname());
			ps.setString(8, dto.getM_code1());
			ps.setString(9, dto.getM_code3());
			ps.setString(10, dto.getMember_name());
			
			ps.setString(11, dto.getO_linenum());
			ps.setString(12, dto.getO_occurrencetime());
			ps.setString(13, dto.getO_detail());
			ps.setString(14, dto.getO_engineer());
			ps.setString(15, dto.getO_reason());
			
			ps.setString(16, dto.getO_resolvedetail());
			ps.setString(17, dto.getO_requestdetail());
			ps.setString(18, dto.getO_attachment_engineer());
			ps.setString(19, dto.getO_a_namecode());
			ps.setString(20, dto.getA_id());
			
			ps.setString(21, dto.getA_name());
			ps.setString(22, dto.getA_linenum());
			ps.setString(23, dto.getA_anum());
			
			int state = 0;
			
			if (dto.getO_state().equals("요청")) {
				ps.setString(24, dto.getO_rnum());
			}
			if (dto.getO_state().equals("해결중")) {
				state = 1;
				ps.setString(24, String.valueOf(state));
				ps.setString(25, dto.getO_solvingtime());
				ps.setString(26, dto.getO_rnum());
			}
			if (dto.getO_state().equals("해결")) {
				state = 2;
				ps.setString(24, String.valueOf(state));
				ps.setString(25, dto.getO_solvedtime());
				ps.setString(26, dto.getO_rnum());
			}	
			if (dto.getO_state().equals("종료")) {
				state = 3;
				ps.setString(24, String.valueOf(state));
				ps.setString(25, dto.getO_finishtime());
				ps.setString(26, dto.getO_rnum());
			}
			
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
	// ////////////////////////////////////////////////////////////동거니거니
	// //////////내일할차레 0131
	public int[] getGradeSearch(String year, String a_company, String a_place,
			String a_dept, String Grade) {
		int[] A_search = new int[13];
		String sql = "SELECT COUNT(*) cnt FROM obstacle WHERE LEFT(o_occurrencetime,7)= ? AND o_ograde= "
				+ "'" + Grade + "'";
		if (a_company.equals("C_00000") && a_place.equals("P_00000")
				&& a_dept.equals("D_00000")) {

		} else if ((!a_company.equals("C_00000")) && a_place.equals("P_00000")) {
			sql += " AND o_company= " + "'" + a_company + "'";
		} else if ((!a_company.equals("C_00000"))
				&& (!a_place.equals("P_00000")) && (a_dept.equals("D_00000"))) {
			sql += " AND o_company= " + "'" + a_company + "'" + "AND o_place= "
					+ "'" + a_place + "'";
		} else {
			sql += " AND o_company= " + "'" + a_company + "'"+" AND o_place= "
			+ "'" + a_place + "'" + " AND o_dept= "
					+ "'" + a_dept + "'"  ;
		}
		// WHERE o_dept=? AND o_ograde=? AND LEFT(o_occurrencetime,7)=?";
		Connection con = null;
		PreparedStatement ps = null; // 준비된 명령 무엇이? 위에 ??들을 채우겠다.
		ResultSet rs = null;
		String temp;
		try {
			con = getCon();
			for (int i = 0; i <= 11; i++) {
				if (i <= 8) {
					temp= year+ "-" + "0" + (i + 1);
				} else {
					temp = year+ "-" + (i + 1);
				}
				ps = con.prepareStatement(sql);
				ps.setString(1, temp);
				rs = ps.executeQuery();
				if (rs.next()) { // 결과가 있으면
					A_search[i] = rs.getInt("cnt");
					A_search[12] += A_search[i];
				}
			}
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

		return A_search;
	}

	public ArrayList<String> getO_Code() {
		ArrayList<String> A_search = new ArrayList<String>();
		String sql = "SELECT o_code1 from o_code1 where o_enable='1'";
		Connection con = null;
		PreparedStatement ps = null; // 준비된 명령 무엇이? 위에 ??들을 채우겠다.
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) { // 결과가 있으면
				A_search.add(rs.getString("o_code1"));
			}
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
		return A_search;
	}

	public int[] getTypeSearch(String year, String Grade, String a_company,
			String a_place, String a_dept) {
		ArrayList<String> O_code = getO_Code();
		String sql = "SELECT COUNT(*) cnt FROM obstacle WHERE o_ograde=? AND o_code1=? AND LEFT(o_occurrencetime,4)=? ";
		if (a_company.equals("C_00000") && a_place.equals("P_00000")&& a_dept.equals("D_00000")) {

		} else if ((!a_company.equals("C_00000")) && a_place.equals("P_00000")) {
			sql += " AND o_company= " + "'" + a_company + "'";
		} else if ((!a_company.equals("C_00000"))&& (!a_place.equals("P_00000")) && (a_dept.equals("D_00000"))) {
			sql += " AND o_company= " + "'" + a_company + "'" + " AND o_place= "
					+ "'" + a_place + "'";
		} else {
			sql += " AND o_company= " + "'" + a_company + "'"+ " AND o_place= "
			+ "'" + a_place + "'" + " AND o_dept= "
					+ "'" + a_dept + "'";
		}
		
		int Max = O_code.size();
		int[] A_search = new int[Max + 1];
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			for (int i = 0; i < Max; i++) {
				ps = con.prepareStatement(sql);
				ps.setString(1, Grade);
				ps.setString(2, O_code.get(i));
				ps.setString(3, year);
				rs = ps.executeQuery();
				if (rs.next()) { // 결과가 있으면
					A_search[i] = rs.getInt("cnt");
					A_search[Max] += A_search[i];

				}
			}
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

		return A_search;
	}
	
	public boolean insertUserObstacle(ObstacleDTO dto) {
		boolean result = false;
	
		/*
		 * o_rnum 생성, o_state = 0, o_id는 현재 로그인한 사용자 아이디,  
		 */
		
		String sql = "INSERT INTO obstacle(o_rnum, o_state, o_title, o_occurrencetime, o_requesttime, ";
		sql += " o_id, o_name, o_company, o_place, o_dept, o_linenum, o_detail, o_attachment,o_opath, o_enable) ";
		sql += "VALUES (?, '0', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,'1');"; 

		String sql_rnum = "SELECT o_rnum FROM obstacle ORDER BY o_rnum DESC;";
		String o_rnum = null;
		
		Connection con = null;
		PreparedStatement ps = null; // 준비된 명령 무엇이? 위에 ??들을 채우겠다.
		ResultSet rs = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql_rnum);
			rs = ps.executeQuery();
			if (rs.next()) { // 결과가 있으면
				
				o_rnum = rs.getString("o_rnum");
				String[] split_code = o_rnum.split("_");
				int temp = Integer.parseInt(split_code[1]);
				temp++;
				o_rnum = split_code[0] +"_"+ String.format("%08d", temp);
			}
		//	o_id, o_name, o_company, o_place, o_dept, o_linenum, o_detail, o_attachment, o_enable) ";
			/* ? 순서 : 총 18개
			   접수번호, 제목, 대분류, 중분류, 자산명, 장애등급, 
			   접수경로, 벤더명, 발생시간, 요청시간, id, 요청고객명,
			   고객사, 사업장, 부서, 고객연락처, 장애현상, 첨부파일경로
			 */			
			ps = con.prepareStatement(sql);
			ps.setString(1, o_rnum);
			ps.setString(2, dto.getO_title());
			ps.setString(3, dto.getO_occurrencetime());
			ps.setString(4, dto.getO_requesttime());
			ps.setString(5, dto.getO_id());
			ps.setString(6, dto.getMember_name());
			ps.setString(7, dto.getM_code1());
			ps.setString(8, dto.getM_code2());
			ps.setString(9, dto.getM_code3());
			ps.setString(10, dto.getO_linenum());
			ps.setString(11, dto.getO_detail());
			ps.setString(12, dto.getO_attachment());
			ps.setString(13, dto.getO_opath());
			
			int cnt = ps.executeUpdate();
			if (cnt == 1)
				result = true; // executeUpdate 가 성공하면 1을 반환한다.
			
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
		
		return result;
	}
	
	///거니거니거니
	public boolean updateCustomer_Obstacle(String FilePath,String O_rnum) {
		boolean result = false;
		
		String sql = "UPDATE obstacle SET o_attachment=? WHERE o_rnum=?";
	
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			
			/* parameter 순서. 공통부분 23개
			 제목, 대분류, 중분류, 장애등급, 접수경로,
			 장비명, 벤더명, 고객사, 부서, 요청고객명, 
			 고객연락처, 장애발생시간, 장애현상, 장애접수자, 장애원인, 
			 장애조치내역, 지원요청사항, 관리자첨부파일, 장비명code, 담당자id,
			 담당자이름, 담당자전화번호, 자산번호 */

			/* state 변화에 따라 추가부분. 2개
			 진행상태, {solvingtime | solvedtime | finishtime } *?

			/* 마지막 parameter 접수번호 */
		
			ps.setString(1,FilePath);
			ps.setString(2, O_rnum);
			
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
	public boolean updateAdmin_Obstacle(String FilePath,String O_rnum) {
		boolean result = false;
		
		String sql = "UPDATE obstacle SET o_attachment_engineer=? WHERE o_rnum=?";
	
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			
			/* parameter 순서. 공통부분 23개
			 제목, 대분류, 중분류, 장애등급, 접수경로,
			 장비명, 벤더명, 고객사, 부서, 요청고객명, 
			 고객연락처, 장애발생시간, 장애현상, 장애접수자, 장애원인, 
			 장애조치내역, 지원요청사항, 관리자첨부파일, 장비명code, 담당자id,
			 담당자이름, 담당자전화번호, 자산번호 */

			/* state 변화에 따라 추가부분. 2개
			 진행상태, {solvingtime | solvedtime | finishtime } *?

			/* 마지막 parameter 접수번호 */
		
			ps.setString(1,FilePath);
			ps.setString(2, O_rnum);
			
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
}
