<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 대금지불 > 대금지불명세서 조회/출력
 * 작 성 일 : 2010.05.25
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : ppay3121.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 대금지불명세서(보고용) 조회/출력
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
    
    String reportname   = "대금지불명세서(직매입)";
    String strStrCd     = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strStrNm     = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strStrNm")), "UTF-8");
    String strYyyymm    = String2.trimToEmpty(request.getParameter("strYyyymm"));
    String strPayCyc    = String2.trimToEmpty(request.getParameter("strPayCyc"));
    String strPayCnt    = String2.trimToEmpty(request.getParameter("strPayCnt"));
    String strPayDt     = String2.trimToEmpty(request.getParameter("strPayDt"));
    String strPayDtNm   = String2.trimToEmpty(request.getParameter("strPayDtNm"));
    String strBizType   = String2.trimToEmpty(request.getParameter("strBizType"));
    String strVenCd     = String2.trimToEmpty(request.getParameter("strVenCd"));
    String strVenNm     = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strVenNm")), "UTF-8");
    String strPumCd     = String2.trimToEmpty(request.getParameter("strPumCd"));
    String strPumNm     = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strPumNm")), "UTF-8");
    String strPayInfo   = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strPayInfo")), "UTF-8");

    System.out.println("strStrCd   = " + strStrCd);
    System.out.println("strStrNm   = " + strStrNm);
    System.out.println("strYyyymm  = " + strYyyymm);
    System.out.println("strPayCyc  = " + strPayCyc);
    System.out.println("strPayCnt  = " + strPayCnt);
    System.out.println("strBizType = " + strBizType);
    System.out.println("strVenCd   = " + strVenCd);
    System.out.println("strVenNm   = " + strVenNm);
    System.out.println("strPumCd   = " + strPumCd);
    System.out.println("strPumNm   = " + strPumNm);
    System.out.println("strPayInfo = " + strPayInfo);
    
    String[] reportodi   = new String[1];   
    String[] reportozr   = new String[1];
    
    
    if("1".equals(strBizType)){
    	reportodi[0] =  "ppay3120";
        reportozr[0] =  "dps/ppay3120";
    }else if("2".equals(strBizType)){
    	reportodi[0] =  "ppay3121";
        reportozr[0] =  "dps/ppay3121";
    }else{
    	reportodi[0] =  "ppay3122";
        reportozr[0] =  "dps/ppay3122";
    }
    
    
    //odi 파라미터
    String[][] params  = new String[][]{
        { "STR_CD="     + strStrCd
        , "STR_NM="     + strStrNm
        , "PAY_YM="     + strYyyymm
        , "PAY_CYC="    + strPayCyc
        , "PAY_CNT="    + strPayCnt
        , "PAY_DT="     + strPayDt
        , "PAY_DT_NM="  + strPayDtNm
        , "BIZ_TYPE="   + strBizType
        , "VEN_CD="     + strVenCd 
        , "VEN_NM="     + strVenNm
        , "PUM_CD="     + strPumCd 
        , "PUM_NM="     + strPumNm
        , "PAY_INFO="   + strPayInfo}
    };
    
    //ozr파라미터
    String[][] formparams = new String[][]{
    };
%>
<%@ include file="/jsp/report.jsp"%>
