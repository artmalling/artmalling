<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > POS 정산 > 매출금 집계표
 * 작 성 일 : 2012.06.27
 * 작 성 자 : DHL
 * 수 정 자 : 
 * 파 일 명 : psal5441.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2012.06.27 DHL  신규작성
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
          "psal5440"
    };
    String[] reportozr = new String[]{
          "dps/psal5440"
    };

    String reportname = "매출금집계표";
    String strStrCd = String2.trimToEmpty(request.getParameter("strStrCd"));
    //String strStrNm = String2.trimToEmpty(request.getParameter("strStrNm"));
    String strSaleDtS = String2.trimToEmpty(request.getParameter("strSaleDtS"));
    String strSaleDtE = String2.trimToEmpty(request.getParameter("strSaleDtE"));
    String strPosNo  = String2.trimToEmpty(request.getParameter("strPosNo"));
    String strHallCd  = String2.trimToEmpty(request.getParameter("strHallCd"));
    
    //odi 파라미터
    String[][] params  = new String[][]{
        //{"STR_CD=" + strStrCd, "STR_NM=" + strStrNm, "SALE_S_DT=" + strSaleDtS, "SALE_E_DT=" + strSaleDtE, "POS_NO=" + strPosNo}
        {"STR_CD=" + strStrCd, "SALE_S_DT=" + strSaleDtS, "SALE_E_DT=" + strSaleDtE, "POS_NO=" + strPosNo, "HALL_CD=" + strHallCd}
    };
    //ozr파라미터
    String[][] formparams = new String[][]{
    };
%>
<script>
    var g_showFlag = false; // 자동팝업창의 닫힘의 유무를 위함
</script>
<%@ include file="/jsp/report.jsp"%>
