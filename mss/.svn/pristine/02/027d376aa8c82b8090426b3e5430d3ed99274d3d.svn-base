<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 마스터 관리> 발행의뢰(인쇄업체)-출력
 * 작 성 일 : 2011.04.20
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif1071.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2011.04.20 (김성미) 프로그램 작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo, 
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.*,
                                                                       java.text.SimpleDateFormat,
                                                                       java.util.Date,
                                                                       java.util.Locale"%>
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
    int ozReportCnt = 1;
    String printMode  ="preview";
    String concatpage = "true";
    String[] reportodi = new String[]{
            "mgif1070"
      };
      String[] reportozr = new String[]{
            "mss/mgif1070"
      };
    String reportname = "상품권 발행 신청서";
    
    String strReqDt = String2.trimToEmpty(request.getParameter("strReqDt"));
    String strStrCd = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strReqSlipNo = String2.trimToEmpty(request.getParameter("strReqSlipNo"));
    String strParamCnt = String2.trimToEmpty(request.getParameter("strParamCnt"));
    SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy/MM/dd", Locale.KOREA );
    SimpleDateFormat formatter1 = new SimpleDateFormat ( "HH:mm:ss", Locale.KOREA );
    Date currentTime = new Date ( );
    String strDay = formatter.format ( currentTime );
    String strTime = formatter1.format ( currentTime );
    //odi 파라미터
    String[][] params  = new String[][]{
		   {"REQ_DT=" + strReqDt, "STR_CD="  + strStrCd, "REQ_SLIP_NO=" + strReqSlipNo, "PARAM_CNT=" + strParamCnt}
		};

    //ozr파라미터
    String[][] formparams = new String[][]{
    		{"TODAY=" + strDay, "TIME="  + strTime}
    };
%>
<%@ include file="/jsp/report.jsp"%>
