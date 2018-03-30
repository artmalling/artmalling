<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 경영보고> 일매출현황
 * 작  성  일  : 2012.06.25
 * 작  성  자  : kj
 * 수  정  자  : 
 * 파  일  명  : meis2201.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2012.06.25 (kj) 신규작성
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
<%
    String dir = BaseProperty.get("context.common.dir");
    int ozReportCnt = 1;
    //print/preview
    String printMode  ="preview";
    //true/false
    String concatpage = "true";
    String[] reportodi = new String[]{
          "meis2200"
    };
    String[] reportozr = new String[]{
          "mss/meis2200"
    };

    String reportname = "일매출현황";
    String strStrCd = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strSaleYmd = String2.trimToEmpty(request.getParameter("strSaleYmd"));

    //odi 파라미터
    String[][] params  = new String[][]{
        {"STR_CD=" + strStrCd, "SALE_YMD=" + strSaleYmd}
    };

    //ozr파라미터
    String[][] formparams = new String[][]{
    };
%>
<script>
    var g_showFlag = false; // 자동팝업창의 닫힘의 유무를 위함
</script>
<%@ include file="/jsp/report.jsp"%>
