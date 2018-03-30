<!-- 
/*******************************************************************************
 * 시스템명	: 경영지원 > 사은행사관리 >	사은품 지급/취소 > 사은품지급등록(리콜방문)G
 * 작 성 일	: 2011.01.18
 * 작 성 자	: 김슬기
 * 수 정 자	: 홍종영
 * 파 일 명	: MCAE4170.jsp
 * 버	 전	: 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개	 요	: 백화점의 각 점정보를 관리한다
 * 이	 력	:
 *		  2011.01.18 (김슬기) 신규작성
 *		  2011.03.04 (김성미) 프로그램 작성
 *		  2012.06.14 (홍종영) 프로그램 수정(mcae414 복사)
 ******************************************************************************/
-->
<%@	page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@	taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@	taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@	taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@	taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인	유무, 기본설정												  *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
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
<script	language="javascript" src="/<%=dir%>/js/popup_mss.js"	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작														  *-->
<!--*************************************************************************-->

<script	LANGUAGE="JavaScript"><!--


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var strUserID = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
var strUserNM = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />';
var strToday	 ="";
/**
 * doInit()
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: 해당 페이지 LOAD 시  
 * return값	: void
 */
function doInit(){

	// Input Data Set Header 초기화
	DS_IO_SALE_INFO.setDataHeader('<gauce:dataset name="H_SALE_INFO"/>');
	DS_IO_SALE_INFO_TEMP.setDataHeader('<gauce:dataset name="H_SALE_INFO"/>');
	DS_IO_SALE_INFO_TEMP2.setDataHeader('<gauce:dataset	name="H_SALE_INFO"/>');
	DS_O_SKU_INFO.setDataHeader('<gauce:dataset	name="H_SKU_LIST"/>');
	DS_IO_GIFTCARD_NO.setDataHeader('<gauce:dataset	name="H_GIFTCARD_NO"/>');
	DS_O_CHECK.setDataHeader('<gauce:dataset name="H_GIFTCARD_NO_CHK"/>');
	// Output Data Set Header 초기화
	
	//그리드 초기화	
	gridCreate1(); // 영수증 정보
	gridCreate2();
	gridCreate3(); // 상품권 등록 정보
		
	// EMedit에	초기화
	initEmEdit(EM_PRSNT_DT,	"TODAY", READ);													//등록일자
	initEmEdit(EM_PRSNT_CHAR_NM, "GEN",	READ);												//등록자
	initEmEdit(EM_STR_NM, "GEN", READ);														//점
	initEmEdit(EM_EVENT_TYPE, "GEN", READ);													//사은행사유형
	initEmEdit(EM_EVENT_CD,	"GEN", READ);													//행사코드
	initEmEdit(EM_EVENT_NAME, "GEN", READ);													//행사명
	initEmEdit(EM_EVENT_S_DT, "YYYYMMDD", READ);											//행사기간 S
	initEmEdit(EM_EVENT_E_DT, "YYYYMMDD", READ);											//행사기간 E
	initEmEdit(EM_EVENT_TYPE_NM, "GEN",	READ);												//행사종류
	initEmEdit(EM_EVENT_GIFT_CYC, "GEN",	READ);											//사은품 지급주기
	initEmEdit(EM_CUST_ONLY_YN, "GEN",	READ);												//보너스 카드 ONLY
	initEmEdit(EM_CARD_ONLY_YN, "GEN",	READ);												//신용카드 ONLY
	initEmEdit(EM_RECP_ADD_YN, "GEN",	READ);												//영수증 합산여부
	initEmEdit(EM_RECP_TODAY_YN, "GEN",	READ);												//영수증 당일여부
	
	initEmEdit(EM_SS_NO, "GEN^13", NORMAL);													//고객주민번호
	
	initEmEdit(EM_CARD_CUST_ID,	"GEN^16", NORMAL);											//고객카드번호
	initEmEdit(EM_CONF_ID, "GEN", PK);														//승인자코드
	initEmEdit(EM_CONF_NM, "GEN", READ);													//승인자명
	initEmEdit(EM_SKU_CD, "GEN", PK);														//지급품코드
	initEmEdit(EM_SKU_NM, "GEN", READ);														//지급품명
	initEmEdit(EM_RECALL_CPN_EVENT_TYPE, "GEN", READ);										//리콜사은행사구분
	initEmEdit(EM_LIMIT_QTY, "NUMBER^3^6", READ);											//한정수량
	initEmEdit(EM_CNT, "NUMBER^3^2", READ);													//지급수량
	
	
	
	
	
	//콤보 초기화                                                               			
	initComboStyle(LC_STR,DS_O_STR,	"CODE^0^30,NAME^0^80", 1, PK);							//점
	initComboStyle(LC_EVENT,DS_O_EVENT_COMBO, "CODE^0^30,NAME^0^120", 1, PK);				//행사코드
	initComboStyle(LC_EXCP_PRSNT_RSN,DS_O_EXCP_PRSNT_RSN, "CODE^0^30,NAME^0^80", 1,	PK);	//예외지급사유코드
	
	getEtcCode("DS_O_EXCP_PRSNT_RSN",	"D", "M073", "N");
	getStore("DS_O_STR", "Y", "1", "N"); 
	LC_STR.Index = 0;
	EM_PRSNT_CHAR_NM.Text =	strUserNM;
	chkExcp(true);
	strToday = getTodayDB("DS_O_RESULT");
	// 테스트 구간
	//strToday = "20120801";
	// 테스트 구간
	
	
 
	EM_PRSNT_DT.Text = strToday;
   
	setTimeout("EM_SS_NO.Focus()",50);
}


function gridCreate1(){
	var	hdrProperies ='<FC>id={currow}			 name="NO"			width=30	align=center</FC>'
					+ '<FC>id=CUST_ID			 name="회원ID"		width=100	align=center</FC>'
					+ '<FC>id=CUST_NAME			 name="회원명"		width=80	align=center</FC>'
					+ '<FC>id=PRSNT_DT			 name="지급일"		width=100	align=center Mask="XXXX/XX/XX"</FC>'
					+ '<FC>id=PRSNT_NO			 name="지급번호"		width=60	align=center</FC>';

	initGridStyle(GD_SALE_INFO,	"common", hdrProperies,	false);
}

function gridCreate2(){
	var	hdrProperies2 ='<FC>id={currow}		name="NO"			width=30	align=center</FC>'
					+ '<FC>id=CHK			name=""				width=30	align=center	EditStyle=CheckBox	HeadCheckShow="false"</FC>'
					+ '<FC>id=TRG_NAME		name="대상범위"		width=60	align=left		edit=none</FC>'
					+ '<FC>id=SKU_NAME		name="지급품명"		width=90	align=left		edit=none</FC>'
					+ '<FC>id=BUY_COST_PRC	name="매입원가"		width=90	align=rigth		edit=none	show=false</FC>'
					+ '<FC>id=GIFTCERT_AMT	name="상품권금액"		width=80	align=rigth		edit=none</FC>';
	initGridStyle(GD_SKU_LIST, "common", hdrProperies2,	true);
}

function gridCreate3(){
	var	hdrProperies3 ='<FC>id={currow}		name="NO"			width=30	align=center</FC>'
					+ '<FC>id=GIFTCARD_NO	name="상품권번호"		width=160	align=center	EditLimit="16" edit="Numeric"</FC>'
					+ '<FC>id=GIFTCERT_AMT	name="상품권금액"		width=100	align=left		ReadOnly =true sumtext=@sum</FC>';
	initGridStyle(GD_GIFTCARD_NO, "common",	hdrProperies3, true);
	GD_GIFTCARD_NO.ViewSummary = "1";
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
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: 조회시 호출
 * return값	: void
 */
function btn_Search() {
}

/**
 * btn_New()
 * 작 성 자	: 김성미
 * 작 성 일	: 2011-03-08
 * 개	 요	:영수증정보, 지급품정보	예외지급정보 초기화
 * return값	: void
 */
function btn_New(flag) {

	// 지급품 정보 수정	내용 체크
	if(DS_IO_SALE_INFO.IsUpdated &&
			showMessage(QUESTION , YESNO, "GAUCE-1000",	"영수증	정보가 변경되었습니다. 신규등록을 하시겠습니까") !=	1){
		return;
	}
	EM_SS_NO.Text = "";
	EM_CARD_CUST_ID.Text = "";
	EM_CONF_ID.Text	= "";
	EM_CONF_NM.Text	= "";
	EM_SKU_CD.Text = "";
	EM_SKU_NM.Text = "";
	IMG_SKU_CD.Text	= "";
	IMG_CONF_ID.Text = "";
	LC_EXCP_PRSNT_RSN.BindColVal = "";
	CHK_EXCP.checked = false;
	
	DS_IO_SALE_INFO_TEMP2.ClearData();
	if(flag	== "S"){
		var	strData	= DS_IO_SALE_INFO.ExportData(1,DS_IO_SALE_INFO.CountRow, true);
		DS_IO_SALE_INFO_TEMP2.ImportData(strData);
		// 지급된 영수증만 삭제	
		for(var	i=1;i<=DS_IO_SALE_INFO_TEMP2.CountRow;i++){
			if(DS_IO_SALE_INFO_TEMP2.NameValue(i,"CHK")	== "T" || DS_IO_SALE_INFO_TEMP2.NameValue(i,"PROVIDE_GB") != "0" ){
				DS_IO_SALE_INFO_TEMP2.DeleteRow(i);
				i -= 1;
			}
		}
		
		DS_IO_SALE_INFO.ClearData();
		if(DS_IO_SALE_INFO_TEMP2.CountRow >	0){
			var	strData1 = DS_IO_SALE_INFO_TEMP2.ExportData(1,DS_IO_SALE_INFO_TEMP2.CountRow, true);
			DS_IO_SALE_INFO.ImportData(strData1);
		}
	}else{
		DS_IO_SALE_INFO.ClearData();
	}
	DS_IO_SKU_LIST.ClearData();
	DS_IO_GIFTCARD_NO.ClearData();
	chkExcp(true);
	GD_SALE_INFO.ColumnProp('CHK','HeadCheck')=	false;
		setTimeout("EM_SS_NO.Focus()",50);
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
 * 작 성 일	: 2011-03-09
 * 개	 요	: 사은품 지급 등록
 * return값	: void
 */


function btn_Save() {
	// 저장할 데이터 없는 경우
	if (DS_IO_SALE_INFO.CountRow == 0){
		//저장할 내용이 없습니다
		showMessage(EXCLAMATION , OK, "USER-1028");
		return;
	}

	if(!DS_IO_SKU_LIST.IsUpdated && !CHK_EXCP.checked){  // 지급품 정보 선택여부
		showMessage(EXCLAMATION , OK, "USER-1000", "지급품을 선택해주세요.");
		return;
	}
	if(CHK_EXCP.checked){  // 예외지급인경우 예외지급 정보 입력 여부
		if(LC_EXCP_PRSNT_RSN.BindColVal == ""){
			showMessage(EXCLAMATION , OK, "USER-1002", "예외지급사유");
			LC_EXCP_PRSNT_RSN.Focus();
			return;
		}
		if(EM_CONF_ID.Text == ""){
			showMessage(EXCLAMATION , OK, "USER-1002", "승인자");
			EM_CONF_ID.Focus();
			return;
		}
		if(EM_SKU_CD.Text == ""){
			showMessage(EXCLAMATION , OK, "USER-1002", "지급품");
			EM_SKU_CD.Focus();
			return;
		}
	}
	if(DS_O_EVENT_INFO.NameValue(1,"EVENT_TYPE") == "03"){ // 카드 행사 일경우 고객카드 번호 정보 정합성 체크
		if(strCardCustId == "" ){
			showMessage(EXCLAMATION , OK, "USER-1000", "고객카드 정보가 확인되지 않았습니다.");
			EM_CARD_CUST_ID.Text = "";
			EM_CARD_CUST_ID.Focus();
			return;
		}
		if(EM_CARD_CUST_ID.Text == ""){
			showMessage(EXCLAMATION , OK, "USER-1000", "고객카드 정보가 확인되지 않았습니다.");
			EM_CARD_CUST_ID.Text = "";
			EM_CARD_CUST_ID.Focus();
			return;
		}
	}
	
	if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;


	if(DS_IO_SKU_LIST.NameValue(DS_IO_SKU_LIST.RowPosition,"GIFTCERT_AMT") != DS_IO_GIFTCARD_NO.NameSum("GIFTCERT_AMT",0,0)){
		showMessage(STOPSIGN, OK, "USER-1000", "상품권 금액은 " + DS_IO_SKU_LIST.NameValue(DS_IO_SKU_LIST.RowPosition,"GIFTCERT_AMT") + "원이랑 같아야 합니다");
		setFocusGrid(GD_GIFTCARD_NO, DS_IO_GIFTCARD_NO, DS_IO_GIFTCARD_NO.CountRow , "GIFTCARD_NO");
		return;
	}

	var strParams = "&strPrsntFlag="		+ encodeURIComponent(CHK_EXCP.checked)
				  + "&strSkuCd="			+ encodeURIComponent(EM_SKU_CD.Text)
				  + "&strTrgCd="			+ encodeURIComponent(HD_TRG_CD.Value)
				  + "&strBuyCostPrc="		+ encodeURIComponent(HD_BUY_COST_PRC.Value)
				  + "&strExcpConfId="		+ encodeURIComponent(EM_CONF_ID.Text)
				  + "&strExcpPrsntRsn="		+ encodeURIComponent(LC_EXCP_PRSNT_RSN.BindColVal)
				  + "&strCardCustId="		+ encodeURIComponent(DS_IO_SALE_INFO.NameString(1,"CUST_ID"))
				  + "&strPrsntDt="			+ encodeURIComponent(EM_PRSNT_DT.Text)
				  + "&strEventType="		+ encodeURIComponent(DS_O_EVENT_INFO.NameValue(1,"EVENT_TYPE"));
	TR_MAIN.Action="/mss/mcae417.mc?goTo=save"+strParams; 
	TR_MAIN.KeyValue="SERVLET(I:DS_O_EVENT_INFO=DS_O_EVENT_INFO,I:DS_IO_SALE_INFO=DS_IO_SALE_INFO,I:DS_IO_SKU_LIST=DS_IO_SKU_LIST,I:DS_IO_GIFTCARD_NO=DS_IO_GIFTCARD_NO)";
	TR_MAIN.Post();
	
	doInit();
	
	if(TR_MAIN.ErrorCode == 0 ) btn_New("S");
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
 * getEventCombo()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-07
 * 개	  요 : 화면	로딩시 사은행사	정보 조회 
 * return값 : void
 */

function getEventCombo(){
	DS_O_EVENT_INFO.ClearData();
	DS_IO_SALE_INFO.ClearData();
	DS_IO_SKU_LIST.ClearData();
	DS_O_CARD_COMP.ClearData();
	DS_IO_GIFTCARD_NO.ClearData();
	
	// 조회조건 셋팅
	var strStrCd	= LC_STR.BindColVal;
	var strPrsntDt	= EM_PRSNT_DT.Text;
	var parameters	= "&strStrCd="  + encodeURIComponent(strStrCd)
					+ "&strPrsntDt="+ encodeURIComponent(strPrsntDt);
	TR_MAIN.Action="/mss/mcae417.mc?goTo=getEventCombo"+parameters;	
	TR_MAIN.KeyValue="SERVLET(O:DS_O_EVENT_COMBO=DS_O_EVENT_COMBO)";	//조회는 O
	TR_MAIN.Post();
	
	if(DS_O_EVENT_COMBO.CountRow == 0){
	showMessage(EXCLAMATION , OK, "USER-1000", "조건에 맞는 사은행사	내용이 없습니다.(getEventCombo)");
	EM_SS_NO.Text			= "";
	EM_CARD_CUST_ID.Text	= "";
	EM_SS_NO.Enable			= false;
	EM_CARD_CUST_ID.Enable	= false;
	
	}else{
	LC_EVENT.Index = 0;
	}
}

/**
 *	getEventInfo()
 *	작 성 자 : 
 *	작 성 일 : 2011-03-07
 *	개	  요 : 화면	로딩시 사은행사	정보 조회 
 *	return값 : void
 */

function getEventInfo() {
	DS_O_EVENT_INFO.ClearData();
	DS_IO_SALE_INFO.ClearData();
	DS_IO_SKU_LIST.ClearData();
	DS_O_CARD_COMP.ClearData();
	DS_IO_GIFTCARD_NO.ClearData();
	
	// 조회조건 셋팅
	var strStrCd	= LC_STR.BindColVal;
	var strPrsntDt	= EM_PRSNT_DT.Text;
	var strEventCd	= LC_EVENT.BindColVal;
	var parameters	= "&strStrCd="  + encodeURIComponent(strStrCd)
					+ "&strPrsntDt="+ encodeURIComponent(strPrsntDt)
					+ "&strEventCd="+ encodeURIComponent(strEventCd);
	TR_MAIN.Action="/mss/mcae417.mc?goTo=getEventInfo"+parameters;  
	TR_MAIN.KeyValue="SERVLET(O:DS_O_EVENT_INFO=DS_O_EVENT_INFO)"; //조회는 O
	TR_MAIN.Post();
	
	if(DS_O_EVENT_INFO.CountRow == 0){
		showMessage(EXCLAMATION , OK, "USER-1000", "조건에 맞는 사은행사	내용이 없습니다.(getEventInfo)");
		EM_SS_NO.Text			= "";
		EM_CARD_CUST_ID.Text	= "";
		EM_SS_NO.Enable			= false;
		EM_CARD_CUST_ID.Enable	= false;
	}else{
		EM_SS_NO.Enable			= true;
		EM_CARD_CUST_ID.Enable	= true;
		DS_O_EVENT_INFO.UserStatus(1) = 1;
		
/* 		if(DS_O_EVENT_INFO.NameValue(1,"EVENT_TYPE") == "03"){
			EM_CARD_CUST_ID.Enable = true;
		} */
	}

}



/**
 *	getCardInfo()
 *	작 성 자 : 
 *	작 성 일 : 2011-03-07
 *	개	  요 : 카드번호	입력시 고객 정보 조회
 *	return값 : void
 */
function getCardInfo()	{
	DS_IO_SALE_INFO.ClearData();
	DS_IO_SKU_LIST.ClearData();
		
	if(DS_O_EVENT_INFO.CountRow == 0){
		showMessage(EXCLAMATION , OK, "USER-1000", "행사 정보를 확인하세요.");
		return;
	}
		
	if(DS_O_EVENT_INFO.NameString(1, "TODAY_YN") == "Y"){
		if(EM_PRSNT_DT.Text != strToday){
			showMessage(EXCLAMATION , OK, "USER-1000", "당일 영수증만 가능합니다.");
			return;
		}
	}
	
	if(DS_O_EVENT_INFO.NameString(1, "TODAY_YN") == "N"){
		if(DS_O_EVENT_INFO.NameString(1, "EVENT_S_DT") > strToday ||
				DS_O_EVENT_INFO.NameString(1, "EVENT_E_DT") < strToday){
			showMessage(EXCLAMATION , OK, "USER-1000", "기간 중 영수증만 가능합니다.");
			return;
		}
	}
	
	// 조회조건 셋팅
	var strStrCd		= DS_O_EVENT_INFO.NameValue(1,"STR_CD");
	var strCardCustId	= EM_CARD_CUST_ID.Text;
	var parameters		= "&strStrCd="     + encodeURIComponent(strStrCd)
						+ "&strCardCustId="+ encodeURIComponent(strCardCustId);
	
	TR_CARDINFO.Action="/mss/mcae417.mc?goTo=getCardInfo"+parameters;
	TR_CARDINFO.KeyValue="SERVLET(O:DS_O_CARD_INFO=DS_O_CARD_INFO)";	//조회는 O
	TR_CARDINFO.Post();
	
	if(DS_O_CARD_INFO.CountRow == 0){
		showMessage(EXCLAMATION , OK, "USER-1000", "고객카드 정보가 확인되지 않았습니다.");	
		EM_CARD_CUST_ID.Text = "";
		EM_CARD_CUST_ID.focus();
		return;
	}
	if(DS_O_CARD_INFO.NameValue(1,"SCED_YN") == "Y"){ // 탈퇴여부
		showMessage(EXCLAMATION , OK, "USER-1000", "탈퇴한 고객카드입니다.");	 
		EM_CARD_CUST_ID.Text = "";
		EM_CARD_CUST_ID.focus();
		return;
	}else	if(DS_O_CARD_INFO.NameValue(1,"RETURN")	!= "0"){ //	정보조회 결과
		showMessage(EXCLAMATION , OK, "USER-1000", DS_O_CARD_INFO.NameValue(1,"MESSAGE"));  
		EM_CARD_CUST_ID.Text = "";
		setTimeout("EM_CARD_CUST_ID.Focus()",50);
		return;
	}
	getSaleInfo2();
}



function getSaleInfo(){
	DS_IO_SALE_INFO.ClearData();
	DS_IO_SKU_LIST.ClearData();
	if(DS_O_EVENT_INFO.CountRow == 0){
		showMessage(EXCLAMATION ,	OK,	"USER-1000", "행사 정보를 확인하세요.");
		return;
	}
	

	
	// 조회조건 셋팅
	var strEventCd	= EM_EVENT_CD.Text;
	var strStrCd	= DS_O_EVENT_INFO.NameValue(1,"STR_CD");
	var strSsNo		= EM_SS_NO.Text;
	
	
	var parameters =	"&strStrCd="  + encodeURIComponent(strStrCd)
					  +	"&strEventCd="+ encodeURIComponent(strEventCd)
					  +	"&strSsNo="   + encodeURIComponent(strSsNo);
	
	TR_MAIN.Action="/mss/mcae417.mc?goTo=getSaleInfo"+parameters; 
	TR_MAIN.KeyValue="SERVLET(O:DS_IO_SALE_INFO_TMP=DS_IO_SALE_INFO_TMP)"; //조회는 O
	TR_MAIN.Post();

 	if(DS_IO_SALE_INFO_TMP.CountRow == 0 ){
		showMessage(EXCLAMATION , OK, "USER-1000", "없는 생년월일 입니다.");
		EM_SS_NO.Text = "";
		setTimeout("EM_SS_NO.Focus()",50);
		return;
	}else{
		var strData = DS_IO_SALE_INFO_TMP.ExportData(1,DS_IO_SALE_INFO_TMP.CountRow, true);
		DS_IO_SALE_INFO.ImportData(strData);
		EM_SS_NO.Text = "";
		getSkuList();
	}
	
}




/**
 *	getSaleInfo2()
 *	작 성 자 : 
 *	작 성 일 : 2011-03-07
 *	개	  요 : 카드 번호 스캔시 영수증 정보 조회
 *	return값 : void
 */

function getSaleInfo2(){

	if(DS_O_EVENT_INFO.CountRow == 0){
		showMessage(EXCLAMATION ,	OK,	"USER-1000", "행사 정보를 확인하세요.(카드)");
		return;
	}
	
	// 조회조건 셋팅
	var strEventCd	= EM_EVENT_CD.Text;
	var strStrCd	= DS_O_EVENT_INFO.NameValue(1,"STR_CD"); 
	
	
	var parameters =	"&strStrCd="  + encodeURIComponent(strStrCd)
					  +	"&strEventCd="+ encodeURIComponent(strEventCd)
					  +	"&strCustId=" + encodeURIComponent(DS_O_CARD_INFO.NameValue(1,"CUST_ID"));

	TR_MAIN.Action="/mss/mcae417.mc?goTo=getSaleInfo2"+parameters; 
	TR_MAIN.KeyValue="SERVLET(O:DS_IO_SALE_INFO_TMP=DS_IO_SALE_INFO_TMP)"; //조회는 O
	TR_MAIN.Post();

	if(DS_IO_SALE_INFO_TMP.CountRow == 0 ){
		showMessage(EXCLAMATION , OK, "USER-1000", "사은품 지급 정보가 없습니다.");
		EM_CARD_CUST_ID.Text = "";
		setTimeout("EM_CARD_CUST_ID.Focus()",50);
		return;
	}else{
		var strData = DS_IO_SALE_INFO_TMP.ExportData(1,DS_IO_SALE_INFO_TMP.CountRow, true);
		DS_IO_SALE_INFO.ImportData(strData);
		EM_CARD_CUST_ID.Text = "";
		getSkuList();
	}
}

/**
 *	getSkuList()
 *	작 성 자 : 
 *	작 성 일 : 2011-03-07
 *	개	  요 : 사은품 조회
 *	return값 : void
 */

	function getSkuList() {

		//(DS_O_EVENT_INFO.NameString(1, "RECP_YN") == "Y")		//EM_EVENT_GIFT_CYC
		// D : 1일 1회
		// P : 기간중 1회
		// N : 계속 지급
		
		if(DS_O_EVENT_INFO.NameString(1, "CYC_DPN") == "D"){
			for(var i=1;i<=DS_IO_SALE_INFO.CountRow;i++){
				if(EM_PRSNT_DT.Text == strToday
				&& DS_IO_SALE_INFO.NameValue(i, "PRSNT_DT") != ""
				&& DS_IO_SALE_INFO.NameValue(i, "PRSNT_NO") != ""){
					
					showMessage(EXCLAMATION , OK, "USER-1000", "사은품 지급은 1일 1회만 가능합니다.");
					return;
				}
			}
		}
		
		if(DS_O_EVENT_INFO.NameString(1, "CYC_DPN") == "P"){
			for(var	i=1;i<=DS_IO_SALE_INFO.CountRow;i++){
				if(DS_O_EVENT_INFO.NameString(1, "EVENT_S_DT") < strToday
				&& DS_O_EVENT_INFO.NameString(1, "EVENT_E_DT") > strToday
				&& DS_IO_SALE_INFO.NameValue(i, "PRSNT_DT") != "" 
				&& DS_IO_SALE_INFO.NameValue(i, "PRSNT_NO") != ""){
					
					showMessage(EXCLAMATION , OK, "USER-1000", "사은품 지급은 기간중 1회만 가능합니다.");
					return;
				}
			}
		}
		
		DS_IO_SKU_LIST.ClearData();
		DS_IO_GIFTCARD_NO.ClearData();

		// 조회조건 셋팅
		var strStrCd		= LC_STR.BindColVal;
		var strEventCd		= EM_EVENT_CD.Text;
		
		
		var parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
					   + "&strEventCd="+ encodeURIComponent(strEventCd);
		TR_MAIN.Action="/mss/mcae417.mc?goTo=getSkuList"+parameters;	 
		TR_MAIN.KeyValue="SERVLET(O:DS_IO_SKU_LIST=DS_IO_SKU_LIST)";	//조회는 O
		TR_MAIN.Post();
	}

/**
 *	getSkuInfo()
 *	작 성 자 : 
 *	작 성 일 : 2011-03-07
 *	개	  요 : 사은품 정보(원가, 대상코드) 조회
 *	return값 : void
 */

function getSkuInfo() {
	DS_O_SKU_INFO.ClearData();
	
	// 조회조건 셋팅
	var strStrCd	= LC_STR.BindColVal;
	var strEventCd	= EM_EVENT_CD.Text;
	var strSkuCd	= EM_SKU_CD.Text;
	
	var parameters	= "&strStrCd="  + encodeURIComponent(strStrCd)
					+ "&strEventCd="+ encodeURIComponent(strEventCd)
					+ "&strSkuCd="  + encodeURIComponent(strSkuCd);
	
	TR_MAIN.Action="/mss/mcae417.mc?goTo=getSkuInfo"+parameters;	 
	TR_MAIN.KeyValue="SERVLET(O:DS_O_SKU_INFO=DS_O_SKU_INFO)"; //조회는 O
	TR_MAIN.Post();
	EM_SKU_CD.Text = "";
	EM_SKU_NM.Text = "";
	HD_BUY_COST_PRC.Value = "";
	HD_TRG_CD.Value = "";
}

/**
 *	chkExcp()
 *	작 성 자 : 
 *	작 성 일 : 2011-03-07
 *	개	  요 : 예외	지금 사유 체크시 하단 내용 활성화
 *	return값 : void
 */

function chkExcp(flag){
	var strFlag = CHK_EXCP.checked;
	if(!flag){
		// 영수증 정보 내용 체크
		if(strFlag && DS_IO_SALE_INFO.CountRow == 0){
			showMessage(EXCLAMATION , OK, "USER-1000", "영수증 정보가 없습니다. 영수증을 등록하세요.");
			EM_CARD_CUST_ID.Focus();
			CHK_EXCP.checked = false;
			return;
		}
		
		// 지급품 정보 수정 내용 체크
		if(strFlag &&
				DS_IO_SKU_LIST.IsUpdated &&
				showMessage(EXCLAMATION , YESNO, "GAUCE-1000", "변경된 지급품 내용이 있습니다. 예외지급내용을 등록하시겠습니까?") != 1){
			CHK_EXCP.checked = false;
			return;
			
		}else{
			DS_IO_SKU_LIST.ClearData();
			DS_IO_GIFTCARD_NO.ClearData();
		}
	}
	LC_EXCP_PRSNT_RSN.Enable = strFlag;
	EM_CONF_ID.Enable	= strFlag;
	EM_SKU_CD.Enable = strFlag;
	enableControl(IMG_SKU_CD,	strFlag);
	enableControl(IMG_CONF_ID, strFlag);
	
	if(strFlag){
		LC_EXCP_PRSNT_RSN.Index =	0;
		enableControl(IMG_ITEM, false);
	}else{
		enableControl(IMG_ITEM, true);
		LC_EXCP_PRSNT_RSN.BindColVal = "";
		EM_CONF_ID.Text =	"";
		EM_CONF_NM.Text =	"";
		EM_SKU_CD.Text = "";
		EM_SKU_NM.Text = ""; 
		HD_BUY_COST_PRC.Value	= "";
		HD_TRG_CD.Value =	"";
	}
}

/**
 * getSkuItem()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-08
 * 개    요 : 지급품 조회
 * return값 : void
 */
function getSkuItem() {
	var rtnMap	= getSkuPop("SEL_SKU_POP3",	DS_O_EVENT_INFO.NameValue(1, "STR_CD"),	"",	DS_O_EVENT_INFO.NameValue(1, "EVENT_CD"));
	if(rtnMap != null){
		EM_SKU_CD.Text	= rtnMap.get("SKU_CD");
		EM_SKU_NM.Text	 = rtnMap.get("SKU_NAME");
		HD_BUY_COST_PRC.Value = rtnMap.get("BUY_COST_PRC");
		HD_TRG_CD.Value = rtnMap.get("TRG_CD");
	}
}

 
/**
 *	chkGiftCardNo()
 *	작 성 자 : 홍종영
 *	작 성 일 : 2012-05-30
 *	개	  요 : 상품권 번호 조회
 *	return값 : void
 */ 
function chkGiftCardNo(strRow){

	var strGiftCardNo = DS_IO_GIFTCARD_NO.NameValue(DS_IO_GIFTCARD_NO.RowPosition, "GIFTCARD_NO");

	var goTo		= "chkGiftCardNo";
	var	action		= "O";
	var parameters	= "&strGiftCardNo="+ encodeURIComponent(strGiftCardNo);
	
	TR_MAIN3.Action="/mss/mcae417.mc?goTo="+goTo+parameters;  
	TR_MAIN3.KeyValue="SERVLET("+action+":DS_O_CHECK=DS_O_CHECK)"; 
	TR_MAIN3.Post();
	
	if(DS_O_CHECK.CountRow == 0){
		showMessage(INFORMATION, OK, "USER-1000", "상품권번호가 유효하지 않습니다.");
		return false;
	}else{
		//setFocusGrid(GD_GIFTCARD_NO, DS_IO_GIFTCARD_NO, strRow , "GIFTCERT_AMT");
		DS_IO_GIFTCARD_NO.NameValue(strRow, "GIFTCERT_AMT") = DS_O_CHECK.NameValue(1, DS_O_CHECK.ColumnID(2));
		//return true;
	}
}

/**
 *	getGiftCardNo()
 *	작 성 자 : 홍종영
 *	작 성 일 : 2012-05-29
 *	개	  요 : 상품권 조회
 *	return값 : void
 */ 
function getGiftCardNo() {

	var goTo		= "getGiftCardNo";
	var action		= "O";
	//var parameters = "&strGiftCardNo="+ encodeURIComponent(strGiftCardNo);
	
	TR_MAIN2.Action="/mss/mcae417.mc?goTo="+goTo;
	TR_MAIN2.KeyValue="SERVLET("+action+":DS_IO_GIFTCARD_NO=DS_IO_GIFTCARD_NO)";
	TR_MAIN2.Post();
	
	setPorcCount("SELECT", GD_GIFTCARD_NO);
}

/**
 * btn_AddRow()
 * 작 성 자	: HJY
 * 작 성 일	: 2012.05.29
 * 개	 요	: 행 추가
 * return값	:
 */

function btn_AddRow() {
	if (DS_IO_SKU_LIST.NameValue(DS_IO_SKU_LIST.RowPosition,"CHK") == "T" && 
			DS_IO_SKU_LIST.NameValue(DS_IO_SKU_LIST.RowPosition,"SKU_GB") == "2") {
		if(DS_IO_SKU_LIST.NameValue(DS_IO_SKU_LIST.RowPosition,"GIFTCERT_AMT") > DS_IO_GIFTCARD_NO.NameSum("GIFTCERT_AMT",0,0)){
			if(DS_IO_GIFTCARD_NO.NameValue(DS_IO_GIFTCARD_NO.CountRow,"GIFTCARD_NO") == ""){
				showMessage(STOPSIGN, OK, "USER-1000", "상품권 번호를 입력하셔야 됩니다");
				setFocusGrid(GD_GIFTCARD_NO, DS_IO_GIFTCARD_NO, DS_IO_GIFTCARD_NO.CountRow , "GIFTCARD_NO");
			}else{
				if(DS_IO_GIFTCARD_NO.NameValue(DS_IO_GIFTCARD_NO.CountRow,"GIFTCERT_AMT") == ""){
					showMessage(STOPSIGN, OK, "USER-1000", "상품권 금액을 확인하셔야 됩니다");
				}else{
					DS_IO_GIFTCARD_NO.AddRow();
					setFocusGrid(GD_GIFTCARD_NO, DS_IO_GIFTCARD_NO, DS_IO_GIFTCARD_NO.CountRow , "GIFTCARD_NO");
					return false;	
				}
			}
		}else{
			showMessage(STOPSIGN, OK, "USER-1000", "상품권 금액은 " + DS_IO_SKU_LIST.NameValue(DS_IO_SKU_LIST.RowPosition,"GIFTCERT_AMT") + "원이랑 같아야 합니다");
		}
	}else{
		showMessage(EXCLAMATION	, OK, "USER-1000", "지급품 물품을 확인하여주세요.");
		return false;
	}
}

/**
 * btn_DeleteRow()
 * 작 성 자	: HJY
 * 작 성 일	: 2012.05.29
 * 개	 요	: 행 삭제
 * return값	:
 */
function btn_DeleteRow() {
	var strDsMst_RowCnt	= DS_IO_SKU_LIST.CountRow;
	if (strDsMst_RowCnt	> 0) {
		DS_IO_GIFTCARD_NO.DeleteRow(DS_IO_GIFTCARD_NO.RowPosition);
	}
}

-->
</script>
</head>



<!--*************************************************************************-->
<!--* B. 스크립트 끝													 		*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스	이벤트 처리													*-->
<!--*	 1.	TR Success 메세지 처리
<!--*	 2.	TR Fail	메세지 처리
<!--*	 3.	DataSet	Success	메세지 처리
<!--*	 4.	DataSet	Fail 메세지	처리
<!--*	 5.	DataSet	이벤트 처리
<!--*************************************************************************-->
<!---------------------	1. TR Success 메세지 처리  ------------------------------->
<script	language=JavaScript	for=TR_MAIN	event=onSuccess>
	for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
	}
</script>
<script	language=JavaScript	for=TR_MAIN2 event=onSuccess>
	for(i=0;i<TR_MAIN2.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN2.SrvErrMsg('UserMsg',i));
	}
</script>
<script	language=JavaScript	for=TR_MAIN3 event=onSuccess>
	for(i=0;i<TR_MAIN3.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN3.SrvErrMsg('UserMsg',i));
	}
</script>
<script	language=JavaScript	for=TR_CARDINFO	event=onSuccess>
	for(i=0;i<TR_CARDINFO.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_CARDINFO.SrvErrMsg('UserMsg',i));
	}
</script>
<!---------------------	2. TR Fail 메세지 처리	----------------------------------->
<script	language=JavaScript	for=TR_MAIN	event=onFail>
	trFailed(TR_MAIN.ErrorMsg);
</script>
<script	language=JavaScript	for=TR_MAIN2 event=onFail>
	trFailed(TR_MAIN2.ErrorMsg);
</script>
<script	language=JavaScript	for=TR_MAIN3 event=onFail>
	trFailed(TR_MAIN3.ErrorMsg);
</script>
<script	language=JavaScript	for=TR_CARDINFO	event=onFail>
	trFailed(TR_CARDINFO.ErrorMsg);
</script>
<!---------------------	3. DataSet Success 메세지 처리	--------------------------->
<!---------------------	4. DataSet Fail	메세지 처리	 -------------------------->
<!---------------------	5. DataSet 이벤트 처리	------------------------------->
 <script language=JavaScript for=DS_IO_SALE_INFO event=OnRowPosChanged(row)>
 if(clickSORT)
	 return;
</script>
<script	language=JavaScript	for=DS_IO_SKU_LIST event=OnRowPosChanged(row)>
 if(clickSORT)
	 return;
</script>
<script	language=JavaScript	for=DS_IO_GIFTCARD_NO event=OnRowPosChanged(row)>
 if(clickSORT)
	 return;
</script>
<!---------------------	6. 컴포넌트	이벤트 처리	 ------------------------------>
<script	language=JavaScript	for=LC_STR event=OnSelChange()>
	// 점코드 변경시 행사 내용 조회
	getEventCombo();	
</script>

<script	language=JavaScript	for=LC_EVENT event=OnSelChange()>
	// 점코드 변경시 행사 내용 조회
	getEventInfo();	 
	setTimeout("EM_SS_NO.Focus()",50);
</script>

<script language="javascript" for=GD_SKU_LIST event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row, colid);
	if(colid != "CHK") return;
	for(var i=1;i<=DS_IO_SKU_LIST.CountRow;i++){
		if(i != row && DS_IO_SKU_LIST.NameValue(row,"CHK") == "T"){
			DS_IO_SKU_LIST.NameValue(i,"CHK") = "F";
		}
    }
	DS_IO_GIFTCARD_NO.ClearData();
</script>
	
<script	language="javascript" for=GD_SALE_INFO event=OnClick(row,colid)>
	if(row == 0){
		sortColId( eval(this.DataID), row, colid); 
		return;
	}
</script>

<script	language=JavaScript	for=EM_SS_NO event=OnKillFocus()>
	if(this.Text ==	undefined) return;
	if(this.Text.length == 6){
		getSaleInfo();
	}else if(this.Text.length >	0){
		DS_IO_SALE_INFO.ClearData();
		DS_IO_SKU_LIST.ClearData();
		
		showMessage(INFORMATION, OK, "USER-1000", "생년월일은 6자리를 입력하여 주세요");
		EM_SS_NO.Text = "";
		setTimeout("EM_SS_NO.Focus()",50);
		return;
	}

</script>


<script	language=JavaScript	for=EM_CARD_CUST_ID	event=OnKillFocus()>
if(this.Text ==	undefined) return;
	if(this.Text.length	== 13 || this.Text.length == 16 || this.Text.length == 18){
		getCardInfo();
	}else if(this.Text.length >	0){
		DS_IO_SALE_INFO.ClearData();
		DS_IO_SKU_LIST.ClearData();
		
		showMessage(INFORMATION, OK, "USER-1000", "카드번호는 13,16,18자리를 입력하여 주세요");
		EM_CARD_CUST_ID.Text = "";
		setTimeout("EM_CARD_CUST_ID.Focus()",50);
		return;
	}

</script>

<script language=JavaScript for=GD_GIFTCARD_NO event=CanColumnPosChange(row,colid)>
	
	switch(colid){
		case 'GIFTCARD_NO': // 상품권 번호 조회	
			if(DS_IO_GIFTCARD_NO.NameValue(row,"GIFTCARD_NO").length != 16){
				showMessage(INFORMATION, OK, "USER-1000", "상품권 자리수는 16자리입니다");
		    	return false;
			}else{
				chkGiftCardNo(row);
				//setFocusGrid(GD_GIFTCARD_NO, DS_IO_GIFTCARD_NO, DS_IO_GIFTCARD_NO.CountRow , "GIFTCERT_NO");
	    		var iItemCd = DS_IO_GIFTCARD_NO.NameValue(row,"GIFTCARD_NO");
	    	    for(var k=i+1; k<=DS_IO_GIFTCARD_NO.CountRow; k++) {
	    	    	if (row != k) {
	    	    		var kItemCd = DS_IO_GIFTCARD_NO.NameValue(k,"GIFTCARD_NO");
	    		        if (iItemCd==kItemCd) {
	    		            showMessage(STOPSIGN, OK, "USER-1000", k +"번째행의  상품권번호와 중복됩니다.");
	    		            return false;
	    		        }
	    	    	}
	    	    }
			}	
			break;
	}
	return true;
</script>

<!-- 승인자  조회 -->
<script	language=JavaScript	for=EM_CONF_ID event=onKillFocus()>
	//변경된 내역이	없으면 무시
	if(!this.Modified)
		return;
	//코드가 존재 하지 않으면 명을 클리어 후 리턴
	if(	EM_CONF_ID.Text	==""){
		EM_CONF_NM.Text	= "";
		   return;
	   }
	if(EM_CONF_ID.text!=null){
		if(EM_CONF_ID.text.length >	0){
			getUserNonPop('DS_O_S_CONF',EM_CONF_ID,EM_CONF_NM,'E','Y');
		}
	}
</script>

<!-- 지급품	조회 -->
<script	language=JavaScript	for=EM_SKU_CD event=onKillFocus()>
//변경된 내역이	없으면 무시
if(!this.Modified)
	return;
//코드가 존재 하지 않으면 명을 클리어 후 리턴
if(	EM_SKU_CD.Text ==""){
	EM_SKU_NM.Text = "";
	HD_BUY_COST_PRC.Value =	"";
	HD_TRG_CD.Value	= ""; 
	   return;
   }
	if(EM_SKU_CD.text!=null){
		if(EM_SKU_CD.text.length > 0){
			getSkuInfo();
			// 조회내용이 없거나 1개 이상이면 팝업 호출
			if(DS_O_SKU_INFO.CountRow == 1){
				// 지급품 조회후 대상코드 매입원가 조회
				EM_SKU_CD.Text = DS_O_SKU_INFO.NameValue(1,	"SKU_CD");
				EM_SKU_NM.Text = DS_O_SKU_INFO.NameValue(1,	"SKU_NAME");
				HD_BUY_COST_PRC.Value =	DS_O_SKU_INFO.NameValue(1, "BUY_COST_PRC");
				HD_TRG_CD.Value	= DS_O_SKU_INFO.NameValue(1, "TRG_CD");
			}else{
				getSkuItem();
			}
			
		}
	}
</script>

<!--*************************************************************************-->
<!--* C. 가우스	이벤트 처리	끝												*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스	DataSet	& Transaction 정의									*-->
<!--*	 1.	DataSet															*-->
<!--*	 2.	Transaction														*-->
<!--*************************************************************************-->

<!---------------------	1. DataSet	------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용	-->	 
<comment id="_NSID_"><object id="DS_O_CARD_INFO"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CARD_COMP"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVENT_COMBO"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_S_CONF"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR"				classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EXCP_PRSNT_RSN"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SKU_INFO"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVENT_INFO"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_SALE_CHK"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_SALE_INFO"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_SALE_INFO_TEMP"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_SALE_INFO_TEMP2"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_SALE_INFO_TMP"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_SKU_LIST"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_GIFTCARD_NO"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CHECK"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_EXCP_SKU"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!---------------------	2. Transaction	--------------------------------------->
<comment id="_NSID_">
	<object	id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
		<param name="KeyName" value="Toinb_dataid4">
	</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
	<object	id="TR_CARDINFO" classid=<%=Util.CLSID_TRANSACTION%>>
		<param name="KeyName" value="Toinb_dataid4">
	</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
	<object	id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>>
		<param name="KeyName" value="Toinb_dataid4">
	</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
	<object	id="TR_MAIN3" classid=<%=Util.CLSID_TRANSACTION%>>
		<param name="KeyName" value="Toinb_dataid4">
	</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스	DataSet	& Transaction 정의 끝																						 *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* E. 본문시작																																								*-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@	include	file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 //	-->

<input type="hidden" id="HD_BUY_COST_PRC">
<input type="hidden" id="HD_TRG_CD">
<div id="testdiv" class="testdiv">
<table width="100%"	border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td	class="PT01	PB03">
		<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="o_table">
			<tr>
				<td>
				<table width="100%"	border="0" cellpadding="0" cellspacing="0" class="s_table">
					<tr>
						<th	width="40"	class="point">점</th>
							<td width="90">
								<comment id="_NSID_">
									<object	id=LC_STR classid=<%=Util.CLSID_LUXECOMBO%> width="90" tabindex=1 align="absmiddle"></object>
								</comment><script>_ws_(_NSID_);</script>
							</td>
						
						<th	width="70" class="point">행사코드</th>
							<td width="100">
								<comment id="_NSID_">
									<object id=LC_EVENT	classid=<%=Util.CLSID_LUXECOMBO%> width="170" tabindex=1 align="absmiddle"></object>
								</comment><script>_ws_(_NSID_);</script>
							</td>
						<th	width="110"	class="point">등록일자</th>
							<td width="90">
								<comment id="_NSID_">
									<object	id=EM_PRSNT_DT classid=<%=Util.CLSID_EMEDIT%> width="90" tabindex=1 align="absmiddle"></object>
								</comment><script>_ws_(_NSID_);</script>
							</td>
						<th	width="100" class="point">등록자</th>
							<td>
								<comment id="_NSID_">
									<object	id=EM_PRSNT_CHAR_NM	classid=<%=Util.CLSID_EMEDIT%> width="90" tabindex=1 align="absmiddle"></object>
								</comment><script>_ws_(_NSID_);</script>
							</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td	class="dot"></td>
	</tr>
	<tr>
		<td	class="PT01	PB03">
		<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="o_table">
			<tr>
				<td>
				<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="s_table">
					<tr>
						<td	class="sub_title">
							<img src="/<%=dir%>/imgs/comm/ring_blue.gif" align="absmiddle" class="PR03" />행사정보
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td	class="PT01	PB03">
				<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="o_table">
					<tr>
						<td>
						<table width="100%"	border="0" cellpadding="0" cellspacing="0" class="s_table">
							<tr>
								<th	width="90">점</th>
									<td	width="90">
										<comment id="_NSID_">
											<object id=EM_STR_NM classid=<%=Util.CLSID_EMEDIT%> width="90" tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								<th	width="95">사은행사유형</th>
									<td width="90">
										<comment id="_NSID_">
											<object id=EM_EVENT_TYPE	classid=<%=Util.CLSID_EMEDIT%> width=90" tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								<th	width="110">행사코드</th>
									<td	width="90">
										<comment id="_NSID_">
											<object id=EM_EVENT_CD	classid=<%=Util.CLSID_EMEDIT%> width="90" tabindex=1	align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								<th	width="110">행사명</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%> width="90"	 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
							</tr>
							<tr>
								<th	width="90">행사기간</th>
									<td	colspan="3"	align="absmiddle">
										<comment id="_NSID_">
											<object	id=EM_EVENT_S_DT classid=<%=Util.CLSID_EMEDIT%>	width="130" tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									~	<comment id="_NSID_">
											<object	id=EM_EVENT_E_DT classid=<%=Util.CLSID_EMEDIT%> width="130" tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								<th	width="100">행사종류</th>
									<td width="90">
										<comment id="_NSID_">
											<object id=EM_EVENT_TYPE_NM	classid=<%=Util.CLSID_EMEDIT%> width="90" tabindex=1	align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								<th	width="110">사은품 지급주기</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_EVENT_GIFT_CYC classid=<%=Util.CLSID_EMEDIT%> width="90"	 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
							</tr> 
							<tr>
								<th	width="90">보너스카드 ONLY</th>
									<td	width="90">
										<comment id="_NSID_">
											<object id=EM_CUST_ONLY_YN classid=<%=Util.CLSID_EMEDIT%> width="90" tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								<th	width="95">신용카드 ONLY</th>
									<td width="90">
										<comment id="_NSID_">
											<object id=EM_CARD_ONLY_YN	classid=<%=Util.CLSID_EMEDIT%> width="90" tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								<th	width="110">영수증  합산여부</th>
									<td	width="90">
										<comment id="_NSID_">
											<object id=EM_RECP_ADD_YN	classid=<%=Util.CLSID_EMEDIT%> width="90" tabindex=1	align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								<th	width="110">영수증  당일여부</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_RECP_TODAY_YN classid=<%=Util.CLSID_EMEDIT%> width="90"	 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
							</tr>
							<tr>
								<th	width="90">쿠폰사은<BR>행사구분</th>
									<td	width="90">
										<comment id="_NSID_">
											<object id=EM_RECALL_CPN_EVENT_TYPE classid=<%=Util.CLSID_EMEDIT%> width="90" tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								<th	width="95">한정수량</th>
									<td width="90">
										<comment id="_NSID_">
											<object id=EM_LIMIT_QTY	classid=<%=Util.CLSID_EMEDIT%> width="90" tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								<th	width="110">지급수량</th>
									<td	width="90" colspan ='3'>
										<comment id="_NSID_">
											<object id=EM_CNT	classid=<%=Util.CLSID_EMEDIT%> width="90" tabindex=1	align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
							</tr>							
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td	class="dot"></td>
	</tr>
	<tr>
		<td	class="PT01	PB03">
		<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="o_table">
			<tr>
				<td	width="740">
				<table width="100%"	border="0" cellpadding="0" cellspacing="0" class="s_table">
					<tr>
						<th	width="100">생년월일</th>
						<td	width="140"><comment id="_NSID_"> <object
							id=EM_SS_NO classid=<%=Util.CLSID_EMEDIT%> width=140
							tabindex=1 align="absmiddle"> </object>	</comment><script>_ws_(_NSID_);</script>
						</td>
						<th	width="100">고객카드번호</th>
						<td	width="140"><comment id="_NSID_"> <object
							id=EM_CARD_CUST_ID classid=<%=Util.CLSID_EMEDIT%> width=140
							tabindex=1 align="absmiddle"> </object>	</comment><script>_ws_(_NSID_);</script>
						</td>
					</tr>
				</table>
				</td>
				<td	align=right>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td><img ID=IMG_ITEM
							src="/<%=dir%>/imgs/btn/supplies_item_serach.gif"
							onclick="javascript:getSkuList();" align="absmiddle" class="PR03" />
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td	class="dot"></td>
	</tr>
	<tr	valign="top">
		<td>
		<table width="100%"	border="0" cellspacing="0" cellpadding="0">
			<tr	valign="top">
				<td	width="60%">
				<table width="100%"	border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td	class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif"	align="absmiddle"
									class="PR03" />사은품 지급 정보</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
							<tr>
								<td><comment id="_NSID_"><OBJECT id=GD_SALE_INFO
									width=100% height=353 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_IO_SALE_INFO">
									<Param Name="ViewSummary" value="1">
								</OBJECT></comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
				<td	width="40%"	class="PL05">
				<table width="100%"	border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td	class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif"	align="absmiddle"
									class="PR03" />지급품정보</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
							<tr>
								<td><comment id="_NSID_"><OBJECT id=GD_SKU_LIST
									width=100% height=110 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_IO_SKU_LIST">
								</OBJECT></comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td	height="6"></td>
					</tr>
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0" >
							<tr>
								<td	class="sub_title">
									<img src="/<%=dir%>/imgs/comm/ring_blue.gif" align="absmiddle" class="PR03" />상품권 번호 등록
								</td>
								<td	align="right">
									<img id="IMG_ADD_ROW" style="vertical-align: middle;" src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18" onclick="btn_AddRow();" hspace="2" />
									<img id="IMG_DEL_ROW" style="vertical-align: middle;" src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18" onclick="btn_DeleteRow();" />
								</td>	
							</tr>
						</table>
						</td>
					</tr>					
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
							<tr>
								<td>
									<comment id="_NSID_">
										<OBJECT id=GD_GIFTCARD_NO width=100% height=110 classid=<%=Util.CLSID_GRID%>>
											<param name="DataID" value="DS_IO_GIFTCARD_NO">
										</OBJECT>
									</comment>
									<script>_ws_(_NSID_);</script>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td	height="5"></td>
					</tr>
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0"
							class="s_table">
							<tr>
								<th	rowspan=2 width="60" class="point">예외지급<br/>사유코드</th>
								<td	colspan=2><input type="checkbox" id=CHK_EXCP
									onclick="javascript:chkExcp();">예외지급</td>
							</tr>
							<tr>
								<td	colspan=2><comment id="_NSID_">	<object
									id=LC_EXCP_PRSNT_RSN classid=<%=Util.CLSID_LUXECOMBO%>
									width=120 tabindex=1 align="absmiddle">	</object> </comment><script>_ws_(_NSID_);</script>
								</td>
								
							</tr>
							<tr>
								<th	width="60" class="point">승인자</th>
								<td	colspan="2"><comment id="_NSID_"> <object
									id=EM_CONF_ID classid=<%=Util.CLSID_EMEDIT%> width=95
									tabindex=1 align="absmiddle"> </object>	</comment><script>_ws_(_NSID_);</script>
								<img id=IMG_CONF_ID	src="/<%=dir%>/imgs/btn/detail_search_s.gif"
									class="PR03"
									onclick="javascript:getUserPop(	EM_CONF_ID,	EM_CONF_NM,	'S'	);"
									align="absmiddle" /> <comment id="_NSID_"> <object
									id=EM_CONF_NM classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object>	</comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th	width="60" class="point">지급품</th>
								<td	colspan="2"><comment id="_NSID_"> <object
									id=EM_SKU_CD classid=<%=Util.CLSID_EMEDIT%>	width=95
									tabindex=1 align="absmiddle"> </object>	</comment><script>_ws_(_NSID_);</script>
								<img id=IMG_SKU_CD src="/<%=dir%>/imgs/btn/detail_search_s.gif"
									class="PR03" onclick="javascript:getSkuItem();;"
									align="absmiddle" /> <comment id="_NSID_"> <object
									id=EM_SKU_NM classid=<%=Util.CLSID_EMEDIT%>	width=100
									tabindex=1 align="absmiddle"> </object>	</comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce	Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object	id=BD_EVENT_INFO classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_O_EVENT_INFO>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
		<c>Col=STR_NM					Ctrl=EM_STR_NM					param=Text</c>
		<c>Col=EVENT_TYPE				Ctrl=EM_EVENT_TYPE				param=Text</c>
		<c>Col=EVENT_CD					Ctrl=EM_EVENT_CD				param=Text</c>
		<c>Col=EVENT_NAME				Ctrl=EM_EVENT_NAME				param=Text</c>
		<c>Col=EVENT_S_DT				Ctrl=EM_EVENT_S_DT				param=Text</c>
		<c>Col=EVENT_E_DT				Ctrl=EM_EVENT_E_DT				param=Text</c>
		<c>Col=EVENT_TYPE_NM			Ctrl=EM_EVENT_TYPE_NM			param=Text</c>
		<c>Col=EVENT_GIFT_CYC			Ctrl=EM_EVENT_GIFT_CYC			param=Text</c>
		<c>Col=CUST_ONLY_YN				Ctrl=EM_CUST_ONLY_YN			param=Text</c>
		<c>Col=CARD_ONLY_YN				Ctrl=EM_CARD_ONLY_YN			param=Text</c>
		<c>Col=RECP_ADD_YN				Ctrl=EM_RECP_ADD_YN				param=Text</c>
		<c>Col=RECP_TODAY_YN			Ctrl=EM_RECP_TODAY_YN			param=Text</c>
		<c>Col=RECP_YN					Ctrl=EM_RECP_ADD_YN				param=Text</c>
		<c>Col=CYC_DPN					Ctrl=EM_EVENT_GIFT_CYC			param=Text</c>
		<c>Col=TODAY_YN					Ctrl=EM_RECP_TODAY_YN			param=Text</c>
		<c>Col=RECALL_CPN_EVENT_TYPE	Ctrl=EM_RECALL_CPN_EVENT_TYPE	param=Text</c>
		<c>Col=LIMIT_QTY				Ctrl=EM_LIMIT_QTY				param=Text</c>
		<c>Col=CNT						Ctrl=EM_CNT						param=Text</c>		
		'>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

