<%
/*******************************************************************************
  * 시스템명 : 한국후지쯔 통합정보시스템 공통 
  * 작 성 일 : 2010.12.12 
  * 작 성 자 : 정지인
  * 수 정 자 :
  * 파 일 명 : login_fail.jsp
  * 버    전 : 1.0
  * 개    요 : 로그인 ID가 없는 경우 에러 페이지 / 패스워드 틀린 경우 , 이미 로긴되어 있는 경우
  * 이    력 : 
  *****************************************************************************/
%>
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>형지 아트몰링  통합정보시스템  </TITLE>
<meta http-equiv="pragma" content="no-cache">
<!-- 
self.moveTo(0,0); 
self.resizeTo(screen.availWidth,screen.availHeight); 
self.opener = "";
//-->  
<link rel="stylesheet" href="/pot/css/mds.css" type="text/css">
</HEAD>
<BODY topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 background="" >
<div id="wrap_02">

<div class="wrap_div02">

    <!-- toplogo S-->
	<div class="T_box"><div class="logo_box"></div></div>
	<!-- toplogo E--> 
    
    <!-- center  box S-->
    <div class="C_box">    
        <div class="login_f_box">          
            <div class="txt_box" style="padding-bottom:18px" id="MESSAGE"></div>
            <div class="btn_box" style="padding-top:22px"><CENTER><a href="#" onclick="window.open('/pot/jsp/login.jsp','win','width=1024-55,height=769-10,resizable=1,scrollbars=1, statusbar=1, toolbar=1, directories=1, menubar=1, location=1'); self.close();"><IMG SRC="/pot/imgs/btn/confirm_01.gif" BORDER=0 ALT=""onmouseover="this.src='/pot/imgs/btn/confirm_01.gif'" onmouseout="this.src='/pot/imgs/btn/confirm_01.gif'" style="cursor:hand"></a></CENTER></div>
       </div>       
    </div>
    <!-- center  box E-->
    
</div>

</div>
</BODY>
<script language="JavaScript">
	var strMsg    = ""; 
	switch (<%=request.getAttribute("errFlag")%>){
    case 0 :
    	//ID 존재하지 않음 
      strMsg = "<B>존재하지 않는 ID 입니다.</B>";       
      break;
    case 1 :
    	//PWD 맞지 않음
      strMsg = "<B>패스워드를 확인하세요</B>"; 
      break;
    case 2 :
    	//세션이  닫히지 않은 상태임TC_LOGHST 
    	// 멀티로긴 사용하지 않는 경우
    	strMsg = "<B>다른 기기에서 로그인하였거나, 비정상 종료 처리된 상태입니다.<BR>"
    	       + "<B>관리자에게 로그아웃 정상처리를 요청하거나,<BR>"
    	       + "<B>멀티로그인 허용을 요청하시면 로그인이 가능합니다.</B>";
      break;
    case 3 :
    	//세션이  닫히지 않은 상태임TC_LOGHST 
    	// 멀티로긴 사용하는 경우
      strMsg = "<B>다른 기기에서 로그인하였거나, 비정상 종료 처리된 상태입니다.</B></FONT><BR><BR>"
             + "<BR> 기존 로그인 정보를 무시 하고 다시 로그인 하실 수 있습니다."
             + "<BR> 로그인을 원하시면 <a href='/pot/tcom001.tc?goTo=updatesession'><font color=red>여기</font></a>를 클릭하십시오.</B>";
      break;

    case 4 :
    	//TC_USRMST.USE_YN != "Y" 
      strMsg = "<B>시스템접근이 불가한 ID입니다..<BR>"
    	     + "<B>관리자에게 연락하십시오.</B>";
      break;
      
    default :
    	// 비정상처리  
    	strMsg = "<B>당신이 이 메시지를 보시게 되어 대단히 유감으로 생각합니다.<BR>"
    	       + "<B>관리자에게 연락하십시오.</B>";
    	break;
  }
  MESSAGE.innerHTML = strMsg;
</script>

</HTML>
