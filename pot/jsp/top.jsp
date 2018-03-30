<%
/*******************************************************************************
 * 시스템명 : 한국후지쯔 통합정보시스템 / 공통
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
%>
<%@ page import="common.vo.SessionInfo,common.util.Util,java.util.Properties,kr.fujitsu.ffw.base.BaseProperty"%>
<% /* BIJ : @ page import="com.softwarefx.chartfx.server.*" */%>
<%@ page import="java.net.InetAddress"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c-rt.tld" %>
<%@ taglib prefix="ajax" uri="/WEB-INF/tld/ajax-lib.tld"%>

<%
	/****************** 세션 서브시스템 셋팅 *****************/
	/****************** 상단 TAB을 권한에 맞게 보기 위해 *******/
	SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
	if (sessionInfo != null) {
		if (request.getParameter("subsystem") != null && !"".equals(request.getParameter("subsystem")))
			sessionInfo.setSUB_SYS(request.getParameter("subsystem"));
	}

	/************ fujitsu.config파일을 읽어들임 ******************************/
	Properties fujitsudeptProps = Util.getFujitsudeptProperties();
	String ajaxInterval = fujitsudeptProps.getProperty("ajax.interval");
	String serverName   = fujitsudeptProps.getProperty("server.name");

	String dir = BaseProperty.get("context.common.dir");
%>

<ajax:library />
<HTML>
<HEAD>
<link rel="stylesheet" href="/pot/css/mds.css" type="text/css">
<meta http-equiv="pragma" content="no-cache">
<script language="javascript"  src="/<%=dir%>/js/common.js"		type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"		type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"		type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"	type="text/javascript"></script>


<script language="javascript" src="/pot/js/global.js"	type="text/javascript"></script>
<script language="javascript" src="/pot/js/message.js"	type="text/javascript"></script>
<script language="javascript" src="/pot/js/common.js"	type="text/javascript"></script>
<script language="javascript" src="/pot/js/ajax.js"		type="text/javascript"></script>
<script language="javascript" src="/pot/js/popup.js"	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script language="javascript">

var flag = 'I';
var subCode = "";
var strWindowList = new Array();

//--------- 화면 로딩시 아래 함수를 주기적으로 부름 ---------->
function displayIt() {
	var param = "&goTo=refresh";
	<ajax:open callback="on_loadedXML" param="param" method="POST" urlvalue="/pot/tcom002.tc"/>
}

<ajax:callback function="on_loadedXML">
	if(rowsNode[0] == null) { return; }
	
	if (rowsNode[0].childNodes[0].childNodes[0].nodeValue != "") {
		var datetime = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
		var hp_inp_yyyymmdd = rowsNode[0].childNodes[1].childNodes[0].nodeValue;
	
		if(datetime == "fail"){
			window.open('/pot/jsp/login.jsp','','');
			top.parent.self.close();
		}else{
			//document.all.timearea.innerText = datetime;
			HD_INP_YYYYMMDD.value = hp_inp_yyyymmdd;
		}
	}
</ajax:callback>

//---------------- 메뉴 보이기 & 감추기 ------------------------------------------
function hide_menu(){

	/*
	if (parent.subframeset.cols == "180,*"){
		parent.subframeset.cols = "0,*";
		hiddenMenu.src = "/pot/imgs/comm/top_menu_view.gif";
	} else {
		parent.subframeset.cols="180,*";
		hiddenMenu.src = "/pot/imgs/comm/top_menu_hidden.gif";
	}
	*/
	if (parent.subframeset.cols == "250,*"){
		parent.subframeset.cols = "0,*";
		hiddenMenu.src = "/pot/imgs/comm/top_menu_view.gif";
	} else {
		parent.subframeset.cols="250,*";
		hiddenMenu.src = "/pot/imgs/comm/top_menu_hidden.gif";
	}
}

//---------------- 즐겨찾기 ------------------------------------------
function call_favorite(){
	top.leftFrame.location.href="/pot/tcom003.tc?goTo=list&subsystem=" + subCode + "&subsystem2=F";
}

/**
 * setMdiPopupInfo()
 * 작 성 자 : 엄준석
 * 작 성 일 : 2010.09.18
 * 개    요 : MDI 팝업 호출시 화면상단에 해당 정보 세팅
 * return값 : void
*/
function setMdiPopupInfo() {
	 
	var dsMdiInfo = parent.mainFrame.DS_MdiInfo; // MDI 정보 데이터셋
	var intLimitLen = 18; // 제한 타이틀 BYTE 수
	var tabNum = 1;
	for (var i = 1; i <= dsMdiInfo.CountRow; i++) {
		if (dsMdiInfo.NameValue(i, "MDI_ID").length > 0) {
			tabNum ++;
		}
	}
	if(tabNum > 7){
		intLimitLen = intLimitLen - tabNum + 2;
	}
	
	for (var i = 1; i <= dsMdiInfo.CountRow; i++) {

		var strMdiId = dsMdiInfo.NameValue(i, "MDI_ID");
		var strPgNm = dsMdiInfo.NameValue(i, "PG_NM");
		var obj = eval("mdiButton" + i);
		var strChar = "";
		var strRet = "";
		var intLen = 0;

		// MDI 타이틀을 제한된 길이로 잘라내고 메뉴를 리셋한다
		if (strMdiId.length > 0) {

			for (var j = 0; j < strPgNm.length; j++) {
				strChar = strPgNm.charAt(j);

				if (escape(strChar).length > 4) {
					intLen += 2;
				} else {
					intLen += 1;
				}

				if (intLen <= intLimitLen) {
					strRet += strChar;
				} else {
					strRet += "...";
					break;
				}
			}

			document.getElementById('td_tab_c' + i).innerHTML = strRet;
			
			obj.style.display = "block";

		} else {
			obj.style.display = "none";
		}
	}
	
	//활성화된 MDI창의 제목 스타일 재설정
	setTimeout("ActiveMdiPopupStyle()", 50);
	//ActiveMdiPopupStyle();
}

/**
 * fn_getYYYYMMDD()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010.06.03
 * 개    요 : 조회한 DB 일자를 조회한다.
 * return값 :
*/
function fn_getYYYYMMDD(){
	return HD_INP_YYYYMMDD.value;
}

/**
 * activeMdiPopup()
 * 작 성 자 : 엄준석
 * 작 성 일 : 2010.10.04
 * 개    요 : MDI 팝업 활성화
 * return값 : void
*/
function activeMdiPopup(dsNo) {

	 parent.mainFrame.fn_activeMdiPopup(dsNo);

	// 활성화된 MDI창의 제목 스타일 재설정
	//ActiveMdiPopupStyle();
}

/**
 * destroyMdiPopup()
 * 작 성 자 : 엄준석
 * 작 성 일 : 2010.10.04
 * 개    요 : MDI 팝업 제거
 * return값 : void
 */
function destroyMdiPopup(dsNo) {
	parent.mainFrame.fn_destroyMdiPopup(dsNo);

	// 활성화된 MDI창의 제목 스타일 설정
	setTimeout("ActiveMdiPopupStyle()", 50);
}

/**
 * destroyAllMdiPopup()
 * 작 성 자 : 정지인
 * 작 성 일 : 2011.08.04
 * 개    요 : MDI 팝업 제거
 * return값 : void
 */
function destroyAllMdiPopup() {
	for (var i = parent.mainFrame.DS_MdiInfo.CountRow; i >= 1; i--) {
		//모든창 닫도록 변경
		if (parent.mainFrame.DS_MdiInfo.NameValue(i,"PG_ID").length > 0){
			parent.mainFrame.fn_destroyMdiPopup(i);
		}
	}
	// 활성화된 MDI창의 제목 스타일 설정
	setTimeout("ActiveMdiPopupStyle()", 50);
}

/**
 * ActiveMdiPopupStyle()
 * 작 성 자 : 엄준석
 * 작 성 일 : 2010.10.04
 * 개    요 : 활성화된 MDI창의 제목 스타일 설정
 * return값 : void
 */
function ActiveMdiPopupStyle() {
	var dsMdiInfo = parent.mainFrame.DS_MdiInfo; // MDI 정보 데이터셋
	var row = parent.mainFrame.fn_getActiveMdiPopup(); // Active 상태의 MDI 화면 데이터셋 번호

	// 활성화된 MDI창의 스타일 재설정
	for (var i = 1; i <= dsMdiInfo.CountRow; i++) {
		if (i == row) {
			document.getElementById('td_tab_l' + i).className = "tab_on_l";
			document.getElementById('td_tab_c' + i).className = "tab_on_c";
			document.getElementById('td_tab_x' + i).className = "tab_on_x";
			document.getElementById('td_tab_r' + i).className = "tab_on_r";
		} else {
			document.getElementById('td_tab_l' + i).className = "tab_off_l";
			document.getElementById('td_tab_c' + i).className = "tab_off_c";
			document.getElementById('td_tab_x' + i).className = "tab_off_x";
			document.getElementById('td_tab_r' + i).className = "tab_off_r";
		}
	}
}

function on_Cascade(){
	parent.mainFrame.objMasterFrame.SortFrame("cascade");
}

function on_Horizontally(){
	parent.mainFrame.objMasterFrame.SortFrame("horizon");
}

function on_Vertically(){
	parent.mainFrame.objMasterFrame.SortFrame("vertical");
}

function on_CloseAll(){
	parent.mainFrame.CloseFrameAll();
}

/**
 * callLogout()
 * 작 성 자 : 엄준석
 * 작 성 일 : 2011.08.03
 * 개    요 : Logout
 * return값 : void
 */
function callLogout() {
	if( showMessage(QUESTION, YESNO, "USER-1000", "로그 아웃 하시겠습니까?") !=1 ) return;

	//popupWindowClose()
	location.href = "/pot/tcom001.tc?goTo=logout";
}

/**
 * popupWindowClose()
 * 작 성 자 : 엄준석
 * 작 성 일 : 2011.08.03
 * 개    요  : 로그아웃
 * return값 : void
 */
function popupWindowClose(){
	// 로그 아웃시 팝업이 올라 와 있음 처리
	/*for (var i=0, n=strWindowList.length; i<n; i++) {
		if(!strWindowList[i].closed) {
			strWindowList[i].close();
		}
	}*/
}

//*----------- 관리자 버튼을 우르는 경우 ----------------------------------------
function displayAdminMenu() {
}


/* 
페이지 온로드시 로그아웃 처리를 위해 각각의 프레임을 로드함.
    백화점			P dps
    경영지원		M mss
    포인트카드		D dcs
    문화센터		C ccs
    온라인			O pot
    포탈			T pot

    goLeftMenuList
    기준정보 S
    매출관리 B
    매출현황 F
    영업관리 P
    고객관리 M 
    상품권관리 G
    사은행사 J
    임대관리 K
    시스템관리 T
*/


// 좌측 메뉴리스트 호출
function goLeftMenuList(strFlag) {

	top.window.status  = "";
	top.document.title = "형지 아트몰링 통합정보시스템";
	subCode            = strFlag;
	var strHref        = "/pot/tcom003.tc?goTo=list&subsystem=" + subCode;
	top.leftFrame.location.href = strHref;
}



//--------------   최초 로딩시 CALL    -----------------------------------------
function doInit() {
	if (parent.mainFrame.DS_MdiInfo)
		parent.topFrame.setMdiPopupInfo();

	displayIt();
	setInterval('displayIt()', <%=ajaxInterval%>);
}

//--------------   건의사항  POPUP    -------------------------------------------
function showSuggestPopup() {
	window.showModalDialog( "/pot/tcom006.tc?goTo=list", "", "dialogWidth:500px;dialogHeight:470px;scroll:no;" + "resizable:no;help:no;unadorned:yes;center:yes;status:no");
}

//-------------   SMS보내기 POPUP   -----------------------------------------------
function sendSmsPopup()
{
	window.showModalDialog( "/pot/tcom005.tc?goTo=list", "", "dialogWidth:600px;dialogHeight:510px;scroll:no;" + "resizable:no;help:no;unadorned:yes;center:yes;status:no");
}

//-------------   도움말 POPUP   -----------------------------------------------
function showHelpPopup()
{
	var dsMdiInfo = parent.mainFrame.DS_MdiInfo; 		// MDI 정보 데이터셋
	var row = parent.mainFrame.fn_getActiveMdiPopup();  // Active 상태의 MDI 화면 데이터셋 번호

	// 초기화면 제외하고 도움말 팝업
	if(row>1) helpPop(dsMdiInfo.NameValue(row,"PG_ID"));
}

//-------------   비밀번호변경 POPUP   -----------------------------------------------
function changePassWordPopup()
{
	window.showModalDialog( "/pot/tcom008.tc?goTo=list", "", "dialogWidth:600px;dialogHeight:232px;scroll:no;" + "resizable:no;help:no;unadorned:yes;center:yes;status:no");
}

//우클릭 방지(letf, topFrame)
function onContextMenu()
{
	return false;
}

document.attachEvent('oncontextmenu',onContextMenu);


</script>
</HEAD>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                     *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                         *-->
<!--*    1. DataSet                                                         *-->
<!--*    2. Transaction                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                     *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                         *-->
<!--*************************************************************************-->

<body onLoad="javascript:doInit();" onmousemove="return false">
<input type="hidden" id=HD_INP_YYYYMMDD >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="20" class="top_bg_01">
		<table border="0" align="right" cellpadding="0" cellspacing="0">
			<tr>				
				<!-- MARIO OUTLET COMMENT START
				<td class="top_tx PT03"><a href="#" onclick="alert(parent.mainFrame.DS_MdiInfo.ExportData(1, parent.mainFrame.DS_MdiInfo.CountRow, true));"> MDI Tracer</a></td>
				MARIO OUTLET COMMENT END -->

				<td class="top_login"><img src="/pot/imgs/comm/square_blue.gif" width="7" height="7" hspace="2" /><c:out value="${sessionScope.sessionInfo.USER_NAME}" /> 님</td>
				<td class="top_time" id="timearea" ></td>
				
				<!-- 2011.08.15 COMMENT 처리 -->
				<!--
				<td class="top_tx"><a href="javascript:sendSmsPopup();"><img src="/pot/imgs/comm/top_sms.gif" valign="absmiddle" hspace="2" />SMS 전송</a></td>
				<td class="top_tx"><a href="javascript:showSuggestPopup();"><img src="/pot/imgs/comm/top_suggest.gif" valign="absmiddle" hspace="2" />건의사항</a></td>
				<td class="top_tx"><!--<a href="javascript:showHelpPopup();"><img src="/pot/imgs/comm/top_help.gif" valign="absmiddle" />도움말</a> </td>
				-->
				<td class="top_tx"><a href="#" onClick="callLogout();"><img src="/pot/imgs/comm/top_logout.gif" style="display:block;"/></a></td>
				<td class="top_tx"><!-- 비밀번호변경 --><a href="#" onClick="changePassWordPopup();"><img src="/pot/imgs/comm/top_changpw.gif" style="display:block;" /></a></td>
				<td class="PR20"></td>
				<td class="top_w_l"></td>				
				<td class="top_w_c">
				       <table border="0" cellpadding="0" cellspacing="0" align="right">
                            <tr>
                            <td><div class="top_win">창도구</div></td>
                            <td><a href="javascript:on_Cascade();"><img	src="/pot/imgs/comm/top_wi_01.gif" alt="바둑판정렬" hspace="2" /></a></td>
                            <td><a href="javascript:on_Horizontally();"><img src="/pot/imgs/comm/top_wi_02.gif" alt="가로정렬" hspace="2" /></a></td>
                            <td><a href="javascript:on_Vertically();"><img src="/pot/imgs/comm/top_wi_03.gif" alt="세로정렬" hspace="2" /></a></td>
                            <td><a href="javascript:destroyAllMdiPopup();"><img src="/pot/imgs/comm/top_wi_04.gif" alt="전체닫기" /></a></td>
                            </tr>
                        </table>
				</td>
				<td class="top_w_r"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="42" class="top_bg_02">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="250" class="PL10"><a href="javascript:parent.mainFrame.fn_activeMdiClear();"><img src="/pot/imgs/comm/top_logo.gif"  /></a></td>
					<td>
						<table border="0" align="right" cellpadding="0" cellspacing="0" >
							<tr>
								<td><!-- 기준정보 --><a href="javascript:goLeftMenuList('S');"><img src="/pot/imgs/comm/top_menu_01.gif" name="mn01" border="0" id="mn01" onMouseOver="this.src='/pot/imgs/comm/top_menu_01_over.gif'" onMouseOut="this.src='/pot/imgs/comm/top_menu_01.gif'" /></a></td>
								<td><!-- 매출관리 --><a href="javascript:goLeftMenuList('B');"><img src="/pot/imgs/comm/top_menu_02.gif" name="mn02" border="0" id="mn02" onMouseOver="this.src='/pot/imgs/comm/top_menu_02_over.gif'" onMouseOut="this.src='/pot/imgs/comm/top_menu_02.gif'" /></a></td>
								<td><!-- 매출현황 --><a href="javascript:goLeftMenuList('F');"><img src="/pot/imgs/comm/top_menu_03.gif" name="mn03" border="0" id="mn03" onMouseOver="this.src='/pot/imgs/comm/top_menu_03_over.gif'" onMouseOut="this.src='/pot/imgs/comm/top_menu_03.gif'" /></a></td>
								<td><!-- 영업관리 --><a href="javascript:goLeftMenuList('P');"><img src="/pot/imgs/comm/top_menu_04.gif" name="mn04" border="0" id="mn04" onMouseOver="this.src='/pot/imgs/comm/top_menu_04_over.gif'" onMouseOut="this.src='/pot/imgs/comm/top_menu_04.gif'" /></a></td>
								<td><!-- 고객관리 --><a href="javascript:goLeftMenuList('M');"><img src="/pot/imgs/comm/top_menu_05.gif" name="mn06" id="mn05" onMouseOver="this.src='/pot/imgs/comm/top_menu_05_over.gif'" onMouseOut="this.src='/pot/imgs/comm/top_menu_05.gif'" /></a></td>
								<td><!-- 상품권관리 --><a href="javascript:goLeftMenuList('G');"><img src="/pot/imgs/comm/top_menu_06.gif" name="mn06" id="mn06" onMouseOver="this.src='/pot/imgs/comm/top_menu_06_over.gif'" onMouseOut="this.src='/pot/imgs/comm/top_menu_06.gif'" /></a></td>
								<td><!-- 사은행사 --><a href="javascript:goLeftMenuList('J');"><img src="/pot/imgs/comm/top_menu_07.gif" name="mn07" id="mn07" onMouseOver="this.src='/pot/imgs/comm/top_menu_07_over.gif'" onMouseOut="this.src='/pot/imgs/comm/top_menu_07.gif'" /></a></td>
								<td><!-- 임대관리 --><a href="javascript:goLeftMenuList('K');"><img src="/pot/imgs/comm/top_menu_08.gif" name="mn08" id="mn08" onMouseOver="this.src='/pot/imgs/comm/top_menu_08_over.gif'" onMouseOut="this.src='/pot/imgs/comm/top_menu_08.gif'" /></a></td>
								<td><!-- 시스템관리 --><a href="javascript:goLeftMenuList('T');"><img src="/pot/imgs/comm/top_menu_09.gif" onMouseOver="this.src='/pot/imgs/comm/top_menu_09_over.gif'" onMouseOut="this.src='/pot/imgs/comm/top_menu_09.gif'" /></a></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="25" class="top_bg_03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="245" class="hmenu"><img id="hiddenMenu" onClick="hide_menu();" src="/pot/imgs/comm/top_menu_hidden.gif"  /><img onClick="call_favorite();" src="/pot/imgs/comm/top_favorite.gif" /></td>
					<td width="10" align="right" ><!-- <img src="/pot/imgs/comm/top_bar.gif" width="6" height="24" /> --></td>
					<td valign="bottom" class="PL10"><!--탭입력 라인-->
						<table border="0" cellspacing="0" cellpadding="0" >
							<tr>
								<td>
									<span id="mdiButton1" style="display: block;">
										<table  border="0" cellspacing="0" cellpadding="0" onClick="activeMdiPopup(1)" onMouseOver="this.style.cursor='hand'"  >
											<tr>
												<td ><div id="td_tab_l1" class="tab_on_l"></div></td>
												<td><div id="td_tab_c1" class="tab_on_c">메인화면</div></td>
												<td id="td_tab_x1" class="tab_on_x"><a href="#" onfocus="this.blur()" onClick="destroyMdiPopup(1)">&nbsp;<img src="/pot/imgs/comm/tab_close.gif" width="10" height="10" /></a></td>
												<td id="td_tab_r1" class="tab_on_r"></td>
											</tr>
										</table>
									</span>
								</td>
								<td>
									<span id="mdiButton2" style="display: none;">
										<table  border="0" cellspacing="0" cellpadding="0" onClick="activeMdiPopup(2)" onMouseOver="this.style.cursor='hand'" >
											<tr>
												<td ><div id="td_tab_l2" class="tab_off_l"></div></td>
												<td><div id="td_tab_c2" class="tab_off_c"></div></td>
												<td id="td_tab_x2" class="tab_off_x">
													<a href="#" onfocus="this.blur()" onClick="destroyMdiPopup(2)">
														&nbsp;<img src="/pot/imgs/comm/tab_close.gif" width="10" height="10" />
													</a>
												</td>
												<td id="td_tab_r2" class="tab_off_r"></td>
											</tr>
										</table>
									</span>
								</td>
								<td>
									<span id="mdiButton3" style="display: none;">
										<table border="0" cellspacing="0" cellpadding="0" onClick="activeMdiPopup(3)" onMouseOver="this.style.cursor='hand'">
											<tr>
												<td id="td_tab_l3" class="tab_off_l"></td>
												<td><div id="td_tab_c3" class="tab_off_c"></div></td>
												<td id="td_tab_x3" class="tab_off_x">
													<a href="#" onfocus="this.blur()" onClick="destroyMdiPopup(3)">
														&nbsp;<img src="/pot/imgs/comm/tab_close.gif" width="10" height="10" />
													</a>
												</td>
												<td id="td_tab_r3" class="tab_off_r"></td>
											</tr>
										</table>
									</span>
								</td>
								<td>
									<span id="mdiButton4" style="display: none;">
										<table border="0" cellspacing="0" cellpadding="0" onClick="activeMdiPopup(4)" onMouseOver="this.style.cursor='hand'">
											<tr>
												<td id="td_tab_l4" class="tab_off_l"></td>
												<td><div id="td_tab_c4" class="tab_off_c"></div></td>
												<td id="td_tab_x4" class="tab_off_x">
													<a href="#" onfocus="this.blur()" onClick="destroyMdiPopup(4)">
														&nbsp;<img src="/pot/imgs/comm/tab_close.gif" width="10" height="10" />
													</a>
												</td>
												<td id="td_tab_r4" class="tab_off_r"></td>
											</tr>
										</table>
									</span>
								</td>
								<td>
									<span id="mdiButton5" style="display: none;">
										<table border="0" cellspacing="0" cellpadding="0" onClick="activeMdiPopup(5)" onMouseOver="this.style.cursor='hand'">
											<tr>
												<td id="td_tab_l5" class="tab_off_l"></td>
												<td><div id="td_tab_c5" class="tab_off_c"></div></td>
												<td id="td_tab_x5" class="tab_off_x">
													<a href="#" onfocus="this.blur()" onClick="destroyMdiPopup(5)">
														&nbsp;<img src="/pot/imgs/comm/tab_close.gif" width="10" height="10" />
													</a>
												</td>
												<td id="td_tab_r5" class="tab_off_r"></td>
											</tr>
										</table>
									</span>
								</td>
								<td>
									<span id="mdiButton6" style="display: none;">
										<table border="0" cellspacing="0" cellpadding="0" onClick="activeMdiPopup(6)" onMouseOver="this.style.cursor='hand'">
											<tr>
												<td id="td_tab_l6" class="tab_off_l"></td>
												<td><div id="td_tab_c6" class="tab_off_c"></div></td>
												<td id="td_tab_x6" class="tab_off_x">
													<a href="#" onfocus="this.blur()" onClick="destroyMdiPopup(6)">
														&nbsp;<img src="/pot/imgs/comm/tab_close.gif" width="10" height="10" />
													</a>
												</td>
												<td id="td_tab_r6" class="tab_off_r"></td>
											</tr>
										</table>
									</span>
								</td>
								<td>
									<span id="mdiButton7" style="display: none;">
										<table border="0" cellspacing="0" cellpadding="0" onClick="activeMdiPopup(7)" onMouseOver="this.style.cursor='hand'">
											<tr>
												<td id="td_tab_l7" class="tab_off_l"></td>
												<td><div id="td_tab_c7" class="tab_off_c"></div></td>
												<td id="td_tab_x7" class="tab_off_x">
													<a href="#" onfocus="this.blur()" onClick="destroyMdiPopup(7)">
														&nbsp;<img src="/pot/imgs/comm/tab_close.gif" width="10" height="10" />
													</a>
												</td>
												<td id="td_tab_r7" class="tab_off_r"></td>
											</tr>
										</table>
									</span>
								</td>
								<td>
									<span id="mdiButton8" style="display: none;">
										<table border="0" cellspacing="0" cellpadding="0" onClick="activeMdiPopup(8)" onMouseOver="this.style.cursor='hand'">
											<tr>
												<td id="td_tab_l8" class="tab_off_l"></td>
												<td><div id="td_tab_c8" class="tab_off_c"></div></td>
												<td id="td_tab_x8" class="tab_off_x">
													<a href="#" onfocus="this.blur()" onClick="destroyMdiPopup(8)">
														&nbsp;<img src="/pot/imgs/comm/tab_close.gif" width="10" height="10" />
													</a>
												</td>
												<td id="td_tab_r8" class="tab_off_r"></td>
											</tr>
										</table>
									</span>
								</td>
								<td>
									<span id="mdiButton9" style="display: none;">
										<table border="0" cellspacing="0" cellpadding="0" onClick="activeMdiPopup(9)" onMouseOver="this.style.cursor='hand'">
											<tr>
												<td id="td_tab_l9" class="tab_off_l"></td>
												<td><div id="td_tab_c9" class="tab_off_c"></div></td>
												<td id="td_tab_x9" class="tab_off_x">
													<a href="#" onfocus="this.blur()" onClick="destroyMdiPopup(9)">
														&nbsp;<img src="/pot/imgs/comm/tab_close.gif" width="10" height="10" />
													</a>
												</td>
												<td id="td_tab_r9" class="tab_off_r"></td>
											</tr>
										</table>
									</span>
								</td>
								<td>
									<span id="mdiButton10" style="display: none;">
										<table border="0" cellspacing="0" cellpadding="0" onClick="activeMdiPopup(10)" onMouseOver="this.style.cursor='hand'">
											<tr>
												<td id="td_tab_l10" class="tab_off_l"></td>
												<td><div id="td_tab_c10" class="tab_off_c"></div></td>
												<td id="td_tab_x10" class="tab_off_x">
													<a href="#" onfocus="this.blur()" onClick="destroyMdiPopup(10)">
														&nbsp;<img src="/pot/imgs/comm/tab_close.gif" width="10" height="10" />
													</a>
												</td>
												<td id="td_tab_r10" class="tab_off_r"></td>
											</tr>
										</table>
									</span>
								</td>
								<td>
									<span id="mdiButton11" style="display: none;">
										<table border="0" cellspacing="0" cellpadding="0" onClick="activeMdiPopup(11)" onMouseOver="this.style.cursor='hand'">
											<tr>
												<td id="td_tab_l11" class="tab_off_l"></td>
												<td><div id="td_tab_c11" class="tab_off_c"></div></td>
												<td id="td_tab_x11" class="tab_off_x">
													<a href="#" onfocus="this.blur()" onClick="destroyMdiPopup(11)"> <img src="/pot/imgs/comm/tab_close.gif" width="10" height="10" /></a></td>
												<td id="td_tab_r11" class="tab_off_r"></td>
											</tr>
										</table>
									</span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- <div id='tmp2' style="visible: none"></div> -->

<!-- <form name="myForm" target="myhiddenFrame"> -->
<!-- 	<input type="hidden" name="usr_cd"> -->
<!-- 	<input type="hidden" name="usr_nm"> -->
<!-- </form> -->

<!-- <iframe name="myhiddenFrame" style="display: none;"></iframe> -->

</body>
</HTML>
