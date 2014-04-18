<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.net.InetAddress"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>

<%  
	 long time = System.currentTimeMillis(); 
	 SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd");
	 String time_in = dayTime.format(new Date(time)); //시간까지 모두 출력
	 String[] arrTime_in = time_in.split("-");	
	 int year = Integer.parseInt(arrTime_in[0]);
	 int month = Integer.parseInt(arrTime_in[1]);;
	 int day = Integer.parseInt(arrTime_in[2]);;
	 String selected = "selected = 'selected'";	  
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
<script type="text/javascript">
	function check() {
		if (document.login.UserSabun.value == "") { // 아이디를 입력하지 않은 경우
			alert("ID를 입력하세요");
			document.login.UserSabun.focus(); // 커서를 넣는다
			return false;
		}
		if (document.login.UserPass.value == "") { // Password를 입력하지 않은 경우
			alert("PASSWORD를 입력하세요");
			document.login.UserPass.focus(); // 커서를 넣는다
			return false;
		}
	}
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>S-LITE</title>

</head>
<body>

<form name="login" action="login.jsp" method="post" onsubmit="return check()">
	<table height="100%" cellSpacing="0" cellPadding="0" width="100%" >
		<tr>
		<td>	
	<table align="center" height="100%" cellSpacing="0" cellPadding="0" width="100%" >
		<tr>
			<td vAlign="middle" align="center"><img src="images/log_logo.png" /><br>
			<table cellSpacing="0" cellPadding="0" width="390" border="0">
				<tr>
					<td style="height: 30px">&nbsp;</td>
				</tr>
				<tr>
					<td vAlign="top" height="70" align="center">
					<table align="right" cellSpacing="0" cellPadding="0" width="100" border="0">
							<tr>
								<td style="height: 10px">&nbsp;</td>
							</tr>
							<tr>
								<td><IMG src="images/id.gif"></td>
								<td><IMG src="images/blank_2px.gif" width="8"></td>
								<td><INPUT id="m_id" style="WIDTH: 180px; height: 30px; font-family: Gothic; font-size: 13pt;"
												type="text" name="m_id"></td>
							</tr>
							<tr>
								<td><IMG src="images/password.gif"></td>
								<td><IMG src="images/blank_2px.gif" width="8"></td>
								<td><INPUT id="m_pwd" style="WIDTH: 180px; height: 30px; font-family: Gothic; font-size: 13pt;"
												type="password" name="m_pwd"></td>
							</tr>
							<tr>
								<td style="height: 15px">&nbsp;</td>
							</tr>
					</table>
					</td>
					<td style="width: 3px">&nbsp;
					</td>
					<td>		
					<table border="0">
						<tr>
						<td align="right"><input type="hidden"
							id="img_select" name="img_select"></input> <input
							type="image" id="btn" value="in" src="images/btn_login.png">&nbsp;&nbsp;&nbsp;</td>
						</tr>
					</table>
					</td>
					</tr>		
		</table>
		</td>
		</tr>
	</table>
	</td>
	</tr>
	<tr>
	<td>
	<table cellSpacing="0" cellPadding="0" width="100%" border="0">
		<jsp:include page=".\bot.jsp" flush="true"></jsp:include>
	</table>
	</td>
	</tr>
</table>
</form>
</body>
</html>

