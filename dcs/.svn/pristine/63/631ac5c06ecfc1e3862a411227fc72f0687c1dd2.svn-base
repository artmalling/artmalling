<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽운영  > 전자쿠폰 > 포인트조회(고객미등록)
 * 작  성  일  : 2012.08.08
 * 작  성  자  : 강진
 * 수  정  자  : 
 * 파  일  명  : dmbo7150.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
	type="text/javascript"></script>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<%
    String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date()); 
%>
<script LANGUAGE="JavaScript">
<!--
var EXCEL_PARAMS = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 강진
 * 작 성 일 : 2010-03-18
 * 개      요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 250;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GR_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    var GET_USER_AUTH_VALUE = getBrchUserAuth('<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />');
    
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1();
    gridCreate2(); 
    
    //검색조건
    /*
    if ("B" == GET_USER_AUTH_VALUE) {
    	initEmEdit(EM_BRCH_ID,    "GEN^10",   READ);       //가맹점코드
        enableControl(IMG_BRCH,   false);
    } else {
    	initEmEdit(EM_BRCH_ID,    "GEN^10",   NORMAL);     //가맹점코드
        enableControl(IMG_BRCH,   true); 
    }
    */
    initEmEdit(EM_BRCH_ID,    "GEN^10",   PK);       //가맹점코드
    
    enableControl(IMG_CUST_SCH,   true);
    enableControl(IMG_BRCH,   true);
    
    //EMedit에 초기화
    
    initEmEdit(EM_BRCH_NAME, "GEN^40",                READ);         //가맹점명
    initEmEdit(EM_CARD_NO_CUT,    "00000000",         NORMAL);     //단축 카드번호
    initEmEdit(EM_CARD_NO,   "0000-0000-0000-0000",   NORMAL);     //카드번호
    initEmEdit(EM_SS_NO,     "000000",        READ);     //생년월일번호
    initEmEdit(EM_CUST_ID_S,   "GEN^9",               READ);     //회원코드
    initEmEdit(EM_CUST_NAME_S, "GEN^40",              READ);       //회원명
    initEmEdit(EM_CUST_ID_H,   "GEN^9",               NORMAL);     //회원코드_hidden
    initEmEdit(EM_SS_NO_H,     "000000",      NORMAL);     //생년월일번호_hidden
    initEmEdit(EM_CARD_NO_H,   "0000-0000-0000-0000", NORMAL);     //카드번호_hidden
    
    EM_CUST_ID_H.style.display   = "none";
    EM_CARD_NO_H.style.display   = "none";
    EM_SS_NO_H.style.display     = "none";
    
    //default ;
    EM_BRCH_ID.Text = '<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />'; //소속가맹점 
    setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_ID.Text);
    if (DS_O_RESULT.CountRow == 1 ) {
        EM_BRCH_ID.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
        EM_BRCH_NAME.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
    }
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"               width=40        align=center</FC>'
                     + '<FC>id=CARD_NO          name="카드번호"         	width="120"     align=center  mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=ADD_POINT        name="적립포인트"       	width="80"     	align=center</FC>'
                     + '<FC>id=REG_DATE         name="최초적립일시"     	width="140"     align=center	mask="XXXX/XX/XX XX:XX:XX"	show=false</FC>'
                     + '<FC>id=MOD_DATE        	name="최종적립일시"     	width="140"     align=center	mask="XXXX/XX/XX XX:XX:XX"</FC>'
                     + '<FC>id=APP_YN          	name="회원등록여부"  	width="80"     	align=center</FC>'
                     + '<FC>id=APP_DATE        	name="회원등록일시"     	width="140"     align=center	mask="XXXX/XX/XX XX:XX:XX"</FC>'
                     + '<FC>id=CUST_ID         	name="회원번호"      	width=80    	Edit=none align=center</FC>'
                     + '<FC>id=CUST_NAME		name="성명"    			width=60    	Edit=none  align=center</FC>'
 			         + '<FC>id=SUM_POINT        name="합계포인트"       	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=90        align=right 		show=true</FC>'
 			         + '<FC>id=POINT            name="가용포인트"       	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=90        align=right 		show=true</FC>'
			         + '<FC>id=OCCURS_POINT     name="적립포인트"       	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=90        align=right 		show=true</FC>'
                     ;
                                          
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}         name="NO"               	width=40        align=center</FC>'
			         + '<FC>id=PROC_DT          name="처리일자"         	width=80        align=center      mask="XXXX/XX/XX"</FC>'
			         + '<FC>id=PROC_TIME        name="처리시간"         	width=70        align=center      mask="XX:XX:XX"</FC>'
			         + '<FC>id=CARD_NO          name="카드번호"         	width=150       align=center      mask="XXXX-XXXX-XXXX-XXXX"</FC>'
			         + '<FC>id=BRCH_ID          name="가맹점ID"         	width=60        align=center      show=false</FC>'
			         + '<FC>id=BRCH_NAME        name="가맹점명"         	width=106       align=left show=false</FC>'
			         + '<FC>id=ADD_POINT        name="적립포인트"       	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=90        align=right</FC>'
			         + '<FC>id=ADD_TYPE         name="적립유형"         	width=90        align=center      show=false</FC>'
			         + '<FC>id=ADD_TYPE_NM      name="적립유형"         	width=90        align=left</FC>'
			         + '<FC>id=USE_POINT        name="사용포인트"       	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=90        align=right 		show=false</FC>'
			         + '<FC>id=USE_TYPE         name="사용유형"         	width=100       align=center      show=false</FC>'
			         + '<FC>id=USE_TYPE_NM      name="사용유형"         	width=100       align=left 		show=false</FC>'
			         + '<FC>id=RECP_NO          name="영수증번호"       	width=150       align=center 		mask="X-XXXXXX-XXXX-XXXXX"</FC>'
			         ;
                     
    initGridStyle(GR_DETAIL, "common", hdrProperies, false);
}

/*************************************************************************
 * 2. 공통버튼
    (1) 조회       - btn_Search(), subQuery()
    (2) 엑셀       - btn_Excel()
*************************************************************************/
/**
* btn_Search()
* 작 성 자 : 강진
* 작 성 일 : 2010-03-18
* 개       요 : 조회시 호출
* return값 : void
*/
function btn_Search() {
	if(trim(EM_BRCH_ID.Text).length == 0){     
        showMessage(EXCLAMATION, OK, "USER-1001","가맹점");
        EM_BRCH_ID.Focus();
	    return;
    }
	/*
    if(trim(EM_SS_NO.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 
            && trim(EM_CARD_NO.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일번호],[회원명] 중 1개는  반드시 입력해야 합니다.");
        EM_CARD_NO.Focus();
        return;
    }
	*/
    if( trim(EM_CARD_NO.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호]는  반드시 입력해야 합니다.");
        EM_CARD_NO.Focus();
        return;
    }	
   	if(trim(EM_CARD_NO.Text).length != 0 && trim(EM_CARD_NO.Text).length != 13 && trim(EM_CARD_NO.Text).length != 16 ) {		
        showMessage(EXCLAMATION, OK, "USER-1000",  "카드번호는 16자리입니다.");
        EM_CARD_NO.Focus();
        return;
    }
	/*
    if (trim(EM_SS_NO.Text).length > 0 && trim(EM_SS_NO.Text).length < 13) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "생년월일번호는 13자리입니다.");
        EM_SS_NO.Focus();
        return;
    }
    if (trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "회원은 9자리입니다.");
        EM_CUST_ID_S.Text = "";
        EM_CUST_ID_S.Focus();
        return;
    }
    */
   showMaster();
}

/**
* btn_Excel()
* 작 성 자 : 강진
* 작 성 일 : 2010-03-18
* 개       요 : 엑셀로 다운로드
* return값 : void
*/
function btn_Excel() {

    var ExcelTitle = "포인트조회(고객미등록)"
               
    GR_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
    openExcel2(GR_MASTER, ExcelTitle, EXCEL_PARAMS, true );
}

function btn_New() {
	doInit();
	
	DS_O_MASTER.ClearData();
	DS_O_DETAIL.ClearData();
    
    EM_CUST_ID_H.Text   = ""; 
    EM_CARD_NO.Text   = "";
    EM_CARD_NO_CUT.Text = "";
    EM_SS_NO_H.Text     = "";
    EM_CUST_ID_S.Text   = ""; 
    EM_CUST_NAME_S.Text = "";
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 강진
 * 작 성 일     : 2010-03-18
 * 개       요     : 포인트조회(고객미등록)
 * return값 : void
 */
function showMaster(){

    var strBrchId  = EM_BRCH_ID.Text;
    var strCardNo  = EM_CARD_NO.Text;
    var strSsNo    = EM_SS_NO.Text;
    var strCustId  = EM_CUST_ID_S.Text;
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strBrchId=" + encodeURIComponent(strBrchId)
                    + "&strCardNo=" + encodeURIComponent(strCardNo)
                    + "&strSsNo="   + encodeURIComponent(strSsNo)
                    + "&strCustId=" + encodeURIComponent(strCustId);    
    
        
    EXCEL_PARAMS = "-가맹점="   +  strBrchId;
    EXCEL_PARAMS += "-가맹점명=" +  EM_BRCH_NAME.Text;
    EXCEL_PARAMS += "-카드번호=" +  strCardNo;
    EXCEL_PARAMS += "-생년월일=" +  strSsNo;
    EXCEL_PARAMS += "-고객ID="   +  strCustId;
    EXCEL_PARAMS += "-고객명="   +  EM_CUST_NAME_S.Text;
    
    TR_MAIN.Action  ="/dcs/dmbo715.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //Focus이동
    if(DS_O_MASTER.CountRow > 0){
        //상단 Grid Focus이동
        GR_MASTER.Focus();
    }else{
    	EM_CARD_NO.Focus();
    }
    
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
}

/**
 * searchDetail()
 * 작 성 자     : 강진
 * 작 성 일     : 2010-03-21
 * 개       요     : 포인트조회(고객미등록) 상세조회
 * return값 : void
 */
function searchDetail(row){
    
    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;
    var strCardNo   = DS_O_MASTER.NameValue(row ,"CARD_NO");
 
    var goTo        = "searchDetail";    
    var action      = "O";     
    var parameters  = "&strCardNo="  + encodeURIComponent(strCardNo);    
    TR_DETAIL.Action  ="/dcs/dmbo715.do?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
    //조회결과 Return
    setPorcCount("SELECT", DS_O_DETAIL.CountRow);
}

/**
 * keyPressEvent()
 * 작 성 자 : 강진
 * 작 성 일 : 2010-03-21
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
    EM_BRCH_NAME.Text = "";//조건입력시 코드초기화
    if (trim(EM_BRCH_ID.Text).length > 0 ) {
        if (kcode == 13 || kcode == 9 || trim(EM_BRCH_ID.Text).length == 10) { //TAB,ENTER 키 실행시에만 
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
 	frame01.Provider('../').OuterWindow.top.leftFrame.urlLink(go.toUpperCase().substring(0,7),"/dcs/"+go+"?goTo=list&strCardNo="+EM_CARD_NO.Text+"&strSsNo="+EM_SS_NO.Text,s,"01",nm);
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
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--DS_O_MASTER  OnRowPosChanged(row)(row,colid)-->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    if(clickSORT) return;
    //그리드 첫 row 상세조회
    if(row != 0){
        searchDetail(row);
    }else{
        DS_O_DETAIL.ClearData();
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 단축카드번호 onKillFocus() -->
<script language=JavaScript for=EM_CARD_NO_CUT event=onKillFocus()>
    //EM_CARD_NO.Text = cardCheckDigit(EM_CARD_NO_CUT.Text); 
	if ( trim(EM_CARD_NO_CUT.Text).length != 0 ) {
    	EM_CARD_NO.Text = cardCheckDigit(EM_CARD_NO_CUT.Text);
    }
</script>
<!-- 가맹점명 onKillFocus() -->
<script language=JavaScript for=EM_BRCH_ID event=onKillFocus()>
    if ((EM_BRCH_ID.Modified) && (trim(EM_BRCH_ID.Text).length != 10)) {
        EM_BRCH_NAME.Text = "";
    }
</script>
<!-- 회원ID onKillFocus() -->
<script language=JavaScript for=EM_CUST_ID_S event=onKillFocus()>
    if ((EM_CUST_ID_S.Modified) && (EM_CUST_ID_S.Text.length != 9)) {
        EM_CUST_NAME_S.Text = ""; 
        EM_CUST_NAME_S.Text = ""; 
        EM_CARD_NO_H.Text   = "";
        EM_SS_NO_H.Text     = "";
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
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%= Util.CLSID_DATASET %>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
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

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_DETAIL");
    
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
						<th width="50" class="point">가맹점</th>
						<td colspan="5"><comment id="_NSID_"> <object
							id=EM_BRCH_ID classid=<%=Util.CLSID_EMEDIT%> width=72 
							onKeyUp="javascript:keyPressEvent(event.keyCode);" tabindex=1> 
						</object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle" id="IMG_BRCH"
							onclick="getBrchPop(EM_BRCH_ID,EM_BRCH_NAME)" /> <comment
							id="_NSID_"> <object id=EM_BRCH_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr> 
					<tr>
						<th width="50">카드번호</th>
						<td width="200"><comment id="_NSID_"><object style="display:none"
							id=EM_CARD_NO_CUT classid=<%=Util.CLSID_EMEDIT%> width="56"
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
							<comment id="_NSID_"> <object
							id=EM_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1>
						</object> </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_">
						<object id=EM_CARD_NO_H classid=<%=Util.CLSID_EMEDIT%> width=0>
						</object> </comment> <script> _ws_(_NSID_);</script>
						<img id="IMG_CUST_SCH"
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							onclick="getCardPop(EM_CARD_NO,EM_CUST_NAME_S,'P',EM_BRCH_ID.text)" /></td>
						<th width="80" style="display:none"></th>
						<td width="150" style="display:none"><comment id="_NSID_"> <object style="display:none"
							id=EM_SS_NO classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1>
						</object> </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_">
						<object id=EM_SS_NO_H classid=<%=Util.CLSID_EMEDIT%> width=0>
						</object> </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_">
						<object id=EM_CUST_ID_H classid=<%=Util.CLSID_EMEDIT%> width=0
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80" style="display:none"></th>
						<td style="display:none"><comment id="_NSID_"> <object id=EM_CUST_ID_S 
							classid=<%=Util.CLSID_EMEDIT%> width=65 tabindex=1
							onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CUST_ID_S','%');" style="display:none">
						</object> </comment> <script> _ws_(_NSID_);</script>  <comment 
							id="_NSID_"> <object id=EM_CUST_NAME_S
							classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 style="display:none"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
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
			    <td class="btn_c"><a href="#" onclick="gourl('dmbo602.do','영수증사후적립','DMBO')">영수증사후적립</a></td>
			    <td class="btn_r"></td>
			    <td class="btn_l"> </td>
			    <td class="btn_c"><a href="#" onclick="gourl('dmbo622.do','영수증사후적립(회원미등록)','DMBO')">영수증사후적립(회원미등록)</a></td>
			    <td class="btn_r"></td>
			  	<td class="btn_l"> </td>
			    <td class="btn_c"><a href="#" onclick="gourl('dctm116.dm','회원메모관리(신규)','DCTM')">회원메모관리(신규)</a></td>
			    <td class="btn_r"></td>		
			    <td class="btn_l"> </td>
			    <td class="btn_c"><a href="#" onclick="gourl('dctm203.dm','개인회원조회/수정','DCTM')">개인회원조회/수정</a></td>
			    <td class="btn_r"></td>
			    <td class="btn_l"> </td>
			    <td class="btn_c"><a href="#" onclick="gourl('dmbo617.do','회원정보안내(소멸예정)','DMBO')">회원정보안내(소멸예정)</a></td>
			    <td class="btn_r"></td>
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
					width="100%" height=100 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script> _ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_DETAIL
					width="100%" height=222 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_DETAIL">
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
</body>
</html>
