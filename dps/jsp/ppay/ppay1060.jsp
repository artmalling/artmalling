<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 대금지불 > 매출 전자세금계산서 기타 발행
 * 작 성 일 : 2010.04.25
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : ppay1060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 매출 전자세금계산서 기타 발행
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

<script LANGUAGE="JavaScript"><!--

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
 * 작 성 일 : 2010-04-25
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
     initEmEdit(EM_S_TAX_S_DT,       "SYYYYMMDD",   PK);             // 발행기간 시작일
     initEmEdit(EM_S_TAX_E_DT,       "TODAY",       PK);             // 발행기간 종료일
     initEmEdit(EM_S_EDI_SEQ_NO,     "GEN^24",      NORMAL);         // 전자세금계산서ID
     initEmEdit(EM_S_VEN_CD,         "000000",      NORMAL);         // 협력사코드
     initEmEdit(EM_S_VEN_NM,         "GEN^40",      READ);           // 협력사명
     
     initEmEdit(EM_TAX_ISSUE_DT,     "YYYYMMDD",    PK);             // 세금계산서발행일자
     initEmEdit(EM_TAX_ISSUE_SEQ_NO, "GEN^5",       READ);           // 세금계산서발행순번
     initEmEdit(EM_VEN_CD,           "000000",      PK);             // 협력사 코드
     initEmEdit(EM_VEN_NM,           "GEN^40",      READ);           // 협력사명
     initEmEdit(EM_VEN_COMP_NO,      "#00-00-00000",READ);            //사업자번호
     initEmEdit(EM_VEN_REP_NAME,     "GEN^40",      READ);           // 대표자명
     initEmEdit(EM_VEN_BIZ_STAT,     "GEN^40",      READ);           // 업태
     initEmEdit(EM_VEN_BIZ_CAT,      "GEN^40",      READ);           // 종목
     initEmEdit(EM_PHONE,            "GEN^13",      READ);           // 전화번호
     initEmEdit(EM_ADDR,             "GEN^120",     READ);           // 주소
     initEmEdit(EM_VEN_CHAR_EMAIL,   "GEN^40",      PK);             // 담당자이메일
     initEmEdit(EM_EDI_SEQ_NO,       "GEN^24",      READ);           // 전자세금계산서 ID
     initEmEdit(EM_SUP_AMT,          "NUMBER^13^0", READ);           // 공급가액
     initEmEdit(EM_VAT_AMT,          "NUMBER^13^0", READ);           // 세액
     initEmEdit(EM_TOT_AMT,          "NUMBER^13^0", READ);           // 합계액
     initEmEdit(EM_REMARK,           "GEN^150"    , NORMAL);         // 비고
     initEmEdit(EM_STR_CHAR_NAME,    "GEN^40",      READ);           // 전송자
     initEmEdit(EM_STR_CHAR_EMAIL,   "GEN^40",      READ);           // 전송자메일
     
     
     
     // 콤보 초기화(조회조건)
     initComboStyle(LC_S_STR_CD,    DS_O_STR_CD,        "CODE^0^30,NAME^0^80", 1, PK);        // 점(조회)
     initComboStyle(LC_S_BIZ_TYPE,  DS_S_BIZ_TYPE,      "CODE^0^30,NAME^0^80", 1, NORMAL);    // 거래형태
     initComboStyle(LC_S_TAX_FLAG,  DS_S_TAX_FLAG,      "CODE^0^30,NAME^0^80", 1, NORMAL);    // 과세구분
     // 콤보 초기화(입력)
     initComboStyle(LC_STR,          DS_O_STR_CD,       "CODE^0^30,NAME^0^80", 1, PK);        // 점
     initComboStyle(LC_BIZ_TYPE,     DS_O_BIZ_TYPE,     "CODE^0^30,NAME^0^80", 1, PK);        // 거래형태
     initComboStyle(LC_TAX_FLAG,     DS_O_TAX_FLAG,     "CODE^0^30,NAME^0^80", 1, PK);        // 과세구분
     initComboStyle(LC_VEN_CHAR_NAME,DS_O_CHAR_NAME,    "CODE^0^0,NAME^0^80",  1, PK);        // 담당자명
     initComboStyle(LC_TAX_INV_TYPE, DS_O_TAX_INV_TYPE, "CODE^0^30,NAME^0^80", 1, READ);      // 세금계산서종류  기존
     initComboStyle(LC_CHARGE_FLAG,  DS_O_CHARGE_FLAG,  "CODE^0^30,NAME^0^80", 1, PK);        // 청구/영수
     
     getStore("DS_O_STR_CD", "Y", "", "N"); 
     getEtcCode("DS_S_BIZ_TYPE",     "D", "P003", "Y");            // 거래형태(조회)
     getEtcCode("DS_S_TAX_FLAG",     "D", "P004", "Y");            // 과세구분(조회)
     getEtcCode("DS_O_BIZ_TYPE",     "D", "P003", "N");            // 거래형태
     getEtcCode("DS_O_TAX_FLAG",     "D", "P004", "N");            // 과세구분
     getEtcCode("DS_O_TAX_INV_TYPE", "D", "P404", "N");            // 세금계산서종류
     getEtcCode("DS_O_CHARGE_FLAG",  "D", "P405", "N");            // 청구/영수

     getCharName(EM_VEN_CD.Text);                                  // 담당자명콤보데이터
     
     LC_S_STR_CD.index    = 0;
     LC_S_BIZ_TYPE.index  = 0;
     LC_S_TAX_FLAG.index  = 0;
     LC_S_STR_CD.Focus(); 
     
     setMasterObject(false, false);
 
 }

 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}          name="NO"              width=30    align=center</FC>'
                      + '<FC>id=VEN_NM            name="협력사"          width=110     Edit=none align=left</FC>'
                      + '<FC>id=TAX_ISSUE_DT      name="발행일자"         width=80    Edit=none Mask="XXXX/XX/XX" align=center</FC>'
                      + '<FC>id=TAX_ISSUE_SEQ_NO  name="발행순번"         width=60    Edit=none align=center</FC>'
                      + '<FC>id=ETAX_NO           name="전자세금계산서 ID" width=190   Edit=none align=center</FC>'
                      + '<FC>id=ETAX_STAT_NM      name="상태"             width=80    Edit=none align=left</FC>'
                      
     initGridStyle(GR_LIST, "common", hdrProperies, true);
 }

 function gridCreate2(){
     var hdrProperies = '<FC>id={currow}          name="NO"            width=30    Edit=none align=center</FC>'
                      + '<FC>id=TAX_ITEM_DT       name="*일자"         width=90    Edit=none EditStyle=Popup Mask="XXXX/XX/XX" align=center</FC>'
                      + '<FC>id=TAX_ITEM_NM       name="*품목"         width=100   align=left</FC>'
                      + '<FC>id=TAX_ITEM_SPEC     name="규격"          width=50    align=left</FC>'
                      + '<FC>id=TAX_ITEM_QTY      name="*수량"         width=40    align=right</FC>'
                      + '<FC>id=TAX_ITEM_UNIT_AMT name="*단가"         width=70    Edit=Numeric align=right</FC>'
                      + '<FC>id=TAX_ITEM_SUP_AMT  name="공급가"        width=80    Edit=none align=right</FC>'
                      + '<FC>id=TAX_ITEM_VAT_AMT  name="세액"          width=80    align=right</FC>'
                      + '<FC>id=TAX_ITEM_REMARK   name="비고"          width=100   align=left</FC>';
         
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
 * 작 성 일 : 2010-04-25
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	// 변경, 추가내역이 있을 경우
    if (DS_IO_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1073") != 1 )
           return;
    }
	
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
 * 작 성 일 : 2010-04-25
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
             LC_STR.Index          = 0;
             LC_BIZ_TYPE.Index     = 0;
             LC_TAX_FLAG.Index     = 0;
             LC_CHAR_NAME          = 0;
             LC_TAX_INV_TYPE.Index = 0;
             LC_CHARGE_FLAG.Index  = 1;
             EM_TAX_ISSUE_DT.Text  = strToday;  
         }
     }
    setMasterObject(true, true);
    LC_STR.Focus();
}

/**
 * btn_Delete()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-25
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
	 
}

/**
 * btn_Save()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-04-25
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
    if( showMessage(QUESTION, YESNO, "USER-1010") == 1 ){    
        TR_MAIN.Action="/dps/ppay106.pp?goTo=save&strFlag=save"; 
        TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
        TR_MAIN.Post();
        
        btn_Search();
    }   
}


/**
 * btn_Excel()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-25
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-25
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-25
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
  * 작 성 일     : 2010-04-25
  * 개    요        : 마스터 Object의 활성화/비활성화를 제어한다.
  * return값 : void
  */
 function setMasterObject(flag, updateFlag){
	 enableControl(LC_STR               , flag); 
     enableControl(LC_BIZ_TYPE          , flag);
     enableControl(LC_TAX_FLAG          , flag);
     enableControl(EM_VEN_CD            , flag);
     enableControl(IMG_VEN              , flag); 
     enableControl(EM_TAX_ISSUE_DT      , flag);
     enableControl(IMG_TAX_ISSUE_DT     , flag);

   	 enableControl(LC_VEN_CHAR_NAME     , updateFlag);
//     enableControl(LC_TAX_INV_TYPE      , updateFlag);
     enableControl(LC_CHARGE_FLAG       , updateFlag);
     enableControl(EM_VEN_CHAR_EMAIL    , updateFlag);
     enableControl(EM_REMARK            , updateFlag);
 }  
 
 
 /**
  * getList()
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-04-25
  * 개    요 :  리스트  조회
  * return값 : void
  */
  function getList(){

     // 조회조건 셋팅
     var strStrCd   = LC_S_STR_CD.BindColVal;                    // 점
     var strTaxSdt  = EM_S_TAX_S_DT.Text;                        // 발행기간시작
     var strTaxEdt  = EM_S_TAX_E_DT.Text;                        // 발행기간종료       
     var strBizType = LC_S_BIZ_TYPE.BindColVal;                  // 거래형태
     var strTaxFlag = LC_S_TAX_FLAG.BindColVal;                  // 과세구분
     var strEdiSeaNo= EM_S_EDI_SEQ_NO.Text;                      // 전자세금계산서ID   
     var strVenCd   = EM_S_VEN_CD.Text;                          // 협력사         

     var goTo       = "getList" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
                    + "&strTaxSdt="+encodeURIComponent(strTaxSdt)   
                    + "&strTaxEdt="+encodeURIComponent(strTaxEdt)   
                    + "&strBizType="+encodeURIComponent(strBizType)  
                    + "&strTaxFlag="+encodeURIComponent(strTaxFlag)   
                    + "&strEdiSeaNo="+encodeURIComponent(strEdiSeaNo)   
                    + "&strVenCd="+encodeURIComponent(strVenCd); 
     
     TR_MAIN.Action  = "/dps/ppay106.pp?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_LIST=DS_O_LIST)"; //조회는 O
     TR_MAIN.Post();
     
     if(DS_O_LIST.CountRow > 0){
	     // 협력사별 반올림 구분을 받는다
	     roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, LC_STR.BindColVal, DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "VEN_CD"));
     }
  }
 
 /**
 * getMaster()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-25
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
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
                   + "&strIssueDt="+encodeURIComponent(strIssueDt)   
                   + "&strIssueSeqNo="+encodeURIComponent(strIssueSeqNo); 
    
    TR_S_MAIN.Action  = "/dps/ppay106.pp?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_S_MAIN.Post();

 }
 
 /**
  * getVenInfo(code, name, btnFlag)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-04-25
  * 개    요 :  브랜드에 따른 협력사 팝업
  * return값 : void
  */
 function getVenInfo(code, name, btnFlag){
     var strStrCd        = LC_S_STR_CD.BindColVal;  
     var strUseYn        = "Y";                             // 사용여부
     var strPumBunType   = "";                              // 브랜드유형
     var strBizType      = "";                              // 거래형태
     var strMcMiGbn      = "2";                             // 매출처(2)/매입처(1)구분
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
  * 작 성 일     : 2010-04-25
  * 개    요        :  값 체크 
  * return값 : void
  */
 function checkValidation(Gubun, btnFlag) {
      
      var messageCode = "USER-1001";
      
      //조회버튼 클릭시 Validation Check
      if(Gubun == "Search"){
    	  if(EM_S_TAX_S_DT.Text == ""){
    		  showMessage(EXCLAMATION, OK, "USER-1003", "조회시작일");
    		  EM_S_TAX_S_DT.Focus();
              return false;
    	  }
    	  if(EM_S_TAX_E_DT.Text == ""){
              showMessage(EXCLAMATION, OK, "USER-1003", "조회종료일");
              EM_S_TAX_E_DT.Focus();
              return false;
          }
    	  if(EM_S_TAX_E_DT.Text < EM_S_TAX_S_DT.Text){                              // 조회일 정합성
              showMessage(EXCLAMATION, OK, "USER-1015");
              EM_S_TAX_S_DT.Focus();
              return false;
         }
          return true;
      }
      
      // 저장버튼 클릭시 Validation Check
      if(Gubun == "Save"){
    	  var strTaxIssueDt = EM_TAX_ISSUE_DT.Text; 
    	  var strPreMonth   = addDate("m", -1, strToday).replace("-","");
    	  
    	  if(strTaxIssueDt == "" ){                                    // 발행일
              showMessage(EXCLAMATION, OK, "USER-1003", "발행일");
              EM_TAX_ISSUE_DT.Focus();
              return false;
           } 
    	  
    	  if(strToday > strToday.substring(0,6)+"10" &&  strTaxIssueDt < strToday.substring(0,6)+"01"){                                    // 발행일
              showMessage(EXCLAMATION, OK, "USER-1000", "등록일이 10일 이후일 경우 당월 1일부터 입력 가능합니다.");
              EM_TAX_ISSUE_DT.Focus();
              return false;
           } 

    	  if(strToday < strToday.substring(0,6)+"10" &&  strTaxIssueDt < strPreMonth.substring(0,6)+"01"){                                    // 발행일
              showMessage(EXCLAMATION, OK, "USER-1000", "등록일이 10일 이전일 경우 전월 1일부터 입력 가능합니다.");
              EM_TAX_ISSUE_DT.Focus();
              return false;
           } 
    	  
    	  if(EM_VEN_CD.Text == "" ){                                    // 협력사
              showMessage(EXCLAMATION, OK, "USER-1003", "협력사");
              EM_VEN_CD.Focus();
              return false;
           } 
    	  
    	/*  if(LC_VEN_CHAR_NAME.BindColVal == "" ){                                    // 담당자명
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
    	  
	   	  if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "REMARK", "비고", "EM_REMARK") )  // 비고
	          return false;
	   	   
	   	  var intRowCount    = DS_IO_MASTER.CountRow;
	   	  var strItemDt      = "";
	   	  var strItemNm      = "";
	   	  var intItemQty     = 0;
	   	  var intItemUnitAmt = 0;
	   	  var intItemSupAmt  = 0;
	   	  var intItemVatAmt  = 0;
	   	  var strTaxFlag     = LC_TAX_FLAG.BindColVal;
	   	  if(intRowCount > 0){
	             for(var i=1; i <= intRowCount; i++){
	                 
	                 strItemDt      = DS_IO_MASTER.NameValue(i, "TAX_ITEM_DT");
	                 strItemNm      = DS_IO_MASTER.NameValue(i, "TAX_ITEM_NM");
	                 intItemQty     = DS_IO_MASTER.NameValue(i, "TAX_ITEM_QTY");
	                 intItemUnitAmt = DS_IO_MASTER.NameValue(i, "TAX_ITEM_UNIT_AMT");
	                 intItemSupAmt  = DS_IO_MASTER.NameValue(i, "TAX_ITEM_SUP_AMT");
	                 intItemVatAmt  = DS_IO_MASTER.NameValue(i, "TAX_ITEM_VAT_AMT");
	                 
	                 if(strItemDt.length <= 0){
	                     showMessage(EXCLAMATION, OK, "USER-1003", "일자");
	                     GR_MASTER.SetColumn("TAX_ITEM_DT");  
	                     DS_IO_MASTER.RowPosition = i;  
	                     return false;
	                 }
	                 
	                 if(strItemNm.length <= 0){
	                     showMessage(EXCLAMATION, OK, "USER-1003", "품목");
	                     GR_MASTER.SetColumn("TAX_ITEM_NM");  
	                     DS_IO_MASTER.RowPosition = i;  
	                     return false;
	                 }
	                 
	                 if(intItemQty == 0){
	                     showMessage(EXCLAMATION, OK, "USER-1003", "수량");
	                     GR_MASTER.SetColumn("TAX_ITEM_QTY");  
	                     DS_IO_MASTER.RowPosition = i;  
	                     return false;
	                 }
	
	                 if(intItemUnitAmt <= 0){
	                     showMessage(EXCLAMATION, OK, "USER-1003", "단가");
	                     GR_MASTER.SetColumn("TAX_ITEM_UNIT_AMT");  
	                     DS_IO_MASTER.RowPosition = i;  
	                     return false;
	                 }
	                 
	                 if(intItemSupAmt == 0){
	                     showMessage(EXCLAMATION, OK, "USER-1003", "공급가");
	                     GR_MASTER.SetColumn("TAX_ITEM_SUP_AMT");  
	                     DS_IO_MASTER.RowPosition = i;  
	                     return false;
	                 }
	                 
	                 // 과세일 경우 세액 필수
	                 if(strTaxFlag == "1"){
	              	   if(intItemVatAmt == 0){
	                         showMessage(EXCLAMATION, OK, "USER-1003", "세액");
	                         GR_MASTER.SetColumn("TAX_ITEM_VAT_AMT");  
	                         DS_IO_MASTER.RowPosition = i;  
	                         return false;
	                     }
	                 }
	                 
	                 if( !checkInputByte( GR_MASTER, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "TAX_ITEM_REMARK", "상품비고"))  // 비고
	                     return false;
	             }
	   	  }
          return true;
      }
      
      // 계산서 전송
      if(Gubun == "SmileTax"){
    	  if(EM_VEN_CHAR_EMAIL.Text == "" ){                                    // 담당자메일
              showMessage(EXCLAMATION, OK, "USER-1003", "담당자메일");
              EM_VEN_CHAR_EMAIL.Focus();
              return false;
          } 
    	  
          var strEtaxStat = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "ETAX_STAT");               // 점
          if(btnFlag == "1"){           // 전송
              if(strEtaxStat != "0"){
                  showMessage(EXCLAMATION, OK, "USER-1120");
                  return false;
              }
          }else if(btnFlag == "2"){     // 이메일
              if(strEtaxStat != "N" && strEtaxStat != "G" && strEtaxStat != "K"){
                  showMessage(EXCLAMATION, OK, "USER-1110");
                  return false;
              }
          }else if(btnFlag == "3"){     // 취소
              if(strEtaxStat != "N" && strEtaxStat != "G" && strEtaxStat != "O"){
                  showMessage(EXCLAMATION, OK, "USER-1216");
                  return false;
              }
          }
          return true;
      }
  }
 
 /**
 * getCharName(strVenCd)
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-04-25
 * 개    요        : 담당자명  콤보 세팅을 위한 dataSet을 가져오는 함수 
 * return값 : void
 */
 function getCharName(strVenCd) {
	 var goTo         = "getCharName" ;    
	 var action       = "O";     
	 var parameters   = "&strVenCd="+encodeURIComponent(strVenCd);
	   
	 TR_DETAIL.Action="/dps/ppay106.pp?goTo="+goTo+parameters;  
	 TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_CHAR_NAME=DS_O_CHAR_NAME)"; //조회는 O
	 TR_DETAIL.Post();
 }
 
 /**
  * getStrVenInfo()
  * 작 성 자     : 김경은
  * 작 성 일     : 2010-04-25
  * 개    요        : 점별협력사별 정보 조회
  * return값 : void
  */
  function getStrVenInfo() {
	  var strStrCd     = LC_STR.BindColVal;
	  var strVenCd     = EM_VEN_CD.Text;
   
      var goTo         = "getStrVenInfo" ;    
      var action       = "O";     
      var parameters   = "&strStrCd="+encodeURIComponent(strStrCd)
                       + "&strVenCd="+encodeURIComponent(strVenCd);
        
      TR_MAIN.Action="/dps/ppay106.pp?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_O_STRVEN_INFO=DS_O_STRVEN_INFO)"; //조회는 O
      TR_MAIN.Post();
      
      if(DS_O_STRVEN_INFO.CountRow > 0){
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_COMP_NO")    = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "COMP_NO");       // 사업자번호
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_COMP_NAME")  = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "COMP_NAME");     // 사업자번호
	   	  
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_REP_NAME")   = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "REP_NAME");      // 대표자명
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_BIZ_STAT")   = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "BIZ_STAT");      // 업태
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_BIZ_CAT")    = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "BIZ_CAT");       // 종목
	      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_ADDR")       = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "DTL_ADDR")
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_DTL_ADDR")   = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "ADDR");   
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"ADDRESS")        = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "DTL_ADDR")
	   	                                                                    + DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "ADDR");          // 주소
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CHAR_ID")    = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "SMEDI_CHAR_ID"); // 전송자
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CHAR_NAME")  = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "SMEDI_CHAR_NM"); // 전송자
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CHAR_EMAIL") = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "SMEDI_EMAIL");   // 전송자이메일
	   	  
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_COMP_NAME") = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "STR_COMP_NAME");   // 상호명
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_COMP_NO")   = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "STR_COMP_NO");     // 법인번호
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_BIZ_CAT")   = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "STR_BIZ_CAT");     // 종목
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_BIZ_STAT")  = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "STR_BIZ_STAT");    // 업태
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_REP_NAME")  = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "STR_REP_NAME");    // 대표자명
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_ADDR")      = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "STR_ADDR");        // 주소
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_DTL_ADDR")  = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "STR_DTL_ADDR");    // 상세주소
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_HP1_NO")    = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "STR_HP1_NO");      // 핸드폰1
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_HP2_NO")    = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "STR_HP2_NO");      // 핸드폰2
	   	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_HP3_NO")    = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "STR_HP3_NO");      // 핸드폰3

	   	  if(DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "BIZ_TYPE").length > 0)
	   	      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"BIZ_TYPE")       = DS_O_STRVEN_INFO.NameValue(DS_O_STRVEN_INFO.RowPosition, "BIZ_TYPE");      // 거래형태
	   	  else
	   	      LC_BIZ_TYPE.Index = 0;	
	   		  
	   	   LC_VEN_CHAR_NAME.Index = 0;
	   	
	   	  // 협력사별 반올림 구분을 받는다
	      roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, LC_STR.BindColVal, EM_VEN_CD.Text);
      }
  }
 
  /**
   * clearVenInfo()
   * 작 성 자 : 김경은
   * 작 성 일 : 2010-04-26
   * 개    요 :  점별 협력사 관련 정보 Clear
   * return값 : void
   */
  function clearVenInfo(){
       
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
       LC_BIZ_TYPE.Index        = 0;
       LC_TAX_FLAG.Index        = 0;
  }
  
  /**
   * setVatCalc(row)
   * 작 성 자 : 김경은
   * 작 성 일 : 2010-04-27
   * 개    요    : 공급가/세액을 계산한다.
   * return값 : void
   */
   function setVatCalc(row, colid){

	    if(colid == "TAX_ITEM_QTY" || colid == "TAX_ITEM_UNIT_AMT" ){
			var strTaxFlag     = LC_TAX_FLAG.BindColVal;
			var intItemQty     = DS_IO_MASTER.NameValue(row, "TAX_ITEM_QTY");
			var intItemUnitAmt = DS_IO_MASTER.NameValue(row, "TAX_ITEM_UNIT_AMT");
			//var intItemSupAmt  = DS_IO_MASTER.NameValue(row, "TAX_ITEM_SUP_AMT");
			//var intItemVatAmt  = DS_IO_MASTER.NameValue(row, "TAX_ITEM_VAT_AMT");
			
			DS_IO_MASTER.NameValue(row, "TAX_ITEM_SUP_AMT") = intItemUnitAmt * intItemQty ;
			if(strTaxFlag == "1"){
				 DS_IO_MASTER.NameValue(row, "TAX_ITEM_VAT_AMT") = getRoundDec(roundFlag, (intItemUnitAmt * intItemQty * 0.1));
			}
			DS_IO_MASTER.NameValue(row,"TAX_ITEM_TOT_AMT") = DS_IO_MASTER.NameValue(row,"TAX_ITEM_SUP_AMT")
						                                    + DS_IO_MASTER.NameValue(row,"TAX_ITEM_VAT_AMT");
			
			EM_SUP_AMT.Text = DS_IO_MASTER.NameValue(row,"TAX_ITEM_SUP_AMT");
			EM_VAT_AMT.Text = DS_IO_MASTER.NameValue(row,"TAX_ITEM_VAT_AMT");
			EM_TOT_AMT.Text = DS_IO_MASTER.NameValue(row,"TAX_ITEM_TOT_AMT");
	    }else if(colid == "TAX_ITEM_VAT_AMT"){
	    	DS_IO_MASTER.NameValue(row,"TAX_ITEM_TOT_AMT") = DS_IO_MASTER.NameValue(row,"TAX_ITEM_SUP_AMT")
                                                           + DS_IO_MASTER.NameValue(row,"TAX_ITEM_VAT_AMT");
	    	EM_SUP_AMT.Text = DS_IO_MASTER.NameValue(row,"TAX_ITEM_SUP_AMT");
            EM_VAT_AMT.Text = DS_IO_MASTER.NameValue(row,"TAX_ITEM_VAT_AMT");
            EM_TOT_AMT.Text = DS_IO_MASTER.NameValue(row,"TAX_ITEM_TOT_AMT");
	    }

   }
  
 /**
  * setSmileTax(state)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-04-27
  * 개    요    : 세금계산서 취소요청(3), EMAIL재전송(2), 전송처리(1)한다.
  * return값 : void
  */
  function setSmileTax(state){

	  var messge = "";

	  // validation Check
      if(!checkValidation("SmileTax", state))
          return;
	
	  if (DS_IO_MASTER.IsUpdated){
	       //저장할 내용이 없습니다
	       showMessage(EXCLAMATION, OK, "USER-1096");
	       return;
	  }
	  
	  if(state == "1")
		  messge = "USER-1097";
	  else if(state == "2")
		  messge = "USER-1098";
	  else
		  messge = "USER-1099";
	  
	  if( showMessage(QUESTION, YESNO, messge) == 1 ){   
		  var strStrCd         = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
		  var strTaxIssueDt    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TAX_ISSUE_DT");
		  var strTaxIssueSeqNo = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TAX_ISSUE_SEQ_NO");
		  var goTo         = "setSmileTax" ;    
	      var action       = "O";     
	      var parameters   = "&strStrCd="+encodeURIComponent(strStrCd)
	                       + "&strTaxIssueDt="+encodeURIComponent(strTaxIssueDt)
	                       + "&strTaxIssueSeqNo="+encodeURIComponent(strTaxIssueSeqNo)
	                       + "&state="+encodeURIComponent(state);
	        
	      TR_MAIN.Action="/dps/ppay106.pp?goTo="+goTo+parameters;  
	      TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
	      TR_MAIN.Post();
	      
	      btn_Search();
	      
	      var idx = DS_O_LIST.ValueRow(3,strTaxIssueSeqNo);
	      DS_O_LIST.RowPosition = idx;
	  }
  }
 
--></script>
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
    case "VEN_NM":
    	break;
    case "VEN_CHAR_NAME":
    	var idx = DS_O_CHAR_NAME.ValueRow(1,this.NameValue(row,"VEN_CHAR_NAME"));

    	if(idx != "0")
	    	this.NameValue(row,"VEN_SMEDI_ID")     = DS_O_CHAR_NAME.NameValue(idx,"SMEDI_ID");
	    	this.NameValue(row,"VEN_CHAR_EMAIL")   = DS_O_CHAR_NAME.NameValue(idx,"EMAIL");
	    	this.NameValue(row,"VEN_HP1_NO")       = DS_O_CHAR_NAME.NameValue(idx,"HP1_NO");
	    	this.NameValue(row,"VEN_HP2_NO")       = DS_O_CHAR_NAME.NameValue(idx,"HP2_NO");
	    	this.NameValue(row,"VEN_HP3_NO")       = DS_O_CHAR_NAME.NameValue(idx,"HP3_NO");
	    	DS_IO_MASTER.NameValue(row,"PHONENUM") = DS_O_CHAR_NAME.NameValue(idx,"HP1_NO")
                                                   + "-" + DS_O_CHAR_NAME.NameValue(idx,"HP2_NO")
                                                   + "-" + DS_O_CHAR_NAME.NameValue(idx,"HP3_NO");
    	break;
    case "TAX_ISSUE_DT":
        this.NameValue(row,"TAX_ITEM_DT") = this.NameValue(row,"TAX_ISSUE_DT") //EM발행일이 변하면 하단그리드 일자를 자동셋팅 20100519 RH
        break;
    case "TAX_FLAG":
        this.NameValue(row,"TAX_INV_TYPE") = this.NameValue(row,"TAX_FLAG")    //과세구분 선택시 세금계산서 종류 자동 셋팅  20100519 RH
        if(LC_TAX_FLAG.BindColVal == "2" || LC_TAX_FLAG.BindColVal == "3"){
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"TAX_ITEM_VAT_AMT") = 0;
            GR_MASTER.ColumnProp("TAX_ITEM_VAT_AMT",  "Edit")   = "none";
        }else{
            setVatCalc(DS_IO_MASTER.RowPosition,"TAX_ITEM_QTY");
            GR_MASTER.ColumnProp("TAX_ITEM_VAT_AMT",  "Edit")   = "True";
        }
        break;
    case "STR_CD":
        DS_O_CHAR_NAME.ClearData();
        break;
    default:
    	setVatCalc(row,colid);
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

<!-- 조회시작일 변경시  -->
<script lanaguage=JavaScript for=EM_S_TAX_S_DT event=OnKillFocus()>
    var strSyyyymmdd = strToday.substring(0,6) + "01";
    checkDateTypeYMD( EM_S_TAX_S_DT, strSyyyymmdd );
</script>

<!-- 조회종료일 변경시  -->
<script lanaguage=JavaScript for=EM_S_TAX_E_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_S_TAX_E_DT );
</script>

<!-- 점(입력)  변경시  -->
<script language=JavaScript for=LC_STR event=OnSelChange()>
    EM_VEN_CD.Text = "";
    clearVenInfo();
    
</script>

<!-- 발행일 KillFocus -->
<script language=JavaScript for=EM_TAX_ISSUE_DT event=onKillFocus()>    
    var strTaxIssueDt = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "TAX_ISSUE_DT");
	if(DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1)   // 신규일경우
	     checkDateTypeYMD( EM_TAX_ISSUE_DT );
	else
		 checkDateTypeYMD( EM_TAX_ISSUE_DT, strTaxIssueDt );
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
        return;
        
    if(EM_S_VEN_CD.Text != "")
        getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM, false);
    else
        EM_S_VEN_NM.Text = "";
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
<comment id="_NSID_"><object id="DS_I_SEARCH"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CHAR_NAME"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STRVEN_INFO"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_SALE_DATE"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ISSUE_DATE"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_LIST"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
<table width="100%"  border="0" cellspacing="0" cellpadding="0">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="50" class="point">점</th>
            <td width="160">
                    <comment id="_NSID_">
                        <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=150 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">발행기간</th>
            <td colspan="3">
                  <comment id="_NSID_">
                      <object id=EM_S_TAX_S_DT classid=<%=Util.CLSID_EMEDIT%>  width=125 tabindex=1 align="absmiddle">
                      </object>
                  </comment><script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_TAX_S_DT" onclick="javascript:openCal('G',EM_S_TAX_S_DT)" align="absmiddle" />
                  ~
                  <comment id="_NSID_">
                      <object id=EM_S_TAX_E_DT classid=<%=Util.CLSID_EMEDIT%>  width=120 tabindex=1 align="absmiddle">
                      </object>
                  </comment><script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_TAX_E_DT" onclick="javascript:openCal('G',EM_S_TAX_E_DT)" align="absmiddle" />
            </td>
            
          </tr>       
            
         <tr>
            <th>거래형태</th>
            <td>
                    <comment id="_NSID_">
                        <object id=LC_S_BIZ_TYPE classid=<%= Util.CLSID_LUXECOMBO %> width=150 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>

            </td>
            <th>과세구분</th>
            <td width="159">
                    <comment id="_NSID_">
                        <object id=LC_S_TAX_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=150 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="125">전자세금계산서ID</th>
            <td>
                  <comment id="_NSID_">
                      <object id=EM_S_EDI_SEQ_NO classid=<%=Util.CLSID_EMEDIT%>  width=150 tabindex=1 align="absmiddle">
                      </object>
                  </comment><script> _ws_(_NSID_);</script>
            </td>         
          </tr>
      
          <tr>
             <th>협력사</th>
             <td colspan="8">
               <comment id="_NSID_"> 
                   <object id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1 align="absmiddle"> </object> 
               </comment><script> _ws_(_NSID_);</script>
               <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_S_VEN" class="PR03" align="absmiddle" onclick="javascript:getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM, true);" />
               <comment id="_NSID_"> 
                   <object id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=250 tabindex=1 align="absmiddle" > </object> 
               </comment><script>_ws_(_NSID_);</script>
             </td>
         </tr>         

        </table></td>
      </tr>
    </table></td>
  </tr>
  
  <tr>
    <td class="dot"></td>
  </tr>
  
    <tr valign="top">
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td width="200">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                    <tr>
                    <td>
                          <comment id="_NSID_"> 
                              <OBJECT id=GR_LIST width=100% height=453 classid=<%=Util.CLSID_GRID%>>
                                 <param name="DataID" value="DS_O_LIST">
                              </OBJECT> 
                          </comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                </table>
                </td>
                <td class="PL10">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="right" valign="bottom">
                            <img src="/<%=dir%>/imgs/btn/cancel_apply.gif" id="IMG_CANCEL" width="62" height="18" hspace="2" onclick="javascript:setSmileTax('3');" />
                            <img src="/<%=dir%>/imgs/btn/email_resend.gif" id="IMG_EMAIL"  width="82" height="18" onclick="javascript:setSmileTax('2');"/>
                            <img src="/<%=dir%>/imgs/btn/send_pre.gif"     id="IMG_SEND"   width="62" height="18" onclick="javascript:setSmileTax('1');"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="PT01 PB03">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                           <tr>
                                <th width="100" class="point">점</th>
                                <td width="103">
                                    <comment id="_NSID_"> 
                                        <object id=LC_STR classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th width="62" class="point">발행일</th>
                                <td width="103">
                                    <comment id="_NSID_"> 
                                        <object id=EM_TAX_ISSUE_DT classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                    <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_TAX_ISSUE_DT" onclick="javascript:openCal('G',EM_TAX_ISSUE_DT)" align="absmiddle" />
                                </td>
                                <th width="85">순번</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TAX_ISSUE_SEQ_NO classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="point">협력사코드</th>
                                <td colspan="3">
                                    <comment id="_NSID_"> 
                                        <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VEN" class="PR03" align="absmiddle" onclick="javascript:getVenInfo(EM_VEN_CD, EM_VEN_NM, true);" />
                                    <comment id="_NSID_"> 
                                        <object id=EM_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=177 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>사업자번호</th>        
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_VEN_COMP_NO classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                                       
                            </tr>
                            <tr>
                                <th class="point">거래형태</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=LC_BIZ_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>   
                                <th class="point">과세구분</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=LC_TAX_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>대표자명</th>        
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_VEN_REP_NAME classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>                     
                             
                            <tr>
                                <th>업태</th>        
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_VEN_BIZ_STAT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>종목</th>        
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_VEN_BIZ_CAT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>전화번호</th>        
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_PHONE classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                             
                            <tr>
                                <th>주소</th>
                                <td colspan="5">
                                    <comment id="_NSID_"> 
                                        <object id=EM_ADDR classid=<%=Util.CLSID_EMEDIT%> width=495 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th>담당자명</th>        
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=LC_VEN_CHAR_NAME classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th class="point">담당자메일</th>        
                                <td colspan="3">
                                    <comment id="_NSID_"> 
                                        <object id=EM_VEN_CHAR_EMAIL classid=<%=Util.CLSID_EMEDIT%> width=308 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                
                            </tr>
                            <tr>
                                <th class="point">세금계산서 종류</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=LC_TAX_INV_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th class="point">청구/영수</th>
                                <td colspan="3">
                                    <comment id="_NSID_"> 
                                        <object id=LC_CHARGE_FLAG classid=<%=Util.CLSID_LUXECOMBO%>  width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th>전자세금계산서 ID</th>
                                <td colspan="5">
                                    <comment id="_NSID_"> 
                                        <object id=EM_EDI_SEQ_NO classid=<%=Util.CLSID_EMEDIT%> width=182 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <!--  -->
                            <tr>
                                <th>공급가액</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_SUP_AMT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1   align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>세액</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_VAT_AMT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>합계액</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TOT_AMT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                             
                            <tr>
                                <th>비고</th>
                                <td colspan="5">
                                    <comment id="_NSID_"> 
                                        <object id=EM_REMARK classid=<%=Util.CLSID_EMEDIT%> width=495 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                             <tr>
                                <th>전송자</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_STR_CHAR_NAME classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>전송자메일</th>
                                <td colspan="3">
                                    <comment id="_NSID_"> 
                                        <object id=EM_STR_CHAR_EMAIL classid=<%=Util.CLSID_EMEDIT%> width=308 tabindex=1 align="absmiddle"> </object> 
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
                            <tr valign="top">
                                <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                                    <tr>
                                        <td>
                                          <comment id="_NSID_"> 
                                              <OBJECT id=GR_MASTER width=100% height=147    classid=<%=Util.CLSID_GRID%>>
                                                 <param name="DataID" value="DS_IO_MASTER">
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
        <param name=DataID          value=DS_IO_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
            <c>Col=STR_CD               Ctrl=LC_STR                  param=BindColVal</c>
            <c>Col=TAX_ISSUE_DT         Ctrl=EM_TAX_ISSUE_DT         param=Text</c>
            <c>Col=TAX_ISSUE_SEQ_NO     Ctrl=EM_TAX_ISSUE_SEQ_NO     param=Text</c>
            <c>Col=VEN_CD               Ctrl=EM_VEN_CD               param=Text</c>
            <c>Col=VEN_NM               Ctrl=EM_VEN_NM               param=Text</c>
            <c>Col=VEN_COMP_NO          Ctrl=EM_VEN_COMP_NO          param=Text</c>
            <c>Col=BIZ_TYPE             Ctrl=LC_BIZ_TYPE             param=BindColVal</c>
            <c>Col=TAX_FLAG             Ctrl=LC_TAX_FLAG             param=BindColVal</c>
            <c>Col=VEN_REP_NAME         Ctrl=EM_VEN_REP_NAME         param=Text</c>
            <c>Col=VEN_BIZ_STAT         Ctrl=EM_VEN_BIZ_STAT         param=Text</c>
            <c>Col=VEN_BIZ_CAT          Ctrl=EM_VEN_BIZ_CAT          param=Text</c>
            <c>Col=PHONENUM             Ctrl=EM_PHONE                param=Text</c>
            <c>Col=ADDRESS              Ctrl=EM_ADDR                 param=Text</c>
            <c>Col=VEN_CHAR_NAME        Ctrl=LC_VEN_CHAR_NAME        param=BindColVal</c>
            <c>Col=VEN_CHAR_EMAIL       Ctrl=EM_VEN_CHAR_EMAIL       param=Text</c>
            <c>Col=TAX_INV_TYPE         Ctrl=LC_TAX_INV_TYPE         param=BindColVal</c>
            <c>Col=CHARGE_FLAG          Ctrl=LC_CHARGE_FLAG          param=BindColVal</c>
            <c>Col=EDI_SEQ_NO           Ctrl=EM_EDI_SEQ_NO           param=Text</c>
            <c>Col=SUP_AMT              Ctrl=EM_SUP_AMT              param=Text</c>
            <c>Col=VAT_AMT              Ctrl=EM_VAT_AMT              param=Text</c>
            <c>Col=TOT_AMT              Ctrl=EM_TOT_AMT              param=Text</c>
            <c>Col=REMARK               Ctrl=EM_REMARK               param=Text</c>
            <c>Col=STR_CHAR_NAME        Ctrl=EM_STR_CHAR_NAME        param=Text</c>
            <c>Col=STR_CHAR_EMAIL       Ctrl=EM_STR_CHAR_EMAIL       param=Text</c>
            
        '>
    </object>
</comment><script>_ws_(_NSID_);</script>

</body>
</html>

