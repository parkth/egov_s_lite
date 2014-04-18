<%@ page contentType="application/vnd.ms-excel;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="kr.co.mycom.obstacle.*"%>
<%@ page import="kr.co.mycom.member.MemberDTO"%>
<%@ page import="kr.co.mycom.member.MemberDAO"%>
<%@ page import="java.util.*"%>
<%@ page import="kr.co.mycom.asset.*"%>
<%@ page import="kr.co.mycom.code.*"%>


<%
	//response.setContentType("text/html; charset=EUC-KR");

	String my_id = (String) session.getAttribute("ID");
	String my_name = (String) session.getAttribute("NAME");
	String master=(String) session.getAttribute("Master");
	String bgcolor="";
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
	//현재연도와 일자 구하는 부분
	long time = System.currentTimeMillis();
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd");
	String time_in = dayTime.format(new Date(time)); //시간까지 모두 출력
	String[] arrTime_in = time_in.split("-");
	int year = Integer.parseInt(arrTime_in[0]);
	int month = Integer.parseInt(arrTime_in[1]);

	int day = Integer.parseInt(arrTime_in[2]);
	String selected = "selected = 'selected'";
	String checked = "checked = 'checked'";
	String disabled = "disabled = 'disabled'";
	/////////////////////////////////////////////////////////////////////////////////////////
	//부서 DB에서 불러와서 뿌려주는 부분 DTO,DAO사용

	String a_company = request.getParameter("a_company");
	String a_place = request.getParameter("a_place");
	String a_dept = request.getParameter("a_dept");
	
	if (a_company == null) {
		a_company = memberInfo.getM_company();
	}
	if (a_place == null) {
		a_place = memberInfo.getM_place();
	}
	if (a_dept == null) {
		a_dept = memberInfo.getM_dept();
	}
	
	// 사용자
	if (master.equals("0") == true) {
		a_company = memberInfo.getM_company();
		a_place = memberInfo.getM_place();
		a_dept = memberInfo.getM_dept();
	}
	// Engineer
	else if (master.equals("2") == true) {
		a_company = memberInfo.getM_company();
	}
	
	ObstacleDAO dao = new ObstacleDAO(); //DAO초기화
	AssetDAO Adao = new AssetDAO(); //DAO초기화
	List<ObstacleDTO> deptList = dao.searchCode(); //부서조회
	List<ObstacleDTO> O_List = dao.searchO_Code(); //대분류 조회
	//사용한 DAO,DTO 부서조회, 대분류 조회 
	////////////////////////////////////////////////////////////////////////////////////////////////////////
	//검색할 날짜 부분 
	String StartYear = request.getParameter("ComboStartyear");
	String EndYear = request.getParameter("ComboEndyear");
	String StartMonth = request.getParameter("ComboStartmonth");
	String EndMonth = request.getParameter("ComboEndmonth");
	if (StartYear == null){
		if(year<10) StartYear = "0"+Integer.toString(year);
		else StartYear = Integer.toString(year);
	}
	if (EndYear == null){
		if(year<10) EndYear = "0"+Integer.toString(year);
		else EndYear = Integer.toString(year);
	}
	if (StartMonth == null){
		if(month<10) StartMonth = "0"+Integer.toString(month);
		else StartMonth = Integer.toString(month);
	}
	if (EndMonth == null){
		if(month<10) EndMonth = "0"+Integer.toString(month);
		else EndMonth = Integer.toString(month);
	}
	String SearchStartDay = StartYear + StartMonth;
	String SearchEndDay = EndYear + EndMonth;
	//검색조회할 시작//종료기간 구하기 
	//라디오 장애등급/장애상태 셀렉트 조회 
	String ComboGrade = request.getParameter("ComboGrade");
	String Radiostatus = request.getParameter("Radiostatus");
	if (ComboGrade == null)
		ComboGrade = "L1_000";
	
	if (Radiostatus == null)
		Radiostatus = "S_00000";
	String O_rnum = request.getParameter("O_rnum"); //일련번호 
	if (O_rnum == null)
		O_rnum = "";

	String O_name = request.getParameter("O_name"); //신청자
	//String toEUCKR = new String(Encoding.getBytes(),"euc-kr");

	if(request.getParameter("O_name") != null)
		O_name  = new String(request.getParameter("O_name").getBytes("Cp1252"), "EUC-KR");//비고

	
	//String O_name = new String(request.getParameter("O_name").getBytes(), "EUC-KR");
	// 사용자일 경우만 이름 받아옴
	if (O_name == null) {
		if (master.equals("0") == true) O_name = my_name;
		else O_name = "";
	}

	////////////////////////////////////////////////////////////////////////////////////////
	String SelectedO_List = request.getParameter("comboO_List");
	if (SelectedO_List == null)
		SelectedO_List = "O1_0000";

	ObstacleDAO O_dao = new ObstacleDAO(); //DAO초기화
	List<ObstacleDTO> O_Search = O_dao.getSearch(SearchStartDay,
			SearchEndDay, ComboGrade, Radiostatus, a_company, a_place,
			a_dept, SelectedO_List, O_rnum, O_name); //대분류 조회

	
	List<AssetDTO> m_code1_lists = Adao.search_mcode1();
	List<AssetDTO> m_code2_lists = Adao.search_mcode2();
	List<AssetDTO> m_code3_lists = Adao.search_mcode3();
	
	CodeDAO codeDao = new CodeDAO();
	List<CodeDTO> lCode1List = codeDao.getLCode1List();

	String readOnly = "readOnly = 'readOnly'";
%>
<script type="text/javascript">

function excel_post()
{
	var frm=D002;
	frm.action = 'obstacle/D002_excel.jsp';
	frm.submit();
	frm.action = './masterpage.jsp?bo_table=D002';
}

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
		<%for (AssetDTO m_code2_obj : m_code2_lists) {%>
			if(selected_csr_code1 == '<%=m_code2_obj.getM_code1()%>'){
			var option=new Option('<%=m_code2_obj.getM_name()%>', '<%=m_code2_obj.getM_code2()%>');
			if('<%=m_code2_obj.getM_code2()%>' == '<%=a_place%>'){
				option.selected = true;
			}
				selectValue.options[i] = option;
				i++;
			}	
		<%}%>
		select_mcode3();
}

function select_mcode3(){
	 var selectValue = document.getElementById("a_dept");
	   selectValue.length = 0;  //모두삭제
		
	   var csr_code2 = document.getElementById("a_place");
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
		<%for (AssetDTO m_code3_obj : m_code3_lists) {%>
		if(selected_csr_code2 == '<%=m_code3_obj.getM_code1()%>'){
				var option=new Option('<%=m_code3_obj.getM_name()%>', '<%=m_code3_obj.getM_code2()%>');
				if('<%=m_code3_obj.getM_code2()%>' == '<%=a_dept%>'){
					option.selected = true;
				} 
				selectValue.options[i] = option;
				  i++;
			}
		<%}%>
	}

function select_lcode1() {
	var selectValue = document.getElementById("ComboGrade");

	    var o_code1 = document.getElementById("a_company");
		var selected_o_code1 = o_code1.options(o_code1.selectedIndex).value;

		var i=0;
		var option;
		if(o_code1=="C_00000" || o_code1==null){
			 option=new Option('전체보기', 'L1_000');
			option.selected = true;
		}
		else{
			 option=new Option('전체보기', 'L1_000');
		}
		 selectValue.options[i] = option;
		 i++;
		<% for(CodeDTO obj : lCode1List) { %>
		    if(selected_o_code1 == '<%=obj.getL_company()%>') {
			var option=new Option('<%=obj.getL_name()%>', '<%=obj.getL_code1()%>');
			
			<%
			if(ComboGrade.equals(obj.getL_code1()))
			{
			%>
			
			option.selected = true;
			
			<%
			}
			%>
			selectValue.options[i] = option;		
			i++;
		    }
		<% }%>
}
function DayCheck(){
	if (document.D002.ComboStartyear.value > document.D002.ComboEndyear.value) { // 검색연도가
		alert("조회 기간을 다시 선택하여 주십시오 ");
		return false;
	}else if((document.D002.ComboStartyear.value == document.D002.ComboEndyear.value) && (document.D002.ComboStartmonth.value > document.D002.ComboEndmonth.value)){
		alert("조회 기간을 다시 선택하여 주십시오 ");
		return false;
	}
	else{
		return true;
	}
}
function showDetail(o_rnum){ //팝업창 띄우는것
	var address = null;
	
	if ('<%=memberInfo.getM_master()%>' == "0") {
		address = './obstacle/D003.jsp?o_rnum=';
	}
	else {
		address = './obstacle/D003_admin.jsp?o_rnum=';
	}
	
	window.open(address+o_rnum, "pop", "width=1000,height=700,history=no,status=no,scrollbars=yes,menubar=no");
}
function initialize(){
	location.href ="./masterpage.jsp?bo_table=D002";
}

</script>

<form name="D002" action="./masterpage.jsp?bo_table=D002" method="post"
	onsubmit="return DayCheck()">
<table width="95%" align="center" border="1" cellspacing="1">
	<tr height="24">
		<td align="center" bgcolor="#A7A9AC" class="01black_bold"><font color="white">접수번호</font></td>
		<td align="center" bgcolor="#A7A9AC" class="01black_bold"><font color="white">제목</font></td>
		<td align="center" bgcolor="#A7A9AC" class="01black_bold"><font color="white">부서</font></td>
		<td align="center" bgcolor="#A7A9AC" class="01black_bold"><font color="white">자산번호(장비)</font></td>
		<td align="center" bgcolor="#A7A9AC" class="01black_bold"><font color="white">발생일/시간</font></td>
		<td align="center" bgcolor="#A7A9AC" class="01black_bold"><font color="white">요청시간</font></td>
		<td align="center" bgcolor="#A7A9AC" class="01black_bold"><font color="white">담당자</font></td>
		<td align="center" bgcolor="#A7A9AC" class="01black_bold"><font color="white">담당자연락처</font></td>
		<td align="center" bgcolor="#A7A9AC" class="01black_bold"><font color="white">접수시간</font></td>
		<td align="center" bgcolor="#A7A9AC" class="01black_bold"><font color="white">해결시간</font></td>
		<td align="center" bgcolor="#A7A9AC" class="01black_bold"><font color="white">종료시간</font></td>
		<td align="center" bgcolor="#A7A9AC" class="01black_bold"><font color="white">등급</font></td>
		<td align="center" bgcolor="#A7A9AC" class="01black_bold"><font color="white">진행사항</font></td>
	</tr>
	<%
		for (ObstacleDTO obj : O_Search) {
			if(obj.getO_state().equals("요청")){ bgcolor ="#da291c";} 
			else if(obj.getO_state().equals("해결중")){ bgcolor ="#daa520";}
			else if(obj.getO_state().equals("해결")){ bgcolor ="#800080";} //
			else{ bgcolor ="#483d8b";}
	%>
	<tr height="24" bgcolor="ffffff"> <!-- 손꾸락 0213 추가완료 -->
		<td align="center" onclick="showDetail('<%=obj.getO_rnum()%>');" class="black"><font color="black"><b><%=obj.getO_rnum()%></b></font></td>
		<% if((obj.getO_title().length())>5){ %>
		<td align="center" class="black"><%=(obj.getO_title()).substring(0,6)%>..</td>
		<%}else{ %>
		<td align="center" class="black"><%=(obj.getO_title())%></td>
		<%} %>
		<td align="center" class="black"><%=obj.getM_code3_m_name()%></td>
		
		<td align="center" class="black">
		<% 
		if (obj.getA_anum() != null) {
		String[] anumList = obj.getA_anum().split(",");
		String oneAssetStr = null;
		AssetDTO aDto = null;

		for (int i=0; i<anumList.length; i++) {
			oneAssetStr = anumList[i] + "(" + Adao.getAssetName(anumList[i]) + ")"; %>
			<%=oneAssetStr%><br>
		<% } 
		} %>
		</td>

		<%String[] s1 = (obj.getO_occurrencetime()).split(" "); %>
		<td align="center" class="black"><%=s1[0]%><br><%=s1[1]%></td>
		<%String[] s2 = (obj.getO_requesttime()).split(" "); %>
		<td align="center" class="black"><%=s2[0]%><br><%=s2[1]%></td>
		<td align="center" class="black"><%=obj.getA_name()%></td>
		<td align="center" class="black"><%=obj.getA_linenum()%></td>
		<% if(!obj.getO_solvingtime().equals("")){
		  String[] s3 = (obj.getO_solvingtime()).split(" "); %>
		<td align="center" class="black"><%=s3[0]%><br><%=s3[1]%></td>
		<%}else{ %>
		<td align="center" class="black"><%=obj.getO_solvingtime()%></td>
		<%} %>
		<% if(!obj.getO_solvedtime().equals("")){
		  String[] s4 = (obj.getO_solvedtime()).split(" "); %>
		<td align="center" class="black"><%=s4[0]%><br><%=s4[1]%></td>
		<%}else{ %>
		<td align="center" class="black"><%=obj.getO_solvedtime()%></td>
		<%} %>
		
		<% if(!obj.getO_finishtime().equals("")){
		  String[] s5 = (obj.getO_finishtime()).split(" "); %>
		<td align="center" class="black"><%=s5[0]%><br><%=s5[1]%></td>
		<%}else{ %>
		<td align="center" class="black"><%=obj.getO_finishtime()%></td>
		<%} 
		String lcodeName = "";
		for (CodeDTO lcodeObj : lCode1List) {
			if (obj.getO_ograde().equals(lcodeObj.getL_code1())) {
				lcodeName = lcodeObj.getL_name();
				break;
			}
		}
		%>
		<td align="center" class="black"><%=lcodeName%></td>
		<td align="center" class="black" ><font color="<%=bgcolor %>"><b><%=obj.getO_state()%></b></font></td>
	</tr>
	<%
		}
	%>
</table>
<script>
select_mcode2(); select_lcode1();
</script>
</form>
<% if (master.equals("0") == true) { // 사용자 %>
<input type="hidden" id="a_company" name="a_company" value="<%=memberInfo.getM_company() %>" />
<input type="hidden" id="a_place" name="a_place" value="<%=memberInfo.getM_place() %>" />
<input type="hidden" id="a_dept" name="a_dept" value="<%=memberInfo.getM_dept() %>" />
<% }
	else if (master.equals("2") == true) { // Engineer %>
<input type="hidden" id="a_company" name="a_company" value="<%=memberInfo.getM_company() %>" />
<% } %>
</body>