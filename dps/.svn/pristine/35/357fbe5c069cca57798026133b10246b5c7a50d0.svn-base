<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 신용카드대금청구 > 청구관리 > 청구대상데이터 가져오기
 * 작  성  일  : 2010.05.25
 * 작  성  자  : 조형욱
 * 수  정  자  : 
 * 파  일  명  : psal9210.jsp
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
    String today = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
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

var schReqDt = "";          // 조회시 청구일자

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
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //마스터   
    // EMedit에 초기화
    initEmEdit(EM_COND_REQ_DT,      "TODAY",     PK);           //조회 종료기간
    //
    initComboStyle(LC_COND_STR_CD, DS_COND_STR_CD, "CODE^0^30, NAME^0^120", 1, PK);
    //
    getStore("DS_COND_STR_CD", "Y", "", "N");   
    //초기값설정
    setComboData(LC_COND_STR_CD,  DS_COND_STR_CD.NameValue(0, "CODE"));  //
    
    LC_COND_STR_CD.Focus();
    //
    //showMaster();
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

function gridCreate2(){
    var hdrProperies    = '<FC>id=COMM_CODE        name="COMM_CODE"      width=0   align=center</FC>'
				    	+ '<FC>id=COMM_NAME1       name="작업구분"        width=200   align=left suppress=1</FC>'
				    	+ '<FC>id=SALE_DT          name="승인일자"       width=100   align=CENTER</FC>'
				    	+ '<FC>id=CNT              name="작업대상건수"     width=100   align=right</FC>'
				    	+ '<FC>id=POSTPONE         name="청구제외건수"     width=100   align=right</FC>';
                     
    initGridStyle(GR_DETAIL, "common", hdrProperies, false);
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
     showdetail();
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
   <%-- if( EM_COND_REQ_DT.Text > '<%=today%>'){   // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1021", "청구일자", "금일");
        EM_COND_REQ_DT.Focus();
        return;
    } --%>
	//
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&paramStrCd="   + encodeURIComponent(LC_COND_STR_CD.BindColVal)
                    + "&paramReqDt="   + encodeURIComponent(EM_COND_REQ_DT.text);
    //
    TR_MAIN.Action  ="/dps/psal921.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
        LC_COND_STR_CD.Focus();  
    }
}

/**
 * showdetail()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-05-26
 * 개       요     : 청구대상데이터 리스트 조회 
 * return값 : void
 */
function showdetail(){
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
   <%-- if( EM_COND_REQ_DT.Text > '<%=today%>'){   // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1021", "청구일자", "금일");
        EM_COND_REQ_DT.Focus();
        return;
    } --%>
	//
    var goTo        = "searchdetail";    
    var action      = "O";     
    var parameters  = "&paramStrCd="   + encodeURIComponent(LC_COND_STR_CD.BindColVal)
                    + "&paramReqDt="   + encodeURIComponent(EM_COND_REQ_DT.text);
    //
    TR_MAIN2.Action  ="/dps/psal921.ps?goTo="+goTo+parameters;  
    TR_MAIN2.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_MAIN2.Post();
    
    
}

/**
 * showMaster()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-05-23
 * 개       요     : 청구대상데이터 리스트 조회 
 * return값 : void
 */
function save(){ 
	if (DS_O_MASTER.CountRow < 1) {
		showMessage(Information, OK, "USER-1075",  "저장");
		return false;
	}
	
	if (schReqDt != EM_COND_REQ_DT.Text) {
		showMessage(Information, OK, "USER-1075",  "저장");
		return false;
	}
	
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
    var goTo        = "save";    
    var action      = "O";     
    var parameters  = "&paramStrCd="   + encodeURIComponent(LC_COND_STR_CD.BindColVal)
                    + "&paramReqDt="   + encodeURIComponent(EM_COND_REQ_DT.text);
    TR_MAIN.Action  ="/dps/psal921.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
}

function getStrmstCode(strDataSet, sysPart, commPart, allGb, nulGb, objComboNm) {
    DS_I_COMMON.setDataHeader('SYS_PART:STRING(1),COMM_PART:STRING(4),ALL_GB:STRING(1),NUL_GB:STRING(1)');
    
    DS_I_COMMON.ClearData();
    DS_I_COMMON.Addrow();
    DS_I_COMMON.NameValue(1, "SYS_PART")  = sysPart;
    DS_I_COMMON.NameValue(1, "COMM_PART") = commPart;
    DS_I_COMMON.NameValue(1, "ALL_GB")    = allGb ;
    DS_I_COMMON.NameValue(1, "NUL_GB")    = nulGb == null ? 'N' : nulGb ;
    
    TR_MAIN.Action  = "/dps/psal903.ps?goTo=getStrmstCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    
    //if (allGb == "Y") {
    if (typeof(objComboNm) == "object" ) objComboNm.index = '0';
    //}
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
 // 조회시 청구일자 설정
    schReqDt = EM_COND_REQ_DT.text;
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
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>> </object>
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
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>>
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
                        <td width="320"><comment id="_NSID_"> 
                            <object id=LC_COND_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=140 align="absmiddle" tabindex=1> 
                            </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width="80" class="point">청구일자</th>
                        <td><comment id="_NSID_"> 
                            <object id=EM_COND_REQ_DT classid=<%=Util.CLSID_EMEDIT%> width=70 align="absmiddle" tabindex=1> 
                            </object> </comment> <script> _ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_COND_REQ_DT)" />
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
                <td><comment id="_NSID_"> <object id=GR_MASTER width="100%" height=100 classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_O_MASTER">
                </object> </comment> <script>_ws_(_NSID_);</script></td>
            </tr>
        </table>
        </td>
    </tr>   
    
    <tr>
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"> <object id=GR_DETAIL width="100%" height=100 classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_O_DETAIL">
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
    
