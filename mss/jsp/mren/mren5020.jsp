<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 계약해지관리 > 계약해지정산
 * 작 성 일 : 2010.01.14
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : MREN5020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 월관리비를 등록한다
 * 이    력 : 2010.01.14(박래형) 신규작성
           2010.05.23(김유완) 수정작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
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
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var g_saveFlag      = false;
var g_currKey       = "S";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
     
    // 입력 Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_CALMST"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_MR_CALITEM"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER,DS_IO_DETAIL");
    
    gridCreate("MST"); //마스터
    gridCreate("DTL"); //관리비항목별 내역
    
    // Object 초기화
    initComboStyle(LC_S_STR_CD,DS_STR_CD,       "CODE^0^30,NAME^0^100", 1, PK);     // [조회용]시설구분
    initEmEdit(EM_S_VEN_CD,                     "NUMBER3^6^0", NORMAL);             // [조회용]협력사
    initEmEdit(EM_S_VEN_NM,                     "GEN",    READ);                    // [조회용]협력사명
    initComboStyle(LC_S_REAS,DS_REAS,           "CODE^0^30,NAME^0^100", 1, NORMAL); // [조회용]해지사유
    initEmEdit(EM_S_DT,                         "SYYYYMMDD", NORMAL);               // [조회용]해지기간(F)
    initEmEdit(EM_E_DT,                         "EYYYYMMDD", NORMAL);               // [조회용]해지기간(T)
    
    
    initEmEdit(EM_VEN_CD,                       "NUMBER3^6^0", READ);               // 협력사
    initEmEdit(EM_VEN_NM,                       "GEN",    READ);                    // 협력사명
    initEmEdit(EM_REP_NAME,                     "GEN",    READ);                    // 대표자
    initEmEdit(EM_COMP_NO,                      "GEN",    READ);                    // 사업자등록번호
    initComboStyle(LC_RENT_TYPE,DS_RENT_TYPE,   "CODE^0^30,NAME^0^100", 1, READ);   // 임대형태
    initComboStyle(LC_RENT_FLAG,DS_RENT_FLAG,   "CODE^0^30,NAME^0^100", 1, READ);   // 임대구분
    initComboStyle(LC_CNTR_TYPE,DS_CNTR_TYPE,   "CODE^0^30,NAME^0^100", 1, READ);   // 계약유형
    initEmEdit(EM_RENT_DEPOSIT,                 "NUMBER^12^0",  READ);              // 임대보증금
    
    initEmEdit(EM_CNTR_CAN_DT,                  "YYYYMMDD",     READ);              // 해지일
    initComboStyle(LC_CNTR_CAN_REAS_CD,DS_REAS, "CODE^0^30,NAME^0^100", 1, READ);   // 해지사유

    initEmEdit(EM_ADD_DED_AMT,                  "NUMBER^12^0",  READ);              // 추가공제액
    initEmEdit(EM_ADD_DED_REASON,               "GEN^200",      READ);              // 추가공제사유
    
    initEmEdit(EM_CAL_YMD,                      "YYYYMMDD",     READ);              // [S]정산일
    initEmEdit(EM_RENT_DEPOSIT_S,               "NUMBER^12^0",  READ);              // [S]임대보증금
    initEmEdit(EM_ADD_DED_AMT_S,                "NUMBER^12^0",  READ);              // [S]추가공제액
    initEmEdit(EM_BAL_AMT,                      "NUMBER^12^0",  READ);              // [S]미수관리비
    initEmEdit(EM_ARREAR_AMT,                   "NUMBER^12^0",  READ);              // [S]연체이자
    initEmEdit(EM_TAX_AMT,                      "NUMBER^12^0",  READ);              // [S]과세관리비
    initEmEdit(EM_TAX_VAT_AMT,                  "NUMBER^12^0",  READ);              // [S]과세VAT
    initEmEdit(EM_NTAX_AMT,                     "NUMBER^12^0",  READ);              // [S]면세관리비
    initEmEdit(EM_RTRN_AMT,                     "NUMBER^12^0",  READ);              // [S]반환보증금
    
    getFlc("DS_STR_CD",                         "M", "1", "Y", "N");                // 시설구분  
    getEtcCode("DS_RENT_TYPE",                  "D", "P003", "N");                  // 임대형태      
    getEtcCode("DS_RENT_FLAG",                  "D", "P084", "N");                  // 임대구분      
    getEtcCode("DS_REAS",                       "D", "M043", "Y", "N", LC_S_REAS);  // 해지사유      
    getEtcCode("DS_CNTR_TYPE",                  "D", "M042", "N");                  // 계약유형  
    
    LC_S_STR_CD.index = 0;                   
    LC_S_STR_CD.Focus();   
    enableControl(IMG_CLOSE_FEE,false);
}


/**
 * gridCreate("대상그리드")
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 그리드SET
 * return값 : void
 */
function gridCreate(grdGBN) {
    if (grdGBN == "MST") {
        
        var hdrProperies = ''
            + '<FC>ID={CURROW}      NAME=NO'         
            + '                                     WIDTH=30    ALIGN=CENTER</FC>'
            + '<FC>ID=VEN_CD        NAME=협력사코드'            
            + '                                     WIDTH=80    ALIGN=CENTER</FC>'
            + '<FC>ID=VEN_NM        NAME=협력사명'        
            + '                                     WIDTH=130   ALIGN=LEFT</FC>'
            ;
            initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
    } else {
        
        var hdrProperies = ''
            + '<FC>ID={CURROW}      NAME=NO'         
            + '                                     WIDTH=30    ALIGN=CENTER</FC>'
            + '<FC>ID=MNTN_ITEM_NM  NAME=관리항목'            
            + '                                     WIDTH=70    ALIGN=LEFT  EDIT=NONE SUMTEXT="합계"</FC>'
            + '<FC>ID=USE_QTY       NAME=사용량'        
            + '                                     WIDTH=60    ALIGN=RIGHT EDIT=NONE SUMTEXT=@SUM</FC>'
            + '<FC>ID=USE_AMT       NAME=금액'        
            + '                                     WIDTH=100   ALIGN=RIGHT EDIT=NUMERIC SUMTEXT=@SUM</FC>'
            ;
            initGridStyle(GD_DETAIL, "COMMON", hdrProperies, true);
            GD_DETAIL.ViewSummary = "1";

    }
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
 * 작 성 일 : 2010.05.23
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if (DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
        	if (!checkValidateSearch()) return;
        	
            // parameters
            var strStrCd    = LC_S_STR_CD.BindColVal;   // [조회용]시설구분(점코드)
            var strVenCd    = EM_S_VEN_CD.Text;         // [조회용]협력사
            var strReas     = LC_S_REAS.BindColVal;     // [조회용]해지사유
            var strSDt      = EM_S_DT.Text;             // [조회용]해지기간(F)
            var strEDt      = EM_E_DT.Text;             // [조회용]해지기간(T)
            
            var goTo = "getMaster";
            var parameters = ""
                + "&strStrCd="  + encodeURIComponent(strStrCd)
                + "&strVenCd="  + encodeURIComponent(strVenCd)
                + "&strReas="   + encodeURIComponent(strReas)
                + "&strSDt="    + encodeURIComponent(strSDt)
                + "&strEDt="    + encodeURIComponent(strEDt);
            
            TR_MAIN.Action = "/mss/mren502.mr?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
            TR_MAIN.Post();
            // 조회결과 Return
            setPorcCount("SELECT", GD_MASTER);
        } else {
            return;
        }
    }  else {
    	if (!checkValidateSearch()) return;
    	
        // parameters
        var strStrCd    = LC_S_STR_CD.BindColVal;   // [조회용]시설구분(점코드)
        var strVenCd    = EM_S_VEN_CD.Text;         // [조회용]협력사
        var strReas     = LC_S_REAS.BindColVal;     // [조회용]해지사유
        var strSDt      = EM_S_DT.Text;             // [조회용]해지기간(F)
        var strEDt      = EM_E_DT.Text;             // [조회용]해지기간(T)
        
        var goTo = "getMaster";
        var parameters = ""
            + "&strStrCd="  + encodeURIComponent(strStrCd)
            + "&strVenCd="  + encodeURIComponent(strVenCd)
            + "&strReas="   + encodeURIComponent(strReas)
            + "&strSDt="    + encodeURIComponent(strSDt)
            + "&strEDt="    + encodeURIComponent(strEDt);
            
        TR_MAIN.Action = "/mss/mren502.mr?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();
        // 조회결과 Return
        setPorcCount("SELECT", GD_MASTER);
    }
    
    if (DS_IO_MASTER.CountRow < 1) {
        DS_IO_DETAIL.ClearData();
    } else {
        if (arguments[0] == undefined || arguments[0] == "S") {
            g_currKey = "S";
        } else {
            var strCurrKeyRow = getNameValueRow(DS_IO_MASTER, "VEN_CD",g_currKey);
            if (strCurrKeyRow == 0 ) {
                DS_IO_MASTER.RowPosition = 1;
            } else {
                DS_IO_MASTER.RowPosition = strCurrKeyRow;
            }
        }
    }
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.23
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.23
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (DS_IO_DETAIL.IsUpdated) {//변경 데이터가 있을때만 저장
        //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_MASTER.Focus();
            return;
        }
        
        g_currKey = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");
        
        var goTo = "save";
        TR_SAVE.Action = "/mss/mren502.mr?goTo=" + goTo;
        TR_SAVE.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)";
        //저장 시  CanRowPosChange 이벤트 우회 flag
        g_saveFlag = true; 
        TR_SAVE.Post();
        g_saveFlag = false;
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
    } 
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.23
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.23
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010.05.23
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * callPopup()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.23
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
    }
}

 /**
 * procCalculate()
 * 작 성 자 : 
 * 작 성 일 : 2010.05.23
 * 개    요 : 관리비정산
 * return값 : void
 */
function procCalculate() {
    var strIStrCd   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition , "STR_CD");  // 시설구분(점코드)
    var strICntrId  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition , "CNTR_ID"); // 계약ID
    var strVenCd    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition , "VEN_NM");  // 협력사명
     
    //관리비정산
    if( showMessage(INFORMATION, YESNO, "USER-1000", "이미 등록된 정보는 삭제되고 재생성됩니다. ("+strVenCd+")의 계약해지정산을 실행하시겠습니까?") != 1 ) return;
    
    var currRow = DS_IO_MASTER.RowPosition;
    
    var goTo = "procCalculate";
    // parameters
    var strStrCd    = LC_S_STR_CD.BindColVal;   // [조회용]시설구분(점코드)
    var strVenCd    = EM_S_VEN_CD.Text;         // [조회용]협력사
    var strReas     = LC_S_REAS.BindColVal;     // [조회용]해지사유
    var strSDt      = EM_S_DT.Text;             // [조회용]해지기간(F)
    var strEDt      = EM_E_DT.Text;             // [조회용]해지기간(T)
    var parameters = ""
        + "&strIStrCd=" + encodeURIComponent(strIStrCd)
        + "&strICntrId="+ encodeURIComponent(strICntrId)
        + "&strStrCd="  + encodeURIComponent(strStrCd)
        + "&strVenCd="  + encodeURIComponent(strVenCd)
        + "&strReas="   + encodeURIComponent(strReas)
        + "&strSDt="    + encodeURIComponent(strSDt)
        + "&strEDt="    + encodeURIComponent(strEDt);
    
    TR_CAL.Action = "/mss/mren502.mr?goTo=" + goTo + parameters;
    TR_CAL.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
    TR_CAL.Post();
    
    setPorcCount("SELECT", GD_MASTER);
    DS_IO_MASTER.RowPosition = currRow;
}

/**
 * getDetail()
 * 작 성 자 : 
 * 작 성 일 : 2010.05.23
 * 개    요 : 관리비항목별 내역 조회(상세)
 * return값 : void
 */
function getDetail(row) {
    var strStrCd    = DS_IO_MASTER.NameValue(row, "STR_CD");     // 시설구분(점코드)
    var strCalYM    = DS_IO_MASTER.NameValue(row, "CAL_YM");     // 부과년월
    var strCntrId   = DS_IO_MASTER.NameValue(row, "CNTR_ID");    // 계약ID
    
    var goTo = "getDetail";
    var parameters = ""
        + "&strStrCd="      + encodeURIComponent(strStrCd)
        + "&strCalYM="      + encodeURIComponent(strCalYM)
        + "&strCntrId="     + encodeURIComponent(strCntrId);
    TR_MAIN2.Action = "/mss/mren502.mr?goTo=" + goTo + parameters;
    TR_MAIN2.KeyValue = "SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)";
    TR_MAIN2.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", GD_DETAIL);
}

/**
 * checkValidateSearch()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.23
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
    
    //해지기간 조회조건 체크
    if (EM_S_DT.Text.replace(/^\s*|\s*$/g, "").length != EM_E_DT.Text.replace(/^\s*|\s*$/g, "").length) {
        showMessage(INFORMATION, OK, "USER-1000", "해지기간(FROM~TO)조건을 정확히 입력하세요.");
    	EM_E_DT.Focus();
        return false;
    }
    
    //해지기간 조회조건 체크2
    if (EM_S_DT.Text > EM_E_DT.Text) {
        showMessage(INFORMATION, OK, "USER-1000", "해지기간(TO)은 해지기간(FROM) 이후로 입력하세요");
        EM_E_DT.Focus();
        return false;
    }

    return true;
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
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_MAIN2 event=onSuccess>
    for(i=0;i<TR_MAIN2.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN2.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
    }
    //저장 후 재조회
    btn_Search(g_currKey);
</script>

<script language=JavaScript for=TR_CAL event=onSuccess>
    for(i=0;i<TR_CAL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_CAL.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN2 event=onFail>
trFailed(TR_MAIN2.ErrorMsg);
</script>

<script language=JavaScript for=TR_SAVE event=onFail>
trFailed(TR_SAVE.ErrorMsg);
</script>

<script language=JavaScript for=TR_CAL event=onFail>
trFailed(TR_CAL.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
if (row > 0) {
	if (DS_IO_MASTER.NameValue(row, "CLOSE_YN") == "T") { //정산,청구생성처리 완료
		enableControl(IMG_CLOSE_FEE,false);
        GD_DETAIL.ColumnProp('USE_AMT', 'Edit')  = "None";   //금액
	} else {
		enableControl(IMG_CLOSE_FEE,true);
        GD_DETAIL.ColumnProp('USE_AMT', 'Edit')  = "NUMERIC";   //금액
	}
	
    getDetail(row);
} else {
	enableControl(IMG_CLOSE_FEE,false);
	GD_DETAIL.ColumnProp('USE_AMT', 'Edit')  = "None";   //금액
}
</script>

<script language=JavaScript for=DS_IO_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return;
</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
if (!g_saveFlag) {
    if (DS_IO_MASTER.CountRow > 0) {
        if (DS_IO_MASTER.RowStatus(row) == 3) { //데이터 변경시
            var ret = showMessage(Question, YesNo, "USER-1049");
            if (ret == "1") {
                rollBackRowData(DS_IO_MASTER, row);
                return true;    
            } else {
                return false;   
            }
        }
        return true;
    }
    return true;
}
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
//그리드 정렬기능
    if( row < 1) sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
//그리드 정렬기능
    if( row < 1) sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=GD_DETAIL event=OnExit(row,colid,olddata)>
//계약해지정산내역 변경시
if (colid == "USE_AMT" && DS_IO_DETAIL.RowStatus(row) == 3) {
	var taxGbn     = DS_IO_DETAIL.NameValue(row, "TAX_INV_FLAG");
	var tempAmt    = 0;
    for (var i=1; i<=DS_IO_DETAIL.CountRow; i++) {
    	if (taxGbn == DS_IO_DETAIL.NameValue(i, "TAX_INV_FLAG")) {
    		tempAmt = eval(tempAmt) + DS_IO_DETAIL.NameValue(i, "USE_AMT");
    	}
    }
    
    //면과세 처리
    if (taxGbn == "1") {//과세
    	EM_TAX_AMT.Text = Math.round((tempAmt/1.1)); //과세관리비
    	EM_TAX_VAT_AMT.Text = eval(tempAmt) -  Math.round((tempAmt/1.1)); //과세관리비VAT
    } else {
    	EM_NTAX_AMT.Text = tempAmt;
    }
    
    EM_RTRN_AMT.Text = eval(EM_RENT_DEPOSIT_S.Text) - (eval(EM_ADD_DED_AMT_S.Text)+eval(EM_BAL_AMT.Text)+eval(EM_ARREAR_AMT.Text)+eval(EM_TAX_AMT.Text)+eval(EM_TAX_VAT_AMT.Text)+eval(EM_NTAX_AMT.Text));
}
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
<!-- 시설구분 OnSelChange() -->
<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
    EM_S_VEN_CD.Text = "";
    EM_S_VEN_NM.Text = "";
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
<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<!-- =============== ONLOAD용  -->
<comment id="_NSID_"><object id="DS_STR_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_RENT_TYPE"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_RENT_FLAG"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_REAS"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CNTR_TYPE"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_CAL" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝 
<!--*************************************************************************-->


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
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td width=80%>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">시설구분</th>
						<td width="120"><comment id="_NSID_"><object
							id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="120"
							tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
						<th width="80">협력사</th>
						<td width="250"><comment id="_NSID_"> <object
							id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width="70"
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:callPopup('sVen');" align="absmiddle" /> <comment
							id="_NSID_"><object id=EM_S_VEN_NM
							classid=<%=Util.CLSID_EMEDIT%> width="150" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">해지사유</th>
						<td><comment id="_NSID_"><object id=LC_S_REAS
							classid=<%=Util.CLSID_LUXECOMBO%> width="120" tabindex=1
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
                        <th>해지기간</th>
                        <td colspan="5"><comment id="_NSID_"> <object
                            id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
                            align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
                        </object> </comment> <script>_ws_(_NSID_);</script> <img id=IMG_S_DT
                            src="/pot/imgs/btn/date.gif" id="btndate1" align="absmiddle"
                            onclick="javascript:openCal('G',EM_S_DT)" /> ~ <comment
                            id="_NSID_"> <object id=EM_E_DT
                            classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"
                            onblur="javascript:checkDateTypeYMD(this);"> </object> </comment> <script>_ws_(_NSID_);</script>
                        <img id=IMG_E_DT src="/pot/imgs/btn/date.gif" id="btndate1"
                            align="absmiddle" onclick="javascript:openCal('G',EM_E_DT)" /></td>
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
				<td width="260" valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"><OBJECT id=GD_MASTER
							width=100% height=478 tabindex=1 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_IO_MASTER">
						</OBJECT></comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
				<td class="PL05">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="PT10">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
									align="absmiddle" /> 계약해지 정보</td>
				                <td class="right"><img id="IMG_CLOSE_FEE"
				                    src="/<%=dir%>/imgs/btn/close_fee.gif" hspace="2"
				                    onclick="javascript:procCalculate();" /> </td>
                                <td class="right" width="5"> </td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="PT01 PB03">
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="100">협력사</th>
								<td width="152"><comment id="_NSID_"> <object
									id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width="145"
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
								<th width="100">협력사명</th>
								<td><comment id="_NSID_"> <object id=EM_VEN_NM
									classid=<%=Util.CLSID_EMEDIT%> width="160" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>대표자</th>
								<td><comment id="_NSID_"> <object id=EM_REP_NAME
									classid=<%=Util.CLSID_EMEDIT%> width="145" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
								<th>사업자등록번호</th>
								<td><comment id="_NSID_"> <object id=EM_COMP_NO
									classid=<%=Util.CLSID_EMEDIT%> width="160" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>임대형태</th>
								<td><comment id="_NSID_"> <object id=LC_RENT_TYPE
									classid=<%=Util.CLSID_LUXECOMBO%> width="150" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
								<th>임대구분</th>
								<td><comment id="_NSID_"> <object id=LC_RENT_FLAG
									classid=<%=Util.CLSID_LUXECOMBO%> width="165" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>계약유형</th>
								<td><comment id="_NSID_"> <object
									id=LC_CNTR_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width="150"
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
								<th>임대보증금</th>
								<td><comment id="_NSID_"> <object
									id=EM_RENT_DEPOSIT classid=<%=Util.CLSID_EMEDIT%> width="160"
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>해지일</th>
                                <td><comment id="_NSID_"> <object id=EM_CNTR_CAN_DT
                                    classid=<%=Util.CLSID_EMEDIT%> width="145" tabindex=1
                                    align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
								</td>
								<th>해지사유</th>
								<td><comment id="_NSID_"> <object
									id=LC_CNTR_CAN_REAS_CD classid=<%=Util.CLSID_LUXECOMBO%> width="165"
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>추가공제액</th>
                                <td><comment id="_NSID_"> <object id=EM_ADD_DED_AMT
                                    classid=<%=Util.CLSID_EMEDIT%> width="145" tabindex=1
                                    align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
								</td>
								<th>추가공제사유</th>
								<td><comment id="_NSID_"> <object
									id=EM_ADD_DED_REASON classid=<%=Util.CLSID_EMEDIT%> width="160"
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
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
							<tr valign="top">
								<td width="280">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td class="PT10">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td class="sub_title"><img
													src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
													align="absmiddle" /> 계약해지정산 내역</td>
											</tr>
										</table>
										</td>
									</tr>
                                    <tr><td height="3"></td></tr>
									<tr valign="top">
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="BD4A">
											<tr>
												<td><comment id="_NSID_"><OBJECT id=GD_DETAIL
													width=100% height=264 tabindex=1
													classid=<%=Util.CLSID_GRID%>>
													<param name="DataID" value="DS_IO_DETAIL">
												</OBJECT></comment><script>_ws_(_NSID_);</script></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td class="PT10">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td height="15"></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td class="PL03">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="s_table">
											<tr>
												<th width="100">정산일</th>
												<td><comment id="_NSID_"> <object
													id=EM_CAL_YMD classid=<%=Util.CLSID_EMEDIT%> width="150"
													tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
												</td>
											</tr>
											<tr>
												<th>임대보증금</th>
												<td><comment id="_NSID_"> <object
													id=EM_RENT_DEPOSIT_S classid=<%=Util.CLSID_EMEDIT%>
													width="150" tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
												</td>
											</tr>
											<tr>
												<th>추가공제액</th>
												<td><comment id="_NSID_"> <object
													id=EM_ADD_DED_AMT_S classid=<%=Util.CLSID_EMEDIT%> width="150"
													tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
												</td>
											</tr>
											<tr>
												<th>미수관리비</th>
												<td><comment id="_NSID_"> <object
													id=EM_BAL_AMT classid=<%=Util.CLSID_EMEDIT%>
													width="150" tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
												</td>
											</tr>
											<tr>
												<th>연체이자</th>
												<td><comment id="_NSID_"> <object
													id=EM_ARREAR_AMT classid=<%=Util.CLSID_EMEDIT%> width="150"
													tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
												</td>
											</tr>
											<tr>
												<th>과세관리비</th>
												<td><comment id="_NSID_"> <object
													id=EM_TAX_AMT classid=<%=Util.CLSID_EMEDIT%> width="150"
													tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
												</td>
											</tr>
											<tr>
												<th>과세VAT</th>
												<td><comment id="_NSID_"> <object
													id=EM_TAX_VAT_AMT classid=<%=Util.CLSID_EMEDIT%> width="150"
													tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
												</td>
											</tr>
											<tr>
												<th>면세관리비</th>
												<td><comment id="_NSID_"> <object
													id=EM_NTAX_AMT classid=<%=Util.CLSID_EMEDIT%> width="150"
													tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
												</td>
											</tr>
											<tr>
												<th>반환보증금</th>
												<td><comment id="_NSID_"> <object
													id=EM_RTRN_AMT classid=<%=Util.CLSID_EMEDIT%> width="150"
													tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
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
<comment id="_NSID_">
<object id=BD_IO_MASTER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_IO_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
		<c>Col=VEN_CD            Ctrl=EM_VEN_CD              param=Text</c>
		<c>Col=VEN_NM            Ctrl=EM_VEN_NM              param=Text</c>
		<c>Col=REP_NAME          Ctrl=EM_REP_NAME            param=Text</c>
		<c>Col=COMP_NO           Ctrl=EM_COMP_NO             param=Text</c>
		<c>Col=RENT_TYPE         Ctrl=LC_RENT_TYPE           param=BindColVal</c>
		<c>Col=RENT_FLAG         Ctrl=LC_RENT_FLAG           param=BindColVal</c>
		<c>Col=CNTR_TYPE         Ctrl=LC_CNTR_TYPE           param=BindColVal</c>
		<c>Col=RENT_DEPOSIT      Ctrl=EM_RENT_DEPOSIT        param=Text</c>
		<c>Col=CNTR_CAN_DT       Ctrl=EM_CNTR_CAN_DT         param=Text</c>
		<c>Col=CNTR_CAN_REAS_CD  Ctrl=LC_CNTR_CAN_REAS_CD    param=BindColVal</c>
		<c>Col=ADD_DED_AMT       Ctrl=EM_ADD_DED_AMT         param=Text</c>
		<c>Col=ADD_DED_REASON    Ctrl=EM_ADD_DED_REASON      param=Text</c>
		<c>Col=CAL_YMD           Ctrl=EM_CAL_YMD             param=Text</c>
		<c>Col=RENT_DEPOSIT_S    Ctrl=EM_RENT_DEPOSIT_S      param=Text</c>
		<c>Col=ADD_DED_AMT_S     Ctrl=EM_ADD_DED_AMT_S       param=Text</c>
		<c>Col=BAL_AMT           Ctrl=EM_BAL_AMT             param=Text</c>
		<c>Col=ARREAR_AMT        Ctrl=EM_ARREAR_AMT          param=Text</c>
		<c>Col=TAX_AMT           Ctrl=EM_TAX_AMT             param=Text</c>
		<c>Col=TAX_VAT_AMT       Ctrl=EM_TAX_VAT_AMT         param=Text</c>
		<c>Col=NTAX_AMT          Ctrl=EM_NTAX_AMT            param=Text</c>
		<c>Col=RTRN_AMT          Ctrl=EM_RTRN_AMT            param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

