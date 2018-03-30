<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 클럽관리 > 클럽가입이력조회(개인)
 * 작  성  일  : 2010.05.19
 * 작  성  자  : 조형욱
 * 수  정  자  : 
 * 파  일  명  : dctm1350.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.05.19 (조형욱) 신규작성
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

	String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	strToMonth = strToMonth + "01";
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
var strBefore         = "";  
var strAfter          = "";
var intChangRow       = 0;
var isFirstSearch     = 0;

//엑셀용
var strClubId   = "";
var strName     = "";
var strFromDt   = "";
var strToDt     = "";
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
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_CUST_NAME,   "GEN^40",              READ);       //회원명 
    initEmEdit(EM_HOME_PH,     "GEN^40",              READ);       //자택전화
    initEmEdit(EM_HOME_PH1,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH2,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH3,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_MOBILE_PH,   "GEN^40",              READ);       //이동전화 
    initEmEdit(EM_MOBILE_PH1,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH2,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH3,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_SS_NO,       "000000",      		  READ);       //생년월일
    initEmEdit(EM_HOME_ADDR,   "GEN^400",             READ);       //회원주소 
    initEmEdit(EM_POINT,       "NUMBER^9^0",          READ);       //누적포인트
    initEmEdit(EM_EMAIL,       "GEN^80",              READ);       //이메일주소
    initEmEdit(EM_EMAIL1,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_EMAIL2,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_CUST_GTADE,  "GEN^40",              READ);       //회원등급
    
    initEmEdit(EM_CUST_ID_S,   "GEN^9",               NORMAL);     //회원코드
    initEmEdit(EM_CUST_NAME_S, "GEN^40",              READ);       //회원명
    initEmEdit(EM_SS_NO_S,     "000000",      		  NORMAL);     //생년월일
    initEmEdit(EM_CARD_NO_S,   "0000-0000-0000-0000", NORMAL);     //카드번호
    initEmEdit(EM_CUST_ID_H,   "GEN^9",               NORMAL);     //회원코드_hidden
    initEmEdit(EM_SS_NO_H,     "#00000",       		  NORMAL);     //생년월일_hidden
    initEmEdit(EM_CARD_NO_H,   "0000000000000000",    NORMAL);     //카드번호_hidden
    
    //활성화 비활성화 화면 초기 설정
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
    
    //초기조회
    //showMaster();
    //
    EM_CARD_NO_S.focus();
}

function gridCreate1(){
    var hdrProperies    = '<FC>id={currow}          name="NO"           width=30     align=center</FC>'
						+ '<FC>id=CLUB_ID           name="클럽ID"        width=60     align=center</FC>'
						+ '<FC>id=CLUB_NAME         name="클럽명"        width=120    align=left</FC>'
						+ '<FC>id=CLUB_INFO         name="클럽설명"       width=390    align=left</FC>'
						+ '<FC>id=C_DATE            name="가입일자"       width=90     align=center</FC>'
						+ '<FC>id=S_DATE            name="탈퇴일자"       width=90     align=center</FC>';  
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies    = '<FC>id={currow}            name="NO"               width=30   align=center</FC>'
				    	+ '<FC>id=CLUB_ID             name="클럽ID"            width=160    align=center</FC>'
				    	+ '<FC>id=CLUB_NAME           name="클럽명"            width=220    align=left</FC>'
				    	+ '<FC>id=PROC_NAME           name="이력구분"           width=120    align=center</FC>'
				    	+ '<FC>id=CONF_DATE           name="확정일자"           width=250    align=center</FC>';  
                     
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
	//
	isFirstSearch = 0;
	//
	if (trim(EM_CUST_ID_S.Text).length > 0 ) {
		EM_CUST_ID_H.Text = EM_CUST_ID_S.Text;
	}
    if(trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 
            && trim(EM_CARD_NO_S.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일],[회원명] 중 1개는  반드시 입력해야 합니다.");
        EM_CARD_NO_S.Focus();
        return;
    }
	
	if(srchEvent('P')) {
		showMaster();
	    //GR_MASTER.Focus();
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
    var strCustId  = EM_CUST_ID_H.Text;
    var parameters  = "회원ID="+ EM_CUST_ID_H.Text;
    parameters = EM_CARD_NO_S.Text.length > 0? parameters + " 카드번호="+ EM_CARD_NO_S.Text : parameters;
    parameters = EM_SS_NO_S.Text.length > 0? parameters + " 생년월일=" + EM_SS_NO_S.Text : parameters;
     
	var ExcelTitle = "클럽가입이력조회(개인)";
	
	openExcel2(GR_DETAIL, ExcelTitle, parameters, true );     
	GR_DETAIL.Focus();
 }

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-02-11
 * 개       요     : 클럽회원 리스트 조회 
 * return값 : void
 */
function showMaster(){	      	 
    var goTo        = "searchMaster";    
    var action      = "O";     
    var strCustId   = EM_CUST_ID_H.Text;
    var parameters  = "&strCustId=" + encodeURIComponent(strCustId);
    TR_MAIN.Action  ="/dcs/dctm135.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	EM_CARD_NO_S.focus();  
    }
    // 
    DS_O_MASTER.RowPosition = LAST_MOD_ROW>0?LAST_MOD_ROW : DS_O_MASTER.RowPosition;
    isFirstSearch = 1;
    
    showDetail();
}
/**
 * showMaster()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-02-11
 * 개       요     : 클럽회원 리스트 조회 
 * return값 : void
 */
function showDetail(){
    var goTo        = "searchDetail";    
    var action      = "O";     
    var strClubId   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CLUB_ID"); 
    var strCustId   = EM_CUST_ID_H.Text;
    var parameters  = "&strCustId=" + encodeURIComponent(strCustId) 
                    + "&strClubId=" + encodeURIComponent(strClubId);
    TR_DETAIL.Action  = "/dcs/dctm135.dm?goTo="+goTo+parameters;
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
}

/**
 * setEnable(flag)
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-04-21
 * 개       요     : Enable true/false
 * return값 : void
 */
function setEnable(flag){
	
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
        showMessage(INFORMATION, OK, "USER-1000", strMsg[0]);
    }    
</script>
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        var strMsg = TR_DETAIL.SrvErrMsg('UserMsg',i).split('|');
    }
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
<!--DS_O_MASTER  OnRowPosChanged(row)(row,colid)-->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
    //상세조회
    if(row != 0 && isFirstSearch > 0){
    	showDetail();
    	LAST_MOD_ROW = DS_O_MASTER.RowPosition;
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->


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
<object id="DS_O_CUSTDETAIL" classid=<%=Util.CLSID_DATASET%>></object>
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
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table"> 
                    <tr>
                    <th width="77">카드번호</th>
                    <td width="160"><comment id="_NSID_"> <object
                        id=EM_CARD_NO_H classid=<%=Util.CLSID_EMEDIT%> tabindex=1
                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
                        id="_NSID_"> <object id=EM_CARD_NO_S
                        classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
                        onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CARD_NO_S','');">
                    </object> </comment> <script> _ws_(_NSID_);</script></td>
                    <th width="80"><span id="titleSsNo1" style="Color: 146ab9">생년월일</span></th>
                    <td width="160"><comment id="_NSID_"> <object
                        id=EM_SS_NO_H classid=<%=Util.CLSID_EMEDIT%> tabindex=1
                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
                        id="_NSID_"> <object id=EM_SS_NO_S
                        classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 style="IME-MODE:disabled"
                        onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_SS_NO_S','');">
                    </object> </comment> <script> _ws_(_NSID_);</script></td>
                    <th width="80"><span id="titleCustName1" style="Color: 146ab9; ">회원명</span></th>
                    <td><comment id="_NSID_"> <object id=EM_CUST_ID_H
                        classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object>
                    </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_"> <object
                        id=EM_CUST_ID_S classid=<%=Util.CLSID_EMEDIT%> width=66 tabindex=1
                        onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CUST_ID_S','P');"
                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                        src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
                        onclick="getCompPop(EM_CUST_ID_S,EM_CUST_NAME_S,'P')" /> <comment
                        id="_NSID_"> <object id=EM_CUST_NAME_S
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
        <td class="dot"></td>
    </tr>
    <tr>
        <td><%@ include file="/jsp/common/memView.jsp"%></td>
    </tr>
    
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=165 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
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
                    width="100%" height=253 classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_O_DETAIL">
                </object> </comment> <script>_ws_(_NSID_);</script></td>
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
            <c>col=EMAIL1        ctrl=EM_EMAIL1       Param=Text</c>
            <c>col=EMAIL2        ctrl=EM_EMAIL2       Param=Text</c>
            <c>col=GRADE_NAME    ctrl=EM_CUST_GTADE   Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
