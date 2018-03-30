<!-- 
/*******************************************************************************
 * 시스템명	: 백화점 영업관리 > 매출관리 >	매출실적
 * 작 성 일 : 2010.06.20
 * 작 성 자 : 박종은
 * 수 정 자 : 홍종영
 * 파 일 명 : psal3090.jsp
 * 버	전 :	1.0	(버전은 1.0부터 시작하며	0.1씩 증가)
 * 개	요 :	추세율현황(월별)
 * 이	력 :2010.06.20 박종은
 * 		   2012.07.17 홍종영(차트 변경)
 ******************************************************************************/
-->

<%@	page language="java" contentType="text/html;charset=utf-8"
   import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"
%>
<%
	request.setCharacterEncoding("utf-8");
	SessionInfo	sessionInfo	= (SessionInfo)session.getAttribute("sessionInfo");
%>
<%@	taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@	taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@	taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@	taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정											   *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
   String dir =	BaseProperty.get("context.common.dir");
%>

<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet"	type="text/css">
<script	language="javascript" src="/<%=dir%>/js/common.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/gauce.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/global.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/message.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/popup.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/popup_dps.js"	type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/popup_mss.js"	type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/popup_dcs.js"	type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/shiftchart.js"	type="text/javascript"></script>



<!--*************************************************************************-->
<!--* B. 스크립트 시작															*-->
<!--*************************************************************************-->

<script	LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개	 요 : 해당	페이지	LOAD 시	
 * return값 : void
 */
//var top = 160;		//해당화면의 동적그리드top위치
var top = 640;		//해당화면의 동적그리드top위치

function doInit(){
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top-100) + "px";
	
	var obj   = document.getElementById("GD_MASTER2"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top+100) + "px";
	
	var obj   = document.getElementById("GD_MASTER3"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top+100) + "px";
	
	var obj   = document.getElementById("GD_MASTER4"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	// Input Data Set Header 초기화
	
	// Output Data Set Header 초기화
	DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
	DS_O_MASTER2.setDataHeader('<gauce:dataset name="H_SEL_MASTER2"/>');
	DS_O_MASTER3.setDataHeader('<gauce:dataset name="H_SEL_MASTER3"/>');
	DS_O_MASTER4.setDataHeader('<gauce:dataset name="H_SEL_MASTER4"/>');
	
	
	//그리드 초기화
	gridCreate1(); //마스터
	gridCreate2(); //마스터
	gridCreate3(); //마스터
	gridCreate4(); //마스터
	
	
	// EMedit에 초기화
	
	initEmEdit(EM_SALE_DT_S,					  "YYYYMMDD",				   PK);	  //매출시작일자
	EM_SALE_DT_S.alignment = 1;


	//현재년도 셋팅
	EM_SALE_DT_S.text =	 varToday;

	initEmEdit(EM_SALE_CMPRDT_S,					  "YYYYMM",				   PK);	  //대비시작일자
	EM_SALE_CMPRDT_S.alignment = 1;

	//현재년도 셋팅
	EM_SALE_CMPRDT_S.text =	 varToMon;

	//콤보 초기화
	initComboStyle(LC_STR_CD,DS_STR_CD,	"CODE^0^30,NAME^0^140",	1, PK);				 //점(조회)
	
	//팀
	initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1,	PK);			//팀(조회)
	
	//파트
	initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1,	NORMAL);			//파트(조회)

	//PC
	initComboStyle(LC_PC_CD,DS_PC_CD, "CODE^0^30,NAME^0^80", 1,	NORMAL);				//PC(조회)
	
	//단위
	initComboStyle(EM_UNIT, DS_UNIT, "CODE^0^30,NAME^0^80", 1, NORMAL);
	
	var	strcd	= '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';			  // 로그인 점코드   
	var	strOrgFlag=EM_ORG_FLAG.CodeValue;//'<c:out value="${sessionScope.sessionInfo.ORG_FLAG}"	/>';	
	   
	getStore2("DS_STR_CD", "Y",	"1", "N", strOrgFlag);													//점	  
	getDept2("DS_DEPT_CD", "Y",	LC_STR_CD.BindColVal, "N", "", strOrgFlag);								   // 팀	
	getTeam2("DS_TEAM_CD", "Y",	LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);			 //	파트	 
	getPc2("DS_PC_CD", "Y",	LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,	 "Y", "", strOrgFlag);// PC	 
	getEtcCode("DS_UNIT"    , "D", "P622", "N"); 		// 단위
	
	LC_STR_CD.BindColVal  =	strcd;	 
	LC_DEPT_CD.Index = 0;
	LC_TEAM_CD.Index = 0;
	LC_PC_CD.Index	 = 0;
	EM_UNIT.Index 	 = 1;
	
	var	orgFlag	= '<c:out value="${sessionScope.orgFlag}" />';
	
	orgFlagCheck(orgFlag);

	EM_SALE_CMPRDT_S.Text = varBf_Year_Mon; 
	
	GD_MASTER.focus();
	LC_STR_CD.Focus();
	
	//기본설정
// 	StartAdd();		// 처음 보이는 화면에 기본 타입을 보여주기 위해 설정
	
	//사용되는 데이터셋	등록 ( 종료시 데이터 변경	체크)( common.js )
	//registerUsingDataset("psal309","DS_O_MASTER" );
	
	
	
}

function gridCreate1(){
	var	hdrProperies = //'<FC>id={currow}				name="NO"		width=30	align=center	</FC>'
					   '<FC>id=GUBUN				name="구분"		width=80	align=center  bgcolor="#E0E6F8"	</FC>'
					 + '<C>id=D01					name="1"	    width=100	align=right	 </C>'
					 + '<C>id=D02					name="2"	    width=100	align=right	 </C>'
					 + '<C>id=D03					name="3"	    width=100	align=right	 </C>'
					 + '<C>id=D04					name="4"	    width=100	align=right	 </C>'
					 + '<C>id=D05					name="5"	    width=100	align=right	 </C>'
					 + '<C>id=D06					name="6"	    width=100	align=right	 </C>'
					 + '<C>id=D07					name="7"	    width=100	align=right	 </C>'
					 + '<C>id=D08					name="8"	    width=100	align=right	 </C>'
					 + '<C>id=D09					name="9"	    width=100	align=right	 </C>'
					 + '<C>id=D10					name="10"	    width=100	align=right	 </C>'
					 + '<C>id=D11					name="11"	    width=100	align=right	 </C>'
					 + '<C>id=D12					name="12"	    width=100	align=right	 </C>'
					 + '<C>id=D13					name="13"	    width=100	align=right	 </C>'
					 + '<C>id=D14					name="14"	    width=100	align=right	 </C>'
					 + '<C>id=D15					name="15"	    width=100	align=right	 </C>'
					 + '<C>id=D16					name="16"	    width=100	align=right	 </C>'
					 + '<C>id=D17					name="17"	    width=100	align=right	 </C>'
					 + '<C>id=D18					name="18"	    width=100	align=right	 </C>'
					 + '<C>id=D19					name="19"	    width=100	align=right	 </C>'
					 + '<C>id=D20					name="20"	    width=100	align=right	 </C>'
					 + '<C>id=D21					name="21"	    width=100	align=right	 </C>'
					 + '<C>id=D22					name="22"	    width=100	align=right	 </C>'
					 + '<C>id=D23					name="23"	    width=100	align=right	 </C>'
					 + '<C>id=D24					name="24"	    width=100	align=right	 </C>'
					 + '<C>id=D25					name="25"	    width=100	align=right	 </C>'
					 + '<C>id=D26					name="26"	    width=100	align=right	 </C>'
					 + '<C>id=D27					name="27"	    width=100	align=right	 </C>'
					 + '<C>id=D28					name="28"	    width=100	align=right	 </C>'
					 + '<C>id=D29					name="29"	    width=100	align=right	 </C>'
					 + '<C>id=D30					name="30"	    width=100	align=right	 </C>'
					 + '<C>id=D31					name="31"	    width=100	align=right	 </C>'
					 + '<C>id=DTOT					name="계"	    width=100	align=right	 </C>'
					 + '<C>id=BIGO					name="진척율"	width=100	align=center bgcolor={decode(QRY_ORD,1,"#E0E6F8","ffffff")}	</C>'
					 ;
		

	initGridStyle(GD_MASTER, "common", hdrProperies, false);
	//합계표시
	//GD_MASTER.ViewSummary =	"1";
	//GD_MASTER.DecRealData =	true;
}

function gridCreate2(){
	var	hdrProperies = '<FC>id={currow}				name="NO"		width=30	align=center	</FC>'
					 + '<FC>id=GUBUN				name="구분"	    width=150	align=left	suppress="1"</FC>'
					 + '<FC>id=SALE_AMT				name="실적"		width=100	align=right		mask="###,###"</FC>'
					 + '<FC>id=RATIO				name="달성율(%)"	width=80	align=right		mask="###.00" </FC>'
					 ;



	initGridStyle(GD_MASTER2, "common", hdrProperies, false);
	//합계표시
	//GD_DETAIL.ViewSummary =	"1";
	//GD_DETAIL.DecRealData =	true;
}

function gridCreate3(){
	var	hdrProperies = '<FC>id={currow}				name="NO"		width=30	align=center	</FC>'
					 + '<FC>id=PART_NM				name="파트"	    width=95	align=left	suppress="1"</FC>'
					 + '<FC>id=FLOR_NM				name="층"		width=70	align=center		</FC>'
					 + '<FC>id=SALE_AMT				name="실적"		width=100	align=right		mask="###,###"</FC>'
					 + '<FC>id=RATIO				name="달성율(%)"	width=80	align=right		mask="###.00" </FC>'
					 ;



	initGridStyle(GD_MASTER3, "common", hdrProperies, false);
	//합계표시
	//GD_DETAIL.ViewSummary =	"1";
	//GD_DETAIL.DecRealData =	true;
}

function gridCreate4(){
	var	hdrProperies = '<FC>id={currow}				name="NO"		width=30	align=center	show=false </FC>'
					 + '<FC>id=PUMBUN_RANK			name="순위"		width=30	align=center	</FC>'
					 + '<FC>id=PUMBUN_NAME			name="브랜드명"  width=150		align=left	</FC>'
					 + '<FC>id=SALE_AMT				name="실적"		width=100	align=right		mask="###,###"</FC>'
					 + '<FC>id=RATIO				name="달성율(%)"	width=80	align=right		mask="###.00" </FC>'
					 ;



	initGridStyle(GD_MASTER4, "common", hdrProperies, false);
	//합계표시
	//GD_DETAIL.ViewSummary =	"1";
	//GD_DETAIL.DecRealData =	true;
}

function orgFlagCheck(orgFlag){	

	if (orgFlag	== "11") {
		EM_ORG_FLAG.Enable = "false";
		EM_ORG_FLAG.Reset();
	}else if (orgFlag == "12") {
		EM_ORG_FLAG.Enable = "true";
		EM_ORG_FLAG.Reset();
	}else{
		EM_ORG_FLAG.Enable = "false";
	}
}
/*************************************************************************
  *	2. 공통버튼
	 (1) 조회		  -	btn_Search(), subQuery()
	 (2) 신규		  -	btn_New()
	 (3) 삭제		  -	btn_Delete()
	 (4) 저장		  -	btn_Save()
	 (5) 엑셀		  -	btn_Excel()
	 (6) 출력		  -	btn_Print()
	 (7) 확정		  -	btn_Conf()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-16
 * 개	요 :	조회시	호출
 * return값 : void
 */
function btn_Search() {
	 
	//마스터, 디테일 그리드 클리어
	DS_O_MASTER.ClearData();
	//DS_O_DETAIL.ClearData();
	
	if(!chkValidation("search")) return;

	var	strStrCd		= LC_STR_CD.BindColVal;		 //점
	var	strDeptCd		= LC_DEPT_CD.BindColVal;	 //팀
	var	strTeamCd		= LC_TEAM_CD.BindColVal;	 //파트
	var	strPCCd			= LC_PC_CD.BindColVal;		 //PC
	var	strSaleDtS		= EM_SALE_DT_S.text;		 //매출월
	var	strSaleCmprDtS	= EM_SALE_CMPRDT_S.text;	 //대비월
	var	strOrgFlag		= EM_ORG_FLAG.CodeValue;
	var strEmUnit 		= EM_UNIT.BindColVal;		 //단위

	var	goTo	   = "searchMaster"	;	 
	var	action	   = "O";	  
	var	parameters = "&strStrCd="			+encodeURIComponent(strStrCd)
				   + "&strDeptCd="			+encodeURIComponent(strDeptCd)
				   + "&strTeamCd="			+encodeURIComponent(strTeamCd)
				   + "&strPCCd="			+encodeURIComponent(strPCCd)
				   + "&strSaleDtS="			+encodeURIComponent(strSaleDtS)
				   + "&strSaleCmprDtS="		+encodeURIComponent(strSaleCmprDtS)
				   + "&strOrgFlag="			+encodeURIComponent(strOrgFlag)
				   + "&strEmUnit="			+encodeURIComponent(strEmUnit)
				   ;
	
	TR_MAIN.Action="/dps/psal309.ps?goTo="+goTo+parameters;	 
	TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)";	//조회는 O
	TR_MAIN.Post();

	GD_MASTER.focus();
	
	searchDetail("2","DS_O_MASTER2");
	searchDetail("3","DS_O_MASTER3");
	searchDetail("4","DS_O_MASTER4");
	
	
	// 조회결과	Return
	//setPorcCount("SELECT", DS_O_MASTER.CountRow);

	//스크롤바 위치 조정
	GD_MASTER.SETVSCROLLING(0);
	GD_MASTER.SETHSCROLLING(0);
	
	
}

/**
 * btn_New()
 * 작 성 자 :	
 * 작 성 일 :	
 * 개	 요 :   
 * return값 : 
 */
function btn_New() {

}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개	요 :	
 * return값 : 
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자 :	
 * 작 성 일 :	
 * 개	 요 :  
 * return값 : void
 */
function btn_Save()	{

	
}

/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개	 요 : 
 * return값 : 
 */
function btn_Excel() {

}


/**
 * btn_Print()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개	 요 : 
 * return값 : 
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개	 요 : 
 * return값 : void
 */

 function btn_Conf() {
 }

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-16
 * 개	요 :	조회시	호출
 * return값 : void
 */
function searchDetail(strSeq, strDsetName) {
	
	 
	obj = document.getElementById(strDsetName);
	obj.ClearData();
	
	var strHeaderName	= "H_SEL_" + strDsetName.substr(5,8);
	 
	var strStrCd		= LC_STR_CD.BindColVal;		 //점
	var	strDeptCd		= LC_DEPT_CD.BindColVal;	 //팀
	var	strTeamCd		= LC_TEAM_CD.BindColVal;	 //파트
	var	strPCCd			= LC_PC_CD.BindColVal;		 //PC
	var	strSaleDtS		= EM_SALE_DT_S.text;		 //매출월
	var	strSaleCmprDtS	= EM_SALE_CMPRDT_S.text;	 //대비월
	var	strOrgFlag		= EM_ORG_FLAG.CodeValue;
	var strEmUnit 		= EM_UNIT.BindColVal;		 //단위

	var	goTo	   = "searchDetail";	 
	var	action	   = "O";	  
	var	parameters = "&strStrCd="			+encodeURIComponent(strStrCd)
				   + "&strDeptCd="			+encodeURIComponent(strDeptCd)
				   + "&strTeamCd="			+encodeURIComponent(strTeamCd)
				   + "&strPCCd="			+encodeURIComponent(strPCCd)
				   + "&strSaleDtS="			+encodeURIComponent(strSaleDtS)
				   + "&strSaleCmprDtS="		+encodeURIComponent(strSaleCmprDtS)
				   + "&strOrgFlag="			+encodeURIComponent(strOrgFlag)
				   + "&strEmUnit="			+encodeURIComponent(strEmUnit)
				   + "&strSeq="				+encodeURIComponent(strSeq)
				   + "&strDsetName="		+encodeURIComponent(strDsetName)
				   + "&strHeaderName="		+encodeURIComponent(strHeaderName)
				   ;
	
	TR_MAIN.Action="/dps/psal309.ps?goTo="+goTo+parameters;	 
	TR_MAIN.KeyValue="SERVLET("+action+":"+strDsetName+"="+strDsetName+")";	//조회는 O
	TR_MAIN.Post();

	
	
	//GD_MASTER.focus();
	// 조회결과	Return
	//setPorcCount("SELECT", DS_O_DETAIL.CountRow);

	//스크롤바 위치 조정
	//GD_DETAIL.SETVSCROLLING(0);
	//GD_DETAIL.SETHSCROLLING(0);	
}

/**
 * chkValidation(gbn)
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개	요 :	 저장
 * return값 : void
 */
function chkValidation(gbn){
	switch (gbn){
	case "search" :

		//점	체크
		if (isNull(LC_STR_CD.BindColVal)==true ) {
			showMessage(Information, OK, "USER-1003","점");
			LC_STR_CD.focus();
			return false;
		}
		/*
		//팀 체크
		if (isNull(LC_DEPT_CD.BindColVal)==true	) {
			showMessage(Information, OK, "USER-1003","팀");
			LC_DEPT_CD.focus();
			return false;
		}

		//PC가 전체가 이닐경우 파트 체크
		if(LC_PC_CD.BindColVal != "%" && LC_TEAM_CD.BindColVal == "%"){
			showMessage(Information, OK, "USER-1003","파트");
			LC_TEAM_CD.focus();
			return false;
		}
		*/
		//매출월
		if (isNull(EM_SALE_DT_S.text) ==true ) {
			showMessage(Information, OK, "USER-1003","매출일자"); 
			EM_SALE_DT_S.focus();
			return false;
		}
		//년월 자릿수, 공백 체크
		if (EM_SALE_DT_S.text.replace("	","").length !=	8 )	{
			showMessage(Information, OK, "USER-1027","매출일자","8");
			EM_SALE_DT_S.focus();
			return false;
		}
		
		//대비일자
		if (isNull(EM_SALE_CMPRDT_S.text) ==true ) {
			showMessage(Information, OK, "USER-1003","대비월"); 
			EM_SALE_CMPRDT_S.focus();
			return false;
		}
		//년월 자릿수, 공백 체크
		if (EM_SALE_CMPRDT_S.text.replace("	","").length !=	6 )	{
			showMessage(Information, OK, "USER-1027","대비월","6");
			EM_SALE_CMPRDT_S.focus();
			return false;
		}
		/*
		if(!isBetweenFromTo(EM_SALE_CMPRDT_S.text, EM_SALE_DT_S.text)){
			showMessage(INFORMATION, OK, "USER-1000","대비월은 매출월보다 작아야 합니다."); 
			EM_SALE_CMPRDT_S.focus();
			return false;
		}
		*/
		break;
   
	}
	return true;
}

function StartAdd(){
	//차트 클리어
	Chart.ClearChart();
	
	//y축 최소값/최대값/증가값/자동값 설정
	SetChartAxisStyle("Chart", "Left", 0,4000000000, 800000000, "true", "true", "false");
	
	//타이틀
	TitleText("Chart", "Footer", "추세율현황(월별)", "black", "14", 2, true);
	
	//Panel 설정
	Chart.Panel.Gradient.Visible = "true";
	Chart.Panel.ForeColor = Chart.ToOLEColor("ced8e0");
	Chart.Panel.Gradient.StartColor =Chart.ToOLEColor("fbdfc6");
	Chart.Panel.Gradient.MidColor =Chart.ToOLEColor("ffffff");
	Chart.Panel.Gradient.EndColor =Chart.ToOLEColor("ffffff");
	
	Chart.Panel.MarginTop = 10;	// Chart1 Panel에서	상단 공백이	차지하는 %
	
	
	//3D 설정
	SetAspectStyle("Chart", "false");
	
	//Zoom 설정
	Chart.Zoom.Enable=false;
}
function Start(){
	//기본설정
	StartAdd();
	//시리즈 추가
	Chart.AddSeries(4);	
	
	//시리즈 1
	Chart.Series(0).DataID				= "DS_O_MASTER_CHART";
	Chart.Series(0).YValues.Column		= "SALE_AMT_TOT";
	Chart.Series(0).PointLabels.Column	= "ORG_NAME";
	Chart.Series(0).Title				= "매출월";
	Chart.Series(0).Color				= Chart.ToOLEColor(SEREIS_COLOR_01);
	Chart.Series(0).ColorEachPoint		= "false";
	Chart.Series(0).asBar.MultiBar		= "1";
	Chart.Series(0).asBar.BarWidth		= "300";
	
	//시리즈 2
	var new_series = 0;
	new_series = Chart.AddSeries(4);
	Chart.Series(new_series).DataID					= "DS_O_MASTER_CHART";
	Chart.Series(new_series).YValues.Column			= "CMPR_SALE_AMT_TOT";
	Chart.Series(new_series).PointLabels.Column		= "ORG_NAME";
	Chart.Series(new_series).Title					= "대비월";
	Chart.Series(new_series).Color					= Chart.ToOLEColor(SEREIS_COLOR_04);
	Chart.Series(new_series).ColorEachPoint			= "false";
	Chart.Series(new_series).asBar.MultiBar			= "1";
	Chart.Series(new_series).asBar.BarWidth			= "300";

	//차트 리로드
	Chart.reset();
}

function xx(){
	DS_O_MASTER_CHART.ClearData();

	var strSale = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SALE_AMT_TOT");
	var strCmpr  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"CMPR_SALE_AMT_TOT");
	var strOrg  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"ORG_NAME");

	DS_O_MASTER_CHART.addRow();
	DS_O_MASTER_CHART.NameValue(1,"SALE_AMT_TOT") = strSale;
	DS_O_MASTER_CHART.NameValue(1,"CMPR_SALE_AMT_TOT") = strCmpr;
	DS_O_MASTER_CHART.NameValue(1,"ORG_NAME") = strOrg;
}



</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝															*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리														*-->
<!--*	 1.	TR Success 메세지 처리
<!--*	 2.	TR Fail	메세지	처리
<!--*	 3.	DataSet	Success	메세지	처리
<!--*	 4.	DataSet	Fail 메세지 처리
<!--*	 5.	DataSet	이벤트	처리
<!--*************************************************************************-->
<!---------------------	1. TR Success 메세지 처리  ---------------------------->
<script	language=JavaScript	for=TR_MAIN	event=onSuccess>
	for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
	}
</script>

<!---------------------	2. TR Fail 메세지 처리  ------------------------------->
<script	language=JavaScript	for=TR_MAIN	event=onFail>
	trFailed(TR_MAIN.ErrorMsg);
</script>
<!---------------------	1. TR Success 메세지 처리  ---------------------------->
<script	language=JavaScript	for=TR_DETAIL event=onSuccess>
	for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++)	{
		showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
	}
</script>

<!---------------------	2. TR Fail 메세지 처리  ------------------------------->
<script	language=JavaScript	for=TR_DETAIL event=onFail>
	trFailed(TR_DETAIL.ErrorMsg);
</script>



<!---------------------	3. DataSet Success 메세지 처리  ----------------------->
<!---------------------	4. DataSet Fail	메세지	처리	-------------------------->
<!---------------------	5. DataSet 이벤트 처리  ------------------------------->
<!---------------------	6. 컴포넌트	이벤트	처리	------------------------------>

<script	language=JavaScript	for=GD_MASTER event=OnClick(row,colid)>
	
	//sortColId( eval(this.DataID), row, colid); //헤더	클릭시	정렬

</script>

<script	language=JavaScript	for=DS_O_MASTER	event=OnRowPosChanged(row)>
if(row > 0 && old_Row >	0){	 
	//search_Detail();

	//xx();
	
// 	Start();
}
old_Row	= row;
</script>

<script	language=JavaScript	for=GD_DETAIL event=OnClick(row,colid)>
	//sortColId( eval(this.DataID), row, colid); //헤더	클릭시	정렬
</script>

<script	language="javascript">
	var	today	 = new Date();
	var	old_Row	= 0;
	var	searchChk =	"";

	// 오늘 일자 셋팅	
	var	now	= new Date();
	var	mon	= now.getMonth()+1;
	if(mon < 10)mon	= "0" +	mon;
	var	day	= now.getDate();
	if(day < 10)day	= "0" +	day;
	var varbfYear= now.getYear()-1; //전년도
	var	varToday = now.getYear().toString()+ mon + day;
	var	varToMon = now.getYear().toString()+ mon;
	var	varBf_Year_Mon = varbfYear.toString()+ mon;
</script>
<!-- 조직	구분	변경시	 -->
<script	language=JavaScript	for=EM_ORG_FLAG	event=OnSelChange()>
	if(EM_ORG_FLAG.CodeValue=="1"){
		
		var	strOrgFlag=EM_ORG_FLAG.CodeValue;
		var	strcd	= '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';			  // 로그인 점코드
		getStore2("DS_STR_CD", "Y",	"1", "N", strOrgFlag);													 //점		
		getDept2("DS_DEPT_CD", "Y",	LC_STR_CD.BindColVal, "N", "", strOrgFlag);									 //	팀		
		getTeam2("DS_TEAM_CD", "Y",	LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);			 //	파트		
		getPc2("DS_PC_CD", "Y",	LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,	 "Y", "", strOrgFlag);// PC		 
		
		LC_STR_CD.BindColVal=strcd;
		LC_DEPT_CD.Index = 0;
		LC_TEAM_CD.Index = 0;
		LC_PC_CD.Index	 = 0; 
	}else if(EM_ORG_FLAG.CodeValue=="2"){
		
		var	strOrgFlag=EM_ORG_FLAG.CodeValue;	
		var	strcd	= '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';			  // 로그인 점코드
		getStore2("DS_STR_CD", "Y",	"1", "N", strOrgFlag);													 //점		
		getDept2("DS_DEPT_CD", "Y",	LC_STR_CD.BindColVal, "N", "", strOrgFlag);									 //	팀		
		getTeam2("DS_TEAM_CD", "Y",	LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);			 //	파트		
		getPc2("DS_PC_CD", "Y",	LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,	 "Y", "", strOrgFlag);// PC	 
		 
		LC_STR_CD.BindColVal = strcd;
		LC_DEPT_CD.Index = 0;
		LC_TEAM_CD.Index = 0;
		LC_PC_CD.Index	 = 0;
	}
</script>
<!-- 점(조회)	변경시	 -->
<script	language=JavaScript	for=LC_STR_CD event=OnSelChange()>
	var	strOrgFlag=EM_ORG_FLAG.CodeValue;
	getDept2("DS_DEPT_CD", "Y",	LC_STR_CD.BindColVal, "N", "", strOrgFlag);									 //	팀		
	getTeam2("DS_TEAM_CD", "Y",	LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);			 //	파트		
	getPc2("DS_PC_CD", "Y",	LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,	 "Y", "", strOrgFlag);// PC	
	LC_DEPT_CD.Index = 0;
	LC_TEAM_CD.Index = 0;
	LC_PC_CD.Index	 = 0;
</script>

<!-- 팀(조회)	 변경시  -->
<script	language=JavaScript	for=LC_DEPT_CD event=OnSelChange()>
	var	strOrgFlag=EM_ORG_FLAG.CodeValue;
	if(LC_DEPT_CD.BindColVal !=	"%"){
		getTeam2("DS_TEAM_CD", "Y",	LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);			 //	파트	
	}else{
		DS_TEAM_CD.ClearData();
		insComboData( LC_TEAM_CD, "%", "전체",1);
		DS_PC_CD.ClearData();
		insComboData( LC_PC_CD,	"%", "전체",1);
	}
	LC_TEAM_CD.Index = 0;
</script>

<!-- TEAM(조회)  변경시	-->
<script	language=JavaScript	for=LC_TEAM_CD event=OnSelChange()>
	var	strOrgFlag=EM_ORG_FLAG.CodeValue;
	if(LC_TEAM_CD.BindColVal !=	"%"){
		getPc2("DS_PC_CD", "Y",	LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,	 "Y", "", strOrgFlag);// PC	  
	}else{
		DS_PC_CD.ClearData();
		insComboData( LC_PC_CD,	"%", "전체",1);
	}
	LC_PC_CD.Index	 = 0;
</script>

<!-- 매출시작일 -->
<script	language=JavaScript	for=EM_SALE_DT_S event=onKillFocus()>

	//영업조회일
	if (isNull(EM_SALE_DT_S.text) ==true ) {
		showMessage(Information, OK, "USER-1003","매출일자"); 
		EM_SALE_DT_S.text =	varToday;
		return ;
	}
	//영업조회일	자릿수, 공백	체크
	if (EM_SALE_DT_S.text.replace("	","").length !=	8 )	{
		showMessage(Information, OK, "USER-1027","매출일자","8");
		EM_SALE_DT_S.text =	varToday;
		return ;
	}
	//일자형식체크
	if (!checkYYYYMMDD(EM_SALE_DT_S.text)	) {
		showMessage(Information, OK, "USER-1069","매출일자");
		EM_SALE_DT_S.text =	varToday;
		return ;
	}

</script>


<!-- 대비시작일 -->
<script	language=JavaScript	for=EM_SALE_CMPRDT_S event=onKillFocus()>

	//영업조회일
	if (isNull(EM_SALE_CMPRDT_S.text) ==true ) {
		showMessage(Information, OK, "USER-1003","대비월"); 
		EM_SALE_CMPRDT_S.text =	varToMon;
		return ;
	}
	//영업조회일	자릿수, 공백	체크
	if (EM_SALE_CMPRDT_S.text.replace("	","").length !=	6 )	{
		showMessage(Information, OK, "USER-1027","대비월","6");
		EM_SALE_CMPRDT_S.text =	varToMon;
		return ;
	}
	//일자형식체크
	if (!checkYYYYMM(EM_SALE_CMPRDT_S.text)	) {
		showMessage(Information, OK, "USER-1069","대비월");
		EM_SALE_CMPRDT_S.text =	varToMon;
		return ;
	}

</script>




<script	language="JavaScript" for=Chart	event="OnFunctionCalculate(SeriesIndex,	X, Y)">
	
	// Add your	specialized	code here
	
	Chart.Series(SeriesIndex).FunctionType.asCustom.Y =	Y;
</script>



<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리	끝													*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의										*-->
<!--*	 1.	DataSet
<!--*	 2.	Transaction
<!--*************************************************************************-->

<!---------------------	1. DataSet	------------------------------------------->
<!-- =============== Input용	-->
<!-- 검색용 -->

<comment id="_NSID_"><object	id="DS_STR_CD"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object	id="DS_DEPT_CD"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object	id="DS_TEAM_CD"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object	id="DS_PC_CD"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object	id="DS_I_COMMON"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object	id="DS_O_RESULT"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object	id="DS_I_CONDITION"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object	id="DS_O_MASTER"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object	id="DS_O_MASTER2"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object	id="DS_O_MASTER3"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object	id="DS_O_MASTER4"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object	id="DS_UNIT"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>


<!---------------------	2. Transaction	--------------------------------------->

<comment id="_NSID_">
	<object	id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
		<param name="KeyName" value="Toinb_dataid4">
	</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
	<object	id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
		<param name="KeyName" value="Toinb_dataid4">
	</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝									*-->
<!--*************************************************************************-->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	//var obj   = document.getElementById("GD_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>

<!--*************************************************************************-->
<!--* E. 본문시작																*-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">
<!--공통 타이틀/버튼 -->
<%@	include	file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<div id="testdiv" class="testdiv">

<table width="100%"	border="0" cellspacing="0" cellpadding="0">
   <tr>
	  <td class="PT01 PB03">
	  <table width="100%" border="0" cellspacing="0" cellpadding="0"
		 class="o_table">
		 <tr>
			<td>
			<table width="100%"	border="0" cellpadding="0" cellspacing="0"
			   class="s_table">
			   <!--tr>
				  <th width="70">조직구분</th>
				  <td width="105" colspan="7" -->
					<comment id="_NSID_">
					<object	id="EM_ORG_FLAG" classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20;	width:95" style="display:none">
					<param name=Cols	value="2">
					<param name=Format	value="1^매장,2^매입">	
					<param name=CodeValue  value="<%=sessionInfo.getORG_FLAG()%>">
					</object>  
					</comment><script> _ws_(_NSID_);</script> 
				  <!--/td>
			   </tr-->
			   <tr>
				  <th width="70" class="point">점</th>
				  <td width="105" colspan="5"><comment id="_NSID_">	<object
					 id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%>	width=95 tabindex=1	
					 align="absmiddle">	</object> </comment><script>_ws_(_NSID_);</script></td>
				  <!--th width="70"  class="point">팀</th-->
				  <!--  td width="105"--><comment id="_NSID_">	<object
					 id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
					 align="absmiddle" style="display:none">	</object> </comment><script>_ws_(_NSID_);</script></td>
				  <!--th width="70" >파트</th>
				  <td width="105"--><comment id="_NSID_">	<object
					 id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
					 align="absmiddle" style="display:none">	</object> </comment><script>_ws_(_NSID_);</script></td>
				  <!--th width="70">PC</th>
				  <td --><comment	id="_NSID_"> <object
					 id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95	tabindex=1 
					 align="absmiddle" style="display:none">	</object> </comment><script>_ws_(_NSID_);</script></td>
			   </tr>
			   <tr>
				  <th class="point">매출월</th>
				  <td ><comment id="_NSID_">	<object
					 id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%>	width=72
					 tabindex=1	align="absmiddle"> </object> </comment>	<script> _ws_(_NSID_);</script>
				  <img src="/<%=dir%>/imgs/btn/date.gif"
					 onclick="javascript:openCal('G',EM_SALE_DT_S)"	align="absmiddle" />
				  </td>
				  <!--th class="point">대비월</th>
				  <td --><comment id="_NSID_">	<object
					 id=EM_SALE_CMPRDT_S classid=<%=Util.CLSID_EMEDIT%>	width=72
					 tabindex=1	align="absmiddle" style="display:none"> </object> </comment>	<script> _ws_(_NSID_);</script>
				  <img src="/<%=dir%>/imgs/btn/date.gif"
					 onclick="javascript:openCal('M',EM_SALE_CMPRDT_S)"	align="absmiddle"  style="display:none"/>
				  </td>
				  <th width = "70"> 단위</th>
				  <td width = "1350" colspan="4">
				     <comment id="_NSID_"> <object	
				     id=EM_UNIT classid=<%=Util.CLSID_LUXECOMBO%> width=95	
				     tabindex=1 align="absmiddle"> </object> </comment>	<script>_ws_(_NSID_);</script>
				  </td>
			   </tr>
			</table>
			</td>
		 </tr>
	  </table>
	  </td>
   </tr>

   <tr>
	  <td class="dot"></td>
   </tr>


   <tr valign="top">
	  <td>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
		 <tr valign="top">
			<td	width="100%"	class="PR03" colspan="2">
			<table width="100%"	border="0" cellspacing="0" cellpadding="0"
			   class="BD4A">
			   <tr>
				  <td width="100%" >
				  <comment id="_NSID_">	<object
					 id=GD_MASTER width=100% height=0	classid=<%=Util.CLSID_GRID%> tabindex=1>
					 <param	name="DataID" value="DS_O_MASTER">
				  </object>	</comment><script>_ws_(_NSID_);</script></td>
			   </tr>
			</table>
			</td>
		 </tr>
		 <tr>
			<td	width="50%"	class="PR03">
			<table width="100%"	border="0" cellspacing="0" cellpadding="0"
			   class="BD4A">
			   <tr>
				  <td width="100%">
				  <comment id="_NSID_">	<object
					 id=GD_MASTER2 width=100% height=0	classid=<%=Util.CLSID_GRID%> tabindex=1>
					 <param	name="DataID" value="DS_O_MASTER2">
				  </object>	</comment><script>_ws_(_NSID_);</script></td>
			   </tr>
			</table>
			</td>
			<td	width="50%">
			<table width="100%"	border="0" cellspacing="0" cellpadding="0"
			   class="BD4A">
			   <tr>
				  <td width="100%">
				  <comment id="_NSID_">	<object
					 id=GD_MASTER3 width=100% height=0	classid=<%=Util.CLSID_GRID%> tabindex=1>
					 <param	name="DataID" value="DS_O_MASTER3">
				  </object>	</comment><script>_ws_(_NSID_);</script></td>
			   </tr>
			</table>
			</td>
		 </tr>
		 <tr>
			<td	width="100%"	class="PR03" colspan="2">
			<table width="100%"	border="0" cellspacing="0" cellpadding="0"
			   class="BD4A">
			   <tr>
				  <td width="100%" colspan="2">
				  <comment id="_NSID_">	<object
					 id=GD_MASTER4 width=100% height=0	classid=<%=Util.CLSID_GRID%> tabindex=1>
					 <param	name="DataID" value="DS_O_MASTER4">
				  </object>	</comment><script>_ws_(_NSID_);</script></td>
			   </tr>
			</table>
			</td>
		 </tr>		 
	  </table>
	  </td>
	  
   </tr>
<!--    <tr valign="top"	class="PT10"> -->
<!-- 	  <td> -->
<!-- 	  <table width="100%" border="0" cellspacing="0" cellpadding="0"> -->
<!-- 		 <tr valign="top"> -->
<!-- 			<td> -->
<!-- 			<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A"> -->
<!-- 			   <tr> -->
<!-- 				  <td width="100%"> -->
<%-- 					<comment id="_NSID_">  --%>
<%-- 						<object	id=Chart width=810 height=260 classid=<%=Util.CLSID_SHIFTCHART%> tabindex=1></object> --%>
<!-- 							<param name="DataID" value="DS_O_MASTER_CHART">							 -->
<!-- 						</object> -->
<%-- 					</comment><script>_ws_(_NSID_);</script> --%>
<!-- 				  </td> -->
<!-- 			   </tr> -->
<!-- 			</table> -->
<!-- 			</td> -->
<!-- 		 </tr> -->
<!-- 	  </table> -->
<!-- 	  </td> -->
<!--    </tr> -->
</table>
<!-----------------------------------------------------------------------------
  Gauce	Bind Component Declaration
------------------------------------------------------------------------------>

</div>
<body>
</html>
