<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 주거세대 마스터관리
 * 작 성 일 : 2010.01.14
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : MREN1070.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 시설구분별관리기준
 * 이    력 : 2010.01.14(박래형) 신규작성
           2010.03.28 (김유완) 수정개발
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
<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var g_saveFlag = false;
var g_currKey  = "S";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.28
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_HHOLDMST"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER");
    
    //그리드 초기화
    gridCreate(); 
   
    // COMBO 초기화,EM 초기화
    initComboStyle(LC_S_FCL_FLAG,DS_LC_FCL_FLAG,            "CODE^0^30,NAME^0^80", 1, PK);      // [조회용]시설구분(점코드) 
    initEmEdit(EM_S_DONG,       "NUMBER3^3^0",NORMAL);                                          // [조회용]동
    initEmEdit(EM_S_HO,         "NUMBER3^4^0",NORMAL);                                          // [조회용]호
    initEmEdit(EM_S_HHOLD_NAME, "GEN",NORMAL);                                                  // [조회용]세대주명
    EM_S_HHOLD_NAME.Language = 1;

    //initComboStyle(LC_S_IN_OUT,  DS_LC_FCL_FLAG,            "CODE^0^30,NAME^0^80", 1, NORMAL);  // [조회용]조회기간구분
    //LC_S_IN_OUT.CBData = "%^전체,1^전입일,2^전출일";
    initEmEdit(EM_S_DT,         "YYYYMMDD",READ);                                               // [조회용]기간S
    initEmEdit(EM_E_DT,         "YYYYMMDD",READ);                                               // [조회용]기간E
    
    // COMBO 초기화,EM 초기화
    initComboStyle(LC_FCL_FLAG,DS_LC_FCL_FLAG,              "CODE^0^30,NAME^0^80", 1, PK);      // 시설구분
    initEmEdit(EM_HHOLD_ID,     "GEN",READ);                                                    // 세대ID
    initEmEdit(EM_HUSE_ID,      "CODE^8^#",PK);                                                 // 주거ID
    EM_HUSE_ID.UpperFlag = 1;//주거 ID 대문자
    initEmEdit(EM_DONG,         "NUMBER^12^0",READ);                                            // 동
    initEmEdit(EM_HO,           "NUMBER^12^0",READ);                                            // 호
    initEmEdit(EM_HEAT_AREA,    "NUMBER^9^2",NORMAL);                                           // 난방면적(㎡)
    initEmEdit(EM_CNTR_AREA,    "NUMBER^9^2",READ);                                             // 면적(㎡)
    initEmEdit(EM_HHOLD_NAME,   "GEN",PK);                                                      // 세대주명
    EM_HHOLD_NAME.Language = 1;
    initEmEdit(EM_PHONE1_NO,    "NUMBER3^4^0",NORMAL);                                          // 전화번호1
    initEmEdit(EM_PHONE2_NO,    "NUMBER3^4^0",NORMAL);                                          // 전화번호2
    initEmEdit(EM_PHONE3_NO,    "NUMBER3^4^0",NORMAL);                                          // 전화번호3
    initEmEdit(EM_MOVE_IN_DT,   "YYYYMMDD",PK);                                                 // 전입일
    initEmEdit(EM_MOVE_OUT_DT,  "YYYYMMDD",NORMAL);                                             // 전출일
    initComboStyle(LC_PWR_KIND_CD,DS_LC_PWR_KIND_CD,        "CODE^0^30,NAME^0^80", 1, NORMAL);  // 전기용도
    initComboStyle(LC_PWR_TYPE,DS_LC_PWR_TYPE,              "CODE^0^30,NAME^0^80", 1, PK);      // 전압
    initComboStyle(LC_PWR_SEL_CHARGE,DS_LC_PWR_SEL_CHARGE,  "CODE^0^30,NAME^0^80", 1, NORMAL);  // 전기선택요금제
    initEmEdit(EM_PWR_CNTR_QTY, "NUMBER^7^0",NORMAL);                                           // 전기계약전력
    initEmEdit(EM_PWR_REVER_RATE,"NUMBER^7^2",NORMAL);                                          // 역율
    initComboStyle(LC_PWR_DC_TYPE,DS_LC_PWR_DC_TYPE,        "CODE^0^30,NAME^0^80", 1, NORMAL);  // 주택전력복지할인구분
    initComboStyle(LC_PWR_REDU_TYPE,DS_LC_PWR_REDU_TYPE,    "CODE^0^30,NAME^0^80", 1, NORMAL);  // 주택전력누진하향적용구분
    initComboStyle(LC_WWTR_KIND_CD,DS_LC_WWTR_KIND_CD,      "CODE^0^30,NAME^0^80", 1, NORMAL);  // 온수(급탕)용도
    initComboStyle(LC_WWTR_CHARGE_YN,DS_LC_WWTR_CHARGE_YN,  "CODE^0^30,NAME^0^80", 1, NORMAL);  // 온수(급탕)차등요금제여부
    initComboStyle(LC_STM_KIND_CD,DS_LC_STM_KIND_CD,        "CODE^0^30,NAME^0^80", 1, NORMAL);  // 증기용도
    initComboStyle(LC_CWTR_KIND_CD,DS_LC_CWTR_KIND_CD,      "CODE^0^30,NAME^0^80", 1, NORMAL);  // 냉수용도
    initComboStyle(LC_GAS_KIND_CD,DS_LC_GAS_KIND_CD,        "CODE^0^30,NAME^0^80", 1, NORMAL);  // 가스용도
    initComboStyle(LC_GAS_REDU_TYPE,DS_LC_GAS_REDU_TYPE,    "CODE^0^30,NAME^0^80", 1, NORMAL);  // 도시가스경감구분
    initComboStyle(LC_WTR_KIND_CD,DS_LC_WTR_KIND_CD,        "CODE^0^30,NAME^0^80", 1, NORMAL);  // 수도용도
    initEmEdit(EM_TV_CNT,       "NUMBER^3^0",NORMAL);                                           // TV수신수량
    initComboStyle(LC_MNTN_PAY_KIND,DS_LC_MNTN_PAY_KIND,    "CODE^0^30,NAME^0^80", 1, NORMAL);  // 관리비납부방법
    
    //시스템 코드 공통코드에서 가지고 오기
    getFlc("DS_LC_FCL_FLAG", "M", "2", "Y", "N", "", "N");           // [조회용]시설구분(점코드) 
    LC_S_FCL_FLAG.index = "0";                   
    LC_S_FCL_FLAG.Focus();          
    getEtcCode("DS_LC_PWR_KIND_CD",     "D", "M045", "N");  // 전기용도      
    DS_LC_PWR_KIND_CD.Filter();                             // 계량기용도(전기) 필터링
    DS_LC_PWR_KIND_CD.SortExpr = "+" + "CODE";
    DS_LC_PWR_KIND_CD.Sort();
    getEtcCode("DS_LC_PWR_TYPE",        "D", "M047", "N");  // 전압      
    getEtcCode("DS_LC_PWR_SEL_CHARGE",  "D", "M081", "N");  // 전기선택요금제      
    getEtcCode("DS_LC_PWR_DC_TYPE",     "D", "M048", "N");  // 주택전력복지할인구분      
    getEtcCode("DS_LC_PWR_REDU_TYPE",   "D", "M049", "N");  // 주택전력누진하향적용구분      
    getEtcCode("DS_LC_WWTR_KIND_CD",    "D", "M045", "N");  // 온수(급탕)용도  
    DS_LC_WWTR_KIND_CD.Filter();                            // 온수(급탕)용도 필터링
    DS_LC_WWTR_KIND_CD.SortExpr = "+" + "CODE";
    DS_LC_WWTR_KIND_CD.Sort();
    getEtcCode("DS_LC_WWTR_CHARGE_YN",  "D", "D022", "N");  // 온수(급탕)차등요금제여부     
    getEtcCode("DS_LC_STM_KIND_CD",     "D", "M045", "N");  // 증기용도      
    DS_LC_STM_KIND_CD.Filter();                             // 증기용도 필터링
    DS_LC_STM_KIND_CD.SortExpr = "+" + "CODE";
    DS_LC_STM_KIND_CD.Sort();
    getEtcCode("DS_LC_CWTR_KIND_CD",    "D", "M045", "N");  // 냉수용도      
    DS_LC_CWTR_KIND_CD.Filter();                            // 냉수용도 필터링
    DS_LC_CWTR_KIND_CD.SortExpr = "+" + "CODE";
    DS_LC_CWTR_KIND_CD.Sort();
    getEtcCode("DS_LC_GAS_KIND_CD",     "D", "M045", "N");  // 가스용도      
    DS_LC_GAS_KIND_CD.Filter();                             // 가스용도 필터링
    DS_LC_GAS_KIND_CD.SortExpr = "+" + "CODE";
    DS_LC_GAS_KIND_CD.Sort();
    getEtcCode("DS_LC_GAS_REDU_TYPE",   "D", "M053", "N");  // 도시가스경감구분      
    getEtcCode("DS_LC_WTR_KIND_CD",     "D", "M045", "N");  // 수도용도      
    DS_LC_WTR_KIND_CD.Filter();                             // 수도용도 필터링
    DS_LC_WTR_KIND_CD.SortExpr = "+" + "CODE";
    DS_LC_WTR_KIND_CD.Sort();
    getEtcCode("DS_LC_MNTN_PAY_KIND",   "D", "M107", "N");  // 관리비납부방법      
    
    objectControlDefault(false);    // 세대정보 비활성화
    objectControlDtlDefault(false); // 관리비부과정보 비활성화
    
    LC_FCL_FLAG.Enable     = false;
    enableControl(IMG_S_DT,false);  // 조회기간 비활성화(팝업)
    enableControl(IMG_E_DT,false);  // 조회기간 비활성화(팝업)
    CHK_STAY_NOW.checked = true;
}

function gridCreate() {
    var hdrProperies = '<FC>ID={CURROW}     NAME="NO"'        
                     + '                                    WIDTH=30  ALIGN=CENTER</FC>'
                     + '<FC>ID=DONGHO       NAME="동호"'
                     + '                                    WIDTH=60  ALIGN=CENTER</FC>'
                     + '<FC>ID=HHOLD_ID     NAME="세대ID"'
                     + '                                    WIDTH=80  ALIGN=CENTER</FC>'
                     + '<FC>ID=HHOLD_NAME   NAME="세대주명"'
                     + '                                    WIDTH=90  ALIGN=LEFT</FC>'
                     + '<FC>ID=DONG         NAME="동"'
                     + '                                    WIDTH=90  ALIGN=CENTER  SHOW=FALSE</FC>'
                     + '<FC>ID=HO           NAME="호"'
                     + '                                    WIDTH=90  ALIGN=CENTER  SHOW=FALSE</FC>'
                     ;
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
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
 * 작 성 일 : 2010.03.28
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search(row) {
    if (DS_IO_MASTER.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
            // 점체크
            if (LC_S_FCL_FLAG.BindColVal == "" || LC_S_FCL_FLAG.BindColVal == "%") {//점 미선택시
                showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
                LC_S_FCL_FLAG.Focus();
                return;
            }  
            // parameters
            var strFlcFlag  = LC_S_FCL_FLAG.BindColVal; // [조회용]시설구분(점코드)
            var strDong     = EM_S_DONG.Text;           // [조회용]동호
            var strHo       = EM_S_HO.Text;             // [조회용]동호
            var strHHName   = EM_S_HHOLD_NAME.Text;     // [조회용]세대주명
            var strIOFlag   = LC_S_IN_OUT.BindColVal;   // [조회용]조회기간구분
            var strSdt      = EM_S_DT.Text;             // [조회용]기간S
            var strEdt      = EM_E_DT.Text;             // [조회용]기간E
            var strStayNow  = "N";                      // [조회용]현거주여부
            if (CHK_STAY_NOW.checked) {
            	strStayNow = "Y";
            }
            
            var goTo = "getMaster";
            var parameters = ""
                + "&strFlcFlag="    + encodeURIComponent(strFlcFlag)
                + "&strDong="       + encodeURIComponent(strDong)
                + "&strHo="         + encodeURIComponent(strHo)
                + "&strHHName="     + encodeURIComponent(strHHName)
                + "&strIOFlag="     + encodeURIComponent(strIOFlag)
                + "&strSdt="        + encodeURIComponent(strSdt)
                + "&strEdt="        + encodeURIComponent(strEdt)
                + "&strStayNow="    + encodeURIComponent(strStayNow);
            TR_MAIN.Action = "/mss/mren107.mr?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
            TR_MAIN.Post();
            
            // 조회결과 Return
            setPorcCount("SELECT", GD_MASTER);
            if (DS_IO_MASTER.CountRow < 1) {
                objectControlDefault(false);
                objectControlDtlDefault(false);        // 기타 항목 비활성화
            } else {
                objectControlDefault(true);
                objectControlDtlDefault(true);
            }
        } else {
            return;
        }
    }  else {
        // 점체크
        if (LC_S_FCL_FLAG.BindColVal == "" || LC_S_FCL_FLAG.BindColVal == "%") {//점 미선택시
            showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
            LC_S_FCL_FLAG.Focus();
            return;
        }  
        // parameters
        var strFlcFlag  = LC_S_FCL_FLAG.BindColVal; // [조회용]시설구분(점코드)
        var strDong     = EM_S_DONG.Text;           // [조회용]동호
        var strHo       = EM_S_HO.Text;             // [조회용]동호
        var strHHName   = EM_S_HHOLD_NAME.Text;     // [조회용]세대주명
        var strIOFlag   = LC_S_IN_OUT.BindColVal;   // [조회용]조회기간구분
        var strSdt      = EM_S_DT.Text;             // [조회용]기간S
        var strEdt      = EM_E_DT.Text;             // [조회용]기간E
        var strStayNow  = "N";                      // [조회용]현거주여부
        if (CHK_STAY_NOW.checked) {
            strStayNow = "Y";
        }
        
        var goTo = "getMaster";
        var parameters = ""
            + "&strFlcFlag="    + encodeURIComponent(strFlcFlag)
            + "&strDong="       + encodeURIComponent(strDong)
            + "&strHo="         + encodeURIComponent(strHo)
            + "&strHHName="     + encodeURIComponent(strHHName)
            + "&strIOFlag="     + encodeURIComponent(strIOFlag)
            + "&strSdt="        + encodeURIComponent(strSdt)
            + "&strEdt="        + encodeURIComponent(strEdt)
            + "&strStayNow="    + encodeURIComponent(strStayNow);
        TR_MAIN.Action = "/mss/mren107.mr?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();
        
        // 조회결과 Return
        setPorcCount("SELECT", GD_MASTER);
        if (DS_IO_MASTER.CountRow < 1) {
	        objectControlDefault(false);
	        objectControlDtlDefault(false);        // 기타 항목 비활성화
        } else {
        	objectControlDefault(true);
        	objectControlDtlDefault(true);
        }
    }
    //저장 후 해당 위치 SET
    if (arguments[0] == undefined || arguments[0] == "S") {
    	g_currKey = "S";
    } else {
    	DS_IO_MASTER.RowPosition = getNameValueRow(DS_IO_MASTER, "HUSE_ID||CHK_STAY",g_currKey);
        //DS_IO_MASTER.NameValueRow("HHOLD_ID", arguments[0]);
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
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CHK_STAY") = 'T';
	}
	
	LC_FCL_FLAG.Focus();
	LC_FCL_FLAG.index = "0"; 
	objectControlDtl(true);
    objectControlDefault(true);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.28
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
	        return;
	    }
	    
	    //저장
	    g_currKey = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "HUSE_ID")+"||"+DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CHK_STAY");
	    var goTo = "save";
	    TR_SAVE.Action = "/mss/mren107.mr?goTo=" + goTo;
	    TR_SAVE.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
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
 * checkValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.28
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidate() {
	for (var i=1; i<=DS_IO_MASTER.CountRow; i++) {
		// 시설구분
	    if (DS_IO_MASTER.NameValue(i, "STR_CD")=="") {
	        showMessage(INFORMATION, OK, "USER-1002", "시설구분");
	        DS_IO_MASTER.RowPosition = i;
	        LC_FCL_FLAG.Focus();
	        return false;
	    } 
	    
	    // 주거ID
	    if (DS_IO_MASTER.NameValue(i, "HUSE_ID")== "") {
	        showMessage(INFORMATION, OK, "USER-1002", "주거ID");
	        DS_IO_MASTER.RowPosition = i;
	        EM_HUSE_ID.Focus();
	        return false;
	    } 
	    // 동/호(동)
	    if (DS_IO_MASTER.NameValue(i, "DONG")== "") {
	        showMessage(INFORMATION, OK, "USER-1002", "동/호(동)");
	        DS_IO_MASTER.RowPosition = i;
	        EM_DONG.Focus();
	        return false;
	    } 
	    
	    // 동/호(호)
	    if (DS_IO_MASTER.NameValue(i, "HO")== "") {
	        showMessage(INFORMATION, OK, "USER-1002", "동/호(호)");
	        DS_IO_MASTER.RowPosition = i;
	        EM_HO.Focus();
	        return false;
	    } 
	    
        //세대주명
        var tmpNameLen= checkLenByteStr(DS_IO_MASTER.NameValue(i, "HHOLD_NAME"))
        if (tmpNameLen > 40 ) {
            showMessage(STOPSIGN, OK, "USER-1000", "세대주명은 40Byte(한글20/영문숫자40)이상 입력 할 수 없습니다.");
            DS_IO_MASTER.RowPosition = i;
            EM_HHOLD_NAME.Focus();
            return false;
        } else if (tmpNameLen < 1) {
            showMessage(INFORMATION, OK, "USER-1002", "세대주명");
            DS_IO_MASTER.RowPosition = i;
            EM_HHOLD_NAME.Focus();
            return false;
        }
	    
	    // 전입일
	    if (DS_IO_MASTER.NameValue(i, "MOVE_IN_DT") == "") {
	        showMessage(INFORMATION, OK, "USER-1002", "전입일");
	    	DS_IO_MASTER.RowPosition = i;
	        EM_MOVE_IN_DT.Focus();
	        return false;
	    }
	    
	    //전출일 등록
	    if (DS_IO_MASTER.NameValue(i, "MOVE_OUT_DT").length == 8) {
	        if (DS_IO_MASTER.NameValue(i, "MOVE_IN_DT") >  DS_IO_MASTER.NameValue(i, "MOVE_OUT_DT")) {
	            showMessage(INFORMATION, OK, "USER-1000", "전출일은 전입일 이후로 입력하세요.");
	            DS_IO_MASTER.RowPosition = i;
	            EM_MOVE_IN_DT.Focus();
	            return false;
	        } 
	    }
	    
	    // 관리비부과여부
	    if (DS_IO_MASTER.NameValue(i, "MNTN_CAL_YN")== "") {
	        showMessage(INFORMATION, OK, "USER-1002", "관리비부과여부");
	    	DS_IO_MASTER.RowPosition = i;
	        RD_MNTN_CAL_YN.Focus();
	        return false;
	    } 
	    
        // 전화번호 지역번호
        if (DS_IO_MASTER.NameValue(i,"PHONE1_NO") != "") {
            if (!firstTelFormatAll(DS_IO_MASTER.NameValue(i,"PHONE1_NO"), "T")) {
                showMessage(STOPSIGN, OK, "USER-1000", "올바르지 않은 지역(통신사)번호 입니다.");
                DS_IO_MASTER.RowPosition = i;
                EM_PHONE1_NO.Focus();
                return false;
            } 
        }
	}
	return true;
}
 
/**
 * callPopup()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.28
 * 개    요 : 팝업 호출
 * return값 :
 */
function callPopup() {
	if (LC_FCL_FLAG.BindColVal == "" || LC_FCL_FLAG.BindColVal == "%") {//점 미선택시
	    showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
	    LC_FCL_FLAG.Focus();
	    return;
	}  
	
	var rt = getHomeIdPop( EM_HUSE_ID, EM_DONG.Text, EM_HO.Text, LC_FCL_FLAG.BindColVal, "S", "0" );
    if (rt) {
    	EM_DONG.Text = rt.DONG;
    	EM_HO.Text = rt.HO;
    	EM_CNTR_AREA.Text = rt.CNTR_AREA;
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DONGHO") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DONG")
        + "-" +DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"HO");
    } else {
    	if (EM_HUSE_ID.Text == "") {
            //기존 값으로 변경
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"HUSE_ID") = DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"HUSE_ID");
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DONG") = DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"DONG");
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"HO") = DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"HO");
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CNTR_AREA") = DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"CNTR_AREA");
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DONGHO") = DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"DONG")
            + "-" +DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"HO");
    	}
    }
 }
 
/**
 * objectControlDefault()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.28
 * 개    요 : (세대정보)입력값 초기값
 * return값 :
 */
function objectControlDefault(objBoolean) {
	if (objBoolean) {
	    //LC_FCL_FLAG.Enable     = true; 
	    EM_HUSE_ID.Enable      = true;           
	    enableControl(IMG_HUSE_ID,true);
	    EM_HHOLD_NAME.Enable   = true;       
	    EM_HEAT_AREA.Enable    = true;
	    EM_PHONE1_NO.Enable    = true;      
	    EM_PHONE2_NO.Enable    = true;      
	    EM_PHONE3_NO.Enable    = true;      
	    EM_MOVE_IN_DT.Enable   = true; 
	    enableControl(IMG_MOVE_IN_DT,true);
	    RD_MNTN_CAL_YN.Enable  = true;
	} else {
	    //LC_FCL_FLAG.Enable     = false; 
	    EM_HUSE_ID.Enable      = false;           
	    enableControl(IMG_HUSE_ID,false)
	    EM_HHOLD_NAME.Enable   = false; 
	    EM_HEAT_AREA.Enable    = false;
	    EM_PHONE1_NO.Enable    = false;      
	    EM_PHONE2_NO.Enable    = false;      
	    EM_PHONE3_NO.Enable    = false;      
	    EM_MOVE_IN_DT.Enable   = false; 
	    enableControl(IMG_MOVE_IN_DT,false);
	    EM_MOVE_OUT_DT.Enable  = false; 
	    enableControl(IMG_MOVE_OUT_DT,false);
	    RD_MNTN_CAL_YN.Enable  = false;
	}
}

/**
 * objectControl(row)
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.28
 * 개    요 : (세대정보)입력값 컨트롤 
 * return값 :
 */
function objectControl(row) {
	// 신규따른 처리
	if (DS_IO_MASTER.RowStatus(row) == 1) {
	    LC_FCL_FLAG.Enable  = true; 
	} else {
	    LC_FCL_FLAG.Enable  = false; 
	}
	 
	//전출일이 오늘 이전일 경우 변경 불가
	if (DS_IO_MASTER.NameValue(row, "MOVE_OUT_DT") != "") {
	    if (eval(DS_IO_MASTER.NameValue(row, "MOVE_OUT_DT")) < eval(getTodayFormat("YYYYMMDD"))) {
	        EM_MOVE_OUT_DT.Enable  = false; 
	        enableControl(IMG_MOVE_OUT_DT,false);
	    } else {
	        EM_MOVE_OUT_DT.Enable  = true; 
	        enableControl(IMG_MOVE_OUT_DT,true);
	    }
	} else {
	    EM_MOVE_OUT_DT.Enable  = true; 
	    enableControl(IMG_MOVE_OUT_DT,true);
	}
	
}

/**
 * objectControlDtlDefault()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.28
 * 개    요 : (관리비부과정보)입력값 초기값
 * return값 :
 */
function objectControlDtlDefault(objBoolean) {
	if (objBoolean) {
	    LC_PWR_KIND_CD.Enable       = true;    
	    //전기용도에 따른
	    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "11") {//주택용
            LC_PWR_SEL_CHARGE.Enable   = false;    // 전기선택요금제
            EM_PWR_CNTR_QTY.Enable     = false;    // 전기계약전력
            EM_PWR_REVER_RATE.Enable   = false;    // 전기계약전력
            LC_PWR_DC_TYPE.Enable      = true;     // 주택전력복지할인구분
            LC_PWR_REDU_TYPE.Enable    = true;     // 주택전력누진하향적용구분 	        
	    } else {
            LC_PWR_SEL_CHARGE.Enable   = true;      // 전기선택요금제
            EM_PWR_CNTR_QTY.Enable     = true;      // 전기계약전력
            EM_PWR_REVER_RATE.Enable   = true;      // 전기계약전력
            LC_PWR_DC_TYPE.Enable      = false;     // 주택전력복지할인구분
            LC_PWR_REDU_TYPE.Enable    = false;     // 주택전력누진하향적용구분    
	    }        
	    LC_PWR_TYPE.Enable          = true;        
	    LC_WWTR_KIND_CD.Enable      = true; 
	    LC_WWTR_CHARGE_YN.Enable    = true;   
	    LC_STM_KIND_CD.Enable       = true; 
	    LC_CWTR_KIND_CD.Enable      = true;
	    LC_GAS_KIND_CD.Enable       = true;
	    LC_GAS_REDU_TYPE.Enable     = true;
	    LC_WTR_KIND_CD.Enable       = true; 
	    EM_TV_CNT.Enable            = true;
	    LC_MNTN_PAY_KIND.Enable     = true; 
	} else {
	    LC_PWR_KIND_CD.Enable       = false;    
	    LC_PWR_TYPE.Enable          = false;        
	    LC_PWR_SEL_CHARGE.Enable    = false;  
	    EM_PWR_CNTR_QTY.Enable      = false;    
	    EM_PWR_REVER_RATE.Enable    = false;     
	    LC_PWR_DC_TYPE.Enable       = false;       
	    LC_PWR_REDU_TYPE.Enable     = false;     
	    LC_WWTR_KIND_CD.Enable      = false; 
	    LC_WWTR_CHARGE_YN.Enable    = false;   
	    LC_STM_KIND_CD.Enable       = false; 
	    LC_CWTR_KIND_CD.Enable      = false;
	    LC_GAS_KIND_CD.Enable       = false;
	    LC_GAS_REDU_TYPE.Enable     = false;
	    LC_WTR_KIND_CD.Enable       = false; 
	    EM_TV_CNT.Enable            = false;
	    LC_MNTN_PAY_KIND.Enable     = false;
	}
}

/**
 * objectControlDtl()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.28
 * 개    요 : (관리비부과정보)입력값 초기값
 * return값 :
 */
function objectControlDtl(objBoolean) {
    if (objBoolean) {
        LC_PWR_KIND_CD.Enable  = true;    
        //전기용도에 따른
        LC_PWR_KIND_CD.Index    = 0;    
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "11") {//주택용
            LC_PWR_DC_TYPE.Enable   = true;    // 주택전력복지할인구분
            LC_PWR_REDU_TYPE.Enable = true;    // 주택전력누진하향적용구분 
        } else {
            LC_PWR_DC_TYPE.Enable   = false;    // 주택전력복지할인구분
            LC_PWR_REDU_TYPE.Enable = false;    // 주택전력누진하향적용구분 
        }        
        LC_PWR_TYPE.Enable          = true;        
        LC_PWR_SEL_CHARGE.Enable    = true;  
        EM_PWR_CNTR_QTY.Enable      = true;    
        EM_PWR_REVER_RATE.Enable    = true;
        LC_WWTR_KIND_CD.Enable = true; 
        LC_WWTR_CHARGE_YN.Enable   = true;   
        LC_STM_KIND_CD.Enable  = true; 
        LC_CWTR_KIND_CD.Enable = true;
        LC_GAS_KIND_CD.Enable  = true;
        LC_GAS_REDU_TYPE.Enable= true;
        LC_WTR_KIND_CD.Enable  = true; 
        EM_TV_CNT.Enable       = true;
        //default값
        LC_PWR_DC_TYPE.Index    = 0;     
        LC_PWR_REDU_TYPE.Index  = 0;  
        LC_WWTR_KIND_CD.Index   = 0;    
        LC_WWTR_CHARGE_YN.Index = 1;       
        LC_STM_KIND_CD.Index    = 0;    
        LC_CWTR_KIND_CD.Index   = 0;    
        LC_GAS_KIND_CD.Index    = 0;    
        LC_GAS_REDU_TYPE.Index  = 0;    
        LC_WTR_KIND_CD.Index    = 0;    
        EM_TV_CNT.Text          = 1;
    } else {
        LC_PWR_KIND_CD.Enable  = false;    
        LC_PWR_TYPE.Enable     = false;        
        LC_PWR_SEL_CHARGE.Enable    = false;  
        EM_PWR_CNTR_QTY.Enable = false;    
        EM_PWR_REVER_RATE.Enable    = false;     
        LC_PWR_DC_TYPE.Enable  = false;       
        LC_PWR_REDU_TYPE.Enable  = false;     
        LC_WWTR_KIND_CD.Enable = false; 
        LC_WWTR_CHARGE_YN.Enable    = false;   
        LC_STM_KIND_CD.Enable  = false; 
        LC_CWTR_KIND_CD.Enable = false;
        LC_GAS_KIND_CD.Enable  = false;
        LC_GAS_REDU_TYPE.Enable= false;
        LC_WTR_KIND_CD.Enable  = false; 
        EM_TV_CNT.Enable       = false;
        //default값
        LC_PWR_KIND_CD.Index    = -1;    
        LC_PWR_TYPE.Index       = -1;    
        LC_PWR_SEL_CHARGE.Index = -1;    
        EM_PWR_CNTR_QTY.Text    = 0;    
        EM_PWR_REVER_RATE.Text  = 0;     
        LC_PWR_DC_TYPE.Index    = -1;     
        LC_PWR_REDU_TYPE.Index  = -1;    
        LC_WWTR_KIND_CD.Index   = -1;    
        LC_WWTR_CHARGE_YN.Index = -1;       
        LC_STM_KIND_CD.Index    = -1;    
        LC_CWTR_KIND_CD.Index   = -1;    
        LC_GAS_KIND_CD.Index    = -1;    
        LC_GAS_REDU_TYPE.Index  = -1;    
        LC_WTR_KIND_CD.Index    = -1;    
        EM_TV_CNT.Text          = 0;
    }
}

 
/**
 * checkLenByteStr()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.01.24
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
-->
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝-
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
    //저장 성공시 재조회
    btn_Search(g_currKey);
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
if(clickSORT) return;
//화면
if (DS_IO_MASTER.CountRow > 0) {
	//세대정보 OBJ컨트롤
    objectControl(row);
	
    //alert("OnRowPosChanged(row)");
	// 관리비부과여부
	if (DS_IO_MASTER.NameValue(row, "MNTN_CAL_YN") == "Y" ) {//사용
		objectControlDtlDefault(true);   // 기타 항목 활성화
	} else {
		objectControlDtlDefault(false);  // 기타 항목 비활성화
	}
	//전압Filter시 오류방지
	//LC_PWR_TYPE.BindColVal =  DS_IO_MASTER.NameValue(row, "PWR_TYPE");
}
</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
if (!g_saveFlag) {
	if (DS_IO_MASTER.CountRow > 0) {
	    if (DS_IO_MASTER.RowStatus(row) == 1) {
	        var ret = showMessage(Question, YesNo, "USER-1049");
	        if (ret == "1") {
	            DS_IO_MASTER.DeleteRow(row);
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
	sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=LC_FCL_FLAG event=OnSelChange()>
//점 변경시 관리비부과여부 
if (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1 ){
	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MNTN_CAL_YN") = LC_FCL_FLAG.ValueOfIndex("MNTN_CAL_YN", LC_FCL_FLAG.Index);
	if (LC_FCL_FLAG.ValueOfIndex("MNTN_CAL_YN", LC_FCL_FLAG.Index) == 'Y') {
		objectControlDtlDefault(true);       // 기타 항목 활성화
	} else {
		objectControlDtlDefault(false);      // 기타 항목 비활성화
	}
}
</script>

<script language=JavaScript for=LC_S_IN_OUT event=OnSelChange()>
//조회조건초기화
if (LC_S_IN_OUT.BindColVal == "%") {
	EM_S_DT.Text = "";
	EM_E_DT.Text = "";
	EM_S_DT.Enable      = false;           
	EM_E_DT.Enable      = false;           
	enableControl(IMG_S_DT,false); // 조회기간 비활성화(팝업)
	enableControl(IMG_E_DT,false); // 조회기간 비활성화(팝업)
} else {
    initEmEdit(EM_S_DT,         "SYYYYMMDD",NORMAL); // [조회용]기간S
    initEmEdit(EM_E_DT,         "EYYYYMMDD",NORMAL); // [조회용]기간E
	enableControl(IMG_S_DT,true); // 조회기간 비활성화(팝업)
	enableControl(IMG_E_DT,true); // 조회기간 비활성화(팝업)
}
</script>
 
<script language=JavaScript for=EM_HUSE_ID event=onKeyUp(kcode,scode)>
//주거ID초기화
EM_DONG.Text    = "";//동
EM_HO.Text      = "";//호
EM_CNTR_AREA.Text = 0;//면적(㎡)
DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DONGHO") = "";
</script>

<script language=JavaScript for=EM_HUSE_ID event=OnKillFocus()>
// 주거ID pop
if(!this.Modified) return;

if (EM_HUSE_ID.Text.length > 0 ) {
	if (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) != 1) {
	    var orgHuseId = DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"HUSE_ID");
	    var newHuseId = EM_HUSE_ID.Text;
	    if (orgHuseId == newHuseId) {
	        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"HUSE_ID") = DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"HUSE_ID");
	        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DONG") = DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"DONG");
	        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"HO") = DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"HO");
	        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CNTR_AREA") = DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"CNTR_AREA");
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DONGHO") = DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"DONG")
            + "-" +DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"HO");
	        return;
	    }	
	}
	
    if (LC_FCL_FLAG.BindColVal == "" || LC_FCL_FLAG.BindColVal == "%") {//점 미선택시
        showMessage(STOPSIGN, OK, "USER-1003", "점");
        LC_FCL_FLAG.Focus();
        return;
    }  
    
    //단일건 체크 
    getHomeIdNonPop( "DS_O_RESULT", EM_HUSE_ID, LC_FCL_FLAG.BindColVal, "M", "0", "N");
    
    if (DS_O_RESULT.CountRow != 1 ) {
        //1건 이외의 내역이 조회 시 팝업 호출
        var rt = getHomeIdPop( EM_HUSE_ID, EM_DONG.Text, EM_HO.Text, LC_FCL_FLAG.BindColVal, "S", "0" );
        if (rt) {
            EM_DONG.Text = rt.DONG;
            EM_HO.Text = rt.HO;
            EM_CNTR_AREA.Text = rt.CNTR_AREA;
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DONGHO") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DONG")
            + "-" +DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"HO");
        } else {
            if (EM_HUSE_ID.Text == "") {
                //기존 값으로 변경
                DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"HUSE_ID") = DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"HUSE_ID");
                DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DONG") = DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"DONG");
                DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"HO") = DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"HO");
                DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CNTR_AREA") = DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"CNTR_AREA");
                DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DONGHO") = DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"DONG")
                + "-" +DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"HO");
            }
        } 
    } else {
    	if (DS_O_RESULT.NameValue(1, "USE_YN") == "Y") {
            EM_DONG.Text = DS_O_RESULT.NameValue(1,"DONG");
            EM_HO.Text = DS_O_RESULT.NameValue(1,"HO");
            EM_CNTR_AREA.Text = DS_O_RESULT.NameValue(1,"CNTR_AREA");
    	} else {
            showMessage(INFORMATION, OK, "USER-1000", "선택한 주거ID["+DS_O_RESULT.NameValue(1, "HUSE_ID")+"]는 해당 시설에 이미 등록되어 있습니다. ");
            EM_HUSE_ID.Text = "";
            EM_DONG.Text = "";
            EM_HO.Text = "";
            EM_CNTR_AREA.Text = "";
    	}
    }
}
</script>

<script language=JavaScript for=EM_MOVE_OUT_DT event=OnKillFocus()>
if (EM_MOVE_OUT_DT.Text.length == 8) {
	if (EM_MOVE_IN_DT.Text > EM_MOVE_OUT_DT.Text) {
	    showMessage(INFORMATION, OK, "USER-1000", "전출일은 전입일 이후로 입력하세요.");
	    EM_MOVE_OUT_DT.Text = "";
	    EM_MOVE_OUT_DT.Focus();
	    return;
	}
}
</script>

<script language=JavaScript for=RD_MNTN_CAL_YN event=OnSelChange()>
if (RD_MNTN_CAL_YN.CodeValue == 'Y') {
	objectControlDtl(true);    // 관리비부과 정보 활성화
} else {
	objectControlDtl(false);   // 관리비부과 정보 비활성화
}
</script>

<script language=JavaScript for=LC_PWR_KIND_CD event=OnSelChange()>
//alert("OnSelChange()");
//전기용도
DS_LC_PWR_TYPE.Filter();       // 전압구분 필터링
DS_LC_PWR_SEL_CHARGE.Filter(); // 요금제구분 필터링
if (LC_PWR_KIND_CD.BindColVal == "11") {//주택용
    DS_LC_PWR_TYPE.SortExpr = "+" + "CODE";
    DS_LC_PWR_TYPE.Sort();
    LC_PWR_TYPE.Index = 0;         // 전압기본값
	
    LC_PWR_SEL_CHARGE.Enable = false;   //전기선택요금제
    LC_PWR_SEL_CHARGE.Index = 0;
    EM_PWR_CNTR_QTY.Enable = false;     //전기계약전력
    //alert("language=JavaScript for=LC_PWR_KIND_CD event=OnSelChange(");
    EM_PWR_CNTR_QTY.Text = 0;
    EM_PWR_REVER_RATE.Enable = false;   //전기계약전력
    EM_PWR_REVER_RATE.Text = 0;
    
    LC_PWR_DC_TYPE.Enable   = true; 
    LC_PWR_DC_TYPE.Index = 0;
    LC_PWR_REDU_TYPE.Enable = true;
    LC_PWR_REDU_TYPE.Index = 0;
} else {
    //정렬
	DS_LC_PWR_TYPE.SortExpr = "+" + "CODE";
	DS_LC_PWR_TYPE.Sort();
	LC_PWR_TYPE.Index = 0;         // 전압기본값
	
    LC_PWR_SEL_CHARGE.Enable = true;   //전기선택요금제
    LC_PWR_SEL_CHARGE.Index = 0;
    EM_PWR_CNTR_QTY.Enable = true;     //전기계약전력
    EM_PWR_CNTR_QTY.Text = 0;
    EM_PWR_REVER_RATE.Enable = true;   //전기계약전력
    EM_PWR_REVER_RATE.Text = 0;
	
    LC_PWR_DC_TYPE.Enable   = false;    // 주택전력복지할인구분
    LC_PWR_DC_TYPE.Index = -1;
    LC_PWR_REDU_TYPE.Enable = false;    // 주택전력누진하향적용구분 
    LC_PWR_REDU_TYPE.Index = -1;
}
</script>

<script language=JavaScript for=LC_PWR_TYPE event=OnSelChange()>
//전압
DS_LC_PWR_SEL_CHARGE.Filter(); // 요금제구분 필터링
if (LC_PWR_TYPE.BindColVal == "1"||LC_PWR_TYPE.BindColVal == "5") { //저압전력
    //LC_PWR_SEL_CHARGE.Enable   = false;                      // 전기선택요금제비활성화
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PWR_SEL_CHARGE") = "0";   // 없음
} else {
    //LC_PWR_SEL_CHARGE.Enable   = true;                       // 전기선택요금제비활성화
    //DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PWR_SEL_CHARGE") = "";
}
</script>

<script language=JavaScript for=DS_LC_PWR_TYPE event=OnFilter(row)>
// 전압구분 필터링
if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "12" ||
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "14" ||
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "17" ) { //용도구분이 일반용(갑),교육용,산업용(갑)
    if (DS_LC_PWR_TYPE.NameValue(row,"CODE") == "4"||DS_LC_PWR_TYPE.NameValue(row,"CODE") == "5") { // 고압C 고압일반 제외
        return false;
    } else { 
        return true;
    }
} else if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "13" ||
           DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "15") { //용도구분이 일반용(을),산업용(을)
    if (DS_LC_PWR_TYPE.NameValue(row,"CODE") == "1"||DS_LC_PWR_TYPE.NameValue(row,"CODE") == "4"||DS_LC_PWR_TYPE.NameValue(row,"CODE") == "5") { // 저압, 고압C 고압일반 제외
        return false;
    } else { 
        return true;
    }
} else if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "11" ) { // 주택용
	if (DS_LC_PWR_TYPE.NameValue(row,"CODE") == "1"||DS_LC_PWR_TYPE.NameValue(row,"CODE") == "5") { // 저압, 고압만
	    return true;
	} else { 
	    return false;
	}       
} else { // 산업용(병)
    if (DS_LC_PWR_TYPE.NameValue(row,"CODE") == "1"||DS_LC_PWR_TYPE.NameValue(row,"CODE") == "5") {  // 저압 ,고압일반 제외
        return false;
    } else { 
        return true;
    }
}
</script>

<script language=JavaScript for=DS_LC_PWR_SEL_CHARGE event=OnFilter(row)>
// 요금제구분
if (DS_LC_PWR_SEL_CHARGE.NameValue(row,"CODE") == "A" || DS_LC_PWR_SEL_CHARGE.NameValue(row,"CODE") == "B") {//A:갑(정액등),B:을(종량등) 제외
    return false;
} else if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "16") { // 용도구분이 산업용(병)
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_TYPE") == "2") { // 고압 A
        if (DS_LC_PWR_SEL_CHARGE.NameValue(row,"CODE") == "0"||DS_LC_PWR_SEL_CHARGE.NameValue(row,"CODE") == "3") {//요금제 없음,선택III 제외
            return false;
        } else { 
            return true;
        }
    } else { // 고압 B,C
        if (DS_LC_PWR_SEL_CHARGE.NameValue(row,"CODE") == "0") {//요금제 없음 제외
            return false;
        } else { 
            return true;
        }
    }
} else if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "11") { // 주택용
    if (DS_LC_PWR_SEL_CHARGE.NameValue(row,"CODE") == "0") {//요금제 없음
        return true;
    } else { 
        return false;
    }
} else {
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_TYPE") == "1") { // 저압
        if (DS_LC_PWR_SEL_CHARGE.NameValue(row,"CODE") == "0") {//요금제 없음
            return true;
        } else { 
            return false;
        }
    } else { // 고압A,B,C
        if (DS_LC_PWR_SEL_CHARGE.NameValue(row,"CODE") == "0"||DS_LC_PWR_SEL_CHARGE.NameValue(row,"CODE") == "3") {//요금제 없음,선택III 제외
            return false;
        } else { 
            return true;
        }
    }
}
</script>

<script language=JavaScript for=DS_LC_PWR_KIND_CD event=OnFilter(row)>
// 계량기용도(전기요금)
if (DS_LC_PWR_KIND_CD.NameValue(row,"CODE").substring(0,1) == "1") {
	if (DS_LC_PWR_KIND_CD.NameValue(row,"CODE") == "18") return false; //가로등 제외
    return true;
} else { 
    return false;
}
</script>

<script language=JavaScript for=DS_LC_WWTR_KIND_CD event=OnFilter(row)>
// 계량기용도(온수(급탕)용도 )
if (DS_LC_WWTR_KIND_CD.NameValue(row,"CODE").substring(0,1) == "2") {
    return true;
} else { 
    return false;
}
</script>

<script language=JavaScript for=DS_LC_STM_KIND_CD event=OnFilter(row)>
// 계량기용도(증기용도 )
if (DS_LC_STM_KIND_CD.NameValue(row,"CODE").substring(0,1) == "0") {
    return true;
} else { 
    return false;
}
</script>

<script language=JavaScript for=DS_LC_CWTR_KIND_CD event=OnFilter(row)>
// 계량기용도(냉수용도 )
if (DS_LC_CWTR_KIND_CD.NameValue(row,"CODE").substring(0,1) == "0") {
    return true;
} else { 
    return false;
}
</script>

<script language=JavaScript for=DS_LC_GAS_KIND_CD event=OnFilter(row)>
// 계량기용도(가스용도 )
if (DS_LC_GAS_KIND_CD.NameValue(row,"CODE").substring(0,1) == "5") {
    return true;
} else { 
    return false;
}
</script>

<script language=JavaScript for=DS_LC_WTR_KIND_CD event=OnFilter(row)>
// 계량기용도(수도용도 : 수도)
if (DS_LC_WTR_KIND_CD.NameValue(row,"CODE").substring(0,1) == "6") {
    return true;
} else { 
    return false;
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
<!-- =============== Input용  -->
<comment id="_NSID_"><object id="DS_IO_MASTER"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<!-- =============== ONLOAD용 -->
<comment id="_NSID_"><object id="DS_LC_FCL_FLAG"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_PWR_DC_TYPE"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_PWR_REDU_TYPE"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_WWTR_CHARGE_YN"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_GAS_REDU_TYPE"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_MNTN_PAY_KIND"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- 전기용도 -->
<comment id="_NSID_">
<object id="DS_LC_PWR_KIND_CD"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>
<!-- 온수(급탕)용도 -->
<comment id="_NSID_">
<object id="DS_LC_WWTR_KIND_CD"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>
<!-- 증기용도 -->
<comment id="_NSID_">
<object id="DS_LC_STM_KIND_CD"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>
<!-- 냉수용도 -->
<comment id="_NSID_">
<object id="DS_LC_CWTR_KIND_CD"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>
<!-- 가스용도 -->
<comment id="_NSID_">
<object id="DS_LC_GAS_KIND_CD"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>
<!-- 수도용도 -->
<comment id="_NSID_">
<object id="DS_LC_WTR_KIND_CD"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_LC_PWR_TYPE"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_LC_PWR_SEL_CHARGE"  classid=<%=Util.CLSID_DATASET%>>
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
						<th class="point" width="90">시설구분</th>
						<td width="145"><comment id="_NSID_"> <object id=LC_S_FCL_FLAG
							classid=<%=Util.CLSID_LUXECOMBO%> width="140"
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="90">동호</th>
						<td width="207"><comment id="_NSID_"> <object
							id=EM_S_DONG classid=<%=Util.CLSID_EMEDIT%> width="92" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> - <comment
							id="_NSID_"> <object id=EM_S_HO
							classid=<%=Util.CLSID_EMEDIT%> width="92" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="90">세대주명</th>
						<td><comment id="_NSID_"> <object
							id=EM_S_HHOLD_NAME classid=<%=Util.CLSID_EMEDIT%> width="130"
							onKeyup="javascript:checkByteStr(this, 40, 'Y');" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>조회기간구분</th>
						<td><comment id="_NSID_"> <object id=LC_S_IN_OUT
							classid=<%=Util.CLSID_LUXECOMBO%> width="140" height=120
							tabindex=1 align="absmiddle">
							<param name=CBData value="%^전체,1^전입일,2^전출일">
							<param name=CBDataColumns value="CODE,NAME">
							<param name=SearchColumn value="NAME">
							<param name=ListExprFormat value="CODE^2^30,NAME^1^100">
							<param name=BindColumn value="CODE">
							<param name=Index  value="0">
						</object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">기간</th>
						<td ><comment id="_NSID_"> <object
							id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
						</object> </comment> <script>_ws_(_NSID_);</script> <img id=IMG_S_DT
							src="/<%=dir%>/imgs/btn/date.gif" id="btndate1" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DT)" /> ~ <comment
							id="_NSID_"> <object id=EM_E_DT
							classid=<%=Util.CLSID_EMEDIT%> width=70 align="absmiddle"
							onblur="javascript:checkDateTypeYMD(this);"> </object> </comment> <script>_ws_(_NSID_);</script>
						<img id=IMG_E_DT src="/<%=dir%>/imgs/btn/date.gif" id="btndate1"
							align="absmiddle" onclick="javascript:openCal('G',EM_E_DT)" /></td>
						<th width="90">현입주세대만<br>조회</th>
						<td><input type="checkbox" id="CHK_STAY_NOW"></td>
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
						<td width="100%"><comment id="_NSID_"><OBJECT
							id=GD_MASTER width=100% height=478 tabindex=1 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_IO_MASTER">
						</OBJECT></comment> <script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
				<td width="5">
				</td>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="s_table">
					<tr>
						<td class="sub_title" colspan=4><img
							src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
							align="absmiddle" class="PR03" /> 세대정보</td>
					</tr>
					<tr>
						<th width="95" class="point">시설구분</th>
						<td width="145"><comment id="_NSID_"> <object
							id=LC_FCL_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width="140"
							height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="95" class="point">세대ID</th>
						<td><comment id="_NSID_"> <object id=EM_HHOLD_ID
							classid=<%=Util.CLSID_EMEDIT%> width="135" height=100
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point">주거ID</th>
						<td><comment id="_NSID_"> <object
							id=EM_HUSE_ID classid=<%=Util.CLSID_EMEDIT%> width="115"
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img id="IMG_HUSE_ID"
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:callPopup();" align="absmiddle" /></td>
                        <th>난방면적(㎡)</th>
                        <td><comment id="_NSID_"> <object id=EM_HEAT_AREA
                            classid=<%=Util.CLSID_EMEDIT%> width="135" tabindex=1
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point">동호</th>
						<td><comment id="_NSID_"> <object id=EM_DONG
							classid=<%=Util.CLSID_EMEDIT%> width="62" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> - <comment
							id="_NSID_"> <object id=EM_HO
							classid=<%=Util.CLSID_EMEDIT%> width="62" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th>면적(㎡)</th>
						<td><comment id="_NSID_"> <object id=EM_CNTR_AREA
							classid=<%=Util.CLSID_EMEDIT%> width="135" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point">세대주명</th>
						<td><comment id="_NSID_"> <object id=EM_HHOLD_NAME onKeyup="javascript:checkByteStr(this, 40, 'Y');" 
							classid=<%=Util.CLSID_EMEDIT%> width="135" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th>전화번호</th>
						<td><comment id="_NSID_"> <object id=EM_PHONE1_NO
							classid=<%=Util.CLSID_EMEDIT%> width=37 tabindex=1 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script> - <comment id="_NSID_">
						<object id=EM_PHONE2_NO classid=<%=Util.CLSID_EMEDIT%> width=37 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> - <comment
							id="_NSID_"> <object id=EM_PHONE3_NO
							classid=<%=Util.CLSID_EMEDIT%> width=37 tabindex=1 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>

					<tr>
						<th class="point">전입일</th>
						<td><comment id="_NSID_"> <object id=EM_MOVE_IN_DT
							classid=<%=Util.CLSID_EMEDIT%> width=115 tabindex=1 align="absmiddle"
							onblur="javascript:checkDateTypeYMD(this);"> </object> </comment> <script>_ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_MOVE_IN_DT"
							align="absmiddle" onclick="javascript:openCal('G',EM_MOVE_IN_DT)" /></td>
						<th>전출일</th>
						<td><comment id="_NSID_"> <object id=EM_MOVE_OUT_DT
							classid=<%=Util.CLSID_EMEDIT%> width=115 tabindex=1 align="absmiddle"
							onblur="javascript:checkDateTypeYMD(this, '');"> </object> </comment> <script>_ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_MOVE_OUT_DT"
							align="absmiddle"
							onclick="javascript:openCal('G',EM_MOVE_OUT_DT)" /></td>
					</tr>
					<tr>
						<td class="sub_title" colspan=4><img
							src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
							align="absmiddle" class="PR03" /> 관리비부과 정보</td>
					</tr>
					<tr>
					<tr>
						<th class="point">관리비부과여부</th>
						<td><comment id="_NSID_"> <object id=RD_MNTN_CAL_YN
							classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
							tabindex=1>
							<param name=Cols value="2">
							<param name=Format value="Y^부과,N^미부과">
							<param name=CodeValue value="Y">
							<param name=AutoMargin value="true">
							<param name=AutoMargin value="true">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th>전기용도</th>
						<td ><comment id="_NSID_"> <object
							id=LC_PWR_KIND_CD classid=<%=Util.CLSID_LUXECOMBO%> width="140"
							height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th class="point">전기전압구분</th>
						<td><comment id="_NSID_"> <object
							id=LC_PWR_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width="140"
							height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th>전기선택요금제</th>
						<td><comment id="_NSID_"> <object
							id=LC_PWR_SEL_CHARGE classid=<%=Util.CLSID_LUXECOMBO%>
							width="140" height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>전기계약전력</th>
						<td><comment id="_NSID_"> <object
							id=EM_PWR_CNTR_QTY classid=<%=Util.CLSID_EMEDIT%> width="135"
							height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th>전기역률</th>
						<td><comment id="_NSID_"> <object id=EM_PWR_REVER_RATE
							classid=<%=Util.CLSID_EMEDIT%> width="135" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>주택전력복지<br>
						할인구분</th>
						<td><comment id="_NSID_"> <object
							id=LC_PWR_DC_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width="140"
							height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th>주택전력누진<br>하향적용구분</th>
						<td><comment id="_NSID_"> <object
							id=LC_PWR_REDU_TYPE classid=<%=Util.CLSID_LUXECOMBO%>
							width="140" height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>온수(급탕)용도</th>
						<td><comment id="_NSID_"> <object
							id=LC_WWTR_KIND_CD classid=<%=Util.CLSID_LUXECOMBO%> width="140"
							height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th>온수(급탕)차등<br>
						요금제여부</th>
						<td><comment id="_NSID_"> <object
							id=LC_WWTR_CHARGE_YN classid=<%=Util.CLSID_LUXECOMBO%>
							width="140" height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>증기용도</th>
						<td><comment id="_NSID_"> <object
							id=LC_STM_KIND_CD classid=<%=Util.CLSID_LUXECOMBO%> width="140"
							height=20 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>냉수용도</th>
						<td><comment id="_NSID_"> <object
							id=LC_CWTR_KIND_CD classid=<%=Util.CLSID_LUXECOMBO%> width="140"
							height=20 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>가스용도</th>
						<td><comment id="_NSID_"> <object
							id=LC_GAS_KIND_CD classid=<%=Util.CLSID_LUXECOMBO%> width="140"
							height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th>도시가스경감구분</th>
						<td><comment id="_NSID_"> <object
							id=LC_GAS_REDU_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width="140"
							height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>수도용도</th>
						<td><comment id="_NSID_"> <object
							id=LC_WTR_KIND_CD classid=<%=Util.CLSID_LUXECOMBO%> width="140"
							height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th>TV수신수량</th>
						<td><comment id="_NSID_"> <object id=EM_TV_CNT
							classid=<%=Util.CLSID_EMEDIT%> width="135" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>관리비납부방법</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=LC_MNTN_PAY_KIND classid=<%=Util.CLSID_LUXECOMBO%> width="140"
							height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
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
       <c>Col=STR_CD            Ctrl=LC_FCL_FLAG            param=BindColVal</c>
       <c>Col=HHOLD_ID          Ctrl=EM_HHOLD_ID            param=Text</c>
       <c>Col=HUSE_ID           Ctrl=EM_HUSE_ID             param=Text</c>
       <c>Col=DONG              Ctrl=EM_DONG                param=Text</c>
       <c>Col=HO                Ctrl=EM_HO                  param=Text</c>
       <c>Col=CNTR_AREA         Ctrl=EM_CNTR_AREA           param=Text</c>
       <c>Col=HEAT_AREA         Ctrl=EM_HEAT_AREA           param=Text</c>
       <c>Col=HHOLD_NAME        Ctrl=EM_HHOLD_NAME          param=Text</c>
       <c>Col=PHONE1_NO         Ctrl=EM_PHONE1_NO           param=Text</c>
       <c>Col=PHONE2_NO         Ctrl=EM_PHONE2_NO           param=Text</c>
       <c>Col=PHONE3_NO         Ctrl=EM_PHONE3_NO           param=Text</c>
       <c>Col=MOVE_IN_DT        Ctrl=EM_MOVE_IN_DT          param=Text</c>
       <c>Col=MOVE_OUT_DT       Ctrl=EM_MOVE_OUT_DT         param=Text</c>
       <c>Col=MNTN_CAL_YN       Ctrl=RD_MNTN_CAL_YN         param=CodeValue</c>
       <c>Col=PWR_KIND_CD       Ctrl=LC_PWR_KIND_CD         param=BindColVal</c>
       <c>Col=PWR_TYPE          Ctrl=LC_PWR_TYPE            param=BindColVal</c>
       <c>Col=PWR_SEL_CHARGE    Ctrl=LC_PWR_SEL_CHARGE      param=BindColVal</c>
       <c>Col=PWR_REVER_RATE    Ctrl=EM_PWR_REVER_RATE      param=Text</c>
       <c>Col=PWR_CNTR_QTY      Ctrl=EM_PWR_CNTR_QTY        param=Text</c>
       <c>Col=PWR_DC_TYPE       Ctrl=LC_PWR_DC_TYPE         param=BindColVal</c>
       <c>Col=PWR_REDU_TYPE     Ctrl=LC_PWR_REDU_TYPE       param=BindColVal</c>
       <c>Col=WWTR_KIND_CD      Ctrl=LC_WWTR_KIND_CD        param=BindColVal</c>
       <c>Col=WWTR_CHARGE_YN    Ctrl=LC_WWTR_CHARGE_YN      param=BindColVal</c>                   
       <c>Col=STM_KIND_CD       Ctrl=LC_STM_KIND_CD         param=BindColVal</c>
       <c>Col=CWTR_KIND_CD      Ctrl=LC_CWTR_KIND_CD        param=BindColVal</c>
       <c>Col=GAS_KIND_CD       Ctrl=LC_GAS_KIND_CD         param=BindColVal</c>
       <c>Col=GAS_REDU_TYPE     Ctrl=LC_GAS_REDU_TYPE       param=BindColVal</c>
       <c>Col=WTR_KIND_CD       Ctrl=LC_WTR_KIND_CD         param=BindColVal</c>
       <c>Col=GAS_REDU_TYPE     Ctrl=LC_GAS_REDU_TYPE       param=BindColVal</c>
       <c>Col=TV_CNT            Ctrl=EM_TV_CNT              param=Text</c>
       <c>Col=MNTN_PAY_KIND     Ctrl=LC_MNTN_PAY_KIND       param=BindColVal</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

