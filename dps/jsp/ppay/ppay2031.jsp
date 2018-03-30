<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 대금지불 > 보류등록출력
 * 작 성 일 : 2013.01.09
 * 작 성 자 : 이성춘
 * 수 정 자 : 
 * 파 일 명 : ppay2031.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 보류등록 조회/출력
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
System.out.println("ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
    String dir = BaseProperty.get("context.common.dir");
    int ozReportCnt = 1;
    //print/preview
    String printMode  ="preview";
    //true/false
    String concatpage = "true";
    
    String reportname   = "공제등록";
    String strStrCd     = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strStrNm     = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strStrNm")), "UTF-8");
    String strYyyymm    = String2.trimToEmpty(request.getParameter("strYyyymm"));
    String strPayCyc    = String2.trimToEmpty(request.getParameter("strPayCyc"));
    String strPayCnt    = String2.trimToEmpty(request.getParameter("strPayCnt"));
    String strVenCd     = String2.trimToEmpty(request.getParameter("strVenCd"));
    String strVenNm     = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strVenNm")), "UTF-8");
    String strPumCd     = String2.trimToEmpty(request.getParameter("strPumCd"));
    String strPumNm     = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strPumNm")), "UTF-8");
    String strPayFlag_Cd= String2.trimToEmpty(request.getParameter("strPayFlag_Cd"));
    String strPayFlag_Nm= URLDecoder.decode(String2.trimToEmpty(request.getParameter("strPayFlag_Nm")), "UTF-8");
    
    
    System.out.println(strStrCd);
    System.out.println(strStrNm);
    System.out.println(strYyyymm);
    System.out.println(strPayCyc);
    System.out.println(strPayCnt);
    System.out.println(strVenCd);
    System.out.println(strVenNm);
    System.out.println(strPumCd);
    System.out.println(strPumNm);
    System.out.println(strPayFlag_Cd);
    System.out.println(strPayFlag_Nm);
    
    
    String[] reportodi   = new String[1];   
    String[] reportozr   = new String[1];
    
    
   	reportodi[0] =  "ppay2040";
    reportozr[0] =  "dps/ppay2040";
    
    
    
    //odi 파라미터
    String[][] params  = new String[][]{
        { "STR_CD="     + strStrCd
        , "STR_NM="     + strStrNm
        , "PAY_YM="     + strYyyymm
        , "PAY_CYC="    + strPayCyc
        , "PAY_CNT="    + strPayCnt
        , "VEN_CD="     + strVenCd 
        , "VEN_NM="     + strVenNm
        , "PUM_CD="     + strPumCd 
        , "PUM_NM="     + strPumNm
        , "strPayFlag_Cd="     + strPayFlag_Cd 
        , "strPayFlag_Nm="     + strPayFlag_Nm
        }
    };
    
    //ozr파라미터
    String[][] formparams = new String[][]{
    };
%>
<%@ include file="/jsp/report.jsp"%>
