<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.code.*"%>
<%@ page import="kr.co.mycom.asset.*"%>
<%@ page import="java.util.List"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

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
String cboCode1 = request.getParameter("cboCode1");
String cboCode2 = request.getParameter("cboCode2");
String cboCode3 = request.getParameter("cboCode3");
String category = request.getParameter("category");
String selected = "selected = 'selected'";

if(category == null || category.equals("null")){
	category = "0";
}

if(cboCode1 == null || cboCode1.equals("null")){
	cboCode1 = "a_code";
}

if(cboCode2 == null || cboCode2.equals("null")){
	cboCode2 = "ALL";
}

if(cboCode3 == null || cboCode3.equals("null")){
	cboCode3 = "ALL";
}

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

<script type="text/javascript">
function select_code2(code1){
	
    var selectValue = document.getElementById("cboCode2");
	var l_detailValue = document.getElementById("l_detail");
	
    selectValue.options.length = 0;
	var i = 1;
    
    switch(code1){
    	case "a_code":
    		selectValue.options[0] = new Option('대분류추가', 'A1_0000');
    		<%List<AssetDTO> a_code1_lists = code_dao.search_acode1();
    		for(AssetDTO code3_obj : a_code1_lists) {%>
    			var option=new Option('<%=code3_obj.getA_name() %>', '<%=code3_obj.getA_code1()%>');
    				if('<%=code3_obj.getA_code1() %>' == '<%= cboCode3 %>') option.selected = true;
    	  		    selectValue.options[i] = option;
    				i++;
    		<%  }	%>	
    		l_detailValue.style.display = "none";

    		
			break;
    	case "o_code":
    		selectValue.options[0] = new Option('대분류추가', 'O1_0000');
    		<%List<AssetDTO> o_code1_lists = code_dao.search_ocode1();
    		for(AssetDTO code3_obj : o_code1_lists) {%>
    		var option=new Option('<%=code3_obj.getO_name() %>', '<%=code3_obj.getO_code1()%>');
    			if('<%=code3_obj.getO_code1() %>' == '<%= cboCode3 %>') option.selected = true;
      		    selectValue.options[i] = option;
    			i++;
    	<%  }	%>
    	l_detailValue.style.display = "none";

    		break;
    	case "m_code":
    		selectValue.options[0] = new Option('대분류추가', 'C_00000');
    		<%List<AssetDTO> m_code1_lists = code_dao.search_mcode1();
    		for(AssetDTO code3_obj : m_code1_lists) {%>
    		var option=new Option('<%=code3_obj.getM_name() %>', '<%=code3_obj.getM_code1()%>');
    			if('<%=code3_obj.getM_code1() %>' == '<%= cboCode3 %>') option.selected = true;
      		    selectValue.options[i] = option;
    			i++;
    	<%  }	%>
    	l_detailValue.style.display = "none";
    		break;
    	case "l_code":
    		selectValue.options[0] = new Option('대분류추가', 'L1_0000');
    	l_detailValue.style.display = "";
    		break;
    }
    select_code3();
}

function select_code3(code2){
	var selectValue = document.getElementById("cboCode3");

	var value_code2 = document.getElementById("cboCode2");
	var code2 = value_code2.options(value_code2.selectedIndex).value;	
	
	selectValue.options.length = 0;
	var check_code = code2.substring(0,1);
	var i = 1;

	if(check_code == 'A'){
		selectValue.options[0] = new Option('중분류추가', 'A2_0000');
		<%List<AssetDTO> a_code2_lists = code_dao.search_acode2();
		for(AssetDTO code3_obj : a_code2_lists) {%>
			if(code2 == '<%=code3_obj.getA_code1()%>'){
				var option=new Option('<%=code3_obj.getA_name() %>', '<%=code3_obj.getA_code2()%>');
				if('<%=code3_obj.getA_code2() %>' == '<%= cboCode3 %>') option.selected = true;
  		    	selectValue.options[i] = option;
				i++;
			}
	<%  }	%>
	} else if(check_code == 'O'){
		selectValue.options[0] = new Option('중분류추가', 'O2_0000');
		<%	List<AssetDTO> o_code2_lists = code_dao.search_ocode2();
		for(AssetDTO code3_obj : o_code2_lists) {%>
		if(code2 == '<%=code3_obj.getO_code1()%>'){
		var option=new Option('<%=code3_obj.getO_name() %>', '<%=code3_obj.getO_code2()%>');
			if('<%=code3_obj.getO_code2() %>' == '<%= cboCode3 %>') option.selected = true;
  		    selectValue.options[i] = option;
			i++;
		}
	<%  }	%>
	}else {
		selectValue.options[0] = new Option('중분류추가', 'C_00000');
		<%List<AssetDTO> m_code2_lists = code_dao.search_mcode2();
		 for(AssetDTO code3_obj : m_code2_lists) {%>
			if(code2 == '<%=code3_obj.getM_code1()%>'){
			var option=new Option('<%=code3_obj.getM_name() %>', '<%=code3_obj.getM_code2()%>');
			if('<%=code3_obj.getM_code2() %>' == '<%= cboCode3 %>') option.selected = true;
 		    selectValue.options[i] = option;
			i++;
			}
	<%  }%>
	}
}
</script>

<title>S-LITE</title>
<link rel="stylesheet" type="text/css" href="../common.css" />
</head>
<body style="margin: 0px" onload="select_code2('<%=cboCode1%>')">
<form name="frm1" method="post" action="Code_create.jsp">
<table width="95%" align="center">
<tr>
<td align="left">● 코드관리 ▶ 코드등록</td>
<td align="right"><input type="submit" value="코드등록" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt"></input>
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
			<select id="cboCode1" name="cboCode1" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_code2(this.value)">
				<option value="a_code" <%=(cboCode1.equals("a_code") == true ? selected : "")%>>자산관련</option>
				<option value="o_code" <%=(cboCode1.equals("o_code") == true ? selected : "")%>>장애관련</option>
				<option value="m_code" <%=(cboCode1.equals("m_code") == true ? selected : "")%>>회사관련</option>
				<option value="l_code" <%=(category.equals("1") == true ? selected : "")%>>등급관련</option>
			</select>
		</td>
		</tr>
		<tr>
		<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">대분류</font></td>
		<td width="15%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
			<select id="cboCode2" name="cboCode2" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_code3()">
			</select>
		</td>
		<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">중분류</font></td>
		<td width="15%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
			<select id="cboCode3" name="cboCode3" style="width: 100%; font-family: Gothic; font-size: 9pt" >
			</select>
		</td>
		</tr>
		<tr>
		<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">코드이름</font></td>
		<td width="15%" colspan="2" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
			<input type="text" id="code_name" name="code_name" style="width: 99%; font-family: Gothic; font-size: 9pt" />
		</td>
		<td width="10%" align="center" style="padding-center: 10px;" bgcolor="ffffff">
			사용여부<input type="checkbox" name="code_enable" id="code_enable" size="12" style="font-family: Gothic; font-size: 9pt" checked>
		</td>
		</tr>
			<tr id = "l_detail" style="display : ;">
				<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">코드회사</font></td>
				<td width="15%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
					<select id="l_company" name="l_company" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_code3()">
						<%
							List<AssetDTO> l_company_lists = code_dao.search_mcode1();
							for(AssetDTO l_company_obj : l_company_lists) {%>
								<option value=<%=l_company_obj.getM_code1() %>><%=l_company_obj.getM_name() %></option>
		    		<%  }	%>	
					</select></td>
				<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">코드설명</font></td>
				<td width="15%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
					<input type="text" id="l_detail" name="l_detail" style="width: 99%; font-family: Gothic; font-size: 9pt" /></td>
			</tr>
	</table>
	</center>
	</form>
	</body>
	</html>
	