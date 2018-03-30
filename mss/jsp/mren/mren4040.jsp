<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 관리비 입금내역관리
 * 작 성 일 : 2010.01.14
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : MREN4040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 관리비 입금관리
 * 이    력 : 2010.01.14(박래형) 신규작성
 *         2010.05.06(김유완) 수정작성
 ******************************************************************************/
--> 
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
<!--*************************************************************************-->
<loginChk:islogin />
<%
	//session 정보
	SessionInfo sessionInfo = (SessionInfo) session
			.getAttribute("sessionInfo");
	String contextRoot = request.getContextPath();
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작
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
 * 작 성 일 : 2010.05.06
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 120;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    //Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_CALMST"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_MR_CALPAY"/>');
    DS_O_COUNT.setDataHeader('<gauce:dataset name="H_SEL_MR_COUNT"/>');
    DS_IO_CALBAL.setDataHeader('<gauce:dataset name="H_SEL_MR_CALBAL"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_DETAIL");
    
    gridCreate("MST"); //마스터
    gridCreate("DTL"); //관리비항목별 내역
 
    // Object 초기화
    initComboStyle(LC_S_STR_CD,DS_STR_CD,       "CODE^0^30,NAME^0^100", 1, PK);     // [조회용]시설구분
    initEmEdit(EM_S_CAL_YM,                     "YYYYMM", PK);                      // [조회용]부과년월
    initEmEdit(EM_S_VEN_CD,                     "NUMBER3^6^0", NORMAL);             // [조회용]협력사
    initEmEdit(EM_S_VEN_NM,                     "GEN",    READ);                    // [조회용]협력사명
    initComboStyle(LC_S_RENT_FLAG,DS_RENT_FLAG, "CODE^0^30,NAME^0^100", 1, NORMAL); // [조회용]임대형태
    DS_RENT_FLAG.Filter();                                                          // [조회용]임대형태 필터링
    DS_RENT_FLAG.SortExpr = "+" + "CODE";
    DS_RENT_FLAG.Sort();
    initComboStyle(LC_S_PAY_FLAG,DS_PAY_FLAG,   "CODE^0^30,NAME^0^100", 1, NORMAL); // [조회용]입금상태구분
    
    initEmEdit(EM_RENT_NOVAT_AMT,               "NUMBER^10^0",  READ);              // [당월]임대료(vat제외)
    initEmEdit(EM_RENT_VAT_AMT,                 "NUMBER^10^0",  READ);              // [당월]임대료VAT
    initEmEdit(EM_RENT_AMT,                     "NUMBER^10^0",  READ);              // [당월]임대료(vat포함)
    initEmEdit(EM_TAX_NOVAT_AMT,                "NUMBER^10^0",  READ);              // [당월]과세관리비(vat제외)
    initEmEdit(EM_TAX_VAT_AMT,                  "NUMBER^10^0",  READ);              // [당월]과세관리비VAT
    initEmEdit(EM_TAX_AMT,                      "NUMBER^10^0",  READ);              // [당월]과세관리비(vat포함)
    
    initEmEdit(EM_NTAX_AMT,                     "NUMBER^10^0",  READ);              // [당월]면세관리비
    initEmEdit(EM_BAL_AMT,                      "NUMBER^10^0",  READ);              // [미수]관리비
    initEmEdit(EM_ARREAR_AMT,                   "NUMBER^10^0",  READ);              // [미수]관리비연체이자
    initEmEdit(EM_RENT_BAL_AMT,                 "NUMBER^10^0",  READ);              // [미수]임대료
    initEmEdit(EM_MOD_RENT_ARREAR_AMT,          "NUMBER^10^0",  READ);              // [미수]임대료연체이자
    //initEmEdit(EM_MOD_AMT,                      "NUMBER^10^0",  READ);              // [조정]조정금액
    initComboStyle(LC_MOD_REASON,DS_MOD_REASON, "CODE^0^30,NAME^0^100", 1, READ);   // [조정]조정사유
   initEmEdit(EM_REAL_CHAREG_AMT,              "NUMBER^10^0",  READ);              // 관리비청구액
    initEmEdit(EM_RENT_REAL_CHAREG_AMT,         "NUMBER^10^0",  READ);              // 임대료청구액
    
    initEmEdit(EM_ARR_AMT,          			"NUMBER^10^0",  NORMAL);            // 미수연체이자(익월)
    initEmEdit(EM_BAL_ARR_AMT,              	"NUMBER^10^0",  READ);              // 미수원금
    initEmEdit(EM_BAL_ARREAR_AMT,              	"NUMBER^10^0",  READ);              // 미수연체이자(당월)
    
    
    getFlc("DS_STR_CD",                         "M", "1", "Y", "N");                // 시설구분  
    LC_S_STR_CD.index = 0;     
    LC_S_STR_CD.Focus();   
    EM_S_CAL_YM.Text = getTodayFormat("YYYYMM");
    
    getEtcCode("DS_RENT_FLAG",                  "D", "P003", "Y");                  // [조회용]임대형태      
    LC_S_RENT_FLAG.index = 0; 
    getEtcCode("DS_PAY_FLAG",                   "D", "M099", "Y");                  // [조회용]입금상태구분      
    LC_S_PAY_FLAG.index = 0; 
    getEtcCode("DS_MOD_REASON",                 "D", "M098", "N");                  // 조정사유     
    
    //행추가 삭제 버튼 비활성화
    enableControl(IMG_ADD_ROW, false);
    enableControl(IMG_DEL_ROW, false);
    
    RD_CAL_FLAG.CodeValue = "M";
}

/**
 * gridCreate("대상그리드")
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.06
 * 개    요 : 그리드SET
 * return값 : void
 */
function gridCreate(grdGBN) {
    if (grdGBN == "MST") {
        var hdrProperies = ''
            + '<FC>ID={CURROW}          NAME=NO'         
            + '                                         WIDTH=30    ALIGN=CENTER</FC>'
            + '<FC>ID=VEN_CD            NAME=협력사코드'            
            + '                                         WIDTH=80    ALIGN=CENTER</FC>'
            + '<FC>ID=VEN_NM            NAME=협력사명'        
            + '                                         WIDTH=130   ALIGN=LEFT </FC>'
            + '<FC>ID=PAY_FLAG          NAME=입금상태'        
            + '                                         WIDTH=130   ALIGN=LEFT EDITSTYLE=LOOKUP    DATA="DS_PAY_FLAG:CODE:NAME" </FC>'
            ;
            initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
    } else {
        var hdrProperies = ''
            + '<FC>ID={CURROW}               NAME=NO'         
            + '                                              WIDTH=30    ALIGN=CENTER</FC>'
            + '<FC>ID=PAY_DT                 NAME=*입금일'            
            + '                                              WIDTH=90   ALIGN=CENTER MASK="XXXX/XX/XX" EDITSTYLE=POPUP SUMTEXT="합계"</FC>'
            + '<FC>ID=PAY_SEQ_NO             NAME=차수'        
            + '                                              WIDTH=35    ALIGN=CENTER EDIT=NONE</FC>'
            + '<FC>ID=PAY_AMT                NAME=*원금'        
            + '                                              WIDTH=100   ALIGN=RIGHT EDIT=NUMERIC SUMTEXT=@SUM </FC>'
            + '<FC>ID=PAY_ARR_AMT            NAME=연체료'        
            + '                                              WIDTH=100   ALIGN=RIGHT EDIT=NUMERIC SUMTEXT=@SUM </FC>'             
            + '<FC>ID=REMARK                 NAME=비고'        
            + '                                              WIDTH=200   ALIGN=LIFT EDIT=true </FC>' 
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
 * 작 성 일 : 2010.05.06
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if (DS_IO_DETAIL.IsUpdated) {//변경데이터 있을 시 확인
	    var ret = showMessage(Question, YesNo, "USER-1059");
	    if (ret == "1") {
            //마감체크
            //getCloseYN();
	    	
	        // parameters
	        var strStrCd    = LC_S_STR_CD.BindColVal;  		// [조회용]시설구분(점코드)
	        var strCalYM    = EM_S_CAL_YM.Text;        		// [조회용]부과년월
	        var strVenCd    = EM_S_VEN_CD.Text;        		// [조회용]협력사
            var strRentFlag = LC_S_RENT_FLAG.BindColVal;    // [조회용]임대형태
            var strPayFlag  = LC_S_PAY_FLAG.BindColVal;     // [조회용]입금상태구분
	        
	        var goTo = "getMaster";
	        var parameters = ""
	            + "&strStrCd="     + encodeURIComponent(strStrCd)
	            + "&strCalYM="     + encodeURIComponent(strCalYM)
	            + "&strVenCd="     + encodeURIComponent(strVenCd)
	            + "&strRentFlag="  + encodeURIComponent(strRentFlag)
	            + "&strPayFlag="   + encodeURIComponent(strPayFlag);
	        TR_MAIN.Action = "/mss/mren404.mr?goTo=" + goTo + parameters;
	        TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
	        TR_MAIN.Post();
	        // 조회결과 Return
	        setPorcCount("SELECT", GD_MASTER);
	    } else {
	        return false;
	    }
	}  else {
		//마감체크
		//getCloseYN();
		
		// parameters
		var strStrCd    = LC_S_STR_CD.BindColVal;  // [조회용]시설구분(점코드)
		var strCalYM    = EM_S_CAL_YM.Text;        // [조회용]부과년월
		var strVenCd    = EM_S_VEN_CD.Text;        // [조회용]협력사
		var strRentFlag = LC_S_RENT_FLAG.BindColVal;    // [조회용]임대형태
		var strPayFlag  = LC_S_PAY_FLAG.BindColVal;     // [조회용]입금상태구분
	    
	    var goTo = "getMaster";
	    var parameters = ""
	        + "&strStrCd="     + encodeURIComponent(strStrCd)
	        + "&strCalYM="     + encodeURIComponent(strCalYM)
	        + "&strVenCd="     + encodeURIComponent(strVenCd)
	        + "&strRentFlag="  + encodeURIComponent(strRentFlag)
	        + "&strPayFlag="   + encodeURIComponent(strPayFlag);
	    TR_MAIN.Action = "/mss/mren404.mr?goTo=" + goTo + parameters;
	    TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
	    TR_MAIN.Post();
	    // 조회결과 Return
	    setPorcCount("SELECT", GD_MASTER);
	}
	
	if (DS_O_MASTER.CountRow < 1) {
	    DS_IO_DETAIL.ClearData();
	} else {
	    if (arguments[0] == undefined || arguments[0] == "S") {
	        g_currKey = "S";
	    } else {
	        var strCurrKeyRow = getNameValueRow(DS_O_MASTER, "CAL_YM||CNTR_ID||CAL_TYPE",g_currKey);
	        if (strCurrKeyRow == 0 ) {
	            DS_O_MASTER.RowPosition = 1;
	        } else {
	            DS_O_MASTER.RowPosition = strCurrKeyRow;
	        }
	    }
	} 

    //마감체크
    getCloseYN();
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.06
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    //저장 시  CanRowPosChange 이벤트 우회 flag
    g_saveFlag = true;
    if (DS_IO_DETAIL.IsUpdated) {//변경 데이터가 있을때만 저장
        //필수 입력값 체크
        if (!checkValidateSave()) {
            g_saveFlag = false;
            return;
        }
        
        //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_DETAIL.Focus();
            return;
        }   
       
        //저장
        var strCalYM        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CAL_YM");     // 부과년월
        var strCntrID       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CNTR_ID");    // 계약ID
        var strCalType      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CAL_TYPE");   // 정산구분
        var strRealAmt      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REAL_CHAREG_AMT");        // 관리비청구금액
        var strRealRentAmt  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "RENT_REAL_CHAREG_AMT");   // 임대료청구금액
        
        var strMntnRentGb = RD_CAL_FLAG.CodeValue;  //임대료/관리비 구분
        var strBalArrAmt = EM_ARR_AMT.Text;
        
        //key저장후 재조회 용
        g_currKey = strCalYM+"||"+strCntrID+"||"+strCalType;
	    var parameters = "&strRealAmt="      + encodeURIComponent(strRealAmt)
	                   + "&strRealRentAmt="  + encodeURIComponent(strRealRentAmt)
	                   + "&strCalYM="        + encodeURIComponent(strCalYM)
	                   + "&strCntrID="       + encodeURIComponent(strCntrID)
	                   + "&strCalType="      + encodeURIComponent(strCalType)
	                   + "&strMntnRentGb="   + encodeURIComponent(strMntnRentGb)
	                   + "&strBalArrAmt="    + encodeURIComponent(strBalArrAmt);
        var goTo = "save";
        TR_SAVE.Action = "/mss/mren404.mr?goTo=" + goTo + parameters;
        TR_SAVE.KeyValue = "SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)";
        TR_SAVE.Post();
    } else {
    	
    	if (DS_IO_CALBAL.IsUpdated) {//변경 데이터가 있을때만 저장

            //변경또는 신규 내용을 저장하시겠습니까?
            if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
                GD_DETAIL.Focus();
                return;
            }   
           
            //저장
            var strCalYM        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CAL_YM");     // 부과년월
            var strCntrID       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CNTR_ID");    // 계약ID
            var strCalType      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CAL_TYPE");   // 정산구분
            var strRealAmt      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REAL_CHAREG_AMT");        // 관리비청구금액
            var strMOD_ARREAR_AMT     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MOD_ARREAR_AMT");        // 미수연체이자
            var strARR_RATE     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ARR_RATE");        			// 연체율           
            var strMntnRentGb = RD_CAL_FLAG.CodeValue;  								//임대료/관리비 구분
            var strBalArrAmt = EM_ARR_AMT.Text;											//익월 미수 연체금액
            
            var strRealRentAmt  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "RENT_REAL_CHAREG_AMT");   // 임대료청구금액
			
            //key저장후 재조회 용
            g_currKey = strCalYM+"||"+strCntrID+"||"+strCalType;
    	    var parameters = "&strCalYM="        + encodeURIComponent(strCalYM)
    	                   + "&strCntrID="       + encodeURIComponent(strCntrID)
    	                   + "&strCalType="      + encodeURIComponent(strCalType)
    	                   + "&strMntnRentGb="   + encodeURIComponent(strMntnRentGb)
    	                   + "&strRealAmt="      + encodeURIComponent(strRealAmt)
    	                   + "&strARR_RATE="     + encodeURIComponent(strARR_RATE)
    	                   + "&strBalArrAmt="    + encodeURIComponent(strBalArrAmt)
    	                   + "&strMOD_ARREAR_AMT="    + encodeURIComponent(strMOD_ARREAR_AMT);
    	    
            var goTo = "balsave";
            TR_SAVE.Action = "/mss/mren404.mr?goTo=" + goTo + parameters;
            TR_SAVE.KeyValue = "SERVLET(I:DS_IO_CALBAL=DS_IO_CALBAL)";
            TR_SAVE.Post();

    	} else {
            showMessage(INFORMATION, OK, "USER-1028");
    	}
    	
    } 
    g_saveFlag = false;
}
/**
 * btn_AddRow()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.06
 * 개    요 : 행추가
 * return값 :
 */
function btn_AddRow() {
    GD_DETAIL.SetColumn("PAY_DT");
    DS_IO_DETAIL.AddRow(); 
    //부과년월셋팅
    //DS_IO_DETAIL.NameValue(DS_IO_DETAIL.Rowposition, "PAY_DT_TMP") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CAL_YM") + "01";
    //DS_IO_DETAIL.NameValue(DS_IO_DETAIL.Rowposition, "PAY_DT") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CAL_YM") + "01";
    //setTimeout("GD_DETAIL.SetColumn('PAY_DT')" , 30);
}

/**
 * btn_DeleteRow()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.06
 * 개    요 : 행삭제
 * return값 :
 */
function btn_Delete() {	 
	if(DS_O_COUNT.NameValue(1, "COUNT") == "1"){
		showMessage(INFORMATION, OK, "USER-1000", "이월처리되어 삭제가 불가능 합니다.");
		return;
	}
	// 선택한 항목을 삭제하겠습니까?
    if( showMessage(INFORMATION, YESNO, "USER-1023") != 1 ){
        GD_DETAIL.Focus();
        return;
    }  
	    
    var strCalYM        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CAL_YM");     // 부과년월
    var strCntrID       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CNTR_ID");    // 계약ID
    var strCalType      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CAL_TYPE");   // 정산구분
        
    var strMntnRentGb   = RD_CAL_FLAG.CodeValue;
    var strBalArrAmt    = EM_ARR_AMT.Text;
    
    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition); 
    
    // parameters
    
    var goTo = "save";
    var parameters = ""
        + "&strCalYM="      + encodeURIComponent(strCalYM)
        + "&strCntrID="     + encodeURIComponent(strCntrID)
        + "&strCalType="    + encodeURIComponent(strCalType)
        + "&strMntnRentGb=" + encodeURIComponent(strMntnRentGb)
        + "&strBalArrAmt="  + encodeURIComponent(strBalArrAmt);
    
    TR_MAIN.Action = "/mss/mren404.mr?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)";
    TR_MAIN.Post();
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * getDetail()
 * 작 성 자 : 
 * 작 성 일 : 2010.05.02
 * 개    요 : 관리비항목별 내역 조회(상세)
 * return값 : void
 */
function getDetail(row) {
    var strCalYM    = DS_O_MASTER.NameValue(row, "CAL_YM");     // 부과년월
    var strCntrId   = DS_O_MASTER.NameValue(row, "CNTR_ID");    // 계약ID
    var strCalType  = DS_O_MASTER.NameValue(row, "CAL_TYPE");   // 정산유형
    
    var strMntnRentGb = RD_CAL_FLAG.CodeValue;
    
    var goTo = "getDetail";
    var parameters = "&strCalYM="      + encodeURIComponent(strCalYM)
       			   + "&strCntrId="     + encodeURIComponent(strCntrId)
        		   + "&strCalType="    + encodeURIComponent(strCalType)
        		   + "&strMntnRentGb=" + encodeURIComponent(strMntnRentGb);
    TR_MAIN2.Action = "/mss/mren404.mr?goTo=" + goTo + parameters;
    TR_MAIN2.KeyValue = "SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL,O:DS_O_COUNT=DS_O_COUNT)";
    TR_MAIN2.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_DETAIL.RealCount(1,DS_IO_DETAIL.CountRow));
    
    //getCalBal(row);
    setEnableControl();
}
 
 /**
  * getCalBal()
  * 작 성 자 : 
  * 작 성 일 : 2010.05.02
  * 개    요 : 관리비항목별 내역 조회(상세)
  * return값 : void
  */
 function getCalBal(row) {
	
     var strCalYM    = DS_O_MASTER.NameValue(row, "CAL_YM");     // 부과년월
     var strCntrId   = DS_O_MASTER.NameValue(row, "CNTR_ID");    // 계약ID
     var strCalType  = DS_O_MASTER.NameValue(row, "CAL_TYPE");   // 정산유형
     
     var strMntnRentGb = RD_CAL_FLAG.CodeValue;
     
     var goTo = "getCalBal";
     var parameters = "&strCalYM="      + encodeURIComponent(strCalYM)
        		    + "&strCntrId="     + encodeURIComponent(strCntrId)
         		    + "&strCalType="    + encodeURIComponent(strCalType)
         		    + "&strMntnRentGb=" + encodeURIComponent(strMntnRentGb);
     TR_SUB.Action = "/mss/mren404.mr?goTo=" + goTo + parameters;
     TR_SUB.KeyValue = "SERVLET(O:DS_IO_CALBAL=DS_IO_CALBAL)";
     TR_SUB.Post();
     
 	if (DS_IO_CALBAL.CountRow > 0) {
 		
 		var iBAL_CNT = DS_IO_CALBAL.NameValue(1, "BAL_CNT");
 		
 	    if (iBAL_CNT == "0") {
 	    	DS_IO_CALBAL.NameValue(1, "BAL_AMT") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CHAREG_AMT"); 
 	    	DS_IO_CALBAL.NameValue(1, "BAL_ARREAR_AMT") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MOD_ARREAR_AMT"); 

 	    	DS_IO_CALBAL.ResetStatus();
 	    	//alert(DS_IO_CALBAL.UserStatus(1)); 	    	
 	    	//alert(DS_IO_CALBAL.SysStatus(1));
 	    	
 	    } else {

 	       // 조회결과 Return
 	       setPorcCount("SELECT", DS_IO_DETAIL.RealCount(1,DS_IO_DETAIL.CountRow));
 	       
 	       setEnableControl();
 	    }
 	} 
 	
 	
 }
 
 /**
  * setEnableControl()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.05.06
  * 개    요 : 그리드 Edit 여부 설정
  * return값 :
  */
 function setEnableControl() {
	  if(DS_O_COUNT.NameValue(1, "COUNT") == "0"){
		  GD_DETAIL.Editable = "true";
		  enableControl(IMG_ADD_ROW, true);
	      enableControl(IMG_DEL_ROW, true);
	  }else{
		  GD_DETAIL.Editable = "false";
		  enableControl(IMG_ADD_ROW, false);
	      enableControl(IMG_DEL_ROW, false);
	  }
 }
 
 /**
  * btn_DeleteRow()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.05.06
  * 개    요 : 행삭제
  * return값 :
  */
 function btn_DeleteRow() {
	  if (DS_IO_DETAIL.RowStatus(DS_IO_DETAIL.RowPosition) == 1) { // 신규시에만 삭제
		  DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition); 
		}else{
			showMessage(INFORMATION, OK, "USER-1052");
			return;
		}
       
 }

/**
 * checkValidateSave()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidateSave() {
    //서브계량기 중복체크
    var totPayAmt = 0;  // 총입금액
    var totMntnAmt = 0; // 관리비입금액
    var totRentAmt = 0; // 임대료입금액
    var totArrAmt = 0;  // 관리비 연체이자
    
    for (var k=1; k<=DS_IO_DETAIL.CountRow; k++) {
        //입금일
        if (DS_IO_DETAIL.NameValue(k, "PAY_DT") == "") {
            DS_IO_DETAIL.RowPosition = k;
            GD_DETAIL.SetColumn("PAY_DT");
            showMessage(INFORMATION, OK, "USER-1003", "입금일");
            return false;
        } 
        
        //if(RD_CAL_FLAG.CodeValue == "M"){
        	//관리비입금액
        if (DS_IO_DETAIL.NameValue(k, "PAY_AMT") == 0 || DS_IO_DETAIL.NameValue(k, "PAY_AMT") == "") { //관리비입금액
            DS_IO_DETAIL.RowPosition = k;
            GD_DETAIL.SetColumn("PAY_AMT");
            showMessage(INFORMATION, OK, "USER-1003", "입금액");
            return false;
        }
        //입력길이 체크	
        if(!checkInputByte( GD_DETAIL, DS_IO_DETAIL, k, 'REMARK', '비고',  null, 100)){
        	return false;
        }
        	/*
        }else{
        	//임대료입금액
            if (DS_IO_DETAIL.NameValue(k, "PAY_RENT_AMT") == 0 || DS_IO_DETAIL.NameValue(k, "PAY_RENT_AMT") == "") {//임대료입금액
                DS_IO_DETAIL.RowPosition = k;
                GD_DETAIL.SetColumn("PAY_RENT_AMT");
                showMessage(INFORMATION, OK, "USER-1003", "(임대료) 입금액");
                return false;
            }
        }*/
        
        //중복값 체크
//         for (var i=k+1; i<=DS_IO_DETAIL.CountRow; i++) {
//             if (DS_IO_DETAIL.NameValue(k, "PAY_DT") == DS_IO_DETAIL.NameValue(i, "PAY_DT")) {
//                 DS_IO_DETAIL.RowPosition = i;
//                 GD_DETAIL.SetColumn("PAY_DT");
//                 showMessage(INFORMATION, OK, "USER-1000", k+"번째 행과 "+i+"번째 행의 입금일이 중복됩니다.");
//                 return false;
//             } 
//         }
        
        //입금액 총계
        totPayAmt     = eval(totPayAmt) + eval(DS_IO_DETAIL.NameValue(k, "PAY_AMT")) + eval(DS_IO_DETAIL.NameValue(k, "PAY_ARR_AMT"));             //관리비 + 관리연체료
        //totRentPayAmt = eval(totPayAmt) + eval(DS_IO_DETAIL.NameValue(k, "PAY_RENT_AMT")) + eval(DS_IO_DETAIL.NameValue(k, "PAY_RENT_ARREAR_AMT"));   //임대료 + 임대연체료
        totMntnAmt    = eval(totMntnAmt) + eval(DS_IO_DETAIL.NameValue(k, "PAY_AMT"));
        //totRentAmt    = eval(totRentAmt) + eval(DS_IO_DETAIL.NameValue(k, "PAY_RENT_AMT"));
        
        totArrAmt    = eval(totArrAmt) + eval(DS_IO_DETAIL.NameValue(k, "PAY_ARR_AMT"));
    } 
    /*
    //관리비입금액 청구액
    if (DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REAL_MNTN") < totMntnAmt ) {
        DS_IO_DETAIL.RowPosition = 1;
        GD_DETAIL.SetColumn("PAY_AMT"); 
        showMessage(INFORMATION, OK, "USER-1000", "관리비입금총액("+totMntnAmt+")은 청구관리비금액("+DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REAL_MNTN")+")을 초과 할 수 없습니다.");
        return false;
    }
    
    //임대료입금액 청구액
    if (DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REAL_RENT") < totRentAmt ) {
        DS_IO_DETAIL.RowPosition = 1;
        GD_DETAIL.SetColumn("PAY_RENT_AMT"); 
        showMessage(INFORMATION, OK, "USER-1000", "임대료입금총액("+totRentAmt+")은 월임대료금액("+DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REAL_RENT")+")을 초과 할 수 없습니다.");
        return false;
    }*/
    
    if(RD_CAL_FLAG.CodeValue == "M"){
    	//총입금액과 청구액(관리비)    	
        if (DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REAL_CHAREG_AMT") < totPayAmt ) {
            DS_IO_DETAIL.RowPosition = 1;
            GD_DETAIL.SetColumn("PAY_AMT");
            showMessage(INFORMATION, OK, "USER-1000", "입금총액("+totPayAmt+")은 청구액("+DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REAL_CHAREG_AMT")+")을 초과 할 수 없습니다.");
            return false;
        }

        //if (DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REAL_CHAREG_AMT") < totPayAmt ) {
        if (DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CHAREG_AMT") < totMntnAmt ) {  //-- 연체료제외
            DS_IO_DETAIL.RowPosition = 1;
            GD_DETAIL.SetColumn("PAY_AMT");
            showMessage(INFORMATION, OK, "USER-1000", "원금총액("+totPayAmt+")은 청구액(연체이자제외)("+DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CHAREG_AMT")+")을 초과 할 수 없습니다.");
            return false;
        }
        
        if (DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MOD_ARREAR_AMT") < totArrAmt ) {  //-- 연체이자
            DS_IO_DETAIL.RowPosition = 1;
            GD_DETAIL.SetColumn("PAY_AMT");
            showMessage(INFORMATION, OK, "USER-1000", "연체료총액("+totArrAmt+")은 관리비연체이자("+DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MOD_ARREAR_AMT")+")을 초과 할 수 없습니다.");
            return false;
        }
        
    }else{
    	//총입금액과 청구액(임대료)
        if (DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "RENT_REAL_CHAREG_AMT") < totPayAmt ) {
            DS_IO_DETAIL.RowPosition = 1;
            GD_DETAIL.SetColumn("PAY_AMT");
            showMessage(INFORMATION, OK, "USER-1000", "입금총액("+totPayAmt+")은 청구액("+DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "RENT_REAL_CHAREG_AMT")+")을 초과 할 수 없습니다.");
            return false;
        }
    }
        
        
    return true;
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
 * 작 성 일 : 2010.05.02
 * 개    요 : 마감여부체크
 * return값 :
 */
function getCloseYN() {

	var strStrCd      = LC_S_STR_CD.BindColVal;       // 시설구분
	var strCalYM      = EM_S_CAL_YM.Text;             // 부과년월(입력)	
	
    //마감체크
    if (getCalCheck("DS_O_CALCHECK", strStrCd, strCalYM, "2") == "TRUE") { 	
        
    	EM_ARR_AMT.Enable   = false;
        enableControl(IMG_ADD_ROW, false);
        enableControl(IMG_DEL_ROW, false);  
    	
    } else {
    	
    	EM_ARR_AMT.Enable   = true;
        enableControl(IMG_ADD_ROW, true);
        enableControl(IMG_DEL_ROW, true);  
    }
		
//     //마감체크 함수(getCloseCheck)
//     if (getCloseCheck("DS_CLOSE_YN", LC_S_STR_CD.BindColVal, EM_S_CAL_YM.Text, "MREN", "48", "0", "M") == "TRUE") {
//         GD_DETAIL.ColumnProp('PAY_DT', 'EDIT')             = "None";       // 부과년월
//         GD_DETAIL.ColumnProp('PAY_AMT','EDIT')             = "None";       // 입금액(관리비)
//         GD_DETAIL.ColumnProp('PAY_ARR_AMT','EDIT')      = "None";    // 연체료(관리비)
//         //GD_DETAIL.ColumnProp('PAY_RENT_AMT','EDIT')        = "None";       // 입금액(임대료)
//         //GD_DETAIL.ColumnProp('PAY_RENT_ARREAR_AMT','EDIT') = "None";    // 연체료(임대료)
        
//         //enableControl(EM_BAL_AMT, false);
//         enableControl(IMG_ADD_ROW, false);
//         enableControl(IMG_DEL_ROW, false);  
//     } else {
//         GD_DETAIL.ColumnProp('PAY_DT', 'EDIT')             = "";           // 부과년월
//         GD_DETAIL.ColumnProp('PAY_AMT','EDIT')             = "NUMERIC";    // 입금액(관리비)
//         GD_DETAIL.ColumnProp('PAY_ARR_AMT','EDIT')      = "NUMERIC";    // 연체료(관리비)
//         //GD_DETAIL.ColumnProp('PAY_RENT_AMT','EDIT')        = "NUMERIC";    // 입금액(임대료)
//         //GD_DETAIL.ColumnProp('PAY_RENT_ARREAR_AMT','EDIT') = "NUMERIC";    // 연체료(임대료)
//         //enableControl(EM_BAL_AMT, true);
//         enableControl(IMG_ADD_ROW, true);
//         enableControl(IMG_DEL_ROW, true);
//     }

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
    //재조회
    btn_Search(g_currKey);
</script>

<script language=JavaScript for=TR_SUB event=onSuccess>
    for(i=0;i<TR_SUB.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SUB.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN2 event=onFail>
trFailed(TR_MAIN2.ErrorMsg);
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
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
//화면
if (row > 0) {
    getDetail(row);   //입금내역
    getCalBal(row);   //미수내역
    
    //enableControl(IMG_ADD_ROW, true);
    //enableControl(IMG_DEL_ROW, true);  
} else {
    //enableControl(IMG_ADD_ROW, false);
    //enableControl(IMG_DEL_ROW, false);	
	DS_IO_DETAIL.ClearData();
}
</script>

<script language=JavaScript for=DS_IO_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return;
//화면
if (row > 0) {
	if (IMG_ADD_ROW.disabled)  {
        //GD_DETAIL.ColumnProp('PAY_DT', 'EDIT')    = "None";       // 부과년월
        //GD_DETAIL.ColumnProp('PAY_AMT','EDIT')    = "None";       // 입금액
		return;
	} else {
	    if (DS_IO_DETAIL.RowStatus(row) == 1) {
	    	GD_DETAIL.ColumnProp('PAY_DT', 'EDIT')               = "";           // 부과년월
	    	GD_DETAIL.ColumnProp('PAY_AMT','EDIT')               = "NUMERIC";    // 입금액/
	    	GD_DETAIL.ColumnProp('PAY_ARR_AMT','EDIT')        = "NUMERIC";    // 연체료
	    	//GD_DETAIL.ColumnProp('PAY_RENT_AMT','EDIT')          = "NUMERIC";    // 입금액(임대료)
	    	//GD_DETAIL.ColumnProp('PAY_RENT_ARREAR_AMT','EDIT')   = "NUMERIC";    // 연체료(임대료)
	    } else {
	        GD_DETAIL.ColumnProp('PAY_DT', 'EDIT') = "None";     // 부과년월
	    	if (DS_IO_DETAIL.NameValue(row, "SAP_IF_FLAG") == "0") {   // SAP미전송
	    		GD_DETAIL.ColumnProp('PAY_AMT','EDIT')               = "NUMERIC";    // 입금액
		    	GD_DETAIL.ColumnProp('PAY_ARR_AMT','EDIT')        = "NUMERIC";    // 연체료
		    	//GD_DETAIL.ColumnProp('PAY_RENT_AMT','EDIT')          = "NUMERIC";    // 입금액(임대료)
		    	//GD_DETAIL.ColumnProp('PAY_RENT_ARREAR_AMT','EDIT')   = "NUMERIC";    // 연체료(임대료)
	    	} else { //1:전송,2:처리완료(SAP_SLIP_NO리턴시)
	    		GD_DETAIL.ColumnProp('PAY_AMT','EDIT')               = "None";    // 입금액
		    	GD_DETAIL.ColumnProp('PAY_ARR_AMT','EDIT')        = "None";    // 연체료
		    	//GD_DETAIL.ColumnProp('PAY_RENT_AMT','EDIT')          = "None";    // 입금액(임대료)
		    	//GD_DETAIL.ColumnProp('PAY_RENT_ARREAR_AMT','EDIT')   = "None";    // 연체료(임대료)
	    	}
	    }
	}
}
</script>

<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
if (!g_saveFlag) {
    if (DS_O_MASTER.CountRow > 0) {
        if (DS_IO_DETAIL.IsUpdated) { //데이터 변경시
            var ret = showMessage(Question, YesNo, "USER-1049");
            if (ret == "1") {
            	DS_IO_DETAIL.ClearData();
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

<script language=JavaScript for=GD_DETAIL event=OnPopup(row,colid,data)>
if(colid == "PAY_DT"){
//적용시작일, 적용종료일자
    var ret = openCal(this,row,"PAY_DT");         
    
    if (ret == undefined) {
    } else {
    	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.Rowposition, "PAY_DT") = ret;
    	/*
    	var strCalYM = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CAL_YM");
    	var strChoiCalYM = ret.substring(0,6);
    	if (strCalYM == strChoiCalYM) {
	    	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.Rowposition, "PAY_DT") = ret;
    	} else {
    		showMessage(INFORMATION, OK, "USER-1000", "입금일은 부과년월 내에서만 가능합니다.");
    	}*/    	
    }
}
</script>

<script language=JavaScript for=GD_DETAIL event=CanColumnPosChange(row,colid)>
if (colid == "PAY_DT") {
//입금일 일자체크
    if (DS_IO_DETAIL.NameValue(row,colid) == "") {
        return true; 
    } else { 
        return checkDateTypeYMD(GD_DETAIL, colid, DS_IO_DETAIL.OrgNameValue(row,colid));
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

<script language=JavaScript for=DS_RENT_FLAG event=OnFilter(row)>
// [조회용]임대형태
if (DS_RENT_FLAG.NameValue(row,"CODE") == "%" || DS_RENT_FLAG.NameValue(row,"CODE") == "3" || DS_RENT_FLAG.NameValue(row,"CODE") == "4") { //임대갑, 임대을만
    return true;
} else { 
    return false;
}
</script>

<script language=JavaScript for=EM_ARR_AMT event=OnKillFocus()>
	DS_IO_DETAIL.NameValue(1, "BAL_AMT") = EM_ARR_AMT.Text;
</script>

<!-- 관리비/임대료 선택이벤트 처리 -->
<script language=JavaScript for=RD_CAL_FLAG event=OnSelChange()>

if(this.CodeValue == "M"){
	document.getElementById('title2').innerHTML = "관리비 입금 내역";
	//document.getElementById('title1').innerHTML = "관리비 정산 내역";
    GD_DETAIL.ColumnProp('PAY_AMT','show')= true;
    GD_DETAIL.ColumnProp('PAY_ARR_AMT','show')= true;
    //GD_DETAIL.ColumnProp('PAY_RENT_AMT','show')= false;
    //GD_DETAIL.ColumnProp('PAY_RENT_ARREAR_AMT','show')= false;
}else if(this.CodeValue == "R"){
    document.getElementById('title2').innerHTML = "임대료 입금 내역";
    //document.getElementById('title1').innerHTML = "임대료 정산 내역";
    //GD_DETAIL.ColumnProp('PAY_AMT','show')= false;
    //GD_DETAIL.ColumnProp('PAY_ARR_AMT','show')= false;
    //GD_DETAIL.ColumnProp('PAY_RENT_AMT','show')= true;
    //GD_DETAIL.ColumnProp('PAY_RENT_ARREAR_AMT','show')= true;
}

btn_Search();
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
<comment id="_NSID_"><object id="DS_O_MASTER"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_COUNT"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_CALBAL"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_STR_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_RENT_FLAG"      classid=<%=Util.CLSID_DATASET%>><param name=UseFilter value=true></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PAY_FLAG"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_MOD_REASON"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSE_YN"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용  -->
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
<object id="TR_SUB" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝
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
						<th width="70" class="point">시설구분</th>
						<td width="145"><comment id="_NSID_"><object
							id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="143"
							tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
						<th width="70" class="point">부과년월</th>
						<td width="120"><comment id="_NSID_"><object
							id=EM_S_CAL_YM classid=<%=Util.CLSID_EMEDIT%> width="85"
							tabindex=1 onblur="javascript:checkDateTypeYM(this);"
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('M',EM_S_CAL_YM);" /></td>
						<th width="70">협력사</th>
						<td><comment id="_NSID_"> <object id=EM_S_VEN_CD
							classid=<%=Util.CLSID_EMEDIT%> width="70" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:callPopup('sVen');" align="absmiddle" /> <comment
							id="_NSID_"> <object id=EM_S_VEN_NM
							classid=<%=Util.CLSID_EMEDIT%> width="130" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="70">임대형태</th>
						<td><comment id="_NSID_"> <object
							id=LC_S_RENT_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width="140" tabindex=1
							height=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="70">입금상태구분</th>
						<td ><comment id="_NSID_"> <object
							id=LC_S_PAY_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width="110" tabindex=1
							height=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="70">조회구분</th>
						<td><comment id="_NSID_"> <object
                            id=RD_CAL_FLAG classid=<%=Util.CLSID_RADIO%>
                            style="height: 20; width: 127" tabindex=1>
                            <param name=Cols value="2">
                            <param name=Format value="M^관리비">
                            <param name=CodeValue value="1">
                            <param name=AutoMargin value="true">
                        </object> </comment><script> _ws_(_NSID_);</script></td>
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
	<tr valign="top">
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td width="300">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"><OBJECT id=GD_MASTER
							width=400 height=770 tabindex=1 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_O_MASTER">
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
									align="absmiddle" />관리비 정산내역</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="PT01 PB03">
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="20" rowspan="7">당<br><br>월</th>
								<th>임대료(VAT제외)</th>
								<td width="110"><comment id="_NSID_"> <object id=EM_RENT_NOVAT_AMT
									classid=<%=Util.CLSID_EMEDIT%> width="100" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>								
								<th width="20" rowspan="4">미<br>수</th>
								<th width="80">임대료</th>
								<td><comment id="_NSID_"> <object id=EM_RENT_BAL_AMT
									classid=<%=Util.CLSID_EMEDIT%> width="100" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th width="100">임대료VAT</th>
								<td><comment id="_NSID_"> <object id=EM_RENT_VAT_AMT
									classid=<%=Util.CLSID_EMEDIT%> width="100" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>								
								<th width="80">임대료<br>연체이자</th>
								<td><comment id="_NSID_"> <object id=EM_MOD_RENT_ARREAR_AMT
									classid=<%=Util.CLSID_EMEDIT%> width="100" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th width="100">임대료(VAT포함)</th>
								<td><comment id="_NSID_"> <object id=EM_RENT_AMT
									classid=<%=Util.CLSID_EMEDIT%> width="100" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
								<th width="80">관리비</th>
								<td><comment id="_NSID_"> <object id=EM_BAL_AMT
									classid=<%=Util.CLSID_EMEDIT%> width="100" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>

							</tr>
							<tr>
								<th width="100">과세관리비<br>(VAT제외)</th>
								<td><comment id="_NSID_"> <object id=EM_TAX_NOVAT_AMT
									classid=<%=Util.CLSID_EMEDIT%> width="100" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
								
								<th width="80">관리비<br>연체이자</th>
								<td><comment id="_NSID_"> <object id=EM_ARREAR_AMT
									classid=<%=Util.CLSID_EMEDIT%> width="100" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>							
							<tr>
								<th width="100">과세관리비VAT</th>
								<td><comment id="_NSID_"> <object id=EM_TAX_VAT_AMT
									classid=<%=Util.CLSID_EMEDIT%> width="100" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
								<td colspan="3"></td>
								
							</tr>
							<tr>
								<th width="100">과세관리비<br>(VAT포함)</th>
								<td><comment id="_NSID_"> <object id=EM_TAX_AMT
									classid=<%=Util.CLSID_EMEDIT%> width="100" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
								<th width="20" rowspan="2">청<br>구<br>액</th>
								<th width="80">관리청구액</th>
								<td><comment id="_NSID_"> <object id=EM_REAL_CHAREG_AMT
									classid=<%=Util.CLSID_EMEDIT%> width="100" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>									
							</tr>
							<tr>
								<th width="100">면세관리비</th>
								<td><comment id="_NSID_"> <object id=EM_NTAX_AMT
									classid=<%=Util.CLSID_EMEDIT%> width="100" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
								<th width="80">임대청구액</th>
								<td><comment id="_NSID_"> <object id=EM_RENT_REAL_CHAREG_AMT
									classid=<%=Util.CLSID_EMEDIT%> width="100" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
							<tr>
							    <th width="20">조정</th>
								<th>사유</th>
								<td><comment id="_NSID_"> <object id=LC_MOD_REASON
									classid=<%=Util.CLSID_LUXECOMBO%> width="105" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
								<td colspan="3"></td>	
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="dot"></td>
					</tr>
					<tr>
						<td class="PT10">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td ><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
									align="absmiddle" /> <span id="title2" style="Color: 146ab9">관리비 입금내역</span></td>
                                <td class="right"><img id="IMG_ADD_ROW"
                                    onclick="btn_AddRow();" src="/<%=dir%>/imgs/btn/add_row.gif"
                                    hspace="2" /> <img id="IMG_DEL_ROW" onclick="btn_DeleteRow();"
                                    src="/<%=dir%>/imgs/btn/del_row.gif" /></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="BD4A">
							<tr>
								<td><comment id="_NSID_"><OBJECT id=GD_DETAIL
									width=100% height=250 tabindex=1 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_IO_DETAIL">
								</OBJECT></comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="dot"></td>
					</tr>
					<tr>
						<td class="PT10">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
									align="absmiddle" />관리비 부과 예정 미수금</td>
							</tr>
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0"
										class="s_table">
								<tr>
								<th width="100" >익월부과<br>미수연체이자</th>
								<td width="110" ><comment id="_NSID_"><object
									id=EM_ARR_AMT style="vertical-align: middle;"
									classid=<%=Util.CLSID_EMEDIT%> width="100"></object></comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="80">미수 원금</th>
								<td  width="130"  ><comment id="_NSID_"><object
									id=EM_BAL_ARR_AMT style="vertical-align: middle;"
									classid=<%=Util.CLSID_EMEDIT%> width="120"></object></comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="100">당월<br>미수연체이자</th>
								<td ><comment id="_NSID_"><object
									id=EM_BAL_ARREAR_AMT style="vertical-align: middle;"
									classid=<%=Util.CLSID_EMEDIT%> width="100"></object></comment><script>_ws_(_NSID_);</script>
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
    <param name=DataID value=DS_O_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
       <c>Col=RENT_NOVAT_AMT      	Ctrl=EM_RENT_NOVAT_AMT        	param=Text</c> 
       <c>Col=RENT_VAT_AMT      	Ctrl=EM_RENT_VAT_AMT        	param=Text</c>
       <c>Col=RENT_AMT          	Ctrl=EM_RENT_AMT            	param=Text</c>
       <c>Col=TAX_NOVAT_AMT       	Ctrl=EM_TAX_NOVAT_AMT         	param=Text</c>
       <c>Col=TAX_VAT_AMT       	Ctrl=EM_TAX_VAT_AMT         	param=Text</c>
       <c>Col=TAX_AMT           	Ctrl=EM_TAX_AMT             	param=Text</c>
       <c>Col=NTAX_AMT          	Ctrl=EM_NTAX_AMT            	param=Text</c>
       <c>Col=RENT_BAL_AMT          Ctrl=EM_RENT_BAL_AMT            param=Text</c>
       <c>Col=MOD_RENT_ARREAR_AMT   Ctrl=EM_MOD_RENT_ARREAR_AMT     param=Text</c>
       <c>Col=BAL_AMT               Ctrl=EM_BAL_AMT             	param=Text</c>
       <c>Col=MOD_ARREAR_AMT        Ctrl=EM_ARREAR_AMT          	param=Text</c>
       <c>Col=MOD_REASON        	Ctrl=LC_MOD_REASON         		param=BindColVal</c>
       <c>Col=REAL_CHAREG_AMT   	Ctrl=EM_REAL_CHAREG_AMT     	param=Text</c>
       <c>Col=RENT_REAL_CHAREG_AMT  Ctrl=EM_RENT_REAL_CHAREG_AMT    param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=BD_IO_CALBAL classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_IO_CALBAL>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
       <c>Col=BAL_AMT          	Ctrl=EM_BAL_ARR_AMT		           	param=Text</c>
       <c>Col=ARR_AMT     	 	Ctrl=EM_ARR_AMT        				param=Text</c>
       <c>Col=BAL_ARREAR_AMT	Ctrl=EM_BAL_ARREAR_AMT      		param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

