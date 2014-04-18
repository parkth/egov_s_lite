<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="kr.co.mycom.obstacle.*"%>
<%@ page import="java.util.*"%> 
<%@ page import="kr.co.mycom.asset.*"%>
<%@ page import="kr.co.mycom.code.*"%>
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
	/////////////////////이까지가 본사/ 사업장/ 부서 받아오는 부분//////////////////////////////
	
	if (StartYear == null) { StartYear = Integer.toString(year); }
	
	ObstacleDAO dao=new ObstacleDAO(); //DAO초기화
	List<ObstacleDTO> deptList = dao.searchCode(); //부서조회
	List<ObstacleDTO> O_List = dao.searchO_Code(); //대분류 조회
	ObstacleDAO O_dao=new ObstacleDAO(); //DAO초기화
	int Max_Size=O_List.size();
	int[] A_search=new int[Max_Size+1];
	int[] total=new int[Max_Size+1];
	
	
	

	String format = "#.#";
	java.text.DecimalFormat df = new java.text.DecimalFormat(format);
	
	AssetDAO Adao = new AssetDAO();
	List<AssetDTO> m_code1_lists = Adao.search_mcode1();
	List<AssetDTO> m_code2_lists = Adao.search_mcode2();
	List<AssetDTO> m_code3_lists = Adao.search_mcode3();
	
	CodeDAO Cdao=new CodeDAO();
	List<CodeDTO> l_lists = Cdao.getGrade();
%>
<script type="text/javascript">

function excel_post()
{
	var frm=D005;
	frm.action = 'obstacle/D005_excel.jsp';
	frm.submit();
	frm.action = './masterpage.jsp?bo_table=D005';
}

function select_mcode2(){
    var selectValue = document.getElementById("a_place");
    D005.a_place.options.length = 0;  //모두삭제
    D005.a_dept.options.length = 0;  //모두삭제
	
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
    D005.a_dept.options.length = 0;  //모두삭제
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>S-LITE</title>
</head>
<body onload="select_mcode2();">
<form name="D005" action="./masterpage.jsp?bo_table=D005"  method="post" >
<table width="95%" align="center">
<tr>
<td align="left">● 장애관리대장 ▶ 유형별건수</td>
<td align="right">
<input type="submit" ID="btnView" value="조회" style="width: 120px;height: 30px; font-family: Gothic; font-size: 9pt"	onclick="" />
<input type="button" value="다운로드" style="width: 120px;height: 30px; font-family: Gothic; font-size: 9pt" onclick="javascript:excel_post()"  />
</tr>
</table>
<table>
		<tr>
			<td style="height: 30px"></td>
		</tr>
	</table>

<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
			<tr>
				<td width="10%" align="center" class="01black_bold" bgcolor="#A7A9AC"><font color="white">발생년도</font></td>
				<td width="20%" align="center" class="01black_bold" bgcolor="ffffff"><font color="white">
				<select id="ComboStartyear" name="ComboStartyear" style="width: 90%; font-family: Gothic; font-size: 9pt">
					<%
						for(int i=year-5; i<=year+5;i++){ 
							if(StartYear==""){
					%>
					<option value=<%=i%> <%=((year == i) == true ? selected : "")%>><%=i%></option>
					<%
							}
							else{
					%>
					<option value=<%=i%> <%=((Integer.parseInt(StartYear) == i) == true ? selected : "")%>><%=i%></option>
					<%
							}
					%>			
						<%
							}
						%>
		</select>년</font></td>
				<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">회사</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
				<select id="a_company" name="a_company" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_mcode2()">
							<option value="C_00000">전체보기</option>
							<%	for(AssetDTO m_code1_obj : m_code1_lists) {%>
									<option value=<%=m_code1_obj.getM_code1() %> <%=(a_company.equals(m_code1_obj.getM_code1()) == true ? selected : "") %>><%=m_code1_obj.getM_name()%></option>
										<%	} %>
				</select>
				</td>
				<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">사업장</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
					<select id="a_place" name="a_place" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_mcode3()">
					</select>
				</td>
				<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">부서</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
					<select id="a_dept" name="a_dept" style="width: 100%; font-family: Gothic; font-size: 9pt">
					</select>
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
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">등급</font></td>
					<% for(ObstacleDTO obj : O_List){%>
						<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" colspan="2"><font color="white"><%=obj.getO_name()%></font></td>						
					<% }%>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">합계(건수)</font></td>
				</tr>
				<tr>
					<td align="center" width="10%" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white"></font></td>				
					<% for(ObstacleDTO obj : O_List){%>
						<td align="center" width="8%" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">건수</font></td>					
						<td align="center" width="8%" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">%</font></td>						
					<% }%>
					<td align="center" width="10%" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white"></font></td>
				</tr>
				<%for(CodeDTO l_name_obj : l_lists) {
					if(a_company.equals("C_00000")){
					A_search=O_dao.getTypeSearch(StartYear,l_name_obj.getL_code1(),a_company,a_place,a_dept);
					%>
					<tr>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white"><%=l_name_obj.getL_name()%>급</font></td>
					<% for(int i=0;i<A_search.length-1;i++){
						total[i]+=A_search[i];
						%>
						<td align="center" width="8%"valign="middle" class="01black_bold" bgcolor="#ffffff"><font color="black"><%=A_search[i] %></font></td>					
						<td align="center" width="8%" valign="middle" class="01black_bold" bgcolor="#ffffff"><font color="black"><%=((A_search[Max_Size])!= 0 ?df.format((double)A_search[i]/A_search[Max_Size]*100) : 0)%> %</font></td>
					<%}total[Max_Size]+=A_search[Max_Size];%>
					<td align="center" width="8%" valign="middle" class="01black_bold" bgcolor="#ffffff"><font color="black"><%=A_search[Max_Size]%></font></td>
				</tr>
				<%} else if(l_name_obj.getL_company().equals(a_company)){
					A_search=O_dao.getTypeSearch(StartYear,l_name_obj.getL_code1(),a_company,a_place,a_dept);
					%>
					<tr>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white"><%=l_name_obj.getL_name()%>급</font></td>
					<% for(int i=0;i<A_search.length-1;i++){
						total[i]+=A_search[i];
						%>
						<td align="center" width="8%"valign="middle" class="01black_bold" bgcolor="#ffffff"><font color="black"><%=A_search[i] %></font></td>					
						<td align="center" width="8%" valign="middle" class="01black_bold" bgcolor="#ffffff"><font color="black"><%=((A_search[Max_Size])!= 0 ?df.format((double)A_search[i]/A_search[Max_Size]*100) : 0)%> %</font></td>
					<%}total[Max_Size]+=A_search[Max_Size]; %>
					<td align="center" width="8%" valign="middle" class="01black_bold" bgcolor="#ffffff"><font color="black"><%=A_search[Max_Size]%></font></td>
				</tr>
				<%}
					}%>
				<tr>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">합계</font></td>
					<% for(int i=0;i<A_search.length-1;i++){ %>
						<td align="center" width="8%"valign="middle" class="01black_bold" bgcolor="#ffffff"><font color="black"><%=total[i]%></font></td>					
						<td align="center" width="8%" valign="middle" class="01black_bold" bgcolor="#ffffff"><font color="black"><%= ((total[Max_Size])!= 0 ?df.format((double)(total[i])/(total[Max_Size])*100) : 0)%> %</font></td>
					<%} %>
					<td align="center" width="8%" valign="middle" class="01black_bold" bgcolor="#ffffff"><font color="black"><%=total[Max_Size] %></font></td>
				</tr>
	</table>
</form>
</body>
</html>