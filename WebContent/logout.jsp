<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<script type ="text/javascript">
if(confirm("로그아웃 하시겠습니까?") != true){
	history.back();
}else
	{
	alert("로그아웃 하였습니다.");
	<%
	session.removeAttribute("ID");
	session.removeAttribute("NAME");
	%>
	location.href="index.jsp";
	}
</script>