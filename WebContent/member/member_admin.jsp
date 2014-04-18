<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.asset.*"%>
<%@ page import="kr.co.mycom.member.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<jsp:useBean id="member" class="kr.co.mycom.asset.AssetDTO" />
<jsp:setProperty property="*" name="member" />
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
String selected = "selected = 'selected'";

AssetDAO dao = new AssetDAO();
List<AssetDTO> m_code1_lists = dao.search_mcode1();
List<AssetDTO> m_code2_lists = dao.search_mcode2();
List<AssetDTO> m_code3_lists = dao.search_mcode3();

String member_company = member.getA_company();
String member_place = member.getA_place();
String member_dept = member.getA_dept();

if(member_company == null || member_company.equals("null")){
	if((String)request.getParameter("member_company") == null){
	member_company = "C_00000";
	} else member_company = (String)request.getParameter("member_company");
}

if(member_place == null || member_place.equals("null")){
	if((String)request.getParameter("member_place") == null){
	member_place = "P_00000";
	} else member_place = (String)request.getParameter("member_place");
}

if(member_dept == null || member_dept.equals("null")){
	if((String)request.getParameter("member_dept") == null){
	member_dept = "D_00000";
	} else member_dept = (String)request.getParameter("member_dept");
}

MemberDAO member_dao = new MemberDAO();
List<MemberDTO> result_lists = member_dao.admin_Member(member_company, member_place, member_dept);

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
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
  
<script type="text/javascript">

function select_mcode2(){
    var selectValue = document.getElementById("a_place");
    C001_form.a_place.options.length = 0;  //모두삭제
    C001_form.a_dept.options.length = 0;  //모두삭제
	
    var value_mcode1 = document.getElementById("a_company");
	var mcode1 = value_mcode1.options(value_mcode1.selectedIndex).value;	
	var place='<%=member_place%>';
	var i=0;
	var option;
	if(place=="P_00000"||place==null){
		 option=new Option('전체보기', 'P_00000');
		option.selected = true;
	}
	else{
		 option=new Option('전체보기', 'P_00000');
	}
	selectValue.options[i] = option;
    i++;
		<%	for(AssetDTO m_code2_obj : m_code2_lists) {
			%>if(mcode1 == '<%=m_code2_obj.getM_code1()%>'){
				var option=new Option('<%=m_code2_obj.getM_name()%>', '<%=m_code2_obj.getM_code2()%>');
				if('<%=m_code2_obj.getM_code2() %>' == '<%=member_place %>'){
					option.selected = true;
				}
				selectValue.options[i] = option;
				i++; 
			}	
		<%}		%>
		select_mcode3();
}

function select_mcode3(){
    var selectValue = document.getElementById("a_dept");
    C001_form.a_dept.options.length = 0;  //모두삭제
    var dept='<%=member_dept%>';
    var i=0;
	var option;
	var value_mcode2 = document.getElementById("a_place");
	var mcode2 = value_mcode2.options(value_mcode2.selectedIndex).value;
	if(dept=="D_00000"||dept==null){
		option=new Option('전체보기', 'D_00000');
		option.selected = true;
	}
	else{
		option=new Option('전체보기', 'D_00000');
	}
	  selectValue.options[i] = option;
	  i++;
		<%	for(AssetDTO m_code3_obj : m_code3_lists) {
			%>if(mcode2 == '<%=m_code3_obj.getM_code1()%>'){
				var option=new Option('<%=m_code3_obj.getM_name()%>', '<%=m_code3_obj.getM_code2()%>');
				if('<%=m_code3_obj.getM_code2() %>' == '<%=member_dept %>'){
					option.selected = true;
				} 
				selectValue.options[i] = option;
			  i++;
			}
		<%}		%>
}
</script>
<title>S-LITE</title>
<link rel="stylesheet" type="text/css" href="./common.css" />
</head>
<body onload="select_mcode2();">
<form name="C001_form" method="post" action=".\masterpage.jsp?bo_table=member_admin" onsubmit="return check()">
<table width="95%" align="center">
<tr>
<td align="left">● 사용자관리 ▶ 사용자목록</td>
<td align="right"><input type="submit" value="조회" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt" ></input>
<input type="button" value="사용자등록" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt" onclick="window.open('./member/Joinform.jsp','','width=900,height=250');"></input>
</td>
</tr>
</table>
<table>
		<tr>
			<td style="height: 30px"></td>
		</tr>
	</table>
<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">회사</font></td>
<td width="15%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_company" name="a_company" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_mcode2()">
			<option value="C_00000">전체보기</option>
			<%	for(AssetDTO m_code1_obj : m_code1_lists) {%>
					<option value=<%=m_code1_obj.getM_code1() %> <%=(member_company.equals(m_code1_obj.getM_code1()) == true ? selected : "") %>><%=m_code1_obj.getM_name()%></option>
						<%	} %>
</select>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">사업장</font></td>
<td width="15%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_place" name="a_place" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_mcode3()">
</select>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">부서</font></td>
<td width="15%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_dept" name="a_dept" style="width: 100%; font-family: Gothic; font-size: 9pt">
</select>
</td>
</table>
<table>
	<tr>
		<td style="height: 30px"></td>
	</tr>
	<tr>
		<td><%=result_lists.size() %>개의 자료가 검색되었습니다.</td>
	</tr>
</table>

<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
<tr>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">ID</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">이름</font></td>
<td width="7%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">전화번호</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">회사</font></td>
<td width="7%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">사업장</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">부서</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">Master</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">사용여부</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">수정</font></td>
</tr>
			<% String member_master = null;
			   String member_enable = null;

       		   for(MemberDTO result_obj : result_lists) {
       		   member_master = result_obj.getM_master();
       		   member_enable = result_obj.getM_enable();
       		   if(member_master.equals("1")) member_master = "Master";
       		   else if(member_master.equals("2")) member_master = "Engineer";
       		   else member_master = "User";
       		   if(member_enable.equals("1")) member_enable = "사용가능";
    		   else member_enable = "사용정지";
    		   
       		   %>
<tr>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><font size="2pt"><%=result_obj.getM_id() %></font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><font size="2pt"><%=result_obj.getM_name() %></font></td>
<td width="7%" align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><font size="2pt"><%=result_obj.getM_linenum() %></font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><font size="2pt"><%=result_obj.getM_company() %></font></td>
<td width="7%" align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><font size="2pt"><%=result_obj.getM_place() %></font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><font size="2pt"><%=result_obj.getM_dept() %></font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><font size="2pt"><%=member_master%></font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><font size="2pt"><%=member_enable%></font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><font size="2pt"><input type="button" id="member_update" name="member_update" value="수정" onclick="window.open('./member/Updateform_admin.jsp?member_id=<%=result_obj.getM_id() %>&member_company=<%=member_company %>&member_place=<%=member_place %>&member_dept=<%=member_dept %>','','width=900,height=250,scrollbars=yes')" /></font></td>
</tr>
<%} %>
</table>
</form>
</body>
</html>