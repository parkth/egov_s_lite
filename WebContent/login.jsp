<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="kr.co.mycom.member.*"%>
<%@ page import="java.util.*"%>
<%

	request.setCharacterEncoding("EUC-KR");
	String ID = (String) request.getParameter("m_id"); //사원번호
	String Pass = (String) request.getParameter("m_pwd");//비밀번호
	
	MemberDAO dao= new MemberDAO();
	MemberDTO dto = dao.searchMember(ID); 
 	
	//String my_name = new String(dto.getM_name().getBytes("8859_1"), "EUC-KR");
	String my_name = dto.getM_name();
	String master = dto.getM_master();
	boolean check = dao.CheckUser(ID, Pass);//로그인 체크

	if(check){
		session.setAttribute("ID", ID);
		session.setAttribute("NAME", my_name);
		session.setAttribute("Master", master);
		session.setMaxInactiveInterval(1200);
		
		response.sendRedirect("masterpage.jsp");	
	 }else{%>
<script type="text/javascript">
	alert("로그인을 실패하였습니다. 관리자에게 문의하세요.");
	history.back();
</script>
<%}%>