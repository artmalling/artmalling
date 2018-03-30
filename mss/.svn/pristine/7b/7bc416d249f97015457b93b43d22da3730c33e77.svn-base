<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상품권관리 > 상품권 입/출고 > 점내 불출 내역 조회 - 출력
 * 작 성 일 : 2011.04.20
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif3181.jsp
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
    String printMode  ="preview"; //프리뷰
    //String printMode  ="print"; // 바로 출력
    String concatpage = "true"; //출력후 화면 계속
    //String concatpage = "false"; // 출력후 화면 닫기
    
    /*
    String[] reportodi = new String[]{
          "mgif3180"
    };
    String[] reportozr = new String[]{
          "mss/mgif3180"
    };
    */
    String[] reportodi = new String[]{
          "mgif3181"
    };
    String[] reportozr = new String[]{
          "mss/mgif3181"
    };  
    String reportname = "상품권 불출 명세서";

    String strStrCd = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strReqYmdFrom = String2.trimToEmpty(request.getParameter("strReqYmdFrom"));
    String strReqYmdTo = String2.trimToEmpty(request.getParameter("strReqYmdTo"));
    String strPoutType = String2.trimToEmpty(request.getParameter("strPoutType"));
    String strPoutFlag = String2.trimToEmpty(request.getParameter("strPoutFlag"));
    String strVenCd = String2.trimToEmpty(request.getParameter("strVenCd"));    

    //odi 파라미터
    String[][] params  = new String[][]{
        {"STR_CD=" + strStrCd, "SALE_S_YMD=" + strReqYmdFrom, "SALE_E_YMD=" + strReqYmdTo, 
        	"POUT_FLAG=" + strPoutType, "POUT_TYPE=" + strPoutFlag, "EVENT_CD=" + strVenCd}
    };

    //ozr파라미터
    String[][] formparams = new String[][]{
    };
%>
<script>
    //var g_showFlag = true; // 자동팝업창의 닫힘의 유무를 위함
var g_showFlag = false; // 자동팝업창의 닫힘의 유무를 위함(미리보기)
</script>

<%@ include file="/jsp/report.jsp"%>

<%
//out.println("<script>window.close();</script>");
%>
