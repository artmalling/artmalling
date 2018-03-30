<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 클럽관리 > 클럽회원조회
 * 작  성  일  : 2010.05.19
 * 작  성  자  : 조형욱
 * 수  정  자  : 
 * 파  일  명  : dctm1330.jsp
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
//
var isFirstSearch     = 0;
var LAST_MOD_ROW      = 0;

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
function doInit(){

    // Input, Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_NAME_S,       "GEN^10",       NORMAL);         //    
    initEmEdit(EM_FROM_DT,      "YYYYMMDD",     PK);           //조회 시작기간    
    initEmEdit(EM_TO_DT,        "TODAY",        PK);           //조회 종료기간
    
    //조회일자 초기값.
    EM_FROM_DT.text = addDate("M", "-1", '<%=strToMonth%>');
    EM_TO_DT.text   = addDate("D", "-1", EM_TO_DT.text);
    //
    EM_FROM_DT.Focus();
    
    //초기조회
    showMaster();
}

function gridCreate1(){
    var hdrProperies    = '<FC>id={currow}          name="NO"                width=30    align=center</FC>'
						+ '<FC>id=CLUB_ID           name="클럽ID"             width=50    align=center</FC>'
						+ '<FC>id=CLUB_NAME         name="클럽명"             width=120   align=left</FC>'
						+ '<FC>id=CLUB_INFO         name="클럽설명"            width=285   align=left</FC>'
						+ '<FC>id=CUST_TCNT         name="보유 회원수"          width=80   align=right</FC>'
						+ '<FC>id=CUST_ICNT         name="기간중 가입 회원수"     width=110   align=right</FC>'
						+ '<FC>id=CUST_OCNT         name="기간중 탈퇴 회원수"     width=110   align=right</FC>';  
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies    = '<FC>id={currow}          name="NO"              width=30   align=center</FC>'
				    	+ '<FC>id=CLUB_ID           name="클럽ID"           width=80    align=center</FC>'
				    	+ '<FC>id=CLUB_NAME         name="클럽명"           width=130    align=left</FC>'
				    	+ '<FC>id=CUST_ID           name="회원ID"           width=80    align=center</FC>'
				    	+ '<FC>id=CUST_NAME         name="회원명"           width=100    align=left</FC>'
				    	+ '<G> name="주거형태"'
				    	+ '<FC>id=HOUSE_TYPE        name="코드"             width=40    align=center</FC>'
				    	+ '<FC>id=HOUSE_NAME        name="명"               width=80    align=left</FC>'
				    	+ '</G>'
				    	+ '<G> name="선호부문"'
				    	+ '<FC>id=FAVOR_DEPT1_YN    name="백화점쇼핑"        width=80    align=center</FC>'
				    	+ '<FC>id=FAVOR_DEPT2_YN    name="문화센터"          width=80    align=center</FC>'
				    	+ '<FC>id=FAVOR_DEPT3_YN    name="아트센터"          width=80    align=center</FC>'
				    	+ '<FC>id=FAVOR_DEPT4_YN    name="호텔"             width=80    align=center</FC>'
				    	+ '<FC>id=FAVOR_DEPT5_YN    name="테마파크"          width=80    align=center</FC>'
				    	+ '</G>'
				    	+ '<G> name="월평균소득"'
				    	+ '<FC>id=INCOME_AMT        name="코드"             width=40    align=center</FC>'
				    	+ '<FC>id=INCOME_NAME       name="명"               width=120    align=left</FC>'
				    	+ '</G>'
				    	+ '<FC>id=POINT             name="보유포인트"        width=80    align=right</FC>'
				    	+ '<FC>id=CONF_DATE         name="가입일자"          width=100    align=center</FC>';  
                     
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
	if(trim(EM_FROM_DT.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_FROM_DT.Focus();
        return;
    }
    if( addDate("M", "-2", '<%=strToMonth%>') > EM_FROM_DT.Text ){          // 조회시작일 3개월이내
        showMessage(EXCLAMATION, OK, "USER-1000","조회시작일자는 3개월이내로 선택하세요.");
        EM_FROM_DT.Focus();
        return;
    }
    if(trim(EM_TO_DT.Text).length == 0){    // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_TO_DT.Focus();
        return;
    }
    if(EM_FROM_DT.Text > EM_TO_DT.Text){      // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_FROM_DT.Focus();
        return;
    }
    //조회
    showMaster();
}
/**
 * btn_Excel()
 * 작   성   자 : 조형욱
 * 작   성   일 : 2010-02-22
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
 function btn_Excel() {
	 var parameters  = "가입일자="+ EM_FROM_DT.Text +"~"+ EM_TO_DT.Text;
	 parameters = EM_NAME_S.text.length > 0? parameters + " 성명="+ EM_NAME_S.text : parameters;
     
     var ExcelTitle = "클럽회원 목록";

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
    strFromDt       = EM_FROM_DT.text;
    strToDt         = EM_TO_DT.text;
    var parameters  = "&strFromDt="     + encodeURIComponent(strFromDt)
                    + "&strToDt="       + encodeURIComponent(strToDt);
    TR_MAIN.Action  ="/dcs/dctm133.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	EM_FROM_DT.Focus();  
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
    strClubId   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CLUB_ID");
    strName     = EM_NAME_S.text;
    strFromDt   = EM_FROM_DT.text;
    strToDt     = EM_TO_DT.text;
        
    var goTo        = "searchDetail";    
    var action      = "O";     
   
    DS_I_DATA.ClearAll();
    DS_I_DATA.setDataHeader('CUST_NAME:STRING(40),CLUB_ID:STRING(40),BEG_DT:STRING(12),END_DT:STRING(12)');
    DS_I_DATA.Addrow();
    DS_I_DATA.NameValue(DS_I_DATA.CountRow, "CUST_NAME")    = strName;
    DS_I_DATA.NameValue(DS_I_DATA.CountRow, "CLUB_ID")      = strClubId;
    DS_I_DATA.NameValue(DS_I_DATA.CountRow, "BEG_DT")       = strFromDt;
    DS_I_DATA.NameValue(DS_I_DATA.CountRow, "END_DT")       = strToDt;
    
    TR_DETAIL.Action  = "/dcs/dctm133.dm?goTo="+goTo;  
    TR_DETAIL.KeyValue="SERVLET(O:DS_O_DETAIL=DS_O_DETAIL,I:DS_I_DATA=DS_I_DATA)"; //조회는 O
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
        showMessage(INFORMATION, OK, "USER-1000", strMsg[1]);
    }
</script>
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        var strMsg = TR_DETAIL.SrvErrMsg('UserMsg',i).split('|');
        EM_BRCH_ID.Text = strMsg[0]; 
        showMessage(INFORMATION, OK, "USER-1000", strMsg[1]);
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
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_FROM_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_FROM_DT)){
    	 EM_FROM_DT.text = addDate("M", "-1", '<%=strToMonth%>');
    }
</script>
   
   
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_TO_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_TO_DT)){
    	 EM_TO_DT.text   = addDate("D", "-1", EM_TO_DT.text);
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
<object id="DS_O_CLUB" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_DATA" classid=<%=Util.CLSID_DATASET%>> </object>
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
                <td><!-- search start -->
                <table width="100%" border="0" cellpadding="0" cellspacing="0"
                    class="s_table">
                    <tr>
                        <th width="80" class="point">가입일자</th>
                        <td width="320"><comment id="_NSID_"> <object id=EM_FROM_DT
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_FROM_DT)" />- <comment
                            id="_NSID_"> <object id=EM_TO_DT
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_TO_DT)" />
                        </td>
                        <th width="80">성명</th>
                            <td><comment id="_NSID_"> <object
                                id=EM_NAME_S classid=<%=Util.CLSID_EMEDIT%> width=154
                                tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
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
					width="100%" height=215 classid=<%=Util.CLSID_GRID%> tabindex=1>
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
                    width="100%" height=285 classid=<%=Util.CLSID_GRID%> tabindex=1>
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

</body>
</html>
