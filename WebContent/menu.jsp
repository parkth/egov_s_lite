<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="common.css" />
<script language="javascript">
		function id_logout()
		{
			if(confirm("로그아웃 하시겠습니까?") == true){
				alert("로그아웃 하였습니다.");
				location.href="logout.jsp";
			}
		}
</script>
</head>
<body>
<%
	String my_id = (String) session.getAttribute("ID");
	String my_name = (String) session.getAttribute("NAME");
	String master= (String) session.getAttribute("Master");

	if(my_id == null || my_id.equals("null")){
		%>
			<script type = "text/javascript">
			alert("로그인하지 않으면 접근할 수 없습니다.");
			history.back();
			</script>
		<%
	}
%>


<table id="Table_01" width="150" border="0" cellpadding="0" cellspacing="0">

<tr>
<td align="center">
<font color="000000"><%=my_name %>님 좋은 하루 되세요</font>
<a href="./masterpage.jsp?bo_table=updateform"><img src="images/btn_info.png" width="40" height="17" border="0"></a>
<a href="javascript:id_logout()"><img src="images/btn_logout.png" width="40" height="16" border="0"></a><br><br>
</td>
</tr>
	<%if(master.equals("1")){ %>
	<tr>
		<td>
			<img src="images/category_04.png" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=D001"><img src="images/category_05.png" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=D002"><img src="images/category_06.png" alt="" border="0"></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=D004"><img src="images/category_07.png" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=D005"><img src="images/category_08.png" alt="" border="0"></a></td>
	</tr>
	
	<tr>
		<td>
			<img src="images/category_12.png" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=E001"><img src="images/category_13.png" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=E002"><img src="images/category_14.png" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="images/category_01.png" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=C001"><img src="images/category_02.png" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=C002"><img src="images/category_03.png" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=C001_excel"><img src="images/category_15.png" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="images/category_09.png" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=member_admin"><img src="images/category_10.png" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=code"><img src="images/category_11.png" width="150" alt="" border="0"></a></td>
	</tr>
	<% } %>
	
	<%if(master.equals("0")){ %>
	<tr>
		<td>
			<img src="images/category_04.png" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=D001"><img src="images/category_05.png" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=D002"><img src="images/category_06.png" alt="" border="0"></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=D004"><img src="images/category_07.png" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=D005"><img src="images/category_08.png" alt="" border="0"></a></td>
	</tr>
	
	<tr>
		<td>
			<img src="images/category_12.png" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=E001"><img src="images/category_13.png" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=E002"><img src="images/category_14.png" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="images/category_01.png" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=C001"><img src="images/category_02.png" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=C002"><img src="images/category_03.png" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="./masterpage.jsp?bo_table=C001_excel"><img src="images/category_15.png" alt="" border="0"></a></td>
	</tr>
	<% } %>
</table>
</body>
</html>