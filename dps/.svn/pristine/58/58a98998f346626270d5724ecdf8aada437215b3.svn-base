<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주결재 > 기긴별매입현황집계표(자동전표구분)출력
 * 작  성  일  : 2010.08.30
 * 작  성  자  : 김경은
 * 수  정  자  : 
 * 파  일  명  : pord4031.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.08.30 (김경은) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo, java.net.URLDecoder,
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.*"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"    prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin /> 
<%
    String dir = BaseProperty.get("context.common.dir");
    int ozReportCnt = 1;
    //print/preview
    String printMode  ="preview";
    //true/false
    String concatpage = "true";
    String[] reportodi = new String[]{
          "pord4021"
    };
    String[] reportozr = new String[]{
          "dps/pord4021"
    };

    String reportname   = "기간별매입현황 집계표";
    String strStrCd     = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strBumun     = String2.trimToEmpty(request.getParameter("strBumun"));
    String strTeam      = String2.trimToEmpty(request.getParameter("strTeam"));
    String strPc        = String2.trimToEmpty(request.getParameter("strPc"));
    String strUserId    = String2.trimToEmpty(request.getParameter("strUserId"));
    String strStartDt   = String2.trimToEmpty(request.getParameter("strStartDt"));
    String strEndDt     = String2.trimToEmpty(request.getParameter("strEndDt"));
    String strSkuFlag1  = String2.trimToEmpty(request.getParameter("strSkuFlag1"));
    String strSkuFlag2  = String2.trimToEmpty(request.getParameter("strSkuFlag2"));
    String strSlipflag1 = String2.trimToEmpty(request.getParameter("strSlipflag1"));
    String strSlipflag2 = String2.trimToEmpty(request.getParameter("strSlipflag2"));
    String strSlipflag3 = String2.trimToEmpty(request.getParameter("strSlipflag3"));
    String strSlipflag4 = String2.trimToEmpty(request.getParameter("strSlipflag4"));
    String strSlipflag5 = String2.trimToEmpty(request.getParameter("strSlipflag5"));
    String strSlipflag6 = String2.trimToEmpty(request.getParameter("strSlipflag6"));
    String strSlipflag7 = String2.trimToEmpty(request.getParameter("strSlipflag7"));
    String strOrgFlag   = String2.trimToEmpty(request.getParameter("strOrgFlag"));

    String disPlayStrNM       = URLDecoder.decode(String2.trimToEmpty(request.getParameter("disPlayStrNM")), "UTF-8");    
    String disPlayBuMunNM     = URLDecoder.decode(String2.trimToEmpty(request.getParameter("disPlayBuMunNM")), "UTF-8");
    String disPlayTeamNM      = URLDecoder.decode(String2.trimToEmpty(request.getParameter("disPlayTeamNM")), "UTF-8");
    String disPlayPcNM        = URLDecoder.decode(String2.trimToEmpty(request.getParameter("disPlayPcNM")), "UTF-8");
    String disPlayBizTypeNM   = URLDecoder.decode(String2.trimToEmpty(request.getParameter("disPlayBizTypeNM")), "UTF-8");
    String disPlaySlipFlagNM  = URLDecoder.decode(String2.trimToEmpty(request.getParameter("disPlaySlipFlagNM")), "UTF-8");

    System.out.println("strStrCd = " + strStrCd);
    System.out.println("strBumun = " + strBumun);
    System.out.println("strTeam = " + strTeam);
    System.out.println("strPc = " + strPc);
    System.out.println("strStartDt = " + strStartDt);
    System.out.println("strSkuFlag1 = " + strSkuFlag1);
    System.out.println("strSkuFlag2 = " + strSkuFlag2);
    System.out.println("strSlipflag1 = " + strSlipflag1);  
    System.out.println("strSlipflag2 = " + strSlipflag2);
    System.out.println("strSlipflag3 = " + strSlipflag3);
    System.out.println("strSlipflag4 = " + strSlipflag4);
    System.out.println("strSlipflag5 = " + strSlipflag5);
    System.out.println("strSlipflag7 = " + strSlipflag7);
    System.out.println("strOrgFlag = " + strOrgFlag);
    System.out.println("strEndDt = " + strEndDt);
    
    
    //odi 파라미터
    String[][] params  = new String[][]{
        {"STR_CD="        + strStrCd,     "STRBUMUN="          + strBumun,          "STRTEAM="            + strTeam,
         "STRPC="         + strPc,        "USER_ID="           + strUserId,         "ORG_FLAG="           + strOrgFlag,    
         "STRSTARTDT="    + strStartDt,   "STRENDDT="          + strEndDt,
         "STRSKUFLAG1="   + strSkuFlag1,  "STRSKUFLAG2="       + strSkuFlag2,       "STRSLIPFLAG1="       + strSlipflag1,
         "STRSLIPFLAG2="  + strSlipflag2, "STRSLIPFLAG3="      + strSlipflag3,      "STRSLIPFLAG4="       + strSlipflag4,
         "STRSLIPFLAG5="  + strSlipflag5, "STRSLIPFLAG6="      + strSlipflag6,      "STRSLIPFLAG7="       + strSlipflag7, 
         "DISPLAYSTRNM="  + disPlayStrNM, "DISPLAYBUMUNBN="    + disPlayBuMunNM,    "DISPLAYTEAMNM="      + disPlayTeamNM,
         "DISPLAYPCNM="   + disPlayPcNM,  "DISPLAYBIZTYPENM="  + disPlayBizTypeNM,  "DISPLAYSLIPFLAGNM="  + disPlaySlipFlagNM}
    };
    
    //ozr파라미터
    String[][] formparams = new String[][]{
    };
%>
<%@ include file="/jsp/report.jsp"%>
