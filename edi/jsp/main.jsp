<%
/*******************************************************************************
 * 시스템명 : 아트몰링 통합정보시스템  / 공통
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
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>
<%@ page import="ecom.vo.SessionInfo2,ecom.util.Util,java.util.Properties"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%
    /****************** 서브메뉴 셋팅 *****************/
    /****************** 상단 TAB을 권한에 맞게 보기 위해 *******/
    SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
    if (sessionInfo != null) {
        if (request.getParameter("submenu") != null && !"".equals(request.getParameter("submenu")))
            sessionInfo.setSUB_MENU(request.getParameter("submenu"));
    }

    String gb = sessionInfo.getGB(); //1. 협력사     2.브랜드  @ 택발행대행사
    String vencd = sessionInfo.getVEN_CD(); //협력사코드
%>

<html>
<head>
<title>아트몰링</title>
<meta http-equiv="pragma" content="no-cache">
<script>
	/******************************************************************************************/
	/* 자식창이 존재하는지 여부를 확인하기 위해. 후에 윈도우가 close될때 사용된다. --> (html/frame.html)	  */
	/******************************************************************************************/
	var isWindowAlive = true; 
	
	window.resizeTo(1024, 768);
</script>
</head>
<frameset rows="0, 90, *" border="0">
	<frame name="duplChkFrame" scrolling=no frameborder=0 marginwidth="0" marginheight="0" src='/edi/jsp/frame.jsp' noresize>
    <frame name="topFrame" scrolling="no" marginwidth="0" marginheight="0" target="leftFrame" src="/edi/jsp/top.jsp" noresize>  
<frameset id="subframeset" cols="180,*" border="0">       
		<frame name="leftFrame" scrolling="no" marginwidth="0" marginheight="0" target="contens" src="/edi/ecom003.ec?goTo=list&submenu=ECMN&strGb=<%=gb%>&strven=<%=vencd%>" noresize>    
		<frame name="mainFrame" scrolling="auto" marginwidth="0" marginheight="0" src="/edi/jsp/mainFrame.jsp" noresize>
</frameset>
</frameset>
<noframes>
    <body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
    <p>이 페이지를 보려면, 프레임을 볼 수 있는 브라우저가 필요합니다.</p>
    </body>
</noframes>
</html> 
