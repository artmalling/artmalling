<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 신용카드대금청구 > 청구관리 > 매출일자별 청구현황
 * 작  성  일  : 2010.05.30
 * 작  성  자  : 
 * 수  정  자  : 
 * 파  일  명  : psal9450.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.05.30 (김영진) 신규작성
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
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strExlParam = "";
var strMsg = "청구일자";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-30
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    // Input, Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    //EMedit에 초기화
    initEmEdit(EM_CHRG_DT_S,     "YYYYMMDD",    PK);  //청구일자
    initEmEdit(EM_CHRG_DT_E,     "TODAY",       PK);      
    
    initComboStyle(LC_STR_CD, DS_COND_STR_CD, "CODE^0^30, NAME^0^80", 1, PK);
    initComboStyle(LC_BCOMP_CD, DS_COND_BCOMP_CD, "CODE^0^30, NAME^0^80", 1, NORMAL);

    getStore("DS_COND_STR_CD", "Y", "", "N");
    getBcompCode("DS_COND_BCOMP_CD", "", "", "Y");

    //초기값설정
    setComboData(LC_STR_CD,  DS_COND_STR_CD.NameValue(0, "CODE"));
    setComboData(LC_BCOMP_CD,  "%");
    
    EM_CHRG_DT_S.Text = "<%=strToMonth%>";
    
    showMaster();
}

function gridCreate1(){
    var hdrProperies    = '<FC>id={currow}        name="NO"            width=30  align=center</FC>'
				    	+ '<FC>id=CHRG_DT         name="청구일자"      width=100  align=center mask="XXXX/XX/XX"   SumText= "합계"</FC>'
				    	+ '<FC>id=SALE_DT         name="매출일자"      width=100  align=center mask="XXXX/XX/XX"</FC>'
				    	+ '<FC>id=BCOMP_NM        name="매입사"        width=150  align=left</FC>'
				    	+ '<FC>id=JBRCH_ID        name="가맹점번호명"  width=155  align=left</FC>'
				    	+ '<FC>id=BUYREQ_CNT      name="청구건수"      width=100  align=right   SumText=@sum</FC>'
				    	+ '<FC>id=BUYREQ_AMT      name="청구액"        width=150  align=right   SumText=@sum</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    GR_MASTER.ViewSummary = "1";
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
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-30
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
  
    if(trim(LC_STR_CD.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "점코드");
        LC_STR_CD.Focus();
        return false;
    }

    if(RD_GUBUN.CodeValue == "1"){
    	strMsg = "청구일자";
    }else if(RD_GUBUN.CodeValue == "2"){
    	strMsg = "매출일자";
    }
    
    if(trim(EM_CHRG_DT_S.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001", strMsg + " 시작일");
        EM_CHRG_DT_S.Focus();
        return;
    }
    if(trim(EM_CHRG_DT_E.Text).length == 0){    // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001", strMsg + " 종료일");
        EM_CHRG_DT_E.Focus();
        return;
    }
    if(EM_CHRG_DT_S.Text > EM_CHRG_DT_E.Text){   // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_CHRG_DT_S.Focus();
        return;
    }
    //조회
    showMaster();
}

/**
 * btn_Excel()
 * 작   성   자 : 김영진
 * 작   성   일 :2010-05-30
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    var ExcelTitle = "매출일자별 청구현황";
    openExcel2(GR_MASTER, ExcelTitle, strExlParam, true );
    GR_MASTER.Focus();
}

 /*************************************************************************
  * 3. 함수
  *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-30
 * 개       요     : 매출일자별 청구현황
 * return값 : void
 */
function showMaster(){    
  
    var strStrCd     = LC_STR_CD.BindColVal;
    var strChrgDtS   = EM_CHRG_DT_S.Text; 
    var strChrgDtE   = EM_CHRG_DT_E.Text;  
    var strBcompCd   = LC_BCOMP_CD.BindColVal;
    
    strExlParam = "점포명="     + strStrCd   + " : " + LC_STR_CD.Text
                + " -매입사="   + strBcompCd + " : " + LC_BCOMP_CD.Text
                + " -조회구분=" + RD_GUBUN.DataValue
                + " -" + strMsg + "=" + strChrgDtS + "~" 　  +   strChrgDtE;

    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                    + "&strChrgDtS=" + encodeURIComponent(strChrgDtS)
                    + "&strChrgDtE=" + encodeURIComponent(strChrgDtE)
                    + "&strBcompCd=" + encodeURIComponent(strBcompCd)
                    + "&strGubun="   + encodeURIComponent(RD_GUBUN.CodeValue);
    
    TR_MAIN.Action  ="/dps/psal945.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //그리드 첫 row 상세조회
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	LC_STR_CD.Focus();
    }
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
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
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_CHRG_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_CHRG_DT_S)){
        EM_CHRG_DT_S.Text = "<%=strToMonth%>";
    }
</script>
    
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_CHRG_DT_E event=onKillFocus()>
    if(!checkDateTypeYMD(EM_CHRG_DT_E)){
        initEmEdit(EM_CHRG_DT_E, "TODAY",       PK); 
    }
</script>  

<!-- 조회구분 선택이벤트 처리 -->
<script language=JavaScript for=RD_GUBUN event=OnSelChange()>
    if(this.CodeValue == "1"){
        document.getElementById('titleDT').innerHTML = "청구일자";
    }else if(this.CodeValue == "2"){
        document.getElementById('titleDT').innerHTML = "매출일자";
    }
    initEmEdit(EM_CHRG_DT_S,     "YYYYMMDD",    PK);  //청구일자
    initEmEdit(EM_CHRG_DT_E,     "TODAY",       PK);      
    EM_CHRG_DT_S.Text = "<%=strToMonth%>";
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
<object id="DS_COND_STR_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_BCOMP_CD" classid=<%=Util.CLSID_DATASET%>>
</object>
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
						<th width="80" class="point">점포명</th>
						<td width="300"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=130
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">매입사</th>
						<td><comment id="_NSID_"> <object id=LC_BCOMP_CD
							classid=<%=Util.CLSID_LUXECOMBO%> width=130 align="absmiddle"
							tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
					    <th width="80">조회구분</th>
                        <td width="300"><comment id="_NSID_"> <object
                            id=RD_GUBUN classid=<%=Util.CLSID_RADIO%>
                            style="height: 20; width: 145" tabindex=1>
                            <param name=Cols value="2">
                            <param name=Format value="1^청구일자,2^매출일자">
                            <param name="AutoMargin" value="true">
                            <param name=CodeValue value="1">
                        </object> </comment><script> _ws_(_NSID_);</script></td>
					    <th width="80" class="point"><span id="titleDT" style="Color: 146ab9">청구일자</span></th>
                        <td><comment id="_NSID_"> <object
                            id=EM_CHRG_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70
                            tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_CHRG_DT_S)" />- <comment
                            id="_NSID_"> <object id=EM_CHRG_DT_E
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_CHRG_DT_E)" /></td>
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
					width="100%" height=479 classid=<%=Util.CLSID_GRID%> tabindex=1>
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

