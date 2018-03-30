<!-- 
/*******************************************************************************
 * 시스템명 : 카드 > 신용카드대금청구 > 코드관리 > 카드수수료율 관리
 * 작  성  일  : 2010.06.03
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : psal9070.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.06.03 (김영진) 신규작성
 *           2010.07.21 FKSS 수정
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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strFlag           = "INS";
var strChangFlag      = false;
var bfListRowPosition = 0;                             // 이전 List Row Position
var strBefore         = "";  
var strAfter          = "";
var intChangRow       = 0;
//
var isFirstSearch     = 0;  // 마스터조회여부
var LAST_MOD_ROW      = 0;
var strChk            ='U';
var g_strPid           = "<%=pageName%>";                 // PID

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-05-19
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
 
var LAST_MOD_ROW = 0;

function doInit(){
    // Input, Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    //initEmEdit(EM_COND_JBRCH_ID,    "GEN^15",        NORMAL);
    //
    //initEmEdit(EM_JBRCH_ID,         "GEN^15",        PK);
   // initEmEdit(EM_JBRCH_NM,         "GEN^40",        PK);
    initEmEdit(EM_START_DT,           "TODAY",       PK);   //-- 시작일자
    initEmEdit(EM_END_DT,        "YYYYMMDD",       PK);   //-- 종료일자
   //initEmEdit(EM_END_DT,        "ENDDATE",       PK);   //-- 종료일자
    initEmEdit(EM_AMT,          "NUMBER^9^0",    NORMAL);
    initEmEdit(EM_FEE_RATE,          "NUMBER^9^2",    NORMAL);
    //
    initComboStyle(LC_COND_STR_CD, DS_COND_STR_CD, "CODE^0^30, NAME^0^120", 1, PK);
    initComboStyle(LC_COND_BCOMP_CD, DS_COND_BCOMP_CD, "CODE^0^30, NAME^0^120", 1, PK);
    // 20120601 * DHL * 발급사코드 /카드종류 추가 -->
    initComboStyle(LC_COND_CCOMP_CD, DS_COND_CCOMP_CD, "CODE^0^30, NAME^0^120", 1, PK);
    initComboStyle(LC_COND_DCARD_TYPE, DS_COND_DCARD_TYPE, "CODE^0^30, NAME^0^80", 1, PK);
    // 20120601 * DHL * 발급사코드 /카드종류 추가 <--
    initComboStyle(LC_COND_JBRCH_GB, DS_COND_JBRCH_GB, "CODE^0^30, NAME^0^120", 1, NORMAL);
    initComboStyle(LC_COND_RATE_GB, DS_COND_RATE_GB, "CODE^0^30,NAME^0^100", 1, NORMAL);
    initEmEdit(EM_S_START_DT,             "TODAY", PK);          //조회용 기준일
    
    initComboStyle(LC_STR_CD, DS_STR_CD, "CODE^0^30, NAME^0^120", 1, PK);
    initComboStyle(LC_BCOMP_CD, DS_BCOMP_CD, "CODE^0^30, NAME^0^120", 1, PK);
    // 20120601 * DHL * 발급사코드 /카드종류 추가 -->
    initComboStyle(LC_CCOMP_CD, DS_CCOMP_CD, "CODE^0^30, NAME^0^120", 1, PK);
    initComboStyle(LC_DCARD_TYPE, DS_DCARD_TYPE, "CODE^0^20, NAME^0^80", 1, PK);
    // 20120601 * DHL * 발급사코드 /카드종류 추가 <--
    initComboStyle(LC_JBRCH_GB, DS_JBRCH_GB, "CODE^0^30, NAME^0^120", 1, PK);
    initComboStyle(LC_FEE_RATE_GB, DS_FEE_RATE_GB, "CODE^0^30, NAME^0^120", 1, PK);
    initComboStyle(LC_INSTMONTH, DS_INSTMONTH, "CODE^0^30, NAME^0^120", 1, PK);
    initComboStyle(LC_TRUNC_GB, DS_TRUNC_GB, "CODE^0^30, NAME^0^120", 1, PK); 
    
    
    
    
    //
    getStore("DS_COND_STR_CD", "Y", "", "N");
    getBcompCode("DS_COND_BCOMP_CD", "", "", "Y");
    // 20120601 * DHL * 발급사코드 /카드종류 추가 -->
    getCcompCode("DS_COND_CCOMP_CD", "", "", "Y");
    // 20120601 * DHL * 발급사코드 /카드종류 추가 <--

    getStore("DS_STR_CD", "Y", "", "N");
    getBcompCode("DS_BCOMP_CD", "", "", "N");
    // 20120601 * DHL * 발급사코드 /카드종류 추가 -->
    getCcompCode("DS_CCOMP_CD", "", "", "N");
    getEtcCode("DS_COND_DCARD_TYPE", "D", "D038", "Y");   // 가맹점 구분(조회)
    getEtcCode("DS_DCARD_TYPE", "D", "D038", "Y");   // 가맹점 구분(조회)
    // 20120601 * DHL * 발급사코드 /카드종류 추가 <--
    
    getEtcCode("DS_COND_JBRCH_GB", "D", "D101", "Y");   // 가맹점 구분(조회)
    getEtcCode("DS_JBRCH_GB", "D", "D101", "N");        // 가맹점 구분
    getEtcCode("DS_COND_RATE_GB", "D", "D102", "Y");    // 수수료 구분(조회)
    getEtcCode("DS_FEE_RATE_GB", "D", "D102", "N");     // 수수료 구분
    getEtcCode("DS_INSTMONTH", "D", "D103", "N");       // 할부개월수
    getEtcCode("DS_TRUNC_GB", "D", "P021", "N");        // 끝전처리
    
    
    
    
    //초기값설정
    setComboData(LC_COND_STR_CD,  DS_COND_STR_CD.NameValue(0, "CODE"));
    setComboData(LC_COND_BCOMP_CD,  "%");
    
    // 20120601 * DHL * 발급사코드 /카드종류 추가 -->
    setComboData(LC_COND_CCOMP_CD,  "%");
    setComboData(LC_COND_JBRCH_GB,  "%");
    setComboData(LC_COND_RATE_GB,  "%");
    
    LC_COND_BCOMP_CD.BindColVal = "%"; 
    LC_COND_CCOMP_CD.BindColVal = "%"; 
    LC_COND_DCARD_TYPE.BindColVal = "%"; 
    // 20120601 * DHL * 발급사코드 /카드종류 추가 <--
    
    // setComboData(LC_COND_JBRCH_GB,  "%"); 
    // setComboData(LC_COND_RATE_GB,  "%");
    
   
    //
    EM_END_DT.text = '99991231'; // 종료일자 초기화
    LC_COND_RATE_GB.Index = 0; 
    LC_JBRCH_GB.Index = 0; 
    LC_COND_JBRCH_GB.Index = 0;
    
    EM_IN_UP_TYPE_H.style.display   = "none";
    EM_STR_CD_H.style.display       = "none";
    EM_BCOMP_CD_H.style.display     = "none";
    // 20120601 * DHL * 카드발급사/카드종류  추가  -->
    EM_CCOMP_CD_H.style.display     = "none";
    EM_DCARD_TYPE_H.style.display   = "none";
    // 20120601 * DHL * 카드발급사/카드종류  추가  <--
    EM_JBRCH_ID_H.style.display     = "none";
    //
    
    
    showMaster();
    
    // 화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("psal907","DS_IO_MASTER,DS_IO_DETAIL");
}

function gridCreate1(){
  	var hdrProperies = '<FC>id={currow}             name="NO"            width=30   align=center  edit=none</FC>'
					    + '<FC>id=STR_CD            name="점포코드"       width=86    align=left    show=false </FC>'
					    + '<FC>id=STR_NM            name="점포명"         width=130   align=left    edit=none</FC>'
					    + '<FC>id=BCOMP_CD          name="매입사코드"     width=110   align=left    show=false</FC>'
					    + '<FC>id=BCOMP_NM          name="매입사명"       width=120   align=left    edit=none</FC>'
					    + '<FC>id=CCOMP_CD          name="발급사코드"     width=110   align=left    show=false</FC>'
					    + '<FC>id=CCOMP_NM          name="발급사명"       width=120   align=left    edit=none</FC>'
					    + '<FC>id=DCARD_TYPE        name="카드종류코드"   width=110   align=left    show=false</FC>'
					    + '<FC>id=DCARD_NM          name="카드종류"       width=120   align=left    edit=none</FC>'
					    + '<FC>id=JBRCH_GB          name="가맹점구분코드" width=120   align=left    show=false</FC>'
					    + '<FC>id=JBRCH_GB_NM       name="가맹점구분"     width=120   align=left    edit=none</FC>'
					    + '<FC>id=JBRCH_ID          name="가맹점번호"     width=120    align=left    edit=none</FC>'
					    + '<FC>id=JBRCH_NM          name="가맹점명"       width=110   align=left    edit=none</FC>'
					    + '<FC>id=FEE_RATE_GB       name="수수료구분코드" width=110   align=left   show=false</FC>' 
					    + '<FC>id=FEE_RATE_GB_NM    name="수수료구분"     width=110   align=left    edit=none</FC>' 
					    + '<FC>id=START_DT          name="시작일자"       width=90    align=center  mask="XXXX/XX/XX" edit=none</FC>'
					    + '<FC>id=END_DT            name="종료일자"       width=90    align=center  mask="XXXX/XX/XX" edit=none</FC>' 
					    + '<FC>id=INSTMONTH         name="할부개월"       width=90   align=right    edit=none</FC>'  
					    + '<FC>id=AMT               name="적용금액"       width=90   align=right    edit=none</FC>' 
					    + '<FC>id=FEE_RATE          name="수수료율"       width=94    align=right   edit=none</FC>'
					    + '<FC>id=TRUNC_GB          name="끝전처리"       width=94    align=right    edit=none</FC>'
					    + '<FC>id=TRUNC_GB_NM       name="끝전처리명"     width=94    align=left  edit=none</FC>'
		     ;
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, true);
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
  * 작 성 자     : 조형욱
  * 작 성 일     : 2010-02-10
  * 개       요     : 조회시 호출
  * return값 : void
  */
function btn_Search() {
	if (DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated) {
		if(showMessage(StopSign, YESNO, "USER-1059") != 1 ){
			//setTimeout("EM_JBRCH_NM.Focus();",50);
	        return false;
		}else{
	        strChangFlag = true;
	    }
    }
	strChk ='U';
    newData();
    isFirstSearch = 0;
    LAST_MOD_ROW = 0;
	//조회
	showMaster();
	
}
/**
 * btn_New()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-05-19
 * 개       요     :가맹점번호 등록 버튼 이벤트 처리
 * return값 : void
 */
function btn_New() {	
	if (DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated) {
	    if(showMessage(EXCLAMATION, YESNO, "USER-1072") != 1 ){
	        setTimeout("LC_STR_CD.Focus();",50);
	        return false;
	    }else{
	        strChangFlag = true;
	        if(DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "STR_NM") == ""){
	            DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
	        }
	    }
	}
	DS_IO_MASTER.AddRow();
    DS_IO_DETAIL.ClearData();
    DS_IO_DETAIL.AddRow();
    strChk = 'I';
    
    EM_IN_UP_TYPE_H.text = "I";
    //
    newData();
}

/**
 * btn_Save()
 * 작   성   자 : 조형욱
 * 작   성   일 : 2010-05-19
 * 개           요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {     
	if (!DS_IO_MASTER.IsUpdated && !DS_IO_DETAIL.IsUpdated) {
        return false;
	}
	 
    if(trim(LC_STR_CD.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
        LC_STR_CD.Focus();
        return false;
    }
    if(trim(LC_BCOMP_CD.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "매입사코드");
        LC_BCOMP_CD.Focus();
        return false;
    }
     
    if(trim(LC_CCOMP_CD.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "발급사코드");
        LC_BCOMP_CD.Focus();
        return false;
    }
     
    if(trim(LC_DCARD_TYPE.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "카드종류");
        LC_BCOMP_CD.Focus();
        return false;
    }
     
    if(trim(LC_JBRCH_GB.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "가맹점구분");
        LC_JBRCH_GB.Focus();
        return false;
    }
    
    if(trim(LC_FEE_RATE_GB.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "수수료구분");
        LC_FEE_RATE_GB.Focus();
        return false;
    }
    if(trim(EM_START_DT.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "시작일자");
        EM_START_DT.Focus();
        return false;
    }
    
    if(trim(EM_END_DT.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "종료일자");
        EM_END_DT.Focus();
        return false;
    }
    
    if(trim(LC_TRUNC_GB.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "끝전처리");
        LC_TRUNC_GB.Focus();
        return false;
    }
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ) {
        return;
    }
    
    saveDetail();
    
    //DS_IO_MASTER.RowPosition = bfListRowPosition;
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {	
	 //선택한 항목을 삭제하겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
        GR_MASTER.Focus();
        return;
    }    
    
     // 신규입력이있을 경우 데이터셋에서만 삭제
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD").length == 0){
        DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
        strChk = 'U';
        return;
    } 
    
    var strStrCd   = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STR_CD");
    var strSeq     = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SEQ");
    
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strSeq="  +encodeURIComponent(strSeq); 
    
    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);  
    
    TR_MAIN.Action="/dps/psal907.ps?goTo=delete"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_MAIN.Post();
    
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){        
        btn_Search();       
    }
}


/**
 * btn_Excel()
 * 작   성   자 : 조형욱
 * 작   성   일 : 2010-02-22
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
 function btn_Excel() {
	 if (DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated) {
	    showMessage(Information, OK, "USER-1091");
    	//setTimeout("EM_JBRCH_NM.Focus();",50);
        return false;
    }
	 
	 var parameters  = "점포명="+ LC_COND_STR_CD.Text;
	// parameters = EM_COND_JBRCH_ID.text.length > 0? parameters + " 가맹점번호="+ EM_COND_JBRCH_ID.text: parameters;
	 parameters = parameters + " 카드매입사="+ LC_COND_BCOMP_CD.Text;
	 
	// 20120601 * DHL * 발급사코드 /카드종류 추가 -->
	 parameters = parameters + " 카드발급사="+ LC_COND_CCOMP_CD.Text;
	 parameters = parameters + " 카드종류="+ LC_COND_DCARD_TYPE.Text;
	// 20120601 * DHL * 발급사코드 /카드종류 추가 <--
	
	// parameters = parameters + " 무서명여부="+ RD_COND_SIGN_YN.DataValue;
	// parameters = parameters + " 제휴여부="+ RD_COND_JOIN_YN.DataValue;     
     var ExcelTitle = "가맹점번호 관리";
     
     //openExcel2(GR_MASTER, ExcelTitle, parameters, true );
     openExcel5(GR_MASTER, ExcelTitle, parameters, true , "",g_strPid );

     
     GR_MASTER.Focus();
 }
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-05-23
 * 개       요     : 가맹점번호 리스트 조회 
 * return값 : void
 */
function showMaster(){           
    var paramStrCd      = LC_COND_STR_CD.BindColVal;
    var paramBcompCd    = LC_COND_BCOMP_CD.BindColVal;
    
    // 20120601 * DHL * 발급사코드 /카드종류 추가 -->
    var paramCcompCd    = LC_COND_CCOMP_CD.BindColVal;
    var paramDcardType  = LC_COND_DCARD_TYPE.BindColVal;
    // 20120601 * DHL * 발급사코드 /카드종류 추가 <--
    
    var paramJbrchGb    = LC_COND_JBRCH_GB.BindColVal;
    var paramFeeRateGb  = LC_COND_RATE_GB.BindColVal;  
    var paramPivotDt    = EM_S_START_DT.text;
    
    var parameters  = "&paramStrCd="   + encodeURIComponent(paramStrCd)
				    + "&paramBcompCd=" + encodeURIComponent(paramBcompCd)
				    // 20120601 * DHL * 발급사코드 /카드종류 추가 -->
				    + "&paramCcompCd=" + encodeURIComponent(paramCcompCd)
				    + "&paramDcardType=" + encodeURIComponent(paramDcardType)
				    // 20120601 * DHL * 발급사코드 /카드종류 추가 <--
				    + "&paramJbrchGb=" + encodeURIComponent(paramJbrchGb)
				    + "&paramFeeRateGb="  + encodeURIComponent(paramFeeRateGb)
				    + "&paramPivotDt="  + encodeURIComponent(paramPivotDt)
				    ;
    
    var goTo        = "searchMaster";    
    var action      = "O";
    TR_MAIN.Action  = "/dps/psal907.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
    
    // 
    DS_IO_MASTER.RowPosition = LAST_MOD_ROW>0?LAST_MOD_ROW : DS_IO_MASTER.RowPosition;
    isFirstSearch = 1;
    
    //showDetail();
}

/**
 * showDetail()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-02-22
 * 개       요     : 가맹점번호 상세 조회 
 * return값 : void
 */
function showDetail(){
	var row = DS_IO_MASTER.RowPosition;	 
    var paramStrCd   = DS_IO_MASTER.NameValue(row ,"STR_CD"); 
    var paramBcompCd = DS_IO_MASTER.NameValue(row ,"BCOMP_CD");
    
    // 20120601 * DHL * 발급사코드 /카드종류 추가 -->
    var paramCcompCd    = DS_IO_MASTER.NameValue(row ,"CCOMP_CD");
    var paramDcardType  = DS_IO_MASTER.NameValue(row ,"DCARD_TYPE");
    // 20120601 * DHL * 발급사코드 /카드종류 추가 <--
    
    var paramJbrchId = DS_IO_MASTER.NameValue(row ,"JBRCH_ID");


    var parameters  = "&paramStrCd="   + encodeURIComponent(paramStrCd)
                    + "&paramBcompCd=" + encodeURIComponent(paramBcompCd)
				    // 20120601 * DHL * 발급사코드 /카드종류 추가 -->
				    + "&paramCcompCd=" + encodeURIComponent(paramCcompCd)
				    + "&paramDcardType=" + encodeURIComponent(paramDcardType)
				    // 20120601 * DHL * 발급사코드 /카드종류 추가 <--
                    + "&paramJbrchId=" + encodeURIComponent(paramJbrchId);
    var goTo        = "searchDetail";    
    var action      = "O";
    TR_DETAIL.Action  = "/dps/psal907.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
}

function getStrmstCode(strDataSet, sysPart, commPart, allGb, nulGb, objComboNm) {
    DS_I_COMMON.setDataHeader('SYS_PART:STRING(1),COMM_PART:STRING(4),ALL_GB:STRING(1),NUL_GB:STRING(1)');
    
    DS_I_COMMON.ClearData();
    DS_I_COMMON.Addrow();
    DS_I_COMMON.NameValue(1, "SYS_PART")  = sysPart;
    DS_I_COMMON.NameValue(1, "COMM_PART") = commPart;
    DS_I_COMMON.NameValue(1, "ALL_GB")    = allGb ;
    DS_I_COMMON.NameValue(1, "NUL_GB")    = nulGb == null ? 'N' : nulGb ;
    
    TR_MAIN.Action  = "/dps/psal907.ps?goTo=getStrmstCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    
    //if (allGb == "Y") {
    if (typeof(objComboNm) == "object" ) objComboNm.index = '0';
    //}
}

function getCardcompCode(strDataSet, sysPart, commPart, allGb, nulGb, objComboNm) {
    DS_I_COMMON.setDataHeader('SYS_PART:STRING(1),COMM_PART:STRING(4),ALL_GB:STRING(1),NUL_GB:STRING(1)');
    
    DS_I_COMMON.ClearData();
    DS_I_COMMON.Addrow();
    DS_I_COMMON.NameValue(1, "SYS_PART")  = sysPart;
    DS_I_COMMON.NameValue(1, "COMM_PART") = commPart;
    DS_I_COMMON.NameValue(1, "ALL_GB")    = allGb ;
    DS_I_COMMON.NameValue(1, "NUL_GB")    = nulGb == null ? 'N' : nulGb ;
    
    TR_MAIN.Action  = "/dps/psal907.ps?goTo=getCardcompCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    
    //if (allGb == "Y") {
    if (typeof(objComboNm) == "object" ) objComboNm.index = '0';
    //}
}


/**
 * deleteMaster()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-05-19
 * 개       요     : 가맹점번호 삭제
 * return값 : void
 */
function deleteMaster(){
    var goTo        = "deleteMaster";
    var action      = "I";  //조회는 O, 저장은 I
    TR_MAIN.Action  ="/dps/psal907.ps?goTo="+goTo;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER, O:DS_O_RESULT=DS_O_RESULT)"; 
    TR_MAIN.Post();
}

/**
 * saveDetail()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-05-19
 * 개       요     : 상세내역 저장
 * return값 : void
 */
function saveDetail(){
    var goTo        = "saveDetail";
    var action      = "I";  //조회는 O, 저장은 I
    
    //
    //LAST_MOD_ROW = DS_IO_MASTER.RowPosition;
    
    //상세조회
    if(DS_IO_MASTER.RowPosition != 0 && EM_IN_UP_TYPE_H.text != "I"){
        LAST_MOD_ROW = DS_IO_MASTER.RowPosition;
    }
    //
    var parameters  = "&strChk="   +  encodeURIComponent(strChk) ;
   
    TR_SAVE_DETAIL.Action  ="/dps/psal907.ps?goTo="+goTo+parameters;   
    TR_SAVE_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL, O:DS_O_RESULT=DS_O_RESULT)"; 
    TR_SAVE_DETAIL.Post(); 
    
    strChk = 'U';
}

/**
 * newData()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-05-19
 * 개       요    :
 * return값 : void
 */
function newData() {
	LC_STR_CD.Enable   = true;
    LC_BCOMP_CD.Enable = true;
    
    // 20120601 * DHL * 카드발급사/카드종류 추가 -->
    LC_CCOMP_CD.Enable = true;
    LC_DCARD_TYPE.Enable = true;
 	// 20120601 * DHL * 카드발급사/카드종류 추가 <--
    
    LC_FEE_RATE_GB.Enable = true;
    LC_JBRCH_GB.Enable = true;
    
    EM_START_DT.Enable = true;
    enableControl(IMG_START_DT, true);
    //
 //   RD_SIGN_YN.CodeValue = "N";
 //   RD_JOIN_YN.CodeValue = "N";
 //   RD_DEL_YN.CodeValue  = "N";
    //
    strChangFlag = false;
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                            *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                         *-->
<!--*    1. TR Success 메세지 처리                                        *-->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        var strMsg = TR_MAIN.SrvErrMsg('UserMsg',i).split('|');
        //EM_BRCH_ID.Text = strMsg[0]; 
        showMessage(INFORMATION, OK, "USER-1000", strMsg[0]);
    }
</script>
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        var strMsg = TR_DETAIL.SrvErrMsg('UserMsg',i).split('|');
        //EM_BRCH_ID.Text = strMsg[0]; 
        showMessage(INFORMATION, OK, "USER-1000", strMsg[0]);
    }
    /*
    EM_STR_CD_H.text    = LC_STR_CD.BindColVal;
    EM_BCOMP_CD_H.text  = LC_BCOMP_CD.BindColVal;
    EM_JBRCH_ID_H.text  = EM_JBRCH_ID.text;
    */
    //
    LC_STR_CD.Enable = false;
    LC_BCOMP_CD.Enable = false;
    // 20120601 * DHL * 카드발급사/카드종류 추가 -->
    LC_CCOMP_CD.Enable = false;
    LC_DCARD_TYPE.Enable = false;
 	// 20120601 * DHL * 카드발급사/카드종류 추가 <--
    LC_FEE_RATE_GB.Enable = false;
    LC_JBRCH_GB.Enable = false;
    EM_START_DT.Enable = false;
    enableControl(IMG_START_DT, false);
    //
</script>

<script language=JavaScript for=TR_SAVE_DETAIL event=onSuccess>
    for(i=0;i<TR_SAVE_DETAIL.SrvErrCount('UserMsg');i++) {
        var strMsg = TR_SAVE_DETAIL.SrvErrMsg('UserMsg',i).split('|');
        //EM_BRCH_ID.Text = strMsg[0]; 
        showMessage(INFORMATION, OK, "USER-1000", strMsg[0]);
    }
    
    showMaster();
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<script language=JavaScript for=TR_SAVE_DETAIL event=onFail>
    trFailed(TR_SAVE_DETAIL.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=onColumnChanged(row,colid)>
    var orgValue      = DS_IO_MASTER.OrgNameValue(row,colid);
    var newValue      = DS_IO_MASTER.NameValue(row,colid);
</script>
<!--DS_O_MASTER  CanRowPosChange(row)-->
<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
//alert(strChangFlag +","+ DS_IO_MASTER.IsUpdated +","+ DS_IO_DETAIL.IsUpdated);
    if ( strChangFlag == false && (DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated)){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            //setTimeout("EM_JBRCH_NM.Focus();",50);
            return false;
        }else {
            if(DS_IO_MASTER.NameValue(row, "STR_NM") == "")
                DS_IO_MASTER.DeleteRow(row);
            return true;
        }
    }else{
         return true;
    }
</script>

<!--DS_O_MASTER  OnRowPosChanged(row)(row,colid)-->
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row,colid)>

	showDetail();
</script>

<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    //sortColId( eval(this.DataID), row, colid);
    //if (row != 0 && colid == "DEL_YN") {
    	//DS_IO_MASTER.NameValue(row, colid) = DS_IO_MASTER.NameValue(row, colid) == "Y"? "N":"Y";
    //}

</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리    끝                                                *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                    *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_STR_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_BCOMP_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 20120601 * DHL * 발급사코드/카드종류 추가  START --> 
<comment id="_NSID_">
<object id="DS_COND_CCOMP_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_DCARD_TYPE" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- 20120601 * DHL * 발급사코드/카드종류 추가   END  -->

<comment id="_NSID_">
<object id="DS_COND_JBRCH_GB" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_RATE_GB" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_BCOMP_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 20120601 * DHL * 발급사코드/카드종류 추가  START --> 
<comment id="_NSID_">
<object id="DS_CCOMP_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_DCARD_TYPE" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- 20120601 * DHL * 발급사코드/카드종류 추가   END  -->

<comment id="_NSID_">
<object id="DS_JBRCH_GB" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_FEE_RATE_GB" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_INSTMONTH" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_TRUNC_GB" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
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

<comment id="_NSID_">
<object id="TR_SAVE_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* E. 본문시작                                                            *-->
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
                <td><!-- search start -->
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                    <tr>
                        <th width="100" class="point">점포명</th>
                        <td width="105"><comment id="_NSID_"> 
                            <object id=LC_COND_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=102 align="absmiddle" tabindex=1> 
                            </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width="100" >매입사코드</th>
                        <td width="105"><comment id="_NSID_"> 
                            <object id=LC_COND_BCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=102 align="absmiddle" tabindex=1> 
                            </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width="100" >발급사코드</th>
                        <td width="105"><comment id="_NSID_"> 
                            <object id=LC_COND_CCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=115 align="absmiddle" tabindex=1> 
                            </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width="100" >카드종류</th>
                        <td><comment id="_NSID_"> 
                            <object id=LC_COND_DCARD_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=89 align="absmiddle" tabindex=1> 
                            </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <th width="100">가맹점구분</th>
                        <td width="105"><comment id="_NSID_"> 
                            <object id=LC_COND_JBRCH_GB classid=<%=Util.CLSID_LUXECOMBO%> width=102 align="absmiddle" tabindex=1> 
                            </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width="100">수수료구분</th>
						<td width="105"><comment id="_NSID_"> <object
							id=LC_COND_RATE_GB classid=<%=Util.CLSID_LUXECOMBO%> width=102
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="100" class="point">기준일자</th>
						<td colspan="3"><comment id="_NSID_"> <object
							 id=EM_S_START_DT classid=<%=Util.CLSID_EMEDIT%> width=115
                            tabindex=1 align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif"
                            onclick="javascript:openCal('G',EM_S_START_DT)" align="absmiddle" />                       
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
    
    <tr>
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"> <object id=GR_MASTER width="100%" height=378 classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_IO_MASTER">
                </object> </comment> <script>_ws_(_NSID_);</script></td>
            </tr>
        </table>
        </td>
    </tr>   
    
    <tr>
        <td class="PT01">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            <tr>
                <th width="100" class="point">점포명</th>
                <td width="160"><comment id="_NSID_"> 
                    <object id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=160 tabindex=1></object> </comment> 
                    <script> _ws_(_NSID_);</script> 
                </td>
                <th width="100" class="point">카드매입사</th>
                <td width="160"><comment id="_NSID_">
                    <object  id=LC_BCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                </td>
                <th width="100" class="point">카드발급사</th>
                <td width="160"><comment id="_NSID_">
                    <object  id=LC_CCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                </td>
            </tr>
            <tr>
				<th width="80" class="point">카드종류</th>
				<td width="150"><comment id="_NSID_"> <object
					id=LC_DCARD_TYPE classid=<%=Util.CLSID_LUXECOMBO%> height=100
					width=160 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
				</td>
                <th width="100" class="point">가맹점구분</th>
                <td width="160"><comment id="_NSID_">
                    <object  id=LC_JBRCH_GB classid=<%=Util.CLSID_LUXECOMBO%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td>
                <th width="100" class="point">수수료구분</th>
                <td width="160"><comment id="_NSID_">
                    <object  id=LC_FEE_RATE_GB classid=<%=Util.CLSID_LUXECOMBO%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td>
            </tr>
            <tr>
                 <th width="80" class="point">시작일자</th>
                   <td><comment id="_NSID_"> <object
                        id=EM_START_DT classid=<%=Util.CLSID_EMEDIT%> width=113 tabindex=1
                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                        src="/<%=dir%>/imgs/btn/date.gif" id="IMG_START_DT" align="absmiddle"
                        onclick="javascript:openCal('G',EM_START_DT)" />
                    </td> 
                 <th width="80" class="point">종료일자</th>
                   <td><comment id="_NSID_"> <object
                        id=EM_END_DT classid=<%=Util.CLSID_EMEDIT%> width=113 tabindex=1
                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                        src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                        onclick="javascript:openCal('G',EM_END_DT)" />
                 </td> 
               <th width="100" class="point">할부개월</th>
                <td width="160"><comment id="_NSID_">
                    <object  id=LC_INSTMONTH classid=<%=Util.CLSID_LUXECOMBO%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td>     
                    
             </tr>       
             <tr> 
               <th width="100">적용금액</th>
                 <td><comment id="_NSID_">
                    <object  id=EM_AMT classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td> 
               <th width="100">수수료율</th>
                 <td><comment id="_NSID_">
                    <object  id=EM_FEE_RATE classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td>           
               <th width="100" class="point">끝전처리</th>
                <td width="160"><comment id="_NSID_">
                    <object  id=LC_TRUNC_GB classid=<%=Util.CLSID_LUXECOMBO%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>

                    <comment id="_NSID_"> <object id=EM_IN_UP_TYPE_H
                        classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object>
                    </comment> <script> _ws_(_NSID_);</script>
                    <comment id="_NSID_"> <object id=EM_STR_CD_H
                        classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object>
                    </comment> <script> _ws_(_NSID_);</script>
                    <comment id="_NSID_"> <object id=EM_BCOMP_CD_H
                        classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object>
                    </comment> <script> _ws_(_NSID_);</script>
                    <comment id="_NSID_"> <object id=EM_CCOMP_CD_H
                        classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object>
                    </comment> <script> _ws_(_NSID_);</script>
                    <comment id="_NSID_"> <object id=EM_DCARD_TYPE_H
                        classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object>
                    </comment> <script> _ws_(_NSID_);</script>
                    <comment id="_NSID_"> <object id=EM_JBRCH_ID_H
                        classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object>
                    </comment> <script> _ws_(_NSID_);</script>		                    

                 </td>
            </tr>
        </table>
        </td>
    </tr> 
    
</table>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_DETAIL classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_IO_DETAIL>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            <c>col=STR_CD           ctrl=LC_STR_CD       Param=BindColVal</c>
            <c>col=BCOMP_CD         ctrl=LC_BCOMP_CD     Param=BindColVal</c>
            <c>col=CCOMP_CD         ctrl=LC_CCOMP_CD     Param=BindColVal</c>
            <c>col=DCARD_TYPE       ctrl=LC_DCARD_TYPE   Param=BindColVal</c>
            <c>col=JBRCH_GB         ctrl=LC_JBRCH_GB     Param=BindColVal</c>
            <c>col=FEE_RATE_GB      ctrl=LC_FEE_RATE_GB  Param=BindColVal</c>
            <c>col=START_DT         ctrl=EM_START_DT     Param=Text</c>
            <c>col=END_DT           ctrl=EM_END_DT       Param=Text</c>
            <c>col=INSTMONTH        ctrl=LC_INSTMONTH    Param=BindColVal</c>
            <c>col=AMT              ctrl=EM_AMT          Param=Text</c>
            <c>col=FEE_RATE         ctrl=EM_FEE_RATE     Param=Text</c>
            <c>col=TRUNC_GB         ctrl=LC_TRUNC_GB     Param=BindColVal</c> 
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</div>
<body>
</html> 
