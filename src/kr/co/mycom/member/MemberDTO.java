package kr.co.mycom.member;

public class MemberDTO {

	private String m_id;
	private String m_name;
	private String m_pwd;
	private String m_company;
	private String m_place;
	private String m_dept;
	private String m_linenum;
	private String m_enable;
	private String m_master;
	private String m_engineer;
	
	public String getM_engineer() {
		return m_engineer;
	}
	public void setM_engineer(String mEngineer) {
		m_engineer = mEngineer;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getM_pwd() {
		return m_pwd;
	}
	public void setM_pwd(String m_pwd) {
		this.m_pwd = m_pwd;
	}
	public String getM_company() {
		return m_company;
	}
	public void setM_company(String m_company) {
		this.m_company = m_company;
	}
	public String getM_place() {
		return m_place;
	}
	public void setM_place(String m_place) {
		this.m_place = m_place;
	}
	public String getM_dept() {
		return m_dept;
	}
	public void setM_dept(String m_dept) {
		this.m_dept = m_dept;
	}
	public String getM_linenum() {
		return m_linenum;
	}
	public void setM_linenum(String m_linenum) {
		this.m_linenum = m_linenum;
	}
	public String getM_enable() {
		return m_enable;
	}
	public void setM_enable(String m_enable) {
		this.m_enable = m_enable;
	}
	public String getM_master() {
		return m_master;
	}
	public void setM_master(String m_master) {
		this.m_master = m_master;
	}
	@Override
	public String toString() {
		return "MemberDTO [m_company=" + m_company + ", m_dept=" + m_dept
				+ ", m_enable=" + m_enable + ", m_engineer=" + m_engineer
				+ ", m_id=" + m_id + ", m_linenum=" + m_linenum + ", m_master="
				+ m_master + ", m_name=" + m_name + ", m_place=" + m_place
				+ ", m_pwd=" + m_pwd + "]";
	}
	
	
}
