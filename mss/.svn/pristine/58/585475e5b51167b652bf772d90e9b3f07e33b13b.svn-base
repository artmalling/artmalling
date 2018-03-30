<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 시설구분별관리기준
 * 작 성 일 : 2010.01.14
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : MREN1010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 시설구분별관리기준
 * 이    력 : 2010.01.14(박래형) 신규작성
           2010.03.15 (김유완) 수정개발
           2011.08.01 FKSS 수정개발
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"          prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"       prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"           prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"        prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
<!--*************************************************************************-->
<loginChk:islogin />
<%
    //session 정보
    SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
    String sess_pgm_id = sessionInfo.getPGM_ID();
    //MREN101
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
var g_RowStatus = 0;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_FCLMST"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER");   
    // EM 초기화
    initEmEdit(EM_AREA,             "NUMBER^9^2"    ,PK);       // 시설전체면적
    initEmEdit(EM_EXCL_AREA,        "NUMBER^9^2"    ,PK);       // 시설전용면적
    initEmEdit(EM_ORG_CD,           "NUMBER3^10^0"  ,PK);       // 담당부서(조직코드)
    initEmEdit(EM_ORG_NM,           "GEN"           ,READ);     // 담당부서(조직명)
    initEmEdit(EM_SHR_AREA,         "NUMBER^9^2"    ,PK);       // 시설공유면적
   // initEmEdit(EM_PAY_TERM_DD,      "NUMBER^2^2"    ,NORMAL);   // 관리비납부기한일자
    //initEmEdit(EM_ARR_RATE,         "NUMBER^3^2"    ,NORMAL);   // 연체율
    //initEmEdit(EM_OFFICE_PAY_AMT,   "NUMBER^12^0"   ,NORMAL);   // 오피스평당관리비
    // COMBO 초기화
    initComboStyle(LC_S_FCL_FLAG,DS_LC_FCL_FLAG,    "CODE^0^30,NAME^0^80", 1, PK);      // [조회용]시설구분(점코드) 
    initComboStyle(LC_FCL_FLAG,DS_LC_FCL_FLAG,      "CODE^0^30,NAME^0^80", 1, PK);      // 시설구분
    initComboStyle(LC_HUSE_FLAG,DS_LC_HUSE_FLAG,    "CODE^0^30,NAME^0^80", 1, PK);      // 주거구분
    initComboStyle(LC_AREA_FLAG,DS_LC_AREA_FLAG,    "CODE^0^30,NAME^0^80", 1, PK);      // 지역
    initComboStyle(LC_USE_YN,DS_LC_USE_YN,          "CODE^0^30,NAME^0^80", 1, NORMAL);  // 사용여부
   /* initComboStyle(LC_PAY_TERM_TYPE,DS_LC_PAY_TERM_TYPE,"CODE^0^30,NAME^0^80", 1, NORMAL); // 관리비납부기한일자
    initComboStyle(LC_MNTN_CAL_YN,DS_LC_USE_YN,     "CODE^0^30,NAME^0^80", 1, PK);      // 관리비계산여부
    initComboStyle(LC_CHRG_YN,DS_LC_USE_YN,         "CODE^0^30,NAME^0^80", 1, PK);      // 관리비청구내역관리여부
    initComboStyle(LC_ARR_CAL_YN,DS_LC_USE_YN,      "CODE^0^30,NAME^0^80", 1, PK);      // 관리비연체계산여부 */
    initComboStyle(LC_PWR_CAL_YN,DS_LC_USE_YN,      "CODE^0^30,NAME^0^80", 1, NORMAL);  // 전기요금
    initComboStyle(LC_WARMWTR_CAL_YN,DS_LC_USE_YN,  "CODE^0^30,NAME^0^80", 1, NORMAL);  // 온수여부
    initComboStyle(LC_STEAM_CAL_YN,DS_LC_USE_YN,    "CODE^0^30,NAME^0^80", 1, NORMAL);  // 증기요금
    initComboStyle(LC_COLDWTR_CAL_YN,DS_LC_USE_YN,  "CODE^0^30,NAME^0^80", 1, NORMAL);  // 냉수요금
    initComboStyle(LC_WTRWORKS_CAL_YN,DS_LC_USE_YN, "CODE^0^30,NAME^0^80", 1, NORMAL);  // 수도요금
    initComboStyle(LC_GRAYWTR_CAL_YN,DS_LC_USE_YN,  "CODE^0^30,NAME^0^80", 1, NORMAL);  // 중수요금
    initComboStyle(LC_GAS_CAL_YN,DS_LC_USE_YN,      "CODE^0^30,NAME^0^80", 1, NORMAL);  // 가스요금
    initComboStyle(LC_PUB_DIV_RATE, DS_PUB_DIV_RATE,"CODE^0^30,NAME^0^80", 1, NORMAL);  // 공용안분율
    //시스템 코드 공통코드에서 가지고 오기
    getFlc("DS_LC_FCL_FLAG", "C", "1", "Y", "N", "1");      // [조회용]시설구분(비주거) 
    LC_S_FCL_FLAG.index = "0";                   
    LC_S_FCL_FLAG.Focus();                   
    LC_FCL_FLAG.Enable      = false;
    LC_HUSE_FLAG.Enable     = false;
    getEtcCode("DS_LC_HUSE_FLAG",       "D", "M079", "N");  // 주거구분      
    getEtcCode("DS_LC_AREA_FLAG",       "D", "M080", "N");  // 지역      
   // getEtcCode("DS_LC_PAY_TERM_TYPE",   "D", "M044", "N");  // 관리비납부기한일자      
    getEtcCode("DS_LC_USE_YN",          "D", "D022", "N");  // 사용여부      
    getEtcCode("DS_PUB_DIV_RATE",       "D", "M041", "N");  // 공용안분율      
    
    objectControl(false);
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
 * 작 성 일 : 2010.03.15
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
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
            var strFlcFlag  = LC_S_FCL_FLAG.BindColVal;   // [조회용]시설구분(점코드)
            var strSelGbn   = "S";                        // [조회용]조회구분값(신규등록시 시설구분 변경 저리)
            var goTo = "getMaster";
            var parameters = ""
                + "&strFlcFlag="    + encodeURIComponent(strFlcFlag)
                + "&strSelGbn="     + encodeURIComponent(strSelGbn);
            TR_MAIN.Action = "/mss/mren101.mr?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
            TR_MAIN.Post();
        
            if (DS_IO_MASTER.CountRow < 1)  {
                LC_FCL_FLAG.BindColVal = "";
                objectControl(false);
                showMessage(STOPSIGN, OK, "USER-1000", "조회 된 내역이 없습니다.");
            } 
            LC_FCL_FLAG.Enable      = false;
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
        var strFlcFlag  = LC_S_FCL_FLAG.BindColVal;   // [조회용]시설구분(점코드)
        var strSelGbn   = "S";                        // [조회용]조회구분값(신규등록시 시설구분 변경 저리 S:단순조회, N:신규등록시)
        var goTo = "getMaster";
        var parameters = ""
            + "&strFlcFlag="    + encodeURIComponent(strFlcFlag)
            + "&strSelGbn="     + encodeURIComponent(strSelGbn);
        TR_MAIN.Action = "/mss/mren101.mr?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();
    
        if (DS_IO_MASTER.CountRow < 1)  {
            LC_FCL_FLAG.BindColVal = "";
            objectControl(false);
            showMessage(STOPSIGN, OK, "USER-1000", "조회 된 내역이 없습니다.");
        } 
        LC_FCL_FLAG.Enable      = false;
    }
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	if (DS_IO_MASTER.IsUpdated) {//변경데이터 있을 시 확인
	    var ret = showMessage(Question, YesNo, "USER-1050");
	    if (ret == "1") {
			DS_IO_MASTER.ClearData();
			DS_IO_MASTER.AddRow();
			//입력폼 활성화
			objectControl(true);
			LC_FCL_FLAG.Enable      = true;
	    } else {
	    	return;
	    }
	} else {
        DS_IO_MASTER.ClearData();
        DS_IO_MASTER.AddRow();
        //입력폼 활성화
        objectControl(true);
        LC_FCL_FLAG.Enable      = true;
	}
	
	LC_FCL_FLAG.Focus();
    //전역변수(데이터 변경상태) 초기화
    g_RowStatus = 0;
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (DS_IO_MASTER.NameValue(1, "INSGB") == "Y") {
        if (DS_IO_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장
            //필수 입력값 체크
            if (!checkValidate()) return;
        

            //변경또는 신규 내용을 저장하시겠습니까?
              if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
              //    GD_MASTER.Focus();
                  return;
              }
            
            //저장
            var goTo = "save";
            TR_SAVE.Action = "/mss/mren101.mr?goTo=" + goTo;
            TR_SAVE.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
            TR_SAVE.Post();
        } else {
            showMessage(INFORMATION, OK, "USER-1028");
            return;
        } 
    } else {
        //필수 입력값 체크
        if (!checkValidate()) return;
        

        //변경또는 신규 내용을 저장하시겠습니까?
          if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            //  GD_MASTER.Focus();
              return;
          }
        
        //저장
        var goTo = "save";
        TR_SAVE.Action = "/mss/mren101.mr?goTo=" + goTo;
        TR_SAVE.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
        TR_SAVE.Post();
    }
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * checkValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.01.24
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidate() {

	if (DS_IO_MASTER.NameValue(1, "STR_CD")=="") {
        LC_FCL_FLAG.Focus();
        showMessage(INFORMATION, OK, "USER-1002", "시설구분");
        return false;
    /*} else if (DS_IO_MASTER.NameValue(1, "HUSE_FLAG")== "") {
    	LC_HUSE_FLAG.Focus();
        showMessage(INFORMATION, OK, "USER-1002", "주거구분");
        return false;*/
    } else if (DS_IO_MASTER.NameValue(1, "AREA")== "") {
    	EM_AREA.Focus();
        showMessage(INFORMATION, OK, "USER-1002", "시설전체면적");
        return false;
    } else if (DS_IO_MASTER.NameValue(1, "AREA_FLAG")== "") {
    	LC_AREA_FLAG.Focus();
        showMessage(INFORMATION, OK, "USER-1002", "지역");
        return false;
    } else if (DS_IO_MASTER.NameValue(1, "EXCL_AREA")== "") {
    	EM_EXCL_AREA.Focus();
        showMessage(INFORMATION, OK, "USER-1002", "시설전용면적");
        return false;
    } else if (DS_IO_MASTER.NameValue(1, "ORG_CD")== "") {
    	EM_ORG_CD.Focus();
        showMessage(INFORMATION, OK, "USER-1002", "담당부서");
        return false;
    } else if (DS_IO_MASTER.NameValue(1, "SHR_AREA")== "") {
    	EM_SHR_AREA.Focus();
        showMessage(INFORMATION, OK, "USER-1002", "시설공유면적");
        return false;
    }
	
	return true;
}
 
/**
 * callPopup()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.01.24
 * 개    요 : 팝업 호출
 * return값 :
 */
function callPopup(popupNm) {
    if (popupNm == "orgcd") { // (담당부서)조직코드
        if (LC_FCL_FLAG.BindColVal == "" || LC_FCL_FLAG.BindColVal == "%") {//점 미선택시
            showMessage(STOPSIGN, OK, "USER-1003", "점");
            LC_FCL_FLAG.Focus();
            return;
        }  
    
        orgPop( EM_ORG_CD, EM_ORG_NM, "N", "", "", "", "", "", "00");
    }
}

/**
 * getInsertInfo()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : 신규등록시 시설구분 변경 호출
 * return값 :
 */
function getInsertInfo() {
    if (g_RowStatus == 3) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1000", "변경된 내역이 있습니다. 시설구분을 변경 하시겠습니까?");
        if (ret != "1") return;
    }
	 
	var strFlcFlag  = LC_FCL_FLAG.BindColVal;   // [조회용]시설구분(점코드)
	var strSelGbn   = "N";                      // [조회용]조회구분값(신규등록시 시설구분 변경 저리)
	var goTo = "getMaster";
	var parameters = ""
	    + "&strFlcFlag="    + encodeURIComponent(strFlcFlag)
	    + "&strSelGbn="     + encodeURIComponent(strSelGbn);
	TR_MAIN.Action = "/mss/mren101.mr?goTo=" + goTo + parameters;
	TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
	TR_MAIN.Post();
}

/**
 * objectControl()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.01.24
 * 개    요 : 입력값 컨트롤
 * return값 :
 */
function objectControl(objBoolean) {
    if (objBoolean) {
        //LC_FCL_FLAG.Enable      = true;         
        //LC_HUSE_FLAG.Enable   = true;      
        EM_AREA.Enable        = true;           
        EM_EXCL_AREA.Enable   = true;      
        EM_SHR_AREA.Enable    = true;       
        LC_AREA_FLAG.Enable   = true;      
        EM_ORG_CD.Enable      = true; 
        LC_USE_YN.Enable      = true;         
        LC_PWR_CAL_YN.Enable  = true;     
        LC_WARMWTR_CAL_YN.Enable  = true; 
        LC_STEAM_CAL_YN.Enable    = true;   
        LC_COLDWTR_CAL_YN.Enable  = true; 
        LC_WTRWORKS_CAL_YN.Enable = true;
        LC_GRAYWTR_CAL_YN.Enable  = true; 
        LC_GAS_CAL_YN.Enable  = true;    
        LC_PUB_DIV_RATE.Enable  = true;    
    	enableControl(IMG_ORG_CD,true)
    } else {
        //LC_FCL_FLAG.Enable      = false;         
        //LC_HUSE_FLAG.Enable   = false;      
        EM_AREA.Enable        = false;           
        EM_EXCL_AREA.Enable   = false;      
        EM_SHR_AREA.Enable    = false;       
        LC_AREA_FLAG.Enable   = false;      
        EM_ORG_CD.Enable      = false; 
        LC_USE_YN.Enable      = false;         
        LC_PWR_CAL_YN.Enable  = false;     
        LC_WARMWTR_CAL_YN.Enable  = false; 
        LC_STEAM_CAL_YN.Enable    = false;   
        LC_COLDWTR_CAL_YN.Enable  = false; 
        LC_WTRWORKS_CAL_YN.Enable = false;
        LC_GRAYWTR_CAL_YN.Enable  = false; 
        LC_GAS_CAL_YN.Enable  = false; 
        LC_PUB_DIV_RATE.Enable  = false; 
    	enableControl(IMG_ORG_CD,false)
    }
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
    
    //전역변수(데이터 변경상태) 초기화
    g_RowStatus = 0;
</script>
<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
    }
    //저장 성공시 재조회
    LC_S_FCL_FLAG.Index = LC_FCL_FLAG.Index
    btn_Search();
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
//최초 조회 시 처리
if (DS_IO_MASTER.CountRow == 1) {
	//관리비계산여부
    objectControl(true);
}
</script>

<script language=JavaScript for=DS_IO_MASTER event=onColumnChanged(row,colid)>
//데이터 변경시 처리
if (DS_IO_MASTER.CountRow == 1) {
    if (colid == "STR_CD") {
        getInsertInfo();  
    } else {
    	g_RowStatus = 3;
    }
}
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
 
<script language=JavaScript for=EM_ORG_CD event=OnKillFocus()>
//[조회용]담당부서(조직코드)코드  자동완성 및 팝업호출
//if (EM_ORG_CD.Text.length > 0 ) {
	if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_ORG_NM.Text = "";
        return;
    } 
    
    if (LC_FCL_FLAG.BindColVal == "" || LC_FCL_FLAG.BindColVal == "%") {//점 미선택시
        showMessage(STOPSIGN, OK, "USER-1003", "점");
        LC_FCL_FLAG.Focus();
        return;
    }  
	
    //단일건 체크 
    setOrgNmWithoutPop("DS_O_RESULT", EM_ORG_CD, EM_ORG_NM , 'N', 1, "", "", "", "", "", LC_FCL_FLAG.BindColVal);
//}
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
<comment id="_NSID_"><object id="DS_LC_HUSE_FLAG"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_AREA_FLAG"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_LC_USE_YN"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PUB_DIV_RATE"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
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
<object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
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
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th class="point" width="100">시설구분</th>
						<td><comment id="_NSID_"> <object
							id=LC_S_FCL_FLAG classid=<%= Util.CLSID_LUXECOMBO %>
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
	<tr valign="top">
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="s_table">
					<tr>
						<th width="100" rowspan="4">시설정보</th>
						<th width="140" class="point">시설구분</th>
						<td width="150"><comment id="_NSID_"> <object
							id=LC_FCL_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width="140" 
							height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="140" class="point">주거구분</th>
						<td><comment id="_NSID_"> <object id=LC_HUSE_FLAG
							classid=<%= Util.CLSID_LUXECOMBO %> width="140" height=100 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point">시설전체면적(㎥)</th>
						<td><comment id="_NSID_"> <object id=EM_AREA
							classid=<%=Util.CLSID_EMEDIT%> width="135" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th class="point">지역</th>
						<td><comment id="_NSID_"> <object id=LC_AREA_FLAG
							classid=<%= Util.CLSID_LUXECOMBO %> width="140" height=100 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point">시설전용면적(㎥)</th>
						<td><comment id="_NSID_"> <object id=EM_EXCL_AREA
							classid=<%=Util.CLSID_EMEDIT%> width="135" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th class="point">담당부서</th>
						<td><comment id="_NSID_"> <object id=EM_ORG_CD
							classid=<%=Util.CLSID_EMEDIT%> width="80" tabindex=1> </object> </comment>
						<script> _ws_(_NSID_);</script> <img id="IMG_ORG_CD"
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:callPopup('orgcd');" align="absmiddle"/> <comment id="_NSID_">
						<object id=EM_ORG_NM classid=<%=Util.CLSID_EMEDIT%> width="120"
							tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point">시설공유면적(㎥)</th>
						<td><comment id="_NSID_"> <object id=EM_SHR_AREA
							classid=<%=Util.CLSID_EMEDIT%> width="135" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th>사용여부</th>
						<td><comment id="_NSID_"> <object id=LC_USE_YN
							classid=<%= Util.CLSID_LUXECOMBO %> width="140" height=100 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
				    <tr>
						<th rowspan="4">관리비부과정보</th>
						<th>전기요금</th>
						<td><comment id="_NSID_"> <object id=LC_PWR_CAL_YN
							classid=<%= Util.CLSID_LUXECOMBO %> width="140" height=100 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>온수여부</th>
						<td><comment id="_NSID_"> <object
							id=LC_WARMWTR_CAL_YN classid=<%= Util.CLSID_LUXECOMBO %>
							width="140" height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>증기요금</th>
						<td><comment id="_NSID_"> <object
							id=LC_STEAM_CAL_YN classid=<%= Util.CLSID_LUXECOMBO %>
							width="140" height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th>냉수요금</th>
						<td><comment id="_NSID_"> <object
							id=LC_COLDWTR_CAL_YN classid=<%= Util.CLSID_LUXECOMBO %>
							width="140" height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>수도요금</th>
						<td><comment id="_NSID_"> <object
							id=LC_WTRWORKS_CAL_YN classid=<%= Util.CLSID_LUXECOMBO %>
							width="140" height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th>중수요금</th>
						<td><comment id="_NSID_"> <object
							id=LC_GRAYWTR_CAL_YN classid=<%= Util.CLSID_LUXECOMBO %>
							width="140" height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>가스요금</th>
						<td><comment id="_NSID_"> <object
							id=LC_GAS_CAL_YN classid=<%= Util.CLSID_LUXECOMBO %> width="140"
							height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
                        <th>공용안분기준</th>
                        <td><comment id="_NSID_"> <object
                            id=LC_PUB_DIV_RATE classid=<%= Util.CLSID_LUXECOMBO %>
                            width="140" height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
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
        <param name=DataID          value=DS_IO_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        <c>Col=STR_CD           Ctrl=LC_FCL_FLAG            param=BindColVal</c>
        <c>Col=HUSE_FLAG        Ctrl=LC_HUSE_FLAG           param=BindColVal</c>
        <c>Col=AREA             Ctrl=EM_AREA                param=Text</c>
        <c>Col=EXCL_AREA        Ctrl=EM_EXCL_AREA           param=Text</c>
        <c>Col=SHR_AREA         Ctrl=EM_SHR_AREA            param=Text</c>
        <c>Col=AREA_FLAG        Ctrl=LC_AREA_FLAG           param=BindColVal</c>
        <c>Col=ORG_CD           Ctrl=EM_ORG_CD              param=Text</c>
        <c>Col=ORG_NM           Ctrl=EM_ORG_NM              param=Text</c>
        <c>Col=USE_YN           Ctrl=LC_USE_YN              param=BindColVal</c>
        <c>Col=PWR_CAL_YN       Ctrl=LC_PWR_CAL_YN          param=BindColVal</c>
        <c>Col=WARMWTR_CAL_YN   Ctrl=LC_WARMWTR_CAL_YN      param=BindColVal</c>
        <c>Col=STEAM_CAL_YN     Ctrl=LC_STEAM_CAL_YN        param=BindColVal</c>
        <c>Col=COLDWTR_CAL_YN   Ctrl=LC_COLDWTR_CAL_YN      param=BindColVal</c>
        <c>Col=WTRWORKS_CAL_YN  Ctrl=LC_WTRWORKS_CAL_YN     param=BindColVal</c>
        <c>Col=GRAYWTR_CAL_YN   Ctrl=LC_GRAYWTR_CAL_YN      param=BindColVal</c>
        <c>Col=GAS_CAL_YN       Ctrl=LC_GAS_CAL_YN          param=BindColVal</c>
        <c>Col=PUB_DIV_RATE     Ctrl=LC_PUB_DIV_RATE        param=BindColVal</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>
