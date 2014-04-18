<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.List" %>   
<%@ page import="kr.co.mycom.asset.*" %>
<%@page import="kr.co.mycom.asset.AssetDTO"%>
<%@page import="kr.co.mycom.asset.AssetDAO"%>
<%@page import="java.util.List"%>

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
// 한글 parameter 전달시 깨지는 것 방지
request.setCharacterEncoding("euc-kr");

String selected = "selected = 'selected'";

String a_company = request.getParameter("a_company_asset");
String a_place = request.getParameter("a_place_asset");
String a_dept = request.getParameter("a_dept_asset");

String a_code1 = request.getParameter("a_code1_asset");
String a_code2 = request.getParameter("a_code2_asset");
String a_code3 = request.getParameter("a_code3_asset");

String a_amodel = request.getParameter("a_amodel_asset");

String a_owner = request.getParameter("a_owner");

String assetValue = new String(request.getParameter("assetValue").getBytes("Cp1252"), "EUC-KR");
String retAssetValue = "";

String[] assetValueList = assetValue.split(",");
String[] allAssetNumberList = new String[assetValueList.length];
String[] allAssetNameList = new String[assetValueList.length];


if (a_owner == null ) {
	a_owner = "";
}
if (a_company == null) {
	a_company = "C_00000";
}
if (a_place == null) {
	a_place = "P_00000";
}
if (a_dept == null) {
	a_dept = "D_00000";
}

if(a_code1 == null){
	a_code1 = "A1_0000";
}
if(a_code2 == null){
	a_code2 = "A2_0000";
}
if(a_code3 == null){
	a_code3 = "A3_0000";
}

if(a_amodel == null){
	a_amodel = "";
}


String check_name = "check_name";
String asset_num = "asset_num";
String asset_name = "asset_name";


AssetDAO assetDao = new AssetDAO();
//List<AssetDTO> assetList = assetDao.getAssetList();

List<AssetDTO> m_code1_lists = assetDao.search_mcode1();
List<AssetDTO> m_code2_lists = assetDao.search_mcode2();
List<AssetDTO> m_code3_lists = assetDao.search_mcode3();

List<AssetDTO> a_code1_lists = assetDao.search_acode1();
List<AssetDTO> a_code2_lists = assetDao.search_acode2();
List<AssetDTO> a_code3_lists = assetDao.search_acode3();

//검색조건 DTO에 SET
AssetDTO assetInfo = new AssetDTO();
assetInfo.setA_company(a_company);
assetInfo.setA_place(a_place);
assetInfo.setA_dept(a_dept);
assetInfo.setA_code1(a_code1);
assetInfo.setA_code2(a_code2);
assetInfo.setA_code3(a_code3);
assetInfo.setA_amodel(a_amodel);
assetInfo.setA_name(a_owner);

List<AssetDTO> asset_lists = assetDao.getAssetList(assetInfo);

%>

<script type="text/javascript">

function initAssetOwner() {
	// 맨 처음 창이 호출될 때 값 셋팅
	if ((document.getElementById("a_owner").value == null) || (document.getElementById("a_owner").value == "")) {
		document.getElementById("a_owner").value =  opener.document.getElementById("o_detail_member_name").value;
	}

	if ((document.getElementById("a_owner").value == null) || (document.getElementById("a_owner").value == "")) {
		document.getElementById("a_owner").value =  opener.document.getElementById("o_detail_member_name").value;
	}


	opener.document.getElementById("o_detail_asset").value;
}

function select_mcode2(){
    var selectValue = document.getElementById("a_place_asset");
    asset_list_form.a_place_asset.options.length = 0;  //모두삭제
    asset_list_form.a_dept_asset.options.length = 0;  //모두삭제
	
    var value_mcode1 = document.getElementById("a_company_asset");
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
		<%for (AssetDTO m_code2_obj : m_code2_lists) {%>if(mcode1 == '<%=m_code2_obj.getM_code1()%>'){
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
    var selectValue = document.getElementById("a_dept_asset");
    asset_list_form.a_dept_asset.options.length = 0;  //모두삭제
    var dept='<%=a_dept%>';
	var value_mcode2 = document.getElementById("a_place_asset");
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
		<%for (AssetDTO m_code3_obj : m_code3_lists) {%>if(mcode2 == '<%=m_code3_obj.getM_code1()%>'){
				var option=new Option('<%=m_code3_obj.getM_name()%>', '<%=m_code3_obj.getM_code2()%>');
				if('<%=m_code3_obj.getM_code2()%>' == '<%=a_dept%>'){
					option.selected = true;
				} 
				selectValue.options[i] = option;
				  i++;
			}
		<%}%>
	
}

function select_acode2(){
    var selectValue = document.getElementById("a_code2_asset");
    asset_list_form.a_code2_asset.options.length = 0;  //모두삭제
    asset_list_form.a_code3_asset.options.length = 0;  //모두삭제
	var a_code2='<%=a_code2%>';
	var i=0;
	var option;
	var value_acode1 = document.getElementById("a_code1_asset");
	var acode1 = value_acode1.options(value_acode1.selectedIndex).value;
	if(a_code2=="A2_0000"||a_code2==null){
		option=new Option('전체보기', 'A2_0000');
		option.selected = true;
	}
	else{
		option=new Option('전체보기', 'A2_0000');
	}
	  selectValue.options[i] = option;
	  i++;
		<%	for(AssetDTO a_code2_obj : a_code2_lists) {
			%>if(acode1 == '<%=a_code2_obj.getA_code1()%>'){
				var option=new Option('<%=a_code2_obj.getA_name()%>', '<%=a_code2_obj.getA_code2()%>');
				if('<%=a_code2_obj.getA_code2()%>' == '<%=a_code2%>'){
					option.selected = true;
				} 
				selectValue.options[i] = option;
				  i++;
			}	
		<%}%>

		select_acode3();
}
function select_acode3(){
    var selectValue = document.getElementById("a_code3_asset");
    asset_list_form.a_code3_asset.options.length = 0;  //모두삭제
    var a_code3= '<%=a_code3%>';
	var i=0;
	var option;
    var value_acode2 = document.getElementById("a_code2_asset");
	var acode2 = value_acode2.options(value_acode2.selectedIndex).value;
	if(a_code3=="A3_0000"||a_code3==null){
		option=new Option('전체보기', 'A3_0000');
		option.selected = true;
	}
	else{
		option=new Option('전체보기', 'A3_0000');
	}
	  selectValue.options[i] = option;
	  i++;
		<%	for(AssetDTO a_code3_obj : a_code3_lists) {
			%>if(acode2 == '<%=a_code3_obj.getA_code1()%>'){
				var option=new Option('<%=a_code3_obj.getA_name()%>', '<%=a_code3_obj.getA_code2()%>');
				if('<%=a_code3_obj.getA_code2()%>' == '<%=a_code3%>'){
					option.selected = true;
				} 
				selectValue.options[i] = option;
				i++;
			}	
		<%}		%>
}

// asset_code: 장비코드, asset_name: 장비명, asset_num: 자산번호
function goBack(asset_code, asset_name, asset_num) {

	var delimiter = ",";

	// 초기값이 없는 경우.
	if (opener.document.getElementById("o_detail_asset").value == "") {
		delimiter = "";
	}
	opener.document.getElementById("o_detail_asset").value += delimiter + asset_name + '/' + asset_num;
	
	self.close();
}

function check_delete(){
	var check_name = null;
	var asset_num = null;
	var asset_name = null;
	var return_str = "";
	var check_length = document.asset_list_form.checkBoxLength.value;

	var delimiter = ",";

	for (var i=0; i<check_length; i++) {
		asset_name = '<%=asset_name%>'+i;
		asset_num = '<%=asset_num%>'+i;
		check_name = '<%=check_name%>'+i;

		if (document.getElementById(check_name).checked == false) {

			if (return_str == "") delimiter = "";
			else delimiter = ",";

			return_str += delimiter + document.getElementById(asset_name).value + '/' + document.getElementById(asset_num).value;
		}
	}

	//if (return_str == "") return_str = "/";
	opener.obstacle_detail_form.o_detail_asset.value = return_str;

	//opener.document.getElementById("o_detail_asset_code").value = asset_code;

	self.close();
}
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>S-LITE</title>
<link rel="stylesheet" type="text/css" href="../common.css" />
</head>
<body>
<form name="asset_list_form" action="./asset_list.jsp?assetValue=<%=assetValue%>" method="post">

<table>
	<tr>
		<td style="height: 20px"></td>
	</tr>
</table>

<table width="90%" align="center">
	<tr>
		<td align="left">● 장비선택</td>
		<td align="right">
		<input type="submit" value="검색" style="width: 100px; height: 30px; font-family: Gothic; font-size: 9pt"></input>
	</tr>
</table>

<table>
	<tr>
		<td style="height: 20px"></td>
	</tr>
</table>

<table width="90%" align="center" border="0" cellspacing="1" bgcolor="000000">
<tr>
<td width="20%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">회사</font></td>
<td width="30%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_company_asset" name="a_company_asset" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_mcode2()">
			<option value="C_00000">전체보기</option>
			<%	for(AssetDTO m_code1_obj : m_code1_lists) {%>
					<option value=<%=m_code1_obj.getM_code1() %> <%=(a_company.equals(m_code1_obj.getM_code1()) == true ? selected : "") %>><%=m_code1_obj.getM_name()%></option>
						<%	} %>
</select>
</td>
<td width="20%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산 구분</font></td>
<td width="30%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_code1_asset" name="a_code1_asset" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_acode2()">
			<option value="A1_0000">전체보기</option>
			<%	for(AssetDTO a_code1_obj : a_code1_lists) {%>
					<option value=<%=a_code1_obj.getA_code1()  %> <%=(a_code1.equals(a_code1_obj.getA_code1()) == true ? selected : "") %>><%=a_code1_obj.getA_name()%></option>
						<%	} %>
</select>
</td>
</tr>

<tr>		
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">사업장</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_place_asset" name="a_place_asset" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_mcode3()">
</select>
</td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산 종류</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_code2_asset" name="a_code2_asset" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_acode3()">
</select>
</td>	
</tr>

<tr>	
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">부서</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_dept_asset" name="a_dept_asset" style="width: 100%; font-family: Gothic; font-size: 9pt">
</select>
</td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산 유형</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<select id="a_code3_asset" name="a_code3_asset" style="width: 100%; font-family: Gothic; font-size: 9pt">
</select>
</td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">모델명</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_amodel_asset" name="a_amodel_asset" value='<%=a_amodel %>' style="width: 98%; font-family: Gothic; font-size: 9pt"/>
</td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산소유자</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_owner" name="a_owner" value='<%=a_owner %>' style="width: 98%; font-family: Gothic; font-size: 9pt"/>
</td>
</tr>
</table>

<table>
	<tr>
		<td style="height: 20px"></td>
	</tr>
</table>

<table width="50%" align="center">
	<tr>
		<td align="left">● 선택된 장비 리스트</td>
		<td align="right">
		<input type="button" value="선택 삭제" onclick="javascript:check_delete();" style="width: 100px; height: 30px; font-family: Gothic; font-size: 9pt"></input>
	</tr>
</table>

<table>
	<tr>
		<td style="height: 20px"></td>
	</tr>
</table>

<table width="50%" align="center" cellpadding=0 cellspacing=0 id="" border="0" bgcolor="000000">
<tr bgcolor="#A7A9AC">
 <td align="center" class="01black_bold" width="5%"><font color="white">체크</font></td>
 <td align="center" class="01black_bold" width="20%"><font color="white">자산번호</font></td>
 <td align="center" class="01black_bold" width="20%"><font color="white">장비명</font></td>
</tr>

 <% int i=0;
 	if (!assetValue.equals("")) {
 	for (; i<assetValueList.length; i++) {
 		String[] oneAssetValueList = assetValueList[i].split("/");
 		allAssetNameList[i] = oneAssetValueList[0];		
 		allAssetNumberList[i] = oneAssetValueList[1]; 		
 		%>
  <tr bgcolor="ffffff">
 	<td align="center" class="black"><input type=checkbox name=<%=check_name+i %>></td>
 	<td align="center" class="black"><%=oneAssetValueList[1]%>
 	<input type="hidden" id=<%=asset_num+i %> name=<%=asset_num+i %> value=<%=oneAssetValueList[1] %> /></td>
 	<td align="center" class="black"><%=oneAssetValueList[0]%>
 	<input type="hidden" id=<%=asset_name+i %> name=<%=asset_name+i %> value=<%=oneAssetValueList[0] %> /></td>
  </tr>
 <%	}
 	}
 %>


</table>

<table>
	<tr>
		<td style="height: 30px"><input type="hidden" name=checkBoxLength value=<%=i %>></input></td>
	</tr>
</table>


<table width="90%" align="center" border="0" cellspacing="1" bgcolor="000000">
<tr bgcolor="#A7A9AC">
<td align="center" class="01black_bold" width="10%"><font color="white">자산번호</font></td>
<td align="center" class="01black_bold" width="10%"><font color="white">자산구분</font></td>
<td align="center" class="01black_bold" width="10%"><font color="white">자산종류</font></td>
<td align="center" class="01black_bold" width="10%"><font color="white">장비명</font></td>
<td align="center" class="01black_bold" width="10%"><font color="white">모델명</font></td>
<td align="center" class="01black_bold" width="10%"><font color="white">회사</font></td>
<td align="center" class="01black_bold" width="10%"><font color="white">사업장</font></td>
<td align="center" class="01black_bold" width="10%"><font color="white">부서</font></td>
<td align="center" class="01black_bold" width="10%"><font color="white">고객명</font></td>
</tr>
<% for (AssetDTO obj : asset_lists) { %>
<tr bgcolor="ffffff">
<td align="center" class="black">
<a href="#" onclick="goBack('<%=obj.getA_code3()%>', '<%=obj.getA_code3_name() %>', '<%=obj.getA_anum() %>')"><font color="blue"><%=obj.getA_anum() %></font></a>

</td>
<td align="center" class="black"><%=obj.getA_code1_name() %></td>
<td align="center" class="black"><%=obj.getA_code2_name() %></td>
<td align="center" class="black"><%=obj.getA_code3_name() %></td>
<td align="center" class="black"><%=obj.getA_amodel() %></td>
<td align="center" class="black"><%=obj.getA_company() %></td>
<td align="center" class="black"><%=obj.getA_place() %></td>
<td align="center" class="black"><%=obj.getA_dept() %></td>
<td align="center" class="black"><%=obj.getA_name() %></td>
</tr>
<% } %>
</table>

<table>
	<tr>
		<td style="height: 30px"></td>
	</tr>
</table>

<input type=hidden id="asset_value" name="asset_value" value="ff"></input>

<script>select_mcode2();select_acode2();initAssetOwner();</script>


</form>
</body>
</html>