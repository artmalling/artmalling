<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 포인트정산 > 월별포인트 잔액관리 출력
 * 작  성  일  : 2010.05.02
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dmtc6031.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.05.02 (김영진) 신규작성
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
    String dir = BaseProperty.get("context.common.dir");
    int ozReportCnt = 1;
    //print/preview
    String printMode  ="preview";
    //true/false
    String concatpage = "true";
    String[] reportodi = new String[]{
          "dmtc6030"
    };
    String[] reportozr = new String[]{
          "dcs/dmtc6030"
    };

    String reportname = "월별포인트 잔액 현황표";
    String strSumSMonth = String2.trimToEmpty(request.getParameter("strSumSMonth"));
    String strBrchId    = String2.trimToEmpty(request.getParameter("strBrchId"));
    
    //odi 파라미터
    String[][] params  = new String[][]{
        {"BRCH_ID=" + strBrchId, "SUM_YM="  + strSumSMonth}
    };

    //ozr파라미터
    String[][] formparams = new String[][]{
    };
%>
<%@ include file="/jsp/report.jsp"%>
