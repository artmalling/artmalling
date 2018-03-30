<!-- 
/*******************************************************************************
 * 시스템명 : 시스템명 : 영업관리 > 수불손익 > 조직별손익명세서
 * 작 성 일 : 2010.06.10
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk3051.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 조직별손익명세서(출력)
 * 이    력 :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo , java.net.URLDecoder, 
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.*"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"    prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    String dir = BaseProperty.get("context.common.dir");
    //String url = "http://localhost:81";
    String url = "http://" + BaseProperty.get("ip") + ":" + BaseProperty.get("port") ;
    int ozReportCnt = 1;
    //print/preview
    String printMode  ="preview";
    //true/false
    String concatpage = "true";
    
    String reportname  = "조직별손익명세서";
    
    String strStrCd      = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strDeptCd     = String2.trimToEmpty(request.getParameter("strDeptCd"));
    String strTeamCd     = String2.trimToEmpty(request.getParameter("strTeamCd"));
    String strPcCd       = String2.trimToEmpty(request.getParameter("strPcCd"));
    String strStkYm      = String2.trimToEmpty(request.getParameter("strStkYm"));
    String strStkSYm     = String2.trimToEmpty(request.getParameter("strStkSYm"));
    String strStkBfYm    = String2.trimToEmpty(request.getParameter("strStkBfYm"));
    String strYyyy       = String2.trimToEmpty(request.getParameter("strYyyy"));
    String strOrgName    = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strOrgName")), "UTF-8");

	String[] reportodi = new String[]{
			"pstk3050"
	};
	String[] reportozr = new String[]{
			"dps/pstk3050"
	};
    String[][] params  = new String[][]{
          {  "STR_CD=" + strStrCd
           , "DEPT_CD=" + strDeptCd
           , "TEAM_CD=" + strTeamCd
           , "PC_CD="   + strPcCd
           , "STK_YM="  + strStkYm
           , "STK_S_YM=" + strStkSYm
           , "STK_BF_YM=" + strStkBfYm
           , "YYYY="    + strYyyy
           , "ORG_NAME=" + strOrgName} 
    }; 
    //ozr파라미터
    String[][] formparams = new String[][]{ 
    
    };
%>
<%@ include file="/jsp/report.jsp"%>

