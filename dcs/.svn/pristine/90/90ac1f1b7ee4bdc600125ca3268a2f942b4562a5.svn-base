<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽운영 > 승인처리 > OK캐쉬백상품권 교환 현황표
 * 작  성  일  : 2010.01.14
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dmbo6390.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.01.14 (김영진) 신규작성
 *           2010.03.03 (김영진) 기능추가
 ******************************************************************************/
-->     
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("UTF-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"    prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
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
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<%
    String strProcDt = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date()); 
    strProcDt = strProcDt + "01";
    
    String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>
<script LANGUAGE="JavaScript">
<!--
var strProcSDt = "";
var strProcEDt = "";
var strBrchId  = "";
var strBrchNm  = "";
var parameters = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-03
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

	var GET_USER_AUTH_VALUE = getBrchUserAuth('<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />');
	
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1();
    
    //검색조건
    /*
    if ("B" == GET_USER_AUTH_VALUE) {
        initEmEdit(EM_BRCH_ID,    "GEN^10", READ);       //가맹점코드
        enableControl(IMG_BRCH,     false);
    } else {
        initEmEdit(EM_BRCH_ID,    "GEN^10", NORMAL);     //가맹점코드
        enableControl(IMG_BRCH,     true); 
    }
    */
    initEmEdit(EM_BRCH_ID,    "GEN^10", PK);       //가맹점코드
    
    //EMedit에 초기화
    initEmEdit(EM_PROC_S_DT,    "YYYYMMDD",  PK);       // 조회 시작기간    
    initEmEdit(EM_PROC_E_DT,    "TODAY",     PK);       // 조회 종료기간
    initEmEdit(EM_BRCH_NAME,    "GEN^40",    READ);     //가맹점명
    
    //default ;
    EM_BRCH_ID.Text = '<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />'; //소속가맹점 
    setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_ID.Text);
    if (DS_O_RESULT.CountRow == 1 ) {
        EM_BRCH_ID.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
        EM_BRCH_NAME.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
    } 
    
    //조회일자 초기값.
    EM_PROC_S_DT.Text   = addDate("M", "-1", '<%=strProcDt%>');
    //showMaster();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"               width=30    align=center</FC>'
                     + '<FC>id=BRCH_NAME    name="가맹점명"         width=73    align=left SumText="합계" </FC>'
                     + '<FC>id=PROC_DT      name="일자"             width=80    align=center     mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=CUST_NAME    name="회원명"           width=50    align=center show=false</FC>'
                     + '<FC>id=MOBILE_PH1   name="이동전화"         width=95    align=center show=false</FC>'
                     + '<FC>id=CARD_NO      name="OK캐쉬백 번호"         width=165   align=center   mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=CONV_POINT   name="OK캐쉬백 상품권교환포인트"       width=168    align=right SumText=@sum </FC>'
                     + '<FC>id=GIFTCD_AMT   name="상품권금액"       width=68    align=right SumText=@sum </FC>'
                     + '<FC>id=GIFTCD_NO    name="상품권번호"       width=184   align=left</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    GR_MASTER.ViewSummary = "1";
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
     (3) 출력       - btn_Print()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-03
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
     
    if(trim(EM_PROC_S_DT.Text).length == 0){          //조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_PROC_S_DT.Focus();
        return;
    }
    if(trim(EM_PROC_E_DT.Text).length == 0){          //조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_PROC_E_DT.Focus();
        return;
    }
    if(trim(EM_BRCH_ID.Text).length == 0){          //가맹점
        showMessage(EXCLAMATION, OK, "USER-1001","가맹점");
        EM_BRCH_ID.Focus();
        return;
    }    
    if(EM_PROC_S_DT.Text > EM_PROC_E_DT.Text){       //조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_PROC_S_DT.Focus();
        return;
    }
    

    showMaster();
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
 }

/**
 * btn_Excel()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-03
 * 개       요     : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	 
	var ExcelTitle = "상품권 교환 현황표"
    if (strBrchId == "") strBrchId = "전체";
	if (strBrchNm == "") strBrchNm = "전체";

	var params = "조회기간="   + strProcSDt+ "~" + strProcEDt
	           + " -가맹점="   + strBrchId
	           + " -가맹점명=" + strBrchNm; 
                                                         
    openExcel2(GR_MASTER, ExcelTitle, params, true );
}

/**
 * btn_Print()
 * 작 성 자 : 김영진
 * 작 성 일     : 2010-03-03
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	/* 
    if (DS_O_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, Ok, "USER-1031");
        return false;
    }
    window.open("/dcs/dmbo639.do?goTo=print"+parameters,"OZREPORT", 1000, 700);
    */
}

/**
 * btn_New()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.05.04
 * 개       요 : 초기화
 * return값 : void
 */
function btn_New() {
	 
	DS_O_MASTER.ClearData();
	
	EM_PROC_S_DT.Text   = addDate("M", "-1", '<%=strProcDt%>');
	initEmEdit(EM_PROC_E_DT,    "TODAY",     PK);       // 조회 종료기간
	
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-03
 * 개       요     : 상품권 교환 현황표 조회 
 * return값 : void
 */
function showMaster(){

    strProcSDt  = EM_PROC_S_DT.Text;
    strProcEDt  = EM_PROC_E_DT.Text;
    strBrchId   = EM_BRCH_ID.Text;
    strBrchNm   = EM_BRCH_NAME.Text;

    var goTo    = "searchMaster";    
    var action  = "O";     
    parameters  = "&strProcSDt=" + encodeURIComponent(strProcSDt)
                + "&strProcEDt=" + encodeURIComponent(strProcEDt)
                + "&strBrchId="  + encodeURIComponent(strBrchId); 
    TR_MAIN.Action  ="/dcs/dmbo639.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
        EM_PROC_S_DT.Focus();
    }
}

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-03
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
    EM_BRCH_NAME.Text = "";//조건입력시 코드초기화
    if (EM_BRCH_ID.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_BRCH_ID.Text.length == 10) { //TAB,ENTER 키 실행시에만 
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
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 가맹점명 onKillFocus() -->
<script language=JavaScript for=EM_BRCH_ID event=onKillFocus()>
    if ((EM_BRCH_ID.Modified) && (EM_BRCH_ID.Text.length != 10)) {
        EM_BRCH_NAME.Text = "";
    }
</script>
<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_PROC_S_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_PROC_S_DT)){
        EM_PROC_S_DT.text =  addDate("M", "-1", '<%=strProcDt%>');
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_PROC_E_DT event=onKillFocus()>
	if(!checkDateTypeYMD(EM_PROC_E_DT)){
		EM_PROC_E_DT.text = <%=toDate%>;
	}
</script>

<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
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
						<td width="300"><comment id="_NSID_"> <object
							id=EM_PROC_S_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_PROC_S_DT)" />- <comment
							id="_NSID_"> <object id=EM_PROC_E_DT
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_PROC_E_DT)" /></td>
						<th width="80"  class="point">가맹점</th>
						<td><comment id="_NSID_"> <object id=EM_BRCH_ID
							classid=<%=Util.CLSID_EMEDIT%> width=72 tabindex=1
							onKeyUp="javascript:keyPressEvent(event.keyCode);"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_BRCH"
							align="absmiddle" onclick="getBrchPop(EM_BRCH_ID,EM_BRCH_NAME)" />
						<comment id="_NSID_"> <object id=EM_BRCH_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
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
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=503 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
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
