<!-- 
/*******************************************************************************
 * 시스템명 : 시스템메뉴 > 관리자메뉴> 공통코드관리
 * 작 성 일 : 2010.12.12
 * 작 성 자 : 정지인
 * 수 정 자 : 
 * 파 일 명 : tcom101r.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 공통코드 출력
 * 이    력 :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
    common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty, kr.fujitsu.ffw.util.*"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"    prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>
<meta http-equiv="Pragma" content="no-cache"; charset=utf-8">

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                    *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
	String url = "http://" + BaseProperty.get("ip") + ":" + BaseProperty.get("port") ;
	
	//String url = "http://localhost:81";
	int ozReportCnt = 4;
	
	//print/preview
	String printMode  ="preview";
	
	//true/false
	String concatpage = "true";
	
	String[] reportodi = new String[]{
		  "tcom1010"
		, "tcom1010"
		, "tcom1010"
		, "tcom1010"
	};
	
	String[] reportozr = new String[]{
		  "pot/tcom1010"
		, "pot/tcom1010"
		, "pot/tcom1010"
		, "pot/tcom1010"
	};

	String reportname  = "공통코드관리";

	String strTmpCd	= String2.trimToEmpty(request.getParameter("strTmpCd"));
	String strSysCd	= String2.trimToEmpty(request.getParameter("strSysCd"));
	url	= url + "/pot/tcom101.tc?goTo=httpstore&strTmpCd="+strTmpCd+"&strSysCd="+strSysCd ;
	
	//odi 파라미터
	String[][] params  = new String[][]{
		  {"TEMP_CODE=" + strTmpCd, "SYS_CODE="  + strSysCd, "URL=" + url}
		, {"TEMP_CODE=" + strTmpCd, "SYS_CODE="  + strSysCd, "URL=" + url}
		, {"TEMP_CODE=" + strTmpCd, "SYS_CODE="  + strSysCd, "URL=" + url}
		, {"TEMP_CODE=" + strTmpCd, "SYS_CODE="  + strSysCd, "URL=" + url}
		//, {"TEMP_CODE=" + strTmpCd, "SYS_CODE="  + "E", "URL=" + url}
	};
	
	//ozr파라미터
	String[][] formparams = new String[][]{};
%>
<%@ include file="/jsp/report.jsp"%>
