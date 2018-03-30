<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 승인처리 > 포인트 승인내역 조회
 * 작  성  일  : 2010.01.14
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dmbo6120.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.01.14 (김영진) 신규작성
 *           2010.03.23 (김영진) 기능추가
*
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%
	request.setCharacterEncoding("utf-8");
%> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"        prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"            prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

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
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dcs.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--

var EXCEL_PARAMS = "";
var ALREADY_ADD  = true;
var isSearch = false;

var recpStrCd = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010.08.25
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit() {

    var GET_USER_AUTH_VALUE = getBrchUserAuth('<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />');
    recpStrCd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'; // 소속 점포
    
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>'); //마스터
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>'); //디테일
    
    gridCreate1(); //그리드 초기화
    
    //검색조건
    if ("B" == GET_USER_AUTH_VALUE) {
    	initEmEdit(EM_Q_BRCH_ID,    "GEN^10",            READ);       //가맹점코드
        enableControl(IMG_BRCH,     false);
    } else {
        initEmEdit(EM_Q_BRCH_ID,    "GEN^10",            NORMAL);     //가맹점코드
        enableControl(IMG_BRCH,     true); 
    }

    initEmEdit(EM_Q_BRCH_NAME,    "GEN^40",              READ);       //가맹점명
    initEmEdit(EM_Q_RECP_NO,      "GEN^16",              PK);         //영수증번호
    initEmEdit(EM_CARD_NO_S,      "0000-0000-0000-0000", NORMAL);     //카드번호

    //default ;
    EM_Q_BRCH_ID.Text = '<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />'; //소속가맹점 
    setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_Q_BRCH_ID.Text);
    if (DS_O_RESULT.CountRow == 1 ) {
        EM_Q_BRCH_ID.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
        EM_Q_BRCH_NAME.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
    }

    EM_Q_RECP_NO.focus();
}

/**
 * gridCreate1()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010.08.25
 * 개       요     : 그리드 초기화  
 * return값 : void
 */ 
function gridCreate1() {
    var hdrProperies = '<FC>id={currow}    name="NO"        width=30   align=center  </FC>'
                     + '<FC>id=ITEM_NAME   name="상품명"    width=190  align=left    SumText="합계"  </FC>'
                     + '<FC>id=SALE_PRC    name="단가"      width=90   align=right   </FC>'
                     + '<FC>id=SALE_QTY    name="수량"      width=60   align=right   </FC>'
                     + '<FC>id=SALE_AMT    name="금액"      width=120  align=right   SumText=@sum </FC>';
                     
     var hdrProperies2 = '<FC>id=COL_NM        name="구분"      width=110   align=left  </FC>'
                       + '<FC>id=COL_VAL_DISP  name="자료"      width=150  align=left    </FC>';

    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    initGridStyle(GR_DETAIL, "common", hdrProperies2, false);

    GR_MASTER.ViewSummary = "1";
    GR_DETAIL.ViewHeader  = "false";
    GR_DETAIL.IndWidth    = "0"; 

    GR_DETAIL.ColumnProp("COL_NM", "bgcolor") = "#eaeef4";
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
     (3) 저장       - btn_Save()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010.08.25
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 isSearch = true;
	 showMaster();
}

/**
 * btn_Excel()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010.08.25
 * 개       요     : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    GR_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";

    var ExcelTitle = "영수증사후적립(회원등록이전)";
    openExcel2(GR_MASTER, ExcelTitle, EXCEL_PARAMS , true );
}


/**
 * btn_Save()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.08.25
 * 개       요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

    if (ALREADY_ADD == true) {
        showMessage(StopSign, OK, "USER-1000",  "이미 포인트 적립된 영수증입니다.");
        return;
    }
    if ( !check_data() ) return ;

    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
       return;
    }

    for (var j = 1; j <= 2; j++) { 
        var ds;
        switch (j) {
            case 1: ds = DS_IO_MASTER; break;
            case 2: ds = DS_IO_DETAIL; break;
        }
        for (var i = 1; i <= ds.CountRow; i++) {
            ds.NameValue(i, "FLAG") = "C";
        }
    }
   
    DS_I_DATA.ClearAll();
    DS_I_DATA.setDataHeader('BRCH_ID:STRING(15)');
    DS_I_DATA.Addrow();
    DS_I_DATA.NameValue(DS_I_DATA.CountRow, "BRCH_ID")    = EM_Q_BRCH_ID.Text;
    
    var strCardNo = EM_CARD_NO_S.Text;
    
    var goTo = "saveData";
    var parameters  = "&strCardNo="  + encodeURIComponent(strCardNo);
    TR_SAVE.Action  ="/dcs/dmbo621.do?goTo="+goTo + parameters;
    TR_SAVE.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL,I:DS_I_DATA=DS_I_DATA)";
    TR_SAVE.Post();  

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
function showMaster(){
	if (trim(EM_Q_RECP_NO.Text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "영수증번호는 필수입력항목입니다.");
        EM_Q_RECP_NO.focus();
        return;
    }
    if (trim(EM_Q_RECP_NO.Text).length != 16) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "영수증번호의 길이는 16자리입니다.");
        EM_Q_RECP_NO.focus();
        return;
    }
    
    if(trim(EM_CARD_NO_S.Text).length == 0){   // 카드번호
        showMessage(EXCLAMATION, OK, "USER-1001","카드번호");
        EM_CARD_NO_S.Focus();
        return;
    }else{
        if (trim(EM_CARD_NO_S.Text).length > 0 && trim(EM_CARD_NO_S.Text).length < 16) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "카드번호는 16자리입니다.");
            EM_CARD_NO_S.Focus();
            return;
        }
    }
    
    ALREADY_ADD = true;

    var goTo        = "searchMaster";    
    var parameters  = "&BRCH_ID="        + encodeURIComponent(EM_Q_BRCH_ID.Text);
        parameters += "&RECP_NO="        + encodeURIComponent(EM_Q_RECP_NO.Text);
        parameters += "&CARD_NO="        + encodeURIComponent(EM_CARD_NO_S.Text);

    EXCEL_PARAMS = "-가맹점="        + EM_Q_BRCH_ID.Text;
    EXCEL_PARAMS += "-가맹점명="     + EM_Q_BRCH_NAME.Text;
    EXCEL_PARAMS += "-영수증번호="   + EM_Q_RECP_NO.Text;
    EXCEL_PARAMS += "-카드번호="     + EM_CARD_NO_S.Text;
    
    TR_MASTER.Action   = "/dcs/dmbo621.do?goTo=" + goTo + parameters;  
    TR_MASTER.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER,O:DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_MASTER.Post();


	//조회결과 Return
	setPorcCount("SELECT", DS_IO_MASTER.CountRow);
}

/**
 * check_data()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.08.25
 * 개       요 : 저장시 유효성 처리
 * return값 : void
 */
function check_data() {

    if (DS_IO_MASTER.CountRow <= 0) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "해당 영수증의 내역이 존재하지 않습니다.");
        return false;
    }
    var ds = DS_IO_DETAIL;
    var OCC_POINT = 0;
    for (var i = 1; i <= ds.CountRow; i++) {
        if ("OCC_POINT" == ds.NameValue(i, "COL_ID")) {
            OCC_POINT = ds.NameValue(i, "COL_VAL");
            break;
        }
    }
    /*
    if (OCC_POINT == "" || OCC_POINT == 0) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "영수증 사용으로 인하여 발생한 적립포인트가 존재하지 않습니다.");
        DS_IO_DETAIL.RowPosition = DS_IO_DETAIL.CountRow;
        return false;
    }
    */
    return true;
}

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.08.25
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
     EM_Q_BRCH_NAME.Text = "";//조건입력시 코드초기화
    if (EM_Q_BRCH_ID.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_Q_BRCH_ID.Text.length == 10) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_Q_BRCH_ID.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
                EM_Q_BRCH_ID.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
                EM_Q_BRCH_NAME.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getBrchPop(EM_Q_BRCH_ID,EM_Q_BRCH_NAME);
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
<!--* C. 가우스 이벤트 처리                                                                                                                                        *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MASTER event=onSuccess>
    for(var i = 0; i < this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    }
    if (DS_IO_MASTER.CountRow > 0) {
        GR_MASTER.focus();
    } else {
        EM_Q_RECP_NO.focus();
    }

    if (isSearch == true) {
	   
	    for (var i = 1; i <= DS_IO_DETAIL.CountRow; i++) {
	        if (DS_IO_DETAIL.NameValue(i, "COL_ID") == "OCC_POINT") {
	            if (DS_IO_DETAIL.NameValue(i, "COL_VAL") > 0) {
	                ALREADY_ADD = true;
	                showMessage(StopSign, OK, "USER-1000",  "이미 포인트 적립된 영수증입니다.");
	            } else {
	                ALREADY_ADD = false;
	            }
	            break;
	        }
	    }
    }
    
    isSearch  = false;    
</script>
<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(var i = 0; i < this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    }
    showMaster();
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MASTER event=onFail>
    trFailed(TR_MASTER.ErrorMsg);
</script>
<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=EM_Q_BRCH_ID event=OnKeyUp(kcode,scode)>
    if (this.Text == "") {
        EM_Q_BRCH_NAME.Text = "";
        return ;
    }
    if (kcode == 13 || kcode == 9 || this.Text.length == 10) { //TAB,ENTER 키 실행시에만 
        setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", this.Text);
        if (DS_O_RESULT.CountRow == 1 ) {
            this.Text           = DS_O_RESULT.NameValue(1, "CODE_CD");
            EM_Q_BRCH_NAME.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
        } else {
            //1건 이외의 내역이 조회 시 팝업 호출
            getBrchPop(this, EM_Q_BRCH_NAME);
        }
    }
</script>
<!-- Grid DETAIL oneClick event 처리 -->
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
  <object id="DS_IO_MASTER"  classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_IO_DETAIL"  classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_I_CONDITION"  classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_O_RESULT"  classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_DATA" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
  <object id="TR_MASTER" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
  </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
  </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
  </object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

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
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80">가맹점코드</th>
						<td width="220"><comment id="_NSID_"> <object
							id=EM_Q_BRCH_ID classid=<%=Util.CLSID_EMEDIT%> width="75"
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
						<img id="IMG_BRCH" src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							align="absmiddle"
							onclick="getBrchPop(EM_Q_BRCH_ID,EM_Q_BRCH_NAME)" /> <comment
							id="_NSID_"> <object id=EM_Q_BRCH_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=110 tabindex=1
							align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
						<th width="80" class="point">영수증번호</th>
                        <td width="140"><comment id="_NSID_"> <object id=EM_Q_RECP_NO
                            classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width="80">카드번호</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_CARD_NO_S classid=<%=Util.CLSID_EMEDIT%> width="140"
                            tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
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
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td valign="top">
                <table width="525" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td width="525" rowspan="3"><comment id="_NSID_"> <object
                            id=GR_MASTER width="525" height=508 classid=<%=Util.CLSID_GRID%>
                            tabindex=1>
                            <param name="DataID" value="DS_IO_MASTER">
                        </object> </comment> <script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
                <td width="30">&nbsp;</td>
                <td width="100%">
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <object id=GR_DETAIL
                            height=508 width="100%" classid=<%=Util.CLSID_GRID%> tabindex=1>
                            <param name="DataID" value="DS_IO_DETAIL">
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
</body>
</html>

