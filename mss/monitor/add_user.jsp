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
 *   관지자 페이지의 로그인 ID를 추가하는 화면이다.
 *   admin 그룹만이 접근 가능하다.
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
			alert("\ID를 입력해 주세요");
			window.document.addition.id.focus();
			return;
		}
		if (password == "")  {
			alert("\비밀번호를 입력해 주세요.");
			window.document.addition.password.focus();
			return;
		}
		var param = "newGroup=" + group
						+ "&newId=" + id
						+ "&newPw=" + password;
		//alert(param);
		sendRequest("inc/user_save.jsp", param, addResult, "POST");
	}
	
	// config 저장 후 응답을 받는다.
	function addResult() {
		if(httpRequest.readyState == 4)	{
			if(httpRequest.status == 200) {
				alert(httpRequest.responseText);
			} else {
			alert("ID 추가 중 문제가 발생하였습니다.");
			}
		} 
	}

	</script>
</head>
<body onload="OnLoad_window();">
<div id="pageTitle">
	&nbsp;&nbsp;<a href='change_password.jsp'> >비밀번호 변경</a>
	&nbsp;&nbsp;<a href='add_user.jsp'> >ID 추가</a>
</div>
<div class="description">
	GAUCE 서버 관리자 로그인 ID를 추가합니다.
</div>

<div>
<fieldset>
	<table> <tr><td width="250">
		<form name="addition">
		<table>
			<tr>
				<td align="right" width='120'><b>그룹 :</b></td>
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
				<td align="right"><b>비밀번호 :</b></td>
				<td><input name="password" type="password" style="vertical-align:middle;"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="button" value="추 가" onclick=add();></td>
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