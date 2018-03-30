<!-- 
/*******************************************************************************
 * 시스템명	: 경영지원 > 사은행사관리 >	사은품 지급/취소 > 사은품지급등록
 * 작 성 일	: 2016.11.15
 * 작 성 자	: KHJ
 * 수 정 자	: 
 * 파 일 명	: MCAE4340.jsp
 * 버	 전	: 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개	 요	: 백화점의 각 점정보를 관리한다
 * 이	 력	:

 ******************************************************************************/
-->
<%@	page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@	taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@	taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@	taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@	taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인	유무, 기본설정												  *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet"	type="text/css">
<script	language="javascript" src="/<%=dir%>/js/common.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/gauce.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/global.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/message.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/popup.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/popup_mss.js"	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작														  *-->
<!--*************************************************************************-->

<script	LANGUAGE="JavaScript">


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var strUserID = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
var strUserNM = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />';
var strToday	 ="";

/**
 * doInit()
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: 해당 페이지 LOAD 시  
 * return값	: void
 */
 var top = 630;		//해당화면의 동적그리드top위치
 var evtcnt
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_CARD_EVENT"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	 var obj   = document.getElementById("GD_SKU_LIST_CARD"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	// Input Data Set Header 초기화
	
	DS_IO_SALE_INFO_TEMP.setDataHeader('<gauce:dataset name="H_SALE_INFO"/>');
	DS_IO_SALE_INFO_TEMP2.setDataHeader('<gauce:dataset	name="H_SALE_INFO"/>');

	DS_IO_SKU_LIST_ALL.setDataHeader('<gauce:dataset	name="H_SKU_LIST_ALL"/>');
	DS_IO_SKU_LIST.setDataHeader('<gauce:dataset	name="H_SKU_LIST"/>');
	DS_IO_SKU_LIST_CARD.setDataHeader('<gauce:dataset	name="H_SKU_LIST_CARD"/>');
	
	DS_O_CHECK.setDataHeader('<gauce:dataset name="H_GIFTCARD_NO_CHK"/>');

	DS_O_PB_EVENT.setDataHeader('<gauce:dataset name="H_PB_EVENT"/>');
	DS_O_PAID_EVENT.setDataHeader('<gauce:dataset name="H_PAID_EVENT"/>');
	DS_O_CARD_EVENT.setDataHeader('<gauce:dataset name="H_CARD_EVENT"/>');
	
	DS_O_RECEIPT.setDataHeader('<gauce:dataset name="H_RECEIPT"/>');
	DS_O_RECEIPT_ADD.setDataHeader('<gauce:dataset name="H_RECEIPT"/>');
	
	
	
	// Output Data Set Header 초기화
	
	//그리드 초기화	
	gridCreate();    //-- 사은행사 HIDDEN
	gridCreate7();   //영수증내역
	gridCreate4();   //브랜드사은행사
	gridCreate5();   //결제유형사은행사
	gridCreate6();   //제휴카드사은행사
	
	gridCreate2();   //지급품정보(중복지급) 
	gridCreate12();  //지급품정보(중복불가)
	gridCreate22();  //제휴카드행사 지급정보
	GD_SKU_LIST.TranslateKeyDown = 0;
	GD_SKU_LIST.TargetEnterKey = 2;
	GD_SKU_LIST_ALL.TranslateKeyDown = 0;
	GD_SKU_LIST_ALL.TargetEnterKey = 2;
	GD_SKU_LIST_CARD.TranslateKeyDown = 0;
	GD_SKU_LIST_CARD.TargetEnterKey = 2;
	
	gridCreate3();   // 상품권 등록 정보

	
	// EMedit에	초기화
	initEmEdit(EM_PRSNT_DT,	"TODAY", READ);													//지급일자
	initEmEdit(EM_PRSNT_CHAR_NM, "GEN",	READ);												//지급자

	//initEmEdit(EM_RECEIPT_NO, "GEN^24",	NORMAL);											//영수증번호
    initEmEdit(EM_RECEIPT_NO,    "000000000000000000000000", NORMAL);         //영수증번호
	
	//콤보 초기화                                                               			
	initComboStyle(LC_STR,DS_O_STR,	"CODE^0^30,NAME^0^80", 1, PK);							//점
	
	getEtcCode("DS_O_EXCP_PRSNT_RSN",	"D", "M073", "N");
	getStore("DS_O_STR", "Y", "1", "N"); 
	getEtcCode("DS_O_EVENT_GIFT_TYPE", "D",	"M033",	"N");
	
	LC_STR.Index = 0;
	EM_PRSNT_CHAR_NM.Text =	strUserNM;			//지급자			
	
	//chkExcp(true);
	strToday = getTodayDB("DS_O_RESULT");
	//--test용 strToday = addDate("d", -1, strToday, "");  //어제일자
	
	evtcnt = getEventInfo();
	//  alert(evtcnt);
 
	EM_PRSNT_DT.Text = strToday;
	EM_RECEIPT_NO.Focus();
   
	//setTimeout("EM_RECEIPT_NO.Focus()",50);
}

//-- 사은행사 HIDDEN
function gridCreate(){
	var	hdrProperies ='<FC>id={currow}		    name="NO"			    width=30	align=center</FC>'
					+ '<FC>id=STR_NM		    name="점"		        width=80	align=left		edit=none	</FC>'
					+ '<FC>id=EVENT_TYPE_NM		name="사은행사유형"		width=80	align=left	    edit=none	</FC>'
					+ '<FC>id=EVENT_NAME	    name="사은행사명"		width=80	align=left		edit=none	</FC>'
					+ '<FC>id=EVENT_S_DT		name="시작일자"		    width=80	align=center	edit=none	mask="XXXX/XX/XX"</FC>'
					+ '<FC>id=EVENT_E_DT		name="종료일자"	        width=80	align=center	edit=none	mask="XXXX/XX/XX" </FC>'
					+ '<FC>id=PC_EVENT_TYPE_NM	name="행사종류"		    width=80	align=left		edit=none	</FC>'
					+ '<FC>id=EVENT_GIFT_CYC	name="사은품지급주기"   width=100	align=left		edit=none	</FC>'
					+ '<FC>id=CUST_ONLY_YN	    name="보너스카드 ONLY"  width=100	align=left		edit=none	</FC>'
					+ '<FC>id=CARD_ONLY_YN	    name="신용카드 ONLY"	width=100	align=left		edit=none	</FC>'
					+ '<FC>id=RECP_ADD_YN	    name="영수증합산"		width=80	align=left		edit=none	</FC>'
					+ '<FC>id=RECP_YN   	    name="영수증당일여부"	width=100	align=left	    edit=none	</FC>';

	initGridStyle(GD_EVENT_INFO,	"common", hdrProperies,	true);
}



//영수증내역
function gridCreate7(){
	var	hdrProperies ='<FC>id={currow}		name="NO"			width=30	align=center</FC>'
					+ '<FC>id=STR_CD		name="점"		    width=80	align=left		edit=none	show=false  </FC>'
					+ '<FC>id=SALE_DT		name="판매일자"		width=100	align=center	edit=none	mask="XXXX/XX/XX"</FC>'
					+ '<FC>id=RECEIPT_NO    name="영수증번호"	width=200	align=center	edit=none	show=false  </FC>'
					+ '<FC>id=F_RECEIPT_NO  name="영수증번호"	width=230	align=center	edit=none	</FC>'
					+ '<FC>id=SALE_AMT_TAX	name="매출금액"		width=120	align=right		edit=none	sumtext=@sum</FC>';

	initGridStyle(GD_RECEIPT,	"common", hdrProperies,	true);
}


//--브랜드사은행사조회
function gridCreate4(){
	var	hdrProperies ='<FC>id={currow}		name="NO"			   width=30	    align=center</FC>'
					+ '<FC>id=STR_CD		name="점"		       width=80	    align=left		edit=none	show=false  </FC>'
					+ '<FC>id=EVENT_NM	    name="사은행사"		   width=120	align=left      edit=none	</FC>'
					+ '<FC>id=DBL_PAID_YN   name="중복지급"		   width=55	    align=center	edit=none	EditStyle=CheckBox </FC>'
					+ '<FC>id=SALE_AMT_TAX	name="매출금액"		   width=80	    align=right		edit=none	</FC>'
					+ '<FC>id=APP_RATE_AMT	name="인정금액"		   width=80	    align=right		edit=none	</FC>'
					+ '<FC>id=RECEIPT_CNT	name="RECEIPT_CNT"	   width=80	    align=right		edit=none	show=false  </FC>'
					+ '<FC>id=F_RECEIPT_NO	name="F_RECEIPT_NO"	   width=80	    align=right		edit=none	show=false  </FC>'
					;

	initGridStyle(GD_PB_EVENT,	"common", hdrProperies,	true);
}

//결제유형별사은행사
function gridCreate5(){
	var	hdrProperies ='<FC>id={currow}		  name="NO"			    width=30	align=center</FC>'
					+ '<FC>id=STR_CD		  name="점"		        width=80	align=left		edit=none	show=false  </FC>'
					+ '<FC>id=EVENT_NM	      name="사은행사"	    width=120	align=left  	edit=none	</FC>'
					+ '<FC>id=DBL_PAID_YN     name="중복지급"       width=55	align=center	edit=none	EditStyle=CheckBox </FC>'
					+ '<FC>id=PAY_TYPE_CASH	  name="상품권"   	    width=45	align=center	edit=none	EditStyle=CheckBox </FC>'
					+ '<FC>id=PAY_TYPE_CARD	  name="현금"		    width=45	align=center	edit=none	EditStyle=CheckBox </FC>'
					+ '<FC>id=PAY_TYPE_GIFT	  name="카드"		    width=45	align=center	edit=none	EditStyle=CheckBox </FC>'
					+ '<FC>id=SALE_AMT_TAX	  name="매출금액"	    width=80	align=right		edit=none	</FC>'
					+ '<FC>id=RECEIPT_CNT	name="RECEIPT_CNT"		width=80	align=right		edit=none	show=false  show=false  </FC>'
					+ '<FC>id=F_RECEIPT_NO	name="F_RECEIPT_NO"		width=80	align=right		edit=none	show=false  show=false  </FC>'
					;

	initGridStyle(GD_PAID_EVENT,	"common", hdrProperies,	true);
}

//카드사제휴생사
function gridCreate6(){
	var	hdrProperies ='<FC>id={currow}		name="NO"			    width=30	align=center</FC>'
					+ '<FC>id=STR_CD		name="점"		        width=80	align=left		edit=none	show=false  </FC>'
					+ '<FC>id=EVENT_NM	    name="사은행사"		    width=200	align=left		edit=none	</FC>'
					+ '<FC>id=DBL_PAID_YN   name="중복지급"		    width=55	align=center	edit=none	EditStyle=CheckBox    show=false </FC>'
					+ '<FC>id=CARD_PUBLISH  name="카드사"		    width=100	align=left		edit=none	show=false</FC>'
					+ '<FC>id=SALE_AMT_TAX	name="매출금액"		    width=80	align=right		edit=none	</FC>'
					+ '<FC>id=RECEIPT_CNT	name="RECEIPT_CNT"		width=80	align=right		edit=none	show=false  </FC>'
					+ '<FC>id=F_RECEIPT_NO	name="F_RECEIPT_NO"		width=80	align=right		edit=none	show=false  </FC>'
					;

	initGridStyle(GD_CARD_EVENT,	"common", hdrProperies,	true);
}


//지급품정보(중복지급) 
function gridCreate2(){
	var	hdrProperies ='<FC>id={currow}		name="NO"				width=30	align=center</FC>'
					+ '<FC>id=EVENT_NM	    name="사은행사"			width=100	align=left      edit=none	suppress=1  </FC>'
					+ '<FC>id=CHK			name="선택"				width=30	align=center	EditStyle=CheckBox	HeadCheck </FC>'
					+ '<FC>id=SKU_GB	    name="사은품종류"		width=65	align=center    edit=none	EditStyle=Lookup   Data="DS_O_EVENT_GIFT_TYPE:CODE:NAME" </FC>'					
					+ '<FC>id=TRG_NAME		name="대상범위"			width=80	align=left		edit=none   </FC>'
					+ '<FC>id=SKU_NAME		name="지급품명"			width=120	align=left		edit=none   </FC>'
					+ '<FC>id=BUY_COST_PRC	name="지급품금액"		width=90	align=rigth		edit=none   </FC>'
					+ '<FC>id=GIFTCARD_NO   name="상품권번호"   	width=100	edit={if(CHK="T",if(SKU_GB = "2", "true", "false"),"false")}   align=center   	</FC>'
					+ '<FC>id=GIFTCERT_AMT	name="상품권금액"   	width=90	align=rigth		edit=none	  </FC>'
					+ '<FC>id=RECEIPT_CNT	name="RECEIPT_CNT"		width=80	align=right		edit=none	show=false  </FC>'
					+ '<FC>id=F_RECEIPT_NO	name="F_RECEIPT_NO"		width=80	align=right		edit=none	show=false  </FC>'
					+ '<FC>id=GIFTCARD_CNT	name="수량"     	    width=60	align=rigth		edit=none	  </FC>'
					+ '<FC>id=GIFTCARD_LIST	name="상품권LIST"     	width=200	align=rigth		edit=none	  </FC>'
					;

	initGridStyle(GD_SKU_LIST_ALL, "common", hdrProperies,	true);
}

//지급품정보(중복불가)
function gridCreate12(){
	var	hdrProperies ='<FC>id={currow}		name="NO"				width=30	align=center</FC>'
		            + '<FC>id=EVENT_NM	    name="사은행사"			width=100	align=left      edit=none	suppress=1  </FC>'
					+ '<FC>id=CHK			name="선택"				width=30	align=center	EditStyle=CheckBox	HeadCheck  </FC>'
					+ '<FC>id=SKU_GB	    name="사은품종류"		width=65	align=center    edit=none	EditStyle=Lookup    Data="DS_O_EVENT_GIFT_TYPE:CODE:NAME"  </FC>'
					+ '<FC>id=TRG_NAME		name="대상범위"			width=80	align=left		edit=none   </FC>'
					+ '<FC>id=SKU_NAME		name="지급품명"			width=120	align=left		edit=none   </FC>'
					+ '<FC>id=BUY_COST_PRC	name="지급품금액"   	width=90	align=rigth		edit=none	</FC>'
					+ '<FC>id=GIFTCARD_NO   name="상품권번호"   	width=100	edit={if(CHK="T",if(SKU_GB = "2", "true", "false"),"false")}    align=center   	</FC>'
					+ '<FC>id=GIFTCERT_AMT	name="상품권금액"   	width=90	align=rigth		edit=none	  </FC>'
					+ '<FC>id=RECEIPT_CNT	name="RECEIPT_CNT"		width=80	align=right		edit=none	show=false  </FC>'
					+ '<FC>id=F_RECEIPT_NO	name="F_RECEIPT_NO"		width=80	align=right		edit=none	show=false  </FC>'
					+ '<FC>id=GIFTCARD_CNT	name="수량"     	    width=60	align=rigth		edit=none	  </FC>'
					+ '<FC>id=GIFTCARD_LIST	name="상품권LIST"     	width=200	align=rigth		edit=none	  </FC>'
					;
					
	initGridStyle(GD_SKU_LIST, "common", hdrProperies,	true);
}

//제휴카드행사 지급정보
function gridCreate22(){
	var	hdrProperies ='<FC>id={currow}		name="NO"				width=30	align=center</FC>'
		            + '<FC>id=EVENT_NM	    name="사은행사"			width=100	align=left      edit=none	suppress=1  </FC>'
					+ '<FC>id=CHK			name="선택"				width=30	align=center	EditStyle=CheckBox	HeadCheck </FC>'
					+ '<FC>id=SKU_GB	    name="사은품종류"		width=65	align=center    edit=none	EditStyle=Lookup    Data="DS_O_EVENT_GIFT_TYPE:CODE:NAME" </FC>'
					+ '<FC>id=TRG_NAME		name="대상범위"			width=80	align=left		edit=none   </FC>'
					+ '<FC>id=SKU_NAME		name="지급품명"			width=120	align=left		edit=none   </FC>'
					+ '<FC>id=BUY_COST_PRC	name="지급품금액"  		width=90	align=rigth		edit=none	</FC>'
					+ '<FC>id=GIFTCARD_NO   name="상품권번호"   	width=100	edit={if(CHK="T",if(SKU_GB = "2", "true", "false"),"false")}    align=center   	</FC>'
					+ '<FC>id=GIFTCERT_AMT	name="상품권금액"   	width=90	align=rigth		edit=none	  </FC>'
					+ '<FC>id=RECEIPT_CNT	name="RECEIPT_CNT"		width=80	align=right		edit=none	show=false  </FC>'
					+ '<FC>id=F_RECEIPT_NO	name="F_RECEIPT_NO"		width=80	align=right		edit=none	show=false  </FC>'
					+ '<FC>id=GIFTCARD_CNT	name="수량"     	    width=60	align=rigth		edit=none	  </FC>'
					+ '<FC>id=GIFTCARD_LIST	name="상품권LIST"     	width=200	align=rigth		edit=none	  </FC>'
					;
	initGridStyle(GD_SKU_LIST_CARD, "common", hdrProperies,	true);
}

function gridCreate3(){
	var	hdrProperies ='<FC>id={currow}		name="NO"			    width=30	align=center</FC>'
					+ '<FC>id=GIFTCARD_NO	name="상품권번호"		width=160	align=center	EditLimit="16" edit="Numeric"</FC>'
					+ '<FC>id=GIFTCERT_AMT	name="상품권금액"		width=100	align=left		ReadOnly =true sumtext=@sum</FC>';
	initGridStyle(GD_GIFTCARD_NO, "common",	hdrProperies, true);
	GD_GIFTCARD_NO.ViewSummary = "1";
}




/*************************************************************************
  *	2. 공통버튼
	 (1) 조회		- btn_Search(),	subQuery()
	 (2) 신규		- btn_New()
	 (3) 삭제		- btn_Delete()
	 (4) 저장		- btn_Save()
	 (5) 엑셀		- btn_Excel()
	 (6) 출력		- btn_Print()
	 (7) 확정		- btn_Conf()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: 조회시 호출
 * return값	: void
 */
function btn_Search() {
}

/**
 * btn_New()
 * 작 성 자	: 김성미
 * 작 성 일	: 2011-03-08
 * 개	 요	:영수증정보, 지급품정보	예외지급정보 초기화
 * return값	: void
 */
function btn_New() {

	DS_O_RECEIPT.ClearData();        // 브랜드사은합산정보
	DS_O_RECEIPT_ADD.ClearData();    // 브랜드사은합산정보
	
	DS_O_PB_EVENT.ClearData();        // 브랜드사은행사
	DS_O_PAID_EVENT.ClearData();      // 결제유형별사은행사
	DS_O_CARD_EVENT.ClearData();      // 제휴카드사은행사
	
	DS_IO_SKU_LIST_ALL.ClearData();       // 지급품정보(중복지급) 
	DS_IO_SKU_LIST.ClearData();           // 지급품정보(중복불가)
	DS_IO_SKU_LIST_CARD.ClearData();      // 제휴카드행사 지급정보
	
	DS_O_CHECK.ClearData();               // 상품권번호체크 
	
	EM_RECEIPT_NO.Text = "";
	EM_RECEIPT_NO.Focus();
	
}

/**
 * btn_Delete()
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: Grid 레코드 삭제
 * return값	: void
 */
function btn_Delete() {
}


/**
 * btn_Save()
 * 작 성 자	: 김성미
 * 작 성 일	: 2011-03-09
 * 개	 요	: 사은품 지급 등록
 * return값	: void
 */


function btn_Save() {
	// 영수증정보가 없는경우
	if (DS_O_RECEIPT_ADD.CountRow == 0){
		//저장할 내용이 없습니다
		showMessage(EXCLAMATION , OK, "USER-1028");
		return;
	}
	//브랜드 영수증 정보
	if (DS_O_PB_EVENT.CountRow == 0 && DS_O_PAID_EVENT.CountRow == 0 && DS_O_CARD_EVENT.CountRow == 0){
		//저장할 내용이 없습니다
		showMessage(EXCLAMATION , OK, "USER-1000", "지급할 행사 내용이 없습니다.");
		return;
	}


    // 저장할 내용이 없습니다.
    if (!DS_IO_SKU_LIST_ALL.IsUpdated && !DS_IO_SKU_LIST.IsUpdated && !DS_IO_SKU_LIST_CARD.IsUpdated){
        showMessage(INFORMATION, OK, "USER-1028");
        return false;
    }

	var strCnt = 0;
	var strCardCnt = 0;
	
	var strSKU_GB = "";
	var strGiftCardNo = "";
	var nGiftCertAmt  = 0;
	var strGiftCardList = "";
	
	var strGiftCardNo_a ="";
	var strGiftCardNo_b ="";
	
	
	// 지급품정보(중복지급) 데이터 체크 시작
	for(var i=1;i<=DS_IO_SKU_LIST_ALL.CountRow;i++){
		if(DS_IO_SKU_LIST_ALL.NameValue(i,"CHK") == "T"){
            
			strSKU_GB = DS_IO_SKU_LIST_ALL.NameValue(i, "SKU_GB");		//사은품종료 =2:상품권
            
            if (strSKU_GB =="2"){             	
                strGiftCardNo = DS_IO_SKU_LIST_ALL.NameValue(i, "GIFTCARD_NO");		// 상품권번호
                nBUY_COST_PRC  = DS_IO_SKU_LIST_ALL.NameValue(i, "BUY_COST_PRC");	// 지급품금액
                nGiftCertAmt  = DS_IO_SKU_LIST_ALL.NameValue(i, "GIFTCERT_AMT");	// 상품권 금액
                strGiftCardList = DS_IO_SKU_LIST_ALL.NameValue(i, "GIFTCARD_LIST");		// 상품권번호LIST
                
                if(strGiftCardList.length == 0){
    				showMessage(INFORMATION, OK, "USER-1000", "상품권번호를 입력하세요.");
                	setFocusGrid(GD_SKU_LIST_ALL, DS_IO_SKU_LIST_ALL, i, "GIFTCARD_NO");
                    return false;
        		}
                
//         		if(strGiftCardNo.length != 12){
//     				showMessage(INFORMATION, OK, "USER-1000", "상품권 자리수는 12자리입니다");
//                 	setFocusGrid(GD_SKU_LIST_ALL, DS_IO_SKU_LIST_ALL, i, "GIFTCARD_NO");
//                     return false;
//         		}
                
//             	if (chkGiftCardNo("DS_IO_SKU_LIST_ALL", i) == false) {
//                    	setFocusGrid(GD_SKU_LIST_ALL, DS_IO_SKU_LIST_ALL, i, "GIFTCARD_NO");
//                     return false;
//             	}
	       		
        		if(nGiftCertAmt == 0){
    				showMessage(INFORMATION, OK, "USER-1000", "상품권금액이 0입니다. 상품권을 확인하십시오.");
                	setFocusGrid(GD_SKU_LIST_ALL, DS_IO_SKU_LIST_ALL, i, "GIFTCARD_NO");
                    return false;
        		}
        		

        		if(nGiftCertAmt != nBUY_COST_PRC){
    				showMessage(INFORMATION, OK, "USER-1000", "지급품금액과 입력 상품권금액이 같지않습니다. 확인하세요");
                	setFocusGrid(GD_SKU_LIST_ALL, DS_IO_SKU_LIST_ALL, i, "GIFTCARD_NO");
                    return false;
        		}

                // 중복체크(상품권번호)
//                 if(gfnCheckDup(DS_IO_SKU_LIST_ALL, strGiftCardNo, "GIFTCARD_NO") > 1){
//                 	DS_IO_SKU_LIST_ALL.Rowposition = i;
//                     showMessage(INFORMATION, Ok, "USER-1000", "중복된 상품권번호(" + strGiftCardNo + ")가 존재합니다.");
//                 	setFocusGrid(GD_SKU_LIST_ALL, DS_IO_SKU_LIST_ALL, i, "GIFTCARD_NO");
//                     return false;
//                 }
                
            	// 지급품정보(중복지급불가) 데이터 체크 시작
//             	for(var a=1;a<=DS_IO_SKU_LIST.CountRow;a++){
            		   
//             		if(DS_IO_SKU_LIST.NameValue(a,"CHK") == "T"){
//                 		if(DS_IO_SKU_LIST.NameValue(a,"SKU_GB") == "2"){
//                 			strGiftCardNo_a = DS_IO_SKU_LIST.NameValue(a, "GIFTCARD_NO");		// 상품권번호             			
//                 			if(strGiftCardNo == strGiftCardNo_a){
//                                 showMessage(INFORMATION, Ok, "USER-1000", "지급품정보(중복불가) 내역 " + a + "번째에 중복된 상품권번호("  + strGiftCardNo + ")가 존재합니다.");
//                             	setFocusGrid(GD_SKU_LIST_ALL, DS_IO_SKU_LIST_ALL, i, "GIFTCARD_NO");
//                                 return false;
//                 				break;
//                 			}
                			
//                 		}
//             		}
//             	}
                
            	// 제휴카드행사지급정보 데이터 체크 시작
//             	for(var b=1;b<=DS_IO_SKU_LIST_CARD.CountRow;b++){
//             		if(DS_IO_SKU_LIST_CARD.NameValue(b,"CHK") == "T"){
//                 		if(DS_IO_SKU_LIST_CARD.NameValue(b,"SKU_GB") == "2"){
//                 			strGiftCardNo_b = DS_IO_SKU_LIST_CARD.NameValue(b, "GIFTCARD_NO");		// 상품권번호
//                 			if(strGiftCardNo == strGiftCardNo_b){
//                                 showMessage(INFORMATION, Ok, "USER-1000", "지급품정보(중복불가) 내역 " + b + "번째에 중복된 상품권번호("  + strGiftCardNo + ")가 존재합니다.");
//                             	setFocusGrid(GD_SKU_LIST_ALL, DS_IO_SKU_LIST_ALL, i, "GIFTCARD_NO");
//                                 return false;
//                 				break;
                				
//                 			}
                			
//                 		}
//             		}
//             	}
                
                
            }
		}
	}


	// 지급품정보(중복불가) 데이터 체크 시작
	for(var i=1;i<=DS_IO_SKU_LIST.CountRow;i++){
		if(DS_IO_SKU_LIST.NameValue(i,"CHK") == "T"){
            
			strSKU_GB = DS_IO_SKU_LIST.NameValue(i, "SKU_GB");		//사은품종료 =2:상품권
            
            if (strSKU_GB =="2"){             	
                strGiftCardNo = DS_IO_SKU_LIST.NameValue(i, "GIFTCARD_NO");		// 상품권번호
                nBUY_COST_PRC  = DS_IO_SKU_LIST.NameValue(i, "BUY_COST_PRC");	// 지급품금액
                nGiftCertAmt  = DS_IO_SKU_LIST.NameValue(i, "GIFTCERT_AMT");	// 상품권 금액
                strGiftCardList = DS_IO_SKU_LIST.NameValue(i, "GIFTCARD_LIST");		// 상품권번호LIST

//         		if(strGiftCardNo.length != 12){
//     				showMessage(INFORMATION, OK, "USER-1000", "상품권 자리수는 12자리입니다");
//                 	setFocusGrid(GD_SKU_LIST, DS_IO_SKU_LIST, i, "GIFTCARD_NO");
//                     return false;
//         		}
                
//             	if (chkGiftCardNo("DS_IO_SKU_LIST", i) == false) {
//                 	setFocusGrid(GD_SKU_LIST, DS_IO_SKU_LIST, i, "GIFTCARD_NO");
//                     return false;
//             	}
	       		

        		if(nGiftCertAmt == 0){
    				showMessage(INFORMATION, OK, "USER-1000", "상품권금액이 0입니다. 상품권을 확인하십시오.");
                	setFocusGrid(GD_SKU_LIST, DS_IO_SKU_LIST, i, "GIFTCARD_NO");
                    return false;
        		}
        		

        		if(nGiftCertAmt != nBUY_COST_PRC){
    				showMessage(INFORMATION, OK, "USER-1000", "지급품금액과 입력 상품권금액이 같지않습니다. 확인하세요");
                	setFocusGrid(GD_SKU_LIST, DS_IO_SKU_LIST, i, "GIFTCARD_NO");
                    return false;
        		}

                // 중복체크(상품권번호)
//                 if(gfnCheckDup(DS_IO_SKU_LIST, strGiftCardNo, "GIFTCARD_NO") > 1){
//                 	DS_IO_SKU_LIST.Rowposition = i;
//                     showMessage(INFORMATION, Ok, "USER-1000", "중복된 상품권번호(" + strGiftCardNo + ")가 존재합니다.");
//                 	setFocusGrid(GD_SKU_LIST, DS_IO_SKU_LIST, i, "GIFTCARD_NO");
//                     return false;
//                 }
                
            	// 제휴카드행사지급정보 데이터 체크 시작
//             	for(var b=1;b<=DS_IO_SKU_LIST_CARD.CountRow;b++){
//             		if(DS_IO_SKU_LIST_CARD.NameValue(b,"CHK") == "T"){
//                 		if(DS_IO_SKU_LIST_CARD.NameValue(b,"SKU_GB") == "2"){
//                 			strGiftCardNo_b = DS_IO_SKU_LIST_CARD.NameValue(b, "GIFTCARD_NO");		// 상품권번호
//                 			if(strGiftCardNo == strGiftCardNo_b){
//                                 showMessage(INFORMATION, Ok, "USER-1000", "지급품정보(중복불가) 내역 " + b + "번째에 중복된 상품권번호("  + strGiftCardNo + ")가 존재합니다.");
//                             	setFocusGrid(GD_SKU_LIST, DS_IO_SKU_LIST, i, "GIFTCARD_NO");
//                                 return false;
//                 				break;
                				
//                 			}
                			
//                 		}
//             		}
//             	}
                
                
            }
		}
	}
    

	// 지급품정보(중복불가) 데이터 체크 시작
	for(var i=1;i<=DS_IO_SKU_LIST_CARD.CountRow;i++){
		if(DS_IO_SKU_LIST_CARD.NameValue(i,"CHK") == "T"){
            
			strSKU_GB = DS_IO_SKU_LIST_CARD.NameValue(i, "SKU_GB");		//사은품종료 =2:상품권
            
            if (strSKU_GB =="2"){             	
                strGiftCardNo = DS_IO_SKU_LIST_CARD.NameValue(i, "GIFTCARD_NO");		// 상품권번호
                nBUY_COST_PRC  = DS_IO_SKU_LIST_CARD.NameValue(i, "BUY_COST_PRC");	    // 지급품금액
                nGiftCertAmt  = DS_IO_SKU_LIST_CARD.NameValue(i, "GIFTCERT_AMT");	    // 상품권 금액
                strGiftCardList = DS_IO_SKU_LIST.NameValue(i, "GIFTCARD_LIST");		// 상품권번호LIST
				
               //---필수입력이 아님
//         		if(strGiftCardNo.length != 0 && strGiftCardNo.length != 12){
//     				showMessage(INFORMATION, OK, "USER-1000", "상품권 자리수는 12자리입니다");
//                 	setFocusGrid(GD_SKU_LIST_CARD, DS_IO_SKU_LIST_CARD, i, "GIFTCARD_NO");
//                     return false;
//         		}
                
//             	if (chkGiftCardNo("DS_IO_SKU_LIST_CARD", i) == false) {
//                 	setFocusGrid(GD_SKU_LIST_CARD, DS_IO_SKU_LIST_CARD, i, "GIFTCARD_NO");
//                     return false;
//             	}
	       		
//---필수입력이 아님
//         		if(nGiftCertAmt == 0){
//     				showMessage(INFORMATION, OK, "USER-1000", "상품권금액이 0입니다. 상품권을 확인하십시오.");
//                 	setFocusGrid(GD_SKU_LIST_CARD, DS_IO_SKU_LIST_CARD, i, "GIFTCARD_NO");
//                  return false;
//         		}        		

//         		if(nGiftCertAmt != nBUY_COST_PRC){
//     				showMessage(INFORMATION, OK, "USER-1000", "지급품금액과 입력 상품권 금액이 같지않습니다. 확인하세요");
//                 	setFocusGrid(GD_SKU_LIST_CARD, DS_IO_SKU_LIST_CARD, i, "GIFTCARD_NO");
//                     return false;
//         		}
        		
//                 // 중복체크(상품권번호)
//                 if(gfnCheckDup(DS_IO_SKU_LIST_CARD, strGiftCardNo, "GIFTCARD_NO") > 1){
//                 	DS_IO_SKU_LIST_CARD.Rowposition = i;
//                     showMessage(INFORMATION, Ok, "USER-1000", "중복된 상품권번호(" + strGiftCardNo + ")가 존재합니다.");
//                 	setFocusGrid(GD_SKU_LIST_CARD, DS_IO_SKU_LIST_CARD, i, "GIFTCARD_NO");
//                     return false;
//                 }
            }
		}
	}
	
	if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
	
	var strParams = "&strPrsntDt="			+ encodeURIComponent(EM_PRSNT_DT.Text)
				  + "&strTrgCd="			+ encodeURIComponent(HD_TRG_CD.Value)
				  + "&strBuyCostPrc="		+ encodeURIComponent(HD_BUY_COST_PRC.Value)
				  + "&strCardCustId="		+ encodeURIComponent(DS_O_CARD_INFO.NameValue(1,"CUST_ID"))
				  + "&strEventType="		+ encodeURIComponent(DS_O_EVENT_INFO.NameValue(1,"EVENT_TYPE"));
	
	TR_MAIN.Action="/mss/mcae434.mc?goTo=save"+strParams; 
	TR_MAIN.KeyValue="SERVLET(I:DS_IO_SKU_LIST_ALL=DS_IO_SKU_LIST_ALL,I:DS_IO_SKU_LIST=DS_IO_SKU_LIST,I:DS_IO_SKU_LIST_CARD=DS_IO_SKU_LIST_CARD)";  
	TR_MAIN.Post();
				
	
	//doInit();
	if(TR_MAIN.ErrorCode == 0 ) btn_New();
}

 
/**
 * btn_Excel()
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: 엑셀로 다운로드
 * return값	: void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: 페이지 프린트	인쇄
 * return값	: void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자	: 
 * 작 성 일	: 2010-12-12
 * 개	 요	: 확정 처리
 * return값	: void
 */

function btn_Conf()	{

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
/**
 * getEventCombo()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-07
 * 개	  요 : 화면	로딩시 사은행사	정보 조회 
 * return값 : void
 */

function getEventCombo(){
	DS_O_EVENT_INFO.ClearData();

	DS_IO_SKU_LIST.ClearData();
	DS_IO_SKU_LIST_CARD.ClearData();
	
	DS_O_CARD_COMP.ClearData();
	
	// 조회조건 셋팅
	var strStrCd	= LC_STR.BindColVal;
	var strPrsntDt	= EM_PRSNT_DT.Text;
	
	var parameters	= "&strStrCd="  + encodeURIComponent(strStrCd)
					+ "&strPrsntDt="+ encodeURIComponent(strPrsntDt);
	
	TR_MAIN.Action="/mss/mcae434.mc?goTo=getEventCombo"+parameters;	
	TR_MAIN.KeyValue="SERVLET(O:DS_O_EVENT_COMBO=DS_O_EVENT_COMBO)";	//조회는 O
	TR_MAIN.Post();
	
	if(DS_O_EVENT_COMBO.CountRow	== 0){
	showMessage(EXCLAMATION , OK, "USER-1000", "조건에 맞는 사은행사	내용이 없습니다.(getEventCombo)");
	EM_RECEIPT_NO.Text		= "";

	EM_RECEIPT_NO.Enable	= false;
	
	}else{

	}
}

/**
 *	getEventInfo()
 *	작 성 자 : 
 *	작 성 일 : 2011-03-07
 *	개	  요 : 화면 로딩시 사은행사 정보 조회 
 *	return값 : void
 */

function getEventInfo() {
	DS_O_EVENT_INFO.ClearData();

	DS_IO_SKU_LIST.ClearData();
	DS_IO_SKU_LIST_CARD.ClearData();
	
	DS_O_CARD_COMP.ClearData();
	

	DS_O_PB_EVENT.ClearData();         // 브랜드사은행사조회
	DS_O_PAID_EVENT.ClearData();       // 결제유형별사은행사조회
	
	// 조회조건 셋팅
	var strStrCd	= LC_STR.BindColVal;
	var strPrsntDt	= EM_PRSNT_DT.Text;
	
	var parameters	= "&strStrCd="  + encodeURIComponent(strStrCd)
					+ "&strPrsntDt="+ encodeURIComponent(strPrsntDt)
;
	
	TR_MAIN.Action="/mss/mcae434.mc?goTo=getEventInfo"+parameters;  
	TR_MAIN.KeyValue="SERVLET(O:DS_O_EVENT_INFO=DS_O_EVENT_INFO)"; //조회는 O
	TR_MAIN.Post();
	
	if(DS_O_EVENT_INFO.CountRow == 0){
		showMessage(EXCLAMATION , OK, "USER-1000", "현재 진행중인 사은행사 내용이 없습니다.(getEventInfo)");
		EM_RECEIPT_NO.Text		= "";

		EM_RECEIPT_NO.Enable	= false;
		
		return DS_O_EVENT_INFO.CountRow; 

	}else{
		EM_RECEIPT_NO.Enable	= true;

		DS_O_EVENT_INFO.UserStatus(1) = 1;
		
		return DS_O_EVENT_INFO.CountRow;
	}
	

}


/**
 *	getPbSaleInfo()
 *	작 성 자 : 
 *	작 성 일 : 2011-03-07
 *	개	  요 : 영수증 번호 행사별 해당 매출 조회 
 *	return값 : void
*/

function getPbSaleInfo(){
	
	DS_O_PB_EVENT.ClearData();        // 브랜드사은행사
	DS_O_PAID_EVENT.ClearData();      // 결제유형별사은행사
	DS_O_CARD_EVENT.ClearData();      // 제휴카드사은행사
	
	for(var	i=1;i<=DS_O_RECEIPT_ADD.CountRow;i++){			
		DS_O_RECEIPT_ADD.UserStatus(i) = 1;
	}	
		
	// 조회조건 셋팅	
	var strReceiptNo	= EM_RECEIPT_NO.Text;
	var strPrsntDt	    = EM_PRSNT_DT.Text;
	var strStrCd_org	= LC_STR.BindColVal;
	var strStrCd		= strReceiptNo.substring(11,13);	
	var strSaleDt		= strReceiptNo.substring(0,8);
	var strPosNo		= strReceiptNo.substring(13,17);
	var strTranNo		= strReceiptNo.substring(17,22);
	var strSaleGbn  	= strReceiptNo.substring(22,23);

	// 브랜드행사 매출/인정금액 조회
	var parameters = "&strPrsntDt="  + encodeURIComponent(strPrsntDt)
	 			   + "&strStrCd="    + encodeURIComponent(strStrCd)
				   + "&strSaleDt="   + encodeURIComponent(strSaleDt)
				   + "&strPosNo="    + encodeURIComponent(strPosNo)
				   + "&strTranNo="   + encodeURIComponent(strTranNo)
					;	

	TR_MAIN.Action="/mss/mcae434.mc?goTo=getPbSaleInfo_all"+parameters; 
	TR_MAIN.KeyValue="SERVLET(O:DS_O_PB_EVENT=DS_O_PB_EVENT, O:DS_O_PAID_EVENT=DS_O_PAID_EVENT,  O:DS_O_CARD_EVENT=DS_O_CARD_EVENT, I:DS_O_RECEIPT_ADD=DS_O_RECEIPT_ADD)"; //조회는 O	
	TR_MAIN.Post();	
}


/**
 *	getSaleInfo()
 *	작 성 자 : 
 *	작 성 일 : 2011-03-07
 *	개	  요 : 영수증 번호 스캔시 영수증 정보 조회
 *	return값 : void
*/

function getSaleInfo(){

	DS_O_PB_EVENT.ClearData();        // 브랜드사은행사
	DS_O_PAID_EVENT.ClearData();      // 결제유형별사은행사
	  
	// 조회조건 셋팅	
	var strReceiptNo	= EM_RECEIPT_NO.Text;
	var strStrCd		= LC_STR.BindColVal;
	var strSaleDt		= strReceiptNo.substring(0,8);
	var strPosNo		= strReceiptNo.substring(8,12);
	var strTranNo		= strReceiptNo.substring(12,17);

	var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
				   + "&strSaleDt="   + encodeURIComponent(strSaleDt)
				   + "&strPosNo="    + encodeURIComponent(strPosNo)
				   + "&strTranNo="   + encodeURIComponent(strTranNo)
					;	

	TR_MAIN.Action="/mss/mcae434.mc?goTo=getPbSaleInfo"+parameters; 
	TR_MAIN.KeyValue="SERVLET(O:DS_O_PB_EVENT=DS_O_PB_EVENT, O:DS_O_PAID_EVENT=DS_O_PAID_EVENT, I:DS_O_RECEIPT_ADD=DS_O_RECEIPT_ADD)"; //조회는 O	
	TR_MAIN.Post();
}



/**
 *	getSaleInfo_Per()
 *	작 성 자 : 
 *	작 성 일 : 2011-03-07
 *	개	  요 : 지난영수증 조회 - 당일지급이벤트는 제외
 *	return값 : void
*/

function getSaleInfo_Per(){
	 
	DS_O_PB_EVENT.ClearData();        // 브랜드행사정보
	DS_O_PAID_EVENT.ClearData();      // 결제유형별행사정보
	DS_O_CARD_EVENT.CearData();      // 제휴카드행사
	  
	// 조회조건 셋팅	
	var strReceiptNo	= EM_RECEIPT_NO.Text;
	var strStrCd		= LC_STR.BindColVal;
	var strSaleDt		= strReceiptNo.substring(0,8);
	var strPosNo		= strReceiptNo.substring(8,12);
	var strTranNo		= strReceiptNo.substring(12,17);

	var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
				   + "&strSaleDt="   + encodeURIComponent(strSaleDt)
				   + "&strPosNo="    + encodeURIComponent(strPosNo)
				   + "&strTranNo="   + encodeURIComponent(strTranNo)
					;	

	TR_MAIN.Action="/mss/mcae434.mc?goTo=getPbSaleInfo_Per"+parameters; 
	TR_MAIN.KeyValue="SERVLET(O:DS_O_PB_EVENT=DS_O_PB_EVENT, O:DS_O_PAID_EVENT=DS_O_PAID_EVENT, I:DS_O_RECEIPT_ADD=DS_O_RECEIPT_ADD)"; //조회는 O	
	TR_MAIN.Post();
	
}

/**
 *	getSaleInfo2()
 *	작 성 자 : 
 *	작 성 일 : 2011-03-07
 *	개	  요 : 카드 번호 스캔시 영수증 정보 조회
 *	return값 : void
 */

function getSaleInfo2(){

	if(DS_O_EVENT_INFO.CountRow == 0){
		showMessage(EXCLAMATION ,	OK,	"USER-1000", "행사 정보를 확인하세요.(카드)");
		return;
	}
	
	// 조회조건 셋팅
	var strEventCd	  =	"";  //EM_EVENT_CD.Text;
	var strStrCd		  =	DS_O_EVENT_INFO.NameValue(1,"STR_CD"); //strReceiptNo.substring(1,3);
	
	
	var parameters =	"&strStrCd="  + encodeURIComponent(strStrCd)
					  +	"&strEventCd="+ encodeURIComponent(strEventCd)
					  +	"&strCustId=" + encodeURIComponent(DS_O_CARD_INFO.NameValue(1,"CUST_ID"));

	TR_MAIN.Action="/mss/mcae434.mc?goTo=getSaleInfo2"+parameters; 
	TR_MAIN.KeyValue="SERVLET(O:DS_IO_SALE_INFO_TMP=DS_IO_SALE_INFO_TMP)"; //조회는 O
	TR_MAIN.Post();
	
	if(DS_IO_SALE_INFO.CountRow > 0){
		// 중복 영수증 내용 체크 - 01: 단독, 03: D3 카드 행사
		for(var i=1;i<=DS_IO_SALE_INFO_TMP.CountRow;i++){
			for(var j=1;j<=DS_IO_SALE_INFO.CountRow;j++){
				if(DS_IO_SALE_INFO_TMP.NameValue(i,"STR_CD") == DS_IO_SALE_INFO.NameValue(j,"STR_CD")
						&& DS_IO_SALE_INFO_TMP.NameValue(i,"SALE_DT") == DS_IO_SALE_INFO.NameValue(j,"SALE_DT")
						&& DS_IO_SALE_INFO_TMP.NameValue(i,"POS_NO")  == DS_IO_SALE_INFO.NameValue(j,"POS_NO")
						&& DS_IO_SALE_INFO_TMP.NameValue(i,"TRAN_NO") == DS_IO_SALE_INFO.NameValue(j,"TRAN_NO")){
					// 영수증 중복체크 
					DS_IO_SALE_INFO_TMP.DeleteRow(i);
					i -=1;
				}
			}
		}
	}

	if(DS_IO_SALE_INFO_TMP.CountRow == 0 ){
		showMessage(EXCLAMATION , OK, "USER-1000", "지급대상 영수증이 없습니다.(카드)");
		
	}else{
		var strData = DS_IO_SALE_INFO_TMP.ExportData(1,DS_IO_SALE_INFO_TMP.CountRow, true);
		DS_IO_SALE_INFO.ImportData(strData);

		setDivAmt();
	}
}

/**
 *	getSkuList()
 *	작 성 자 : 
 *	작 성 일 : 2011-03-07
 *	개	  요 : 지급품조회
 *	return값 : void
 */

function getSkuList() {
		
	DS_IO_SKU_LIST.ClearData();
	DS_IO_SKU_LIST_ALL.ClearData();
	DS_IO_SKU_LIST_CARD.ClearData();


	for(var	i=1;i<=DS_O_RECEIPT_ADD.CountRow;i++){			
		DS_O_RECEIPT_ADD.UserStatus(i) = 1;
	}	
		
	for(var	i=1;i<=DS_O_PB_EVENT.CountRow;i++){			
		DS_O_PB_EVENT.UserStatus(i) = 1;
	}		

	for(var	i=1;i<=DS_O_PAID_EVENT.CountRow;i++){			
		DS_O_PAID_EVENT.UserStatus(i) = 1;
	}	

	for(var	i=1;i<=DS_O_CARD_EVENT.CountRow;i++){			
		DS_O_CARD_EVENT.UserStatus(i) = 1;
	}	
	
	// 조회조건 셋팅
	var strStrCd		= LC_STR.BindColVal;
	
	var parameters = "&strStrCd="     + encodeURIComponent(strStrCd);
	
	TR_MAIN.Action="/mss/mcae434.mc?goTo=getSkuList"+parameters;	 
	TR_MAIN.KeyValue="SERVLET(I:DS_O_PB_EVENT=DS_O_PB_EVENT, I:DS_O_PAID_EVENT=DS_O_PAID_EVENT, I:DS_O_CARD_EVENT=DS_O_CARD_EVENT, O:DS_IO_SKU_LIST_ALL=DS_IO_SKU_LIST_ALL, O:DS_IO_SKU_LIST=DS_IO_SKU_LIST, O:DS_IO_SKU_LIST_CARD=DS_IO_SKU_LIST_CARD)";	//조회는 O
	TR_MAIN.Post();

	var strEventCd = "";
	var strEventCd_i = "";
	
	for(var i=1;i<=DS_IO_SKU_LIST_ALL.CountRow;i++){

		var strEventCd_i = DS_IO_SKU_LIST_ALL.NameValue(i, "EVENT_CD");
		
		if (strEventCd_i != strEventCd) {
			DS_IO_SKU_LIST_ALL.NameValue(i,"CHK") = "T";			
		}

		var strEventCd = DS_IO_SKU_LIST_ALL.NameValue(i, "EVENT_CD");
		
    }
	
	DS_IO_SKU_LIST.NameValue(1,"CHK") = "T";
	
	strEventCd = "";
	strEventCd_i = "";
	for(var i=1;i<=DS_IO_SKU_LIST_CARD.CountRow;i++){

		var strEventCd_i = DS_IO_SKU_LIST_CARD.NameValue(i, "EVENT_CD");
		
		if (strEventCd_i != strEventCd) {
			DS_IO_SKU_LIST_CARD.NameValue(i,"CHK") = "T";			
		}

		var strEventCd = DS_IO_SKU_LIST_CARD.NameValue(i, "EVENT_CD");
		
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
	
	TR_MAIN3.Action="/mss/mcae434.mc?goTo="+goTo+parameters;  
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
 *	getGiftCardNo()
 *	작 성 자 : 홍종영
 *	작 성 일 : 2012-05-29
 *	개	  요 : 상품권 조회
 *	return값 : void
 */ 
function getGiftCardNo() {
/*
	var goTo		= "getGiftCardNo";
	var action		= "O";
	//var parameters = "&strGiftCardNo="+encodeURIComponent(strGiftCardNo);
	
	TR_MAIN2.Action="/mss/mcae434.mc?goTo="+goTo;
	TR_MAIN2.KeyValue="SERVLET("+action+":DS_IO_GIFTCARD_NO=DS_IO_GIFTCARD_NO)";
	TR_MAIN2.Post();
	
	setPorcCount("SELECT", GD_GIFTCARD_NO);
	*/
}

/**
 * btn_AddRow()
 * 작 성 자	: HJY
 * 작 성 일	: 2012.05.29
 * 개	 요	: 행 추가
 * return값	:
 */

function btn_AddRow() {
	 /*
	if (DS_IO_SKU_LIST.NameValue(DS_IO_SKU_LIST.RowPosition,"CHK") == "T" && 
			DS_IO_SKU_LIST.NameValue(DS_IO_SKU_LIST.RowPosition,"SKU_GB") == "2") {
		if(DS_IO_SKU_LIST.NameValue(DS_IO_SKU_LIST.RowPosition,"GIFTCERT_AMT") > DS_IO_GIFTCARD_NO.NameSum("GIFTCERT_AMT",0,0)){
			if(DS_IO_GIFTCARD_NO.NameValue(DS_IO_GIFTCARD_NO.CountRow,"GIFTCARD_NO") == ""){
				showMessage(STOPSIGN, OK, "USER-1000", "상품권 번호를 입력하셔야 됩니다");
				setFocusGrid(GD_GIFTCARD_NO, DS_IO_GIFTCARD_NO, DS_IO_GIFTCARD_NO.CountRow , "GIFTCARD_NO");
			}else{
				if(DS_IO_GIFTCARD_NO.NameValue(DS_IO_GIFTCARD_NO.CountRow,"GIFTCERT_AMT") == ""){
					showMessage(STOPSIGN, OK, "USER-1000", "상품권 금액을 확인하셔야 됩니다");
				}else{
					DS_IO_GIFTCARD_NO.AddRow();
					setFocusGrid(GD_GIFTCARD_NO, DS_IO_GIFTCARD_NO, DS_IO_GIFTCARD_NO.CountRow , "GIFTCARD_NO");
					return false;	
				}
			}
		}else{
			showMessage(STOPSIGN, OK, "USER-1000", "상품권 금액은 " + DS_IO_SKU_LIST.NameValue(DS_IO_SKU_LIST.RowPosition,"GIFTCERT_AMT") + "원이랑 같아야 합니다");
		}
	}else{
		showMessage(EXCLAMATION	, OK, "USER-1000", "지급품 물품을 확인하여주세요.");
		return false;
	}
	 */
}

/**
 * btn_DeleteRow()
 * 작 성 자	: HJY
 * 작 성 일	: 2012.05.29
 * 개	 요	: 행 삭제
 * return값	:
 */
function btn_DeleteRow() {
	var strDsMst_RowCnt	= DS_O_RECEIPT_ADD.CountRow;
		
	DS_O_PB_EVENT.ClearData();        // 브랜드사은행사
	DS_O_PAID_EVENT.ClearData();      // 결제유형별사은행사
	DS_O_CARD_EVENT.ClearData();      // 제휴카드사은행사
	
	DS_IO_SKU_LIST_ALL.ClearData();       // 지급품정보(중복지급)
	DS_IO_SKU_LIST.ClearData();           // 지급품정보(중복지급불가)
	DS_IO_SKU_LIST_CARD.ClearData();      // 제휴카드행사지급품정보
	
	
	if (strDsMst_RowCnt	> 0) {
		DS_O_RECEIPT_ADD.DeleteRow(DS_O_RECEIPT_ADD.RowPosition);
		
		if (DS_O_RECEIPT_ADD.CountRow > 0) {
			getPbSaleInfo();
			getSkuList();
			
		}
	}
}


/**
 * dataClear()
 * 작 성 자	: khj
 * 작 성 일	: 2016.11.25
 * 개	 요	: 지급일자 변경시 초기화
 * return값	:
 */
function dataClear() {
	
    //지급일자변경시   
	DS_O_RECEIPT.ClearData();        // 브랜드사은합산정보
	DS_O_RECEIPT_ADD.ClearData();    // 브랜드사은합산정보
	
	DS_O_PB_EVENT.ClearData();        // 브랜드사은행사
	DS_O_PAID_EVENT.ClearData();      // 결제유형별사은행사
	DS_O_CARD_EVENT.ClearData();      // 제휴카드사은행사
	
	DS_IO_SKU_LIST_ALL.ClearData();      // 지급품정보(중복지급) 
	DS_IO_SKU_LIST.ClearData();           // 지급품정보(중복불가)
	DS_IO_SKU_LIST_CARD.ClearData();      // 제휴카드행사 지급정보
	
	EM_RECEIPT_NO.Text = "";
	EM_RECEIPT_NO.Focus();
}

</script>
</head>



<!--*************************************************************************-->
<!--* B. 스크립트 끝													 		*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스	이벤트 처리													*-->
<!--*	 1.	TR Success 메세지 처리
<!--*	 2.	TR Fail	메세지 처리
<!--*	 3.	DataSet	Success	메세지 처리
<!--*	 4.	DataSet	Fail 메세지	처리
<!--*	 5.	DataSet	이벤트 처리
<!--*************************************************************************-->
<!---------------------	1. TR Success 메세지 처리  ------------------------------->
<script	language=JavaScript	for=TR_MAIN	event=onSuccess>
	for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
	}
</script>
<script	language=JavaScript	for=TR_MAIN2 event=onSuccess>
	for(i=0;i<TR_MAIN2.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN2.SrvErrMsg('UserMsg',i));
	}
</script>
<script	language=JavaScript	for=TR_MAIN3 event=onSuccess>
	for(i=0;i<TR_MAIN3.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN3.SrvErrMsg('UserMsg',i));
	}
</script>
<script	language=JavaScript	for=TR_CARDINFO	event=onSuccess>
	for(i=0;i<TR_CARDINFO.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_CARDINFO.SrvErrMsg('UserMsg',i));
	}
</script>
<!---------------------	2. TR Fail 메세지 처리	----------------------------------->
<script	language=JavaScript	for=TR_MAIN	event=onFail>
	trFailed(TR_MAIN.ErrorMsg);
</script>
<script	language=JavaScript	for=TR_MAIN2 event=onFail>
	trFailed(TR_MAIN2.ErrorMsg);
</script>
<script	language=JavaScript	for=TR_MAIN3 event=onFail>
	trFailed(TR_MAIN3.ErrorMsg);
</script>
<script	language=JavaScript	for=TR_CARDINFO	event=onFail>
	trFailed(TR_CARDINFO.ErrorMsg);
</script>
<!---------------------	3. DataSet Success 메세지 처리	--------------------------->
<!---------------------	4. DataSet Fail	메세지 처리	 -------------------------->
<!---------------------	5. DataSet 이벤트 처리	------------------------------->


<script	language=JavaScript	for=DS_IO_SKU_LIST event=OnRowPosChanged(row)>
 	//if(clickSORT)
		//return;
</script>

<!---------------------	6. 컴포넌트	이벤트 처리	 ------------------------------>
<script	language=JavaScript	for=LC_STR event=OnSelChange()>
	// 점코드 변경시 행사 내용 조회
	strToday = EM_PRSNT_DT.Text;
	//getEventCombo();	
</script>

<script	language=JavaScript	for=EM_PRSNT_DT event=OnSelChange()>
	// 일자 변경시 행사 내용 조회
	//getEventCombo();	
</script>

<script	language=JavaScript	for=EM_RECEIPT_NO event=onLastChar(char)>
//OnKillFocus()>
    //영수증 번호입력후
    
	if(this.Text ==	undefined) return;
	if(this.Text ==	"") return;

	//사은품 지급영수증 유무 확인 -  미지급시 영수내역에 ADD	-- 작성중.. .
	var strReceiptNo	= EM_RECEIPT_NO.Text;
	var strStrCd_org	= LC_STR.BindColVal;
	var strPrsntDt	    = EM_PRSNT_DT.Text;    //지급일자
	
	var strStrCd		= strReceiptNo.substring(11,13);	
	var strSaleDt		= strReceiptNo.substring(0,8);
	var strPosNo		= strReceiptNo.substring(13,17);
	var strTranNo		= strReceiptNo.substring(17,22);
	var strSaleGbn  	= strReceiptNo.substring(22,23);

	if (strSaleGbn != "0") {
		showMessage(EXCLAMATION ,	OK,	"USER-1000", "정상 매출 영수증이 아닙니다. 확인 바랍니다.");
		return;
	}	

	if (strStrCd != strStrCd_org) {
		showMessage(EXCLAMATION ,	OK,	"USER-1000", "아트몰링 영수증이 아닙니다. 확인 바랍니다.");
		return;
	}
	
	 if (strSaleDt != strPrsntDt) {
		//showMessage(EXCLAMATION ,	OK,	"USER-1000", "지급일자보다 영수증 매출일자가 큰영수증은 등록 할 수 없습니다.");
		showMessage(EXCLAMATION ,	OK,	"USER-1000", "당일 영수증만 지급처리 가능합니다.");
		EM_RECEIPT_NO.Text = "";
		EM_RECEIPT_NO.Focus();
		return;
	} 
	
	for(var k=i+1; k<=DS_O_RECEIPT_ADD.CountRow; k++) {
    	
   		var RECEIPT_NO = DS_O_RECEIPT_ADD.NameValue(k,"F_RECEIPT_NO");
        if (strReceiptNo == RECEIPT_NO) {
            showMessage(STOPSIGN, OK, "USER-1000", k +"번째행의 영수증번호와 중복됩니다.");
            EM_RECEIPT_NO.text = "";
            return;
        }
   	
    }	
		
	DS_O_RECEIPT.ClearData();        // 영수증내역
	
	// 조회조건 셋팅	
	var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
				   + "&strSaleDt="   + encodeURIComponent(strSaleDt)
				   + "&strPosNo="    + encodeURIComponent(strPosNo)
				   + "&strTranNo="   + encodeURIComponent(strTranNo)
				   + "&strReceiptNo="   + encodeURIComponent(strReceiptNo)
				   + "&evtcnt="      +  + encodeURIComponent(evtcnt)
					;	

	TR_MAIN.Action="/mss/mcae434.mc?goTo=getRECEIPT_list"+parameters; 
	TR_MAIN.KeyValue="SERVLET(O:DS_O_RECEIPT=DS_O_RECEIPT)"; //조회는 O	
	TR_MAIN.Post();
	
	// 영수증 정보 ADD
	if (DS_O_RECEIPT.CountRow > 0){
		DS_O_RECEIPT_ADD.AddRow();
		DS_O_RECEIPT_ADD.NameValue(DS_O_RECEIPT_ADD.RowPosition,"STR_CD") = DS_O_RECEIPT.NameValue(1,"STR_CD");
		DS_O_RECEIPT_ADD.NameValue(DS_O_RECEIPT_ADD.RowPosition,"SALE_DT") = DS_O_RECEIPT.NameValue(1,"SALE_DT");
		DS_O_RECEIPT_ADD.NameValue(DS_O_RECEIPT_ADD.RowPosition,"RECEIPT_NO") = DS_O_RECEIPT.NameValue(1,"RECEIPT_NO");
		DS_O_RECEIPT_ADD.NameValue(DS_O_RECEIPT_ADD.RowPosition,"F_RECEIPT_NO") = strReceiptNo;		
		DS_O_RECEIPT_ADD.NameValue(DS_O_RECEIPT_ADD.RowPosition,"SALE_AMT_TAX") = DS_O_RECEIPT.NameValue(1,"SALE_AMT_TAX");		
		
		getPbSaleInfo();
		getSkuList();
		
		EM_RECEIPT_NO.Text = "";
		EM_RECEIPT_NO.Focus();
	} 
			
</script>


<script language="javascript" for=GD_SKU_LIST_ALL event=OnClick(row,colid)>
	//중복 지급내역 선택시
	
	//if(row == 0) sortColId( eval(this.DataID), row, colid);
	if(row == 0) return;
	//if(colid != "CHK" && colid != "GIFTCARD_NO") return;	
	if(colid != "CHK") return;
	
	var strEventCd = DS_IO_SKU_LIST_ALL.NameValue(row, "EVENT_CD");
	var strEventCd_i = "";
	strChk_i = "";
	
	for(var i=1;i<=DS_IO_SKU_LIST_ALL.CountRow;i++){
		
		strChk_i = DS_IO_SKU_LIST_ALL.NameValue(row,"CHK")
		strEventCd_i = DS_IO_SKU_LIST_ALL.NameValue(i,"EVENT_CD");
		
		if (strEventCd_i == strEventCd && i != row && DS_IO_SKU_LIST_ALL.NameValue(row,"CHK") == "T" ) {
			DS_IO_SKU_LIST_ALL.NameValue(i,"GIFTCARD_NO") = "";	
			DS_IO_SKU_LIST_ALL.NameValue(i,"GIFTCERT_AMT") = "";
			DS_IO_SKU_LIST_ALL.NameValue(i,"GIFTCARD_CNT") = "";	
			DS_IO_SKU_LIST_ALL.NameValue(i,"GIFTCARD_LIST") = "";		
			DS_IO_SKU_LIST_ALL.NameValue(i,"CHK") = "F";	
		} 
		
		if (strEventCd_i == strEventCd && i == row && DS_IO_SKU_LIST_ALL.NameValue(row,"CHK") == "F" ) {
			DS_IO_SKU_LIST_ALL.NameValue(i,"GIFTCARD_NO") = "";	
			DS_IO_SKU_LIST_ALL.NameValue(i,"GIFTCERT_AMT") = "";
			DS_IO_SKU_LIST_ALL.NameValue(i,"GIFTCARD_CNT") = "";	
			DS_IO_SKU_LIST_ALL.NameValue(i,"GIFTCARD_LIST") = "";		
			DS_IO_SKU_LIST_ALL.NameValue(i,"CHK") = "F";	
		} 
		
    }
	
	
	//setDivAmt();
	//DS_IO_GIFTCARD_NO.ClearData();	
</script>


<script language="javascript" for=GD_SKU_LIST event=OnClick(row,colid)>
	//중복불가 지급내역 선택시
	
	//if(row == 0) sortColId( eval(this.DataID), row, colid);
	if(row == 0) return;
	if(colid != "CHK") return;
	
	for(var i=1;i<=DS_IO_SKU_LIST.CountRow;i++){
		if(i != row && DS_IO_SKU_LIST.NameValue(row,"CHK") == "T"){
			DS_IO_SKU_LIST.NameValue(i,"GIFTCARD_NO") = "";	
			DS_IO_SKU_LIST.NameValue(i,"GIFTCERT_AMT") = "";		
			DS_IO_SKU_LIST.NameValue(i,"GIFTCARD_CNT") = "";	
			DS_IO_SKU_LIST.NameValue(i,"GIFTCARD_LIST") = "";
			DS_IO_SKU_LIST.NameValue(i,"CHK") = "F";
		}
		
		if ( i == row && DS_IO_SKU_LIST.NameValue(row,"CHK") == "F" ) {
			DS_IO_SKU_LIST.NameValue(i,"GIFTCARD_NO") = "";	
			DS_IO_SKU_LIST.NameValue(i,"GIFTCERT_AMT") = "";	
			DS_IO_SKU_LIST.NameValue(i,"GIFTCARD_CNT") = "";	
			DS_IO_SKU_LIST.NameValue(i,"GIFTCARD_LIST") = "";	
			DS_IO_SKU_LIST.NameValue(i,"CHK") = "F";	
		} 
    }	
	
	//setDivAmt();
	//DS_IO_GIFTCARD_NO.ClearData();
</script>

	
<script language="javascript" for=GD_SKU_LIST_CARD event=OnClick(row,colid)>
	//제휴카드 지급내역 선택시
	
	//if(row == 0) sortColId( eval(this.DataID), row, colid);
	if(row == 0) return;
	if(colid != "CHK") return;
	
	var strEventCd = DS_IO_SKU_LIST_CARD.NameValue(row, "EVENT_CD");
	var strEventCd_i = "";
	strChk_i = "";
	
	for(var i=1;i<=DS_IO_SKU_LIST_CARD.CountRow;i++){
		
		strChk_i = DS_IO_SKU_LIST_CARD.NameValue(row,"CHK")
		strEventCd_i = DS_IO_SKU_LIST_CARD.NameValue(i,"EVENT_CD");
		
		if (strEventCd_i == strEventCd && i != row && DS_IO_SKU_LIST_CARD.NameValue(row,"CHK") == "T" ) {
			DS_IO_SKU_LIST_CARD.NameValue(i,"GIFTCARD_NO") = "";	
			DS_IO_SKU_LIST_CARD.NameValue(i,"GIFTCERT_AMT") = "";
			DS_IO_SKU_LIST_CARD.NameValue(i,"GIFTCARD_CNT") = "";	
			DS_IO_SKU_LIST_CARD.NameValue(i,"GIFTCARD_LIST") = "";		
			DS_IO_SKU_LIST_CARD.NameValue(i,"CHK") = "F";			
		}
		
		if (strEventCd_i == strEventCd && i == row && DS_IO_SKU_LIST_CARD.NameValue(row,"CHK") == "F" ) {
			DS_IO_SKU_LIST_CARD.NameValue(i,"GIFTCARD_NO") = "";	
			DS_IO_SKU_LIST_CARD.NameValue(i,"GIFTCERT_AMT") = "";	
			DS_IO_SKU_LIST_CARD.NameValue(i,"GIFTCARD_CNT") = "";	
			DS_IO_SKU_LIST_CARD.NameValue(i,"GIFTCARD_LIST") = "";	
			DS_IO_SKU_LIST_CARD.NameValue(i,"CHK") = "F";	
		} 
    }
	//setDivAmt();
	//DS_IO_GIFTCARD_NO.ClearData();
</script>


<!-- 데이터셋 값 변경 후 -->
<script language="javascript"  for=DS_IO_SKU_LIST_ALL event=OnColumnChanged(row,colid)>
	//중복불가 지급내역 선택시
	if(DS_IO_SKU_LIST_ALL.NameValue(row,"GIFTCARD_NO").length == 0) {
		//DS_IO_SKU_LIST_ALL.NameValue(row, "GIFTCERT_AMT") = 0;
		return;
	}
	
	switch(colid){
		case 'GIFTCARD_NO':     // 상품권 번호 조회	
			if(DS_IO_SKU_LIST_ALL.NameValue(row,"GIFTCARD_NO").length != 12){
				
			}else{
	    		var iItemCd = DS_IO_SKU_LIST_ALL.NameValue(row,"GIFTCARD_NO");
	    		var iGIFTCERT_AMT = DS_IO_SKU_LIST_ALL.NameValue(row,"GIFTCERT_AMT");
	    		var iGIFTCARD_CNT = 0;
	    		var strGIFTCARD_LIST = DS_IO_SKU_LIST_ALL.NameValue(row,"GIFTCARD_LIST");
	    		
	    		var intcol = 0;
	    		
				for(var irow=1;irow<=DS_IO_SKU_LIST_ALL.CountRow;irow++){
	    			
	    			iGIFTCARD_CNT = DS_IO_SKU_LIST_ALL.NameValue(irow,"GIFTCARD_CNT");
	    			intcol = 0;
		    		for(var i=1;i<=iGIFTCARD_CNT;i++){
		    			var strGIFTCARD_NO = DS_IO_SKU_LIST_ALL.NameValue(irow,"GIFTCARD_LIST").substring(intcol,12 + intcol);
		    			
		    			if (iItemCd == strGIFTCARD_NO) {
		    	            showMessage(STOPSIGN, OK, "USER-1000", irow + "행에 이미 입력한 상품권번호 입니다.");
		    	            DS_IO_SKU_LIST_ALL.NameValue(row,"GIFTCARD_NO") = "";
		    	            return;
		    				
		    			}
		    			intcol = intcol + 12
		    		}
	    		}
				
				//중복불가 사은품 내역 에서 상품권 중복 체크
				for(var irow=1;irow<=DS_IO_SKU_LIST.CountRow;irow++){
	    			
	    			iGIFTCARD_CNT = DS_IO_SKU_LIST.NameValue(irow,"GIFTCARD_CNT");
	    			intcol = 0;
		    		for(var i=1;i<=iGIFTCARD_CNT;i++){
		    			var strGIFTCARD_NO = DS_IO_SKU_LIST.NameValue(irow,"GIFTCARD_LIST").substring(intcol,12 + intcol);
		    			
		    			if (iItemCd == strGIFTCARD_NO) {
		    	            showMessage(STOPSIGN, OK, "USER-1000", "지급품정보(중복불가) " + irow + "행에 이미 입력한 상품권번호 입니다.");
		    	            DS_IO_SKU_LIST_ALL.NameValue(row,"GIFTCARD_NO") = "";
		    	            return;
		    				
		    			}
		    			intcol = intcol + 12
		    		}
	    		}

				//제휴카드행사 지급정보 사은품 내역 에서 상품권 중복 체크
				for(var irow=1;irow<=DS_IO_SKU_LIST_CARD.CountRow;irow++){
	    			
	    			iGIFTCARD_CNT = DS_IO_SKU_LIST_CARD.NameValue(irow,"GIFTCARD_CNT");
	    			intcol = 0;
		    		for(var i=1;i<=iGIFTCARD_CNT;i++){
		    			var strGIFTCARD_NO = DS_IO_SKU_LIST_CARD.NameValue(irow,"GIFTCARD_LIST").substring(intcol,12 + intcol);
		    			
		    			if (iItemCd == strGIFTCARD_NO) {
		    	            showMessage(STOPSIGN, OK, "USER-1000", "제휴카드행사 지급정보 " + irow + "행에 이미 입력한 상품권번호 입니다.");
		    	            DS_IO_SKU_LIST_ALL.NameValue(row,"GIFTCARD_NO") = "";
		    	            return;
		    				
		    			}
		    			intcol = intcol + 12
		    		}
	    		}
	    		//--상품권이 중복이없고 유효한 상품권이경우에 수량, 금액, list에 추가
	    		if (chkGiftCardNo("DS_IO_SKU_LIST_ALL", row)) {
	    		
		    		DS_IO_SKU_LIST_ALL.NameValue(row,"GIFTCARD_CNT") = DS_IO_SKU_LIST_ALL.NameValue(row,"GIFTCARD_CNT") + 1;
		    		DS_IO_SKU_LIST_ALL.NameValue(row,"GIFTCERT_AMT") = DS_IO_SKU_LIST_ALL.NameValue(row,"GIFTCERT_AMT") + iGIFTCERT_AMT;
		    		DS_IO_SKU_LIST_ALL.NameValue(row,"GIFTCARD_LIST") = DS_IO_SKU_LIST_ALL.NameValue(row,"GIFTCARD_NO") + strGIFTCARD_LIST;
		    		DS_IO_SKU_LIST_ALL.NameValue(row,"GIFTCARD_NO") = "";
	    		}
			}
			break;
	}
</script>

<!-- 데이터셋 값 변경 후 -->
<script language="javascript"  for=GD_SKU_LIST_ALL event=CanColumnPosChange(Row,Colid)>

	//중복불가 지급내역 선택시
	if(DS_IO_SKU_LIST_ALL.NameValue(Row,"GIFTCARD_NO").length == 0){
		//DS_IO_SKU_LIST_ALL.NameValue(Row, "GIFTCERT_AMT") = 0;
		return;
	}
	
	switch(Colid){
		case 'GIFTCARD_NO':     // 상품권 번호 조회	
			if(DS_IO_SKU_LIST_ALL.NameValue(Row,"GIFTCARD_NO").length != 12){
				showMessage(INFORMATION, OK, "USER-1000", "상품권 자리수는 12자리입니다");				
				//setFocusGrid(GD_SKU_LIST_ALL, DS_IO_SKU_LIST_ALL, Row , "GIFTCARD_NO");
				
		    	return false;
			}else{
	    		var iItemCd = DS_IO_SKU_LIST_ALL.NameValue(Row,"GIFTCARD_NO");
	    	    for(var k=i+1; k<=DS_IO_SKU_LIST_ALL.CountRow; k++) {
	    	    	if (Row != k) {
	    	    		var kItemCd = DS_IO_SKU_LIST_ALL.NameValue(k,"GIFTCARD_NO");
	    		        if (iItemCd==kItemCd) {
	    		            showMessage(STOPSIGN, OK, "USER-1000", k +"번째행의  상품권번호와 중복됩니다.");

	    					//setFocusGrid(GD_SKU_LIST_ALL, DS_IO_SKU_LIST_ALL, Row , "GIFTCARD_NO");
	    		            return false;
	    		        }
	    	    	}
	    	    }
	    		//if (chkGiftCardNo("DS_IO_SKU_LIST_ALL", Row) == false) {
	    		//
	    		//	return false;
	       		//};					
			}	
			return true;
			break;
	}
</script>





<!-- 데이터셋 값 변경 후 -->
<script language="javascript"  for=DS_IO_SKU_LIST event=OnColumnChanged(row,colid)>

	//중복불가 지급내역 선택시
	if(DS_IO_SKU_LIST.NameValue(row,"GIFTCARD_NO").length == 0) {
		//DS_IO_SKU_LIST.NameValue(row, "GIFTCERT_AMT") = 0;
		return;
	}
	
	switch(colid){
		case 'GIFTCARD_NO':     // 상품권 번호 조회	
			if(DS_IO_SKU_LIST.NameValue(row,"GIFTCARD_NO").length != 12){
				return;
			}else{
	    			    		
	    		var iItemCd = DS_IO_SKU_LIST.NameValue(row,"GIFTCARD_NO");
	    		var iGIFTCERT_AMT = DS_IO_SKU_LIST.NameValue(row,"GIFTCERT_AMT");
	    		var iGIFTCARD_CNT = 0;
	    		var strGIFTCARD_LIST = DS_IO_SKU_LIST.NameValue(row,"GIFTCARD_LIST");
	    		
	    		var intcol = 0;

				for(var irow=1;irow<=DS_IO_SKU_LIST.CountRow;irow++){
	    			
	    			iGIFTCARD_CNT = DS_IO_SKU_LIST.NameValue(irow,"GIFTCARD_CNT");
	    			intcol = 0;
		    		for(var i=1;i<=iGIFTCARD_CNT;i++){
		    			var strGIFTCARD_NO = DS_IO_SKU_LIST.NameValue(irow,"GIFTCARD_LIST").substring(intcol,12 + intcol);
		    			
		    			if (iItemCd == strGIFTCARD_NO) {
		    	            showMessage(STOPSIGN, OK, "USER-1000", irow + "행에 이미 입력한 상품권번호 입니다.");
		    	            DS_IO_SKU_LIST.NameValue(row,"GIFTCARD_NO") = "";
		    	            return;
		    				
		    			}
		    			intcol = intcol + 12
		    		}
	    		}
				

				for(var irow=1;irow<=DS_IO_SKU_LIST_ALL.CountRow;irow++){
	    			
	    			iGIFTCARD_CNT = DS_IO_SKU_LIST_ALL.NameValue(irow,"GIFTCARD_CNT");
	    			intcol = 0;
		    		for(var i=1;i<=iGIFTCARD_CNT;i++){
		    			var strGIFTCARD_NO = DS_IO_SKU_LIST_ALL.NameValue(irow,"GIFTCARD_LIST").substring(intcol,12 + intcol);
		    			
		    			if (iItemCd == strGIFTCARD_NO) {
		    	            showMessage(STOPSIGN, OK, "USER-1000", "지급품정보(중복지급)" + irow + "행에 이미 입력한 상품권번호 입니다.");
		    	            DS_IO_SKU_LIST.NameValue(row,"GIFTCARD_NO") = "";
		    	            return;
		    				
		    			}
		    			intcol = intcol + 12
		    		}
	    		}
				

				//제휴카드행사 지급정보 사은품 내역 에서 상품권 중복 체크
				for(var irow=1;irow<=DS_IO_SKU_LIST_CARD.CountRow;irow++){
	    			
	    			iGIFTCARD_CNT = DS_IO_SKU_LIST_CARD.NameValue(irow,"GIFTCARD_CNT");
	    			intcol = 0;
		    		for(var i=1;i<=iGIFTCARD_CNT;i++){
		    			var strGIFTCARD_NO = DS_IO_SKU_LIST_CARD.NameValue(irow,"GIFTCARD_LIST").substring(intcol,12 + intcol);
		    			
		    			if (iItemCd == strGIFTCARD_NO) {
		    	            showMessage(STOPSIGN, OK, "USER-1000", "제휴카드행사 지급정보 " + irow + "행에 이미 입력한 상품권번호 입니다.");
		    	            DS_IO_SKU_LIST.NameValue(row,"GIFTCARD_NO") = "";
		    	            return;
		    				
		    			}
		    			intcol = intcol + 12
		    		}
	    		}
				
	    		//--상품권이 중복이없고 유효한 상품권이경우에 수량, 금액, list에 추가
	    		if (chkGiftCardNo("DS_IO_SKU_LIST", row)) {
	    		
	    			DS_IO_SKU_LIST.NameValue(row,"GIFTCARD_CNT") = DS_IO_SKU_LIST.NameValue(row,"GIFTCARD_CNT") + 1;
	    			DS_IO_SKU_LIST.NameValue(row,"GIFTCERT_AMT") = DS_IO_SKU_LIST.NameValue(row,"GIFTCERT_AMT") + iGIFTCERT_AMT;
	    			DS_IO_SKU_LIST.NameValue(row,"GIFTCARD_LIST") = DS_IO_SKU_LIST.NameValue(row,"GIFTCARD_NO") + strGIFTCARD_LIST;
	    			DS_IO_SKU_LIST.NameValue(row,"GIFTCARD_NO") = "";
	    		}
			}
			break;
	}
</script>



<!-- 데이터셋 값 변경 후 -->
<script language="javascript"  for=GD_SKU_LIST event=CanColumnPosChange(Row,Colid)>

	//중복불가 지급내역 선택시
	if(DS_IO_SKU_LIST.NameValue(Row,"GIFTCARD_NO").length == 0){
		//DS_IO_SKU_LIST.NameValue(Row, "GIFTCERT_AMT") = 0;
		return;
	}
	
	switch(Colid){
		case 'GIFTCARD_NO':     // 상품권 번호 조회	
			if(DS_IO_SKU_LIST.NameValue(Row,"GIFTCARD_NO").length != 12){
				showMessage(INFORMATION, OK, "USER-1000", "상품권 자리수는 12자리입니다");				
				//setFocusGrid(GD_SKU_LIST, DS_IO_SKU_LIST, Row , "GIFTCARD_NO");
				
		    	return false;
			}else{
	    		var iItemCd = DS_IO_SKU_LIST.NameValue(Row,"GIFTCARD_NO");
	    	    for(var k=i+1; k<=DS_IO_SKU_LIST.CountRow; k++) {
	    	    	if (Row != k) {
	    	    		var kItemCd = DS_IO_SKU_LIST.NameValue(k,"GIFTCARD_NO");
	    		        if (iItemCd==kItemCd) {
	    		            showMessage(STOPSIGN, OK, "USER-1000", k +"번째행의  상품권번호와 중복됩니다.");

	    					//setFocusGrid(GD_SKU_LIST, DS_IO_SKU_LIST, Row , "GIFTCARD_NO");
	    		            return false;
	    		        }
	    	    	}
	    	    }
	    		//if (chkGiftCardNo("DS_IO_SKU_LIST", Row) == false) {
	    		//
	    		//	return false;
	       		//};					
			}	
			return true;
			break;
	}
</script>



<!-- 데이터셋 값 변경 후 -->
<script language="javascript"  for=DS_IO_SKU_LIST_CARD event=OnColumnChanged(row,colid)>

	//중복불가 지급내역 선택시
	if(DS_IO_SKU_LIST_CARD.NameValue(row,"GIFTCARD_NO").length == 0) {
		//DS_IO_SKU_LIST_CARD.NameValue(row, "GIFTCERT_AMT") = 0;
		return;
	}
	
	switch(colid){
		case 'GIFTCARD_NO':     // 상품권 번호 조회	
			if(DS_IO_SKU_LIST_CARD.NameValue(row,"GIFTCARD_NO").length != 12){
				
			}else{
	    		var iItemCd = DS_IO_SKU_LIST_CARD.NameValue(row,"GIFTCARD_NO");
	    		var iGIFTCERT_AMT = DS_IO_SKU_LIST_CARD.NameValue(row,"GIFTCERT_AMT");
	    		var iGIFTCARD_CNT = 0;
	    		var strGIFTCARD_LIST = DS_IO_SKU_LIST_CARD.NameValue(row,"GIFTCARD_LIST");
	    		
	    		var intcol = 0;

				for(var irow=1;irow<=DS_IO_SKU_LIST_CARD.CountRow;irow++){
	    			
	    			iGIFTCARD_CNT = DS_IO_SKU_LIST_CARD.NameValue(irow,"GIFTCARD_CNT");
	    			intcol = 0;
		    		for(var i=1;i<=iGIFTCARD_CNT;i++){
		    			var strGIFTCARD_NO = DS_IO_SKU_LIST_CARD.NameValue(irow,"GIFTCARD_LIST").substring(intcol,12 + intcol);
		    			
		    			if (iItemCd == strGIFTCARD_NO) {
		    	            showMessage(STOPSIGN, OK, "USER-1000",  irow + "행에 이미 입력한 상품권번호 입니다.");
		    	            setFocusGrid(GD_SKU_LIST_CARD, DS_IO_SKU_LIST_CARD, row , "GIFTCARD_NO");
		    	            DS_IO_SKU_LIST_CARD.NameValue(row,"GIFTCARD_NO") = "";
		    	            return;
		    				
		    			}
		    			intcol = intcol + 12
		    		}
	    		}
				
				for(var irow=1;irow<=DS_IO_SKU_LIST_ALL.CountRow;irow++){
	    			
	    			iGIFTCARD_CNT = DS_IO_SKU_LIST_ALL.NameValue(irow,"GIFTCARD_CNT");
	    			intcol = 0;
		    		for(var i=1;i<=iGIFTCARD_CNT;i++){
		    			var strGIFTCARD_NO = DS_IO_SKU_LIST_ALL.NameValue(irow,"GIFTCARD_LIST").substring(intcol,12 + intcol);
		    			
		    			if (iItemCd == strGIFTCARD_NO) {
		    	            showMessage(STOPSIGN, OK, "USER-1000", "지급품정보(중복지급)" + irow + "행에 이미 입력한 상품권번호 입니다.");
		    	            setFocusGrid(GD_SKU_LIST_CARD, DS_IO_SKU_LIST_CARD, row , "GIFTCARD_NO");
		    	            DS_IO_SKU_LIST_CARD.NameValue(row,"GIFTCARD_NO") = "";
		    	            return;
		    				
		    			}
		    			intcol = intcol + 12
		    		}
	    		}
				
				for(var irow=1;irow<=DS_IO_SKU_LIST.CountRow;irow++){
	    			
	    			iGIFTCARD_CNT = DS_IO_SKU_LIST.NameValue(irow,"GIFTCARD_CNT");
	    			intcol = 0;
		    		for(var i=1;i<=iGIFTCARD_CNT;i++){
		    			var strGIFTCARD_NO = DS_IO_SKU_LIST.NameValue(irow,"GIFTCARD_LIST").substring(intcol,12 + intcol);
		    			
		    			if (iItemCd == strGIFTCARD_NO) {
		    	            showMessage(STOPSIGN, OK, "USER-1000", "지급품정보(중복불가)" + irow + "행에 이미 입력한 상품권번호 입니다.");
		    	            setFocusGrid(GD_SKU_LIST_CARD, DS_IO_SKU_LIST_CARD, row , "GIFTCARD_NO");
		    	            DS_IO_SKU_LIST_CARD.NameValue(row,"GIFTCARD_NO") = "";
		    	            return;
		    				
		    			}
		    			intcol = intcol + 12
		    		}
	    		}
				
	    		//--상품권이 중복이없고 유효한 상품권이경우에 수량, 금액, list에 추가
	    		if (chkGiftCardNo("DS_IO_SKU_LIST_CARD", row)) {
	    			DS_IO_SKU_LIST_CARD.NameValue(row,"GIFTCARD_CNT") = DS_IO_SKU_LIST_CARD.NameValue(row,"GIFTCARD_CNT") + 1;
	    			DS_IO_SKU_LIST_CARD.NameValue(row,"GIFTCERT_AMT") = DS_IO_SKU_LIST_CARD.NameValue(row,"GIFTCERT_AMT") + iGIFTCERT_AMT;
	    			DS_IO_SKU_LIST_CARD.NameValue(row,"GIFTCARD_LIST") = DS_IO_SKU_LIST_CARD.NameValue(row,"GIFTCARD_NO") + strGIFTCARD_LIST;
	    			DS_IO_SKU_LIST_CARD.NameValue(row,"GIFTCARD_NO") = "";
	    			//alert(row+colid);
	    		}
	    		else {
		            DS_IO_SKU_LIST_CARD.NameValue(row,"GIFTCARD_NO") = DS_IO_SKU_LIST_CARD.OrgNameValue(row,"GIFTCARD_NO"); 
					setFocusGrid(GD_SKU_LIST_CARD, DS_IO_SKU_LIST_CARD, row , "GIFTCARD_NO");
	    		}
			}
			break;
	}
		
</script>

<!-- 데이터셋 값 변경 후 -->
<script language="javascript"  for=GD_SKU_LIST_CARD event=CanColumnPosChange(Row,Colid)>

//중복불가 지급내역 선택시
	if(DS_IO_SKU_LIST_CARD.NameValue(Row,"GIFTCARD_NO").length == 0){
		//DS_IO_SKU_LIST_CARD.NameValue(Row, "GIFTCERT_AMT") = 0;
		return;
	}
	
	switch(Colid){
		case 'GIFTCARD_NO':     // 상품권 번호 조회	
			if(DS_IO_SKU_LIST_CARD.NameValue(Row,"GIFTCARD_NO").length != 12){
				showMessage(INFORMATION, OK, "USER-1000", "상품권 자리수는 12자리입니다");
				DS_IO_SKU_LIST_CARD.NameValue(Row,"GIFTCARD_NO") = DS_IO_SKU_LIST_CARD.OrgNameValue(Row,"GIFTCARD_NO"); 
				setFocusGrid(GD_SKU_LIST_CARD, DS_IO_SKU_LIST_CARD, Row , "GIFTCARD_NO");
				
		    	return false;
			}else{
	    		var iItemCd = DS_IO_SKU_LIST_CARD.NameValue(Row,"GIFTCARD_NO");
	    	    for(var k=i+1; k<=DS_IO_SKU_LIST_CARD.CountRow; k++) {
	    	    	if (Row != k) {
	    	    		var kItemCd = DS_IO_SKU_LIST_CARD.NameValue(k,"GIFTCARD_NO");
	    		        if (iItemCd==kItemCd) {
	    		            showMessage(STOPSIGN, OK, "USER-1000", k +"번째행의  상품권번호와 중복됩니다.");
	    		            DS_IO_SKU_LIST_CARD.NameValue(Row,"GIFTCARD_NO") = DS_IO_SKU_LIST_CARD.OrgNameValue(Row,"GIFTCARD_NO"); 
	    					setFocusGrid(GD_SKU_LIST_CARD, DS_IO_SKU_LIST_CARD, Row , "GIFTCARD_NO");
	    					//setFocusGrid(GD_SKU_LIST_CARD, DS_IO_SKU_LIST_CARD, Row , "GIFTCARD_NO");
	    		            return false;
	    		        }
	    	    	}
	    	    }
	    		//if (chkGiftCardNo("DS_IO_SKU_LIST_CARD", Row) == false) {
	    		//
	    		//	return false;
	       		//};					
			}
			return false;
			break;
	}
</script>



<script language=JavaScript for=GD_GIFTCARD_NO event=CanColumnPosChange(row,colid)>

	switch(colid){
		case 'GIFTCARD_NO': // 상품권 번호 조회	
			if(DS_IO_GIFTCARD_NO.NameValue(row,"GIFTCARD_NO").length != 12){
				showMessage(INFORMATION, OK, "USER-1000", "상품권 자리수는 12자리입니다");
		    	return false;
			}else{
				chkGiftCardNo(row);
				//setFocusGrid(GD_GIFTCARD_NO, DS_IO_GIFTCARD_NO, DS_IO_GIFTCARD_NO.CountRow , "GIFTCERT_NO");
	    		var iItemCd = DS_IO_GIFTCARD_NO.NameValue(row,"GIFTCARD_NO");
	    	    for(var k=i+1; k<=DS_IO_GIFTCARD_NO.CountRow; k++) {
	    	    	if (row != k) {
	    	    		var kItemCd = DS_IO_GIFTCARD_NO.NameValue(k,"GIFTCARD_NO");
	    		        if (iItemCd==kItemCd) {
	    		            showMessage(STOPSIGN, OK, "USER-1000", k +"번째행의  상품권번호와 중복됩니다.");
	    		            return false;
	    		        }
	    	    	}
	    	    }
			}	
			break;
	}
	return true;
</script>


	
<!-- 상품권 번호 입력 후 enter -->
<script language="javascript"  for=GD_SKU_LIST_CARD event=onKeyUp(row,colid,kcode)>
	
	if (kcode == 13 && colid == "GIFTCARD_NO"  ) {

		GD_SKU_LIST_CARD.SetColumn("GIFTCARD_NO");
	}
	
</script>

<script language="javascript"  for=GD_SKU_LIST_ALL event=onKeyUp(row,colid,kcode)>
	
	if (kcode == 13 && colid == "GIFTCARD_NO"  ) {

		GD_SKU_LIST_ALL.SetColumn("GIFTCARD_NO");
	}
	
</script>

<script language="javascript"  for=GD_SKU_LIST event=onKeyUp(row,colid,kcode)>
	
	if (kcode == 13 && colid == "GIFTCARD_NO"  ) {

		GD_SKU_LIST.SetColumn("GIFTCARD_NO");
	}
	
</script>



<!-- 그리드  onKeyPress() -->
<script language=JavaScript for=GD_RECEIPT event=onKeyPress(kcode)>
    if (  kcode == 49 //1
    	||kcode == 50 //2
    	||kcode == 51 //3
    	||kcode == 52 //4
    	||kcode == 53 //5
    	||kcode == 54 //6
    	||kcode == 55 //7
    	||kcode == 56 //8
    	||kcode == 57 //9
    	||kcode == 48 //0
    	||kcode == 97 //1
    	||kcode == 98 //2
    	||kcode == 99 //3
    	||kcode == 100 //4
    	||kcode == 101 //5
    	||kcode == 102 //6
    	||kcode == 103 //7
    	||kcode == 104 //8
    	||kcode == 105 //9
    	||kcode == 96 //0
       ) {
    	if (kcode > 95) kcode = kcode - 48;
    	EM_RECEIPT_NO.text = String.fromCharCode(kcode);
    	EM_RECEIPT_NO.focus();
      }
</script>
	

<!--*************************************************************************-->
<!--* C. 가우스	이벤트 처리	끝												*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스	DataSet	& Transaction 정의									*-->
<!--*	 1.	DataSet															*-->
<!--*	 2.	Transaction														*-->
<!--*************************************************************************-->

<!---------------------	1. DataSet	------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용	-->	 
<comment id="_NSID_"><object id="DS_O_CARD_INFO"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CARD_COMP"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVENT_COMBO"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_S_CONF"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR"				classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EXCP_PRSNT_RSN"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVENT_GIFT_TYPE"	classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_O_EVENT_INFO"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RECEIPT"	    	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RECEIPT_ADD"   	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>


<comment id="_NSID_"><object id="DS_O_PB_EVENT"		    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAID_EVENT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CARD_EVENT"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="GD_GIFTCARD_NO"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>


<comment id="_NSID_"><object id="DS_IO_SALE_CHK"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_SALE_INFO"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_SALE_INFO_TEMP"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_SALE_INFO_TEMP2"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_SALE_INFO_TMP"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_SKU_LIST"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_SKU_LIST_ALL"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_SKU_LIST_CARD"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>


<comment id="_NSID_"><object id="DS_O_CHECK"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_EXCP_SKU"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!---------------------	2. Transaction	--------------------------------------->
<comment id="_NSID_">
	<object	id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
		<param name="KeyName" value="Toinb_dataid4">
	</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
	<object	id="TR_CARDINFO" classid=<%=Util.CLSID_TRANSACTION%>>
		<param name="KeyName" value="Toinb_dataid4">
	</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
	<object	id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>>
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
<!--* D. 가우스	DataSet	& Transaction 정의 끝																						 *-->
<!--*************************************************************************-->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_CARD_EVENT");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GD_SKU_LIST_CARD");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
    
}
</script>

<!--*************************************************************************-->
<!--* E. 본문시작																																								*-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@	include	file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 //	-->

<input type="hidden" id="HD_BUY_COST_PRC">
<input type="hidden" id="HD_TRG_CD">
<div id="testdiv" class="testdiv">
<table width="100%"	border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td	class="PT01	PB03">
		<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="o_table">
			<tr>
				<td>
				<table width="100%"	border="0" cellpadding="0" cellspacing="0" class="s_table">
					<tr>
						<th	width="90"	class="point">점</th>
							<td width="120">
								<comment id="_NSID_">
									<object	id=LC_STR classid=<%=Util.CLSID_LUXECOMBO%> width="110" tabindex=1 align="absmiddle"></object>
								</comment><script>_ws_(_NSID_);</script>
							</td>	
						<th	width="90"	class="point">지급일자</th>
							<td width="120">
								<comment id="_NSID_">
									<object	id=EM_PRSNT_DT classid=<%=Util.CLSID_EMEDIT%> width="90" tabindex=1 align="absmiddle"></object>
								</comment><script>_ws_(_NSID_);</script>
								<!-- 날짜 입력부 디버깅시 변경 -->
								
								<img src="/<%=dir%>/imgs/btn/date.gif" style="display:none;" align="absmiddle"
								onclick="javascript:openCal('G',EM_PRSNT_DT), dataClear();"/>
								
								<!--img src="/<%=dir%>/imgs/btn/date.gif"  align="absmiddle"
								onclick="javascript:openCal('G',EM_PRSNT_DT), dataClear();"/-->
							</td>
						<th	width="90" class="point">지급자</th>
							<td>
								<comment id="_NSID_">
									<object	id=EM_PRSNT_CHAR_NM	classid=<%=Util.CLSID_EMEDIT%> width="90" tabindex=1 align="absmiddle"></object>
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
		<td	class="dot"></td>
	</tr>
	<tr>
		<td>
			<tr style="display:none;">
				<td	class="sub_title">
					<img src="/<%=dir%>/imgs/comm/ring_blue.gif" align="absmiddle" class="PR03" />행사정보
				</td>
			</tr>
			
			<tr style="display:none;">
				<td>
				<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
					<tr>
						<td><comment id="_NSID_"><OBJECT id=GD_EVENT_INFO
							width=100% height=80 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_O_EVENT_INFO">
						</OBJECT></comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
			</tr>
		</td>
	</tr>	
	<tr  style="display:none;">
		<td	class="dot"></td>
	</tr>
	<tr>
		<td	class="PT01	PB03">
		<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="o_table">
			<tr>
				<td>	
				<table width="100%"	border="0" cellpadding="0" cellspacing="0" class="s_table">
					<tr>
						<th	class="point" width="90">영수증번호</th>
							<td	colspan=3>
								<comment id="_NSID_"> 
									<object id=EM_RECEIPT_NO classid=<%=Util.CLSID_EMEDIT%>	width="200"
										tabindex=1 align="absmiddle"> </object>	
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
		<td	class="dot"></td>
	</tr>
	<tr>
		<td>
			<tr>
				<td>
				<table width="100%"	border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<td	class="sub_title">
							<img src="/<%=dir%>/imgs/comm/ring_blue.gif" align="absmiddle" class="PR03" />영수증내역
						</td>
						<td	align="right">
							<img id="IMG_DEL_ROW" style="vertical-align: middle;" src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18" onclick="btn_DeleteRow();" />
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
					<tr>
						<td><comment id="_NSID_"><OBJECT id=GD_RECEIPT
							width=100% height=120 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_O_RECEIPT_ADD">
						</OBJECT></comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
			</tr>
		</td>
	</tr>	
	<tr>
		<td	class="dot"></td>
	</tr>
	<tr	valign="top">
		<td>
		<table width="100%"	border="0" cellspacing="0" cellpadding="0">
			<tr	valign="top">
				<td	width="35%">
				<table width="100%"	border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td	height="4"></td>
					</tr>
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td	class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif"	align="absmiddle"
									class="PR03" />브랜드사은행사조회</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
							<tr>
								<td><comment id="_NSID_"><OBJECT id=GD_PB_EVENT
									width=100% height=220 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_O_PB_EVENT">
								</OBJECT></comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>					
					<tr>
						<td	height="6"></td>
					</tr>					
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td	class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif"	align="absmiddle"
									class="PR03" />결제유형별행사조회</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
							<tr>
								<td><comment id="_NSID_"><OBJECT id=GD_PAID_EVENT
									width=100% height=100 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_O_PAID_EVENT">
								</OBJECT></comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>				
					<tr>
						<td	height="6"></td>
					</tr>
					
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td	class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif"	align="absmiddle"
									class="PR03" />카드사제휴행사조회</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
							<tr>
								<td><comment id="_NSID_"><OBJECT id=GD_CARD_EVENT
									width=100%   classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_O_CARD_EVENT">
									<Param Name="ViewSummary" value="1">
								</OBJECT></comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
				<td	width="65%"	class="PL05">
				<table width="100%"	border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td	class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif"	align="absmiddle"
									class="PR03" />지급품정보(중복불가)
								</td>
								<td align="right"><img ID=IMG_ITEM
									src="/<%=dir%>/imgs/btn/supplies_item_serach.gif"
									onclick="javascript:getSkuList();" align="absmiddle" class="PR03" />
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
							<tr>
								<td><comment id="_NSID_"><OBJECT id=GD_SKU_LIST
									width=100% height=220 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_IO_SKU_LIST">
								</OBJECT></comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td	height="6"></td>
					</tr>
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td	class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif"	align="absmiddle"
									class="PR03" />지급품정보(중복지급)</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
							<tr>
								<td><comment id="_NSID_"><OBJECT id=GD_SKU_LIST_ALL
									width=100% height=100 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_IO_SKU_LIST_ALL">
								</OBJECT></comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td	height="6"></td>
					</tr>
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td	class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif"	align="absmiddle"
									class="PR03" />제휴카드행사 지급정보</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
							<tr>
								<td><comment id="_NSID_"><OBJECT id=GD_SKU_LIST_CARD
									width=100% classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_IO_SKU_LIST_CARD">
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
</div>
<!-----------------------------------------------------------------------------
  Gauce	Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

