<!-- change_password.jsp : Created on 2008. 7. 29.
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
 *   ������ �������� �α��� Password�� �����ϴ� ȭ���̴�.
-->

<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<%@ include file="inc/session_check.jsp" %>


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
			checkGroup();
			
		}
	//-->
	
	function checkGroup() {
		var check = "<%=session.getAttribute("user_group")%>";
		if(check == "admin") {
			pageTitle.innerHTML = "&nbsp;&nbsp;<a href='change_password.jsp'> >��й�ȣ ����</a>"
													+ "&nbsp;&nbsp;<a href='add_user.jsp'> >ID �߰�</a>";
		} else {
			pageTitle.innerHTML = "��й�ȣ ����";
		}			
	}
	function change() {
		var oldPw = window.document.password.oldPassword.value;
		var newPw1 = window.document.password.newPassword1.value;
		var newPw2 = window.document.password.newPassword2.value;
		if (oldPw == "" || newPw1 == "" || newPw2 == "")  {
			alert("\��й�ȣ�� �Է��ϼ���.");
			window.document.password.oldPassword.focus();
			return;
		}
		if (newPw1 != newPw2)  {
			alert("\�� ��й�ȣ�� Ȯ���� �ּ���.");
			window.document.password.newPassword1.focus();
			return;
		}
		var param = "oldPw=" + oldPw 
						+ "&newPw=" + newPw1;
		//alert(param);
		sendRequest("inc/password_save.jsp", param, changeResult, "POST");
	}
	
	// config ���� �� ������ �޴´�.
	function changeResult() {
		if(httpRequest.readyState == 4)	{
			if(httpRequest.status == 200) {
				alert(httpRequest.responseText);
			} else {
			alert("Password���� �� ������ �߻��Ͽ����ϴ�.");
			}
		} 
	}

	</script>
</head>
<body onload="OnLoad_window();">
<div id='pageTitle'>
</div>
<div class="description">
	GAUCE ���� ������ �α��� ��й�ȣ�� �����մϴ�.
</div>

<div>
<fieldset>
	<table> <tr><td width="250">
		<form name="password">
		<table>
			<tr>
				<td align="right" width='120'><b>���� ��й�ȣ :</b></td>
				<td><input name="oldPassword" type="password" style="vertical-align:middle;"></td>
			</tr>
			<tr>
				<td align="right"><b>�� ��й�ȣ :</b></td>
				<td><input name="newPassword1" type="password" style="vertical-align:middle;"></td>
			</tr>
			<tr>
				<td align="right"><b>��й�ȣ Ȯ�� :</b></td>
				<td><input name="newPassword2" type="password" style="vertical-align:middle;"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="button" value="�� ��" onclick=change();></td>
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