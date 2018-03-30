<!-- config_innoxync_add.jsp : Created on 2008. 7. 29.
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
 *   GAUCE Server�� ȯ�� ���� ������ �߰� �ϴ� ������ �̴�.
 *   ����� ���� Ȥ�� ����Ʈ ������ �߰��� �� �ִ�.
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
			type_Check();
			
		}
	//-->
	var homePath = "<%=session.getAttribute("homePath")%>";
	var homeMode = "<%=session.getAttribute("homeMode")%>";
	
	
	// ����� ���� or default ���� Ȯ��
	function type_Check() {
	
		var domain_types = document.getElementsByName('domain_type');
		var domain_in = "";
		if(domain_types[1].checked) {
			domain_in = "<input type='text' name='domain' value='default' size='10' disabled='true'> </input>";
			default_table();
		}
		else {
			domain_in = "<input type='text' name='domain' size='10'> </input>";
			default_commend.innerHTML = "";
		}
		domain_input.innerHTML = domain_in;
		
		
	}
	
	// �ش� ������ �̸��� ȯ�漳�� ������ ���� �ϴ��� üũ
	function domain_Check() {
	
	}
	
	//���� ����
	function config_Add() {
		document.config.domain_name.value = document.getElementById('domain').value;
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
			<td colspan='3'>
				���� web.xml ���� <script>document.write(homeMode)</script>-filter�� ��ϵǾ� �ֽ��ϴ�.</br>
				GAUCE ������ ȯ�� ������ �߰��մϴ�. &nbsp;&nbsp;
				<input type='radio' name='domain_type' value='etc' checked='checked' onclick='type_Check();'>��������� <span class='help'>(?)
								<span class='helptext'>����� ���� ȯ�� ������ �����մϴ�.<br>
									������ ���� ����/ First Row ����/ ���ڵ�/ �����ͼ� �÷� ������/ ��ȣȭ ����� ������ �� �ֽ��ϴ�.<br></span>
							</span> 
				</input> &nbsp;
				<input type='radio' name='domain_type' value='default' onclick='type_Check();'>default <span class='help'>(?)
								<span class='helptext'>GAUCE ������ �����ϴµ� �ʿ��� �⺻���� ȯ���� �����մϴ�.<br></span>
							</span> 
				</input> &nbsp;
			</td>
		</tr>
		<tr> 
			<td>ȯ������ - <script>document.write(homePath)</script>/<script>document.write(homeMode)</script>_conf/<script>document.write(homeMode)</script>-
			</td>
			<td>
				<div id='domain_input'></div>				
			</td>
			<td>.xml  &nbsp;&nbsp;</td>
		</tr>
		<tr> 
			<td align='center'>
			</td>
		</tr>
	</table>
</div>

<div>
<fieldset>
	<form name="config" action="inc/gauce_config_add.jsp" method="post" onsubmit="return config_Add()" style="margin:0px; margin-top:10px;">
	<input type='hidden' name='domain_name'></input>
	<table border='0'>
		<tr>
			<td colspan='2' align='center'><b>global</b><td>
		</tr>
		<tr> <td colspan='2'>
			<div id='dlobal_commend'> 
			</div>
		</td> </tr>
		<tr> 
			<td colspan='2'>
			<div id='default_commend'>
			</div>
			</td>
		</tr>
		<tr>
			<td colspan='2' align='center'><input type="button" value="�� ��" onclick=config_Add();></td>
		</tr>
	</table>
	</form>
</fieldset>
</div>

</body>
</html>