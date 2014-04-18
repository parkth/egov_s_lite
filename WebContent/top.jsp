<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String my_id = (String) session.getAttribute("ID");
	String my_name = (String) session.getAttribute("NAME");

	if(my_id == null || my_id.equals("null")){
		%>
			<script type = "text/javascript">
			alert("로그인하지 않으면 접근할 수 없습니다.");
			history.back();
			</script>
		<%
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>top</title>
<link rel="stylesheet" type="text/css" href="common.css" />

</head>
<body>
 
<table border="0" width="100%">
	<tr>
		<td align="center" valign="bottom" width="5%">
			<a href="masterpage.jsp"><img height="50px" src=".\images\top_logo.png" border="0"></a>
		</td>
		<td style="width: 20px" />
		</td>
		<td align="right" valign="bottom" width="20%">
		</td>	
	</tr>
</table>
</body>
</html>