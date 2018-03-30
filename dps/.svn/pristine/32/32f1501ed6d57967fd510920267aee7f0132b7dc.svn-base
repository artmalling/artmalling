<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 대금지불 > 대금지불명세서 조회/출력
 * 작 성 일 : 2010.05.25
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : psal9282.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 거래선별 매출 현황
 * 이    력 :
 * 
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo, 
                                                                       kr.fujitsu.ffw.base.BaseProperty, java.net.URLDecoder,
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
    
    String reportname   = "카드사별 매출 현황";
    String strStrNm     = String2.trimToEmpty(request.getParameter("strStrNm")); 
    String strStrCd     = String2.trimToEmpty(request.getParameter("strStrCd"));                                    
    String strSaleDtS   = String2.trimToEmpty(request.getParameter("strSaleDtS"));                                  
    String strSaleDtE   = String2.trimToEmpty(request.getParameter("strSaleDtE"));                                  
    String strCardsa    = String2.trimToEmpty(request.getParameter("strCardsa"));                                         
    String strBcomp     = String2.trimToEmpty(request.getParameter("strBcomp"));                                         
    String strPosFloor  = String2.trimToEmpty(request.getParameter("strPosFloor"));                                         
    String strPosFlag   = String2.trimToEmpty(request.getParameter("strPosFlag"));                                         
    String strPosNoS    = String2.trimToEmpty(request.getParameter("strPosNoS"));                                         
    String strPosNoE    = String2.trimToEmpty(request.getParameter("strPosNoE"));                                         

    System.out.println("strStrCd     = " + strStrCd);
    System.out.println("strSaleDtS   = " + strSaleDtS);
    System.out.println("strSaleDtE   = " + strSaleDtE);
    System.out.println("strCardsa    = " + strCardsa);
    System.out.println("strBcomp     = " + strBcomp);
    System.out.println("strPosFloor  = " + strPosFloor);
    System.out.println("strPosFlag   = " + strPosFlag);
    System.out.println("strPosNos    = " + strPosNoS);
    System.out.println("strPosNoE    = " + strPosNoE);
    
    String[] reportodi   = new String[1];   
    String[] reportozr   = new String[1];
    
	reportodi[0] =  "psal9282";
	reportozr[0] =  "dps/psal9282";
    
    
    //odi 파라미터
    
String[][] params  = new String[][]{
        { "STR_CD="     + strStrCd
        , "STR_NM="     + strStrNm	
        , "SALE_DT_S="  + strSaleDtS
        , "SALE_DT_E="  + strSaleDtE
        , "CARDSA="     + strCardsa
        , "BCOMP="      + strBcomp
        , "POS_FLOOR="  + strPosFloor
        , "POS_FLAG="   + strPosFlag
        , "POS_NO_S="   + strPosNoS
        , "POS_NO_E="   + strPosNoE
        }
    };
    
    //ozr파라미터
    String[][] formparams = new String[][]{
    };
%>
<%@ include file="/jsp/report.jsp"%>
