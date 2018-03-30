<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽운영 > 승인처리 > 기간별매입현황 집계표 출력
 * 작  성  일  : 2010.05.02
 * 작  성  자  : 박래형
 * 수  정  자  : 
 * 파  일  명  : pord4021.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가) 
 * 개         요  : 
 * 이         력  :
 *           2010.04.25 (박래형) 신규작성
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
          "pord4041"
    };
    String[] reportozr = new String[]{
          "dps/pord4041"
    };

    String reportname   = "기간별매입현황 집계표";
    String strStrCd     = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strBumun     = String2.trimToEmpty(request.getParameter("strBumun"));
    String strTeam      = String2.trimToEmpty(request.getParameter("strTeam"));
    String strPc        = String2.trimToEmpty(request.getParameter("strPc"));   
    String strStartDt   = String2.trimToEmpty(request.getParameter("strStartDt"));
    String strEndDt     = String2.trimToEmpty(request.getParameter("strEndDt"));   
  

    String disPlayStrNM       = URLDecoder.decode(String2.trimToEmpty(request.getParameter("disPlayStrNM")), "UTF-8");    
    String disPlayBuMunNM     = URLDecoder.decode(String2.trimToEmpty(request.getParameter("disPlayBuMunNM")), "UTF-8");
    String disPlayTeamNM      = URLDecoder.decode(String2.trimToEmpty(request.getParameter("disPlayTeamNM")), "UTF-8");
    String disPlayPcNM        = URLDecoder.decode(String2.trimToEmpty(request.getParameter("disPlayPcNM")), "UTF-8");
    String disPlayBizTypeNM   = URLDecoder.decode(String2.trimToEmpty(request.getParameter("disPlayBizTypeNM")), "UTF-8");
    String disPlaySlipFlagNM  = URLDecoder.decode(String2.trimToEmpty(request.getParameter("disPlaySlipFlagNM")), "UTF-8");
    String disPlayPumbunCD    = URLDecoder.decode(String2.trimToEmpty(request.getParameter("disPlayPumbunCD")), "UTF-8");
    String disPlayPumbunNM    = URLDecoder.decode(String2.trimToEmpty(request.getParameter("disPlayPumbunNM")), "UTF-8");

    System.out.println("strStrCd = " + strStrCd);
    System.out.println("strBumun = " + strBumun);
    System.out.println("strTeam = " + strTeam);
    System.out.println("strPc = " + strPc);
    System.out.println("strStartDt = " + strStartDt);  
    System.out.println("strEndDt = " + strEndDt);
    System.out.println("disPlayPumbunCD = " + disPlayPumbunCD);
    System.out.println("disPlayPumbunNM = " + disPlayPumbunNM);
    
    
    //odi 파라미터
    String[][] params  = new String[][]{
        {"STR_CD="            + strStrCd,     "STRBUMUN="             + strBumun,          "STRTEAM="            + strTeam,
         "STRPC="             + strPc,          
         "STRSTARTDT="        + strStartDt,   "STRENDDT="             + strEndDt,
         "DISPLAYSTRNM="      + disPlayStrNM, "DISPLAYBUMUNBN="       + disPlayBuMunNM,    "DISPLAYTEAMNM="      + disPlayTeamNM,
         "DISPLAYPCNM="       + disPlayPcNM,  "DISPLAYBIZTYPENM="     + disPlayBizTypeNM,  "DISPLAYSLIPFLAGNM="  + disPlaySlipFlagNM,
         "DISPLAYPUMBUNCD="   + disPlayPumbunCD,  "DISPLAYPUMBUNNM="  + disPlayPumbunNM}
    };
    
    //ozr파라미터
    String[][] formparams = new String[][]{
    };
%>
<%@ include file="/jsp/report.jsp"%>