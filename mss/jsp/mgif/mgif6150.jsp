<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상품권관리 > 정산관리 >세금계산서관리
 * 작 성 일 : 2011.06.09
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : MGIF6150.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 세금계산서를 등록한다.
 * 이    력 : 2011.06.09 (김유완) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                    *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                 *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var g_autoFlag = false;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.06.09
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit() {
    // 입력 Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_CALMST"/>');

    //그리드 초기화
    gridCreate();

    // EMedit에 초기화
    initComboStyle(LC_S_STR_CD,DS_STR_CD,               "CODE^0^30,NAME^0^100", 1, PK);     // [조회용]시설구분
    initEmEdit(EM_S_CAL_YM,                             "YYYYMM", PK);                      // [조회용]부과년월
    initEmEdit(EM_VEN_CD,                             "NUMBER3^6^0", NORMAL);             // [조회용]협력사
    initEmEdit(EM_VEN_NM,                             "GEN",    READ);                    // [조회용]협력사명
    initEmEdit(EM_ISSUE_DT,                             "TODAY",  PK);                      // 발행일자
    //콤보 초기화
    getFlc("DS_STR_CD",                                 "M", "1", "Y", "N");                // [조회용]시설구분
    getEtcCode("DS_TAX_INV_TYPE",                       "D", "P404", "N");                  // 계산서종류 
    getEtcCode("DS_ETAX_STAT",                          "D", "P401", "N");                  // 계산서상태
    EM_S_CAL_YM.Text = getTodayFormat("YYYYMM");
    LC_S_STR_CD.Focus();
    LC_S_STR_CD.Index = 0;
    //objectControlDefault(false);
    
    EM_VEN_CD.Enable       = false;           
    enableControl(IMG_VEN_CD,false); 
    //종료시 데이터 변경 체크 (common.js )
    registerUsingDataset("mgif615","DS_IO_MASTER" );
}

/**
 * gridCreate("대상그리드")
 * 작 성 자 : FKL
 * 작 성 일 : 2011.06.09
 * 개    요 : 그리드SET
 * return값 : void
 */
function gridCreate() {
    var hdrProperies = ''
        + '<FC>ID={CURROW}          NAME=NO'         
        + '                                         WIDTH=30    ALIGN=CENTER</FC>'
        + '<FC>ID=CHK_BOX           NAME=""'
        + '                                         EDIT={IF(ETAX_STAT_NM="발행","FALSE","TRUE")}'
        + '                                         WIDTH=18    ALIGN=CENTER    EDITSTYLE=CHECKBOX  HEADCHECKSHOW=TRUE</FC>'
        + '<FC>ID=STR_NAME          NAME=점'        
        + '                                         WIDTH=120    ALIGN=left   EDIT="NONE" </FC>'
        + '<FC>ID=CAL_YM            NAME=부과년월'        
        + '                                         WIDTH=70    ALIGN=CENTER    MASK="XXXX/XX"  EDIT="NONE"</FC>'
        + '<FC>ID=CAL_TYPENM        NAME=정산유형         WIDTH=80   ALIGN=LEFT         EDIT="NONE"</FC>'
        + '<FC>ID=VEN_NM            NAME=협력사'        
        + '                                         WIDTH=190   ALIGN=LEFT      SUMTEXT="합계"   EDIT="NONE"</FC>'
        + '<FC>ID=TAX_GB_NM         NAME=계산서구분      WIDTH=80   ALIGN=LEFT         EDIT="NONE"</FC>'
        
        + '<FC>ID=FEE_RATE          NAME=수수료율        WIDTH=80   ALIGN=right        EDIT="NONE"</FC>'
        + '<FC>ID=REAL_PAY_AMT      NAME=실정산금액      WIDTH=80   ALIGN=right       EDIT="NONE"     sumtext=@sum </FC>'
        + '<FC>ID=SUP_AMT           NAME=공급가액         WIDTH=80   ALIGN=right         EDIT="NONE"   sumtext=@sum </FC>'
        + '<FC>ID=VAT_AMT           NAME=부가세             WIDTH=80   ALIGN=right        EDIT="NONE"    sumtext=@sum </FC>'
        + '<FC>ID=TOT_AMT           NAME=합계금액          WIDTH=80   ALIGN=right         EDIT="NONE"   sumtext=@sum </FC>'
        + '<FC>ID=ETAX_STAT_NM      NAME=계산서발행       WIDTH=80   ALIGN=LEFT         EDIT="NONE"   </FC>'
        + '<FC>ID=ETAX_STAT         NAME=세금계산서상태 WIDTH=100   ALIGN=LEFT        EDIT="NONE" EDITSTYLE=LOOKUP   DATA="DS_ETAX_STAT:CODE:NAME"</FC>'
        ;
        initGridStyle(GD_MASTER, "COMMON", hdrProperies, true);
        GD_MASTER.ViewSummary = "1";
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
 * 작 성 자 : FKL
 * 작 성 일 : 2011.06.09
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if (DS_IO_MASTER.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
            if (!checkValidateSearch()) return;
            //입금등록관련 정산마감 관련 내역 초기화
            DS_IO_MASTER.ClearData();
            objectControlDefault(false);
            
            // parameters
            var strStrCd    = LC_S_STR_CD.BindColVal;       // 점구분
            var strCalYM    = EM_S_CAL_YM.Text;             // 정산년월
            var strTaxType  = LC_S_TAX_TYPE.BindColVal;     // 계산서 발행여부
            var strCalType  = LC_S_CAL_TYPE.BindColVal;     // 정산유형
            var strVenCd    = EM_VEN_CD.Text;               // 협력사코드
            
            var goTo = "getMaster";
            var parameters = ""
                + "&strStrCd="      + encodeURIComponent(strStrCd)
                + "&strCalYM="      + encodeURIComponent(strCalYM)
                + "&strTaxType="    + encodeURIComponent(strTaxType)
                + "&strCalType="    + encodeURIComponent(strCalType)
                + "&strVenCd="      + encodeURIComponent(strVenCd);
            TR_MAIN.Action = "/mss/mgif615.mg?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
            TR_MAIN.Post();
            
            // 조회결과 Return
            setPorcCount("SELECT", DS_IO_MASTER.RealCount(1,DS_IO_MASTER.CountRow) );
            GD_MASTER.Focus();
        } else {
            return;
        }
    }  else {
        if (!checkValidateSearch()) return;
        //입금등록관련 정산마감 관련 내역 초기화
        DS_IO_MASTER.ClearData();
        objectControlDefault(false);
        
        // parameters
        var strStrCd    = LC_S_STR_CD.BindColVal;       // 점구분
        var strCalYM    = EM_S_CAL_YM.Text;             // 정산년월
        var strTaxType  = LC_S_TAX_TYPE.BindColVal;     // 계산서 발행여부
        var strCalType  = LC_S_CAL_TYPE.BindColVal;     // 정산유형
        var strVenCd    = EM_VEN_CD.Text;               // 협력사코드
        
        var goTo = "getMaster";
        var parameters = ""
            + "&strStrCd="      + encodeURIComponent(strStrCd)
            + "&strCalYM="      + encodeURIComponent(strCalYM)
            + "&strTaxType="    + encodeURIComponent(strTaxType)
            + "&strCalType="    + encodeURIComponent(strCalType)
            + "&strVenCd="      + encodeURIComponent(strVenCd);
        TR_MAIN.Action = "/mss/mgif615.mg?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();
        
        // 조회결과 Return
        setPorcCount("SELECT", DS_IO_MASTER.RealCount(1,DS_IO_MASTER.CountRow) );
        GD_MASTER.Focus();
    }
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.06.09
 * 개    요 : 초기화
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.06.09
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.06.09
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	if (DS_IO_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장
		if (EM_ISSUE_DT.Text == "") {
			showMessage(INFORMATION, OK, "USER-1000", "발행일자를 입력하세요");
			EM_ISSUE_DT.Focus();
			return false;
		} 

		// 저장 parameters
        var strIssueDT    = EM_ISSUE_DT.Text;            // 발행일자 

        var goTo = "taxProcess";
		var parameters = ""
			+ "&strIssueDT="        + encodeURIComponent(strIssueDT);
		TR_SAVE.Action = "/mss/mgif615.mg?goTo=" + goTo + parameters;
		TR_SAVE.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
		TR_SAVE.Post();
		
	} else {
	    showMessage(INFORMATION, OK, "USER-1028");
	}
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.06.09
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.06.09
 * 개    요 : 출력
 * return값 : void
 */
function btn_Print() {
}


/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getVenCd()
  * 작 성 자 : 
  * 작 성 일 : 2011-04-06
  * 개    요 : 가맹점 팝업 오픈시 점코드 필수
  * return값 : void
  */
 function getVenCd(){
     if(LC_S_STR_CD.BindColVal == ""){
            showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
            LC_STR.Focus();
            return;
        }
     getMssEvtVenPop( EM_VEN_CD, EM_VEN_NM, 'S', LC_S_CAL_TYPE.BindColVal, '', LC_S_STR_CD.BindColVal);
 }

 
/**
 * checkValidateSearch()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.06.09
 * 개    요 : 값체크
 * return값 :
 */
function checkValidateSearch() {
     if (LC_S_STR_CD.BindColVal == "") {
         showMessage(INFORMATION, OK, "USER-1000", "시설(구분)을 선택하세요");
         LC_S_STR_CD.Focus();
         return false;
     }
     
     if (EM_S_CAL_YM.Text == "") {
         showMessage(INFORMATION, OK, "USER-1000", "부과년월(FROM) 입력 하세요");
         EM_S_CAL_YM.Focus();
         return false;
     }

    return true;
}

/**
 * objectControlDefault()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.06.09
 * 개    요 : 세금계산서관리 생성 부 컨트롤
 * return값 :
 */
function objectControlDefault(objBoolean) {
    if (objBoolean) {
        //이미지
        //enableControl(IMG_CREATE_CHRG,true);
        //enableControl(IMG_CANCEL_CHRG,true);
    } else {
        //EM_ISSUE_DT.Text = "";
        //이미지
        //enableControl(IMG_CREATE_CHRG,false);
        //enableControl(IMG_CANCEL_CHRG,false);
    }
}

-->
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                          *-->
<!--*    1. TR Success 메세지 처리                                                                                         *-->
<!--*    2. TR Fail 메세지 처리                                                                                               *-->
<!--*    3. DataSet Success 메세지 처리                                                                               *-->
<!--*    4. DataSet Fail 메세지 처리                                                                                     *-->
<!--*    5. DataSet 이벤트 처리                                                                                               *-->
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
    }
    
    // parameters
    var strStrCd    = LC_S_STR_CD.BindColVal;       // 시설구분
    var strCalYM    = EM_S_CAL_YM.Text;             // 부과년월
    var strTaxType  = LC_S_TAX_TYPE.BindColVal;     // 임대형태
    var strVenCd    = EM_VEN_CD.Text;             // 협력사코드
    
    var goTo = "getMaster";
    var parameters = ""
        + "&strStrCd="      + encodeURIComponent(strStrCd)
        + "&strCalYM="      + encodeURIComponent(strCalYM)
        + "&strTaxType="    + encodeURIComponent(strTaxType)
        + "&strVenCd="      + encodeURIComponent(strVenCd);
    TR_MAIN.Action = "/mss/mgif615.mg?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
    TR_MAIN.Post();
    
    setPorcCount("SELECT", DS_IO_MASTER.RealCount(1,DS_IO_MASTER.CountRow) );
    GD_MASTER.Focus();
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
    if(clickSORT)return;
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1 && colid!="CHK_BOX")  sortColId( eval(this.DataID), row , colid );
</script>

 <script language=JavaScript for=EM_VEN_CD event=OnKillFocus()>
//if(this.Text.length > 0){
    if(!this.Modified)
        return;
        
    if(this.text==''){
        EM_VEN_NM.Text = "";
        return;
    } 
    if(LC_S_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
        LC_S_STR_CD.Focus();
        return;
    }
    
    getMssEvtVenNonPop( "DS_O_RESULT", EM_VEN_CD, EM_VEN_NM, "E", "Y", "1", '', LC_S_STR_CD.BindColVal);
//}
//return true;
</script>

<script language=javascript for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
//헤더 전체 체크/체크해제 컨트롤
    if (bCheck == '1'){ // 전체체크
        GD_MASTER.Redraw = false;
        for(var i=1; i<=DS_IO_MASTER.CountRow; i++){
        	if (DS_IO_MASTER.NameValue(i, "ETAX_STAT_YN") == 'N') {
	            DS_IO_MASTER.NameValue(i, "CHK_BOX") = 'T';
        	}
        }
        GD_MASTER.Redraw = true;
    }else{  // 전체체크해제
        GD_MASTER.Redraw = false;
        for (var i=1; i<=DS_IO_MASTER.CountRow; i++){
            if (DS_IO_MASTER.NameValue(i, "ETAX_STAT_YN") == 'N') {
                DS_IO_MASTER.NameValue(i, "CHK_BOX") = 'F';
            }
        }
        GD_MASTER.Redraw = true;
    }
</script>

<script language=JavaScript for=LC_S_CAL_TYPE event=OnSelChange()>
//조회조건초기화
if (LC_S_CAL_TYPE.BindColVal == "%") {
	EM_VEN_CD.Text         = "";
	EM_VEN_NM.Text         = "";
	EM_VEN_CD.Enable       = false;           
    enableControl(IMG_VEN_CD,false); 
} else {
	EM_VEN_CD.Enable       = true;           
    enableControl(IMG_VEN_CD,true);
}
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                      *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                         *-->
<!--*    1. DataSet                                                         *-->
<!--*    2. Transaction                                                     *-->
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<!-- ===============- ONLOAD용 -->
<comment id="_NSID_"><object id="DS_STR_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_ETAX_STAT"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
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
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                         *-->
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
						<th width="80" class="point">점</th>
						<td width="115"><comment id="_NSID_"><object
							id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="110"
							tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
						<th width="80" class="point">정산년월</th>
						<td colspan="3"><comment id="_NSID_"><object
							id=EM_S_CAL_YM classid=<%=Util.CLSID_EMEDIT%> width="70"
							tabindex=1 onblur="javascript:checkDateTypeYM(this);"
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('M',EM_S_CAL_YM);" /></td>
					</tr>
					<tr>
						<th>계산서 발행여부</th>
						<td><comment id="_NSID_"> <object id=LC_S_TAX_TYPE
							classid=<%=Util.CLSID_LUXECOMBO%> width="110" tabindex=1
							align="absmiddle">
							<param name=CBData value="%^전체,Y^발행,N^미발행">
							<param name=CBDataColumns value="CODE,NAME">
							<param name=SearchColumn value="NAME">
							<param name=ListExprFormat value="CODE^2^30,NAME^1^100">
							<param name=BindColumn value="CODE">
							<param name=Index value="0">
						</object> </comment><script>_ws_(_NSID_);</script></td>
						<th>정산유형</th>
						<td><comment id="_NSID_"> <object
							id=LC_S_CAL_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width="110"
							tabindex=1 align="absmiddle">
							<param name=CBData value="%^전체,1^제휴협력사정산 ,2^가맹점정산">
							<param name=CBDataColumns value="CODE,NAME">
							<param name=SearchColumn value="NAME">
							<param name=ListExprFormat value="CODE^2^30,NAME^1^100">
							<param name=BindColumn value="CODE">
							<param name=Index value="0">
						</object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="80">협력사</th>
                        <td><comment id="_NSID_"> <object id=EM_VEN_CD
                            classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
                            align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VEN_CD"
                            align="absmiddle" class="PR03" onclick="javascript:getVenCd();" />
                        <comment id="_NSID_"> <object id=EM_VEN_NM
                            classid=<%=Util.CLSID_EMEDIT%> width=180 tabindex=1
                            align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
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
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="PT01 PB03">
				<table width="220" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">발행일자</th>
						<td width="110"><comment id="_NSID_"><object
							id=EM_ISSUE_DT classid=<%=Util.CLSID_EMEDIT%> width="85"
							tabindex=1 onblur="javascript:checkDateTypeYMD(this);"
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script><img
							src="/pot/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_ISSUE_DT);" /></td>
					</tr>
				</table>
				</td>
				<td class="right"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PT05">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><object id=GD_MASTER
					width="100%" height=442 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_IO_MASTER">
				</object></comment><script>_ws_(_NSID_);</script></td>
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
