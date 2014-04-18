package kr.co.mycom.obstacle;

public class ObstacleDTO {
	private String o_rnum;
	private String o_state;
	
	private String o_title;
	private String o_code1; // 대분류
	private String o_code2; // 중분류
	private String code1_m_name; // code1 name o_code1_m_name으로..
	private String code2_m_name; // code2 name o_code2_m_name으로..
	
	private String o_a_name; // 장비명
	private String o_a_namecode;
	
	private String o_ograde;
	private String o_opath; // 접수경로
	
	private String o_vendorname;
	
	private String o_occurrencetime;
	private String o_requesttime;
	private String o_solvingtime;
	private String o_solvedtime;
	private String o_finishtime;
	
	private String o_id;
	private String m_code1; // 고객사코드
	private String m_code2; // 사업장코드
	private String m_code3;    // 부서코드
	private String m_code1_m_name; // 고객사이름
	private String m_code2_m_name; // 사업장이름
	private String m_code3_m_name; // 부서이름

	private String o_linenum;
	
	private String o_detail; // 장애현상
	private String o_attachment; // 첨부파일경로
	
	private String member_name; // 요청고객명
	
	private String o_reason;
	private String o_resolvedetail;
	private String o_engineer;
	private String o_requestdetail;
	private String o_attachment_engineer;
	
	// DTODG 에서 사용되던 것.
	private String dept;
	private String dept_name;
	private String enable;
	private String o_name;
	
	private String A_id;
	private String A_name;
	private String A_linenum;
	
	private String a_anum; // 자산번호
	
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String deptName) {
		dept_name = deptName;
	}
	public String getEnable() {
		return enable;
	}
	public void setEnable(String enable) {
		this.enable = enable;
	}
	public String getO_name() {
		return o_name;
	}
	public void setO_name(String oName) {
		o_name = oName;
	}
	public String getO_reason() {
		return o_reason;
	}
	public void setO_reason(String oReason) {
		o_reason = oReason;
	}
	public String getO_resolvedetail() {
		return o_resolvedetail;
	}
	public void setO_resolvedetail(String oResolvedetail) {
		o_resolvedetail = oResolvedetail;
	}
	public String getO_engineer() {
		return o_engineer;
	}
	public void setO_engineer(String oEngineer) {
		o_engineer = oEngineer;
	}
	public String getO_requestdetail() {
		return o_requestdetail;
	}
	public void setO_requestdetail(String oRequestdetail) {
		o_requestdetail = oRequestdetail;
	}

	public String getM_code1_m_name() {
		return m_code1_m_name;
	}
	public void setM_code1_m_name(String mCode1MName) {
		m_code1_m_name = mCode1MName;
	}
	public String getO_rnum() {
		return o_rnum;
	}
	public void setO_rnum(String oRnum) {
		o_rnum = oRnum;
	}
	public String getO_state() {
		return o_state;
	}
	public void setO_state(String oState) {
		o_state = oState;
	}
	public String getO_title() {
		return o_title;
	}
	public void setO_title(String oTitle) {
		o_title = oTitle;
	}
	public String getO_code1() {
		return o_code1;
	}
	public void setO_code1(String oCode1) {
		o_code1 = oCode1;
	}
	public String getO_code2() {
		return o_code2;
	}
	public void setO_code2(String oCode2) {
		o_code2 = oCode2;
	}
	public String getO_a_name() {
		return o_a_name;
	}
	public void setO_a_name(String oAName) {
		o_a_name = oAName;
	}
	public String getO_a_namecode() {
		return o_a_namecode;
	}
	public void setO_a_namecode(String oANamecode) {
		o_a_namecode = oANamecode;
	}
	public String getO_ograde() {
		return o_ograde;
	}
	public void setO_ograde(String oOgrade) {
		o_ograde = oOgrade;
	}
	public String getO_opath() {
		return o_opath;
	}
	public void setO_opath(String oOpath) {
		o_opath = oOpath;
	}
	public String getO_vendorname() {
		return o_vendorname;
	}
	public void setO_vendorname(String oVendorname) {
		o_vendorname = oVendorname;
	}
	public String getO_occurrencetime() {
		if(o_occurrencetime.length()==21)
			return o_occurrencetime.substring(0, 19);
		else
			return o_occurrencetime;
	}
	public void setO_occurrencetime(String oOccurrencetime) {
		o_occurrencetime = oOccurrencetime;
	}
	public String getO_requesttime() {
		if(o_requesttime.length() == 21)
			return o_requesttime.substring(0, 19);
		else
			return o_requesttime;
	}
	public void setO_requesttime(String oRequesttime) {
		o_requesttime = oRequesttime;
	}
	public String getO_solvingtime() {
		if(o_solvingtime.length() == 21)
			return o_solvingtime.substring(0, 19);
		else
			return o_solvingtime;
	}
	public void setO_solvingtime(String oSolvingtime) {
		o_solvingtime = oSolvingtime;
	}
	public String getO_solvedtime() {
		if(o_solvedtime.length() == 21)
			return o_solvedtime.substring(0, 19);
		else
			return o_solvedtime;
	}
	public void setO_solvedtime(String oSolvedtime) {
		o_solvedtime = oSolvedtime;
	}
	public String getO_finishtime() {
		if(o_finishtime.length() == 21)
			return o_finishtime.substring(0, 19);
		else
			return o_finishtime;
	}
	public void setO_finishtime(String oFinishtime) {
		o_finishtime = oFinishtime;
	}
	public String getO_id() {
		return o_id;
	}
	public void setO_id(String oId) {
		o_id = oId;
	}

	public String getM_code1() {
		return m_code1;
	}
	public void setM_code1(String mCode1) {
		m_code1 = mCode1;
	}
	public String getM_code2() {
		return m_code2;
	}
	public void setM_code2(String mCode2) {
		m_code2 = mCode2;
	}
	public String getM_code2_m_name() {
		return m_code2_m_name;
	}
	public void setM_code2_m_name(String mCode2MName) {
		m_code2_m_name = mCode2MName;
	}
	public String getM_code3() {
		return m_code3;
	}
	public void setM_code3(String mCode3) {
		m_code3 = mCode3;
	}
	public String getO_linenum() {
		return o_linenum;
	}
	public void setO_linenum(String oLinenum) {
		o_linenum = oLinenum;
	}
	public String getO_detail() {
		return o_detail;
	}
	public void setO_detail(String oDetail) {
		o_detail = oDetail;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String memberName) {
		member_name = memberName;
	}
	public String getCode1_m_name() {
		return code1_m_name;
	}
	public void setCode1_m_name(String code1MName) {
		code1_m_name = code1MName;
	}
	public String getCode2_m_name() {
		return code2_m_name;
	}
	public void setCode2_m_name(String code2MName) {
		code2_m_name = code2MName;
	}
	public String getM_code3_m_name() {
		return m_code3_m_name;
	}
	public void setM_code3_m_name(String mCode3MName) {
		m_code3_m_name = mCode3MName;
	}
	public String getO_attachment() {
		return o_attachment;
	}
	public void setO_attachment(String oAttachment) {
		o_attachment = oAttachment;
	}
	public String getO_attachment_engineer() {
		return o_attachment_engineer;
	}
	public void setO_attachment_engineer(String oAttachmentEngineer) {
		o_attachment_engineer = oAttachmentEngineer;
	}
	public String getA_id() {
		return A_id;
	}
	public void setA_id(String aId) {
		A_id = aId;
	}
	public String getA_name() {
		return A_name;
	}
	public void setA_name(String aName) {
		A_name = aName;
	}
	public String getA_linenum() {
		return A_linenum;
	}
	public void setA_linenum(String aLinenum) {
		A_linenum = aLinenum;
	}
	public String getA_anum() {
		return a_anum;
	}
	public void setA_anum(String aAnum) {
		a_anum = aAnum;
	}
	@Override
	public String toString() {
		return "ObstacleDTO [A_id=" + A_id + ", A_linenum=" + A_linenum
				+ ", A_name=" + A_name + ", a_anum=" + a_anum
				+ ", code1_m_name=" + code1_m_name + ", code2_m_name="
				+ code2_m_name + ", dept=" + dept + ", dept_name=" + dept_name
				+ ", enable=" + enable + ", m_code1=" + m_code1
				+ ", m_code1_m_name=" + m_code1_m_name + ", m_code2=" + m_code2
				+ ", m_code2_m_name=" + m_code2_m_name + ", m_code3=" + m_code3
				+ ", m_code3_m_name=" + m_code3_m_name + ", member_name="
				+ member_name + ", o_a_name=" + o_a_name + ", o_a_namecode="
				+ o_a_namecode + ", o_attachment=" + o_attachment
				+ ", o_attachment_engineer=" + o_attachment_engineer
				+ ", o_code1=" + o_code1 + ", o_code2=" + o_code2
				+ ", o_detail=" + o_detail + ", o_engineer=" + o_engineer
				+ ", o_finishtime=" + o_finishtime + ", o_id=" + o_id
				+ ", o_linenum=" + o_linenum + ", o_name=" + o_name
				+ ", o_occurrencetime=" + o_occurrencetime + ", o_ograde="
				+ o_ograde + ", o_opath=" + o_opath + ", o_reason=" + o_reason
				+ ", o_requestdetail=" + o_requestdetail + ", o_requesttime="
				+ o_requesttime + ", o_resolvedetail=" + o_resolvedetail
				+ ", o_rnum=" + o_rnum + ", o_solvedtime=" + o_solvedtime
				+ ", o_solvingtime=" + o_solvingtime + ", o_state=" + o_state
				+ ", o_title=" + o_title + ", o_vendorname=" + o_vendorname
				+ "]";
	}	
}
