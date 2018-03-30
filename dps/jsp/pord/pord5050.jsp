<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 수입경비 > INVOICE 등록
 * 작 성 일 : 2010.03.12
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pcod5050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : INVOICE 등록
 * 이    력 :
 *        2010.03.20 (박래형) 신규작성
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
var strYYYYMM       = "";   // 현재년월
var strGSkuType     = "";   // 단품종류 (1:규격, 3:의류)
var strGStyleType   = "";   // 의류단품종류(1:A, 2:B 타입의류)
var strGBizType     = "";   // 거래형태 (1:직매입,2:특정)
var strTaxFlag     = "";   // 과세구분 (0:과세,1:면세)
var roundFlag       = "";   // 원가단가 반올림 구분 (1:반올림 2:올림 3:내림)

var inta              = 0;
var bfListRowPosition = 0;  // 이전 List Row Position
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
     DS_O_SKU_INFO.setDataHeader('<gauce:dataset name="H_SKU_INFO"/>');
     DS_O_OFFER_INFO.setDataHeader('<gauce:dataset name="H_OFFER_INFO"/>');
     DS_O_INVOICE_INFO.setDataHeader('<gauce:dataset name="H_INVOICE_INFO"/>');
     DS_INVOICE_STAT.setDataHeader('<gauce:dataset name="H_INVOICE_STAT"/>');

     // Output Data Set Header 초기화
     
     //그리드 초기화
     gridCreate1(); //마스터
     gridCreate2(); //디테일    
     
     // 조회부 
     initEmEdit(EM_S_S_INVOICE_DT,       "TODAY",              PK);            // INVOICE 기간 1
     initEmEdit(EM_S_E_INVOICE_DT,       "TODAY",              PK);            // INVOICE 기간 2
     initEmEdit(EM_S_INVOICE_NO,         "GEN^30",             NORMAL);        // INVOICE NO
     initEmEdit(EM_S_OFFER_NO,           "GEN^30",             NORMAL);        // OFFER NO
     initEmEdit(EM_S_PUMBUN_CD,          "000000",             NORMAL);        // 브랜드코드
     initEmEdit(EM_S_PUMBUN_NM,          "GEN^40",             READ);          // 브랜드명
     initEmEdit(EM_S_VEN_CD,             "000000",             NORMAL);        // 협력사코드
     initEmEdit(EM_S_VEN_NM,             "GEN^40",             READ);          // 협력사명
     initEmEdit(EM_S_SLIP_NO,            "0000-0-0000000",     NORMAL);        // 전표번호  
                                                                     
     // 입력부                                                          
     initEmEdit(EM_I_OFFER_NO,           "GEN^30^",           PK);             // OFFER NO   
//     EM_I_OFFER_NO.Format                = "00-000000-00000";                // 마스크 입힘
//     EM_I_OFFER_NO.alignment             = 1;                                // 가운데 정렬
     
     initEmEdit(EM_O_OFFER_DT,           "YYYYMMDD",           READ);          // OFFER DT  
     initEmEdit(EM_I_SLIP_NO,            "0000-0-00000000",    READ);          // 전표번호                                 
     initEmEdit(EM_O_SLIP_FLAG,          "GEN^40",             READ);          // 전표상태          
     initEmEdit(EM_I_PUMBUN_CD,          "000000",             PK);            // 브랜드코드                 
     initEmEdit(EM_O_PUMBUN_NM,          "GEN^40",             READ);          // 브랜드명                 
     initEmEdit(EM_I_BUYER_CD,           "GEN^6",              READ);          // 바이어코드           
     initEmEdit(EM_O_BUYER_NM,           "GEN^40",             READ);          // 바이어명                    
     initEmEdit(EM_I_VEN_CD,             "000000",             PK);            // 협력사코드             
     initEmEdit(EM_O_VEN_NM,             "GEN^40",             READ);          // 협력사명          
     initEmEdit(EM_I_INVOICE_DT,         "YYYYMMDD",           PK);            // INVOICE 일자           
     initEmEdit(EM_I_INVOICE_NO,         "GEN^30",             PK);            // INVOICE NO    
     initEmEdit(EM_I_BL_NO,              "GEN^30",             NORMAL);        // B/L NO     
     initEmEdit(EM_I_SHIP_PORT,          "GEN^100",            NORMAL);        // 선적항           
     initEmEdit(EM_I_ETD,                "YYYYMMDD",           NORMAL);        // 선적일     
     initEmEdit(EM_I_ETA,                "YYYYMMDD",           NORMAL);        // 도착일
     initEmEdit(EM_I_LC_DATE,            "YYYYMMDD",           NORMAL);        // L/C DATE        
     initEmEdit(EM_I_LC_NO,              "GEN^40",             NORMAL);        // L/C NO     
     initEmEdit(EM_I_EXC_APP_DT,         "YYYYMMDD",           PK);            // 환율적용일            
     initEmEdit(EM_I_EXC_RATE,           "NUMBER^13^2",        PK);            // 환율                     
     initEmEdit(EM_I_ENTRY_DT,           "YYYYMMDD",           NORMAL);        // 통관예정일
     initEmEdit(EM_I_IMPORT_NO,          "GEN^30",             NORMAL);        // 수입신고번호
     initEmEdit(EM_I_PACKING_CHARGE,     "NUMBER^13^2",        NORMAL);        // Packing Charge      
     initEmEdit(EM_I_NCV,                "NUMBER^13^2",        NORMAL);        // NCV                 
     initEmEdit(EM_I_INVOICE_AMT,        "NUMBER^13^2",        READ);          // INVOICE 금액          
     initEmEdit(EM_I_PRC_APP_DT,         "YYYYMMDD",           PK);            // 가격적용일
     initEmEdit(EM_I_DELI_DT,            "YYYYMMDD",           PK);            // 납품예정일              
     initEmEdit(EM_I_CHK_DT,             "YYYYMMDD",           READ);          // 검품확정일             
     initEmEdit(EM_I_INVOICE_TOT_QTY,    "NUMBER^7^0",         READ);          // 수량계
     initEmEdit(EM_I_INVOICE_TOT_AMT,    "NUMBER^13^2",        READ);          // 원가계
     initEmEdit(EM_I_SALE_TOT_AMT,       "NUMBER^13^2",        READ);          // 매가계
     initEmEdit(EM_I_REMARK,             "GEN^100",            NORMAL);        // 비고     
                                                               
     //숨겨진 컴퍼넌트                                                
     initEmEdit(EM_BIZ_TYPE,             "GEN^40",             READ);          // 거래형태                  
     initEmEdit(EM_TAX_FLAG,             "GEN^40",             READ);          // 과세구분                    
     initEmEdit(EM_SKU_FLAG,             "GEN^40",             READ);          // 단품종류       
     initEmEdit(EM_BIZ_TYPE_NM,          "GEN",                READ);          // 거래형태
     initEmEdit(EM_TAX_FLAG_NM,          "GEN",                READ);          // 과세구분         
     initEmEdit(EM_SKU_FLAG_NM,          "GEN",                READ);          // 단품종류       
     initEmEdit(EM_TOT_GAP_AMT,          "NUMBER^13^0",        READ);          // 총차익액
     initEmEdit(EM_TOT_GAP_RATE,         "NUMBER^13^0",        READ);          // 총차익율     
     
     EM_BIZ_TYPE.style.display           = "none";
     EM_TAX_FLAG.style.display           = "none";
     EM_SKU_FLAG.style.display           = "none";     
     EM_TOT_GAP_AMT.style.display        = "none";     
     EM_TOT_GAP_RATE.style.display       = "none";
                                                                     
     //콤보 초기화
     initComboStyle(LC_S_STR_CD,            DS_STR,                 "CODE^0^30,NAME^0^80",  1, PK);      // 조회부 점
     initComboStyle(LC_I_STR_CD,            DS_STR,                 "CODE^0^30,NAME^0^80",  1, PK);      // 점    
     initComboStyle(LC_I_IMPORT_COUNTRY,    DS_I_IMPORT_COUNTRY,    "CODE^0^30,NAME^0^80",  1, NORMAL);  // 수입국가               
     initComboStyle(LC_I_ARRI_PORT,         DS_I_ARRI_PORT,         "CODE^0^30,NAME^0^80",  1, NORMAL);  // 도착항   
     initComboStyle(LC_I_PRC_COND,          DS_I_PRC_COND,          "CODE^0^30,NAME^0^180", 1, NORMAL);  // 가격조건            
     initComboStyle(LC_I_PAYMENT_COND,      DS_I_PAYMENT_COND,      "CODE^0^30,NAME^0^180", 1, NORMAL);  // 결제조건            
     initComboStyle(LC_I_PAYMENT_DTL_COND,  DS_I_PAYMENT_DTL_COND,  "CODE^0^30,NAME^0^80",  1, NORMAL);  // 결제조건 상세
     initComboStyle(LC_I_CURRENCY_CD,       DS_I_CURRENCY,          "CODE^0^30,NAME^0^80",  1, PK);      // 화폐단위 
     
     //공통코드에서 데이터 가지고 오기     
     getStore("DS_STR", "Y", "", "N");          
     getEtcCode("DS_I_CURRENCY",        "D", "P217", "N");      // 화폐단위 
     getEtcCode("DS_I_PRC_COND",        "D", "P218", "N");      // 가격조건 
     getEtcCode("DS_I_PAYMENT_COND",    "D", "P219", "N");      // 결제조건 
     getEtcCode("DS_I_PAYMENT_DTL_COND","D", "P220", "N");      // 결제조건상세 
     getEtcCode("DS_I_ARRI_PORT",       "D", "P222", "N");      // 도착항 
     getEtcCode("DS_I_IMPORT_COUNTRY",  "D", "P223", "N");      // 수입국가 
     getEtcCode("DS_O_S_PROC_STAT",     "D", "P207", "N");      // 전표상태
     getEtcCode("DS_O_BIZ_TYPE",        "D", "P002", "N");      // 거래형태 
     getEtcCode("DS_O_TAX_FLAG",        "D", "P004", "N");      // 과세구분
     getEtcCode("DS_O_SKU_FLAG",        "D", "P015", "N");      // 단품구분     
     getEtcCode("DS_ORD_UNIT_CD",       "D", "P013", "N");      // 단위  

     insComboData( LC_I_IMPORT_COUNTRY, "", "",1);
     insComboData( LC_I_ARRI_PORT, "", "",1);
     insComboData( LC_I_PRC_COND, "", "",1);
     insComboData( LC_I_PAYMENT_COND, "", "",1);
     insComboData( LC_I_PAYMENT_DTL_COND, "", "",1);
//     insComboData( LC_I_CURRENCY_CD, "", "",1);
     
     //데이터셋 등록
     registerUsingDataset("pord505","DS_LIST,DS_IO_MASTER,DS_IO_DETAIL,DS_O_SKU_INFO,DS_O_INVOICE_INFO");
     
     //화면 로드시 입력 컴퍼넌트 비활성화
     checkValidation(false);   
     GR_DETAIL.Editable = false;
     LC_I_PAYMENT_DTL_COND.Enable = false;
     LC_S_STR_CD.Index = 0;
     LC_S_STR_CD.Focus();
     EM_S_S_INVOICE_DT.Text    = (strYYYYMM + '01');
     LC_I_STR_CD.Enable        = false; //OFFER NO를 조회할때만 사용하기 위해 신규시 풀고 OFFER NO 입력되면 활성화
     EM_I_OFFER_NO.Enable      = false; 
     enableControl(IMG_OFFER_NO, false);
 }

function gridCreate1(){
    var hdrProperies = '<FC>id=STR_NM              name="점"            width=55    align=left</FC>'
                     + '<FC>id=INVOICE_DT          name="INVOICE 일자"  width=80    align=center Mask="XXXX-XX-XX"</FC>'
                     + '<FC>id=INVOICE_NO          name="INVOICE_NO"    width=120   align=center </FC>'
                     + '<FC>id=OFFER_SHEET_NO      name="OFFER NO"      width=120   align=center </FC>'
                     + '<FC>id=PUMBUN_NM           name="브랜드"          width=100    align=left</FC>'
                     + '<FC>id=VEN_NM              name="협력사"        width=120    align=left</FC>'
                     + '<FC>id=SLIP_PROC_STAT_NM   name="전표상태"      width=120    align=left SHOW=FALSE</FC>';                     

    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}              name="NO"         width=30    align=center Edit=none sumtext=""    </FC>'
    	             + '<FC>id=CHECK1                name="선택"       width=50    align=center HeadCheckShow=true EditStyle=CheckBox</FC>'
                     + '<FC>id=PUMMOK_CD             name="품목코드"   width=10    align=left   SHOW=FALSE/FC>'
                     + '<FC>id=SKU_CD                name="* 단품코드" width=110   align=left   EditStyle=Popup sumtext="합계" </FC>'
                     + '<FC>id=SKU_NM                name="단품명"     width=135   align=left   Edit=none </FC>'
                     + '<FC>id=STYLE_CD              name="스타일코드" width=210   align=left   Edit=none </FC>'
                     + '<FC>id=COLOR_CD              name="칼라"       width=60    align=left   Edit=none </FC>'
                     + '<FC>id=SIZE_CD               name="사이즈"     width=60    align=left   Edit=none </FC>'
                     + '<FC>id=MODEL_NO              name="모델코드"   width=80    align=left   Edit=none </FC>'
                     + '<FC>id=ORD_UNIT_CD           name="단위코드"   width=40    align=center Edit=none SHOW=FALSE</FC>'
                     + '<FC>id=ORD_UNIT_NM           name="단위"       width=40    align=left   Edit=none </FC>'
                     + '<FC>id=INVOICE_QTY           name="* 수량"     width=40    align=rigth  Edit=Numeric sumtext=@sum </FC>'
                     + '<FG> name="원가"'
                     + '<FC>id=INVOICE_UNIT_AMT      name="* 외화단가" width=80    align=right  sumtext=@sum </FC>'
                     + '<FC>id=INVOICE_KOR_UNIT_AMT  name="원화단가"   width=80    align=right  Edit=none   sumtext=@sum </FC>'
                     + '<FC>id=INVOICE_AMT           name="외화금액"   width=80    align=right  Edit=none   sumtext=@sum </FC>'
                     + '<FC>id=INVOICE_KOR_AMT       name="원화금액"   width=80    align=right  Edit=none   sumtext=@sum </FC>'
                     + '</FG>'
                     + '<FG> name="매가"'
                     + '<FC>id=SALE_PRC              name="*단가"      width=80    align=right Edit=Numeric sumtext=@sum </FC>'
                     + '<FC>id=SALE_AMT              name="금액"       width=100   align=right Edit=none    sumtext=@sum </FC></FG>'
                     + '<FC>id=GAP_RATE              name="차익율"     width=60    align=right Edit=none    </FC>'
                     + '<FC>id=GAP_AMT               name="차익액"     width=60    align=right Edit=none    sumtext=@sum </FC>';                     

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
        bfListRowPosition = 0;                               // 이전 List Row Position
        getList();
        // 조회결과 Return
        setPorcCount("SELECT", GR_MASTER);
        if(DS_IO_MASTER.CountRow == 0){
        	LC_S_STR_CD.Focus();
            checkValidation(false);
            GR_DETAIL.Editable = false;
            return;
        }
        /*
        checkValidation(false);  
        EM_I_PUMBUN_CD.Enable = false;        //브랜드코드 비활성화
        enableControl(IMG_I_PUMBUN, false);   //브랜드이미지 비활성화
        */
        LC_I_STR_CD.Enable        = false;
        EM_I_OFFER_NO.Enable      = false;
        enableControl(IMG_OFFER_NO, false);     
        EM_I_INVOICE_DT.Enable    = false;
        EM_I_INVOICE_NO.Enable    = false;
        EM_I_EXC_RATE.Enable      = false;
        EM_I_EXC_APP_DT.Enable    = false;
        EM_I_DELI_DT.Enable       = false;
        EM_I_PRC_APP_DT.Enable    = false;
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
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "INVOICE_NO") == ""){
        if(showMessage(QUESTION, YESNO, "USER-1072") != 1 ){
              return;
          }else{
              DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
          }
    }else{
        DS_LIST.Addrow(); 
    }    
    // 마스터 Row추가
    DS_IO_MASTER.Addrow();  

    checkValidation(true);                      // 입력부 활성화
    GR_DETAIL.Editable = true;
    
    // OFFER NO에 의해 변한다
    LC_I_STR_CD.Enable = true; 
    EM_I_OFFER_NO.Enable = true;
    enableControl(IMG_OFFER_NO, true);
    
    // 신규일때 초기 값 셋팅해준다.
    if(DS_LIST.RowStatus(DS_LIST.RowPosition)==1){
        LC_I_STR_CD.Index = 0;                  // 점코드
        EM_I_INVOICE_DT.Text = strToday;
        EM_I_PRC_APP_DT.Text = addDate("d", 1, strToday);;
        EM_I_DELI_DT.Text    = addDate("d", 1, strToday);;
        EM_I_EXC_APP_DT.Text = strToday;
    }
        
    DS_IO_DETAIL.ClearData();                   // 디테일 클리어
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
        if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "INVOICE_NO").length == 0){
            DS_LIST.DeleteRow(DS_LIST.RowPosition);
            DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
            DS_IO_DETAIL.ClearData();
            return;
        }

        if(!checkValue("Delete"))
            return;
        
        if(showMessage(Question, YESNO, "USER-1023") == 1){
            var strStrCd         = DS_LIST.NameValue(DS_LIST.RowPosition, "STR_CD");
            var strInvoiceYm     = DS_LIST.NameValue(DS_LIST.RowPosition, "INVOICE_YM")
            var strInvoiceSeqNo  = DS_LIST.NameValue(DS_LIST.RowPosition, "INVOICE_SEQ_NO");
            var strSlipNo        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_NO");

//            alert("strSlipNo = " + strSlipNo);
            
            DS_LIST.DeleteRow(DS_LIST.RowPosition);   
            DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition); 
            
            var goTo       = "save";    
            var action     = "I";     
            var parameters = "&strFlag=delete" 
                           + "&strStrCd="+encodeURIComponent(strStrCd)
                           + "&strInvoiceYm="+encodeURIComponent(strInvoiceYm)
                           + "&strInvoiceSeqNo="+encodeURIComponent(strInvoiceSeqNo)
                           + "&strSlipNo="+encodeURIComponent(strSlipNo);
            TR_MAIN.Action="/dps/pord505.po?goTo="+goTo+parameters; 
            TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)";
            TR_MAIN.Post(); 
            
            DS_IO_DETAIL.ClearData();    
            btn_Search();
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
        
        // 디테일 데이터 없을경우 저장할 수 없다.
        if(DS_IO_DETAIL.CountRow <= 0){
            showMessage(EXCLAMATION, OK, "GAUCE-1000", "상세데이터 등록후 저장하십시오."); 
            GR_DETAIL.Focus();
            return;
        }        

        if(!checkValue("Save"))
        	return;
        
        if(!closeCheck())
            return;
        	
        if( showMessage(QUESTION, YESNO, "USER-1010") == 1 ){ 
	            var strInvoiceDt = strToday;
	            var strInvoiceYm = strYYYYMM;
	            var parameters = "&strInvoiceDt="+encodeURIComponent(strInvoiceDt)
	                           + "&strInvoiceYm="+encodeURIComponent(strInvoiceYm); 
	            
	            TR_MAIN.Action="/dps/pord505.po?goTo=save&strFlag=save"+parameters;;  
	            TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)"; 
	            TR_MAIN.Post();  
	            btn_Search();  
        }  
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
	 
//	 EM_I_OFFER_NO.Enable = flag;
     EM_I_PUMBUN_CD.Enable = false;
     EM_I_VEN_CD.Enable = false;
     EM_I_INVOICE_DT.Enable = flag;  
     EM_I_INVOICE_NO.Enable = flag;
     EM_I_BL_NO.Enable = flag;
     EM_I_SHIP_PORT.Enable = flag;
     EM_I_ETD.Enable = flag;
     EM_I_ETA.Enable = flag;
     EM_I_LC_DATE.Enable = flag;
     EM_I_LC_NO.Enable = flag;
     EM_I_EXC_APP_DT.Enable = flag;
     EM_I_EXC_RATE.Enable = flag;
     EM_I_ENTRY_DT.Enable = flag;
     EM_I_IMPORT_NO.Enable = flag;
     EM_I_PRC_APP_DT.Enable = flag;  
     EM_I_DELI_DT.Enable = flag;     
     EM_I_REMARK.Enable = flag;
     EM_I_PACKING_CHARGE.Enable = flag;
     EM_I_NCV.Enable = flag;
     
     LC_I_IMPORT_COUNTRY.Enable = flag;
     LC_I_ARRI_PORT.Enable = flag;
     LC_I_PRC_COND.Enable = flag;
     LC_I_PAYMENT_COND.Enable = flag;
//     LC_I_PAYMENT_DTL_COND.Enable = flag;
     LC_I_CURRENCY_CD.Enable = flag;     
/*    
     enableControl(IMG_PUMBUN_CD, flag);
     enableControl(IMG_VEN_CD, flag);
     enableControl(IMG_OFFER_NO, flag);
*/
     enableControl(IMG_INVOICE_DT, flag);
     enableControl(IMG_ETD, flag);
     enableControl(IMG_ETA, flag);
     enableControl(IMG_LC_DATE, flag);
     enableControl(IMG_EXC_APP_DT, flag);
     enableControl(IMG_ENTRY_DT, flag);
     enableControl(IMG_INVOICE_DT, flag);
     enableControl(IMG_PRC_APP_DT, flag);
     enableControl(IMG_DELI_DT, flag);     
//     GR_DETAIL.Editable = flag;
 }

 function setComponent(flag){
     
     EM_I_BL_NO.Enable = flag;
     EM_I_SHIP_PORT.Enable = flag;
     EM_I_ETD.Enable = flag;
     EM_I_ETA.Enable = flag;
     EM_I_LC_DATE.Enable = flag;
     EM_I_LC_NO.Enable = flag;
     EM_I_ENTRY_DT.Enable = flag;
     EM_I_IMPORT_NO.Enable = flag;  
     EM_I_REMARK.Enable = flag;
     EM_I_PACKING_CHARGE.Enable = flag;
     EM_I_NCV.Enable = flag;

     EM_I_INVOICE_DT.Enable = flag;
     EM_I_DELI_DT.Enable = flag;
     EM_I_PRC_APP_DT.Enable = flag;

     LC_I_IMPORT_COUNTRY.Enable = flag;
     LC_I_ARRI_PORT.Enable = flag;
     LC_I_PRC_COND.Enable = flag;
     LC_I_PAYMENT_COND.Enable = flag;
//     LC_I_PAYMENT_DTL_COND.Enable = flag;
     LC_I_CURRENCY_CD.Enable = flag;     

//     enableControl(IMG_OFFER_NO, flag);
     enableControl(IMG_ETD, flag);
     enableControl(IMG_ETA, flag);
     enableControl(IMG_LC_DATE, flag);
     enableControl(IMG_ENTRY_DT, flag);     

     enableControl(IMG_INVOICE_DT, flag);
     enableControl(IMG_DELI_DT, flag);
     enableControl(IMG_PRC_APP_DT, flag);
 }
 
 /**
 * closeCheck()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-10
 * 개    요    : 저장시 일마감체크를 한다.
 * return값 : void
 */
 function closeCheck(){
     var strStrCd         = LC_I_STR_CD.BindColVal; // 점
     var strCloseDt       = strToday;               // 마감체크일자
     var strCloseTaskFlag = "PORD";                 // 업무구분(매입월마감)
     var strCloseUnitFlag = "42";                   // 단위업무
     var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
     var strCloseFlag     = "M";                    // 마감구분(월마감:M)
    
     var closeFlag = getCloseCheck( "DS_O_RESULT", strStrCd , strCloseDt , strCloseTaskFlag 
                                   , strCloseUnitFlag , strCloseAcntFlag , strCloseFlag);
     
     if(closeFlag == "TRUE"){
         showMessage(EXCLAMATION, OK, "USER-1068", "매입일","INVOIC");
         return false;
     }else{
         return true;
     }
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
    var strStrCd         = LC_S_STR_CD.BindColVal;    // 점
    var strSInvoiceDt    = EM_S_S_INVOICE_DT.Text;    // 조회기간1
    var strEInvoiceDt    = EM_S_E_INVOICE_DT.Text;    // 조회기간2
    var strInvoiceNo     = EM_S_INVOICE_NO.Text;      // INVOICE NO
    var strOfferNo       = EM_S_OFFER_NO.Text;        // OFFER NO
    var strPumbun        = EM_S_PUMBUN_CD.Text;       // 브랜드
    var strVen           = EM_S_VEN_CD.Text;          // 협력사
    var strSlipNo        = EM_S_SLIP_NO.Text;         // 전표번호
   
    var goTo       = "getList" ;    
    var action     = "O";     
    var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strSInvoiceDt="+encodeURIComponent(strSInvoiceDt)     
                    + "&strEInvoiceDt="+encodeURIComponent(strEInvoiceDt)      
                    + "&strInvoiceNo="+encodeURIComponent(strInvoiceNo)      
                    + "&strOfferNo="+encodeURIComponent(strOfferNo)       
                    + "&strPumbun="+encodeURIComponent(strPumbun)        
                    + "&strVen="+encodeURIComponent(strVen)       
                    + "&strSlipNo="+encodeURIComponent(strSlipNo);  
    TR_MAIN.Action="/dps/pord505.po?goTo="+goTo+parameters;  
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
    var strStrCd           = DS_LIST.NameValue(DS_LIST.RowPosition, "STR_CD");          // 점
    var strInvoiceYm       = DS_LIST.NameValue(DS_LIST.RowPosition, "INVOICE_YM");      // INVOICE_YM
    var strInvoiceSeqNo    = DS_LIST.NameValue(DS_LIST.RowPosition, "INVOICE_SEQ_NO");  // INVOICE_SEQ_NO
    
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)   
                    + "&strInvoiceYm="+encodeURIComponent(strInvoiceYm)
                    + "&strInvoiceSeqNo="+encodeURIComponent(strInvoiceSeqNo);  
    TR_S_MAIN.Action="/dps/pord505.po?goTo="+goTo+parameters;  
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
     var strStrCd           = DS_LIST.NameValue(DS_LIST.RowPosition, "STR_CD");          // 점
     var strInvoiceYm       = DS_LIST.NameValue(DS_LIST.RowPosition, "INVOICE_YM");      // INVOICE_YM
     var strInvoiceSeqNo    = DS_LIST.NameValue(DS_LIST.RowPosition, "INVOICE_SEQ_NO");  // INVOICE_SEQ_NO
     var strVenCd           = DS_LIST.NameValue(DS_LIST.RowPosition, "VEN_CD");          // 협력사
     
     var goTo       = "getDetail" ;    
     var action     = "O";     
     var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)   
                     + "&strInvoiceYm="+encodeURIComponent(strInvoiceYm)
                     + "&strInvoiceSeqNo="+encodeURIComponent(strInvoiceSeqNo);  
     TR_S_MAIN.Action="/dps/pord505.po?goTo="+goTo+parameters;  
     TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
     TR_S_MAIN.Post();
     
     setTimeout("setRoundFlag()",50);         
     GR_DETAIL.ColumnProp('CHECK1','HeadCheck')= "FALSE";
  }
  
  /**
   * setRoundFlag()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-24
   * 개    요 :  협력사별 반올림 구분을 가져오기 위함
   * return값 : void
   */
 function setRoundFlag(){    
     var strStrCd           = DS_LIST.NameValue(DS_LIST.RowPosition, "STR_CD");        // 점
     var strVenCd           = DS_LIST.NameValue(DS_LIST.RowPosition, "VEN_CD");        // 협력사
     
     roundFlag = getVenRoundFlag('DS_O_RESULT', strToday, strStrCd, strVenCd);   
 }
  
 /**
  * addDetailRow()
  * 작 성 자     :박래형
  * 작 성 일     : 2010-03-05
  * 개    요        : 디테일 등록위한  ROW 추가
  * return값 : void
  */
 function addDetailRow(){
//    alert(strGSkuType);

    if(DS_IO_MASTER.CountRow == 0){
           showMessage(EXCLAMATION, OK, "USER-1000", "전표 마스터 내용을 먼저 추가해 주세요.");
           return;
    }
    
    if(checkValue("Add")){
    	
        // 디테일 Row 추가
        DS_IO_DETAIL.Addrow(); 
        setFocusGrid(GR_DETAIL, DS_IO_DETAIL, DS_IO_DETAIL.RowPosition, "SKU_CD");
        checkValidation(false);
        if(strGSkuType == '1'){      // 규격단품
            GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = false;
            GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
            GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;
            
        }else if(strGSkuType == '2'){// 신선단품
            GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = false;
            GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
            GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;     
            
        }else if(strGSkuType == '3'){// 의류단품
            GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = true;
            GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = true;
            GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = true;     
        }
        
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STR_CD")          = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");          // 점
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INVOICE_YM")      = strYYYYMM;                                                           // INVOICE_YM
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INVOICE_SEQ_NO")  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "INVOICE_SEQ_NO");  // INVOICE_SEQ_NO        
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "EXC_RATE")        = EM_I_EXC_RATE.Text;                                                  // INVOICE_SEQ_NO        
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

    sel_DeleteRow( DS_IO_DETAIL, "CHECK1" );
    
	if(DS_IO_DETAIL.CountRow == 0){
		checkValidation(true);		   
	    GR_DETAIL.Editable = true;
        LC_I_STR_CD.Enable   = true;
        EM_I_OFFER_NO.Enable = true;
        enableControl(IMG_OFFER_NO, true);
        GR_DETAIL.ColumnProp('CHECK1','HeadCheck')= "FALSE";
	}		
} 

/**
* getPumbunInfo(pop)
* 작 성 자 : 박래형
* 작 성 일 : 2010-02-19
* 개    요 :  브랜드팝업 관련 데이터 조회 및 세팅
* param : pop (팝업을 띄울지..1:팝업, 0:무시)
* return값 : void
*/
function getPumbunInfo(pop){
    var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
    var strStrCd        = LC_I_STR_CD.BindColVal;                                    // 점
    var strOrgCd        = "";                                                        // 조직코드
    var strVenCd        = "";                                                        // 협력사
    var strBuyerCd      = "";                                                        // 바이어
    var strPumbunType   = "";                                                        // 브랜드유형
    var strUseYn        = "Y";                                                       // 사용여부
    var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
    var strSkuType      = "";                                                        // 단품종류(1:규격단품)
    var strItgOrdFlag   = "";                                                        // 통합발주여부
    var strBizType      = "1";                                                       // 거래형태(1:직매입,2:특정)
    var strSaleBuyFlag  = "1";                                                       // 판매분매입구분(1:사전매입)

    if(EM_I_PUMBUN_CD.Text != ""){
        var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_I_PUMBUN_CD, EM_O_PUMBUN_NM, "Y", pop
                                          , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                          , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                          , strBizType,strSaleBuyFlag);

        if(DS_O_RESULT.CountRow == 1){

            strGSkuType    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "SKU_TYPE");
            strGStyleType  = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "STYLE_TYPE");
            strGBizType    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "BIZ_TYPE");
            
            var idx = "";
            // 거래형태
            if(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "BIZ_TYPE") != undefined){
                idx                 = DS_O_BIZ_TYPE.ValueRow(1,DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "BIZ_TYPE"));
                EM_BIZ_TYPE.Text    = DS_O_BIZ_TYPE.ValueRow(1,DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "BIZ_TYPE"));
                EM_BIZ_TYPE_NM.Text = DS_O_BIZ_TYPE.NameValue(idx, "NAME");
            }else{
                EM_BIZ_TYPE.Text    = "";
                EM_BIZ_TYPE_NM.Text = "";
            }              
            
            // 과세구분
            if(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "TAX_FLAG") != undefined){
                idx = DS_O_TAX_FLAG.ValueRow(1,DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "TAX_FLAG"));
                EM_TAX_FLAG.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "TAX_FLAG");
                EM_TAX_FLAG_NM.Text = DS_O_TAX_FLAG.NameValue(idx, "NAME");
                strTaxFlag         = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "TAX_FLAG");
            }else{
                EM_TAX_FLAG.Text    = "";
                EM_TAX_FLAG_NM.Text = "";                
                strTaxFlag         = "";
            }         
            
            // 단품종류             
            if(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "SKU_TYPE") != undefined){
                idx                 = DS_O_SKU_FLAG.ValueRow(1,DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "SKU_TYPE"));
                EM_SKU_FLAG.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "SKU_TYPE");
                EM_SKU_FLAG_NM.Text = DS_O_SKU_FLAG.NameValue(idx, "NAME");
            }else{
                EM_SKU_FLAG.Text    = "";
                EM_SKU_FLAG_NM.Text = "";
            }
            
            EM_O_PUMBUN_NM.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "PUMBUN_NAME");              
            // 바이어            
            EM_O_BUYER_NM.Text  = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "CHAR_BUYER_NAME");   
            // 협력사코드
            EM_O_VEN_NM.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_NAME");
            EM_I_BUYER_CD.Text  = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "CHAR_BUYER_CD");
            EM_I_VEN_CD.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_CD");            
        }
        
    }else{
        var rtnMap = strPbnPop(EM_I_PUMBUN_CD, EM_O_PUMBUN_NM, 'Y'
                                ,strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                ,strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                ,strBizType,strSaleBuyFlag);
    }
    if(rtnMap != null){
        
        strGSkuType        = rtnMap.get("SKU_TYPE");
        strGStyleType      = rtnMap.get("STYLE_TYPE");
        strGBizType        = rtnMap.get("BIZ_TYPE");
        
        EM_I_VEN_CD.Text   = rtnMap.get("VEN_CD");
        EM_O_VEN_NM.Text   = rtnMap.get("VEN_NAME");
        
        var idx = "";
        // 거래형태
        if(rtnMap.get("BIZ_TYPE") != ""){
            idx = DS_O_BIZ_TYPE.ValueRow(1,rtnMap.get("BIZ_TYPE"));
            EM_BIZ_TYPE.Text    = DS_O_BIZ_TYPE.ValueRow(1,rtnMap.get("BIZ_TYPE"));
            EM_BIZ_TYPE_NM.Text = DS_O_BIZ_TYPE.NameValue(idx, "NAME");
        }else{
            EM_BIZ_TYPE.Text    = "";
            EM_BIZ_TYPE_NM.Text = "";
        }
        
        // 과세구분
        if(rtnMap.get("TAX_FLAG") != ""){
            idx = DS_O_TAX_FLAG.ValueRow(1,rtnMap.get("TAX_FLAG"));
            EM_TAX_FLAG.Text    = DS_O_TAX_FLAG.ValueRow(1,rtnMap.get("TAX_FLAG"));
            EM_TAX_FLAG_NM.Text = DS_O_TAX_FLAG.NameValue(idx, "NAME");
            
            strTaxFlag = DS_TAX_FLAG.ValueRow(1,rtnMap.get("TAX_FLAG"));
        }else{
            EM_TAX_FLAG.Text    = "";
            EM_TAX_FLAG_NM.Text = "";
            
            strTaxFlag = "";
        }
        
        // 단품종류
        if(rtnMap.get("SKU_TYPE") != ""){
            idx = DS_O_SKU_FLAG.ValueRow(1,rtnMap.get("SKU_TYPE"));
            EM_SKU_FLAG.Text    = DS_O_SKU_FLAG.ValueRow(1,rtnMap.get("SKU_TYPE"));
            EM_SKU_FLAG_NM.Text = DS_O_SKU_FLAG.NameValue(idx, "NAME");
        }else{
            EM_SKU_FLAG.Text    = "";
            EM_SKU_FLAG_NM.Text = "";
        }
        
        // 바이어
        EM_I_BUYER_CD.Text = rtnMap.get("CHAR_BUYER_CD");
        EM_O_BUYER_NM.Text = rtnMap.get("CHAR_BUYER_NAME");
    }
    
    // 저장시 다시 한번 브랜드의 존재여부를 확인하기 위해
    if(DS_O_RESULT.CountRow > 0) return true;
    if(rtnMap != null) return true;
}

/**
* getPumbunInfo()
* 작 성 자 : 박래형
* 작 성 일 : 2010-03-07
* 개    요 :  브랜드팝업 관련 데이터 조회 및 세팅
* return값 : void
*/
function getInputPumbunInfo(){
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
   
    var rtnMap = strPbnPop(EM_I_PUMBUN_CD, EM_O_PUMBUN_NM, 'Y'
                            ,strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                            ,strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                            ,strBizType,strSaleBuyFlag);
    if(rtnMap != null){
        
        
        strGSkuType        = rtnMap.get("SKU_TYPE");
        strGStyleType      = rtnMap.get("STYLE_TYPE");
        strGBizType        = rtnMap.get("BIZ_TYPE");
        
        EM_I_VEN_CD.Text   = rtnMap.get("VEN_CD");
        EM_O_VEN_NM.Text   = rtnMap.get("VEN_NAME");
        
        var idx = "";
        // 거래형태
        if(rtnMap.get("BIZ_TYPE") != ""){
            idx = DS_O_BIZ_TYPE.ValueRow(1,rtnMap.get("BIZ_TYPE"));
            EM_BIZ_TYPE.Text    = DS_O_BIZ_TYPE.ValueRow(1,rtnMap.get("BIZ_TYPE"));
            EM_BIZ_TYPE_NM.Text = DS_O_BIZ_TYPE.NameValue(idx, "NAME");
        }else{
            EM_BIZ_TYPE.Text = "";
            EM_BIZ_TYPE_NM.Text = "";
        }
        
        // 과세구분
        if(rtnMap.get("TAX_FLAG") != ""){
            idx = DS_O_TAX_FLAG.ValueRow(1,rtnMap.get("TAX_FLAG"));
            EM_TAX_FLAG.Text    = DS_O_TAX_FLAG.ValueRow(1,rtnMap.get("TAX_FLAG"));
            EM_TAX_FLAG_NM.Text = DS_O_TAX_FLAG.NameValue(idx, "NAME");
            
            strTaxFlag = DS_TAX_FLAG.ValueRow(1,rtnMap.get("TAX_FLAG"));
        }else{
            EM_TAX_FLAG.Text    = "";
            EM_TAX_FLAG_NM.Text = "";
            
            strTaxFlag = "";
        }
        
        // 단품종류
        if(rtnMap.get("SKU_TYPE") != ""){
            idx = DS_O_SKU_FLAG.ValueRow(1,rtnMap.get("SKU_TYPE"));
            EM_SKU_FLAG.Text    = DS_O_SKU_FLAG.ValueRow(1,rtnMap.get("SKU_TYPE"));
            EM_SKU_FLAG_NM.Text = DS_O_SKU_FLAG.NameValue(idx, "NAME");
        }else{
            EM_SKU_FLAG.Text    = "";
            EM_SKU_FLAG_NM.Text = "";
        }
        
        // 바이어
        EM_I_BUYER_CD.Text = rtnMap.get("CHAR_BUYER_CD");
        EM_O_BUYER_NM.Text = rtnMap.get("CHAR_BUYER_NAME");
        
    }
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

       strGSkuType        = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "SKU_TYPE");
       strGStyleType      = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "STYLE_TYPE");
       strGBizType        = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "BIZ_TYPE");
       // 바이어
       EM_O_BUYER_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "CHAR_BUYER_CD");
       EM_O_BUYER_NM.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "BUYER_EMP_NAME");
       
       EM_I_VEN_CD.Text   = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_CD");
       EM_O_VEN_NM.Text   = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_NAME");
   }
 }

/**
* getOVenInfo()
* 작 성 자 : 박래형
* 작 성 일 : 2010-03-08
* 개    요 :  브랜드에 따른 협력사 팝업
* return값 : void
*/
function getOVenInfo(){
    var strStrCd        = LC_I_STR_CD.BindColVal;                                    // 점
    var strUseYn        = "Y";                                                       // 사용여부
    var strPumBunType   = "0";                                                       // 브랜드유형
    var strBizType      = "1";                                                       // 거래형태
    var strMcMiGbn      = "1";                                                       // 매출처/매입처구분
    var strBizFlag      = "";                                                        // 거래구분
    
    if(EM_I_VEN_CD.Text != ""){
        var rtnMap = setVenNmWithoutPop( "DS_O_RESULT", EM_I_VEN_CD, EM_O_VEN_NM, "1"
                                            ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                                            ,strBizFlag);
    }else{
        var rtnMap = repVenPop(EM_I_VEN_CD, EM_O_VEN_NM
                            ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                            ,strBizFlag);
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
    var intRow          = 1;
    var strSkuCd        = DS_IO_DETAIL.NameValue(row, "SKU_CD");
    var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
    var strStrCd        = LC_I_STR_CD.BindColVal;                                    // 점
    var strPumbunCd     = EM_I_PUMBUN_CD.Text;                                       // 브랜드코드
    var strPumbunType   = "";                                                        // 브랜드유형
    var strBizType      = "";                                                        // 거래형태(1:직매입)
    var strUseYn        = "Y";              

	var rtnList = strSkuMultiSelPop(strSkuCd, "", "Y"
	                                , strUsrCd, strStrCd, strPumbunCd, strPumbunType, strBizType
	                                , strUseYn);

    if(rtnList != null){
        for(var i = 0; i < rtnList.length; i++){
            if(i == 0 )
                intRow = row;
            else
                DS_IO_DETAIL.AddRow();
            
            DS_IO_DETAIL.NameValue(row+i, "SKU_CD")          = rtnList[i].SKU_CD;
            DS_IO_DETAIL.NameValue(row+i, "SKU_NM")          = rtnList[i].SKU_NAME;

            DS_IO_DETAIL.NameValue(row+i, "STR_CD")          = LC_I_STR_CD.BindColVal;                                    // 점코드
            DS_IO_DETAIL.NameValue(row+i, "INVOICE_YM")      = setInvoiceYm(EM_I_INVOICE_DT.Text);                        // INVOICE_YM
            DS_IO_DETAIL.NameValue(row+i, "INVOICE_SEQ_NO")  = DS_LIST.NameValue(DS_LIST.RowPosition, "INVOICE_SEQ_NO");  // INVOICE_SEQ_NO

            //  getSkuInfo('D', rtnList[i].SKU_CD);
            //aaa getOffSkuInfo();
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
     }else{ 
        rtnList = skuBTypeMultiSelPordPop(strSkuCd, "", "Y"
                                         , strUsrCd, strStrCd, strPumbunCd, "", ""
                                         , "", "", "", strPumbunType, strBizType
                                         , strUseYn, "", "");
     }
        // 멀티셀렉트 팝업 선택시
        if(rtnList != null){
            for(var i = 0; i < rtnList.length; i++){
                if(i == 0 )
                    intRow = row;
                else
                    DS_IO_DETAIL.AddRow();
                
                DS_IO_DETAIL.NameValue(row+i, "SKU_CD")      = rtnList[i].SKU_CD;
                DS_IO_DETAIL.NameValue(row+i, "SKU_NM")      = rtnList[i].SKU_NAME;

                DS_IO_DETAIL.NameValue(row+i, "STR_CD")          = LC_I_STR_CD.BindColVal;               // 점코드
                DS_IO_DETAIL.NameValue(row+i, "INVOICE_YM")      = setInvoiceYm(EM_I_INVOICE_DT.Text);      // INVOICE_YM
                DS_IO_DETAIL.NameValue(row+i, "INVOICE_SEQ_NO")  = DS_LIST.NameValue(DS_LIST.RowPosition, "INVOICE_SEQ_NO");  // INVOICE_SEQ_NO

                //getSkuInfo('D', rtnList[i].SKU_CD);
                //aaa getOffSkuInfo();
            }
            if(rtnList.length > 1)
                setFocusGrid(GR_DETAIL, DS_IO_DETAIL,intRow,"OFFER_QTY");
        }
}

/**
* setInvoiceYm(OfferDt)
* 작 성 자 : 박래형
* 작 성 일 : 2010-03-29
* 개    요 : OfferYm을 정한다(Offer일자의 년월을 구한다)
* return값 : void
*/
function setInvoiceYm(OfferDt){
    var strInvoiceYm = null;
    strInvoiceYm = OfferDt.substring(0,6);
    return strInvoiceYm;
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
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "OFFER_TOT_AMT") = DS_IO_DETAIL.NameSum("OFFER_AMT",0,0);    
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
         if(LC_S_STR_CD.Text.length == 0){                                      // 점
             showMessage(EXCLAMATION, OK, messageCode, "점");
             LC_S_STR_CD.Focus();
             return false;
         }   
         if(EM_S_S_INVOICE_DT.Text.length == 0){                                //INVOICE 기간1
             showMessage(EXCLAMATION, OK, messageCode, "OFFER 기간");
             EM_S_S_INVOICE_DT.Focus();
             return false;
         }  
         if(EM_S_E_INVOICE_DT.Text.length == 0){                                //INVOICE 기간2
        	 showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미존재하는 INVOICE NO 입니다.");
             EM_S_E_INVOICE_DT.Focus();
             return false;
         } 
         
         if(EM_S_S_INVOICE_DT.Text > EM_S_E_INVOICE_DT.Text){                   // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1015");
             EM_S_S_INVOICE_DT.Focus();
             return false;
         }
         return true;
         
     case "Add":
         if(LC_I_STR_CD.Text.length == 0){                                      // 점
             showMessage(EXCLAMATION, OK, "USER-1002", "점");                 
             LC_I_STR_CD.Focus();                                              
             return false;                                                      
         }
         
         if(EM_I_OFFER_NO.Text.length == 0){                                    // OFFER_NO
             showMessage(EXCLAMATION, OK, "USER-1002", "OFFER_NO");                 
             LC_I_STR_CD.Focus();                                              
             return false;                                                      
         }

         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "OFFER_SHEET_NO", "OFFER_NO", "EM_I_OFFER_NO") )  //OFFER_NO 
             return false;
//         if(EM_I_OFFER_NO.Text.length == 0){                                  // OFFER NO
//             showMessage(EXCLAMATION, OK, "USER-1002", "OFFER NO");                 
//             EM_I_OFFER_NO.Focus();                                              
//             return false;                                                      
//         }
         /*         
         if(EM_I_PUMBUN_CD.Text.length == 0){                                 // 브랜드코드
             showMessage(EXCLAMATION, OK, "USER-1002", "브랜드코드");                 
             EM_I_PUMBUN_CD.Focus();                                              
             return false;                                                      
         }
                                                                                
         if(EM_I_VEN_CD.Text.length == 0){                                      // 협력사 코드
             showMessage(EXCLAMATION, OK, "USER-1002", "협력사코드");
             EM_I_VEN_CD.Focus();
             return false;
          } 
         */                                                                               
         if(EM_I_INVOICE_DT.Text.length == 0){                                  // INVOICE 일자
             showMessage(EXCLAMATION, OK, "USER-1002", "INVOICE일자");
             EM_I_INVOICE_DT.Focus();
             return false;
          } 
                                                                                
         if(EM_I_INVOICE_NO.Text.length == 0){                                  // INVOICE NO
             showMessage(EXCLAMATION, OK, "USER-1002", "INVOICE NO");
             EM_I_INVOICE_NO.Focus();
             return false;
          } 
                                                                                
         if(!checkInvoiceNo()){                                                  // INVOICE NO
             showMessage(EXCLAMATION, OK, "USER-1002", "INVOICE NO");
             EM_I_INVOICE_NO.Focus();
             return false;
         } 
         
         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "INVOICE_NO", "INVOICE_NO", "EM_I_INVOICE_NO") )  // INVOICE_NO
             return false;         

         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "LC_NO", "LC_NO", "EM_I_LC_NO") )                 // LC_NO 
             return false;

         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "SHIP_PORT", "선적항", "EM_I_SHIP_PORT") )        // 선적항 
             return false;
         
         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "BL_NO", "BL_NO", "EM_I_BL_NO") )                 // BL_NO 
             return false;
         
         if(LC_I_CURRENCY_CD.BindColVal.length == 0){                   // 화폐단위
             showMessage(EXCLAMATION, OK, "USER-1002", "화폐단위");
             LC_I_CURRENCY_CD.Focus();
             return false;
         }
         
         if(EM_I_EXC_APP_DT.Text.length == 0){                          // 환율적용일 
             showMessage(EXCLAMATION, OK, "USER-1002", "환율적용일");
             EM_I_EXC_APP_DT.Focus();
             return false;
          } 
         
         if(EM_I_EXC_RATE.Text.length == 0){                            // 환율
             showMessage(EXCLAMATION, OK, "USER-1002", "환율");
             EM_I_EXC_RATE.Focus();
             return false;
         }
         
         if(EM_I_EXC_RATE.Text <= 0){                                   // 환율
             showMessage(EXCLAMATION, OK, "USER-1008", "환율",  "0");
             EM_I_EXC_RATE.Focus();
             return false;
         }
         
         if(EM_I_DELI_DT.Text.length == 0){                             // 납품예정일
             showMessage(EXCLAMATION, OK, "USER-1002", "납품예정일");
             EM_I_DELI_DT.Focus();
             return false;
          } 
         
         if(EM_I_PRC_APP_DT.Text.length == 0){                          // 가격적용일
             showMessage(EXCLAMATION, OK, "USER-1002", "가격적용일");
             EM_I_PRC_APP_DT.Focus();
             return false;
          } 
                   
         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "IMPORT_NO", "수입신고번호", "EM_I_IMPORT_NO") )  // 수입신고번호 
             return false;
         
//         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "SLIP_NO", "전표번호", "EM_I_SLIP_NO") )        // 전표번호 
//             return false;
         
         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "REMARK", "비고", "EM_I_REMARK") )                // 비고 
             return false;       
         
         var strSkucd             = "";                  // 단품코드
         var intQty               = 0;                   // INVOICE 수량             
         var intInvoiceUnitAmt    = 0;                   // 외화단가
         var intInvoiceKorUnitAmt = 0;                   // 원화(원가단가)
         var intSalePrc           = 0;                   // 매가단가

         var intRowCount   = DS_IO_DETAIL.CountRow;
         if(intRowCount > 0){
             for(var i=1; i <= intRowCount; i++){
                 
                 strSkucd             = DS_IO_DETAIL.NameValue(i, "SKU_CD");
                 intQty               = DS_IO_DETAIL.NameValue(i, "INVOICE_QTY");
                 intInvoiceUnitAmt    = DS_IO_DETAIL.NameValue(i, "INVOICE_UNIT_AMT");
                 intInvoiceKorUnitAmt = DS_IO_DETAIL.NameValue(i, "INVOICE_KOR_UNIT_AMT");
                 intSalePrc           = DS_IO_DETAIL.NameValue(i, "SALE_PRC");        

                 if(strSkucd.length <= 0){
                     return true;
                 }

                 if(!checkSkuInfo(i)){
//                     showMessage(EXCLAMATION, OK, "USER-1069", "단품코드");
                     GR_DETAIL.SetColumn("SKU_CD");  
                     DS_IO_DETAIL.RowPosition = i;  
                     return false;
                 }
                 /*
                 // 중복체크
                var dupRow = checkDupKey(DS_IO_DETAIL, "SKU_CD");
                if (dupRow > 0) {
                    showMessage(EXCLAMATION, OK,  "USER-1044", dupRow);
                    DS_IO_DETAIL.RowPosition = dupRow;
                    DS_IO_DETAIL.NameValue(dupRow, "CHECK1") = "T";
                    GR_DETAIL.SetColumn("SKU_CD");
                    GR_DETAIL.Focus(); 

                    return false;
                }
                */
                
                 if(intQty <= 0){
                     showMessage(EXCLAMATION, OK, "USER-1003", "INVOICE 수량");
                     DS_IO_DETAIL.RowPosition = i;
                     DS_IO_DETAIL.NameValue(i, "CHECK1") = "T";
                     GR_DETAIL.SetColumn("INVOICE_QTY");
                     GR_DETAIL.Focus(); 
 
                     return false;
                 }                 
                 
                 if(intInvoiceUnitAmt <= 0){
                     showMessage(EXCLAMATION, OK, "USER-1008", "외화단가",  "0");
                     DS_IO_DETAIL.RowPosition = i;
                     DS_IO_DETAIL.NameValue(i, "CHECK1") = "T";
                     GR_DETAIL.SetColumn("INVOICE_UNIT_AMT");
                     GR_DETAIL.Focus();
      
                     return false;
                 }
                 
                 if(intSalePrc <= 0){
                     showMessage(EXCLAMATION, OK, "USER-1008", "매가단가",  "0");
                     DS_IO_DETAIL.RowPosition = i;
                     DS_IO_DETAIL.NameValue(i, "CHECK1") = "T";
                     GR_DETAIL.SetColumn("SALE_PRC");
                     GR_DETAIL.Focus();
      
                     return false;
                 }

                 if(intInvoiceKorUnitAmt > intSalePrc){
                     showMessage(EXCLAMATION, OK, "USER-1020", "매가단가",  "원가단가");
                     DS_IO_DETAIL.RowPosition = i;
                     DS_IO_DETAIL.NameValue(i, "CHECK1") = "T";
                     GR_DETAIL.SetColumn("SALE_PRC");
                     GR_DETAIL.Focus();
      
                     return false;
                 }
             }
         }
         return true; 
         
     case "Save":   
    	 
    	 // 저장시 인보이스 상태
    	 var strReturnValue = chkInvoiceStat();
    	 if(strReturnValue == "A"){
             showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 OFFER마감처리 되었습니다.");  
             return false;
             
    	 }else if(strReturnValue == "B"){
             showMessage(EXCLAMATION, OK, "GAUCE-1000", "전표를 수정할 수 없습니다.");  
             return false;
    	 }
    	 
         if(LC_I_STR_CD.Text.length == 0){                                      // 점
             showMessage(EXCLAMATION, OK, "USER-1002", "점");                 
             LC_I_STR_CD.Focus();                                              
             return false;                                                      
         }
         
         if(EM_I_OFFER_NO.Text.length == 0){                                    // OFFER_NO
             showMessage(EXCLAMATION, OK, "USER-1002", "OFFER_NO");                 
             LC_I_STR_CD.Focus();                                              
             return false;                                                      
         }

         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "OFFER_SHEET_NO", "OFFER_NO", "EM_I_OFFER_NO") )  //OFFER_NO 
             return false;
//         if(EM_I_OFFER_NO.Text.length == 0){                                  // OFFER NO
//             showMessage(EXCLAMATION, OK, "USER-1002", "OFFER NO");                 
//             EM_I_OFFER_NO.Focus();                                              
//             return false;                                                      
//         }
         /*         
         if(EM_I_PUMBUN_CD.Text.length == 0){                                 // 브랜드코드
             showMessage(EXCLAMATION, OK, "USER-1002", "브랜드코드");                 
             EM_I_PUMBUN_CD.Focus();                                              
             return false;                                                      
         }
                                                                                
         if(EM_I_VEN_CD.Text.length == 0){                                      // 협력사 코드
             showMessage(EXCLAMATION, OK, "USER-1002", "협력사코드");
             EM_I_VEN_CD.Focus();
             return false;
          } 
         */                                                                               
         if(EM_I_INVOICE_DT.Text.length == 0){                                  // INVOICE 일자
             showMessage(EXCLAMATION, OK, "USER-1002", "INVOICE일자");
             EM_I_INVOICE_DT.Focus();
             return false;
          } 
                                                                                
         if(EM_I_INVOICE_NO.Text.length == 0){                                  // INVOICE NO
             showMessage(EXCLAMATION, OK, "USER-1002", "INVOICE NO");
             EM_I_INVOICE_NO.Focus();
             return false;
          } 
                                                                                
         if(!checkInvoiceNo()){                                                  // INVOICE NO
             showMessage(EXCLAMATION, OK, "USER-1002", "INVOICE NO");
             EM_I_INVOICE_NO.Focus();
             return false;
         } 
         
         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "INVOICE_NO", "INVOICE_NO", "EM_I_INVOICE_NO") )  // INVOICE_NO
             return false;         

         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "LC_NO", "LC_NO", "EM_I_LC_NO") )                 // LC_NO 
             return false;

         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "SHIP_PORT", "선적항", "EM_I_SHIP_PORT") )        // 선적항 
             return false;
         
         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "BL_NO", "BL_NO", "EM_I_BL_NO") )                 // BL_NO 
             return false;
         
         if(LC_I_CURRENCY_CD.BindColVal.length == 0){                   // 화폐단위
             showMessage(EXCLAMATION, OK, "USER-1002", "화폐단위");
             LC_I_CURRENCY_CD.Focus();
             return false;
         }
         
         if(EM_I_EXC_APP_DT.Text.length == 0){                          // 환율적용일 
             showMessage(EXCLAMATION, OK, "USER-1002", "환율적용일");
             EM_I_EXC_APP_DT.Focus();
             return false;
          } 
         
         if(EM_I_EXC_RATE.Text.length == 0){                            // 환율
             showMessage(EXCLAMATION, OK, "USER-1002", "환율");
             EM_I_EXC_RATE.Focus();
             return false;
         }
         
         if(EM_I_EXC_RATE.Text <= 0){                                   // 환율
             showMessage(EXCLAMATION, OK, "USER-1008", "환율",  "0");
             EM_I_EXC_RATE.Focus();
             return false;
         }
         
         if(EM_I_DELI_DT.Text.length == 0){                             // 납품예정일
             showMessage(EXCLAMATION, OK, "USER-1002", "납품예정일");
             EM_I_DELI_DT.Focus();
             return false;
          } 
         
         if(EM_I_PRC_APP_DT.Text.length == 0){                          // 가격적용일
             showMessage(EXCLAMATION, OK, "USER-1002", "가격적용일");
             EM_I_PRC_APP_DT.Focus();
             return false;
          } 
                   
         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "IMPORT_NO", "수입신고번호", "EM_I_IMPORT_NO") )  // 수입신고번호 
             return false;
         
//         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "SLIP_NO", "전표번호", "EM_I_SLIP_NO") )        // 전표번호 
//             return false;
         
         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "REMARK", "비고", "EM_I_REMARK") )                // 비고 
             return false;       
         
         var strSkucd             = "";                  // 단품코드
         var intQty               = 0;                   // INVOICE 수량             
         var intInvoiceUnitAmt    = 0;                   // 외화단가
         var intInvoiceKorUnitAmt = 0;                   // 원화(원가단가)
         var intSalePrc           = 0;                   // 매가단가

         var intRowCount   = DS_IO_DETAIL.CountRow;
         if(intRowCount > 0){
             for(var i=1; i <= intRowCount; i++){
                 
                 strSkucd             = DS_IO_DETAIL.NameValue(i, "SKU_CD");
                 intQty               = DS_IO_DETAIL.NameValue(i, "INVOICE_QTY");
                 intInvoiceUnitAmt    = DS_IO_DETAIL.NameValue(i, "INVOICE_UNIT_AMT");
                 intInvoiceKorUnitAmt = DS_IO_DETAIL.NameValue(i, "INVOICE_KOR_UNIT_AMT");
                 intSalePrc           = DS_IO_DETAIL.NameValue(i, "SALE_PRC");        

                 
                 if(strSkucd.length <= 0){
                     DS_IO_DETAIL.NameValue(i, "CHECK1") = "T";
                 }else{    
                     DS_IO_DETAIL.NameValue(i, "CHECK1") = "F";      

                     if(!checkSkuInfo(i)){
                         GR_DETAIL.SetColumn("SKU_CD");  
                         DS_IO_DETAIL.RowPosition = i;  
                         DS_IO_DETAIL.NameValue(i, "CHECK1") = "T";
                         return false;
                     }
                     
                     /*
                     // 중복체크
                     var dupRow = checkDupKey(DS_IO_DETAIL, "SKU_CD");
                     if (dupRow > 0) {
                        showMessage(EXCLAMATION, OK,  "USER-1044", dupRow);
                        //DS_IO_DETAIL.NameValue( dupRow, "SKU_CD")  = "";
                        
                        DS_IO_DETAIL.RowPosition = dupRow;
                        DS_IO_DETAIL.NameValue(dupRow, "CHECK1") = "T";
                        GR_DETAIL.SetColumn("SKU_CD");
                        GR_DETAIL.Focus(); 

                        return false;
                     }
                     */
                    
                     if(intQty <= 0){
                         showMessage(EXCLAMATION, OK, "USER-1003", "INVOICE 수량");
                         DS_IO_DETAIL.RowPosition = i;
                         DS_IO_DETAIL.NameValue(i, "CHECK1") = "T";
                         GR_DETAIL.SetColumn("INVOICE_QTY");
                         GR_DETAIL.Focus(); 
     
                         return false;
                     }                 
                     
                     if(intInvoiceUnitAmt <= 0){
                         showMessage(EXCLAMATION, OK, "USER-1008", "외화단가",  "0");
                         DS_IO_DETAIL.RowPosition = i;
                         DS_IO_DETAIL.NameValue(i, "CHECK1") = "T";
                         GR_DETAIL.SetColumn("INVOICE_UNIT_AMT");
                         GR_DETAIL.Focus();
          
                         return false;
                     }
                     
                     if(intSalePrc <= 0){
                         showMessage(EXCLAMATION, OK, "USER-1008", "매가단가",  "0");
                         DS_IO_DETAIL.RowPosition = i;
                         DS_IO_DETAIL.NameValue(i, "CHECK1") = "T";
                         GR_DETAIL.SetColumn("SALE_PRC");
                         GR_DETAIL.Focus();
          
                         return false;
                     }

                     if(intInvoiceKorUnitAmt > intSalePrc){
                         showMessage(EXCLAMATION, OK, "USER-1020", "매가단가",  "원가단가");
                         DS_IO_DETAIL.RowPosition = i;
                         DS_IO_DETAIL.NameValue(i, "CHECK1") = "T";
                         GR_DETAIL.SetColumn("SALE_PRC");
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
         // 삭제시 인보이스 상태
         var strReturnValue = chkInvoiceStat();
         if(strReturnValue == "A"){
             showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미 OFFER마감처리 되었습니다.");  
             return false;
             
         }else if(strReturnValue == "B"){
             showMessage(EXCLAMATION, OK, "GAUCE-1000", "전표를 삭제할 수 없습니다.");  
             return false;
         }
         return true; 
     }     
}

/**
 * getOfferNoPopup()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-14 
 * 개    요 : OFFER NO 따른 상세정보 조회 팝업
 * 사용방법 : getOfferNoPopup()
 * return값 : OrderNo
 */
 function getOfferNoPopup(){
     
        var arrArg    = new Array();     
        var row       = DS_IO_MASTER.RowPosition;
        var strStrCd  = LC_I_STR_CD.BindColVal;           
        arrArg        = offerSheetPop(strStrCd);           //offer no 팝업
/*        
        var retStrCd  = arrArg[0].STR_CD;
        var retOfferYm = arrArg[0].OFFER_YM;
        var retOfferSeqNo = arrArg[0].OFFER_SEQ_NO;
        var retOfferNo = retStrCd + retOfferYm + retOfferSeqNo;
*/        
        if(arrArg != null){
	
	        DS_IO_DETAIL.ClearData();
	        DS_IO_MASTER.NameValue(row, "OFFER_YM") = arrArg[0].OFFER_YM;                  // OFFER_SEQ_NO  
	        DS_IO_MASTER.NameValue(row, "OFFER_SEQ_NO") = arrArg[0].OFFER_SEQ_NO;          // OFFER_SEQ_NO  
	        DS_IO_MASTER.NameValue(row, "OFFER_SHEET_NO") = arrArg[0].OFFER_SHEET_NO;      // OFFER_NO  
	        DS_IO_MASTER.NameValue(row, "OFFER_DT") = arrArg[0].OFFER_DT;                  // OFFER_DT 
	        DS_IO_MASTER.NameValue(row, "PUMBUN_CD") = arrArg[0].PUMBUN_CD;                // 브랜드코드
	        DS_IO_MASTER.NameValue(row, "BL_NO") = arrArg[0].BL_NO;   
	        DS_IO_MASTER.NameValue(row, "IMPORT_COUNTRY") = arrArg[0].IMPORT_COUNTRY;      // 수입국가
	        DS_IO_MASTER.NameValue(row, "SHIP_PORT") = arrArg[0].SHIP_PORT;                // 선적항  
	        DS_IO_MASTER.NameValue(row, "ARRI_PORT") = arrArg[0].ARRI_PORT;                // 도착항  
	        DS_IO_MASTER.NameValue(row, "LC_DATE") = arrArg[0].LC_DATE;            
	        DS_IO_MASTER.NameValue(row, "LC_NO") = arrArg[0].LC_NO;  
	        DS_IO_MASTER.NameValue(row, "PRC_COND") = arrArg[0].PRC_COND;                  // 가격조건
	        DS_IO_MASTER.NameValue(row, "PAYMENT_COND") = arrArg[0].PAYMENT_COND;          // 결제조건
	        DS_IO_MASTER.NameValue(row, "PAYMENT_DTL_COND") = arrArg[0].PAYMENT_DTL_COND;  // 결제조건상세   
	        DS_IO_MASTER.NameValue(row, "CURRENCY_CD") = arrArg[0].CURRENCY_CD;            // 화폐단위   
	        DS_IO_MASTER.NameValue(row, "EXC_APP_DT") = arrArg[0].EXC_APP_DT;              // 환율적용일             
	        DS_IO_MASTER.NameValue(row, "EXC_RATE") = arrArg[0].EXC_RATE;                  // 환율   
	        DS_IO_MASTER.NameValue(row, "PACKING_CHARGE") = arrArg[0].PACKING_CHARGE;      // PACKING_CHARGE   
	        DS_IO_MASTER.NameValue(row, "NCV") = arrArg[0].NCV;                            // NCV   
	        DS_IO_MASTER.NameValue(row, "BIZ_TYPE") = strGBizType;                         // NCV   
	        DS_IO_MASTER.NameValue(row, "TAX_FLAG") = strTaxFlag;                         // NCV   
	        strGStyleType                           = arrArg[0].STYLE_TYPE;
	        
	        //해당 OFFER_NO에 등록된 단품을 디테일 그리드에 자동 셋팅해 준다.
	        if(arrArg[0].SKU_TYPE == '1'){
	            GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = false;
	            GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
	            GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;
	            
	        }else if(arrArg[0].SKU_TYPE == '2'){//신선단품
	            GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = false;
	            GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
	            GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;  
	        }
	        else if(arrArg[0].SKU_TYPE == '3'){//의류단품
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
	        
	        for(var i = 0; i < arrArg.length; i++){
	      	  DS_IO_DETAIL.AddRow();
	            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"SKU_CD")   = arrArg[i].SKU_CD;     
	            //alert("단품 정보 = " + arrArg[i].SKU_CD);
	            // getOffSkuInfo();
	            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EXC_RATE") = EM_I_EXC_RATE.Text;  //aaaa
	        }
	        return true;
        }else{
            /*        	
            showMessage(EXCLAMATION, OK, "USER-1036", "OFFER NO");
            EM_I_OFFER_NO.Text = "";
            setTimeout( "EM_I_OFFER_NO.Focus()",50);
            */
            return false;            
        }        
 }

 /**
  * getOfferNo()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-14 
  * 개    요    : OFFER NO 수기입력에 따른 OFFER정보 셋팅
  * 사용방법 : getOfferNo()
  * return값 : OFFER NO 에 따른 상세값 셋팅
  */
  function getOfferNo(){
    //조회조건 셋팅
    var strStrCd    = LC_I_STR_CD.BindColVal;   // 점코드  
    var strOfferNo  = EM_I_OFFER_NO.Text;       // OFFER_NO   
    
    var masterRow    = DS_IO_MASTER.RowPosition;
    var offerInfoRow = DS_O_OFFER_INFO.RowPosition;
         	
	var goTo       = "getOfferNo" ;    
	var action     = "O";     
	var parameters = "&strStrCd="+encodeURIComponent(strStrCd)    
                   + "&strOfferNo="+encodeURIComponent(strOfferNo); 
	TR_S_MAIN.Action   = "/dps/pord505.po?goTo="+goTo+parameters;  
	TR_S_MAIN.KeyValue = "SERVLET("+action+":DS_O_OFFER_INFO=DS_O_OFFER_INFO)";
	TR_S_MAIN.Post();       
	
	if(DS_O_OFFER_INFO.CountRow > 0){

	    DS_IO_DETAIL.ClearData();
        DS_IO_MASTER.NameValue(masterRow, "OFFER_YM")         = DS_O_OFFER_INFO.NameValue(offerInfoRow, "OFFER_YM");           // OFFER_SEQ_NO  
        DS_IO_MASTER.NameValue(masterRow, "OFFER_SEQ_NO")     = DS_O_OFFER_INFO.NameValue(offerInfoRow, "OFFER_SEQ_NO");       // OFFER_SEQ_NO  
	    DS_IO_MASTER.NameValue(masterRow, "OFFER_SHEET_NO")   = DS_O_OFFER_INFO.NameValue(offerInfoRow, "OFFER_SHEET_NO");     // OFFER_NO  
	    DS_IO_MASTER.NameValue(masterRow, "OFFER_DT")         = DS_O_OFFER_INFO.NameValue(offerInfoRow, "OFFER_DT");           // OFFER_DT 
	    DS_IO_MASTER.NameValue(masterRow, "PUMBUN_CD")        = DS_O_OFFER_INFO.NameValue(offerInfoRow, "PUMBUN_CD");          // 브랜드코드
	    DS_IO_MASTER.NameValue(masterRow, "BL_NO")            = DS_O_OFFER_INFO.NameValue(offerInfoRow, "BL_NO");   
	    DS_IO_MASTER.NameValue(masterRow, "IMPORT_COUNTRY")   = DS_O_OFFER_INFO.NameValue(offerInfoRow, "IMPORT_COUNTRY");     // 수입국가
	    DS_IO_MASTER.NameValue(masterRow, "SHIP_PORT")        = DS_O_OFFER_INFO.NameValue(offerInfoRow, "SHIP_PORT");          // 선적항  
	    DS_IO_MASTER.NameValue(masterRow, "ARRI_PORT")        = DS_O_OFFER_INFO.NameValue(offerInfoRow, "ARRI_PORT");          // 도착항  
	    DS_IO_MASTER.NameValue(masterRow, "LC_DATE")          = DS_O_OFFER_INFO.NameValue(offerInfoRow, "LC_DATE");            
	    DS_IO_MASTER.NameValue(masterRow, "LC_NO")            = DS_O_OFFER_INFO.NameValue(offerInfoRow, "LC_NO");  
	    DS_IO_MASTER.NameValue(masterRow, "PRC_COND")         = DS_O_OFFER_INFO.NameValue(offerInfoRow, "PRC_COND");           // 가격조건
	    DS_IO_MASTER.NameValue(masterRow, "PAYMENT_COND")     = DS_O_OFFER_INFO.NameValue(offerInfoRow, "PAYMENT_COND");       // 결제조건
	    DS_IO_MASTER.NameValue(masterRow, "PAYMENT_DTL_COND") = DS_O_OFFER_INFO.NameValue(offerInfoRow, "PAYMENT_DTL_COND");   // 결제조건상세   
	    DS_IO_MASTER.NameValue(masterRow, "CURRENCY_CD")      = DS_O_OFFER_INFO.NameValue(offerInfoRow, "CURRENCY_CD");        // 화폐단위   
	    DS_IO_MASTER.NameValue(masterRow, "EXC_APP_DT")       = DS_O_OFFER_INFO.NameValue(offerInfoRow, "EXC_APP_DT");         // 환율적용일             
	    DS_IO_MASTER.NameValue(masterRow, "EXC_RATE")         = DS_O_OFFER_INFO.NameValue(offerInfoRow, "EXC_RATE");           // 환율   
	    DS_IO_MASTER.NameValue(masterRow, "PACKING_CHARGE")   = DS_O_OFFER_INFO.NameValue(offerInfoRow, "PACKING_CHARGE");     // PACKING_CHARGE   
	    DS_IO_MASTER.NameValue(masterRow, "NCV")              = DS_O_OFFER_INFO.NameValue(offerInfoRow, "NCV");                // NCV  
        DS_IO_MASTER.NameValue(masterRow, "BIZ_TYPE")         = strGBizType;                         //거래형태   
        DS_IO_MASTER.NameValue(masterRow, "TAX_FLAG")         = strTaxFlag;                         //과세구분   	  
        strGStyleType                                         = DS_O_OFFER_INFO.NameValue(offerInfoRow, "STYLE_TYPE");                // NCV
        
		// 해당 OFFER_NO에 등록된 단품을 디테일 그리드에 자동 셋팅해 준다.
		if(DS_O_OFFER_INFO.NameValue(1, "SKU_TYPE") == '1'){
		    GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = false;
		    GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
		    GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;
		    
		}else if(DS_O_OFFER_INFO.NameValue(1, "SKU_TYPE") == '2'){//신선단품
		    GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = false;
		    GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
		    GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;  
		    
		}else if(DS_O_OFFER_INFO.NameValue(1, "SKU_TYPE") == '3'){//의류단품
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
		
		for(var i = 1; i <= DS_O_OFFER_INFO.CountRow; i++){
		    DS_IO_DETAIL.AddRow();
		    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"SKU_CD")   = DS_O_OFFER_INFO.NameValue(i, "SKU_CD"); //단품코드 입력시 컬럼이 체인지 되면서 단품정보 가져온다.   
            //alert("단품 정보 = " + DS_O_OFFER_INFO.NameValue(i, "SKU_CD"));
		    //          getOffSkuInfo();
		    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EXC_RATE") = EM_I_EXC_RATE.Text;
		}    
		return true;
	}else{		
	    /*		
		showMessage(EXCLAMATION, OK, "USER-1036", "OFFER NO");
	    EM_I_OFFER_NO.Text = "";
	    setTimeout( "EM_I_OFFER_NO.Focus()",50);
	    */
	    return false;
	}
  }

  /**
   * checkInvoiceNo()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-04-22 
   * 개    요 : INVOICENO 입력시  데이터 존재하는지 체크한다.
   * return값 : 
   */
   function checkInvoiceNo(){
     //조회조건 셋팅     
     var strStrCd      = LC_I_STR_CD.BindColVal;     // 점코드   
     var strInvoiceNo  = EM_I_INVOICE_NO.Text;       // INVOICE_NO   
             
     var goTo           = "checkInvoiceNo" ;    
     var action         = "O";     
     var parameters     = "&strInvoiceNo="+encodeURIComponent(strInvoiceNo)
                        + "&strStrCd="+encodeURIComponent(strStrCd);    
     
     TR_S_MAIN.Action   = "/dps/pord505.po?goTo="+goTo+parameters;  
     TR_S_MAIN.KeyValue = "SERVLET("+action+":DS_O_INVOICE_INFO=DS_O_INVOICE_INFO)";
     TR_S_MAIN.Post();    
     
     if(DS_LIST.NameValue(DS_LIST.RowPosition, "SLIP_PROC_STAT") == "00"){
    	 return true;
     }
     
     if(DS_O_INVOICE_INFO.CountRow > 0){
    	 showMessage(EXCLAMATION, OK, "GAUCE-1000", "이미존재하는 INVOICE NO 입니다.");  

    	 return false;
     }else
    	 return true;
   }

   /**
    * chkInvoiceStat()
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-07-19 
    * 개    요 : INVOICENO 저장, 삭제시 체크 항목(전표진행상태, 오퍼마감)
    * return값 : 
    */
    function chkInvoiceStat(){
      //조회조건 셋팅     
      var strStrCd       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");          // 점코드   
      var strOfferNo     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "OFFER_SHEET_NO");  // OFFER_NO  
      
      var strReturnValue = "";
              
      var goTo           = "chkInvoiceStat" ;    
      var action         = "O";     
      var parameters     = "&strOfferNo="+encodeURIComponent(strOfferNo)
                         + "&strStrCd="+encodeURIComponent(strStrCd);    
      
      TR_S_MAIN.Action   = "/dps/pord505.po?goTo="+goTo+parameters;  
      TR_S_MAIN.KeyValue = "SERVLET("+action+":DS_INVOICE_STAT=DS_INVOICE_STAT)";
      TR_S_MAIN.Post();    
      
      if(DS_INVOICE_STAT.CountRow == 1){
          if(DS_INVOICE_STAT.NameValue(DS_INVOICE_STAT.RowPosition, "CLOSE_FLAG") == "Y"){
              strReturnValue = "A";
              return strReturnValue;          
          }
          
          if(DS_INVOICE_STAT.NameValue(DS_INVOICE_STAT.RowPosition, "SLIP_PROC_STAT") != "00"){
              strReturnValue = "B";
              return strReturnValue;
          }    	  
      }else if(DS_INVOICE_STAT.CountRow == 0){
          return strReturnValue;
      }
      return strReturnValue;
    }
  
 /**
  * setDsMasterOfOfferNo(flag)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-25 
  * 개    요 : OFFER NO를지우면 마스터 정보 클리어
  * 사용방법 : setDsMasterOfOfferNo()
  * return값 : 
  */
  function setDsMasterOfOfferNo(flag){
      
      OFFER_SHEET_NO.Enable   = flag
      PUMBUN_CD.Enable        = flag
      BL_NO.Enable            = flag
      IMPORT_COUNTRY.Enable   = flag
      SHIP_PORT.Enable        = flag
      ARRI_PORT.Enable        = flag
      LC_DATE.Enable          = flag
      LC_NO.Enable            = flag
      PRC_COND.Enable         = flag
      PAYMENT_COND.Enable     = flag
      PAYMENT_DTL_COND.Enable = flag
      CURRENCY_CD.Enable      = flag
      EXC_APP_DT.Enable       = flag
      EXC_RATE.Enable         = flag
      PACKING_CHARGE.Enable   = flag
      NCV.Enable              = flag
  }
 
 //컴퍼넌트 날짜입력 체크함수
 function checkDateFormat(obj, setDate, message){
     if(isYYYYMMDD(obj.Text) == ""){
         showMessage(EXCLAMATION, OK, "USER-1007", message);
         obj.Text = setDate;
         obj.Focus();        
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
      var strStrCd        = LC_S_STR_CD.BindColVal;                                    // 점
      var strOrgCd        = tmpOrgCd + "00000000";                                     // 조직코드
      var strVenCd        = "";                                                        // 협력사
      var strBuyerCd      = "";                                                        // 바이어
      var strPumbunType   = "0";                                                       // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "1";                                                       // 단품구분(2:비단품)
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
       var strOrgCd        = tmpOrgCd + "00000000";                                     // 조직코드
       var strVenCd        = "";                                                        // 협력사
       var strBuyerCd      = "";                                                        // 바이어
       var strPumbunType   = "0";                                                       // 브랜드유형
       var strUseYn        = "Y";                                                       // 사용여부
       var strSkuFlag      = "1";                                                       // 단품구분(2:비단품)
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
  * getOffSkuInfo(flag)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-24
  * 개    요 :  상세내역의 단품관련 데이터 조회
  * return값 : void
  */
  function getOffSkuInfo(row){  
	 
	  var strStrCd      = LC_I_STR_CD.BindColVal;
	  var strSkuCd      = DS_IO_DETAIL.NameValue(row, "SKU_CD");
	  var strAppDt      = EM_I_PRC_APP_DT.Text;
	  var strOfferYm    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition ,"OFFER_YM");
	  var strOfferSeqNo = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition ,"OFFER_SEQ_NO");
	  var strExcRate    = EM_I_EXC_RATE.Text;
	  
	  var goTo       = "getOffSkuInfo" ;    
	  var action     = "O";     
	  var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
	                 + "&strSkuCd="+encodeURIComponent(strSkuCd)    
	                 + "&strAppDt="+encodeURIComponent(strAppDt)   
	                 + "&strOfferYm="+encodeURIComponent(strOfferYm)   
	                 + "&strOfferSeqNo="+encodeURIComponent(strOfferSeqNo)
	                 + "&strExcRate="+encodeURIComponent(strExcRate);     
	  TR_S_MAIN.Action="/dps/pord505.po?goTo="+goTo+parameters;  
	  TR_S_MAIN.KeyValue="SERVLET("+action+":DS_O_SKU_INFO=DS_O_SKU_INFO)";
	  TR_S_MAIN.Post(); 
	
	  if(DS_O_SKU_INFO.CountRow == 0){
	      showMessage(EXCLAMATION, OK, "GAUCE-1000", "해당 단품에 정보가 없습니다. 확인바랍니다."); 
	      clearSkuInfo();                     
	      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CHECK1") = "T";
	      return false;
	  }
	
	  DS_IO_DETAIL.NameValue(row, "STR_CD")              = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");           // 점코드
	  DS_IO_DETAIL.NameValue(row, "INVOICE_YM")          = strYYYYMM;                                                            // 인보이스년월
	  DS_IO_DETAIL.NameValue(row, "SKU_CD")              = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SKU_CD");         // 단품코드
	  DS_IO_DETAIL.NameValue(row, "SKU_NM")              = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SKU_NM");         // 단품명
	  DS_IO_DETAIL.NameValue(row, "PUMMOK_CD")           = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "PUMMOK_CD");      // 품목코드
	  DS_IO_DETAIL.NameValue(row, "STYLE_CD")            = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "STYLE_CD");       //
	  DS_IO_DETAIL.NameValue(row, "COLOR_CD")            = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "COLOR_CD");       //
	  DS_IO_DETAIL.NameValue(row, "SIZE_CD")             = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SIZE_CD");        //
	  DS_IO_DETAIL.NameValue(row, "MODEL_NO")            = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "MODEL_NO");       //
	  DS_IO_DETAIL.NameValue(row, "ORD_UNIT_CD")         = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SALE_UNIT_CD");   //
	  DS_IO_DETAIL.NameValue(row, "ORD_UNIT_NM")         = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SALE_UNIT_NM");   //
	  DS_IO_DETAIL.NameValue(row, "INVOICE_QTY")         = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "OFFER_QTY");      //
	  DS_IO_DETAIL.NameValue(row, "INVOICE_UNIT_AMT")    = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "OFFER_UNIT_AMT"); //
	  DS_IO_DETAIL.NameValue(row, "INVOICE_AMT ")        = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "OFFER_AMT");      //
	  DS_IO_DETAIL.NameValue(row, "INVOICE_KOR_UNIT_AMT")= DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "COST_PRC");       //
	  DS_IO_DETAIL.NameValue(row, "INVOICE_AMT ")        = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "COST_AMT");       //
	  DS_IO_DETAIL.NameValue(row, "SALE_PRC")            = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SALE_PRC");       // 매가단가
	  DS_IO_DETAIL.NameValue(row, "SALE_AMT")            = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SALE_AMT");       // 매가금액
	  DS_IO_DETAIL.NameValue(row, "TAX_FLAG")            = strTaxFlag;     //
	  DS_IO_DETAIL.NameValue(row, "BIZ_TYPE")            = strGBizType;     //
	  DS_IO_DETAIL.NameValue(row, "GAP_RATE")            = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "GAP_RATE");       // 차익율
	  DS_IO_DETAIL.NameValue(row, "GAP_AMT")             = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "GAP_AMT");        // 차익액
  }

  /**
  * clearSkuInfo(flag)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-24
  * 개    요 :  상세내역의 초기화
  * return값 : void
  */
  function clearSkuInfo(){  

      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PUMMOK_CD")             = "";
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SKU_NM")                = "";
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STYLE_CD")              = "";
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "COLOR_CD")              = "";
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SIZE_CD")               = "";
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "MODEL_NO")              = "";
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORD_UNIT_CD")           = "";
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORD_UNIT_NM")           = "";
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INVOICE_QTY")           = 0;
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INVOICE_UNIT_AMT")      = 0;
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INVOICE_KOR_UNIT_AMT")  = 0;
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INVOICE_AMT")           = 0;
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INVOICE_KOR_AMT")       = 0;
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SALE_PRC")              = 0;
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SALE_AMT")              = 0;
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAP_RATE")              = 0;
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAP_AMT")               = 0;  
  }

  /**
  * getSkuInfo(flag)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-24
  * 개    요 :  상세내역의 단품관련 데이터 조회
  * return값 : void
  */
  function getSkuInfo(flag, strSku){  
      
      //조회조건 셋팅
      var strStrCd    = LC_I_STR_CD.BindColVal; // 점 
      var strOfferNo  = EM_I_OFFER_NO.Text;     // OFFER_NO 
      var strPrcAppDt = EM_I_PRC_APP_DT.Text;   // 가격적용일
      var strSkuCd    = "";                     // 단품코드     
      
      if(flag == 'D'){                          	  
    	  
            var goTo       = "getSkuInfo" ;    
            var action     = "O";     
            var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)    
                            + "&strOfferNo="+encodeURIComponent(strOfferNo) 
                            + "&strPrcAppDt="+encodeURIComponent(strPrcAppDt)     
                            + "&strSkuCd="+encodeURIComponent(strSku);
            TR_S_MAIN.Action   = "/dps/pord505.po?goTo="+goTo+parameters;  
            TR_S_MAIN.KeyValue = "SERVLET("+action+":DS_O_SKU_INFO=DS_O_SKU_INFO)";
            TR_S_MAIN.Post();
/*                        
            alert("카운트로우 = " + DS_O_SKU_INFO.CountRow);
            if(DS_O_SKU_INFO.CountRow == 0){
                showMessage(EXCLAMATION, OK, "GAUCE-1000", "해당 단품에 가격정보가 없습니다. 확인바랍니다."); 
                DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
                DS_IO_DETAIL.InsertRow(DS_IO_DETAIL.RowPosition);
                return false;
            }
*/           
            //alert("strSku = " + strSku);
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PUMMOK_CD")   = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "PUMMOK_CD");       // 품목코드
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "MODEL_NO")    = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "MODEL_NO");        // 모델코드
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STYLE_CD")    = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "STYLE_CD");        // 스타일
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "COLOR_CD")    = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "COLOR_CD");        // 컬러
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SIZE_CD")     = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SIZE_CD");         // 사이즈
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SALE_PRC")    = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SALE_PRC");        // 매가단가

      }else if(flag == 'M'){
            for(var i=1; i<=DS_IO_DETAIL.CountRow; i++){
//                alert(i);
                strSkuCd = DS_IO_DETAIL.NameValue(i, "SKU_CD"); // 단품코드 
                
                var goTo       = "getSkuInfo" ;    
                var action     = "O";     
                var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)    
                                + "&strPrcAppDt="+encodeURIComponent(strPrcAppDt)     
                                + "&strSkuCd="+encodeURIComponent(strSkuCd);
                TR_S_MAIN.Action   = "/dps/pord505.po?goTo="+goTo+parameters;  
                TR_S_MAIN.KeyValue = "SERVLET("+action+":DS_O_SKU_INFO=DS_O_SKU_INFO)"; //조회는 O
                TR_S_MAIN.Post();
                
                if(DS_O_SKU_INFO.CountRow > 0){      
//                  alert(DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SALE_PRC"));
                    DS_IO_DETAIL.NameValue(i, "SALE_PRC")  = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SALE_PRC");        // 매가단가
                }
            }             
            if(DS_O_SKU_INFO.CountRow > 0){
                return true;                    
            }  
      }else{       
          return false;   
      }
  }
    
  /**
  * checkSkuInfo(i)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-31
  * 개    요 :  저장시 저장가능한 단품인지 체크한다
  * return값 : void
  */
  function checkSkuInfo(i){      
      //  alert("단품정보");
      var strStrCd      = LC_I_STR_CD.BindColVal;
      var strSkuCd      = DS_IO_DETAIL.NameValue(i, "SKU_CD");
      var strAppDt      = EM_I_PRC_APP_DT.Text;
      var strOfferYm    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition ,"OFFER_YM");
      var strOfferSeqNo = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition ,"OFFER_SEQ_NO");
      var strExcRate    = EM_I_EXC_RATE.Text;
      
      var goTo       = "getOffSkuInfo" ;    
      var action     = "O";     
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
                     + "&strSkuCd="+encodeURIComponent(strSkuCd)    
                     + "&strAppDt="+encodeURIComponent(strAppDt)   
                     + "&strOfferYm="+encodeURIComponent(strOfferYm)  
                     + "&strOfferSeqNo="+encodeURIComponent(strOfferSeqNo)
                     + "&strExcRate="+encodeURIComponent(strExcRate);     
      TR_S_MAIN.Action="/dps/pord505.po?goTo="+goTo+parameters;  
      TR_S_MAIN.KeyValue="SERVLET("+action+":DS_O_SKU_INFO=DS_O_SKU_INFO)";
      TR_S_MAIN.Post(); 

      if(DS_O_SKU_INFO.CountRow == 0){
          showMessage(EXCLAMATION, OK, "GAUCE-1000", "해당 단품에 정보가 없습니다. 확인바랍니다."); 
          clearSkuInfo();   //단품코드만 남기고 해당 로우의 단품정보를 지운다.
          return false;
      }else{
    	  return true;
      }
  
 /*     
      //조회조건 셋팅
      var strStrCd    = LC_I_STR_CD.BindColVal;// 점 
      var strOfferNo  = EM_I_OFFER_NO.Text;    // OFFER_NO 
      var strPrcAppDt = EM_I_PRC_APP_DT.Text;  // 가격적용일
      var strSkuCd    = "";                    // 단품코드     
  
      strSkuCd     = DS_IO_DETAIL.NameValue(i, "SKU_CD"); // 단품코드 
      
      var goTo       = "getSkuInfo" ;    
      var action     = "O";     
      var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)   
                      + "&strOfferNo="+encodeURIComponent(strOfferNo) 
                      + "&strPrcAppDt="+encodeURIComponent(strPrcAppDt)     
                      + "&strSkuCd="+encodeURIComponent(strSkuCd);
      TR_S_MAIN.Action   = "/dps/pord505.po?goTo="+goTo+parameters;  
      TR_S_MAIN.KeyValue = "SERVLET("+action+":DS_O_SKU_INFO=DS_O_SKU_INFO)"; //조회는 O
      TR_S_MAIN.Post();
      
      if(DS_O_SKU_INFO.CountRow > 0){      
          return true;
      }else
    	  //저장할 수 없는 단품에 포커스 간다
          //setFocusGrid(GR_DETAIL, DS_IO_DETAIL, DS_IO_DETAIL.RowPosition ,"OFFER_QTY");
          return false;   
*/
  }

  /**
  * setCalc(calFlag)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-24
  * 개    요 :  계산식 반영(외화,원화, 차익율)
  * return값 : void
  */
 function setCalc(calFlag){   
     var strInvoiceQty        = 0;         // 수량
     var strInvoiceUnitAmt    = 0;         // 외화단가
     var strInvoiceKorUnitAmt = 0;         // 원화단가
     var strInvoiceAmt        = 0;         // 외화금액
     var strInvoiceKorAmt     = 0;         // 원화금액     
     var strSalePrc           = 0;         // 매가단가     
     var strSaleAmt           = 0;         // 매가금액     
     var strGapRate           = 0;         // 차익율          
     var strExcRate           = 0;         // 환율
     var strInvoiceAmt        = 0;         // INVOICE 금액
     var Tot_QTY              = 0;         // 수량계
     var Tot_NewCostAmt       = 0;         // 원가계
     var Tot_NewSaleAmt       = 0;         // 매가계
     var Tot_InvoiceAmt       = 0;         // INVOICE 금액     
     var totGapAmt            = 0;         // 차익액

     strTaxFlag              = EM_TAX_FLAG.Text; // 과세구분
     if(calFlag == 'D'){    //디테일 변경시     
         strInvoiceQty        = parseInt(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INVOICE_QTY"));             // 수량
         strInvoiceUnitAmt    = parseInt(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INVOICE_UNIT_AMT"));        // 외화단가
         strInvoiceKorUnitAmt = parseInt(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INVOICE_KOR_UNIT_AMT"));    // 원화단가
         strInvoiceAmt        = parseInt(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INVOICE_AMT"));             // 외화금액
         strInvoiceKorAmt     = parseInt(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INVOICE_KOR_AMT"));         // 원화금액     
         strSalePrc           = parseInt(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SALE_PRC"));                // 매가단가     
         strSaleAmt           = parseInt(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SALE_AMT"));                // 매가금액     
         strGapRate           = parseInt(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAP_RATE"));                // 차익율              
         strExcRate           = parseInt(EM_I_EXC_RATE.Text);                                                          // 환율
         strInvoiceAmt        = parseInt(EM_I_INVOICE_AMT.Text);                                                       // INVOICE 금액

         Tot_QTY              = 0;    // 수량계
         Tot_NewCostAmt       = 0;    // 원가계
         Tot_NewSaleAmt       = 0;    // 매가계
         Tot_InvoiceAmt       = 0;    // INVOICE 금액         
         strInvoiceAmt        = strInvoiceUnitAmt    * strInvoiceQty;                      // 외화금액
         strInvoiceKorUnitAmt = getRoundDec(roundFlag, strInvoiceUnitAmt * strExcRate, 0); // 원화단가     
         strInvoiceKorAmt     = strInvoiceKorUnitAmt * strInvoiceQty;                      // 원화금액
         strSaleAmt           = strSalePrc           * strInvoiceQty;                      // 매가금액                              
         
         // 차익율, 차익액 구하기
         strGapRate = getCalcPord("GAP_RATE", strInvoiceKorAmt, strSaleAmt, "", strTaxFlag, roundFlag);
         totGapAmt  = DS_IO_DETAIL.Sum(22,0,0);    
         //totGapAmt  = getCalcPord("GAP_AMT",  strInvoiceKorAmt, strSaleAmt, "", strTaxFlag, roundFlag);
         
         // 계산값 셋팅
         DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INVOICE_KOR_UNIT_AMT") = strInvoiceKorUnitAmt; // 원화단가
         DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INVOICE_AMT")          = strInvoiceAmt;        // 외화금액
         DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "INVOICE_KOR_AMT")      = strInvoiceKorAmt;     // 원화금액
         DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SALE_AMT")             = strSaleAmt;           // 매가금액     
         DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAP_RATE")             = strGapRate;           // 차익율
         DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GAP_AMT")              = getCalcPord("GAP_AMT",  strInvoiceKorAmt, strSaleAmt, "", strTaxFlag, roundFlag);            // 차익액
     }else if(calFlag == 'M'){    // 마스터 변경시(환율)   
          for(var i=1; i<=DS_IO_DETAIL.CountRow; i++){  
             strInvoiceQty        = parseInt(DS_IO_DETAIL.NameValue(i, "INVOICE_QTY"));             // 수량
             strInvoiceUnitAmt    = parseInt(DS_IO_DETAIL.NameValue(i, "INVOICE_UNIT_AMT"));        // 외화단가
             strInvoiceKorUnitAmt = parseInt(DS_IO_DETAIL.NameValue(i, "INVOICE_KOR_UNIT_AMT"));    // 원화단가
             strInvoiceAmt        = parseInt(DS_IO_DETAIL.NameValue(i, "INVOICE_AMT"));             // 외화금액
             strInvoiceKorAmt     = parseInt(DS_IO_DETAIL.NameValue(i, "INVOICE_KOR_AMT"));         // 원화금액         
             strSalePrc           = parseInt(DS_IO_DETAIL.NameValue(i, "SALE_PRC"));                // 매가단가     
             strSaleAmt           = parseInt(DS_IO_DETAIL.NameValue(i, "SALE_AMT"));                // 매가금액     
             strGapRate           = parseInt(DS_IO_DETAIL.NameValue(i, "GAP_RATE"));                // 차익율                  
             strExcRate           = parseInt(EM_I_EXC_RATE.Text);                                   // 환율
             strInvoiceAmt        = parseInt(EM_I_INVOICE_AMT.Text);                                // INVOICE 금액
    
             Tot_QTY              = 0;    // 수량계
             Tot_NewCostAmt       = 0;    // 원가계
             Tot_NewSaleAmt       = 0;    // 매가계
             Tot_InvoiceAmt       = 0;    // INVOICE 금액             
             strInvoiceAmt        = strInvoiceUnitAmt    * strInvoiceQty;                      // 외화금액
             strInvoiceKorUnitAmt = getRoundDec(roundFlag, strInvoiceUnitAmt * strExcRate, 0); // 원화단가     
             strInvoiceKorAmt     = strInvoiceKorUnitAmt * strInvoiceQty;                      // 원화금액
             strSaleAmt           = strSalePrc           * strInvoiceQty;                      // 매가금엑          
             
             // 차익율, 차익액 구하기
             strGapRate = getCalcPord("GAP_RATE", strInvoiceKorAmt, strSaleAmt, "", strTaxFlag, roundFlag);
             totGapAmt  = DS_IO_DETAIL.Sum(22,0,0);    
             //totGapAmt  = getCalcPord("GAP_AMT",  strInvoiceKorAmt, strSaleAmt, "", strTaxFlag, roundFlag);                      
                          
             //계산값 셋팅
             DS_IO_DETAIL.NameValue(i, "INVOICE_KOR_UNIT_AMT") = strInvoiceKorUnitAmt; // 원화단가
             DS_IO_DETAIL.NameValue(i, "INVOICE_AMT")          = strInvoiceAmt;        // 외화금액
             DS_IO_DETAIL.NameValue(i, "INVOICE_KOR_AMT")      = strInvoiceKorAmt;     // 원화금액
             DS_IO_DETAIL.NameValue(i, "SALE_AMT")             = strSaleAmt;           // 매가금액     
             DS_IO_DETAIL.NameValue(i, "GAP_RATE")             = strGapRate;           // 차익율
             DS_IO_DETAIL.NameValue(i, "GAP_AMT")              = getCalcPord("GAP_AMT",  strInvoiceKorAmt, strSaleAmt, "", strTaxFlag, roundFlag);            // 차익액            
          } // 루프끝    
     }

    // 계산값 셋팅
    Tot_QTY                   = DS_IO_DETAIL.NameSum("INVOICE_QTY",0,0);     // 수량계       
    Tot_NewCostAmt            = DS_IO_DETAIL.NameSum("INVOICE_KOR_AMT",0,0); // 원가계   (원화금액) 확인해 볼 것!!!
    Tot_NewSaleAmt            = DS_IO_DETAIL.NameSum("SALE_AMT",0,0);        // 매가계   
    Tot_InvoiceAmt            = DS_IO_DETAIL.NameSum("INVOICE_AMT",0,0);     // INVOICE 금액       
    EM_I_INVOICE_TOT_QTY.Text = Tot_QTY;                                     // 수량계
    EM_I_INVOICE_TOT_AMT.Text = Tot_NewCostAmt;                              // 원가계
    EM_I_SALE_TOT_AMT.Text    = Tot_NewSaleAmt;                              // 매가계    
    EM_I_INVOICE_AMT.Text     = Tot_InvoiceAmt;                              // INVOICE 금액 
    
    
    //20110524 차익율 추가                  
    var totGapRate = getCalcPord("GAP_RATE", Tot_NewCostAmt, Tot_NewSaleAmt, "", strTaxFlag, roundFlag);
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAP_RATE") = totGapRate;    
    //EM_TOT_GAP_RATE.Text      = totGapRate;        // 차익율
    EM_TOT_GAP_AMT.Text       = DS_IO_DETAIL.NameSum("GAP_AMT",0,0);         // 차익액      

    alert("차익율 = " + totGapRate);
 }
  
  /**
  * clearObject()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-04-13
  * 개    요 :  OFFER_NO변경시 마스터 그리드 초기화
  * return값 : void
  */
  function clearObject(){
	  
      EM_O_OFFER_DT.Text      = "";
      EM_I_SLIP_NO.Text       = "";
      EM_O_SLIP_FLAG.Text     = "";
      EM_I_PUMBUN_CD.Text     = "";
      EM_O_PUMBUN_NM.Text     = "";
      EM_I_BUYER_CD.Text      = "";
      EM_O_BUYER_NM.Text      = "";
      EM_I_VEN_CD.Text        = "";
      EM_O_VEN_NM.Text        = "";
      EM_I_INVOICE_NO.Text    = "";
      EM_I_BL_NO.Text         = "";
      EM_I_SHIP_PORT.Text     = "";
      EM_I_ETD.Text           = "";
      EM_I_ETA.Text           = "";
      EM_I_LC_DATE.Text       = "";
      EM_I_LC_NO.Text         = "";
      EM_I_EXC_APP_DT.Text    = "";
      EM_I_EXC_RATE.Text      = 0;
      EM_I_ENTRY_DT.Text      = "";
      EM_I_IMPORT_NO.Text     = "";
      EM_I_PACKING_CHARGE.Text= "";
      EM_I_NCV.Text           = "";
      EM_I_INVOICE_AMT.Text   = "";
      EM_I_PRC_APP_DT.Text    = "";
      EM_I_DELI_DT.Text       = "";
      EM_I_CHK_DT.Text        = "";
      EM_I_INVOICE_TOT_QTY.Text = "";
      EM_I_INVOICE_TOT_AMT.Text = "";
      EM_I_SALE_TOT_AMT.Text  = "";
      EM_I_REMARK.Text        = "";
      EM_BIZ_TYPE.Text        = "";
      EM_TAX_FLAG.Text        = "";
      EM_SKU_FLAG.Text        = "";
      EM_BIZ_TYPE_NM.Text     = "";
      EM_TAX_FLAG_NM.Text     = "";
      EM_SKU_FLAG_NM.Text     = "";
      EM_TOT_GAP_AMT.Text     = "";
      EM_TOT_GAP_RATE.Text    = "";
      LC_I_IMPORT_COUNTRY.Text= "";
      LC_I_ARRI_PORT.Text     = "";
      LC_I_PRC_COND.Text      = "";
      LC_I_PAYMENT_COND.Text  = "";
      LC_I_PAYMENT_DTL_COND.Text = "";
      LC_I_CURRENCY_CD.Text   = "";      

      EM_I_INVOICE_DT.Text    = strToday;
      EM_I_PRC_APP_DT.Text    = strToday;
      EM_I_DELI_DT.Text       = strToday;
      EM_I_EXC_APP_DT.Text    = strToday;
      
 //     DS_IO_DETAIL.ClearData();
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

<script language=JavaScript for=TR_M_MAIN event=onSuccess>
    for(i=0;i<TR_M_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_M_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_S_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_M_MAIN event=onFail>
    trFailed(TR_M_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=DS_LIST event=CanRowPosChange(row)>

    if (DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated){
        if(showMessage(QUESTION, YESNO, "GAUCE-1000", "변경된 내역이 있습니다. <br> 이동 하시겠습니까?") != 1 ){
            return false;
        }else {
            if(DS_LIST.NameValue(row, "INVOICE_NO") == "")
                DS_LIST.DeleteRow(row);    
            
            DS_IO_MASTER.NameValue(row,"EM_I_INVOICE_AMT")      = DS_IO_MASTER.OrgNameValue(row,"EM_I_INVOICE_AMT");        //INVOICE 금액
            DS_IO_MASTER.NameValue(row,"EM_I_INVOICE_TOT_QTY")  = DS_IO_MASTER.OrgNameValue(row,"EM_I_INVOICE_TOT_QTY");    //수량계
            DS_IO_MASTER.NameValue(row,"EM_I_INVOICE_TOT_AMT")  = DS_IO_MASTER.OrgNameValue(row,"EM_I_INVOICE_TOT_AMT");    //원가계
            DS_IO_MASTER.NameValue(row,"EM_I_SALE_TOT_AMT")     = DS_IO_MASTER.OrgNameValue(row,"EM_I_SALE_TOT_AMT");       //매가계
            return true;
        }
    }else{
        return true;
    }
</script>

<script language=JavaScript for=DS_LIST event=onRowPosChanged(row)>
if(clickSORT)
    return;
    
    strGStyleType = DS_LIST.NameValue(row, "STYLE_TYPE");
    
	var strSlipProcStat = DS_LIST.NameValue(row, "SLIP_PROC_STAT");	
	if(strSlipProcStat == '00' || strSlipProcStat == '' ){         //전표상태가 전표입력상태일대만 수정가능

        GR_DETAIL.Editable  = true;
        setComponent(true);
	    GR_DETAIL.ColumnProp('CHECK1','EDIT')= "TRUE";
	    enableControl(IMG_ADD, true);
	    enableControl(IMG_DEL, true);
	}else{
        GR_DETAIL.Editable  = false;
	    setComponent(false);
	    GR_DETAIL.ColumnProp('CHECK1','EDIT')= "FALSE";
	    enableControl(IMG_ADD, false);
	    enableControl(IMG_DEL, false);
	}

    var strInvoiceNo = DS_LIST.NameValue(row, "INVOICE_NO");
    
	// 화면 로드시 입력 컴퍼넌트 비활성화	
    // checkValidation(false);
	
	LC_I_STR_CD.Enable   = false;
	EM_I_OFFER_NO.Enable = false;
	
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        
        if(DS_LIST.RowStatus(row)==1){
            EM_I_INVOICE_DT.Text = strToday;
            EM_I_PRC_APP_DT.Text = strToday;
            EM_I_DELI_DT.Text    = strToday;
            return;
        }else{
        	getMaster();
            getDetail(); 
        	if(strInvoiceNo != ""){
	        	if(inta == 0){  
	                inta++;
	            }else{
	                setPorcCount("SELECT", DS_IO_DETAIL.CountRow);      
	            }     
        	}                    
            strGSkuType   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SKU_TYPE");
            strGBizType   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_TYPE");
            strGStyleType = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STYLE_TYPE");         
        }
    }
    
    // 단품구분
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SKU_TYPE")=='1'){        //규격단품
        GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = false;
        GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
        GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false; 
        
    }else if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SKU_TYPE")=='2'){  //신선단품
        GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = false;
        GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
        GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;  
        
    }else if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SKU_TYPE")=='3'){  //의류단품
    	if(DS_LIST.NameValue(DS_LIST.RowPosition, "STYLE_TYPE") == '1'){
            GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = true;
            GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = true;
            GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = true;    
    	}else{
            GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = true;
            GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
            GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;    
    	}    
    }
    
    // 마스터의 구분값들을 전역변수에 셋팅
    strGSkuType   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SKU_TYPE");
    strGBizType   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_TYPE");
    strGStyleType = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STYLE_TYPE");    
    searchFlag      = false;
    
</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
</script>

<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>
</script>

<!--  ===================GR_MASTER============================ -->
<!-- Grid Master oneClick event 처리 -->

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

<!--  DS_IO_MASTER 변경시 -->
<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
/*
    if(DS_IO_MASTER.IsUpdated){
        if(colid == "PUMBUN_CD"){
            DS_IO_DETAIL.ClearData();
        }
    }  
*/
    switch (colid) {
    case "PUMBUN_CD":
        if(EM_I_PUMBUN_CD.Text == ""){
            EM_O_PUMBUN_NM.Text    = "";
            EM_I_BUYER_CD.Text     = "";
            EM_O_BUYER_NM.Text     = "";
            EM_I_VEN_CD.Text       = "";
            EM_O_VEN_NM.Text       = "";
            EM_BIZ_TYPE.Text       = "";
            EM_BIZ_TYPE_NM.Text    = "";
            EM_TAX_FLAG.Text       = "";
            EM_TAX_FLAG_NM.Text    = "";
            EM_SKU_FLAG.Text       = "";
            EM_SKU_FLAG_NM.Text    = "";
        }else if(EM_I_PUMBUN_CD.Text.length == 6){
            getPumbunInfo("0");
        }
        DS_IO_DETAIL.ClearData();
        break; 
    case "VEN_CD":
        if(EM_I_VEN_CD.Text.length == 6){
            var strStrCd           = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");        // 점
            var strVenCd           = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");        // 협력사      
            roundFlag = getVenRoundFlag('DS_O_RESULT', strToday, strStrCd, strVenCd);                   // 반올림구분 가져옴
//            alert("반올림구분 = " + roundFlag);
        }else{
            EM_O_VEN_NM.Text       = "";            
        }
        break;  
    case "EXC_RATE":       
        setCalc('M');
        break;    
        
/*      
    case "OFFER_SHEET_NO":                         //OFFER_NO
        if(EM_I_OFFER_NO.Text.length == 0){
            DS_IO_MASTER.Deleterow(row);
            DS_IO_MASTER.Addrow();
            LC_I_STR_CD.Index      = 0;
            checkValidation(false);
        }
        else{
            //화면 로드시 입력 컴퍼넌트 비활성화
            checkValidation(true);
        }
        break;  
*/       
    
    }    
    
/*
    if(strNpDt > strMgDt){
        showMessage(EXCLAMATION, OK, "USER-1020", "마진적용일","납품예정일");
        EM_I_MAJINDATE.Text = EM_I_NPYJDATE.Text  
        if(EM_I_MAJINDATE.Text.length == 8 && EM_I_PB_CD.Text != ''){
            LC_I_HS_GBN.Enable = true;
            getMarginFlag();         
        }       
    }
*/
</script>

<!-- Grid GR_DETAIL oneClick event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);    
</script>

 <!--  ===================DS_IO_DETAIL============================ -->
<!-- GR_DETAIL OnPopup event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnPopup(row,colid,data)>
/*
    var strOrderNo = DS_IO_DETAIL.NameValue(row,"ORDER_NO")    
    if(colid == "SKU_CD"){
        getSkuPop(row, colid);
    }
*/    
    switch(colid){
    case "SKU_CD":
        if( strGSkuType == '1'){                    //단품종류가 규격단품이면
            getSkuPop(row, colid, '1');             //규격단품 팝업띄우는 함수
        }else if( strGSkuType == '3'){
        //  alert("의류단품인가");
            getABSkuPop(row, colid);
        }else if( strGSkuType == '2'){   
//        	showMessage(EXCLAMATION, OK, "GAUCE-1000", "신선단품은 등록할 수 없습니다."); 
            getSkuPop(row, colid, '1');             //신선단품 팝업띄우는 함수
            return;
        }
        break;
    }
</script>

<script language=JavaScript for=DS_IO_DETAIL event=onRowPosChanged(row)>

if(clickSORT)
    return;

</script>
<!--  DS_IO_DETAIL 변경시 -->
<script language=JavaScript for=DS_IO_DETAIL event=OnColumnChanged(row,colid)>
    //그리드 삭제시 마스터 내용 변경위함 ( 수량계 원가계 매가계)
//    setCalc('D');
    
    switch (colid) {
    case "SKU_CD":
        if(DS_IO_DETAIL.NameValue(row, "SKU_CD") == "")
            return;
        /*    	
        getSkuInfo('D', DS_IO_DETAIL.NameValue(row, colid));
        setTimeout("getOffSkuInfo()",50);
        */
        getOffSkuInfo(row);
        break; 
    case "INVOICE_UNIT_AMT":    //외화단가 변경시
        setCalc('D');    //원화단가 외화금액 원화금액 차익율을 계산한다.
        break; 
    case "SALE_PRC":            //원화단가 변경시
        setCalc('D');    //원화단가 외화금액 원화금액 차익율을 계산한다.
        break;   
    case "INVOICE_QTY":            //원화단가 변경시
        setCalc('D');    //원화단가 외화금액 원화금액 차익율을 계산한다.
        break;      
    }
</script>

<!-- 디테일 삭제시 컴퍼넌트 총금액-->
<script language=JavaScript for=DS_IO_DETAIL event=OnRowDeleted(row)> 
//그리드 삭제시 마스터 내용 변경위함 ( 수량계 원가계 매가계)
    setCalc('D');
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

<!-- 입력부 OFFER_NO KillFocus -->
<script language=JavaScript for=EM_I_OFFER_NO event=onKillFocus()>
    if(!this.Modified){
        return;
    }
    DS_IO_DETAIL.ClearData();
    if(EM_I_OFFER_NO.Text != ""){
        if(getOfferNo()){
            return;         
        }else{
            clearObject();
            showMessage(EXCLAMATION, OK, "USER-1036", "OFFER NO");
            EM_I_OFFER_NO.Text = "";
//            getOfferNoPopup();
            setTimeout( "EM_I_OFFER_NO.Focus()",50);
            return;
        }
    }else if(EM_I_OFFER_NO.Text.length == 0){
        clearObject();
        return;
    }else{
        clearObject();
        getOfferNoPopup();
        return;
    }
</script>

<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
    EM_S_PUMBUN_CD.Text    = "";
    EM_S_PUMBUN_NM.Text    = "";    
    EM_S_VEN_CD.Text       = "";
    EM_S_VEN_NM.Text       = "";    
//    EM_S_INVOICE_NO.Text   = "";
//    EM_S_OFFER_NO.Text     = "";
</script>

<!-- 조회시작일 변경시  -->
<script lanaguage=JavaScript for=EM_S_S_INVOICE_DT event=OnKillFocus()>
//    checkDateTypeYMD( EM_S_S_INVOICE_DT );
    
    var strSyyyymmdd = strToday.substring(0,6) + "01";
    checkDateTypeYMD( EM_S_S_INVOICE_DT, strSyyyymmdd );
</script>

<!-- 조회종료일 변경시  -->
<script lanaguage=JavaScript for=EM_S_E_INVOICE_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_S_E_INVOICE_DT );
</script>

<!-- 점(입력)  변경시  -->
<script language=JavaScript for=LC_I_STR_CD event=OnSelChange()>
    clearObject();
    EM_I_OFFER_NO.Text = "";
</script>

<!-- ETD(출발일)  -->
<script lanaguage=JavaScript for=EM_I_ETD event=OnKillFocus()>
    checkDateTypeYMD( EM_I_ETD );
</script>

<!-- ETA(도착일)  -->
<script lanaguage=JavaScript for=EM_I_ETA event=OnKillFocus()>
    checkDateTypeYMD( EM_I_ETA );
</script>

<!-- L/C DATE 변경시  -->
<script lanaguage=JavaScript for=EM_I_LC_DATE event=OnKillFocus()>
    checkDateTypeYMD( EM_I_LC_DATE );
</script>

<!-- 환율적용일 변경시  -->
<script lanaguage=JavaScript for=EM_I_EXC_APP_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_I_EXC_APP_DT );
</script>
    
<!-- 통관예정일  -->
<script lanaguage=JavaScript for=EM_I_ENTRY_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_I_ENTRY_DT );

    var strNextDay = addDate("d", 1, strToday);
    if(EM_I_ENTRY_DT.Text <= strToday){    	
        EM_I_DELI_DT.Text    = strNextDay;
        EM_I_PRC_APP_DT.Text = strNextDay;
        
    }else{
        EM_I_DELI_DT.Text    = EM_I_ENTRY_DT.Text;
        EM_I_PRC_APP_DT.Text = EM_I_ENTRY_DT.Text;    	
    }    
</script>

<!-- 납품예정일  -->
<script lanaguage=JavaScript for=EM_I_DELI_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_I_DELI_DT );
    
    var strNextDay = addDate("d", 1, strToday);
    

    if(EM_I_DELI_DT.Text < strToday){ 
    	if(EM_I_ENTRY_DT.Text < strToday){    		
            showMessage(EXCLAMATION, OK, "USER-1020", "납품예정일","금일");
            EM_I_DELI_DT.Text = strNextDay;
            setTimeout( "EM_I_DELI_DT.Focus()",50);   
            
    	}else{
            showMessage(EXCLAMATION, OK, "USER-1020", "납품예정일","통관예정일");
            EM_I_DELI_DT.Text = EM_I_ENTRY_DT.Text;
            setTimeout( "EM_I_DELI_DT.Focus()",50);   
    	}
        
    }else{
        if(EM_I_DELI_DT.Text < EM_I_ENTRY_DT.Text){  
            showMessage(EXCLAMATION, OK, "USER-1020", "납품예정일","통관예정일");
            EM_I_DELI_DT.Text = EM_I_ENTRY_DT.Text;
            setTimeout( "EM_I_DELI_DT.Focus()",50);
        }  	
    }
</script>

<!-- 가격적용일  -->
<script lanaguage=JavaScript for=EM_I_PRC_APP_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_I_PRC_APP_DT );
    
    var strNextDay = addDate("d", 1, strToday);
    if(EM_I_PRC_APP_DT.Text < EM_I_DELI_DT.Text){
        showMessage(EXCLAMATION, OK, "USER-1020", "가격적용일","납품예정일");
        EM_I_PRC_APP_DT.Text = EM_I_DELI_DT.Text;
        setTimeout( "EM_I_PRC_APP_DT.Focus()",50);
    }
</script>  

<!-- 검품확정일  -->
<script lanaguage=JavaScript for=EM_I_CHK_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_I_CHK_DT );
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
/*
    // 입력부 팝업 사용안함
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
*/    
</script>

<!-- 신입력부 협력사 KillFocus -->
<script language=JavaScript for=EM_I_VEN_CD event=onKillFocus()>
/*
    if(EM_I_VEN_CD.Text != ""){
        setVenNonInfo(EM_I_VEN_CD, EM_O_VEN_NM);
    }else
        EM_O_VEN_NM.Text = "";  
*/
</script>

<!-- 환율 KillFocus -->
<script language=JavaScript for=EM_I_EXC_RATE event=onKillFocus()>  
    if(EM_I_EXC_RATE.Text == ""){
    	EM_I_EXC_RATE.Text = 0;
    }                                                                           // 환율
</script>

<!--  INVOICE_NO KillFocus -->
<script language=JavaScript for=EM_I_INVOICE_NO event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "INVOICE_NO", "INVOICE_NO", "EM_I_INVOICE_NO");  // INVOICE_NO
	if(!checkInvoiceNo()){	
	    setTimeout( "EM_I_INVOICE_NO.Focus()",50);
	    return;
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

<!--  BL_NO KillFocus -->
<script language=JavaScript for=EM_I_BL_NO event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "BL_NO", "BL_NO", "EM_I_BL_NO");  //BL_NO
</script>

<!--  수입신고번호 KillFocus -->
<script language=JavaScript for=EM_I_IMPORT_NO event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "IMPORT_NO", "수입신고번호", "EM_I_IMPORT_NO");  //수입신고번호 
</script>

<!--  전표번호 KillFocus -->
<script language=JavaScript for=EM_I_SLIP_NO event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "SLIP_NO", "전표번호", "EM_I_SLIP_NO");  //전표번호 
</script>

<!--  비고 KillFocus -->
<script language=JavaScript for=EM_I_REMARK event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "REMARK", "비고", "EM_I_REMARK");  //비고
</script>

<!-- 걸제조건  변경시  -->
<script language=JavaScript for=LC_I_PAYMENT_COND event=OnSelChange()>

	strGStyleType = DS_LIST.NameValue(DS_LIST.RowPosition, "STYLE_TYPE");
	
	var strSlipProcStat = DS_LIST.NameValue(DS_LIST.RowPosition, "SLIP_PROC_STAT"); 
	if(strSlipProcStat == '00' || strSlipProcStat == '' ){         //전표상태가 전표입력상태일대만 수정가능

	    if(LC_I_PAYMENT_COND.BindColVal == "002"){
	        LC_I_PAYMENT_DTL_COND.Enable = true;
	        
	    }else{
	        LC_I_PAYMENT_DTL_COND.index = 0;
	        LC_I_PAYMENT_DTL_COND.Enable = false;
	    }
	}else{
        LC_I_PAYMENT_DTL_COND.Enable = false;
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
<comment id="_NSID_"><object id="DS_ORD_UNIT_CD"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_BIZ_TYPE"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TAX_FLAG"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SKU_FLAG"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_PROC_STAT"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SKU_INFO"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TAX_FLAG"           classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_OFFER_INFO"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_INVOICE_INFO"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_INVOICE_STAT"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
                    <td width="300">
                         <comment id="_NSID_">
                            <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=100 align="absmiddle" tabindex=1 >
                            </object>
                        </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point" width="75">INVOICE 기간</th>
                    <td>
                        <comment id="_NSID_">
                              <object id=EM_S_S_INVOICE_DT classid=<%=Util.CLSID_EMEDIT%>  width=119 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_S_INVOICE_DT)" align="absmiddle"/>
                        ~
                        <comment id="_NSID_">
                              <object id=EM_S_E_INVOICE_DT classid=<%=Util.CLSID_EMEDIT%>  width=119 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_E_INVOICE_DT)" align="absmiddle"/>
                    </td>
                  </tr>
                   
                  <tr>
                    <th>INVOICE NO</th>
                    <td>
                        <comment id="_NSID_">
                              <object id=EM_S_INVOICE_NO classid=<%=Util.CLSID_EMEDIT%>  width=295 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                    </td>
                    <th>OFFER NO</th>
                    <td>
                        <comment id="_NSID_">
                              <object id=EM_S_OFFER_NO classid=<%=Util.CLSID_EMEDIT%>  width=295 tabindex=1 align="absmiddle">
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
                
                  <tr>
                    <th>전표번호</th>
                    <td colspan="3">
                        <comment id="_NSID_">
                              <object id=EM_S_SLIP_NO classid=<%=Util.CLSID_EMEDIT%>  width=100 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
  <!-- -->                  
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
                            <OBJECT id=GR_MASTER width=100% height=431 classid=<%=Util.CLSID_GRID%>>
                                <param name="DataID" value="DS_LIST">
                            </OBJECT>
                        </comment><script>_ws_(_NSID_);</script>
                   </td>
                </tr>
             </table>
        </td>
       <td class="PL10">
       <div style="width:100%; height:434px; overflow: auto">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="PT01 PB03">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0"
                            class="s_table">
                    
                            
                <tr>
                  <th class="point" width="80">점</th>
                  <td width="95">
                         <comment id="_NSID_">
                            <object id=LC_I_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=90 align="absmiddle" tabindex=1>
                            </object>
                        </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th width="73">전표번호</th>
                  <td width="105">
                      <comment id="_NSID_">
                            <object id=EM_I_SLIP_NO classid=<%=Util.CLSID_EMEDIT%>  width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th width="80">전표상태</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_O_SLIP_FLAG classid=<%=Util.CLSID_EMEDIT%>  width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th class="point" width="80">OFFER NO</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                            <object id=EM_I_OFFER_NO classid=<%=Util.CLSID_EMEDIT%>  width=269 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_OFFER_NO" class="PR03" align="absmiddle" onclick="javascript:getOfferNoPopup();" />
                  </td>
                  <th>OFFER 일자</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_O_OFFER_DT classid=<%=Util.CLSID_EMEDIT%>  width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>  
                
                <tr>
                  <th>브랜드</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                            <object id=EM_I_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
<!--                       
                      <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_PUMBUN_CD" class="PR03" align="absmiddle" onclick="javascript:getInputPumbunInfo();" />
 -->                 
                      &nbsp;<comment id="_NSID_">
                            <object id=EM_O_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%>  width=193 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>바이어</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_BUYER_CD classid=<%=Util.CLSID_EMEDIT%>  width=45 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                            <object id=EM_O_BUYER_NM classid=<%=Util.CLSID_EMEDIT%>  width=50 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                 
                <tr>
                  <th>거래형태</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_BIZ_TYPE_NM classid=<%=Util.CLSID_EMEDIT%>  width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>과세구분</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_TAX_FLAG_NM classid=<%=Util.CLSID_EMEDIT%>  width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>단품종류</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_SKU_FLAG_NM classid=<%=Util.CLSID_EMEDIT%>  width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>  
               
                <tr>
                  <th>협력사</th>
                  <td colspan="5">
                      <comment id="_NSID_">
                            <object id=EM_I_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
<!--                       
                      <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VEN_CD" class="PR03" align="absmiddle" onclick="javascript:getInputVenInfo(EM_I_VEN_CD,EM_O_VEN_NM);" />
 -->             
                      &nbsp;<comment id="_NSID_">
                            <object id=EM_O_VEN_NM classid=<%=Util.CLSID_EMEDIT%>  width=193 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                 
                <tr>
                  <th class="point">INVOICE</BR>일자</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_INVOICE_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_INVOICE_DT onclick="javascript:openCal('G',EM_I_INVOICE_DT)" align="absmiddle"/>
                  </td>
                  <th class="point">INVOICE NO</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_INVOICE_NO classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>B/L NO</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_BL_NO classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>  
                </tr>
                
                <tr>
                  <th>수입국가</th>
                  <td>
                      <comment id="_NSID_">
                         <object id=LC_I_IMPORT_COUNTRY classid=<%= Util.CLSID_LUXECOMBO%> width=90 align="absmiddle" tabindex=1 >
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th>선적항</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                            <object id=EM_I_SHIP_PORT classid=<%=Util.CLSID_EMEDIT%> width=306 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>도착항</th>
                  <td>
                      <comment id="_NSID_">
                         <object id=LC_I_ARRI_PORT classid=<%= Util.CLSID_LUXECOMBO%> width=90 align="absmiddle" tabindex=1 >
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th>선적일</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_ETD classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_ETD onclick="javascript:openCal('G',EM_I_ETD)" align="absmiddle"/>
                  </td>
                  <th>도착일</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_ETA classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_ETA onclick="javascript:openCal('G',EM_I_ETA)" align="absmiddle"/>
                  </td>
                </tr>
                
                <tr>
                  <th>L/C DATE</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_LC_DATE classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_LC_DATE onclick="javascript:openCal('G',EM_I_LC_DATE)" align="absmiddle"/>
                  </td>
                  <th>L/C NO</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                            <object id=EM_I_LC_NO classid=<%=Util.CLSID_EMEDIT%> width=306 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th>가격조건</th>
                  <td>
                      <comment id="_NSID_">
                         <object id=LC_I_PRC_COND classid=<%= Util.CLSID_LUXECOMBO %> width=90 align="absmiddle" tabindex=1 >
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th>결제조건</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                         <object id=LC_I_PAYMENT_COND classid=<%= Util.CLSID_LUXECOMBO%> width=203 align="absmiddle" tabindex=1 >
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                      <comment id="_NSID_">
                         <object id=LC_I_PAYMENT_DTL_COND classid=<%= Util.CLSID_LUXECOMBO%> width=102 align="absmiddle" tabindex=1 >
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                                   
                <tr>
                  <th class="point">화폐단위</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=LC_I_CURRENCY_CD classid=<%=Util.CLSID_LUXECOMBO%> width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th class="point">환율적용일</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_EXC_APP_DT classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_EXC_APP_DT onclick="javascript:openCal('G',EM_I_EXC_APP_DT)" align="absmiddle"/>
                  </td>
                  <th class="point">환율</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_EXC_RATE classid=<%=Util.CLSID_EMEDIT%>  width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                </tr>
                
                <tr>
                  <th>통관예정일</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_ENTRY_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_ENTRY_DT onclick="javascript:openCal('G',EM_I_ENTRY_DT)" align="absmiddle"/>
                  </td>
                  <th>수입신고번호</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                            <object id=EM_I_IMPORT_NO classid=<%=Util.CLSID_EMEDIT%> width=306 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                 
                <tr>                  
                  <th>Packing</br>Charge</th>
                  <td>
                      <comment id="_NSID_">
                         <object id=EM_I_PACKING_CHARGE classid=<%= Util.CLSID_EMEDIT%> width=90 align="absmiddle" tabindex=1 >
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th>N.C.V</th>
                  <td>
                      <comment id="_NSID_">
                         <object id=EM_I_NCV classid=<%= Util.CLSID_EMEDIT%> width=100 align="absmiddle" tabindex=1 >
                         </object>
                     </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th>INVOICE 금액</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_INVOICE_AMT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
                
                <tr>
                  <th class="point">납품예정일</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_DELI_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_DELI_DT onclick="javascript:openCal('G',EM_I_DELI_DT)" align="absmiddle"/>
                  </td> 
                  <th class="point">가격적용일</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_PRC_APP_DT classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_PRC_APP_DT onclick="javascript:openCal('G',EM_I_PRC_APP_DT)" align="absmiddle"/>
                  </td> 
                  <th>검품확정일</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_CHK_DT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>                 
                </tr>
               
                <tr>
                  <th>수량계</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_INVOICE_TOT_QTY classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>원가계</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_INVOICE_TOT_AMT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th>매가계</th>
                  <td>
                      <comment id="_NSID_">
                            <object id=EM_I_SALE_TOT_AMT classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                            </object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>                
                </tr>
                
                <tr>
                  <th>비고</th>
                  <td colspan="5">
                    <comment id="_NSID_">
                        <object id=EM_I_REMARK classid=<%= Util.CLSID_EMEDIT %> width=495 align="absmiddle" tabindex=1 >
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
                                    <OBJECT id=GR_DETAIL width=100% height=165 classid=<%=Util.CLSID_GRID%>>
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

<comment id="_NSID_"> 
    <object id=EM_BIZ_TYPE classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>

<comment id="_NSID_"> 
    <object id=EM_TAX_FLAG classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>

<comment id="_NSID_"> 
    <object id=EM_SKU_FLAG classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>

<comment id="_NSID_"> 
    <object id=EM_TOT_GAP_AMT classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>

<comment id="_NSID_"> 
    <object id=EM_TOT_GAP_RATE classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>

 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

<comment id="_NSID_">
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER>
        <param name="ActiveBind"    value=true>
	<param name=BindInfo
		value='
 
        <c>Col=PUMBUN_CD            Ctrl=EM_I_PUMBUN_CD             param=Text</c>         
        <c>Col=PUMBUN_NAME          Ctrl=EM_O_PUMBUN_NM             param=Text</c>        
        <c>Col=BUYER_CD             Ctrl=EM_I_BUYER_CD              param=Text</c> 
        <c>Col=BUYER_NM             Ctrl=EM_O_BUYER_NM              param=Text</c> 
        <c>Col=VEN_CD               Ctrl=EM_I_VEN_CD                param=Text</c> 
        <c>Col=VEN_NAME             Ctrl=EM_O_VEN_NM                param=Text</c> 
        <c>Col=SKU_TYPE_NM          Ctrl=EM_SKU_FLAG_NM             param=Text</c> 
        <c>Col=BIZ_TYPE_NM          Ctrl=EM_BIZ_TYPE_NM             param=Text</c> 
        <c>Col=TAX_FLAG             Ctrl=EM_TAX_FLAG                param=Text</c> 
        <c>Col=TAX_FLAG_NM          Ctrl=EM_TAX_FLAG_NM             param=Text</c>         
        <c>Col=OFFER_SHEET_NO       Ctrl=EM_I_OFFER_NO              param=Text</c> 
        <c>Col=SLIP_NO              Ctrl=EM_I_SLIP_NO               param=Text</c> 
        <c>Col=OFFER_DT             Ctrl=EM_O_OFFER_DT              param=Text</c>   
        <c>Col=INVOICE_DT           Ctrl=EM_I_INVOICE_DT            param=Text</c> 
        <c>Col=INVOICE_NO           Ctrl=EM_I_INVOICE_NO            param=Text</c>   
        <c>Col=BL_NO                Ctrl=EM_I_BL_NO                 param=Text</c> 
        <c>Col=SHIP_PORT            Ctrl=EM_I_SHIP_PORT             param=Text</c>   
        <c>Col=ETD                  Ctrl=EM_I_ETD                   param=Text</c> 
        <c>Col=ETA                  Ctrl=EM_I_ETA                   param=Text</c>   
        <c>Col=LC_DATE              Ctrl=EM_I_LC_DATE               param=Text</c> 
        <c>Col=LC_NO                Ctrl=EM_I_LC_NO                 param=Text</c>   
        <c>Col=EXC_APP_DT           Ctrl=EM_I_EXC_APP_DT            param=Text</c> 
        <c>Col=EXC_RATE             Ctrl=EM_I_EXC_RATE              param=Text</c>   
        <c>Col=ENTRY_DT             Ctrl=EM_I_ENTRY_DT              param=Text</c> 
        <c>Col=IMPORT_NO            Ctrl=EM_I_IMPORT_NO             param=Text</c>   
        <c>Col=PACKING_CHARGE       Ctrl=EM_I_PACKING_CHARGE        param=Text</c> 
        <c>Col=NCV                  Ctrl=EM_I_NCV                   param=Text</c>   
        <c>Col=INVOICE_TOT_AMT      Ctrl=EM_I_INVOICE_AMT           param=Text</c> 
        <c>Col=PRC_APP_DT           Ctrl=EM_I_PRC_APP_DT            param=Text</c>   
        <c>Col=DELI_DT              Ctrl=EM_I_DELI_DT               param=Text</c>   
        <c>Col=CHK_DT               Ctrl=EM_I_CHK_DT                param=Text</c>   
        <c>Col=INVOICE_TOT_QTY      Ctrl=EM_I_INVOICE_TOT_QTY       param=Text</c>   
        <c>Col=INVOICE_WON_TOT_AMT  Ctrl=EM_I_INVOICE_TOT_AMT       param=Text</c> 
        <c>Col=SALE_TOT_AMT         Ctrl=EM_I_SALE_TOT_AMT          param=Text</c>     
        <c>Col=REMARK               Ctrl=EM_I_REMARK                param=Text</c>     
        <c>Col=GAP_RATE             Ctrl=EM_TOT_GAP_RATE            param=Text</c>     
        <c>Col=GAP_TOT_AMT          Ctrl=EM_TOT_GAP_AMT             param=Text</c>  
        <c>Col=SLIP_PROC_STAT_NM    Ctrl=EM_O_SLIP_FLAG             param=Text</c>     
                
        <c>Col=STR_CD               Ctrl=LC_I_STR_CD                param=BindColVal</c> 
        <c>Col=IMPORT_COUNTRY       Ctrl=LC_I_IMPORT_COUNTRY        param=BindColVal</c> 
        <c>Col=ARRI_PORT            Ctrl=LC_I_ARRI_PORT             param=BindColVal</c> 
        <c>Col=PRC_COND             Ctrl=LC_I_PRC_COND              param=BindColVal</c> 
        <c>Col=PAYMENT_COND         Ctrl=LC_I_PAYMENT_COND          param=BindColVal</c> 
        <c>Col=PAYMENT_DTL_COND     Ctrl=LC_I_PAYMENT_DTL_COND      param=BindColVal</c> 
        <c>Col=CURRENCY_CD          Ctrl=LC_I_CURRENCY_CD           param=BindColVal</c> 
        
        
        '>
</object>
</comment><script>_ws_(_NSID_);</script>

<body>
</html>

