<!-- 
/*******************************************************************************
 * 시스템명 : 시스템명 : 영업관리 > 재고수불 > 조직별재고조사집계표출력
 * 작 성 일 : 2010.05.23
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk2101.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 실사재고 후 조사한 내역을 조직별로 집계 출력
 * 이    력 :
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
    
    String reportname  = "월수불장현황";
    
    String strStrCd      = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strOrgNm      = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strOrgNm")), "UTF-8");
    String strDeptCd     = String2.trimToEmpty(request.getParameter("strDeptCd"));
    String strTeamCd     = String2.trimToEmpty(request.getParameter("strTeamCd"));
    String strPcCd       = String2.trimToEmpty(request.getParameter("strPcCd"));    
    String strStkYm      = String2.trimToEmpty(request.getParameter("strStkYm"));
    String strTaxFlag    = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strTaxFlag")), "UTF-8");
    
    String strTaxFlagCode = String2.trimToEmpty(request.getParameter("strTaxFlagCode"));
    String strPumbunCd   = String2.trimToEmpty(request.getParameter("strPumbunCd"));
    String strPumbunNm   = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strPumbunNm")), "UTF-8");
    
    String odiFlag = "";
    String ozrFlag = ""; 
   
    if (strTaxFlagCode.equals("A")){ 
        odiFlag = "pstk3030";
        ozrFlag = "dps/pstk3030"; 
    }else if (strTaxFlagCode.equals("B")){ 
        odiFlag = "pstk3031";
        ozrFlag = "dps/pstk3031"; 
    }
        
    String[] reportodi = new String[]{
            odiFlag
    };
    String[] reportozr = new String[]{
            ozrFlag
    };
    
//    url = url + "/dps/pstk203.pt?goTo=httpstore&strStrCd="+strStrCd+"&strStkYm="+strStkYm+"&strPumbunCd="+strPumbunCd+"&strPumbunName="+strPumbunName+"&strStkDt="+strStkDt+"&strOrgName="+strOrgName ;
    //odi 파라미터
    String[][] params  = new String[][]{
          {"STR_CD=" + strStrCd
        	  , "ORG_NM=" + strOrgNm
        	  , "DEPT_CD=" + strDeptCd        	  
        	  , "TEAM_CD=" + strTeamCd
        	  , "PC_CD=" + strPcCd        	  
        	  , "STK_YM=" + strStkYm
              , "TAX_FLAG=" + strTaxFlag
              , "PUMBUN_CD=" + strPumbunCd
              , "PUMBUN_NAME" + strPumbunNm} 
    }; 
    //ozr파라미터
    String[][] formparams = new String[][]{ 
    
    };
%>
<%@ include file="/jsp/report.jsp"%>

