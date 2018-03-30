<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 대금지불 > 대금지불명세서 조회/출력
 * 작 성 일 : 2010.05.25
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : psal5451.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 대금지불명세서 조회/출력
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
    
    String reportname   = "전자저널(영수증)";
    String strStrCd     = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strSaleDt    = String2.trimToEmpty(request.getParameter("strSaleDt"));
    String strPosNo    = String2.trimToEmpty(request.getParameter("strPosNo"));
    String strTranNo    = String2.trimToEmpty(request.getParameter("strTranNo"));

    System.out.println("strStrCd   = " + strStrCd);
    System.out.println("strSaleDt   = " + strSaleDt);
    System.out.println("strPosNo  = " + strPosNo);
    System.out.println("strTranNo  = " + strTranNo);
    
    String[] reportodi   = new String[1];   
    String[] reportozr   = new String[1];
    
    
    
    reportodi[0] =  "psal5301";
    reportozr[0] =  "dps/psal5301";
    
    
    //odi 파라미터
    String[][] params  = new String[][]{
        { "STR_CD="     + strStrCd
        , "SALE_DT="  + strSaleDt
        , "POS_NO="   + strPosNo
        , "TRAN_NO="  + strTranNo}
    };
    
    //ozr파라미터
    String[][] formparams = new String[][]{
    };
%>
<%@ include file="/jsp/report.jsp"%>
