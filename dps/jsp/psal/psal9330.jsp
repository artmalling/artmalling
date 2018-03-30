<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 신용카드대금청구 > 반송관리 > 반송상세데이터조회
 * 작  성  일  : 2010.06.01
 * 작  성  자  : 
 * 수  정  자  : 
 * 파  일  명  : psal9330.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.06.01 (김영진) 신규작성
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
    String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
    strToMonth = strToMonth + "01";
 // PID 확인을 위한
    String pageName = request.getRequestURI();
    int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
    int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
    pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strExlParam = "";
var strMsg = "입금수신일자";
var top = 140;		//해당화면의 동적그리드top위치
var g_strPid           = "<%=pageName%>";                 // PID

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-01
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	 //Input, Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    //EMedit에 초기화
    initEmEdit(EM_APPR_NO,     "0000000000",  NORMAL);
    initEmEdit(EM_PAY_DT_S,    "YYYYMMDD",    PK);
    initEmEdit(EM_PAY_DT_E,    "TODAY",       PK);           //조회 

    initEmEdit(EM_CARD_NO,     "0000-0000-0000-0000-0000",  NORMAL);       //카드번호

    initComboStyle(LC_STR_CD,   DS_STR_CD,     "CODE^0^30,NAME^0^100",  1, PK);
    initComboStyle(LC_BCOMP_CD, DS_BCOMP_CD,   "CODE^0^30,NAME^0^100",  1, NORMAL);
    initComboStyle(LC_BRCH_CD,  DS_BRCH_CD,    "CODE^0^120,NAME^0^180", 1, NORMAL);
    initComboStyle(LC_DATA_FLAG, DS_DATA_FLAG, "CODE^0^30,NAME^0^100",  1, NORMAL);

    //초기값설정
    getStore("DS_STR_CD", "Y", "", "N");
    setComboData(LC_STR_CD,  DS_STR_CD.NameValue(0, "CODE"));
    getEtcCode("DS_DATA_FLAG", "D", "D034", "Y");
    
    //매입사코드콤보 목록 가져오기 및 초기값 설정
    getBcompCode("DS_BCOMP_CD", "", "", "Y");
    setComboData(LC_BCOMP_CD,  "%"); 
    setComboData(LC_DATA_FLAG,  "%"); 
    
    EM_PAY_DT_S.text =  <%=strToMonth%>;
    
    showMaster();
}

function gridCreate1(){
    var hdrProperies    = '<FC>id={currow}     name="NO"                width=30    align=center</FC>'
                        + '<FC>id=PAY_DT       name="입금수신일자"       width=85    align=center mask="XXXX/XX/XX" SumText= "합계"</FC>'
                        + '<FC>id=DATA_FLAG    name="데이터구분"         width=80    align=left</FC>'
                        + '<FC>id=SALE_DT      name="매출일자"           width=65    align=center mask="XX/XX/XX"</FC>'
                        + '<FC>id=RECV_DT      name="청구일자"           width=65    align=center mask="XX/XX/XX"</FC>'
                        + '<FC>id=CARD_NO      name="카드번호"           width=170   align=center mask="XXXX-XXXX-XXXX-XXXX-XXXX"</FC>'
                        + '<FC>id=DIV_MONTH    name="할부기간"           width=70    align=right</FC>'
                        + '<FC>id=APPR_NO      name="승인번호"           width=80    align=left</FC>'
                        + '<FC>id=CRTN_CD      name="카드사 반송코드"     width=100   align=center</FC>'
                        + '<FC>id=VRTN_FLAG    name="VAN사 반송코드/명"   width=130   align=left</FC>'
                        + '<FC>id=TRADE_AMT    name="거래금액"           width=100   align=right      SumText=@sum</FC>'
                        + '<FC>id=CCOMP_NM     name="카드사코드"         width=90   align=left</FC>'
                        + '<FC>id=JBRCH_ID     name="카드사 가맹점번호"   width=110   align=left</FC>'
                        + '<FC>id=JBRCH_NM     name="가맹점번호명"       width=90   align=left</FC>'
                        + '<FC>id=CHECKCARD_YN     name="체크카드여부"       width=90   align=center</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    GR_MASTER.ViewSummary = "1";
}

/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-01
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(trim(LC_STR_CD.BindColVal).length == 0){
	    showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
	    LC_STR_CD.Focus();
	    return false;
	}
	
    
    if(RD_GUBUN.CodeValue == "1"){
        strMsg = "반송수신";
    }else if(RD_GUBUN.CodeValue == "2"){
        strMsg = "매출일자";
    }
    
    if(trim(EM_PAY_DT_S.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001", strMsg + " 시작일");
        EM_PAY_DT_S.Focus();
        return;
    }
    if(trim(EM_PAY_DT_E.Text).length == 0){    // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001", strMsg + " 종료일");
        EM_PAY_DT_E.Focus();
        return;
    }
    if(EM_PAY_DT_S.Text > EM_PAY_DT_E.Text){   // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_PAY_DT_S.Focus();
        return;
    }

    //조회
    showMaster();
}

/**
 * btn_Excel()
 * 작   성   자 : 김영진
 * 작   성   일 : 2010-06-01
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    var ExcelTitle = "입금상세데이터조회";
//    openExcel2(GR_MASTER, ExcelTitle, strExlParam, true );
        openExcel5(GR_MASTER, ExcelTitle, strExlParam, true, "",g_strPid );

    GR_MASTER.Focus();
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-01
 * 개       요     : 입금상세데이터조회 
 * return값 : void
 */
function showMaster(){    

	var strStrCd   = LC_STR_CD.BindColVal;
	var strPayDtS  = EM_PAY_DT_S.text;  
	var strPayDtE  = EM_PAY_DT_E.text;  
	var strBcompCd = LC_BCOMP_CD.BindColVal;
	var strJbrchId = LC_BRCH_CD.BindColVal; 
	var strDataFlag= LC_DATA_FLAG.BindColVal; 
	var strCardNo  = EM_CARD_NO.text;
	var strApprNo  = EM_APPR_NO.text;
	
	strExlParam = "점포명="           + LC_STR_CD.Text
	            + " -조회구분="       + RD_GUBUN.DataValue
                + " -" + strMsg + "=" + strPayDtS + "~" 　  +   strPayDtE
                + " -카드매입사="     + LC_BCOMP_CD.Text
                + " -가맹점번호="     + strJbrchId
                + " -데이터구분="     + strDataFlag
                + " -카드번호="       + strCardNo
                + " -승인번호="       + strApprNo;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strStrCd="   + encodeURIComponent(strStrCd)
                    + "&strPayDtS="  + encodeURIComponent(strPayDtS)
                    + "&strPayDtE="  + encodeURIComponent(strPayDtE)
                    + "&strBcompCd=" + encodeURIComponent(strBcompCd)
                    + "&strJbrchId=" + encodeURIComponent(strJbrchId)
                    + "&strDataFlag="+ encodeURIComponent(strDataFlag)
                    + "&strCardNo="  + encodeURIComponent(strCardNo)
                    + "&strApprNo="  + encodeURIComponent(strApprNo)
                    + "&strGubun="   + encodeURIComponent(RD_GUBUN.CodeValue);
    
    TR_MAIN.Action  ="/dps/psal933.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //그리드 첫 row 상세조회
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	LC_STR_CD.Focus();
    }

    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-01
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
     EM_CCOMP_NM.Text = "";//조건입력시 코드초기화
    if (EM_CCOMP_CD.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_CCOMP_CD.Text.length == 2) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_CARDBIN", EM_CCOMP_CD.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
                EM_CCOMP_CD.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
                EM_CCOMP_NM.Text   = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getCcompPop(EM_CCOMP_CD, EM_CCOMP_NM);
            }
        }
    }
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                        *-->
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
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<!-- 매입사콤보 선택이벤트 처리 -->
<script language=JavaScript for=LC_BCOMP_CD event=OnSelChange()>
    DS_BRCH_CD.ClearData();
    if(this.BindColVal != "%"){
        LC_BRCH_CD.Enable = true;
        getJbrchCode("DS_BRCH_CD", this.BindColVal, "N");
    }else{
        LC_BRCH_CD.Enable = false;
    }
</script>

<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 입금수신일자 Start onKillFocus() -->
<script language=JavaScript for=EM_PAY_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_PAY_DT_S)){
    	EM_PAY_DT_S.text =  <%=strToMonth%>;
    }
</script>
 <!-- 입금수신일자 End onKillFocus() -->
<script language=JavaScript for=EM_PAY_DT_E event=onKillFocus()>
    if(!checkDateTypeYMD(EM_PAY_DT_E)){
    	initEmEdit(EM_PAY_DT_E,    "TODAY",       PK);  
    }
</script>

<!-- 조회구분 선택이벤트 처리 -->
<script language=JavaScript for=RD_GUBUN event=OnSelChange()>
    initEmEdit(EM_PAY_DT_S,    "YYYYMMDD",  PK);           
    initEmEdit(EM_PAY_DT_E,    "TODAY",     PK);           
    EM_PAY_DT_S.text = <%=strToMonth%>;
    DS_O_MASTER.ClearData();
    if(this.CodeValue == "1"){
        document.getElementById('titleDT').innerHTML = "입금수신일자";
    }else if(this.CodeValue == "2"){
        document.getElementById('titleDT').innerHTML = "매출일자";
    }
</script>
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리    끝                                                                                                                               *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                             *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
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
<object id="DS_BRCH_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_DATA_FLAG" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
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
<!--* E. 본문시작                                                                                                                                                              *-->
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
						<th width="70" class="point">점포명</th>
						<td width="160"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=145
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">조회구분</th>
                        <td width="168"><comment id="_NSID_"> <object
                            id=RD_GUBUN classid=<%=Util.CLSID_RADIO%>
                            style="height: 20; width: 166" tabindex=1>
                            <param name=Cols value="2">
                            <param name=Format value="1^입금수신일자,2^매출일자">
                            <param name="AutoMargin" value="true">
                            <param name=CodeValue value="1">
                        </object> </comment><script> _ws_(_NSID_);</script></td>
						<th width="80" class="point"><span id="titleDT" style="Color: 146ab9">입금수신일자</span></th>
						<td><comment id="_NSID_"> <object
							id=EM_PAY_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_PAY_DT_S)" />- <comment
                            id="_NSID_"> <object id=EM_PAY_DT_E
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_PAY_DT_E)" /></td>
					</tr>
                    <tr>                
                        <th width="70">카드매입사</th>
                        <td width="160"><comment id="_NSID_"> <object
                            id=LC_BCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=145
                            align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width="80">가맹점번호</th>
                        <td width="168"><comment id="_NSID_"> <object
                            id=LC_BRCH_CD classid=<%=Util.CLSID_LUXECOMBO%> width=166
                            align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width="80">데이터구분</th>
                        <td><comment id="_NSID_"> <object
                            id=LC_DATA_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=174
                            align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                    </tr>
					<tr>
						<th width="70">카드번호</th>
						<td width="160"><comment id="_NSID_"> <object
							id=EM_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width=155
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">승인번호</th>
                        <td colspan="3"><comment id="_NSID_"> <object id=EM_APPR_NO
                            classid=<%=Util.CLSID_EMEDIT%> width=162 align="absmiddle"
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

	<tr>
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=455 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>

</table>
</div>
<body>
</html>
