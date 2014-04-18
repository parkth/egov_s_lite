package kr.co.mycom.member;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import kr.co.mycom.security.DataEncrypt;


public class MemberDAO {
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
	
	public boolean CheckUser(String ID, String Pass) {

		DataEncrypt dataEncrpyt = new DataEncrypt();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int enable=1;
		boolean result = false;
		String sql = "SELECT COUNT(*) cnt FROM member WHERE m_id=? AND m_pwd=? AND m_enable=?";
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			ps.setString(1, ID);
			//ps.setString(2, dataEncrpyt.encrypt(Pass));
			ps.setString(2, Pass);
			System.out.println(Pass);
			ps.setString(3, Integer.toString(enable));

			rs = ps.executeQuery();
			if (rs.next()) { // ��� ������
				System.out.println(rs.getInt("cnt"));				
				if (rs.getInt("cnt") == 1) {
					result = true;
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
		return result;
	}
	

	public boolean insertMember(MemberDTO dto) throws UnsupportedEncodingException { 
		boolean ok = false;
		String sql = "INSERT INTO member (m_id, m_name, m_pwd, m_company, m_place, m_dept, m_linenum, m_enable, m_master)" +
				"VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";	// TOOL
	
		DataEncrypt dataEncrpyt = new DataEncrypt();
		String m_name = new String(dto.getM_name());
		String m_id = new String(dto.getM_id());

		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);

			ps.setString(1, m_id);
			ps.setString(2, m_name);
			ps.setString(3, dataEncrpyt.encrypt(dto.getM_pwd()));
			ps.setString(4, dto.getM_company());
			ps.setString(5, dto.getM_place());
			ps.setString(6, dto.getM_dept());
			ps.setString(7, dto.getM_linenum());
			if(dto.getM_enable() == null){
				ps.setString(8, "0");				
			} else{
				ps.setString(8, "1");
			}
			
			System.out.println(dto.getM_master());
			if(dto.getM_master() == null && dto.getM_engineer() == null){
				ps.setString(9, "0");				
			} else if(dto.getM_engineer() == null){
				ps.setString(9, "1");
			} else ps.setString(9, "2");
			
			int cnt = ps.executeUpdate(); // insert, update, delete, select :
			// executeQuery() �޼ҵ� ���
			if (cnt == 1)
				ok = true; // executeUpdate �� �����ϸ� 1�� ��ȯ�Ѵ�.
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
		return ok; // �����ϸ� true, �����ϸ� false ����
	}
	
	public boolean idcheck(String id) {
		boolean ok = false;
		String sql = "select count(*) cnt from member where m_id=?";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if (rs.next()) { // ��� ������
				int cnt = rs.getInt("cnt");
				if (cnt == 1)
					ok = true;
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
		return ok;
	}
	

	public MemberDTO searchMember(String m_id) { 
		MemberDTO dto = new MemberDTO();

		String sql = "SELECT * from member where m_id = ?";	// TOOL
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			ps.setString(1, m_id);
			rs = ps.executeQuery();

			if(rs.next()) { // ��� ������
				
			dto.setM_id(rs.getString("m_id"));
			dto.setM_name(rs.getString("m_name"));
			//System.out.println("searchMember method, name: "+rs.getString("m_name"));
			dto.setM_pwd(rs.getString("m_pwd"));
			dto.setM_company(rs.getString("m_company"));
			dto.setM_place(rs.getString("m_place"));
			dto.setM_dept(rs.getString("m_dept"));
			dto.setM_linenum(rs.getString("m_linenum"));
			dto.setM_enable(rs.getString("m_enable"));
			dto.setM_master(rs.getString("m_master"));
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
	
	public boolean updateMember(MemberDTO dto, String changepwd) {
		boolean ok = false;
		String sql = "update member" + " set" + " m_name = ? " + ",m_company = ?"
						+ ",m_place=?" + ",m_dept=?" + ",m_linenum=?" + ",m_enable=?" + ",m_master=?";
		DataEncrypt dataEncrpyt = new DataEncrypt();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = getCon();
			if (changepwd != "") {
				sql = sql + ",m_pwd=" + "'" + dataEncrpyt.encrypt(changepwd)+ "'";
			} 
			sql = sql + " where m_id=?";
			ps = con.prepareStatement(sql);
			
			ps.setString(1, dto.getM_name());
			ps.setString(2, dto.getM_company());
			ps.setString(3, dto.getM_place());
			ps.setString(4, dto.getM_dept());
			ps.setString(5, dto.getM_linenum());
			if(dto.getM_enable() == null){
				ps.setString(6, "0");				
			} else{
				ps.setString(6, "1");
			}
			if(dto.getM_master() == null && dto.getM_engineer() == null){
				ps.setString(7, "0");				
			} else if(dto.getM_engineer() == null){
				ps.setString(7, "1");
			} else ps.setString(7, "2");
			
			ps.setString(8, dto.getM_id());
			int cnt =ps.executeUpdate();	
			if(cnt==1)
				ok = true; // ���� ok
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
		return ok;
	}
	
	 public List<MemberDTO> admin_Member(String m_company, String m_place, String m_dept) throws UnsupportedEncodingException{
     List<MemberDTO> lists = new ArrayList<MemberDTO>();
     
     
     Connection con = null;
	 PreparedStatement ps = null;
	 ResultSet rs = null;
    
	 String sql = "SELECT member.m_id, member.m_name, member.m_linenum, m_code1.m_name, m_code2.m_name, m_code3.m_code3, m_code3.m_name, member.m_enable, member.m_master FROM member INNER JOIN (m_code1 INNER JOIN (m_code2 INNER JOIN m_code3 ON m_code2.m_code2 = m_code3.m_code2) ON m_code1.m_code1 = m_code2.m_code1) ON member.m_dept = m_code3.m_code3";
     String sql_condition = "SELECT member.m_id, member.m_name, member.m_linenum, m_code1.m_name, m_code2.m_name, m_code3.m_code3, m_code3.m_name, member.m_enable, member.m_master FROM member INNER JOIN (m_code1 INNER JOIN (m_code2 INNER JOIN m_code3 ON m_code2.m_code2 = m_code3.m_code2) ON m_code1.m_code1 = m_code2.m_code1) ON member.m_dept = m_code3.m_code3 where ";
     
     String company = null;
     String place = null;
     String dept = null;
     int condition_count = 0;

     if(m_company != null && !m_company.equals("C_00000"))
     {
         company = new String(m_company.getBytes("8859_1"), "EUC-KR");
         if(condition_count > 0) sql_condition = sql_condition + " AND ";
             sql_condition = sql_condition + "m_code1.m_code1 = '" + company + "'";
         condition_count++;
     }
     
     if(m_place != null && !m_place.equals("P_00000"))
     {
         place = new String(m_place.getBytes("8859_1"), "EUC-KR");
         if(condition_count > 0) sql_condition = sql_condition + " AND ";
         sql_condition = sql_condition + "m_code2.m_code2 = '" + place + "'";
         condition_count++;
     }
     if(m_dept != null && !m_dept.equals("D_00000"))
     {
         dept = new String(m_dept.getBytes("8859_1"), "EUC-KR");
         if(condition_count > 0) sql_condition = sql_condition + " AND ";
         sql_condition = sql_condition + "m_code3.m_code3 = '" + dept + "'";
         condition_count++;
     }
     
     sql_condition = sql_condition + " GROUP BY member.m_id";
     
    // System.out.println(sql_condition.toString());
     try {
         con = getCon();
         if(condition_count == 0) ps = con.prepareStatement(sql);
         else ps = con.prepareStatement(sql_condition);
         
         rs = ps.executeQuery();

         while(rs.next())
         {
        	 MemberDTO dto = new MemberDTO();
        	 
             dto.setM_id(rs.getString("m_id"));
             dto.setM_name(rs.getString("m_name"));
             dto.setM_company(rs.getString("m_code1.m_name"));
             dto.setM_place(rs.getString("m_code2.m_name"));
             dto.setM_dept(rs.getString("m_code3.m_name"));
             dto.setM_linenum(rs.getString("m_linenum"));
             dto.setM_enable(rs.getString("m_enable"));
             dto.setM_master(rs.getString("m_master"));
             
             lists.add(dto);
         }
     }
     catch (Exception e) {
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
     return lists;
 }
	 
	 public List<MemberDTO> search_mname() {
			List<MemberDTO> lists = new ArrayList<MemberDTO>();

			String sql = "SELECT m_id, m_name, m_dept FROM member";
			Connection con = null;
			PreparedStatement ps = null;
			ResultSet rs = null;

			try {
				con = getCon();
				ps = con.prepareStatement(sql);
				rs = ps.executeQuery();

				while (rs.next()) { // ��� ������
					MemberDTO dto = new MemberDTO();
					dto.setM_id(rs.getString("m_id"));
					dto.setM_name(rs.getString("m_name"));
					dto.setM_dept(rs.getString("m_dept"));
					
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
	 
	 public boolean check_licnece()
	 {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			String SystemDate = formatter.format(new Date());
			String ExpireDate = "2015-12-31";
			
			if(Integer.parseInt(SystemDate.substring(0,4)) < Integer.parseInt(ExpireDate.substring(0,4)) &&
			   Integer.parseInt(SystemDate.substring(5,7)) < Integer.parseInt(ExpireDate.substring(5,7)) &&
			   Integer.parseInt(SystemDate.substring(8,10)) < Integer.parseInt(ExpireDate.substring(8,10)))
				return true;
			
			return false;
	 }
	
}

