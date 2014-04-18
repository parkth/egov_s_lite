<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page import="java.util.*,java.io.*,java.sql.*,java.text.*"%>
 <%@ page import="kr.co.mycom.asset.*"%>
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
AssetDAO dao=new AssetDAO();
 // 한글 깨지는 거 방지
 String filePath = new String(request.getParameter("filePath").getBytes("Cp1252"), "EUC-KR");
 String fileFullPath = new String(request.getParameter("fileFullPath").getBytes("Cp1252"), "EUC-KR");
 String anum= new String(request.getParameter("anum")); //어떤놈이냐
 StringTokenizer tokens = new StringTokenizer(fileFullPath, "|");
 
 
 File deleteFile=new File(filePath);
 if(deleteFile.exists()) deleteFile.delete();
 
 //updateCustomer_Obstacle
 String oneFilePath = null;
 String UpdateFilePath="";
 boolean result=false;
 while (tokens.hasMoreElements()) {
	 oneFilePath = tokens.nextToken();
	 if(oneFilePath.equals(filePath)){}
	 else{
		 UpdateFilePath+="|"+oneFilePath;
	 }
 }
 if(UpdateFilePath==null){
	 result=dao.update_Asset("",anum);
 } else {
	 result=dao.update_Asset(UpdateFilePath,anum);
 }
 
 if(result){
 	%>
	 <script type="text/javascript">
	 alert("삭제되었습니다. ");
	 location.href="./asset/C003_admin.jsp?anum="+'<%=anum%>';
	 </script>
	 <%
	 	} else { // 실패
	 %>
	 <script type="text/javascript">
	 alert("실패하였습니다. 관리자에게 문의하세요.");
	 history.back();
	 </script>
	 <%
	 	
	 	}
	 %>