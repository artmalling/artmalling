<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 신용카드대금청구 > 청구관리 > 청구대상데이터 청구
 * 작  성  일  : 2010.05.25
 * 작  성  자  : 조형욱
 * 수  정  자  : 
 * 파  일  명  : psal9300.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.05.25 (조형욱) 신규작성
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
<!--* A. 로그인 유무, 기본설정                                                *-->
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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strFlag           = "INS";
var strChangFlag      = false;
var bfListRowPosition = 0;                             // 이전 List Row Position
var strBefore         = "";  
var strAfter          = "";
var intChangRow  = 0;
var strToday = '<%=Util.getToday("yyyyMMdd")%>';
var top = 140;

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
	var obj   = document.getElementById("GR_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	// Input, Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터    
    // EMedit에 초기화
    initEmEdit(EM_COND_REQ_DT,      "TODAY",     PK);           //조회 종료기간
    //
    initComboStyle(LC_COND_STR_CD, DS_COND_STR_CD, "CODE^0^30, NAME^0^120", 1, PK);
    //
    getStore("DS_COND_STR_CD", "Y", "", "N");   
    //초기값설정
    setComboData(LC_COND_STR_CD,  DS_COND_STR_CD.NameValue(0, "CODE"));  //
    //
    //showMaster();
    LC_COND_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies    = '<FC>id={currow}         name="NO"             width=30   align=center</FC>'
				    	+ '<FC>id=COMM_CODE        name="COMM_CODE"      width=0   align=center</FC>'
				    	+ '<FC>id=COMM_NAME1       name="작업구분"        width=200   align=left</FC>'
				    	+ '<FC>id=CNT              name="작업대상건수"     width=100   align=right</FC>'
				    	+ '<FC>id=PROC_CNT         name="처리건수"        width=80  align=right</FC>'
				    	+ '<FC>id=RTN_MSG          name="처리결과 메세지"   width=370  align=left</FC>';
                     
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
  * 작 성 자     : 조형욱
  * 작 성 일     : 2010-02-10
  * 개       요     : 조회시 호출
  * return값 : void
  */
 function btn_Search() {
     //조회
     showMaster();
 }
 
 /**
  * btn_Save()
  * 작 성 자     : 조형욱
  * 작 성 일     : 2010-02-10
  * 개       요     : 저장시 호출
  * return값 : void
  */
 function btn_Save() {
     //조회
     save();
 }

/**
 * btn_Excel()
 * 작   성   자 : 조형욱
 * 작   성   일 : 2010-02-22
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
 function btn_Excel() {
	 var parameters  = "점포명="+ LC_COND_STR_CD.Text;
     parameters = parameters + " 청구일자="+ EM_COND_REQ_DT.Text;
     
     var ExcelTitle = "청구대상데이터 가져오기";

     openExcel2(GR_MASTER, ExcelTitle, parameters, true );
     
     GR_MASTER.Focus();
 }
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-05-26
 * 개       요     : 청구대상데이터 리스트 조회 
 * return값 : void
 */
function showMaster(){
	if(trim(LC_COND_STR_CD.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
        LC_COND_STR_CD.Focus();
        return false;
    }
	if(trim(EM_COND_REQ_DT.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","청구일자");
        EM_COND_REQ_DT.Focus();
        return;
    }
	//
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&paramStrCd="   + encodeURIComponent(LC_COND_STR_CD.BindColVal)
                    + "&paramReqDt="   + encodeURIComponent(EM_COND_REQ_DT.text);
    //
    TR_MAIN.Action  ="/dps/psal930.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	LC_COND_STR_CD.Focus();  
    }
}

/**
 * searchSeq()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-05-23
 * 개       요     : 저장전 체크 CHRG_SEQ 
 * return값 : void
 */
function searchSeq(){
	 DS_O_SEQ.ClearData();
    //
    var goTo        = "searchSeq";    
    var action      = "O";     
    var parameters  = "&paramReqDt="   + encodeURIComponent(EM_COND_REQ_DT.text);
    TR_MAIN.Action  ="/dps/psal930.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_SEQ=DS_O_SEQ)"; //조회는 O
    TR_MAIN.Post();
}

/**
 * showMaster()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-05-23
 * 개       요     : 청구대상데이터 리스트 조회 
 * return값 : void
 */
function save(){ 
	if(trim(LC_COND_STR_CD.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
        LC_COND_STR_CD.Focus();
        return false;
    }
    if(trim(EM_COND_REQ_DT.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1003","청구일자");
        EM_COND_REQ_DT.Focus();
        return;
    }
    /* 
    if(strToday != EM_COND_REQ_DT.Text){          // 
        showMessage(EXCLAMATION, OK, "USER-1000","저장/전송처리시 청구일자는 금일만 입력 가능합니다.");
        EM_COND_REQ_DT.Focus();
        return;
    }
    */

    searchSeq();
    if(DS_O_SEQ.CountRow > 0){
    	showMessage(EXCLAMATION, OK, "USER-1000","미전송된 데이터가 존재합니다. 전송 후 처리 가능합니다.");
    	return;
    }    
    
  //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ) {
        return;
    }
    
    //
    var goTo        = "save";    
    var action      = "O";     
    var parameters  = "&paramStrCd="   + encodeURIComponent(LC_COND_STR_CD.BindColVal)
                    + "&paramReqDt="   + encodeURIComponent(EM_COND_REQ_DT.text);
    TR_MAIN.Action  ="/dps/psal930.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
}

/**
 * showMaster()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-05-23
 * 개       요     : 파일 데이타 송신 
 * return값 : void
 */
function sendData(){ 
	 
	if(trim(LC_COND_STR_CD.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
        LC_COND_STR_CD.Focus();
        return false;
    }
    if(trim(EM_COND_REQ_DT.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1003","청구일자");
        EM_COND_REQ_DT.Focus();
        return;
    }
    /* 
    if(strToday != EM_COND_REQ_DT.Text){          // 
        showMessage(EXCLAMATION, OK, "USER-1000","저장/전송처리시 청구일자는 금일만 입력 가능합니다.");
        EM_COND_REQ_DT.Focus();
        return;
    }
     */
    searchSeq();
    
    if(DS_O_SEQ.CountRow == 0){
    	showMessage(EXCLAMATION, OK, "USER-1000","전송할 데이터가 없습니다.");
    	return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1097") != 1 ) {
        return;
    }
    
    var strChrgSeq = DS_O_SEQ.NameValue(1, "CHRG_SEQ");
    //
    var goTo        = "sendData";    
    var action      = "O";     
    var parameters  = "&paramStrCd="   + encodeURIComponent(LC_COND_STR_CD.BindColVal)
                    + "&paramReqDt="   + encodeURIComponent(EM_COND_REQ_DT.text)
                    + "&strToday="     + encodeURIComponent(strToday)
                    + "&strChrgSeq="   + encodeURIComponent(strChrgSeq);
    TR_MAIN.Action  ="/dps/psal930.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
}

function sendData_first(){ 
	 
	/*if(trim(LC_COND_STR_CD.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
        LC_COND_STR_CD.Focus();
        return false;
    }
    if(trim(EM_COND_REQ_DT.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1003","청구일자");
        EM_COND_REQ_DT.Focus();
        return;
    }*/
    /* 
    if(strToday != EM_COND_REQ_DT.Text){          // 
        showMessage(EXCLAMATION, OK, "USER-1000","저장/전송처리시 청구일자는 금일만 입력 가능합니다.");
        EM_COND_REQ_DT.Focus();
        return;
    }
     */
    //searchSeq();
    
    /*if(DS_O_SEQ.CountRow == 0){
    	showMessage(EXCLAMATION, OK, "USER-1000","전송할 데이터가 없습니다.");
    	return;
    }*/
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1097") != 1 ) {
        return;
    }
    
    var strChrgSeq = "1";
    //
    var goTo        = "sendData_first";    
    var action      = "O";     
    var parameters  = "&paramStrCd="   + encodeURIComponent(LC_COND_STR_CD.BindColVal)
                    + "&paramReqDt="   + encodeURIComponent(EM_COND_REQ_DT.text)
                    + "&strToday="     + encodeURIComponent(strToday)
                    + "&strChrgSeq="   + encodeURIComponent(strChrgSeq);
    TR_MAIN.Action  ="/dps/psal930.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
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
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->

<!-- 청구일자 onKillFocus() -->
<script language=JavaScript for=EM_COND_REQ_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_COND_REQ_DT)){
        initEmEdit(EM_COND_REQ_DT,    "TODAY",     PK);        
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
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_SEQ" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_STR_CD" classid=<%=Util.CLSID_DATASET%>> </object>
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
	<param name="TimeOut" value=1200000>
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
                        <td width="165"><comment id="_NSID_"> 
                            <object id=LC_COND_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=165 align="absmiddle" tabindex=1> 
                            </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width="80" class="point">청구일자</th>
                        <td width="95"><comment id="_NSID_"> 
                            <object id=EM_COND_REQ_DT classid=<%=Util.CLSID_EMEDIT%> width=70 align="absmiddle" tabindex=1> 
                            </object> </comment> <script> _ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_COND_REQ_DT)" />
                        </td>
                        <td class="FS11 red">
                        	<!--  <img src="/<%=dir%>/imgs/btn/send_pre_c.gif" align="absmiddle" />-->
                        	 * 저장후 1분 후에 전송처리 가능함.&nbsp&nbsp&nbsp&nbsp&nbsp FRIST_DATA -> <input type="button" value="FIRSTDATA" onclick="sendData_first();" /></td>
                            <!-- 매입VAN변경 20160301 onclick="sendData();" align="absmiddle" /> * 저장후 1분 후에 전송처리 가능함.&nbsp&nbsp&nbsp&nbsp&nbsp FRIST_DATA -> <input type="button" value="FIRSTDATA" onclick="sendData_first();" /></td> -->
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
                <td><comment id="_NSID_"> <object id=GR_MASTER width="100%" height=504 classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_O_MASTER">
                </object> </comment> <script>_ws_(_NSID_);</script></td>
            </tr>
        </table>
        </td>
    </tr>   
    
</table>

<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</div>
<body>
</html>
    
