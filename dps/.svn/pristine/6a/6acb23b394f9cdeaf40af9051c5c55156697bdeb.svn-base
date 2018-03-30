<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > POS기준정보> POS관리
 * 작 성 일 : 2011.01.19
 * 작 성 자 : 정진영
 * 수 정 자 :  
 * 파 일 명 : pcod8010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : POS 정보를 관리한다.
 * 이    력 :
 *        2011.01.19 (정진영) 신규작성
 ******************************************************************************/
-->
<%@page import="kr.fujitsu.ffw.util.Date2"%>
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

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
<script language="javascript" src="/<%=dir%>/js/common.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var btnSaveClick = false;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 100;		//해당화면의 동적그리드top위치

function doInit(){
	 
    // 텝 초기화
    initTab('TAB_MAIN');
    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_O_POS_NO           , "CODE^4^0"       , NORMAL);    // POS번호
    initEmEdit(EM_O_POS_NAME         , "GEN^20"         , NORMAL);    // POS명
    initEmEdit(EM_O_SHOP_NAME        , "GEN^20"         , NORMAL);    // 매장명
    initEmEdit(EM_POS_NO             , "CODE^4^0"       , PK);        // POS번호
    initEmEdit(EM_POS_NAME           , "GEN^20"         , PK);        // POS명
    initEmEdit(EM_SHOP_NAME          , "GEN^20"         , PK);        // 매장명
    initEmEdit(EM_MST_POS_NO         , "CODE^4^0"       , NORMAL);    // 마스터POS 번호
    initEmEdit(EM_MST_POS_NAME       , "GEN^20"         , READ);      // 마스터POS 명
    initEmEdit(EM_PHONE1_NO          , "CODE^4^0"       , NORMAL);    // 전화번호
    initEmEdit(EM_PHONE2_NO          , "CODE^4^0"       , NORMAL);    // 전화번호
    initEmEdit(EM_PHONE3_NO          , "CODE^4^0"       , NORMAL);    // 전화번호
    initEmEdit(EM_RSPNS_NAME         , "GEN^10"         , NORMAL);    // 책임자이름
    initEmEdit(EM_RSPNS_TEL_NO_1     , "CODE^4^0"       , NORMAL);    // 책임자전화번호
    initEmEdit(EM_RSPNS_TEL_NO_2     , "CODE^4^0"       , NORMAL);    // 책임자전화번호
    initEmEdit(EM_RSPNS_TEL_NO_3     , "CODE^4^0"       , NORMAL);    // 책임자전화번호
    initEmEdit(EM_FNB_SHOP_CD        , "CODE^4"         , NORMAL);    // F&B매장 코드
    initEmEdit(EM_FNB_SHOP_NAME      , "GEN^40"         , READ);      // F&B매장 명
    initEmEdit(EM_VEN_CD             , "CODE^6"         , NORMAL);    // 협력사 코드
    initEmEdit(EM_VEN_NAME           , "GEN^40"         , READ);      // 협력사 명
    //initEmEdit(EM_EVENT_PLACE_CD     , "CODE^4"         , NORMAL);    // 행사장 코드
    //initEmEdit(EM_EVENT_PLACE_NAME   , "GEN^40"         , READ);      // 행사장 명
    //initEmEdit(EM_POS_IP_ADDR        , "GEN^15"         , PK);        // POS IP
    initEmEdit(EM_POS_IP_ADDR1_1      , "CODE^3^0"      , PK);        // POS IP1_1
    initEmEdit(EM_POS_IP_ADDR1_2      , "CODE^3^0"      , PK);        // POS IP1_2
    initEmEdit(EM_POS_IP_ADDR1_3      , "CODE^3^0"      , PK);        // POS IP1_3
    initEmEdit(EM_POS_IP_ADDR1_4      , "CODE^3^0"      , PK);        // POS IP1_4
    
    initEmEdit(EM_POS_IP_ADDR2_1      , "CODE^3^0"      , NORMAL);    // POS IP2_1
    initEmEdit(EM_POS_IP_ADDR2_2      , "CODE^3^0"      , NORMAL);    // POS IP2_2
    initEmEdit(EM_POS_IP_ADDR2_3      , "CODE^3^0"      , NORMAL);    // POS IP2_3
    initEmEdit(EM_POS_IP_ADDR2_4      , "CODE^3^0"      , NORMAL);    // POS IP2_4
    
    //initEmEdit(EM_MAIN_SRVR_IP_ADDR  , "GEN^15"        , PK);        // 메인서버IP
    initEmEdit(EM_MAIN_SRVR_IP_ADDR_1, "CODE^3^0"       , PK);        // 메인서버 IP 1
    initEmEdit(EM_MAIN_SRVR_IP_ADDR_2, "CODE^3^0"       , PK);        // 메인서버 IP 2
    initEmEdit(EM_MAIN_SRVR_IP_ADDR_3, "CODE^3^0"       , PK);        // 메인서버 IP 3
    initEmEdit(EM_MAIN_SRVR_IP_ADDR_4, "CODE^3^0"       , PK);        // 메인서버 IP 4
    initEmEdit(EM_MAIN_SRVR_PORT_NO  , "CODE^5^0"       , PK);        // 메인서버 포트번호
    //initEmEdit(EM_BACK_SRVR_IP_ADDR, "GEN^15"         , PK);        // 백업서버IP
    initEmEdit(EM_BACK_SRVR_IP_ADDR_1, "CODE^3^0"       , PK);        // 백업서버 IP 1
    initEmEdit(EM_BACK_SRVR_IP_ADDR_2, "CODE^3^0"       , PK);        // 백업서버 IP 2
    initEmEdit(EM_BACK_SRVR_IP_ADDR_3, "CODE^3^0"       , PK);        // 백업서버 IP 3
    initEmEdit(EM_BACK_SRVR_IP_ADDR_4, "CODE^3^0"       , PK);        // 백업서버 IP 4
    initEmEdit(EM_BACK_SRVR_PORT_NO  , "CODE^5^0"       , PK);        // 백업서버 포트번호
    initEmEdit(EM_AD_FILE_URL1       , "GEN^80"         , NORMAL);    // 광고파일URL1
    initEmEdit(EM_AD_FILE_URL2       , "GEN^80"         , NORMAL);    // 광고파일URL2
    initEmEdit(EM_UPER_MSG_ID        , "CODE^4"         , PK);        // 상단메세지ID
    initEmEdit(EM_UPER_MSG_NAME      , "GEN^40"         , READ);      // 상단메세지ID 명
    //initEmEdit(EM_MIDL_MSG_ID        , "CODE^4"         , PK);        // 중간메세지ID
    //initEmEdit(EM_MIDL_MSG_NAME      , "GEN^40"         , READ);      // 중간메세지ID 명
    initEmEdit(EM_LWER_MSG_ID        , "CODE^4"         , PK);        // 하단메세지ID
    initEmEdit(EM_LWER_MSG_NAME      , "GEN^40"         , READ);      // 하단메세지ID 명
    initEmEdit(EM_CASH_RECP_MSG_ID   , "CODE^4"         , PK);        // 현금영수증메세지ID
    initEmEdit(EM_CASH_RECP_MSG_NAME , "GEN^40"         , READ);      // 현금영수증메세지ID 명

    initEmEdit(EM_OPTN_19         , "NUMBER^3^0"     , NORMAL);    // OPTN_19
    initEmEdit(EM_OPTN_20         , "NUMBER^8^0"     , PK);        // OPTN_20
    initEmEdit(EM_OPTN_21_FROM    , "0000"           , NORMAL);    // OPTN_21
    initEmEdit(EM_OPTN_21_TO      , "0000"           , NORMAL);    // OPTN_21
    initEmEdit(EM_OPTN_22         , "GEN^20"         , READ);      // OPTN_22
    initEmEdit(EM_OPTN_23         , "GEN^20"         , READ);      // OPTN_23
    initEmEdit(EM_OPTN_24         , "GEN^20"         , READ);      // OPTN_24
    initEmEdit(EM_OPTN_25         , "GEN^20"         , READ);      // OPTN_25
    
    initEmEdit(EM_REMARK          , "GEN^100"        , NORMAL);      // 비고
    
    // 숫자 양수만 입력
    EM_OPTN_19.NumericRange = "0~+:0"; 

    //콤보 초기화
    initComboStyle(LC_O_STR_CD      , DS_O_STR_CD      , "CODE^0^30,NAME^0^140", 1, PK);           // 점(조회)
    initComboStyle(LC_STR_CD        , DS_STR_CD        , "CODE^0^30,NAME^0^130", 1, PK);           // 점
    initComboStyle(LC_FLOR_CD       , DS_FLOR_CD       , "CODE^0^30,NAME^0^130", 1, PK);           // 층
    initComboStyle(LC_HALL_CD       , DS_HALL_CD    , "CODE^0^30,NAME^0^80",  1, PK);
    initComboStyle(LC_POS_FLAG      , DS_POS_FLAG      , "CODE^0^30,NAME^0^130", 1, PK);           // POS구분
    initComboStyle(LC_ITEM_REG_TYPE , DS_ITEM_REG_TYPE , "CODE^0^30,NAME^0^130", 1, PK);           // 상품등록형태
    initComboStyle(LC_MIX_REG_YN    , DS_MIX_REG_YN    , "CODE^0^30,NAME^0^130", 1, PK);           // 혼합등록가능여부
    initComboStyle(LC_EVENT_PLACE_CD, DS_EVENT_PLACE_CD, "CODE^0^30,NAME^0^130", 1, NORMAL);       // 행사장 코드
    initComboStyle(LC_USE_YN        , DS_USE_YN        , "CODE^0^30,NAME^0^130", 1, PK);           // 사용여부
    
    initComboStyle(LC_OPTN_01       , DS_OPTN_01       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 01
    initComboStyle(LC_OPTN_02       , DS_OPTN_02       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 02
    initComboStyle(LC_OPTN_03       , DS_OPTN_03       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 03
    initComboStyle(LC_OPTN_04       , DS_OPTN_04       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 04
    initComboStyle(LC_OPTN_05       , DS_OPTN_05       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 05
    initComboStyle(LC_OPTN_06       , DS_OPTN_06       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 06
    initComboStyle(LC_OPTN_07       , DS_OPTN_07       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 07
    initComboStyle(LC_OPTN_08       , DS_OPTN_08       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 08
    initComboStyle(LC_OPTN_09       , DS_OPTN_09       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 09
    initComboStyle(LC_OPTN_10       , DS_OPTN_10       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 10
    initComboStyle(LC_OPTN_11       , DS_OPTN_11       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 11
    initComboStyle(LC_OPTN_12       , DS_OPTN_12       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 12
    initComboStyle(LC_OPTN_13       , DS_OPTN_13       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 13
    initComboStyle(LC_OPTN_14       , DS_OPTN_14       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 14
    initComboStyle(LC_OPTN_15       , DS_OPTN_15       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 15
    initComboStyle(LC_OPTN_16       , DS_OPTN_16       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 16
    initComboStyle(LC_OPTN_17       , DS_OPTN_17       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 17
    initComboStyle(LC_OPTN_18       , DS_OPTN_18       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 18
    
    initComboStyle(LC_OPTN_26       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 26
    initComboStyle(LC_OPTN_27       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 27
    initComboStyle(LC_OPTN_28       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 28
    initComboStyle(LC_OPTN_29       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 29
    initComboStyle(LC_OPTN_30       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 30
    initComboStyle(LC_OPTN_31       , DS_OPTN_31       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 31
    initComboStyle(LC_OPTN_32       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 32
    initComboStyle(LC_OPTN_33       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 33
    initComboStyle(LC_OPTN_34       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 34
    initComboStyle(LC_OPTN_35       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 35
    initComboStyle(LC_OPTN_36       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 36
    initComboStyle(LC_OPTN_37       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 37
    initComboStyle(LC_OPTN_38       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 38
    initComboStyle(LC_OPTN_39       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 39
    initComboStyle(LC_OPTN_40       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 40
    initComboStyle(LC_OPTN_41       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 41
    initComboStyle(LC_OPTN_42       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 42
    initComboStyle(LC_OPTN_43       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 43
    initComboStyle(LC_OPTN_44       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 44
    initComboStyle(LC_OPTN_45       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 45
    initComboStyle(LC_OPTN_46       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 46
    initComboStyle(LC_OPTN_47       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 47
    initComboStyle(LC_OPTN_48       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 48
    initComboStyle(LC_OPTN_49       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 49
    initComboStyle(LC_OPTN_50       , DS_OPTN_00       , "CODE^0^30,NAME^0^80" , 1, PK);       // OPTN 50
    

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_FLOR_CD"      , "D", "P061", "N");
    getEtcCode("DS_POS_FLAG"     , "D", "P082", "N");
    getEtcCode("DS_ITEM_REG_TYPE", "D", "P030", "N");
    getEtcCode("DS_MIX_REG_YN"   , "D", "D022", "N");
    getEtcCode("DS_USE_YN"       , "D", "D022", "N");
    
    getEtcCode("DS_OPTN_01"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_02"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_03"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_04"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_05"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_06"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_07"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_08"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_09"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_10"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_11"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_12"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_13"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_14"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_15"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_16"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_17"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_18"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_00"    , "D", "D022", "N", "N");
    getEtcCode("DS_OPTN_31"    , "D", "P106", "N", "N");
    getEtcCode("DS_HALL_CD",  "D", "P197", "N");
    
    // 점코드 조회
    getStore("DS_O_STR_CD", "N", "1", "Y");
    getStore("DS_STR_CD", "N", "1", "N");
    getEventPlaceCode("DS_EVENT_PLACE_CD","","N","Y");
    insComboFirstNullId(LC_EVENT_PLACE_CD,"");

    // 필터 적용여부
    DS_EVENT_PLACE_CD.UseFilter = true;
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_O_STR_CD.Index < 0){
        LC_O_STR_CD.Index= 0;
    }
    
    enableCnt("R");

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod801","DS_MASTER" );
    LC_O_STR_CD.Focus();
    
    var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	var obj   = document.getElementById("tab_page2"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}   width=25  align=center  name="NO"       </FC>'
                     + '<FC>id=POS_NO     width=60  align=center  name="POS번호 "  </FC>'
                     + '<FC>id=POS_NAME   width=80  align=left    name="POS명"    </FC>'
                     + '<FC>id=SHOP_NAME  width=80  align=left    name="매장명"    </FC>';
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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            GD_MASTER.Focus();
            return ;
        }
    }

    if( LC_O_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_O_STR_CD.Focus();
        return;
    }
    
    DS_MASTER.ClearData();

    var strStrCd    = LC_O_STR_CD.BindColVal;
    var strPosNo    = EM_O_POS_NO.Text;
    var strPosName  = EM_O_POS_NAME.Text;
    var strShopName = EM_O_SHOP_NAME.Text;
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strPosNo="+encodeURIComponent(strPosNo)
                   + "&strPosName="+encodeURIComponent(strPosName)
                   + "&strShopName="+encodeURIComponent(strShopName);
    TR_MAIN.Action="/dps/pcod801.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {

    if( DS_MASTER.IsUpdated ){
        if( DS_MASTER.RowStatus(DS_MASTER.RowPosition) == '1'){
            if(showMessage(QUESTION, YESNO, "USER-1051")!=1){
                EM_POS_NAME.Focus();
                return;
            }
        }else{
            if(showMessage(QUESTION, YESNO, "USER-1050")!=1){
                EM_POS_NAME.Focus();
                return;
            }           
        }
        DS_MASTER.UndoAll();
    }
    
    DS_MASTER.AddRow();
    var row = DS_MASTER.CountRow;
   
    DS_MASTER.NameValue(row,"STR_CD")  = LC_O_STR_CD.BindColVal;
    DS_MASTER.NameValue(row,"USE_YN")  = "Y";
    DS_MASTER.NameValue(row,"OPTN_01") = "N";
    DS_MASTER.NameValue(row,"OPTN_02") = "N";
    DS_MASTER.NameValue(row,"OPTN_03") = "N";
    DS_MASTER.NameValue(row,"OPTN_04") = "N";
    DS_MASTER.NameValue(row,"OPTN_05") = "N";
    DS_MASTER.NameValue(row,"OPTN_06") = "N";
    DS_MASTER.NameValue(row,"OPTN_07") = "N";
    DS_MASTER.NameValue(row,"OPTN_08") = "N";
    DS_MASTER.NameValue(row,"OPTN_09") = "N";
    DS_MASTER.NameValue(row,"OPTN_10") = "N";
    DS_MASTER.NameValue(row,"OPTN_11") = "N";
    DS_MASTER.NameValue(row,"OPTN_12") = "N";
    DS_MASTER.NameValue(row,"OPTN_13") = "N";
    DS_MASTER.NameValue(row,"OPTN_14") = "N";
    DS_MASTER.NameValue(row,"OPTN_15") = "N";
    DS_MASTER.NameValue(row,"OPTN_16") = "N";
    DS_MASTER.NameValue(row,"OPTN_17") = "N";
    DS_MASTER.NameValue(row,"OPTN_18") = "N";
    
    DS_MASTER.NameValue(row,"OPTN_26") = "N";
    DS_MASTER.NameValue(row,"OPTN_27") = "N";
    DS_MASTER.NameValue(row,"OPTN_28") = "N";
    DS_MASTER.NameValue(row,"OPTN_29") = "N";
    DS_MASTER.NameValue(row,"OPTN_30") = "N";
    
    DS_MASTER.NameValue(row,"OPTN_31") = "0";
    DS_MASTER.NameValue(row,"OPTN_32") = "N";
    DS_MASTER.NameValue(row,"OPTN_33") = "N";
    DS_MASTER.NameValue(row,"OPTN_34") = "N";
    DS_MASTER.NameValue(row,"OPTN_35") = "N";
    DS_MASTER.NameValue(row,"OPTN_36") = "N";
    DS_MASTER.NameValue(row,"OPTN_37") = "N";
    DS_MASTER.NameValue(row,"OPTN_38") = "N";
    DS_MASTER.NameValue(row,"OPTN_39") = "N";
    DS_MASTER.NameValue(row,"OPTN_40") = "N";
    
    DS_MASTER.NameValue(row,"OPTN_41") = "N";
    DS_MASTER.NameValue(row,"OPTN_42") = "N";
    DS_MASTER.NameValue(row,"OPTN_43") = "N";
    DS_MASTER.NameValue(row,"OPTN_44") = "N";
    DS_MASTER.NameValue(row,"OPTN_45") = "N";
    DS_MASTER.NameValue(row,"OPTN_46") = "N";
    DS_MASTER.NameValue(row,"OPTN_47") = "N";
    DS_MASTER.NameValue(row,"OPTN_48") = "N";
    DS_MASTER.NameValue(row,"OPTN_49") = "N";
    DS_MASTER.NameValue(row,"OPTN_50") = "N";

	EM_POS_NO.Focus();
}

/**
 * btn_copyAddRow()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 선택된 row의 정보를 신규row로 복사
 * return값 : void
 */
function btn_copyAddRow() {
	
	 if( DS_MASTER.IsUpdated ){
        if( DS_MASTER.RowStatus(DS_MASTER.RowPosition) == '1'){
            if(showMessage(QUESTION, YESNO, "USER-1051")!=1){
                EM_POS_NAME.Focus();
                return;
            }
        }else{
            if(showMessage(QUESTION, YESNO, "USER-1050")!=1){
                EM_POS_NAME.Focus();
                return;
            }           
        }
        DS_MASTER.UndoAll();
    }
    var oldRow = DS_MASTER.Rowposition;
    
    DS_MASTER.AddRow();
    var row = DS_MASTER.CountRow;
   
	DS_MASTER.NameValue(row,"STR_CD")             = DS_MASTER.NameValue(oldRow,"STR_CD");            
	//DS_MASTER.NameValue(row,"POS_NO")             = DS_MASTER.NameValue(oldRow,"POS_NO");            
	//DS_MASTER.NameValue(row,"SHOP_NAME")          = DS_MASTER.NameValue(oldRow,"SHOP_NAME");         
	DS_MASTER.NameValue(row,"EVENT_PLACE_CD")     = DS_MASTER.NameValue(oldRow,"EVENT_PLACE_CD");    
	//DS_MASTER.NameValue(row,"POS_NAME")           = DS_MASTER.NameValue(oldRow,"POS_NAME");          
	DS_MASTER.NameValue(row,"POS_FLAG")           = DS_MASTER.NameValue(oldRow,"POS_FLAG");          
	DS_MASTER.NameValue(row,"FLOR_CD")            = DS_MASTER.NameValue(oldRow,"FLOR_CD");           
	DS_MASTER.NameValue(row,"MST_POS_NO")         = DS_MASTER.NameValue(oldRow,"MST_POS_NO");        
	DS_MASTER.NameValue(row,"FNB_SHOP_CD")        = DS_MASTER.NameValue(oldRow,"FNB_SHOP_CD");       
	DS_MASTER.NameValue(row,"ITEM_REG_TYPE")      = DS_MASTER.NameValue(oldRow,"ITEM_REG_TYPE");     
	DS_MASTER.NameValue(row,"MIX_REG_YN")         = DS_MASTER.NameValue(oldRow,"MIX_REG_YN");        
	DS_MASTER.NameValue(row,"BACK_SRVR_PORT_NO")  = DS_MASTER.NameValue(oldRow,"BACK_SRVR_PORT_NO"); 
	DS_MASTER.NameValue(row,"LWER_MSG_ID")        = DS_MASTER.NameValue(oldRow,"LWER_MSG_ID");       
	DS_MASTER.NameValue(row,"RSPNS_NAME")         = DS_MASTER.NameValue(oldRow,"RSPNS_NAME");        
	DS_MASTER.NameValue(row,"OPTN_02")            = DS_MASTER.NameValue(oldRow,"OPTN_02");           
	DS_MASTER.NameValue(row,"OPTN_07")            = DS_MASTER.NameValue(oldRow,"OPTN_07");           
	DS_MASTER.NameValue(row,"OPTN_12")            = DS_MASTER.NameValue(oldRow,"OPTN_12");           
	DS_MASTER.NameValue(row,"OPTN_17")            = DS_MASTER.NameValue(oldRow,"OPTN_17");           
	DS_MASTER.NameValue(row,"OPTN_22")            = DS_MASTER.NameValue(oldRow,"OPTN_22");           
	DS_MASTER.NameValue(row,"OPTN_26")            = DS_MASTER.NameValue(oldRow,"OPTN_26");           
	DS_MASTER.NameValue(row,"OPTN_31")            = DS_MASTER.NameValue(oldRow,"OPTN_31");           
	DS_MASTER.NameValue(row,"OPTN_36")            = DS_MASTER.NameValue(oldRow,"OPTN_36");           
	DS_MASTER.NameValue(row,"OPTN_41")            = DS_MASTER.NameValue(oldRow,"OPTN_41");           
	DS_MASTER.NameValue(row,"OPTN_46")            = DS_MASTER.NameValue(oldRow,"OPTN_46");           
	DS_MASTER.NameValue(row,"POS_IP_ADDR1")       = DS_MASTER.NameValue(oldRow,"POS_IP_ADDR1");      
	DS_MASTER.NameValue(row,"AD_FILE_URL1")       = DS_MASTER.NameValue(oldRow,"AD_FILE_URL1");      
	DS_MASTER.NameValue(row,"CASH_RECP_MSG_ID")   = DS_MASTER.NameValue(oldRow,"CASH_RECP_MSG_ID");  
	DS_MASTER.NameValue(row,"RSPNS_TEL_NO_1")     = DS_MASTER.NameValue(oldRow,"RSPNS_TEL_NO_1");    
	DS_MASTER.NameValue(row,"OPTN_03")            = DS_MASTER.NameValue(oldRow,"OPTN_03");           
	DS_MASTER.NameValue(row,"OPTN_08")            = DS_MASTER.NameValue(oldRow,"OPTN_08");           
	DS_MASTER.NameValue(row,"OPTN_13")            = DS_MASTER.NameValue(oldRow,"OPTN_13");           
	DS_MASTER.NameValue(row,"OPTN_18")            = DS_MASTER.NameValue(oldRow,"OPTN_18");           
	DS_MASTER.NameValue(row,"OPTN_23")            = DS_MASTER.NameValue(oldRow,"OPTN_23");           
	DS_MASTER.NameValue(row,"OPTN_27")            = DS_MASTER.NameValue(oldRow,"OPTN_27");           
	DS_MASTER.NameValue(row,"OPTN_32")            = DS_MASTER.NameValue(oldRow,"OPTN_32");           
	DS_MASTER.NameValue(row,"OPTN_37")            = DS_MASTER.NameValue(oldRow,"OPTN_37");           
	DS_MASTER.NameValue(row,"OPTN_42")            = DS_MASTER.NameValue(oldRow,"OPTN_42");           
	DS_MASTER.NameValue(row,"OPTN_47")            = DS_MASTER.NameValue(oldRow,"OPTN_47");           
	DS_MASTER.NameValue(row,"MAIN_SRVR_IP_ADDR")  = DS_MASTER.NameValue(oldRow,"MAIN_SRVR_IP_ADDR"); 
	DS_MASTER.NameValue(row,"AD_FILE_URL2")       = DS_MASTER.NameValue(oldRow,"AD_FILE_URL2");      
	DS_MASTER.NameValue(row,"PHONE1_NO")          = DS_MASTER.NameValue(oldRow,"PHONE1_NO");         
	DS_MASTER.NameValue(row,"RSPNS_TEL_NO_2")     = DS_MASTER.NameValue(oldRow,"RSPNS_TEL_NO_2");    
	DS_MASTER.NameValue(row,"OPTN_04")            = DS_MASTER.NameValue(oldRow,"OPTN_04");           
	DS_MASTER.NameValue(row,"OPTN_09")            = DS_MASTER.NameValue(oldRow,"OPTN_09");           
	DS_MASTER.NameValue(row,"OPTN_14")            = DS_MASTER.NameValue(oldRow,"OPTN_14");           
	DS_MASTER.NameValue(row,"OPTN_19")            = DS_MASTER.NameValue(oldRow,"OPTN_19");           
	DS_MASTER.NameValue(row,"OPTN_24")            = DS_MASTER.NameValue(oldRow,"OPTN_24");           
	DS_MASTER.NameValue(row,"OPTN_28")            = DS_MASTER.NameValue(oldRow,"OPTN_28");           
	DS_MASTER.NameValue(row,"OPTN_33")            = DS_MASTER.NameValue(oldRow,"OPTN_33");           
	DS_MASTER.NameValue(row,"OPTN_38")            = DS_MASTER.NameValue(oldRow,"OPTN_38");           
	DS_MASTER.NameValue(row,"OPTN_43")            = DS_MASTER.NameValue(oldRow,"OPTN_43");           
	DS_MASTER.NameValue(row,"OPTN_48")            = DS_MASTER.NameValue(oldRow,"OPTN_48");           
	DS_MASTER.NameValue(row,"MAIN_SRVR_PORT_NO")  = DS_MASTER.NameValue(oldRow,"MAIN_SRVR_PORT_NO"); 
	DS_MASTER.NameValue(row,"UPER_MSG_ID")        = DS_MASTER.NameValue(oldRow,"UPER_MSG_ID");       
	DS_MASTER.NameValue(row,"PHONE2_NO")          = DS_MASTER.NameValue(oldRow,"PHONE2_NO");         
	DS_MASTER.NameValue(row,"RSPNS_TEL_NO_3")     = DS_MASTER.NameValue(oldRow,"RSPNS_TEL_NO_3");    
	DS_MASTER.NameValue(row,"OPTN_05")            = DS_MASTER.NameValue(oldRow,"OPTN_05");           
	DS_MASTER.NameValue(row,"OPTN_10")            = DS_MASTER.NameValue(oldRow,"OPTN_10");           
	DS_MASTER.NameValue(row,"OPTN_15")            = DS_MASTER.NameValue(oldRow,"OPTN_15");           
	DS_MASTER.NameValue(row,"OPTN_20")            = DS_MASTER.NameValue(oldRow,"OPTN_20");           
	DS_MASTER.NameValue(row,"OPTN_25")            = DS_MASTER.NameValue(oldRow,"OPTN_25");           
	DS_MASTER.NameValue(row,"OPTN_29")            = DS_MASTER.NameValue(oldRow,"OPTN_29");           
	DS_MASTER.NameValue(row,"OPTN_34")            = DS_MASTER.NameValue(oldRow,"OPTN_34");           
	DS_MASTER.NameValue(row,"OPTN_39")            = DS_MASTER.NameValue(oldRow,"OPTN_39");           
	DS_MASTER.NameValue(row,"OPTN_44")            = DS_MASTER.NameValue(oldRow,"OPTN_44");           
	DS_MASTER.NameValue(row,"OPTN_49")            = DS_MASTER.NameValue(oldRow,"OPTN_49");           
	DS_MASTER.NameValue(row,"BACK_SRVR_IP_ADDR")  = DS_MASTER.NameValue(oldRow,"BACK_SRVR_IP_ADDR"); 
	DS_MASTER.NameValue(row,"MIDL_MSG_ID")        = DS_MASTER.NameValue(oldRow,"MIDL_MSG_ID");       
	DS_MASTER.NameValue(row,"PHONE3_NO")          = DS_MASTER.NameValue(oldRow,"PHONE3_NO");         
	DS_MASTER.NameValue(row,"OPTN_01")            = DS_MASTER.NameValue(oldRow,"OPTN_01");           
	DS_MASTER.NameValue(row,"OPTN_06")            = DS_MASTER.NameValue(oldRow,"OPTN_06");           
	DS_MASTER.NameValue(row,"OPTN_11")            = DS_MASTER.NameValue(oldRow,"OPTN_11");           
	DS_MASTER.NameValue(row,"OPTN_16")            = DS_MASTER.NameValue(oldRow,"OPTN_16");           
	DS_MASTER.NameValue(row,"USE_YN")             = DS_MASTER.NameValue(oldRow,"USE_YN");            
	DS_MASTER.NameValue(row,"OPTN_30")            = DS_MASTER.NameValue(oldRow,"OPTN_30");           
	DS_MASTER.NameValue(row,"OPTN_35")            = DS_MASTER.NameValue(oldRow,"OPTN_35");           
	DS_MASTER.NameValue(row,"OPTN_40")            = DS_MASTER.NameValue(oldRow,"OPTN_40");           
	DS_MASTER.NameValue(row,"OPTN_45")            = DS_MASTER.NameValue(oldRow,"OPTN_45");           
	DS_MASTER.NameValue(row,"OPTN_50")            = DS_MASTER.NameValue(oldRow,"OPTN_50");           
	DS_MASTER.NameValue(row,"MST_POS_NAME")       = DS_MASTER.NameValue(oldRow,"MST_POS_NAME");      
	DS_MASTER.NameValue(row,"FNB_SHOP_NAME")      = DS_MASTER.NameValue(oldRow,"FNB_SHOP_NAME");     
	DS_MASTER.NameValue(row,"EVENT_PLACE_NAME")   = DS_MASTER.NameValue(oldRow,"EVENT_PLACE_NAME");  
	DS_MASTER.NameValue(row,"UPER_MSG_NAME")      = DS_MASTER.NameValue(oldRow,"UPER_MSG_NAME");     
	DS_MASTER.NameValue(row,"MIDL_MSG_NAME")      = DS_MASTER.NameValue(oldRow,"MIDL_MSG_NAME");     
	DS_MASTER.NameValue(row,"LWER_MSG_NAME")      = DS_MASTER.NameValue(oldRow,"LWER_MSG_NAME");     
	DS_MASTER.NameValue(row,"CASH_RECP_MSG_NAME") = DS_MASTER.NameValue(oldRow,"CASH_RECP_MSG_NAME");
	DS_MASTER.NameValue(row,"OPTN_21_FROM")       = DS_MASTER.NameValue(oldRow,"OPTN_21_FROM");      
	DS_MASTER.NameValue(row,"OPTN_21_TO")         = DS_MASTER.NameValue(oldRow,"OPTN_21_TO");        
	DS_MASTER.NameValue(row,"REMARK")             = DS_MASTER.NameValue(oldRow,"REMARK");            
	DS_MASTER.NameValue(row,"POS_IP_ADDR2")       = DS_MASTER.NameValue(oldRow,"POS_IP_ADDR2");      
	DS_MASTER.NameValue(row,"VEN_CD")             = DS_MASTER.NameValue(oldRow,"VEN_CD");            
	DS_MASTER.NameValue(row,"VEN_NAME")           = DS_MASTER.NameValue(oldRow,"VEN_NAME");                  
	setIpInput(row);
	EM_POS_NO.Focus();
}


/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if( !DS_MASTER.IsUpdated ){
        // 저장할 내용이 없습니다.
        showMessage(INFORMATION, OK, "USER-1028");        
        if( DS_MASTER.CountRow > 0)
            EM_POS_NAME.Focus();
        else
            LC_O_STR_CD.Focus();        
        return;
    }
    //필수 입력체크 
    if(!checkValidation())
        return;

    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','04','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        EM_POS_NAME.Focus();
        return;
    }

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        EM_POS_NAME.Focus();
        return;
    }
    var savePosCd = EM_POS_NO.Text;   
    btnSaveClick = true;
    TR_MAIN.Action="/dps/pcod801.pc?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; 
    TR_MAIN.Post();
    btnSaveClick = false;
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();        
        DS_MASTER.RowPosition = DS_MASTER.NameValueRow("POS_NO",savePosCd);
    }
    GD_MASTER.Focus();

}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * enableCnt()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 입력 설정
 * return값 : void
 */
function enableCnt( mode ){
    var insFlag = mode=="I";
    var updFlag = !(mode=="R");
    var readFlag = false;
    
    enableControl(EM_POS_NO                , insFlag);
    enableControl(EM_POS_NAME              , updFlag);
    enableControl(LC_STR_CD                , insFlag);
    enableControl(EM_SHOP_NAME             , updFlag);
    enableControl(LC_FLOR_CD               , updFlag);
    enableControl(LC_HALL_CD               , updFlag);
    enableControl(LC_POS_FLAG              , updFlag);
    enableControl(LC_ITEM_REG_TYPE         , updFlag);
    enableControl(LC_MIX_REG_YN            , updFlag);
    enableControl(IMG_MST_POS              , updFlag);
    enableControl(EM_MST_POS_NO            , updFlag);
    enableControl(EM_MST_POS_NAME          , readFlag);
    enableControl(EM_PHONE1_NO             , updFlag);
    enableControl(EM_PHONE2_NO             , updFlag);
    enableControl(EM_PHONE3_NO             , updFlag);
    enableControl(EM_RSPNS_NAME            , updFlag);
    enableControl(EM_RSPNS_TEL_NO_1        , updFlag);
    enableControl(EM_RSPNS_TEL_NO_2        , updFlag);
    enableControl(EM_RSPNS_TEL_NO_3        , updFlag);
    enableControl(IMG_FNB_SHOP             , updFlag);
    enableControl(EM_FNB_SHOP_CD           , updFlag);
    enableControl(EM_FNB_SHOP_NAME         , readFlag);
    enableControl(LC_EVENT_PLACE_CD        , updFlag);
    //enableControl(IMG_EVENT_PLACE          , updFlag);
    //enableControl(EM_EVENT_PLACE_CD        , updFlag);
    //enableControl(EM_EVENT_PLACE_NAME      , readFlag);
    //enableControl(EM_POS_IP_ADDR           , updFlag);
    enableControl(EM_POS_IP_ADDR1_1         , updFlag);
    enableControl(EM_POS_IP_ADDR1_2         , updFlag);
    enableControl(EM_POS_IP_ADDR1_3         , updFlag);
    enableControl(EM_POS_IP_ADDR1_4         , updFlag);
    enableControl(EM_POS_IP_ADDR2_1         , updFlag);
    enableControl(EM_POS_IP_ADDR2_2         , updFlag);
    enableControl(EM_POS_IP_ADDR2_3         , updFlag);
    enableControl(EM_POS_IP_ADDR2_4         , updFlag);
    //enableControl(EM_MAIN_SRVR_IP_ADDR     , updFlag);
    enableControl(EM_MAIN_SRVR_IP_ADDR_1   , updFlag);
    enableControl(EM_MAIN_SRVR_IP_ADDR_2   , updFlag);
    enableControl(EM_MAIN_SRVR_IP_ADDR_3   , updFlag);
    enableControl(EM_MAIN_SRVR_IP_ADDR_4   , updFlag);
    enableControl(EM_MAIN_SRVR_PORT_NO     , updFlag);
    //enableControl(EM_BACK_SRVR_IP_ADDR     , updFlag);
    enableControl(EM_BACK_SRVR_IP_ADDR_1   , updFlag);
    enableControl(EM_BACK_SRVR_IP_ADDR_2   , updFlag);
    enableControl(EM_BACK_SRVR_IP_ADDR_3   , updFlag);
    enableControl(EM_BACK_SRVR_IP_ADDR_4   , updFlag);
    enableControl(EM_BACK_SRVR_PORT_NO     , updFlag);
    enableControl(EM_AD_FILE_URL1          , updFlag);
    enableControl(EM_AD_FILE_URL2          , updFlag);
    enableControl(IMG_UPER_MSG             , updFlag);
    enableControl(EM_UPER_MSG_ID           , updFlag);
    enableControl(EM_UPER_MSG_NAME         , readFlag);
   // enableControl(IMG_MIDL_MSG             , updFlag);
   // enableControl(EM_MIDL_MSG_ID           , updFlag);
   // enableControl(EM_MIDL_MSG_NAME         , readFlag);
    enableControl(IMG_LWER_MSG             , updFlag);
    enableControl(EM_LWER_MSG_ID           , updFlag);
    enableControl(EM_LWER_MSG_NAME         , readFlag);
    enableControl(IMG_CASH_RECP_MSG        , updFlag);
    enableControl(EM_CASH_RECP_MSG_ID      , updFlag);
    enableControl(EM_CASH_RECP_MSG_NAME    , readFlag);
    enableControl(EM_REMARK                , updFlag);
    
    enableControl(IMG_VEN_CD              , updFlag);
    enableControl(EM_VEN_CD               , updFlag);
    enableControl(EM_VEN_NAME             , readFlag);
    
    enableControl(LC_USE_YN              , updFlag);
    enableControl(LC_OPTN_01             , updFlag);
    enableControl(LC_OPTN_02             , updFlag);
    enableControl(LC_OPTN_03             , updFlag);
    enableControl(LC_OPTN_04             , updFlag);
    enableControl(LC_OPTN_05             , updFlag);
    enableControl(LC_OPTN_06             , updFlag);
    enableControl(LC_OPTN_07             , updFlag);
    enableControl(LC_OPTN_08             , updFlag);
    enableControl(LC_OPTN_09             , updFlag);
    enableControl(LC_OPTN_10             , updFlag);
    enableControl(LC_OPTN_11             , updFlag);
    enableControl(LC_OPTN_12             , updFlag);
    enableControl(LC_OPTN_13             , updFlag);
    enableControl(LC_OPTN_14             , updFlag);
    enableControl(LC_OPTN_15             , updFlag);
    enableControl(LC_OPTN_16             , updFlag);
    enableControl(LC_OPTN_17             , updFlag);
    enableControl(LC_OPTN_18             , updFlag);
    enableControl(EM_OPTN_19             , updFlag);
    enableControl(EM_OPTN_20             , updFlag);
    enableControl(EM_OPTN_21_FROM        , updFlag);
    enableControl(EM_OPTN_21_TO          , updFlag);
    enableControl(EM_OPTN_22             , readFlag);
    enableControl(EM_OPTN_23             , readFlag);
    enableControl(EM_OPTN_24             , readFlag);
    enableControl(EM_OPTN_25             , readFlag);
    
    enableControl(LC_OPTN_26             , updFlag);
    enableControl(LC_OPTN_27             , updFlag);
    enableControl(LC_OPTN_28             , updFlag);
    enableControl(LC_OPTN_29             , updFlag);
    enableControl(LC_OPTN_30             , updFlag);
    enableControl(LC_OPTN_31             , updFlag);
    enableControl(LC_OPTN_32             , updFlag);
    enableControl(LC_OPTN_33             , updFlag);
    enableControl(LC_OPTN_34             , updFlag);
    enableControl(LC_OPTN_35             , updFlag);
    enableControl(LC_OPTN_36             , updFlag);
    enableControl(LC_OPTN_37             , updFlag);
    enableControl(LC_OPTN_38             , updFlag);
    enableControl(LC_OPTN_39             , updFlag);
    enableControl(LC_OPTN_40             , updFlag);
    enableControl(LC_OPTN_41             , updFlag);
    enableControl(LC_OPTN_42             , updFlag);
    enableControl(LC_OPTN_43             , updFlag);
    enableControl(LC_OPTN_44             , updFlag);
    enableControl(LC_OPTN_45             , updFlag);
    enableControl(LC_OPTN_46             , updFlag);
    enableControl(LC_OPTN_47             , updFlag);
    enableControl(LC_OPTN_48             , updFlag);
    enableControl(LC_OPTN_49             , updFlag);
    enableControl(LC_OPTN_50             , updFlag);
    
}

/**
 * setPosNo()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : POS 번호를 조회한다.
 * return값 : void
 */
function setPosNo( evnFlag, svrFlag){

    var codeObj = svrFlag=='S'?EM_O_POS_NO:EM_MST_POS_NO;
    var nameObj = svrFlag=='S'?EM_O_POS_NAME:EM_MST_POS_NAME;
    var strObj = svrFlag=='S'?LC_O_STR_CD:LC_STR_CD;
    
    if( strObj.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        strObj.Focus();
        return;
    }
    var strCd = strObj.BindColVal;
    
    if( codeObj.Text == "" && evnFlag != "POP" ){
        nameObj.Text = "";
        return;     
    }
    
    if( evnFlag == "POP" ){
        posNoPop(codeObj,nameObj, strCd,'', '',svrFlag=='S'?'':'Y');
        codeObj.Focus();
    }else if( evnFlag == "NAME" ){
        setPosNoNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, svrFlag=='S'?0:1, strCd,'', '',svrFlag=='S'?'':'Y');
    }
    
}
/**
 * setFNBShop()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : F&B매장를 조회한다.
 * return값 : void
 */
function setFNBShop( evnFlag){

    var codeObj = EM_FNB_SHOP_CD;
    var nameObj = EM_FNB_SHOP_NAME;
    var strObj = LC_STR_CD;
    
    if( strObj.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        strObj.Focus();
        return;
    }
    var strCd = strObj.BindColVal;
    
    if( codeObj.Text == "" && evnFlag != "POP" ){
        nameObj.Text = "";
        return;     
    }
    
    if( evnFlag == "POP" ){
        fnbShopPop(codeObj,nameObj, strCd,'','Y');
        codeObj.Focus();
    }else if( evnFlag == "NAME" ){
        setFnbShopNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 1, strCd,'','Y');
    }
    
}

/**
 * setPosMsg()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 메세지를 조회한다.
 * return값 : void
 */
function setPosMsg( evnFlag, type, codeObj, nameObj){

    var strObj = LC_STR_CD;
    
    if( strObj.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        strObj.Focus();
        return;
    }
    var strCd = strObj.BindColVal;
    
    if( codeObj.Text == "" && evnFlag != "POP" ){
        nameObj.Text = "";
        return;     
    }
    
    if( evnFlag == "POP" ){
        posMsgPop(codeObj,nameObj, strCd, type,'Y');
        codeObj.Focus();
    }else if( evnFlag == "NAME" ){
        setPosMsgNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 1, strCd, type,'Y');
    }
    
}
/**
 * checkValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 입력값을 검증한다.
 * return값 : void
 */
function checkValidation(){
    var errCompObj;
    var errYn = false;
    var row;
    for(var i=1; i<=DS_MASTER.CountRow; i++){
        var rowStatus = DS_MASTER.RowStatus(i);
        if( !(rowStatus=="1"||rowStatus=="3"))
            continue;
        row = i;
        if(DS_MASTER.NameValue(i,"POS_NO")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "POS번호");
            errComp = "EM_POS_NO";
            errYn = true;
            break;
        }
        if(DS_MASTER.NameValue(i,"POS_NO").length < 4){
            showMessage(EXCLAMATION, OK, "USER-1027", "POS번호",4);
            errComp = "EM_POS_NO";
            errYn = true;
            break;
        }
        if(DS_MASTER.NameValue(i,"POS_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "POS명");
            errComp = "EM_POS_NAME";
            errYn = true;
            break;
        }
        if( !checkInputByte( null, DS_MASTER, i, 'POS_NAME', 'POS명',  "EM_POS_NAME")){
            errComp = "EM_POS_NAME";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"STR_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "점");
            errComp = "LC_STR_CD";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"SHOP_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "매장명");
            errComp = "EM_SHOP_NAME";
            errYn = true;
            break;          
        }
        if( !checkInputByte( null, DS_MASTER, i, 'SHOP_NAME', '매장명',  "EM_SHOP_NAME")){
            errComp = "EM_SHOP_NAME";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"FLOR_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "층");
            errComp = "LC_FLOR_CD";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"HALL_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "관");
            errComp = "LC_HALL_CD";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"POS_FLAG")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "POS구분");
            errComp = "LC_POS_FLAG";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"ITEM_REG_TYPE")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "상품등록형태");
            errComp = "LC_ITEM_REG_TYPE";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"MIX_REG_YN")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "혼합등록가능여부");
            errComp = "LC_MIX_REG_YN";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"MST_POS_NO")!="" && DS_MASTER.NameValue(i,"MST_POS_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "마스터POS");
            errComp = "EM_MST_POS_NO";
            errYn = true;
            break;          
        }
        if( DS_MASTER.NameValue(i,"MST_POS_NO") == DS_MASTER.NameValue(i,"POS_NO")){
            showMessage(EXCLAMATION, OK, "USER-1092", "마스터POS","POS번호");
            errComp = "EM_MST_POS_NO";
            errYn = true;
            break;          
        }
        if( !checkInputByte( null, DS_MASTER, i, 'RSPNS_NAME', '책임자이름',  "EM_RSPNS_NAME")){
            errComp = "EM_RSPNS_NAME";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"FNB_SHOP_CD")!="" && DS_MASTER.NameValue(i,"FNB_SHOP_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "F&B매장");
            errComp = "EM_FNB_SHOP_CD";
            errYn = true;
            break;          
        }
        /*
        if(DS_MASTER.NameValue(i,"EVENT_PLACE_CD")!="" && DS_MASTER.NameValue(i,"EVENT_PLACE_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "행사장");
            errComp = "EM_EVENT_PLACE_CD";
            errYn = true;
            break;          
        }*/

        if(DS_MASTER.NameValue(i,"UPER_MSG_ID")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "상단메세지");
            errComp = "EM_UPER_MSG_ID";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"UPER_MSG_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "상단메세지");
            errComp = "EM_UPER_MSG_ID";
            errYn = true;
            break;          
        }
       /*  if(DS_MASTER.NameValue(i,"MIDL_MSG_ID")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "중간메세지");
            errComp = "EM_MIDL_MSG_ID";
            errYn = true;
            break;          
        } 
            if(DS_MASTER.NameValue(i,"MIDL_MSG_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "중간메세지");
            errComp = "EM_MIDL_MSG_ID";
            errYn = true;
            break;          
        } */
        if(DS_MASTER.NameValue(i,"LWER_MSG_ID")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "하단메세지");
            errComp = "EM_LWER_MSG_ID";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"LWER_MSG_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "하단메세지");
            errComp = "EM_LWER_MSG_ID";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"CASH_RECP_MSG_ID")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "현금영수증메세지");
            errComp = "EM_CASH_RECP_MSG_ID";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"CASH_RECP_MSG_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "현금영수증메세지");
            errComp = "EM_CASH_RECP_MSG_ID";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"USE_YN")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "사용여부");
            errComp = "LC_USE_YN";
            errYn = true;
            break;          
        }

        if( !checkInputByte( null, DS_MASTER, i, 'REMARK', '비고',  "EM_REMARK")){
            errComp = "EM_REMARK";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"POS_IP_ADDR1")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "POS IP");
            errComp = "EM_POS_IP_ADDR1_1";
            errYn = true;
            break;          
        }
        if(!isValidStrIpAddr(DS_MASTER.NameValue(i,"POS_IP_ADDR1"))){
            showMessage(EXCLAMATION, OK, "USER-1004", "POS IP");
            if(EM_POS_IP_ADDR1_1.Text ==""){
                errComp = "EM_POS_IP_ADDR1_1";
            }else if(EM_POS_IP_ADDR1_2.Text ==""){
                errComp = "EM_POS_IP_ADDR1_2";
            }else if(EM_POS_IP_ADDR1_3.Text ==""){
                errComp = "EM_POS_IP_ADDR1_3";
            }else if(EM_POS_IP_ADDR1_4.Text ==""){
                errComp = "EM_POS_IP_ADDR1_4";
            }else if(EM_POS_IP_ADDR1_1.Text > 255){
                errComp = "EM_POS_IP_ADDR1_1";
            }else if(EM_POS_IP_ADDR1_2.Text > 255){
                errComp = "EM_POS_IP_ADDR1_2";
            }else if(EM_POS_IP_ADDR1_3.Text > 255){
                errComp = "EM_POS_IP_ADDR1_3";
            }else if(EM_POS_IP_ADDR1_4.Text > 255){
                errComp = "EM_POS_IP_ADDR1_4";
            }else{
                errComp = "EM_POS_IP_ADDR1_1";
            }
            errYn = true;
            break;          
        }
        
        if(DS_MASTER.NameValue(i,"POS_IP_ADDR2")!="" && DS_MASTER.NameValue(i,"POS_IP_ADDR2")!="..."){
            //alert(DS_MASTER.NameValue(i,"POS_IP_ADDR2"));
            if(!isValidStrIpAddr(DS_MASTER.NameValue(i,"POS_IP_ADDR2"))){
                showMessage(EXCLAMATION, OK, "USER-1004", "POS IP");
                if(EM_POS_IP_ADDR2_1.Text ==""){
                    errComp = "EM_POS_IP_ADDR2_1";
                }else if(EM_POS_IP_ADDR2_2.Text ==""){
                    errComp = "EM_POS_IP_ADDR2_2";
                }else if(EM_POS_IP_ADDR2_3.Text ==""){
                    errComp = "EM_POS_IP_ADDR2_3";
                }else if(EM_POS_IP_ADDR2_4.Text ==""){
                    errComp = "EM_POS_IP_ADDR2_4";
                }else if(EM_POS_IP_ADDR2_1.Text > 255){
                    errComp = "EM_POS_IP_ADDR2_1";
                }else if(EM_POS_IP_ADDR2_2.Text > 255){
                    errComp = "EM_POS_IP_ADDR2_2";
                }else if(EM_POS_IP_ADDR2_3.Text > 255){
                    errComp = "EM_POS_IP_ADDR2_3";
                }else if(EM_POS_IP_ADDR2_4.Text > 255){
                    errComp = "EM_POS_IP_ADDR2_4";
                }else{
                    errComp = "EM_POS_IP_ADDR2_1";
                }
                errYn = true;
                break;          
            }
        }
        
        if(DS_MASTER.NameValue(i,"MAIN_SRVR_IP_ADDR")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "메인서버IP");
            errComp = "EM_MAIN_SRVR_IP_ADDR_1";
            errYn = true;
            break;          
        }
        if(!isValidStrIpAddr(DS_MASTER.NameValue(i,"MAIN_SRVR_IP_ADDR"))){
            showMessage(EXCLAMATION, OK, "USER-1004", "메인서버 IP");
            if(EM_MAIN_SRVR_IP_ADDR_1.Text ==""){
                errComp = "EM_MAIN_SRVR_IP_ADDR_1";
            }else if(EM_MAIN_SRVR_IP_ADDR_2.Text ==""){
                errComp = "EM_MAIN_SRVR_IP_ADDR_2";
            }else if(EM_MAIN_SRVR_IP_ADDR_3.Text ==""){
                errComp = "EM_MAIN_SRVR_IP_ADDR_3";
            }else if(EM_MAIN_SRVR_IP_ADDR_4.Text ==""){
                errComp = "EM_MAIN_SRVR_IP_ADDR_4";
            }else if(EM_MAIN_SRVR_IP_ADDR_1.Text > 255){
                errComp = "EM_MAIN_SRVR_IP_ADDR_1";
            }else if(EM_MAIN_SRVR_IP_ADDR_2.Text > 255){
                errComp = "EM_MAIN_SRVR_IP_ADDR_2";
            }else if(EM_MAIN_SRVR_IP_ADDR_3.Text > 255){
                errComp = "EM_MAIN_SRVR_IP_ADDR_3";
            }else if(EM_MAIN_SRVR_IP_ADDR_4.Text > 255){
                errComp = "EM_MAIN_SRVR_IP_ADDR_4";
            }else{
                errComp = "EM_MAIN_SRVR_IP_ADDR_1";
            }
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"MAIN_SRVR_PORT_NO")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "메인서버포트번호");
            errComp = "EM_MAIN_SRVR_PORT_NO";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"BACK_SRVR_IP_ADDR")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "백업서버IP");
            errComp = "EM_BACK_SRVR_IP_ADDR_1";
            errYn = true;
            break;          
        }
        if(!isValidStrIpAddr(DS_MASTER.NameValue(i,"BACK_SRVR_IP_ADDR"))){
            showMessage(EXCLAMATION, OK, "USER-1004", "백업서버 IP");
            if(EM_BACK_SRVR_IP_ADDR_1.Text ==""){
                errComp = "EM_BACK_SRVR_IP_ADDR_1";
            }else if(EM_BACK_SRVR_IP_ADDR_2.Text ==""){
                errComp = "EM_BACK_SRVR_IP_ADDR_2";
            }else if(EM_BACK_SRVR_IP_ADDR_3.Text ==""){
                errComp = "EM_BACK_SRVR_IP_ADDR_3";
            }else if(EM_BACK_SRVR_IP_ADDR_4.Text ==""){
                errComp = "EM_BACK_SRVR_IP_ADDR_4";
            }else if(EM_BACK_SRVR_IP_ADDR_1.Text > 255){
                errComp = "EM_BACK_SRVR_IP_ADDR_1";
            }else if(EM_BACK_SRVR_IP_ADDR_2.Text > 255){
                errComp = "EM_BACK_SRVR_IP_ADDR_2";
            }else if(EM_BACK_SRVR_IP_ADDR_3.Text > 255){
                errComp = "EM_BACK_SRVR_IP_ADDR_3";
            }else if(EM_BACK_SRVR_IP_ADDR_4.Text > 255){
                errComp = "EM_BACK_SRVR_IP_ADDR_4";
            }else{
                errComp = "EM_BACK_SRVR_IP_ADDR_1";
            }
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"BACK_SRVR_PORT_NO")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "백업서버포트번호");
            errComp = "EM_BACK_SRVR_PORT_NO";
            errYn = true;
            break;          
        }
        if( !checkInputByte( null, DS_MASTER, i, 'AD_FILE_URL1', '광고파일 URL1',  "EM_AD_FILE_URL1")){
            errComp = "EM_AD_FILE_URL1";
            errYn = true;
            break;          
        }
        if( !checkInputByte( null, DS_MASTER, i, 'AD_FILE_URL2', '광고파일 URL2',  "EM_AD_FILE_URL2")){
            errComp = "EM_AD_FILE_URL2";
            errYn = true;
            break;          
        }
        
        // OPTION 입력값 검증
        if(!checkOptionValidation(i))
            return false;
    }
    
    if( errYn){
        setTabItemIndex('TAB_MAIN',1);
        DS_MASTER.RowPosition = row;
        setTimeout(errComp +".Focus();",50);
        return false;
    }
    return true;
}

/**
 * checkOptionValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : Option 입력값을 검증한다.
 * return값 : void
 */
function checkOptionValidation( row){
    var errComp;
    var errYn = false;
    if( DS_MASTER.NameValue(row,"OPTN_01") == "" ){
        showMessage(EXCLAMATION, OK, "USER-1002", "현금결제사용여부");
        errComp = "LC_OPTN_01";
        errYn = true;       
    } else if( DS_MASTER.NameValue(row,"OPTN_02") == "" ){
        showMessage(EXCLAMATION, OK, "USER-1002", "상품권결제사용여부");
        errComp = "LC_OPTN_02";
        errYn = true;       
    } else if( DS_MASTER.NameValue(row,"OPTN_03") == "" ){
        showMessage(EXCLAMATION, OK, "USER-1002", "쿠폰결제사용여부");
        errComp = "LC_OPTN_03";
        errYn = true;       
    } else if( DS_MASTER.NameValue(row,"OPTN_04") == "" ){
        showMessage(EXCLAMATION, OK, "USER-1002", "포인트결제사용여부");
        errComp = "LC_OPTN_04";
        errYn = true;       
    } else if( DS_MASTER.NameValue(row,"OPTN_06") == "" ){
        showMessage(EXCLAMATION, OK, "USER-1002", "현금취소사용여부");
        errComp = "LC_OPTN_06";
        errYn = true;       
    } else if( DS_MASTER.NameValue(row,"OPTN_07") == "" ){
        showMessage(EXCLAMATION, OK, "USER-1002", "상품권취소사용여부");
        errComp = "LC_OPTN_07";
        errYn = true;       
    } else if( DS_MASTER.NameValue(row,"OPTN_08") == "" ){
        showMessage(EXCLAMATION, OK, "USER-1002", "쿠폰취소사용여부");
        errComp = "LC_OPTN_08";
        errYn = true;       
    } else if( DS_MASTER.NameValue(row,"OPTN_09") == "" ){
        showMessage(EXCLAMATION, OK, "USER-1002", "포인트취소사용여부");
        errComp = "LC_OPTN_09";
        errYn = true;       
    } else if( DS_MASTER.NameValue(row,"OPTN_11") == "" ){
        showMessage(EXCLAMATION, OK, "USER-1002", "매가변경사용여부");
        errComp = "LC_OPTN_11";
        errYn = true;       
    } else if( DS_MASTER.NameValue(row,"OPTN_12") == "" ){
        showMessage(EXCLAMATION, OK, "USER-1002", "특별(￦)에누리사용여부");
        errComp = "LC_OPTN_12";
        errYn = true;       
    } else if( DS_MASTER.NameValue(row,"OPTN_13") == "" ){
        showMessage(EXCLAMATION, OK, "USER-1002", "주차할인사용여부");
        errComp = "LC_OPTN_13";
        errYn = true;       
    } else if( DS_MASTER.NameValue(row,"OPTN_14") == "" ){
        showMessage(EXCLAMATION, OK, "USER-1002", "상품권시재관리여부");
        errComp = "LC_OPTN_14";
        errYn = true;       
    } else if( DS_MASTER.NameValue(row,"OPTN_15") == "" ){
        showMessage(EXCLAMATION, OK, "USER-1002", "단축키LOCAL사용여부");
        errComp = "LC_OPTN_15";
        errYn = true;       
    } else if( DS_MASTER.NameValue(row,"OPTN_16") == "" ){
        showMessage(EXCLAMATION, OK, "USER-1002", "Dual Moniter사용여부");
        errComp = "LC_OPTN_16";
        errYn = true;       
    } else if( DS_MASTER.NameValue(row,"OPTN_17") == "" ){
        showMessage(EXCLAMATION, OK, "USER-1002", "외상거래가능여부");
        errComp = "LC_OPTN_17";
        errYn = true;       
    } else if( DS_MASTER.NameValue(row,"OPTN_18") == "" ){
        showMessage(EXCLAMATION, OK, "USER-1002", "사은품회수가능여부");
        errComp = "LC_OPTN_18";
        errYn = true;       
    } else if(DS_MASTER.NameValue(row,"OPTN_19") > 100){
        showMessage(EXCLAMATION, OK, "USER-1021", "특별(%)에누리 MAX율", 100);
        errComp = "EM_OPTN_19";
        errYn = true;
    }else if(DS_MASTER.NameValue(row,"OPTN_21_FROM") != "" || DS_MASTER.NameValue(row,"OPTN_21_TO")!= "" ){
        if(DS_MASTER.NameValue(row,"OPTN_21_FROM") == ""){
            showMessage(EXCLAMATION, OK, "USER-1003", "주문번호영역 FROM");
            errComp = "EM_OPTN_21_FROM";
            errYn = true;
        }else if(DS_MASTER.NameValue(row,"OPTN_21_TO") == ""){
            showMessage(EXCLAMATION, OK, "USER-1003", "주문번호영역 TO");
            errComp = "EM_OPTN_21_TO";
            errYn = true;
        }else if(DS_MASTER.NameValue(row,"OPTN_21_FROM") > DS_MASTER.NameValue(row,"OPTN_21_TO")){
            showMessage(EXCLAMATION, OK, "USER-1009", "주문번호영역 FROM", "주문번호영역 TO");
            errComp = "EM_OPTN_21_FROM";
            errYn = true;
        }
    }
    
    if(errYn){
        setTabItemIndex('TAB_MAIN',2);
        DS_MASTER.RowPosition = row;
        setTimeout(errComp +".Focus();",50);
        return false;
    }
    return true;
}

/**
 * setIpInput()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : Ip 값을 바인드한다.
 * return값 : void
 */
function setIpInput( row){
    if(row < 1){
        EM_POS_IP_ADDR1_1.Text = "";
        EM_POS_IP_ADDR1_2.Text = "";
        EM_POS_IP_ADDR1_3.Text = "";
        EM_POS_IP_ADDR1_4.Text = "";
        EM_POS_IP_ADDR2_1.Text = "";
        EM_POS_IP_ADDR2_2.Text = "";
        EM_POS_IP_ADDR2_3.Text = "";
        EM_POS_IP_ADDR2_4.Text = "";
        EM_MAIN_SRVR_IP_ADDR_1.Text = "";
        EM_MAIN_SRVR_IP_ADDR_2.Text = "";
        EM_MAIN_SRVR_IP_ADDR_3.Text = "";
        EM_MAIN_SRVR_IP_ADDR_4.Text = "";
        EM_BACK_SRVR_IP_ADDR_1.Text = "";
        EM_BACK_SRVR_IP_ADDR_2.Text = "";
        EM_BACK_SRVR_IP_ADDR_3.Text = "";
        EM_BACK_SRVR_IP_ADDR_4.Text = "";
        return;
    }

    var posIpAddr1 = DS_MASTER.NameValue( row, "POS_IP_ADDR1");
    var posIpAddrList1 = posIpAddr1.split("\.");
    EM_POS_IP_ADDR1_1.Text = posIpAddrList1[0];
    EM_POS_IP_ADDR1_2.Text = posIpAddrList1[1];
    EM_POS_IP_ADDR1_3.Text = posIpAddrList1[2];
    EM_POS_IP_ADDR1_4.Text = posIpAddrList1[3];
    var posIpAddr2 = DS_MASTER.NameValue( row, "POS_IP_ADDR2");
    var posIpAddrList2 = posIpAddr2.split("\.");
    EM_POS_IP_ADDR2_1.Text = posIpAddrList2[0];
    EM_POS_IP_ADDR2_2.Text = posIpAddrList2[1];
    EM_POS_IP_ADDR2_3.Text = posIpAddrList2[2];
    EM_POS_IP_ADDR2_4.Text = posIpAddrList2[3];
    var mainIpAddr = DS_MASTER.NameValue( row, "MAIN_SRVR_IP_ADDR");
    var mainIpAddrList = mainIpAddr.split("\.");
    EM_MAIN_SRVR_IP_ADDR_1.Text = mainIpAddrList[0];
    EM_MAIN_SRVR_IP_ADDR_2.Text = mainIpAddrList[1];
    EM_MAIN_SRVR_IP_ADDR_3.Text = mainIpAddrList[2];
    EM_MAIN_SRVR_IP_ADDR_4.Text = mainIpAddrList[3];
    var backIpAddr = DS_MASTER.NameValue( row, "BACK_SRVR_IP_ADDR");
    var backIpAddrList = backIpAddr.split("\.");
    EM_BACK_SRVR_IP_ADDR_1.Text = backIpAddrList[0];
    EM_BACK_SRVR_IP_ADDR_2.Text = backIpAddrList[1];
    EM_BACK_SRVR_IP_ADDR_3.Text = backIpAddrList[2];
    EM_BACK_SRVR_IP_ADDR_4.Text = backIpAddrList[3];
    
}
/**
 * setIpDataset()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : Ip 값을 바인드한다.
 * return값 : void
 */
function setIpDataset( flag){
    var row = DS_MASTER.RowPosition;
    var tmpIp = "";
    switch(flag){
        case 'POS1':
            tmpIp  = EM_POS_IP_ADDR1_1.Text;
            tmpIp += ".";
            tmpIp += EM_POS_IP_ADDR1_2.Text;
            tmpIp += ".";
            tmpIp += EM_POS_IP_ADDR1_3.Text;
            tmpIp += ".";
            tmpIp += EM_POS_IP_ADDR1_4.Text;
            DS_MASTER.NameValue( row, "POS_IP_ADDR1") = tmpIp;
            break;
        case 'POS2':
            tmpIp  = EM_POS_IP_ADDR2_1.Text;
            tmpIp += ".";
            tmpIp += EM_POS_IP_ADDR2_2.Text;
            tmpIp += ".";
            tmpIp += EM_POS_IP_ADDR2_3.Text;
            tmpIp += ".";
            tmpIp += EM_POS_IP_ADDR2_4.Text;
            DS_MASTER.NameValue( row, "POS_IP_ADDR2") = tmpIp;
            break;
        case 'MAIN':
            tmpIp  = EM_MAIN_SRVR_IP_ADDR_1.Text;
            tmpIp += ".";
            tmpIp += EM_MAIN_SRVR_IP_ADDR_2.Text;
            tmpIp += ".";
            tmpIp += EM_MAIN_SRVR_IP_ADDR_3.Text;
            tmpIp += ".";
            tmpIp += EM_MAIN_SRVR_IP_ADDR_4.Text;
            DS_MASTER.NameValue( row, "MAIN_SRVR_IP_ADDR") = tmpIp;
            break;
        case 'BACK':
            tmpIp  = EM_BACK_SRVR_IP_ADDR_1.Text;
            tmpIp += ".";
            tmpIp += EM_BACK_SRVR_IP_ADDR_2.Text;
            tmpIp += ".";
            tmpIp += EM_BACK_SRVR_IP_ADDR_3.Text;
            tmpIp += ".";
            tmpIp += EM_BACK_SRVR_IP_ADDR_4.Text;
            DS_MASTER.NameValue( row, "BACK_SRVR_IP_ADDR") = tmpIp;
            break;
    }
}

/**
 * setVenCode()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-08
 * 개    요 : 협력사 팝업을 실행한다.
 * return값 : void
**/
function setVenCode(evnFlag){
    var codeObj = EM_VEN_CD;
    var nameObj = EM_VEN_NAME;

    if( evnFlag == 'POP'){
        venPop(codeObj,nameObj,LC_STR_CD.BindColVal,'Y');
        codeObj.Focus();
        return;
    }

    if( codeObj.Text ==""){
        nameObj.Text = "";      
        return;
    }
    
    setVenNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj , 1,LC_STR_CD.BindColVal,'Y');

}


/**
 * process()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-06-10
 * 개    요        : 처리버튼 클릭시
 * return값 : void
 */
function btn_send_pos_emg(){
	
	 	var strPosNo = DS_MASTER.NameValue(DS_MASTER.RowPosition,"POS_NO");
		var strProcDt       = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));

        if( strPosNo == ''){
        	showMessage(EXCLAMATION, OK, "USER-1000","POS번호가 존재하지 않습니다.");
        	return;
        }
        
	    if( showMessage(QUESTION, YESNO, "USER-1204") == 1 ){
	 
	        var parameters    = "&strProcDt="  + encodeURIComponent(strProcDt)
	    					  + "&strPosNo="  + encodeURIComponent(strPosNo)
	    					  ;
	       
	    	TR_MAIN.Action = "/dps/pcod801.pc?goTo=sendposemg"+parameters;
	    	TR_MAIN.KeyValue = "SERVLET(O:DS_MASTER=DS_MASTER)";
	    	//searchSetWait("B"); // 프로그래스바
	    	TR_MAIN.Post();        
	    }
}

-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)>
    if( row < 1 || btnSaveClick)
        return;
    if( this.IsUpdated ){
        // 변경된 상세내역이 존재합니다. 이동 하시겠습니까? 
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
            EM_POS_NAME.Focus();
            return false;
        }
        this.UndoAll();
    }
    </script>
<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
    setIpInput(row);
    
    if( row < 1 )
        return;
    
    
    if( this.RowStatus(row)=="1"){
        enableCnt("I");
    }else{
        enableCnt("U");
    }    
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>

<!-- POS번호(조회) -->
<script language=JavaScript for=EM_O_POS_NO event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setPosNo('NAME','S');
</script>

<!-- 마스터POS 번호 -->
<script language=JavaScript for=EM_MST_POS_NO event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setPosNo('NAME','I');
</script>

<!-- F&B매장 -->
<script language=JavaScript for=EM_FNB_SHOP_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setFNBShop('NAME');
</script>
<!-- 상단메세지ID -->
<script language=JavaScript for=EM_UPER_MSG_ID event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setPosMsg('NAME',1,EM_UPER_MSG_ID,EM_UPER_MSG_NAME);
</script>
<!-- 중간메세지ID -->
<!-- <script language=JavaScript for=EM_MIDL_MSG_ID event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setPosMsg('NAME',2,EM_MIDL_MSG_ID,EM_MIDL_MSG_NAME);
</script> -->
<!-- 하단메세지ID -->
<script language=JavaScript for=EM_LWER_MSG_ID event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setPosMsg('NAME',3,EM_LWER_MSG_ID,EM_LWER_MSG_NAME);
</script>
<!-- 현금영수증메세지ID -->
<script language=JavaScript for=EM_CASH_RECP_MSG_ID event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setPosMsg('NAME',4,EM_CASH_RECP_MSG_ID,EM_CASH_RECP_MSG_NAME);
</script>
<!-- POS IP 
<script language=JavaScript for=EM_POS_IP_ADDR event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    // 저장시 체크 2011.04.26
    if(!isValidStrIpAddr(EM_POS_IP_ADDR.Text)){
        showMessage(EXCLAMATION, OK, "USER-1004", "POS IP");
        //EM_POS_IP_ADDR.Text = "";
        setTimeout("EM_POS_IP_ADDR.Focus()",50);
    }
    // */
    
</script>

<!-- 메인서버 IP
<script language=JavaScript for=EM_MAIN_SRVR_IP_ADDR event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    // 저장시 체크 2011.04.26
    if(!isValidStrIpAddr(EM_MAIN_SRVR_IP_ADDR.Text)){
        showMessage(EXCLAMATION, OK, "USER-1004", "메인서버 IP");
       // EM_MAIN_SRVR_IP_ADDR.Text = "";
        setTimeout("EM_MAIN_SRVR_IP_ADDR.Focus()",50);
    }
   // */
</script>

<!-- 백업서버 IP
<script language=JavaScript for=EM_BACK_SRVR_IP_ADDR event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    // 저장시 체크 2011.04.26
    if(!isValidStrIpAddr(EM_BACK_SRVR_IP_ADDR.Text)){
        showMessage(EXCLAMATION, OK, "USER-1004", "백업서버 IP");
        //EM_BACK_SRVR_IP_ADDR.Text = "";
        setTimeout("EM_BACK_SRVR_IP_ADDR.Focus()",50);
    }
    //*/
</script>
-->
<!-- POS IP1 -->
<script language=JavaScript for=EM_POS_IP_ADDR1_1 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    setIpDataset('POS1');    
</script>
<script language=JavaScript for=EM_POS_IP_ADDR1_2 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    setIpDataset('POS1');    
</script>
<script language=JavaScript for=EM_POS_IP_ADDR1_3 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    setIpDataset('POS1');    
</script>
<script language=JavaScript for=EM_POS_IP_ADDR1_4 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    setIpDataset('POS1');    
</script>

<!-- POS IP2 -->
<script language=JavaScript for=EM_POS_IP_ADDR2_1 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    setIpDataset('POS2');    
</script>
<script language=JavaScript for=EM_POS_IP_ADDR2_2 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    setIpDataset('POS2');    
</script>
<script language=JavaScript for=EM_POS_IP_ADDR2_3 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    setIpDataset('POS2');    
</script>
<script language=JavaScript for=EM_POS_IP_ADDR2_4 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    setIpDataset('POS2');    
</script>

<!-- 메인서버 IP -->
<script language=JavaScript for=EM_MAIN_SRVR_IP_ADDR_1
	event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    setIpDataset('MAIN');    
</script>
<script language=JavaScript for=EM_MAIN_SRVR_IP_ADDR_2
	event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    setIpDataset('MAIN');    
</script>
<script language=JavaScript for=EM_MAIN_SRVR_IP_ADDR_3
	event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    setIpDataset('MAIN');    
</script>
<script language=JavaScript for=EM_MAIN_SRVR_IP_ADDR_4
	event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    setIpDataset('MAIN');    
</script>
<!-- 백업서버 IP -->
<script language=JavaScript for=EM_BACK_SRVR_IP_ADDR_1
	event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    setIpDataset('BACK');    
</script>
<script language=JavaScript for=EM_BACK_SRVR_IP_ADDR_2
	event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    setIpDataset('BACK');    
</script>
<script language=JavaScript for=EM_BACK_SRVR_IP_ADDR_3
	event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    setIpDataset('BACK');    
</script>
<script language=JavaScript for=EM_BACK_SRVR_IP_ADDR_4
	event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    setIpDataset('BACK');    
</script>
<!-- 점 -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    //
    EM_MST_POS_NO.Text = "";
    EM_MST_POS_NAME.Text = "";
    EM_FNB_SHOP_CD.Text = "";
    EM_FNB_SHOP_NAME.Text = "";
    EM_UPER_MSG_ID.Text = "";
    EM_UPER_MSG_NAME.Text = "";
    /* EM_MIDL_MSG_ID.Text = ""; 
    EM_MIDL_MSG_NAME.Text = "";*/
    EM_LWER_MSG_ID.Text = "";
    EM_LWER_MSG_NAME.Text = "";
    EM_CASH_RECP_MSG_ID.Text = "";
    EM_CASH_RECP_MSG_NAME.Text = "";
    DS_EVENT_PLACE_CD.Filter();
</script>

<script language=JavaScript for=DS_EVENT_PLACE_CD event=OnFilter(row)>
    var value = this.NameValue(row,"STR_CD");
    if( value == "")
        return true;
    
    if( value != LC_STR_CD.BindColVal)
        return false;
    
    return true;
</script>
<script language=JavaScript for=EM_VEN_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    setVenCode('NAME');
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_">
<object id="DS_O_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_FLOR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_POS_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_ITEM_REG_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_MIX_REG_YN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_EVENT_PLACE_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_USE_YN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_OPTN_01" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OPTN_02" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OPTN_03" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OPTN_04" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OPTN_05" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OPTN_06" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OPTN_07" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OPTN_08" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OPTN_09" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OPTN_10" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OPTN_11" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OPTN_12" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OPTN_13" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OPTN_14" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OPTN_15" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OPTN_16" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OPTN_17" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OPTN_18" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_OPTN_00" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_OPTN_31" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_HALL_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SEARCH_NM" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CLOSECHECK" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
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
    
    
	var obj   = document.getElementById("tab_page2");
    
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
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
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
						<th width="50" class="point">점</th>
						<td width="180"><comment id="_NSID_"> <object
							id=LC_O_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=180
							tabindex=1 align="absmiddle"></object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="50">POS번호</th>
						<td width="180"><comment id="_NSID_"> <object
							id=EM_O_POS_NO classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
							align="absmiddle"></object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:setPosNo('POP','S');" align="absmiddle" /> <comment
							id="_NSID_"> <object id=EM_O_POS_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
							align="absmiddle"></object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="50">매장명</th>
						<td><comment id="_NSID_"> <object
							id=EM_O_SHOP_NAME classid=<%=Util.CLSID_EMEDIT%> width=170
							tabindex=1 align="absmiddle"></object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<td>
						<img src="/<%=dir%>/imgs/btn/copy_row.gif" id=IMG_ADD_COPY onClick="javascript:btn_copyAddRow();" hspace="2" />
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
			
				<td width="300">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"> <object id=GD_MASTER
							width=100% height=508 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_MASTER">
						</object> </comment> <script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
				
				<td class="PL10">
				<div id=TAB_MAIN width=100% height=508 TitleWidth=120
					TitleAlign="center">
				<menu TitleName="POS정보" DivId="tab_page1" />
				<menu TitleName="POS OPTION" DivId="tab_page2" />
				</div>
				
				
				<div id=tab_page1 border=0
					style="position: absolute; left: 0; top: 22px; width: 100%;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
					    
					    <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
              			<tr>
						
						<td class="sub_title PB03 PT10"><img
							src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PB03"
							align="absmiddle" /> POS정보</td>
								
	                    <td width="140">
	            		<table width="100%" >
	                    <td align="right">
							<table border="0" cellspacing="0" cellpadding="0">
							  <tr>
							    <td class="btn_l"> </td>
							    <td class="btn_c"><a href="#" tabindex=1 onclick="btn_send_pos_emg()">긴급POS정보전송</a></td>
							    <td class="btn_r"></td>
							  </tr>
							</table>                
		                </td>		
						</table>				
			            </td>		

                </td> 
                </tr></table></td></tr>
                			            					
					</tr>
					<tr>
						<td>

						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="75" class="point">POS번호</th>
								<td width="165"><comment id="_NSID_"> <object
									id=EM_POS_NO classid=<%=Util.CLSID_EMEDIT%> width=160
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th width="75" class="point">POS명</th>
								<td><comment id="_NSID_"> <object
									id=EM_POS_NAME classid=<%=Util.CLSID_EMEDIT%> width=160
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>
							
							<tr>
								<th class="point">점</th>
								<td><comment id="_NSID_"> <object id=LC_STR_CD
									classid=<%=Util.CLSID_LUXECOMBO%> width=160 tabindex=1
									align="absmiddle"></object> </comment><script>_ws_(_NSID_);</script></td>
								<th class="point">매장명</th>
								<td><comment id="_NSID_"> <object
									id=EM_SHOP_NAME classid=<%=Util.CLSID_EMEDIT%> width=160
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th class="point">관/층</th>
                                <td><comment id="_NSID_"> <object
                                    id=LC_HALL_CD classid=<%=Util.CLSID_LUXECOMBO%> 
                                    width=80 tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                                    <comment id="_NSID_"> <object
                                    id=LC_FLOR_CD classid=<%=Util.CLSID_LUXECOMBO%>
                                    width=80 tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
								<th class="point">POS구분</th>
								<td><comment id="_NSID_"> <object id=LC_POS_FLAG
									classid=<%=Util.CLSID_LUXECOMBO%> width=160 tabindex=1
									align="absmiddle"></object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th class="point">상품등록형태</th>
								<td><comment id="_NSID_"> <object
									id=LC_ITEM_REG_TYPE classid=<%=Util.CLSID_LUXECOMBO%>
									width=160 tabindex=1 align="absmiddle"></object> </comment><script>_ws_(_NSID_);</script>
								</td>
								<th class="point">혼합등록<br>
								가능여부</th>
								<td><comment id="_NSID_"> <object
									id=LC_MIX_REG_YN classid=<%=Util.CLSID_LUXECOMBO%> width=160
									tabindex=1 align="absmiddle"></object> </comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
							
							<tr>
								<th>마스터POS</th>
								<td><comment id="_NSID_"> <object
									id=EM_MST_POS_NO classid=<%=Util.CLSID_EMEDIT%> width=45
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_MST_POS
									class="PR03" onclick="javascript:setPosNo('POP','I');"
									align="absmiddle" /> <comment id="_NSID_"> <object
									id=EM_MST_POS_NAME classid=<%=Util.CLSID_EMEDIT%> width=90
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th>전화번호</th>
								<td><comment id="_NSID_"> <object
									id=EM_PHONE1_NO classid=<%=Util.CLSID_EMEDIT%> width=40
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								&nbsp;-&nbsp; <comment id="_NSID_"> <object
									id=EM_PHONE2_NO classid=<%=Util.CLSID_EMEDIT%> width=40
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								&nbsp;-&nbsp; <comment id="_NSID_"> <object
									id=EM_PHONE3_NO classid=<%=Util.CLSID_EMEDIT%> width=40
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>
							
							<tr>
								<th>책임자이름</th>
								<td><comment id="_NSID_"> <object
									id=EM_RSPNS_NAME classid=<%=Util.CLSID_EMEDIT%> width=160
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th>책임자<br>
								전화번호</th>
								<td><comment id="_NSID_"> <object
									id=EM_RSPNS_TEL_NO_1 classid=<%=Util.CLSID_EMEDIT%> width=40
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								&nbsp;-&nbsp; <comment id="_NSID_"> <object
									id=EM_RSPNS_TEL_NO_2 classid=<%=Util.CLSID_EMEDIT%> width=40
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								&nbsp;-&nbsp; <comment id="_NSID_"> <object
									id=EM_RSPNS_TEL_NO_3 classid=<%=Util.CLSID_EMEDIT%> width=40
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr >
								<td colspan="4"><b>책임자이름,전화번호는 EOD 시작전 단축키기준으로 POSMST를 업데이트합니다.(PDA만)</b></td>
							</tr>
							
							<tr>
								<th>FNB매장</th>
								<td><comment id="_NSID_"> <object
									id=EM_FNB_SHOP_CD classid=<%=Util.CLSID_EMEDIT%> width=45
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
									id=IMG_FNB_SHOP class="PR03"
									onclick="javascript:setFNBShop('POP');" align="absmiddle" /> <comment
									id="_NSID_"> <object id=EM_FNB_SHOP_NAME
									classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th>행사장</th>
								<td><comment id="_NSID_"> <object
									id=LC_EVENT_PLACE_CD classid=<%=Util.CLSID_LUXECOMBO%>
									width=160 tabindex=1 align="absmiddle"></object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th class="point">상단메세지ID</th>
								<td><comment id="_NSID_"> <object
									id=EM_UPER_MSG_ID classid=<%=Util.CLSID_EMEDIT%> width=45
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
									id=IMG_UPER_MSG class="PR03"
									onclick="javascript:setPosMsg('POP',1,EM_UPER_MSG_ID,EM_UPER_MSG_NAME);"
									align="absmiddle" /> <comment id="_NSID_"> <object
									id=EM_UPER_MSG_NAME classid=<%=Util.CLSID_EMEDIT%> width=90
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<%-- <th class="point">중간메세지ID</th>
								<td><comment id="_NSID_"> <object
									id=EM_MIDL_MSG_ID classid=<%=Util.CLSID_EMEDIT%> width=45
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
									id=IMG_MIDL_MSG class="PR03"
									onclick="javascript:setPosMsg('POP',2,EM_MIDL_MSG_ID,EM_MIDL_MSG_NAME);"
									align="absmiddle" /> <comment id="_NSID_"> <object
									id=EM_MIDL_MSG_NAME classid=<%=Util.CLSID_EMEDIT%> width=90
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td> --%>
							</tr>
							
							<tr>
								<th class="point">하단메세지ID</th>
								<td><comment id="_NSID_"> <object
									id=EM_LWER_MSG_ID classid=<%=Util.CLSID_EMEDIT%> width=45
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
									id=IMG_LWER_MSG class="PR03"
									onclick="javascript:setPosMsg('POP',3,EM_LWER_MSG_ID,EM_LWER_MSG_NAME);"
									align="absmiddle" /> <comment id="_NSID_"> <object
									id=EM_LWER_MSG_NAME classid=<%=Util.CLSID_EMEDIT%> width=90
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th class="point">현금영수증<br>
								메세지ID</th>
								<td><comment id="_NSID_"> <object
									id=EM_CASH_RECP_MSG_ID classid=<%=Util.CLSID_EMEDIT%> width=45
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
									id=IMG_CASH_RECP_MSG class="PR03"
									onclick="javascript:setPosMsg('POP',4,EM_CASH_RECP_MSG_ID,EM_CASH_RECP_MSG_NAME);"
									align="absmiddle" /> <comment id="_NSID_"> <object
									id=EM_CASH_RECP_MSG_NAME classid=<%=Util.CLSID_EMEDIT%>
									width=90 tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>
							
							<tr>
								<th>협력사</th>
								<td><comment id="_NSID_"> <object id=EM_VEN_CD
									classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1
									align="absmiddle"></object> </comment><script>_ws_(_NSID_);</script> <img
									src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_VEN_CD
									class="PR03" onclick="javascript:setVenCode('POP');"
									align="absmiddle" /> <comment id="_NSID_"> <object
									id=EM_VEN_NAME classid=<%=Util.CLSID_EMEDIT%> width=90
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th class="point">사용여부</th>
								<td><comment id="_NSID_"> <object id=LC_USE_YN
									classid=<%=Util.CLSID_LUXECOMBO%> width=160 tabindex=1
									align="absmiddle"></object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th>비고</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_REMARK classid=<%=Util.CLSID_EMEDIT%> width=420
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>
							
						</table>
						</td>

					</tr>
				</table>

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="sub_title PB03 PT10"><img
							src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PB03"
							align="absmiddle" /> POS시스템정보</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="75" class="point">POS IP1</th>
								<td><comment id="_NSID_"> <object
									id=EM_POS_IP_ADDR1_1 classid=<%=Util.CLSID_EMEDIT%> width=30
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>&nbsp;.
								<comment id="_NSID_"> <object id=EM_POS_IP_ADDR1_2
									classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>&nbsp;.
								<comment id="_NSID_"> <object id=EM_POS_IP_ADDR1_3
									classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>&nbsp;.
								<comment id="_NSID_"> <object id=EM_POS_IP_ADDR1_4
									classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th width="75">POS IP2</th>
								<td><comment id="_NSID_"> <object
									id=EM_POS_IP_ADDR2_1 classid=<%=Util.CLSID_EMEDIT%> width=30
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>&nbsp;.
								<comment id="_NSID_"> <object id=EM_POS_IP_ADDR2_2
									classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>&nbsp;.
								<comment id="_NSID_"> <object id=EM_POS_IP_ADDR2_3
									classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>&nbsp;.
								<comment id="_NSID_"> <object id=EM_POS_IP_ADDR2_4
									classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th width="75" class="point">메인서버IP</th>
								<td width="165"><comment id="_NSID_"> <object
									id=EM_MAIN_SRVR_IP_ADDR_1 classid=<%=Util.CLSID_EMEDIT%>
									width=30 tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>&nbsp;.
								<comment id="_NSID_"> <object
									id=EM_MAIN_SRVR_IP_ADDR_2 classid=<%=Util.CLSID_EMEDIT%>
									width=30 tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>&nbsp;.
								<comment id="_NSID_"> <object
									id=EM_MAIN_SRVR_IP_ADDR_3 classid=<%=Util.CLSID_EMEDIT%>
									width=30 tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>&nbsp;.
								<comment id="_NSID_"> <object
									id=EM_MAIN_SRVR_IP_ADDR_4 classid=<%=Util.CLSID_EMEDIT%>
									width=30 tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th width="75" class="point">포트번호</th>
								<td><comment id="_NSID_"> <object
									id=EM_MAIN_SRVR_PORT_NO classid=<%=Util.CLSID_EMEDIT%>
									width=155 tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th width="75" class="point">백업서버IP</th>
								<td><comment id="_NSID_"> <object
									id=EM_BACK_SRVR_IP_ADDR_1 classid=<%=Util.CLSID_EMEDIT%>
									width=30 tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>&nbsp;.
								<comment id="_NSID_"> <object
									id=EM_BACK_SRVR_IP_ADDR_2 classid=<%=Util.CLSID_EMEDIT%>
									width=30 tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>&nbsp;.
								<comment id="_NSID_"> <object
									id=EM_BACK_SRVR_IP_ADDR_3 classid=<%=Util.CLSID_EMEDIT%>
									width=30 tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>&nbsp;.
								<comment id="_NSID_"> <object
									id=EM_BACK_SRVR_IP_ADDR_4 classid=<%=Util.CLSID_EMEDIT%>
									width=30 tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th width="75" class="point">포트번호</th>
								<td><comment id="_NSID_"> <object
									id=EM_BACK_SRVR_PORT_NO classid=<%=Util.CLSID_EMEDIT%>
									width=155 tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th width="75">광고파일 URL1</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_AD_FILE_URL1 classid=<%=Util.CLSID_EMEDIT%> width=415
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th width="75">광고파일 URL2</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_AD_FILE_URL2 classid=<%=Util.CLSID_EMEDIT%> width=415
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</div>

				<div id=tab_page2 border=0
					style="position: absolute; left: 0; top: 22px; width: 100%;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title PB03 PT10"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PB03"
									align="absmiddle" /> POS OPTION</td>
							</tr>
						</table>
						</td>
					</tr>
					
					<tr>
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							
							<tr>
								<th width="150" class="point">현금결제사용여부(01)</th>
								<td width="99"><comment id="_NSID_"> <object
									id=LC_OPTN_01 classid=<%=Util.CLSID_LUXECOMBO%> width=95
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th width="130" class="point">상품권결제사용여부(02)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_02
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th class="point">쿠폰결제사용여부(03)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_03
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">포인트결제사용여부(04)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_04
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th class="point">단품정보서버조회여부(05)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_05
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">현금취소사용여부(06)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_06
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th class="point">상품권취소사용여부(07)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_07
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">쿠폰취소사용여부(08)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_08
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th class="point">포인트취소사용여부(09)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_09
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">OK캐쉬백사용여부(10)</th>
<!-- 								<th class="point">기타결제가능여부(10)</th> -->
								<td><comment id="_NSID_"> <object id=LC_OPTN_10
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th class="point">매가변경사용여부(11)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_11
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">특별(￦)에누리사용여부&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>     <!--&nbsp; 안붙이면 태그가 이상해짐  -->
								<td><comment id="_NSID_"> <object id=LC_OPTN_12
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th class="point">주차할인사용여부(13)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_13
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">상품권시재관리여부(14)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_14
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th class="point">단축키로컬사용여부(15)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_15
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">Dual Moniter사용여부(16)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_16
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th class="point">외상거래가능여부(17)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_17
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">사은품회수가능여부(18)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_18
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th>특별(%)에누리 MAX율(19)</th>
								<td><comment id="_NSID_"> <object id=EM_OPTN_19
									classid=<%=Util.CLSID_EMEDIT%> width=93 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">테이블현황갱신주기(20)</th>
								<td><comment id="_NSID_"> <object
									id=EM_OPTN_20 classid=<%=Util.CLSID_EMEDIT%> width=93
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>
							
							<tr>
								<th>주문번호영역(21)</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_OPTN_21_FROM classid=<%=Util.CLSID_EMEDIT%> width=160
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								&nbsp;-&nbsp; <comment id="_NSID_"> <object
									id=EM_OPTN_21_TO classid=<%=Util.CLSID_EMEDIT%> width=160
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>
							
							<tr>
								<th>옵션22</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_OPTN_22 classid=<%=Util.CLSID_EMEDIT%> width=340
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>
							
							<tr>
								<th>옵션23</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_OPTN_23 classid=<%=Util.CLSID_EMEDIT%> width=340
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>
							
							<tr>
								<th>옵션24</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_OPTN_24 classid=<%=Util.CLSID_EMEDIT%> width=340
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>
							
							<tr>
								<th>옵션25</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_OPTN_25 classid=<%=Util.CLSID_EMEDIT%> width=340
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>
							
							<tr>
								<th class="point">FNB주문ONLY여부(26)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_26
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script>_ws_(_NSID_);</script></td>
								<th class="point">카드번호수입력가능여부(26)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_27
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th class="point">포인트적립사용여부(28)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_28
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">주문체크영수증출력여부(29)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_29
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th class="point">FNB주방프린터사용여부(30)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_30
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">주문교환증발급형태(31)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_31
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th class="point">수기승인가능여부(32)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_32
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">수기취소승인가능여부(33)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_33
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th class="point">꼬리표출력사용여부(34)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_34
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">응모번호출력사용여부(35)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_35
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th class="point">카드자동반품가능여부(36)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_36
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">주방PRT(메뉴분류)(37)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_37
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
<!-- 								<th class="point">DCC사용여부(38)</th> -->
								<th class="point">임대명판사용여부(38)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_38
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">준비금마감입금입력여부(39)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_39
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th class="point">사은품확인여부(40)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_40
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">기타결제가능여부(41)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_41
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>

							<tr>
								<th class="point">온라인결제가능여부(42)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_42
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">외상결제가능여부(43)</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_43
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>

							<tr>
								<th class="point">옵션44</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_44
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">옵션45</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_45
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>

							<tr>
								<th class="point">옵션46</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_46
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">옵션47</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_47
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							
							<tr>
								<th class="point">옵션48</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_48
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th class="point">옵션49</th>
								<td><comment id="_NSID_"> <object id=LC_OPTN_49
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>							
							<tr>
								<th class="point">옵션50</th>
								<td colspan=3><comment id="_NSID_"> <object
									id=LC_OPTN_50 classid=<%=Util.CLSID_LUXECOMBO%> width=95
									tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>

						</table>
						</td>
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
<object id=BO_HEADER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
        <c>col=STR_CD                 ctrl=LC_STR_CD                param=BindColVal </c>  
        <c>col=FLOR_CD                ctrl=LC_FLOR_CD               param=BindColVal </c>
        <c>col=HALL_CD                ctrl=LC_HALL_CD            param=BindColVal </c>
        <c>col=POS_FLAG               ctrl=LC_POS_FLAG              param=BindColVal </c>
        <c>col=ITEM_REG_TYPE          ctrl=LC_ITEM_REG_TYPE         param=BindColVal </c>
        <c>col=MIX_REG_YN             ctrl=LC_MIX_REG_YN            param=BindColVal </c>
        <c>col=POS_NO                 ctrl=EM_POS_NO                param=Text </c>
        <c>col=POS_NAME               ctrl=EM_POS_NAME              param=Text </c>
        <c>col=SHOP_NAME              ctrl=EM_SHOP_NAME             param=Text </c>
        <c>col=MST_POS_NO             ctrl=EM_MST_POS_NO            param=Text </c>
        <c>col=MST_POS_NAME           ctrl=EM_MST_POS_NAME          param=Text </c>
        <c>col=PHONE1_NO              ctrl=EM_PHONE1_NO             param=Text </c>
        <c>col=PHONE2_NO              ctrl=EM_PHONE2_NO             param=Text </c>
        <c>col=PHONE3_NO              ctrl=EM_PHONE3_NO             param=Text </c>
        <c>col=RSPNS_NAME             ctrl=EM_RSPNS_NAME            param=Text </c>
        <c>col=RSPNS_TEL_NO_1         ctrl=EM_RSPNS_TEL_NO_1        param=Text </c>
        <c>col=RSPNS_TEL_NO_2         ctrl=EM_RSPNS_TEL_NO_2        param=Text </c>
        <c>col=RSPNS_TEL_NO_3         ctrl=EM_RSPNS_TEL_NO_3        param=Text </c>
        <c>col=FNB_SHOP_CD            ctrl=EM_FNB_SHOP_CD           param=Text </c>
        <c>col=FNB_SHOP_NAME          ctrl=EM_FNB_SHOP_NAME         param=Text </c>
        <c>col=EVENT_PLACE_CD         ctrl=LC_EVENT_PLACE_CD        param=BindColVal </c>
        <c>col=VEN_CD                 ctrl=EM_VEN_CD                param=Text </c>
        <c>col=VEN_NAME               ctrl=EM_VEN_NAME              param=Text </c>
        <c>col=USE_YN                 ctrl=LC_USE_YN                param=BindColVal </c>
        <c>col=MAIN_SRVR_PORT_NO      ctrl=EM_MAIN_SRVR_PORT_NO     param=Text </c>
        <c>col=BACK_SRVR_PORT_NO      ctrl=EM_BACK_SRVR_PORT_NO     param=Text </c>
        <c>col=AD_FILE_URL1           ctrl=EM_AD_FILE_URL1          param=Text </c>
        <c>col=AD_FILE_URL2           ctrl=EM_AD_FILE_URL2          param=Text </c>
        <c>col=UPER_MSG_ID            ctrl=EM_UPER_MSG_ID           param=Text </c>
        <c>col=UPER_MSG_NAME          ctrl=EM_UPER_MSG_NAME         param=Text </c>
        <c>col=MIDL_MSG_ID            ctrl=EM_MIDL_MSG_ID           param=Text </c>
        <c>col=MIDL_MSG_NAME          ctrl=EM_MIDL_MSG_NAME         param=Text </c>
        <c>col=LWER_MSG_ID            ctrl=EM_LWER_MSG_ID           param=Text </c>
        <c>col=LWER_MSG_NAME          ctrl=EM_LWER_MSG_NAME         param=Text </c>
        <c>col=CASH_RECP_MSG_ID       ctrl=EM_CASH_RECP_MSG_ID      param=Text </c>
        <c>col=CASH_RECP_MSG_NAME     ctrl=EM_CASH_RECP_MSG_NAME    param=Text </c>  
        <c>col=REMARK                 ctrl=EM_REMARK                param=Text </c>  
        <c>col=OPTN_19                ctrl=EM_OPTN_19               param=Text </c>
        <c>col=OPTN_20                ctrl=EM_OPTN_20               param=Text </c>
        <c>col=OPTN_21_FROM           ctrl=EM_OPTN_21_FROM          param=Text </c>
        <c>col=OPTN_21_TO             ctrl=EM_OPTN_21_TO            param=Text </c>
        <c>col=OPTN_22                ctrl=EM_OPTN_22               param=Text </c>
        <c>col=OPTN_23                ctrl=EM_OPTN_23               param=Text </c>
        <c>col=OPTN_24                ctrl=EM_OPTN_24               param=Text </c>
        <c>col=OPTN_25                ctrl=EM_OPTN_25               param=Text </c>
        <c>col=OPTN_01                ctrl=LC_OPTN_01               param=BindColVal </c>
        <c>col=OPTN_02                ctrl=LC_OPTN_02               param=BindColVal </c>
        <c>col=OPTN_03                ctrl=LC_OPTN_03               param=BindColVal </c>
        <c>col=OPTN_04                ctrl=LC_OPTN_04               param=BindColVal </c>
        <c>col=OPTN_05                ctrl=LC_OPTN_05               param=BindColVal </c>
        <c>col=OPTN_06                ctrl=LC_OPTN_06               param=BindColVal </c>
        <c>col=OPTN_07                ctrl=LC_OPTN_07               param=BindColVal </c>
        <c>col=OPTN_08                ctrl=LC_OPTN_08               param=BindColVal </c>
        <c>col=OPTN_09                ctrl=LC_OPTN_09               param=BindColVal </c>
        <c>col=OPTN_10                ctrl=LC_OPTN_10               param=BindColVal </c>
        <c>col=OPTN_11                ctrl=LC_OPTN_11               param=BindColVal </c>
        <c>col=OPTN_12                ctrl=LC_OPTN_12               param=BindColVal </c>
        <c>col=OPTN_13                ctrl=LC_OPTN_13               param=BindColVal </c>
        <c>col=OPTN_14                ctrl=LC_OPTN_14               param=BindColVal </c>
        <c>col=OPTN_15                ctrl=LC_OPTN_15               param=BindColVal </c>
        <c>col=OPTN_16                ctrl=LC_OPTN_16               param=BindColVal </c>
        <c>col=OPTN_17                ctrl=LC_OPTN_17               param=BindColVal </c>
        <c>col=OPTN_18                ctrl=LC_OPTN_18               param=BindColVal </c> 
            
        <c>col=OPTN_26                ctrl=LC_OPTN_26               param=BindColVal </c>
        <c>col=OPTN_27                ctrl=LC_OPTN_27               param=BindColVal </c>
        <c>col=OPTN_28                ctrl=LC_OPTN_28               param=BindColVal </c>
        <c>col=OPTN_29                ctrl=LC_OPTN_29               param=BindColVal </c>
        <c>col=OPTN_30                ctrl=LC_OPTN_30               param=BindColVal </c>
        <c>col=OPTN_31                ctrl=LC_OPTN_31               param=BindColVal </c>
        <c>col=OPTN_32                ctrl=LC_OPTN_32               param=BindColVal </c>
        <c>col=OPTN_33                ctrl=LC_OPTN_33               param=BindColVal </c>
        <c>col=OPTN_34                ctrl=LC_OPTN_34               param=BindColVal </c>
        <c>col=OPTN_35                ctrl=LC_OPTN_35               param=BindColVal </c>
        <c>col=OPTN_36                ctrl=LC_OPTN_36               param=BindColVal </c>
        <c>col=OPTN_37                ctrl=LC_OPTN_37               param=BindColVal </c>
        <c>col=OPTN_38                ctrl=LC_OPTN_38               param=BindColVal </c>
        <c>col=OPTN_39                ctrl=LC_OPTN_39               param=BindColVal </c>
        <c>col=OPTN_40                ctrl=LC_OPTN_40               param=BindColVal </c>
        <c>col=OPTN_41                ctrl=LC_OPTN_41               param=BindColVal </c>
        <c>col=OPTN_42                ctrl=LC_OPTN_42               param=BindColVal </c>
        <c>col=OPTN_43                ctrl=LC_OPTN_43               param=BindColVal </c>
        <c>col=OPTN_44                ctrl=LC_OPTN_44               param=BindColVal </c>
        <c>col=OPTN_45                ctrl=LC_OPTN_45               param=BindColVal </c>
        <c>col=OPTN_46                ctrl=LC_OPTN_46               param=BindColVal </c>
        <c>col=OPTN_47                ctrl=LC_OPTN_47               param=BindColVal </c>
        <c>col=OPTN_48                ctrl=LC_OPTN_48               param=BindColVal </c>
        <c>col=OPTN_49                ctrl=LC_OPTN_49               param=BindColVal </c>
        <c>col=OPTN_50                ctrl=LC_OPTN_50               param=BindColVal </c>     
    '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
<body>
</html>
