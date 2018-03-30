<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 입/출고> 점내 불출신청-출력
 * 작 성 일 : 2011.05.06
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif2101.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2011.05.06 (김성미) 프로그램 작성
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
   String printMode  ="preview"; //프리뷰
    //String printMode  ="print"; // 바로 출력
    String concatpage = "true"; //출력후 화면 계속
    //String concatpage = "false"; // 출력후 화면 닫기
    String[] reportodi = new String[]{
            "mgif2100"
      };
      String[] reportozr = new String[]{
            "mss/mgif2100"
      };
    String reportname = "상품권 점내불출 신청서";
    
    String strStrCd = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strPourReqDt = String2.trimToEmpty(request.getParameter("strPourReqDt"));
    String strPourReqSlipNo = String2.trimToEmpty(request.getParameter("strPourReqSlipNo"));
    String strUserId = String2.trimToEmpty(request.getParameter("strUserId"));
    //odi 파라미터
    String[][] params  = new String[][]{
		   {"STR_CD=" + strStrCd, "POUT_REQ_DT="  + strPourReqDt, "POUT_REQ_SLIP_NO=" + strPourReqSlipNo, "USER_ID=" + strUserId}
		};

    //ozr파라미터
    String[][] formparams = new String[][]{
    };
%>
<%@ include file="/jsp/report.jsp"%>