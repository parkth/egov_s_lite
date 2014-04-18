<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.security.CheckSecurity"%>
<%@ page import="kr.co.mycom.asset.*"%>
<%@ page import="kr.co.mycom.member.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.io.File"%>
    
<%
	String anum = request.getParameter("anum");
	CheckSecurity checkSecurity = new CheckSecurity();
	AssetDAO dao = new AssetDAO();
	AssetDTO dto = dao.search_detail_admin(anum);
	String my_id = (String) session.getAttribute("ID");
	String selected = "selected = 'selected'";
	String checked = "checked = 'checked'";

	List<AssetDTO> m_code1_lists = dao.search_mcode1();
	List<AssetDTO> m_code2_lists = dao.search_mcode2();
	List<AssetDTO> m_code3_lists = dao.search_mcode3();

	List<AssetDTO> a_code1_lists = dao.search_acode1();
	List<AssetDTO> a_code2_lists = dao.search_acode2();
	List<AssetDTO> a_code3_lists = dao.search_acode3();
	
	MemberDAO member_dao= new MemberDAO();
	List<MemberDTO> m_name_lists = member_dao.search_mname();
	
	AssetDAO dao_history = new AssetDAO();
	List<AssetDTO> result_history = dao.getA_history(anum);

	if(my_id == null || my_id.equals("null")){
		%>
			<script type = "text/javascript">
			alert("로그인하지 않으면 접근할 수 없습니다.");
			history.back();
			</script>
		<%
	}
	
	String master = (String) session.getAttribute("Master");

	if(!master.equals("1")){
		%>
			<script type = "text/javascript">
			alert("관리자가 아니면 접근할 수 없습니다.");
			history.back();
			</script>
		<%
	}
%>
  
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  
<script type="text/javascript">

function select_mcode2(){
    var selectValue = document.getElementById("a_place");
    C003_form.a_place.options.length = 0;  //모두삭제
    C003_form.a_dept.options.length = 0;  //모두삭제
	
    var value_mcode1 = document.getElementById("a_company");
	var mcode1 = value_mcode1.options(value_mcode1.selectedIndex).value;	
	var place='<%=dto.getA_place()%>';
	var i=0;
	var option;
	
		<%for (AssetDTO m_code2_obj : m_code2_lists) {%>if(mcode1 == '<%=m_code2_obj.getM_code1()%>'){
				if('<%=m_code2_obj.getM_enable()%>' == '1'){
				var option=new Option('<%=m_code2_obj.getM_name()%>', '<%=m_code2_obj.getM_code2()%>');
				if('<%=m_code2_obj.getM_code2()%>' == '<%=dto.getA_place()%>'){
					option.selected = true;
				}
				selectValue.options[i] = option;
				i++;
				}
			}	
		<%}%>
	
		
		select_mcode3();
}

function select_mcode3(){
    var selectValue = document.getElementById("a_dept");
    C003_form.a_dept.options.length = 0;  //모두삭제
    var dept='<%=dto.getA_dept()%>';
	var value_mcode2 = document.getElementById("a_place");
	var mcode2 = value_mcode2.options(value_mcode2.selectedIndex).value;
	var i=0;
	var option;
	
		<%for (AssetDTO m_code3_obj : m_code3_lists) {%>if(mcode2 == '<%=m_code3_obj.getM_code1()%>'){
			if('<%=m_code3_obj.getM_enable()%>' == '1'){
			var option=new Option('<%=m_code3_obj.getM_name()%>', '<%=m_code3_obj.getM_code2()%>');
				if('<%=m_code3_obj.getM_code2()%>' == '<%=dto.getA_dept()%>'){
					option.selected = true;
				} 
				selectValue.options[i] = option;
				  i++;
			}
			}
		<%}%>
	
}

function select_acode2(){
    var selectValue = document.getElementById("a_code2");
    C003_form.a_code2.options.length = 0;  //모두삭제
    C003_form.a_code3.options.length = 0;  //모두삭제
	var a_code2='<%=dto.getA_code2()%>';
	var i=0;
	var option;
	var value_acode1 = document.getElementById("a_code1");
	var acode1 = value_acode1.options(value_acode1.selectedIndex).value;
	
		<%	for(AssetDTO a_code2_obj : a_code2_lists) {
			%>if(acode1 == '<%=a_code2_obj.getA_code1()%>'){
				if('<%=a_code2_obj.getA_enable()%>' == '1'){

				var option=new Option('<%=a_code2_obj.getA_name()%>', '<%=a_code2_obj.getA_code2()%>');
				if('<%=a_code2_obj.getA_code2()%>' == '<%=dto.getA_code2()%>'){
					option.selected = true;
				} 
				selectValue.options[i] = option;
				  i++;
				}
			}	
		<%}%>

		select_acode3();
}
function select_acode3(){
    var selectValue = document.getElementById("a_code3");
    C003_form.a_code3.options.length = 0;  //모두삭제
    var a_code3= '<%=dto.getA_code3()%>';
	var i=0;
	var option;
    var value_acode2 = document.getElementById("a_code2");
	var acode2 = value_acode2.options(value_acode2.selectedIndex).value;
	
		<%	for(AssetDTO a_code3_obj : a_code3_lists) {
			%>if(acode2 == '<%=a_code3_obj.getA_code1()%>'){
				if('<%=a_code3_obj.getA_enable()%>' == '1'){

				var option=new Option('<%=a_code3_obj.getA_name()%>', '<%=a_code3_obj.getA_code2()%>');
				if('<%=a_code3_obj.getA_code2()%>' == '<%=dto.getA_code3()%>'){
					option.selected = true;
				} 
				selectValue.options[i] = option;
				i++;
				}
			}	
		<%}		%>
}


function select_manme(){
	var selectValue = document.getElementById("a_name");
    var value_mcode1 = document.getElementById("a_dept");
	var mcode1 = value_mcode1.options(value_mcode1.selectedIndex).value;	

	var i=0;
		<%	for(MemberDTO m_name_obj : m_name_lists) {
			%>
			  if(mcode1 == '<%=m_name_obj.getM_dept()%>'){
				var option=new Option('<%=m_name_obj.getM_name()%>');
				if('<%=m_name_obj.getM_name()%>' == '<%=dto.getA_name()%>'){
					option.selected = true;
					document.C003_form.a_id.value = '<%=m_name_obj.getM_id()%>';
				} 
				selectValue.options[i] = option;
				i++;
			}
		<%}		%>
}

function put_id(){
	var selectValue = document.getElementById("a_name");
    var value_mcode1 = document.getElementById("a_dept");
	var mcode1 = value_mcode1.options(value_mcode1.selectedIndex).value;	

		<%	for(MemberDTO m_name_obj : m_name_lists) {
			%>
				if('<%=m_name_obj.getM_name()%>' == selectValue.value){
					document.C003_form.a_id.value = '<%=m_name_obj.getM_id()%>';
				} 
		<%}		%>	
}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>S-LITE</title>
<link rel="stylesheet" type="text/css" href="../common.css" />
</head>
<body onload="select_mcode2();select_acode2();select_manme();">
<form name="C003_form" method="post" action="C003_update.jsp">
<table width="95%" align="center">
<tr>
<td align="left">● 자산관리대장 ▶ 자산상세현황</td>
<td align="right">
<input type="submit" value="수정" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt"/>
<input type="button" value="삭제" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt" onclick="javascript:location.href='C003_delete.jsp?a_anum=<%=dto.getA_anum() %>'"/>
<input type="button" value="닫기" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt" onclick="javascript:self.close();"/>
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
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산번호</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_anum" name="a_anum" value='<%=dto.getA_anum() %>' style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">관리번호</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_gnum" name="a_gnum" value='<%=dto.getA_gnum() %>' style="width: 98%; font-family: Gothic; font-size: 9pt" />
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">회사</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<%
	
%>
<select id="a_company" name="a_company" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_mcode2()">
			<%	for(AssetDTO m_code1_obj : m_code1_lists) {
					if(m_code1_obj.getM_enable().equals("1")){%>
					<option value=<%=m_code1_obj.getM_code1() %> <%=(dto.getA_company().equals(m_code1_obj.getM_code1()) == true ? selected : "") %>><%=m_code1_obj.getM_name()%></option>
						<%	
					}
					} %>
</select>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산 구분</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_code1" name="a_code1" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_acode2()">
			<%	for(AssetDTO a_code1_obj : a_code1_lists) {
					if(a_code1_obj.getA_enable().equals("1")){%>
					<option value=<%=a_code1_obj.getA_code1()  %> <%=(dto.getA_code1().equals(a_code1_obj.getA_code1()) == true ? selected : "") %>><%=a_code1_obj.getA_name()%></option>
						<%	}
					} %>
</select>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">사업장</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_place" name="a_place" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_mcode3()" >
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
<select id="a_dept" name="a_dept" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_manme()">
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
<input type="text" id="a_locate" name="a_locate" value='<%=checkSecurity.getText(dto.getA_locate()) %>' style="width: 98%; font-family: Gothic; font-size: 9pt" />
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">품명</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_aname" name="a_aname" value='<%=checkSecurity.getText(dto.getA_aname()) %>' style="width: 98%; font-family: Gothic; font-size: 9pt" />
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">이름</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_name" name="a_name" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="javascript:put_id()">
</select>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">Model</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_amodel" name="a_amodel" value='<%=checkSecurity.getText(dto.getA_amodel()) %>' style="width: 98%; font-family: Gothic; font-size: 9pt" />
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">ID</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_id" name="a_id" value='<%=dto.getA_id() %>' style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">제조사</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_vendorname" name="a_vendorname" value='<%=checkSecurity.getText(dto.getA_vendorname()) %>' style="width: 98%; font-family: Gothic; font-size: 9pt" />
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">취득일</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_getdate" name="a_getdate" value='<%=dto.getA_getdate() %>' style="width: 98%; font-family: Gothic; font-size: 9pt" />
<input type="hidden" id="a_adddate" name="a_adddate" value='<%=dto.getA_adddate() %>'>
</td>
<td rowspan="2" width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">SPEC.</font></td>
<td rowspan="2" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<textarea id="a_spec" name="a_spec" style="width: 98%; height: 50px; font-family: Gothic; font-size: 9pt" >
<%=checkSecurity.getText(dto.getA_spec()) %>
</textarea>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">비고</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_bigo" name="a_bigo" value='<%=checkSecurity.getText(dto.getA_bigo())%>' style="width: 98%; font-family: Gothic; font-size: 9pt" />
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">사용여부</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold" >
<input type="checkbox" name="a_enable" id="a_enable" size="12" style="font-family: Gothic; font-size: 9pt" <%=(dto.getA_enable().equals("1") == true ? checked : "")%> ></td>

<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">첨부파일</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<% if (dto.getA_attachment() != null && !(dto.getA_attachment().equals("")) && !(dto.getA_attachment().equals("NULL"))) {

 String filePath = dto.getA_attachment();
 
 StringTokenizer tokens = new StringTokenizer(filePath, "|");
 File tempFile = null;
 String fileName = null;
 String oneFilePath = null;
 
 while (tokens.hasMoreElements()) {
	 oneFilePath = tokens.nextToken();
	 tempFile = new File(oneFilePath);
	 fileName = tempFile.getName(); %>
<a href="../file_download.jsp?fileName=<%=fileName%>&filePath=<%=oneFilePath%>"><font color="blue"><%=fileName %></font></a>&nbsp;&nbsp;
<a href="../file_delete_assets.jsp?filePath=<%=oneFilePath%>&anum=<%=anum%>&fileFullPath=<%=filePath%>"><font color="blue">삭제</font></a>&nbsp;&nbsp;
 
 <% }
 } %>
</td>
</tr>
</table>
<br>	
<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
<tr>
<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">번호</font></td>
<td width="20%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">취득일</font></td>
<td width="15%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">ID</font></td>
<td width="15%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">이름</font></td>
<td width="15%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">회사</font></td>
<td width="15%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">사업장</font></td>
<td width="15%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">부서</font></td>

</tr>
			<% 
				int result_num = 1;
				for(AssetDTO result_obj : result_history) {
			%>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_num %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_getdate() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_id() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getM_name() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_company() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_place() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_dept() %></td>
</tr>
			<%
				result_num = result_num + 1;
				} 
			%>
</table>
</form>
</body>
</html>