<%
/*******************************************************************************
  * 시스템명 : 메인 > 기초화면
  * 작 성 일 : 2010.04.28
  * 작 성 자 : 엄준석 
  * 수 정 자 :
  * 파 일 명 : portal.jsp
  * 버    전 : 1.0
  * 개    요 : 메인화면을 출력하기 위한 기초화면 이다.
  * 이    력 :
  *****************************************************************************/
%>
<%@ page language="java" contentType="text/html;charset=utf-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<script language="JavaScript"> 

	var frame = window.external.GetFrame(window);
/**
  * onStart()
  * 작 성 자 : 엄준석
  * 작 성 일 : 2010-04-28
  * 개    요  : 해당 페이지 LOAD 시  
  * return값 : void
*/
function onStart(){

	/* 메인 페이지 초기 호출 */
	var programUrl = "";
	var programID = "main";
	var programNM = "메인화면";
	var button = "";
	//var url = "/pot/"+programUrl+"?goTo="+programID+"&programNM="+encodeURIComponent(programNM)+"&button="+button; 
	var url = "/pot/tcom001.tc?goTo=mainFrame"; 

	// MDI 윈도우 생성/활성화
	frame.CreateFrame("mainPage", url, programNM, 0, 0, "100%", "100%", "sunken", "maximize", "maximize", true);
	frame.Provider("/" + "mainPage").FrameModify("sysmenu",0);

	/* 메인 페이지 초기 호출 */
/*    var programUrl = "tcom101.tc";
    var programID = "list";
    var programNM = "메인화면";
    var button = "10000000";
    var url = "/pot/jsp/mainFrame.jsp"; 

    // MDI 윈도우 생성/활성화
	frame.Provider('../').OuterWindow.parent.mainFrame.fn_CreateWin(programID, programNM, url);
*/
}


</script>
</head>

<body onload="onStart();" class="body_main" scroll="no">


</body>
</html>
