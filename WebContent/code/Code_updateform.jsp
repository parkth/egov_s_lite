<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.code.*"%>
<%@ page import="kr.co.mycom.asset.*"%>
<%@ page import="java.util.List"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript">
function check(){
    var code_name = document.getElementById("code_name");
    code_name.value += " "; 
}
</script>
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
String update_code = request.getParameter("update_code") + " ";
String sub_code = update_code.substring(0,2);

String dis_cboCode1 = request.getParameter("cboCode1");
String dis_cboCode2 = request.getParameter("cboCode2");
String dis_cboCode3 = request.getParameter("cboCode3");
String send_cboCode = request.getParameter("send_cboCode");

String code_name = new String(request.getParameter("code_name").getBytes("Cp1252"), "EUC-KR");
code_name+= " ";
String code_enable = request.getParameter("code_enable");
String selected = "selected = 'selected'";

CodeDTO code_dto = new CodeDTO();
CodeDAO l_code_dao = new CodeDAO();

String l_detail = null;
String l_company = null;
if(dis_cboCode1.equals("l_code")){
code_dto = l_code_dao.search_lcode1(update_code);

l_detail = code_dto.getL_detail();
l_company = code_dto.getL_company();

}

if(dis_cboCode1 == null || dis_cboCode1.equals("null")){
	dis_cboCode1 = "a_code";
}
if(dis_cboCode2 == null || dis_cboCode2.equals("null")){
	dis_cboCode2 = "ALL";
}
if(dis_cboCode3 == null || dis_cboCode3.equals("null")){
	//dis_cboCode3 = "ALL";
}

String checked = "checked = 'checked'";

AssetDAO code_dao = new AssetDAO();

String master = (String) session.getAttribute("Master");

if(master.equals("0")){
	%>
		<script type = "text/javascript">
		alert("관리자가 아니면 접근할 수 없습니다.");
		history.back();
		</script>
	<%
}
%>

<title>S-LITE</title>
<link rel="stylesheet" type="text/css" href="../common.css" />
</head>
<body style="margin: 0px">
<form name="frm1" method="post" action="Code_update.jsp" onsubmit="return check();">
<table width="95%" align="center">
<tr>
<td align="left">● 코드관리 ▶ 코드수정</td>
<td align="right"><input type="submit" value="코드수정" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt"></input>
</td></tr>
</table>
<center>
<table>
	<tr>
		<td style="height: 30px"></td>
	</tr>
</table>
	<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
		<tr>
		<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">관련분야</font></td>
		<td width="15%" colspan="3" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
			<select id="dis_cboCode1" name="dis_cboCode1" style="width: 100%; font-family: Gothic; font-size: 9pt" disabled>
				<option value="a_code" <%=(dis_cboCode1.equals("a_code") == true ? selected : "")%>>자산관련</option>
				<option value="o_code" <%=(dis_cboCode1.equals("o_code") == true ? selected : "")%>>장애관련</option>
				<option value="m_code" <%=(dis_cboCode1.equals("m_code") == true ? selected : "")%>>회사관련</option>
				<option value="l_code" <%=(dis_cboCode1.equals("l_code") == true ? selected : "")%>>등급관련</option>
			</select>
		</td>
		</tr>
		<tr>
		<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">코드이름</font></td>
		<td width="20%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
			<input type="text" id="code_name" name="code_name" value=<%=code_name %> style="width: 99%; font-family: Gothic; font-size: 9pt" />
		</td>
		<td width="10%" colspan="2" align="center" style="padding-center: 10px;" bgcolor="ffffff">
			사용여부<input type="checkbox" name="code_enable" id="code_enable" size="12" style="font-family: Gothic; font-size: 9pt" <%=(code_enable.equals("1") == true ? checked : "")%>>
		<input type="hidden" name="cboCode1" id="cboCode1" value=<%=dis_cboCode1 %> />
		<input type="hidden" name="cboCode2" id="cboCode2" value=<%=dis_cboCode2 %> />
		<input type="hidden" name="cboCode3" id="cboCode3" value=<%=dis_cboCode3 %> />
		<input type="hidden" name="l_code1" id="l_code1" value=<%=send_cboCode %> />
		<input type="hidden" name="m_code" id="m_code" value=<%= update_code %> />
		</td>
		</tr>
		<%if(dis_cboCode1.equals("l_code")){%>
			<tr>
				<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">코드회사</font></td>
				<td width="15%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
					<select id="l_company" name="l_company" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_code3()">
						<%
							List<AssetDTO> l_company_lists = code_dao.search_mcode1();
							for(AssetDTO l_company_obj : l_company_lists) {%>
								<option value=<%=l_company_obj.getM_code1() %> <%=(l_company_obj.getM_code1().equals(l_company) == true ? selected : "")%>><%=l_company_obj.getM_name() %></option>
		    		<%  }	%>	
					</select></td>
				<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">코드설명</font></td>
				<td width="15%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
					<input type="text" id="l_detail" name="l_detail" value="<%=code_dto.getL_detail() %>" style="width: 99%; font-family: Gothic; font-size: 9pt" /></td>
			</tr>
			<%}%>
	</table>
	</center>
	</form>
	</body>
	</html>
	