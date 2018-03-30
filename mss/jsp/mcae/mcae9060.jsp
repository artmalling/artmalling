<!-- 
/*******************************************************************************
 * 시스템명	: 경영지원 > 사은행사관리 >	사은행사마스터 > 사은행사 마스터 등록
 * 작 성 일	: 2016.11.11
 * 작 성 자	: khj
 * 수 정 자	: 
 * 파 일 명	: MCAE9060.jsp
 * 버	 전	: 1.1 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개	 요	: 
 * 이	 력	: 2017.09.05 jyk 수정. (회원만 참여 행사)
 ******************************************************************************/
-->
<%@	page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"	%>
<%@	taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@	taglib uri="/WEB-INF/tld/gauce40.tld"		prefix="gauce" %>
<%@	taglib uri="/WEB-INF/tld/app.tld"			prefix="loginChk" %>
<%@	taglib uri="/WEB-INF/tld/button.tld"		prefix="button"	%>

<!--*************************************************************************-->
<!--* A. 로그인	유무, 기본설정												*-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet"	type="text/css">
<script	language="javascript" src="/<%=dir%>/js/common.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/gauce.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/global.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/message.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/popup.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/popup_mss.js"	type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/popup_dps.js"	type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작														*-->
<!--*************************************************************************-->

<script	LANGUAGE="JavaScript">

var	strEvtStrPbnFlag = true;
var	strToday = getTodayFormat("yyyymmdd");
var	strSDate = addDate('M',	-1,	strToday);
var	btnClickSearch = false;
var	strStrEvtFlag =	false;

var strUserID = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
var strUserNM = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />';

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: 해당 페이지 LOAD 시
 * return값	: void
 */

var strCurRow = 0;
var top = 100;		//해당화면의 동적그리드top위치
var top2 = 525;		//해당화면의 동적그리드top위치
var top3 = 490;		//해당화면의 동적그리드top위치
function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_EVTMSTR"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_EVTPBN"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";

	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_EVTSTRPBN"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";
	
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_EVTSTRSKU"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top3) + "px";

	// Data	Set	Header 초기화
	DS_O_EVTMST.setDataHeader('<gauce:dataset name="H_EVTMST"/>');
	DS_IO_STREVT.setDataHeader('<gauce:dataset name="H_STREVT"/>');
	DS_IO_STREVT_COPY.setDataHeader('<gauce:dataset	name="H_STREVT"/>');
	DS_O_EVTPBN.setDataHeader('<gauce:dataset name="H_EVTPBN"/>');
	DS_IO_EVTSTRPBN.setDataHeader('<gauce:dataset name="H_EVTSTRPBN"/>');
	DS_IO_EVTSTRSKU.setDataHeader('<gauce:dataset name="H_EVTSTRSKU"/>');
	
	//그리드 초기화
	gridCreate1(); //마스터
	gridCreate2();
	gridCreate3();
	gridCreate4();
	
	// EMedit에	초기화
	initEmEdit(EM_S_EVENT_S_DT,	"SYYYYMMDD", PK);								// 행사기간	S
	initEmEdit(EM_S_EVENT_E_DT,	"TODAY", PK);									// 행사기간	E
	initEmEdit(EM_S_EVENT_CD, "NUMBER3^11",	NORMAL);							// 행사코드
	initEmEdit(EM_S_EVENT_NM, "GEN^11",	READ);									// 행사코드명
		
	initEmEdit(EM_STR, "GEN", READ);											// 점
	initEmEdit(EM_EVENT_CD,	"GEN", READ);										// 행사코드
	initEmEdit(EM_EVENT_NM,	"GEN", READ);										// 행사명
	initEmEdit(EM_EVENT_S_DT, "TODAY", READ);									// 행사시작일
	initEmEdit(EM_EVENT_E_DT, "TODAY", READ);									// 행사종료일
	initEmEdit(EM_ORG_CD,	  "GEN^10",	 PK);									// 신청부서코드
	initEmEdit(EM_ORG_NM,	"GEN^40", READ);									// 신청부서명
	initEmEdit(EM_EVENT_L_CD, "GEN", READ);										// 행사테마(대)
	
	initEmEdit(EM_EVENT_TYPE_NM, "GEN", READ);									// 행사종류 2012. 05. 16 홍종영
	
	initEmEdit(EM_EVENT_M_CD, "GEN", READ);										// 행사테마(중)
	initEmEdit(EM_EVENT_S_CD, "GEN", READ);										// 행사테마(소)

	initEmEdit(EM_PB_APP_RATE,	"NUMBER^3^2", READ);						    // 브랜드부담율
	
	initEmEdit(EM_CHAR_ID, "GEN^10", PK);										// DESK담당자코드
	initEmEdit(EM_CHAR_NM, "GEN", READ);										// DESK담당자명
	initEmEdit(EM_CARDCOMP,	"NUMBER3^2", READ);									// 제휴카드코드
	initEmEdit(EM_CARDCOMP_NM, "GEN", READ);									// 제휴카드명
																				   
	initEmEdit(EM_APP_RATE,	"NUMBER^3^2", READ);								// 카드사 부담율
																				   
	//콤보 초기화																   
	initComboStyle(LC_S_STR,DS_O_S_STR,	"CODE^0^30,NAME^0^80", 1, PK);							// 점
	initComboStyle(LC_CUST_ONLY_YN,DS_O_CUST_ONLY_YN, "CODE^0^30,NAME^0^100", 1, READ);			// 보너스카드 ONLY 2012. 05. 14 홍종영
	initComboStyle(LC_CARD_ONLY_YN,DS_O_CARD_ONLY_YN, "CODE^0^30,NAME^0^100", 1, READ);			// 신용카드	ONLY 2012. 05. 14 홍종영
	initComboStyle(LC_EVENT_TYPE,DS_O_EVENT_TYPE, "CODE^0^30,NAME^0^100", 1, READ);				// 사은행사유형
	initComboStyle(LC_EVENT_GIFT_TYPE,DS_O_EVENT_GIFT_TYPE,	"CODE^0^30,NAME^0^80", 1, READ);	// 사은품종류
	initComboStyle(LC_EVENT_GIFT_CYC,DS_O_EVENT_GIFT_CYC, "CODE^0^30,NAME^0^100", 1, READ);		// 사은품지급주기
	initComboStyle(LC_RECP_ADD_YN,DS_O_RECP_ADD_YN,	"CODE^0^30,NAME^0^100",	1, READ);			// 영수증합산여부
	initComboStyle(LC_RECP_TODAY_YN,DS_O_RECP_TODAY_YN,	"CODE^0^30,NAME^0^100",	1, READ);		// 영수증당일여부
	initComboStyle(LC_DEPT,DS_O_DEPT, "CODE^0^30,NAME^0^80", 1,	READ);							// 부문
	initComboStyle(LC_TEAM,DS_O_TEAM, "CODE^0^30,NAME^0^80", 1,	READ);							// 팀 
	initComboStyle(LC_PC,DS_O_PC, "CODE^0^30,NAME^0^80", 1,	READ);								// PC 
	
	getEtcCode("DS_O_EVENT_TYPE", "D", "M002", "N");
	getEtcCode("DS_O_EVENT_GIFT_TYPE", "D",	"M003",	"N");										
	getEtcCode("DS_O_CUST_ONLY_YN",	"D", "M206", "N");											// 보너스카드	ONLY	2012. 05. 14 홍종영
	getEtcCode("DS_O_CARD_ONLY_YN",	"D", "M207", "N");											// 신용카드	ONLY	2012. 05. 14 홍종영
	getEtcCode("DS_O_EVENT_GIFT_CYC", "D", "M201", "N");
	getEtcCode("DS_O_RECP_ADD_YN", "D",	"M202",	"N");
	getEtcCode("DS_O_RECP_TODAY_YN", "D", "M203", "N");
	
	getStore("DS_O_S_STR", "Y",	"1", "N");
	initTab('TAB');
	EM_EVENT_CD.Alignment=1
	LC_S_STR.Index = 0;
	LC_S_STR.Focus();
	
	
	
	//-- 컴포넌트	Enable/Disable 설정
	setObject();
	
	//--- 전체브랜드선택 여부
	chkAllBrand();
}

function gridCreate1(){
	var	hdrProperies ='<FC>id={currow}		name="NO"			width=25	align=center</FC>'
					+ '<FC>id=STR_NM		name="점"			width=60	align=left</FC>'
					+ '<FC>id=EVENT_CD		name="행사코드"		width=100	align=center</FC>'
					+ '<FC>id=EVENT_NAME	name="행사명"			width=100	align=left</FC>';
					 
	initGridStyle(GD_EVTMSTR, "common",	hdrProperies, false);
}

function gridCreate2(){
	var	hdrProperies ='<FC>id=FLAG			name=""				width=20	align=center	EditStyle=CheckBox	 HeadCheckShow="true" </FC>'
					+ '<FC>id={currow}		name="NO"			width=30	align=center	Edit=none</FC>'
					+ '<FC>id=PUMBUN_CD		name="브랜드코드"		width=60	align=center	Edit=none</FC>'
					+ '<FC>id=PUMBUN_NAME	name="브랜드명"		width=100	align=left		Edit=none</FC>';
					 
	initGridStyle(GD_EVTPBN, "common", hdrProperies, true);
}

function gridCreate3(){
	var	hdrProperies ='<FC>id=FLAG			name=""				width=20	align=center	EditStyle=CheckBox	 HeadCheckShow="true" </FC>'
					+ '<FC>id={currow}		name="NO"			width=30	align=center	</FC>'
					+ '<FC>id=PUMBUN_CD		name="브랜드코드"		width=60	align=center	Edit=none</FC>'
					+ '<FC>id=PUMBUN_NAME	name="브랜드명"		width=80	align=left		Edit=none</FC>'
					+ '<FC>id=APP_RATE		name="인정율"			width=50	align=right		eidt=Numeric</FC>';
					 
	initGridStyle(GD_EVTSTRPBN,	"common", hdrProperies,	true);
}

function gridCreate4(){	
	var	hdrProperies ='<FC>id={currow}		name="NO"			width=30	align=center</FC>'
					+ '<FC>id=SKU_GB_NM		name="사은품종류"		width=80	align=center	Edit=None</FC>'
					+ '<FC>id=SKU_CD		name="사은품코드"		width=100	align=center	Edit={IF(SKU_CD="","true","false")}	 EditStyle=PopupFix</FC>'
					+ '<FC>id=SKU_NAME		name="사은품명"		width=130	align=left		Edit=None</FC>'
					+ '<FC>id=BUY_COST_PRC	name="원가"			width=80	align=right		Edit=None</FC>'
					+ '<FC>id=TRG_CD		name="대상범위"		width=80	align=left		EditStyle=Lookup	Data="DS_O_TRG:CODE:NAME"</FC>';
					
	initGridStyle(GD_EVTSTRSKU,	"common", hdrProperies,	true);
}

/*************************************************************************
  *	2. 공통버튼
	 (1) 조회		- btn_Search(),	subQuery()
	 (2) 신규		- btn_New()
	 (3) 삭제		- btn_Delete()
	 (4) 저장		- btn_Save()
	 (5) 엑셀		- btn_Excel()
	 (6) 출력		- btn_Print()
	 (7) 확정		- btn_Conf()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자	: 김성미
 * 작 성 일	: 2011-02-23
 * 개	 요	: 조회시 호출
 * return값	: void
 */
function btn_Search() {
	 if(LC_S_STR.BindColVal.length == 0){  // 점코드
		showMessage(EXCLAMATION	, OK, "USER-1001", "점");
		LC_S_STR.focus();
		return;
	}
	if(EM_S_EVENT_S_DT.Text.length == 0){	// 조회시작일
		showMessage(EXCLAMATION	, OK, "USER-1001","조회기간");
		EM_S_EVENT_S_DT.focus();
		return;
	}else if(EM_S_EVENT_E_DT.Text.length ==	0){	   // 조회 종료일
		showMessage(EXCLAMATION	, OK, "USER-1001","조회기간");
		EM_S_EVENT_E_DT.focus();
		return;
	}else if(EM_S_EVENT_S_DT.Text >	EM_S_EVENT_E_DT.Text){ // 조회일 정합성
		showMessage(EXCLAMATION	, OK, "USER-1015");
		EM_S_EVENT_S_DT.focus();
		return;
	}
	btnClickSearch = true;
	DS_IO_STREVT.ClearData();
	DS_O_EVTPBN.ClearData();
	DS_IO_EVTSTRPBN.ClearData();
	DS_IO_EVTSTRSKU.ClearData();
	CHK_ALLBRAND.checked = false;
	
	// 조회조건	셋팅
	var	strStrCd		= LC_S_STR.BindColVal;
	var	strSdt			= EM_S_EVENT_S_DT.Text;
	var	strEdt			= EM_S_EVENT_E_DT.Text;
	var	strEventCd		= EM_S_EVENT_CD.Text;
	var	goTo	   = "getEvtMst" ;	  
	var	action	   = "O";	  
	var	parameters = "&strStrCd="  +encodeURIComponent(strStrCd)
				   + "&strSdt="    +encodeURIComponent(strSdt)
				   + "&strEdt="    +encodeURIComponent(strEdt)
				   + "&strEventCd="+encodeURIComponent(strEventCd);
	TR_MAIN.Action="/mss/mcae906.mc?goTo="+goTo+parameters;	 
	TR_MAIN.KeyValue="SERVLET("+action+":DS_O_EVTMST=DS_O_EVTMST)";	//조회는 O
	TR_MAIN.Post();
	if(DS_O_EVTMST.CountRow	> 0){
		// 저장전 Row 셋팅
		if(strCurRow > 0){
			DS_O_EVTMST.RowPosition	= strCurRow;
		}
		strCurRow =	0;
		DS_O_EVENT_TYPE.Filter();
		
		//--- 대상범위	데이터셋 조회
		getTrg();
		
		//--- 점별	사은행사 정보 조회
		getStrEvt();
		
		//-- 컴포넌트	Enable/Disable 설정
		setObject();
		
		//--- 전체브랜드선택 여부
		chkAllBrand();
	}
	btnClickSearch = false;
	// 조회결과	Return
	setPorcCount("SELECT", GD_EVTMSTR);
}

/**
 * btn_New()
 * 작 성 자	: shryu
 * 작 성 일	: 2006-06-20
 * 개	 요	: Grid 레코드 추가
 * return값	: void
 */
function btn_New() {
	
}

/**
 * btn_Delete()
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: Grid 레코드 삭제
 * return값	: void
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자	: 김성미
 * 작 성 일	: 2011-02-25
 * 개	 요	: DB에 저장
 * return값	: void
 */
function btn_Save()	{
	 //	저장할 데이터 없는 경우	
	   if (!DS_IO_STREVT.IsUpdated 
			   && !(DS_IO_EVTSTRPBN.IsUpdated || CHK_ALLBRAND.checked)
			   && !DS_IO_EVTSTRSKU.IsUpdated){
		   //저장할	내용이 없습니다
		   showMessage(EXCLAMATION , OK, "USER-1028");
		   return;
	   }
	   
	 //	사은행사 마스터	정보 필수입력사항
	  if(DS_IO_STREVT.NameValue(1, "EVENT_TYPE") ==	""){ //	사은행사 유형
		  showMessage(EXCLAMATION ,	OK,	"USER-1002", "사은행사 유형");
		  LC_EVENT_TYPE.Focus();
		  return;
	  }
	 
	  if(DS_IO_STREVT.NameValue(1, "EVENT_GIFT_TYPE") == ""){ // 사은품	종류
		  showMessage(EXCLAMATION ,	OK,	"USER-1002", "사은품 종류");
		  LC_EVENT_GIFT_TYPE.Focus();
		  return;	
	  }

	  if(DS_IO_STREVT.NameValue(1, "EVENT_GIFT_CYC") ==	""){ //	사은품 지급주기
		  showMessage(EXCLAMATION ,	OK,	"USER-1002", "사은품 지급주기");
		  LC_EVENT_GIFT_CYC.Focus();
		  return;	
	  }

	  if(DS_IO_STREVT.NameValue(1, "RECP_ADD_YN") == ""){ // 영수증	합산여부
		  showMessage(EXCLAMATION ,	OK,	"USER-1002", "영수증 합산여부");
		  LC_RECP_ADD_YN.Focus();
		  return;	
	  }

	  if(DS_IO_STREVT.NameValue(1, "RECP_TODAY_YN")	== ""){	// 영수증 당일여부
		  showMessage(EXCLAMATION ,	OK,	"USER-1002", "영수증 당일여부");
		  LC_RECP_TODAY_YN.Focus();
		  return;	
	  }
	  
	  if(DS_IO_STREVT.NameValue(1, "ORG_CD") ==	"" || DS_IO_STREVT.NameValue(1,	"ORG_NM") == ""){ // DESK 담당자
		  showMessage(EXCLAMATION ,	OK,	"USER-1003", "행사주관부서");
		  EM_ORG_CD.Focus();
		  return;
	  }
		  
	  if(DS_IO_STREVT.NameValue(1, "CHAR_ID") == ""	|| DS_IO_STREVT.NameValue(1, "CHAR_NM")	== ""){	// DESK	담당자
		  showMessage(EXCLAMATION ,	OK,	"USER-1003", "DESK 담당자");
		  EM_CHAR_ID.Focus();
		  return;
	  }
	  
	  if(DS_IO_STREVT.NameValue(1, "EVENT_TYPE") ==	"02" &&	DS_IO_STREVT.NameValue(1, "CARD_COMP") == ""){ // 제휴카드
		  showMessage(EXCLAMATION ,	OK,	"USER-1003", "제휴카드");
		  EM_CARDCOMP.Focus();
		  return;
	  }
	  
	  if(DS_IO_STREVT.NameValue(1, "EVENT_TYPE") ==	"02" &&	DS_IO_STREVT.NameValue(1, "APP_RATE") == ""){ // 인정율
		  showMessage(EXCLAMATION ,	OK,	"USER-1003", "부담율");
		  EM_APP_RATE.Focus();
		  return;
	  }
	  

	  if(DS_IO_STREVT.NameValue(1, "CAL_YN") ==	"T" &&	DS_IO_STREVT.NameValue(1, "PB_APP_RATE") == ""){ // 브랜드부담율
		  showMessage(EXCLAMATION ,	OK,	"USER-1003", "브랜드부담율");
		  EM_PB_APP_RATE.Focus();
		  return;
	  }
	  

	  //if(DS_IO_STREVT.NameValue(1, "EVENT_TYPE") ==	"02" && DS_IO_STREVT.NameValue(1, "CAL_YN") ==	"F") {
	  if(DS_IO_STREVT.NameValue(1, "EVENT_TYPE") ==	"03") {
		 if ( (CHK_PAY_TYPE_CASH.checked == false) && 
			  (CHK_PAY_TYPE_CARD.checked == false) && 
			  (CHK_PAY_TYPE_GIFT.checked == false) ) {
		 
			 	showMessage(EXCLAMATION ,	OK,	"USER-1003", "결제유형");  
		  		return;
		  	}
	  }
	  
	  
	  
	  //참여브랜드 선택여부
	  if(DS_IO_EVTSTRPBN.CountRow == 0 && !CHK_ALLBRAND.checked){
		  showMessage(EXCLAMATION ,	OK,	"USER-1000", "참여브랜드를 선택해주세요.");	
		  return;
	  }
	  
	  if(!checkSku()){
		  return;
	  }
	  
	  if (showMessage(QUESTION , YESNO,	"USER-1010") !=	1) return;
	  
	  DS_IO_STREVT.NameValue(1,"STR_CD") = DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition,"STR_CD");
	  DS_IO_STREVT.NameValue(1,"EVENT_CD") = DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition,"EVENT_CD");
	  
	  DS_IO_STREVT.NameValue(1,"PC_EVENT_TYPE") = DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition,"EVENT_TYPE");
	  
	  DS_IO_STREVT.NameValue(1,	"VEN_CD") =	HD_VEN_CD.Value;
	  var strData =	DS_IO_STREVT.ExportData(1, DS_IO_STREVT.CountRow, true);
	  DS_IO_STREVT_COPY.ImportData(strData);
	   var strKeyValue = "SERVLET(I:DS_IO_STREVT=DS_IO_STREVT"			 //	사은행사 마스터
						+ ",I:DS_IO_EVTSTRPBN=DS_IO_EVTSTRPBN"			 //	사은행사 참여브랜드
						+ ",I:DS_IO_EVTSTRSKU=DS_IO_EVTSTRSKU"			 //	사은행사 사은품
						+ ",I:DS_IO_STREVT_COPY=DS_IO_STREVT_COPY)";		 
	   
	   TR_MAIN.Action="/mss/mcae906.mc?goTo=save&strAllBrand="+encodeURIComponent(CHK_ALLBRAND.checked); 
	   TR_MAIN.KeyValue=strKeyValue;
	   TR_MAIN.Post();
	   
	   strCurRow = DS_O_EVTMST.RowPosition;

	   if(TR_MAIN.ErrorCode	== 0){
		   strStrEvtFlag = false; 
		   btn_Search();
	   }
	}

/**
 * btn_Excel()
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: 엑셀로 다운로드
 * return값	: void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: 페이지 프린트	인쇄
 * return값	: void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자	: 
 * 작 성 일	: 2010-12-12
 * 개	 요	: 확정 처리
 * return값	: void
 */

function btn_Conf()	{

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  *	getTrg()
  *	작 성 자 : 
  *	작 성 일 : 2011-02-23
  *	개	  요 : 대상범위	데이터셋 조회
  *	return값 : void
  */
 function getTrg() {
	 var goTo		= "getTrg" ; 
	 var parameters	= "&strStrCd="+encodeURIComponent(DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition, "STR_CD"));
	 TR_MAIN.Action="/mss/mcae906.mc?goTo="+goTo+parameters;  
	 TR_MAIN.KeyValue="SERVLET(O:DS_O_TRG=DS_O_TRG)"; 
	 TR_MAIN.Post();
 }
 
 /**
  *	setObject()
  *	작 성 자 : 
  *	작 성 일 : 2011-02-23
  *	개	  요 : 컴포넌트	Enable/Disable 설정
  *	return값 : void
  */

 function setObject() {

		var	strFlag	= "";
	   
		// 기존에 사은행사 마스터가	등록이 되어	있지 않고행사가	시작되지 않은경우에만 등록 가능
		
		if(DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition,"CNT")	== "0"){
			strFlag	=  true;
			
			CHK_DBL_PAID_YN.disabled 		= false; 
			LC_EVENT_GIFT_TYPE.BindColVal 	= "01";
			EM_CHAR_ID.Text = strUserID;
			EM_CHAR_NM.Text = strUserNM;
			CHK_MEMBONLY_YN.disabled 		= false;  		// 회원만 행사 참여	2017.09.05 jyk
			CHK_RECP_YN.disabled 			= false;		// 영수증 표기 여부	2017.09.05 jyk
			
		}else{
			strFlag	= false;
			CHK_DBL_PAID_YN.disabled = true; 
			CHK_CAL_YN.disabled		 = true;    //제휴카드사은행사는 정산여부 변경 불가
			CHK_MEMBONLY_YN.disabled = true;
			CHK_RECP_YN.disabled     = true;
		}
		
		LC_EVENT_TYPE.Enable = strFlag;
		LC_CUST_ONLY_YN.Enable = strFlag;
		LC_CARD_ONLY_YN.Enable = strFlag;
		LC_EVENT_GIFT_TYPE.Enable =	strFlag;
		//LC_EVENT_GIFT_CYC.Enable = strFlag;
		//LC_RECP_ADD_YN.Enable =	strFlag;
		LC_RECP_TODAY_YN.Enable	= strFlag;
		
	    //	사은행사인 경우
		if(DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition,"EVENT_TYPE") == "4"){ // 사은행사
			LC_CARD_ONLY_YN.BindColVal = "N"; // 신용카드 ONLY : N
			LC_CARD_ONLY_YN.Enable	= false;		    
		}	
	    
		//	제휴카드 행사일경우	카드사 정보	수정 가능
		if(DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition,"EVENT_TYPE") == "6"){
			LC_CARD_ONLY_YN.BindColVal = "Y"; // 신용카드 ONLY ; Y
			LC_CARD_ONLY_YN.Enable = false;
			LC_CUST_ONLY_YN.BindColVal = "N"; // 보너스카드 ONLY : N
			LC_CUST_ONLY_YN.Enable = false;			
			//LC_EVENT_GIFT_CYC.BindColVal = "P"; // 사은품지급주기 : P-기간중 1회
			//LC_EVENT_GIFT_CYC.Enable = false;		
			//강연식_20140227 -제휴카드 행사 시 지급주기 변경가능
			LC_RECP_ADD_YN.BindColVal = "Y"; // 영수증합산가능 : Y
			LC_RECP_ADD_YN.Enable = false;				
			LC_RECP_TODAY_YN.BindColVal = "Y"; // 영수증당일체크 : Y
			LC_RECP_TODAY_YN.Enable = false;			
			EM_CARDCOMP.Enable =	strFlag;
			EM_APP_RATE.Enable =	true;
			enableControl(IMG_CARDCOMP, strFlag);
			
		    CHK_CAL_YN.disabled=true;    //제휴카드사은행사는 정산여부 변경 불가
            CHK_PAY_TYPE_CASH.disabled = true; 
            CHK_PAY_TYPE_CARD.disabled = true; 
            CHK_PAY_TYPE_GIFT.disabled = true;
            

			EM_PB_APP_RATE.Enable   =	false;	
			
			//CHK_DBL_PAID_YN.checked = false;
			//CHK_DBL_PAID_YN.disabled = true;    // 타사카드는 중복지급 불가
			
		}else{
			EM_CARDCOMP.Enable = false;
			EM_APP_RATE.Enable = false;
			enableControl(IMG_CARDCOMP,	false);
			
			EM_CARDCOMP.Text = "";
			EM_CARDCOMP_NM.Text	= "";
			EM_APP_RATE.Text = 0;
			strStrEvtFlag =	false;			

            CHK_PAY_TYPE_CASH.disabled = true; 
            CHK_PAY_TYPE_CARD.disabled = true; 
            CHK_PAY_TYPE_GIFT.disabled = true;
		}
	 	
		strFlag	= true;
		
		//if(strToday	< DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition, "EVENT_S_DT")){
		if(strToday	<= DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition, "EVENT_E_DT")){
			strFlag	=  true;
			//alert("!");
		}
		enableControl(IMG_PUMBUN, strFlag);
		enableControl(IMG_ADD, strFlag);
		enableControl(IMG_DEL, strFlag);
		enableControl(IMG_ADD_ROW, strFlag);	  
		enableControl(IMG_DEL_ROW, strFlag);
		
		GD_EVTSTRPBN.Editable	=	 strFlag;  
		GD_EVTSTRSKU.Editable	=	 strFlag;	
		GD_EVTPBN.Editable	 =	  strFlag;	
		
		EM_CHAR_ID.Enable =	strFlag;
		enableControl(IMG_DESK,	strFlag);
		
		LC_DEPT.Enable = strFlag;
		LC_TEAM.Enable = strFlag;
		LC_PC.Enable = strFlag;
		enableControl(CHK_ALLBRAND,	strFlag);
		GD_EVTMSTR.Focus();		   
		
 }
 
 
 /**
  *	getStrEvt()
  *	작 성 자 : 김성미
  *	작 성 일 : 2011-02-23
  *	개	  요 : 점별	사은행사 정보 조회
  *	return값 : void
  */
 function getStrEvt(flag) {
	  DS_IO_STREVT.ClearData();
	  DS_O_EVTPBN.ClearData();
	  DS_IO_EVTSTRPBN.ClearData();
	  DS_IO_EVTSTRSKU.ClearData();
	  CHK_ALLBRAND.checked = false;
	 //	조회조건 셋팅
	 var strStrCd		 = DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition, "STR_CD");
	 var strEventCd		 = DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition, "EVENT_CD");
	
	 var goTo		= "getStrEvt" ;	   
	 var action		= "O";	   
	 var parameters	= "&strStrCd="   + encodeURIComponent(strStrCd)
					+ "&strEventCd=" + encodeURIComponent(strEventCd);
	 
	 TR_MAIN.Action="/mss/mcae906.mc?goTo="+goTo+parameters;  
	 TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_STREVT=DS_IO_STREVT)"; //조회는	O
	 TR_MAIN.Post();
	 
	 getDept("DS_O_DEPT", "N", LC_S_STR.BindColVal,	"Y");
	 //getTeam("DS_O_TEAM", "N", LC_S_STR.BindColVal,	LC_DEPT.BindColVal,	"Y");
	 //getPc("DS_O_PC", "N", LC_S_STR.BindColVal,	LC_DEPT.BindColVal,	LC_TEAM.BindColVal,	"Y");
	 LC_DEPT.Index = 0;
	 LC_TEAM.Index = 0;
	 LC_PC.Index = 0;
	 
	// 점별	사은행사 정보가	없고  시작되지 않은	행사 일경우	사은행사 기본정보 셋팅
	 //if(DS_IO_STREVT.CountRow	== 0 &&	strToday < DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition,"EVENT_S_DT")){
	if(DS_IO_STREVT.CountRow ==	0){
		 DS_IO_STREVT.ClearData();
		 DS_IO_STREVT.AddRow();

		 if (DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition, "EVENT_TYPE") !="6") {
			 LC_EVENT_TYPE.BindColVal = "01";
		 } else {
			 LC_EVENT_TYPE.BindColVal = "02";
		 }

		 GD_EVTSTRPBN.Enable = "True";  //참여브랜드 그리드 활성화
		 CHK_ALLBRAND.disabled = false; //전체브랜드적용chkbox 활성화
		 
	 }else if(DS_IO_STREVT.CountRow	> 0){//	점별 사은행사 정보가 있는경우 참여 브랜드, 사은품, 제휴카드	정보 조회
	    // 부문, 팀, PC 콤보 설정
		getStrEvtInfo(flag);
	 }
 }
 
 /**
  *	getStrEvtInfo()
  *	작 성 자 : 김성미
  *	작 성 일 : 2011-02-23
  *	개	  요 : 점별	사은행사 정보 조회
  *	return값 : void
  */
 function getStrEvtInfo(flag) {
	 //	조회조건 셋팅
	 var strStrCd		 = LC_S_STR.BindColVal;
	 var strEventCd		 = EM_EVENT_CD.Text;
	
	 var goTo		= "getStrEvtInfo" ;	   
	 var parameters	= "&strStrCd="   + encodeURIComponent(strStrCd)
					+ "&strEventCd=" + encodeURIComponent(strEventCd);
	 TR_MAIN.Action="/mss/mcae906.mc?goTo="+goTo+parameters;  
	 TR_MAIN.KeyValue="SERVLET(O:DS_IO_EVTSTRPBN=DS_IO_EVTSTRPBN,O:DS_IO_EVTSTRSKU=DS_IO_EVTSTRSKU)"; //조회는 O
	 TR_MAIN.Post();

	 CHK_ALLBRAND.disabled = true;    //전체브랜드적용chkbox 비활성화

	 
	 if(DS_IO_EVTSTRPBN.CountRow ==	1){
		 if(DS_IO_EVTSTRPBN.NameValue(1,"PUMBUN_CD") ==	"******"){
			 DS_IO_EVTSTRPBN.ClearData();
			 CHK_ALLBRAND.checked =	true;
			 
//			 if(EM_EVENT_S_DT.text <= strToday){
			 if(EM_EVENT_E_DT.text < strToday){
			 	GD_EVTSTRPBN.Enable = "false";    //참여브랜드 그리드 비활성화
			 	
			 } else {

				 GD_EVTSTRPBN.Enable = "true";     //참여브랜드 그리드 활성화	 
				 CHK_ALLBRAND.disabled = false;     //전체브랜드적용chkbox 활성화
			 }
		 }
	 }else{
		 GD_EVTSTRPBN.DataID = "DS_IO_EVTSTRPBN";

		 if(DS_IO_EVTSTRPBN.CountRow > 0){
			 //if (EM_EVENT_S_DT.text <= strToday) {
			 if (EM_EVENT_E_DT.text < strToday) {
				 
				 GD_EVTSTRPBN.Enable = "false";     //참여브랜드 그리드 비활성화
			 } else {

				 GD_EVTSTRPBN.Enable = "true";     //참여브랜드 그리드 활성화	 
				 CHK_ALLBRAND.disabled = false;     //전체브랜드적용chkbox 활성화
			 }
		 } else {
			 
			 //---참여브랜드 등록이 없는경우... 
			 GD_EVTSTRPBN.Enable = "true";	    //참여브랜드 그리드 활성화			 
			 CHK_ALLBRAND.disabled = false;     //전체브랜드적용chkbox 활성화
		 }
		 
	 }
	 

	 
 }
 
 /**
  *	getPumbun()
  *	작 성 자 : 김성미
  *	작 성 일 : 2011-02-24
  *	개	  요 : 브랜드 마스터(브랜드)조회
  *	return값 : void
  */
 function getPumbun() {
	 //	조회조건 셋팅
	 var strStrCd		  =	DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition, "STR_CD");
	 var strDept		  =	LC_DEPT.BindColVal;
	 var strTeam		  =	LC_TEAM.BindColVal;
	 var strPc			  =	LC_PC.BindColVal;
	
	 var goTo		= "getEvtPbn" ;	   
	 var action		= "O";	   
	 var parameters	= "&strStrCd=" + encodeURIComponent(strStrCd)
					+ "&strDept="  + encodeURIComponent(strDept)
					+ "&strTeam="  + encodeURIComponent(strTeam)
					+ "&strPc="    + encodeURIComponent(strPc);
	 TR_MAIN.Action="/mss/mcae906.mc?goTo="+goTo+parameters;  
	 TR_MAIN.KeyValue="SERVLET("+action+":DS_O_EVTPBN=DS_O_EVTPBN)"; //조회는 O
	 TR_MAIN.Post();
	 
	 //	브랜드 정보가 있는경우 기존	등록된 참여브랜드와	비교하여 없는 브랜드만 남긴다.
	 if(DS_IO_EVTSTRPBN.CountRow > 0){
		 for(var i=1;i<=DS_O_EVTPBN.CountRow;i++){
			 var strPumbunCd = DS_O_EVTPBN.NameValue(i,"PUMBUN_CD");
			 for(var j=1;j<=DS_IO_EVTSTRPBN.CountRow;j++){
				 if(strPumbunCd	== DS_IO_EVTSTRPBN.NameValue(j,"PUMBUN_CD")){
					 DS_O_EVTPBN.DeleteRow(i);
					 i = i - 1;
				 }
			 }
		 }
	 }
 }
 
  
  /**
   * addPumbun()
   * 작	성 자 :	김성미
   * 작	성 일 :	2011-02-24
   * 개	   요 :	브랜드 => 참여브랜드 추가
   * return값 :	void
   */
  function addPumbun() {
	  var strRowCnt	= DS_O_EVTPBN.CountRow;
	   // 체크된 브랜드을 참여 브랜드에	이동시킨다 
	   for(var i=1;i<=strRowCnt;i++){
		  if(DS_O_EVTPBN.NameValue(i,"FLAG") ==	"T"){
				DS_IO_EVTSTRPBN.AddRow();
				DS_IO_EVTSTRPBN.NameValue(DS_IO_EVTSTRPBN.CountRow,"FLAG") = "";
				DS_IO_EVTSTRPBN.NameValue(DS_IO_EVTSTRPBN.CountRow,"STR_CD") = DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition,"STR_CD");
				DS_IO_EVTSTRPBN.NameValue(DS_IO_EVTSTRPBN.CountRow,"EVENT_CD") = DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition,"EVENT_CD");
				DS_IO_EVTSTRPBN.NameValue(DS_IO_EVTSTRPBN.CountRow,"PUMBUN_CD")	= DS_O_EVTPBN.NameValue(i,"PUMBUN_CD");
				DS_IO_EVTSTRPBN.NameValue(DS_IO_EVTSTRPBN.CountRow,"PUMBUN_NAME") =	DS_O_EVTPBN.NameValue(i,"PUMBUN_NAME");
				DS_IO_EVTSTRPBN.NameValue(DS_IO_EVTSTRPBN.CountRow,"APP_RATE") = DS_O_EVTPBN.NameValue(i,"APP_RATE");
				DS_O_EVTPBN.DeleteRow(i);
				i =	i -	1;
		  }
	  }
	   // 브랜드 추가후	전체 체크 표시 해제
	   GD_EVTPBN.ColumnProp('FLAG','HeadCheck')= false;
  }
   
/**
 * delPumbun()
 * 작 성 자	: 김성미
 * 작 성 일	: 2011-02-24
 * 개	 요	: 참여브랜드 =>	브랜드 마스터 추가
 * return값	: void
 */
function delPumbun() {
	 var strRowCnt = DS_IO_EVTSTRPBN.CountRow;
	 for(var i=1;i<=strRowCnt;i++){
		  if(DS_IO_EVTSTRPBN.NameValue(i,"FLAG") ==	"T"){
			   DS_O_EVTPBN.AddRow();
			   DS_O_EVTPBN.NameValue(DS_O_EVTPBN.CountRow,"FLAG") =	"";
			   DS_O_EVTPBN.NameValue(DS_O_EVTPBN.CountRow,"PUMBUN_CD") = DS_IO_EVTSTRPBN.NameValue(i,"PUMBUN_CD");
			   DS_O_EVTPBN.NameValue(DS_O_EVTPBN.CountRow,"PUMBUN_NAME") = DS_IO_EVTSTRPBN.NameValue(i,"PUMBUN_NAME");
			   DS_O_EVTPBN.NameValue(DS_O_EVTPBN.CountRow,"APP_RATE") =	DS_IO_EVTSTRPBN.NameValue(i,"APP_RATE");
			   DS_IO_EVTSTRPBN.DeleteRow(i);
			   i = i-1;
		  }
	  }
	DS_O_EVTPBN.ResetStatus();
	GD_EVTSTRPBN.ColumnProp('FLAG','HeadCheck')= false;
}
 
 /**
  *	setEvtInfo()
  *	작 성 자 : 김성미
  *	작 성 일 : 2011-02-24
  *	개	  요 : 사은행사	내역이 없는경우	초기화 셋팅
  *	return값 : void
  */
 function setEvtInfo(dsObj,	delYn) {
	 if(delYn) dsObj.ClearData();
	 if(dsObj == DS_O_EVTPBN ||	dsObj == DS_IO_EVTSTRPBN) return;
	  dsObj.AddRow();
	  dsObj.NameValue(dsObj.RowPosition, "STR_CD") = DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition,	"STR_CD");
	  dsObj.NameValue(dsObj.RowPosition, "EVENT_CD") = DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition, "EVENT_CD");
}
 
 /**
  *	btn_AddRow()
  *	작 성 자 : 김성미
  *	작 성 일 : 2011-02-24
  *	개	  요 : 사은품 행추가
  *	return값 : void
  */
 function btn_AddRow() {
	  DS_IO_EVTSTRSKU.AddRow();
	  DS_IO_EVTSTRSKU.NameValue(DS_IO_EVTSTRSKU.RowPosition, "STR_CD") = DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition,	"STR_CD");
	  DS_IO_EVTSTRSKU.NameValue(DS_IO_EVTSTRSKU.RowPosition, "EVENT_CD") = DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition, "EVENT_CD");
	  DS_IO_EVTSTRSKU.RowPosition =	DS_IO_EVTSTRSKU.CountRow;
	  GD_EVTSTRSKU.SetColumn("SKU_CD");
	  GD_EVTSTRSKU.Focus();
}
 
 /**
  *	btn_DeleteRow()
  *	작 성 자 : 김성미
  *	작 성 일 : 2011-02-24
  *	개	  요 : 사은품 행삭제
  *	return값 : void
  */
 function btn_DeleteRow() {
	 if(DS_IO_EVTSTRSKU.SysStatus(DS_IO_EVTSTRSKU.RowPosition) != "1"){
		 showMessage(EXCLAMATION , OK, "USER-1000",	"이미 등록된 사은품은 삭제할수 없습니다.");
		 return;
	 }
	  DS_IO_EVTSTRSKU.DeleteRow(DS_IO_EVTSTRSKU.RowPosition);
}
 
 /**
  *	checkSku()
  *	작 성 자 : 김성미
  *	작 성 일 : 2011-02-24
  *	개	  요 : 사은품 데이터 정합성	체크
  *	return값 : void
  */
 function checkSku() {
	 for(var i=1;i<=DS_IO_EVTSTRSKU.CountRow;i++){
		 if(DS_IO_EVTSTRSKU.NameValue(i,"SKU_CD") == ""){
			 showMessage(EXCLAMATION , OK, "USER-1000",	"사은품	코드를 선택하세요");
			 DS_IO_EVTSTRSKU.RowPosition  =	i;
			 GD_EVTSTRSKU.SetColumn("SKU_CD");
			 GD_EVTSTRSKU.Focus();
			 setTabItemIndex("TAB",2);
			 return	false;
		 }
		 if(DS_IO_EVTSTRSKU.NameValue(i,"TRG_CD") == ""){
			 showMessage(EXCLAMATION , OK, "USER-1000",	"대상범위를	선택하세요");
			 DS_IO_EVTSTRSKU.RowPosition  =	i;
			 GD_EVTSTRSKU.SetColumn("TRG_CD");
			 GD_EVTSTRSKU.Focus();
			 setTabItemIndex("TAB",2);
			 return	false;
		 }
	 }
	 
	 return	true;
}
 
 /**
 * getSEvent()
 * 작 성 자	: 김성미
 * 작 성 일	: 2011-01-26
 * 개	 요	:  조회용 이벤트 팝업
 * return값	: void
 */
 function getSEvent(){
	
	// 조회	이벤트 조건	검색시 점코드 필수 
	if(LC_S_STR.BindColVal.length == 0){
		showMessage(EXCLAMATION	, OK, "USER-1001", "점");
		return;
	}
   //mssEventPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,'','','N',LC_S_STR.BindColVal,	EM_S_EVENT_S_DT.Text, EM_S_EVENT_E_DT.Text);
   mssEventMstPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,LC_S_STR.BindColVal, '4/6');
 }

 /**
  *	chkAllBrand()
  *	작 성 자 : 김성미
  *	작 성 일 : 2011-05-02
  *	개	  요 :	전관행사 선택
  *	return값 : void
  */
 function chkAllBrand(){
	  
	 var strFlag ;
	  if(CHK_ALLBRAND.checked){
		 strFlag =	false;
		 DS_O_EVTPBN.ClearData();
		 DS_IO_EVTSTRPBN.ClearData();
		 LC_DEPT.BindColVal	= "";
		 LC_TEAM.BindColVal	= "";
		 LC_PC.BindColVal =	"";
	 }else{
		 strFlag = true;
		 //LC_DEPT.Index = 0;
		 //LC_TEAM.Index = 0;
		 //LC_PC.Index = 0;
	 }
	 enableControl(IMG_PUMBUN, strFlag);
	 enableControl(IMG_ADD,	strFlag);
	 enableControl(IMG_DEL,	strFlag);
	 LC_DEPT.Enable	= strFlag;
	 LC_TEAM.Enable	= strFlag;
	 LC_PC.Enable =	strFlag;
	 
 }
 
 
 function openPop(){
	 if(DS_O_EVTMST.CountRow ==	0){
		 showMessage(EXCLAMATION , OK, "USER-1000",	"사은행사 정보를 확인하세요.");
		 return;
	 }
	 
	 if(DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition,"STR_CD")	== ""){
		 showMessage(EXCLAMATION , OK, "USER-1000",	"사은행사 정보를 확인하세요.");
		 return;
	 }
	 orgPop(EM_ORG_CD, EM_ORG_NM,'N', '','','','4','Y',DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition,"STR_CD"),'','1');
 }

 

 /**
  * chkCalyn()
  * 작 성 자 : 
  * 작 성 일 : 2016.11.11
  * 개    요 : 체크박스 클릭시 컨트롤 활성화
  * return값 :
  */
 function chkCalyn(){

       if(CHK_CAL_YN.checked == true){    	          
           if (LC_EVENT_TYPE.BindColVal == '01') {    //-- 브랜드별행사  
        	              
        	   CHK_PAY_TYPE_CASH.checked = false;
        	   CHK_PAY_TYPE_CARD.checked = false;
        	   CHK_PAY_TYPE_GIFT.checked = false;
        	   
               CHK_PAY_TYPE_CASH.disabled = true; 
               CHK_PAY_TYPE_CARD.disabled = true; 
               CHK_PAY_TYPE_GIFT.disabled = true;  
               
               EM_PB_APP_RATE.Enable = true; 	
			
			} else {	              

	            CHK_PAY_TYPE_CASH.checked = true; 
	            CHK_PAY_TYPE_CARD.checked = true; 
	            CHK_PAY_TYPE_GIFT.checked = true; 
	            
	            CHK_PAY_TYPE_CASH.disabled = false; 
	            CHK_PAY_TYPE_CARD.disabled = false; 
	            CHK_PAY_TYPE_GIFT.disabled = false; 

				EM_PB_APP_RATE.Text   =	"0";
				EM_PB_APP_RATE.Enable   =	false;
			}
       } else {
           if (LC_EVENT_TYPE.BindColVal == '01') {    //-- 브랜드별행사  
           
        	   CHK_PAY_TYPE_CASH.checked = false;
        	   CHK_PAY_TYPE_CARD.checked = false;
        	   CHK_PAY_TYPE_GIFT.checked = false;
        	   
               CHK_PAY_TYPE_CASH.disabled = true; 
               CHK_PAY_TYPE_CARD.disabled = true; 
               CHK_PAY_TYPE_GIFT.disabled = true; 
               
               EM_PB_APP_RATE.Enable = false; 
                				
			} else {	              

        	   CHK_PAY_TYPE_CASH.checked = false;
        	   CHK_PAY_TYPE_CARD.checked = false;
        	   CHK_PAY_TYPE_GIFT.checked = false;
        	   
               CHK_PAY_TYPE_CASH.disabled = true; 
               CHK_PAY_TYPE_CARD.disabled = true; 
               CHK_PAY_TYPE_GIFT.disabled = true;  
               
			   EM_PB_APP_RATE.Text     =	"0";
			   EM_PB_APP_RATE.Enable   =	false;
			}       
      }
 }
 
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝													 *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스	이벤트 처리													*-->
<!--*	 1.	TR Success 메세지 처리
<!--*	 2.	TR Fail	메세지 처리
<!--*	 3.	DataSet	Success	메세지 처리
<!--*	 4.	DataSet	Fail 메세지	처리
<!--*	 5.	DataSet	이벤트 처리
<!--*************************************************************************-->
<!---------------------	1. TR Success 메세지 처리  ---------------------------->
<script	language=JavaScript	for=TR_MAIN	event=onSuccess>
	for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
	}
</script>

<!---------------------	2. TR Fail 메세지 처리	------------------------------->
<script	language=JavaScript	for=TR_MAIN	event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>

<!---------------------	3. DataSet Success 메세지 처리	----------------------->
<!---------------------	4. DataSet Fail	메세지 처리	 -------------------------->
<!---------------------	5. DataSet 이벤트 처리	------------------------------->
<script	language=JavaScript	for=DS_O_EVENT_TYPE	event=OnFilter(row)>
if(DS_O_EVTMST.CountRow	== 0) return false;
if(DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition, "EVENT_TYPE")	== "4"){
	if (DS_O_EVENT_TYPE.NameValue(row, "CODE") != "02")	{//	단독, D3카드 고객행사
		return true;
	}
}else if (DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition, "EVENT_TYPE")	== "9") {  // 회원대상
	if (DS_O_EVENT_TYPE.NameValue(row, "CODE") =="01")	{// 브랜드 유형만 선택하게
		return true;
	}
}else{
	if (DS_O_EVENT_TYPE.NameValue(row, "CODE") == "02")	{//	카드사제휴행사
		return true;
	}
}
return false;
</script>

<script	language=JavaScript	for=DS_IO_STREVT
	event=OnColumnChanged(row,colid)>
strStrEvtFlag =	true;
</script>


<script language=JavaScript for=LC_RECP_TODAY_YN event=OnSelChange()>
	if (LC_RECP_TODAY_YN.BindColVal =='Y') {
		setComboData(LC_EVENT_GIFT_CYC,"D");
		
	} else {
		setComboData(LC_EVENT_GIFT_CYC,"P");
	}
</script>

<script language=JavaScript for=LC_EVENT_TYPE event=OnSelChange()>

    if(  this.BindColVal == '03' && this.Enable ){ // 결재유형별행사
        enableControl(LC_CUST_ONLY_YN, false);
        setComboData(LC_CUST_ONLY_YN,"Y");  
        enableControl(LC_CARD_ONLY_YN, false);
        setComboData(LC_CARD_ONLY_YN,"N");  
        //enableControl(LC_EVENT_GIFT_CYC, false);
        //setComboData(LC_EVENT_GIFT_CYC,"D");
        enableControl(LC_EVENT_GIFT_CYC, false);  // 강연식_20150728 -보너스카드 고객 행사 시 지급주기 변경가능
        setComboData(LC_EVENT_GIFT_CYC,"D");     //  강연식_20150728 -보너스카드 고객 행사 시 지급주기 변경가능
        enableControl(LC_RECP_ADD_YN, false);
        setComboData(LC_RECP_ADD_YN,"Y");  
        enableControl(LC_RECP_TODAY_YN, true);
        setComboData(LC_RECP_TODAY_YN,"Y");     //당일영수증
         
        CHK_CAL_YN.checked = false;
        CHK_CAL_YN.disabled = true;
        CHK_PAY_TYPE_CASH.disabled = false; 
        CHK_PAY_TYPE_CARD.disabled = false; 
        CHK_PAY_TYPE_GIFT.disabled = false; 

        CHK_PAY_TYPE_CASH.checked = true;
        CHK_PAY_TYPE_CARD.checked = true;
        CHK_PAY_TYPE_GIFT.checked = true;
        
        EM_PB_APP_RATE.Text   =	"0";
		EM_PB_APP_RATE.Enable   =	false;
            

    }else if( this.BindColVal == '02' && this.Enable ){ // 제휴카드 행사
        enableControl(LC_CUST_ONLY_YN, false);
        setComboData(LC_CUST_ONLY_YN,"N");  
        enableControl(LC_CARD_ONLY_YN, false);
        setComboData(LC_CARD_ONLY_YN,"Y");  
//        enableControl(LC_EVENT_GIFT_CYC, false);
//        setComboData(LC_EVENT_GIFT_CYC,"P");  
        enableControl(LC_EVENT_GIFT_CYC, false);  // 강연식_20140227 -제휴카드 행사 시 지급주기 변경가능
        setComboData(LC_EVENT_GIFT_CYC,"D");      //  강연식_20140227 -제휴카드 행사 시 지급주기 변경가능
        enableControl(LC_RECP_ADD_YN, false);
        setComboData(LC_RECP_ADD_YN,"Y");  
        enableControl(LC_RECP_TODAY_YN, false);
        setComboData(LC_RECP_TODAY_YN,"Y");    //당일영수증
        
    }else {                                     //01 : 브랜드행사
    	enableControl(LC_CUST_ONLY_YN, true);
        setComboData(LC_CUST_ONLY_YN,"");  
    	enableControl(LC_CARD_ONLY_YN, false);
        setComboData(LC_CARD_ONLY_YN,"N");  
        enableControl(LC_EVENT_GIFT_CYC, false);
        setComboData(LC_EVENT_GIFT_CYC,"D");  enableControl(LC_RECP_ADD_YN, false);
        setComboData(LC_RECP_ADD_YN,"Y");  
        enableControl(LC_RECP_TODAY_YN, true);
        setComboData(LC_RECP_TODAY_YN,"Y");   //당일영수증

        CHK_CAL_YN.checked = false;
        CHK_CAL_YN.disabled = false;
        CHK_PAY_TYPE_CASH.disabled = true; 
        CHK_PAY_TYPE_CARD.disabled = true; 
        CHK_PAY_TYPE_GIFT.disabled = true; 

        CHK_PAY_TYPE_CASH.checked = false;
        CHK_PAY_TYPE_CARD.checked = false;
        CHK_PAY_TYPE_GIFT.checked = false;
        
		EM_PB_APP_RATE.Enable   =	false;
		
        
    }
 </script>
 
<!---------------------	6. 컴포넌트	이벤트 처리	 ------------------------------>
<!-- 조회용	행사코드명 한건	조회 -->
<script	language=JavaScript	for=EM_S_EVENT_CD event=onKillFocus()>
//변경된 내역이	없으면 무시
if(!this.Modified)
	return;
//코드가 존재 하지 않으면 명을 클리어 후 리턴
if(	EM_S_EVENT_CD.Text ==""){
	EM_S_EVENT_NM.Text = "";
	   return;
   }
if(EM_S_EVENT_CD.text!=null){
	if(EM_S_EVENT_CD.text.length > 0){
		// 조회	이벤트 조건	검색시 점코드 필수 
		if(LC_S_STR.BindColVal.length == 0){
			showMessage(EXCLAMATION	, OK, "USER-1001", "점");
			return;
		}
		//var ret =	setMssEvtNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_S_EVENT_CD,	EM_S_EVENT_NM, '', '', "N",	LC_S_STR.BindColVal);
		var	ret	= setMssEvtMstNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_S_EVENT_CD, EM_S_EVENT_NM,	LC_S_STR.BindColVal, '4/6');
		// 조회내용이 없거나 1개 이상이면 팝업 호출
		if(ret.CountRow	== 1){
			EM_S_EVENT_CD.Text = ret.NameValue(ret.RowPosition,	"EVENT_CD");
			EM_S_EVENT_NM.Text = ret.NameValue(ret.RowPosition,	"EVENT_NM");
		}else{
		   // mssEventPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,'','','Y', LC_S_STR.BindColVal
		  //		  ,	EM_S_EVENT_S_DT.Text, EM_S_EVENT_E_DT.Text ,'02');
			mssEventMstPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,LC_S_STR.BindColVal,	'4/6');
		}
	}
}
</script>

<!-- 등록용	DEST 담당자	  조회 -->
<script	language=JavaScript	for=EM_CHAR_ID event=onKillFocus()>
	//변경된 내역이	없으면 무시
	if(!this.Modified)
		return;
	//코드가 존재 하지 않으면 명을 클리어 후 리턴
	if(	EM_CHAR_ID.Text	==""){
		EM_CHAR_NM.Text	= "";
		   return;
	   }
	
	if(EM_CHAR_ID.text!=null){
		  if(EM_CHAR_ID.text.length	> 0){
			  getUserNonPop("DS_O_RESULT", EM_CHAR_ID, EM_CHAR_NM, "E" , "Y")
		  }
	  }
</script>

<!-- 등록용	DEST 담당자	  조회 -->
<script	language=JavaScript	for=EM_ORG_CD event=onKillFocus()>
	//변경된 내역이	없으면 무시
	if(!this.Modified)
		return;
	//코드가 존재 하지 않으면 명을 클리어 후 리턴
	if(	EM_ORG_CD.Text ==""){
		EM_ORG_NM.Text = "";
		   return;
	   }
	
	if(EM_ORG_CD.text!=null){
		  if(EM_ORG_CD.text.length > 0){
			  setOrgNmWithoutPop("DS_O_RESULT",	EM_ORG_CD, EM_ORG_NM , '0',	'N', '','','','4','Y',DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition,"STR_CD"));	
		  }
		  
		  if (DS_O_RESULT.CountRow == 1	) {	 
					EM_ORG_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,	"ORG_CD");
					EM_ORG_NM.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,	"ORG_NAME");
				} else {
					//1건 이외의 내역이	조회 시	팝업 호출 
					openPop();
				}
	  }
	
</script>

<script	language=JavaScript	for=EM_CARDCOMP	event=onKillFocus()>
	//변경된 내역이	없으면 무시
	if(!this.Modified)
		return;
	//코드가 존재 하지 않으면 명을 클리어 후 리턴
	if(	EM_CARDCOMP.Text ==""){
		EM_CARDCOMP_NM.Text	= "";
		   return;
	   }
	
	if(EM_CARDCOMP.text!=null){
		  if(EM_CARDCOMP.text.length > 0){
			  getEvtCardCompNonPop(	"DS_O_RESULT", EM_CARDCOMP,	EM_CARDCOMP_NM,	 "E" , "Y",	DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition, 'STR_CD'));
		  }
	  }
</script>


<!-- 점 변경시 -->
<script	language=JavaScript	for=LC_S_STR event=OnSelChange>
	if(LC_S_STR.BindColVal != ""){
		DS_O_DEPT.ClearData();
		DS_O_TEAM.ClearData();
		DS_O_PC.ClearData();
	}
</script>

<!-- 부문 변경시 -->
<script	language=JavaScript	for=LC_DEPT	event=OnSelChange>
	if(LC_DEPT.BindColVal != ""){
		DS_O_TEAM.ClearData();
		DS_O_PC.ClearData();
		getTeam("DS_O_TEAM", "N", LC_S_STR.BindColVal, LC_DEPT.BindColVal, "Y");
		//getPc("DS_O_PC", "N", LC_S_STR.BindColVal, LC_DEPT.BindColVal, LC_TEAM.BindColVal, "Y");
		LC_TEAM.Index =	0;
		//LC_PC.Index	= 0;
	}
</script>

<!-- 팀	변경시 -->
<script	language=JavaScript	for=LC_TEAM	event=OnSelChange>
	if(LC_DEPT.BindColVal != ""){
		DS_O_PC.ClearData();
		getPc("DS_O_PC", "N", LC_S_STR.BindColVal, LC_DEPT.BindColVal, LC_TEAM.BindColVal, "Y");
		LC_PC.Index	= 0;
	}	

</script>


<script	language="javascript" for=GD_EVTPBN  event=OnHeadCheckClick(Col,Colid,bCheck)>
	var	strFlag	= "T";
	if(Colid ==	"FLAG"){
		if(bCheck == "0") strFlag =	"F"
		for(var	i=1; i<=DS_O_EVTPBN.CountRow; i++){
			DS_O_EVTPBN.NameString(i, Colid) = strFlag;
		}
	}
</script>

<script	language="javascript" for=GD_EVTSTRPBN  event=OnHeadCheckClick(Col,Colid,bCheck)>
	var	strFlag	= "T";
	if(Colid ==	"FLAG"){
		if(bCheck == "0") strFlag =	"F"
		for(var	i=1; i<=DS_IO_EVTSTRPBN.CountRow; i++){
			DS_IO_EVTSTRPBN.NameString(i, Colid) = strFlag;
		}
	}
</script>

<script	language=JavaScript	for=DS_O_EVTMST	event=CanRowPosChange(row)>
	if(DS_O_EVTMST.CountRow	== 0) return;
		if(strStrEvtFlag ||	DS_IO_EVTSTRPBN.IsUpdated || DS_IO_EVTSTRSKU.IsUpdated){
			if(showMessage(QUESTION	, YESNO, "GAUCE-1000", "변경된 내용이 있습니다.	이동 하시겠습니까?") !=	1 ){
				return false;
			}
		}
		strStrEvtFlag =	false;
		return true;
</script>

<script	language=JavaScript	for=DS_O_EVTMST	event=OnRowPosChanged(row)>

 	if(row	== 0) return;
 	if(btnClickSearch)	return;
	
 	DS_O_EVENT_TYPE.Filter();


 	//--- 대상범위	데이터셋 조회
 	getTrg();
	
 	//--- 점별	사은행사 정보 조회
 	getStrEvt();
	
 	//-- 컴포넌트	Enable/Disable 설정
 	setObject();
		
	//--- 전체브랜드선택 여부
 	chkAllBrand();
	
 	//chkCalyn();
</script>


<!-- Grid GD_EVTSTRSKU OnPopup event 처리 -->
<script	language=JavaScript	for=GD_EVTSTRSKU  event=OnPopup(row,colid,data)>
if((colid == "SKU_CD") && (row > 0)){
	if(LC_EVENT_GIFT_TYPE.BindColVal ==	""){
		showMessage(EXCLAMATION	, OK, "USER-1000", "사은품 종류를 선택하세요.");
		LC_EVENT_GIFT_TYPE.Focus();
	}else{
		DS_IO_EVTSTRSKU.NameValue(DS_IO_EVTSTRSKU.RowPosition, "SKU_GB") = LC_EVENT_GIFT_TYPE.BindColVal;
		
		//popup_mss.js 의 getSkuPop 함수 사용 - ccom220호출 하여 ccom220_service의 [SEL_SKU_POP2] 쿼리 사용
		var	rtnMap = getSkuPop("SEL_SKU_POP2"
				 , DS_IO_EVTSTRSKU.NameValue(DS_IO_EVTSTRSKU.RowPosition, "STR_CD")
				 , DS_IO_EVTSTRSKU.NameValue(DS_IO_EVTSTRSKU.RowPosition, "SKU_GB"));
		
		DS_IO_EVTSTRSKU.NameValue(DS_IO_EVTSTRSKU.RowPosition, "SKU_CD") = "";
		DS_IO_EVTSTRSKU.NameValue(DS_IO_EVTSTRSKU.RowPosition, "SKU_NAME") = "";
		DS_IO_EVTSTRSKU.NameValue(DS_IO_EVTSTRSKU.RowPosition, "BUY_COST_PRC") = "";
		DS_IO_EVTSTRSKU.NameValue(DS_IO_EVTSTRSKU.RowPosition, "SKU_GB") = "";
		DS_IO_EVTSTRSKU.NameValue(DS_IO_EVTSTRSKU.RowPosition, "SKU_GB_NM")	= "";
		
		if(rtnMap != null){
			for(var	i=1;i<=DS_IO_EVTSTRSKU.CountRow;i++){
				if(DS_IO_EVTSTRSKU.NameValue(i,"SKU_CD") ==	rtnMap.get("SKU_CD")){
					showMessage(EXCLAMATION	, OK, "USER-1000", "중복된 사은품이	있습니다.");
					return;
				}
			}
			DS_IO_EVTSTRSKU.NameValue(DS_IO_EVTSTRSKU.RowPosition, "SKU_CD")= rtnMap.get("SKU_CD");
			DS_IO_EVTSTRSKU.NameValue(DS_IO_EVTSTRSKU.RowPosition, "SKU_NAME") = rtnMap.get("SKU_NAME");
			DS_IO_EVTSTRSKU.NameValue(DS_IO_EVTSTRSKU.RowPosition, "BUY_COST_PRC") = rtnMap.get("BUY_COST_PRC");
			DS_IO_EVTSTRSKU.NameValue(DS_IO_EVTSTRSKU.RowPosition, "SKU_GB") = rtnMap.get("SKU_GB");
			DS_IO_EVTSTRSKU.NameValue(DS_IO_EVTSTRSKU.RowPosition, "SKU_GB_NM")	= rtnMap.get("SKU_GB_NM");
		}
	}
}
</script>
<script	language=JavaScript	for=GD_EVTMSTR event=OnClick(row,colid)>
  if(row ==	0) sortColId( eval(this.DataID), row, colid);
</script>
<script	language=JavaScript	for=DS_O_EVTMSTR event=OnRowPosChanged(row)>
 if(clickSORT)
	 return;
</script>
<!-- Grid GD_EVTSTRSKU 삭제	처리 -->
<script	language=JavaScript	for=GD_EVTSTRSKU event=OnClick(row,colid)>
  if(row ==	0) sortColId( eval(this.DataID), row, colid);
	if(colid ==	"DEL"){
		DS_IO_EVTSTRSKU.DeleteRow(row);
		if(DS_IO_EVTSTRSKU.CountRow	== 0){
			setEvtInfo(DS_IO_EVTSTRSKU,	false);
		}
	}	 
</script>
<script	language=JavaScript	for=DS_IO_EVTSTRSKU
	event=OnRowPosChanged(row)>
 if(clickSORT)
	 return;
</script>
<script	language=JavaScript	for=GD_EVTPBN event=OnClick(row,colid)>
  if(row ==	0) sortColId( eval(this.DataID), row, colid);
</script>
<script	language=JavaScript	for=DS_O_EVTPBN	event=OnRowPosChanged(row)>
 if(clickSORT)
	 return;
</script>
<script	language=JavaScript	for=GD_EVTSTRPBN event=OnClick(row,colid)>
  if(row ==	0) sortColId( eval(this.DataID), row, colid);
</script>
<script	language=JavaScript	for=DS_IO_EVTSTRPBN
	event=OnRowPosChanged(row)>
 if(clickSORT)
	 return;
</script>


<!-- Grid GD_EVTSTRPBN 인정율 100% 이하	만 등록	가능 -->
<script	language=JavaScript	for=GD_EVTSTRPBN
	event=OnExit(row,colid,olddata)>
if((colid == "APP_RATE") &&	(DS_IO_EVTSTRPBN.NameValue(row,	colid) > 100 ||	DS_IO_EVTSTRPBN.NameValue(row, colid) <	0)){
	showMessage(EXCLAMATION	, OK, "USER-1000", "인정률은0 ~	100	범위로 입력하세요.");
	DS_IO_EVTSTRPBN.NameValue(row, colid) =	100;
	strEvtStrPbnFlag = false;
}else{
	strEvtStrPbnFlag = true;
}
</script>

<!-- 제휴카드사	부담율 100%	이하 만	등록 가능 -->
<script	language=JavaScript	for=EM_APP_RATE	event=OnKillFocus()>
if(this.Text > 100 || this.Text	< 0){
	showMessage(EXCLAMATION	, OK, "USER-1000", "부담률은0 ~	100	범위로 입력하세요.");
	this.Text =	100;
	this.Focus();
}
</script>

<!-- Grid GD_EVTSTRPBN 인정율 100% 이하	만 등록	가능 -->
<script	language=JavaScript	for=GD_EVTSTRPBN
	event=CanColumnPosChange(row,colid)>
	return strEvtStrPbnFlag;
</script>

<script	language=JavaScript	for=GD_EVTSTRSKU event=OnListSelect(index)>
DS_IO_EVTSTRSKU.NameValue(DS_IO_EVTSTRSKU.RowPosition, "TRG_F")	= DS_O_TRG.NameValue(index,"TRG_F");
DS_IO_EVTSTRSKU.NameValue(DS_IO_EVTSTRSKU.RowPosition, "TRG_T")	= DS_O_TRG.NameValue(index,"TRG_T");
</script>
<script	language=JavaScript	for=LC_S_STR event=OnSelChange()>
 EM_S_EVENT_CD.Text	= "";
 EM_S_EVENT_NM.Text	= "";
</script>
<!--*************************************************************************-->
<!--* C. 가우스	이벤트 처리	끝												 *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스	DataSet	& Transaction 정의									 *-->
<!--*	 1.	DataSet
<!--*	 2.	Transaction
<!--*************************************************************************-->

<!---------------------	1. DataSet	------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용	-->
<comment id="_NSID_"><object id="DS_O_S_STR" 			classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVENT_TYPE"		classid=<%= Util.CLSID_DATASET%>><param name=UseFilter value=true></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVENT_GIFT_TYPE"	classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SKU_GB"			classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TRG"				classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"			classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CARD_COMP"		classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"			classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"		classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVENT_GIFT_CYC"	classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RECP_ADD_YN"		classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RECP_TODAY_YN"	classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVENT_TYPE_NM"	classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CUST_ONLY_YN"		classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CARD_ONLY_YN"		classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_DEPT"				classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TEAM"				classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PC"				classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVTMST"			classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_STREVT"			classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_STREVT_COPY"		classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVTPBN"			classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_EVTSTRPBN"		classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_EVTSTRSKU"		classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!---------------------	2. Transaction	--------------------------------------->
<comment id="_NSID_"><object id="TR_MAIN" 				classid=<%= Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스	DataSet	& Transaction 정의 끝									*-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_EVTMSTR");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
    var obj   = document.getElementById("GD_EVTPBN");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top2+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
    }
    obj.style.height  = grd_height + "px";
    
    var obj   = document.getElementById("GD_EVTSTRPBN");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top2+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
    }
    obj.style.height  = grd_height + "px";
    
    var obj   = document.getElementById("GD_EVTSTRSKU");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top3+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top3);
    }
    obj.style.height  = grd_height + "px";
}
</script>


<!--*************************************************************************-->
<!--* E. 본문시작																*-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@	include	file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 //	-->
	<div id="testdiv" class="testdiv">
		<input type=hidden id=HD_VEN_CD>
		<table width="100%"	border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td	class="PT01	PB03">
					<table width="100%"	border="0" cellspacing="0" cellpadding="0"
						class="o_table">
						<tr>
							<td>
								<!-- search	start -->
								<table width="100%"	border="0" cellpadding="0" cellspacing="0"
									class="s_table">
									<tr>
										<th	width="50" class="point">점</th>
										<td	width="120"><comment id="_NSID_"> <object
												id=LC_S_STR	classid=<%=Util.CLSID_LUXECOMBO%> width="117"
												tabindex=1 align="absmiddle"> </object>	</comment> <script>_ws_(_NSID_);</script>
										</td>
										<th	width="60" class="point">행사기간</th>
										<td	width="200"><comment id="_NSID_"> <object
												id=EM_S_EVENT_S_DT classid=<%=Util.CLSID_EMEDIT%> width="70"
												onblur="javascript:checkDateTypeYMD(this);"	tabindex=1
												align="absmiddle"> </object> </comment>	<script>_ws_(_NSID_);</script>
											<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
											onclick="javascript:openCal('G',EM_S_EVENT_S_DT)" /> ~ <comment
												id="_NSID_"> <object id=EM_S_EVENT_E_DT
												classid=<%=Util.CLSID_EMEDIT%>
												onblur="javascript:checkDateTypeYMD(this);"	width="70"
												tabindex=1 align="absmiddle"> </object>	</comment> <script>_ws_(_NSID_);</script>
											<img src="/<%=dir%>/imgs/btn/date.gif"
											onclick="javascript:openCal('G',EM_S_EVENT_E_DT)"
											align="absmiddle" />
										</td>
										<th	width="60">행사코드</th>
										<td><comment id="_NSID_"> <object
												id=EM_S_EVENT_CD classid=<%=Util.CLSID_EMEDIT%>	width=90
												tabindex=1 align="absmiddle"> </object>	</comment> <script>_ws_(_NSID_);</script>
											<img src="/pot/imgs/btn/detail_search_s.gif"
											onclick="javascript:getSEvent();" align="absmiddle"	/> <comment
												id="_NSID_"> <object id=EM_S_EVENT_NM
												classid=<%=Util.CLSID_EMEDIT%> width=120 align="absmiddle">
											</object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
								</table></td>
						</tr>
					</table></td>
			</tr>
			<tr>
				<td	class="dot"></td>
			</tr>
			<tr	valign="top">
				<td><table width="100%"	border="0" cellspacing="0"
						cellpadding="0">
						<tr	valign="top">
							<td	width="295"><table width="100%"	border="0"
									cellspacing="0"	cellpadding="0">
									<tr>
										<td><table width="100%"	border="0" cellspacing="0"
												cellpadding="0"	class="BD4A">
												<tr>
													<td><comment id="_NSID_"> <OBJECT
															id=GD_EVTMSTR width=100% height=504
															classid=<%=Util.CLSID_GRID%>>
															<param name="DataID" value="DS_O_EVTMST">
														</OBJECT></comment>	<script>_ws_(_NSID_);</script>
													</td>
												</tr>
											</table></td>
									</tr>
								</table></td>
							<td	class="PL10"><table	width="100%" border="0"
									cellspacing="0"	cellpadding="0">
									<tr>
										<td	class="PT01	PB03"><table width="100%" border="0"
												cellspacing="0"	cellpadding="0">
												<tr>
													<td><table width="100%"	border="0" cellpadding="0"
															cellspacing="0"	class="s_table">
															<tr>
																<th	width="100">점</th>
																<td	colspan="3"><comment id="_NSID_"> <object
																		id=EM_STR classid=<%=Util.CLSID_EMEDIT%> width=140
																		tabindex=1 align="absmiddle"> </object>	</comment> <script>_ws_(_NSID_);</script>
																</td>
															</tr>
															<tr>
																<th	width="100">행사코드</th>
																<td	width="150"><comment id="_NSID_"> <object
																		id=EM_EVENT_CD classid=<%=Util.CLSID_EMEDIT%>
																		width=140 tabindex=1 align="absmiddle">	</object> </comment> <script>_ws_(_NSID_);</script>
																</td>
																<th	width="80">행사명</th>
																<td><comment id="_NSID_"> <object
																		id=EM_EVENT_NM classid=<%=Util.CLSID_EMEDIT%>
																		width=140 tabindex=1 align="absmiddle">	</object> </comment> <script> _ws_(_NSID_);</script>
																</td>
															</tr>
															<tr>
																<th	width="100">행사시작일</th>
																<td><comment id="_NSID_"> <object
																		id=EM_EVENT_S_DT classid=<%=Util.CLSID_EMEDIT%>
																		width=140 tabindex=1 align="absmiddle">	</object> </comment> <script>_ws_(_NSID_);</script>
																</td>
																<th	width="80">행사종료일</th>
																<td><comment id="_NSID_"> <object
																		id=EM_EVENT_E_DT classid=<%=Util.CLSID_EMEDIT%>
																		width=140 tabindex=1 align="absmiddle">	</object> </comment> <script>_ws_(_NSID_);</script>
																</td>
															</tr>
															<tr>
																<th	width="100" class="point">행사주관부서</th>
																<td	colspan=3><comment id="_NSID_">	<object
																		id=EM_ORG_CD classid=<%=Util.CLSID_EMEDIT%>	width=140
																		tabindex=1 align="absmiddle"> </object>	</comment> <script>_ws_(_NSID_);</script>
																	<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
																	align="absmiddle" class="PR03"
																	onclick="javascript:openPop();"	id=popOrg /> <comment
																		id="_NSID_"> <object id=EM_ORG_NM
																		classid=<%=Util.CLSID_EMEDIT%> width=145 tabindex=1
																		align="absmiddle"> </object> </comment>	<script>_ws_(_NSID_);</script>
																</td>
															</tr>
															<tr>
																<th	width="100">행사테마(대)</th>
																<td><comment id="_NSID_"> <object
																		id=EM_EVENT_L_CD classid=<%=Util.CLSID_EMEDIT%>
																		width=140 tabindex=1 align="absmiddle">	</object> </comment> <script>_ws_(_NSID_);</script>
																</td>

																<th	width="80">행사종류</th>
																<td><comment id="_NSID_"> <object
																		id=EM_EVENT_TYPE_NM	classid=<%=Util.CLSID_EMEDIT%>
																		height=100 width=140 tabindex=1	align="absmiddle">
																	</object> </comment> <script>_ws_(_NSID_);</script>
																</td>

															</tr>
															<tr>

																<th	width="100">행사테마(중)</th>
																<td><comment id="_NSID_"> <object
																		id=EM_EVENT_M_CD classid=<%=Util.CLSID_EMEDIT%>
																		width=140 tabindex=1 align="absmiddle">	</object> </comment> <script>_ws_(_NSID_);</script>
																</td>
																<th	width="80">행사테마(소)</th>
																<td><comment id="_NSID_"> <object
																		id=EM_EVENT_S_CD classid=<%=Util.CLSID_EMEDIT%>
																		width=140 tabindex=1 align="absmiddle">	</object> </comment> <script>_ws_(_NSID_);</script>
																</td>
															</tr>
															
															
															<tr>
																<th	width="100" class="point">사은행사유형</th>
																<td><comment id="_NSID_"> <object
																		id=LC_EVENT_TYPE classid=<%=Util.CLSID_LUXECOMBO%>
																		height=100 width=140 tabindex=1	align="absmiddle">
																	</object> </comment> <script>_ws_(_NSID_);</script>
																</td>
																<!-- th  width="100"> 부가사항 </th--> <!-- 2017.09.05 jyk -->
																<!-- td-->
																	<input type="checkbox" id=CHK_MEMBONLY_YN align="absmiddle"   onclick="" tabindex=1 style="display:none"> 회원만적용 &nbsp; <!-- 2017.09.05 jyk -->
																	<input type="checkbox" id=CHK_RECP_YN align="absmiddle"   onclick="" tabindex=1 style="display:none"> 영수증 표기여부 &nbsp; <!-- 2017.09.05 jyk -->
																<!--/td-->
															</tr>
															<tr>
															
																									
										                       <th  width="100">정산여부</th>
										                       <td>
										                            <input type="checkbox" id=CHK_CAL_YN align="absmiddle"   onclick="javascript:chkCalyn();" tabindex=1 > 
										                       </td>								
										                       <th  width="100">결제유형</th>
										                       <td>
										                            <input type="checkbox" id=CHK_PAY_TYPE_CASH value="F"   align="absmiddle"  tabindex=1 >현금 &nbsp;
										                            <input type="checkbox" id=CHK_PAY_TYPE_CARD value="F"   align="absmiddle"  tabindex=1 >카드 &nbsp;
										                            <input type="checkbox" id=CHK_PAY_TYPE_GIFT value="F"   align="absmiddle"  tabindex=1 >상품권
										                       </td>
                       
															</tr>
															
															<tr>
																<th	width="100">브랜드 부담율</th>
																<td	><comment id="_NSID_">	<object
																		id=EM_PB_APP_RATE classid=<%=Util.CLSID_EMEDIT%> width=50
																		tabindex=1 align="absmiddle"> </object>	</comment> <script>_ws_(_NSID_);</script>
																</td>
																<th  width="100">중복지급여부</th>
										                        <td>
										                            <input type="checkbox" id=CHK_DBL_PAID_YN value="F"   align="absmiddle"  tabindex=1 >중복지급
										                        </td>
																
															</tr>
															
															<tr>
																<th	width="100" class="point">영수증 당일여부</th>
																<td><comment id="_NSID_"> <object
																		id=LC_RECP_TODAY_YN	classid=<%=Util.CLSID_LUXECOMBO%>
																		height=100 width=140 tabindex=1	align="absmiddle">
																	</object> </comment> <script>_ws_(_NSID_);</script>
																</td>
																<th	width="80" class="point">사은품	종류</th>
																<td><comment id="_NSID_"> <object
																		id=LC_EVENT_GIFT_TYPE
																		classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=140
																		tabindex=1 align="absmiddle"> </object>	</comment> <script>_ws_(_NSID_);</script>
																</td>
															</tr>
															<tr style="display:none;">
																<th	width="100" class="point">보너스카드	ONLY</th>
																<td><comment id="_NSID_"> <object
																		id=LC_CUST_ONLY_YN classid=<%=Util.CLSID_LUXECOMBO%>
																		height=100 width=140 tabindex=1	align="absmiddle">
																	</object> </comment> <script>_ws_(_NSID_);</script>
																</td>

																<th	width="80" class="point">신용카드 ONLY</th>
																<td><comment id="_NSID_"> <object
																		id=LC_CARD_ONLY_YN classid=<%=Util.CLSID_LUXECOMBO%>
																		height=100 width=140 tabindex=1	align="absmiddle">
																	</object> </comment> <script>_ws_(_NSID_);</script>
																</td>
															</tr>


															<tr>
																<th	width="100" class="point">사은품 지급주기</th>
																<td><comment id="_NSID_"> <object
																		id=LC_EVENT_GIFT_CYC classid=<%=Util.CLSID_LUXECOMBO%>
																		height=100 width=140 tabindex=1	align="absmiddle">
																	</object> </comment> <script>_ws_(_NSID_);</script>
																</td>
																<th	width="80" class="point">영수증 합산</th>
																<td><comment id="_NSID_"> <object
																		id=LC_RECP_ADD_YN classid=<%=Util.CLSID_LUXECOMBO%>
																		height=100 width=140 tabindex=1	align="absmiddle">
																	</object> </comment> <script>_ws_(_NSID_);</script>
																</td>
															</tr>
															<tr>
																<th	width="100" class="point">DESK담당자</th>
																<td	colspan="3"><comment id="_NSID_"> <object
																		id=EM_CHAR_ID classid=<%=Util.CLSID_EMEDIT%> width=140
																		onKeyup="javascript:checkByteStr(this, 10, 'Y');"
																		tabindex=1 align="absmiddle"> </object>	</comment> <script>_ws_(_NSID_);</script>
																	<img id=IMG_DESK
																	src="/<%=dir%>/imgs/btn/detail_search_s.gif"
																	class="PR03"
																	onclick="javascript:getUserPop(	EM_CHAR_ID,	EM_CHAR_NM,	'S'	);"
																	align="absmiddle" /> <comment id="_NSID_"> <object
																		id=EM_CHAR_NM classid=<%=Util.CLSID_EMEDIT%> width=145
																		tabindex=1 align="absmiddle"> </object>	</comment> <script>_ws_(_NSID_);</script>
																</td>
															</tr>
															<tr>
																<th	width="100">제휴카드/부담율</th>
																<td	colspan=3><comment id="_NSID_">	<object
																		id=EM_CARDCOMP classid=<%=Util.CLSID_EMEDIT%>
																		width=140
																		onKeyup="javascript:checkByteStr(this, 10, 'Y');"
																		tabindex=1 align="absmiddle"> </object>	</comment> <script>_ws_(_NSID_);</script>
																	<img id=IMG_CARDCOMP
																	src="/<%=dir%>/imgs/btn/detail_search_s.gif"
																	class="PR03"
																	onclick="javascript:getEvtCardComp(	EM_CARDCOMP, EM_CARDCOMP_NM, 'S', DS_O_EVTMST.NameValue(DS_O_EVTMST.RowPosition, 'STR_CD'));"
																	align="absmiddle" /> <comment id="_NSID_"> <object
																		id=EM_CARDCOMP_NM classid=<%=Util.CLSID_EMEDIT%>
																		width=145 tabindex=1 align="absmiddle">	</object> </comment> <script>_ws_(_NSID_);</script>
																	/ <comment id="_NSID_">	<object
																		id=EM_APP_RATE classid=<%=Util.CLSID_EMEDIT%> width=50
																		tabindex=1 align="absmiddle"> </object>	</comment> <script>_ws_(_NSID_);</script>
																</td>
															</tr>
														</table></td>
												</tr>
											</table></td>
									</tr>
									<tr>
										<td	class="PT10">
											<div id=TAB	width="100%" height=500	TitleWidth=120
												TitleAlign="center"	TitleStyle="" TitleGap=3>
												<menu TitleName="참여브랜드/인정율"	DivId="tab_page1" />
												<menu TitleName="사은품" DivId="tab_page2" />
											</div>
											<div id=tab_page1>
												<table width="100%"	border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td	class="PT03	PB03"><table width="100%" border="0"
																cellspacing="0"	cellpadding="0"	class="s_table">
																<tr>
																	<th	width="60">부문</th>
																	<td width="110"><comment id="_NSID_"> <object
																			id=LC_DEPT classid=<%=Util.CLSID_LUXECOMBO%>
																			height=130 width=100 tabindex=1	align="absmiddle">
																		</object> </comment> <script>_ws_(_NSID_);</script>
																	</td>
																	<th	width="60">팀</th>
																	<td width="110"><comment id="_NSID_"> <object
																			id=LC_TEAM classid=<%=Util.CLSID_LUXECOMBO%>
																			height=100 width=100 tabindex=1	align="absmiddle">
																		</object> </comment> <script>_ws_(_NSID_);</script>
																	</td>
																	<th	width="60">PC</th>
																	<td><comment id="_NSID_"> <object
																			id=LC_PC classid=<%=Util.CLSID_LUXECOMBO%> height=100
																			width=100 tabindex=1 align="absmiddle">	</object> </comment> <script>_ws_(_NSID_);</script>
																	</td>
																</tr>
															</table></td>
													</tr>
													<tr>
														<td>
															<table width="100%"	border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td	width="230">
																		<table width="100%"	border="0" cellspacing="0"
																			cellpadding="0">
																			<tr>
																				<td	class="sub_title PT10 PB03"><img
																					src="/<%=dir%>/imgs/comm/ring_blue.gif"
																					class="PR03" align="absmiddle" />브랜드	마스터</td>

																				<td	align="right"><img id=IMG_PUMBUN
																					src="/<%=dir%>/imgs/btn/label_search.gif"
																					onclick="javascript:getPumbun();" class="PR03"
																					align="absmiddle" />
																				</td>
																			</tr>
																			<tr>
																				<td	colspan=2>
																					<table width="100%"	border="0" cellspacing="0"
																						cellpadding="0"	class="BD4A">
																						<tr>
																							<td><comment id="_NSID_"> <OBJECT
																									id=GD_EVTPBN width=230 height=130
																									classid=<%=Util.CLSID_GRID%>>
																									<param name="DataID" value="DS_O_EVTPBN">
																								</OBJECT></comment>	<script>_ws_(_NSID_);</script>
																							</td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																		</table>
																	</td>

																	<td	class="PR03	PL03"><img id=IMG_ADD
																		src="/<%=dir%>/imgs/btn/next.gif"
																		onclick="javascript:addPumbun();" align="absmiddle"	/>
																		<br> <img id=IMG_DEL
																		src="/<%=dir%>/imgs/btn/before.gif"
																		onclick="javascript:delPumbun();" align="absmiddle"	/>
																	</td>

																	<td	width="100%"><table	width="100%" border="0"
																			cellspacing="0"	cellpadding="0">
																			<tr>
																				<td>
																					<table width="100%"	border="0" cellspacing="0"
																						cellpadding="0">
																						<tr>
																							<td	class="sub_title PT10 PB03"><img
																								src="/<%=dir%>/imgs/comm/ring_blue.gif"
																								class="PR03" align="absmiddle" />참여브랜드</td>
																							<td	align="right"><input type="checkbox"
																								id=CHK_ALLBRAND
																								onclick="javacript:chkAllBrand();">	전체
																								브랜드 적용</td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																			<tr>
																				<td>
																					<table width="100%"	border="0" cellspacing="0"
																						cellpadding="0"	class="BD4A">
																						<tr>
																							<td><comment id="_NSID_"> <OBJECT
																									id=GD_EVTSTRPBN	width=100% height=130
																									classid=<%=Util.CLSID_GRID%>>
																									<param name="DataID" value="DS_IO_EVTSTRPBN">
																									<param name=Enable  value="True">
																								</OBJECT></comment>	<script>_ws_(_NSID_);</script>
																							</td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																		</table></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</div>
											<div id=tab_page2>
												<table width="100%"	border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td	align="right" class="PT03 PB03"><img
															id="IMG_ADD_ROW" style="vertical-align:	middle;"
															src="/<%=dir%>/imgs/btn/add_row.gif" width="52"
															height="18"	onclick="btn_AddRow();"	hspace="2" /> <img
															id="IMG_DEL_ROW" style="vertical-align:	middle;"
															src="/<%=dir%>/imgs/btn/del_row.gif" width="52"
															height="18"	onclick="btn_DeleteRow();" />
														</td>
													</tr>
													<tr>
														<td>
															<table width="100%"	border="0" cellspacing="0"
																cellpadding="0"	class="BD4A">
																<tr>
																	<td><comment id="_NSID_"> <OBJECT
																			id=GD_EVTSTRSKU	width=100% height=163
																			classid=<%=Util.CLSID_GRID%>>
																			<param name="DataID" value="DS_IO_EVTSTRSKU">
																		</OBJECT></comment>	<script>_ws_(_NSID_);</script>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</div>
										</td>
									</tr>
								</table></td>
						</tr>
					</table></td>
			</tr>
		</table>
	</div>
	<!-----------------------------------------------------------------------------
  Gauce	Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object	id=BO_EVTMST classid=<%=Util.CLSID_BIND%>>
		<param name=DataID			value=DS_O_EVTMST>
		<param name="ActiveBind"	value=true>
		<param name=BindInfo		value='
		<c>col=STR_NM				ctrl=EM_STR					param=Text</c>
		<c>col=EVENT_CD				ctrl=EM_EVENT_CD			param=Text</c>
		<c>col=EVENT_NAME			ctrl=EM_EVENT_NM			param=Text</c>
		<c>col=EVENT_S_DT			ctrl=EM_EVENT_S_DT			param=Text</c>
		<c>col=EVENT_E_DT			ctrl=EM_EVENT_E_DT			param=Text</c>
		<c>col=EVENT_L_NM			ctrl=EM_EVENT_L_CD			param=Text</c>
		<c>col=EVENT_M_NM			ctrl=EM_EVENT_M_CD			param=Text</c>
		<c>col=EVENT_S_NM			ctrl=EM_EVENT_S_CD			param=Text</c>
		<c>col=EVENT_TYPE_NM		ctrl=EM_EVENT_TYPE_NM		param=Text</c>
		'>
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object	id=BO_EVTSTR classid=<%=Util.CLSID_BIND%>>
		<param name=DataID			value=DS_IO_STREVT>
		<param name="ActiveBind"	value=true>
		<param name=BindInfo		value='
		<c>col=EVENT_TYPE			ctrl=LC_EVENT_TYPE			param=BindColVal</c>
		<c>col=EVENT_GIFT_TYPE		ctrl=LC_EVENT_GIFT_TYPE		param=BindColVal</c>
		<c>col=CHAR_ID				ctrl=EM_CHAR_ID				param=Text</c>
		<c>col=CHAR_NM				ctrl=EM_CHAR_NM				param=Text</c>
		<c>col=CARD_COMP			ctrl=EM_CARDCOMP			param=Text</c>
		<c>col=CARD_COMP_NM			ctrl=EM_CARDCOMP_NM			param=Text</c>
		<c>col=VEN_CD				ctrl=HD_VEN_CD				param=Value</c>
		<c>col=APP_RATE				ctrl=EM_APP_RATE			param=Text</c>
		<c>col=ORG_CD				ctrl=EM_ORG_CD				param=Text</c>
		<c>col=ORG_NM				ctrl=EM_ORG_NM				param=Text</c>
		<c>col=EVENT_GIFT_CYC		ctrl=LC_EVENT_GIFT_CYC		param=BindColVal</c>
		<c>col=RECP_ADD_YN			ctrl=LC_RECP_ADD_YN			param=BindColVal</c>
		<c>col=RECP_TODAY_YN		ctrl=LC_RECP_TODAY_YN		param=BindColVal</c>
		<c>col=CUST_ONLY_YN			ctrl=LC_CUST_ONLY_YN		param=BindColVal</c>
		<c>col=CARD_ONLY_YN			ctrl=LC_CARD_ONLY_YN		param=BindColVal</c>		
		<c>col=CAL_YN			    ctrl=CHK_CAL_YN		        param=checked</c>
		<c>col=PAY_TYPE_CASH	    ctrl=CHK_PAY_TYPE_CASH		param=checked</c>
		<c>col=PAY_TYPE_CARD		ctrl=CHK_PAY_TYPE_CARD		param=checked</c>
		<c>col=PAY_TYPE_GIFT	    ctrl=CHK_PAY_TYPE_GIFT		param=checked</c>
		<c>col=PB_APP_RATE			ctrl=EM_PB_APP_RATE		    param=Text</c>	
		<c>col=DBL_PAID_YN	        ctrl=CHK_DBL_PAID_YN		param=checked</c>
		<c>col=RECP_DISP_YN	        ctrl=CHK_RECP_YN			param=checked</c>			<!-- 2017.09.05 jyk -->
		<c>col=MEMB_ONLY_YN	        ctrl=CHK_MEMBONLY_YN		param=checked</c>		  	<!-- 2017.09.05 jyk -->
		'>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

