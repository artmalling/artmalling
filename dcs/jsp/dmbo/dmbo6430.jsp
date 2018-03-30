<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 고객관리 > 포인트운영 > 영수증적립취소
 * 작 성 일 : 2017.09.11
 * 작 성 자 : jyk
 * 수 정 자 : 
 * 파 일 명 : dmbo6430.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 영수증 적립 내용을 취소한다.
 * 이    력 :
 *        2016.12.01 (jyk) 신규작성 
 ******************************************************************************/
--> 
<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="common.vo.SessionInfo" %>
<%@ page import="common.util.Util"  %>
<%@ page import="kr.fujitsu.ffw.base.BaseProperty"  %>
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
var RD_COMP_PERS_FLAG_VALUE = "P";
var isSearch = false; 

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 
 /**
 * doInit()
 * 작 성 자     : jyk
 * 작 성 일     : 2017-09-11
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 300;		//해당화면의 동적그리드top위치
 function doInit() {
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GR_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GR_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    var GET_USER_AUTH_VALUE = getBrchUserAuth('<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />'); 
    
    
    DS_O_CUSTDETAIL.setDataHeader('<gauce:dataset name="H_CUST"/>'); //고객
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>'); //마스터
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>'); //디테일
    
    //그리드 초기화
    gridCreate1();
    gridCreate2();
    
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
    initEmEdit(EM_Q_BRCH_ID,    "GEN^10",            PK);         	  //가맹점코드

   
    initEmEdit(EM_Q_BRCH_NAME,    "GEN^40",              READ);       //가맹점명
    //initEmEdit(EM_Q_RECP_NO,      "GEN^16",              PK);       //영수증번호
    //initEmEdit(EM_Q_RECP_NO,      "GEN^24",              PK);         //영수증번호
    initEmEdit(EM_Q_RECP_NO,    "000000000000000000000000", NORMAL);         //영수증번호
    
    initEmEdit(EM_CARD_NO_CUT,    "00000000",            NORMAL);     //단축 카드번호
    initEmEdit(EM_CARD_NO_S,      "0000-0000-0000-0", NORMAL);     //카드번호
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
    
    getStore("DS_O_S_STR", "N", "", "N"); //점코드
    
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
 }
 
 /**
 * gridCreate1()
 * 작 성 자     : jyk
 * 작 성 일     : 2017-09-11
 * 개       요     : 그리드 초기화  
 * return값 : void
 */ 
 function gridCreate1() {  
    var hdrProperies = '<FC>id={currow}        name="NO"         width=30   	align=center  </FC>'  
                     + '<FC>id=STR_CD          name="점"    	     width=130  	align=left    Editstyle=lookup    Data="DS_O_S_STR:CODE:NAME" </FC>'
                     + '<FC>id=SALE_DT         name="매출일자"      width=90   	align=center  Mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=POS_NO          name="POS번호"      width=60   	align=center  </FC>'
                     + '<FC>id=TRAN_NO         name="거래번호"      width=80  		align=center  </FC>'
                     + '<FC>id=TRAN_FLAG   	   name="거래구분"      width=120  	align=center  Show=false</FC>'
                     + '<FC>id=TRAN_TYPE   	   name="거래형태"      width=120  	align=center  Show=false</FC>'
                     + '<FC>id=SALE_TOT_AMT    name="총매출액"      width=110  	align=right   SumText=""</FC>'
                     + '<FC>id=OCC_POINT	   name="적립포인트"    width=110  	align=right   SumText=""</FC>'
                     ;
                      
    initGridStyle(GR_MASTER, "common", hdrProperies, false); 
    GR_MASTER.ViewSummary = "1";  
 }
 
 /**
 * gridCreate2()
 * 작 성 자     : jyk
 * 작 성 일     : 2017-09-11
 * 개       요     : 그리드 초기화  
 * return값 : void
 */ 
 function gridCreate2() {
    var hdrProperies = '<FC>id={currow}    name="NO"        width=30   align=center  </FC>'
                     + '<FC>id=ITEM_NAME   name="상품명"    width=190  align=left    SumText="합계"  </FC>'
                     + '<FC>id=SALE_PRC    name="단가"      width=90   align=right   </FC>'
                     + '<FC>id=SALE_QTY    name="수량"      width=60   align=right   SumText=@sum</FC>'
                     + '<FC>id=SALE_AMT    name="금액"      width=120  align=right   SumText=@sum </FC>'
                     + '<FC>id=PUMBUN_CD    name="품목코드"      width=120  align=right    Show=false</FC>'
                     + '<FC>id=TOT_SALE_AMT    name="총매출액"      width=120  align=right Show=false</FC>'
                     + '<FC>id=NORM_SALE_AMT    name="매출액"      width=120  201align=right Show=false</FC>'
                     ;
                      
    initGridStyle(GR_DETAIL, "common", hdrProperies, false);
    GR_DETAIL.ViewSummary = "1";  
 } 
 
/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
     (3) 저장       - btn_Save()
 *************************************************************************/

 /**
 * btn_Search()
 * 작 성 자     : jyk
 * 작 성 일     : 2017-09-11
 * 개       요     : 조회시 호출
 * return값 : void
 */
 function btn_Search(){
    
	// isSearch = true;
	
	//그리드 초기화 
    DS_O_CUSTDETAIL.ClearData();
    DS_IO_MASTER.ClearData();
    DS_IO_DETAIL.ClearData();
    /*
	if(!checkValidation("Search"))    // validation 체크
	   return;
	    
	CARD_STAT_CD = "";  
	
	// 조회조건 셋팅    
	var strBrchId    = encodeURIComponent(EM_Q_BRCH_ID.Text);      		// 가맹점번호 
	var strRecpNo    = encodeURIComponent(EM_Q_RECP_NO.Text);      		// 영수증번호
	var strCardNo    = encodeURIComponent(EM_CARD_NO_S.Text);      		// 카드번호
	var strSsNo      = encodeURIComponent(EM_SS_NO_S.Text);        		// 생년월일
	var strCustId    = encodeURIComponent(EM_CUST_ID_S.Text);     	 	// 회원
	var strCompFlag  = encodeURIComponent(RD_COMP_PERS_FLAG.CodeValue); // 회원구분
	   
	var parameters =  "&strFlag=Search_Cust"
					+ "&strBrchId="	+ encodeURIComponent(strBrchId)    
	                + "&strRecpNo="	+ encodeURIComponent(strRecpNo)
	                + "&strCardNo="	+ encodeURIComponent(strCardNo)
	                + "&strSsNo="	+ encodeURIComponent(strSsNo)
	                + "&strCustId="	+ encodeURIComponent(strCustId)     
	                + "&strCompFlag="	+ encodeURIComponent(strCompFlag)     
	                ; 
	
	EXCEL_PARAMS = "회원구분="   + RD_COMP_PERS_FLAG.Text;
	EXCEL_PARAMS = "-가맹점="    + EM_Q_BRCH_ID.Text;
	EXCEL_PARAMS += "-가맹점명="  + EM_Q_BRCH_NAME.Text;
	EXCEL_PARAMS += "-영수증번호=" + EM_Q_RECP_NO.Text;
	EXCEL_PARAMS += "-카드번호="    + EM_CARD_NO_S.Text;
	EXCEL_PARAMS += "-생년월일=" 	   + EM_SS_NO_S.Text;
	EXCEL_PARAMS += "-고객ID="      + EM_CUST_ID_S.Text;
	EXCEL_PARAMS += "-고객명="       + EM_CUST_NAME_S.Text;
	
	TR_CUST.Action   = "/dcs/dmbo643.do?goTo=searchCust"+ parameters;  
	TR_CUST.KeyValue = "SERVLET(O:DS_O_CUSTDETAIL=DS_O_CUSTDETAIL)"; 
	TR_CUST.Post(); 
	*/
 }

 /**
 * btn_Excel()
 * 작 성 자     : jyk
 * 작 성 일     : 2017-09-11
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
 * 작 성 자     : jyk
 * 작 성 일     : 2017-09-11
 * 개       요     : 신규 버튼시 호출
 * return값 : void
 */
 function btn_New() {
	
	//그리드 초기화 
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
    EM_Q_RECP_NO.Enable = "true";
    
 }

 /**
 * btn_Save()
 * 작 성 자     : jyk
 * 작 성 일     : 2017-09-11
 * 개       요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {   
    
	//if(!checkValidation("Save"))    // validation 체크
	//	   return;

    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
       return;
    } 
     
    for (var j = 1; j <= 2; j++) { 
        var ds;
        switch (j) {
            //case 1: ds = DS_O_CUSTDETAIL; break;
            case 1: ds = DS_IO_MASTER; break;
            case 2: ds = DS_IO_DETAIL; break;
        }
        for (var i = 1; i <= ds.CountRow; i++) {
            ds.NameValue(i, "FLAG") = "C";
        }
    }
    
    var goTo = "save";
    TR_SAVE.Action  ="/dcs/dmbo643.do?goTo="+goTo;
    TR_SAVE.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)";
    TR_SAVE.Post();   
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
 /**
  * getRecpInfo()
  * 작 성 자     : jyk
  * 작 성 일     : 2016-11-28
  * 개    요        : 영수증 내역 마스터 조회한다.
  * return값 : void
  */ 
 function getRecpInfo(){ 
	  DS_IO_RECPINFO.ClearData();
 	// 조회조건 셋팅   
    var strBrchId    = encodeURIComponent(EM_Q_BRCH_ID.Text); // 가맹점번호 
 	var strRecpNo    = encodeURIComponent(EM_Q_RECP_NO.Text); // 영수증번호
 	
 	// validation 체크
	if(!checkValidation("Search_RecpInfo"))    
		   return;
 	
 	var parameters =  "&strBrchId="	+ encodeURIComponent(strBrchId)    
 	                + "&strRecpNo="	+ encodeURIComponent(strRecpNo)   
 	                ; 

 	TR_MASTER.Action   = "/dcs/dmbo643.do?goTo=searchMaster"+parameters;   
 	TR_MASTER.KeyValue = "SERVLET(O:DS_IO_RECPINFO=DS_IO_RECPINFO)"; //조회는 O
 	TR_MASTER.Post();   
 	
 	//조회결과 Return
	setPorcCount("SELECT", DS_IO_RECPINFO.CountRow);
	
 	if(DS_IO_RECPINFO.CountRow > 0 ){
	 	for(i=0; i < DS_IO_RECPINFO.CountRow; i++){  
	 		DS_IO_MASTER.Addrow();    
	 		DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"BRCH_ID") = DS_IO_RECPINFO.NameValue(DS_IO_RECPINFO.RowPosition,"BRCH_ID"); 	//가맹점번호
	 		DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CD") = DS_IO_RECPINFO.NameValue(DS_IO_RECPINFO.RowPosition,"STR_CD");	 	//점코드
	 		DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"SALE_DT") = DS_IO_RECPINFO.NameValue(DS_IO_RECPINFO.RowPosition,"SALE_DT"); 	//매출일자	
	 		DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"POS_NO") = DS_IO_RECPINFO.NameValue(DS_IO_RECPINFO.RowPosition,"POS_NO");   	//pos번호
	 		DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"TRAN_NO") = DS_IO_RECPINFO.NameValue(DS_IO_RECPINFO.RowPosition,"TRAN_NO"); 	//거래번호
	 		DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"TRAN_FLAG") = DS_IO_RECPINFO.NameValue(DS_IO_RECPINFO.RowPosition,"TRAN_FLAG");//거래구분
	 		DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"TRAN_TYPE") = DS_IO_RECPINFO.NameValue(DS_IO_RECPINFO.RowPosition,"TRAN_TYPE");//거래형태
	 		DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"SALE_TOT_AMT") = DS_IO_RECPINFO.NameValue(DS_IO_RECPINFO.RowPosition,"SALE_TOT_AMT"); //판매합계금액 
	 		
	 		//영수증번호 중복 체크
	 	    if ( fnCheckDupKey() == false ) {
	 	        return false;
	 	    }
	 	
	 	//영수증내역 상세 조회
	 	getRecpInfo_dtl();
	 	getRecpInfo_cust(); 
 	}
	}
 	//영수증번호 초기화
 	EM_Q_RECP_NO.Focus();
 	EM_Q_RECP_NO.Text = "";
 } 

 /**
  * getRecpInfo_dtl()
  * 작 성 자     : jyk
  * 작 성 일     : 2016-11-28
  * 개    요        : 영수증 내역을 상세 조회한다.
  * return값 : void
  */ 
 function getRecpInfo_dtl(){ 
	   
    var strBrchId    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BRCH_ID");  // 가맹점번호 
    // 영수증번호[24] => (매출일자(8)+000+점코드(2)+POS번호(4)+거래번호(5)+매출구분(1)+"0")
 	var strRecpNo    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SALE_DT") + "000"
 	                 + DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD")
 	                 + DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "POS_NO") 
 	                 + DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TRAN_NO")  
 	                 + DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TRAN_TYPE")+"0";  
	
 	var parameters =  "&strBrchId="	+ encodeURIComponent(strBrchId)    
 	                + "&strRecpNo="	+ encodeURIComponent(strRecpNo)   
 	                ;
 	
 	TR_MAIN.Action   = "/dcs/dmbo643.do?goTo=searchDetail"+parameters;   
 	TR_MAIN.KeyValue = "SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
 	TR_MAIN.Post();  
 	
 	
 	EM_Q_RECP_NO.Focus();
 	EM_Q_RECP_NO.SelStart = 0;
 	EM_Q_RECP_NO.SelLength = 1;
 } 

 

 /**
  * getRecpInfo_cust()
  * 작 성 자     : jyk
  * 작 성 일     : 2016-11-28
  * 개    요        : 적립회원을 조회한다.
  * return값 : void
  */ 
 function getRecpInfo_cust(){ 
	   
    
 	var strSaleDt	= DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SALE_DT");
 	var strStrCd    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
 	var strPosNo    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "POS_NO"); 
 	var strTranNo   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TRAN_NO");  
 	var strCustId   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CUST_ID");
 	var numPoint    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "OCC_POINT");
 	                
	
 	var parameters =  "&strSaleDt="	+ encodeURIComponent(strSaleDt)    
 	                + "&strStrCd="	+ encodeURIComponent(strStrCd)
 	                + "&strPosNo="	+ encodeURIComponent(strPosNo)
 	                + "&strTranNo="	+ encodeURIComponent(strTranNo)
 	                ;
 	
 	TR_CUST.Action   = "/dcs/dmbo643.do?goTo=searchCust"+parameters;   
 	TR_CUST.KeyValue = "SERVLET(O:DS_O_CUSTDETAIL=DS_O_CUSTDETAIL)"; //조회는 O
 	TR_CUST.Post();  
 	
 	
	if (strCustId==''||numPoint==0) {
		DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "OCC_POINT") = DS_O_CUSTDETAIL.NameValue(1, "OCC_POINT");
		DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CUST_ID") = DS_O_CUSTDETAIL.NameValue(1, "CUST_ID");
		DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ENTR_PATH_CD") = DS_O_CUSTDETAIL.NameValue(1, "ENTR_PATH_CD");
		DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "EXE_TYPE") = DS_O_CUSTDETAIL.NameValue(1, "EXE_TYPE");
		
		//alert(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "EXE_TYPE"));
	}
 	
 	//EM_Q_RECP_NO.Focus();
 	//EM_Q_RECP_NO.SelStart = 0;
 	//EM_Q_RECP_NO.SelLength = 1;
 } 
 
 /**
 * checkValidation()
 * 작 성 자     : jyk
 * 작 성 일     : 2016-11-28
 * 개    요        : 조회조건 값 체크 
 * return값 : void
 */
 function checkValidation(Gubun) {
       
    //조회버튼 클릭시 Validation Check
	if(Gubun == "Search") { 
		if (trim(EM_Q_BRCH_ID.Text).length == 0) {
			showMessage(EXCLAMATION, OK, "USER-1000",  "가맹점코드는 필수입력항목입니다.");
			EM_Q_BRCH_ID.focus();
			return false;
		}
		if (trim(EM_Q_BRCH_ID.Text).length != 10) {
		    showMessage(EXCLAMATION, OK, "USER-1000",  "가맹점코드의 길이는 10 자리입니다.");
		    EM_Q_BRCH_ID.focus();
		    return false;
		}
	      
		if(RD_COMP_PERS_FLAG.CodeValue == "P" && trim(EM_SS_NO_S.Text).length == 0 && 
			trim(EM_CUST_ID_S.Text).length == 0 && trim(EM_CARD_NO_S.Text).length == 0) {
		    showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일],[회원명] 중 1개는  반드시 입력해야 합니다.");
		    EM_CARD_NO_S.Focus();
		    return false;
		} else if(RD_COMP_PERS_FLAG.CodeValue == "C" && trim(EM_SS_NO_S.Text).length == 0 && 
			trim(EM_CUST_ID_S.Text).length == 0 && trim(EM_CARD_NO_S.Text).length == 0){
		    showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일],[법인명] 중 1개는  반드시 입력해야 합니다.");
		    EM_CARD_NO_S.Focus();
		    return false;
		} else { 
			if(trim(EM_CARD_NO_S.Text).length != 0 && trim(EM_CARD_NO_S.Text).length != 13 && trim(EM_CARD_NO_S.Text).length != 16 ) {		
		        showMessage(EXCLAMATION, OK, "USER-1000",  "카드번호는 13자리 또는 16자리입니다.");
		        EM_CARD_NO_S.Focus();
		        return false;
		    }
			
		    if (RD_COMP_PERS_FLAG.CodeValue == "P" && (trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 6)) {
		        showMessage(EXCLAMATION, OK, "USER-1000",  "생년월일은 6자리입니다.");
		        EM_SS_NO_S.Focus();
		        return false;
		    } else if (RD_COMP_PERS_FLAG.CodeValue == "C" && (trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 10)) {
		        showMessage(EXCLAMATION, OK, "USER-1000",  "사업자등록번호는 10자리입니다.");
		        EM_SS_NO_S.Focus();
		        return false;
		    }
		    
		    if (RD_COMP_PERS_FLAG.CodeValue == "P" && trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9) {
		        showMessage(EXCLAMATION, OK, "USER-1000",  "회원은 9자리입니다.");
		        EM_CUST_ID_S.Text = "";
		        EM_CUST_ID_S.Focus();
		        return false;
		    } else if (RD_COMP_PERS_FLAG.CodeValue == "C" && trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9) {
		        showMessage(EXCLAMATION, OK, "USER-1000",  "법인(단체)은 9자리입니다.");
		        EM_CUST_ID_S.Text = "";
		        EM_CUST_ID_S.Focus();
		        return false;
		    }
		} 
	}
    
    //영수증 내역 마스터 조회시 Validation Check
    if(Gubun == "Search_RecpInfo"){
	    //if (DS_O_CUSTDETAIL.CountRow <= 0) {
	    //    showMessage(EXCLAMATION, OK, "USER-1000",  "회원정보가 존재하지 않습니다.");
	     //   return false;
	    //}
    }
    
    
	// 저장버튼 클릭시 Validation Check
	if(Gubun == "Save"){ 
		
		var StrCustName = DS_O_CUSTDETAIL.NameValue(1, "CUST_NAME");
		
		if (StrCustName ==  "미등록") {  //강연식
		       showMessage(EXCLAMATION, OK, "USER-1000",  "회원정보를 먼저입력 해야 합니다.");
		       return false;
		}
		
	    if (DS_O_CUSTDETAIL.CountRow <= 0) {
	        showMessage(EXCLAMATION, OK, "USER-1000",  "회원정보가 존재하지 않습니다.");
	        return false;
	    }

	    if (DS_IO_MASTER.CountRow <= 0) {
	        showMessage(EXCLAMATION, OK, "USER-1000",  "해당 영수증의 내역이 존재하지 않습니다.");
	        return false;
	    } 
	    if ("0" != CARD_STAT_CD ) {
	        //2014.01.16 형지 아트몰링 요청 메시지 수정
	        showMessage(StopSign, OK, "USER-1000",  "카드 중지 및 분실 되어 적립이 불가능 합니다.");
	        return;
	    }
	} 
	
	return true; 
 } 

 /**
  * fnCheckDupKey()
  * 작 성 자     : jyk
  * 작 성 일     : 2017-09-11
  * 개    요        : 중복 영수증 체크 
  * return값 : void
  */ 
 function fnCheckDupKey() {
	  
     var dupRow = checkDupKey(DS_IO_MASTER, "STR_CD||SALE_DT||POS_NO||TRAN_NO");
     if (dupRow > 0) {
        showMessage(STOPSIGN, OK, "USER-1000", "중복된 영수증 번호 입니다. 영수증 번호를 확인해주세요");
        DS_IO_MASTER.DeleteRow(dupRow);
        EM_Q_RECP_NO.text = "";
        return false;
     }else{
        return true;
     }
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
  * btn_delRow()
  * 작 성 자     : jyk
  * 작 성 일     : 2017-09-11
  * 개    요 : 행삭제버튼 클릭시 
  * return값 : void
  */
 function btn_delRow(){
 	if( DS_IO_MASTER.CountRow < 1){
         showMessage(INFORMATION, OK, "USER-1019"); 
         return;     
 	} 
 	DS_IO_MASTER.deleteRow(DS_IO_MASTER.RowPosition);    
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
<script language=JavaScript for=TR_CUST event=onSuccess>
    for(var i = 0; i < this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    }
    if (DS_O_CUSTDETAIL.CountRow > 0) {
        initEmEdit(EM_SS_NO,          "000000",      READ); 
    } else {
        initEmEdit(EM_SS_NO,          "000000",      READ);
    } 
    
    //카드상태코드
    //CARD_STAT_CD = DS_O_CUSTDETAIL.NameValue(1, "CARD_STAT_CD");
 
    //if (isSearch == true) {
	//    if ("0" != CARD_STAT_CD ) {
	//        showMessage(StopSign, OK, "USER-1000",  "해당 회원의 유효한 카드가 존재하지 않습니다. 영수증 사후 적립이 불가능한 회원입니다.");
	//    }  
   // }
    
   // isSearch  = false; 
    EM_Q_RECP_NO.focus();
</script>

<script language=JavaScript for=TR_MASTER event=onSuccess>
    for(var i = 0; i < this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    } 
     
    if(DS_IO_RECPINFO.CountRow == 0){
        showMessage(StopSign, OK, "USER-1000",  "영수증 번호를 확인해주세요."); 
        EM_Q_RECP_NO.Text = ""; 
        EM_Q_RECP_NO.Focus();
    }
    EM_Q_RECP_NO.Focus();
</script>

<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(var i = 0; i < this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    } 
    //재조회
    btn_Search(); 
    
    //영수증번호 enable 처리 
    EM_Q_RECP_NO.Text = ""; 
    //EM_Q_RECP_NO.Enable = "false";  
</script>

<script language=JavaScript for=TR_MAIN event=onSuccess>
    EM_Q_RECP_NO.Focus();
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_CUST event=onFail>
    trFailed(TR_CUST.ErrorMsg);
</script>
<script language=JavaScript for=TR_MASTER event=onFail>
    trFailed(TR_MASTER.ErrorMsg);
</script>  
<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)> 
    if(clickSORT) return;  
    if(row == 0){ 
    	DS_IO_MASTER.ClearData();
    } 
    //영수증 상세 조회
    getRecpInfo_dtl();
    //회원정보 조회
    getRecpInfo_cust();
</script>   

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------> 
<!-- 회원구분 이벤트 -->
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
<script language=JavaScript for=EM_CARD_NO_CUT  event=OnKillFocus()>

	if ( trim(EM_CARD_NO_CUT.Text).length != 0 ) {
    	EM_CARD_NO_S.Text = cardCheckDigit(EM_CARD_NO_CUT.Text);
    } 
</script>


<!--script language=JavaScript for=EM_CARD_NO_S event=onLastChar(char)>
// onKillFocus()> 
    if(trim(EM_CARD_NO_S.Text).length==13){
    	btn_Search();

    }
</script--> 


<!-- 회원ID onKillFocus() -->
<script language=JavaScript for=EM_CUST_ID_S event=onKillFocus()>
    if ((EM_CUST_ID_S.Modified) && (EM_CUST_ID_S.Text.length != 9)) {
        EM_CUST_NAME_S.Text = ""; 
        EM_CUST_NAME_S.Text = ""; 
        EM_CARD_NO_H.Text   = "";
        EM_SS_NO_H.Text     = "";
    } 
</script>

<!-- 영수증번호 onKillFocus() -->
<script language=JavaScript for=EM_Q_RECP_NO event=onLastChar(char)>
//  onKillFocus()>
    if ((EM_Q_RECP_NO.Modified) && (EM_Q_RECP_NO.Text.length != 24) && (EM_Q_RECP_NO.Text.length != 0)) { 
    	EM_Q_RECP_NO.Text = "";  
    	showMessage(INFORMATION, OK, "USER-1000", "영수증 번호를 확인해주세요.");
    	EM_Q_RECP_NO.Focus();
    	return false; 
    } else {
		//적립할 영수증 내역 조회
    	getRecpInfo();
    	
    }
    EM_Q_RECP_NO.focus();
</script>


<!-- 회원ID onKeyDown() -->
<script language=JavaScript for=EM_CUST_ID_S event=onKeyDown(kcode,scode)>
    if (!(kcode == 13 || kcode == 9)) EM_CUST_NAME_S.Text = "";
</script>

<!-- 그리드  onKeyPress() -->
<script language=JavaScript for=GR_MASTER event=onKeyPress(kcode)>
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
    	EM_Q_RECP_NO.text = String.fromCharCode(kcode);
    	EM_Q_RECP_NO.focus();
      }
</script>

<script language=JavaScript for=GR_DETAIL event=onKeyPress(kcode)>
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
    	EM_Q_RECP_NO.text = String.fromCharCode(kcode);
    	EM_Q_RECP_NO.focus();
    }
    
</script>

<!-- 가맹점번호 OnKeyUp() -->
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
<!-- Grid oneClick event 처리 -->
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
<object id="DS_O_S_STR" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script> 

<comment id="_NSID_">
<object id="DS_IO_RECPINFO" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
  <object id="TR_CUST" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
  </object>
</comment>
<script>_ws_(_NSID_);</script>
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
					class="s_table" >
					<tr style="display:none">
						<th width="57" style="display:none">회원구분</th>
						<td width="170" style="display:none"><comment id="_NSID_"> <object
							id=RD_COMP_PERS_FLAG classid=<%=Util.CLSID_RADIO%>
							style="height: 20; width: 140" tabindex=1>
							<param name=Cols value="2">
							<param name=Format value="P^개인카드,C^법인카드">
							<param name=CodeValue value="P">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="76" class="point" >가맹점코드</th>
						<td width="170"><comment id="_NSID_"> <object
							id=EM_Q_BRCH_ID classid=<%=Util.CLSID_EMEDIT%> width="71"
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
						<img id="IMG_BRCH" src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							align="absmiddle"  onclick="getBrchPop(EM_Q_BRCH_ID,EM_Q_BRCH_NAME)" /> 
							 <comment
							id="_NSID_"> <object id=EM_Q_BRCH_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td> 
						<th width="57">카드번호</th>
						<td width="170"><comment id="_NSID_"> <object style="display : none"
							id=EM_CARD_NO_CUT classid=<%=Util.CLSID_EMEDIT%> width="55"
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
						    <comment id="_NSID_"> <object
							id=EM_CARD_NO_S classid=<%=Util.CLSID_EMEDIT%> width="155"
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr style="display:none"> 
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
			    <td class="btn_l"> </td>
			    <td class="btn_c"><a href="#" onclick="gourl('dmbo642.do','사후적립(일괄)','DMBO')">개인카드조회</a></td>
			    <td class="btn_r"></td>
			    <td class="btn_l"> </td>
			    <td class="btn_c"><a href="#" onclick="gourl('dctm301.dm','포인트조회','DCTM')">포인트조회</a></td>
			    <td class="btn_r"></td>
			    <td class="btn_l" style="display : none"> </td>
			    <td class="btn_c" style="display : none"><a href="#" onclick="gourl('dmbo715.do','포인트조회(회원미등록)','DMBO')">포인트조회(회원미등록)</a></td>
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
						<thstyle="display:none"><!--회원등급--></th>
						<td style="display:none"><comment id="_NSID_"> <object id=EM_CUST_GRADE
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
						<thstyle="display:none"><!--회원유형--></th>
						<td colspan="5" style="display:none"><comment id="_NSID_"> <object id=EM_CUST_TYPE
							classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>	
						<th style="display:none">발생포인트</th>
						<td style="display:none"><comment id="_NSID_"> <object id=EM_OCCURS_POINT
							classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th style="display:none">가용+발생</th>
						<td style="display:none"><comment id="_NSID_"> <object id=EM_SUM_POINT
							classid=<%=Util.CLSID_EMEDIT%> width=166 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
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
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
						<tr>
							<th width="80" class="point">영수증번호</th>
							<td><comment id="_NSID_"> <object id=EM_Q_RECP_NO
								classid=<%=Util.CLSID_EMEDIT%> width=190 tabindex="1" ></object>
								<param name=SelectAll   value="true">
								 </comment> <script> _ws_(_NSID_);</script>
							<img
								src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
								onclick="javascript:btn_delRow();" /></td> 
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
                <table width="625" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td width="525" rowspan="3"><comment id="_NSID_"> <object
                            id=GR_MASTER width="525" classid=<%=Util.CLSID_GRID%>
                            tabindex="1">
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
                            width="100%" classid=<%=Util.CLSID_GRID%> tabindex="1">
                            <param name="DataID" value="DS_IO_DETAIL">
                        </object> </comment> <script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                <br><b> ※ 위 내용은 적립 취소시 내역을 조회하므로 금액이 (-)로 표기 됩니다. </b>
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
<object id=BD_CUSTDETAIL classid=<%=Util.CLSID_BIND%> tabindex="0">
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

