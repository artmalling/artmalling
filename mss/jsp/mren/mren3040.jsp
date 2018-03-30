<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 관리비청구/입금관리 >관리비정산조회
 * 작 성 일 : 2010.05.26
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : MREN304.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 관리비청구서를 조회/출력한다
 * 이    력 : 2010.05.26 (김유완) 신규작성
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
	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

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
 * 작 성 일 : 2010.05.26
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 120;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit() {
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // 입력 Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_CALMST"/>');

    //그리드 초기화
    gridCreate();

    // EMedit에 초기화
    initComboStyle(LC_S_STR_CD,DS_STR_CD,               "CODE^0^30,NAME^0^100", 1, PK);     // [조회용]시설구분
    initEmEdit(EM_S_CAL_SYM,                            "YYYYMM", NORMAL);                  // [조회용]부과년월(FROM)
    initEmEdit(EM_S_CAL_EYM,                            "YYYYMM", NORMAL);                  // [조회용]부과년월(TO)
    initEmEdit(EM_S_VEN_CD,                             "NUMBER3^6^0", NORMAL);             // [조회용]협력사
    initEmEdit(EM_S_VEN_NM,                             "GEN",    READ);                    // [조회용]협력사명
    initComboStyle(LC_S_RENT_TYPE,DS_RENT_TYPE,         "CODE^0^30,NAME^0^100", 1, NORMAL); // [조회용]임대형태
    DS_RENT_TYPE.Filter();                                                                  // [조회용]임대형태 필터링
    DS_RENT_TYPE.SortExpr = "+" + "CODE";
    DS_RENT_TYPE.Sort();
    
    //콤보 초기화
    getFlc("DS_STR_CD",                                 "M", "1", "Y", "N");                // [조회용]시설구분  
    getEtcCode("DS_RENT_TYPE",                          "D", "P003", "Y");                  // [조회용]임대형태  
    LC_S_STR_CD.Focus();
    EM_S_CAL_SYM.Text = getTodayFormat("YYYYMM");
    EM_S_CAL_EYM.Text = getTodayFormat("YYYYMM");
    
    //등록 비활성화
    
    //종료시 데이터 변경 체크 (common.js )
    registerUsingDataset("mren304","DS_O_MASTER" );
    
    LC_S_STR_CD.Index = 0;
}

/**
 * gridCreate("대상그리드")
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.26
 * 개    요 : 그리드SET
 * return값 : void
 */
function gridCreate() {
    var hdrProperies = ''
        + '<FC>ID={CURROW}          NAME=NO         	    WIDTH=30    ALIGN=CENTER</FC>'
        + '<FC>ID=CAL_YM            NAME=부과년월			WIDTH=70    ALIGN=CENTER MASK="XXXX/XX" SUMTEXT="합계"</FC>'
        + '<FC>ID=VEN_CD            NAME=협력사코드		    WIDTH=70    ALIGN=CENTER</FC>'
        + '<FC>ID=VEN_NM            NAME=협력사명			WIDTH=190   ALIGN=LEFT</FC>'
        + '<FC>ID=CAL_TYPE          NAME=정산구분			WIDTH=90    ALIGN=LEFT</FC>'
        + '<FC>ID=RENT_TYPE         NAME=임대형태			WIDTH=100   ALIGN=LEFT  EDITSTYLE=LOOKUP   DATA="DS_RENT_TYPE:CODE:NAME"</FC>'
        + '<FC>ID=RENT_NOVAT_AMT    NAME=임대료(VAT제외)	WIDTH=100   ALIGN=RIGHT show=false   SUMTEXT=@SUM</FC>'
        + '<FC>ID=RENT_VAT_AMT      NAME=임대료VAT		    WIDTH=100   ALIGN=RIGHT show=false   SUMTEXT=@SUM</FC>'
        + '<FC>ID=RENT_AMT          NAME=임대료(VAT포함)	WIDTH=100   ALIGN=RIGHT show=false   SUMTEXT=@SUM</FC>'
        + '<FC>ID=TAX_NOVAT_AMT     NAME=과세액(VAT제외)	WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM</FC>'
        + '<FC>ID=TAX_VAT_AMT       NAME=과세액VAT		    WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM</FC>'
        + '<FC>ID=TAX_AMT           NAME=과세관리비		    WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM</FC>'
        + '<FC>ID=NTAX_AMT          NAME=면세관리비		    WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM</FC>'
        + '<FC>ID=CHRG_AMT          NAME=관리비부과액		WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM</FC>'
        + '<FC>ID=BAL_AMT           NAME=미수관리비		    WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM</FC>'
        + '<FC>ID=ARREAR_AMT        NAME=미수연체이자		WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM</FC>'
        + '<FC>ID=TOT_BAL_AMT       NAME=미수합계			WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM</FC>'
        + '<FC>ID=MOD_AMT           NAME=조정금액			WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM</FC>'
        + '<FC>ID=REAL_CHAREG_AMT   NAME=실청구액			WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM</FC>'
        ;
        initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
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
 * 작 성 일 : 2010.05.26
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if (DS_O_MASTER.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
            if (!checkValidateSearch()) return;
            
            // parameters
            var strStrCd    = LC_S_STR_CD.BindColVal;       // 시설구분
            var strCalSYM   = EM_S_CAL_SYM.Text;            // 부과년월
            var strCalEYM   = EM_S_CAL_EYM.Text;            // 부과년월
            var strRentType = LC_S_RENT_TYPE.BindColVal;    // 임대형태
            var strVenCd    = EM_S_VEN_CD.Text;             // 계약ID
            var goTo = "getMaster";
            var parameters = ""
                + "&strStrCd="      + encodeURIComponent(strStrCd)
                + "&strCalSYM="     + encodeURIComponent(strCalSYM)
                + "&strCalEYM="     + encodeURIComponent(strCalEYM)
                + "&strRentType="   + encodeURIComponent(strRentType)
                + "&strVenCd="      + encodeURIComponent(strVenCd);
            TR_MAIN.Action = "/mss/mren304.mr?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
            TR_MAIN.Post();
            
            // 조회결과 Return
            setPorcCount("SELECT", DS_O_MASTER.RealCount(1,DS_O_MASTER.CountRow) );
            GD_MASTER.Focus();
        } else {
            return;
        }
    }  else {
        if (!checkValidateSearch()) return;
        
        // parameters
        var strStrCd    = LC_S_STR_CD.BindColVal;       // 시설구분
        var strCalSYM   = EM_S_CAL_SYM.Text;            // 부과년월
        var strCalEYM   = EM_S_CAL_EYM.Text;            // 부과년월
        var strRentType = LC_S_RENT_TYPE.BindColVal;    // 임대형태
        var strVenCd    = EM_S_VEN_CD.Text;             // 계약ID
        var goTo = "getMaster";
        var parameters = ""
            + "&strStrCd="      + encodeURIComponent(strStrCd)
            + "&strCalSYM="     + encodeURIComponent(strCalSYM)
            + "&strCalEYM="     + encodeURIComponent(strCalEYM)
            + "&strRentType="   + encodeURIComponent(strRentType)
            + "&strVenCd="      + encodeURIComponent(strVenCd);
        TR_MAIN.Action = "/mss/mren304.mr?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
        TR_MAIN.Post();
        
        // 조회결과 Return
        setPorcCount("SELECT", DS_O_MASTER.RealCount(1,DS_O_MASTER.CountRow) );
        GD_MASTER.Focus();
    }
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.26
 * 개    요 : 초기화
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.26
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.26
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.26
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    if (DS_O_MASTER.CountRow > 0) {
        var ExcelTitle = "관리비정산조회"   
        
        var excel_strcd = LC_S_STR_CD.BindColVal;   // [조회용]시설구분
        var excel_sGoal = EM_S_CAL_SYM.Text;        // [조회용]부가년월FROM
        var excel_eGoal = EM_S_CAL_EYM.Text;        // [조회용]부가년월TO
        var excel_venCd = EM_S_VEN_NM.Text;         // [조회용]협력사명
        var excel_rentTp= LC_S_RENT_TYPE.BindColVal;// [조회용]임대형태
        
        var parameters = "시설구분="    +excel_strcd
                       + " - 부과년월(From~To)=" +excel_sGoal + "~" + excel_eGoal
                       + " - 협력사="  +excel_venCd
                       + " - 임대형태=" +excel_rentTp;
        
        //openExcel2(GD_MASTER, ExcelTitle, parameters, true );
        openExcel5(GD_MASTER, ExcelTitle, parameters, true , "",g_strPid );

        GD_MASTER.Focus();
    } else {
        showMessage(INFORMATION, OK, "USER-1000", "조회 후 가능합니다.");
    }
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.26
 * 개    요 : 출력
 * return값 : void
 */
function btn_Print() {
}


/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * callPopup()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.02
 * 개    요 : 팝업 호출
 * return값 :
 */
function callPopup(popupNm) {
    if (popupNm == "sVen") { //[조회용]협력사
        if (LC_S_STR_CD.BindColVal == ""
            || LC_S_STR_CD.BindColVal == "%") {//시설구분 미선택시
            showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
            LC_S_STR_CD.Focus();
              return;
        }

        var strOrgFlag = "2";
        var strBizType = "";
        /*
        if (LC_S_STR_CD.ValueOfIndex("FCL_FLAG", LC_S_STR_CD.Index) == "1") {
            // 백화점일경우 매입매춝구분:매출, 거래형태:임대을 ,임대갑
            strOrgFlag = "2";
            strBizType = "";
        } else {
            // 그 외            매입매춝구분:매출, 거래형태:임대갑
            strOrgFlag = "2";
            strBizType = "4";
        }
        */
        
        venPop(EM_S_VEN_CD, EM_S_VEN_NM, LC_S_STR_CD.BindColVal,"", "", strBizType, strOrgFlag, "", "T");
    } else if (popupNm == "cYM") {
        //openCal('M',EM_CAL_YM);
    }
}

/**
 * checkValidateSearch()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.26
 * 개    요 : 값체크(조회시)
 * return값 :
 */
function checkValidateSearch() {
    // 시설구분
    if (LC_S_STR_CD.BindColVal == "" ) {
        showMessage(INFORMATION, OK, "USER-1002", "관리비구분");
        LC_S_STR_CD.Focus();
        return false;
    } 
    
    //부과년월 조회조건 체크
    if (EM_S_CAL_SYM.Text.replace(/^\s*|\s*$/g, "").length != EM_S_CAL_EYM.Text.replace(/^\s*|\s*$/g, "").length) {
        showMessage(INFORMATION, OK, "USER-1000", "부과년월(FROM~TO)조건을 정확히 입력하세요.");
        EM_S_CAL_EYM.Focus();
        return false;
    }
    
    //부과년월 조회조건 체크2
    if (EM_S_CAL_SYM.Text > EM_S_CAL_EYM.Text) {
        showMessage(INFORMATION, OK, "USER-1000", "부과년월(TO)은 부과년월(FROM) 이후로 입력하세요");
        EM_S_CAL_EYM.Focus();
        return false;
    }

    return true;
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return; 
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>

<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
//[조회용]시설구분 변경시
LC_S_RENT_TYPE.Index = 0;
</script>

<script language=JavaScript for=EM_S_VEN_CD event=OnKillFocus()>
//[조회용]협력사 코드 자동완성 및 팝업호출
    if(!this.Modified)
        return;
        
    if(this.text==''){
        EM_S_VEN_NM.Text = "";
        return;
    }
    
    if (LC_S_STR_CD.BindColVal == "") {//점 미선택시
        showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
        LC_S_STR_CD.Focus();
        return;
    }
    
    var strOrgFlag = "2";
    var strBizType = "";
    /*
    if (LC_S_STR_CD.ValueOfIndex("FCL_FLAG", LC_S_STR_CD.Index) == "1") {
        // 백화점일경우 매입매춝구분:매출, 거래형태:임대을 ,임대갑
        strOrgFlag = "2";
        strBizType = "";
    } else {
        // 그 외            매입매춝구분:매출, 거래형태:임대갑
        strOrgFlag = "2";
        strBizType = "4";
    }
    */
    
    //단일건 체크 
    setVenNmWithoutPop("DS_O_RESULT", EM_S_VEN_CD, EM_S_VEN_NM , 1, LC_S_STR_CD.BindColVal, "", "", strBizType, strOrgFlag, "", "T");
</script>

<script language=JavaScript for=DS_RENT_TYPE event=OnFilter(row)>
// [조회용]임대형태
if (DS_RENT_TYPE.NameValue(row,"CODE") == "%" 
        || DS_RENT_TYPE.NameValue(row,"CODE") == "3" 
        || DS_RENT_TYPE.NameValue(row,"CODE") == "4"
        || DS_RENT_TYPE.NameValue(row,"CODE") == "5"
        ) { //임대갑, 임대을만
    return true;
} else { 
    return false;
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
<comment id="_NSID_"><object id="DS_O_MASTER"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CLOSE_YN"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<!-- ===============- ONLOAD용 -->
<comment id="_NSID_"><object id="DS_STR_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_RENT_TYPE"      classid=<%=Util.CLSID_DATASET%>><param name=UseFilter value=true></object></comment><script>_ws_(_NSID_);</script>
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

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                     *-->
<!--*************************************************************************-->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
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
                        <th width="70" class="point">시설구분</th>
                        <td width="115"><comment id="_NSID_"><object
                            id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="110"
                            tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
                        <th width="70">부과년월</th>
                        <td width="180"><comment id="_NSID_"><object id=EM_S_CAL_SYM
                            classid=<%=Util.CLSID_EMEDIT%> width="60" tabindex=1
                            onblur="javascript:checkDateTypeYM(this);" align="absmiddle">
                        </object></comment><script>_ws_(_NSID_);</script><img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('M',EM_S_CAL_SYM);" /> ~ <comment id="_NSID_"><object id=EM_S_CAL_EYM
                            classid=<%=Util.CLSID_EMEDIT%> width="60" tabindex=1
                            onblur="javascript:checkDateTypeYM(this);" align="absmiddle">
                        </object></comment><script>_ws_(_NSID_);</script><img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('M',EM_S_CAL_EYM);" /></td>
                        <th width="70">협력사</th>
						<td><comment id="_NSID_"> <object id=EM_S_VEN_CD
							classid=<%=Util.CLSID_EMEDIT%> width="60" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:callPopup('sVen');" align="absmiddle" /> <comment
							id="_NSID_"><object id=EM_S_VEN_NM
							classid=<%=Util.CLSID_EMEDIT%> width="150" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
                    <tr>
                        <th>임대형태</th>
                        <td colspan="5"><comment id="_NSID_"> <object id=LC_S_RENT_TYPE
                            classid=<%=Util.CLSID_LUXECOMBO%> width=110 tabindex=1
                            align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script></td>

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
        <td class="PT05">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"><object id=GD_MASTER
                    width="100%" height=760 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID"       value="DS_O_MASTER">
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
