<%@page import="javax.security.auth.Subject"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%> <!-- for Enumeration -->
<%@page import="kr.co.mycom.obstacle.*"%>
<%@page import="kr.co.mycom.member.MemberDAO"%>
<%@page import="kr.co.mycom.member.MemberDTO"%>
<%@page import="kr.co.mycom.security.CheckSecurity"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
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
	    long time = System.currentTimeMillis(); 
	    SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
	    String solvingtime = dayTime.format(new Date(time)); //시간까지 모두 출력
    	
    	String saveDir=application.getRealPath("/upload"); //실제 저장 폴더의 하위폴더...
        //"C:/Users/LDCC/workspace/S-LITE v0.1/WebContent/upload"; // 절대경로
        //System.out.println("saveDIR: "+saveDir);
        
        int maxSize= 1024*1024*100;//100M(파일첨부 최대용량)
        String encoding = "euc-kr";//인코딩 방식

         MultipartRequest m =
        new MultipartRequest(request, saveDir, maxSize, encoding, new DefaultFileRenamePolicy()); //new DefaultFileRenamePolicy() 없을시 파일 자동 덮어 쓰기가 된다. 
        
        // input text 아무것도 안 썼을 경우 m.getParameter("o_title").equals("")

        String memberPhoneNumber = m.getParameter("o_member_phone1")+"-"+m.getParameter("o_member_phone2")+"-"+m.getParameter("o_member_phone3");

        String requestTime = m.getParameter("req_year");
        requestTime += "-"+m.getParameter("req_month");
        requestTime += "-"+m.getParameter("req_day");
        requestTime += " "+m.getParameter("req_hour");
        requestTime += ":"+m.getParameter("req_minute");
        requestTime += ":00";
        
        String occurTime = m.getParameter("occur_year");
        occurTime += "-"+m.getParameter("occur_month");
        occurTime += "-"+m.getParameter("occur_day");
        occurTime += " "+m.getParameter("occur_hour");
        occurTime += ":"+m.getParameter("occur_minute");
        occurTime += ":00";
        
 		Enumeration<String> fileEnums = m.getFileNames();
 		String filePath = "";
 		File file = null;
 		String fileName = null;

 		while (fileEnums.hasMoreElements()) {
 			String fileElement = (String)fileEnums.nextElement();
 			file = m.getFile(fileElement);
 			if (file != null) {
 				fileName = file.getName();
 				filePath += "|"+file;
 			}
 		}

	
		
 		// 값을 넘겨주기 위해 셋팅
 		ObstacleDTO obsDto = new ObstacleDTO();
 		MemberDAO mDAO=new MemberDAO();
 		CheckSecurity checkSecurity = new CheckSecurity(); 
 		MemberDTO mDTO=mDAO.searchMember(my_id);
 		
 		obsDto.setO_title(checkSecurity.replaceTagToText(m.getParameter("o_title")));
 		obsDto.setO_code1(m.getParameter("select_o_code1"));
 		obsDto.setO_code2(m.getParameter("select_o_code2"));
 		obsDto.setO_a_name(m.getParameter("o_asset"));
 		obsDto.setO_ograde(m.getParameter("o_grade"));
 		obsDto.setO_opath(m.getParameter("o_request_path"));
 		obsDto.setO_vendorname(checkSecurity.replaceTagToText(m.getParameter("o_vendor")));
 		obsDto.setO_occurrencetime(occurTime);
 		obsDto.setO_requesttime(requestTime);
 		obsDto.setO_solvingtime(solvingtime);
 		obsDto.setM_code1(m.getParameter("select_o_member_company"));	
 		obsDto.setM_code2(m.getParameter("select_o_place"));
 		obsDto.setM_code3(m.getParameter("select_o_dept"));
 		obsDto.setMember_name(m.getParameter("o_member_name"));
 		obsDto.setO_id(m.getParameter("my_id"));
 		obsDto.setO_linenum(memberPhoneNumber);
 		obsDto.setO_detail(checkSecurity.replaceTagToText(m.getParameter("o_detail")));
 		//업로드 검사
if(fileName != null){
	if(fileName.endsWith(".doc") || fileName.endsWith(".hwp") || fileName.endsWith(".pdf") || 
			fileName.endsWith(".txt") || fileName.endsWith(".xls") 
			|| fileName.endsWith(".xlsx"))
	{
 		obsDto.setO_attachment(filePath);
	}
	else
	{
		%>
        <script>
 			alert("지정된 문서 양식을 올려주세요.");
 			history.back();
 		</script>
 		<%
	}
}
 		obsDto.setO_engineer(mDTO.getM_name());

 		ObstacleDAO obsDao = new ObstacleDAO();
 		boolean insertResult = obsDao.insertObstacle(obsDto);
 		if (insertResult) { %>
 		<script>
 			alert("장애등록을 성공하였습니다.");

 			if(confirm('추가등록하시겠습니까?')==true){
 			    location.href ="./masterpage.jsp?bo_table=D002";
 		 	}
 			else{
 			    location.href ="./masterpage.jsp";
 			}
 		</script>
 		<% }
 		else { %>
 		<script>
 			alert("장애등록을 실패하였습니다.");
 			history.back();
 		</script>
        <%}%>
</body>
</html> 


