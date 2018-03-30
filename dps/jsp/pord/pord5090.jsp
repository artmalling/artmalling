<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 수입경비 > OFFER SHEET 마감처리
 * 작 성 일 : 2010.03.12
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pcod5090.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : OFFER SHEET 마감처리
 * 이    력 :
 *        2010.04.06 (박래형) 신규작성
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


var strToday        = "";   // 현재날짜
var strYYYYMM       = "";   // 현재날짜
var name            = "ORDER NO";

var g_strYNGbn      = "";   // 확정여부 메시지 띄우기 위해
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
     strYYYYMM =   strToday.substring(0,6);  
     
     // Input Data Set Header 초기화     
     DS_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>'); 
     DS_CHK_CLOSE.setDataHeader('<gauce:dataset name="H_CHK_CLOSE"/>'); 
     // Output Data Set Header 초기화
     
     //그리드 초기화
     gridCreate1(); //마스터    
     
     // 조회부
     initEmEdit(EM_S_S_OFFER_DT,      "SYYYYMMDD",   PK);          //조회기준 기간 1
     initEmEdit(EM_S_E_OFFER_DT,      "TODAY",       PK);          //조회기준 기간 2
     initEmEdit(EM_S_OFFER_NO,        "GEN^30",      NORMAL);      //기준 NO
     initEmEdit(EM_S_PUMBUN_CD,       "000000",      NORMAL);      //브랜드코드
     initEmEdit(EM_S_PUMBUN_NM,       "GEN^40",      READ);        //브랜드명
     initEmEdit(EM_S_VEN_CD,          "0000000",     NORMAL);      //협력사코드
     initEmEdit(EM_S_VEN_NM,          "GEN^40",      READ);        //협력사명                                                        
//     initEmEdit(RD_CLOSE_FLAG,        "GEN",         PK);          //OFFER마감여부 
                                                                     
     //콤보 초기화
     initComboStyle(LC_S_STR_CD,         DS_STR,             "CODE^0^30,NAME^0^80", 1, PK);      //조회부 점
     
     //공통코드에서 데이터 가지고 오기     
     getStore("DS_STR", "Y", "", "N");  
     getEtcCode("DS_O_STANDARD_TYPE",  "D", "P229", "N");       // 기준일
     
     //데이터셋 등록
     registerUsingDataset("pord509","DS_LIST");
     
     LC_S_STR_CD.Index = 0;
     LC_S_STR_CD.Focus();
 }

function gridCreate1(){
    var hdrProperies = '<FC>id=CHECK1                name="선택"            align=center EditStyle=CheckBox  HeadCheckShow=true </FC>' //  edit={IF(EXPNC_CLOSE_FLAG="Y" OR COST_CLOSE_FLAG="Y","false","true")} 
    	            + '<FC>id=STR_NM                 name="점"              edit=none    width=60     align=left show=false</FC>'
			        + '<FC>id=PUMBUN_CD              name="브랜드코드"         edit=none   width=70     align=center </FC>'
			        + '<FC>id=PUMBUN_NM              name="브랜드명"           edit=none   width=120    align=left </FC>'
			        + '<FC>id=VEN_CD                 name="협력사코드"       edit=none   width=70     align=center </FC>'
			        + '<FC>id=VEN_NM                 name="협력사명"         edit=none   width=130    align=left </FC>'
			        + '<FC>id=OFFER_DT               name="OFFER 일자"       edit=none   width=80     align=center  Mask="XXXX/XX/XX" show=false</FC>'
                    + '<FC>id=OFFER_SHEET_NO         name="OFFER NO"         edit=none   width=220    align=center </FC>'
                    + '<FC>id=CLOSE_FLAG             name="OFFER 마감여부"   width=120   align=center  </FC>'
                    + '<FC>id=CHANGE_CLOSE_FLAG      name="TEMP 마감여부"    width=120   align=center  show=false</FC>'
                    + '<FC>id=EXPNC_CLOSE_FLAG       name="제경비확정여부"   width=120    align=center </FC>'
                    + '<FC>id=COST_CLOSE_FLAG        name="원가산정 확정여부" width=120   align=center  </FC>'
			        + '<FC>id=CURRENCY_CD            name="환종"             edit=none   width=60      align=center </FC>'
			        + '<FG> name = "OFFER"'
			        + '<FC>id=OFFER_TOT_QTY          name="수량"             edit=none   width=60      align=right </FC>'                        
			        + '<FC>id=OFFER_TOT_AMT          name="금액"             edit=none   width=130     align=right </FC>'                        
			        + '<FG>name = "INVOICE"'                                             
			        + '<FC>id=INVOICE_TOT_QTY        name="수량"             edit=none   width=60      align=right </FC>'                        
			        + '<FC>id=INVOICE_TOT_AMT        name="외화금액"         edit=none   width=130     align=right </FC>'                        
			        + '<FC>id=INVOICE_WON_TOT_AMT    name="원화금액"         edit=none   width=130     align=right </FC>'                        
			        + '<FG> name ="입고(검품)"'                                              
			        + '<FC>id=CHK_TOT_QTY            name="수량"             edit=none   width=60      align=right </FC>'                        
			        + '<FC>id=CHK_EXC_TAMT           name="외화금액"         edit=none   width=130     align=right </FC>'                        
			        + '<FC>id=CHK_COST_TAMT          name="원화금액"         edit=none   width=130     align=right </FC></FG>';                                             
			
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
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() { 

	GR_MASTER.ColumnProp('CHECK1','HeadCheck')= "false";
    
    // 변경, 추가내역이 있을 경우
    if (DS_LIST.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1073") != 1 )
           return;
    }
    
    if(checkValue("Search")){
        getList();
        // 조회결과 Return
        setPorcCount("SELECT", GR_MASTER);
        if(DS_LIST.CountRow == 0){
            LC_S_STR_CD.Focus();
            return;
        }
    }
    GR_MASTER.ColumnProp('CHECK1','HeadCheck')= "false";
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
	 
    // 저장할 데이터 없는 경우
    if (!DS_LIST.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1090");
        return;
    }

    var strCloseFlag = DS_LIST.NameValue(DS_LIST.RowPosition, "CLOSE_FLAG");
    
    if(strCloseFlag == "N"){
        var returnv = showMessage(STOPSIGN, YESNO, "USER-1205");    //확정하시겠습니까?
        if(returnv == "1"){
            //alert("확정");
            g_strYNGbn = "Y";
        }else{
            return;
        }
        
    }else if(strCloseFlag == "Y"){                                 //확정 취소하시겠습니까?
        var returnv = showMessage(STOPSIGN, YESNO, "USER-1206");
        if(returnv == "1"){
            //alert("확정취소");
            g_strYNGbn = "N";
        }else{
            return;
        }
    }
    
	if(!checkValue("Save", g_strYNGbn))
		return false;	
	
    TR_MAIN.Action="/dps/pord509.po?goTo=conf&strToday="+strToday+"&strYNGbn="+g_strYNGbn; 
    TR_MAIN.KeyValue="SERVLET(I:DS_LIST=DS_LIST)"; //조회는 O
    TR_MAIN.Post();     
    btn_Search();
    
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
    var strStrCd         = LC_S_STR_CD.BindColVal;       // 점
    var strSStandardDt   = EM_S_S_OFFER_DT.Text;         // 조회기간1
    var strEStandardDt   = EM_S_E_OFFER_DT.Text;         // 조회기간2
    var strStandardNo    = EM_S_OFFER_NO.Text;           // 기준에 따른 NO
    var strPumbun        = EM_S_PUMBUN_CD.Text;          // 브랜드
    var strVen           = EM_S_VEN_CD.Text;             // 협력사
    var strCloseFlag     = RD_CLOSE_FLAG.CodeValue;      // 마감여부
   
    var goTo       = "getList" ;    
    var action     = "O";     
    var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)    
                    + "&strSStandardDt="+encodeURIComponent(strSStandardDt)     
                    + "&strEStandardDt="+encodeURIComponent(strEStandardDt)      
                    + "&strStandardNo="+encodeURIComponent(strStandardNo)       
                    + "&strPumbun="+encodeURIComponent(strPumbun)        
                    + "&strVen="+encodeURIComponent(strVen)        
                    + "&strCloseFlag="+encodeURIComponent(strCloseFlag);  
    TR_MAIN.Action="/dps/pord509.po?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_LIST=DS_LIST)"; //조회는 O
    TR_MAIN.Post();
 }
/**
 * checkValue(Gubun)
 * 작 성 자     : 박래형
 * 작 성 일     : 2010-03-12
 * 개    요        : 조회조건 값 체크 
 * Gubun : Search, Save, Delete
 * return값 : void
 */
function checkValue(Gubun, strYNFlag) {
     
     var messageCode = "USER-1001";

     switch (Gubun) {
     case "Search": 
         if(LC_S_STR_CD.Text.length == 0){                                    // 점
             showMessage(EXCLAMATION, OK, messageCode, "점");
             LC_S_STR_CD.Focus();
             return false;
         }   
         if(EM_S_S_OFFER_DT.Text.length == 0){                                //INVOICE 기간1
             showMessage(EXCLAMATION, OK, messageCode, "OFFER 기간");
             EM_S_S_OFFER_DT.Focus();
             return false;
         }  
         if(EM_S_E_OFFER_DT.Text.length == 0){                                //INVOICE 기간2
             showMessage(EXCLAMATION, OK, messageCode, "OFFER 기간");
             EM_S_E_OFFER_DT.Focus();
             return false;
         } 
         
         if(EM_S_S_OFFER_DT.Text > EM_S_E_OFFER_DT.Text){                             // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1015");
             EM_S_S_OFFER_DT.Focus();
             return false;
         }
         return true;
         break;
         
     case "Save":      
         var intRowCount   = DS_LIST.CountRow;
         if(intRowCount > 0){
             for(var i=1; i <= intRowCount; i++){
            	 
                 if(DS_LIST.NameValue(i, "CHECK1") == "T"){
                	 // 오퍼 마감상태에서 마감취소할때만 체크한다.
                	 if(strYNFlag == "N"){
                         var strReturnValue = chkConfClose(i);
                         
                         if(strReturnValue == "A"){         //수입제경비 확정상태
                             return false;
                             
                         }else if(strReturnValue == "B"){   //수입원가 산정상태
                             return false;
                         }                		 
                	 }
                	 
                	 /*
                     var strCloseFlag      = DS_LIST.Namevalue(i, "CHANGE_CLOSE_FLAG");   // OFFER 마감여부(저장전에 임시로 셋팅하는 값)
                     var strExpncCloseFlag = DS_LIST.Namevalue(i, "EXPNC_CLOSE_FLAG");    // 제경비 확정여부
                     var strCostCloseFlag  = DS_LIST.Namevalue(i, "COST_CLOSE_FLAG");     // 수입원가 확정여부
                     
                     if(strCloseFlag == "N"){  //확정취소: 실제로는 Y일때(중요: 체크박스 체크시점에서 값을 바꾼다 Y->N, N->Y)
                         if(strExpncCloseFlag == "Y"){
                             showMessage(EXCLAMATION, OK, "USER-1182");     //수입제경비 확정상태
                             DS_LIST.RowPosition = i;
                             GR_MASTER.SetColumn("CHECK1");
                             GR_MASTER.Focus();
                             return false;
                         }
                         if(strCostCloseFlag == "Y"){
                             showMessage(EXCLAMATION, OK, "USER-1181");     //수입원가 확정상태
                             DS_LIST.RowPosition = i;
                             GR_MASTER.SetColumn("CHECK1");
                             GR_MASTER.Focus();
                             return false;
                         }
                     }else{
//                    	 alert("확정하려는 상태");
                     }
                     */
                 }
             }
         }
         return true;
         break;
     }    
}

/**
 * chkConfClose(row, strYNFlag)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-07-19
 * 개    요 :  확정시 체크사항
 * return값 : void
 */
function chkConfClose(row) {
   var strStrCd        = DS_LIST.NameValue(row, "STR_CD");
   var strOfferYm      = DS_LIST.NameValue(row, "OFFER_YM");
   var strOfferSeqNo   = DS_LIST.NameValue(row, "OFFER_SEQ_NO");
   var strOfferSheetNo = DS_LIST.NameValue(row, "OFFER_SHEET_NO");
   
   var strReturnValue  = "";
   var goTo       = "chkConfClose" ;    
   var action     = "O";     
   var parameters = "&strStrCd="+encodeURIComponent(strStrCd)    
			      + "&strOfferYm="+encodeURIComponent(strOfferYm)
			      + "&strOfferSeqNo="+encodeURIComponent(strOfferSeqNo)
			      + "&strOfferSheetNo="+encodeURIComponent(strOfferSheetNo);
   
   TR_MAIN.Action="/dps/pord509.po?goTo="+goTo+parameters;  
   TR_MAIN.KeyValue="SERVLET("+action+":DS_CHK_CLOSE=DS_CHK_CLOSE)"; //조회는 O
   TR_MAIN.Post();  
   
   if(DS_CHK_CLOSE.NameValue(DS_CHK_CLOSE.RowPosition, "EXPNC_CLOSE_FLAG") == "Y"){
       showMessage(EXCLAMATION, OK, "USER-1000", "이미 수입제경비 확정 되었습니다.");
       setFocusGrid(GR_MASTER, DS_LIST, row, "CHECK1");
       strReturnValue = "A";
       return strReturnValue;
       
   }else if(DS_CHK_CLOSE.NameValue(DS_CHK_CLOSE.RowPosition, "COST_CLOSE_FLAG") == "Y"){
       showMessage(EXCLAMATION, OK, "USER-1000", "이미 수입원가산정 되었습니다.");
       setFocusGrid(GR_MASTER, DS_LIST, row, "CHECK1");
       strReturnValue = "B";
       return strReturnValue;       
   } 
   
   return strReturnValue;
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
      var strOrgCd        = tmpOrgCd+"00000000";                                         // 조직코드
      var strVenCd        = "";                                                        // 협력사
      var strBuyerCd      = "";                                                        // 바이어
      var strPumbunType   = "0";                                                       // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
      var strSkuType      = "";                                                        // 단품종류(1:규격단품)
      var strItgOrdFlag   = "";                                                        // 통합발주여부
      var strBizType      = "1";                                                       // 거래형태(1:직매입) 
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
      var strStrCd        = LC_S_STR_CD.BindColVal;                                    // 점
      var strOrgCd        = tmpOrgCd+"00000000";                                       // 조직코드
      var strVenCd        = "";                                                        // 협력사
      var strBuyerCd      = "";                                                        // 바이어
      var strPumbunType   = "0";                                                       // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
      var strSkuType      = "";                                                        // 단품종류(1:규격단품)
      var strItgOrdFlag   = "";                                                        // 통합발주여부
      var strBizType      = "1";                                                       // 거래형태(1:직매입) 
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
   * 개    요 :  조회 브랜드에 따른 협력사 팝업
   * return값 : void
   */
  function getVenInfo(code, name){
      var strStrCd        = LC_S_STR_CD.BindColVal;                                    // 점
      var strUseYn        = "Y";                                                       // 사용여부
      var strPumBunType   = "0";                                                       // 브랜드유형
      var strBizType      = "1";                                                        // 거래형태
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
      var strPumBunType   = "0";                                                       // 브랜드유형
      var strBizType      = "1";                                                        // 거래형태
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
//    sortColId( eval(this.DataID), row, colid);    
</script>

<script language=JavaScript for=DS_LIST event=onRowPosChanged(row)>
/*
	var strExpncCloseFlag = DS_LIST.Namevalue(row, "EXPNC_CLOSE_FLAG");
	var strCostCloseFlag  = DS_LIST.Namevalue(row, "COST_CLOSE_FLAG");
	
	if(strExpncCloseFlag == "Y" || strCostCloseFlag == "Y"){
		GR_MASTER.ColumnProp("CHECK1", "Edit") = "none";
	}else{
		GR_MASTER.ColumnProp("CHECK1", "Edit") = "any";
	}
*/
</script>

<!--  DS_LIST 변경시 -->
<script language=JavaScript for=DS_LIST event=OnColumnChanged(row,colid)>

    var strCloseFlag = DS_LIST.NameValue(row, "CHANGE_CLOSE_FLAG");
    
	switch (colid) {
	case "CHECK1":
	    if(strCloseFlag == "Y"){
	    	DS_LIST.NameValue(row, "CHANGE_CLOSE_FLAG") = "N";
	    }else if(strCloseFlag == "N"){
	    	DS_LIST.NameValue(row, "CHANGE_CLOSE_FLAG") = "Y";	    	
	    }
	    break;
	}
</script>


<!-- 마스터 그리드 헤더 선택시 전체 선택/해제 -->
<script language=JavaScript for=GR_MASTER event="OnHeadCheckClick(Col,Colid,bCheck)">       
    if (Colid == "CHECK1") {
        if (bCheck == 1) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_LIST.CountRow; i++)
            {
                DS_LIST.NameValue(i + 1, "CHECK1") = "T";
            }    
            GR_MASTER.Redraw = true;
        }
        else if (bCheck == 0) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_LIST.CountRow; i++)
            {
                DS_LIST.NameValue(i + 1, "CHECK1") = "F";
            } 
            GR_MASTER.Redraw = true;
        }
    }
</script>


<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
//  EM_S_OFFER_NO.Text = "";
    EM_S_PUMBUN_CD.Text   = "";
    EM_S_PUMBUN_NM.Text   = "";
    EM_S_VEN_CD.Text      = "";
    EM_S_VEN_NM.Text      = "";
</script>


<!-- 조회시작일 변경시  -->
<script lanaguage=JavaScript for=EM_S_S_OFFER_DT event=OnKillFocus()>
//    checkDateTypeYMD( EM_S_S_OFFER_DT );
    
    var strSyyyymmdd = strToday.substring(0,6) + "01";
    checkDateTypeYMD( EM_S_S_OFFER_DT, strSyyyymmdd );
</script>

<!-- 조회종료일 변경시  -->
<script lanaguage=JavaScript for=EM_S_E_OFFER_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_S_E_OFFER_DT );
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
<comment id="_NSID_"><object id="DS_O_RESULT"           classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_LIST"               classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STANDARD_TYPE"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CHK_CLOSE"          classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
<object id="TR_M_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
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
                    <td colspan="3" width=300>
                         <comment id="_NSID_">
                            <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 align="absmiddle" tabindex=1 >
                            </object>
                        </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point" width="100">OFFER 기간</th>
                    <td colspan="3">
                        <comment id="_NSID_">
                              <object id=EM_S_S_OFFER_DT classid=<%=Util.CLSID_EMEDIT%>  width=120 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_S_OFFER_DT)" align="absmiddle"/>
                        ~
                        <comment id="_NSID_">
                              <object id=EM_S_E_OFFER_DT classid=<%=Util.CLSID_EMEDIT%>  width=120 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_E_OFFER_DT)" align="absmiddle"/>
                    </td>
                  </tr>
                  <tr>
                    <th><span id="STANDARD_NO" style="Color: 146ab9">OFFER NO</span></th>
                    <td colspan="3">
                        <comment id="_NSID_">
                              <object id=EM_S_OFFER_NO classid=<%=Util.CLSID_EMEDIT%>  width=285 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                    </td>
                    <th>OFFER 마감여부</th>
                    <td><comment id="_NSID_"> <object id=RD_CLOSE_FLAG
                        classid=<%=Util.CLSID_RADIO%> tabindex=1
                        style="height: 20; width: 200">
                        <param name=Cols value="2">
                        <param name=Format value="N^미마감,Y^마감">
                        <param name=CodeValue value="N">
                    </object> </comment> <script> _ws_(_NSID_);</script></td>
                  </tr>
                  <tr>
                    <th>브랜드</th>
                    <td colspan="3">
                        <comment id="_NSID_">
                              <object id=EM_S_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_S_PUMBUN" class="PR03" align="absmiddle" onclick="javascript:searchPumbunPop();" />
                        <comment id="_NSID_">
                              <object id=EM_S_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%>  width=180 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                    </td>
                    <th>협력사</th>
                    <td colspan="3">
                        <comment id="_NSID_">
                              <object id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_S_VEN" class="PR03" align="absmiddle" onclick="javascript:getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM);" />
                        <comment id="_NSID_">
                              <object id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%>  width=180 tabindex=1 align="absmiddle">
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
        <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                    <td>
                        <comment id="_NSID_">
                            <OBJECT id=GR_MASTER width=100% height=454 classid=<%=Util.CLSID_GRID%>>
                                <param name="DataID" value="DS_LIST">
                            </OBJECT>
                        </comment><script>_ws_(_NSID_);</script>
                   </td>
                </tr>
             </table>
        </td>
  
      </tr>
    </table></td>
  </tr>
</table>
</div>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<body>
</html>

