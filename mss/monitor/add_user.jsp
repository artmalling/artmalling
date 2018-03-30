<!-- add_user.jsp : Created on 2008. 7. 29.
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
 *   ������ �������� �α��� ID�� �߰��ϴ� ȭ���̴�.
 *   admin �׷츸�� ���� �����ϴ�.
-->

<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<%@ include file="inc/session_check_admin.jsp" %>


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

	function add() {
		var group = window.document.addition.group.value;
		var id = window.document.addition.id.value;
		var password = window.document.addition.password.value;
		if (id == "")  {
			alert("\ID�� �Է��� �ּ���");
			window.document.addition.id.focus();
			return;
		}
		if (password == "")  {
			alert("\��й�ȣ�� �Է��� �ּ���.");
			window.document.addition.password.focus();
			return;
		}
		var param = "newGroup=" + group
						+ "&newId=" + id
						+ "&newPw=" + password;
		//alert(param);
		sendRequest("inc/user_save.jsp", param, addResult, "POST");
	}
	
	// config ���� �� ������ �޴´�.
	function addResult() {
		if(httpRequest.readyState == 4)	{
			if(httpRequest.status == 200) {
				alert(httpRequest.responseText);
			} else {
			alert("ID �߰� �� ������ �߻��Ͽ����ϴ�.");
			}
		} 
	}

	</script>
</head>
<body onload="OnLoad_window();">
<div id="pageTitle">
	&nbsp;&nbsp;<a href='change_password.jsp'> >��й�ȣ ����</a>
	&nbsp;&nbsp;<a href='add_user.jsp'> >ID �߰�</a>
</div>
<div class="description">
	GAUCE ���� ������ �α��� ID�� �߰��մϴ�.
</div>

<div>
<fieldset>
	<table> <tr><td width="250">
		<form name="addition">
		<table>
			<tr>
				<td align="right" width='120'><b>�׷� :</b></td>
				<td><select name='group'>
						<option value='user'>user</option>
						<option value='admin'>admin</option>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right"><b>ID :</b></td>
				<td><input name="id" type="password" style="vertical-align:middle;"></td>
			</tr>
			<tr>
				<td align="right"><b>��й�ȣ :</b></td>
				<td><input name="password" type="password" style="vertical-align:middle;"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="button" value="�� ��" onclick=add();></td>
			</tr>
		</table>
		</form>
	</tr><td width="250">
	
	</td></table>
</fieldset>
</div>
<p>

</body>
</html>