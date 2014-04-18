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
String selected = "selected = 'selected'";

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
function btnView_Click(){
	var cboCode1 = document.getElementById("cboCode1");
	var cboCode2 = document.getElementById("cboCode2");
	var cboCode3 = document.getElementById("cboCode3");
	var v_cboCode1 = cboCode1.options(cboCode1.selectedIndex).value;
	var v_cboCode2 = cboCode2.options(cboCode2.selectedIndex).value;
	var v_cboCode3 = cboCode3.options(cboCode3.selectedIndex).value;
	location.href = "masterpage.jsp?bo_table=code&cboCode1=" + v_cboCode1 + "&cboCode2=" + v_cboCode2 + "&cboCode3=" + v_cboCode3; 
}
function select_code2(code1){
	
    var selectValue = document.getElementById("cboCode2");
	var selectValue2 = document.getElementById("cboCode3");

	var l_detailValue = document.getElementById("l_detail");
	
    selectValue.options.length = 0;
    selectValue2.options.length = 0;
	var i = 1;

	selectValue.options[0] = new Option('전체보기', 'ALL');

    switch(code1){
    	case "a_code":
    		<%List<AssetDTO> a_code1_lists = code_dao.search_acode1();
    		for(AssetDTO code3_obj : a_code1_lists) {%>
    			var option=new Option('<%=code3_obj.getA_name() %>', '<%=code3_obj.getA_code1()%>');
    				if('<%=code3_obj.getA_code1() %>' == '<%= cboCode2 %>') option.selected = true;
    	  		    selectValue.options[i] = option;
    				i++;
    		<%  }	%>	
			break;
    	case "o_code":
    		<%List<AssetDTO> o_code1_lists = code_dao.search_ocode1();
    		for(AssetDTO code3_obj : o_code1_lists) {%>
    		var option=new Option('<%=code3_obj.getO_name() %>', '<%=code3_obj.getO_code1()%>');
    			if('<%=code3_obj.getO_code1() %>' == '<%= cboCode2 %>') option.selected = true;
      		    selectValue.options[i] = option;
    			i++;
    	<%  }	%>
    		break;
    	case "m_code":
    		<%List<AssetDTO> m_code1_lists = code_dao.search_mcode1();
    		for(AssetDTO code3_obj : m_code1_lists) {%>
    		var option=new Option('<%=code3_obj.getM_name() %>', '<%=code3_obj.getM_code1()%>');
    			if('<%=code3_obj.getM_code1() %>' == '<%= cboCode2 %>') option.selected = true;
      		    selectValue.options[i] = option;
    			i++;
    	<%  }	%>
    		break;
    	case "l_code":
    		<%List<AssetDTO> l_code1_lists = code_dao.search_mcode1();
    		for(AssetDTO code3_obj : l_code1_lists) {%>
    		var option=new Option('<%=code3_obj.getM_name() %>', '<%=code3_obj.getM_code1()%>');
    			if('<%=code3_obj.getM_code1() %>' == '<%= cboCode2 %>') option.selected = true;
      		    selectValue.options[i] = option;
    			i++;
    	<%  }	%>
    		break;
    }
    select_code3();
}

function select_code3(){
	var selectValue = document.getElementById("cboCode3");

	var value_code2 = document.getElementById("cboCode2");
	var code2 = value_code2.options(value_code2.selectedIndex).value;	
	
	selectValue.options.length = 0;
	var check_code = code2.substring(0,1);
	var i = 1;
	
	selectValue.options[0] = new Option('전체보기', 'ALL');

	if(check_code == 'A'){
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
		<%	List<AssetDTO> o_code2_lists = code_dao.search_ocode2();
		for(AssetDTO code3_obj : o_code2_lists) {%>
		if(code2 == '<%=code3_obj.getO_code1()%>'){
		var option=new Option('<%=code3_obj.getO_name() %>', '<%=code3_obj.getO_code2()%>');
			if('<%=code3_obj.getO_code2() %>' == '<%= cboCode3 %>') option.selected = true;
  		    selectValue.options[i] = option;
			i++;
		}
	<%  }	%>
	}else if(check_code == 'C'){
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
<link rel="stylesheet" type="text/css" href="./common.css" />
</head>
<body style="margin: 0px" onload="select_code2('<%=cboCode1%>')">
<form name="frm1" method="post">
<table width="95%" align="center">
<tr>
<td align="left">● 코드관리 ▶ 코드현황</td>
<td align="right"><input type="button" value="조회" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt" onClick="btnView_Click();"></input>
<input type="button" value="코드등록" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt" onclick="window.open('./code/Code_createform.jsp','','width=500,height=200');"></input>
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
		<td width="15%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
			<select id="cboCode1" name="cboCode1" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_code2(this.value)">
				<option value="a_code" <%=(cboCode1.equals("a_code") == true ? selected : "")%>>자산관리</option>
				<option value="o_code" <%=(cboCode1.equals("o_code") == true ? selected : "")%>>장애관리</option>
				<option value="m_code" <%=(cboCode1.equals("m_code") == true ? selected : "")%>>회사</option>
				<option value="l_code" <%=(cboCode1.equals("l_code") == true ? selected : "")%>>등급관리</option>
			</select>
		</td>
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
	</table>
	<table>
		<tr>
		<td style="height: 30px"></td>
		</tr>
		<tr>
		<%
		List<CodeDTO> code2_lists;
		CodeDAO dao = new CodeDAO();
		int search_count = 0;
		int count_code = 3;
		if(cboCode2.equals("ALL")){	// 대분류에서 검색
			if(cboCode1.equals("o_code")) count_code = 2;
			if(cboCode1.equals("l_code")) count_code = 1;
			for(int i=1;i<=count_code;i++){
				code2_lists = dao.search_code2(cboCode1 + i);
				search_count = search_count + code2_lists.size();
			}
		} else if(cboCode3.equals("ALL")){ 		// 두번째 분류에서 검색
			code2_lists = dao.search_code3(cboCode1, cboCode2);
			search_count = code2_lists.size();	
		} else {
			code2_lists = dao.search_code4(cboCode1, cboCode3);
			search_count = code2_lists.size();	
		}
			%>
		<td><%=search_count %>개의 자료가 검색되었습니다.</td>
		</tr>
	</table>
<table width="95%" border="0" cellspacing="1" bgcolor="000000">
	<%
	if(cboCode1.equals("l_code")){
	%>
	<tr height="24" bgcolor="#A7A9AC">
		<td width="10%" align="center" class="01black_bold"><font color="white">관련분야</font></td>
		<td width="10%" align="center" class="01black_bold"><font color="white">대분류</font></td>
		<td width="10%" align="center" class="01black_bold"><font color="white">코드번호</font></td>
		<td width="10%"align="center" class="01black_bold"><font color="white">코드이름</font></td>
		<td width="10%"align="center" class="01black_bold"><font color="white">코드회사</font></td>
		<td width="40%"align="center" class="01black_bold"><font color="white">코드설명</font></td>
		<td width="10%" align="center" class="01black_bold"><font color="white">사용여부</font></td>
		<td width="5%" align="center" class="01black_bold"><font color="white">수정</font></td>
		<td width="5%" align="center" class="01black_bold"><font color="white">삭제</font></td>
	</tr>
	<%} else {
		%>
		<tr height="24" bgcolor="#A7A9AC">
		<td width="10%" align="center" class="01black_bold"><font color="white">관련분야</font></td>
		<td width="10%" align="center" class="01black_bold"><font color="white">대분류</font></td>
		<td width="10%" align="center" class="01black_bold"><font color="white">코드번호</font></td>
		<td width="50%"align="center" class="01black_bold"><font color="white">코드이름</font></td>
		<td width="10%" align="center" class="01black_bold"><font color="white">사용여부</font></td>
		<td width="5%" align="center" class="01black_bold"><font color="white">수정</font></td>
		<td width="5%" align="center" class="01black_bold"><font color="white">삭제</font></td>
	</tr>
			<%	}
				count_code = 3;
				if(cboCode2.equals("ALL")){
					if(cboCode1.equals("o_code")) count_code = 2;
					if(cboCode1.equals("l_code")) count_code = 1;
					for(int i = 1; i <= count_code;i++){
						code2_lists = dao.search_code2(cboCode1 + i);
						for(CodeDTO code2_obj : code2_lists) {
							if(cboCode1.equals("l_code")){
								%>
									<tr bgcolor="ffffff">
										<td align="center" class="black"><%=(cboCode1.equals("a_code") == true ? "자산관리" : (cboCode1.equals("o_code") == true ? "장애관리" : (cboCode1.equals("l_code") == true ? "등급관리" : "회사"))) %></td>
										<td align="center" class="black"><%=((cboCode1 + i).equals("a_code1") == true ? "자산구분" : ((cboCode1 + i).equals("a_code2") == true ? "자산종류" : ((cboCode1 + i).equals("a_code3") == true ? "자산유형" : ((cboCode1 + i).equals("o_code1") == true ? "대분류" : ((cboCode1 + i).equals("o_code2") == true ? "중분류(업무구분)" : ((cboCode1 + i).equals("m_code1") == true ? "회사명" : ((cboCode1 + i).equals("m_code2") == true ? "위치" : ((cboCode1 + i).equals("l_code1") == true ? "등급명" : "부서")))))))) %></td>
										<td align="center" class="black"><%=code2_obj.getM_code() %></td>
										<td align="center" class="black"><%=code2_obj.getM_name() %></td>
										<td align="center" class="black"><%=code2_obj.getL_company() %></td>
										<td align="center" class="black"><%=code2_obj.getL_detail() %></td>
										<td align="center" class="black"><%=(code2_obj.getM_enable().equals("1") == true ? "사용" : "불가") %></td>	
										<% String update_cboCode2 = cboCode1 + i;%>
										<td align="center" class="black"><input type="button" value="수정" style="width: 50px; font-family: Gothic; font-size: 9pt" onclick="window.open('./code/Code_updateform.jsp?cboCode1=<%=cboCode1%>&cboCode2=<%=update_cboCode2%>&cboCode3=<%=cboCode3%>&send_cboCode=<%=cboCode2%>&update_code=<%=code2_obj.getM_code() %>&code_name=<%=code2_obj.getM_name() %>&code_enable=<%=code2_obj.getM_enable() %>','','width=390,height=150');"></td>
										<td align="center" class="black"><input type="button" value="삭제" style="width: 50px; font-family: Gothic; font-size: 9pt" onclick="window.open('./code/Code_delete.jsp?cboCode1=<%=cboCode1%>&cboCode2=<%=update_cboCode2%>&cboCode3=<%=cboCode3%>&send_cboCode=<%=cboCode2%>&update_code=<%=code2_obj.getM_code() %>&code_name=<%=code2_obj.getM_name() %>&code_enable=<%=code2_obj.getM_enable() %>','','width=10,height=10');"></td>
									</tr>
							<%
							}else{
								%>
							<tr bgcolor="ffffff">
										<td align="center" class="black"><%=(cboCode1.equals("a_code") == true ? "자산관리" : (cboCode1.equals("o_code") == true ? "장애관리" : (cboCode1.equals("l_code") == true ? "등급관리" : "회사"))) %></td>
										<td align="center" class="black"><%=((cboCode1 + i).equals("a_code1") == true ? "자산구분" : ((cboCode1 + i).equals("a_code2") == true ? "자산종류" : ((cboCode1 + i).equals("a_code3") == true ? "자산유형" : ((cboCode1 + i).equals("o_code1") == true ? "대분류" : ((cboCode1 + i).equals("o_code2") == true ? "중분류(업무구분)" : ((cboCode1 + i).equals("m_code1") == true ? "회사명" : ((cboCode1 + i).equals("m_code2") == true ? "위치" : ((cboCode1 + i).equals("l_code1") == true ? "등급명" : "부서")))))))) %></td>
										<td align="center" class="black"><%=code2_obj.getM_code() %></td>
										<td align="center" class="black"><%=code2_obj.getM_name() %></td>
										<td align="center" class="black"><%=(code2_obj.getM_enable().equals("1") == true ? "사용" : "불가") %></td>	
										<% String update_cboCode2 = cboCode1 + i;%>
										<td align="center" class="black"><input type="button" value="수정" style="width: 50px; font-family: Gothic; font-size: 9pt" onclick="window.open('./code/Code_updateform.jsp?cboCode1=<%=cboCode1%>&cboCode2=<%=update_cboCode2%>&cboCode3=<%=cboCode3%>&send_cboCode=<%=cboCode2%>&update_code=<%=code2_obj.getM_code() %>&code_name=<%=code2_obj.getM_name() %>&code_enable=<%=code2_obj.getM_enable() %>','','width=390,height=150');"></td>
										<td align="center" class="black"><input type="button" value="삭제" style="width: 50px; font-family: Gothic; font-size: 9pt" onclick="window.open('./code/Code_delete.jsp?cboCode1=<%=cboCode1%>&cboCode2=<%=update_cboCode2%>&cboCode3=<%=cboCode3%>&send_cboCode=<%=cboCode2%>&update_code=<%=code2_obj.getM_code() %>&code_name=<%=code2_obj.getM_name() %>&code_enable=<%=code2_obj.getM_enable() %>','','width=10,height=10');"></td>
									</tr>							
							<%}
							} 
					} 
				}
				else if(cboCode3.equals("ALL")){
					code2_lists = dao.search_code3(cboCode1, cboCode2);
					for(CodeDTO code2_obj : code2_lists) {
						if(cboCode1.equals("l_code")){
					%>
					<tr bgcolor="ffffff">
						<td align="center" class="black"><%=(cboCode1.equals("a_code") == true ? "자산관리" : (cboCode1.equals("o_code") == true ? "장애관리" : (cboCode1.equals("l_code") == true ? "등급관리" : "회사"))) %></td>
						<td align="center" class="black"><%=(cboCode2.equals("a_code1") == true ? "자산구분" : (cboCode2.equals("a_code2") == true ? "자산종류" : (cboCode2.equals("a_code3") == true ? "자산유형" : (cboCode2.equals("o_code1") == true ? "대분류" : (cboCode2.equals("o_code2") == true ? "중분류(업무구분)" : (cboCode2.equals("m_code1") == true ? "회사명" : (cboCode2.equals("m_code2") == true ? "위치" : (cboCode2.equals("l_code1") == true ? "등급명" : "부서")))))))) %></td>
						<td align="center" class="black"><%=code2_obj.getM_code() %></td>
						<td align="center" class="black"><%=code2_obj.getM_name() %></td>
						<td align="center" class="black"><%=code2_obj.getL_company() %></td>
						<td align="center" class="black"><%=code2_obj.getL_detail() %></td>
						<td align="center" class="black"><%=(code2_obj.getM_enable().equals("1") == true ? "사용" : "불가") %></td>					
						<% String update_cboCode2 = cboCode1 + 2;%>
						<td align="center" class="black"><input type="button" value="수정" style="width: 50px; font-family: Gothic; font-size: 9pt" onclick="window.open('./code/Code_updateform.jsp?cboCode1=<%=cboCode1%>&cboCode2=<%=update_cboCode2%>&cboCode3=<%=cboCode3%>&send_cboCode=<%=cboCode2%>&update_code=<%=code2_obj.getM_code() %>&code_name=<%=code2_obj.getM_name() %>&code_enable=<%=code2_obj.getM_enable() %>&l_detail=<%=code2_obj.getL_detail() %>','','width=390,height=150');"></td>
						<td align="center" class="black"><input type="button" value="삭제" style="width: 50px; font-family: Gothic; font-size: 9pt" onclick="window.open('./code/Code_delete.jsp?cboCode1=<%=cboCode1%>&cboCode2=<%=cboCode2%>&cboCode3=<%=cboCode3%>&send_cboCode=<%=cboCode2%>&update_code=<%=code2_obj.getM_code() %>&code_name=<%=code2_obj.getM_name() %>&code_enable=<%=code2_obj.getM_enable() %>','','width=10,height=10');"></td>
					</tr>
			<%} else {%>
				<tr bgcolor="ffffff">
						<td align="center" class="black"><%=(cboCode1.equals("a_code") == true ? "자산관리" : (cboCode1.equals("o_code") == true ? "장애관리" : (cboCode1.equals("l_code") == true ? "등급관리": "회사")))%></td>
						<td align="center" class="black"><%=(cboCode2.equals("a_code1") == true ? "자산구분" : (cboCode2.equals("a_code2") == true ? "자산종류" : (cboCode2.equals("a_code3") == true ? "자산유형" : (cboCode2.equals("o_code1") == true ? "대분류" : (cboCode2.equals("o_code2") == true ? "중분류(업무구분)" : (cboCode2.equals("m_code1") == true ? "회사명" : (cboCode2.equals("m_code2") == true ? "위치" : (cboCode2.equals("l_code1") == true ? "등급명" : "부서")))))))) %></td>
						<td align="center" class="black"><%=code2_obj.getM_code() %></td>
						<td align="center" class="black"><%=code2_obj.getM_name() %></td>
						<td align="center" class="black"><%=(code2_obj.getM_enable().equals("1") == true ? "사용" : "불가") %></td>
						<% String update_cboCode2 = cboCode1 + "2";%>
						<td align="center" class="black"><input type="button" value="수정" style="width: 50px; font-family: Gothic; font-size: 9pt" onclick="window.open('./code/Code_updateform.jsp?cboCode1=<%=cboCode1%>&cboCode2=<%=update_cboCode2%>&cboCode3=<%=cboCode3%>&send_cboCode=<%=cboCode2%>&update_code=<%=code2_obj.getM_code() %>&code_name=<%=code2_obj.getM_name() %>&code_enable=<%=code2_obj.getM_enable() %>','','width=390,height=150');"></td>
						<td align="center" class="black"><input type="button" value="삭제" style="width: 50px; font-family: Gothic; font-size: 9pt" onclick="window.open('./code/Code_delete.jsp?cboCode1=<%=cboCode1%>&cboCode2=<%=cboCode2%>&cboCode3=<%=cboCode3%>&send_cboCode=<%=cboCode2%>&update_code=<%=code2_obj.getM_code() %>&code_name=<%=code2_obj.getM_name() %>&code_enable=<%=code2_obj.getM_enable() %>','','width=10,height=10');"></td>
					</tr>
			<%}
					}
				} else {
						code2_lists = dao.search_code4(cboCode1, cboCode3);
					for(CodeDTO code2_obj : code2_lists){
							if(cboCode1.equals("l_code")){
			%>
					<tr bgcolor="ffffff">
						<td align="center" class="black"><%=(cboCode1.equals("a_code") == true ? "자산관리" : (cboCode1.equals("o_code") == true ? "장애관리" : (cboCode1.equals("l_code") == true ? "등급관리": "회사")))%></td>
						<td align="center" class="black"><%=(cboCode2.equals("a_code1") == true ? "자산구분" : (cboCode2.equals("a_code2") == true ? "자산종류" : (cboCode2.equals("a_code3") == true ? "자산유형" : (cboCode2.equals("o_code1") == true ? "대분류" : (cboCode2.equals("o_code2") == true ? "중분류(업무구분)" : (cboCode2.equals("m_code1") == true ? "회사명" : (cboCode2.equals("m_code2") == true ? "위치" : (cboCode2.equals("l_code1") == true ? "등급명" : "부서")))))))) %></td>
						<td align="center" class="black"><%=code2_obj.getM_code() %></td>
						<td align="center" class="black"><%=code2_obj.getM_name() %></td>
						<td align="center" class="black"><%=code2_obj.getL_company() %></td>
						<td align="center" class="black"><%=code2_obj.getL_detail() %></td>
						<td align="center" class="black"><%=(code2_obj.getM_enable().equals("1") == true ? "사용" : "불가") %></td>	
						<% String update_cboCode2 = cboCode1 + "3";%>
						<td align="center" class="black"><input type="button" value="수정" style="width: 50px; font-family: Gothic; font-size: 9pt" onclick="window.open('./code/Code_updateform.jsp?cboCode1=<%=cboCode1%>&cboCode2=<%=update_cboCode2%>&cboCode3=<%=cboCode3%>&send_cboCode=<%=cboCode2%>&update_code=<%=code2_obj.getM_code() %>&code_name=<%=code2_obj.getM_name()%>&code_enable=<%=code2_obj.getM_enable()%>&l_detail=<%=code2_obj.getL_detail() %>','','width=390,height=150');"></td>
						<td align="center" class="black"><input type="button" value="삭제" style="width: 50px; font-family: Gothic; font-size: 9pt" onclick="window.open('./code/Code_delete.jsp?cboCode1=<%=cboCode1%>&cboCode2=<%=cboCode2%>&cboCode3=<%=cboCode3%>&send_cboCode=<%=cboCode2%>&update_code=<%=code2_obj.getM_code() %>&code_name=<%=code2_obj.getM_name()%>&code_enable=<%=code2_obj.getM_enable() %>','','width=10,height=10');"></td>
					</tr>
			<%
							} else{ %>
					<tr bgcolor="ffffff">
						<td align="center" class="black"><%=(cboCode1.equals("a_code") == true ? "자산관리" : (cboCode1.equals("o_code") == true ? "장애관리" : (cboCode1.equals("l_code") == true ? "등급관리": "회사")))%></td>
						<td align="center" class="black"><%=(cboCode2.equals("a_code1") == true ? "자산구분" : (cboCode2.equals("a_code2") == true ? "자산종류" : (cboCode2.equals("a_code3") == true ? "자산유형" : (cboCode2.equals("o_code1") == true ? "대분류" : (cboCode2.equals("o_code2") == true ? "중분류(업무구분)" : (cboCode2.equals("m_code1") == true ? "회사명" : (cboCode2.equals("m_code2") == true ? "위치" : (cboCode2.equals("l_code1") == true ? "등급명" : "부서")))))))) %></td>
						<td align="center" class="black"><%=code2_obj.getM_code() %></td>
						<td align="center" class="black"><%=code2_obj.getM_name() %></td>
						<td align="center" class="black"><%=(code2_obj.getM_enable().equals("1") == true ? "사용" : "불가") %></td>					
						<% String update_cboCode2 = cboCode1 + 3;%>
						<td align="center" class="black"><input type="button" value="수정" style="width: 50px; font-family: Gothic; font-size: 9pt" onclick="window.open('./code/Code_updateform.jsp?cboCode1=<%=cboCode1%>&cboCode2=<%=update_cboCode2%>&cboCode3=<%=cboCode3%>&send_cboCode=<%=cboCode2%>&update_code=<%=code2_obj.getM_code() %>&code_name=<%=code2_obj.getM_name()%>&code_enable=<%=code2_obj.getM_enable() %>','','width=390,height=150');"></td>
						<td align="center" class="black"><input type="button" value="삭제" style="width: 50px; font-family: Gothic; font-size: 9pt" onclick="window.open('./code/Code_delete.jsp?cboCode1=<%=cboCode1%>&cboCode2=<%=cboCode2%>&cboCode3=<%=cboCode3%>&send_cboCode=<%=cboCode2%>&update_code=<%=code2_obj.getM_code() %>&code_name=<%=code2_obj.getM_name()%>&code_enable=<%=code2_obj.getM_enable() %>','','width=10,height=10');"></td>
					</tr>
						<%	}
					}
				}
			%>
		</table>
	</center>
	</form>
	</body>
	</html>
	