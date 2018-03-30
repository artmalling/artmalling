<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주관리 > ORDER SHEET 조회
 * 작 성 일 : 2010.03.04
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pcod5020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : ORDER SHEET 등록
 * 이    력 :
 *        2010.04.04 (박래형) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"     prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"  prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"      prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"   prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">


var strToday        = "";   //현재날짜
var strYYYYMM       = "";   //현재날짜



var inta            = 0;
var bfListRowPosition = 0;                               // 이전 List Row Position
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

 function doInit(){
	 
	//햔재날짜
	 strToday  =   getTodayDB("DS_O_RESULT");   
//	 strYYYYMM =   getTodayFormat("yyyymm");  
	 
     // Input Data Set Header 초기화     
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
     DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>'); 
     DS_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>'); 

     // Output Data Set Header 초기화
     
     //그리드 초기화
     gridCreate1(); //마스터
     gridCreate2(); //디테일
     
  // EMedit에 초기화
     // 조회부
     initEmEdit(EM_S_S_ORDER_DT,        "SYYYYMMDD",  NORMAL);        //ORDER 기간 1
     initEmEdit(EM_S_E_ORDER_DT,        "TODAY",      NORMAL);        //ORDER 기간 2
     initEmEdit(EM_S_ORDER_SEQ_NO,      "GEN^13",     NORMAL);        //ORDER NO
     initEmEdit(EM_S_PUMBUN_CD,         "000000",     NORMAL);        //브랜드코드
     initEmEdit(EM_S_PUMBUN_NM,         "GEN",        READ);          //브랜드명
     initEmEdit(EM_S_VEN_CD,            "000000",     NORMAL);        //협력사코드
     initEmEdit(EM_S_VEN_NM,            "GEN",        READ);          //협력사명
     
     // 입력부
     initEmEdit(EM_I_PUMBUN_CD,         "000000",     READ);         //브랜드코드
     initEmEdit(EM_O_PUMBUN_NM,         "GEN",        READ);          //브랜드명
     initEmEdit(EM_O_BUYER_CD,          "GEN^6",      READ);          //바이어코드
     initEmEdit(EM_O_BUYER_NM,          "GEN",        READ);          //바이어명
     initEmEdit(EM_I_VEN_CD,            "000000",     READ);         //협력사코드
     initEmEdit(EM_O_VEN_NM,            "GEN",        READ);          //협력사명    
     initEmEdit(EM_I_EXC_APP_DT,        "YYYYMMDD",   READ);        //환율적용일
     initEmEdit(EM_I_EXC_RATE,          "NUMBER^13^2",READ);        //환율
     initEmEdit(EM_I_SHIP_PORT,         "GEN^40",     READ);        //선적항
     initEmEdit(EM_I_LC_DATE,           "YYYYMMDD",   READ);        //L/C DATE
     initEmEdit(EM_I_LC_NO,             "GEN^40",     READ);        //L/C NO
     initEmEdit(EM_I_LC_EFFECTIVE_DT,   "YYYYMMDD",   READ);        //L/C 유효일
     initEmEdit(EM_I_LC_OPEN_BANK,      "GEN^40",     READ);        //L/C 개설은행
     initEmEdit(EM_O_TOT_PRICE,         "NUMBER^13^2",READ);          //총금액
     initEmEdit(EM_I_PAYMENT,           "GEN^100",    READ);        //Payment
     initEmEdit(EM_I_VENDOR_INFO,       "GEN^200",    READ);        //Vendor Info
     initEmEdit(EM_I_ORDER_DT,          "YYYYMMDD",   READ);            //ORDER 일자
     initEmEdit(EM_I_ORDER_NO,          "CODE^13^0",  READ);          //ORDER NO
     EM_I_ORDER_NO.Format = "00-000000-00000";
     EM_I_ORDER_NO.Alignment = 0;
     initEmEdit(EM_I_ATTN,              "GEN^100",    READ);        //ATTN
     initEmEdit(EM_I_MESSRS,            "GEN^100",    READ);        //MESSR
     initEmEdit(EM_I_SHIPPMENT,         "GEN^100",    READ);        //Shippment
     initEmEdit(EM_I_VALIDITY,          "GEN^100",    READ);        //Validity
     initEmEdit(EM_I_PACKING,           "GEN^100",    READ);        //Packing
     initEmEdit(EM_O_PRICE,             "GEN^100",    READ);        //Price
     initEmEdit(EM_O_PRICE_2,           "NUMBER^13^2",READ);          //Price2
     initEmEdit(EM_I_ORIGIN,             "GEN^100",    READ);        //Origin
     initEmEdit(EM_I_INSPECTION,        "GEN^100",    READ);        //Inspection
     initEmEdit(EM_I_DELIVERY,          "GEN^100",    READ);

     //콤보 초기화
     initComboStyle(LC_S_STR_CD,            DS_STR,                 "CODE^0^30,NAME^0^80", 1, PK);                //조회부 점
     
     initComboStyle(LC_I_STR_CD,            DS_STR,                 "CODE^0^30,NAME^0^80", 1, READ);                //점
     initComboStyle(LC_I_CURRENCY_CD,       DS_I_CURRENCY,          "CODE^0^30,NAME^0^80", 1, READ);            //화폐단위
     initComboStyle(LC_I_PRC_COND,          DS_I_PRC_COND,          "CODE^0^30,NAME^0^80", 1, READ);            //가격조건
     initComboStyle(LC_I_PAYMENT_COND,      DS_I_PAYMENT_COND,      "CODE^0^30,NAME^0^80", 1, READ);            //결제조건
     initComboStyle(LC_I_PAYMENT_DTL_COND,  DS_I_PAYMENT_DTL_COND,  "CODE^0^30,NAME^0^80", 1, READ);            //결제조건 상세 
     initComboStyle(LC_I_SHIPMENT_CD,       DS_I_SHIPPMENT,         "CODE^0^30,NAME^0^80", 1, READ);            //운송방법
     initComboStyle(LC_I_ARRI_PORT,         DS_I_ARRI_PORT,         "CODE^0^30,NAME^0^80", 1, READ);            //도착항
     initComboStyle(LC_I_IMPORT_COUNTRY,    DS_I_IMPORT_COUNTRY,    "CODE^0^30,NAME^0^80", 1, READ);            //수입국가
     
     //공통코드에서 데이터 가지고 오기
     getStore("DS_STR", "Y", "", "N");                          // 점코드     

     getEtcCode("DS_I_CURRENCY",        "D", "P217", "N");      // 화폐단위 
     getEtcCode("DS_I_PRC_COND",        "D", "P218", "N");      // 가격조건 
     getEtcCode("DS_I_PAYMENT_COND",    "D", "P219", "N");      // 결제조건 
     getEtcCode("DS_I_PAYMENT_DTL_COND","D", "P220", "N");      // 결제조건상세 
     getEtcCode("DS_I_SHIPPMENT",       "D", "P221", "N");      // 운송방법 
     getEtcCode("DS_I_ARRI_PORT",       "D", "P222", "N");      // 도착항 
     getEtcCode("DS_I_IMPORT_COUNTRY",  "D", "P223", "N");      // 수입국가 
     getEtcCode("DS_ORD_UNIT_CD",       "D", "P013", "N");      // 단위 
     
     //데이터셋 등록
     registerUsingDataset("pord502","DS_LIST,DS_IO_MASTER,DS_IO_DETAIL" );

     LC_S_STR_CD.Index = 0; // 조회부 점
     LC_S_STR_CD.Focus();   // 조회부 포커스
//     LC_I_STR_CD.Index = 0; // 입력부 점    
     
//     EM_S_S_ORDER_DT.Text = (strYYYYMM + '01');
     
 }

function gridCreate1(){
    var hdrProperies = '<FC>id=STR_NM       name="점"            width=50    align=center </FC>'
			        + '<FC>id=ORDER_DT       name="ORDER 일자"    width=80    align=center Mask="XXXX-XX-XX" </FC>'
			        + '<FC>id=ORDER_SHEET_NO name="ORDER NO"      width=120   align=center Mask="XX-XXXXXX-XXXXX" </FC>'
			        + '<FC>id=PUMBUN_NM      name="브랜드"          width=80    align=left </FC>'
			        + '<FC>id=VEN_NM         name="협력사"        width=80    align=left </FC>';                   

    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies = '<FC>id=CHECK1       width=20               align=center EditStyle=CheckBox HeadCheckShow=true  show=false</FC>'
                     + '<FC>id={currow}     name="NO"              width=50     align=center Edit=none sumtext=""</FC>'
			         + '<FC>id=SKU_CD       name="단품코드"         width=120   align=center  sumtext="합계" </FC>'
                     + '<FC>id=SKU_NM       name="단품명"           width=100   align=left    Edit=none </FC>'
                     + '<FC>id=ORD_UNIT_CD  name="단위"             width=60   align=left    Edit=none  EditStyle=Lookup  Data="DS_ORD_UNIT_CD:CODE:NAME"</FC>'
			         + '<FC>id=STYLE_CD     name="스타일코드"       width=210    align=center Edit=none </FC>'
			         + '<FC>id=COLOR_CD     name="칼라"             width=80    align=center  Edit=none </FC>'
			         + '<FC>id=SIZE_CD      name="사이즈"           width=80    align=center  Edit=none </FC>'
			         + '<FC>id=MODEL_NO     name="모델코드"         width=100    align=center Edit=none </FC>'
			         + '<FC>id=ORDER_QTY    name="ORDER 수량"       width=80    align=right Edit=Numeric  sumtext=@sum </FC>'
			         + '<FC>id=OFFER_QTY    name="OFFER 수량"       width=80    align=right Edit=none  sumtext=@sum </FC>'
			         + '<FC>id=INVOICE_QTY  name="INVOICE 수량"     width=80    align=right Edit=none  sumtext=@sum </FC>'
			         + '<FC>id=CHK_QTY      name="입고수량"         width=80    align=right Edit=none  sumtext=@sum </FC>'
                     + '<FC>id=NOT_IN_QTY        name="미입고수량"  width=80    align=right Edit=none  sumtext=@sum </FC>'
			         + '<FC>id=ORDER_UNIT_AMT    name="외화단가"    width=80                           sumtext=@sum</FC>'
			         + '<FC>id=ORDER_AMT         name="외화금액"    width=100   align=right Edit=none  sumtext=@sum</FC>';                     

    initGridStyle(GR_DETAIL, "common", hdrProperies, false);
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
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {	
   	
	if(checkValue("Search")){
		DS_IO_MASTER.ClearData();
		DS_IO_DETAIL.ClearData();
        inta = 0;
        bfListRowPosition = 0;       
	    getList();
        setPorcCount("SELECT", GR_MASTER);
	    
        if(DS_LIST.CountRow == 0){
            LC_S_STR_CD.Focus();
            return;
        }

        GR_MASTER.Focus();
     }
//	EM_I_VENDOR_INFO.ReadOnly = "true";
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {		 
}

/**
 * btn_Save()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {	 	
}

/**
 * btn_Excel()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 박래형
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
 * getList()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-107
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
 function getList(){
     
    // 조회조건 셋팅
    var strStrCd         = LC_S_STR_CD.BindColVal;      // 점
    var strSOrderDt      = EM_S_S_ORDER_DT.Text;        // 조회기간1
    var strEOrderdDt     = EM_S_E_ORDER_DT.Text;        // 조회기간2
    var strOrderNo       = EM_S_ORDER_SEQ_NO.Text;      // ORDER NO
    var strPumbun        = EM_S_PUMBUN_CD.Text;         // 브랜드
    var strVen           = EM_S_VEN_CD.Text;            // 협력사
   
    var goTo       = "getList" ;    
    var action     = "O";     
    var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)   
                    + "&strSOrderDt="+encodeURIComponent(strSOrderDt)     
                    + "&strEOrderdDt="+encodeURIComponent(strEOrderdDt)      
                    + "&strOrderNo="+encodeURIComponent(strOrderNo)        
                    + "&strPumbun="+encodeURIComponent(strPumbun)        
                    + "&strVen="+encodeURIComponent(strVen);  
    TR_MAIN.Action="/dps/pord502.po?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_LIST=DS_LIST)"; //조회는 O
    TR_MAIN.Post();
 }
 /**
  * getMaster()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-107
  * 개    요 :  마스터 리스트 조회
  * return값 : void
  */
  function getMaster(){
	  
	// 조회조건 셋팅
	var strStrCd         = DS_LIST.NameValue(DS_LIST.RowPosition, "STR_CD");        // 점
	var strOrderYm       = DS_LIST.NameValue(DS_LIST.RowPosition, "ORDER_YM");      // ORDER_YM
	var strOrderSeqNo    = DS_LIST.NameValue(DS_LIST.RowPosition, "ORDER_SEQ_NO");  // ORDER_SEQ_NO
	
	var goTo       = "getMaster" ;    
	var action     = "O";     
	var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)   
	                + "&strOrderYm="+encodeURIComponent(strOrderYm)
	                + "&strOrderSeqNo="+encodeURIComponent(strOrderSeqNo);  
	TR_S_MAIN.Action="/dps/pord502.po?goTo="+goTo+parameters;  
	TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
	TR_S_MAIN.Post();
  }
 
 /**
  * getDetail()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-07
  * 개    요 :  마스터 리스트 조회
  * return값 : void
  */
  function getDetail(){
     // 조회조건 셋팅
     var strStrCd         = DS_LIST.NameValue(DS_LIST.RowPosition, "STR_CD");        // 점
     var strOrderYm       = DS_LIST.NameValue(DS_LIST.RowPosition, "ORDER_YM");      // ORDER_YM
     var strOrderSeqNo    = DS_LIST.NameValue(DS_LIST.RowPosition, "ORDER_SEQ_NO");  // ORDER_SEQ_NO
    
     var goTo       = "getDetail" ;    
     var action     = "O";     
     var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)   
				     + "&strOrderYm="+encodeURIComponent(strOrderYm)
				     + "&strOrderSeqNo="+encodeURIComponent(strOrderSeqNo);  
     TR_S_MAIN.Action="/dps/pord502.po?goTo="+goTo+parameters;  
     TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
     TR_S_MAIN.Post();
  }
  
/**
 * checkValue(Gubun)
 * 작 성 자     : 박래형
 * 작 성 일     : 2010-03-12
 * 개    요        : 조회조건 값 체크 
 * Gubun : Search, Save, Delete
 * return값 : void
 */
function checkValue(Gubun) {
     
     var messageCode = "USER-1001";

     switch (Gubun) {
     case "Search": 
         if(LC_S_STR_CD.Text.length == 0){                                    // 점
             showMessage(EXCLAMATION, OK, messageCode, "점");
             LC_S_STR_CD.Focus();
             return false;
         }   
         if(EM_S_S_ORDER_DT.Text.length == 0){                                //ORDER 기간1
             showMessage(EXCLAMATION, OK, messageCode, "ORDER 기간");
             EM_S_S_ORDER_DT.Text = strToday;
             EM_S_S_ORDER_DT.Focus();
             return false;
         }  
         if(EM_S_E_ORDER_DT.Text.length == 0){                                //ORDER 기간2
             showMessage(EXCLAMATION, OK, messageCode, "ORDER 기간");
             EM_S_E_ORDER_DT.Text = strToday;
             EM_S_E_ORDER_DT.Focus();
             return false;
         } 
         
         if(EM_S_S_ORDER_DT.Text > EM_S_E_ORDER_DT.Text){                             // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1015");
             EM_S_S_ORDER_DT.Focus();
             return false;
         }
         return true;
         break;
     }     
}



/**
 * searchPumbunPop()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-18
 * 개    요 :  조회조건 브랜드팝업
 * return값 : void
 */
 function searchPumbunPop(){
     var tmpOrgCd        = LC_S_STR_CD.BindColVal;
     var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
     var strStrCd        = LC_S_STR_CD.BindColVal;                                       // 점
     var strOrgCd        = tmpOrgCd + "00000000";                                     // 조직코드
     var strVenCd        = "";                                                        // 협력사
     var strBuyerCd      = "";                                                        // 바이어
     var strPumbunType   = "0";                                                       // 브랜드유형
     var strUseYn        = "Y";                                                       // 사용여부
     var strSkuFlag      = "1";                                                       // 단품구분(2:비단품)
     var strSkuType      = "";                                                        // 단품종류(1:규격단품)
     var strItgOrdFlag   = "";                                                        // 통합발주여부
     var strBizType      = "1";                                                      // 거래형태(1:직매입) 
     var strSaleBuyFlag  = "1";                                                       // 판매분매입구분

     var rtnMap = strPbnPop( EM_S_PUMBUN_CD, EM_S_PUMBUN_NM, 'Y'
                            , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                            , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                            , strBizType,strSaleBuyFlag);
     if(rtnMap != null){
    	 return true;
     }else{
    	 return false;
     }
 }


 /**
  * searchPumbunNonPop()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-18
  * 개    요 :  조회조건 브랜드팝업
  * return값 : void
  */
  function searchPumbunNonPop(){
      var tmpOrgCd        = LC_S_STR_CD.BindColVal;
      var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
      var strStrCd        = LC_S_STR_CD.BindColVal;                                       // 점
      var strOrgCd        = tmpOrgCd + "00000000";                                     // 조직코드
      var strVenCd        = "";                                                        // 협력사
      var strBuyerCd      = "";                                                        // 바이어
      var strPumbunType   = "0";                                                       // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "1";                                                       // 단품구분(2:비단품)
      var strSkuType      = "";                                                        // 단품종류(1:규격단품)
      var strItgOrdFlag   = "";                                                        // 통합발주여부
      var strBizType      = "1";                                                      // 거래형태(1:직매입) 
      var strSaleBuyFlag  = "1";                                                       // 판매분매입구분


      var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_S_PUMBUN_CD, EM_S_PUMBUN_NM, "Y", "1"
                             , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                             , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                             , strBizType,strSaleBuyFlag);           

      if(rtnMap != null){
          return true;
      }else{
          return false;
      }
  }

 
 /**
  * getVenInfo(code, name)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-18
  * 개    요 :  브랜드에 따른 협력사 팝업
  * return값 : void
  */
 function getVenInfo(code, name){
     var strStrCd        = LC_S_STR_CD.BindColVal;                                    // 점
     var strUseYn        = "Y";                                                       // 사용여부
     var strPumBunType   = "0";                                                       // 브랜드유형(0정상)
     var strBizType      = "1";                                                       // 거래형태
     var strMcMiGbn      = "1";                                                       // 매출처/매입처구분
     var strBizFlag      = "";                                                        // 거래구분
     

     var rtnMap = venPop(code, name
                          ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                          ,strBizFlag);
     
     if(rtnMap != null){
    	 return true;
     }else{
         return false;    	
     }
 }
 

 /**
  * getVenNonInfo(code, name)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-18
  * 개    요 :  브랜드에 따른 협력사 팝업
  * return값 : void
  */
 function getVenNonInfo(code, name){
     var strStrCd        = LC_S_STR_CD.BindColVal;                                    // 점
     var strUseYn        = "Y";                                                       // 사용여부
     var strPumBunType   = "0";                                                       // 브랜드유형(0정상)
     var strBizType      = "1";                                                       // 거래형태
     var strMcMiGbn      = "1";                                                       // 매출처/매입처구분
     var strBizFlag      = "";                                                        // 거래구분

     var rtnMap = setVenNmWithoutPop( "DS_O_RESULT", code, name, "1"
                                         ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                                         ,strBizFlag);
     if(rtnMap != null){
         return true;
     }else{
         return false;       
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
        showMessage(EXCLAMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_S_MAIN event=onFail>
trFailed(TR_S_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>


<script language=JavaScript for=DS_LIST event=onRowPosChanged(row)>

    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        
        getMaster();
        getDetail();
        
        if(inta == 0){  
            inta++;
        }else{
            setPorcCount("SELECT", DS_IO_DETAIL.CountRow);      
        }
        
        if(DS_LIST.NameValue(row, "SKU_TYPE")=='1'){        //규격단품
            GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = false;
            GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
            GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;    
            
        }else if(DS_LIST.NameValue(row, "SKU_TYPE")=='2'){  //신선단품
            GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = false;
            GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
            GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;     

        }else if(DS_LIST.NameValue(row, "SKU_TYPE")=='3'){  //의류단품          
            if(DS_LIST.NameValue(row, "STYLE_TYPE")=='1'){
                GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = true;
                GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = true;
                GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = true;                 
            }else{
                GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = true;
                GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
                GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;                    
            } 
        }
    }   
    if(clickSORT)
        return;
</script>

<script language=JavaScript for=DS_IO_DETAIL event=onRowPosChanged(row)>
if(clickSORT)
    return;
</script>
<!--  ===================GR_MASTER============================ -->
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);

</script>


<!-- Grid GR_DETAIL oneClick event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>
  sortColId( eval(this.DataID), row, colid);    
</script>


<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
    EM_S_PUMBUN_CD.Text    = "";
    EM_S_PUMBUN_NM.Text    = "";    
    EM_S_VEN_CD.Text       = "";
    EM_S_VEN_NM.Text       = "";    
    EM_S_ORDER_SEQ_NO.Text = "";
</script>


<!-- 조회시작일 변경시  -->
<script lanaguage=JavaScript for=EM_S_S_ORDER_DT event=OnKillFocus()>
//    checkDateTypeYMD( EM_S_S_ORDER_DT );

    var strSyyyymmdd = strToday.substring(0,6) + "01";
    checkDateTypeYMD( EM_S_S_ORDER_DT, strSyyyymmdd );
</script>

<!-- 조회종료일 변경시  -->
<script lanaguage=JavaScript for=EM_S_E_ORDER_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_S_E_ORDER_DT );
</script>


<!-- 조회부 브랜드 KillFocus -->
<script language=JavaScript for=EM_S_PUMBUN_CD event=onKillFocus()>

    if(EM_S_PUMBUN_CD.Text != ""){
        searchPumbunNonPop();
    }else
    	EM_S_PUMBUN_NM.Text = "";  

</script>


<!-- 조회부 협력사 KillFocus -->
<script language=JavaScript for=EM_S_VEN_CD event=onKillFocus()>

    if(EM_S_VEN_CD.Text != ""){
        getVenNonInfo(EM_S_VEN_CD, EM_S_VEN_NM);
    }else
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
<comment id="_NSID_"><object id="DS_I_COMMON"           classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STR"                classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CURRENCY"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PRC_COND"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SHIPPMENT"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PAYMENT_COND"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PAYMENT_DTL_COND" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_ARRI_PORT"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_IMPORT_COUNTRY"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"           classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_LIST"               classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"          classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"          classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SKU_SALEPRC"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_ORD_UNIT_CD"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


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
                    <td width="300">
                         <comment id="_NSID_">
                            <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1 width=100 align="absmiddle">
                            </object>
                        </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point" width="70">ORDER 기간</th>
                    <td>
                        <comment id="_NSID_">
                              <object id=EM_S_S_ORDER_DT classid=<%=Util.CLSID_EMEDIT%>  width=119 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_S_ORDER_DT)" align="absmiddle"/>
                        ~
                        <comment id="_NSID_">
                              <object id=EM_S_E_ORDER_DT classid=<%=Util.CLSID_EMEDIT%>  width=119 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_E_ORDER_DT)" align="absmiddle"/>
                    </td>
                 </tr>
                 <tr>
                    <th>ORDER NO</th>
                    <td colspan="3">
                        <comment id="_NSID_">
                              <object id=EM_S_ORDER_SEQ_NO classid=<%=Util.CLSID_EMEDIT%>  width=100 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th>브랜드</th>
                    <td>
                        <comment id="_NSID_">
                              <object id=EM_S_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_S_PUMBUN" class="PR03" align="absmiddle" onclick="javascript:searchPumbunPop();" />
                        <comment id="_NSID_">
                              <object id=EM_S_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%>  width=190 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                    </td>
                    <th>협력사</th>
                    <td>
                        <comment id="_NSID_">
                              <object id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_S_VEN" class="PR03" align="absmiddle" onclick="javascript:getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM);" />
                        <comment id="_NSID_">
                              <object id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%>  width=190 tabindex=1 align="absmiddle">
                              </object>
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
        <td width="200">
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                    <td>
                        <comment id="_NSID_">
                            <OBJECT id=GR_MASTER width=100% height=453 classid=<%=Util.CLSID_GRID%>>
                                <param name="DataID" value="DS_LIST">
                            </OBJECT>
                        </comment><script>_ws_(_NSID_);</script>
                   </td>
                </tr>
             </table>
        </td>
       <td class="PL10">
       <div style="width:100%; height:456px; overflow: auto">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="PT01 PB03">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0"
                            class="s_table">
                            
                <tr>
                  <th width="80">점</th>
                  <td colspan="5">
                         <comment id="_NSID_">
                            <object id=LC_I_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1 width=90 align="absmiddle">
                            </object>
                        </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th >브랜드</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                            <object id=EM_I_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      &nbsp;<comment id="_NSID_">
                            <object id=EM_O_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%>  width=190 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>바이어</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_O_BUYER_CD classid=<%=Util.CLSID_EMEDIT%>  width=45 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                            <object id=EM_O_BUYER_NM classid=<%=Util.CLSID_EMEDIT%>  width=50 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>협력사</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                            <object id=EM_I_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      &nbsp<comment id="_NSID_">
                            <object id=EM_O_VEN_NM classid=<%=Util.CLSID_EMEDIT%>  width=190 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>화폐단위</th>
                  <td>
	                  <comment id="_NSID_">
	                     <object id=LC_I_CURRENCY_CD classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1 width=100 align="absmiddle">
	                     </object>
	                 </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>  
                                              
                <tr>
                  <th width="80">가격조건</th>
                  <td width="95">
                      <comment id="_NSID_">
                         <object id=LC_I_PRC_COND classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1 width=90 align="absmiddle">
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th width="73">운송방법</th>
                  <td width="105">
                      <comment id="_NSID_">
                            <object id=LC_I_SHIPMENT_CD classid=<%=Util.CLSID_LUXECOMBO%>  width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th width="70">환율적용일</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_EXC_APP_DT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                 
                <tr>
                  <th>결제조건</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                         <object id=LC_I_PAYMENT_COND classid=<%= Util.CLSID_LUXECOMBO%> tabindex=1 width=188 align="absmiddle">
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                      <comment id="_NSID_">
                         <object id=LC_I_PAYMENT_DTL_COND classid=<%= Util.CLSID_LUXECOMBO%> tabindex=1 width=100 align="absmiddle">
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th>환율</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_EXC_RATE classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                 
                <tr>
                  <th>선적항</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                            <object id=EM_I_SHIP_PORT classid=<%=Util.CLSID_EMEDIT%> width=289 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>도착항</th>
                  <td>
                      <comment id="_NSID_">
                         <object id=LC_I_ARRI_PORT classid=<%= Util.CLSID_LUXECOMBO%> tabindex=1 width=100 align="absmiddle">
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
               
                <tr>
                  <th>L/C DATE</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_LC_DATE classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>L/C NO</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                            <object id=EM_I_LC_NO classid=<%=Util.CLSID_EMEDIT%> width=293 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>L/C 유효일</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_LC_EFFECTIVE_DT classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>L/C개설은행</th>
                  <td width="105">
                      <comment id="_NSID_">
                            <object id=EM_I_LC_OPEN_BANK classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>총금액</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_O_TOT_PRICE classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Payment</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_PAYMENT classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=485 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Vendor Info</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_VENDOR_INFO classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=485 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>ORDER 일자</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_ORDER_DT classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>ORDER NO</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_ORDER_NO classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>수입국가</th>
                  <td >
                      <comment id="_NSID_">
                         <object id=LC_I_IMPORT_COUNTRY classid=<%= Util.CLSID_LUXECOMBO%> tabindex=1 width=100 align="absmiddle">
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                 
                <tr>
                  <th>ATTN</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_ATTN classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=485 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>MESSR</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_MESSRS classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=485 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Shippment</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_SHIPPMENT classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=485 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Validity</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_VALIDITY classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=485 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Packing</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_PACKING classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=485 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Price</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_O_PRICE classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=383 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                    <comment id="_NSID_">
                        <object id=EM_O_PRICE_2 classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=100 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Origin</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_ORIGIN classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=485 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Inspection</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_INSPECTION classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=485 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Delivery</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_DELIVERY classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=485 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
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
		                            <OBJECT id=GR_DETAIL width=100% height=160 classid=<%=Util.CLSID_GRID%>>
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
        </div>
        </td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
            
        <c>Col=PUMBUN_CD            Ctrl=EM_I_PUMBUN_CD         param=Text</c> 
        <c>Col=PUMBUN_NM            Ctrl=EM_O_PUMBUN_NM         param=Text</c> 
        <c>Col=VEN_CD               Ctrl=EM_I_VEN_CD            param=Text</c> 
        <c>Col=VEN_NM               Ctrl=EM_O_VEN_NM            param=Text</c> 
        <c>Col=BUYER_CD             Ctrl=EM_O_BUYER_CD          param=Text</c> 
        <c>Col=BUYER_NM             Ctrl=EM_O_BUYER_NM          param=Text</c> 
        
        <c>Col=ORDER_TOT_AMT        Ctrl=EM_O_TOT_PRICE         param=Text</c>    
 
        <c>Col=SHIP_PORT            Ctrl=EM_I_SHIP_PORT         param=Text</c> 
        <c>Col=LC_DATE              Ctrl=EM_I_LC_DATE           param=Text</c> 
        <c>Col=LC_NO                Ctrl=EM_I_LC_NO             param=Text</c> 
        <c>Col=LC_EFFECTIVE_DT      Ctrl=EM_I_LC_EFFECTIVE_DT   param=Text</c> 
        <c>Col=LC_OPEN_BANK         Ctrl=EM_I_LC_OPEN_BANK      param=Text</c> 
        <c>Col=VENDOR_INFO          Ctrl=EM_I_VENDOR_INFO       param=Text</c> 
        <c>Col=ORDER_DT             Ctrl=EM_I_ORDER_DT          param=Text</c>  
        <c>Col=ORDER_SHEET_NO       Ctrl=EM_I_ORDER_NO          param=Text</c>
        <c>Col=ATTN                 Ctrl=EM_I_ATTN              param=Text</c> 
        <c>Col=MESSRS               Ctrl=EM_I_MESSRS             param=Text</c> 
        <c>Col=VALIDITY             Ctrl=EM_I_VALIDITY          param=Text</c>    
        <c>Col=SHIPPMENT            Ctrl=EM_I_SHIPPMENT          param=Text</c> 
        <c>Col=PACKING              Ctrl=EM_I_PACKING           param=Text</c>    
        <c>Col=PRICE                Ctrl=EM_O_PRICE             param=Text</c> 
        <c>Col=PRICE2               Ctrl=EM_O_PRICE_2           param=Text</c>    
        <c>Col=ORIGIN                Ctrl=EM_I_ORIGIN            param=Text</c> 
        <c>Col=INSPECTION           Ctrl=EM_I_INSPECTION        param=Text</c>    
        <c>Col=DELIVERY             Ctrl=EM_I_DELIVERY          param=Text</c> 
        <c>Col=EXC_APP_DT           Ctrl=EM_I_EXC_APP_DT        param=Text</c>    
        <c>Col=EXC_RATE             Ctrl=EM_I_EXC_RATE          param=Text</c> 
        <c>Col=PAYMENT              Ctrl=EM_I_PAYMENT           param=Text</c> 
                
        <c>Col=STR_CD               Ctrl=LC_I_STR_CD            param=BindColVal</c> 
        <c>Col=PRC_COND             Ctrl=LC_I_PRC_COND          param=BindColVal</c> 
        <c>Col=CURRENCY_CD          Ctrl=LC_I_CURRENCY_CD       param=BindColVal</c> 
        <c>Col=SHIPPMENT_CD         Ctrl=LC_I_SHIPMENT_CD       param=BindColVal</c> 
        <c>Col=PAYMENT_COND         Ctrl=LC_I_PAYMENT_COND      param=BindColVal</c> 
        <c>Col=PAYMENT_DTL_COND     Ctrl=LC_I_PAYMENT_DTL_COND  param=BindColVal</c>
        <c>Col=ARRI_PORT            Ctrl=LC_I_ARRI_PORT         param=BindColVal</c> 
        <c>Col=IMPORT_COUNTRY       Ctrl=LC_I_IMPORT_COUNTRY    param=BindColVal</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
<body>
</html>

