<!-- login.jsp : Created on 2008. 7. 29.
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
 *   ������ �������� �α��� ȭ���̴�.
-->

<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<html>
<head>
	<meta http-equiv=Content-Type content="text/html; charset=euc-kr">
	<title>GAUCE Administration</title>
	<link rel="Stylesheet" href="data/style.css">
	<style>
		#login_div {
			text-align : center;
			margin-top : 50px;
		}
		#error_div {
			color : red;
		}
	</style>
	<script type="text/javascript">
	<!--
	
	function window.onload() {
    window.document.login.id.focus();
	}

	function check() {
    if (window.document.login.id.value=="")  {
        alert("\���̵� �Է��ϼ���.");
//        error_div.innerHTML = "<b>LOGIN FAIL :</b><br>"
//        										+ "���̵� �Է��ϼ���!";
        window.document.login.id.focus();
        return;
    }
    if (window.document.login.password.value=="")  {
        alert("\��й�ȣ�� �Է��ϼ���.");
//        error_div.innerHTML = "<b>LOGIN FAIL :</b><br>"
//        										+ "��й�ȣ�� �Է��ϼ���!";
        window.document.login.password.focus();
        return;
    }
    window.document.login.submit();
	}
	
	//-->
	</script>
</head>
<body>
<div id="login_div">
	<table><tr><td>
	<fieldset style="padding:10px;">
		<legend>GAUCE ���� ������ �α���</legend>
		<form name="login" action="inc/login_check.jsp" method="post" onsubmit="return check()" style="margin:0px; margin-top:10px;">
		<table>
			<tr>
				<td align="right">���̵� :</td>
				<td><input name="id" type="text" style="vertical-align:middle;"></td>
			</tr>
			<tr>
				<td align="right">��й�ȣ :</td>
				<td><input name="password" type="password" style="vertical-align:middle;"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="button" value="�α���" onclick=check();></td>
			</tr>
		</table>
		</form>
		</td> </td>
	</fieldset>
	</td></tr></table>
	
	<table><tr><td>
	<div id="error_div">
	</div>
	</td></tr></table>
</div>
</body>
</html>