<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 계약해지관리 > 계약해지등록
 * 작 성 일 : 2010.01.14
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : MREN5010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 관리비 입금관리
 * 이    력 : 2010.01.14(박래형) 신규작성
 *         2010.05.18(김유완) 수정작성
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
var g_saveFlag      = true;
var g_currKey       = "S";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.18
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 145;		//해당화면의 동적그리드top위치
 var top2 =440;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";

    //Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_CNTRMST"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_MR_CALBAL"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER,DS_IO_DETAIL");
    
    gridCreate("MST"); //마스터
    gridCreate("DTL"); //관리비항목별 내역
 
    // Object 초기화
    initComboStyle(LC_S_FCL_FLAG,DS_LC_FCL_FLAG,    "CODE^0^30,NAME^0^80", 1,   PK);        // [조회용]시설구분(점코드) 
    initEmEdit(EM_S_VEN_CD,                         "NUMBER3^6^0",              NORMAL);    // [조회용]협력사
    initEmEdit(EM_S_VEN_NM,                         "GEN",                      READ);      // [조회용]협력사명
    initComboStyle(LC_S_CNTR_TYPE,  DS_CNTR_TYPE,   "CODE^0^30,NAME^0^80", 1,   NORMAL);    // [조회용]계약유형
    initComboStyle(LC_S_RENT_TYPE,  DS_RENT_TYPE,   "CODE^0^30,NAME^0^80", 1,   NORMAL);    // [조회용]임대형태
    DS_RENT_TYPE.Filter();                                                                  // [조회용]임대형태 필터링
    DS_RENT_TYPE.SortExpr = "+" + "CODE";
    DS_RENT_TYPE.Sort();
    initComboStyle(LC_S_RENT_FLAG,  DS_RENT_FLAG,   "CODE^0^30,NAME^0^80", 1,   NORMAL);    // [조회용]임대구분
    initComboStyle(LC_S_CLOSE_FLAG, DS_S_CLOSE_FLAG,"CODE^0^30,NAME^0^80", 1,   NORMAL);    // [조회용]해지사유
    initEmEdit(EM_S_DT,                             "YYYYMMDD",                 READ);      // [조회용]기간S
    initEmEdit(EM_E_DT,                             "YYYYMMDD",                 READ);      // [조회용]기간E
    
    initEmEdit(EM_VEN_CD,                           "NUMBER3^6^0",              READ);      // 협력사
    initEmEdit(EM_VEN_NM,                           "GEN",                      READ);      // 협력사명
    initEmEdit(EM_REP_NAME,                         "GEN",                      READ);      // 대표자
    initEmEdit(EM_COMP_NO,                          "000-00-00000",             READ);      // 사업자번호
    initComboStyle(LC_CNTR_TYPE,DS_CNTR_TYPE,       "CODE^0^30,NAME^0^100", 1,  READ);      // 계약유형
    initEmEdit(EM_RENT_DEPOSIT,                     "NUMBER^12^0",              READ);      // 임대보증금
    initEmEdit(EM_PAY_DT,                           "YYYYMMDD",                 READ);      // 임대보증금입금일
    initComboStyle(LC_RENT_TYPE,DS_RENT_TYPE,       "CODE^0^30,NAME^0^100", 1,  READ);      // 임대형태
    initComboStyle(LC_RENT_FLAG,DS_RENT_FLAG,       "CODE^0^30,NAME^0^100", 1,  READ);      // 임대구분
    initEmEdit(EM_CNTR_S_DT,                        "YYYYMMDD",                 READ);      // 계약기간 
    initEmEdit(EM_CNTR_E_DT,                        "YYYYMMDD",                 READ);      // 계약기간 
    
    initEmEdit(EM_CNTR_CAN_DT,                      "YYYYMMDD",                 PK);        // 해지일 
    initComboStyle(LC_CNTR_CAN_REAS_CD,DS_CLOSE_FLAG,"CODE^0^30,NAME^0^100", 1, PK);        // 해지사유
    initEmEdit(EM_ADD_DED_AMT,                      "NUMBER^12^0",              NORMAL);    // 추가공제금액
    initEmEdit(EM_RTRN_AMT,                         "NUMBER^12^0",              READ);      // 반환보증금
    initEmEdit(EM_ADD_DED_REASON,                   "GEN^200",                  NORMAL);    // 추가공제사유
    
    getFlc("DS_LC_FCL_FLAG",        "M", "1", "Y", "N");                    // [조회용]시설구분(점코드) 
    LC_S_FCL_FLAG.index = 0;                   
    LC_S_FCL_FLAG.Focus();          
    getEtcCode("DS_CNTR_TYPE",      "D", "M042", "Y", "N", LC_S_CNTR_TYPE); // [조회용]계약유형 
    getEtcCode("DS_RENT_TYPE",      "D", "P003", "Y", "N", LC_S_RENT_TYPE); // [조회용]임대형태      
    getEtcCode("DS_RENT_FLAG",      "D", "P084", "Y", "N", LC_S_RENT_FLAG); // [조회용]임대구분      
    getEtcCode("DS_S_CLOSE_FLAG",   "D", "M043", "Y", "N", LC_S_CLOSE_FLAG);// [조회용]해지사유      
    getEtcCode("DS_CLOSE_FLAG",     "D", "M043", "N");                      // 해지사유      
    getEtcCode("DS_MOD_REASON",     "D", "M098", "N");                      // 조정사유     
    
    //초기화
    enableControl(IMG_S_DT,false); // 조회기간 비활성화(팝업)
    enableControl(IMG_E_DT,false); // 조회기간 비활성화(팝업)
}

/**
 * gridCreate("대상그리드")
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.18
 * 개    요 : 그리드SET
 * return값 : void
 */
function gridCreate(grdGBN) {
    if (grdGBN == "MST") {
        var hdrProperies = ''
            + '<FC>ID={CURROW}      NAME=NO'         
            + '                                     WIDTH=30    ALIGN=CENTER</FC>'
            + '<FC>ID=VEN_CD        NAME=협력사코드'            
            + '                                     WIDTH=80    ALIGN=CENTER</FC>'
            + '<FC>ID=VEN_NM        NAME=협력사명'        
            + '                                     WIDTH=140   ALIGN=LEFT</FC>'
            ;
            initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
    } else {
        var hdrProperies = ''
            + '<FC>ID={CURROW}          NAME=NO'         
            + '                                         WIDTH=30    ALIGN=CENTER</FC>'
            + '<FC>ID=CAL_YM            NAME=부과년월'            
            + '                                         WIDTH=100    ALIGN=CENTER MASK="XXXX/XX"</FC>'
            + '<FC>ID=ARR_DD            NAME=연체일수'            
            + '                                         WIDTH=65    ALIGN=CENTER  SHOW=false</FC>'
            + '<FC>ID=REAL_CHAREG_AMT   NAME=총부과액'        
            + '                                         WIDTH=120    ALIGN=RIGHT</FC>'
            + '<FC>ID=PAY_AMT           NAME=입금액'        
            + '                                         WIDTH=100    ALIGN=RIGHT</FC>'
            + '<FC>ID=ARR_RATE          NAME=연체율'        
            + '                                         WIDTH=100    ALIGN=RIGHT</FC>'
            + '<FC>ID=ARR_AMT           NAME=연체액'        
            + '                                         WIDTH=90    ALIGN=RIGHT  SHOW=false</FC>'
            ;
            initGridStyle(GD_DETAIL, "COMMON", hdrProperies, false);
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
 * 작 성 일 : 2010.05.18
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if (DS_IO_MASTER.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
            // parameters
            var strStrCd    = LC_S_FCL_FLAG.BindColVal;     // [조회용]시설구분(점코드)
            var strVenCd    = EM_S_VEN_CD.Text;             // [조회용]협력사
            var strCntrType = LC_S_CNTR_TYPE.BindColVal;    // [조회용]계약유형
            var strRentType = LC_S_RENT_TYPE.BindColVal;    // [조회용]임대형태
            var strRentFlag = LC_S_RENT_FLAG.BindColVal;    // [조회용]임대구분
            var strCloseFlag= LC_S_CLOSE_FLAG.BindColVal;   // [조회용]해지사유
            var strSGbn     = LC_S_SGBN.BindColVal;         // [조회용]조회기간구분
            var strSDT      = EM_S_DT.Text;                 // [조회용]기간S
            var strEDT      = EM_E_DT.Text;                 // [조회용]기간E
            
            var goTo = "getMaster";
            var parameters = ""
                + "&strStrCd="      + encodeURIComponent(strStrCd)
                + "&strVenCd="      + encodeURIComponent(strVenCd)
                + "&strCntrType="   + encodeURIComponent(strCntrType)
                + "&strRentType="   + encodeURIComponent(strRentType)
                + "&strRentFlag="   + encodeURIComponent(strRentFlag)
                + "&strCloseFlag="  + encodeURIComponent(strCloseFlag)
                + "&strSGbn="       + encodeURIComponent(strSGbn)
                + "&strSDT="        + encodeURIComponent(strSDT)
                + "&strEDT="        + encodeURIComponent(strEDT);
            TR_MAIN.Action = "/mss/mren501.mr?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
            TR_MAIN.Post();
            // 조회결과 Return
            setPorcCount("SELECT", GD_MASTER);
        } else {
            return;
        }
    }  else {
    	// parameters
        var strStrCd    = LC_S_FCL_FLAG.BindColVal;     // [조회용]시설구분(점코드)
        var strVenCd    = EM_S_VEN_CD.Text;             // [조회용]협력사
        var strCntrType = LC_S_CNTR_TYPE.BindColVal;    // [조회용]계약유형
        var strRentType = LC_S_RENT_TYPE.BindColVal;    // [조회용]임대형태
        var strRentFlag = LC_S_RENT_FLAG.BindColVal;    // [조회용]임대구분
        var strCloseFlag= LC_S_CLOSE_FLAG.BindColVal;   // [조회용]해지사유
        var strSGbn     = LC_S_SGBN.BindColVal;         // [조회용]조회기간구분
        var strSDT      = EM_S_DT.Text;                 // [조회용]기간S
        var strEDT      = EM_E_DT.Text;                 // [조회용]기간E
        
        var goTo = "getMaster";
        var parameters = ""
            + "&strStrCd="      + encodeURIComponent(strStrCd)
            + "&strVenCd="      + encodeURIComponent(strVenCd)
            + "&strCntrType="   + encodeURIComponent(strCntrType)
            + "&strRentType="   + encodeURIComponent(strRentType)
            + "&strRentFlag="   + encodeURIComponent(strRentFlag)
            + "&strCloseFlag="  + encodeURIComponent(strCloseFlag)
            + "&strSGbn="       + encodeURIComponent(strSGbn)
            + "&strSDT="        + encodeURIComponent(strSDT)
            + "&strEDT="        + encodeURIComponent(strEDT);
        TR_MAIN.Action = "/mss/mren501.mr?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();
        // 조회결과 Return
        setPorcCount("SELECT", GD_MASTER);
    }
    
    if (DS_IO_MASTER.CountRow < 1) {
        DS_IO_DETAIL.ClearData();
    } else {
        if (arguments[0] == undefined || arguments[0] == "S") {
            g_currKey = "S";
        } else {
            var strCurrKeyRow = getNameValueRow(DS_IO_MASTER, "CNTR_ID",g_currKey);
            if (strCurrKeyRow == 0 ) {
                DS_IO_MASTER.RowPosition = 1;
            } else {
                DS_IO_MASTER.RowPosition = strCurrKeyRow;
            }
        }
    } 
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.18
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    //저장 시  CanRowPosChange 이벤트 우회 flag
    if (DS_IO_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장
        //필수 입력값 체크
        if (!checkValidateSave())  return;
        
        //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_MASTER.Focus();
            return;
        }   
        //key저장후 재조회 용
        g_currKey = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_ID");
        var goTo = "save";
        TR_SAVE.Action = "/mss/mren501.mr?goTo=" + goTo;
        TR_SAVE.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
        g_saveFlag = false;
        TR_SAVE.Post();
	    g_saveFlag = true;
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
    } 
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * getDetail()
 * 작 성 자 : 
 * 작 성 일 : 2010.05.18
 * 개    요 : 관리비항목별 내역 조회(상세)
 * return값 : void
 */
function getDetail(row) {
    var strCalYM    = DS_IO_MASTER.NameValue(row, "CAL_YM");     // 부과년월
    var strCntrId   = DS_IO_MASTER.NameValue(row, "CNTR_ID");    // 계약ID
    
    var goTo = "getDetail";
    var parameters = ""
        + "&strCntrId="     + encodeURIComponent(strCntrId);
    TR_MAIN2.Action = "/mss/mren501.mr?goTo=" + goTo + parameters;
    TR_MAIN2.KeyValue = "SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)";
    TR_MAIN2.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_DETAIL.CountRow);
}

/**
 * checkValidateSave()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.18
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidateSave() {
	//해지일(필수)
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_CAN_DT").length == 8) {
	    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_CAN_DT") > getTodayDB("DS_O_RESULT")) {
	        showMessage(INFORMATION, OK, "USER-1000", "해지일은 당일 이전으로만 등록가능합니다.");
	        EM_CNTR_CAN_DT.Focus();
	        return false;
	    }
	}  else {
        showMessage(INFORMATION, OK, "USER-1003", "해지일");
        EM_CNTR_CAN_DT.Focus();
        return false;
	}

	//해지사유(필수)
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CNTR_CAN_REAS_CD") == "") {
        showMessage(INFORMATION, OK, "USER-1002", "해지사유");
    	LC_CNTR_CAN_REAS_CD.Focus();
        return false;
    }  
	
    //추가공제사유
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ADD_DED_REASON").length > 0) {
        var tmpLenE = checkLenByte(DS_IO_MASTER, DS_IO_MASTER.RowPosition, "ADD_DED_REASON")
        if (tmpLenE > 200 ) {
            showMessage(STOPSIGN, OK, "USER-1048", "추가공제사유는 200[한글100/영문,숫자200자]");
            EM_ADD_DED_REASON.Focus();
            return false;
        }
    }

    return true;
}

/**
 * callPopup()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.18
 * 개    요 : 팝업 호출
 * return값 :
 */
function callPopup(popupNm) {
    if (popupNm == "sVen") { //[조회용]협력사
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
 * objectControl()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.18
 * 개    요 : 입력 활성/비활성화(상단)
 * return값 :
 */
function objectControl(objBoolean) {
    if (objBoolean) {
    	EM_CNTR_CAN_DT.Enable      = true;
    	LC_CNTR_CAN_REAS_CD.Enable = true;
    	EM_ADD_DED_AMT.Enable      = true;
    	EM_ADD_DED_REASON.Enable   = true;
        //이미지
        enableControl(IMG_CNTR_CAN_DT,true);
    } else {
        EM_CNTR_CAN_DT.Enable      = false;
        LC_CNTR_CAN_REAS_CD.Enable = false;
        EM_ADD_DED_AMT.Enable      = false;
        EM_ADD_DED_REASON.Enable   = false;
        //이미지
        enableControl(IMG_CNTR_CAN_DT,false);
    }
}

/**
 * checkLenByte()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.18
 * 개    요 : 문자열 Byte체크
 * return값 :
 */
function checkLenByte(objDateSet, row, colid) {
    //byte체크
    var intByte = 0;
    var strTemp = objDateSet.NameValue(row, colid);
    for (k = 0; k < strTemp.length; k++) {
        var onechar = strTemp.charAt(k);
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
	var strStrCd    = LC_S_FCL_FLAG.BindColVal;     // [조회용]시설구분(점코드)
	var strVenCd    = EM_S_VEN_CD.Text;             // [조회용]협력사
	var strCntrType = LC_S_CNTR_TYPE.BindColVal;    // [조회용]계약유형
	var strRentType = LC_S_RENT_TYPE.BindColVal;    // [조회용]임대형태
	var strRentFlag = LC_S_RENT_FLAG.BindColVal;    // [조회용]임대구분
	var strCloseFlag= LC_S_CLOSE_FLAG.BindColVal;   // [조회용]해지사유
	var strSGbn     = LC_S_SGBN.BindColVal;         // [조회용]조회기간구분
	var strSDT      = EM_S_DT.Text;                 // [조회용]기간S
	var strEDT      = EM_E_DT.Text;                 // [조회용]기간E
	
	var goTo = "getMaster";
	var parameters = ""
	    + "&strStrCd="      + encodeURIComponent(strStrCd)
	    + "&strVenCd="      + encodeURIComponent(strVenCd)
	    + "&strCntrType="   + encodeURIComponent(strCntrType)
	    + "&strRentType="   + encodeURIComponent(strRentType)
	    + "&strRentFlag="   + encodeURIComponent(strRentFlag)
	    + "&strCloseFlag="  + encodeURIComponent(strCloseFlag)
	    + "&strSGbn="       + encodeURIComponent(strSGbn)
	    + "&strSDT="        + encodeURIComponent(strSDT)
	    + "&strEDT="        + encodeURIComponent(strEDT);
	TR_MAIN.Action = "/mss/mren501.mr?goTo=" + goTo + parameters;
	TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
	TR_MAIN.Post();
    
    var strCurrKeyRow = getNameValueRow(DS_IO_MASTER, "CNTR_ID",g_currKey);
    if (strCurrKeyRow == 0 ) {
        DS_IO_MASTER.RowPosition = 1;
    } else {
        DS_IO_MASTER.RowPosition = strCurrKeyRow;
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

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
//화면
if (row > 0) {
    getDetail(row);
    //임대계약이 해지일시 임대계약해지정보 등록/수정불가
    if (DS_IO_MASTER.NameValue(row, "CNTR_TYPE") == "04") {
	    objectControl(false);
    } else {
	    objectControl(true);
    }
} else {
    DS_IO_DETAIL.ClearData();
}
</script>

<script language=JavaScript for=DS_IO_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return;
</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
if (g_saveFlag) {
    if (DS_IO_MASTER.CountRow > 0) {
        if (DS_IO_MASTER.IsUpdated) { //데이터 변경시
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

<script language=JavaScript for=EM_ADD_DED_AMT event=OnKeyUp(kcode,scode)>
//조정금액 변경시
    var strModAmt = EM_ADD_DED_AMT.Text;
    var strchargAmt = eval(DS_IO_MASTER.OrgNameValue(DS_IO_MASTER.RowPosition,"RTRN_AMT"));
    if (strchargAmt == "") strchargAmt = 0;
    EM_RTRN_AMT.Text = eval(strchargAmt) - (strModAmt);
</script>

<script language=JavaScript for=EM_ADD_DED_AMT event=OnKillFocus()>
    var strModAmt = EM_ADD_DED_AMT.Text.replace("-","");
    if (strModAmt == "" || strModAmt == "0" ) {
        EM_ADD_DED_AMT.Text = "0";
    }
</script>

<script language=JavaScript for=DS_RENT_TYPE event=OnFilter(row)>
// [조회용]임대형태
if (DS_RENT_TYPE.NameValue(row,"CODE") == "%" || DS_RENT_TYPE.NameValue(row,"CODE") == "3" || DS_RENT_TYPE.NameValue(row,"CODE") == "4") { //임대갑, 임대을만
    return true;
} else { 
    return false;
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

<script language=JavaScript for=LC_S_SGBN event=OnSelChange()>
//조회조건초기화
if (LC_S_SGBN.BindColVal == "%") {
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
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_LC_FCL_FLAG"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_RENT_TYPE"      classid=<%=Util.CLSID_DATASET%>><param name=UseFilter value=true></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_RENT_FLAG"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CNTR_TYPE"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSE_FLAG"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_S_CLOSE_FLAG"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PAY_FLAG"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_MOD_REASON"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<!-- =============== 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
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
    var obj   = document.getElementById("GD_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top2+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
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
                        <th width="90">계약유형</th>
                        <td><comment id="_NSID_"> <object id=LC_S_CNTR_TYPE
                            classid=<%=Util.CLSID_LUXECOMBO%> width="170" tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
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
                        <th>해지사유</th>
                        <td><comment id="_NSID_"> <object id=LC_S_CLOSE_FLAG
                            classid=<%=Util.CLSID_LUXECOMBO%> width="170" tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th>조회기간구분</th>
                        <td><comment id="_NSID_"> <object id=LC_S_SGBN
                            classid=<%=Util.CLSID_LUXECOMBO%> width="120"  
                            tabindex=1 align="absmiddle">
                            <param name=CBData value="%^전체,1^계약시작일,2^계약종료일,3^계약해지일">
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
                <td width="300">
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"><OBJECT id=GD_MASTER
                            width=100% height=735 tabindex=1 classid=<%=Util.CLSID_GRID%>>
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
                                    align="absmiddle" /> 임대계약정보</td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="PT01 PB03">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0"
                            class="s_table">
	                        <tr>
		                        <th width="70">협력사</th>
		                        <td width="190"><comment id="_NSID_"> <object id=EM_VEN_CD
		                            classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1
		                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <comment id="_NSID_"> <object
		                            id=EM_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=117
		                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                                <th width="70">대표자</th>
	                            <td><comment id="_NSID_"> <object
	                                id=EM_REP_NAME classid=<%=Util.CLSID_EMEDIT%> width="135"
	                                tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
	                            </td>
                            </tr>
	                        <tr>
		                        <th>사업자번호</th>
		                        <td><comment id="_NSID_"> <object id=EM_COMP_NO
		                            classid=<%=Util.CLSID_EMEDIT%> width=180 tabindex=1
		                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                                <th>계약유형</th>
	                            <td><comment id="_NSID_"> <object
	                                id=LC_CNTR_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width="140"
	                                tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
	                            </td>
                            </tr>
	                        <tr>
		                        <th>임대보증금</th>
		                        <td><comment id="_NSID_"> <object id=EM_RENT_DEPOSIT
		                            classid=<%=Util.CLSID_EMEDIT%> width=180 tabindex=1
		                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                                <th>임대보증금<br>입금일</th>
	                            <td><comment id="_NSID_"> <object
	                                id=EM_PAY_DT classid=<%=Util.CLSID_EMEDIT%> width="135"
	                                tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
	                            </td>
                            </tr>
                            <tr>
                                <th>임대형태</th>
                                <td><comment id="_NSID_"> <object id=LC_RENT_TYPE
                                    classid=<%=Util.CLSID_LUXECOMBO%> width=185 tabindex=1
                                    align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                                <th>임대구분</th>
                                <td><comment id="_NSID_"> <object
                                    id=LC_RENT_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width="140"
                                    tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th>계약기간</th>
                                <td colspan="3"><comment id="_NSID_"> <object id=EM_CNTR_S_DT
                                    classid=<%=Util.CLSID_EMEDIT%> width=83 tabindex=1
                                    align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> ~ <comment id="_NSID_"> <object
                                    id=EM_CNTR_E_DT classid=<%=Util.CLSID_EMEDIT%> width=83
                                    align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="PT10">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="sub_title"><img
                                    src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                                    align="absmiddle" /> 임대계약해지 정보</td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="PT01 PB03">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0"
                            class="s_table">
							<tr>
								<th width="70" class="point">해지일</th>
								<td width="190"><comment id="_NSID_"> <object
									id=EM_CNTR_CAN_DT classid=<%=Util.CLSID_EMEDIT%> width=160
									onblur="javascript:checkDateTypeYMD(this);"
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								<img id=IMG_CNTR_CAN_DT src="/<%=dir%>/imgs/btn/date.gif"
									align="absmiddle" onclick="javascript:openCal('G',EM_CNTR_CAN_DT)" /></td>
								<th width="70" class="point">해지사유</th>
								<td><comment id="_NSID_"> <object
									id=LC_CNTR_CAN_REAS_CD classid=<%=Util.CLSID_LUXECOMBO%>
									width="140" tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
                                <th>추가공제금액</th>
                                <td><comment id="_NSID_"> <object id=EM_ADD_DED_AMT
                                    classid=<%=Util.CLSID_EMEDIT%> width=180 tabindex=1
                                    align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                                <th>반환보증금</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_RTRN_AMT classid=<%=Util.CLSID_EMEDIT%> width="135"
                                    tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th>추가공제사유</th>
                                <td colspan="3"><comment id="_NSID_"> <object id=EM_ADD_DED_REASON
                                    classid=<%=Util.CLSID_EMEDIT%> width=415 tabindex=1
                                    align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
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
                                    align="absmiddle" /> 관리비 미수금 정보</td>
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
                                    width=100% height=440 tabindex=1 classid=<%=Util.CLSID_GRID%>>
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
<object id=BD_IO_MASTER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_IO_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
       <c>Col=VEN_CD             Ctrl=EM_VEN_CD              param=Text</c>
       <c>Col=VEN_NM             Ctrl=EM_VEN_NM              param=Text</c>
       <c>Col=REP_NAME           Ctrl=EM_REP_NAME            param=Text</c>
       <c>Col=COMP_NO            Ctrl=EM_COMP_NO             param=Text</c>
       <c>Col=CNTR_TYPE          Ctrl=LC_CNTR_TYPE           param=BindColVal</c>
       <c>Col=RENT_DEPOSIT       Ctrl=EM_RENT_DEPOSIT        param=Text</c>
       <c>Col=PAY_DT             Ctrl=EM_PAY_DT              param=Text</c>
       <c>Col=RENT_TYPE          Ctrl=LC_RENT_TYPE           param=BindColVal</c>
       <c>Col=RENT_FLAG          Ctrl=LC_RENT_FLAG           param=BindColVal</c>
       <c>Col=CNTR_S_DT          Ctrl=EM_CNTR_S_DT           param=Text</c>
       <c>Col=CNTR_E_DT          Ctrl=EM_CNTR_E_DT           param=Text</c>
       <c>Col=CNTR_CAN_DT        Ctrl=EM_CNTR_CAN_DT         param=Text</c>
       <c>Col=CNTR_CAN_REAS_CD   Ctrl=LC_CNTR_CAN_REAS_CD    param=BindColVal</c>
       <c>Col=ADD_DED_AMT        Ctrl=EM_ADD_DED_AMT         param=Text</c>
       <c>Col=RTRN_AMT           Ctrl=EM_RTRN_AMT            param=Text</c>
       <c>Col=ADD_DED_REASON     Ctrl=EM_ADD_DED_REASON      param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
