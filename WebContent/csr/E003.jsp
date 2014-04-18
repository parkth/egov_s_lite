<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.csr.CSRDAO"%>
<%@ page import="kr.co.mycom.csr.CSRDTO"%>
<%@page import="kr.co.mycom.security.CheckSecurity"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%
	request.setCharacterEncoding("EUC-KR");
%>
<%
	String my_id = (String) session.getAttribute("ID");
	String my_name = (String) session.getAttribute("NAME");
	String master=(String) session.getAttribute("Master");
	
	if(my_id == null || my_id.equals("null")){
		%>
			<script type = "text/javascript">
			alert("로그인하지 않으면 접근할 수 없습니다.");
			history.back();
			</script>
		<%
	}

	long time = System.currentTimeMillis();
	SimpleDateFormat dayTime = new SimpleDateFormat(
			"yyyy-MM-dd-HH-mm-ss");
	String time_in = dayTime.format(new Date(time)); //시간까지 모두 출력
	String[] arrTime_in = time_in.split("-");
	int curYear = Integer.parseInt(arrTime_in[0]);
	int curMonth = Integer.parseInt(arrTime_in[1]);
	int curDay = Integer.parseInt(arrTime_in[2]);
	int curHour = Integer.parseInt(arrTime_in[3]);
	int curMinute = Integer.parseInt(arrTime_in[4]);

	String csr_rnum = request.getParameter("csr_rnum");

	CheckSecurity checkSecurity = new CheckSecurity(); 
	CSRDAO csrDao = new CSRDAO(); //DAO초기화
	CSRDTO csrSearch = csrDao.getData(csr_rnum);

	List<CSRDTO> mCode1List = csrDao.getMCode1List();
	/*         for(int i = 0 ; i < mCode1List.size(); i++)
	        	logger.info(i + "번 회사  : " + mCode1List.get(i).getM_code1_m_name()); */

	List<CSRDTO> mCode2List = csrDao.getMCode2List();
	/*         for(int i = 0 ; i < mCode2List.size(); i++)
	        	logger.info(i + "사업장 회사  : " + mCode2List.get(i).getM_code2_m_name()); */

	List<CSRDTO> mCode3List = csrDao.getMCode3List();
	/*         for(int i = 0 ; i < mCode3List.size(); i++)
	        	logger.info(i + "부서  : " + mCode3List.get(i).getM_code3_m_name()); */

	String selected = "selected = 'selected'";
	String checked = "checked = 'checked'";
%>

<script type="text/javascript">
function check() {

//	alert(""+document.csr_detail_form.getElementById("csr_state").value);
	//var csr_state = document.csr_detail_form.getElementById("csr_state").value;

//	alert("if 진입 전");
	var i = 0;
	var master=<%=master%>
	if(document.csr_detail_form.csr_state.value == '0' && master.value !='0') {
		var radioCheck = false;
		var radioValue = -1;
		
		for(i = 0; i < document.csr_detail_form.c_dependentsystem_flag.length; i++) {
			if(document.csr_detail_form.c_dependentsystem_flag[i].checked) {
				radioCheck = true;
				radioValue = document.csr_detail_form.c_dependentsystem_flag[i].value;
				break;
			}
		}
		if(document.csr_detail_form.c_previewer.value == "") {
			alert("사전검토자를 입력하세요.");
			document.csr_detail_form.c_previewer.focus();
			return false;
		}
		if(document.csr_detail_form.c_preview_result.value == "") {
			alert("사전검토결과를 입력하세요.");
			document.csr_detail_form.c_preview_result.focus();
			return false;
		}
		if(!radioCheck) {
			alert("영향 받는 시스템 존재여부를 선택해주세요.");
			return false;
		}
		
		if(radioValue == 0 && document.csr_detail_form.c_dependentsystem.value == "") {
			alert("영향 받는 시스템을 입력하세요.");
			document.csr_detail_form.c_dependentsystem.focus();
			return false;
		}
		if(document.csr_detail_form.c_previewer.value.length > 60) {
			alert("사전검토자는 30자 이상 입력할 수 없습니다.");
			document.csr_detail_form.c_previewer.focus();
			return false;
		}
		if(document.csr_detail_form.c_preview_result.value.length > 100) {
			alert("사전검토결과는 50자 이상 입력할 수 없습니다.");
			document.csr_detail_form.c_preview_result.focus();
			return false;
		}
		if(radioValue == 0 && document.csr_detail_form.c_dependentsystem.value.length > 200) {
			alert("영향 받는 시스템은 200자 이상 입력할 수 없습니다.");
			document.csr_detail_form.c_dependentsystem.focus();
			return false;
		}
		
		
	} else if(document.csr_detail_form.csr_state.value == '1' && master.value !='0') {
/* 		if (document.csr_detail_form.csr_reason.value == "") {
			alert("CSR원인을 입력하세요.");
			document.csr_detail_form.csr_reason.focus();
			return false;
		} */
		if (document.csr_detail_form.csr_processing_contents.value == "") {
			alert("CSR처리내용을 선택하세요.");
			document.csr_detail_form.csr_processing_contents.focus();
			return false;
		}
		
		if (document.csr_detail_form.csr_estimate_md.value == "") {
			alert("예상공수를 선택하세요.");
			document.csr_detail_form.csr_estimate_md.focus();
			return false;
		}
		if (document.csr_detail_form.csr_complete_md.value == "") {
			alert("완료공수를 선택하세요.");
			document.csr_detail_form.csr_complete_md.focus();
			return false;
		}
		
		/* if (document.csr_detail_form.csr_reason.value.length > 200) {
			alert("CSR원인은 100자 이상 입력할 수 없습니다.");
			document.csr_detail_form.csr_reason.focus();
			return false;
		} */
		if (document.csr_detail_form.csr_processing_contents.value.length > 1000) {
			alert("CSR처리내용은 500자 이상 입력할 수 없습니다.");
			document.csr_detail_form.csr_processing_contents.focus();
			return false;
		}
		
	} else if(document.csr_detail_form.csr_state.value == '2' && master.value !='0') {
		if (document.csr_detail_form.csr_client_comment.value == "") {
			alert("고객의견을 선택하세요. ");
			document.csr_detail_form.csr_client_comment.focus();
			return false;
		}
		
		if (document.csr_detail_form.csr_client_comment.value.length > 200) {
			alert("고객의견은 100자 이상 입력할 수 없습니다.");
			document.csr_detail_form.csr_client_comment.focus();
			return false;
		}
	}
	
	return true;
}
function checkDecimal(el){
	 var ex = /^[0-9]+\.?[0-9]*$/;
	 if(ex.test(el.value)==false){
	   el.value = el.value.substring(0,el.value.length - 1);
	  }
	}

function check_radio(num) {
    if(num == "0") {
  	  csr_detail_form.c_dependentsystem.disabled = false;
   } else {
  	 csr_detail_form.c_dependentsystem.disabled = true;
  }
}

function changeSolving(){ //1 3 5 781012 날짜가 변했을때
	var selectedYear = null;
	var selectedYearValue = null;
	var selectedMonth = null;
	var selectedMonthValue = null;
	var selectObject= null;
	var lastDay = null;
	
	selectedYear = document.getElementById("solving_year");
	selectedMonth = document.getElementById("solving_month");
	selectObject=document.getElementById("solving_day");

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

function changeSolved(){ //1 3 5 781012 날짜가 변했을때
	var selectedYear = null;
	var selectedYearValue = null;
	var selectedMonth = null;
	var selectedMonthValue = null;
	var selectObject= null;
	var lastDay = null;
	
	selectedYear = document.getElementById("solved_year");
	selectedMonth = document.getElementById("solved_month");
	selectObject=document.getElementById("solved_day");

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

function changeFinish(){ //1 3 5 781012 날짜가 변했을때
	var selectedYear = null;
	var selectedYearValue = null;
	var selectedMonth = null;
	var selectedMonthValue = null;
	var selectObject= null;
	var lastDay = null;
	
	selectedYear = document.getElementById("finish_year");
	selectedMonth = document.getElementById("finish_month");
	selectObject=document.getElementById("finish_day");

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
 
function changeEstimate(){ //1 3 5 781012 날짜가 변했을때
	var selectedYear = null;
	var selectedYearValue = null;
	var selectedMonth = null;
	var selectedMonthValue = null;
	var selectObject= null;
	var lastDay = null;
	
	selectedYear = document.getElementById("estimate_year");
	selectedMonth = document.getElementById("estimate_month");
	selectObject=document.getElementById("estimate_day");

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
 
<%-- function change(isRequest){ //1 3 5 781012 날짜가 변했을때
	var selectedYear = null;
	var selectedYearValue = null;
	var selectedMonth = null;
	var selectedMonthValue = null;
	var selectObject= null;
	var lastDay = null;
	
	if (isRequest == 0) {
		selectedYear = document.getElementById("solving_year");	
		selectedMonth = document.getElementById("solving_month");	
		selectObject=document.getElementById("solving_day");
	} else if (isRequest == 1){
		selectedYear = document.getElementById("solved_year");	
		selectedMonth = document.getElementById("solved_month");	
		selectObject=document.getElementById("solved_day");
	} else {
		selectedYear = document.getElementById("finish_year");	
		selectedMonth = document.getElementById("finish_month");	
		selectObject=document.getElementById("finish_day");
	}

	selectedYearValue = selectedYear.options[selectedYear.selectedIndex].value;
	selectedMonthValue = selectedMonth.options[selectedMonth.selectedIndex].value;
	selectObject.length=0; //날짜 초기화
	
	lastDay = new Date(selectedYearValue, selectedMonthValue, 0).getDate();
	logger.info("인자  : " + isRequest);
	
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
} --%>
 
<%-- function changeDeptOptionsDetail(){
    var selectValue = document.getElementById("select_o_detail_dept");
    selectValue.length = 0;  //모두삭제
	
    var o_code1 = document.getElementById("select_o_detail_member_company");
	var selected_o_code1 = o_code1.options(o_code1.selectedIndex).value;

	var i=0;
	<%for (CSRDTO obj : mCode3List) {%>
	    if(selected_o_code1 == '<%=obj.getM_code1()%>'') {
		    if ('<%=obj.getM_code3()%>'' == '<%=csrSearch.getM_code3()%>'') {
				var option=new Option('<%=obj.getM_code3_m_name()%>'', '<%=obj.getM_code3()%>'', true, true);
		    }
		    else {
				var option=new Option('<%=obj.getM_code3_m_name()%>'', '<%=obj.getM_code3()%>'' );
		    }
		selectValue.options[i] = option;
		i++;
	    }
	<%}%>
}
 --%>

//0: 내용저장, 1: 접수, 2: 해결, 3: 종료
function buttonCheck(clickedButton) {
	var detailButton = document.getElementById("o_detail_button");
	
	switch(clickedButton) {
	case 0: // 내용저장
		detailButton.value = 0;
		break;
	case 1: // 접수
		detailButton.value = 1;
		break;
	case 2: // 해결
		detailButton.value = 2;
		break;
	case 3: // 종료
		detailButton.value = 3;
		break;
	}

	document.obstacle_detail_form.submit();
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

	var addStr = "<tr><td><input type=checkbox name=checkList value="+addCount+" size='5%'></td><td><input type=file name=test"+addCount+" size='80%'></td></tr>";
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
<link rel="stylesheet" type="text/css" href="../common.css" />
</head>
<body onload="check_radio();">
	<form name="csr_detail_form" action="update_csr.jsp" method="post"
		enctype="multipart/form-data" onsubmit="return check()">
		<%if (Integer.parseInt(csrSearch.getCSR_digit_state()) < 3 && !master.equals("0")) {%>
		<table width="95%" align="center">
			<tr>
				<td align="left">● CSR관리대장 ▶ CSR상세현황</td>
				<td align="right">
					<input type="submit" id="btnView" name="btnView" value="저장" 	style="width: 120px; height: 30px; font-family: Gothic; font-size: 9pt" />
					<input type="button" value="닫기" 	style="width: 120px; height: 30px; font-family: Gothic; font-size: 9pt"onclick="javascript:self.close();" /></td>
			</tr>
		</table>
		<%} %>
		<table>
			<tr>
				<td style="height: 15px"></td>
			</tr>
		</table>
		<table width="95%" align="center" border="0" cellspacing="1"
			bgcolor="000000">
			<tr>
				<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">제목</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input type="text" id="csr_title" name="csr_title" value='<%=csrSearch.getCSR_title()%>' style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly" />
				</td>
				<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">회사</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input type="text" id="csr_member_company" name="csr_member_company" value='<%=csrSearch.getM_code1_m_name()%>' style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">CSR번호</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input type="text" id="csr_rnum" name="csr_rnum" value='<%=csrSearch.getCSR_rnum()%>' style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly" /></td>
				<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white" width="15%">사업장</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input type="text" id="csr_place" name="csr_place" value='<%=csrSearch.getM_code2_m_name()%>' style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly" /></td>
			</tr>
			<tr>
				<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">CSR유형</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input type="text" id="csr_code1" name="csr_code1" value='<%=csrSearch.getCSR_code1_m_name()%>' style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly" /></td>
				<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">부서</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input type="text" id="csr_dept" name="csr_dept" value='<%=csrSearch.getM_code3_m_name()%>' style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly" /></td>
			</tr>
			<tr>
				<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">시스템 구분</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input type="text" id="csr_system_category" name="csr_system_category" value='<%=csrSearch.getCSR_system_category_m_name()%>' style="width: 98%; font-family: Gothic; font-size: 9pt"readonly="readonly" /></td>
				<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">요청고객명</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input	type="text" id="csr_member_name" name="csr_member_name"	value='<%=csrSearch.getCSR_name()%>' style="width: 98%; font-family: Gothic; font-size: 9pt"readonly="readonly" /></td>
			</tr>
			<tr>
				<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">접수일자</font></td>
				<td align="left" valign="middle" class="01black_bold" bgcolor="ffffff" width="35%">&nbsp;&nbsp;<%=csrSearch.getCSR_requesttime()%></td>
				<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">고객연락처</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input type="text" name="csr_linenum" id="csr_linenum" style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readOnly" value='<%=csrSearch.getCSR_linenum()%>'></input>	</td>

			</tr>
			<tr height="100px">
				<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white" width="15%">내용</font></td>
				<td align="center" colspan="3" valign="middle" bgcolor="ffffff" width="85%">
				<% String detail = checkSecurity.getText(csrSearch.getCSR_detail()); %>
				<textarea id="csr_detail" name="csr_detail" cols="1" rows="3" style="width: 98%; height: 100px; overflow: auto; resize:none" readonly="readOnly"><%=detail %></textarea></td>
			</tr>
			<tr>
			<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">첨부파일(고객)</font></td>
			<td align="center" valign="middle" colspan="3" bgcolor="ffffff">
			<% if (csrSearch.getCSR_attachment() != null && !(csrSearch.getCSR_attachment().equals("")) && !(csrSearch.getCSR_attachment().equals("NULL"))) {
			 
			 String filePath = csrSearch.getCSR_attachment();
			 
			 StringTokenizer tokens = new StringTokenizer(filePath, "|");
			 File tempFile = null;
			 String fileName = null;
			 String oneFilePath = null;
			 
			 while (tokens.hasMoreElements()) {
				 oneFilePath = tokens.nextToken();
				 tempFile = new File(oneFilePath);
				 fileName = tempFile.getName(); %>
			<a href="../file_download.jsp?fileName=<%=fileName%>&filePath=<%=oneFilePath%>"><font color="blue"><%=fileName %></font></a>&nbsp;&nbsp;
			<a href="../file_delete.jsp?filePath=<%=oneFilePath%>&O_rnum=<%=csr_rnum%>&fileFullPath=<%=filePath%>"><font color="blue">삭제</font></a>&nbsp;&nbsp;
			 <% }
			 } %>
			</td>
			</tr>
						
		</table>
 		<table>
			<tr>
				<input type="hidden" name="csr_state" id="csr_state" value="<%=csrSearch.getCSR_digit_state() %>"></input>
				<%-- <input type="hidden" name="my_id" id="my_id" value="<%=my_id %>"></input>
				<input type="hidden" name="my_company" id="my_company" value="<%=memberInfo.getM_company() %>"></input>
				<input type="hidden" name="my_place" id="my_place" value="<%=memberInfo.getM_place() %>"></input>
				<input jtype="hidden" name="my_dept" id="my_dept" value="<%=memberInfo.getM_dept() %>"></input> --%>
			</tr>
		</table>
		
		<!-- 1. 요청 : 상태가 0보다 크면 읽기만-->
		<%if (Integer.parseInt(csrSearch.getCSR_digit_state()) > 0) {%>
		<table>
			<tr>
				<td style="height: 3px"></td>
			</tr>
		</table>
		<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">사전 검토자</font></td>
				<td width="85%" align="center" valign="middle" bgcolor="ffffff"	class="01black_bold">
				<input type="text" id="c_previewer"	 value='<%=csrSearch.getCSR_previewer()%>' name="c_previewer"style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/></td>
			</tr>
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">사전 검토 일시</font></td>
				<td width="85%" align="center" valign="middle" bgcolor="ffffff"	class="01black_bold">
				<input type="text" id="c_solvingtime"	name="c_solvingtime"style="width: 98%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_solvingtime()%>' readonly="readonly"/></td>	
			</tr>
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">조치 예정일</font></td>
				<td width="85%" align="center" valign="middle" bgcolor="ffffff"	class="01black_bold">
				<input type="text" id="csr_estimate_solvetime"	name="csr_estimate_solvetime"style="width: 98%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_estimate_solvetime()%>' readonly="readonly"/></td>	
			</tr>
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">사전 검토 결과</font></td>
				<td width="85%" align="center" valign="middle" bgcolor="ffffff"	class="01black_bold">
				<input type="text" id="c_preview_result" name="c_preview_result" value='<%=csrSearch.getCSR_preview_result()%>' style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/></td>
			</tr>
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">영향 받는 시스템</font></td>
				<td width="85%" align="left" valign="middle" bgcolor="ffffff">
				<% if(csrSearch.getCSR_dependentsystem_flag().equals("0")){ %>
					<input type="radio" id="c_dependentsystem_flag"	name="c_dependentsystem_flag" onClick="check_radio(0)" name="Radiostatus" value="0" checked disabled="disabled">Yes 
					<input type="radio"	id="c_dependentsystem_flag" name="c_dependentsystem_flag" onClick="check_radio(1)" name="Radiostatus" value="1" disabled="disabled">No 
					<input type="text" id="c_dependentsystem" name="c_dependentsystem" style="width: 100%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_dependentsystem()%>' readonly="readonly"/></td>
				<%}else{ %>
					<input type="radio" id="c_dependentsystem_flag"	name="c_dependentsystem_flag" onClick="check_radio(0)" name="Radiostatus" value="0"  disabled="disabled">Yes 
					<input type="radio"	id="c_dependentsystem_flag" name="c_dependentsystem_flag" onClick="check_radio(1)" name="Radiostatus" value="1" checked disabled="disabled">No 
					<input type="text" id="c_dependentsystem" name="c_dependentsystem" style="width: 100%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_dependentsystem()%>' readonly="readonly"/></td>
				<%} %>
				
			</tr>
		</table>
			<!-- -2. 해결 중  : 상태가 1보다 크면 읽기만 -->
			<%if (Integer.parseInt(csrSearch.getCSR_digit_state()) > 1) {%>
			<table>
				<tr>
					<td style="height: 3px"></td>
				</tr>
			</table>
			<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
				<tr>
					<td width="15%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">완료 일시</font></td>
					<td colspan="3" align="center" valign="middle" bgcolor="ffffff" width="85%">
					<input type="text" id="csr_solvedtime" name="csr_solvedtime" style="width: 98%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_solvedtime()%>' readonly="readonly"></input></td>
				</tr>
				<tr>
					<td width="15%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">처리내용</font></td>
					<td colspan="3" align="center" valign="middle" bgcolor="ffffff" width="85%">
					<input type="text" id="csr_processing_contents" name="csr_processing_contents" style="width: 98%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_processing_contents()%>' readonly="readonly"></input></td>
				</tr>
				<%-- <tr>
					<td rowspan="4" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">처리결과</font></td>
					<td colspan="3" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="85%"><font color="white">원인</font></td>
				</tr>
				<tr>
					<td colspan="3" align="center" valign="middle" bgcolor="ffffff" width="85%">
					<textarea id="csr_reason" name="csr_reason" cols="1" rows="3" style="width: 98%; height: 30px; overflow: hidden; resize:none" readonly="readOnly"><%=csrSearch.getCSR_reason()%></textarea></td>
				</tr>
	
				<tr>
					<td colspan="3" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="85%"><font color="white">처리내용</font></td>
				</tr>
				<tr>
					<td colspan="3" align="center" valign="middle" bgcolor="ffffff" width="85%">
					<textarea id="csr_processing_contents" name="csr_processing_contents" cols="1" rows="3" style="width: 98%; height: 50px; overflow: hidden; resize:none" readonly="readOnly"><%=csrSearch.getCSR_processing_contents()%></textarea></td>
				</tr> --%>
				<tr>
					<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">예상공수(M/D)</font></td>
					<td align="center" valign="middle" bgcolor="ffffff" width="35%">
					<input type="text" id="csr_estimate_md" name="csr_estimate_md" style="width: 98%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_estimate_md()%>' readonly="readonly"/></td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">완료공수(M/D)</font></td>
					<td align="center" valign="middle" bgcolor="ffffff" width="35%">
					<input type="text" id="csr_complete_md" name="csr_complete_md" style="width: 98%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_complete_md()%>'  readonly="readonly"/></td>
				</tr>
				<tr>
			<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">첨부파일(관리자)</font></td>
			<td align="center" valign="middle" colspan="3" bgcolor="ffffff">
			<% if (csrSearch.getCsr_attachment_engineer() != null && !(csrSearch.getCsr_attachment_engineer().equals("")) && !(csrSearch.getCsr_attachment_engineer().equals("NULL"))) {
			 
			 String filePath = csrSearch.getCsr_attachment_engineer();
			 
			 StringTokenizer tokens = new StringTokenizer(filePath, "|");
			 File tempFile = null;
			 String fileName = null;
			 String oneFilePath = null;
			 
			 while (tokens.hasMoreElements()) {
				 oneFilePath = tokens.nextToken();
				 tempFile = new File(oneFilePath);
				 fileName = tempFile.getName(); %>
			<a href="../file_download.jsp?fileName=<%=fileName%>&filePath=<%=oneFilePath%>"><font color="blue"><%=fileName %></font></a>&nbsp;&nbsp;
			<a href="../file_delete.jsp?filePath=<%=oneFilePath%>&O_rnum=<%=csr_rnum%>&fileFullPath=<%=filePath%>"><font color="blue">삭제</font></a>&nbsp;&nbsp;
			 <% }
			 } %>
			</td>
			</tr>
				
				
			</table>
				<!-- -3. 해결   : 상태가 2보다 크면 읽기만-->
				<%if (Integer.parseInt(csrSearch.getCSR_digit_state()) > 2) {%>
				<table>
					<tr>
						<td style="height: 3px"></td>
					</tr>
				</table>
				<table width="95%" align="center" border="0" cellspacing="1"
					bgcolor="000000">
					<tr>
						<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">종료 일시</font></td>
						<td align="center" valign="middle" bgcolor="ffffff"	width="85%">
						<input type="text" id="c_finishtime" name="c_finishtime" style="width: 98%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_finishtime()%>' readonly="readonly"/></td>
					</tr>
					<tr>
						<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">고객 의견</font></td>
						<td align="center" valign="middle" bgcolor="ffffff"	width="85%">
						<textarea id="csr_client_comment" name="csr_client_comment" cols="1" rows="3" style="width: 98%; height: 50px; overflow: hidden; resize:none" readonly="readOnly"><%=csrSearch.getCSR_client_comment()%></textarea>
						</td>
					</tr>
				</table>
				<%} else if(!master.equals("0")) {%>
				<table>
					<tr>
						<td style="height: 3px"></td>
					</tr>
				</table>
				<table width="95%" align="center" border="0" cellspacing="1"
					bgcolor="000000">
					<tr>
						<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">종료 일시</font></td>
						<td align="center" valign="middle" bgcolor="ffffff"	width="35%">
						<select id="finish_year" name="finish_year"	onchange=changeFinish()	style="width: 20%; font-family: Gothic; font-size: 9pt">
								<%
									for (int i = curYear - 10; i <= curYear + 10; i++) {
								%>
								<option value=<%=i%>
								<%=((curYear == i) == true ? selected : "")%>><%=i%></option>
								<%
									}
								%>
						</select>년
						<select id="finish_month" name="finish_month" onchange=changeFinish() style="width: 15%; font-family: Gothic; font-size: 9pt">
								<%
									for (int i = 1; i <= 12; i++) {
										if (i < 10) {
								%>
								<option value=<%="0" + i%>
									<%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
									<%
										} else {
									%>
									<option value=<%=i%>
										<%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
									<%
										}
									}
								%>
						</select>월 
						<select id="finish_day" name="finish_day" style="width: 15%; font-family: Gothic; font-size: 9pt">
						</select>일 
						<select id="finish_hour" name="finish_hour" style="width: 15%; font-family: Gothic; font-size: 9pt">
								<%
									for (int i = 1; i <= 24; i++) {
											if (i < 10) {
									%>
									<option value=<%="0" + i%>
										<%=((curHour == i) == true ? selected : "")%>><%=i%></option>
									<%
										} else {
									%>
									<option value=<%=i%>
									<%=((curHour == i) == true ? selected : "")%>><%=i%></option>
									<%
										}
									}
									%>
						</select>시
						<select id="finish_minute" name="finish_minute" style="width: 15%; font-family: Gothic; font-size: 9pt">
								<%
									for (int i = 0; i < 60; i += 10) {
											if (i < 10) {
										%>
										<option value=<%="0" + i%>
											<%=(((curMinute >= i) && (curMinute < (i + 10))) == true ? selected
												: "")%>><%="0" + i%></option>
										<%
											} else {
										%>
										<option value=<%=i%>
											<%=(((curMinute >= i) && (curMinute < (i + 10))) == true ? selected
												: "")%>><%=i%></option>
										<%
											}
										}
								%>
						</select>분
						<script>
							changeFinish();
						</script></td>
					</tr>
					<tr>
						<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">고객 의견</font></td>
						<td align="center" valign="middle" bgcolor="ffffff"	width="85%">
						<textarea id="csr_client_comment" name="csr_client_comment" cols="1" rows="3" style="width: 98%; height: 30px; overflow: hidden; resize:none"></textarea></td>
					</tr>
				</table>
				<%}%>
			
			<%} else if(!master.equals("0")) {%>
			<table>
				<tr>
					<td style="height: 3px"></td>
				</tr>
			</table>
			<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
				<tr>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">완료 일시</font></td>
					<td colspan="3"  align="center" valign="middle" bgcolor="ffffff" width="85%">
					<select id="solved_year" name="solved_year"	onchange=changeSolved() style="width: 20%; font-family: Gothic; font-size: 9pt">
							<%
								for (int i = curYear - 10; i <= curYear + 10; i++) {
							%>
							<option value=<%=i%>
							<%=((curYear == i) == true ? selected : "")%> ><%=i%></option>
							<%
								}
							%>
					</select>년
					<select id="solved_month" name="solved_month" onchange=changeSolved() style="width: 15%; font-family: Gothic; font-size: 9pt">
							<%
								for (int i = 1; i <= 12; i++) {
										if (i < 10) {
							%>
								<option value=<%="0" + i%>
									<%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
								<%
									} else {
								%>
								<option value=<%=i%>
									<%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
								<%
									}
								}
							%>
					</select>월
					<select id="solved_day" name="solved_day" style="width: 15%; font-family: Gothic; font-size: 9pt">
					</select>일
					<select id="solved_hour" name="solved_hour" style="width: 15%; font-family: Gothic; font-size: 9pt">
							<%
								for (int i = 1; i <= 24; i++) {
										if (i < 10) {
							%>
							<option value=<%="0" + i%>
								<%=((curHour == i) == true ? selected : "")%>><%=i%></option>
								<%
									} else {
								%>
								<option value=<%=i%>
								<%=((curHour == i) == true ? selected : "")%>><%=i%></option>
								<%
									}
								}
							%>
					</select>시
					<select id="solved_minute" name="solved_minute" style="width: 15%; font-family: Gothic; font-size: 9pt">
							<%
								for (int i = 0; i < 60; i += 10) {
										if (i < 10) {
							%>
							<option value=<%="0" + i%>
								<%=(((curMinute >= i) && (curMinute < (i + 10))) == true ? selected	: "")%>><%="0" + i%></option>
								<%
									} else {
								%>
								<option value=<%=i%>
									<%=(((curMinute >= i) && (curMinute < (i + 10))) == true ? selected	: "")%>><%=i%></option>
								<%
									}
								}
							%>
					</select>분 
					<script>
						changeSolved();
					</script>
				</td>
				</tr>
				<!-- <tr>
					<td rowspan="4" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">처리결과</font></td>
					<td colspan="3" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="85%"><font color="white">원인</font></td>
				</tr>
				<tr>
					<td colspan="3" align="center" valign="middle" bgcolor="ffffff" width="85%">
					<textarea id="csr_reason" name="csr_reason" cols="1" rows="3" style="width: 98%; height: 30px; overflow: hidden; resize:none"></textarea></td>
				</tr>
	
				<tr>
					<td colspan="3" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="85%"><font color="white">처리내용</font></td>
				</tr>
				<tr>
					<td colspan="3" align="center" valign="middle" bgcolor="ffffff" width="85%">
					<textarea id="csr_processing_contents" name="csr_processing_contents" cols="1" rows="3" style="width: 98%; height: 50px; overflow: hidden; resize:none"></textarea></td>
				</tr> -->
				<tr height="300px">
				<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white" width="15%">처리 내용</font></td>
				<td align="center" colspan="3" valign="middle" bgcolor="ffffff" width="85%">
				<textarea id="csr_processing_contents" name="csr_processing_contents" cols="1" rows="3" style="width: 98%; height: 300px; overflow: hidden; resize:none"></textarea></td>
				</tr>		
				<tr>
					<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">예상공수(M/D)</font></td>
					<td align="center" valign="middle" bgcolor="ffffff" width="35%">
					<input type="text" id="csr_estimate_md" name="csr_estimate_md" style="width: 98%; font-family: Gothic; font-size: 9pt" onkeyup="checkDecimal(this);"/></td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">완료공수(M/D)</font></td>
					<td align="center" valign="middle" bgcolor="ffffff" width="35%">
					<input type="text" id="csr_complete_md" name="csr_complete_md" style="width: 98%; font-family: Gothic; font-size: 9pt" onkeyup="checkDecimal(this);"/></td>
				</tr>
<tr>
<td width="15%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">첨부파일(관리자)</font></td>
<td width="85%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold" colspan="3">

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
</tr>
			</table>
			<%}%>
			
			
		<%} else if(!master.equals("0")) {%>
		<table>
			<tr>
				<td style="height: 3px"></td>
			</tr>
		</table>
		<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">사전 검토자</font></td>
				<td width="85%" align="center" valign="middle" bgcolor="ffffff"	class="01black_bold">
				<input type="text" id="c_previewer"	name="c_previewer"style="width: 98%; font-family: Gothic; font-size: 9pt" /></td>
			</tr>
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">사전 검토 일시</font></td>
				<td width="85%" align="center" valign="middle" bgcolor="ffffff"	class="01black_bold">
					<!-- <input type="text" id="c_solvingtime" name="c_solvingtime" style="width: 98%; font-family: Gothic; font-size: 9pt" /> -->

					<select id="solving_year" name="solving_year" onchange=changeSolving() style="width: 20%; font-family: Gothic; font-size: 9pt">
						<%
							for (int i = curYear - 10; i <= curYear + 10; i++) {
						%>
						<option value=<%=i%>
						<%=((curYear == i) == true ? selected : "")%>><%=i%></option>
						<%
							}
						%>
				</select>년 <select id="solving_month" name="solving_month" onchange=changeSolving() style="width: 15%; font-family: Gothic; font-size: 9pt">
						<%
							for (int i = 1; i <= 12; i++) {
									if (i < 10) {
						%>
							<option value=<%="0" + i%>
								<%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
							<%
								} else {
							%>
							<option value=<%=i%>
								<%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
							<%
								}
							}
						%>
				</select>월 <select id="solving_day" name="solving_day"style="width: 15%; font-family: Gothic; font-size: 9pt">
				</select>일 <select id="solving_hour" name="solving_hour"style="width: 15%; font-family: Gothic; font-size: 9pt">
						<%
							for (int i = 1; i <= 24; i++) {
									if (i < 10) {
						%>
							<option value=<%="0" + i%>
								<%=((curHour == i) == true ? selected : "")%>><%=i%></option>
							<%
								} else {
							%>
							<option value=<%=i%>
							<%=((curHour == i) == true ? selected : "")%>><%=i%></option>
							<%
								}
							}
						%>
				</select>시 <select id="solving_minute" name="solving_minute" style="width: 15%; font-family: Gothic; font-size: 9pt">
						<%
							for (int i = 0; i < 60; i += 10) {
									if (i < 10) {
						%>
							<option value=<%="0" + i%>
								<%=(((curMinute >= i) && (curMinute < (i + 10))) == true ? selected
									: "")%>><%="0" + i%></option>
							<%
								} else {
							%>
							<option value=<%=i%>
								<%=(((curMinute >= i) && (curMinute < (i + 10))) == true ? selected
									: "")%>><%=i%></option>
							<%
								}
							}
						%>
				</select>분 
				<script>
					changeSolving();
				</script>
				</td>
			</tr>
			
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">조치 예정일</font></td>
				<td width="85%" align="center" valign="middle" bgcolor="ffffff"	class="01black_bold">
				<select id="estimate_year" name="estimate_year" onchange=changeestimate() style="width: 20%; font-family: Gothic; font-size: 9pt">
						<%
							for (int i = curYear - 10; i <= curYear + 10; i++) {
						%>
						<option value=<%=i%>
						<%=((curYear == i) == true ? selected : "")%>><%=i%></option>
						<%
							}
						%>
				</select>년 <select id="estimate_month" name="estimate_month" onchange=changeestimate() style="width: 15%; font-family: Gothic; font-size: 9pt">
						<%
							for (int i = 1; i <= 12; i++) {
									if (i < 10) {
						%>
							<option value=<%="0" + i%>
								<%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
							<%
								} else {
							%>
							<option value=<%=i%>
								<%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
							<%
								}
							}
						%>
				</select>월 <select id="estimate_day" name="estimate_day"style="width: 15%; font-family: Gothic; font-size: 9pt">
				</select>일 <select id="estimate_hour" name="estimate_hour"style="width: 15%; font-family: Gothic; font-size: 9pt">
						<%
							for (int i = 1; i <= 24; i++) {
									if (i < 10) {
						%>
							<option value=<%="0" + i%>
								<%=((curHour == i) == true ? selected : "")%>><%=i%></option>
							<%
								} else {
							%>
							<option value=<%=i%>
							<%=((curHour == i) == true ? selected : "")%>><%=i%></option>
							<%
								}
							}
						%>
				</select>시 <select id="estimate_minute" name="estimate_minute" style="width: 15%; font-family: Gothic; font-size: 9pt">
						<%
							for (int i = 0; i < 60; i += 10) {
									if (i < 10) {
						%>
							<option value=<%="0" + i%>
								<%=(((curMinute >= i) && (curMinute < (i + 10))) == true ? selected
									: "")%>><%="0" + i%></option>
							<%
								} else {
							%>
							<option value=<%=i%>
								<%=(((curMinute >= i) && (curMinute < (i + 10))) == true ? selected
									: "")%>><%=i%></option>
							<%
								}
							}
						%>
				</select>분 
				<script>
					changeEstimate();
				</script>
				</td>
			</tr>
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">사전 검토 결과</font></td>
				<td width="85%" align="center" valign="middle" bgcolor="ffffff"	class="01black_bold">
				<input type="text" id="c_preview_result" name="c_preview_result"	style="width: 98%; font-family: Gothic; font-size: 9pt" /></td>
			</tr>
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">영향 받는 시스템</font></td>
				<td width="85%" align="left" valign="middle" bgcolor="ffffff">
				<input type="radio" id="c_dependentsystem_flag"	name="c_dependentsystem_flag" onClick="check_radio(0)" name="Radiostatus" value="0">Yes 
				<input type="radio"	id="c_dependentsystem_flag" name="c_dependentsystem_flag" onClick="check_radio(1)" name="Radiostatus" value="1">No 
				<input type="text" id="c_dependentsystem" name="c_dependentsystem" style="width: 91%; font-family: Gothic; font-size: 9pt" /></td>

			</tr>
		</table>
		<%}%>
		
	</form>
</body>
</html>