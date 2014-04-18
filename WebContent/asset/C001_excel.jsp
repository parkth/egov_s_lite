<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
  
<script language="javascript">	
	function check() {
			if (document.C001_excel_form.file1.value == "" || document.C001_excel_form.file1.value == null ) { 
				alert("첨부파일을 추가하세요!");
				return false;
			} else if (!checkFileType(document.C001_excel_form.file1.value)) {
				alert("주어진 양식 파일을 수정하여 업로드 해 주세요.");
				return false;
			}
			return true;
	}
	
	function checkFileType(filePath) {
		var fileLen = filePath.length;
		var fileFormat = filePath.substring(fileLen - 4);
		fileFormatfileFormat = fileFormat.toLowerCase();

		if (fileFormat == ".xls") {
			return true;
		} else {
			return false;
		}
	}
</script>
<title>S-LITE</title>
</head>
<body>
<form name="C001_excel_form" method="post" action=".\masterpage.jsp?bo_table=C001_excel_view"  enctype="multipart/form-data" onsubmit="return check()">
<table width="95%" align="center">
<tr>
<td align="left">● 자산관리대장 ▶ 자산등록(Excel)</td>
</tr>
</table>
<table>
		<tr>
			<td style="height: 40px"></td>
		</tr>
</table>
<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
	<tr>
		<td width="30%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">Excel 파일 선택</font></td>
		<td width="50%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><input type="file" name="file1" size="50" align="absmiddle" /></td>
		<td width="20%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC">
		<input type="submit" value="등록" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt" ></input></td>
	</tr>
	
</table>
<br><br>
<table width="95%" align="center" border="0" cellspacing="1" bgcolor="FFFFFF">
	<td><a href="asset/input_form.xls"><img src="images/btn_excel.png" alt="" border="0" style="cursor:pointer;"></a></td>
	
</table>
</form>
</body>
</html>