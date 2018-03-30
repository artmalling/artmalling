<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주관리 > 전표번호별 발주조회
 * 작 성 일 : 2010.04.19
 * 작 성 자 : 신명섭
 * 수 정 자 : 
 * 파 일 명 : pord1170.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button"%>
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
<script language="javascript"   src="/<%=dir%>/js/common.js"        type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/gauce.js"         type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/global.js"        type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/message.js"       type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/popup.js"         type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/popup_dps.js"     type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/popup_mss.js"     type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">

var strBuyerYN        = "";                            // 바이어/SM일 경우 Y
var strToday          = "";                            // 현재날짜
var strSlipNo         = "";                            // 발주번호
var roundFlag         = "";                            // 반올림 구분 (1:원단위미만반올림, 2:원단위미만버림, 3:원단위미만올림)
                      
var strSumText        = "";                            // GR_DETAIL 합계(차익율)
var blnSkuChanged     = false;                         // 단품코드 변경 여부
var intSearchCnt      = 0;                             // 조회버튼클릭 여부(0일 경우 마스터조회 건수)
var bfListRowPosition = 0;                             // 이전 List Row Position
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 var top  = 195;		//해당화면의 동적그리드top위치
 var top2 = 425;		//해당화면의 동적그리드top위치
/**
 * doInit()
 * 작 성 자    : 김경은
 * 작 성 일     : 2010-02-14
 * 개    요        : 해당 페이지 LOAD 시  
 * return값 : void
 */

 function doInit(){
	 
		//Master 그리드 세로크기자동조정  2013-07-17
		 var obj   = document.getElementById("GR_LIST"); 
		 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
		 
		 var obj   = document.getElementById("GR_DETAIL"); 
		 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";
		 
		 var obj   = document.getElementById("GR_DETAIL1"); 
		 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";
		 
		 var obj   = document.getElementById("GR_DETAIL2"); 
		 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";

		 var obj   = document.getElementById("GR_DETAIL3"); 
		 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";
		 
		 var obj   = document.getElementById("GR_DETAIL4"); 
		 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";

		 var obj   = document.getElementById("GR_DETAIL5"); 
		 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";
		 
		 var obj   = document.getElementById("GR_DETAIL6"); 
		 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";

		 strToday = getTodayDB("DS_O_RESULT");
     
     
     initTab('TAB_MAIN'); /*REV2010*/
    // Input Data Set Header 초기화
     
    // Output Data Set Header 초기화
    DS_O_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>');
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_MASTER1.setDataHeader('<gauce:dataset name="H_MASTER1"/>');//대출입
    DS_IO_MASTER3.setDataHeader('<gauce:dataset name="H_MASTER3"/>');//점출입
    DS_IO_MASTER4.setDataHeader('<gauce:dataset name="H_MASTER4"/>');//매가인상하
    DS_IO_MASTER5.setDataHeader('<gauce:dataset name="H_MASTER5"/>');//수입
    DS_IO_MASTER6.setDataHeader('<gauce:dataset name="H_MASTER6"/>');//품목발주
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    DS_IO_DETAIL1.setDataHeader('<gauce:dataset name="H_DETAIL1"/>');//대출입
    DS_IO_DETAIL2.setDataHeader('<gauce:dataset name="H_DETAIL1"/>');//대출입
    DS_IO_DETAIL3.setDataHeader('<gauce:dataset name="H_DETAIL3"/>');//점출입
    DS_IO_DETAIL4.setDataHeader('<gauce:dataset name="H_DETAIL4"/>');//매가인상하
    DS_IO_DETAIL5.setDataHeader('<gauce:dataset name="H_DETAIL5"/>');//수입
    DS_IO_DETAIL6.setDataHeader('<gauce:dataset name="H_DETAIL6"/>');//품목발주
    DS_O_SKU_INFO.setDataHeader('<gauce:dataset name="H_SKU_INFO"/>');
    DS_O_TEAM.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_PC.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    
    
     DS_EVENT_FLAG.setDataHeader('<gauce:dataset name="H_MARGIN_FLAG"/>');
     DS_SETEVNFLAG.setDataHeader('<gauce:dataset name="H_MARGIN_FLAG"/>');
     DS_EVENT_RATE.setDataHeader('<gauce:dataset name="H_MARGIN_RATE"/>'); 
     DS_SETEVNRATE.setDataHeader('<gauce:dataset name="H_MARGIN_RATE"/>'); 
           
    // 그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //디테일
    
    /* 대출입 그리드초기화 */
    gridCreate3(); //디테일1
    gridCreate4(); //디테일2
    
    /* 점출입 그리드초기화 */
    gridCreate5(); //디테일
    
    /* 매가인상하 그리드초기화 */
    gridCreate6(); //디테일
    
    /* 수입 그리드초기화 */
    gridCreate7(); //디테일
    
    /* 품목발주 그리드초기화 */
    gridCreate8(); //디테일

    // EMedit에 초기화 (조회용)
   // initEmEdit(RD_S_SLIP_FLAG,  "GEN",         NORMAL);         // 전표구분      
    initEmEdit(EM_S_START_DT,   "SYYYYMMDD"        , NORMAL);         // 조회기간1
    initEmEdit(EM_S_END_DT,     "TODAY"            , NORMAL);         // 조회기간2
    initEmEdit(EM_S_PB_CD,      "000000"           , NORMAL);         // 브랜드코드
    initEmEdit(EM_S_PB_NM,      "GEN"              , READ);           // 브랜드명     
    initEmEdit(EM_S_VEN_CD,     "000000"           , NORMAL);         // 협력사코드
    initEmEdit(EM_S_VEN_NM,     "GEN"              , READ);           // 협력사코드명
    initEmEdit(EM_S_SLIP_NO,    "0000-0-0000000"   , NORMAL);         // 전표번호  

    // EMedit에 초기화 (입력용):매입,반품
   // initEmEdit(EM_SLIP_NO,           "GEN^11"     , READ);           // 전표번호  
    initEmEdit(EM_SLIP_NO,           "0000-0-0000000"  , READ);           // 전표번호
    initEmEdit(EM_SLIP_PROC_STAT_NM, "GEN^40"          , READ);           // 전표상태  
    initEmEdit(RD_SLIP_FLAG,         "GEN"             , READ);           // 전표구분          
    initEmEdit(EM_PUMBUN_CD,         "000000"          , READ);           // 브랜드코드  
    initEmEdit(EM_PUMBUN_NM,         "GEN"             , READ);           // 브랜드명
    initEmEdit(EM_BUYER_CD,          "GEN"             , READ);           // 바이어코드
    initEmEdit(EM_BUYER_NM,          "GEN"             , READ);           // 바이어명
    initEmEdit(EM_BIZ_TYPE_NM,       "GEN"             , READ);           // 거래형태
    initEmEdit(EM_TAX_FLAG_NM,       "GEN"             , READ);           // 과세구분
    initEmEdit(EM_ORD_FLAG,          "GEN"             , READ);           // 발주구분
    initEmEdit(EM_VEN_CD,            "000000"          , READ);           // 협력사코드
    initEmEdit(EM_VEN_NM,            "GEN"             , READ);           // 협력사명
    initEmEdit(EM_ORD_OWN_FLAG,      "GEN"             , READ);           // 발주주체
    initEmEdit(EM_ORD_DT,            "YYYYMMDD"        , READ);           // 발주일
    initEmEdit(EM_CONF_DT,           "YYYYMMDD"        , READ);           // 발주확정일
    initEmEdit(EM_DELI_DT,           "YYYYMMDD"        , READ);           // 납품예정일
    initEmEdit(EM_PRC_APP_DT,        "YYYYMMDD"        , READ);           // 가격적용일
    initEmEdit(EM_CHK_DT,            "YYYYMMDD"        , READ);           // 검품확정일
    initEmEdit(EM_GAP_TOT_AMT,       "NUMBER^13^0"     , READ);           // 차익액 
    initEmEdit(EM_GAP_RATE,          "NUMBER^3^2"      , READ);           // 차익율
    initEmEdit(EM_TOT_QTY,           "NUMBER^13^1"     , READ);           // 수량계
    initEmEdit(EM_TOT_COST_AMT,      "NUMBER^13^0"     , READ);           // 원가계
    initEmEdit(EM_TOT_SALE_AMT,      "NUMBER^13^0"     , READ);           // 매가계
    initEmEdit(EM_REMARK,            "GEN^100"         , NORMAL);         // 비고
    
    // EMedit에 초기화 (입력용) :대출입 :REV2010
   // initEmEdit(EM_SLIP_NO1,           "GEN"        , READ);           // 전표번호
    initEmEdit(EM_SLIP_NO1,           "0000-0-0000000" , READ);           // 전표번호
    initEmEdit(EM_PROC_STAT1,         "GEN"            , READ);           // 전표상태
    initEmEdit(EM_PUMBUN_CD1,         "000000"         , READ);           // 대출브랜드코드     
    initEmEdit(EM_PUMBUN_NM1,         "GEN"            , READ);           // 대출브랜드명
    initEmEdit(EM_TAX_FLAG1,          "GEN"            , READ);           // 대출과세구분
    initEmEdit(EM_TAX_FLAG_NM1,       "GEN"            , READ);           // 대출과세구분명
    initEmEdit(EM_P_PUMBUN_CD1,       "000000"         , READ);           // 대입브랜드코드     
    initEmEdit(EM_P_PUMBUN_NM1,       "GEN"            , READ);           // 대입브랜드명
    initEmEdit(EM_P_TAX_FLAG1,        "GEN"            , READ);           // 대입과세구분
    initEmEdit(EM_P_TAX_FLAG_NM1,     "GEN"            , READ);           // 대입과세구분명
   // initEmEdit(EM_P_SLIP_NO1,         "GEN"        , READ);             // 상대전표번호
    initEmEdit(EM_P_SLIP_NO1,         "0000-0-0000000" , READ);           // 상대전표번호
    initEmEdit(EM_S_PROC_STAT1,       "GEN"            , READ);           // 상대전표상태
    initEmEdit(EM_BUYER_CD1,          "GEN"            , READ);           // 바이어코드
    initEmEdit(EM_P_BUYER_CD1,        "GEN"            , READ);           // 대입바이어코드
    initEmEdit(EM_BUYER_NM1,          "GEN"            , READ);           // 바이어명
    initEmEdit(EM_ORD_DT1,            "YYYYMMDD"   , READ);         // 발주일
    initEmEdit(EM_DELI_DT1,           "YYYYMMDD"   , READ);         // 시행일(납품예정일)
    initEmEdit(EM_PRC_APP_DT1,        "YYYYMMDD"   , READ);         // 가격적용일
    initEmEdit(EM_CHK_DT1,            "YYYYMMDD"   , READ);           // 검품확정일
    initEmEdit(EM_GAP_TOT_AMT1,       "NUMBER^13^0", READ);           // 차익액 
    initEmEdit(EM_GAP_RATE1,          "NUMBER^3^2" , READ);           // 차익율
    initEmEdit(EM_TOT_QTY1,           "NUMBER^13^0", READ);           // 수량계
    initEmEdit(EM_TOT_COST_AMT1,      "NUMBER^13^0", READ);           // 원가계
    initEmEdit(EM_TOT_SALE_AMT1,      "NUMBER^13^0", READ);           // 매가계
    initEmEdit(EM_REMARK1,            "GEN^100"    , READ);     // 비고
    
 // EMedit에 초기화 (입력용) :점출입       
    //initEmEdit(EM_E_SLIP_NO3,         "GEN"        , READ);           // 점출전표번호
    initEmEdit(EM_E_SLIP_NO3           ,"0000-0-0000000"    ,READ);           // 전표번호
   // initEmEdit(EM_F_SLIP_NO3,         "GEN"        , READ);           // 점입전표번호
    initEmEdit(EM_F_SLIP_NO3           ,"0000-0-0000000"    ,READ);           // 전표번호
    initEmEdit(EM_E_PROC_STAT3,       "GEN"        , READ);           // 점출전표상태
    initEmEdit(EM_F_PROC_STAT3,       "GEN"        , READ);           // 점입전표상태
    
    initEmEdit(EM_PUMBUN_CD3,         "000000"     , READ);             // 점출브랜드코드     
    initEmEdit(EM_PUMBUN_NM3,         "GEN"        , READ);           // 점출브랜드명
    initEmEdit(EM_TAX_FLAG3,          "GEN"        , READ);           // 점출과세구분
    initEmEdit(EM_TAX_FLAG_NM3,       "GEN"        , READ);           // 점출과세구분명
    initEmEdit(EM_P_PUMBUN_CD3,       "000000"     , READ)            // 점입브랜드코드     
    initEmEdit(EM_P_PUMBUN_NM3,       "GEN"        , READ);           // 점입브랜드명
    initEmEdit(EM_P_TAX_FLAG3,        "GEN"        , READ);           // 점입과세구분
    initEmEdit(EM_P_TAX_FLAG_NM3,     "GEN"        , READ);           // 점입과세구분명
    initEmEdit(EM_P_SLIP_NO3,         "GEN"        , READ);           // 상대전표번호
    initEmEdit(EM_S_PROC_STAT3,       "GEN"        , READ);           // 상대전표상태
    initEmEdit(EM_BUYER_CD3,          "GEN"        , READ);           // 바이어코드
    initEmEdit(EM_P_BUYER_CD3,        "GEN"        , READ);           // 점입바이어코드
    initEmEdit(EM_BUYER_NM3,          "GEN"        , READ);           // 바이어명
    initEmEdit(EM_ORD_DT3,            "YYYYMMDD"   , READ);           // 점출예정일
    initEmEdit(EM_DELI_DT3,           "YYYYMMDD"   , READ);           // 점입예정일
    initEmEdit(EM_PRC_APP_DT3,        "YYYYMMDD"   , READ);           // 가격적용일
    initEmEdit(EM_CHK_DT3,            "YYYYMMDD"   , READ);           // 검품확정일
    initEmEdit(EM_GAP_TOT_AMT3,       "NUMBER^13^0", READ);           // 차익액 
    initEmEdit(EM_GAP_RATE3,          "NUMBER^3^2" , READ);           // 차익율
    initEmEdit(EM_TOT_QTY3,           "NUMBER^13^0", READ);           // 수량계
    initEmEdit(EM_TOT_COST_AMT3,      "NUMBER^13^0", READ);           // 원가계
    initEmEdit(EM_TOT_SALE_AMT3,      "NUMBER^13^0", READ);           // 매가계
    initEmEdit(EM_REMARK3,            "GEN^100"    , READ);           // 비고
  
 // EMedit에 초기화 (입력용) : 매가 인상하
   // initEmEdit(EM_SLIP_NO4,           "GEN^11"     , READ);           // 전표번호  
    initEmEdit(EM_SLIP_NO4           ,"0000-0-0000000"    ,READ);           // 전표번호
    initEmEdit(EM_SLIP_PROC_STAT_NM4, "GEN^40"     , READ);           // 전표상태  
    initEmEdit(EM_PUMBUN_CD4,         "000000"     , READ);             // 브랜드코드  
    initEmEdit(EM_PUMBUN_NM4,         "GEN"        , READ);           // 브랜드명
    initEmEdit(EM_BUYER_CD4,          "GEN"        , READ);           // 바이어코드
    initEmEdit(EM_BUYER_NM4,          "GEN"        , READ);           // 바이어명
    initEmEdit(EM_TAX_FLAG_NM4,       "GEN"        , READ);           // 과세구분
    initEmEdit(EM_ORD_DT4,            "YYYYMMDD"   , READ);             // 발주일
    initEmEdit(EM_DELI_DT4,           "YYYYMMDD"   , READ);             // 시행일
    initEmEdit(EM_CHK_DT4,            "YYYYMMDD"   , READ);           // 검품확정일
    initEmEdit(EM_OLD_PRC_APP_DT4,    "YYYYMMDD"   , READ);             // 구가격적용일
    initEmEdit(EM_NEW_PRC_APP_DT4,    "YYYYMMDD"   , READ);             // 신가격적용일

    initEmEdit(EM_GAP_TOT_AMT4,       "NUMBER^13^0", READ);           // 차익액 
//    initEmEdit(EM_GAP_RATE,        "NUMBER^3^2" , READ);           // 차익율
    initEmEdit(EM_TOT_QTY4,           "NUMBER^13^0", READ);           // 수량계
    initEmEdit(EM_OLD_SALE_TAMT4,     "NUMBER^13^0", READ);           // 구매가계
    initEmEdit(EM_NEW_SALE_TAMT4,     "NUMBER^13^0", READ);           // 신매가계
    initEmEdit(EM_REMARK4,            "GEN^100"    , READ);         // 비고
    
    
    //EMedit에 초기화 (입력용) :수입                                                          
    initEmEdit(EM_I_OFFER_NO5,           "GEN^30^",     READ);            //OFFER NO   X 
    initEmEdit(EM_O_OFFER_DT5,           "YYYYMMDD",    READ);          //OFFER DT   X 
   // initEmEdit(EM_I_SLIP_NO5,            "GEN^11",      READ);          //전표번호   
    initEmEdit(EM_I_SLIP_NO5,            "0000-0-0000000"    ,READ);           // 전표번호
    initEmEdit(EM_O_SLIP_FLAG5,          "GEN^40",      READ);          //전표상태        X   
    initEmEdit(EM_I_PUMBUN_CD5,          "GEN^6",       READ);            //브랜드코드                 
    initEmEdit(EM_O_PUMBUN_NM5,          "GEN^40",      READ);          //브랜드명                 
    initEmEdit(EM_I_BUYER_CD5,           "GEN^6",       READ);          //바이어코드           
    initEmEdit(EM_O_BUYER_NM5,           "GEN^40",      READ);          //바이어명                    
    initEmEdit(EM_I_VEN_CD5,             "GEN^6",       READ);            //협력사코드   X            
    initEmEdit(EM_O_VEN_NM5,             "GEN^40",      READ);          //협력사명        X   
    initEmEdit(EM_I_INVOICE_DT5,         "YYYYMMDD",    READ);            //INVOICE 일자           
    initEmEdit(EM_I_INVOICE_NO5,         "GEN^30",      READ);            //INVOICE NO    
    initEmEdit(EM_I_BL_NO5,              "GEN^30",      READ);        //B/L NO     
    initEmEdit(EM_I_SHIP_PORT5,          "GEN^100",     READ);        //선적항           
    initEmEdit(EM_I_ETD5,                "YYYYMMDD",    READ);        //ETD(출발일)     
    initEmEdit(EM_I_ETA5,                "YYYYMMDD",    READ);        //ETA(도착일)
    initEmEdit(EM_I_LC_DATE5,            "YYYYMMDD",    READ);        //L/C DATE        
    initEmEdit(EM_I_LC_NO5,              "GEN^40",      READ);        //L/C NO     
    initEmEdit(EM_I_EXC_APP_DT5,         "YYYYMMDD",    READ);            //환율적용일            
    initEmEdit(EM_I_EXC_RATE5,           "NUMBER^13^2", READ);            //환율                     
    initEmEdit(EM_I_ENTRY_DT5,           "YYYYMMDD",    READ);        //통관예정일
    initEmEdit(EM_I_IMPORT_NO5,          "GEN^30",      READ);        //수입신고번호
    initEmEdit(EM_I_PACKING_CHARGE5,     "NUMBER^13^2", READ);          //Packing Charge      
    initEmEdit(EM_I_NCV5,                "NUMBER^13^2", READ);          //NCV                 
    initEmEdit(EM_I_INVOICE_AMT5,        "NUMBER^13^2", READ);          //INVOICE 금액          
    initEmEdit(EM_I_PRC_APP_DT5,         "YYYYMMDD",    READ);            //가격적용일
    initEmEdit(EM_I_DELI_DT5,            "YYYYMMDD",    READ);            //납품예정일              
    initEmEdit(EM_I_CHK_DT5,             "YYYYMMDD",    READ);          //검품확정일             
    initEmEdit(EM_I_INVOICE_TOT_QTY5,    "NUMBER^7^0",  READ);          //수량계
    initEmEdit(EM_I_INVOICE_TOT_AMT5,    "NUMBER^13^2", READ);          //원가계
    initEmEdit(EM_I_SALE_TOT_AMT5,       "NUMBER^13^2", READ);          //매가계
    initEmEdit(EM_I_REMARK5,             "GEN^100",     READ);        //비고    
    
    // EMedit에 초기화 (입력용) :품목발주     
    initEmEdit(RD_SLIP_FLAG6,  "GEN"  ,     READ);               //입력용 전표구분  
    initEmEdit(EM_I_PB_CD6,    "GEN^6",     READ);               //입력용 브랜드코드
    initEmEdit(EM_I_PB_NM6,    "GEN",       READ);             //입력용 브랜드명     
    initEmEdit(EM_I_BJDATE6,   "YYYYMMDD",  READ);               //입력용 발주일     
    initEmEdit(EM_I_BJHJDATE6, "YYYYMMDD",  READ);             //입력용 발주확정
    initEmEdit(EM_I_NPYJDATE6, "YYYYMMDD",  READ);               //입력용 납품예정일
    initEmEdit(EM_I_MAJINDATE6,"YYYYMMDD",  READ);               //입력용 마진적용일
    initEmEdit(EM_O_ETC6,      "GEN^100",   READ);           //입력용 비고
    initEmEdit(EM_O_MG_RATE,   "NUMBER^5^2"    ,READ);    // 출력용 마진율

    //initEmEdit(EM_O_SLIP_NO6,  "GEN",       READ);              //출력용 전표번호
    initEmEdit(EM_O_SLIP_NO6           ,"0000-0-0000000"    ,READ); // 전표번호
    initEmEdit(EM_O_SLIP_PROC_STAT_NM6, "GEN",     READ);         //출력용 전표상태
    initEmEdit(EM_O_BALJUJC6,  "GEN",       READ);                //출력용 발주주체
    initEmEdit(EM_O_BUYER_CD6, "GEN",       READ);                //출력용 바이어코드
    initEmEdit(EM_O_BUYER_NM6, "GEN",       READ);              //출력용 바이어명
    initEmEdit(EM_O_GS_GBN6,   "GEN",       READ);              //출력용 과세구분
    initEmEdit(EM_O_HRS_CD6,   "GEN",       READ);              //출력용 협력사코드
    initEmEdit(EM_O_HRS_NM6,   "GEN",       READ);              //출력용 협력사명
    initEmEdit(EM_O_GPWJ_DATE6,"YYYYMMDD",  READ);              //출력용 검품확정일
    initEmEdit(EM_O_SRG6,      "NUMBER^7^0",   READ);           //출력용 수량계
    initEmEdit(EM_O_WGG6,      "NUMBER^13^0",  READ);           //출력용 원가계
    initEmEdit(EM_O_MGG6,      "NUMBER^13^0",  READ);            //출력용 매가계
    
    //숨겨진 컴퍼넌트
    initEmEdit(EM_BIZ_TYPE5,             "GEN^40",      READ);          //거래형태                  
    initEmEdit(EM_TAX_FLAG5,             "GEN^40",      READ);          //과세구분                    
    initEmEdit(EM_SKU_FLAG5,             "GEN^40",      READ);          //단품종류        
    
    initEmEdit(EM_BIZ_TYPE_NM5,          "GEN",         READ);          // 거래형태
    initEmEdit(EM_TAX_FLAG_NM5,          "GEN",         READ);          // 과세구분         
    initEmEdit(EM_SKU_FLAG_NM5,          "GEN",         READ);          // 단품종류        X   
     
    
    //콤보 초기화 (조회용)
    initComboStyle(LC_S_STR,            DS_O_STR,              "CODE^0^30,NAME^0^140", 1, NORMAL);    // 점     
    initComboStyle(LC_S_BUMUN,          DS_O_DEPT,             "CODE^0^30,NAME^0^80", 1, NORMAL);     // 팀     
    initComboStyle(LC_S_TEAM,           DS_O_TEAM,             "CODE^0^30,NAME^0^80", 1, NORMAL);     // 파트     
    initComboStyle(LC_S_PC,             DS_O_PC,               "CODE^0^30,NAME^0^80", 1, NORMAL);     // PC     
    initComboStyle(LC_S_GJDATE_TYPE,    DS_O_GJDATE_TYPE,      "CODE^0^30,NAME^0^80", 1, NORMAL);     // 기준일     
    initComboStyle(LC_S_S_PROC_STAT,    DS_O_S_PROC_STAT,      "CODE^0^30,NAME^0^80", 1, NORMAL);     // 전표상태
    initComboStyle(LC_S_AUTO_SLIP_FLAG, DS_O_S_AUTO_SLIP_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);     // 자동전표구분    
    // 콤보초기화 (결과조회용)
    initComboStyle(LC_STR,           DS_O_STR,           "CODE^0^30,NAME^0^140", 1, READ);         // 점 
    initComboStyle(LC_AFT_ORD_FLAG,  DS_O_AFT_ORD_FLAG,  "CODE^0^30,NAME^0^100", 1, READ);         // 사후구분 
    initComboStyle(LC_PAY_COND,      DS_O_PAY_COND,      "CODE^0^30,NAME^0^80", 1, READ);          // 지불구분 
      // 대출입 : 콤보초기화 (결과조회용)
    initComboStyle(LC_STR1,           DS_O_STR,           "CODE^0^30,NAME^0^140", 1, READ);        // 점 
    initComboStyle(LC_AFT_ORD_FLAG1,  DS_O_AFT_ORD_FLAG,  "CODE^0^30,NAME^0^100", 1, READ);        // 사후구분
     
    // 점출입 : 콤보초기화 (결과조회용)
    initComboStyle(LC_STR3,           DS_O_STR,           "CODE^0^30,NAME^0^140", 1, READ);       // 점출점 
    initComboStyle(LC_P_STR3,         DS_O_STR,           "CODE^0^30,NAME^0^140", 1, READ);       // 점입점 
    initComboStyle(LC_AFT_ORD_FLAG3,  DS_O_AFT_ORD_FLAG,  "CODE^0^30,NAME^0^100", 1, READ);       // 사후구분 
    
    // 매가인상하 : 콤보초기화 (결과조회용)
    initComboStyle(LC_STR4,           DS_O_STR,           "CODE^0^30,NAME^0^140", 1, READ);         // 점 
    initComboStyle(LC_AFT_ORD_FLAG4,  DS_O_AFT_ORD_FLAG,  "CODE^0^30,NAME^0^100", 1, READ);         // 사후구분
    initComboStyle(LC_INC_FLAG4,      DS_O_INC_FLAG,      "CODE^0^30,NAME^0^80", 1, READ);          // 인상하구분
    initComboStyle(LC_OLD_EVENT_CD4 , DS_O_OLD_EVENT_CD,  "CODE^0^90,NAME^0^0", 1, READ);           // 구행사코드 
    initComboStyle(LC_NEW_EVENT_CD4 , DS_O_NEW_EVENT_CD,  "CODE^0^90,NAME^0^0", 1, READ);           // 신행사코드 
    initComboStyle(LC_INC_RSN_CD4,    DS_INC_RSN_CD,      "CODE^0^30,NAME^0^130", 1, READ);         // 인상하사유  
 
    // 수입 : 콤보초기화 (결과조회용)
    initComboStyle(LC_I_STR_CD5,            DS_STR,                 "CODE^0^30,NAME^0^140", 1, READ); //점    
    initComboStyle(LC_I_IMPORT_COUNTRY5,    DS_I_IMPORT_COUNTRY,    "CODE^0^30,NAME^0^80", 1, READ);  //수입국가               
    initComboStyle(LC_I_ARRI_PORT5,         DS_I_ARRI_PORT,         "CODE^0^30,NAME^0^80", 1, READ);  //도착항   
    initComboStyle(LC_I_PRC_COND5,          DS_I_PRC_COND,          "CODE^0^30,NAME^0^80", 1, READ);  //가격조건            
    initComboStyle(LC_I_PAYMENT_COND5,      DS_I_PAYMENT_COND,      "CODE^0^30,NAME^0^80", 1, READ);  //결제조건            
    initComboStyle(LC_I_PAYMENT_DTL_COND5,  DS_I_PAYMENT_DTL_COND,  "CODE^0^30,NAME^0^80", 1, READ);  //결제조건 상세
    initComboStyle(LC_I_CURRENCY_CD5,       DS_I_CURRENCY,          "CODE^0^30,NAME^0^80", 1, READ);  //화폐단위   
    
    // 품목발주 : 콤보초기화 (결과조회용)
    initComboStyle(LC_I_STORE6,  DS_STR,           "CODE^0^30,NAME^0^140", 1, READ);                //입력용 점 
    initComboStyle(LC_I_SH_GBN6, DS_O_AFT_ORD_FLAG,  "CODE^0^30,NAME^0^100", 1, READ);              //입력용 사후구분   
    initComboStyle(LC_I_HS_GBN6, DS_SETEVNFLAG,    "EVENT_FLAG^0^30,EVENT_FLAG_NM^0^0", 1, READ);   //입력용 행사구분 
    initComboStyle(LC_I_HS_RATE6,DS_EVENT_RATE,    "EVENT_RATE^0^30,EVENT_RATE_NM^0^0", 1, READ);   //입력용 행사율     
     
    //공통코드에서 데이터 가지고 오기
    //getStrCode("DS_O_STR","N","N");                          // 점
    getEtcCode("DS_O_GJDATE_TYPE",      "D", "P214", "N");       // 기준일
    getEtcCode("DS_O_S_PROC_STAT",      "D", "P207", "Y");       // 전표상태
    getEtcCode("DS_O_AFT_ORD_FLAG",     "D", "P209", "N");       // 사전사후구분
    getEtcCode("DS_O_PAY_COND",         "D", "P212", "N");       // 지불구분 
    getEtcCode("DS_O_BIZ_TYPE",         "D", "P002", "N");       // 거래형태 
    getEtcCode("DS_O_TAX_FLAG",         "D", "P004", "N");       // 과세구분
    getEtcCode("DS_O_ORD_FLAG",         "D", "P203", "N");       // 발주구분 
    getEtcCode("DS_O_ORD_OWN_FLAG",     "D", "P202", "N");       // 발주주체구분 
    getEtcCode("DS_O_INC_FLAG",         "D", "P226", "N");       // 인상하구분
    getEtcCode("DS_S_INC_RSN_CD",       "D", "P227", "Y");       // 인상하사유조회용
    getEtcCode("DS_INC_RSN_CD",         "D", "P227", "N");       // 인상하사유
    getEtcCode("DS_O_S_AUTO_SLIP_FLAG", "D", "P204", "Y");       // 자동전표구분
    
    //공통코드에서 데이터 가지고 오기     
    getStore("DS_STR", "Y", "", "N");          
    getEtcCode("DS_I_CURRENCY",        "D", "P217", "N");      // 화폐단위 
    getEtcCode("DS_I_PRC_COND",        "D", "P218", "N");      // 가격조건 
    getEtcCode("DS_I_PAYMENT_COND",    "D", "P219", "N");      // 결제조건 
    getEtcCode("DS_I_PAYMENT_DTL_COND","D", "P220", "N");      // 결제조건상세 
    getEtcCode("DS_I_ARRI_PORT",       "D", "P222", "N");      // 도착항 
    getEtcCode("DS_I_IMPORT_COUNTRY",  "D", "P223", "N");      // 수입국가 

    getEtcCode("DS_TAG_FLAG",          "D", "P063", "N");      // 택구분 
    getEtcCode("DS_TAG_PRT_OWN_FLAG",  "D", "P064", "N");      // 택발행주체    
    getEtcCode("DS_O_SKU_FLAG",        "D", "P015", "N");      // 단품구분    
    getEtcCode("DS_ORD_UNIT_CD",       "D", "P013", "N");      // 단위
    
    EM_BIZ_TYPE.style.display          = "none";
    EM_TAX_FLAG.style.display          = "none";
    
    //대출입 
    EM_BIZ_TYPE1.style.display         = "none";
    EM_VEN_CD1.style.display           = "none";
    EM_TAX_FLAG1.style.display         = "none";    
    EM_P_BUYER_CD1.style.display       = "none";   
    EM_P_BIZ_TYPE1.style.display       = "none";
    EM_P_TAX_FLAG1.style.display       = "none";
    EM_P_VEN_CD1.style.display         = "none";
    EM_P_TOT_QTY1.style.display        = "none";
    EM_P_TOT_COST_AMT1.style.display   = "none";
    EM_P_TOT_SALE_AMT1.style.display   = "none";
    EM_P_DTL_CNT1.style.display        = "none";
    EM_P_GAP_TOT_AMT1.style.display    = "none";
    EM_P_GAP_RATE1.style.display       = "none";
    EM_P_BUYER_NM1.style.display       = "none";
    
    //점출입
    EM_BIZ_TYPE3.style.display         = "none";
    EM_TAX_FLAG3.style.display         = "none";
    EM_VEN_CD3.style.display           = "none";
    EM_P_BIZ_TYPE3.style.display       = "none";
    EM_P_TAX_FLAG3.style.display       = "none";
    EM_P_VEN_CD3.style.display         = "none";
    EM_P_BUYER_CD3.style.display       = "none";
    EM_P_SLIP_NO3.style.display        = "none";
    EM_S_PROC_STAT3.style.display      = "none";
    
    //매가인상하
    EM_BIZ_TYPE4.style.display         = "none";
    EM_TAX_FLAG4.style.display         = "none";
    EM_VEN_CD4.style.display           = "none";
    EM_GAP_RATE4.style.display         = "none";
    
    //수입
    EM_BIZ_TYPE5.style.display         = "none";
    EM_TAX_FLAG5.style.display         = "none";
    EM_SKU_FLAG5.style.display         = "none";
    
    getStore("DS_O_STR", "Y", "", "N");   
    //getDept("DS_O_DEPT", "Y", LC_S_STR.BindColVal, "Y");                                              // 팀 
    //getTeam("DS_O_TEAM", "Y", LC_S_STR.BindColVal, LC_S_BUMUN.BindColVal, "Y");                       // 파트  
    //getPc("DS_O_PC", "Y", LC_S_STR.BindColVal, LC_S_BUMUN.BindColVal, LC_S_TEAM.BindColVal, "Y");     // PC  

    // LOAD시 마스터 비활성화
    setMasterObject(false);
   
    LC_S_STR.Index            = 0; 
    LC_S_BUMUN.Index          = 0;
    LC_S_TEAM.Index           = 0;
    LC_S_PC.Index             = 0;  
    LC_S_GJDATE_TYPE.Index    = 0;
    LC_S_S_PROC_STAT.Index    = 0;
    LC_S_AUTO_SLIP_FLAG.Index = 0;
    CHK_1.checked             = true;
    LC_S_STR.Focus();   

    setTempEvnDataset();        //행사구분 행사율 데이터셋 임시지정
    setEventFlagDs();           //행사구분 행사율 데이터셋 복사        
    
    registerUsingDataset("pord117","DS_O_LIST,DS_IO_MASTER,DS_IO_MASTER1,DS_IO_DETAIL,DS_O_SKU_INFO" ); //대출입
 } 


 function gridCreate1(){
     var hdrProperies = '<FC>id=STR_NM             name="점"          width=60  align=left Edit=none </FC>'
                      + '<FC>id=SLIP_FLAG_NM       name="구분"        width=35  BgColor={decode(REJ_CAN_FLAG,1,"#C8FFFF",2,"#D2D2D2")}  align=left  Edit=none </FC>'
                      + '<FC>id=SLIP_NO            name="전표번호"    width=110  align=center Edit=none Edit=none Mask="XXXX-X-XXXXXXX" sumtext="합계"</FC>'
                      + '<FC>id=ORD_DT             name="발주일"      width=80  align=center Edit=none Mask="XXXX/XX/XX" </FC>'
                      + '<FC>id=SLIP_PROC_STAT_NM  name="전표상태"    width=80  align=left  Edit=none </FC>'
                      + '<FC>id=PUMBUN_NM          name="브랜드"      width=110  align=left Edit=none </FC>'
                      + '<FC>id=VEN_NM             name="협력사"      width=100  align=left Edit=none </FC>'
                      + '<FC>id=COST_TAMT          name="원가금액"    width=100 align=right Edit=none  sumtext=@sum </FC>'
                      + '<FC>id=SALE_TAMT          name="매가금액"    width=100 align=right Edit=none  sumtext=@sum </FC>';
                      

     initGridStyle(GR_LIST, "common", hdrProperies, false);
 }

 function gridCreate2(){
     var hdrProperies = '<FC>id={currow}          name="NO"           width=30    align=center sumtext=""</FC>'
                      + '<FC>id=SKU_CD            name="단품코드"     width=120   align=left   EditStyle=Popup sumtext="합계"</FC>'                           
                      + '<FC>id=SKU_NM            name="단품명"       width=100   align=left   Edit=none </FC>'                           
                      + '<FC>id=STYLE_CD          name="스타일"       width=90    align=left   Edit=none </FC>'
                      + '<FC>id=COLOR_CD          name="칼라"         width=35    align=center Edit=none </FC>'
                      + '<FC>id=SIZE_CD           name="사이즈"       width=40    align=center Edit=none </FC>'
                      + '<FC>id=ORD_UNIT_NM       name="단위"         width=50    align=left   Edit=none </FC>'                          
                      + '<FC>id=ORD_QTY           name="수량"         width=50    align=right  Edit=Numeric sumtext=@sum </FC>'          
                      + '<FC>id=RATE              name="목표;이익율"   width=60    align=right  Edit=Numeric </FC>'                           
                      + '<FG> name="원가 (부가세 제외)"'       
                      + '<FC>id=NEW_COST_PRC      name="단가"         width=80    align=right  Edit=Numeric </FC>'                        
                      + '<FC>id=NEW_COST_AMT      name="금액"         width=110   align=right  Edit=none sumtext=@sum </FC>'                        
                      + '</FG> '                                                    
                      + '<FG> name="매가 (부가세 포함)"'                                       
                      + '<FC>id=NEW_SALE_PRC      name="단가"         width=80    align=right  Edit=Numeric </FC>'                        
                      + '<FC>id=NEW_SALE_AMT      name="금액"         width=110   align=right  Edit=none sumtext=@sum </FC>'                        
                      + '</FG> '                                                    
                      + '<FC>id=NEW_GAP_RATE      name="차익율"       width=60    align=right  Edit=none sumtext='+strSumText+' </FC>'
                      + '<FC>id=AVG_SALE_QTY      name="평균판매량"   width=70    align=right  Edit=none sumtext=@sum </FC>'                           
                      + '<FC>id=AVG_SALE_AMT      name="평균판매액"   width=110    align=right  Edit=none sumtext=@sum </FC>'                           
                      + '<FC>id=ORD_STK_QTY       name="현재고"       width=50     align=right  Edit=none sumtext=@sum </FC>' ;   
   initGridStyle(GR_DETAIL, "common", hdrProperies, false);
 }
 /* 대출입 그리드 */
 function gridCreate3(){
     var hdrProperies = '<FC>id={currow}          name="NO"          width=30    align=center   sumtext=""</FC>'                           
			          + '<FC>id=SKU_CD            name="단품코드"     width=120    align=center EditStyle=Popup sumtext="합계"</FC>'                           
			          + '<FC>id=SKU_NM            name="단품명"       width=100   align=left    Edit=none </FC>'                           
			          + '<FC>id=STYLE_CD          name="스타일"       width=82    align=left    Edit=none </FC>'
			          + '<FC>id=COLOR_CD          name="칼라"         width=35    align=center  Edit=none </FC>'
			          + '<FC>id=SIZE_CD           name="사이즈"       width=40    align=center  Edit=none </FC>'                                               
			          + '<FC>id=ORD_UNIT_NM       name="단위"         width=50    align=left    Edit=none </FC>'
			          + '<FC>id=ORD_QTY           name="수량"         width=50    align=right   Edit=Numeric sumtext=@sum </FC>'           
                      + '<FC>id=RATE              name="목표이익율"   width=70    align=right  Edit=Numeric </FC>'                                                                      
			          + '<FC>id=NEW_COST_PRC      name="원가단가"     width=80    align=right   Edit=none </FC>'                        
			          + '<FC>id=NEW_COST_AMT      name="원가금액"     width=110   align=right   Edit=none sumtext=@sum </FC>'                                                         
			          + '<FC>id=NEW_SALE_PRC      name="매가단가"     width=80    align=right   Edit=none </FC>'                        
			          + '<FC>id=NEW_SALE_AMT      name="매가금액"     width=110   align=right   Edit=none sumtext=@sum </FC>'                                   
			          + '<FC>id=NEW_GAP_RATE      name="차익율"       width=80    align=right   Edit=none sumtext='+strSumText+' </FC>';    
     initGridStyle(GR_DETAIL1, "common", hdrProperies, false);
 }
 function gridCreate4(){
     var hdrProperies = '<FC>id={currow}          name="NO"           width=30    align=center sumtext=""</FC>'                           
			          + '<FC>id=SKU_CD            name="단품코드"     width=120    align=left  EditStyle=Popup </FC>'                           
			          + '<FC>id=SKU_NM            name="단품명"       width=100   align=left   Edit=none </FC>'                           
			          + '<FC>id=STYLE_CD          name="스타일"       width=82    align=left   Edit=none </FC>'
			          + '<FC>id=COLOR_CD          name="칼라"         width=35    align=center Edit=none </FC>'
			          + '<FC>id=SIZE_CD           name="사이즈"       width=40    align=center Edit=none </FC>'                                                    
			          + '<FC>id=ORD_UNIT_NM       name="단위"         width=50    align=left   Edit=none </FC>'
			          + '<FC>id=ORD_QTY           name="수량"         width=50   align=right   Edit=Numeric</FC>'             
                      + '<FC>id=RATE              name="목표이익율"   width=70    align=right  Edit=Numeric </FC>'                                                         
			          + '<FC>id=NEW_COST_PRC      name="원가단가"     width=80    align=right  Edit=none </FC>'                        
			          + '<FC>id=NEW_COST_AMT      name="원가금액"     width=110   align=right  Edit=none </FC>'                                                             
			          + '<FC>id=NEW_SALE_PRC      name="매가단가"     width=80    align=right  Edit=none </FC>'                        
			          + '<FC>id=NEW_SALE_AMT      name="매가금액"     width=110   align=right  Edit=none  </FC>'                                                             
			          + '<FC>id=NEW_GAP_RATE      name="차익율"       width=80    align=right  Edit=none </FC>';   
     initGridStyle(GR_DETAIL2, "common", hdrProperies, false);
 }
 function gridCreate5(){
     var hdrProperies = '<FC>id={currow}          name="NO"          width=30    align=center sumtext=""</FC>'                          
                      + '<FC>id=SKU_CD            name="단품코드"     width=120   align=left   EditStyle=Popup sumtext="합계"</FC>'                           
                      + '<FC>id=SKU_NM            name="단품명"       width=100   align=left   Edit=none </FC>'                    
                      + '<FC>id=STYLE_CD          name="스타일"       width=90    align=left   Edit=none </FC>'
                      + '<FC>id=COLOR_CD          name="칼라"         width=35    align=center Edit=none </FC>'
                      + '<FC>id=SIZE_CD           name="사이즈"       width=40    align=center Edit=none </FC>'
                      + '<FC>id=ORD_UNIT_NM       name="단위"         width=50    align=left   Edit=none </FC>'                                                     
                      + '<FC>id=ORD_QTY           name="수량"         width=50    align=right  Edit=Numeric sumtext=@sum </FC>'             
                      + '<FC>id=RATE              name="목표이익율"   width=70    align=right  Edit=Numeric </FC>'                          
                      + '<FG> name="원가 (부가세 제외)"'                                       
                      + '<FC>id=NEW_COST_PRC      name="단가"         width=80    align=right  Edit=none </FC>'                        
                      + '<FC>id=NEW_COST_AMT      name="금액"         width=110   align=right  Edit=none sumtext=@sum </FC>'                        
                      + '</FG> '                                                    
                      + '<FG> name="매가 (부가세 포함)"'                                       
                      + '<FC>id=NEW_SALE_PRC      name="단가"         width=80    align=right  Edit=none </FC>'                        
                      + '<FC>id=NEW_SALE_AMT      name="금액"         width=110   align=right  Edit=none sumtext=@sum </FC>'                        
                      + '</FG> '                                                    
                      + '<FC>id=NEW_GAP_RATE      name="차익율"       width=80    align=right  Edit=none sumtext='+strSumText+' </FC>';   
     initGridStyle(GR_DETAIL3, "common", hdrProperies, false);
 }
 function gridCreate6(){
     var hdrProperies = '<FC>id={currow}          name="NO"           width=30   align=center sumtext=""</FC>'
                      + '<FC>id=SKU_CD            name="단품코드"     width=120   align=left   EditStyle=Popup sumtext="합계"</FC>'                           
                      + '<FC>id=SKU_NM            name="단품명"       width=100   align=left   Edit=none </FC>'      
                      + '<FC>id=STYLE_CD          name="스타일"       width=90    align=left   Edit=none </FC>'
                      + '<FC>id=COLOR_CD          name="칼라"         width=35    align=center Edit=none </FC>'
                      + '<FC>id=SIZE_CD           name="사이즈"       width=40    align=center Edit=none </FC>'
                      + '<FC>id=ORD_UNIT_NM       name="단위"         width=50    align=left   Edit=none </FC>'                                                     
                      + '<FC>id=ORD_QTY           name="수량"         width=50    align=right  Edit=Numeric sumtext=@sum </FC>'                           
                      + '<FG> name="구매가"'                                       
                      + '<FC>id=OLD_SALE_PRC      name="단가"         width=80    align=right   Edit=none </FC>'                        
                      + '<FC>id=OLD_SALE_AMT      name="금액"         width=110   align=right   Edit=none sumtext=@sum </FC>'                        
                      + '</FG> '                                                    
                      + '<FG> name="신매가"'                                       
                      + '<FC>id=NEW_SALE_PRC      name="단가"         width=80    align=right   Edit=none </FC>'                        
                      + '<FC>id=NEW_SALE_AMT      name="금액"         width=110   align=right   Edit=none sumtext=@sum </FC>'                        
                      + '</FG> '                                                    
                      + '<FC>id=NEW_GAP_AMT       name="차익액"       width=80    align=right   Edit=none sumtext=@sum </FC>';   
     initGridStyle(GR_DETAIL4, "common", hdrProperies, false);
 }
 function gridCreate7(){
	 var hdrProperies = '<FC>id={currow}              name="NO"        width=30     align=center  Edit=none sumtext=""    </FC>'+ '<FC>id=PUMMOK_CD             name="품목코드"   width=75     align=left   SHOW=FALSE/FC>'
	                  + '<FC>id=SKU_CD                name="단품코드"   width=110    align=left   EditStyle=Popup sumtext="합계" </FC>'
	                  + '<FC>id=SKU_NM                name="단품명"     width=135    align=left   Edit=none </FC>'
	                  + '<FC>id=STYLE_CD              name="스타일코드" width=210     align=left  Edit=none </FC>'
	                  + '<FC>id=COLOR_CD              name="칼라"       width=60     align=left   Edit=none </FC>'
	                  + '<FC>id=SIZE_CD               name="사이즈"     width=60     align=left   Edit=none </FC>'
	                  + '<FC>id=MODEL_NO              name="모델코드"   width=80     align=left   Edit=none </FC>'
	                  + '<FC>id=ORD_UNIT_CD           name="단위코드"   width=40     align=center Edit=none SHOW=FALSE</FC>'
	                  + '<FC>id=ORD_UNIT_NM           name="단위"       width=40     align=left   Edit=none </FC>'
	                  + '<FC>id=INVOICE_QTY           name="수량"       width=40     align=rigth  Edit=Numeric sumtext=@sum </FC>'
	                  + '<FG> name="원가 (부가세 제외)"'
	                  + '<FC>id=INVOICE_UNIT_AMT      name="외화단가"   width=80     align=right  sumtext=@sum </FC>'
	                  + '<FC>id=INVOICE_KOR_UNIT_AMT  name="원화단가"   width=110     align=right  Edit=none  sumtext=@sum </FC>'
	                  + '<FC>id=INVOICE_AMT           name="외화금액"   width=80     align=right  Edit=none  sumtext=@sum </FC>'
	                  + '<FC>id=INVOICE_KOR_AMT       name="원화금액"   width=110     align=right  Edit=none  sumtext=@sum </FC>'
	                  + '</FG>'
	                  + '<FG> name="매가 (부가세 포함)"'
	                  + '<FC>id=SALE_PRC              name="단가"       width=80     align=right  Edit=Numeric sumtext=@sum </FC>'
	                  + '<FC>id=SALE_AMT              name="금액"       width=110    align=right  Edit=none    sumtext=@sum </FC></FG>'    
	                  + '<FC>id=GAP_RATE              name="차익율"     width=60     align=right  Edit=none    sumtext=@sum </FC>'    
	                  + '<FC>id=GAP_AMT               name="차익액"     width=60     align=right  Edit=none    SHOW=FALSE</FC>';                         
	
	 initGridStyle(GR_DETAIL5, "common", hdrProperies, false);
	 }
 
 function gridCreate8(){
     var hdrProperies = '<FC>id={currow}              name="NO"         width=30    align=center  sumtext=""         </FC>'
			          + '<FC>id=CHECK1                name="선택"       width=45    align=center  HeadCheckShow=true EditStyle=CheckBox</FC>'
			          + '<FC>id=PUMMOK_SRT_CD         name="단축코드"   width=55    align=center  EditStyle=Popup    </FC>'
			          + '<FC>id=PUMMOK_CD             name="품목코드"   width=75    align=center  EditStyle=none     sumtext="합계" </FC>'
			          + '<FC>id=PUMMOK_NM             name="품목명"     width=100   align=left    Edit=none                      </FC>'
			          + '<FC>id=ORD_UNIT_CD           name="단위"       width=35    align=left    Edit=none          EditStyle=Lookup  Data="DS_ORD_UNIT_CD:CODE:NAME" </FC>'
			          + '<FC>id=ORD_QTY               name="수량"     width=40    align=right   Edit=Numeric         sumtext=@sum  </FC>'
			          + '<FC>id=MG_RATE               name="마진율"     width=40    align=right   Edit=none          sumtext=@avg  show=false</FC>'
			          + '<FG> name="원가 (부가세 제외)"' 
			          + '<FC>id=NEW_COST_PRC          name="단가"       width=80    align=right   Edit=none          sumtext=@sum  </FC>'
			          + '<FC>id=NEW_COST_AMT          name="금액"       width=95    align=right   Edit=none          sumtext=@sum  </FC>'
			          + '</FG> '
			          + '<FG> name="매가 (부가세 포함)"'
			          + '<FC>id=NEW_SALE_PRC          name="단가"      width=80    align=right  Edit=Numeric      </FC>'
			          + '<FC>id=NEW_SALE_AMT          name="금액"        width=95    align=right  Edit=none         sumtext=@sum  </FC>'
			          + '</FG> '                      
			          + '<FC>id=TAG_FLAG              name="TAG구분"     width=100   align=left   Edit=none          EditStyle=Lookup   Data="DS_TAG_FLAG:CODE:NAME" </FC>'
			          + '<FC>id=TAG_PRT_OWN_FLAG      name="TAG;발행주체" width=60    align=left   Edit=none          EditStyle=Lookup   Data="DS_TAG_PRT_OWN_FLAG:CODE:NAME" </FC>'
			          + '<FC>id=NEW_GAP_RATE          name="신차익율"    width=60    align=left   Edit=none          show="false"</FC>'
			          + '<FC>id=NEW_GAP_AMT           name="신차익액"    width=80    align=left   Edit=none          show="false"</FC>';
      initGridStyle(GR_DETAIL6, "common", hdrProperies,false);
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
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-02-16
 * 개    요        : 조회시 필수 조회조건을 체크한 후 조회한다.
 * return값 : void
 */
function btn_Search() {

    switch(getTabItemSelect("TAB_MAIN")){
    //단품(매입)
    case 1:
         
        if(checkValidation("Search")){
            DS_IO_MASTER.ClearData();  
            DS_IO_DETAIL.ClearData();
            intSearchCnt = 0;
            bfListRowPosition = 0;
            getList();
            // 조회결과 Return
            setPorcCount("SELECT", GR_LIST);
            if(DS_O_LIST.CountRow <= 0){
                setMasterObject(false);
                LC_S_STR.Focus();
            }
        }
      
        break;
    case 2:
        /***********************************************************************************/
        /* 대출입조회 */ 
              
        if(checkValidation("Search")){
           DS_IO_MASTER1.ClearData();  
           DS_IO_DETAIL1.ClearData();
           DS_IO_DETAIL2.ClearData();
           intSearchCnt = 0;
           bfListRowPosition = 0;
           getList();
           // 조회결과 Return
           setPorcCount("SELECT", GR_LIST);
           if(DS_O_LIST.CountRow <= 0){
               setMasterObject(false);
               LC_S_STR.Focus();
           }
         }
        break;
    case 3:
        /***********************************************************************************/
        /* 점출입조회 */ 
                
        if(checkValidation("Search")){
            DS_IO_MASTER3.ClearData();  
            DS_IO_DETAIL3.ClearData();
            intSearchCnt = 0;
            bfListRowPosition = 0;
            getList();
            // 조회결과 Return
            setPorcCount("SELECT", GR_LIST);
            if(DS_O_LIST.CountRow <= 0){
                setMasterObject(false);
                LC_S_STR.Focus();
            }
        }
        break;  
     case 4: 
                 
         if(checkValidation("Search")){
             DS_IO_MASTER4.ClearData();  
             DS_IO_DETAIL4.ClearData();
             intSearchCnt      = 0;
             bfListRowPosition = 0;
             getList();
             // 조회결과 Return
             setPorcCount("SELECT", GR_LIST);
             if(DS_O_LIST.CountRow <= 0){
                 setMasterObject(false);
                 LC_S_STR.Focus();
             }
          }
         break;
     case 5:
         
         if(checkValidation("Search")){
             DS_IO_MASTER5.ClearData();  
             DS_IO_DETAIL5.ClearData();
             intSearchCnt = 0;
             bfListRowPosition = 0;
             getList();
             // 조회결과 Return
             setPorcCount("SELECT", GR_LIST);
             if(DS_O_LIST.CountRow <= 0){
                 setMasterObject(false);
                 LC_S_STR.Focus();
             }
         }
       
         break; 
     case 6:
         
         if(checkValidation("Search")){
             DS_IO_MASTER6.ClearData();  
             DS_IO_DETAIL6.ClearData();
             intSearchCnt = 0;
             bfListRowPosition = 0;
             getList();
             // 조회결과 Return
             setPorcCount("SELECT", GR_LIST);
             if(DS_O_LIST.CountRow <= 0){
                 setMasterObject(false);
                 LC_S_STR.Focus();
             }
         }
       
         break;  
     }
}


/**
 * btn_New()
 */
function btn_New() {
}

/**
 * btn_Delete()
*/
function btn_Delete() {
 
}

/**
 * btn_Save()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-02-16
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자     : FKL
 * 작 성 일     : 2010-12-12
 * 개    요        : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자     : FKL
 * 작 성 일     : 2010-02-14
 * 개    요        : 페이지 프린트 인쇄
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
 * setMasterObject(flag)
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-03-08
 * 개    요        : 마스터 Object의 활성화/비활성화를 제어한다.
 * return값 : void
 */
function setMasterObject(flag){

    enableControl(LC_STR            , flag);
    enableControl(EM_PUMBUN_CD      , flag);
    RD_SLIP_FLAG.Enable             = flag;
    enableControl(LC_AFT_ORD_FLAG   , flag);
    enableControl(EM_ORD_DT         , flag);
    enableControl(EM_DELI_DT        , flag);
    enableControl(EM_PRC_APP_DT     , flag);
    enableControl(EM_VEN_CD         , flag);
    enableControl(EM_REMARK         , flag);
    enableControl(LC_PAY_COND       , flag);
    enableControl(LC_STR1           , flag);
    enableControl(LC_AFT_ORD_FLAG1  , flag);
    enableControl(LC_STR3           , flag);
    enableControl(LC_P_STR3         , flag);
    enableControl(LC_AFT_ORD_FLAG3  , flag);
    
    enableControl(LC_STR4           , flag);
    enableControl(LC_AFT_ORD_FLAG4  , flag);
    enableControl(LC_INC_FLAG4      , flag);
    enableControl(LC_OLD_EVENT_CD4  , flag);
    enableControl(LC_NEW_EVENT_CD4  , flag);
}  


/**
 * checkValidation()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-02-15
 * 개    요        : 조회조건 값 체크 
 * return값 : void
 */
function checkValidation(Gubun) {
     
     var messageCode = "USER-1001";
     
     //조회버튼 클릭시 Validation Check
     if(Gubun == "Search"){   
         if(LC_S_STR.Text.length == 0){                                          // 점
               showMessage(EXCLAMATION, OK, messageCode, "점");
               LC_S_STR.Focus();
               return false;
         }  
         /*
         if(LC_S_BUMUN.Text.length == 0){                                        // 팀
             showMessage(EXCLAMATION, OK, messageCode, "팀");
             LC_S_BUMUN.Focus();
             return false;
         }  
         if(LC_S_TEAM.Text.length == 0){                                         // 파트
             showMessage(EXCLAMATION, OK, messageCode, "파트");
             LC_S_TEAM.Focus();
             return false;
         }  
         if(LC_S_PC.Text.length == 0){                                           // PC
             showMessage(EXCLAMATION, OK, messageCode, "PC");
             LC_S_PC.Focus();
             return false;
         }  
         */
         if(LC_S_GJDATE_TYPE.Text.length == 0){                                  // 기준일
             showMessage(EXCLAMATION, OK, messageCode, "기준일");
             LC_S_GJDATE_TYPE.Focus();
             return false;
         }
         if(EM_S_START_DT.Text.length == 0){                              // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1002", "조회시작일");
             EM_S_START_DT.Focus();
             return false;
        }
         if(EM_S_END_DT.Text.length == 0){                              // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1002", "조회종료일");
             EM_S_END_DT.Focus();
             return false;
        }
         if(EM_S_START_DT.Text > EM_S_END_DT.Text){                              // 조회일 정합성
              showMessage(EXCLAMATION, OK, "USER-1015");
              EM_S_START_DT.Focus();
              return false;
         }
     }
     return true; 
}

/**
* getList()
* 작 성 자 : 김경은
* 작 성 일 : 2010-02-16
* 개    요 :  마스터 리스트 조회
* return값 : void
*/
function getList(){
   // 조회조건 셋팅
   var strStrCd         = LC_S_STR.BindColVal;                   // 점
   var strBumun         = LC_S_BUMUN.BindColVal;                 // 팀
   var strTeam          = LC_S_TEAM.BindColVal;                  // 파트
   var strPc            = LC_S_PC.BindColVal;                    // PC
   var strOrgCd         = strStrCd + strBumun + strTeam + strPc; // 조직   
   var strGJdateType    = LC_S_GJDATE_TYPE.BindColVal;           // 기준일
   var strStartDt       = EM_S_START_DT.Text;                    // 조회기간1
   var strEndDt         = EM_S_END_DT.Text;                      // 조회기간2
   var strProcStat      = LC_S_S_PROC_STAT.BindColVal;           // 전표상태
   var strPumbun        = EM_S_PB_CD.Text;                       // 브랜드
   var strBizType       = EM_BIZ_TYPE.Text;                      // 거래형태
   var strVen           = EM_S_VEN_CD.Text;                      // 협력사
   var strSlipNo        = EM_S_SLIP_NO.Text;                     // 전표번호
   var autoSlipFlag     = LC_S_AUTO_SLIP_FLAG.BindColVal;        // 자동전표구분
  // var strSlip_flag     = RD_S_SLIP_FLAG.CodeValue;              // 전표구분 
  
  
   var slipFlagList = setSlipFlag();   
   if(!slipFlagList){ 
       return;
   }
  
   var goTo       = "getList" ;    
   var action     = "O";     
   var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)     
                   + "&strBumun="+encodeURIComponent(strBumun)     
                   + "&strTeam="+encodeURIComponent(strTeam)      
                   + "&strPc="+encodeURIComponent(strPc)     
                   + "&strOrgCd="+encodeURIComponent(strOrgCd)
                   + "&strGJdateType="+encodeURIComponent(strGJdateType)
                   + "&strStartDt="+encodeURIComponent(strStartDt)   
                   + "&strEndDt="+encodeURIComponent(strEndDt)     
                   + "&strProcStat="+encodeURIComponent(strProcStat)  
                   + "&strPumbun="+encodeURIComponent(strPumbun)    
                   + "&strBizType="+encodeURIComponent(strBizType)
                   + "&strVen="+encodeURIComponent(strVen)  
                   + "&slipFlagList="+encodeURIComponent(slipFlagList)
                   + "&strSlipNo="+encodeURIComponent(strSlipNo)
                   + "&autoSlipFlag="+encodeURIComponent(autoSlipFlag);    
                 //  + "&strSlip_flag="+strSlip_flag; 
   TR_L_MAIN.Action  = "/dps/pord117.po?goTo="+goTo+parameters;  
   TR_L_MAIN.KeyValue= "SERVLET("+action+":DS_O_LIST=DS_O_LIST)"; //조회는 O
   TR_L_MAIN.Post();

}

/**
 * setSlipFlag()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-04-08
 * 개    요 :  전표구분에 따른 조회조건 셋팅
 * return값 : 조회조건 문자열로 리턴
 */
function setSlipFlag(){

    var strSlipIssueCnt = "A.SLIP_FLAG IN (";
    
    if(CHK_1.checked){
        strSlipIssueCnt += "'A','B','C','D','E','F','G')";
    }else{      
        if(CHK_2.checked){
            strSlipIssueCnt += "'A'," ;
        } 
        
        if(CHK_3.checked){
            strSlipIssueCnt += "'B'," ;             
        }
        
        // 20120518 * DHL * 마리오 주석처리 START        
        if(CHK_4.checked){
            strSlipIssueCnt += "'C','D'," ;             
        }
        
        if(CHK_5.checked){
            strSlipIssueCnt += "'E','F'," ;             
        }
                 
        if(CHK_6.checked){
            strSlipIssueCnt += "'G'," ;             
        }
        // 20120518 * DHL * 마리오 주석처리 END 
        
        strSlipIssueCnt = strSlipIssueCnt.substring(0, strSlipIssueCnt.length-1);
        strSlipIssueCnt += ")";
    }     
        
    // 20120518 * DHL * 마리오 주석처리 START
    // 원본
    if(CHK_1.checked == false && CHK_2.checked == false && CHK_3.checked == false 
    && CHK_4.checked == false && CHK_5.checked == false && CHK_6.checked == false){
    // 수정
    //if(CHK_1.checked == false && CHK_2.checked == false && CHK_3.checked == false){
    // 20120518 * DHL * 마리오 주석처리 END
//      alert();
        showMessage(StopSign, OK, "GAUCE-1005", "전표구분");
        CHK_1.checked  = true;
//      var obj = document.getElementById("CHK_1");         
//      setTimeout("obj.Focus()",50);
        
        DS_O_LIST.ClearData();
        return false;
    }              
    return strSlipIssueCnt;
}

/**
 * checkSlipFlag()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-04-08
 * 개    요 :  전표구분 선택시 체크 
 * return값 : 조회조건 문자열로 리턴
 */
function checkSlipFlag (checkId){
     
    if(checkId == CHK_1){
        CHK_1.checked = true;
        CHK_2.checked = false;
        CHK_3.checked = false;
        
        // 20120518 * DHL * 마리오 주석처리 START
        CHK_4.checked = false;
        CHK_5.checked = false;
        CHK_6.checked = false;
        // 20120518 * DHL * 마리오 주석처리 END
        
    }else{
        CHK_1.checked = false;
    }
}

/**
* getDetail()
* 작 성 자 : 김경은
* 작 성 일 : 2010-02-18
* 개    요 :  상세조회
* return값 : void
*/
function getDetail(){
   var strVenCd     = "";
   var strStrCd     = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"STR_CD");
   var strSlipNo    = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_NO");
   
   var goTo         = "getDetail" ;    
   var action       = "O";     
   var parameters   = "&strStrCd=" +encodeURIComponent(strStrCd)+
                      "&strSlipNo="+encodeURIComponent(strSlipNo);
   
   TR_MAIN.Action="/dps/pord117.po?goTo="+goTo+parameters;  
   TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER,"+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
   TR_MAIN.Post();

   strVenCd  = EM_VEN_CD.Text;
   // 협력사별 반올림 구분을 받는다
   roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, strStrCd, strVenCd);
   
   GR_DETAIL.ColumnProp('SEL','HeadCheck')= "FALSE";
   setMasterObject(false);

}

/**
* getDetail()
* 작 성 자 : 김경은
* 작 성 일 : 2010-02-18
* 개    요 :  대출입상세조회
* return값 : void
*/
function getDetail1(){
       var strStrCd    = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"STR_CD");
       var strSlipNo   = "";
       var strPSlipNo  = "";
       var strSlipFlag = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_FLAG");
       
       if(strSlipFlag == 'C'){
           strSlipNo  = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_NO");
           strPSlipNo = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"P_SLIP_NO");
       }else{
           strSlipNo  = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"P_SLIP_NO");
           strPSlipNo = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_NO");
       }

       var goTo       = "getDetail1" ;    
       var action     = "O";     
       var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                        + "&strSlipNo="+encodeURIComponent(strSlipNo)
                        + "&strPSlipNo="+encodeURIComponent(strPSlipNo)
                        + "&strSlipFlag="+encodeURIComponent(strSlipFlag);
       
       TR_MAIN.Action="/dps/pord117.po?goTo="+goTo+parameters;  
       TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER1=DS_IO_MASTER1,"+action+":DS_IO_DETAIL1=DS_IO_DETAIL1,"+action+":DS_IO_DETAIL2=DS_IO_DETAIL2)"; //조회는 O
       TR_MAIN.Post();
       
       strVen  = DS_IO_MASTER1.NameValue(DS_IO_MASTER1.RowPosition, "VEN_CD");            // 대출협력사코드
       strPVen = DS_IO_MASTER1.NameValue(DS_IO_MASTER1.RowPosition, "P_VEN_CD");          // 대입협력사코드

       // 협력사별 반올림 구분을 받는다
       roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, strStrCd, strVen);
       pRoundFlag = getVenRoundFlag("DS_O_RESULT", strToday, strStrCd, strPVen);
   
    }
/**
* getDetai3()
* 작 성 자 : 김경은
* 작 성 일 : 2010-04-04
* 개    요 :  점출입 상세조회
* return값 : void
*/
function getDetail3(){
   var strVenCd     = "";
   var strSlipFlag  = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_FLAG");
   var strStrCd     = "";
   var strPStrCd    = "";
   var strSlipNo    = "";
   var strPSlipNo   = "";
   strStrCd   = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"STR_CD");
   strSlipNo  = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_NO");
   
   if(DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_FLAG") == 'E'){
       strPStrCd  = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"P_STR_CD");
       strPSlipNo = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"P_SLIP_NO");
   }else{
       strPStrCd  = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"STR_CD");
       strPSlipNo = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_NO");
   }

   var goTo       = "getDetail3" ;    
   var action     = "O";     
   var parameters = "&strSlipFlag="+encodeURIComponent(strSlipFlag)
				   + "&strStrCd="+encodeURIComponent(strStrCd)
				   + "&strSlipNo="+encodeURIComponent(strSlipNo)
				   + "&strPStrCd="+encodeURIComponent(strPStrCd)
				   + "&strPSlipNo="+encodeURIComponent(strPSlipNo);                    
   
   TR_MAIN.Action="/dps/pord117.po?goTo="+goTo+parameters;  
   TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER3=DS_IO_MASTER3,"+action+":DS_IO_DETAIL3=DS_IO_DETAIL3)"; //조회는 O
   TR_MAIN.Post();
   
   strStyleType = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STYLE_TYPE");
   
   strVenCd  = EM_VEN_CD.Text;
   // 협력사별 반올림 구분을 받는다
   roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, strStrCd, strVenCd);
    
}   
/**
* getDetail4()
* 작 성 자 : 김경은
* 작 성 일 : 2010-03-28
* 개    요 :  매가인상하 상세조회
* return값 : void
*/
function getDetail4(){
     
   var strVenCd     = "";
   var strStrCd     = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"STR_CD");
   var strSlipNo    = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_NO");
   var strPumbunCd    = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"PUMBUN_CD");
   var strOldPrcAppDt = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"OLD_PRC_APP_DT");
   var strNewPrcAppDt = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"NEW_PRC_APP_DT");
   
   if(DS_O_LIST.RowPosition >= 1){
       getEventCode("DS_O_OLD_EVENT_CD", strStrCd, strPumbunCd, strOldPrcAppDt, "N");     // 구행사코드
       getEventCode("DS_O_NEW_EVENT_CD", strStrCd, strPumbunCd, strNewPrcAppDt, "N");     // 신행사코드
   }
   
   
   var goTo         = "getDetail4" ;    
   var action       = "O";     
   var parameters   = "&strStrCd="+encodeURIComponent(strStrCd)+
                      "&strSlipNo="+encodeURIComponent(strSlipNo);
   
   TR_MAIN.Action="/dps/pord117.po?goTo="+goTo+parameters;  
   TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER4=DS_IO_MASTER4,"+action+":DS_IO_DETAIL4=DS_IO_DETAIL4)"; //조회는 O
   TR_MAIN.Post();
   
   strStyleType = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STYLE_TYPE");
   
   strVenCd  = EM_VEN_CD.Text;
   // 협력사별 반올림 구분을 받는다
   roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, strStrCd, strVenCd);
   
}

/**
 * getMaster()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-107
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
 function getMaster5(){    
     
   // 조회조건 셋팅
   var strStrCd     = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "STR_CD");        // 점
   var strSlipNo    = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_NO");
   
  /* var strInvoiceYm       = DS_LIST.NameValue(DS_LIST.RowPosition, "INVOICE_YM");      // INVOICE_YM
   var strInvoiceSeqNo    = DS_LIST.NameValue(DS_LIST.RowPosition, "INVOICE_SEQ_NO");  // INVOICE_SEQ_NO */
   
   var goTo       = "getMaster5" ;    
   var action     = "O";     
   var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)   
                   + "&strSlipNo="+encodeURIComponent(strSlipNo)
                   ;  
   TR_S_MAIN.Action="/dps/pord117.po?goTo="+goTo+parameters;  
   TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER5=DS_IO_MASTER5)"; //조회는 O
   TR_S_MAIN.Post();       
 }

/**
* getDetail5()
* 작 성 자 : 김경은
* 작 성 일 : 2010-03-28
* 개    요 :  수입디테일
* return값 : void
*/

function getDetail5(){
    
     // 조회조건 셋팅
     var strStrCd           = DS_IO_MASTER5.NameValue(DS_IO_MASTER5.RowPosition, "STR_CD");        // 점
     var strInvoiceYm       = DS_IO_MASTER5.NameValue(DS_IO_MASTER5.RowPosition, "INVOICE_YM");      // INVOICE_YM
     var strInvoiceSeqNo    = DS_IO_MASTER5.NameValue(DS_IO_MASTER5.RowPosition, "INVOICE_SEQ_NO");  // INVOICE_SEQ_NO
    
     var goTo       = "getDetail5" ;    
     var action     = "O";     
     var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)   
                     + "&strInvoiceYm="+encodeURIComponent(strInvoiceYm)
                     + "&strInvoiceSeqNo="+encodeURIComponent(strInvoiceSeqNo);  
     TR_S_MAIN.Action="/dps/pord117.po?goTo="+goTo+parameters;  
     TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL5=DS_IO_DETAIL5)"; //조회는 O
     TR_S_MAIN.Post();
 }
/**
 * getMaster()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-15
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
 function getMaster6(){

        var strStrCd  = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"STR_CD");
        var strSlipNo = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_NO");
        var strDatasetId = "DS_O_RESULT";
        
        var goTo       = "getMaster6" ;    
        var action     = "O";     
        var parameters = "&strStrCd="+encodeURIComponent(strStrCd)+
                         "&strSlipNo="+encodeURIComponent(strSlipNo);
        
        TR_S_MAIN.Action="/dps/pord117.po?goTo="+goTo+parameters;  
        TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER6=DS_IO_MASTER6)"; //조회는 O
        TR_S_MAIN.Post();

 }

 /**
 * getDetail()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-15
 * 개    요 :  디테일 리스트 조회
 * return값 : void
 */
 function getDetail6(){

    var strStrCd  = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"STR_CD");
    var strSlipNo = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_NO");
    var strDatasetId = "DS_O_RESULT";
      
    var goTo       = "getDetail6" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)+
                     "&strSlipNo="+encodeURIComponent(strSlipNo);
    
    TR_S_MAIN.Action="/dps/pord117.po?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL6=DS_IO_DETAIL6)"; //조회는 O
    TR_S_MAIN.Post();
    
    // 협력사별 반올림 구분을 받는다
 //   roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, strStrCd, strVenCd);

//    alert("roundFlag::" + roundFlag);
    // 협력사별 반올림 구분을 받는다
//    getVenRoundFlag(strDatasetId, strToday, strStrCd, strVenCd);
 }


/**
* closeCheck()
* 작 성 자 : 김경은
* 작 성 일 : 2010-03-10
* 개    요    : 저장시 일마감체크를 한다.
* return값 : void
*/
function closeCheck(){
     var strStrCd         = LC_STR.BindColVal;      // 점
     var strCloseDt       = EM_ORD_DT.Text;         // 마감체크일자
     var strCloseTaskFlag = "PORD";                 // 업무구분(매입월마감)
     var strCloseUnitFlag = "42";                   // 단위업무
     var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
     var strCloseFlag     = "M";                    // 마감구분(월마감:M)
    
     var closeFlag = getCloseCheck( "DS_O_RESULT", strStrCd , strCloseDt , strCloseTaskFlag 
                                   , strCloseUnitFlag , strCloseAcntFlag , strCloseFlag);
     
     if(closeFlag == "TRUE"){
         showMessage(EXCLAMATION, OK, "USER-1068", "매입월","발주매입");
         return false;
     }else{
         return true;
     } 
     return true;
}

 /**
  * getVenInfo(code, name, btnFlag)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-03-08
  * 개    요 :  브랜드에 따른 협력사 팝업
  * return값 : void
  */
 function getVenInfo(code, name, btnFlag){
     var strStrCd = "";
     if(code.id == "EM_S_VEN_CD")
          strStrCd        = LC_S_STR.BindColVal;  
     else
          strStrCd        = LC_STR.BindColVal;  

     var strUseYn        = "Y";                                                      // 사용여부
     var strPumBunType   = "";                                                      // 브랜드유형
     var strBizType      = "";                                                       // 거래형태
     var strMcMiGbn      = "1";                                                      // 매출처/매입처구분
     var strBizFlag      = "";                                                       // 거래구분
     
     if(!btnFlag){
         var rtnMap = setVenNmWithoutPop( "DS_O_RESULT", code, name, "1"
                 ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                 ,strBizFlag);
     }else{
         var rtnMap = venPop(code, name
                            ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                            ,strBizFlag);
     }
     if(code.id == "EM_VEN_CD"){
         // 협력사별 반올림 구분을 받는다
         roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, LC_STR.BindColVal, EM_VEN_CD.Text);
     }
 }

 /**
  * setVenNmWithoutPopCall(code,name)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-03-08
  * 개    요 :  협력사 자동세팅
  * return값 : void
  */
 function setVenNmWithoutPopCall(code, name){
     var strStrCd = "";
     if(code.id == "EM_S_VEN_CD")
          strStrCd        = LC_S_STR.BindColVal;  
     else
          strStrCd        = LC_STR.BindColVal;  

     var strUseYn        = "Y";                                                      // 사용여부
     var strPumBunType   = "";                                                      // 브랜드유형
     var strBizType      = "";                                                       // 거래형태
     var strMcMiGbn      = "1";                                                      // 매출처/매입처구분
     var strBizFlag      = "";                                                       // 거래구분
     

     var rtnMap = setVenNmWithoutPop( "DS_O_RESULT", code, name, "1"
                                     ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                                     ,strBizFlag);
    
     if(code.id == "EM_VEN_CD"){
         // 협력사별 반올림 구분을 받는다
         roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, LC_STR.BindColVal, EM_VEN_CD.Text);
     }
 }
 
 /**
  * searchPumbunPop()
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-03-10
  * 개    요    : 조회조건 브랜드팝업
  *          btnFlag : true(팝업버튼클릭) 
  * return값 : void
  */
  function searchPumbunPop(btnFlag){   
      var tmpOrgCd        = LC_S_STR.BindColVal + LC_S_BUMUN.BindColVal + LC_S_TEAM.BindColVal + LC_S_PC.BindColVal;
      var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
      var strStrCd        = LC_S_STR.BindColVal;                                       // 점
      var strOrgCd        = replaceStr(tmpOrgCd,"%","00")+"00";                        // 조직코드
      var strVenCd        = "";                                                        // 협력사
      var strBuyerCd      = "";                                                        // 바이어
      var strPumbunType   = "";                                                       // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "";                                                        // 단품구분(1:단품)
      var strSkuType      = "";                                                        // 단품종류(1:규격단품)
      var strItgOrdFlag   = "";                                                        // 통합발주여부
      var strBizType      = "";                                                        // 거래형태(1:직매입) 
      var strSaleBuyFlag  = "";                                                        // 판매분매입구분

      if(!btnFlag){
            setStrPbnNmWithoutPop( "DS_O_RESULT", EM_S_PB_CD, EM_S_PB_NM, "Y", "1"
                                  , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                  , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                  , strBizType,strSaleBuyFlag);           
      }else {       
          
         var rtnMap = strPbnPop( EM_S_PB_CD, EM_S_PB_NM, 'Y'
                                , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                , strBizType,strSaleBuyFlag);
      }
  }
 
 /**
  * clearDataSetRow(DataSet)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-03-08
  * 개    요 : 선택 로우의 데이터를 Clear한다.
  * 사용방법 : clearDataSetRow(DS_MASTER);
  **/
 function clearDataSetRow(DataSet){
     var intToColCnt       = DataSet.CountColumn;       // 대상 데이터셋 컬럼수
     var strColNM          = "";                        // 원본 데이터셋 컬럼명
     for(var i = 1; i <= intToColCnt; i++){
         strColNM = DataSet.ColumnID(i);
         DataSet.NameValue(DataSet.RowPosition, strColNM) = ""; 
     }
 }

  /**
  * setTempEvnDataset()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-17
  * 개    요    : 행사구분, 행사율에 적용할 데이터셋을 임시로 지정
  * return값 : void
  */
  function setTempEvnDataset(){
      for(var i = 0; i < 100; i++){
          DS_SETEVNFLAG.Addrow();
          if(i < 10){
              DS_SETEVNFLAG.NameValue(i+1,"EVENT_FLAG") = '0' + i;
              DS_SETEVNFLAG.NameValue(i+1,"EVENT_FLAG_NM") = '0' + i;
          }else{
              DS_SETEVNFLAG.NameValue(i+1,"EVENT_FLAG") = i;    
              DS_SETEVNFLAG.NameValue(i+1,"EVENT_FLAG_NM") = i;       
          }
      }   
  }
 
  /**
  * setEventFlagDs()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-17
  * 개    요    : 행사구분 데이터셋 복사
  * return값 : void
  */
  
  function setEventFlagDs(){

      DS_EVENT_FLAG.ClearData();         //복사될 데이터셋 초기화  
      DS_EVENT_RATE.ClearData();         //복사될 데이터셋 초기화  
      var setEvnFlag = DS_SETEVNFLAG.ExportData(1,DS_SETEVNFLAG.CountRow, true ); 
      DS_EVENT_FLAG.ImportData(setEvnFlag);
      DS_EVENT_RATE.ImportData(setEvnFlag);      
//      alert("DS_EVENT_FLAG = "+ DS_EVENT_FLAG.CountRow); 
//      alert("DS_EVENT_RATE = "+ DS_EVENT_RATE.CountRow);      
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
<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_L_MAIN event=onSuccess>
    for(i=0;i<TR_L_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_L_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_S_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_L_MAIN event=onFail>
    trFailed(TR_L_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--  ===================DS_O_LIST============================ -->
<script language=JavaScript for=DS_O_LIST event=CanRowPosChange(row)>
</script>

<script language=JavaScript for=DS_O_LIST event=onRowPosChanged(row)>

    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        var strSlipNo       = DS_O_LIST.NameValue(row, "SLIP_NO");          // 발주번호
        var strSlipProcStat = DS_O_LIST.NameValue(row, "SLIP_PROC_STAT");   // 전표상태
        var strSkuType      = DS_O_LIST.NameValue(row, "SKU_TYPE");         // 단품종류(1,규격..)
        var strSlipflag     = DS_O_LIST.NameValue(row, "SLIP_FLAG");        // 전표구분
        var strImportFlag   = DS_O_LIST.NameValue(row, "IMPORT_FLAG");      // 수입구분
        var strSkuFlag      = DS_O_LIST.NameValue(row, "SKU_FLAG");         // '1':단품, '2':품목(비단품)
        var strStyleType    = DS_O_LIST.NameValue(row, "STYLE_TYPE");       // '1':단품, '2':품목(비단품)
        
        //alert("strStyleType");
        //setTabItemIndex( TabDivID, Index)
        switch(strSlipflag){
           case 'A':
        	   if(strSkuFlag == '1'){
        		  if(strImportFlag == '1'){ 
                     setTabItemIndex('TAB_MAIN',5);
                  }else{
                       setTabItemIndex('TAB_MAIN',1); 
                  }  
        	   }else if(strSkuFlag == '2'){
        		   setTabItemIndex('TAB_MAIN',6); 
        	   }
               break;
               
           case 'B': 
        	   if(strSkuFlag == '1'){
                  setTabItemIndex('TAB_MAIN',1); 
               }else if(strSkuFlag == '2'){
                    setTabItemIndex('TAB_MAIN',6); 
               }
               break;
           case 'C': 
               setTabItemIndex('TAB_MAIN',2);  
               break; 
           case 'E': 
               setTabItemIndex('TAB_MAIN',3);  
               break; 
           case 'G': 
               setTabItemIndex('TAB_MAIN',4);  
               break;  
               
        }
        if(strSlipNo != ""){
            switch(getTabItemSelect("TAB_MAIN")){
               case 1:
                     getDetail();
                      if(intSearchCnt == 0){
                         intSearchCnt++;
                      }else
                          setPorcCount("SELECT", DS_IO_DETAIL.CountRow);
                      break;
                case 2:
                      getDetail1();
                      if(intSearchCnt == 0){
                         intSearchCnt++;
                      }else
                          setPorcCount("SELECT", DS_IO_DETAIL1.CountRow);
                      break;
                case 3:
                    getDetail3();
                    if(intSearchCnt == 0){
                       intSearchCnt++;
                    }else
                        setPorcCount("SELECT", DS_IO_DETAIL3.CountRow);
                    break;
                case 4:
                    getDetail4();
                    if(intSearchCnt == 0){
                       intSearchCnt++;
                    }else
                        setPorcCount("SELECT", DS_IO_DETAIL4.CountRow);
                    break;  
                case 5:
                	getMaster5();
                    getDetail5();
                    if(intSearchCnt == 0){
                       intSearchCnt++;
                    }else
                        setPorcCount("SELECT", DS_IO_DETAIL5.CountRow);
                    break;
                case 6:
                    getMaster6();
                    getDetail6();
                    if(intSearchCnt == 0){
                       intSearchCnt++;
                    }else
                        setPorcCount("SELECT", DS_IO_DETAIL6.CountRow);
                    break;      
            }
        }
        if (strSkuType == '1'){
            switch(getTabItemSelect("TAB_MAIN")){
            case 1:
               //매입반품               
               GR_DETAIL.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
               GR_DETAIL.ColumnProp("STYLE_CD", "Show") = "false";     /* 스타일 */
               GR_DETAIL.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */
               GR_DETAIL.ColumnProp("AVG_SALE_QTY", "Show") = "true";  /* 평균판매량 */
               GR_DETAIL.ColumnProp("AVG_SALE_AMT", "Show") = "true";  /* 평균판매액 */
               GR_DETAIL.ColumnProp("ORD_STK_QTY", "Show") = "true";   /* 현재고 */
               GR_DETAIL.ColumnProp("RATE", "Show") = "false";         /* 목표이익율 */
               break;
            case 2:
               //대출입
               GR_DETAIL1.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
               GR_DETAIL1.ColumnProp("STYLE_CD", "Show") = "false";     /* 스타일 */
               GR_DETAIL1.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */
               GR_DETAIL2.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
               GR_DETAIL2.ColumnProp("STYLE_CD", "Show") = "false";     /* 스타일 */
               GR_DETAIL2.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */
               GR_DETAIL2.ColumnProp("RATE", "Show") = "false";         /* 목표이익율 */
               break;
            case 3:
                //점출입
               GR_DETAIL3.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
               GR_DETAIL3.ColumnProp("STYLE_CD", "Show") = "false";     /* 스타일 */
               GR_DETAIL3.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */
               GR_DETAIL3.ColumnProp("RATE", "Show") = "false";         /* 목표이익율 */
               break; 
            case 4:
                //매가인상하
               GR_DETAIL4.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
               GR_DETAIL4.ColumnProp("STYLE_CD", "Show") = "false";     /* 스타일 */
               GR_DETAIL4.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */
               break;
            case 5:
                //수입
               GR_DETAIL5.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
               GR_DETAIL5.ColumnProp("STYLE_CD", "Show") = "false";     /* 스타일 */
               GR_DETAIL5.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */
               break;
               
            }
        }else if(strSkuType == '2'){
            switch(getTabItemSelect("TAB_MAIN")){
            case 1:
               //매입반품
               GR_DETAIL.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
               GR_DETAIL.ColumnProp("STYLE_CD", "Show") = "false";     /* 스타일 */
               GR_DETAIL.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */
               GR_DETAIL.ColumnProp("AVG_SALE_QTY", "Show") = "false"; /* 평균판매량 */
               GR_DETAIL.ColumnProp("AVG_SALE_AMT", "Show") = "false"; /* 평균판매액 */
               GR_DETAIL.ColumnProp("ORD_STK_QTY", "Show") = "false";  /* 현재고 */
               GR_DETAIL.ColumnProp("RATE", "Show") = "true";          /* 목표이익율 */
               break;
            case 2:
               //대출입
               GR_DETAIL1.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
               GR_DETAIL1.ColumnProp("STYLE_CD", "Show") = "false";     /* 스타일 */
               GR_DETAIL1.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */
               GR_DETAIL2.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
               GR_DETAIL2.ColumnProp("STYLE_CD", "Show") = "false";     /* 스타일 */
               GR_DETAIL2.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */
               GR_DETAIL1.ColumnProp("RATE", "Show") = "true";          /* 목표이익율 */
               GR_DETAIL2.ColumnProp("RATE", "Show") = "true";          /* 목표이익율 */
               break;
            case 3:
                //점출입
               GR_DETAIL3.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
               GR_DETAIL3.ColumnProp("STYLE_CD", "Show") = "false";     /* 스타일 */
               GR_DETAIL3.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */
               GR_DETAIL3.ColumnProp("RATE", "Show") = "true";          /* 목표이익율 */
               break;
            case 4:
                break;
            case 5:
                //수입
               GR_DETAIL5.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
               GR_DETAIL5.ColumnProp("STYLE_CD", "Show") = "false";     /* 스타일 */
               GR_DETAIL5.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */
               break;      
             }
        }else{
            switch(getTabItemSelect("TAB_MAIN")){
            case 1:
               //매입반품
               if(strStyleType == "1"){
                   GR_DETAIL.ColumnProp("SIZE_CD", "Show") = "true";      /* 사이즈 */
                   GR_DETAIL.ColumnProp("STYLE_CD", "Show") = "true";     /* 스타일 */
                   GR_DETAIL.ColumnProp("COLOR_CD", "Show") = "true";     /* 칼라 */         	   
               }else{
                   GR_DETAIL.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
                   GR_DETAIL.ColumnProp("STYLE_CD", "Show") = "true";     /* 스타일 */
                   GR_DETAIL.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */            	   
               }
               GR_DETAIL.ColumnProp("AVG_SALE_QTY", "Show") = "true"; /* 평균판매량 */
               GR_DETAIL.ColumnProp("AVG_SALE_AMT", "Show") = "true"; /* 평균판매액 */
               GR_DETAIL.ColumnProp("ORD_STK_QTY", "Show") = "true";  /* 현재고 */
               GR_DETAIL.ColumnProp("RATE", "Show") = "false";         /* 목표이익율 */   
               break;
            case 2:
                //대출입
               GR_DETAIL1.ColumnProp("RATE", "Show") = "false";         /* 목표이익율 */  
               GR_DETAIL2.ColumnProp("RATE", "Show") = "false";         /* 목표이익율 */   
           	   if(strSlipflag == "C"){
           	       strCStyleType = DS_IO_MASTER1.NameValue(DS_IO_MASTER1.RowPosition,"STYLE_TYPE1");
           	       strDStyleType = DS_IO_MASTER1.NameValue(DS_IO_MASTER1.RowPosition,"STYLE_TYPE2");
           	   }else{
           	       strCStyleType = DS_IO_MASTER1.NameValue(DS_IO_MASTER1.RowPosition,"STYLE_TYPE2")
           	       strDStyleType = DS_IO_MASTER1.NameValue(DS_IO_MASTER1.RowPosition,"STYLE_TYPE1");
           	   }

           	   if(strCStyleType == "1"){
                   GR_DETAIL1.ColumnProp("STYLE_CD", "Show") = "True";     /* 스타일 */
           	       GR_DETAIL1.ColumnProp("COLOR_CD", "SHOW") = "True";
           	       GR_DETAIL1.ColumnProp("SIZE_CD" , "SHOW") = "True";
           	   }else if(strCStyleType == "2"){
                   GR_DETAIL1.ColumnProp("STYLE_CD", "Show") = "True";     /* 스타일 */
           	       GR_DETAIL1.ColumnProp("COLOR_CD", "SHOW") = "False";
           	       GR_DETAIL1.ColumnProp("SIZE_CD" , "SHOW") = "False";
           	   }
           	   
           	   if(strDStyleType == "1"){
                   GR_DETAIL2.ColumnProp("STYLE_CD", "Show") = "True";     /* 스타일 */
           	       GR_DETAIL2.ColumnProp("COLOR_CD", "SHOW") = "True";
           	       GR_DETAIL2.ColumnProp("SIZE_CD" , "SHOW") = "True";
           	   }else if(strDStyleType == "2"){
                   GR_DETAIL2.ColumnProp("STYLE_CD", "Show") = "True";     /* 스타일 */
           	       GR_DETAIL2.ColumnProp("COLOR_CD", "SHOW") = "False";
           	       GR_DETAIL2.ColumnProp("SIZE_CD" , "SHOW") = "False";
           	   }           	   
               break;
            case 3:
                //점출입
                GR_DETAIL3.ColumnProp("RATE", "Show") = "false";         /* 목표이익율 */   
                if(strStyleType == "1"){
                    GR_DETAIL3.ColumnProp("SIZE_CD", "Show") = "true";      /* 사이즈 */
                    GR_DETAIL3.ColumnProp("STYLE_CD", "Show") = "true";     /* 스타일 */
                    GR_DETAIL3.ColumnProp("COLOR_CD", "Show") = "true";     /* 칼라 */                 
                }else{
                    GR_DETAIL3.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
                    GR_DETAIL3.ColumnProp("STYLE_CD", "Show") = "true";     /* 스타일 */
                    GR_DETAIL3.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */                
                }
               break; 
            case 4:
                //매가인상하
                if(strStyleType == "1"){
                    GR_DETAIL4.ColumnProp("SIZE_CD", "Show") = "true";      /* 사이즈 */
                    GR_DETAIL4.ColumnProp("STYLE_CD", "Show") = "true";     /* 스타일 */
                    GR_DETAIL4.ColumnProp("COLOR_CD", "Show") = "true";     /* 칼라 */                 
                }else{
                    GR_DETAIL4.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
                    GR_DETAIL4.ColumnProp("STYLE_CD", "Show") = "true";     /* 스타일 */
                    GR_DETAIL4.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */                
                }
               break;
            case 5:
                //수입
                if(strStyleType == "1"){
                    GR_DETAIL5.ColumnProp("SIZE_CD", "Show") = "true";      /* 사이즈 */
                    GR_DETAIL5.ColumnProp("STYLE_CD", "Show") = "true";     /* 스타일 */
                    GR_DETAIL5.ColumnProp("COLOR_CD", "Show") = "true";     /* 칼라 */                 
                }else{
                    GR_DETAIL5.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
                    GR_DETAIL5.ColumnProp("STYLE_CD", "Show") = "true";     /* 스타일 */
                    GR_DETAIL5.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */                
                }
               break;     
            }
        }
            
            setMasterObject(false);
    }

</script>

<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
</script>

<!--  ===================DS_IO_DETAIL============================ -->
<script language=JavaScript for=DS_IO_DETAIL event=OnColumnChanged(row,colid)>
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>




<!--  ===================GR_DETAIL============================ -->
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GR_LIST event=OnClick(row,colid)>
     sortColId(eval(this.DataID), row, colid);
  
</script>

<!-- 디테일 선택시 전체 선택/해제 -->
<script language=JavaScript for=GR_LIST
    event="OnHeadCheckClick(Col,Colid,bCheck)">    

    //헤더 전체 체크/체크해제 컨트롤
    if (bCheck == '1'){ // 전체체크
        for(var i=1; i<=DS_O_LIST.CountRow; i++){
            DS_O_LIST.NameValue(i, "CHECK1") = 'T';
        }
    }else{  // 전체체크해제
        for (var i=1; i<=DS_O_LIST.CountRow; i++){
            DS_O_LIST.NameValue(i, "CHECK1") = 'F';
        }
    }
</script>

<!--  ===================GR_DETAIL============================ -->
<!-- 그리드 CHECK BOX 전체 선택 -->
<script language="javascript"  for=GR_DETAIL event=OnHeadCheckClick(Col,Colid,bCheck)>
</script>
<!-- GR_DETAIL OnPopup event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnPopup(row,colid,data)>
</script>

<!-- GR_DETAIL CanColumnPosChange(Row,Colid) event 처리 -->
<script language="javascript"  for=GR_DETAIL event=CanColumnPosChange(Row,Colid)>
</script>

<!-- GR_DETAIL OnColumnPosChanged(Row,Colid) event 처리 -->
<script language="javascript"  for=GR_DETAIL event=OnColumnPosChanged(Row,Colid)>
</script>



<!-- Grid DETAIL oneClick event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_S_STR event=OnSelChange()>
    if(LC_S_STR.BindColVal != "%"){
        getDept("DS_O_DEPT", "Y", LC_S_STR.BindColVal, "Y");   // 팀 
        LC_S_BUMUN.Index = 0;
    }
    
    EM_S_PB_CD.Text  = "";
    EM_S_PB_NM.Text  = "";
    EM_S_VEN_CD.Text = "";
    EM_S_VEN_NM.Text = "";

</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_S_BUMUN event=OnSelChange()>
    if(LC_S_BUMUN.BindColVal != "%"){
        getTeam("DS_O_TEAM", "Y", LC_S_STR.BindColVal, LC_S_BUMUN.BindColVal, "Y");                       // 파트  
    }else{
        DS_O_TEAM.ClearData();
        insComboData( LC_S_TEAM, "%", "전체",1);
        DS_O_PC.ClearData();
        insComboData( LC_S_PC, "%", "전체",1);
    }
    LC_S_TEAM.Index = 0;
    
    EM_S_PB_CD.Text  = "";
    EM_S_PB_NM.Text  = "";
    
</script>

<!-- 파트(조회)  변경시  -->
<script language=JavaScript for=LC_S_TEAM event=OnSelChange()>
    if(LC_S_TEAM.BindColVal != "%"){
        getPc("DS_O_PC", "Y", LC_S_STR.BindColVal, LC_S_BUMUN.BindColVal, LC_S_TEAM.BindColVal, "Y");     // PC  
    }else{
        DS_O_PC.ClearData();
        insComboData( LC_S_PC, "%", "전체",1);
    }
    LC_S_PC.Index = 0;
    
    EM_S_PB_CD.Text  = "";
    EM_S_PB_NM.Text  = "";
    
</script>

<!-- PC(조회)  변경시  -->
<script language=JavaScript for=LC_S_PC event=OnSelChange()>
    EM_S_PB_CD.Text  = "";
    EM_S_PB_NM.Text  = "";
</script>

<!-- 브랜드 KillFocus -->
<script language=JavaScript for=EM_S_PB_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    if(EM_S_PB_CD.Text != "")
        searchPumbunPop(false);
    else
        EM_S_PB_NM.Text = "";
</script>

<!-- 협력사 KillFocus -->
<script language=JavaScript for=EM_S_VEN_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return
        
    if(EM_S_VEN_CD.Text != "")
        getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM, false);
    else
        EM_S_VEN_NM.Text = "";
</script>

<!-- 조회시작일 변경시  -->
<script lanaguage=JavaScript for=EM_S_START_DT event=OnKillFocus()>
    var strSyyyymmdd = strToday.substring(0,6) + "01";
    checkDateTypeYMD( EM_S_START_DT, strSyyyymmdd );
</script>

<!-- 조회종료일 변경시  -->
<script lanaguage=JavaScript for=EM_S_END_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_S_END_DT );
</script>

<!-- 점(입력)  변경시  -->
<script language=JavaScript for=LC_STR event=OnSelChange()>
</script>

<!-- 사후구분(입력)  포커스변경시  -->
<script language=JavaScript for=LC_AFT_ORD_FLAG event=OnSelChange()>
</script>

<!-- 브랜드코드 KillFocus -->
<script language=JavaScript for=EM_PUMBUN_CD event=onKillFocus()>
</script>

<!-- 협력사 KillFocus -->
<script language=JavaScript for=EM_VEN_CD event=onKillFocus()>
</script>

<!-- 지불구분(입력)  변경시  -->
<script language=JavaScript for=LC_PAY_COND event=OnSelChange()>

</script>

<!-- 전표구분 변경시  -->
<script language=JavaScript for=RD_SLIP_FLAG event=OnSelChange()>

</script>

<!-- 발주일 변경시  -->
<script lanaguage=JavaScript for=EM_ORD_DT event=OnKillFocus()>
</script>
<!-- 납품예정일 변경시  -->
<script lanaguage=JavaScript for=EM_DELI_DT event=OnKillFocus()>
</script>
<!-- 가격적용일 변경시  -->
<script lanaguage=JavaScript for=EM_PRC_APP_DT event=OnKillFocus()>
</script>

<!-- 비고 KillFocus -->
<script language=JavaScript for=EM_REMARK event=onKillFocus()>  
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

<comment id="_NSID_"><object id="DS_I_COMMON"           classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DEPT"             classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TEAM"             classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PC"               classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GJDATE_TYPE"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_PROC_STAT"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR"              classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_AFT_ORD_FLAG"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_COND"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_LIST"             classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SKU_INFO"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STORE"            classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_BIZ_TYPE"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TAX_FLAG"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ORD_FLAG"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ORD_OWN_FLAG"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"           classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_INC_FLAG"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"          classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER1"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER3"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER4"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER5"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER6"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"          classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL1"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL2"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL3"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL4"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL5"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL6"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_NEW_EVENT_CD"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_OLD_EVENT_CD"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_INC_RSN_CD"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STR"                classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CURRENCY"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PRC_COND"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SHIPPMENT"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PAYMENT_COND"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PAYMENT_DTL_COND" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_ARRI_PORT"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_IMPORT_COUNTRY"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_AFT_ORD_FLAG"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TAG_FLAG"           classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TAG_PRT_OWN_FLAG"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EVENT_FLAG"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EVENT_RATE"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SETEVNFLAG"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SETEVNRATE"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_AUTO_SLIP_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
    <object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
        <param name="KeyName" value="Toinb_dataid4">
    </object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
    <object id="TR_S_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
        <param name="KeyName" value="Toinb_dataid4">
    </object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
    <object id="TR_L_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
        <param name="KeyName" value="Toinb_dataid4">
    </object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_LIST");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GR_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top2) {
    	grd_height = top2;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
    }
    obj.style.height  = grd_height + "px";
    
    
}
</script>

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">

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
                        <th class="point" width="70">점</th>
                        <td width="110">
                          <comment id="_NSID_"> 
                              <object id=LC_S_STR classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=100 align="absmiddle" tabindex=1> </object> 
                          </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th width="70">팀</th>
                        <td width="110">
                          <comment id="_NSID_"> 
                              <object id=LC_S_BUMUN classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle" tabindex=1> </object> 
                          </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th  width="70">파트</th>
                        <td width="110">
                          <comment id="_NSID_"> 
                              <object id=LC_S_TEAM classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle" tabindex=1> </object> 
                          </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th  width="70">PC</th>
                        <td>
                          <comment id="_NSID_"> 
                              <object id=LC_S_PC classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle" tabindex=1> </object> 
                          </comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <th class="point" width="70">기준일</th>
                        <td width="110">
                          <comment id="_NSID_"> 
                              <object id=LC_S_GJDATE_TYPE classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=100 align="absmiddle" tabindex=1> </object> 
                          </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th class="point" width="70">조회기간</th>
                        <td colspan="3">
                          <comment id="_NSID_"> 
                              <object id=EM_S_START_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"> </object> 
                          </comment><script> _ws_(_NSID_);</script>
                          <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_S_START_DT onclick="javascript:openCal('G',EM_S_START_DT)" align="absmiddle" />
                          ~ 
                          <comment id="_NSID_"> 
                              <object id=EM_S_END_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"> </object> 
                          </comment><script> _ws_(_NSID_);</script> 
                          <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_S_END_DT onclick="javascript:openCal('G',EM_S_END_DT)" align="absmiddle" />
                        </td>
                        <th width="70">전표상태</th>
                        <td>
                          <comment id="_NSID_"> 
                              <object id=LC_S_S_PROC_STAT classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle" tabindex=1> </object> 
                          </comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <th>브랜드</th>
                        <td colspan="3">
                          <comment id="_NSID_"> 
                              <object id=EM_S_PB_CD classid=<%=Util.CLSID_EMEDIT%> width=88 tabindex=1  align="absmiddle"> </object> 
                          </comment><script> _ws_(_NSID_);</script>
                          <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_S_PUMBUN" class="PR03" align="absmiddle" onclick="javascript:searchPumbunPop(true);" /> 
                          <comment id="_NSID_"> 
                              <object id=EM_S_PB_NM classid=<%=Util.CLSID_EMEDIT%> width=184 tabindex=1 align="absmiddle"> </object> 
                          </comment><script> _ws_(_NSID_);</script> 
                        </td>
                        <th>협력사</th>
                        <td colspan="3">
                          <comment id="_NSID_"> 
                              <object id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=88 tabindex=1 align="absmiddle"> </object> 
                          </comment><script> _ws_(_NSID_);</script>
                          <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_S_VEN" class="PR03" align="absmiddle" onclick="javascript:getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM, true);" />
                          <comment id="_NSID_"> 
                              <object id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=184 tabindex=1 align="absmiddle" > </object> 
                          </comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <th>전표번호</th>
                        <td colspan="3">
                          <comment id="_NSID_"> 
                              <object id=EM_S_SLIP_NO classid=<%=Util.CLSID_EMEDIT%> width=113 tabindex=1 align="absmiddle"> </object> 
                          </comment><script> _ws_(_NSID_);</script>
                        </td>
                        <th>자동전표여부</th>
                        <td colspan="3">                            
                            <comment id="_NSID_"> 
                              <object id=LC_S_AUTO_SLIP_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle" tabindex=1> </object> 
                          </comment><script>_ws_(_NSID_);</script>
                        </td> 
                    </tr>
                    <tr>
                        <th class="point">전표구분</th>
                        <td colspan="7">                            
                            <input type="checkbox" id=CHK_1 onclick="javascript:checkSlipFlag(CHK_1);">전체
                            <input type="checkbox" id=CHK_2 onclick="javascript:checkSlipFlag(CHK_2);">매입
                            <input type="checkbox" id=CHK_3 onclick="javascript:checkSlipFlag(CHK_3);">반품
                            <!--  20120518 * DHL * 마리오 주석처리 START -->
                            <input type="checkbox" id=CHK_4 onclick="javascript:checkSlipFlag(CHK_4);">대출입
                            <input type="checkbox" id=CHK_5 onclick="javascript:checkSlipFlag(CHK_5);">점출입
                            <input type="checkbox" id=CHK_6 onclick="javascript:checkSlipFlag(CHK_6);">매가인상하
                            <!--  20120518 * DHL * 마리오 주석처리 END   -->            
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
                <td width="400">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                    <tr>
                    <td>
                          <comment id="_NSID_"> 
                              <OBJECT id=GR_LIST width=100% height=405 classid=<%=Util.CLSID_GRID%>>
                                 <param name="DataID" value="DS_O_LIST">
                                 <Param Name="ViewSummary"   value="1" >
                              </OBJECT> 
                          </comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                </table>
                </td>
                <td class="PL10">
                 <div id=TAB_MAIN  width="100%" height=700 TitleWidth=90 TitleAlign="center" MenuDisplay=false>
                     <menu TitleName="단품매입"        DivId="tab_page1" Enable='false' />
                     <menu TitleName="대출입"          DivId="tab_page2" Enable='false' />
                     <menu TitleName="점출입"          DivId="tab_page3" Enable='false' />
                     <menu TitleName="매가인상하"      DivId="tab_page4" Enable='false' />
                     <menu TitleName="수입"            DivId="tab_page5" Enable='false' />
                     <menu TitleName="품목"            DivId="tab_page6" Enable='false' />
                 </div>
                <div id=tab_page1 width="100%" > 
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                
                    <tr>
                        <td class=" PB03">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                        <tr>
                                <th width="65" >점</th>
                                <td width="105">
                                    <comment id="_NSID_"> 
                                        <object id=LC_STR classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th width="75">전표번호</th>
                                <td width="105">
                                    <comment id="_NSID_"> 
                                        <object id=EM_SLIP_NO classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th width="75">전표상태</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_SLIP_PROC_STAT_NM classid=<%=Util.CLSID_EMEDIT%> width=115 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th>전표구분</th>
                                <td>
                                    <comment id="_NSID_">
                                        <object id=RD_SLIP_FLAG classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:100">
                                        <param name=Cols    value="2">
                                        <param name=Format  value="A^매입,B^반품">
                                        <param name=CodeValue  value="A">
                                        </object>  
                                    </comment>
                                    <script> _ws_(_NSID_);</script> 
                                </td>
                                <th>사후구분</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=LC_AFT_ORD_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th>지불구분</th>
                                <td colspan="5">
                                    <comment id="_NSID_"> 
                                        <object id=LC_PAY_COND classid=<%=Util.CLSID_LUXECOMBO%> width=115 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                             
                            <tr>
                                <th>브랜드</th>
                                <td colspan="3">
                                    <comment id="_NSID_"> 
                                        <object id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    <comment id="_NSID_"> 
                                        <object id=EM_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=198 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>바이어</th>        
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_BUYER_CD classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    <comment id="_NSID_"> 
                                        <object id=EM_BUYER_NM classid=<%=Util.CLSID_EMEDIT%> width=67 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>거래형태</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_BIZ_TYPE_NM classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>과세구분</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TAX_FLAG_NM classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>발주구분</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_ORD_FLAG classid=<%=Util.CLSID_EMEDIT%> width=115 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>협력사    </th>
                                <td colspan="3">
                                    <comment id="_NSID_"> 
                                        <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    <comment id="_NSID_"> 
                                        <object id=EM_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=198 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>발주주체</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_ORD_OWN_FLAG classid=<%=Util.CLSID_EMEDIT%> width=115 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                           
                            <tr>
                                <th>발주일</th>
                                <td >
                                    <comment id="_NSID_"> 
                                        <object id=EM_ORD_DT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>발주확정일</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_CONF_DT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>납품예정일</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_DELI_DT classid=<%=Util.CLSID_EMEDIT%> width=115 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                          
                            <tr>
                                <th>가격적용일</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_PRC_APP_DT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>검품확정일</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_CHK_DT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>차익액/율</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_GAP_TOT_AMT classid=<%=Util.CLSID_EMEDIT%> width=67 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    <comment id="_NSID_"> 
                                        <object id=EM_GAP_RATE classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>수량계</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TOT_QTY classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1   align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>원가계</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TOT_COST_AMT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>매가계</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TOT_SALE_AMT classid=<%=Util.CLSID_EMEDIT%> width=115 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                           
                            <tr>
                                <th>비고</th>
                                <td colspan="5">
                                    <comment id="_NSID_"> 
                                        <object id=EM_REMARK classid=<%=Util.CLSID_EMEDIT%> width=517 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            
                        </table>
                        </td>
                    </tr>
                    
                    <tr>
                        <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr valign="top">
                                <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                                    <tr>
                                        <td>
                                          <comment id="_NSID_"> 
                                              <OBJECT id=GR_DETAIL width=100% height=175    classid=<%=Util.CLSID_GRID%>>
                                                 <param name="DataID" value="DS_IO_DETAIL">
                                                 <Param Name="ViewSummary"   value="1" >
                                              </OBJECT> 
                                          </comment><script>_ws_(_NSID_);</script>
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
               <div id=tab_page2 width="100%" > 
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class=" PB03">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                        
                            <tr>
                                <th width="70">점</th>
                                <td width="100">
                                    <comment id="_NSID_"> 
                                        <object id=LC_STR1 classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1  align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th width="80">전표번호</th>
                                <td width="100">
                                    <comment id="_NSID_"> 
                                        <object id=EM_SLIP_NO1 classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th width="80">전표상태</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_PROC_STAT1 classid=<%=Util.CLSID_EMEDIT%> width=112 tabindex=1  align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>사후구분</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=LC_AFT_ORD_FLAG1 classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th>상대전표</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_P_SLIP_NO1 classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>상대전표상태</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_S_PROC_STAT1 classid=<%=Util.CLSID_EMEDIT%> width=112 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>대출브랜드 </th>
                                <td colspan="3">
                                    <comment id="_NSID_"> 
                                        <object id=EM_PUMBUN_CD1 classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    <comment id="_NSID_"> 
                                        <object id=EM_PUMBUN_NM1 classid=<%=Util.CLSID_EMEDIT%> width=198 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>대출과세구분</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TAX_FLAG_NM1 classid=<%=Util.CLSID_EMEDIT%> width=112 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>대입브랜드 </th>
                                <td colspan="3">
                                    <comment id="_NSID_"> 
                                        <object id=EM_P_PUMBUN_CD1 classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    <comment id="_NSID_"> 
                                        <object id=EM_P_PUMBUN_NM1 classid=<%=Util.CLSID_EMEDIT%> width=198 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>대입과세구분</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_P_TAX_FLAG_NM1 classid=<%=Util.CLSID_EMEDIT%> width=112 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                       
                            <tr>
                                <th>발주일</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_ORD_DT1 classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>시행일</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_DELI_DT1 classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>바이어</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_BUYER_CD1 classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    <comment id="_NSID_"> 
                                        <object id=EM_BUYER_NM1 classid=<%=Util.CLSID_EMEDIT%> width=64 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>가격적용일</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_PRC_APP_DT1 classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>검품확정일</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_CHK_DT1 classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>차익액/율</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_GAP_TOT_AMT1 classid=<%=Util.CLSID_EMEDIT%> width=67 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    <comment id="_NSID_"> 
                                        <object id=EM_GAP_RATE1 classid=<%=Util.CLSID_EMEDIT%> width=42 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                               
                            <tr>
                                <th>수량계</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TOT_QTY1 classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1   align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>원가계</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TOT_COST_AMT1 classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>매가계</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TOT_SALE_AMT1 classid=<%=Util.CLSID_EMEDIT%> width=112 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                        
                            <tr>
                                <th>비고</th>
                                <td colspan="5">
                                    <comment id="_NSID_"> 
                                        <object id=EM_REMARK1 classid=<%=Util.CLSID_EMEDIT%> width=514 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
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
                                <td><b>[대출]</b> 
                                </td>
                           </tr>
                            <tr valign="top">
                                <td colspan=2>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                                    <tr>
                                        <td>
                                          <comment id="_NSID_"> 
                                              <OBJECT id=GR_DETAIL1 width=100% height=102 classid=<%=Util.CLSID_GRID%>>
                                                 <param name="DataID" value="DS_IO_DETAIL1">
                                                 <Param Name="ViewSummary"   value="1" >
                                              </OBJECT> 
                                          </comment><script>_ws_(_NSID_);</script>
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
                                <td><b>[대입]</b> 
                                </td>
                            </tr>
                            <tr valign="top">
                                <td colspan=2>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                                    <tr>
                                        <td>
                                          <comment id="_NSID_"> 
                                              <OBJECT id=GR_DETAIL2 width=100% height=60 classid=<%=Util.CLSID_GRID%>>
                                                 <param name="DataID" value="DS_IO_DETAIL2">
                                              </OBJECT> 
                                          </comment><script>_ws_(_NSID_);</script>
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
                <div id=tab_page3 width="100%" > 
                   <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class=" PB03">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                            
                            <tr>
                                <th width="70">점출점</th>
                                <td width="105">
                                    <comment id="_NSID_"> 
                                        <object id=LC_STR3 classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th width="80">점출전표번호</th>
                                <td width="105">
                                    <comment id="_NSID_"> 
                                        <object id=EM_E_SLIP_NO3 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th width="80">점출전표상태</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_E_PROC_STAT3 classid=<%=Util.CLSID_EMEDIT%> width=100 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>                            
                            </tr>
                             
                            <tr>
                                <th>점입점</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=LC_P_STR3 classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th>점입전표번호</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_F_SLIP_NO3 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>점입전표상태</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_F_PROC_STAT3 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>사후구분</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=LC_AFT_ORD_FLAG3 classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th>점출예정일</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_ORD_DT3 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>점입예정일</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_DELI_DT3 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>                      
                            </tr>                            
                            
                            <tr>
                                <th>검품확정일</th>
                                <td colspan="5">
                                    <comment id="_NSID_"> 
                                        <object id=EM_CHK_DT3 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>점출브랜드</th>
                                <td colspan="3">
                                    <comment id="_NSID_"> 
                                        <object id=EM_PUMBUN_CD3 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    <comment id="_NSID_"> 
                                        <object id=EM_PUMBUN_NM3 classid=<%=Util.CLSID_EMEDIT%> width=203 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th width="80">점출과세구분</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TAX_FLAG_NM3 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>점입브랜드</th>
                                <td colspan="3">
                                    <comment id="_NSID_"> 
                                        <object id=EM_P_PUMBUN_CD3 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    <comment id="_NSID_"> 
                                        <object id=EM_P_PUMBUN_NM3 classid=<%=Util.CLSID_EMEDIT%> width=203 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>점입과세구분</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_P_TAX_FLAG_NM3 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>가격적용일</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_PRC_APP_DT3 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>바이어</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_BUYER_CD3 classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    <comment id="_NSID_"> 
                                        <object id=EM_BUYER_NM3 classid=<%=Util.CLSID_EMEDIT%> width=52 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>차익액/율</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_GAP_TOT_AMT3 classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    <comment id="_NSID_"> 
                                        <object id=EM_GAP_RATE3 classid=<%=Util.CLSID_EMEDIT%> width=37 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>수량계</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TOT_QTY3 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1   align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>원가계</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TOT_COST_AMT3 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>매가계</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TOT_SALE_AMT3 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>비고</th>
                                <td colspan="5">
                                    <comment id="_NSID_"> 
                                        <object id=EM_REMARK3 classid=<%=Util.CLSID_EMEDIT%> width=512 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
  <!---->
                        </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="dot"></td>
                    </tr>
                    <tr>
                        <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr valign="top">
                                <td colspan=2>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                                    <tr>
                                        <td>
                                          <comment id="_NSID_"> 
                                              <OBJECT id=GR_DETAIL3 width=100% height=170 classid=<%=Util.CLSID_GRID%>>
                                                 <param name="DataID" value="DS_IO_DETAIL3">
                                                 <Param Name="ViewSummary"   value="1" >
                                              </OBJECT> 
                                          </comment><script>_ws_(_NSID_);</script>
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
                <div id=tab_page4 width="100%" >
                   <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class=" PB03">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                        
                        <tr>
                                <th width="80">점</th>
                                <td width="105">
                                    <comment id="_NSID_"> 
                                        <object id=LC_STR4 classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th width="80">전표번호</th>
                                <td width="105">
                                    <comment id="_NSID_"> 
                                        <object id=EM_SLIP_NO4 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th width="70">전표상태</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_SLIP_PROC_STAT_NM4 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                             
                            <tr>
                                <th>사후구분</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=LC_AFT_ORD_FLAG4 classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th>인상하구분</th>
                                <td colspan=3>
                                    <comment id="_NSID_"> 
                                        <object id=LC_INC_FLAG4 classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>브랜드</th>
                                <td colspan="3">
                                    <comment id="_NSID_"> 
                                        <object id=EM_PUMBUN_CD4 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    <comment id="_NSID_"> 
                                        <object id=EM_PUMBUN_NM4 classid=<%=Util.CLSID_EMEDIT%> width=203 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>과세구분</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TAX_FLAG_NM4 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>                                
                            </tr>
                            
                            <tr>
                                <th>발주일</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_ORD_DT4 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>시행일</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_DELI_DT4 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>검품확정일</th>
                                <td >
                                    <comment id="_NSID_"> 
                                        <object id=EM_CHK_DT4 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>구가격적용일</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_OLD_PRC_APP_DT4 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>구행사코드</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=LC_OLD_EVENT_CD4 classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th>바이어</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_BUYER_CD4 classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    <comment id="_NSID_"> 
                                        <object id=EM_BUYER_NM4 classid=<%=Util.CLSID_EMEDIT%> width=52 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                           
                            <tr>
                                <th>신가격적용일</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_NEW_PRC_APP_DT4 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>신행사코드</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=LC_NEW_EVENT_CD4 classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th>차익액</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_GAP_TOT_AMT4 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>수량계</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TOT_QTY4 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1   align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>구매가계</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_OLD_SALE_TAMT4 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>신매가계</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_NEW_SALE_TAMT4 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                           
                            <tr>
                                <th>사유</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=LC_INC_RSN_CD4 classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>

                                </td>
                                <th>비고</th>
                                <td colspan=3>
                                    <comment id="_NSID_"> 
                                        <object id=EM_REMARK4 classid=<%=Util.CLSID_EMEDIT%> width=296 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
  <!-- -->                            
                        </table>
                        </td>
                    </tr>
                      <tr>
                        <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                           <tr valign="top">
                               <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                                    <tr>
                                        <td>
                                          <comment id="_NSID_"> 
                                              <OBJECT id=GR_DETAIL4 width=100% height=186  classid=<%=Util.CLSID_GRID%>>
                                                 <param name="DataID" value="DS_IO_DETAIL4">
                                                 <Param Name="ViewSummary"   value="1" >
                                              </OBJECT> 
                                          </comment><script>_ws_(_NSID_);</script>
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
                
                
                <div id=tab_page5 width="100%" >

                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="PB03">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0"
                            class="s_table">
                    
                            
                <tr>
                  <th width="80">점</th>
                  <td width="95">
                         <comment id="_NSID_">
                            <object id=LC_I_STR_CD5 classid=<%= Util.CLSID_LUXECOMBO %> width=90 align="absmiddle" tabindex=1>
                            </object>
                        </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th width="73">전표번호</th>
                  <td width="105">
                      <comment id="_NSID_">
                            <object id=EM_I_SLIP_NO5 classid=<%=Util.CLSID_EMEDIT%>  width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th width="80">전표상태</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_O_SLIP_FLAG5 classid=<%=Util.CLSID_EMEDIT%>  width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th width="80">OFFER NO</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                            <object id=EM_I_OFFER_NO5 classid=<%=Util.CLSID_EMEDIT%>  width=95 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>OFFER 일자</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_O_OFFER_DT5 classid=<%=Util.CLSID_EMEDIT%>  width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>  
                
                <tr>
                  <th>브랜드</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                            <object id=EM_I_PUMBUN_CD5 classid=<%=Util.CLSID_EMEDIT%>  width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                            <object id=EM_O_PUMBUN_NM5 classid=<%=Util.CLSID_EMEDIT%>  width=196 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>바이어</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_BUYER_CD5 classid=<%=Util.CLSID_EMEDIT%>  width=45 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                            <object id=EM_O_BUYER_NM5 classid=<%=Util.CLSID_EMEDIT%>  width=50 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                 
                <tr>
                  <th>거래형태</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_BIZ_TYPE_NM5 classid=<%=Util.CLSID_EMEDIT%>  width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>과세구분</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_TAX_FLAG_NM5 classid=<%=Util.CLSID_EMEDIT%>  width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>단품종류</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_SKU_FLAG_NM5 classid=<%=Util.CLSID_EMEDIT%>  width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>  
               
                <tr>
                  <th>협력사</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                            <object id=EM_I_VEN_CD5 classid=<%=Util.CLSID_EMEDIT%>  width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                            <object id=EM_O_VEN_NM5 classid=<%=Util.CLSID_EMEDIT%>  width=196 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                 
                <tr>
                  <th>INVOICE</BR>일자</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_INVOICE_DT5 classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>INVOICE NO</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_INVOICE_NO5 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>B/L NO</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_BL_NO5 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>  
                </tr>
                
                <tr>
                  <th>수입국가</th>
                  <td>
                      <comment id="_NSID_">
                         <object id=LC_I_IMPORT_COUNTRY5 classid=<%= Util.CLSID_LUXECOMBO%> width=90 align="absmiddle" tabindex=1 >
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th>선적항</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                            <object id=EM_I_SHIP_PORT5 classid=<%=Util.CLSID_EMEDIT%> width=306 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>도착항</th>
                  <td>
                      <comment id="_NSID_">
                         <object id=LC_I_ARRI_PORT5 classid=<%= Util.CLSID_LUXECOMBO%> width=90 align="absmiddle" tabindex=1 >
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th>ETD(출발일)</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_ETD5 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>ETA(종료일)</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_ETA5 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>L/C DATE</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_LC_DATE5 classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>L/C NO</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                            <object id=EM_I_LC_NO5 classid=<%=Util.CLSID_EMEDIT%> width=306 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>가격조건</th>
                  <td>
                      <comment id="_NSID_">
                         <object id=LC_I_PRC_COND5 classid=<%= Util.CLSID_LUXECOMBO %> width=90 align="absmiddle" tabindex=1 >
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th>결제조건</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                         <object id=LC_I_PAYMENT_COND5 classid=<%= Util.CLSID_LUXECOMBO%> width=203 align="absmiddle" tabindex=1 >
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                      <comment id="_NSID_">
                         <object id=LC_I_PAYMENT_DTL_COND5 classid=<%= Util.CLSID_LUXECOMBO%> width=102 align="absmiddle" tabindex=1 >
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                                   
                <tr>
                  <th>화폐단위</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=LC_I_CURRENCY_CD5 classid=<%=Util.CLSID_LUXECOMBO%> width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>환율적용일</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_EXC_APP_DT5 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>환율</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_EXC_RATE5 classid=<%=Util.CLSID_EMEDIT%>  width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                </tr>
                
                <tr>
                  <th>통관예정일</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_ENTRY_DT5 classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>수입신고번호</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                            <object id=EM_I_IMPORT_NO5 classid=<%=Util.CLSID_EMEDIT%> width=306 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                 
                <tr>                  
                  <th>Packing</br>Charge</th>
                  <td>
                      <comment id="_NSID_">
                         <object id=EM_I_PACKING_CHARGE5 classid=<%= Util.CLSID_EMEDIT%> width=90 align="absmiddle" tabindex=1 >
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th>N.C.V</th>
                  <td>
                      <comment id="_NSID_">
                         <object id=EM_I_NCV5 classid=<%= Util.CLSID_EMEDIT%> width=100 align="absmiddle" tabindex=1 >
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th>INVOICE 금액</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_INVOICE_AMT5 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>납품예정일</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_DELI_DT5 classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td> 
                  <th>가격적용일</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_PRC_APP_DT5 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td> 
                  <th>검품확정일</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_CHK_DT5 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>                 
                </tr>
               
                <tr>
                  <th>수량계</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_INVOICE_TOT_QTY5 classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>원가계</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_INVOICE_TOT_AMT5 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>매가계</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_SALE_TOT_AMT5 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>                
                </tr>
                
                <tr>
                  <th>비고</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_REMARK5 classid=<%= Util.CLSID_EMEDIT %> width=495 align="absmiddle" tabindex=1 >
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>

              </table></td>
          </tr>
          <tr>
            <td class="dot"></td>
          </tr>
            <tr>
                <td class="PT05">
                   <table width="100%" border="0" cellspacing="0" cellpadding="0">
                       <tr valign="top">
                            <td>
                                <comment id="_NSID_">
                                    <OBJECT id=GR_DETAIL5 width=100% height=145 classid=<%=Util.CLSID_GRID%>>
                                        <param name="DataID" value="DS_IO_DETAIL5">
                                        <Param Name="ViewSummary"   value="1" >
                                    </OBJECT>
                                </comment><script>_ws_(_NSID_);</script>
                           </td>
                        </tr>
                     </table>
                    </td>
                  </tr>
                 </table>
            
               </div> 
               <div id=tab_page6 width="100%" >
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                       <td class="PB03">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0"
                            class="s_table">
                            
                            <tr>
                                <th width="70" >점</th>
                                <td width="105"><comment id="_NSID_"> <object
                                    id=LC_I_STORE6 classid=<%=Util.CLSID_LUXECOMBO%> width=100
                                    align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
                                <th width="90">전표번호</th>
                                <td width="105"><comment id="_NSID_"> <object
                                    id=EM_O_SLIP_NO6 classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                                <th width="70">전표상태</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_O_SLIP_PROC_STAT_NM6 classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                            </tr>
                             
                            <tr>
                                <th>전표구분</th>
                                <td><comment id="_NSID_"> <object id=RD_SLIP_FLAG6
                                    classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height: 20; width: 100">
                                    <param name=Cols value="2">
                                    <param name=Format value="A^매입,B^반품">
                                    <param name=CodeValue value="A">
                                </object> </comment> <script> _ws_(_NSID_);</script></td>
                                <th>사후구분</th>
                                <td colspan="3"><comment id="_NSID_"> <object id=LC_I_SH_GBN6
                                    classid=<%=Util.CLSID_LUXECOMBO%> width=105 align="absmiddle" tabindex=1>
                                </object> </comment><script>_ws_(_NSID_);</script></td>
                            </tr>
                            
                            <tr>
                                <th>브랜드</th>
                                <td colspan="3">
                                  <comment id="_NSID_"> 
                                  <object id=EM_I_PB_CD6 classid=<%=Util.CLSID_EMEDIT%> 
                                    width=100 tabindex=1 align="absmiddle"> </object> 
                                  </comment>
                                  <script> _ws_(_NSID_);</script>
                                  <comment id="_NSID_">
                                  <object id=EM_I_PB_NM6 classid=<%=Util.CLSID_EMEDIT%> 
                                     width=213 tabindex=1 align="absmiddle"></object>
                                  </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>발주주체</th>
                                <td><comment id="_NSID_"> <object id=EM_O_BALJUJC6
                                    classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 value="0"
                                    align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
                            </tr>
                            
                            <tr>
                                <th>협력사</th>
                                <td colspan="3">
                                    <comment id="_NSID_"> 
                                    <object id=EM_O_HRS_CD6 classid=<%=Util.CLSID_EMEDIT%> 
                                      width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment>
                                    <script> _ws_(_NSID_);</script> 
                                    <comment id="_NSID_"> <object
                                    id=EM_O_HRS_NM6 classid=<%=Util.CLSID_EMEDIT%> width=213
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>과세구분</th>
                                <td><comment id="_NSID_"> <object id=EM_O_GS_GBN6
                                    classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                            </tr>
                           
                            <tr>
                                <th>발주일</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_I_BJDATE6 classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>발주확정일</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_I_BJHJDATE6 classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>바이어</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_O_BUYER_CD6 classid=<%=Util.CLSID_EMEDIT%> width=45
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                <comment id="_NSID_"> <object id=EM_O_BUYER_NM6
                                    classid=<%=Util.CLSID_EMEDIT%> width=52 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                            </tr>
                             
                            <tr>
                                <th>납품예정일</th>
                                <td ><comment id="_NSID_"> <object
                                    id=EM_I_NPYJDATE6 classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>검품확정일</th>
                                <td colspan="3"><comment id="_NSID_"> <object
                                    id=EM_O_GPWJ_DATE6 classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>마진적용일</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_I_MAJINDATE6 classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>행사구분/행사율</th>
                                <td colspan="3"> <comment
                                    id="_NSID_"> <object id=LC_I_HS_GBN6
                                    classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 align="absmiddle">
                                </object> </comment><script>_ws_(_NSID_);</script><comment
                                    id="_NSID_"> <object id=LC_I_HS_RATE6
                                    classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 align="absmiddle">
                                </object> </comment><script>_ws_(_NSID_);</script>
                                    <comment id="_NSID_"> <object id=EM_O_MG_RATE
                                     classid=<%=Util.CLSID_EMEDIT%> width=94 tabindex=1
                                     align="absmiddle"> </object> 
                                     </comment
                                     ><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>수량계</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_O_SRG6 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                                <th>원가계</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_O_WGG6 classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                                <th>매가계</th>
                                <td><comment id="_NSID_"> <object id=EM_O_MGG6
                                    classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                            </tr>
                            
                            <tr>
                                <th>비고</th>
                                <td colspan="5"><comment id="_NSID_"> <object
                                    id=EM_O_ETC6 classid=<%=Util.CLSID_EMEDIT%> width=512 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                            </tr>
 <!---->                            
                        </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="PT05">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr valign="top">
                                <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                                    class="BD4A">
                                    <tr>
                                        <td><comment id="_NSID_"> <OBJECT id=GR_DETAIL6
                                            width=100% height=172 classid=<%=Util.CLSID_GRID%>>
                                            <param name="DataID" value="DS_IO_DETAIL6">
                                            <Param Name="ViewSummary" value="1">
                                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                                    </tr>
                                </table>
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
<comment id="_NSID_"> 
    <object id=EM_BIZ_TYPE classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<comment id="_NSID_"> 
    <object id=EM_TAX_FLAG classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>

<!-- 여기서부터 대출입 -->
<!-- 대출거래형태 -->
<comment id="_NSID_"> 
    <object id=EM_BIZ_TYPE1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 대출협력사코드 -->
<comment id="_NSID_"> 
    <object id=EM_VEN_CD1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 대출과세구분 -->
<comment id="_NSID_"> 
    <object id=EM_TAX_FLAG1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 대입바이어 -->
<comment id="_NSID_"> 
    <object id=EM_P_BUYER_CD1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 대입바이어명 -->
<comment id="_NSID_"> 
    <object id=EM_P_BUYER_NM1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 대입거래형태 -->
<comment id="_NSID_"> 
    <object id=EM_P_BIZ_TYPE1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 대입과세구분 -->
<comment id="_NSID_"> 
    <object id=EM_P_TAX_FLAG1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 대입협력사코드 -->
<comment id="_NSID_"> 
    <object id=EM_P_VEN_CD1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 대입수량합계 -->
<comment id="_NSID_"> 
    <object id=EM_P_TOT_QTY1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 대입원가계 -->
<comment id="_NSID_"> 
    <object id=EM_P_TOT_COST_AMT1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<comment id="_NSID_">
<!-- 대입매가계 --> 
    <object id=EM_P_TOT_SALE_AMT1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 대입명세건수 -->
<comment id="_NSID_"> 
    <object id=EM_P_DTL_CNT1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 대입차익액합 -->
<comment id="_NSID_"> 
    <object id=EM_P_GAP_TOT_AMT1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 대입신차익율 -->
<comment id="_NSID_"> 
    <object id=EM_P_GAP_RATE1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>

<!-- 여기서부터 점출입 -->
<!-- 점출과세구분 -->
<comment id="_NSID_"> 
    <object id=EM_TAX_FLAG3 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 점입과세구분 -->
<comment id="_NSID_"> 
    <object id=EM_P_TAX_FLAG3 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 점출거래형태 -->
<comment id="_NSID_"> 
    <object id=EM_BIZ_TYPE3 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 점입거래형태 -->
<comment id="_NSID_"> 
    <object id=EM_P_BIZ_TYPE3 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 점출협력사 -->
<comment id="_NSID_"> 
    <object id=EM_VEN_CD3 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 점입협력사 -->
<comment id="_NSID_"> 
    <object id=EM_P_VEN_CD3 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>

<!-- 점입바이어코드 -->
<comment id="_NSID_"> 
    <object id=EM_P_BUYER_CD3 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>

<!-- 상대전표번호 -->
<comment id="_NSID_"> 
    <object id=EM_P_SLIP_NO3 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>

<!-- 상대전표상태 -->
<comment id="_NSID_"> 
    <object id=EM_S_PROC_STAT3 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 여기서부터 매가인상하 -->
<comment id="_NSID_"> 
    <object id=EM_BIZ_TYPE4 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<comment id="_NSID_"> 
    <object id=EM_TAX_FLAG4 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<comment id="_NSID_"> 
    <object id=EM_VEN_CD4 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<comment id="_NSID_"> 
    <object id=EM_GAP_RATE4 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<!-- 여기서부터수입 -->
<comment id="_NSID_"> 
    <object id=EM_BIZ_TYPE5 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<comment id="_NSID_"> 
    <object id=EM_TAX_FLAG5 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
<comment id="_NSID_"> 
    <object id=EM_SKU_FLAG5 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>

 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
    <object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
            <c>Col=SLIP_NO             Ctrl=EM_SLIP_NO            param=Text</c>
            <c>Col=SLIP_PROC_STAT_NM   Ctrl=EM_SLIP_PROC_STAT_NM  param=Text</c>
            <c>Col=PUMBUN_CD           Ctrl=EM_PUMBUN_CD          param=Text</c>
            <c>Col=PUMBUN_NM           Ctrl=EM_PUMBUN_NM          param=Text</c>         
            <c>Col=BUYER_CD            Ctrl=EM_BUYER_CD           param=Text</c>
            <c>Col=BUYER_NM            Ctrl=EM_BUYER_NM           param=Text</c>
            <c>Col=BIZ_TYPE_NM         Ctrl=EM_BIZ_TYPE_NM        param=Text</c>
            <c>Col=TAX_FLAG_NM         Ctrl=EM_TAX_FLAG_NM        param=Text</c>
            <c>Col=ORD_FLAG_NM         Ctrl=EM_ORD_FLAG           param=Text</c>
            <c>Col=VEN_CD              Ctrl=EM_VEN_CD             param=Text</c>
            <c>Col=VEN_NM              Ctrl=EM_VEN_NM             param=Text</c>
            <c>Col=ORD_OWN_FLAG_NM     Ctrl=EM_ORD_OWN_FLAG       param=Text</c>
            <c>Col=ORD_DT              Ctrl=EM_ORD_DT             param=Text</c>
            <c>Col=CONF_DT             Ctrl=EM_CONF_DT            param=Text</c>
            <c>Col=DELI_DT             Ctrl=EM_DELI_DT            param=Text</c>
            <c>Col=NEW_PRC_APP_DT      Ctrl=EM_PRC_APP_DT         param=Text</c>
            <c>Col=CHK_DT              Ctrl=EM_CHK_DT             param=Text</c>
            <c>Col=GAP_TOT_AMT         Ctrl=EM_GAP_TOT_AMT        param=Text</c>
            <c>Col=NEW_GAP_RATE        Ctrl=EM_GAP_RATE           param=Text</c>
            <c>Col=ORD_TOT_QTY         Ctrl=EM_TOT_QTY            param=Text</c>
            <c>Col=NEW_COST_TAMT       Ctrl=EM_TOT_COST_AMT       param=Text</c>
            <c>Col=NEW_SALE_TAMT       Ctrl=EM_TOT_SALE_AMT       param=Text</c>
            <c>Col=REMARK              Ctrl=EM_REMARK             param=Text</c>
                                                                  
            <c>Col=STR_CD              Ctrl=LC_STR                param=BindColVal</c>
            <c>Col=AFT_ORD_FLAG        Ctrl=LC_AFT_ORD_FLAG       param=BindColVal</c>
            <c>Col=PAY_COND            Ctrl=LC_PAY_COND           param=BindColVal</c>
            <c>Col=SLIP_FLAG           Ctrl=RD_SLIP_FLAG          param=CodeValue</c>
            <c>Col=BIZ_TYPE            Ctrl=EM_BIZ_TYPE           param=Text</c>
            <c>Col=TAX_FLAG            Ctrl=EM_TAX_FLAG           param=Text</c>
            
        '>
    </object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
    <object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER1>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
            <c>Col=PUMBUN_CD           Ctrl=EM_PUMBUN_CD1         param=Text</c>
            <c>Col=PUMBUN_NM           Ctrl=EM_PUMBUN_NM1         param=Text</c>
            <c>Col=BIZ_TYPE            Ctrl=EM_BIZ_TYPE1          param=Text</c> 
            <c>Col=P_SLIP_NO           Ctrl=EM_P_SLIP_NO1         param=Text</c> 
            <c>Col=VEN_CD              Ctrl=EM_VEN_CD1            param=Text</c> 
            <c>Col=P_PUMBUN_CD         Ctrl=EM_P_PUMBUN_CD1       param=Text</c>
            <c>Col=P_PUMBUN_NM         Ctrl=EM_P_PUMBUN_NM1       param=Text</c>     
            <c>Col=BUYER_CD            Ctrl=EM_BUYER_CD1          param=Text</c>
            <c>Col=BUYER_NM            Ctrl=EM_BUYER_NM1          param=Text</c>
            <c>Col=TAX_FLAG            Ctrl=EM_TAX_FLAG1          param=Text</c>
            <c>Col=TAX_FLAG_NM         Ctrl=EM_TAX_FLAG_NM1       param=Text</c>
            <c>Col=P_TAX_FLAG          Ctrl=EM_P_TAX_FLAG1        param=Text</c>
            <c>Col=P_TAX_FLAG_NM       Ctrl=EM_P_TAX_FLAG_NM1     param=Text</c>
            <c>Col=P_S_PROC_STAT       Ctrl=EM_S_PROC_STAT1       param=Text</c>
            <c>Col=ORD_DT              Ctrl=EM_ORD_DT1            param=Text</c>
            <c>Col=DELI_DT             Ctrl=EM_DELI_DT1           param=Text</c>
            <c>Col=NEW_PRC_APP_DT      Ctrl=EM_PRC_APP_DT1        param=Text</c>
            <c>Col=CHK_DT              Ctrl=EM_CHK_DT1            param=Text</c>
            <c>Col=GAP_TOT_AMT         Ctrl=EM_GAP_TOT_AMT1       param=Text</c>
            <c>Col=NEW_GAP_RATE        Ctrl=EM_GAP_RATE1          param=Text</c>
            <c>Col=ORD_TOT_QTY         Ctrl=EM_TOT_QTY1           param=Text</c>
            <c>Col=NEW_COST_TAMT       Ctrl=EM_TOT_COST_AMT1      param=Text</c>
            <c>Col=NEW_SALE_TAMT       Ctrl=EM_TOT_SALE_AMT1      param=Text</c>
            <c>Col=REMARK              Ctrl=EM_REMARK1            param=Text</c>
            <c>Col=SLIP_PROC_STAT_NM   Ctrl=EM_PROC_STAT1         param=Text</c>
            <c>Col=SLIP_NO             Ctrl=EM_SLIP_NO1           param=Text</c> 
            <c>Col=P_VEN_CD            Ctrl=EM_P_VEN_CD1          param=Text</c>
            <c>Col=P_NEW_GAP_RATE      Ctrl=EM_P_GAP_RATE1        param=Text</c>
            <c>Col=STR_CD              Ctrl=LC_STR1               param=BindColVal</c>
            <c>Col=AFT_ORD_FLAG        Ctrl=LC_AFT_ORD_FLAG1      param=BindColVal</c>

            
        '>
    </object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
    <object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER3>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
            <c>Col=P_SLIP_NO             Ctrl=EM_P_SLIP_NO3         param=Text</c> 
            <c>Col=PUMBUN_CD             Ctrl=EM_PUMBUN_CD3         param=Text</c>
            <c>Col=PUMBUN_NM             Ctrl=EM_PUMBUN_NM3         param=Text</c> 
            <c>Col=P_PUMBUN_CD           Ctrl=EM_P_PUMBUN_CD3       param=Text</c>
            <c>Col=P_PUMBUN_NM           Ctrl=EM_P_PUMBUN_NM3       param=Text</c>         
            <c>Col=BUYER_CD              Ctrl=EM_BUYER_CD3          param=Text</c>
            <c>Col=BUYER_NM              Ctrl=EM_BUYER_NM3          param=Text</c> 
            <c>Col=BIZ_TYPE              Ctrl=EM_BIZ_TYPE3          param=Text</c> 
            <c>Col=BIZ_TYPE_NM           Ctrl=EM_BIZ_TYPE_NM3       param=Text</c>
            <c>Col=P_BIZ_TYPE            Ctrl=EM_P_BIZ_TYPE3        param=Text</c>
            <c>Col=TAX_FLAG              Ctrl=EM_TAX_FLAG3          param=Text</c>
            <c>Col=TAX_FLAG_NM           Ctrl=EM_TAX_FLAG_NM3       param=Text</c>
            <c>Col=P_TAX_FLAG            Ctrl=EM_P_TAX_FLAG3        param=Text</c>
            <c>Col=P_TAX_FLAG_NM         Ctrl=EM_P_TAX_FLAG_NM3     param=Text</c>
            <c>Col=VEN_CD                Ctrl=EM_VEN_CD3            param=Text</c>
            <c>Col=VEN_NM                Ctrl=EM_VEN_NM3            param=Text</c>
            <c>Col=P_VEN_CD              Ctrl=EM_P_VEN_CD3            param=Text</c>
            <c>Col=ORD_DT                Ctrl=EM_ORD_DT3            param=Text</c>
            <c>Col=DELI_DT               Ctrl=EM_DELI_DT3           param=Text</c>
            <c>Col=NEW_PRC_APP_DT        Ctrl=EM_PRC_APP_DT3        param=Text</c>
            <c>Col=CHK_DT                Ctrl=EM_CHK_DT3            param=Text</c>
            <c>Col=GAP_TOT_AMT           Ctrl=EM_GAP_TOT_AMT3       param=Text</c>
            <c>Col=NEW_GAP_RATE          Ctrl=EM_GAP_RATE3          param=Text</c>
            <c>Col=ORD_TOT_QTY           Ctrl=EM_TOT_QTY3           param=Text</c>
            <c>Col=NEW_COST_TAMT         Ctrl=EM_TOT_COST_AMT3      param=Text</c>
            <c>Col=NEW_SALE_TAMT         Ctrl=EM_TOT_SALE_AMT3      param=Text</c>
            <c>Col=REMARK                Ctrl=EM_REMARK3            param=Text</c>
            <c>Col=SLIP_PROC_STAT_NM     Ctrl=EM_S_PROC_STAT3       param=Text</c>
            
            <c>Col=E_SLIP_NO             Ctrl=EM_E_SLIP_NO3         param=Text</c>
            <c>Col=F_SLIP_NO             Ctrl=EM_F_SLIP_NO3         param=Text</c>
            <c>Col=E_SLIP_PROC_STAT_NM   Ctrl=EM_E_PROC_STAT3       param=Text</c>
            <c>Col=F_SLIP_PROC_STAT_NM   Ctrl=EM_F_PROC_STAT3       param=Text</c>
            
            <c>Col=STR_CD                Ctrl=LC_STR3               param=BindColVal</c>
            <c>Col=P_STR_CD              Ctrl=LC_P_STR3             param=BindColVal</c>
            <c>Col=AFT_ORD_FLAG          Ctrl=LC_AFT_ORD_FLAG3      param=BindColVal</c>
        '>
    </object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
    <object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER4>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
            <c>Col=SLIP_NO             Ctrl=EM_SLIP_NO4            param=Text</c>
            <c>Col=SLIP_PROC_STAT_NM   Ctrl=EM_SLIP_PROC_STAT_NM4  param=Text</c>
            <c>Col=PUMBUN_CD           Ctrl=EM_PUMBUN_CD4          param=Text</c>
            <c>Col=PUMBUN_NM           Ctrl=EM_PUMBUN_NM4          param=Text</c>         
            <c>Col=BUYER_CD            Ctrl=EM_BUYER_CD4           param=Text</c>
            <c>Col=BUYER_NM            Ctrl=EM_BUYER_NM4           param=Text</c>
            <c>Col=TAX_FLAG_NM         Ctrl=EM_TAX_FLAG_NM4        param=Text</c>
            <c>Col=VEN_CD              Ctrl=EM_VEN_CD4             param=Text</c>
            <c>Col=ORD_DT              Ctrl=EM_ORD_DT4             param=Text</c>
            <c>Col=DELI_DT             Ctrl=EM_DELI_DT4            param=Text</c>
            <c>Col=OLD_PRC_APP_DT      Ctrl=EM_OLD_PRC_APP_DT4     param=Text</c>
            <c>Col=NEW_PRC_APP_DT      Ctrl=EM_NEW_PRC_APP_DT4     param=Text</c>
            <c>Col=CHK_DT              Ctrl=EM_CHK_DT4             param=Text</c>
            <c>Col=GAP_TOT_AMT         Ctrl=EM_GAP_TOT_AMT4        param=Text</c>
            <c>Col=NEW_GAP_RATE        Ctrl=EM_GAP_RATE4           param=Text</c>
            <c>Col=ORD_TOT_QTY         Ctrl=EM_TOT_QTY4            param=Text</c>
            <c>Col=OLD_SALE_TAMT       Ctrl=EM_OLD_SALE_TAMT4      param=Text</c>
            <c>Col=NEW_SALE_TAMT       Ctrl=EM_NEW_SALE_TAMT4      param=Text</c>
            <c>Col=REMARK              Ctrl=EM_REMARK4             param=Text</c>
                                                                  
            <c>Col=STR_CD              Ctrl=LC_STR4                param=BindColVal</c>
            <c>Col=AFT_ORD_FLAG        Ctrl=LC_AFT_ORD_FLAG4       param=BindColVal</c>
            <c>Col=BIZ_TYPE            Ctrl=EM_BIZ_TYPE4           param=Text</c>
            <c>Col=TAX_FLAG            Ctrl=EM_TAX_FLAG4           param=Text</c>
            <c>Col=OLD_EVENT_CD        Ctrl=LC_OLD_EVENT_CD4       param=BindColVal</c>
            <c>Col=NEW_EVENT_CD        Ctrl=LC_NEW_EVENT_CD4       param=BindColVal</c>
            <c>Col=INC_RSN_CD          Ctrl=LC_INC_RSN_CD4         param=BindColVal</c>
            <c>Col=INC_FLAG            Ctrl=LC_INC_FLAG4           param=BindColVal</c>
            
            
            
        '>
    </object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER5>
        <param name="ActiveBind"    value=true>
    <param name=BindInfo
        value='
        <c>Col=PUMBUN_CD            Ctrl=EM_I_PUMBUN_CD5             param=Text</c>         
        <c>Col=PUMBUN_NAME          Ctrl=EM_O_PUMBUN_NM5             param=Text</c>        
        <c>Col=BUYER_CD             Ctrl=EM_I_BUYER_CD5              param=Text</c> 
        <c>Col=BUYER_NM             Ctrl=EM_O_BUYER_NM5              param=Text</c> 
        <c>Col=VEN_CD               Ctrl=EM_I_VEN_CD5                param=Text</c> 
        <c>Col=VEN_NAME             Ctrl=EM_O_VEN_NM5                param=Text</c> 
        <c>Col=SKU_TYPE_NM          Ctrl=EM_SKU_FLAG_NM5             param=Text</c> 
        <c>Col=BIZ_TYPE_NM          Ctrl=EM_BIZ_TYPE_NM5             param=Text</c> 
        <c>Col=TAX_FLAG             Ctrl=EM_TAX_FLAG5                param=Text</c> 
        <c>Col=TAX_FLAG_NM          Ctrl=EM_TAX_FLAG_NM5             param=Text</c> 
        
        <c>Col=OFFER_SHEET_NO       Ctrl=EM_I_OFFER_NO5              param=Text</c> 
        <c>Col=SLIP_NO              Ctrl=EM_I_SLIP_NO5               param=Text</c> 
        <c>Col=OFFER_DT             Ctrl=EM_O_OFFER_DT5              param=Text</c>   
        <c>Col=INVOICE_DT           Ctrl=EM_I_INVOICE_DT5            param=Text</c> 
        <c>Col=INVOICE_NO           Ctrl=EM_I_INVOICE_NO5            param=Text</c>   
        <c>Col=BL_NO                Ctrl=EM_I_BL_NO5                 param=Text</c> 
        <c>Col=SHIP_PORT            Ctrl=EM_I_SHIP_PORT5             param=Text</c>   
        <c>Col=ETD                  Ctrl=EM_I_ETD5                   param=Text</c> 
        <c>Col=ETA                  Ctrl=EM_I_ETA5                   param=Text</c>   
        <c>Col=LC_DATE              Ctrl=EM_I_LC_DATE5               param=Text</c> 
        <c>Col=LC_NO                Ctrl=EM_I_LC_NO5                 param=Text</c>   
        <c>Col=EXC_APP_DT           Ctrl=EM_I_EXC_APP_DT5            param=Text</c> 
        <c>Col=EXC_RATE             Ctrl=EM_I_EXC_RATE5              param=Text</c>   
        <c>Col=ENTRY_DT             Ctrl=EM_I_ENTRY_DT5              param=Text</c> 
        <c>Col=IMPORT_NO            Ctrl=EM_I_IMPORT_NO5             param=Text</c>   
        <c>Col=PACKING_CHARGE       Ctrl=EM_I_PACKING_CHARGE5        param=Text</c> 
        <c>Col=NCV                  Ctrl=EM_I_NCV5                   param=Text</c>   
        <c>Col=INVOICE_WON_TOT_AMT  Ctrl=EM_I_INVOICE_AMT5           param=Text</c> 
        <c>Col=PRC_APP_DT           Ctrl=EM_I_PRC_APP_DT5            param=Text</c>   
        <c>Col=DELI_DT              Ctrl=EM_I_DELI_DT5               param=Text</c>   
        <c>Col=CHK_DT               Ctrl=EM_I_CHK_DT5                param=Text</c>   
        <c>Col=INVOICE_TOT_QTY      Ctrl=EM_I_INVOICE_TOT_QTY5       param=Text</c>   
        <c>Col=INVOICE_TOT_AMT      Ctrl=EM_I_INVOICE_TOT_AMT5       param=Text</c> 
        <c>Col=SALE_TOT_AMT         Ctrl=EM_I_SALE_TOT_AMT5          param=Text</c>     
        <c>Col=REMARK               Ctrl=EM_I_REMARK5                param=Text</c>     
        <c>Col=GAP_RATE             Ctrl=EM_TOT_GAP_RATE5            param=Text</c>     
        <c>Col=GAP_TOT_AMT          Ctrl=EM_TOT_GAP_AMT5             param=Text</c>  
        <c>Col=SLIP_PROC_STAT_NM    Ctrl=EM_O_SLIP_FLAG5             param=Text</c>     
                
        <c>Col=STR_CD               Ctrl=LC_I_STR_CD5                param=BindColVal</c> 
        <c>Col=IMPORT_COUNTRY       Ctrl=LC_I_IMPORT_COUNTRY5        param=BindColVal</c> 
        <c>Col=ARRI_PORT            Ctrl=LC_I_ARRI_PORT5             param=BindColVal</c> 
        <c>Col=PRC_COND             Ctrl=LC_I_PRC_COND5              param=BindColVal</c> 
        <c>Col=PAYMENT_COND         Ctrl=LC_I_PAYMENT_COND5          param=BindColVal</c> 
        <c>Col=PAYMENT_DTL_COND     Ctrl=LC_I_PAYMENT_DTL_COND5      param=BindColVal</c> 
        <c>Col=CURRENCY_CD          Ctrl=LC_I_CURRENCY_CD5           param=BindColVal</c> 
        '>
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_IO_MASTER6>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            
        <c>Col=SLIP_NO             Ctrl=EM_O_SLIP_NO6               param=Text</c>
        <c>Col=SLIP_PROC_STAT_NM   Ctrl=EM_O_SLIP_PROC_STAT_NM6     param=Text</c>
        
        <c>Col=PUMBUN_CD        Ctrl=EM_I_PB_CD6     param=Text</c>
        <c>Col=PUMBUN_NM        Ctrl=EM_I_PB_NM6     param=Text</c>        
        <c>Col=VEN_CD           Ctrl=EM_O_HRS_CD6    param=Text</c>
        <c>Col=VEN_NM           Ctrl=EM_O_HRS_NM6    param=Text</c>
        <c>Col=ORD_OWN_FLAG_NM  Ctrl=EM_O_BALJUJC6   param=Text</c>
        <c>Col=ORD_DT           Ctrl=EM_I_BJDATE6    param=Text</c>
        <c>Col=DELI_DT          Ctrl=EM_I_NPYJDATE6  param=Text</c>
        <c>Col=CHK_DT           Ctrl=EM_O_GPWJ_DATE6 param=Text</c> 
        <c>Col=ORD_CONF_DT      Ctrl=EM_I_BJHJDATE6  param=Text</c>
        <c>Col=MG_APP_DT        Ctrl=EM_I_MAJINDATE6 param=Text</c>
        <c>Col=BUYER_CD         Ctrl=EM_O_BUYER_CD6  param=Text</c>
        <c>Col=BUYER_NM         Ctrl=EM_O_BUYER_NM6  param=Text</c>
        <c>Col=TAX_FLAG_NM      Ctrl=EM_O_GS_GBN6    param=Text</c>
        <c>Col=TAX_FLAG         Ctrl=EM_TAX_FLAG6    param=Text</c>
        <c>Col=REMARK           Ctrl=EM_O_ETC6       param=Text</c>
        <c>Col=ORD_TOT_QTY      Ctrl=EM_O_SRG6       param=Text</c>
        <c>Col=NEW_COST_TAMT    Ctrl=EM_O_WGG6       param=Text</c>
        <c>Col=NEW_SALE_TAMT    Ctrl=EM_O_MGG6       param=Text</c>     
        <c>Col=MG_RATE          Ctrl=EM_O_MG_RATE    param=Text</c>   
        
        <c>Col=STR_CD           Ctrl=LC_I_STORE6     param=BindColVal</c>   
        <c>Col=AFT_ORD_FLAG     Ctrl=LC_I_SH_GBN6    param=BindColVal</c>
        <c>Col=EVENT_FLAG       Ctrl=LC_I_HS_GBN6    param=BindColVal</c>
        <c>Col=EVENT_RATE       Ctrl=LC_I_HS_RATE6   param=BindColVal</c>
        <c>Col=SLIP_FLAG        Ctrl=RD_SLIP_FLAG6   param=CodeValue</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<body>
</html>

