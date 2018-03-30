<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 입고/출고> 상품권 강제불출
 * 작 성 일 : 2011.07.29
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : mgif2140.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 강제결제불출나 훼손 상품권을 강제불출처리한다.
 * 이    력 : 2011.07.29 (김유완) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo,
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.Date2" %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%    
    String dir        = BaseProperty.get("context.common.dir");
    String strPoutDt  = Date2.getYear() + Date2.getMonth() + "01";
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var lo_StrCd = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김유완
 * 작 성 일 : 2011.07.29
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    //Input Data Set Header 초기화
     DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_POUT_GIFT"/>');
    //Output Data Set Header 초기화
    
    //EMEDIT 설정
    setEmEdit();

    //콤보 초기화
    setCombo();
    
    //그리드 초기화
    gridCreate();
    
    //화면로딩시 점콤보에 포커스
    LC_STR_CD.Focus();
    
    lo_StrCd = LC_STR_CD.BindColVal;
    enableControl(IMG_DEL_ROW, false);  
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_MASTER");
}

/**
 * setEmEdit()
 * 작 성 자 : 김유완
 * 작 성 일 :  2011.07.29
 * 개    요 : EMEDIT 설정 
 * return값 : void
*/
function setEmEdit(){
    initEmEdit(EM_POUT_DT,     "TODAY", PK);            //불출일자
    initEmEdit(EM_GIFTCARD_NO, "GEN^18^0", NORMAL); //상품권코드
    //initEmEdit(EM_GIFTCARD_NO, "NUMBER3^18^0", NORMAL); //상품권코드
}

/**
 * setCombo()
 * 작 성 자 : 김유완
 * 작 성 일 : 2011.07.29
 * 개    요 : 콤보 설정 
 * return값 : void
*/
function setCombo(){
    initComboStyle(LC_STR_CD  , DS_STR_CD  , "CODE^0^30,NAME^0^90", 1, PK);     //점(조회)콤보
    initComboStyle(LC_POUT_TYPE, DS_POUT_TYPE, "CODE^0^30,NAME^0^120", 1, PK);  //불출유형
    LC_POUT_TYPE.Enable = false;
    
    //점콤보 가져오기 ( gauce.js )
    getStore("DS_STR_CD", "Y", "1", "N");
    LC_STR_CD.BindColVal = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'; // 로그인 점코드
    if( LC_STR_CD.Index < 0) LC_STR_CD.Index= 0;
    
    getEtcCode("DS_POUT_TYPE", "D", "M014", "N");
    LC_POUT_TYPE.BindColVal  = "5"; /*재무강제불출*/  
}

/**
 * gridCreate()
 * 작 성 자 : 김유완
 * 작 성 일 : 2011.07.29
 * 개    요 : 반품상품권 그리드 초기화 
 * return값 : void
*/
function gridCreate(){
	var hdrProperies = ''
		+ '<FC>ID={CURROW}        NAME="NO"'
		+ '                                         WIDTH=30    ALIGN=CENTER</FC>'
		+ '<FC>ID=GIFT_TYPE_NAME  NAME="상품권종류"'
		+ '                                         WIDTH=110   ALIGN=LEFT     EDIT=NONE </FC>'
		+ '<FC>ID=GIFT_AMT_NAME   NAME="금종명"'
		+ '                                         WIDTH=130   ALIGN=LEFT     EDIT=NONE SUMTEXT="합계"</FC>'
		+ '<FC>ID=GIFTCERT_AMT    NAME="상품권금액"'
		+ '                                         WIDTH=110   ALIGN=RIGHT    EDIT=NONE</FC>'
		+ '<FC>ID=GIFTCARD_NO     NAME="상품권번호"'
		+ '                                         WIDTH=160   ALIGN=CENTER   EDIT=NONE</FC>'
		+ '<FC>ID=CONF_QTY        NAME="수량"'
		+ '                                         WIDTH=110   ALIGN=RIGHT    EDIT=NUMERIC SUMTEXT=@SUM</FC>'
		+ '<FC>ID=CONF_AMT        NAME="불출금액"'
		+ '                                         WIDTH=130   ALIGN=RIGHT    EDIT=NONE SUMTEXT=@SUM</FC>'
		; 
    initGridStyle(GD_MAIN, "common", hdrProperies, true);
    GD_MAIN.ViewSummary = "1";
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
     (6) 출력       - btn_Print()
     (7) 확정       - btn_Conf()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자 : 김유완
 * 작 성 일 : 2011.07.29
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

}

/**
 * btn_New()
 * 작 성 자 : 김유완
 * 작 성 일 : 2011.07.29
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    if( DS_MASTER.IsUpdated || DS_MASTER.CountRow > 0){
	    // 변경된 상세내역이 존재합니다. 신규작성하시겠습니까?
	    if( showMessage(EXCLAMATION, YESNO, "USER-1050") != 1 ){           
	        DS_MASTER.Focus();
	        return;
	    }
	}
	DS_MASTER.ClearData();
	// LC_STR_CD.Enable = true;
    setObject(true);
}

/**
 * btn_Save()
 * 작 성 자 : 김유완
 * 작 성 일 : 2011.07.29
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    //저장할 데이터 없는 경우
    if (!DS_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ) return;
    
    var parameters = "&strStoreCd="  + encodeURIComponent(LC_STR_CD.BindColVal)      //점코드
				    + "&strPoutDt="  + encodeURIComponent(EM_POUT_DT.text)          //불출일자
				    + "&strPoutType="+ encodeURIComponent(LC_POUT_TYPE.BindColVal)  //불출유형
				    ;
    TR_MAIN.Action   = "/mss/mgif214.mg?goTo=save" + parameters;
    TR_MAIN.KeyValue = "SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0) DS_MASTER.ClearData();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
function setObject(flag){
	LC_STR_CD.Enable       = flag;
	//LC_POUT_TYPE.Enable    = flag; 
	//EM_GIFTCARD_NO.Enable  = flag;
	EM_POUT_DT.Enable      = flag; 
	enableControl(IMG_POUT_DT, flag);
	
	if (flag) {
		enableControl(IMG_DEL_ROW, false);	
	} else {
		enableControl(IMG_DEL_ROW, true);	
	}
	//그리드 설정
	/*
	if (flag) {
		GD_MAIN.ColumnProp("CONF_QTY","Edit")="Numeric";
		GD_MAIN.ColumnProp("CONF_AMT","Edit")="Numeric";
	} else {
        GD_MAIN.ColumnProp("CONF_QTY","Edit")="None";
        GD_MAIN.ColumnProp("CONF_AMT","Edit")="None";
	}
	*/
}

/**
  * getGiftCardNo()
  * 작 성 자 : 김유완
  * 작 성 일 : 2011.07.29
  * 개    요 : 상품권 코드에대한 정보 조회 
  * return값 : void
  */
function getGiftCardNo() {
	DS_O_RESULT.ClearData();
	var strGiftCardNo = EM_GIFTCARD_NO.Text;
    var goTo       = "getGiftNoInfo"; 
    var parameters = "&strStoreCd=" + LC_STR_CD.BindColVal  //점코드
                   + "&strGiftNo="  + strGiftCardNo         //상품권번호
                   + "&isAll=N"
                   ;

    DS_O_RESULT.DataID   = "/mss/mgif214.mg?goTo="+goTo+parameters;
    DS_O_RESULT.SyncLoad = "true";
    DS_O_RESULT.Reset();

    if(DS_O_RESULT.CountRow == "0") {
        showMessage(INFORMATION, OK, "USER-1000", strGiftCardNo + "상품권의 상태가 불출가능 상태가 아닙니다.");
        EM_GIFTCARD_NO.Text = "";
        setTimeout("EM_GIFTCARD_NO.Focus();",50);
        return;
    } else {
    	var sameRow = DS_MASTER.NameValueRow("GIFTCARD_NO", DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "GIFTCARD_NO"));
        if(sameRow != 0){
        	showMessage(INFORMATION, OK, "USER-1000", strGiftCardNo + "의 상품권 번호가 중복됩니다.");
            EM_GIFTCARD_NO.Text = "";
            setTimeout("EM_GIFTCARD_NO.Focus();",50);
            return false;
        } else {
	        var data = DS_O_RESULT.ExportData(1,DS_O_RESULT.CountRow,false); 
	        DS_MASTER.ImportData(data);
	        LC_STR_CD.Enable = false; 
	        EM_GIFTCARD_NO.Text = "";
	        setTimeout("EM_GIFTCARD_NO.Focus();", 50); 
        }
    }
}

/**
 * delRow()
 * 작 성 자 : 
 * 작 성 일 : 2011.07.29
 * 개    요 : 행삭제
 * return값 : void
 */
function delRow() {
    if(DS_MASTER.CountRow == 0){
        showMessage(INFORMATION, OK, "USER-1019");
        return;
    }
    
    DS_MASTER.DeleteRow(DS_MASTER.RowPosition);
}
-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*    6. 컴포넌트 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!----------------------- 2. TR Fail 메세지 처리  ----------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_MASTER  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_O_RESULT  event=OnLoadError()>
    dsFailed(this);
</script>

<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_MASTER event=onColumnChanged(row,colid)>
//불출수량변경 시 불출금액 변경 
if (colid == 'CONF_QTY') {
	DS_MASTER.NameValue(row,'CONF_AMT')= DS_MASTER.NameValue(row,'GIFTCERT_AMT') * DS_MASTER.NameValue(row,'CONF_QTY');
}
</script>

<script language=JavaScript for=DS_MASTER event=onRowPosChanged(row,colid)>
// 입력에따른 Object 활성/비활성화
if (DS_MASTER.CountRow == 0) {
	setObject(true); 
} else if (DS_MASTER.CountRow == 1) {
	setObject(false); 
}
</script>


<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!-- Grid sorting event 처리 -->
<script language=JavaScript for=GD_MAIN event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_CAL_DTL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=EM_GIFTCARD_NO event=OnKillFocus()>
if(this.Text == "") return;
if(this.Text.length != 12 && this.Text.length != 13 && this.Text.length != 16 && this.Text.length != 18){
    showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
    this.Text = "";
    setTimeout("EM_GIFTCARD_NO.Focus()", 50);
    return;
}
getGiftCardNo();
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_">
<!-- ====================Output용================== -->
    <!--[콤보]점구분 -->
    <object id="DS_STR_CD"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]불출유형 -->
    <object id="DS_POUT_TYPE" classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]반품상품권 -->
    <object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object>
    <!-- 상품권번호이용조회 -->
    <object id="DS_O_RESULT" classid=<%= Util.CLSID_DATASET %>></object>
<!-- ====================Input용================== -->

<!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
    <!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
        <param name="KeyName" value="Toinb_dataid4">
    </object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝  
<!--*************************************************************************-->
<!--* E. 본문시작 
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="PT01 PB03" colspan=2>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">불출점</th>
						<td width="120"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=120
							align="absmiddle"></object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80" class="point">불출일자</th>
						<td width="130"><comment id="_NSID_"> <object
							id=EM_POUT_DT classid=<%=Util.CLSID_EMEDIT%> width=100
							onblur="checkDateTypeYMD(this, '<%=strPoutDt%>');"
							align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" class="PR03" id=IMG_POUT_DT
							onclick="javascript:openCal('G',EM_POUT_DT)" align="absmiddle" />
						</td>
						<th width="80">불출유형</th>
						<td class="point"><comment id="_NSID_"> <object id=LC_POUT_TYPE
							classid=<%= Util.CLSID_LUXECOMBO %> width=220 align="absmiddle"></object>
						</comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PT01 PB03">
		<table width="320" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80">상품권코드</th>
						<td width="210"><comment id="_NSID_"> <object
							id=EM_GIFTCARD_NO classid=<%=Util.CLSID_EMEDIT%> width=200
							tabindex=1 align="absmiddle"></object> </comment><script>_ws_(_NSID_);</script>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
		<td class="right"><img src="/<%=dir%>/imgs/btn/del_row.gif" id="IMG_DEL_ROW"
			width="52" height="18" onClick="javascript:delRow();" />
	</tr>
	<tr>
		<td class="dot" colspan=2></td>
	</tr>
	<tr>
		<td class="PT01 PB03" colspan=2>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"><object id=GD_MAIN
							width="100%" height=465 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_MASTER">
						</object></comment><script>_ws_(_NSID_);</script></td>
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
