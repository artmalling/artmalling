<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 도시가스요금표관리
 * 작 성 일 : 2010.03.25
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : MREN1060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 도시가스요금표관리
 * 이    력 : 2010.03.25 (김유완) 신규작성
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
 * 작 성 일 : 2010.03.25
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_GASPRC"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER");
    
    //그리드 초기화
    gridCreate("MST"); //마스터
    
    //콤보 초기화
    initComboStyle(LC_S_GAS_KIND_CD ,DS_S_GAS_KIND_CD , "CODE^0^30,NAME^0^80", 1, NORMAL);// [조회용]용도구분     
    initComboStyle(LC_S_GAS_KIND_DTL_CD ,DS_S_GAS_KIND_DTL_CD , "CODE^0^30,NAME^0^80", 1, NORMAL);    // [조회용]용도구분상세     
    initComboStyle(LC_S_AREA_FLAG ,DS_S_AREA_FLAG , "CODE^0^30,NAME^0^80", 1, NORMAL);    // [조회용]지역구분     
    //시스템 코드 공통코드에서 가지고 오기
    getEtcCode("DS_S_GAS_KIND_CD",     "D", "M045", "Y", "N", LC_S_GAS_KIND_CD );   // [조회용]용도구분   
    DS_S_GAS_KIND_CD.Filter();

    getEtcCode("DS_S_GAS_KIND_DTL_CD", "D", "M052", "Y", "N", LC_S_GAS_KIND_DTL_CD);// [조회용]용도구분상세  
    getEtcCode("DS_S_AREA_FLAG",       "D", "M080", "Y", "N", LC_S_AREA_FLAG);      // [조회용]지역구분
    getEtcCode("DS_GAS_KIND_CD",       "D", "M045", "N", "N");                      // 용도구분
    DS_GAS_KIND_CD.Filter();
    getEtcCode("DS_GAS_KIND_DTL_CD",   "D", "M052", "N", "N");                      // 용도구분상세
    getEtcCode("DS_AREA_FLAG",         "D", "M080", "N", "N");                      // 지역구분
    getEtcCode("DS_DATE_MM",           "D", "M100", "N");                           // 월
    LC_S_GAS_KIND_CD.Focus();
}

function gridCreate(gdGnb){
	//마스터그리드
	if (gdGnb == "MST") {
	    var hdrProperies = ''
	        + '<FC>ID={CURROW}         NAME="NO"'
	        + '                                            WIDTH=30    ALIGN=CENTER'
	        + '                                            BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
	        + '<FC>ID=GAS_KIND_CD      NAME="*용도구분"'
	        + '                                            WIDTH=100   ALIGN=LEFT  EDITSTYLE=LOOKUP   DATA="DS_GAS_KIND_CD:CODE:NAME"'
	        + '                                            BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
	        + '<FC>ID=GAS_KIND_DTL_CD  NAME="*용도상세구분"'
	        + '                                            WIDTH=130   ALIGN=LEFT  EDITSTYLE=LOOKUP   DATA="DS_GAS_KIND_DTL_CD:CODE:NAME"'
	        + '                                            BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
	        + '<FC>ID=AREA_FLAG        NAME="*지역"'
	        + '                                            WIDTH=70    ALIGN=LEFT  EDITSTYLE=LOOKUP   DATA="DS_AREA_FLAG:CODE:NAME"'
	        + '                                            BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
	        + '<FC>ID=SEQ              NAME="*SEQ"'
	        + '                                            WIDTH=70    ALIGN=LEFT  SHOW=FALSE</FC>'
	        + '<FC>ID=APP_S_MM         NAME="*적용월;(FROM)"'
	        + '                                            WIDTH=70    ALIGN=CENTER  EDITSTYLE=LOOKUP   DATA="DS_DATE_MM:CODE:NAME"'
	        + '                                            BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
	        + '<FC>ID=APP_E_MM         NAME="*적용월;(TO)"'
	        + '                                            WIDTH=70    ALIGN=CENTER  EDITSTYLE=LOOKUP   DATA="DS_DATE_MM:CODE:NAME"'
	        + '                                            BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
	        + '<FC>ID=BAS_PRC          NAME="*기본요금"'
	        + '                                            WIDTH=120   ALIGN=RIGHT  EDIT=REALNUMERIC</FC>'
	        + '<FC>ID=UNIT_PRC         NAME="*단가"'
	        + '                                            WIDTH=120   ALIGN=RIGHT  EDIT=REALNUMERIC</FC>'
	        + '<FC>ID=GAS_REDU1_PRC    NAME="사회배려경감"'
	        + '                                            WIDTH=120   ALIGN=RIGHT  EDIT=REALNUMERIC</FC>'
	        + '<FC>ID=GAS_REDU2_PRC    NAME="차상위계층경감"'
	        + '                                            WIDTH=120   ALIGN=RIGHT  EDIT=REALNUMERIC</FC>'
	        + '<FC>ID=DUPCHK           NAME="중복체크"'
	        + '                                            WIDTH=120   ALIGN=RIGHT  SHOW=FALSE</FC>'
	        ;   
	    initGridStyle(GD_MASTER, "COMMON", hdrProperies, true);
	    GD_MASTER.TitleHeight = 40;
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
 * 작 성 일 : 2010.03.25
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if (DS_IO_MASTER.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
            var strGasKind      = LC_S_GAS_KIND_CD .BindColVal;     // [조회용]용도구분
            var strGasKindDtl   = LC_S_GAS_KIND_DTL_CD .BindColVal; // [조회용]용도구분상세
            var strAreaFlag     = LC_S_AREA_FLAG .BindColVal;       // [조회용]지역구분
            var goTo = "getMaster";
            var parameters = ""
                + "&strGasKind="    + encodeURIComponent(strGasKind)
                + "&strGasKindDtl=" + encodeURIComponent(strGasKindDtl)
                + "&strAreaFlag="   + encodeURIComponent(strAreaFlag);
            TR_MAIN.Action = "/mss/mren106.mr?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
            TR_MAIN.Post();
        
            // 조회결과 Return
            setPorcCount("SELECT", GD_MASTER);
        } else {
            return;
        }
    }  else {
        var strGasKind      = LC_S_GAS_KIND_CD .BindColVal;     // [조회용]용도구분
        var strGasKindDtl   = LC_S_GAS_KIND_DTL_CD .BindColVal; // [조회용]용도구분상세
        var strAreaFlag     = LC_S_AREA_FLAG .BindColVal;       // [조회용]지역구분
        var goTo = "getMaster";
        var parameters = ""
            + "&strGasKind="    + encodeURIComponent(strGasKind)
            + "&strGasKindDtl=" + encodeURIComponent(strGasKindDtl)
            + "&strAreaFlag="   + encodeURIComponent(strAreaFlag);
        TR_MAIN.Action = "/mss/mren106.mr?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();
    
        // 조회결과 Return
        setPorcCount("SELECT", GD_MASTER);
    }
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.25
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (DS_IO_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장
    
        //필수 입력값,스크립트 중복 값 체크
	    if (!checkValidate()) return;
    
        //DB중복값제크
        /*
        if (!checkValidateDB()) {
            showMessage(INFORMATION, OK, "USER-1000", "등록 된 내역과 겹치는 적용월 구간이 존재합니다."); 
            return; 
        }*/
        
	  //변경또는 신규 내용을 저장하시겠습니까?
	    if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
	        GD_MASTER.Focus();
	        return;
	    }
    
	    //저장
        var goTo = "save";
        TR_SAVE.Action = "/mss/mren106.mr?goTo=" + goTo;
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
    GD_MASTER.SetColumn("GAS_KIND_CD");
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
 * getEtcCodeSub()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : 공통코드가져오기
 * return값 :
 */
function getEtcCodeSub(objDateSet, objCode) {
    var goTo = "getEtcCodeSub";
    var parameters = ""
        + "&strDSName="     + encodeURIComponent(objDateSet)
        + "&strEtcCode="    + encodeURIComponent(objCode);
    TR_MAIN.Action = "/mss/mren102.mr?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:"+objDateSet+"="+objDateSet+")";
    TR_MAIN.StatusResetType= "2";
    TR_MAIN.Post();
}
 

/**
 * setAutoMM()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.17
 * 개    요 : 사용월
 * return값 : maxToVal
 */
function setAutoMM(Row) {
	
    if (DS_IO_MASTER.NameValue(Row, "GAS_KIND_CD") == "" )    return;
    if (DS_IO_MASTER.NameValue(Row, "GAS_KIND_DTL_CD") == "" )     return;
    if (DS_IO_MASTER.NameValue(Row, "AREA_FLAG") == "" )  return;
    
    var maxToVal = 0;
    var strChkKeyVal  = ""
        + "" +DS_IO_MASTER.NameValue(Row, "GAS_KIND_CD")
        + "" +DS_IO_MASTER.NameValue(Row, "GAS_KIND_DTL_CD")
        + "" +DS_IO_MASTER.NameValue(Row, "AREA_FLAG");
    for (i=1; i<=DS_IO_MASTER.CountRow; i++) {
        if (i != Row) {
            var tmpChkKeyVal = ""
                + "" +DS_IO_MASTER.NameValue(i, "GAS_KIND_CD")
                + "" +DS_IO_MASTER.NameValue(i, "GAS_KIND_DTL_CD")
                + "" +DS_IO_MASTER.NameValue(i, "AREA_FLAG");
            if (strChkKeyVal == tmpChkKeyVal) {
                var tmpMaxToVal = eval(DS_IO_MASTER.NameValue(i, "APP_E_MM"));
                if (tmpMaxToVal > maxToVal) {
                    maxToVal = eval(tmpMaxToVal);
                }
            }
        }
    } 
    maxToVal = maxToVal + 1;  
    if (maxToVal < 10) {
    	maxToVal = "0" + maxToVal.toString(); 
    } else {
    	maxToVal = "" + maxToVal.toString(); 
    }
    
    if (eval(maxToVal) > 12) {
        DS_IO_MASTER.NameValue(Row, "APP_S_MM") = "";
    } else {
        DS_IO_MASTER.NameValue(Row, "APP_S_MM") = maxToVal;
    }
}

 
/**
 * checkValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.25
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidate() {
    // 필수 입력값 체크
    for (var n=1; n<=DS_IO_MASTER.CountRow; n++) {
        if (DS_IO_MASTER.RowStatus(n) != 0 ) {
            // 용도구분
            if (DS_IO_MASTER.NameValue(n,"GAS_KIND_CD") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("GAS_KIND_CD");
                showMessage(INFORMATION, OK, "USER-1002", "용도구분");
                return false;
            }

            // 용도상세구분
            if (DS_IO_MASTER.NameValue(n,"GAS_KIND_DTL_CD") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("GAS_KIND_DTL_CD");
                showMessage(INFORMATION, OK, "USER-1002", "용도상세구분");
                return false;
            }

            // 지역
            if (DS_IO_MASTER.NameValue(n,"AREA_FLAG") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("AREA_FLAG");
                showMessage(INFORMATION, OK, "USER-1002", "지역");
                return false;
            }
            
            // 적용월(FROM)
            if (DS_IO_MASTER.NameValue(n,"APP_S_MM") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("APP_S_MM");
                showMessage(INFORMATION, OK, "USER-1002", "적용월(FROM)");
                return false;
            }
            
            // 적용월(TO)
            if (DS_IO_MASTER.NameValue(n,"APP_E_MM") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("APP_E_MM");
                showMessage(INFORMATION, OK, "USER-1002", "적용월(TO)");
                return false;
            }
            
            // 적용월(FROM) ~ 적용월(TO)
            var strSmm = DS_IO_MASTER.NameValue(n,"APP_S_MM");
            var strEmm = DS_IO_MASTER.NameValue(n,"APP_E_MM");
            if (strSmm > strEmm) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("APP_S_MM");
                showMessage(INFORMATION, OK, "USER-1000", "적용월(FROM)은 적용월(TO) 이후 월은 등록 할 수 없습니다. ");
                return false;
            }
            
            // 기본요금
            if (DS_IO_MASTER.NameValue(n,"BAS_PRC") < 1) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("BAS_PRC");
                showMessage(INFORMATION, OK, "USER-1002", "기본요금");
                return false;
            }
            
            // 단가
            if (DS_IO_MASTER.NameValue(n,"UNIT_PRC") < 1) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("UNIT_PRC");
                showMessage(INFORMATION, OK, "USER-1002", "단가");
                return false;
            }
            
            // 사회배려경감
            /*
            if (DS_IO_MASTER.NameValue(n,"GAS_REDU1_PRC") < 1) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("GAS_REDU1_PRC");
                showMessage(INFORMATION, OK, "USER-1002", "사회배려경감");
                return false;
            }
            
            // 차장위계층경감
            if (DS_IO_MASTER.NameValue(n,"GAS_REDU2_PRC") < 1) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("GAS_REDU2_PRC");
                showMessage(INFORMATION, OK, "USER-1002", "차장위계층경감");
                return false;
            }*/
        }
    }
	 
	// 중복값 체크 
	for (var i=1; i<=DS_IO_MASTER.CountRow; i++) {
        var tmpChkKeyVal = "" //용도구분, 용도상세구분, 지역
            + "" + DS_IO_MASTER.NameValue(i, "GAS_KIND_CD")
            + "" + DS_IO_MASTER.NameValue(i, "GAS_KIND_DTL_CD")
            + "" + DS_IO_MASTER.NameValue(i, "AREA_FLAG");
        for (var k=i+1; k<=DS_IO_MASTER.CountRow; k++) {
			if (DS_IO_MASTER.RowStatus(k) == 1 || DS_IO_MASTER.RowStatus(k) == 3) { //신규,수정건 체크
	            var insChkKeyVal = "" //용도구분, 용도상세구분, 지역
	                + "" + DS_IO_MASTER.NameValue(k, "GAS_KIND_CD")
	                + "" + DS_IO_MASTER.NameValue(k, "GAS_KIND_DTL_CD")
	                + "" + DS_IO_MASTER.NameValue(k, "AREA_FLAG");
	            if (tmpChkKeyVal==insChkKeyVal) {
	                var immS = DS_IO_MASTER.NameValue(i, "APP_S_MM");
	                var immE = DS_IO_MASTER.NameValue(i, "APP_E_MM");
	                var kmmS = DS_IO_MASTER.NameValue(k, "APP_S_MM");
	                var kmmE = DS_IO_MASTER.NameValue(k, "APP_E_MM");
	                if (   // 적용월(FROM)
	                        (eval(immS) >= eval(kmmS) && eval(immS) <= eval(kmmE)) ||
	                        (eval(immE) >= eval(kmmS) && eval(immE) <= eval(kmmE)) 
	                       ||
	                       // 적용월(TO)
	                        (eval(kmmS) >= eval(immS) && eval(kmmS) <= eval(immE)) ||
	                        (eval(kmmE) >= eval(immS) && eval(kmmE) <= eval(immE)))  
	                   {
	                          DS_IO_MASTER.RowPosition = k;
	                          showMessage(INFORMATION, OK, "USER-1000", "["+i+"]번째 행의 사용량(구간)이  ["+k+"]번째 행의 사용량(구간)과 중복 됩니다.");
	                          return false;
	                   }
	            }
			}
        }
	} 
	
    return true;
}

/**
 * checkValidateDB()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.25
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
	TR_MAIN.Action = "/mss/mren106.mr?goTo=" + goTo + parameters;
	TR_MAIN.KeyValue = "SERVLET(O:DS_O_DUPKEYVALUE=DS_O_DUPKEYVALUE, I:DS_IO_MASTER=DS_IO_MASTER)";
	TR_MAIN.StatusResetType= "2"; //DS상태 초기화 하지 않음
	TR_MAIN.Post();
	
	if (DS_O_DUPKEYVALUE.CountRow < 1 ) {
	    return true;
	} else { 
	    for (var i=1; i<=DS_IO_MASTER.CountRow; i++) {
	        //if (DS_IO_MASTER.RowStatus(i) == 1 || DS_IO_MASTER.RowStatus(i) == 3) { // 신규,수정
	        if (DS_IO_MASTER.RowStatus(i) == 1) { // 신규
	            var tmpKey = ""
                    + "" + DS_IO_MASTER.NameValue(k, "GAS_KIND_CD")
                    + "" + DS_IO_MASTER.NameValue(k, "GAS_KIND_DTL_CD")
                    + "" + DS_IO_MASTER.NameValue(k, "AREA_FLAG")
                    + "" + DS_IO_MASTER.NameValue(k, "APP_S_MM");
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
	
/**
 * conVerGasKind()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.25
 * 개    요 : 가스 상세용도 필터하기 위한 용도 컨버젼
 * return값 :
 */
function conVerGasKind(gasKind) {
	var rtnGasKind = null;	 
 
	if (gasKind == "51" || gasKind == "52") {
		rtnGasKind = "0";	 
	} else if(gasKind == "53") {
        rtnGasKind = "1";    
    } else if(gasKind == "54") {
        rtnGasKind = "2";    
    } else if(gasKind == "55") {
        rtnGasKind = "3";    
    } else if(gasKind == "56") {
        rtnGasKind = "4";    
    } else  {
        rtnGasKind = "5";   
    }
	return rtnGasKind;
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
   /* showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
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
<script language=JavaScript for=DS_S_GAS_KIND_CD event=OnFilter(row)>
// 용도구분
if (DS_S_GAS_KIND_CD.NameValue(row,"CODE").substring(0,1) == "5" ||
	DS_S_GAS_KIND_CD.NameValue(row,"CODE").substring(0,1) == "%") { 
    return true;
} else { 
    return false;
}
</script>

<script language=JavaScript for=DS_GAS_KIND_CD event=OnFilter(row)>
// 용도구분
if (DS_GAS_KIND_CD.NameValue(row,"CODE").substring(0,1) == "5") { 
    return true;
} else { 
    return false;
}
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
if (DS_IO_MASTER.RowStatus(row) == "1") {
    GD_MASTER.ColumnProp('GAS_KIND_CD',     'Edit') = "";   // 용도구분
    // 용도상세구분
    if (DS_IO_MASTER.NameValue(row,"GAS_KIND_CD") == "51" || DS_IO_MASTER.NameValue(row,"GAS_KIND_CD") == "52") { //01 산업용 , 02 냉방용 
        GD_MASTER.ColumnProp('GAS_KIND_DTL_CD', 'Edit')  = "NONE";
    } else {
        GD_MASTER.ColumnProp('GAS_KIND_DTL_CD', 'Edit')  = "";
    }
    GD_MASTER.ColumnProp('AREA_FLAG',       'Edit') = "";   // 지역
    
} else {
    GD_MASTER.ColumnProp('GAS_KIND_CD',     'Edit') = "NONE";   // 용도구분
    GD_MASTER.ColumnProp('GAS_KIND_DTL_CD', 'Edit') = "NONE";   // 용도상세구분
    GD_MASTER.ColumnProp('AREA_FLAG',       'Edit') = "NONE";   // 지역
}

</script>

<script language=JavaScript for=DS_GAS_KIND_DTL_CD event=OnFilter(row)>
// 용도구분의 코드값에 따라 용도구분상세 필터링
if (DS_IO_MASTER.CountRow > 0) {
	var strGasKind = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAS_KIND_CD");
	if ( conVerGasKind(strGasKind) == DS_GAS_KIND_DTL_CD.NameValue(row,"CODE").substring(0, 1)) { 
	    return true;
	} else { 
	    return false;
	}
} 
</script>

<script language=JavaScript for=DS_S_GAS_KIND_DTL_CD event=OnFilter(row)>
// 용도구분의 코드값에 따라 용도구분상세 필터링
	var strGasKind = LC_S_GAS_KIND_CD.ValueOfIndex("CODE", LC_S_GAS_KIND_CD.Index);
	if (strGasKind == "%") {
		return true;
	} else {
	    if (DS_S_GAS_KIND_DTL_CD.NameValue(row,"CODE") == "%") {
	    	return true;		
	    } else {
	        if (conVerGasKind(strGasKind) == DS_S_GAS_KIND_DTL_CD.NameValue(row,"CODE").substring(0, 1)) { 
	            return true;
	        } else { 
	            return false;
	        }
	    }
	}
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=LC_S_GAS_KIND_CD event=OnSelChange()>
DS_S_GAS_KIND_DTL_CD.Filter();
DS_S_GAS_KIND_DTL_CD.SortExpr = "+" + "CODE";
DS_S_GAS_KIND_DTL_CD.Sort();
LC_S_GAS_KIND_DTL_CD.Index = 0;
</script>
 
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
//그리드 정렬기능
    sortColId( eval(this.DataID), row , colid );
</script>


<script language=JavaScript for=GD_MASTER event=OnCloseUp(row,colid)>
if (colid == "GAS_KIND_CD") {
	DS_GAS_KIND_DTL_CD.Filter();
	if (DS_IO_MASTER.NameValue(row,"GAS_KIND_CD") == "51" || DS_IO_MASTER.NameValue(row,"GAS_KIND_CD") == "52") { //01 산업용 , 02 냉방용 
		GD_MASTER.ColumnProp('GAS_KIND_DTL_CD', 'Edit')  = "NONE";
		DS_IO_MASTER.NameValue(row,"GAS_KIND_DTL_CD")  = "00";
	} else {
		GD_MASTER.ColumnProp('GAS_KIND_DTL_CD', 'Edit')  = "";
		DS_IO_MASTER.NameValue(row,"GAS_KIND_DTL_CD")  = "";
	}
setAutoMM(row);
} else if (colid == "GAS_KIND_DTL_CD") {
setAutoMM(row);
} else if (colid == "AREA_FLAG") {
setAutoMM(row);
} 
//월 자동입력
</script>

<script language=JavaScript for=DS_DATE_MM event=OnFilter(row)>
// [조회용]임대형태
if (DS_DATE_MM.NameValue(row,"CODE") == "00" ) { //없음제외
    return false;
} else { 
    return true;
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
<comment id="_NSID_"><object id="DS_S_GAS_KIND_CD"    classid=<%=Util.CLSID_DATASET%>><param name=UseFilter   value=true></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_S_AREA_FLAG"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_GAS_KIND_CD"      classid=<%=Util.CLSID_DATASET%>><param name=UseFilter   value=true></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_AREA_FLAG"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DATE_MM"          classid=<%=Util.CLSID_DATASET%>><param name=UseFilter   value=true></object></comment><script>_ws_(_NSID_);</script>
<!-- 필터사용 DATASET -->
<comment id="_NSID_">
<object id="DS_S_GAS_KIND_DTL_CD"  classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_GAS_KIND_DTL_CD"  classid=<%=Util.CLSID_DATASET%>>
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
						<th width="90">용도구분</th>
						<td width="145"><comment id="_NSID_"> <object
							id=LC_S_GAS_KIND_CD  classid=<%=Util.CLSID_LUXECOMBO%>
							width="140" height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="90">용도상세구분</th>
						<td width="145"><comment id="_NSID_"> <object
							id=LC_S_GAS_KIND_DTL_CD  classid=<%=Util.CLSID_LUXECOMBO%>
							width="140" height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="90">지역</th>
						<td ><comment id="_NSID_"> <object
							id=LC_S_AREA_FLAG  classid=<%=Util.CLSID_LUXECOMBO%>
							width="140" height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
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
					width=100% height=483 tabindex=1 classid=<%=Util.CLSID_GRID%>>
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

