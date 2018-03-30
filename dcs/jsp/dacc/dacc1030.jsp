<!-- 
 * 시스템명 : 포인트카드 > 제휴카드사 > 실적조회 > 제휴카드사포인트 검증
 * 작  성  일  : 2010.05.24
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dacc1030.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.05.24 (김영진) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"    prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	request.setCharacterEncoding("utf-8");
	String dir = BaseProperty.get("context.common.dir");

	String strToMonth = new java.text.SimpleDateFormat("yyyyMM")
			.format(new java.util.Date());
	strToMonth = strToMonth + "01";
%>
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
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var bfListRowPosition = 0;                             // 이전 List Row Position
var params = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-24
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_GAP_LIST.setDataHeader('<gauce:dataset name="H_GAPLIST"/>');
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //마스터
    
    // EMedit에 초기화
    //-- 검색 필드
    initEmEdit(EM_S_DT_S,       "YYYYMMDD", PK);      //시작일
    initEmEdit(EM_E_DT_S,       "TODAY",    PK);      //종료일
    initEmEdit(EM_BRCH_ID_S,    "GEN^10",   NORMAL);  //가맹점코드
    initEmEdit(EM_BRCH_NAME_S,  "GEN^40",   READ);    //가맹점명    
    initEmEdit(EM_STR_CD_S,     "GEN^10",   NORMAL);  //STR_CD
    
    //조회일자 초기값.
    EM_S_DT_S.text = <%=strToMonth%>;
    EM_STR_CD_S.style.display = "none";
    
    initComboStyle(LC_CARD_S,DS_CARD, "CODE^0^30,NAME^0^80", 1, NORMAL);    //상태
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getCardCode("DS_CARD", "", "", "Y");    
    LC_CARD_S.BindColVal = "%";

    btn_Search();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        name="NO"              width=30    align=center</FC>'
    	             + '<FC>id=STR_CD          name="가맹점ID"         width=130  align=left show=false </FC>'
                     + '<FC>id=BRCH_NM         name="가맹점명"         width=100  align=left </FC>'
                     + '<FC>id=PAY_DTL         name="제휴카드사"       width=150  align=left show=false </FC>'
                     + '<FC>id=PAY_DTL_NM      name="제휴카드사명"     width=80   align=left </FC>'
                     + '<FC>id=SALE_DT         name="적립일시"         width=80   align=center mask="XXXX/XX/XX" SumText="합계"</FC>'
                     + '<G> name="포인트카드"'
                     + '<FC>id=PCARD_COUNT     name="적립건수"         width=70    align=right  SumText=@sum</FC>'
                     + '<FC>id=PCARD_POINT     name="적립금"           width=70    align=right  SumText=@sum</FC>'
                     + '</G>'
                     + '<G> name="POS"'
                     + '<FC>id=POS_COUNT       name="적립건수"         width=70    align=right  SumText=@sum</FC>'
                     + '<FC>id=POS_POINT       name="적립금"           width=70    align=right  SumText=@sum</FC>'
                     + '</G>'
                     + '<G> name="카드사"'
                     + '<FC>id=JCOMP_COUNT     name="적립건수"         width=70    align=right  SumText=@sum</FC>'
                     + '<FC>id=JCOMP_POINT     name="적립금"           width=70    align=right  SumText=@sum</FC>'
                     + '</G>'
                     + '<G> name="카드사 - 포인트카드"'
                     + '<FC>id=CHA1_COUNT      name="차이건수"         width=70    align=right  SumText=@sum</FC>'
                     + '<FC>id=CHA1_POINT      name="차이금액"         width=70    align=right  SumText=@sum</FC>'
                     + '</G>'
                     + '<G> name="카드사 - POS"'
                     + '<FC>id=CHA2_COUNT      name="차이건수"         width=70    align=right  SumText=@sum</FC>'
                     + '<FC>id=CHA2_POINT      name="차이금액"         width=70    align=right  SumText=@sum</FC>'
                     + '</G>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    GR_MASTER.ViewSummary = "1";
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}     name="NO"                width=30    align=center</FC>'
                     + '<FC>id=STR_CD       name="가맹점ID"           width=130   align=left show=false </FC>'
                     + '<FC>id=BRCH_NM      name="가맹점명"           width=100   align=left </FC>'
                     + '<FC>id=PAY_DTL      name="제휴카드사"         width=150   align=left show=false </FC>'
                     + '<FC>id=PAY_DTL_NM   name="제휴카드사명"        width=100  align=left </FC>'
                     + '<FC>id=RECP_NO      name="영수증번호"          width=150  align=center SumText="합계"</FC>'
                     + '<FC>id=CAPPR_NO     name="카드승인번호"        width=110  align=center </FC>'
                     + '<FC>id=PCARD_POINT  name="적립분담금"        width=90   align=right SumText=@sum</FC>'
                     + '<FC>id=POS_POINT    name="POS적립금"           width=90   align=right SumText=@sum</FC>'
                     + '<FC>id=JCOMP_POINT  name="카드사적립금"        width=100  align=right SumText=@sum</FC>'
                     + '<FC>id=CHA1_POINT   name="카드사 - 포인트카드"  width=120  align=right SumText=@sum</FC>'
                     + '<FC>id=CHA2_POINT   name="카드사 - POS"        width=120   align=right SumText=@sum</FC>';
                     
    initGridStyle(GR_GAP_LIST, "common", hdrProperies, false);
    GR_GAP_LIST.ViewSummary = "1";
}
/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-24
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    if (trim(EM_S_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "조회기간");
        EM_S_DT_S.Focus();
        return;
    } else if (trim(EM_E_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "조회기간");
        EM_E_DT_S.Focus();
        return;
    }     
    
    if (trim(EM_S_DT_S.text) > trim(EM_E_DT_S.text)) { 
        showMessage(EXCLAMATION, OK, "USER-1015",  "");
        EM_S_DT_S.Focus();
        return;
    }
    
    bfListRowPosition = 0;
    //조회
    showMaster();
}

/**
 * btn_Excel()
 * 작   성   자 : 김영진
 * 작   성   일 : 2010-05-24
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */ 
 function btn_Excel() {

     var ExcelTitle = "제휴카드사포인트 검증";
     openExcel2(GR_MASTER, ExcelTitle, params, true );
     GR_MASTER.Focus();
 }

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * showMaster()
  * 작 성 자 : 김영진
  * 작 성 일 : 2010-05-24
  * 개      요  : 조회
  * return값 :
  */
function showMaster(){
    var strSdt    = EM_S_DT_S.text;
    var strEdt    = EM_E_DT_S.text;
    var strStrCd  = EM_STR_CD_S.text;
	
    params = "조회시작일자="      + EM_S_DT_S.text
           + " -조회종료일자="    + EM_E_DT_S.text
           + " -가맹점코드="      + EM_BRCH_ID_S.text
           + " -가맹점명="        + EM_BRCH_NAME_S.text
           + " -점코드="          + EM_STR_CD_S.text
           + " -제휴신용카드사="   + LC_CARD_S.BindColVal;
                   
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strSdt="     + encodeURIComponent(strSdt)
                    + "&strEdt="     + encodeURIComponent(strEdt)
                    + "&strStrCd="   + encodeURIComponent(strStrCd)
                    + "&strCardCd="  + encodeURIComponent(LC_CARD_S.BindColVal);
                  
    TR_MAIN.Action  = "/dcs/dacc103.da?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    setPorcCount("SELECT", DS_O_MASTER.RealCount(1, DS_O_MASTER.CountRow));

    if (DS_O_MASTER.CountRow > 0 ) {
        GR_MASTER.Focus();        
    }
    else {
        EM_S_DT_S.Focus();    
    }    
}

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-24
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
    EM_BRCH_NAME_S.Text = "";//조건입력시 코드초기화
    EM_STR_CD_S.Text    = "";//조건입력시 코드초기화
    if (EM_BRCH_ID_S.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_BRCH_ID_S.Text.length == 10) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_ID_S.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
                EM_BRCH_ID_S.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
                EM_BRCH_NAME_S.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
                EM_STR_CD_S.Text    = DS_O_RESULT.NameValue(1, "STR_CD");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getBrchPop2(EM_BRCH_ID_S,EM_BRCH_NAME_S, EM_STR_CD_S);
            }
        }
    }
}
  
function getCardCode(strDataSet, sysPart, commPart, allGb, nulGb, objComboNm) {
    DS_I_COMMON.setDataHeader('SYS_PART:STRING(1),COMM_PART:STRING(4),ALL_GB:STRING(1),NUL_GB:STRING(1)');
	    
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(1, "SYS_PART")  = sysPart;
	DS_I_COMMON.NameValue(1, "COMM_PART") = commPart;
	DS_I_COMMON.NameValue(1, "ALL_GB")    = allGb ;
	DS_I_COMMON.NameValue(1, "NUL_GB")    = nulGb == null ? 'N' : nulGb ;
	    
	TR_MAIN.Action  = "/dcs/dcom100.cc?goTo=getCardCode";
	TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
	TR_MAIN.Post();
	    
	//if (allGb == "Y") {
	if (typeof(objComboNm) == "object" ) objComboNm.index = '0';
	//}
}  

/**
 * doClick()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-24
 * 개       요     : 차이내역 조회
 * return값 : void
 */
function doClick(row){
    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;
    var strStrCd    = DS_O_MASTER.NameValue(row ,"STR_CD");
    var strSaleDt   = DS_O_MASTER.NameValue(row ,"SALE_DT");
    var strPayDtl   = DS_O_MASTER.NameValue(row ,"PAY_DTL");
    var goTo        = "searchGapList";    
    var action      = "O";     
    var parameters  = "&strStrCd=" + encodeURIComponent(strStrCd)
                    + "&strSaleDt="+ encodeURIComponent(strSaleDt)
                    + "&strPayDtl="+ encodeURIComponent(strPayDtl);
    TR_DETAIL.Action  = "/dcs/dacc103.da?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_O_GAP_LIST=DS_O_GAP_LIST)"; //조회는 O
    TR_DETAIL.Post();
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                        *-->
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
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--DS_O_MASTER  OnRowPosChanged(row)-->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    if(clickSORT) return;
    //그리드 첫 row 상세조회
    if(row != 0){
        if( bfListRowPosition == row)
            return;
            bfListRowPosition = row;
            doClick(row);
    }else{
        DS_O_GAP_LIST.ClearData();
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 가맹점명 onKillFocus() -->
<script language=JavaScript for=EM_BRCH_ID_S event=onKillFocus()>
    if ((EM_BRCH_ID_S.Modified) && (EM_BRCH_ID_S.Text.length != 10)) {
        EM_BRCH_NAME_S.Text = "";
        EM_STR_CD_S.Text    = "";
    }
</script>
<!-- Grid sorting 기능  -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>
<!-- Grid sorting 기능  -->
<script language=JavaScript for=GR_GAP_LIST event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_S_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_DT_S)){
    	EM_S_DT_S.text = <%=strToMonth%>;
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_E_DT_S event=onKillFocus()>
    checkDateTypeYMD(EM_E_DT_S);
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
<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_GAP_LIST" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 공통콤보용 -->
<comment id="_NSID_">
<object id="DS_CARD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 팝업용  -->
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
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
						<th width="80" class="point">조회기간</th>
						<td width="200"><comment id="_NSID_"> <object
							id=EM_S_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DT_S)" />- <comment
							id="_NSID_"> <object id=EM_E_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_E_DT_S)" /></td>
						<th width="80">가맹점명</th>
						<td width="205"><comment id="_NSID_"> <object
							id=EM_BRCH_ID_S classid=<%=Util.CLSID_EMEDIT%> width=75
							tabindex=1 align="absmiddle"
							onKeyUp="javascript:keyPressEvent(event.keyCode);"></object> </comment><script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							align="absmiddle"
							onclick="getBrchPop2(EM_BRCH_ID_S,EM_BRCH_NAME_S, EM_STR_CD_S)" />
						<comment id="_NSID_"> <object id=EM_BRCH_NAME_S
							classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1
							align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
							<comment id="_NSID_"> <object id=EM_STR_CD_S
                            classid=<%=Util.CLSID_EMEDIT%> width=0
                            align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
						<th width="80">제휴신용카드사</th>
						<td><comment id="_NSID_"> <object id=LC_CARD_S
							classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=100 tabindex=1></object>
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
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><object id=GR_MASTER width="100%" height=246
					classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="sub_title PT07 PB02"><img
			src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
			align="absmiddle" class="PR03" /> 차이내역</td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_GAP_LIST
					width="100%" height=230 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_GAP_LIST">
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
