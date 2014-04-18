package kr.co.mycom.csr;

public class CSRDTO {
	private String csr_rnum;
	private String csr_state;
	private String csr_digit_state;

	private String csr_title;
	private String csr_detail; // 요청내용
	private String csr_system_category; // 시스템구분
	private String csr_system_category_m_name; 
	private String csr_code1; // csr유형
	private String csr_code1_m_name; 
	
	private String csr_requesttime;
	private String csr_solvingtime;
	private String csr_solvedtime;
	private String csr_finishtime;
	
	private String csr_id;// 요청고객id
	private String member_name; // 요청고객명
	private String m_code1; // 고객사코드
	private String m_code2; // 사업장코드
	private String m_code3;    // 부서코드
	private String m_code1_m_name; // 고객사이름
	private String m_code2_m_name; // 사업장이름
	private String m_code3_m_name; // 부서이름

	private String csr_linenum;
	
	private String csr_previewer;
	private String csr_estimate_solvetime;
	private String csr_preview_result;
	
	private String csr_dependentsystem_flag;
	private String csr_dependentsystem;	
	
	private String csr_reason;
	private String csr_processing_contents;
	private String csr_estimate_md;
	private String csr_complete_md;

	private String csr_client_comment;
	
	// DTODG 에서 사용되던 것.
	private String dept;
	private String dept_name;
	private String enable;
	private String csr_name;
	
	private String csr_attachment;
	private String csr_attachment_engineer;
	
	


	public String getCSR_rnum() {
		return csr_rnum;
	}


	public void setCSR_rnum(String csr_rnum) {
		this.csr_rnum = csr_rnum;
	}

	public String getCSR_digit_state() {
		return csr_digit_state;
	}


	public void setCSR_digit_state(String csr_digit_state) {
		this.csr_digit_state = csr_digit_state;
	}

	
	public String getCSR_state() {
		return csr_state;
	}


	public void setCSR_state(String csr_state) {
		this.csr_state = csr_state;
	}


	public String getCSR_title() {
		return csr_title;
	}


	public void setCSR_title(String csr_title) {
		this.csr_title = csr_title;
	}


	public String getCSR_detail() {
		return csr_detail;
	}


	public void setCSR_detail(String csr_detail) {
		this.csr_detail = csr_detail;
	}

	public String getCSR_system_category() {
		return csr_system_category;
	}


	public void setCSR_system_category(String csr_system_category) {
		this.csr_system_category = csr_system_category;
	}

	public String getCSR_system_category_m_name() {
		return csr_system_category_m_name;
	}


	public void setCSR_system_category_m_name(String csr_system_category_m_name) {
		this.csr_system_category_m_name = csr_system_category_m_name;
	}


	
	public String getCSR_code1() {
		return csr_code1;
	}


	public void setCSR_code1(String csr_code1) {
		this.csr_code1 = csr_code1;
	}


	public String getCSR_code1_m_name() {
		return csr_code1_m_name;
	}


	public void setCSR_code1_m_name(String csr_code1_m_name) {
		this.csr_code1_m_name = csr_code1_m_name;
	}


	public String getEnable() {
		return enable;
	}


	public void setEnable(String enable) {
		this.enable = enable;
	}


	public String getCSR_requesttime() {
		if(csr_requesttime == null)
			return csr_requesttime;
		else if(csr_requesttime.length() == 21)
			return csr_requesttime.substring(0, 19);
		else 
			return csr_requesttime;
	}


	public void setCSR_requesttime(String csr_requesttime) {
		this.csr_requesttime = csr_requesttime;
	}


	public String getCSR_solvingtime() {
		if(csr_solvingtime == null)
			return csr_solvingtime;
		else if(csr_solvingtime.length() == 21)
			return csr_solvingtime.substring(0, 19);
		else
			return csr_solvingtime;
	}


	public void setCSR_solvingtime(String csr_solvingtime) {
		this.csr_solvingtime = csr_solvingtime;
	}


	public String getCSR_solvedtime() {
		if(csr_solvedtime == null)
			return csr_solvedtime;
		else if(csr_solvedtime.length() ==21)
			return csr_solvedtime.substring(0, 19);
		else
			return csr_solvedtime;
	}


	public void setCSR_solvedtime(String csr_solvedtime) {
		this.csr_solvedtime = csr_solvedtime;
	}


	public String getCSR_finishtime() {
		if(csr_finishtime == null)
			return csr_finishtime;
		else if(csr_finishtime.length() ==21)
			return csr_finishtime.substring(0, 19);
		return csr_finishtime;
	}


	public void setCSR_finishtime(String csr_finishtime) {
		this.csr_finishtime = csr_finishtime;
	}


	public String getCSR_id() {
		return csr_id;
	}


	public void setCSR_id(String csr_id) {
		this.csr_id = csr_id;
	}


	public String getMember_name() {
		return member_name;
	}


	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}


	public String getM_code1() {
		return m_code1;
	}


	public void setM_code1(String m_code1) {
		this.m_code1 = m_code1;
	}


	public String getM_code2() {
		return m_code2;
	}


	public void setM_code2(String m_code2) {
		this.m_code2 = m_code2;
	}


	public String getM_code3() {
		return m_code3;
	}


	public void setM_code3(String m_code3) {
		this.m_code3 = m_code3;
	}


	public String getM_code1_m_name() {
		return m_code1_m_name;
	}


	public void setM_code1_m_name(String m_code1_m_name) {
		this.m_code1_m_name = m_code1_m_name;
	}


	public String getM_code2_m_name() {
		return m_code2_m_name;
	}


	public void setM_code2_m_name(String m_code2_m_name) {
		this.m_code2_m_name = m_code2_m_name;
	}


	public String getM_code3_m_name() {
		return m_code3_m_name;
	}


	public void setM_code3_m_name(String m_code3_m_name) {
		this.m_code3_m_name = m_code3_m_name;
	}


	public String getCSR_linenum() {
		return csr_linenum;
	}


	public void setCSR_linenum(String csr_linenum) {
		this.csr_linenum = csr_linenum;
	}


	public String getCSR_previewer() {
		return csr_previewer;
	}


	public void setCSR_previewer(String csr_previewer) {
		this.csr_previewer = csr_previewer;
	}


	public String getCSR_estimate_solvetime() {
		if(csr_estimate_solvetime == null)
			return csr_estimate_solvetime;
		else if(csr_estimate_solvetime.length() ==21)
			return csr_estimate_solvetime.substring(0, 19);
		else
			return csr_estimate_solvetime;
	}


	public void setCSR_estimate_solvetime(String csr_estimate_solvetime) {
		this.csr_estimate_solvetime = csr_estimate_solvetime;
	}


	public String getCSR_preview_result() {
		return csr_preview_result;
	}


	public void setCSR_preview_result(String csr_preview_result) {
		this.csr_preview_result = csr_preview_result;
	}


	public String getCSR_dependentsystem_flag() {
		return csr_dependentsystem_flag;
	}


	public void setCSR_dependentsystem_flag(String csr_dependentsystem_flag) {
		this.csr_dependentsystem_flag = csr_dependentsystem_flag;
	}


	public String getCSR_dependentsystem() {
		return csr_dependentsystem;
	}


	public void setCSR_dependentsystem(String csr_dependentsystem) {
		this.csr_dependentsystem = csr_dependentsystem;
	}


	public String getCSR_reason() {
		return csr_reason;
	}


	public void setCSR_reason(String csr_reason) {
		this.csr_reason = csr_reason;
	}


	public String getCSR_processing_contents() {
		return csr_processing_contents;
	}


	public void setCSR_processing_contents(String csr_processing_contents) {
		this.csr_processing_contents = csr_processing_contents;
	}


	public String getCSR_estimate_md() {
		return csr_estimate_md;
	}


	public void setCSR_estimate_md(String csr_estimate_md) {
		this.csr_estimate_md = csr_estimate_md;
	}


	public String getCSR_complete_md() {
		return csr_complete_md;
	}


	public void setCSR_complete_md(String csr_complete_md) {
		this.csr_complete_md = csr_complete_md;
	}


	public String getDept() {
		return dept;
	}


	public void setDept(String dept) {
		this.dept = dept;
	}


	public String getDept_name() {
		return dept_name;
	}


	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}


	public String getCSR_name() {
		return csr_name;
	}


	public void setCSR_name(String csr_name) {
		this.csr_name = csr_name;
	}


	public String getCSR_client_comment() {
		return csr_client_comment;
	}


	public void setCSR_client_comment(String csr_client_comment) {
		this.csr_client_comment = csr_client_comment;
	}
	
	public String getCSR_attachment() {
		return csr_attachment;
	}
	
	public void setCSR_attachment(String csrAttachment) {
		csr_attachment = csrAttachment;
	}
	
	public String getCsr_attachment_engineer() {
		return csr_attachment_engineer;
	}


	public void setCsr_attachment_engineer(String csr_attachment_engineer) {
		this.csr_attachment_engineer = csr_attachment_engineer;
	}

	@Override
	public String toString() {
		return "CSRDTO [csr_code1_m_name=" + csr_code1_m_name
				+ ", dept=" + dept + ", dept_name=" + dept_name
				+ ", enable=" + enable
				+ ", m_code1=" + m_code1
				+ ", m_code1_m_name=" + m_code1_m_name
				+ ", m_code2=" + m_code2
				+ ", m_code2_m_name=" + m_code2_m_name
				+ ", m_code3=" + m_code3
				+ ", m_code3_m_name=" + m_code3_m_name
				+ ", member_name=" + member_name 
				+ ", csr_rnum=" + csr_rnum
				+ ", csr_state=" + csr_state
				+ ", csr_title=" + csr_title
				+ ", csr_detail=" + csr_detail
				+ ", csr_code1=" + csr_code1
				+ ", csr_requesttime=" + csr_requesttime
				+ ", csr_solvedtime=" + csr_solvedtime
				+ ", csr_solvingtime=" + csr_solvingtime
				+ ", csr_finishtime=" + csr_finishtime
				+ ", csr_id=" + csr_id
				+ ", csr_linenum=" + csr_linenum
				+ ", csr_name=" + csr_name

				+ ", csr_previewer=" + csr_previewer
				+ ", csr_estimate_solvetime=" + csr_estimate_solvetime
				+ ", csr_preview_result=" + csr_preview_result
				
				+ ", csr_dependentsystem_flag=" + csr_dependentsystem_flag
				+ ", csr_dependentsystem=" + csr_dependentsystem
				
				+ ", csr_reason=" + csr_reason
				+ ", csr_reason=" + csr_processing_contents
				+ ", csr_reason=" + csr_estimate_md
				+ ", csr_reason=" + csr_complete_md
				+ ", csr_client_comment=" + csr_client_comment+ "]";
	}	
}
