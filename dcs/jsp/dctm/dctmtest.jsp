<%
/*******************************************************************************
  *****************************************************************************/
%>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="common.vo.SessionInfo" %>
<%@ page import="common.util.Util"  %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c-rt.tld" %>
<%@ taglib prefix="ajax" uri="/WEB-INF/tld/ajax-lib.tld"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>
<%
/****************** 세션 서브시스템 셋팅 *****************/

SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
if (sessionInfo != null) 
{
    if(request.getParameter("subsystem") != null && !"".equals(request.getParameter("subsystem")))
        sessionInfo.setSUB_SYS(request.getParameter("subsystem"));
}

/*
SessionInfo user2 = new SessionInfo();
user2 =(SessionInfo) session.getAttribute("sessionInfo");
                System.out.println(">>>>>>>>>>>>>>. : " + user2.getUSER_NAME());
                
*/
/*
System.out.println(">asdfghj<>>>>>>>>>>>>>>>>> " + request.getAttribute("sample2"));
System.out.println(">>>>>>>>>>>>><<<<>>>>>>>>>>>>>>>>> " + session.getAttribute("test"));
System.out.println(">>>>>>>>>>>><<<<<<>>>>>>>>>>>>>>>>>>>>>>>> " + session.getAttribute("sample"));
//HttpSession session = request.getSession();
System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> + " + request.getSession().getAttribute("sessionInfo"));
//SessionInfo sessionInfo = (SessionInfo)request.getSession().getAttribute("sessionInfo");
System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
*/
/*
if (sessionInfo != null) 
{
    if(request.getParameter("subsystem") != null && !"".equals(request.getParameter("subsystem")))
        sessionInfo.setSUB_SYS(request.getParameter("subsystem"));
}*/
%>
<ajax:library />
<HTML>
<HEAD>
<link rel="stylesheet" href="/dcs/css/mds.css" type="text/css">
</HEAD>
<meta http-equiv="Content-Type" content="text/html;charset=euc-kr">
<link href="/dcs/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/dcs/js/common.js"  type="text/javascript"></script>
<script language="javascript"  src="/dcs/js/gauce.js"   type="text/javascript"></script>
<script language="javascript"  src="/dcs/js/global.js"  type="text/javascript"></script>
<script language="javascript"  src="/dcs/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/dcs/js/ajax.js"    type="text/javascript"></script>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">

var subSystem = '<c:out value="${sessionScope.sessionInfo.SUB_SYS}" />';     // login 주업무 영역
var isAllMenu = '<c:out value="${sessionScope.isAllMenu}" />';                  // 전체 권한을 가진 사용자
alert("USER : " + '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />');

</script>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                            *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                    *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리    끝                                                *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                    *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* E. 본문시작                                                            *-->
<!--*************************************************************************-->
<BODY onLoad="">
<table width="178" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="3"><%= sessionInfo.getUSER_NAME() %>
      <!-- sub_System 수정-->
      <!-- 백화점 P, 경영지원  M, 포인트카드 D, 문화센터C, 포탈(시스템관리)T -->
      <c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'P'}"> <img src="/dcs/imgs/comm/left_title01.gif" width="173" height="42" /> </c:if>
      <c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'M'}"> <img src="/dcs/imgs/comm/left_title02.gif" width="173" height="42" /> </c:if>
      <c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'D'}"> <img src="/dcs/imgs/comm/left_title03.gif" width="173" height="42" /> </c:if>
      <c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'C'}"> <img src="/dcs/imgs/comm/left_title04.gif" width="173" height="42" /> </c:if>
      <c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'T'}"> <img src="/dcs/imgs/comm/left_title05.gif" width="173" height="42" /> </c:if></td>
  </tr>
</table>
</form>
