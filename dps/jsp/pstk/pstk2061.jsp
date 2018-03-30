<!-- 
/*******************************************************************************
 * 시스템명 : 시스템명 : 영업관리 > 재고수불 > 실사재고조사표출력(비단품)
 * 작 성 일 : 2010.04.25
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk2061.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 실사재고조사표출력(비단품)
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
    //String url = "http://" + BaseProperty.get("ip") + ":" + BaseProperty.get("port") ;
    //String url = "http://localhost:81";
    String url = "http://" + BaseProperty.get("ip") + ":" + BaseProperty.get("port") ;
    int ozReportCnt = 1;
    //print/preview
    String printMode  ="preview";
    //true/false
    String concatpage = "true";
    
    String reportname  = "재고 조사표";
    
    String strStrCd      = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strStkYm      = String2.trimToEmpty(request.getParameter("strStkYm"));
    String strDeptCd     = String2.trimToEmpty(request.getParameter("strDeptCd"));
    String strTeamCd     = String2.trimToEmpty(request.getParameter("strTeamCd"));
    String strPcCd       = String2.trimToEmpty(request.getParameter("strPcCd"));
    String strCornerCd   = String2.trimToEmpty(request.getParameter("strCornerCd"));
    String strPumbunCd   = String2.trimToEmpty(request.getParameter("strPumbunCd"));
    String strPumbunName = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strPumbunName")), "UTF-8");
    String strStkDt      = String2.trimToEmpty(request.getParameter("strStkDt"));
    String strOrgName    = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strOrgName")), "UTF-8");
    String strFlorCd     = String2.trimToEmpty(request.getParameter("strFlorCd"));
    String strFlorName   = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strFlorName")), "UTF-8");

	String[] reportodi = new String[]{
			"pstk2060"
	};
	String[] reportozr = new String[]{
			"dps/pstk2060"
	};
    String[][] params  = new String[][]{
          {"STR_CD=" + strStrCd
         , "STK_YM=" + strStkYm
         , "DEPT_CD=" + strDeptCd
         , "TEAM_CD=" + strTeamCd
         , "PC_CD=" + strPcCd
         , "CORNER_CD=" + strCornerCd
         , "PUMBUN_CD=" + strPumbunCd
         , "PUMBUN_NAME="  + strPumbunName
         , "STK_DT=" + strStkDt
         , "ORG_NAME="  + strOrgName
         , "FLOR_CD=" + strFlorCd
         , "FLOR_NAME="  + strFlorName} 
    }; 
    //ozr파라미터
    String[][] formparams = new String[][]{ 
    
    };
%>
<%@ include file="/jsp/report.jsp"%>

