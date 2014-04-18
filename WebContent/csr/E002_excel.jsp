<%@ page contentType="application/vnd.ms-excel;charset=UTF-8" %>
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
if(request.getParameter("search_name") != null)
	search_name  = new String(request.getParameter("search_name").getBytes("Cp1252"), "EUC-KR");//비고

String search_title = request.getParameter("search_title");

if(request.getParameter("search_title") != null)
	search_title  = new String(request.getParameter("search_title").getBytes("Cp1252"), "EUC-KR");//비고


if (csr_rnum2 == null)
	csr_rnum2 = "";
if(select_csr_system_category == null)
	select_csr_system_category ="E_00000";
if (select_csr_place == null) 
	select_csr_place = "P_00000";
if (select_csr_dept == null) 
	select_csr_dept = "D_00000";
if (select_csr_code1 == null)
	select_csr_code1 = "C1_0000";
if (select_csr_state == null)
	select_csr_state ="";
if (select_csr_member_company == null) 
	select_csr_member_company = "C_00000";
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
	var frm=D002;
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
	
// 	window.open(address+csr_rnum, "pop", "width=1000, height=700, history=no, status=no, scrollbars=yes,menubar=no");
  	window.open('./csr/E003.jsp?csr_rnum='+csr_rnum,'','width=900, height=660, scrollbars=yes');
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
//			if('<%=obj.getM_code2()%>' == '<%=memberInfo.getM_place()%>') {
//				option.selected = true;
//			}

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
//		if('<%=obj.getM_code3()%>' == '<%=memberInfo.getM_dept()%>') {
//			option.selected = true;
//		}

		selectValue.options[i] = option;		
		i++;
	    }
	<% }%>
}

function DayCheck(){
	
	if (document.E002.ComboreqYear.value > document.E002.ComboEndReqYear.value || document.E002.ComboreqYear2.value > document.E002.ComboEndReqYear2.value) { // 검색연도가
		alert("조회 기간을 다시 선택하여 주십시오 ");
		return false;
	}
	else if(((document.E002.ComboreqYear.value == document.E002.ComboEndReqYear.value)&&(document.E002.ComboreqYear.value > document.E002.ComboEndReqYear.value)) || ((document.E002.ComboreqYear2.value == document.E002.ComboEndReqYear2.value)&&(document.E002.ComboreqYear2.value > document.E002.ComboEndReqYear2.value)) ){
		alert("조회 기간을 다시 선택하여 주십시오 ");
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

<body>



<table width="95%" align="center" border="1" cellspacing="1">
<tr height="24">
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">순번</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">CSR번호</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">상태</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청제목</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">내용</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">시스템구분</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">CSR유형</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청 시간</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청자ID</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청자성명</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청자회사명</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청자사업장명</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청자부서</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">요청자연락처</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#FF73EE"><font color="white">사전검토참석자</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#FF73EE"><font color="white">담당자접수시간</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#FF73EE"><font color="white">조치예정일</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#FF73EE"><font color="white">사전 검토 결과</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#FF73EE"><font color="white">영향받는 시스템</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#FF73EE"><font color="white">해결완료시간</font></td>

<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#FF73EE"><font color="white">원인</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#FF73EE"><font color="white">처리내용</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#FF73EE"><font color="white">예상공수</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#FF73EE"><font color="white">완료공수</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#FF73EE"><font color="white">종료시간</font></td>
<td width="2%" align="center" valign="middle" class="01black_bold" bgcolor="#FF73EE"><font color="white">요청자 의견</font></td>

</tr>
<%int i = 1; %>
	<% for(CSRDTO result_obj : result_lists) { 
		 
	if(result_obj.getCSR_state().equals("0")){ bgcolor ="#da291c"; state = "요청"; estimate_solvetime = "접수 전";} 
	else if(result_obj.getCSR_state().equals("1")){ bgcolor ="#daa520"; state = "해결중"; estimate_solvetime = result_obj.getCSR_estimate_solvetime();}
	else if(result_obj.getCSR_state().equals("2")){ bgcolor ="#800080"; state = "해결"; estimate_solvetime = result_obj.getCSR_estimate_solvetime();} //
	else{ bgcolor ="#483d8b"; state = "종료"; estimate_solvetime = result_obj.getCSR_estimate_solvetime();}%>
<tr height="24" >
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%= i%></td><%i++; %>


<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_rnum()%></td>


<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><font color="<%=bgcolor %>"><b><%=state%></b></font></td>

<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_title()%></td>

<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_detail()%></td>

<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_system_category_m_name()%></td>

<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_code1_m_name()%></td>

<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_requesttime()%></td>

<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_id()%></td>

<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getMember_name()%></td>

<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getM_code1_m_name()%></td>

<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getM_code2_m_name()%></td>

<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getM_code3_m_name()%></td>

<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_linenum()%></td>
  
  
<%if(result_obj.getCSR_previewer()==null){%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff">-</td>
<%}else{%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_previewer()%></td>
<%}%>
<%if(result_obj.getCSR_solvingtime()==null){%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff">-</td>
<%}else{%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_solvingtime()%></td>
<%}%>
<%if(estimate_solvetime==null){%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff">-</td>
<%}else{%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=estimate_solvetime%></td>
<%}%>
<%if(result_obj.getCSR_preview_result()==null){%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff">-</td>
<%}else{%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_preview_result()%></td>
<%}%>
<%if(result_obj.getCSR_dependentsystem()==null){%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff">-</td>
<%}else{%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_dependentsystem()%></td>
<%}%>
<%if(result_obj.getCSR_solvedtime()==null){%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff">-</td>
<%}else{%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_solvedtime()%></td>
<%}%>
<%if(result_obj.getCSR_reason()==null){%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff">-</td>
<%}else{%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_reason()%></td>
<%}%>
<%if(result_obj.getCSR_processing_contents()==null){%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff">-</td>
<%}else{%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_processing_contents()%></td>
<%}%>
<%if(result_obj.getCSR_estimate_md()==null){%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff">-</td>
<%}else{%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_estimate_md()%></td>
<%}%>
<%if(result_obj.getCSR_complete_md()==null){%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff">-</td>
<%}else{%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_complete_md()%></td>
<%}%>
<%if(result_obj.getCSR_finishtime()==null){%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff">-</td>
<%}else{%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_finishtime()%></td>
<%}%>
<%if(result_obj.getCSR_client_comment()==null){%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff">-</td>
<%}else{%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getCSR_client_comment()%></td>
<%}%>	
</tr>
<%
}%>
</table>
</body>
