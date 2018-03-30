<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽 운영 > 기준정보  > 적립율등록 출력
 * 작  성  일  : 2010.04.21
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dmbo1012.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.04.21 (김영진) 신규작성
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
          "dmbo1010"
    };
    String[] reportozr = new String[]{
          "dcs/dmbo1010"
    };
    
    String reportname = "포인트 적립율 현황표";
    String strBrchId  = String2.trimToEmpty(request.getParameter("strBrchId"));
    String strPayType = String2.trimToEmpty(request.getParameter("strPayType"));
    String strAppSDt  = String2.trimToEmpty(request.getParameter("strAppSDt"));
    
    //odi 파라미터
    String[][] params  = new String[][]{
        {"BRCH_ID=" + strBrchId, "PAY_TYPE_CD="  + strPayType, "APP_S_DT=" + strAppSDt}
    };    

    //ozr파라미터
    String[][] formparams = new String[][]{
        {"APP_S_DT=" + strAppSDt, "PAY_TYPE_CD="  + strPayType, "APP_S_DT=" + strAppSDt}
    };
    
%>
<%@ include file="/jsp/report.jsp"%>

