<%
/*******************************************************************************
 * 시스템명 : 시스템관리 > 로그관리> 실시간로그인현황
 * 작 성 일 : 2010.06.23
 * 작 성 자 : Hseon
 * 수 정 자 : 
 * 파 일 명 : tcom3040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 강제로그아웃
 * 이    력 : 
 ******************************************************************************/
%>
<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.*"%>
<%@ page import="common.util.*"%>
<%@ page import="kr.fujitsu.ffw.base.Configure"%>
<%@ page import="kr.fujitsu.ffw.base.BaseProperty"%> 
<%@ page import="common.dao.CCom900DAO"%>
<!--*************************************************************************-->
<!--*************************************************************************-->
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script> 

<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<body>
<%
	try{
			String strUserId = request.getParameter("strUserId"); 

			CCom900DAO dao = new CCom900DAO(); 
			dao.updLogout(strUserId);
			
	}catch (Exception e) {
%>
<script language=javascript> 
	showMessage(STOPSIGN, OK, "USER-1000", "강제로그아웃시 문제가 발생하였습니다.");
</script>	
<%
	} finally {  
%>
<script language=javascript> 
	showMessage(INFORMATION, OK, "USER-1000", "강제로그아웃 하였습니다.");
	parent.btn_Search();
</script>	
<%
	} 
%>
