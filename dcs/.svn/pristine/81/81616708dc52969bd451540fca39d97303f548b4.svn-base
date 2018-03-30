<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > >멤버쉽 운영 > 승인처리  > 포인트 강제처리 현황표 출력
 * 작  성  일  : 2010.05.03
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dmbo6051.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.05.03 (김영진) 신규작성
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
    //String url = "http://" + BaseProperty.get("ip") + ":" + BaseProperty.get("port");
    String url = "http://" + BaseProperty.get("oz.svr.ip") + ":" + BaseProperty.get("oz.svr.port"); //":" + BaseProperty.get("port");
    
    //String url = "http://localhost:81";
    int ozReportCnt = 1;
    //print/preview
    String printMode  ="preview";
    //true/false
    String concatpage = "true";
    String[] reportodi = new String[]{
          "dmbo6050"
    };
    String[] reportozr = new String[]{
          "dcs/dmbo6050"
    };
    String reportname = "포인트 강제처리 현황표";
    String strBrchCd  = String2.trimToEmpty(request.getParameter("strBrchCd"));
    String strProrDt_f = String2.trimToEmpty(request.getParameter("strProrDt_f"));
    String strProrDt_t = String2.trimToEmpty(request.getParameter("strProrDt_t"));
    
    url = url + "/dcs/dmbo605.do?goTo=httpstore&strBrchCd="+strBrchCd+"&strProrDt_f="+strProrDt_f+"&strProrDt_t="+strProrDt_t;

    //odi 파라미터
    String[][] params   = new String[][]{
        {"BRCH_ID=" + strBrchCd, "PROC_S_DT="  + strProrDt_f, "PROC_E_DT="  + strProrDt_t, "URL=" + url}
    };

    //ozr파라미터
    String[][] formparams = new String[][]{
    };
%>
<%@ include file="/jsp/report.jsp"%>
