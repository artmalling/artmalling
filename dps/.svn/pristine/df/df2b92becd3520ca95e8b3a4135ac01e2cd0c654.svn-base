<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 대금지불 > 매입세금계산서 수기 접수 처리
 * 작 성 일 : 2010.04.14
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : ppay1030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 매입세금계산서 수기 접수처리
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
<!--
var rtnVal            = false;
var intSearchCnt      = 0;                             // 조회버튼클릭 여부(0일 경우 마스터조회 건수)
var bfListRowPosition = 0;                             // 이전 List Row Position
var strToday          = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-14
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
     gridCreate3(); //디테일
     
     // EMedit에 초기화
     initEmEdit(EM_S_YYYYMM,         "THISMN",      PK);             // 매입년월
     initEmEdit(EM_S_SALE_S_DT,      "YYYYMMDD",    READ);           // 매입기간 시작일
     initEmEdit(EM_S_SALE_E_DT,      "YYYYMMDD",    READ);           // 매입기간 종료일
     initEmEdit(EM_S_TAX_S_DT,       "YYYYMMDD",    PK);             // 발행기간 시작일
     initEmEdit(EM_S_TAX_E_DT,       "YYYYMMDD",    PK);             // 발행기간 종료일
     initEmEdit(EM_S_EDI_SEQ_NO,     "GEN^24",      NORMAL);         // 전자세금계산서ID
     initEmEdit(EM_S_VEN_CD,         "000000",      NORMAL);         // 협력사코드
     initEmEdit(EM_S_VEN_NM,         "GEN^40",      READ);           // 협력사명
     
     initEmEdit(EM_YYYYMM,           "YYYYMM",      READ);           // 매입년월
     initEmEdit(EM_TAX_ISSUE_DT,     "YYYYMMDD",    READ);           // 세금계산서발행일자
     initEmEdit(EM_TAX_ISSUE_SEQ_NO, "GEN^5",       READ);           // 세금계산서발행순번
     initEmEdit(EM_ETAX_STAT_NM,     "GEN^40",      READ);           // 상태
     initEmEdit(EM_VEN_CD,           "000000",      READ);           // 협력사 코드
     initEmEdit(EM_VEN_NM,           "GEN^40",      READ);           // 협력사명
     initEmEdit(EM_BIZ_TYPE_NM,      "GEN^40",      READ);           // 거래형태
     initEmEdit(EM_TAX_FLAG_NM,      "GEN^40",      READ);           // 과세구분
     initEmEdit(EM_VEN_COMP_NO,      "#00-00-00000",READ);           // 사업자번호
     initEmEdit(EM_VEN_REP_NAME,     "GEN^40",      READ);           // 대표자명
     initEmEdit(EM_BIZ_STAT,         "GEN^40",      READ);           // 업태
     initEmEdit(EM_PHONE,            "GEN^13",      READ);           // 전화번호
     initEmEdit(EM_BIZ_CAT,          "GEN^40",      READ);           // 종목
     initEmEdit(EM_ADDR,             "GEN^120",     READ);           // 주소
     initEmEdit(EM_TAX_INV_FLAG,     "GEN^40",      READ);           // 세금계산서구분
     initEmEdit(EM_TAX_INV_TYPE,     "GEN^40",      READ);           // 세금계산서종류
     initEmEdit(EM_ETAX_NO,          "GEN^29",      NORMAL);         // 전자세금계산서 ID
     initEmEdit(EM_RVS_ISSUE_FLAG,   "GEN^40",      READ);           // 역발행구분
     initEmEdit(EM_PAY_WAY,          "GEN^40",      READ);           // 지불방법
     initEmEdit(EM_CHARGE_FLAG,      "GEN^40",      READ);           // 청구/영수
     initEmEdit(EM_SUP_AMT,          "NUMBER^13^0", READ);           // 공급가액
     initEmEdit(EM_VAT_AMT,          "NUMBER^13^0", READ);           // 세액
     initEmEdit(EM_TOT_AMT,          "NUMBER^13^0", READ);           // 합계액
     initEmEdit(EM_REMARK,           "GEN^100"    , READ);           // 비고
     
     
     
     //콤보 초기화(조회조건)
     initComboStyle(LC_S_STR_CD,    DS_O_STR_CD,    "CODE^0^30,NAME^0^80", 1, PK);        // 점(조회)
     initComboStyle(LC_S_PAY_CYC,   DS_O_PAY_CYC,   "CODE^0^30,NAME^0^80", 1, PK);        // 지불주기
     initComboStyle(LC_S_PAY_CNT,   DS_O_PAY_CNT,   "CODE^0^30,NAME^0^80", 1, PK);        // 지불회차
     initComboStyle(LC_S_BIZ_TYPE,  DS_O_BIZ_TYPE,  "CODE^0^30,NAME^0^80", 1, NORMAL);    // 거래형태
     initComboStyle(LC_S_TAX_FLAG,  DS_O_TAX_FLAG,  "CODE^0^30,NAME^0^80", 1, NORMAL);    // 과세구분
     initComboStyle(LC_S_ETAX_STAT, DS_O_ETAX_STAT, "CODE^0^30,NAME^0^80", 1, NORMAL);    // 전자세금계산서상태
     
     initComboStyle(LC_PAY_CYC,     DS_O_PAY_CYC,   "CODE^0^30,NAME^0^80", 1, READ);      // 지불주기
     initComboStyle(LC_PAY_CNT,     DS_O_PAY_CNT,   "CODE^0^30,NAME^0^80", 1, READ);      // 지불회차
     
     
     
     getStore("DS_O_STR_CD", "Y", "", "N");   
     getEtcCode("DS_O_PAY_CYC",   "D", "P052", "N");            // 조회지불주기
     getEtcCode("DS_O_PAY_CNT",   "D", "P407", "N");            // 조회지불회차
     getEtcCode("DS_O_BIZ_TYPE",  "D", "P215", "Y");            // 거래형태
     getEtcCode("DS_O_TAX_FLAG",  "D", "P004", "Y");            // 과세구분
     getEtcCode("DS_O_SLIP_FLAG", "D", "P201", "Y");            // 전표구분
     getEtcCode("DS_O_ETAX_STAT", "D", "P402", "Y");            // 세금계산서상태
     
     LC_S_STR_CD.index    = 0;
     LC_S_PAY_CYC.index   = 0;
     LC_S_PAY_CNT.index   = 0;
     LC_S_BIZ_TYPE.index  = 0;
     LC_S_TAX_FLAG.index  = 0;
     LC_S_ETAX_STAT.index = 0;
     LC_S_STR_CD.Focus(); 
     
     getSaleDate("DS_O_SALE_DATE", EM_S_YYYYMM.Text, LC_S_PAY_CYC.BindColVal, LC_S_PAY_CNT.BindColVal);
     EM_S_SALE_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
     EM_S_SALE_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
     EM_S_TAX_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
     EM_S_TAX_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");

 }

 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}          name="NO"              width=30    align=center</FC>'
                      + '<FC>id=VEN_NM            name="협력사"           width=80     Edit=none align=left</FC>'
                      + '<FC>id=TAX_ISSUE_DT      name="발행일자"         width=80    Edit=none Mask="XXXX/XX/XX" align=center</FC>'
                      + '<FC>id=TAX_ISSUE_SEQ_NO  name="발행순번"         width=60    Edit=none align=center</FC>'
                      + '<FC>id=EDI_SEQ_NO        name="전자세금계산서 ID" width=110   Edit=none align=center</FC>'
                      + '<FC>id=ETAX_STAT_NM      name="상태"             width=80    Edit=none align=left</FC>'
                      
     initGridStyle(GR_LIST, "common", hdrProperies, true);
 }

 function gridCreate2(){
     var hdrProperies = '<FC>id={currow}          name="NO"            width=30    Edit=none align=center</FC>'
                      + '<FC>id=TAX_ITEM_DT       name="일자"          width=80    Edit=none Mask="XXXX/XX/XX" align=left</FC>'
                      + '<FC>id=TAX_ITEM_NM       name="품목"          width=100   Edit=none align=left</FC>'
                      + '<FC>id=TAX_ITEM_SPEC     name="규격"          width=50    Edit=none align=left</FC>'
                      + '<FC>id=TAX_ITEM_QTY      name="수량"          width=40    Edit=none align=right</FC>'
                      + '<FC>id=TAX_ITEM_UNIT_AMT name="단가"          width=70    Edit=none align=right</FC>'
                      + '<FC>id=TAX_ITEM_SUP_AMT  name="공급가"        width=80    Edit=none align=right</FC>'
                      + '<FC>id=TAX_ITEM_VAT_AMT  name="*세액"          width=80    Edit=Numeric align=right</FC>'
                      + '<FC>id=TAX_ITEM_REMARK   name="비고"          width=100    Edit=none align=left</FC>';
         
     initGridStyle(GR_DETAIL1, "common", hdrProperies, true);
 }

 function gridCreate3(){
     var hdrProperies = '<FC>id={currow}          name="NO"             width=30    Edit=none sumtext="합계" align=center</FC>'
                      + '<FC>id=CHK_DT            name="검품확정일"      width=80    Edit=none Mask="XXXX/XX/XX" align=center</FC>'
                      + '<FC>id=SLIP_FLAG         name="전표구분"        width=60    EditStyle=Lookup Data="DS_O_SLIP_FLAG:CODE:NAME"  align=center</FC>'
                      + '<FC>id=SLIP_NO           name="전표번호"        width=100   Edit=none align=center Mask="XXXX-XXXXXXX"</FC>'
                      + '<FC>id=PUMBUN_CD         name="브랜드코드"        width=50    Edit=none align=left</FC>'
                      + '<FC>id=PUMBUN_NM         name="브랜드"            width=80    Edit=none align=left</FC>'
                      + '<FC>id=CHK_COST_TAMT     name="공급가액"        width=80    Edit=none sumtext=@sum  align=right</FC>'
                      + '<FC>id=CHK_V_COST_TAMT   name="부가세액"        width=80    Edit=none sumtext=@sum  align=right</FC>'
                      + '<FC>id=CHK_TOT_AMT       name="합계금액"        width=80    Edit=none sumtext=@sum  align=right</FC>'
                      + '<FC>id=REMARK            name="비고"            width=140   Edit=none align=left</FC>';
         
     initGridStyle(GR_DETAIL2, "common", hdrProperies, false);
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
 * 작 성 일 : 2010-04-14
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(checkValidation("Search")){
		DS_IO_MASTER.ClearData();  
        DS_IO_DETAIL.ClearData();
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
 * 작 성 일 : 2010-04-11
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {

}

/**
 * btn_Delete()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-14
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-04-14
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
function btn_Save() {
    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated && !DS_IO_MASTER.IsUpdated){
       //저장할 내용이 없습니다
       showMessage(EXCLAMATION, OK, "USER-1028");
       return;
    }

    if(!checkValidation("Save"))
      return;

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") == 1 ){    // validation 체크
        TR_MAIN.Action="/dps/ppay103.pp?goTo=save&strFlag=save"; 
        TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
        TR_MAIN.Post();

        btn_Search();
    }   
}


/**
 * btn_Excel()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-14
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-14
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-14
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
 * getList()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-14
 * 개    요 :  마스터  조회
 * return값 : void
 */
 function getList(){

    // 조회조건 셋팅
    var strStrCd   = LC_S_STR_CD.BindColVal;                    // 점
    var strYyyymm  = EM_S_YYYYMM.Text;                          // 매입년월
    var strPayCyc  = LC_S_PAY_CYC.BindColVal;                   // 지불주기
    var strPayCnt  = LC_S_PAY_CNT.BindColVal;                   // 지불회차
    var strBizType = LC_S_BIZ_TYPE.BindColVal;                  // 거래형태
    var strTaxFlag = LC_S_TAX_FLAG.BindColVal;                  // 과세구분
    var strSaleSdt = EM_S_SALE_S_DT.Text;                       // 매입기간시작
    var strSaleEdt = EM_S_SALE_E_DT.Text;                       // 매입기간종료
    var strTaxSdt  = EM_S_TAX_S_DT.Text;                        // 발행기간시작
    var strTaxEdt  = EM_S_TAX_E_DT.Text;                        // 발행기간종료       
    var strEdiSeaNo= EM_S_EDI_SEQ_NO.Text;                         // 전자세금계산서ID   
    var strVenCd   = EM_S_VEN_CD.Text;                          // 협력사         
    var strEtaxStat= LC_S_ETAX_STAT.BindColVal;                 // 세금계산서상태

    var goTo       = "getList" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
                   + "&strYyyymm="+encodeURIComponent(strYyyymm)  
                   + "&strPayCyc="+encodeURIComponent(strPayCyc)   
                   + "&strPayCnt="+encodeURIComponent(strPayCnt)   
                   + "&strBizType="+encodeURIComponent(strBizType)  
                   + "&strTaxFlag="+encodeURIComponent(strTaxFlag)  
                   + "&strSaleSdt="+encodeURIComponent(strSaleSdt)  
                   + "&strSaleEdt="+encodeURIComponent(strSaleEdt)  
                   + "&strTaxSdt="+encodeURIComponent(strTaxSdt)   
                   + "&strTaxEdt="+encodeURIComponent(strTaxEdt)   
                   + "&strEdiSeaNo="+encodeURIComponent(strEdiSeaNo)   
                   + "&strVenCd="+encodeURIComponent(strVenCd)    
                   + "&strEtaxStat="+encodeURIComponent(strEtaxStat); 
    
    TR_MAIN.Action  = "/dps/ppay103.pp?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_LIST=DS_O_LIST)"; //조회는 O
    TR_MAIN.Post();
 }
 
 
 /**
 * getDetail()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-14
 * 개    요 :  상세조회
 * return값 : void
 */
 function getDetail(){
	// 조회조건 셋팅
    var strStrCd      = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "STR_CD");               // 점
    var strIssueDt    = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "TAX_ISSUE_DT");         // 세금계산서발행일자
    var strIssueSeqNo = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "TAX_ISSUE_SEQ_NO");     // 세금계산서발행순번
   
    var goTo         = "getDetail" ;    
    var action       = "O";     
    var parameters   = "&strStrCd="+encodeURIComponent(strStrCd)   
				     + "&strIssueDt="+encodeURIComponent(strIssueDt)   
				     + "&strIssueSeqNo="+encodeURIComponent(strIssueSeqNo); 
    
    TR_DETAIL.Action="/dps/ppay103.pp?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER,"+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();

    GR_LIST.ColumnProp('SEL','HeadCheck')= "FALSE";

 }
 
 /**
  * getVenInfo(code, name, btnFlag)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-04-14
  * 개    요 :  브랜드에 따른 협력사 팝업
  * return값 : void
  */
 function getVenInfo(code, name, btnFlag){
     var strStrCd        = LC_S_STR_CD.BindColVal;  
     var strUseYn        = "Y";                             // 사용여부
     var strPumBunType   = "0";                             // 브랜드유형
     var strBizType      = "";                              // 거래형태
     var strMcMiGbn      = "1";                             // 매출처/매입처구분(1:매입처)
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
 }
   
  /**
   * checkValidation()
   * 작 성 자     : 김경은
   * 작 성 일     : 2010-04-15
   * 개    요        :  값 체크 
   * return값 : void
   */
  function checkValidation(Gubun) {
       
       var messageCode = "USER-1001";
       
       //조회버튼 클릭시 Validation Check
       if(Gubun == "Search"){   
    	   if(EM_S_YYYYMM.Text.length == 0){
               showMessage(INFORMATION, OK, "USER-1002", "매입년월");
               EM_S_YYYYMM.Focus();
               return false;
           }
    	   
    	   if(EM_S_TAX_S_DT.Text.length == 0 ){      // 조회일 정합성
               showMessage(INFORMATION, OK, "USER-1002", "조회시작일");
               EM_S_TAX_S_DT.Focus();
               return false;
           }
           
           if(EM_S_TAX_E_DT.Text.length == 0){      // 조회일 정합성
               showMessage(INFORMATION, OK, "USER-1002", "조회종료일");
               EM_S_TAX_E_DT.Focus();
               return false;
           }
           
           if(EM_S_TAX_S_DT.Text > EM_S_TAX_E_DT.Text){                              // 조회일 정합성
               showMessage(EXCLAMATION, OK, "USER-1015");
               EM_S_TAX_S_DT.Focus();
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
           if(EM_ETAX_NO.Text == ""){                                 // 전자세금계산서ID
        	   showMessage(EXCLAMATION, OK, "USER-1002", "전자세금계산서ID");
        	   EM_ETAX_NO.Focus();
               return false;
           }
           
           if(!closeCheck(EM_S_SALE_S_DT.Text)){           // 마감체크(시작일)
               return false;
           }
           
           if(!closeCheck(EM_S_SALE_E_DT.Text)){           // 마감체크(종료일)
               return false;
           }
           
           var strStrCd   = LC_S_STR_CD.BindColVal;                    // 점
           var strYyyymm  = EM_S_YYYYMM.Text;                          // 매입년월
           var strPayCyc  = LC_S_PAY_CYC.BindColVal;                   // 지불주기
           var strPayCnt  = LC_S_PAY_CNT.BindColVal;                   // 지불회차
           
           if(!getIssueDate("DS_O_ISSUE_DATE",strStrCd,strYyyymm,strPayCyc,strPayCnt)){
        	   return false;
           }
           
           if(ppayCloseCheck(strStrCd,strYyyymm,strPayCyc,strPayCnt) == "TRUE"){
               showMessage(INFORMATION, OK, "USER-1150", "대금지불월", "매입세금계산서 수기접수 처리");
               return false;
           }
           return true;
       }
   }
  
  /**
   * closeCheck()
   * 작 성 자 : 김경은
   * 작 성 일 : 2010-05-09
   * 개    요    : 저장시 일마감체크를 한다. (마감시 생성가능)
   * return값 : void
   */
   function closeCheck(strCloseDt){
        var strStrCd         = LC_S_STR_CD.BindColVal; // 점
        var strCloseTaskFlag = "PORD";                 // 업무구분(매입월마감)
        var strCloseUnitFlag = "42";                   // 단위업무
        var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
        var strCloseFlag     = "M";                    // 마감구분(월마감:M)
       
        var closeFlag = getCloseCheck( "DS_O_RESULT", strStrCd , strCloseDt , strCloseTaskFlag 
                                      , strCloseUnitFlag , strCloseAcntFlag , strCloseFlag);
        
        if(closeFlag == "FALSE"){
            showMessage(EXCLAMATION, OK, "USER-1140", "매입월","매입세금계산서 수기접수 처리");
            return false;
        }else{
            return true;
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
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

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
        if(DS_O_LIST.RowStatus(row) != 1){   // 신규일경우
             getDetail();
        }
        if(intSearchCnt == 0){
            intSearchCnt++;
        }else{
            setPorcCount("SELECT", DS_IO_MASTER.CountRow);
        }

    }

    /*
    var strETaxStat = this.NameValue(row, "ETAX_STAT");
    //세금계산서 상태가 승인일 경우는 수정 불가
    if( strETaxStat== "K"){
    	enableControl(EM_ETAX_NO      , false);
    	GR_DETAIL1.Editable            = false;
    }else{
    	enableControl(EM_ETAX_NO      , true);
    	GR_DETAIL1.Editable            = true;
    }
    */
</script>
<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
    switch (colid) {
    case "TAX_ITEM_VAT_AMT":
    	this.NameValue(row,"TAX_ITEM_TOT_AMT") = this.NameValue(row,"TAX_ITEM_SUP_AMT")
    	                                           + this.NameValue(row,"TAX_ITEM_VAT_AMT");
    	EM_VAT_AMT.Text = this.NameValue(row,"TAX_ITEM_VAT_AMT");
    	EM_TOT_AMT.Text = this.NameValue(row,"TAX_ITEM_TOT_AMT");
    	break;

    }

</script>

<script language=JavaScript for=DS_IO_DETAIL1 event=onRowPosChanged(row)>
    if(clickSORT)
        return;
</script>

<script language=JavaScript for=DS_IO_DETAIL2 event=onRowPosChanged(row)>
    if(clickSORT)
        return;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- GR_LIST event 처리 -->
<script language=JavaScript for=GR_LIST event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- GR_DETAIL1 event 처리 -->
<script language=JavaScript for=GR_DETAIL1 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- GR_DETAIL2 event 처리 -->
<script language=JavaScript for=GR_DETAIL2 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- 그리드 CHECK BOX 전체 선택 -->
<script language="javascript"  for=GR_LIST event=OnHeadCheckClick(Col,Colid,bCheck)>

    //헤더 전체 체크/체크해제 컨트롤
    var dataSet = eval(this.DataID);
    for( var i=1 ; i<=dataSet.CountRow; i++){
        dataSet.NameValue(i,Colid) = bCheck=='0'?'F':'T';
    }
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
    EM_S_TAX_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
    EM_S_TAX_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
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
    EM_S_TAX_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
    EM_S_TAX_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
    
</script>

<!-- 조회시작일 변경시  -->
<script lanaguage=JavaScript for=EM_S_TAX_S_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_S_TAX_S_DT, EM_S_SALE_S_DT.Text);
</script>

<!-- 조회종료일 변경시  -->
<script lanaguage=JavaScript for=EM_S_TAX_E_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_S_TAX_E_DT,EM_S_SALE_E_DT.Text);
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
<comment id="_NSID_"><object id="DS_O_STR_CD"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CYC"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CNT"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_BIZ_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TAX_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ETAX_STAT" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SLIP_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_SALE_DATE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ISSUE_DATE" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_LIST"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
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
            <th width="70" class="point">점</th>
            <td width="110">
                    <comment id="_NSID_">
                        <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="70" class="point">매입년월</th>
            <td width="110">
                  <comment id="_NSID_">
                      <object id=EM_S_YYYYMM classid=<%=Util.CLSID_EMEDIT%>  width=75 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',EM_S_YYYYMM)"  align="absmiddle"/>
            </td>
            <th width="100" class="point">지불주기</th>
            <td width="110">
                    <comment id="_NSID_">
                        <object id=LC_S_PAY_CYC classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="70" class="point">지불회차</th>
            <td>
                    <comment id="_NSID_">
                        <object id=LC_S_PAY_CNT classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          
          <tr>
            <th>거래형태</th>
            <td>
                    <comment id="_NSID_">
                        <object id=LC_S_BIZ_TYPE classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>

            </td>
            <th>과세구분</th>
            <td>
                    <comment id="_NSID_">
                        <object id=LC_S_TAX_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
            <th>매입기간</th>
            <td colspan="3">
                  <comment id="_NSID_">
                      <object id=EM_S_SALE_S_DT classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  ~
                  <comment id="_NSID_">
                      <object id=EM_S_SALE_E_DT classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
            </td>            
          </tr>
          
          <tr>
            <th class="point">발행기간</th>
            <td colspan="3">
                  <comment id="_NSID_">
                      <object id=EM_S_TAX_S_DT classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                      </object>
                  </comment><script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_TAX_S_DT" onclick="javascript:openCal('G',EM_S_TAX_S_DT)" align="absmiddle" />
                  ~
                  <comment id="_NSID_">
                      <object id=EM_S_TAX_E_DT classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                      </object>
                  </comment><script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_TAX_E_DT" onclick="javascript:openCal('G',EM_S_TAX_E_DT)" align="absmiddle" />
            </td>
            <th>전자세금계산서ID</th>
            <td colspan="3">
                  <comment id="_NSID_">
                      <object id=EM_S_EDI_SEQ_NO classid=<%=Util.CLSID_EMEDIT%>  width=175 tabindex=1 align="absmiddle">
                      </object>
                  </comment><script> _ws_(_NSID_);</script>
            </td>            
          </tr>
          
          <tr>
             <th>협력사</th>
             <td colspan="3">
               <comment id="_NSID_"> 
                   <object id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"> </object> 
               </comment><script> _ws_(_NSID_);</script>
               <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VEN" class="PR03" align="absmiddle" onclick="javascript:getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM, true);" />
               <comment id="_NSID_"> 
                   <object id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=186 tabindex=1 align="absmiddle" > </object> 
               </comment><script>_ws_(_NSID_);</script>
             </td>
             <th>상태</th>
             
             <td colspan="3">
                    <comment id="_NSID_">
                    
                        <object id=LC_S_ETAX_STAT classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
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
                              <OBJECT id=GR_LIST width=100% height=430 classid=<%=Util.CLSID_GRID%>>
                                 <param name="DataID" value="DS_O_LIST">
                              </OBJECT> 
                          </comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                </table>
                </td>
                <td class="PL10">
                <div style="width:100%; height:435px; overflow: auto">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="PT01 PB03">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                        <tr>
                                <th width="70">매입년월</th>
                                <td width="105">
                                    <comment id="_NSID_"> 
                                        <object id=EM_YYYYMM classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th width="70">지불주기</th>
                                <td width="105">
                                    <comment id="_NSID_"> 
                                        <object id=LC_PAY_CYC classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th width="80">지불회차</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=LC_PAY_CNT classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th>발행일</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TAX_ISSUE_DT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th>순번</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TAX_ISSUE_SEQ_NO classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th>상태</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_ETAX_STAT_NM classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>협력사</th>
                                <td colspan="3">
                                    <comment id="_NSID_"> 
                                        <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                    &nbsp;<comment id="_NSID_"> 
                                        <object id=EM_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=191 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>거래형태</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_BIZ_TYPE_NM classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>                          
                            </tr>
                            <tr>
                                <th>사업자번호</th>        
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_VEN_COMP_NO classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>대표자명</th>        
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_VEN_REP_NAME classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>과세구분</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TAX_FLAG_NM classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>                     
                             
                            <tr>
                                <th>업태</th>        
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_BIZ_STAT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>종목</th>        
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_BIZ_CAT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
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
                                        <object id=EM_ADDR classid=<%=Util.CLSID_EMEDIT%> width=501 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>세금계산서</BR>구분</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TAX_INV_FLAG classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>세금계산서</BR>종류</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TAX_INV_TYPE classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th class="point">접수세금계산서</BR>NO</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_ETAX_NO classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>역발행구분</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_RVS_ISSUE_FLAG classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>지불방법</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_PAY_WAY classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>청구/영수</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_CHARGE_FLAG classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                                                         
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
                                        <object id=EM_REMARK classid=<%=Util.CLSID_EMEDIT%> width=501 tabindex=1 align="absmiddle"> </object> 
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
                                              <OBJECT id=GR_DETAIL1 width=100% height=70    classid=<%=Util.CLSID_GRID%>>
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
                                              <OBJECT id=GR_DETAIL2 width=100% height=107    classid=<%=Util.CLSID_GRID%>>
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
            <c>Col=PAY_YM               Ctrl=EM_YYYYMM               param=Text</c>
            <c>Col=PAY_CYC              Ctrl=LC_PAY_CYC              param=BindColVal</c>
            <c>Col=PAY_CNT              Ctrl=LC_PAY_CNT              param=BindColVal</c>
            <c>Col=TAX_ISSUE_DT         Ctrl=EM_TAX_ISSUE_DT         param=Text</c>
            <c>Col=TAX_ISSUE_SEQ_NO     Ctrl=EM_TAX_ISSUE_SEQ_NO     param=Text</c>
            <c>Col=ETAX_STAT_NM         Ctrl=EM_ETAX_STAT_NM         param=Text</c>
            <c>Col=VEN_CD               Ctrl=EM_VEN_CD               param=Text</c>
            <c>Col=VEN_NM               Ctrl=EM_VEN_NM               param=Text</c>
            <c>Col=BIZ_TYPE_NM          Ctrl=EM_BIZ_TYPE_NM          param=Text</c>
            <c>Col=TAX_FLAG_NM          Ctrl=EM_TAX_FLAG_NM          param=Text</c>
            <c>Col=VEN_COMP_NO          Ctrl=EM_VEN_COMP_NO          param=Text</c>
            <c>Col=VEN_REP_NAME         Ctrl=EM_VEN_REP_NAME         param=Text</c>
            <c>Col=PHONENUM             Ctrl=EM_PHONE                param=Text</c>
            <c>Col=BIZ_STAT             Ctrl=EM_BIZ_STAT             param=Text</c>
            <c>Col=BIZ_CAT              Ctrl=EM_BIZ_CAT              param=Text</c>
            <c>Col=ADDRESS              Ctrl=EM_ADDR                 param=Text</c>
            <c>Col=TAX_INV_FLAG_NM      Ctrl=EM_TAX_INV_FLAG         param=Text</c>
            <c>Col=TAX_INV_TYPE_NM      Ctrl=EM_TAX_INV_TYPE         param=Text</c>
            <c>Col=ETAX_NO              Ctrl=EM_ETAX_NO              param=Text</c>
            <c>Col=RVS_ISSUE_FLAG_NM    Ctrl=EM_RVS_ISSUE_FLAG       param=Text</c>
            <c>Col=PAY_WAY_NM           Ctrl=EM_PAY_WAY              param=Text</c>
            <c>Col=CHARGE_FLAG_NM       Ctrl=EM_CHARGE_FLAG          param=Text</c>
            <c>Col=SUP_AMT              Ctrl=EM_SUP_AMT              param=Text</c>
            <c>Col=VAT_AMT              Ctrl=EM_VAT_AMT              param=Text</c>
            <c>Col=TOT_AMT              Ctrl=EM_TOT_AMT              param=Text</c>
            <c>Col=REMARK               Ctrl=EM_REMARK               param=Text</c>
            
        '>
    </object>
</comment><script>_ws_(_NSID_);</script>

</body>
</html>

