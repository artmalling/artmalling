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
 *   GAUCE ��Ƽ�͸��� ȯ�� ���� ������ ���� �ϴ� ������ �̴�.
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
	
	// config ���� �� ������ �޴´�.
	function saveResult() {
	
		if(httpRequest.readyState == 4)	{
			//alert(httpRequest.responseText);
			if(httpRequest.status == 200) {	
				alert("������ �Ϸ� �Ǿ����ϴ�.");
			}
		} else {
		}
	}
			
	</script>
</head>
<body onload="OnLoad_window();">
<div id="pageTitle">���� ����͸� ����</div>
	<div class="description">
		���� ����͸� �ɼ��� �����մϴ�. <br>
		����͸� ȯ������ ��� - <script>document.write(homePath)</script>/<script>document.write(homeMode)</script>_conf/monitor-config.xml
	</div>

<div>
<fieldset>
	<form name="config">
	<table>
		<tr>
			<td align="right"><b>�α����� ��� </b><span class='help'>(?)
								<span class='helptext'>�α������� ��ġ�Դϴ�.<br> gauce-default.xml���� ������ �� �ֽ��ϴ�.<br></span>
							</span> :</td>
			<td> <script>document.write(logPath)</script>/</td>
		</tr>
		<tr bgcolor='#ebebeb'>
			<td align="right"><b>������ Refresh time </b><span class='help'>(?)
								<span class='helptext'>��ϴ��͸��� ��� �����Ͱ� ������Ʈ�Ǵ� �ð� ������ �����մϴ�.<br></span>
							</span> :</td>
			<td><input name="reloadTime" type="text" value=<%=session.getAttribute("reloadTime")%> style="vertical-align:middle;"> (1/1000 ��)</td>
		</tr>
		<tr>
			<td align="right"><b>���� ó�� �ð� ������ �� </b><span class='help'>(?)
								<span class='helptext'>Service Chart�� ������ ��(������)�� Service List�� ������ ���� �����մϴ�.<br></span>
							</span> :</td>
			<td><input name="chartSize" type="text" value=<%=session.getAttribute("chartSize")%> style="vertical-align:middle;"> (��)</td>
		</tr>
		<tr bgcolor='#ebebeb'>
			<td align="right"><b>Over time </b><span class='help'>(?)
								<span class='helptext'>Service List���� ������ �����͸� �����ϴ� ���� �ð��� �����մϴ�.<br></span>
							</span> :</td>
			<td><input name="overTime" type="text" value=<%=session.getAttribute("overTime")%> style="vertical-align:middle;"> (��)</td>
		</tr>
		<tr>
			<td></td>
			<td><input type="button" value="�� ��" onclick=save();></td>
		</tr>
	</table>
	</form>
</fieldset>
</div>

</body>
</html>