<%
/**  monitor_config_modify.jsp : Created on 2008. 7. 29.
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
 *   모니터링의 환경 설정 파일을 변경한다.
 *   생성자 : MonitorConfigLoader("GAUCE설치 경로");
*/
%>

<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<%@ include file="session_check.jsp" %>  
                                                                    
<%@ page import="java.util.*"%>                                     
<%@ page import="com.ixync.common.monitor.MonitorConfigLoader" %>          

<%	
	String chartSize	= request.getParameter("chartSize");							
	String reloadTime	= request.getParameter("reloadTime");
	String overTime		= request.getParameter("overTime");
	
	MonitorConfigLoader loader = new MonitorConfigLoader();
	
	loader.setReloadTime(Long.valueOf(reloadTime).intValue());
	loader.setMaxSize(Integer.valueOf(chartSize).intValue());
	loader.setOverTime(Integer.valueOf(overTime).intValue());
	loader.configSave();
							 
	response.setContentType("text/xml; charset=euc-kr");
	response.setHeader("Cache-Control", "no-cache");
	out.println("<?xml version=\"1.0\" encoding=\"euc-kr\" ?>");
	out.println("<response>");
	out.println("	<message>SUCCESS</message>");
	out.println("</response>");
	
%>
 