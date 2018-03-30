<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권판매/회수 > 상품권 판매 내역조회 - 출력
 * 작 성 일 : 2011.04.20
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif1121.jsp
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
    
    String[] reportodi = new String[]{
            "mgif4090"
      };
      String[] reportozr = new String[]{
            "mss/mgif4090"
      };
    String reportname = "상품권재고조회(재무)";
  
    String strSTR_CD = String2.trimToEmpty(request.getParameter("STR_CD"));
    String strSTK_S_DT = String2.trimToEmpty(request.getParameter("STK_S_DT"));
    String strSTK_E_DT = String2.trimToEmpty(request.getParameter("STK_E_DT"));
    String strGIFT_TYPE_CD = String2.trimToEmpty(request.getParameter("GIFT_TYPE_CD"));
    String strGIFT_AMT_TYPE = String2.trimToEmpty(request.getParameter("GIFT_AMT_TYPE"));
    
    
    SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy/MM/dd", Locale.KOREA );
    SimpleDateFormat formatter1 = new SimpleDateFormat ( "HH:mm:ss", Locale.KOREA );
    Date currentTime = new Date ( );
    String strDay = formatter.format ( currentTime );
    String strTime = formatter1.format ( currentTime );
    //odi 파라미터
    String[][] params  = new String[][]{
		   {"STR_CD=" + strSTR_CD, "STK_S_DT=" + strSTK_S_DT,"STK_E_DT=" + strSTK_E_DT, "GIFT_TYPE_CD=" + strGIFT_TYPE_CD, "GIFT_AMT_TYPE=" + strGIFT_AMT_TYPE}
		};

    //ozr파라미터
    String[][] formparams = new String[][]{
    		{"TODAY=" + strDay, "TIME="  + strTime}
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
