<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.security.CheckSecurity"%>
<%@ page import="kr.co.mycom.asset.*"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration "%>
<%@page import="java.io.File "%>
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
	AssetDTO asset_dto = new AssetDTO();
	while (fileEnums.hasMoreElements()) {
			String fileElement = (String)fileEnums.nextElement();
			file = m.getFile(fileElement);
			if (file != null) {
				fileName = file.getName();
				filePath += "|"+file;
			}
		}
//업로드 검사	
if(fileName != null){
	if(fileName.endsWith(".doc") || fileName.endsWith(".hwp") || fileName.endsWith(".pdf") || 
			fileName.endsWith(".txt") || fileName.endsWith(".xls") 
			|| fileName.endsWith(".xlsx"))
	{
		asset_dto.setA_attachment(filePath);
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
	CheckSecurity checkSecurity = new CheckSecurity();
		
		
	
	asset_dto.setA_anum(m.getParameter("a_anum"));
	asset_dto.setA_company(m.getParameter("a_company"));
	asset_dto.setA_place(m.getParameter("a_place"));
	asset_dto.setA_dept(m.getParameter("a_dept"));

	String a_locate = m.getParameter("a_locate");
	asset_dto.setA_locate(checkSecurity.replaceTagToText(a_locate));

	asset_dto.setA_name(m.getParameter("a_name"));
	asset_dto.setA_id(m.getParameter("a_id"));
	asset_dto.setA_getdate(m.getParameter("a_getdate"));
	asset_dto.setA_adddate(m.getParameter("a_adddate"));

	String a_bigo = m.getParameter("a_bigo");
	asset_dto.setA_bigo(checkSecurity.replaceTagToText(a_bigo));

	asset_dto.setA_code1(m.getParameter("a_code1"));
	asset_dto.setA_code2(m.getParameter("a_code2"));
	asset_dto.setA_code3(m.getParameter("a_code3"));

	String a_aname = m.getParameter("a_aname");
	asset_dto.setA_aname(checkSecurity
			.replaceTagToText(a_aname));

	String a_amodel = m.getParameter("a_amodel");
	asset_dto.setA_amodel(checkSecurity
			.replaceTagToText(a_amodel));

	String a_vendorname = m.getParameter("a_vendorname");
	asset_dto.setA_vendorname(checkSecurity
			.replaceTagToText(a_vendorname));

	String a_spec = m.getParameter("a_spec");
	asset_dto.setA_spec(checkSecurity.replaceTagToText(a_spec));

	

	
	AssetDAO dao = new AssetDAO();
	boolean check = dao.insertAsset(asset_dto);
	if (check) { // insert 성공%>
		<script type="text/javascript">
		alert("자산이 성공적으로 등록되었습니다. ");
		
		if(confirm('추가등록하시겠습니까?')==true){
			location.href="./masterpage.jsp?bo_table=C001";
		}
		else {
			location.href = "./masterpage.jsp?bo_table=C002";
		}
		</script>
<%} else {%>
<script>
	alert("실패하였습니다. 관리자에게 문의하세요.");
	history.back();
</script>
<%}%>

</body>
</html> 
