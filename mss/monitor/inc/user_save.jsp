<%
/**  user_save.jsp : Created on 2008. 7. 29.
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
*/

/**
 *   ������ �������� ������ �߰��Ѵ�.
 *   ID/Password�� ��ġ ������ WEB-INF �Ʒ��� '.password'���Ͽ� �����ȴ�.
 *   ������ : CheckPassword("GAUCE��ġ���")
*/
%>

<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<%@ page import="com.ixync.common.monitor.CheckPassword" %>
<%@ page import="java.util.*"%>                                     
<%@ include file="session_check.jsp" %>  
<%
	String check = (String)session.getAttribute("user_group");
	
	String result = "";
	if(check.equals("admin")) {
		String group = request.getParameter("newGroup");
		String id 	=  request.getParameter("newId"); //(String)session.getAttribute("newId");
		String password =  request.getParameter("newPw");
		String path = (String)session.getAttribute("homePath");
	
		CheckPassword admin = new CheckPassword(path);
  	result = admin.saveIdPassword(group, id, password);	
  	//result = "ok";
	} else {
		result = "user �׷��� ID�� �߰��� �� �����ϴ�.";
	}
	out.println(result);
//	response.setContentType("text/xml");
//	response.setHeader("Cache-Control", "no-cache");
//	out.print("<?xml version=\"1.0\" encoding=\"euc-kr\"?>\r\n");
//	out.print("<result>\r\n");
//	out.print("	<message>" + result + "</message>\r\n");
//	out.print("	<message>" + result + "</message>\r\n");
//	out.print("</result>\r\n");
//	out.flush();
//	out.close();
%>
 