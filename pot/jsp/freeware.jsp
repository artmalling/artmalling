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
<title>필수유틸</title>
<link href="../css/ds.css" rel="stylesheet" type="text/css" />


</head>
<body>

	<table width=500 height=300 align=center>
		<tr>
			<td><font size=5><a href=./file/adobe_reader11.exe>PDF리더(어도비리더)</a></td><td><- 다운로드후 오른쪽클릭 관리자권한으로 실행</font></td>
		</tr>
		<tr>
			<td><font size=5><a href=./file/BANDIZIP-SETUP.EXE>반디집(압축프로그램)</a></font></td>
		</tr>
		<tr>
			<td><font size=5><a href=./file/V3_9.0.zip>V3백신</a></font></td>
		</tr>
		<tr>
			<td><font size=5><a href=./file/xpopup.exe>빨전(xpopup)</a></font></td>
		</tr>
		<tr>
			<td><font size=5>캐드뷰어<a href=./file/SetupDWGTrueView2013_32bit.exe>     32bit     </a><a href=./file/SetupDWGTrueView2013_64bit.exe>     64bit     </a></font></td>
		</tr>
		<tr>
			<td><font size=5><a href=./file/duzon.zip>더존</a></font></td>
		</tr>
	</table>

</body>
</html>

