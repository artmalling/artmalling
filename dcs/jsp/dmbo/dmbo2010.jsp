<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽운영 > 기준정보 > 캠페인 조회
 * 작  성  일  : 2010.01.14
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dmbo2010.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.01.14 (김영진) 신규작성
 *           2010.03.17 (김영진) 기능생성
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
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<%
	String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	strToMonth = strToMonth + "01";
	
	String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>
<script LANGUAGE="JavaScript">

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-17
 * 개       요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    //EMedit에 초기화
    initEmEdit(EM_S_DT_S,        "YYYYMMDD",     PK);          //조회 시작기간    
    initEmEdit(EM_E_DT_S,        "TODAY",        PK);          //조회 종료기간
    
    initEmEdit(EM_CAMPAIGN_ID,   "GEN^17",       READ);        //캠페인코드
    initEmEdit(EM_CAMPAIGN_NM,   "GEN^40",       READ);        //캠페인명
    initEmEdit(EM_STATUS,        "GEN^10",       READ);        //캠페인상태
    initEmEdit(EM_START_DT,      "####/##/##",   READ);        //시작일
    initEmEdit(EM_END_DT,        "####/##/##",   READ);        //종료일
    initEmEdit(EM_CUST_CNT,      "NUMBER^9^0",   READ);        //인원수
    initEmEdit(EM_STR_CNT,       "NUMBER^9^0",   READ);        //적용가맹점수

    //조회일자 초기값.
    EM_S_DT_S.text = addDate("M", "-1", '<%=strToMonth%>');
    
    //OPEN 시 조회
    showMaster();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"          width=30       align=center</FC>'
                     + '<FC>id=CAMPAIGN_ID      name="캠페인ID"    width=140      align=center</FC>'
                     + '<FC>id=CAMPAIGN_NM      name="캠페인명"    width=170      align=left</FC>'
                     + '<FC>id=STATUS           name="상태"        width=70       align=center</FC>'
                     + '<FC>id=CUST_CNT         name="인원수"      width=90      align=right</FC>'
                     + '<FC>id=STR_CNT          name="점포수"      width=90       align=right</FC>'
                     + '<FC>id=START_DT         name="시작일자"    width=90       align=center     mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=END_DT           name="종료일자"    width=90       align=center     mask="XXXX/XX/XX"</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false); 
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-17
 * 개       요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	
    if(trim(EM_S_DT_S.Text).length == 0){     // 조회시작일
	     showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	     EM_S_DT_S.Focus();
	     return;
	}
    if(trim(EM_E_DT_S.Text).length == 0){    // 조회 종료일
	     showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	     EM_E_DT_S.Focus();
	     return;
　　 }
    if(EM_S_DT_S.Text > EM_E_DT_S.Text){     // 조회일 정합성
	     showMessage(EXCLAMATION, OK, "USER-1015");
	     EM_S_DT_S.Focus();
	     return;
	} 
	showMaster();
	//조회결과 Return
	setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-17
 * 개       요     : 캠페인 조회 
 * return값 : void
 */
function showMaster(){
    var strSDt   = EM_S_DT_S.Text;
    var strEDt   = EM_E_DT_S.Text;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strSDt="  + encodeURIComponent(strSDt)
                    + "&strEDt="  + encodeURIComponent(strEDt);    
    TR_MAIN.Action  ="/dcs/dmbo201.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	EM_S_DT_S.Focus();
    }
}
 
/**
 * doClick()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-17
 * 개       요     : 선택된 캠페인 정보 상세 조회 
 * return값 : void
 */
function doClick(row){

    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;
    
    var strCamId    = DS_O_MASTER.NameValue(row ,"CAMPAIGN_ID");
    var goTo        = "searchDetail";    
    var action      = "O";     
    var parameters  = "&strCamId=" + encodeURIComponent(strCamId);
    TR_DETAIL.Action  = "/dcs/dmbo201.do?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
 }

/**
 * openCust(camId,camNm,segNm)
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-17
 * 개       요     : 캠페인회원조회팝업
 * return값 : void
 */
function openCust(camId,camNm){
	var rtnMap  = new Map();
	var arrArg  = new Array();
	arrArg.push(camId.Text);
	arrArg.push(camNm.Text);
	
    var returnVal = window.showModalDialog("/dcs/dmbo201.do?goTo=popCust",
    		        arrArg,
                    "dialogWidth:825px;dialogHeight:499px;scroll:no;" +
                    "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    GR_MASTER.Focus();
 }
 
/**
 * openBrch(camId,camNm)
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-17
 * 개       요     : 캠페인가맹점조회팝업
 * return값 : void
 */
function openBrch(camId,camNm){
    var rtnMap  = new Map();
    var arrArg  = new Array();
    arrArg.push(camId.Text);
    arrArg.push(camNm.Text);

    var returnVal = window.showModalDialog("/dcs/dmbo201.do?goTo=popBrch",
    		        arrArg,
                    "dialogWidth:448px;dialogHeight:410px;scroll:no;" +
                    "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    GR_MASTER.Focus();
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
<script language=JavaScript for=TR_DETAIL event=onFail>
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
        doClick(row);
        enableControl(IMG_OPENCUST , true);
        enableControl(IMG_OPENBRCH , true);
    }else{
        DS_O_DETAIL.ClearData();
        enableControl(IMG_OPENCUST , false);
        enableControl(IMG_OPENBRCH , false);
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_S_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_DT_S)){
    	EM_S_DT_S.Text = addDate("M", "-1", '<%=strToMonth%>');
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_E_DT_S event=onKillFocus()>
	if(!checkDateTypeYMD(EM_E_DT_S)){
		EM_E_DT_S.text = <%=toDate%>;
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
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>> </object>
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
						<th width="100" class="point">조회일자</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_S_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle">
						</object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DT_S)" />- <comment
							id="_NSID_"> <object id=EM_E_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle">
						</object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_E_DT_S)" /></td>
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
					width="100%" height=424 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script> _ws_(_NSID_);</script></td>
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
						<th width="80">캠페인코드</th>
						<td width="180"><comment id="_NSID_"> <object
							id=EM_CAMPAIGN_ID classid=<%=Util.CLSID_EMEDIT%> width=168
							tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">캠페인명</th>
						<td width="180"><comment id="_NSID_"> <object
							id=EM_CAMPAIGN_NM classid=<%=Util.CLSID_EMEDIT%> width=168
							tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">캠페인상태</th>
						<td><comment id="_NSID_"> <object id=EM_STATUS
							classid=<%=Util.CLSID_EMEDIT%> width=142 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>시작일</th>
						<td><comment id="_NSID_"> <object id=EM_START_DT
							classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th>종료일</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_END_DT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
							align="absmiddle">"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>인원수</th>
						<td><comment id="_NSID_"> <object id=EM_CUST_CNT
							classid=<%=Util.CLSID_EMEDIT%> width=100> </object> </comment> <script> _ws_(_NSID_);</script>
						&nbsp;<img src="/<%=dir%>/imgs/btn/search_detail_s.gif"
							id="IMG_OPENCUST" align="absmiddle" tabindex=1
							onkeydown="if(event.keyCode==13){openCust(EM_CAMPAIGN_ID,EM_CAMPAIGN_NM)}"
							onclick="javascript:openCust(EM_CAMPAIGN_ID,EM_CAMPAIGN_NM)" />
						</td>
						<th>점포수</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_STR_CNT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;<img
							src="/<%=dir%>/imgs/btn/search_detail_s.gif" id="IMG_OPENBRCH"
							align="absmiddle" tabindex=1
							onkeydown="if(event.keyCode==13){openBrch(EM_CAMPAIGN_ID,EM_CAMPAIGN_NM)}"
							onclick="javascript:openBrch(EM_CAMPAIGN_ID,EM_CAMPAIGN_NM)" /></td>
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
	<param name=DataID value=DS_O_DETAIL>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=CAMPAIGN_ID       ctrl=EM_CAMPAIGN_ID       Param=Text</c>
            <c>col=CAMPAIGN_NM       ctrl=EM_CAMPAIGN_NM       Param=Text</c>
            <c>col=STATUS            ctrl=EM_STATUS            Param=Text</c>
            <c>col=START_DT          ctrl=EM_START_DT          Param=Text</c>
            <c>col=END_DT            ctrl=EM_END_DT            Param=Text</c>
            <c>col=CUST_CNT          ctrl=EM_CUST_CNT          Param=Text</c>
            <c>col=STR_CNT           ctrl=EM_STR_CNT           Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
