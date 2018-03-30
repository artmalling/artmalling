<%
/**  password_save.jsp : Created on 2008. 7. 29.
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
 *   관리자 페이지의 로그인 비밀번호를 변경한다.
 *   ID/Password는 설치 파일의 WEB-INF 아래에 '.password'파일에 보관된다.
*/
%>

<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<%@ page import="com.ixync.common.monitor.CheckPassword" %>
<%@ page import="java.util.*"%>                                     
<%@ include file="session_check.jsp" %>  
<%
	request.setCharacterEncoding("EUC-KR");
	String id 	= (String)session.getAttribute("user_name");
	String path = (String)session.getAttribute("homePath");
	String oldPw = request.getParameter("oldPw");
	String newPw = request.getParameter("newPw");
  
  CheckPassword admin = new CheckPassword(path);
  String result = admin.modifyPassword(id, oldPw, newPw);
	
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
 