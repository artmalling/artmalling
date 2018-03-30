<%/**  innoxync_config_add.jsp : Created on 2008. 7. 29.
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
 *   GAUCE Server�� ȯ�� ���� ������ �߰��Ѵ�.
 *   �ļ��� :ConfigLoader("GAUCE��ġ���")
*/%>

<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<%@ include file="session_check.jsp" %>  
<%@ page import="java.util.*"%>                                     
<%@ page import="com.ixync.common.monitor.ConfigLoader"%> 
<%@ page import="com.gauce.db.DBProfile"%> 

<%
 	String result = "";
 	String path = (String)session.getAttribute("homePath");
 	String mode = (String)session.getAttribute("homeMode");
 	String domain_name = request.getParameter("domain_name");
 	
 	if(domain_name == null || domain_name.trim().equals("")) {
 		result = "ȯ�� ���� �̸��� �Է��� �ּ���.";
 		
 	} else { //����
 		ConfigLoader loader = new ConfigLoader(path, mode);
 		
 		//�ʼ�
 		loader.setCompressed(request.getParameter("compressed"));
 		loader.setFragment(request.getParameter("fragment"));
 		loader.setEncDefault(request.getParameter("enc_default"));
 		loader.setEncGet(request.getParameter("enc_get"));
 		loader.setEncPost(request.getParameter("enc_post"));
 		loader.setColumnInteger(request.getParameter("column_integer"));
 		loader.setColumnDecimal(request.getParameter("column_decimal"));
 		loader.setColumnString(request.getParameter("column_string"));
 		loader.setColumnRound(request.getParameter("column_round"));
 		
 		//����
 		String cryptoSpi = request.getParameter("crypto_spi");
 		if(null != cryptoSpi && !cryptoSpi.trim().equals("")) {
 			loader.setCryptoSpi(cryptoSpi);
 		}
 		int index = 0;
 		while(true) {
		 	index++;
		 	String cryptoName = request.getParameter("crypto_name_" + index);
		 	String cryptoValue = request.getParameter("crypto_value_" + index);
		 	if(null != cryptoName && !cryptoName.trim().equals("")
		 			&& null != cryptoValue && !cryptoValue.trim().equals("")) {
		 		loader.setCryptoParam(cryptoName, cryptoValue);
		 	} else {
		 		break;
		 	}
 		}
 		
	 	if(domain_name.equals("default")) {	//����Ʈ ���ϸ�
			loader.setMonitorLog(request.getParameter("monitor_log"));
			loader.setMonitorDir(request.getParameter("monitor_dir"));
	 	
		 	String pack = "com.ixync.filter.";
		 	String clas = "HttpIXyncRequestWrapper";
		 	if(mode.equals("gauce")) {
				pack = "com.gauce.filter.";	
				clas = "HttpGauceRequestWrapper";
			}  
		 	if(request.getParameter("connector_req").equals("true")) {
		 		clas = "HttpStrutsRequestWrapper";
		 	}
		 	loader.setConnectorReq(pack + clas);
		 	//loader.setConnectorReq(request.getParameter("connector_req"));
	 	
			String dataSourceNames = request.getParameter("dataSource_names");
	 	
		 	if(dataSourceNames != null) {
		 		int start = 0;
		 		int end = 0;
		 		while(true) {	
		 			end = dataSourceNames.indexOf(":", start);
		 			if(end < 1) break;
		 			String temp = dataSourceNames.substring(start, end);
		 			String gdbcName = temp;
		 			DBProfile profile = new DBProfile(
		 								"",
		                     request.getParameter("jdbc_driver_" + temp), 
		                     request.getParameter("jdbc_url_" + temp), 
		                     request.getParameter("jdbc_user_" + temp), 
		                     request.getParameter("jdbc_pass_" + temp), 
		                     request.getParameter("jdbc_in_" + temp), 
		                     request.getParameter("jdbc_out_" + temp), 
		                     "", 
		                     1);
		           loader.setDataResource(gdbcName, profile);
		 			start = (end+1);
		 		}
		 	}
	 	}
	 	loader.configSave(domain_name);
	 	result = "���� �Ͽ����ϴ�.";
 	} //else end
 	
 	String rHtml = "<script language=javascript> \n "
                + "<!-- \n"
                + " alert('" + result +"'); \n"
                + " history.back(); \n"
                + "// --> \n"
                + "</script> \n ";
 	out.println(rHtml);
 %>
 