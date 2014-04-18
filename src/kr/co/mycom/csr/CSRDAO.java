package kr.co.mycom.csr;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class CSRDAO {
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
	
public CSRDTO getData(String csr_rnum){
		
		String sql="SELECT csr.csr_rnum, csr.csr_state, csr.csr_title, csr.csr_detail, csr.csr_system_category, csr.csr_code1, csr.csr_requesttime ";
		sql += ", csr.csr_id, csr.csr_name, csr.csr_company, csr.csr_place, csr.csr_dept, csr.csr_linenum, csr.csr_enable ";
		
		sql += ", csr_code1.csr_name, csr_code1.csr_code1 ";
		sql += ", csr_system_category.csr_system_category_name, csr_system_category.csr_system_category "; 
		sql += ", m_code1.m_name, m_code1.m_code1, m_code2.m_name, m_code2.m_code2 ";
		sql += ", m_code3.m_name, m_code3.m_code3 ";
		
		sql += ", csr.csr_previewer, csr.csr_solvingtime, csr.csr_estimate_solvetime, csr.csr_preview_result, csr.csr_dependentsystem_flag, csr.csr_dependentsystem ";
		
		sql += ", csr.csr_solvedtime, csr.csr_reason, csr.csr_processing_contents, csr.csr_estimate_md, csr.csr_complete_md, csr.csr_client_comment, csr.csr_finishtime ";
		sql += ", csr.csr_attachment ";
		
		sql += "FROM (((((m_code3 INNER JOIN csr ON m_code3.m_code3=csr.csr_dept) JOIN m_code1 ON csr.csr_company=m_code1.m_code1) JOIN m_code2 ON csr.csr_place = m_code2.m_code2) LEFT JOIN csr_code1 ON csr_code1.csr_code1=csr.csr_code1 LEFT JOIN csr_system_category ON csr_system_category.csr_system_category=csr.csr_system_category )) ";	
		sql += "WHERE csr_rnum=?";
		
/*		String sql="SELECT csr.csr_rnum, csr.csr_title, csr.csr_ograde, ";
		sql += "csr_code1.csr_name, csr_code1.csr_code1, csr_code2.csr_name, csr_code2.csr_code2, ";
		sql += "csr.csr_opath, csr.csr_vendorname, csr.csr_a_name, csr.csr_a_namecode, ";
		sql += "csr.csr_occurrencetime, csr.csr_requesttime, ";
		sql += "m_code1.m_name, m_code1.m_code1, m_code2.m_name, m_code2.m_code2, ";
		sql += "m_code3.m_name, m_code3.m_code3, csr.csr_linenum, csr.csr_name, ";
		sql += "csr.csr_detail, csr.csr_attachment, csr.csr_state, ";
		sql += "csr.csr_reason, csr.csr_resolvedetail, csr.csr_engineer, ";
		sql += "csr.csr_requestdetail, csr.csr_attachment_engineer, ";
		sql += "csr.a_name, csr.a_linenum, csr.a_anum ";
		
		sql += "FROM (((((m_code3 INNER JOIN csr ON m_code3.m_code3=csr.csr_dept) JOIN m_code1 ON csr.csr_company=m_code1.m_code1) JOIN m_code2 ON csr.csr_place = m_code2.m_code2) LEFT JOIN csr_code1 ON csr_code1.csr_code1=csr.csr_code1) LEFT JOIN csr_code2 ON csr.csr_code2=csr_code2.csr_code2 ) ";	
		sql += "WHERE csr_rnum=?";*/
		
		CSRDTO dto = new CSRDTO();
		String State="";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			ps.setString(1, csr_rnum);
			rs = ps.executeQuery();
			

			if (rs.next()) { // 결과가 있으면
				dto.setCSR_rnum(rs.getString("csr.csr_rnum"));
				dto.setM_code3_m_name(rs.getString("m_code3.m_name"));
				dto.setCSR_title(rs.getString("csr.csr_title"));
				
				if((rs.getString("csr_code1.csr_name")==null)) {
					dto.setCSR_code1_m_name("");
					dto.setCSR_code1("");
				}
				else{
					dto.setCSR_code1_m_name(rs.getString("csr_code1.csr_name"));
					dto.setCSR_code1(rs.getString("csr_code1.csr_code1"));
				}
				
				if((rs.getString("csr_system_category.csr_system_category_name")==null)) {
					dto.setCSR_system_category_m_name("");
					dto.setCSR_system_category("");
				}
				else{
					dto.setCSR_system_category_m_name(rs.getString("csr_system_category.csr_system_category_name"));
					dto.setCSR_system_category(rs.getString("csr_system_category.csr_system_category"));
				}
				
				dto.setCSR_requesttime(rs.getString("csr.csr_requesttime"));
				dto.setM_code1_m_name(rs.getString("m_code1.m_name"));
				dto.setM_code1(rs.getString("m_code1.m_code1"));
				dto.setM_code2_m_name(rs.getString("m_code2.m_name"));
				dto.setM_code2(rs.getString("m_code2.m_code2"));
				dto.setM_code3_m_name(rs.getString("m_code3.m_name"));
				dto.setM_code3(rs.getString("m_code3.m_code3"));
				dto.setCSR_linenum(rs.getString("csr.csr_linenum"));
				dto.setCSR_name(rs.getString("csr.csr_name"));
				dto.setMember_name(rs.getString("csr.csr_name"));
				dto.setCSR_detail(rs.getString("csr.csr_detail"));
				String digit_state = rs.getString("csr_state");
				if(digit_state.equals("0")) State="요청";
				else if(digit_state.equals("1")) State="해결중";
				else if(digit_state.equals("2")) State="해결";
				else if(digit_state.equals("3")) State="종료";
				dto.setCSR_state(State);
				dto.setCSR_digit_state(digit_state);
				
				dto.setCSR_previewer(rs.getString("csr_previewer"));
				dto.setCSR_solvingtime(rs.getString("csr_solvingtime"));
				dto.setCSR_estimate_solvetime(rs.getString("csr_estimate_solvetime"));
				dto.setCSR_preview_result(rs.getString("csr_preview_result"));
				

				dto.setCSR_dependentsystem_flag(rs.getString("csr_dependentsystem_flag"));
				dto.setCSR_dependentsystem(rs.getString("csr_dependentsystem"));
				

				dto.setCSR_solvedtime(rs.getString("csr_solvedtime"));
				dto.setCSR_reason(rs.getString("csr_reason"));
				dto.setCSR_processing_contents(rs.getString("csr_processing_contents"));
				dto.setCSR_estimate_md(rs.getString("csr_estimate_md"));
				dto.setCSR_complete_md(rs.getString("csr_complete_md"));

				dto.setCSR_client_comment(rs.getString("csr_client_comment"));
				dto.setCSR_finishtime(rs.getString("csr_finishtime"));
				
				// null이면 빈공백 삽입
				dto.setCSR_reason((rs.getString("csr.csr_reason") == null) ? "" : rs.getString("csr.csr_reason"));
				dto.setCSR_attachment(rs.getString("csr.csr_attachment"));
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
	
	public List<CSRDTO> searchCode() {
		List<CSRDTO> lists = new ArrayList<CSRDTO>();

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
				CSRDTO dto = new CSRDTO();
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
	public List<CSRDTO> searchCSR_Code() {
		List<CSRDTO> lists = new ArrayList<CSRDTO>();
		String sql = "SELECT * FROM CSR_CODE1 where csr_enable='1'";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		//String deptCheck = code + "%";
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) { // 결과가 있으면
				CSRDTO dto = new CSRDTO();
				dto.setCSR_code1(rs.getString("CSR_code1"));
				dto.setCSR_name(rs.getString("CSR_name"));
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
	
	public List<CSRDTO> getCSRCode1List() {
		List<CSRDTO> lists = new ArrayList<CSRDTO>();

		String sql = "SELECT * FROM csr_code1 WHERE `csr_code1` LIKE 'C1%' AND csr_enable='1'";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				CSRDTO dto = new CSRDTO();
				dto.setCSR_code1(rs.getString("csr_code1"));
				dto.setCSR_code1_m_name(rs.getString("csr_name"));
				
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
	
	public List<CSRDTO> getCSRSystemCategoryList() {
		List<CSRDTO> lists = new ArrayList<CSRDTO>();

		String sql = "SELECT * FROM csr_system_category WHERE `csr_system_category` LIKE 'C2%' AND csr_system_category_enable='1'";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				CSRDTO dto = new CSRDTO();
				dto.setCSR_system_category(rs.getString("csr_system_category"));
				dto.setCSR_system_category_m_name(rs.getString("csr_system_category_name"));
				
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
	
	
	
	public List<CSRDTO> getMCode1List() {
		List<CSRDTO> lists = new ArrayList<CSRDTO>();

		String sql = "SELECT m_code1, m_name FROM m_code1 WHERE m_enable='1'";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				CSRDTO dto = new CSRDTO();
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
		
	public List<CSRDTO> getMCode2List() {
		List<CSRDTO> lists = new ArrayList<CSRDTO>();

		String sql = "SELECT m_code1.m_code1, m_code1.m_name, m_code2.m_code2, m_code2.m_name FROM m_code1 INNER JOIN m_code2 ON m_code1.m_code1 = m_code2.m_code1;";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				CSRDTO dto = new CSRDTO();
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
	
	public List<CSRDTO> getMCode3List() {
		List<CSRDTO> lists = new ArrayList<CSRDTO>();

		String sql = "SELECT m_code1.m_code1, m_code1.m_name, m_code2.m_code2, m_code2.m_name, m_code3.m_code3, m_code3.m_name FROM m_code1 INNER JOIN (m_code2 INNER JOIN m_code3 ON m_code2.m_code2 = m_code3.m_code2) ON m_code1.m_code1 = m_code2.m_code1;";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				CSRDTO dto = new CSRDTO();
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
	
	
	// 관리자가 CSR 작성
	public boolean insertCSR(CSRDTO dto) {
		boolean result = false;
	
		/*
		 * csr_rnum 생성, csr_state = 0, csr_id는 현재 로그인한 사용자 아이디,  
		 */
		
		String sql = "INSERT INTO csr(csr_rnum, csr_state, csr_title, csr_detail, ";
		sql += "csr_system_category, csr_code1, csr_requesttime, ";
		sql += "csr_id, csr_name, csr_company, csr_place, csr_dept, csr_linenum, csr_enable) ";
		sql += "VALUES (?, '0', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, '1');"; 

		String sql_rnum = "SELECT csr_rnum FROM csr ORDER BY csr_rnum DESC;";
		String csr_rnum = null;
		
		Connection con = null;
		PreparedStatement ps = null; // 준비된 명령 무엇이? 위에 ??들을 채우겠다.
		ResultSet rs = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql_rnum);
			rs = ps.executeQuery();
			if (rs.next()) { // 결과가 있으면
				
				csr_rnum = rs.getString("csr_rnum");
				String[] split_code = csr_rnum.split("_");
				int temp = Integer.parseInt(split_code[1]);
				temp++;
				csr_rnum = split_code[0] +"_"+ String.format("%08d", temp);
			}
			
			/* ? 순서 : 총 12개
			   csr번호, 제목, 내용, 시스템구분, CSR유형, 요청시간, 
			   고객id, 고객명, 고객사, 사업장, 부서, 고객연락처
			 */			
			ps = con.prepareStatement(sql);
			ps.setString(1, csr_rnum);
			ps.setString(2, dto.getCSR_title());
			ps.setString(3, dto.getCSR_detail());
			ps.setString(4, dto.getCSR_system_category());
			ps.setString(5, dto.getCSR_code1());
			ps.setString(6, dto.getCSR_requesttime());
			ps.setString(7, dto.getCSR_id());
			ps.setString(8, dto.getMember_name());
			ps.setString(9, dto.getM_code1());
			ps.setString(10, dto.getM_code2());
			ps.setString(11, dto.getM_code3());
			ps.setString(12, dto.getCSR_linenum());
			
			
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
	
	public boolean updateCSR(CSRDTO dto) {
		boolean result = false;
		
		String sql = "UPDATE csr SET csr_title=?, csr_detail=?, csr_system_category=?, csr_code1=?, csr_company=?, csr_dept=?, csr_name=?, csr_linenum=?, ";
		
		
		if (dto.getCSR_state().equals("해결중")) {
			//	4개 : 사전검토참석자, 사전검토결과, 영향 받는 시스템 플래그, 영향받는시스템,
			sql += "csr_previewer=?, csr_estimate_solvetime=?, csr_preview_result=?, csr_dependentsystem_flag=?, csr_dependentsystem=?, " ;
			sql += ", csr_state=?";
			sql += ", csr_solvingtime=? ";
		}
		else if (dto.getCSR_state().equals("해결")) {
			//	4개 : CSR원인, 처리내용, 예상공수, 완료공수 
			sql += "csr_reason=?, csr_processing_contents=?, csr_estimate_md=?, csr_complete_md=? ";
			sql += ", csr_state=?";
			sql += ", csr_solvedtime=? ";
		}
		else if (dto.getCSR_state().equals("종료")) {
			sql += ", csr_state=?";
			sql += ", csr_finishtime=? ";
		}
		
		sql += "WHERE csr_rnum=?"; 
		
		Connection con = null;
		PreparedStatement ps = null;
		
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			
			/* parameter 순서. 공통부분 8개
			 제목, 요청내용, 시스템구분, csr유형, 고객사, 부서, 요청고객명, 고객연락처,
			 
			 */

			/* state 변화에 따라 추가부분. 2개
			 진행상태, {solvingtime | solvedtime | finishtime } *?

			/* 마지막 parameter 접수번호 */
		
			ps.setString(1, dto.getCSR_title());
			ps.setString(2, dto.getCSR_detail());
			ps.setString(3, dto.getCSR_system_category());
			ps.setString(4, dto.getCSR_code1());
			ps.setString(5, dto.getM_code1());
			ps.setString(6, dto.getM_code3());
			ps.setString(7, dto.getMember_name());
			ps.setString(8, dto.getCSR_linenum());
			
			
			int state = 0;
			
			if (dto.getCSR_state().equals("요청")) {
				ps.setString(9, dto.getCSR_rnum());
			}
			if (dto.getCSR_state().equals("해결중")) {
//				4개 : 사전검토참석자, 사전검토결과, 영향 받는 시스템 플래그, 영향받는시스템,
				state = 1;
				ps.setString(9, dto.getCSR_previewer());
				ps.setString(10, dto.getCSR_preview_result());
				ps.setString(11, dto.getCSR_dependentsystem_flag());
				ps.setString(12, dto.getCSR_dependentsystem());
				
				ps.setString(13, String.valueOf(state));
				ps.setString(14, dto.getCSR_solvingtime());
				ps.setString(15, dto.getCSR_rnum());
			}
			if (dto.getCSR_state().equals("해결")) {
//				4개 : CSR원인, 처리내용, 예상공수, 완료공수 
				state = 2;
				ps.setString(9, dto.getCSR_reason());
				ps.setString(10, dto.getCSR_processing_contents());
				ps.setString(11, dto.getCSR_estimate_md());
				ps.setString(12, dto.getCSR_complete_md());
				
				ps.setString(13, String.valueOf(state));
				ps.setString(14, dto.getCSR_solvedtime());
				ps.setString(15, dto.getCSR_rnum());
			}	
			if (dto.getCSR_state().equals("종료")) {
				state = 3;
				ps.setString(9, String.valueOf(state));
				ps.setString(10, dto.getCSR_finishtime());
				ps.setString(11, dto.getCSR_rnum());
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

	public ArrayList<String> getCSR_Code() {
		ArrayList<String> A_search = new ArrayList<String>();
		String sql = "SELECT csr_code1 from csr_code1 where csr_enable='1'";
		Connection con = null;
		PreparedStatement ps = null; // 준비된 명령 무엇이? 위에 ??들을 채우겠다.
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) { // 결과가 있으면
				A_search.add(rs.getString("csr_code1"));
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

	// 일반 고객이 CSR 작성
	public boolean insertUserCSR(CSRDTO dto) {
		boolean result = false;
	
		/*
		 * csr_rnum 생성, csr_state = 0, csr_id는 현재 로그인한 사용자 아이디,  
		 */
		
		String sql = "INSERT INTO csr(csr_rnum, csr_state, csr_title, csr_detail, ";
		sql += "csr_system_category, csr_code1, csr_requesttime, ";
		sql += "csr_id, csr_name, csr_company, csr_place, csr_dept, csr_linenum, csr_enable, csr_attachment) ";
		sql += "VALUES (?, '0', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, '1', ?);"; 

		String sql_rnum = "SELECT csr_rnum FROM csr ORDER BY csr_rnum DESC;";
		String csr_rnum = null;
		
		Connection con = null;
		PreparedStatement ps = null; // 준비된 명령 무엇이? 위에 ??들을 채우겠다.
		ResultSet rs = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql_rnum);
			rs = ps.executeQuery();
			if (rs.next()) { // 결과가 있으면
				
				csr_rnum = rs.getString("csr_rnum");
				if(csr_rnum == null)
					csr_rnum = "C_00000001";
				String[] split_code = csr_rnum.split("_");
				int temp = Integer.parseInt(split_code[1]);
				temp++;
				csr_rnum = split_code[0] +"_"+ String.format("%08d", temp);
			}
			
			/* ? 순서 : 총 12개
			   csr번호, 제목, 내용, 시스템구분, CSR유형, 요청시간, 
			   고객id, 고객명, 고객사, 사업장, 부서, 고객연락처
			 */			
			ps = con.prepareStatement(sql);
			ps.setString(1, csr_rnum);
			ps.setString(2, dto.getCSR_title());
			ps.setString(3, dto.getCSR_detail());
			ps.setString(4, dto.getCSR_system_category());
			ps.setString(5, dto.getCSR_code1());
			ps.setString(6, dto.getCSR_requesttime());
			ps.setString(7, dto.getCSR_id());
			ps.setString(8, dto.getMember_name());
			ps.setString(9, dto.getM_code1());
			ps.setString(10, dto.getM_code2());
			ps.setString(11, dto.getM_code3());
			ps.setString(12, dto.getCSR_linenum());
			ps.setString(13, dto.getCSR_attachment());
			
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
	public boolean updateCustomer_CSR(String FilePath,String CSR_rnum) {
		boolean result = false;
		
		String sql = "UPDATE csr SET csr_attachment=? WHERE csr_rnum=?";
	
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
			ps.setString(2, CSR_rnum);
			
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
	public boolean updateAdmin_CSR(String FilePath,String CSR_rnum) {
		boolean result = false;
		
		String sql = "UPDATE csr SET csr_attachment_engineer=? WHERE csr_rnum=?";
	
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
			ps.setString(2, CSR_rnum);
			
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
	
	//csr모두 보여주기_명훈
	public List<CSRDTO> showCSR(String csr_rnum, String SearchStartDay, String SearchEndDay, String SearchStartDay2, 
			String SearchEndDay2, String csr_category, String csr_place, String csr_dept,
			String code1, String state, String csr_company, String csr_name, String csr_title) {
		String sql = "SELECT csr.csr_rnum, csr.csr_state, csr.csr_title, csr.csr_previewer, csr.csr_detail, csr.csr_system_category, csr.csr_code1, csr.csr_requesttime ";
		sql += ", csr.csr_id, csr.csr_name, csr.csr_company, csr.csr_place, csr.csr_dept, csr.csr_linenum, csr.csr_enable, csr.csr_solvingtime, csr.csr_preview_result, csr.csr_dependentsystem, csr.csr_solvedtime, csr.csr_finishtime, csr.csr_reason, csr.csr_processing_contents, csr.csr_estimate_md, csr.csr_complete_md, csr.csr_client_comment ";
		
		sql += ", csr_code1.csr_name, csr_code1.csr_code1 ";
		sql += ", csr_system_category.csr_system_category_name, csr_system_category.csr_system_category "; 
		sql += ", m_code1.m_name, m_code1.m_code1, m_code2.m_name, m_code2.m_code2 ";
		sql += ", m_code3.m_name, m_code3.m_code3, csr.csr_estimate_solvetime ";
		sql += "FROM (((((m_code3 INNER JOIN csr ON m_code3.m_code3=csr.csr_dept) JOIN m_code1 ON csr.csr_company=m_code1.m_code1) JOIN m_code2 ON csr.csr_place = m_code2.m_code2) " +
				"LEFT JOIN csr_code1 ON csr_code1.csr_code1=csr.csr_code1 " +
				"LEFT JOIN csr_system_category ON csr_system_category.csr_system_category=csr.csr_system_category )) WHERE csr.csr_rnum = ";
		
		List<CSRDTO> lists = new ArrayList<CSRDTO>();			
		
		if(csr_rnum !=""){
			sql=sql+"'"+csr_rnum+"'";
		}
		else if(csr_rnum=="" && SearchStartDay!=""){
			
			/*sql = "SELECT csr.csr_rnum, csr.csr_state, csr.csr_title, csr.csr_detail, csr.csr_system_category, csr.csr_code1, csr.csr_requesttime ";
			sql += ", csr.csr_id, csr.csr_name, csr.csr_company, csr.csr_place, csr.csr_dept, csr.csr_linenum, csr.csr_enable ";
			
			sql += ", csr_code1.csr_name, csr_code1.csr_code1 ";
			sql += ", csr_system_category.csr_system_category_name, csr_system_category.csr_system_category "; */
			
			sql = "SELECT csr.csr_rnum, csr.csr_state, csr.csr_title, csr.csr_detail, csr.csr_system_category, " +
					"csr.csr_code1, csr.csr_requesttime, csr.csr_id, csr.csr_name, csr.csr_company, csr.csr_place, " +
					"csr.csr_dept, csr.csr_linenum, csr.csr_enable, csr.csr_previewer, csr.csr_solvingtime, " +
					"csr.csr_estimate_solvetime, csr.csr_preview_result, csr.csr_dependentsystem_flag, csr.csr_dependentsystem, " +
					"csr.csr_solvedtime, csr.csr_finishtime, csr.csr_reason, csr.csr_processing_contents, " +
					"csr.csr_estimate_md, csr.csr_complete_md, csr.csr_client_comment";
			sql += ", m_code1.m_name, m_code1.m_code1, m_code2.m_name, m_code2.m_code2 ";
			sql += ", m_code3.m_name, m_code3.m_code3, csr.csr_estimate_solvetime ";
			sql += ", csr_system_category.csr_system_category_name, csr_code1.csr_name ";
			
			sql += "FROM (((((m_code3 INNER JOIN csr ON m_code3.m_code3=csr.csr_dept) JOIN m_code1 ON csr.csr_company=m_code1.m_code1) JOIN m_code2 ON csr.csr_place = m_code2.m_code2) " +
					"LEFT JOIN csr_code1 ON csr_code1.csr_code1=csr.csr_code1 " +
					"LEFT JOIN csr_system_category ON csr_system_category.csr_system_category=csr.csr_system_category )) WHERE ";
		
			if(SearchStartDay!="" && SearchEndDay!=""){
				sql+=" DATE_FORMAT(csr.csr_requesttime,'%Y%m%d') BETWEEN "+SearchStartDay+"01" + " AND " + SearchEndDay+"31";
				
			}
			/*if(SearchStartDay2!="" && SearchEndDay2!="")
				sql+=" AND DATE_FORMAT(csr.csr_estimate_solvetime,'%Y%m%d') BETWEEN "+SearchStartDay+"01" + " AND " + SearchEndDay+"31";*/
			
			if(state!=""){
				sql+= " AND csr.csr_state="+"'"+state+"'";
				if(!state.equals("0")){
					if(SearchStartDay2!="" && SearchEndDay2!=""){
						sql+=" AND DATE_FORMAT(csr.csr_estimate_solvetime,'%Y%m%d') BETWEEN "+SearchStartDay+"01" + " AND " + SearchEndDay+"31";
					}
				}
				
			}
			if(!code1.equals("C1_0000"))
				sql+=" AND csr.csr_code1="+"'"+code1+"'";
			
			System.out.println(csr_rnum);
			
			if(csr_rnum !="")
				sql+=" AND csr.csr_rnum="+"'"+ csr_rnum +"'";
			
			if(!csr_category.equals("E_00000"))
				sql+=" AND csr.csr_system_category="+"'"+csr_category+"'";
			
			if(csr_title!=(""))
				sql+=" AND csr.csr_title like "+"'%"+csr_title+"%'";
			
			if (csr_company.equals("C_00000") && csr_place.equals("P_00000")
					&& csr_dept.equals("D_00000")) {
				
			} else if ((!csr_company.equals("C_00000")) && csr_place.equals("P_00000")) {
				sql += " AND csr.csr_company= " + "'" + csr_company + "'";
			} else if ((!csr_company.equals("C_00000"))
					&& (!csr_place.equals("P_00000")) && (csr_dept.equals("D_00000"))) {
				sql += " AND csr.csr_company= " + "'" + csr_company + "'" + "AND csr.csr_place= "
						+ "'" + csr_place + "'";
			} else {
				sql += " AND csr.csr_company= " + "'" + csr_company + "'"+" AND csr.csr_place= "
				+ "'" + csr_place + "'" + " AND csr.csr_dept= "
						+ "'" + csr_dept + "'"  ;
			}
			if(csr_name!="") 
				sql+= " AND csr.csr_name="+"'"+csr_name+"'";
			sql += " order by csr.csr_requesttime desc";
			
		}
		
		System.out.println(sql);
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			//ps.setString(1, deptCheck);
			rs = ps.executeQuery();
			while (rs.next()) { // 결과가 있으면
				CSRDTO dto = new CSRDTO();
				
	
				/*dto.setCSR_rnum(rs.getString("csr_rnum"));
				dto.setCSR_state(rs.getString("csr_state"));
				dto.setCSR_title(rs.getString("csr_title"));
				dto.setCSR_title(rs.getString("csr_detail"));
				dto.setCSR_system_category(rs.getString("csr_system_category"));
				dto.setCSR_system_category_m_name(rs.getString("csr_system_category.csr_system_category_name"));
				dto.setCSR_code1(rs.getString("csr_code1"));
				dto.setCSR_code1_m_name(rs.getString("csr_code1.csr_name"));
				dto.setCSR_requesttime(rs.getString("csr_requesttime"));
				dto.setMember_name(rs.getString("csr_id"));
				dto.setMember_name(rs.getString("csr_name"));
				dto.setM_code3_m_name(rs.getString("csr_company"));
				dto.setM_code2_m_name(rs.getString("m_code2.m_name"));
				dto.setM_code3_m_name(rs.getString("m_code3.m_name"));
				dto.setCSR_estimate_solvetime(rs.getString("csr_estimate_solvetime"));*/
				
				dto.setCSR_rnum(rs.getString("csr_rnum"));
				dto.setCSR_state(rs.getString("csr_state"));
				dto.setCSR_title(rs.getString("csr_title"));
				dto.setCSR_detail(rs.getString("csr_detail"));
				dto.setCSR_system_category(rs.getString("csr_system_category"));
				dto.setCSR_system_category_m_name(rs.getString("csr_system_category.csr_system_category_name"));
				dto.setCSR_code1(rs.getString("csr_code1"));
				dto.setCSR_code1_m_name(rs.getString("csr_code1.csr_name"));
				dto.setCSR_requesttime(rs.getString("csr_requesttime"));
				dto.setCSR_id(rs.getString("csr_id")); 
				dto.setMember_name(rs.getString("csr_name"));
				dto.setM_code1_m_name(rs.getString("m_code1.m_name"));
				dto.setM_code2_m_name(rs.getString("m_code2.m_name"));
				dto.setM_code3_m_name(rs.getString("m_code3.m_name"));
				dto.setCSR_linenum(rs.getString("csr_linenum"));
				  
				dto.setCSR_previewer(rs.getString("csr_previewer")); 
				dto.setCSR_solvingtime(rs.getString("csr_solvingtime"));
				dto.setCSR_estimate_solvetime(rs.getString("csr_estimate_solvetime")); 
				dto.setCSR_preview_result(rs.getString("csr_preview_result"));
				 
				dto.setCSR_dependentsystem(rs.getString("csr_dependentsystem"));
				  
				dto.setCSR_solvedtime(rs.getString("csr_solvedtime")); 
				dto.setCSR_finishtime(rs.getString("csr_finishtime"));
				dto.setCSR_reason(rs.getString("csr_reason")); 
				dto.setCSR_processing_contents(rs.getString("csr_processing_contents")); 
				dto.setCSR_estimate_md(rs.getString("csr_estimate_md")); 
				dto.setCSR_complete_md(rs.getString("csr_complete_md"));
				dto.setCSR_client_comment(rs.getString("csr_client_comment"));
							
			
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
	
	//CSR요청서 하단에 포함할 것_명훈
	public boolean receiveCSR(CSRDTO dto) { // 저장 성공시 true 실패시 false (이걸		

		boolean ok = false;
		String sql = "UPDATE csr SET csr_previewer = ?, " +
				"csr_solvingtime = ? ," +
				"csr_estimate_solvetime = ? ," +
				"csr_preview_result = ?, " +
				"csr_dependentsystem_flag = ?," +
				"csr_dependentsystem = ?, " +
				"csr_state = ? " +
				"where csr_rnum = ?";
		
		Connection con = null;
		PreparedStatement ps = null; // 준비된 명령 무엇이? 위에 ??들을 채우겠다.

		try {
			con = getCon();
			ps = con.prepareStatement(sql);

/*			Logger logger = Logger.getLogger( this.getClass() );
			logger.info("getCSR_previewer  : " + dto.getCSR_previewer());
			logger.info("solvingTime  : " + dto.getCSR_solvingtime());
			logger.info("estimate_solvetime  : " + dto.getCSR_estimate_solvetime());
			logger.info("getCSR_preview_result  : " +dto.getCSR_preview_result());
			logger.info("getCSR_dependentsystem_flag  : " +dto.getCSR_dependentsystem_flag());
			logger.info("getCSR_dependentsystem  : " +dto.getCSR_dependentsystem());
			logger.info("getCSR_rnum  : " +dto.getCSR_rnum());*/
			
			ps.setString(1, dto.getCSR_previewer());
			ps.setString(2, dto.getCSR_solvingtime());
			ps.setString(3, dto.getCSR_estimate_solvetime());
			ps.setString(4, dto.getCSR_preview_result());
			ps.setString(5, dto.getCSR_dependentsystem_flag());			
			
			if(dto.getCSR_dependentsystem_flag().equals("0")){
				ps.setString(6, dto.getCSR_dependentsystem());
			}else{
				ps.setString(6, "No");
			}
			ps.setString(7, "1"); // csr 상태값이 1인 해결중 상태로 변경!
			ps.setString(8, dto.getCSR_rnum());
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
	
	// CSR_rnum이 1인 경우 (1: 해결중  =>  2: 해결완료) => 이 함수 호출 후 해결완료로 상태 변경
	public boolean SolveCSR(CSRDTO dto)
	{
		boolean result = false;
		
		String sql = "UPDATE csr SET csr_solvedtime=?, csr_reason=?, csr_processing_contents=?," +
				"csr_estimate_md=?, csr_complete_md=?, csr_state=? WHERE csr_rnum=?";
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			
			con = getCon();
			ps = con.prepareStatement(sql);
			
			ps.setString(1, dto.getCSR_solvedtime()); // 해결완료시간
			ps.setString(2, dto.getCSR_reason()); // 원인			
			ps.setString(3, dto.getCSR_processing_contents()); // 처리내용
			ps.setString(4, dto.getCSR_estimate_md()); // 예상공수
			ps.setString(5, dto.getCSR_complete_md()); // 완료공수
			ps.setString(6, "2"); // csr 상태값이 2인 해결완료 상태로 변경!
			ps.setString(7, dto.getCSR_rnum()); // csr 상태값 => 1인 경우만 처리하기 위해..
			
			
			int cnt = ps.executeUpdate();
			
			if(cnt == 1) // 저장 OK
			{
				result = true;
			}
			else
			{
				result = false;
			}
		
		} catch (Exception e) {
			// TODO: handle exception
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

	// CSR_rnum이 2인 경우 (2: 해결완료 =>  3: 종료) => 이 함수 호출 후 종료로 상태 변경
	public boolean finishCSR(String csr_rnum, String csr_client_comment, String csr_finishtime)
	{
		boolean result = false;
		
		String sql = "UPDATE csr SET csr_client_comment=?, csr_finishtime=?, csr_state=?" +
				"WHERE csr_rnum=?";
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			
			con = getCon();
			ps = con.prepareStatement(sql);
			
			ps.setString(1, csr_client_comment); // 요청자 의견
			ps.setString(2, csr_finishtime); // 종료시간
			ps.setString(3, "3"); // csr 상태값 종료(3)로 변경
			ps.setString(4, csr_rnum); // csr 번호
			
			int cnt = ps.executeUpdate();
			
			if(cnt == 1) // 저장 OK
			{
				result = true;
			}
			else
			{
				result = false;
			}
			
		} catch (Exception e) {
			// TODO: handle exception
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

	
	//처리 상태 가져오는 메소드_명훈
	public List<CSRDTO> getStateList() {
		List<CSRDTO> lists = new ArrayList<CSRDTO>();

		String sql = "SELECT DISTINCT csr_state FROM csr ORDER BY csr.csr_state ASC";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // 결과가 있으면
				CSRDTO dto = new CSRDTO();
				dto.setCSR_state(rs.getString("csr_state"));
							
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
