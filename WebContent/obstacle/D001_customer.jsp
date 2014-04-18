<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="kr.co.mycom.member.*"%>
<%@page import="kr.co.mycom.obstacle.ObstacleDAO"%>
<%@page import="kr.co.mycom.obstacle.ObstacleDTO"%>
    
<%
    	String my_id = (String) session.getAttribute("ID");
		String my_name = (String) session.getAttribute("NAME");

		if(my_id == null || my_id.equals("null")){
			%>
				<script type = "text/javascript">
				alert("로그인하지 않으면 접근할 수 없습니다.");
				history.back();
				</script>
			<%
		}
        MemberDAO memDao = new MemberDAO();
        MemberDTO memberInfo = memDao.searchMember(my_id);
		
        long time = System.currentTimeMillis(); 
        SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
        String time_in = dayTime.format(new Date(time)); //시간까지 모두 출력
        String[] arrTime_in = time_in.split("-");	
        int curYear = Integer.parseInt(arrTime_in[0]);
        int curMonth = Integer.parseInt(arrTime_in[1]);
        int curDay = Integer.parseInt(arrTime_in[2]);
        int curHour = Integer.parseInt(arrTime_in[3]);
        int curMinute = Integer.parseInt(arrTime_in[4]);

        String selected = "selected = 'selected'";
    %>

<script type="text/javascript">

function change(){
	var selectedYear = null;
	var selectedYearValue = null;
	var selectedMonth = null;
	var selectedMonthValue = null;
	var selectObject= null;
	var lastDay = null;
	
	selectedYear = document.getElementById("occur_year");	
	selectedMonth = document.getElementById("occur_month");	
	selectObject=document.getElementById("occur_day");

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

function check() {	

	if (document.add_obstacle_form.o_title.value == "") {
		alert("제목을 입력하세요");
		document.add_obstacle_form.o_title.focus();
		return false;
	}
	if (document.add_obstacle_form.o_detail.value == "") {
		alert("장애현상을 입력하세요");
		document.add_obstacle_form.o_detail.focus();
		return false;
	}

	return true;
}

function goBack() {
	location.href ="./obstacle/D001.jsp";
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

	var addStr = "<tr><td><input type=checkbox id=checkList name=checkList value="+addCount+" size='10%'></td><td><input type=file name=test"+addCount+" size='120%'></td></tr>";
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
<form name="add_obstacle_form" action="./masterpage.jsp?bo_table=D001_add_user" method="post" enctype="multipart/form-data" onsubmit="return check()">
<table width="95%" align="center">
<tr>
<td align="left">● 장애관리대장 ▶ 장애등록</td>
<td align="right">
<input type="submit" id="btnView" value="등록" 	style="width: 120px; height: 30px; font-family: Gothic; font-size: 9pt" />
<input type="button" value="등록 취소" 	style="width: 120px; height: 30px; font-family: Gothic; font-size: 9pt" onclick="goBack()" /></td></tr>
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

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">장애발생시간</font></td>
<td align="center" valign="middle" bgcolor="ffffff" width="40%">

<select id="occur_year" name="occur_year" onchange=change() style="width: 20%; font-family: Gothic; font-size: 9pt">
<% for(int i=curYear-10; i<=curYear+10;i++){ %>
<option value=<%=i%> <%=((curYear == i) == true ? selected : "")%>"><%=i%></option>
<%}%></select>년

<select id="occur_month" name="occur_month" onchange=change() style="width: 15%; font-family: Gothic; font-size: 9pt">
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
<textarea id="o_detail" name="o_detail" cols="1" rows="3" style="width:98%; height:100px; overflow:hidden"></textarea>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">첨부파일</font></td>
<td width="90%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold" colspan="3">

<table width="100%" cellpadding=0 cellspacing=0 id="" border="0">
<tr>
 <td width="5%">체크</td>
 <td width="75%">내용</td>
 <td width="10%"><input type="button" value="행 추가" onclick="javascript:addInputBox();"></td>
 <td width="10%"><input type="button" value="행 삭제" onclick="javascript:subtractInputBox();"></td>
 </tr>
 <tr>
 <table cellpadding=0 cellspacing=0 id="dynamic_file_table" border="0">
</table>
 </tr>
</table>
</table>

<script>
 change();
</script>

<input type="hidden" name="my_id" id="my_id" value="<%=my_id %>"></input>
<input type="hidden" name="my_name" id="my_name" value="<%=memberInfo.getM_name()%>"></input>
<input type="hidden" name="my_company" id="my_company" value="<%=memberInfo.getM_company() %>"></input>
<input type="hidden" name="my_place" id="my_place" value="<%=memberInfo.getM_place() %>"></input>
<input type="hidden" name="my_dept" id="my_dept" value="<%=memberInfo.getM_dept() %>"></input>
<input type="hidden" name="my_linenum" id="my_linenum" value="<%=memberInfo.getM_linenum() %>"></input>

</form>
</body>
</html>