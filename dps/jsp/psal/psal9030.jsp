<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 신용카드대금청구 > 코드관리 > 가맹점번호관리
 * 작  성  일  : 2010.05.19
 * 작  성  자  : 조형욱
 * 수  정  자  : 
 * 파  일  명  : psal9030.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.05.23 (조형욱) 신규작성
 *           2011.08.03 FKSS
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
function doInit(){
    // Input, Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_PAY_DAY,          "NUMBER^1^0",         NORMAL);
    initEmEdit(EM_JBRCH_ID,         "000000000000000",    PK);
    initEmEdit(EM_JBRCH_NM,         "GEN^40",        NORMAL);
    initEmEdit(EM_SIGN_AMT,         "NUMBER^9^0",         NORMAL);
    //
    initComboStyle(LC_COND_STR_CD, DS_COND_STR_CD, "CODE^0^30, NAME^0^120", 1, PK);
    initComboStyle(LC_COND_BCOMP_CD, DS_COND_BCOMP_CD, "CODE^0^30, NAME^0^120", 1, NORMAL);
    initComboStyle(LC_COND_JBRCH_TYPE, DS_JBRCH_TYPE, "CODE^0^30, NAME^0^120", 1, NORMAL);
    initComboStyle(LC_STR_CD, DS_STR_CD, "CODE^0^30, NAME^0^120", 1, PK);
    initComboStyle(LC_BCOMP_CD, DS_BCOMP_CD, "CODE^0^30, NAME^0^120", 1, PK);
    initComboStyle(LC_JBRCH_TYPE, DS_JBRCH_TYPE_D, "CODE^0^30, NAME^0^120", 1, PK);
    initComboStyle(LC_JBRCH_GB, DS_JBRCH_GB, "CODE^0^30, NAME^0^120", 1, PK);

    //
    getStore("DS_COND_STR_CD",   "Y",   "", "N");
    getBcompCode("DS_COND_BCOMP_CD",  "", "", "Y");
    getEtcCode("DS_JBRCH_TYPE",  "D",  "D070", "Y");
    getEtcCode("DS_JBRCH_TYPE_D","D",  "D070", "N");
    getStore("DS_STR_CD", "Y", "", "N");
    getBcompCode("DS_BCOMP_CD", "", "", "N");
    getEtcCode("DS_JBRCH_GB", "D", "D101", "N");
    
    //초기값설정
    setComboData(LC_COND_STR_CD,  DS_COND_STR_CD.NameValue(0, "CODE"));
    setComboData(LC_COND_BCOMP_CD,    "%"); 
    setComboData(LC_COND_JBRCH_TYPE,  "%"); 
    setComboData(LC_JBRCH_GB,  "%"); 
    //
    EM_IN_UP_TYPE_H.style.display   = "none";
    EM_STR_CD_H.style.display       = "none";
    EM_BCOMP_CD_H.style.display     = "none";
    EM_JBRCH_ID_H.style.display     = "none";
    
    LC_JBRCH_TYPE.Index = 0;
    //
    showMaster();
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("psal903","DS_IO_MASTER,DS_IO_DETAIL");
}

function gridCreate1(){
    var hdrProperies    = '<FC>id={currow}      name="NO"              width=30     align=center edit=none</FC>'
                        + '<FC>id=STR_NAME      name="점포명"           width=100    align=left edit=none</FC>'
                        + '<FC>id=BCOMP_NM      name="매입사명"         width=80    align=left edit=none</FC>'
                        + '<FC>id=JBRCH_ID      name="가맹점번호"       width=100    align=center edit=none</FC>'
                        + '<FC>id=JBRCH_GB_NM   name="가맹점구분"       width=100    align=center edit=none</FC>'
                        + '<FC>id=JBRCH_TYPE    name="가맹점종류"       width=110    align=left  show=false</FC>'
                        + '<FC>id=JBRCH_TYPE_NM name="가맹점종류"       width=70     align=center edit=none</FC>'
                        + '<FC>id=JBRCH_NM      name="가맹점명"         width=110    align=left edit=none</FC>'
                        + '<FC>id=SIGN_YN       name="무서명여부"       width=65     align=center edit=none</FC>'
                        + '<FC>id=SIGN_AMT      name="무서명한도금액"   width=95    align=right edit=none</FC>'
                        + '<FC>id=PAY_DAY       name="입금소요일"       width=70     align=right edit=none</FC>'
                        + '<FC>id=DEL_YN        name="삭제여부"         width=60     align=center edit=none</FC>';
                        //+ '<FC>id=DEL_YN        name="삭제여부"          width=80     align=center Value={IF(DEL_YN="Y","T","F")} Edit={IF("1"="1","T","F")} EditStyle=CheckBox  </FC>';
                     
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
			setTimeout("LC_JBRCH_TYPE.Focus();",50);
	        return false;
		}else{
	        strChangFlag = true;
	    }
    }
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
	        if(DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "STR_NAME") == ""){
	            DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
	        }
	    }
	}
	DS_IO_MASTER.AddRow();
    DS_IO_DETAIL.ClearData();
    DS_IO_DETAIL.AddRow();    
    
    EM_IN_UP_TYPE_H.text = "I"; //저장구분(신규:I, 수정:U)
    isFirstSearch = 0;          
    LAST_MOD_ROW = 0;
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
		 //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
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
    if(trim(EM_JBRCH_ID.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "가맹점번호");
        EM_JBRCH_ID.Focus();
        return false;
    }
    if(trim(LC_JBRCH_GB.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "가맹점구분");
        LC_JBRCH_GB.Focus();
        return false;
    }
    
    if(trim(EM_JBRCH_NM.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "가맹점명");
        
        EM_JBRCH_NM.Focus();
        return false;
    }
    /*
    if(trim(EM_JBRCH_ID.text).length != 15){
        showMessage(EXCLAMATION, OK, "USER-1003",  "가맹점번호");
        EM_JBRCH_ID.Focus();
        return false;
    }
    */
    if(trim(LC_JBRCH_TYPE.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "가맹점종류");
        LC_JBRCH_TYPE.Focus();
        return false;
    }
    if(trim(RD_SIGN_YN.CodeValue).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "무서명여부");
        RD_SIGN_YN.Focus();
        return false;
    }
    if(RD_SIGN_YN.CodeValue == "Y" && (trim(EM_SIGN_AMT.text).length == 0 || parseInt(EM_SIGN_AMT.text) < 1)){
        showMessage(EXCLAMATION, OK, "USER-1003",  "무서명한도금액");
        EM_SIGN_AMT.Focus();
        return false;
    }
    if (parseInt(EM_SIGN_AMT.text) < parseInt(0)) {
        showMessage(EXCLAMATION, OK, "USER-1000", "무서명한도금액은 (-)금액을 입력 할 수 없습니다.");
        EM_SIGN_AMT.Focus();
        return;
    } 
    if(trim(EM_PAY_DAY.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "입금소요일");
        EM_PAY_DAY.Focus();
        return false;
    }
    if (parseInt(EM_PAY_DAY.text) < parseInt(0)) {
        showMessage(EXCLAMATION, OK, "USER-1000", "입금소요일은 (-)로 입력 할 수 없습니다.");
        EM_PAY_DAY.Focus();
        return;
    } 
    if(trim(RD_DEL_YN.CodeValue).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "삭제여부");
        RD_DEL_YN.Focus();
        return false;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ) {
        return;
    }
    
    saveDetail();    
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
    	setTimeout("LC_JBRCH_TYPE.Focus();",50);
        return false;
    }
	 
	 var parameters  = "점포명="+ LC_COND_STR_CD.Text;
	 parameters = parameters + " 카드매입사="+ LC_COND_BCOMP_CD.Text;
	 parameters = parameters + " 무서명여부="+ RD_COND_SIGN_YN.DataValue;
	 parameters = parameters + " 가맹점종류="+ LC_COND_JBRCH_TYPE.BindColVal;     
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
    var paramJbrchType  = LC_COND_JBRCH_TYPE.BindColVal;
    var paramSignyn     = RD_COND_SIGN_YN.CodeValue;
    var parameters  = "&paramStrCd="     + encodeURIComponent(paramStrCd)
				    + "&paramBcompCd="   + encodeURIComponent(paramBcompCd)
				    + "&paramJbrchType=" + encodeURIComponent(paramJbrchType)
				    + "&paramSignyn="    + encodeURIComponent(paramSignyn);
    
    var goTo        = "searchMaster";    
    var action      = "O";
    TR_MAIN.Action  = "/dps/psal903.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
    
    // 
    DS_IO_MASTER.RowPosition = LAST_MOD_ROW>0?LAST_MOD_ROW : DS_IO_MASTER.RowPosition;
    isFirstSearch = 1;
    
    LC_JBRCH_GB.Enable = false;
    
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
    var paramStrCd     = DS_IO_MASTER.NameValue(row ,"STR_CD"); 
    var paramBcompCd   = DS_IO_MASTER.NameValue(row ,"BCOMP_CD");
    var paramJbrchId   = DS_IO_MASTER.NameValue(row ,"JBRCH_ID");
    var paramJbrchType = DS_IO_MASTER.NameValue(row ,"JBRCH_TYPE");
    var parameters  = "&paramStrCd="     + encodeURIComponent(paramStrCd)
                    + "&paramBcompCd="   + encodeURIComponent(paramBcompCd)
                    + "&paramJbrchId="   + encodeURIComponent(paramJbrchId)
                    + "&paramJbrchType=" + encodeURIComponent(paramJbrchType);
    var goTo        = "searchDetail";    
    var action      = "O";
    TR_DETAIL.Action  = "/dps/psal903.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
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
    TR_MAIN.Action  ="/dps/psal903.ps?goTo="+goTo;   
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
   
    if  (isFirstSearch > 0) {
    	 LAST_MOD_ROW = DS_IO_MASTER.RowPosition;
    }
    
  //  var strJbrchNm = LC_STR_CD.Text + " " + LC_BCOMP_CD.Text + " " + LC_JBRCH_TYPE.Text; 
   // DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "JBRCH_NM") = strJbrchNm;
    //
    TR_SAVE_DETAIL.Action  ="/dps/psal903.ps?goTo="+goTo;   
    TR_SAVE_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL, O:DS_O_RESULT=DS_O_RESULT)"; 
    TR_SAVE_DETAIL.Post();
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
    EM_JBRCH_ID.Enable = true;
    LC_JBRCH_GB.Enable = true;
    //
    RD_SIGN_YN.CodeValue = "N";
    RD_DEL_YN.CodeValue  = "N";
    
    strChangFlag = false;
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
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

    LC_STR_CD.Enable = false;
    LC_BCOMP_CD.Enable = false;
    EM_JBRCH_ID.Enable = false;

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
            setTimeout("LC_JBRCH_TYPE.Focus();",50);
            return false;
        }else {
            if(DS_IO_MASTER.NameValue(row, "STR_NAME") == "")
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
    if (row != 0 && colid == "DEL_YN") {
    	//DS_IO_MASTER.NameValue(row, colid) = DS_IO_MASTER.NameValue(row, colid) == "Y"? "N":"Y";
    }

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
<object id="DS_JBRCH_TYPE" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_BCOMP_CD" classid=<%=Util.CLSID_DATASET%>> </object>
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
<object id="DS_JBRCH_TYPE_D" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_JBRCH_GB" classid=<%=Util.CLSID_DATASET%>> </object>
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
                        <th width="80" class="point">점포명</th>
                        <td width="180"><comment id="_NSID_"> 
                            <object id=LC_COND_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=158 align="absmiddle" tabindex=1> 
                            </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width="80" >매입사코드</th>
                        <td width="180"><comment id="_NSID_"> 
                            <object id=LC_COND_BCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=158 align="absmiddle" tabindex=1> 
                            </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <th width="80">무서명여부</th>
                        <td width="180"><comment id="_NSID_"> 
                            <object id=RD_COND_SIGN_YN classid=<%=Util.CLSID_RADIO%>
                                style="height: 20; width: 160" tabindex=1>
                                <param name=Cols value="3">
                                <param name=Format value="^전체,Y^Yes,N^No">
                                <param name=CodeValue value="">
                                <param name=AutoMargin value="true">
                            </object> </comment> 
                            <script> _ws_(_NSID_);</script> 
                        </td>
                        <th width="80" >가맹점종류</th>
                        <td width="180"><comment id="_NSID_"> 
                            <object id=LC_COND_JBRCH_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=158 align="absmiddle" tabindex=1> 
                            </object> </comment> <script> _ws_(_NSID_);</script>
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
                <td><comment id="_NSID_"> <object id=GR_MASTER width="100%" height=375 classid=<%=Util.CLSID_GRID%> tabindex=1>
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
                 <th width="100" class="point">가맹점번호</th>
                 <td ><comment id="_NSID_">
                    <object  id=EM_JBRCH_ID classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td>
            </tr>
            <tr>
                <th width="100" class="point">가맹점구분</th>
                <td width="160"><comment id="_NSID_">
                    <object  id=LC_JBRCH_GB classid=<%=Util.CLSID_LUXECOMBO%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td>
                <th width="100" class="point">가맹점명</th>
                <td width="160"><comment id="_NSID_"> 
                    <object id=EM_JBRCH_NM classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1></object> </comment> 
                    <script> _ws_(_NSID_);</script> 
                </td>
                <th width="100" class="point">가맹점종류</th>
                <td width="160"><comment id="_NSID_"> 
                    <object id=LC_JBRCH_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script> 
                </td>
               
                
            </tr>
            <tr>
                <th width="100">무서명여부</th>
                <td width="160"><comment id="_NSID_">
                    <object  id=RD_SIGN_YN classid=<%=Util.CLSID_RADIO%> 
                        style="height: 20; width: 160" tabindex=1>
                        <param name=Cols value="2">
                        <param name=Format value="Y^Yes,N^No">
                        <param name=CodeValue value="">
                        <param name=AutoMargin value="true">
                    </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                 </td>
                <th width="100">무서명한도금액</th>
                <td><comment id="_NSID_">
                    <object  id=EM_SIGN_AMT classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script>
                </td>
                <th width="80" class="point">입금소요일</th>
                <td width="160"><comment id="_NSID_"> 
                    <object id=EM_PAY_DAY classid=<%=Util.CLSID_EMEDIT%> width=156 tabindex=1> </object> </comment> 
                    <script> _ws_(_NSID_);</script> 
                </td>
             </tr>
             <tr>
                <th width="100">삭제여부</th>
                <td colspan="5"><comment id="_NSID_">
                    <object  id=RD_DEL_YN classid=<%=Util.CLSID_RADIO%>
                        style="height: 20; width: 160" tabindex=1>
                        <param name=Cols value="2">
                        <param name=Format value="Y^Yes,N^No">
                        <param name=CodeValue value="">
                        <param name=AutoMargin value="true">
                    </object> </comment> 
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
            <c>col=STR_CD           ctrl=LC_STR_CD      Param=BindColVal</c>
            <c>col=BCOMP_CD         ctrl=LC_BCOMP_CD    Param=BindColVal</c>
            <c>col=JBRCH_ID         ctrl=EM_JBRCH_ID    Param=Text</c>
            <c>col=JBRCH_GB         ctrl=LC_JBRCH_GB    Param=BindColVal</c>
            <c>col=JBRCH_NM         ctrl=EM_JBRCH_NM    Param=Text</c>            
            <c>col=SIGN_YN          ctrl=RD_SIGN_YN     Param=CodeValue</c>
            <c>col=SIGN_AMT         ctrl=EM_SIGN_AMT    Param=Text</c>
            <c>col=JBRCH_TYPE       ctrl=LC_JBRCH_TYPE  Param=BindColVal</c>
            <c>col=PAY_DAY          ctrl=EM_PAY_DAY     Param=Text</c>
            <c>col=DEL_YN           ctrl=RD_DEL_YN      Param=CodeValue</c>
            <c>col=IN_UP_TYPE       ctrl=EM_IN_UP_TYPE_H      Param=Text</c>
            <c>col=STR_CD_H         ctrl=EM_STR_CD_H    Param=Text</c>
            <c>col=BCOMP_CD_H       ctrl=EM_BCOMP_CD_H  Param=Text</c>
            <c>col=JBRCH_ID_H       ctrl=EM_JBRCH_ID_H  Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

</div>
<body>
</html>   
