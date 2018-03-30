<%/**  innoxync_config_load.jsp : Created on 2008. 7. 29.
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
 *   GAUCE Server의 환경 설정 파일을 추가한다.
 *   생성자 : ConfigLoader("GAUCE설치경로")
 *   
*/%>

<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<%@ include file="session_check.jsp" %>  
<%@ page import="java.util.*"%>
<%@ page import="com.ixync.common.monitor.ConfigLoader"%>                       

<%
	String result = "";
	String path = (String)session.getAttribute("homePath");
	String mode = (String)session.getAttribute("homeMode");
	String domainName = request.getParameter("domainName");
		
	if(domainName == null || domainName.trim().equals("")) {
	
		result = "<script language=javascript> \n "
               + "<!-- \n"
               + " alert('환경 파일 이름을 입력해 주세요.'); \n"
               + " history.back(); \n"
               + "// --> \n"
               + "</script> \n ";
	} else { //정상
		ConfigLoader loader = new ConfigLoader(path, mode);
		loader.configLoad(domainName);
		
		result = loader.configLoad(domainName);
		
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
	
		//out.println("<?xml version='1.0' encoding='euc-kr'?>");
	}
	out.println(result);
%>
 