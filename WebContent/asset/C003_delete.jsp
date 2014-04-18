<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import ="kr.co.mycom.asset.*"%>
<%@ page import="java.util.*"%>
    <%
    	request.setCharacterEncoding("EUC-KR");
    %>
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

String master = (String) session.getAttribute("Master");

if(!master.equals("1")){
	%>
		<script type = "text/javascript">
		alert("관리자가 아니면 접근할 수 없습니다.");
		history.back();
		</script>
	<%
}

	AssetDAO dao = new AssetDAO();
	boolean check = dao.deleteAsset(request.getParameter("a_anum"));
	if (check) { // insert 성공
		%>
		<script type="text/javascript">
			alert("자산이 성공적으로 삭제되었습니다. ");
			self.close();
			window.opener.location.href="../masterpage.jsp?bo_table=C002";
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