<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주관리 > 수입원가 산정 확정
 * 작 성 일 : 2010.01.21
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pord5100.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 수입원가 산정 확정
 * 이    력 :
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"          prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">

var strToday      = "";                            // 현재날짜v
var strYYYYMM     = "";
var headerInsFlag = false;

var inta              = 0;
var bfListRowPosition = 0;                               // 이전 List Row Position

var g_strYNGbn        = "";
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
     
     strToday        = getTodayDB("DS_O_RESULT");
     strYYYYMM       = strToday.substring(0,6);  
     
     // Input Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
     DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>'); 
     // Output Data Set Header 초기화
     
     //그리드 초기화
     gridCreate1(); //마스터
     gridCreate2(); //디테일
     
     // EMedit에 초기화
     initEmEdit(EM_START_DT,   "SYYYYMMDD", NORMAL);          //조회기간1
     initEmEdit(EM_END_DT,     "TODAY", NORMAL);              //조회기간2
     initEmEdit(EM_O_OFFERNO,  "GEN^30", NORMAL);             //OFFER NO
     initEmEdit(EM_S_PB_CD,    "000000", NORMAL);             //조회용 브랜드코드
     initEmEdit(EM_S_PB_NM,    "GEN",   READ);                //조회용 브랜드명     
     initEmEdit(EM_S_VEN_CD,   "000000", NORMAL);             //조회용 협력사코드
     initEmEdit(EM_S_VEN_NM,   "GEN",   READ);                //조회용 협력사코드명
     
     //콤보 초기화
     initComboStyle(LC_S_STR,         DS_O_STR,         "CODE^0^30,NAME^0^80", 1, NORMAL);     // 점
     
     //점,공통코드 데이타 가져오기 
     getStore("DS_O_STR", "Y", "", "N");
     
     LC_S_STR.Index   = 0;      

     //데이터셋 등록
     registerUsingDataset("pord507","DS_IO_MASTER");
 }

 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}                name="NO"             width=40     align=center </FC>'
                         + '<FC>id=CHECK1               name="선택"           width=60     align=center EditStyle=CheckBox HeadCheckShow="true"</FC>'
                         + '<FC>id=STR_CD               name="점코드"         SHOW=FALSE   </FC>'
                         + '<FC>id=OFFER_YM             name="OFFER YM"       SHOW=FALSE   </FC>'
                         + '<FC>id=OFFER_SEQ_NO         name="OFFER 순번"     SHOW=FALSE   </FC>'
                         + '<FC>id=OFFER_DT             name="OFFER DATE"     Edit=none    width=100    align=center mask="XXXX/XX/XX"</FC>'
                         + '<FC>id=OFFER_SHEET_NO       name="OFFER NO"       Edit=none    width=200    align=center </FC>'
                         + '<FC>id=BL_NO                name="B/L NO"         Edit=none    width=80     align=center </FC>'    
                         + '<FC>id=PUMBUN_CD            name="브랜드코드"        Edit=none   width=80     align=center </FC>' 
                         + '<FC>id=PUMBUN_NM            name="브랜드"            Edit=none   width=80     align=left </FC>'
                         + '<FC>id=VEN_CD               name="협력사코드"      Edit=none    width=80    align=center</FC>'
                         + '<FC>id=VEN_NM               name="협력사"          Edit=none    width=110   align=left </FC>'
                         + '<FC>id=OFFER_TOT_QTY        name="OFFER 수량"      Edit=none    width=80    align=right </FC>'
                         + '<FC>id=CHK_TOT_QTY          name="입고수량"         Edit=none   width=80     align=right </FC>'
                         + '<FC>id=NOT_IN_QTY           name="미입고수량"       Edit=none   width=80     align=right </FC>'
                         + '<FC>id=CHK_EXC_TAMT         name="외화금액"         Edit=none   width=100    align=right </FC>'
                         + '<FC>id=CHK_COST_TAMT        name="원화금액"         Edit=none   width=100    align=right </FC>'
                         + '<FC>id=EXP_SUP_AMT          name="총추정통관제비용"  Edit=none   width=120    align=right </FC>'
                         + '<FC>id=EXP_VAT_AMT          name="VAT"              Edit=none   width=100    align=right </FC>'
                         + '<FC>id=CLOSE_FLAG           name="OFFER 마감여부"   Edit=none   width=100    align=CENTER </FC>'
                         + '<FC>id=EXPNC_CLOSE_FLAG     name="제경비 확정여부"   Edit=none   width=100    align=CENTER </FC>'
                         + '<FC>id=COST_CLOSE_FLAG      name="원가 확정여부"     Edit=none   width=100    align=CENTER </FC>'
                         + '<FC>id=TMP_COST_CLOSE_FLAG  name="임시 원가 확정여부" Edit=none   width=120    align=CENTER show=false</FC>'
                         + '<FC>id=SKU_FLAG             name="단품구분"         Edit=none   width=80     align=CENTER show=false</FC>'
                         + '<FC>id=SKU_TYPE             name="단품종류"         Edit=none   width=80     align=CENTER show=false</FC>';
                      
                         
     initGridStyle(GR_MASTER, "common", hdrProperies, true);
 }

 function gridCreate2(){
     var hdrProperies = '<FC>id={currow}             name="NO"             width=40    align=center</FC>'            
                         + '<FC>id=SLIP_NO           name="전표번호"        width=100   align=center  Mask="XXXX-X-XXXXXXX"</FC>'            
                         + '<FC>id=SKU_CD            name="단품코드"        width=100   align=center</FC>'            
                         + '<FC>id=SKU_NM            name="단품명"          width=140   align=left</FC>'            
                         + '<FC>id=STYLE_CD          name="스타일"          width=100   align=left</FC>'            
                         + '<FC>id=COLOR_CD          name="칼라"            width=100   align=left</FC>'            
                         + '<FC>id=SIZE_CD           name="사이즈"          width=100   align=left</FC>'            
                         + '<FC>id=MODEL_NO          name="모델번호"        width=100   edit=none align=center </FC>'            
                         + '<FC>id=CHK_QTY           name="수량"            width=70    align=right </FC>'            
                         + '<FC>id=CHK_EXC_AMT       name="외화금액"        width=120   edit=none align=right </FC>'
                         + '<FC>id=CHK_COST_AMT      name="원화금액"        width=120   align=right</FC>'
                         + '<FC>id=ASS_EXPENCE_AMT   name="추정통관제비용"  width=120   Edit=none align=right </FC>'
                         + '<FC>id=ASS_COST_PRC      name="추정원가"        width=120   edit=none align=right </FC>'
                         + '<FC>id=CONF_EXPENCE_AMT  name="확정통관제비용"  width=120   align=right </FC>'
                         + '<FC>id=CONF_COST_PRC     name="확정원가"        width=120   align=right </FC>';    

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
     
    // 변경, 추가내역이 있을 경우
    if (DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1073") != 1 )
           return;
    }    

    if(EM_START_DT.Text > EM_END_DT.Text){                             // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_START_DT.Text = EM_END_DT.Text;
        EM_START_DT.Focus();
        return;
    }

    GR_MASTER.ColumnProp('CHECK1','HeadCheck')= "FALSE";
    DS_IO_MASTER.ClearData();  
    DS_IO_DETAIL.ClearData();

    inta = 0;
    bfListRowPosition = 0;       
    
    // 조회조건 셋팅
    var strStrCd        = LC_S_STR.BindColVal;          //점
    var strOfferDtFrom  = EM_START_DT.text;             //offer기간 from
    var strOfferDtTo    = EM_END_DT.text;               //offer기간 to
    var strOfferNo      = EM_O_OFFERNO.text;            //offer 번호
    var strPbCd         = EM_S_PB_CD.text;              //브랜드코드
    var strVenCd        = EM_S_VEN_CD.text;             //협력사 코드
    var strConfFlag     = RD_S_CONF_FLAG.CodeValue;     //제경비 확정여부 

    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
                   + "&strOfferDtFrom="+encodeURIComponent(strOfferDtFrom)     
                   + "&strOfferDtTo="+encodeURIComponent(strOfferDtTo)
                   + "&strOfferNo="+encodeURIComponent(strOfferNo)
                   + "&strPbCd="+encodeURIComponent(strPbCd)
                   + "&strVenCd="+encodeURIComponent(strVenCd)
                   + "&strConfFlag="+encodeURIComponent(strConfFlag);
    
    TR_MAIN.Action="/dps/pord510.po?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();  

    setPorcCount("SELECT", GR_MASTER);
    headerInsFlag = false;
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
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
     
     headerInsFlag = false;
     
    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }
    
    if(!checkValidation("Save"))
        return ;
    
              
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") == 1 ){
        
        var strDetailCount = DS_IO_DETAIL.CountRow;          
        TR_MAIN.Action="/dps/pord510.po?goTo=save&strFlag=save"; 
        TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
        TR_MAIN.Post();              
        btn_Search(); 
    }

    headerInsFlag = true;
    bfListRowPosition = 0;
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
    if (!DS_IO_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1090");
        return;
    }

    var strCostCloseFlag = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COST_CLOSE_FLAG");
    
    if(strCostCloseFlag == "N"){
        var returnv = showMessage(STOPSIGN, YESNO, "USER-1205");    //확정하시겠습니까?
        if(returnv == "1"){
            //alert("확정");
            g_strYNGbn = "Y";
        }else{
            return;
        }
        
    }else if(strCostCloseFlag == "Y"){                             //확정 취소하시겠습니까?
        var returnv = showMessage(STOPSIGN, YESNO, "USER-1206");
        if(returnv == "1"){
            //alert("확정취소");
            g_strYNGbn = "N";
        }else{
            return;
        }
    }
    
    //확정시 값체크
    if(!checkValidation("Conf"))
        return false;

    
    TR_MAIN.Action="/dps/pord510.po?goTo=conf&strToday="+strToday+"&strYNGbn="+g_strYNGbn; 
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post(); 
    
    btn_Search();
    
    
    /*
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1024") == 1 ){  
    }
    */
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getDetail()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-18
  * 개    요 :  상세조회
  * return값 : void
  */
 function getDetail(strStrCd,strOfferYm,strOfferSeqNo) {
    var goTo       = "getDetail" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
                   + "&strOfferYm="+encodeURIComponent(strOfferYm)     
                   + "&strOfferSeqNo="+encodeURIComponent(strOfferSeqNo);
    
    TR_DETAIL.Action="/dps/pord510.po?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();  
    
    GR_DETAIL.ColumnProp('CHECK1','HeadCheck')= "FALSE";
}

 /**
  * searchPumbunPop()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-18
  * 개    요 :  조회조건 브랜드팝업
  * return값 : void
  */
  function searchPumbunPop(){
      var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
      var strStrCd        = LC_S_STR.BindColVal;                                       // 점
      var strOrgCd        = "";                                                        // 조직코드
      var strVenCd        = "";                                                        // 협력사
      var strBuyerCd      = "";                                                        // 바이어
      var strPumbunType   = "0";                                                       // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "1";                                                       // 단품구분(2:비단품)
      var strSkuType      = "";                                                        // 단품종류(1:규격단품)
      var strItgOrdFlag   = "";                                                        // 통합발주여부
      var strBizType      = "1";                                                       // 거래형태(1:직매입) 
      var strSaleBuyFlag  = "1";                                                       // 판매분매입구분

      var rtnMap = strPbnPop( EM_S_PB_CD, EM_S_PB_NM, 'Y'
                             , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                             , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                             , strBizType,strSaleBuyFlag);
      if(rtnMap != null){
          return true;
      }else
          return false;

  }

  /**
   * searchPumbunPop()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-18
   * 개    요 :  조회조건 브랜드팝업
   * return값 : void
   */
   function searchPumbunNonPop(){
       var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
       var strStrCd        = LC_S_STR.BindColVal;                                       // 점
       var strOrgCd        = "";                                                        // 조직코드
       var strVenCd        = "";                                                        // 협력사
       var strBuyerCd      = "";                                                        // 바이어
       var strPumbunType   = "0";                                                       // 브랜드유형
       var strUseYn        = "Y";                                                       // 사용여부
       var strSkuFlag      = "1";                                                       // 단품구분(2:비단품)
       var strSkuType      = "";                                                        // 단품종류(1:규격단품)
       var strItgOrdFlag   = "";                                                        // 통합발주여부
       var strBizType      = "1";                                                       // 거래형태(1:직매입) 
       var strSaleBuyFlag  = "1";                                                       // 판매분매입구분

       var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_S_PB_CD, EM_S_PB_NM, "Y", "1"
                             , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                             , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                             , strBizType,strSaleBuyFlag);       
       if(rtnMap != null){
           return true;
       }else
           return false;

   }
  
 /**
  * getVenInfo(code, name)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-18
  * 개    요 :  브랜드에 따른 협력사 팝업
  * return값 : void
  */
 function getVenInfo(code, name){
     var strStrCd        = LC_S_STR.BindColVal;                                       // 점
     var strUseYn        = "Y";                                                       // 사용여부
     var strPumBunType   = "0";                                                       // 브랜드유형
     var strBizType      = "1";                                                       // 거래형태
     var strMcMiGbn      = "1";                                                       // 매출처/매입처구분
     var strBizFlag      = "";                                                        // 거래구분 

     var rtnMap = repVenPop(code, name
                          ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                          ,strBizFlag);
     if(rtnMap != null){
        return true; 
     }else
        return false;
 }
 
 
 /**
  * getVenInfoNon(code, name)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-18
  * 개    요 :  브랜드에 따른 협력사 팝업
  * return값 : void
  */
 function getVenInfoNon(code, name){
     var strStrCd        = LC_S_STR.BindColVal;                                       // 점
     var strUseYn        = "Y";                                                       // 사용여부
     var strPumBunType   = "0";                                                       // 브랜드유형
     var strBizType      = "1";                                                       // 거래형태
     var strMcMiGbn      = "1";                                                       // 매출처/매입처구분
     var strBizFlag      = "";                                                        // 거래구분

     var rtnMap = setVenNmWithoutPop( "DS_O_RESULT", code, name, "1"
                                         ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                                         ,strBizFlag);
     if(rtnMap != null){
         return true; 
     }else
         return false;
 } 
 
  /**
   * checkValidation(Gubun)
   * 작 성 자     : 박래형
   * 작 성 일     : 2010-02-28
   * 개    요        : 조회조건 값 체크 
   * Gubun : Search, Save, Delete
   * return값 : void
   */
  function checkValidation(Gubun) {
       
       switch (Gubun) {

       case "Conf":      
           var intRowCount   = DS_IO_MASTER.CountRow;
           if(intRowCount > 0){
               for(var i=1; i <= intRowCount; i++){
                   
                   if(DS_IO_MASTER.NameValue(i, "CHECK1") == "T"){                  
                       var strCostCloseFlag  = DS_IO_MASTER.Namevalue(i, "COST_CLOSE_FLAG");     // 수입원가 확정여부
                       
                       var checkFlag  = checkYnFlag(i);
              
                       //마감여부체크
                       if(!closeCheck(i)){
                    	   return false;
                       }
                       
                       //확정시
                       if(g_strYNGbn == "Y"){ 
                           
                           if(checkFlag == "D"){                                //OFFER마감이 안되어있는 상태
                        	   showMessage(EXCLAMATION, OK, "USER-1000", "이미 수입원가산정 되었습니다.");    
                               //alert("OFFER 마감이  아닙니다.");
                               DS_IO_MASTER.RowPosition = i;
                               GR_MASTER.SetColumn("CHECK1");
                               GR_MASTER.Focus();
                               return false;
                               
                           }else if(checkFlag == "A"){                                //OFFER마감이 안되어있는 상태
                               showMessage(EXCLAMATION, OK, "USER-1183");     
                               //alert("OFFER 마감이  아닙니다.");
                               DS_IO_MASTER.RowPosition = i;
                               GR_MASTER.SetColumn("CHECK1");
                               GR_MASTER.Focus();
                               return false;
                               
                           }else if(checkFlag == "B"){                          //제경비 확정이 안되어있는 상태
                               showMessage(EXCLAMATION, OK, "USER-1184");     
                               //alert("제경비 확정이 아닙니다.");
                               DS_IO_MASTER.RowPosition = i;
                               GR_MASTER.SetColumn("CHECK1");
                               GR_MASTER.Focus();
                               return false;
                           }else if(checkFlag == "C"){                          //입고월과 확정월체크
                        	   showMessage(EXCLAMATION, OK, "USER-1186");     
                               //alert("제경비 확정이 아닙니다.");
                               DS_IO_MASTER.RowPosition = i;
                               GR_MASTER.SetColumn("CHECK1");
                               GR_MASTER.Focus();
                               return false;    
                           }
                       }else if(g_strYNGbn == "N"){                            
                           if(checkFlag == "E"){                                //OFFER마감이 안되어있는 상태
                               showMessage(EXCLAMATION, OK, "USER-1000", "이미 수입원가산정 취소되었습니다.");    
                               //alert("OFFER 마감이  아닙니다.");
                               DS_IO_MASTER.RowPosition = i;
                               GR_MASTER.SetColumn("CHECK1");
                               GR_MASTER.Focus();
                               return false;                               
                           }                    	   
                       }                       
                   }
               }
           }
           return true;
           break;       
       }     
  }
  
  /**
  * closeCheck()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-10
  * 개    요    : 저장시 일마감체크를 한다.
  * return값 : void
  */
  function closeCheck(row){
       var strStrCd         = DS_IO_MASTER.NameValue(row, "STR_CD");      // 점
       var strCloseDt       = strToday;               // 마감체크일자
       var strCloseTaskFlag = "PSTK";                 // 업무구분()
       var strCloseUnitFlag = "43";                   // 단위업무
       var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
       var strCloseFlag     = "M";                    // 마감구분(월마감:M)
      
       var closeFlag = getCloseCheck( "DS_O_RESULT", strStrCd , strCloseDt , strCloseTaskFlag 
                                     , strCloseUnitFlag , strCloseAcntFlag , strCloseFlag);
       
       if(closeFlag == "TRUE"){
           showMessage(EXCLAMATION, OK, "USER-1068", "수불월"," 제경비 경비 확정또는 확정취소");
           return false;
       }else{
           return true;
       }
  }
  
  /**
  * checkYnFlag(row)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-05-30
  * 개    요    : 저장시 마감(확정)여부 체크.
  * return값 : void
  */
  function checkYnFlag(row){
	  
	    var strStrCd      = DS_IO_MASTER.NameValue(row, "STR_CD");
	    var strOfferYm    = DS_IO_MASTER.NameValue(row, "OFFER_YM");
	    var strOfferSeqNo = DS_IO_MASTER.NameValue(row, "OFFER_SEQ_NO");
	
		var goTo       = "checkYnFlag" ;    
		var action     = "O";     
		var parameters = "&strStrCd="+encodeURIComponent(strStrCd)    
		               + "&strOfferYm="+encodeURIComponent(strOfferYm)     
		               + "&strOfferSeqNo="+encodeURIComponent(strOfferSeqNo);
		
		TR_DETAIL.Action="/dps/pord510.po?goTo="+goTo+parameters;  
		TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_RESULT=DS_O_RESULT)"; //조회는 O
		TR_DETAIL.Post();  

        var checkCloseFlag = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "CLOSE_FLAG");        //오퍼마감여부
        var checkExpncFlag = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EXPNC_CLOSE_FLAG");  //제경비확정여부
        var checkCostFlag  = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "COST_CLOSE_FLAG");   //원가확정여부
        var checkIpGoFlag  = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "YIPGO_FLAG");        //입고월과 확정월이 같은지 여부

        //alert("g_strYNGbn = " + g_strYNGbn);
        //alert("checkCostFlag = " + checkCostFlag);
        if(g_strYNGbn == "Y"){
        	if(checkCostFlag == "Y")
        	    return "D";
        	
        }else if(g_strYNGbn == "N"){
            if(checkCostFlag == "N")
                return "E";
        }
        
        
        if(checkCloseFlag == "N"){  // OFFER 마감여부
        	return "A";
        } 
        if(checkExpncFlag == "N"){  // 제경비확정여부
            return "B";
        }
        if(checkIpGoFlag == "N"){   // 입고월과 확정월이 같은지 여부
            return "C";
        }
        return "X";   //수입원가 산정 확정 할수 있는 상태
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

<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
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

<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid);
</script>

<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid);
</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
    
//alert("headerInsFlag캔로   :" + headerInsFlag)
    if(headerInsFlag){
        if (DS_IO_DETAIL.IsUpdated){
            if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
                return false;
            }else {
                headerInsFlag = false;
                return true;
            }
        }else{
            return true;
        }
    }
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
    var strStrCd      = DS_IO_MASTER.NameValue(row, "STR_CD");
    var strOfferYm    = DS_IO_MASTER.NameValue(row, "OFFER_YM");
    var strOfferSeqNo = DS_IO_MASTER.NameValue(row, "OFFER_SEQ_NO"); 
    var strSkuType    = DS_IO_MASTER.NameValue(row, "SKU_TYPE"); 
    
   if (row != 0) {
       if( bfListRowPosition == row)
           return;
       bfListRowPosition = row;  
       
       if(strOfferSeqNo != ""){
           getDetail(strStrCd,strOfferYm,strOfferSeqNo);
           if(inta == 0){  
               inta++;
           }else{
               setPorcCount("SELECT", DS_IO_DETAIL.CountRow);      
           }
       }
   }   

   if(strSkuType == '1'){      // 규격단품
       GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = false;
       GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
       GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;
       
   }else if(strSkuType == '2'){// 신선단품
       GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = false;
       GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
       GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;     
       
   }else if(strSkuType == '3'){// 의류단품
       GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = true;
       GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = true;
       GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = true;     
   }
   
   if(clickSORT)
       return;
</script>

<!--  DS_IO_MASTER 변경시 -->
<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>

    var strCostCloseFlag = DS_IO_MASTER.NameValue(row, "TMP_COST_CLOSE_FLAG");
    
    switch (colid) {
    case "CHECK1":
        if(strCostCloseFlag == "Y"){
            DS_IO_MASTER.NameValue(row, "TMP_COST_CLOSE_FLAG") = "N";
        }else if(strCostCloseFlag == "N"){
            DS_IO_MASTER.NameValue(row, "TMP_COST_CLOSE_FLAG") = "Y";          
        }
        break;
    }
</script>

<script language=JavaScript for=DS_IO_DETAIL event=OnRowPosChanged(row)>

if(clickSORT)
    return;
</script>



<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 전체 선택/해제 -->
<script language=JavaScript for=GR_MASTER
    event="OnHeadCheckClick(Col,Colid,bCheck)">     
    
    
    //헤더 전체 체크/체크해제 컨트롤
    if (Colid == "CHECK1") {
        if (bCheck == '1'){ // 전체체크
            for(var i=1; i<=DS_IO_MASTER.CountRow; i++){
                DS_IO_MASTER.NameValue(i, "CHECK1") = 'T';
               
            }
        }else{  // 전체체크해제
            for (var i=1; i<=DS_IO_MASTER.CountRow; i++){
                DS_IO_MASTER.NameValue(i, "CHECK1") = 'F';
            }
        }
    }

</script>


<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_S_STR event=OnSelChange()>
//  EM_O_OFFERNO.Text = "";
    EM_S_PB_CD.Text   = "";
    EM_S_PB_NM.Text   = "";
    EM_S_VEN_CD.Text  = "";
    EM_S_VEN_NM.Text  = "";
</script>


<!-- 조회시작일 변경시  -->
<script lanaguage=JavaScript for=EM_START_DT event=OnKillFocus()>
//    checkDateTypeYMD( EM_START_DT );
    
    var strSyyyymmdd = strToday.substring(0,6) + "01";
    checkDateTypeYMD( EM_START_DT, strSyyyymmdd );
</script>

<!-- 조회종료일 변경시  -->
<script lanaguage=JavaScript for=EM_END_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_END_DT );
</script>


<!-- 조회부 브랜드 KillFocus -->
<script language=JavaScript for=EM_S_PB_CD event=onKillFocus()>

    if(EM_S_PB_CD.Text != "")
        searchPumbunNonPop();
    else{
        EM_S_PB_CD.Text = "";
        EM_S_PB_NM.Text = ""        
    }
</script>

<!-- 조회부 협력사 KillFocus -->
<script language=JavaScript for=EM_S_VEN_CD event=onKillFocus()>

//getVenInfoNon();
    if(EM_S_VEN_CD.Text != "")
        getVenInfoNon(EM_S_VEN_CD, EM_S_VEN_NM);
    else{
        EM_S_VEN_CD.Text = "";  
        EM_S_VEN_NM.Text = "";      
    }    
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
<comment id="_NSID_"><object id="DS_O_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_COSTCD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
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

  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th class="point" width="70">점</th>
            <td width="300">
                 <comment id="_NSID_">
                    <object id=LC_S_STR classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1 width=140 align="absmiddle">
                    </object>
                </comment><script>_ws_(_NSID_);</script>
            </td>
            <th class="point" width="100">OFFER기간</th>
            <td colspan="3">
                <comment id="_NSID_">
                      <object id=EM_START_DT classid=<%=Util.CLSID_EMEDIT%>  width=120 tabindex=1 align="absmiddle">
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_START_DT)" align="absmiddle"/>
                ~
                <comment id="_NSID_">
                      <object id=EM_END_DT classid=<%=Util.CLSID_EMEDIT%>  width=120 tabindex=1 align="absmiddle">
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_END_DT)" align="absmiddle"/>
            </td>
          </tr>
           
          <tr>
            <th>OFFER NO</th>
            <td>
                <comment id="_NSID_">
                      <object id=EM_O_OFFERNO classid=<%=Util.CLSID_EMEDIT%>  width=285 tabindex=1 align="absmiddle">
                      </object>
                </comment><script> _ws_(_NSID_);</script>
            </td>
              <th>원가확정여부</th>
              <td colspan="3"><comment id="_NSID_"> <object
                  id=RD_S_CONF_FLAG classid=<%=Util.CLSID_RADIO%>
                  style="height: 20; width: 200" tabindex=1>
                  <param name=Cols value="3">
                  <param name=Format value="N^미확정,Y^확정" tabindex=1>
                  <param name=CodeValue value="N"> 
              </object> </comment> <script> _ws_(_NSID_);</script></td>
          </tr>
           
          <tr>
            <th>브랜드</th>
            <td>
                <comment id="_NSID_">
                      <object id=EM_S_PB_CD classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:searchPumbunPop();" align="absmiddle"/>
                <comment id="_NSID_">
                      <object id=EM_S_PB_NM classid=<%=Util.CLSID_EMEDIT%>  width=180 tabindex=1 align="absmiddle">
                      </object>
                </comment><script> _ws_(_NSID_);</script>
            </td>
            <th>협력사</th>
            <td colspan="3">
                <comment id="_NSID_">
                      <object id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM);" align="absmiddle"/>
                <comment id="_NSID_">
                      <object id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%>  width=190 tabindex=1 align="absmiddle">
                      </object>
                </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
<!-- -->          
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr>
     <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
            <tr>
                <td>
                    <comment id="_NSID_">
                        <OBJECT id=GR_MASTER width=100% height=220 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_IO_MASTER">
                        </OBJECT>
                    </comment><script>_ws_(_NSID_);</script>
                </td>
            </tr>
        </table>
     </td>
  </tr>
  <tr valign="top">
    <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
              <td height="5">
              </td>
          </tr>
          <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                    <tr>
                        <td>
                            <comment id="_NSID_">
                                <OBJECT id=GR_DETAIL width=100% height=220 classid=<%=Util.CLSID_GRID%>>
                                    <param name="DataID" value="DS_IO_DETAIL">
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
</body>
</html>

