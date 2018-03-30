<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽관리 > 포인트관리 > 부정적립예상통계조회 
 * 작  성  일  : 2010.05.02
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dmbo6111.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *          2010.05.02 (김영진) 신규작성
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
    //String url = "http://" + BaseProperty.get("oz.svr.ip"); //":" + BaseProperty.get("port");
    String url = "http://" + BaseProperty.get("oz.svr.ip") + ":" + BaseProperty.get("oz.svr.port"); //":" + BaseProperty.get("port");
    
    //String url = "http://localhost:81";
    int ozReportCnt = 1;
    //print/preview
    String printMode  ="preview";
    //true/false
    String concatpage = "true";
    String[] reportodi = new String[]{
          "dmbo6110"
    };
    String[] reportozr = new String[]{
          "dcs/dmbo6110"
    };
    String reportname = "부정적립 예상 통계 현황표";
    String strSdt  = String2.trimToEmpty(request.getParameter("strSdt"));
    String strEdt  = String2.trimToEmpty(request.getParameter("strEdt"));
    String strCnt  = String2.trimToEmpty(request.getParameter("strCnt"));
    String strAddPoint  = String2.trimToEmpty(request.getParameter("strAddPoint"));
    
    //if(strAddPoint.equals(""))
    //	strAddPoint = "-999999999";
    url = url + "/dcs/dmbo611.do?goTo=httpstore&strSdt="+strSdt+"&strEdt="+strEdt+"&strCnt="+strCnt+"&strAddPoint="+strAddPoint;

    //odi 파라미터
    String[][] params   = new String[][]{
        {"ADD_F_DT=" + strSdt, "ADD_T_DT="  + strEdt, "ADD_CNT="  + strCnt, "ADD_POINT="  + strAddPoint , "URL=" + url}
    };

    //ozr파라미터
    String[][] formparams = new String[][]{
    };
%>
<%@ include file="/jsp/report.jsp"%>
