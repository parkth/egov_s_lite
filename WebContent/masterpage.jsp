<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% 
	String my_id = (String) session.getAttribute("ID");
 	String my_name = (String) session.getAttribute("NAME");
 	String master= (String) session.getAttribute("Master");
 	
 	if(my_id == null || my_id.equals("null")){
 		%>
 			<script type = "text/javascript"> 
 			alert("로그인하지 않으면 접근할 수 없습니다.");
 			location.href="index.jsp"
 			</script>
 		<%
 	}
 	
 %>
<%
	// 한글 깨지는 것 방지
	request.setCharacterEncoding("euc-kr");

	String bo_table = request.getParameter("bo_table");
	
	request.setAttribute("bo_table", bo_table);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>S-LITE</title>
<link rel="stylesheet" type="text/css" href="common.css" />
</head>
<body>
	<table border='0' width="100%"  height="100%" align="center">
		<tr>
			<td colspan='2' height='120'><jsp:include page="top.jsp"
					flush="true"></jsp:include></td>
		</tr>
		<tr>
			<td width='12%' height='400' valign="top">
				<jsp:include page="menu.jsp" flush="true" />
			</td>
			<td width='88%' valign="top" align="center">
				<c:if test="${bo_table == null }">
					<jsp:include page=".\csr\E002.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'C001' }">
					<jsp:include page=".\asset\C001.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'C001_excel'  }">
					<jsp:include page=".\asset\C001_excel.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'C001_excel_view'  }">
					<jsp:include page=".\excel\excel_file_view.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'C001_excel_addvalue'  }">
					<jsp:include page=".\excel\excel_file_addvalue.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'C001_insert'  }">
					<jsp:include page=".\asset\C001_insert.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'C002'  }">
					<jsp:include page=".\asset\C002.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'C003'  }">
					<jsp:include page=".\asset\C003.jsp" flush="true"></jsp:include>
				</c:if>
				
				<c:if test="${bo_table == 'D001' }">
				<%if(master.equals("0") == false){ %>
					<jsp:include page=".\obstacle\D001.jsp" flush="true"></jsp:include>
				<% } else { %>
					<jsp:include page=".\obstacle\D001_customer.jsp" flush="true"></jsp:include>
				<% } %>
				</c:if>
						
				<c:if test="${bo_table == 'D001_add'  }">
					<jsp:include page=".\obstacle\add_obstacle.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'D001_add_user'  }">
					<jsp:include page=".\obstacle\add_user_obstacle.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'D002' }">
					<jsp:include page=".\obstacle\D002.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'D003' }">
					<jsp:include page=".\obstacle\D003.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'D004' }">
					<jsp:include page=".\obstacle\D004.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'D005' }">
					<jsp:include page=".\obstacle\D005.jsp" flush="true"></jsp:include>
				</c:if>
				
				<c:if test="${bo_table == 'E001'  }">
					<jsp:include page=".\csr\E001.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'E001_add_user'  }">
					<jsp:include page=".\csr\add_user_csr.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'E002' }">
					<jsp:include page=".\csr\E002.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'E003' }">
					<jsp:include page=".\csr\E003.jsp" flush="true"></jsp:include>
				</c:if>
				
				
				<!-- 회원 파트  -->
				<c:if test="${bo_table == 'joinform' }">
					<jsp:include page=".\member\Joinform.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'join' }">
					<jsp:include page=".\member\Join.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'updateform' }">
					<jsp:include page=".\member\Updateform.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'update' }">
					<jsp:include page=".\member\Update.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'member_admin' }">
					<jsp:include page=".\member\member_admin.jsp" flush="true"></jsp:include>
				</c:if>
				<c:if test="${bo_table == 'logout' }">
					<jsp:include page=".\logout.jsp" flush="true"></jsp:include>
				</c:if>
				
				<!-- 코드 파트  -->
				<c:if test="${bo_table == 'code' }">
					<jsp:include page=".\code\Code_Management.jsp" flush="true"></jsp:include>
				</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="2" height='80'><jsp:include page="bot.jsp"
					flush="true" /></td>
		</tr>
	</table>
</body>
</html>