<!--
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 회원관리 > 회원메모관리
 * 작 성 일    : 2010.01.14
 * 작 성 자    : 김영진
 * 수 정 자    :
 * 파 일 명    : dctm1160.jsp
 * 버    전       : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요       :
 * 이    력       :
 *           2010.01.14 (김영진) 신규작성
 *           2010.02.18 (김영진) 기능추가
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
	request.setCharacterEncoding("utf-8");
	String strSsno = "EM_SS_NO_S";
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

%>
<%
	String strSsNo = (request.getParameter("strSsNo") != null && !"".equals(request.getParameter("strSsNo").trim())) ? request.getParameter("strSsNo") : "";
	String strCardNo = (request.getParameter("strCardNo") != null && !"".equals(request.getParameter("strCardNo").trim()))? request.getParameter("strCardNo"): "";
	String strCustId = (request.getParameter("strCustId") != null && !"".equals(request.getParameter("strCustId").trim()))? request.getParameter("strCustId"): "";
	String strCompPersFlag = (request.getParameter("strCompPersFlag") != null && !"".equals(request.getParameter("strCompPersFlag").trim()))? request.getParameter("strCompPersFlag"): "P";
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<%
	String strToDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String strToDate2 = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	strToDate2 = strToDate2 + "01";
%>
<script LANGUAGE="JavaScript">
<!--
var strCompPersFlag = "P";
var strChangFlag    = false;
var bfListRowPosition = 0;                             // 이전 List Row Position
var strCardNo    = "";
var strSsNo      = "";
var strCustId    = "";
var strCustNm    = "";
var strMemoDateF = "";
var strMemoDateT = "";
var strCompFlag  = "";
var intChangRow  = 0;
var g_strPid           = "<%=pageName%>";                 // PID
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-21
 * 개       요     : 해당 페이지 LOAD 시
 * return값 : void
 */

function doInit(){
	

	//Input,Output Data Set Header 초기화
	DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
	
	//Output Data Set Header 초기화
	DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');

	//그리드 초기화
	gridCreate1(); //마스터

	// EMedit에 초기화
	initEmEdit(EM_CARD_NO_S,   "0000-0000-0000-0000", NORMAL);     //카드번호
    initEmEdit(EM_CARD_NO_CUT,    "00000000",            NORMAL);     //단축 카드번호
	initEmEdit(EM_SS_NO_H,     "000000",      NORMAL);     //생년월일_hidden
	initEmEdit(EM_SS_NO_S,     "000000",      NORMAL);     //생년월일
	initEmEdit(EM_CUST_ID_S,   "GEN^9",               NORMAL);     //회원코드
	initEmEdit(EM_CUST_ID_H,   "GEN^9",               NORMAL);     //회원코드_hidden
	initEmEdit(EM_CUST_NAME_S, "GEN^40",              READ);       //회원명

	initEmEdit(EM_MEMO_DATE_F, "YYYYMMDD", PK);           //조회일자 F
	initEmEdit(EM_MEMO_DATE_T, "YYYYMMDD", PK);           //조회일자 T

	initEmEdit(EM_CUST_NAME,   "GEN^40",     READ);       //회원명
	initEmEdit(EM_HOME_PH,     "GEN^40",     READ);       //자택전화
	initEmEdit(EM_HOME_PH1,    "GEN^40",     READ);       //자택전화hidden
	initEmEdit(EM_HOME_PH2,    "GEN^40",     READ);       //자택전화hidden
	initEmEdit(EM_HOME_PH3,    "GEN^40",     READ);       //자택전화hidden
	initEmEdit(EM_MOBILE_PH,   "GEN^40",     READ);       //이동전화
	initEmEdit(EM_MOBILE_PH1,  "GEN^40",     READ);       //이동전화 hidden
	initEmEdit(EM_MOBILE_PH2,  "GEN^40",     READ);       //이동전화 hidden
	initEmEdit(EM_MOBILE_PH3,  "GEN^40",     READ);       //이동전화 hidden
	initEmEdit(EM_SS_NO,       "000000",	 READ);  	  //생년월일
	initEmEdit(EM_HOME_ADDR,   "GEN^400",    READ);       //회원주소
	initEmEdit(EM_POINT,       "NUMBER^9^0", READ);       //누적포인트
// 	initEmEdit(EM_OCCURS_POINT,"NUMBER^9^0", READ);       //발생포인트
// 	initEmEdit(EM_SUM_POINT,   "NUMBER^9^0", READ);       //누적+발생포인트
	initEmEdit(EM_EMAIL,       "GEN^80",     READ);       //이메일주소
	initEmEdit(EM_EMAIL1,      "GEN^80",     READ);       //이메일주소hidden
	initEmEdit(EM_EMAIL2,      "GEN^80",     READ);       //이메일주소hidden
	initEmEdit(EM_CUST_GTADE,  "GEN^40",     READ);       //회원등급
	initEmEdit(EM_CUST_TYPE,   "GEN^40",     READ);       //회원유형
	initEmEdit(EM_ENTR_DT,    "YYYYMMDD",    READ);       //가입일자 추가 16.12.22
	
	initComboStyle(LC_MEMO_TYPE_D, DS_MEMO_TYPE, "CODE^0^30,NAME^0^90", 1, PK);    //메모유형
	initEmEdit(TXT_MEMO_DESC_D,     "GEN^400",      PK);          //회원메모

	//시스템 코드 공통코드에서 가지고 오기( popup.js )
	getEtcCode("DS_MEMO_TYPE", "D", "D020", "N");

	//조회일자 초기값.
	EM_MEMO_DATE_F.text = addDate("M", "-1", '<%=strToDate2%>');
	EM_MEMO_DATE_T.text = <%=strToDate%>;

	//활성화 비활성화 화면 초기 설정
	EM_MEMO_DATE_D.style.display = "none";
	EM_HOME_PH1.style.display    = "none";
	EM_HOME_PH2.style.display    = "none";
	EM_HOME_PH3.style.display    = "none";
	EM_MOBILE_PH1.style.display  = "none";
	EM_MOBILE_PH2.style.display  = "none";
	EM_MOBILE_PH3.style.display  = "none";
	EM_EMAIL1.style.display      = "none";
	EM_EMAIL2.style.display      = "none";
	EM_CUST_ID_H.style.display   = "none";
	EM_CARD_NO_H.style.display   = "none";
	EM_SS_NO_H.style.display     = "none";
	
	document.getElementById('titleSsno').innerHTML = "생년월일";
	document.getElementById('titleCust').innerHTML = "회원명";

	LC_MEMO_TYPE_D.Enable  = false;
	TXT_MEMO_DESC_D.Enable = false;
	
	RD_UPD_FLAG.CodeValue  = "2";
	RD_UPD_FLAG.Enable = false;
	
	RD_COMP_PERS_FLAG_S.Focus();
	
	//법인회원 조회/수정 화면에서 넘어오는 파라메타
	RD_COMP_PERS_FLAG_S.CodeValue = "<%=strCompPersFlag%>";
	
	if("<%=strSsNo%>" != "" || "<%=strCardNo%>" != "" || "<%=strCustId%>" != ""){
		initSearch();
	}

	//화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
	registerUsingDataset("dctm116","DS_O_MASTER,DS_IO_DETAIL");
}

function gridCreate1(){
	var hdrProperies = '<FC>id={currow}        name="NO"          width=30    align=center</FC>'
					 + '<FC>id=MEMO_DATE       name="메모일시"      width=140   align=center  mask="XXXX/XX/XX XX:XX:XX"</FC>'
					 + '<FC>id=COMM_NAME1      name="메모구분"     width=100   align=left</FC>'
					 + '<FC>id=CUST_ID         name="회원ID"       width=150   align=left   show=false</FC>'
					 + '<FC>id=CUST_NAME       name="회원명"       width=90    align=left</FC>'
					 + '<FC>id=COMP_PERS_FLAG  name="개인법인구분"  width=20    align=center  show=false</FC>'
					 + '<FC>id=SS_NO           name="생년월일"	  width=102   align=center  mask={IF(COMP_PERS_FLAG="P","XXXXXX","XXX-XX-XXXXX")}</FC>'
					 + '<FC>id=MEMO_DESC       name="메모"         width=225   align=left</FC>'
					 + '<FC>id=REG_ID          name="등록자ID"     width=80    align=left show=false</FC>'
					 + '<FC>id=USER_NAME       name="등록자"       width=80    align=left </FC>'
					 + '<FC>id=ORG_MEMO_DATE   name="원메모일시"    width=140   align=center  mask="XXXX/XX/XX XX:XX:XX"</FC>'
					 + '<FC>id=MOD_DATE        name="수정일시"      width=150   align=center  mask="XXXX/XX/XX XX:XX:XX"</FC>'
					 + '<FC>id=MOD_ID          name="수정자ID"      width=80    align=left show=false</FC>'
					 + '<FC>id=MOD_NAME        name="수정자"        width=80    align=left </FC>';

	initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 저장       - btn_Save()
     (4) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-22
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	if (DS_O_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated || strChangFlag != false){
		if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
			setTimeout("LC_MEMO_TYPE_D.Focus();",50);
			return false;
		}else{
			strChangFlag = true;
		}
	}
	
	if(RD_COMP_PERS_FLAG_S.CodeValue == "P" && trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0
			&& trim(EM_CARD_NO_S.Text).length == 0){
		showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일],[회원명] 중 1개는  반드시 입력해야 합니다.");
		EM_CARD_NO_S.Focus();
		return;
	} else if(RD_COMP_PERS_FLAG_S.CodeValue == "C" && trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0
			&& trim(EM_CARD_NO_S.Text).length == 0) {
		showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일],[법인명] 중 1개는  반드시 입력해야 합니다.");
		EM_CARD_NO_S.Focus();
		return;
	} else{
		//if (trim(EM_CARD_NO_S.Text).length > 0 && trim(EM_CARD_NO_S.Text).length < 16) {
		if(trim(EM_CARD_NO_S.Text).length != 0 && trim(EM_CARD_NO_S.Text).length != 13 && trim(EM_CARD_NO_S.Text).length != 16 ) {
			showMessage(EXCLAMATION, OK, "USER-1000",  "카드번호는 16자리입니다.");
			EM_CARD_NO_S.Focus();
			return;
		}
		if (RD_COMP_PERS_FLAG_S.CodeValue == "P" && (trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 6)) {
			showMessage(EXCLAMATION, OK, "USER-1000",  "생년월일은 6자리입니다.");
			EM_SS_NO_S.Focus();
			return;
		}else if (RD_COMP_PERS_FLAG_S.CodeValue == "C" && (trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 10)) {
			showMessage(EXCLAMATION, OK, "USER-1000",  "사업자등록번호는 10자리입니다.");
			EM_SS_NO_S.Focus();
			return;
		}
		if (RD_COMP_PERS_FLAG_S.CodeValue == "P" && trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9) {
			showMessage(EXCLAMATION, OK, "USER-1000",  "회원은 9자리입니다.");
			EM_CUST_ID_S.Text = "";
			EM_CUST_ID_S.Focus();
			return;
		}else if (RD_COMP_PERS_FLAG_S.CodeValue == "C" && trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9) {
			showMessage(EXCLAMATION, OK, "USER-1000",  "법인(단체)은 9자리입니다.");
			EM_CUST_ID_S.Text = "";
			EM_CUST_ID_S.Focus();
			return;
		}
	}

	if(trim(EM_MEMO_DATE_F.Text).length == 0){          // 조회시작일
		showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
		EM_MEMO_DATE_F.Focus();
		return;
	}else if(trim(EM_MEMO_DATE_T.Text).length == 0){    // 조회 종료일
		showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
		EM_MEMO_DATE_T.Focus();
		return;
	}else if(EM_MEMO_DATE_F.Text > EM_MEMO_DATE_T.Text){   // 조회일 정합성
		showMessage(EXCLAMATION, OK, "USER-1015");
		EM_MEMO_DATE_F.Focus();
		return;
	}

	bfListRowPosition = 0;
	intChangRow = 0;
	
	if(srchEvent(RD_COMP_PERS_FLAG_S.CodeValue)) {
		showMaster();
	}

	//조회결과 Return
	setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * btn_New()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-22
 * 개      요      : 신규추가 초기화
 * return값 : void
 */
function btn_New() {
	if(DS_O_CUSTDETAIL.CountRow == 0){
		showMessage(EXCLAMATION, OK, "USER-1000","조회 후 신규 등록 가능합니다.");
		return;
	}
	
	if (DS_O_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated){
		if(showMessage(EXCLAMATION, YESNO, "USER-1072") != 1 ){
			setTimeout("LC_MEMO_TYPE_D.Focus();",50);
			return false;
		}else{
			strChangFlag = true;
			if(DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "MEMO_DATE") == ""){
				DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition);
			}
		}
	}
	
	DS_O_MASTER.Addrow();
	DS_IO_DETAIL.ClearData();
	DS_IO_DETAIL.AddRow();
	LC_MEMO_TYPE_D.Enable  = true;
	TXT_MEMO_DESC_D.Enable = true;
	LC_MEMO_TYPE_D.Index          = -1;
	strChangFlag = false;
	LC_MEMO_TYPE_D.Focus();
	bfListRowPosition = 0;

	RD_UPD_FLAG.CodeValue  = "2";
	RD_UPD_FLAG.Enable     = false;

}

/**
 * btn_Save()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-22
 * 개       요     : 회원메모 저장
 * return값 : void
 */
function btn_Save() {

	// 저장할 데이터 없는 경우
	if (!DS_IO_DETAIL.IsUpdated){
		//저장할 내용이 없습니다
		showMessage(EXCLAMATION, OK, "USER-1028");
		return;
	}
	if(trim(LC_MEMO_TYPE_D.Text).length == 0){
		showMessage(EXCLAMATION, OK, "USER-1002",  "메모유형");
		LC_MEMO_TYPE_D.Focus();
		return;
	}
	if(trim(TXT_MEMO_DESC_D.Text).length == 0){
		showMessage(EXCLAMATION, OK, "USER-1002",  "메모내용");
		TXT_MEMO_DESC_D.Focus();
		return;
	}

	//저장여부 QUESTION
	if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
		return;
	}
	if(intChangRow != 1){
		intChangRow = DS_O_MASTER.RowPosition;
	}
	saveData();

}

/**
 * btn_Excel()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-22
 * 개       요     : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	var parameters = "";
	var ExcelTitle = "회원메모관리"

	if(strCompFlag == "P"){
		parameters += "회원구분=개인회원"
				   + " -조회기간=" + strMemoDateF + "~" + strMemoDateT
				   + " -카드번호=" + strCardNo
				   + " -생년월일=" + strSsNo
				   + " -회원ID="   + strCustId
				   + " -회원명="   + strCustNm;
	}else  if(strCompFlag == "C"){
		parameters += "회원구분=법인회원"
					+ " -조회기간="   + strMemoDateF + "~" + strMemoDateT
					+ " -카드번호="   + strCardNo
					+ " -사업자번호=" + strSsNo
					+ " -법인ID="     + strCustId
					+ " -법인(단체)명=" + strCustNm;
	}
	//openExcel2(GR_MASTER, ExcelTitle, parameters, true );
	openExcel5(GR_MASTER, ExcelTitle, parameters, true , "",g_strPid );
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-21
 * 개       요     : 회원메모 리스트 조회
 * return값 : void
 */
function showMaster(){
	
	strCompFlag  = RD_COMP_PERS_FLAG_S.CodeValue;
	strCardNo    = EM_CARD_NO_S.Text;
	strSsNo      = EM_SS_NO_S.Text;
	strCustId    = EM_CUST_ID_S.Text;
	strCustNm    = EM_CUST_NAME_S.Text;
	strMemoDateF = EM_MEMO_DATE_F.Text;
	strMemoDateT = EM_MEMO_DATE_T.Text;

	if(trim(EM_CUST_ID_S.Text).length == 0){
		strCustId   = EM_CUST_ID_H.Text;
	}
	if(trim(EM_CARD_NO_S.Text).length == 0){
		strCardNo = EM_CARD_NO_H.Text;
	}
	if(trim(EM_SS_NO_S.Text).length == 0){
		strSsNo = EM_SS_NO_H.Text;
	}
	var goTo        = "searchMaster";
	var action      = "O";
	var parameters  = "&strCardNo="    + encodeURIComponent(strCardNo)
					+ "&strSsNo="      + encodeURIComponent(strSsNo)
					+ "&strCustId="    + encodeURIComponent(strCustId)
					+ "&strMemoDateF=" + encodeURIComponent(strMemoDateF)
					+ "&strMemoDateT=" + encodeURIComponent(strMemoDateT)
					+ "&strCompPersFlag="+ encodeURIComponent(strCompFlag);
	
	TR_MAIN.Action  ="/dcs/dctm116.dm?goTo="+goTo+parameters;
	TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
	TR_MAIN.Post();

	if(DS_O_MASTER.CountRow > 0){
		GR_MASTER.Focus();
		if(intChangRow > 0){
			bfListRowPosition = DS_O_MASTER.RowPosition;
			setFocusGrid(GR_MASTER, DS_O_MASTER, intChangRow);
			doClick(intChangRow);
		}
		LC_MEMO_TYPE_D.Enable  = true;
		TXT_MEMO_DESC_D.Enable = true;
		
		RD_UPD_FLAG.Enable     = true;
		RD_UPD_FLAG.CodeValue == "2";
	}else{
		RD_COMP_PERS_FLAG_S.Focus();
		LC_MEMO_TYPE_D.Enable  = false;
		TXT_MEMO_DESC_D.Enable = false;
		
		RD_UPD_FLAG.CodeValue == "2";
		RD_UPD_FLAG.Enable     = false;
	}
	strChangFlag = false;
}

/**
 * doClick()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-22
 * 개       요     : 선택된 회원메모 정보 상세 조회
 * return값 : void
 */
function doClick(row){

	if( row == undefined )
		row = DS_O_MASTER.RowPosition;
	var strCustId   = DS_O_MASTER.NameValue(row ,"CUST_ID");
	var strMemoDate = DS_O_MASTER.NameValue(row ,"MEMO_DATE");
	var goTo        = "searchDetail";
	var action      = "O";
	var parameters  = "&strCustId="   + encodeURIComponent(strCustId)
					+ "&strMemoDate=" + encodeURIComponent(strMemoDate);
	TR_DETAIL.Action  = "/dcs/dctm116.dm?goTo="+goTo+parameters;
	TR_DETAIL.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
	TR_DETAIL.Post();
	
	RD_UPD_FLAG.CodeValue == "2";
}

/**
 * saveData()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-23
 * 개       요     : 회원메모 저장
 * return값 : void
 */
function saveData(){
	
	//if (DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition ,"CUST_ID") == "") { 
	 	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition ,"CUST_ID") = strCustId;
	//}
	
	var goTo        = "save";
	var action      = "I";  //조회는 O
	
	var strUpdFlag  = RD_UPD_FLAG.CodeValue; 
	
    var parameters  = "&strUpdFlag="    + encodeURIComponent(strUpdFlag); 
	
	//TR_MAIN.Action  ="/dcs/dctm116.dm?goTo="+goTo;
	TR_MAIN.Action  ="/dcs/dctm116.dm?goTo="+goTo+parameters;  
	TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)";
	TR_MAIN.Post();
	showMaster();
 }

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.02.22
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
	EM_CUST_NAME_S.Text = "";//조건입력시 코드초기화
	if (trim(EM_CUST_ID_S.Text).length > 0 ) {
		if (kcode == 13 || kcode == 9 || EM_CUST_ID_S.Text.length == 9) { //TAB,ENTER 키 실행시에만
			setNmToDataSet("DS_O_RESULT", "SEL_CUSTOMER", EM_CUST_ID_S.Text);

			if (DS_O_RESULT.CountRow == 1 ) {
				EM_CUST_ID_S.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
				EM_CUST_NAME_S.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
			} else {
				//1건 이외의 내역이 조회 시 팝업 호출
				getCustPop(EM_CUST_ID_S,EM_CUST_NAME_S);
			}
		}
	}
}

/**
 * initSearch()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.04.06
 * 개       요 : Init시 개인/법인 수정화면에서 넘어오는 값이 있으면 조회
 * return값 :
 */
function initSearch(){
	if(RD_COMP_PERS_FLAG_S.CodeValue == "C"){
		document.getElementById('titleSsno').innerHTML         = "사업자등록번호";
		document.getElementById('titleSsNo2').innerHTML        = "사업자등록번호";
		document.getElementById('titleCust').innerHTML         = "법인(단체)명";
		document.getElementById('titleCustName').innerHTML     = "법인(단체)명";
		document.getElementById('titleHomeAddr').innerHTML     = "사업장주소";
		document.getElementById('titleHomePH').innerHTML       = "대표전화";
		document.getElementById('titleMobileOffiPH').innerHTML = "담당자전화";

		initEmEdit(EM_SS_NO_H,    "#00-00-00000",      NORMAL);     //사업자번호_hidden
		initEmEdit(EM_SS_NO_S,    "#00-00-00000",      NORMAL);     //사업자번호
		initEmEdit(EM_SS_NO,      "#00-00-00000",      READ);       //사업자번호
	}
	
	EM_SS_NO_S.Text   = "<%=strSsNo%>";
	EM_CARD_NO_S.Text = "<%=strCardNo%>";
	EM_CUST_ID_S.Text = "<%=strCustId%>";
	setCustInfoToDataSet("DS_O_RESULT", "SEL_CUSTSRCH", EM_CUST_ID_S.Text, EM_CARD_NO_S.Text, EM_SS_NO_S.Text, 'getOneWithoutPop',RD_COMP_PERS_FLAG_S.CodeValue);
	
	if (DS_O_RESULT.CountRow == 1 ) {
		EM_CUST_ID_H.Text   = DS_O_RESULT.NameValue(1, "CUST_ID");
		if(trim(EM_CUST_ID_S.Text) != ""){
			EM_CUST_NAME_S.Text = DS_O_RESULT.NameValue(1, "CUST_NAME");
		}
		EM_CARD_NO_H.Text   = DS_O_RESULT.NameValue(1, "CARD_NO");
		EM_SS_NO_H.Text     = DS_O_RESULT.NameValue(1, "SS_NO");
	}
	if(trim(EM_CARD_NO_S.Text) != ""){
		EM_CARD_NO_S.Focus();
	}
	if(trim(EM_SS_NO_S.Text) != ""){
		EM_SS_NO_S.Focus();
	}
	if(trim(EM_CUST_ID_S.Text) != ""){
		EM_CUST_ID_S.Focus();
	}
	btn_Search();
}

/**
 * gourl()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-29
 * 개      요  : 화면 이동
 * return값 : void
 */
function gourl(go,nm,s){
	try{
		frame01 = window.external.GetFrame(window);
		frame01.Provider('../').OuterWindow.showStatusBar(strMsg); 
	} catch(e){		
	}
	frame01.Provider('../').OuterWindow.top.leftFrame.urlLink(go.toUpperCase().substring(0,7),"/dcs/"+go+"?goTo=list&strCardNo="+EM_CARD_NO_S.Text+"&strSsNo="+EM_SS_NO_S.Text,s,"01",nm);
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                        *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                        *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
	for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
	}
</script>
<script language=JavaScript for=TR_DETAIL event=onSuccess>
	for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
	}
	intChangRow = 0;
	bfListRowPosition = DS_O_MASTER.RowPosition;
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
	trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
	trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
	if ( strChangFlag == false && (DS_O_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated)){
		if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
			setTimeout("LC_MEMO_TYPE_D.Focus();",50);
			return false;
		}else {
			if(DS_O_MASTER.NameValue(row, "MEMO_DATE") == "")
				DS_O_MASTER.DeleteRow(row);
			return true;
		}
	}else{
		 return true;
	}
</script>
<!--DS_O_MASTER  OnRowPosChanged(row)(row,colid)-->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
	if(clickSORT) return;
	//그리드 첫 row 상세조회
	if(row != 0){
		if( bfListRowPosition == row ){
			return;
		}
		if( intChangRow == 0 ){
			bfListRowPosition = row;
			doClick(row);
		}

	}else{
		DS_IO_DETAIL.ClearData();
	}
</script>
<!--DS_I_SEARCHINFO  OnRowPosChanged(row)(row,colid)-->
<script language=JavaScript for=DS_I_SEARCHINFO event=OnRowPosChanged(row)>
	if(clickSORT) return;
	
	//그리드 첫 row 상세조회
	if(row != 0){
		initSearch();
	}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!-- 회원ID onKillFocus() -->
<script language=JavaScript for=EM_CUST_ID_S event=onKillFocus()>
	if ((EM_CUST_ID_S.Modified) && (EM_CUST_ID_S.Text.length != 9)) {
		EM_CUST_NAME_S.Text = "";
		EM_CUST_NAME_S.Text = "";
		EM_CARD_NO_H.Text   = "";
		EM_SS_NO_H.Text     = "";
	}
</script>
<script language=JavaScript for=RD_COMP_PERS_FLAG_S event=OnSelChange()>
	if (strCompPersFlag == this.CodeValue) return;
	if ( strChangFlag == false && (DS_O_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated)){
		if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
			setTimeout("LC_MEMO_TYPE_D.Focus();",50);
			RD_COMP_PERS_FLAG_S.CodeValue = strCompPersFlag;
			return false;
		}
	}
	if ("P" == this.CodeValue) {
		document.getElementById('titleSsno').innerHTML         = "생년월일";
		document.getElementById('titleSsNo2').innerHTML        = "생년월일";
		document.getElementById('titleCust').innerHTML         = "회원명";
		document.getElementById('titleCustName').innerHTML     = "회원명";
		document.getElementById('titleHomeAddr').innerHTML     = "회원주소";
		document.getElementById('titleHomePH').innerHTML       = "자택전화";
		document.getElementById('titleMobileOffiPH').innerHTML = "이동전화";

		initEmEdit(EM_SS_NO_H,     "000000",     		 NORMAL);     //생년월일_hidden
		initEmEdit(EM_SS_NO_S,     "000000",     		 NORMAL);     //생년월일
		initEmEdit(EM_SS_NO,       "000000-0000000",       READ);       //사업자번호
		GR_MASTER.ColumnProp('CUST_NAME','name') = '회원명';
		GR_MASTER.ColumnProp('SS_NO','name') = '생년월일';

		strCompPersFlag = this.CodeValue;
	} else if ("C" == this.CodeValue) {
		document.getElementById('titleSsno').innerHTML         = "사업자등록번호";
		document.getElementById('titleSsNo2').innerHTML        = "사업자등록번호";
		document.getElementById('titleCust').innerHTML         = "법인(단체)명";
		document.getElementById('titleCustName').innerHTML     = "법인(단체)명";
		document.getElementById('titleHomeAddr').innerHTML     = "사업장주소";
		document.getElementById('titleHomePH').innerHTML       = "대표전화";
		document.getElementById('titleMobileOffiPH').innerHTML = "담당자전화";

		initEmEdit(EM_SS_NO_H,     "#00-00-00000",      NORMAL);     //사업자번호_hidden
		initEmEdit(EM_SS_NO_S,     "#00-00-00000",      NORMAL);     //사업자번호
		initEmEdit(EM_SS_NO,       "#00-00-00000",      READ);       //사업자번호

		GR_MASTER.ColumnProp('CUST_NAME','name') = '법인(단체)명';
		GR_MASTER.ColumnProp('SS_NO','name') = '사업자등록번호';
		strCompPersFlag = this.CodeValue;
	}
	DS_O_CUSTDETAIL.ClearData();
	DS_O_MASTER.ClearData();
	DS_IO_DETAIL.ClearData();
	EM_CUST_ID_H.Text   = "";
	EM_CARD_NO_H.Text   = "";
	EM_SS_NO_H.Text     = "";
	EM_HOME_PH.Text     = "";
	EM_MOBILE_PH.Text   = "";
	EM_EMAIL.Text       = "";
	EM_CUST_ID_S.Text   = "";
	EM_CUST_NAME_S.Text = "";
	EM_CARD_NO_S.Text   = "";
	EM_SS_NO_S.Text     = "";
	LC_MEMO_TYPE_D.Enable  = false;
	TXT_MEMO_DESC_D.Enable = false;
	
	RD_UPD_FLAG.Enable = false;
	EM_CARD_NO_CUT.Text   = "";
	
</script>

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_MEMO_DATE_F event=onKillFocus()>
	if(!checkDateTypeYMD(EM_MEMO_DATE_F)){
		EM_MEMO_DATE_F.Text = addDate("M", "-1", '<%=strToDate2%>');
	}
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_MEMO_DATE_T event=onKillFocus()>
	if(!checkDateTypeYMD(EM_MEMO_DATE_T)){
		initEmEdit(EM_MEMO_DATE_T,    "TODAY",     PK);
	}
</script>

<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
	sortColId( eval(this.DataID), row, colid);
</script>


<!-- 단축카드번호 onKillFocus() -->
<script language=JavaScript for=EM_CARD_NO_CUT event=onKillFocus()>
    //EM_CARD_NO_S.Text = cardCheckDigit(EM_CARD_NO_CUT.Text); 
	if ( trim(EM_CARD_NO_CUT.Text).length != 0 ) {
    	EM_CARD_NO_S.Text = cardCheckDigit(EM_CARD_NO_CUT.Text);
    	getCustInfoSrch(13,EM_CARD_NO_S,'EM_CARD_NO_S',strCompPersFlag);
    }
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== 공통콤보용 -->
<comment id="_NSID_">
<object id="DS_MEMO_TYPE" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Input,Output용  -->
<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CUSTDETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
					    <th width="77">카드번호</th>
						<td width="170">
						    <comment id="_NSID_"> <object style="display:none"
							id=EM_CARD_NO_CUT classid=<%=Util.CLSID_EMEDIT%> width="55"
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
						    <comment id="_NSID_"> <object
							id=EM_CARD_NO_H width=0 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
							id="_NSID_"> <object id=EM_CARD_NO_S
							classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1
							onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CARD_NO_S',strCompPersFlag);">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="77" style="display:none">회원구분</th>
						<td width="160" style="display:none"><comment id="_NSID_"> <object
							id=RD_COMP_PERS_FLAG_S classid=<%=Util.CLSID_RADIO%> tabindex=1
							style="height: 20; width: 150">
							<param name=Cols value="2">
							<param name=Format value="P^개인회원,C^법인회원">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80" class="point">조회기간</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_MEMO_DATE_F classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_MEMO_DATE_F)" />- <comment
							id="_NSID_"> <object id=EM_MEMO_DATE_T
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_MEMO_DATE_T)" /></td>
					</tr>
					<tr> 
						<th width="80"><span id="titleSsno" style="Color: 146ab9">사업자번호</span></th>
						<td width="150"><comment id="_NSID_"> <object
							id=EM_SS_NO_H width=0 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
							id="_NSID_"> <object id=EM_SS_NO_S
							classid=<%=Util.CLSID_EMEDIT%> width=105 tabindex=1
							onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'<%=strSsno%>',strCompPersFlag);">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80"><span id="titleCust" style="Color: 146ab9">법인명</span></th>
						<td><comment id="_NSID_"> <object id=EM_CUST_ID_H
							width=0 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
							id="_NSID_"> <object id=EM_CUST_ID_S
							classid=<%=Util.CLSID_EMEDIT%> width=66 tabindex=1
							onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CUST_ID_S',strCompPersFlag);"
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							onclick="getCompPop(EM_CUST_ID_S,EM_CUST_NAME_S,strCompPersFlag)" />
						<comment id="_NSID_"> <object id=EM_CUST_NAME_S
							classid=<%=Util.CLSID_EMEDIT%> width=81 align="absmiddle"></object>
						</comment> <script> _ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
	    <td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
			  <tr>
			    <td class="btn_l"> </td>
			    <td class="btn_c"><a href="#" onclick="gourl('dctm301.dm','포인트조회','DCTM')">포인트조회</a></td>
			    <td class="btn_r"></td>
			    <td class="btn_l" style="display:none"> </td>
			    <td class="btn_c" style="display:none"><a href="#" onclick="gourl('dmbo999.do','회원정보안내(소멸예정)','DMBO')">회원정보안내(소멸예정)</a></td>
			    <td class="btn_r" style="display:none"></td>
			  </tr>
			</table>                
	    </td>	
	</tr>	
	<tr>
		<td class="dot"></td>
	</tr>
	<tr>
		<td> <%@ include file="/jsp/common/memView.jsp"%>
		</td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=250 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script> _ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PT01">
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			class="s_table">
			<tr>
                <th width="80" class="point">메모유형</th>
                <td ><comment id="_NSID_"> <object
                    id=EM_MEMO_DATE_D classid=<%=Util.CLSID_EMEDIT%> width=0>
                </object> </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_"> <object
                    id=LC_MEMO_TYPE_D classid=<%=Util.CLSID_LUXECOMBO%> height=100
                    width=155 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>

                <th width="80"  style="display:none"  class="point">수정저장구분</th>
                <td style="display:none" ><comment id="_NSID_">
                      <object id=RD_UPD_FLAG classid=<%=Util.CLSID_RADIO%> style="height:20; width:280" align="absmiddle" tabindex=1>
                        <param name=Cols    value="3">
                        <param name=Format  value="1^수정저장,2^수정신규저장,3^추가신규저장">
                        <param name=CodeValue  value="1">
                      </object>
                    </comment> <script> _ws_(_NSID_);</script></td>                    
            </tr>
			<tr>
				<th width="80" class="point">메모내용</th>
				<td ><comment id="_NSID_"> <object
					id=TXT_MEMO_DESC_D classid=<%=Util.CLSID_TEXTAREA%>
					style="width: 100%; height: 145px;" tabindex=1
					onkeyup="javascript:checkByteStr(TXT_MEMO_DESC_D, 400,'Y');">
				</object> </comment> <script> _ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_DETAIL classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_DETAIL>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
			<c>col=MEMO_DATE       ctrl=EM_MEMO_DATE_D       Param=Text</c>
			<c>col=MEMO_TYPE       ctrl=LC_MEMO_TYPE_D       Param=BindColVal</c>
			<c>col=MEMO_DESC       ctrl=TXT_MEMO_DESC_D      Param=Text</c>
		'>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=BD_CUSTDETAIL classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_O_CUSTDETAIL>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=CUST_NAME     ctrl=EM_CUST_NAME    Param=Text</c>
            <c>col=HOME_PH1      ctrl=EM_HOME_PH1     Param=Text</c>
            <c>col=HOME_PH2      ctrl=EM_HOME_PH2     Param=Text</c>
            <c>col=HOME_PH3      ctrl=EM_HOME_PH3     Param=Text</c>
            <c>col=MOBILE_PH1    ctrl=EM_MOBILE_PH1   Param=Text</c>
            <c>col=MOBILE_PH2    ctrl=EM_MOBILE_PH2   Param=Text</c>
            <c>col=MOBILE_PH3    ctrl=EM_MOBILE_PH3   Param=Text</c>
            <c>col=SS_NO         ctrl=EM_SS_NO        Param=Text</c>
            <c>col=HOME_ADDR     ctrl=EM_HOME_ADDR    Param=Text</c>
            <c>col=POINT         ctrl=EM_POINT        Param=Text</c>
            <c>col=OCCURS_POINT  ctrl=EM_OCCURS_POINT Param=Text</c>
            <c>col=SUM_POINT     ctrl=EM_SUM_POINT    Param=Text</c>
            <c>col=EMAIL1        ctrl=EM_EMAIL1       Param=Text</c>
            <c>col=EMAIL2        ctrl=EM_EMAIL2       Param=Text</c>
            <c>col=GRADE_NAME    ctrl=EM_CUST_GTADE   Param=Text</c>
            <c>col=CUST_TYPE_NM  ctrl=EM_CUST_TYPE    Param=Text</c>
            <c>col=ENTR_DT  	 ctrl=EM_ENTR_DT    Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
