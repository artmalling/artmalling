<!--
/*******************************************************************************
 * 시스템명 : 포인트카드 > 신용카드대금청구 > 청구관리 > 청구데이터 건수확인
 * 작  성  일  : 2010.05.25
 * 작  성  자  : 조형욱
 * 수  정  자  :
 * 파  일  명  : psal9250.jsp
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
<!--* A. 로그인 유무, 기본설정                                                         *-->
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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script language="JavaScript">
<!--
var strFlag				= "INS";
var strChangFlag		= false;
var bfListRowPosition	= 0;                             // 이전 List Row Position
var strBefore			= "";
var strAfter			= "";
var intChangRow			= 0;

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

	//그리드 초기화
	gridCreate1(); //마스터

	// EMedit에 초기화
	initEmEdit(EM_COND_SALE_DT1,     "YYYYMMDD",  PK);           //조회 종료기간
	initEmEdit(EM_COND_SALE_DT2,     "TODAY",     PK);           //조회 종료기간
	initEmEdit(EM_COND_REQ_DT1,      "YYYYMMDD",  PK);           //조회 종료기간
	initEmEdit(EM_COND_REQ_DT2,      "TODAY",     PK);           //조회 종료기간
	initEmEdit(EM_COND_POS_NO1,      "0000",      NORMAL);       //조회 종료
	initEmEdit(EM_COND_POS_NO2,      "0000",      NORMAL);       //조회 종료
	//
	initComboStyle(LC_COND_STR_CD,   DS_COND_STR_CD,   "CODE^0^30, NAME^0^120", 1, PK);
	initComboStyle(LC_COND_BCOMP_CD, DS_COND_BCOMP_CD, "CODE^0^30, NAME^0^120", 1, NORMAL);
	initComboStyle(LC_COND_BRCH_CD,  DS_COND_BRCH_CD,  "CODE^0^120,NAME^0^180", 1, NORMAL);
	//
	getStore("DS_COND_STR_CD", "Y", "", "N");

	//초기값설정
	setComboData(LC_COND_STR_CD,  DS_COND_STR_CD.NameValue(0, "CODE"));  //

	// 매입사코드콤보 목록 가져오기 및 초기값 설정
	getBcompCode("DS_COND_BCOMP_CD", "", "", "Y");
	setComboData(LC_COND_BCOMP_CD,  "%");

	//조회일자 초기값.
	EM_COND_SALE_DT1.text   = addDate("M", "-1", '<%=strToMonth%>');
	EM_COND_SALE_DT2.text   = addDate("D", "-1", EM_COND_SALE_DT2.text);
	EM_COND_REQ_DT1.text   = addDate("M", "-1", '<%=strToMonth%>');
	EM_COND_REQ_DT2.text   = addDate("D", "-1", EM_COND_REQ_DT2.text);
	//
	//LC_COND_STR_CD.Focus();
	showMaster();
}

function gridCreate1(){
	var hdrProperies    = '<FC>id={currow}              name="NO"               width=30   align=center</FC>'
						+ '<FC>id=STR_CD                name="STR_CD"           width=0    align=center</FC>'
						+ '<FC>id=SALE_DT               name="매출일자"          width=90    align=center mask="XXXX/XX/XX"</FC>'
						+ '<FC>id=REQ_DT                name="청구일자"          width=90    align=center mask="XXXX/XX/XX"</FC>'
						+ '<FC>id=BCOMP_CD              name="BCOMP_CD"         width=0    align=center</FC>'
						+ '<FC>id=BCOMP_NM              name="카드매입사"        width=100    align=left</FC>'
						+ '<FC>id=POS_NO                name="POS번호"          width=80    align=center SumText= "합계"</FC>'
						+ '<FC>id=POS_COUNT             name="POS승인건수"       width=100    align=right SumText=@sum</FC>'
						+ '<FC>id=POS_AMT               name="POS승인금액"       width=100    align=right SumText=@sum</FC>'
						+ '<FC>id=REQ_COUNT             name="청구대상건수"       width=100    align=right SumText=@sum</FC>'
						+ '<FC>id=REQ_AMT               name="청구대상금액"       width=100    align=right SumText=@sum</FC>'
						+ '<FC>id=PP_COUNT              name="보류건수"          width=85    align=right SumText=@sum</FC>'
						+ '<FC>id=PP_AMT                name="보류금액"          width=85    align=right SumText=@sum</FC>'
						+ '<FC>id=REAL_COUNT            name="실청구대상건수"     width=100    align=right SumText=@sum</FC>'
						+ '<FC>id=REAL_AMT              name="실청구대상금액"     width=100    align=right SumText=@sum</FC>'
						+ '<FC>id=BUY_COUNT             name="청구건수"          width=100    align=right SumText=@sum</FC>'
						+ '<FC>id=BUY_AMT               name="청구금액"          width=100    align=right SumText=@sum</FC>'
						+ '<FC>id=DIF_COUNT             name="차이건수"          width=100    align=right SumText=@sum</FC>'
						+ '<FC>id=DIF_AMT               name="차이금액"          width=100    align=right SumText=@sum</FC>';

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
  * 작 성 자     : 조형욱
  * 작 성 일     : 2010-05-22
  * 개       요     : 조회시 호출
  * return값 : void
  */
function btn_Search() {
	//조회
	showMaster();
}

/**
 * btn_Excel()
 * 작   성   자 : 조형욱
 * 작   성   일 : 2010-05-22
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	var parameters  = "점포명="+ LC_COND_STR_CD.Text;
	parameters = parameters + " 카드매입사="+ LC_COND_BCOMP_CD.Text;
	parameters = parameters + " 매출일자="+ EM_COND_SALE_DT1.Text +"~"+ EM_COND_SALE_DT2.Text;;

	var ExcelTitle = "청구 데이터 건수확인";

	openExcel2(GR_MASTER, ExcelTitle, parameters, true );

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
	if(trim(LC_COND_STR_CD.BindColVal).length == 0){
		showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
		LC_COND_STR_CD.Focus();
		return false;
	}
	if(trim(EM_COND_SALE_DT1.Text).length == 0){          // 조회시작일
		showMessage(EXCLAMATION, OK, "USER-1001","매출일자 시작일");
		EM_COND_SALE_DT1.Focus();
		return;
	}
	if(trim(EM_COND_SALE_DT2.Text).length == 0){          // 조회시작일
		showMessage(EXCLAMATION, OK, "USER-1001","매출일자 종료일");
		EM_COND_SALE_DT2.Focus();
		return;
	}
	if(EM_COND_SALE_DT1.Text > EM_COND_SALE_DT2.Text){      // 조회일 정합성
		showMessage(EXCLAMATION, OK, "USER-1015");
		EM_COND_SALE_DT1.Focus();
		return;
	}

	if(trim(EM_COND_REQ_DT1.Text).length == 0){          // 조회시작일
		showMessage(EXCLAMATION, OK, "USER-1001","청구일자 시작일");
		EM_COND_REQ_DT1.Focus();
		return;
	}
	if(trim(EM_COND_REQ_DT2.Text).length == 0){          // 조회시작일
		showMessage(EXCLAMATION, OK, "USER-1001","청구일자 종료일");
		EM_COND_REQ_DT2.Focus();
		return;
	}
	if(EM_COND_REQ_DT1.Text > EM_COND_REQ_DT2.Text){      // 조회일 정합성
		showMessage(EXCLAMATION, OK, "USER-1015");
		EM_COND_REQ_DT1.Focus();
		return;
	}

	var goTo        = "searchMaster";
	var action      = "O";
	var parameters  = "&paramStrCd="   + encodeURIComponent(LC_COND_STR_CD.BindColVal)
					+ "&paramSaleDt1=" + encodeURIComponent(EM_COND_SALE_DT1.text)
					+ "&paramSaleDt2=" + encodeURIComponent(EM_COND_SALE_DT2.text)
					+ "&paramReqDt1="  + encodeURIComponent(EM_COND_REQ_DT1.text)
					+ "&paramReqDt2="  + encodeURIComponent(EM_COND_REQ_DT2.text)
					+ "&paramPosNo1="  + encodeURIComponent(EM_COND_POS_NO1.text)
					+ "&paramPosNo2="  + encodeURIComponent(EM_COND_POS_NO2.text)
					+ "&paramBcompCd=" + encodeURIComponent(LC_COND_BCOMP_CD.BindColVal)
					+ "&paramBrchCd="  + encodeURIComponent(LC_COND_BRCH_CD.BindColVal);
	TR_MAIN.Action  ="/dps/psal925.ps?goTo="+goTo+parameters;
	TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
	TR_MAIN.Post();

	//그리드 첫 row 상세조회
	if(DS_O_MASTER.CountRow > 0){
		GR_MASTER.Focus();
		//setEnable(true);
	}else{
		LC_COND_STR_CD.Focus();
		//setEnable(false);

	}
	//bfListRowPosition = 0;
	//조회결과 Return
	setPorcCount("SELECT", DS_O_MASTER.CountRow);
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
<!-- 매입사콤보 선택이벤트 처리 -->
<script language=JavaScript for=LC_COND_BCOMP_CD event=OnSelChange()>
	DS_COND_BRCH_CD.ClearData();
	if(this.BindColVal != "%"){
		LC_COND_BRCH_CD.Enable = true;
		getJbrchCode("DS_COND_BRCH_CD", this.BindColVal, "N");
	}else{
		LC_COND_BRCH_CD.Enable = false;
	}
</script>

<!-- 매출일자 Start onKillFocus() -->
<script language=JavaScript for=EM_COND_SALE_DT1 event=onKillFocus()>
	if(!checkDateTypeYMD(EM_COND_SALE_DT1)){
		EM_COND_SALE_DT1.text   = addDate("M", "-1", '<%=strToMonth%>');
	}
</script>
<!-- 매출일자 End onKillFocus() -->
<script language=JavaScript for=EM_COND_SALE_DT2 event=onKillFocus()>
	if(!checkDateTypeYMD(EM_COND_SALE_DT2)){
		EM_COND_SALE_DT2.text   = addDate("D", "-1", EM_COND_SALE_DT2.text);
	}
</script>


<!-- 청구일자 Start onKillFocus() -->
<script language=JavaScript for=EM_COND_REQ_DT1 event=onKillFocus()>
	if(!checkDateTypeYMD(EM_COND_REQ_DT1)){
		EM_COND_REQ_DT1.text   = addDate("M", "-1", '<%=strToMonth%>');
	}
</script>
<!-- 청구일자 End onKillFocus() -->
<script language=JavaScript for=EM_COND_REQ_DT2 event=onKillFocus()>
	if(!checkDateTypeYMD(EM_COND_REQ_DT2)){
		EM_COND_REQ_DT2.text   = addDate("D", "-1", EM_COND_REQ_DT2.text);
	}
</script>

<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
	sortColId( eval(this.DataID), row, colid);
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
<object id="DS_COND_STR_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_BCOMP_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_BRCH_CD" classid=<%=Util.CLSID_DATASET%>> </object>
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
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
				<tr>
					<td>
						<!-- search start -->
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
							<tr>
								<th width="80" class="point">점포명</th>
								<td width="300">
									<comment id="_NSID_">
										<object id=LC_COND_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=192 align="absmiddle" tabindex=1>
										</object>
									</comment> <script> _ws_(_NSID_);</script>
								</td>
								<th width="80">카드매입사</th>
								<td>
									<comment id="_NSID_">
										<object id=LC_COND_BCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 align="absmiddle" tabindex=1>
										</object>
									</comment> <script> _ws_(_NSID_);</script>
									<comment id="_NSID_">
										<object id=LC_COND_BRCH_CD classid=<%=Util.CLSID_LUXECOMBO%> width=190 align="absmiddle" tabindex=1> </object>
									</comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th width="80" class="point">매출일자</th>
								<td>
									<comment id="_NSID_">
										<object id=EM_COND_SALE_DT1 classid=<%=Util.CLSID_EMEDIT%> width=70 align="absmiddle" tabindex=1>
										</object>
									</comment> <script> _ws_(_NSID_);</script>
									<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_COND_SALE_DT1)" />-
									<comment id="_NSID_">
										<object id=EM_COND_SALE_DT2 classid=<%=Util.CLSID_EMEDIT%> width=70 align="absmiddle" tabindex=1>
										</object>
									</comment> <script> _ws_(_NSID_);</script>
									<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_COND_SALE_DT2)" />
								</td>
								<th width="80" class="point">청구일자</th>
								<td>
									<comment id="_NSID_">
										<object id=EM_COND_REQ_DT1 classid=<%=Util.CLSID_EMEDIT%> width=70 align="absmiddle" tabindex=1>
										</object>
									</comment> <script> _ws_(_NSID_);</script>
									<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_COND_REQ_DT1)" />-
									<comment id="_NSID_">
										<object id=EM_COND_REQ_DT2 classid=<%=Util.CLSID_EMEDIT%> width=70 align="absmiddle" tabindex=1>
										</object>
									</comment> <script> _ws_(_NSID_);</script>
									<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_COND_REQ_DT2)" />
								</td>
							</tr>
		
							<tr>
								<th width="80">POS번호</th>
								<td colspan="3">
									<comment id="_NSID_">
										<object id=EM_COND_POS_NO1 classid=<%=Util.CLSID_EMEDIT%> width=90 align="absmiddle" tabindex=1>
										</object>
									</comment> <script> _ws_(_NSID_);</script>-
									<comment id="_NSID_">
										<object id=EM_COND_POS_NO2 classid=<%=Util.CLSID_EMEDIT%> width=90 align="absmiddle" tabindex=1>
										</object>
									</comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>
						</table>
						<!-- search End -->
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
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
				<tr>
					<td>
						<!-- grid start -->
						<comment id="_NSID_">
							<object id=GR_MASTER width="100%" height=455 classid=<%=Util.CLSID_GRID%> tabindex=1>
								<param name="DataID" value="DS_O_MASTER">
							</object>
						</comment> <script>_ws_(_NSID_);</script>
						<!-- grid end -->
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
</body>
</html>