<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 가맹점관리 > 코드관리 > 가맹점 코드관리 
 * 작  성  일  : 2010.02.10
 * 작  성  자  : 
 * 수  정  자  : 
 * 파  일  명  : dbri1010.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.02.10 (김영진) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
	request.setCharacterEncoding("utf-8");
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
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var strFlag           = "INS";
var strChangFlag      = false;
var bfListRowPosition = 0;                             // 이전 List Row Position
var intChangRow       = 0;
var strBefore         = "";  
var strAfter          = "";
//엑셀용
var strBrchId         = "";
var strBrchNm         = "";
var strCompNo         = "";
var strBrchTypeText   = "";
var strBrchType       = "";

var g_strPid           = "<%=pageName%>";                 // PID

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-10
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    // Input, Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    DS_IO_DETAIL.ClearData();
    DS_IO_DETAIL.AddRow();

    // EMedit에 초기화
    initEmEdit(EM_BRCH_ID_S,   "GEN^10",       NORMAL);         //가맹점ID
    initEmEdit(EM_BRCH_NAME_S, "GEN^40",       READ);           //가맹점명
    initEmEdit(EM_COMP_NO_S,   "#00-00-00000", NORMAL);         //사업자번호
    initComboStyle(LC_BRCH_TYPE_S,DS_BRCH_TYPE_S, "CODE^0^30,NAME^0^80", 1, NORMAL);    //가맹점유형

    initEmEdit(EM_BRCH_ID,       "GEN^10",  READ);               //가맹점ID
    initEmEdit(EM_BRCH_NAME,     "GEN^40",  PK);                 //가맹점명
    initEmEdit(EM_STR_CD,        "GEN^2",   NORMAL);             //소속점코드
    initComboStyle(LC_STR,DS_STR,"CODE^0^30,NAME^0^80", 1, PK);  //소속점코드
    initEmEdit(EM_BRCH_TYPE,     "GEN^2",   NORMAL);             //가맹점유형
    initComboStyle(LC_BRCH_TYPE,DS_BRCH_TYPE, "CODE^0^30,NAME^0^80", 1, PK);    //가맹점유형
    initEmEdit(EM_REP_NAME,      "GEN^40",  PK);                 //대표자성명
    initEmEdit(EM_REP_SSNO,      "000000-0000000", NORMAL);      //대표자주민번호
    initEmEdit(EM_COMP_NO,       "#00-00-00000",   PK);          //사업자번호
    initEmEdit(EM_BRCH_PH1,      "0000",     NORMAL);            //대표전화1
    initEmEdit(EM_BRCH_PH2,      "0000",     NORMAL);            //대표전화2
    initEmEdit(EM_BRCH_PH3,      "0000",     NORMAL);            //대표전화3
    initEmEdit(EM_CHAR_NAME,     "GEN^40",   PK);                //담당자성명
    initEmEdit(EM_CHAR_PH1,      "0000",     PK);                //담당자연락처1
    initEmEdit(EM_CHAR_PH2,      "0000",     PK);                //담당자연락처2
    initEmEdit(EM_CHAR_PH3,      "0000",     PK);                //담당자연락처3
    initEmEdit(EM_CHAR_EMAIL1,   "GEN^50",   PK);                //담당자 이메일1
    initComboStyle(LC_CHAR_EMAIL2,DS_CHAR_EMAIL2, "CODE^0^25,NAME^0^85", 1, PK);    //담당자 이메일2
    initEmEdit(EM_CHAR_EMAIL2,   "GEN^50",   PK);                //담당자 이메일2
    initEmEdit(EM_OPEN_DT,       "YYYYMMDD", NORMAL);            //개업일자
    initEmEdit(EM_CAN_DT,        "YYYYMMDD", NORMAL);            //해지일자
    initEmEdit(EM_CAN_REASON,    "GEN^400",  NORMAL);            //해지사유
    initEmEdit(EM_REP_PUMMOK_NM, "GEN^40",   PK);                //대표품목명
    initEmEdit(EM_REP_BRAND_NM,  "GEN^40",   PK);                //대표브랜드
    initEmEdit(EM_BIZ_STAT,      "GEN^40",   NORMAL);            //업태
    initEmEdit(EM_BIZ_CAT,       "GEN^40",   NORMAL);            //종목
    initEmEdit(EM_ZIP_CD1,       "GEN^3",    READ);              //우편번호1
    initEmEdit(EM_ZIP_CD2,       "GEN^3",    READ);              //우편번호2
    initEmEdit(EM_BRCH_ADDR1,    "GEN^200",  READ);              //주소1
    initEmEdit(EM_BRCH_ADDR2,    "GEN^200",  NORMAL);            //주소2
    initEmEdit(EM_FINC_CD,       "GEN^10",   PK);                //재무업체코드
    initEmEdit(EM_BRCH_PAY_DAY,  "DD",       NORMAL);            //가맹점입금예정일
    initEmEdit(EM_BRCH_NEW_YN,   "GEN^1",    NORMAL);             //구/신주소여부
    
    initComboStyle2(LC_SHORT_CD,DS_O_SHORT_CD, "CODE^0^20,NAME^0^43", 1, PK); //단축코드
        
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_BRCH_TYPE_S", "D", "D025", "Y");
    getEtcCode("DS_BRCH_TYPE",   "D", "D025", "N");
    getEtcCode("DS_CHAR_EMAIL2", "D", "D013", "N");
    getEtcCode("DS_STR",         "D", "P055", "N");
    getEtcCode("DS_O_SHORT_CD",  "D", "D061", "N");
    getStore("DS_STR",   "N",   "", "N");

    //초기값설정
    setComboData(LC_BRCH_TYPE_S, "%");
    //setComboData(LC_STR,         "");
    setComboData(LC_BRCH_TYPE,   "");
    setComboData(LC_CHAR_EMAIL2, "99");
    setComboData(LC_SHORT_CD,    "");
    
    //담당자이메일 도메인 99일때만 직접입력 칸 표시
    EM_CHAR_EMAIL2.style.display = "";
    EM_STR_CD.style.display      = "none";
    EM_BRCH_TYPE.style.display   = "none";
    LC_SHORT_CD.style.display    = "none";
    EM_BRCH_NEW_YN.style.display = "none";
    EM_CAN_REASON.Enable         = false;
    
    //초기조회
    showMaster();
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dbri101","DS_O_MASTER,DS_IO_DETAIL");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"            width=30   align=center</FC>'
                     + '<FC>id=BRCH_ID          name="가맹점ID"      width=80   align=center  show=false</FC>'
                     + '<FC>id=BRCH_NAME        name="가맹점명"      width=120  align=left</FC>'
                     + '<FC>id=STR_CD           name="점코드"        width=80   align=center  show=false</FC>'
                     + '<FC>id=STR_NAME         name="소속점명"      width=120  align=left</FC>'
                     + '<FC>id=COMP_NO          name="사업자번호"    width=140  align=center  mask="XXX-XX-XXXXX"</FC>'
                     + '<FC>id=REP_PUMMOK_NM    name="대표품목명"    width=130  align=left</FC>'
                     + '<FC>id=CHAR_NAME        name="담당자성명"    width=120  align=left</FC>'
                     + '<FC>id=CHAR_PH          name="연락처"        width=120  align=center</FC>'
                     + '<FC>id=BRCH_TYPE        name="가맹점유형코드" width=120  align=center show=false</FC>'
                     + '<FC>id=BRCH_TYPE_NM     name="가맹점유형명"   width=100  align=center show=false</FC>';  
                     
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
 * 작 성 일     : 2010-02-10
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
    if (DS_O_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated){
        if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
          setTimeout("EM_BRCH_NAME.Focus();",50);
            return false;
        }else{
          strChangFlag = true;
        }
    }
    //DETAIL 초기화
    newData();
    bfListRowPosition = 0;
    //조회
    showMaster();
}

/**
 * btn_New()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-14
 * 개       요     : 신규추가 초기화
 * return값 : void
 */
function btn_New() {

	if (DS_O_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated){
	     if(showMessage(EXCLAMATION, YESNO, "USER-1072") != 1 ){
	         setTimeout("EM_BRCH_NAME.Focus();",50);
	         return false;
	     }else{
	         strChangFlag = true;
	         if(DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "BRCH_ID") == ""){
	             DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition);
	         }
	     }
	}
	trFlag = "INS";
	DS_O_MASTER.Addrow(); 
	DS_IO_DETAIL.ClearData();
	DS_IO_DETAIL.AddRow();
	setEnable(true);
	newData();
    bfListRowPosition = 0;
    intChangRow = 1;

}

/**
 * btn_Save()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-14
 * 개       요     : DB에 저장 / 수정  처리
 * return값 : void
 */
function btn_Save() {
	 
    if(DS_IO_DETAIL.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "신규버튼 클릭 후에 저장하시기 바랍니다.");
        return false;
    }
    
    if(trim(EM_BRCH_NAME.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "가맹점명");
        EM_BRCH_NAME.Focus();
        return;
    }
    if(trim(LC_STR.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1002",  "소속점포");
        LC_STR.Focus();
        return;
    }
    if(trim(LC_BRCH_TYPE.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1002",  "가맹점유형");
        LC_BRCH_TYPE.Focus();
        return;
    }
    if( LC_BRCH_TYPE.BindColVal == "51" && trim(LC_SHORT_CD.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1002",  "단축코드");
        LC_SHORT_CD.Focus();
        return;
    }
    if(trim(EM_REP_NAME.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1003",  "대표자성명");
        EM_REP_NAME.Focus();
        return;
    }
    if(trim(EM_REP_SSNO.Text).length != 0 ){
        if(!juminCheck(EM_REP_SSNO.Text)){
            showMessage(EXCLAMATION, OK, "USER-1004",  "대표자주민번호");
            EM_REP_SSNO.SelectAll = true;
            EM_REP_SSNO.Focus();
            return;
        }
    }
    if(trim(EM_COMP_NO.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1003",  "사업자번호");
        EM_COMP_NO.Focus();
        return;
    }
    var chk;
    if(EM_COMP_NO.Text.indexOf("B")==-1){
        chk = isSaupNO(EM_COMP_NO.Text);
    }
    if(chk==false){
    	showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 사업자번호가 아닙니다.");
    	 EM_COMP_NO.Text = "";
        EM_COMP_NO.Focus();
        return false;
    }
    if(trim(EM_BRCH_PH1.text) != "" && (trim(EM_BRCH_PH2.text) == "" || trim(EM_BRCH_PH3.text) == "")
     || trim(EM_BRCH_PH2.text) != "" && (trim(EM_BRCH_PH1.text) == "" || trim(EM_BRCH_PH3.text) == "")
     || trim(EM_BRCH_PH3.text) != "" && (trim(EM_BRCH_PH1.text) == "" || trim(EM_BRCH_PH2.text) == "")){
        showMessage(EXCLAMATION, OK, "USER-1000",  "대표전화를  정확히 입력하세요.");
        if(trim(EM_BRCH_PH1.text) == ""){
        	EM_BRCH_PH1.Focus();
        }else if(trim(EM_BRCH_PH2.text) == ""){
        	EM_BRCH_PH2.Focus();
        }else if(trim(EM_BRCH_PH3.text) == ""){
        	EM_BRCH_PH3.Focus();
        }
        return false;
    }
    if(trim(EM_BRCH_PH1.text) != "" && firstTelFormatAll(EM_BRCH_PH1) == false){
        showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 번호가 아닙니다.");
        EM_BRCH_PH1.Focus();
        EM_BRCH_PH1.SelectAll = true;
        return false;
    }
    if(trim(EM_CHAR_NAME.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1003",  "담당자성명");
        EM_CHAR_NAME.Focus();
        return;
    }
    if(trim(EM_CHAR_PH1.Text).length == 0 || trim(EM_CHAR_PH2.Text).length == 0 
            || EM_CHAR_PH3.text.length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "담당자연락처");
        EM_CHAR_PH1.Focus();
        return;
    }
    if(firstTelFormatAll(EM_CHAR_PH1) == false){
        showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 번호가 아닙니다.");
        EM_CHAR_PH1.Focus();
        EM_CHAR_PH1.SelectAll = true;
        return false;
    }
    if(trim(EM_CHAR_EMAIL1.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1003",  "담당자이메일");
        EM_CHAR_EMAIL1.Focus();
        return;
    }
    if(trim(LC_CHAR_EMAIL2.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1002",  "도메인");
        LC_CHAR_EMAIL2.Focus();
        return;
    }
    if( LC_CHAR_EMAIL2.BindColVal == "99" && trim(EM_CHAR_EMAIL2.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1003",  "도메인");
        EM_CHAR_EMAIL2.Focus();
        return;
    }
    if(trim(EM_OPEN_DT.Text).length != 0 && trim(EM_CAN_DT.Text).length != 0){
        if(EM_OPEN_DT.Text > EM_CAN_DT.Text){   // 개업일자, 해지일자 정합성
            showMessage(EXCLAMATION, OK, "USER-1020","해지일자","개업일자");
            EM_CAN_DT.Focus();
            return;
        }
    }
    if(trim(EM_CAN_DT.Text).length != 0 && trim(EM_CAN_REASON.text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1003",  "해지사유");
        EM_CAN_REASON.Focus();
        return;
    }
    if(trim(EM_REP_PUMMOK_NM.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1003",  "대표품목명");
        EM_REP_PUMMOK_NM.Focus();
        return;
    }
    if(trim(EM_REP_BRAND_NM.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1003",  "대표브랜드");
        EM_REP_BRAND_NM.Focus();
        return;
    }
    if(EM_ZIP_CD1.text=="" && EM_ZIP_CD2.text == "" && trim(EM_BRCH_ADDR2.Text).length != 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "주소");
        getPostPop_dcs(EM_ZIP_CD1,EM_ZIP_CD2,EM_BRCH_ADDR1,EM_BRCH_ADDR2,EM_OFFI_NEW_YN);
        return false;
    }
    if((EM_ZIP_CD1.text!="" && EM_ZIP_CD2.text != "")&& trim(EM_BRCH_ADDR2.Text).length == 0){       
        showMessage(EXCLAMATION, OK, "USER-1003",  "상세주소");
        EM_BRCH_ADDR2.Focus();
        return false;
    }
    if(trim(EM_FINC_CD.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1003",  "재무업체코드");
        EM_FINC_CD.Focus();
        return;
    }
    if(trim(EM_BRCH_PAY_DAY.Text).length == 1){
        showMessage(EXCLAMATION, OK, "USER-1053",  "가맹점입금예정일", "2");
        EM_BRCH_PAY_DAY.SelectAll = true;
        EM_BRCH_PAY_DAY.Focus();
        return;
    }
    
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SCOMP_YN") = RD_SCOMP_YN.CodeValue;
    EM_STR_CD.Text    = LC_STR.BindColVal;
    EM_BRCH_TYPE.Text = LC_BRCH_TYPE.BindColVal;
    
    if(LC_CHAR_EMAIL2.BindColVal == "99"){
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CHAR_EMAIL2") = EM_CHAR_EMAIL2.Text;
    }else{
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CHAR_EMAIL2") = LC_CHAR_EMAIL2.Text;
    }

    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }
    
    //저장여부 QUESTION
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
    
    if(intChangRow != 1){
        intChangRow = DS_O_MASTER.RowPosition;
    }
    bfListRowPosition = 0;
    saveData();
}

/**
 * btn_Excel()
 * 작   성   자 : 김영진
 * 작   성   일 : 2010-02-22
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    if (strBrchId == "") strBrchId = "전체";
    if (strBrchNm == "") strBrchNm = "전체";
    if (strCompNo == "") strCompNo = "전체";
    if (strBrchTypeText == "") strBrchTypeText = "전체";

    var parameters = "가맹점코드="   + strBrchId
                   + " -가맹점명="   + strBrchNm
                   + " -사업자번호=" + strCompNo
                   + " -가맹점유형=" + strBrchTypeText;
    
	var ExcelTitle = "가맹점 코드 관리";

	//openExcel2(GR_MASTER, ExcelTitle, parameters, true );
	openExcel5(GR_MASTER, ExcelTitle, parameters, true , "",g_strPid );

	
	GR_MASTER.Focus();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-11
 * 개       요     : 가맹점코드 리스트 조회 
 * return값 : void
 */
function showMaster(){
    strBrchId   = EM_BRCH_ID_S.text;
    strBrchNm   = EM_BRCH_NAME_S.text;
    strCompNo   = EM_COMP_NO_S.text;
    strBrchTypeText = LC_BRCH_TYPE_S.Text;
    strBrchType = LC_BRCH_TYPE_S.BindColVal;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strBrchId="   + encodeURIComponent(strBrchId)
                    + "&strCompNo="   + encodeURIComponent(strCompNo)
                    + "&strBrchType=" + encodeURIComponent(strBrchType);
    TR_MAIN2.Action  ="/dcs/dbri101.db?goTo="+goTo+parameters;  
    TR_MAIN2.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN2.Post();
    
    //그리드 첫 row 상세조회
    if(DS_O_MASTER.CountRow > 0){
    	GR_MASTER.Focus();
    	if(intChangRow > 0){
            bfListRowPosition = DS_O_MASTER.RowPosition;
            setFocusGrid(GR_MASTER, DS_O_MASTER, intChangRow);
            doClick(intChangRow);
        }
    	setEnable(true);
    }else{
    	EM_BRCH_ID_S.Focus();
    	setEnable(false);
    	
    }
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * setEnable(flag)
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-04-21
 * 개       요     : Enable true/false
 * return값 : void
 */
function setEnable(flag){
	EM_BRCH_NAME.Enable = flag;
	EM_STR_CD.Enable    = flag;
	LC_STR.Enable       = flag;
	EM_BRCH_TYPE.Enable = flag;
	LC_BRCH_TYPE.Enable = flag;
	RD_SCOMP_YN.Enable  = flag;
	EM_REP_NAME.Enable  = flag;
	EM_REP_SSNO.Enable  = flag;
	EM_COMP_NO.Enable   = flag;
	EM_BRCH_PH1.Enable  = flag;
	EM_BRCH_PH2.Enable  = flag;
	EM_BRCH_PH3.Enable  = flag;
	EM_CHAR_NAME.Enable = flag;
	EM_CHAR_PH1.Enable  = flag;
	EM_CHAR_PH2.Enable  = flag;
	EM_CHAR_PH3.Enable  = flag;
	EM_CHAR_EMAIL1.Enable   = flag;
	LC_CHAR_EMAIL2.Enable   = flag;
	EM_CHAR_EMAIL2.Enable   = flag;
	EM_OPEN_DT.Enable       = flag;
	EM_CAN_DT.Enable        = flag;
	EM_REP_PUMMOK_NM.Enable = flag;
	EM_REP_BRAND_NM.Enable  = flag;
	EM_BIZ_STAT.Enable      = flag;
	EM_BIZ_CAT.Enable       = flag;
	EM_BRCH_ADDR2.Enable    = flag;
	EM_FINC_CD.Enable       = flag;
	EM_BRCH_PAY_DAY.Enable  = flag;
    enableControl(IMG_OPEN_DT , flag);
    enableControl(IMG_CAN_DT  , flag);
    enableControl(IMG_ZIP_CD  , flag);
    if(trim(EM_CAN_DT.Text) != ""){
    	EM_CAN_REASON.Enable    = false;
    }
}

/**
 * saveData()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-15
 * 개       요     : 가맹점코드 저장
 * return값 : void
 */
function saveData(){
    var goTo        = "save";
    var action      = "I";  //조회는 O
    TR_MAIN.Action  ="/dcs/dbri101.db?goTo="+goTo;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_MAIN.Post();

    if(LC_CHAR_EMAIL2.BindColVal != "99"){
        EM_CHAR_EMAIL2.Text = ""; 
    }
    showMaster();
 }
 
/**
 * doClick()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-11
 * 개       요     : 선택된 가맹점코드 정보 상세 조회 
 * return값 : void
 */
function doClick(row){
    strFlag = "UPD";
    EM_CHAR_EMAIL2.text = "";
    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;
    var strBrchId   = DS_O_MASTER.NameValue(row ,"BRCH_ID");
    var goTo        = "searchDetail";    
    var action      = "O";     
    var parameters  = "&strBrchId=" + encodeURIComponent(strBrchId);
    TR_DETAIL.Action  = "/dcs/dbri101.db?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();

    LC_STR.BindColVal       = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition ,"STR_CD"); 
    
    RD_SCOMP_YN.CodeValue   = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition ,"SCOMP_YN");
    LC_BRCH_TYPE.BindColVal = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition ,"BRCH_TYPE");
    
    LC_CHAR_EMAIL2.Text     = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition ,"CHAR_EMAIL2");
    LC_CHAR_EMAIL2.Index    = LC_CHAR_EMAIL2.IndexOfColumn("NAME", EM_CHAR_EMAIL2.Text);
    if(trim(EM_CAN_REASON.text).length > 0){
    	EM_CAN_REASON.Enabled = true;
    }else{
    	EM_CAN_REASON.Enabled = false;
    }
    if(strFlag == "UPD" && LC_CHAR_EMAIL2.BindColVal == ""){
        setComboData(LC_CHAR_EMAIL2,"99");
        EM_CHAR_EMAIL2.style.display = "";
    }else{
        EM_CHAR_EMAIL2.style.display = "none";
    }
}

/**
 * newData()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.04.13
 * 개      요  : 설정 초기화 
 * return값 :
 */
function newData(){
    EM_STR_CD.style.display    = "none";
    EM_BRCH_TYPE.style.display = "none";
    LC_SHORT_CD.style.display  = "none";
    document.getElementById('subTitle1').style.display = "none";
    document.getElementById('subTitle2').style.display = "none";
    RD_SCOMP_YN.CodeValue = "Y";
    LC_BRCH_TYPE.Index    = -1;
    LC_STR.Index          = -1;
    EM_CHAR_EMAIL2.text   = "";
    setComboData(LC_CHAR_EMAIL2,"99");
    EM_CHAR_EMAIL2.style.display = "";
    EM_BRCH_NAME.Focus();
    strChangFlag = false;
}

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.02.24
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
	EM_BRCH_NAME_S.Text = "";//조건입력시 코드초기화
    if (EM_BRCH_ID_S.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_BRCH_ID_S.Text.length == 10) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_ID_S.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
            	EM_BRCH_ID_S.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
            	EM_BRCH_NAME_S.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getBrchPop(EM_BRCH_ID_S,EM_BRCH_NAME_S);
            }
        }
    }
}
/**
 * initComboStyle2
 * 작  성 자 : 김영진
 * 작  성 일 : 2010.05.13
 * 개        요 : LuxeCombo의 Style 및 기본적 PARAMETER SETTING
 * 사 용 법  : initComboStyle(LC_DEAL_GUBN_S, ds_deal_gubn, "ETC_CODE^0^20,ETC_NAME^0^100", 1, PK/READ/NORMAL);
 *          initComboStyle(LuxeCombo ID, Dataset Name, ExprForamt, SearchColumn Index, PK)
 */
function initComboStyle2(objCombo, strDataSet, strExprFormat, intSearchColumn,  strType, strDsBindFlag){
    objCombo.ComboDataID      = strDataSet.id;
    objCombo.ListExprFormat   = strExprFormat;
    objCombo.FontSize         = "9";
    objCombo.FontName         = "돋움";
    objCombo.ListCount        = 10;
    //objCombo.SearchColumn   = strExprFormat.split(",")[intSearchColumn].split("^")[0];
    objCombo.BindColumn       = strExprFormat.split(",")[0].split("^")[0];
    objCombo.InheritColor   = true;
    if (strDsBindFlag != true){
        objCombo.SyncComboData    = false;
    }
    objCombo.WantSelChgEvent  = true;
    switch(THEME){
      case SPRING :
        break;
      case SUMMER :
        break;
      case FALL   :
        break;
      case WINTER :
        setObjTypeStyle( objCombo, "COMBO", strType );
        break;
      default :
      break;
    }
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                         *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        var strMsg = TR_MAIN.SrvErrMsg('UserMsg',i).split('|');
        EM_BRCH_ID.Text = strMsg[0]; 
        showMessage(INFORMATION, OK, "USER-1000", strMsg[1]);
    }
</script>
<script language=JavaScript for=TR_MAIN2 event=onSuccess>
    for(i=0;i<TR_MAIN2.SrvErrCount('UserMsg');i++) {
    	  showMessage(INFORMATION, OK, "USER-1000", TR_MAIN2.SrvErrMsg('UserMsg',i));
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
<script language=JavaScript for=TR_MAIN2 event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--DS_O_MASTER  CanRowPosChange(row)-->
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
    if ( strChangFlag == false && (DS_O_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated)){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            setTimeout("EM_BRCH_NAME.Focus();",50);
            return false;
        }else {
            if(DS_O_MASTER.NameValue(row, "BRCH_ID") == "")
                DS_O_MASTER.DeleteRow(row);
            return true;
        }
    }else{
         return true;
    }
</script>
<!--DS_O_MASTER  OnRowPosChanged(row)-->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    if(clickSORT) return;
    //그리드 첫 row 상세조회
    if(row != 0){
    	if( bfListRowPosition == row)
            return;
    	if( intChangRow == 0 ){
            bfListRowPosition = row;            
            doClick(row);
        }
    }else{
        DS_IO_DETAIL.ClearData();
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 대표전화  onKillFocus()-->
<script language=JavaScript for=EM_BRCH_PH1 event=onKillFocus()>
    if(trim(EM_BRCH_PH1.Text).length != 0){
        if(firstTelFormatAll(EM_BRCH_PH1)==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 번호가 아닙니다.");
            EM_BRCH_PH1.Text = ""
            setTimeout( "EM_BRCH_PH1.Focus();",50);
            return false;
        }
    }
</script>
<!-- 담당자연락처 onKillFocus()-->
<script language=JavaScript for=EM_CHAR_PH1 event=onKillFocus()>
    if(trim(EM_CHAR_PH1.Text).length != 0){
        if(firstTelFormatAll(EM_CHAR_PH1)==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 번호가 아닙니다.");
            EM_CHAR_PH1.Text = ""
            setTimeout( "EM_CHAR_PH1.Focus();",50);
            return false;
        }
    }
</script>
<!-- 가맹점명 onKillFocus() -->
<script language=JavaScript for=EM_BRCH_ID_S event=onKillFocus()>
    if ((EM_BRCH_ID_S.Modified) && (EM_BRCH_ID_S.Text.length != 10)) {
        EM_BRCH_NAME_S.Text = "";
    }
</script>
<!-- 도메인 OnSelChange() -->
<script language=JavaScript for=LC_CHAR_EMAIL2 event=OnSelChange2()>

    if(LC_CHAR_EMAIL2.BindColVal == "99"){
        EM_CHAR_EMAIL2.style.display = "";
    }else{
        var orgEmail2 = DS_IO_DETAIL.NameValue(1,"CHAR_EMAIL2");
        var changeEmail2 = LC_CHAR_EMAIL2.Text;
        if(orgEmail2 != changeEmail2){
        	EM_CHAR_EMAIL2.Text = changeEmail2;
        }
        EM_CHAR_EMAIL2.style.display = "none";
    }
</script>
<script language=JavaScript for= LC_CHAR_EMAIL2 event=OnKillFocus()>
    EM_CHAR_EMAIL2.selectAll = true;
</script>


<!-- 대표자주민번호 onKeyUp(kcode,scode) -->
<script language=JavaScript for=EM_REP_SSNO event=OnKillFocus()>
    if(trim(EM_REP_SSNO.Text).length != 0 ){
        if(!juminCheck(EM_REP_SSNO.Text)){
            showMessage(EXCLAMATION, OK, "USER-1004",  "대표자주민번호");
            EM_REP_SSNO.Text = "";
            setTimeout( "EM_REP_SSNO.Focus();",50);
            return;
        }
    }
</script>

<!-- 사업자번호 onKeyUp(kcode,scode) -->
<script language=JavaScript for=EM_COMP_NO event=OnKillFocus()>
    if(trim(EM_COMP_NO.Text).length != 0 ){
        var chk;
        if(EM_COMP_NO.Text.indexOf("B")==-1){
            chk = isSaupNO(EM_COMP_NO.Text);
        }
        if(chk==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 사업자번호가 아닙니다.");
            EM_COMP_NO.Text = "";
            setTimeout( "EM_COMP_NO.Focus();",50);
            return false;
        }
    }
</script>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 개업일자  onKillFocus() -->
<script language=JavaScript for=EM_OPEN_DT event=onKillFocus()>
    checkDateTypeYMD(EM_OPEN_DT);
</script> 
<!-- 해지일자 onKillFocus() -->
<script language=JavaScript for=EM_CAN_DT event=onKillFocus()>
    checkDateTypeYMD(EM_CAN_DT);
    if(EM_CAN_DT.Text.length == 8){
        EM_CAN_REASON.Enable = true;
        setTimeout("EM_CAN_REASON.Focus();",50);
    }else{
        EM_CAN_REASON.Enable = false;
        EM_CAN_REASON.Text   = "";
    }
</script>
<!-- 가맹점유형 OnSelChange() -->
<script language=JavaScript for=LC_BRCH_TYPE event=OnSelChange()>
    if(this.BindColVal == "51"){
        LC_SHORT_CD.style.display  = "";
        document.getElementById('subTitle1').style.display = "";
        document.getElementById('subTitle2').style.display = "";
    }else{
    	//getEtcCode("DS_STR",         "D", "P055", "N");        
        LC_SHORT_CD.style.display  = "none";
        document.getElementById('subTitle1').style.display = "none";
        document.getElementById('subTitle2').style.display = "none";
    }
    
    DS_STR.ClearData();
    if(this.BindColVal == "11"){    	
        getStore("DS_STR",   "N",   "", "N");
        LC_STR.BindColVal       = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition ,"STR_CD");        
    }else{
    	getEtcCode("DS_STR",         "D", "P055", "N"); 
    	LC_STR.BindColVal       = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition ,"STR_CD");
    }

</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== 공통콤보용 -->
<comment id="_NSID_">
<object id="DS_BRCH_TYPE_S" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_BRCH_TYPE" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CHAR_EMAIL2" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_STR" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_SHORT_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
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
<object id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>>
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
<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
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
						<th width="80">가맹점명</th>
						<td width="200"><comment id="_NSID_"> <object
							id=EM_BRCH_ID_S classid=<%=Util.CLSID_EMEDIT%> width=71
							tabindex=1 onKeyUp="javascript:keyPressEvent(event.keyCode);">
						</object> </comment> <script> _ws_(_NSID_);</script> <img id=IMG_BRCH_BTN
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							onclick="getBrchPop(EM_BRCH_ID_S,EM_BRCH_NAME_S)" /> <comment
							id="_NSID_"> <object id=EM_BRCH_NAME_S
							classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">사업자번호</th>
						<td width="150"><comment id="_NSID_"> <object
							id=EM_COMP_NO_S classid=<%=Util.CLSID_EMEDIT%> width=120
							tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">가맹점유형</th>
						<td><comment id="_NSID_"> <object id=LC_BRCH_TYPE_S
							classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=120 tabindex=1>
						</object> </comment> <script> _ws_(_NSID_);</script></td>
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
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=450 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="110" class="point">가맹점코드</th>
						<td><comment id="_NSID_"> <object
							id=EM_BRCH_ID classid=<%=Util.CLSID_EMEDIT%> width=71> </object>
						</comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_"> <object
							id=EM_BRCH_NAME classid=<%=Util.CLSID_EMEDIT%> width=180
							tabindex=1 onkeyup="javascript:checkByteStr(EM_BRCH_NAME, 40, '');"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="100" class="point">소속점포</th>
						<td><comment id="_NSID_"> <object
							id=LC_STR classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=125
							tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script> <comment
							id="_NSID_"> <object id=EM_STR_CD
							classid=<%=Util.CLSID_EMEDIT%> width=0> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width="100" class="point">가맹점유형</th>
						<td><comment id="_NSID_"> <object id=LC_BRCH_TYPE
							classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=125 tabindex=1>
						</object> </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_">
						<object id=EM_BRCH_TYPE classid=<%=Util.CLSID_EMEDIT%> width=0>
						</object> </comment> <script> _ws_(_NSID_);</script>&nbsp; <span id="subTitle1" style="display:none">( 단축코드 : </span><comment id="_NSID_"> <object id=LC_SHORT_CD
                            classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=65 tabindex=1>
                        </object> </comment> <script> _ws_(_NSID_);</script> <span id="subTitle2" style="display:none">)</span></td>
						<th width="100">계열사여부</th>
						<td><comment id="_NSID_"> <object id=RD_SCOMP_YN
							classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
							tabindex=1>
							<param name=Cols value="2">
							<param name=Format value="Y^예,N^아니오">
							<param name=CodeValue value="Y">
							<param name=AutoMargin value="true">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="100" class="point">대표자성명</th>
						<td><comment id="_NSID_"> <object id=EM_REP_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=120 onkeyup="javascript:checkByteStr(EM_REP_NAME, 40, '');" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="100">대표자주민번호</th>
						<td><comment id="_NSID_"> <object id=EM_REP_SSNO
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width="100" class="point">사업자번호</th>
						<td><comment id="_NSID_"> <object id=EM_COMP_NO
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="100">대표전화</th>
						<td><comment id="_NSID_"> <object id=EM_BRCH_PH1
							classid=<%=Util.CLSID_EMEDIT%> width=31 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						- <comment id="_NSID_"> <object id=EM_BRCH_PH2
							classid=<%=Util.CLSID_EMEDIT%> width=33 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						- <comment id="_NSID_"> <object id=EM_BRCH_PH3
							classid=<%=Util.CLSID_EMEDIT%> width=33 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width="100" class="point">담당자성명</th>
						<td><comment id="_NSID_"> <object id=EM_CHAR_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1 onkeyup="javascript:checkByteStr(EM_CHAR_NAME, 40, '');"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="100" class="point">담당자연락처</th>
						<td><comment id="_NSID_"> <object id=EM_CHAR_PH1
							classid=<%=Util.CLSID_EMEDIT%> width=31 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						- <comment id="_NSID_"> <object id=EM_CHAR_PH2
							classid=<%=Util.CLSID_EMEDIT%> width=33 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						- <comment id="_NSID_"> <object id=EM_CHAR_PH3
							classid=<%=Util.CLSID_EMEDIT%> width=33 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th class="point">담당자이메일</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_CHAR_EMAIL1 classid=<%=Util.CLSID_EMEDIT%> width=120
							tabindex=1 onkeyup="javascript:checkByteStr(EM_CHAR_EMAIL1, 50, '');"> </object> </comment> <script> _ws_(_NSID_);</script> @ <comment
							id="_NSID_"> <object id=LC_CHAR_EMAIL2
							classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=120 tabindex=1>
						</object> </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_">
						<object id=EM_CHAR_EMAIL2 classid=<%=Util.CLSID_EMEDIT%> width=158
							tabindex=1 onkeyup="javascript:checkByteStr(EM_CHAR_EMAIL2, 50, '');"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="100">개업일자</th>
						<td><comment id="_NSID_"> <object id=EM_OPEN_DT
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" id="IMG_OPEN_DT"
							onclick="javascript:openCal('G',EM_OPEN_DT)" /></td>
						<th width="100">해지일자</th>
						<td><comment id="_NSID_"> <object id=EM_CAN_DT
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" id="IMG_CAN_DT"
							onclick="javascript:openCal('G',EM_CAN_DT)" /></td>
					</tr>
					<tr>
						<th width="100">해지사유</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_CAN_REASON classid=<%=Util.CLSID_EMEDIT%> width=690
							tabindex=1 onkeyup="javascript:checkByteStr(EM_CAN_REASON, 400, '');"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="100" class="point">대표품목명</th>
						<td><comment id="_NSID_"> <object
							id=EM_REP_PUMMOK_NM classid=<%=Util.CLSID_EMEDIT%> width=120
							tabindex=1 onkeyup="javascript:checkByteStr(EM_REP_PUMMOK_NM, 40, '');"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="100" class="point">대표브랜드</th>
						<td><comment id="_NSID_"> <object
							id=EM_REP_BRAND_NM classid=<%=Util.CLSID_EMEDIT%> width=120
							tabindex=1 onkeyup="javascript:checkByteStr(EM_REP_BRAND_NM, 40, '');"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="100">업태</th>
						<td><comment id="_NSID_"> <object id=EM_BIZ_STAT
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1 onkeyup="javascript:checkByteStr(EM_BIZ_STAT, 40, '');"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="100">종목</th>
						<td><comment id="_NSID_"> <object id=EM_BIZ_CAT
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1 onkeyup="javascript:checkByteStr(EM_BIZ_CAT, 40, '');"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width="100">주소</th>
						<td colspan="3"><comment id="_NSID_"><object id=EM_BRCH_NEW_YN
                                classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle">
                            </object> </comment> <script> _ws_(_NSID_);</script><comment
							id="_NSID_"> <object id=EM_ZIP_CD1
							classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> - <comment
							id="_NSID_"> <object id=EM_ZIP_CD2
							classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/search_post_s.gif" align="absmiddle" tabindex=1 id="IMG_ZIP_CD"
							onclick="javascript:getPostPop_dcs(EM_ZIP_CD1,EM_ZIP_CD2, EM_BRCH_ADDR1,EM_BRCH_ADDR2,EM_BRCH_NEW_YN)"
							onkeydown="if(event.keyCode==13){getPostPopEnter_dcs(EM_ZIP_CD1,EM_ZIP_CD2, EM_BRCH_ADDR1,EM_BRCH_ADDR2,EM_BRCH_NEW_YN)}">
						<comment id="_NSID_"> <object id=EM_BRCH_ADDR1
							classid=<%=Util.CLSID_EMEDIT%> width=257 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script><comment
							id="_NSID_"> <object id=EM_BRCH_ADDR2
							classid=<%=Util.CLSID_EMEDIT%> width=268 tabindex=1
							align="absmiddle" onkeyup="javascript:checkByteStr(EM_BRCH_ADDR2, 200, '');"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="100" class="point">재무업체코드</th>
						<td><comment id="_NSID_"> <object id=EM_FINC_CD
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1 onkeyup="javascript:checkByteStr(EM_FINC_CD, 10, '');"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="100">가맹점입금예정일</th>
						<td>&nbsp;매월&nbsp; <comment id="_NSID_"> <object
							id=EM_BRCH_PAY_DAY classid=<%=Util.CLSID_EMEDIT%> width=20
							tabindex=1> </object> 일 </comment> <script> _ws_(_NSID_);</script></td>
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
  Gauce Bind Component Declaration

------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_HEADER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_DETAIL>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=BRCH_ID          ctrl=EM_BRCH_ID         Param=Text</c>
            <c>col=BRCH_NAME        ctrl=EM_BRCH_NAME       Param=Text</c>
            <c>col=STR_CD           ctrl=EM_STR_CD          Param=Text</c>
            <c>col=BRCH_TYPE        ctrl=EM_BRCH_TYPE       Param=Text</c>
            <c>col=SCOMP_YN         ctrl=RD_SCOMP_YN        Param=Text</c>
            <c>col=REP_NAME         ctrl=EM_REP_NAME        Param=Text</c>
            <c>col=REP_SSNO         ctrl=EM_REP_SSNO        Param=Text</c>
            <c>col=COMP_NO          ctrl=EM_COMP_NO         Param=Text</c>
            <c>col=BRCH_PH1         ctrl=EM_BRCH_PH1        Param=Text</c>
            <c>col=BRCH_PH2         ctrl=EM_BRCH_PH2        Param=Text</c>
            <c>col=BRCH_PH3         ctrl=EM_BRCH_PH3        Param=Text</c>
            <c>col=CHAR_NAME        ctrl=EM_CHAR_NAME       Param=Text</c>
            <c>col=CHAR_PH1         ctrl=EM_CHAR_PH1        Param=Text</c>
            <c>col=CHAR_PH2         ctrl=EM_CHAR_PH2        Param=Text</c>
            <c>col=CHAR_PH3         ctrl=EM_CHAR_PH3        Param=Text</c>
            <c>col=CHAR_EMAIL1      ctrl=EM_CHAR_EMAIL1     Param=Text</c>
            <c>col=CHAR_EMAIL2      ctrl=EM_CHAR_EMAIL2     Param=Text</c>
            <c>col=OPEN_DT          ctrl=EM_OPEN_DT         Param=Text</c>
            <c>col=CAN_DT           ctrl=EM_CAN_DT          Param=Text</c>
            <c>col=CAN_REASON       ctrl=EM_CAN_REASON      Param=Text</c>
            <c>col=REP_PUMMOK_NM    ctrl=EM_REP_PUMMOK_NM   Param=Text</c>
            <c>col=REP_BRAND_NM     ctrl=EM_REP_BRAND_NM    Param=Text</c>
            <c>col=BIZ_STAT         ctrl=EM_BIZ_STAT        Param=Text</c>
            <c>col=BIZ_CAT          ctrl=EM_BIZ_CAT         Param=Text</c>
            <c>col=ZIP_CD1          ctrl=EM_ZIP_CD1         Param=Text</c>
            <c>col=ZIP_CD2          ctrl=EM_ZIP_CD2         Param=Text</c>
            <c>col=BRCH_ADDR1       ctrl=EM_BRCH_ADDR1      Param=Text</c>
            <c>col=BRCH_ADDR2       ctrl=EM_BRCH_ADDR2      Param=Text</c>
            <c>col=FINC_CD          ctrl=EM_FINC_CD         Param=Text</c>
            <c>col=BRCH_PAY_DAY     ctrl=EM_BRCH_PAY_DAY    Param=Text</c>
            <c>col=SHORT_CD         ctrl=LC_SHORT_CD        Param=BindColVal</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
