<%
/*******************************************************************************
  * 시스템명 : 한국후지쯔 통합정보시스템 공통 
  * 작 성 일 : 2010.06.12 
  * 작 성 자 : FKL
  * 수 정 자 :
  * 파 일 명 : UpdateManager.jsp
  * 버    전 : 1.0
  * 개    요 : 가우스 서버 암호화 유틸리티를 이용한 ActiveUpdate 암호화 적용 방법(CASE-1)
  * 이    력 : 
  *****************************************************************************/
%>

<%@ page	import="java.io.*,com.shift.utils.common.*,javax.servlet.ServletOutputStream;" 	pageEncoding="utf-8"%><%	

	//String file = "/ActiveUpdate4Manager_Unicode/install.xml";
	String file = "/AU4/install.xml";	
	InstallUpdateManager updateManager = new InstallUpdateManager(application, file);
	updateManager.setServer(request.getServerName());
	updateManager.setVersion("JS01");
	
	try {
		updateManager.init();
		response.setContentLength(updateManager.getHeader().length + updateManager.getBody().length);
		
		/**		jeuse인경우 주석을 풀어주세요**/
		//out.clear();
		//out.close();
		

		ServletOutputStream sos = response.getOutputStream();
		sos.write(updateManager.getHeader());
		sos.write(updateManager.getBody());
		sos.close();
	} catch(Exception e) {
		e.printStackTrace();
		response.sendError(HttpServletResponse.SC_FORBIDDEN);
	}
%>
