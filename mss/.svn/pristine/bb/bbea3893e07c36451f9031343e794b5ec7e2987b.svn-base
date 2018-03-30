<%
/*******************************************************************************
  *****************************************************************************/
%>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="common.vo.SessionInfo" %>
<%@ page import="common.util.Util"  %>
<%@ page import="kr.fujitsu.ffw.base.BaseProperty"  %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c-rt.tld" %>
<%@ taglib prefix="ajax" uri="/WEB-INF/tld/ajax-lib.tld"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>  
<%
/****************** 세션 서브시스템 셋팅 *****************/
/*
if (sessionInfo != null) 
{
    if(request.getParameter("subsystem") != null && !"".equals(request.getParameter("subsystem")))
        sessionInfo.setSUB_SYS(request.getParameter("subsystem"));
}*/
%>
<ajax:library />
<%String dir = BaseProperty.get("context.common.dir");%>
<HTML>
<HEAD>
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
</HEAD>
<meta http-equiv="Content-Type" content="text/html;charset=euc-kr">
<script language="javascript"  src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/common_dps.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/ajax.js"    type="text/javascript"></script>


<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">


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
      <td colspan="3">
          <!-- sub_System 수정-->
          <!-- 백화점 P, 경영지원  M, 디큐브카드 D, 문화센터C, 포탈(시스템관리)T -->
          <c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'P'}">
              <img src="/<%=dir%>/imgs/comm/left_title01.gif" width="173" height="42" />
          </c:if>
          <c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'M'}">
              <img src="/<%=dir%>/imgs/comm/left_title02.gif" width="173" height="42" />
          </c:if>
          <c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'D'}">
              <img src="/<%=dir%>/imgs/comm/left_title03.gif" width="173" height="42" />
          </c:if>
          <c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'C'}">
              <img src="/<%=dir%>/imgs/comm/left_title04.gif" width="173" height="42" />
          </c:if>
          <c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'T'}">
              <img src="/<%=dir%>/imgs/comm/left_title05.gif" width="173" height="42" />
          </c:if>
        </td>
      </tr>
</table>

  </form>
    
