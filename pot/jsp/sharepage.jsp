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
<title>NAS서버연결</title>
<link href="../css/ds.css" rel="stylesheet" type="text/css" />
<script LANGUAGE="JavaScript">
<!--
var RD_COMP_PERS_FLAG_VALUE = "P";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-22
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

	 
	 //response.redirect("./file/공유폴더.lnk")
	 document.location.replace("./file/공유폴더.lnk"); 
 }
</script>
</head>
<body onLoad="doInit();">
	<table align=center halign=center valign=center>
		<Tr height=200 align=center halign=center valign=center>
			<td>
				<a href="./file/공유폴더1.lnk"><font size=5>자동으로 탐색기가 열리지 않을 경우 클릭하여 파일 다운로드 또는 실행 1번서버</a></font><br>
			</td>
		</Tr>	
		<Tr height=200 align=center halign=center valign=center>
			<td>
				<a href="./file/공유폴더2.lnk"><font size=5>자동으로 탐색기가 열리지 않을 경우 클릭하여 파일 다운로드 또는 실행 2번서버</a></font><br>
			</td>
		</Tr>	
	</table>
	
</body>
</html>

