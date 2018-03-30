<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽운영 > 승인처리>  영수증사후적립 (고객미등록)
 * 작 성 일    : 2010.03.23
 * 작 성 자    : jinjung.kim
 * 수 정 자    :    
 * 파 일 명    : DMBO6220.jsp
 * 버       전    : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개       요    :  
 * 이       력    :
 *           2010.03.23 (jinjung.kim) 신규작성
 *           2010.04.13 (fkl) 수정
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	String strSsNo	= (request.getParameter("strSsNo") != null && !"".equals(request.getParameter("strSsNo").trim())) ? request.getParameter("strSsNo") : "";	
	String strCardNo= (request.getParameter("strCardNo") != null && !"".equals(request.getParameter("strCardNo").trim())) ? request.getParameter("strCardNo") : "";	
%> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"        prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"            prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

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
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dcs.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--

var EXCEL_PARAMS = "";
var CARD_STAT_CD = "";
var ALREADY_ADD  = true;
var RD_COMP_PERS_FLAG_VALUE = "P";
var isSearch = false;

var recpStrCd = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.23
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 250;		//해당화면의 동적그리드top위치
function doInit() {
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GR_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GR_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";



    var GET_USER_AUTH_VALUE = getBrchUserAuth('<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />');
    recpStrCd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'; // 소속 점포
    
    DS_O_CUSTDETAIL.setDataHeader('<gauce:dataset name="H_CUST"/>'); //고객
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>'); //마스터
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>'); //디테일
    
    gridCreate1(); //그리드 초기화
    
    //검색조건
    /*
    if ("B" == GET_USER_AUTH_VALUE) {
    	initEmEdit(EM_Q_BRCH_ID,    "GEN^10",            READ);       //가맹점코드
        enableControl(IMG_BRCH,     false);
    } else {
        initEmEdit(EM_Q_BRCH_ID,    "GEN^10",            NORMAL);     //가맹점코드
        enableControl(IMG_BRCH,     true); 
    }
    */
    initEmEdit(EM_Q_BRCH_ID,    "GEN^10",            PK);       //가맹점코드

   
    initEmEdit(EM_Q_BRCH_NAME,    "GEN^40",              READ);       //가맹점명
    //initEmEdit(EM_Q_RECP_NO,      "GEN^16",              PK);         //영수증번호
    initEmEdit(EM_Q_RECP_NO,      "0-000000-0000-00000-0-0000000",              PK);         //영수증번호
    initEmEdit(EM_CARD_NO_CUT,    "00000000",            NORMAL);     //단축 카드번호
    initEmEdit(EM_CARD_NO_S,      "0000-0000-0000-0000", NORMAL);     //카드번호
    initEmEdit(EM_SS_NO_S,        "000000",      		 NORMAL);     //생년월일
    initEmEdit(EM_CUST_ID_S,      "GEN^9",               NORMAL);     //회원코드
    initEmEdit(EM_CUST_NAME_S,    "GEN^40",              READ);       //회원명
    
    //회원정보 
    initEmEdit(EM_CUST_NAME,   "GEN^40",              READ);       //회원명 
    initEmEdit(EM_HOME_PH,     "GEN^40",              READ);       //자택전화
    initEmEdit(EM_HOME_PH1,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH2,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH3,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_MOBILE_PH,   "GEN^40",              READ);       //이동전화 
    initEmEdit(EM_MOBILE_PH1,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH2,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH3,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_SS_NO,       "000000",      		  READ);       //생년월일
    initEmEdit(EM_HOME_ADDR,   "GEN^400",             READ);       //회원주소 
    initEmEdit(EM_POINT,       "NUMBER^9^0",          READ);       //누적포인트
//     initEmEdit(EM_OCCURS_POINT,"NUMBER^9^0",          READ);       //발생포인트
//     initEmEdit(EM_SUM_POINT,   "NUMBER^9^0",          READ);       //누적+발생포인트
    initEmEdit(EM_EMAIL,       "GEN^80",              READ);       //이메일주소
    initEmEdit(EM_EMAIL1,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_EMAIL2,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_CUST_GRADE,  "GEN^40",              READ);       //회원등급
    initEmEdit(EM_CUST_TYPE,   "GEN^40",     		  READ);       //회원유형
     
    //활성화 비활성화 화면 초기 설정
    EM_HOME_PH1.style.display    = "none";
    EM_HOME_PH2.style.display    = "none"; 
    EM_HOME_PH3.style.display    = "none";
    EM_MOBILE_PH1.style.display  = "none";
    EM_MOBILE_PH2.style.display  = "none";
    EM_MOBILE_PH3.style.display  = "none";
    EM_EMAIL1.style.display      = "none"; 
    EM_EMAIL2.style.display      = "none";
    EM_CUST_ID_H.style.display   = "none";
    EM_CARD_NO_H.style.display   = "none";
    EM_SS_NO_H.style.display     = "none";
    
    //default ;
    EM_Q_BRCH_ID.Text = '<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />'; //소속가맹점 
    setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_Q_BRCH_ID.Text);
    if (DS_O_RESULT.CountRow == 1 ) {
        EM_Q_BRCH_ID.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
        EM_Q_BRCH_NAME.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
    }

    if("<%=strSsNo%>" != "" || "<%=strCardNo%>" != ""){
    	EM_SS_NO_S.Text = "<%=strSsNo%>";
    	EM_CARD_NO_S.Text = "<%=strCardNo%>";    	
    }
    
    EM_Q_RECP_NO.focus();
}
/**
 * gridCreate1()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.23
 * 개       요     : 그리드 초기화  
 * return값 : void
 */ 
function gridCreate1() {
    var hdrProperies = '<FC>id={currow}    name="NO"        width=30   align=center  </FC>'
                     + '<FC>id=ITEM_NAME   name="상품명"    width=190  align=left    SumText="합계"  </FC>'
                     + '<FC>id=SALE_PRC    name="단가"      width=90   align=right   </FC>'
                     + '<FC>id=SALE_QTY    name="수량"      width=60   align=right   </FC>'
                     + '<FC>id=SALE_AMT    name="금액"      width=120  align=right   SumText=@sum </FC>'
                     + '<FC>id=PUMBUN_CD    name="품목코드"      width=120  align=right    Show=false</FC>'
                     + '<FC>id=TOT_SALE_AMT    name="총매출액"      width=120  align=right Show=false</FC>'
                     + '<FC>id=NORM_SALE_AMT    name="매출액"      width=120  align=right Show=false</FC>'
                     ;
                     
     var hdrProperies2 = '<FC>id=COL_NM        name="구분"      width=110   align=left  </FC>'
                       + '<FC>id=COL_VAL_DISP  name="자료"      width=150  align=left    </FC>';

    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    initGridStyle(GR_DETAIL, "common", hdrProperies2, false);

    GR_MASTER.ViewSummary = "1";
    GR_DETAIL.ViewHeader  = "false";
    GR_DETAIL.IndWidth    = "0"; 

    GR_DETAIL.ColumnProp("COL_NM", "bgcolor") = "#eaeef4";
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
     (3) 저장       - btn_Save()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.23
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 isSearch = true;
	 showMaster();
	 
	 
}

/**
 * btn_Excel()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.23
 * 개       요     : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    GR_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";

    var ExcelTitle = "영수증사후적립";
    openExcel2(GR_MASTER, ExcelTitle, EXCEL_PARAMS , true );
}

/**
 * btn_New()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010-02-25
 * 개       요     : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	 
	DS_O_CUSTDETAIL.ClearData();
    DS_IO_MASTER.ClearData();
    DS_IO_DETAIL.ClearData();
    EM_Q_RECP_NO.Text = "";
    EM_CARD_NO_CUT.Text = "";
    EM_CARD_NO_S.Text = "";
    EM_CARD_NO_H.Text = "";
    EM_SS_NO_S.Text = "";
    EM_SS_NO_H.Text = "";
	EM_CUST_ID_S.Text = "";
	EM_CUST_NAME_S.Text = "";
    initEmEdit(EM_SS_NO,          "000000",      READ);
}

/**
 * btn_Save()
 * 작 성 자 : jinjung.kim
 * 작 성 일 : 2010.03.23
 * 개       요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	 
	 
	 var StrCustName = DS_O_CUSTDETAIL.NameValue(1, "CUST_NAME");
	 
	 if (StrCustName ==  "미등록") {  //강연식
	        showMessage(EXCLAMATION, OK, "USER-1000",  "회원정보를 먼저입력 해야 합니다.");
	        return false;
	    }

    if ("1" == CARD_STAT_CD ) {
        //2014.01.16 형지 아트몰링 요청 메시지 수정
    	//showMessage(StopSign, OK, "USER-1000",  "해당 회원의 유효한 카드가 존재하지 않습니다. 영수증 사후 적립이 불가능한 회원입니다.");
        showMessage(StopSign, OK, "USER-1000",  "카드 중지 및 분실 되어 적립이 불가능 합니다.");
        return;
    }
    if (ALREADY_ADD == true) {
        showMessage(StopSign, OK, "USER-1000",  "이미 포인트 적립된 영수증입니다.");
        return;
    }
    if ( !check_data() ) return ;

    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
       return;
    }

    for (var j = 1; j <= 3; j++) { 
        var ds;
        switch (j) {
            case 1: ds = DS_O_CUSTDETAIL; break;
            case 2: ds = DS_IO_MASTER; break;
            case 3: ds = DS_IO_DETAIL; break;
        }
        for (var i = 1; i <= ds.CountRow; i++) {
            ds.NameValue(i, "FLAG") = "C";
        }
    }
   
    DS_I_DATA.ClearAll();
    DS_I_DATA.setDataHeader('BRCH_ID:STRING(15)');
    DS_I_DATA.Addrow();
    DS_I_DATA.NameValue(DS_I_DATA.CountRow, "BRCH_ID")    = EM_Q_BRCH_ID.Text;
    
    //var parameters  = "&strRecpNo="    + EM_Q_RECP_NO.Text;
    
    var goTo = "saveData";
    TR_SAVE.Action  ="/dcs/dmbo622.do?goTo="+goTo;
    TR_SAVE.KeyValue="SERVLET(I:DS_O_CUSTDETAIL=DS_O_CUSTDETAIL,I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL,I:DS_I_DATA=DS_I_DATA)";
    TR_SAVE.Post();  

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
function showMaster(){

	if (trim(EM_Q_BRCH_ID.Text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "가맹점코드는 필수입력항목입니다.");
        EM_Q_BRCH_ID.focus();
        return;
    }
    if (trim(EM_Q_BRCH_ID.Text).length != 10) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "가맹점코드의 길이는 10 자리입니다.");
        EM_Q_BRCH_ID.focus();
        return;
    }
    
	if (trim(EM_Q_RECP_NO.Text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "영수증번호는 필수입력항목입니다.");
        EM_Q_RECP_NO.focus();
        return;
    }
    if ((trim(EM_Q_RECP_NO.Text).length != 16) && (trim(EM_Q_RECP_NO.Text).length != 17) && (trim(EM_Q_RECP_NO.Text).length != 24)) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "영수증번호의 길이는 16 OR 24 자리입니다.");
        EM_Q_RECP_NO.focus();
        return;
    }
/*
    if (( EM_Q_BRCH_ID.Text.substring(2,3) == "1" ) && ( ( EM_Q_RECP_NO.Text.substring(7,8) != "1" ) && ( EM_Q_RECP_NO.Text.substring(7,8) != "2" ) ))  { 
    	showMessage(EXCLAMATION, OK, "USER-1000",  "가맹점과 영수증의 점이 불일치 합니다.");
        return;
    } 
    if (( EM_Q_BRCH_ID.Text.substring(2,3) == "3" ) && ( ( EM_Q_RECP_NO.Text.substring(7,8) != "3" ) ))  { 
    	showMessage(EXCLAMATION, OK, "USER-1000",  "가맹점과 영수증의 점이 불일치 합니다.");
        return;
    }  
*/    
    if(RD_COMP_PERS_FLAG.CodeValue == "P" && trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 
            && trim(EM_CARD_NO_S.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일],[회원명] 중 1개는  반드시 입력해야 합니다.");
        EM_CARD_NO_S.Focus();
        return;
    }else if(RD_COMP_PERS_FLAG.CodeValue == "C" && trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 
            && trim(EM_CARD_NO_S.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일],[법인명] 중 1개는  반드시 입력해야 합니다.");
        EM_CARD_NO_S.Focus();
        return;
    }else{
        // MARIO OUTLET
    	//if (trim(EM_CARD_NO_S.Text).length > 0 && trim(EM_CARD_NO_S.Text).length < 16) {
    	if(trim(EM_CARD_NO_S.Text).length != 0 && trim(EM_CARD_NO_S.Text).length != 13 && trim(EM_CARD_NO_S.Text).length != 16 ) {		
            showMessage(EXCLAMATION, OK, "USER-1000",  "카드번호는 13자리 또는 16자리입니다.");
            EM_CARD_NO_S.Focus();
            return;
        }
        if (RD_COMP_PERS_FLAG.CodeValue == "P" && (trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 6)) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "생년월일은 6자리입니다.");
            EM_SS_NO_S.Focus();
            return;
        }else if (RD_COMP_PERS_FLAG.CodeValue == "C" && (trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 10)) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "사업자등록번호는 10자리입니다.");
            EM_SS_NO_S.Focus();
            return;
        }
        if (RD_COMP_PERS_FLAG.CodeValue == "P" && trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "회원은 9자리입니다.");
            EM_CUST_ID_S.Text = "";
            EM_CUST_ID_S.Focus();
            return;
        }else if (RD_COMP_PERS_FLAG.CodeValue == "C" && trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "법인(단체)은 9자리입니다.");
            EM_CUST_ID_S.Text = "";
            EM_CUST_ID_S.Focus();
            return;
        }
    }
       
    /*    
    if(RD_COMP_PERS_FLAG.CodeValue == "P" && trim(EM_CARD_NO_S.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호]는  반드시 입력해야 합니다.");
        EM_CARD_NO_S.Focus();
        return;
    }else if(RD_COMP_PERS_FLAG.CodeValue == "C" ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [개인카드] 만 가능 합니다.");
        EM_CARD_NO_S.Focus();
        return;
    }else{
        // MARIO OUTLET
    	//if (trim(EM_CARD_NO_S.Text).length > 0 && trim(EM_CARD_NO_S.Text).length < 16) {
    	if(trim(EM_CARD_NO_S.Text).length != 0 && trim(EM_CARD_NO_S.Text).length != 13 && trim(EM_CARD_NO_S.Text).length != 16 ) {		
            showMessage(EXCLAMATION, OK, "USER-1000",  "카드번호는 13자리 또는 16자리입니다.");
            EM_CARD_NO_S.Focus();
            return;
        }
        if (RD_COMP_PERS_FLAG.CodeValue == "P" && (trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 6)) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "생년월일은 6자리입니다.");
            EM_SS_NO_S.Focus();
            return;
        }else if (RD_COMP_PERS_FLAG.CodeValue == "C" && (trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 10)) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "사업자등록번호는 10자리입니다.");
            EM_SS_NO_S.Focus();
            return;
        }
        if (RD_COMP_PERS_FLAG.CodeValue == "P" && trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "회원은 9자리입니다.");
            EM_CUST_ID_S.Text = "";
            EM_CUST_ID_S.Focus();
            return;
        }else if (RD_COMP_PERS_FLAG.CodeValue == "C" && trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "법인(단체)은 9자리입니다.");
            EM_CUST_ID_S.Text = "";
            EM_CUST_ID_S.Focus();
            return;
        }
    }
        */
        
    CARD_STAT_CD = "";
    ALREADY_ADD = true;

    var goTo        = "searchMaster";    
    var parameters  = "&BRCH_ID="        + encodeURIComponent(EM_Q_BRCH_ID.Text);
        parameters += "&RECP_NO="        + encodeURIComponent(EM_Q_RECP_NO.Text);
        parameters += "&CARD_NO="        + encodeURIComponent(EM_CARD_NO_S.Text);
        parameters += "&SS_NO="          + encodeURIComponent(EM_SS_NO_S.Text);
        parameters += "&CUST_ID="        + encodeURIComponent(EM_CUST_ID_S.Text);
        parameters += "&COMP_PERS_FLAG=" + encodeURIComponent(RD_COMP_PERS_FLAG.CodeValue);
    
    EXCEL_PARAMS = "회원구분="       + RD_COMP_PERS_FLAG.Text;
    EXCEL_PARAMS = "-가맹점="        + EM_Q_BRCH_ID.Text;
    EXCEL_PARAMS += "-가맹점명="     + EM_Q_BRCH_NAME.Text;
    EXCEL_PARAMS += "-영수증번호="   + EM_Q_RECP_NO.Text;
    EXCEL_PARAMS += "-카드번호="     + EM_CARD_NO_S.Text;
    EXCEL_PARAMS += "-생년월일=" + EM_SS_NO_S.Text;
    EXCEL_PARAMS += "-고객ID="       + EM_CUST_ID_S.Text;
    EXCEL_PARAMS += "-고객명="       + EM_CUST_NAME_S.Text;
    
    TR_MASTER.Action   = "/dcs/dmbo622.do?goTo=" + goTo + parameters;  
    TR_MASTER.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER,O:DS_O_CUSTDETAIL=DS_O_CUSTDETAIL,O:DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_MASTER.Post();
    
	//조회결과 Return
	setPorcCount("SELECT", DS_IO_MASTER.CountRow);
}
 /**
 * check_data()
 * 작 성 자 : jinjung.kim
 * 작 성 일 : 2010.03.23
 * 개       요 : 저장시 유효성 처리
 * return값 : void
 */
function check_data() {
    
    if (DS_O_CUSTDETAIL.CountRow <= 0) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "회원정보가 존재하지 않습니다.");
        return false;
    }

    if (DS_IO_MASTER.CountRow <= 0) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "해당 영수증의 내역이 존재하지 않습니다.");
        return false;
    }
    var ds = DS_IO_DETAIL;
    var OCC_POINT = 0;
    for (var i = 1; i <= ds.CountRow; i++) {
        if ("OCC_POINT" == ds.NameValue(i, "COL_ID")) {
            OCC_POINT = ds.NameValue(i, "COL_VAL");
            break;
        }
    }
    /*
    if (OCC_POINT == "" || OCC_POINT == 0) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "영수증 사용으로 인하여 발생한 적립포인트가 존재하지 않습니다.");
        DS_IO_DETAIL.RowPosition = DS_IO_DETAIL.CountRow;
        return false;
    }
    */
    return true;
}
 
/**
 * keyPressEvent()
 * 작 성 자 : jinjung.kim
 * 작 성 일 : 2010.03.23
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
     EM_Q_BRCH_NAME.Text = "";//조건입력시 코드초기화
    if (EM_Q_BRCH_ID.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_Q_BRCH_ID.Text.length == 10) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_Q_BRCH_ID.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
                EM_Q_BRCH_ID.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
                EM_Q_BRCH_NAME.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getBrchPop(EM_Q_BRCH_ID,EM_Q_BRCH_NAME);
            }
        }
    }
}
 
/**
 * gourl()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-29
 * 개      요  : 화면 이동
 * return값 : void
 */
function gourl(go,nm,s){
	try{
		frame01 = window.external.GetFrame(window);
		frame01.Provider('../').OuterWindow.showStatusBar(strMsg); 
	} catch(e){		
	}
	frame01.Provider('../').OuterWindow.top.leftFrame.urlLink(go.toUpperCase().substring(0,7),"/dcs/"+go+"?goTo=list&strCardNo="+EM_CARD_NO_S.Text+"&strSsNo="+EM_SS_NO_S.Text,s,"01",nm);
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
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
<script language=JavaScript for=TR_MASTER event=onSuccess>
    for(var i = 0; i < this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    }
    if (DS_O_CUSTDETAIL.CountRow > 0) {
        initEmEdit(EM_SS_NO,          "000000",      READ);
    } else {
        initEmEdit(EM_SS_NO,          "000000",      READ);
    }
    if (DS_IO_MASTER.CountRow > 0) {
        GR_MASTER.focus();
    } else {
        showMessage(StopSign, OK, "USER-1000",  "영수증 내역이 없습니다. 영수증 번호를 확인하세요.");

    	EM_Q_RECP_NO.focus();
    }
    CARD_STAT_CD = DS_O_CUSTDETAIL.NameValue(1, "CARD_STAT_CD");

    if (isSearch == true) {
	    if ("1" == CARD_STAT_CD ) {
	        showMessage(StopSign, OK, "USER-1000",  "해당 회원의 유효한 카드가 존재하지 않습니다. 영수증 사후 적립이 불가능한 회원입니다.");
	    } else {
	        
	        for (var i = 1; i <= DS_IO_DETAIL.CountRow; i++) {
	            if (DS_IO_DETAIL.NameValue(i, "COL_ID") == "OCC_POINT") {
	                if (DS_IO_DETAIL.NameValue(i, "COL_VAL") > 0) {
	                    ALREADY_ADD = true;
	                    showMessage(StopSign, OK, "USER-1000",  "이미 포인트 적립된 영수증입니다.");
	                } else {
	                    ALREADY_ADD = false;
	                }
	                break;
	            }
	        }
	    }
    }
    
    isSearch  = false;    
</script>
<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(var i = 0; i < this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    }
    showMaster();
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MASTER event=onFail>
    trFailed(TR_MASTER.ErrorMsg);
</script>
<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=RD_COMP_PERS_FLAG event=OnClick()>
    if (this.CodeValue == RD_COMP_PERS_FLAG_VALUE) return;
    RD_COMP_PERS_FLAG_VALUE = this.CodeValue ;
    if ("P" == this.CodeValue) 
    {
        document.getElementById('titleSsno1').innerHTML        = "생년월일";
        document.getElementById('titleSsno2').innerHTML        = "생년월일";
        document.getElementById('titleCustName1').innerHTML    = "회원명";
        document.getElementById('titleCustName').innerHTML     = "회원명";
        document.getElementById('titleHomeAddr').innerHTML     = "회원주소";
        document.getElementById('titleMobileOffiPH').innerHTML = "이동전화";
        document.getElementById('titleHomePH').innerHTML       = "자택전화";
        
        initEmEdit(EM_SS_NO_S,      "000000",      NORMAL);//생년월일
        initEmEdit(EM_SS_NO,        "000000",      READ);  //생년월일
    } 
    else if ("C" == CodeValue) 
    {
        document.getElementById('titleSsno1').innerHTML        = "사업자등록번호";
        document.getElementById('titleSsno2').innerHTML        = "사업자등록번호";
        document.getElementById('titleCustName1').innerHTML    = "법인(단체)명";
        document.getElementById('titleCustName').innerHTML     = "법인(단체)명";
        document.getElementById('titleHomeAddr').innerHTML     = "사업장주소";
        document.getElementById('titleMobileOffiPH').innerHTML = "담당자전화";
        document.getElementById('titleHomePH').innerHTML       = "대표전화";

        initEmEdit(EM_SS_NO_S,     "#00-00-00000",        NORMAL);     //사업자번호
        initEmEdit(EM_SS_NO,       "#00-00-00000",        READ);       //사업자번호
    }
    DS_IO_DETAIL.ClearData();
    DS_IO_MASTER.ClearData();
    
    EM_Q_RECP_NO.Text   = "";
    EM_CUST_ID_H.Text   = ""; 
    EM_CARD_NO_H.Text   = "";
    EM_SS_NO_H.Text     = "";
    EM_HOME_PH.Text     = ""; 
    EM_MOBILE_PH.Text   = ""; 
    EM_EMAIL.Text       = ""; 
    EM_CUST_ID_S.Text   = ""; 
    EM_CUST_NAME_S.Text = ""; 
    EM_CUST_NAME.Text   = "";
    EM_SS_NO.Text       = "";
    EM_CARD_NO_S.Text   = "";
    EM_SS_NO_S.Text     = "";
    EM_HOME_ADDR.Text   = "";
    EM_CUST_GRADE.Text  = "";
    EM_POINT.Text       = "";
</script>

<!-- 단축카드번호 onKillFocus() -->
<script language=JavaScript for=EM_CARD_NO_CUT event=onKillFocus()>
	if ( trim(EM_CARD_NO_CUT.Text).length != 0 ) {
    	EM_CARD_NO_S.Text = cardCheckDigit(EM_CARD_NO_CUT.Text);
    }
</script>
<!-- 회원ID onKillFocus() -->
<script language=JavaScript for=EM_CUST_ID_S event=onKillFocus()>
    if ((EM_CUST_ID_S.Modified) && (EM_CUST_ID_S.Text.length != 9)) {
        EM_CUST_NAME_S.Text = ""; 
        EM_CUST_NAME_S.Text = ""; 
        EM_CARD_NO_H.Text   = "";
        EM_SS_NO_H.Text     = "";
    } 
</script>
<script language=JavaScript for=EM_CUST_ID_S event=onKeyDown(kcode,scode)>
    if (!(kcode == 13 || kcode == 9)) EM_CUST_NAME_S.Text = "";
</script>

<script language=JavaScript for=EM_Q_BRCH_ID event=OnKeyUp(kcode,scode)>
    if (this.Text == "") {
        EM_Q_BRCH_NAME.Text = "";
        return ;
    }
    if (kcode == 13 || kcode == 9 || this.Text.length == 10) { //TAB,ENTER 키 실행시에만 
        setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", this.Text);
        if (DS_O_RESULT.CountRow == 1 ) {
            this.Text           = DS_O_RESULT.NameValue(1, "CODE_CD");
            EM_Q_BRCH_NAME.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
        } else {
            //1건 이외의 내역이 조회 시 팝업 호출
            getBrchPop(this, EM_Q_BRCH_NAME);
        }
    }
</script>
<!-- Grid DETAIL oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>


<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                              *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                  *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- ===============- Output용 -->
<comment id="_NSID_">
  <object id="DS_IO_MASTER"  classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_IO_DETAIL"  classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CUSTDETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_I_CONDITION"  classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_O_RESULT"  classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_DATA" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
  <object id="TR_MASTER" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
  </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
  </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
  </object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                 *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GR_DETAIL");
    
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
<!--* E. 본문시작                                                           *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="57" style="display : none">회원구분</th>
						<td width="170" style="display : none"><comment id="_NSID_"> <object
							id=RD_COMP_PERS_FLAG classid=<%=Util.CLSID_RADIO%>
							style="height: 20; width: 140" tabindex=1>
							<param name=Cols value="2">
							<param name=Format value="P^개인카드,C^법인카드">
							<param name=CodeValue value="P">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="76" class="point">가맹점코드</th>
						<td width="170"><comment id="_NSID_"> <object
							id=EM_Q_BRCH_ID classid=<%=Util.CLSID_EMEDIT%> width="71"
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
						<img id="IMG_BRCH" src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							align="absmiddle"  onclick="getBrchPop(EM_Q_BRCH_ID,EM_Q_BRCH_NAME)" /> 
							 <comment
							id="_NSID_"> <object id=EM_Q_BRCH_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
						<th width="80" class="point">영수증번호</th>
						<td colspan="3"><comment id="_NSID_"> <object id=EM_Q_RECP_NO
							classid=<%=Util.CLSID_EMEDIT%> width=190 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width="57">카드번호</th>
						<td width="170"><comment id="_NSID_"> <object style="display : none"
							id=EM_CARD_NO_CUT classid=<%=Util.CLSID_EMEDIT%> width="55"
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
						    <comment id="_NSID_"> <object
							id=EM_CARD_NO_S classid=<%=Util.CLSID_EMEDIT%> width="155"
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80"><span id="titleSsNo1" style="Color: 146ab9">생년월일</span></th>
						<td width="170"><comment id="_NSID_"> <object
							id=EM_SS_NO_S classid=<%=Util.CLSID_EMEDIT%> width=166 tabindex=1></object>
						</comment> <script> _ws_(_NSID_);</script></td>
						<th width="80"><span id="titleCustName1" style="Color: 146ab9">회원명</span></th>
						<td><comment id="_NSID_"> <object id=EM_CUST_ID_H
							classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object>
						</comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_"> <object
							id=EM_CARD_NO_H classid=<%=Util.CLSID_EMEDIT%> tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
							id="_NSID_"> <object id=EM_SS_NO_H
							classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object>
						</comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_"> <object
							id=EM_CUST_ID_S classid=<%=Util.CLSID_EMEDIT%> width=67
							tabindex=1
							onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CUST_ID_S',RD_COMP_PERS_FLAG.CodeValue);"
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							onclick="getCompPop(EM_CUST_ID_S,EM_CUST_NAME_S,RD_COMP_PERS_FLAG.CodeValue)" /> <comment
							id="_NSID_"> <object id=EM_CUST_NAME_S
							classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"></object>
						</comment> <script> _ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
	    <td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
			  <tr>
			    <td class="btn_l" style="display : none"> </td>
			    <td class="btn_c" style="display : none"><a href="#" onclick="gourl('dctm203.dm','개인회원조회/수정','DCTM')">개인회원조회/수정</a></td>
			    <td class="btn_r" style="display : none"></td>
			    <td class="btn_l" style="display : none"> </td>
			    <td class="btn_c" style="display : none"><a href="#" onclick="gourl('dctm201.dm','개인카드조회','DCTM')">개인카드조회</a></td>
			    <td class="btn_r" style="display : none"></td>
			    <td class="btn_l"> </td>
			    <td class="btn_c"><a href="#" onclick="gourl('dctm301.dm','포인트조회','DCTM')">포인트조회</a></td>
			    <td class="btn_r"></td>
			    <td class="btn_l"> </td>
			    <td class="btn_c"><a href="#" onclick="gourl('dmbo715.do','포인트조회(회원미등록)','DMBO')">포인트조회(회원미등록)</a></td>
			    <td class="btn_r"></td>
			    <td class="btn_l" style="display : none"> </td>
			    <td class="btn_c" style="display : none"><a href="#" onclick="gourl('dmbo617.do','회원정보안내(소멸예정)','DMBO')">회원정보안내(소멸예정)</a></td>
			    <td class="btn_r" style="display : none"></td>
			    <td class="btn_l" style="display : none"> </td>
			    <td class="btn_c" style="display : none"><a href="#" onclick="gourl('dctm116.dm','회원메모관리(신규)','DCTM')">회원메모관리(신규)</a></td>
			    <td class="btn_r" style="display : none"></td>			    
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
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80"><span id="titleCustName" style="Color: 146ab9">회원명</span></th>
						<td width="150"><comment id="_NSID_"> <object
							id=EM_CUST_NAME classid=<%=Util.CLSID_EMEDIT%> width=140
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80"><span id="titleHomePH" style="Color: 146ab9">자택전화</span></th>
						<td width="170"><comment id="_NSID_"> <object
							id=EM_HOME_PH classid=<%=Util.CLSID_EMEDIT%> width=166 tabindex=1></object>
						</comment> <script> _ws_(_NSID_);</script></td>
						<th width="80"><span id="titleMobileOffiPH"
							style="Color: 146ab9">이동전화</span></th>
						<td><comment id="_NSID_"> <object id=EM_MOBILE_PH
							classid=<%=Util.CLSID_EMEDIT%> width=173 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width="80"><span id="titleSsNo2" style="Color: 146ab9">생년월일</span></th>
						<td><comment id="_NSID_"> <object id=EM_SS_NO
							classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th><span id="titleHomeAddr" style="Color: 146ab9">회원주소</span></th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_HOME_ADDR classid=<%=Util.CLSID_EMEDIT%> width=444
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>가용포인트</th>
						<td><comment id="_NSID_"> <object id=EM_POINT
							classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>이메일주소</th>
						<td><comment id="_NSID_"> <object id=EM_EMAIL
							classid=<%=Util.CLSID_EMEDIT%> width=166 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>회원등급</th>
						<td><comment id="_NSID_"> <object id=EM_CUST_GRADE
							classid=<%=Util.CLSID_EMEDIT%> width=173 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						<comment id="_NSID_"> <object id=EM_HOME_PH1
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						<comment id="_NSID_"> <object id=EM_HOME_PH2
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						<comment id="_NSID_"> <object id=EM_HOME_PH3
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						<comment id="_NSID_"> <object id=EM_MOBILE_PH1
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						<comment id="_NSID_"> <object id=EM_MOBILE_PH2
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						<comment id="_NSID_"> <object id=EM_MOBILE_PH3
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						<comment id="_NSID_"> <object id=EM_EMAIL1
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						<comment id="_NSID_"> <object id=EM_EMAIL2
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>발생포인트</th>
						<td><comment id="_NSID_"> <object id=EM_OCCURS_POINT
							classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>가용+발생</th>
						<td><comment id="_NSID_"> <object id=EM_SUM_POINT
							classid=<%=Util.CLSID_EMEDIT%> width=166 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>회원유형</th>
						<td colspan="4"><comment id="_NSID_"> <object id=EM_CUST_TYPE
							classid=<%=Util.CLSID_EMEDIT%> width=173 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>						
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr valign="top">
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td valign="top">
                <table width="525" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td width="525" rowspan="3"><comment id="_NSID_"> <object
                            id=GR_MASTER width="525" height=357 classid=<%=Util.CLSID_GRID%>
                            tabindex=1>
                            <param name="DataID" value="DS_IO_MASTER">
                        </object> </comment> <script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
                <td width="30">&nbsp;</td>
                <td width="100%">
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <object id=GR_DETAIL
                            height=357 width="100%" classid=<%=Util.CLSID_GRID%> tabindex=1>
                            <param name="DataID" value="DS_IO_DETAIL">
                        </object> </comment> <script>_ws_(_NSID_);</script></td>
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
<object id=BD_CUSTDETAIL classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_O_CUSTDETAIL>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            <c>col=CUST_NAME     ctrl=EM_CUST_NAME    Param=Text</c>
            <c>col=HOME_PH1      ctrl=EM_HOME_PH      Param=Text</c>
            <c>col=HOME_PH1      ctrl=EM_HOME_PH1     Param=Text</c>
            <c>col=HOME_PH2      ctrl=EM_HOME_PH2     Param=Text</c>
            <c>col=HOME_PH3      ctrl=EM_HOME_PH3     Param=Text</c>
            <c>col=MOBILE_PH1    ctrl=EM_MOBILE_PH    Param=Text</c>
            <c>col=MOBILE_PH1    ctrl=EM_MOBILE_PH1   Param=Text</c>
            <c>col=MOBILE_PH2    ctrl=EM_MOBILE_PH2   Param=Text</c>
            <c>col=MOBILE_PH3    ctrl=EM_MOBILE_PH3   Param=Text</c>
            <c>col=SS_NO         ctrl=EM_SS_NO        Param=Text</c>
            <c>col=HOME_ADDR     ctrl=EM_HOME_ADDR    Param=Text</c>
            <c>col=POINT         ctrl=EM_POINT        Param=Text</c>
            <c>col=OCCURS_POINT  ctrl=EM_OCCURS_POINT Param=Text</c>
            <c>col=SUM_POINT     ctrl=EM_SUM_POINT    Param=Text</c>
            <c>col=EMAIL1        ctrl=EM_EMAIL        Param=Text</c>
            <c>col=EMAIL1        ctrl=EM_EMAIL1       Param=Text</c>
            <c>col=EMAIL2        ctrl=EM_EMAIL2       Param=Text</c>
            <c>col=GRADE_NAME    ctrl=EM_CUST_GRADE   Param=Text</c>
            <c>col=CTYPE_NAME    ctrl=EM_CUST_TYPE    Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

