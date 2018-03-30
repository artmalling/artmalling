<%
/**  login_check.jsp : Created on 2008. 7. 29.
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
 *   관리자 페이지의 로그인 ID와 Password를 검사한다.
 *   로그인 성공 시 로그인 시간과 유저의 그룹을 세션에 등록한다.
*/
%>

<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<%@ page import="com.ixync.common.monitor.CheckPassword" %>
<%@ page import="java.util.Date" %>
<%@ include file="config_read.jsp" %>

<%
    String loginId  = request.getParameter("id");
    String loginPwd = request.getParameter("password");
    String homePath	= (String)session.getAttribute("homePath");	//20080724
 		
 		//context경로(GAUCE-server 설치 디렉토리)
    CheckPassword admin = new CheckPassword(homePath);
    String result = admin.checkPassword(loginId, loginPwd);
    
    if(result.equals("admin") || result.equals("user")) {
    	Date date = new Date();
			int h = date.getHours();
			int m = date.getMinutes();
			int s = date.getSeconds();
			String time = h + "시" + m + "분" + s + "초";
		
    	session.setAttribute("user_group", result);
    	session.setAttribute("user_name", loginId);
    	session.setAttribute("login_time", time);
      response.sendRedirect("../frameset.jsp");
    }else {
    	session.setAttribute("user_group", "fail");
    	String rHtml =
                "<script language=javascript> \n " +
                "<!-- \n" +
                " alert('" + result + "'); \n" +
                " history.back(); \n" +
                "// --> \n" +
                "</script> \n ";
			session.invalidate();
			out.println(rHtml);
    }
%>