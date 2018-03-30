<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 경영실적> 경영실적보고서조회
 * 작 성 일 : 2011.07.18
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0725.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 경영실적보고서를 출력한다.
 * 이    력 :
 *        2011.07.18 (이정식) 신규작성
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
    String dir           = BaseProperty.get("context.common.dir");
    String filePath      = BaseProperty.get("mss.upload.http") + "chartimg/";
    String strFileName   = String2.trimToEmpty(request.getAttribute("strFileName").toString());
    String imgUrl1       = filePath + strFileName + "_1.png";
    String imgUrl2       = filePath + strFileName + "_2.png";
    String imgUrl3       = filePath + strFileName + "_3.png";
    String imgUrl4       = filePath + strFileName + "_4.png";
    String imgUrl5       = filePath + strFileName + "_5.png";
    String imgUrl6       = filePath + strFileName + "_6.png";
    String imgUrl7       = filePath + strFileName + "_7.png";
    String imgUrl8       = filePath + strFileName + "_8.png";
    String imgUrl9       = filePath + strFileName + "_9.png";
    String strStrCd      = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strStrNm      = String2.trimToEmpty(request.getParameter("ORG_NAME"));
    String strRsltYear   = String2.trimToEmpty(request.getParameter("strRsltYm")).substring(0, 4);
    String strRsltMon1   = "01";
    String strRsltMon2   = String2.trimToEmpty(request.getParameter("strRsltYm")).substring(4, 6);
    String strSumGb      = String2.trimToEmpty(request.getParameter("strSumGb"));
    if(strSumGb.equals("2")) {
    	strSumGb    = "누계";
    } else {
    	strRsltMon1 = strRsltMon2;
    	strSumGb    = "";
    }
    int ozReportCnt = 1;
    //print/preview
    String printMode  ="preview";
    //true/false
    String concatpage = "true";
    String[] reportodi = new String[]{
          "meis0720"
    };
    String[] reportozr = new String[]{
          "mss/meis0720"
    };
    
    String reportname    = "경영실적보고서";
    
    //odi 파라미터
    String[][] params  = new String[][]{
        { "STR_CD="   + strStrCd,    "STR_NM=" + strStrNm,    "RSLT_YM=" + strRsltYear
        , "FROM_MON=" + strRsltMon1, "TO_MON=" + strRsltMon2, "SUM_GB="  + strSumGb   }
    };    

    //ozr파라미터
    String[][] formparams = new String[][]{
        { "CHART_IMG_URL1=" + imgUrl1, "CHART_IMG_URL2=" + imgUrl2
        , "CHART_IMG_URL3=" + imgUrl3, "CHART_IMG_URL4=" + imgUrl4
        , "CHART_IMG_URL5=" + imgUrl5, "CHART_IMG_URL6=" + imgUrl6
        , "CHART_IMG_URL7=" + imgUrl7, "CHART_IMG_URL8=" + imgUrl8
        , "CHART_IMG_URL9=" + imgUrl9}
    };
%>
<%@ include file="/jsp/report.jsp"%>
