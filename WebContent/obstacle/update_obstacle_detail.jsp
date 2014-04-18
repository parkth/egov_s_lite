<%@page import="javax.security.auth.Subject"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%> <!-- for Enumeration -->
<%@page import="kr.co.mycom.obstacle.*"%>
<%@page import="kr.co.mycom.security.CheckSecurity"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="kr.co.mycom.asset.AssetDAO"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>S-LITE</title>
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
    	String saveDir=application.getRealPath("/upload"); //실제 저장 폴더의 하위폴더...
        
        int maxSize= 1024*1024*100;//100M(파일첨부 최대용량)
        String encoding = "euc-kr";//인코딩 방식

         MultipartRequest m =
        new MultipartRequest(request, saveDir, maxSize, encoding, new DefaultFileRenamePolicy()); //new DefaultFileRenamePolicy() 없을시 파일 자동 덮어 쓰기가 된다. 
            
        String clickedButton = m.getParameter("o_detail_button");

        String occurTime = null;
        String reqTime = null;
        
 		Enumeration<String> fileEnums = m.getFileNames();
 		String filePath = m.getParameter("admin_file_path");
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
 		
 		if (filePath == null || filePath.equals(null) || filePath.equals("null")) filePath = "";
 		
 		String memberPhoneNumber = m.getParameter("o_detail_member_phone1")+"-"+m.getParameter("o_detail_member_phone2")+"-"+m.getParameter("o_detail_member_phone3");
 		
		
 		// 값을 넘겨주기 위해 셋팅
 		CheckSecurity checkSecurity = new CheckSecurity(); 
 		ObstacleDTO obsDto = new ObstacleDTO();
 		
 		obsDto.setO_rnum(m.getParameter("o_detail_rnum"));
 		
 		obsDto.setO_title(checkSecurity.replaceTagToText(m.getParameter("o_detail_title")));
 		obsDto.setO_code1(m.getParameter("select_o_detail_code1"));
 		obsDto.setO_code2(m.getParameter("select_o_detail_code2"));
 		
 		obsDto.setO_ograde(m.getParameter("select_o_detail_grade"));	
 		obsDto.setO_opath(m.getParameter("o_detail_request_path"));
 		
 		
 		// 제품명 여러개 처리
 		
 		
 		String[] assetArr = m.getParameter("o_detail_asset").split(",");
 		
 		String assetNumberStr = "";
 		String assetNameStr = "";
 		String assetCodeStr = "";
 		String delimiter = ",";
 		
 		AssetDAO aDao = new AssetDAO();
 		
 		if (!assetArr[0].equals("/")) {
 		 	for (int i=0; i<assetArr.length; i++) {
 		 		String[] oneAssetValueList = assetArr[i].split("/");
 		 		if (assetNumberStr.equals("")) delimiter = "";
 		 		else delimiter = ",";
 		 		
 		 		if (oneAssetValueList.length > 1) {
 		 			assetNameStr += delimiter + oneAssetValueList[0];
 		 			assetNumberStr += delimiter + oneAssetValueList[1];
 		 			assetCodeStr += delimiter + aDao.getAssetCode(oneAssetValueList[1]);
 		 		}
 		 	}
 		}
 		
 		obsDto.setO_a_name(assetNameStr);
 		obsDto.setA_anum(assetNumberStr);
 		obsDto.setO_a_namecode(assetCodeStr);
 		
 		obsDto.setO_vendorname(checkSecurity.replaceTagToText(m.getParameter("o_detail_vendor")));

 		obsDto.setM_code1(m.getParameter("select_o_detail_member_company"));
 		obsDto.setM_code3(m.getParameter("select_o_detail_dept"));
 		
 		if (m.getParameter("select_o_detail_a_id").equals("미지정")) {
 			obsDto.setA_id("");
 	 		obsDto.setA_name("");
 	 		obsDto.setA_linenum("");
 		}
 		else {
 			obsDto.setA_id(m.getParameter("select_o_detail_a_id"));
 	 		obsDto.setA_name(m.getParameter("select_o_detail_a_name"));
 	 		obsDto.setA_linenum(m.getParameter("o_detail_member_phone1_in_charge")+"-"+m.getParameter("o_detail_member_phone2_in_charge")+"-"+m.getParameter("o_detail_member_phone3_in_charge"));	
 		}
 		
 		obsDto.setMember_name(m.getParameter("o_detail_member_name"));
 		obsDto.setO_linenum(memberPhoneNumber);
 		obsDto.setO_detail(checkSecurity.replaceTagToText(m.getParameter("o_detail_detail")));
 		
 		obsDto.setO_engineer(m.getParameter("o_detail_engineer"));
 		obsDto.setO_reason(checkSecurity.replaceTagToText(m.getParameter("o_detail_reason")));
 		obsDto.setO_resolvedetail(checkSecurity.replaceTagToText(m.getParameter("o_detail_resolvedetail")));
 		obsDto.setO_requestdetail(checkSecurity.replaceTagToText(m.getParameter("o_detail_requestdetail")));
 		obsDto.setO_attachment_engineer(filePath);	

 		occurTime = m.getParameter("occur_year_detail");
        occurTime += "-"+m.getParameter("occur_month_detail");
        occurTime += "-"+m.getParameter("occur_day_detail");
        occurTime += " "+m.getParameter("occur_hour_detail");
        occurTime += ":"+m.getParameter("occur_minute_detail");
        occurTime += ":00";
        
        // 내용저장, 접수, 해결, 종료 버튼을 눌렀을 때 원하는 시간 지정.
        reqTime = m.getParameter("req_year_detail");
        reqTime += "-"+m.getParameter("req_month_detail");
        reqTime += "-"+m.getParameter("req_day_detail");
        reqTime += " "+m.getParameter("req_hour_detail");
        reqTime += ":"+m.getParameter("req_minute_detail");
        reqTime += ":00";
        		
 		obsDto.setO_occurrencetime(occurTime);	
 
 		ObstacleDAO obsDao = new ObstacleDAO();
 		ObstacleDTO timeDto = obsDao.getTime(obsDto.getO_rnum());	
 		
		// 접수하지 않은 상태에서 해결, 종료를 선택하였을 경우 또는,
		// 해결하지 않은 상태에서 종료를 선택하였을 경우 false
 		boolean isValid = true;
 		
 		 if (clickedButton.equals("0")) { // 내용저장
 			obsDto.setO_state("요청");
         }
         else if (clickedButton.equals("1")) { // 접수
        	obsDto.setO_state("해결중");
         	obsDto.setO_solvingtime(reqTime);
         }
 		 else if (clickedButton.equals("2")) { // 해결
 			if (timeDto.getO_solvingtime() == null) isValid = false;
 			obsDto.setO_state("해결");
 		 	obsDto.setO_solvedtime(reqTime);
         }
 		 else if (clickedButton.equals("3")) { // 종료
 			if (timeDto.getO_solvedtime() == null) isValid = false;
 			obsDto.setO_state("종료");
 		 	obsDto.setO_finishtime(reqTime);
 		 }
 		 
 		 boolean updateResult = false;

 		 if (isValid) {
 	 		updateResult = obsDao.updateObstacle(obsDto);
 		 }	 

 		if (updateResult) { %>
 		<script>
 			alert("장애상세현황 변경을 성공하였습니다.");
 			self.close();
 			window.opener.D002.submit();
 		</script>
 		<% }
 		else { %>
 		<script>
 			alert("장애상세현황 변경을 실패하였습니다. \n접수, 해결, 종료의 순서로 선택하였는지 확인 바랍니다.");
 			history.back();
 		</script>
        <% } %>
</body>
</html> 


