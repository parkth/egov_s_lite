<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.member.*"%>

<%
	request.setCharacterEncoding("EUC-KR");
%>
<jsp:useBean id="member" class="kr.co.mycom.member.MemberDTO" />
<jsp:setProperty property="*" name="member" />
<%
String my_id = (String) session.getAttribute("ID");

if(my_id == null || my_id.equals("null")){
	%>
		<script type = "text/javascript">
		alert("로그인하지 않으면 접근할 수 없습니다.");
		history.back();
		</script>
	<%
}
	MemberDAO dao = new MemberDAO();
	boolean ok = dao.insertMember(member);
	if (ok) { // insert 성공
%>
<script type="text/javascript">
alert("사용자가 성공적으로 등록되었습니다. ");
self.close();
window.opener.location.href="../masterpage.jsp?bo_table=member_admin";
</script>
<%
	} else { // 실패
%>
<script type="text/javascript">
alert("실패하였습니다. 관리자에게 문의하세요.");
history.back();
</script>
<%
	
	}
%>
