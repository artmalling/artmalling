<!-- logout.jsp : Created on 2008. 7. 29.
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
 *   ������ �������� �α׾ƿ� �� �α��� �������� �̵��Ѵ�.
-->

<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<%
    session.invalidate();
    response.sendRedirect("login.jsp");
%>