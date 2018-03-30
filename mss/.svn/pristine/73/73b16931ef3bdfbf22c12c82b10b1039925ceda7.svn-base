<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 계약관리 > 계약마스터관리
 * 작 성 일 : 2010.01.14
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : MREN2010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 시설구분별관리기준
 * 이    력 : 2010.01.14(박래형) 신규작성
           2010.04.14 (김유완) 수정개발
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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->
<script LANGUAGE="JavaScript"><!--

var g_saveFlag      = false;
var g_currKey       = "S";
var g_cesFlag       = false; //CES구분
var g_cntrFilter    = false; //CNTR_TYPE필터구분
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 145;		//해당화면의 동적그리드top위치
function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_CNTRMST"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER");
    
    //그리드 초기화
    gridCreate(); 
   
    // COMBO 초기화,EM 초기화
    initComboStyle(LC_S_FCL_FLAG,DS_LC_FCL_FLAG,            "CODE^0^30,NAME^0^80", 1, PK);      // [조회용]시설구분(점코드) 
    initEmEdit(EM_S_VEN_CD,        "NUMBER3^6^0",NORMAL);                                       // [조회용]협력사
    initEmEdit(EM_S_VEN_NM,        "GEN",READ);                                                 // [조회용]협력사명
    initComboStyle(LC_S_RENT_TYPE,  DS_LC_S_RENT_TYPE,      "CODE^0^30,NAME^0^80", 1, NORMAL);  // [조회용]임대형태
    DS_LC_S_RENT_TYPE.Filter();                                                                 // [조회용]임대형태 필터링
    DS_LC_S_RENT_TYPE.SortExpr =   "+" + "CODE";
    DS_LC_S_RENT_TYPE.Sort();
    initComboStyle(LC_S_RENT_FLAG,  DS_LC_S_RENT_FLAG,      "CODE^0^30,NAME^0^80", 1, NORMAL);  // [조회용]임대구분
    LC_S_RENT_FLAG.Enable = false;
    initComboStyle(LC_S_CNTR_TYPE,  DS_LC_S_CNTR_TYPE,      "CODE^0^30,NAME^0^80", 1, NORMAL);  // [조회용]계약유형
    initEmEdit(EM_S_DT,            "YYYYMMDD",READ);                                            // [조회용]기간S
    initEmEdit(EM_E_DT,            "YYYYMMDD",READ);                                            // [조회용]기간E
    
    // COMBO 초기화,EM 초기화
    initComboStyle(LC_FCL_FLAG,DS_LC_FCL_FLAG,              "CODE^0^30,NAME^0^80", 1, PK);      // 시설구분
    initEmEdit(EM_VEN_CD,          "NUMBER3^6^0",PK);                                           // 협력사
    initEmEdit(EM_VEN_NM,          "GEN",READ);                                                 // 협력사명
    initEmEdit(EM_COMP_NO,         "000-00-00000", READ);                                       // 사업자등록번호
    initEmEdit(EM_REP_NAME,        "GEN",READ);                                                 // 대표자
    initEmEdit(EM_PHONE_NO,        "GEN",READ);                                                 // 전화번호
    initComboStyle(LC_BELONG_STR_CD,DS_LC_BELONG_STR_CD,    "CODE^0^30,NAME^0^80", 1, NORMAL);  // 소속시설
    initEmEdit(EM_CHAR_NAME,       "GEN^40",NORMAL);                                            // 담당자명
    EM_CHAR_NAME.Language = 1;
    initEmEdit(EM_PHONE1_NO,       "NUMBER3^4^0",NORMAL);                                       // 담당자연락처1
    initEmEdit(EM_PHONE2_NO,       "NUMBER3^4^0",NORMAL);                                       // 담당자연락처2
    initEmEdit(EM_PHONE3_NO,       "NUMBER3^4^0",NORMAL);                                       // 담당자연락처3
    initComboStyle(LC_CNTR_TYPE,DS_LC_CNTR_TYPE,            "CODE^0^30,NAME^0^80", 1, PK);      // 계약유형
    initEmEdit(EM_SAP_CNTR_ID,     "NUMBER3^20^0",NORMAL);                                      // 계약번호
    initEmEdit(EM_CNTR_S_DT,       "YYYYMMDD",PK);                                              // 계약기간(F)
    initEmEdit(EM_CNTR_E_DT,       "YYYYMMDD",PK);                                              // 계약기간(T)
    initComboStyle(LC_RENT_TYPE,DS_LC_S_RENT_TYPE,          "CODE^0^30,NAME^0^80", 1, READ);    // 임대형태
    initComboStyle(LC_RENT_FLAG,DS_LC_S_RENT_FLAG,          "CODE^0^30,NAME^0^80", 1, READ);    // 임대구분
    initEmEdit(EM_CNTR_AREA,       "NUMBER^9^2",PK);                                            // 계약면적
    initEmEdit(EM_RENT_DEPOSIT,    "NUMBER^12^0",NORMAL);                                       // 임대보증금
    initEmEdit(EM_EXCL_AREA,       "NUMBER^9^2",NORMAL);                                        // 전용면적
	initEmEdit(EM_MM_RENTFEE_NOVAT,"NUMBER^12^0",NORMAL);                                       // 월임대료(VAT제외)
    initEmEdit(EM_SHR_AREA,        "NUMBER^9^2",NORMAL);                                        // 공유면적
	initEmEdit(EM_MM_RENTFEE_VAT,  "NUMBER^12^0",NORMAL);                                       // 월임대료(VAT금액)
    //initEmEdit(EM_DONG,            "GEN^3",NORMAL);                                             // 동
    //initEmEdit(EM_FLOOR_FLAG,      "GEN^2",NORMAL);                                             // 층
    //initEmEdit(EM_HO,              "GEN^4",NORMAL);                                             // 호
    initEmEdit(EM_DONG,            "GEN^3",PK);                                             // 동
    initEmEdit(EM_FLOOR_FLAG,      "GEN^2",PK);                                             // 층
    initEmEdit(EM_HO,              "GEN^4",PK);                                             // 호
    initEmEdit(EM_MM_RENTFEE,      "NUMBER^12^0",NORMAL);                                       // 월임대료(VAT포함)
    initEmEdit(EM_FILE_PATH,       "GEN^100",READ);                                             // 파일경로
    initComboStyle(LC_FCL_TYPE,DS_LC_FCL_TYPE,              "CODE^0^30,NAME^0^80", 1, PK);      // 임대시설종류  
    //initComboStyle(LC_PAY_TERM_TYPE,DS_LC_PAY_TERM_TYPE,    "CODE^0^30,NAME^0^80", 1, NORMAL);  // 관리비납부기한일자
    initComboStyle(LC_PAY_TERM_TYPE,DS_LC_PAY_TERM_TYPE,    "CODE^0^30,NAME^0^80", 1, PK);  // 관리비납부기한일자
    initComboStyle(LC_MNTN_CAL_YN,DS_LC_USE_YN,             "CODE^0^30,NAME^0^80", 1, PK);      // 관리비계산여부
    initComboStyle(LC_CHRG_YN,DS_LC_USE_YN,                 "CODE^0^30,NAME^0^80", 1, PK);      // 관리비청구내역관리여부
    initComboStyle(LC_ARR_CAL_YN,DS_LC_USE_YN,              "CODE^0^30,NAME^0^80", 1, PK);      // 관리비연체계산여부
    //initEmEdit(EM_PAY_TERM_DD,     "NUMBER^2^2",NORMAL);                                        // 관리비납부기한일자
    initEmEdit(EM_PAY_TERM_DD,     "NUMBER^2^2",PK);                                        // 관리비납부기한일자
    initEmEdit(EM_ARR_RATE,        "NUMBER^3^2",NORMAL);                                        // 연체율
    //initEmEdit(EM_OFFICE_PAY_AMT,"NUMBER^12^0",NORMAL);   // 오피스평당관리비
    
    //initComboStyle(LC_RENT_PAY_TERM_TYPE,DS_LC_PAY_TERM_TYPE,"CODE^0^30,NAME^0^80", 1, NORMAL); // 임대료납부기한일자
    initComboStyle(LC_RENT_PAY_TERM_TYPE,DS_LC_PAY_TERM_TYPE,"CODE^0^30,NAME^0^80", 1, NORMAL); // 임대료납부기한일자
    initComboStyle(LC_RENT_CAL_YN,DS_LC_USE_YN,             "CODE^0^30,NAME^0^80", 1, NORMAL);      // 임대료계산여부
    initComboStyle(LC_RENT_ARR_CAL_YN,DS_LC_USE_YN,         "CODE^0^30,NAME^0^80", 1, NORMAL);      // 임대료연체계산여부
    //initEmEdit(EM_RENT_PAY_TERM_DD,"NUMBER^2^2",NORMAL);                                        // 임대료납부기한일자 일
    initEmEdit(EM_RENT_PAY_TERM_DD,"NUMBER^2^2",NORMAL);                                        // 임대료납부기한일자 일
    initEmEdit(EM_RENT_ARR_RATE,   "NUMBER^3^2",NORMAL);                                        // 임대료연체율
    
    //initComboStyle(LC_PWR_KIND_CD,DS_LC_PWR_KIND_CD,        "CODE^0^30,NAME^0^80", 1, NORMAL);  // 전기용도
    //initComboStyle(LC_PWR_TYPE,DS_LC_PWR_TYPE,              "CODE^0^30,NAME^0^80", 1, NORMAL);  // 전기전압구분
    //initComboStyle(LC_PWR_SEL_CHARGE,DS_LC_PWR_SEL_CHARGE,  "CODE^0^30,NAME^0^80", 1, NORMAL);  // 전기선택요금제
    //initEmEdit(EM_PWR_CNTR_QTY, "NUMBER^7^0",NORMAL);                                           // 전기계약전력
    //initEmEdit(EM_PWR_REVER_RATE,"NUMBER^7^2",NORMAL);                                          // 역율
    //initComboStyle(LC_WWTR_KIND_CD,DS_LC_WWTR_KIND_CD,      "CODE^0^30,NAME^0^80", 1, NORMAL);  // 온수(급탕)용도
    //initEmEdit(EM_WWTR_QTY,     "NUMBER^9^2",NORMAL);                                           // 온수계약용량/계약면적
    //initComboStyle(LC_WWTR_CHARGE_YN,DS_LC_WWTR_CHARGE_YN,  "CODE^0^30,NAME^0^80", 1, NORMAL);  // 온수(급탕)차등요금제여부
    //initComboStyle(LC_STM_KIND_CD,DS_LC_STM_KIND_CD,        "CODE^0^30,NAME^0^80", 1, NORMAL);  // 증기용도
    //initEmEdit(EM_STM_QTY,      "NUMBER^9^2",NORMAL);                                           // 증기열교환기열량
    //initComboStyle(LC_CWTR_KIND_CD,DS_LC_CWTR_KIND_CD,      "CODE^0^30,NAME^0^80", 1, NORMAL);  // 냉수용도
    //initEmEdit(EM_CWTR_QTY,     "NUMBER^9^2",NORMAL);                                           // 냉수열교환기열량
    //initComboStyle(LC_GAS_KIND_CD,DS_LC_GAS_KIND_CD,        "CODE^0^30,NAME^0^80", 1, NORMAL);  // 가스용도
    //initComboStyle(LC_GAS_REDU_TYPE,DS_LC_GAS_REDU_TYPE,    "CODE^0^30,NAME^300^80", 1, NORMAL);// 도시가스경감구분
    //initComboStyle(LC_WTR_KIND_CD,DS_LC_WTR_KIND_CD,        "CODE^0^30,NAME^0^80", 1, NORMAL);  // 수도용도
    //initEmEdit(EM_DIV_RATE,     "NUMBER^3^2",NORMAL);                                           // 공용안분율
    //initEmEdit(EM_TV_CNT,       "NUMBER^3^0",NORMAL);                                           // TV수신수량
    //initComboStyle(LC_WTR_CAL_SIZE,DS_LC_WTR_CAL_SIZE,        "CODE^0^30,NAME^0^80", 1, NORMAL);  // 수도계량기구경
    //initEmEdit(EM_REMARK,       "GEN^100",NORMAL);                                           // 비고
    
    //시스템 코드 공통코드에서 가지고 오기
    getFlc("DS_LC_FCL_FLAG",            "M", "1", "Y", "N");                    // [조회용]시설구분(점코드) 
    LC_S_FCL_FLAG.index = 0;                   
    LC_S_FCL_FLAG.Focus();          
    getEtcCode("DS_LC_S_RENT_TYPE",     "D", "P003", "Y", "N", LC_S_RENT_TYPE); // [조회용]임대형태      
    getEtcCode("DS_LC_S_RENT_FLAG",     "D", "P084", "Y", "N", LC_S_RENT_FLAG); // [조회용]임대구분      
    getEtcCode("DS_LC_S_CNTR_TYPE",     "D", "M042", "Y", "N", LC_S_CNTR_TYPE); // [조회용]계약유형      
    getFlc("DS_LC_BELONG_STR_CD",       "M", "1", "Y", "N");                    // 소속시설 
    getEtcCode("DS_LC_CNTR_TYPE",       "D", "M042", "N", "N");                 // 계약유형    
    
    //getEtcCode("DS_LC_PWR_KIND_CD",     "D", "M045", "N");  // 전기용도      
    //DS_LC_PWR_KIND_CD.Filter();                             // 계량기용도(전기) 필터링
    //DS_LC_PWR_KIND_CD.SortExpr = "+" + "CODE";
    //DS_LC_PWR_KIND_CD.Sort();
    //getEtcCode("DS_LC_PWR_TYPE",        "D", "M047", "N");  // 전기전압구분      
    //getEtcCode("DS_LC_PWR_SEL_CHARGE",  "D", "M081", "N");  // 전기선택요금제      
    //getEtcCode("DS_LC_WWTR_KIND_CD",    "D", "M045", "N");  // 온수(급탕)용도  
    //DS_LC_WWTR_KIND_CD.Filter();                            // 온수(급탕)용도 필터링
    //DS_LC_WWTR_KIND_CD.SortExpr = "+" + "CODE";
    //DS_LC_WWTR_KIND_CD.Sort();
    //getEtcCode("DS_LC_WWTR_CHARGE_YN",  "D", "D022", "N");  // 온수(급탕)차등요금제여부     
    //getEtcCode("DS_LC_STM_KIND_CD",     "D", "M045", "N");  // 증기용도      
    //DS_LC_STM_KIND_CD.Filter();                             // 증기용도 필터링
    //DS_LC_STM_KIND_CD.SortExpr = "+" + "CODE";
    //DS_LC_STM_KIND_CD.Sort();
    //getEtcCode("DS_LC_CWTR_KIND_CD",    "D", "M045", "N");  // 냉수용도      
    //DS_LC_CWTR_KIND_CD.Filter();                            // 냉수용도 필터링
    //DS_LC_CWTR_KIND_CD.SortExpr = "+" + "CODE";
    //DS_LC_CWTR_KIND_CD.Sort();
    //getEtcCode("DS_LC_GAS_KIND_CD",     "D", "M045", "N");  // 가스용도      
    //DS_LC_GAS_KIND_CD.Filter();                             // 가스용도 필터링
    //DS_LC_GAS_KIND_CD.SortExpr = "+" + "CODE";
    //DS_LC_GAS_KIND_CD.Sort();
    //getEtcCode("DS_LC_GAS_REDU_TYPE",   "D", "M053", "N");  // 도시가스경감구분      
    //getEtcCode("DS_LC_WTR_KIND_CD",     "D", "M045", "N");  // 수도용도      
    //DS_LC_WTR_KIND_CD.Filter();                             // 수도용도 필터링
    //DS_LC_WTR_KIND_CD.SortExpr = "+" + "CODE";
    //DS_LC_WTR_KIND_CD.Sort();
    
    getEtcCode("DS_LC_PAY_TERM_TYPE",   "D", "M044", "N");  // 관리비납부기한일자
    getEtcCode("DS_LC_USE_YN",          "D", "D022", "N");  // 사용여부
    getEtcCode("DS_LC_FCL_TYPE",        "D", "M200", "N");  // 임대시설종류
    //getEtcCode("DS_LC_WTR_CAL_SIZE",    "D", "M087", "N");  // 수도계량기구경 
    
    
    //초기 입력OBJ SET
    objectControlDefault(false);
    /*PDF Files , Word Files, 압축 Files*/
    INF_FILEUPLOAD.FileFilterString = 2+8+128; 

}

function gridCreate() {
    var hdrProperies = '<FC>ID={CURROW}     NAME="NO"'        
                     + '                                    WIDTH=30    ALIGN=CENTER</FC>'
                     + '<FC>ID=CNTR_ID      NAME="계약ID"'
                     + '                                    WIDTH=70    ALIGN=CENTER</FC>'
                     + '<FC>ID=VEN_CD       NAME="협력사코드"'
                     + '                                    WIDTH=70    ALIGN=CENTER</FC>'
                     + '<FC>ID=VEN_NM       NAME="협력사명"'
                     + '                                    WIDTH=130   ALIGN=LEFT</FC>'
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
 * 작 성 일 : 2010.04.14
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search(row) {
    if (DS_IO_MASTER.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
            //조회시 체크
        	if (!searchValidate()) return;
            // parameters
            var strFlcFlag  = LC_S_FCL_FLAG.BindColVal; // [조회용]시설구분(점코드)
            var strVenCd    = EM_S_VEN_CD.Text;         // [조회용]협력사
            var strStayNow  = "N";                      // [조회용]현거주여부
            if (CHK_STAY_NOW.checked) {
                strStayNow  = "Y";
            }
            var strRentType = LC_S_RENT_TYPE.BindColVal;// [조회용]임대형태
            var strRentFlag = LC_S_RENT_FLAG.BindColVal;// [조회용]임대구분
            var strCntrType = LC_S_CNTR_TYPE.BindColVal;// [조회용]계약유형
            var strIOFlag   = LC_S_IN_OUT.BindColVal;   // [조회용]조회기간구분
            var strSdt      = EM_S_DT.Text;             // [조회용]기간S
            var strEdt      = EM_E_DT.Text;             // [조회용]기간E
            var goTo = "getMaster";
            var parameters = ""
                + "&strFlcFlag="    + encodeURIComponent(strFlcFlag)
                + "&strVenCd="      + encodeURIComponent(strVenCd)
                + "&strStayNow="    + encodeURIComponent(strStayNow)
                + "&strRentType="   + encodeURIComponent(strRentType)
                + "&strRentFlag="   + encodeURIComponent(strRentFlag)
                + "&strCntrType="   + encodeURIComponent(strCntrType)
                + "&strIOFlag="     + encodeURIComponent(strIOFlag)
                + "&strSdt="        + encodeURIComponent(strSdt)
                + "&strEdt="        + encodeURIComponent(strEdt);

            TR_MAIN.Action = "/mss/mren201.mr?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
            TR_MAIN.Post();
            
            // 조회결과 Return
            setPorcCount("SELECT", GD_MASTER);
            if (DS_IO_MASTER.CountRow < 1) {
                objectControlDefault(false);        	// 전체 항목 비활성화
            } else {
                //objectControlDefault(true);
                //objectControl1(false);
                //objectControl2(true);
            }
        } else {
            return;
        }
    }  else {
    	
        //조회시 체크
        if (!searchValidate()) return;
    	// parameters
        var strFlcFlag  = LC_S_FCL_FLAG.BindColVal; // [조회용]시설구분(점코드)
        var strVenCd    = EM_S_VEN_CD.Text;         // [조회용]협력사
        var strStayNow  = "N";                      // [조회용]현거주여부
        if (CHK_STAY_NOW.checked) {
            strStayNow = "Y";
        }
        var strRentType = LC_S_RENT_TYPE.BindColVal;// [조회용]임대형태
        var strRentFlag = LC_S_RENT_FLAG.BindColVal;// [조회용]임대구분
        var strCntrType = LC_S_CNTR_TYPE.BindColVal;// [조회용]계약유형
        var strIOFlag   = LC_S_IN_OUT.BindColVal;   // [조회용]조회기간구분
        var strSdt      = EM_S_DT.Text;             // [조회용]기간S
        var strEdt      = EM_E_DT.Text;             // [조회용]기간E
        var goTo = "getMaster";
        var parameters = ""
            + "&strFlcFlag="    + encodeURIComponent(strFlcFlag)
            + "&strVenCd="      + encodeURIComponent(strVenCd)
            + "&strStayNow="    + encodeURIComponent(strStayNow)
            + "&strRentType="   + encodeURIComponent(strRentType)
            + "&strRentFlag="   + encodeURIComponent(strRentFlag)
            + "&strCntrType="   + encodeURIComponent(strCntrType)
            + "&strIOFlag="     + encodeURIComponent(strIOFlag)
            + "&strSdt="        + encodeURIComponent(strSdt)
            + "&strEdt="        + encodeURIComponent(strEdt);
        
        TR_MAIN.Action = "/mss/mren201.mr?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();
        
        // 조회결과 Return
        setPorcCount("SELECT", GD_MASTER);
        if (DS_IO_MASTER.CountRow < 1) {
            objectControlDefault(false);        // 전체 항목 비활성화
        } else {
            //objectControlDefault(true);
            //objectControl1(false);
            //objectControl2(true);
        }
    }
    //저장 후 해당 위치 SET
    if (arguments[0] == undefined || arguments[0] == "S") {
        g_currKey = "S";
    } else {
    	if (getNameValueRow(DS_IO_MASTER, "CNTR_ID",g_currKey) == 0 ) {
    		DS_IO_MASTER.RowPosition = 1;
    	} else {
	        DS_IO_MASTER.RowPosition = getNameValueRow(DS_IO_MASTER, "CNTR_ID",g_currKey);
    	}
    }
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.14
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    if (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1049");
        if (ret == "1") {
            DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
            DS_IO_MASTER.AddRow();
        } else {
            return;
        }
    } else if  (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 3) {
        var ret = showMessage(Question, YesNo, "USER-1050");
        if (ret == "1") {
        	rollBackRowData(DS_IO_MASTER, DS_IO_MASTER.RowPosition);
            DS_IO_MASTER.AddRow();
        } else {
            return;
        }
    } else {
    	DS_IO_MASTER.AddRow();
    }
    //초기값 SET
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CNTR_TYPE") = '01'; //계약유형 (신규)
    LC_CNTR_TYPE.Enable = false; //신규시 계약유형은 신규
    LC_FCL_FLAG.Focus();
    LC_FCL_FLAG.index = 0; 
    
    LC_FCL_TYPE.index = 0;
    LC_MNTN_CAL_YN.index = 0;
    LC_CHRG_YN.index = 0;
    LC_ARR_CAL_YN.index = 1;
    LC_PAY_TERM_TYPE.index = 1;
    LC_RENT_CAL_YN.index = 1;
    LC_RENT_ARR_CAL_YN.index = 1;


    //LC_WWTR_KIND_CD.BindColVal = "22";  //온수용도 : 업무용 기본
    //LC_WWTR_CHARGE_YN.BindColVal = "N"; //온수차등요금제 : NO 기본
    //LC_CWTR_KIND_CD.BindColVal = "N";   //냉수용도 : 일반용 기본
    //LC_WTR_KIND_CD.BindColVal = "62";   //수됴용도 : 업무용 기본
    //objectControl1(true);
    //objectControl2(true);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.14
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
        	g_saveFlag = false;
            GD_MASTER.Focus();
            return;
        }
        
        //저장
        g_currKey = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_ID");
        var goTo = "save";
        TR_SAVE.Action = "/mss/mren201.mr?goTo=" + goTo;
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
 * searchValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.19
 * 개    요 : 값체크(저장)
 * return값 :
 */
function searchValidate() {
    // 시설구분
    if (LC_S_FCL_FLAG.BindColVal == "" || LC_S_FCL_FLAG.BindColVal == "%") {//점 미선택시
        showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
        LC_S_FCL_FLAG.Focus();
        return;
    }  
    
    if (LC_S_IN_OUT.BindColVal != "%") {
	    // 기간(F)
	    if ((EM_S_DT.Text).length < 8) {
	        showMessage(INFORMATION, OK, "USER-1002", "조회기간(FROM)");
	        EM_S_DT.Focus();
	        return false;
	    }
	    
	    // 기간(T)
	    if ((EM_E_DT.Text).length < 8) {
	        showMessage(INFORMATION, OK, "USER-1002", "조회기간(TO)");
	        EM_E_DT.Focus();
	        return false;
	    }
	    
	    //전출일 등록
	    if ((EM_S_DT.Text).length == 8) {
	        if (EM_S_DT.Text > EM_E_DT.Text) {
	            showMessage(INFORMATION, OK, "USER-1000", "조회기간(TO)는 조회기간(FROM) 이후로 입력하세요.");
	            EM_E_DT.Focus();
	            return false;
	        } 
	    }
	}
    
    return true;
}
 
/**
 * getVenInfo()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.19
 * 개    요 : 팝업 호출
 * return값 :
 */
function getVenInfo(strStrCd, strVenCd) {
    var goTo = "getVenInfo";
    var parameters = ""
        + "&strStrCd="  + encodeURIComponent(strStrCd)
        + "&strVenCd="  + encodeURIComponent(strVenCd);
    TR_MAIN.Action = "/mss/mren201.mr?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_O_VENINFO=DS_O_VENINFO)";
    TR_MAIN.Post();
    
    if (DS_O_VENINFO.CountRow == 1) {
    	if (DS_O_VENINFO.NameValue(1, "USE_COUNT") == "0") {
            EM_COMP_NO.Text = DS_O_VENINFO.NameValue(1, "COMP_NO");
            EM_REP_NAME.Text = DS_O_VENINFO.NameValue(1, "REP_NAME");
            EM_PHONE_NO.Text = DS_O_VENINFO.NameValue(1, "PHONE_NO");
            LC_RENT_TYPE.BindColVal = DS_O_VENINFO.NameValue(1, "BIZ_TYPE");
            LC_RENT_FLAG.BindColVal = DS_O_VENINFO.NameValue(1, "POS_CAL_FLAG");
            if (DS_O_VENINFO.NameValue(1, "BIZ_TYPE") == "4") { //입대갑일경우만 월임대료 활성화
                EM_MM_RENTFEE_NOVAT.Enable    = true;
            } else {
                EM_MM_RENTFEE_NOVAT.Text = 0;
                EM_MM_RENTFEE_NOVAT.Enable    = false;
            }
    	} else {
            showMessage(INFORMATION, OK, "USER-1000", "현재 계약중인 협력사 입니다.");
            EM_VEN_CD.Text = "";
            EM_VEN_NM.Text = "";
            EM_COMP_NO.Text = "";
            EM_REP_NAME.Text = "";
            EM_PHONE_NO.Text = "";
            LC_RENT_TYPE.Index = -1;
            LC_RENT_FLAG.Index = -1;
            EM_MM_RENTFEE_NOVAT.Text = 0;
            EM_MM_RENTFEE_NOVAT.Enable    = true;
            setTimeout("EM_VEN_CD.Focus()", 150);
    	}

    } else {
        //EM_VEN_CD.Text = "";
        //EM_VEN_NM.Text = "";
        EM_COMP_NO.Text = "";
        EM_REP_NAME.Text = "";
        EM_PHONE_NO.Text = "";
        LC_RENT_TYPE.Index = -1;
        LC_RENT_FLAG.Index = -1;
        EM_MM_RENTFEE_NOVAT.Text = 0;
        EM_MM_RENTFEE_NOVAT.Enable    = true;
    }
}
 
/**
 * callPopup()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.19
 * 개    요 : 팝업 호출
 * return값 :
 */
function callPopup(popupNm) {
    if (popupNm == "ven") {// [등록용]협력사
        if (LC_FCL_FLAG.BindColVal == ""
                || LC_FCL_FLAG.BindColVal == "%") {//시설구분 미선택시
            showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
            LC_FCL_FLAG.Focus();
            return;
        }
    
        var strOrgFlag = "2";
        var strBizType = "";
        /*
        if (LC_FCL_FLAG.ValueOfIndex("FCL_FLAG", LC_FCL_FLAG.Index) == "1") {
            // 백화점일경우 매입매춝구분:매출, 거래형태:임대을 ,임대갑
            strOrgFlag = "2";
            strBizType = "";
        } else {
        	// 그 외            매입매춝구분:매출, 거래형태:임대갑
            strOrgFlag = "2";
            strBizType = "4";
        }
        */
        var rt = venPop(EM_VEN_CD, EM_VEN_NM, LC_FCL_FLAG.BindColVal,"", "", strBizType, strOrgFlag, "", "T");
        if (EM_VEN_NM.Text == "") {
            EM_VEN_CD.Text = "";
            EM_COMP_NO.Text = "";
            EM_REP_NAME.Text = "";
            EM_PHONE_NO.Text = "";
            LC_RENT_TYPE.Index = -1;
            LC_RENT_FLAG.Index = -1;
            EM_MM_RENTFEE_NOVAT.Text = 0;
            EM_MM_RENTFEE_NOVAT.Enable    = true;
        }
        setTimeout("EM_VEN_CD.Focus()", 50);
        if (rt == null) return;
       	getVenInfo(LC_FCL_FLAG.BindColVal, EM_VEN_CD.Text)
        
    } else if ("sVen") { //[조회용]협력사
		if (LC_S_FCL_FLAG.BindColVal == ""
		    || LC_S_FCL_FLAG.BindColVal == "%") {//시설구분 미선택시
			showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
			LC_S_FCL_FLAG.Focus();
			  return;
		}

        var strOrgFlag = "2";
        var strBizType = "";
        /*
        if (LC_S_FCL_FLAG.ValueOfIndex("FCL_FLAG", LC_S_FCL_FLAG.Index) == "1") {
            // 백화점일경우 매입매춝구분:매출, 거래형태:임대을 ,임대갑
            strOrgFlag = "2";
            strBizType = "";
        } else {
            // 그 외            매입매춝구분:매출, 거래형태:임대갑
            strOrgFlag = "2";
            strBizType = "4";
        }
        */
		
		venPop(EM_S_VEN_CD, EM_S_VEN_NM, LC_S_FCL_FLAG.BindColVal,"", "", strBizType, strOrgFlag, "", "T");
    }
}

/**
 * objectControlDefault()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.19
 * 개    요 : 입력 활성/비활성화(전체)
 * return값 :
 */
function objectControlDefault(objBoolean) {
    if (objBoolean) {
        LC_FCL_FLAG.Enable				= true;
        EM_VEN_CD.Enable				= true;
        LC_BELONG_STR_CD.Enable			= true;
        EM_CHAR_NAME.Enable				= true;
        EM_PHONE1_NO.Enable				= true;
        EM_PHONE2_NO.Enable				= true;
        EM_PHONE3_NO.Enable				= true;
        LC_CNTR_TYPE.Enable				= true;
        EM_SAP_CNTR_ID.Enable			= true;
        EM_CNTR_S_DT.Enable				= true;
        EM_CNTR_E_DT.Enable				= true;
        EM_CNTR_AREA.Enable				= true;
        EM_RENT_DEPOSIT.Enable			= true;
        EM_EXCL_AREA.Enable				= true;
        EM_MM_RENTFEE_NOVAT.Enable		= true;
        EM_SHR_AREA.Enable				= true;
        EM_MM_RENTFEE_VAT.Enable		= true;
        EM_DONG.Enable					= true;
        EM_FLOOR_FLAG.Enable			= true;
        EM_HO.Enable					= true;
        EM_MM_RENTFEE.Enable			= true;
        //하단
        //08.02RD_MNTN_CAL_YN.Enable   = true;
        //LC_PWR_KIND_CD.Enable   = true;
        //LC_PWR_TYPE.Enable      = true;
        //LC_PWR_SEL_CHARGE.Enable= true;
        //EM_PWR_CNTR_QTY.Enable  = true;
        //EM_PWR_REVER_RATE.Enable= true;
        //LC_WWTR_KIND_CD.Enable  = true;
        //LC_WWTR_CHARGE_YN.Enable= true;
        //LC_STM_KIND_CD.Enable   = true;
        //CES시설일경우만 활성화
        if (g_cesFlag) {
            //EM_WWTR_QTY.Enable      = true;    //온수계약용량/계약면적
            //EM_STM_QTY.Enable       = true;    //증기열교효환기열량
            //EM_CWTR_QTY.Enable      = true;    //냉수열교효환기열량
        } else {
            //EM_WWTR_QTY.Enable      = false;
            //EM_STM_QTY.Enable       = false;
            //EM_CWTR_QTY.Enable      = false;
        }
        //LC_CWTR_KIND_CD.Enable  = true;
        //LC_GAS_KIND_CD.Enable   = true;
        //LC_GAS_REDU_TYPE.Enable = true;
        //LC_WTR_KIND_CD.Enable   = true;
        //EM_DIV_RATE.Enable      = true;
        //EM_TV_CNT.Enable        = true;
        //이미지
        enableControl(IMG_MREN_CHANGE,true);
        enableControl(IMG_MREN_HIS,true);
        enableControl(IMG_VEN_SEARCH,true);
        enableControl(IMG_CNTR_S_DT,true);
        enableControl(IMG_CNTR_E_DT,true);
        enableControl(IMG_FILE_SEARCH,true);
        enableControl(IMG_FILE_DOWN,true);
        enableControl(IMG_FILE_DEL,true);
        enableControl(IMG_S_DT,true); // 조회기간 비활성화(팝업)
        enableControl(IMG_E_DT,true); // 조회기간 비활성화(팝업)

        //08.02
        LC_FCL_TYPE.Enable				= true;
        LC_PAY_TERM_TYPE.Enable      	= true;
        LC_MNTN_CAL_YN.Enable        	= true;
        LC_CHRG_YN.Enable            	= true;
        LC_ARR_CAL_YN.Enable         	= true;
        EM_PAY_TERM_DD.Enable        	= true;
        EM_ARR_RATE.Enable           	= true;
        //EM_OFFICE_PAY_AMT.Enable = true;
        LC_RENT_PAY_TERM_TYPE.Enable 	= true;
        LC_RENT_CAL_YN.Enable        	= true;
        LC_RENT_ARR_CAL_YN.Enable    	= true;
        EM_RENT_PAY_TERM_DD.Enable   	= true;
        EM_RENT_ARR_RATE.Enable      	= true;
        //EM_REMARK.Enable = false;        
        
    } else {
		LC_FCL_FLAG.Enable				= false;
		EM_VEN_CD.Enable				= false;
		LC_BELONG_STR_CD.Enable			= false;
		EM_CHAR_NAME.Enable				= false;
		EM_PHONE1_NO.Enable				= false;
		EM_PHONE2_NO.Enable				= false;
		EM_PHONE3_NO.Enable				= false;
		LC_CNTR_TYPE.Enable				= false;
		EM_SAP_CNTR_ID.Enable			= false;
		EM_CNTR_S_DT.Enable				= false;
		EM_CNTR_E_DT.Enable				= false;
		EM_CNTR_AREA.Enable				= false;
		EM_RENT_DEPOSIT.Enable			= false;
		EM_EXCL_AREA.Enable				= false;
		EM_MM_RENTFEE_NOVAT.Enable		= false;
		EM_SHR_AREA.Enable				= false;
		EM_MM_RENTFEE_VAT.Enable		= false;
		EM_DONG.Enable					= false;
		EM_FLOOR_FLAG.Enable			= false;
		EM_HO.Enable					= false;
		EM_MM_RENTFEE.Enable			= false;
		//하단
		//08.02RD_MNTN_CAL_YN.Enable   = false;
		//LC_PWR_KIND_CD.Enable   = false;
		//LC_PWR_TYPE.Enable      = false;
		//LC_PWR_SEL_CHARGE.Enable= false;
		//EM_PWR_CNTR_QTY.Enable  = false;
		//EM_PWR_REVER_RATE.Enable= false;
		//LC_WWTR_KIND_CD.Enable  = false;
		//EM_WWTR_QTY.Enable      = false;
		//LC_WWTR_CHARGE_YN.Enable= false;
		//LC_STM_KIND_CD.Enable   = false;
		//EM_STM_QTY.Enable       = false;
		//LC_CWTR_KIND_CD.Enable  = false;
		//EM_CWTR_QTY.Enable      = false;
		//LC_GAS_KIND_CD.Enable   = false;
		//LC_GAS_REDU_TYPE.Enable = false;
		//LC_WTR_KIND_CD.Enable   = false;
		//EM_DIV_RATE.Enable      = false;
		//EM_TV_CNT.Enable        = false;
		//이미지
        enableControl(IMG_MREN_CHANGE,false);
        enableControl(IMG_MREN_HIS,false);
        enableControl(IMG_VEN_SEARCH,false);
		enableControl(IMG_CNTR_S_DT,false);
		enableControl(IMG_CNTR_E_DT,false);
		enableControl(IMG_FILE_SEARCH,false);
		enableControl(IMG_FILE_DOWN,false);
		enableControl(IMG_FILE_DEL,false);
        enableControl(IMG_S_DT,false); // 조회기간 비활성화(팝업)
        enableControl(IMG_E_DT,false); // 조회기간 비활성화(팝업)
        
      //08.02
        LC_FCL_TYPE.Enable				= false;
        LC_PAY_TERM_TYPE.Enable			= false;
        LC_MNTN_CAL_YN.Enable			= false;
        LC_CHRG_YN.Enable				= false;
        LC_ARR_CAL_YN.Enable			= false;
        EM_PAY_TERM_DD.Enable			= false;
        EM_ARR_RATE.Enable				= false;
        //EM_OFFICE_PAY_AMT.Enable	= false;
        LC_RENT_PAY_TERM_TYPE.Enable	= false;
        LC_RENT_CAL_YN.Enable			= false;
        LC_RENT_ARR_CAL_YN.Enable		= false;
        EM_RENT_PAY_TERM_DD.Enable		= false;
        EM_RENT_ARR_RATE.Enable			= false;
        //EM_REMARK.Enable			= false;
    }
}

/**
 * objectControl1()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.19
 * 개    요 : 입력 활성/비활성화(상단)
 * return값 :
 */
function objectControl1(objBoolean) {
    if (objBoolean) {
        LC_FCL_FLAG.Enable				= true;
        EM_VEN_CD.Enable				= true;
        //CES시설일경우만 활성화
        if (g_cesFlag) {
	        LC_BELONG_STR_CD.Enable = true;		//소속시설
        } else {
        	LC_BELONG_STR_CD.Enable = false;	//소속시설
        }
        EM_CHAR_NAME.Enable				= true;
        EM_PHONE1_NO.Enable				= true;
        EM_PHONE2_NO.Enable				= true;
        EM_PHONE3_NO.Enable				= true;
        //LC_CNTR_TYPE.Enable = true;
        EM_SAP_CNTR_ID.Enable			= true;
        //EM_CNTR_S_DT.Enable = true;
        //EM_CNTR_E_DT.Enable = true;
        EM_CNTR_AREA.Enable				= true;
        EM_RENT_DEPOSIT.Enable			= true;
        EM_EXCL_AREA.Enable				= true;
        EM_MM_RENTFEE_NOVAT.Enable		= true;
        EM_SHR_AREA.Enable				= true;
        EM_DONG.Enable					= true;
        EM_FLOOR_FLAG.Enable			= true;
        EM_HO.Enable					= true;
        //이미지
        enableControl(IMG_VEN_SEARCH,true);
        
      //08.02
        LC_FCL_TYPE.Enable				= true;
        LC_PAY_TERM_TYPE.Enable			= true;
        LC_MNTN_CAL_YN.Enable			= true;
        LC_CHRG_YN.Enable				= true;
        LC_ARR_CAL_YN.Enable			= true;
        EM_PAY_TERM_DD.Enable			= true;
        EM_ARR_RATE.Enable				= true;
        //EM_OFFICE_PAY_AMT.Enable = true;
        LC_RENT_PAY_TERM_TYPE.Enable	= true;
        LC_RENT_CAL_YN.Enable			= true;
        LC_RENT_ARR_CAL_YN.Enable		= true;
        EM_RENT_PAY_TERM_DD.Enable		= true;
        EM_RENT_ARR_RATE.Enable			= true;
        //EM_REMARK.Enable = true;
    } else {
        LC_FCL_FLAG.Enable				= false;
        EM_VEN_CD.Enable				= false;
        LC_BELONG_STR_CD.Enable			= false;
        EM_CHAR_NAME.Enable				= false;
        EM_PHONE1_NO.Enable				= false;
        EM_PHONE2_NO.Enable				= false;
        EM_PHONE3_NO.Enable				= false;
        //LC_CNTR_TYPE.Enable = false;
        EM_SAP_CNTR_ID.Enable			= false;
        //EM_CNTR_S_DT.Enable = false;
        //EM_CNTR_E_DT.Enable = false;
        EM_CNTR_AREA.Enable				= false;
        EM_RENT_DEPOSIT.Enable			= false;
        EM_EXCL_AREA.Enable				= false;
        EM_MM_RENTFEE_NOVAT.Enable		= false;
        EM_SHR_AREA.Enable				= false;
        EM_DONG.Enable					= false;
        EM_FLOOR_FLAG.Enable			= false;
        EM_HO.Enable					= false;
        //이미지
        enableControl(IMG_VEN_SEARCH,false);
        
      //08.02
        LC_FCL_TYPE.Enable				= false;
        LC_PAY_TERM_TYPE.Enable			= false;
        LC_MNTN_CAL_YN.Enable			= false;
        LC_CHRG_YN.Enable				= false;
        LC_ARR_CAL_YN.Enable			= false;
        EM_PAY_TERM_DD.Enable			= false;
        EM_ARR_RATE.Enable				= false;
        //EM_OFFICE_PAY_AMT.Enable = false;
        LC_RENT_PAY_TERM_TYPE.Enable	= false;
        LC_RENT_CAL_YN.Enable			= false;
        LC_RENT_ARR_CAL_YN.Enable		= false;
        EM_RENT_PAY_TERM_DD.Enable		= false;
        EM_RENT_ARR_RATE.Enable			= false;
        //EM_REMARK.Enable = false;
    }
}

/**
 * objectControl2()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.19
 * 개    요 : 입력 활성/비활성화(하단)
 * return값 :
 */
function objectControl2(objBoolean) {
    if (objBoolean) {
        //08.02RD_MNTN_CAL_YN.Enable   = true;
        //LC_PWR_KIND_CD.Enable   = true;
        //LC_PWR_TYPE.Enable      = true;
        //LC_PWR_SEL_CHARGE.Enable= true;
        //EM_PWR_CNTR_QTY.Enable  = true;
        //EM_PWR_REVER_RATE.Enable= true;
        //LC_WWTR_KIND_CD.Enable  = true;
        //LC_WWTR_CHARGE_YN.Enable= true;
        //LC_STM_KIND_CD.Enable   = true;
        //CES시설일경우만 활성화
        if (g_cesFlag) {
	        //EM_WWTR_QTY.Enable      = true;    //온수계약용량/계약면적
	        //EM_STM_QTY.Enable       = true;    //증기열교효환기열량
	        //EM_CWTR_QTY.Enable      = true;    //냉수열교효환기열량
        } else {
            //EM_WWTR_QTY.Enable      = false;
            //EM_STM_QTY.Enable       = false;
            //EM_CWTR_QTY.Enable      = false;
        }
        //LC_CWTR_KIND_CD.Enable  = true;
        //LC_GAS_KIND_CD.Enable   = true;
        //LC_GAS_REDU_TYPE.Enable = true;
        //LC_WTR_KIND_CD.Enable   = true;
        //EM_DIV_RATE.Enable      = true;
        //EM_TV_CNT.Enable        = true;
    } else {
        //08.02RD_MNTN_CAL_YN.Enable   = false;
        //LC_PWR_KIND_CD.Enable   = false;
        //LC_PWR_TYPE.Enable      = false;
        //LC_PWR_SEL_CHARGE.Enable= false;
        //EM_PWR_CNTR_QTY.Enable  = false;
        //EM_PWR_REVER_RATE.Enable= false;
        //LC_WWTR_KIND_CD.Enable  = false;
        //EM_WWTR_QTY.Enable      = false;
        //LC_WWTR_CHARGE_YN.Enable= false;
        //LC_STM_KIND_CD.Enable   = false;
        //EM_STM_QTY.Enable       = false;
        //LC_CWTR_KIND_CD.Enable  = false;
        //EM_CWTR_QTY.Enable      = false;
        //LC_GAS_KIND_CD.Enable   = false;
        //LC_GAS_REDU_TYPE.Enable = false;
       // LC_WTR_KIND_CD.Enable   = false;
        //EM_DIV_RATE.Enable      = false;
        //EM_TV_CNT.Enable        = false;
    }
}

/**
 * objectControl2Value()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.19
 * 개    요 : 입력 초기값(하단)
 * return값 :
 */
function objectControl2Value(objBoolean) {
    if (objBoolean) {
        //RD_MNTN_CAL_YN.Enable   = true;
        //LC_PWR_KIND_CD.Enable   = true;
        //LC_PWR_TYPE.Enable      = true;
        //LC_PWR_SEL_CHARGE.Enable= true;
        //EM_PWR_CNTR_QTY.Enable  = true;
        //EM_PWR_REVER_RATE.Enable= true;
        //LC_WWTR_KIND_CD.Enable  = true;
        //LC_WWTR_CHARGE_YN.Enable= true;
        //LC_STM_KIND_CD.Enable   = true;
        //CES시설일경우만 활성화
        if (g_cesFlag) {
            //EM_WWTR_QTY.Enable      = true;    //온수계약용량/계약면적
            //EM_STM_QTY.Enable       = true;    //증기열교효환기열량
            //EM_CWTR_QTY.Enable      = true;    //냉수열교효환기열량
        } else {
            //EM_WWTR_QTY.Enable      = false;
            //EM_STM_QTY.Enable       = false;
            //EM_CWTR_QTY.Enable      = false;
        }
        //LC_CWTR_KIND_CD.Enable  = true;
        //LC_GAS_KIND_CD.Enable   = true;
        //LC_GAS_REDU_TYPE.Enable = true;
        //LC_WTR_KIND_CD.Enable   = true;
        //EM_DIV_RATE.Enable      = true;
        //EM_TV_CNT.Enable        = true;
        
        //LC_PWR_KIND_CD.Index    = 0; 
        //LC_PWR_TYPE.Index       = 0; 
        //LC_PWR_SEL_CHARGE.Index = 0; 
        //EM_PWR_CNTR_QTY.Text    = 0;  
        //EM_PWR_REVER_RATE.Text  = 0;  
        //LC_WWTR_KIND_CD.Index   = 0; 
        //EM_WWTR_QTY.Text        = 0;  
        //LC_WWTR_CHARGE_YN.Index = 0; 
        //LC_STM_KIND_CD.Index    = 0; 
        //EM_STM_QTY.Text         = 0;  
        //LC_CWTR_KIND_CD.Index   = 0; 
        //EM_CWTR_QTY.Text        = 0;  
        //LC_GAS_KIND_CD.Index    = 0; 
        //LC_GAS_REDU_TYPE.Index  = 0; 
        //LC_WTR_KIND_CD.Index    = 0; 
        //EM_DIV_RATE.Text        = 0;  
        //EM_TV_CNT.Text          = 0;
        
    } else {
        //RD_MNTN_CAL_YN.Enable   = false;
        //LC_PWR_KIND_CD.Enable   = false;
        //LC_PWR_TYPE.Enable      = false;
        //LC_PWR_SEL_CHARGE.Enable= false;
        //EM_PWR_CNTR_QTY.Enable  = false;
        //EM_PWR_REVER_RATE.Enable= false;
        //LC_WWTR_KIND_CD.Enable  = false;
        //EM_WWTR_QTY.Enable      = false;
        //LC_WWTR_CHARGE_YN.Enable= false;
        //LC_STM_KIND_CD.Enable   = false;
        //EM_STM_QTY.Enable       = false;
        //LC_CWTR_KIND_CD.Enable  = false;
        //EM_CWTR_QTY.Enable      = false;
        //LC_GAS_KIND_CD.Enable   = false;
        //LC_GAS_REDU_TYPE.Enable = false;
        //LC_WTR_KIND_CD.Enable   = false;
        //EM_DIV_RATE.Enable      = false;
        //EM_TV_CNT.Enable        = false;
        
        //LC_PWR_KIND_CD.Index    = -1; 
        //LC_PWR_TYPE.Index       = -1; 
        //LC_PWR_SEL_CHARGE.Index = -1; 
        //EM_PWR_CNTR_QTY.Text    = 0;  
        //EM_PWR_REVER_RATE.Text  = 0;  
        //LC_WWTR_KIND_CD.Index   = -1; 
        //EM_WWTR_QTY.Text        = 0;  
        //LC_WWTR_CHARGE_YN.Index = -1; 
        //LC_STM_KIND_CD.Index    = -1; 
        //EM_STM_QTY.Text         = 0;  
        //LC_CWTR_KIND_CD.Index   = -1; 
        //EM_CWTR_QTY.Text        = 0;  
        //LC_GAS_KIND_CD.Index    = -1; 
        //LC_GAS_REDU_TYPE.Index  = -1; 
        //LC_WTR_KIND_CD.Index    = -1; 
        //EM_DIV_RATE.Text        = 0;  
        //EM_TV_CNT.Text          = 0;
    }
}


/**
 * checkValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.19
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidate() {
	// 시설구분
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD")=="") {
	    showMessage(INFORMATION, OK, "USER-1003", "시설구분");
	    LC_FCL_FLAG.Focus();
	    return false;
	} 
	
	// 협력사
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD")== "") {
	    showMessage(INFORMATION, OK, "USER-1002", "협력사");
	    EM_VEN_CD.Focus();
	    return false;
	} 
	
	// 담당자명
	var tmpNameLen= checkLenByteStr(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CHAR_NAME"))
	if (tmpNameLen > 40 ) {
	    showMessage(STOPSIGN, OK, "USER-1000", "담당자명은 40Byte(한글20/영문숫자40)이상 입력 할 수 없습니다.");
	    CHAR_NAME.Focus();
	    return false;
	} 
	
    // 전화번호 지역(통신사)번호
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PHONE1_NO") != "") {
        if (!firstTelFormatAll(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PHONE1_NO"), "T")) {
            showMessage(STOPSIGN, OK, "USER-1000", "올바르지 않은 지역(통신사)번호 입니다.");
            EM_PHONE1_NO.Focus();
            return false;
        } 
    }
	
	// 계약유형
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_TYPE") == "") {
	    showMessage(INFORMATION, OK, "USER-1003", "계약유형");
	    LC_CNTR_TYPE.Focus();
	    return false;
	}
	
	// 계약번호
	/*
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SAP_CNTR_ID") == "") {
	    showMessage(INFORMATION, OK, "USER-1002", "계약번호");
	    EM_SAP_CNTR_ID.Focus();
	    return false;
	}*/
	
	// 계약면적(㎡
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_AREA") == "") {
	    showMessage(INFORMATION, OK, "USER-1003", "계약면적");
	    EM_CNTR_AREA.Focus();
	    return false;
	}
	
	// 계약기간(F)
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_S_DT").length < 8) {
	    showMessage(INFORMATION, OK, "USER-1002", "계약기간(FROM)");
	    EM_CNTR_S_DT.Focus();
	    return false;
	}
	
	// 계약기간(T)
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_E_DT").length < 8) {
	    showMessage(INFORMATION, OK, "USER-1002", "계약기간(TO)");
	    EM_CNTR_E_DT.Focus();
	    return false;
	}
	
	//전출일 등록
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_S_DT").length == 8) {
	    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_S_DT") >  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_E_DT")) {
	        showMessage(INFORMATION, OK, "USER-1000", "계약기간(TO)는 계약기간(FROM) 이후로 입력하세요.");
	        EM_CNTR_E_DT.Focus();
	        return false;
	    } 
	}

	// 동/충/호
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DONG")== "") {
		showMessage(INFORMATION, OK, "USER-1002", "동/층/호");
	    EM_DONG.Focus();
	    return false;
	}
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FLOOR_FLAG")== "") {
		showMessage(INFORMATION, OK, "USER-1002", "동/층/호");
	    EM_FLOOR_FLAG.Focus();
	    return false;
	}
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "HO")== "") {
		showMessage(INFORMATION, OK, "USER-1002", "동/층/호");
	    EM_HO.Focus();
	    return false;
	}	
	
	// 임대시설종류
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FCL_TYPE")== "") {
	    showMessage(INFORMATION, OK, "USER-1002", "임대시설종류");
	    LC_FCL_TYPE.Focus();
	    return false;
	}
	
	// 관리비부과여부
	/*
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MNTN_CAL_YN")== "") {
	    showMessage(INFORMATION, OK, "USER-1002", "관리비부과여부");
	    //08.02RD_MNTN_CAL_YN.Focus();LC_MNTN_CAL_YN
	    LC_MNTN_CAL_YN.Focus();
	    return false;
	} 
	*/
	// 관리비청구내역관리여부	
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MNTN_CAL_YN")== "") {
	    showMessage(INFORMATION, OK, "USER-1002", "관리비부과여부");	    
	    LC_MNTN_CAL_YN.Focus();
	    return false;
	}	
	// 관리비청구내역관리여부	
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CHRG_YN")== "") {
	    showMessage(INFORMATION, OK, "USER-1002", "관리비청구내역관리여부");	    
	    LC_CHRG_YN.Focus();
	    return false;
	}

	// 관리비연체계산여부
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ARR_CAL_YN")== "") {
	    showMessage(INFORMATION, OK, "USER-1002", "관리비연체계산여부");	    
	    LC_ARR_CAL_YN.Focus();
	    return false;
	}

	// 관리비납부기한	
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_TERM_TYPE")== "") {
	    showMessage(INFORMATION, OK, "USER-1002", "관리비납부기한");	    
	    LC_PAY_TERM_TYPE.Focus();
	    return false;
	}
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_TERM_DD")== "") {
		showMessage(INFORMATION, OK, "USER-1002", "관리비납부기한");	    
		EM_PAY_TERM_DD.Focus();
		return false;
	}
	
// 	// 임대료계산여부
// 	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "RENT_CAL_YN")== "") {
// 	    showMessage(INFORMATION, OK, "USER-1002", "임대료계산여부");	    
// 	    LC_RENT_CAL_YN.Focus();
// 	    return false;
// 	}
	
// 	// 임대료연체계산여부
// 	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "RENT_ARR_CAL_YN")== "") {
// 	    showMessage(INFORMATION, OK, "USER-1002", "임대료연체계산여부");	    
// 	    LC_RENT_ARR_CAL_YN.Focus();
// 	    return false;
// 	}

// 	// 임대료납부기한	
// 	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "RENT_PAY_TERM_TYPE")== "") {
// 	    showMessage(INFORMATION, OK, "USER-1002", "임대료납부기한");	    
// 	    LC_RENT_PAY_TERM_TYPE.Focus();
// 	    return false;
// 	}	
// 	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "RENT_PAY_TERM_DD")== "") {
// 		showMessage(INFORMATION, OK, "USER-1002", "임대료납부기한");	    
// 		EM_RENT_PAY_TERM_DD.Focus();
// 		return false;
// 	}
		
	/*
	//오피스평당관리비	
	if (EM_OFFICE_PAY_AMT.Text == "") {
	    showMessage(INFORMATION, OK, "USER-1002", "오피스평당관리비");	    
	    EM_OFFICE_PAY_AMT.Focus();
	    return false;
	}*/

    return true;
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

/**
 * getMrenPop()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.01.24
 * 개    요 : POPUP 호출
 * return값 :
 */
function getMrenPop() {
	var strCntrId   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CNTR_ID");
	var strStrCd    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CD");
    var strVenCd    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_CD");
    var strVenNm    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_NM");
    var strCompNo   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"COMP_NO");
    var strRepNm    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"REP_NAME");
    var strRentType = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"RENT_TYPE");
    var strRentFlag = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"RENT_FLAG");
     
    var arrArg  = new Array();
 
    arrArg.push(strCntrId);
    arrArg.push(strStrCd);
    arrArg.push(strVenCd);
    arrArg.push(strVenNm);
    arrArg.push(strCompNo);
    arrArg.push(strRepNm);
    arrArg.push(strRentType);
    arrArg.push(strRentFlag);

   if(DS_IO_MASTER.CountRow >= 1) {
	   var returnVal = window.showModalDialog("/mss/mren201.mr?goTo=getMrenPop",
	            arrArg,
	            "dialogWidth:900px;dialogHeight:500px;scroll:no;" +
	            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
   }
   else {
	   showMessage(INFORMATION, OK, "USER-1000", "계약마스터 조회 후 조회 가능합니다.");
       return;
   }
}

/**
 * changeMren()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.19
 * 개    요 : 계약변경
 * return값 :
 */
function changeMren() {
	//계약변경 FLAG Y:계약변경, N:일반
	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CHANGED_FLAG") = "Y";
	//상단 활성화(계약변경 시)
    EM_CHAR_NAME.Enable     = true;
    EM_PHONE1_NO.Enable     = true;
    EM_PHONE2_NO.Enable     = true;
    EM_PHONE3_NO.Enable     = true;
    LC_CNTR_TYPE.Enable     = false;
    LC_CNTR_TYPE.BindColVal = "03"; // 변경계약
    EM_CNTR_S_DT.Enable     = true;
    EM_CNTR_E_DT.Enable     = true;
    EM_CNTR_AREA.Enable     = true;
    EM_RENT_DEPOSIT.Enable  = true;
    EM_EXCL_AREA.Enable     = true;
    
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"RENT_TYPE") == "4") { //입대갑일경우만 월임대료 활성화
        EM_MM_RENTFEE_NOVAT.Enable    = true;
    } else {
        EM_MM_RENTFEE_NOVAT.Text = 0;
        EM_MM_RENTFEE_NOVAT.Enable    = false;
    }
    EM_SHR_AREA.Enable      = true;
    EM_DONG.Enable          = true;
    EM_FLOOR_FLAG.Enable    = true;
    EM_HO.Enable            = true;
    //이미지
    enableControl(IMG_CNTR_S_DT,true);
    enableControl(IMG_CNTR_E_DT,true);
    enableControl(IMG_FILE_SEARCH,true);
    enableControl(IMG_FILE_DOWN,true);
    enableControl(IMG_FILE_DEL,true);
    
    //계약시작일 계약종료일SET (시작일:이전종료일+1일, 종료일:이전종료일+1년)
    var currEdt = DS_IO_MASTER.OrgNameValue(DS_IO_MASTER.RowPosition,"CNTR_E_DT");
    if (currEdt == "99991231") {
        EM_CNTR_S_DT.Text   = getTodayFormat("YYYYMMDD");
        EM_CNTR_E_DT.Text   = "99991231";
    } else {
        EM_CNTR_S_DT.Text   = setDateAdd("D", 1, currEdt);
        EM_CNTR_E_DT.Text   = setDateAdd("Y", 1, currEdt);
    }
    //하단 활성화
	objectControl2(true);
}

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
 * deleteFile()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 파일열기
 * return값 :
 */
function deleteFile() {
     var strFlag = "";
     if (DS_IO_MASTER.OrgNameValue(DS_IO_MASTER.RowPosition,"FILE_PATH") != "") {
        strFlag = "D";
     } else {
         strFlag = "N";
     }
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_GB") = strFlag;  // 파일Flag
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_PATH") = ""; // 파일경로(DB저장경로 String)
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_FILE_PATH") = ""; // 파일(실제파일저장위치)
}
 
/**
 * openFile()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.19
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
        if (chrByre != chrLen) {    // 파일명 한글
            showMessage(STOPSIGN, OK, "USER-1000", "파일명은 영문,숫자만으로 작성해주세요");
            return;
        } else if (chrByre > 22) {  // 파일명 22Byte이내작성
            showMessage(STOPSIGN, OK, "USER-1000", "파일명은 22Byte(영문,숫자22자)이내로 작성해주세요");
            return;
        } else {
	        if((1024 * 1024 * 5) < INF_FILEUPLOAD.FileInfo("size")){
	            showMessage(STOPSIGN, OK, "USER-1000", "업로드파일의 사이즈는 5M 를 넘을 수 없습니다.");
	            var strFlag = "";
	            if (DS_IO_MASTER.OrgNameValue(DS_IO_MASTER.RowPosition,"FILE_PATH") != "") {
	                strFlag = "D";
	            } else {
	                strFlag = "N";
	            }
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_GB") = strFlag;  // 파일Flag
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_PATH") = ""; // 파일경로(DB저장경로 String)
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_FILE_PATH") = ""; // 파일(실제파일저장위치)
	        } else {
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_GB") = "Y";           // 파일Flag
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_PATH") = strFileInfo; // 파일경로(DB저장경로 String)
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REAL_FILE_PATH") = strFileInfo; // 파일(실제파일저장위치)
	        }
	    }
	} 
}


/* 
function Exam( component ){
    //입력된 컴포넌트에 따라 처리 인자값 처리 변경
    var classId = component.classid.toUpperCase();
    switch(classId){
        //EMEDIT 에서 호출시
        case CLSID_EMEDIT :
            var vlaue = component.Text;
            value = vlaue.replace(' ','');
            // 빈값일경우

    }
} */




--></script>
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
if (row > 0) {
	//계약변경, 계약이력조회 버튼활성화
    enableControl(IMG_MREN_CHANGE,true);
    enableControl(IMG_MREN_HIS,true);
    enableControl(IMG_FILE_SEARCH,true);
    
    // 파일다운로드 컨트롤
    if (DS_IO_MASTER.NameValue(row, "OLD_FILE_PATH").length > 0 ) {
        enableControl(IMG_FILE_DOWN,true);
        enableControl(IMG_FILE_DEL,true);
    } else {
        enableControl(IMG_FILE_DOWN,false);
        enableControl(IMG_FILE_DEL,false);
    }
    
	//계약유형선택 필터링
	DS_LC_CNTR_TYPE.Filter();
	LC_CNTR_TYPE.BindColVal = DS_IO_MASTER.OrgNameValue(row,"CNTR_TYPE");
	
	//신규행 등록시 
	if (DS_IO_MASTER.RowStatus(row) == 1) {
        objectControl1(true);
        objectControl2(true);
        //계약변경, 계약이력조회 버튼비활성화
        enableControl(IMG_MREN_CHANGE,false);
        enableControl(IMG_MREN_HIS,false);
        
        EM_CNTR_S_DT.Enable = true;// 계약기간(F)
        EM_CNTR_E_DT.Enable = true;// 계약기간(T)
        enableControl(IMG_CNTR_S_DT,true);
        enableControl(IMG_CNTR_E_DT,true);
	} else {
		/*11.09.07 조회시에도 신규시와 동일하고 임시 수정*/
		
		//계약유형[신규등록]에 대해서는 등록일 당일에 대하여 계약정보 변경가능 LC_CNTR_TYPE
		if (DS_IO_MASTER.NameValue(row, "CNTR_TYPE") == "01" && DS_IO_MASTER.NameValue(row, "REG_DATE") == getTodayFormat("YYYYMMDD")) {
			objectControl1(true);
			objectControl2(true);
			//키값 시설구분, 협력사, 소속시설은 변경 불가능
	        LC_FCL_FLAG.Enable      = false;
	        EM_VEN_CD.Enable        = false;
	        LC_BELONG_STR_CD.Enable = false;
		} else {
			objectControl1(false);
			objectControl2(false);
		}
		

	    //계약해지일 경우 
	    if (DS_IO_MASTER.NameValue(row, "CNTR_TYPE")=="04") {
	    	LC_CNTR_TYPE.Enable = false;
            EM_CNTR_S_DT.Enable = false;// 계약기간(F)
            EM_CNTR_E_DT.Enable = false;// 계약기간(T)
            enableControl(IMG_CNTR_S_DT,false);
            enableControl(IMG_CNTR_E_DT,false);
            //계약변경, 계약이력조회 버튼비활성화
            enableControl(IMG_MREN_CHANGE,false);
        //계약유형이 재계약일경우만 계약기간 활성화
	    } else if (DS_IO_MASTER.NameValue(row, "CNTR_TYPE")=="02") {
	        LC_CNTR_TYPE.Enable = true;
	        EM_CNTR_S_DT.Enable = false;// 계약기간(F)
	        EM_CNTR_E_DT.Enable = true;// 계약기간(T)
	        enableControl(IMG_CNTR_S_DT,false);
	        enableControl(IMG_CNTR_E_DT,true);
	    } else {
	       // LC_CNTR_TYPE.Enable = true;
	        LC_CNTR_TYPE.Enable = false;
	        //계약유형[신규등록]에 대해서는 등록일 당일에 대하여 계약정보 (계약기간 )변경가능
	        if (DS_IO_MASTER.NameValue(row, "CNTR_TYPE") == "01" && DS_IO_MASTER.NameValue(row, "REG_DATE") == getTodayFormat("YYYYMMDD")) {
	        	LC_CNTR_TYPE.Enable = false;
	        	EM_CNTR_S_DT.Enable = true;// 계약기간(F)
	            EM_CNTR_E_DT.Enable = true;// 계약기간(T)
	            enableControl(IMG_CNTR_S_DT,true);
	            enableControl(IMG_CNTR_E_DT,true);
	        } else{
                EM_CNTR_S_DT.Enable = false;// 계약기간(F)
                EM_CNTR_E_DT.Enable = false;// 계약기간(T)
                enableControl(IMG_CNTR_S_DT,false);
                enableControl(IMG_CNTR_E_DT,false);
	        }
	    }
	    /*
	    //11.09.07 임시 추가 삭제 요망
		objectControl1(true);
        objectControl2(true);
        //계약변경, 계약이력조회 버튼비활성화
        enableControl(IMG_MREN_CHANGE,true);
        enableControl(IMG_MREN_HIS,true);
        
        LC_CNTR_TYPE.Enable = true;
        
        EM_CNTR_S_DT.Enable = true;// 계약기간(F)
        EM_CNTR_E_DT.Enable = true;// 계약기간(T)
        enableControl(IMG_CNTR_S_DT,true);
        enableControl(IMG_CNTR_E_DT,true);
        */
        
	}
} else {
    enableControl(IMG_MREN_CHANGE,false);
    enableControl(IMG_MREN_HIS,false);
    enableControl(IMG_FILE_SEARCH,false);
    enableControl(IMG_FILE_DOWN,false);
    enableControl(IMG_FILE_DEL,false);
}
</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
if (!g_saveFlag) {
    if (DS_IO_MASTER.CountRow > 0) {
        if (DS_IO_MASTER.RowStatus(row) == 1) { // 신규행작성시
            var ret = showMessage(Question, YesNo, "USER-1049");
            if (ret == "1") {
                DS_IO_MASTER.DeleteRow(row);
                return true;    
            } else {
                return false;   
            }
        } else if (DS_IO_MASTER.RowStatus(row) == 3) { //데이터 변경시
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
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=LC_FCL_FLAG event=OnSelChange()>
if (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1) {
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BELONG_STR_CD") =  LC_FCL_FLAG.BindColVal;
    EM_VEN_CD.Text = "";
    EM_VEN_NM.Text = "";
    EM_COMP_NO.Text = "";
    EM_REP_NAME.Text = "";
    EM_PHONE_NO.Text = "";
    LC_RENT_TYPE.Index = -1;
    LC_RENT_FLAG.Index = -1;
    //관립비부과여부값 변경
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MNTN_CAL_YN") = LC_FCL_FLAG.ValueOfIndex("MNTN_CAL_YN", LC_FCL_FLAG.Index);
    if (LC_FCL_FLAG.ValueOfIndex("MNTN_CAL_YN", LC_FCL_FLAG.Index) == "Y") {
        objectControl2Value(true);    // 관리비부과 정보 활성화
    } else {
        objectControl2Value(false);   // 관리비부과 정보 비활성화
    }
}
</script>

<script language=JavaScript for=LC_CNTR_TYPE event=OnSelChange()>
if (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 3) {
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_TYPE")=="02") {//재계약일경우만 활성화
	    EM_CNTR_S_DT.Enable = false;// 계약기간(F)
	    EM_CNTR_E_DT.Enable = true;// 계약기간(T)
	    enableControl(IMG_CNTR_S_DT,false);
	    enableControl(IMG_CNTR_E_DT,true);
	} else {
        EM_CNTR_S_DT.Enable = false;// 계약기간(F)
        EM_CNTR_E_DT.Enable = false;// 계약기간(T)
        enableControl(IMG_CNTR_S_DT,false);
        enableControl(IMG_CNTR_E_DT,false);
	}
} else if (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 0){
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_TYPE")=="02") {//재계약일경우만 활성화
        EM_CNTR_S_DT.Enable = false;// 계약기간(F)
        EM_CNTR_E_DT.Enable = true;// 계약기간(T)
        enableControl(IMG_CNTR_S_DT,false);
        enableControl(IMG_CNTR_E_DT,true);
    } else {
        EM_CNTR_S_DT.Enable = false;// 계약기간(F)
        EM_CNTR_E_DT.Enable = false;// 계약기간(T)
        enableControl(IMG_CNTR_S_DT,false);
        enableControl(IMG_CNTR_E_DT,false);
    }
}
</script>

<script language=JavaScript for= LC_CNTR_TYPE event=OnDropDown()>
g_cntrFilter = true;
DS_LC_CNTR_TYPE.Filter();       // 계약유형
//정렬
DS_LC_CNTR_TYPE.SortExpr = "+" + "CODE";
DS_LC_CNTR_TYPE.Sort();

LC_CNTR_TYPE.BindColVal = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CNTR_TYPE");
</script>

<script language=JavaScript for= LC_CNTR_TYPE event=OnCloseUp()>
g_cntrFilter = false;
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
    enableControl(IMG_S_DT,true); // 조회기간 활성화(팝업)
    enableControl(IMG_E_DT,true); // 조회기간 활성화(팝업)
}
</script>
<!-- 08.02-->  
<script language=JavaScript for=LC_MNTN_CAL_YN event=OnSelChange()>
if (LC_MNTN_CAL_YN.BindColVal == 'Y') {
	objectControl2Value(true);    // 관리비부과 정보 활성화
} else {
	objectControl2Value(false);   // 관리비부과 정보 비활성화
}
</script>
<!--  
<script language=JavaScript for=LC_PWR_KIND_CD event=OnSelChange()>
//전기용도
DS_LC_PWR_TYPE.Filter();       // 전기전압구분구분 필터링
DS_LC_PWR_SEL_CHARGE.Filter(); // 요금제구분 필터링
//정렬
DS_LC_PWR_TYPE.SortExpr = "+" + "CODE";
DS_LC_PWR_TYPE.Sort();
//신규행 등록시 
if (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1) {
    LC_PWR_TYPE.Index = 0;         // 전기전압구분기본값
}
</script>
 
<script language=JavaScript for=LC_PWR_TYPE event=OnSelChange()>
//전기전압구분
DS_LC_PWR_SEL_CHARGE.Filter(); // 요금제구분 필터링
if (LC_PWR_TYPE.BindColVal == "1"||LC_PWR_TYPE.BindColVal == "5") { //저압전력
    //LC_PWR_SEL_CHARGE.Enable   = false;                      // 전기선택요금제비활성화
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PWR_SEL_CHARGE") = "0";   // 없음
} else {
    //LC_PWR_SEL_CHARGE.Enable   = true;                       // 전기선택요금제비활성화
    //DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PWR_SEL_CHARGE") = "";
}
//신규행 등록시 
if (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1) {
	LC_PWR_SEL_CHARGE.Index = 0;   // 요금제구분 필터링
}
</script>

<script language=JavaScript for=DS_LC_PWR_TYPE event=OnFilter(row)>
// 전기전압구분구분 필터링
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
} 

if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PWR_KIND_CD") == "16") { // 용도구분이 산업용(병)
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
-->
<script language=JavaScript for=DS_LC_CNTR_TYPE event=OnFilter(row)>
// 계약유형 필터
if (g_cntrFilter) {
    if (DS_IO_MASTER.OrgNameValue(DS_IO_MASTER.RowPosition,"CNTR_TYPE") == "01") {
        if (DS_LC_CNTR_TYPE.NameValue(row,"CODE") == "03") {
            return false;
        } else { 
            return true;
        }
    } else if (DS_IO_MASTER.OrgNameValue(DS_IO_MASTER.RowPosition,"CNTR_TYPE") == "02") {
        if (DS_LC_CNTR_TYPE.NameValue(row,"CODE") == "02") {
            return true;
        } else { 
            return false;
        }
    } else if (DS_IO_MASTER.OrgNameValue(DS_IO_MASTER.RowPosition,"CNTR_TYPE") == "03") {
        if (DS_LC_CNTR_TYPE.NameValue(row,"CODE") == "01") {
            return false;
        } else { 
            return true;
        }
    } else {
    	return true;
    }
} else {
    return true;
}

</script>

<script language=JavaScript for=LC_S_RENT_TYPE event=OnSelChange()>
//[조회용]임대형태 - 임대을일 경우만 임대구분선택가능
if (LC_S_RENT_TYPE.BindColVal == "3") {
	LC_S_RENT_FLAG.Enable = true;
	LC_S_RENT_FLAG.Index = 0;
} else {
	LC_S_RENT_FLAG.Enable = false;
	LC_S_RENT_FLAG.Index = 0;
}
</script>

<script language=JavaScript for=DS_LC_S_RENT_TYPE event=OnFilter(row)>
// [조회용]임대형태
if (DS_LC_S_RENT_TYPE.NameValue(row,"CODE") == "%" 
		|| DS_LC_S_RENT_TYPE.NameValue(row,"CODE") == "3" 
		|| DS_LC_S_RENT_TYPE.NameValue(row,"CODE") == "4"
		|| DS_LC_S_RENT_TYPE.NameValue(row,"CODE") == "5"
		) { //임대갑, 임대을만
    return true;
} else { 
    return false;
}
</script>
<!--  
<script language=JavaScript for=DS_LC_PWR_KIND_CD event=OnFilter(row)>
// 계량기용도(전기요금)
if (DS_LC_PWR_KIND_CD.NameValue(row,"CODE").substring(0,1) == "1") {
    if (DS_LC_PWR_KIND_CD.NameValue(row,"CODE") == "18" || DS_LC_PWR_KIND_CD.NameValue(row,"CODE") == "11") return false; // 주택/가로등 제외
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
-->
<script language=JavaScript for=EM_S_VEN_CD event=OnKillFocus()>
//[조회용]협력사 코드 자동완성 및 팝업호출
    if(!this.Modified)
        return;
        
    if(this.text==''){
        EM_S_VEN_NM.Text = "";
        return;
    }
    
    if (LC_S_FCL_FLAG.BindColVal == "") {//점 미선택시
        showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
        LC_S_FCL_FLAG.Focus();
        return;
    }
    
    var strOrgFlag = "2";
    var strBizType = "";
    /*
    if (LC_S_FCL_FLAG.ValueOfIndex("FCL_FLAG", LC_S_FCL_FLAG.Index) == "1") {
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
    setVenNmWithoutPop("DS_O_RESULT", EM_S_VEN_CD, EM_S_VEN_NM , 1, LC_S_FCL_FLAG.BindColVal, "", "", strBizType, strOrgFlag, "", "T");
</script>
    
<!-- 시설구분 OnSelChange() -->
<script language=JavaScript for=LC_S_FCL_FLAG event=OnSelChange()>
    EM_S_VEN_CD.Text = "";
    EM_S_VEN_NM.Text = "";
</script>

<script language=JavaScript for=EM_VEN_CD event=OnKillFocus()>
//협력사 코드 자동완성 및 팝업호출
    if(!this.Modified) return;
        
    if(this.text==""){
        EM_VEN_NM.Text = "";
        EM_VEN_CD.Text = "";
        EM_VEN_NM.Text = "";
        EM_COMP_NO.Text = "";
        EM_REP_NAME.Text = "";
        EM_PHONE_NO.Text = "";
        LC_RENT_TYPE.Index = -1;
        LC_RENT_FLAG.Index = -1;
        return;
    }
    
    if (LC_FCL_FLAG.BindColVal == "") {//점 미선택시
        showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
        LC_FCL_FLAG.Focus();
        return;
    }
    
    var strOrgFlag = "2";
    var strBizType = "";
    /*
    if (LC_FCL_FLAG.ValueOfIndex("FCL_FLAG", LC_FCL_FLAG.Index) == "1") {
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
    var rt = setVenNmWithoutPop("DS_O_RESULT", EM_VEN_CD, EM_VEN_NM , 1, LC_FCL_FLAG.BindColVal, "", "", strBizType, strOrgFlag, "", "T");
    
    if (rt == undefined) {
        //협력사 정보 SET
        if (DS_O_RESULT.CountRow == 1) {
            getVenInfo(LC_FCL_FLAG.BindColVal, EM_VEN_CD.Text)
        }
    } else if (rt == null) {
        if(EM_VEN_NM.text==""){
            EM_VEN_NM.Text = "";
            EM_VEN_CD.Text = "";
            EM_VEN_NM.Text = "";
            EM_COMP_NO.Text = "";
            EM_REP_NAME.Text = "";
            EM_PHONE_NO.Text = "";
            LC_RENT_TYPE.Index = -1;
            LC_RENT_FLAG.Index = -1;
            return;
        }   
    } else {
    	EM_VEN_CD.Text = "";
    	EM_VEN_CD.Focus();
    	EM_VEN_CD.Text = rt.get("VEN_CD");
    	EM_VEN_NM.Text = rt.get("VEN_NAME");
    	return;
    }
</script>  

<!-- EM_MM_RENTFEE_VAT -->
<script language=JavaScript for=EM_MM_RENTFEE_NOVAT event=OnKillFocus()>
	EM_MM_RENTFEE_VAT.Text = EM_MM_RENTFEE_NOVAT.Text * 0.1;
	EM_MM_RENTFEE.Text = eval(EM_MM_RENTFEE_VAT.Text) + eval(EM_MM_RENTFEE_NOVAT.Text);
</script>


<!-- <script language=JavaScript for=EM_MM_RENTFEE_NOVAT event=OnKillFocus(row,colid,oldData)>
    var orgValue = DS_IO_MASTER.OrgNameValue(row,colid);
    var newValue = DS_IO_MASTER.NameValue(row,colid);
    var changeFlag = oldData != newValue  ;
    switch (colid) {
    case "MM_RENTFEE_NOVAT" :
    	if(oldData != newValue){
    	DS_IO_MASTER.NameValue(row,"MM_RENTFEE_VAT") = DS_IO_MASTER.NameValue(row,"MM_RENTFEE_NOVAT") / 0.1;
//		- (eval(this.DataID).NameValue(row,"MM_RENTFEE_NOVAT") / 1.1);
        	//if( changeFlag && !g_taxInvFlag){        		        		
			//eval(this.DataID).NameValue(row,"USE_AMT") = eval(this.DataID).NameValue(row,"USE_QTY") * EM_COST_AMT.Text + eval(this.DataID).NameValue(row,"VAT_AMT");
        }else{
       		return;
       	}
       	break;
    }
    return true;
/*     
 	if(this.Modified) 
		return;
        
    if(EM_MM_RENTFEE_NOVAT.text!=""){
    	EM_MM_RENTFEE.text = '1';
        return;
    } */
</script> -->







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
<comment id="_NSID_"><object id="DS_O_VENINFO"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== ONLOAD용 -->
<comment id="_NSID_"><object id="DS_LC_FCL_FLAG"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_BELONG_STR_CD"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>


<comment id="_NSID_"><object id="DS_LC_S_RENT_FLAG"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_CNTR_TYPE"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_PAY_TERM_TYPE"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_USE_YN"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PUB_DIV_RATE"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_FCL_TYPE"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- 임대형태  -->
<comment id="_NSID_">
<object id="DS_LC_S_RENT_TYPE"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>
<!-- 계약유형  -->
<comment id="_NSID_">
<object id="DS_LC_CNTR_TYPE"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>
<!-- 전기용도 -->
<comment id="_NSID_">
<object id="DS_LC_PWR_KIND_CD"    classid=<%=Util.CLSID_DATASET%>>
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

<!--------------------- 3. Fileupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_FILEUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
    <param name="Text" value='FileOpen'>
    <param name="Enable" value="true">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝
<!--*************************************************************************-->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
       var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top) {
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
						<th class="point" width="80">시설구분</th>
						<td width="120"><comment id="_NSID_"> <object
							id=LC_S_FCL_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width="120"
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80">협력사</th>
						<td width="205"><comment id="_NSID_"> <object
							id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:callPopup('sVen')" align="absmiddle" /> <comment
							id="_NSID_"> <object id=EM_S_VEN_NM
							classid=<%=Util.CLSID_EMEDIT%> width=110 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="90">현계약만조회</th>
						<td><input type="checkbox" id="CHK_STAY_NOW" tabindex=1></td>
					</tr>
					<tr>
						<th>임대형태</th>
						<td><comment id="_NSID_"> <object id=LC_S_RENT_TYPE
							classid=<%=Util.CLSID_LUXECOMBO%> width="120" tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>임대구분</th>
						<td><comment id="_NSID_"> <object id=LC_S_RENT_FLAG
							classid=<%=Util.CLSID_LUXECOMBO%> width="200" tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>계약유형</th>
						<td><comment id="_NSID_"> <object id=LC_S_CNTR_TYPE
							classid=<%=Util.CLSID_LUXECOMBO%> width="120" tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>조회기간구분</th>
						<td><comment id="_NSID_"> <object id=LC_S_IN_OUT
							classid=<%=Util.CLSID_LUXECOMBO%> width="120" 
							tabindex=1 align="absmiddle">
							<param name=CBData value="%^전체,1^계약시작일,2^계약종료일">
							<param name=CBDataColumns value="CODE,NAME">
							<param name=SearchColumn value="NAME">
							<param name=ListExprFormat value="CODE^2^30,NAME^1^100">
							<param name=BindColumn value="CODE">
							<param name=Index value="0">
						</object> </comment><script>_ws_(_NSID_);</script></td>
						<th>조회기간</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
						</object> </comment> <script>_ws_(_NSID_);</script> <img id=IMG_S_DT
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DT)" /> ~ <comment
							id="_NSID_"> <object id=EM_E_DT
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"
							onblur="javascript:checkDateTypeYMD(this);"> </object> </comment> <script>_ws_(_NSID_);</script>
						<img id=IMG_E_DT src="/<%=dir%>/imgs/btn/date.gif"
							align="absmiddle" onclick="javascript:openCal('G',EM_E_DT)" /></td>
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
				<td width="270">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td width="100%"><comment id="_NSID_"><OBJECT
							id=GD_MASTER width=350 height=454 tabindex=1
							classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_IO_MASTER">
						</OBJECT></comment> <script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
				<td width="5"></td>
				<td>
				<div id="DIV_CONTENTS"
					style="width: 100%; height: 600; overflow-y: scroll;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="s_table">
					<tr>
						<td class="sub_title" colspan=4>
						<span id="SPAN_TITLE_01" class="sub_title" style="width:357px; align:left"><img
							src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
							align="absmiddle" class="PR03" /> 계약정보</span>
						<span id="SPAN_TITLE_02" style="width:158px; align:right"><img
							src="/<%=dir%>/imgs/btn/contract_change.gif" id="IMG_MREN_CHANGE"
							onclick="javascript:changeMren();" hspace="2" align="absmiddle" />
						<img src="/<%=dir%>/imgs/btn/contract_list_search.gif"
							id="IMG_MREN_HIS" onclick="javascript:getMrenPop();" hspace="2"
							align="absmiddle" /></span>
						</td>
					</tr><!--
					<tr>
						<th width="80" class="point">시설구분</th>
						<td width="125"><comment id="_NSID_"> <object
							id=LC_FCL_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width="120"
							height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80" class="point">협력사</th>
						<td><comment id="_NSID_"> <object id=EM_VEN_CD
							classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
							id="IMG_VEN_SEARCH" src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							class="PR03" onclick="javascript:callPopup('ven')"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=110
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					--><tr>
						<th width="120" class="point">시설구분</th>
						<td width="125"><comment id="_NSID_"> <object
							id=LC_FCL_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width="120"
							height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="150" class="point">협력사</th>
						<td><comment id="_NSID_"> <object id=EM_VEN_CD
							classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
							id="IMG_VEN_SEARCH" src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							class="PR03" onclick="javascript:callPopup('ven')"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=110
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>					
					<tr>
						<th>사업자등록번호</th>
						<td><comment id="_NSID_"> <object id=EM_COMP_NO
							classid=<%=Util.CLSID_EMEDIT%> width="115" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th>대표자</th>
						<td><comment id="_NSID_"> <object id=EM_REP_NAME
							classid=<%=Util.CLSID_EMEDIT%> width="195" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><comment id="_NSID_"> <object id=EM_PHONE_NO
							classid=<%=Util.CLSID_EMEDIT%> width="115" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th>소속시설</th>
						<td><comment id="_NSID_"> <object
							id=LC_BELONG_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="200"
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>담당자명</th>
						<td><comment id="_NSID_"> <object id=EM_CHAR_NAME
							classid=<%=Util.CLSID_EMEDIT%> width="115" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th>담당자연락처</th>
						<td><comment id="_NSID_"> <object id=EM_PHONE1_NO
							classid=<%=Util.CLSID_EMEDIT%> width="57" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
							id="_NSID_"> <object id=EM_PHONE2_NO
							classid=<%=Util.CLSID_EMEDIT%> width="57" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
							id="_NSID_"> <object id=EM_PHONE3_NO
							classid=<%=Util.CLSID_EMEDIT%> width="57" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point">계약유형</th>
						<td><comment id="_NSID_"> <object id=LC_CNTR_TYPE
							classid=<%=Util.CLSID_LUXECOMBO%> width="120" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th>계약번호</th>
						<td><comment id="_NSID_"> <object id=EM_SAP_CNTR_ID
							classid=<%=Util.CLSID_EMEDIT%> width="195" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point">계약기간</th>
						<td colspan="3">
							<comment id="_NSID_"> 
								<object id=EM_CNTR_S_DT classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);"></object> 
							</comment> 
							<script>_ws_(_NSID_);</script> 
							<img id=IMG_CNTR_S_DT src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_CNTR_S_DT)" />
							 
								~ 
							
							<comment id="_NSID_"> 
								<object id=EM_CNTR_E_DT classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);"></object> 
							</comment> 
							<script>_ws_(_NSID_);</script>
							<img id=IMG_CNTR_E_DT src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_CNTR_E_DT)" />
						</td>
					</tr>
					<tr>
						<th>임대형태/<BR>
						임대구분</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=LC_RENT_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width="115"
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						/ <comment id="_NSID_"><object id=LC_RENT_FLAG
							classid=<%=Util.CLSID_LUXECOMBO%> width="115" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point">계약면적(평)</th>
						<td><comment id="_NSID_"> <object id=EM_CNTR_AREA
							classid=<%=Util.CLSID_EMEDIT%> width="115" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th>임대보증금</th>
						<td><comment id="_NSID_"> <object
							id=EM_RENT_DEPOSIT classid=<%=Util.CLSID_EMEDIT%> width="195"
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>전용면적(평)</th>
						<td><comment id="_NSID_"> <object id=EM_EXCL_AREA
							classid=<%=Util.CLSID_EMEDIT%> width="115" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th>월임대료(VAT제외)</th>
						<td>
							<comment id="_NSID_"> 
								<object id=EM_MM_RENTFEE_NOVAT classid=<%=Util.CLSID_EMEDIT%> width="195" tabindex=1 
										align="absmiddle"></object>
							</comment> 
							<script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>공유면적(평)</th>
						<td><comment id="_NSID_"> <object id=EM_SHR_AREA
							classid=<%=Util.CLSID_EMEDIT%> width="115" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th>월임대료VAT</th>
						<td><comment id="_NSID_"> <object id=EM_MM_RENTFEE_VAT
							classid=<%=Util.CLSID_EMEDIT%> width="195" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr><!--
					<tr>
						<th>동/층/호</th>
						<td><comment id="_NSID_"> <object id=EM_DONG
							classid=<%=Util.CLSID_EMEDIT%> width="50" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> 동 <comment
							id="_NSID_"> <object id=EM_FLOOR_FLAG
							classid=<%=Util.CLSID_EMEDIT%> width="50" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> 층 <comment
							id="_NSID_"> <object id=EM_HO
							classid=<%=Util.CLSID_EMEDIT%> width="50" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> 호</td>
						<th>월임대료(VAT포함)</th>
						<td><comment id="_NSID_"> <object id=EM_MM_RENTFEE
							classid=<%=Util.CLSID_EMEDIT%> width="195" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					--><tr>
						<th class="point">동/층/호</th>
						<td><comment id="_NSID_"> <object id=EM_DONG
							classid=<%=Util.CLSID_EMEDIT%> width="20" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> 동 <comment
							id="_NSID_"> <object id=EM_FLOOR_FLAG
							classid=<%=Util.CLSID_EMEDIT%> width="20" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> 층 <comment
							id="_NSID_"> <object id=EM_HO
							classid=<%=Util.CLSID_EMEDIT%> width="30" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> 호</td>
						<th>월임대료(VAT포함)</th>
						<td><comment id="_NSID_"> <object id=EM_MM_RENTFEE
							classid=<%=Util.CLSID_EMEDIT%> width="195" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>					
					<tr>
						<th>첨부파일</th>
						<td colspan="3" align="left"><comment id="_NSID_">
						<object id=EM_FILE_PATH classid=<%=Util.CLSID_EMEDIT%> width="230"
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/file_search.gif" id="IMG_FILE_SEARCH"
							onclick="javascript:openFile();" hspace="2" align="absmiddle" /><img
							id="IMG_FILE_DOWN" src="/<%=dir%>/imgs/btn/file_down.gif"
							onclick="javascript:saveAsFiles();" align="absmiddle" /><img
							id="IMG_FILE_DEL" style="vertical-align: middle;"
							onclick="javascript:deleteFile();"
							src="/<%=dir%>/imgs/btn/file_del.gif" /></td>
					</tr>
					<tr>
					    <th class="point">임대시설종류</th>
						<td colspan="3"><comment id="_NSID_"> <object id=LC_FCL_TYPE
							classid=<%= Util.CLSID_LUXECOMBO %> width="120" height=100 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<td class="sub_title" colspan=4><img
							src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
							align="absmiddle" class="PR03" /> 관리비부과 정보</td>
					</tr>					
					<tr>						
						<th class="point">관리비계산여부</th>
						<td><comment id="_NSID_"> <object id=LC_MNTN_CAL_YN
							classid=<%= Util.CLSID_LUXECOMBO %> width="120" height=100 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th class="point">관리비청구내역관리여부</th>
						<td><comment id="_NSID_"> <object id=LC_CHRG_YN
							classid=<%= Util.CLSID_LUXECOMBO %> width="200" height=100 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point">관리비연체계산여부</th>
						<td><comment id="_NSID_"> <object id=LC_ARR_CAL_YN
							classid=<%= Util.CLSID_LUXECOMBO %> width="120" height=100 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>관리비연체율(%)</th>
						<td ><comment id="_NSID_"> <object
							id=EM_ARR_RATE classid=<%=Util.CLSID_EMEDIT%> width="195"
							tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point">관리비납부기한일자</th>
						<td><comment id="_NSID_"> <object id=LC_PAY_TERM_TYPE
							classid=<%= Util.CLSID_LUXECOMBO %> width="60" height=100 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <comment
							id="_NSID_"> <object id=EM_PAY_TERM_DD
							classid=<%=Util.CLSID_EMEDIT%> width="45" tabindex=1> </object> </comment>
						<script> _ws_(_NSID_);</script> 일</td>                      
					</tr>
					<tr>
						<th class="point">임대료계산여부</th>
						<td><comment id="_NSID_"> <object id=LC_RENT_CAL_YN
							classid=<%= Util.CLSID_LUXECOMBO %> width="120" height=100 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point">임대료연체계산여부</th>
						<td><comment id="_NSID_"> <object id=LC_RENT_ARR_CAL_YN
							classid=<%= Util.CLSID_LUXECOMBO %> width="120" height=100 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>임대료연체율(%)</th>
						<td ><comment id="_NSID_"> <object
							id=EM_RENT_ARR_RATE classid=<%=Util.CLSID_EMEDIT%> width="195"
							tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point">임대료납부기한일자</th>
						<td colspan="3"><comment id="_NSID_"> <object id=LC_RENT_PAY_TERM_TYPE
							classid=<%= Util.CLSID_LUXECOMBO %> width="75" height=100 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <comment
							id="_NSID_"> <object id=EM_RENT_PAY_TERM_DD
							classid=<%=Util.CLSID_EMEDIT%> width="55" tabindex=1> </object> </comment>
						<script> _ws_(_NSID_);</script> 일</td>                        
					</tr>
				</table>
				</div>
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
       <c>Col=STR_CD              Ctrl=LC_FCL_FLAG            param=BindColVal</c>
       <c>Col=VEN_CD              Ctrl=EM_VEN_CD              param=Text</c>
       <c>Col=VEN_NM              Ctrl=EM_VEN_NM              param=Text</c>
       <c>Col=COMP_NO             Ctrl=EM_COMP_NO             param=Text</c>
       <c>Col=REP_NAME            Ctrl=EM_REP_NAME            param=Text</c>
       <c>Col=PHONE_NO            Ctrl=EM_PHONE_NO            param=Text</c>
       <c>Col=BELONG_STR_CD       Ctrl=LC_BELONG_STR_CD       param=BindColVal</c>
       <c>Col=CHAR_NAME           Ctrl=EM_CHAR_NAME           param=Text</c>
       <c>Col=PHONE1_NO           Ctrl=EM_PHONE1_NO           param=Text</c>
       <c>Col=PHONE2_NO           Ctrl=EM_PHONE2_NO           param=Text</c>
       <c>Col=PHONE3_NO           Ctrl=EM_PHONE3_NO           param=Text</c>
       <c>Col=CNTR_TYPE           Ctrl=LC_CNTR_TYPE           param=BindColVal</c>
       <c>Col=SAP_CNTR_ID         Ctrl=EM_SAP_CNTR_ID         param=Text</c>
       <c>Col=CNTR_S_DT           Ctrl=EM_CNTR_S_DT           param=Text</c>
       <c>Col=CNTR_E_DT           Ctrl=EM_CNTR_E_DT           param=Text</c>
       <c>Col=RENT_TYPE           Ctrl=LC_RENT_TYPE           param=BindColVal</c>
       <c>Col=RENT_FLAG           Ctrl=LC_RENT_FLAG           param=BindColVal</c>
       <c>Col=CNTR_AREA           Ctrl=EM_CNTR_AREA           param=Text</c>
       <c>Col=RENT_DEPOSIT        Ctrl=EM_RENT_DEPOSIT        param=Text</c>
       <c>Col=EXCL_AREA           Ctrl=EM_EXCL_AREA           param=Text</c>
       <c>Col=MM_RENTFEE_NOVAT    Ctrl=EM_MM_RENTFEE_NOVAT    param=Text</c>
       <c>Col=SHR_AREA            Ctrl=EM_SHR_AREA            param=Text</c>
       <c>Col=MM_RENTFEE_VAT      Ctrl=EM_MM_RENTFEE_VAT      param=Text</c>
       <c>Col=DONG                Ctrl=EM_DONG                param=Text</c>
       <c>Col=FLOOR_FLAG          Ctrl=EM_FLOOR_FLAG          param=Text</c>
       <c>Col=HO                  Ctrl=EM_HO                  param=Text</c>
       <c>Col=MM_RENTFEE          Ctrl=EM_MM_RENTFEE          param=Text</c>
       <c>Col=FILE_PATH           Ctrl=EM_FILE_PATH           param=Text</c>
       <c>Col=FCL_TYPE            Ctrl=LC_FCL_TYPE            param=BindColVal</c>
       <c>Col=PAY_TERM_TYPE       Ctrl=LC_PAY_TERM_TYPE       param=BindColVal</c>
       <c>Col=CHRG_YN             Ctrl=LC_CHRG_YN             param=BindColVal</c>
       <c>Col=PAY_TERM_DD         Ctrl=EM_PAY_TERM_DD         param=Text</c>
       <c>Col=ARR_CAL_YN          Ctrl=LC_ARR_CAL_YN          param=BindColVal</c>
       <c>Col=ARR_RATE            Ctrl=EM_ARR_RATE            param=Text</c>       
       <c>Col=RENT_PAY_TERM_TYPE  Ctrl=LC_RENT_PAY_TERM_TYPE  param=BindColVal</c>
       <c>Col=RENT_PAY_TERM_DD    Ctrl=EM_RENT_PAY_TERM_DD    param=Text</c>
       <c>Col=RENT_CAL_YN         Ctrl=LC_RENT_CAL_YN         param=BindColVal</c>
       <c>Col=RENT_ARR_CAL_YN     Ctrl=LC_RENT_ARR_CAL_YN     param=BindColVal</c>
       <c>Col=RENT_ARR_RATE       Ctrl=EM_RENT_ARR_RATE       param=Text</c>
       <c>Col=MNTN_CAL_YN         Ctrl=LC_MNTN_CAL_YN         param=BindColVal</c>     
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
