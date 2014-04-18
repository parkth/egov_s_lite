<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.asset.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.io.File"%>
    
<%
	String anum = request.getParameter("anum");
	AssetDAO dao = new AssetDAO();
	AssetDTO dto = dao.search_detail(anum);
	
	AssetDAO dao_history = new AssetDAO();
	List<AssetDTO> result_history = dao.getA_history(anum);
	
	String my_id = (String) session.getAttribute("ID");

	if(my_id == null || my_id.equals("null")){
		%>
			<script type = "text/javascript">
			alert("로그인하지 않으면 접근할 수 없습니다.");
			history.back();
			</script>
		<%
	}
%>
  
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  
<script type="text/javascript">

</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>S-LITE</title>
<link rel="stylesheet" type="text/css" href="../common.css" />
</head>
<body>
<form method="post">
<table width="95%" align="center">
<tr>
<td align="left">● 자산관리대장 ▶ 자산상세현황</td>
<td align="right">
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
<input type="text" id="a_anum" name="a_anum" value=<%=dto.getA_anum() %> style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">관리번호</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_gnum" name="a_gnum" value=<%=dto.getA_gnum() %> style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">회사</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_company" name="a_company" value=<%=dto.getA_company() %> style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산 구분</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_code1" name="a_code1" value=<%=dto.getA_code1() %> style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">사업장</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_place" name="a_place" value=<%=dto.getA_place() %> style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산 종류</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_code2" name="a_code2" value=<%=dto.getA_code2() %> style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">부서</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_dept" name="a_dept" value=<%=dto.getA_dept() %> style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">자산 유형</font></td>
<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_code3" name="a_code3" value=<%=dto.getA_code3() %> style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">위치</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_locate" name="a_locate" value=<%=dto.getA_locate() %> style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">품명</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_aname" name="a_aname" value=<%=dto.getA_aname() %> style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">이름</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_name" name="a_name" value=<%=dto.getA_name() %> style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">Model</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_amodel" name="a_amodel" value=<%=dto.getA_amodel() %> style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">ID</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_id" name="a_id" value=<%=dto.getA_id() %> style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">제조사</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_vendorname" name="a_vendorname" value=<%=dto.getA_vendorname() %> style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">취득일</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_getdate" name="a_getdate" value=<%=dto.getA_getdate() %> style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
<td rowspan="2" width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">SPEC.</font></td>
<td rowspan="2" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<textarea id="a_spec" name="a_spec" style="width: 98%; height: 50px; font-family: Gothic; font-size: 9pt" readonly="readonly">
<%=dto.getA_spec() %>
</textarea>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">비고</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
<input type="text" id="a_bigo" name="a_bigo" value='<%=dto.getA_bigo()%>' style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">첨부파일</font></td>
<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold" colspan="3">
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