<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주관리 > OFFER SHEET 등록
 * 작 성 일 : 2010.03.12
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pcod5030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : OFFER SHEET 등록
 * 이    력 : 
 *        2010.03.04 (박래형) 신규작성       
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


var strGSkuType     = null;   //단품종류 (1:규격, 3:의류)
var strGStyleType   = null;   //의류단품종류(1:A, 2:B 타입의류)
var strGBizType     = null;   //거래형태 (1:직매입,2:특정)

var blnSkuChanged   = false;

var inta = 0;
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
     strYYYYMM =   strToday.substring(0,6); 
     
     // Input Data Set Header 초기화     
     DS_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>'); 
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
     DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>'); 
     DS_I_SKU_SALEPRC.setDataHeader('<gauce:dataset name="H_SKU_SALEPRC"/>'); 
     DS_O_ORDERNO.setDataHeader('<gauce:dataset name="H_ORDERNO"/>'); 
     DS_O_OFFERNO.setDataHeader('<gauce:dataset name="H_OFFERNO"/>'); 
     DS_CHECKTREATMENTOFF_NO.setDataHeader('<gauce:dataset name="H_CHECKTREATMENTOFF_NO"/>'); 
     
     
     // Output Data Set Header 초기화
     
     //그리드 초기화
     gridCreate1(); //마스터
     gridCreate2(); //디테일
     
     // EMedit에 초기화
     // 조회부
     initEmEdit(EM_S_S_OFFER_DT,        "TODAY",      NORMAL);        //OFFER 기간 1
     initEmEdit(EM_S_E_OFFER_DT,        "TODAY",      NORMAL);        //OFFER 기간 2
     initEmEdit(EM_S_OFFER_SEQ_NO,      "GEN^30",     NORMAL);        //OFFER NO
     initEmEdit(EM_S_PUMBUN_CD,         "000000",     NORMAL);        //브랜드코드
     initEmEdit(EM_S_PUMBUN_NM,         "GEN",        READ);          //브랜드명
     initEmEdit(EM_S_VEN_CD,            "000000",     NORMAL);        //협력사코드
     initEmEdit(EM_S_VEN_NM,            "GEN",        READ);          //협력사명
     
     // 입력부     
     initEmEdit(EM_I_PUMBUN_CD,         "000000",     PK);            //브랜드코드            
     initEmEdit(EM_O_PUMBUN_NM,         "GEN",        READ);          //브랜드명             
     initEmEdit(EM_O_BUYER_CD,          "GEN^6",      READ);          //바이어코드           
     initEmEdit(EM_O_BUYER_NM,          "GEN",        READ);          //바이어명            
     initEmEdit(EM_I_VEN_CD,            "000000",     PK);            //협력사코드           
     initEmEdit(EM_O_VEN_NM,            "GEN",        READ);          //협력사명            
     initEmEdit(EM_I_SHIP_PORT,         "GEN^40",     NORMAL);        //선적항             
     initEmEdit(EM_I_ORIGIN,             "GEN^100",   NORMAL);        //ORIGIN           
     initEmEdit(EM_I_OFFER_DT,          "YYYYMMDD",   PK);            //OFFER 일자        
     initEmEdit(EM_I_OFFER_NO,          "GEN^13",     PK);            //OFFER NO        
     initEmEdit(EM_I_PACKING,           "GEN^100",    NORMAL);        //Packing         
     initEmEdit(EM_I_INSURANCE,         "GEN^100",    NORMAL);        //Insurance       
     initEmEdit(EM_I_SHIPMENT,          "GEN^100",    NORMAL);        //Shippment       
     initEmEdit(EM_I_VALIDITY,          "GEN^100",    NORMAL);        //Validity        
     initEmEdit(EM_I_EXC_APP_DT,        "YYYYMMDD",   NORMAL);        //환율적용일            
     initEmEdit(EM_I_EXC_RATE,          "NUMBER^13^2",NORMAL);        //환율             
     initEmEdit(EM_I_BL_DT,             "YYYYMMDD",   NORMAL);        //B/L 일자          
     initEmEdit(EM_I_LC_DATE,           "YYYYMMDD",   NORMAL);        //L/C DATE        
     initEmEdit(EM_I_BL_NO,             "GEN^30",     NORMAL);        //B/L NO          
     initEmEdit(EM_I_LC_NO,             "GEN^40",     NORMAL);        //L/C NO
//     initEmEdit(EM_I_LC_EFFECTIVE_DT,   "TODAY",      NORMAL);      //L/C 유효일         
     initEmEdit(EM_I_LC_EFFECTIVE_DT,   "YYYYMMDD",   NORMAL);        //L/C 유효일         
     initEmEdit(EM_I_LC_OPEN_BANK,      "GEN^40",     NORMAL);        //L/C 개설은행        
     initEmEdit(EM_O_PRICE,             "GEN^100",    NORMAL);        //Price           
     initEmEdit(EM_O_PRICE_2,           "NUMBER^13^2",READ);          //Price2          
     initEmEdit(EM_I_COMMODITY,         "GEN^100",    NORMAL);        //COMMODITY        
     initEmEdit(EM_I_PAYMENT,           "GEN^100",    NORMAL);        //Payment         
     initEmEdit(EM_I_VENDOR_INFO,       "GEN^200",    NORMAL);        //Vendor Info
     initEmEdit(EM_I_INSPECTION,        "GEN^100",    NORMAL);        //Inspection
     initEmEdit(EM_I_PACKING_CHARGE,    "NUMBER^13^2",NORMAL);        //Packing Charge
     initEmEdit(EM_I_SHIPPER,           "GEN^100",    NORMAL);        //Shipper     
     initEmEdit(EM_I_NCV,               "NUMBER^13^2",NORMAL);        //NCV
     
     //콤보 초기화
     initComboStyle(LC_S_STR_CD,            DS_STR,                 "CODE^0^30,NAME^0^80",  1, PK);               //조회부 점
     
     initComboStyle(LC_I_STR_CD,            DS_STR,                 "CODE^0^30,NAME^0^80",  1, PK);               //점               
     initComboStyle(LC_I_ARRI_PORT,         DS_I_ARRI_PORT,         "CODE^0^30,NAME^0^80",  1, NORMAL);           //도착항
     initComboStyle(LC_I_IMPORT_COUNTRY,    DS_I_IMPORT_COUNTRY,    "CODE^0^30,NAME^0^80",  1, NORMAL);           //수입국가            
     initComboStyle(LC_I_PRC_COND,          DS_I_PRC_COND,          "CODE^0^30,NAME^0^180", 1, NORMAL);           //가격조건            
     initComboStyle(LC_I_CURRENCY_CD,       DS_I_CURRENCY,          "CODE^0^30,NAME^0^80",  1, NORMAL);           //화폐단위            
     initComboStyle(LC_I_PAYMENT_COND,      DS_I_PAYMENT_COND,      "CODE^0^30,NAME^0^180", 1, NORMAL);           //결제조건            
     initComboStyle(LC_I_PAYMENT_DTL_COND,  DS_I_PAYMENT_DTL_COND,  "CODE^0^30,NAME^0^80",  1, NORMAL);           //결제조건 상세
     
     //공통코드에서 데이터 가지고 오기
     getStore("DS_STR", "Y", "", "N");                          // 점코드     

     getEtcCode("DS_I_CURRENCY",        "D", "P217", "N");      // 화폐단위 
     getEtcCode("DS_I_PRC_COND",        "D", "P218", "N");      // 가격조건 
     getEtcCode("DS_I_PAYMENT_COND",    "D", "P219", "N");      // 결제조건 
     getEtcCode("DS_I_PAYMENT_DTL_COND","D", "P220", "N");      // 결제조건상세 
     getEtcCode("DS_I_ARRI_PORT",       "D", "P222", "N");      // 도착항 
     getEtcCode("DS_I_IMPORT_COUNTRY",  "D", "P223", "N");      // 수입국가 
     getEtcCode("DS_ORD_UNIT_CD",       "D", "P013", "N");      // 단위 

     insComboData( LC_I_ARRI_PORT, "", "",1);
     insComboData( LC_I_IMPORT_COUNTRY, "", "",1);
     insComboData( LC_I_PRC_COND, "", "",1);
     insComboData( LC_I_CURRENCY_CD, "", "",1);
     insComboData( LC_I_PAYMENT_COND, "", "",1);
     insComboData( LC_I_PAYMENT_DTL_COND, "", "",1);
     
     //데이터셋 등록
     registerUsingDataset("pord503","DS_LIST,DS_IO_MASTER,DS_IO_DETAIL,DS_I_SKU_SALEPRC,DS_O_ORDERNO" );

     LC_S_STR_CD.Index = 0; // 조회부 점
     LC_S_STR_CD.Focus(); // 조회부 포커스
//     LC_I_STR_CD.Index = 0; // 입력부 점
     
     EM_S_S_OFFER_DT.Text = (strYYYYMM + '01');
     
     //화면 로드시 입력 컴퍼넌트 비활성화
     checkValidation(false);
     LC_I_PAYMENT_DTL_COND.Enable = false;
     
 }

function gridCreate1(){
    var hdrProperies = '<FC>id=STR_NM          name="점"            width=50    align=left</FC>'
                     + '<FC>id=OFFER_DT        name="OFFER 일자"    width=80    align=center Mask="XXXX-XX-XX"</FC>'
                     + '<FC>id=OFFER_SHEET_NO  name="OFFER NO"      width=120   align=center </FC>'
                     + '<FC>id=OFFER_SEQ_NO    name="OFFER_SEQ_NO"  width=120   show=false</FC>'
                     + '<FC>id=PUMBUN_NM       name="브랜드"          width=80    align=left</FC>'
                     + '<FC>id=VEN_NM          name="협력사"        width=80    align=left</FC>'
                     + '<FC>id=CHECKVALUE      name="체크벨류"      width=80    align=left</FC>';                     

    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies = '<FC>id=CHECK1          width=20               align=center EditStyle=CheckBox HeadCheckShow=true edit={IF(CHECKVALUE2="","true","false")}</FC>'
                     + '<FC>id={currow}        name="NO"              width=50      align=center Edit=none sumtext=""    </FC>'
                     + '<FC>id=SKU_CD          name="단품코드"         width=120     align=center   EditStyle=Popup sumtext="합계" edit={IF(CHECKVALUE2="","true","false")}</FC>'
                     + '<FC>id=SKU_NM          name="단품명"           width=140     align=left Edit=none </FC>'
                     + '<FC>id=ORD_UNIT_CD     name="단위"             width=50      align=left    Edit=none EditStyle=Lookup  Data="DS_ORD_UNIT_CD:CODE:NAME"</FC>'
                     + '<FC>id=STYLE_CD        name="스타일코드"       width=210     align=center Edit=none </FC>'
                     + '<FC>id=COLOR_CD        name="칼라"             width=80     align=center Edit=none </FC>'
                     + '<FC>id=SIZE_CD         name="사이즈"           width=80     align=center Edit=none </FC>'
                     + '<FC>id=MODEL_NO        name="모델코드"         width=100     align=center Edit=none </FC>'
                     + '<FC>id=ORDER_NO        name="ORDER NO"         width=120     align=center Mask="XX-XXXXXX-XXXXX" EditStyle=Popup  sumtext=@sum </FC>'
                     + '<FC>id=OFFER_QTY       name="* OFFER 수량"     width=80     align=right Edit=Numeric  sumtext=@sum </FC>'
                     + '<FC>id=INVOICE_QTY     name="INVOICE 수량"     width=80     align=right Edit=none  sumtext=@sum </FC>'
                     + '<FC>id=CHK_QTY         name="입고수량"         width=80     align=right Edit=none  sumtext=@sum </FC>'
                     + '<FC>id=NOT_IN_QTY      name="미입고수량"       width=80     align=right Edit=none  sumtext=@sum </FC>'
                     + '<FC>id=OFFER_UNIT_AMT  name="* 외화단가"       width=80     align=right            sumtext=@sum </FC>'
                     + '<FC>id=OFFER_AMT       name="외화금액"         width=100    align=right Edit=none  sumtext=@sum </FC>'
                     + '<FC>id=CHECKVALUE      name="중복체크"         width=100    align=right Edit=none  show=false </FC>';                     

    initGridStyle(GR_DETAIL, "common", hdrProperies, true);
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
     
    inta = 0;
     
    // 변경, 추가내역이 있을 경우
    if (DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1073") != 1 )
           return;
    }
   
    
    if(checkValue("Search")){
        DS_IO_MASTER.ClearData();
        DS_IO_DETAIL.ClearData();
        inta = 0;
        bfListRowPosition = 0; 
        getList();
        setPorcCount("SELECT", GR_MASTER);
        if(DS_LIST.CountRow == 0){
            LC_S_STR_CD.Focus();
            checkValidation(false);
            return;
        }

        GR_MASTER.Focus();        
        
        //입력부 활성화
        checkValidation(true);  
        EM_I_PUMBUN_CD.Enable = false;        //브랜드코드 비활성화
        EM_I_VEN_CD.Enable = false;           //협력사코드 비활성화
        enableControl(IMG_I_PUMBUN, false);   //브랜드이미지 비활성화
        enableControl(IMG_I_VEN, false);      //협력사이미지 비활성화
        LC_I_STR_CD.Enable = false;           //점코드 비활성화
        EM_I_OFFER_NO.Enable = false;         //점코드 비활성화
        EM_I_OFFER_DT.Enable = false;         //점코드 비활성화
        enableControl(IMG_I_OFFER_DT, false); //브랜드이미지 비활성화
    }
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {

    // 전표마스터 추가후 행추가, 삭제 버튼 활성화 (저장되지 않은 내용이 있을경우 추가되지 않음)
    if(DS_LIST.NameValue(DS_LIST.CountRow, "OFFER_SHEET_NO") == ""){
          if(showMessage(QUESTION, YESNO, "USER-1072") != 1 ){
              return;
          }else{
              DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
          }
    }else{
        DS_LIST.Addrow(); 
    }
         
    DS_IO_MASTER.Addrow();            
    DS_IO_DETAIL.ClearData();   //디테일 클리어
    
    var idx;
    if(DS_IO_MASTER.CountRow > 0){
         var strOfferNo = DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_SHEET_NO");
         if(strOfferNo.length == 0){
             LC_I_STR_CD.Index = 0;                  //점코드
             
             initEmEdit(EM_I_OFFER_DT, "TODAY", PK); //OFFER 일자
             
             //화면 로드시 입력 컴퍼넌트 비활성화
             checkValidation(true);    
         }
     }
     LC_I_STR_CD.Focus();
}

/**
 * btn_Delete()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {      
    
    // 삭제할 데이터 없는 경우
    if (DS_IO_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1019");
        return;
    }
            
    // 신규 전표인 경우 데이터셋에서만 삭제
    if(DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_SHEET_NO").length == 0){
        DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
        DS_LIST.DeleteRow(DS_LIST.RowPosition);
        return;
    }    
    
    if(!checkValue("Delete"))
        return;
    
    if(showMessage(Question, YESNO, "USER-1023") == 1){
        deletedata();   
    }
}

/**
 * btn_Save()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {          
     
    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated && !DS_IO_MASTER.IsUpdated){
       //저장할 내용이 없습니다
       showMessage(EXCLAMATION, OK, "USER-1028");
       return;
    }
    
    if(DS_IO_DETAIL.CountRow <= 0){
        showMessage(QUESTION, OK, "GAUCE-1000", "상세데이터 등록후 저장하십시오."); 
        GR_DETAIL.Focus();
        return;
    }    
    
    if(!checkValue("Save"))
        return;
    
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") == 1 ){              
        saveMaster();
        btn_Search();  
    } 
    
    bfListRowPosition = 0; 
    blnSkuChanged = false;
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
 * checkValidation()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-107
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
 function checkValidation(flag){
     
     EM_I_OFFER_NO.Enable      = flag;
     EM_I_PUMBUN_CD.Enable     = flag;
//   EM_O_PUMBUN_NM.Enable = flag;
//   EM_O_BUYER_CD.Enable  = flag;
//   EM_O_BUYER_NM.Enable  = flag;
     EM_I_VEN_CD.Enable        = flag;
//   EM_O_VEN_NM.Enable    = flag;
     EM_I_SHIP_PORT.Enable     = flag;
     EM_I_LC_DATE.Enable       = flag;
     EM_I_LC_NO.Enable         = flag;
//     EM_I_LC_EFFECTIVE_DT.Enable   = flag;
     EM_I_LC_OPEN_BANK.Enable  = flag;
     EM_I_EXC_APP_DT.Enable    = flag;
     EM_I_PAYMENT.Enable       = flag;
     EM_I_VENDOR_INFO.Enable   = flag;
     EM_I_OFFER_DT.Enable      = flag;
//   EM_I_OFFER_NO.Enable      = flag;
     EM_I_SHIPMENT.Enable      = flag;
     EM_I_VALIDITY.Enable      = flag;
     EM_I_PACKING.Enable       = flag;
     EM_O_PRICE.Enable         = flag;
//   EM_O_PRICE_2.Enable   = flag;
     EM_I_INSPECTION.Enable    = flag;
     
     EM_I_INSURANCE.Enable     = flag;
     EM_I_BL_DT.Enable         = flag;
     EM_I_BL_NO.Enable         = flag;
     EM_I_LC_EFFECTIVE_DT.Enable = flag;
     EM_I_COMMODITY.Enable     = flag;   

     LC_I_STR_CD.Enable        = flag;
     LC_I_CURRENCY_CD.Enable   = flag;
     LC_I_PRC_COND.Enable      = flag;
     LC_I_PAYMENT_COND.Enable  = flag;
//     LC_I_PAYMENT_DTL_COND.Enable = flag;
     LC_I_ARRI_PORT.Enable     = flag;
     LC_I_IMPORT_COUNTRY.Enable= flag;   

     EM_I_PACKING_CHARGE.Enable = flag;
     EM_I_SHIPPER.Enable        = flag;
     EM_I_NCV.Enable            = flag; 
     EM_I_ORIGIN.Enable          = flag; 
     EM_I_EXC_RATE.Enable       = flag; 
     
     enableControl(IMG_I_PUMBUN, flag);
     enableControl(IMG_I_VEN, flag);
     enableControl(IMG_I_BL_DT, flag);
     enableControl(IMG_I_EXC_APP_DT, flag);
//     enableControl(IMG_ADD, flag);
//     enableControl(IMG_DEL, flag);
     enableControl(IMG_I_LC_DATE, flag);
     enableControl(IMG_I_LC_EFFECTIVE_DT, flag);
     enableControl(IMG_I_OFFER_DT, flag);
 }

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
    var strSOfferDt      = EM_S_S_OFFER_DT.Text;        // 조회기간1
    var strEOfferDt      = EM_S_E_OFFER_DT.Text;        // 조회기간2
    var strOfferNo       = EM_S_OFFER_SEQ_NO.Text;      // OFFER NO
    var strPumbun        = EM_S_PUMBUN_CD.Text;         // 브랜드
    var strVen           = EM_S_VEN_CD.Text;            // 협력사
   
    var goTo       = "getList" ;    
    var action     = "O";     
    var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strSOfferDt="+encodeURIComponent(strSOfferDt)     
                    + "&strEOfferDt="+encodeURIComponent(strEOfferDt)      
                    + "&strOfferNo="+encodeURIComponent(strOfferNo)        
                    + "&strPumbun="+encodeURIComponent(strPumbun)       
                    + "&strVen="+encodeURIComponent(strVen);  
    TR_MAIN.Action="/dps/pord503.po?goTo="+goTo+parameters;  
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
    var strOfferYm       = DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_YM");      // OFFER_YM
    var strOfferSeqNo    = DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_SEQ_NO");  // OFFER_SEQ_NO
    
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)  
                    + "&strOfferYm="+encodeURIComponent(strOfferYm)
                    + "&strOfferSeqNo="+encodeURIComponent(strOfferSeqNo);  
    TR_S_MAIN.Action="/dps/pord503.po?goTo="+goTo+parameters;  
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
     var strOfferYm       = DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_YM");      // OFFER_YM
     var strOfferSeqNo    = DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_SEQ_NO");  // OFFER_SEQ_NO
    
     var goTo       = "getDetail" ;    
     var action     = "O";     
     var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)   
                     + "&strOfferYm="+encodeURIComponent(strOfferYm)
                     + "&strOfferSeqNo="+encodeURIComponent(strOfferSeqNo);  
     TR_S_MAIN.Action="/dps/pord503.po?goTo="+goTo+parameters;  
     TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
     TR_S_MAIN.Post();

     GR_DETAIL.ColumnProp('CHECK1','HeadCheck')= "FALSE";     
  }
 
  /**
   * saveMaster()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-29
   * 개    요 :  마스터 디테일 저장
   * return값 : void
   */
  function saveMaster(){  
       
//    alert("저장전 " + DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "OFFER_SEQ_NO"));
      
      var strOfferDt = strToday;
      var strOfferYm = strYYYYMM;
      var strOfferNo = EM_I_OFFER_NO.Text;
      var parameters = "&strOfferDt="+encodeURIComponent(strOfferDt)
                      + "&strOfferYm="+encodeURIComponent(strOfferYm)
                      + "&strOfferNo="+encodeURIComponent(strOfferNo); 
      
      TR_MAIN.Action="/dps/pord503.po?goTo=save&strFlag=save"+parameters;;  
      TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)"; 
      TR_MAIN.Post();  
  }
 
  /**
   * deletedata()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-29
   * 개    요 :  마스터 디테일 삭제
   * return값 : void
   */
  
  function deletedata(){
      var strStrCd       = DS_LIST.NameValue(DS_LIST.RowPosition, "STR_CD");
      var strOfferYm     = DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_YM")
      var strOfferSeqNo  = DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_SEQ_NO");
  //    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PROC_FLAG") != 'N'){
  //        alert("삭제할 수 없는 데이터 입니다.");     
  //    }
      DS_LIST.DeleteRow(DS_LIST.RowPosition);   
      DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);   
      var goTo       = "save";    
      var action     = "I";     
      var parameters = "&strFlag=delete" 
                     + "&strStrCd="+encodeURIComponent(strStrCd)
                     + "&strOfferYm="+encodeURIComponent(strOfferYm)
                     + "&strOfferSeqNo="+encodeURIComponent(strOfferSeqNo);
      TR_MAIN.Action="/dps/pord503.po?goTo="+goTo+parameters; 
      TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)"; 
      TR_MAIN.Post(); 
      
      DS_IO_DETAIL.ClearData(); 
      getList();
      DS_IO_DETAIL.ClearData();               
  }    
  
 /**
  * addDetailRow()
  * 작 성 자     :박래형
  * 작 성 일     : 2010-03-05
  * 개    요        : 디테일 등록위한  ROW 추가
  * return값 : void
  */
 function addDetailRow(){
//   alert(strSkuType);
    if(DS_IO_MASTER.CountRow == 0){
           showMessage(QUESTION, OK, "USER-1000", "전표 마스터 내용을 먼저 추가해 주세요.");
           return;
    }
    if(checkValue("Add")){
        if(strGSkuType == 1){      //규격단품
            GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = false;
            GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
            GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;
            
        }else if(strGSkuType == 2){//신선단품
            GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = false;
            GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
            GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;   
            
        }else if(strGSkuType == 3){//의류단품
        	if(strGStyleType == "1"){
                GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = true;
                GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = true;
                GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = true;         		
        	}else{
                GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = true;
                GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
                GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;         		
        	}    
        }
                
        //키값 수정 못하게 비활성화
        EM_I_OFFER_DT.Enable = false;    
        LC_I_STR_CD.Enable   = false;
        EM_I_PUMBUN_CD.Enable= false;
        EM_I_VEN_CD.Enable   = false;
        EM_I_OFFER_NO.Enable = false;
        enableControl(IMG_I_PUMBUN, false);   //브랜드이미지 비활성화
        enableControl(IMG_I_VEN, false);      //협력사이미지 비활성화
    
        //디테일 Row 추가
        DS_IO_DETAIL.Addrow(); 
        GR_DETAIL.SetColumn("SKU_CD");
        GR_DETAIL.Focus();    
        
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STR_CD")        = LC_I_STR_CD.BindColVal;        // 점
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "OFFER_YM")      = setOfferYm(EM_I_OFFER_DT.Text);      // OFFER_YM        
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "OFFER_SEQ_NO") = DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_SEQ_NO");
    }
 } 

 /**
* delDetailRow()
* 작 성 자 : 박래형
* 작 성 일 : 2010-03-05
* 개    요 : 디테일 행삭제
* return값 : void
*/
function delDetailRow(){
    if(DS_IO_DETAIL.CountRow == 0){
        showMessage(QUESTION, OK, "USER-1019");
            return;
        }

    sel_DeleteRow( DS_IO_DETAIL, "CHECK1" );
      //그리드 CHEKCBOX헤더 체크해제
    GR_DETAIL.ColumnProp('CHECK1','HeadCheck')= "false";
      
    if(DS_IO_DETAIL.CountRow == 0){
        EM_I_OFFER_DT.Enable = true;    
        LC_I_STR_CD.Enable   = true;
        EM_I_PUMBUN_CD.Enable= true;
        EM_I_VEN_CD.Enable   = true;    
        EM_I_OFFER_NO.Enable = true;
        enableControl(IMG_I_PUMBUN, true);   //브랜드이미지 비활성화
        enableControl(IMG_I_VEN, true);      //협력사이미지 비활성화
        EM_I_OFFER_DT.Enable = true;         //점코드 비활성화
        enableControl(IMG_I_OFFER_DT, true);   //브랜드이미지 비활성화
    }
} 

/**
* setOfferYm(OfferDt)
* 작 성 자 : 박래형
* 작 성 일 : 2010-03-29
* 개    요 : OfferYm을 정한다(Offer일자의 년월을 구한다)
* return값 : void
*/
function setOfferYm(OfferDt){
    var strOfferYm = null;
    strOfferYm = OfferDt.substring(0,6);
    return strOfferYm;
} 

/**
* getPumbunInfo()
* 작 성 자 : 박래형
* 작 성 일 : 2010-03-07
* 개    요 :  브랜드팝업 관련 데이터 조회 및 세팅
* return값 : void
*/
function getPumbunInfo(){
    var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
    var strStrCd        = LC_I_STR_CD.BindColVal;                                    // 점
    var strOrgCd        = "";                                                        // 조직코드
    var strVenCd        = "";                                                        // 협력사
    var strBuyerCd      = "";                                                        // 바이어
    var strPumbunType   = "0";                                                       // 브랜드유형
    var strUseYn        = "Y";                                                       // 사용여부
    var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
    var strSkuType      = "";                                                        // 단품종류(3:의류단품)
    var strItgOrdFlag   = "";                                                        // 통합발주여부
    var strBizType      = "1";                                                       // 거래형태(1:직매입,2:특정)
    var strSaleBuyFlag  = "1";                                                       // 판매분매입구분(1:사전매입)
   

//    if(EM_I_PUMBUN_CD.Text != ""){
//        setStrPbnNmWithoutPop( "DS_O_RESULT", EM_I_PUMBUN_CD, EM_O_PUMBUN_NM, "Y", "1"
//                              , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
//                              , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
//                              , strBizType,strSaleBuyFlag);
//        if(DS_O_RESULT.CountRow == 1){
//
//            strGSkuType    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "SKU_TYPE");
//            strGStyleType  = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "STYLE_TYPE");
//            strGBizType    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "BIZ_TYPE");
//            // 바이어
//            EM_O_BUYER_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "CHAR_BUYER_CD");
//            EM_O_BUYER_NM.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "BUYER_EMP_NAME");
//            
//            EM_I_VEN_CD.Text   = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_CD");
//            EM_O_VEN_NM.Text   = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_NAME");
//
//        }
//    }else{
        var rtnMap = strPbnPop(EM_I_PUMBUN_CD, EM_O_PUMBUN_NM, 'Y'
                                ,strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                ,strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                ,strBizType,strSaleBuyFlag);
        if(rtnMap != null){
            
            strGSkuType    = rtnMap.get("SKU_TYPE");
            strGStyleType  = rtnMap.get("STYLE_TYPE");
            strGBizType    = rtnMap.get("BIZ_TYPE");

            EM_O_BUYER_CD.Text   = rtnMap.get("CHAR_BUYER_CD");
            EM_O_BUYER_NM.Text   = rtnMap.get("BUYER_EMP_NAME");
            
            EM_I_VEN_CD.Text   = rtnMap.get("VEN_CD");
            EM_O_VEN_NM.Text   = rtnMap.get("VEN_NAME");
            
        }
//    }
}

/**
 * setStrPbnNmWithoutPopCall()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-10
 * 개    요 :  브랜드입력시 부가정보 바로세팅
 * return값 : void
 */
 function setStrPbnNmWithoutPopCall(){
    var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
    var strStrCd        = LC_I_STR_CD.BindColVal;                                    // 점
    var strOrgCd        = "";                                                        // 조직코드
    var strVenCd        = "";                                                        // 협력사
    var strBuyerCd      = "";                                                        // 바이어
    var strPumbunType   = "0";                                                       // 브랜드유형
    var strUseYn        = "Y";                                                       // 사용여부
    var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
    var strSkuType      = "";                                                        // 단품종류(3:의류단품)
    var strItgOrdFlag   = "";                                                        // 통합발주여부
    var strBizType      = "1";                                                       // 거래형태(1:직매입,2:특정)
    var strSaleBuyFlag  = "1";                                                       // 판매분매입구분(1:사전매입)

   var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_I_PUMBUN_CD, EM_O_PUMBUN_NM, "Y", "1"
                                   , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                   , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                   , strBizType,strSaleBuyFlag);

   if(DS_O_RESULT.CountRow == 1){

       strGSkuType    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "SKU_TYPE");
       strGStyleType  = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "STYLE_TYPE");
       strGBizType    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "BIZ_TYPE");
       // 바이어
       EM_O_BUYER_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "CHAR_BUYER_CD");
       EM_O_BUYER_NM.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "BUYER_EMP_NAME");
       
       EM_I_VEN_CD.Text   = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_CD");
       EM_O_VEN_NM.Text   = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_NAME");
       return true;
   }else{
       return false;
   }
 }

 /**
 * getSkuPop(row, colid)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-28
 * 개    요 :  단품 팝업  관련 데이터 조회 및 세팅
 * return값 : void
 *///래형래형
 function getSkuPop(row, colid, popFlag){
     
//   alert("왜");
     var intRow          = 1;
     var strSkuCd        = DS_IO_DETAIL.NameValue(row, "SKU_CD");
     var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
     var strStrCd        = LC_I_STR_CD.BindColVal;                                  // 점
     var strPumbunCd     = EM_I_PUMBUN_CD.Text;                                       // 브랜드코드
     var strPumbunType   = "";                                                        // 브랜드유형
     var strBizType      = "";                                                        // 거래형태(1:직매입)
     var strUseYn        = "Y";              
     
//     if(strSkuCd != ""){        
//         var rtnMap = setStrSkuNmWithoutToGridPop( "DS_O_RESULT", strSkuCd, "", "Y", popFlag,
//                                                   strUsrCd, strStrCd, strPumbunCd, strPumbunType, strBizType,
//                                                   strUseYn);
//         if(rtnMap != null){
//             DS_IO_DETAIL.NameValue(row, "SKU_CD")        = rtnMap.get("SKU_CD");         // 단품코드
//             DS_IO_DETAIL.NameValue(row, "SKU_NM")        = rtnMap.get("SKU_NAME");       // 단품명
             
//             DS_IO_DETAIL.NameValue(row, "STR_CD")        = LC_I_STR_CD.BindColVal;               // 점코드
//             DS_IO_DETAIL.NameValue(row, "OFFER_YM")      = setOfferYm(EM_I_OFFER_DT.Text);      // OFFER_YM
//             DS_IO_DETAIL.NameValue(row, "OFFER_SEQ_NO")  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "OFFER_SEQ_NO");  // OFFER_SEQ_NO
             
//             getSkuInfo();
//         }
//     }else{
         var rtnList = strSkuMultiSelPop(strSkuCd, "", "Y"
                                         , strUsrCd, strStrCd, strPumbunCd, strPumbunType, strBizType
                                         , strUseYn);
//     }
     if(rtnList != null){
         for(var i = 0; i < rtnList.length; i++){
             if(i == 0 )
                 intRow = row;
             else
                 DS_IO_DETAIL.AddRow();
             
             DS_IO_DETAIL.NameValue(row+i, "SKU_CD")      = rtnList[i].SKU_CD;
             DS_IO_DETAIL.NameValue(row+i, "SKU_NM")      = rtnList[i].SKU_NAME;

             DS_IO_DETAIL.NameValue(row+i, "STR_CD")        = LC_I_STR_CD.BindColVal;                                  // 점코드
             DS_IO_DETAIL.NameValue(row+i, "OFFER_YM")      = setOfferYm(EM_I_OFFER_DT.Text);                          // OFFER_YM
             DS_IO_DETAIL.NameValue(row+i, "OFFER_SEQ_NO")  = DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_SEQ_NO");  // OFFER_SEQ_NO
          
             getSkuInfo2(row+i);
         }
         if(rtnList.length > 1)
             setFocusGrid(GR_DETAIL, DS_IO_DETAIL,intRow,"OFFER_QTY");
     }
 }

 /**
 * getABSkuPop(row, colid)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-28
 * 개    요 :  AB단품 팝업  관련 데이터 조회 및 세팅
 * return값 : void
 */
 function getABSkuPop(row, colid){
     var intRow          = 1;
     var strSkuCd        = DS_IO_DETAIL.NameValue(row, colid);
     var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
     var strStrCd        = LC_I_STR_CD.BindColVal;                                    // 점
     var strPumbunCd     = EM_I_PUMBUN_CD.Text;                                       // 브랜드코드
     var strPumbunType   = "";                                                        // 브랜드유형
     var strBizType      = "";                                                        // 거래형태(1:직매입)
     var strUseYn        = "Y";                                                       // 사용여부   

     if(strGStyleType == "1"){
//         alert("의류단품A형");
//         if(strSkuCd != "" ){
//             rtnMap = setSkuATypeNmWithoutToGridPordPop("DS_O_RESULT", strSkuCd, "", "Y", "1"
//                                                         , strUsrCd, strStrCd, strPumbunCd, "", ""
//                                                         , "", strPumbunType, strBizType, strUseYn );   
//         }else{
             rtnList = skuATypeMultiSelPordPop(strSkuCd, "", "Y"
                                              , strUsrCd, strStrCd, strPumbunCd, "", ""
                                              , "", strPumbunType, strBizType, strUseYn);
//         }
      }else{
//           alert("의류단품B형");
//         if(strSkuCd != ""){
//             rtnMap = setSkuBTypeNmWithoutToGridPordPop("DS_O_RESULT", strSkuCd, "", "Y", "1"
//                                                         , strUsrCd, strStrCd, strPumbunCd, "", ""
//                                                         , "", "", "",  strPumbunType, strBizType
//                                                         , strUseYn, "", "" );  
//         }else{
      
             rtnList = skuBTypeMultiSelPordPop(strSkuCd, "", "Y"
                                              , strUsrCd, strStrCd, strPumbunCd, "", ""
                                              , "", "", "", strPumbunType, strBizType
                                              , strUseYn, "", "");
//         }
      }

     // 코드 입력시
//     if(strSkuCd != ""){
//         if(rtnMap != null){
//             DS_IO_DETAIL.NameValue(row, "SKU_CD")        = rtnMap.get("SKU_CD");         // 단품코드
//             DS_IO_DETAIL.NameValue(row, "SKU_NM")        = rtnMap.get("SKU_NAME");       // 단품명

//             DS_IO_DETAIL.NameValue(row, "STR_CD")        = LC_I_STR_CD.BindColVal;               // 점코드
//             DS_IO_DETAIL.NameValue(row, "OFFER_YM")      = setOfferYm(EM_I_OFFER_DT.Text);      // OFFER_YM
//             DS_IO_DETAIL.NameValue(row, "OFFER_SEQ_NO")  = DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_SEQ_NO");  // OFFER_SEQ_NO

//             getSkuInfo();
//         }
//     }else{
         // 멀티셀렉트 팝업 선택시
         if(rtnList != null){
             for(var i = 0; i < rtnList.length; i++){
                 if(i == 0 )
                     intRow = row;
                 else
                     DS_IO_DETAIL.AddRow();
                 
                 DS_IO_DETAIL.NameValue(row+i, "SKU_CD")      = rtnList[i].SKU_CD;
                 DS_IO_DETAIL.NameValue(row+i, "SKU_NM")      = rtnList[i].SKU_NAME;

                 DS_IO_DETAIL.NameValue(row+i, "STR_CD")        = LC_I_STR_CD.BindColVal;               // 점코드
                 DS_IO_DETAIL.NameValue(row+i, "OFFER_YM")      = setOfferYm(EM_I_OFFER_DT.Text);      // OFFER_YM
                 DS_IO_DETAIL.NameValue(row+i, "OFFER_SEQ_NO")  = DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_SEQ_NO");  // OFFER_SEQ_NO

                 getSkuInfo2(row+i);
             }
             if(rtnList.length > 1)
                 setFocusGrid(GR_DETAIL, DS_IO_DETAIL,intRow,"OFFER_QTY");
         }
  //   }
 } 

 /**
 * getSkuInfo()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-03
 * 개    요 :  단품 매가 원가 
 * return값 : void
 */
 function getSkuInfo(){  
     
//   alert("단품정보");
     var strStrCd = LC_I_STR_CD.BindColVal;
     var strSkuCd = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SKU_CD");
     
     var goTo       = "getSkuInfo" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strSkuCd="+encodeURIComponent(strSkuCd);     
     TR_S_MAIN.Action="/dps/pord503.po?goTo="+goTo+parameters;  
     TR_S_MAIN.KeyValue="SERVLET("+action+":DS_I_SKU_SALEPRC=DS_I_SKU_SALEPRC)";
     TR_S_MAIN.Post(); 

     if(DS_I_SKU_SALEPRC.CountRow == 0){
//aaa         showMessage(EXCLAMATION, OK, "GAUCE-1000", "해당 단품에 가격정보가 없습니다. 확인바랍니다."); 
//aaa         DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
//aaa         DS_IO_DETAIL.InsertRow(DS_IO_DETAIL.RowPosition);
         return false;
     }
     
//     alert("카운트 = " + DS_I_SKU_SALEPRC.CountRow);
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"SKU_NM")      = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"SKU_NM"); 
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"STYLE_CD")    = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"STYLE_CD"); 
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"COLOR_CD")    = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"COLOR_CD"); 
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"SIZE_CD")     = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"SIZE_CD"); 
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"PUMMOK_CD")   = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"PUMMOK_CD"); 
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"MODEL_NO")    = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"MODEL_NO"); 
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORD_UNIT_CD") = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"SALE_UNIT_CD"); //단위 

     //래형래형
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STR_CD")       = LC_I_STR_CD.BindColVal;
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "OFFER_YM")     = setOfferYm(EM_I_OFFER_DT.Text);      
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "OFFER_SEQ_NO") = DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_SEQ_NO");  // OFFER_SEQ_NO
     
//     alert(DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_SEQ_NO"));
     
 //    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PRT_REQ_SEQ_NO")= DS_LIST.NameValue(DS_LIST.RowPosition, "PRT_REQ_SEQ_NO");
 }

 /**
 * getSkuInfo2(row)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-03
 * 개    요 :  단품 매가 원가 
 * return값 : void
 */
 function getSkuInfo2(row){  
     
     var strStrCd = LC_I_STR_CD.BindColVal;
     var strSkuCd = DS_IO_DETAIL.NameValue(row, "SKU_CD");
     
     var goTo       = "getSkuInfo" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strSkuCd="+encodeURIComponent(strSkuCd);     
     TR_S_MAIN.Action="/dps/pord503.po?goTo="+goTo+parameters;  
     TR_S_MAIN.KeyValue="SERVLET("+action+":DS_I_SKU_SALEPRC=DS_I_SKU_SALEPRC)";
     TR_S_MAIN.Post(); 

     if(DS_I_SKU_SALEPRC.CountRow == 0){
         return false;
     }
     
     DS_IO_DETAIL.NameValue(row,"SKU_NM")      = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"SKU_NM"); 
     DS_IO_DETAIL.NameValue(row,"STYLE_CD")    = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"STYLE_CD"); 
     DS_IO_DETAIL.NameValue(row,"COLOR_CD")    = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"COLOR_CD"); 
     DS_IO_DETAIL.NameValue(row,"SIZE_CD")     = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"SIZE_CD"); 
     DS_IO_DETAIL.NameValue(row,"PUMMOK_CD")   = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"PUMMOK_CD"); 
     DS_IO_DETAIL.NameValue(row,"MODEL_NO")    = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"MODEL_NO"); 
     DS_IO_DETAIL.NameValue(row,"ORD_UNIT_CD") = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"SALE_UNIT_CD"); //단위 

     //래형래형
     DS_IO_DETAIL.NameValue(row, "STR_CD")       = LC_I_STR_CD.BindColVal;
     DS_IO_DETAIL.NameValue(row, "OFFER_YM")     = setOfferYm(EM_I_OFFER_DT.Text);      
     DS_IO_DETAIL.NameValue(row, "OFFER_SEQ_NO") = DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_SEQ_NO");  // OFFER_SEQ_NO
 }

 /**
 * checkSkuInfo()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-03
 * 개    요 :  저장시 단품 데이터 체크 
 * return값 : void
 */
 function checkSkuInfo(row, flag){
     
 //  alert("단품정보쳌");
     var strStrCd = LC_I_STR_CD.BindColVal;
     var strSkuCd = DS_IO_DETAIL.NameValue(row, "SKU_CD");
     
     var goTo       = "getSkuInfo" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strSkuCd="+encodeURIComponent(strSkuCd);     
     TR_MAIN.Action="/dps/pord503.po?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_I_SKU_SALEPRC=DS_I_SKU_SALEPRC)";
     TR_MAIN.Post(); 

//     alert("strSkuCd = "+ strSkuCd);
     if(DS_I_SKU_SALEPRC.CountRow == 0){
         if(flag =='I'){ //입력할때
             showMessage(EXCLAMATION, OK, "GAUCE-1000", "해당 단품에 정보가 없습니다. 확인바랍니다."); 
             DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
             return false;           
         }else{         //저장할때
             return false;                       
         }
     }else{
         return true;
     }
 }

 /**
 * skuValCheck(row, colid)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-22
 * 개    요 :  입력시  Validation Check
 * return값 : void
 */
 function skuValCheck(row, colid){
     
//     alert("단품정보쳌ㅇㅇㅇ");
 //  alert("2");
     var intRow          = 1;
     var strSkuCd        = DS_IO_DETAIL.NameValue(row, colid);
     var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
     var strStrCd        = LC_I_STR_CD.BindColVal;                                         // 점
     var strPumbunCd     = EM_I_PUMBUN_CD.Text;                                         // 브랜드코드
     var strPumbunType   = "";                                                        // 브랜드유형
     var strBizType      = "";                                                        // 거래형태(1:직매입)
     var strUseYn        = "Y";                                                       // 사용여부   

     var rtnMap = setStrSkuNmWithoutToGridPordPop( "DS_O_RESULT", strSkuCd, "", "Y", "0",
                                               strUsrCd, strStrCd, strPumbunCd, strPumbunType, strBizType,
                                               strUseYn);

//     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SKU_CD") = rtnMap.get("SKU_CD");
//     alert(rtnMap.get("SKU_CD"));
     if(rtnMap != null)
         return true;
     else
         return false;
 }

 /**
 * setCalDetail(row)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-11
 * 개    요 :  디테일 그리드 병경에 따른 총금액 수정
 * return값 : void
 */
 function setCalDetail(row){
     
     var strOfferQty     = DS_IO_DETAIL.NameValue(row, "OFFER_QTY");        //OFFER수량
     var strOfferUnitAmt = DS_IO_DETAIL.NameValue(row, "OFFER_UNIT_AMT");   //외화단가
     var strOfferAmt     = DS_IO_DETAIL.NameValue(row, "OFFER_AMT");        //외화금액
     
     strOfferAmt    =  strOfferQty * strOfferUnitAmt;    
     DS_IO_DETAIL.NameValue(row, "OFFER_AMT") = strOfferAmt; 
     EM_O_PRICE_2.Text = DS_IO_DETAIL.NameSum("OFFER_AMT",0,0);
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "OFFER_TOT_AMT") = DS_IO_DETAIL.NameSum("OFFER_AMT",0,0);    
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "OFFER_TOT_QTY") = DS_IO_DETAIL.NameSum("OFFER_QTY",0,0);    
 }


 /**
 * checkTreatmentOffNo()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-07-18
 * 개    요 :  마스터 삭제시 OFFER 마감체크 및 invoice에 등록된 전표인지 확인
 * return값 : void
 */
 function checkTreatmentOffNo(){

     var strStrCd        = DS_LIST.NameValue(DS_LIST.RowPosition, "STR_CD");
     var strOfferYm      = DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_YM");
     var strOfferSeqNo   = DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_SEQ_NO");
     var strOfferSheetNo = DS_LIST.NameValue(DS_LIST.RowPosition, "OFFER_SHEET_NO");

     //alert("strStrCd = " + strStrCd);
     //alert("strOfferYm = " + strOfferYm);
     //alert("strOfferSeqNo = " + strOfferSeqNo);
     //alert("strOfferSheetNo = " + strOfferSheetNo);
     
     var strReturn       = null;
     
     var goTo       = "checkTreatmentOffNo" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
				    + "&strOfferYm="+encodeURIComponent(strOfferYm)     
                    + "&strOfferSeqNo="+encodeURIComponent(strOfferSeqNo)
                    + "&strOfferSheetNo="+encodeURIComponent(strOfferSheetNo);     
     TR_S_MAIN.Action="/dps/pord503.po?goTo="+goTo+parameters;  
     TR_S_MAIN.KeyValue="SERVLET("+action+":DS_CHECKTREATMENTOFF_NO=DS_CHECKTREATMENTOFF_NO)";
     TR_S_MAIN.Post(); 
     
     if(DS_CHECKTREATMENTOFF_NO.NameValue(DS_CHECKTREATMENTOFF_NO.RowPosition, "CLOSE_FLAG") == "Y"){
         strReturn = "B";   // OFFER 마감 처리 됬음(삭제불가능)
    	 
     }else if(DS_CHECKTREATMENTOFF_NO.NameValue(DS_CHECKTREATMENTOFF_NO.RowPosition, "CHECKVALUE") !=""){
         strReturn = "A";   // INVOICE에 등록되있음 (삭제불가능) 
         
     }else{
         strReturn = "C";   // 삭제가능
     }
     
     return strReturn;
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
          if(EM_S_S_OFFER_DT.Text.length == 0){                                //OFFER 기간1
              showMessage(EXCLAMATION, OK, messageCode, "OFFER 기간");
              EM_S_S_OFFER_DT.Text = strToday;
              EM_S_S_OFFER_DT.Focus();
              return false;
          }  
          if(EM_S_E_OFFER_DT.Text.length == 0){                                //OFFER 기간2
              showMessage(EXCLAMATION, OK, messageCode, "OFFER 기간");
              EM_S_E_OFFER_DT.Text = strToday;
              EM_S_E_OFFER_DT.Focus();
              return false;
          } 

          if(EM_S_S_OFFER_DT.Text > EM_S_E_OFFER_DT.Text){                             // 조회일 정합성
              showMessage(EXCLAMATION, OK, "USER-1015");
              EM_S_S_OFFER_DT.Focus();
              return false;
          }
          return true; 
          
      case "Add":
          if(LC_I_STR_CD.Text.length == 0){                                    // 점
              showMessage(EXCLAMATION, OK, "USER-1002", "점");                 
              LC_I_STR_CD.Focus();                                              
              return false;                                                      
          }
          
          if(EM_I_PUMBUN_CD.Text.length == 0){                                 // 브랜드코드
              showMessage(EXCLAMATION, OK, "USER-1002", "브랜드코드");                 
              EM_I_PUMBUN_CD.Focus();                                              
              return false;                                                      
          }
                                                                                 
          if(EM_I_VEN_CD.Text.length == 0){                                    // 협력사 코드
              showMessage(EXCLAMATION, OK, "USER-1002", "협력사코드");
              EM_I_VEN_CD.Focus();
              return false;
           } 
                                                                                 
          if(EM_I_OFFER_DT.Text.length == 0){                                  // OFFER 일자
              showMessage(EXCLAMATION, OK, "USER-1002", "OFFER일자");
              EM_I_OFFER_DT.Focus();
              return false;
           } 
                    
//        if(!getOfferNo()){                                  // OFFER NO
//            showMessage(EXCLAMATION, OK, "USER-1002", "OFFER NO");                 
//            EM_I_OFFER_NO.Focus();                                              
//            return false;                                                      
//        }

          if(EM_I_OFFER_NO.Text.length == 0){                                  // OFFER NO
              showMessage(EXCLAMATION, OK, "USER-1002", "OFFER NO");                 
              EM_I_OFFER_NO.Focus();                                              
              return false;                                                      
          }
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "SHIP_PORT", "선적항", "EM_I_SHIP_PORT") )  //선적항 
              return false;
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "ORIGIN", "ORIGIN", "EM_I_ORIGIN") )  //ORIGIN 
              return false;
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "PACKING", "PACKING", "EM_I_PACKING") )  //PACKING 
              return false;
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "INSURANCE", "INSURANCE", "EM_I_INSURANCE") )  //INSURANCE 
              return false;
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "SHIPPMENT", "SHIPPMENT", "EM_I_SHIPMENT") )  //SHIPPMENT 
              return false;          
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "VALIDITY", "VALIDITY", "EM_I_VALIDITY") )  //VALIDITY 
              return false;

          if(EM_I_EXC_RATE.Text < 0){                                           //환율
              showMessage(EXCLAMATION, OK, "USER-1008", "환율",  "0");
              EM_I_EXC_RATE.Focus();
              return false;
          }
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "LC_NO", "LC_NO", "EM_I_LC_NO") )  //LC_NO 
              return false;

          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "BL_NO", "BL_NO", "EM_I_BL_NO") )  //BL_NO 
              return false;
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "LC_OPEN_BANK", "L/C개설은행", "EM_I_LC_OPEN_BANK") )  //L/C개설은행 
              return false;
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "PRICE", "PRICE", "EM_O_PRICE") )  //PRICE 
              return false;

          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "COMMODITY", "COMMODITY", "EM_I_COMMODITY") )  //COMMODITY 
              return false;
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "PAYMENT", "PAYMENT", "EM_I_PAYMENT") )  //PAYMENT 
              return false;
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "VENDOR_INFO", "VENDOR_INFO", "EM_I_VENDOR_INFO") )  // VENDOR_INFO
              return false;          

          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "INSPECTION", "INSPECTION", "EM_I_INSPECTION") )  //INSPECTION 
              return false;
                                        
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "SHIPPER", "SHIPPER", "EM_I_SHIPPER") )  //SHIPPER 
              return false;
          
          var strSkucd        = "";                    // 단품코드
          var intQty          = 0;                     // OFFER 수량             
          var intOfferUnitAmt = 0;                     // 외화단가
          var strOrderNo      = "";
          
          var intRowCount   = DS_IO_DETAIL.CountRow;
          if(intRowCount > 0){
              for(var i=1; i <= intRowCount; i++){
                  
                  strSkucd        = DS_IO_DETAIL.NameValue(i, "SKU_CD");
                  intQty          = DS_IO_DETAIL.NameValue(i, "OFFER_QTY");
                  intOfferUnitAmt = DS_IO_DETAIL.NameValue(i, "OFFER_UNIT_AMT");
                  strOrderNo      = DS_IO_DETAIL.NameValue(i, "ORDER_NO");
                  
                  if(strSkucd.length <= 0){
                      return true;
                  }
                  // 존재하는 단품 코드인지 확인한다.
//                alert("checkSkuInfo+++" + strSkuCd);
                  if(!checkSkuInfo(i, 'S')){
                      showMessage(EXCLAMATION, OK, "USER-1069", "단품코드");
                      GR_DETAIL.SetColumn("SKU_CD");  
                      DS_IO_DETAIL.RowPosition = i;  
                      return false;
                  }
                  
                  // 중복체크
                  var dupRow = checkDupKey(DS_IO_DETAIL, "CHECKVALUE");
                  if (dupRow > 0) {
                      showMessage(QUESTION, Ok,  "USER-1044", dupRow);
                      //DS_IO_DETAIL.NameValue( dupRow, "SKU_CD")  = "";
                      
                      DS_IO_DETAIL.RowPosition = dupRow;
                      GR_DETAIL.SetColumn("SKU_CD");
                      GR_DETAIL.Focus(); 

                      return false;
                  }  
                  if(intQty <= 0){
                      showMessage(EXCLAMATION, OK, "USER-1003", "OFFER 수량");
                      DS_IO_DETAIL.RowPosition = i;
                      GR_DETAIL.SetColumn("OFFER_QTY");
                      GR_DETAIL.Focus(); 
  
                      return false;
                  }
                  
                  if(intOfferUnitAmt < 0){
                      showMessage(EXCLAMATION, OK, "USER-1008", "외화단가",  "0");
                      DS_IO_DETAIL.RowPosition = i;
                      GR_DETAIL.SetColumn("OFFER_UNIT_AMT");
                      GR_DETAIL.Focus();
       
                      return false;
                  }
                  
                  if(intOfferUnitAmt == 0){
                      showMessage(EXCLAMATION, OK, "USER-1008", "외화단가",  "0");
                      DS_IO_DETAIL.RowPosition = i;
                      GR_DETAIL.SetColumn("OFFER_UNIT_AMT");
                      GR_DETAIL.Focus();
       
                      return false;
                  }
              }
          }
          return true; 
          
      case "Save":

		 // 저장시 OFFER 마감 체크
		  var returnValue = checkTreatmentOffNo();  
		  if(returnValue == "B"){
		      showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 OFFER마감처리 되었습니다.");  
	 	      return false;
	      }
    	    
          if(LC_I_STR_CD.Text.length == 0){                                    // 점
              showMessage(EXCLAMATION, OK, "USER-1002", "점");                 
              LC_I_STR_CD.Focus();                                              
              return false;                                                      
          }
          
          if(EM_I_PUMBUN_CD.Text.length == 0){                                 // 브랜드코드
              showMessage(EXCLAMATION, OK, "USER-1002", "브랜드코드");                 
              EM_I_PUMBUN_CD.Focus();                                              
              return false;                                                      
          }
                                                                                 
          if(EM_I_VEN_CD.Text.length == 0){                                    // 협력사 코드
              showMessage(EXCLAMATION, OK, "USER-1002", "협력사코드");
              EM_I_VEN_CD.Focus();
              return false;
           } 
                                                                                 
          if(EM_I_OFFER_DT.Text.length == 0){                                  // OFFER 일자
              showMessage(EXCLAMATION, OK, "USER-1002", "OFFER일자");
              EM_I_OFFER_DT.Focus();
              return false;
           } 
                    
//        if(!getOfferNo()){                                  // OFFER NO
//            showMessage(EXCLAMATION, OK, "USER-1002", "OFFER NO");                 
//            EM_I_OFFER_NO.Focus();                                              
//            return false;                                                      
//        }

          if(EM_I_OFFER_NO.Text.length == 0){                                  // OFFER NO
              showMessage(EXCLAMATION, OK, "USER-1002", "OFFER NO");                 
              EM_I_OFFER_NO.Focus();                                              
              return false;                                                      
          }
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "SHIP_PORT", "선적항", "EM_I_SHIP_PORT") )  //선적항 
              return false;
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "ORIGIN", "ORIGIN", "EM_I_ORIGIN") )  //ORIGIN 
              return false;
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "PACKING", "PACKING", "EM_I_PACKING") )  //PACKING 
              return false;
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "INSURANCE", "INSURANCE", "EM_I_INSURANCE") )  //INSURANCE 
              return false;
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "SHIPPMENT", "SHIPPMENT", "EM_I_SHIPMENT") )  //SHIPPMENT 
              return false;          
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "VALIDITY", "VALIDITY", "EM_I_VALIDITY") )  //VALIDITY 
              return false;

          if(EM_I_EXC_RATE.Text < 0){                                           //환율
              showMessage(EXCLAMATION, OK, "USER-1008", "환율",  "0");
              EM_I_EXC_RATE.Focus();
              return false;
          }
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "LC_NO", "LC_NO", "EM_I_LC_NO") )  //LC_NO 
              return false;

          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "BL_NO", "BL_NO", "EM_I_BL_NO") )  //BL_NO 
              return false;
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "LC_OPEN_BANK", "L/C개설은행", "EM_I_LC_OPEN_BANK") )  //L/C개설은행 
              return false;
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "PRICE", "PRICE", "EM_O_PRICE") )  //PRICE 
              return false;

          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "COMMODITY", "COMMODITY", "EM_I_COMMODITY") )  //COMMODITY 
              return false;
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "PAYMENT", "PAYMENT", "EM_I_PAYMENT") )  //PAYMENT 
              return false;
          
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "VENDOR_INFO", "VENDOR_INFO", "EM_I_VENDOR_INFO") )  // VENDOR_INFO
              return false;          

          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "INSPECTION", "INSPECTION", "EM_I_INSPECTION") )  //INSPECTION 
              return false;
                                        
          if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "SHIPPER", "SHIPPER", "EM_I_SHIPPER") )  //SHIPPER 
              return false;
          
          var strSkucd        = "";                    // 단품코드
          var intQty          = 0;                     // OFFER 수량             
          var intOfferUnitAmt = 0;                     // 외화단가
          var strOrderNo      = "";
          
          var intRowCount   = DS_IO_DETAIL.CountRow;
          if(intRowCount > 0){
              for(var i=1; i <= intRowCount; i++){
                  
                  strSkucd        = DS_IO_DETAIL.NameValue(i, "SKU_CD");
                  intQty          = DS_IO_DETAIL.NameValue(i, "OFFER_QTY");
                  intOfferUnitAmt = DS_IO_DETAIL.NameValue(i, "OFFER_UNIT_AMT");
                  strOrderNo      = DS_IO_DETAIL.NameValue(i, "ORDER_NO");
                  
                  if(strSkucd.length <= 0){
                      DS_IO_DETAIL.NameValue(i, "CHECK1") = "T";
                  }else{
                      DS_IO_DETAIL.NameValue(i, "CHECK1") = "F";

                      // 존재하는 단품 코드인지 확인한다.
//                    alert("checkSkuInfo+++" + strSkuCd);
                      if(!checkSkuInfo(i, 'S')){
                          showMessage(EXCLAMATION, OK, "USER-1069", "단품코드");
                          GR_DETAIL.SetColumn("SKU_CD");  
                          DS_IO_DETAIL.RowPosition = i;  
                          return false;
                      }
                      
                      // 중복체크
                      var dupRow = checkDupKey(DS_IO_DETAIL, "CHECKVALUE");
                      if (dupRow > 0) {
                          showMessage(QUESTION, Ok,  "USER-1044", dupRow);                          
                          DS_IO_DETAIL.RowPosition = dupRow;
                          GR_DETAIL.SetColumn("SKU_CD");
                          DS_IO_DETAIL.NameValue(dupRow, "CHECK1") = "T";
                          GR_DETAIL.Focus(); 

                          return false;
                      }  

//                     if(!checkOrderNo(i)){
//                         showMessage(EXCLAMATION, OK, "USER-1069", "ORDER_NO");
//                         GR_DETAIL.SetColumn("ORDER_NO");  
//                         DS_IO_DETAIL.RowPosition = i;  
//                         return false;
//                     }
                     
                      if(intQty <= 0){
                          showMessage(EXCLAMATION, OK, "USER-1003", "OFFER 수량");
                          DS_IO_DETAIL.RowPosition = i;
                          GR_DETAIL.SetColumn("OFFER_QTY");
                          GR_DETAIL.Focus(); 
      
                          return false;
                      }
                      
                      if(intOfferUnitAmt < 0){
                          showMessage(EXCLAMATION, OK, "USER-1008", "외화단가",  "0");
                          DS_IO_DETAIL.RowPosition = i;
                          GR_DETAIL.SetColumn("OFFER_UNIT_AMT");
                          GR_DETAIL.Focus();
           
                          return false;
                      }
                      
                      if(intOfferUnitAmt == 0){
                          showMessage(EXCLAMATION, OK, "USER-1008", "외화단가",  "0");
                          DS_IO_DETAIL.RowPosition = i;
                          GR_DETAIL.SetColumn("OFFER_UNIT_AMT");
                          GR_DETAIL.Focus();
           
                          return false;
                      }
                  }
              }
          }
          sel_DeleteRow( DS_IO_DETAIL, "CHECK1" );
          if(DS_IO_DETAIL.CountRow <= 0){
              showMessage(EXCLAMATION, OK, "GAUCE-1000", "상세데이터 등록후 저장하십시오."); 
              GR_DETAIL.Focus();
              return;
          }
          return true; 
      
		case "Delete":
			//alert();
			var strCloseFlag  = DS_LIST.NameValue(DS_LIST.RowPosition, "CLOSE_FLAG"); 
			var strCheckValue = DS_LIST.NameValue(DS_LIST.RowPosition, "CHECKVALUE");   
			
			var strReturnvalue = checkTreatmentOffNo();
            
		    //alert("strReturnvalue = " + strReturnvalue);
		    
            if(strReturnvalue == "B"){
                showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 OFFER마감처리 되었습니다.");  
                return false;
            	
            }else if(strReturnvalue == "A"){
                showMessage(EXCLAMATION, OK, "GAUCE-1000", "처리완료된 전표입니다.");         //iINVOICE에 등록된 OFFER 번호임
                return false;
            	
            }else if(strReturnvalue == "C"){
            	return true;
            }
            
            /*
			if(strCheckValue != ""){
			    showMessage(EXCLAMATION, OK, "GAUCE-1000", "처리완료된 전표입니다."); //iINVOICE에 등록된 OFFER 번호임
			    return false;
			}
			
			if(strCloseFlag == "Y"){
			    showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 OFFER마감처리 되었습니다.");
			    return false;
			}
			*/
			return true; 
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
  
  /**
   * setVenInfo(code, name)
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-18
   * 개    요 :  브랜드에 따른 협력사 팝업
   * return값 : void
   */
  function setVenInfo(code, name){
      var strStrCd        = LC_I_STR_CD.BindColVal;                                    // 점
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
   * setVenNonInfo(code, name)
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-18
   * 개    요 :  브랜드에 따른 협력사 팝업
   * return값 : void
   */
  function setVenNonInfo(code, name){
      var strStrCd        = LC_I_STR_CD.BindColVal;                                    // 점
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

  /**
   * clearPumbunInfo()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-08
   * 개    요 :  브랜드정보 Clear
   * return값 : void
   */
  function clearPumbunInfo(){
      EM_O_PUMBUN_NM.Text    = "";
      EM_O_BUYER_CD.Text     = "";
      EM_O_BUYER_NM.Text     = "";
      EM_I_VEN_CD.Text       = "";
      EM_O_VEN_NM.Text       = "";
  }
  
  /**
   * getOrderNo( )
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-04-01 
   * 개    요 : OFFER NO 수기입력시 이미 존재하는 데이터 인지 확인한다
   * 사용방법 : getOrderNo()
   * return값 : 
   */
   function getOfferNo(){  
       
        var strOfferNo = EM_I_OFFER_NO.Text;
        
        var parameters = "&strOfferNo="+encodeURIComponent(strOfferNo);
        
        TR_OFF_MAIN.Action="/dps/pord503.po?goTo=searchOfferrNo"+parameters;
        TR_OFF_MAIN.KeyValue="SERVLET(O:DS_O_OFFERNO=DS_O_OFFERNO)";
        TR_OFF_MAIN.Post();      
        
        if(DS_O_OFFERNO.CountRow == 0){
            //alert("입력가능");
            return true;
        }else{
            showMessage(QUESTION, OK, "GAUCE-1000", "이미존재하는 OFFER_NO 입니다.");
            EM_I_OFFER_NO.Text = ""; 
            setTimeout("EM_I_OFFER_NO.Focus()",50);     
            return false;
        }   
   }     
  
/**
 * getOrderNoPopup( objCd, objNm )
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-14 
 * 개    요 : 단품에 따른 OrderNo 조회 팝업
 * 사용방법 : getOrderNoPopup()
 * return값 : OrderNo
 */
 function getOrderNoPopup(){
        var rtnMap  = new Map();
        var arrArg  = new Array();

        var strStrCd = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STR_CD");
        var strSkuCd = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SKU_CD");
        var strSkuNm = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SKU_NM");
        
//      alert(strSkuNm);
//      var addCondition = setAddCondition( 2, arguments );
//      strGSkuType          // 단품종류 (1:규격, 3:의류)
//      strGStyleType        // 의류단품종류(1:A, 2:B 타입의류)
//      strGBizType          // 거래형태 (1:직매입,2:특정)        
        
        arrArg.push(rtnMap);
        arrArg.push(strGSkuType);       //단품종류
        arrArg.push(strGStyleType);     //의류단품 종류
        arrArg.push(strGBizType);       //거래형태
        arrArg.push(strStrCd);          //점코드
        arrArg.push(strSkuCd);          //단품코드
        arrArg.push(strSkuNm);          //단품명
        
        var returnVal = window.showModalDialog("/dps/pord503.po?goTo=getOrderNoPopup",
                                                arrArg,
                                                "dialogWidth:550px;dialogHeight:330px;scroll:yes;" +
                                                "resizable:no;help:no;unadorned:yes;center:yes;status:no");

        if (returnVal){
            var map = arrArg[0];
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORDER_NO")     = map.get("ORDER_NO");
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORDER_YM")     = map.get("ORDER_YM");
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORDER_SEQ_NO") = map.get("ORDER_SEQ_NO");
//            checkOrderNo();       //입력된 ORDER NO가 존재하는지 체크
            return map;
        }
        return null;
 }

 /**
  * checkOrderNo(Row)
  * 작 성 자 : 
  * 작 성 일 : 2010-03-31
  * 개    요  : 입력된 ORDER NO에 따라서 데이터 체크
  * return값 : void
  */
  function checkOrderNo(Row){  
    var strStrCd    = LC_I_STR_CD.BindColVal;
    var strSkuCd    = DS_IO_DETAIL.NameValue(Row, "SKU_CD");
    var strOrder    = DS_IO_DETAIL.NameValue(Row, "ORDER_NO");
    
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strSkuCd="+encodeURIComponent(strSkuCd)
                   + "&strOrder="+encodeURIComponent(strOrder);
    
    TR_ORD_MAIN.Action="/dps/pord503.po?goTo=searchOrderNo"+parameters;
    TR_ORD_MAIN.KeyValue="SERVLET(O:DS_O_ORDERNO=DS_O_ORDERNO)";
    TR_ORD_MAIN.Post();      
    
    if(DS_O_ORDERNO.CountRow == 0){
        
        showMessage(QUESTION, OK, "GAUCE-1000", "존재하지 않는 ORDER_NO 입니다.");
        GR_DETAIL.SetColumn("ORDER_NO");
        GR_DETAIL.Focus();    
        return false;
    }else{
        //alert(DS_O_ORDERNO.NameValue(DS_O_ORDERNO.RowPosition,"ORDER_NO"));
        DS_IO_DETAIL.NameValue(Row,"ORDER_NO") = DS_O_ORDERNO.NameValue(DS_O_ORDERNO.RowPosition,"ORDER_NO");
        DS_IO_DETAIL.NameValue(Row,"ORDER_YM") = DS_O_ORDERNO.NameValue(DS_O_ORDERNO.RowPosition,"ORDER_YM");
        DS_IO_DETAIL.NameValue(Row,"ORDER_SEQ_NO") = DS_O_ORDERNO.NameValue(DS_O_ORDERNO.RowPosition,"ORDER_SEQ_NO");
        return true;
    }   
  }   
 
  /**
   * clearInputMaster()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-08
   * 개    요 :  입력부 점코드 변경시 마스터 클리어
   * return값 : void
   */
  function clearInputMaster(){
      EM_I_PUMBUN_CD.Text = "";
      EM_O_PUMBUN_NM.Text = "";
      EM_I_VEN_CD.Text = "";
      EM_O_VEN_NM.Text = "";
      EM_O_BUYER_CD.Text = "";
      EM_O_BUYER_NM.Text = "";
  }
 /**
 * test()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-11
 * 개    요 :  디테일 그리드 병경에 따른 총금액 수정
 * return값 : void
 */
 function test(){

     alert("strSkuType    : " + strGSkuType);
     alert("strStyleType  : " + strGStyleType);
     alert("strBizType    : " + strGBizType);
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

<script language=JavaScript for=TR_ORD_MAIN event=onSuccess>
    for(i=0;i<TR_ORD_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_ORD_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_OFF_MAIN event=onSuccess>
    for(i=0;i<TR_OFF_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_OFF_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_S_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_ORD_MAIN event=onFail>
    trFailed(TR_ORD_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_OFF_MAIN event=onFail>
    trFailed(TR_OFF_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=DS_LIST event=CanRowPosChange(row)>
    if (DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            return false;
        }else {
            if(DS_LIST.NameValue(row, "OFFER_SHEET_NO") == "")
                DS_LIST.DeleteRow(row);    
            DS_IO_MASTER.NameValue(row,"OFFER_TOT_QTY")  = DS_IO_MASTER.OrgNameValue(row,"OFFER_TOT_QTY");
            DS_IO_MASTER.NameValue(row,"PRICE2")         = DS_IO_MASTER.OrgNameValue(row,"PRICE2");
            return true;
        }
    }else{
        return true;
    }
    EM_I_OFFER_DT.Enable = false;         //OFFER  일자 비활성화
    LC_I_STR_CD.Enable   = false;
</script>

<script language=JavaScript for=DS_LIST event=onRowPosChanged(row)>

if(clickSORT)
    return;
    
    strGStyleType      = DS_LIST.NameValue(row, "STYLE_TYPE");
    var strOfferNo     = DS_LIST.NameValue(row, "OFFER_SHEET_NO");          // 발주번호
    var strCloseFlag   = DS_LIST.NameValue(row, "CLOSE_FLAG");              // 마감구분
    var strChkValue    = DS_LIST.NameValue(row, "CHECKVALUE");              // OFFER_NO 처리구분
    
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        
        getMaster();
        getDetail();
        
//        setCalDetail(row);    
        
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

        if(strOfferNo != ""){
            if(inta == 0){  
                inta++;
            }else{
                setPorcCount("SELECT", DS_IO_DETAIL.CountRow);      
            }           
        }
    }    
    
    /*
    // 해당 OFFER_NO가 INVOICE에 등록이 되어있으면 수정 OFFER에 등록된 단품 수정 불가
    if(strChkValue !=""){
        GR_DETAIL.ColumnProp("CHECK1", "Edit")        = "none"; 
        GR_DETAIL.ColumnProp("SKU_CD", "Edit")        = "none"; 
        
    }else{
        GR_DETAIL.ColumnProp("CHECK1", "Edit")        = "Any"; 
        GR_DETAIL.ColumnProp("SKU_CD", "Edit")        = "Any"; 
    }
    */
    
    if(strCloseFlag == "N" || strCloseFlag == ""){     
//    	alert();
        checkValidation(true);
        GR_DETAIL.Editable = true;
        enableControl(IMG_ADD, true);
        enableControl(IMG_DEL, true);  	
        
    }else if(strCloseFlag == "Y"){
//        alert("strCloseFlag = " + strCloseFlag);
        enableControl(IMG_ADD, false);
        enableControl(IMG_DEL, false);
        GR_DETAIL.Editable = false;
        LC_I_PAYMENT_DTL_COND.Enable = false;
        checkValidation(false);
    }
    
    EM_I_OFFER_NO.Enable = false;  //필수값 수정 불가능
    EM_I_OFFER_DT.Enable = false;
    enableControl(IMG_I_OFFER_DT, false);   //브랜드이미지 비활성화 
    
    
</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
</script>

<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>

</script>

<!--  ===================GR_MASTER============================ -->
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);    
</script>

<!--  DS_IO_MASTER 변경시 -->
<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
//  alert();
/*
    switch (colid) {
    
    case "PUMBUN_CD":
        if(EM_I_PUMBUN_CD.Text == "")
            clearPumbunInfo();      
        
        DS_IO_DETAIL.ClearData();
        break;
    case "VEN_CD":
        if(EM_I_VEN_CD.Text == ""){
            EM_O_VEN_NM.Text = "";
        }
        break; 
      
    case "OFFER_SHEET_NO":
        getOfferNo();
        break; 
    }
    */  
</script>

<!-- Grid GR_DETAIL oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid, "DS_IO_MASTER,DS_IO_DETAIL" );
/*
    if( row < 1){
        if( DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated){
            showMessage(EXCLAMATION, OK, "USER-1000","변경된 상세내역이 존재하여 정렬 할 수 없습니다.");
            return;
        }
        sortColId( eval(this.DataID), row , colid );
    }   
*/
</script>

<!-- Grid GR_DETAIL oneClick event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid);
/*
    if( row < 1){
        if( DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated){
            showMessage(EXCLAMATION, OK, "USER-1000","변경된 상세내역이 존재하여 정렬 할 수 없습니다.");
            return;
        }
        sortColId( eval(this.DataID), row , colid );
    }   
*/
</script>

 <!--  ===================DS_IO_DETAIL============================ -->
<!-- GR_DETAIL OnPopup event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnPopup(row,colid,data)>
        
    switch(colid){
    case "SKU_CD":
        if(DS_LIST.NameValue(DS_LIST.RowPosition, "SKU_TYPE") == '1' || strGSkuType == '1'){     //단품종류가 규격단품이면
            getSkuPop(row, colid, '1');                              //규격단품 팝업띄우는 함수
        }else if(DS_LIST.NameValue(DS_LIST.RowPosition, "SKU_TYPE") == '3' || strGSkuType == '3'){
        //  alert("의류단품인가");
            getABSkuPop(row, colid);
        }else if(DS_LIST.NameValue(DS_LIST.RowPosition, "SKU_TYPE") == '2' || strGSkuType == '2'){   
//            alert("신선단품은 등록할수 없음");
            getSkuPop(row, colid, '1');                              //신선단품 팝업띄우는 함수
            return;
        }
        break;
    case "ORDER_NO":  
        getOrderNoPopup();    
        break; 
    }
</script>

<!-- GR_DETAIL CanColumnPosChange(Row,Colid) event 처리 -->
<script language="javascript"  for=GR_DETAIL event=CanColumnPosChange(Row,Colid)>
    switch (Colid) {
    case "SKU_CD":

        if(DS_IO_DETAIL.NameValue(Row, "SKU_CD") == "")
            return;
        
        var blnSkuChk = skuValCheck(Row,Colid);
//        alert("blnSkuChk = " + blnSkuChk);
        if(blnSkuChk) {
            return true;
        }else if (!blnSkuChk && DS_IO_DETAIL.NameValue(Row,"SKU_CD") == ""){
            setTimeout("showMessage(EXCLAMATION, OK,'USER-1003', '단품코드')",50);
            DS_IO_DETAIL.DeleteRow(Row);
            DS_IO_DETAIL.InsertRow(Row);
            DS_IO_DETAIL.NameValue(Row, "SKU_CD") = "";
            DS_IO_DETAIL.NameValue(Row, "CHECK1") = 'T';
            GR_DETAIL.Focus();
            return false;
        }else {
            //if(this.NameValue(row,"SKU_CD") != "")
            setTimeout("showMessage(EXCLAMATION, OK, 'USER-1065', '정확한 단품코드')",50);
            DS_IO_DETAIL.DeleteRow(Row);
            DS_IO_DETAIL.InsertRow(Row);
            DS_IO_DETAIL.NameValue(Row, "SKU_CD") = "";
            GR_DETAIL.Focus();
            return false;
        }        
        if (blnSkuChanged) {
            //clearDataSetRow(DS_IO_DETAIL);
            if(DS_IO_DETAIL.NameValue(row,"SKU_CD") != "")
            setTimeout("showMessage(EXCLAMATION, OK, 'USER-1065', '정확한 단품코드')",50);
            DS_IO_DETAIL.DeleteRow(Row);
            DS_IO_DETAIL.InsertRow(Row);
            DS_IO_DETAIL.NameValue(Row, "SKU_CD") = "";
            GR_DETAIL.Focus();
            blnSkuChanged = false;
            return false;
        }else{
            return true;
        }
    }
</script>

<script language=JavaScript for=DS_IO_DETAIL event=onRowPosChanged(row)>

if(clickSORT)
    return;
</script>

<!--  DS_IO_DETAIL 변경시 -->
<script language=JavaScript for=DS_IO_DETAIL event=OnColumnChanged(row,colid)>
    setCalDetail(row);  
    
    var orgValue = DS_IO_DETAIL.OrgNameValue(row, "SKU_CD");
    var newValue = DS_IO_DETAIL.NameValue(row, "SKU_CD");
    switch (colid) {
    case "SKU_CD":
         blnSkuChanged = true;
        if(orgValue.length > 0)
            if(orgValue != newValue){
                //getSkuInfo();
//                this.NameValue(row,"ORG_SKU_CD") = newValue;               
            }
        DS_IO_DETAIL.NameValue(row, "CHECKVALUE") = DS_IO_DETAIL.NameValue(row, "SKU_CD") + DS_IO_DETAIL.NameValue(row, "ORDER_NO");
        break;
    case "ORDER_NO":
        checkOrderNo(row);
        setTimeout("GR_DETAIL.SetColumn('ORDER_NO')",50);
        GR_DETAIL.Focus();    

        DS_IO_DETAIL.NameValue(row, "CHECKVALUE") = DS_IO_DETAIL.NameValue(row, "SKU_CD") + DS_IO_DETAIL.NameValue(row, "ORDER_NO");
        break;
    }
</script>

<!-- GR_DETAIL OnColumnPosChanged(Row,Colid) event 처리 -->
<script language="javascript"  for=GR_DETAIL event=OnColumnPosChanged(Row,Colid)>
    switch (Colid) {
    case "ORDER_NO":
        if(blnSkuChanged)
              getSkuInfo();
        break;
    }
</script>

<!-- 디테일 삭제시 컴퍼넌트 총금액-->
<script language=JavaScript for=DS_IO_DETAIL event=OnRowDeleted(row)>   
    setCalDetail(row);  
</script>

<!-- 디테일 선택시 전체 선택/해제 -->
<script language=JavaScript for=GR_DETAIL event="OnHeadCheckClick(Col,Colid,bCheck)">      
    
    if (Colid == "CHECK1") {
        if (bCheck == 1) {
            GR_DETAIL.Redraw = false;
            for (var i = 0; i < DS_IO_DETAIL.CountRow; i++)
            {
            	DS_IO_DETAIL.NameValue(i + 1, "CHECK1") = "T";
            }    
            GR_DETAIL.Redraw = true;
        }
        else if (bCheck == 0) {
            GR_DETAIL.Redraw = false;
            for (var i = 0; i < DS_IO_DETAIL.CountRow; i++)
            {
                DS_IO_DETAIL.NameValue(i + 1, "CHECK1") = "F";
            } 
            GR_DETAIL.Redraw = true;
        }
    }
</script>

<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
    EM_S_PUMBUN_CD.Text    = "";
    EM_S_PUMBUN_NM.Text    = "";    
    EM_S_VEN_CD.Text       = "";
    EM_S_VEN_NM.Text       = "";    
    EM_S_OFFER_SEQ_NO.Text = "";
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

<!-- 점(입력)  변경시  -->
<script language=JavaScript for=LC_I_STR_CD event=OnSelChange()>
    clearInputMaster();
</script>

<!-- L/C DATE 변경시  -->
<script lanaguage=JavaScript for=EM_I_LC_DATE event=OnKillFocus()>
    checkDateTypeYMD( EM_I_LC_DATE );
</script>

<!-- L/C 유효일자 변경시  -->
<script lanaguage=JavaScript for=EM_I_LC_EFFECTIVE_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_I_LC_EFFECTIVE_DT );
</script>
  
<!-- OFFER 일자 변경시  -->
<script lanaguage=JavaScript for=EM_I_OFFER_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_I_OFFER_DT );
</script>

<!-- BL일자 변경시  -->
<script lanaguage=JavaScript for=EM_I_BL_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_I_BL_DT );
</script>

<!-- 환율적용일 변경시  -->
<script lanaguage=JavaScript for=EM_I_EXC_APP_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_I_EXC_APP_DT );
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

<!-- 신입력부 브랜드 KillFocus -->
<script language=JavaScript for=EM_I_PUMBUN_CD event=onKillFocus()>

    if(EM_I_PUMBUN_CD.Text.length == 6){
        if(setStrPbnNmWithoutPopCall()){             
            return;
        }else{
            clearPumbunInfo();
            DS_IO_DETAIL.ClearData();
            getPumbunInfo();
        }
    }else if(EM_I_PUMBUN_CD.Text.length == 0){
        clearPumbunInfo();
        DS_IO_DETAIL.ClearData();
        return;
    }else{
        clearPumbunInfo();
        DS_IO_DETAIL.ClearData();
        getPumbunInfo();
    } 
</script>

<!-- 신입력부 협력사 KillFocus -->
<script language=JavaScript for=EM_I_VEN_CD event=onKillFocus()>

    if(EM_I_VEN_CD.Text != ""){
        setVenNonInfo(EM_I_VEN_CD, EM_O_VEN_NM);
    }else
        EM_O_VEN_NM.Text = "";  
</script>

<!-- 입력부 OFFER_NO KillFocus -->
<script language=JavaScript for=EM_I_OFFER_NO event=onKillFocus()>
    getOfferNo();
</script>

<!-- 걸제조건  변경시  -->
<script language=JavaScript for=LC_I_PAYMENT_COND event=OnSelChange()>
    if(LC_I_PAYMENT_COND.BindColVal == "002"){
        LC_I_PAYMENT_DTL_COND.Enable = true;
        
    }else{
        LC_I_PAYMENT_DTL_COND.index = 0;
        LC_I_PAYMENT_DTL_COND.Enable = false;
    }
</script>

<!--  선적항 KillFocus -->
<script language=JavaScript for=EM_I_SHIP_PORT event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "SHIP_PORT", "선적항", "EM_I_SHIP_PORT");  //선적항 
</script>

<!--  LC_NO KillFocus -->
<script language=JavaScript for=EM_I_LC_NO event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "LC_NO", "LC_NO", "EM_I_LC_NO");  //LC_NO 
</script>

<!--   L/C개설은행 KillFocus -->
<script language=JavaScript for=EM_I_LC_OPEN_BANK event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "LC_OPEN_BANK", "L/C개설은행", "EM_I_LC_OPEN_BANK");  //L/C개설은행
</script>

<!--   VENDOR_INFO KillFocus -->
<script language=JavaScript for=EM_I_VENDOR_INFO event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "VENDOR_INFO", "VENDOR_INFO", "EM_I_VENDOR_INFO");  // VENDOR_INFO
</script>

<!--   VALIDITY KillFocus -->
<script language=JavaScript for=EM_I_VALIDITY event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "VALIDITY", "VALIDITY", "EM_I_VALIDITY");  //VALIDITY  
</script>

<!--   SHIPPMENT KillFocus -->
<script language=JavaScript for=EM_I_SHIPMENT event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "SHIPPMENT", "SHIPPMENT", "EM_I_SHIPMENT");  //SHIPPMENT  
</script>

<!--   PACKING KillFocus -->
<script language=JavaScript for=EM_I_PACKING event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "PACKING", "PACKING", "EM_I_PACKING");  //PACKING 
</script>

<!--   INSURANCE KillFocus -->
<script language=JavaScript for=EM_I_INSURANCE event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "INSURANCE", "INSURANCE", "EM_I_INSURANCE");  //INSURANCE 
</script>

<!--   PRICE KillFocus -->
<script language=JavaScript for=EM_O_PRICE event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "PRICE", "PRICE", "EM_O_PRICE");  //PRICE
</script>

<!--   ORIGIN KillFocus -->
<script language=JavaScript for=EM_I_ORIGIN event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "ORIGIN", "ORIGIN", "EM_I_ORIGIN");  //ORIGIN  
</script>

<!--   INSPECTION KillFocus -->
<script language=JavaScript for=EM_I_INSPECTION event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "INSPECTION", "INSPECTION", "EM_I_INSPECTION");  //INSPECTION
</script>

<!--   BL_NO KillFocus -->
<script language=JavaScript for=EM_I_BL_NO event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "BL_NO", "BL_NO", "EM_I_BL_NO");  //BL_NO  
</script>

<!--   PAYMENT KillFocus -->
<script language=JavaScript for=EM_I_PAYMENT event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "PAYMENT", "PAYMENT", "EM_I_PAYMENT");  //PAYMENT  
</script>

<!--   COMMODITY KillFocus -->
<script language=JavaScript for=EM_I_COMMODITY event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "COMMODITY", "COMMODITY", "EM_I_COMMODITY");  //COMMODITY  
</script>

<!--   SHIPPER KillFocus -->
<script language=JavaScript for=EM_I_SHIPPER event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "SHIPPER", "SHIPPER", "EM_I_SHIPPER"); //SHIPPER 
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
<comment id="_NSID_"><object id="DS_I_COMMON"               classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"            classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STR"                    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CURRENCY"             classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PRC_COND"             classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SHIPPMENT"            classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PAYMENT_COND"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PAYMENT_DTL_COND"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_ARRI_PORT"            classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_IMPORT_COUNTRY"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"               classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CHECKTREATMENTOFF_NO"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_LIST"                   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"              classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"              classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SKU_SALEPRC"          classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ORDERNO"              classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_OFFERNO"              classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_ORD_UNIT_CD"            classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
<object id="TR_ORD_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_OFF_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
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
                    <th class="point" width="70">OFFER 기간</th>
                    <td>
                        <comment id="_NSID_">
                              <object id=EM_S_S_OFFER_DT classid=<%=Util.CLSID_EMEDIT%>  width=119 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_S_OFFER_DT)" align="absmiddle"/>
                        ~
                        <comment id="_NSID_">
                              <object id=EM_S_E_OFFER_DT classid=<%=Util.CLSID_EMEDIT%>  width=119 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_E_OFFER_DT)" align="absmiddle"/>
                    </td>
                  </tr>
                  <tr>
                    <th>OFFER NO</th>
                    <td colspan="3">
                        <comment id="_NSID_">
                              <object id=EM_S_OFFER_SEQ_NO classid=<%=Util.CLSID_EMEDIT%>  width=295 tabindex=1 align="absmiddle">
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
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_S_VEN" class="PR03" align="absmiddle" onclick="javascript:getVenInfo(EM_S_VEN_CD,EM_S_VEN_NM);" />
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
                            <OBJECT id=GR_MASTER width=100% height=455 classid=<%=Util.CLSID_GRID%>>
                                <param name="DataID" value="DS_LIST">
                            </OBJECT>
                        </comment><script>_ws_(_NSID_);</script>
                   </td>
                </tr>
             </table>
        </td>
       <td class="PL10">
       <div style="width:100%; height:458px; overflow: auto">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="PT01 PB03">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0"
                            class="s_table">
                            
                <tr>
                  <th class="point" width="73">점</th>
                  <td colspan="5">
                         <comment id="_NSID_">
                            <object id=LC_I_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1 width=90 align="absmiddle">
                            </object>
                        </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th class="point">브랜드</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                            <object id=EM_I_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_I_PUMBUN" class="PR03" align="absmiddle" onclick="javascript:getPumbunInfo();" />
                      <comment id="_NSID_">
                            <object id=EM_O_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=194 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>바이어</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_O_BUYER_CD classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                            <object id=EM_O_BUYER_NM classid=<%=Util.CLSID_EMEDIT%> width=55 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th class="point">협력사</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                            <object id=EM_I_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_I_VEN" class="PR03" align="absmiddle" onclick="javascript:getVenInfo(EM_I_VEN_CD,EM_O_VEN_NM);" />
                      <comment id="_NSID_">
                            <object id=EM_O_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=194 tabindex=1 align="absmiddle">
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
                  <th width="73">수입국가</th>
                  <td width="95">
                      <comment id="_NSID_">
                         <object id=LC_I_IMPORT_COUNTRY classid=<%= Util.CLSID_LUXECOMBO%> tabindex=1 width=90 align="absmiddle">
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th width="73">선적항</th>
                  <td width="105">
                      <comment id="_NSID_">
                            <object id=EM_I_SHIP_PORT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th width="80">ORIGIN</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_ORIGIN classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th class="point">OFFER 일자</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_OFFER_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_I_OFFER_DT onclick="javascript:openCal('G',EM_I_OFFER_DT)" align="absmiddle"/>
                  </td>
                  <th class="point">OFFER NO</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_OFFER_NO classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>가격조건</th>
                  <td>
                      <comment id="_NSID_">
                         <object id=LC_I_PRC_COND classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1 width=100 align="absmiddle">
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Packing</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_PACKING classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=495 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Insurance</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_INSURANCE classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=495 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Shippment</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_SHIPMENT classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=495 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Validity</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_VALIDITY classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=495 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                    
                <tr>
                  <th>화폐단위</th>
                  <td>
                      <comment id="_NSID_">
                         <object id=LC_I_CURRENCY_CD classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1 width=90 align="absmiddle">
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th>환율적용일</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_EXC_APP_DT classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle">
                            </object>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_I_EXC_APP_DT onclick="javascript:openCal('G',EM_I_EXC_APP_DT)" align="absmiddle"/>
                      </comment><script> _ws_(_NSID_);</script>
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
                  <th>B/L 일자</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_BL_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_I_BL_DT onclick="javascript:openCal('G',EM_I_BL_DT)" align="absmiddle"/>
                  </td> 
                  <th>L/C DATE</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_LC_DATE classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_I_LC_DATE onclick="javascript:openCal('G',EM_I_LC_DATE)" align="absmiddle"/>
                  </td>
                  <th>L/C NO</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_LC_NO classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>B/L NO</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_BL_NO classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>                
                  <th>L/C 유효일</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_LC_EFFECTIVE_DT classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_I_LC_EFFECTIVE_DT onclick="javascript:openCal('G',EM_I_LC_EFFECTIVE_DT)" align="absmiddle"/>
                  </td>
                  <th>L/C개설은행</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_LC_OPEN_BANK classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Price</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_O_PRICE classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=392 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                    <comment id="_NSID_">
                        <object id=EM_O_PRICE_2 classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=100 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Commodity</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_COMMODITY classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=495 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Payment</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_PAYMENT classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=495 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Vendor Info</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_VENDOR_INFO classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=495 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>Inspection</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_INSPECTION classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=495 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                 
                <tr>
                  <th>결제조건</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                         <object id=LC_I_PAYMENT_COND classid=<%= Util.CLSID_LUXECOMBO%> tabindex=1 width=191 align="absmiddle">
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                      <comment id="_NSID_">
                         <object id=LC_I_PAYMENT_DTL_COND classid=<%= Util.CLSID_LUXECOMBO%> tabindex=1 width=100 align="absmiddle">
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>                  
                  <th>Packing Charge</th>
                  <td>
                      <comment id="_NSID_">
                         <object id=EM_I_PACKING_CHARGE classid=<%= Util.CLSID_EMEDIT%> tabindex=1 width=100 align="absmiddle">
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>

                <tr>
                  <th>Shipper</th>
                  <td colspan=3>
                      <comment id="_NSID_">
                         <object id=EM_I_SHIPPER classid=<%= Util.CLSID_EMEDIT%> tabindex=1 width=289 align="absmiddle">
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  <th>N.C.V</th>
                  <td>
                      <comment id="_NSID_">
                         <object id=EM_I_NCV classid=<%= Util.CLSID_EMEDIT%> tabindex=1 width=100 align="absmiddle">
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
                <td class="right">
                    <img src="/<%=dir%>/imgs/btn/add_row.gif" id="IMG_ADD"  width="52" height="18" hspace="2" onclick="javascript:addDetailRow();" /><img src="/<%=dir%>/imgs/btn/del_row.gif" id="IMG_DEL" width="52" height="18" onclick="javascript:delDetailRow();" />
                </td>
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
        <c>Col=SHIP_PORT            Ctrl=EM_I_SHIP_PORT         param=Text</c>         
        <c>Col=LC_DATE              Ctrl=EM_I_LC_DATE           param=Text</c> 
        <c>Col=LC_NO                Ctrl=EM_I_LC_NO             param=Text</c>         
        <c>Col=LC_EFFECTIVE_DT      Ctrl=EM_I_LC_EFFECTIVE_DT   param=Text</c> 
        <c>Col=LC_OPEN_BANK         Ctrl=EM_I_LC_OPEN_BANK      param=Text</c>         
        <c>Col=VENDOR_INFO          Ctrl=EM_I_VENDOR_INFO       param=Text</c> 
        <c>Col=OFFER_DT             Ctrl=EM_I_OFFER_DT          param=Text</c>  
        <c>Col=OFFER_SHEET_NO       Ctrl=EM_I_OFFER_NO          param=Text</c>        
        <c>Col=VALIDITY             Ctrl=EM_I_VALIDITY          param=Text</c> 
        <c>Col=SHIPPMENT            Ctrl=EM_I_SHIPMENT          param=Text</c> 
        <c>Col=PACKING              Ctrl=EM_I_PACKING           param=Text</c>          
        <c>Col=ORIGIN               Ctrl=EM_I_ORIGIN            param=Text</c> 
        <c>Col=INSURANCE            Ctrl=EM_I_INSURANCE         param=Text</c> 
        <c>Col=EXC_APP_DT           Ctrl=EM_I_EXC_APP_DT        param=Text</c>    
        <c>Col=EXC_RATE             Ctrl=EM_I_EXC_RATE          param=Text</c>         
        <c>Col=BL_DT                Ctrl=EM_I_BL_DT             param=Text</c>    
        <c>Col=BL_NO                Ctrl=EM_I_BL_NO             param=Text</c>           
        <c>Col=PRICE                Ctrl=EM_O_PRICE             param=Text</c> 
        <c>Col=PRICE2               Ctrl=EM_O_PRICE_2           param=Text</c>    
        <c>Col=COMMODITY            Ctrl=EM_I_COMMODITY         param=Text</c>   
        <c>Col=PAYMENT              Ctrl=EM_I_PAYMENT           param=Text</c>                           
        <c>Col=INSPECTION           Ctrl=EM_I_INSPECTION        param=Text</c> 
        <c>Col=PACKING_CHARGE       Ctrl=EM_I_PACKING_CHARGE    param=Text</c> 
        <c>Col=SHIPPER              Ctrl=EM_I_SHIPPER           param=Text</c> 
        <c>Col=NCV                  Ctrl=EM_I_NCV               param=Text</c>   
                
        <c>Col=STR_CD               Ctrl=LC_I_STR_CD            param=BindColVal</c> 
        <c>Col=ARRI_PORT            Ctrl=LC_I_ARRI_PORT         param=BindColVal</c> 
        <c>Col=IMPORT_COUNTRY       Ctrl=LC_I_IMPORT_COUNTRY    param=BindColVal</c>
        <c>Col=PRC_COND             Ctrl=LC_I_PRC_COND          param=BindColVal</c> 
        <c>Col=CURRENCY_CD          Ctrl=LC_I_CURRENCY_CD       param=BindColVal</c> 
        <c>Col=PAYMENT_COND         Ctrl=LC_I_PAYMENT_COND      param=BindColVal</c> 
        <c>Col=PAYMENT_DTL_COND     Ctrl=LC_I_PAYMENT_DTL_COND  param=BindColVal</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>

<body>
</html>

