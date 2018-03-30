<%
/**  innoxync_config_list.jsp : Created on 2008. 7. 29.
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
 *   GAUCE Server의 설치 디렉토리에 존재하는 유효한 환경 설정 파일 목록을 리턴한다.
 *   <message>
 *      <domains>
 *        <domain> default </domain>
 *        <domain> ... </domain>
 *      </domains>
 *   </message>
 *   
*/
%>

<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<%@ include file="session_check.jsp" %>  
<%@ page import="java.util.*"%>  
<%@ page import="java.io.File"%>                                   

<%	
	String homePath	= (String)session.getAttribute("homePath");
	String homeMode = (String)session.getAttribute("homeMode");
	response.setContentType("text/xml");
	response.setHeader("Cache-Control", "no-cache");
	out.println("<?xml version='1.0' encoding='euc-kr'?>");
	//out.println("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>");
	out.println("<message>");
	out.println("	<domains>");
	
	File path = new File(homePath + "/WEB-INF/" + homeMode + "_conf");
  if(path.isDirectory()) {
		File[] fileList = path.listFiles();
  	for(int i = 0, j = 0; i < fileList.length; i++) {
  		int innoxyncStart = fileList[i].getName().indexOf(homeMode + "-");
  		int xmlStart = fileList[i].getName().lastIndexOf(".xml");
  		if( !fileList[i].isDirectory() && innoxyncStart == 0 
  				&& fileList[i].getName().length() == xmlStart + ".xml".length()) {
  			out.println("		<domain>" + fileList[i].getName().substring(innoxyncStart + (homeMode + "-").length(), xmlStart) + "</domain>");
  			j++;	
  		}
  	}
  }
	out.println("	</domains>");
	out.println("</message>");
%>
 