<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.obstacle.*"%>
<%@ page import="java.util.*"%>
<% 	

ObstacleDAO O_dao=new ObstacleDAO(); //DAO초기화
String O_rnum=request.getParameter("o_rnum");
ObstacleDTO O_Search = O_dao.getData(O_rnum);


String allAssetStr = "";
String [] assetNumberList = O_Search.getA_anum().split(",");

String [] assetNameList = O_Search.getO_a_name().split(",");
String [] assetCodeList = O_Search.getO_a_namecode().split(",");
String delimiter = ",";

List<ObstacleDTO> anumObsList = null;

String master=(String) session.getAttribute("Master");
String parentAddr = null;
if(master.equals("0")){
	parentAddr = "./D003.jsp?o_rnum=";
}
else {
	parentAddr = "./D003_admin.jsp?o_rnum=";
}

%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../common.css" />
</head>
<body onload="page_load()">
<table width="100%" align="center" border="0" cellspacing="1" bgcolor="000000">
<% 
for (int i=0; i<assetNumberList.length; i++) {
	if (!assetNumberList[i].equals("")) { 
	anumObsList = O_dao.getAnumObstacleList(assetNumberList[i], O_rnum); %>
	
<tr>
<td width="15%" align="center" valign="middle" bgcolor="ffffff" colspan="6">자산번호: <%= assetNumberList[i]%></td>
</tr>
	
<%  for (ObstacleDTO obj : anumObsList) { %>
<tr>
<td width="15%" align="center" valign="middle" bgcolor="ffffff"><a href="<%=parentAddr%><%=obj.getO_rnum()%>" target="_parent"><font color="blue"><%=obj.getO_rnum()%></font></a></td>
<td width="15%" align="center" valign="middle" bgcolor="ffffff"><%=obj.getO_state()%></td>
<td width="15%" align="center" valign="middle" bgcolor="ffffff"><%=obj.getO_title()%></td>
<% 
if (obj.getO_a_namecode() != null) {
String [] nameCodeList = obj.getO_a_namecode().split(","); %>
<td width="15%" align="center" valign="middle" bgcolor="ffffff">
<% for (int j=0; j<nameCodeList.length; j++) { %>
<%=nameCodeList[j] %><br>	
<% } %></td>
<% } 
else { %>
<td width="15%" align="center" valign="middle" bgcolor="ffffff"></td>
<% } %>
<% 
if (obj.getO_a_name() != null) { 
String [] nameList = obj.getO_a_name().split(","); %>
<td width="15%" align="center" valign="middle" bgcolor="ffffff">
<% for (int j=0; j<nameList.length; j++) { %>
<%=nameList[j] %><br>	
<% } %></td>
<% } 
else { %>
<td width="15%" align="center" valign="middle" bgcolor="ffffff"></td>
<% } %>
<td width="15%" align="center" valign="middle" bgcolor="ffffff"><%=obj.getO_occurrencetime()%></td>
</tr>
<% } 
  } 
}%>
</table>
</body>
</html>