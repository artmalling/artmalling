<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품지급정산 > 세금계산서조회/수정/삭제
 * 작 성 일 : 2011.05.03
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : mcae6050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 전자세금계산서 수정/삭제
 * 이    력 : 2011.06.13 김유완 수정개발
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
<!--
var rtnVal            = false;
var intSearchCnt      = 0;                             // 조회버튼클릭 여부(0일 경우 마스터조회 건수)
var bfListRowPosition = 0;                             // 이전 List Row Position
var strToday          = "";
var roundFlag         = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-05-03
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

 function doInit(){

     strToday = getTodayDB("DS_O_RESULT");
     
     // Input Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
     DS_O_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>');
     // Output Data Set Header 초기화
     

     //그리드 초기화
     gridCreate1(); //마스터
     gridCreate2(); //디테일
     
     // EMedit에 초기화
     initEmEdit(EM_S_YYYYMM,           "THISMN",      PK);             // 매입년월
     initEmEdit(EM_S_SALE_S_DT,        "YYYYMMDD",    READ);           // 매입기간 시작일
     initEmEdit(EM_S_SALE_E_DT,        "YYYYMMDD",    READ);           // 매입기간 종료일
                                       
     initEmEdit(EM_S_TAX_S_DT,         "YYYYMMDD",    NORMAL);         // 발행기간 시작일
     initEmEdit(EM_S_TAX_E_DT,         "YYYYMMDD",    NORMAL);         // 발행기간 종료일
     initEmEdit(EM_S_ETAX_NO,          "GEN",         NORMAL);         // 전자세금계산서ID
     initEmEdit(EM_S_VEN_CD,           "000000",      NORMAL);         // 협력사코드
     initEmEdit(EM_S_VEN_NM,           "GEN^40",      READ);           // 협력사명
     initEmEdit(RD_S_TAX_INV_FLAG,     "GEN",         NORMAL);         // 매입매출구분          
                                       
     initEmEdit(EM_TAX_INV_FLAG_NM,    "GEN",         READ);           // 매출/매입구분
     initEmEdit(EM_PAY_YM,             "YYYYMM",      READ);           // 매입년월
     initEmEdit(EM_PAY_CYC,            "GEN",         READ);           // 지불주기
     initEmEdit(EM_PAY_CNT,            "GEN",         READ);           // 지불회차
     initEmEdit(EM_TAX_ISSUE_DT,       "YYYYMMDD",    READ);           // 세금계산서발행일자
     initEmEdit(EM_TAX_ISSUE_SEQ_NO,   "GEN^5",       READ);           // 세금계산서발행순번
     initEmEdit(EM_VEN_CD,             "000000",      READ);           // 협력사 코드
     initEmEdit(EM_VEN_NM,             "GEN^40",      READ);           // 협력사명
     initEmEdit(EM_BIZ_TYPE,           "GEN^40",      READ);           // 거래형태
     initEmEdit(EM_TAX_FLAG,           "GEN^40",      READ);           // 과세구분
     initEmEdit(EM_VEN_COMP_NO,        "#00-00-00000",READ);           // 사업자번호
     initEmEdit(EM_VEN_REP_NAME,       "GEN^40",      READ);           // 대표자명
     initEmEdit(EM_VEN_BIZ_STAT,       "GEN^40",      READ);           // 업태
     initEmEdit(EM_VEN_BIZ_CAT,        "GEN^40",      READ);           // 종목
     initEmEdit(EM_PHONE,              "GEN^13",      READ);           // 전화번호
     initEmEdit(EM_ADDR,               "GEN^120",     READ);           // 주소
     initEmEdit(EM_VEN_CHAR_EMAIL,     "GEN^40",      NORMAL);         // 담당자이메일
     initEmEdit(EM_ETAX_ISSUE_FLAG_NM, "GEN^40",      READ);           // 전자세금계산서발행구분
     initEmEdit(EM_TAX_ISSUE_FLAG_NM,    "GEN^40",    READ);           // 세금계산서구분
     initEmEdit(EM_TAX_INV_TYPE_NM,    "GEN^40",      READ);           // 세금계산서종류
     initEmEdit(EM_EDI_SEQ_NO,         "GEN^24",      READ);           // 전자세금계산서 ID
     initEmEdit(EM_RVS_ISSUE_FLAG_NM,  "GEN^40",      READ);           // 역발행구분
     initEmEdit(EM_PAY_WAY_NM,         "GEN^40",      READ);           // 지불방법
     initEmEdit(EM_CHARGE_FLAG_NM,     "GEN^40",      READ);           // 청구,영수
     
     initEmEdit(EM_SUP_AMT,            "NUMBER^13^0", READ);           // 공급가액
     initEmEdit(EM_VAT_AMT,            "NUMBER^13^0", READ);           // 세액
     initEmEdit(EM_TOT_AMT,            "NUMBER^13^0", READ);           // 합계액
     initEmEdit(EM_REMARK,             "GEN^150"    , NORMAL);         // 비고
     initEmEdit(EM_STR_CHAR_NAME,      "GEN^40",      READ);           // 전송자
     initEmEdit(EM_STR_CHAR_EMAIL,     "GEN^40",      READ);           // 전송자메일
     
     // 콤보 초기화(조회조건)
     initComboStyle(LC_S_STR_CD,    DS_O_STR_CD,    "CODE^0^30,NAME^0^80", 1, PK);        // 점(조회)
     initComboStyle(LC_S_BIZ_TYPE,  DS_S_BIZ_TYPE,  "CODE^0^30,NAME^0^80", 1, NORMAL);    // 거래형태
     initComboStyle(LC_S_TAX_FLAG,  DS_S_TAX_FLAG,  "CODE^0^30,NAME^0^80", 1, NORMAL);    // 과세구분

     initComboStyle(LC_S_PAY_CYC,   DS_O_PAY_CYC,   "CODE^0^30,NAME^0^80", 1, PK);        // 지불주기
     initComboStyle(LC_S_PAY_CNT,   DS_O_PAY_CNT,   "CODE^0^30,NAME^0^80", 1, PK);        // 지불회차
     initComboStyle(LC_S_ETAX_STAT, DS_S_ETAX_STAT, "CODE^0^30,NAME^0^80", 1, NORMAL);    // 상태
     
     // 콤보 초기화(입력)
     initComboStyle(LC_VEN_CHAR_NAME,DS_O_CHAR_NAME,    "CODE^0^0,NAME^0^80",  1, NORMAL);    // 담당자명
    
     getStore("DS_O_STR_CD", "Y", "1", "N"); 
     getEtcCode("DS_S_BIZ_TYPE",     "D", "P003", "Y");            // 거래형태(조회)
     getEtcCode("DS_S_TAX_FLAG",     "D", "P004", "Y");            // 과세구분(조회)
     getEtcCode("DS_S_ETAX_STAT",    "D", "P401", "Y");            // 세금계산서상태(조회)
     
     getEtcCode("DS_O_BIZ_TYPE",     "D", "P003", "N");            // 거래형태
     getEtcCode("DS_O_TAX_FLAG",     "D", "P004", "N");            // 과세구분
     getEtcCode("DS_O_TAX_INV_TYPE", "D", "P404", "N");            // 세금계산서종류
     getEtcCode("DS_O_CHARGE_FLAG",  "D", "P405", "N");            // 청구/영수
     
     getEtcCode("DS_O_PAY_CYC",   "D", "P052", "N");            // 조회지불주기
     getEtcCode("DS_O_PAY_CNT",   "D", "P407", "N");            // 조회지불회차
     getEtcCode("DS_O_SLIP_FLAG", "D", "P201", "Y");            // 전표구분
          
     getCharName(EM_VEN_CD.Text);                                  // 담당자명콤보데이터
     
     LC_S_STR_CD.index    = 0;
     LC_S_BIZ_TYPE.index  = 0;
     LC_S_TAX_FLAG.index  = 0;
     LC_S_PAY_CYC.index   = 0;
     LC_S_PAY_CNT.index   = 0;
     LC_S_ETAX_STAT.index = 0;
     LC_S_STR_CD.Focus(); 

     getSaleDate("DS_O_SALE_DATE", EM_S_YYYYMM.Text, LC_S_PAY_CYC.BindColVal, LC_S_PAY_CNT.BindColVal);
     EM_S_SALE_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
     EM_S_SALE_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
     setMasterObject(false, false);
 }

 function gridCreate1(){
     var hdrProperies = '<FC>id=SEL               name="선택"               width=50    align=center HeadCheckShow=true EditStyle=CheckBox</FC>'
                      + '<FC>id={currow}          name="NO"                 width=30    align=center</FC>'
                      + '<FC>id=TAX_INV_FLAG      name="매입/매출"          width=60     Edit=none align=left</FC>'
                      + '<FC>id=VEN_NM            name="협력사"             width=80     Edit=none align=left</FC>'
                      + '<FC>id=BIZ_TYPE          name="거래형태"           width=80     Edit=none align=left</FC>'
                      + '<FC>id=TAX_FLAG          name="과세구분"           width=70     Edit=none align=left</FC>'
                      + '<FC>id=PAY_CYC           name="지불주기"           width=60     Edit=none align=left</FC>'
                      + '<FC>id=PAY_CNT           name="지불회차"           width=70     Edit=none align=left</FC>'
                      + '<FC>id=TAX_ISSUE_DT      name="발행일자"           width=80     Edit=none Mask="XXXX/XX/XX" align=center</FC>'
                      + '<FC>id=TAX_ISSUE_SEQ_NO  name="순번"               width=50     Edit=none align=center</FC>'
                      + '<FC>id=ETAX_STAT_NM      name="상태"               width=100     Edit=none align=left</FC>'
                      + '<FC>id=EDI_SEQ_NO        name="전자세금계산서 ID"   width=180    Edit=none align=center</FC>';
                      
     initGridStyle(GR_LIST, "common", hdrProperies, true);
 }

 function gridCreate2(){
     var hdrProperies = '<FC>id={currow}          name="NO"            width=30    Edit=none align=center</FC>'
                      + '<FC>id=TAX_ITEM_DT       name="일자"          width=80    Edit=Numeric Mask="XXXX/XX/XX" align=left</FC>'
                      + '<FC>id=TAX_ITEM_NM       name="품목"          width=100   align=left</FC>'
                      + '<FC>id=TAX_ITEM_SPEC     name="규격"          width=50    align=left</FC>'
                      + '<FC>id=TAX_ITEM_QTY      name="수량"          width=40    Edit=none align=right</FC>'
                      + '<FC>id=TAX_ITEM_UNIT_AMT name="단가"          width=70    Edit=none align=right</FC>'
                      + '<FC>id=TAX_ITEM_SUP_AMT  name="공급가"        width=80    Edit=none align=right</FC>'
                      + '<FC>id=TAX_ITEM_VAT_AMT  name="세액"          width=80    Edit=Numeric align=right</FC>'
                      + '<FC>id=TAX_ITEM_REMARK   name="비고"          width=100   Edit=none align=left</FC>';
         
     initGridStyle(GR_MASTER, "common", hdrProperies, true);
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
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-05-03
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 if(checkValidation("Search")){
		 DS_IO_MASTER.ClearData();  
	     intSearchCnt = 0;
	     bfListRowPosition = 0;
	     getList();
	     // 조회결과 Return
	     setPorcCount("SELECT", GR_LIST);
	 }
}

/**
 * btn_New()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-05-03
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
      // 전표마스터 추가후 행추가, 삭제 버튼 활성화 (저장되지 않은 내용이 있을경우 추가되지 않음)
    if(DS_IO_MASTER.IsUpdated){
          if(showMessage(QUESTION, YESNO, "USER-1072") != 1 ){
              setMasterObject(true, true);
              return;
          }else{
              DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
          }
    }else{
        DS_O_LIST.Addrow(); 
    }
    
    DS_IO_MASTER.ClearData(); 
    DS_IO_MASTER.Addrow(); 

    var idx;
    if(DS_IO_MASTER.CountRow > 0){
         var strEdiSeqNo = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "EDI_SEQ_NO");
         if(strEdiSeqNo.length == 0){
             EM_BIZ_TYPE.Index     = 0;
             EM_TAX_FLAG.Index     = 0;
             LC_CHAR_NAME          = 0;
//             LC_TAX_INV_TYPE.Index = 0;
//             LC_CHARGE_FLAG.Index  = 0;
             EM_TAX_ISSUE_DT.Text  = strToday;  
         }
     }
    setMasterObject(true, true);
//    LC_STR.Focus();
}

/**
 * btn_Delete()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-05-03
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
	// 삭제할 데이터 없는 경우
	if (!DS_O_LIST.IsUpdated){
	       //저장할 내용이 없습니다
	       showMessage(EXCLAMATION, OK, "USER-1019");
	       return;
	 }
	
    if(!checkValidation("Delete"))
         return;
    
    // 삭제 메세지 
    if(showMessage(Question, YESNO, "USER-1023") == 1){  
    
    	//sel_DeleteRow(DS_O_LIST, "SEL");
    	
    	// 기존데이터일 경우 삭제 Action실행 
        var params = "&strFlag=delete" ;
        
       
        TR_MAIN.Action="/mss/mcae605.mc?goTo=delete&strFlag=delete"; 
        TR_MAIN.KeyValue="SERVLET(I:DS_O_LIST=DS_O_LIST)"; //조회는 O
        TR_MAIN.Post();
        
        btn_Search();
    }
}

/**
 * btn_Save()
 * 작 성 자     : 김경은
 * 작 성 일     : 2011-05-05
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
function btn_Save() {
     
     
    // 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated){
       //저장할 내용이 없습니다
       showMessage(EXCLAMATION, OK, "USER-1028");
       return;
    }

    if(!checkValidation("Save"))
      return;

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") == 1 ){    // validation 체크
        TR_MAIN.Action="/mss/mcae605.mc?goTo=save&strFlag=save"; 
        TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
        TR_MAIN.Post();

        btn_Search();
    }  
    
}


/**
 * btn_Excel()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-05-03
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-05-03
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-04-25
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * setMasterObject(flag, updateFlag)
  * 작 성 자     : 김경은
  * 작 성 일     : 2011-05-03
  * 개    요        : 마스터 Object의 활성화/비활성화를 제어한다.
  * return값 : void
  */
 function setMasterObject(flag, updateFlag){
//     GR_MASTER.Editable                 = flag;
     enableControl(EM_BIZ_TYPE          , flag);
     enableControl(EM_TAX_FLAG          , flag);
     enableControl(EM_VEN_CD            , flag);
     enableControl(EM_TAX_ISSUE_DT      , flag);
     
     enableControl(LC_VEN_CHAR_NAME     , updateFlag);
     enableControl(EM_VEN_CHAR_EMAIL    , updateFlag);
     enableControl(EM_REMARK            , updateFlag);
 }  
 
  /**
  * getList()
  * 작 성 자 : 김경은
  * 작 성 일 : 2011-05-03
  * 개    요 :  리스트  조회
  * return값 : void
  */
  function getList(){

     // 조회조건 셋팅
     var strStrCd      = LC_S_STR_CD.BindColVal;                    // 점
     var strPayYm      = EM_S_YYYYMM.Text;                          // 매입년월
     var strPayCyc     = LC_S_PAY_CYC.BindColVal;                   // 지불주기
     var strPayCnt     = LC_S_PAY_CNT.BindColVal;                   // 지불회차
     var strTaxSdt     = EM_S_TAX_S_DT.Text;                        // 발행기간시작
     var strTaxEdt     = EM_S_TAX_E_DT.Text;                        // 발행기간종료       
     var strBizType    = LC_S_BIZ_TYPE.BindColVal;                  // 거래형태
     var strTaxFlag    = LC_S_TAX_FLAG.BindColVal;                  // 과세구분
     var strEdiSeaNo   = EM_S_ETAX_NO.Text;                         // 전자세금계산서ID   
     var strVenCd      = EM_S_VEN_CD.Text;                          // 협력사         
     var strTaxInvFlag = RD_S_TAX_INV_FLAG.CodeValue;               // 매입매출구분
     var strEtaxStat   = LC_S_ETAX_STAT.BindColVal;                 // 상태

     var goTo       = "getList" ;    
     var action     = "O";     
     var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
                    + "&strPayYm="     + encodeURIComponent(strPayYm)
                    + "&strPayCyc="    + encodeURIComponent(strPayCyc)
                    + "&strPayCnt="    + encodeURIComponent(strPayCnt)
                    + "&strTaxSdt="    + encodeURIComponent(strTaxSdt)
                    + "&strTaxEdt="    + encodeURIComponent(strTaxEdt)
                    + "&strBizType="   + encodeURIComponent(strBizType)
                    + "&strTaxFlag="   + encodeURIComponent(strTaxFlag)
                    + "&strEdiSeaNo="  + encodeURIComponent(strEdiSeaNo) 
                    + "&strVenCd="     + encodeURIComponent(strVenCd)
                    + "&strTaxInvFlag="+ encodeURIComponent(strTaxInvFlag)
                    + "&strEtaxStat="  + encodeURIComponent(strEtaxStat); 
     
     TR_MAIN.Action  = "/mss/mcae605.mc?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_LIST=DS_O_LIST)"; //조회는 O
     TR_MAIN.Post();
     
     // 협력사별 반올림 구분을 받는다
//     roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, LC_STR.BindColVal, DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "VEN_CD"));
  }
  
 /**
 * getMaster()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-05-03
 * 개    요 :  마스터  조회
 * return값 : void
 */
 function getMaster(){
    var strVenCd = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "VEN_CD");
      getCharName(strVenCd);                      // 담당자명콤보데이터

    // 조회조건 셋팅
    var strStrCd      = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "STR_CD");               // 점
    var strIssueDt    = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "TAX_ISSUE_DT");         // 세금계산서발행일자
    var strIssueSeqNo = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "TAX_ISSUE_SEQ_NO");     // 세금계산서발행순번

    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
                   + "&strIssueDt="   + encodeURIComponent(strIssueDt)
                   + "&strIssueSeqNo="+ encodeURIComponent(strIssueSeqNo); 
    
    TR_S_MAIN.Action  = "/mss/mcae605.mc?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_S_MAIN.Post();
 }
 
 /**
  * getVenInfo(code, name, btnFlag)
  * 작 성 자 : 김경은
  * 작 성 일 : 2011-05-03
  * 개    요 :  브랜드에 따른 협력사 팝업
  * return값 : void
  */
 function getVenInfo(code, name, btnFlag){
     var strStrCd        = LC_S_STR_CD.BindColVal;  
     var strUseYn        = "Y";                             // 사용여부
     var strPumBunType   = "0";                             // 브랜드유형
     var strBizType      = "";                              // 거래형태
     var strMcMiGbn      = "";                              // 매출처/매입처구분
     var strBizFlag      = "";                              // 거래구분
    
     if(!btnFlag){
         var rtnMap = setVenNmWithoutPop( "DS_O_RESULT", code, name, "1"
                 ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                 ,strBizFlag);
     }else{
         var rtnMap = venPop(code, name
                            ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                            ,strBizFlag);
     }
     
     if(rtnMap != null){
         getCharName(EM_VEN_CD.Text);                                  // 담당자명콤보데이터
         getStrVenInfo();                                              // 점별협력사 정보
     }
         
 }
   
 /**
  * checkValidation()
  * 작 성 자     : 김경은
  * 작 성 일     : 2011-05-03
  * 개    요        :  값 체크 
  * return값 : void
  */
 function checkValidation(Gubun) {
 
      //조회버튼 클릭시 Validation Check
      if(Gubun == "Search"){   
         if(EM_S_YYYYMM.Text.length == 0){
              showMessage(INFORMATION, OK, "USER-1002", "매입년월");
              EM_S_YYYYMM.Focus();
              return false;
          }
         if(EM_S_TAX_S_DT.Text.length == 0 && EM_S_TAX_E_DT.Text.length > 0){      // 조회일 정합성
             showMessage(INFORMATION, OK, "USER-1002", "조회시작일");
             EM_S_TAX_S_DT.Focus();
             return false;
         }
         
         if(EM_S_TAX_S_DT.Text.length > 0 && EM_S_TAX_E_DT.Text.length == 0){      // 조회일 정합성
             showMessage(INFORMATION, OK, "USER-1002", "조회종료일");
             EM_S_TAX_E_DT.Focus();
             return false;
         }
         
         if(EM_S_TAX_S_DT.Text > EM_S_TAX_E_DT.Text){                              // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1015");
             EM_S_TAX_S_DT.Focus();
             return false;
        }
          return true;
      }
      
      // 저장버튼 클릭시 Validation Check
      if(Gubun == "Save"){
    	  /*  if(LC_VEN_CHAR_NAME.BindColVal == "" ){                           // 담당자명
          showMessage(EXCLAMATION, OK, "USER-1002", "담당자명");
          LC_VEN_CHAR_NAME.Focus();
          return false;
          } 
          */
	      if(EM_VEN_CHAR_EMAIL.Text == "" ){                                    // 담당자메일
	          showMessage(EXCLAMATION, OK, "USER-1003", "담당자메일");
	          EM_VEN_CHAR_EMAIL.Focus();
	          return false;
	      } 
          
	      var strEtaxStat = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "ETAX_STAT");      
          if(strEtaxStat != "0" && strEtaxStat != "S"){
              showMessage(EXCLAMATION, OK, "USER-1130", "수정");
              return false;
          }
          return true;
      }
      
   // 저장버튼 클릭시 Validation Check
      if(Gubun == "Delete"){          
          var strEtaxStat = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "ETAX_STAT");      
          if(strEtaxStat != "0" && strEtaxStat != "S"){
              showMessage(EXCLAMATION, OK, "USER-1130", "삭제");
              return false;
          }
          return true;
      }
      
  }
 
 /**
 * getCharName(strVenCd)
 * 작 성 자     : 김경은
 * 작 성 일     : 2011-04-25
 * 개    요        : 담당자명  콤보 세팅을 위한 dataSet을 가져오는 함수 
 * return값 : void
 */

 function getCharName(strVenCd) {
     var goTo         = "getCharName" ;    
     var action       = "O";     
     var parameters   = "&strVenCd="+encodeURIComponent(strVenCd);
       
     TR_DETAIL.Action="/mss/mcae605.mc?goTo="+goTo+parameters;  
     TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_CHAR_NAME=DS_O_CHAR_NAME)"; //조회는 O
     TR_DETAIL.Post();
 }
 
 /**
  * getStrVenInfo()
  * 작 성 자     : 김경은
  * 작 성 일     : 2011-05-03
  * 개    요        : 점별협력사별 정보 조회
  * return값 : void
  */

  function getStrVenInfo() {
      var strStrCd     = LC_STR.BindColVal;
      var strVenCd     = EM_VEN_CD.Text;
      
      var goTo         = "getStrVenInfo" ;    
      var action       = "O";     
      var parameters   = "&strStrCd="+ encodeURIComponent(strStrCd)
                       + "&strVenCd="+ encodeURIComponent(strVenCd);
        
      TR_DETAIL.Action="/mss/mcae605.mc?goTo="+goTo+parameters;  
      TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_STRVEN_INFO=DS_O_STRVEN_INFO)"; //조회는 O
      TR_DETAIL.Post();
      
      if(DS_O_STRVEN_INFO.CountRow > 0){
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_COMP_NO")    = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "COMP_NO");   // 사업자번호
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"BIZ_TYPE")       = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "BIZ_TYPE");  // 거래형태
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_REP_NAME")   = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "REP_NAME");  // EOVYWKAUD
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_BIZ_STAT")   = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "BIZ_STAT");  // 업태
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_BIZ_CAT")    = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "BIZ_CAT");   // 종목
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PHONENUM")       = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "PHONENUM");  // 전화번호
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"ADDRESS")        = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "ADDRESS");   // 주소
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CHAR_NAME")  = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "SMEDI_CHAR_NM");   // 전송자
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CHAR_EMAIL") = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "SMEDI_EMAIL");   // 전송자
//        LC_VEN_CHAR_NAME.Index = 0;
      }
  }
 
 /**
  * clearVenInfo()
  * 작 성 자 : 김경은
  * 작 성 일 : 2011-05-03
  * 개    요 :  점별 협력사 관련 정보 Clear
  * return값 : void
  */
 function clearVenInfo(){
      //DS_O_CHAR_NAME.ClearData();
      EM_VEN_NM.Text           = "";
      EM_VEN_COMP_NO.Text      = "";
      EM_VEN_REP_NAME.Text     = "";
      EM_PHONE.Text            = "";
      EM_ADDR.Text             = "";
      EM_VEN_CHAR_EMAIL.Text   = "";
      EM_VEN_BIZ_STAT.Text     = "";
      EM_VEN_BIZ_CAT.Text      = "";
      EM_STR_CHAR_NAME.Text    = "";
      EM_STR_CHAR_EMAIL.Text   = "";
      EM_BIZ_TYPE.Index        = 0;
      EM_TAX_FLAG.Index        = 0;
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
<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_S_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
    switch (colid) {
    case "VEN_CD":
        break;
    case "VEN_CHAR_NAME":
        var idx = DS_O_CHAR_NAME.ValueRow(1,this.NameValue(row,"VEN_CHAR_NAME"));
        if(idx != "0")
             this.NameValue(row,"VEN_CHAR_EMAIL") = DS_O_CHAR_NAME.NameValue(idx,"EMAIL");
        break;
    case "TAX_ITEM_VAT_AMT":
        this.NameValue(row,"TAX_ITEM_TOT_AMT") = this.NameValue(row,"TAX_ITEM_SUP_AMT")
                                                   + this.NameValue(row,"TAX_ITEM_VAT_AMT");
        EM_VAT_AMT.Text = this.NameValue(row,"TAX_ITEM_VAT_AMT");
        EM_TOT_AMT.Text = this.NameValue(row,"TAX_ITEM_TOT_AMT");
        break;

    }

</script>

<script language=JavaScript for=DS_O_LIST event=CanRowPosChange(row)>
    if (DS_IO_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            return false;
        }else {
            if(DS_O_LIST.RowStatus(row) == 1)   // 신규일경우
                DS_O_LIST.DeleteRow(row);
            
            return true;
        }
    }else{
        return true;
    }
</script>
<script language=JavaScript for=DS_O_LIST event=onRowPosChanged(row)>
	if(clickSORT)
	    return;
	    
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        if(DS_O_LIST.RowStatus(row) != 1)   // 신규일경우
             getMaster();
        
        var strETaxStat = this.NameValue(row, "ETAX_STAT");
        if(strETaxStat == "0" || strETaxStat == "S")
            setMasterObject(false, true);
        else
            setMasterObject(false, false);
        
        if(intSearchCnt == 0){
            intSearchCnt++;
        }else{
            setPorcCount("SELECT", DS_IO_MASTER.CountRow);
        }

    }

</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GR_LIST event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- GR_MASTER OnPopup event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnPopup(row,colid,data)>
    openCal(GR_MASTER,row,colid);
</script>

<!-- 그리드 CHECK BOX 전체 선택 -->
<script language="javascript"  for=GR_LIST event=OnHeadCheckClick(Col,Colid,bCheck)>

    //헤더 전체 체크/체크해제 컨트롤
    var dataSet = eval(this.DataID);
    for( var i=1 ; i<=dataSet.CountRow; i++){
        dataSet.NameValue(i,Colid) = bCheck=='0'?'F':'T';
    }
</script>
<!-- GR_MASTER 데이터변경  -->
<script language=JavaScript for=GR_MASTER event=CanColumnPosChange(row,colid)>
    if(row < 1)
        return true;
    switch(colid){
    case "TAX_ITEM_DT":
        if(DS_IO_MASTER.NameValue(row, "TAX_ITEM_DT") == "")
            return true;
        if(!checkDateTypeYMD(this,colid,''))
            return false;
        break;
    }
</script>

<!-- 점(입력)  변경시  -->
<script language=JavaScript for=LC_STR event=OnSelChange()>
    EM_VEN_CD.Text = "";
    clearVenInfo();
</script>

<!-- 협력사 KillFocus -->
<script language=JavaScript for=EM_VEN_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return
        
    clearVenInfo();
    if(EM_VEN_CD.Text != "")
        getVenInfo(EM_VEN_CD, EM_VEN_NM, false);
    else
        EM_VEN_NM.Text = "";

    getCharName(EM_VEN_CD.Text);                                  // 담당자명콤보데이터
    getStrVenInfo();                                              // 점별협력사 정보

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

<!-- 기준년월 KillFocus -->
<script language=JavaScript for=EM_S_YYYYMM event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    checkDateTypeYM(EM_S_YYYYMM);
    EM_S_SALE_S_DT.Text = "";
    EM_S_SALE_E_DT.Text = "";
    getSaleDate("DS_O_SALE_DATE", EM_S_YYYYMM.Text, LC_S_PAY_CYC.BindColVal, LC_S_PAY_CNT.BindColVal);
    EM_S_SALE_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
    EM_S_SALE_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");

</script>

<!-- 지불주기 변경시  -->
<script language=JavaScript for=LC_S_PAY_CYC event=OnSelChange()>
    EM_S_SALE_S_DT.Text = "";
    EM_S_SALE_E_DT.Text = "";
    
    DS_O_PAY_CNT.ClearData();
    if(LC_S_PAY_CYC.BindColVal == "1")
        getEtcCode("DS_O_PAY_CNT", "D", "P407", "N");         // 지불회차
    else if(LC_S_PAY_CYC.BindColVal == "2")
        getEtcCode("DS_O_PAY_CNT", "D", "P408", "N");         // 지불회차
    else if(LC_S_PAY_CYC.BindColVal == "3")
        getEtcCode("DS_O_PAY_CNT", "D", "P409", "N");         // 지불회차
        
    LC_S_PAY_CNT.index = 0;
           
</script>

<!-- 지불회차 변경시  -->
<script language=JavaScript for=LC_S_PAY_CNT event=OnSelChange()>
    EM_S_SALE_S_DT.Text = "";
    EM_S_SALE_E_DT.Text = "";

    getSaleDate("DS_O_SALE_DATE", EM_S_YYYYMM.Text, LC_S_PAY_CYC.BindColVal, LC_S_PAY_CNT.BindColVal);
    EM_S_SALE_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
    EM_S_SALE_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
    
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

<comment id="_NSID_"><object id="DS_O_STR_CD"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_S_BIZ_TYPE"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_S_TAX_FLAG"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_BIZ_TYPE"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TAX_FLAG"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TAX_INV_TYPE" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CHARGE_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CHAR_NAME"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STRVEN_INFO"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_S_ETAX_STAT"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_SALE_DATE"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ISSUE_DATE"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_LIST"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CYC"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CNT"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<table width="100%" border="0" cellspacing="0" cellpadding="0">

	<!--공통 타이틀/버튼 -->
	<%@ include file="/jsp/common/titleButton.jsp"%>
	<!--공통 타이틀/버튼 // -->

	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">

					<tr>
						<th width="65" class="point">점</th>
						<td width="110"><comment id="_NSID_"> <object
							id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=108
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80" class="point">매입/매출년월</th>
						<td width="105"><comment id="_NSID_"> <object
							id=EM_S_YYYYMM classid=<%=Util.CLSID_EMEDIT%> width=75 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('M',EM_S_YYYYMM)" align="absmiddle" />
						</td>
						<th width="95" class="point">지불주기</th>
						<td width="110"><comment id="_NSID_"> <object
							id=LC_S_PAY_CYC classid=<%= Util.CLSID_LUXECOMBO %> width=100
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="70" class="point">지불회차</th>
						<td><comment id="_NSID_"> <object id=LC_S_PAY_CNT
							classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>

					<tr>
						<th>거래형태</th>
						<td><comment id="_NSID_"> <object id=LC_S_BIZ_TYPE
							classid=<%= Util.CLSID_LUXECOMBO %> width=108 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>과세구분</th>
						<td><comment id="_NSID_"> <object id=LC_S_TAX_FLAG
							classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>매입기간</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_S_SALE_S_DT classid=<%=Util.CLSID_EMEDIT%> width=90
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						~ <comment id="_NSID_"> <object id=EM_S_SALE_E_DT
							classid=<%=Util.CLSID_EMEDIT%> width=91 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>

					<tr>
						<th>발행기간</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_S_TAX_S_DT classid=<%=Util.CLSID_EMEDIT%> width=119
							tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_TAX_S_DT"
							onclick="javascript:openCal('G',EM_S_TAX_S_DT)" align="absmiddle" />
						~ <comment id="_NSID_"> <object id=EM_S_TAX_E_DT
							classid=<%=Util.CLSID_EMEDIT%> width=119 tabindex=1
							align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" id="IMG_TAX_E_DT"
							onclick="javascript:openCal('G',EM_S_TAX_E_DT)" align="absmiddle" />
						</td>
						<th>전자세금계산서ID</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_S_ETAX_NO classid=<%=Util.CLSID_EMEDIT%> width=195
							tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
						</td>
					</tr>

					<tr>
						<th>협력사</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=88 tabindex=1
							align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VEN"
							class="PR03" align="absmiddle"
							onclick="javascript:getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM, true);" />
						<comment id="_NSID_"> <object id=EM_S_VEN_NM
							classid=<%=Util.CLSID_EMEDIT%> width=182 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>상태</th>
						<td><comment id="_NSID_"> <object id=LC_S_ETAX_STAT
							classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>매입/매출</th>
						<td><comment id="_NSID_"> <object
							id=RD_S_TAX_INV_FLAG classid=<%=Util.CLSID_RADIO%>
							style="height: 20; width: 100" tabindex=1>
							<param name=Cols value="2">
							<param name=Format value="1^매입,2^매출">
							<param name=CodeValue value="2">
							<param name=AutoMargin value="true">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>

					<tr>
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
				<td width="200">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"> <OBJECT id=GR_LIST
							width=100% height=428 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_O_LIST">
						</OBJECT> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
				<td class="PL10">
				<div style="width: 100%; height: 435px; overflow: auto">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="PT01 PB03">
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">

							<tr>
								<th width="90">매출/매입</th>
								<td width="103"><comment id="_NSID_"> <object
									id=EM_TAX_INV_FLAG_NM classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="80">매입매출년월</th>
								<td width="103"><comment id="_NSID_"> <object
									id=EM_PAY_YM classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="72">지불주기</th>
								<td><comment id="_NSID_"> <object id=EM_PAY_CYC
									classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>

							<tr>
								<th>발행일</th>
								<td><comment id="_NSID_"> <object
									id=EM_TAX_ISSUE_DT classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
								<th>발행순번</th>
								<td><comment id="_NSID_"> <object
									id=EM_TAX_ISSUE_SEQ_NO classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
								<th>지불회차</th>
								<td><comment id="_NSID_"> <object id=EM_PAY_CNT
									classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>

							<tr>
								<th>협력사코드</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>&nbsp;<comment
									id="_NSID_"> <object id=EM_VEN_NM
									classid=<%=Util.CLSID_EMEDIT%> width=198 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
								<th>사업자번호</th>
								<td><comment id="_NSID_"> <object
									id=EM_VEN_COMP_NO classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>

							<tr>
								<th>거래형태</th>
								<td><comment id="_NSID_"> <object id=EM_BIZ_TYPE
									classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
								<th>과세구분</th>
								<td><comment id="_NSID_"> <object id=EM_TAX_FLAG
									classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
								<th>대표자명</th>
								<td><comment id="_NSID_"> <object
									id=EM_VEN_REP_NAME classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>

							<tr>
								<th>업태</th>
								<td><comment id="_NSID_"> <object
									id=EM_VEN_BIZ_STAT classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th>종목</th>
								<td><comment id="_NSID_"> <object
									id=EM_VEN_BIZ_CAT classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th>전화번호</th>
								<td><comment id="_NSID_"> <object id=EM_PHONE
									classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>

							<tr>
								<th>주소</th>
								<td colspan="5"><comment id="_NSID_"> <object
									id=EM_ADDR classid=<%=Util.CLSID_EMEDIT%> width=500 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>

							<tr>
								<th>담당자명</th>
								<td><comment id="_NSID_"> <object
									id=LC_VEN_CHAR_NAME classid=<%=Util.CLSID_LUXECOMBO%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th>담당자메일</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_VEN_CHAR_EMAIL classid=<%=Util.CLSID_EMEDIT%> width=295
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>

							<tr>
								<th>전자세금계산서</BR>
								발행구분</th>
								<td><comment id="_NSID_"> <object
									id=EM_ETAX_ISSUE_FLAG_NM classid=<%=Util.CLSID_EMEDIT%>
									width=100 tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th>세금계산서</BR>
								구분</th>
								<td><comment id="_NSID_"> <object
									id=EM_TAX_ISSUE_FLAG_NM classid=<%=Util.CLSID_EMEDIT%>
									width=100 tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th>세금계산서 </BR>
								종류</th>
								<td><comment id="_NSID_"> <object
									id=EM_TAX_INV_TYPE_NM classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>

							<tr>
								<th>전자세금계산서 ID</th>
								<td colspan="5"><comment id="_NSID_"> <object
									id=EM_EDI_SEQ_NO classid=<%=Util.CLSID_EMEDIT%> width=196
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th>역발행구분</th>
								<td><comment id="_NSID_"> <object
									id=EM_RVS_ISSUE_FLAG_NM classid=<%=Util.CLSID_EMEDIT%>
									width=100 tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th>지불방법</th>
								<td><comment id="_NSID_"> <object
									id=EM_PAY_WAY_NM classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th>청구/영수</th>
								<td><comment id="_NSID_"> <object
									id=EM_CHARGE_FLAG_NM classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>

							<tr>
								<th>공급가액</th>
								<td><comment id="_NSID_"> <object id=EM_SUP_AMT
									classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
								<th>세액</th>
								<td><comment id="_NSID_"> <object id=EM_VAT_AMT
									classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
								<th>합계액</th>
								<td><comment id="_NSID_"> <object id=EM_TOT_AMT
									classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>

							<tr>
								<th>비고</th>
								<td colspan="5"><comment id="_NSID_"> <object
									id=EM_REMARK classid=<%=Util.CLSID_EMEDIT%> width=500
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>

							<tr>
								<th>전송자</th>
								<td><comment id="_NSID_"> <object
									id=EM_STR_CHAR_NAME classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th>전송자메일</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_STR_CHAR_EMAIL classid=<%=Util.CLSID_EMEDIT%> width=295
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
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
							<tr valign="top">
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="BD4A">
									<tr>
										<td><comment id="_NSID_"> <OBJECT id=GR_MASTER
											width=100% height=92 classid=<%=Util.CLSID_GRID%>>
											<param name="DataID" value="DS_IO_MASTER">
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
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>Col=TAX_INV_FLAG_NM      Ctrl=EM_TAX_INV_FLAG_NM      param=Text</c>
            <c>Col=PAY_YM               Ctrl=EM_PAY_YM               param=Text</c>
            <c>Col=PAY_CYC_NM           Ctrl=EM_PAY_CYC              param=Text</c>
            <c>Col=PAY_CNT_NM           Ctrl=EM_PAY_CNT              param=Text</c>
            <c>Col=TAX_ISSUE_DT         Ctrl=EM_TAX_ISSUE_DT         param=Text</c>
            <c>Col=TAX_ISSUE_SEQ_NO     Ctrl=EM_TAX_ISSUE_SEQ_NO     param=Text</c>
            <c>Col=VEN_CD               Ctrl=EM_VEN_CD               param=Text</c>
            <c>Col=VEN_NM               Ctrl=EM_VEN_NM               param=Text</c>
            <c>Col=VEN_COMP_NO          Ctrl=EM_VEN_COMP_NO          param=Text</c>
            <c>Col=BIZ_TYPE_NM          Ctrl=EM_BIZ_TYPE             param=Text</c>
            <c>Col=TAX_FLAG_NM          Ctrl=EM_TAX_FLAG             param=Text</c>
            <c>Col=VEN_REP_NAME         Ctrl=EM_VEN_REP_NAME         param=Text</c>
            <c>Col=VEN_BIZ_STAT         Ctrl=EM_VEN_BIZ_STAT         param=Text</c>
            <c>Col=VEN_BIZ_CAT          Ctrl=EM_VEN_BIZ_CAT          param=Text</c>
            <c>Col=PHONENUM             Ctrl=EM_PHONE                param=Text</c>
            <c>Col=ADDRESS              Ctrl=EM_ADDR                 param=Text</c>
            <c>Col=VEN_CHAR_NAME        Ctrl=LC_VEN_CHAR_NAME        param=BindColVal</c>
            <c>Col=VEN_CHAR_EMAIL       Ctrl=EM_VEN_CHAR_EMAIL       param=Text</c>
            <c>Col=ETAX_ISSUE_FLAG_NM   Ctrl=EM_ETAX_ISSUE_FLAG_NM   param=Text</c>
            <c>Col=TAX_ISSUE_FLAG_NM    Ctrl=EM_TAX_ISSUE_FLAG_NM    param=Text</c>
            <c>Col=TAX_INV_TYPE_NM      Ctrl=EM_TAX_INV_TYPE_NM      param=Text</c>
            <c>Col=TAX_EDI_SEQ_NO       Ctrl=EM_EDI_SEQ_NO           param=Text</c>
            <c>Col=RVS_ISSUE_FLAG_NM    Ctrl=EM_RVS_ISSUE_FLAG_NM    param=Text</c>
            <c>Col=PAY_WAY_NM           Ctrl=EM_PAY_WAY_NM           param=Text</c>
            <c>Col=CHARGE_FLAG_NM       Ctrl=EM_CHARGE_FLAG_NM       param=Text</c>
            <c>Col=TAX_INV_TYPE         Ctrl=LC_TAX_INV_TYPE         param=BindColVal</c>
            <c>Col=CHARGE_FLAG          Ctrl=LC_CHARGE_FLAG          param=BindColVal</c>
            <c>Col=EDI_SEQ_NO           Ctrl=EM_EDI_SEQ_NO           param=Text</c>
            <c>Col=SUP_AMT              Ctrl=EM_SUP_AMT              param=Text</c>
            <c>Col=VAT_AMT              Ctrl=EM_VAT_AMT              param=Text</c>
            <c>Col=TOT_AMT              Ctrl=EM_TOT_AMT              param=Text</c>
            <c>Col=REMARK               Ctrl=EM_REMARK               param=Text</c>
            <c>Col=STR_CHAR_NAME          Ctrl=EM_STR_CHAR_NAME      param=Text</c>
            <c>Col=STR_CHAR_EMAIL       Ctrl=EM_STR_CHAR_EMAIL       param=Text</c>
            
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

