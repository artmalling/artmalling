<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품 지급/취소 > 사은품지급등록
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : MCAE4010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.18 (김슬기) 신규작성
 *        2011.03.04 (김성미) 프로그램 작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

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
<script language="javascript" src="/<%=dir%>/js/common.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"><!--


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var strUserID = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
 var strUserNM = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />';
 var strToday    ="";
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    // Input Data Set Header 초기화
    DS_IO_SALE_INFO.setDataHeader('<gauce:dataset name="H_SALE_INFO"/>');
    DS_IO_SALE_INFO_TEMP.setDataHeader('<gauce:dataset name="H_SALE_INFO"/>');
    DS_IO_SALE_INFO_TEMP2.setDataHeader('<gauce:dataset name="H_SALE_INFO"/>');
    DS_O_SKU_INFO.setDataHeader('<gauce:dataset name="H_SKU_LIST"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
   gridCreate2();
    
    // EMedit에 초기화
    initEmEdit(EM_PRSNT_DT, "TODAY", READ);    //등록일자
    initEmEdit(EM_PRSNT_CHAR_NM, "GEN", READ);         //등록자
    initEmEdit(EM_STR_NM, "GEN", READ);     //점
    initEmEdit(EM_EVENT_CD, "GEN", READ);     //행사코드
    initEmEdit(EM_EVENT_NAME, "GEN", READ);     //행사명
    initEmEdit(EM_EVENT_TYPE_NM, "GEN", READ);     //사은행사유형
    initEmEdit(EM_EVENT_S_DT, "YYYYMMDD", READ);//행사기간 S
    initEmEdit(EM_EVENT_E_DT, "YYYYMMDD", READ);//행사기간 E
    initEmEdit(EM_RECEIPT_NO, "GEN^24", NORMAL);    //영수증번호
    initEmEdit(EM_CARD_CUST_ID, "GEN^16", NORMAL);    //고객카드번호
    initEmEdit(EM_CONF_ID, "GEN", PK);    //승인자코드
    initEmEdit(EM_CONF_NM, "GEN", READ);    //승인자명
    initEmEdit(EM_SKU_CD, "GEN", PK);    //지급품코드
    initEmEdit(EM_SKU_NM, "GEN", READ);    //지급품명
    
    initEmEdit(EM_SLAE_AMT_SUM, "NUMBER^12^0", READ);    //총인정금액

    //콤보 초기화
    initComboStyle(LC_STR,DS_O_STR, "CODE^0^30,NAME^0^80", 1, PK);      //점
    initComboStyle(LC_EVENT,DS_O_EVENT_COMBO, "CODE^0^30,NAME^0^120", 1, PK);       // 행사코드
    initComboStyle(LC_EXCP_PRSNT_RSN,DS_O_EXCP_PRSNT_RSN, "CODE^0^30,NAME^0^80", 1, PK);      //예외지급사유코드
    //그리드 초기화
    gridCreate1(); // 영수증 정보
    getEtcCode("DS_O_EXCP_PRSNT_RSN",   "D", "M073", "N");
    getStore("DS_O_STR", "Y", "1", "N"); 
    LC_STR.Index = 0;
    EM_PRSNT_CHAR_NM.Text = strUserNM;
    EM_SLAE_AMT_SUM.Text = 0;
    chkExcp(true);
    strToday = getTodayDB("DS_O_RESULT");
    // 테스트 구간
   // strToday = "20110801";
    // 테스트 구간
 
    EM_PRSNT_DT.Text = strToday;
   
    setTimeout("EM_RECEIPT_NO.Focus()",50);
}


function gridCreate1(){
    var hdrProperies ='<FC>id={currow}    name="NO"         width=30   align=center</FC>'
			        + '<FC>id=CHK      name=""           width=20   align=center  Edit={IF(PROVIDE_GB="0","true","false")}    EditStyle=CheckBox  HeadCheckShow="true" </FC>'
			        + '<FC>id=TRAN_NO    name="영수증번호" sumtext="합계"    edit=none   width=80  align=left</FC>'
                    + '<FC>id=SALE_DT    name="판매일자"   edit=none  mask="XXXX/XX/XX"  width=80  align=center</FC>'
                    + '<FC>id=TOT_SALE_AMT    name="매출금액" sumtext=@sum  edit=none    width=80  align=right</FC>'
                    + '<FC>id=SALE_AMT    name="인정금액"   sumtext=@sum edit=none   width=80  align=right</FC>'
                    + '<FC>id=DIV_AMT    name="지급안분금액" sumtext=@sum   edit=none   width=80  align=right</FC>'
                    + '<FC>id=PROVIDE_GB_NM    name="지급여부"   edit=none    width=60  align=left</FC>';
                     
    initGridStyle(GD_SALE_INFO, "common", hdrProperies, true);
}

function gridCreate2(){
    var hdrProperies2 ='<FC>id={currow}    name="NO"         width=30   align=center</FC>'
			        + '<FC>id=CHK      name=""     width=30   align=center    EditStyle=CheckBox  HeadCheckShow="false" </FC>'
			        + '<FC>id=TRG_NAME    name="대상범위"   edit=none    width=70  align=left</FC>'
			        + '<FC>id=SKU_NAME    name="지급품명"  edit=none   width=70   align=left</FC>'
			        + '<FC>id=BUY_COST_PRC    name="매입원가"   edit=none    width=90  align=right</FC>';
                     
    initGridStyle(GD_SKU_LIST, "common", hdrProperies2, true);
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
}

/**
 * btn_New()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-03-08
 * 개    요 :영수증정보, 지급품정보 예외지급정보 초기화
 * return값 : void
 */
function btn_New(flag) {
	 
	// 지급품 정보 수정 내용 체크
     if(DS_IO_SALE_INFO.IsUpdated &&
             showMessage(QUESTION , YESNO, "GAUCE-1000", "영수증 정보가 변경되었습니다. 신규등록을 하시겠습니까") != 1){
         return;
     }
	EM_RECEIPT_NO.Text = "";
	EM_CARD_CUST_ID.Text = "";
	EM_CONF_ID.Text = "";
	EM_CONF_NM.Text = "";
	EM_SKU_CD.Text = "";
	EM_SKU_NM.Text = "";
	IMG_SKU_CD.Text = "";
	IMG_CONF_ID.Text = "";
	LC_EXCP_PRSNT_RSN.BindColVal = "";
	CHK_EXCP.checked = false;
	
	DS_IO_SALE_INFO_TEMP2.ClearData();
	if(flag == "S"){
		var strData = DS_IO_SALE_INFO.ExportData(1,DS_IO_SALE_INFO.CountRow, true);
		DS_IO_SALE_INFO_TEMP2.ImportData(strData);
		// 지급된 영수증만 삭제 
        for(var i=1;i<=DS_IO_SALE_INFO_TEMP2.CountRow;i++){
            if(DS_IO_SALE_INFO_TEMP2.NameValue(i,"CHK") == "T" || DS_IO_SALE_INFO_TEMP2.NameValue(i,"PROVIDE_GB") != "0" ){
            	DS_IO_SALE_INFO_TEMP2.DeleteRow(i);
                i -= 1;
            }
        }
		
        DS_IO_SALE_INFO.ClearData();
		if(DS_IO_SALE_INFO_TEMP2.CountRow > 0){
			var strData1 = DS_IO_SALE_INFO_TEMP2.ExportData(1,DS_IO_SALE_INFO_TEMP2.CountRow, true);
			DS_IO_SALE_INFO.ImportData(strData1);
		}
	}else{
		DS_IO_SALE_INFO.ClearData();
	}
	DS_IO_SKU_LIST.ClearData();
	EM_SLAE_AMT_SUM.Text = "0";
	chkExcp(true);
	GD_SALE_INFO.ColumnProp('CHK','HeadCheck')= false;
	setTimeout("EM_RECEIPT_NO.Focus()",50);
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-03-09
 * 개    요 : 사은품 지급 등록
 * return값 : void
 */
function btn_Save() {
	   // 저장할 데이터 없는 경우
	   if (DS_IO_SALE_INFO.CountRow == 0){
           //저장할 내용이 없습니다
           showMessage(EXCLAMATION , OK, "USER-1028");
           return;
       }
	   var strCnt = 0;
	   var strCardCnt = 0;
	    for(var i=1;i<=DS_IO_SALE_INFO.CountRow;i++){
	        if(DS_IO_SALE_INFO.NameValue(i,"CHK") == "T"){
	        	strCnt += 1;           
	        }
	    }
	    
	    if(strCnt  == 0 && strCardCnt  == 0){
	    	 //저장할 내용이 없습니다
	           showMessage(EXCLAMATION , OK, "USER-1028");
	           return;
	    }
	    
	   if(!DS_IO_SKU_LIST.IsUpdated && !CHK_EXCP.checked){  // 지급품 정보 선택여부
	       showMessage(EXCLAMATION , OK, "USER-1000", "지급품을 선택해주세요.");
	       return;
	   }
	   if(CHK_EXCP.checked){  // 예외지급인경우 예외지급 정보 입력 여부
	       if(LC_EXCP_PRSNT_RSN.BindColVal == ""){
	    	   showMessage(EXCLAMATION , OK, "USER-1002", "예외지급사유");
	    	   LC_EXCP_PRSNT_RSN.Focus();
	    	   return;
	       }
	       if(EM_CONF_ID.Text == ""){
               showMessage(EXCLAMATION , OK, "USER-1002", "승인자");
               EM_CONF_ID.Focus();
               return;
           }
	       if(EM_SKU_CD.Text == ""){
               showMessage(EXCLAMATION , OK, "USER-1002", "지급품");
               EM_SKU_CD.Focus();
               return;
           }
	       
	   }
	   if(DS_O_EVENT_INFO.NameValue(1,"EVENT_TYPE") == "03"){ // 카드 행사 일경우 고객카드 번호 정보 정합성 체크
		  /* if(strCustId == "" ){
               showMessage(EXCLAMATION , OK, "USER-1000", "고객카드 정보가 확인되지 않았습니다.");
               EM_CARD_CUST_ID.Text = "";
               EM_CARD_CUST_ID.Focus();
               return;
		   }
		   if(EM_CARD_CUST_ID.Text == ""){
	           showMessage(EXCLAMATION , OK, "USER-1000", "고객카드 정보가 확인되지 않았습니다.");
	           EM_CARD_CUST_ID.Text = "";
	           EM_CARD_CUST_ID.Focus();
	           return;
		   }*/
	   }
		
	   if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
	   
	   var strParams = "&strPrsntFlag="    + encodeURIComponent(CHK_EXCP.checked)
	                 + "&strSkuCd="        + encodeURIComponent(EM_SKU_CD.Text)
	                 + "&strTrgCd="        + encodeURIComponent(HD_TRG_CD.Value)
	                 + "&strBuyCostPrc="   + encodeURIComponent(HD_BUY_COST_PRC.Value)
	                 + "&strExcpConfId="   + encodeURIComponent(EM_CONF_ID.Text)
	                 + "&strExcpPrsntRsn=" + encodeURIComponent(LC_EXCP_PRSNT_RSN.BindColVal)
	                 + "&strCardCustId="   + encodeURIComponent(EM_CARD_CUST_ID.Text)
	                 + "&strSaleAmtSum="   + encodeURIComponent(EM_SLAE_AMT_SUM.Text)
	                 + "&strPrsntDt="      + encodeURIComponent(EM_PRSNT_DT.Text)
	                 + "&strEventType="    + encodeURIComponent(DS_O_EVENT_INFO.NameValue(1,"EVENT_TYPE"));
	   TR_MAIN.Action="/mss/mcae401.mc?goTo=save"+strParams; 
	   TR_MAIN.KeyValue="SERVLET(I:DS_O_EVENT_INFO=DS_O_EVENT_INFO,I:DS_IO_SALE_INFO=DS_IO_SALE_INFO,I:DS_IO_SKU_LIST=DS_IO_SKU_LIST)";  
	   TR_MAIN.Post();
	  
	   if(TR_MAIN.ErrorCode == 0 ) btn_New("S");
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
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
  * getEventCombo()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-07
  * 개    요 : 화면 로딩시 사은행사 정보 조회 
  * return값 : void
  */

 function getEventCombo() {
      DS_O_EVENT_INFO.ClearData();
      DS_IO_SALE_INFO.ClearData();
      DS_IO_SKU_LIST.ClearData();
      DS_O_CARD_COMP.ClearData();
      
      // 조회조건 셋팅
       var strStrCd        = LC_STR.BindColVal;
       var strPrsntDt      = EM_PRSNT_DT.Text;
       var parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
                      + "&strPrsntDt="+ encodeURIComponent(strPrsntDt);
       TR_MAIN.Action="/mss/mcae401.mc?goTo=getEventCombo"+parameters;  
       TR_MAIN.KeyValue="SERVLET(O:DS_O_EVENT_COMBO=DS_O_EVENT_COMBO)"; //조회는 O
       TR_MAIN.Post();
       
       if(DS_O_EVENT_COMBO.CountRow == 0){
           showMessage(EXCLAMATION , OK, "USER-1000", "조건에 맞는 사은행사 내용이 없습니다.");
           EM_RECEIPT_NO.Text = "";
           EM_CARD_CUST_ID.Text = "";
           EM_RECEIPT_NO.Enable = false;
           EM_CARD_CUST_ID.Enable = false;
           
       }else{
    	   LC_EVENT.Index = 0;
    	   //getEventInfo();
       }
 }
 
 /**
  * getEventInfo()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-07
  * 개    요 : 화면 로딩시 사은행사 정보 조회 
  * return값 : void
  */

 function getEventInfo() {
	  DS_O_EVENT_INFO.ClearData();
	  DS_IO_SALE_INFO.ClearData();
      DS_IO_SKU_LIST.ClearData();
      DS_O_CARD_COMP.ClearData();
	  
	  // 조회조건 셋팅
	   var strStrCd        = LC_STR.BindColVal;
	   var strPrsntDt      = EM_PRSNT_DT.Text;
	   var strEventCd      = LC_EVENT.BindColVal;
	   var parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
	                  + "&strPrsntDt="+ encodeURIComponent(strPrsntDt)
	                  + "&strEventCd="+ encodeURIComponent(strEventCd);
	   TR_MAIN.Action="/mss/mcae401.mc?goTo=getEventInfo"+parameters;  
	   TR_MAIN.KeyValue="SERVLET(O:DS_O_EVENT_INFO=DS_O_EVENT_INFO)"; //조회는 O
	   TR_MAIN.Post();
	   
	   if(DS_O_EVENT_INFO.CountRow == 0){
           showMessage(EXCLAMATION , OK, "USER-1000", "조건에 맞는 사은행사 내용이 없습니다.");
           EM_RECEIPT_NO.Text = "";
           EM_CARD_CUST_ID.Text = "";
           EM_RECEIPT_NO.Enable = false;
           EM_CARD_CUST_ID.Enable = false;
           
       }else{
    	   EM_RECEIPT_NO.Enable = true;
           DS_O_EVENT_INFO.UserStatus(1) = 1;
       	   if(DS_O_EVENT_INFO.NameValue(1,"EVENT_TYPE") == "03"){
       		EM_CARD_CUST_ID.Enable = true;
       	   }
       }
 }
 

 
 /**
  * getCardInfo()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-07
  * 개    요 : 카드번호 입력시 고객 정보 조회
  * return값 : void
  */
 function getCardInfo() {
      if(DS_O_EVENT_INFO.CountRow == 0){
          showMessage(EXCLAMATION , OK, "USER-1000", "행사 정보를 확인하세요.");
          return;
      }
    /* if(DS_O_EVENT_INFO.NameValue(1,"EVENT_TYPE") != "03"){
          showMessage(EXCLAMATION , OK, "USER-1000", "D3카드고객행사가 아닙니다.");
          EM_CARD_CUST_ID.Text = "";    
          return;
      }*/
      // 조회조건 셋팅
       var strStrCd       = DS_O_EVENT_INFO.NameValue(1,"STR_CD");
       var strCardCustId  = EM_CARD_CUST_ID.Text;
       
       var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
                      + "&strCardCustId="+ encodeURIComponent(strCardCustId);
       
       TR_CARDINFO.Action="/mss/mcae401.mc?goTo=getCardInfo"+parameters;  
       TR_CARDINFO.KeyValue="SERVLET(O:DS_O_CARD_INFO=DS_O_CARD_INFO)"; //조회는 O
       TR_CARDINFO.Post();
      
       if(DS_O_CARD_INFO.CountRow == 0){
    	   showMessage(EXCLAMATION , OK, "USER-1000", "고객카드 정보가 확인되지 않았습니다.");  
           EM_CARD_CUST_ID.Text = "";
           EM_CARD_CUST_ID.focus();
           return;
       }
      if(DS_O_CARD_INFO.NameValue(1,"SCED_YN") == "Y"){ // 탈퇴여부
    	  showMessage(EXCLAMATION , OK, "USER-1000", "탈퇴한 고객카드입니다.");  
          EM_CARD_CUST_ID.Text = "";
          EM_CARD_CUST_ID.focus();
          return;
      }else if(DS_O_CARD_INFO.NameValue(1,"RETURN") != "0"){ // 정보조회 결과
          showMessage(EXCLAMATION , OK, "USER-1000", DS_O_CARD_INFO.NameValue(1,"MESSAGE"));  
          EM_CARD_CUST_ID.Text = "";
          EM_CARD_CUST_ID.focus();
          return;
      }
      
      getSaleInfo2();
 }
 /**
  * getSaleInfo()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-07
  * 개    요 : 영수증 번호 스캔시 영수증 정보 조회
  * return값 : void
  */

 function getSaleInfo() {
	  
	  if(DS_O_EVENT_INFO.CountRow == 0){
		  showMessage(EXCLAMATION , OK, "USER-1000", "행사 정보를 확인하세요.");
		  return;
	  }
	  if(DS_O_EVENT_INFO.NameValue(1,"EVENT_TYPE") == "03"){
		  if(EM_CARD_CUST_ID.Text == ""){
			  showMessage(EXCLAMATION , OK, "USER-1000", "고객 카드 행사 입니다 <br><br> 고객카드 번호를 먼저 입력하세요.");
			  EM_CARD_CUST_ID.Focus();
			  return;
		  }
		/*  if(DS_O_CARD_INFO.NameValue(1,"RTN_CD") != "0"){
			   showMessage(EXCLAMATION , OK, "USER-1000", DS_O_CARD_INFO.NameValue(1,"RTN_MSG"));  
	           EM_CARD_CUST_ID.Text = "";
	           DS_O_CARD_INFO.ClearData();
              return;
          } */
    
	  }
	  
	  // 조회조건 셋팅
       var strEventCd     = EM_EVENT_CD.Text;
       var strReceiptNo   = EM_RECEIPT_NO.Text;
       var strStrCd       = DS_O_EVENT_INFO.NameValue(1,"STR_CD"); //strReceiptNo.substring(1,3);
       var strSaleDt      = strToday.substring(0,2) + strReceiptNo.substring(1,7);
       var strPosNo       = strReceiptNo.substring(7,11);
       var strTranNo      = strReceiptNo.substring(11,16);
       var strEventType   = DS_O_EVENT_INFO.NameValue(1,"EVENT_TYPE");
       
    if(strSaleDt != strToday){
         showMessage(INFORMATION, OK, "USER-1000", "당일 영수증만 등록이 가능합니다.");  
         EM_RECEIPT_NO.Text = "";
         EM_RECEIPT_NO.Focus();
         return;
     }  
       
       // 중복 영수증 내용 체크 - 01: 단독, 03: D3 카드 행사 
   	   for(var i=1;i<=DS_IO_SALE_INFO.CountRow;i++){
              if(DS_IO_SALE_INFO.NameValue(i,"STR_CD") == strStrCd
                      && DS_IO_SALE_INFO.NameValue(i,"SALE_DT") == strSaleDt
                      && DS_IO_SALE_INFO.NameValue(i,"POS_NO") == strPosNo
                      && DS_IO_SALE_INFO.NameValue(i,"TRAN_NO") == strTranNo){
                  showMessage(EXCLAMATION , OK, "USER-1000", "이미 등록된 영수증입니다.");
                  EM_RECEIPT_NO.Text = "";
                  EM_RECEIPT_NO.Focus();
                  return;
              }
          }
       
       var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
                      + "&strEventCd="   + encodeURIComponent(strEventCd)
                      + "&strSaleDt="    + encodeURIComponent(strSaleDt)
                      + "&strPosNo="     + encodeURIComponent(strPosNo)
                      + "&strTranNo="    + encodeURIComponent(strTranNo)
                      + "&strEventType=" + encodeURIComponent(strEventType);
      
       TR_MAIN.Action="/mss/mcae401.mc?goTo=getSaleInfo"+parameters; 
       TR_MAIN.KeyValue="SERVLET(O:DS_IO_SALE_INFO_TMP=DS_IO_SALE_INFO_TMP,O:DS_IO_SALE_CHK=DS_IO_SALE_CHK)"; //조회는 O
       TR_MAIN.Post();
      
       if(DS_IO_SALE_CHK.NameValue(1,"CNT") == "0" ){
           showMessage(EXCLAMATION , OK, "USER-1000", "매출  미전송건입니다.");
           EM_RECEIPT_NO.Text = "";
       }else if(DS_IO_SALE_INFO_TMP.CountRow == 0 ){
           showMessage(EXCLAMATION , OK, "USER-1000", "지급대상 영수증이 아닙니다.");
           EM_RECEIPT_NO.Text = "";
       }else{
   		   var strData = DS_IO_SALE_INFO_TMP.ExportData(1,DS_IO_SALE_INFO_TMP.CountRow, true);
           DS_IO_SALE_INFO.ImportData(strData);
    	   EM_RECEIPT_NO.Text = "";
    	   setDivAmt();
       }
 }
 
 /**
  * getSaleInfo2()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-07
  * 개    요 : 영수증 번호 스캔시 영수증 정보 조회
  * return값 : void
  */

 function getSaleInfo2() {
      
      if(DS_O_EVENT_INFO.CountRow == 0){
          showMessage(EXCLAMATION , OK, "USER-1000", "행사 정보를 확인하세요.");
          return;
      }
      
      // 조회조건 셋팅
       var strEventCd     = EM_EVENT_CD.Text;
       var strStrCd       = DS_O_EVENT_INFO.NameValue(1,"STR_CD"); //strReceiptNo.substring(1,3);
       
       
       var parameters = "&strStrCd="   + encodeURIComponent(strStrCd)
                      + "&strEventCd=" + encodeURIComponent(strEventCd)
                      + "&strCustId="  + encodeURIComponent(DS_O_CARD_INFO.NameValue(1,"CUST_ID"));
      
       TR_MAIN.Action="/mss/mcae401.mc?goTo=getSaleInfo2"+parameters; 
       TR_MAIN.KeyValue="SERVLET(O:DS_IO_SALE_INFO_TMP=DS_IO_SALE_INFO_TMP)"; //조회는 O
       TR_MAIN.Post();
       
       if(DS_IO_SALE_INFO.CountRow > 0){
    	   // 중복 영수증 내용 체크 - 01: 단독, 03: D3 카드 행사 
           for(var i=1;i<=DS_IO_SALE_INFO_TMP.CountRow;i++){
               for(var j=1;j<=DS_IO_SALE_INFO.CountRow;j++){
                   if(DS_IO_SALE_INFO_TMP.NameValue(i,"STR_CD") == DS_IO_SALE_INFO.NameValue(j,"STR_CD")
                           && DS_IO_SALE_INFO_TMP.NameValue(i,"SALE_DT") == DS_IO_SALE_INFO.NameValue(j,"SALE_DT")
                           && DS_IO_SALE_INFO_TMP.NameValue(i,"POS_NO") == DS_IO_SALE_INFO.NameValue(j,"POS_NO")
                           && DS_IO_SALE_INFO_TMP.NameValue(i,"TRAN_NO") == DS_IO_SALE_INFO.NameValue(j,"TRAN_NO")){
                       // 영수증 중복체크 
                       DS_IO_SALE_INFO_TMP.DeleteRow(i);
                       i -=1;
                   }
               }
           }
       }
       
       if(DS_IO_SALE_INFO_TMP.CountRow == 0 ){
           showMessage(EXCLAMATION , OK, "USER-1000", "지급대상 영수증이 없습니다.");
           EM_CARD_CUST_ID.Text = "";
           EM_CARD_CUST_ID.focus();
       }else{
           var strData = DS_IO_SALE_INFO_TMP.ExportData(1,DS_IO_SALE_INFO_TMP.CountRow, true);
           DS_IO_SALE_INFO.ImportData(strData);
           EM_CARD_CUST_ID.Text = "";
           setDivAmt();
       }
 }
 
 /**
  * getSkuList()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-07
  * 개    요 : 사은품 조회
  * return값 : void
  */

 function getSkuList() {
	  if(DS_IO_SALE_INFO.CountRow == 0){
          showMessage(EXCLAMATION , OK, "USER-1000", "영수증 정보를 확인하세요.");
          return;
      }
	  
	  if(EM_SLAE_AMT_SUM.Text == "0"){
		  showMessage(EXCLAMATION , OK, "USER-1000", "영수증 정보를 확인하세요.");
		  return;
	  }
	  DS_IO_SKU_LIST.ClearData();
	  
      // 조회조건 셋팅
       var strStrCd        = LC_STR.BindColVal;
       var strEventCd      = EM_EVENT_CD.Text;
       var strSaleAmtSum   = EM_SLAE_AMT_SUM.Text;
       
       var parameters = "&strStrCd="      + encodeURIComponent(strStrCd)
                      + "&strEventCd="    + encodeURIComponent(strEventCd)
                      + "&strSaleAmtSum=" + encodeURIComponent(strSaleAmtSum);
       TR_MAIN.Action="/mss/mcae401.mc?goTo=getSkuList"+parameters;  
       TR_MAIN.KeyValue="SERVLET(O:DS_IO_SKU_LIST=DS_IO_SKU_LIST)"; //조회는 O
       TR_MAIN.Post();
       
       if(DS_IO_SKU_LIST.CountRow == 0){
    	   showMessage(EXCLAMATION , OK, "USER-1000", "총지급 인정금액이 부족합니다.");
           return; 
       }
 }
 
 /**
  * getSkuInfo()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-07
  * 개    요 : 사은품 정보(원가, 대상코드) 조회
  * return값 : void
  */

 function getSkuInfo() {
	   DS_O_SKU_INFO.ClearData();

      // 조회조건 셋팅
       var strStrCd        = LC_STR.BindColVal;
       var strEventCd      = EM_EVENT_CD.Text;
       var strSkuCd        = EM_SKU_CD.Text;
       
       var parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
                      + "&strEventCd="+ encodeURIComponent(strEventCd)
                      + "&strSkuCd="  + encodeURIComponent(strSkuCd);
       
       TR_MAIN.Action="/mss/mcae401.mc?goTo=getSkuInfo"+parameters;  
       TR_MAIN.KeyValue="SERVLET(O:DS_O_SKU_INFO=DS_O_SKU_INFO)"; //조회는 O
       TR_MAIN.Post();
       EM_SKU_CD.Text = "";
       EM_SKU_NM.Text = "";
       HD_BUY_COST_PRC.Value = "";
       HD_TRG_CD.Value = "";
 }
 
 /**
  * chkExcp()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-07
  * 개    요 : 예외 지금 사유 체크시 하단 내용 활성화
  * return값 : void
  */

 function chkExcp(flag) {
	  var strFlag = CHK_EXCP.checked;
	  if(!flag){
		  // 영수증 정보 내용 체크
		  if(strFlag && DS_IO_SALE_INFO.CountRow == 0){
			  showMessage(EXCLAMATION , OK, "USER-1000", "영수증 정보가 없습니다. 영수증을 등록하세요.");
			  EM_RECEIPT_NO.Focus();
			  CHK_EXCP.checked = false;
			  return;
		  }
		  
		  // 지급품 정보 수정 내용 체크
		  if(strFlag &&
				  DS_IO_SKU_LIST.IsUpdated &&
				  showMessage(EXCLAMATION , YESNO, "GAUCE-1000", "변경된 지급품 내용이 있습니다. 예외지급내용을 등록하시겠습니까?") != 1){
			  CHK_EXCP.checked = false;
			  return;
			  
		  }else{
			  DS_IO_SKU_LIST.ClearData();
		  }
	  }
      LC_EXCP_PRSNT_RSN.Enable = strFlag;
      EM_CONF_ID.Enable = strFlag;
      EM_SKU_CD.Enable = strFlag;
      enableControl(IMG_SKU_CD, strFlag);
      enableControl(IMG_CONF_ID, strFlag);
      
      if(strFlag){
    	  LC_EXCP_PRSNT_RSN.Index = 0;
    	  enableControl(IMG_ITEM, false);
      }else{
    	  enableControl(IMG_ITEM, true);
    	  LC_EXCP_PRSNT_RSN.BindColVal = "";
          EM_CONF_ID.Text = "";
          EM_CONF_NM.Text = "";
          EM_SKU_CD.Text = "";
          EM_SKU_NM.Text = ""; 
          HD_BUY_COST_PRC.Value = "";
          HD_TRG_CD.Value = "";
      }
 }
 
 /**
  * setDivAmt()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-08
  * 개    요 : 지분안분금액 계산
  * return값 : void
  */

 function setDivAmt(strFlag) {
	 var strCnt = 0;
	 var strSum = 0;
	 var strSaleAmt = new Array();
	 var strSaleAmtRate = new Array();
	 var strDivAmt = new Array();
	 var strRosPos = new Array();
	 var BuyCostPrc = 0;
	 var strDataSet = "";
	 var strCol = "";
	 var strSumDivAmt = 0;
	
       strDataSet = "DS_IO_SALE_INFO";
       strCol = 10;
	 
	 //원가   
    if(CHK_EXCP.checked){
    	BuyCostPrc = HD_BUY_COST_PRC.Value;
    }else{
    	for(var i=1;i<=DS_IO_SKU_LIST.CountRow;i++){
            if( DS_IO_SKU_LIST.NameValue(i,"CHK") == "F") continue;
            BuyCostPrc = DS_IO_SKU_LIST.NameValue(i,"BUY_COST_PRC");
        }
    }
	 //영수증 합계  
	 for(var i=1;i<=eval(strDataSet).CountRow;i++){
	    if( eval(strDataSet).NameValue(i,"CHK") == "F") continue;
        strCnt += 1;
        strSum += eval(strDataSet).NameValue(i,"SALE_AMT");
        strSaleAmt[i] = eval(strDataSet).NameValue(i,"SALE_AMT");
        strRosPos[i] = i;
	 }
	 EM_SLAE_AMT_SUM.Text = strSum;
	 if(BuyCostPrc == 0) return;
	 
	 //안분률 계산
	for(var j=1;j<=eval(strDataSet).CountRow;j++){
		if( eval(strDataSet).NameValue(j,"CHK") == "F") continue;
		strSaleAmtRate[j] = (strSaleAmt[j]/strSum) * 100;
		strDivAmt[j] = BuyCostPrc * (strSaleAmtRate[j]/100);
		strDivAmt[j] = Math.floor(strDivAmt[j]/100) * 100;
		eval(strDataSet).NameValue(strRosPos[j],"DIV_AMT") = strDivAmt[j];
		if(j == strRosPos[strRosPos.length-1]){
			  eval(strDataSet).NameValue(strRosPos[strRosPos.length-1],"DIV_AMT") = BuyCostPrc - strSumDivAmt;
		}
	   strSumDivAmt += strDivAmt[j];
	}
	 
 }
 
 
 /**
  * getSkuItem()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-08
  * 개    요 : 지급품 조회
  * return값 : void
  */
 function getSkuItem() {
	 var rtnMap = getSkuPop("SEL_SKU_POP3", DS_O_EVENT_INFO.NameValue(1, "STR_CD"), "", DS_O_EVENT_INFO.NameValue(1, "EVENT_CD"));
	 if(rtnMap != null){
		 EM_SKU_CD.Text = rtnMap.get("SKU_CD");
		 EM_SKU_NM.Text  = rtnMap.get("SKU_NAME");
		 HD_BUY_COST_PRC.Value = rtnMap.get("BUY_COST_PRC");
		 HD_TRG_CD.Value = rtnMap.get("TRG_CD");
		 setDivAmt();
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
<script language=JavaScript for=TR_CARDINFO event=onSuccess>
    for(i=0;i<TR_CARDINFO.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_CARDINFO event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
 <script language=JavaScript for=DS_IO_SALE_INFO event=OnRowPosChanged(row)>
 if(clickSORT)
     return;
</script>
<script language=JavaScript for=DS_IO_SKU_LIST event=OnRowPosChanged(row)>
 if(clickSORT)
     return;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=LC_STR event=OnSelChange()>
	// 점코드 변경시 행사 내용 조회
	getEventCombo();    
</script>
<script language=JavaScript for=LC_EVENT event=OnSelChange()>
    // 점코드 변경시 행사 내용 조회
    getEventInfo();  
    setTimeout("EM_RECEIPT_NO.Focus()",50);
</script>
<script language="javascript" for=GD_SKU_LIST event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row, colid);
	if(colid != "CHK") return;
	for(var i=1;i<=DS_IO_SKU_LIST.CountRow;i++){
		if(i != row && DS_IO_SKU_LIST.NameValue(row,"CHK") == "T"){
			DS_IO_SKU_LIST.NameValue(i,"CHK") = "F";
		}else{
			
		}
    }
	setDivAmt();
</script>

<script language="javascript" for=GD_SALE_INFO event=OnClick(row,colid)>
if(row == 0){
    sortColId( eval(this.DataID), row, colid); 
    return;
}
	if(colid != "CHK") return;
	if(DS_IO_SALE_INFO.NameValue(row, "PROVIDE_GB") != "0") return; 
	var strCnt = 0;
	for(var i=1;i<=DS_IO_SALE_INFO.CountRow;i++){
	    if( DS_IO_SALE_INFO.NameValue(i,"CHK") == "T"){
	    	strCnt += 1;
	    }else{
	    	DS_IO_SALE_INFO.NameValue(i,"DIV_AMT") = "";
	    }
	}
	setDivAmt();
	DS_IO_SKU_LIST.ClearData();
	GD_SALE_INFO.ColumnProp('CHK','HeadCheck')= false;
</script>

<script language="javascript" for=GD_SALE_INFO
	event=OnHeadCheckClick(Col,Colid,bCheck)>
    var strFlag = "T";
    if(Colid == "CHK"){
        if(bCheck == "0") strFlag = "F";
        for(var i=1; i<=DS_IO_SALE_INFO.CountRow; i++){
        	if(DS_IO_SALE_INFO.NameValue(i,"PROVIDE_GB") == "1") continue;    
        	DS_IO_SALE_INFO.NameString(i, Colid) = strFlag;
        	if(strFlag == "F"){
        		DS_IO_SALE_INFO.NameValue(i,"DIV_AMT") = "";
        		EM_SLAE_AMT_SUM.Text = 0;
        	}else{
        		setDivAmt();
        	}
        }
    }
</script>

<script language=JavaScript for=EM_RECEIPT_NO event=OnKillFocus()>
    if(this.Text == undefined) return;
	if(this.Text.length == 24){
	    // 일자 체크 
	    if(!checkYYYYMMDD("20" + this.Text.substring(1,7))){
	    	showMessage(EXCLAMATION , OK, "USER-1000", "당사 발행 영수증이 아닙니다.");
	        EM_RECEIPT_NO.Text = "";
	        setTimeout("EM_RECEIPT_NO.Focus()",50);
	        return;
	    }
		//포스 체크 
		if(this.Text.substring(7,8) != "1"
				&& this.Text.substring(7,8) != "2"
				&& this.Text.substring(7,8) != "3"){
			showMessage(EXCLAMATION , OK, "USER-1000", "당사 발행 영수증이 아닙니다.");
            EM_RECEIPT_NO.Text = "";
            setTimeout("EM_RECEIPT_NO.Focus()",50);
            return;
		}
		getSaleInfo();
	    setTimeout("EM_RECEIPT_NO.Focus()",50);
	}else if(this.Text.length > 0){
		showMessage(EXCLAMATION , OK, "USER-1000", "당사 발행 영수증이 아닙니다.");
		EM_RECEIPT_NO.Text = "";
		setTimeout("EM_RECEIPT_NO.Focus()",50);
	}
</script>
<script language=JavaScript for=EM_RECEIPT_NO event=OnKeyUp(kcode,scode)>
if(this.Text == undefined) return;
	if(this.Text.length == 24){
		//getSaleInfo();
	}
</script>
<script language=JavaScript for=EM_CARD_CUST_ID event=OnKillFocus()>
if(this.Text == undefined) return;
	if(this.Text.length == 16){
	   // getCardInfo();
	}else{
	    //DS_O_CARD_INFO.ClearData();
	}
</script>
<script language=JavaScript for=EM_CARD_CUST_ID
	event=OnKeyUp(kcode,scode)>
	if(this.Text.length == 16){
	    getCardInfo();
	}else{
		//DS_O_CARD_INFO.ClearData();
	}
</script>

<!-- 지급품 조회 -->
<script language=JavaScript for=EM_SKU_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
//코드가 존재 하지 않으면 명을 클리어 후 리턴
if( EM_SKU_CD.Text ==""){
	EM_SKU_NM.Text = "";
	HD_BUY_COST_PRC.Value = "";
	HD_TRG_CD.Value = ""; 
       return;
   }
    if(EM_SKU_CD.text!=null){
        if(EM_SKU_CD.text.length > 0){
        	getSkuInfo();
            // 조회내용이 없거나 1개 이상이면 팝업 호출
            if(DS_O_SKU_INFO.CountRow == 1){
            	// 지급품 조회후 대상코드 매입원가 조회
            	EM_SKU_CD.Text = DS_O_SKU_INFO.NameValue(1, "SKU_CD");
            	EM_SKU_NM.Text = DS_O_SKU_INFO.NameValue(1, "SKU_NAME");
            	HD_BUY_COST_PRC.Value = DS_O_SKU_INFO.NameValue(1, "BUY_COST_PRC");
            	HD_TRG_CD.Value = DS_O_SKU_INFO.NameValue(1, "TRG_CD");
            	setDivAmt();
            }else{
            	getSkuItem();
            }
            
        }
    }
</script>

<!-- 승인자   조회 -->
<script language=JavaScript for=EM_CONF_ID event=onKillFocus()>
	//변경된 내역이 없으면 무시
	if(!this.Modified)
	    return;
	//코드가 존재 하지 않으면 명을 클리어 후 리턴
	if( EM_CONF_ID.Text ==""){
		EM_CONF_NM.Text = "";
	       return;
	   }
    if(EM_CONF_ID.text!=null){
        if(EM_CONF_ID.text.length > 0){
            getUserNonPop('DS_O_S_CONF',EM_CONF_ID,EM_CONF_NM,'E','Y');
        }
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
<comment id="_NSID_">
<object id="DS_O_CARD_INFO" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=DS_I_CONDITION classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=DS_O_CARD_COMP classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=DS_O_EVENT_COMBO classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_S_CONF" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_STR" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_EXCP_PRSNT_RSN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_SKU_INFO" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_EVENT_INFO" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_SALE_CHK" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_SALE_INFO" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_SALE_INFO_TEMP" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_SALE_INFO_TEMP2" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_SALE_INFO_TMP" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_SKU_LIST" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_EXCP_SKU" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_CARDINFO" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<input type="hidden" id="HD_BUY_COST_PRC">
<input type="hidden" id="HD_TRG_CD">
<div id="testdiv" class="testdiv">
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
						<th width="100" class="point">점</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LC_STR classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=140 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
				        <th width="100" class="point">행사코드</th>
                        <td><comment id="_NSID_"> <object
                            id=LC_EVENT classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=180 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
                        <th width="100" class="point">등록일자</th>
                        <td width="140"><comment id="_NSID_"> <object
                            id=EM_PRSNT_DT classid=<%=Util.CLSID_EMEDIT%> width=140
                            tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                         </td>
                        <th width="100" class="point">등록자</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_PRSNT_CHAR_NM classid=<%=Util.CLSID_EMEDIT%> width=140
                            tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
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
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="sub_title"><img
							src="/<%=dir%>/imgs/comm/ring_blue.gif" align="absmiddle"
							class="PR03" />행사정보</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="PT01 PB03">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="100">점</th>
								<td width="140"><comment id="_NSID_"> <object id=EM_STR_NM
									classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								<th width="100">행사코드</th>
								<td width="140"><comment id="_NSID_"> <object id=EM_EVENT_CD
									classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								<th width="100">행사명</th>
								<td><comment id="_NSID_"> <object
									id=EM_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%> width=140
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th width="100">사은행사유형</th>
								<td width="140"><comment id="_NSID_"> <object
									id=EM_EVENT_TYPE_NM classid=<%=Util.CLSID_EMEDIT%> width=140
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								<th width="100">행사기간</th>
								<td colspan="3" align="absmiddle"><comment id="_NSID_">
								<object id=EM_EVENT_S_DT classid=<%=Util.CLSID_EMEDIT%>
									width=140 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								~ <comment id="_NSID_"> <object id=EM_EVENT_E_DT
									classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
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
	<tr>
		<td class="dot"></td>
	</tr>
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="740">
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th class="point" width="100">영수증번호</th>
						<td width="200"><comment id="_NSID_"> <object
							id=EM_RECEIPT_NO classid=<%=Util.CLSID_EMEDIT%> width=200
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="100">고객카드번호</th>
						<td width="140"><comment id="_NSID_"> <object
							id=EM_CARD_CUST_ID classid=<%=Util.CLSID_EMEDIT%> width=140
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
					</tr>
				</table>
				</td>
				<td align=right>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td><img ID=IMG_ITEM
							src="/<%=dir%>/imgs/btn/supplies_item_serach.gif"
							onclick="javascript:getSkuList();" align="absmiddle" class="PR03" />
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
				<td width="60%">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" align="absmiddle"
									class="PR03" />영수증정보</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
                            class="BD4A">
                            <tr>
                                <td><comment id="_NSID_"><OBJECT id=GD_SALE_INFO
                                    width=100% height=320 classid=<%=Util.CLSID_GRID%>>
                                    <param name="DataID" value="DS_IO_SALE_INFO">
                                    <Param Name="ViewSummary" value="1">
                                </OBJECT></comment><script>_ws_(_NSID_);</script></td>
                            </tr>
                        </table>
						</td>
					</tr>
					<tr height=3>
						<td></td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0"
							class="s_table">
							<tr>
								<th width="100">총인정금액</th>
								<td colspan="2"><comment id="_NSID_"> <object
									id=EM_SLAE_AMT_SUM classid=<%=Util.CLSID_EMEDIT%> width=200
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
				<td width="40%" class="PL05">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" align="absmiddle"
									class="PR03" />지급품정보</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="BD4A">
							<tr>
								<td><comment id="_NSID_"><OBJECT id=GD_SKU_LIST
									width=100% height=240 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_IO_SKU_LIST">
								</OBJECT></comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="5"></td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0"
							class="s_table">
							<tr>
                                <th rowspan=2 width="60" class="point">예외지급<br/>사유코드</th>
                                <td colspan=2><input type="checkbox" id=CHK_EXCP
                                    onclick="javascript:chkExcp();">예외지급</td>
                            </tr>
							<tr>
								<td colspan=2><comment id="_NSID_"> <object
									id=LC_EXCP_PRSNT_RSN classid=<%=Util.CLSID_LUXECOMBO%>
									width=120 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
								
							</tr>
							<tr>
								<th width="60" class="point">승인자</th>
								<td colspan="2"><comment id="_NSID_"> <object
									id=EM_CONF_ID classid=<%=Util.CLSID_EMEDIT%> width=95
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								<img id=IMG_CONF_ID src="/<%=dir%>/imgs/btn/detail_search_s.gif"
									class="PR03"
									onclick="javascript:getUserPop( EM_CONF_ID, EM_CONF_NM, 'S' );"
									align="absmiddle" /> <comment id="_NSID_"> <object
									id=EM_CONF_NM classid=<%=Util.CLSID_EMEDIT%> width=115
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th width="60" class="point">지급품</th>
								<td colspan="2"><comment id="_NSID_"> <object
									id=EM_SKU_CD classid=<%=Util.CLSID_EMEDIT%> width=95
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								<img id=IMG_SKU_CD src="/<%=dir%>/imgs/btn/detail_search_s.gif"
									class="PR03" onclick="javascript:getSkuItem();;"
									align="absmiddle" /> <comment id="_NSID_"> <object
									id=EM_SKU_NM classid=<%=Util.CLSID_EMEDIT%> width=115
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
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
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_EVENT_INFO classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_O_EVENT_INFO>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
        <c>Col=STR_NM          Ctrl=EM_STR_NM           param=Text</c>
        <c>Col=EVENT_CD        Ctrl=EM_EVENT_CD         param=Text</c>
        <c>Col=EVENT_NAME      Ctrl=EM_EVENT_NAME       param=Text</c>
        <c>Col=EVENT_TYPE_NM   Ctrl=EM_EVENT_TYPE_NM    param=Text</c>
        <c>Col=EVENT_S_DT      Ctrl=EM_EVENT_S_DT       param=Text</c>
        <c>Col=EVENT_E_DT      Ctrl=EM_EVENT_E_DT       param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

