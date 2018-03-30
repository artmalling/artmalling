<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽 운영 > 기준정보  > 적립율등록 
 * 작  성  일  : 2010.07.21
 * 작  성  자  : FKSS
 * 수  정  자  : 
 * 파  일  명  : dmbo1010.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *        
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
//var isFirstSearch     = 0;  // 마스터조회여부
var bfMasterRowPos = 0;       // 마스터조회여부
var LAST_MOD_ROW      = 0;
var strChk            ='U';
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
function doInit(){
    // Input, Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    initEmEdit(EM_COND_BRCH_ID,      "GEN^10", 	NORMAL);   //가맹점ID
    initEmEdit(EM_COND_BRCH_NAME,    "GEN^40", 	READ);     //가맹점명
    
    initEmEdit(EM_BRCH_ID,     "GEN^10",    	NORMAL);   //가맹점ID
    initEmEdit(EM_BRCH_NAME,   "GEN^40",    	READ);     //가맹점명   
    initEmEdit(EM_POINT_RATE,  "NUMBER^4^1",    NORMAL);
    initEmEdit(EM_MARGIN_A,    "NUMBER^3^0",    NORMAL);
    initEmEdit(EM_DC_A,        "NUMBER^3^0",    NORMAL);
    initEmEdit(EM_MARGIN_B,    "NUMBER^3^0",    NORMAL);
    initEmEdit(EM_DC_B,        "NUMBER^3^0",    NORMAL);
    initEmEdit(EM_MARGIN_C,    "NUMBER^3^0",    NORMAL);
    initEmEdit(EM_DC_C,        "NUMBER^3^0",    NORMAL);
    initEmEdit(EM_CASH_RATE,   "NUMBER^5^2",    NORMAL);
    initEmEdit(EM_JEHU_RATE,   "NUMBER^5^2",    NORMAL);
    initEmEdit(EM_JASA_RATE,   "NUMBER^5^2",    NORMAL);
    initEmEdit(EM_TASA_RATE,   "NUMBER^5^2",    NORMAL);
    initEmEdit(EM_JASAS_RATE,  "NUMBER^5^2",    NORMAL);
    initEmEdit(EM_TASAS_RATE,  "NUMBER^5^2",    NORMAL);
    initEmEdit(EM_JASAD_RATE,  "NUMBER^5^2",    NORMAL);
    initEmEdit(EM_TASAD_RATE,  "NUMBER^5^2",    NORMAL);
    initEmEdit(EM_START_DT,    "TODAY",         PK);   //-- 시작일자
    initEmEdit(EM_END_DT,      "YYYYMMDD",      NORMAL);   //-- 종료일자
 //   initEmEdit(EM_AMT,          "NUMBER^9^0",    NORMAL);
 //   initEmEdit(EM_FEE_RATE,          "NUMBER^9^1",    NORMAL);
 
    initComboStyle(LC_COND_POCARD_PREFIX, DS_COND_POCARD_PREFIX, "CODE^0^30, NAME^0^120", 1, PK);
    initComboStyle(LC_COND_POCARD_TYPE, DS_COND_POCARD_TYPE, "CODE^0^30, NAME^0^120", 1, NORMAL);
    initComboStyle(LC_COND_DC_GB, DS_COND_DC_GB, "CODE^0^30, NAME^0^120", 1, NORMAL);
    initComboStyle(LC_COND_CUST_GRADE,DS_O_CUST_GRADE_SEARCH, "CODE^0^30,NAME^0^120", 1, PK);
    
    initComboStyle(LC_POCARD_PREFIX, DS_POCARD_PREFIX, "CODE^0^30, NAME^0^120", 1, PK);
    initComboStyle(LC_POCARD_TYPE, DS_POCARD_TYPE, "CODE^0^30, NAME^0^120", 1, PK);
    initComboStyle(LC_DC_GB, DS_DC_GB, "CODE^0^30, NAME^0^120", 1, PK);
    initComboStyle(LC_HANDO_CHK, DS_HANDO_CHK, "CODE^0^30, NAME^0^120", 1, PK);
    initComboStyle(LC_CUST_GRADE,DS_O_CUST_GRADE, "CODE^0^30,NAME^0^120", 1, PK);

   // initComboStyle(LC_COND_STR_CD, DS_COND_STR_CD, "CODE^0^30, NAME^0^120", 1, PK);
 //   initComboStyle(LC_COND_BCOMP_CD, DS_COND_BCOMP_CD, "CODE^0^30, NAME^0^120", 1, NORMAL);
  //  initComboStyle(LC_COND_JBRCH_GB, DS_COND_JBRCH_GB, "CODE^0^30, NAME^0^120", 1, NORMAL);
  //  initComboStyle(LC_COND_RATE_GB, DS_COND_RATE_GB, "CODE^0^30,NAME^0^100", 1, NORMAL);
    
    initEmEdit(EM_S_START_DT,             "TODAY", PK);          //조회용 기준일
    initEmEdit(EM_S_END_DT,               "TODAY", PK);          //조회용 기준일
    
 //   initComboStyle(LC_STR_CD, DS_STR_CD, "CODE^0^30, NAME^0^120", 1, PK);
 //   initComboStyle(LC_BCOMP_CD, DS_BCOMP_CD, "CODE^0^30, NAME^0^120", 1, PK);
 //   initComboStyle(LC_JBRCH_GB, DS_JBRCH_GB, "CODE^0^30, NAME^0^120", 1, PK);
  //  initComboStyle(LC_FEE_RATE_GB, DS_FEE_RATE_GB, "CODE^0^30, NAME^0^120", 1, PK);
  //  initComboStyle(LC_INSTMONTH, DS_INSTMONTH, "CODE^0^30, NAME^0^120", 1, PK);
 //   initComboStyle( LC_TRUNC_GB, DS_TRUNC_GB, "CODE^0^30, NAME^0^120", 1, PK); 
    //
    
    getEtcCode("DS_COND_POCARD_PREFIX", "D", "D104", "Y");
    getEtcCode("DS_COND_POCARD_TYPE", "D", "D105", "Y");
    getEtcCode("DS_COND_DC_GB", "D", "D106", "Y");
    getEtcCode("DS_O_CUST_GRADE_SEARCH", "D", "D011", "Y");
    
    getEtcCode("DS_POCARD_PREFIX", "D", "D104", "N");
    getEtcCode("DS_POCARD_TYPE", "D", "D105", "N");
    getEtcCode("DS_DC_GB", "D", "D106", "N");
    getEtcCode("DS_HANDO_CHK", "D", "D107", "N");
    getEtcCode("DS_O_CUST_GRADE", "D", "D011", "N");
    
    
 //   getStore("DS_COND_STR_CD", "Y", "", "N");
 //   getBcompCode("DS_COND_BCOMP_CD", "", "", "Y");
 //   getStore("DS_STR_CD", "Y", "", "N");
//    getBcompCode("DS_BCOMP_CD", "", "", "N");
//    getEtcCode("DS_COND_JBRCH_GB", "D", "D101", "Y");   // 가맹점 구분(조회)
//    getEtcCode("DS_JBRCH_GB", "D", "D101", "N");   // 가맹점 구분
//    getEtcCode("DS_COND_RATE_GB", "D", "D102", "Y");   // 수수료 구분(조회)
//    getEtcCode("DS_FEE_RATE_GB", "D", "D102", "N");   // 수수료 구분
//    getEtcCode("DS_INSTMONTH", "D", "D103", "N");   // 할부개월수
//    getEtcCode("DS_TRUNC_GB", "D", "P021", "N");   // 끝전처리
    
    //초기값설정
  //  setComboData(LC_COND_STR_CD,  DS_COND_STR_CD.NameValue(0, "CODE"));
 //   setComboData(LC_COND_BCOMP_CD,  "%"); 
    //setComboData(LC_COND_JBRCH_GB,  "%"); 
    //setComboData(LC_COND_RATE_GB,  "%");
   
    //
     EM_END_DT.text = '99991231'; // 종료일자 초기화
   // LC_COND_RATE_GB.Index = 0; 
   // LC_JBRCH_GB.Index = 0; 
   // LC_COND_JBRCH_GB.Index = 0;
   
    LC_COND_POCARD_PREFIX.Index = 0; 
    LC_COND_POCARD_TYPE.Index = 0; 
    LC_COND_DC_GB.Index = 0;
    LC_COND_CUST_GRADE.Index = 0;
    LC_CUST_GRADE.Index = 0;
    
    EM_COND_BRCH_ID.Focus();

    
    EM_IN_UP_TYPE_H.style.display   = "none";
   // EM_STR_CD_H.style.display       = "none";
   // EM_BCOMP_CD_H.style.display     = "none";
    EM_JBRCH_ID_H.style.display     = "none";
    //
    showMaster();
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("101","DS_IO_MASTER,DS_IO_DETAIL");
}
function gridCreate1(){
	 var hdrProperies = '<FC>id={currow}           name="NO"               width=30    align=center edit=none</FC>'
	        + '<FC>id=BRCH_ID             name="가맹점ID"          width=86    align=center   show=false </FC>'
	        + '<FC>id=BRCH_NAME           name="가맹점명"          width=110   align=left     edit=none</FC>'
	        + '<FC>id=CUST_GRADE          name="고객등급"          width=110   align=center   edit=none show=false</FC>'
	        + '<FC>id=CUST_GRADE_NM       name="고객등급"          width=110   align=center   edit=none</FC>'
	        + '<FC>id=START_DT            name="시작일자"          width=90    align=center  mask="XXXX/XX/XX" edit=none</FC>'
	        + '<FC>id=END_DT              name="종료일자"          width=90    align=center  mask="XXXX/XX/XX" edit=none</FC>'	        
	        //+ '<FC>id=POCARD_NAME         name="패밀리카드구분"         width=110   align=left    edit=none</FC>'
	        //+ '<FC>id=POCARD_TYPE         name="패밀리카드구분코드" width=110   align=left     show=false</FC>'
	        //+ '<FC>id=POCARD_TYPE_NM      name="카드그룹"          width=110   align=left     edit=none</FC>'
	        //+ '<FC>id=DC_GB               name="DC구분코드"        width=110   align=left     show=false </FC>'
	        //+ '<FC>id=DC_GB_NM            name="에누리적용기준"            width=110   align=left     edit=none</FC>'
	        //+ '<FC>id=MARGIN_A            name="범위A"             width=110   align=right     edit=none</FC>'
	        //+ '<FC>id=DC_A                name="에누리율A"             width=110   align=right    edit=none</FC>'
	        //+ '<FC>id=MARGIN_B            name="범위B"             width=110   align=right     edit=none</FC>'
	        //+ '<FC>id=DC_B                name="에누리율B"             width=110   align=right     edit=none</FC>'
	        //+ '<FC>id=MARGIN_C            name="범위C"             width=110   align=right    edit=none</FC>'
	        //+ '<FC>id=DC_C                name="에누리율C"             width=110   align=right     edit=none</FC>'
	        + '<FC>id=CASH_RATE           name="현금적립율"        width=110   align=right     edit=none</FC>'
	        + '<FC>id=JEHU_CARD_RATE      name="제휴카드율"        width=110   align=right     edit=none</FC>'
	        + '<FC>id=JASA_CARD_RATE      name="자사카드율"        width=110   align=right     edit=none</FC>'
	        + '<FC>id=JASA_TICKET_RATE    name="자사상품권율"      width=110   align=right     edit=none</FC>'
	        + '<FC>id=TASA_CARD_RATE      name="타사카드율"        width=110   align=right     edit=none</FC>'
	        + '<FC>id=TASA_TICKET_RATE    name="타사상품권율"      width=110   align=right     edit=none</FC>'
	        + '<FC>id=JASA_DVD_RATE       name="자사분담율"        width=110   align=right     edit=none</FC>'
	        + '<FC>id=BRCH_DVD_RATE       name="가맹점분담율"      width=110   align=right     edit=none</FC>'
	        //+ '<FC>id=HANDO_CHK           name="한도체크코드"      width=110   align=left      show=false</FC>'
	        //+ '<FC>id=HANDO_CHK_NM        name="한도체크"          width=110   align=left     edit=true</FC>'
	        + '<FC>id=POINT_RATE          name="포인트배수"        width=110   align=right     edit=none</FC>'; 
         
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
			setTimeout("EM_BRCH_NAME.Focus();",50);
	        return false;
		}else{
	        strChangFlag = true;
	    }
    }
	strChk ='U';
    newData();
    //isFirstSearch = 0;
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
	  //      setTimeout("LC_STR_CD.Focus();",50);
	        return false;
	    }else{
	        strChangFlag = true;
	        if(DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "START_DT") == ""){
	            DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
	        }
	    }
	}
	
	DS_IO_MASTER.AddRow();
    DS_IO_DETAIL.ClearData();
    DS_IO_DETAIL.AddRow();
    strChk = 'I';
    
    EM_IN_UP_TYPE_H.text = "I";
    EM_POINT_RATE.Text = 1;
    EM_JASAD_RATE.Text = 100;

    newData(true);
    strChangFlag = false;
    EM_BRCH_ID.Focus();
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
	 
    if(trim(EM_BRCH_ID.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "가맹점");
        EM_BRCH_ID.Focus();
        return false;
    }
    
    if(trim(LC_CUST_GRADE.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "고객등급");
        LC_CUST_GRADE.Focus();
        return false;
    }    
/*    
    if(trim(LC_POCARD_PREFIX.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "패밀리카드구분");
        LC_POCARD_PREFIX.Focus();
        return false;
    }
     
    if(trim(LC_POCARD_TYPE.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "카드그룹");
        LC_POCARD_TYPE.Focus();
        return false;
    }
    
    if(trim(LC_DC_GB.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "에누리적용기준");
        LC_DC_GB.Focus();
        return false;
    }
    
    if(trim(LC_HANDO_CHK.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "한도체크");
        LC_HANDO_CHK.Focus();
        return false;
    } 
*/    
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
    
    if(EM_START_DT.text > EM_END_DT.text){   // 시작일자<=종료일자 정합성체크
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_END_DT.Focus();
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
 * btn_Excel()
 * 작   성   자 : 조형욱
 * 작   성   일 : 2010-02-22
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
 function btn_Excel() {
	 if (DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated) {
	    showMessage(Information, OK, "USER-1091");
    	setTimeout("EM_BRCH_NAME.Focus();",50);
        return false;
    }
	 
	 var parameters  = "점포명="+ LC_COND_STR_CD.Text;
	// parameters = EM_COND_JBRCH_ID.text.length > 0? parameters + " 가맹점번호="+ EM_COND_JBRCH_ID.text: parameters;
	 parameters = parameters + " 카드매입사="+ LC_COND_BCOMP_CD.Text;
	// parameters = parameters + " 무서명여부="+ RD_COND_SIGN_YN.DataValue;
	// parameters = parameters + " 제휴여부="+ RD_COND_JOIN_YN.DataValue;     
     var ExcelTitle = "가맹점번호 관리";
     
     openExcel2(GR_MASTER, ExcelTitle, parameters, true );
     
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
	var strBrchId           = EM_COND_BRCH_ID.Text;
	//var strPocardPrefix     = LC_COND_POCARD_PREFIX.BindColVal;
	var strCustGrade     	= LC_COND_CUST_GRADE.BindColVal;
	var strPocardType       = LC_COND_POCARD_TYPE.BindColVal;
	var strDcGb             = LC_COND_DC_GB.BindColVal;  
	var strFromPivotDt      = EM_S_START_DT.text;
	var strToPivotDt        = EM_S_END_DT.text;  
	
	DS_IO_MASTER.ClearData();
	bfMasterRowPos = 0;
	
    var parameters  = "&strBrchId=" 		  + encodeURIComponent(strBrchId)
                      //+ "&strPocardPrefix=" + encodeURIComponent(strPocardPrefix)
                      + "&strCustGrade=" 	  + encodeURIComponent(strCustGrade)
                      + "&strPocardType="     + encodeURIComponent(strPocardType)
                      + "&strDcGb=" 		  + encodeURIComponent(strDcGb)
                      + "&strFromPivotDt="    + encodeURIComponent(strFromPivotDt) 
    				  + "&strToPivotDt="      + encodeURIComponent(strToPivotDt) ;
    
    var goTo        = "searchMaster";    
    var action      = "O";
    TR_MAIN.Action  = "/dcs/dmbo101.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
    
    // 
    DS_IO_MASTER.RowPosition = LAST_MOD_ROW>0?LAST_MOD_ROW : DS_IO_MASTER.RowPosition;
    //isFirstSearch = 1;
    
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

	if(row == 0){
		DS_IO_DETAIL.ClearData();
		return;
	}
    var strBrchId   = DS_IO_MASTER.NameValue(row ,"BRCH_ID"); 
    //var strPocardPrefix = DS_IO_MASTER.NameValue(row ,"POCARD_PREFIX");
    var strCustGrade= DS_IO_MASTER.NameValue(row ,"CUST_GRADE");
    var strStartDt	= DS_IO_MASTER.NameValue(row ,"START_DT");

    var parameters  = "&strBrchId="  + encodeURIComponent(strBrchId)
                    //+ "&strPocardPrefix=" + strPocardPrefix;
    				+ "&strCustGrade=" + encodeURIComponent(strCustGrade)
    				+ "&strStartDt=" + encodeURIComponent(strStartDt);
                  
    var goTo        = "searchDetail";    
    var action      = "O";
    //TR_DETAIL.Action  = "/dcs/dmbo101.do?goTo="+goTo+parameters;
    TR_DETAIL.Action  = "/dcs/dmbo101.do?goTo="+goTo+parameters;  
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
    
    TR_MAIN.Action  = "/dcs/dmbo101.do?goTo=getStrmstCode";
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
    
    TR_MAIN.Action  = "/dcs/101.do?goTo=getCardcompCode";
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
 
function deleteMaster(){
    var goTo        = "deleteMaster";
    var action      = "I";  //조회는 O, 저장은 I
    TR_MAIN.Action  ="/dcs/101.do?goTo="+goTo;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER, O:DS_O_RESULT=DS_O_RESULT)"; 
    TR_MAIN.Post();
}
*/
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

    var strBrchId	= EM_BRCH_ID.Text;
    var strCustGrade= LC_CUST_GRADE.BindColVal;
    var strEndDt	= EM_END_DT.Text; 
    var strStartDt	= EM_START_DT.Text; 
    
    var parameters  = "&strChk="   +  encodeURIComponent(strChk)
    				+ "&strBrchId=" + encodeURIComponent(strBrchId)
    				+ "&strCustGrade=" + encodeURIComponent(strCustGrade)
					+ "&strStartDt=" + encodeURIComponent(strStartDt )    				
    				+ "&strEndDt=" + encodeURIComponent(strEndDt);   
    //alert(strChk);
    TR_SAVE_DETAIL.Action  ="/dcs/dmbo101.do?goTo="+goTo+parameters;   
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
function newData(flag) {
	EM_BRCH_ID.Enable   	= flag;
	LC_POCARD_PREFIX.Enable = flag;
    LC_POCARD_TYPE.Enable   = flag;
    LC_DC_GB.Enable 		= flag;
    LC_CUST_GRADE.Enable 	= flag;
    EM_START_DT.Enable 		= flag;    
    EM_CASH_RATE.Enable  	= flag;
    EM_JEHU_RATE.Enable  	= flag;
    EM_JASA_RATE.Enable  	= flag;
    EM_TASA_RATE.Enable  	= flag;
    EM_JASAS_RATE.Enable 	= flag;
    EM_TASAS_RATE.Enable 	= flag;
    EM_JASAD_RATE.Enable 	= flag;
    EM_TASAD_RATE.Enable 	= flag;
    EM_POINT_RATE.Enable 	= flag;    
    enableControl(IMG_BRCH_ID, flag);
}

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.02.24
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
    EM_BRCH_NAME.Text = "";//조건입력시 코드초기화
    if (EM_BRCH_ID.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_BRCH_ID.Text.length == 10) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_ID.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
                EM_BRCH_ID.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
                EM_BRCH_NAME.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getBrchPop(EM_BRCH_ID,EM_BRCH_NAME);
            }
        }
    }
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
    
    EM_BRCH_ID.Enable   = false;
    newData(false);
    /*
    EM_STR_CD_H.text    = LC_STR_CD.BindColVal;
    EM_BCOMP_CD_H.text  = LC_BCOMP_CD.BindColVal;
    EM_JBRCH_ID_H.text  = EM_JBRCH_ID.text;
    */
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
            setTimeout("EM_BRCH_NAME.Focus();",50);
            return false;
        }else {
            if(DS_IO_MASTER.NameValue(row, "START_DT") == "")
                DS_IO_MASTER.DeleteRow(row);
            return true;
        }
    }else{
         return true;
    }
</script>

<!--DS_O_MASTER  OnRowPosChanged(row)(row,colid)-->
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row,colid)>
	if( row < 1 || bfMasterRowPos == row)
    	return;
	bfMasterRowPos = row;
	
	showDetail();
</script>

<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>

</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->

<script language=JavaScript for=EM_START_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    var toDate = getTodayFormat('YYYYMMDD');
    if( !checkDateTypeYMD(this,toDate,"GR_MASTER","EM_START_DT"))
        return;
    //var appSDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EM_START_DT");
    var appEDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EM_END_DT");
    //var toDate = getTodayFormat('YYYYMMDD');
    //var yesterDay = getRawData(addDate('D',-1,getTodayFormat('YYYYMMDD')));
    if( toDate > this.Text){
        //showMessage(EXCLAMATION, OK,"USER-1030","적용종료일");
        showMessage(EXCLAMATION, OK, "USER-1000", "시작일자는 오늘 이후 일자만 가능 합니다.");
        //DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EM_END_DT") = "99991231";
        this.Text = toDate;
        return;
    }
    if( appEDt < this.Text){
        //showMessage(EXCLAMATION, OK,"USER-1008","적용종료일","적용시작일");
        showMessage(EXCLAMATION, OK, "USER-1000", "종료일자는 시작일자 보다 크거나 같아야 (시작일자 <= 종료일자) 합니다.");
        //DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EM_END_DT") = "99991231";
        this.Text = toDate;
        return;
    }
</script>	

<script language=JavaScript for=EM_END_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    if( !checkDateTypeYMD(this,'99991231',"GR_MASTER","EM_END_DT"))
        return;
    var appSDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EM_START_DT");
    var toDate = getTodayFormat('YYYYMMDD');
    var yesterDay = getRawData(addDate('D',-1,getTodayFormat('YYYYMMDD')));
    if( yesterDay > this.Text){
        //showMessage(EXCLAMATION, OK,"USER-1030","적용종료일");
        showMessage(EXCLAMATION, OK, "USER-1000", "종료일자는 어제 이후 일자만 가능 합니다.");
        //DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EM_END_DT") = "99991231";
        this.Text = "99991231";
        return;
    }
    if( appSDt > this.Text){
        //showMessage(EXCLAMATION, OK,"USER-1008","적용종료일","적용시작일");
        showMessage(EXCLAMATION, OK, "USER-1000", "종료일자는 시작일자 보다 크거나 같아야 (시작일자 <= 종료일자) 합니다.");
        //DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EM_END_DT") = "99991231";
        this.Text = "99991231";
        return;
    }
</script>	
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
<object id="DS_COND_POCARD_PREFIX" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_POCARD_TYPE" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_DC_GB" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_POCARD_PREFIX" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_POCARD_TYPE" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_DC_GB" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_HANDO_CHK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_CUST_GRADE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_CUST_GRADE_SEARCH" classid=<%=Util.CLSID_DATASET%>></object>
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
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80">가맹점</th>
						<td width="200"><comment id="_NSID_"> <object
							id=EM_COND_BRCH_ID classid=<%=Util.CLSID_EMEDIT%> width=72 tabindex=1
							onKeyUp="javascript:keyPressEvent(event.keyCode);"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							align="absmiddle" onclick="getBrchPop(EM_COND_BRCH_ID,EM_COND_BRCH_NAME)" />
						<comment id="_NSID_"> <object id=EM_COND_BRCH_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">고객등급</th>
						<td width="80"><comment id="_NSID_"> <object
								id=LC_COND_CUST_GRADE classid=<%=Util.CLSID_LUXECOMBO%> width=80
								tabindex=1></object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80" >기준일자</th>
						<td ><comment id="_NSID_"> <object
							id=EM_S_START_DT classid=<%=Util.CLSID_EMEDIT%> width=70
                            tabindex=1 align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
                        	<img src="/<%=dir%>/imgs/btn/date.gif"
                            onclick="javascript:openCal('G',EM_S_START_DT)" align="absmiddle" />- 
							<comment id="_NSID_"> <object
							id=EM_S_END_DT classid=<%=Util.CLSID_EMEDIT%> width=70
                            tabindex=1 align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
                        	<img src="/<%=dir%>/imgs/btn/date.gif"
                            onclick="javascript:openCal('G',EM_S_END_DT)" align="absmiddle" /></td>						
					</tr>
					<tr style="display:none">
				    	<th width="80">카드구분</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LC_COND_POCARD_TYPE classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=120 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">패밀리카드</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LC_COND_POCARD_PREFIX classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=120 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>								
						<th width="80">DC적용기준</th>
						<td><comment id="_NSID_"> <object id=LC_COND_DC_GB
							classid=<%=Util.CLSID_LUXECOMBO%> width=120 tabindex=1 align="absmiddle">
						</object> </comment> <script> _ws_(_NSID_);</script> </td>					
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
                <td><comment id="_NSID_"> <object id=GR_MASTER width="100%" height=200 classid=<%=Util.CLSID_GRID%> tabindex=1>
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
                <th width="100" class="point">가맹점</th>
                <td width="200"><comment id="_NSID_"> <object
							id=EM_BRCH_ID classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							onKeyUp="javascript:keyPressEvent(event.keyCode);"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_BRCH_ID"
							align="absmiddle" onclick="getBrchPop(EM_BRCH_ID,EM_BRCH_NAME)" />
						<comment id="_NSID_"> <object id=EM_BRCH_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
				</td>
                <th width="100" class="point">고객등급</th>
                <td colspan="3" width="170"><comment id="_NSID_"> <object
								id=LC_CUST_GRADE classid=<%=Util.CLSID_LUXECOMBO%> width=160
								tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
                 </td>
            </tr>
            <tr style="display:none">
                <th width="100" class="point">패밀리카드구분</th>
                <td><comment id="_NSID_">
                    <object  id=LC_POCARD_PREFIX classid=<%=Util.CLSID_LUXECOMBO%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td>
                <th width="100" class="point">카드그룹</th>
                <td colspan="3"><comment id="_NSID_">
                    <object  id=LC_POCARD_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td>             
            </tr>            
            <tr style="display:none">
                <th width="100" class="point">에누리적용기준</th>
                 <td><comment id="_NSID_">
                    <object  id=LC_DC_GB classid=<%=Util.CLSID_LUXECOMBO%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td>
                <th width="100" class="point">한도체크</th>
                 <td colspan="3"><comment id="_NSID_">
                    <object  id=LC_HANDO_CHK classid=<%=Util.CLSID_LUXECOMBO%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td>
            </tr>
            <tr style="display:none">
               <th width="100" >에누리-A</th>
                  <td><comment id="_NSID_"> 
                    <object id=EM_MARGIN_A classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
					<comment id="_NSID_"> <object id=EM_DC_A classid=<%=Util.CLSID_EMEDIT%> width=85 tabindex=1> </object> </comment> 
					<script> _ws_(_NSID_);</script>
				  </td> 
               <th width="100" >에누리-B</th>
                  <td ><comment id="_NSID_"> 
                    <object id=EM_MARGIN_B classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
					<comment id="_NSID_"> <object id=EM_DC_B classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1> </object> </comment> 
					<script> _ws_(_NSID_);</script>
				  </td>
               <th width="100" >에누리-C</th>
                  <td><comment id="_NSID_"> 
                    <object id=EM_MARGIN_C classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
					<comment id="_NSID_"> <object id=EM_DC_C classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1> </object> </comment> 
					<script> _ws_(_NSID_);</script>
				  </td>         
             </tr>
             <tr>
               <th width="100">현금율</th>
                 <td><comment id="_NSID_">
                    <object  id=EM_CASH_RATE classid=<%=Util.CLSID_EMEDIT%> width=157 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td> 
               <th width="100">제휴카드율</th>
                 <td width="170"><comment id="_NSID_">
                    <object  id=EM_JEHU_RATE classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td> 
               <th width="100">자사카드율</th>
                 <td ><comment id="_NSID_">
                    <object  id=EM_JASA_RATE classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td>        
             </tr> 
              <tr>
               <th width="100">타사카드율</th>
                 <td><comment id="_NSID_">
                    <object  id=EM_TASA_RATE classid=<%=Util.CLSID_EMEDIT%> width=157 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td> 
               <th width="100">자사상품권율</th>
                 <td width="160"><comment id="_NSID_">
                    <object  id=EM_JASAS_RATE classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td> 
               <th width="100">타사상품권율</th>
                 <td><comment id="_NSID_">
                    <object  id=EM_TASAS_RATE classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td>        
             </tr>                                  
             <tr> 
              <th width="100">자사분담율</th>
                 <td><comment id="_NSID_">
                    <object  id=EM_JASAD_RATE classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td> 
               <th width="100">가맹점분담율</th>
                 <td><comment id="_NSID_">
                    <object  id=EM_TASAD_RATE classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                    
                    <comment id="_NSID_"> <object id=EM_IN_UP_TYPE_H
                        classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object>
                    </comment> <script> _ws_(_NSID_);</script>
                    <comment id="_NSID_"> <object id=EM_JBRCH_ID_H
                        classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object>
                    </comment> <script> _ws_(_NSID_);</script>		
                 </td>       
                <th width="100">포인트배수</th>
                 <td><comment id="_NSID_">
                    <object  id=EM_POINT_RATE classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td>
            </tr>
            <tr>
               <th width="100" class="point">시작일자</th>
                   <td><comment id="_NSID_"> <object
                        id=EM_START_DT classid=<%=Util.CLSID_EMEDIT%> width=138 tabindex=1
                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                        src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                        onclick="javascript:openCal('G',EM_START_DT)" />
                    </td> 
                 <th width="100" class="point">종료일자</th>
                   <td colspan="3"><comment id="_NSID_"> <object
                        id=EM_END_DT classid=<%=Util.CLSID_EMEDIT%> width=138 tabindex=1
                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                        src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                        onclick="javascript:openCal('G',EM_END_DT)" />
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
            <c>col=BRCH_ID          ctrl=EM_BRCH_ID          Param=Text</c>
            <c>col=BRCH_NAME        ctrl=EM_BRCH_NAME        Param=Text</c>  
            <c>col=POCARD_PREFIX    ctrl=LC_POCARD_PREFIX    Param=BindColVal</c>
            <c>col=POCARD_TYPE      ctrl=LC_POCARD_TYPE      Param=BindColVal</c>
            <c>col=DC_GB            ctrl=LC_DC_GB            Param=BindColVal</c>
            <c>col=POINT_RATE       ctrl=EM_POINT_RATE       Param=Text</c>
            <c>col=HANDO_CHK        ctrl=LC_HANDO_CHK        Param=BindColVal</c>
            <c>col=MARGIN_A         ctrl=EM_MARGIN_A         Param=Text</c>
            <c>col=DC_A             ctrl=EM_DC_A             Param=Text</c>
            <c>col=MARGIN_B         ctrl=EM_MARGIN_B         Param=Text</c>
            <c>col=DC_B             ctrl=EM_DC_B             Param=Text</c>
            <c>col=MARGIN_C         ctrl=EM_MARGIN_C         Param=Text</c>
            <c>col=DC_C             ctrl=EM_DC_C             Param=Text</c>
            <c>col=CASH_RATE        ctrl=EM_CASH_RATE        Param=Text</c>
            <c>col=JEHU_CARD_RATE   ctrl=EM_JEHU_RATE        Param=Text</c>
            <c>col=JASA_CARD_RATE   ctrl=EM_JASA_RATE        Param=Text</c>
            <c>col=TASA_CARD_RATE   ctrl=EM_TASA_RATE        Param=Text</c>
            <c>col=JASA_TICKET_RATE ctrl=EM_JASAS_RATE       Param=Text</c>
            <c>col=TASA_TICKET_RATE ctrl=EM_TASAS_RATE       Param=Text</c>
            <c>col=START_DT         ctrl=EM_START_DT         Param=Text</c>
            <c>col=END_DT           ctrl=EM_END_DT           Param=Text</c>
            <c>col=JASA_DVD_RATE    ctrl=EM_JASAD_RATE       Param=Text</c>
            <c>col=BRCH_DVD_RATE    ctrl=EM_TASAD_RATE       Param=Text</c>
            <c>col=IN_UP_TYPE       ctrl=EM_IN_UP_TYPE_H     Param=Text</c>
            <c>col=JBRCH_ID_H       ctrl=EM_JBRCH_ID_H       Param=Text</c>
            <c>col=CUST_GRADE       ctrl=LC_CUST_GRADE       Param=BindColVal</c>
        '>

</object>
</comment>
<script>_ws_(_NSID_);</script>

</div>
<body>
</html> 
