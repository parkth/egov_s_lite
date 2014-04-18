<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.asset.*"%>
<%@ page import="kr.co.mycom.member.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
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
	MemberDAO member_dao= new MemberDAO();
	MemberDTO member_dto = member_dao.searchMember(my_id);
	
 	String a_company = member_dto.getM_company();
 	String a_place = member_dto.getM_place();
 	String a_dept = member_dto.getM_dept();
 	
 	String selected_company = "";
 	
 	// 사용자 아닌 경우 이름, ID 비우기
 	if (master.equals("0") == false) {
 		my_id = "";
 		my_name = "";
 	}
 	
 	// 관리자 아닌 경우 본인의 회사 기본 선택.
 	if (master.equals("1") == false) {
 		selected_company = member_dto.getM_company();
 	}

	long time = System.currentTimeMillis(); 
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd");
	String time_in = dayTime.format(new Date(time)); //시간까지 모두 출력
	String[] arrTime_in = time_in.split("-");	
	int curYear = Integer.parseInt(arrTime_in[0]);
	int curMonth = Integer.parseInt(arrTime_in[1]);
	int curDay = Integer.parseInt(arrTime_in[2]);

String selectedCode1 = null;
String selected = "selected = 'selected'";
String readOnly = "readOnly = 'readOnly'";
String disabled = "disabled = 'disabled'";

AssetDAO dao = new AssetDAO();
List<AssetDTO> m_code1_lists = dao.search_mcode1();
List<AssetDTO> m_code2_lists = dao.search_mcode2();
List<AssetDTO> m_code3_lists = dao.search_mcode3();

List<AssetDTO> a_code1_lists = dao.search_acode1();
List<AssetDTO> a_code2_lists = dao.search_acode2();
List<AssetDTO> a_code3_lists = dao.search_acode3();

%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
  
<script type="text/javascript">

function select_acode2(){
    var selectValue = document.getElementById("a_code2");
    C001_form.a_code2.options.length = 0;  //모두삭제
    C001_form.a_code3.options.length = 0;  //모두삭제
    
	var value_acode1 = document.getElementById("a_code1");
	var acode1 = value_acode1.options(value_acode1.selectedIndex).value;
	var i=0;
		<%	for(AssetDTO a_code2_obj : a_code2_lists) {
			%>if(acode1 == '<%=a_code2_obj.getA_code1()%>'){
				if('<%=a_code2_obj.getA_enable()%>' == '1'){
				var option=new Option('<%=a_code2_obj.getA_name()%>', '<%=a_code2_obj.getA_code2()%>');
				selectValue.options[i] = option;
				  i++;
				}
				}	
		<%}		%>
		
		select_acode3();
}

function select_acode3(){
    var selectValue = document.getElementById("a_code3");
    C001_form.a_code3.options.length = 0;  //모두삭제

    var value_acode2 = document.getElementById("a_code2");
	var acode2 = value_acode2.options(value_acode2.selectedIndex).value;
	var i =0;
		<%	for(AssetDTO a_code3_obj : a_code3_lists) {
			%>if(acode2 == '<%=a_code3_obj.getA_code1()%>'){
				if('<%=a_code3_obj.getA_enable()%>' == '1'){
				var option=new Option('<%=a_code3_obj.getA_name()%>', '<%=a_code3_obj.getA_code2()%>');
				selectValue.options[i] = option;
				  i++;
				}
			}	
		<%}		%>
}

function change(){ //1 3 5 781012 날짜가 변했을때
	var value_year = document.getElementById("year");
	var value_month = document.getElementById("month");
	var value_day = document.getElementById("day");

	var year = value_year.options[value_year.selectedIndex].value;
	var month = value_month.options[value_month.selectedIndex].value;
	value_day.length=0; //날짜 초기화
	
	lastDay = new Date(year, month, 0).getDate();

	for (var i=1; i<=lastDay; i++) {
		var option = new Option(i,i);
		// 현재 년,월,일이 일치하는 경우에만 날짜를 현재 일로 셋팅. 월이나 년 바꾸면 1일이 기본 됨.
		if(i==<%=curDay%> && month==<%=curMonth%> && year==<%=curYear%>){		
			option.selected=true;
		 }
		value_day.options[i-1] = option; // index는 0부터 시작.
	}
}

// 회사, 사업장, 부서 콤보박스
//수정_ 명훈(select_mcode2, select_mcode3)
function select_mcode2(){
	var selectValue = document.getElementById("a_place");
	 selectValue.length = 0;  //모두삭제
		
	    var csr_code1 = document.getElementById("a_company");
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
		<% for(AssetDTO obj : m_code2_lists) { %>
		    if(selected_csr_code1 == '<%=obj.getM_code1()%>') {
			var option=new Option('<%=obj.getM_name()%>', '<%=obj.getM_code2()%>');
			if('<%=obj.getM_code2()%>' == '<%=member_dto.getM_place()%>') {
				option.selected = true;
			}

			selectValue.options[i] = option;		
			i++;
		    }
		<% }%>
		
		select_mcode3();
}

function select_mcode3(){
	 var selectValue = document.getElementById("a_dept");
	   selectValue.length = 0;  //모두삭제
		
	    var csr_code2 = document.getElementById("a_place");
		var selected_csr_code2 = csr_code2.options(csr_code2.selectedIndex).value;

		var i=0;
		var option;
		if(selectValue.value=="P_00000"||selectValue.value==null){
			option=new Option('전체보기', 'D_00000');
			option.selected = true;
		}
		else{
			option=new Option('전체보기', 'D_00000');
		}
		  selectValue.options[i] = option;
		  i++;
		<% for(AssetDTO m_code3_obj : m_code3_lists) { %>
		    if(selected_csr_code2 == '<%=m_code3_obj.getM_code1()%>') {
			var option=new Option('<%=m_code3_obj.getM_name()%>', '<%=m_code3_obj.getM_code2()%>');
			if('<%=m_code3_obj.getM_code2()%>' == '<%=member_dto.getM_dept()%>') {
				option.selected = true;
			}
			selectValue.options[i] = option;		
			i++;
		    }
		<% }%>
	
}

function check() {
	document.C001_form.a_getdate.value = document.C001_form.year.value + "-"
	+ document.C001_form.month.value + "-" + document.C001_form.day.value;
		
		if (document.C001_form.a_locate.value == "") { 
			alert("위치를 입력하세요.");
			document.C001_form.a_locate.focus();
			return false;
		}
		if (document.C001_form.a_name.value == "" ) { 
			alert("이름을 입력하세요.");
			document.C001_form.a_id.focus();
			return false;
		}
		if (document.C001_form.a_id.value == "" ) { 
			alert("ID를 입력하세요.");
			document.C001_form.a_id.focus();
			return false;
		}
		if (document.C001_form.a_aname.value == "") { 
			alert("품명을 입력하세요.");
			document.C001_form.a_aname.focus();
			return false;
		}
		if (document.C001_form.a_amodel.value == "") { 
			alert("Model을 입력하세요.");
			document.C001_form.a_amodel.focus();
			return false;
		}
		if (document.C001_form.a_vendorname == "") { 
			alert("제조사를 입력하세요.");
			document.C001_form.a_vendorname.focus();
			return false;
		}
		if (document.C001_form.a_spec.value == "" ) { 
			alert("SPEC을 입력하세요.");
			document.C001_form.a_spec.focus();
			return false;
		}
		if (document.C001_form.a_bigo.value == "" ) { 
			alert("비고를 입력하세요.");
			document.C001_form.a_id.focus();
			return false;
		}
	
	
		if (document.C001_form.a_locate.value == "") { // 위치 입력 X
			alert("위치를 입력하세요");
			document.C001_form.a_locate.focus();
			return false;
		}
		if (document.C001_form.a_aname.value == "") { // 품명 입력 X
			alert("품명을 입력하세요");
			document.C001_form.a_aname.focus();
			return false;
		}
		if (document.C001_form.a_amodel.value == "") { // Model 입력 X
			alert("Model을 입력하세요");
			document.C001_form.a_amodel.focus();
			return false;
		}
		if (document.C001_form.a_vendorname.value == "") { // 제조사 입력 X
			alert("제조사를 입력하세요");
			document.C001_form.a_vendorname.focus();
			return false;
		}
		if (document.C001_form.a_spec.value == "") { // Spec 입력 X
			alert("SPEC을 입력하세요");
			document.C001_form.a_spec.focus();
			return false;
		}
		
		
		if (document.C001_form.a_locate.value.length > 40) { 
			alert("위치는 20자 이상 입력할 수 없습니다.");
			document.C001_form.a_locate.focus();
			return false;
		}
		if (document.C001_form.a_name.value.length > 10 ) { 
			alert("이름은 5자 이상 입력할 수 없습니다.");
			document.C001_form.a_id.focus();
			return false;
		}
		if (document.C001_form.a_id.value.length > 12 ) { 
			alert("ID는 영어12자 이상 입력할 수 없습니다.");
			document.C001_form.a_id.focus();
			return false;
		}
		if (document.C001_form.a_aname.value.length > 40) { 
			alert("품명은 20자 이상 입력할 수 없습니다.");
			document.C001_form.a_aname.focus();
			return false;
		}
		if (document.C001_form.a_amodel.value.length > 40 ) { 
			alert("Model은 20자 이상 입력할 수 없습니다.");
			document.C001_form.a_amodel.focus();
			return false;
		}
		if (document.C001_form.a_vendorname.value.length > 40) { 
			alert("제조사는 20자 이상 입력할 수 없습니다.");
			document.C001_form.a_vendorname.focus();
			return false;
		}
		if (document.C001_form.a_spec.value.length > 200 ) { 
			alert("SPEC은 100자 이상 입력할 수 없습니다.");
			document.C001_form.a_spec.focus();
			return false;
		}
		if (document.C001_form.a_bigo.value.length > 40 ) { 
			alert("비고는 20자 이상 입력할 수 없습니다.");
			document.C001_form.a_id.focus();
			return false;
		}
		return true;
}


var count = 0;
var addCount;

// 첨부파일
function addInputBox() {
	for(var i=1; i<=count; i++) {
		if(!document.getElementsByName("testAsset"+i)[0]) {
			addCount = i;
			break;
		}
	  	else addCount = count;
	}

	var addStr = "<tr><td><input type=checkbox name=checkListAsset value="+addCount+" size='10%'></td><td><input type=file name=testAsset"+addCount+" size='120%'></td></tr>";
	var table = document.getElementById("dynamic_file_table_asset");
	var newRow = table.insertRow();
	var newCell = newRow.insertCell();
	newCell.innerHTML = addStr;

	count++;
}
	 	 
	 
//행삭제	 
function subtractInputBox() {
	var table = document.getElementById("dynamic_file_table_asset");
	var rows = dynamic_file_table_asset.rows.length;
	var chk = 0;
	 
	if(rows > 0){

		// 처음에 한 줄 만들었다가 삭제하려고 할 때 length undefined.	
		if (document.C001_form.checkListAsset.length == undefined) {
			if (document.C001_form.checkListAsset.checked == true) {
				table.deleteRow(0);
				count--;
				chk++;	
			}
		}
		
		for (var i=0; i<document.C001_form.checkListAsset.length; i++) {
			if (document.C001_form.checkListAsset[i].checked == true) {
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
<title>S-LITE</title>
</head>
<body onload="select_acode2();select_mcode2();">
<form name="C001_form" method="post" action=".\masterpage.jsp?bo_table=C001_insert"  enctype="multipart/form-data" onsubmit="return check()">
<table width="95%" align="center">
<tr>
<td align="left">● 자산관리대장 ▶ 자산등록</td>
<td align="right"><input type="submit" value="등록" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt" ></input></td>
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
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">

<select id="a_company" name="a_company" onchange="select_mcode2();" style="width: 100%; font-family: Gothic; font-size: 9pt"
<%=(master.equals("1") == false ? disabled : "")%>>
		<option value="C_00000">전체보기</option>
		<%	for(AssetDTO m_code1_obj : m_code1_lists) {
				if(m_code1_obj.getM_enable().equals("1")){%>
				<option value=<%=m_code1_obj.getM_code1() %> <%=(member_dto.getM_company().equals(m_code1_obj.getM_code1()) == true ? selected : "") %>><%=m_code1_obj.getM_name()%></option>
			<%	}
			} %>
</select>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산 구분</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_code1" name="a_code1" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_acode2()">
			<%	for(AssetDTO a_code1_obj : a_code1_lists) {
					if(a_code1_obj.getA_enable().equals("1")){%>
					<option value=<%=a_code1_obj.getA_code1() %>><%=a_code1_obj.getA_name()%></option>
						<%	} 
						}%>
</select>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">사업장</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">

<select id="a_place" name="a_place" onchange="select_mcode3();" style="width: 100%; font-family: Gothic; font-size: 9pt"
<%=(master.equals("1") == false ? disabled : "")%>>
		<option value="P_00000">전체보기</option>
		<%	for(AssetDTO m_code2_obj : m_code2_lists) {
				if(m_code2_obj.getM_enable().equals("1")){%>
				<option value=<%=m_code2_obj.getM_code2() %> <%=(member_dto.getM_place().equals(m_code2_obj.getM_code2()) == true ? selected : "") %>><%=m_code2_obj.getM_name()%></option>
				
			<%	}
			} %>
</select>

 <%-- 
<select id="a_place" name="a_place" onchange="select_mcode3()" style="width: 100%; font-family: Gothic; font-size: 9pt"
<%=(master.equals("0") == true ? disabled : "")%>>
</select>  --%>


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
<select id="a_dept" name="a_dept" style="width: 100%; font-family: Gothic; font-size: 9pt" 
<%=(master.equals("1") == false ? disabled : "")%>>
<option value="P_00000">전체보기</option>
	<%	for(AssetDTO m_code3_obj : m_code3_lists) {%>
					<option value=<%=m_code3_obj.getM_code2() %> <%=(member_dto.getM_dept().equals(m_code3_obj.getM_code2()) == true ? selected : "") %>><%=m_code3_obj.getM_name()%></option>
						<%	} %>
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
<input type="text" id="a_locate" name="a_locate" style="width: 98%; font-family: Gothic; font-size: 9pt"/>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">품명</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_aname" name="a_aname" style="width: 98%; font-family: Gothic; font-size: 9pt"/>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">이름</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_name" name="a_name" value='<%=my_name %>' style="width: 98%; font-family: Gothic; font-size: 9pt" 
<%=master.equals("0") == true ? readOnly : "" %>/>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">Model</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_amodel" name="a_amodel" style="width: 98%; font-family: Gothic; font-size: 9pt"/>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">ID</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_id" name="a_id" value='<%=my_id %>' style="width: 98%; font-family: Gothic; font-size: 9pt" 
<%=master.equals("0") == true ? readOnly : "" %>/>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">제조사</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_vendorname" name="a_vendorname" style="width: 98%; font-family: Gothic; font-size: 9pt"/>
</td>
</tr>
<tr>
<td width="10%" height="1px" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">취득일</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select  id="year" name="year" onchange="change()" style="width:30%;">
<% for(int i=curYear-10; i<=curYear+10;i++){ %>
	<option value=<%=i%>
	<%=((curYear == i) == true ? selected : "")%>><%=i%></option>
<%}%>
</select>년

<select id="month" name="month" onchange="change()" style="width:20%;">
<% for(int i=1; i<=12;i++){ %>
<option value=<%=i%> <%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
<%}%>
</select>월

<select id="day" name="day" style="width:20%;">
</select>일

<input type="hidden" id="a_getdate" name="a_getdate"/>
<input type="hidden" id="a_adddate" name="a_adddate" value=<%=time_in%>/>

</td>
<td rowspan="2" width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">SPEC.</font></td>
<td rowspan="2" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<textarea id="a_spec" name="a_spec" style="width: 98%; height: 50px; font-family: Gothic; font-size: 9pt; overflow:auto" >
</textarea>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">비고</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_bigo" name="a_bigo" style="width: 98%; font-family: Gothic; font-size: 9pt"/>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">첨부파일</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold" colspan="3">

<table width="100%" cellpadding=0 cellspacing=0 id="" border="0">
<tr>
 <td width="5%">체크</td>
 <td width="75%">내용</td>
 <td width="10%"><input type="button" value="행 추가" onclick="javascript:addInputBox();"></td>
 <td width="10%"><input type="button" value="행 삭제" onclick="javascript:subtractInputBox();"></td>
</tr>
<tr>
<table cellpadding=0 cellspacing=0 id="dynamic_file_table_asset" border="0">
</table>
</tr>
</table>
<script type="text/javascript">
select_mcode2(); change();
</script>
<!-- 
<input type="file" id="a_attachment" name="a_attachment" style="width: 99%; font-family: Gothic; font-size: 9pt"/>
-->
</td>
</tr>
<tr>
</tr>
</table>
<% if (master.equals("0") == true) { // 사용자 %>
<input type="hidden" id="a_company" name="a_company" value="<%=member_dto.getM_company() %>" />
<input type="hidden" id="a_place" name="a_place" value="<%=member_dto.getM_place() %>" />
<input type="hidden" id="a_dept" name="a_dept" value="<%=member_dto.getM_dept() %>" />
<% }
	else if (master.equals("2") == true) { // Engineer %>
<input type="hidden" id="a_company" name="a_company" value="<%=member_dto.getM_company() %>" />
<% } %>
</form>
</body>
</html>