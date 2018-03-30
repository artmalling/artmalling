<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<script language='javascript'>
	function insertIt() {
		document.form1.method="post";
		document.form1.submit();
	}
</script>
<body>
	<form name="form1" action="board.jstl?goTo=insert" encType="multipart/form-data">
		<table border="1">
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" size="20"></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="writer" size="8"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea cols="60" rows="10" name="contents"></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="file" name="file1">
				</td> 
			</tr>
			<tr>
				<td colspan="2">
					<input type="file" name="file2">
				</td> 
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" name="b1" value="등록" onclick="javascript:insertIt();">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
