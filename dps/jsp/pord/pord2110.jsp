<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주결재 > 단품발주검품확정
 * 작 성 일 : 2010.04.19
 * 작 성 자 : 신명섭
 * 수 정 자 : 
 * 파 일 명 : pord2110.jsp
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

var g_listChkCnt      = 0;                             // 리스트체크카운트
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자    : 김경은
 * 작 성 일     : 2010-02-14
 * 개    요        : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top  = 165;		//해당화면의 동적그리드top위치
 var top2 = 440;		//해당화면의 동적그리드top위치
 function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_LIST"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	//Master 그리드 세로크기자동조정  2013-07-17
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
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    DS_IO_DETAIL1.setDataHeader('<gauce:dataset name="H_DETAIL1"/>');//대출입
    DS_IO_DETAIL2.setDataHeader('<gauce:dataset name="H_DETAIL1"/>');//대출입
    DS_IO_DETAIL3.setDataHeader('<gauce:dataset name="H_DETAIL3"/>');//점출입
    DS_IO_DETAIL4.setDataHeader('<gauce:dataset name="H_DETAIL4"/>');//매가인상하
    DS_IO_DETAIL5.setDataHeader('<gauce:dataset name="H_DETAIL5"/>');//수입
    DS_O_CHK_SLIP_FLAG.setDataHeader('<gauce:dataset name="H_CHK_SLIP_FLAG"/>'); //전표진행상태
    DS_O_SKU_INFO.setDataHeader('<gauce:dataset name="H_SKU_INFO"/>');
    DS_O_TEAM.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_PC.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_OFFER_CLOSE.setDataHeader('<gauce:dataset name="H_OFFER_CLOSE"/>');  // 수입 OFFER마감체크
    DS_PAY_CLOSE_CHK.setDataHeader('<gauce:dataset name="H_PAY_CLOSE_CHK"/>');     //대금지불마감체크
    DS_APPDT_PRICE.setDataHeader('<gauce:dataset name="H_APPDT_PRICE"/>');
    DS_TAX_YN.setDataHeader('<gauce:dataset name="H_TAX_YN"/>');                   //세금계산서 발행여부체크
    DS_CHK_JG_FLAG.setDataHeader('<gauce:dataset name="H_CHK_JG_FLAG"/>');         //재고실사마감여부
    
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
    

    // EMedit에 초기화 (조회용)
   // initEmEdit(RD_S_SLIP_FLAG,  "GEN",         NORMAL);         // 전표구분      
    initEmEdit(EM_S_START_DT,         "SYYYYMMDD",     NORMAL);         // 조회기간1
    initEmEdit(EM_S_END_DT,           "TODAY",         NORMAL);         // 조회기간2
    initEmEdit(EM_S_PB_CD,            "000000",        NORMAL);         // 브랜드코드
    initEmEdit(EM_S_PB_NM,            "GEN",           READ);           // 브랜드명     
    initEmEdit(EM_S_VEN_CD,           "000000",        NORMAL);         // 협력사코드
    initEmEdit(EM_S_VEN_NM,           "GEN",           READ);           // 협력사코드명
    initEmEdit(EM_S_SLIP_NO,          "0000-0-0000000",  NORMAL);         // 전표번호  

    // EMedit에 초기화 (입력용):매입,반품
    //initEmEdit(EM_SLIP_NO,           "GEN^11"     , READ);            // 전표번호
    initEmEdit(EM_SLIP_NO           , "0000-0-0000000"  ,READ);           // 전표번호
    initEmEdit(EM_SLIP_PROC_STAT_NM,  "GEN^40"        ,READ);           // 전표상태  
//     initEmEdit(RD_SLIP_FLAG,          "GEN"           ,READ);           // 전표구분          
    initEmEdit(EM_PUMBUN_CD,          "000000"        ,READ);           // 브랜드코드  
    initEmEdit(EM_PUMBUN_NM,          "GEN"           ,READ);           // 브랜드명
    initEmEdit(EM_BUYER_CD,           "GEN"           ,READ);           // 바이어코드
    initEmEdit(EM_BUYER_NM,           "GEN"           ,READ);           // 바이어명
    initEmEdit(EM_BIZ_TYPE_NM,        "GEN"           ,READ);           // 거래형태
    initEmEdit(EM_TAX_FLAG_NM,        "GEN"           ,READ);           // 과세구분
    initEmEdit(EM_ORD_FLAG,           "GEN"           ,READ);           // 발주구분
    initEmEdit(EM_VEN_CD,             "000000"        ,READ);           // 협력사코드
    initEmEdit(EM_VEN_NM,             "GEN"           ,READ);           // 협력사명
    initEmEdit(EM_ORD_OWN_FLAG,       "GEN"           ,READ);           // 발주주체
    initEmEdit(EM_ORD_DT,             "YYYYMMDD"      ,READ);           // 발주일
    initEmEdit(EM_CONF_DT,            "YYYYMMDD"      ,READ);           // 발주확정일
    initEmEdit(EM_DELI_DT,            "YYYYMMDD"      ,READ);           // 납품예정일
    initEmEdit(EM_PRC_APP_DT,         "YYYYMMDD"      ,READ);           // 가격적용일
    initEmEdit(EM_CHK_DT,             "YYYYMMDD"      ,PK);             // 검품확정일 -SHIN
    initEmEdit(EM_GAP_TOT_AMT,        "NUMBER^13^0"   ,READ);           // 차익액 
    initEmEdit(EM_GAP_RATE,           "NUMBER^3^2"    ,READ);           // 차익율
    initEmEdit(EM_TOT_QTY,            "NUMBER^13^1"   ,READ);           // 수량계
    initEmEdit(EM_TOT_COST_AMT,       "NUMBER^13^0"   ,READ);           // 원가계
    initEmEdit(EM_TOT_SALE_AMT,       "NUMBER^13^0"   ,READ);           // 매가계
    initEmEdit(EM_TOT_TAX,            "NUMBER^13^0"   ,READ);           // 부가세계
    initEmEdit(EM_REMARK,             "GEN^100"       ,READ);           // 비고
    
    // EMedit에 초기화 (입력용) :대출입 :REV2010
    //initEmEdit(EM_SLIP_NO1,           "GEN"        , READ);           // 전표번호
    initEmEdit(EM_SLIP_NO1,           "0000-0-0000000"    ,READ);         // 전표번호
    initEmEdit(EM_PROC_STAT1,         "GEN"             ,READ);         // 전표상태
    initEmEdit(EM_PUMBUN_CD1,         "000000"          ,READ);         // 대출브랜드코드     
    initEmEdit(EM_PUMBUN_NM1,         "GEN"             ,READ);         // 대출브랜드명
    initEmEdit(EM_TAX_FLAG1,          "GEN"             ,READ);         // 대출과세구분
    initEmEdit(EM_TAX_FLAG_NM1,       "GEN"             ,READ);         // 대출과세구분명
    initEmEdit(EM_P_PUMBUN_CD1,       "000000"          ,READ);         // 대입브랜드코드     
    initEmEdit(EM_P_PUMBUN_NM1,       "GEN"             ,READ);         // 대입브랜드명
    initEmEdit(EM_P_TAX_FLAG1,        "GEN"             ,READ);         // 대입과세구분
    initEmEdit(EM_P_TAX_FLAG_NM1,     "GEN"             ,READ);         // 대입과세구분명
   // initEmEdit(EM_P_SLIP_NO1,       "GEN"             ,READ);         // 상대전표번호
    initEmEdit(EM_P_SLIP_NO1,         "0000-0-0000000"    ,READ);         // 상대전표번호
    initEmEdit(EM_S_PROC_STAT1,       "GEN"             ,READ);         // 상대전표상태
    initEmEdit(EM_BUYER_CD1,          "GEN"             ,READ);         // 바이어코드
    initEmEdit(EM_P_BUYER_CD1,        "GEN"             ,READ);         // 대입바이어코드
    initEmEdit(EM_BUYER_NM1,          "GEN"             ,READ);         // 바이어명
    initEmEdit(EM_ORD_DT1,            "YYYYMMDD"        ,READ);         // 발주일
    initEmEdit(EM_DELI_DT1,           "YYYYMMDD"        ,READ);         // 시행일(납품예정일)
    initEmEdit(EM_PRC_APP_DT1,        "YYYYMMDD"        ,READ);         // 가격적용일
    initEmEdit(EM_CHK_DT1,            "YYYYMMDD"        ,PK);           // 검품확정일
    initEmEdit(EM_GAP_TOT_AMT1,       "NUMBER^13^0"     ,READ);         // 차익액 
    initEmEdit(EM_GAP_RATE1,          "NUMBER^3^2"      ,READ);         // 차익율
    initEmEdit(EM_TOT_QTY1,           "NUMBER^13^0"     ,READ);         // 수량계
    initEmEdit(EM_TOT_COST_AMT1,      "NUMBER^13^0"     ,READ);         // 원가계
    initEmEdit(EM_TOT_SALE_AMT1,      "NUMBER^13^0"     ,READ);         // 매가계
    initEmEdit(EM_REMARK1,            "GEN^100"         ,READ);         // 비고
    
 // EMedit에 초기화 (입력용) :점출입       
    //initEmEdit(EM_E_SLIP_NO3,       "GEN"        , READ);             // 점출전표번호
    initEmEdit(EM_E_SLIP_NO3         ,"0000-0-0000000"    ,READ);         // 전표번호
   // initEmEdit(EM_F_SLIP_NO3,       "GEN"        , READ);             // 점입전표번호
    initEmEdit(EM_F_SLIP_NO3         ,"0000-0-0000000"    ,READ);         // 전표번호
    initEmEdit(EM_E_PROC_STAT3,       "GEN"             ,READ);         // 점출전표상태
    initEmEdit(EM_F_PROC_STAT3,       "GEN"             ,READ);         // 점입전표상태
    initEmEdit(EM_PUMBUN_CD3,         "000000"          ,READ);         // 점출브랜드코드     
    initEmEdit(EM_PUMBUN_NM3,         "GEN"             ,READ);         // 점출브랜드명
    initEmEdit(EM_TAX_FLAG3,          "GEN"             ,READ);         // 점출과세구분
    initEmEdit(EM_TAX_FLAG_NM3,       "GEN"             ,READ);         // 점출과세구분명
    initEmEdit(EM_P_PUMBUN_CD3,       "000000"          ,READ)          // 점입브랜드코드     
    initEmEdit(EM_P_PUMBUN_NM3,       "GEN"             ,READ);         // 점입브랜드명
    initEmEdit(EM_P_TAX_FLAG3,        "GEN"             ,READ);         // 점입과세구분
    initEmEdit(EM_P_TAX_FLAG_NM3,     "GEN"             ,READ);         // 점입과세구분명
    initEmEdit(EM_P_SLIP_NO3,         "GEN"             ,READ);         // 상대전표번호
    initEmEdit(EM_S_PROC_STAT3,       "GEN"             ,READ);         // 상대전표상태
    initEmEdit(EM_BUYER_CD3,          "GEN"             ,READ);         // 바이어코드
    initEmEdit(EM_P_BUYER_CD3,        "GEN"             ,READ);         // 점입바이어코드
    initEmEdit(EM_BUYER_NM3,          "GEN"             ,READ);         // 바이어명
    initEmEdit(EM_ORD_DT3,            "YYYYMMDD"        ,READ);         // 점출예정일
    initEmEdit(EM_DELI_DT3,           "YYYYMMDD"        ,READ);         // 점입예정일
    initEmEdit(EM_PRC_APP_DT3,        "YYYYMMDD"        ,READ);         // 가격적용일
    initEmEdit(EM_CHK_DT3,            "YYYYMMDD"        ,PK);           // 검품확정일
    initEmEdit(EM_GAP_TOT_AMT3,       "NUMBER^13^0"     ,READ);         // 차익액 
    initEmEdit(EM_GAP_RATE3,          "NUMBER^3^2"      ,READ);         // 차익율
    initEmEdit(EM_TOT_QTY3,           "NUMBER^13^0"     ,READ);         // 수량계
    initEmEdit(EM_TOT_COST_AMT3,      "NUMBER^13^0"     ,READ);         // 원가계
    initEmEdit(EM_TOT_SALE_AMT3,      "NUMBER^13^0"     ,READ);         // 매가계
    initEmEdit(EM_REMARK3,            "GEN^100"         ,READ);         // 비고
  
 // EMedit에 초기화 (입력용) : 매가 인상하
    //initEmEdit(EM_SLIP_NO4,           "GEN^11"     , READ);           // 전표번호
    initEmEdit(EM_SLIP_NO4           ,"0000-0-0000000"    ,READ);           // 전표번호
    initEmEdit(EM_SLIP_PROC_STAT_NM4, "GEN^40"     , READ);           // 전표상태  
    initEmEdit(EM_PUMBUN_CD4,         "000000"     , READ);             // 브랜드코드  
    initEmEdit(EM_PUMBUN_NM4,         "GEN"        , READ);           // 브랜드명
    initEmEdit(EM_BUYER_CD4,          "GEN"        , READ);           // 바이어코드
    initEmEdit(EM_BUYER_NM4,          "GEN"        , READ);           // 바이어명
    initEmEdit(EM_TAX_FLAG_NM4,       "GEN"        , READ);           // 과세구분
    initEmEdit(EM_ORD_DT4,            "YYYYMMDD"   , READ);             // 발주일
    initEmEdit(EM_DELI_DT4,           "YYYYMMDD"   , READ);             // 시행일
    initEmEdit(EM_CHK_DT4,            "YYYYMMDD"   , PK);           // 검품확정일
    initEmEdit(EM_OLD_PRC_APP_DT4,    "YYYYMMDD"   , READ);             // 구가격적용일
    initEmEdit(EM_NEW_PRC_APP_DT4,    "YYYYMMDD"   , READ);             // 신가격적용일
    initEmEdit(EM_GAP_TOT_AMT4,       "NUMBER^13^0", READ);           // 차익액 
//    initEmEdit(EM_GAP_RATE,        "NUMBER^3^2" , READ);           // 차익율
    initEmEdit(EM_TOT_QTY4,           "NUMBER^13^0", READ);           // 수량계
    initEmEdit(EM_OLD_SALE_TAMT4,     "NUMBER^13^0", READ);           // 구매가계
    initEmEdit(EM_NEW_SALE_TAMT4,     "NUMBER^13^0", READ);           // 신매가계
    initEmEdit(EM_REMARK4,            "GEN^100"    , READ);         // 비고
    
    initEmEdit(EM_I_OFFER_NO5,           "GEN^30^",     READ);            //OFFER NO   X 
    initEmEdit(EM_O_OFFER_DT5,           "YYYYMMDD",    READ);          //OFFER DT   X 
    //initEmEdit(EM_I_SLIP_NO5,            "GEN^11",      READ);          //전표번호
    initEmEdit(EM_I_SLIP_NO5           ,"0000-0-0000000"    ,READ);           // 전표번호 
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
    initEmEdit(EM_CHK_DT5,               "YYYYMMDD",    PK);          //검품확정일             
    initEmEdit(EM_I_INVOICE_TOT_QTY5,    "NUMBER^7^0",  READ);          //수량계
    initEmEdit(EM_I_INVOICE_TOT_AMT5,    "NUMBER^13^2", READ);          //원가계
    initEmEdit(EM_I_SALE_TOT_AMT5,       "NUMBER^13^2", READ);          //매가계
    initEmEdit(EM_TOT_TAX5,              "NUMBER^13^0", READ);           //부가세계
    initEmEdit(EM_I_REMARK5,             "GEN^100",     READ);        //비고    
    
    //숨겨진 컴퍼넌트
    initEmEdit(EM_BIZ_TYPE5,             "GEN^40",      READ);          //거래형태                  
    initEmEdit(EM_TAX_FLAG5,             "GEN^40",      READ);          //과세구분                    
    initEmEdit(EM_SKU_FLAG5,             "GEN^40",      READ);          //단품종류        
    initEmEdit(EM_BIZ_TYPE_NM5,          "GEN",         READ);          // 거래형태
    initEmEdit(EM_TAX_FLAG_NM5,          "GEN",         READ);          // 과세구분         
    initEmEdit(EM_SKU_FLAG_NM5,          "GEN",         READ);          // 단품종류        X   
    
    //콤보 초기화 (조회용)
    initComboStyle(LC_S_STR,         DS_O_STR,         "CODE^0^30,NAME^0^80", 1, NORMAL);     // 점     
    initComboStyle(LC_S_BUMUN,       DS_O_DEPT,        "CODE^0^30,NAME^0^80", 1, NORMAL);     // 팀     
    initComboStyle(LC_S_TEAM,        DS_O_TEAM,        "CODE^0^30,NAME^0^80", 1, NORMAL);     // 파트     
    initComboStyle(LC_S_PC,          DS_O_PC,          "CODE^0^30,NAME^0^80", 1, NORMAL);     // PC     
    initComboStyle(LC_S_GJDATE_TYPE, DS_O_GJDATE_TYPE, "CODE^0^30,NAME^0^80", 1, NORMAL);     // 기준일     
    initComboStyle(LC_S_S_PROC_STAT, DS_O_S_PROC_STAT, "CODE^0^30,NAME^0^80", 1, NORMAL);     // 전표상태     
      
    // 콤보초기화 (결과조회용)
    initComboStyle(LC_STR,           DS_O_STR,           "CODE^0^30,NAME^0^80", 1, READ);         // 점 
    initComboStyle(LC_AFT_ORD_FLAG,  DS_O_AFT_ORD_FLAG,  "CODE^0^30,NAME^0^80", 1, READ);         // 사후구분 
    initComboStyle(LC_PAY_COND,      DS_O_PAY_COND,      "CODE^0^30,NAME^0^80", 1, READ);         // 지불구분 
      // 대출입 : 콤보초기화 (결과조회용)
    initComboStyle(LC_STR1,           DS_O_STR,           "CODE^0^30,NAME^0^80", 1, READ);         // 점 
    initComboStyle(LC_AFT_ORD_FLAG1,  DS_O_AFT_ORD_FLAG,  "CODE^0^30,NAME^0^80", 1, READ);     // 사후구분
     
    // 점출입 : 콤보초기화 (결과조회용)
    initComboStyle(LC_STR3,           DS_O_STR,           "CODE^0^30,NAME^0^80", 1, READ);       // 점출점 
    initComboStyle(LC_P_STR3,         DS_O_STR,           "CODE^0^30,NAME^0^80", 1, READ);       // 점입점 
    initComboStyle(LC_AFT_ORD_FLAG3,  DS_O_AFT_ORD_FLAG,  "CODE^0^30,NAME^0^80", 1, READ);       // 사후구분 
    
    // 매가인상하 : 콤보초기화 (결과조회용)
    initComboStyle(LC_STR4,           DS_O_STR,           "CODE^0^30,NAME^0^80", 1, READ);         // 점 
    initComboStyle(LC_AFT_ORD_FLAG4,  DS_O_AFT_ORD_FLAG,  "CODE^0^30,NAME^0^80", 1, READ);         // 사후구분
    initComboStyle(LC_INC_FLAG4,      DS_O_INC_FLAG,      "CODE^0^30,NAME^0^80", 1, READ);         // 인상하구분
    initComboStyle(LC_OLD_EVENT_CD4 , DS_O_OLD_EVENT_CD,  "CODE^0^90,NAME^0^0", 1, READ);         // 구행사코드 
    initComboStyle(LC_NEW_EVENT_CD4 , DS_O_NEW_EVENT_CD,  "CODE^0^90,NAME^0^0", 1, READ);         // 신행사코드 
    initComboStyle(LC_INC_RSN_CD4,    DS_INC_RSN_CD,      "CODE^0^30,NAME^0^80", 1, READ);     // 인상하사유  
   
    // 수입 : 콤보초기화 (결과조회용)
    initComboStyle(LC_I_STR_CD5,            DS_STR,                 "CODE^0^30,NAME^0^80", 1, READ);      //점    
    initComboStyle(LC_I_IMPORT_COUNTRY5,    DS_I_IMPORT_COUNTRY,    "CODE^0^30,NAME^0^80", 1, READ);  //수입국가               
    initComboStyle(LC_I_ARRI_PORT5,         DS_I_ARRI_PORT,         "CODE^0^30,NAME^0^80", 1, READ);  //도착항   
    initComboStyle(LC_I_PRC_COND5,          DS_I_PRC_COND,          "CODE^0^30,NAME^0^80", 1, READ);  //가격조건            
    initComboStyle(LC_I_PAYMENT_COND5,      DS_I_PAYMENT_COND,      "CODE^0^30,NAME^0^80", 1, READ);  //결제조건            
    initComboStyle(LC_I_PAYMENT_DTL_COND5,  DS_I_PAYMENT_DTL_COND,  "CODE^0^30,NAME^0^80", 1, READ);  //결제조건 상세
    initComboStyle(LC_I_CURRENCY_CD5,       DS_I_CURRENCY,          "CODE^0^30,NAME^0^80", 1, READ);  //화폐단위   
    
    
    //공통코드에서 데이터 가지고 오기
    //getStrCode("DS_O_STR","N","N");                         // 점
    getEtcCode("DS_O_GJDATE_TYPE",   "D", "P214", "N");       // 기준일
   // getEtcCode("DS_O_S_PROC_STAT",   "D", "P207", "Y");       // 전표상태
    getEtcCode("DS_O_S_PROC_STAT",   "D", "P235", "N");       // 전표상태
    getEtcCode("DS_O_AFT_ORD_FLAG",  "D", "P209", "N");       // 사전사후구분
    getEtcCode("DS_O_PAY_COND",      "D", "P212", "N");       // 지불구분 
    getEtcCode("DS_O_BIZ_TYPE",      "D", "P002", "N");       // 거래형태 
    getEtcCode("DS_O_TAX_FLAG",      "D", "P004", "N");       // 과세구분
    getEtcCode("DS_O_ORD_FLAG",      "D", "P203", "N");       // 발주구분 
    getEtcCode("DS_O_ORD_OWN_FLAG",  "D", "P202", "N");       // 발주주체구분 
    getEtcCode("DS_O_INC_FLAG",       "D", "P226", "N");       // 인상하구분
    getEtcCode("DS_S_INC_RSN_CD",     "D", "P227", "Y");       // 인상하사유조회용
    getEtcCode("DS_INC_RSN_CD",       "D", "P227", "N");       // 인상하사유
    
    //공통코드에서 데이터 가지고 오기     
    getStore("DS_STR", "Y", "", "N");          
    getEtcCode("DS_I_CURRENCY",        "D", "P217", "N");      // 화폐단위 
    getEtcCode("DS_I_PRC_COND",        "D", "P218", "N");      // 가격조건 
    getEtcCode("DS_I_PAYMENT_COND",    "D", "P219", "N");      // 결제조건 
    getEtcCode("DS_I_PAYMENT_DTL_COND","D", "P220", "N");      // 결제조건상세 
    getEtcCode("DS_I_ARRI_PORT",       "D", "P222", "N");      // 도착항 
    getEtcCode("DS_I_IMPORT_COUNTRY",  "D", "P223", "N");      // 수입국가 

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
   
    LC_S_STR.Index         = 0; 
    LC_S_BUMUN.Index       = 0;
    LC_S_TEAM.Index        = 0;
    LC_S_PC.Index          = 0;  
    LC_S_GJDATE_TYPE.Index = 0;
    LC_S_S_PROC_STAT.Index = 0;//미확정 디폴트
    CHK_1.checked            = true;
    LC_S_STR.Focus();   
    
    registerUsingDataset("pord211","DS_O_LIST,DS_IO_MASTER,DS_IO_MASTER1,DS_IO_MASTER3,DS_IO_MASTER4,DS_IO_MASTER5,DS_IO_DETAIL,DS_IO_DETAIL1,DS_IO_DETAIL2,DS_IO_DETAIL3,DS_IO_DETAIL4,DS_IO_DETAIL5" );
 } 

 //리스트
 function gridCreate1(){
     var hdrProperies = '<FC>id=CHECK1             name="선택"        width=45    align=center EditStyle=CheckBox  HeadCheckShow=true </FC>'
                      + '<FC>id=SLIP_FLAG_NM       name="구분"        width=30    BgColor={decode(REJ_CAN_FLAG,1,"#C8FFFF",2,"#D2D2D2")} align=left  Edit=none </FC>'
                      + '<FC>id=SLIP_NO            name="전표번호"    width=110     align=center Edit=none Mask="XXXX-X-XXXXXXX" sumtext="합계"</FC>'
                      + '<FC>id=ORD_DT             name="발주일"      width=80     align=center Edit=none Mask="XXXX/XX/XX" </FC>'
                      + '<FC>id=SLIP_PROC_STAT_NM  name="전표상태"    width=80     align=left  Edit=none </FC>'
                      + '<FC>id=PUMBUN_NM          name="브랜드"        width=90   align=left Edit=none </FC>'
                      + '<FC>id=VEN_NM             name="협력사"      width=110    align=left Edit=none </FC>'
                      + '<FC>id=COST_TAMT          name="원가금액"    width=90   align=right Edit=none sumtext=@sum </FC>'
                      + '<FC>id=SALE_TAMT          name="매가금액"    width=90   align=right Edit=none sumtext=@sum </FC>'
                      + '<FC>id=STR_NM             name="점"          width=60     align=left Edit=none </FC>'
                      + '<FC>id=CHK_DT             name="검품확정일"   width=80     align=right Edit=none Mask="XXXX/XX/XX" </FC>';

     initGridStyle(GR_LIST, "common", hdrProperies, true);
 }

 function gridCreate2(){
      var hdrProperies =  '<FC>id={currow}          name="NO"          width=30     align=center sumtext=""</FC>'
                        + '<FC>id=SKU_CD            name="단품코드"     width=100   align=left Edit=None sumtext="합계"</FC>'                           
                        + '<FC>id=SKU_NM            name="단품명"       width=100   align=left Edit=None </FC>'                           
                        + '<FC>id=STYLE_CD          name="스타일"       width=90    align=left Edit=None </FC>'
                        + '<FC>id=COLOR_CD          name="칼라"         width=35    align=center Edit=None </FC>'
                        + '<FC>id=SIZE_CD           name="사이즈"       width=40    align=center Edit=None </FC>'
                        + '<FC>id=ORD_UNIT_NM       name="단위"         width=40    align=left Edit=None </FC>'                        
                        + '<FC>id=ORD_QTY           name="발주수량"     width=60    align=right Edit=None sumtext=@sum </FC>'
                        + '<FC>id=CHK_QTY           name="*검품수량"    width=60    align=right  Edit=Numeric sumtext=@sum </FC>'                
                        + '<FC>id=RATE              name="목표;이익율"   width=70    align=right  Edit=Numeric </FC>'                   
                        + '<FG> name="원가 (부가세 제외)"'       
                        + '<FC>id=NEW_COST_PRC      name="단가"         width=80    align=right Edit=None </FC>'                        
                        + '<FC>id=NEW_COST_AMT      name="금액"         width=100   align=right Edit=None sumtext=@sum </FC>'                        
                        + '</FG> '             
                        + '<FC>id=VAT_AMT           name="부가세"       width=60    align=right  Edit=Numeric sumtext=@sum </FC>'                                        
                        + '<FG> name="매가 (부가세 포함)"'                                       
                        + '<FC>id=NEW_SALE_PRC      name="단가"         width=80    align=right Edit=None </FC>'                        
                        + '<FC>id=NEW_SALE_AMT      name="금액"         width=100   align=right Edit=None sumtext=@sum </FC>'                        
                        + '</FG> '                                                    
                        + '<FC>id=NEW_GAP_RATE      name="차익율"       width=60    align=right Edit=None sumtext='+strSumText+' </FC>'
                        + '<FC>id=AVG_SALE_QTY      name="평균판매량"   width=70    align=right Edit=None sumtext=@sum </FC>'                           
                        + '<FC>id=AVG_SALE_AMT      name="평균판매액"   width=100   align=right Edit=None sumtext=@sum </FC>'                           
                        + '<FC>id=ORD_STK_QTY       name="현재고"       width50     align=right Edit=None sumtext=@sum </FC>'   ;   
     initGridStyle(GR_DETAIL, "common", hdrProperies, true);
 }
 /* 대출입 그리드 */
 function gridCreate3(){
      var hdrProperies = '<FC>id={currow}          name="NO"          width=30     align=center sumtext=""</FC>'                           
                       + '<FC>id=SKU_CD            name="단품코드"     width=110   align=center  EditStyle=Popup sumtext="합계"</FC>'                           
                       + '<FC>id=SKU_NM            name="단품명"       width=100   align=left Edit=none </FC>'                           
                       + '<FC>id=STYLE_CD          name="스타일"       width=82    align=left Edit=none </FC>'
                       + '<FC>id=COLOR_CD          name="칼라"         width=35    align=center Edit=none </FC>'
                       + '<FC>id=SIZE_CD           name="사이즈"       width=40    align=center Edit=none </FC>'                                               
                       + '<FC>id=ORD_UNIT_NM       name="단위"         width=40    align=left Edit=none </FC>'
                       + '<FC>id=ORD_QTY           name="발주수량"     width=60    align=right  Edit=none sumtext=@sum </FC>' 
                       + '<FC>id=CHK_QTY           name="검품수량"     width=60    align=right  Edit=none sumtext=@sum </FC>'                 
                       + '<FC>id=RATE              name="목표이익율"   width=70    align=right  Edit=Numeric </FC>'                   
                       + '<FC>id=NEW_COST_PRC      name="원가단가"     width=80    align=right Edit=none </FC>'                        
                       + '<FC>id=NEW_COST_AMT      name="원가금액"     width=100   align=right Edit=none sumtext=@sum </FC>'                                                         
                       + '<FC>id=NEW_SALE_PRC      name="매가단가"     width=80    align=right Edit=none </FC>'                        
                       + '<FC>id=NEW_SALE_AMT      name="매가금액"     width=100   align=right Edit=none sumtext=@sum </FC>'                                   
                       + '<FC>id=NEW_GAP_RATE      name="차익율"       width=80    align=right Edit=none sumtext='+strSumText+' </FC>';    
     initGridStyle(GR_DETAIL1, "common", hdrProperies, false);
 }
 function gridCreate4(){
     var hdrProperies = '<FC>id={currow}          name="NO"           width=30    align=center sumtext=""</FC>'                           
                      + '<FC>id=SKU_CD            name="단품코드"     width=110   align=left EditStyle=Popup </FC>'                           
                      + '<FC>id=SKU_NM            name="단품명"       width=100   align=left Edit=none </FC>'                           
                      + '<FC>id=STYLE_CD          name="스타일"       width=82    align=left Edit=none </FC>'
                      + '<FC>id=COLOR_CD          name="칼라"         width=35    align=center Edit=none </FC>'
                      + '<FC>id=SIZE_CD           name="사이즈"       width=40    align=center Edit=none </FC>'                                                    
                      + '<FC>id=ORD_UNIT_NM       name="단위"         width=40    align=left Edit=none </FC>'
                      + '<FC>id=ORD_QTY           name="발주수량"     width=60    align=right  Edit=none</FC>' 
                      + '<FC>id=CHK_QTY           name="검품수량"     width=60    align=right  Edit=none</FC>'                  
                      + '<FC>id=RATE              name="목표이익율"   width=70    align=right  Edit=Numeric </FC>'                   
                      + '<FC>id=NEW_COST_PRC      name="원가단가"     width=80    align=right Edit=none </FC>'                        
                      + '<FC>id=NEW_COST_AMT      name="원가금액"     width=100   align=right Edit=none </FC>'                                                             
                      + '<FC>id=NEW_SALE_PRC      name="매가단가"     width=80    align=right Edit=none </FC>'                        
                      + '<FC>id=NEW_SALE_AMT      name="매가금액"     width=100   align=right Edit=none  </FC>'                                                             
                      + '<FC>id=NEW_GAP_RATE      name="차익율"       width=80    align=right Edit=none </FC>';   
     initGridStyle(GR_DETAIL2, "common", hdrProperies, false);
 }
 function gridCreate5(){
     var hdrProperies = '<FC>id={currow}          name="NO"           width=30    align=center sumtext=""</FC>'                          
                      + '<FC>id=SKU_CD            name="단품코드"     width=110   align=left EditStyle=Popup sumtext="합계"</FC>'                           
                      + '<FC>id=SKU_NM            name="단품명"       width=100   align=left Edit=None </FC>'                    
                      + '<FC>id=STYLE_CD          name="스타일"       width=90    align=left Edit=None </FC>'
                      + '<FC>id=COLOR_CD          name="칼라"         width=35    align=center Edit=None </FC>'
                      + '<FC>id=SIZE_CD           name="사이즈"       width=40    align=center Edit=None </FC>'
                      + '<FC>id=ORD_UNIT_NM       name="단위"         width=40    align=left Edit=None </FC>'                                                     
                      + '<FC>id=ORD_QTY           name="발주수량"     width=60    align=right Edit=None sumtext=@sum </FC>' 
                      + '<FC>id=CHK_QTY           name="검품수량"     width=60    align=right  Edit=None sumtext=@sum </FC>'                 
                      + '<FC>id=RATE              name="목표;이익율"   width=70    align=right  Edit=Numeric </FC>'                   
                      + '<FG> name="원가 (부가세 제외)"'                                       
                      + '<FC>id=NEW_COST_PRC      name="단가"         width=80    align=right Edit=None </FC>'                        
                      + '<FC>id=NEW_COST_AMT      name="금액"         width=100   align=right Edit=None sumtext=@sum </FC>'                        
                      + '</FG> '                                                    
                      + '<FG> name="매가 (부가세 포함)"'                                       
                      + '<FC>id=NEW_SALE_PRC      name="단가"         width=80    align=right Edit=None </FC>'                        
                      + '<FC>id=NEW_SALE_AMT      name="금액"         width=100   align=right Edit=None sumtext=@sum </FC>'                        
                      + '</FG> '                                                    
                      + '<FC>id=NEW_GAP_RATE      name="차익율"       width=80    align=right Edit=None sumtext='+strSumText+' </FC>';   
     initGridStyle(GR_DETAIL3, "common", hdrProperies, false);
 }
 function gridCreate6(){
     var hdrProperies = '<FC>id={currow}          name="NO"           width=30   align=center sumtext=""</FC>'
                      + '<FC>id=SKU_CD            name="단품코드"     width=110   align=left EditStyle=Popup sumtext="합계"</FC>'                           
                      + '<FC>id=SKU_NM            name="단품명"       width=100   align=left Edit=none </FC>'      
                      + '<FC>id=STYLE_CD          name="스타일"       width=90    align=left Edit=none </FC>'
                      + '<FC>id=COLOR_CD          name="칼라"         width=35    align=center Edit=none </FC>'
                      + '<FC>id=SIZE_CD           name="사이즈"       width=40    align=center Edit=none </FC>'
                      + '<FC>id=ORD_UNIT_NM       name="단위"         width=40    align=left Edit=none </FC>'                                                     
                      + '<FC>id=ORD_QTY           name="발주수량"     width=60    align=right Edit=none sumtext=@sum </FC>' 
                      + '<FC>id=CHK_QTY           name="검품수량"     width=60    align=right  Edit=none </FC>'
                      + '<FC>id=OLD_COST_PRC      name="신원가"       width=80    align=right show=false edit=none</FC>'                                    
                      + '<FC>id=OLD_COST_AMT      name="신원가금액"   width=100   align=right show=false edit=none</FC>'                                               
                      + '<FC>id=NEW_COST_PRC      name="구원가"       width=80    align=right show=false edit=none</FC>'                                               
                      + '<FC>id=NEW_COST_AMT      name="구원가금액"   width=100   align=right show=false edit=none</FC>'                           
                      + '<FG> name="구매가"'                                       
                      + '<FC>id=OLD_SALE_PRC      name="단가"         width=80    align=right Edit=none </FC>'                        
                      + '<FC>id=OLD_SALE_AMT      name="금액"         width=100   align=right Edit=none sumtext=@sum </FC>'                        
                      + '</FG> '                                                    
                      + '<FG> name="신매가"'                                       
                      + '<FC>id=NEW_SALE_PRC      name="단가"         width=80    align=right Edit=none </FC>'                        
                      + '<FC>id=NEW_SALE_AMT      name="금액"         width=100   align=right Edit=none sumtext=@sum </FC>'                        
                      + '</FG> ' 
                      + '<FC>id=GAP_SALE_AMT      name="차익액"       width=80    align=right Edit=none sumtext=@sum </FC>';   
     initGridStyle(GR_DETAIL4, "common", hdrProperies, false);
 }
 function gridCreate7(){
     var hdrProperies = '<FC>id={currow}             name="NO"        width=30     align=center  Edit=none sumtext=""    </FC>'
                     + '<FC>id=PUMMOK_CD             name="품목코드"   width=10     align=left    SHOW=FALSE/FC>'
                     + '<FC>id=SKU_CD                name="단품코드"   width=110    align=left   EditStyle=Popup sumtext="합계" </FC>'
                     + '<FC>id=SKU_NM                name="단품명"     width=140    align=left   Edit=none </FC>'
                     + '<FC>id=STYLE_CD              name="스타일코드" width=210    align=left   Edit=none </FC>'
                     + '<FC>id=COLOR_CD              name="칼라"       width=60     align=left   Edit=none </FC>'
                     + '<FC>id=SIZE_CD               name="사이즈"     width=60     align=left   Edit=none </FC>'
                     + '<FC>id=MODEL_NO              name="모델코드"   width=80     align=left   Edit=none </FC>'
                     + '<FC>id=ORD_UNIT_CD           name="단위코드"   width=40     align=center Edit=none SHOW=FALSE</FC>'
                     + '<FC>id=ORD_UNIT_NM           name="단위"       width=40     align=left   Edit=none </FC>'
                     + '<FC>id=ORD_QTY               name="발주수량"   width=60     align=rigth  Edit=none sumtext=@sum </FC>'
                     + '<FC>id=CHK_QTY               name="*검품수량"  width=60     align=right  Edit=Numeric sumtext=@sum </FC>' 
                     + '<FG> name="원가 (부가세 제외)"'
                     + '<FC>id=EXC_PRC               name="외화단가"   width=80      align=right  sumtext=@sum </FC>'
                     + '<FC>id=NEW_COST_PRC          name="원화단가"   width=100    align=right  Edit=none  sumtext=@sum </FC>'
                     + '<FC>id=EXC_AMT               name="외화금액"   width=80     align=right  Edit=none  sumtext=@sum </FC>'
                     + '<FC>id=NEW_COST_AMT          name="원화금액"   width=100    align=right  Edit=none  sumtext=@sum </FC>'
                     + '</FG>'
                     + '<FC>id=VAT_AMT               name="부가세"     width=60     align=right  Edit=Numeric sumtext=@sum </FC>' 
                     + '<FG> name="매가 (부가세 포함)"'
                     + '<FC>id=NEW_SALE_PRC          name="단가"       width=80     align=right Edit=none sumtext=@sum </FC>'
                     + '<FC>id=NEW_SALE_AMT          name="금액"       width=120    align=right Edit=none  sumtext=@sum </FC></FG>'
                     + '<FC>id=NEW_GAP_RATE          name="차익율"     width=60     align=right Edit=none  sumtext=@sum </FC>'
                     + '<FC>id=NEW_GAP_AMT           name="차익액"     width=60     align=right Edit=none  SHOW=FALSE</FC>';                       

        initGridStyle(GR_DETAIL5, "common", hdrProperies, false);
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
	g_listChkCnt = 0;
	    
    switch(getTabItemSelect("TAB_MAIN")){
    case 1:
         if (DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated){
             if( showMessage(QUESTION, YESNO, "USER-1073") != 1 )
                return;
         }
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
         if (DS_IO_DETAIL1.IsUpdated || DS_IO_MASTER1.IsUpdated){
             if( showMessage(QUESTION, YESNO, "USER-1073") != 1 )
                return;
         }
        
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
         if (DS_IO_DETAIL3.IsUpdated || DS_IO_MASTER3.IsUpdated){
             if( showMessage(QUESTION, YESNO, "USER-1073") != 1 )
                return;
         }        
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
         if (DS_IO_DETAIL4.IsUpdated || DS_IO_MASTER4.IsUpdated){
             if( showMessage(QUESTION, YESNO, "USER-1073") != 1 )
                return;
         }        
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
         if (DS_IO_DETAIL5.IsUpdated || DS_IO_MASTER5.IsUpdated){
             if( showMessage(QUESTION, YESNO, "USER-1073") != 1 )
                return;
         }
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
     }    

    DS_IO_MASTER.ResetStatus();
    DS_IO_MASTER1.ResetStatus();
    DS_IO_MASTER3.ResetStatus();
    DS_IO_MASTER4.ResetStatus();
    DS_IO_MASTER5.ResetStatus();
    DS_IO_DETAIL.ResetStatus();
    DS_IO_DETAIL5.ResetStatus();
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
	 
    if(!confRej())
        return;
    
    btn_Search();  
 }

 /**
  * confRej()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-07-12
  * 개    요 : 확정 처리
  * return값 : void
  */
 function confRej() { 	
     
    if(!DS_O_LIST.IsUpdated){
        showMessage(EXCLAMATION, OK, "USER-1002", "처리할 전표"); 
        //GR_DETAIL.Focus();
        return;
    }
    
    var strSlipProcStat = "";     //승인할 것인지 반려할 것인지(승인: 00, 반려: 01)    
    var vanMsgFlag      = false;       //반려했을때의메시지
    
    var strImportFlag   = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"IMPORT_FLAG");     
    var strSlipFlag1    = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_FLAG"); 
    var confFlag        = "";
    var sendFlag        = "";          //SMS전송시 보내는 플레그 
    
    var disPlayConfFlag = ""   //화면상의 전표진행상태(화면상의 전표진행상태와 실제 진행상태가 다를수 있기때문에 체크한다. 검품확정상태 : 09, 미검품확정상태 : 00)
    var returnflag      = false;

    var k = 0;
    var X; 
    var Y;
    var Z;                        //대출입만 사용    
    Z = DS_IO_DETAIL2;
    
    switch(strSlipFlag1){
       case 'A': 
          X = DS_IO_MASTER;
          Y = DS_IO_DETAIL;
          if(strImportFlag == '1'){
             X = DS_IO_MASTER5;
             Y = DS_IO_DETAIL5;
          }
          break;
       case 'B': 
           X = DS_IO_MASTER;
           Y = DS_IO_DETAIL;
           break;
       case 'C': 
           X = DS_IO_MASTER1;
           Y = DS_IO_DETAIL1;
           break;
       case 'E': 
           X = DS_IO_MASTER3;
           Y = DS_IO_DETAIL3;
           break;
       case 'F': 
           X = DS_IO_MASTER3;
           Y = DS_IO_DETAIL3;
           break;     
       case 'G': 
           X = DS_IO_MASTER4;
           Y = DS_IO_DETAIL4;
           break;
    }         
    
    //점출점에서 점출확정상태 취소하려면(재고수불에 반영된다)
    if(DS_O_LIST.Namevalue(DS_O_LIST.RowPosition ,"SLIP_PROC_STAT") == "08" && DS_O_LIST.Namevalue(DS_O_LIST.RowPosition ,"SLIP_FLAG") == "E"){// 검품확정상태
        //확정 취소 하시겠습니까?
        if( showMessage(STOPSIGN, YESNO, "USER-1206") != 1 ){
            return;         
        }else{
            if( showMessage(STOPSIGN, YESNO, "USER-1212", "취소") == 1 ){        //정말 취소 하시겠습니까.
                strSlipProcStat = "08"  //확정상태의 플래그로 승인을 취소하기 위함.
                confFlag = "conf";      //마스터디테일 로그테이블에 만 데이터 적용(프로시저 )
                sendFlag = "2";         //확정취소
            }else{
                return;
            }   
        }
    }else if(DS_O_LIST.Namevalue(DS_O_LIST.RowPosition ,"SLIP_PROC_STAT") == "09"){ // 검품확정상태(확정취소하려면)
        disPlayConfFlag = "09"
        
        //확정 취소 하시겠습니까?
        if( showMessage(STOPSIGN, YESNO, "USER-1206") != 1 )
            return;
        else{
            if( showMessage(STOPSIGN, YESNO, "USER-1212", "취소") == 1 ){        //정말 취소 하시겠습니까.
                strSlipProcStat = "09"  //확정상태의 플래그로 승인을 취소하기 위함.
                confFlag = "conf";      //마스터디테일 로그테이블에 만 데이터 적용(프로시저 X)
                sendFlag = "2";         //확정취소
            }else{
                return;
            }   
        }
    //확정하려면
    }else{
        disPlayConfFlag = "00";
        
        //확정(반려)하시겠습니까?
        var returnv = showMessage(DECIDE, DECIDEREJECT, "USER-1215");
        if(returnv == 2){
            if( showMessage(STOPSIGN, YESNO, "USER-1212", "반려") == 1 ){        //정말 반려 하시겠습니까. 
                strSlipProcStat = "09"  //확정상태의 플래그로 승인을 취소하기 위함.
                vanMsgFlag = true;            
                confFlag = "reject";    //마스터디테일 로그테이블에 만 데이터 적용(프로시저 X)
                sendFlag = "1";         //반려(취소)
            }else{
                return;
            }        
            
        }else if(returnv == 1){
            strSlipProcStat = "00"  //확정이안된상태의 플래그로 승인을하기 위함.
            vanMsgFlag = false;            
            confFlag = "conf";      //마스터디테일 로그테이블에 만 데이터 적용(프로시저 X)
            sendFlag = " 0";        //확정
        }else{
            return;
        }
    }
      
    // 점입점이면서 점출확정상태이면
    if(DS_O_LIST.Namevalue(DS_O_LIST.RowPosition ,"SLIP_PROC_STAT") == "08" && DS_O_LIST.Namevalue(DS_O_LIST.RowPosition ,"SLIP_FLAG") == "F"){
    	if(vanMsgFlag){
            vanMsgFlag = true;            
            confFlag = "reject";    //마스터디테일 로그테이블에 만 데이터 적용(프로시저 X)
            sendFlag = "1";         //반려(취소)
    	}else{
            vanMsgFlag = false;            
            confFlag = "conf";      //프로시저탐
            sendFlag = "0";         //확정    		
    	}
        strSlipProcStat = "08"      //확정이안된상태의 플래그로 승인을하기 위함.
    }
    
    // 반영될 PARAMETERS
    var strStrCd         = "";
    var strSlipNo        = "";
    var strPStrCd        = "";
    var strPSlipNo       = "";
    var strSlipFlag      = "";
    var strImportFlag    = "";
    var strBottleSlipYN  = "";
    var strStrinCanYN    = "";
    var strOrdFlag       = "";
    var strBizType       = "";    
    var varChkDt         = "";
    
    // UI단에서 구분위한 변수
    var listSlipNo       = ""; 
    
    if(g_listChkCnt ==1){   //한건이면
        for(p = 1; p<= DS_O_LIST.CountRow; p++){
            if(DS_O_LIST.NameValue(p, "CHECK1") == "T"){
                listSlipNo    = DS_O_LIST.NameValue(p, "SLIP_NO");       // 리스트에 있는 전표번호
                strSlipFlag   = DS_O_LIST.NameValue(p, "SLIP_FLAG");     // 리스트에 있는 전표구분
                strImportFlag = DS_O_LIST.NameValue(p, "IMPORT_FLAG");   // 리스트에 있는 수입구분
            }
        }
        var masterSlipNo = X.NameValue(X.RowPosition, "SLIP_NO");     // 마스터에 있는 전표번호
        if(listSlipNo == masterSlipNo){

            checkSlipFlag(DS_O_LIST.RowPosition);        // 현재 전표의 DB전표진행상태를 알기 위함
            
            if(strSlipFlag == "E" || strSlipFlag == "F"){// 점출입
            	if(strSlipFlag == "E"){
            		if(disPlayConfFlag == "00"){         // 검품 확정 하려는 상태
                        if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "08"){ // 점출점 확정상태이면
                            showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정된 전표입니다.");
                            setFocusGrid(GR_LIST, DS_O_LIST, DS_O_LIST.RowPosition, "CHECK1");               
                            returnflag = false;
                            return;
                            
                        }else if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "09"){// 검품 확정상태이면
                            showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정된 전표입니다.");
                            setFocusGrid(GR_LIST, DS_O_LIST, DS_O_LIST.RowPosition, "CHECK1");               
                            returnflag = false;
                            return;
                            
                        }else{
                            strSlipProcStat = "00"  // 확정이안된상태의 플래그로 승인을하기 위함.
                        }
            		
            		}else{        // 점출점에서 점출확정 취소하려는 의도(화면에서 전표진행상태는  08) 재고수불에 반영되는 프로시져 탄다(Y일때 타고 N일때 안탐).
                        if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "09"){ // 점입점 확정상태면
                            showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정된 전표입니다.");
                            setFocusGrid(GR_LIST, DS_O_LIST, DS_O_LIST.RowPosition, "CHECK1");   
                            returnflag = false;
                            return;             
                            
                        }else if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") != "08"){ // 점출점 확정상태가 아니면
                            showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정 취소된 전표입니다.");
                            setFocusGrid(GR_LIST, DS_O_LIST, DS_O_LIST.RowPosition, "CHECK1");   
                            returnflag = false;
                            return;             
            		
                        }else{
                            strSlipProcStat = "08"; // 확정상태의 플래그로 검품확정을 취소하기 위함.
                        }            			
            		}
            		
            	}else if(strSlipFlag == "F"){       // 점입전표일때
                    if(disPlayConfFlag == "00"){    // 검품 확정 하려는 상태
                    	
                        if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "09"){ // 점입점 확정상태이면
                            showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정된 전표입니다.");
                            setFocusGrid(GR_LIST, DS_O_LIST, DS_O_LIST.RowPosition, "CHECK1");             
                            returnflag = false;
                            return;
                            
                        }else if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") != "08"){// 점출점 확정이 아니면

                            showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정취소된 전표입니다.");
                            setFocusGrid(GR_LIST, DS_O_LIST, DS_O_LIST.RowPosition, "CHECK1");             
                            returnflag = false;
                            return;
                        	
                        }else{
                            strSlipProcStat = "08";     //확정이 안된 상태의 플래그로 승인을 하기 위함.
                        }
                    
                    }else{        // 점입점에서 점입확정 취소하려는 의도(화면에서 전표진행상태는  09) 취소시 08로 되고 재고수불에 반영 안된다.
                        if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") != "09"){ // 점입점 확정취소이면
                            setFocusGrid(GR_LIST, DS_O_LIST, DS_O_LIST.RowPosition, "CHECK1");            
                            returnflag = false;
                            return;
                        }else{
                            strSlipProcStat = "09"; //확정상태의 플래그로 승인을 취소하기 위함.
                        }                       
                    }           		
            		
            	}else{
            		//alert("정체를 알수 없다");
            	}
            }else{  //매입 반품 대출입  매가인상하
                if(disPlayConfFlag == "00"){                //검품 확정 하려는 상태
                    if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "09"){
                        showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정된 전표입니다.");
                        setFocusGrid(GR_LIST, DS_O_LIST, DS_O_LIST.RowPosition, "CHECK1");      //멀티 품목 선택시 입력 첫번재 행의 수량으로 포커스 이동          
                        returnflag = false;
                        return;
                    }else{
                        returnflag = true;  
                    }
                }else{  //화면상에 검품 확정 상태이면(사용자는 확정취소를 의도)
                    if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "00"){
                        showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정취소된 전표입니다.");
                        setFocusGrid(GR_LIST, DS_O_LIST, DS_O_LIST.RowPosition, "CHECK1");      //멀티 품목 선택시 입력 첫번재 행의 수량으로 포커스 이동          
                        returnflag = false;
                        return;
                    }else{
                        returnflag = true;  
                    }
                }               	
            }

            // 재고실사 마감여부
            if(!chechJgDtFlag(X.NameValue(X.RowPosition,"STR_CD"), X.NameValue(X.RowPosition,"CHK_DT"), DS_O_LIST.RowPosition)){
                returnflag = false;
                return false;         
            }
            //MARIO OUTLET
            if(DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_FLAG") == "B" || DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"BIZ_TYPE") == "1"){// 직매입 반품
            	if (DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"FILE_CHECK") == 0) {
	            	showMessage(EXCLAMATION, OK, "GAUCE-1000", "직매입 반품 전표에 대한 증빙자료 첨부를 확인하세요.");
	        //        return;
            	} 
            }
            //MARIO OUTLET
            
            // 세금계산서 발행유무
            if(!checkTaxYn(X.NameValue(X.RowPosition,"STR_CD"), listSlipNo, DS_O_LIST.RowPosition)){
                returnflag = false;
                return false;         
            } 
            
//             // 일 시재마감체크
//             if(!dayCloseCheck(X.NameValue(X.RowPosition,"STR_CD"), strToday, X.RowPosition)){
//                 return false;
//             }      
            
            // 대금지불마감체크
            var strCd = X.NameValue(X.RowPosition, "STR_CD");
            var venCd = X.NameValue(X.RowPosition, "VEN_CD");
            var chkDt = X.NameValue(X.RowPosition, "CHK_DT");
            
            if(!chkPayClose(X.RowPosition, strCd, venCd, chkDt)){
                returnflag = false;
                return false;               
            } 
            
            // 마감체크
            if(!closeCheck(X.NameValue(X.RowPosition,"STR_CD"), X.NameValue(X.RowPosition,"CHK_DT"), X.RowPosition)){
                return false;
            }      
            
            // 검품확정시에만 검품확정일자 체크한다. 20110804
            if(sendFlag == 0){
	            //검품확정일자 체크
	            if(!checkChkDt(X.NameValue(X.RowPosition, "ORD_DT"), X.NameValue(X.RowPosition, "CHK_DT"), X.NameValue(X.RowPosition, "AFT_ORD_FLAG"))){
	                returnflag = false;
	                return false;               
	            } 
	            
	            // 20161121 발주확정일이 없을경우 발주확정일에 검풀확정일을 세팅
	            if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORD_CF_DT") == "" || DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORD_CF_DT") == "        "){
	            	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORD_CF_DT") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CHK_DT");
	            }
            }
            
            // 하단그리드 매가비교하기위함
            if(!chkAppDtPrice(X.NameValue(X.RowPosition,"STR_CD"), listSlipNo, sendFlag, DS_O_LIST.RowPosition)){
                return;            	
            }
            
            // ******************만약에 수입전표일때는 오퍼마감체크한다.
            if(strImportFlag == "1"){
                var strStrCd   = X.NameValue(X.RowPosition,"STR_CD"); 
                var strOfferNo = X.NameValue(X.RowPosition,"OFFER_SHEET_NO");  
                if(!chkOfferClose(strStrCd, strOfferNo, DS_O_LIST.RowPosition))
                	return;
            }
            
            //++++++++++++++++++++++++++++++++++업데이트위함
            // 마스터 상태를 insert로 셋팅 
            X.UserStatus(1) = 1;

            // 디테일 상태를 insert로 셋팅 
            for(var j=1;j<=Y.CountRow;j++) {
                Y.UserStatus(j) = 1;
            }

            // 디테일 상태를 insert로 셋팅 대출입
            if(strSlipFlag == "C"){
                for(var j=1;j<=Z.CountRow;j++) {
                    Z.UserStatus(j) = 1;
                }
            }

            //++++++++++++++++++++++++++++++++++    
            strStrCd           = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"STR_CD");               
            strSlipNo          = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_NO");              
            strPStrCd          = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"P_STR_CD");             
            strPSlipNo         = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"P_SLIP_NO");            
            strSlipFlag        = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_FLAG");            
            strImportFlag      = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"IMPORT_FLAG");          
            strBottleSlipYN    = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"BOTTLE_SLIP_YN");       
            strStrinCanYN      = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"STRIN_CAN_YN");         
            strOrdFlag         = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"ORD_FLAG");             
            strBizType         = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"BIZ_TYPE");

            var parameters  = "&strSlipProcStat="+encodeURIComponent(strSlipProcStat)
				            + "&strToday="+encodeURIComponent(strToday)
				            + "&strPStrCd="+encodeURIComponent(strPStrCd)
				            + "&strPSlipNo="+encodeURIComponent(strPSlipNo)
				            + "&strSlipFlag="+encodeURIComponent(strSlipFlag)
				            + "&strStrCd="+encodeURIComponent(strStrCd)
				            + "&strSlipNo="+encodeURIComponent(strSlipNo)
				            + "&strImportFlag="+encodeURIComponent(strImportFlag)
				            + "&strBottleSlipYN="+encodeURIComponent(strBottleSlipYN)
				            + "&strStrinCanYN="+encodeURIComponent(strStrinCanYN)
				            + "&strOrdFlag="+encodeURIComponent(strOrdFlag)
				            + "&varChkDt="+encodeURIComponent(varChkDt)
				            + "&strBizType="+encodeURIComponent(strBizType)
				            + "&sendFlag="+encodeURIComponent(sendFlag); 
            TR_S_MAIN.Action="/dps/pord211.po?goTo=conf&confFlag="+confFlag+parameters;
            TR_S_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER="+X.id+",I:DS_IO_DETAIL="+Y.id+",I:DS_IO_DETAIL2="+Z.id+")";
            TR_S_MAIN.Post(); 

            k = 1;      
            
        }else{      //한건이지만 리스트와 마스터 정보가 다르면 다시 DB갔다온다. 검품확정일은 DB값으로 자동 셋팅된다
            for(var closeChkCnt = 1; closeChkCnt<=DS_O_LIST.CountRow; closeChkCnt++){
                if(DS_O_LIST.NameValue(closeChkCnt,"CHECK1") == "T"){
                	
		            // 현재전표상태
		            checkSlipFlag(closeChkCnt);         //현재 전표의 DB전표진행상태를 알기 위함                
		            strSlipFlag = DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_FLAG");                

		            // 재고실사 마감여부
		            if(!chechJgDtFlag(DS_O_LIST.NameValue(closeChkCnt,"STR_CD"), DS_O_LIST.NameValue(closeChkCnt,"CHK_DT"), closeChkCnt)){
		                returnflag = false;
		                return false;         
		            }
 
		            //MARIO OUTLET
		            if(DS_O_LIST.NameValue(closeChkCnt, "SLIP_FLAG") == "B" || DS_O_LIST.NameValue(closeChkCnt,"BIZ_TYPE") == "1"){// 직매입 반품
		            	if (DS_O_LIST.NameValue(closeChkCnt,"FILE_CHECK") == 0) {
			            	showMessage(EXCLAMATION, OK, "GAUCE-1000", "직매입 반품 전표에 대한 증빙자료 첨부를 확인하세요.");
			       //         return;
		            	} 
		            }
		            //MARIO OUTLET
		            
		            // 세금계산서 발행유무
		            if(!checkTaxYn(DS_O_LIST.NameValue(closeChkCnt,"STR_CD"), DS_O_LIST.NameValue(closeChkCnt,"SLIP_NO"), closeChkCnt)){
		                returnflag = false;
		                return false;         
		            } 
		            
// 		            // 일 시재마감체크                   
//                     if(!dayCloseCheck(DS_O_LIST.NameValue(closeChkCnt,"STR_CD"), strToday, closeChkCnt)){
//                         return false;
//                     }    
		            
	                // 대금지불마감체크
	                var strCd = DS_O_LIST.NameValue(closeChkCnt, "STR_CD");
	                var venCd = DS_O_LIST.NameValue(closeChkCnt, "VEN_CD");
	                var chkDt = DS_O_LIST.NameValue(closeChkCnt, "CHK_DT");
	                
	                if(!chkPayClose(closeChkCnt, strCd, venCd, chkDt)){
	                    returnflag = false;
	                    return false;               
	                } 
	                
                    // 마감체크                    
                    if(!closeCheck(DS_O_LIST.NameValue(closeChkCnt,"STR_CD"), DS_O_LIST.NameValue(closeChkCnt,"CHK_DT"), closeChkCnt)){
                        return false;
                    }              
                    
                    // 하단그리드 매가비교하기위함
                    if(!chkAppDtPrice(DS_O_LIST.NameValue(closeChkCnt,"STR_CD"), DS_O_LIST.NameValue(closeChkCnt,"SLIP_NO"), sendFlag, closeChkCnt)){
                        return false;               
                    }
                    
                    // ******************만약에 수입전표일때는 오퍼마감체크한다.
                    if(strImportFlag == "1"){
                        var strStrCd   = DS_O_LIST.NameValue(closeChkCnt,"STR_CD"); 
                        var strOfferNo = DS_O_LIST.NameValue(closeChkCnt,"OFFER_SHEET_NO");  
                        if(!chkOfferClose(strStrCd, strOfferNo, closeChkCnt))
                            return;
                    }
                }       
            }    
            
            for(var masterChkCnt = 1; masterChkCnt<=DS_O_LIST.CountRow; masterChkCnt++){
                if(DS_O_LIST.NameValue(masterChkCnt,"CHECK1") == "T"){
                        
                    if(strSlipFlag == "A" || strSlipFlag == "B" ){
                        if(strImportFlag == "1"){
                            DS_MASTER_TMP.setDataHeader('<gauce:dataset name="H_MASTER5"/>');     //수입        
                            confGetMaster5(masterChkCnt);
                            
                        }else{
                            DS_MASTER_TMP.setDataHeader('<gauce:dataset name="H_MASTER"/>');      //매입반품
                            confGetDetail(masterChkCnt);                    
                        }
                    }else if(strSlipFlag == "C"){
                        DS_MASTER_TMP.setDataHeader('<gauce:dataset name="H_MASTER1"/>');         //대출입
                        confGetDetail1(masterChkCnt);
                        
                    }else if(strSlipFlag == "E" || strSlipFlag == "F"){
                        DS_MASTER_TMP.setDataHeader('<gauce:dataset name="H_MASTER3"/>');      //점출입
                        confGetDetail3(masterChkCnt);
                        
                    }else if(strSlipFlag == "G"){
                        DS_MASTER_TMP.setDataHeader('<gauce:dataset name="H_MASTER4"/>');      //매가인상하
                        confGetDetail4(masterChkCnt);
                    }

                    var strSlipNo      = DS_O_LIST.NameValue(masterChkCnt,"SLIP_NO");
		
		            if(strSlipFlag == "E" || strSlipFlag == "F"){// 점출입
		                if(strSlipFlag == "E"){
		                    if(disPlayConfFlag == "00"){         // 검품 확정 하려는 상태
		                        if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "08"){ // 점출점 확정상태이면
		                            showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정된 전표입니다.");
		                            setFocusGrid(GR_LIST, DS_O_LIST, masterChkCnt, "CHECK1");               
		                            returnflag = false;
		                            return;
		                            
		                        }else if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "09"){ // 검품 확정상태이면
                                    showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정취소된 전표입니다.");
                                    setFocusGrid(GR_LIST, DS_O_LIST, masterChkCnt, "CHECK1");               
                                    returnflag = false;
                                    return;
		                        	
		                        }else{
		                            strSlipProcStat = "00"  // 확정이안된상태의 플래그로 승인을하기 위함.
		                        }
		                    
		                    }else{        // 점출점에서 점출확정 취소하려는 의도(화면에서 전표진행상태는  08) 재고수불에 반영되는 프로시져 탄다.
		                        if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "09"){ // 점입점 상태이면
		                            showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정된 전표입니다.");
		                            setFocusGrid(GR_LIST, DS_O_LIST, masterChkCnt, "CHECK1");                
		                            returnflag = false;
		                            return;
		                            
		                        }else if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") != "08"){// 점출점 확정상태가 아니면
                                    showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정취소된 전표입니다.");
                                    setFocusGrid(GR_LIST, DS_O_LIST, masterChkCnt, "CHECK1");                
                                    returnflag = false;
                                    return;		                        	
		                        
		                        }else{
		                            strSlipProcStat = "08"; // 확정상태의 플래그로 검품확정을 취소하기 위함.
		                        }                       
		                    }
		                    
		                }else if(strSlipFlag == "F"){       // 점입전표일때
		                	if(disPlayConfFlag == "00"){    // 검품 확정 하려는 상태
		                        if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "09"){ // 점입점 확정상태이면
		                            showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정된 전표입니다.");
		                            setFocusGrid(GR_LIST, DS_O_LIST, masterChkCnt, "CHECK1");             
		                            returnflag = false;
		                            return;
		                            
		                        }else if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") != "08"){
                                    showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정취소된 전표입니다.");
                                    setFocusGrid(GR_LIST, DS_O_LIST, masterChkCnt, "CHECK1");             
                                    returnflag = false;
                                    return;
		                        }else{
                                    strSlipProcStat = "08";     //확정이 안된 상태의 플래그로 승인을 하기 위함.		                        	
		                        }
		                    
		                    }else{        // 점입점에서 점입확정 취소하려는 의도(화면에서 전표진행상태는  09) 취소시 08로 되고 재고수불에 반영 안된다.
		                        if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") != "09"){ // 점입점 확정취소이면
		                            showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정취소된 전표입니다.");
		                            setFocusGrid(GR_LIST, DS_O_LIST, masterChkCnt, "CHECK1");            
		                            returnflag = false;
		                            return;
		                        }else{
		                            strSlipProcStat = "09"; //확정상태의 플래그로 승인을 취소하기 위함.
		                        }                       
		                    }                   
		                    
		                }else{
		                    //alert("정체를 알수 없다");
		                }		            	
		            	
		            }else{  //매입 반품 대출입  매가인상하
	                    if(disPlayConfFlag == "00"){        //검품 확정 하려는 상태
	                        if(DS_MASTER_TMP.NameValue(DS_MASTER_TMP.RowPosition, "SLIP_PROC_STAT") == "09"){
	                            showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정된 전표입니다.");
	                            setFocusGrid(GR_LIST, DS_O_LIST, masterChkCnt, "CHECK1");      //멀티 품목 선택시 입력 첫번재 행의 수량으로 포커스 이동          
	                            returnflag = false;
	                            return;
	                        }else{
	                            returnflag = true;  
	                        }
	                    }else{  //화면상에 검품 확정 상태이면(사용자는 확정취소를 의도)
	                        if(DS_MASTER_TMP.NameValue(DS_MASTER_TMP.RowPosition, "SLIP_PROC_STAT") == "00"){
	                            showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정취소된 전표입니다.");
	                            setFocusGrid(GR_LIST, DS_O_LIST, masterChkCnt, "CHECK1");      //멀티 품목 선택시 입력 첫번재 행의 수량으로 포커스 이동          
	                            returnflag = false;
	                            return;
	                        }else{
	                            returnflag = true;  
	                        }
	                    } 
		            }                               
                    
                    //++++++++++++++++++++++++++++++++++업데이트위함
                    // 마스터 상태를 insert로 셋팅 
                    DS_MASTER_TMP.UserStatus(1) = 1;

                    // 디테일 상태를 insert로 셋팅 
                    for(var j=1;j<=DS_DETAIL_TMP.CountRow;j++) {
                        DS_DETAIL_TMP.UserStatus(j) = 1;
                    }

                    // 디테일 상태를 insert로 셋팅 대출입
                    if(strSlipFlag == "C"){
                        for(var j=1;j<=DS_DETAIL_TMP_D.CountRow;j++) {
                            DS_DETAIL_TMP_D.UserStatus(j) = 1;
                        }
                    }
                    //++++++++++++++++++++++++++++++++++    
                    
                    
                    strStrCd           = DS_O_LIST.NameValue(masterChkCnt,"STR_CD");               
                    strSlipNo          = DS_O_LIST.NameValue(masterChkCnt,"SLIP_NO");              
                    strPStrCd          = DS_O_LIST.NameValue(masterChkCnt,"P_STR_CD");             
                    strPSlipNo         = DS_O_LIST.NameValue(masterChkCnt,"P_SLIP_NO");            
                    strSlipFlag        = DS_O_LIST.NameValue(masterChkCnt,"SLIP_FLAG");            
                    strImportFlag      = DS_O_LIST.NameValue(masterChkCnt,"IMPORT_FLAG");          
                    strBottleSlipYN    = DS_O_LIST.NameValue(masterChkCnt,"BOTTLE_SLIP_YN");       
                    strStrinCanYN      = DS_O_LIST.NameValue(masterChkCnt,"STRIN_CAN_YN");         
                    strOrdFlag         = DS_O_LIST.NameValue(masterChkCnt,"ORD_FLAG");             
                    strBizType         = DS_O_LIST.NameValue(masterChkCnt,"BIZ_TYPE");                       

                    var parameters  = "&strSlipProcStat="+encodeURIComponent(strSlipProcStat)
				                    + "&strToday="+encodeURIComponent(strToday)
				                    + "&strPStrCd="+encodeURIComponent(strPStrCd)
				                    + "&strPSlipNo="+encodeURIComponent(strPSlipNo)
				                    + "&strSlipFlag="+encodeURIComponent(strSlipFlag)
				                    + "&strStrCd="+encodeURIComponent(strStrCd)
				                    + "&strSlipNo="+encodeURIComponent(strSlipNo)
				                    + "&strImportFlag="+encodeURIComponent(strImportFlag)
				                    + "&strBottleSlipYN="+encodeURIComponent(strBottleSlipYN)
				                    + "&strStrinCanYN="+encodeURIComponent(strStrinCanYN)
				                    + "&strOrdFlag="+encodeURIComponent(strOrdFlag)
				                    + "&varChkDt="+encodeURIComponent(varChkDt)
				                    + "&strBizType="+encodeURIComponent(strBizType)
				                    + "&sendFlag="+encodeURIComponent(sendFlag); 
                    TR_S_MAIN.Action="/dps/pord211.po?goTo=conf&confFlag="+confFlag+parameters;
                    TR_S_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_MASTER_TMP,I:DS_IO_DETAIL=DS_DETAIL_TMP,I:DS_IO_DETAIL2=DS_DETAIL_TMP_D)";
                    TR_S_MAIN.Post();

                    k = 1;   
                }       
            }
        }
    	
    }else{      // 멀티체크이면 

        // 체크된 건에 대해서 마감체크 및 DB전표진행상태를 체크한다.
        for(var closeChkCnt = 1; closeChkCnt<=DS_O_LIST.CountRow; closeChkCnt++){
            if(DS_O_LIST.NameValue(closeChkCnt,"CHECK1") == "T"){    
                
                // 현재전표상태
                checkSlipFlag(closeChkCnt);         //현재 전표의 DB전표진행상태를 알기 위함                
                strSlipFlag   = DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_FLAG");
                strImportFlag = DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "IMPORT_FLAG");
                
                if(strSlipFlag == "E" || strSlipFlag == "F"){// 점출입
                    if(strSlipFlag == "E"){
                        if(disPlayConfFlag == "00"){         // 검품 확정 하려는 상태
                            if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "08"){ // 점출점 확정상태이면
                                showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정된 전표입니다.");
                                setFocusGrid(GR_LIST, DS_O_LIST, closeChkCnt, "CHECK1");               
                                returnflag = false;
                                return;
                                
                            }else if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "09"){ // 검품 확정상태이면
                                showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정취소된 전표입니다.");
                                setFocusGrid(GR_LIST, DS_O_LIST, closeChkCnt, "CHECK1");               
                                returnflag = false;
                                return;
                            	
                            }else{
                                strSlipProcStat = "00"  // 확정이안된상태의 플래그로 승인을하기 위함.
                            }
                        
                        }else{        // 점출점에서 점출확정 취소하려는 의도(화면에서 전표진행상태는  08) 재고수불에 반영되는 프로시져 탄다.
                            if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "09"){ // 점입점 확정상태면
                                showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정된 전표입니다.");
                                setFocusGrid(GR_LIST, DS_O_LIST, closeChkCnt, "CHECK1");                
                                returnflag = false;
                                return;
                            }else if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") != "08"){
                            	
                                showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정취소된 전표입니다.");
                                setFocusGrid(GR_LIST, DS_O_LIST, closeChkCnt, "CHECK1");                
                                returnflag = false;
                                return;
                            }else{                            	
                                strSlipProcStat = "08"; // 확정상태의 플래그로 검품확정을 취소하기 위함.                            	
                            }                       
                        }
                        
                    }else if(strSlipFlag == "F"){       // 점입전표일때
                        if(disPlayConfFlag == "00"){    // 검품 확정 하려는 상태
                            if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "09"){ // 점입점 확정상태이면
                                showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정된 전표입니다.");
                                setFocusGrid(GR_LIST, DS_O_LIST, closeChkCnt, "CHECK1");             
                                returnflag = false;
                                return;
                                
                            }else if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") != "08"){
                                showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정취소된 전표입니다.");
                                setFocusGrid(GR_LIST, DS_O_LIST, closeChkCnt, "CHECK1");             
                                returnflag = false;
                                return;
                            	
                            }else{
                                strSlipProcStat = "08";     //확정이 안된 상태의 플래그로 승인을 하기 위함.                            	
                            }
                        
                        }else{        // 점입점에서 점입확정 취소하려는 의도(화면에서 전표진행상태는  09) 취소시 08로 되고 재고수불에 반영 안된다.
                            if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") != "09"){ // 점입점 확정취소이면
                                showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정취소된 전표입니다.");
                                setFocusGrid(GR_LIST, DS_O_LIST, closeChkCnt, "CHECK1");            
                                returnflag = false;
                                return;
                            }else{
                                strSlipProcStat = "09"; //확정상태의 플래그로 승인을 취소하기 위함.
                            }                       
                        }                   
                        
                    }else{
                        //alert("정체를 알수 없다");
                    }                       
                    
                }else{  //매입 반품 대출입  매가인상하                
	                if(disPlayConfFlag == "00"){        //검품 확정 하려는 상태
	                    if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "09"){
	                        showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정된 전표입니다.");
	                        setFocusGrid(GR_LIST, DS_O_LIST, closeChkCnt, "CHECK1");      //멀티 품목 선택시 입력 첫번재 행의 수량으로 포커스 이동          
	                        returnflag = false;
	                        return;
	                    }else{
	                        returnflag = true;  
	                    }
	                }else{  //화면상에 검품 확정 상태이면(사용자는 확정취소를 의도)
	                    if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "00"){
	                        showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 확정취소된 전표입니다.");
	                        setFocusGrid(GR_LIST, DS_O_LIST, closeChkCnt, "CHECK1");      //멀티 품목 선택시 입력 첫번재 행의 수량으로 포커스 이동          
	                        returnflag = false;
	                        return;
	                    }else{
	                        returnflag = true;  
	                    }
	                }
                }              

                // 재고실사 마감여부
                if(!chechJgDtFlag(DS_O_LIST.NameValue(closeChkCnt,"STR_CD"), DS_O_LIST.NameValue(closeChkCnt,"CHK_DT"), closeChkCnt)){
                    returnflag = false;
                    return false;         
                } 
                //MARIO OUTLET
                if(DS_O_LIST.NameValue(closeChkCnt,"SLIP_FLAG") == "B" || DS_O_LIST.NameValue(closeChkCnt,"BIZ_TYPE") == "1"){// 직매입 반품
                	if (DS_O_LIST.NameValue(closeChkCnt,"FILE_CHECK") == 0) {
	                	showMessage(EXCLAMATION, OK, "GAUCE-1000", "직매입 반품 전표에 대한 증빙자료 첨부를 확인하세요.");
	            //        return;
                	}
                }
                //MARIO OUTLET
                
                
                // 세금계산서 발행유무
                if(!checkTaxYn(DS_O_LIST.NameValue(closeChkCnt,"STR_CD"), DS_O_LIST.NameValue(closeChkCnt,"SLIP_NO"), closeChkCnt)){
                    returnflag = false;
                    return false;         
                } 
                
//                 // 일 시재마감
//                 if(!dayCloseCheck(DS_O_LIST.NameValue(closeChkCnt,"STR_CD"), strToday, closeChkCnt)){
//                     return false;
//                 }     
                
                // 대금지불마감체크
                var strCd = DS_O_LIST.NameValue(closeChkCnt, "STR_CD");
                var venCd = DS_O_LIST.NameValue(closeChkCnt, "VEN_CD");
                var chkDt = DS_O_LIST.NameValue(closeChkCnt, "CHK_DT");
                
                if(!chkPayClose(closeChkCnt, strCd, venCd, chkDt)){
                    returnflag = false;
                    return false;               
                } 

                // 마감체크
                if(!closeCheck(DS_O_LIST.NameValue(closeChkCnt,"STR_CD"), DS_O_LIST.NameValue(closeChkCnt,"CHK_DT"), closeChkCnt)){
                    return false;
                }       
                
                // 하단그리드 매가비교하기위함
                if(!chkAppDtPrice(DS_O_LIST.NameValue(closeChkCnt,"STR_CD"), DS_O_LIST.NameValue(closeChkCnt,"SLIP_NO"), sendFlag, closeChkCnt)){
                    return false;
                }       
                  
                // ******************만약에 수입전표일때는 오퍼마감체크한다.
                if(strImportFlag == "1"){
                    var strStrCd   = DS_O_LIST.NameValue(closeChkCnt,"STR_CD"); 
                    var strOfferNo = DS_O_LIST.NameValue(closeChkCnt,"OFFER_SHEET_NO");  
                    if(!chkOfferClose(strStrCd, strOfferNo, closeChkCnt))
                        return;
                }                
            }       
        }    

        for(var masterChkCnt = 1; masterChkCnt<=DS_O_LIST.CountRow; masterChkCnt++){
            if(DS_O_LIST.NameValue(masterChkCnt,"CHECK1") == "T"){    
                
            	strStrCd              = DS_O_LIST.NameValue(masterChkCnt,"STR_CD");               
                strSlipNo             = DS_O_LIST.NameValue(masterChkCnt,"SLIP_NO");              
                strPStrCd             = DS_O_LIST.NameValue(masterChkCnt,"P_STR_CD");             
                strPSlipNo            = DS_O_LIST.NameValue(masterChkCnt,"P_SLIP_NO");            
                strSlipFlag           = DS_O_LIST.NameValue(masterChkCnt,"SLIP_FLAG");            
                strImportFlag         = DS_O_LIST.NameValue(masterChkCnt,"IMPORT_FLAG");          
                strBottleSlipYN       = DS_O_LIST.NameValue(masterChkCnt,"BOTTLE_SLIP_YN");       
                strStrinCanYN         = DS_O_LIST.NameValue(masterChkCnt,"STRIN_CAN_YN");         
                strOrdFlag            = DS_O_LIST.NameValue(masterChkCnt,"ORD_FLAG");             
                strBizType            = DS_O_LIST.NameValue(masterChkCnt,"BIZ_TYPE");   

                if(strSlipFlag == "A" || strSlipFlag == "B" ){
                    if(strImportFlag == "1"){
                        DS_MASTER_TMP.setDataHeader('<gauce:dataset name="H_MASTER5"/>');     //수입        
                        confGetMaster5(masterChkCnt);
                        
                    }else{
                        DS_MASTER_TMP.setDataHeader('<gauce:dataset name="H_MASTER"/>');      //매입반품
                        confGetDetail(masterChkCnt);                    
                    }
                }else if(strSlipFlag == "C"){
                    DS_MASTER_TMP.setDataHeader('<gauce:dataset name="H_MASTER1"/>');         //대출입
                    confGetDetail1(masterChkCnt);
                    
                }else if(strSlipFlag == "E" || strSlipFlag == "F"){
                    DS_MASTER_TMP.setDataHeader('<gauce:dataset name="H_MASTER3"/>');      //점출입
                    confGetDetail3(masterChkCnt);
                    
                }else if(strSlipFlag == "G"){
                    DS_MASTER_TMP.setDataHeader('<gauce:dataset name="H_MASTER4"/>');      //매가인상하
                    confGetDetail4(masterChkCnt);
                }

	            // 20161121 발주확정일이 없을경우 발주확정일에 검풀확정일을 세팅
	            if(DS_MASTER_TMP.NameValue(masterChkCnt, "ORD_CF_DT") == "" || DS_MASTER_TMP.NameValue(masterChkCnt, "ORD_CF_DT") == "        "){
	            	DS_MASTER_TMP.NameValue(masterChkCnt, "ORD_CF_DT") = DS_IO_MASTER.NameValue(masterChkCnt, "CHK_DT");
	            }
                
                //++++++++++++++++++++++++++++++++++업데이트위함
                // 마스터 상태를 insert로 셋팅 
                DS_MASTER_TMP.UserStatus(1) = 1;

                // 디테일 상태를 insert로 셋팅 
                for(var j=1;j<=DS_DETAIL_TMP.CountRow;j++) {
                    DS_DETAIL_TMP.UserStatus(j) = 1;
                }

                // 디테일 상태를 insert로 셋팅 대출입
                if(strSlipFlag == "C"){
                    for(var j=1;j<=DS_DETAIL_TMP_D.CountRow;j++) {
                        DS_DETAIL_TMP_D.UserStatus(j) = 1;
                    }
                }
                //++++++++++++++++++++++++++++++++++      
                
                //++++++++++++++++++++++++++++++++++확정일자
                varChkDt = DS_MASTER_TMP.NameValue(DS_MASTER_TMP.RowPosition, "CHK_DT");
                //++++++++++++++++++++++++++++++++++  

                var parameters  = "&strSlipProcStat="+encodeURIComponent(strSlipProcStat)
	                            + "&strToday="+encodeURIComponent(strToday)
	                            + "&strPStrCd="+encodeURIComponent(strPStrCd)
	                            + "&strPSlipNo="+encodeURIComponent(strPSlipNo)
	                            + "&strSlipFlag="+encodeURIComponent(strSlipFlag)
	                            + "&strStrCd="+encodeURIComponent(strStrCd)
	                            + "&strSlipNo="+encodeURIComponent(strSlipNo)
	                            + "&strImportFlag="+encodeURIComponent(strImportFlag)
	                            + "&strBottleSlipYN="+encodeURIComponent(strBottleSlipYN)
	                            + "&strStrinCanYN="+encodeURIComponent(strStrinCanYN)
	                            + "&strOrdFlag="+encodeURIComponent(strOrdFlag)
	                            + "&varChkDt="+encodeURIComponent(varChkDt)
	                            + "&strBizType="+encodeURIComponent(strBizType)
	                            + "&sendFlag="+encodeURIComponent(sendFlag);    
                TR_S_MAIN.Action="/dps/pord211.po?goTo=conf&confFlag="+confFlag+parameters;
                TR_S_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_MASTER_TMP,I:DS_IO_DETAIL=DS_DETAIL_TMP,I:DS_IO_DETAIL2=DS_DETAIL_TMP_D)";
                TR_S_MAIN.Post(); 

                k += 1;
            }  
        }
    }    

    //반려된 전표일경우
    if(vanMsgFlag){
        showMessage(EXCLAMATION, OK, "USER-1201", k);        
        btn_Search();         
        return;
    }
    
    if(strSlipProcStat == "08"){    //점출입일경우
    	if(sendFlag == 0){         //확정
            showMessage(EXCLAMATION, OK, "USER-1202", k);       
    	}else{                     //취소
            showMessage(EXCLAMATION, OK, "USER-1203", k);       
    	}
    }else if(strSlipProcStat == "09"){//확정상태였던 전표의 취소된 건수
        showMessage(EXCLAMATION, OK, "USER-1203", k); 
    }else{//미확정상태였던 전표의 확정된 건수
        showMessage(EXCLAMATION, OK, "USER-1202", k);       
    } 
    returnflag = true;
    return returnflag;
  }
/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
 /**
  * checkSlipFlag()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-07-12
  * 개    요 :  리스트 DB전표진행상태 조회
  * return값 : void
  */
  function checkSlipFlag(row){
	  var strStrCd  = DS_O_LIST.NameValue(row,"STR_CD");
      var strSlipNo = DS_O_LIST.NameValue(row,"SLIP_NO");
      
      var goTo       = "checkSlipFlag" ;    
      var action     = "O";     
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)+
                       "&strSlipNo="+encodeURIComponent(strSlipNo);
      
      TR_S_MAIN.Action="/dps/pord211.po?goTo="+goTo+parameters;  
      TR_S_MAIN.KeyValue="SERVLET("+action+":DS_O_CHK_SLIP_FLAG=DS_O_CHK_SLIP_FLAG)"; //조회는 O
      TR_S_MAIN.Post();
  }
  
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
  // var strSlip_flag     = RD_S_SLIP_FLAG.CodeValue;            // 전표구분 
  
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
                   + "&strSlipNo="+encodeURIComponent(strSlipNo)  
                   + "&slipFlagList="+encodeURIComponent(slipFlagList);    
                 //  + "&strSlip_flag="+strSlip_flag; 
   TR_L_MAIN.Action  = "/dps/pord211.po?goTo="+goTo+parameters;  
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
        
        if(CHK_4.checked){
            strSlipIssueCnt += "'C','D'," ;             
        }
        
        if(CHK_5.checked){
            strSlipIssueCnt += "'E','F'," ;             
        }
                 
        if(CHK_6.checked){
            strSlipIssueCnt += "'G'," ;             
        }
        strSlipIssueCnt = strSlipIssueCnt.substring(0, strSlipIssueCnt.length-1);
        strSlipIssueCnt += ")";
    }     
        
    if(CHK_1.checked == false && CHK_2.checked == false && CHK_3.checked == false 
    && CHK_4.checked == false && CHK_5.checked == false && CHK_6.checked == false){    
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
 * searchCheckSlipFlag()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-04-08
 * 개    요 :  전표구분 선택시 체크 
 * return값 : 조회조건 문자열로 리턴
 */
function searchCheckSlipFlag (checkId){
     
    if(checkId == CHK_1){
        CHK_1.checked = true;
        CHK_2.checked = false;
        CHK_3.checked = false;
        CHK_4.checked = false;
        CHK_5.checked = false;
        CHK_6.checked = false;
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
   var parameters   = "&strStrCd="+encodeURIComponent(strStrCd)+
                      "&strSlipNo="+encodeURIComponent(strSlipNo);
   
   TR_MAIN.Action="/dps/pord211.po?goTo="+goTo+parameters;  
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
       
       TR_MAIN.Action="/dps/pord211.po?goTo="+goTo+parameters;  
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
				  + "&strPStrCd="+encodeURIComponent(strPStrCd)
				  + "&strSlipNo="+encodeURIComponent(strSlipNo)
				  + "&strPSlipNo="+encodeURIComponent(strPSlipNo);                 
   
   TR_MAIN.Action="/dps/pord211.po?goTo="+goTo+parameters;  
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
   
   TR_MAIN.Action="/dps/pord211.po?goTo="+goTo+parameters;  
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
   
  /* var strInvoiceYm       = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "INVOICE_YM");      // INVOICE_YM
   var strInvoiceSeqNo    = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "INVOICE_SEQ_NO");  // INVOICE_SEQ_NO */
   
   var goTo       = "getMaster5" ;    
   var action     = "O";     
   var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)   
                  + "&strSlipNo="+encodeURIComponent(strSlipNo);  
   TR_S_MAIN.Action="/dps/pord211.po?goTo="+goTo+parameters;  
   TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER5=DS_IO_MASTER5,"+action+":DS_IO_DETAIL5=DS_IO_DETAIL5)"; //조회는 O
   TR_S_MAIN.Post();       
 }

/**
* getDetail5()
* 작 성 자 : 김경은
* 작 성 일 : 2010-03-28
* 개    요 :  수입디테일
* return값 : void


function getDetail5(){
    
     // 조회조건 셋팅
     var strStrCd           = DS_IO_MASTER5.NameValue(DS_IO_MASTER5.RowPosition, "STR_CD");        // 점
     var strSlipNo          = DS_IO_MASTER5.NameValue(DS_IO_MASTER5.RowPosition, "SLIP_NO");  //전표번호
    
     var goTo       = "getDetail5" ;    
     var action     = "O";     
     var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)   
                     + "&strSlipNo="+encodeURIComponent(strSlipNo);  
     TR_S_MAIN.Action="/dps/pord211.po?goTo="+goTo+parameters;  
     TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL5=DS_IO_DETAIL5)"; //조회는 O
     TR_S_MAIN.Post();
 }
*/ 
 
/************ 멀티선택시 마스터 디테일 타는 부분*******************/
/**
* confGetDetail(row)
* 작 성 자 : 박래형
* 작 성 일 : 2010-07-07
* 개    요 :  상세조회
* return값 : void
*/
function confGetDetail(row){
    var strVenCd     = "";
    var strStrCd     = DS_O_LIST.NameValue(row,"STR_CD");
    var strSlipNo    = DS_O_LIST.NameValue(row,"SLIP_NO");
    
    var goTo         = "getDetail" ;    
    var action       = "O";     
    var parameters   = "&strStrCd="+encodeURIComponent(strStrCd)
                     + "&strSlipNo="+encodeURIComponent(strSlipNo);
    
    TR_MAIN.Action="/dps/pord211.po?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_MASTER_TMP,"+action+":DS_IO_DETAIL=DS_DETAIL_TMP)"; //조회는 O
    TR_MAIN.Post();
    
    strVenCd  = DS_MASTER_TMP.NameValue(DS_MASTER_TMP.RowPosition, "VEN_CD");
    // 협력사별 반올림 구분을 받는다
    roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, strStrCd, strVenCd);
    
    GR_DETAIL.ColumnProp('SEL','HeadCheck')= "FALSE";
    setMasterObject(false);
   
}

/**
* confGetDetail1(row)
* 작 성 자 : 박래형
* 작 성 일 : 2010-07-07
* 개    요 :  대출입상세조회
* return값 : void
*/
function confGetDetail1(row){
    var strStrCd    = DS_O_LIST.NameValue(row,"STR_CD");
    var strSlipNo   = "";
    var strPSlipNo  = "";
    var strSlipFlag = DS_O_LIST.NameValue(row,"SLIP_FLAG");
    
    if(strSlipFlag == 'C'){
        strSlipNo  = DS_O_LIST.NameValue(row,"SLIP_NO");
        strPSlipNo = DS_O_LIST.NameValue(row,"P_SLIP_NO");
    }else{
        strSlipNo  = DS_O_LIST.NameValue(row,"P_SLIP_NO");
        strPSlipNo = DS_O_LIST.NameValue(row,"SLIP_NO");
    }

    var goTo       = "getDetail1" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                     + "&strSlipNo="+encodeURIComponent(strSlipNo)
                     + "&strPSlipNo="+encodeURIComponent(strPSlipNo)
                     + "&strSlipFlag="+encodeURIComponent(strSlipFlag);
    TR_MAIN.Action="/dps/pord211.po?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER1=DS_MASTER_TMP,"+action+":DS_IO_DETAIL1=DS_DETAIL_TMP,"+action+":DS_IO_DETAIL2=DS_DETAIL_TMP_D)"; //조회는 O
    TR_MAIN.Post();
    
    strVen  = DS_MASTER_TMP.NameValue(DS_MASTER_TMP.RowPosition, "VEN_CD");            // 대출협력사코드
    strPVen = DS_MASTER_TMP.NameValue(DS_MASTER_TMP.RowPosition, "P_VEN_CD");          // 대입협력사코드

    // 협력사별 반올림 구분을 받는다
    roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, strStrCd, strVen);
    pRoundFlag = getVenRoundFlag("DS_O_RESULT", strToday, strStrCd, strPVen);
       
}

/**
* confGetDetail3(row)
* 작 성 자 : 박래형
* 작 성 일 : 2010-07-07
* 개    요 :  점출입 상세조회
* return값 : void
*/
function confGetDetail3(row){
    var strVenCd     = "";
    var strSlipFlag  = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_FLAG");
    var strStrCd     = "";
    var strPStrCd    = "";
    var strSlipNo    = "";
    var strPSlipNo   = "";
    
    strStrCd   = DS_O_LIST.NameValue(row,"STR_CD");
    strSlipNo  = DS_O_LIST.NameValue(row,"SLIP_NO");
    
    var goTo       = "getDetail3" ;    
    var action     = "O";     
    var parameters = "&strSlipFlag="+encodeURIComponent(strSlipFlag)
                     + "&strStrCd="+encodeURIComponent(strStrCd)
                     + "&strSlipNo="+encodeURIComponent(strSlipNo);  
    TR_MAIN.Action="/dps/pord211.po?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER3=DS_MASTER_TMP,"+action+":DS_IO_DETAIL3=DS_DETAIL_TMP)"; //조회는 O
    TR_MAIN.Post();
    
    strStyleType = DS_MASTER_TMP.NameValue(DS_MASTER_TMP.RowPosition,"STYLE_TYPE");
    
    strVenCd  = DS_MASTER_TMP.NameValue(DS_MASTER_TMP.RowPosition, "VEN_CD");
    // 협력사별 반올림 구분을 받는다
    roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, strStrCd, strVenCd);    
}   

/**
* confGetDetail4(row)
* 작 성 자 : 박래형
* 작 성 일 : 2010-07-07
* 개    요 :  매가인상하 상세조회
* return값 : void
*/
function confGetDetail4(row){

    var strVenCd       = "";
    var strStrCd       = DS_O_LIST.NameValue(row,"STR_CD");
    var strSlipNo      = DS_O_LIST.NameValue(row,"SLIP_NO");
    /*
    if(DS_O_LIST.RowPosition >= 1){
        getEventCode("DS_O_OLD_EVENT_CD", strStrCd, strPumbunCd, strOldPrcAppDt, "N");     // 구행사코드
        getEventCode("DS_O_NEW_EVENT_CD", strStrCd, strPumbunCd, strNewPrcAppDt, "N");     // 신행사코드
    }
    */   
    var goTo         = "getDetail4" ;    
    var action       = "O";     
    var parameters   = "&strStrCd="+encodeURIComponent(strStrCd)+
                       "&strSlipNo="+encodeURIComponent(strSlipNo);
    TR_MAIN.Action="/dps/pord211.po?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER4=DS_MASTER_TMP,"+action+":DS_IO_DETAIL4=DS_DETAIL_TMP)"; //조회는 O
    TR_MAIN.Post();
    
    strStyleType = DS_MASTER_TMP.NameValue(DS_MASTER_TMP.RowPosition,"STYLE_TYPE");
    
    strVenCd  = EM_VEN_CD.Text;
    // 협력사별 반올림 구분을 받는다
    roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, strStrCd, strVenCd);
   
}

/**
 * confGetMaster5()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-07-07
 * 개    요 :  마스터 디테일 조회
 * return값 : void
 */
 function confGetMaster5(row){    
    
     // 조회조건 셋팅
     var strStrCd     = DS_O_LIST.NameValue(row, "STR_CD");        // 점
     var strSlipNo    = DS_O_LIST.NameValue(row,"SLIP_NO");
     
    /* var strInvoiceYm       = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "INVOICE_YM");      // INVOICE_YM
     var strInvoiceSeqNo    = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "INVOICE_SEQ_NO");  // INVOICE_SEQ_NO */
     
     var goTo       = "getMaster5";    
     var action     = "O";      
     var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)   
                     + "&strSlipNo="+encodeURIComponent(strSlipNo);  
     TR_MAIN.Action="/dps/pord211.po?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER5=DS_MASTER_TMP,"+action+":DS_IO_DETAIL5=DS_DETAIL_TMP)"; //조회는 O
     TR_MAIN.Post();   
 }

/**
* confGetDetail5()
* 작 성 자 : 박래형
* 작 성 일 : 2010-07-07
* 개    요 :  수입디테일
* return값 : void


function confGetDetail5(){
    
     // 조회조건 셋팅
     var strStrCd           = DS_IO_MASTER5.NameValue(DS_IO_MASTER5.RowPosition, "STR_CD");        // 점
     var strInvoiceYm       = DS_IO_MASTER5.NameValue(DS_IO_MASTER5.RowPosition, "INVOICE_YM");      // INVOICE_YM
     var strInvoiceSeqNo    = DS_IO_MASTER5.NameValue(DS_IO_MASTER5.RowPosition, "INVOICE_SEQ_NO");  // INVOICE_SEQ_NO
     var strSlipNo          = DS_IO_MASTER5.NameValue(DS_IO_MASTER5.RowPosition, "SLIP_NO");  //전표번호
    
     var goTo       = "getDetail5" ;    
     var action     = "O";     
     var parameters =  "&strStrCd="+strStrCd   
                     + "&strInvoiceYm="+strInvoiceYm
                     + "&strInvoiceSeqNo="+strInvoiceSeqNo
                     + "&strSlipNo="+strSlipNo;  
     TR_S_MAIN.Action="/dps/pord211.po?goTo="+goTo+parameters;  
     TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL5=DS_IO_DETAIL5)"; //조회는 O
     TR_S_MAIN.Post();
 }
*/

/**
* dayCloseCheck(strStrCd, strToday, masterChkCnt)
* 작 성 자 : 박래형
* 작 성 일 : 2010-08-24
* 개    요    : 확정시 일시재마감체크한다
* return값 : void
*/
function dayCloseCheck(strStrCd, strToday, masterChkCnt){
     var strStrCd         = strStrCd;               // 점
     var strCloseDt       = strToday;   
     var strCloseTaskFlag = "PORD";                 // 업무구분(매입월마감)
     var strCloseUnitFlag = "06";                   // 단위업무
     var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
     var strCloseFlag     = "T";                    // 마감구분(tlrks)
     
     var closeFlag = getCloseCheck( "DS_O_RESULT", strStrCd , strCloseDt , strCloseTaskFlag 
                                   , strCloseUnitFlag , strCloseAcntFlag , strCloseFlag);
     
     if(closeFlag == "TRUE"){
         showMessage(EXCLAMATION, OK, "USER-1150", "시재마감","검품확정");
         setFocusGrid(GR_LIST, DS_O_LIST,masterChkCnt, "CHECK1");      // 선택으로 포커스
         return false;
     }else{
         return true;
     } 
     return true;
}

/**
* closeCheck(strStrCd, strChkDt, masterChkCnt)
* 작 성 자 : 김경은
* 작 성 일 : 2010-03-10
* 개    요    : 저장시 월마감체크를 한다. 검품확정일로 체크한다 -20110704 박래형
* return값 : void
*/
function closeCheck(strStrCd, strChkDt, masterChkCnt){
     var strStrCd         = strStrCd;      // 점
     var strCloseDt       = strChkDt;   
     var strCloseTaskFlag = "PORD";                 // 업무구분(매입월마감)
     var strCloseUnitFlag = "42";                   // 단위업무
     var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
     var strCloseFlag     = "M";                    // 마감구분(월마감:M)
     
     var closeFlag = getCloseCheck( "DS_O_RESULT", strStrCd , strCloseDt , strCloseTaskFlag 
                                   , strCloseUnitFlag , strCloseAcntFlag , strCloseFlag);
     
     if(closeFlag == "TRUE"){
         showMessage(EXCLAMATION, OK, "USER-1068", "매입월","발주매입");
         setFocusGrid(GR_LIST, DS_O_LIST,masterChkCnt, "CHECK1");      // 선택으로 포커스
         return false;
     }else{
         return true;
     } 
     return true;
}

/**
 * chkPayClose()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-08-12
 * 개    요 :  대금지불 마감 체크
 * return값 : void
 */
 function chkPayClose(row, strStrCd, strVenCd, strChkDt){
     
    var goTo       = "chkPayClose" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
                   + "&strVenCd="+encodeURIComponent(strVenCd)     
                   + "&strChkDt="+encodeURIComponent(strChkDt);     
    TR_MAIN.Action="/dps/pord211.po?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_PAY_CLOSE_CHK=DS_PAY_CLOSE_CHK)"; //조회는 O
    TR_MAIN.Post(); 
    if(DS_PAY_CLOSE_CHK.NameValue(DS_PAY_CLOSE_CHK.RowPosition, "RET_FLAG") == "TRUE"){
        showMessage(INFORMATION, OK, "USER-1220", "대금지불");
        setFocusGrid(GR_LIST, DS_O_LIST ,row, "CHECK1");      // 선택으로 포커스
        return false;
    }else{
        return true;
    }
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
      var strPumbunType   = "";                                                        // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
      var strSkuType      = "";                                                        // 단품종류(1:규격단품)
      var strItgOrdFlag   = "";                                                        // 통합발주여부
      var strBizType      = "";                                                        // 거래형태(1:직매입) 
      var strSaleBuyFlag  = "";                                                       // 판매분매입구분

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
   * setGapCalc()
   * 작 성 자 : 김경은
   * 작 성 일 : 2010-03-10
   * 개    요    : 차익액, 차익율을 계산한다.
   * return값 : void
   */
   function setGapCalc(row){
       var strTaxFlag  = EM_TAX_FLAG.Text;
       var strBizType  = EM_BIZ_TYPE.Text;                               // 거래형태
       var chk_qty     = DS_IO_DETAIL.NameValue(row, "CHK_QTY");         // 검품수량
       var cost_prc    = DS_IO_DETAIL.NameValue(row, "NEW_COST_PRC");    // 원가단가
       var sale_prc    = DS_IO_DETAIL.NameValue(row, "NEW_SALE_PRC");    // 매가단가
       var rate        = DS_IO_DETAIL.NameValue(row, "MG_RATE");         // 마진율
       var cost_amt    = chk_qty * cost_prc;                             // 원가금액
       var sale_amt    = chk_qty * sale_prc;                             // 매가금액
       var vatAmt      = 0;
       var cost_amt_vat = 0;
       
       // 거래형태 (1:직매입,2:특정)
       if(strBizType == "2"){
           ////cost_amt     = getCalcPord("COST_PRC", "", sale_amt, rate, strTaxFlag, roundFlag);  // 원가금액(부가제제외)
           ////cost_amt_vat = getCalcPord("COST_PRC", "", sale_amt, rate, "2", roundFlag);         // 원가금액(부가제포함)
           ////cost_prc     = getRoundDec("1", cost_amt / chk_qty);                                // 원가단가
           ////vatAmt       = cost_amt_vat - cost_amt;
           vatAmt       = getCalcPord("VAT_AMT",  cost_amt,   "",         "", strTaxFlag, roundFlag); 
           
       }else if(strBizType == "1"){
           vatAmt       = getCalcPord("VAT_AMT",  cost_amt,   "",         "", strTaxFlag, roundFlag);    	   
       }
       
       var gapAmt     = getCalcPord("GAP_AMT",  cost_amt,   sale_amt,   "", strTaxFlag, roundFlag);
       var gapRate    = getCalcPord("GAP_RATE", cost_amt,   sale_amt,   "", strTaxFlag, roundFlag);
       
       DS_IO_DETAIL.NameValue(row, "NEW_COST_AMT") = cost_amt;    // 원가금액
       DS_IO_DETAIL.NameValue(row, "NEW_SALE_AMT") = sale_amt;    // 매가금액
       DS_IO_DETAIL.NameValue(row, "NEW_GAP_AMT")  = gapAmt;      // 차익액
       DS_IO_DETAIL.NameValue(row, "NEW_GAP_RATE") = gapRate;     // 차익율
       DS_IO_DETAIL.NameValue(row, "VAT_AMT")      = vatAmt;      // 부가세

       var totCostAmt = DS_IO_DETAIL.Sum(22,0,0);
       var totSaleAmt = DS_IO_DETAIL.Sum(24,0,0);   
       ////var totGapAmt  = DS_IO_DETAIL.Sum(13,0,0);    
       var totGapAmt  = getCalcPord("GAP_AMT",  totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
       var totGapRate = getCalcPord("GAP_RATE", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);

       EM_GAP_TOT_AMT.Text  = totGapAmt;
       EM_GAP_RATE.Text     = totGapRate;       
       EM_TOT_QTY.Text      = DS_IO_DETAIL.Sum(19,0,0);
       EM_TOT_COST_AMT.Text = DS_IO_DETAIL.Sum(22,0,0);
       EM_TOT_SALE_AMT.Text = DS_IO_DETAIL.Sum(24,0,0);
       
       var totCostAmt       = EM_TOT_COST_AMT.Text;
       var totVatAmt         = getCalcPord("VAT_AMT", totCostAmt, "", "", strTaxFlag, roundFlag);
       ////EM_TOT_TAX.Text      = DS_IO_DETAIL.Sum(20,0,0);
       EM_TOT_TAX.Text      = totVatAmt;
     }
   
   /**
    * setGapCalcPrc()
    * 작 성 자 : 김경은
    * 작 성 일 : 2010-03-10
    * 개    요    : 원가금액 변경시 부가세, 차익율, 차익액계산
    * return값 : void
    */
    function setGapCalcPrc(row){
          var strTaxFlag  = EM_TAX_FLAG.Text;
          var strBizType  = EM_BIZ_TYPE.Text;                               // 거래형태
         // var ord_qty     = DS_IO_DETAIL.NameValue(row, "ORD_QTY");       // 발주수량
          var chk_qty     = DS_IO_DETAIL.NameValue(row, "CHK_QTY");         // 검품수량
          var cost_prc    = DS_IO_DETAIL.NameValue(row, "NEW_COST_PRC");    // 원가단가
          var sale_prc    = DS_IO_DETAIL.NameValue(row, "NEW_SALE_PRC");    // 매가단가
          var cost_amt    = DS_IO_DETAIL.NameValue(row, "NEW_COST_AMT");    // 원가금액
          var sale_amt    = chk_qty * sale_prc;                             // 매가금액
          
          DS_IO_DETAIL.NameValue(row, "NEW_SALE_AMT") = sale_amt;           // 매가금액

          var totCostAmt = DS_IO_DETAIL.Sum(22,0,0);
          var totSaleAmt = DS_IO_DETAIL.Sum(24,0,0);
          
          // 거래형태 (1:직매입,2:특정)
          switch (strBizType) {
          case "1":
              if(DS_IO_DETAIL.Sum(24,0,0) > 0){
                  DS_IO_DETAIL.NameValue(row, "NEW_GAP_RATE")  = getCalcPord("GAP_RATE", cost_amt,   sale_amt,   "", strTaxFlag, roundFlag);
              }
              break;
          case "2":
              GR_DETAIL.ColumnProp("NEW_COST_PRC", "Edit")    = "none";
              GR_DETAIL.ColumnProp("NEW_SALE_PRC", "Edit")    = "none";
              break;
          }
             
          var gapAmt     = getCalcPord("GAP_AMT",  cost_amt,   sale_amt,   "", strTaxFlag, roundFlag);
          var gapRate    = getCalcPord("GAP_RATE", cost_amt,   sale_amt,   "", strTaxFlag, roundFlag);
          var vatAmt     = getCalcPord("VAT_AMT",  cost_amt,   "",         "", strTaxFlag, roundFlag);

          DS_IO_DETAIL.NameValue(row, "NEW_GAP_AMT")  = gapAmt;      // 차익액
          DS_IO_DETAIL.NameValue(row, "NEW_GAP_RATE") = gapRate;     // 차익율
          DS_IO_DETAIL.NameValue(row, "VAT_AMT")      = vatAmt;      // 부가세
          
          var totGapAmt  = getCalcPord("GAP_AMT",  totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
          var totGapRate = getCalcPord("GAP_RATE", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);

          EM_GAP_TOT_AMT.Text = totGapAmt;
          EM_GAP_RATE.Text    = totGapRate;
          
          EM_TOT_QTY.Text      = DS_IO_DETAIL.Sum(19,0,0);
          EM_TOT_COST_AMT.Text = DS_IO_DETAIL.Sum(22,0,0);
          EM_TOT_SALE_AMT.Text = DS_IO_DETAIL.Sum(24,0,0);
          var totCostAmt       = EM_TOT_COST_AMT.Text;
          var totVatAmt         = getCalcPord("VAT_AMT", totCostAmt, "", "", strTaxFlag, roundFlag);
          ////EM_TOT_TAX.Text      = DS_IO_DETAIL.Sum(20,0,0);
          EM_TOT_TAX.Text      = totVatAmt;
          DS_IO_MASTER5.NameValue(DS_IO_MASTER5.RowPosition, "EXC_TAMT") = DS_IO_DETAIL.Sum(25,0,0);    
      }
    
    /**
     * setGapCalc5()
     * 작 성 자 : 신명tjq
     * 작 성 일 : 2010-03-10
     * 개    요    : 수입전표의 차익액, 차익율을 계산한다.
     * return값 : void
     */
    function setGapCalc5(row){
        var strTaxFlag  = EM_TAX_FLAG5.Text;
        var strBizType  = EM_BIZ_TYPE5.Text;                               // 거래형태
       // var ord_qty     = DS_IO_DETAIL.NameValue(row, "ORD_QTY");         // 발주수량
        var chk_qty     = DS_IO_DETAIL5.NameValue(row, "CHK_QTY");         // 검품수량
        var cost_prc    = DS_IO_DETAIL5.NameValue(row, "NEW_COST_PRC");    // 원가단가
        var sale_prc    = DS_IO_DETAIL5.NameValue(row, "NEW_SALE_PRC");    // 매가단가
        var exc_prc     = DS_IO_DETAIL5.NameValue(row, "EXC_PRC");         // 외화원가
        var cost_amt    = chk_qty * cost_prc;                             // 원가금액
        var sale_amt    = chk_qty * sale_prc;                             // 매가금액
        var exc_amt     = chk_qty * exc_prc;                              //외화금액
        
        
        DS_IO_DETAIL5.NameValue(row, "NEW_COST_AMT") = cost_amt;          // 원가금액
        DS_IO_DETAIL5.NameValue(row, "NEW_SALE_AMT") = sale_amt;          // 매가금액
        DS_IO_DETAIL5.NameValue(row, "EXC_AMT")      = exc_amt;           // 외화금액

        var totCostAmt = DS_IO_DETAIL5.Sum(23,0,0);
        var totSaleAmt = DS_IO_DETAIL5.Sum(27,0,0);
        
        // 거래형태 (1:직매입)
        switch (strBizType) {
        case "1":
            if(DS_IO_DETAIL5.Sum(27,0,0) > 0){
                DS_IO_DETAIL5.NameValue(row, "NEW_GAP_RATE")  = getCalcPord("GAP_RATE", cost_amt,   sale_amt,   "", strTaxFlag, roundFlag);
            }
//            GR_DETAIL5.ColumnProp("NEW_COST_PRC", "Edit")    = "Numeric";
//            GR_DETAIL5.ColumnProp("NEW_SALE_PRC", "Edit")    = "Numeric";
            break;
        }
           
        var gapAmt     = getCalcPord("GAP_AMT",  cost_amt,   sale_amt,   "", strTaxFlag, roundFlag);
        var gapRate    = getCalcPord("GAP_RATE", cost_amt,   sale_amt,   "", strTaxFlag, roundFlag);
        var vatAmt     = getCalcPord("VAT_AMT",  cost_amt,   "",         "", strTaxFlag, roundFlag);

        DS_IO_DETAIL5.NameValue(row, "NEW_GAP_AMT")  = gapAmt;      // 차익액
        DS_IO_DETAIL5.NameValue(row, "NEW_GAP_RATE") = gapRate;     // 차익율
        DS_IO_DETAIL5.NameValue(row, "VAT_AMT")      = vatAmt;      // 부가세
        
        var totGapAmt  = getCalcPord("GAP_AMT",  totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
        var totGapRate = getCalcPord("GAP_RATE", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);

        EM_TOT_GAP_AMT5.Text     = totGapAmt;
        EM_TOT_GAP_RATE5.Text    = totGapRate;
        
        EM_I_INVOICE_TOT_QTY5.Text      = DS_IO_DETAIL5.Sum(20,0,0); 
        EM_I_INVOICE_TOT_AMT5.Text      = DS_IO_DETAIL5.Sum(23,0,0);
        EM_I_SALE_TOT_AMT5.Text         = DS_IO_DETAIL5.Sum(27,0,0);
        EM_TOT_TAX5.Text                = DS_IO_DETAIL5.Sum(21,0,0); 
       
    } 
     
     /**
      * setGapCalcPrc5()
      * 작 성 자 : 신명tjq
      * 작 성 일 : 2010-03-10
      * 개    요    : 수입전표의 차익액, 차익율을 계산한다.
      * return값 : void
      */
     function setGapCalcPrc5(row){
         var strTaxFlag  = EM_TAX_FLAG5.Text;
         var strBizType  = EM_BIZ_TYPE5.Text;                               // 거래형태
        // var ord_qty     = DS_IO_DETAIL.NameValue(row, "ORD_QTY");        // 발주수량
         var chk_qty     = DS_IO_DETAIL5.NameValue(row, "CHK_QTY");         // 검품수량
         var cost_prc    = DS_IO_DETAIL5.NameValue(row, "NEW_COST_PRC");    // 원가단가
         var sale_prc    = DS_IO_DETAIL5.NameValue(row, "NEW_SALE_PRC");    // 매가단가
         var exc_prc     = DS_IO_DETAIL5.NameValue(row, "EXC_PRC");         // 외화원가
         var cost_amt    = DS_IO_DETAIL5.NameValue(row, "NEW_COST_AMT");    // 원가금액
         var sale_amt    = chk_qty * sale_prc;                              // 매가금액
         var exc_amt     = chk_qty * exc_prc;                               // 외화금액
         
         DS_IO_DETAIL5.NameValue(row, "NEW_SALE_AMT") = sale_amt;           // 매가금액
         DS_IO_DETAIL5.NameValue(row, "EXC_AMT")      = exc_amt;            // 외화금액

         var totCostAmt = DS_IO_DETAIL5.Sum(23,0,0);
         var totSaleAmt = DS_IO_DETAIL5.Sum(27,0,0);
         
         // 거래형태 (1:직매입)
         switch (strBizType) {
         case "1":
             if(DS_IO_DETAIL5.Sum(27,0,0) > 0){
                 DS_IO_DETAIL5.NameValue(row, "NEW_GAP_RATE")  = getCalcPord("GAP_RATE", cost_amt,   sale_amt,   "", strTaxFlag, roundFlag);
             }
             break;
         }

         var gapAmt     = getCalcPord("GAP_AMT",  cost_amt,   sale_amt,   "", strTaxFlag, roundFlag);
         var gapRate    = getCalcPord("GAP_RATE", cost_amt,   sale_amt,   "", strTaxFlag, roundFlag);
         var vatAmt     = getCalcPord("VAT_AMT",  cost_amt,   "",         "", strTaxFlag, roundFlag);
         
         DS_IO_DETAIL5.NameValue(row, "NEW_GAP_AMT")  = gapAmt;      // 차익액
         DS_IO_DETAIL5.NameValue(row, "NEW_GAP_RATE") = gapRate;     // 차익율
         DS_IO_DETAIL5.NameValue(row, "VAT_AMT")      = vatAmt;      // 부가세
         
         var totGapAmt  = getCalcPord("GAP_AMT",  totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
         var totGapRate = getCalcPord("GAP_RATE", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);

         EM_TOT_GAP_AMT5.Text     = totGapAmt;
         EM_TOT_GAP_RATE5.Text    = totGapRate;
         
         EM_I_INVOICE_TOT_QTY5.Text      = DS_IO_DETAIL5.Sum(20,0,0); 
         EM_I_INVOICE_TOT_AMT5.Text      = DS_IO_DETAIL5.Sum(23,0,0);
         EM_I_SALE_TOT_AMT5.Text         = DS_IO_DETAIL5.Sum(27,0,0);
         EM_TOT_TAX5.Text                = DS_IO_DETAIL5.Sum(21,0,0); 

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
   * chkOfferClose()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-07-19
   * 개    요 :  수입일때 오퍼마감체크
   * return값 : void
   */
   function chkOfferClose(strStrCd, strOfferClose, row){    
       
	   var goTo       = "chkOfferClose" ;    
	   var action     = "O";     
	   var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
	                  + "&strOfferClose="+encodeURIComponent(strOfferClose);  
	   TR_S_MAIN.Action="/dps/pord211.po?goTo="+goTo+parameters;  
	   TR_S_MAIN.KeyValue="SERVLET("+action+":DS_OFFER_CLOSE=DS_OFFER_CLOSE)"; //조회는 O
	   TR_S_MAIN.Post();    
	   
	   if(DS_OFFER_CLOSE.NameValue(DS_OFFER_CLOSE.RowPosition, "CLOSE_FLAG") == "Y"){
	       showMessage(EXCLAMATION, OK, "USER-1000", "OFFER 마감처리 되었습니다.");
	       setFocusGrid(GR_LIST, DS_O_LIST, row, "CHECK1"); 
	       return false;
	   }
	   return true;
   }

   /**
    * chkAppDtPrice(strStrCd, strSlipNo, strSendFlag)
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-07-21
    * 개    요    : 확정시 단품 가격정합성체크
    * return값 : void
    */
    function chkAppDtPrice(strStrCd, strSlipNo, strSendFlag, rowPosition){    

	    var strreturnValue = null;
	    
	    var goTo       = "chkAppDtPrice" ;    
	    var action     = "O";     
	    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
			           + "&strSlipNo="+encodeURIComponent(strSlipNo) 
			           + "&strSendFlag="+encodeURIComponent(strSendFlag);  
	    TR_APPDT_PRICE.Action="/dps/pord211.po?goTo="+goTo+parameters;  
	    TR_APPDT_PRICE.KeyValue="SERVLET("+action+":DS_APPDT_PRICE=DS_APPDT_PRICE)"; //조회는 O
	    TR_APPDT_PRICE.Post(); 
	      
	    var ssssmmm    = DS_APPDT_PRICE.NameValue(1, "RETURN_MESSAGE");
	    strreturnValue = parseInt(DS_APPDT_PRICE.NameValue(1, "RETURN_INT")); 
	    
	    if(strreturnValue != 0){  
	  	  setFocusGrid(GR_LIST, DS_O_LIST, rowPosition, "CHECK1");      // 선택으로 포커스
	        showMessage(EXCLAMATION, OK, "SCRIPT-1000", ssssmmm);
	  	  return false;
	    }
	
	    return true;
    }

    /**
     * checkTaxYn(strStrCd, strSlipNo, strSendFlag)
     * 작 성 자 : 박래형
     * 작 성 일 : 2010-07-24
     * 개    요    : 확정시 비단품 마진적용일 체크
     * return값 : void
     */
     function checkTaxYn(strStrCd, strSlipNo, rowPosition){    
         var strreturnValue = "";
         
         var goTo       = "checkTaxYn" ;    
         var action     = "O";     
         var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
                        + "&strSlipNo="+encodeURIComponent(strSlipNo);  
         TR_S_MAIN.Action="/dps/pord211.po?goTo="+goTo+parameters;  
         TR_S_MAIN.KeyValue="SERVLET("+action+":DS_TAX_YN=DS_TAX_YN)"; //조회는 O
         TR_S_MAIN.Post(); 

         strreturnValue = DS_TAX_YN.NameValue(1, "TAX_YN_FLAG");    
         var ssssmmm = "이미 매입세금계산서가 생성되었습니다. 확인바랍니다.";
         if(strreturnValue == "Y"){  
             setFocusGrid(GR_LIST, DS_O_LIST, rowPosition, "CHECK1");      // 선택으로 포커스
             showMessage(EXCLAMATION, OK, "SCRIPT-1000", ssssmmm);
             return false;
         }
         return true;
     }

    /**
     * checkChkDt(strOrdDt, strChkDt)
     * 작 성 자 : 박래형
     * 작 성 일 : 2010-08-03
     * 개    요    : 발주일에 따른 검품확정일 체크
     * return값 : void
     */
     function checkChkDt(strOrdDt, strChkDt, strAftOrdFlag){    

         //var strToday = "20111231";
         //사전전표일경우
         if(strAftOrdFlag == "0"){
             //시스템일자가 검품확정일보다 클 경우
             if(strToday > strChkDt){     
                 
                 //발주월이 시스템월보다 크거나 같을 경우
                 if(strOrdDt.substring(0, 6) >= strToday.substring(0, 6)){   
                	 
                	 // 전월인 경우는 OK, 전월이 아닌 경우 NOT OK
                	 if(setDateAdd("D", 1, strOrdDt).substring(0, 6) != strToday.substring(0, 6)) {
                       showMessage(EXCLAMATION, OK, "USER-1020", "검품확정일","시스템일자");
                       return false;
                       
                	 }
                       
                 //발주월이 시스템월보다 작을 경우      
                 }else if(strOrdDt.substring(0, 6) < strToday.substring(0, 6)){   
                     
                     //검품확정일이 발주월의 마지막 날이면
                     if((strChkDt.substring(0, 6) == strOrdDt.substring(0, 6)) && (strChkDt.substring(0, 6) != setDateAdd("D", 1, strChkDt).substring(0, 6))){    
                         return true;
                         
                     //검품확정일이 그달의 마지막 일자가 아니면    
                     }else if(strChkDt.substring(0, 6) == strOrdDt.substring(0, 6)){                                                                           
                         showMessage(EXCLAMATION, OK, "USER-1214");
                         return false;
                         
                     //검품확정일이 그달의 마지막 일자가 아니면    
                     }else{                                                                           
                           showMessage(EXCLAMATION, OK, "USER-1213");
                           return false;
                     }
                 }
             }
         }        
         return true;
     }
  /**
   * chechJgDtFlag(strStrCd, strChkDt, strSendFlag)
   * 작 성 자 : 박래형
   * 작 성 일 : 2011-09-29
   * 개    요    : 검품확정시 재고실사마감체크여부
   * return값 : void
   */
   function chechJgDtFlag(strStrCd, strChkDt, rowPosition){    
       var strreturnValue = "";
       
       var goTo       = "chechJgDtFlag" ;    
       var action     = "O";     
       var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
                      + "&strChkDt="+encodeURIComponent(strChkDt);  
       TR_APPDT_PRICE.Action="/dps/pord211.po?goTo="+goTo+parameters;  
       TR_APPDT_PRICE.KeyValue="SERVLET("+action+":DS_CHK_JG_FLAG=DS_CHK_JG_FLAG)"; //조회는 O
       TR_APPDT_PRICE.Post(); 

       strreturnValue = DS_CHK_JG_FLAG.NameValue(1, "CHK_JG_FLAG");     
       var ssssmmm = "재고실사가 마감되어 실사일 이전으로 검품확정할수 없습니다.";
       if(strreturnValue == "FALSE"){  
           setFocusGrid(GR_LIST, DS_O_LIST, rowPosition, "CHECK1");      // 선택으로 포커스
           showMessage(EXCLAMATION, OK, "SCRIPT-1000", ssssmmm);
           return false;
       }
       return true;
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
        showMessage(EXCLAMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_L_MAIN event=onSuccess>
    for(i=0;i<TR_L_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_L_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_APPDT_PRICE event=onSuccess>
    for(i=0;i<TR_APPDT_PRICE.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_APPDT_PRICE.SrvErrMsg('UserMsg',i));
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
<script language=JavaScript for=TR_APPDT_PRICE event=onFail>
    trFailed(TR_APPDT_PRICE.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--  ===================DS_O_LIST============================ -->
<script language=JavaScript for=DS_O_LIST event=CanRowPosChange(row)>

    if(DS_IO_MASTER.IsUpdated || DS_IO_MASTER1.IsUpdated || DS_IO_MASTER3.IsUpdated || DS_IO_MASTER4.IsUpdated || DS_IO_MASTER5.IsUpdated 
                              || DS_IO_DETAIL.IsUpdated  || DS_IO_DETAIL5.IsUpdated ){

        if(showMessage(INFORMATION, YESNO, "GAUCE-1000", "변경된 내역이 있습니다. <br> 이동 하시겠습니까?") != 1 ){
            return false;
            
        }else{
            DS_IO_MASTER.ResetStatus();
            DS_IO_MASTER1.ResetStatus();
            DS_IO_MASTER3.ResetStatus();
            DS_IO_MASTER4.ResetStatus();
            DS_IO_MASTER5.ResetStatus();
            DS_IO_DETAIL.ResetStatus();
            DS_IO_DETAIL5.ResetStatus();
            return true;        	
        }
    }  
</script>

<script language=JavaScript for=DS_O_LIST event=onRowPosChanged(row)>

   if(clickSORT)
      return;
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        var strSlipNo       = DS_O_LIST.NameValue(row, "SLIP_NO");          // 발주번호
        var strSlipProcStat = DS_O_LIST.NameValue(row, "SLIP_PROC_STAT");   // 전표상태
        var strSkuType      = DS_O_LIST.NameValue(row, "SKU_TYPE");         // 단품종류(1,규격..)
        var strSlipflag     = DS_O_LIST.NameValue(row, "SLIP_FLAG");        // 전표구분
        var strImportFlag   = DS_O_LIST.NameValue(row, "IMPORT_FLAG");      // 수입구분
        var strStyleType    = DS_O_LIST.NameValue(row, "STYLE_TYPE");       // 스타일타입
        var strBizType      = DS_O_LIST.NameValue(row, "BIZ_TYPE");         // 거래형태 
      
        //setTabItemIndex( TabDivID, Index)
        switch(strSlipflag){
           case 'A':
              if(strImportFlag == '1'){ 
                  setTabItemIndex('TAB_MAIN',5);
              }else{
                 setTabItemIndex('TAB_MAIN',1); 
              }
              break;
               
           case 'B': 
               setTabItemIndex('TAB_MAIN',1); 
               break;
           case 'C': 
               setTabItemIndex('TAB_MAIN',2);  
               break; 
           case 'E': 
               setTabItemIndex('TAB_MAIN',3);  
               break; 
           case 'F': 
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
                    //getDetail5();
                    if(intSearchCnt == 0){
                       intSearchCnt++;
                    }else
                        setPorcCount("SELECT", DS_IO_DETAIL5.CountRow);
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
               GR_DETAIL.ColumnProp("AVG_SALE_QTY", "Show") = "true"; /* 평균판매량 */
               GR_DETAIL.ColumnProp("AVG_SALE_AMT", "Show") = "true"; /* 평균판매액 */
               GR_DETAIL.ColumnProp("ORD_STK_QTY", "Show") = "true";  /* 현재고 */

               break;
            case 2:
               //대출입
               GR_DETAIL1.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
               GR_DETAIL1.ColumnProp("STYLE_CD", "Show") = "false";     /* 스타일 */
               GR_DETAIL1.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */
               GR_DETAIL2.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
               GR_DETAIL2.ColumnProp("STYLE_CD", "Show") = "false";     /* 스타일 */
               GR_DETAIL2.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */
               break;
            case 3:
                //점출입
               GR_DETAIL3.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
               GR_DETAIL3.ColumnProp("STYLE_CD", "Show") = "false";     /* 스타일 */
               GR_DETAIL3.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */
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

               break;
            case 2:
               //대출입
               GR_DETAIL1.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
               GR_DETAIL1.ColumnProp("STYLE_CD", "Show") = "false";     /* 스타일 */
               GR_DETAIL1.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */
               GR_DETAIL2.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
               GR_DETAIL2.ColumnProp("STYLE_CD", "Show") = "false";     /* 스타일 */
               GR_DETAIL2.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */
               break;
            case 3:
                //점출입
               GR_DETAIL3.ColumnProp("SIZE_CD", "Show") = "false";      /* 사이즈 */
               GR_DETAIL3.ColumnProp("STYLE_CD", "Show") = "false";     /* 스타일 */
               GR_DETAIL3.ColumnProp("COLOR_CD", "Show") = "false";     /* 칼라 */
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
               
               break;
            case 2:
                //대출입
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
            }
        }   
        setMasterObject(false);
            
            /* 확정된전표는 검품수량 edit 막는다 */
        if(strSlipProcStat !="09"){   /*shin */
            if(strSlipflag == 'A'){
               if(strImportFlag == '1'){ 
                   GR_DETAIL5.Editable  = true; /*수입*/
               } else{
                   GR_DETAIL.Editable  = true; /*매입*/
               }
            }
            if(strSlipflag == 'B'){
               GR_DETAIL.Editable  = true;  
            }
               
        }else{
            if(strSlipflag == 'A'){
                if(strImportFlag == '1'){ 
                    GR_DETAIL5.Editable  = false; /*수입*/
                } else{
                    GR_DETAIL.Editable  = false; /*매입*/
                }
            }
            if(strSlipflag == 'B'){
                GR_DETAIL.Editable  = false;  
            }
        }

       /* 검품확정일을 수정허가 하고 막는다 */ 
        switch(strSlipflag){
        case 'A':
            if(strImportFlag == '0'){
                if(strSlipProcStat !="09"  ){                                               
                    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "AFT_ORD_FLAG")=='0'){               
                        EM_CHK_DT.Enable   = true;                                                         
                        enableControl(IMG_EM_CHK_DT, true);                                                
                    }else{
                        EM_CHK_DT.Enable   = false;                                                          
                        enableControl(IMG_EM_CHK_DT, false);   
                    }                                                                                         
                                                                                                                
                }else{                      
                   EM_CHK_DT.Enable   = false;                                                          
                   enableControl(IMG_EM_CHK_DT, false);                                     
                } 
                
             }else{
                 if(strSlipProcStat !="09"  ){                                                               
                                                                                                 
                     EM_CHK_DT5.Enable   = true;                                                         
                     enableControl(IMG_EM_CHK_DT5, true);                                                  
                                                                                      
                  }else{                                                                                       
                                               
                     EM_CHK_DT5.Enable   = false;                                                          
                     enableControl(IMG_EM_CHK_DT5, false);                                                 
                  }         
             }
             break;
           
        case 'B': 
            if(strSlipProcStat !="09"  ){                                                                
                                                                                        
                if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "AFT_ORD_FLAG")=='0'){               
                    EM_CHK_DT.Enable   = true;                                                         
                    enableControl(IMG_EM_CHK_DT, true);                                                
                }else{
                    EM_CHK_DT.Enable   = false;                                                          
                    enableControl(IMG_EM_CHK_DT, false);  
                }                                                                                         
                                                                                                            
             }else{                      
                 EM_CHK_DT.Enable   = false;                                                          
                 enableControl(IMG_EM_CHK_DT, false);                                  
             }       
             break;
            
        case 'C': 
            if(strSlipProcStat !="09"  ){                                             
                if (DS_IO_MASTER1.NameValue(DS_IO_MASTER1.RowPosition, "AFT_ORD_FLAG")=='0'){               
                    EM_CHK_DT1.Enable   = true;                                                         
                    enableControl(IMG_EM_CHK_DT1, true);                                                
                }else{
                    EM_CHK_DT1.Enable   = false;                                                          
                    enableControl(IMG_EM_CHK_DT1, false);    
                }                                                                                         
                                                                                                            
            }else{                       
                EM_CHK_DT1.Enable   = false;                                                          
                enableControl(IMG_EM_CHK_DT1, false);                                  
            }       
            break;
            
        case 'E': 
            if(strSlipProcStat !="09" && strSlipProcStat !="08" ){                                                                
                if (DS_IO_MASTER3.NameValue(DS_IO_MASTER3.RowPosition, "AFT_ORD_FLAG")=='0'){               
                    EM_CHK_DT3.Enable   = true;                                                         
                    enableControl(IMG_EM_CHK_DT3, true); 
                }else{
                    EM_CHK_DT3.Enable   = false;                                                          
                    enableControl(IMG_EM_CHK_DT3, false);   
                }                                               
                                                                                                            
            }else{                                                                                       
                EM_CHK_DT3.Enable   = false;                                                          
                enableControl(IMG_EM_CHK_DT3, false);                               
            }       
            break;
            
        case 'F': 
            if(strSlipProcStat !="09" && strSlipProcStat !="08" ){                                                                
                if (DS_IO_MASTER3.NameValue(DS_IO_MASTER3.RowPosition, "AFT_ORD_FLAG")=='0'){               
                    EM_CHK_DT3.Enable   = true;                                                         
                    enableControl(IMG_EM_CHK_DT3, true); 
                }else{
                    EM_CHK_DT3.Enable   = false;                                                          
                    enableControl(IMG_EM_CHK_DT3, false);   
                }                                               
                                                                                                            
            }else{                                                                                       
                EM_CHK_DT3.Enable   = false;                                                          
                enableControl(IMG_EM_CHK_DT3, false);                                
            }       
            break;  
            
        case 'G': 
            if(strSlipProcStat !="09"  ){                                                                
                                                                       
                if (DS_IO_MASTER4.NameValue(DS_IO_MASTER4.RowPosition, "AFT_ORD_FLAG")=='0'){               
                    EM_CHK_DT4.Enable   = true;                                                         
                    enableControl(IMG_EM_CHK_DT4, true);                                                
                }else{
                    EM_CHK_DT4.Enable   = false;                                                          
                    enableControl(IMG_EM_CHK_DT4, false);  
                }                                                                                         
                                                                                                            
            }else{                      
               EM_CHK_DT4.Enable   = false;                                                          
               enableControl(IMG_EM_CHK_DT4, false);                                  
            }       
            break;
        }  
    }

    if(strSkuType == "2"){
        GR_DETAIL.ColumnProp("RATE",  "Show") = "True";     /* 목표이익율 */
        GR_DETAIL1.ColumnProp("RATE", "Show") = "True";     /* 목표이익율 */
        GR_DETAIL2.ColumnProp("RATE", "Show") = "True";     /* 목표이익율 */
        GR_DETAIL3.ColumnProp("RATE", "Show") = "True";     /* 목표이익율 */
    }else{
        GR_DETAIL.ColumnProp("RATE",  "Show") = "False";     /* 목표이익율 */
        GR_DETAIL1.ColumnProp("RATE", "Show") = "False";     /* 목표이익율 */
        GR_DETAIL2.ColumnProp("RATE", "Show") = "False";     /* 목표이익율 */
        GR_DETAIL3.ColumnProp("RATE", "Show") = "False";     /* 목표이익율 */
    }
</script>

<!-- 매입반품 -->
<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>
	if (DS_IO_MASTER.NameValue(row,"TAX_FLAG")== '1'){
	    GR_DETAIL.ColumnProp("VAT_AMT", "Edit")    = "Numeric";
	    
	}else{
	    GR_DETAIL.ColumnProp("VAT_AMT", "Edit")    = "None";    
	}
	
    if(DS_IO_MASTER.NameValue(row,"BIZ_TYPE")== '1'){
        GR_DETAIL.ColumnProp("NEW_COST_AMT", "edit") = "none";  /* 원가금액 */
    }else{
        GR_DETAIL.ColumnProp("NEW_COST_AMT", "edit") = "numeric";  /* 원가금액 */
    }
	
</script>
<!-- 수입 -->
<script language=JavaScript for=DS_IO_MASTER5 event=onRowPosChanged(row)>
	if (DS_IO_MASTER5.NameValue(row,"TAX_FLAG")== '1'){
	    GR_DETAIL5.ColumnProp("VAT_AMT", "Edit")    = "Numeric";
	    
	}else{
	    GR_DETAIL5.ColumnProp("VAT_AMT", "Edit")    = "None";	    
	}
    
    if(DS_IO_MASTER5.NameValue(row,"BIZ_TYPE")== '1'){
        GR_DETAIL5.ColumnProp("NEW_COST_AMT", "edit") = "none";  /* 원가금액 */
    }else{
        GR_DETAIL5.ColumnProp("NEW_COST_AMT", "edit") = "numeric";  /* 원가금액 */
    }
</script>

<script language=JavaScript for=DS_O_LIST event=OnColumnChanged(row,colid)>
	
	g_listChkCnt = 0;
	if(colid == "CHECK1" ){
	    for(var x = 1; x<= DS_O_LIST.CountRow; x++){
	        if(this.NameValue(x, "CHECK1") == "T"){
	            g_listChkCnt = g_listChkCnt + 1;
	        }
	    }   
	}
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
</script>

<!--  ===================DS_IO_DETAIL============================ -->

<script language="javascript"  for=GR_DETAIL event=CanColumnPosChange(Row,Colid)>

    var ord_qty  = DS_IO_DETAIL.NameValue(Row, "ORD_QTY");   // 발주수량
    var chk_qty  = DS_IO_DETAIL.NameValue(Row, "CHK_QTY");   // 검품수량
    
    switch (Colid) {    
       case "CHK_QTY":  
          if(DS_IO_DETAIL.NameValue(Row, "CHK_QTY") > DS_IO_DETAIL.NameValue(Row, "ORD_QTY")){
             showMessage(INFORMATION, OK, "USER-1021", "검품수량","발주수량");
             return false;
          }
          return true;
          break;  
    }   
   
</script>

<script language=JavaScript for=DS_IO_DETAIL event=OnColumnChanged(row,colid)>

    var ord_qty  = this.NameValue(row, "ORD_QTY");   // 발주수량
    var chk_qty  = this.NameValue(row, "CHK_QTY");   // 검품수량
    
    switch (colid) {
       case "CHK_QTY":  
           setGapCalc(row);
           break;
           
       case "VAT_AMT":
    	   var strTaxFlag = EM_TAX_FLAG.Text;
    	   var totCostAmt = DS_IO_DETAIL.Sum(22,0,0);
           var totVatAmt  = getCalcPord("VAT_AMT", totCostAmt, "", "", strTaxFlag, roundFlag);
                            //getCalcPord("VAT_AMT", totCostAmt, "", "", strTaxFlag, roundFlag);
           ////EM_TOT_TAX.Text      = DS_IO_DETAIL.Sum(20,0,0);
           var totVatAmt  = getCalcPord("VAT_AMT", totCostAmt, "", "", strTaxFlag, roundFlag);

           EM_TOT_TAX.Text      = totVatAmt;
           break;
           
       case "NEW_COST_AMT":
           setGapCalcPrc(row);
    	   break;
    }   

</script>

<script language="javascript"  for=GR_DETAIL5 event=CanColumnPosChange(Row,Colid)>

    var ord_qty  = DS_IO_DETAIL5.NameValue(Row, "ORD_QTY");   // 발주수량
    var chk_qty  = DS_IO_DETAIL5.NameValue(Row, "CHK_QTY");   // 검품수량
    
    switch (Colid) {    
       case "CHK_QTY":  
          if(DS_IO_DETAIL5.NameValue(Row, "CHK_QTY") > DS_IO_DETAIL5.NameValue(Row, "ORD_QTY")){
             showMessage(INFORMATION, OK, "USER-1021", "검품수량","발주수량");
             return false;
          }
          return true;
          break;  
    }   
   
</script>
<script language=JavaScript for=DS_IO_DETAIL5 event=OnColumnChanged(row,colid)>
	
	var ord_qty  = this.NameValue(row, "ORD_QTY");   // 발주수량
	var chk_qty  = this.NameValue(row, "CHK_QTY");   // 검품수량
	
	switch (colid) {
	  case "CHK_QTY":  
	      setGapCalc5(row);
	      break;
      case "NEW_COST_AMT":
          setGapCalcPrc5(row);
          break;
	}   
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
<!-- 검품확정일 변경시  -->
<script lanaguage=JavaScript for=EM_CHK_DT event=OnKillFocus()>
   checkDateTypeYMD( EM_CHK_DT );
</script>
<script lanaguage=JavaScript for=EM_CHK_DT1 event=OnKillFocus()>
   checkDateTypeYMD( EM_CHK_DT1 );
</script>
<script lanaguage=JavaScript for=EM_CHK_DT3 event=OnKillFocus()>
   checkDateTypeYMD( EM_CHK_DT3 );
</script>
<script lanaguage=JavaScript for=EM_CHK_DT4 event=OnKillFocus()>
   checkDateTypeYMD( EM_CHK_DT4 );
</script>
<script lanaguage=JavaScript for=EM_CHK_DT5 event=OnKillFocus()>
   checkDateTypeYMD( EM_CHK_DT5 );
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
<comment id="_NSID_"><object id="DS_IO_DETAIL"          classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL1"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL2"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL3"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL4"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL5"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CHK_SLIP_FLAG"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_NEW_EVENT_CD"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_OLD_EVENT_CD"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_INC_RSN_CD"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>                                                        
<comment id="_NSID_"><object id="DS_MASTER_TMP"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DETAIL_TMP"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DETAIL_TMP_D"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STR"                classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CURRENCY"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PRC_COND"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SHIPPMENT"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PAYMENT_COND"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PAYMENT_DTL_COND" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_ARRI_PORT"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_IMPORT_COUNTRY"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_AFT_ORD_FLAG"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EVENT_FLAG"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EVENT_RATE"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_OFFER_CLOSE"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_APPDT_PRICE"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PAY_CLOSE_CHK"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TAX_YN"             classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CHK_JG_FLAG"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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

<comment id="_NSID_">
    <object id="TR_APPDT_PRICE" classid=<%=Util.CLSID_TRANSACTION%>>
        <param name="KeyName" value="Toinb_dataid4">
    </object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
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
    
    var obj   = document.getElementById("GR_DETAIL1");
	var grd_height = 0;
    if((parseInt(window.document.body.clientHeight)) <= top2) {
    	grd_height = top2;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
    }
    obj.style.height  = grd_height + "px";
    
    var obj   = document.getElementById("GR_DETAIL2");
	var grd_height = 0;
    if((parseInt(window.document.body.clientHeight)) <= top2) {
    	grd_height = top2;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
    }
    obj.style.height  = grd_height + "px";
    
    var obj   = document.getElementById("GR_DETAIL3");
	var grd_height = 0;
    if((parseInt(window.document.body.clientHeight)) <= top2) {
    	grd_height = top2;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
    }
    obj.style.height  = grd_height + "px";
    
    var obj   = document.getElementById("GR_DETAIL4");
	var grd_height = 0;
    if((parseInt(window.document.body.clientHeight)) <= top2) {
    	grd_height = top2;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
    }
    obj.style.height  = grd_height + "px";
    
    var obj   = document.getElementById("GR_DETAIL5");
	var grd_height = 0;
    if((parseInt(window.document.body.clientHeight)) <= top2) {
    	grd_height = top2;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
    }
    obj.style.height  = grd_height + "px";
    
    
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
                        <th class="point">전표구분</th>
                        <td colspan="5">                            
                            <input type="checkbox" id=CHK_1 onclick="javascript:searchCheckSlipFlag(CHK_1);">전체
                            <input type="checkbox" id=CHK_2 onclick="javascript:searchCheckSlipFlag(CHK_2);">매입
                            <input type="checkbox" id=CHK_3 onclick="javascript:searchCheckSlipFlag(CHK_3);">반품
                            <input type="checkbox" id=CHK_4 onclick="javascript:searchCheckSlipFlag(CHK_4);">대출입
                            <input type="checkbox" id=CHK_5 onclick="javascript:searchCheckSlipFlag(CHK_5);">점출입
                            <input type="checkbox" id=CHK_6 onclick="javascript:searchCheckSlipFlag(CHK_6);">매가인상하            
                        </td> 
                        <th>전표번호</th>
                        <td>
                          <comment id="_NSID_"> 
                              <object id=EM_S_SLIP_NO classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1 align="absmiddle"> </object> 
                          </comment><script> _ws_(_NSID_);</script>
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
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                    <tr>
                    <td>
                          <comment id="_NSID_"> 
                              <OBJECT id=GR_LIST width=450 height=720 classid=<%=Util.CLSID_GRID%>>
                                 <param name="DataID" value="DS_O_LIST">
                                 <Param Name="ViewSummary"   value="1" >
                              </OBJECT> 
                          </comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                </table>
                </td>
                <td class="PL10">
                 <div id=TAB_MAIN  width="100%" height=735 TitleWidth=90 TitleAlign="center" MenuDisplay=false>
                     <menu TitleName="단품매입"        DivId="tab_page1" Enable='false' />
                     <menu TitleName="대출입"          DivId="tab_page2" Enable='false' />
                     <menu TitleName="점출입"          DivId="tab_page3" Enable='false' />
                     <menu TitleName="매가인상하"      DivId="tab_page4" Enable='false' />
                     <menu TitleName="수입"            DivId="tab_page5" Enable='false' />
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
                                        <object id=EM_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=193 tabindex=1 align="absmiddle"> </object> 
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
                                        <object id=EM_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=193 tabindex=1 align="absmiddle"> </object> 
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
                                        <object id=EM_CHK_DT classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_EM_CHK_DT
                                    onclick="javascript:openCal('G',EM_CHK_DT)"
                                    align="absmiddle" /></td>
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
                                <th>부가세계</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TOT_TAX classid=<%=Util.CLSID_EMEDIT%> width=101 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>비고</th>
                                <td colspan="3">
                                    <comment id="_NSID_"> 
                                        <object id=EM_REMARK classid=<%=Util.CLSID_EMEDIT%> width=315 tabindex=1 align="absmiddle"> </object> 
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
                                              <OBJECT id=GR_DETAIL width=100% height=490  classid=<%=Util.CLSID_GRID%>>
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
                        <td >
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
                                        <object id=EM_CHK_DT1 classid=<%=Util.CLSID_EMEDIT%> width=75 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                     <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_EM_CHK_DT1
                                    onclick="javascript:openCal('G',EM_CHK_DT1)"
                                    align="absmiddle" /></td>
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
                                              <OBJECT id=GR_DETAIL1 width=100% height=450 classid=<%=Util.CLSID_GRID%>>
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
                                              <OBJECT id=GR_DETAIL2 width=100% height=450 classid=<%=Util.CLSID_GRID%>>
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
                                        <object id=EM_CHK_DT3 classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                     <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_EM_CHK_DT3
                                    onclick="javascript:openCal('G',EM_CHK_DT3)"
                                    align="absmiddle" /></td>
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
                                              <OBJECT id=GR_DETAIL3 width=100% height=450 classid=<%=Util.CLSID_GRID%>>
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
                                        <object id=EM_CHK_DT4 classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_EM_CHK_DT4
                                    onclick="javascript:openCal('G',EM_CHK_DT4)"
                                    align="absmiddle" /></td>
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
                                              <OBJECT id=GR_DETAIL4 width=100% height=450  classid=<%=Util.CLSID_GRID%>>
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
			                  <th width="70">점</th>
			                  <td width="95">
			                         <comment id="_NSID_">
			                            <object id=LC_I_STR_CD5 classid=<%= Util.CLSID_LUXECOMBO %> width=90 align="absmiddle" tabindex=1>
			                            </object>
			                        </comment><script>_ws_(_NSID_);</script>
			                  </td>
			                  <th width="70">전표번호</th>
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
			                            <object id=EM_O_PUMBUN_NM5 classid=<%=Util.CLSID_EMEDIT%>  width=193 tabindex=1 align="absmiddle">
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
			                            <object id=EM_O_VEN_NM5 classid=<%=Util.CLSID_EMEDIT%>  width=193 tabindex=1 align="absmiddle">
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
			                            <object id=EM_CHK_DT5 classid=<%=Util.CLSID_EMEDIT%> width=75 tabindex=1 align="absmiddle">
			                            </object>
			                      </comment><script> _ws_(_NSID_);</script>
			                       <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_EM_CHK_DT5
			                                    onclick="javascript:openCal('G',EM_CHK_DT5)"
			                                    align="absmiddle" /></td>
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
			                   <th>부가세계</th>
			                    <td><comment id="_NSID_"> 
			                       <object id=EM_TOT_TAX5 classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle"> </object> 
			                     </comment><script> _ws_(_NSID_);</script>
			                    </td>
			                   <th>비고</th>
			                      <td colspan="3">
			                        <comment id="_NSID_"> 
			                          <object id=EM_I_REMARK5 classid=<%=Util.CLSID_EMEDIT%> width=305 tabindex=1 align="absmiddle"> </object> 
			                        </comment><script> _ws_(_NSID_);</script>
			                      </td>
			                 </tr>
 <!---->
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
                                    <OBJECT id=GR_DETAIL5 width=100% height=450 classid=<%=Util.CLSID_GRID%>>
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
            <c>Col=ORD_CF_DT           Ctrl=EM_CONF_DT            param=Text</c>
            <c>Col=DELI_DT             Ctrl=EM_DELI_DT            param=Text</c>
            <c>Col=NEW_PRC_APP_DT      Ctrl=EM_PRC_APP_DT         param=Text</c>
            <c>Col=CHK_DT              Ctrl=EM_CHK_DT             param=Text</c>
            <c>Col=GAP_TOT_AMT         Ctrl=EM_GAP_TOT_AMT        param=Text</c>
            <c>Col=NEW_GAP_RATE        Ctrl=EM_GAP_RATE           param=Text</c>
            <c>Col=ORD_TOT_QTY         Ctrl=EM_TOT_QTY            param=Text</c>
            <c>Col=NEW_COST_TAMT       Ctrl=EM_TOT_COST_AMT       param=Text</c>
            <c>Col=NEW_SALE_TAMT       Ctrl=EM_TOT_SALE_AMT       param=Text</c>
            <c>Col=VAT_TAMT            Ctrl=EM_TOT_TAX            param=Text</c>
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
            <c>Col=P_VEN_CD              Ctrl=EM_P_VEN_CD3          param=Text</c>
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
            <c>Col=GAP_SALE_TAMT       Ctrl=EM_GAP_TOT_AMT4        param=Text</c>
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
	    <param name=BindInfo        value='
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
	        <c>Col=NEW_COST_TAMT        Ctrl=EM_I_INVOICE_AMT5           param=Text</c> 
	        <c>Col=PRC_APP_DT           Ctrl=EM_I_PRC_APP_DT5            param=Text</c>   
	        <c>Col=DELI_DT              Ctrl=EM_I_DELI_DT5               param=Text</c>   
	        <c>Col=CHK_DT               Ctrl=EM_CHK_DT5                  param=Text</c>   
	        <c>Col=ORD_TOT_QTY          Ctrl=EM_I_INVOICE_TOT_QTY5       param=Text</c>   
	        <c>Col=EXC_TAMT             Ctrl=EM_I_INVOICE_TOT_AMT5       param=Text</c> 
	        <c>Col=NEW_SALE_TAMT        Ctrl=EM_I_SALE_TOT_AMT5          param=Text</c>     
	        <c>Col=REMARK               Ctrl=EM_I_REMARK5                param=Text</c>     
	        <c>Col=NEW_GAP_RATE         Ctrl=EM_TOT_GAP_RATE5            param=Text</c>     
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

<body>
</html>

