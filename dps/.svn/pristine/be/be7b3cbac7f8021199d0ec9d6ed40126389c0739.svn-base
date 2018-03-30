<!-- 
/*******************************************************************************
 * 시스템명 : 시스템명 : 영업관리 > 재고수불 > 실사재고조사표출력
 * 작 성 일 : 2010.04.25
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk2031.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 실사재고조사표출력
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
    //String url = "http://" + BaseProperty.get("ip") + ":" + BaseProperty.get("port") ;
    //String url = "http://localhost:81";
    String url = "http://" + BaseProperty.get("ip") + ":" + BaseProperty.get("port") ;
    int ozReportCnt = 1;
    //print/preview
    String printMode  ="preview";
    //true/false
    String concatpage = "true";
    
    String reportname  = "재고 조사표";
    
    String strStrCd     = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strStkYm     = String2.trimToEmpty(request.getParameter("strStkYm"));
    String strPumbunCd  = String2.trimToEmpty(request.getParameter("strPumbunCd"));
    String strPumbunName  = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strPumbunName")), "UTF-8");
    //String strPumbunName  = String2.trimToEmpty(request.getParameter("strPumbunName"));
    String strStkDt   = String2.trimToEmpty(request.getParameter("strStkDt"));
    String strOrgName   = URLDecoder.decode(String2.nvl(request.getParameter("strOrgName")), "UTF-8"); 
    //String strOrgName   = String2.trimToEmpty(request.getParameter("strOrgName")); 
    String strSkuType   = String2.trimToEmpty(request.getParameter("strSkuType"));  
    String strStkFlag   = URLDecoder.decode(String2.nvl(request.getParameter("strStkFlag")), "UTF-8"); 
    String odiFlag = "";
    String ozrFlag = "";

    if (strSkuType.equals("1")){ 
	    odiFlag = "pstk2030";
        ozrFlag = "dps/pstk2030"; 
    }else if (strSkuType.equals("2")){ 
        odiFlag = "pstk2031";
        ozrFlag = "dps/pstk2031"; 
    }else if (strSkuType.equals("3")){  	
        odiFlag = "pstk2032";
        ozrFlag = "dps/pstk2032"; 
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
          {"STR_CD=" + strStrCd, "STK_YM=" + strStkYm, "PUMBUN_CD=" + strPumbunCd, "PUMBUN_NAME="  + strPumbunName, "STK_DT=" + strStkDt, "ORG_NAME="  + strOrgName , "STK_FLAG="  + strStkFlag } 
    }; 
    //ozr파라미터
    String[][] formparams = new String[][]{     
    };
%>
<%@ include file="/jsp/report.jsp"%>

