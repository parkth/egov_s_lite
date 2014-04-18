<%@ page contentType="application/vnd.ms-excel;charset=UTF-8" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="kr.co.mycom.obstacle.*"%>
<%@ page import="java.util.*"%> 
<%@ page import="kr.co.mycom.asset.*"%>
<%@ page import="kr.co.mycom.code.*"%>
<%


//파일 다운로드 보안
String fileName = "obstacle.xls";
if(fileName !=null && !"".equals(fileName)){
fileName = fileName.replaceAll("&", "&amp");
fileName = fileName.replaceAll("<", "%lt;");
fileName = fileName.replaceAll(">", "&gt;");
fileName = fileName.replaceAll("\"", "&#34;");
fileName = fileName.replaceAll("\'", "&#39;");
fileName = fileName.replaceAll("%00", null);
fileName = fileName.replaceAll("%", "&#37;");
response.setHeader("Content-Disposition", "attachment; fileName=\"" + fileName + "\";"); 
response.setHeader("Content-Transfer-Encoding", "binary"); 
}else{
	%>
	<script type = "text/javascript">
	alert("확장자가 올바르지 않습니다.");
	history.back();
	</script>
<%
}
String my_id = (String) session.getAttribute("ID");

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
	String selected = "selected = 'selected'";
	String checked = "checked = 'checked'";	
	String StartYear=request.getParameter("ComboStartyear");
	/////////////////////////////////////////////////////////////////////////////////////////
	//부서 DB에서 불러와서 뿌려주는 부분 DTO,DAO사용
	String a_company = request.getParameter("a_company");
	String a_place = request.getParameter("a_place");
	String a_dept = request.getParameter("a_dept");
	if (a_company == null) { a_company = "C_00000"; }
	if (a_place == null) { a_place = "P_00000"; }
	if (a_dept == null) { a_dept = "D_00000"; }
	/////////////////////이까지가 본사/ 사업장/ 부서 받아오는 부분///////////
	
	if (StartYear == null) { StartYear = Integer.toString(year); }
	ObstacleDAO dao=new ObstacleDAO(); //DAO초기화
	List<ObstacleDTO> deptList = dao.searchCode(); //부서조회
	List<ObstacleDTO> O_List = dao.searchO_Code(); //대분류 조회
	ObstacleDAO O_dao=new ObstacleDAO(); //DAO초기화
	

	
	AssetDAO Adao = new AssetDAO();
	List<AssetDTO> m_code1_lists = Adao.search_mcode1();
	List<AssetDTO> m_code2_lists = Adao.search_mcode2();
	List<AssetDTO> m_code3_lists = Adao.search_mcode3();
	
	CodeDAO Cdao=new CodeDAO();
	List<CodeDTO> l_lists = Cdao.getGrade();
	int[] A_search=new int[13];
	int[] total=new int[13];
%>    
<script type="text/javascript">

function select_mcode2(){
    var selectValue = document.getElementById("a_place");
    D004.a_place.options.length = 0;  //모두삭제
    D004.a_dept.options.length = 0;  //모두삭제
	
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
		<%	for(AssetDTO m_code2_obj : m_code2_lists) {
			%>if(mcode1 == '<%=m_code2_obj.getM_code1()%>'){
				var option=new Option('<%=m_code2_obj.getM_name()%>', '<%=m_code2_obj.getM_code2()%>');
				if('<%=m_code2_obj.getM_code2() %>' == '<%=a_place %>'){
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
    D004.a_dept.options.length = 0;  //모두삭제
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
		<%	for(AssetDTO m_code3_obj : m_code3_lists) {
			%>if(mcode2 == '<%=m_code3_obj.getM_code1()%>'){
				var option=new Option('<%=m_code3_obj.getM_name()%>', '<%=m_code3_obj.getM_code2()%>');
				if('<%=m_code3_obj.getM_code2() %>' == '<%=a_dept %>'){
					option.selected = true;
				} 
				selectValue.options[i] = option;
				  i++;
			}
		<%}		%>
	
}
</script>

<table width="95%" border="1" cellspacing="1">
	<tr height="24">
		<td bgcolor="#A7A9AC" align="center" valign="middle" class="01black_bold"><font color="white">구분</font></td>
		<% for(int i=1;i<=12;i++){ %>
		<td bgcolor="#A7A9AC" align="center" valign="middle" class="01black_bold"><font color="white"><%=i%>월</font></td>
		<%} %>
		<td bgcolor="#A7A9AC" align="center" valign="middle" class="01black_bold"><font color="white">합계</font></td>
	</tr>
	<%for(CodeDTO l_name_obj : l_lists) {
		if(a_company.equals("C_00000")){
			A_search=O_dao.getGradeSearch(StartYear,a_company,a_place,a_dept,l_name_obj.getL_name());
			%>
		<tr height="24" >
			<td align="center"  bgcolor="#A7A9AC" valign="middle" class="01black_bold"><font color="white"><%=l_name_obj.getL_name()%>급</font></td>
			<% for(int i=0;i<=12;i++){
				total[i]+=A_search[i];
				%>
			<td align="center"  bgcolor="#ffffff" valign="middle" class="01black_bold"><font color="black"><%=A_search[i]%></font></td>
			<%} %>
		</tr>
		<%
			} else if(l_name_obj.getL_company().equals(a_company)){
		A_search=O_dao.getGradeSearch(StartYear,a_company,a_place,a_dept,l_name_obj.getL_name());
		%>
	<tr height="24" >
		<td align="center"  bgcolor="#A7A9AC" valign="middle" class="01black_bold"><font color="white"><%=l_name_obj.getL_name()%>급</font></td>
		<% for(int i=0;i<=12;i++){
			total[i]+=A_search[i];
			%>
		<td align="center"  bgcolor="#ffffff" valign="middle" class="01black_bold"><font color="black"><%=A_search[i]%></font></td>
		<%} %>
	</tr>
	<%
		}
		} %>
	<tr height="24" >
		<td align="center"  bgcolor="#A7A9AC" valign="middle" class="01black_bold"><font color="white">합계</font></td>
		<% for(int i=0;i<=12;i++){ %>
		<td align="center"  bgcolor="#ffffff" valign="middle" class="01black_bold"><font color="black"><%=total[i] %></font></td>
		<%} %>
	</tr>
</table>
</body>