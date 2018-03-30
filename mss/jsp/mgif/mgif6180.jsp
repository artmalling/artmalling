<!--
/*******************************************************************************
 * 시스템명 : 경영지원 > 상품권관리 > 정산관리 >재무전송(SAP)
 * 작 성 일 : 2011.09.19
 * 작 성 자 : 김성미
 * 수 정 자 : 
 * 파 일 명 : MGIF6180.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : SAP I/F 전송
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
  import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                              *-->
<!--*************************************************************************-->
<loginChk:islogin />
<% String dir = BaseProperty.get("context.common.dir"); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<title>재무전송(SAP)</title>
<link rel="stylesheet" type="text/css" href="/<%=dir%>/css/mds.css" />
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_ccs.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                      *-->
<!--*************************************************************************-->
<script type="text/javascript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var newMasterYn = false;
var btnClickSelect = false;
var btnClickNew = false;
var btnClickSave = false;
var globalCntrCd = "";
var globalSapIf = "";
var globalReqDt = "";
var toDay = "";
/**
 * doInit()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-09-05
 * 개    요 : 해당 페이지 LOAD 시
 * return값 : void
 */
function doInit() {
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');

    // 그리드 초기화
    gridCreate1();

    // EMedit 초기화
    initEmEdit(EM_S_REQ_DT, "YYYYMMDD", PK); // 생성일(조회)
    initEmEdit(EM_S_REQ_YM, "YYYYMM", PK); // 생성월(조회)
    
    // 콤보 초기화
    initComboStyle(LC_S_CNTR_CD, DS_O_CNTR_CD, "CODE^0^30,NAME^0^100", 1, PK); // 센터코드(조회)
    initComboStyle(LC_S_SAP_IF, DS_O_SAP_IF,   "CODE^0^50,NAME^0^150", 1, PK); // SAP I/F(조회)

    // 콤보데이터 가져오기 
    getStore("DS_O_CNTR_CD", "N", "", "N");   
   // getEtcCodeReferLike("DS_O_SAP_IF", "D", "P701", "", "N"); // SAP I/F(조회)
    RD_CAL_GB.CodeValue = "1";
    getIFCode();
    // 콤보데이터 기본값 설정
    LC_S_CNTR_CD.Index = 0; // 센터(조회)
    LC_S_SAP_IF.Index = 0;  // SAP I/F(조회)

    // DB시간 가져오기
    toDay = getTodayDB("DS_I_COMMON");
    
    // EMedit 기본값
    EM_S_REQ_DT.Text = toDay;// 생성일(조회)  : db시간
    EM_S_REQ_YM.Text = toDay;// 생성일(조회)  : db시간
    RD_CAL_GB.CodeValue = "1";
    // 포커스 초기화
    initFocus();
}

function gridCreate1() {
    var hdrProperies = '<FC>id={currow}  name="NO"                width=40   align=center  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=BUDAT     name="전기일"          width=70   align=center Suppress=2  Mask="XXXX/XX/XX"   SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=LELNR    name="전표번호"        width=70   align=center Suppress=1 subSumText="" SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=BUZEI     name="차수"             width=50  align=center  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=NEWKO     name="계정코드"           width=70   align=left  SubBgColor=#FFFFE0 </FC>'
                     + '<FC>id=NEWKONM     name="계정코드명"           width=170   align=left  SubBgColor=#FFFFE0 </FC>'
                     + '<FC>id=SGTXT     name="적요"          width=150   align=left  SubBgColor=#FFFFE0</FC>'
                     + '<FG>id=C        name="차변"'
                     + '<FC>id=C_WRBTR  name="금액"               width=80   align=right  SubSumText={subsum(C_WRBTR)} SumText={subsum(C_WRBTR)}   SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=C_WMWST  name="세액"               width=80   align=right  SubSumText={subsum(C_WMWST)} SumText={subsum(C_WMWST)} SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=C_FWBAS  name="과세표준금액"           width=80   align=right  SubBgColor=#FFFFE0</FC>'
                     + '</FG>'
                     + '<FG>id=D       name="대변"'
                     + '<FC>id=D_WRBTR  name="금액"               width=80   align=right  SubSumText={subsum(D_WRBTR)+subsum(D_WMWST)}  SumText={subsum(D_WRBTR)+subsum(D_WMWST)} SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=D_WMWST  name="세액"               width=80   align=right SubSumText="" SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=D_FWBAS  name="과세표준금액"           width=80   align=right SubSumText="" SubBgColor=#FFFFE0</FC>'
                     + '</FG>'
                     + '<FC>id=BSCHL     name="전기키"          width=40   align=center  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=HKONT     name="조정계정"           width=80   align=center  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=HKONTNM     name="조정계정명"           width=170   align=left  SubBgColor=#FFFFE0 </FC>'
                     + '<FC>id=UMSKZ     name="특별GL"           width=60   align=left  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=MWSKZ     name="세금코드"           width=80   align=center  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=GJAHR    name="회계연도"           width=60   align=center  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=BUPLA    name="사업장"             width=80   align=center SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=GSBER    name="사업영역"             width=80   align=center SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=KOSTL    name="코스트센터"             width=80   align=center SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=ZTERM    name="지급조건"             width=80   align=center SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=ZFBDT    name="지급기산일"             width=80   align=center Mask="XXXX/XX/XX" SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=BLART    name="전표유형"             width=60   align=center SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=ZLSPR    name="지급보류"             width=60   align=center SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=ZUONR    name="지정"             width=120   align=left SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=BKTXT    name="HEADER적요"             width=120   align=left SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=FDTAG    name="만기일"             width=80   align=center Mask="XXXX/XX/XX" SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=STR_CD    name="점코드"             width=60   align=center SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=TRANTP    name="SAP구분"             width=70   align=center SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=TRANYN    name="SAP전송;유무"             width=60   align=center SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=TRANDT    name="생성일"             width=80   align=center Mask="XXXX/XX/XX" SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=BELNR    name="회계전표번호"        width=90   align=center Suppress=1 subSumText="" SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=XSTAT    name="I/F상태"        width=60   align=center Suppress=1 subSumText="" SubBgColor=#FFFFE0</FC>'
                     ;

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    
    DS_O_MASTER.SubSumExpr =  'LELNR';
    GD_MASTER.ColumnProp("LELNR", "SubSumText") = "소계";
    GD_MASTER.ColumnProp("BUDAT", "sumtext") = "합계";
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
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-09-05
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
    var strCntrCd = LC_S_CNTR_CD.BindColVal;
    var strSapIf = LC_S_SAP_IF.BindColVal;
    var strCalGb = RD_CAL_GB.CodeValue;
   
    if (strCalGb == "1") {
        var strReqDt = EM_S_REQ_DT.Text;
    }else if (strCalGb == "2"){
    	var strReqDt = EM_S_REQ_YM.Text;
    }
    // 센터
    if (strCntrCd == "") {
        showMessage(EXCLAMATION, OK, "USER-1000", "조회시 센터는 반드시 선택해야 합니다.");
        LC_S_CNTR_CD.Focus();
        return false;
    }
    
    // I/F
    if (strSapIf == "") {
        showMessage(EXCLAMATION, OK, "USER-1000", "조회시 I/F는 반드시 선택해야 합니다.");
        LC_S_SAP_IF.Focus();
        return false;
    }

    // 생성일
    if (strReqDt == "") {
        // 조회시 []은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1001", "생성일");
        EM_S_REQ_DT.Focus();
        return false;
    }
    
    // 생성일 체크
    if (!ccsIsDate(EM_S_REQ_DT, "생성일")) {
        return false;
    }
    
    
    // 현재일자 체크
    //if (eval(yyyymmddhh24miss.substring(0,8)) < eval(strReqDt)) {
    //    // []은(는) []보다 작거나 같아야 합니다.
    //    showMessage(EXCLAMATION, OK, "USER-1021", "생성일자", "현재일자");
    //    EM_S_REQ_DT.Focus();
    //    return false;
   // }
    
    // 글로벌 변수
    globalCntrCd = strCntrCd;
    globalSapIf = strSapIf;
    globalReqDt = strReqDt;

    // MASTER CLEAR
    DS_O_MASTER.ClearData();
    // 신규행 false
    newMasterYn = false;
    // 버튼클릭조회 true
    btnClickSelect = true;
    // sort 초기화
  //  DS_O_MASTER.Sortexpr = "";

    var goTo       = "searchMaster";
    var action     = "O"; // 조회
    var parameters = "&strCntrCd="+ encodeURIComponent(strCntrCd)
                   + "&strSapIf=" + encodeURIComponent(strSapIf)
                   + "&strReqDt=" + encodeURIComponent(strReqDt)
                   + "&strCalGb=" + encodeURIComponent(strCalGb);

    TR_MAIN.Action = "/mss/mgif618.mg?goTo="+goTo+parameters;
    TR_MAIN.KeyValue = "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)";
    TR_MAIN.Post();

    
    // MASTER 포커스
    GD_MASTER.Focus();
    //조회후 결과표시
    var row = DS_O_MASTER.CountRow;
    setPorcCount("SELECT", row);

    // 버튼클릭조회 false
    btnClickSelect = false;
}

/**
 * btn_New()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-09-05
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {

}

/**
 * btn_Delete()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-09-05
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-09-05
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

}

/**
 * btn_Excel()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-09-05
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	var ExcelTitle = "회계전표 IF"
        openExcel2(GD_MASTER, ExcelTitle, "", true );
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-09-05
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {

}

/**
 * btn_Conf()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-09-05
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * getIFCode()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-09-19
 * 개    요 : 정산구분에 따른  SAP I/F 콤보 조회
 * 사용방법 : getIFCode()
 * return값 : true, false
 */
function getIFCode(){
	TR_MAIN.Action = "/mss/mgif618.mg?goTo=getIFCode";
	TR_MAIN.KeyValue = "SERVLET(O:DS_O_SAP_IF=DS_O_SAP_IF)";
	TR_MAIN.Post();
}
 
/**
 * ccsIsDate()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-09-05
 * 개    요 : 날짜확인
 * 사용방법 : ccsIsDate(obj, title)
 *            arguments[0] -> 객체
 *            arguments[1] -> 이름
 * return값 : true, false
 */
function ccsIsDate(obj, title) {
    if (obj.Text == "") {
        showMessage(EXCLAMATION, OK, "USER-1003", title+" 년월일");
        obj.focus();
        return false;
    }
    if (obj.Text.length != 8) {
        showMessage(EXCLAMATION, OK, "USER-1000", title+" 년월일 8자리를 입력해야 합니다.");
        obj.focus();
        return false;
    }
    if (obj.Text.charAt(0) == "0") {
        // ()의 입력형식이 올바르지 않습니다.
        showMessage(EXCLAMATION, OK, "USER-1004", title+" 날짜");
        obj.focus();
        return false;
    }
    if (isNaN(obj.Text)) {
        // ()의 입력형식이 올바르지 않습니다.
        showMessage(EXCLAMATION, OK, "USER-1004", title+" 날짜");
        obj.focus();
        return false;
    }

    return true;
}

/**
 * initFocus()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-09-05
 * 개    요 : 포커스 초기화
 * 사용방법 : initFocus()
 * return값 : void
 */
function initFocus() {
    LC_S_CNTR_CD.Focus();
}

/**
 * getSapIfsCode()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-09-05
 * 개    요 : SAP I/F 코드 구하기
 * 사용방법 : initFocus()
 * return값 : void
 */
function getSapIfsCode() {
    // 점코드
    var strCode = "";
    var codeRow = DS_O_SAP_IF.NameValueRow("CODE", globalSapIf);    
    if (codeRow > 0) {
        strCode = DS_O_SAP_IF.NameValue(codeRow, "REFER_CODE");
    }
    
    return strCode;
}

/**
 * sapIfCreate()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-03-22
 * 개    요 : SAP I/F 생성
 * return값 : void
 */
function sapIfCreate() {
    if (globalCntrCd == "" || globalSapIf == "" || globalReqDt == "") {
        // 데이터 조회 후 ()이/가 가능합니다.
        showMessage(INFORMATION, OK, "USER-1075", "생성");
        return false;
        
    } else {
        var cnt = 0;
        for (var m = 1; m <= DS_O_MASTER.CountRow; m++) {
            if (DS_O_MASTER.NameValue(m, "TRANYN") == "Y") {
                cnt = 1;
                break;
            }
        }
        
        if (cnt == 1) {
            showMessage(EXCLAMATION, OK, "USER-1000", "이미 전송 되어 생성할 수 없습니다.");
            return false;
        }        
        
        var strCalGb = RD_CAL_GB.CodeValue;
        
        if (strCalGb == "1") {
        	/*var year = globalReqDt.substring(0,4);
            var month = globalReqDt.substring(4,6);
            var day = globalReqDt.substring(6,8);
            var dd = new Date(year, eval(month), 0);
            var lastDay = dd.getDate();
            var lastDateInfo = year+"-"+month+"-"+lastDay;
            
            if (eval(day) != eval(lastDay)) {
                showMessage(EXCLAMATION, OK, "USER-1000", "마지막일로 조회 후 생성 가능합니다.");
                return false;
            }*/
            var strReqDt = EM_S_REQ_DT.Text;
        }else if (strCalGb == "2"){
        	var strReqDt = EM_S_REQ_YM.Text;
        }
        
        // SAP I/F 코드
    	  var sapIfCode = getSapIfsCode();
    	  if (sapIfCode.trim() == "") {
    		    return false;
    	  }
        
        var parameters = "&strCntrCd="+ encodeURIComponent(globalCntrCd)
                       + "&strSapIf=" + encodeURIComponent(globalSapIf)
                       + "&strReqDt=" + encodeURIComponent(strReqDt);
        
        TR_MAIN.Action = "/mss/mgif618.mg?goTo="+sapIfCode+parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
        TR_MAIN.Post();
        
        // 정상 처리일 경우 조회
        if (TR_MAIN.ErrorCode == 0) {
            btn_Search();
        }
    }
}

/**
 * sapIfSend()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-03-22
 * 개    요 : SAP I/F 전송
 * return값 : void
 */
function sapIfSend() {
    if (globalCntrCd == "" || globalSapIf == "" || globalReqDt == "") {
        // 데이터 조회 후 ()이/가 가능합니다.
        showMessage(INFORMATION, OK, "USER-1075", "전송");
        return false;
    } else {       
        var masterRow = DS_O_MASTER.CountRow;
        if (masterRow == 0) {
            showMessage(EXCLAMATION, OK, "USER-1000", "자료생성 후 전송 가능합니다.");
            return false;
        }
        
        var cnt = 0;
        for (var m = 1; m <= masterRow; m++) {
            if (DS_O_MASTER.NameValue(m, "TRANYN") == "Y") {
                cnt = 1;
                break;
            }
        }
        
        if (cnt == 1) {
            showMessage(EXCLAMATION, OK, "USER-1000", "이미 전송 되었습니다.");
            return false;
        }
        
        // SAP I/F 코드
        var sapIfCode = getSapIfsCode();
        if (sapIfCode.trim() == "") {
            return false;
        }
        
        var strCalGb = RD_CAL_GB.CodeValue;
        
        if (strCalGb == "1") {
        	var strReqDt = EM_S_REQ_DT.Text;
        }else if (strCalGb == "2"){
            var strReqDt = EM_S_REQ_YM.Text;
        }
        
        var parameters = "&strCntrCd="+ encodeURIComponent(globalCntrCd)
                       + "&strSapIf=" + encodeURIComponent(globalSapIf)
                       + "&strReqDt=" + encodeURIComponent(strReqDt)
                       + "&strCalGb=" + encodeURIComponent(strCalGb);
        
        TR_MAIN.Action = "/mss/mgif618.mg?goTo=ifsSend"+parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
        TR_MAIN.Post();
        
        // 정상 처리일 경우 조회
        if (TR_MAIN.ErrorCode == 0) {
            btn_Search();
        }
    }
}
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                        *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script type="text/javascript" for="TR_MAIN" event="onSuccess">
    for (var i=0; i<this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script type="text/javascript" for="TR_MAIN" event="onFail">
    trFailed(this.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_SAP_IF event=OnFilter(row)>
DS_O_MASTER.ClearData();
if(RD_CAL_GB.CodeValue == 1){
	if (DS_O_SAP_IF.NameValue(row, "CAL_GB") != "1") {// 일자별 
	    return false;
	}
	return true;	
}else if (RD_CAL_GB.CodeValue == 2){
	if (DS_O_SAP_IF.NameValue(row, "CAL_GB") != "2") {// 월별 
	    return false;
	}
	return true;
}

</script>
<script type="text/javascript" for="DS_O_MASTER" event="OnDataError(row,colid)">
    var colName = GD_MASTER.GetHdrDispName(-3, colid);
    if (this.ErrorCode == "50018") {
        showMessage(STOPSIGN, OK, "GAUCE-1005", colName);
    } else if (this.ErrorCode == "50019") {
        showMessage(STOPSIGN, OK, "GAUCE-1007", row);
    } else {
        showMessage(STOPSIGN, OK, "USER-1000", this.ErrorMsg);
    }
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=RD_CAL_GB event=OnClick()>
DS_O_SAP_IF.Filter();
LC_S_SAP_IF.Index = 0;  // SAP I/F(조회)
if(RD_CAL_GB.CodeValue == "1"){ // 일자
	document.getElementById("title").innerText = "전기일";
    DIV_DATE.style.display = '';
    DIV_YYYYMM.style.display = 'none';
}else if(RD_CAL_GB.CodeValue == "2"){ // 월
	document.getElementById("title").innerText = "전기월";
	DIV_DATE.style.display = 'none';
    DIV_YYYYMM.style.display = '';
}
// EMedit 기본값
EM_S_REQ_DT.Text = toDay;// 생성일(조회)  : db시간
EM_S_REQ_YM.Text = toDay;// 생성일(조회)  : db시간
</script>
<script language=JavaScript for=LC_S_SAP_IF event=OnCloseUp()>
DS_O_MASTER.ClearData();
globalCntrCd = "";
globalSapIf = "";
lobalReqDt = "";
</script>
<script language=JavaScript for=LC_S_CNTR_CD event=OnCloseUp()>
DS_O_MASTER.ClearData();
globalCntrCd = "";
globalSapIf = "";
lobalReqDt = "";
</script>
<script type="text/javascript" for="GD_MASTER" event="OnClick(row,colid)">
    if (row < 1) {
        // sortColId(eval(this.DataID), row , colid);
    }
</script>
<script language=JavaScript for=EM_S_REQ_DT event=OnKillFocus()>
DS_O_MASTER.ClearData();
globalCntrCd = "";
globalSapIf = "";
lobalReqDt = "";
</script>

<script language=JavaScript for=EM_S_REQ_YM event=OnKillFocus()>
DS_O_MASTER.ClearData();
globalCntrCd = "";
globalSapIf = "";
lobalReqDt = "";
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                              *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER" classid="<%=Util.CLSID_DATASET%>"></object></comment><script type="text/javascript">_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT" classid="<%=Util.CLSID_DATASET%>"></object></comment><script type="text/javascript">_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CNTR_CD" classid="<%=Util.CLSID_DATASET%>"></object></comment><script type="text/javascript">_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SAP_IF" classid="<%=Util.CLSID_DATASET%>">
<param name=UseFilter value=true>
</object></comment><script type="text/javascript">_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DATE" classid="<%=Util.CLSID_DATASET%>"></object></comment><script type="text/javascript">_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON" classid="<%=Util.CLSID_DATASET%>"></object></comment><script type="text/javascript">_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid="<%=Util.CLSID_DATASET%>"></object></comment><script type="text/javascript">_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
  <object id="TR_MAIN" classid="<%=Util.CLSID_TRANSACTION%>">
    <param name="KeyName" value="Toinb_dataid4">
  </object>
</comment>
<script type="text/javascript">_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* E. 본문시작                                                           *-->
<!--*************************************************************************-->
</head>
<body onload="doInit();" class="PL10 PT15">
<!-- 공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp" %>
<!-- //공통 타이틀/버튼  -->

<!-- wrap -->
<div id="testdiv" class="testdiv">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="PT01 PB03">
        <!-- search -->
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
          <tr>
            <td>
              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table" style="table-layout:fixed;">
                <colgroup>
                <col width="100" />
                <col width="280" />
                <col width="100" />
                <col />
                </colgroup>
                <tbody>
                <tr>
                  <th class="point">점</th>
                  <td>
                    <comment id="_NSID_">
                      <object id="LC_S_CNTR_CD" classid="<%=Util.CLSID_LUXECOMBO%>" width="275" align="absmiddle">
                      </object>
                    </comment>
                    <script type="text/javascript">_ws_(_NSID_);</script>
                  </td>
                   <th class="point">정산구분</th>
                  <td>
                    <comment id="__NSID__">
                      <object id=RD_CAL_GB classid=<%=Util.CLSID_RADIO%> style="height:24; width:175">
                        <param name=Cols   value="2">
                        <param name=Format  value="1^일정산,2^월정산">
                      </object></comment><SCRIPT>_ws_(__NSID__);</SCRIPT>
                  </td>
                 
                </tr>
                <tr>
                   <th class="point">SAP I/F</th>
                  <td>
                    <comment id="_NSID_">
                      <object id="LC_S_SAP_IF" classid="<%=Util.CLSID_LUXECOMBO%>" width="275" align="absmiddle">
                      </object>
                    </comment>
                    <script type="text/javascript">_ws_(_NSID_);</script>
                  </td>
                  <th id="title" class="point">전기일</th>
                  <td>
                    <div id="DIV_DATE">
                     <comment id="_NSID_">
                      <object id="EM_S_REQ_DT" classid="<%=Util.CLSID_EMEDIT%>" width="80" align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
                      </object>
                    </comment>
                    <script type="text/javascript">_ws_(_NSID_);</script>
                    <a href="#calendarPopup" onclick="openCal('G', EM_S_REQ_DT); return false;" onkeydown="if(event.keyCode == 13) openCal('G', EM_S_REQ_DT);"><img src="/pot/imgs/btn/date.gif" align="absmiddle" /></a>
                    </div>
                   
                    <div id="DIV_YYYYMM" style="Display='none'">
                    <comment id="_NSID_">
                    <object id="EM_S_REQ_YM" classid="<%=Util.CLSID_EMEDIT%>" width="80" align="absmiddle" onblur="javascript:checkDateTypeYM(this);">
                    </object>
                    </comment>
                    <script type="text/javascript">_ws_(_NSID_);</script>
                    <a href="#calendarPopup" onclick="openCal('M', EM_S_REQ_YM); return false;" onkeydown="if(event.keyCode == 13) openCal('M', EM_S_REQ_YM);"><img src="/pot/imgs/btn/date.gif" align="absmiddle" /></a>
                    </div>
                  </td>
                </tr>
                </tbody>
              </table>
            </td>
          </tr>
        </table>
        <!-- //search -->
      </td>
    </tr>
    <tr>
      <td class="dot"></td>
    </tr>
    <tr valign="top">
      <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr valign="top">
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td class="right">
                    <img src="/<%=dir%>/imgs/btn/re_fee.gif" id="IMG_CREATE" width="72" height="18" alt="정산재생성" onclick="sapIfCreate(); return false;" />
                    <img src="/<%=dir%>/imgs/btn/send_pre.gif" id="IMG_SEND" width="62" height="18" alt="전송처리" onclick="sapIfSend(); return false;" />
                  </td>
                </tr>
              </table>
            <td>
          </tr>
          <tr valign="top">
            <td>
              <!-- content -->
              <table border="0" width=100% cellspacing="0" cellpadding="0" class="BD4A">
                <tr>
                  <td>
                    <comment id="_NSID_">
                      <object id="GD_MASTER" width="100%" height="455" classid="<%=Util.CLSID_GRID%>">
                        <param name="DataID" value="DS_O_MASTER">
                      </object>
                    </comment>
                    <script type="text/javascript">_ws_(_NSID_);</script>
                  </td>
                </tr>
              </table>
              <!-- //content -->
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!-- //wrap -->
</body>
</html>
