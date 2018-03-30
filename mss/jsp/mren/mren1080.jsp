<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 계량기 관리
 * 작 성 일 : 2010.01.14
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : MREN1080.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 계량기 관리
 * 이    력 : 2010.01.14(박래형) 신규작성
 *         2010.01.14(김유완) 수정작성
 *         2011.07.18(FKSS) 수정 
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
	SessionInfo sessionInfo = (SessionInfo) session .getAttribute("sessionInfo");
	String contextRoot = request.getContextPath();
	String dir = BaseProperty.get("context.common.dir");
	
    //기본 URL
    String u = javax.servlet.http.HttpUtils.getRequestURL(request).toString(); 
    String webDir = u.substring(0, u.lastIndexOf("mss")-1);
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

<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var g_saveFlag = false;
var g_currRow  = 1;
var g_autoFlag = false;
var g_openPage = true; //파일다운로드에 사용 할 변수
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.01.14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_MR_GAUGMST_DTL"/>');
    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_GAUGMST"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER,DS_IO_DETAIL");
    
    //그리드 초기화
    gridCreate("dtl"); //상세
    gridCreate("mst"); //마스터
    
    initComboStyle(LC_S_FCL_FLAG,DS_S_FCL_FLAG,             "CODE^0^30,NAME^0^80", 1, PK);      // [조회용]시설구분(조회) 
    initComboStyle(LC_S_GAUG_TYPE,DS_S_GAUG_TYPE,           "CODE^0^30,NAME^0^80", 1, PK);      // [조회용]계량기구분(조회)
    initEmEdit(EM_S_GAUG_ID,        "CODE^20^#",NORMAL);                                        // [조회용]계량기ID(조회)
    EM_S_GAUG_ID.UpperFlag = 1;                                                                 // [조회용]계량기ID대문자
    initEmEdit(EM_S_INST_PLC,       "GEN^40",READ);                                             // [조회용]설치장소
    
    initEmEdit(EM_GAUG_ID,          "CODE^20^#",READ);                                          // 계량기ID 
    initComboStyle(LC_GAUG_TYPE,DS_GAUG_TYPE,               "CODE^0^30,NAME^0^80", 1, PK);    // 계량기구분  
    initComboStyle(LC_FCL_FLAG,DS_FCL_FLAG,                 "CODE^0^30,NAME^0^80", 1, PK);      //  시설구분  //0718 FKSS
    initEmEdit(EM_HIGH_GAUG_ID,   "CODE^20^#",PK);                                        // 상위계량기ID
    initEmEdit(EM_INST_PLC,         "GEN^40",NORMAL);                                             // 설치장소
    initComboStyle(LC_GAUG_LVL,DS_GAUG_LVL,                 "CODE^0^30,NAME^0^80", 1, PK);    // 계량기레벨
    initComboStyle(LC_GAUG_USE_FLAG,DS_GAUG_USE_FLAG,       "CODE^0^30,NAME^0^80", 1, PK);      // 계량기사용구분
    initComboStyle(LC_DIV_RULE_TYPE,DS_DIV_RULE_TYPE,       "CODE^0^30,NAME^0^80", 1, PK);      // 공동안분기준
    initComboStyle(LC_GAUG_KIND_CD,DS_GAUG_KIND_CD,         "CODE^0^30,NAME^0^80", 1, PK);      // 계량기용도
    initComboStyle(LC_PWR_TYPE,DS_PWR_TYPE,                 "CODE^0^30,NAME^0^80", 1, NORMAL);  // 전압
    initComboStyle(LC_PWR_SEL_CHARGE,DS_PWR_SEL_CHARGE,     "CODE^0^30,NAME^0^80", 1, NORMAL);  // 선택요금제
    initEmEdit(EM_PWR_CNTR_QTY,     "NUMBER^7^2",NORMAL);                                       // 계약전력  
    initEmEdit(EM_PWR_REVER_RATE,   "NUMBER^7^2",NORMAL);                                       // 전기역률  
    initEmEdit(EM_GAUG_MULTIPLE,    "NUMBER^9^2",NORMAL);                                       // 계량기배수
    initEmEdit(EM_USE_EQUIP_QTY,    "NUMBER^7^0",NORMAL);                                       // (가로등)사용설비용량  
    initComboStyle(LC_WWTR_CHARGE_YN,DS_WWTR_CHARGE_YN,     "CODE^0^30,NAME^0^80", 1, NORMAL);  // 온수차등요금제
    initComboStyle(LC_WTR_CAL_SIZE,DS_WTR_CAL_SIZE,         "CODE^0^30,NAME^0^80", 1, NORMAL);  // 수도계량기구경
    initEmEdit(EM_VALID_S_DT,       "YYYYMMDD", NORMAL);                                          // 유효시작일자
    initEmEdit(EM_VALID_E_DT,       "YYYYMMDD", NORMAL);                                          // 유효종료일자
    initEmEdit(EM_FILE_PATH,        "GEN^50",READ);                                             // 첨부파일 

    getFlc("DS_S_FCL_FLAG",             "M", "1", "Y", "N");                                    // [조회용]시설구분(점코드)
    LC_S_FCL_FLAG.index = "0"; // 시설구분
    LC_S_FCL_FLAG.focus();
    getEtcCode("DS_S_GAUG_TYPE",        "D", "M039", "N", "N", LC_S_GAUG_TYPE);                 // [조회용]계량기구분 
    getEtcCode("DS_GAUG_TYPE",          "D", "M039", "N");                                      // 계량기구분
    getEtcCode("DS_GAUG_LVL",           "D", "M086", "N");                                      // 계량기레벨
    getEtcCode("DS_GAUG_USE_FLAG",      "D", "M040", "N");                                      // 계량기사용구분
    getEtcCode("DS_DIV_RULE_TYPE",      "D", "M041", "N");                                      // 공동안분기준
    getEtcCode("DS_GAUG_KIND_CD",       "D", "M045", "N");                                      // 계량기용도
    getEtcCode("DS_PWR_TYPE",           "D", "M047", "N");                                      // 전압
    getEtcCode("DS_PWR_SEL_CHARGE",     "D", "M081", "N");                                      // 전기선택요금제
    getEtcCode("DS_WWTR_CHARGE_YN",     "D", "D022", "N");                                      // 온수차등요금제 사용유무
    getEtcCode("DS_WTR_CAL_SIZE",       "D", "M087", "N");                                      // 수도계량기구경
    
    getFlc("DS_FCL_FLAG",             "M", "1", "Y", "N");                                       // 시설구분(점코드) FKSS

    //기본 비활성화 항목들
    objectControlDefault();
    /*PDF Files , Word Files, 압축 Files*/
    INF_FILEUPLOAD.FileFilterString = 2+128+256; 
}

function gridCreate(strGbn){
	var hdrProperies ='';
	if (strGbn=='mst') {
		hdrProperies = ''
			+ '<FC>ID={CURROW}           NAME="NO"' 
			+ '                                                  WIDTH=40      ALIGN=CENTER</FC>'
			+ '<FC>ID=GAUG_ID            NAME="계량기 ID"'         
			+ '                                                  WIDTH=100     ALIGN=CENTER</FC>'
			+ '<FC>ID=INST_PLC           NAME="설치장소"'           
			+ '                                                  WIDTH=120     ALIGN=LEFT</FC>';
			initGridStyle(GD_MASTER, "common", hdrProperies, false);
	} else {
        hdrProperies = ''
			+ '<FC>ID={CURROW}           NAME="NO"' 
			+ '                                                  WIDTH=40      ALIGN=CENTER</FC>'
			+ '<FC>ID=GAUG_ID            NAME="*계량기 ID"'          
			+ '                                                  WIDTH=100     ALIGN=CENTER    EDIT=ALPHANUM   EDITSTYLE=POPUP</FC>'
			+ '<FC>ID=INST_PLC           NAME="설치장소"'         
			+ '                                                  WIDTH=150     ALIGN=LEFT      EDIT=NONE</FC>'
			+ '<FC>ID=GAUG_LVL           NAME="계량기레벨"'         
			+ '                                                  WIDTH=100     ALIGN=LEFT      EDIT=NONE   EDITSTYLE=LOOKUP    DATA="DS_GAUG_LVL:CODE:NAME"</FC>'
			+ '<FC>ID=VALID_S_DT         NAME="유효시작일자"'         
			+ '                                                  WIDTH=100     ALIGN=CENTER    EDIT=NONE   MASK="XXXX/XX/XX"</FC>'
			+ '<FC>ID=VALID_E_DT         NAME="유효종료일자"'           
			+ '                                                  WIDTH=100     ALIGN=CENTER    EDIT=NONE   MASK="XXXX/XX/XX"</FC>';
            initGridStyle(GD_DETAIL, "common", hdrProperies, true);
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
 * 작 성 일 : 2010.01.14
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
            // parameters
            var strFlcFlag  = LC_S_FCL_FLAG.BindColVal;     // [조회용]시설구분(점코드)
            var strGaugType = LC_S_GAUG_TYPE.BindColVal;    // [조회용]계량기구분(점코드)
            var strGaugID   = EM_S_GAUG_ID.Text;            // [조회용]계량기ID
            var goTo = "getMaster";
            var parameters = ""
                + "&strFlcFlag="    + encodeURIComponent(strFlcFlag)
                + "&strGaugType="   + encodeURIComponent(strGaugType)
                + "&strGaugID="     + encodeURIComponent(strGaugID);
            TR_MAIN.Action = "/mss/mren108.mr?goTo=" + goTo + parameters;
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
        // parameters
        var strFlcFlag  = LC_S_FCL_FLAG.BindColVal;     // [조회용]시설구분(점코드)
        var strGaugType = LC_S_GAUG_TYPE.BindColVal;    // [조회용]계량기구분(점코드)
        var strGaugID   = EM_S_GAUG_ID.Text;            // [조회용]계량기ID
        var goTo = "getMaster";
        var parameters = ""
            + "&strFlcFlag="    + encodeURIComponent(strFlcFlag)
            + "&strGaugType="   + encodeURIComponent(strGaugType)
            + "&strGaugID="     + encodeURIComponent(strGaugID);
        TR_MAIN.Action = "/mss/mren108.mr?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();
        // 조회결과 Return
        setPorcCount("SELECT", GD_MASTER);
    }
    
    if (DS_IO_MASTER.CountRow > 0) {    	
    	objectControl(true);
    	objectControlType1();
    	enableControl(IMG_FILE_SEARCH, true);
    	
        if (arguments[0] == undefined || arguments[0] == 1) {
            g_currRow = 1;
        } else {
            DS_IO_MASTER.RowPosition = arguments[0];
        }
    } else {
    	objectControlDefault();
    }
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.28
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	if (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1) {//변경데이터 있을 시 확인
	    var ret = showMessage(Question, YesNo, "USER-1050");
	    if (ret == "1") {
	    	DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
			DS_IO_MASTER.AddRow();
	    } else {
	    	return;
	    }
	} else {
        //DS_IO_MASTER.ClearData();
        DS_IO_MASTER.AddRow();        
        objectControl(true);
      //  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CHK_STAY") = 'T';
	}
	
	//LC_FCL_FLAG.Focus();
	//LC_FCL_FLAG.index = "0"; 
	//objectControlDtl(true);
    //objectControlDefault(true);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.01.14
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    //저장 시  CanRowPosChange 이벤트 우회 flag
    g_saveFlag = true;
    if (DS_IO_MASTER.IsUpdated||DS_IO_DETAIL.IsUpdated) {//변경 데이터가 있을때만 저장
        //필수 입력값 체크
        if (!checkValidate()) {
            g_saveFlag = false;
            return;
        }
        
      //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_DETAIL.Focus();
            return;
        }   
        //저장
        g_currRow = DS_IO_MASTER.RowPosition;
        var goTo = "save";
        TR_SAVE.Action = "/mss/mren108.mr?goTo=" + goTo;
        TR_SAVE.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)";
        TR_SAVE.Post();
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
    } 
    g_saveFlag = false;
}


/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
/**
 * saveAsFiles()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 값체크(저장)
 * return값 :
 */
function saveAsFiles() {
    var strPath   = "upload/";    
    var strFileNm = DS_IO_MASTER.NameValue(DS_IO_MASTER.Rowposition, "OLD_FILE_PATH"); 
    strFileNm = strFileNm.substring(strFileNm.lastIndexOf("/")+1);
    if( strFileNm != null  ) {                          
        iFrame.location.href="/mss/jsp/fileDownload.jsp?strPath="+strPath+"&strFileNm="+strFileNm;
    }  
}

/**
 * checkValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidate() {
	 //입력 필수 입력 체크
	 if (LC_GAUG_TYPE.BindColVal == "") {
         showMessage(INFORMATION, OK, "USER-1003", "계량기구분");
         return false;
     } 
     
     if (LC_FCL_FLAG.BindColVal == "") {
         showMessage(INFORMATION, OK, "USER-1003", "시설구분");
         return false;
     }
	//서브계량기 중복체크
	for (var k=1; k<=DS_IO_DETAIL.CountRow; k++) {
        //계량기ID체크
        /* 계량기ID MAX+1 로 변경 2011.08.01 lee
        if (DS_IO_DETAIL.NameValue(i, "GAUG_ID") == "") {
            DS_IO_DETAIL.RowPosition = i;
            showMessage(INFORMATION, OK, "USER-1002", "계량기ID");
            return false;
        }  
        */        
		
		//중복값 체크
		for (var i=k+1; i<=DS_IO_DETAIL.CountRow; i++) {
			if (DS_IO_DETAIL.NameValue(k, "GAUG_ID") == DS_IO_DETAIL.NameValue(i, "GAUG_ID")) {
				DS_IO_DETAIL.RowPosition = i;
				showMessage(INFORMATION, OK, "USER-1000", k+"번째 행과 "+i+"번째  행의 계량기ID가 중복됩니다.");
				return false;
			} 
		}
	} 
	return true;
}
 
/**
 * getDetail()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 공통코드가져오기
 * return값 :
 */
function getDetail() {  
    // parameters
    var strFlcFlag  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD") // 시설구분(점코드)
    var strGaugID   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_ID") // 계량기ID
    var goTo = "getDetail";
    var parameters = ""
        + "&strFlcFlag="    + encodeURIComponent(strFlcFlag)
        + "&strGaugID="     + encodeURIComponent(strGaugID);
    TR_SUB.Action = "/mss/mren108.mr?goTo=" + goTo + parameters;
    TR_SUB.KeyValue = "SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)";
    TR_SUB.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_DETAIL.CountRow);
}

/**
 * objectControl()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 입력값 컨트롤
 * return값 :
 */
function objectControlDefault() {
    enableControl(IMG_VALID_S_DT, false);
    enableControl(IMG_VALID_E_DT, false);
    enableControl(IMG_FILE_DOWN, false);
    enableControl(IMG_FILE_DEL, false);
    //초기화면
    LC_GAUG_TYPE.Enable      = false;
    LC_FCL_FLAG.Enable       = false;
    LC_GAUG_LVL.Enable       = false;    
    LC_GAUG_USE_FLAG.Enable  = false;       
    LC_DIV_RULE_TYPE.Enable  = false;      
    LC_PWR_TYPE.Enable       = false; 
    LC_GAUG_KIND_CD.Enable   = false;         
    LC_WWTR_CHARGE_YN.Enable = false;  
    LC_WTR_CAL_SIZE.Enable   = false; 
    LC_PWR_SEL_CHARGE.Enable = false;    
    EM_PWR_CNTR_QTY.Enable   = false;  
    EM_VALID_E_DT.Enable     = false;    
    EM_VALID_S_DT.Enable     = false;  
    EM_PWR_REVER_RATE.Enable = false;   //전기역률
    EM_GAUG_MULTIPLE.Enable  = false;   //계량기배수
    EM_USE_EQUIP_QTY.Enable  = false;   //(가로등)사용설비용량
    EM_HIGH_GAUG_ID.Enable   = false;
    EM_INST_PLC.Enable       = false;
 //   enableControl(IMG_DEL_ROW, false);
 //   enableControl(IMG_ADD_ROW, false);
    enableControl(IMG_FILE_SEARCH, false);
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
    	LC_GAUG_TYPE.Enable      = true;
        LC_FCL_FLAG.Enable       = true;
        LC_GAUG_LVL.Enable       = true;
		LC_GAUG_USE_FLAG.Enable  = true;       
		LC_DIV_RULE_TYPE.Enable  = true;      
		LC_PWR_TYPE.Enable       = true; 
		LC_GAUG_KIND_CD.Enable   = true;         
		LC_WWTR_CHARGE_YN.Enable = true;  
		LC_WTR_CAL_SIZE.Enable   = true;  
		LC_PWR_SEL_CHARGE.Enable = true;    
		EM_PWR_CNTR_QTY.Enable   = true;  
		EM_INST_PLC.Enable       = true;
		EM_PWR_REVER_RATE.Enable = true;
		EM_GAUG_MULTIPLE.Enable  = true;
		EM_USE_EQUIP_QTY.Enable  = true;
        EM_VALID_E_DT.Enable     = true;   
        EM_VALID_S_DT.Enable     = true;
        EM_HIGH_GAUG_ID.Enable   = true;
        EM_INST_PLC.Enable       = true;
        enableControl(IMG_VALID_S_DT, true);
        enableControl(IMG_VALID_E_DT, true);
        enableControl(IMG_FILE_SEARCH, true);
    } else {
    	LC_GAUG_TYPE.Enable      = false;
        LC_FCL_FLAG.Enable       = false;
        LC_GAUG_LVL.Enable       = false;
        LC_GAUG_USE_FLAG.Enable  = false;       
        LC_DIV_RULE_TYPE.Enable  = false;      
        LC_PWR_TYPE.Enable       = false; 
        LC_GAUG_KIND_CD.Enable   = false;         
        LC_WWTR_CHARGE_YN.Enable = false;  
        LC_WTR_CAL_SIZE.Enable   = false; 
        LC_PWR_SEL_CHARGE.Enable = false;    
        EM_PWR_CNTR_QTY.Enable   = false;        
        EM_VALID_E_DT.Enable     = false;    
        EM_VALID_S_DT.Enable     = false;
        EM_HIGH_GAUG_ID.Enable   = false;
        EM_INST_PLC.Enable       = false;
        enableControl(IMG_DEL_ROW, false);
        enableControl(IMG_ADD_ROW, false);
        enableControl(IMG_FILE_SEARCH, false);
    }
}

/**
 * objectControlType1()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 계량기 구분에 따른 항목변경
 * return값 :
 */
function objectControlType1() {
	 //계량기구분 변경 시	 
	 if (LC_GAUG_TYPE.BindColVal == "10") { //전력일 시
	     LC_GAUG_KIND_CD.Enable     = true;  //계량기용도
	     LC_PWR_TYPE.Enable         = true;  //전압
	     LC_PWR_SEL_CHARGE.Enable   = true;  //선택요금제
	     EM_PWR_CNTR_QTY.Enable     = true;  //계약전력
	     LC_WWTR_CHARGE_YN.Enable   = false; //온수차등요금제
	     LC_WTR_CAL_SIZE.Enable     = false; //수도계량기구경
	 } else if (LC_GAUG_TYPE.BindColVal == "20") { //온수일 시
	     LC_GAUG_KIND_CD.Enable     = true;  //계량기용도
	     LC_PWR_TYPE.Enable         = false; //전압
	     LC_PWR_SEL_CHARGE.Enable   = false; //선택요금제
	     EM_PWR_CNTR_QTY.Enable     = false; //계약전력
	     LC_WWTR_CHARGE_YN.Enable   = true;  //온수차등요금제
	     LC_WTR_CAL_SIZE.Enable     = false; //수도계량기구경
	 } else if (LC_GAUG_TYPE.BindColVal == "50") { //가스일 시
	     LC_GAUG_KIND_CD.Enable     = true;  //계량기용도
	     LC_PWR_TYPE.Enable         = false; //전압
	     LC_PWR_SEL_CHARGE.Enable   = false; //선택요금제
	     EM_PWR_CNTR_QTY.Enable     = false; //계약전력
	     LC_WWTR_CHARGE_YN.Enable   = false;  //온수차등요금제
	     LC_WTR_CAL_SIZE.Enable     = false; //수도계량기구경
	 } else if (LC_GAUG_TYPE.BindColVal == "60") { //수도일 시
	     LC_GAUG_KIND_CD.Enable     = true;  //계량기용도
	     LC_PWR_TYPE.Enable         = false; //전압
	     LC_PWR_SEL_CHARGE.Enable   = false; //선택요금제
	     EM_PWR_CNTR_QTY.Enable     = false; //계약전력
	     LC_WWTR_CHARGE_YN.Enable   = false; //온수차등요금제
	     LC_WTR_CAL_SIZE.Enable     = true;  //수도계량기구경
	 } else {
	     LC_GAUG_KIND_CD.Enable     = false; //계량기용도
	     LC_PWR_TYPE.Enable         = false; //전압
	     LC_PWR_SEL_CHARGE.Enable   = false; //선택요금제
	     EM_PWR_CNTR_QTY.Enable     = false; //계약전력
	     LC_WWTR_CHARGE_YN.Enable   = false; //온수차등요금제
	     LC_WTR_CAL_SIZE.Enable     = false; //수도계량기구경
	 }
}

/**
 * objectControlType2()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 입력값 컨트롤(계량기레벨에 따른 기타 값 컨트룰)
 * return값 :
 */
function objectControlType2(objBoolean) {
    if (objBoolean) {
        LC_GAUG_KIND_CD.Enable   = true;         
		if (LC_GAUG_TYPE.BindColVal == "10") { //전력일시 전압 필터링
		    LC_PWR_TYPE.Enable   = true; 
		} else {
		    LC_PWR_TYPE.Enable   = false; 
		}
        
        LC_PWR_SEL_CHARGE.Enable = true;    
        EM_PWR_CNTR_QTY.Enable   = true;  
        LC_WWTR_CHARGE_YN.Enable = true;  
        LC_WTR_CAL_SIZE.Enable   = true; 
       // enableControl(IMG_DEL_ROW, true);
      //  enableControl(IMG_ADD_ROW, true);
        //enableControl(IMG_FILE_SEARCH, true);
    } else {
        LC_GAUG_KIND_CD.Enable   = false;         
        LC_PWR_TYPE.Enable       = false; 
        LC_PWR_SEL_CHARGE.Enable = false;    
        EM_PWR_CNTR_QTY.Enable   = false;  
        LC_WWTR_CHARGE_YN.Enable = false;  
        LC_WTR_CAL_SIZE.Enable   = false;
      //  enableControl(IMG_DEL_ROW, false);
       // enableControl(IMG_ADD_ROW, false);
        //enableControl(IMG_FILE_SEARCH, false);
    }
}

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
 * callPopup()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 팝업 호출
 * return값 :
 */
function callPopup1(popupNm) {
	if (popupNm == "gaugId") { // 계량기ID
	    var rt = getGaugIdPop(EM_HIGH_GAUG_ID, EM_S_INST_PLC, LC_FCL_FLAG.BindColVal, LC_GAUG_TYPE.BindColVal,  "S", "F", "");
	   /* if (rt) {
	        EM_S_INST_PLC.Text = rt.INST_PLC;
	    } */
	}
}

/**
 * deleteFile()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 파일열기
 * return값 :
 */
function deleteFile() {
     var strFlag = "";
     if (DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"FILE_PATH") != "") {
         strFlag = "D";
     } else {
         strFlag = "N";
     }

     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_GB") = strFlag;  // 파일Flag
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_PATH") = ""; // 경로명 표기
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_PATH_REAL") = ""; // 경로명 표기
}

/**
 * openFile()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 파일열기
 * return값 :
 */
function openFile() {
	//Fils Open창
	INF_FILEUPLOAD.Open();
	if (INF_FILEUPLOAD.SelectState) {
	    var strFileInfo = INF_FILEUPLOAD.Value; //파일이름
	    var tmpFileName = strFileInfo.substring(strFileInfo.lastIndexOf("\\")+1);
	    var strFileName = tmpFileName.substring(0, tmpFileName.lastIndexOf("."));
	    var chrByre = checkLenByteStr(strFileName);
	    var chrLen  = strFileName.length;
        /*if (chrByre != chrLen) {    // 파일명 한글
            showMessage(STOPSIGN, OK, "USER-1000", "파일명은 영문,숫자만으로 작성해주세요");
            return;
        } else */if (chrByre > 22) {  // 파일명 22Byte이내작성
	        showMessage(STOPSIGN, OK, "USER-1000", "파일명은 22Byte(영문,숫자22자)이내로 작성해주세요");
	        return;
	    } else {
	        if((1024 * 1024 * 5) < INF_FILEUPLOAD.FileInfo("size")){
	            showMessage(STOPSIGN, OK, "USER-1000", "업로드파일의 사이즈는 5M 를 넘을 수 없습니다.");
                var strFlag = "";
                if (DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"FILE_PATH") != "") {
                    strFlag = "D";
                } else {
                    strFlag = "N";
                }
	            
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_GB") = strFlag;  // 파일Flag
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_PATH") = ""; // 경로명 표기
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_PATH_REAL") = ""; // 경로명 표기
	        } else {
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_GB") = "Y";           // 파일Flag
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_PATH") = strFileInfo; // 파일경로(DB에서 변경)
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_PATH_REAL") = strFileInfo; // 파일경로(DB에서 변경)
	        }
	    }
	} 
}

/**
 * checkLenByteStr()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 문자열 Byte체크
 * return값 :
 */
function checkLenByteStr(str) {
    //byte체크
    var intByte = 0;
    for (k = 0; k < str.length; k++) {
        var onechar = str.charAt(k);
        if (escape(onechar).length > 4) {
            intByte += 2;
        } else {
            intByte++;
        }
    }
    return intByte;
}

/**
 * nonBindCol()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.06.01
 * 개    요 : 필터링 되는 값들은 가우스바인딩하지 않음
 * return값 :
 */
function nonBindCol(row) {
    DS_GAUG_KIND_CD.Filter(); //용도 필터링
    DS_PWR_TYPE.Filter();  //전압필터링
    DS_PWR_SEL_CHARGE.Filter();  //요금제필터링
    
    LC_GAUG_KIND_CD.index = LC_GAUG_KIND_CD.IndexOfColumn("CODE", DS_IO_MASTER.NameValue(row, "GAUG_KIND_CD"));
    LC_PWR_TYPE.index = LC_PWR_TYPE.IndexOfColumn("CODE", DS_IO_MASTER.NameValue(row, "PWR_TYPE"));
    LC_PWR_SEL_CHARGE.index = LC_PWR_SEL_CHARGE.IndexOfColumn("CODE", DS_IO_MASTER.NameValue(row, "PWR_SEL_CHARGE"));
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
    //저장 성공시 재조회
    btn_Search(g_currRow);
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
	//상세 조회
	getDetail();
	nonBindCol(row);
	
    // 파일다운로드 컨트롤
    if (DS_IO_MASTER.NameValue(row, "OLD_FILE_PATH").length > 0 ) {
        enableControl(IMG_FILE_DOWN,true);
        enableControl(IMG_FILE_DEL,true);
    } else {
        enableControl(IMG_FILE_DOWN,false);
        enableControl(IMG_FILE_DEL,false);
    }
	//계량기사용구분,공동안분기준
    // CES에만 적용[2010.04.12] LC_GAUG_USE_FLAG.Enable  = true;       
    // CES에만 적용[2010.04.12] LC_DIV_RULE_TYPE.Enable  = true;    
    
    //관리기준에따른 항목컨트롤 (시설구분 = 설치장소)
    //if (DS_IO_MASTER.NameValue(row, "STR_CD") == DS_IO_MASTER.NameValue(row, "INST_STR_CD")) {
        //objectControl(true); 시설구분 = 설치장소일 경우만 활성화
        // CES에만 적용[2010.04.12]  objectControlType1();
	    //계량기레벨에 따른 계량기 정복 항목 컨트롤
	    if (DS_IO_MASTER.NameValue(row, "GAUG_LVL") == "3") {
	        // CES에만 적용[2010.04.12]  objectControl(false);
	      //  enableControl(IMG_DEL_ROW, false);
	     //   enableControl(IMG_ADD_ROW, false);
	    } else {
	    //    enableControl(IMG_DEL_ROW, true);
	   //     enableControl(IMG_ADD_ROW, true);
	        // CES에만 적용[2010.04.12]  objectControlType1();
	    }
    //} else {
    	// CES에만 적용[2010.04.12]  objectControl(false);
        //enableControl(IMG_DEL_ROW, false);
        //enableControl(IMG_ADD_ROW, false);
    //}
    
    //유효종료일자 이후에는 서브계량기 등록불가
    if (eval(DS_IO_MASTER.OrgNameString(row, "VALID_E_DT")) < eval(getTodayFormat("YYYYMMDD")) ) {
     //   enableControl(IMG_DEL_ROW, false);
     //   enableControl(IMG_ADD_ROW, false);
    }

} else {
	DS_IO_DETAIL.ClearData();
}
</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
//저장 시 체크없음
if (g_saveFlag) return;  

if (DS_IO_MASTER.CountRow > 0) {
    if (DS_IO_MASTER.RowStatus(row) == 3 || DS_IO_DETAIL.IsUpdated) {
        var ret = showMessage(Question, YesNo, "USER-1049");
        if (ret == "1") {
        	setTimeout("rollBackRowData(DS_IO_MASTER, "+row+")", 50);
            return true;    
        } else {
            return false;   
        }
    }
    return true;
}
return true;
</script>

<script language=JavaScript for=DS_IO_DETAIL event=onRowPosChanged(row)>
if(clickSORT) return;
//상세(서브계량기)
if (DS_IO_DETAIL.CountRow > 0) {
	//그리드 컨트롤
	if (DS_IO_DETAIL.RowStatus(row) == 1 ) {
		GD_DETAIL.ColumnProp('GAUG_ID', 'EDIT')   = "ALPHANUM";
	} else {
		GD_DETAIL.ColumnProp('GAUG_ID', 'EDIT')   = "NONE";
	}
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
//헤더행위는 제외
if (row < 1) return;
//팝업입력은 제외
if (g_autoFlag) return;
if (colid == "GAUG_ID") {
    var strGaugId   = DS_IO_DETAIL.NameValue(row, "GAUG_ID");                           //해당 위치의 입력 값
    var strFlc      = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");       //설치 시설
    var strGaugType = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_TYPE");    //계량기 구분
    var strGaugLv   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_LVL");     //계량기 레벨
    var strGaugKind = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_KIND_CD"); //계량기 용도
    
    if (strGaugId.length > 0) {
        if (DS_IO_DETAIL.NameValue(row, "GAUG_ID") == olddata) return;
        getGaugIdNonPop( "DS_O_RESULT", strGaugId, strFlc, strGaugType, "G", "N", "T", strGaugKind, strGaugLv);
        
        if (DS_O_RESULT.CountRow != 1 ) {
            //1건 이외의 내역이 조회 시 팝업 호출
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_ID") = ""; //계량기ID
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INST_PLC") = ""; //설치장소
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_LVL") = ""; ///계량기레벨
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VALID_S_DT") = ""; ///유효시작일자
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VALID_E_DT") = ""; ///유효종료일자
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "HIGH_GAUG_ID") = "";
            var rt = getGaugIdPop(strGaugId, "",strFlc, strGaugType,  "M", "T", strGaugKind, strGaugLv);
            if (rt == undefined) return;

            var forCnt = 0;
            for(var i=0; i<rt.length; i++) {
                var validateChk = true;
                for (var k=1; k<=DS_IO_DETAIL.CountRow; k++) {
                    if (DS_IO_DETAIL.NameValue(k, "GAUG_ID") == rt[i].GAUG_ID) {
                        validateChk = false;
                        break;
                    }
                } 
                //중복값 없을시 처리
                if (validateChk) {
                    if (forCnt != 0) DS_IO_DETAIL.InsertRow(DS_IO_DETAIL.RowPosition);
                    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_ID") = rt[i].GAUG_ID;   //계량기ID
                    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INST_PLC") = rt[i].INST_PLC; //설치장소
                    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_LVL") = rt[i].GAUG_LVL; //계량기레벨
                    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VALID_S_DT") = rt[i].VALID_S_DT; //유효시작일자
                    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VALID_E_DT") = rt[i].VALID_E_DT; //유효종료일자
                    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "HIGH_GAUG_ID") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_ID");
                    forCnt++;
                }
            }
        } else {
            if (DS_O_RESULT.NameValue(1, "USE_YN") == "N") {
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_ID") = ""; //계량기ID
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INST_PLC") = ""; //설치장소
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_LVL") = ""; ///계량기레벨
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VALID_S_DT") = ""; ///유효시작일자
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VALID_E_DT") = ""; ///유효종료일자
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "HIGH_GAUG_ID") = "";
                setTimeout("showMessage(INFORMATION, OK, 'USER-1000', '선택한 계량기 ID는 이미 타 상위ID에 등록되어 있습니다.')", 100);
                return; 
           }
           var validateChk = true;
           for (var k=1; k<=DS_IO_DETAIL.CountRow; k++) {
        	   if (k != eval(DS_IO_DETAIL.RowPosition)) {
                   if (DS_IO_DETAIL.NameValue(k, "GAUG_ID") == DS_O_RESULT.NameValue(1, "GAUG_ID")) {
                       validateChk = false;
                       break;
                   } 	   
        	   }
           } 
           //중복값 없을시 처리
           if (validateChk) {
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_ID") = DS_O_RESULT.NameValue(1, "GAUG_ID");   //계량기ID
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INST_PLC") = DS_O_RESULT.NameValue(1, "INST_PLC"); //설치장소
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_LVL") = DS_O_RESULT.NameValue(1, "GAUG_LVL"); //계량기레벨
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VALID_S_DT") = DS_O_RESULT.NameValue(1, "VALID_S_DT"); //유효시작일자
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VALID_E_DT") = DS_O_RESULT.NameValue(1, "VALID_E_DT"); //유효종료일자
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "HIGH_GAUG_ID") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_ID");
           } else {
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_ID") = ""; //계량기ID
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INST_PLC") = ""; //설치장소
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_LVL") = ""; ///계량기레벨
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VALID_S_DT") = ""; ///유효시작일자
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VALID_E_DT") = ""; ///유효종료일자
               DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "HIGH_GAUG_ID") = "";
               setTimeout("showMessage(INFORMATION, OK, 'USER-1000', '이미 입력된 계량기ID 입니다.')", 100);
               return;         
           }
        }
    } else {
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_ID") = ""; //계량기ID
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INST_PLC") = ""; //설치장소
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_LVL") = ""; ///계량기레벨
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VALID_S_DT") = ""; ///유효시작일자
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VALID_E_DT") = ""; ///유효종료일자
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "HIGH_GAUG_ID") = "";
    }
}
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

<script language=JavaScript for=GD_DETAIL event=OnPopup(row,colid,data)>
//계량기 id팝업호출
    if (row < 1) return;
    g_autoFlag = true; //onExit 이벤트 제외
    var strFlc      = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");       //설치 시설
    var strGaugType = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_TYPE");    //계량기 구분
    var strGaugLv   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_LVL");     //계량기 레벨
    var strGaugKind = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_KIND_CD"); //계량기 용도
    var strGaugId   = DS_IO_DETAIL.NameValue(row, "GAUG_ID");                           //해당 위치의 입력 값
    var rt = getGaugIdPop(strGaugId, "", strFlc, strGaugType,  "M", "T",  strGaugKind, strGaugLv);
    
    if (rt == undefined) {
    	g_autoFlag = false;
    	return;
    }

    var forCnt = 0;
    //g_autoFlag = true; //onExit 이벤트 제외
    for(var i=0; i<rt.length; i++) {
    	var validateChk = true;
    	for (var k=1; k<=DS_IO_DETAIL.CountRow; k++) {
    		if (DS_IO_DETAIL.NameValue(k, "GAUG_ID") == rt[i].GAUG_ID) {
    			validateChk = false;
    			break;
    		}
    	} 
    	//중복값 없을시 처리
    	if (validateChk) {
    		if (forCnt != 0) DS_IO_DETAIL.InsertRow(DS_IO_DETAIL.RowPosition);
    	    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_ID") = rt[i].GAUG_ID;   //계량기ID
    	    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INST_PLC") = rt[i].INST_PLC; //설치장소
    	    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_LVL") = rt[i].GAUG_LVL; //계량기레벨
    	    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VALID_S_DT") = rt[i].VALID_S_DT; //유효시작일자
    	    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VALID_E_DT") = rt[i].VALID_E_DT; //유효종료일자
    	    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "HIGH_GAUG_ID") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_ID");
    	    forCnt++;
    	} else {
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_ID") = ""; //계량기ID
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INST_PLC") = ""; //설치장소
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAUG_LVL") = ""; ///계량기레벨
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VALID_S_DT") = ""; ///유효시작일자
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VALID_E_DT") = ""; ///유효종료일자
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "HIGH_GAUG_ID") = "";
            setTimeout("showMessage(INFORMATION, OK, 'USER-1000', '이미 입력된 계량기ID 입니다.')", 100);
            g_autoFlag = false;
            return;  
    	}
    }
    g_autoFlag = false; //onExit 이벤트 제외 끝
</script>

<script language=JavaScript for=LC_GAUG_TYPE event=OnCloseUp()>
//계량기구분 변경 시
DS_GAUG_KIND_CD.Filter();
objectControlType1();  //CES에만 적용[2010.04.12]
if (LC_GAUG_TYPE.BindColVal == "10") { //전력일 시
	DS_PWR_TYPE.Filter();  //전압필터링
	LC_WWTR_CHARGE_YN.Index    = -1;
	LC_WTR_CAL_SIZE.Index      = -1;
} else if (LC_GAUG_TYPE.BindColVal == "20") { //온수일 시
    LC_PWR_TYPE.Index          = -1;
    LC_PWR_SEL_CHARGE.Index    = -1;
    EM_PWR_CNTR_QTY.Text       = 0;
    LC_WTR_CAL_SIZE.Index      = -1;
} else if (LC_GAUG_TYPE.BindColVal == "50") { //가스일 시
    LC_PWR_TYPE.Index          = -1;
    LC_PWR_SEL_CHARGE.Index    = -1;
    EM_PWR_CNTR_QTY.Text       = 0;
    LC_WWTR_CHARGE_YN.Index    = -1;
    LC_WTR_CAL_SIZE.Index      = -1;
} else if (LC_GAUG_TYPE.BindColVal == "60") { //수도일 시
    LC_PWR_TYPE.Index          = -1;
    LC_PWR_SEL_CHARGE.Index    = -1;
    EM_PWR_CNTR_QTY.Text       = 0;
    LC_WWTR_CHARGE_YN.Index    = -1;
} else {
    LC_GAUG_KIND_CD.Index      = -1;
    LC_PWR_TYPE.Index          = -1;
    LC_PWR_SEL_CHARGE.Index    = -1;
    EM_PWR_CNTR_QTY.Text       = 0;
    LC_WWTR_CHARGE_YN.Index    = -1;
    LC_WTR_CAL_SIZE.Index      = -1;
}
</script>

<script language=JavaScript for=LC_GAUG_KIND_CD event=OnCloseUp()>
//계량기용도 변경 시( 전력일경우만 전압필터링)
if (LC_GAUG_TYPE.BindColVal == "10") {
	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_KIND_CD") = LC_GAUG_KIND_CD.BindColVal;
	DS_PWR_TYPE.Filter();  //전압필터링
	DS_PWR_TYPE.SortExpr = "+" + "CODE";
	DS_PWR_TYPE.Sort();
	DS_PWR_SEL_CHARGE.Filter(); // 선택요금 필터링
	DS_PWR_SEL_CHARGE.SortExpr = "+" + "CODE";
	DS_PWR_SEL_CHARGE.Sort();
}
</script>

<script language=JavaScript for=LC_PWR_TYPE event=OnCloseUp()>
//전압 변경 시( 전력일경우만 선택요금 필터링)
if (LC_GAUG_TYPE.BindColVal == "10") {
	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_TYPE") = LC_PWR_TYPE.BindColVal;
    DS_PWR_SEL_CHARGE.Filter(); // 선택요금 필터링
    DS_PWR_SEL_CHARGE.SortExpr = "+" + "CODE";
    DS_PWR_SEL_CHARGE.Sort();
}
</script>

<script language=JavaScript for=LC_PWR_SEL_CHARGE event=OnCloseUp()>
//전기선택요금제 변경 시
DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_SEL_CHARGE") = LC_PWR_SEL_CHARGE.BindColVal;
</script>

<script language=JavaScript for=DS_GAUG_KIND_CD event=OnFilter(row)>
//계량기구분에 따른 계량기용도 필터링
if (DS_IO_MASTER.CountRow < 1) return; 
if (LC_GAUG_TYPE.BindColVal == "30" || LC_GAUG_TYPE.BindColVal == "40" ) { //증기, 냉수 일경우 용도없음만 표기
    if (DS_GAUG_KIND_CD.NameValue(row,"CODE") == "00") { //용도 없음
        return true;
    } else { 
        return false;
    }
} else {
    if (DS_GAUG_KIND_CD.NameValue(row,"CODE").substring(0,1) == (LC_GAUG_TYPE.BindColVal).substring(0,1)) {
        return true;
    } else { 
        return false;
    }
}
</script>

<script language=JavaScript for=DS_PWR_TYPE event=OnFilter(row)>
//계량기구분이 전력일 시 전압필터링
if (DS_IO_MASTER.CountRow < 1) return; 
if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_KIND_CD") == "12" ||
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_KIND_CD") == "14" ||
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_KIND_CD") == "17" ) { //용도구분이 일반용(갑),교육용,산업용(갑)
    if (DS_PWR_TYPE.NameValue(row,"CODE") == "4"||DS_PWR_TYPE.NameValue(row,"CODE") == "5") { // 고압C 고압일반 제외
        return false;
    } else { 
        return true;
    }
} else if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_KIND_CD") == "13" ||
           DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_KIND_CD") == "15") { //용도구분이 일반용(을),산업용(을)
    if (DS_PWR_TYPE.NameValue(row,"CODE") == "1"||DS_PWR_TYPE.NameValue(row,"CODE") == "4"||DS_PWR_TYPE.NameValue(row,"CODE") == "5") { // 저압, 고압C 고압일반 제외
        return false;
    } else { 
        return true;
    }
} else if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_KIND_CD") == "11" ) { // 주택용
    if (DS_PWR_TYPE.NameValue(row,"CODE") == "1"||DS_PWR_TYPE.NameValue(row,"CODE") == "5") { // 저압, 고압만
        return true;
    } else { 
        return false;
    }       
} else { // 산업용(병)
    if (DS_PWR_TYPE.NameValue(row,"CODE") == "1"||DS_PWR_TYPE.NameValue(row,"CODE") == "5") {  // 저압 ,고압일반 제외
        return false;
    } else { 
        return true;
    }
}
</script>


<script language=JavaScript for=DS_PWR_SEL_CHARGE event=OnFilter(row)>
// 요금제구분
if (DS_IO_MASTER.CountRow < 1) return; 
if (LC_GAUG_TYPE.BindColVal == "10") { //계량기 구분이 전력일 시
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_KIND_CD") == "18") { //계량기 용도가  (가로등)
    	 if (DS_PWR_SEL_CHARGE.NameValue(row,"CODE") == "A" || DS_PWR_SEL_CHARGE.NameValue(row,"CODE") == "B") {//A:갑(정액등),B:을(종량등) 표기
    		 return true;
    	 } else {
    	     return false;
    	 }
    } else { 
         if (DS_PWR_SEL_CHARGE.NameValue(row,"CODE") == "A" || DS_PWR_SEL_CHARGE.NameValue(row,"CODE") == "B") {//A:갑(정액등),B:을(종량등) 제외
       	     return false;
	     } else {
	    	 if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_KIND_CD") == "16") { // 용도구분이 산업용(병)
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
	         } else if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAUG_KIND_CD") == "11") { // 주택용
	             if (DS_PWR_SEL_CHARGE.NameValue(row,"CODE") == "0") {//요금제 없음
	                 return true;
	             } else { 
	                 return false;
	             }
	         } else {
	             if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_TYPE") == "1") { // 저압
	                 if (DS_PWR_SEL_CHARGE.NameValue(row,"CODE") == "0") {//요금제 없음
	                     return true;
	                 } else { 
	                     return false;
	                 }
	             } else { // 고압A,B,C
	                 if (DS_PWR_SEL_CHARGE.NameValue(row,"CODE") == "0"||DS_PWR_SEL_CHARGE.NameValue(row,"CODE") == "3") {//요금제 없음,선택III 제외
	                     return false;
	                 } else { 
	                     return true;
	                 }
	             }
	         }
	     }
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
<!-- =============== ONLOAD용 -->
<comment id="_NSID_"><object id="DS_S_FCL_FLAG"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_FCL_FLAG"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_S_GAUG_TYPE"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_GAUG_TYPE"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_GAUG_LVL"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_GAUG_USE_FLAG"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DIV_RULE_TYPE"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_WWTR_CHARGE_YN"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_WTR_CAL_SIZE"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- 용도 -->
<comment id="_NSID_">
<object id="DS_GAUG_KIND_CD"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>
<!-- 전압 -->
<comment id="_NSID_">
<object id="DS_PWR_TYPE"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>
<!-- 선택요금 -->
<comment id="_NSID_">
<object id="DS_PWR_SEL_CHARGE"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>

<!-- =============== 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

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
<!--------------------- 3. Fileupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_FILEUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
    <param name="Text" value="FileOpen">
    <param name="Enable" value="true">
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
<iframe id=iFrame name=iFrame src="about:blank" width=0 height=0></iframe>
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
						<td width="130"><comment id="_NSID_"> <object
							id=LC_S_FCL_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width="127"
							tabindex=1 height=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="70" class="point">계량기구분</th>
						<td width="130"><comment id="_NSID_"> <object
							id=LC_S_GAUG_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width="127" 
							tabindex=1 height=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="70">계량기ID</th>
						<td><comment id="_NSID_"> <object id=EM_S_GAUG_ID
							classid=<%=Util.CLSID_EMEDIT%> width="90" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							onclick="javascript:callPopup('gaugId');" class="PR03" /> <comment
                            id="_NSID_"> <object id=EM_S_INST_PLC
                            classid=<%=Util.CLSID_EMEDIT%> width="160" tabindex=1
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
	<tr valign="top">
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td width="300">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"><OBJECT id=GD_MASTER
							width=100% height=503 tabindex=1 classid=<%=Util.CLSID_GRID%>>
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
									align="absmiddle" /> 계량기정보</td>
							</tr>
							<tr height="3">
								<td></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="PB03">
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="100">계량기ID</th>
								<td width="145"><comment id="_NSID_"> <object
									id=EM_GAUG_ID classid=<%=Util.CLSID_EMEDIT%> width="135"
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
								<th width="100" class="point">계량기구분</th>
								<td><comment id="_NSID_"> <object id=LC_GAUG_TYPE
									classid=<%=Util.CLSID_LUXECOMBO%> width="140" height=100
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th width="100" class="point">시설구분</th>
								<td><comment id="_NSID_"> <object
									id=LC_FCL_FLAG classid=<%=Util.CLSID_LUXECOMBO%>
									width="140" height=100 tabindex=1 align="absmiddle"> </object>
								</comment><script>_ws_(_NSID_);</script></td>
								<th width="100">상위계량기ID</th>
								<td><comment id="_NSID_"> <object id=EM_HIGH_GAUG_ID
							        classid=<%=Util.CLSID_EMEDIT%> width="90" tabindex=1
							         align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
							         <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							         onclick="javascript:callPopup1('gaugId');" class="PR03" /> 
							    </td>
							</tr>
							<tr>
								<th>설치장소</th>
								<td><comment id="_NSID_"> <object id=EM_INST_PLC
									classid=<%=Util.CLSID_EMEDIT%> width="135" tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
								<th>계량기레벨</th>
								<td><comment id="_NSID_"> <object id=LC_GAUG_LVL
									classid=<%=Util.CLSID_LUXECOMBO%> width="140" height=100
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>계량기사용구분</th>
								<td><comment id="_NSID_"> <object
									id=LC_GAUG_USE_FLAG classid=<%=Util.CLSID_LUXECOMBO%>
									width="140" height=100 tabindex=1 align="absmiddle"> </object>
								</comment><script>_ws_(_NSID_);</script></td>
								<th>공동안분기준</th>
								<td><comment id="_NSID_"> <object
									id=LC_DIV_RULE_TYPE classid=<%=Util.CLSID_LUXECOMBO%>
									width="140" height=100 tabindex=1 align="absmiddle"> </object>
								</comment><script>_ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>계량기용도</th>
								<td><comment id="_NSID_"> <object
									id=LC_GAUG_KIND_CD classid=<%=Util.CLSID_LUXECOMBO%>
									width="140" height=100 tabindex=1 align="absmiddle"> </object>
								</comment><script>_ws_(_NSID_);</script></td>
								<th>전기전압구분</th>
								<td><comment id="_NSID_"> <object id=LC_PWR_TYPE
									classid=<%=Util.CLSID_LUXECOMBO%> width="140" height=100
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>전기선택요금제</th>
								<td><comment id="_NSID_"> <object
									id=LC_PWR_SEL_CHARGE classid=<%=Util.CLSID_LUXECOMBO%>
									width="140" tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
								<th>전기계약전력</th>
								<td><comment id="_NSID_"> <object
									id=EM_PWR_CNTR_QTY classid=<%=Util.CLSID_EMEDIT%> width="135"
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th>전기역률</th>
								<td><comment id="_NSID_"> <object
									id=EM_PWR_REVER_RATE classid=<%=Util.CLSID_EMEDIT%> width="135"
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
								<th>계량기배수</th>
								<td><comment id="_NSID_"> <object
									id=EM_GAUG_MULTIPLE classid=<%=Util.CLSID_EMEDIT%> width="135"
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th>가로등설비용량</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_USE_EQUIP_QTY classid=<%=Util.CLSID_EMEDIT%> width="135"
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th>온수차등요금제</th>
								<td><comment id="_NSID_"> <object
									id=LC_WWTR_CHARGE_YN classid=<%=Util.CLSID_LUXECOMBO%>
									width="140" height=100 tabindex=1 align="absmiddle"> </object>
								</comment><script>_ws_(_NSID_);</script></td>
								<th>수도계량기구경</th>
								<td><comment id="_NSID_"> <object
									id=LC_WTR_CAL_SIZE classid=<%=Util.CLSID_LUXECOMBO%>
									width="140" height=100 tabindex=1 align="absmiddle"> </object>
								</comment><script>_ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>유효시작일자</th>
								<td><comment id="_NSID_"> <object
									id=EM_VALID_S_DT classid=<%=Util.CLSID_EMEDIT%> width=115
									align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
								</object></comment><script>_ws_(_NSID_);</script> <img
									src="/<%=dir%>/imgs/btn/date.gif"
									onclick="javascript:openCal('G',EM_VALID_S_DT)"
									align="absmiddle" id="IMG_VALID_S_DT" /></td>
								<th>유효종료일자</th>
								<td><comment id="_NSID_"> <object
									id=EM_VALID_E_DT classid=<%=Util.CLSID_EMEDIT%> width=115
									align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
								</object></comment><script>_ws_(_NSID_);</script> <img
									src="/<%=dir%>/imgs/btn/date.gif"
									onclick="javascript:openCal('G',EM_VALID_E_DT)"
									align="absmiddle" id="IMG_VALID_E_DT" /></td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td colspan="3" align="left"><comment id="_NSID_">
								<object id=EM_FILE_PATH classid=<%=Util.CLSID_EMEDIT%>
									width="212" tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/file_search.gif"
									id="IMG_FILE_SEARCH" onclick="javascript:openFile();"
									hspace="2" align="absmiddle" /><img
									id="IMG_FILE_DOWN" src="/<%=dir%>/imgs/btn/file_down.gif"
									onclick="javascript:saveAsFiles();" align="absmiddle" /><img
									id="IMG_FILE_DEL" style="vertical-align: middle;"
									onclick="javascript:deleteFile();"
									src="/<%=dir%>/imgs/btn/file_del.gif" /></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="dot"></td>
					</tr>
					<tr>
						<td class="PT05">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title">
								<td class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
									align="absmiddle" /> 서브 계량기정보</td>
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
									width=100% height=178 tabindex=1 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_IO_DETAIL">
								</OBJECT></comment><script>_ws_(_NSID_);</script></td>
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
<object id=BD_O_MASTER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
          <c>Col=GAUG_ID            Ctrl=EM_GAUG_ID            param=Text</c> 
          <c>Col=GAUG_TYPE          Ctrl=LC_GAUG_TYPE          param=BindColVal</c> 
          <c>Col=INST_PLC           Ctrl=EM_INST_PLC           param=Text</c> 
          <c>Col=GAUG_LVL           Ctrl=LC_GAUG_LVL           param=BindColVal</c>
          <c>Col=STR_CD             Ctrl=LC_FCL_FLAG           param=BindColVal</c>
          <c>Col=HIGH_GAUG_ID       Ctrl=EM_HIGH_GAUG_ID       param=Text</c> 
          <c>Col=GAUG_USE_FLAG      Ctrl=LC_GAUG_USE_FLAG      param=BindColVal</c> 
          <c>Col=DIV_RULE_TYPE      Ctrl=LC_DIV_RULE_TYPE      param=BindColVal</c> 
          <c>Col=PWR_CNTR_QTY       Ctrl=EM_PWR_CNTR_QTY       param=Text</c> 
          <c>Col=PWR_REVER_RATE     Ctrl=EM_PWR_REVER_RATE     param=Text</c> 
          <c>Col=USE_GAUG_MULTIPLE  Ctrl=EM_GAUG_MULTIPLE      param=Text</c> 
          <c>Col=USE_EQUIP_QTY      Ctrl=EM_USE_EQUIP_QTY      param=Text</c> 
          <c>Col=WWTR_CHARGE_YN     Ctrl=LC_WWTR_CHARGE_YN     param=BindColVal</c> 
          <c>Col=WTR_CAL_SIZE       Ctrl=LC_WTR_CAL_SIZE       param=BindColVal</c> 
          <c>Col=VALID_S_DT         Ctrl=EM_VALID_S_DT         param=Text</c> 
          <c>Col=VALID_E_DT         Ctrl=EM_VALID_E_DT         param=Text</c> 
          <c>Col=FILE_PATH          Ctrl=EM_FILE_PATH          param=Text</c> 
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
