<%
/*******************************************************************************
  * 시스템명 : 형지 아트몰링 통합정보시스템 공통 
  * 작 성 일 : 2010.12.12 
  * 작 성 자 : 정지인
  * 수 정 자 :
  * 파 일 명 : already_login.jsp
  * 버    전 : 1.0
  * 개    요 : 로그인 ID가 없는 경우 에러 페이지
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
<TITLE>형지 아트몰링 통합정보시스템  </TITLE>
<meta http-equiv="pragma" content="no-cache">
<link rel="stylesheet" href="/pot/css/mmds.css" type="text/css">

<script>
	/**
    * onClick()
    * 작 성 자 : 권홍재
    * 작 성 일 : 2006-12-12
    * 개    요 : 로그인 페이지 가기.
    * return값 : void
    */ 
	function goLoginPage(){
		window.open('/pot/index.html', '', 'width=1024-10, height=768-55, status=1, resizable=1, titlebar=1, location=1, toolbar=1, menubar=1, scrollbars=1');
		parent.close();
	}
</script>
</HEAD>
<BODY topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 background="imgs/common/login_01.jpg" >
<!---///??--->
<TABLE width="711" height="119" border="0" cellspacing="0" cellpadding="0" align=center>
<TR>
<TD><BR><BR><IMG SRC="imgs/common/login_02.jpg" WIDTH="194" HEIGHT="64" BORDER=0 ALT=""></TD>
</TR>
</TABLE>
<!---///--->
<TABLE width="711" height="350" border="0" cellspacing="0" cellpadding="0" align=center bgcolor=F2ECDE>
<TR>
<TD>
	<BR>
	<TABLE width="580" height="230" border="1" cellspacing="0" cellpadding="0" align=center bgcolor=ffffff style="border-collapse:collapse;" bordercolor="#E6DDB9">
	<TR>
	<TD>
		<TABLE width="540" border="0" cellspacing="0" cellpadding="0" align=center >
		<TR>
		<TD WIDTH="180" ><IMG SRC="imgs/common/login_fail.jpg" WIDTH="166" HEIGHT="190" BORDER=0 ALT=""></TD>
		<TD>
			<TABLE width="350" border="0" cellspacing="0" cellpadding="10">
			<TR>
			<TD><FONT SIZE="3" COLOR="F39252"><B>이미 시스템에 로그인되어 있는  아이디 입니다.</B></FONT><BR><BR>
                      <BR> 기존 로그인 정보를 무시 하고 다시 로그인 하실 수 있습니다.
                      <BR> 로그인을 원하시면 <a href="/pot/tcom001.tc?goTo=updatesession"><font color=red>여기</font></a>를 클릭해 주세요</TD>
			</TR>
			<TR>
			<TD height=1 bgcolor=F2ECDE></TD>
			</TR>			
			</TABLE></TD>
		</TR>
		</TABLE></TD>
	</TR>
	</TABLE>
	<BR>
	<CENTER><IMG SRC="imgs/btn/login_back.jpg" WIDTH="57" HEIGHT="19" BORDER=0 ALT=""onmouseover="this.src='imgs/btn/login_back_on.jpg'" onMouseOut="this.src='imgs/btn/login_back.jpg'" style="cursor:hand" onClick="goLoginPage()"></CENTER></TD>
</TR>
</TABLE>
<!---///?????--->
<TABLE width="711" height="50" border="0" cellspacing="0" cellpadding="0" align=center>
<TR>
<TD align=center><BR><IMG SRC="imgs/common/login_05.jpg" WIDTH="453" HEIGHT="42" BORDER=0 ALT=""></TD>
</TR>
</TABLE>
</BODY>
</HTML>
