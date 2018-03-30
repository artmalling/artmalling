<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > POS정산
 * 작 성 일 : 2010.06.08
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal5011.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : POS별 정산/마감현황
 * 이    력 :2010.06.08 박종은
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

    //String url = "http://" + BaseProperty.get("ip") + ":" + BaseProperty.get("port") ;
    int ozReportCnt = 1;

    String printMode  ="preview";

    String concatpage = "true";
    String reportname    = "POS별 정산/마감현황";
   
    
    String strStrCd      = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strPosFloor   = String2.trimToEmpty(request.getParameter("strPosFloor"));
    String strPosFlag    = String2.trimToEmpty(request.getParameter("strPosFlag"));
    String strPosNoS     = String2.trimToEmpty(request.getParameter("strPosNoS"));
    String strPosNoE     = String2.trimToEmpty(request.getParameter("strPosNoE"));
    String strSaleDtS    = String2.trimToEmpty(request.getParameter("strSaleDtS"));
    //String strGbn        = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strGbn")), "UTF-8");
    String strGbn    = String2.trimToEmpty(request.getParameter("strGbn"));
    String strUserId     = String2.trimToEmpty(request.getParameter("strUserId"));
    //String strStrCdN     = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strStrCdN")), "UTF-8");
    //String strPosFloorN  = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strPosFloorN")), "UTF-8");
    //String strPosFlagN   = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strPosFlagN")), "UTF-8");
    String strStrCdN    = String2.trimToEmpty(request.getParameter("strStrCdN"));
    String strPosFloorN    = String2.trimToEmpty(request.getParameter("strPosFloorN"));
    String strPosFlagN    = String2.trimToEmpty(request.getParameter("strPosFlagN"));
    
    String[] reportodi = new String[]{
            "psal5011"
    };
    String[] reportozr = new String[]{
            "dps/psal5011"
    };
    
    if(strGbn.equals("POS")){
    	reportodi[0] = "psal5011";
    	reportozr[0] = "dps/psal5011";
    }
    else{
    	reportodi[0] = "psal5012";
        reportozr[0] = "dps/psal5012";
    }
    
    String[][] params  = new String[][]{
              { "STR_CD="        + strStrCd        
              , "SALE_DT="       + strSaleDtS        
              , "FLAG="          + strGbn
              , "FLOOR="         + strPosFloor     
              , "POS_FLAG="      + strPosFlag        
              , "POS_NO_S="      + strPosNoS
              , "POS_NO_E="      + strPosNoE       
              , "STR_NAME="       + strStrCdN         
              , "FLOOR_NAME="     + strPosFloorN
              , "POS_FLAG_NAME="  + strPosFlagN     
              , "USER_ID="        + strUserId
              }
             

    }; 

    //ozr파라미터
    String[][] formparams = new String[][]{ 
    
    };
    
%>
<%@ include file="/jsp/report.jsp"%>

