<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 계량기 매핑 관리
 * 작 성 일 : 2010.04.08
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : MREN1090.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 계량기 매핑 관리
 * 이    력 : 2010.04.08 (김유완) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"          prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"       prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"           prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"        prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
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
<!--* B. 스크립트 시작 
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var g_saveFlag = false;
var g_autoFlag = false;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.08
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_MR_GAUGMST"/>');
    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_GAUGMST_DTL"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER,DS_IO_DETAIL");

    //그리드 초기화
    gridCreate("dtl"); //상세
    gridCreate("mst"); //마스터
    
    //콤보 초기화
    initComboStyle(LC_S_FCL_FLAG,DS_S_FCL_FLAG,             "CODE^0^30,NAME^0^80", 1, PK);      // [조회용]시설구분
    initComboStyle(LC_S_GAUG_TYPE,DS_S_GAUG_TYPE,           "CODE^0^30,NAME^0^80", 1, PK);      // [조회용]계량기구분
    initEmEdit(EM_S_GAUG_ID,    "GEN^20",NORMAL);                                               // [조회용]계량기ID 
    initEmEdit(EM_S_INST_PLC,   "GEN^40",READ);                                                 // [조회용]설치장소
    initEmEdit(EM_S_VEN_CD,     "GEN^6",NORMAL);                                                // [조회용]협력업사코드 
    initEmEdit(EM_S_VEN_NAME,   "GEN^40",READ);                                                 // [조회용]협력업사명      
    
    getFlc("DS_S_FCL_FLAG",             "M", "1", "Y", "N");                                    // [조회용]시설구분
    getEtcCode("DS_S_GAUG_TYPE",        "D", "M039", "N", "N", LC_S_GAUG_TYPE);                 // [조회용]계량기구분 
    getEtcCode("DS_GAUG_USE_FLAG",      "D", "M040", "N");                                      // 계량기사용구분 
    getEtcCode("DS_DIV_RULE_TYPE",      "D", "M041", "N");                                      // 계량기사용구분 
    
    LC_S_FCL_FLAG.Focus();
    LC_S_FCL_FLAG.index = "0"; // [조회용]시설구분 ]
    objectControl(false);
}

function gridCreate(strGbn){
	//마스터그리드 
    var hdrProperies ='';
    if (strGbn=='mst') {
    	hdrProperies = ''
            + '<FC>ID={CURROW}         NAME="NO"'
            + '                                            WIDTH=30    ALIGN=CENTER</FC>'
            + '<FC>ID=GAUG_ID          NAME="계량기ID"'
            + '                                            WIDTH=110   ALIGN=CENTER</FC>'
            + '<FC>ID=INST_PLC         NAME="설치장소"'
            + '                                            WIDTH=195   ALIGN=LEFT  </FC>'
            + '<FC>ID=GAUG_USE_FLAG    NAME="계량기사용구분"'
            + '                                            WIDTH=110   ALIGN=LEFT  EDITSTYLE=LOOKUP    DATA="DS_GAUG_USE_FLAG:CODE:NAME"</FC>'
            + '<FC>ID=DIV_RULE_TYPE    NAME="공동안분기준"'
            + '                                            WIDTH=130   ALIGN=LEFT  EDITSTYLE=LOOKUP    DATA="DS_DIV_RULE_TYPE:CODE:NAME"</FC>'
            + '<FC>ID=VALID_S_DT       NAME="유효시작일자"'
            + '                                            WIDTH=100   ALIGN=CENTER MASK="XXXX/XX/XX"</FC>'
            + '<FC>ID=VALID_E_DT       NAME="유효종료일자"'
            + '                                            WIDTH=100   ALIGN=CENTER MASK="XXXX/XX/XX"</FC>' 
            + '<FC>ID=STR_CD           NAME="점코드"'
            + '                                            WIDTH=195   ALIGN=LEFT  SHOW="false"</FC>'
            ;   
        initGridStyle(GD_MASTER, "COMMON", hdrProperies, false); 
    } else {
    	hdrProperies = ''
            + '<FC>ID={CURROW}         NAME="NO"'
            + '                                            WIDTH=30    ALIGN=CENTER</FC>'
            + '<FC>ID=GAUG_ID          NAME="*계량기ID"'
            + '                                            WIDTH=100   ALIGN=CENTER    EDIT=NONE </FC>'
            + '<FC>ID=CNTR_ID          NAME="*계약ID"'
            + '                                            WIDTH=100   ALIGN=CENTER    EDIT=AlphaNum   EDITSTYLE=POPUP</FC>'
            + '<FC>ID=VEN_CD           NAME="협력사"'
            + '                                            WIDTH=60    ALIGN=LEFT      EDIT=NONE    SHOW=FALSE</FC>'
            + '<FC>ID=VEN_NM           NAME="협력사명"'    
            + '                                            WIDTH=195   ALIGN=LEFT      EDIT=NONE    </FC>'
            + '<FC>ID=DIV_RATE         NAME="안분율"'
            + '                                            WIDTH=130   ALIGN=RIGHT     EDIT=NONE</FC>'
            + '<FC>ID=APP_S_DT         NAME="*적용일자"'
            + '                                            WIDTH=110   ALIGN=CENTER    EDIT=Numeric MASK="XXXX/XX/XX"   EDITSTYLE=POPUP</FC>'
            + '<FC>ID=APP_E_DT         NAME="*종료일자"'
            + '                                            WIDTH=110   ALIGN=CENTER    EDIT=Numeric MASK="XXXX/XX/XX"   EDITSTYLE=POPUP</FC>' 
            ;   
        initGridStyle(GD_DETAIL, "COMMON", hdrProperies, true); 
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
 * 작 성 일 : 2010.04.08
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if (DS_IO_MASTER.IsUpdated||DS_IO_DETAIL.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
            // 시설구분 체크
            if (LC_S_FCL_FLAG.BindColVal == "" || LC_S_FCL_FLAG.BindColVal == "%") {//시설구분 미선택시
                showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
                LC_S_FCL_FLAG.Focus();
                return;
            }  
            // 계량기구분  체크
            if (LC_S_GAUG_TYPE.BindColVal == "" || LC_S_GAUG_TYPE.BindColVal == "%") {//계량기구분 미선택시
                showMessage(STOPSIGN, OK, "USER-1003", "계량기구분");
                LC_S_GAUG_TYPE.Focus();
                return;
            }  
            
            // parameters
            var strFlcFlag  = LC_S_FCL_FLAG.BindColVal;     // [조회용]시설구분(점코드)
            var strGaugType = LC_S_GAUG_TYPE.BindColVal;    // [조회용]계량기구분
            var strGaugID   = EM_S_GAUG_ID.Text;            // [조회용]계량기ID
            var strVenCd    = EM_S_VEN_CD.Text;             // [조회용]협력사코드
            var goTo = "getMaster";
            var parameters = ""
                + "&strFlcFlag="    + encodeURIComponent(strFlcFlag)
                + "&strGaugType="   + encodeURIComponent(strGaugType)
                + "&strGaugID="     + encodeURIComponent(strGaugID)
                + "&strVenCd="      + encodeURIComponent(strVenCd);
            TR_MAIN.Action = "/mss/mren109.mr?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
            TR_MAIN.Post();
            
            // 조회결과 Return
            setPorcCount("SELECT", GD_MASTER);
            //if (DS_IO_DETAIL.CountRow < 1) objectControl(false);
        
        } else {
            return;
        }
    }  else {
        // 시설구분 체크
        if (LC_S_FCL_FLAG.BindColVal == "" || LC_S_FCL_FLAG.BindColVal == "%") {//시설구분 미선택시
            showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
            LC_S_FCL_FLAG.Focus();
            return;
        }  
        // 계량기구분  체크
        if (LC_S_GAUG_TYPE.BindColVal == "" || LC_S_GAUG_TYPE.BindColVal == "%") {//계량기구분 미선택시
            showMessage(STOPSIGN, OK, "USER-1003", "계량기구분");
            LC_S_GAUG_TYPE.Focus();
            return;
        }  
        
        // parameters
        var strFlcFlag  = LC_S_FCL_FLAG.BindColVal;     // [조회용]시설구분(점코드)
        var strGaugType = LC_S_GAUG_TYPE.BindColVal;    // [조회용]계량기구분
        var strGaugID   = EM_S_GAUG_ID.Text;            // [조회용]계량기ID
        var strVenCd    = EM_S_VEN_CD.Text;             // [조회용]협력사코드
        var goTo = "getMaster";
        var parameters = ""
            + "&strFlcFlag="    + encodeURIComponent(strFlcFlag)
            + "&strGaugType="   + encodeURIComponent(strGaugType)
            + "&strGaugID="     + encodeURIComponent(strGaugID)
            + "&strVenCd="      + encodeURIComponent(strVenCd);
        TR_MAIN.Action = "/mss/mren109.mr?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();
        // 조회결과 Return
        setPorcCount("SELECT", GD_MASTER);
    }
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.08
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    //저장 시  CanRowPosChange 이벤트 우회 flag
    g_saveFlag = true;
    if (DS_IO_DETAIL.IsUpdated) {//변경 데이터가 있을때만 저장
        //필수 입력값 체크
        if (!checkValidate()) {
            g_saveFlag = false;
            return;
        }
    
        //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_MASTER.Focus();
            return;
        }
        
        //저장
        var goTo = "save";
        TR_SAVE.Action = "/mss/mren109.mr?goTo=" + goTo;
        TR_SAVE.KeyValue = "SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)";
        TR_SAVE.Post();
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
    } 
    
    g_saveFlag = false;
}


/**
 * btn_AddRow()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : 행추가
 * return값 :
 */
function btn_AddRow() {
	//안분율이 100이상일경우
	if (DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "DIV_RATE") > 100) {
	    showMessage(INFORMATION, OK, "USER-1000", "안분율은 100% 이내로 입력해야 합니다.");
	    setTimeout("GD_DETAIL.SetColumn('DIV_RATE')" , 30);
	    return;
	}
	 
    GD_DETAIL.SetColumn("CNTR_ID");
    DS_IO_DETAIL.AddRow(); 
    setTimeout("GD_DETAIL.SetColumn('CNTR_ID')" , 30);
}

/**
 * btn_DeleteRow()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : 행삭제
 * return값 :
 */
function btn_DeleteRow() {
	 DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition); 
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * callPopup()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 팝업 호출
 * return값 :
 */
function callPopup(popupNm) {
    if (popupNm == "gaugId") { // 계량기ID
        var rt = getGaugIdPop(EM_S_GAUG_ID, EM_S_INST_PLC, LC_S_FCL_FLAG.BindColVal, LC_S_GAUG_TYPE.BindColVal,  "S", "F", "");
        if (rt) {
            EM_S_INST_PLC.Text = rt.INST_PLC;
        }
    }
}

/**
 * getDetail()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 계량기별 매핑정보 
 * return값 :
 */
function getDetail() {  
    // parameters
    var strGaugID   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_ID") // 계량기ID
    var goTo = "getDetail";
    var parameters = ""
        + "&strGaugID="     + encodeURIComponent(strGaugID);
    TR_SUB.Action = "/mss/mren109.mr?goTo=" + goTo + parameters;
    TR_SUB.KeyValue = "SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)";
    TR_SUB.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_DETAIL.CountRow);
}


/**
 * checkValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidate() {
    // 필수 입력값 체크
    for (var n=1; n<=DS_IO_DETAIL.CountRow; n++) {
        if (DS_IO_DETAIL.RowStatus(n) != 0 ) {
            // 계약ID
            if (DS_IO_DETAIL.NameValue(n,"CNTR_ID") == "") {
                GD_DETAIL.SetColumn("CNTR_ID");
                DS_IO_DETAIL.RowPosition = n;
                showMessage(INFORMATION, OK, "USER-1003", "계약ID");
                setTimeout("GD_DETAIL.SetColumn('CNTR_ID')" , 30);
                return false;
            }
            
            // 안분율
            if (DS_IO_DETAIL.NameValue(n,"DIV_RATE") > 100) {
                GD_DETAIL.SetColumn("DIV_RATE");
                DS_IO_DETAIL.RowPosition = n;
                showMessage(INFORMATION, OK, "USER-1000", "안분율은 100% 이내로 입력해야 합니다.");
                setTimeout("GD_DETAIL.SetColumn('DIV_RATE')" , 30);
                return false;
            }
            
            // 적용일자
            if (DS_IO_DETAIL.NameValue(n,"APP_S_DT").length != 8 ) {
                GD_DETAIL.SetColumn("APP_S_DT");
                DS_IO_DETAIL.RowPosition = n;
                showMessage(INFORMATION, OK, "USER-1003", "적용일자");
                setTimeout("GD_DETAIL.SetColumn('APP_S_DT')" , 30);
                return false;
            }
            
            // 종료일자
            if (DS_IO_DETAIL.NameValue(n,"APP_E_DT").length != 8 ) {
                GD_DETAIL.SetColumn("APP_E_DT");
                DS_IO_DETAIL.RowPosition = n;
                showMessage(INFORMATION, OK, "USER-1003", "종료일자");
                setTimeout("GD_DETAIL.SetColumn('APP_E_DT')" , 30);
                return false;
            }
            
            // 적용일자 ~ 종료일자
            var strAppSdt = DS_IO_DETAIL.NameValue(n,"APP_S_DT");
            var strAppEdt = DS_IO_DETAIL.NameValue(n,"APP_E_DT");
            if (strAppSdt > strAppEdt) {
                GD_DETAIL.SetColumn("APP_S_DT");
                DS_IO_DETAIL.RowPosition = n;
                showMessage(INFORMATION, OK, "USER-1009", "적용일자", "종료일자");
                setTimeout("GD_DETAIL.SetColumn('APP_S_DT')" , 30);
                return false;
            }
        }
    }
    
    //계량기사용구분이 개별일경우 (기간)중복체크
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_USE_FLAG") == "1" ) {
        for (var k=1; k<=DS_IO_DETAIL.CountRow; k++) {
            var tmpAppSDt = DS_IO_DETAIL.NameValue(k, "APP_S_DT"); //체크할 적용일자
            var tmpAppEDt = DS_IO_DETAIL.NameValue(k, "APP_E_DT"); //체크할 종료일자
            for (var i=(k+1); i<=DS_IO_DETAIL.CountRow; i++) {
                var iAppSDt = DS_IO_DETAIL.NameValue(i, "APP_S_DT");
                var iAppEDt = DS_IO_DETAIL.NameValue(i, "APP_E_DT");
                if ( // 사용구간(From)
                     (eval(iAppSDt) >= eval(tmpAppSDt) && eval(iAppSDt) <= eval(tmpAppEDt)) ||
                     (eval(iAppEDt) >= eval(tmpAppSDt) && eval(iAppEDt) <= eval(tmpAppEDt)) 
                    ||
                    // 사용구간(To)
                     (eval(tmpAppSDt) >= eval(iAppSDt) && eval(tmpAppSDt) <= eval(iAppEDt)) ||
                     (eval(tmpAppEDt) >= eval(iAppSDt) && eval(tmpAppEDt) <= eval(iAppEDt)))  
                {
                	GD_DETAIL.SetColumn("APP_S_DT");
                	DS_IO_DETAIL.RowPosition = i;
                    showMessage(INFORMATION, OK, "USER-1000", "["+i+"]번째 행이  ["+k+"]번째 행의  적용기간(적용일자~종료일자)과 중복 됩니다.");
                    setTimeout("GD_DETAIL.SetColumn('APP_S_DT')" , 30);
                    return false;
                }
            }
        }
    } 
    return true;
}

/**
 * checkValidateTrem()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidateTrem() {
    // 중복값 체크 
    var tmpAppSDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT"); //체크할 적용일자
    var tmpAppEDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_E_DT"); //체크할 종료일자
    for (var i=1; i<=DS_IO_DETAIL.CountRow; i++) {
    	if (i != DS_IO_DETAIL.RowPosition) { //비교행은 제외
			var iAppSDt = DS_IO_DETAIL.NameValue(i, "APP_S_DT");
			var iAppEDt = DS_IO_DETAIL.NameValue(i, "APP_E_DT");
			if ( // 사용구간(From)
			     (eval(iAppSDt) >= eval(tmpAppSDt) && eval(iAppSDt) <= eval(tmpAppEDt)) ||
			     (eval(iAppEDt) >= eval(tmpAppSDt) && eval(iAppEDt) <= eval(tmpAppEDt)) 
			    ||
			    // 사용구간(To)
			     (eval(tmpAppSDt) >= eval(iAppSDt) && eval(tmpAppSDt) <= eval(iAppEDt)) ||
			     (eval(tmpAppEDt) >= eval(iAppSDt) && eval(tmpAppEDt) <= eval(iAppEDt)))  
			{
				showMessage(INFORMATION, OK, "USER-1000", "["+i+"]번째 행의 적용기간(적용일자~종료일자)과 중복 됩니다.");
				GD_DETAIL.SetColumn("APP_S_DT");
				return false;
			}
    	}
    } 
    return true;
}

/**
 * objectControl()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 입력값 컨트롤
 * return값 :
 */
function objectControl(objBoolean) {
    if (objBoolean) {
        GD_DETAIL.ColumnProp('CNTR_ID', 'Edit') = 'AlphaNum';
   	    //GD_DETAIL.ColumnProp('DIV_RATE','Edit') = 'RealNumeric';
    	GD_DETAIL.ColumnProp('APP_S_DT','Edit') = '';
    	GD_DETAIL.ColumnProp('APP_E_DT','Edit') = '';
        enableControl(IMG_DEL_ROW, true);
        enableControl(IMG_ADD_ROW, true);
    } else {
        GD_DETAIL.ColumnProp('CNTR_ID', 'Edit') = 'None';
        //GD_DETAIL.ColumnProp('DIV_RATE','Edit') = 'None';
        GD_DETAIL.ColumnProp('APP_S_DT','Edit') = 'None';
        GD_DETAIL.ColumnProp('APP_E_DT','Edit') = 'None'; 
        enableControl(IMG_DEL_ROW, false);
        enableControl(IMG_ADD_ROW, false);
    }
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
<script language=JavaScript for=TR_SUB event=onSuccess>
    for(i=0;i<TR_SUB.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SUB.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
    }
    //저장 성공시(계량기별 매핑정보) 재조회
    getDetail();
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_SUB event=onFail>
    trFailed(TR_SUB.ErrorMsg);
</script>
<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  -------------------------------> 

<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>
if(clickSORT) return;
//마스터
if (row > 0) {
	//유효기간이 지난 계량기에 대한 매핑불가
	if (eval(DS_IO_MASTER.NameValue(row, "VALID_E_DT")) < eval(getTodayFormat("YYYYMMDD")) ) {
	    objectControl(false);
	} else {
	    objectControl(true);
	}
	
	//[안분율 컨트롤]계량기 개별일경우 안분율 비활성화
	if (DS_IO_MASTER.NameValue(row, "GAUG_USE_FLAG") == 2) { //[개량기사용구분] 공통
	    if (DS_IO_MASTER.NameValue(row, "DIV_RULE_TYPE") == 2) { //[공동안분기준] 안분율
	        GD_DETAIL.ColumnProp('DIV_RATE','Edit') = 'RealNumeric';
	    } else {
	        GD_DETAIL.ColumnProp('DIV_RATE','Edit') = 'None';
	    }
	} else { //개별
        GD_DETAIL.ColumnProp('DIV_RATE','Edit') = 'None';
	}
	
    //상세 조회
    getDetail();
} else {
	objectControl(false);
    DS_IO_DETAIL.ClearData();
}
</script>

<script language=JavaScript for=DS_IO_DETAIL event=onRowPosChanged(row)>
if(clickSORT) return;
//디테일(적용기간 이전에 대한 행 삭제 가능 이 후 불가능)
if (row > 0) {
    //적용기간 이전에 대한 행 삭제 가능 이 후 불가능
    if (eval(DS_IO_DETAIL.OrgNameString(row, "APP_S_DT")) < eval(getTodayFormat("YYYYMMDD")) ) {
    	enableControl(IMG_DEL_ROW, false);
    } else {
    	enableControl(IMG_DEL_ROW, true);
    }
    
    //이미등록된건은 수정불가(계약ID)
    if (DS_IO_DETAIL.RowStatus(row) == 1) {
        GD_DETAIL.ColumnProp('CNTR_ID', 'Edit') = 'AlphaNum';
    } else {
        GD_DETAIL.ColumnProp('CNTR_ID', 'Edit') = 'None';
    }
}
</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
//저장 시 체크없음
if (DS_IO_MASTER.CountRow > 0) {
    if ( DS_IO_DETAIL.IsUpdated) {
        var ret = showMessage(Question, YesNo, "USER-1049");
        if (ret == "1") {
            //rollbackDate(row);          
            return true;    
        } else {
            return false;   
        }
    }
    return true;
}
return true;
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

<script language=JavaScript for=EM_S_GAUG_ID event=OnKillFocus()> 
//계량기ID
    if(!this.Modified) return;
       
    if(this.text==''){;
	    EM_S_INST_PLC.Text = "";
	    return;
    } 

    //단일건 체크 
    getGaugIdNonPop( "DS_O_RESULT", EM_S_GAUG_ID, LC_S_FCL_FLAG.BindColVal, LC_S_GAUG_TYPE.BindColVal, "E", "N", "F", "");
    if (DS_O_RESULT.CountRow == 1 ) {
        EM_S_GAUG_ID.Text = DS_O_RESULT.NameValue(1, "GAUG_ID");
        EM_S_INST_PLC.Text = DS_O_RESULT.NameValue(1, "INST_PLC");
    } else {
        //1건 이외의 내역이 조회 시 팝업 호출
        EM_S_INST_PLC.Text = "";
        var rt = getGaugIdPop(EM_S_GAUG_ID, EM_S_INST_PLC, LC_S_FCL_FLAG.BindColVal, LC_S_GAUG_TYPE.BindColVal, "S", "F", "");
        if (rt) {
            //EM_S_GAUG_ID.Text = rt.GAUG_ID;
            EM_S_INST_PLC.Text = rt.INST_PLC;
        } 
    } 
</script>

<script language=JavaScript for=EM_S_VEN_CD event=OnKillFocus()> 
//협력사코드 변경시
    if(!this.Modified) return;
       
    if(this.text==''){;
	    EM_S_VEN_NAME.Text = "";
	    return;
    } 

    setVenNmWithoutPop("DS_O_RESULT", EM_S_VEN_CD, EM_S_VEN_NAME , '1');
</script>

<script language=JavaScript for=GD_DETAIL event=OnPopup(row,colid,data)>
if (colid == "CNTR_ID") {
//계약ID 팝업호출
    if (row < 1) return;
    var strFlc      = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");  //설치 시설
    var strCntrId   = DS_IO_DETAIL.NameValue(row, "CNTR_ID");                           //해당 위치의 입력 값
    var strMstGaugId= DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_ID");      //[마스터]계량기ID
    var strMstGaugTy= DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_TYPE");    //[마스터]계량기구분
    var strMstGaugKi= DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_KIND_CD"); //[마스터]계량기형태
    var rt = getCntrPop( strCntrId, strFlc, "", strMstGaugTy, strMstGaugKi, "S", "N", "C");
    
    if (rt == undefined) return;

    g_autoFlag = true; //onExit 이벤트 제외
    
    var validateChk = true;
    for (var k=1; k<=DS_IO_DETAIL.CountRow; k++) {
        if (DS_IO_DETAIL.NameValue(k, "CNTR_ID") == rt.CNTR_ID) {
            validateChk = false;
            break;
        }
    } 
    //중복값 없을시 처리
    if (validateChk) {
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_ID") = strMstGaugId;     //계량기ID
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CNTR_ID") = rt.CNTR_ID;       //계약ID
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_CD") = rt.VEN_CD;         //협력사
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_NM") = rt.VEN_NM;         //협력사명
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") = rt.CNTR_S_DT;    //적용일자
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_E_DT") = rt.CNTR_E_DT;    //종료일자
    } else {
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_ID") = "";    //계량기ID
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CNTR_ID") = "";    //계약ID
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_CD") = "";     //협력사코드
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_NM") = "";     //협력사명
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") = "";   //적용일자
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_E_DT") = "";   //종료일자
        showMessage(INFORMATION, OK, "USER-1000", "이미 입력된 계약ID 입니다.");
    }
    
    g_autoFlag = false; //onExit 이벤트 제외 끝
} else if(colid == "APP_S_DT" || colid == "APP_E_DT"){
//적용시작일, 적용종료일자
    openCal(this,row,colid);    
}
</script>
<script language=JavaScript for=GD_DETAIL event=OnExit(row,colid,olddata)>
//해더 행위는 제외
if (row < 1) return;
//팝업입력은 제외
if (g_autoFlag) return;

//계약ID
if (colid == "CNTR_ID") {
    var strCntrId   = DS_IO_DETAIL.NameValue(row, "CNTR_ID");                           //해당 위치의 입력 값
    var strFlc      = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");  //[마스터]설치 시설
    var strMstGaugId= DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_ID");      //[마스터]계량기ID
    var strMstGaugTy= DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_TYPE");    //[마스터]계량기구분
    var strMstGaugKi= DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_KIND_CD"); //[마스터]계량기형태
    
    if (strCntrId.length > 0) {
    	if (olddata == strCntrId) return;
    	getCntrNonPop( "DS_O_RESULT", strCntrId, strFlc, "", strMstGaugTy, strMstGaugKi, "G", "N", "Y", "C");
    	
        if (DS_O_RESULT.CountRow != 1 ) {
            //1건 이외의 내역이 조회 시 팝업 호출
	        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_ID") = "";    //계량기ID
	        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CNTR_ID") = "";    //계약ID
	        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_CD") = "";     //협력사코드
	        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_NM") = "";     //협력사명
	        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") = "";   //적용일자
	        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_E_DT") = "";   //종료일자
            
            var rt = getCntrPop( strCntrId, strFlc, "", strMstGaugTy, strMstGaugKi, "S", "N", "C");
            if (rt == undefined) return;

            var validateChk = true;
            for (var k=1; k<=DS_IO_DETAIL.CountRow; k++) {
                if (k != eval(DS_IO_DETAIL.RowPosition)) {
                    if (DS_IO_DETAIL.NameValue(k, "CNTR_ID") == rt.CNTR_ID) {
                        validateChk = false;
                        break;
                    }       
                }
            } 
            
            //중복값 없을시 처리
            if (validateChk) {
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_ID") = strMstGaugId;     //계량기ID
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CNTR_ID") = rt.CNTR_ID;       //설치장소
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_CD") = rt.VEN_CD;         //협력사
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_NM") = rt.VEN_NM;         //협력사명
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") = rt.CNTR_S_DT;    //적용일자
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_E_DT") = rt.CNTR_E_DT;    //종료일자
            } else {
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_ID") = "";    //계량기ID
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CNTR_ID") = "";    //계약ID
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_CD") = "";     //협력사코드
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_NM") = "";     //협력사명
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") = "";   //적용일자
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_E_DT") = "";   //종료일자
                showMessage(INFORMATION, OK, "USER-1000", "이미 입력된 계약ID 입니다.");
                return;         
            }
        } else {
			//계약ID가 변경되지 않을 시 
			//if (strCntrId == DS_IO_DETAIL.OrgNameString(row,"CNTR_ID")) return;
			if (strCntrId == olddata) return;
            if (DS_O_RESULT.NameValue(1, "KIND_YN") == "N") {
                showMessage(INFORMATION, OK, "USER-1000", "매핑하려는 계약ID는 등록하려는 계량기ID와 구분/용도가 동일해야 합니다.");
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_ID") = "";   //계량기ID
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CNTR_ID") = "";   //계약ID
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_CD") = "";    //협력사코드
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_NM") = "";    //협력사명
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") = "";    //적용일자
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_E_DT") = "";    //종료일자
                return; 
           }
           
           var validateChk = true;
           for (var k=1; k<=DS_IO_DETAIL.CountRow; k++) {
               if (k != eval(DS_IO_DETAIL.RowPosition)) {
                   if (DS_IO_DETAIL.NameValue(k, "CNTR_ID") == DS_O_RESULT.NameValue(1, "CNTR_ID")) {
                       validateChk = false;
                       break;
                   }       
               }
           } 
           //중복값 없을시 처리
           if (validateChk) {
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_ID")  = strMstGaugId;                             //계량기ID
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CNTR_ID")  = DS_O_RESULT.NameValue(1, "CNTR_ID");      //설치장소
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_CD")   = DS_O_RESULT.NameValue(1, "VEN_CD");       //협력사코드
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_NM")   = DS_O_RESULT.NameValue(1, "VEN_NM");       //협력사명
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") = DS_O_RESULT.NameValue(1, "CNTR_S_DT");    //적용일자
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_E_DT") = DS_O_RESULT.NameValue(1, "CNTR_E_DT");    //종료일자
           } else {
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_ID") = "";    //계량기ID
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CNTR_ID") = "";    //계약ID
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_CD") = "";     //협력사코드
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_NM") = "";     //협력사명
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") = "";   //적용일자
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_E_DT") = "";   //종료일자
               showMessage(INFORMATION, OK, "USER-1000", "이미 입력된 계약ID 입니다.");
               return;         
           }
        }
    } else {
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_ID") = "";   //계량기ID
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CNTR_ID") = "";   //계약ID
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_CD") = "";    //협력사코드
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_NM") = "";    //협력사명
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") = "";  //적용일자
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_E_DT") = "";  //종료일자
    }
} 
/*
 else if (colid == "APP_S_DT") {
//적용일자
	var sDt = DS_IO_DETAIL.NameValue(row,"APP_S_DT");
	var eDt = DS_IO_DETAIL.NameValue(row,"APP_E_DT");
    if (eDt.length == 8) {
        if (eDt.length > 0 && eval(sDt) > eval(eDt)) {
            showMessage(INFORMATION, OK, "USER-1009", "적용일자", "종료일자");
            setTimeout("GD_DETAIL.SetColumn('APP_S_DT')", 50);
        }
    } else { 
        //checkDateTypeYMD(GD_DETAIL, colid);
    }
} else if (colid == "APP_E_DT") {
//종료일자
    var sDt = DS_IO_DETAIL.NameValue(row,"APP_S_DT");
    var eDt = DS_IO_DETAIL.NameValue(row,"APP_E_DT");
    if (eDt.length == 8) {
        if (sDt.length > 0 && eval(sDt) > eval(eDt)) {
            showMessage(INFORMATION, OK, "USER-1009", "적용일자", "종료일자");
            setTimeout("GD_DETAIL.SetColumn('APP_E_DT')", 50);
        }
    } else { 
        //checkDateTypeYMD(GD_DETAIL, colid);
    }
}
*/
</script>

<script language=JavaScript for=GD_DETAIL event=CanColumnPosChange(row,colid)>

if (colid == "APP_S_DT" || colid == "APP_E_DT") {
//적용일자, 종료일자
	if (DS_IO_DETAIL.NameValue(row,colid) == "") {
		return true; 
	} else { 
		return checkDateTypeYMD(GD_DETAIL, colid);
	}
} else if (colid == "DIV_RATE") {
//안분율 음수제외
    var intDivRate = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "DIV_RATE");
    if (eval(intDivRate) > 100)  {
    	showMessage(INFORMATION, OK, "USER-1000", "안분율은 100% 이내로 입력해야 합니다.");
    	return false;
    }
}
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
<comment id="_NSID_"><object id="DS_IO_MASTER"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<comment id="_NSID_"><object id="DS_S_FCL_FLAG"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_S_GAUG_TYPE"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_GAUG_USE_FLAG"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DIV_RULE_TYPE"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_SUB" classid=<%=Util.CLSID_TRANSACTION%>>
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
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th class="point" width="80">시설구분</th>
						<td width="123"><comment id="_NSID_"> <object
							id=LC_S_FCL_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width="120"
							height=20 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80" class="point">계량기구분</th>
						<td width="123"><comment id="_NSID_"> <object
							id=LC_S_GAUG_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width="120"
							height=20 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80">계량기ID</th>
						<td><comment id="_NSID_"> <object id=EM_S_GAUG_ID
							classid=<%=Util.CLSID_EMEDIT%> width="80" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							onclick="javascript:callPopup('gaugId');" class="PR03" /> <comment
							id="_NSID_"> <object id=EM_S_INST_PLC
							classid=<%=Util.CLSID_EMEDIT%> width="135" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="60">협력사</th>
						<td colspan="5"><comment id="_NSID_"> <object id=EM_S_VEN_CD
                            classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
                            onclick="javascript:venPop(EM_S_VEN_CD, EM_S_VEN_NAME);EM_S_VEN_CD.Focus();"
                            align="absmiddle" /> <comment id="_NSID_"> <object
                            id=EM_S_VEN_NAME classid=<%=Util.CLSID_EMEDIT%> width=220 tabindex=1
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
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
        <td class="sub_title"><img
            src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
            align="absmiddle" class="PR03" />계량기 정보</td>
    </tr>
    <tr valign="top">
        <td align="left">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr valign="top">
                <td><comment id="_NSID_"><OBJECT id=GD_MASTER
                    width=100% height=200 tabindex=1 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_IO_MASTER">
                </OBJECT></comment><script>_ws_(_NSID_);</script></td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
      <td height="3"></td>
    </tr>
    <tr>
        <td class="dot"></td>
    </tr>
    <tr>
        <td align="left">
            <table  width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="sub_title"><img
		            src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
		            align="absmiddle" class="PR03" />계량기별 매핑정보</td>
	           <td align="right"><img id="IMG_ADD_ROW"
		            style="vertical-align: middle;" src="/<%=dir%>/imgs/btn/add_row.gif"
		            width="52" height="18" onclick="btn_AddRow();" hspace="2" /><img
		            id="IMG_DEL_ROW" style="vertical-align: middle;"
		            src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
		            onclick="btn_DeleteRow();" /></td>
            </tr>
            </table>
        </td>
     
    </tr>
    <tr>
        <td height="3"></td>
    </tr>
	<tr valign="top">
		<td align="left">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr valign="top">
				<td><comment id="_NSID_"><OBJECT id=GD_DETAIL
					width=100% height=235 tabindex=1 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_IO_DETAIL">
				</OBJECT></comment><script>_ws_(_NSID_);</script></td>
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

