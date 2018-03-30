<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽운영 > VIP 라운지 > 회원별 방문횟수조회
 * 작 성 일    : 2010.06.30
 * 작 성 자    : 김영진
 * 수 정 자    : 
 * 파 일 명    : dmbo7140.jsp
 * 버    전       : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가) 
 * 개    요       : 
 * 이    력       :
 *           2010.06.30 (김영진) 신규작성
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
	String strToMonth = new java.text.SimpleDateFormat("yyyyMM")
			.format(new java.util.Date());
	strToMonth = strToMonth + "01";
	
	String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
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
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var EXCEL_PARAMS = "";
var strLastDay   = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-30
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    var GET_USER_AUTH_VALUE = getBrchUserAuth('<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />');
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');

    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //상세
    
    //검색조건
    if ("B" == GET_USER_AUTH_VALUE) {
        initEmEdit(EM_BRCH_ID_S,    "GEN^10",   READ);       //가맹점코드
        enableControl(IMG_BRCH,   false);
    } else {
        initEmEdit(EM_BRCH_ID_S,    "GEN^10",   PK);         //가맹점코드
        enableControl(IMG_BRCH,   true); 
    }
    
    //EMedit에 초기화
    initEmEdit(EM_VISIT_IN_DATE_S,  "YYYYMMDD",     PK);         //조회 시작기간    
    initEmEdit(EM_VISIT_IN_DATE_E,  "YYYYMMDD",     PK);         //조회 종료기간
    initEmEdit(EM_BRCH_NM_S,        "GEN^40",       READ);       //가맹점명
    initEmEdit(EM_VISIT_QTY_S,      "NUMBER^3^0",   NORMAL);     //방문횟수
    
    //default ;
    EM_BRCH_ID_S.Text = '<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />'; //소속가맹점 
    setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_ID_S.Text);
    if (DS_O_RESULT.CountRow == 1 ) {
    	EM_BRCH_ID_S.Text = DS_O_RESULT.NameValue(1, "CODE_CD");
    	EM_BRCH_NM_S.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
    }
    
    EM_VISIT_IN_DATE_S.Text = addDate("M", "-1", '<%=strToMonth%>');
    strLastDay = EM_VISIT_IN_DATE_S.Text.substring(0, 6) + getLastDay( EM_VISIT_IN_DATE_S.Text.substring(0, 4), EM_VISIT_IN_DATE_S.Text.substring(5, 6) );
    EM_VISIT_IN_DATE_E.Text = strLastDay;
    EM_VISIT_QTY_S.Text = "5";
  
    btn_Search();
}

function gridCreate1(){
	var hdrProperies = '<FC>id={currow}       name="NO"                 width=30      align=center</FC>'
                     + '<FC>id=CUST_ID        name="회원ID"             width="90"    align=center    SumText= "합계"</FC>'
                     + '<FC>id=CUST_NAME      name="회원명"             width="90"    align=left</FC>'
                     + '<FC>id=CUST_GRADE     name="카드회원등급"       width="82"    align=center</FC>'
                     + '<FC>id=CRM_GRADE      name="CRM회원등급"        width="82"    align=center</FC>'
                     + '<FC>id=VIP_QTY        name="방문횟수"           width="90"    align=right     SumText=@sum</FC>'
                     + '<FC>id=BRCH_ID        name="가맹점ID"           width="80"    align=center    show=false</FC>';
                     
   initGridStyle(GR_MASTER, "common", hdrProperies, false);
   GR_MASTER.ViewSummary = "1";
}

function gridCreate2(){
	 var hdrProperies = '<FC>id={currow}       name="NO"             width=30      align=center</FC>'
                      + '<FC>id=IN_DATE        name="방문일자"       width=80      align=center   Mask="XXXX/XX/XX"</FC>'
                      + '<FC>id=IN_TIME        name="방문시간"       width=80      align=center   Mask="XX:XX:XX" </FC>'
                      + '<FC>id=MEMBER_QTY     name="동반고객수"     width=70      align=right</FC>';
                      
     initGridStyle(GR_DETAIL, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-30
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(trim(EM_VISIT_IN_DATE_S.Text).length == 0){          // 조회시작일
	    showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	    EM_VISIT_IN_DATE_S.Focus();
	    return;
	}
	if(trim(EM_VISIT_IN_DATE_E.Text).length == 0){          // 조회 종료일
	    showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	    EM_VISIT_IN_DATE_E.Focus();
	    return;
	}
	if(EM_VISIT_IN_DATE_S.Text > EM_VISIT_IN_DATE_E.Text){  // 조회일 정합성
	    showMessage(EXCLAMATION, OK, "USER-1015");
	    EM_VISIT_IN_DATE_S.Focus();
	    return;
	} 
	if(trim(EM_BRCH_ID_S.Text).length == 0){          // 가맹점명
	    showMessage(EXCLAMATION, OK, "USER-1001","가맹점명");
	    EM_BRCH_ID_S.Focus();
	    return;
	}
    if(parseInt(trim(EM_VISIT_QTY_S.Text)) < 0){
        showMessage(EXCLAMATION, OK, "USER-1004",  "방문횟수");
        EM_VISIT_QTY_S.Focus();
        return;
    }
	if(trim(EM_VISIT_QTY_S.Text).length == 0){
		EM_VISIT_QTY_S.Text = "1";
	}
    showMaster();
    
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * btn_Excel()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-30
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
   
    var ExcelTitle = "일자별 VIP 방문 고객조회"
    openExcel2(GR_MASTER, ExcelTitle, EXCEL_PARAMS, true );
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-30
 * 개       요     : 일자별 VIP 방문 고객 리스트 조회 
 * return값 : void
 */
function showMaster(){
	 
	var strVisitInDtS = EM_VISIT_IN_DATE_S.Text;
	var strVisitInDtE = EM_VISIT_IN_DATE_E.Text;
	var strBrchId     = EM_BRCH_ID_S.Text;
	var strVisitQty   = EM_VISIT_QTY_S.Text;
	
	EXCEL_PARAMS  = "조회기간="  + strVisitInDtS + "~" + strVisitInDtE;
	EXCEL_PARAMS += "-가맹점="   + strBrchId;
	EXCEL_PARAMS += "-가맹점명=" + EM_BRCH_NM_S.Text;
	EXCEL_PARAMS += "-방문횟수=" + strVisitQty;

    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strVisitInDtS=" + encodeURIComponent(strVisitInDtS)
                    + "&strVisitInDtE=" + encodeURIComponent(strVisitInDtE)
                    + "&strBrchId="     + encodeURIComponent(strBrchId)
                    + "&strVisitQty="   + encodeURIComponent(strVisitQty);
    TR_MAIN.Action  ="/dcs/dmbo714.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	EM_VISIT_IN_DATE_S.Focus();
    }
}

/**
 * doClick()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-30
 * 개       요     : 선택된 일자별 VIP 방문 고객 상세 조회 
 * return값 : void
 */
function doClick(row){
    
    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;

    var strVisitInDtS = EM_VISIT_IN_DATE_S.Text;
    var strVisitInDtE = EM_VISIT_IN_DATE_E.Text;
    var strBrchId     = DS_O_MASTER.NameValue(row ,"BRCH_ID");
    var strCustId     = DS_O_MASTER.NameValue(row ,"CUST_ID");
    
    var goTo        = "searchDetail";    
    var action      = "O";     
    var parameters  = "&strVisitInDtS=" + encodeURIComponent(strVisitInDtS)
                    + "&strVisitInDtE=" + encodeURIComponent(strVisitInDtE)
                    + "&strBrchId="     + encodeURIComponent(strBrchId)
                    + "&strCustId="     + encodeURIComponent(strCustId);
    TR_DETAIL.Action  = "/dcs/dmbo714.do?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
}

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-30
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
    EM_BRCH_NM_S.Text = "";//조건입력시 코드초기화
    if (trim(EM_BRCH_ID_S.Text).length > 0 ) {
        if (kcode == 13 || kcode == 9 || trim(EM_BRCH_ID_S.Text).length == 10) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_ID_S.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
                EM_BRCH_ID_S.Text = DS_O_RESULT.NameValue(1, "CODE_CD");
                EM_BRCH_NM_S.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getBrchPop(EM_BRCH_ID_S,EM_BRCH_NM_S);
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
    //그리드 첫 row 상세조회
    if(row != 0){
    	doClick(row);
    }else{
        DS_O_DETAIL.ClearData();
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!-- 가맹점명 onKillFocus() -->
<script language=JavaScript for=EM_BRCH_ID_S event=onKillFocus()>
    if ((EM_BRCH_ID_S.Modified) && (trim(EM_BRCH_ID_S.Text).length != 10)) {
        EM_BRCH_ID_S.Text = "";
        EM_BRCH_NM_S.Text = "";
    }
</script>
<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_VISIT_IN_DATE_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_VISIT_IN_DATE_S)){
    	EM_VISIT_IN_DATE_S.Text = addDate("M", "-1", '<%=strToMonth%>');
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_VISIT_IN_DATE_E event=onKillFocus()>
    if(!checkDateTypeYMD(EM_VISIT_IN_DATE_E)){
    	EM_VISIT_IN_DATE_E.Text = strLastDay;
    }
</script>  
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>
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
<!-- =============== Input용 -->
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- =============== 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
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
<!-- =============== 공통함수용 -->

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
<!--
window.onresize = function(){
    var obj   = document.getElementById("testdiv"); 
    obj.style.height  = (parseInt(window.document.body.clientHeight)-40) + "px";
}
//-->
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
						<th width="80" class="point">조회기간</th>
						<td width="200"><comment id="_NSID_"> <object
							id=EM_VISIT_IN_DATE_S classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_VISIT_IN_DATE_S)" />- <comment
							id="_NSID_"> <object id=EM_VISIT_IN_DATE_E
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_VISIT_IN_DATE_E)" /></td>
						<th width="80" class="point">가맹점</th>
						<td width="196"><comment id="_NSID_"> <object id=EM_BRCH_ID_S
							classid=<%=Util.CLSID_EMEDIT%> width=76 tabindex=1
							align="absmiddle"
							onKeyUp="javascript:keyPressEvent(event.keyCode);"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							align="absmiddle" id="IMG_BRCH"
							onclick="getBrchPop(EM_BRCH_ID_S,EM_BRCH_NM_S)" /> <comment
							id="_NSID_"> <object id=EM_BRCH_NM_S
							classid=<%=Util.CLSID_EMEDIT%> width=86 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							<th width="80">방문횟수</th>
                        <td><comment id="_NSID_"> <object id=EM_VISIT_QTY_S
                            classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>회 이상</td>
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
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top">
				<table width="508" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <object id=GR_MASTER
                            width="100%" height=503 classid=<%=Util.CLSID_GRID%> tabindex=1>
                            <param name="DataID" value="DS_O_MASTER">
                        </object> </comment> <script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
				</td>
				<td align="center" class="PL05 PR05" width="30">&nbsp;</td>
				<td width="100%">
				<table width=100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <object id=GR_DETAIL
                            width="100%" height=503 classid=<%=Util.CLSID_GRID%> tabindex=1>
                            <param name="DataID" value="DS_O_DETAIL">
                        </object> </comment> <script>_ws_(_NSID_);</script></td>
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
</body>
</html>
