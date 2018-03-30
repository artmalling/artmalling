<%
/*******************************************************************************
  * 시스템명 : 마리오아울렛 통합정보시스템 공통 
  * 작 성 일 : 2010.12.12 
  * 작 성 자 : 정지인
  * 수 정 자 :
  * 파 일 명 : left.jsp
  * 버    전 : 1.0
  * 개    요 : 좌측 메뉴 구성
  * 이    력 : 
  *****************************************************************************/
%>
<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%
    request.setCharacterEncoding("utf-8"); 
    String dir = request.getContextPath();
%>
<%@ page import="ecom.vo.SessionInfo2,ecom.util.Util,java.util.Properties"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>
<%


/****************** 세션 서브메뉴 셋팅 *****************/
SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
if (sessionInfo != null) 
{
    if(request.getParameter("submenu") != null && !"".equals(request.getParameter("submenu")))
        sessionInfo.setSUB_MENU(request.getParameter("submenu")); 
}
 
%>
<ajax:library />
<HTML>
<HEAD>
</HEAD>
<meta http-equiv="pragma" content="no-cache">  
<link href="<%=dir%>/css/ds.css" rel="stylesheet" type="text/css" />
<script language="javascript"  src="<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/popup.js"  type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/global.js"    type="text/javascript"></script>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var subSystem = '<c:out value="${sessionScope.sessionInfo2.SUB_MENU}" />';     // login 주업무 영역 

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/    
/**
* doInit()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-07
* 개    요 : 화면이 처음 로딩될때 호출되는 영역 입니다.
* return값 : void
*/
function doInit(){
    //메뉴 보여주기 
    
 /*   if(strGb == "@") {
    	subSystem = "EORD";
    }*/
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
    
function urlLink(txt, url, scode){    
// 불려질 url체크, 조회 중입니다.윈도우 떠있지 않을때
	if (url != '' && top.mainFrame.openWaitWin == null) 
	{
		
//	    document.menuForm.method = "POST";
//	    document.menuForm.action = "/edi/jsp/openBzPage.jsp";
	    document.menuForm.txt.value = txt;
	    document.menuForm.pid.value = scode;
	    document.menuForm.url.value = url;
	    top.document.title = txt;
	    top.topFrame.hidden_pid.value = scode; //도움말을 위한 프로그램아뒤등록
//	    document.menuForm.submit();
        
	   top.mainFrame.location.href = url;
	}    
}
-->    
</script>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                            *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* E. 본문시작                                                            *-->
<!--*************************************************************************-->

<BODY onLoad="doInit()">
<table width="178" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="l_o_bx01" /> </td>
    <td class="l_o_bx02"></td>
    <td  class="l_o_bx03" /></td>
  </tr>
  <tr>
    <td width="3" class="l_o_bx04"></td>
    <td valign="top" >
    	<table width="173" border="0" align="center" cellpadding="0" cellspacing="0" >
      <tr>
      <td colspan="3" valign="bottom">
          <!-- sub_menu 수정-->
          <!-- 커뮤니티 ECMN, 발주/매일 EORD, 영업실적 ESAL, 대금정보 EPAY, 임대정보 EREN, 약속관리 EPRM, 구인/구직 EJOB, 정보수정 ECTM -->
           <c:if test="${ sessionScope.sessionInfo2.SUB_MENU == 'ECMN'}">
           	   <img src="/edi/imgs/comm/left_title_01.gif" /></td>
          </c:if>
          <c:if test="${ sessionScope.sessionInfo2.SUB_MENU == 'EORD'}">
              <img src="/edi/imgs/comm/left_title_02.gif"  /></td>
          </c:if>
          <c:if test="${ sessionScope.sessionInfo2.SUB_MENU == 'ESAL'}">
              <img src="/edi/imgs/comm/left_title_03.gif"  /></td>
          </c:if>
          <c:if test="${ sessionScope.sessionInfo2.SUB_MENU == 'EPAY'}">
              <img src="/edi/imgs/comm/left_title_04.gif"  /></td>
          </c:if>
          <c:if test="${ sessionScope.sessionInfo2.SUB_MENU == 'EREN'}">
              <img src="/edi/imgs/comm/left_title_05.gif"  /></td>
          </c:if>
          <c:if test="${ sessionScope.sessionInfo2.SUB_MENU == 'EPRO'}">
              <img src="/edi/imgs/comm/left_title_06.gif"  /></td>
          </c:if>
          <c:if test="${ sessionScope.sessionInfo2.SUB_MENU == 'EJOB'}">
              <img src="/edi/imgs/comm/left_title_07.gif"  /></td>
          </c:if>
          <c:if test="${ sessionScope.sessionInfo2.SUB_MENU == 'ECTM'}">
              <img src="/edi/imgs/comm/left_title_08.gif"  /></td>
          </c:if>
      </tr>
      <tr>
        <td width="3" class="l_i_bx04"></td>
      <td class="center PT03" ><img src="/edi/imgs/comm/left_title_b.gif" />
      </td>
       <td class="l_i_bx06"></td>
     </tr>
      
      <tr>
        <!-- 메뉴입니다. -->
        <td width="3" class="l_i_bx04"></td>
        <td width="167" height="520"  valign="top"  class="PT07">
        <div style="width:100%; height:520; overflow:auto;">
		<table width="157" align="center">    	    
    	    	<c:forEach items="${ret}" var="it" varStatus="a">
	    		<tr>
				<td class="hand PT15"><a onclick="javascript:urlLink('<c:out value="${it.NAME}"/>','<c:out value="${it.URL}"/>', '<c:out value="${it.SCODE}"/>');"><img src="/edi/imgs/comm/square_white.gif" /> <c:out value="${it.NAME}"/></a></td>
		    	</tr>
            	</c:forEach>
		</table>
		</div>
		</td>    	    
        <td class="l_i_bx06"></td>
      </tr>
      <tr>
        <td  class="l_i_bx07" /></td>
        <td  class="l_i_bx08"></td>
        <td  class="l_i_bx09" /></td>
      </tr>
    </table>
    	</tr>
    	</td>
    <td  class="l_o_bx06"></td>
  </tr>
  <tr>
   <td class="l_o_bx04"></td>
  <td  bgcolor="#efefef" class="PT05 PB03 PL10"></td>
   <td class="l_o_bx06"></td>
  </tr>

  <tr>
    <td class="l_o_bx07" /></td>
    <td class="l_o_bx08"></td>
    <td class="l_o_bx09" /></td>
  </tr>
</table>


  <form name="menuForm" target="menuhiddenFrame">
    <input type="hidden" name="txt">
    <input type="hidden" name="url">
    <input type="hidden" name="pid">
  </form>

    
<!-----좌메뉴끝------>
<iframe  name="menuhiddenFrame"  style="display:none;"></iframe>
<iframe  name="myhiddenFrame"  style="display:none;"></iframe>
</BODY>
</HTML>
