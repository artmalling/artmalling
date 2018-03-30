<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 관리비청구/입금관리 >관리비입금내역등록
 * 작 성 일 : 2010.05.12
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : MREN405.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 관리비입금내역를 등록한다
 * 이    력 : 2010.05.12 (김유완) 신규작성
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
var g_currKey       = "S"; 
var g_autoFlag      = false;
var g_popProcess    = false;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit() {
    // 입력 Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_CALPAY"/>');
    DS_IO_MASTER_TMP.setDataHeader('<gauce:dataset name="H_SEL_MR_CALPAY_TMP"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER");

    //그리드 초기화
    gridCreate();

    // EMedit에 초기화
    initComboStyle(LC_S_STR_CD,DS_STR_CD,               "CODE^0^30,NAME^0^100", 1, PK);     // [조회용]시설구분
    initEmEdit(EM_S_CAL_SYM,                            "YYYYMM", PK);                      // [조회용]부과년월(STR)
    initEmEdit(EM_S_CAL_EYM,                            "YYYYMM", PK);                      // [조회용]부과년월(END)
    initEmEdit(EM_S_VEN_CD,                             "NUMBER3^6^0", NORMAL);             // [조회용]협력사
    initEmEdit(EM_S_VEN_NM,                             "GEN",    READ);                    // [조회용]협력사명
    initComboStyle(LC_S_RENT_TYPE,DS_RENT_TYPE,         "CODE^0^30,NAME^0^100", 1, NORMAL); // [조회용]임대형태
    initComboStyle(LC_STR_CD,DS_STR_CD,                 "CODE^0^30,NAME^0^100", 1, PK);     // 시설구분
    initEmEdit(EM_CAL_YM,                               "YYYYMM", PK);                      // 부과년월
    initEmEdit(EM_FILS_LOC,                             "GEN", READ);                       // EXCEL경로
    
    //콤보 초기화
    getFlc("DS_STR_CD",                                 "M", "1", "Y", "N");                // [조회용]시설구분  
    getEtcCode("DS_RENT_TYPE",                          "D", "P003", "Y");                  // [조회용]임대형태  
    LC_S_STR_CD.Focus();
    EM_S_CAL_SYM.Text = getTodayFormat("YYYYMM");
    EM_S_CAL_EYM.Text = getTodayFormat("YYYYMM");
    
    //등록 비활성화
    enableControl(IMG_FILE_SEARCH, false);  //Excel찾기버튼
    
    //종료시 데이터 변경 체크 (common.js )
    registerUsingDataset("mren405","DS_IO_MASTER" );
    /*EXCEL파일*/
    INF_EXCELUPLOAD.FileFilterString = 16; 
    
    LC_S_STR_CD.Index = 0;
    LC_STR_CD.BindColVal = LC_S_STR_CD.BindColVal;
}

/**
 * gridCreate("대상그리드")
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 그리드SET
 * return값 : void
 */
function gridCreate() {
    var hdrProperies = ''
        + '<FC>ID={CURROW}          NAME=NO'         
        + '                                         WIDTH=30    ALIGN=CENTER</FC>'
        + '<FC>ID=CAL_YM            NAME=부과년월'            
        + '                                         WIDTH=80    ALIGN=CENTER    MASK="XXXX/XX" EDIT=NONE    SUBSUMTEXT=""</FC>'
        + '<FC>ID=VEN_CD            NAME=*협력사코드'        
        + '                                         WIDTH=90    ALIGN=CENTER    EDIT=NUMERIC   EDITSTYLE=POPUP SUBSUMTEXT=""</FC>'
        + '<FC>ID=VEN_NM            NAME=협력사명'        
        + '                                         WIDTH=220   ALIGN=LEFT      EDIT=NONE</FC>'
        + '<FC>ID=PAY_DT            NAME=*입금일'            
        + '                                         WIDTH=100   ALIGN=CENTER    EDIT=NUMERIC    MASK="XXXX/XX/XX" EDITSTYLE=POPUP</FC>'
        + '<FC>ID=PAY_SEQ_NO        NAME=입금차수'            
        + '                                         WIDTH=60    ALIGN=CENTER    EDIT=NONE       SUBSUMTEXT="합계"</FC>'
        + '<FC>ID=REAL_CHAREG_AMT   NAME=총부과액'            
        + '                                         WIDTH=110   ALIGN=RIGTH     EDIT=NONE       </FC>'
        + '<FC>ID=REAL_MNTN         NAME=관리비'            
        + '                                         WIDTH=110   ALIGN=RIGTH     EDIT=NONE       SHOW=FALSE</FC>'
        + '<FC>ID=REAL_RENT         NAME=임대료'            
        + '                                         WIDTH=110   ALIGN=RIGTH     EDIT=NONE       SHOW=FALSE</FC>'
        + '<FC>ID=PAY_AMT           NAME=*관리비입금액'            
        + '                                         WIDTH=130   ALIGN=RIGTH     EDIT=NUMERIC    </FC>'
        + '<FC>ID=PAY_RENT_AMT      NAME=*임대료입금액'            
        + '                                         WIDTH=130   ALIGN=RIGTH     EDIT=NUMERIC    </FC>'
        + '<FC>ID=CNTR_ID           NAME=계약ID'        
        + '                                         WIDTH=70    ALIGN=CENTER    EDIT=NONE       SHOW=FALSE</FC>'
        ;
        initGridStyle(GD_MASTER, "COMMON", hdrProperies, true);
        //DS_IO_MASTER.SubSumExpr  = "1:CAL_YM:VEN_CD:REAL_CHAREG_AMT:REAL_MNTN:REAL_RENT" ;    
        DS_IO_MASTER.SubSumExpr  = "1:CAL_YM:CNTR_ID:REAL_CHAREG_AMT:REAL_MNTN:REAL_RENT" ;    
        
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
 * 작 성 일 : 2010.05.12
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
            TR_MAIN.Action = "/mss/mren405.mr?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
            TR_MAIN.Post();
            
            // 조회결과 Return
            setPorcCount("SELECT", DS_IO_MASTER.RealCount(1,DS_IO_MASTER.CountRow) );
            GD_MASTER.Focus();
            g_currKey = "S";
        } else {
            return;
        }
    }  else {
    	if (!checkValidateSearch()) return;
    	//입금등록관련 정산마감 관련 내역 초기화
        DS_IO_MASTER.ClearData();
        objectControlDefault(false);
        
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
		TR_MAIN.Action = "/mss/mren405.mr?goTo=" + goTo + parameters;
		TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
		TR_MAIN.Post();
        
        // 조회결과 Return
		setPorcCount("SELECT", DS_IO_MASTER.RealCount(1,DS_IO_MASTER.CountRow) );
		GD_MASTER.Focus();
        g_currKey = "S";
    }
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 초기화
 * return값 : void
 */
function btn_New() {
	//시설, 부과년월 선택체크
    if (!chkBfCloseYN()) return;
	    
	// 신규
	GD_MASTER.SetColumn("VEN_CD");
	DS_IO_MASTER.AddRow();
	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD") = LC_STR_CD.BindColVal;
	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CAL_YM") = EM_CAL_YM.Text;
	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_DT") = getTodayFormat("YYYYMMDD"); //입금일
	GD_MASTER.SetColumn("VEN_CD");

}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
	//시설, 부과년월 선택체크
	if (DS_IO_MASTER.CountRow > 0) {
		if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CLOSE_YN") == "TRUE")  {
			showMessage(INFORMATION, OK, "USER-1000", "해당건은 정산마감이 완료되어 삭제 할 수 없습니다.");
			return;
		}
	    DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
	}
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (DS_IO_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장
        //금액체크
        DS_IO_MASTER.Sortexpr = "+CNTR_ID";
        DS_IO_MASTER.Sort();
        DS_IO_MASTER.ResetSubsum();
        
        //필수 입력값 체크
        if (!checkValidateSave()) return;
        
        //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_MASTER.Focus();
            return;
        }
        //저장
        g_currKey = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CAL_YM")
					+"||"+DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD")
					+"||"+DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_DT")
					+"||"+DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_AMT");
        var goTo = "save";
        TR_SAVE.Action = "/mss/mren405.mr?goTo=" + goTo;
        TR_SAVE.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
        TR_SAVE.Post();
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
    } 
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    if (DS_IO_MASTER.CountRow > 0) {
        var ExcelTitle = "관리비입금내역등록"   
        
        var excel_strcd = LC_S_STR_CD.BindColVal;   // [조회용]시설구분
        var excel_sGoal = EM_S_CAL_SYM.Text;        // [조회용]부가년월FROM
        var excel_eGoal = EM_S_CAL_EYM.Text;        // [조회용]부가년월TO
        var excel_venCd = EM_S_VEN_NM.Text;         // [조회용]협력사명
        var excel_rentTp= LC_S_RENT_TYPE.BindColVal;// [조회용]임대형태
        
        var parameters = "시설구분="    +excel_strcd
                       + " - 부과년월=" + excel_sGoal + "~" + excel_eGoal
                       + " - 협력사="   +excel_venCd
                       + " - 임대형태=" +excel_rentTp;
        
        openExcel2(GD_MASTER, ExcelTitle, parameters, true );
        GD_MASTER.Focus();
    } else {
        showMessage(INFORMATION, OK, "USER-1000", "조회 후 가능합니다.");
    }
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
    	openCal('M',EM_CAL_YM);
    }
}

/**
 * chkBfCloseYN()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 마감여부체크
 * return값 :
 */
function chkBfCloseYN() {
    // 시설구분, 년월, 정산마감 시 신규 불가
    if (LC_STR_CD.BindColVal=="") {
        showMessage(INFORMATION, OK, "USER-1000", "관리비입금을 등록/삭제하려는 시설(구분)을 선택하세요");
        LC_STR_CD.Focus();
        return false;
    } 

    if (EM_CAL_YM.Text.replace(/^\s*|\s*$/g, "")=="") {
        showMessage(INFORMATION, OK, "USER-1000", "관리비입금을 등록/삭제하려는 년월을 입력하세요");
        EM_CAL_YM.Focus();
        return false;
    } 
    
    //마감체크 함수
    if (getCloseCheck("DS_CLOSE_YN", LC_STR_CD.BindColVal, EM_CAL_YM.Text, "MREN", "48", "0", "M") == "TRUE") {
        var strCalY     = (EM_CAL_YM.Text).substring(0,4);
        var strCalM     = (EM_CAL_YM.Text).substring(5,6);
        showMessage(INFORMATION, OK, "USER-1000", "선택한 시설의 "+strCalY+"년"+strCalM+"월은 이미 정산마감 되었습니다.");
        return false;
    } 
    
	return true;
}

/**
 * getCloseYN()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 마감여부체크
 * return값 :
 */
function getCloseYN() {
	//마감체크 함수(getCloseCheck)
	if (getCloseCheck("DS_CLOSE_YN", LC_STR_CD.BindColVal, EM_CAL_YM.Text, "MREN", "48", "0", "M") == "TRUE") {
	    objectControlDefault(false);
        var strCalY     = (EM_CAL_YM.Text).substring(0,4);
        var strCalM     = (EM_CAL_YM.Text).substring(5,6);
        showMessage(INFORMATION, OK, "USER-1000", "선택한 시설의 "+strCalY+"년"+strCalM+"월은 이미 정산마감 되었습니다.");
        //DS_IO_MASTER.ClearData();
	} else {
	    var strStrCd    = LC_STR_CD.BindColVal;    // 시설구분
	    var strCalSYM   = EM_CAL_YM.Text;          // 부과년월
	    var strCalEYM   = EM_CAL_YM.Text;          // 부과년월
	    var strRentType = "";  // 임대형태
	    var strVenCd    = "";  // 계약ID
	    var goTo = "getMaster";
	    var parameters = ""
	        + "&strStrCd="      + encodeURIComponent(strStrCd)
	        + "&strCalSYM="     + encodeURIComponent(strCalSYM)
	        + "&strCalEYM="     + encodeURIComponent(strCalEYM)
	        + "&strRentType="   + encodeURIComponent(strRentType)
	        + "&strVenCd="      + encodeURIComponent(strVenCd);
	    TR_MAIN.Action = "/mss/mren405.mr?goTo=" + goTo + parameters;
	    TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
	    TR_MAIN.Post();
	    
	    // 조회결과 Return
        setPorcCount("SELECT", DS_IO_MASTER.RealCount(1,DS_IO_MASTER.CountRow) );
        GD_MASTER.Focus();
		
        //DS_IO_MASTER.ClearData();
	    objectControlDefault(true);
	}
}

/**
 * checkValidateSearch()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 값체크
 * return값 :
 */
function checkValidateSearch() {
     if (LC_S_STR_CD.BindColVal == "") {
         showMessage(INFORMATION, OK, "USER-1000", "시설(구분)을 선택하세요");
         LC_S_STR_CD.Focus();
         return false;
     }
     
     if (EM_S_CAL_SYM.Text == "") {
         showMessage(INFORMATION, OK, "USER-1000", "부과년월(FROM) 입력 하세요");
         EM_S_CAL_SYM.Focus();
         return false;
     }
     
     if (EM_S_CAL_EYM.Text == "") {
         showMessage(INFORMATION, OK, "USER-1000", "부과년월(TO) 입력 하세요");
         EM_S_CAL_EYM.Focus();
         return false;
     }
     
     if (EM_S_CAL_EYM.Text < EM_S_CAL_SYM.Text) {
         showMessage(INFORMATION, OK, "USER-1000", "부과년월(TO)은 부과년월(FROM)이후로  입력 하세요");
         EM_S_CAL_EYM.Focus();
         return false;
     }

    return true;
}

/**
 * checkValidateSave()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 값체크
 * return값 :
 */
function checkValidateSave() {
    var strStrCd = LC_STR_CD.BindColVal;
    var strCalYM = EM_CAL_YM.Text;
    if (strStrCd == "") { // 시설구분 미등록시
        showMessage(STOPSIGN, OK, "USER-1002", "시설구분");
        LC_STR_CD.Focus();
        return false;
    }
    if (strCalYM == "") { // 부과년월 미입력시
        showMessage(STOPSIGN, OK, "USER-1003", "부과년월");
        EM_CAL_YM.Focus();
        return false;
    }
        
    for (var i=1; i<=DS_IO_MASTER.CountRow; i++) {
        if (DS_IO_MASTER.RowStatus(i) == 1 || DS_IO_MASTER.RowStatus(i) == 3 ) {
            // 협력사코드
            if (DS_IO_MASTER.NameValue(i,"VEN_CD") == "") {
                showMessage(STOPSIGN, OK, "USER-1000", "입력하신 협력사코드가 올바르지 않습니다.");
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("CNTR_ID");
                return false;
            }
            
            // 입금일
            if (DS_IO_MASTER.NameValue(i,"PAY_DT") == "") {
                showMessage(STOPSIGN, OK, "USER-1003", "입금일");
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("PAY_DT");
                return false;
            }
            
            // [관리비/임대료]입금액
            if ((DS_IO_MASTER.NameValue(i,"PAY_AMT") == "" || eval(DS_IO_MASTER.NameValue(i,"PAY_AMT")) < 1)
            		&& (DS_IO_MASTER.NameValue(i,"PAY_RENT_AMT") == "" || eval(DS_IO_MASTER.NameValue(i,"PAY_RENT_AMT")) < 1)) {
                showMessage(STOPSIGN, OK, "USER-1003", "(관리비/임대료) 입금액");
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("PAY_AMT");
                return false;
            }
        } else if (DS_IO_MASTER.RowStatus(i) == 4) {
            var strVenCd    = DS_IO_MASTER.NameValue((i-1),"VEN_NM")+"||"+DS_IO_MASTER.NameValue((i-1),"VEN_CD");  // 협력사코드/명
            var realAmt     = eval(DS_IO_MASTER.NameValue(i,"REAL_CHAREG_AMT"));    // 총청구금액
            var payAmt      = eval(DS_IO_MASTER.NameValue(i,"PAY_AMT")) + eval(DS_IO_MASTER.NameValue(i,"PAY_RENT_AMT")); //총입금금액
            var realMntnAmt = eval(DS_IO_MASTER.NameValue(i,"REAL_MNTN"));          // 관리비청구금액
            var payMntnAmt  = eval(DS_IO_MASTER.NameValue(i,"PAY_AMT"));            // 관리비입금금액
            var realRentAmt = eval(DS_IO_MASTER.NameValue(i,"REAL_RENT"));          // 임대료청구금액
            var payRentAmt  = eval(DS_IO_MASTER.NameValue(i,"PAY_RENT_AMT"));       // 임대료입금금액
            
            //관리비
            if (realMntnAmt < payMntnAmt) {
                DS_IO_MASTER.RowPosition = i-1;
                showMessage(STOPSIGN, OK, "USER-1000", "협력사["+strVenCd+"]의 관리비입금액("+payMntnAmt+"원)이 관리비청구액("+realMntnAmt+"원)보다 초과 입력되었습니다.");
                GD_MASTER.SetColumn("PAY_AMT");
                return false;
            }

            //임대료
            if (realRentAmt < payRentAmt) {
                DS_IO_MASTER.RowPosition = i-1;
                showMessage(STOPSIGN, OK, "USER-1000", "협력사["+strVenCd+"]의 임대료입금액("+payRentAmt+"원)이 임대료청구액("+realRentAmt+"원)보다 초과 입력되었습니다.");
                GD_MASTER.SetColumn("PAY_RENT_AMT");
                return false;
            }
            
            //총금액
            if (realAmt < payAmt) {
                DS_IO_MASTER.RowPosition = i-1;
                showMessage(STOPSIGN, OK, "USER-1000", "협력사["+strVenCd+"]의 입금액("+payAmt+"원)이 총부과액("+realAmt+"원)보다 초과 입력되었습니다.");
                GD_MASTER.SetColumn("PAY_AMT");
                return false;
            }
        } 
    }
    return true;
}

/**
 * loadExcelData()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : Excel파일 DateSet에 저장
 * return값 :
 */
function loadExcelData() {
     if (!chkBfCloseYN()) return;
     
	//Fils Open창
	INF_EXCELUPLOAD.Open();
	if (INF_EXCELUPLOAD.SelectState) {
	    //loadExcelData 옵션처리
	    var strExcelFileName = "'" + INF_EXCELUPLOAD.Value + "'"; //파일이름
	    if (strExcelFileName == "''") return;
	    EM_FILS_LOC.text = strExcelFileName;//경로명 표기
	    var strStartRow = 1;    // 시작Row
	    var strEndRow = 0;      // 끝Row
	    var strReadType = 0;    // 읽기모드
	    var strBlankCount = 3;  // 공백row개수
	    var strLFTOCR = 0;      // 줄바꿈처리 
	    var strFireEvent = 1;   // 이벤트발생
	    var strSheetIndex = 1;  // Sheet Index 추가
	    var strtrEtc = "1,0";   // 기타
	
	    var strOption = strExcelFileName
	        + "," + strStartRow + "," + strEndRow + "," + strReadType 
	        + "," + strBlankCount + "," + strLFTOCR + "," + strFireEvent
	        + "," + strSheetIndex + "," + strtrEtc;
	    //Excel파일 DateSet에 저장               
	    DS_IO_MASTER_TMP.ClearData();
	    DS_IO_MASTER_TMP.Do("Excel.Application", strOption);
	    var excelUpCnt =  DS_IO_MASTER_TMP.CountRow;
	    
	    g_autoFlag = true; //OnColumnChanged 이벤트 우회
	    GD_MASTER.Redraw = false;
	    var errCnt = 0;
        for (var i=1; i<=DS_IO_MASTER_TMP.CountRow; i++) {
        	DS_IO_MASTER.AddRow();
        	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CAL_YM") = EM_CAL_YM.Text;
        	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD") = DS_IO_MASTER_TMP.NameValue(i, "VEN_CD");
        	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_DT") = DS_IO_MASTER_TMP.NameValue(i, "PAY_DT");
        	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_AMT")= DS_IO_MASTER_TMP.NameValue(i, "PAY_AMT");
        	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_RENT_AMT")= DS_IO_MASTER_TMP.NameValue(i, "PAY_RENT_AMT");

            var strStrCd    = LC_STR_CD.BindColVal;                     //설치 시설
            var strVenCd    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");    //해당 위치의 입력 값
            var strCalYM    = EM_CAL_YM.Text; //부과년월
            getVenInfoNonPop( "DS_O_RESULT", strVenCd, "", strStrCd, strCalYM, "G", "N");
            if (DS_O_RESULT.CountRow == 1 ) {
            	if (DS_O_RESULT.NameValue(1, "PAY_FLAG") == "2") { // 입금완료
            		errCnt++;
            	} else {
                    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD")      = DS_O_RESULT.NameValue(1, "VEN_CD");  //협력사코드
                    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NM")      = DS_O_RESULT.NameValue(1, "VEN_NM");  //협력사명
                    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_ID")     = DS_O_RESULT.NameValue(1, "CNTR_ID"); //설치장소
                    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_CHAREG_AMT") = DS_O_RESULT.NameValue(1, "REAL_CHAREG_AMT");  //총부과액
                    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_MNTN")   = DS_O_RESULT.NameValue(1, "REAL_MNTN");  //총관리비부과액
                    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_RENT")   = DS_O_RESULT.NameValue(1, "REAL_RENT");  //총임대료부과액
                    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CAL_TYPE")    = DS_O_RESULT.NameValue(1, "CAL_TYPE");
            	}
            } else {
            	errCnt++;
            	DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
            }
        }
        //DS_IO_MASTER.ResetSubsum();
	    GD_MASTER.Redraw = true;
	    g_autoFlag = false;
	    
	    if (errCnt > 0) {
		    showMessage(INFORMATION, OK, "USER-1000", "총[ " +errCnt+"/"+excelUpCnt+" ]건의 협력사가(사유 : 코드오류/정산내역없음/입금완료 등) 제외 되었습니다." );
	    }
	} 
}

/**
 * objectControlDefault()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 관리비입금내역 등록 부 컨트롤
 * return값 :
 */
function objectControlDefault(objBoolean) {
	
    if (objBoolean) {
        GD_MASTER.ColumnProp('VEN_CD', 'Edit')  = "NUMERIC";// 계약ID
        GD_MASTER.ColumnProp('PAY_DT', 'Edit')  = "NUMERIC";// 입금일
        GD_MASTER.ColumnProp('PAY_AMT','Edit')  = "NUMERIC";// 관리비입금액
        GD_MASTER.ColumnProp('PAY_RENT_AMT','Edit')  = "NUMERIC";// 임대료입금액
        //이미지
        //enableControl(IMG_CAL_YM,true);
        enableControl(IMG_FILE_SEARCH,true);
    } else {
        GD_MASTER.ColumnProp('VEN_CD', 'Edit')  = "None";   // 계약ID
        GD_MASTER.ColumnProp('PAY_DT', 'Edit')  = "None";   // 입금일
        GD_MASTER.ColumnProp('PAY_AMT','Edit')  = "None";   // 관리비입금액
        GD_MASTER.ColumnProp('PAY_RENT_AMT','Edit')  = "None";// 임대료입금액
        EM_CAL_YM.Text = "";
        //이미지
        //enableControl(IMG_CAL_YM,false);
        enableControl(IMG_FILE_SEARCH,false);
    }
    EM_FILS_LOC.Text = "";
}

/**
 * getVenInfo()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 협력사 POP
 * return값 :
 */
function getVenInfo(  objCd, objNm, strFlc, strCalYM, gbnMulti) {
    var rtnArray = new Array();
    var arrArg   = new Array();
    var strCode = "";
    var strName = "";
    if (gbnMulti == "M" ) {
        strCode = objCd;
        strName = objNm;
    } else {
        if (typeof(objCd) == "object" ) {
            strCode = objCd.Text;
            strName = objNm.Text;
            //[Fix : 2010.04.11] 명을 기준 으로 올바른코드값 체크
            if (strName.length < 1) {
                objCd.Text = ""; 
                objNm.Text = "";
            }
        } else {
            strCode = objCd;
            strName = objNm;
        }
    }

    arrArg.push(rtnArray);
    arrArg.push(strCode);
    arrArg.push(strFlc);
    arrArg.push(strCalYM);
    arrArg.push(gbnMulti);

    var returnVal = window.showModalDialog("/mss/mren405.mr?goTo=callPopup",
                                           arrArg,
                                           "dialogWidth:520px;dialogHeight:408px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    if (returnVal){
        if (gbnMulti == "M") {
            var rt = arrArg[0];
            return rt;
        } else {
            var rt = arrArg[0][0];
            objCd.Text = rt.VEN_CD;
            objNm.Text = rt.VEN_NM;
            return rt;
        }
    }
}

/**
 * getVenInfoNonPop()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 협력사 POP
 * return값 :
 */

function getVenInfoNonPop( strDataSet, objCd, objNm, strFlc, strCalYM, mgGb, searchTp){
    if (typeof(objCd) == "object" ) {
        objNm.Text = "";//[Fix : 2010.04.11]코드기준검색
        if(trim(objCd.Text) == ""){
            return;
        } 
        strCode = objCd.Text;
        strName = objNm.Text;
    } else {
        if(trim(objCd) == ""){
            return;
        }
        strCode = objCd;
        strName = objNm;
    }
    
    var dataSetId = eval(strDataSet);
    var parameters = ""
        + "&strStrCd="     + encodeURIComponent(strFlc)
        + "&strCalYM="     + encodeURIComponent(strCalYM)
        + "&strVenCd="     + encodeURIComponent(strCode)
        + "&strCntrId="    + "";
    TR_MAIN.Action="/mss/mren405.mr?goTo=getVenInfo"+parameters;
    TR_MAIN.KeyValue="SERVLET(O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.CountRow == 1) {
        if (mgGb == "E") {
            objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "VEN_CD");
            objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "VEN_NM");    
        } 
        return dataSetId;
    }else{
        if(searchTp == "Y"){
        	return getVenInfo(  objCd, objNm, strFlc, strCalYM, "S");
        } else {
            return dataSetId;
        }
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
    
    //저장 후 조회    
    if (EM_CAL_YM.Text.replace(/^\s*|\s*$/g, "").length == 6) {
        //입금등록관련 정산마감 관련 내역 초기화
        // parameters
        LC_S_STR_CD.BindColVal  = LC_STR_CD.BindColVal;
        EM_S_CAL_SYM.Text       = EM_CAL_YM.Text;
        EM_S_CAL_EYM.Text       = EM_CAL_YM.Text;
        
        DS_IO_MASTER.ClearData();
        objectControlDefault(false);
    }

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
    TR_MAIN.Action = "/mss/mren405.mr?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
    TR_MAIN.Post();
    
    // 조회결과 Return
    DS_IO_MASTER.RowPosition = getNameValueRow(DS_IO_MASTER, "CAL_YM||VEN_CD||PAY_DT||PAY_AMT",g_currKey);
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

<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
if (colid == "VEN_CD") {
    //팝업입력은 제외
    if (g_autoFlag) return;
    
    if(DS_IO_MASTER.NameValue(row,"VEN_CD") == DS_IO_MASTER.OrgNameValue(row,"VEN_CD") && DS_IO_MASTER.SysStatus(row) != 1) return;
    if(DS_IO_MASTER.NameValue(row, "VEN_CD") == ""){
        DS_IO_MASTER.NameValue(row, "VEN_NM") = "";
        DS_IO_MASTER.NameValue(row, "CNTR_ID") = "";
        DS_IO_MASTER.NameValue(row, "REAL_CHAREG_AMT") = 0;
        DS_IO_MASTER.NameValue(row, "REAL_MNTN") = 0;
        DS_IO_MASTER.NameValue(row, "REAL_RENT") = 0;
        DS_IO_MASTER.NameValue(row, "CAL_TYPE") = "";
        return;
    }
    
    DS_IO_MASTER.NameValue(row, "VEN_NM") = "";
    DS_IO_MASTER.NameValue(row, "CNTR_ID") = "";
    DS_IO_MASTER.NameValue(row, "REAL_CHAREG_AMT") = 0;
    DS_IO_MASTER.NameValue(row, "REAL_MNTN") = 0;
    DS_IO_MASTER.NameValue(row, "REAL_RENT") = 0;
    DS_IO_MASTER.NameValue(row, "CAL_TYPE") = "";

    var strStrCd    = LC_STR_CD.BindColVal;                     //설치 시설
    var strVenCd    = DS_IO_MASTER.NameValue(row, "VEN_CD");    //해당 위치의 입력 값
    var strCalYM    = EM_CAL_YM.Text; //부과년월
    if (g_popProcess) return true;
    getVenInfoNonPop( "DS_O_RESULT", strVenCd, "", strStrCd, strCalYM, "G", "N");
    if (DS_O_RESULT.CountRow == 1 ) {
        if (DS_O_RESULT.NameValue(1, "PAY_FLAG") == "2") { // 입금완료
            setTimeout("GD_MASTER.SetColumn('VEN_CD')",50);
        	showMessage(INFORMATION, OK, "USER-1000", "해당협력사는 입금이 완료되어 추가 입금등록을 할 수 없습니다.");
            DS_IO_MASTER.NameValue(row, "VEN_CD") = "";
        } else {
	        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD")   = DS_O_RESULT.NameValue(1, "VEN_CD");  //협력사코드
	        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NM")   = DS_O_RESULT.NameValue(1, "VEN_NM");  //협력사명
	        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_ID")  = DS_O_RESULT.NameValue(1, "CNTR_ID"); //설치장소
	        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_CHAREG_AMT") = DS_O_RESULT.NameValue(1, "REAL_CHAREG_AMT");  //총부과액
	        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_MNTN") = DS_O_RESULT.NameValue(1, "REAL_MNTN");   //관리비부과액
	        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_RENT") = DS_O_RESULT.NameValue(1, "REAL_RENT");   //임대료부과액
	        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CAL_TYPE") = DS_O_RESULT.NameValue(1, "CAL_TYPE");
        }
    } else {
    	g_popProcess = true;
        var rt = getVenInfo(  strVenCd, "", strStrCd, strCalYM, "S");
        //1건 이외의 내역이 조회 시 팝업 호출
        if (rt == undefined) {
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD")  = "";           //협력사
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NM")  = "";           //협력사명
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_ID") = "";           //계약ID
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_CHAREG_AMT") = 0;    //총부과액
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_MNTN") = 0;          //관리비부과액
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_RENT") = 0;          //임대료부과액
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CAL_TYPE") = "";
        } else {
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD")  = rt.VEN_CD;    //협력사
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NM")  = rt.VEN_NM;    //협력사명
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_ID") = rt.CNTR_ID;   //계약ID
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_CHAREG_AMT") = rt.REAL_CHAREG_AMT;   //총부과액
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_MNTN") = rt.REAL_MNTN;   //관리비부과액
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_RENT") = rt.REAL_RENT;   //임대료부과액
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CAL_TYPE") = rt.CAL_TYPE;
        }
    	g_popProcess = false;
        return true;
    }
}
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=CanColumnPosChange(row,colid)>
if (colid == "PAY_DT") {
//입금일 일자체크
    if (DS_IO_MASTER.NameValue(row,colid) == "") {
        return true; 
    } else { 
        return checkDateTypeYMD(GD_MASTER, colid, DS_IO_MASTER.OrgNameValue(row,colid));
    }
} 
</script>

<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    if(colid == "PAY_DT"){
        openCal(this,row,colid);    
    } else if(colid == "VEN_CD"){
    	//계약ID 팝업호출
        if (row < 1) return;
        var strStrCd    = LC_STR_CD.BindColVal;                     //설치 시설
        var strVenCd    = DS_IO_MASTER.NameValue(row, "VEN_CD");    //해당 위치의 입력 값
        var strCalYM    = EM_CAL_YM.Text; //부과년월
        var rt = getVenInfo(  strVenCd, "", strStrCd, strCalYM, "S");
        
        if (rt == undefined) return;

        g_autoFlag = true; //onExit 이벤트 제외
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD")  = rt.VEN_CD;    //협력사
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NM")  = rt.VEN_NM;    //협력사명
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_ID") = rt.CNTR_ID;   //계약ID
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_CHAREG_AMT") = rt.REAL_CHAREG_AMT;   //총부과액
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_MNTN") = rt.REAL_MNTN;   //관리비부과액
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_RENT") = rt.REAL_RENT;   //임대료부과액
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CAL_TYPE") = rt.CAL_TYPE;
        g_autoFlag = false; //onExit 이벤트 제외 끝
    }
</script>

<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
//[조회용]시설구분 변경시
LC_S_RENT_TYPE.Index = 0;
</script>

<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
//시설구분 변경시
//마감여부체크
if (EM_CAL_YM.Text.replace(/^\s*|\s*$/g, "").length == 6) {
	getCloseYN();
}
</script>

<script language=JavaScript for=EM_CAL_YM event=OnKillFocus()>
// 마감여부체크
if(!this.Modified) return;
    
if (EM_CAL_YM.Text.replace(/^\s*|\s*$/g, "").length == 6) {
	getCloseYN();
} else {
	if (DS_IO_MASTER.IsUpdated) {
		objectControlDefault(false);
		DS_IO_MASTER.ClearData();
	}
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
<comment id="_NSID_"><object id="DS_IO_MASTER_TMP"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<!-- ===============- ONLOAD용 -->
<comment id="_NSID_"><object id="DS_STR_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_S_MR_MNTNITEM"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_RENT_TYPE"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSE_YN"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
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
<!--------------------- 3. Excelupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_EXCELUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
    <param name="Text" value='FileOpen'>
    <param name="Enable" value="true">
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
						<th width="120" class="point">시설구분</th>
						<td width="195"><comment id="_NSID_"><object
							id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="143"
							tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
						<th width="120" class="point">부과년월</th>
						<td><comment id="_NSID_"><object id=EM_S_CAL_SYM
							classid=<%=Util.CLSID_EMEDIT%> width="105" tabindex=1
							onblur="javascript:checkDateTypeYM(this);" align="absmiddle">
						</object></comment><script>_ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('M',EM_S_CAL_SYM);" /> ~ <comment
							id="_NSID_"><object id=EM_S_CAL_EYM
							classid=<%=Util.CLSID_EMEDIT%> width="105" tabindex=1
							onblur="javascript:checkDateTypeYM(this);" align="absmiddle">
						</object></comment><script>_ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('M',EM_S_CAL_EYM);" /></td>
					</tr>
					<tr>
						<th>임대형태</th>
						<td><comment id="_NSID_"> <object id=LC_S_RENT_TYPE
							classid=<%=Util.CLSID_LUXECOMBO%> width=143 tabindex=1
							align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script></td>
						<th>협력사</th>
						<td><comment id="_NSID_"> <object id=EM_S_VEN_CD
							classid=<%=Util.CLSID_EMEDIT%> width="70" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script><img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
                            onclick="javascript:callPopup('sVen');" align="absmiddle" /> <comment
							id="_NSID_"><object
							id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width="175"
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
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
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="s_table">
					<tr>
						<th width="60" class="point">시설구분</th>
						<td width="100"><comment id="_NSID_"><object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="95"
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
						<th width="60" class="point">부과년월</th>
						<td width="85"><comment id="_NSID_"><object
							id=EM_CAL_YM style="vertical-align: middle;"
							onblur="javascript:checkDateTypeYM(this);"
							classid=<%=Util.CLSID_EMEDIT%> width="60"></object></comment><script>_ws_(_NSID_);</script><img
							id="IMG_CAL_YM" style="vertical-align: middle;"
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:callPopup('cYM');" /></td>
						<th width="60">엑셀업로드</th>
						<td width="310"><comment id="_NSID_"><object
							id=EM_FILS_LOC style="vertical-align: middle;"
							classid=<%=Util.CLSID_EMEDIT%> width="230"></object></comment><script>_ws_(_NSID_);</script><img
							id="IMG_FILE_SEARCH" style="vertical-align: middle;"
							src="/<%=dir%>/imgs/btn/file_search.gif"
							onclick="javascript:loadExcelData();" /></td>
						<td width="75" align="center"><a
							href="/mss/samplefiles/calpayUpload.xls"> <img
							style="vertical-align: middle;"
							src="/<%=dir%>/imgs/btn/excel_down.gif" /></a></td>
					</tr>
				</table>
				</td>
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
					width="100%" height=445 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID"       value="DS_IO_MASTER">
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
