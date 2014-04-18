<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%@ page import="java.net.InetAddress"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="kr.co.mycom.asset.*"%>
<%@ page import="kr.co.mycom.member.*"%>

<%
	String my_id = (String) session.getAttribute("ID");
	String my_name = (String) session.getAttribute("NAME");
	String member_id = (String) request.getParameter("member_id");
	String master = (String) session.getAttribute("Master");

	String member_company = (String) request.getParameter("member_company");
	String member_place = (String) request.getParameter("member_place");
	String member_dept = (String) request.getParameter("member_dept");
	
	if(my_id == null || my_id.equals("null")){
		%>
			<script type = "text/javascript">
			alert("로그인하지 않으면 접근할 수 없습니다.");
			history.back();
			</script>
		<%
	}
	if(member_id == null || member_id.equals("null")){
		member_id = my_id;
	}
	
MemberDAO member_dao= new MemberDAO();
MemberDTO member_dto = member_dao.searchMember(member_id);


AssetDAO dao = new AssetDAO();
List<AssetDTO> m_code1_lists = dao.search_mcode1();
List<AssetDTO> m_code2_lists = dao.search_mcode2();
List<AssetDTO> m_code3_lists = dao.search_mcode3();

String selected = "selected = 'selected'";
String checked = "checked = 'checked'";


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<script type="text/javascript">

function m_master_flase()
{
		document.update_form.m_master.checked = false;
}

function m_engineer_flase()
{
		document.update_form.m_engineer.checked = false;
}

function select_mcode2(){
    var selectValue = document.getElementById("m_place");
    update_form.m_place.options.length = 0;  //모두삭제
    update_form.m_dept.options.length = 0;  //모두삭제
	
    var value_mcode1 = document.getElementById("m_company");
	var mcode1 = value_mcode1.options(value_mcode1.selectedIndex).value;	

	var i=0;
		<%	for(AssetDTO m_code2_obj : m_code2_lists) {
			%>if(mcode1 == '<%=m_code2_obj.getM_code1()%>'){
				var option=new Option('<%=m_code2_obj.getM_name()%>', '<%=m_code2_obj.getM_code2()%>');
				if('<%=m_code2_obj.getM_code2() %>' == '<%=member_dto.getM_place() %>'){
					option.selected = true;
			    }
			    selectValue.options[i] = option;
				i++;
			}	
		<%}		%>
		select_mcode3();
}

function select_mcode3(){
    var selectValue = document.getElementById("m_dept");
    update_form.m_dept.options.length = 0;  //모두삭제

	var value_mcode2 = document.getElementById("m_place");
	var mcode2 = value_mcode2.options(value_mcode2.selectedIndex).value;

			var i=0;
		<%	for(AssetDTO m_code3_obj : m_code3_lists) {
			%>if(mcode2 == '<%=m_code3_obj.getM_code1()%>'){
				var option=new Option('<%=m_code3_obj.getM_name()%>', '<%=m_code3_obj.getM_code2()%>');
				if('<%=m_code3_obj.getM_code2() %>' == '<%=member_dto.getM_dept() %>'){
				    option.selected = true;
				}
				selectValue.options[i] = option;
				i++;
			  }	
		<%}		%>
}


	function check() {
		document.update_form.m_linenum.value = document.update_form.phone1.value + "-"
		+ document.update_form.phone2.value + "-" + document.update_form.phone3.value;
					
		if (document.update_form.m_id.value == "") {
			alert("ID를 입력하세요");
			document.update_form.m_id.focus();
			return false;
		}
	if (document.update_form.m_name.value == "") {
		alert("이름을 입력하세요");
		document.update_form.m_name.focus();
		return false;
	}
		if (document.update_form.m_name.value.length <= 1 || document.update_form.m_name.value.length >= 6 ) {
			alert("이름을 2글자 이상 5글자 이하로 입력하세요");
			document.update_form.m_name.focus();
			return false;
		}
		if (document.update_form.phone2.value == "") {
			alert("전화번호 두번째를 입력하세요");
			document.update_form.phone2.focus();
			return false;
		}
		if (isNaN(document.update_form.phone2.value)) {
			alert("전화번호 두번째에 숫자를 입력하세요");
			document.update_form.phone2.focus();
			return false;
		}
		if (document.update_form.phone3.value == "") {
			alert("전화번호 세번째를 입력하세요");
			document.update_form.phone3.focus();
			return false;
		}
		if (isNaN(document.update_form.phone3.value)) {
			alert("전화번호 세번째에 숫자를 입력하세요");
			document.update_form.phone3.focus();
			return false;
		}
		if (document.update_form.m_pwd.value.length <= 5 && document.update_form.m_pwd.value.length > 0 ) {
			alert("비밀번호를 6자리 이상 입력하세요");
			document.update_form.m_pwd.focus();
			return false;
		}
		if (document.update_form.m_pwd_confirm.value == "" && document.update_form.m_pwd.value.length > 0 ) {
			alert("비밀번호를 다시 입력하세요");
			document.update_form.m_pwd_confirm.focus();
			return false;
		}
		if (document.update_form.m_pwd_confirm.value.length <= 5 && document.update_form.m_pwd_confirm.value.length > 0 ) {
			alert("비밀번호를 6자리 이상 입력하세요");
			document.update_form.m_pwd_confirm.focus();
			return false;
		}
		if (document.update_form.m_pw.value != document.update_form.m_pwd_confirm.value){
			alert("동일한 비밀번호를 입력하세요");
			document.update_form.m_pwd_confirm.focus();
			return false;
		}
		
		if (document.update_form.m_pwd_confirm.value.length > 20 && document.update_form.m_pwd_confirm.value.length > 20 ) {
			alert("비밀번호는 20자 이상 입력할 수 없습니다.");
			document.update_form.m_pwd_confirm.focus();
			return false;
		}
			return true;
	}
	
	
</script>
<head>

<title>S-LITE</title>
<link rel="stylesheet" type="text/css" href="../common.css" />
</head>
<body onload="select_mcode2();">
	<form name="update_form" action="Update_admin.jsp?member_company=<%=member_company %>&member_place=<%=member_place %>&member_dept=<%=member_dept %>" method="post" onsubmit="return check()">
<table width="95%" align="center">
<tr>
<td align="left">● 사용자관리 ▶ 사용자수정</td>
<td align="right"><input type="submit" value="수정" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt"></input></td>
</tr>
</table>
<table>
		<tr>
			<td style="height: 30px"></td>
		</tr>
	</table>
	<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
			
				<tr>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">I&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D</font></td>
					<td align="center" valign="middle" bgcolor="ffffff" colspan="3" width="40%">
						<input align="left" type="text" id="m_id" name="m_id" style="width: 99%; font-family: Gothic; font-size: 9pt" value=<%=member_dto.getM_id()%> readonly="readonly" />
					</td>		
				</tr>
				<tr>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름&nbsp;</font>
					<td align="left" valign="middle" bgcolor="ffffff" width="40%">
						<input type="text" id="m_name" name="m_name" style="width: 99%; font-family: Gothic; font-size: 9pt" value=<%=member_dto.getM_name()%> maxlength="5" />
					</td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">회&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;사&nbsp;</font>
					<td align="center" valign="middle" bgcolor="ffffff" width="40%">
						<select id="m_company" name="m_company" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_mcode2()">
							<%	for(AssetDTO m_code1_obj : m_code1_lists) {%>
							<option value=<%=m_code1_obj.getM_code1() %> <%=(member_dto.getM_company().equals(m_code1_obj.getM_code1()) == true ? selected : "") %>><%=m_code1_obj.getM_name()%></option>
							<%	} %>
						</select>
					</td>
				</tr>
				<tr>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">전화번호</font>
					<td align="left" valign="middle" bgcolor="ffffff" width="40%">
						<input type="hidden" name="m_linenum" id="m_linenum" value=<%=member_dto.getM_linenum() %>>
						<%
							String phone = member_dto.getM_linenum();
							String[] arrPhone = phone.split("-");	// '-' 로 3개의 배열로 나눈다.
							String phone1 = arrPhone[0];
							String phone2 = arrPhone[1];
							String phone3 = arrPhone[2];
						%>
						<select name="phone1" id="phone1" style="width: 30%; font-family: Gothic; font-size: 8pt">
							<option value="010" <%=(phone1.equals("010") == true ? selected:"")%>>010
							<option value="011" <%=(phone1.equals("011") == true ? selected:"")%>>011
							<option value="016" <%=(phone1.equals("016") == true ? selected:"")%>>016
							<option value="017" <%=(phone1.equals("017") == true ? selected:"")%>>017
							<option value="018" <%=(phone1.equals("018") == true ? selected:"")%>>018
							<option value="019" <%=(phone1.equals("019") == true ? selected:"")%>>019
						</select>-
						<input type="text" name="phone2" id="phone2" maxlength="4" style="width: 30%; font-family: Gothic; font-size: 8pt" value=<%=phone2 %>>-
						<input type="text" name="phone3" id="phone3" maxlength="4" style="width: 30%; font-family: Gothic; font-size: 8pt" value=<%=phone3 %>>
					</td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">사&nbsp;&nbsp;&nbsp;업&nbsp;&nbsp;&nbsp;장&nbsp;</font>
					<td align="center" valign="middle" bgcolor="ffffff" width="40%">
						<select id="m_place" name="m_place" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_mcode3()">
						</select>
					</td>
				</tr>
				<tr>				
					<td colspan="2" align="center" style="padding-center: 10px;width: 50%;" bgcolor="ffffff">
					
					Master
					<input type="radio" name="m_master" id="m_master" size="12" style="font-family: Gothic; font-size: 9pt" onclick="m_engineer_flase()" <%=(member_dto.getM_master().equals("1") == true ? checked : "")%> >
					Engineer
					<input type="radio" name="m_engineer" id="m_engineer" size="12" style="font-family: Gothic; font-size: 9pt" onclick="m_master_flase()" <%=(member_dto.getM_master().equals("2") == true ? checked : "")%>>	
					사용여부
					<input type="checkbox" name="m_enable" id="m_enable" size="12" style="font-family: Gothic; font-size: 9pt" <%=(member_dto.getM_enable().equals("1") == true ? checked : "")%> >
					
					</td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">부&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;서&nbsp;</font>
					<td align="center" valign="middle" bgcolor="ffffff" width="40%">
						<select id="m_dept" name="m_dept" style="width: 100%; font-family: Gothic; font-size: 9pt">
						</select>
					</td>
				</tr>
				<tr>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">비밀번호</font> 
					<td align="left" valign="middle" bgcolor="ffffff" width="40%">
						<input type="password" id="m_pwd" name="m_pwd" style="width: 99%; font-family: Gothic; font-size: 9pt"  maxlength="12"/>
					</td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">다시입력</font>
					<td align="left" valign="middle" bgcolor="ffffff" width="40%">
						<input type="password" id="m_pwd_confirm" name="m_pwd_confirm" style="width: 99%; font-family: Gothic; font-size: 9pt"  maxlength="12"/>
				</tr>
				</table>			
	</form>
</body>
</html>

