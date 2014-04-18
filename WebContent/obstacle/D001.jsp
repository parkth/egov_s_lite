<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="kr.co.mycom.member.*"%>
<%@ page import="kr.co.mycom.code.*"%>
<%@ page import="kr.co.mycom.obstacle.ObstacleDAO"%>
<%@ page import="kr.co.mycom.obstacle.ObstacleDTO"%>

<%
    	String my_id = (String) session.getAttribute("ID");
		String my_name = (String) session.getAttribute("NAME");
		String master = (String) session.getAttribute("Master");

		if(my_id == null || my_id.equals("null")){
			%>
				<script type = "text/javascript">
				alert("로그인하지 않으면 접근할 수 없습니다.");
				history.back();
				</script>
			<%
		}
		if(master.equals("0")){
			%>
				<script type = "text/javascript">
				alert("관리자가 아니면 접근할 수 없습니다.");
				history.back();
				</script>
			<%
		}

        MemberDAO memDao = new MemberDAO();
        MemberDTO memberInfo = memDao.searchMember(my_id);
        String engineer_company = "";
        
        if (master.equals("2") == true) { // Engineer
        	engineer_company = memberInfo.getM_company();
    	}

        long time = System.currentTimeMillis(); 
        SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
        String time_in = dayTime.format(new Date(time)); //시간까지 모두 출력
        String[] arrTime_in = time_in.split("-");	
        int curYear = Integer.parseInt(arrTime_in[0]);
        int curMonth = Integer.parseInt(arrTime_in[1]);
        int curDay = Integer.parseInt(arrTime_in[2]);
        int curHour = Integer.parseInt(arrTime_in[3]);
        int curMinute = Integer.parseInt(arrTime_in[4]);

        ObstacleDAO obsDao = new ObstacleDAO();
        List<ObstacleDTO> obsCode1List = obsDao.getOCode1List();
        List<ObstacleDTO> obsCode2List = obsDao.getOCode2List();
        List<ObstacleDTO> mCode1List = obsDao.getMCode1List();
        List<ObstacleDTO> mCode2List = obsDao.getMCode2List();
        List<ObstacleDTO> mCode3List = obsDao.getMCode3List();
        
        String selected = "selected = 'selected'";
        String readOnly = "readOnly = 'readOnly'";
    	String disabled = "disabled = 'disabled'";
        
        CodeDAO codeDao = new CodeDAO();
    	List<CodeDTO> lCode1List = codeDao.getLCode1List();
    %>

<script type="text/javascript">

function change(isRequest){ //1 3 5 781012 날짜가 변했을때
	var selectedYear = null;
	var selectedYearValue = null;
	var selectedMonth = null;
	var selectedMonthValue = null;
	var selectObject= null;
	var lastDay = null;
	
	if (isRequest == 1) {
		selectedYear = document.getElementById("req_year");
		selectedMonth = document.getElementById("req_month");
		selectObject=document.getElementById("req_day");
	}
	else {
		selectedYear = document.getElementById("occur_year");	
		selectedMonth = document.getElementById("occur_month");	
		selectObject=document.getElementById("occur_day");
	}

	selectedYearValue = selectedYear.options[selectedYear.selectedIndex].value;
	selectedMonthValue = selectedMonth.options[selectedMonth.selectedIndex].value;
	selectObject.length=0; //날짜 초기화
	
	lastDay = new Date(selectedYearValue, selectedMonthValue, 0).getDate();

	for (var i=1; i<=lastDay; i++) {
		if(i<10){
			var option=new Option(i,"0"+(i));}
		else 
			var option=new Option(i,i);
		
		// 현재 년,월,일이 일치하는 경우에만 날짜를 현재 일로 셋팅. 월이나 년 바꾸면 1일이 기본 됨.
		if(i == <%=curDay%> && selectedMonthValue==<%=curMonth%> && selectedYearValue==<%=curYear%>){		
			option.selected=true;
		}
		selectObject.options[i-1] = option; // index는 0부터 시작.
	}
}

function changeCode2Options(){
    var selectValue = document.getElementById("select_o_code2");
    selectValue.length = 0;  //모두삭제
	
    var o_code1 = document.getElementById("select_o_code1");
	var selected_o_code1 = o_code1.options(o_code1.selectedIndex).value;

	var i=0;
	<% for(ObstacleDTO obj : obsCode2List) { %>
	    if(selected_o_code1 == '<%=obj.getO_code1()%>') {
		var option=new Option('<%=obj.getCode2_m_name()%>', '<%=obj.getO_code2()%>');
		selectValue.options[i] = option;
		i++;
	    }
	<% }%>
}

function changeGradeOptions() {
	 var selectValue = document.getElementById("o_grade");
	 selectValue.length = 0;  //모두삭제
		
	    var o_code1 = document.getElementById("select_o_member_company");
		var selected_o_code1 = o_code1.options(o_code1.selectedIndex).value;

		var i=0;

		var i=0;
		var option;
		if(o_code1=="C_00000"||o_code1==null){
			 option=new Option('전체보기', 'L1_0000');
			option.selected = true;
		}
		else{
			 option=new Option('전체보기', 'L1_0000');
		}
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
	 var selectValue = document.getElementById("select_o_place");
	 selectValue.length = 0;  //모두삭제
		
	    var csr_code1 = document.getElementById("select_o_member_company");
		var selected_csr_code1 = csr_code1.options(csr_code1.selectedIndex).value;

	
		var i=0;
		var option;
		if(csr_code1.value=="C_00000"||csr_code1.value==null){
			 option=new Option('전체보기', 'P_00000');
			option.selected = true;
		}
		else{
			 option=new Option('전체보기', 'P_00000');
		}
		  selectValue.options[i] = option;
		  i++;
		<% for(ObstacleDTO obj : mCode2List) { %>
		    if(selected_csr_code1 == '<%=obj.getM_code1()%>') {
			var option=new Option('<%=obj.getM_code2_m_name()%>', '<%=obj.getM_code2()%>');
			if('<%=obj.getM_code2()%>' == '<%=memberInfo.getM_place()%>') {
				option.selected = true;
			}

			selectValue.options[i] = option;		
			i++;
		    }
		<% }%>
		changeDeptOptions();
}

function changeDeptOptions(){
   var selectValue = document.getElementById("select_o_dept");
   selectValue.length = 0;  //모두삭제
	
   var csr_code2 = document.getElementById("select_o_place");
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
	<% for(ObstacleDTO obj : mCode3List) { %>
	    if(selected_csr_code2 == '<%=obj.getM_code2()%>') {
		var option=new Option('<%=obj.getM_code3_m_name()%>', '<%=obj.getM_code3()%>');
		if('<%=obj.getM_code3()%>' == '<%=memberInfo.getM_dept()%>') {
			option.selected = true;
		}

		selectValue.options[i] = option;		
		i++;
	    }
	<% }%>
}

function check() {	

	if (document.add_obstacle_form.o_title.value == "") {
		alert("제목을 입력하세요");
		document.add_obstacle_form.o_title.focus();
		return false;
	}
	
	if (document.add_obstacle_form.o_title.value.length > 100) {
		alert("제목은 50자 이상 입력할 수 업습니다.");
		document.add_obstacle_form.o_title.focus();
		return false;
	}
	
	if (document.add_obstacle_form.o_asset.value == "") {
		alert("제품명을 입력하세요");
		document.add_obstacle_form.o_asset.focus();
		return false;
	}
	if (document.add_obstacle_form.o_asset.value.length > 40) {
		alert("제품명은 20자 이상 입력할 수 없습니다.");
		document.add_obstacle_form.o_asset.focus();
		return false;
	}
	if (document.add_obstacle_form.o_member_name.value == "") {
		alert("요청고객명을 입력하세요");
		document.add_obstacle_form.o_member_name.focus();
		return false;
	}
	if (document.add_obstacle_form.o_member_name.value == "") {
		alert("요청고객명을 입력하세요");
		document.add_obstacle_form.o_member_name.focus();
		return false;
	}
	if (document.add_obstacle_form.o_member_name.value.length > 20) {
		alert("요청고객명은 영어 12자 이상 입력할 수 없습니다.");
		document.add_obstacle_form.o_member_name.focus();
		return false;
	}
	if (isNaN(document.add_obstacle_form.o_member_phone1.value)) { //isNaN(is not a number) 은 숫자를 입력하지 않을경우
		alert("연락처에는 숫자만 입력하세요");
		document.add_obstacle_form.o_member_phone1.focus();
		return false;
	}
	if (isNaN(document.add_obstacle_form.o_member_phone2.value)) { //isNaN(is not a number) 은 숫자를 입력하지 않을경우
		alert("연락처에는 숫자만 입력하세요");
		document.add_obstacle_form.o_member_phone2.focus();
		return false;
	}
	if (isNaN(document.add_obstacle_form.o_member_phone3.value)) { //isNaN(is not a number) 은 숫자를 입력하지 않을경우
		alert("연락처에는 숫자만 입력하세요");
		document.add_obstacle_form.o_member_phone3.focus();
		return false;
	}
	if (document.add_obstacle_form.o_member_phone1.value == "") {
		alert("고객연락처를 입력하세요");
		document.add_obstacle_form.o_member_phone1.focus();
		return false;
	}
	if (document.add_obstacle_form.o_member_phone2.value == "") {
		alert("고객연락처를 입력하세요");
		document.add_obstacle_form.o_member_phone2.focus();
		return false;
	}
	if (document.add_obstacle_form.o_member_phone3.value == "") {
		alert("고객연락처를 입력하세요");
		document.add_obstacle_form.o_member_phone3.focus();
		return false;
	}
	if (document.add_obstacle_form.o_detail.value == "") {
		alert("장애현상을 입력하세요");
		document.add_obstacle_form.o_detail.focus();
		return false;
	}
	
	if (document.add_obstacle_form.o_detail.value.length > 1000) {
		alert("장애현상은 500자 이상 입력할 수 없습니다.");
		document.add_obstacle_form.o_detail.focus();
		return false;
	}
	if (document.add_obstacle_form.select_o_member_company.value == "C_00000") {
		alert("회사를 선택하세요");
		document.add_obstacle_form.select_o_member_company.focus();
		return false;
	}
	if (document.add_obstacle_form.select_o_place.value == "P_00000") {
		alert("사업장을 선택하세요 ");
		document.add_obstacle_form.select_o_place.focus();
		return false;
	}
	if (document.add_obstacle_form.select_o_dept.value == "D_00000") {
		alert("부서를 선택하세요");
		document.add_obstacle_form.select_o_dept.focus();
		return false;
	}
	if (document.add_obstacle_form.o_grade.value == "L1_0000") {
		alert("장애등급을 선택하세요");
		document.add_obstacle_form.o_grade.focus();
		return false;
	}
	
	if(document.add_obstacle_form.o_vendor.value.length > 20){
		alert("벤더명은 10자 이상 입력할 수 없습니다.");
		document.add_obstacle_form.o_vendor.focus();
		return false;
	}

	var isSelected = false;

	isSelected = false;
	for (var i=0; i<document.add_obstacle_form.o_request_path.length; i++) {
		if (document.add_obstacle_form.o_request_path[i].checked) {
			isSelected = true;
		}
	}
	if (isSelected == false) {
		alert("접수경로를 선택하세요");
		return false;
	}
	
	return true;
}

function goBack() {
	location.href ="./obstacle/D001_customer.jsp";
}

var count = 0;
var addCount;

// 첨부파일
function addInputBox() {
	for(var i=1; i<=count; i++) {
		if(!document.getElementsByName("test"+i)[0]) {
			addCount = i;
			break;
		}
	  	else addCount = count;
	}

	var addStr = "<tr><td><input type=checkbox name=checkList value="+addCount+" size='10%'></td><td><input type=file name=test"+addCount+" size='120%'></td></tr>";
	var table = document.getElementById("dynamic_file_table");
	var newRow = table.insertRow();
	var newCell = newRow.insertCell();
	newCell.innerHTML = addStr;

	count++;
}
	 	 
	 
//행삭제	 
function subtractInputBox() {
	var table = document.getElementById("dynamic_file_table");
	var rows = dynamic_file_table.rows.length;
	var chk = 0;

	if(rows > 0){
		
		// 처음에 한 줄 만들었다가 삭제하려고 할 때 length undefined.	
		if (document.add_obstacle_form.checkList.length == undefined) {
			if (document.add_obstacle_form.checkList.checked == true) {
				table.deleteRow(0);
				count--;
				chk++;	
			}
		}
		for (var i=0; i<document.add_obstacle_form.checkList.length; i++) {
			if (document.add_obstacle_form.checkList[i].checked == true) {
				table.deleteRow(i);
				i--;
				count--;
				chk++;
			}
		}
		if(chk <= 0){
			alert("삭제할 행을 체크해 주세요.");
		}
	}
	else {
		alert("더이상 삭제할 수 없습니다.");
	}
}

</script>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>S-LITE</title>
<link rel="stylesheet" type="text/css" href="common.css" />
</head>
<body>
<form name="add_obstacle_form" action="./masterpage.jsp?bo_table=D001_add" method="post" enctype="multipart/form-data" onsubmit="return check()">
<table width="95%" align="center">
<tr>
<td align="left">● 장애관리대장 ▶ 장애등록</td>
<td align="right">
<input type="submit" id="btnView" value="등록" 	style="width: 120px; height: 30px; font-family: Gothic; font-size: 9pt" />
</td></tr>
</table>
<table>
		<tr>
			<td style="height: 30px"></td>
		</tr>
</table>

<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">제목</font></td>
<td align="center" valign="middle" bgcolor="ffffff" width="40%">
<input type="text" name="o_title"  style="width: 98%; font-family: Gothic; font-size: 9pt"></input>
</td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">회사</font></td>
<td align="center" valign="middle" bgcolor="ffffff" width="40%">
<select name="select_o_member_company" id="select_o_member_company" onchange="changePlaceOptions();" style="width: 98%; font-family: Gothic; font-size: 9pt"
<%=(master.equals("1") == false ? disabled : "")%>> 
		<option value="C_00000">전체보기</option>
<% for (ObstacleDTO m_code1_obj : mCode1List) { %>
      <option value=<%=m_code1_obj.getM_code1() %> <%=(memberInfo.getM_company().equals(m_code1_obj.getM_code1()) == true ? selected : "") %>><%=m_code1_obj.getM_code1_m_name()%></option>
	<%}%>
</select>
</td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">대분류</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<select name="select_o_code1" id="select_o_code1" onchange="changeCode2Options();" style="width: 98%; font-family: Gothic; font-size: 9pt">
<%
  for (ObstacleDTO obj : obsCode1List) { %>
      <option value=<%=obj.getO_code1() %>><%=obj.getCode1_m_name()%></option>
<%}%>
</select></td>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">사업장</font></td>
<td align="center" valign="middle" bgcolor="ffffff" width="40%">
<select name="select_o_place" id="select_o_place" onchange="changeDeptOptions();" style="width: 98%; font-family: Gothic; font-size: 9pt" 
<%=(master.equals("1") == false ? disabled : "")%>> 
	<option value="P_00000">전체보기</option>
<%
for(ObstacleDTO m_code2_obj : mCode2List) {%>
	<option value=<%=m_code2_obj.getM_code2() %> <%=(memberInfo.getM_place().equals(m_code2_obj.getM_code2()) == true ? selected : "") %>><%=m_code2_obj.getM_code2_m_name()%></option>
<%} %>
</select>
</td>


</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">중분류(업무구분)</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<select name="select_o_code2" id="select_o_code2" style="width: 98%; font-family: Gothic; font-size: 9pt"></select></td>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">부서</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<select id="select_o_dept" name="select_o_dept" style="width: 98%; font-family: Gothic; font-size: 9pt" 
<%=(master.equals("1") == false ? disabled : "")%>> 
	<option value="D_00000">전체보기</option>
<%	for(ObstacleDTO m_code3_obj : mCode3List) {%>
		<option value=<%=m_code3_obj.getM_code3() %> <%=(memberInfo.getM_dept().equals(m_code3_obj.getM_code3()) == true ? selected : "") %>><%=m_code3_obj.getM_code3_m_name()%></option>
		
<%}%>
</select>
</td>

</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">장애등급</font></td>
<td align="center" valign="middle" bgcolor="ffffff" width="40%">

<select name="o_grade" id="o_grade" style="width: 98%; font-family: Gothic; font-size: 9pt">
</select>
</td>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청고객명</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<input type="text" name="o_member_name" id="o_member_name" style="width: 98%; font-family: Gothic; font-size: 9pt" 
	<%=memberInfo.getM_master().equals("0") == true ? readOnly : "" %>></input>
 
</td>

</tr>
<tr>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">접수경로</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<input name="o_request_path" id="o_request_path" type="radio" value="전화접수">전화접수
<input name="o_request_path" id="o_request_path" type="radio" value="온라인접수">온라인접수
<input name="o_request_path" id="o_request_path" type="radio" value="이메일접수">이메일접수
<input name="o_request_path" id="o_request_path" type="radio" value="모니터링">모니터링</td>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">고객연락처</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<%
String lineNum = memberInfo.getM_linenum();
String[] arrLineNum = lineNum.split("-");
%>
<select name="o_member_phone1" id="o_member_phone1" style="width: 45px; font-family: Gothic; font-size: 8pt">
							<option value="010" <%=("010".equals(arrLineNum[0]) == true ? selected : "")%>>010
							<option value="011" <%=("011".equals(arrLineNum[0]) == true ? selected : "")%>>011
							<option value="016" <%=("016".equals(arrLineNum[0]) == true ? selected : "")%>>016
							<option value="017" <%=("017".equals(arrLineNum[0]) == true ? selected : "")%>>017
							<option value="018" <%=("018".equals(arrLineNum[0]) == true ? selected : "")%>>018
							<option value="019" <%=("019".equals(arrLineNum[0]) == true ? selected : "")%>>019
</select>	
-<input type="text" name="o_member_phone2" id="o_member_phone2"  maxlength="4" style="width: 30px; font-family: Gothic; font-size: 9pt;" 
	></input>
-<input type="text" name="o_member_phone3" id="o_member_phone3" maxlength="4"  style="width: 30px; font-family: Gothic; font-size: 9pt;" 
	></input>

</td>

</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">제품명</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<input type="text" name="o_asset" id="o_asset" style="width: 98%; font-family: Gothic; font-size: 9pt"></input>
</td>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">벤더명</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<input type="text" name="o_vendor" id="o_vendor"  style="width: 98%; font-family: Gothic; font-size: 9pt"></input>
</td>

</tr>
<tr>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">접수시간</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<select id="req_year" name="req_year" onchange=change(1) style="width: 20%; font-family: Gothic; font-size: 9pt">
<% for(int i=curYear-10; i<=curYear+10;i++){ %>
<option value=<%=i%>
<%=((curYear == i) == true ? selected : "")%>"><%=i%></option>
<%}%></select>년

<select id="req_month" name="req_month" onchange=change(1) style="width: 15%; font-family: Gothic; font-size: 9pt">
<% for(int i=1; i<=12;i++){ 
if (i<10) { %>
<option value=<%="0"+i%> <%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
<% }
else {%>
<option value=<%=i%> <%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
<% }
  }%>
</select>월

<select id="req_day" name="req_day" style="width: 15%; font-family: Gothic; font-size: 9pt">
</select>일

<select id="req_hour" name="req_hour" style="width: 15%; font-family: Gothic; font-size: 9pt">
<% for(int i=1; i<=24;i++){ 
if (i<10) { %>
<option value=<%="0"+i%> <%=((curHour == i) == true ? selected : "")%>><%=i%></option>
<% } else { %>
<option value=<%=i%> <%=((curHour == i) == true ? selected : "")%>><%=i%></option>
<% }
  }%>
</select>시

<select id="req_minute" name="req_minute" style="width: 15%; font-family: Gothic; font-size: 9pt">
<% for(int i=0; i<60;i+=10){ 
if (i<10) { %>
<option value=<%="0"+i%> <%=(((curMinute >= i) && (curMinute < (i+10))) == true ? selected : "")%>><%="0"+i%></option>
<% } else { %>
<option value=<%=i%> <%=(((curMinute >= i) && (curMinute < (i+10))) == true ? selected : "")%>><%=i%></option>
<% }
  }%>
</select>분

</td>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">장애발생시간</font></td>
<td align="center" valign="middle" bgcolor="ffffff">

<select id="occur_year" name="occur_year" onchange=change(0) style="width: 20%; font-family: Gothic; font-size: 9pt">
<% for(int i=curYear-10; i<=curYear+10;i++){ %>
<option value=<%=i%> <%=((curYear == i) == true ? selected : "")%>"><%=i%></option>
<%}%></select>년

<select id="occur_month" name="occur_month" onchange=change(0) style="width: 15%; font-family: Gothic; font-size: 9pt">
<% for(int i=1; i<=12;i++){ 
if (i<10) { %>
<option value=<%="0"+i%> <%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
<% }
else {%>
<option value=<%=i%> <%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
<% }
  }%>
</select>월

<select id="occur_day" name="occur_day" style="width: 15%; font-family: Gothic; font-size: 9pt">
</select>일

<select id="occur_hour" name="occur_hour" style="width: 15%; font-family: Gothic; font-size: 9pt">
<% for(int i=1; i<=24;i++){ 
if (i<10) { %>
<option value=<%="0"+i%> <%=((curHour == i) == true ? selected : "")%>><%=i%></option>
<% } else { %>
<option value=<%=i%> <%=((curHour == i) == true ? selected : "")%>><%=i%></option>
<% }
  }%>
</select>시

<select id="occur_minute" name="occur_minute" style="width: 15%; font-family: Gothic; font-size: 9pt">
<% for(int i=0; i<60;i+=10){ 
if (i<10) { %>
<option value=<%="0"+i%> <%=(((curMinute >= i) && (curMinute < (i+10))) == true ? selected : "")%>><%="0"+i%></option>
<% } else { %>
<option value=<%=i%> <%=(((curMinute >= i) && (curMinute < (i+10))) == true ? selected : "")%>><%=i%></option>
<% }
  }%>
</select>분

</td>

</tr>
<tr height="100px">
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" ><font color="white">장애현상</font></td>
<td align="center" colspan="3" valign="middle" bgcolor="ffffff">
<textarea id="o_detail" name="o_detail" cols="1" rows="3" style="width:98%; height:100px; overflow:auto"></textarea>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">첨부파일</font></td>
<td width="90%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold" colspan="3">

<table width="100%" cellpadding=0 cellspacing=0 id="" border="0">
<tr>
 <td width="5%">체크</td>
 <td width="75%">내용</td>
 <td width="10%"><input type="button" value="파일 추가" onclick="javascript:addInputBox();"></td>
 <td width="10%"><input type="button" value="파일 삭제" onclick="javascript:subtractInputBox();"></td>
</tr>
<tr>
<table cellpadding=0 cellspacing=0 id="dynamic_file_table" border="0">
</table>
</tr>
</table>

</td>
</tr>
<tr>
<input type="hidden" name="my_id" id="my_id" value="<%=my_id %>"></input>
<script>
change(1); change(0); changeCode2Options(); changePlaceOptions(); changeGradeOptions();
</script>
</tr>
</table>
<% if (master.equals("2") == true) { // Engineer %>
<input type="hidden" id="select_o_member_company" name="select_o_member_company" value="<%=memberInfo.getM_company() %>" />
<% } %>
</form>
</body>
</html>