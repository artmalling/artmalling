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
 *   GAUCE Server�� ȯ�� ���� ������ ���� �ϴ� ������ �̴�.
 *   GAUCE ��ġ ������ �����ϴ� ��ȿ�� ȯ�漳�� ���� ����Ʈ�� �����ְ�
 *   �̿� ���� ������ �����ش�.
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

	// ȯ�� ���� ���� ����Ʈ�� �ҷ��´�.
	function domainList_Lode() {
		var param = "";
		sendRequest("inc/gauce_config_list.jsp", param, listLoadResult, "POST");
	}
	
	// ȯ�� ���� ���� ����Ʈ �Ľ�
	function listLoadResult() {
		var domain_select = "<select id='domain_list' onchange='javascript:domain_Change();'>"
							+ "<option value=''>------����------</option>";
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
	
	// ȯ�� ���� ���� ������ �ҷ��´�.
	function domainData_Lode(name) {
		if(name != null && name != "") {
			document.config.domain_name.value = name;
			var param = "domainName=" + name;
			
			sendRequest("inc/gauce_config_load.jsp", param, dataLoadResult, "POST");
		}
	}
	
	// ȯ�� ���� ���� ���� �Ľ�
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
				} else { //default �������� ��츸 �����ش�.
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
	
	// ȯ�� ���� ���� ����
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
	
	//���� ����
	function config_Modify() {
		//action="inc/gauce_config_modify.jsp"
		window.document.config.submit();
	}
	
			
	</script>
</head>
<body onload="OnLoad_window();">
<div id="pageTitle">
	&nbsp;&nbsp;<a href='config_gauce_modify.jsp'> >���� ȯ�漳�� ���� ����</a>
	&nbsp;&nbsp;<a href='config_gauce_add.jsp'> >���� ȯ�漳�� ���� �߰�</a>
</div>
<div class="description">
	<table> 
		<tr> 
			<td colspan='2'>
				GAUCE ������ ȯ�� ������ �����մϴ�. </br>
				���� web.xml ���� <script>document.write(homeMode)</script>-filter�� ��ϵǾ� �ֽ��ϴ�.</br>
			</td>
		</tr>
		<tr> 
			<td>ȯ������ ��� - <script>document.write(homePath)</script>/<script>document.write(homeMode)</script>_conf/</td> 
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
			<td colspan='2' align='center'><input type="button" value="�� ��" onclick=config_Modify();>
			</td>
		</tr>
	</table>
	</form>
</fieldset>
</div>

</body>
</html>