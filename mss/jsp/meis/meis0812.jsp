<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 실적요약> 주간 TREND 현황
 * 작 성 일 : 2011.06.21
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0812.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 주간 매출 트렌드 및 고객 현황을 출력
 * 이    력 :
 *        2011.06.21 (이정식) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo, 
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
    String dir      = BaseProperty.get("context.common.dir");
    String filePath = BaseProperty.get("mss.upload.http") + "chartimg/";
    String strUsrId = Util.getUserId(request);
    int ozReportCnt = 1;
    //print/preview
    String printMode  ="preview";
    //true/false
    String concatpage = "true";
    String[] reportodi = new String[]{
          "meis0810"
    };
    String[] reportozr = new String[]{
          "mss/meis0810"
    };
    
    String reportname    = "주간 경영실적 보고서";
    String strStrCd      = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strSaleDt     = String2.trimToEmpty(request.getParameter("strSaleDt"));
    String strFileName   = String2.trimToEmpty(request.getParameter("strFileName"));
    String strStartDt    = null;
    String strSaleMon    = null;
    String strLstMon     = null; 
    String strLstDt      = null;
    String strLstStartDt = null;
    String strSaleYear   = null;
    String strLstYear    = null;
    String imgUrl1       = filePath + strFileName + "_1.png";
    String imgUrl2       = filePath + strFileName + "_2.png";
    
    strSaleMon  = strSaleDt.substring(0, 6);
    strSaleYear = strSaleDt.substring(0, 4);
    strLstMon   = Util.addYear(strSaleMon+"01", -1, "yyyyMM");
    strStartDt  = Util.addDay(strSaleDt, -6, "yyyyMMdd");
    if(!strSaleMon.equals(strStartDt.substring(0, 6))){
        strStartDt = strSaleMon +"01";
    }
    strLstDt      = Util.addYear(strSaleDt, -1, "yyyyMMdd");
    strLstStartDt = Util.addYear(strStartDt, -1, "yyyyMMdd");
    strLstYear    = Util.addYear(strSaleDt, -1, "yyyy");
    
    //odi 파라미터
    String[][] params  = new String[][]{
        { "STR_CD="       + strStrCd,      "START_DT="  + strStartDt,  "SALE_DT="  + strSaleDt
        , "LST_START_DT=" + strLstStartDt, "LST_DT="    + strLstDt,    "SALE_MON=" + strSaleMon
        , "LST_MON="      + strLstMon,     "SALE_YEAR=" + strSaleYear, "LST_YEAR=" + strLstYear
        , "USER_ID="      + strUsrId}
    };    

    //ozr파라미터
    String[][] formparams = new String[][]{
        {"CHART_IMG_URL1=" + imgUrl1, "CHART_IMG_URL2=" + imgUrl2}
    };
%>
<%@ include file="/jsp/report.jsp"%>
