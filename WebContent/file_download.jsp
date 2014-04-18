<%@ page language="java" contentType="application; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.*,java.io.*,java.sql.*,java.text.*"%>
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
 // 한글 깨지는 거 방지
 String fileName = new String(request.getParameter("fileName").getBytes("Cp1252"), "EUC-KR");
 String filePath = new String(request.getParameter("filePath").getBytes("Cp1252"), "EUC-KR");
 
 // 다운로드시 한글파일 이름 제대로 나오게 함.
 String fileNameOutput=new String(fileName.getBytes("euc-kr"),"8859_1");
 
 File file=new File(filePath);
 
 // getOutputStream() 문제 해결
 out.clear();
 out=pageContext.pushBody();
 
 byte b[]=new byte[(int)file.length()];
 response.setHeader("Content-Disposition","attachment;filename="+fileNameOutput);
 response.setHeader("Content-Length",String.valueOf(file.length()));
 
 if(file.isFile()){
  BufferedInputStream fin=new BufferedInputStream(new FileInputStream(file));
  BufferedOutputStream outs=new BufferedOutputStream(response.getOutputStream());
  int read=0;
  while((read=fin.read(b))!=-1){outs.write(b,0,read);}
  outs.close();
  fin.close();
 }
 %>