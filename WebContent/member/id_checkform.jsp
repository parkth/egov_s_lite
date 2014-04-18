<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%String my_id = (String) session.getAttribute("ID");

if(my_id == null || my_id.equals("null")){
	%>
		<script type = "text/javascript">
		alert("로그인하지 않으면 접근할 수 없습니다.");
		history.back();
		</script>
	<%
} %>
<html>
<script type="text/javascript">
	function check() {
		var idPs=/^[a-z0-9_]{4,20}$/;  //아이디 비밀번호 체크표현식
		
		<!-- ID 체크 -->
		var idNum=document.idcheck_form.m_id.value.search(/[^(0-9)]/);
		var idEng=document.idcheck_form.m_id.value.search(/[^(a-z)]/);
		
		if (document.idcheck_form.m_id.value == "") {
			alert("ID를 입력하세요");
			document.idcheck_form.m_id.focus();
			return false;
		}
		if(document.idcheck_form.m_id.value.length<=5){
			alert("아이디는 6자 이상 입력하셔야 합니다.");
			document.idcheck_form.m_id.select();  //모두선택된 상태에서 focus
			return false;	
		}
		if(document.idcheck_form.m_id.value.length>12){
			alert("아이디는 12자 이상 입력할 수 없습니다.");
			document.idcheck_form.m_id.select();  //모두선택된 상태에서 focus
			return false;	
		}
		if(!idPs.test(document.idcheck_form.m_id.value)){
			alert("유효한 아이디 형식이 아닙니다.");
			document.idcheck_form.m_id.value="";  //id작성했던 값을 비워줌
			document.idcheck_form.m_id.focus();  //id focus이동
			return false;
		}
		if(idNum<0||idEng<0){
			  alert("아이디는 숫자와 영문자를 혼용하셔야 합니다.");
			  document.idcheck_form.m_id.select(); 
		  return false;
		}
		if(/(\w)\1\1\1/.test(document.idcheck_form.m_id.value)){
			  alert("아이디에 같은 문자를 4번 이상 사용할수 없습니다.");
			  document.idcheck_form.m_id.select();
		  return false;
		}
		
		return true;
	}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ID 확인 체크</title>
<link rel="stylesheet" type="text/css" href="../common.css" />
</head>
<body>
<form name="idcheck_form" action="id_check.jsp" method="post" onsubmit="return check()">
<table width="95%" align="center">
<tr>
<td align="left">● 사용자관리 ▶ ID 체크 확인</td>
<td align="right"><input type="submit" value="체크" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt"></input>
<input type="button" value="취소" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt" onclick="javascript:self.close();"></input></td>
</tr>
</table>
<table>
		<tr>
			<td style="height: 30px"></td>
		</tr>
	</table>
	<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
	<tr>
		<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">ID 체크 입력</font></td>
		<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
		<input type="text" id="m_id" name="m_id" style="width: 98%; font-family: Gothic; font-size: 9pt" maxlength="12"/>
	</td>
	</table>
	</form>
</body>
</html>