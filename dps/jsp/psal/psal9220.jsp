<!--
/*******************************************************************************
 * 시스템명 : 포인트카드 > 신용카드대금청구 > 청구관리 > 청구대상 데이터 조회
 * 작  성  일  : 2010.05.31
 * 작  성  자  :
 * 수  정  자  :
 * 파  일  명  : psal9220.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  :
 * 이         력  :
 *           2010.05.31 (김영진) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="common.vo.SessionInfo" %>
<%@ page import="common.util.Util"  %>
<%@ page import="kr.fujitsu.ffw.base.BaseProperty"  %>

<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                         *-->
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
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                 *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strExlParam = "";
var gsGridLoad = "N";	//그리드 로딩 처리
var gsGridClick = "N";	//그리드 클릭시
var top = 300;		//해당화면의 동적그리드top위치
var g_strPid           = "<%=pageName%>";                 // PID

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-31
 * 개       요     : 해당 페이지 LOAD 시
 * return값 : void
 */
function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GR_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	//Input, Output Data Set Header 초기화
	DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
	DS_O_COUNT.setDataHeader('<gauce:dataset name="H_COUNT"/>');

	//그리드 초기화
	gridCreate1();	//마스터

	//EMedit에 초기화
	initEmEdit(EM_CARD_NO,     "GEN^10",               NORMAL);
	initEmEdit(EM_APPR_NO,     "0000000000",           NORMAL);
	initEmEdit(EM_REQ_DT,      "TODAY",                PK);				//조회from
	
	//테스트용 임시 시작***********
	/* initEmEdit(EM_REQ_DT,      "YYYYMMDD",                PK);				//조회from(테스트용)
	var now = new Date();
	var mon = now.getMonth();
	if(mon < 10)mon = "0" + mon;
	var varToday = now.getYear().toString()+ mon + "01";
	EM_REQ_DT.Text = varToday; */
	//테스트용 임시 종료**********
	
	initEmEdit(EM_REQ_TO_DT,   "TODAY",                PK);				//조회 to
	initEmEdit(EM_CARD_NO,     "0000-0000-0000-0000-0000",  NORMAL);	//카드번호
	initEmEdit(EM_DIV_MONTH,   "00",                   NORMAL);			//할부


	//수정및 신규 START
	initEmEdit(EM_IO_REC_FLAG,     "GEN^10",               NORMAL);

	initComboStyle(LC_IO_WORK_FLAG, DS_IO_WORK_FLAG, "CODE^0^30,NAME^0^60", 1, PK);
	getEtcCode("DS_IO_WORK_FLAG" ,"D"   ,"D035"  ,"N" );			//작업구분

	initEmEdit(EM_IO_COMP_NO,   "000-00-00000",               NORMAL);			//사업자번호
	initEmEdit(EM_IO_CARD_NO,   "0000-0000-0000-0000-0000",   NORMAL);			//카드번호
	initEmEdit(EM_IO_EXP_DT,    "00/00",                      NORMAL);			//유효기간
	initEmEdit(EM_IO_DIV_MONTH, "CODE^2",                     NORMAL);			//할부
	initEmEdit(EM_IO_APPR_AMT,  "",                           NORMAL);			//승인금액
	initEmEdit(EM_IO_SVC_AMT,   "",                           NORMAL);			//봉사료
	initEmEdit(EM_IO_APPR_NO,   "0000000000",                 NORMAL);			//승인번호
	initEmEdit(EM_IO_APPR_DT,   "YYYYMMDD",                   NORMAL);			//승인일자
	initEmEdit(EM_IO_APPR_TIME, "00:00:00",                   NORMAL);			//승인시간
	initEmEdit(EM_IO_CAN_DT,    "YYYYMMDD",                   NORMAL);			//취소일자
	initEmEdit(EM_IO_CAN_TIME,  "00:00:00",                   NORMAL);			//승인시간
	
	//LC_IO_CCOMP_CD  //발급사코드
	//LC_IO_BCOMP_CD  //매입사코드

	initComboStyle(LC_IO_CCOMP_CD,   DS_CCOMP_NM,   "CODE^0^30,NAME^0^50", 1, PK);	//발급사코드
	getCcompCode("DS_CCOMP_NM", "", "", "Y");//발급사코드

	initComboStyle(LC_IO_BCOMP_CD,   DS_BCOMP_NM,   "CODE^0^30,NAME^0^50", 1, PK);	//매입사코드
	getBcompCode("DS_BCOMP_NM", "", "", "Y"); //매입사코드
	
	initComboStyle(LC_IO_PAY_TYPE,   DS_O_PAY_TYPE, "CODE^0^30, NAME^0^70", 1, PK);	//결재구분
    getEtcCode("DS_O_PAY_TYPE", "D", "D065", "N");
	
  	//initEmEdit(LC_IO_DEVICE_ID,    "GEN^10",               NORMAL);
  	initComboStyle(LC_IO_DEVICE_ID,   DS_O_DEVICE_ID, "CODE^0^80, NAME^0^70", 1, PK);	//단말기번호
    //getEtcCode("DS_O_DEVICE_ID", "D", "P181", "N");
  	getEtcCodeRefer("DS_O_DEVICE_ID",   "D", "P181", "N");
  	
	initEmEdit(EM_IO_JBRCH_ID,	"00000000",		NORMAL);	//가맹점번호
	initEmEdit(EM_IO_REQ_DT,	"YYYYMMDD",		NORMAL);	//매입요청일
	initEmEdit(EM_IO_SEQ_NO,	"CODE^3",		NORMAL);	//매입요청일순번

	//콤보 초기화
	initComboStyle(LC_IO_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);	//점(조회)
	getStore("DS_O_STR_CD", "Y", "", "N");									//점

	//END

	initComboStyle(LC_STR_CD,   DS_STR_CD,   "CODE^0^30,NAME^0^80", 1, PK);
	initComboStyle(LC_BCOMP_CD, DS_BCOMP_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);
	initComboStyle(LC_BRCH_CD,  DS_BRCH_CD,  "CODE^0^120,NAME^0^180", 1, NORMAL);

	// 초기값설정
	getStore("DS_STR_CD", "Y", "", "N");
	setComboData(LC_STR_CD,  DS_STR_CD.NameValue(0, "CODE"));
	DS_O_DEVICE_ID.Filter();
	// 매입사코드콤보 목록 가져오기 및 초기값 설정
	getBcompCode("DS_BCOMP_CD", "", "", "Y");
	setComboData(LC_BCOMP_CD,  "%");

	//showMaster();
	
	enableCheck();
	enableCheck1(false);
	enableCheck2(false);
}

function gridCreate1(){
	var hdrProperies    = '<FC>id={currow}     name="NO"             width=30   align=center</FC>'
						+ '<FC>id=REC_FLAG     name="레코드구분"       width=70   align=center  SumText= ""</FC>'
						+ '<FC>id=DEVICE_ID    name="단말기번호"       width=80   align=center  SumText= "합계"</FC>'
						+ '<FC>id=WORK_FLAG    name="작업구분"         width=60   align=center show=false</FC>'
						+ '<FC>id=WORK_FLAG_NM name="작업구분"         width=100  align=left   SumText= ""</FC>'
						+ '<FC>id=COMP_NO      name="사업자번호"       width=100  align=center mask="XXX-XX-XXXXX"  SumText= ""</FC>'
						+ '<FC>id=CARD_NO      name="카드번호"         width=170  align=center mask="XXXX-XXXX-XXXX-XXXX-XXXX"  SumText= ""</FC>'
						+ '<FC>id=EXP_DT       name="유효기간"         width=100  align=center mask="XX/XX"  SumText= ""</FC>'
						+ '<FC>id=DIV_MONTH    name="할부"             width=40   align=right  SumText= ""</FC>'
						+ '<FC>id=APPR_AMT     name="승인금액"         width=100   align=right  SumText=@sum</FC>'
						+ '<FC>id=SVC_AMT      name="봉사료"           width=90   align=right   SumText= ""</FC>'
						+ '<FC>id=APPR_NO      name="승인번호"         width=80   align=center  SumText= ""</FC>'
						+ '<FC>id=APPR_DT      name="승인일자"         width=80   align=center  SumText= "" mask="XXXX/XX/XX"</FC>'
						+ '<FC>id=APPR_TIME    name="승인시간"         width=80   align=center  SumText= "" mask="XX:XX:XX"</FC>'
						+ '<FC>id=CAN_DT       name="취소일자"         width=80   align=center  SumText= "" mask="XXXX/XX/XX"</FC>'
						+ '<FC>id=CAN_TIME     name="취소시간"         width=80   align=center  SumText= "" mask="XX:XX:XX"</FC>'
						+ '<FC>id=CCOMP_CD     name="발급사코드"       width=100  align=left    SumText= "" SHOW=FALSE</FC>'
						+ '<FC>id=CCOMP_NM     name="발급사코드/명"    width=100  align=left    SumText= ""</FC>'
						+ '<FC>id=BCOMP_CD     name="매입사코드"       width=100  align=left    SumText= "" SHOW=FALSE</FC>'
						+ '<FC>id=BCOMP_NM     name="매입사코드/명"    width=100  align=left    SumText= ""</FC>'
						+ '<FC>id=JBRCH_ID     name="가맹점번호"       width=80   align=center  SumText= ""</FC>'
						+ '<FC>id=REQ_DT       name="청구일자"         width=80   align=center  SumText= "" mask="XXXX/XX/XX"</FC>'
						+ '<FC>id=FCL_FLAG     name="시설구분"         width=80   align=center  SumText= "" SHOW=FALSE </FC>'
						+ '<FC>id=SEQ_NO       name="청구순번"         width=80   align=center  SumText= ""</FC>'
						+ '<FC>id=STR_CD       name="점"               width=80   align=center  SumText= "" SHOW=FALSE </FC>'
						+ '<FC>id=DOLLAR_FLAG  name="달러구분"         width=80   align=center  SumText= "" SHOW=FALSE </FC>'
						+ '<FC>id=FILLER       name="FILLER"           width=80   align=center  SumText= "" SHOW=FALSE </FC>'
						+ '<FC>id=SALE_DT      name="매출일자"         width=80   align=center  SumText= "" SHOW=FALSE </FC>'
						+ '<FC>id=POS_NO       name="POS번호"          width=80   align=center  SumText= "" SHOW=FALSE </FC>'
						+ '<FC>id=TRAN_NO      name="거래번호"         width=80   align=center  SumText= "" SHOW=FALSE </FC>'
						+ '<FC>id=POS_SEQ_NO   name="일련번호"         width=80   align=center  SumText= "" SHOW=FALSE </FC>'
						+ '<FC>id=PAY_TYPE     name="결재구분"         width=80   align=center  SumText= "" SHOW=FALSE </FC>'
						+ '<FC>id=CHECK1       name="신규구분"         width=80   align=center  SumText= "" SHOW=FALSE </FC>'
						;

	initGridStyle(GR_MASTER, "common", hdrProperies, false);
	GR_MASTER.ViewSummary = "1";
}

/*************************************************************************
 * 2. 공통버튼
	 (1) 조회       - btn_Search(), subQuery()
	 (2) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-31
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(trim(LC_STR_CD.BindColVal).length == 0){
		showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
		LC_STR_CD.Focus();
		return false;
	}

	if(trim(EM_REQ_DT.Text).length == 0){
		showMessage(EXCLAMATION, OK, "USER-1001","청구일자From");
		EM_REQ_DT.Focus();
		return;
	}
	if(trim(EM_REQ_TO_DT.Text).length == 0){
		showMessage(EXCLAMATION, OK, "USER-1001","청구일자To");
		EM_REQ_TO_DT.Focus();
		return;
	}
	DS_O_DEVICE_ID.Filter();
	//조회
	showMaster();
}

//신규
function btn_New(){
	DS_O_MASTER.AddRow();
	enableCheck();
	enableCheck1(true);
	enableCheck2(true);
}

//저장
function btn_Save(){
	
	// 저장할 데이터 없는 경우
	if (!DS_O_MASTER.IsUpdated){
		//저장할 내용이 없습니다
		showMessage(EXCLAMATION, OK, "USER-1028");
		return;
	}
	
	//데이터 체크
	if(!fn_DataCheck(LC_IO_STR_CD, 		"점", 				"LC", 0, 0, 0)) return;
	if(!fn_DataCheck(EM_IO_REQ_DT, 		"청구일자", 			"EM", 0, 0, 8)) return;
	if(!fn_DataCheck(EM_IO_SEQ_NO, 		"순번", 				"EM", 0, 0, 0)) return;
	if(!fn_DataCheck(LC_IO_DEVICE_ID, 	"단말기번호", 		"LC", 0, 0, 0)) return;
	if(!fn_DataCheck(LC_IO_WORK_FLAG, 	"작업구분", 			"LC", 0, 0, 0)) return;
	if(!fn_DataCheck(EM_IO_CARD_NO, 	"카드번호", 			"EM", 0, 0, 0)) return;
	if(!fn_DataCheck(EM_IO_EXP_DT, 		"유효기간(YY/MM)", 	"EM", 0, 0, 4)) return;
	if(!fn_DataCheck(EM_IO_DIV_MONTH, 	"할부", 				"EM", 0, 0, 0)) return;
	if(!fn_DataCheck(EM_IO_APPR_AMT, 	"승인금액", 			"EM", 2, 0, 0)) return;
	if(!fn_DataCheck(EM_IO_SVC_AMT, 	"봉사료", 			"EM", 0, 0, 0)) return;
	if(!fn_DataCheck(EM_IO_APPR_NO, 	"승인번호", 			"EM", 0, 10, 0)) return;
	if(!fn_DataCheck(EM_IO_APPR_DT, 	"승인일자", 			"EM", 0, 0, 8)) return;
	if(!fn_DataCheck(EM_IO_APPR_TIME, 	"승인시간", 			"EM", 0, 0, 6)) return;
	
	if(LC_IO_WORK_FLAG.BindColVal == "12") {	//작업구분이 취소인경우
		if(!fn_DataCheck(EM_IO_CAN_DT, 		"취소일자", 			"EM", 0, 0, 8)) return;
		if(!fn_DataCheck(EM_IO_CAN_TIME, 	"취소시간", 			"EM", 0, 0, 6)) return;
	} else {	//작업구분 일반일경우 취소일자, 취소시간 초기화 
		EM_IO_CAN_DT.Text = "";
		EM_IO_CAN_TIME.Text = "";
	}
	
	if(!fn_DataCheck(LC_IO_CCOMP_CD, 	"발급사", 			"LC", 0, 0, 0)) return;
	if(!fn_DataCheck(LC_IO_BCOMP_CD, 	"매입사", 			"LC", 0, 0, 0)) return;
	//if(!fn_DataCheck(EM_IO_JBRCH_ID, 	"가맹점번호", 		"EM", 0, 0, 0)) return;
	if(!fn_DataCheck(LC_IO_PAY_TYPE, 	"결재구분", 			"LC", 0, 0, 0)) return;
	
	if(EM_IO_JBRCH_ID.Text == "") {
		showMessage(INFORMATION, OK, "USER-1000", "가맹점번호가 잘못되었습니다. 매입사를 선택하면 자동으로 입력됩니다.");		
		LC_IO_BCOMP_CD.Focus();
		return;
	}
	
	saveData();
}

/**
 * 데이터 체크
 */
function fn_DataCheck(obj, objName, objType, minLen, maxLen, length) {
	var objValue = "";
	if(objType == "LC") {
		objValue = obj.BindColVal;
	} else {
		objValue = obj.Text;
	}
	
	if (objValue == "") {
		showMessage(EXCLAMATION, OK, "USER-1003",  objName);
		obj.Focus();
		return false;
	} else if(minLen > 0 && objValue.length < minLen) {
		showMessage(EXCLAMATION, OK, "USER-1003",  objName + "[최소]");
		obj.Focus();
		return false;
	} else if(maxLen > 0 && objValue.length > maxLen) {
		showMessage(EXCLAMATION, OK, "USER-1003",  objName + "[최대]");
		obj.Focus();
		return false;
	} else if(length > 0 && objValue.length != length) {
		showMessage(EXCLAMATION, OK, "USER-1003",  objName + "[길이]");
		obj.Focus();
		return false;
	}
	
	return true;
}

/**
 * btn_Excel()
 * 작   성   자 : 김영진
 * 작   성   일 : 2010-05-31
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

	var ExcelTitle = "청구대상 데이터 조회";
	//openExcel2(GR_MASTER, ExcelTitle, strExlParam, true );
	openExcel5(GR_MASTER, ExcelTitle, strExlParam, true , "",g_strPid );

	GR_MASTER.Focus();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
function saveData(){
	
	//변경또는 신규 내용을 저장하시겠습니까?
	if( showMessage(QUESTION, YESNO, "USER-1000", "저장 하시겠습니까?") != 1 ) {
		return;
	}

	var goTo		= "saveData";
	var action		= "I";	//등록
	var parameters	= "";
	
	TR_MAIN.Action  ="/dps/psal922.ps?goTo="+goTo+parameters;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; 
    TR_MAIN.Post();
	
	showMaster();
}

 /**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-31
 * 개       요     : 청구대상 데이터 조회
 * return값 : void
 */
function showMaster(){
	 
	gsGridLoad = "N";	//그리드 로드 off

	var strStrCd   = LC_STR_CD.BindColVal;
	var strReqDt   = EM_REQ_DT.text;
	var strReqToDt = EM_REQ_TO_DT.text;
	var strBcompCd = LC_BCOMP_CD.BindColVal;
	var strJbrchId = LC_BRCH_CD.BindColVal;
	var strCardNo  = EM_CARD_NO.text;
	var strApprNo  = EM_APPR_NO.text;
	var strDivMonth  = EM_DIV_MONTH.text;

	strExlParam = "점포명="     + LC_STR_CD.Text
				+ " -청구일자From=" + strReqDt
				+ " -청구일자To="   + strReqToDt
				+ " -카드매입사=" + LC_BCOMP_CD.Text
				+ " -가맹점번호=" + strJbrchId
				+ " -카드번호="   + strCardNo
				+ " -승인번호="   + strApprNo
				+ " -할부="      + strDivMonth;

	var goTo        = "searchMaster";
	var action      = "O";
	var parameters  = "&strStrCd="   + encodeURIComponent(strStrCd)
					+ "&strReqDt="   + encodeURIComponent(strReqDt)
					+ "&strReqToDt=" + encodeURIComponent(strReqToDt)
					+ "&strBcompCd=" + encodeURIComponent(strBcompCd)
					+ "&strJbrchId=" + encodeURIComponent(strJbrchId)
					+ "&strCardNo="  + encodeURIComponent(strCardNo)
					+ "&strApprNo="  + encodeURIComponent(strApprNo)
					+ "&strDivMonth="  + encodeURIComponent(strDivMonth);

	TR_MAIN.Action  ="/dps/psal922.ps?goTo="+goTo+parameters;
	TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
	TR_MAIN.Post();
	
	//그리드 첫 row 상세조회
	if(DS_O_MASTER.CountRow > 0) {
		//GR_MASTER.Focus();

		//청구대상 데이터 오류 검사
		goTo        = "searchCount";
		TR_SUB.Action  ="/dps/psal922.ps?goTo="+goTo+parameters;
		TR_SUB.KeyValue="SERVLET("+action+":DS_O_COUNT=DS_O_COUNT)"; //조회는 O
		TR_SUB.Post();

		if(DS_O_COUNT.NameValue(1, "CNT") > 0){
			showMessage(EXCLAMATION, OK, "USER-1000","수정 할 데이타가 존재 합니다.");
		}
		
	} else {
		LC_STR_CD.Focus();
	}

	//조회결과 Return
	setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-31
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
	 EM_CCOMP_NM.Text = "";//조건입력시 코드초기화
	if (LC_IO_CCOMP_CD.Text.length > 0 ) {
		if (kcode == 13 || kcode == 9 || LC_IO_CCOMP_CD.Text.length == 2) { //TAB,ENTER 키 실행시에만
			setNmToDataSet("DS_O_RESULT", "SEL_CARDBIN", LC_IO_CCOMP_CD.Text);
			if (DS_O_RESULT.CountRow == 1 ) {
				LC_IO_CCOMP_CD.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
				EM_CCOMP_NM.Text   = DS_O_RESULT.NameValue(1, "CODE_NM");
			} else {
				//1건 이외의 내역이 조회 시 팝업 호출
				getCcompPop(LC_IO_CCOMP_CD, EM_CCOMP_NM);
			}
		}
	}
}

/**
* 입력/수정항복 Enable 처리
* 입력, 수정 불가
*/
function enableCheck(){
	EM_IO_REC_FLAG.Enable=false;	//레코드구분 - 입력 불가(매입사 선택시 자동 입력)
	EM_IO_COMP_NO.Enable=false;		//사업자번호 - 입력 불가(점 선택시 자동 입력)
	EM_IO_JBRCH_ID.Enable=false;	//가맹점번호 - 입력 불가(매입사 선택시 자동 입력)
	
	var flag = false;
	var divDis = "none";
	if(LC_IO_WORK_FLAG.BindColVal == 12) {
		flag = true;
		divDis = "";
	}
	EM_IO_CAN_DT.Enable=flag;		//취소일자 - 작업구분(LC_IO_WORK_FLAG) 11일때 입력,수정 불가, 작업구분 12일때 입력,수정 가능
	EM_IO_CAN_TIME.Enable=flag;		//취소시간 - 작업구분(LC_IO_WORK_FLAG) 11일때 입력,수정 불가, 작업구분 12일때 입력,수정 가능
	document.all.IMG_CAN_DT.style.display = divDis;
}

/**
* 입력/수정항복 Enable 처리
* 입력 가능, 수정 불가
*/
function enableCheck1(flag) {
	var divDis = "";
	if(flag == false) {
		divDis = "none";
	} else {
		divDis = "";
	}
	document.all.IMG_REQ_DT.style.display = divDis;
	
	LC_IO_STR_CD.Enable=flag;		//점 - 신규 입력, 수정 불가
	EM_IO_REQ_DT.Enable=flag;		//청구일자 - 신규 입력, 수정 불가
	EM_IO_SEQ_NO.Enable=flag;		//순번 - 신규 입력, 수정 불가
}

/**
* 입력/수정항복 Enable 처리
* 입력, 수정 가능
*/
function enableCheck2(flag){
	LC_IO_DEVICE_ID.Enable=flag;	//단말기번호 - 입력, 수정
	LC_IO_WORK_FLAG.Enable=flag;	//작업구분 - 입력, 수정
	EM_IO_CARD_NO.Enable=flag;		//카드번호 - 입력, 수정
	EM_IO_EXP_DT.Enable=flag;		//유효기간(YY/MM) - 입력, 수정
	EM_IO_DIV_MONTH.Enable=flag;	//할부 - 입력, 수정
	EM_IO_APPR_AMT.Enable=flag;		//승인금액 - 입력, 수정
	EM_IO_SVC_AMT.Enable=flag;		//봉사료 - 입력, 수정
	EM_IO_APPR_NO.Enable=flag;		//승인번호 - 입력, 수정
	EM_IO_APPR_DT.Enable=flag;		//승인일자 - 입력, 수정
	EM_IO_APPR_TIME.Enable=flag;	//승인시간 - 입력, 수정
	LC_IO_CCOMP_CD.Enable=flag;		//발급사코드 - 입력, 수정
	LC_IO_BCOMP_CD.Enable=flag;		//매입사코드 - 입력, 수정
	LC_IO_PAY_TYPE.Enable=flag;		//결재구분 - 입력, 수정
	
	var divDis = "";
	if(flag == false) {
		divDis = "none";
	} else {
		divDis = "";
	}
	document.all.IMG_APPR_DT.style.display = divDis;
}

-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                   *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                            *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--************************************************************************-->

<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
	for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
	}
</script>
<script language=JavaScript for=TR_SUB event=onSuccess>
	for(i=0;i<TR_SUB.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_SUB.SrvErrMsg('UserMsg',i));
	}
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
	trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_SUB event=onFail>
	trFailed(TR_SUB.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--DS_BCOMP_CD  OnRowPosChanged(row)(row,colid)-->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_DEVICE_ID event=onFilter(row)>
   	var strStrCd = LC_IO_STR_CD.BindColVal;
    if (DS_O_DEVICE_ID.NameValue(row,"REFER_CODE") == strStrCd){
    	return true;
    }else{ 
    	return false;
    }
    

</script>
<script language=JavaScript for=DS_O_MASTER event=OnLoadCompleted(rowcnt)>
    if (rowcnt > 0) {
    	gsGridLoad = "Y";	//그리드 로드 셋팅
    }
</script>


<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
	if(gsGridLoad == "Y") {
		//수정
		enableCheck();
		enableCheck1(false);
		enableCheck2(true);
	}
	DS_O_DEVICE_ID.Filter();

</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<!-- 카드발급사 onKillFocus() -->
<script language=JavaScript for=LC_IO_CCOMP_CD event=onKillFocus()>
	if ((LC_IO_CCOMP_CD.Modified) && (LC_IO_CCOMP_CD.Text.length != 2)) {
		EM_CCOMP_NM.Text = "";
	}
</script>

<!-- 청구일자 onKillFocus() -->
<script language=JavaScript for=EM_REQ_DT event=onKillFocus()>
	if(!checkDateTypeYMD(EM_REQ_DT)){
		initEmEdit(EM_REQ_DT,    "TODAY",     PK);
	}
</script>

<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
	sortColId( eval(this.DataID), row, colid);
</script>

<!-- 매입사콤보 선택이벤트 처리 -->
<script language=JavaScript for=LC_BCOMP_CD event=OnSelChange()>
	DS_BRCH_CD.ClearData();
	if(this.BindColVal != "%"){
		LC_BRCH_CD.Enable = true;
		getJbrchCode("DS_BRCH_CD", this.BindColVal, "N");
	}else{
		LC_BRCH_CD.Enable = false;
	}
</script>

<!-- 입력/수정 매입사코드 선택이벤트 처리 -->
<script language=JavaScript for=LC_IO_BCOMP_CD event=OnCloseUp()>

	if(LC_IO_STR_CD.BindColVal == "") {
		showMessage(EXCLAMATION, OK, "USER-1000","점을 먼저 선택하세요.");
		LC_IO_STR_CD.Focus();
		return;
	}

	if(this.BindColVal == "01") {
		EM_IO_REC_FLAG.Text = "D";
	} else {
		EM_IO_REC_FLAG.Text = "d";
	}
	
	//가맹점 번호 조회
	var action      = "O";
	var goTo        = "getJbrchID";
	var parameters  = "&strStrCd="   + encodeURIComponent(LC_IO_STR_CD.BindColVal)
	                + "&strBCompCd=" + encodeURIComponent(LC_IO_BCOMP_CD.BindColVal);
	
	TR_SUB.Action  ="/dps/psal922.ps?goTo="+goTo+parameters;
	TR_SUB.KeyValue="SERVLET("+action+":DS_O_JBRCH_ID=DS_O_JBRCH_ID)"; //조회는 O
	TR_SUB.Post();
	
	if(DS_O_JBRCH_ID.NameValue(1, "JBRCHID") != ""){
		EM_IO_JBRCH_ID.Text = DS_O_JBRCH_ID.NameValue(1, "JBRCHID");
	}

</script>

<!-- 입력/수정 작업구분 선택이벤트 처리 -->
<script language=JavaScript for=LC_IO_WORK_FLAG event=OnCloseUp()>
	var flag = false;
	var divDis = "none";
	if(LC_IO_WORK_FLAG.BindColVal == 12) {
		flag = true;
		divDis = "";
	}
	EM_IO_CAN_DT.Enable=flag;		//취소일자 - 작업구분(LC_IO_WORK_FLAG) 11일때 입력,수정 불가, 작업구분 12일때 입력,수정 가능
	EM_IO_CAN_TIME.Enable=flag;		//취소시간 - 작업구분(LC_IO_WORK_FLAG) 11일때 입력,수정 불가, 작업구분 12일때 입력,수정 가능
	document.all.IMG_CAN_DT.style.display = divDis;
</script>

<!-- 점 선택시 시설구분, 사업자 번호 셋팅 -->
<script language=JavaScript for=LC_IO_STR_CD event=OnCloseUp()>

	//정보 조회
	var action      = "O";
	var goTo        = "getStrInfo";
	var parameters  = "&strStrCd="   + encodeURIComponent(LC_IO_STR_CD.BindColVal);
	
	TR_SUB.Action  ="/dps/psal922.ps?goTo="+goTo+parameters;
	TR_SUB.KeyValue="SERVLET("+action+":DS_O_STR_INFO=DS_O_STR_INFO)"; //조회는 O
	TR_SUB.Post();
	
	//시설구분 셋팅(EM_IO_FCL_FLAG)
	if(DS_O_STR_INFO.NameValue(1, "FCL_FLAG") != ""){
		EM_IO_FCL_FLAG.Text = DS_O_STR_INFO.NameValue(1, "FCL_FLAG");
	}
	
	//사업자 번호 셋팅(EM_IO_COMP_NO)
	if(DS_O_STR_INFO.NameValue(1, "COMP_NO") != ""){
		EM_IO_COMP_NO.Text = DS_O_STR_INFO.NameValue(1, "COMP_NO");
	}
	//단말기ID콤보 세팅 
	DS_O_DEVICE_ID.Filter();

</script>


<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리    끝                                                      *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                         *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_COUNT" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_JBRCH_ID" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_STR_INFO" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_BCOMP_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_BRCH_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_IO_WORK_FLAG" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_CCOMP_NM" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_BCOMP_NM" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PAY_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DEVICE_ID" classid=<%=Util.CLSID_DATASET%>>
    <param name=DataID      value="Filter_s1.csv">
    <param name=UseFilter   value=true>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                       *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_SUB" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
    var grd_height = 0;
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>
<!--*************************************************************************-->
<!--* E. 본문시작                                                                      *-->
<!--*************************************************************************-->

<body onLoad="doInit();" class="PL10 PT15">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="PT01 PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
				<tr>
					<td>
						<!-- search start -->
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="80" class="point">점포명</th>
								<td width="170">
									<comment id="_NSID_">
										<object id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=145 align="absmiddle" tabindex=1></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="80" class="point">청구일자</th>
								<td colspan="3">
									<comment id="_NSID_">
										<object id=EM_REQ_DT classid=<%=Util.CLSID_EMEDIT%> width=70 align="absmiddle" tabindex=1></object>
									</comment><script>_ws_(_NSID_);</script>
									<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_REQ_DT)" />
									~
									<comment id="_NSID_">
										<object id=EM_REQ_TO_DT classid=<%=Util.CLSID_EMEDIT%> width=70 align="absmiddle" tabindex=1>
										</object>
									</comment><script>_ws_(_NSID_);</script>
									<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_REQ_TO_DT)" />
								</td>
							</tr>
							<tr>
								<th width="80">카드매입사</th>
								<td width="170">
									<comment id="_NSID_">
										<object id=LC_BCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=145 align="absmiddle" tabindex=1></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="80">가맹점번호</th>
								<td colspan="3">
									<comment id="_NSID_">
										<object id=LC_BRCH_CD classid=<%=Util.CLSID_LUXECOMBO%> width=154 align="absmiddle" tabindex=1></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th width="80">카드번호</th>
								<td width="170">
									<comment id="_NSID_">
										<object id=EM_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width=155 align="absmiddle" tabindex=1></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="80">승인번호</th>
								<td width="170">
									<comment id="_NSID_">
										<object id=EM_APPR_NO classid=<%=Util.CLSID_EMEDIT%> width=150 align="absmiddle" tabindex=1></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="80">할부</th>
								<td width="170">
									<comment id="_NSID_">
										<object id=EM_DIV_MONTH classid=<%=Util.CLSID_EMEDIT%> width=140 align="absmiddle" tabindex=1></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
						</table>
						<!-- search end -->
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
		<td class="dot"></td>
	</tr>

	<tr>
		<td class="PB03">
			<!-- grid start -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
				<tr>
					<td>
						<comment id="_NSID_">
							<object id=GR_MASTER width="100%" height=300 classid=<%=Util.CLSID_GRID%> tabindex=1>
								<param name="DataID" value="DS_O_MASTER">
							</object>
						</comment><script>_ws_(_NSID_);</script>
					</td>
				</tr>
			</table>
			<!-- grid end -->
		</td>
	</tr>
	<!-- 추가 START -->
	<tr>
		<td class="PT01 PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
							<tr>
								<th width="60" class="point">점</th>
								<td width="100">
									<comment id="_NSID_">
										<object id=LC_IO_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=90 align="absmiddle" tabindex=1></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								
								<th width="60" class="point">청구일자</th>
								<td width="100">
									<comment id="_NSID_">
										<object id=EM_IO_REQ_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
									</comment><script>_ws_(_NSID_);</script>
									<span id="IMG_REQ_DT">
										<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_IO_REQ_DT)" />
									</span>
								</td>

								<th width="85" class="point">순번</th>
								<td width="90">
									<comment id="_NSID_">
										<object id=EM_IO_SEQ_NO classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle" ></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
		
								<th width="60">레코드구분</th>
								<td width="">
									<comment id="_NSID_">
										<object id=EM_IO_REC_FLAG classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle" ></object>
									</comment>
									<script>_ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th class="point">단말기번호</th>
								<td>
									<comment id="_NSID_">
										<object id=LC_IO_DEVICE_ID classid=<%=Util.CLSID_LUXECOMBO%> width=90 align="absmiddle" tabindex=1></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								
								<th class="point">작업구분</th>
								<td>
									<comment id="_NSID_">
										<object id=LC_IO_WORK_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=90 align="absmiddle" tabindex=1></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								
								<th>사업자번호</th>
								<td>
									<comment id="_NSID_">
										<object id=EM_IO_COMP_NO classid=<%=Util.CLSID_EMEDIT%> width=85 tabindex=1 align="absmiddle"></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
		
								<th class="point">카드번호</th>
								<td>
									<comment id="_NSID_">
										<object id=EM_IO_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1 align="absmiddle"></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th class="point">유효기간<br>(YY/MM)</th>
								<td>
									<comment id="_NSID_">
										<object id=EM_IO_EXP_DT classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle"></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>

								<th class="point">할부</th>
								<td>
									<comment id="_NSID_">
										<object id=EM_IO_DIV_MONTH classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								
								<th class="point">승인금액</th>
								<td>
									<comment id="_NSID_">
										<object id=EM_IO_APPR_AMT classid=<%=Util.CLSID_EMEDIT%> width=85 tabindex=1 align="absmiddle"></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								
								<th class="point">봉사료</th>
								<td>
									<comment id="_NSID_">
										<object id=EM_IO_SVC_AMT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th class="point">승인번호</th>
								<td>
									<comment id="_NSID_">
										<object id=EM_IO_APPR_NO classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle"></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								
								<th class="point">승인일자</th>
								<td>
									<comment id="_NSID_">
										<object id=EM_IO_APPR_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
									</comment><script>_ws_(_NSID_);</script>
									<span id="IMG_APPR_DT">
										<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_IO_APPR_DT)" />
									</span>
								</td>
								
								<th class="point">승인시간</th>
								<td>
									<comment id="_NSID_">
										<object id=EM_IO_APPR_TIME classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1 align="absmiddle"></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								
								<th>취소일자</th>
								<td>
									<comment id="_NSID_">
										<object id=EM_IO_CAN_DT classid=<%=Util.CLSID_EMEDIT%> width=70 align="absmiddle" tabindex=1></object>
									</comment><script>_ws_(_NSID_);</script>
									<span id="IMG_CAN_DT">
										<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_IO_CAN_DT)" />
									</span>
								</td>
							</tr>
							
							<tr>
								<th>취소시간</th>
								<td>
									<comment id="_NSID_">
										<object id=EM_IO_CAN_TIME classid=<%=Util.CLSID_EMEDIT%> width=90 align="absmiddle" tabindex=1></object>
									</comment><script>_ws_(_NSID_);</script>
								
								<th class="point">발급사</th>
								<td>
									<comment id="_NSID_">
										<object id=LC_IO_CCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=85 align="absmiddle" tabindex=1></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>

								<th class="point">매입사</th>
								<td>
									<comment id="_NSID_">
										<object id=LC_IO_BCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=85 align="absmiddle" tabindex=1></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								
								<th class="point">가맹점번호</th>
								<td>
									<comment id="_NSID_">
										<object id=EM_IO_JBRCH_ID classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th class="point">결재구분</th>
								<td colspan="7">
									<comment id="_NSID_">
										<object id=LC_IO_PAY_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=85 align="absmiddle" tabindex=1></object>
									</comment><script>_ws_(_NSID_);</script>
									<span style="display:none">
										<!-- 시설구분 -->
										<comment id="_NSID_">
											<object id=EM_IO_FCL_FLAG classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</span>
									
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<!-- 추가 END -->
</table>
</div>

<comment id="_NSID_">
<object id=BD_HEADER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_O_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
				<c>col=STR_CD         ctrl=LC_IO_STR_CD            Param=BindColVal</c>
				<c>col=REQ_DT         ctrl=EM_IO_REQ_DT            Param=Text</c>
				<c>col=SEQ_NO         ctrl=EM_IO_SEQ_NO            Param=Text</c>
				<c>col=REC_FLAG       ctrl=EM_IO_REC_FLAG          Param=Text</c>
				<c>col=DEVICE_ID      ctrl=LC_IO_DEVICE_ID         Param=BindColVal</c>
				<c>col=WORK_FLAG      ctrl=LC_IO_WORK_FLAG         Param=BindColVal</c>
				<c>col=COMP_NO        ctrl=EM_IO_COMP_NO           Param=Text</c>
				<c>col=CARD_NO        ctrl=EM_IO_CARD_NO           Param=Text</c>
				<c>col=EXP_DT         ctrl=EM_IO_EXP_DT            Param=Text</c>
				<c>col=DIV_MONTH      ctrl=EM_IO_DIV_MONTH         Param=Text</c>
				<c>col=APPR_AMT       ctrl=EM_IO_APPR_AMT          Param=Text</c>
				<c>col=SVC_AMT        ctrl=EM_IO_SVC_AMT           Param=Text</c>
				<c>col=APPR_NO        ctrl=EM_IO_APPR_NO           Param=Text</c>
				<c>col=APPR_DT        ctrl=EM_IO_APPR_DT           Param=Text</c>
				<c>col=APPR_TIME      ctrl=EM_IO_APPR_TIME         Param=Text</c>
				<c>col=CAN_DT         ctrl=EM_IO_CAN_DT            Param=Text</c>
				<c>col=CAN_TIME       ctrl=EM_IO_CAN_TIME          Param=Text</c>
				<c>col=CCOMP_CD       ctrl=LC_IO_CCOMP_CD          Param=BindColVal</c>
				<c>col=BCOMP_CD       ctrl=LC_IO_BCOMP_CD          Param=BindColVal</c>
				<c>col=JBRCH_ID       ctrl=EM_IO_JBRCH_ID          Param=Text</c>
				<c>col=PAY_TYPE       ctrl=LC_IO_PAY_TYPE          Param=BindColVal</c>
				<c>col=FCL_FLAG       ctrl=EM_IO_FCL_FLAG          Param=Text</c>
				<c>col=CHECK1         ctrl=EM_IO_CHECK             Param=Text</c>
			 '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

</body>
</html>