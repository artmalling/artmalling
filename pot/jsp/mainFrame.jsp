<%
/*******************************************************************************
 * 시스템명 : 한국후지쯔 통합정보시스템
 * 작 성 일 : 2010.12.12
 * 작 성 자 : FKL
 * 수 정 자 :
 * 파 일 명 : mainFrame.jsp
 * 버    전 : 1.0
 * 개    요 : 메인 화면
 * 이    력 :
 ******************************************************************************/
%>
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty, java.util.List, java.util.Map, common.util.PagingHelper"   %>

<%@ taglib prefix="ajax" uri="/WEB-INF/tld/ajax-lib.tld"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"     prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"  prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"      prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"   prefix="button" %>

<ajax:library /> 

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정												*-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String viewLevel = Util.getViewLevel(request);

	int todoCnt      	= 13;
	int iTableHeight 	= 465;	//iFrame 사이즈
	int iDivTableHeight = 490;	//Tab 사이즈

	boolean showGragh = true;
	if(viewLevel.equals("2")){
		//그래프를 볼 레벨 설정 viewLevel: 공통코드TC02
		//showGragh = false;
		showGragh = true;
	}
	if(showGragh){
		iTableHeight	= 115;//20161130사이즈수정
		iDivTableHeight = 170;
		todoCnt   		= 6;
	}

	String dir				= BaseProperty.get("context.common.dir");
	List tempList			= null;

	// 날씨관련 선언
	Map  weatherMap			= (Map)  request.getAttribute("weatherMap");
	List weatherCastList	= (List) request.getAttribute("weatherCastList");
	String strWthrIcon		= null;
	String strWthrMinTemp	= null;
	String strWthrMaxTemp	= null;
	String strWthrRain		= null;

	// TO DO LIST
	List toDoList		= (List) request.getAttribute("toDoList");
	String strToDoName	= null;
	String strToDoUrl	= null;
	String strToDoLcode	= null;
	String strToDoMcode	= null;
	String strToDoPid	= null;
	String strToDoTitle	= null;

	// 배너관련
	List bannerList		= (List) request.getAttribute("bannerList");
	String strBanName	= null;
	String strBanLink	= null;
	String strFileNm	= null;

%>
<HTML>
<HEAD>
<title>형지 아트몰링 통합정보시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"  type="text/javascript"></script>
</HEAD>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                  *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var gTabMark	="N";
var gTabPlan	="N";
var gTabManage	="N";
var gTabSystem	="N";
var gTabEtc		="N";

var top = 230;		// 매출속보 영업 사이즈 자동리사이즈
function openNotice(noticeFlag){
	frame = window.external.GetFrame(window);
	frame.Provider('../').OuterWindow.parent.leftFrame.urlLink("TCOM201", "/pot/tcom201.tc?goTo=list&noticeFlag="+noticeFlag,  "TCOM", "02",  "공지사항관리");
}

function setDummyFocus(){
	try{
		initTab("TB_NORMAL");
		document.all.iNotiFrameAll.src="/pot/tcom001.tc?goTo=showNotiAll&iCurrRow=1" ; // MainLoad시 부하 생겨 전체공지만 조회
		window.external.GetFrame(window).Provider('../').OuterWindow.parent.leftFrame.TV_MAIN.focus();

	} catch(e) {}
	

	// 매출속보 영업 사이즈 자동리사이즈
	var obj   = document.getElementById("iSaleFream"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
}


//배너 클릭 시 링크 popup
function bannerPop(strUrl){
	window.open(strUrl);
}

//ToDoList
function openMdiFrame(strToDoUrl, strToDoLcode, strToDoMcode, strToDoPid, strToDoTitle){
	try{
		window.external.GetFrame(window).Provider('../').OuterWindow.top.leftFrame.urlLink(strToDoPid, strToDoUrl, strToDoLcode, strToDoMcode, strToDoTitle);
	} catch(e){}

}


//일자 클릭 시 케이웨더사이트  popup
function weatherPop(gbn){
	var strUrl = "";
	if(gbn=="0")
		strUrl = "http://www.kweather.co.kr/current/current_1.htm";
	else
		strUrl = "http://www.kweather.co.kr/weekend/weekend.htm";

	window.open(strUrl, "wetherPop");
}

// Tab클릭시 데이터 조회 (한번)
function changeTabMark()
{
	if(gTabMark=="N") document.all.iNotiFrameMark.src="/pot/tcom001.tc?goTo=showNotiMark&iCurrRow=1" ;
	gTabMark ="Y";
}

function changeTabManage()
{
	if(gTabManage=="N") document.all.iNotiFrameManage.src="/pot/tcom001.tc?goTo=showNotiManage&iCurrRow=1" ;
	gTabManage ="Y";
}

function changeTabPlan()
{
	if(gTabPlan=="N") document.all.iNotiFramePlan.src="/pot/tcom001.tc?goTo=showNotiPlan&iCurrRow=1" ;
	gTabPlan ="Y";
}

function changeTabSystem()
{
	if(gTabSystem=="N") document.all.iNotiFrameSystem.src="/pot/tcom001.tc?goTo=showNotiSystem&iCurrRow=1" ;
	gTabSystem ="Y";
}

function changeTabEtc()
{
	alert("1");
	if(gTabEtc=="N") document.all.iNotiFrameEtc.src="/pot/tcom001.tc?goTo=showNotiEtc&iCurrRow=1" ;
	gTabEtc ="Y";
}
-->
</script>
</head>

<body class="PL10 PT05" onload="setDummyFocus();">
<div id="testdiv" style="overflow-x:hidden; overflow-y:auto; height:100%; width:100%; padding-right:5px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr valign="top">
			<td width="100%">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<!-- 1. Start -->
						<td valign="top">
							<table width="100%" border="0" cellpadding="0" cellspacing="0" >
					
								<!-- 공지 Start-->
								<tr>
									<td class="PT01 PB03">
										<!--tab start -->
										<table width="100%" border="0" cellpadding="0" cellspacing="0" >
											<tr>
												<td class="PT01 PB03 PR15" width="*">
													<!--tab start -->
													<div id=TB_NORMAL width="100%"  height="<%=iDivTableHeight %>" TitleWidth=80 TitleAlign="center" TitleGap=3 style="border: 3px">
														<menu TitleName="전체공지"	DivId="tabNotiAll"     	/>
														<!--
														<menu TitleName="영업" 	    DivId="tabNotiMark"    	ClickBfFunc="changeTabMark" />
														<menu TitleName="영업기획" 	DivId="tabNotiPlan"  	ClickBfFunc="changeTabPlan" />
														<menu TitleName="경영지원" 	DivId="tabNotiManage"  	ClickBfFunc="changeTabManage" />
														<menu TitleName="시스템" 	DivId="tabNotiSystem"  	ClickBfFunc="changeTabSystem" />
														<menu TitleName="기타" 		DivId="tabNotiEtc"  	ClickBfFunc="changeTabEtc" />
														-->
													</div>
												<!-- tab end -->
												
												</td>
												<td width="725">
													<span class="main_font">날씨정보</span>
												</td>
											</tr>
											
											<tr height=<%=iTableHeight %>>
												<td>
												
													<!--  1. 전체공지  --------------------------------------------------- -->
													<div id=tabNotiAll width="100%">														
														<iFrame id="iNotiFrameAll" width="100%" height=<%=iTableHeight %> style="overflow:hidden;" class="notice_ifbox"></iFrame>
													</div>
											
													<!--  2. 마케팅공지  --------------------------------------------------- -->
													<!--
													<div id="tabNotiMark" width="100%" style="position: absolute; top:26px;">
														<iFrame id="iNotiFrameMark" width="100%" height=<%=iTableHeight %> style="overflow:hidden;"></iFrame>
													</div>
													-->
											
													<!--  3. 영업기획공지  --------------------------------------------------- -->
													<!--
													<div id="tabNotiPlan" width="100%" style="position: absolute; top:26px;">
														<iFrame id="iNotiFramePlan" width="100%" height=<%=iTableHeight %> style="overflow:hidden;"></iFrame>
													</div>
													-->
											
													<!--  4. 경영지원공지  --------------------------------------------------- -->
													<!--
													<div id="tabNotiManage" width="100%" style="position: absolute; top:26px;">
														<iFrame id="iNotiFrameManage" width="100%" height=<%=iTableHeight %> style="overflow:hidden;"></iFrame>
													</div>
													-->
											
													<!--  5. 시스템공지  --------------------------------------------------- -->
													<!--
													<div id="tabNotiSystem" width="100%" style="position: absolute; top:26px;">
														<iFrame id="iNotiFrameSystem" width="100%" height=<%=iTableHeight %> style="overflow:hidden;"></iFrame>
													</div>
													-->
											
													<!--  6. 기타공지  --------------------------------------------------- -->
													<!--
													<div id="tabNotiEtc" width="100%" style="position: absolute; top:26px;">
														<iFrame id="iNotiFrameEtc" width="100%" height=<%=iTableHeight %> style="overflow:hidden;"></iFrame>
													</div>
													-->
												
												</td>
												<td valign="top">
													<!-- 날씨 부분 시작 -->
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td style='background-repeat: no-repeat; background-image: url(/pot/imgs/weather/weather_bg.jpg);'>
																<div style='width: 100%; height: 100%; overflow: hidden; padding:10px'>
<!--  											background-image: url( http://vortex.accuweather.com/adcbin/netweather_v2/backgrounds/tornado_728x90_bg.jpg );  -->
																	
																	<div style='height: 100%;'>
																		<object type='application/x-shockwave-flash' data='http://netweather.accuweather.com/adcbin/netweather_v2/netwx-v211.swf' height='100' width='100%' align='top'>
																			<param name='movie' value='http://netweather.accuweather.com/adcbin/netweather_v2/netwx-v211.swf' />
																			<param name='allowScriptAccess' value='never' />
																			<param name='allowNetworking' value='internal' />
																			<param name='quality' value='high' />
																			<param name='scale' value='noscale' />
																			<param name='salign' value='lt' />
																			<param name='wmode' value='transparent' />
																			<param name='bgcolor' value='#ffffff' />
																			<param name='flashvars' value='partner=netweather&myspace=1&logo=1&tStyle=normal&zipcode=ASI|KR|KS013|BUSAN|&lang=eng&size=211&theme=1&metric=1' />
																		</object>
																	</div>
																</div>
															</td>
														</tr>
													</table>
													<!-- 날씨 부분 종료 -->
												</td>
											</tr>
										</table>
									<!-- tab end -->
									</td>
								</tr>
							<!-- 공지End -->
					
								<!--관리자 매출속보등의 메뉴 Start  -->
					
								<% if(showGragh){ %>
								<tr>
									<td class="PT10" colspan="2">
										<iframe id="iSaleFream" width="100%" height="500" style="overflow:hidden;" src="/pot/tcom001.tc?goTo=showSale_art"></iframe>
									</td>
								</tr>
								<% } %>
					
								<!--관리자 매출속보등의 메뉴 공지End  -->
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
</body>
</html>
