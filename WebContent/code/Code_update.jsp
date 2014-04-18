<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import ="kr.co.mycom.code.*"%>
<%@ page import="java.util.*"%>
    <%
    	request.setCharacterEncoding("EUC-KR");
    %>
<jsp:useBean id ="code" class="kr.co.mycom.code.CodeDTO"/>
<jsp:setProperty property="*" name="code"/>
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

String master = (String) session.getAttribute("Master");

if(master.equals("0")){
	%>
		<script type = "text/javascript">
		alert("관리자가 아니면 접근할 수 없습니다.");
		history.back();
		</script>
	<%
}

	CodeDAO dao = new CodeDAO();

	String check_code1 = code.getCboCode2().substring(6, 7);
	
	String send_cboCode = code.getL_code1();

	boolean check = false;
    if(check_code1.equals("1")){
    	check = dao.updateCode1(code);
    }else if(check_code1.equals("2")){
    	if(code.getCboCode1().equals("l_code")){
    		check = dao.updateCode1(code);
    	} else check = dao.updateCode2(code);
    }else check = dao.updateCode3(code);

	if (check) { // insert 성공
		%>
		<script type="text/javascript">
			alert("코드가 성공적으로 수정되었습니다. ");
			self.close();
			window.opener.location.href="../masterpage.jsp?bo_table=code&cboCode1=<%=code.getCboCode1()%>&cboCode2=<%=send_cboCode%>&cboCode3=<%=code.getCboCode3()%>";
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