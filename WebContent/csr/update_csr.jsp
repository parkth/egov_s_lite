<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="javax.security.auth.Subject"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration "%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="kr.co.mycom.csr.CSRDAO"%>
<%@ page import="kr.co.mycom.csr.CSRDTO"%>
<%@page import="kr.co.mycom.security.CheckSecurity"%>
<%
	request.setCharacterEncoding("EUC-KR");
%>
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
	String saveDir=application.getRealPath("/upload"); //실제 저장 폴더의 하위폴더...
	
	int maxSize= 1024*1024*100;//100M(파일첨부 최대용량)
	String encoding = "euc-kr";//인코딩 방식
	
	MultipartRequest m =
	new MultipartRequest(request, saveDir, maxSize, encoding, new DefaultFileRenamePolicy()); //new DefaultFileRenamePolicy() 없을시 파일 자동 덮어 쓰기가 된다. 

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
	
	
	CheckSecurity checkSecurity = new CheckSecurity();
	CSRDTO csr_dto = new CSRDTO();
	CSRDAO csr_dao = new CSRDAO();
	boolean check = false;
	if(m.getParameter("csr_state").equals("0")) {
		
		csr_dto.setCSR_previewer(checkSecurity.replaceTagToText(m.getParameter("c_previewer")));
		
		String solvingTime = m.getParameter("solving_year");
		solvingTime += "-"+m.getParameter("solving_month");
		solvingTime += "-"+m.getParameter("solving_day");
		solvingTime += " "+m.getParameter("solving_hour");
		solvingTime += ":"+m.getParameter("solving_minute");
		solvingTime += ":00";
			
		csr_dto.setCSR_solvingtime(solvingTime);
		
		String estimateTime = m.getParameter("estimate_year");
		estimateTime += "-"+m.getParameter("estimate_month");
		estimateTime += "-"+m.getParameter("estimate_day");
		estimateTime += " "+m.getParameter("estimate_hour");
		estimateTime += ":"+m.getParameter("estimate_minute");
		estimateTime += ":00";
			
		csr_dto.setCSR_estimate_solvetime(estimateTime);
		
		String c_preview_result = m.getParameter("c_preview_result");
		csr_dto.setCSR_preview_result(checkSecurity.replaceTagToText(c_preview_result));
		
		csr_dto.setCSR_dependentsystem_flag(m.getParameter("c_dependentsystem_flag"));
		
		String c_dependentsystem = m.getParameter("c_dependentsystem");
		csr_dto.setCSR_dependentsystem(checkSecurity.replaceTagToText(c_dependentsystem));
		
		csr_dto.setCSR_rnum(m.getParameter("csr_rnum"));
			
		check = csr_dao.receiveCSR(csr_dto);
	} else if(m.getParameter("csr_state").equals("1")) {
		
		String solvedTime = m.getParameter("solved_year");
		solvedTime += "-"+m.getParameter("solved_month");
		solvedTime += "-"+m.getParameter("solved_day");
		solvedTime += " "+m.getParameter("solved_hour");
		solvedTime += ":"+m.getParameter("solved_minute");
		solvedTime += ":00";
		
		csr_dto.setCSR_solvedtime(solvedTime);

		String csr_reason = m.getParameter("csr_reason");
		csr_dto.setCSR_reason(checkSecurity.replaceTagToText(csr_reason));
		
		String csr_processing_contents = m.getParameter("csr_processing_contents");
		csr_dto.setCSR_processing_contents(checkSecurity.replaceTagToText(csr_processing_contents));
		
		csr_dto.setCSR_estimate_md(m.getParameter("csr_estimate_md"));
		csr_dto.setCSR_complete_md(m.getParameter("csr_complete_md"));
		csr_dto.setCSR_rnum(m.getParameter("csr_rnum"));
		
		if(fileName != null){
			if(fileName.endsWith(".doc") || fileName.endsWith(".hwp") || fileName.endsWith(".pdf") || 
					fileName.endsWith(".txt") || fileName.endsWith(".xls") 
					|| fileName.endsWith(".xlsx"))
			{
		 		csr_dto.setCsr_attachment_engineer(filePath);
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
		
		
		check = csr_dao.SolveCSR(csr_dto);

	} else if(m.getParameter("csr_state").equals("2")) {

		String finishTime = m.getParameter("finish_year");
		finishTime += "-"+m.getParameter("finish_month");
		finishTime += "-"+m.getParameter("finish_day");
		finishTime += " "+m.getParameter("finish_hour");
		finishTime += ":"+m.getParameter("finish_minute");
		finishTime += ":00";
		
		String csr_client_comment = m.getParameter("csr_client_comment");
		String csr_rnum = m.getParameter("csr_rnum");
		check = csr_dao.finishCSR(csr_rnum, checkSecurity.replaceTagToText(csr_client_comment), finishTime);
	}
	if (check) { // insert 성공
	%>
		<script type="text/javascript">
		alert("CSR이 성공적으로 갱신되었습니다. ");
		window.opener.E002.submit();
		self.close();
		</script>
	<% } else { // 실패%>
		<script type="text/javascript">
		alert("CSR갱신을 실패하였습니다. ");
		self.close();
		</script>	
	<%}%>