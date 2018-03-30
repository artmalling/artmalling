<!-- 
/*******************************************************************************
 * 시스템명 : 영업지원 > 사은행사관리 > 사은품지급 > 사은행사 상품권 교환
 * 작  성  일  : 2013.04.04
 * 작  성  자  : 이성춘
 * 수  정  자  : 
 * 파  일  명  : mcae6080.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%
	request.setCharacterEncoding("utf-8");
%> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"    prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
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
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
	type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var CARD_NO_EXIST = false;
var strNewSrch = "N";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-02
 * 개    요        : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

	// Output Data Set Header 초기화
    DS_I_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_I_POINT.setDataHeader('<gauce:dataset name="H_POINT"/>');
    DS_IO_RULE.setDataHeader('<gauce:dataset name="H_RULE"/>');
    DS_O_AMT.setDataHeader('<gauce:dataset name="H_AMT"/>');
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_TODAY"/>'); 
    
    
    DS_I_POINT.ClearData();
    DS_I_POINT.Addrow();    
    
    //그리드 초기화

    gridCreate1(); //입력용
    gridCreate2(); //조회용
    
    // EMedit에 초기화
    initEmEdit(EM_CARD_NO_S,   "0000-0000-0000-0", PK);         //카드번호
    
    
    initEmEdit(EM_CUST_NAME,   "GEN^40",              READ);       //회원명 
    initEmEdit(EM_HOME_PH,     "GEN^40",              READ);       //자택전화
    initEmEdit(EM_HOME_PH1,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH2,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH3,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_MOBILE_PH,   "GEN^40",              READ);       //이동전화 
    initEmEdit(EM_MOBILE_PH1,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH2,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH3,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_SS_NO,       "000000",     	      READ);       //생년월일
    initEmEdit(EM_HOME_ADDR,   "GEN^400",             READ);       //회원주소 
    initEmEdit(EM_POINT,       "NUMBER^9^0",          READ);       //누적포인트
//     initEmEdit(EM_OCCURS_POINT,"NUMBER^9^0", 		  READ);       //발생포인트
//     initEmEdit(EM_SUM_POINT,   "NUMBER^9^0",          READ);       //누적+발생포인트
    initEmEdit(EM_EMAIL,       "GEN^80",              READ);       //이메일주소
    initEmEdit(EM_EMAIL1,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_EMAIL2,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_CUST_GTADE,  "GEN^40",              READ);       //회원등급
    initEmEdit(EM_CUST_TYPE,   "GEN^40",     		  READ);       //회원유형
     
    
    //initEmEdit(EM_CUST_ID_S,   "GEN^9",               NORMAL);     //회원코드
    //initEmEdit(EM_CUST_NAME_S, "GEN^40",              READ);       //회원명
    //initEmEdit(EM_SS_NO_S,     "000000",    		    NORMAL);     //생년월일
    //initEmEdit(EM_CARD_NO_S,   "0000-0000-0000-0000", NORMAL);     //카드번호
    //initEmEdit(EM_CARD_NO_CUT,    "00000000",            NORMAL);     //단축 카드번호
    //initEmEdit(EM_CUST_ID_H,   "GEN^9",               NORMAL);     //회원코드_hidden
    //initEmEdit(EM_SS_NO_H,     "#00000",       		NORMAL);     //생년월일_hidden
    //initEmEdit(EM_CARD_NO_H,   "0000000000000000",    NORMAL);     //카드번호_hidden


    //활성화 비활성화 화면 초기 설정
    EM_HOME_PH1.style.display    = "none";
    EM_HOME_PH2.style.display    = "none"; 
    EM_HOME_PH3.style.display    = "none";
    EM_MOBILE_PH1.style.display  = "none";
    EM_MOBILE_PH2.style.display  = "none";
    EM_MOBILE_PH3.style.display  = "none";
    EM_EMAIL1.style.display      = "none"; 
    EM_EMAIL2.style.display      = "none";
    //EM_CUST_ID_H.style.display   = "none";
    //EM_CARD_NO_H.style.display   = "none";
    //EM_SS_NO_H.style.display     = "none";

    //활성화 비활성화 화면 초기 설정
    //EM_VAILD_NO_S.style.display   = "none";
    
    EM_CARD_NO_S.Focus();
    
    //최초 addrow Dataset status 초기화.
       
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("mcae608","DS_I_POINT,DS_I_MASTER");

}


function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"                   width=30     align=center</FC>'
                     + '<FC>id=GIFTCARD_NO      name="*상품권번호"           width=190    align=center</FC>'
                     + '<FC>id=GIFTCARD_AMT     name="상품권금액"            width=100    align=right    edit=none</FC>'
                     + '<FC>id=PROC_DT          name="거래일자"              width=120    align=center   edit=none   mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=GIFT_SYS_YN      name="상품권발급등록여부"     width=150    align=center   edit=none</FC>';
                     
    initGridStyle(GR_MASTER1, "common", hdrProperies, true);
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}         name="NO"           width=30    align=center</FC>'
    	             + '<FC>id=SEQ_NO           name="순번"         width=100   align=center</FC>'
                     + '<FC>id=SUM_AMT        	name="상품권금액"   width=100   align=right</FC>'
                     + '<FC>id=PROC_DT          name="거래일자"     width=100   align=center     mask="XXXX/XX/XX"</FC>';
                     
    initGridStyle(GR_MASTER2, "common", hdrProperies, false);
}
/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 저장       - btn_Save()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-02
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	if(trim(EM_CARD_NO_S.Text).length == 0){                       // 카드번호
	    showMessage(EXCLAMATION, OK, "USER-1001","카드번호");
	    EM_CARD_NO_S.Focus();
	    return;
	}
	/*
    if(trim(EM_PWD_NO_S.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "비밀번호");
        EM_PWD_NO_S.Focus();
        return;
    } 
    if( trim(EM_PWD_NO_S.Text).length > 0 && trim(EM_PWD_NO_S.Text).length < 4){
        showMessage(EXCLAMATION, OK, "USER-1000",  "비밀번호는 4자리입니다.");
        EM_PWD_NO_S.Focus();
        return false;
    }
    */
	
	strNewSrch = "Y";
	
	
    clearData();
    CARD_NO_EXIST = false;
    //srchEvent('%');
    showMaster();
}


/**
 * btn_Save()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-22
 * 개       요     : 상품권교환 
 * return값 : void
 */
function btn_Save() {
	 
    if (!CARD_NO_EXIST) {
        showMessage(StopSign, OK, "USER-1000",  "유효한 카드가 존재하지 않는 회원입니다. 상품권 교환할 수 없습니다.");
        return;
    }
/*
    if(DS_I_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "상품권매수");
        return;
    }   
*/
	
	
    if(DS_I_MASTER.CountRow == 0){
    	 showMessage(EXCLAMATION, OK, "USER-1000",  "행추가 버튼 클릭 후 상품권을 등록하세요.");
         return;
    }
    for(var i=1; i<=DS_I_MASTER.CountRow; i++){ 
        var strGiftCardNo = DS_I_MASTER.NameValue(i, "GIFTCARD_NO");
        if ( trim(strGiftCardNo).length == 0) {
            showMessage(EXCLAMATION, OK, "USER-1003", "상품권번호");
            GR_MASTER1.SetColumn("REAL_DT");  
            DS_I_MASTER.RowPosition = i;
            return;
        }   
    }
    
    var strGiftNoYn = "N";
    for(var i=1; i<2; i++){
        for(var j=2; j<=DS_I_MASTER.CountRow; j++){ 
            if( DS_I_MASTER.NameValue(i, "GIFTCARD_NO") == DS_I_MASTER.NameValue(j, "GIFTCARD_NO")){
                strGiftNoYn = "Y"; 
            }
    	}
    }
    
    if (strGiftNoYn == "Y") {
        showMessage(StopSign, OK, "USER-1000",  "동일한 상품권번호가 존재합니다. 상품권 교환할 수 없습니다.");
        strGiftNoYn = "N";
        return;
    }
    
    var intGiftCardAmt = 0;
    for(var i=1; i<=DS_I_MASTER.CountRow; i++){ 
        intGiftCardAmt = intGiftCardAmt + parseInt(DS_I_MASTER.NameValue(i, "GIFTCARD_AMT"));
    }
    var intConvGiftAmt = 0;
    for (i=1; i < DS_IO_RULE.CountRow+1 ; i++){
    	intConvGiftAmt 	= intConvGiftAmt + (parseInt(DS_IO_RULE.NameValue(i, "CONV_GIFT_AMT")) * parseInt(DS_IO_RULE.NameValue(i, "CONV_QTY")));
    }    
/*
    if ( intGiftCardAmt != intConvGiftAmt) {
        showMessage(EXCLAMATION, OK, "USER-1000", "상품권교환매수를  확인하세요.");
        return;
    }
*/    
    if( showMessage(QUESTION, YESNO, "USER-1000", "상품권 교환을 처리하시겠습니까?") != 1 ){
        return;
    }
    //saveData(); 11.08.11    
    realSave();
}


/**
 * btn_New()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-22
 * 개      요      : 신규추가 초기화
 * return값 : void
 */
function btn_New() {

    /*
	initEmEdit(EM_CARD_NO_S,   "0000-0000-0000-0000", PK);         //카드번호
    initEmEdit(EM_PWD_NO_S,    "0000",                PK);          //비밀번호
    initEmEdit(EM_VAILD_NO_S,  "00/00",               NORMAL);     //유효기간
    
    initEmEdit(EM_NAME,       "NUMBER^9^0", READ);       //가용포인트
//     initEmEdit(EM_OCCURS_POINT,"NUMBER^9^0", READ);       //발생포인트
//     initEmEdit(EM_SUM_POINT,   "NUMBER^9^0", READ);       //누적+발생포인트
    initEmEdit(EM_MESSAGE,     "GEN^20",     READ);       //상태메세지
    */
    
	strNewSrch = "N";
	
	DS_I_POINT.ClearData();
	DS_IO_RULE.ClearData();
    DS_I_MASTER.ClearData();
    DS_O_CUSTDETAIL.ClearData();

    EM_CARD_NO_S.Text   = "";
     
     

    EM_NAME.Text  = ""; 
    EM_OCCURS_POINT.Text  = ""; 
    EM_SUM_POINT.Text  = ""; 
    EM_MESSAGE.Text  = ""; 

    //최초 addrow Dataset status 초기화.
    DS_I_POINT.ResetStatus();   
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * saveData()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-02
 * 개       요     : 상품권교환 
 * return값 : void
 */
function saveData(){
	var strCardNo = EM_CARD_NO_S.Text;
	DS_I_POINT.NameValue(DS_I_POINT.RowPosition, "CARD_NO") = strCardNo;

    var goTo        = "chkSave";
    var action      = "I";  //조회는 O
    TR_MAIN2.Action  ="/mss/mcae608.mc?goTo="+goTo;   
    TR_MAIN2.KeyValue="SERVLET("+action+":DS_I_POINT=DS_I_POINT,"+action+":DS_I_MASTER=DS_I_MASTER)"; 
    TR_MAIN2.Post();
 }
  
/**
 * realSave()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-02
 * 개       요     : 상품권교환 저장
 * return값 : void
 */
 function realSave(){
	var strCardNo = EM_CARD_NO_S.Text;
    
	var intConvPoint 	= 0;  	//상품권전환 총포인트
	var intConvGiftAmt	= 0;	//상품권전환 총금액
    for (i=1; i < DS_I_MASTER.CountRow+1 ; i++){
    	intConvGiftAmt 	= intConvGiftAmt + (parseInt(DS_I_MASTER.NameValue(i, "GIFTCARD_AMT")));
    }

	DS_I_POINT.NameValue(DS_I_POINT.RowPosition, "CARD_NO") 		= strCardNo;
	DS_I_POINT.NameValue(DS_I_POINT.RowPosition, "CONV_POINT") 		= intConvPoint;
	DS_I_POINT.NameValue(DS_I_POINT.RowPosition, "CONV_GIFT_AMT") 	= intConvGiftAmt;
	DS_I_POINT.UserStatus(1) = 1;
	for(i=1 ; i <DS_I_MASTER.CountRow+1; i++){
		DS_I_MASTER.UserStatus(i) = 1;
	}
    var strCardNo    = EM_CARD_NO_S.Text;
    
    
	
    var goTo        = "save";
    var action      = "I";  //조회는 O
    var parameters  = "&strCardNo="         + encodeURIComponent(strCardNo);
    TR_MAIN.Action  ="/mss/mcae608.mc?goTo="+goTo+parameters;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_I_MASTER=DS_I_MASTER,"+action+":DS_I_POINT=DS_I_POINT)"; 
    TR_MAIN.Post();
}

/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-02
 * 개       요     : 상품권교환 리스트 조회 
 * return값 : void
 */
function showMaster(){
 
    var strCardNo    = EM_CARD_NO_S.Text;
    
    

    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strCardNo="    + encodeURIComponent(strCardNo);
    
    //TR_MAIN.Action  ="/mss/mcae608.mc?goTo="+goTo+parameters;
    TR_MAIN.Action  ="/mss/mcae608.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER,"+action+":DS_O_CUSTDETAIL=DS_O_CUSTDETAIL)"; //조회는 O
    TR_MAIN.Post();
    
        if(DS_O_CUSTDETAIL.countrow == 0)
    {
        	showMessage(StopSign, OK, "USER-1000",  "카드번호오류 또는 선발급카드입니다");
    }
  
}

/**
 * searchAmt()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-02
 * 개       요     : 상품권금액 조회 
 * return값 : void
 */
function searchAmt(){

    var strGiftCardNo	= DS_I_MASTER.NameValue(DS_I_MASTER.RowPosition, "GIFTCARD_NO");   
    if ( trim(strGiftCardNo).length == 0 ) {
        showMessage(EXCLAMATION, OK, "USER-1003", "상품권번호"); 
        return;
    }
    
    var goTo         = "searchAmt";    
    var action       = "O";     
    var parameters   = "&strGiftCardNo="    + encodeURIComponent(strGiftCardNo);
    TR_MAIN3.Action  ="/mss/mcae608.mc?goTo="+goTo+parameters;  
    TR_MAIN3.KeyValue="SERVLET("+action+":DS_O_AMT=DS_O_AMT)"; //조회는 O
    TR_MAIN3.Post();
}

/**
 * btn_Add1()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-08
 * 개       요 : 그리드 Row추가 
 * return값 : void
 */ 
function btn_Add1(){
	 var intFRow = 0;
	 var intTRow = 0;
	 
    if (!CARD_NO_EXIST) {
        showMessage(StopSign, OK, "USER-1000",  "유효한 카드가 존재하지 않는 회원입니다. 상품권 교환할 수 없습니다.");
        return;
    }
/*    
    if(strNewSrch == "Y"){
        showMessage(EXCLAMATION, OK, "USER-1000",  "상품권을 추가 할 수 없습니다.");
        return;
    }
*/      
    var strToday = getTodayFormat('YYYYMMDD');
  
	var intConvPoint 	= 0;  	//상품권전환 총포인트
	/*
    for (i=1; i < DS_IO_RULE.CountRow+1 ; i++){
    	intConvPoint 	= intConvPoint + (parseInt(DS_IO_RULE.NameValue(i, "CONV_POINT")) * parseInt(DS_IO_RULE.NameValue(i, "CONV_QTY")));
    	intTRow 	 	= intTRow + parseInt(DS_IO_RULE.NameValue(i, "CONV_QTY"));
    }
    
    if(intTRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "상품권매수 입력 후 처리 가능합니다.");
        return;
    }    
  
    if(intConvPoint > parseInt(EM_NAME.Text)){
    	showMessage(EXCLAMATION, OK, "USER-1000",  "가용포인트가 부족합니다. 상품권 교환할 수 없습니다.");
        return false;
    }
    */
/*
    if(intTRow == DS_I_MASTER.CountRow){
    	showMessage(EXCLAMATION, OK, "USER-1000",  "상품권 총 매수만큼 Row가 생성됩니다.");
    	return false;
    }
*/    
	var intConvPointi 	= 0;
	var intConvPointj 	= 0;
    // 상품권교환 기준 포인트 간 교환 정합성 체크( (하위기준포인트 * 교환매수) < (상위기준포인트 * 교환매수))
    /*
    for (j= DS_IO_RULE.CountRow+1 ; j > 1 ; j--){
    	
    	intConvPointi 	= 0;
    	for (i=1; i < j ; i++){
        	intConvPointi 	= intConvPointi + (parseInt(DS_IO_RULE.NameValue(i, "CONV_POINT")) * parseInt(DS_IO_RULE.NameValue(i, "CONV_QTY")));
        }
    	
    	if(DS_IO_RULE.NameValue(j, "CONV_QTY") == 0){
    		intConvPointj = parseInt(DS_IO_RULE.NameValue(j, "CONV_POINT")); 
    	}else{
    		intConvPointj = (parseInt(DS_IO_RULE.NameValue(j, "CONV_POINT")) * parseInt(DS_IO_RULE.NameValue(j, "CONV_QTY")));
    	}
    	
    	if ( intConvPointj <= intConvPointi) {
        	showMessage(EXCLAMATION, OK, "USER-1000",  " 상품권교환의 [(하위기준포인트 * 교환매수) < (상위기준포인트 * 교환매수)] 의 관계를 확인 하세요.");
        	return false;  
    	}
    }
    
/*    
    if(intTRow > 0){
	   	for (i=1; i < DS_IO_RULE.CountRow+1 ; i++){
	   		for(j=1; j < parseInt(DS_IO_RULE.NameValue(i, "CONV_QTY"))+1 ; j++){
	            DS_I_MASTER.AddRow();
	            DS_I_MASTER.NameValue(DS_I_MASTER.RowPosition, "PROC_DT") 		= strToday;
	            DS_I_MASTER.NameValue(DS_I_MASTER.RowPosition, "BRCH_ID")  		= '<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />';   
	            DS_I_MASTER.NameValue(DS_I_MASTER.RowPosition, "GIFTCARD_AMT") 	= parseInt(DS_IO_RULE.NameValue(i, "CONV_GIFT_AMT"));   			
	   		} 
	   	}
    }   	
    
    var strBrchName = getBrchName();
    for (i=1 ; i < DS_I_MASTER.CountRow+1 ; i++){
    	DS_I_MASTER.NameValue(i, "BRCH_NAME") = strBrchName;
    }
*/    

	DS_I_MASTER.AddRow();
	DS_I_MASTER.NameValue(DS_I_MASTER.RowPosition, "PROC_DT") 		= strToday;
	//DS_I_MASTER.NameValue(DS_I_MASTER.RowPosition, "BRCH_ID")  		= '<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />';
	
	strNewSrch = "Y";
    

}

/**
 * btn_Del1()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-08
 * 개       요 : 그리드 Row삭제 
 * return값 : void
 */ 
function btn_Del1(){
	var row = DS_I_MASTER.RowPosition;
	DS_I_MASTER.DeleteRow(row);	
}

/**
 * getBrchName()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-02
 * 개       요 : BRCH_NAME 조회
 * return값 : void
 */
function getBrchName(){
	var strBrchName = "";
    if (DS_I_MASTER.NameValue(DS_I_MASTER.RowPosition, "BRCH_ID").length > 0 ) {
        setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", DS_I_MASTER.NameValue(DS_I_MASTER.RowPosition, "BRCH_ID"));
        if (DS_O_RESULT.CountRow == 1 ) {
        	strBrchName = DS_O_RESULT.NameValue(1, "CODE_NM");
        }
    }
    return strBrchName;
}

/**
 * clearData()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-02
 * 개       요 : clear
 * return값 : void
 */
function clearData(){
	strNewSrch = "N";
	
	DS_I_POINT.ClearData();
	DS_I_POINT.Addrow();
	DS_I_MASTER.ClearData();
	DS_O_CUSTDETAIL.ClearData();

	//EM_PWD_NO_S.Text = "";   
	//EM_CARD_NO_CUT.Text   = "";	
	    
	//최초 addrow Dataset status 초기화.
	DS_I_POINT.ResetStatus();
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                         *-->
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
        showMaster();
        //srchEvent('%');
        DS_I_POINT.ClearData();
        DS_I_POINT.AddRow();
        DS_I_MASTER.ClearData();

        //EM_PWD_NO_S.Text  = ""; 
        strNewSrch = "N";
        
        
        //최초 addrow Dataset status 초기화.
        DS_I_POINT.ResetStatus();        
    }
</script>
<script language=JavaScript for=TR_MAIN2 event=onSuccess>
    for(i=0;i<TR_MAIN2.SrvErrCount('UserMsg');i++) {
    	var strMsg = TR_MAIN2.SrvErrMsg('UserMsg',i).split('|');
        if(strMsg[0] == "00"){
            realSave();
        }
    }
</script>
<script language=JavaScript for=TR_MAIN3 event=onSuccess>
	DS_I_MASTER.NameValue(DS_I_MASTER.RowPosition, "GIFTCARD_AMT") = EM_GIFTCARD_AMT.Text;
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_MAIN2 event=onFail>
    trFailed(TR_MAIN2.ErrorMsg);
</script>
<script language=JavaScript for=TR_MAIN3 event=onFail>
    trFailed(TR_MAIN3.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_CUSTDETAIL event=OnLoadCompleted(rowcnt)>
    if (rowcnt <= 0)  { CARD_NO_EXIST = true; return; }
    if (this.NameValue(1, "CARD_NO") == "") {
        CARD_NO_EXIST = true;
    } else {
        CARD_NO_EXIST = true;
    }
    if (!CARD_NO_EXIST) {
        showMessage(StopSign, OK, "USER-1000",  "유효한 카드가 존재하지 않는 회원입니다. 상품권 교환할 수 없습니다.");
    }
</script>

<script language=JavaScript for=DS_O_AMT event=OnLoadCompleted(rowcnt,row)>

	if (this.NameValue(1, "CHECK_CNT") >= 1)  {
	    showMessage(StopSign, OK, "USER-1000",  "이미 교환된 상품권번호입니다.");
	    DS_I_MASTER.NameValue(1, "GIFTCARD_NO") = "";
	    DS_I_MASTER.NameValue(1, "GIFTCERT_AMT") = 0;
		return;
	}
	if (rowcnt <= 0)  {
        showMessage(StopSign, OK, "USER-1000",  "상품권번호 또는 상품권 상태를 확인 하시기 바랍니다.");
		return;
    }
    if (this.NameValue(1, "GIFTCERT_AMT") == "") {
        showMessage(StopSign, OK, "USER-1000",  "상품권번호 또는 상품권 상태를 확인 하시기 바랍니다.");
		return;
    }
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER1 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 상품권번호 event 처리 -->
<script language=JavaScript for=GR_MASTER1 event=OnExit(row,colid,olddata)>
if (colid == "GIFTCARD_NO") {
   	if (olddata != DS_I_MASTER.NameValue(row, "GIFTCARD_NO")) {
		//값이 변경될시 체크
		searchAmt();
   	}
}
</script>



<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- ===============- Input용  -->
<comment id="_NSID_">
<object id="DS_I_POINT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_RULE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CUSTDETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_AMT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_MAIN3" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
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
						<th width="77" class="point">카드번호</th>
						<td width="600">
							<comment id="_NSID_">
							<object id=EM_CARD_NO_S
							classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1>
							</object> </comment> <script> _ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
	                        onclick="getCardPop(EM_CARD_NO_S,EM_CARD_NO_S,'P')" />
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
			<%@ include file="/jsp/common/memView.jsp"%>
		</td>
	</tr>
	
    
	
	<tr>
		<td class="PT10">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="sub_title"><img src="/pot/imgs/comm/ring_blue.gif"
					class="PR03" align="absmiddle" /> 상품권 번호 등록</td>
				<td class="right"><img src="/pot/imgs/btn/add_row.gif"
					hspace="2" id="IMG_ADD" onclick="javascript:btn_Add1();" /> 
					<img src="/<%=dir%>/imgs/btn/del_row.gif"
					onclick="javascript:btn_Del1();" />
				    <comment id="_NSID_"> <object id=EM_GIFTCARD_AMT classid=<%=Util.CLSID_EMEDIT%> width=0 tabindex=1> 
					</object> </comment> <script> _ws_(_NSID_);</script>
   				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER1
					width="100%" height=108 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_I_MASTER">
				</object> </comment> <script> _ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	
    <tr>
        <td class="sub_title PT07 PB02"><img
            src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
            align="absmiddle" class="PR03" /> 당일 상품권 교환 내역</td>
    </tr>
    <tr valign="top">
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"> <object id=GR_MASTER2
                    width="100%" height=104 classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_O_MASTER">
                </object> </comment> <script> _ws_(_NSID_);</script></td>
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
<object id=BD_CUSTDETAIL classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_O_CUSTDETAIL>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=CUST_NAME     ctrl=EM_CUST_NAME    Param=Text</c>
            <c>col=HOME_PH       ctrl=EM_HOME_PH     Param=Text</c>
            <c>col=MOBILE_PH     ctrl=EM_MOBILE_PH   Param=Text</c>
            <c>col=SS_NO         ctrl=EM_SS_NO        Param=Text</c>
            <c>col=HOME_ADDR     ctrl=EM_HOME_ADDR    Param=Text</c>
            <c>col=POINT         ctrl=EM_POINT        Param=Text</c>
            <c>col=OCCURS_POINT  ctrl=EM_OCCURS_POINT Param=Text</c>
            <c>col=SUM_POINT     ctrl=EM_SUM_POINT    Param=Text</c>
            <c>col=EMAIL         ctrl=EM_EMAIL        Param=Text</c>
            <c>col=GRADE_NAME    ctrl=EM_CUST_GTADE   Param=Text</c>
            <c>col=CUST_TYPE_NM  ctrl=EM_CUST_TYPE    Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=BD_AMT classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_O_AMT>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            <c>col=GIFTCERT_AMT      ctrl=EM_GIFTCARD_AMT      Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
