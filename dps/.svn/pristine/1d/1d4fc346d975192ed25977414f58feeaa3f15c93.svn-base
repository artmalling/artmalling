<%
/**  config_read.jsp : Created on 2008. 7. 29.
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
%>

<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<%@ page import="com.ixync.common.monitor.MonitorConfigLoader" %>
<%@ page import="com.ixync.servlet.FilterDataLoader" %>

<%
		MonitorConfigLoader loader = new MonitorConfigLoader();
		loader.configLoad();
	
		session.setAttribute("reloadTime", String.valueOf(loader.getReloadTime()));
		session.setAttribute("chartSize", String.valueOf(loader.getMaxSize()));
		session.setAttribute("overTime", String.valueOf(loader.getOverTime()));
		if(loader.isMonitorLog()) {
			session.setAttribute("logPath", loader.getLogPath());
		} else {
			session.setAttribute("logPath", "현재 로그 파일이 생성되지 않고있습니다.");
		}
		session.setAttribute("homePath", loader.getInstallPath()); //20080724
		session.setAttribute("homeMode", loader.getHomeMode()); //20090721		
%>