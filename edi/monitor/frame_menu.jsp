<!-- frame_menu.jsp : Created on 2008. 7. 29.
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
 *   frame menu
 *   �α��� ���¿� �޴� ����Ʈ�� �����ش�.
-->

<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<%@ include file="inc/session_check.jsp" %>
<%@ page import="java.util.*"%>
<script type="text/javascript" src="util.js"></script>
<html>
<head>
	<meta http-equiv=Content-Type content="text/html; charset=euc-kr">
	<title>GAUCE Administration</title>
	<link rel="Stylesheet" href="data/style.css">
	<style>
		body {
			background-color : white;
			margin-right : 0px;
		}
		fieldset#menu {
			padding-bottom : 15px;
		}
		li.menu1 {
			font-weight : bold;
			color : black;
			margin-top : 10px;
		}
		li.menu2 {
			list-style : none;
		}
		a {
			text-decoration : underline;
		}
	</style>
</head>
<body>

	<fieldset id="menu_2">
		<li class="menu"><%=session.getAttribute("user_name")%> �� (<%=session.getAttribute("user_group")%>)</li>
		<li class="menu2">�α��� : <%=session.getAttribute("login_time")%> </li>
		<li class="menu2"><a href="logout.jsp" target="_top">logout</a></li>
	</fieldset>
	<p>
	<fieldset id="menu_1">
		<li class="menu1"><a href="monitor.jsp" target="content_area">���� ����͸�</a></li>
		<li class="menu1">����</li>
			<li class="menu2"><a href="config_gauce_modify.jsp" target="content_area">GAUCE ���� ����</a></li>
			<li class="menu2"><a href="config_monitor.jsp" target="content_area">���� ����͸� ����</a></li>
			<li class="menu2"><a href="change_password.jsp" target="content_area">��й�ȣ ����</a></li>
	</fieldset>
	<p>
	<fieldset id="menu_1">
		<li class="menu1">Help</li>
			<li class="menu2"><a href="manual_monitor.html" target="content_area">����͸� �Ŵ���</a></li>
			<li class="menu2"><a href="manual_configuration.html" target="content_area">GAUCE ȯ�漳�� ����</a></li>
			<li class="menu2"><a href='http://www.gauce.com/' target='blank'>www.gauce.com</a></li>
			
	</fieldset>
</body>
</html>