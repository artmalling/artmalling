<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품지급/취소 > 기타지급관리
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : MCAE4080.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 : 2011.01.18 (김슬기) 신규작성
 *         2011.04.25 (김정민) 수정개발
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<% request.setCharacterEncoding("utf-8"); %>

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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">


/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var g_autoFlag = false;
var strSaveFlag = false; 
var g_select =false;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 100;		//해당화면의 동적그리드top위치
 var top2 = 220;		//해당화면의 동적그리드top위치
function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	 var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";


    // Input Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
	DS_O_CHECK.setDataHeader('<gauce:dataset name="H_GIFTCARD_NO_CHK"/>');

    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터    
    gridCreate2();
    
    // EMedit에 초기화
    initEmEdit(EM_S_S_DT,       "SYYYYMMDD", PK);             //기간FROM (조회)
    initEmEdit(EM_S_E_DT,       "YYYYMMDD", PK);              //기간TO (조회)
    initEmEdit(EM_EVENT_S_DT,   "YYYYMMDD", READ);            //행사기간FROM
    initEmEdit(EM_EVENT_E_DT,   "YYYYMMDD", READ);            //행사기간TO
    initEmEdit(EM_INFRR_DT,     "YYYYMMDD", NORMAL);          //기타지급일자
    initEmEdit(EM_S_EVENT_CD,   "NUMBER3^11^0", NORMAL);      //행사코드 (조회)
    initEmEdit(EM_S_EVENT_NAME, "GEN^40", READ);              //행사명 (조회)
    initEmEdit(EM_I_EVENT_CD,   "NUMBER3^11^0", PK);          //행사코드 
    initEmEdit(EM_I_EVENT_NAME, "GEN^40", READ);              //행사명  
    initEmEdit(EM_REMARK,       "GEN^200", NORMAL);              //비고 
    
    
    initEmEdit(EM_EVENT_GIFT_TYPE, "GEN^5", NORMAL);              //사은품종류 01:상품권 /02:물품

    EM_S_E_DT.Text          = getTodayFormat("YYYYMMDD");     //기간TO(조회)
    EM_EVENT_S_DT.Text      = getTodayFormat("YYYYMMDD");     //행사기간FROM
    EM_EVENT_E_DT.Text      = getTodayFormat("YYYYMMDD");     //행사기간TO
    EM_INFRR_DT.Text        = getTodayFormat("YYYYMMDD");     //기타지급일자
    
    //콤보 초기화
    initComboStyle(LC_S_STR_CD,DS_S_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점(조회)
    initComboStyle(LC_I_STR_CD,DS_I_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점 
    initComboStyle(LC_EVENT_TYPE,DS_EVENT_TYPE, "CODE^0^30,NAME^0^150", 1, READ);      //사은행사유형 
    
    // 공통에서 가져오기
    getStore("DS_S_STR_CD", "Y", "1", "N");   //점(조회)
    getStore("DS_I_STR_CD", "Y", "1", "N");   //점 
    getEtcCode("DS_EVENT_TYPE", "D", "M002", "N", "N", LC_EVENT_TYPE);   //사은행사유형
    getSkuCd("DS_SKU_CD");                // 사은품코드(GRID)   
   // getEtcCode("DS_EVENT_GIFT_TYPE", "D", "M065", "N", "N");   //사은품구분

    //점(조회) 
    LC_S_STR_CD.Index = 0;
 //   LC_I_STR_CD.Index = 0;
   LC_S_STR_CD.Focus(); 
    DS_SKU_CD.UseFilter = true;
  //  getSkuCd();
    CheckFlag(false);
}


function gridCreate1(){
    var hdrProperies ='<FC>id={currow}    name="NO"                 width=30   align=center </FC>'
			        + '<FC>id=STR_CD      name="점"                 width=67   align=center EDITSTYLE=LOOKUP   DATA="DS_I_STR_CD:CODE:NAME" </FC>'
			        + '<FC>id=INFRR_DT    name="기타지급일자"       width=76   align=center Mask="XXXX/XX/XX"  </FC>'
                    + '<FC>id=SLIP_NO     name="기타지급순번"       width=76   align=center </FC>'
                    + '<FC>id=REMARK      name="비고"               width=80   align=LEFT   </FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies2 ='<FC>id={currow}          name="NO"            width=30       align=center     Edit=none</FC>'
                    + '<FC>ID=SysSts name="SysStatus" width=70 Value={SysStatus}     align=Center show=false  </FC>'
                    + '<FC>id=SEQ_NO             name="순번"          width=70   align=center     show=false</FC>'
			        + '<FC>id=SKU_GB             name="*사은품구분"   width=90   align=LEFT       EDITSTYLE=COMBO    DATA="1:물품,2:상품권" </FC>'
			        + '<FC>id=SKU_CD             name="*사은품코드"   width=150  align=LEFT       EDITSTYLE=LOOKUP   DATA="DS_SKU_CD:SKU_CD:SKU_NAME" </FC>'
                    + '<FC>id=BUY_COST_PRC       name="단가"          width=70   align=right      Edit=none    </FC>'
                    + '<FC>id=INFRR_QTY          name="*수량"         width=60   align=right      edit={if(SysStatus ="I","true", "false")}     </FC>'
                    + '<FC>id=AMT                name="지급금액"      width=80   align=right      Edit=none    </FC>'
					+ '<FC>id=GIFTCARD_NO        name="상품권번호"    width=100	 align=center     edit={if(SysStatus ="I", if(SKU_GB="2", "true", "false"), false)}    	</FC>'
					+ '<FC>id=GIFTCARD_CNT       name="수량"     	  width=60	 align=rigth	  edit=none	   </FC>'
					+ '<FC>id=GIFTCERT_AMT    	 name="상품권금액"    width=90	 align=rigth	  edit=none	   </FC>'
					+ '<FC>id=GIFTCARD_LIST	     name="상품권LIST"    width=200	 align=rigth	  edit=none	   </FC>'
					;
                     
    initGridStyle(GD_DETAIL, "common", hdrProperies2, true); 
  //  GD_DETAIL.UseChangeInfo = false;
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
    if (DS_DETAIL.IsUpdated || DS_MASTER.IsUpdated) {
        if (showMessage(Question, YesNo, "USER-1059") != "1") { //아니요 
            return;
        }      
    }  
	 
	if (EM_S_S_DT.Text > EM_S_E_DT.Text){ 
        showMessage(INFORMATION, OK, "USER-1008", "종료기간", "시작기간");
        EM_S_E_DT.Focus();
        return;
    }
	// 조회조건 셋팅
    var strStrCd        = LC_S_STR_CD.BindColVal;
    var strSdt          = EM_S_S_DT.Text;
    var strEdt          = EM_S_E_DT.Text;
    var strEventCd      = EM_S_EVENT_CD.Text;
   
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="   + encodeURIComponent(strStrCd)
                   + "&strSdt="     + encodeURIComponent(strSdt)
                   + "&strEdt="     + encodeURIComponent(strEdt)
                   + "&strEventCd=" + encodeURIComponent(strEventCd);
    TR_MAIN.Action="/mss/mcae408.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    g_select =true;
    TR_MAIN.Post();
    g_select = false;
    
    setPorcCount("SELECT", GD_MASTER);
    
    if(DS_MASTER.CountRow !=0) {
    	getDetail2();
    }
    else{ 
        DS_MASTER.ClearData();
        DS_DETAIL.ClearData();
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
	 DS_MASTER.AddRow(); 
	 CheckFlag(true); 
     setTimeout("LC_I_STR_CD.Focus()",50);
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	 
	 if(EM_I_EVENT_CD.Text == "") {
		  showMessage(StopSign, OK, "USER-1000", "행사코드를 입력하세요");
          setTimeout("EM_I_EVENT_CD.Focus();",50);
          return; 
	 }
	 
	 var strToday = getTodayFormat("YYYYMMDD");  
	 if(DS_MASTER.RowStatus(DS_MASTER.RowPosition)== "1") {
	   if(EM_INFRR_DT.Text < strToday) {
	       showMessage(INFORMATION, OK, "USER-1000", "기타지급일자는 오늘날짜보다 <br>작을 수 없습니다.");
	       setTimeout("EM_INFRR_DT.Focus();",50);
	       return;  
	   }
	 }
	 
	 if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_S_DT") > EM_INFRR_DT.Text && DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_E_DT") < EM_INFRR_DT.Text) {
          showMessage(INFORMATION, OK, "USER-1000", "기타지급일자가 행사기간에 포함되지 않습니다.");
          setTimeout("EM_INFRR_DT.Focus();",50);
          return;
	 }
	 
	 for(var i=0; i <= DS_DETAIL.CountRow; i++) {
        if(DS_DETAIL.NameValue(i,"SKU_GB") == "") {  
            showMessage(StopSign, OK, "USER-1002", "사은품구분"); 
            setFocusGrid(GD_DETAIL, DS_DETAIL, i, "SKU_GB");
            return;
        }
        if(DS_DETAIL.NameValue(i,"SKU_CD") == "") {  
               showMessage(StopSign, OK, "USER-1003", "사은품코드"); 
               setFocusGrid(GD_DETAIL, DS_DETAIL, i, "SKU_CD");
               return;
           }
        if(DS_DETAIL.NameValue(i,"INFRR_QTY") == 0) {  
               showMessage(StopSign, OK, "USER-1003", "수량"); 
               setFocusGrid(GD_DETAIL, DS_DETAIL, i, "INFRR_QTY");
               return;
           }
    }
 
	if(DS_DETAIL.CountRow == "0") {
	     showMessage(INFORMATION, OK, "USER-1000", "상세내역을 입력 하셔야 합니다."); 
	     return;
	}
	
	if(DS_MASTER.RowStatus(DS_MASTER.RowPosition) == "1" || DS_DETAIL.RowStatus(DS_MASTER.RowPosition) == "1") { 
	    getEventMagam(); 
	}
	
	var strStrCd   = LC_I_STR_CD.BindColVal;    // 점
    var strEventCd = EM_I_EVENT_CD.Text;        // 행사코드
    var strInfrrDt = EM_INFRR_DT.Text;          // 기타지급일자
    var strRemark  = EM_REMARK.Text;            // 비고
    var strSlipNo = DS_MASTER.NameValue(DS_MASTER.RowPosition,"SLIP_NO");
	 
    

	var strCnt = 0;
	var strCardCnt = 0;
	
	var strSKU_GB = "";
	var strGiftCardNo = "";
	var nGiftCertAmt  = 0;
	var strGiftCardList = "";
	
	var strGiftCardNo_a ="";
	var strGiftCardNo_b ="";
	
	
	// 지급품정보(중복지급) 데이터 체크 시작
	for(var i=1;i<=DS_DETAIL.CountRow;i++){
		strSKU_GB = DS_DETAIL.NameValue(i, "SKU_GB");		//사은품종료 =2:상품권
           
        if (strSKU_GB =="2"){             	
            strGiftCardNo = DS_DETAIL.NameValue(i, "GIFTCARD_NO");		// 상품권번호
            nBUY_COST_PRC  = DS_DETAIL.NameValue(i, "AMT");	            // 지급품금액
            nGiftCertAmt  = DS_DETAIL.NameValue(i, "GIFTCERT_AMT");	// 상품권 금액
            strGiftCardList = DS_DETAIL.NameValue(i, "GIFTCARD_LIST");		// 상품권번호LIST
            
            if(strGiftCardList.length == 0){
				showMessage(INFORMATION, OK, "USER-1000", "상품권번호를 입력하세요.");
            	setFocusGrid(GD_DETAIL, DS_DETAIL, i, "GIFTCARD_NO");
                return false;
    		}
    		
    		if(nGiftCertAmt == 0){
				showMessage(INFORMATION, OK, "USER-1000", "상품권금액이 0입니다. 상품권을 확인하십시오.");
            	setFocusGrid(GD_DETAIL, DS_DETAIL, i, "GIFTCARD_NO");
                return false;
    		}
    		

    		if(nGiftCertAmt != nBUY_COST_PRC){
				showMessage(INFORMATION, OK, "USER-1000", "지급금액과 입력 상품권금액이 같지않습니다. 확인하세요");
            	setFocusGrid(GD_DETAIL, DS_DETAIL, i, "GIFTCARD_NO");
                return false;
    		}
        }
	
	}

	
	//변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
        GD_DETAIL.Focus();
        return;
    } 
    strSaveFlag = true;
    var goTo = "save";
    var parameters = "&strStrCd="   + encodeURIComponent(strStrCd)
                   + "&strEventCd=" + encodeURIComponent(strEventCd) 
                   + "&strInfrrDt=" + encodeURIComponent(strInfrrDt)
                   + "&strRemark="  + encodeURIComponent(strRemark)
                   + "&strSlipNo="  + encodeURIComponent(strSlipNo);
    TR_MAIN.Action = "/mss/mcae408.mc?goTo=" + goTo + parameters;  
    TR_MAIN.KeyValue = "SERVLET(I:DS_MASTER=DS_MASTER, I:DS_DETAIL=DS_DETAIL)";
    TR_MAIN.Post();
   
    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    btn_Search(); 
    strSaveFlag = false;
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

/**
 * addRow()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-24
 * 개    요 : 행추가
 * return값 : void
 */

function addRow() {
   if(DS_MASTER.CountRow == 0){
       return;
   }  
   
   if(EM_I_EVENT_CD.Text == "") {
       showMessage(INFORMATION, OK, "USER-1000", "행사코드를 먼저 입력해 주세요");
       setTimeout("EM_I_EVENT_CD.Focus();",50);
       return; 
   } 
   var strToday = getTodayFormat("YYYYMMDD");  
   if(EM_INFRR_DT.Text < strToday) {
	   showMessage(INFORMATION, OK, "USER-1000", "기타지급일자는 오늘날짜보다 <br>작을 수 없습니다.");
       setTimeout("EM_INFRR_DT.Focus();",50);
       return;  
   }
   
   
   if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_S_DT") <= EM_INFRR_DT.Text && DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_E_DT") >= EM_INFRR_DT.Text) {
	   if(DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"SKU_CD") == "") {
		   showMessage(INFORMATION, OK, "USER-1000", "사은품을 선택해야 합니다.");
		   return;
	   }
	   DS_DETAIL.AddRow();
	   
	   LC_I_STR_CD.Enable = false;
       LC_EVENT_TYPE.Enable = false;
       EM_I_EVENT_CD.Enable = false;
       EM_INFRR_DT.Enable = false; 
       enableControl(popEventI, false);
       enableControl(imgFrr, false);   
   }
   else {
	   showMessage(INFORMATION, OK, "USER-1000", "기타지급일자가 행사기간에 속하지 않습니다.");
	   setTimeout("EM_INFRR_DT.Focus();",50);
       return; 
   }
    
   //DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"SKU_GB") = "1";
   DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "SKU_GB") = EM_EVENT_GIFT_TYPE.Text;
   getSkuCd();
   setFocusGrid(GD_DETAIL, DS_DETAIL, DS_DETAIL.CountRow, "SKU_GB");
}

/**
 * delRow()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-24
 * 개    요 : 행삭제
 * return값 : void
 */

function delRow() {
    if(DS_DETAIL.CountRow == 0){
        showMessage(INFORMATION, OK, "USER-1019");
        return;
    }
    
    if (DS_DETAIL.RowStatus(DS_DETAIL.RowPosition) != "1") { 
    	showMessage(INFORMATION, OK, "USER-1000", "이미 등록된 내용은 삭제 할 수 없습니다.");
        return; 
    }
    
    if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_S_DT") <= EM_INFRR_DT.Text && DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_E_DT") >= EM_INFRR_DT.Text) {
        DS_DETAIL.DeleteRow(DS_DETAIL.RowPosition);
    }
    else {
        showMessage(INFORMATION, OK, "USER-1000", "기타지급일자가 행사기간에 속하지 않습니다.");
        setTimeout("EM_INFRR_DT.Focus();",50);
        return; 
    }
    
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getEventType()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011-04-25
  * 개    요 : 사은 행사 유형 조회
  * return값 : void
  */
function getEventType(){
	var strEventCd   = EM_I_EVENT_CD.Text;
   
    var goTo       = "getEventType" ;    
    var action     = "O";     
    var parameters = "&strEventCd="   + encodeURIComponent(strEventCd);   
    TR_MAIN.Action="/mss/mcae408.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_RESULT=DS_O_RESULT)"; //조회는 O
    TR_MAIN.Post();
    
    LC_EVENT_TYPE.BindColVal = DS_O_RESULT.NameValue(1, "EVENT_TYPE"); 
    EM_EVENT_GIFT_TYPE.Text = DS_O_RESULT.NameValue(1, "EVENT_GIFT_TYPE"); 

}

/**
 * CheckFlag()
 * 작 성 자 : 김정민
 * 작 성 일 : 2011-04-25
 * 개    요 : 로딩시 컨트롤 제어
 * return값 : void
 */
function CheckFlag(strGbn) {
	if(strGbn == true) {
		LC_I_STR_CD.Enable = true;
      //  LC_EVENT_TYPE.Enable = true;
        EM_I_EVENT_CD.Enable = true;
        EM_INFRR_DT.Enable = true; 
        enableControl(popEventI, true);
        enableControl(imgFrr, true);
        enableControl(Addrow, true);
        enableControl(Delrow, true);  
        
        LC_I_STR_CD.Index = 0; 
        LC_EVENT_TYPE.Index = 0; 
        EM_I_EVENT_CD.Text= "";
        EM_I_EVENT_NAME.Text = "";
        EM_INFRR_DT.Text        = getTodayFormat("YYYYMMDD"); 
        EM_EVENT_S_DT.Text = "";
        EM_EVENT_E_DT.Text = "";
        EM_REMARK.Text = "";
	}
	else {
		LC_I_STR_CD.Enable = false;
		LC_EVENT_TYPE.Enable = false;
		EM_I_EVENT_CD.Enable = false;
		EM_INFRR_DT.Enable = false; 
		enableControl(popEventI, false);
        enableControl(imgFrr, false);
        enableControl(Addrow, false);
        enableControl(Delrow, false);  
        
        LC_I_STR_CD.BindColVal = "";
        EM_I_EVENT_CD.Text= "";
        EM_I_EVENT_NAME.Text = "";
        EM_EVENT_S_DT.Text = "";
        EM_EVENT_E_DT.Text = "";
        LC_EVENT_TYPE.BindColVal = ""; 
    //    EM_INFRR_DT.Text        = getTodayFormat("YYYYMMDD");
        EM_INFRR_DT.Text        ="";
        EM_REMARK.Text = "";
	}
}

/**
 * getEventMagam()
 * 작 성 자 : 김정민
 * 작 성 일 : 2011-04-25
 * 개    요 : 사은품 마감 체크
 * return값 : void
 */
function getEventMagam() {
	var strEventCd = EM_I_EVENT_CD.Text;        // 행사코드
	    
    var goTo = "getEventMagam";
    var action = "O";
    var parameters = "&strEventCd=" + encodeURIComponent(strEventCd);
    TR_MAIN.Action = "/mss/mcae408.mc?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_O_RETURN=DS_O_RETURN)";
    TR_MAIN.Post();
  //  alert();
    if(DS_O_RETURN.NameValue(DS_O_RETURN.RowPosition,"CONF_FLAG") == "1") { 
        showMessage(INFORMATION, OK, "USER-1000", "사은품 행사가 확정된 행사코드 입니다.");
        EM_I_EVENT_CD.Text = ""; 
        setTimeout(" EM_I_EVENT_CD.Focus();",50);
        return;
    }
}

/**
 * getDetail()
 * 작 성 자 : 김정민
 * 작 성 일 : 2011-04-05
 * 개    요 : DETAIL조회
 * return값 : void
 */
function getDetail() {  
	 if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD") == ""  || DS_MASTER.NameValue(DS_MASTER.RowPosition,"INFRR_DT")== "" || DS_MASTER.NameValue(DS_MASTER.RowPosition,"SLIP_NO")=="") {
		 DS_DETAIL.ClearData();
		 return;
	 }
	 
    if(DS_MASTER.CountRow >= 1) { 
    	var Today = getTodayFormat("YYYYMMDD");
        if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_S_DT") <= Today && DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_E_DT") >= Today) {
            if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_S_DT") <= EM_INFRR_DT.Text && DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_E_DT") >= EM_INFRR_DT.Text) {
                enableControl(Addrow, true);
                enableControl(Delrow, true);    
                 // alert("1");
                  EM_REMARK.Enable = true; 
            }
            else {
                 enableControl(Addrow, false);
                 enableControl(Delrow, false);  
                 LC_I_STR_CD.Enable = false;
                 LC_EVENT_TYPE.Enable = false;
                 EM_I_EVENT_CD.Enable = false;
                 EM_INFRR_DT.Enable = false; 
                 enableControl(popEventI, false);
                 enableControl(imgFrr, false);
                 enableControl(Addrow, false);
              //   alert("2");
                 enableControl(Delrow, false); 
            }
        }
        else {
            enableControl(Addrow, false);
            enableControl(Delrow, false);  
            LC_I_STR_CD.Enable = false;
            LC_EVENT_TYPE.Enable = false;
            EM_I_EVENT_CD.Enable = false;
            EM_INFRR_DT.Enable = false; 
            enableControl(popEventI, false);
            enableControl(imgFrr, false);
            enableControl(Addrow, false);
          //  alert("3");
            enableControl(Delrow, false); 
        } 

        getSkuCd();
           var strStrCd     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
           var strInfrrDt   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"INFRR_DT");
           var strSlipNo    = DS_MASTER.NameValue(DS_MASTER.RowPosition,"SLIP_NO");
          
           var goTo       = "getDetail" ;    
           var action     = "O";     
           var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                          + "&strInfrrDt="  + encodeURIComponent(strInfrrDt)
                          + "&strSlipNo="   + encodeURIComponent(strSlipNo);
          
           TR_MAIN.Action="/mss/mcae408.mc?goTo="+goTo+parameters;  
           TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
           TR_MAIN.Post();
           
           setPorcCount("SELECT", GD_DETAIL);   
    } 
    else {
        return;
    }
}

/**
 * getDetail()
 * 작 성 자 : 김정민
 * 작 성 일 : 2011-04-05
 * 개    요 : DETAIL조회
 * return값 : void
 */
function getDetail2() { 
	 if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD") == ""  || DS_MASTER.NameValue(DS_MASTER.RowPosition,"INFRR_DT")== "" || DS_MASTER.NameValue(DS_MASTER.RowPosition,"SLIP_NO")=="") {
         DS_DETAIL.ClearData();
         return;
     }
	 
    if(DS_MASTER.CountRow >= 1) { 
    	var Today = getTodayFormat("YYYYMMDD");
        if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_S_DT") <= Today && DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_E_DT") >= Today) {
            if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_S_DT") <= EM_INFRR_DT.Text && DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_E_DT") >= EM_INFRR_DT.Text) {
                enableControl(Addrow, true);
                enableControl(Delrow, true);  
                 // alert("1");
                  EM_REMARK.Enable = true; 
            }
            else {
                 enableControl(Addrow, false);
                 enableControl(Delrow, false);  
                 LC_I_STR_CD.Enable = false;
                 LC_EVENT_TYPE.Enable = false;
                 EM_I_EVENT_CD.Enable = false;
                 EM_INFRR_DT.Enable = false; 
                 enableControl(popEventI, false);
                 enableControl(imgFrr, false);
                 enableControl(Addrow, false);
              //   alert("2");
                 enableControl(Delrow, false); 
            }
        }
        else {
            enableControl(Addrow, false);
            enableControl(Delrow, false);  
            LC_I_STR_CD.Enable = false;
            LC_EVENT_TYPE.Enable = false;
            EM_I_EVENT_CD.Enable = false;
            EM_INFRR_DT.Enable = false; 
            enableControl(popEventI, false);
            enableControl(imgFrr, false);
            enableControl(Addrow, false);
          //  alert("3");
            enableControl(Delrow, false); 
        } 

        getSkuCd();
           var strStrCd     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
           var strInfrrDt   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"INFRR_DT");
           var strSlipNo    = DS_MASTER.NameValue(DS_MASTER.RowPosition,"SLIP_NO");
          
           var goTo       = "getDetail" ;    
           var action     = "O";     
           var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                          + "&strInfrrDt="  + encodeURIComponent(strInfrrDt)
                          + "&strSlipNo="   + encodeURIComponent(strSlipNo);
          
           TR_MAIN.Action="/mss/mcae408.mc?goTo="+goTo+parameters;  
           TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
           TR_MAIN.Post(); 
    } 
    else {
        return;
    }
}


/**
 *	chkGiftCardNo()
 *	작 성 자 : 홍종영
 *	작 성 일 : 2012-05-30
 *	개	  요 : 상품권 번호 조회
 *	return값 : void
 */ 
function chkGiftCardNo(strDataSet, strRow){

	var strGiftCardNo = eval(strDataSet).NameValue(strRow, "GIFTCARD_NO");

	var goTo		= "chkGiftCardNo";
	var	action		= "O";
	var parameters	= "&strGiftCardNo="+ encodeURIComponent(strGiftCardNo);
	
	TR_MAIN3.Action="/mss/mcae408.mc?goTo="+goTo+parameters;  
	TR_MAIN3.KeyValue="SERVLET("+action+":DS_O_CHECK=DS_O_CHECK)"; 
	TR_MAIN3.Post();
	
	if(DS_O_CHECK.CountRow == 0){
		//eval(strDataSet).NameValue(strRow, "GIFTCERT_AMT") = 0;
		showMessage(INFORMATION, OK, "USER-1000", "상품권번호가 유효하지 않습니다.");
		return false;
	}else{

		eval(strDataSet).NameValue(strRow, "GIFTCERT_AMT") = DS_O_CHECK.NameValue(1, DS_O_CHECK.ColumnID(2));
		return true;
	}
	
}

/**
 * getSkuCd()
 * 작 성 자 : 김정민
 * 작 성 일 : 2011-04-26
 * 개    요 : 사은품코드,명조회
 * return값 : void
 */
function getSkuCd() {
     var strStrCd   = LC_I_STR_CD.BindColVal;     
	 var strEventCd = EM_I_EVENT_CD.Text;                                  // 행사코드 
     
	    var goTo = "getSkuCd";
	    var action = "O";
	    var parameters = "&strStrCd="   + encodeURIComponent(strStrCd)
	                   + "&strEventCd=" + encodeURIComponent(strEventCd);
	    TR_MAIN.Action = "/mss/mcae408.mc?goTo=" + goTo + parameters;
	    TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_SKU_CD=DS_SKU_CD)"; 
	    TR_MAIN.StatusResetType= "2";
	    TR_MAIN.Post();
}
 

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

<script	language=JavaScript	for=TR_MAIN3 event=onSuccess>
	for(i=0;i<TR_MAIN3.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN3.SrvErrMsg('UserMsg',i));
	}
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>


<script	language=JavaScript	for=TR_MAIN3 event=onFail>
	trFailed(TR_MAIN3.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }    
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }     
</script>

<script language=JavaScript for=GD_DETAIL
	event=OnExit(row,colid,olddata)> 
if (colid == "INFRR_QTY") {
	DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"AMT") = DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"BUY_COST_PRC") * DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"INFRR_QTY");
}
</script>

<!-- 조회 후 DETAIL 수정 후 MASTER 클릭시 이벤트 발생  -->
<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)> 
if (!strSaveFlag) {
    if (DS_MASTER.CountRow > 0) {
        if (DS_MASTER.RowStatus(row) == 1) { // 신규행작성시
            var ret = showMessage(Question, YesNo, "USER-1049");
            if (ret == "1") {
                DS_MASTER.DeleteRow(row);
                return true;    
            } else {
                return false;   
            }
        } else if (DS_MASTER.RowStatus(row) == 3) { //데이터 변경시
            var ret = showMessage(Question, YesNo, "USER-1049");
            if (ret == "1") {
                rollBackRowData(DS_MASTER, row);
                return true;    
            } else {
                return false;   
            }
        }
        return true;
    }
    return true;
}
</script>

<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
    if (row > 0 && g_select==false) {  

        LC_I_STR_CD.Enable = false;
        LC_EVENT_TYPE.Enable = false;
        EM_I_EVENT_CD.Enable = false;
        EM_INFRR_DT.Enable = false; 
        enableControl(popEventI, false);
        enableControl(imgFrr, false);
         
        setTimeout("getDetail()",50); 
        GD_DETAIL.SetColumn("SKU_CD");
    }    
</script>

<script language=JavaScript for=DS_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return;
    if (DS_DETAIL.RowStatus(row) == "1") { 
    	GD_DETAIL.ColumnProp('SKU_GB',     'Edit') = "";   // 사은품구분
        GD_DETAIL.ColumnProp('SKU_CD',     'Edit') = "";   // 사은품코드
    	GD_DETAIL.ColumnProp('INFRR_QTY',  'Edit') = "Numeric";   // 수량   
        
 
      //  EM_REMARK.Enable = true; 
    } else {   
    	var Today = getTodayFormat("YYYYMMDD");
        if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_S_DT") <= Today && DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_E_DT") >= Today) {
         //  alert("1");
        	if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_S_DT") <= EM_INFRR_DT.Text && DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_E_DT") >= EM_INFRR_DT.Text) {
        	//	alert("2");
        		GD_DETAIL.ColumnProp('SKU_GB',     'Edit') = "NONE";   // 사은품구분
                GD_DETAIL.ColumnProp('SKU_CD',     'Edit') = "NONE";   // 사은품코드
                //GD_DETAIL.ColumnProp('INFRR_QTY',  'Edit') = "Numeric";   // 수량 
                GD_DETAIL.ColumnProp('INFRR_QTY',  'Edit') = "NONE";   // 수량
                
                
            }
        }
        else { 
        //	alert("3");
            GD_DETAIL.ColumnProp('SKU_GB',     'Edit') = "NONE";   // 사은품구분
            GD_DETAIL.ColumnProp('SKU_CD',     'Edit') = "NONE";   // 사은품코드
            GD_DETAIL.ColumnProp('INFRR_QTY',  'Edit') = "NONE";   // 수량 
        }
    }
</script>



<!-- 데이터셋 값 변경 후 -->
<script language="javascript"  for=DS_DETAIL event=OnColumnChanged(row,colid)>

	switch(colid){
		
		case'SKU_GB':
		    //  alert(DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"SKU_CD"));
	       getSkuCd();
	       DS_SKU_CD.Filter();
	    
	       DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"SKU_CD") = "";
	       DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"BUY_COST_PRC") = ""; 
	       DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"GIFTCERT_AMT") = "0"; 
	       DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"GIFTCARD_CNT") = "0"; 
	       DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"GIFTCARD_LIST") = ""; 

		   break;
		
		case 'GIFTCARD_NO':     // 상품권 번호 조회	
			//중복불가 지급내역 선택시
			if(DS_DETAIL.NameValue(row,"GIFTCARD_NO").length == 0) {
				//DS_DETAIL.NameValue(row, "GIFTCERT_AMT") = 0;
				return;
			}
			
			if(DS_DETAIL.NameValue(row,"GIFTCARD_NO").length != 12){
				return;
			}else{
	    		var iItemCd = DS_DETAIL.NameValue(row,"GIFTCARD_NO");
	    		var iGIFTCERT_AMT = DS_DETAIL.NameValue(row,"GIFTCERT_AMT");
	    		var iGIFTCARD_CNT = 0;
	    		var strGIFTCARD_LIST = DS_DETAIL.NameValue(row,"GIFTCARD_LIST");
	    		
	    		var intcol = 0;
	    		
				for(var irow=1;irow<=DS_DETAIL.CountRow;irow++){
	    			
	    			iGIFTCARD_CNT = DS_DETAIL.NameValue(irow,"GIFTCARD_CNT");
	    			intcol = 0;
		    		for(var i=1;i<=iGIFTCARD_CNT;i++){
		    			var strGIFTCARD_NO = DS_DETAIL.NameValue(irow,"GIFTCARD_LIST").substring(intcol,12 + intcol);
		    			
		    			if (iItemCd == strGIFTCARD_NO) {
		    	            showMessage(STOPSIGN, OK, "USER-1000", irow + "행에 이미 입력한 상품권번호 입니다.");
		    	            DS_DETAIL.NameValue(row,"GIFTCARD_NO") = "";
		    	            return;
		    				
		    			}
		    			intcol = intcol + 12
		    		}
	    		}
				
	    		//--상품권이 중복이없고 유효한 상품권이경우에 수량, 금액, list에 추가
	    		if (chkGiftCardNo("DS_DETAIL", row)) {
	    		
	    			DS_DETAIL.NameValue(row,"GIFTCARD_CNT") = DS_DETAIL.NameValue(row,"GIFTCARD_CNT") + 1;
	    			DS_DETAIL.NameValue(row,"GIFTCERT_AMT") = DS_DETAIL.NameValue(row,"GIFTCERT_AMT") + iGIFTCERT_AMT;
	    			DS_DETAIL.NameValue(row,"GIFTCARD_LIST") = DS_DETAIL.NameValue(row,"GIFTCARD_NO") + strGIFTCARD_LIST;
	    			DS_DETAIL.NameValue(row,"GIFTCARD_NO") = "";
	    		}
			}
			break;
	}
</script>

 
<!-- DETAIL에서 콤보 선택 시 이벤트 발생 -->
<script language=JavaScript for=GD_DETAIL event=OnCloseUp(row,colid)>
if(colid == "SKU_CD") {
	if(DS_DETAIL.ContRow == "1") {
        return;
    }
    if(DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"SKU_CD")== "") {
        return;
    }
    else {
        for(var i=1; i<=DS_DETAIL.CountRow-1; i++) {
            if(DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"SKU_CD") == DS_DETAIL.NameValue(i,"SKU_CD")) {
        //    	alert(DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"SKU_CD"));
         //   	alert(DS_DETAIL.NameValue(i,"SKU_CD"));
            	showMessage(StopSign, OK, "USER-1018", i,"사은품");
            	DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"SKU_CD") = "";  
                return;
            }
        }
        
        if(DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"SKU_CD") != "") {
        	var strStrCd   = LC_I_STR_CD.BindColVal;     
            var strEventCd = EM_I_EVENT_CD.Text;                                  // 행사코드 
            var strSkuCD = DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"SKU_CD");
            
             var goTo = "getSkuAmt";
             var action = "O";
             var parameters = "&strStrCd="   + encodeURIComponent(strStrCd)
                            + "&strEventCd=" + encodeURIComponent(strEventCd)
                            + "&strSkuCD="   + encodeURIComponent(strSkuCD);
             TR_MAIN.Action = "/mss/mcae408.mc?goTo=" + goTo + parameters;
             TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_SKU_GB=DS_SKU_GB)"; 
             TR_MAIN.StatusResetType= "2";
             TR_MAIN.Post();
             
             if(DS_SKU_GB.CountRow == 0) {
                 DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"BUY_COST_PRC") = "";
                 return;
             }
             else {
                DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"BUY_COST_PRC") = DS_SKU_GB.NameValue(DS_SKU_GB.RowPosition,"BUY_COST_PRC");
             }
        } 
           
    }

}
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=EM_S_EVENT_CD event=onKillFocus()>
  //  if (EM_O_EVENT_CD.Text.length > 0 ) { 
      if(!this.Modified)
                return;
                
            if(this.text==''){
                EM_S_EVENT_NAME.Text = "";
                return;
            }
         
            if(LC_S_STR_CD.BindColVal == "%"){
                showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
                LC_S_STR_CD.Focus();
                return;
            }
        
        setMssEvtNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_S_EVENT_CD, EM_S_EVENT_NAME, '', '', 'Y', LC_S_STR_CD.BindColVal);
        if (DS_O_RESULT.CountRow == 1 ) {  
            EM_S_EVENT_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_CD");
            EM_S_EVENT_NAME.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_NM");
        } else {
            //1건 이외의 내역이 조회 시 팝업 호출 
            mssEventPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NAME,'','','Y',LC_S_STR_CD.BindColVal, '', ''); 
        }
  //  }  
     
</script>

<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
    EM_S_EVENT_CD.Text = "";
    EM_S_EVENT_NAME.Text = "";
</script>

<script language=JavaScript for=EM_I_EVENT_CD event=onKillFocus()>
  //  if (EM_O_EVENT_CD.Text.length > 0 ) { 
      if(!this.Modified)
                return;
                
            if(this.text==''){
                EM_I_EVENT_NAME.Text = "";
                return;
            }
         
            if(LC_I_STR_CD.BindColVal == "%"){
                showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
                LC_I_STR_CD.Focus();
                return;
            }
        
        setMssEvtNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_I_EVENT_CD, EM_I_EVENT_NAME,EM_S_S_DT,EM_S_E_DT, 'Y', LC_I_STR_CD.BindColVal);
        if (DS_O_RESULT.CountRow == 1 ) {  
            EM_I_EVENT_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_CD");
            EM_I_EVENT_NAME.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_NM");
            EM_EVENT_S_DT.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_S_DT");
            EM_EVENT_E_DT.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_E_DT");
        } else {
            //1건 이외의 내역이 조회 시 팝업 호출 
            mssEventPop('SEL_STR_EVENT_POP',EM_I_EVENT_CD,EM_I_EVENT_NAME,EM_EVENT_S_DT, EM_EVENT_E_DT,'Y',LC_I_STR_CD.BindColVal, EM_S_S_DT.Text ,EM_S_E_DT.Text); 
        }
        getEventType();
         
        
  //  }  
     
</script>

<script language=JavaScript for=EM_I_EVENT_CD
	event=onKeyDown(kcode,scode)>
    if (EM_I_EVENT_CD.Text.length == 11 ){
     //   getEvent();
    } 
</script>

<script language=JavaScript for=DS_SKU_CD event=OnFilter(row)>
    if(DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"SKU_GB") != "") {
        if(DS_SKU_CD.NameValue(row,"SKU_GB").substring(0,1) == DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"SKU_GB")){ 
            return true;
        }
        else {
             return false;
        } 
    }
    else { 
        return;
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
<object id="DS_S_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_EVENT_TYPE" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_EVENT_GIFT_TYPE" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_DETAIL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RETURN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_EVENT" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script> 
<comment id="_NSID_">
<object id="DS_SKU_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script> 
<comment id="_NSID_">
<object id="DS_SKU_GB" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script> 

<comment id="_NSID_"><object id="DS_O_CHECK"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- 공통 -->
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
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
	<object	id="TR_MAIN3" classid=<%=Util.CLSID_TRANSACTION%>>
		<param name="KeyName" value="Toinb_dataid4">
	</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
    var obj   = document.getElementById("GD_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top2) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
    }
    obj.style.height  = grd_height + "px";
}
</script>


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
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
						<th width="60" class="point">점</th>
						<td width="120"><comment id="_NSID_"> <object
							id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 tabindex=1
							width=117 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						<th width="80" class="point">기간</th>
						<td width="200" align="absmiddle"><comment id="_NSID_">
						<object id=EM_S_S_DT classid=<%= Util.CLSID_EMEDIT %> width=70
							tabindex=1 align="absmiddle"
							onblur="javascript:checkDateTypeYMD(this);"> </object> </comment><script>_ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_S_DT)" /> ~ <comment
							id="_NSID_"> <object id=EM_S_E_DT
							classid=<%= Util.CLSID_EMEDIT %> width=70 tabindex=1
							align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_E_DT)" /></td>
						<th width="80">행사코드</th>
						<td><comment id="_NSID_"> <object id=EM_S_EVENT_CD
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							class="PR03"
							onclick="javascript:mssEventPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NAME,'','','Y',LC_S_STR_CD.BindColVal, '', '');"
							id=popEventS /> <comment id="_NSID_"> <object
							id=EM_S_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%> width=110
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
	<tr valign="top">
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td width="270" class="PL05">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="BD4A">
							<tr>
								<td><comment id="_NSID_"><OBJECT id=GD_MASTER
									width=100% height=505 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_MASTER">
								</OBJECT></comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
				<td width="5"></td>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="PT3">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
									align="absmiddle" class="PR03" />기타지급 마스터</td>
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
										<th width="80" class="point">점</th>
										<td width="130"><comment id="_NSID_"> <object
											id=LC_I_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 tabindex=1
											width=130 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
										</td>
										<th width="55" class="point">행사코드</th>
										<td><comment id="_NSID_"> <object
											id=EM_I_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=82
											tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
											align="absmiddle" class="PR03"
											onclick="javascript:mssEventPop('SEL_STR_EVENT_POP',EM_I_EVENT_CD,EM_I_EVENT_NAME,EM_EVENT_S_DT, EM_EVENT_E_DT,'Y',LC_I_STR_CD.BindColVal, EM_S_S_DT.Text ,EM_S_E_DT.Text); getEventType();"
											id=popEventI /> <comment id="_NSID_"> <object
											id=EM_I_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%> width=120
											tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th>사은행사유형</th>
										<td><comment id="_NSID_"> <object
											id=LC_EVENT_TYPE classid=<%= Util.CLSID_LUXECOMBO %>
											height=100 width=130 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
										</td>
								<comment id="_NSID_"  > 
									<object  style="display:none;"  id=EM_EVENT_GIFT_TYPE  classid=<%=Util.CLSID_EMEDIT%>	width="50"
										tabindex=1 align="absmiddle"> </object>
								</comment><script>_ws_(_NSID_);</script>
										<th>행사기간</th>
										<td align="absmiddle"><comment id="_NSID_"> <object
											id=EM_EVENT_S_DT classid=<%= Util.CLSID_EMEDIT %> width=107
											tabindex=1 align="absmiddle"
											onblur="javascript:checkDateTypeYMD(this);"> </object> </comment><script>_ws_(_NSID_);</script>
								 
										~ <comment id="_NSID_"> <object id=EM_EVENT_E_DT
											classid=<%= Util.CLSID_EMEDIT %> width=107 tabindex=1
											align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
										</object> </comment><script>_ws_(_NSID_);</script>  
										</td>
									</tr>
									<tr>
										<th class="point">기타지급일자</th>
										<td><comment id="_NSID_"> <object
											id=EM_INFRR_DT classid=<%= Util.CLSID_EMEDIT %> width=106
											tabindex=1 align="absmiddle"
											onblur="javascript:checkDateTypeYMD(this);"> </object> </comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
											onclick="javascript:openCal('G',EM_INFRR_DT)" id="imgFrr" />
										</td>
										<th>비고</th>
										<td><comment id="_NSID_"> <object id=EM_REMARK
											classid=<%= Util.CLSID_EMEDIT %> width=228 tabindex=1
											align="absmiddle" onkeyup="javascript:checkByteStr(this, 200, 'Y');"> </object> </comment><script>_ws_(_NSID_);</script></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="PL05">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="PT3">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td class="sub_title"><img
											src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11"
											height="12" align="absmiddle" class="PR03" />기타지급 상세</td>
										<td class="right PB03"><img
											src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18"
											hspace="2" id="Addrow" onClick="javascript:addRow();" /> <img
											src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
											id="Delrow" onClick="javascript:delRow();" /></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="BD4A">
									<tr>
										<td><comment id="_NSID_"><OBJECT id=GD_DETAIL
											width=100% height=388 classid=<%=Util.CLSID_GRID%>>
											<param name="DataID" value="DS_DETAIL">
										</OBJECT></comment><script>_ws_(_NSID_);</script></td>
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
</DIV>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
        <c>Col=STR_CD               Ctrl=LC_I_STR_CD         param=BindColVal</c>
        <c>Col=INFRR_DT             Ctrl=EM_INFRR_DT         param=Text</c> 
        <c>Col=EVENT_CD             Ctrl=EM_I_EVENT_CD       param=Text</c> 
        <c>Col=EVENT_NAME           Ctrl=EM_I_EVENT_NAME     param=Text</c> 
        <c>Col=EVENT_S_DT           Ctrl=EM_EVENT_S_DT       param=Text</c> 
        <c>Col=EVENT_E_DT           Ctrl=EM_EVENT_E_DT       param=Text</c> 
        <c>Col=EVENT_TYPE           Ctrl=LC_EVENT_TYPE       param=BindColVal</c>
        <c>Col=EVENT_GIFT_TYPE      Ctrl=EM_EVENT_GIFT_TYPE  param=Text</c>         
        <c>Col=REMARK               Ctrl=EM_REMARK           param=Text</c>   
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>  
</body>
</html>

