<%
/*******************************************************************************
 * 시스템명 : 한국후지쯔 통합정보시스템  / 공통
 * 작 성 일 : 2010.12.12 
 * 작 성 자 : 정지인
 * 수 정 자 :
 * 파 일 명 : main.jsp
 * 버    전 : 1.0
 * 개    요 : 화면분기
 * 이    력 : 
 *****************************************************************************/
%>
<%@ page contentType="text/html;charset=utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
<title>형지 아트몰링  통합정보시스템</title>
<meta http-equiv="pragma" content="no-cache">
<script language="javascript"  src="/pot/js/common.js" type="text/javascript"></script>
<script>
/******************************************************************************************/
/* 자식창이 존재하는지 여부를 확인하기 위해. 후에 윈도우가 close될때 사용된다. --> (html/frame.html)	  */
/******************************************************************************************/
var isWindowAlive = true;
</script>
</head>
<frameset rows="0, 90, *" border="0">
	<frame name="duplChkFrame" scrolling=no frameborder=0 marginwidth="0" marginheight="0" src='/pot/jsp/frame.jsp' noresize>
	<frame name="topFrame" scrolling="no" marginwidth="0" marginheight="0" target="leftFrame" src="/pot/jsp/top.jsp" noresize>
	<frameset id="subframeset" cols="250,*" border="0">
		<frame name="leftFrame" scrolling="auto" marginwidth="0" marginheight="0" target="contens" src="/pot/tcom003.tc?goTo=list">    
		<frame name="mainFrame" scrolling="auto" marginwidth="0" marginheight="0" src="/pot/jsp/mdiFrame.jsp">
	</frameset>
</frameset>
<noframes>
	<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
		<p>이 페이지를 보려면, 프레임을 볼 수 있는 브라우저가 필요합니다.</p>
	</body>
</noframes>
</html>
