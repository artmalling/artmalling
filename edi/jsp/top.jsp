<%
	/*******************************************************************************
	 * 시스템명 : 아트몰링 통합정보시스템 / 공통
	 * 작 성 일 : 2010.12.12
	 * 작 성 자 : 정지인
	 * 수 정 자 :
	 * 파 일 명 : top.jsp
	 * 버    전 : 1.0
	 * 개    요 : 상단메뉴
	 * 이    력 :
	 ******************************************************************************/
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
	/****************** 서브메뉴 셋팅 *****************/
	/****************** 상단 TAB을 권한에 맞게 보기 위해 *******/
	SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
	if (sessionInfo != null) {
		if (request.getParameter("submenu") != null
				&& !"".equals(request.getParameter("submenu")))
			sessionInfo.setSUB_MENU(request.getParameter("submenu"));
	}

	String gb = sessionInfo.getGB(); //1. 협력사     2.브랜드  @ 택발행대행사
	String vencd = sessionInfo.getVEN_CD(); //협력사코드
%>



<ajax:library />
<HTML>
<HEAD>
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

<script language="javascript">

var strGb = '<%=gb%>';
var strVen = '<%=vencd%>';
var flag = 'I';
var strOut ="";

<!--------- 화면 로딩시 아래 함수를 주기적으로 부름 (긴급메시지,시간)----------------->
function displayIt() {

}

<!---------------- 메뉴 보이기 & 감추기 ------------------------------------------>
function hide_menu(){

	if (parent.subframeset.cols == "180,*"){
		parent.subframeset.cols = "0,*";
		hiddenMenu.src = "/edi/imgs/comm/top_menu_view.gif";
	} else {
		parent.subframeset.cols="180,*";
		hiddenMenu.src = "/edi/imgs/comm/top_menu_hidden.gif";
	}

}

<!-- ----------- 관리자 버튼을 우르는 경우 ---------------------------------------->
function displayAdminMenu() {
}


/* 페이지 온로드시 로그아웃 처리를 위해 각각의 프레임을 로드함.
	커뮤니티 ECMN
	발주/매일 EORD
	영업실적 ESAL
	대금정보 EPAY
	임대정보 EREN
	약속관리 EPRM
	구인/구직 EJOB
	정보수정 ECTM
*/

<!-- 메인화면  -->
function goMain() {
	top.window.status='';
	top.document.title = "아트몰링 EDI시스템";
	top.mainFrame.location.href="/edi/ecom001.ec?goTo=goMain";
}

<!-- 커뮤니티  -->
function goECMN() {
	/*if(strGb == "@") {
		showMessage(INFORMATION, OK, "USER-1000", "사용하실 수 없는 메뉴입니다.");
		return;
	}
	else { */
		top.window.status='';
		top.document.title = "아트몰링 EDI시스템";

		top.leftFrame.location.href="/edi/ecom003.ec?goTo=list&submenu=ECMN&strGb="+strGb+"&strVen="+strVen;
		top.topFrame.location.href="/edi/jsp/top.jsp?submenu=ECMN&strGb="+strGb;
	//}
}

<!-- 발주/매입  -->
function goEORD() {
	top.window.status='';
	top.document.title = "아트몰링 EDI시스템";
	top.leftFrame.location.href="/edi/ecom003.ec?goTo=list&submenu=EORD&strGb="+strGb+"&strVen="+strVen;
	top.topFrame.location.href="/edi/jsp/top.jsp?submenu=EORD&strGb="+strGb;
}

<!-- 영업실적   -->
function goESAL() {
	if(strGb == "@") {
		showMessage(INFORMATION, OK, "USER-1000", "사용하실 수 없는 메뉴입니다.");
		return;
	}
	else {
		top.window.status='';
		top.document.title = "아트몰링 EDI시스템";
		top.leftFrame.location.href="/edi/ecom003.ec?goTo=list&submenu=ESAL&strGb="+strGb+"&strVen="+strVen;
		top.topFrame.location.href="/edi/jsp/top.jsp?submenu=ESAL&strGb="+strGb;
	}
}

<!-- 대금정보  -->
function goEPAY() {
	if(strGb == "@") {
		showMessage(INFORMATION, OK, "USER-1000", "사용하실 수 없는 메뉴입니다.");
		return;
	}
	else {
		top.window.status='';
		top.document.title = "아트몰링 EDI시스템";
		top.leftFrame.location.href="/edi/ecom003.ec?goTo=list&submenu=EPAY&strGb="+strGb+"&strVen="+strVen;
		top.topFrame.location.href="/edi/jsp/top.jsp?submenu=EPAY&strGb="+strGb;
	}
}

<!-- 임대정보  -->
function goEREN() {
	if(strGb == "@") {
		showMessage(INFORMATION, OK, "USER-1000", "사용하실 수 없는 메뉴입니다.");
		return;
	}
	else {
		top.window.status='';
		top.document.title = "아트몰링 EDI시스템";
		top.leftFrame.location.href="/edi/ecom003.ec?goTo=list&submenu=EREN&strGb="+strGb+"&strVen="+strVen;
		top.topFrame.location.href="/edi/jsp/top.jsp?submenu=EREN&strGb="+strGb;
	}
}

<!-- 약속관리  -->
function goEPRM() {
	if(strGb == "@") {
		showMessage(INFORMATION, OK, "USER-1000", "사용하실 수 없는 메뉴입니다.");
		return;
	}
	else {
		top.window.status='';
		top.document.title = "아트몰링 EDI시스템";
		top.leftFrame.location.href="/edi/ecom003.ec?goTo=list&submenu=EPRO&strGb="+strGb+"&strVen="+strVen;
		top.topFrame.location.href="/edi/jsp/top.jsp?submenu=EPRM";
	}
}

<!-- 구인/구직  -->
function goEJOB() {
	if(strGb == "@") {
		showMessage(INFORMATION, OK, "USER-1000", "사용하실 수 없는 메뉴입니다.");
		return;
	} else {
		top.window.status='';
		top.document.title = "아트몰링 EDI시스템";
		top.leftFrame.location.href="/edi/ecom003.ec?goTo=list&submenu=EJOB&strGb="+strGb+"&strVen="+strVen;
		top.topFrame.location.href="/edi/jsp/top.jsp?submenu=EJOB";
	}
}

<!-- 정보수정  -->
function goECTM() {
	/*
	top.window.status='';
	top.document.title = "아트몰링 EDI시스템";
	top.leftFrame.location.href="/edi/ecom003.ec?goTo=list&submenu=ECTM&strGb="+strGb;
	top.topFrame.location.href="/edi/jsp/top.jsp?submenu=ECTM";
	*/
	if(strGb == "@") {
		showMessage(INFORMATION, OK, "USER-1000", "사용하실 수 없는 메뉴입니다.");
		return;
	}
	else {
		var arrArg  = new Array();
		arrArg.push("");
		arrArg.push("");
		var returnVal = window.showModalDialog("/edi/ecom001.ec?goTo=pwdUpdateMain",
											   "",
											   "dialogWidth:432px;dialogHeight:337px;scroll:no;" +
											   "resizable:no;help:no;unadorned:yes;center:yes;status:no");
		//window.open("/edi/ecom001.ec?goTo=pwdUpdateMain","비밀번호변경","width=1020px,height=527px,status=yes");
	}
}



<!--------------   최초 로딩시 CALL    ------------------------------------------>
function doInit() {
	//displayIt();
	//alert(strVen);
	if(strGb == "@") {
		top.window.status='';
		top.document.title = "아트몰링 EDI시스템";
		if(strVen == "99999") {
			top.leftFrame.location.href="/edi/ecom003.ec?goTo=list&submenu=EORD&strGb="+strGb+"&strVen="+strVen;
		} else {
			top.leftFrame.location.href="/edi/ecom003.ec?goTo=list&submenu=ECMN&strGb="+strGb+"&strVen="+strVen;
		}
	}
}

<!--------------   건의사항  POPUP    ------------------------------------------->
function showSuggestPopup() {
}

<!--------------   비밀번호 변경  POPUP    --------------------------------------->
function ChangePasswordPopup() {
}

<!--------------  임시로 세션에 값을 저장 (개발시) -------------------------------->
function sessionSubmit() {
}

<!--------------   새창  POPUP    ------------- -->
function newWindowOpen() {
}


<!-------------   도움말 POPUP   ----------------------------------------------->
function helpWindowOpen()
{
	if( document.all.hidden_pid.value == "")
	{
		showMessage(INFORMATION, OK, "USER-1000", "프로그램을 선택하여 주십시오.");
		return;
	}
	helpPop(document.all.hidden_pid.value);

}
</script>
</HEAD>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                            *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* E. 본문시작                                                            *-->
<!--*************************************************************************-->

<body  onLoad="javascript:doInit();">
<table style="background-image: url(/edi/imgs/comm/top_bg.gif); background-repeat: repeat-x;" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="20" valign="bottom">
			<table border="0" align="right" cellpadding="0" cellspacing="0" >
				<tr>
					<td class="top_login"><img src="/edi/imgs/comm/square_blue.gif" width="7" height="7" hspace="2" />
						<c:out value="${sessionScope.sessionInfo2.VEN_NAME}" /> 님
					</td>
					<td class="top_time" id="timearea">
						<input type="hidden" name="hidden_pid">
					</td>
					<td class="top_tx PT03">
						<a href="/edi/ecom001.ec?goTo=logout" onfocus="this.blur();"><img src="/edi/imgs/comm/top_logout.gif" valign="absmiddle" /></a>
					</td>
					<td class="top_tx PT03">
						<a href="javascript:helpWindowOpen();" onfocus="this.blur();"><img src="/edi/imgs/comm/top_help.gif" valign="absmiddle" /></a>
					</td>
					<td class="PR20"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="41" valign="bottom">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="180" class="PL10">
						<img src="/edi/imgs/comm/top_logo.gif" width="127" height="31" onclick="javascript:goMain();"/></td>
					<td width="100%" style="padding-top:1px">
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<a href="javascript:goECMN();">
										<img src="/edi/imgs/comm/top_menu_01.gif" name="mn01"  border="0" id="mn01" onMouseOver="this.src='/edi/imgs/comm/top_menu_01_over.gif'" onMouseOut="this.src='/edi/imgs/comm/top_menu_01.gif'" />
									</a>
								</td>
								<td>
									<a href="javascript:goEORD();">
										<img src="/edi/imgs/comm/top_menu_02.gif" name="mn02"  id="mn02" onMouseOver="this.src='/edi/imgs/comm/top_menu_02_over.gif'" onMouseOut="this.src='/edi/imgs/comm/top_menu_02.gif'" />
									</a>
								</td>
								<td>
									<a href="javascript:goESAL();">
										<img src="/edi/imgs/comm/top_menu_03.gif" name="mn03"  id="mn03" onMouseOver="this.src='/edi/imgs/comm/top_menu_03_over.gif'" onMouseOut="this.src='/edi/imgs/comm/top_menu_03.gif'" />
									</a>
								</td>
								<td>
									<a href="javascript:goEPAY();">
										<img src="/edi/imgs/comm/top_menu_04.gif" name="mn04"  id="mn04" onMouseOver="this.src='/edi/imgs/comm/top_menu_04_over.gif'" onMouseOut="this.src='/edi/imgs/comm/top_menu_04.gif'" />
									</a>
								</td>
								<td>
									<a href="javascript:goECTM();">
										<img src="/edi/imgs/comm/top_menu_05.gif"  onMouseOver="this.src='/edi/imgs/comm/top_menu_05_over.gif'" onMouseOut="this.src='/edi/imgs/comm/top_menu_05.gif'" />
									</a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="27" valign="bottom" class="PB02">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td style="padding-bottom:7px" width="170" >
						<img id="hiddenMenu" onClick="hide_menu();" src="/edi/imgs/comm/top_menu_hidden.gif" width="174" height="19" hspace="2" />
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>

<!-- div 때문에 아래 영역 빈 스페이스 발생 일단 주석처리 오류시 주석 해제할것. sbcho -->
<!--
	<div id='tmp2' style="visible:none;height:0;width:0;"></div>
-->
<form name="myForm" target="myhiddenFrame">
	<input type="hidden" name="usr_cd">
	<input type="hidden" name="usr_nm">
</form>
<iframe name="myhiddenFrame" style="display: none;"></iframe>
</HTML>
