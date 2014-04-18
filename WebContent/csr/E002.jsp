<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="kr.co.mycom.csr.CSRDAO"%>
<%@ page import="kr.co.mycom.csr.CSRDTO"%>
<%@ page import="kr.co.mycom.code.*"%>
<%@ page import="kr.co.mycom.member.MemberDTO"%>
<%@ page import="kr.co.mycom.member.MemberDAO"%>

<%
String my_id = (String) session.getAttribute("ID");
String my_name = (String) session.getAttribute("NAME");
String master=(String) session.getAttribute("Master");

String bgcolor=""; //처리상태 글자색
String state=""; //처리상태

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

CSRDAO dao = new CSRDAO();

String estimate_solvetime = "";
String selected_company = "";


long time = System.currentTimeMillis(); 
SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
String time_in = dayTime.format(new Date(time)); //시간까지 모두 출력
String[] arrTime_in = time_in.split("-");	

int year = Integer.parseInt(arrTime_in[0]);
int month = Integer.parseInt(arrTime_in[1]);
int day = Integer.parseInt(arrTime_in[2]);

int year2 = Integer.parseInt(arrTime_in[0]);
int month2 = Integer.parseInt(arrTime_in[1]);
int day2 = Integer.parseInt(arrTime_in[2]);

String str_Linenum = memberInfo.getM_linenum();

List<CSRDTO> csrCode1List = dao.getCSRCode1List();
List<CSRDTO> csrSystemCategoryList = dao.getCSRSystemCategoryList();
List<CSRDTO> mCode1List = dao.getMCode1List();
  
List<CSRDTO> mCode2List = dao.getMCode2List();

List<CSRDTO> mCode3List = dao.getMCode3List();

List<CSRDTO> mStateList = dao.getStateList();

String selected = "selected = 'selected'";
String disabled = "disabled = 'disabled'";

CodeDAO codeDao = new CodeDAO();
List<CodeDTO> lCode1List = codeDao.getLCode1List();

String reqYear = request.getParameter("ComboreqYear");
String EndReqYear = request.getParameter("ComboEndReqYear");
String reqMonth = request.getParameter("ComboreqMonth");
String EndReqMonth = request.getParameter("ComboEndReqMonth");
if (reqYear == null){
	if(year<10) reqYear = "0"+Integer.toString(year);
	else reqYear = Integer.toString(year);
}
if (EndReqYear == null){
	if(year<10) EndReqYear = "0"+Integer.toString(year);
	else EndReqYear = Integer.toString(year);
}
if (reqMonth == null){
	if(month<10) reqMonth = "0"+Integer.toString(month);
	else reqMonth = Integer.toString(month);
}
if (EndReqMonth == null){
	if(month<10) EndReqMonth = "0"+Integer.toString(month);
	else EndReqMonth = Integer.toString(month);
}
String SearchStartDay = reqYear + reqMonth; // 요청일자
String SearchEndDay = EndReqYear + EndReqMonth;


String reqYear2 = request.getParameter("ComboreqYear2");
String EndReqYear2 = request.getParameter("ComboEndReqYear2");
String reqMonth2 = request.getParameter("ComboreqMonth2");
String EndReqMonth2 = request.getParameter("ComboEndReqMonth2");
	if (reqYear2 == null){
		if(year<10) reqYear2 = "0"+Integer.toString(year);
		else reqYear2 = Integer.toString(year);
	}
	if (EndReqYear2 == null){
		if(year<10) EndReqYear2 = "0"+Integer.toString(year);
		else EndReqYear2 = Integer.toString(year);
	}
	if (reqMonth2 == null){
		if(month<10) reqMonth2 = "0"+Integer.toString(month);
		else reqMonth2 = Integer.toString(month);
	}
	if (EndReqMonth2 == null){
		if(month<10) EndReqMonth2 = "0"+Integer.toString(month);
		else EndReqMonth2 = Integer.toString(month);
	}
String SearchStartDay2 = reqYear2 + reqMonth2;
String SearchEndDay2 = EndReqYear2 + EndReqMonth2;


String csr_rnum2 = request.getParameter("search_rnum");
String select_csr_system_category = request.getParameter("select_csr_system_category");
String select_csr_place = request.getParameter("select_csr_place");
String select_csr_dept = request.getParameter("select_csr_dept");
String select_csr_code1 = request.getParameter("select_csr_code1");
String select_csr_state = request.getParameter("select_csr_state");
String select_csr_member_company = request.getParameter("select_csr_member_company");
String search_name = request.getParameter("search_name");
String search_title = request.getParameter("search_title");

if (csr_rnum2 == null)
	csr_rnum2 = "";
if(select_csr_system_category == null)
	select_csr_system_category ="E_00000";
if (select_csr_code1 == null)
	select_csr_code1 = "C1_0000";
if (select_csr_state == null)
	select_csr_state ="";
if (select_csr_member_company == null) 
	select_csr_member_company =  memberInfo.getM_company();
if (select_csr_place == null) 
	select_csr_place = memberInfo.getM_place();
if (select_csr_dept == null) 
	select_csr_dept = memberInfo.getM_dept();
if (search_name == null)
	search_name="";
if(search_title==null)
	search_title="";



List<CSRDTO> result_lists = dao.showCSR(csr_rnum2,  SearchStartDay, SearchEndDay, SearchStartDay2, 
		SearchEndDay2, select_csr_system_category,  select_csr_place,  select_csr_dept,
		select_csr_code1, select_csr_state, select_csr_member_company, search_name, search_title);

%>
<script type="text/javascript">
function excel_post()
{
	var frm=E002;
	frm.action = 'csr/E002_excel.jsp';
	frm.submit();
	frm.action = './masterpage.jsp?bo_table=E002';
}

function showDetail(csr_rnum){ //팝업창 띄우는것
	var address = './csr/E003.jsp?csr_rnum=';
	<%-- if ('<%=memberInfo.getM_master()%>' == "0") {
		address = './csr/E003.jsp?csr_rnum=';
		}
	else {
		address = './csr/E003_admin.jsp?csr_rnum=';
	} --%> 
	
  	window.open('./csr/E003.jsp?csr_rnum='+csr_rnum,'','width=900, height=660, scrollbars=yes');
}


function select_state() {
	var selectValue = document.getElementById("select_csr_state");

		var i=0;
		var option;

		option=new Option('전체보기', '0');

		selectValue.options[i] = option;
		 i++;
		
		<% for(CodeDTO obj : lCode1List) { %>
		    if(selected_o_code1 == '<%=obj.getL_company()%>') {
			var option=new Option('<%=obj.getL_name()%>', '<%=obj.getL_code1()%>');

			selectValue.options[i] = option;		
			i++;
		    }
		<% }%>
}

function changePlaceOptions() {
	 var selectValue = document.getElementById("select_csr_place");
	 selectValue.length = 0;  //모두삭제
		
	    var csr_code1 = document.getElementById("select_csr_member_company");
		var selected_csr_code1 = csr_code1.options(csr_code1.selectedIndex).value;

		var i=0;
		var option;
		if(csr_code1=="C_00000"||csr_code1==null){
			 option=new Option('전체보기', 'P_00000');
			option.selected = true;
		}
		else{
			 option=new Option('전체보기', 'P_00000');
		}
		  selectValue.options[i] = option;
		  i++;
		<% for(CSRDTO obj : mCode2List) { %>
		    if(selected_csr_code1 == '<%=obj.getM_code1()%>') {
			var option=new Option('<%=obj.getM_code2_m_name()%>', '<%=obj.getM_code2()%>');
			if('<%=obj.getM_code2()%>' == '<%=select_csr_place%>') {
				option.selected = true;
			}

			selectValue.options[i] = option;		
			i++;
		    }
		<% }%>

		changeDeptOptions();
}

function changeDeptOptions(){
   var selectValue = document.getElementById("select_csr_dept");
   selectValue.length = 0;  //모두삭제
	
   var csr_code2 = document.getElementById("select_csr_place");
	var selected_csr_code2 = csr_code2.options(csr_code2.selectedIndex).value;

	var i=0;
	var option;
	if(selectValue=="P_00000"||selectValue==null){
		option=new Option('전체보기', 'D_00000');
		option.selected = true;
	}
	else{
		option=new Option('전체보기', 'D_00000');
	}
	  selectValue.options[i] = option;
	  i++;
	<% for(CSRDTO obj : mCode3List) { %>
	    if(selected_csr_code2 == '<%=obj.getM_code2()%>') {
		var option=new Option('<%=obj.getM_code3_m_name()%>', '<%=obj.getM_code3()%>');
		if('<%=obj.getM_code3()%>' == '<%=select_csr_dept%>') {
			option.selected = true;
		}

		selectValue.options[i] = option;		
		i++;
	    }
	<% }%>
}

function DayCheck(){
	if ((document.E002.ComboreqYear.value > document.E002.ComboEndReqYear.value) || (document.E002.ComboreqYear2.value > document.E002.ComboEndReqYear2.value)) { // 검색연도가
		alert('조회 기간을 다시 선택하여 주십시오 ');
		return false;
	}
	else if(((document.E002.ComboreqYear.value == document.E002.ComboEndReqYear.value) && (document.E002.ComboreqMonth.value > document.E002.ComboEndReqMonth.value)) ||
			((document.E002.ComboreqYear2.value == document.E002.ComboEndReqYear2.value) && (document.E002.ComboreqMonth2.value > document.E002.ComboEndReqMonth2.value))){
				alert('조회 기간을 다시 선택하여 주십시오 ');
		return false;
	}
	else{
		return true;
	}
	
}


function initialize(){
	location.href ="./masterpage.jsp?bo_table=E002";
}
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
  
<title>S-LITE</title>

<link rel="stylesheet" type="text/css" href="../common.css" />

</head>
<body onload="changePlaceOptions()">
<form name="E002" action="./masterpage.jsp?bo_table=E002"  method="post" onsubmit="return DayCheck()">
<table width="95%" align="center">
<tr>
<td align="left">● CSR ▶ CSR현황</td>
<td align="right">
<input type="button" value="초기화" onclick=initialize_all(); style="width: 100px; height: 30px; font-family: Gothic; font-size: 9pt"></input>
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
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">제목</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="search_title" name="search_title"  style="width: 98%; font-family: Gothic; font-size: 9pt" value=<%=search_title %>> </input></td>

<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청자 회사명</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select name="select_csr_member_company" id="select_csr_member_company" onchange="changePlaceOptions();" style="width: 98%; font-family: Gothic; font-size: 9pt"
<%=(master.equals("1") == false ? disabled : "")%>> 
		<option value="C_00000">전체보기</option>
<%
  for (CSRDTO m_code1_obj : mCode1List) { %>
      <option value=<%=m_code1_obj.getM_code1() %> <%=(select_csr_member_company.equals(m_code1_obj.getM_code1()) == true ? selected : "") %>><%=m_code1_obj.getM_code1_m_name()%></option>
	<%}%>
</select>
</td>
</tr>

<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">시스템 구분</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select name="select_csr_system_category" id="select_csr_system_category" style="width: 98%; font-family: Gothic; font-size: 9pt"> 
		<option value="E_00000">전체보기</option>
<%
  for (CSRDTO obj : csrSystemCategoryList) { %>
      <option value=<%=obj.getCSR_system_category()%> <%=(select_csr_system_category.equals(obj.getCSR_system_category()) == true ? selected : "") %>>
      <%=obj.getCSR_system_category_m_name()%></option>
<%}%>
</select>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청자 사업장명</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select name="select_csr_place" id="select_csr_place" onchange="changeDeptOptions();" style="width: 98%; font-family: Gothic; font-size: 9pt" 
<%=(master.equals("1") == false ? disabled : "")%>> 
	<option value="P_00000">전체보기</option>
<%	for(CSRDTO m_code2_obj : mCode2List) {%>
		<option value=<%=m_code2_obj.getM_code2() %> <%=(select_csr_place.equals(m_code2_obj.getM_code2()) == true ? selected : "") %>><%=m_code2_obj.getM_code2_m_name()%></option>
<%}%>
</select>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">CSR번호</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="search_rnum" name="search_rnum" style="width: 98%; font-family: Gothic; font-size: 9pt" value=<%=csr_rnum2 %>></input></td>

<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청부서명</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="select_csr_dept" name="select_csr_dept" style="width: 98%; font-family: Gothic; font-size: 9pt" 
<%=(master.equals("1") == false ? disabled : "")%>> 
	<option value="D_00000">전체보기</option>
<%	for(CSRDTO m_code3_obj : mCode3List) {%>
		<option value=<%=m_code3_obj.getM_code3() %> <%=(select_csr_dept.equals(m_code3_obj.getM_code3()) == true ? selected : "") %>><%=m_code3_obj.getM_code3_m_name()%></option>
<%}%>
</select>
</td>
</tr>

<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">CSR유형</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select name="select_csr_code1" id="select_csr_code1" style="width: 98%; font-family: Gothic; font-size: 9pt">
<option value="C1_0000">전체보기</option>
<%
  for (CSRDTO obj : csrCode1List) { %>
      <option value=<%=obj.getCSR_code1() %> <%=(select_csr_code1.equals(obj.getCSR_code1()) == true ? selected : "")%>>
      <%=obj.getCSR_code1_m_name()%></option>
<%}%>
</select>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청자 성명</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="search_name" name="search_name" style="width: 98%; font-family: Gothic; font-size: 9pt" value=<%=search_name %>></input></td>
</tr>

<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">처리상태</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select name="select_csr_state" id="select_csr_state" style="width: 98%; font-family: Gothic; font-size: 9pt">
<option value= "" <%=(select_csr_state.equals("") == true ? selected : "") %>>전체보기</option>
<option value = "0" <%=(select_csr_state.equals("0") == true ? selected : "") %>>요청</option>
<option value = "1" <%=(select_csr_state.equals("1") == true ? selected : "") %>>해결중</option>
<option value = "2" <%=(select_csr_state.equals("2") == true ? selected : "") %>>해결</option>
<option value = "3" <%=(select_csr_state.equals("3") == true ? selected : "") %>>종료</option>
</select>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청일자</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="ComboreqYear" name="ComboreqYear"
			style="width: 15%; font-family: Gothic; font-size: 9pt">
			<%
				for (int i = year - 5; i <= year + 5; i++) {
					if (reqYear == "") {
			%>
			<option value=<%=i%> <%=((year == i) == true ? selected : "")%>><%=i%></option>
			<%
				} else {
			%>
			<option value=<%=i%>
				<%=((Integer.parseInt(reqYear) == i) == true ? selected
									: "")%>><%=i%></option>
			<%
				}
			%>
			<%
				}
			%>
		</select>년 &nbsp; <select id="ComboreqMonth" name="ComboreqMonth"
			style="width: 10%; font-family: Gothic; font-size: 9pt">
			<%
				for (int i = 1; i <= 12; i++) {
						if (i < 10) {
			%>
			<option value=<%="0" + i%> <%=((Integer.parseInt(reqMonth) == i) == true ? selected : "")%>><%=i%></option>
			<%
				} else {
			%><option value=<%=i%> <%=((Integer.parseInt(reqMonth) == i) == true ? selected : "")%>><%=i%></option>
			<%
				}}
			%>
		</select>월 &nbsp; ~ &nbsp; <select id="ComboEndReqYear" name="ComboEndReqYear"
			onchange=yearChange()
			style="width: 15%; font-family: Gothic; font-size: 9pt">
			<%
				for (int i = year - 5; i <= year + 5; i++) {
					if (EndReqYear == "") {
			%>
			<option value=<%=i%> <%=((year == i) == true ? selected : "")%>><%=i%></option>
			<%
				} else {
			%>
			<option value=<%=i%>
				<%=((Integer.parseInt(EndReqYear) == i) == true ? selected
									: "")%>><%=i%></option>
			<%
				}
			%>
			<%
				}
			%>
		</select>년 &nbsp; <select id="ComboEndReqMonth" name="ComboEndReqMonth"
			style="width: 10%; font-family: Gothic; font-size: 9pt">
			<%
				for (int i = 1; i <= 12; i++) {
						if (i < 10) {
			%>
			<option value=<%="0" + i%> <%=((Integer.parseInt(EndReqMonth) == i) == true ? selected : "")%>><%=i%></option>
			<%
				} else {
			%><option value=<%=i%> <%=((Integer.parseInt(EndReqMonth) == i) == true ? selected : "")%>><%=i%></option>
			<%
				}}
			%>
		</select>월</td>




</tr>

<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">조치예정일</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="ComboreqYear2" name="ComboreqYear2"
			style="width: 15%; font-family: Gothic; font-size: 9pt">
			<%
				for (int i = year2 - 5; i <= year2 + 5; i++) {
					if (reqYear2 == "") {
			%>
			<option value=<%=i%> <%=((year == i) == true ? selected : "")%>><%=i%></option>
			<%
				} else {
			%>
			<option value=<%=i%>
				<%=((Integer.parseInt(reqYear2) == i) == true ? selected : "")%>><%=i%></option>
			<%
				}
			%>
			<%
				}
			%>
		</select>년 &nbsp; <select id="ComboreqMonth2" name="ComboreqMonth2" style="width: 10%; font-family: Gothic; font-size: 9pt">
			<%
				for (int i = 1; i <= 12; i++) {
						if (i < 10) {
			%>
			<option value=<%="0" + i%> <%=((Integer.parseInt(reqMonth2) == i) == true ? selected : "")%>><%=i%></option>
			<%
				} else {
			%><option value=<%=i%> <%=((Integer.parseInt(reqMonth2) == i) == true ? selected : "")%>><%=i%></option>
			<%
				}}
			%>
		</select>월 &nbsp; ~ &nbsp; <select id="ComboEndReqYear2" name="ComboEndReqYear2" onchange=yearChange() style="width: 15%; font-family: Gothic; font-size: 9pt">
			<%
				for (int i = year2 - 5; i <= year2 + 5; i++) {
					if (EndReqYear2 == "") {
			%>
			<option value=<%=i%> <%=((year2 == i) == true ? selected : "")%>><%=i%></option>
			<%
				} else {
			%>
			<option value=<%=i%>
				<%=((Integer.parseInt(EndReqYear2) == i) == true ? selected : "")%>><%=i%></option>
			<%
				}
			%>
			<%
				}
			%>
		</select>년 &nbsp; <select id="ComboEndReqMonth2" name="ComboEndReqMonth2" style="width: 10%; font-family: Gothic; font-size: 9pt">
			<%
				for (int i = 1; i <= 12; i++) {
						if (i < 10) {
			%>
			<option value=<%="0" + i%> <%=((Integer.parseInt(EndReqMonth2) == i) == true ? selected : "")%>><%=i%></option>
			<%
				} else {
			%><option value=<%=i%> <%=((Integer.parseInt(EndReqMonth2) == i) == true ? selected : "")%>><%=i%></option>
			<%
				}}
			%>
		</select>월</td>
	<td colspan="2" width="50%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold"></td>

</tr>

</table>
<br>
</form>
<table>
	<tr><td><%=result_lists.size()%>개의 자료가 검색되었습니다.</td></tr>
</table>

<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
<tr>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">번호</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">시스템구분</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">CSR번호</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청자 부서명</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청자 성명</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청제목</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">CSR유형</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">처리상태</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청일자</font></td>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">조치예정일</font></td>
</tr>
<%int i = 1; %>
	<% for(CSRDTO result_obj : result_lists) { 
		 
	if(result_obj.getCSR_state().equals("0")){ bgcolor ="#da291c"; state = "요청"; estimate_solvetime = "접수 전";} 
	else if(result_obj.getCSR_state().equals("1")){ bgcolor ="#daa520"; state = "해결중"; estimate_solvetime = result_obj.getCSR_estimate_solvetime();}
	else if(result_obj.getCSR_state().equals("2")){ bgcolor ="#800080"; state = "해결"; estimate_solvetime = result_obj.getCSR_estimate_solvetime();} //
	else{ bgcolor ="#483d8b"; state = "종료"; estimate_solvetime = result_obj.getCSR_estimate_solvetime();}%>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%= i%></td><%i++; %>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_system_category_m_name()%></td>
<td align="center" onclick="showDetail('<%=result_obj.getCSR_rnum()%>');" class="black" valign="middle" bgcolor="ffffff"><a href=# class=no-uline><font color = "black"><b><%=result_obj.getCSR_rnum()%></b></font></a></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getM_code3_m_name()%></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getMember_name()%></td>
<% if((result_obj.getCSR_title().length())>5){ %>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_title().substring(0,6)%>..</td>
<%}else{ %>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_title()%></td>
<%} %>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_code1_m_name()%></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><font color="<%=bgcolor %>"><b><%=state%></b></font></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_requesttime()%></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=estimate_solvetime%></td>

</tr>
<%}%>
</table>
<script>changePlaceOptions();</script>
</body>
</html>