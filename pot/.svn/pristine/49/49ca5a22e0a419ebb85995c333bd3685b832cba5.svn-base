<!-- config_innoxync_modify.jsp : Created on 2008. 7. 29.
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
 *   GAUCE Server의 환경 설정 파일을 수정 하는 페이지 이다.
 *   GAUCE 설치 폴더에 존재하는 유효한 환경설정 파일 리스트를 보여주고
 *   이에 대한 정보를 보여준다.
-->

<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
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
	<script type="text/javascript" src="data/config_ui.js"></script>
	<script type="text/javascript">
	<!--
		function OnLoad_window() {
			InitTooltip();
			
			galobal_table();
			domainList_Lode();
		}
	//-->
	var homePath = "<%=session.getAttribute("homePath")%>";
	var homeMode = "<%=session.getAttribute("homeMode")%>";

	// 환경 설정 파일 리스트를 불러온다.
	function domainList_Lode() {
		var param = "";
		sendRequest("inc/gauce_config_list.jsp", param, listLoadResult, "POST");
	}
	
	// 환경 설정 파일 리스트 파싱
	function listLoadResult() {
		var domain_select = "<select id='domain_list' onchange='javascript:domain_Change();'>"
							+ "<option value=''>------선택------</option>";
		if(httpRequest.readyState == 4)	{
			if(httpRequest.status == 200) {	
				//alert(httpRequest.responseText);
				var xmlDoc		= httpRequest.responseXML;
				var dataNodes	= xmlDoc.getElementsByTagName("domains");	//<domains>
				var dataNode = dataNodes[0].getElementsByTagName("domain");
				
				for(var i = 0; i < dataNode.length; i++) {
					var name = dataNode[i].firstChild.nodeValue;
					domain_select += "<option value='" + name + "'>" + homeMode + "-" + name + ".xml </option>";
				}
				domain_select += "</select>";
				domain_value.innerHTML = domain_select;
			} else {
				alert(httpRequest.responseText);
			}
		} else {//do notting..
		}
	}
	
	// 환경 설정 파일 정보를 불러온다.
	function domainData_Lode(name) {
		if(name != null && name != "") {
			document.config.domain_name.value = name;
			var param = "domainName=" + name;
			
			sendRequest("inc/gauce_config_load.jsp", param, dataLoadResult, "POST");
		}
	}
	
	// 환경 설정 파일 정보 파싱
	function dataLoadResult() {
	
		if(httpRequest.readyState == 4)	{
			if(httpRequest.status == 200) {	
				//alert(httpRequest.responseText);
				
				var xmlDoc = httpRequest.responseXML;
				
				var dataNode	= xmlDoc.getElementsByTagName("global");
				nCompressed		= dataNode[0].getAttribute("compressed");
				nFragment		= dataNode[0].getAttribute("fragment");
				
				dataNode		= xmlDoc.getElementsByTagName("charset");
				nDefault		= dataNode[0].getAttribute("default");
				nGet			= dataNode[0].getAttribute("get");
				nPost			= dataNode[0].getAttribute("post");
				
				dataNode	= xmlDoc.getElementsByTagName("col-def");
				nInteger	= dataNode[0].getAttribute("integer");
				nDecimal	= dataNode[0].getAttribute("decimal");
				nString		= dataNode[0].getAttribute("string");
				nRound		= dataNode[0].getAttribute("round");
				
				dataNode			= xmlDoc.getElementsByTagName("crypto");
				if(dataNode.length > 0) {
					nSpi = dataNode[0].getAttribute("spi");
					
					galobal_table();
					
					dataNode = dataNode[0].getElementsByTagName("param");
					nParamCount = dataNode.length;
					
					for(var i = 0; i < nParamCount; i++) {
						nParamName	= dataNode[i].getAttribute("name");
						nParamValue	= dataNode[i].getAttribute("value");
						param_Add();	
					}
				} else {
					galobal_table();
				}
				dataNode = xmlDoc.getElementsByTagName("monitor");
				if(dataNode.length > 0) {
					nLog = dataNode[0].getAttribute("log");
					nLogPath = dataNode[0].getAttribute("path");
				}
				
				dataNode = xmlDoc.getElementsByTagName("request");
				if(dataNode.length > 0) {
					nRegClass	= dataNode[0].getAttribute("className");
					//nRegClass_true = nRegClass;
					
					var pack = "";
					if(homeMode == "gauce")
						pack = "com.gauce.filter.";
					else
						pack = "com.ixync.filter."
					if(nRegClass == (pack + "HttpStrutsRequestWrapper")) {
						nRegClass_true = "true";
					} else {
						nRegClass_true = "false";
					}
				}
				
				dataNode = xmlDoc.getElementsByTagName("response");
				if(dataNode.length > 0) {
					var nResClass	= dataNode[0].getAttribute("className");
				}
				
				var datasNode = xmlDoc.getElementsByTagName("dataSource");
				
				if(isDefault == true) {
					default_table();
				} else { //default 도메인일 경우만 보여준다.
					default_commend.innerHTML = "";
				}
				
				nDbCount = datasNode.length;
				if(nDbCount > 0) {
					
					for(var i = 0; i < nDbCount; i++) {
						nDBName			= datasNode[i].getAttribute("name");
						nDBCharIn		= datasNode[i].getAttribute("charsetIn");
						nDBCharOut		= datasNode[i].getAttribute("charsetOut");
						   
						dataNode		= xmlDoc.getElementsByTagName("jdbc");
						nJdbcDriver		= dataNode[i].getAttribute("driver");
						nJdbcUrl		= dataNode[i].getAttribute("url");
						nJdbcUser		= dataNode[i].getAttribute("user");
						nJdbcPass		= dataNode[i].getAttribute("password");
						
						nJdbcSchema		= dataNode[i].getAttribute("schema");
						dataSource_table(nDBName);
					}
				} 
			} else {
				alert(httpRequest.responseText);
			}
		} else {
		}
	}
	
	// 환경 설정 파일 선택
	function domain_Change() {
		var list = document.getElementById('domain_list');
		var domain = list[list.selectedIndex].value;
		domainData_Lode(domain);
		if(domain == "default") {
			isDefault = true;
		} else {
			isDefault = false;
		}
	}
	
	//내용 저장
	function config_Modify() {
		//action="inc/gauce_config_modify.jsp"
		window.document.config.submit();
	}
	
			
	</script>
</head>
<body onload="OnLoad_window();">
<div id="pageTitle">
	&nbsp;&nbsp;<a href='config_gauce_modify.jsp'> >서버 환경설정 파일 수정</a>
	&nbsp;&nbsp;<a href='config_gauce_add.jsp'> >서버 환경설정 파일 추가</a>
</div>
<div class="description">
	<table> 
		<tr> 
			<td colspan='2'>
				GAUCE 서버의 환경 정보를 수정합니다. </br>
				현재 web.xml 에는 <script>document.write(homeMode)</script>-filter가 등록되어 있습니다.</br>
			</td>
		</tr>
		<tr> 
			<td>환경파일 경로 - <script>document.write(homePath)</script>/<script>document.write(homeMode)</script>_conf/</td> 
			<td>
				<div id='domain_value'></div>
			</td>
		</tr>
	</table>
</div>

<div>
<fieldset>
	<form name="config" action="inc/gauce_config_modify.jsp" method="post" onsubmit="return config_Modify()" style="margin:0px; margin-top:10px;">
	<input type='hidden' name='domain_name'></input>
	<table border='0'>
		<tr>
			<td colspan='2' align='center'><b>global</b><td>
		</tr>
		<tr>
			<td colspan='2'>
				<div id='dlobal_commend'> 
				</div>
			</td> 
		</tr>
		<tr> 
			<td colspan='2'>
				<div id='default_commend'>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan='2' align='center'><input type="button" value="저 장" onclick=config_Modify();>
			</td>
		</tr>
	</table>
	</form>
</fieldset>
</div>

</body>
</html>