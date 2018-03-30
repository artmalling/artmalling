<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 전력요금표관리(기타)
 * 작 성 일 : 2010.03.23
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : MREN1050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 전력요금표관리(기타)
 * 이    력 : 2010.03.23 (김유완) 신규작성
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
var g_DefaultFee = [{"f0111":"5280", "f0122":"5790", "f0123":"6660", "f0132":"5790", "f0133":"6660"},
                    {                "f0222":"5790", "f0223":"6660", "f0232":"5790", "f0233":"6660"},
                    {"f1111":"4610", "f1122":"4880", "f1123":"5620", "f1132":"4510", "f1133":"5200"},
                    {                "f1222":"6030", "f1223":"6970", "f1232":"5570", "f1233":"6450"},
                    {                "f1322":"6070", "f1323":"7000", "f1332":"5590", "f1333":"6210", "f1334":"6890", "f1342":"5550", "f1343":"6340", "f1344":"6800"}
                    ]

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.23
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_POWERPRCE"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER");
    
    //그리드 초기화
    gridCreate("MST"); //마스터
    
    //콤보 초기화
    initComboStyle(LC_S_PWR_KIND_CD ,DS_LC_S_PWR_KIND_CD , "CODE^0^30,NAME^0^80", 1, PK); // [조회용]용도구분     

    //시스템 코드 공통코드에서 가지고 오기
    getEtcCode("DS_LC_S_PWR_KIND_CD",   "D", "M045", "N", "N", LC_S_PWR_KIND_CD );        // [조회/등록용]용도구분     M046
    DS_LC_S_PWR_KIND_CD.Filter();
    getEtcCode("DS_PWR_TYPE",           "D", "M047", "N");    // 전압구분     
    getEtcCode("DS_PWR_SEL_CHARGE",     "D", "M081", "N");    // 요금제구분     
    getEtcCode("DS_TIME_ZONE",          "D", "M050", "N");    // 시간대     
    LC_S_PWR_KIND_CD.Focus();
}

function gridCreate(gdGnb){
	//마스터그리드
	if (gdGnb == "MST") {
	    var hdrProperies = ''
	        + '<FC>ID={CURROW}         NAME="NO"'
	        + '                                            WIDTH=30    ALIGN=CENTER'
	        + '                                            BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
	        + '<FC>ID=PWR_KIND_CD      NAME="*용도구분"'
	        + '                                            WIDTH=90    ALIGN=LEFT  EDITSTYLE=LOOKUP   DATA="DS_LC_S_PWR_KIND_CD:CODE:NAME"'
	        + '                                            BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
	        + '<FC>ID=PWR_TYPE         NAME="*전압구분"'
	        + '                                            WIDTH=70    ALIGN=LEFT  EDITSTYLE=LOOKUP   DATA="DS_PWR_TYPE:CODE:NAME"'
	        + '                                            BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
	        + '<FC>ID=PWR_SEL_CHARGE   NAME="*요금제구분"'
	        + '                                            WIDTH=70    ALIGN=LEFT  EDITSTYLE=LOOKUP   DATA="DS_PWR_SEL_CHARGE:CODE:NAME"'
	        + '                                            BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
	        + '<FC>ID=TIME_ZONE        NAME="*시간대"'
	        + '                                            WIDTH=80    ALIGN=LEFT  EDITSTYLE=LOOKUP   DATA="DS_TIME_ZONE:CODE:NAME"'
	        + '                                            BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
	        + '<C>ID=BAS_PRC           NAME="*기본요금;(원/KWh)"'
	        + '                                            WIDTH=90    ALIGN=RIGHT EDIT=NUMERIC</C>'
	        + '<G>                     NAME="전력량요금(원/KWh)"'
	        + '<C>ID=UNIT_PRC_01       NAME="*1월"'
	        + '                                            WIDTH=80    ALIGN=RIGHT EDIT=REALNUMERIC</C>'
	        + '<C>ID=UNIT_PRC_02       NAME="*2월"'
	        + '                                            WIDTH=80    ALIGN=RIGHT EDIT=REALNUMERIC</C>'
	        + '<C>ID=UNIT_PRC_03       NAME="*3월"'
	        + '                                            WIDTH=80    ALIGN=RIGHT EDIT=REALNUMERIC</C>'
	        + '<C>ID=UNIT_PRC_04       NAME="*4월"'
	        + '                                            WIDTH=80    ALIGN=RIGHT EDIT=REALNUMERIC</C>'
	        + '<C>ID=UNIT_PRC_05       NAME="*5월"'
	        + '                                            WIDTH=80    ALIGN=RIGHT EDIT=REALNUMERIC</C>'
	        + '<C>ID=UNIT_PRC_06       NAME="*6월"'
	        + '                                            WIDTH=80    ALIGN=RIGHT EDIT=REALNUMERIC</C>'
	        + '<C>ID=UNIT_PRC_07       NAME="*7월"'
	        + '                                            WIDTH=80    ALIGN=RIGHT EDIT=REALNUMERIC</C>'
	        + '<C>ID=UNIT_PRC_08       NAME="*8월"'
	        + '                                            WIDTH=80    ALIGN=RIGHT EDIT=REALNUMERIC</C>'
	        + '<C>ID=UNIT_PRC_09       NAME="*9월"'
	        + '                                            WIDTH=80    ALIGN=RIGHT EDIT=REALNUMERIC</C>'
	        + '<C>ID=UNIT_PRC_10       NAME="*10월"'
	        + '                                            WIDTH=80    ALIGN=RIGHT EDIT=REALNUMERIC</C>'
	        + '<C>ID=UNIT_PRC_11       NAME="*11월"'
	        + '                                            WIDTH=80    ALIGN=RIGHT EDIT=REALNUMERIC</C>'
	        + '<C>ID=UNIT_PRC_12       NAME="*12월"'
	        + '                                            WIDTH=80    ALIGN=RIGHT EDIT=REALNUMERIC</C></G>'
	        ;   
	    initGridStyle(GD_MASTER, "COMMON", hdrProperies, true);
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
 * 작 성 일 : 2010.03.23
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if (DS_IO_MASTER.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
            var strPwrType  = LC_S_PWR_KIND_CD .BindColVal;    // [조회용]용도구분
            var goTo = "getMaster";
            var parameters = ""
                + "&strPwrType="    + encodeURIComponent(strPwrType);
            TR_MAIN.Action = "/mss/mren105.mr?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
            TR_MAIN.Post();
        
            // 조회결과 Return
            setPorcCount("SELECT", GD_MASTER);
        } else {
            return;
        }
    }  else {
        var strPwrType  = LC_S_PWR_KIND_CD .BindColVal;    // [조회용]용도구분
        var goTo = "getMaster";
        var parameters = ""
            + "&strPwrType="    + encodeURIComponent(strPwrType);
        TR_MAIN.Action = "/mss/mren105.mr?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();
    
        // 조회결과 Return
        setPorcCount("SELECT", GD_MASTER);
    }
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.23
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (DS_IO_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장
    
        //필수 입력값,스크립트 중복 값 체크
	    if (!checkValidate()) return;
    
        //DB중복값제크
        if (!checkValidateDB()) {
            showMessage(INFORMATION, OK, "USER-1000", "등록 된 내역과 겹치는 사용구간이 존재합니다."); 
            return; 
        }
        
      //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_MASTER.Focus();
            return;
        }
    
	    //저장
        var goTo = "save";
        TR_SAVE.Action = "/mss/mren105.mr?goTo=" + goTo;
        TR_SAVE.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
        TR_SAVE.Post();
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
}


/**
 * btn_AddRow()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : 행추가
 * return값 :
 */
function btn_AddRow() {
    DS_IO_MASTER.AddRow();
    GD_MASTER.SetColumn("PWR_KIND_CD");
}

/**
 * btn_DeleteRow()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : 행삭제
 * return값 :
 */
function btn_DeleteRow() {
	DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition); 
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
/**
 * checkValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.23
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidate() {
    // 필수 입력값 체크
    for (var n=1; n<=DS_IO_MASTER.CountRow; n++) {
        if (DS_IO_MASTER.RowStatus(n) != 0 ) {
            // 용도구분
            if (DS_IO_MASTER.NameValue(n,"PWR_KIND_CD") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("PWR_KIND_CD");
                showMessage(INFORMATION, OK, "USER-1002", "용도구분");
                return false;
            }

            // 전압구분
            if (DS_IO_MASTER.NameValue(n,"PWR_TYPE") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("PWR_TYPE");
                showMessage(INFORMATION, OK, "USER-1002", "전압구분");
                return false;
            }

            // 요금제구분
            if (DS_IO_MASTER.NameValue(n,"PWR_SEL_CHARGE") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("PWR_SEL_CHARGE");
                showMessage(INFORMATION, OK, "USER-1002", "요금제구분");
                return false;
            }
            
            // 시간대
            if (DS_IO_MASTER.NameValue(n,"TIME_ZONE") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("TIME_ZONE");
                showMessage(INFORMATION, OK, "USER-1002", "시간대");
                return false;
            }
            
            // 기본요금(원/KWh)
            if (DS_IO_MASTER.NameValue(n,"BAS_PRC") < 1) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("BAS_PRC");
                showMessage(INFORMATION, OK, "USER-1002", "기본요금(원/KWh)");
                return false;
            }
            
            // 전력량요금(원/KWh) 1월
            if (DS_IO_MASTER.NameValue(n,"UNIT_PRC_01") < 1) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("UNIT_PRC_01");
                showMessage(INFORMATION, OK, "USER-1002", "전력량요금(원/KWh) 1월");
                return false;
            }
            
            // 전력량요금(원/KWh) 2월
            if (DS_IO_MASTER.NameValue(n,"UNIT_PRC_02") < 1) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("UNIT_PRC_02");
                showMessage(INFORMATION, OK, "USER-1002", "전력량요금(원/KWh) 2월");
                return false;
            }
            
            // 전력량요금(원/KWh) 3월
            if (DS_IO_MASTER.NameValue(n,"UNIT_PRC_03") < 1) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("UNIT_PRC_03");
                showMessage(INFORMATION, OK, "USER-1002", "전력량요금(원/KWh) 3월");
                return false;
            }
            
            // 전력량요금(원/KWh) 4월
            if (DS_IO_MASTER.NameValue(n,"UNIT_PRC_04") < 1) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("UNIT_PRC_04");
                showMessage(INFORMATION, OK, "USER-1002", "전력량요금(원/KWh) 4월");
                return false;
            }
            
            // 전력량요금(원/KWh) 5월
            if (DS_IO_MASTER.NameValue(n,"UNIT_PRC_05") < 1) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("UNIT_PRC_05");
                showMessage(INFORMATION, OK, "USER-1002", "전력량요금(원/KWh) 5월");
                return false;
            }
            
            // 전력량요금(원/KWh) 6월
            if (DS_IO_MASTER.NameValue(n,"UNIT_PRC_06") < 1) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("UNIT_PRC_06");
                showMessage(INFORMATION, OK, "USER-1002", "전력량요금(원/KWh) 6월");
                return false;
            }
            
            // 전력량요금(원/KWh) 7월
            if (DS_IO_MASTER.NameValue(n,"UNIT_PRC_07") < 1) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("UNIT_PRC_07");
                showMessage(INFORMATION, OK, "USER-1002", "전력량요금(원/KWh) 7월");
                return false;
            }
            
            // 전력량요금(원/KWh) 8월
            if (DS_IO_MASTER.NameValue(n,"UNIT_PRC_08") < 1) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("UNIT_PRC_08");
                showMessage(INFORMATION, OK, "USER-1002", "전력량요금(원/KWh) 8월");
                return false;
            }
            
            // 전력량요금(원/KWh) 9월
            if (DS_IO_MASTER.NameValue(n,"UNIT_PRC_09") < 1) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("UNIT_PRC_09");
                showMessage(INFORMATION, OK, "USER-1002", "전력량요금(원/KWh) 9월");
                return false;
            }
            
            // 전력량요금(원/KWh) 10월
            if (DS_IO_MASTER.NameValue(n,"UNIT_PRC_010") < 1) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("UNIT_PRC_010");
                showMessage(INFORMATION, OK, "USER-1002", "전력량요금(원/KWh) 10월");
                return false;
            }
            
            // 전력량요금(원/KWh) 11월
            if (DS_IO_MASTER.NameValue(n,"UNIT_PRC_011") < 1) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("UNIT_PRC_011");
                showMessage(INFORMATION, OK, "USER-1002", "전력량요금(원/KWh) 11월");
                return false;
            }
            
            // 전력량요금(원/KWh) 12월
            if (DS_IO_MASTER.NameValue(n,"UNIT_PRC_012") < 1) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("UNIT_PRC_012");
                showMessage(INFORMATION, OK, "USER-1002", "전력량요금(원/KWh) 12월");
                return false;
            }
        }
    }
	 
	// 중복값 체크 
	for (var i=1; i<=DS_IO_MASTER.CountRow; i++) {
        var tmpChkKeyVal = "" //용도구분, 전압구분, 요금제구분, 시간대
            + "" + DS_IO_MASTER.NameValue(i, "PWR_KIND_CD")
            + "" + DS_IO_MASTER.NameValue(i, "PWR_TYPE")
            + "" + DS_IO_MASTER.NameValue(i, "PWR_SEL_CHARGE")
            + "" + DS_IO_MASTER.NameValue(i, "TIME_ZONE");
        for (var k=i+1; k<=DS_IO_MASTER.CountRow; k++) {
			if (DS_IO_MASTER.RowStatus(k) == 1 ) { //신규건 체크
	            var insChkKeyVal = "" //용도구분, 전압구분, 요금제구분, 시간대
	                + "" + DS_IO_MASTER.NameValue(k, "PWR_KIND_CD")
	                + "" + DS_IO_MASTER.NameValue(k, "PWR_TYPE")
	                + "" + DS_IO_MASTER.NameValue(k, "PWR_SEL_CHARGE")
	                + "" + DS_IO_MASTER.NameValue(k, "TIME_ZONE");
	            if (tmpChkKeyVal==insChkKeyVal) {
                    DS_IO_MASTER.RowPosition = k;
                    showMessage(INFORMATION, OK, "USER-1000", "["+i+"]번째 행과 신규행 ["+k+"]의 키값이 중복됩니다.");
                    return false;
	            }
			}
        }
	} 
	
    return true;
}

/**
 * checkValidateDB()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.23
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidateDB() {
	// 중복키값 색상초기화
	for (var j=1; j<=DS_IO_MASTER.CountRow; j++) {
	    DS_IO_MASTER.NameValue(j,"DUPCHK") = "N"; 
	}
	 
	var goTo = "getDupKeyValue";
	var parameters = "";
	TR_MAIN.Action = "/mss/mren105.mr?goTo=" + goTo + parameters;
	TR_MAIN.KeyValue = "SERVLET(O:DS_O_DUPKEYVALUE=DS_O_DUPKEYVALUE, I:DS_IO_MASTER=DS_IO_MASTER)";
	TR_MAIN.StatusResetType= "2"; //DS상태 초기화 하지 않음
	TR_MAIN.Post();
	
	if (DS_O_DUPKEYVALUE.CountRow < 1 ) {
	    return true;
	} else { 
	    for (var i=1; i<=DS_IO_MASTER.CountRow; i++) {
	        if (DS_IO_MASTER.RowStatus(i) == 1 ) { // 신규
	            var tmpKey = ""
                    + "" + DS_IO_MASTER.NameValue(k, "PWR_KIND_CD")
                    + "" + DS_IO_MASTER.NameValue(k, "PWR_TYPE")
                    + "" + DS_IO_MASTER.NameValue(k, "PWR_SEL_CHARGE")
                    + "" + DS_IO_MASTER.NameValue(k, "TIME_ZONE");
	            for (var k=1; k<=DS_O_DUPKEYVALUE.CountRow; k++) {
	                if (DS_O_DUPKEYVALUE.NameValue(k,"DUPVALUE") == tmpKey) {
	                    DS_IO_MASTER.NameValue(i,"DUPCHK") = "Y";
	                } 
	            }
	        }
	    }
	    return false;
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

<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
    }
    
    //저장 후 재 조회
    btn_Search();
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
  /*  showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_SAVE event=onFail>
    /*showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_SAVE.ErrorCode + "\n" + "ErrorMsg  : " + TR_SAVE.ErrorMsg);
    for(i=1;i<TR_SAVE.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_SAVE.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_SAVE.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
if (DS_IO_MASTER.RowStatus(row) == "1") {
    GD_MASTER.ColumnProp('PWR_KIND_CD',     'Edit') = "";   // 용도구분
    GD_MASTER.ColumnProp('PWR_TYPE',        'Edit') = "";   // 전압구분
    
    DS_TIME_ZONE.Filter(); // 시간대 필터링
    DS_PWR_TYPE.Filter();  // 전압구분
    if (DS_IO_MASTER.NameValue(row,"PWR_KIND_CD") == "12" ||
    	DS_IO_MASTER.NameValue(row,"PWR_KIND_CD") == "14" ||
    	DS_IO_MASTER.NameValue(row,"PWR_KIND_CD") == "17" ) { // 일반용(갑), 산업용(갑), 교육용
        GD_MASTER.ColumnProp('TIME_ZONE',   'Edit')   = "NONE";   // 시간대
    } else {
        GD_MASTER.ColumnProp('TIME_ZONE',   'Edit')   = "";       // 시간대
    }
    
    if (DS_IO_MASTER.NameValue(row,"PWR_TYPE") == "1") { //저압전력
        GD_MASTER.ColumnProp('PWR_SEL_CHARGE', 'Edit')  = "NONE";   // 요금제구분
    } else {
        GD_MASTER.ColumnProp('PWR_SEL_CHARGE', 'Edit')  = "";       // 요금제구분
    }
    
} else {
    GD_MASTER.ColumnProp('PWR_KIND_CD',     'Edit') = "NONE";   // 용도구분
    GD_MASTER.ColumnProp('PWR_TYPE',        'Edit') = "NONE";   // 전압구분
    GD_MASTER.ColumnProp('PWR_SEL_CHARGE',  'Edit') = "NONE";   // 요금제구분
    GD_MASTER.ColumnProp('TIME_ZONE',       'Edit') = "NONE";   // 시간대
}
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
//그리드 정렬기능
    sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=GD_MASTER event=OnCloseUp(row,colid)>
if (colid == "PWR_KIND_CD") {
//용도구분
	DS_TIME_ZONE.Filter(); // 시간대 필터링
	DS_PWR_TYPE.Filter();  // 전압구분
	if (DS_IO_MASTER.NameValue(row,"PWR_KIND_CD") == "12"||
	    DS_IO_MASTER.NameValue(row,"PWR_KIND_CD") == "14"||
        DS_IO_MASTER.NameValue(row,"PWR_KIND_CD") == "17") { //일반(갑),교육용, 산업(갑)
		GD_MASTER.ColumnProp('TIME_ZONE',   'Edit')   = "NONE";   // 시간대
		DS_IO_MASTER.NameValue(row,"TIME_ZONE")       = "00";     // 없음
	} else {
		GD_MASTER.ColumnProp('TIME_ZONE',   'Edit')   = "";       // 시간대
		DS_IO_MASTER.NameValue(row,"TIME_ZONE")       = "";
	}
} else  if (colid == "PWR_TYPE") {
//전압구분
	DS_PWR_SEL_CHARGE.Filter(); // 요금제구분 필터링

    if (DS_IO_MASTER.NameValue(row,"PWR_KIND_CD") == "12"||
        DS_IO_MASTER.NameValue(row,"PWR_KIND_CD") == "14"||
        DS_IO_MASTER.NameValue(row,"PWR_KIND_CD") == "17") { //일반(갑), 산업(갑)
        GD_MASTER.ColumnProp('TIME_ZONE',   'Edit')   = "NONE";   // 시간대
        DS_IO_MASTER.NameValue(row,"TIME_ZONE")       = "00";     // 없음
    } else {
        GD_MASTER.ColumnProp('TIME_ZONE',   'Edit')   = "";       // 시간대
        DS_IO_MASTER.NameValue(row,"TIME_ZONE")       = "";
    }
	
    if (DS_IO_MASTER.NameValue(row,"PWR_TYPE") == "1") { //저압전력
        GD_MASTER.ColumnProp('PWR_SEL_CHARGE', 'Edit')  = "NONE";   // 요금제구분
        DS_IO_MASTER.NameValue(row,"PWR_SEL_CHARGE")    = "0";      // 없음
    } else {
        GD_MASTER.ColumnProp('PWR_SEL_CHARGE', 'Edit')  = "";       // 요금제구분
        DS_IO_MASTER.NameValue(row,"PWR_SEL_CHARGE")    = "";       // 없음
    }
} else  if (colid == "PWR_SEL_CHARGE") {
// 요금제구분
	DS_PWR_SEL_CHARGE.Filter(); // 시간대 필터링
}

</script>

<script language=JavaScript for=DS_LC_S_PWR_KIND_CD event=OnFilter(row)>
// 용도구분
if (DS_LC_S_PWR_KIND_CD.NameValue(row,"CODE").substring(0,1) == "1") { 
    if (DS_LC_S_PWR_KIND_CD.NameValue(row,"CODE") == "11"||DS_LC_S_PWR_KIND_CD.NameValue(row,"CODE") == "18") return false; //가로등,주거용 제외
    return true;
} else { 
    return false;
}
</script>

<script language=JavaScript for=DS_PWR_TYPE event=OnFilter(row)>
// 전압구분 필터링
//DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PWR_TYPE") = "";
if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "12" ||
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "14" ||
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "17"	) { //용도구분이 일반용(갑),교육용,산업용(갑)
    if (DS_PWR_TYPE.NameValue(row,"CODE") == "4"||DS_PWR_TYPE.NameValue(row,"CODE") == "5") { // 고압C , 일반고압 제외
        return false;
    } else { 
        return true;
    }
} else if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "13" ||
		   DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "15") {//용도구분이 일반용(을),산업용(을)
    if (DS_PWR_TYPE.NameValue(row,"CODE") == "1"||DS_PWR_TYPE.NameValue(row,"CODE") == "4"||DS_PWR_TYPE.NameValue(row,"CODE") == "5") { // 저압, 고압C 일반고압 제외
        return false;
    } else { 
        return true;
    }
} else { // 산업용(병)
    if (DS_PWR_TYPE.NameValue(row,"CODE") == "1"||DS_PWR_TYPE.NameValue(row,"CODE") == "5") {  // 저압, 일반고압 제외
        return false;
    } else { 
        return true;
    }
}
</script>

<script language=JavaScript for=DS_PWR_SEL_CHARGE event=OnFilter(row)>
// 요금제구분
if (DS_PWR_SEL_CHARGE.NameValue(row,"CODE") == "A" || DS_PWR_SEL_CHARGE.NameValue(row,"CODE") == "B") {//A:갑(정액등),B:을(종량등) 제외
    return false;
} else if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "16") { // 용도구분이 산업용(병)
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_TYPE") == "2") { // 고압 A
	    if (DS_PWR_SEL_CHARGE.NameValue(row,"CODE") == "0"||DS_PWR_SEL_CHARGE.NameValue(row,"CODE") == "3") {//요금제 없음,선택III 제외
	        return false;
	    } else { 
	        return true;
	    }
	} else { // 고압 B,C
        if (DS_PWR_SEL_CHARGE.NameValue(row,"CODE") == "0") {//요금제 없음 제외
            return false;
        } else { 
            return true;
        }
	}
} else {
    if (DS_PWR_SEL_CHARGE.NameValue(row,"CODE") == "0"||DS_PWR_SEL_CHARGE.NameValue(row,"CODE") == "3") {//요금제 없음,선택III 제외
        return false;
    } else { 
        return true;
    }
}
</script>

<script language=JavaScript for=DS_TIME_ZONE event=OnFilter(row)>
// 시간대 필터링
DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"TIME_ZONE") = "";
if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "15") { //용도구분이 산업용(을)
    if ((DS_TIME_ZONE.NameValue(row,"CODE").substr(0,1)) == "2") { // 심야,주간,저녁
        return true;
    } else { 
        return false;
    }
} else if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "13" ||
		DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "16") {//용도구분이 일반용(을) 산업용(병)
    if ((DS_TIME_ZONE.NameValue(row,"CODE").substr(0,1)) == "1") { // 경,중,최대부하 
        return true;
    } else { 
        return false;
    }
} else {
    if (DS_TIME_ZONE.NameValue(row,"CODE") == "00") {
        return true;
    } else { 
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
<comment id="_NSID_"><object id="DS_IO_MASTER"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<comment id="_NSID_"><object id="DS_O_DUPKEYVALUE"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== ONLOAD용 -->
<!-- 필터사용 DATASET -->
<comment id="_NSID_">
<object id="DS_LC_S_PWR_KIND_CD"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_PWR_TYPE"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_PWR_SEL_CHARGE"  classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_TIME_ZONE"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>
<!-- =============== 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
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
						<th width="80" class="point">용도구분</th>
						<td ><comment id="_NSID_"> <object
							id=LC_S_PWR_KIND_CD  classid=<%=Util.CLSID_LUXECOMBO%>
							width="140" height=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
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
        <td align="right"><img id="IMG_ADD_ROW"
            style="vertical-align: middle;" src="/<%=dir%>/imgs/btn/add_row.gif"
            width="52" height="18" onclick="btn_AddRow();" hspace="2" /><img
            id="IMG_DEL_ROW" style="vertical-align: middle;"
            src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
            onclick="btn_DeleteRow();" /></td>
    </tr>
    <tr>
        <td height="3"></td>
    </tr>
	<tr valign="top">
		<td align="left">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr valign="top">
				<td><comment id="_NSID_"><OBJECT id=GD_MASTER
					width=100% height=483 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_IO_MASTER">
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

