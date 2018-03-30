<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > CES Billing >메인계량기정산고지서출력
 * 작 성 일 : 2010.06.16
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : MREN606.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 메인계량기정산고지서 조회/출력
 * 이    력 : 2010.06.16 (김유완) 신규작성
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
 * 작 성 일 : 2010.05.26
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit() {
    // 입력 Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MGAUGUSED_MONTH"/>');

    // EMedit에 초기화
    initComboStyle(LC_S_STR_CD,DS_STR_CD,               "CODE^0^30,NAME^0^100", 1, PK);         // [조회용]시설구분
    initComboStyle(LC_S_GAUG_TYPE,DS_S_GAUG_TYPE,       "CODE^0^30,NAME^0^80", 1, NORMAL);      // [조회용]계량기구분(조회)
    initEmEdit(EM_S_CAL_YM,                             "YYYYMM", PK);                          // [조회용]부과년월
    
    //콤보 초기화
    getFlc("DS_STR_CD",                                 "M", "2", "Y", "N");                    // [조회용]시설구분  
    getEtcCode("DS_S_GAUG_TYPE",                        "D", "M039", "Y", "N", LC_S_GAUG_TYPE); // [조회용]계량기구분 
    LC_S_STR_CD.Focus();
    EM_S_CAL_YM.Text = getTodayFormat("YYYYMM");
    
    //등록 비활성화
    
    //종료시 데이터 변경 체크 (common.js )
    registerUsingDataset("mren606","DS_O_MASTER" );
    
    LC_S_STR_CD.Index = 0;
    DS_S_GAUG_TYPE.Filter();     //[계산방식]데이터 필터
    
    //그리드 초기화
    gridCreate();
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
        + '<FC>ID={CURROW}          NAME=NO'         
        + '                                         WIDTH=30    ALIGN=CENTER</FC>'
        + '<FC>ID=STR_CD            NAME=시설구분'        
        + '                                         WIDTH=130   ALIGN=LEFT  SUMTEXT="합계"    EDITSTYLE=LOOKUP   DATA="DS_STR_CD:CODE:NAME"</FC>'
        + '<FC>ID=MNTN_ITEM_NM      NAME=관리비항목명'        
        + '                                         WIDTH=130   ALIGN=LEFT</FC>'
        + '<FC>ID=CAL_CD            NAME=계량기구분'        
        + '                                         WIDTH=130   ALIGN=LEFT  EDITSTYLE=LOOKUP   DATA="DS_S_GAUG_TYPE:CODE:NAME"</FC>'
        + '<FC>ID=USE_QTY           NAME=사용량'        
        + '                                         WIDTH=120   ALIGN=RIGHT SUMTEXT=@SUM</FC>'
        + '<FC>ID=USE_AMT           NAME=사용금액'        
        + '                                         WIDTH=120   ALIGN=RIGHT SUMTEXT=@SUM</FC>'
        + '<FC>ID=BAS_AMT           NAME=기본요금'        
        + '                                         WIDTH=120   ALIGN=RIGHT SUMTEXT=@SUM</FC>' 
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
	var strStrCd   = LC_S_STR_CD.BindColVal;       // 시설구분
	var strCalYM   = EM_S_CAL_YM.Text;             // 정산년월FROM
	var strGaugType= LC_S_GAUG_TYPE.BindColVal;    // 계량기구분
	
	if(strStrCd == "") { 
	    showMessage(INFORMATION, OK, "USER-1002", "시설구분"); 
	    LC_S_STR_CD.Focus();
	    return;
	}
	
	if(strCalYM == "") { 
	    showMessage(INFORMATION, OK, "USER-1003", "정산년월"); 
	    EM_S_CAL_YM.Text = getTodayFormat("YYYYMM");
	    EM_S_CAL_YM.Focus();
	    return;
	}
	
	var goTo = "getMaster";
	var parameters = ""
	    + "&strStrCd="      + encodeURIComponent(strStrCd)
	    + "&strCalYM="      + encodeURIComponent(strCalYM)
	    + "&strGaugType="   + encodeURIComponent(strGaugType);
	TR_MAIN.Action = "/mss/mren606.mr?goTo=" + goTo + parameters;
	TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
	TR_MAIN.Post();
	
	// 조회결과 Return
	setPorcCount("SELECT", DS_O_MASTER.RealCount(1,DS_O_MASTER.CountRow) );
	GD_MASTER.Focus(); 
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
        var ExcelTitle = "메인계량기정산고지서출력"   
        
        var excel_strcd = LC_S_STR_CD.Text;           // [조회용]시설구분
        var excel_sGoal = EM_S_CAL_YM.Text;           // [조회용]부가년월FROM
        var excel_gaug = LC_S_GAUG_TYPE.Text;         // [조회용]계량기구분 
        
        var parameters = "시설구분="        +excel_strcd
                       + " - 정산년월="     +excel_sGoal
                       + " - 계량기구분="    +excel_gaug ;
        
        openExcel2(GD_MASTER, ExcelTitle, parameters, true );
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
    if (EM_S_CAL_YM.Text.replace(/^\s*|\s*$/g, "").length != 6) {
        showMessage(INFORMATION, OK, "USER-1000", "부과년월을 입력하세요.");
        EM_S_CAL_YM.Focus();
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
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>6
    //그리드 정렬기능
    if( row < 1) sortColId( eval(this.DataID), row , colid ); 
</script>
  
<script language=JavaScript for=DS_S_GAUG_TYPE event=OnFilter(row)>
//계량기 타입을 관리비 항목에 맞게 FILTER
if (DS_S_GAUG_TYPE.NameValue(row,"CODE") == "10"        // 전기
        || DS_S_GAUG_TYPE.NameValue(row,"CODE") == "20" // 온수
        || DS_S_GAUG_TYPE.NameValue(row,"CODE") == "30" // 증기
        || DS_S_GAUG_TYPE.NameValue(row,"CODE") == "40" // 냉수
        || DS_S_GAUG_TYPE.NameValue(row,"CODE") == "60" // 수도
    ) 
{
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
<comment id="_NSID_"><object id="DS_S_GAUG_TYPE"    classid=<%=Util.CLSID_DATASET%>><param name=UseFilter value=true></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STR_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
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
                        <th width="80" class="point">시설구분</th>
                        <td width="141"><comment id="_NSID_"><object
                            id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="140"
                            tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
                        <th width="80"  class="point">정산년월</th>
                        <td width="131"><comment id="_NSID_"><object id=EM_S_CAL_YM
                            classid=<%=Util.CLSID_EMEDIT%> width="100" tabindex=1
                            onblur="javascript:checkDateTypeYM(this);" align="absmiddle">
                        </object></comment><script>_ws_(_NSID_);</script><img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('M',EM_S_CAL_YM);" /></td>
                        <th>계량기구분</th>
                        <td><comment id="_NSID_"> <object
                            id=LC_S_GAUG_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width="160"
                            tabindex=1 height=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
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
    <tr>
        <td class="PT05">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"><object id=GD_MASTER
                    width="100%" height=500 classid=<%=Util.CLSID_GRID%>>
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
