<!-- 
/*******************************************************************************
 * 시스템명 : 협력사EDI > 발주/매입 > 규격단품 매입발주 등록
 * 작 성 일 : 2011.08.14
 * 작 성 자 : 김 경 은
 * 수 정 자 : 
 * 파 일 명 : eord1060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 규격단품으로 관리하는 상품의 매입/반품 발주 등록한다.
 * 이    력 :
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="kr.fujitsu.ffw.base.BaseProperty,kr.fujitsu.ffw.util.String2,kr.fujitsu.ffw.control.ActionForm"%>
<%@ page import="ecom.util.Util"%>
<%@ page import="java.util.*"%>
<%@ page import="sun.misc.FormattedFloatingDecimal.Form"%>
<%@ page import="ecom.vo.SessionInfo2"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<%
    String dir = request.getContextPath();

    SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
    String USER_ID = sessionInfo.getUSER_ID();                      // 사용자아이디
    String STR_CD  = sessionInfo.getSTR_CD();                       // 점코드
    String STR_NM  = sessionInfo.getSTR_NM();                       // 점명
    String VEN_CD  = sessionInfo.getVEN_CD();                       // 협력사코드
    String VEN_NM  = sessionInfo.getVEN_NAME();                     // 협력사명
    String GB      = sessionInfo.getGB();                           // 1. 협력사     2.브랜드
    String pumbunCd          = sessionInfo.getPUMBUN_CD();      //브랜드코드
    String pumbunNm          = sessionInfo.getPUMBUN_NAME();    //브랜드명
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링</title>
<link href="<%=dir%>/css/ds.css" rel="stylesheet" type="text/css" />
<script language="javascript"  src="<%=dir%>/js/common.js"   type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/popup.js"    type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/message.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/global.js"   type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/gauce.js"    type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var dtlCount          = 0;                              // 상세 Row 수
var dtlIdCount        = 0;                              // 상세 생성된 ID Count
var venRoundFlag      = "";                             // 협력사 반올림 구분
var pumbunCd    = '<%=pumbunCd%>';

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자    : 김경은
 * 작 성 일     : 2011-08-14
 * 개    요        : 해당 페이지 LOAD 시  
 * return값 : void
 */
 function doInit(){
    
     getTodayDB();              // 현재날짜
     getVenRound();             // 협력사별 반올림 구분
     btn_Control();             // 상단버튼 Control
     setMstObjControl(false);   // Master 활성화/비활성화
     
     initDateText('SYYYYMMDD', 'start_date');      // 조회시작일
     initDateText('TODAY'    , 'end_date');        // 조회종료일
     
     getPumbunCombo('<%=STR_CD%>', '<%=VEN_CD%>', 's_pumbun_cd', 'Y', '1', pumbunCd);        // 브랜드 조회조건 
     getSelectCombo('D' ,'P214' ,'s_date_type'      ,'N');                         // 기준일
     getSelectCombo('D' ,'P207' ,'s_slip_proc_falg' ,'Y');                         // 전표상태
     
     getPumbunCombo('<%=STR_CD%>', '<%=VEN_CD%>', 'pumbun_cd', 'N', '1', pumbunCd);           // 브랜드 입력 

 } 

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search()
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
 * 작 성 일 : 2011-08-10
 * 개    요    : 조회시 필수 조회조건을 체크한 후 조회한다.
 * return : void
 */ 
 function btn_Search(){
      // Validation Check
      if(!checkValidation("Search")) 
          return;
 
      // 리스트 조회
      frm.chkAll.checked = false;    // 전체선택 초기화
      getList();
     
 }

/**
 * btn_New()
 * 작 성 자    : 김경은
 * 작 성 일     : 2011-02-15
 * 개    요        : 신규버튼 클릭 (DS_IO_MASTER의 ROW 추가)
 * return값 : void
 */
 function btn_New() {
      var nextDate = addDate("d", 1, strToday);
      clearData();                                      // 전체 데이터 Clear
       
      frm.reg_date.value          = "";                 // 전표등록일자
      setMstObjControl(true);                           // Master 활성화/비활성화
      
      frm.ven_cd.value            = "<%=VEN_CD%>";      // 협력사
      frm.ven_nm.value            = "<%=VEN_NM%>";      // 협력사명
      frm.aft_ord_flag_nm.value   = "사전전표";          // 사전사후구분명
      frm.aft_ord_flag.value      = "0";                 // 사전사후구분
      setRadioValue("slip_flag" ,"A");                   // 전표구분
      frm.ord_flag_nm.value       = "일반";              // 발주구분명
      frm.ord_flag.value          = "0";                 // 발주구분
      frm.ord_own_flag.value      = "1";                 // 발주주체
      frm.ord_own_flag_nm.value   = "EDI발주";           // 발주주체명
      initDateText("TODAY"  ,"ord_dt");                  // 발주일
      frm.deli_dt.value           = nextDate;            // 납품예정일
      frm.prc_app_dt.value        = nextDate;            // 가격적용일
      //frm.pumbun_cd.selectedIndex = 1;                  // 브랜드
      
      frm.slip_flag[0].focus();
 
     //setDetailObject(true);
 }

/**
 * btn_Delete()
 * 작 성 자     : 김경은
 * 작 성 일     : 2011-02-16
 * 개    요        : 삭제버튼 클릭 
 * return값 : void
 */
 function btn_Delete() {
        
     // 삭제할 데이터 없는 경우
     if (frm.reg_date.value == "99999999"){
         showMessage(EXCLAMATION, OK, "USER-1019");
         return;
     }
         
     if(!checkValidation("Delete"))
        return;
     
     // 전표상태체크
     chkSlipProdStat("Delete");
     
 }

/**
 * btn_Save()
 * 작 성 자     : 김경은
 * 작 성 일     : 2011-08-16
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
 function btn_Save() {
     if(frm.reg_date.value == "99999999"){
          //저장할 내용이 없습니다
          showMessage(EXCLAMATION, OK, "USER-1028");
          return; 
     }
     
     if(!checkValidation("Save"))
       return;
     
     //Check된 Row삭제(단품코드가 입력 안 된 Row삭제)
     delDetailRow();                    
     if(document.getElementsByName("d_check").length <= 0){
         showMessage(EXCLAMATION, OK, "GAUCE-1000", "상세데이터 등록후 저장하십시오."); 
         enableControl(frm.img_add  ,true);
         return;
     }
     
     // 전표상태체크
     chkSlipProdStat("Save");
     
 }

/**
 * btn_Excel()
 * 작 성 자     : FKL
 * 작 성 일     : 2011-08-25
 * 개    요        : 엑셀로 다운로드
 * return값 : void
 */
 function btn_Excel() {
 
 }

/**
 * btn_Print()
 * 작 성 자     : FKL
 * 작 성 일     : 2011-08-25
 * 개    요        : 페이지 프린트 인쇄
 * return값 : void
 */
 function btn_Print() {
     
 }

/**
 * btn_Conf()
 * 작 성 자     : 
 * 작 성 일     : 2011-08-25
 * 개    요        : 확정 처리
 * return값 : void
 */

 function btn_Conf() {
 
 }

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * getObjArrData(objNm)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-20
 * 개    요 :  배열Object데이터 String변환
 * return값 : void
 */ 
 function getObjArrData(objNm){
     var tmpVal = document.getElementsByName(objNm);
     var rtnVal = ""; 
     var gb     = tmpVal.length>1 ? "/":"" ;
     for(var i = 0; i < tmpVal.length; i++){ 
         rtnVal += removeComma2(tmpVal[i].value) + gb;
     }
     return rtnVal;
 }

/**
 * getParam()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-20
 * 개    요 :  param 생성
 * return값 : void
 */ 
 function getParam(){
     var str = "";
     str = "&goTo=save"
         + "&str_cd="            + '<%=STR_CD%>'                   // 전표번호
         + "&slip_no="           + frm.slip_no.value               // 전표번호
         + "&slip_proc_stat_nm=" + frm.slip_proc_stat_nm.value     // 전표상태명
         + "&slip_proc_stat=+"   + frm.slip_proc_stat.value        // 전표상태
         + "&slip_flag="         + getRadioValue("slip_flag")      // 전표구분
         + "&aft_ord_flag_nm="   + frm.aft_ord_flag_nm.value       // 사전사후구분명
         + "&aft_ord_flag="      + frm.aft_ord_flag.value          // 사전사후구분
         + "&pumbun_cd="         + frm.pumbun_cd.value             // 브랜드
         + "&ord_flag_nm="       + frm.ord_flag_nm.value           // 발주구분명
         + "&ord_flag="          + frm.ord_flag.value              // 발주구분
         + "&buyer_cd="          + frm.buyer_cd.value              // 바이어ID
         + "&buyer_nm="          + frm.buyer_nm.value              // 바이어명
         + "&ven_cd="            + frm.ven_cd.value                // 협력사
         + "&ven_nm="            + frm.ven_nm.value                // 협력사명
         + "&biz_type="          + frm.biz_type.value              // 거래형태
         + "&biz_type_nm="       + frm.biz_type_nm.value           // 거래형태명
         + "&tax_flag="          + frm.tax_flag.value              // 과세구분
         + "&tax_flag_nm="       + frm.tax_flag_nm.value           // 과세구분명
         + "&ord_dt="            + frm.ord_dt.value                // 발주일
         + "&conf_dt="           + frm.conf_dt.value               // 확정일
         + "&ord_own_flag="      + frm.ord_own_flag.value          // 발주주체
         + "&ord_own_flag_nm="   + frm.ord_own_flag_nm.value       // 발주주체명
         + "&deli_dt="           + frm.deli_dt.value               // 납품예정일
         + "&prc_app_dt="        + frm.prc_app_dt.value            // 가격적용일
         + "&chk_dt="            + frm.chk_dt.value                // 검품확정일
         + "&tot_qty="           + frm.tot_qty.value               // 발주총수량
         + "&tot_cost_amt="      + frm.tot_cost_amt.value          // 원가금액합
         + "&tot_sale_amt="      + frm.tot_sale_amt.value          // 매가금액합
         + "&gap_tot_amt="       + frm.gap_tot_amt.value           // 차익액합
         + "&gap_rate="          + frm.gap_rate.value              // 차익율
         + "&remark="            + frm.remark.value                // 비고
         + "&reg_date="          + frm.reg_date.value              // 전표등록일자
         + "&bottle_slip_yn="    + frm.bottle_slip_yn.value        // 공병여부
         + "&vat_tamt="          + frm.vat_tamt.value              // 부가세합
         + "&dtlCnt="            + dtlCount                        // 상세건수
         
         + "&d_strCd="           + getObjArrData("d_strCd")        // 점
         + "&d_slip_no="         + getObjArrData("d_slip_no")
         + "&d_pumbunCd="        + getObjArrData("d_pumbunCd")
         + "&d_venCd="           + getObjArrData("d_venCd")
         + "&d_slipFlag="        + getObjArrData("d_slipFlag")
         + "&d_pummokCd="        + getObjArrData("d_pummokCd")
         + "&d_skuNm="           + getObjArrData("d_skuNm")
         + "&d_ordUnitCd="       + getObjArrData("d_ordUnitCd")
         + "&d_ordUnitNm="       + getObjArrData("d_ordUnitNm")
         + "&d_stkQty="          + getObjArrData("d_stkQty")
         + "&d_avgSaleQty="      + getObjArrData("d_avgSaleQty")
         + "&d_avgSaleAmt="      + getObjArrData("d_avgSaleAmt")
         + "&d_newCostPrc="      + getObjArrData("d_newCostPrc")
         + "&d_newSalePrc="      + getObjArrData("d_newSalePrc")
         + "&d_mgRate="          + getObjArrData("d_mgRate")
         + "&d_bottleCd="        + getObjArrData("d_bottleCd")
         + "&d_bizType="         + getObjArrData("d_bizType")
         + "&d_costZero="        + getObjArrData("d_costZero")
         + "&d_saleZero="        + getObjArrData("d_saleZero")
         + "&d_newGapRate="      + getObjArrData("d_newGapRate")
         + "&d_ord_seq_no="      + getObjArrData("d_ord_seq_no") 
         + "&d_vatAmt="          + getObjArrData("d_vatAmt")
         + "&d_skuCd="           + getObjArrData("d_skuCd")
         + "&d_ordQty="          + getObjArrData("d_ordQty")
         + "&d_newCostAmt="      + getObjArrData("d_newCostAmt")
         + "&d_newSaleAmt="      + getObjArrData("d_newSaleAmt")
         + "&d_newGapAmt="       + getObjArrData("d_newGapAmt")
         + "&d_orgSkuCd="        + getObjArrData("d_orgSkuCd")
         + "&del_detail="        + frm.del_detail.value;
         
     return str;
 }
 
/**
 * getTodayDB()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-08
 * 개    요 :  시스템 일자
 * return값 : void
 */ 
 function getTodayDB(){
     var param = "&goTo=getTodayDB";
     
     <ajax:open callback="on_getTodayDBXML" 
         param="param" 
         method="POST" 
         urlvalue="/edi/ccom001.cc"/>
     
      <ajax:callback function="on_getTodayDBXML">
      strToday =  rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : String(rowsNode[0].childNodes[0].childNodes[0].nodeValue);
      </ajax:callback>
 }
 
/**
 * btn_Control()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-08
 * 개    요 :  버튼 Enable Control
 * return값 : void
 */ 
 function btn_Control(){
      /* 버튼비활성화  */
      enableControl(frm.search,true);   //신규
      enableControl(frm.newrow,true);   //신규
      enableControl(frm.del,true);      //삭제
      enableControl(frm.save,true);     //저장
      enableControl(frm.excel,false);   //엑셀
      enableControl(frm.prints,false);  //프린터   
 }
 
/**
 * setMstObjControl(flag)
 * 작 성 자     : 김경은
 * 작 성 일     : 2011-08-11
 * 개    요        : 마스터 Object의 활성화/비활성화를 제어한다.
 * return값 : void
 */
 function setMstObjControl(flag){
      
      setObjEnable("pumbun_cd"         ,flag);          // 브랜드
      setObjEnable("ord_dt"            ,flag);          // 발주일
      enableControl(frm.img_ord_dt     ,flag);          // 발주일 달력버튼  
      setObjEnable("deli_dt"           ,flag);          // 납품예정일
      enableControl(frm.img_deli_dt    ,flag);          // 발주일 달력버튼  
      setObjEnable("prc_app_dt"        ,flag);          // 가격적용일
      enableControl(frm.img_prc_app_dt ,flag);          // 가격적용일 달력버튼
      
      var slip_proc_stat  = frm.slip_proc_stat.value;   // 전표진행상태
      var reg_date        = frm.reg_date.value;         // 전표등록일자
      
      if(reg_date == "" || slip_proc_stat == "00"){
          setObjEnable("remark"      ,true);            // 비고
          enableControl(frm.img_add  ,true);            // 행추가버튼
          enableControl(frm.img_del  ,true);            // 행추가버튼
          if(reg_date == ""){
              for(var i = 0; i < frm.elements("slip_flag").length; i++){   // 전표구분  
                  frm.elements("slip_flag")[i].disabled = false;
              }
          }else{
              for(var i = 0; i < frm.elements("slip_flag").length; i++){   // 전표구분  
                  frm.elements("slip_flag")[i].disabled = true;
              }
          }
      }else{
          setObjEnable("remark"      ,false);           
          enableControl(frm.img_add  ,false);           
          enableControl(frm.img_del  ,false);           
          for(var i = 0; i < frm.elements("slip_flag").length; i++){  
              frm.elements("slip_flag")[i].disabled = true;
          }
      }
 }  
 
/**
 * setDtlObjControl(flag)
 * 작 성 자     : 김경은
 * 작 성 일     : 2011-08-11
 * 개    요        : 상세 Object의 활성화/비활성화를 제어한다.
 * return값 : void
 */
 function setDtlObjControl(){
      var slip_proc_stat  = frm.slip_proc_stat.value;   // 전표진행상태
      var reg_date        = frm.reg_date.value;         // 전표등록일자
      var flag            = "";                                                
      var chkLen          = 0;                          // d_check Length
      
      if(dtlCount == 0) // 상세내역이 없을 경우
         return;
          
      if(reg_date == "" || slip_proc_stat == "00")
          flag = false;
      else
          flag = true;
      
      frm.chkAll.disabled           = flag;    // 전체선택 초기화
      var len = document.getElementsByName("d_check").length;
      for(var i=0; i<len; i++){
          document.getElementById("d_check"+(i)).disabled  = flag;            // CHKECK
          document.getElementById("d_skuCd"+(i)).disabled  = flag;            // 단품
          document.getElementById("d_ordQty"+(i)).disabled = flag;            // 발주수량
          document.getElementById("skuCdImg"+(i)).disabled = flag;            // 단품팝업버튼
     
          var saleZero = document.getElementById("d_saleZero"+(i)).value;     // 매가단가 0 여부 (Y:0, N:0아님) 
          if(saleZero == "Y"){  // 매가단가가 0일 경우 수정가능
              document.getElementById("d_newSalePrc"+(i)).disabled = false;   // 매가단가
          }else{
              document.getElementById("d_newSalePrc"+(i)).disabled = true;            
          }
      }
 }  
 
/**
 * clearData()
 * 작 성 자     : 김경은
 * 작 성 일     : 2011-08-11
 * 개    요        : 데이터를 지운다.
 * return값 : void
 */
 function clearData(){
      frm.slip_no.value           = "";           // 전표번호
      frm.slip_proc_stat_nm.value = "";           // 전표상태
      frm.slip_proc_stat.value    = "";           // 전표상태
      frm.slip_flag.value         = "";           // 전표구분
      frm.aft_ord_flag_nm.value   = "";           // 사전사후구분명
      frm.aft_ord_flag.value      = "";           // 사전사후구분
      frm.pumbun_cd.value         = "";           // 브랜드
      frm.ord_flag_nm.value       = "";           // 발주구분명
      frm.ord_flag.value          = "";           // 발주구분
      frm.buyer_cd.value          = "";           // 바이어ID
      frm.buyer_nm.value          = "";           // 바이어명
      frm.ven_cd.value            = "";           // 협력사
      frm.ven_nm.value            = "";           // 협력사명
      frm.biz_type.value          = "";           // 거래형태
      frm.biz_type_nm.value       = "";           // 거래형태명
      frm.tax_flag.value          = "";           // 과세구분
      frm.tax_flag_nm.value       = "";           // 과세구분명
      frm.ord_dt.value            = "";           // 발주일
      frm.conf_dt.value           = "";           // 확정일
      frm.ord_own_flag.value      = "";           // 발주주체
      frm.ord_own_flag_nm.value   = "";           // 발주주체명
      frm.deli_dt.value           = "";           // 납품예정일
      frm.prc_app_dt.value        = "";           // 가격적용일
      frm.chk_dt.value            = "";           // 검품확정일
      frm.tot_qty.value           = "";           // 발주총수량
      frm.tot_cost_amt.value      = "";           // 원가금액합
      frm.tot_sale_amt.value      = "";           // 매가금액합
      frm.gap_tot_amt.value       = "";           // 차익액합
      frm.gap_rate.value          = "";           // 차익율
      frm.remark.value            = "";           // 비고
      frm.reg_date.value          = "99999999";   // 전표등록일자
      frm.bottle_slip_yn.value    = "";           // 공병여부
      frm.vat_tamt.value          = "";           // 부가세합
      frm.chkAll.checked          = false;        // 전체선택 초기화
      frm.del_detail.value        = "";           // 상세삭제 Row (ord_seq_no)
      dtlCount                    = 0;            // 상세건수
      dtlIdCount                  = 0;            // 상세 ID Count
      //setRadioValue("slip_flag", "");           // 전표구분
      // 상세 초기화
      var content = "";
      content =  "<table width='1005' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_detail'>";
      content += "</table>";
      document.getElementById("divDetailContent").innerHTML = content;
 }  
 
/**
 * getPumbunCombo()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-10
 * 개    요    : 점별브랜드콤보
 *          strcd   : 점코드
 *          vencd   : 협력사코드
 *          target  : 진행 할 항목
 *          allGB   : Y 전체 포함,N 전체 포함 안함
 *          skuFlag : 단품구분 (1: 단품조건, 2: 비단품조건)
 * return : void
 */ 
 function getPumbunCombo(strCd, venCd, target, allGB, skuFlag, pumbunCd){
      var param = "";
     
      param = "&goTo=getPumbunSTK&strcd=" + strCd
               + "&vencd="                + venCd
               + "&skuFlag="              + skuFlag
               + "&pumbunCd="             + pumbunCd
               ;
     
     <ajax:open callback="on_loadedXML" 
         param="param" 
         method="POST" 
         urlvalue="/edi/ccom001.cc"/>
     
     <ajax:callback function="on_loadedXML">
        
        var pumbun    = document.getElementById(target);   // object
        var optLen    = 0;                                 // option Length
        var pumbun_cd = "";                                // 브랜드
        var pumbun_nm = "";                                // 브랜드명
        
        if( allGB == "Y" )
            pumbun.options[optLen] = new Option('전체', '');
        else
            pumbun.options[optLen] = new Option('', '');
        
        optLen = pumbun.options.length;
        if( rowsNode.length > 0 ){
            for( i =0; i < rowsNode.length; i++){
                pumbun_cd = rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                pumbun_nm = rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                pumbun.options[optLen+i] = new Option(pumbun_nm, pumbun_cd);
            }
        } 
        
     </ajax:callback>
 }
 
/**
 * getSelectCombo()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-10
 * 개    요    : 공통코드 조회
 *          syspat  : PART
 *          compart : COMPART
 *          target  : 진행 할 항목
 *          allGB   : Y 전체 포함,N 전체 포함 안함
 * return : void
 */ 
 function getSelectCombo(syspat,compart,target,allGB){
     
     var param = "&goTo=getEtcCode&syspat="+syspat+"&compart="+compart;
     <ajax:open callback="on_SelectComboXML" 
         param="param" 
         method="POST" 
         urlvalue="/edi/ccom001.cc"/>
     
     <ajax:callback function="on_SelectComboXML"> 
     
     var etcCombo = document.getElementById(target);   // object
     var optLen   = 0;                                 // option Length
     var code     = "";                                // 코드
     var name     = "";                                // 명
     
     if( allGB == "Y" )
         etcCombo.options[optLen] = new Option('전체', '');
          
     optLen = etcCombo.options.length;
     if( rowsNode.length > 0 ){
         for( i =0; i < rowsNode.length; i++){
             code = rowsNode[i].childNodes[0].childNodes[0].nodeValue;
             name = rowsNode[i].childNodes[1].childNodes[0].nodeValue;
             etcCombo.options[optLen+i] = new Option(name, code);
         }
     } 
     
     </ajax:callback>
 }
  
/**
 * checkValidation()
 * 작 성 자     : 김경은
 * 작 성 일     : 2011-08-10
 * 개    요        : Validation Check
 * return값 : void
 */
 function checkValidation(Gubun){
      switch (Gubun) {
      // 조회
      case "Search": 
          var strCd      = frm.s_str_cd.value;                       // 점
          var venCd      = frm.s_ven_cd.value;                       // 협력사
          var start_date = getRawData(trim(frm.start_date.value));   // 조회시작일
          var end_date   = getRawData(trim(frm.end_date.value));     // 조회종료일
                   
          if( strCd == "" ){
              showMessage(INFORMATION, OK, "USER-1003", "점");
              frm.strCd.focus();
              return false;
          }
       
          if( venCd == "" ){
              showMessage(INFORMATION, OK, "USER-1003", "협력사코드");
              frm.venCd.focus();
              return false;
          }
              
          if( start_date == "" ){
              showMessage(INFORMATION, OK, "USER-1003", "조회시작일");
              frm.start_date.focus();
              return false;
          }
          
          if( end_date == "" ){
              showMessage(INFORMATION, OK, "USER-1003", "조회종료일");
              frm.end_date.focus();
              return false;
          }
              
          //조회일자 정합성 체크
          if (start_date > end_date) {  //시작일은 종료일보다 작아야 합니다.
              showMessage(StopSign, OK, "USER-1015");
              frm.start_date.focus();
              return false;
          }
          break;
          
      // 저장
      case "Save":
          var pumbun_cd  = frm.pumbun_cd.value;                        // 브랜드
          var ven_cd     = frm.ven_cd.value;                           // 협력사
          var ord_dt     = getRawData(trim(frm.ord_dt.value));         // 발주일
          var deli_dt    = getRawData(trim(frm.deli_dt.value));        // 납품예정일
          var prc_app_dt = getRawData(trim(frm.prc_app_dt.value));     // 가격적용일
          var remark     = frm.remark.value;                           // 비고
          var reg_date   = frm.reg_date.value;                         // 등록일자
          
          if(pumbun_cd == ""){
              showMessage(EXCLAMATION, OK, "USER-1002", "브랜드");
              frm.pumbun_cd.focus();
              return false;
          }
          
          // 존재하는 브랜드 코드인지 확인한다.
          pumbunValCheck();
       
          if(ven_cd == ""){
              showMessage(EXCLAMATION, OK, "USER-1002", "협력사");
              frm.ven_cd.focus();
              return false;
          }
          if(ord_dt == ""){
              showMessage(EXCLAMATION, OK, "USER-1002", "발주일");
              frm.ord_dt.focus();
              return false;
          }
          if(reg_date == ""){
              if(strToday > ord_dt){
                  showMessage(EXCLAMATION, OK, "USER-1180", "발주일");
                  frm.ord_dt.focus();
                  return false;
              }
          }
          if(deli_dt == ""){
              showMessage(EXCLAMATION, OK, "USER-1002", "납품예정일");
              frm.deli_dt.focus();
              return false;
          }
          if(ord_dt > deli_dt){
              showMessage(EXCLAMATION, OK, "USER-1020", "납품예정일","발주일");
              frm.deli_dt.focus();
              return false;
          } 
          if(prc_app_dt == ""){
              showMessage(EXCLAMATION, OK, "USER-1002", "가격적용일");
              frm.prc_app_dt.focus();
              return false;
          }
          if(deli_dt > prc_app_dt){
              showMessage(EXCLAMATION, OK, "USER-1020", "가격적용일","납품예정일");
              frm.prc_app_dt.focus();
              return false;
          } 
          if(getByteValLength(remark) > 100){
              showMessage(EXCLAMATION , OK, "USER-1020" , "비고", "100Byte");
              frm.remark.focus();
              return false;
          }
          
          // 상세(단품)정보 Validation Check
          if(!checkValidationDtl())
              return false;
          
          break;
         
      // 삭제
      case "Delete":
          var strRegDate      = frm.reg_date.value;  
          var strSlipProcStat = frm.slip_proc_stat.value; 
          if(strSlipProcStat != "00"){
              showMessage(EXCLAMATION, OK, "USER-1160"); 
              return false;
          }
        
          if(strRegDate != strToday){
              showMessage(EXCLAMATION, OK, "USER-1170");
              return false;
          }
      }
      return true; 
 }

/**
 * checkValidationDtl()
 * 작 성 자     : 김경은
 * 작 성 일     : 2011-08-10
 * 개    요        : Validation Check (상세)
 * return값 : void
 */
 function checkValidationDtl(){
     var intRowCount = document.getElementsByName("d_check").length;
     for(var i=0; i < intRowCount; i++){
         var strSkuCd      = document.getElementsByName("d_skuCd")[i].value;
         var intQty        = document.getElementsByName("d_ordQty")[i].value;
         var intNewCostPrc = document.getElementsByName("d_newCostPrc")[i].value;
         var intNewSalePrc = document.getElementsByName("d_newSalePrc")[i].value;
         var fltNewGapRate = document.getElementsByName("d_newGapRate")[i].value;
         var strBottleCd   = document.getElementsByName("d_bottleCd")[i].value;

         // 단품코드가 없을경우
         if(strSkuCd.length <= 0){      
             document.getElementsByName("d_check")[i].checked = true;
             continue; 
         }
         // 존재하는 단품 코드인지 확인한다.
         skuValCheck(i, "0");

         // 중복체크
         var dupRow = dupCheck("d_skuCd");
         if (dupRow > 0) {
             showMessage(EXCLAMATION, OK,  "USER-1044", dupRow+1);
             setfocus("d_skuCd", dupRow);
             return false;
         }
         if(intQty <= 0){
             showMessage(EXCLAMATION, OK, "USER-1008", "발주수량", "0");
             setfocus("d_ordQty", i);
             return false;
         }
         if(intNewSalePrc <= 0){
             showMessage(EXCLAMATION, OK, "USER-1008", "매가단가", "0");
             setfocus("d_newSalePrc", i);
             return false;
         }
         if(intNewCostPrc <= 0){
             showMessage(EXCLAMATION, OK, "USER-1008", "원가단가", "0");
             setfocus("d_newCostPrc", i);
             return false;
         }
         if(fltNewGapRate.lenght <= 0){
             showMessage(EXCLAMATION, OK, "USER-1003", "차익율");
             setfocus("d_newGapRate", i);
             return false;
         }
         
         document.getElementsByName("d_check")[i].checked= false;
         
         // 공병전표여부 세팅
         if(strBottleCd != "")
             frm.bottle_slip_yn.value = "Y";
         else
             frm.bottle_slip_yn.value = "N";
     }
     return true;
 }
 
/**
 * getList()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-10
 * 개    요   : 리스트 조회
 * return : void
 */
 function getList(){
     var strCd        = frm.s_str_cd.value;                 // 점
     var venCd        = frm.s_ven_cd.value;                 // 협력사
     var pumbunCd     = frm.s_pumbun_cd.value;              // 브랜드
     var slipProcFlag = frm.s_slip_proc_falg.value;         // 전표상태
     var dateType     = frm.s_date_type.value;              // 기준일
     var startDate    = frm.start_date.value;               // 조회시작일
     var endDate      = frm.end_date.value;                 // 조회종료일
     var slipFlag     = getRadioValue("s_slip_flag");       // 전표구분
     var slipNo       = frm.s_slip_no.value;                // 전표번호
     
     var param        = "&goTo=getList"
                      + "&strCd="         + strCd
                      + "&venCd="         + venCd
                      + "&pumbunCd="      + pumbunCd
                      + "&slipProcFlag="  + slipProcFlag
                      + "&dateType="      + dateType
                      + "&startDate="     + startDate
                      + "&endDate="       + endDate
                      + "&slipFlag="      + slipFlag
                      + "&slipNo="        + slipNo;
     
     <ajax:open callback="on_getListXML" 
     
         param   ="param" 
         method  ="POST" 
         urlvalue="/edi/eord106.eo"/>
     
     <ajax:callback function="on_getListXML"> 
     
     document.all.divListTitle.scrollLeft     = 0;
     document.all.divListContent.scrollLeft   = 0;
     document.all.divDetailTitle.scrollLeft   = 0;
     document.all.divDetailContent.scrollLeft = 0;
     
     var tmpArr = new Array(); 
     var content =  "";
     frm.last_row.value = -1;
     if( rowsNode.length > 0 ){
         content =  "<table width='500' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_list'>";
         for( var i = 0; i < rowsNode.length; i++ ){
             for( var j = 0; j < rowsNode[i].childNodes.length; j++ ){
                 tmpArr[j] = rowsNode[i].childNodes[j].childNodes[0].nodeValue == "null" ? "" : String(rowsNode[i].childNodes[j].childNodes[0].nodeValue);
             }
             // 조회내용리스트 스크립트 생성
             content += setList(i, tmpArr);
         }
         content += "</table>";
         document.getElementById("divListContent").innerHTML = content;
         
         setRowBgColor(-1, 6);                       // 조회시 첫번째 로우 색깔 변경
         getMaster(0);                               // Master Data 조회
         setPorcCount("SELECT", rowsNode.length);
     }else{
         content =  "<table width='500' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_list'>";
         content += "</table>";
         document.getElementById("divListContent").innerHTML = content;
         clearData();
         content =  "<table width='1005' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_detail'>";
         content += "</table>";
         document.getElementById("divDetailContent").innerHTML = content;
         setMstObjControl(false);        // Master 활성화/비활성화
         setDtlObjControl();             // Detail 활성화/비활성화
     }
     
     </ajax:callback>
 }

/**
 * getMaster(row)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-12
 * 개    요   : 마스터 조회
 *         row : 선택 Row
 * return: void
 */
 function getMaster(row){
     var strCd   = document.getElementById("strCd"+row).value;         // 점
     var slip_no = document.getElementById("slip_no"+row).value;;      // 전표번호
     
     var param   = "&goTo=getMaster"
                 + "&strCd="         + strCd
                 + "&slipNo="        + slip_no;
     
     <ajax:open callback="on_getMasterXML" 
         param    ="param" 
         method   ="POST" 
         urlvalue ="/edi/eord106.eo"/>
     
     <ajax:callback function="on_getMasterXML"> 
     
     var tmpArr = new Array(); 
     if( rowsNode.length > 0 ){
         for( var i = 0; i < rowsNode.length; i++ ){
             for( var j = 0; j < rowsNode[i].childNodes.length; j++ ){
                 tmpArr[j] = rowsNode[i].childNodes[j].childNodes[0].nodeValue == "null" ? "" : String(rowsNode[i].childNodes[j].childNodes[0].nodeValue);
             }
         }
         setMaster(tmpArr);        // Master 화면세팅
         getDetail(row);           // Detail Data 조회(단품정보)
     }
     
     </ajax:callback>
 }

/**
 * getDetail(row)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-12
 * 개    요   : 마스터 조회
 *         row : 선택 Row
 * return: void
 */
 function getDetail(row){
     var strCd          = document.getElementById("strCd"+row).value;                // 점
     var slip_no        = document.getElementById("slip_no"+row).value;              // 전표번호
     
     var param   = "&goTo=getDetail"
                 + "&strCd="         + strCd
                 + "&slipNo="        + slip_no;
     
     <ajax:open callback="on_getDetailXML" 
         param    ="param" 
         method   ="POST" 
         urlvalue ="/edi/eord106.eo"/>
     
     <ajax:callback function="on_getDetailXML"> 
     
     var tmpArr  = new Array(); 
     var content =  "";
     dtlCount    = 0;
     dtlIdCount  = 0;
     frm.del_detail.value = "";     // 삭제된 상세(ord_seq_no)
     if( rowsNode.length > 0 ){
         content =  "<table width='1005' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_detail'>";
         for( var i = 0; i < rowsNode.length; i++ ){
             for( var j = 0; j < rowsNode[i].childNodes.length; j++ ){
                 tmpArr[j] = rowsNode[i].childNodes[j].childNodes[0].nodeValue == "null" ? "" : String(rowsNode[i].childNodes[j].childNodes[0].nodeValue);
             }
             // 조회내용리스트 스크립트 생성
             content += setDetail(i, tmpArr);
         }
         content += "</table>";
         document.getElementById("divDetailContent").innerHTML = content;
         dtlCount   = rowsNode.length;   // 상세정보(단품)의 전체 Row수
         dtlIdCount = rowsNode.length;   // 상세 ID Count 
         setMstObjControl(false);        // Master 활성화/비활성화
         setDtlObjControl();             // Detail 활성화/비활성화
     }
     
     </ajax:callback>
 }

/**
 * setDetail(row, tmpArr)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-10
 * 개    요   : 상세(단품) 조회내용 리스트 생성 
 * return : void
 */
 function setDetail(row, tmpArr){
     
     var tmpContent = "";
     var col        = 0;
     // tmpArr[]
     //  점[0]             ,전표번호[1]      ,전표상세번호[2]     ,품목코드[3]   ,단품코드[4]    
     // ,단품명[5]         ,발주단위[6]      ,발주단위명[7]       ,신차익액[8]   ,신차익율[9]    
     // ,발주시점재고[10]  ,일평균판매량[11]  ,일평균판매금액[12]  ,발주수량[13]  ,신원가단가[14]   
     // ,신원가금액[15]    ,신매가단가[16]    ,신매가금액[17]     ,브랜드코드[18]  ,협력사코드[19]   
     // ,전표구분[20]      ,마진율[21]        ,이전단품코드[22]   ,부가세[23]    ,공병단브랜드호[24]  
     // ,거래형태[25]      ,원가0여부[26]     ,매가0여부[27]
 
     tmpContent += "<tr>";
     tmpContent += "     <td class='r1' width='35' id='d_no'>"+(row+1)+"</td>";
     tmpContent += "     <td class='r1' width='25'><input type='checkbox' name='d_check'  id='d_check"+row+"'  value='' style='width:25;text-align:center;'/ disabled='disabled'></td>";
     tmpContent += "     <td class='r1' width='120'><input type='text'    name='d_skuCd'  id='d_skuCd"+row+"'  value='"+tmpArr[4]+"' style='width:95;text-align:center;' maxlength='13' onkeypress='javascript:onlyNumber();' onblur='skuKillFocus("+row+");' disabled='disabled' />";
     tmpContent += "                                <input type='button'  name='skuCdImg' id='skuCdImg"+row+"' onclick='getSkuPop("+row+");' value='..' disabled='disabled'  />";
     tmpContent += "     </td>";
     tmpContent += "     <td class='r1' width='85' id='td_skuNm' title="+tmpArr[5]+" ><input type='text' name='d_skuNm'      id='d_skuNm"+row+"'      value='"+tmpArr[5]+"' style='width:85;text-align:left;' maxlength='40' disabled='disabled'/></td>";
     tmpContent += "     <td class='r1' width='45'><input type='text' name='d_ordUnitNm'  id='d_ordUnitNm"+row+"'  value='"+tmpArr[7]+"' style='width:45;text-align:left;' maxlength='3' disabled='disabled' /></td>";
     tmpContent += "     <td class='r1' width='45'><input type='text' name='d_ordQty'     id='d_ordQty"+row+"'     value='"+convAmt(tmpArr[13])+"' onkeypress='javascript:onlyNumber();' style='width:45;text-align:right; IME-MODE: disabled;' maxlength='7'  onblur='javascript:calcDetail("+row+");'  disabled='disabled'/></td>";
     tmpContent += "     <td class='r1' width='85'><input type='text' name='d_newCostPrc' id='d_newCostPrc"+row+"' value='"+convAmt(tmpArr[14])+"' style='width:85;text-align:right;' maxlength='9' disabled='disabled' /></td>";
     tmpContent += "     <td class='r1' width='85'><input type='text' name='d_newCostAmt' id='d_newCostAmt"+row+"' value='"+convAmt(tmpArr[15])+"' style='width:85;text-align:right;' maxlength='13' disabled='disabled' /></td>";
     tmpContent += "     <td class='r1' width='85'><input type='text' name='d_newSalePrc' id='d_newSalePrc"+row+"' value='"+convAmt(tmpArr[16])+"' onkeypress='javascript:onlyNumber();' onblur='javascript:calcDetail("+row+");' style='width:85;text-align:right;IME-MODE: disabled' maxlength='9'  disabled='disabled';' /></td>";
     tmpContent += "     <td class='r1' width='85'><input type='text' name='d_newSaleAmt' id='d_newSaleAmt"+row+"' value='"+convAmt(tmpArr[17])+"' style='width:85;text-align:right;' maxlength='13' disabled='disabled' /></td>";
     tmpContent += "     <td class='r1' width='45'><input type='text' name='d_newGapRate' id='d_newGapRate"+row+"' value='"+tmpArr[9]+"' style='width:45;text-align:right;' disabled='disabled' /></td>";
     tmpContent += "     <td class='r1' width='45'><input type='text' name='d_avgSaleQty' id='d_avgSaleQty"+row+"' value='"+convAmt(tmpArr[11])+"' style='width:45;text-align:right;' maxlength='2' disabled='disabled' /></td>";
     tmpContent += "     <td class='r1' width='95'><input type='text' name='d_avgSaleAmt' id='d_avgSaleAmt"+row+"' value='"+convAmt(tmpArr[12])+"' style='width:95;text-align:right;' maxlength='40' disabled='disabled' /></td>";
     tmpContent += "     <td class='r1' width='55'><input type='text' name='d_stkQty'     id='d_stkQty"+row+"'     value='"+convAmt(tmpArr[10])+"' style='width:55;text-align:right;' maxlength='40' disabled='disabled' /></td>";
     
     tmpContent += "     <input type='hidden' name='d_strCd'      id='d_strCd"+row+"'      value='"+tmpArr[0]+"'  />";   // 점
     tmpContent += "     <input type='hidden' name='d_slip_no'    id='d_slip_no"+row+"'    value='"+tmpArr[1]+"'  />";   // 전표번호
     tmpContent += "     <input type='hidden' name='d_ord_seq_no' id='d_ord_seq_no"+row+"' value='"+tmpArr[2]+"'  />";   // 전표상세번호
     tmpContent += "     <input type='hidden' name='d_pummokCd'   id='d_pummokCd"+row+"'   value='"+tmpArr[3]+"'  />";   // 품목
     tmpContent += "     <input type='hidden' name='d_ordUnitCd'  id='d_ordUnitCd"+row+"'  value='"+tmpArr[6]+"'  />";   // 발주단위
     tmpContent += "     <input type='hidden' name='d_newGapAmt'  id='d_newGapAmt"+row+"'  value='"+tmpArr[8]+"'  />";   // 신차익액
     tmpContent += "     <input type='hidden' name='d_pumbunCd'   id='d_pumbunCd"+row+"'   value='"+tmpArr[18]+"' />";   // 브랜드
     tmpContent += "     <input type='hidden' name='d_venCd'      id='d_venCd"+row+"'      value='"+tmpArr[19]+"' />";   // 협력사
     tmpContent += "     <input type='hidden' name='d_slipFlag'   id='d_slipFlag"+row+"'   value='"+tmpArr[20]+"' />";   // 전표구분
     tmpContent += "     <input type='hidden' name='d_mgRate'     id='d_mgRate"+row+"'     value='"+tmpArr[21]+"' />";   // 마진율
     tmpContent += "     <input type='hidden' name='d_vatAmt'     id='d_vatAmt"+row+"'     value='"+tmpArr[23]+"' />";   // 부가세
     tmpContent += "     <input type='hidden' name='d_bottleCd'   id='d_bottleCd"+row+"'   value='"+tmpArr[24]+"' />";   // 공병코드
     tmpContent += "     <input type='hidden' name='d_bizType'    id='d_bizType"+row+"'    value='"+tmpArr[25]+"' />";   // 거래형태
     tmpContent += "     <input type='hidden' name='d_costZero'   id='d_costZero"+row+"'   value='"+tmpArr[26]+"' />";   // 원가 '0'여부
     tmpContent += "     <input type='hidden' name='d_saleZero'   id='d_saleZero"+row+"'   value='"+tmpArr[27]+"' />";   // 매가 '0'여부
     tmpContent += "     <input type='hidden' name='d_orgSkuCd'   id='d_orgSkuCd"+row+"'   value='"+tmpArr[22]+"' />";   // 이전단품코드

     tmpContent += "</tr>";
     return tmpContent; 
     
 }

/**
 * setMaster(tmpArr)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-16
 * 개    요   : 조회된 마스트 내용 화면에 세팅
 *         tmpArr : 조회내역
 * return: void
 */
 function setMaster(tmpArr){
     //  전표번호[0]      ,점코드[1]        ,점명[2]           ,브랜드코드[3]         ,브랜드명[4]
     // ,협력사코드[5]    ,협력사명[6]      ,신가격적용일[7]    ,신행사코드[8]       ,전표구분[9]
     // ,전표구분명[10]   ,발주주체구분[11] ,발주주체구분명[12] ,발주구분[13]        ,발주구분명[14]
     // ,자동전표구분[15] ,인상하구분[16]   ,사전사후구분[17]   ,출입구분[18]        ,발주일자[19]
     // ,납품예정일[20]   ,SM확정일자[21]   ,SM ID[22]         ,바이어ID[23]        ,발주확정일자[24]
     // ,바이어코드[25]   ,바이어코드명[26] ,전표진행상태[27]   ,전표진행상태명[28]  ,명세건수[29]
     // ,발주수량합[30]   ,신원가금액합[31] ,신매가금액합[32]   ,차익액합[33]        ,신차익율[34]
     // ,지불조건[35]     ,비고[36]         ,거래형태[37]      ,거래형태명[38]      ,과세구분[39]
     // ,과세구분명[40]   ,삭제구분[41]     ,검품확정일[42]     ,부가세[43]         ,공병전표여부[44]
     // ,등록일자[45]     ,사전사후구분명[46]
     
     frm.slip_no.value           = slip_format(tmpArr[0]);                  // 전표번호
     frm.slip_proc_stat_nm.value = tmpArr[28];                              // 전표상태명
     frm.slip_proc_stat.value    = tmpArr[27];                              // 전표상태
     frm.slip_flag.value         = setRadioValue("slip_flag", tmpArr[9]);   // 전표구분
     frm.aft_ord_flag_nm.value   = tmpArr[46];                              // 사전사후구분명
     frm.aft_ord_flag.value      = tmpArr[17];                              // 사전사후구분
     frm.pumbun_cd.value         = tmpArr[3];                               // 브랜드
     frm.ord_flag_nm.value       = tmpArr[14];                              // 발주구분명
     frm.ord_flag.value          = tmpArr[13];                              // 발주구분
     frm.buyer_cd.value          = tmpArr[25];                              // 바이어ID
     frm.buyer_nm.value          = tmpArr[26];                              // 바이어명
     frm.ven_cd.value            = tmpArr[5];                               // 협력사
     frm.ven_nm.value            = tmpArr[6];                               // 협력사명
     frm.biz_type.value          = tmpArr[37];                              // 거래형태
     frm.biz_type_nm.value       = tmpArr[38];                              // 거래형태명
     frm.tax_flag.value          = tmpArr[39];                              // 과세구분
     frm.tax_flag_nm.value       = tmpArr[40];                              // 과세구분명
     frm.ord_dt.value            = getDateFormat(tmpArr[19]);               // 발주일
     frm.conf_dt.value           = getDateFormat(tmpArr[24]);               // 확정일
     frm.ord_own_flag.value      = tmpArr[11];                              // 발주주체
     frm.ord_own_flag_nm.value   = tmpArr[12];                              // 발주주체명
     frm.deli_dt.value           = getDateFormat(tmpArr[20]);               // 납품예정일
     frm.prc_app_dt.value        = getDateFormat(tmpArr[7]);                // 가격적용일
     frm.chk_dt.value            = getDateFormat(tmpArr[42]);               // 검품확정일
     frm.tot_qty.value           = convAmt(tmpArr[30]);                     // 발주총수량
     frm.tot_cost_amt.value      = convAmt(tmpArr[31]);                     // 원가금액합
     frm.tot_sale_amt.value      = convAmt(tmpArr[32]);                     // 매가금액합
     frm.gap_tot_amt.value       = convAmt(tmpArr[33]);                     // 차익액합
     frm.gap_rate.value          = tmpArr[34];                              // 차익율
     frm.remark.value            = tmpArr[36];                              // 비고
     frm.reg_date.value          = tmpArr[45];                              // 전표등록일자
     frm.bottle_slip_yn.value    = tmpArr[44];                              // 공병여부
     frm.vat_tamt.value          = tmpArr[43];                              // 부가세합
     
 }

/**
 * scrollControl()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-10
 * 개    요   : 왼쪽 리스트 스크롤바 Control 
 * return : void
 */
 function scrollControl(flag){
     if(flag == "list")
         document.all.divListTitle.scrollLeft = document.all.divListContent.scrollLeft;
     else
         document.all.divDetailTitle.scrollLeft = document.all.divDetailContent.scrollLeft;
 }

/**
 * setList(row, tmpArr)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-10
 * 개    요   : 리스트 조회내용 리스트 생성 
 * return : void
 */
 function setList(row, tmpArr){
     
     var tmpContent = "";
     var col        = 0;
     // tmpArr[]
     //  전표번호[0]  ,점[1]        ,점명[2]       ,전표구분[3]  ,전표구분명[4] 
     // ,발주일[5]    ,전표상태[6]  ,전표상태명[7]  ,브랜드명[8]    ,취소여부[9]
     
     tmpContent += "   <tr onclick='setRowBgColor("+row+",6); getMaster("+row+");' style='cursor:hand;'>";
     tmpContent += "       <input type='hidden'       id='slip_no"+row+"'        name='slipNo'         value='"+tmpArr[0]+"' />";             // 전표번호
     tmpContent += "       <input type='hidden'       id='strCd"+row+"'          name='strCd'          value='"+tmpArr[1]+"' />";             // 점
     tmpContent += "       <input type='hidden'       id='slip_flag"+row+"'      name='slipFlag'       value='"+tmpArr[3]+"' />";             // 전표구분
     tmpContent += "       <input type='hidden'       id='slip_proc"+row+"'      name='slip_proc'      value='"+tmpArr[6]+"' />";             // 전표진행상태
     tmpContent += "       <td class='r1' width='65'  id='column"+row+"_"+(col++)+"'>"+tmpArr[4]+"</td>";                                     // 전표구분명
     tmpContent += "       <td class='r1' width='90'  id='column"+row+"_"+(col++)+"'>"+slip_format(tmpArr[0])+"</td>";                        // 전표번호
     tmpContent += "       <td class='r1' width='75'  id='column"+row+"_"+(col++)+"'>"+getDateFormat(tmpArr[5])+"</td>";                      // 발주일
     tmpContent += "       <td class='r3' width='65'  id='column"+row+"_"+(col++)+"' title="+tmpArr[7]+">"+cutTitleText(tmpArr[7],5)+"</td>"; // 전표진행상태명
     tmpContent += "       <td class='r3' width='110' id='column"+row+"_"+(col++)+"' title="+tmpArr[8]+">"+cutTitleText(tmpArr[8],8)+"</td>"; // 브랜드
     tmpContent += "       <td class='r3' width='85'  id='column"+row+"_"+(col++)+"' title="+tmpArr[2]+">"+cutTitleText(tmpArr[2],6)+"</td>"; // 점명
     tmpContent += "    </tr>";
     return tmpContent; 
 }

/**
 * addDetailRow()
 * 작 성 자     :김경은
 * 작 성 일     : 2011-08-16
 * 개    요        : 발주매입 상세(단품) ROW 추가
 * return값 : void
 */
 function addDetailRow() { 
      
      if(dtlCount == 0){
          frm.chkAll.disabled = false;
          if(!checkValidation("Save"))
              return;
      }
      setMstObjControl(false);   // Master 활성화/비활성화
      var oRow    = tb_detail.insertRow();
      var oCell1  = oRow.insertCell();
      var oCell2  = oRow.insertCell();
      var oCell3  = oRow.insertCell();
      var oCell4  = oRow.insertCell();
      var oCell5  = oRow.insertCell();
      var oCell6  = oRow.insertCell();
      var oCell7  = oRow.insertCell();
      var oCell8  = oRow.insertCell();
      var oCell9  = oRow.insertCell();
      var oCell10 = oRow.insertCell();
      var oCell11 = oRow.insertCell();
      var oCell12 = oRow.insertCell();
      var oCell13 = oRow.insertCell();
      var oCell14 = oRow.insertCell();
 
      oCell1.id          = "d_no";   //"'d_no"+(dtlIdCount+1)+"'"; 
      oCell1.className   = "r1";
      oCell1.style.width = "35";
      oCell1.innerHTML  =  dtlCount+1 ; 
      oCell2.className   = "r1";
      oCell2.style.width = "25";
      oCell2.innerHTML  += "<input type='hidden' name='d_strCd'      id='d_strCd"+dtlIdCount+"'      value=''/>";    // 점
      oCell2.innerHTML  += "<input type='hidden' name='d_slip_no'    id='d_slip_no"+dtlIdCount+"'    value='' />";   // 전표번호
      oCell2.innerHTML  += "<input type='hidden' name='d_ord_seq_no' id='d_ord_seq_no"+dtlIdCount+"' value='' />";   // 전표상세번호
      oCell2.innerHTML  += "<input type='hidden' name='d_pummokCd'   id='d_pummokCd"+dtlIdCount+"'   value='' />";   // 품목
      oCell2.innerHTML  += "<input type='hidden' name='d_ordUnitCd'  id='d_ordUnitCd"+dtlIdCount+"'  value='' />";   // 발주단위
      oCell2.innerHTML  += "<input type='hidden' name='d_newGapAmt'  id='d_newGapAmt"+dtlIdCount+"'  value='' />";   // 신차익액
      oCell2.innerHTML  += "<input type='hidden' name='d_pumbunCd'   id='d_pumbunCd"+dtlIdCount+"'   value='' />";   // 브랜드
      oCell2.innerHTML  += "<input type='hidden' name='d_venCd'      id='d_venCd"+dtlIdCount+"'      value='' />";   // 협력사
      oCell2.innerHTML  += "<input type='hidden' name='d_slipFlag'   id='d_slipFlag"+dtlIdCount+"'   value='' />";   // 전표구분
      oCell2.innerHTML  += "<input type='hidden' name='d_mgRate'     id='d_mgRate"+dtlIdCount+"'     value='' />";   // 마진율
      oCell2.innerHTML  += "<input type='hidden' name='d_vatAmt'     id='d_vatAmt"+dtlIdCount+"'     value='' />";   // 부가세
      oCell2.innerHTML  += "<input type='hidden' name='d_bottleCd'   id='d_bottleCd"+dtlIdCount+"'   value='' />";   // 공병코드
      oCell2.innerHTML  += "<input type='hidden' name='d_bizType'    id='d_bizType"+dtlIdCount+"'    value='' />";   // 거래형태
      oCell2.innerHTML  += "<input type='hidden' name='d_costZero'   id='d_costZero"+dtlIdCount+"'   value='' />";   // 원가 '0'여부
      oCell2.innerHTML  += "<input type='hidden' name='d_saleZero'   id='d_saleZero"+dtlIdCount+"'   value='' />";   // 매가 '0'여부
      oCell2.innerHTML  += "<input type='hidden' name='d_orgSkuCd'   id='d_orgSkuCd"+dtlIdCount+"'   value='' />";   // 이전단품코드
      
      oCell2.innerHTML  += "<input type='checkbox' name='d_check' id='d_check"+dtlIdCount+"' value='' style='width:25;text-align:center;'/>";
      
      oCell3.className   = "r1";
      oCell3.style.width = "120";
      oCell3.innerHTML   = "<input type='text'    name='d_skuCd'  id='d_skuCd"+dtlIdCount+"'  value='' style='width:95;text-align:center;' maxlength='13' onkeypress='javascript:onlyNumber();' onblur='skuKillFocus("+dtlIdCount+");' />";
      oCell3.innerHTML  += " <input type='button' name='skuCdImg' id='skuCdImg"+dtlIdCount+"' onclick='getSkuPop("+dtlIdCount+");' value='..' />";
      
      oCell4.id          = "td_skuNm";
      oCell4.className   = "r1";
      oCell4.style.width = "85";
      oCell4.innerHTML   = "<input type='text' name='d_skuNm'      id='d_skuNm"+dtlIdCount+"'      value='' style='width:85;text-align:left;' maxlength='40' disabled='disabled'/>";
      
      oCell5.className   = "r1";
      oCell5.style.width = "45";
      oCell5.innerHTML   = "<input type='text' name='d_ordUnitNm'  id='d_ordUnitNm"+dtlIdCount+"'  value='' style='width:45;text-align:left;' maxlength='3' disabled='disabled' />";
      
      oCell6.className   = "r1";
      oCell6.style.width = "45";
      oCell6.innerHTML   = "<input type='text' name='d_ordQty'     id='d_ordQty"+dtlIdCount+"'     value='' onkeypress='javascript:onlyNumber();' style='width:45;text-align:right; IME-MODE: disabled;' maxlength='7'  onblur='javascript:calcDetail("+dtlIdCount+");' />";
      
      oCell7.className   = "r1";
      oCell7.style.width = "85";
      oCell7.innerHTML   = "<input type='text' name='d_newCostPrc' id='d_newCostPrc"+dtlIdCount+"' value='' style='width:85;text-align:right;' maxlength='9' disabled='disabled' />";
      
      oCell8.className   = "r1";
      oCell8.style.width = "85";
      oCell8.innerHTML   = "<input type='text' name='d_newCostAmt' id='d_newCostAmt"+dtlIdCount+"' value='' style='width:85;text-align:right;' maxlength='13' disabled='disabled' />";
      
      oCell9.className   = "r1";
      oCell9.style.width = "85";
      oCell9.innerHTML   = "<input type='text' name='d_newSalePrc' id='d_newSalePrc"+dtlIdCount+"' value='' onkeypress='javascript:onlyNumber();' onblur='javascript:calcDetail("+dtlIdCount+");' style='width:85;text-align:right;IME-MODE: disabled' maxlength='9'  disabled='disabled';' />";
      
      oCell10.className   = "r1";
      oCell10.style.width = "85";
      oCell10.innerHTML   = "<input type='text' name='d_newSaleAmt' id='d_newSaleAmt"+dtlIdCount+"' value='' style='width:85;text-align:right;' maxlength='13' disabled='disabled' />";
      
      oCell11.className   = "r1";
      oCell11.style.width = "45";
      oCell11.innerHTML   = "<input type='text' name='d_newGapRate' id='d_newGapRate"+dtlIdCount+"' value='' style='width:45;text-align:right;' disabled='disabled' />";
      
      oCell12.className   = "r1";
      oCell12.style.width = "45";
      oCell12.innerHTML   = "<input type='text' name='d_avgSaleQty' id='d_avgSaleQty"+dtlIdCount+"' value='' style='width:45;text-align:right;' maxlength='2' disabled='disabled' />";
      
      oCell13.className   = "r1";
      oCell13.style.width = "95";
      oCell13.innerHTML   = "<input type='text' name='d_avgSaleAmt' id='d_avgSaleAmt"+dtlIdCount+"' value='' style='width:95;text-align:right;' maxlength='40' disabled='disabled' />";
      
      oCell14.className   = "r1";
      oCell14.style.width = "55";
      oCell14.innerHTML   = "<input type='text' name='d_stkQty'     id='d_stkQty"+dtlIdCount+"'     value='' style='width:55;text-align:right;' maxlength='40' disabled='disabled' />";
      
      setTimeout("document.getElementById('d_skuCd"+dtlIdCount+"').focus();", 1);
      dtlCount++;                // No
      dtlIdCount++;              // 상세ID Count
 }
 
/**
 * delDetailRow()
 * 작 성 자     :김경은
 * 작 성 일     : 2011-08-16
 * 개    요        : 발주매입 상세(단품) ROW 삭제
 * return값 : void
 */
 function delDetailRow() {
     var chkLen = document.getElementsByName("d_check").length;   
     if(chkLen == 0){
         // 삭제할 내역이 없습니다.
         showMessage(EXCLAMATION, OK, "USER-1019");
         return;
     }

     for(var i = chkLen; i > 0; i--){
         if(document.getElementsByName("d_check")[i-1].checked){
             var ord_seq_no = document.getElementsByName("d_ord_seq_no")[i-1].value;
             var gb         = frm.del_detail.value == "" ? "":"/";
          //   alert(ord_seq_no);
             if(ord_seq_no != " "){
               frm.del_detail.value +=  gb + ord_seq_no;
             } 
             tb_detail.deleteRow(i-1);
             dtlCount--;
         }
     }
     
    if(dtlCount != 0){
        setNo(d_no);                 // No을 다시 세팅
    }else{
        frm.chkAll.checked = false;
        setMstObjControl(true);      // Master 활성화/비활성화
    }
 }
  
/**
 * getRadioValue(target)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-10
 * 개    요   : 라디오박스의 선택된값을 가져온다.
 *  - target : 라디오박스 이름
 * return : void
 */
 function getRadioValue(target){
     if (frm.elements(target).length) {
         for (var j = 0; j < frm.elements(target).length; j++) {
             if (frm.elements(target)[j].checked) {
                 return frm.elements(target)[j].value;
             }
         }
     }
 }

/**
 * setRadioValue(target, val)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-10
 * 개    요   : 라디오박스에 값을 세팅한다.
 *  - target : 라디오박스 이름
 *  - val    : 세팅할 값
 * return : void
 */
 function setRadioValue(target, val){
     if (frm.elements(target).length) {
         for (var j = 0; j < frm.elements(target).length; j++) {
             if (frm.elements(target)[j].value == val) {
                 frm.elements(target)[j].checked = true;
                 return;
             }
         }
     }
 }

/**
 * setRowBgColor(row,colCount)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-12
 * 개    요   : 선택된 Row의 BGColor를 변경한다.
 *         row      : 선택 Row
 *         colCount : 전체컬럼수
 * return : void
 */
 function setRowBgColor(row,colCount){
     var lastRow = frm.last_row.value;   // 마지막 선택 Row
     row         = row == -1 ? 0:row;    // 현재 선택 Row
     if(lastRow != row){
         for(var j=0;j<colCount;j++) {
             document.getElementById("column"+row+"_"+j).style.backgroundColor     = "#fff56E";
             if(lastRow != -1)
                 document.getElementById("column"+lastRow+"_"+j).style.backgroundColor = "#ffffff";
         } 
         frm.last_row.value = row;
     }
 }

/**
 * getPumbunInfo()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-18
 * 개    요 :  브랜드상세내역 조회
 * return값 : void
 */
 function getPumbunInfo(){
     var strCd    = '<%=STR_CD%>';         // 점
     var venCd    = '<%=VEN_CD%>';         // 협력사
     var pumbunCd = frm.pumbun_cd.value;    // 브랜드
     
     var param   = "&goTo=getPumbunInfo"
                 + "&strCd="         + strCd
                 + "&venCd="         + venCd
                 + "&pumbunCd="      + pumbunCd;
     
     <ajax:open callback="on_getPumbunInfoXML" 
         param    ="param" 
         method   ="POST" 
         urlvalue ="/edi/eord106.eo"/>
     
     <ajax:callback function="on_getPumbunInfoXML"> 
     
     var tmpArr = new Array(); 
     if( rowsNode.length > 0 ){
         for( var i = 0; i < rowsNode.length; i++ ){
             for( var j = 0; j < rowsNode[i].childNodes.length; j++ ){
                 tmpArr[j] = rowsNode[i].childNodes[j].childNodes[0].nodeValue == "null" ? "" : String(rowsNode[i].childNodes[j].childNodes[0].nodeValue);
             }
         }
     }
     // 브랜드정보 세팅
     setPumbunInfo(tmpArr);
     
     </ajax:callback>
 }

/**
 * setPumbunInfo(tmpArr)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-16
 * 개    요   : 조회된 브랜드의 상세 내역을 세팅
 *         tmpArr : 조회내역
 * return: void
 */
 function setPumbunInfo(tmpArr){
     //  브랜드코드[0]      ,브랜드명[1]        ,영수증명[2]      ,단품구분[3]       ,대표브랜드코드[4]
     // ,단품종류[5]      ,거래형태[6]      ,과세구분[7]      ,바이어코드[8]     ,바이어명[9]
     // ,SM코드[10]       ,SM명[11]        ,협력사코드[12]    ,협력[13]         ,의류단품코드구분[14]
     // ,바이어사원명[15] ,매입조직[16]     ,판매조직[17]     ,브랜드유형[18]      ,거래형태명[19] 
     // ,과세구분명[20]   ,원가0여부[21]    ,매가0여부[22]
     
     if(tmpArr == ""){
         frm.biz_type.value          = "";                                    // 거래형태
         frm.biz_type_nm.value       = "";                                    // 거래형태명
         frm.tax_flag.value          = "";                                    // 과세구분
         frm.tax_flag_nm.value       = "";                                    // 과세구분명
         frm.buyer_cd.value          = "";                                    // 바이어ID
         frm.buyer_nm.value          = "";                                    // 바이어명
     }else{
         frm.biz_type.value          = tmpArr[6];                              // 거래형태
         frm.biz_type_nm.value       = tmpArr[19];                             // 거래형태명
         frm.tax_flag.value          = tmpArr[7];                              // 과세구분
         frm.tax_flag_nm.value       = tmpArr[20];                             // 과세구분명
         frm.buyer_cd.value          = tmpArr[8];                              // 바이어ID
         frm.buyer_nm.value          = tmpArr[15];                             // 바이어명
     }
 }
 
/**
 * getSkuPop(row, colid)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-20
 * 개    요 :  단품 팝업  관련 데이터 조회 및 세팅
 * return값 : void
 */
 function getSkuPop(row){
     var intRow          = 1;
     var strSkuCd        = document.getElementById("d_skuCd"+(row)).value;            // 단품
     var strUsrCd        = "";                                                        // 사원번호
     var strStrCd        = '<%=STR_CD%>';                                             // 점
     var strPumbunCd     = frm.pumbun_cd.value;                                       // 브랜드코드
     var strPumbunType   = "";                                                        // 브랜드유형(0,4)
     var strBizType      = frm.biz_type.value;                                        // 거래형태(2:특정)
     var strUseYn        = "Y";                                                       // 사용여부   
     var strVenCd        = frm.ven_cd.value;                                          // 협력사
 
     var rtnList = strSkuMultiSelPop(strSkuCd, "", "Y"
                                     , strUsrCd, strStrCd, strPumbunCd, strPumbunType, strBizType
                                     , strUseYn, '', '', '', ''
                                     ,'', '', '', strVenCd);
 
     if(rtnList != null){
         for(var i = 0; i < rtnList.length; i++){
             if(i == 0 )
                 intRow = row;
             else
                 addDetailRow();
             
             document.getElementById("d_skuCd"+(row+i)).value = rtnList[i].SKU_CD;       // 단품코드       
             document.getElementById("d_skuNm"+(row+i)).value = rtnList[i].SKU_NM;       // 단품명      
             var orgValue = document.getElementById("d_orgSkuCd"+(row+i)).value;
             var newValue = document.getElementById("d_skuCd"+(row+i)).value;
             if(orgValue != newValue){
                 document.getElementById("d_orgSkuCd"+(row+i)).value = newValue;
                 getSkuInfo(row+i);
             }
         }
         if(rtnList.length > 1){
             setTimeout("document.getElementById('d_ordQty"+intRow+"').focus();", 1);
         }
     }
 }

/** 
 * strSkuMultiSelPop()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-20
 * 개    요 : 단품코드(점별) Popup(멀티선택)
 * 사용방법 : strSkuMultiSelPop( strCd, strNm, authGb)
 *            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
 *            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
 *            arguments[2] -> 권한여부
 *            //--추가조건--
 *            arguments[3] -> 사원번호
 *            arguments[4] -> 점코드
 *            arguments[5] -> 브랜드코드
 *            arguments[6] -> 브랜드유형
 *            arguments[7] -> 거래형태
 *            arguments[8] -> 사용여부
 *            arguments[9] -> 매입일자
 *            arguments[10] -> 단품종류
 *            arguments[11] -> 협력사코드
 *            arguments[12] -> 스타일코드
 *            arguments[13] -> 칼라코드
 *            arguments[14] -> 사이즈코드
 *            arguments[15] -> 소스마킹코드테이블 포함여부
 *            arguments[16] -> 단품협력사코드
 *
 * 실행  예) strSkuMultiSelPop( "CODE", "NAME" , 'N');
 *
 * return값 : list
 *             map
                SKU_CD          단품코드
                SKU_NAME        단품명
                RECP_NAME       영수증명
                PUMBUN_CD       브랜드코드
                PUMBUN_NAME     브랜드명
                PUMMOK_CD       품목코드
                SALE_UNIT_CD    판매단위
                CMP_SPEC_CD     구성규격
                CMP_SPEC_UNIT   구성규격단위
                GIFT_AMT_TYPE   상품권금종
                STYLE_CD        스타일코드
                COLOR_CD        칼라코드
                SIZE_CD         사이즈코드
                SKU_TYPE        단품종류
 */
 function strSkuMultiSelPop( strCd, strNm, authGb ){
     var rtnList  = new Array();
     var arrArg   = new Array();
     var addCondition = setAddCondition( 3, arguments );
 
     arrArg.push(rtnList);
     arrArg.push(strCd);
     arrArg.push(strNm);
     arrArg.push(authGb);
     arrArg.push("M");
     arrArg.push(addCondition);
 
     var returnVal = window.showModalDialog("/edi/ccom004.cc?goTo=strSkuPop",
                                            arrArg,
                                            "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     if (returnVal){
         return arrArg[0];
     }
     
     return null;
 }

/**
 * skuValCheck(row, colid)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-20
 * 개    요 :  단품  Validation Check
 *        row : row
 *        popFlag : 팝업여부(0:팝업X, 1:팝업)
 * return값 : void
 */
 function skuValCheck(row, popFlag){
     var intRow   = 1;
     var strSkuCd = "";     
     if(popFlag == "1")
         strSkuCd = document.getElementById("d_skuCd"+row).value;
     else
         strSkuCd = document.getElementsByName("d_skuCd")[row].value;
         
     var strUsrCd        = "";                                                        // 사원번호
     var strStrCd        = '<%=STR_CD%>';                                             // 점
     var strPumbunCd     = frm.pumbun_cd.value;                                       // 브랜드코드
     var strPumbunType   = "";                                                        // 브랜드유형(0,4)
     var strBizType      = frm.biz_type.value;                                        // 거래형태(2:특정)
     var strUseYn        = "Y";                                                       // 사용여부   
     var strVenCd        = frm.ven_cd.value;                                          // 협력사
     
     var rtnMap = setStrSkuNmWithoutToGridPordPop( row, strSkuCd, "", "Y", popFlag,
                                               strUsrCd, strStrCd, strPumbunCd, strPumbunType, strBizType,
                                               strUseYn, '', '', '', ''
                                               ,'', '', '', strVenCd);
     
 }

/**
 * setStrSkuNmWithoutToGridPordPop()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-20
 * 개    요 :  단품코드(점별) 이름
 * 사용방법 : setStrSkuNmWithoutToGridPordPop( row, strCd, strNm, authGb, searchTp)
 *            arguments[0] -> row
 *            arguments[1] -> 코드
 *            arguments[2] -> 명
 *            arguments[3] -> 권한여부
 *            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
 *            //--추가조건--
 *            arguments[5] -> 사원번호
 *            arguments[6] -> 점코드
 *            arguments[7] -> 브랜드코드
 *            arguments[8] -> 브랜드유형
 *            arguments[9] -> 거래형태
 *            arguments[10]-> 사용여부
 *            arguments[11] -> 매입일자
 *            arguments[12] -> 단품종류
 *            arguments[13] -> 협력사코드
 *
 * 실행  예) setStrSkuNmWithoutToGridPordPop(row, "CODE", "NAME" , 'N', 0);
 *
 * return값 : map
                SKU_CD          단품코드
                SKU_NAME        단품명
                RECP_NAME       영수증명
                PUMBUN_CD       브랜드코드
                PUMMOK_CD       품목코드
                SALE_UNIT_CD    판매단위
                CMP_SPEC_CD     구성규격
                CMP_SPEC_UNIT   구성규격단위
                GIFT_AMT_TYPE   상품권금종
 */
 function setStrSkuNmWithoutToGridPordPop( row, strCd, strNm, authGb, searchTp){
 
      var addCondition = setAddCondition( 5, arguments );
      var skuCd = strCd;    
      var skuNm = strNm;    
      var auth  = authGb;     
      var cond  = addCondition;
     
      var param   = "&goTo=searchOnWithoutPordPop"
                  + "&skuCd="         + skuCd
                  + "&skuNm="         + skuNm
                  + "&auth="          + auth
                  + "&cond="          + cond;
 
     <ajax:open callback="on_searchOnWithoutPordPopXML" 
         param    ="param" 
         method   ="POST" 
         urlvalue ="/edi/ccom004.cc"/>
     
     <ajax:callback function="on_searchOnWithoutPordPopXML"> 
     
     var tmpArr = new Array(); 
     var rtnMap = new Map();
     if( rowsNode.length == 1 ){
         
         for( var i = 0; i < rowsNode.length; i++ ){
             for( var j = 0; j < rowsNode[i].childNodes.length; j++ ){
                 tmpArr[j] = rowsNode[i].childNodes[j].childNodes[0].nodeValue == "null" ? "" : String(rowsNode[i].childNodes[j].childNodes[0].nodeValue);
             }
             rtnMap.put("SKU_CD", tmpArr[0]);
             //rtnMap.put("SKU_NM", tmpArr[1]);
             
             if(document.getElementById("d_skuNm"+(row)).value == "")
                   getSkuInfo(row);
         }
     }else{
         if(searchTp == "1"){
             if(addCondition == ""){
                 rtnMap = strSkuToGridPop( strCd, strNm, authGb )
             }else{
                 rtnMap = strSkuToGridPop( strCd, strNm, authGb, addCondition );
             }
         }else{
             return null;
         }
     }
     
     if(rtnMap != null){
         if(searchTp == "1"){
             document.getElementById("d_skuCd"+(row)).value = rtnMap.get("SKU_CD");       // 단품코드       
             document.getElementById("d_skuNm"+(row)).value = rtnMap.get("SKU_NM");       // 단품명  
             
             var orgValue = document.getElementById("d_orgSkuCd"+(row)).value;
             var newValue = document.getElementById("d_skuCd"+(row)).value;
             if(orgValue != newValue){
                 document.getElementById("d_orgSkuCd"+(row)).value = newValue;
                 getSkuInfo(row);
             }
         }
     }else{
         showMessage(EXCLAMATION, OK, "USER-1065", "정확한 단품코드"); 
         setSkuInfo(row, "");
         setTimeout("document.getElementById('d_skuCd"+row+"').focus();", 1);
     }
     
     </ajax:callback>
 }
    
/** 
 * strSkuToGridPop()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-20
 * 개    요 : 단품코드(점별) Popup(Grid)
 * 사용방법 : strSkuToGridPop( strCd, strNm, authGb)
 *            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
 *            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
 *            arguments[2] -> 권한여부
 *            //--추가조건--
 *            arguments[3] -> 사원번호
 *            arguments[4] -> 점코드
 *            arguments[5] -> 브랜드코드
 *            arguments[6] -> 브랜드유형
 *            arguments[7] -> 거래형태
 *            arguments[8] -> 사용여부
 *            arguments[9] -> 매입일자
 *            arguments[10] -> 단품종류
 *            arguments[11] -> 협력사코드
 *            arguments[12] -> 스타일코드
 *            arguments[13] -> 칼라코드
 *            arguments[14] -> 사이즈코드
 *            arguments[15] -> 소스마킹코드테이블 포함여부
 *            arguments[16] -> 단품협력사코드
 *
 * 실행  예) strSkuToGridPop( "CODE", "NAME" , 'N');
 *
 * return값 : map
                SKU_CD          단품코드
                SKU_NAME        단품명
                RECP_NAME       영수증명
                PUMBUN_CD       브랜드코드
                PUMBUN_NAME     브랜드명
                PUMMOK_CD       품목코드
                SALE_UNIT_CD    판매단위
                CMP_SPEC_CD     구성규격
                CMP_SPEC_UNIT   구성규격단위
                GIFT_AMT_TYPE   상품권금종
                STYLE_CD        스타일코드
                COLOR_CD        칼라코드
                SIZE_CD         사이즈코드
                SKU_TYPE        단품종류
 */
 function strSkuToGridPop( strCd, strNm, authGb )
 {
     var rtnMap  = new Map();
     var arrArg  = new Array();
     var addCondition = setAddCondition( 3, arguments );
 
     arrArg.push(rtnMap);
     arrArg.push(strCd);
     arrArg.push(strNm);
     arrArg.push(authGb);
     arrArg.push("S");
     arrArg.push(addCondition);
     
     var returnVal = window.showModalDialog("/edi/ccom004.cc?goTo=strSkuPop",
                                            arrArg,
                                            "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
      
     if (returnVal){
         var map = arrArg[0];
         return map;
     }
     
     return null;
 }
               
/**
 * getSkuInfo()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-02-19
 * 개    요 :  상세내역의 단품관련 데이터 조회
 * return값 : void
 */
 function getSkuInfo(row){  
     var strCd    = '<%=STR_CD%>';                                    // 점
     var pumbunCd = frm.pumbun_cd.value;                              // 브랜드
     var ordDt    = frm.ord_dt.value;                                 // 발주일
     var prcAppDt = frm.prc_app_dt.value;                             // 가격적용일
     var skuCd    = document.getElementById("d_skuCd"+(row)).value;   // 단품코드
     var bizType  = frm.biz_type.value;                               // 거래형태
 
     var param   = "&goTo=getSkuInfo"
                 + "&strCd="         + strCd
                 + "&pumbunCd="      + pumbunCd
                 + "&ordDt="         + ordDt
                 + "&ordYm="         + ordDt.substring(0,7)
                 + "&prcAppDt="      + prcAppDt
                 + "&skuCd="         + skuCd
                 + "&bizType="       + bizType;
     
     <ajax:open callback="on_getSkuInfoXML" 
         param    ="param" 
         method   ="POST" 
         urlvalue ="/edi/eord106.eo"/>
     
     <ajax:callback function="on_getSkuInfoXML"> 
     
     var tmpArr = new Array(); 
     if( rowsNode.length > 0 ){
         for( var i = 0; i < rowsNode.length; i++ ){
             for( var j = 0; j < rowsNode[i].childNodes.length; j++ ){
                 tmpArr[j] = rowsNode[i].childNodes[j].childNodes[0].nodeValue == "null" ? "" : String(rowsNode[i].childNodes[j].childNodes[0].nodeValue);
             }
         }
     }
     // 단품정보 세팅
     setSkuInfo(row, tmpArr);
     
     </ajax:callback>
 }
   
/**
 * setSkuInfo(row, tmpArr)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-20
 * 개    요   : 조회된 단품정보 세팅
 *         row
 *         tmpArr : 조회내역
 * return: void
 */
 function setSkuInfo(row, tmpArr){
     //  점[0]               ,단품코드[1]        ,단품명[2]         ,품목코드[3]         ,브랜드코드[4]
     // ,브랜드적용시작일[5]    ,브랜드적용종료일[6]  ,기본규격단위[7]    ,기본규격단위명[8]   ,평균판매량[9]
     // ,평균판매액[10]       ,판매원가[11]       ,판매매가[12]      ,판매마진율[13]      ,재고[14]
     // ,공병단품코드[15]     ,거래형태[16]       ,원가0여부[17]     ,매가0여부[18]       
     if(tmpArr == ""){
         document.getElementById("d_slip_no"+(row)).value    = "";
         document.getElementById("d_strCd"+(row)).value      = "";
         document.getElementById("d_pumbunCd"+(row)).value   = "";
         document.getElementById("d_venCd"+(row)).value      = "";
         document.getElementById("d_slipFlag"+(row)).value   = "";
         document.getElementById("d_pummokCd"+(row)).value   = "";
         document.getElementById("d_skuNm"+(row)).value      = "";
         document.getElementById("d_ordUnitCd"+(row)).value  = "";
         document.getElementById("d_ordUnitNm"+(row)).value  = "";
         document.getElementById("d_stkQty"+(row)).value     = "";
         document.getElementById("d_avgSaleQty"+(row)).value = "";
         document.getElementById("d_avgSaleAmt"+(row)).value = "";
         document.getElementById("d_newCostPrc"+(row)).value = "";
         document.getElementById("d_newSalePrc"+(row)).value = "";
         document.getElementById("d_mgRate"+(row)).value     = "";
         document.getElementById("d_bottleCd"+(row)).value   = "";
         document.getElementById("d_bizType"+(row)).value    = "";
         document.getElementById("d_costZero"+(row)).value   = "";
         document.getElementById("d_saleZero"+(row)).value   = "";
         document.getElementById("d_newGapRate"+(row)).value = "";
         
         document.getElementById("d_ord_seq_no"+(row)).value = "";
         document.getElementById("d_vatAmt"+(row)).value     = "";
         document.getElementById("d_skuCd"+(row)).value      = "";
         document.getElementById("d_ordQty"+(row)).value     = "";
         document.getElementById("d_newCostAmt"+(row)).value = "";
         document.getElementById("d_newSaleAmt"+(row)).value = "";
         document.getElementById("d_newGapAmt"+(row)).value  = "";
         document.getElementById("d_orgSkuCd"+(row)).value   = "";
         
     }else{
         document.getElementById("d_slip_no"+(row)).value    = frm.slip_no.value;        // 전표번호
         document.getElementById("d_strCd"+(row)).value      = tmpArr[0];                // 점
         document.getElementById("d_pumbunCd"+(row)).value   = tmpArr[4];                // 브랜드
         document.getElementById("d_venCd"+(row)).value      = frm.ven_cd.value;         // 협력사
         document.getElementById("d_slipFlag"+(row)).value   = getRadioValue("slip_flag");      // 전표구분
         document.getElementById("d_pummokCd"+(row)).value   = tmpArr[3];                // 품목
         document.getElementById("d_skuNm"+(row)).value      = tmpArr[2];                // 단품명
         document.getElementById("d_ordUnitCd"+(row)).value  = tmpArr[7];                // 발주단위
         document.getElementById("d_ordUnitNm"+(row)).value  = tmpArr[8];                // 발주단위명
         document.getElementById("d_stkQty"+(row)).value     = convAmt(tmpArr[14]);      // 재고수량
         document.getElementById("d_avgSaleQty"+(row)).value = convAmt(tmpArr[9]);       // 평균판매량
         document.getElementById("d_avgSaleAmt"+(row)).value = convAmt(tmpArr[10]);      // 평균판매금액
         document.getElementById("d_newCostPrc"+(row)).value = convAmt(tmpArr[11]);      // 원가
         document.getElementById("d_newSalePrc"+(row)).value = convAmt(tmpArr[12]);      // 매가
         document.getElementById("d_mgRate"+(row)).value     = tmpArr[13];               // 마진율
         document.getElementById("d_bottleCd"+(row)).value   = tmpArr[15];               // 공병코드
         document.getElementById("d_bizType"+(row)).value    = tmpArr[16];               // 거래형태
         document.getElementById("d_costZero"+(row)).value   = tmpArr[17];               // 원가 '0'여부(Y/N)
         document.getElementById("d_saleZero"+(row)).value   = tmpArr[18];               // 매가 '0'여부(Y/N)
         document.getElementById("d_newGapRate"+(row)).value = tmpArr[13];               // 차익율(특정일경우 마진율세팅)
         document.getElementById("d_ord_seq_no"+(row)).value = " ";
     }
     
     // 매가단가가 0일 경우 수정가능
     if(tmpArr[18] == "Y"){
         document.getElementById("d_newSalePrc"+(row)).disabled = false;
         document.getElementById("d_newSalePrc"+(row)).value    = "";
     }else{
         document.getElementById("d_newSalePrc"+(row)).disabled = true;
     }
 }

/**
 * calcDetail(row, colid)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-03-10
 * 개    요    : 차익액, 차익율을 계산한다.
 * return값 : void
 */
 function calcDetail(row){
     var strTaxFlag  = frm.tax_flag.value;                                                // 과세구분
     var strBizType  = frm.biz_type.value;                                                // 거래형태
     var ord_qty     = removeComma2(document.getElementById("d_ordQty"+(row)).value);     // 발주수량
     var cost_prc    = removeComma2(document.getElementById("d_newCostPrc"+(row)).value); // 원가단가
     var sale_prc    = removeComma2(document.getElementById("d_newSalePrc"+(row)).value); // 매가단가
     var cost_amt    = 0;                                                // 원가금액
     var cost_amt_vat= 0;                                                // 원가금액(부가세포함)
     var sale_amt    = 0;                                                // 매가금액
     var rate        = document.getElementById("d_mgRate"+(row)).value;                   // 마진율
     var totGapAmt   = 0;                                                                 // 총차익액
     var totGapRate  = 0;                                                                 // 총차익율
     var totCostAmt  = 0;                                                                 // 총원가금액
     var totSaleAmt  = 0;                                                                 // 총매가금액
                                                                        
     
     // 매가단가 입력시  원가단가를 계산한다. ===========================================================
     var saleZero = document.getElementById("d_saleZero"+(row)).value;
     if(saleZero == "Y"){
         sale_prc     = removeComma2(document.getElementById("d_newSalePrc"+(row)).value);
         sale_amt     = ord_qty * sale_prc;
         cost_amt     = getCalcPord("COST_PRC", "", sale_amt, rate, strTaxFlag, venRoundFlag);  // 원가금액
         cost_amt_vat = getCalcPord("COST_PRC", "", sale_amt, rate, "2", venRoundFlag);         // 원가금액(부가세포함)
         cost_prc     = getRoundDec("1", cost_amt / ord_qty);                                   // 원가단가 
         document.getElementById("d_newSalePrc"+(row)).value = convAmt(String(sale_prc));
         document.getElementById("d_newCostPrc"+(row)).value = convAmt(String(cost_prc));                                                // 원가금액
         document.getElementById("d_newCostAmt"+(row)).value = convAmt(String(cost_amt));                 
     }else{
    	 sale_amt     = ord_qty * sale_prc;
    	 cost_amt     = ord_qty * cost_prc;
    	 cost_amt_vat = getCalcPord("COST_PRC", "", sale_amt, rate, "2", venRoundFlag);         // 원가금액(부가세포함)
     }
     //==============================================================================================
     
     document.getElementById("d_newCostAmt"+(row)).value = convAmt(String(cost_amt));        // 원가금액
     document.getElementById("d_newSaleAmt"+(row)).value = convAmt(String(sale_amt));        // 매가금액
        
     var gapAmt = getCalcPord("GAP_AMT",  cost_amt,   sale_amt,   "", strTaxFlag, venRoundFlag);
     var vatAmt = getCalcPord("VAT_AMT",  cost_amt,   "",         "", strTaxFlag, venRoundFlag);
     document.getElementById("d_newGapAmt"+(row)).value  = convAmt(String(gapAmt));       // 차익액
     //document.getElementById("d_vatAmt"+(row)).value     = convAmt(String(vatAmt));       // 부가세
     document.getElementById("d_vatAmt"+(row)).value     = cost_amt_vat - cost_amt;       // 부가세

     totCostAmt = getDetailSum("d_newCostAmt");
     totSaleAmt = getDetailSum("d_newSaleAmt");
     totGapAmt  = getDetailSum("d_newGapAmt");
     totGapRate = getCalcPord("GAP_RATE", totCostAmt, totSaleAmt, "", strTaxFlag, venRoundFlag);
     
     frm.gap_tot_amt.value  = convAmt(String(totGapAmt));                       // 차익액계
     frm.gap_rate.value     = totGapRate;                                       // 차익율
     
     frm.tot_qty.value      = convAmt(String(getDetailSum("d_ordQty")));        // 발주수량계
     frm.tot_cost_amt.value = convAmt(String(totCostAmt));                      // 원가계
     frm.tot_sale_amt.value = convAmt(String(totSaleAmt));                      // 매가계
     
     frm.vat_tamt.value     = getDetailSum("d_vatAmt");                         // 부가세계
 }
 
/**
 * getDetailSum()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-19
 * 개    요   : objet 배열의  합계를 구한다.
 * return : void
 */
 function getDetailSum(objNm){
     var len    = document.getElementsByName(objNm).length;  
     var obj    = document.getElementsByName(objNm);
     var tot    = 0;
     for(var i = 0; i < len; i++){
         tot += Number(removeComma2(obj[i].value));
     }
     return tot;
 }
               
/**
 * setNo(obj)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-19
 * 개    요   : Row 삭제시 상세내역 (단품정보)의 순번을 변경한다.
 * return : void
 */
 function setNo(obj){
     var len = obj.length;
     if(len == undefined){
         obj.innerHTML = 1;
     }else{
         for(var i = 0; i < len; i++){ 
             obj[i].innerHTML = i+1;
         }
     }
 }

/**
 * checkAll()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-19
 * 개    요   : 상세내역 (단품정보) 전체 선택/해제
 * return : void
 */
 function checkAll(){
     var chkLen = document.getElementsByName("d_check").length;   
     for(var i = 0; i < chkLen; i++){
         document.getElementsByName("d_check")[i].checked = frm.chkAll.checked;
     }
 }

/**
 * closeCheck()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-10
 * 개    요    : 저장시 일마감체크를 한다.
 * return값 : void
 */
 function closeCheck(){
     var strStrcd         = '<%=STR_CD%>';      // 점
     var strCloseDt       = getRawData(document.getElementById("ord_dt").value);    // 마감체크일자
     var strCloseTaskFlag = "PORD";                 // 업무구분(매입월마감)
     var strCloseUnitFlag = "42";                   // 단위업무
     var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
     var strCloseFlag     = "M";                    // 마감구분(월마감:M)
     
     var param = "&goTo=getCloseCheck" + "&strcd="            + strStrcd
                                       + "&closeDt="          + strCloseDt
                                       + "&strCloseTaskFlag=" + strCloseTaskFlag
                                       + "&strCloseUnitFlag=" + strCloseUnitFlag
                                       + "&strCloseAcntFlag=" + strCloseAcntFlag
                                       + "&strCloseFlag="     + strCloseFlag;
                                       
     
     <ajax:open callback="on_getCloseCheckXML" 
         param="param" 
         method="POST" 
         urlvalue="/edi/ccom001.cc"/>
     
     <ajax:callback function="on_getCloseCheckXML">
     if( rowsNode.length > 0 ){
         var closeFlag = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
         if( closeFlag == "TRUE"){
             showMessage(INFORMATION, OK, "GAUCE-1000", "매입 일마감되어 발주매일 등록/수정이 불가능합니다.");
         }else{
            //변경또는 신규 내용을 저장하시겠습니까?
             if( showMessage(QUESTION, YESNO, "USER-1010") == 1 ){    // validation 체크
                 
                 var param = getParam();
                 <ajax:open callback="on_saveXML"
                     param="param" 
                     method="POST" 
                     urlvalue="/edi/eord106.eo"/>
                 
                 <ajax:callback function="on_saveXML">
                   
                 if( rowsNode.length > 0 ){
                     ret = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
                     if( ret > 0 ){
                         new_row = "1";
                         showMessage(INFORMATION, OK, "GAUCE-1000", "정상적으로 저장되었습니다.");
                         getList();
                     }else {
                         showMessage(INFORMATION, OK, "GAUCE-1000", ret);
                     }  
                 }
                 </ajax:callback>
             }   
         }
     }
     </ajax:callback>
 }
 
 /**
  * getVenRound()
  * 작 성 자 : 김경은
  * 작 성 일 : 2011-04-18
  * 개    요 :  반올림 구분 
  * return값 : void
  */   
 function getVenRound(){
     var param = "&goTo=getVenRoundFlag" 
               + "&strCd=" + '<%=STR_CD%>'
               + "&venCd=" + '<%=VEN_CD%>';
     
     <ajax:open callback="on_getVenRoundFlagXML" 
         param="param" 
         method="POST" 
         urlvalue="/edi/ccom001.cc"/>
     
     <ajax:callback function="on_getVenRoundFlagXML">
     if( rowsNode.length > 0 ){   
         venRoundFlag = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
     } else {
         venRoundFlag = "";
     }    
     </ajax:callback>
 }  
 
/**
 * ordDtChange()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-12
 * 개    요   : 발주일 변경시
 * return : void
 */
 function ordDtChange(){
     var ordDt = getRawData(frm.ord_dt.value);
     
     if(dateCheck(document.getElementById("ord_dt"))){
         if(strToday > ordDt){
             showMessage(EXCLAMATION, OK, "USER-1180", "발주일");
             frm.ord_dt.value     = strToday;
             frm.deli_dt.value    = addDate("d", 1, strToday);
             frm.prc_app_dt.value = addDate("d", 1, strToday);
             frm.ord_dt.focus();
         }else{
             frm.deli_dt.value    = addDate("d", 1, frm.ord_dt.value);
             frm.prc_app_dt.value = addDate("d", 1, frm.ord_dt.value);
         }
     }
 }

/**
 * deliDtChange()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-12
 * 개    요   : 납품예정일 변경시
 * return : void
 */
 function deliDtChange(){
     var ordDt  = getRawData(frm.ord_dt.value);      // 발주일
     var deliDt = getRawData(frm.deli_dt.value);     // 납품예정일
         
     if(dateCheck(document.getElementById("deli_dt"), addDate("d", 1, frm.ord_dt.value))){
         if(ordDt > deliDt){
             showMessage(EXCLAMATION, OK, "USER-1020", "납품예정일","발주일");
             frm.deli_dt.value = addDate("d", 1, frm.ord_dt.value);
             frm.deli_dt.focus();
         }
         frm.prc_app_dt.value = frm.deli_dt.value;
     }
 }

/**
 * prcAppDtChange()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-12
 * 개    요   : 가격적용일 변경시
 * return : void
 */
 function prcAppDtChange(){
     var deliDt    = getRawData(frm.deli_dt.value);      // 납품예정일
     var prcAppDt  = getRawData(frm.prc_app_dt.value);   // 가격적용일
 
     if(dateCheck(document.getElementById("prc_app_dt"),deliDt)){
         if(deliDt > prcAppDt){
             showMessage(EXCLAMATION, OK, "USER-1020", "가격적용일","납품예정일");
             frm.prc_app_dt.value = frm.deli_dt.value;
             frm.prc_app_dt.focus();
         }
     }
 }

/**
 * skuKillFocus()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-20
 * 개    요   : 단품코드 Kill Focus시..
 * return : void
 */
 function skuKillFocus(row){
     var orgValue = document.getElementById("d_orgSkuCd"+(row)).value;
     var newValue = document.getElementById("d_skuCd"+(row)).value;
     if( newValue != "" ){
         if(orgValue != newValue){
             document.getElementById("d_orgSkuCd"+(row)).value = newValue;
             skuValCheck(row, "1");
         }
     }else{
         setSkuInfo(row, "");        // 단품정보 Clear
     }
     
     calcDetail(row);               // 다시 계산
 }


/**
 * pumbunValCheck()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-25
 * 개    요 :  브랜드  Validation Check
 * return값 : void
 */
 function pumbunValCheck(){
	 
     var param    = "";
     var strCd    = "<%=STR_CD%>";
     var venCd    = "<%=VEN_CD%>";
     var skuFlag  = "1";
     var pumbunCd = frm.pumbun_cd.value;
    
    // alert("!!");
     param = "&goTo=getPumbunSTK&strcd=" + strCd
              + "&vencd="                  + venCd
              + "&skuFlag="                + skuFlag
              + "&pumbunCd="               + pumbunCd;
    
     <ajax:open callback="on_loadedXML" 
         param="param" 
         method="POST" 
         urlvalue="/edi/ccom001.cc"/>
    
     <ajax:callback function="on_loadedXML">
         if( rowsNode.length <= 0 ){
             showMessage(EXCLAMATION, OK, "USER-1069", "브랜드");
          } 
       
    </ajax:callback>
 }
 
 /**
  * chkSlipProdStat()
  * 작 성 자 : 김경은
  * 작 성 일 : 2011-08-18
  * 개    요 :  전표상태를 조회한다.
  * return값 : void
  */ 
 function chkSlipProdStat(flag){
     var strCd          = "<%=STR_CD%>";                  // 점
     var slip_no        = frm.slip_no.value;              // 전표번호
     var slip_proc_stat = "";

     var param = "&goTo=getSlipProcStat&strCd="+strCd+"&slip_no="+slip_no;

     <ajax:open callback="on_loadedXML" 
         param="param" 
         method="POST" 
         urlvalue="/edi/ccom001.cc"/>
    
     <ajax:callback function="on_loadedXML">
     //alert(rowsNode.length);
     if( rowsNode.length != 0 ){
         showMessage(INFORMATION, OK, "GAUCE-1218");    
     }else{
         if(flag == "Save"){
             // 매입일마감 체크
             closeCheck();
         }else if(flag == "Delete"){
             var strCd  = '<%=STR_CD%>';
             var slipNo = frm.slip_no.value;
             
             // 삭제 메세지 
             if(showMessage(Question, YESNO, "USER-1023") == 1){  
                 var param = "&goTo=delete"
                           + "&strCd="         + strCd
                           + "&slipNo="        + slipNo;
                 <ajax:open callback="on_deleteXML"
                     param="param" 
                     method="POST" 
                     urlvalue="/edi/eord106.eo"/>
                 
                 <ajax:callback function="on_deleteXML">
                   
                 if( rowsNode.length > 0 ){
                     ret = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
                     if( ret > 0 ){
                         new_row = "1";
                         showMessage(INFORMATION, OK, "GAUCE-1000", "삭제되었습니다.");
                         getList();
                     }else {
                         showMessage(INFORMATION, OK, "GAUCE-1000", ret);
                     }  
                 }
                 </ajax:callback>
             }
         }
     }
       
    </ajax:callback>
    
 }

/**
 * setfocus()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-25
 * 개    요   : 포커스세팅 및 입력내용 블럭지정
 * return : void
 */
 function setfocus(objNm, row){
     document.getElementsByName(objNm)[row].select(); 
     document.getElementsByName(objNm)[row].focus();
 }

--></script>
</head>


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">
<form name="frm">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="396" class="title"><img
                    src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13"
                    align="absmiddle" class="PR05" /> EDI 규격단품 발주등록</td>
                <td>
                <table border="0" align="right" cellpadding="0" cellspacing="0">
                    <tr>
                        <td><img src="/edi/imgs/btn/search.gif" width="50" height="22" id="search" onclick="btn_Search();" /></td>
                        <td><img src="/edi/imgs/btn/new.gif"    width="50" height="22" id="newrow" onclick="btn_New();" /></td>
                        <td><img src="/edi/imgs/btn/del.gif"    width="50" height="22" id="del"    onclick="btn_Delete();" /></td>
                        <td><img src="/edi/imgs/btn/save.gif"   width="50" height="22" id="save"   onclick="btn_Save();" /></td>
                        <td><img src="/edi/imgs/btn/excel.gif"  width="61" height="22" id="excel"  /></td>
                        <td><img src="/edi/imgs/btn/print.gif"  width="50" height="22" id="prints" /></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td class="PT01 PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
            <tr>
                <td>
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                    <tr>
                        <th width="80" class="point">점</th>
                        <td width="140">
                            <input type="hidden" name="s_str_cd" id="s_str_cd" value="<%=STR_CD%>">
                            <input type="text" name="s_str_nm" id="s_str_nm" size="20" maxlength="10" value="<%=STR_NM%>" disabled="disabled" />
                        </td>
                        <th width="80" class="point input_pk">협력사</th>
                        <td width="140">
                            <input type="hidden" name="s_ven_cd" id="s_ven_cd" value="<%=VEN_CD%>" disabled="disabled" /> 
                            <input type="text"   name="s_ven_nm" id="s_ven_nm" size="20" value="<%=VEN_NM%>" disabled="disabled" />
                        </td>
                        <th>브랜드코드</th>
                        <td>
                            <select name="s_pumbun_cd" id="s_pumbun_cd" style="width: 193;"></select>
                        </td>
                    </tr>
                    <tr>
                        <th width="80">전표상태</th>
                        <td width="140">
                            <select name="s_slip_proc_falg" id="s_slip_proc_falg" style="width:132;"></select>
                            <input type="hidden" name="slip_no_new" id="slip_no_new" >
                        </td>
                        <th width="80">기준일</th>
                        <td width="140">
                            <select name="s_date_type" id="s_date_type" style="width: 132;"></select>
                        </td>
                        <th width="80">기간</th>
                        <td><input type="text" name="start_date" id="start_date" size="10" title="YYYY/MM/DD" value="" maxlength="10"
                            onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);"
                            style='text-align: center;' /> <img 
                            src="<%=dir%>/imgs/icon/ico_calender.gif" alt="시작일" align="absmiddle" onclick="openCal('G',start_date);return false;" />
                        ~   <input type="text" name="end_date" id="end_date" size="10" value="" maxlength="10" 
                            onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);"
                            style='text-align: center;' /> <img
                            src="<%=dir%>/imgs/icon/ico_calender.gif" alt="시작일" align="absmiddle" onclick="openCal('G',end_date);return false;" />
                        </td>
                    </tr>
                    <tr>
                        <th width="80">전표구분</th>
                        <td colspan="3">
                           <input type="radio" name="s_slip_flag" id="s_slip_flag" value="%" checked="checked" /> 전체 
                           <input type="radio" name="s_slip_flag" id="s_slip_flag" value="A" /> 매입    
                           <input type="radio" name="s_slip_flag" id="s_slip_flag" value="B" /> 반품
                        </td>
                        <th>전표번호</th>
                        <td colspan="3">
                          <input type="text" name="s_slip_no" id="s_slip_no" size="30" maxlength="11"
                                 onkeypress="javascript:onlyNumber();" onBlur="slip_format(this.value, this);" style='text-align: center;' />
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
                <td width="250">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="BD4A">
                    <tr valign="top">
                        <td>
                        <div id="divListTitle" style="width: 250; overflow: hidden;">
                        <table width="520" border="0" cellpadding="0" cellspacing="0" class="g_table">
                            <tr>
                                <th width="65">전표구분</th>
                                <th width="90">전표번호</th>
                                <th width="75">발주일</th>
                                <th width="65">전표상태</th>
                                <th width="110">브랜드</th>
                                <th width="85">점</th>
                                <th width="15">&nbsp;</th>
                            </tr>
                        </table>
                        </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        <div id="divListContent" style="width: 250px; height: 440px; overflow: scroll" onscroll="scrollControl('list');">
                        <table width="500" border="0" cellspacing="0" cellpadding="0" class="g_table" id="tb_list">
                        </table>
                        </div>
                        </td>
                    </tr>
                </table>
                </td>
                <td class="PL10">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="PT01 PB03">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                            <tr>
                                <th width="70">전표번호</th>
                                <td width="95">
                                    <input type="text" name="slip_no" id="slip_no" size="14" maxlength="11" value="" disabled="disabled" style='text-align:center' />
                                </td>
                                <th width="70">전표상태</th>
                                <td width="95">
                                    <input type="text"   name="slip_proc_stat_nm" id="slip_proc_stat_nm" size="14"  value="" disabled="disabled" />
                                    <input type="hidden" name="slip_proc_stat"    id="slip_proc_stat"    value="" />
                                </td>
                                <th width="70" class="point">전표구분</th>
                                <td>
                                   <input type="radio" name="slip_flag" id="slip_flag" value="A" checked="checked" /> 매입    
                                   <input type="radio" name="slip_flag" id="slip_flag" value="B" /> 반품 
                                </td>
                            </tr>
                           
                            <tr>
                                <th class="point">사후구분</th>
                                <td>
                                    <input class="input_pk" type="text"   name="aft_ord_flag_nm" id="aft_ord_flag_nm" size="14" disabled="disabled" value="" />
                                    <input type="hidden" name="aft_ord_flag"    id="aft_ord_flag"    value="" />
                                </td>
                                
                                <th class="point">브랜드</th>
                                <td colspan="3">
                                    <select name="pumbun_cd" id="pumbun_cd" class="input_pk" onchange="getPumbunInfo();" style="width: 180;"></select>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>발주구분</th>
                                <td>
                                    <input type="text"   name="ord_flag_nm" id="ord_flag_nm" size="14" disabled="disabled" value="" />
                                    <input type="hidden" name="ord_flag"    id="ord_flag"    value="" />
                                </td>
                                <th>바이어</th>        
                                <td colspan = "3">
                                    <input type="text"   name="buyer_cd" id="buyer_cd" size="10" disabled="disabled" />
                                    <input type="text"   name="buyer_nm" id="buyer_nm" size="15" disabled="disabled" />
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="point">협력사</th>
                                <td>
                                    <input type="hidden" name="ven_cd" id="ven_cd" value="" disabled="disabled" /> 
                                    <input class="input_pk" type="text"   name="ven_nm" id="ven_nm" value="" size="14" disabled="disabled" />
                                </td>
                                <th>거래형태</th>
                                <td>
                                    <input type="hidden" name="biz_type"    id="biz_type"    value="" disabled="disabled" /> 
                                    <input type="text"   name="biz_type_nm" id="biz_type_nm" value="" size="14" disabled="disabled" />
                                </td>
                                <th>과세구분</th>
                                <td>
                                    <input type="hidden" name="tax_flag"    id="tax_flag"    value=""  disabled="disabled" /> 
                                    <input type="text"   name="tax_flag_nm" id="tax_flag_nm"  value="" size="14" disabled="disabled" />
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="point">발주일</th>
                                <td>
                                    <input class="input_pk" type="text" name="ord_dt" id="ord_dt" size="10" maxlength="10"
                                            onkeypress="javascript:onlyNumber();" onblur="ordDtChange();" onfocus="dateValid(this);"
                                            style='text-align: center; IME-MODE: disabled' /> <img
                                            src="<%=dir%>/imgs/icon/ico_calender.gif" id="img_ord_dt"
                                            alt="발주일" align="absmiddle" onclick="openCal('G',ord_dt);return false;" />
                                </td>
                                <th>발주확정일</th>
                                <td>
                                    <input name="conf_dt" id="conf_dt" size="14" disabled="disabled" />
                                </td>
                                <th>발주주체</th>
                                <td>
                                    <input type="hidden" name="ord_own_flag"    id="ord_own_flag"    value="" disabled="disabled" /> 
                                    <input type="text"   name="ord_own_flag_nm" id="ord_own_flag_nm" value="" size="14" disabled="disabled" />
                                </td>
                            </tr>
                            <tr>
                                <th class="point">납품예정일</th>
                                <td>
                                    <input class="input_pk" type="text" name="deli_dt" id="deli_dt" size="10" maxlength="10"
                                            onkeypress="javascript:onlyNumber();" onblur="deliDtChange();" onfocus="dateValid(this);"
                                            style='text-align: center; IME-MODE: disabled' /> <img
                                            src="<%=dir%>/imgs/icon/ico_calender.gif" id="img_deli_dt"
                                            alt="납품예정일" align="absmiddle" onclick="openCal('G',deli_dt);return false;" />
                                </td>
                                <th class="point">가격적용일</th>
                                <td>
                                    <input class="input_pk" type="text" name="prc_app_dt" id="prc_app_dt" size="10" maxlength="10"
                                            onkeypress="javascript:onlyNumber();" onblur="prcAppDtChange();" onfocus="dateValid(this);"
                                            style='text-align: center; IME-MODE: disabled' /> <img
                                            src="<%=dir%>/imgs/icon/ico_calender.gif" id="img_prc_app_dt"
                                            alt="가격적용일" align="absmiddle" onclick="openCal('G',prc_app_dt);return false;" />
                                </td>
                                <th>검품확정일</th>
                                <td>
                                    <input name="chk_dt" id="chk_dt" size="14" disabled="disabled" />
                                </td>
                            </tr>
                            
                            <tr>
                                <th>수량계</th>
                                <td>
                                    <input name="tot_qty" id="tot_qty" size="14" style="text-align: right;" disabled="disabled" />
                                </td>
                                <th>원가계</th>
                                <td>
                                    <input name="tot_cost_amt" id="tot_cost_amt" size="14" style="text-align: right;" disabled="disabled" />
                                </td>
                                <th>매가계</th>
                                <td>
                                    <input name="tot_sale_amt" id="tot_sale_amt" size="14" style="text-align: right;" disabled="disabled" />
                                </td>
                            </tr>
                           
                            <tr>
                                <th>차익액</th>
                                <td>
                                    <input name="gap_tot_amt" id="gap_tot_amt" size="14" style="text-align: right;" disabled="disabled" />
                                </td>
                                <th>차익율</th>
                                <td colspan="3">
                                    <input name="gap_rate" id="gap_rate" size="14" style="text-align: right;" disabled="disabled" />
                                </td>
                            </tr>
                            
                            <tr>
                                <th>비고</th>
                                <td colspan="6">
                                    <input type="text" size="76" name="remark" id="remark" onblur="getByteValLength(this);" />
                                </td>
                            </tr>
                                
                        </table>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="right PB03">
                                    <img src="<%=dir%>/imgs/btn/add_row.gif" id="img_add" onclick="addDetailRow();" /><img
                                         src="<%=dir%>/imgs/btn/del_row.gif" id="img_del" onclick="delDetailRow();" />
                                </td>
                            </tr>                                                                                                                                                                            
                        </table>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="BD4A">
                            <tr valign="top"> 
                                <td width="100%">
                                <div id="divDetailTitle" style="width: 560px; overflow: hidden;">
                                <table width=1025 border="0" cellspacing="0" cellpadding="0" class="g_table">
                                    <tr> 
                                        <th rowspan="2" width="35">No</th>
                                        <th rowspan="2" width="25">선택<input type="checkbox" name="chkAll" id="chkAll" onclick="checkAll();" disabled='disabled'></th>
                                        <th rowspan="2" width="120">* 단품코드</th>
                                        <th rowspan="2" width="85">단품명</th>
                                        <th rowspan="2" width="45">단위</th>
                                        <th rowspan="2" width="45">* 수량</th>
                                        <th colspan="2" width="170">원가</th>
                                        <th colspan="2" width="170">매가</th>
                                        <th rowspan="2" width="45">차익율</th>
                                        <th rowspan="2" width="45">평균<BR>판매량</th>
                                        <th rowspan="2" width="95">평균<BR>판매액</th>
                                        <th rowspan="2" width="55">현재고</th>
                                        <th rowspan="2" width="15">&nbsp;</th>
                                    </tr>
                                    <tr>
                                        <th width="85">* 단가</th>
                                        <th width="85">금액</th>
                                        <th width="85">* 단가</th>
                                        <th width="85">금액</th>
                                    </tr>
                                </table>
                                </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                <div id="divDetailContent" style="width: 560px; height: 159px; overflow:scroll" onscroll="scrollControl('detail');">
                                <table width=1005 border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_detail'>
                                </table>
                                </div>
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
<input type="hidden" name="last_row"        id="last_row"         value=-1>          <!-- List 이전 선택 Row -->
<input type="hidden" name="reg_date"        id="reg_date"         value="99999999">  <!-- 전표등록일자 -->
<input type="hidden" name="bottle_slip_yn"  id="bottle_slip_yn"   value="">          <!-- 공병여부 -->
<input type="hidden" name="vat_tamt"        id="vat_tamt"         value="">          <!-- 부가세합 -->
<input type="hidden" name="del_detail"      id="del_detail"       value="">          <!-- 삭제된 상세순번 -->
</form>
</body>
</html>

