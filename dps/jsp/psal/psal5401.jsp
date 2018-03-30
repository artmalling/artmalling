<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 대금지불 > 대금지불명세서 조회/출력
 * 작 성 일 : 2010.05.25
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : psal4581.jsp
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
    
    String reportname   = "거래선별 매출 현황";
    String strStrCd     = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strSaleDtS   = String2.trimToEmpty(request.getParameter("strSaleDtS"));
    String strSaleDtE   = String2.trimToEmpty(request.getParameter("strSaleDtE"));
    String strGubun     = String2.trimToEmpty(request.getParameter("strGubun"));
    
    System.out.println("strStrCd     = " + strStrCd);
    System.out.println("strSaleDtS   = " + strSaleDtS);
    System.out.println("strSaleDtE   = " + strSaleDtE);
    System.out.println("strGubun     = " +strGubun);
    String[] reportodi   = new String[1];   
    String[] reportozr   = new String[1];
    
    
    if(strGubun.equals("1")){
	    reportodi[0] =  "psal5401";
	    reportozr[0] =  "dps/psal5401";
    	
    }else if(strGubun.equals("2")){
    	reportodi[0] =  "psal5402";
	    reportozr[0] =  "dps/psal5402";
    }else if(strGubun.equals("3")){
    	reportodi[0] =  "psal5403";
	    reportozr[0] =  "dps/psal5403";
    }else if(strGubun.equals("4")){
    	reportodi[0] =  "psal5404";
	    reportozr[0] =  "dps/psal5404";
    } 
    
    
    //odi 파라미터
    String[][] params  = new String[][]{
        { "STR_CD="     + strStrCd
        , "SALE_DT_S="  + strSaleDtS
        , "SALE_DT_E="  + strSaleDtE}
    };
    
    //ozr파라미터
    String[][] formparams = new String[][]{
    };
%>
<script>
    var g_showFlag = false; // 자동팝업창의 닫힘의 유무를 위함
</script>
<%@ include file="/jsp/report.jsp"%>
