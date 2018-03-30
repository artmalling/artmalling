<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 판매/회수> 반품 상품권 재사용 등록(상품권 재사용등록)
 * 작 성 일 : 2011.04.28
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : mgif3060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 상품권의 반품/교환반품 등록내역을 조회하여 재사용이 가능한 상품권의 재사용 내역을 등록한다.
 * 이    력 :
 *        2011.04.28 (이정식) 신규작성
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
    String strStartDt = Date2.getYear() + Date2.getMonth() + "01";
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
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-28
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    //Input Data Set Header 초기화
     DS_RTN_COU.setDataHeader('<gauce:dataset name="H_SEL_RTN_COU"/>');
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
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("mgfi3060","DS_RTN_COU" );
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2011-04-28
 * 개    요 : EMEDIT 설정 
 * return값 : void
*/
function setEmEdit(){
    initEmEdit(EM_RTN_S_DT,    "SYYYYMMDD", PK);        //반품회수기간 시작
    initEmEdit(EM_RTN_E_DT,    "TODAY"    , PK);        //반품회수기간 종료
    initEmEdit(EM_REUSE_DT,    "TODAY"    , PK);        //재사용등록일자
    initEmEdit(EM_GIFTCARD_NO, "GEN^12^0", NORMAL); //상품권코드
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-28
 * 개    요 : 콤보 설정 
 * return값 : void
*/
function setCombo(){
    initComboStyle(LC_STR_CD  , DS_STR_CD  , "CODE^0^30,NAME^0^90", 1, PK);      //회수점(조회)콤보
    initComboStyle(LC_RTN_TYPE, DS_RTN_TYPE, "CODE^0^30,NAME^0^120", 1, NORMAL); //회수구분 콤보
    
    //점콤보 가져오기 ( gauce.js )
    getStore("DS_STR_CD", "Y", "1", "N");
    LC_STR_CD.BindColVal = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'; // 로그인 점코드
    if( LC_STR_CD.Index < 0) LC_STR_CD.Index= 0;
    
    getEtcCode("DS_RTN_TYPE", "D", "M076", "Y");
    DS_RTN_TYPE.DeleteRow(2);
    DS_RTN_TYPE.DeleteRow(4);
  	LC_RTN_TYPE.BindColVal    = "%";
    
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-28
 * 개    요 : 반품상품권 그리드 초기화 
 * return값 : void
*/
function gridCreate(){
    //결제내역 그리드
    var hdrProperies = '<FC>id={currow}      width=30  align=center name="NO"</FC>'
                     + '<FC>id=CHECK_FLAG    width=20  align=center name="" EditStyle=checkbox HeadCheck=false HeadCheckShow=true</FC>'
                     + '<FC>id=STR_NAME      width=80  align=left   edit=none name="회수점"</FC>'
                     + '<FC>id=DRAWL_DT      width=90  align=center edit=none name="회수일자" Mask="XXXX/XX/XX"</FC>'
                     + '<C>id=STAT_NAME      width=120  align=center edit=none name="회수구분"</C>'
                     + '<C>id=GIFT_TYPE_NAME width=110 align=left   edit=none name="상품권종류"</C>'
                     + '<C>id=GIFT_AMT_NAME  width=105 align=left   edit=none name="금종명"</C>'
                     + '<C>id=GIFTCERT_AMT   width=90  align=right  edit=none name="상품권금액"</C>'
                     + '<C>id=GIFTCARD_NO    width=180 align=center edit=none name="상품권코드"</C>'
                     + '</G>'
                     ;
                     
    initGridStyle(GD_RTN_COU, "common", hdrProperies, true);
}
/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
     (6) 출력       - btn_Print()
     (7) 확정       - btn_Conf()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-28
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	
    //1. validation
    if (isNull(LC_STR_CD.BindColVal)){
        showMessage(EXCLAMATION, OK, "USER-1002", "점"); //(점)은/는 반드시 선택해야 합니다.
        LC_STR_CD.Focus();
        return;
    }
    
    if (isNull(EM_RTN_S_DT.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "반품회수기간"); //(반품회수기간)은/는 반드시 입력해야 합니다.
        EM_RTN_S_DT.focus();
        return;
    }
	
    if (isNull(EM_RTN_E_DT.text)){
	    showMessage(EXCLAMATION, OK, "USER-1003", "반품회수기간"); //(반품회수기간)은/는 반드시 입력해야 합니다.
	    EM_RTN_E_DT.focus();
	    return;
	}
	
    if (!checkYYYYMMDD(EM_RTN_S_DT.text)){
        showMessage(EXCLAMATION, OK, "USER-1061", "반품회수기간");//(반품회수기간)은/는 유효하지 않는 날짜입니다.
        EM_RTN_S_DT.focus();
        return;
    }
    startDt = EM_RTN_S_DT.text;
	
    if (!checkYYYYMMDD(EM_RTN_E_DT.text)){
        showMessage(EXCLAMATION, OK, "USER-1061", "반품회수기간");//(반품회수기간)은/는 유효하지 않는 날짜입니다.
        EM_RTN_E_DT.focus();
        return;
    }
    
    if(EM_RTN_S_DT.text > EM_RTN_E_DT.text){
        showMessage(EXCLAMATION, OK, "USER-1015"); //시작일은 종료일보다 작아야 합니다.
        EM_RTN_S_DT.focus();
        return;
    }
    
    if(EM_RTN_E_DT.text > EM_REUSE_DT.text){
        showMessage(EXCLAMATION, OK, "USER-1000", "조회 종료일은 재사용등록일자보다 크거나 같아야 합니다.");  
        EM_RTN_E_DT.text = EM_REUSE_DT.text;
        EM_RTN_E_DT.focus();
        return;
    }
    
    if( DS_RTN_COU.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(EXCLAMATION, YESNO, "USER-1059") != 1 ){           
        	DS_RTN_COU.Focus();
            return;
        }
    }
    
    lo_StrCd = LC_STR_CD.BindColVal;
    
    //2. 데이터셋 초기화
    DS_RTN_COU.ClearData();
    LC_STR_CD.Enable = true;
    //3. 조회시작
    //헤더체크초기화
    GD_RTN_COU.ColumnProp('CHECK_FLAG','HeadCheck') = false;
    var goTo       = "searchRtnCou";
    
    var action     = "O";
    var parameters = "&strStoreCd=" + encodeURIComponent(LC_STR_CD.BindColVal) //회수점코드
                   + "&strStartDt=" + encodeURIComponent(EM_RTN_S_DT.text) //반품회수기간 시작일 
                   + "&strEndDt="   + encodeURIComponent(EM_RTN_E_DT.text) //반품회수기간 종료일
                   + "&strRtnType=" + encodeURIComponent(LC_RTN_TYPE.BindColVal) //회수구분
                   + "&isAll=Y"
                   ;
    
    TR_MAIN.Action   = "/mss/mgif306.mg?goTo="+goTo+parameters;
    TR_MAIN.KeyValue = "SERVLET("+action+":DS_RTN_COU=DS_RTN_COU)"; //조회는 O    
    TR_MAIN.Post();
    
    if(DS_RTN_COU.CountRow > 0)
    	setObject(false);
    else
    	setObject(true);
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_RTN_COU);    
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-28
 * 개    요 : 
 * return값 : void
*/
function subQuery(row){
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-28
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    if( DS_RTN_COU.IsUpdated || DS_RTN_COU.CountRow > 0){
	    // 변경된 상세내역이 존재합니다. 신규작성하시겠습니까?
	    if( showMessage(EXCLAMATION, YESNO, "USER-1050") != 1 ){           
	        DS_RTN_COU.Focus();
	        return;
	    }
	}
	DS_RTN_COU.ClearData();
	// LC_STR_CD.Enable = true;
    setObject(true);
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-28
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-28
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    //저장할 데이터 없는 경우
    if (!DS_RTN_COU.IsUpdated || DS_RTN_COU.CountRow == 0){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
    
    var Row = DS_RTN_COU.NameValueRow("CHECK_FLAG","T");

    if(Row == 0){
    	//저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
    
    if (isNull(EM_REUSE_DT.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "재사용등록일자"); //(재사용등록일자)은/는 반드시 입력해야 합니다.
        EM_REUSE_DT.focus();
        return;
    }
    if (!checkYYYYMMDD(EM_REUSE_DT.text)){
        showMessage(EXCLAMATION, OK, "USER-1061", "재사용등록일자"); //(재사용등록일자)은/는 유효하지 않는 날짜입니다.
        EM_REUSE_DT.focus();
        return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ) return;
    
    TR_MAIN.Action   = "/mss/mgif306.mg?goTo=save&strReUseDt=" + encodeURIComponent(EM_REUSE_DT.text);
    TR_MAIN.KeyValue = "SERVLET(I:DS_RTN_COU=DS_RTN_COU)"; //조회는 O
    TR_MAIN.Post();
    
    //정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0) btn_Search();
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-28
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-28
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-28
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
function setObject(flag){
	LC_STR_CD.Enable = flag;
	EM_GIFTCARD_NO.Enable = flag;
	EM_REUSE_DT.Enable = flag;
	EM_RTN_S_DT.Enable = flag; 
	EM_RTN_E_DT.Enable = flag;
	enableControl(IMG_SDT, flag);
	enableControl(IMG_EDT, flag);
	enableControl(IMG_DT, flag);
}
/**
  * getGiftCardNo()
  * 작 성 자 : 이정식
  * 작 성 일 : 2011-04-28
  * 개    요 : 상품권 코드에대한 정보 조회 
  * return값 : void
  */
function getGiftCardNo() {
	DS_O_RESULT.ClearData();
    var strGiftCardNo = EM_GIFTCARD_NO.Text;
      
    var goTo       = "searchRtnSingleCou"; 
    var parameters = "&strStoreCd=" + LC_STR_CD.BindColVal      //회수점코드
                   + "&strGiftNo="  + strGiftCardNo //상품권번호
                   + "&isAll=N"
                   ;

    DS_O_RESULT.DataID   = "/mss/mgif306.mg?goTo="+goTo+parameters;
    DS_O_RESULT.SyncLoad = "true";
    DS_O_RESULT.Reset();

    if(DS_O_RESULT.CountRow == "0") {
        showMessage(INFORMATION, OK, "USER-1000", strGiftCardNo + "상품권의 상태가 판매/가판매 상태가 아닙니다.");
        EM_GIFTCARD_NO.Text = "";
        setTimeout("EM_GIFTCARD_NO.Focus();",50);
        return;
    } else {
    	var sameRow = DS_RTN_COU.NameValueRow("GIFTCARD_NO", DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "GIFTCARD_NO"));
        if(sameRow != 0){
        	showMessage(INFORMATION, OK, "USER-1000", strGiftCardNo + "의 상품권 번호가 중복됩니다.");
            EM_GIFTCARD_NO.Text = "";
            setTimeout("EM_GIFTCARD_NO.Focus();",50);
            return false;
        }
        
        if(DS_O_RESULT.NameValue(1,"DRAWL_STR") != DS_O_RESULT.NameValue(1,"IN_STR")){
        	showMessage(INFORMATION, OK, "USER-1000", strGiftCardNo + "의 회수점과 입고점이 다릅니다. 재사용하실수 없습니다.");
            EM_GIFTCARD_NO.Text = "";
            setTimeout("EM_GIFTCARD_NO.Focus();",50);
            return false;
        }
        var data = DS_O_RESULT.ExportData(1,DS_O_RESULT.CountRow,false); 
        DS_RTN_COU.ImportData(data);
        LC_STR_CD.Enable = false; 
        EM_GIFTCARD_NO.Text = "";
        setTimeout("EM_GIFTCARD_NO.Focus();", 50); 
    }
}

/**
 * delRow()
 * 작 성 자 : 
 * 작 성 일 : 2011-04-28
 * 개    요 : 행삭제
 * return값 : void
 */
function delRow() {
    if(DS_RTN_COU.CountRow == 0){
        showMessage(INFORMATION, OK, "USER-1019");
        return;
    }
    
    for(var i=DS_RTN_COU.CountRow; i>0; i--) {
        if(DS_RTN_COU.NameValue(i,"CHECK_FLAG") == "T") DS_RTN_COU.DeleteRow(i);
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
<script language=JavaScript for=DS_RTN_COU  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_O_RESULT  event=OnLoadError()>
    dsFailed(this);
</script>

<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!-- Grid sorting event 처리 -->
<script language=JavaScript for=GD_RTN_COU event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_CAL_DTL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!--헤더 체크시 일괄체크 처리-->
<script language="javascript"  for=GD_RTN_COU event=OnHeadCheckClick(col,colid,bCheck)>
    this.ReDraw = "false";    // 그리드 전체 draw 를 false 로 지정
    if (bCheck == '1'){       // 전체체크
        for(var i=1; i<=DS_RTN_COU.CountRow; i++) DS_RTN_COU.NameString(i, colid) = 'T';
    }else{                    // 전체체크해제
        for(var i=1; i<=DS_RTN_COU.CountRow; i++) DS_RTN_COU.NameString(i, colid) = 'F';
    }
    this.ReDraw = "true";       
</script>
<script language=JavaScript for=EM_GIFTCARD_NO event=OnKillFocus()>
if(this.Text == "") return;
//if(this.Text.length != 13 && this.Text.length != 16 && this.Text.length != 18){
if(this.Text.length != 12){
    showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
    this.Text = "";
    setTimeout("EM_GIFTCARD_NO.Focus()", 50);
    return;
}
getGiftCardNo();
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                              *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                           		*-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_">
<!-- ====================Output용================== -->
    <!--[콤보]점구분 -->
    <object id="DS_STR_CD"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]회수구분 -->
    <object id="DS_RTN_TYPE" classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]반품상품권 -->
    <object id="DS_RTN_COU"  classid=<%= Util.CLSID_DATASET %>></object>
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
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
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
    <td class="PT01 PB03" colspan=2><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="90" class="point">회수점</th>
            <td width="120">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=120  align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">회수기간</th>
            <td width="220">
              <comment id="_NSID_">
                <object id=EM_RTN_S_DT classid=<%=Util.CLSID_EMEDIT%> width=80 onblur="checkDateTypeYMD(this, '<%=strStartDt%>');" align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03" id=IMG_SDT
                onclick="javascript:openCal('G',EM_RTN_S_DT)" align="absmiddle" />
              ~ 
              <comment id="_NSID_">
                <object id=EM_RTN_E_DT classid=<%=Util.CLSID_EMEDIT%> width=80 onblur="checkDateTypeYMD(this);" align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03" id=IMG_EDT
                onclick="javascript:openCal('G',EM_RTN_E_DT)" align="absmiddle" />
            </td>
            <th width="80">회수구분</th>
            <td>
              <comment id="_NSID_">
                <object id=LC_RTN_TYPE classid=<%= Util.CLSID_LUXECOMBO %> width=167 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="PT01 PB03"><table width="555" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="88" class="point">재사용등록일자</th>
            <td width="120">
              <comment id="_NSID_">
                <object id=EM_REUSE_DT classid=<%=Util.CLSID_EMEDIT%> width=80 onblur="checkDateTypeYMD(this);" align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03" id=IMG_DT
                onclick="javascript:openCal('G',EM_REUSE_DT)" align="absmiddle" />
            </td>
            <th width="80">상품권코드</th>
            <td width="210">
              <comment id="_NSID_">
                <object id=EM_GIFTCARD_NO classid=<%=Util.CLSID_EMEDIT%> width=200 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
    <td class="right"><img src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18" onClick="javascript:delRow();" />
  </tr>
  <tr>
    <td class="dot" colspan=2></td>
  </tr>
  <tr>
    <td class="PT01 PB03" colspan=2><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_RTN_COU width="100%" height=465 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_RTN_COU">
                </object></comment><script>_ws_(_NSID_);</script>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>
