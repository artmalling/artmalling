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
 *   관지자 페이지의 로그인 Password를 변경하는 화면이다.
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
			pageTitle.innerHTML = "&nbsp;&nbsp;<a href='change_password.jsp'> >비밀번호 변경</a>"
													+ "&nbsp;&nbsp;<a href='add_user.jsp'> >ID 추가</a>";
		} else {
			pageTitle.innerHTML = "비밀번호 변경";
		}			
	}
	function change() {
		var oldPw = window.document.password.oldPassword.value;
		var newPw1 = window.document.password.newPassword1.value;
		var newPw2 = window.document.password.newPassword2.value;
		if (oldPw == "" || newPw1 == "" || newPw2 == "")  {
			alert("\비밀번호를 입력하세요.");
			window.document.password.oldPassword.focus();
			return;
		}
		if (newPw1 != newPw2)  {
			alert("\새 비밀번호를 확인해 주세요.");
			window.document.password.newPassword1.focus();
			return;
		}
		var param = "oldPw=" + oldPw 
						+ "&newPw=" + newPw1;
		//alert(param);
		sendRequest("inc/password_save.jsp", param, changeResult, "POST");
	}
	
	// config 저장 후 응답을 받는다.
	function changeResult() {
		if(httpRequest.readyState == 4)	{
			if(httpRequest.status == 200) {
				alert(httpRequest.responseText);
			} else {
			alert("Password변경 중 문제가 발생하였습니다.");
			}
		} 
	}

	</script>
</head>
<body onload="OnLoad_window();">
<div id='pageTitle'>
</div>
<div class="description">
	GAUCE 서버 관리자 로그인 비밀번호를 변경합니다.
</div>

<div>
<fieldset>
	<table> <tr><td width="250">
		<form name="password">
		<table>
			<tr>
				<td align="right" width='120'><b>기존 비밀번호 :</b></td>
				<td><input name="oldPassword" type="password" style="vertical-align:middle;"></td>
			</tr>
			<tr>
				<td align="right"><b>새 비밀번호 :</b></td>
				<td><input name="newPassword1" type="password" style="vertical-align:middle;"></td>
			</tr>
			<tr>
				<td align="right"><b>비밀번호 확인 :</b></td>
				<td><input name="newPassword2" type="password" style="vertical-align:middle;"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="button" value="저 장" onclick=change();></td>
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