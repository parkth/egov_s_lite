<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.asset.*"%>
<%@ page import="kr.co.mycom.member.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File "%>
<%@ page import="java.text.SimpleDateFormat"%>
    
<jsp:useBean id="asset" class="kr.co.mycom.asset.AssetDTO" />
<jsp:setProperty property="*" name="asset" />
<%
String my_id = (String) session.getAttribute("ID");
String Master = (String) session.getAttribute("Master");
MemberDAO memDao = new MemberDAO();
MemberDTO memberInfo = memDao.searchMember(my_id);

if(my_id == null || my_id.equals("null")){
	%>
		<script type = "text/javascript">
		alert("로그인하지 않으면 접근할 수 없습니다.");
		history.back();
		</script>
	<%
}

long time = System.currentTimeMillis(); 
SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM");
String time_in = dayTime.format(new Date(time)); //시간까지 모두 출력
String[] arrTime_in = time_in.split("-");	
int curYear = Integer.parseInt(arrTime_in[0]);
int curMonth = Integer.parseInt(arrTime_in[1]);

String selectedCode1 = null;
String selected = "selected = 'selected'";
String a_company = request.getParameter("a_company");
String a_place = request.getParameter("a_place");
String a_dept = request.getParameter("a_dept");
String a_code1= request.getParameter("a_code1");
String a_code2= request.getParameter("a_code2");
String a_code3= request.getParameter("a_code3");
if(a_code1==null){
	a_code1="A1_0000";
}
if(a_code2==null){
	a_code2="A2_0000";
}
if(a_code3==null){
	a_code3="A3_0000";
}
if (a_company == null) {
	a_company = memberInfo.getM_company();
}
if (a_place == null) {
	a_place = memberInfo.getM_place();
}
if (a_dept == null) {
	a_dept = memberInfo.getM_dept();
}

//////////////날짜///////////////////////////////////////////////////////////////////////////////////////
String a_anum = request.getParameter("a_anum");
String a_gnum= request.getParameter("a_gnum");
String a_locate= request.getParameter("a_locate");
String a_aname= request.getParameter("a_aname");

String a_name= request.getParameter("a_name");
String a_amodel= request.getParameter("a_amodel");
String a_id= request.getParameter("a_id");
String a_vendorname = request.getParameter("a_vendorname");
if (a_anum == null) { a_anum = ""; }
if (a_gnum == null) { a_gnum = ""; }
if (a_locate == null) { a_locate = ""; }
if (a_aname == null) { a_aname = ""; }
if (a_name == null) { a_name = ""; }
if (a_amodel == null) { a_amodel = ""; }
if (a_id == null) { a_id = ""; }
if (a_vendorname == null) { a_vendorname = ""; }

//사용자
if (Master.equals("0") == true) {
	a_company = memberInfo.getM_company();
	a_place = memberInfo.getM_place();
	a_dept = memberInfo.getM_dept();
	a_name = memberInfo.getM_name();
	a_id = memberInfo.getM_id();
}
//Engineer
else if (Master.equals("2") == true) {
	a_company = memberInfo.getM_company();
}
asset.setA_company(a_company);
asset.setA_place(a_place);
asset.setA_dept(a_dept);

////////////////////////////////////////////////////////////////////////////
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String add_year = request.getParameter("add_year");
	String add_month = request.getParameter("add_month");
	if (year == null)
		year = "";
	if (month == null)
		month = "";
	if (add_year == null)
		add_year = "";
	if (add_month == null)
		add_month = "";
AssetDAO dao = new AssetDAO();
List<AssetDTO> m_code1_lists = dao.search_mcode1();
List<AssetDTO> m_code2_lists = dao.search_mcode2();
List<AssetDTO> m_code3_lists = dao.search_mcode3();

List<AssetDTO> a_code1_lists = dao.search_acode1();
List<AssetDTO> a_code2_lists = dao.search_acode2();
List<AssetDTO> a_code3_lists = dao.search_acode3();

List<AssetDTO> result_lists = dao.searchcode(asset);

String readOnly = "readOnly = 'readOnly'";
String disabled = "disabled = 'disabled'";

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
  
<script type="text/javascript">

function excel_post()
{
	var frm=C002_form;
	frm.action = 'asset/C002_excel.jsp';
	frm.submit();
	frm.action = './masterpage.jsp?bo_table=C002';
}

function select_mcode2(){ //회사 전체보기
    var selectValue = document.getElementById("a_place");
    C002_form.a_place.options.length = 0;  //모두삭제
    C002_form.a_dept.options.length = 0;  //모두삭제
	
    var value_mcode1 = document.getElementById("a_company");
	var mcode1 = value_mcode1.options(value_mcode1.selectedIndex).value;	
	var place='<%=a_place%>';
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
		<%for (AssetDTO m_code2_obj : m_code2_lists) {%>if(mcode1 == '<%=m_code2_obj.getM_code1()%>'){
				if('<%=m_code2_obj.getM_enable()%>' == '1'){
				var option=new Option('<%=m_code2_obj.getM_name()%>', '<%=m_code2_obj.getM_code2()%>');
				if('<%=m_code2_obj.getM_code2()%>' == '<%=a_place%>'){
					option.selected = true;
				}
				selectValue.options[i] = option;
				i++;
				}
			}	
		<%}%>
	
		
		select_mcode3();
}

function select_mcode3(){ //사업장 전체 보기
    var selectValue = document.getElementById("a_dept");
    C002_form.a_dept.options.length = 0;  //모두삭제
    var dept='<%=a_dept%>';
	var value_mcode2 = document.getElementById("a_place");
	var mcode2 = value_mcode2.options(value_mcode2.selectedIndex).value;
	var i=0;
	var option;
	if(dept=="D_00000"||dept==null){
		option=new Option('전체보기', 'D_00000');
		option.selected = true;
	}
	else{
		option=new Option('전체보기', 'D_00000');
	}
	  selectValue.options[i] = option;
	  i++;
		<%for (AssetDTO m_code3_obj : m_code3_lists) {%>if(mcode2 == '<%=m_code3_obj.getM_code1()%>'){
			if('<%=m_code3_obj.getM_enable()%>' == '1'){
			var option=new Option('<%=m_code3_obj.getM_name()%>', '<%=m_code3_obj.getM_code2()%>');
				if('<%=m_code3_obj.getM_code2()%>' == '<%=a_dept%>'){
					option.selected = true;
				} 
				selectValue.options[i] = option;
				  i++;
			}
			}
		<%}%>
	
}

function select_acode2(){ //자산 구분 전체 보기
    var selectValue = document.getElementById("a_code2");
    C002_form.a_code2.options.length = 0;  //모두삭제
    C002_form.a_code3.options.length = 0;  //모두삭제
	var a_code2='<%=a_code2%>';
	var i=0;
	var option;
	var value_acode1 = document.getElementById("a_code1");
	var acode1 = value_acode1.options(value_acode1.selectedIndex).value;
	if(a_code2=="A2_0000"||a_code2==null){
		option=new Option('전체보기', 'A2_0000');
		option.selected = true;
	}
	else{
		option=new Option('전체보기', 'A2_0000');
	}
	  selectValue.options[i] = option;
	  i++;
		<%	for(AssetDTO a_code2_obj : a_code2_lists) {
			%>if(acode1 == '<%=a_code2_obj.getA_code1()%>'){
				if('<%=a_code2_obj.getA_enable()%>' == '1'){

				var option=new Option('<%=a_code2_obj.getA_name()%>', '<%=a_code2_obj.getA_code2()%>');
				if('<%=a_code2_obj.getA_code2()%>' == '<%=a_code2%>'){
					option.selected = true;
				} 
				selectValue.options[i] = option;
				  i++;
				}
			}	
		<%}%>

		select_acode3();
}
function select_acode3(){ //자산 종류 전체 보기
    var selectValue = document.getElementById("a_code3");
    C002_form.a_code3.options.length = 0;  //모두삭제
    var a_code3= '<%=a_code3%>';
	var i=0;
	var option;
    var value_acode2 = document.getElementById("a_code2");
	var acode2 = value_acode2.options(value_acode2.selectedIndex).value;
	if(a_code3=="A3_0000"||a_code3==null){
		option=new Option('전체보기', 'A3_0000');
		option.selected = true;
	}
	else{
		option=new Option('전체보기', 'A3_0000');
	}
	  selectValue.options[i] = option;
	  i++;
		<%	for(AssetDTO a_code3_obj : a_code3_lists) {
			%>if(acode2 == '<%=a_code3_obj.getA_code1()%>'){
				if('<%=a_code3_obj.getA_enable()%>' == '1'){

				var option=new Option('<%=a_code3_obj.getA_name()%>', '<%=a_code3_obj.getA_code2()%>');
				if('<%=a_code3_obj.getA_code2()%>' == '<%=a_code3%>'){
					option.selected = true;
				} 
				selectValue.options[i] = option;
				i++;
				}
			}	
		<%}		%>
}

	function makedate(){
		document.C002_form.a_getdate.value = document.C002_form.year.value + "-"
		+ document.C002_form.month.value;
		
		document.C002_form.a_adddate.value = document.C002_form.add_year.value + "-"
		+ document.C002_form.add_month.value;
	}

	function show_detail(anum){
		if('<%=Master%>' == '1'){
			window.open('./asset/C003_admin.jsp?anum='+anum,'','width=900,height=500,scrollbars=yes');
		}else {
			window.open('./asset/C003.jsp?anum='+anum,'','width=900,height=500,scrollbars=yes');
		}
	}
	function initialize(){
		makedate();
		document.C002_form.submit();
	}
	function initialize_all(){
		location.href="./masterpage.jsp?bo_table=C002";
	}
</script>

<title>S-LITE</title>
</head>
<body onload="select_mcode2();select_acode2();change(1);change();">
<form name="C002_form" action=".\masterpage.jsp?bo_table=C002" method="post" onsubmit="makedate()">
<table width="95%" align="center">
<tr>
<td align="left">● 자산관리대장 ▶ 자산관리현황</td>
<td align="right">
<input type="button" value="초기화" onclick=initialize_all();
			style="width: 100px; height: 30px; font-family: Gothic; font-size: 9pt"></input>
<input type="submit" value="조회" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt"></input>
<input type="button" value="다운로드" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt" onclick="javascript:excel_post()"></input></td>
</tr>
</table>
<table>
		<tr>
			<td style="height: 30px"></td>
		</tr>
	</table>
<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산번호</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_anum" value='<%=a_anum %>' name="a_anum" style="width: 98%; font-family: Gothic; font-size: 9pt"/>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">관리번호</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_gnum" name="a_gnum" value='<%=a_gnum %>' style="width: 98%; font-family: Gothic; font-size: 9pt"/>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">회사</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_company" name="a_company" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_mcode2()" <%=(Master.equals("1") == false ? disabled : "")%>>
			<option value="C_00000">전체보기</option>
			<%	for(AssetDTO m_code1_obj : m_code1_lists) {
					if(m_code1_obj.getM_enable().equals("1")){%>
					<option value=<%=m_code1_obj.getM_code1() %> <%=(a_company.equals(m_code1_obj.getM_code1()) == true ? selected : "") %>><%=m_code1_obj.getM_name()%></option>
						<%	
					}
					} %>
</select>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산 구분</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_code1" name="a_code1" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_acode2()">
			<option value="A1_0000">전체보기</option>
			<%	for(AssetDTO a_code1_obj : a_code1_lists) {
					if(a_code1_obj.getA_enable().equals("1")){%>
					<option value=<%=a_code1_obj.getA_code1()  %> <%=(a_code1.equals(a_code1_obj.getA_code1()) == true ? selected : "") %>><%=a_code1_obj.getA_name()%></option>
						<%	}
					} %>
</select>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">사업장</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_place" name="a_place"style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_mcode3()" <%=(Master.equals("0") == true ? disabled : "")%>>
</select>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산 종류</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_code2" name="a_code2" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_acode3()">
</select>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">부서</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_dept" name="a_dept" style="width: 100%; font-family: Gothic; font-size: 9pt" <%=(Master.equals("0") == true ? disabled : "")%>>
</select>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산 유형</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_code3" name="a_code3" style="width: 100%; font-family: Gothic; font-size: 9pt">
</select>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">위치</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_locate" name="a_locate" value='<%=a_locate %>' style="width: 98%; font-family: Gothic; font-size: 9pt"/>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">품명</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_aname" name="a_aname" value='<%=a_aname %>' style="width: 98%; font-family: Gothic; font-size: 9pt"/>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">이름</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_name" name="a_name"  value='<%=a_name %>' style="width: 98%; font-family: Gothic; font-size: 9pt" <%=(Master.equals("0") == true ? readOnly : "")%>/>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">Model</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_amodel" name="a_amodel" value='<%=a_amodel %>' style="width: 98%; font-family: Gothic; font-size: 9pt"/>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">ID</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_id" name="a_id"  value='<%=a_id %>' style="width: 98%; font-family: Gothic; font-size: 9pt"/ <%=(Master.equals("0") == true ? readOnly : "")%>>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">제조사</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_vendorname" name="a_vendorname"  value='<%=a_vendorname %>' style="width: 98%; font-family: Gothic; font-size: 9pt"/>
</td>
</tr>

<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">취득일</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select  id="year" name="year" onchange="change(1)" style="width:30%;">
			<%
				for (int i = curYear - 5; i <= curYear + 5; i++) {
					if (year.equals("")) {
				%>
				<option value=<%=i%> <%=((curYear == i) == true ? selected : "")%>><%=i%></option>
				<%
					} else {
				%>
				<option value=<%=i%>
					<%=((Integer.parseInt(year) == i) == true ? selected
										: "")%>><%=i%></option>
				<%
					}
				}
			%>
</select>년
<select id="month" name="month" onchange="change(1)" style="width:20%;">
			<%
			for (int i = 1; i <= 12; i++) {
			if (month.equals("")) {
			%><option value=<%=i%> <%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
			<%
			}else {
			%>
			<option value=<%=i%> <%=((Integer.parseInt(month) == i) == true ? selected : "")%>><%=i%></option>
			<%
				}
			}
			%>
</select>월
<input type="hidden" id="a_getdate" name="a_getdate"/>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">등록일</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select  id="add_year" name="add_year" onchange="change()" style="width:30%;">
			<%
				for (int i = curYear - 5; i <= curYear + 5; i++) {
					if (add_year.equals("")) {
				%>
				<option value=<%=i%> <%=((curYear == i) == true ? selected : "")%>><%=i%></option>
				<%
					} else {
				%>
				<option value=<%=i%>
					<%=((Integer.parseInt(add_year) == i) == true ? selected
										: "")%>><%=i%></option>
				<%
					}
				}
			%>
</select>년
<select id="add_month" name="add_month" onchange="change()" style="width:20%;">
			<%
			for (int i = 1; i <= 12; i++) {
			if (add_month.equals("")) {
			%>
			<option value=<%=i%> <%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
			<%
			}else {
			%>
			<option value=<%=i%> <%=((Integer.parseInt(add_month) == i) == true ? selected : "")%>><%=i%></option>
			<%
				}
			}
			%>
</select>월
<input type="hidden" id="a_adddate" name="a_adddate"/>
<input type="hidden" id="l_detail" name="l_detail" /> 
</td>
</tr>

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
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산번호</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">관리번호</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산구분</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산종류</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산유형</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">품명</font></td>
<td width="7%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">Model</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">제조사</font></td>
<td width="7%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">회사</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">사업장</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">부서</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">위치</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">이름</font></td>
<td width="6%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">취득일</font></td>
<td width="6%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">사용여부</font></td>

</tr>
			<% for(AssetDTO result_obj : result_lists) {%>
<tr>
<% if(result_obj.getA_enable().equals("1") || result_obj.getA_enable().equals("3")){ %>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff" onclick="show_detail('<%=result_obj.getA_anum()%>')"><a href=# class=no-uline><font color="#666666"><%=result_obj.getA_anum() %></font></a></td>
<%} else{ %>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff" onclick="show_detail('<%=result_obj.getA_anum()%>')"><a href=# class=no-uline><font color="#DA291C"><%=result_obj.getA_anum() %></font></a></td>
<%} %>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_gnum() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_code1() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_code2() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_code3() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_aname() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_amodel() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_vendorname() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_company() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_place() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_dept() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_locate() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_name() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_getdate() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=(result_obj.getA_enable().equals("1") == true ? "사용가능" : "사용정지")%></td>
</tr>
<%
}%>
</table>
<script>select_mcode2();select_acode2();change(1);change();</script>
</form>
<% if (Master.equals("0") == true) { // 사용자 %>
<input type="hidden" id="a_company" name="a_company" value="<%=a_company %>" />
<input type="hidden" id="a_place" name="a_place" value="<%=a_place %>" />
<input type="hidden" id="a_dept" name="a_dept" value="<%=a_dept %>" />
<% }
	else if (Master.equals("2") == true) { // Engineer %>
<input type="hidden" id="a_company" name="a_company" value="<%=a_company %>" />
<% } %>
</body>
</html>