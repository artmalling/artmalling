<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 관리비정산
 * 작 성 일 : 2010.01.14
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : MREN3030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 월관리비를 등록한다
 * 이    력 : 2010.01.14(박래형) 신규작성
           2010.05.02(김유완) 수정작성
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
var g_rowPosition   = 1;
var g_DetailSave    = false;
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
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_MR_CALITEM"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER");
     
    gridCreate("MST"); //마스터
    gridCreate("DTL"); //관리비항목별 내역
    
    // Object 초기화
    initComboStyle(LC_S_STR_CD,DS_STR_CD,       "CODE^0^30,NAME^0^100", 1, PK);     // [조회용]시설구분
    initEmEdit(EM_S_CAL_YM,                     "YYYYMM", PK);                      // [조회용]부과년월
    initEmEdit(EM_S_VEN_CD,                     "NUMBER3^6^0", NORMAL);             // [조회용]협력사
    initEmEdit(EM_S_VEN_NM,                     "GEN",    READ);                    // [조회용]협력사명
    
    initComboStyle(LC_STR_CD,DS_STR_CD,         "CODE^0^30,NAME^0^100", 1, PK);     // 시설구분
    initEmEdit(EM_CAL_YM,                       "YYYYMM", PK);                      // 부과년월
    
    initEmEdit(EM_VEN_CD,                       "NUMBER3^6^0", READ);               // 협력사
    initEmEdit(EM_VEN_NM,                       "GEN",    READ);                    // 협력사명
    initComboStyle(LC_RENT_TYPE,DS_RENT_TYPE,   "CODE^0^30,NAME^0^100", 1, READ);   // 임대형태
    initComboStyle(LC_RENT_FLAG,DS_RENT_FLAG,   "CODE^0^30,NAME^0^100", 1, READ);   // 임대구분
    initEmEdit(EM_RENT_DEPOSIT,                 "NUMBER^12^0",  READ);              // 임대보증금
    initEmEdit(EM_MM_RENTFEE,                   "NUMBER^12^0",  READ);              // 임대료
    initEmEdit(EM_CNTR_S_DT,                    "YYYYMMDD",     READ);              // 계약기간(F)
    initEmEdit(EM_CNTR_E_DT,                    "YYYYMMDD",     READ);              // 계약기간(T)

    initEmEdit(EM_RENT_NOVAT_AMT,             	"NUMBER^10^0",  READ);              // [당월]임대료VAT(제외)
    initEmEdit(EM_RENT_VAT_AMT,                 "NUMBER^10^0",  READ);              // [당월]임대료vat(금액)
    initEmEdit(EM_RENT_AMT,                     "NUMBER^10^0",  READ);              // [당월]임대료VAT(포함)
    initEmEdit(EM_TAX_NOVAT_AMT,             	"NUMBER^10^0",  READ);              // [당월]과세관리비VAT(제외)
    initEmEdit(EM_TAX_VAT_AMT,                  "NUMBER^10^0",  READ);              // [당월]과세관리비VAT(금액)
    initEmEdit(EM_TAX_AMT,                      "NUMBER^10^0",  READ);              // [당월]과세관리비VAT(포함)
    initEmEdit(EM_NTAX_AMT,                     "NUMBER^10^0",  READ);              // [당월]면세관리비
    initEmEdit(EM_BAL_AMT,                      "NUMBER^10^0",  READ);              // [미수]관리비
    initEmEdit(EM_ARREAR_AMT,                   "NUMBER^10^0",  READ);              // [미수]연체이자
    //initEmEdit(EM_MOD_AMT,                      "NUMBER^10^0",  NORMAL);          // [조정]조정금액
    initComboStyle(LC_MOD_REASON,DS_MOD_REASON, "CODE^0^30,NAME^0^100", 1, NORMAL); // [조정]조정사유
    initEmEdit(EM_REAL_CHAREG_AMT,              "NUMBER^10^0",  READ);              // 청구액
    
    initEmEdit(EM_RENT_BAL_AMT,                 "NUMBER^10^0",  READ);              //정산 미수임대료
    initEmEdit(EM_MOD_ARREAR_AMT,               "NUMBER^10^0",  NORMAL);            //조정_미수관리비연체이자
    initEmEdit(EM_RENT_ARREAR_AMT,              "NUMBER^10^0",  READ);              //정산_미수임대료연체이자
    initEmEdit(EM_MOD_RENT_ARREAR_AMT,          "NUMBER^10^0",  NORMAL);          	//조정_미수임대료연체이자
    initEmEdit(EM_RENT_REAL_CHAREG_AMT,         "NUMBER^10^0",  READ);             	//임대료청구액   
    
    getFlc("DS_STR_CD",                         "M", "1", "Y", "N");                // 시설구분  
    LC_S_STR_CD.index = 0;                   
    LC_STR_CD.index = 0;                   
    LC_S_STR_CD.Focus();   
    EM_S_CAL_YM.Text = getTodayFormat("YYYYMM");
    enableControl(IMG_MAIN_COST,false);//관리비정산
    //enableControl(IMG_RE_FEE,false);//관리비정산
    //EM_MOD_AMT.Enable      = false;
    LC_MOD_REASON.Enable   = false;
    
    getEtcCode("DS_RENT_TYPE",                  "D", "P003", "N");                  // 임대형태      
    getEtcCode("DS_RENT_FLAG",                  "D", "P084", "N");                  // 임대구분      
    getEtcCode("DS_MOD_REASON",                 "D", "M098", "N");                  // 조정사유      
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
            + '<FC>ID={CURROW}               NAME=NO'         
            + '                                     WIDTH=30    ALIGN=CENTER</FC>'
            + '<FC>ID=VEN_CD                 NAME=협력사코드'            
            + '                                     WIDTH=80    ALIGN=CENTER</FC>'
            + '<FC>ID=VEN_NM                 NAME=협력사명'        
            + '                                     WIDTH=130   ALIGN=LEFT </FC>'
            + '<FC>ID=MOD_ARREAR_AMT         NAME=조정_미수연체이자(관리비)'        
            + '                                     WIDTH=130   ALIGN=LEFT SHOW="FALSE" </FC>'
            + '<FC>ID=MOD_TOT_BAL_AMT        NAME=조정_미수합계(관리비)'        
            + '                                     WIDTH=130   ALIGN=LEFT SHOW="FALSE" </FC>'
            + '<FC>ID=RENT_BAL_AMT           NAME=정산_미수임대료'        
            + '                                     WIDTH=130   ALIGN=LEFT SHOW="FALSE" </FC>'
            + '<FC>ID=RENT_ARREAR_AMT        NAME=정산_미수연체이자(임대료)'        
            + '                                     WIDTH=130   ALIGN=LEFT SHOW="FALSE" </FC>'
            + '<FC>ID=RENT_TOT_BAL_AMT       NAME=정산_미수합계(임대료)'        
            + '                                     WIDTH=130   ALIGN=LEFT SHOW="FALSE" </FC>'
            + '<FC>ID=MOD_RENT_ARREAR_AMT    NAME=조정_미수연체이자(임대료)'        
            + '                                     WIDTH=130   ALIGN=LEFT SHOW="FALSE" </FC>'
            + '<FC>ID=MOD_RENT_TOT_BAL_AMT   NAME=조정_미수합계(임대료)'        
            + '                                     WIDTH=130   ALIGN=LEFT SHOW="FALSE" </FC>'
            + '<FC>ID=RENT_REAL_CHAREG_AMT   NAME=정산_청구액(임대료)'        
            + '                                     WIDTH=130   ALIGN=LEFT SHOW="FALSE" </FC>'
            ;
            initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
    } else {
        
        var hdrProperies = ''
            + '<FC>ID={CURROW}      NAME=NO'         
            + '                                     WIDTH=30    ALIGN=CENTER  EDIT=NONE</FC>'
            + '<FC>ID=MNTN_ITEM_NM  NAME=관리항목'            
            + '                                     WIDTH=80    ALIGN=LEFT  EDIT=NONE sumtext="합계"</FC>'
            + '<FC>ID=USE_QTY       NAME=사용량'        
            + '                                     WIDTH=100   ALIGN=RIGHT EDIT=NONE SHOW="FALSE"</FC>'
            + '<FC>ID=USE_AMT       NAME=금액'        
            + '                                     WIDTH=100   ALIGN=RIGHT EDIT=NONE sumtext=@sum</FC>'
            + '<FC>ID=MOD_USE_AMT   NAME=조정금액'        
            + '                                     WIDTH=100   ALIGN=RIGHT EDIT=NUMERIC SHOW="FALSE"</FC>'
            ;
            initGridStyle(GD_DETAIL, "COMMON", hdrProperies, true);
            
            //합계표시
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
 * 작 성 일 : 2010.05.02
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if (DS_IO_MASTER.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
        	// 마감체크
            //getCloseYN("search");
            
            // parameters
            var strStrCd    = LC_S_STR_CD.BindColVal;      // [조회용]시설구분(점코드)
            var strCalYM    = EM_S_CAL_YM.Text;            // [조회용]부과년월            
            var strVenCd    = EM_S_VEN_CD.Text;            // [조회용]협력사
                        
            var goTo = "getMaster";
            var parameters = ""
                + "&strStrCd="      + encodeURIComponent(strStrCd)
                + "&strCalYM="      + encodeURIComponent(strCalYM)
                + "&strVenCd="      + encodeURIComponent(strVenCd);
            TR_MAIN.Action = "/mss/mren303.mr?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
            TR_MAIN.Post();
            //마감조회
            // 조회결과 Return
            setPorcCount("SELECT", GD_MASTER);
        } else {
            return;
        }
    }  else {
		// 마감체크
		//getCloseYN("search");
        
        // parameters
        var strStrCd    = LC_S_STR_CD.BindColVal;   // [조회용]시설구분(점코드)
        var strCalYM    = EM_S_CAL_YM.Text;         // [조회용]부과년월        
        var strVenCd    = EM_S_VEN_CD.Text;         // [조회용]협력사
              
        var goTo = "getMaster";
        var parameters = ""
            + "&strStrCd="      + encodeURIComponent(strStrCd)
            + "&strCalYM="      + encodeURIComponent(strCalYM)
            + "&strVenCd="      + encodeURIComponent(strVenCd);
        TR_MAIN.Action = "/mss/mren303.mr?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();
        //마감조회
        // 조회결과 Return
        setPorcCount("SELECT", GD_MASTER);
    }
    
    if (DS_IO_MASTER.CountRow < 1) {
    	DS_O_DETAIL.ClearData();
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
    
    if (DS_IO_MASTER.CountRow >= g_rowPosition ) {
    	DS_IO_MASTER.RowPosition = g_rowPosition;    	
    }
    g_rowPosition = 1;
    

    getCloseYN("search");
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
 * 작 성 일 : 2010.05.02
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_O_DETAIL.DeleteRow(DS_O_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.02
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	//저장 시  CanRowPosChange 이벤트 우회 flag
	g_saveFlag = true; 
    if (DS_IO_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장
        //필수 입력값 체크
        if (!checkValidate()) {
        	g_saveFlag = false;
            return;
        }
    	
        //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_MASTER.Focus();
            g_saveFlag = false;
            return;
        }
        
        g_currKey = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");
        
        var goTo = "save";
        TR_SAVE.Action = "/mss/mren303.mr?goTo=" + goTo;
        TR_SAVE.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
        TR_SAVE.Post();
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
    } 
    
    g_saveFlag = false;
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.02
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.02
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010.05.02
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * detailSave()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.05.02
  * 개    요 : DB에 저장 / 수정 / 삭제 처리
  * return값 : void
  */
 function detailSave() {
     if (DS_O_DETAIL.IsUpdated) {//변경 데이터가 있을때만 저장
         //필수 입력값 체크
         /*if (!checkValidate()) {
         	g_saveFlag = false;
             return;
         }*/
    	 if(EM_CAL_YM.Text.length < 6){
      		showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "부과년월");
      		EM_CAL_YM.Focus();
              return;
      	}
         
         //변경또는 신규 내용을 저장하시겠습니까?
         if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
             GD_DETAIL.Focus();
             //g_saveFlag = false;
             return;
         }
         
         g_rowPosition = DS_IO_MASTER.RowPosition;
         
         var strStrCd    = LC_STR_CD.BindColVal;     // 시설구분(점코드)
         var strFclFlag  = LC_STR_CD.ValueOfIndex("FCL_FLAG", LC_STR_CD.Index);     // 시설코드 (1,2,3,4:오피스,5,6) 
         var strCalYM    = EM_CAL_YM.Text;           // 부과년월
         var strCalY     = strCalYM.substring(0,4);
         var strCalM     = strCalYM.substring(4,6);
         alert(strCalM);
         return;
         var strCntrId   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_ID");    // 계약ID
         
         //g_currKey = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");
         
         var goTo = "detailSave";
         var parameters = "&strStrCd="      + encodeURIComponent(strStrCd)
         				+ "&strFclFlag="    + encodeURIComponent(strFclFlag)
         				+ "&strCalYM="      + encodeURIComponent(strCalYM)
         				+ "&strCntrId="     + encodeURIComponent(strCntrId);
         
         TR_SAVE.Action = "/mss/mren303.mr?goTo=" + goTo + parameters;
         TR_SAVE.KeyValue = "SERVLET(I:DS_O_DETAIL=DS_O_DETAIL)";
         TR_SAVE.Post();
         
         
      // 정상 처리일 경우 조회
         if( TR_SAVE.ErrorCode == 0){        
        	 //enableControl(IMG_RE_FEE ,true);
         }
     } else {
         showMessage(INFORMATION, OK, "USER-1028");
     } 
     
     //g_saveFlag = false;
 }
 
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
    }
}

/**
 * getCloseYN()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 마감여부체크
 * return값 :
 */
function getCloseYN(locFlag) {

	var strStrCd      = LC_STR_CD.BindColVal;       // 시설구분
	var strCalYM      = EM_CAL_YM.Text;               // 부과년월(입력)	   
	
	if (locFlag == "search") {

		strCalYM      = EM_S_CAL_YM.Text;               // 부과년월(입력)	
 
        //마감체크
        if (getCalCheck("DS_O_CALCHECK", strStrCd, strCalYM, "2") == "TRUE") { 	
            //EM_MOD_AMT.Enable      = false;
            LC_MOD_REASON.Enable   = false;
            EM_MOD_ARREAR_AMT.Enable   = false;
            EM_MOD_RENT_ARREAR_AMT.Enable   = false;
        } else {
        	if (getCalCheck("DS_O_CALCHECK", strStrCd, strCalYM, "3") == "TRUE") { 	
                //EM_MOD_AMT.Enable      = false;
                LC_MOD_REASON.Enable   = false;
                EM_MOD_ARREAR_AMT.Enable   = false;
                EM_MOD_RENT_ARREAR_AMT.Enable   = false;
        	} else {
	            //EM_MOD_AMT.Enable      = true;
	            LC_MOD_REASON.Enable   = true;
	            EM_MOD_ARREAR_AMT.Enable   = true;
	            EM_MOD_RENT_ARREAR_AMT.Enable   = true;
        	}
        }
	} else {
	    //마감체크 
	    if (getCalCheck("DS_O_CALCHECK", strStrCd, strCalYM, "2") == "TRUE") { 	
	    	enableControl(IMG_MAIN_COST,false);//관리비정산
	    	
	        showMessage(STOPSIGN, OK, "USER-1000", "익월이 정산되어 재정산 불가능합니다.");    	
	       
            //var strCalY     = (EM_CAL_YM.Text).substring(0,4);
            //var strCalM     = (EM_CAL_YM.Text).substring(4,6);
            //showMessage(INFORMATION, OK, "USER-1000", "선택한 시설의 "+strCalY+"년"+strCalM+"월은 이미 정산마감 되었습니다.");
            return true;
        } else {
        	if (getCalCheck("DS_O_CALCHECK", strStrCd, strCalYM, "3") == "TRUE") { 	
    	    	enableControl(IMG_MAIN_COST,false);//관리비정산
    	        showMessage(STOPSIGN, OK, "USER-1000", "정산월의 당월입금내역이 존재합니다. 재정산 불가능합니다.");    	
    	    	return;
    	   	}  else {
    	   		
	            enableControl(IMG_MAIN_COST,true);//관리비정산
	            //enableControl(IMG_RE_FEE,true);//관리비재정산
	            return false;
    	   	}
        }	
	}
}

 /**
 * procCalculate()
 * 작 성 자 : 
 * 작 성 일 : 2010.05.02
 * 개    요 : 관리비정산
 * return값 : void
 */
function procCalculate() {
    var strStrCd    = LC_STR_CD.BindColVal;     // 시설구분(점코드)
    var strFclFlag  = LC_STR_CD.ValueOfIndex("FCL_FLAG", LC_STR_CD.Index);     // 시설코드 (1,2,3,4:오피스,5,6) 
    var strCalYM    = EM_CAL_YM.Text;           // 부과년월
    var strCalY     = strCalYM.substring(0,4);
    var strCalM     = strCalYM.substring(4,6);
    var strCalFlag  = RD_CAL_FLAG.CodeValue;
    
    var strFlag = "";
    if(strCalFlag == "1"){
    	strFlag = "임대료";
    }else{
    	strFlag = "관리비";
    }
    
     
    //관리비정산
    if( showMessage(INFORMATION, YESNO, "USER-1000", "이미 등록된 정보는 삭제되고 재생성됩니다."+strCalY+"년"+strCalM+"월 " +strFlag+ " 정산을 실행하시겠습니까?") != 1 ){
        return;
    }
    //조회조건동기화
    LC_S_STR_CD.BindColVal = LC_STR_CD.BindColVal;
    EM_S_CAL_YM.Text = EM_CAL_YM.Text;
    
    var goTo = "procCalculate";
    var parameters = ""
        + "&strStrCd="      + encodeURIComponent(strStrCd)
        + "&strFclFlag="    + encodeURIComponent(strFclFlag)
        + "&strCalYM="      + encodeURIComponent(strCalYM)
        + "&strCalFlag="    + encodeURIComponent(strCalFlag)
        + "&strVenCd=";
    TR_CAL.Action = "/mss/mren303.mr?goTo=" + goTo + parameters;
    TR_CAL.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
    TR_CAL.Post();
    
    setPorcCount("SELECT", GD_MASTER);
}
 
/**
 * reProcCalculate()
 * 작 성 자 : 
 * 작 성 일 : 2010.05.02
 * 개    요 : 관리비재정산
 * return값 : void

function reProcCalculate() {
	if(EM_CAL_YM.Text.length < 6){
		showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "부과년월");
		EM_CAL_YM.Focus();
        return;
	}
    var strStrCd    = LC_STR_CD.BindColVal;     // 시설구분(점코드)
    var strFclFlag  = LC_STR_CD.ValueOfIndex("FCL_FLAG", LC_STR_CD.Index);     // 시설코드 (1,2,3,4:오피스,5,6) 
    var strCalYM    = EM_CAL_YM.Text;           // 부과년월
    var strCalY     = strCalYM.substring(0,4);
    var strCalM     = strCalYM.substring(4,6);
    var strCntrId   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_ID");    // 계약ID
         
    //관리비정산
    if( showMessage(INFORMATION, YESNO, "USER-1000", "이미 등록된 정보는 삭제되고 재생성됩니다."+strCalY+"년"+strCalM+"월 관리비 정산을 실행하시겠습니까?") != 1 ){
        return;
    }
    //조회조건동기화
    LC_S_STR_CD.BindColVal = LC_STR_CD.BindColVal;
    EM_S_CAL_YM.Text = EM_CAL_YM.Text;
    
    var goTo = "reProcCalculate";
    var parameters = "&strStrCd="      + encodeURIComponent(strStrCd)
                   + "&strFclFlag="    + encodeURIComponent(strFclFlag)
                   + "&strCalYM="      + encodeURIComponent(strCalYM)
                   + "&strCntrId="     + encodeURIComponent(strCntrId);
    
    TR_CAL.Action = "/mss/mren303.mr?goTo=" + goTo + parameters;
    TR_CAL.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
    TR_CAL.Post();
    
 // 정상 처리일 경우 조회
    if( TR_CAL.ErrorCode == 0){        
    	//enableControl(IMG_RE_FEE,false);
    }
    
    setPorcCount("SELECT", GD_MASTER);
}
 */
/**
 * getDetail()
 * 작 성 자 : 
 * 작 성 일 : 2010.05.02
 * 개    요 : 관리비항목별 내역 조회(상세)
 * return값 : void
 */
function getDetail(row) {
    var strStrCd    = DS_IO_MASTER.NameValue(row, "STR_CD");     // 시설구분(점코드)
    var strCalYM    = DS_IO_MASTER.NameValue(row, "CAL_YM");     // 부과년월
    var strCntrId   = DS_IO_MASTER.NameValue(row, "CNTR_ID");    // 계약ID
    var strCalType  = DS_IO_MASTER.NameValue(row, "CAL_TYPE");   // 정산유형
    
    var goTo = "getDetail";
    var parameters = ""
        + "&strStrCd="      + encodeURIComponent(strStrCd)
        + "&strCalYM="      + encodeURIComponent(strCalYM)
        + "&strCntrId="     + encodeURIComponent(strCntrId)
        + "&strCalType="    + encodeURIComponent(strCalType);
    TR_MAIN2.Action = "/mss/mren303.mr?goTo=" + goTo + parameters;
    TR_MAIN2.KeyValue = "SERVLET(O:DS_O_DETAIL=DS_O_DETAIL)";
    TR_MAIN2.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", GD_DETAIL);
}

/**
 * checkValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.02
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidate() {
    // 조정사유
    if (eval(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MOD_RENT_ARREAR_AMT")) != 0 
    		|| eval(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MOD_ARREAR_AMT")) != 0) {
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MOD_REASON")== "") {
            showMessage(INFORMATION, OK, "USER-1002", "금액조정이 일어난 경우, 조정사유");
            LC_MOD_REASON.Focus();
            return false;
        } 
    } 

    //조정금액
    /*
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MOD_REASON") != "") {
        if (eval(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MOD_AMT")) == 0) {
            showMessage(INFORMATION, OK, "USER-1003", "조정사유를 선택하신경우, 조정금액");
            EM_MOD_AMT.Focus();
            return false;
        }
    } */

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
if(clickSORT)return;
//화면
if (row > 0) {
// 	if (DS_IO_MASTER.NameValue(row, "CHRG_YN") == "Y" || DS_IO_MASTER.NameValue(row, "CLOSE_YN") == "TRUE" ) { //청구생성여부
// 		//EM_MOD_AMT.Enable      = false;
// 		LC_MOD_REASON.Enable   = false;
// 	} else {
//         //EM_MOD_AMT.Enable      = true;
//         LC_MOD_REASON.Enable   = true;
// 	}
	
    getDetail(row);
} else {
    //EM_MOD_AMT.Enable      = false;
    LC_MOD_REASON.Enable   = false;
}
</script>

<script language=JavaScript for=DS_O_DETAIL event=OnRowPosChanged(row)>
    if(clickSORT)return;
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

<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
//마감여부체크
    EM_CAL_YM.Enable     = true;
    //마감여부체크
    if (EM_CAL_YM.Text.length == 6) {
        if (getCloseYN("mainCost")) return;//마감여부체크
    } else {
        enableControl(IMG_MAIN_COST,false);
        //enableControl(IMG_RE_FEE,false);
    }

</script>

<script language=JavaScript for=EM_CAL_YM event=OnKillFocus()>
//마감여부체크
if (EM_CAL_YM.Text.length == 6) {
    if (getCloseYN("mainCost")) return;//마감여부체크
} else {
    enableControl(IMG_MAIN_COST,false);
    //enableControl(IMG_RE_FEE,false);
}
</script>
<!--  
<script language=JavaScript for=EM_MOD_AMT event=OnKeyUp(kcode,scode)>
//조정금액 변경시
    var strModAmt = EM_MOD_AMT.Text;
    var strchargAmt = eval(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"TAX_AMT")) +
    eval(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"NTAX_AMT"));
    //eval(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"BAL_AMT"));
    
    EM_REAL_CHAREG_AMT.Text = eval(strchargAmt) - (strModAmt);
</script>

<script language=JavaScript for=EM_MOD_AMT event=OnKillFocus()>
	var strModAmt = EM_MOD_AMT.Text.replace("-","");
	if (strModAmt == "" || strModAmt == "0" ) {
	    EM_MOD_AMT.Text = "0";
	}
</script>
-->

<script language=JavaScript for=EM_MOD_ARREAR_AMT event=OnKeyUp(kcode,scode)>
//조정관리비연체료 변경시
    var strModAmt = EM_MOD_ARREAR_AMT.Text;
    var strchargAmt = eval(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"MOD_ARREAR_AMT")) +
    eval(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"BAL_AMT"));
    //eval(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"BAL_AMT"));
    
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"MOD_TOT_BAL_AMT") = strchargAmt;
</script>

<script language=JavaScript for=EM_MOD_AMT event=OnKillFocus()>
	var strModAmt = EM_MOD_AMT.Text.replace("-","");
	if (strModAmt == "" || strModAmt == "0" ) {
	    EM_MOD_AMT.Text = "0";
	}
</script>

<script language=JavaScript for=EM_MOD_RENT_ARREAR_AMT event=OnKeyUp(kcode,scode)>
//조정관리비연체료 변경시
    var strModAmt = EM_MOD_RENT_ARREAR_AMT.Text;
    var strchargAmt = eval(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"MOD_RENT_ARREAR_AMT")) +
    eval(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"RENT_BAL_AMT"));
    //eval(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"BAL_AMT"));   
    
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"MOD_RENT_TOT_BAL_AMT") = strchargAmt;
</script>

<script language=JavaScript for=EM_MOD_RENT_ARREAR_AMT event=OnKillFocus()>
	var strModAmt = EM_MOD_RENT_ARREAR_AMT.Text.replace("-","");
	if (strModAmt == "" || strModAmt == "0" ) {
		EM_MOD_RENT_ARREAR_AMT.Text = "0";
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
<comment id="_NSID_"><object id="DS_O_DETAIL"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<!-- =============== ONLOAD용  -->
<comment id="_NSID_"><object id="DS_STR_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_RENT_TYPE"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_RENT_FLAG"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_MOD_REASON"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSE_YN"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CALCHECK"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
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
						<td width="145"><comment id="_NSID_"><object
							id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="143" tabindex=1
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
						<th width="80" class="point">부과년월</th>
						<td width="110">
							<comment id="_NSID_">
								<object	id=EM_S_CAL_YM classid=<%=Util.CLSID_EMEDIT%> width="85" tabindex=1	onblur="javascript:checkDateTypeYM(this);" align="absmiddle">
								</object>
							</comment>
							<script>_ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('M',EM_S_CAL_YM);" />
						</td>
						<th width="60">협력사</th>
						<td>
							<comment id="_NSID_"> 
								<object id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width="90" tabindex=1	align="absmiddle">
								</object> 
							</comment> 
							<script> _ws_(_NSID_);</script> 
							<comment id="_NSID_">
								<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript:callPopup('sVen');" align="absmiddle"/>
								<object id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width="110" tabindex=1 align="absmiddle"></object>
							</comment> 
							<script> _ws_(_NSID_);</script>
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
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td class="PT01 PB03">
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">시설구분</th>
						<td width="145"><comment id="_NSID_"><object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="143" tabindex=1
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
						<th width="80" class="point">부과년월</th>
						<td width="110"><comment id="_NSID_"><object
							id=EM_CAL_YM classid=<%=Util.CLSID_EMEDIT%> width="85" tabindex=1
							onblur="javascript:checkDateTypeYM(this);" align="absmiddle">
						</object></comment><script>_ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('M',EM_CAL_YM);" /></td>
						<th width="60">정산구분</th>
                        <td>
                            <comment id="_NSID_">
                            <object id=RD_CAL_FLAG classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:120">
                            <param name=Cols    value="2">
                            <param name=Format  value="2^관리비">
                            <param name=CodeValue  value="2">
                            </object>  
                            </comment><script> _ws_(_NSID_);</script> 
                        </td>
                        <td class="right"><img id="IMG_MAIN_COST"
							src="/<%=dir%>/imgs/btn/maintenance_cost.gif" hspace="2" 
							onclick="javascript:procCalculate();" /></td>
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
							width=290 height=467 tabindex=1 classid=<%=Util.CLSID_GRID%>>
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
									align="absmiddle" /> 계약정보</td>
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
								<td width="150"><comment id="_NSID_"> <object
									id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width="140"
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
                                <th width="100">협력사명</th>
                                <td><comment id="_NSID_"> <object id=EM_VEN_NM
                                    classid=<%=Util.CLSID_EMEDIT%> width="155" tabindex=1
                                    align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>임대형태</th>
								<td><comment id="_NSID_"> <object
									id=LC_RENT_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width="145"
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
								<th>임대구분</th>
								<td><comment id="_NSID_"> <object id=LC_RENT_FLAG
									classid=<%=Util.CLSID_LUXECOMBO%> width="160" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>임대보증금</th>
								<td><comment id="_NSID_"> <object
									id=EM_RENT_DEPOSIT classid=<%=Util.CLSID_EMEDIT%> width="140"
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
								<th>임대료</th>
								<td><comment id="_NSID_"> <object
									id=EM_MM_RENTFEE classid=<%=Util.CLSID_EMEDIT%> width="155"
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th>계약기간</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_CNTR_S_DT classid=<%=Util.CLSID_EMEDIT%> width="140"
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								~ <comment id="_NSID_"> <object id=EM_CNTR_E_DT
									classid=<%=Util.CLSID_EMEDIT%> width="140" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="dot"></td>
					</tr>
					<tr>
						<td>
						<table width="100%"  border="0" cellspacing="0" cellpadding="0">
							<tr valign="top">
								<td width="230">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td>
										<table width="100%" height="20" border="0" cellspacing="0" cellpadding="0" >											
											<tr>
												<td class="sub_title"><img
													src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
													align="absmiddle" /> 관리비항목 내역</td><!--
												<td class="middle">
                                                    <img src="/<%=dir%>/imgs/btn/re_fee.gif" id="IMG_RE_FEE"
                                                    onclick="detailSave();" align="absmiddle" />
                                                </td>
											--></tr>
										</table>
										</td>
									</tr>
									<!--
									<tr class="PT10">
			                    		<td class="FS11 red">※수정후에는 정산재생성을 꼭해야 합니다.
			                    		</td>
			                  		</tr>
									-->
									<tr valign="top">
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
											<tr>
												<td><comment id="_NSID_"><OBJECT id=GD_DETAIL
													width=260 height=314 tabindex=1 classid=<%=Util.CLSID_GRID%>>
													<param name="DataID" value="DS_O_DETAIL">
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
										<td>
										<table width="100%" height="20" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td class="sub_title"><img
													src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
													align="absmiddle" /> 관리비정산 내역</td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td class="PL03">
											<table width="100%" border="0" cellspacing="0" cellpadding="0"
												class="s_table">
												<tr>
													<th width="20" rowspan="7">당<br>월</th>
													<th>임대료(VAT제외)</th>
														<td colspan="2" ><comment id="_NSID_"> <object
															id=EM_RENT_NOVAT_AMT classid=<%=Util.CLSID_EMEDIT%>
															width="150" tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
														</td>
												</tr>		
												<tr>
													<th width="110">임대료VAT</th>
													<td colspan="2"><comment id="_NSID_"> <object
														id=EM_RENT_VAT_AMT classid=<%=Util.CLSID_EMEDIT%>
														width="150" tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
													</td>
												</tr>
												<tr>												
													<th>임대료(VAT포함)</th>
													<td colspan="2"><comment id="_NSID_"> <object
														id=EM_RENT_AMT classid=<%=Util.CLSID_EMEDIT%> width="150"
														tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
													</td>
												</tr>
												<tr>
													<th>과세관리비<br>(VAT제외)</th>
													<td colspan="2"><comment id="_NSID_"> <object
														id=EM_TAX_NOVAT_AMT classid=<%=Util.CLSID_EMEDIT%> width="150"
														tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
													</td>
												</tr>
												<tr>
													<th>관리비VAT</th>
													<td colspan="2"><comment id="_NSID_"> <object
														id=EM_TAX_VAT_AMT classid=<%=Util.CLSID_EMEDIT%>
														width="150" tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
													</td>
												</tr>
												<tr>
													<th>과세관리비<br>(VAT포함)</th>
													<td colspan="2"><comment id="_NSID_"> <object
														id=EM_TAX_AMT classid=<%=Util.CLSID_EMEDIT%> width="150"
														tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
													</td>
												</tr>											
												<tr>
													<th>면세관리비</th>
													<td colspan="2"><comment id="_NSID_"> <object
														id=EM_NTAX_AMT classid=<%=Util.CLSID_EMEDIT%> width="150"
														tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
													</td>
												</tr>
												<tr>
													<th rowspan="4">미<br>수</th>
													<th>관리비</th>
													<td colspan="2"><comment id="_NSID_"> <object
														id=EM_BAL_AMT classid=<%=Util.CLSID_EMEDIT%> width="150"
														tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
													</td>
												</tr>
												<tr>
													<th>임대료</th>
													<td colspan="2"><comment id="_NSID_"> <object
														id=EM_RENT_BAL_AMT classid=<%=Util.CLSID_EMEDIT%> width="150"
														tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
													</td>
												</tr>
												<tr>
													<th>관리비연체료</th>
													<td ><comment id="_NSID_"> <object
														id=EM_ARREAR_AMT classid=<%=Util.CLSID_EMEDIT%> width="70"
														tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
													    / <comment id="_NSID_"> <object
														id=EM_MOD_ARREAR_AMT classid=<%=Util.CLSID_EMEDIT%> width="70"
														tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
													</td>
												</tr>
												<tr>
													<th>임대료연체료</th>
													<td ><comment id="_NSID_"> <object
														id=EM_RENT_ARREAR_AMT classid=<%=Util.CLSID_EMEDIT%> width="70"
														tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
													    / <comment id="_NSID_"> <object
														id=EM_MOD_RENT_ARREAR_AMT classid=<%=Util.CLSID_EMEDIT%> width="70"
														tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
													</td>
												</tr>
												<!-- 	
												<tr>
													<th rowspan="1">조<br>
													정</th>
													
													<th>조정금액</th>
													<td><comment id="_NSID_"> <object
														id=EM_MOD_AMT classid=<%=Util.CLSID_EMEDIT%> width="140"
														tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
													</td> 
												</tr>-->
												<tr>
													<th colspan="2">조정사유</th>
													<td colspan="2"><comment id="_NSID_"> <object
														id=LC_MOD_REASON classid=<%=Util.CLSID_LUXECOMBO%>
														width="150" tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
													</td>
												</tr>
												<tr>
													<th colspan="2" align="center">관리비청구액</th>
													<td colspan="2"><comment id="_NSID_"> <object
														id=EM_REAL_CHAREG_AMT classid=<%=Util.CLSID_EMEDIT%>
														width="150" tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
													</td>
												</tr>
												<tr>
													<th colspan="2" align="center">임대료청구액</th>
													<td colspan="2"> <comment id="_NSID_"> <object
														id=EM_RENT_REAL_CHAREG_AMT classid=<%=Util.CLSID_EMEDIT%>
														width="150" tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
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
       <c>Col=VEN_CD                   Ctrl=EM_VEN_CD                 param=Text</c>
       <c>Col=VEN_NM                   Ctrl=EM_VEN_NM                 param=Text</c>
       <c>Col=RENT_TYPE                Ctrl=LC_RENT_TYPE              param=BindColVal</c>
       <c>Col=RENT_FLAG                Ctrl=LC_RENT_FLAG              param=BindColVal</c>
       <c>Col=RENT_DEPOSIT             Ctrl=EM_RENT_DEPOSIT           param=Text</c>
       <c>Col=MM_RENTFEE               Ctrl=EM_MM_RENTFEE             param=Text</c>
       <c>Col=CNTR_S_DT                Ctrl=EM_CNTR_S_DT              param=Text</c>
       <c>Col=CNTR_E_DT                Ctrl=EM_CNTR_E_DT              param=Text</c>
       <c>Col=RENT_NOVAT_AMT           Ctrl=EM_RENT_NOVAT_AMT         param=Text</c>
       <c>Col=RENT_VAT_AMT             Ctrl=EM_RENT_VAT_AMT           param=Text</c>
	   <c>Col=RENT_AMT                 Ctrl=EM_RENT_AMT               param=Text</c>
       <c>Col=TAX_NOVAT_AMT            Ctrl=EM_TAX_NOVAT_AMT          param=Text</c>
       <c>Col=TAX_VAT_AMT              Ctrl=EM_TAX_VAT_AMT            param=Text</c>
       <c>Col=TAX_AMT                  Ctrl=EM_TAX_AMT                param=Text</c>
       <c>Col=NTAX_AMT                 Ctrl=EM_NTAX_AMT               param=Text</c>
       <c>Col=BAL_AMT                  Ctrl=EM_BAL_AMT                param=Text</c>
       <c>Col=ARREAR_AMT               Ctrl=EM_ARREAR_AMT             param=Text</c>
       <c>Col=MOD_REASON               Ctrl=LC_MOD_REASON             param=BindColVal</c>
       <c>Col=REAL_CHAREG_AMT          Ctrl=EM_REAL_CHAREG_AMT        param=Text</c>       
       <c>Col=RENT_BAL_AMT             Ctrl=EM_RENT_BAL_AMT           param=Text</c>
       <c>Col=MOD_ARREAR_AMT           Ctrl=EM_MOD_ARREAR_AMT         param=Text</c>
       <c>Col=RENT_ARREAR_AMT          Ctrl=EM_RENT_ARREAR_AMT        param=Text</c>
       <c>Col=MOD_RENT_ARREAR_AMT      Ctrl=EM_MOD_RENT_ARREAR_AMT    param=Text</c>
       <c>Col=RENT_REAL_CHAREG_AMT     Ctrl=EM_RENT_REAL_CHAREG_AMT   param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

