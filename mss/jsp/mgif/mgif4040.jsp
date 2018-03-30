<!-- 
/*******************************************************************************
 * 시스템명	: 경영지원 > 상품권	관리 > 상품권재고관리  > 상품권	이력조회
 * 작 성 일	: 2011.03.11
 * 작 성 자	: 신익수
 * 수 정 자	: 
 * 파 일 명	: mgif4040.jsp
 * 버	 전	: 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개	 요	: 상품권 이력을	조회 한다.
 * 이	 력	: 2011.03.11 (신익수) 신규개발
 ******************************************************************************/
-->
<%@	page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"	  %>
<%@	taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@	taglib uri="/WEB-INF/tld/gauce40.tld"		  prefix="gauce" %>	 
<%@	taglib uri="/WEB-INF/tld/app.tld"			  prefix="loginChk"	%>
<%@	taglib uri="/WEB-INF/tld/button.tld"		  prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인	유무, 기본설정																									  *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">	 
<link href="/<%=dir%>/css/mds.css" rel="stylesheet"	type="text/css">
<script	language="javascript"  src="/<%=dir%>/js/common.js"		type="text/javascript"></script>
<script	language="javascript"  src="/<%=dir%>/js/gauce.js"		type="text/javascript"></script>
<script	language="javascript"  src="/<%=dir%>/js/global.js"		type="text/javascript"></script>
<script	language="javascript"  src="/<%=dir%>/js/message.js"	type="text/javascript"></script>


<!--*************************************************************************-->
<!--* B. 스크립트 시작																												   *-->
<!--*************************************************************************-->

<script	LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
//디테일 조회 두번 막기	위해 
var	old_Row	= 0;
 
 /*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자	: 신익수
 * 작 성 일	: 2010-03-11
 * 개	 요	: 해당 페이지 LOAD 시  
 * return값	: void
 */

	function doInit(){
	
		// Input Data Set Header 초기화
		DS_O_MASTER.setDataHeader('<gauce:dataset name="H_O_MASTER"/>');
		DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_O_DETAIL"/>');
		DS_O_MASTER2.setDataHeader('<gauce:dataset name="H_O_MASTER2"/>');
		DS_O_MASTER3.setDataHeader('<gauce:dataset name="H_O_MASTER3"/>');
		DS_O_MASTER4.setDataHeader('<gauce:dataset name="H_O_MASTER4"/>');
		DS_O_MASTER5.setDataHeader('<gauce:dataset name="H_O_MASTER5"/>');
		
		DS_SEL_GIFT_TYPE_CD.setDataHeader('<gauce:dataset name="H_GIFT_TYPE_CD"/>');
		DS_SEL_GIFT_AMT_CD.setDataHeader('<gauce:dataset name="H_GIFT_AMT_CD"/>');
		
		//그리드 초기화
		gridCreate(); 
		gridCreate2(); 
		gridCreate3(); 
		gridCreate4();
		gridCreate5();
		
		// EMedit에	초기화	
		initEmEdit(EM_S_GIFTCARD_NO, "NUMBER3^18", NORMAL);											//시작 번호
		initEmEdit(EM_E_GIFTCARD_NO, "NUMBER3^18", NORMAL);											//종료번호
		                                                                                			
		initEmEdit(EM_S_ISSUE_IN_DT,"YYYYMMDD",	READ);												//발행입고일자
		initEmEdit(EM_S_STAT_FLAG_NM,"GEN",	READ);													//상품권상태명
		initEmEdit(EM_S_ISSUE_TYPE_NM,"GEN", READ);													//발행형태명
		initEmEdit(EM_S_GIFT_TYPE_NAME,"GEN", READ);												//상품권종류명
		initEmEdit(EM_S_GIFT_AMT_NAME,"GEN", READ);													//금종명
		initEmEdit(EM_S_GIFTCARD_PRC,"NUMBER^12^2",	READ);											//금액
		initEmEdit(EM_S_OUT_DT,"YYYYMMDD", READ);													//출고일자
		initEmEdit(EM_S_IN_STR_NM,"GEN", READ);														//출고점
		initEmEdit(EM_S_POUT_DT,"YYYYMMDD",	READ);													//불출일자
		initEmEdit(EM_S_POUT_PART_CD,"GEN",	READ);													//불출부서(추후 부서명으로	해야함 조직쪽 테이블 알아야	함)
		initEmEdit(EM_S_ACDT_REG_DT,"YYYYMMDD",	READ);												//사고일자
		initEmEdit(EM_S_ACDT_STR_NM,"GEN", READ);													//사고점
		initEmEdit(EM_S_ACDT_RSN_NM,"GEN", READ);													//사고사유
		initEmEdit(EM_S_CAN_DT,"YYYYMMDD", READ);													//해지일자
		initEmEdit(EM_S_CAN_STR_NM,"GEN", READ);													//해지등록점
		initEmEdit(EM_S_CAN_RSN_NM,"GEN", READ);													//해지사유
		                                                                                			
		initEmEdit(EM_OUT_DT,"YYYYMMDD", READ);														//폐기일자
		initEmEdit(EM_OUT_STR_NM,"GEN",	READ);														//폐기등록점
		
		//콤보 초기화
		initComboStyle(LC_SEL_GIFT_TYPE_CD,DS_SEL_GIFT_TYPE_CD,	"CODE^0^30,NAME^0^80", 1, PK);		// [조회용]	상품권 종류
		initComboStyle(LC_SEL_GIFT_AMT_CD,DS_SEL_GIFT_AMT_CD, "CODE^0^40,NAME^0^80", 1,	NORMAL);	// [조회용] 상품권 종류 에 따른 금종
		
		//상품권 종류 가져오기
		getGiftTypeCd();
		
		//화면 로드시 포커스 셋팅
		LC_SEL_GIFT_TYPE_CD.Focus();
		setObject();
		
		//종료시 데이터	변경 체크 (common.js )
		//registerUsingDataset("mcae101","DS_O_MASTER" );
	 }
	
	function gridCreate(){
		//상품권 번호 그리드
		var	hdrProperies = ''
			+ '<FC>ID={CURROW}			NAME="NO"			WIDTH=30	ALIGN=CENTER</FC>'
			+ '<FC>ID=GIFT_AMT_NAME		NAME="금종"			WIDTH=60	ALIGN=LEFT</FC>'
			+ '<FC>ID=GIFTCARD_NO		NAME="상품권번호"		WIDTH=140	ALIGN=CENTER</FC>'
			;
		initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
	}
	
	function gridCreate2(){
	  //판매정보
		var	hdrProperies = ''
			+ '<FC>ID={CURROW}			NAME="NO"			WIDTH=30	ALIGN=CENTER</FC>'
			+ '<FC>ID=SALE_STR			NAME="판매점"	 		WIDTH=70	ALIGN=LEFT</FC>'
			+ '<FC>ID=SALE_FLAG_NM		NAME="판매구분"		WIDTH=80	ALIGN=LEFT</FC>'
			+ '<FC>ID=SALE_DT			NAME="판매일자"		WIDTH=80	mask="XXXX/XX/XX"  ALIGN=CENTER</FC>'
			;
		initGridStyle(GD_MASTER2, "COMMON",	hdrProperies, false);
	}	
	
	function gridCreate3(){	
	//회수정보
		var	hdrProperies = ''
			+ '<FC>ID={CURROW}			NAME="NO"			WIDTH=30	ALIGN=CENTER</FC>'
			+ '<FC>ID=DRAWL_STR			NAME="회수점"			WIDTH=70	ALIGN=LEFT</FC>'
			+ '<FC>ID=DRAWL_FLAG_NM		NAME="회수구분"		WIDTH=80	ALIGN=LEFT</FC>'
			+ '<FC>ID=DRAWL_DT			NAME="회수일자"		WIDTH=77	mask="XXXX/XX/XX"  ALIGN=CENTER</FC>'
			+ '<FC>ID=POS_NO			NAME="회수POS"		WIDTH=80	ALIGN=LEFT</FC>'
			+ '<FC>ID=TRAN_NO			NAME="거래번호"		WIDTH=80	ALIGN=LEFT</FC>'
			;
		initGridStyle(GD_MASTER3, "COMMON",	hdrProperies, false);
	}
	
	function gridCreate4(){	
		//회수정보
		var	hdrProperies = ''
			+ '<FC>ID={CURROW}			NAME="NO"			WIDTH=30	ALIGN=CENTER</FC>'
			+ '<FC>ID=DRAWL_STR			NAME="재사용점"		WIDTH=120	ALIGN=LEFT</FC>'
			+ '<FC>ID=REG_DT			NAME="재사용일자"		WIDTH=100	mask="XXXX/XX/XX"  ALIGN=CENTER</FC>'
			;
		initGridStyle(GD_MASTER4, "COMMON",	hdrProperies, false);
	}
	
 	function gridCreate5(){
		//영수증정보
		var	hdrProperies = ''
			+ '<FC>ID={CURROW}			NAME="NO1"			WIDTH=30	ALIGN=CENTER	sumtext="합"</FC>'
			+ '<FC>ID=SEQ_NO			NAME="NO2"			WIDTH=30	ALIGN=CENTER	sumtext="계"</FC>'
			+ '<FC>ID=PUMBUN_CD			NAME="브랜드코드"		WIDTH=80	ALIGN=LEFT		</FC>'
			+ '<FC>ID=RECP_NAME			NAME="브랜드명"		WIDTH=100	ALIGN=CENTER	</FC>'
			+ '<FC>ID=SALE_AMT			NAME="판매금액"		WIDTH=80	ALIGN=CENTER	sumtext=@sum </FC>'
			;
		initGridStyle(GD_MASTER5, "COMMON",	hdrProperies, false);
		GD_MASTER5.ViewSummary = "1";
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
 * 작 성 자	: 신익수
 * 작 성 일	: 2010-03-11
 * 개	 요	: 조회시 호출
 * return값	: void
 */
function btn_Search() {
	if(LC_SEL_GIFT_TYPE_CD.BindColVal.length ==	0){	 //	상품권 종류
		showMessage(INFORMATION, OK, "USER-1001", "상품권 종류");
		LC_SEL_GIFT_TYPE_CD.focus();
		return;
	}
	
	if(LC_SEL_GIFT_AMT_CD.BindColVal.length	== 0){	// 금종
		showMessage(INFORMATION, OK, "USER-1001", "금종");
		LC_SEL_GIFT_TYPE_CD.focus();
		return;
	}
	
	if(EM_S_GIFTCARD_NO.Text ==	"")	{
		showMessage(INFORMATION, OK, "USER-1001", "상품권 시작번호");
		EM_S_GIFTCARD_NO.focus();
		return;
	}
	
	if(EM_E_GIFTCARD_NO.Text ==	"")	{
		showMessage(INFORMATION, OK, "USER-1001", "상품권 종료번호");
		EM_E_GIFTCARD_NO.focus();
		return;
	}

	
	//데이타 셋	클리어
	DS_O_MASTER.ClearData();
	DS_O_MASTER2.ClearData();
	DS_O_MASTER3.ClearData();
	DS_O_MASTER4.ClearData();
	DS_O_MASTER5.ClearData();
	DS_O_DETAIL.ClearData();
	
	 //	조회조건 셋팅
	var	strGiftTypeCd	= LC_SEL_GIFT_TYPE_CD.BindColVal;
	var	strGiftAmtCd	= LC_SEL_GIFT_AMT_CD.BindColVal;
	var	strGiftCardNo	= EM_S_GIFTCARD_NO.Text;	//시작 번호
	var	strGiftCardENo	= EM_E_GIFTCARD_NO.Text; //종료번호
	
	var	goTo	   = "getGiftAmtMst" ;	  
	var	action	   = "O";	  
	var	parameters = "&strGiftTypeCd=" + encodeURIComponent(strGiftTypeCd)
				   + "&strGiftAmtCd="  + encodeURIComponent(strGiftAmtCd)
				   + "&strGiftCardNo=" + encodeURIComponent(strGiftCardNo)
				   + "&strGiftCardENo="+ encodeURIComponent(strGiftCardENo)
				   ;
	
	TR_MAIN.Action="/mss/mgif404.mg?goTo="+goTo+parameters;	 
	TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)";	//조회는 O
	TR_MAIN.Post();
	
	old_Row	= 1;
	// 조회결과	Return
	setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_New()
 * 작 성 자	: shryu
 * 작 성 일	: 2006-06-20
 * 개	 요	: Grid 레코드 추가
 * return값	: void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자	: 신익수
 * 작 성 일	: 2010-03-11
 * 개	 요	: Grid 레코드 삭제
 * return값	: void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자	: 신익수
 * 작 성 일	: 2010-03-11
 * 개	 요	: DB에 저장	/ 수정 / 삭제 처리
 * return값	: void
 */
function btn_Save()	{
  
}

/**
 * btn_Excel()
 * 작 성 자	: 신익수
 * 작 성 일	: 2010-03-11
 * 개	 요	: 엑셀로 다운로드
 * return값	: void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자	: 신익수
 * 작 성 일	: 2010-03-11
 * 개	 요	: 페이지 프린트	인쇄
 * return값	: void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자	: 
 * 작 성 일	: 2010-03-11
 * 개	 요	: 확정 처리
 * return값	: void
 */

function btn_Conf()	{
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  *	getGiftTypeCd()
  *	작 성 자 : 신익수
  *	작 성 일 : 2010-03-11
  *	개	  요 : 상품권 종류 가져오기	
  *	return값 : void
  */
 function getGiftTypeCd	() {
	 TR_MAIN.Action	   = "/mss/mgif404.mg?goTo=getGiftTypeCd";
	 TR_MAIN.KeyValue= "SERVLET(O:DS_SEL_GIFT_TYPE_CD=DS_SEL_GIFT_TYPE_CD)";
	 TR_MAIN.Post();
	 
	 LC_SEL_GIFT_TYPE_CD.index = 0;
	 
	 //getGiftAmcCd();
 }
  
 /**
  *	getGiftAmcCd()
  *	작 성 자 : 신익수
  *	작 성 일 : 2010-03-11
  *	개	  요 : 상품권 종류에 따른  금종	조회
  *	return값 : void
  */
 function getGiftAmcCd () {
   // LC_SEL_GIFT_AMT_CD.Enable	= true;
	  
	var	strGiftTypeCd		 = LC_SEL_GIFT_TYPE_CD.BindColVal;
	
	var	goTo	   = "getGiftAmtCd"	;	 
	var	action	   = "O";	  
	var	parameters = "&strGiftTypeCd="+ encodeURIComponent(strGiftTypeCd);
	
	TR_MAIN.Action="/mss/mgif404.mg?goTo="+goTo+parameters;	 
	TR_MAIN.KeyValue="SERVLET("+action+":DS_SEL_GIFT_AMT_CD=DS_SEL_GIFT_AMT_CD)"; //조회는 O
	TR_MAIN.Post();
	
	LC_SEL_GIFT_AMT_CD.index = 0;
 }

 /**
  *	getGiftMst()
  *	작 성 자 : 신익수
  *	작 성 일 : 2010-03-11
  *	개	  요 : 상품권 번호에 대한 상세 조회
  *	return값 : void
  */
function getGiftMst(strGiftCardNo) {
	DS_O_DETAIL.ClearData();
	var	goTo	   = "getGiftMst" ;	   
	var	action	   = "O";	  
	var	parameters = "&strGiftCardNo="+ encodeURIComponent(strGiftCardNo);
	
	TR_MAIN1.Action="/mss/mgif404.mg?goTo="+goTo+parameters;  
	TR_MAIN1.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
	TR_MAIN1.Post();	 
	
	//각각의 EMEDIT	에 값을	셋팅
}

/**
 * getSaleMst()
 * 작 성 자	: 신익수
 * 작 성 일	: 2010-03-11
 * 개	 요	: 상품권 번호에	대한 판매정보 조회
 * return값	: void
 */
function getSaleMst(strGiftCardNo) {
	DS_O_MASTER2.ClearData();
	var	goTo	   = "getSaleMst" ;	   
	var	action	   = "O";	  
	var	parameters = "&strGiftCardNo="+ encodeURIComponent(strGiftCardNo);
	
	TR_MAIN2.Action="/mss/mgif404.mg?goTo="+goTo+parameters;  
	TR_MAIN2.KeyValue="SERVLET("+action+":DS_O_MASTER2=DS_O_MASTER2)"; //조회는	O
	TR_MAIN2.Post(); 
	
	// 조회결과	Return
	setPorcCount("SELECT", GD_MASTER2);
}

/**
 * getSaleMst()
 * 작 성 자	: 신익수
 * 작 성 일	: 2010-03-11
 * 개	 요	: 상품권 번호에	대한 회수정보 조회
 * return값	: void
 */
function getGiftDrawl(strGiftCardNo){
	DS_O_MASTER3.ClearData();
	var	goTo	   = "getGiftDrawl"	;	 
	var	action	   = "O";	  
	var	parameters = "&strGiftCardNo="+ encodeURIComponent(strGiftCardNo);
	
	TR_MAIN3.Action="/mss/mgif404.mg?goTo="+goTo+parameters;  
	TR_MAIN3.KeyValue="SERVLET("+action+":DS_O_MASTER3=DS_O_MASTER3)"; //조회는	O
	TR_MAIN3.Post(); 
	
 //	조회결과 Return
	setPorcCount("SELECT", GD_MASTER3);
}
 
/**
 * getSaleMst()
 * 작 성 자	: 신익수
 * 작 성 일	: 2010-03-11
 * 개	 요	: 상품권 번호에	대한 재사용	조회
 * return값	: void
 */
function getGiftReuse(strGiftCardNo){
	DS_O_MASTER4.ClearData();
	var	goTo	   = "getGiftReuse"	;	 
	var	action	   = "O";	  
	var	parameters = "&strGiftCardNo="+ encodeURIComponent(strGiftCardNo);
	
	TR_MAIN4.Action="/mss/mgif404.mg?goTo="+goTo+parameters;  
	TR_MAIN4.KeyValue="SERVLET("+action+":DS_O_MASTER4=DS_O_MASTER4)"; //조회는	O
	TR_MAIN4.Post(); 
	
 //	조회결과 Return
	setPorcCount("SELECT", GD_MASTER4);
}

function getReceipt(strGiftCardNo){
	DS_O_MASTER5.ClearData();
	var	goTo	   = "getReceipt";	 
	var	action	   = "O";	  
	var	parameters = "&strGiftCardNo="+ encodeURIComponent(strGiftCardNo);
	
	TR_MAIN5.Action="/mss/mgif404.mg?goTo="+goTo+parameters;  
	TR_MAIN5.KeyValue="SERVLET("+action+":DS_O_MASTER5=DS_O_MASTER5)"; //조회는	O
	TR_MAIN5.Post(); 
	
 //	조회결과 Return
	setPorcCount("SELECT", GD_MASTER5);
}
 /**
  *	setObject()
  *	작 성 자 : 
  *	작 성 일 : 2010-03-11
  *	개	  요 : 컴포넌트	Enable/Disable 설정
  *	return값 : void
  */
 function setObject() {
		
		//LC_SEL_GIFT_AMT_CD.Enable	= false;
		
 }
 
 /**
  *	callPopup()
  *	작 성 자 : 신익수
  *	작 성 일 : 2010-03-11
  *	개	  요 : 팝업	호출
  *	return값 :
  */
 function callPopup(popupNm) {
   
 }
 
 /**
  *	checkValidate()
  *	작 성 자 : 신익수
  *	작 성 일 : 2010-03-11
  *	개	  요 : 값체크
  *	return값 :
  */
 function checkValidate() {
   
 }

 
 function chkGiftCardNo(strFlag){
	 if(strFlag	== "S"){
		 var strGiftCardNo = eval("EM_S_GIFTCARD_NO");
	 }else{
		 var strGiftCardNo = eval("EM_E_GIFTCARD_NO");
		 if(EM_S_GIFTCARD_NO.Text >	EM_E_GIFTCARD_NO.Text){
			 showMessage(INFORMATION, OK, "USER-1000", "상품권시작번호가 종료번호보다 클수 없습니다.");
			 EM_S_GIFTCARD_NO.Text = "";
			 EM_E_GIFTCARD_NO.Text = "";
			 setTimeout("EM_S_GIFTCARD_NO.Focus();",50);
			 return;
		 }
	 }
	 
	var	goTo	   = "chkGiftCardNo" ;	  
	var	action	   = "O";	  
	var	parameters = "&strGiftCardNo="+ encodeURIComponent(strGiftCardNo.Text);
	
	TR_MAIN.Action="/mss/mgif404.mg?goTo="+goTo+parameters;	 
	TR_MAIN.KeyValue="SERVLET("+action+":DS_O_CHECK=DS_O_CHECK)"; //조회는 O
	TR_MAIN.Post();	
	
	if(DS_O_CHECK.CountRow == 0){
		showMessage(INFORMATION, OK, "USER-1000", "상품권번호가	유효하지 않습니다.");
		strGiftCardNo.Text = "";
		setTimeout(strGiftCardNo.id+".Focus();",50);
		return;
	}
 }
-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝														*-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스	이벤트 처리													*-->
<!--*	 1.	TR Success 메세지 처리											*-->
<!--*	 2.	TR Fail	메세지 처리												*-->
<!--*	 3.	DataSet	Success	메세지 처리										*-->
<!--*	 4.	DataSet	Fail 메세지	처리										*-->
<!--*	 5.	DataSet	이벤트 처리												*-->
<!--*************************************************************************-->
<!---------------------	1. TR Success 메세지 처리  ---------------------------->
<script	language=JavaScript	for=TR_MAIN	event=onSuccess>
	for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
	}
</script>

<script	language=JavaScript	for=TR_MAIN1 event=onSuccess>
	for(i=0;i<TR_MAIN1.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN1.SrvErrMsg('UserMsg',i));
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

<script	language=JavaScript	for=TR_MAIN4 event=onSuccess>
	for(i=0;i<TR_MAIN4.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN4.SrvErrMsg('UserMsg',i));
	}
</script>

<script	language=JavaScript	for=TR_MAIN5 event=onSuccess>
	for(i=0;i<TR_MAIN5.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN5.SrvErrMsg('UserMsg',i));
	}
</script>

<!---------------------	2. TR Fail 메세지 처리	------------------------------->
<script	language=JavaScript	for=TR_MAIN	event=onFail>
	trFailed(TR_MAIN.ErrorMsg);
</script>

<script	language=JavaScript	for=TR_MAIN1 event=onFail>
	trFailed(TR_MAIN1.ErrorMsg);
</script>

<script	language=JavaScript	for=TR_MAIN2 event=onFail>
	trFailed(TR_MAIN2.ErrorMsg);
</script>

<script	language=JavaScript	for=TR_MAIN3 event=onFail>
	trFailed(TR_MAIN3.ErrorMsg);
</script>

<script	language=JavaScript	for=TR_MAIN4 event=onFail>
	trFailed(TR_MAIN4.ErrorMsg);
</script>

<script	language=JavaScript	for=TR_MAIN5 event=onFail>
	trFailed(TR_MAIN5.ErrorMsg);
</script>
<!---------------------	3. DataSet Success 메세지 처리	----------------------->
<!---------------------	4. DataSet Fail	메세지 처리	 -------------------------->
<!---------------------	5. DataSet 이벤트 처리	------------------------------->
<script	language=JavaScript	for=DS_O_MASTER	event=OnRowPosChanged(row)>
	if(row > 0 && old_Row != row ){
		//상품권 번호
		var	strGiftCardNo =	DS_O_MASTER.NameValue(row, "GIFTCARD_NO");
		//상품 디테일 조회
		getGiftMst(strGiftCardNo);
		//판매정보 조회
		getSaleMst(strGiftCardNo);
		//회수정보 조회
		getGiftDrawl(strGiftCardNo);
		//영수증 조회
		getReceipt(strGiftCardNo);		
		//재사용조회
		getGiftReuse(strGiftCardNo);
	}
	old_Row	= row;
</script>

<!---------------------	6. 컴포넌트	이벤트 처리	 -------------------------------->
<!-- 상품권	종류 변경시	-->
<script	language=JavaScript	for=LC_SEL_GIFT_TYPE_CD	event=OnSelChange>
	if(LC_SEL_GIFT_TYPE_CD.BindColVal != ""){
		DS_O_MASTER.ClearData();
		DS_O_DETAIL.ClearData();
		DS_O_MASTER2.ClearData();
		DS_O_MASTER3.ClearData();
		DS_O_MASTER4.ClearData();
		DS_O_MASTER5.ClearData();
		//금종 조회
		getGiftAmcCd();
	}
	
</script>
 <script language=JavaScript for=EM_S_GIFTCARD_NO event=OnKillFocus()>
 if(this.Text == "") return;
 if(this.Text.length ==	13 || this.Text.length == 16 || this.Text.length ==	18){
	 chkGiftCardNo("S");
 }else{
	 showMessage(INFORMATION, OK, "USER-1000", "상품권번호를 정확하게 입력하세요");
	 this.Text = "";
	 setTimeout("EM_S_GIFTCARD_NO.Focus();",50);
	 return;
 }
</script>
  <script language=JavaScript for=EM_E_GIFTCARD_NO event=OnKillFocus()>
 if(this.Text == "") return;
 if(this.Text.length ==	13 || this.Text.length == 16 || this.Text.length ==	18){
	 chkGiftCardNo("E");
 }else{
	 showMessage(INFORMATION, OK, "USER-1000", "상품권번호를 정확하게 입력하세요");
	 this.Text = "";
	 setTimeout("EM_E_GIFTCARD_NO.Focus();",50);
	 return;
 }
</script>
<!--*************************************************************************-->
<!--* C. 가우스	이벤트 처리	끝																									   *-->
<!--*************************************************************************-->
<!-- 마스터 정렬 기능  1-->
<script	language=JavaScript	for=GD_MASTER event=OnClick(row,colid)>
	//그리드 정렬기능
	if(	row	< 1) {
		sortColId( eval(this.DataID), row ,	colid );
	}
</script>
<!-- 마스터 정렬 기능 2-->
<script	language=JavaScript	for=GD_MASTER2 event=OnClick(row,colid)>
	//그리드 정렬기능
	if(	row	< 1) {
		sortColId( eval(this.DataID), row ,	colid );
	}
</script>
<!-- 마스터  정렬 기능 3-->
<script	language=JavaScript	for=GD_MASTER3 event=OnClick(row,colid)>
	//그리드 정렬기능
	if(	row	< 1) {
		sortColId( eval(this.DataID), row ,	colid );
	}
</script>

<!-- 마스터 정렬 기능 4-->
<script	language=JavaScript	for=GD_MASTER4 event=OnClick(row,colid)>
	//그리드 정렬기능
	if(	row	< 1) {
		sortColId( eval(this.DataID), row ,	colid );
	}
</script>

<!-- 마스터 정렬 기능 5-->
<script	language=JavaScript	for=GD_MASTER5 event=OnClick(row,colid)>
	//그리드 정렬기능
	if(	row	< 1) {
		sortColId( eval(this.DataID), row ,	colid );
	}
</script>
<!--*************************************************************************-->
<!--* D. 가우스	DataSet	& Transaction 정의																		   *-->
<!--*	 1.	DataSet															*-->
<!--*	 2.	Transaction														*-->
<!--*************************************************************************-->

<!---------------------	1. DataSet	------------------------------------------->

<!-- ===============- Input용  -->
<comment id="_NSID_"><object id="DS_O_MASTER"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MASTER2"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MASTER3"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MASTER4"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MASTER5"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DETAIL"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CHECK"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->

<!-- ===============- ONLOAD용 -->
<comment id="_NSID_"><object id="DS_SEL_GIFT_TYPE_CD"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script> 
<comment id="_NSID_"><object id="DS_SEL_GIFT_AMT_CD"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->


<!---------------------	2. Transaction	--------------------------------------->
<comment id="_NSID_">
<object	id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName"	value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object	id="TR_MAIN1" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName"	value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object	id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName"	value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object	id="TR_MAIN3" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName"	value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object	id="TR_MAIN4" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName"	value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object	id="TR_MAIN5" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName"	value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스	DataSet	& Transaction 정의 끝																	  *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작																														  *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@	include	file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 //	-->

<DIV id="testdiv" class="testdiv">
<table width="100%"	border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td	class="PT01	PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
		<tr>
		  <td><table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
			  <tr>
				<th	width="70" class="point">상품권종류</th>
				<td	width="130">
					<comment id="_NSID_"> 
						<object	id=LC_SEL_GIFT_TYPE_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=130 align="absmiddle"> 
						</object> 
					</comment>
					<script>_ws_(_NSID_);</script>
				</td>
				<th	width="70">금종</th>
				<td	width="120">
					<comment id="_NSID_"> 
						<object	id=LC_SEL_GIFT_AMT_CD classid=<%=Util.CLSID_LUXECOMBO%>	height=100
							width=120 align="absmiddle"> 
						</object> 
					</comment>
					<script>_ws_(_NSID_);</script>
				</td>
				<th	width="70" class="point">상품권번호</th>
				<td	>
					
					<comment id="_NSID_">
					  <object id=EM_S_GIFTCARD_NO classid=<%=Util.CLSID_EMEDIT%>   width=130 tabindex=1	align="absmiddle">
					  </object></comment><script>_ws_(_NSID_);</script>
					  ~
					<comment id="_NSID_">
					  <object id=EM_E_GIFTCARD_NO classid=<%=Util.CLSID_EMEDIT%>   width=130 tabindex=1	align="absmiddle">
					  </object></comment><script>_ws_(_NSID_);</script>
				</td>
			  </tr>
			</table></td>
		</tr>
	  </table></td>
  </tr>
  <tr>
	<td	class="dot"></td>
  </tr>
  <tr valign="top">
	<td><table width="100%"	border="0" cellspacing="0" cellpadding="0">
		<tr	valign="top">
		  <td width="220"><table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
			  <tr>
				<td	width="100%"><comment id="_NSID_">
					<OBJECT
							id=GD_MASTER width=100%	height=505 classid=<%=Util.CLSID_GRID%>>
					  <param name="DataID" value="DS_O_MASTER">
					</OBJECT>
				  </comment>
				  <script>_ws_(_NSID_);</script>
				</td>
			  </tr>
			</table></td>
		  <td class="PL05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td><table width="100%"	border="0" cellspacing="0" cellpadding="0">
					<tr>
					  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
						  <tr>
							<td><table width="100%"	border="0" cellspacing="0" cellpadding="0"
									class="s_table">
								<tr>
								  <th width="75" rowspan="2">발행정보</th>
								  <th width="75">발행입고일자</th>
								  <td width="80">
									<object	id=EM_S_ISSUE_IN_DT	classid=<%=Util.CLSID_EMEDIT%> width=80	align="absmiddle"> </object> 
								  </td>
								  <th width="60">상품권상태</th>
								  <td width="80">
									<object	id=EM_S_STAT_FLAG_NM classid=<%=Util.CLSID_EMEDIT%>	width=80 align="absmiddle">	</object> 
								  </td>
								  <th width="60">발행형태</th>
								  <td >
									<object	id=EM_S_ISSUE_TYPE_NM classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"> </object> 
								  </td>
								</tr>
								<tr>
								  <th>상품권종류</th>
								  <td>
									<object	id=EM_S_GIFT_TYPE_NAME classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"> </object>
								  </td>
								  <th>금종</th>
								  <td>
									<object	id=EM_S_GIFT_AMT_NAME classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"> </object>
								  </td>
								  <th>상품권금액</th>
								  <td>
									<object	id=EM_S_GIFTCARD_PRC classid=<%=Util.CLSID_EMEDIT%>	width=80 align="absmiddle">	</object>
								  </td>
								</tr>
								<tr>
								  <th>출고정보</th>
								  <th>출고일자</th>
								  <td>
									<object	id=EM_S_OUT_DT classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"> </object>
								  </td>
								  <th>출고점</th>
								  <td>
									<object	id=EM_S_IN_STR_NM classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"> </object>
								  </td>
								  <th>&nbsp;</th>
								  <td></td>
								</tr>
								<tr>
								  <th>불출정보</th>
								  <th>불출일자</th>
								  <td>
									<object	id=EM_S_POUT_DT	classid=<%=Util.CLSID_EMEDIT%> width=80	align="absmiddle"> </object>
								  </td>
								  <th>불출부서</th>
								  <td>
									<object	id=EM_S_POUT_PART_CD classid=<%=Util.CLSID_EMEDIT%>	width=80 align="absmiddle">	</object>
								  </td>
								  <th>&nbsp;</th>
								  <td></td>
								</tr>
								<tr>
								  <th>사고정보</th>
								  <th>사고일자</th>
								  <td>
									<object	id=EM_S_ACDT_REG_DT	classid=<%=Util.CLSID_EMEDIT%> width=80	align="absmiddle"> </object>
								  </td>
								  <th>사고점</th>
								  <td>
									<object	id=EM_S_ACDT_STR_NM	classid=<%=Util.CLSID_EMEDIT%> width=80	align="absmiddle"> </object>
								  </td>
								  <th>사고사유</th>
								  <td>
									<object	id=EM_S_ACDT_RSN_NM	classid=<%=Util.CLSID_EMEDIT%> width=80	align="absmiddle"> </object>
								  </td>
								</tr>
								<tr>
								  <th>사고해지정보</th>
								  <th>해지일자</th>
								  <td>
									<object	id=EM_S_CAN_DT classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"> </object>
								  </td>
								  <th>해지등록점</th>
								  <td>
									<object	id=EM_S_CAN_STR_NM classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"> </object>
								  </td>
								  <th>해지사유</th>
								  <td>
									<object	id=EM_S_CAN_RSN_NM classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"> </object>
								  </td>
								</tr>
								
								<tr>
								  <th>폐기정보</th>
								  <th>폐기일자</th>
								  <td>
									<object	id=EM_OUT_DT classid=<%=Util.CLSID_EMEDIT%>	width=80 align="absmiddle">	</object>
								  </td>
								  <th>폐기점</th>
								  <td>
									<object	id=EM_OUT_STR_NM classid=<%=Util.CLSID_EMEDIT%>	width=80 align="absmiddle">	</object>
								  </td>
								  <th></th>
								  <td>
									
								  </td>
								</tr>
							   
							  </table>
							</td>
						  </tr>
						</table></td>
					</tr>
				  </table></td>
			  </tr>
			  
			  <tr>
				<td	class="PT05">
				<table	width="100%" border="0"	cellspacing="0"	cellpadding="0">
					<tr>
						<td width="315" class="sub_title PB03"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>판매정보</td>
						<td class="PL05 sub_title	PB03"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle"	class="PR03"/>회수정보</td>
					</tr>
					
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
								<tr>
									<td	width="100%">
										<comment id="_NSID_">
											<object	id="GD_MASTER2"	width="100%" height="140" classid="<%=Util.CLSID_GRID%>">
												<param name="DataID" value="DS_O_MASTER2"	/>
											</object>
										</comment>
									<script>_ws_(_NSID_);</script></td>
								</tr>
							</table>
							
							<table width="100%"	border="0" cellspacing="0" cellpadding="0" >
								<tr>
									<td height="5"></td>
								</tr>
								<tr >
									<td	 class="PL05 sub_title PB03"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>영수증정보</td>
								</tr>
								<tr>
									<td height="5"></td>
								</tr>
							</table>
							
							<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
								<tr>
									<td	width="100%" >
										<comment id="_NSID_">
											<object	id="GD_MASTER5"	width="100%" height="140" classid="<%=Util.CLSID_GRID%>">
												<param name="DataID" value="DS_O_MASTER5"	/>
											</object>
										</comment>
										<script>_ws_(_NSID_);</script>
									</td>
								</tr>
							</table>
						</td>

						<td	class="PL05">
							<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
								<tr>
									<td	width="100%" >
										<comment id="_NSID_">
											<object	id="GD_MASTER3"	width="100%" height="140" classid="<%=Util.CLSID_GRID%>">
												<param name="DataID" value="DS_O_MASTER3" />
											</object>
										</comment>
										<script>_ws_(_NSID_);</script>
									</td>
								</tr>
							</table>
					
							<table width="100%"	border="0" cellspacing="0" cellpadding="0" >
								<tr>
									<td height="5"></td>
								</tr>
								<tr >
									<td	 class="PL05 sub_title PB03"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>재사용내역</td>
								</tr>
								<tr>
									<td height="5"></td>
								</tr>
							</table>
							
							<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
							  <tr>
								<td	width="100%" >
								<comment id="_NSID_">
									<object	id="GD_MASTER4"	width="100%" height="140" classid="<%=Util.CLSID_GRID%>">
									  <param name="DataID" value="DS_O_MASTER4"	/>
									</object>
								  </comment>
								  <script>_ws_(_NSID_);</script>
								</td>
							  </tr>
							</table>
							
						</td>
					</tr>
					
				  </table></td>
			  </tr>
			</table></td>
		</tr>
	  </table></td>
  </tr>
</table>
</td>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce	Bind Component Declaration
------------------------------------------------------------------------------>
 <comment id="_NSID_">
<object	id=BD_O_DETAIL classid=<%=Util.CLSID_BIND%>>
		<param name=DataID			value=DS_O_DETAIL>
		<param name="ActiveBind"	value=true>
		<param name=BindInfo		value='
		<c>col=ISSUE_IN_DT			Ctrl=EM_S_ISSUE_IN_DT		param=Text</c>
		<c>col=STAT_FLAG_NM			Ctrl=EM_S_STAT_FLAG_NM		param=Text</c>
		<c>col=ISSUE_TYPE_NM		Ctrl=EM_S_ISSUE_TYPE_NM		param=Text</c>
		<c>col=GIFT_TYPE_NAME		Ctrl=EM_S_GIFT_TYPE_NAME	param=Text</c>
		<c>col=GIFT_AMT_NAME		Ctrl=EM_S_GIFT_AMT_NAME		param=Text</c>
		<c>col=GIFTCERT_AMT			Ctrl=EM_S_GIFTCARD_PRC		param=Text</c>
		<c>col=OUT_DT				Ctrl=EM_S_OUT_DT			param=Text</c>
		<c>col=IN_STR_NM			Ctrl=EM_S_IN_STR_NM			param=Text</c>
		<c>col=POUT_DT				Ctrl=EM_S_POUT_DT			param=Text</c>
		<c>col=POUT_PART_CD			Ctrl=EM_S_POUT_PART_CD		param=Text</c>
		<c>col=ACDT_REG_DT			Ctrl=EM_S_ACDT_REG_DT		param=Text</c>
		<c>col=ACDT_STR_NM			Ctrl=EM_S_ACDT_STR_NM		param=Text</c>
		<c>col=ACDT_RSN_NM			Ctrl=EM_S_ACDT_RSN_NM		param=Text</c>
		<c>col=CAN_DT				Ctrl=EM_S_CAN_DT			param=Text</c>
		<c>col=CAN_STR_NM			Ctrl=EM_S_CAN_STR_NM		param=Text</c>
		<c>col=CAN_RSN_NM			Ctrl=EM_S_CAN_RSN_NM		param=Text</c>
		<c>col=DUSE_DT				Ctrl=EM_OUT_DT				param=Text</c>
		<c>col=DRAWL_STR_NM			Ctrl=EM_OUT_STR_NM			param=Text</c>
		'>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>
 
