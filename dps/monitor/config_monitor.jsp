<!-- config_nonitor.jsp : Created on 2008. 7. 29.
 * 
 *   Copyright (c) 2000-2008 Shift Information & Communication Co.
 *   5F, Seongsu Venture town, 231-1, Seongsu2-Ga Seongdong-Gu, Seoul, Korea 133-826
 *   All rights reserved.
 *
 *   This software is the confidential and proprietary information of
 *   Shift Information & Communication Co. ("Confidential Information").
 *   You shall not disclose such Confidential Information and shall use 
 *   it only in accordance with the terms of the license agreement you 
 *   entered into with Shift Information & Communication.
-->

<!--
 *   GAUCE 모티터링의 환경 설정 파일을 수정 하는 페이지 이다.
 *   
-->

<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<!--script type="text/javascript" src="util.js"></script-->
<%@ include file="inc/session_check.jsp" %>
<%@ include file="inc/config_read.jsp" %>
<html>
<head>
	<meta http-equiv=Content-Type content="text/html; charset=euc-kr">
	<title>GAUCE Administration</title>
	<link rel="Stylesheet" href="data/style.css">
	<style>
		fieldset {
			padding-top : 5px;
		}
	</style>
	<script type="text/javascript" src="data/script.js"></script>
	<script type="text/javascript" src="data/util.js"></script>
	<script type="text/javascript">
	<!--
		function OnLoad_window() {
			InitTooltip();
		}
	//-->
	var logPath = "<%=session.getAttribute("logPath")%>";
	var homePath = "<%=session.getAttribute("homePath")%>";
	var homeMode = "<%=session.getAttribute("homeMode")%>";
	
	function save() {
		var chartSize = window.document.config.chartSize.value
		var reloadTime = window.document.config.reloadTime.value
		var overTime = window.document.config.overTime.value
		
		var param = "chartSize=" + chartSize 
							+ "&reloadTime=" + reloadTime 
							+ "&overTime=" + overTime;					
		sendRequest("inc/monitor_config_modify.jsp", param, saveResult, "POST");
	}
	
	// config 저장 후 응답을 받는다.
	function saveResult() {
	
		if(httpRequest.readyState == 4)	{
			//alert(httpRequest.responseText);
			if(httpRequest.status == 200) {	
				alert("변경이 완료 되었습니다.");
			}
		} else {
		}
	}
			
	</script>
</head>
<body onload="OnLoad_window();">
<div id="pageTitle">서버 모니터링 설정</div>
	<div class="description">
		서버 모니터링 옵션을 설정합니다. <br>
		모니터링 환경파일 경로 - <script>document.write(homePath)</script>/<script>document.write(homeMode)</script>_conf/monitor-config.xml
	</div>

<div>
<fieldset>
	<form name="config">
	<table>
		<tr>
			<td align="right"><b>로그파일 경로 </b><span class='help'>(?)
								<span class='helptext'>로그파일의 위치입니다.<br> gauce-default.xml에서 설정할 수 있습니다.<br></span>
							</span> :</td>
			<td> <script>document.write(logPath)</script>/</td>
		</tr>
		<tr bgcolor='#ebebeb'>
			<td align="right"><b>데이터 Refresh time </b><span class='help'>(?)
								<span class='helptext'>모니니터링의 모든 데이터가 업데이트되는 시간 간격을 설정합니다.<br></span>
							</span> :</td>
			<td><input name="reloadTime" type="text" value=<%=session.getAttribute("reloadTime")%> style="vertical-align:middle;"> (1/1000 초)</td>
		</tr>
		<tr>
			<td align="right"><b>서비스 처리 시간 데이터 수 </b><span class='help'>(?)
								<span class='helptext'>Service Chart의 데이터 양(가로축)과 Service List의 데이터 수를 설정합니다.<br></span>
							</span> :</td>
			<td><input name="chartSize" type="text" value=<%=session.getAttribute("chartSize")%> style="vertical-align:middle;"> (개)</td>
		</tr>
		<tr bgcolor='#ebebeb'>
			<td align="right"><b>Over time </b><span class='help'>(?)
								<span class='helptext'>Service List에서 보여줄 데이터를 선별하는 기준 시간을 설정합니다.<br></span>
							</span> :</td>
			<td><input name="overTime" type="text" value=<%=session.getAttribute("overTime")%> style="vertical-align:middle;"> (초)</td>
		</tr>
		<tr>
			<td></td>
			<td><input type="button" value="저 장" onclick=save();></td>
		</tr>
	</table>
	</form>
</fieldset>
</div>

</body>
</html>