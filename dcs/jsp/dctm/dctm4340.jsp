<% request.setCharacterEncoding("utf-8"); %>
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,
				 													   kr.fujitsu.ffw.base.BaseProperty,
																	   kr.fujitsu.ffw.util.*"%>
<%@ page import="java.util.Properties"%>

<%
	String SSOFlag   = BaseProperty.get("SSO.flag");
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="../css/ds.css" rel="stylesheet" type="text/css" />


</head>
<body>
	<table width=500 height=300 align=center>
		<tr>
			<td><a href=http://192.168.122.102:8088/pot/jsp/file/email_distinct/email_list.csv>이메일리스트 다운로드</a></td>
		</tr>
	</table>

</body>
</html>
 
