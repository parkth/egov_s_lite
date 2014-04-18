<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page import="java.util.*,java.io.*,java.sql.*,java.text.*"%>
 <%@ page import="kr.co.mycom.obstacle.*"%>
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
 ObstacleDAO dao=new ObstacleDAO();
 // 한글 깨지는 거 방지
 String filePath = new String(request.getParameter("filePath").getBytes("Cp1252"), "EUC-KR"); //삭제할 파일경로
 String fileFullPath = new String(request.getParameter("fileFullPath").getBytes("Cp1252"), "EUC-KR"); //디비 저장된 풀경로
 String O_rnum= new String(request.getParameter("O_rnum")); //어떤놈이냐
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
	 result=dao.updateCustomer_Obstacle("",O_rnum);
 }
 else {
	 System.out.println("여러개");
	result=dao.updateCustomer_Obstacle(UpdateFilePath,O_rnum);
 }
 
 if(result){
 	%>
	 <script type="text/javascript">
	 alert("삭제되었습니다. ");
	 location.href="./obstacle/D003_admin.jsp?o_rnum="+'<%=O_rnum%>';
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