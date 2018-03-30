<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출실적
 * 작 성 일 : 2010.05.13
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal4201.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 행사테마별매출현황
 * 이    력 :2010.05.13 박종은
 * 
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

    
    int ozReportCnt = 1;

    String printMode  ="preview";

    String concatpage = "true";
    String reportname    = "행사테마별매출현황";

    String strStrCd      = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strLCd        = String2.trimToEmpty(request.getParameter("strLCd"));
    String strMCd        = String2.trimToEmpty(request.getParameter("strMCd"));
    String strSCd        = String2.trimToEmpty(request.getParameter("strSCd"));
    String strSaleDtS    = String2.trimToEmpty(request.getParameter("strSaleDtS"));
    String strSaleDtE    = String2.trimToEmpty(request.getParameter("strSaleDtE"));
    String strUserId     = String2.trimToEmpty(request.getParameter("strUserId"));
    String strStrCdN     = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strStrCdN")), "UTF-8");
    String strLCdN       = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strLCdN")), "UTF-8");
    String strMCdN       = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strMCdN")), "UTF-8");
    String strSCdN       = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strSCdN")), "UTF-8");
    
	String[] reportodi = new String[]{
			"psal4201"
	};
	String[] reportozr = new String[]{
			"dps/psal4201"
	};
	System.out.println(strStrCdN);
    String[][] params  = new String[][]{
              { "STR_CD="      + strStrCd        , "L_CD="        + strLCd        	  , "M_CD="        + strMCd
        	  , "S_CD="        + strSCd        	 , "SALE_DT_S="   + strSaleDtS        , "SALE_DT_E="   + strSaleDtE
              , "USER_ID="     + strUserId       , "STR_NAME="     + strStrCdN         , "L_NAME="       + strLCdN
              , "M_NAME="       + strMCdN         , "S_NAME="       + strSCdN} 
    }; 
    
    //ozr파라미터
    String[][] formparams = new String[][]{ 
    
    };
    
%>
<%@ include file="/jsp/report.jsp"%>

