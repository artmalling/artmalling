<!-- 
/*******************************************************************************
 * 시스템명	: 영업관리 > 협력사EDI	> 단골고객관리 > 단골고객매출조회
 * 작 성 일 : 2012.06.25
 * 작 성 자 : 홍종영
 * 수 정 자 : 
 * 파 일 명 : medi1080.jsp
 * 버	전 :	1.0	(버전은 1.0부터 시작하며	0.1씩 증가)
 * 개	요 :	
 * 이	력 :
 * 
 ******************************************************************************/
-->

<%@	page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@	taglib uri="/WEB-INF/tld/c-rt.tld"		prefix="c"%>
<%@	taglib uri="/WEB-INF/tld/gauce40.tld"	prefix="gauce"%>
<%@	taglib uri="/WEB-INF/tld/app.tld"		prefix="loginChk"%>
<%@	taglib uri="/WEB-INF/tld/button.tld"	prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정												*-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet"	type="text/css">
<script	language="javascript"	src="/<%=dir%>/js/common.js"		type="text/javascript"></script>
<script	language="javascript"	src="/<%=dir%>/js/gauce.js"			type="text/javascript"></script>
<script	language="javascript"	src="/<%=dir%>/js/global.js"		type="text/javascript"></script>
<script	language="javascript"	src="/<%=dir%>/js/message.js"		type="text/javascript"></script>
<script	language="javascript"	src="/<%=dir%>/js/popup.js"			type="text/javascript"></script>
<script	language="javascript"	src="/<%=dir%>/js/popup_dps.js"		type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작															*-->
<!--*************************************************************************-->

<script	LANGUAGE="JavaScript">
<!--
var	strToday = getTodayFormat("yyyymmdd");
var	strSDate = addDate('M',	-1,	strToday);

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 홍종영
 * 작 성 일 : 2012-06-25
 * 개	요 :	해당 페이지 LOAD	시  
 * return값 : void
 */

 function doInit(){

	 strToday =	getTodayDB("DS_O_RESULT");
	 
	 //	Input Data Set Header 초기화
	 DS_IO_MASTER.setDataHeader('<gauce:dataset	name="H_MASTER"/>');
	 DS_IO_DETAIL.setDataHeader('<gauce:dataset	name="H_DETAIL"/>');
	 //	Output Data	Set	Header 초기화
	  
	 
	 //그리드 초기화
	 gridCreate1();	//마스터
	 gridCreate2(); //디테일
	 
	 //	EMedit에	초기화
	 initEmEdit(EM_S_VEN_CD,		 "000000",		NORMAL);		//	협력사코드
	 initEmEdit(EM_S_VEN_NM,		 "GEN^40",		READ);			//	협력사명
	 initEmEdit(EM_S_PUMBUN_CD,		 "000000",		NORMAL);		//	품번코드
	 initEmEdit(EM_S_PUMBUN_NM,		 "GEN^40",		READ);			//	품번명
	 initEmEdit(EM_CUST_NAME,		 "GEN^40",		NORMAL);		//	고객명
	 initEmEdit(homeaddr1,		 "GEN^40",		NORMAL);		//	고객명
	 initEmEdit(sale_s,		 "GEN^40",		NORMAL);		//	고객명
	 initEmEdit(sale_e,		 "GEN^40",		NORMAL);		//	고객명
	 initEmEdit(EM_CARD_NO,			 "GEN^40",		NORMAL);		//	카드번호
	 initEmEdit(EM_S_SALE_S_DT,		 "SYYYYMMDD",	NORMAL);		//	매출기간 시작일
	 initEmEdit(EM_S_SALE_E_DT,		 "TODAY",		NORMAL);		//	매출기간 종료일

	 //콤보 초기화(조회조건)
	 initComboStyle(LC_S_STR_CD,	DS_O_STR_CD,	"CODE^0^30,NAME^0^80", 1, PK);	// 점(조회)
	 
	initComboStyle(birth_s,	ds_birth_s, 	"CODE^0^30,NAME^0^80",	1,	NORMAL);		//등급 구분
	initComboStyle(birth_e,	ds_birth_e, 	"CODE^0^30,NAME^0^80",	1,	NORMAL);		//등급 구분
	initComboStyle(age,		ds_age, 	"CODE^0^30,NAME^0^80",	1,	NORMAL);		//등급 구분
	
	 getStore("DS_O_STR_CD", "Y", "", "N");	  

		getEtcCode("ds_birth_s",	"D", "M100", "N");							//생월 시작 불러오기
		setComboData(birth_s,"00");										//생월시작 값
		
		getEtcCode("ds_birth_e",	"D", "M100", "N");							//생월 끝 불러오기
		setComboData(birth_e,"00");										//생월끝 값
		
		getEtcCode("ds_age",	"D", "P627", "N");							//연령 불러오기
		setComboData(age,"00");										//연령 값
	
	 LC_S_STR_CD.index	= 0;
	 LC_S_STR_CD.Focus(); 
 }

 function gridCreate1(){
	 var hdrProperies =	'<FC>id={currow}		name="NO"			width=30	align=center</FC>'
					  +	'<FC>id=PUMBUN_CD		name="브랜드코드"	width=70	align=center</FC>'
					  +	'<FC>id=PUMBUN_NAME		name="브랜드명"		width=120	align=center</FC>'
					  +	'<FC>id=CUST_NAME		name="고객명"		width=70	align=center</FC>'
					  +	'<FC>id=BIRTH_DT		name="생년월일"		width=120	align=center mask=XXXX-XX-XX</FC>'
					  +	'<FC>id=MOBILE_PH1		name="PHONE1"		width=50	align=center</FC>'
					  +	'<FC>id=MOBILE_PH2		name="PHONE2"		width=50	align=center</FC>'
					  +	'<FC>id=MOBILE_PH3		name="PHONE3"		width=50	align=center</FC>'
					  +	'<FC>id=CARD_NO			name="카드번호"		width=150	align=center</FC>'
					  +	'<FC>id=SALE_AMT		name="매출액"		width=90	align=right</FC>'
					  +	'<FC>id=CUST_ID			name="고객ID"		width=90	align=right show=false</FC>'
					  +	'<FC>id=S_SALE_DT		name="시작"			width=90	align=right show=false</FC>'
					  +	'<FC>id=E_SALE_DT		name="종료"			width=90	align=right show=false</FC>';					  
	 initGridStyle(GR_MASTER, "common",	hdrProperies, false);	  
 }
 
 function gridCreate2(){
	 var hdrProperies =	'<FC>id={currow}		name="NO"			width=30	align=center</FC>'
					  +	'<FC>id=SALE_DT			name="매출일자"		width=120	align=center mask=XXXX-XX-XX</FC>'
					  +	'<FC>id=PUMMOK_CD		name="품목코드"		width=120	align=center</FC>'
					  +	'<FC>id=PUMMOK_NAME		name="품목명"		width=70	align=center</FC>'
					  +	'<FC>id=SALE_QTY		name="수량"			width=120	align=center</FC>'
					  +	'<FC>id=SALE_TOT_AMT	name="매출액"		width=90	align=center</FC>';

	 initGridStyle(GR_DETAIL, "common",	hdrProperies, false);	  
 }

/*************************************************************************
  *	2. 공통버튼
	 (1) 조회		  -	btn_Search(), subQuery()
	 (2) 신규		  -	btn_New()
	 (3) 삭제		  -	btn_Delete()
	 (4) 저장		  -	btn_Save()
	 (5) 엑셀		  -	btn_Excel()
	 (6) 출력		  -	btn_Print()
	 (7) 확정		  -	btn_Conf()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자 : 홍종영
 * 작 성 일 : 2012-06-25
 * 개	요 :	조회시	호출
 * return값 : void
 */
function btn_Search() {
	DS_IO_MASTER.ClearData();
	DS_IO_DETAIL.ClearData();

	LC_S_STR_CD.Focus();
	getMaster();
	setPorcCount("SELECT",	GR_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : 홍종영
 * 작 성 일 : 2012-06-25
 * 개	요 :	Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	
}

/**
 * btn_Delete()
 * 작 성 자 : 홍종영
 * 작 성 일 : 2012-06-25
 * 개	요 :	Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//	  DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자	 : 홍종영
 * 작 성 일	 : 2012-06-25
 * 개	요		 : DB에 저장 /	수정처리
 * return값 : void
 */
function btn_Save()	{
	 
}


/**
 * btn_Excel()
 * 작 성 자 : 홍종영
 * 작 성 일 : 2012-06-25
 * 개	요 :	엑셀로	다운로드
 * return값 : void
 */
function btn_Excel() {
	var ExcelTitle = "단골 고객 매출 조회";		
			
	var excel_strcd = LC_S_STR_CD.Text;
	var excel_sDate = EM_S_SALE_S_DT.Text;
	var excel_eDate = EM_S_SALE_E_DT.Text;
	   
	var parameters = "점=" + excel_strcd + " - 기간=" + excel_sDate + "~" + excel_eDate;
	
	openExcel2(GR_MASTER, ExcelTitle, parameters, true );
	GR_MASTER.Focus();
}

/**
 * btn_Print()
 * 작 성 자 : 홍종영
 * 작 성 일 : 2012-06-25
 * 개	요 :	페이지	프린트	인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : 홍종영
 * 작 성 일 : 2012-06-25
 * 개	요 :	확정 처리
 * return값 : void
 */

function btn_Conf()	{

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
 * getList()
 * 작 성 자 : 홍종영
 * 작 성 일 : 2012-06-25
 * 개	요 :	 마스터  조회
 * return값 : void
 */
function getMaster(){
	if(EM_S_VEN_CD.Text == "" && EM_S_VEN_NM.Text == ""){
		showMessage(EXCLAMATION , OK, "USER-1000", "협력사코드를 입력하여 주세요");
		EM_S_VEN_CD.focus();
	}
	
	if(EM_S_SALE_S_DT.Text == ""){
		showMessage(EXCLAMATION , OK, "USER-1000", "매출기간을 입력하여 주세요");
		EM_S_SALE_S_DT.focus();
	}
	if(EM_S_SALE_E_DT.Text == ""){
		showMessage(EXCLAMATION , OK, "USER-1000", "오늘일자를 입력하여 주세요");
		EM_S_SALE_E_DT.focus();
	}	
	
	if(EM_S_SALE_S_DT.Text > EM_S_SALE_E_DT.Text){
		showMessage(EXCLAMATION , OK, "USER-1000", "매출기간은 오늘일자 보다 작아야 합니다");
		EM_S_SALE_S_DT.focus();
	}
	
	
	
	
	// 조회조건	셋팅
	var	strStrCd   = LC_S_STR_CD.BindColVal;	// 점
	var	strVenCd   = EM_S_VEN_CD.Text;			// 협력사
	var	strPumbunCd= EM_S_PUMBUN_CD.Text;		// 품번
	var	strCustName= EM_CUST_NAME.Text			// 고객명
	
	var	strCardNo  = EM_CARD_NO.Text			// 카드번호
	var	strSaleSdt = EM_S_SALE_S_DT.Text;		// 매출기간시작
	var	strSaleEdt = EM_S_SALE_E_DT.Text;		// 매출기간종료
	
	var	strhomeaddr1= homeaddr1.Text;			// 지역
	var	strbirth_s 	= birth_s.BindColVal;		// 생월시작
	var	strbirth_e 	= birth_e.BindColVal;		// 생월끝
	var	strsale_s 	= sale_s.Text;				// 매출시작
	var	strsale_e 	= sale_e.Text;				// 매출끝
	var	strage		= age.BindColVal;			// 연령
	
	var	goTo	   = "getMaster";	 
	var	action	   = "O";	  
	var	parameters = "&strStrCd="    +encodeURIComponent(strStrCd)
				   + "&strVenCd="    +encodeURIComponent(strVenCd)
				   + "&strPumbunCd=" +encodeURIComponent(strPumbunCd)
				   + "&strCustName=" +encodeURIComponent(strCustName)
				   + "&strCardNo="   +encodeURIComponent(strCardNo)
				   + "&strSaleSdt="  +encodeURIComponent(strSaleSdt)
				   + "&strSaleEdt="  +encodeURIComponent(strSaleEdt)
				   + "&strHomeAddr1="+encodeURIComponent(strhomeaddr1)
				   + "&strBirth_S="  +encodeURIComponent(strbirth_s)
				   + "&strBirth_E="  +encodeURIComponent(strbirth_e)
				   + "&strSale_S="   +encodeURIComponent(strsale_s)
				   + "&strSale_E="   +encodeURIComponent(strsale_e)
				   + "&strAge="      +encodeURIComponent(strage);

	TR_MAIN.Action	= "/mss/medi108.md?goTo="+goTo+parameters;	
	TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
	TR_MAIN.Post();
 }
 
 
function getDetail(){
	var	strSaleSdt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"S_SALE_DT");		// 매출기간시작
	var	strSaleEdt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"E_SALE_DT");		// 매출기간종료
	var	strStrCd   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CD");			// 점
	var	strPumbunCd= DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PUMBUN_CD");		// 품번
	var	strCustNo  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CUST_ID");		// 고객아이디
	 
	var	goTo	   = "getDetail";	 
	var	action	   = "O";	  
	var	parameters = "&strStrCd="   + encodeURIComponent(strStrCd)
				   + "&strPumbunCd="+ encodeURIComponent(strPumbunCd)
				   + "&strCustNo="  + encodeURIComponent(strCustNo)
				   + "&strSaleSdt=" + encodeURIComponent(strSaleSdt)
				   + "&strSaleEdt=" + encodeURIComponent(strSaleEdt);

	TR_DETAIL.Action	= "/mss/medi108.md?goTo="+goTo+parameters;	
	TR_DETAIL.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
	TR_DETAIL.Post();
} 
 
 /**
  *	getVenInfo(code, name, btnFlag)
  *	작 성	자 :	홍종영
  *	작 성	일 :	2012-06-25
  *	개	 요 :  품번에 따른 협력사 팝업
  *	return값	: void
  */
 function getVenInfo(code, name, btnFlag){
	 var strStrCd		 = LC_S_STR_CD.BindColVal;	
	 var strUseYn		 = "Y";								// 사용여부
	 var strPumBunType	 = "";								// 품번유형
	 var strMcMiGbn		 = "";								// 매출처/매입처구분
	
	 if(!btnFlag){
		 var rtnMap	= setVenNmWithoutPop( "DS_O_RESULT",code
													   ,name
													   ,"1"
													   ,strStrCd
													   ,strUseYn
													   ,strPumBunType
													   ,strMcMiGbn);
	 }else{
		 var rtnMap	= venPop(code
							,name
							,strStrCd
							,strUseYn
							,strPumBunType
							,strMcMiGbn);
	 }
 }

 /**
  *	searchPumbunPop()
  *	작 성	자 :	홍종영
  *	작 성	일 :	2010-03-18
  *	개	 요 :  조회조건 품번팝업
  *	return값	: void
  */
  function searchPumbunPop(){
	  var tmpOrgCd		  =	LC_S_STR_CD.BindColVal;
	  var strUsrCd		  =	'<c:out	value="${sessionScope.sessionInfo.USER_ID}"	/>';	// 세션 사원번호
	  var strStrCd		  =	LC_S_STR_CD.BindColVal;										// 점
	  var strOrgCd		  =	tmpOrgCd + "00000000";										// 조직코드
	  var strVenCd		  =	EM_S_VEN_CD.Text;											// 협력사
	  var strBuyerCd	  =	"";															// 바이어
	  var strPumbunType	  =	"";															// 품번유형
	  var strUseYn		  =	"Y";														// 사용여부
	  var strSkuFlag	  =	"";															// 단품구분
	  var strSkuType	  =	"";															// 단품종류(1:규격단품)
	  var strItgOrdFlag	  =	"";															// 통합발주여부
	  var strBizType	  =	"";															// 거래형태(2:특정)	
	  var strSaleBuyFlag  =	"";															// 판매분매입구분


	  var rtnMap = strPbnPop( EM_S_PUMBUN_CD, EM_S_PUMBUN_NM, 'Y'
							 , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
							 , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
							 , strBizType,strSaleBuyFlag);
	  if(rtnMap	!= null){
		  return true;
	  }else{
		  return false;
	  }
  }

  /**
   * searchPumbunNonPop()
   * 작 성 자 : 홍종영
   * 작 성 일 : 2010-03-18
   * 개	  요	:  조회조건	품번팝업
   * return값 : void
   */
   function	searchPumbunNonPop(){
	   var tmpOrgCd		   = LC_S_STR_CD.BindColVal;
	   var strUsrCd		   = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';	// 세션 사원번호
	   var strStrCd		   = LC_S_STR_CD.BindColVal;									// 점
	   var strOrgCd		   = tmpOrgCd +	"00000000";										// 조직코드
	   var strVenCd		   = EM_S_VEN_CD.Text;											// 협력사
	   var strBuyerCd	   = "";														// 바이어
	   var strPumbunType   = "";														// 품번유형
	   var strUseYn		   = "Y";														// 사용여부
	   var strSkuFlag	   = "";														// 단품구분
	   var strSkuType	   = "";														// 단품종류(1:규격단품)
	   var strItgOrdFlag   = "";														// 통합발주여부
	   var strBizType	   = "";														// 거래형태(2:특정) 
	   var strSaleBuyFlag  = "";														// 판매분매입구분


	   var rtnMap =	setStrPbnNmWithoutPop( "DS_O_RESULT", EM_S_PUMBUN_CD, EM_S_PUMBUN_NM, "Y", "1"
							  ,	strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
							  ,	strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
							  ,	strBizType,	strSaleBuyFlag);		   

	   if(rtnMap !=	null){
		   return true;
	   }else{
		   return false;
	   }
   }
-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝														*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리													*-->
<!--*	 1.	TR Success 메세지 처리
<!--*	 2.	TR Fail	메세지	처리
<!--*	 3.	DataSet	Success	메세지	처리
<!--*	 4.	DataSet	Fail 메세지 처리
<!--*	 5.	DataSet	이벤트	처리
<!--*************************************************************************-->
<!---------------------	1. TR Success 메세지 처리  ---------------------------->
<script	language=JavaScript	for=TR_MAIN	event=onSuccess>
	for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
	}
</script>
<script	language=JavaScript	for=TR_DETAIL event=onSuccess>
	for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++)	{
		showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
	}
</script>
<!---------------------	2. TR Fail 메세지 처리  ------------------------------->
<script	language=JavaScript	for=TR_MAIN	event=onFail>
	trFailed(TR_MAIN.ErrorMsg);
</script>
<script	language=JavaScript	for=TR_DETAIL event=onFail>
	trFailed(TR_DETAIL.ErrorMsg);
</script>

<!---------------------	3. DataSet Success 메세지 처리  ----------------------->
<!---------------------	4. DataSet Fail	메세지	처리	-------------------------->
<!---------------------	5. DataSet 이벤트 처리  ------------------------------->


<script	language=JavaScript	for=DS_IO_MASTER event=onRowPosChanged(row)>
if(clickSORT)
	return;

getDetail();

</script>
<!---------------------	6. 컴포넌트	이벤트	처리	------------------------------>



<!-- 협력사 KillFocus -->
<script	language=JavaScript	for=EM_S_VEN_CD	event=onKillFocus()>
	//변경된 내역이 없으면 무시
	if(!this.Modified)
		return
		
	if(EM_S_VEN_CD.Text	!= "")
		getVenInfo(EM_S_VEN_CD,	EM_S_VEN_NM, false);
	else
		EM_S_VEN_NM.Text = "";
</script>

<!-- 조회부 품번	KillFocus -->
<script	language=JavaScript	for=EM_S_PUMBUN_CD event=onKillFocus()>

	if(EM_S_PUMBUN_CD.Text != ""){
		searchPumbunNonPop();
	}else
		EM_S_PUMBUN_NM.Text	= "";  
</script>



<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리	끝												*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의									*-->
<!--*	 1.	DataSet
<!--*	 2.	Transaction	  
<!--*************************************************************************-->

<!---------------------	1. DataSet	------------------------------------------->
<!-- =============== Input용	-->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_O_STR_CD"	 classid=<%= Util.CLSID_DATASET	%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"	 classid=<%= Util.CLSID_DATASET	%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET	%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SEARCH"	 classid=<%= Util.CLSID_DATASET	%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"	 classid=<%= Util.CLSID_DATASET	%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_SALE_DATE" classid=<%= Util.CLSID_DATASET	%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"	 classid=<%= Util.CLSID_DATASET	%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"	 classid=<%= Util.CLSID_DATASET	%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============in_out -->
<comment id="_NSID_"><object id="ds_birth_s" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="ds_birth_e" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="ds_age" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!---------------------	2. Transaction	--------------------------------------->
<comment id="_NSID_">
<object	id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName"	value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object	id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName"	value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝								*-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작															*-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<table width="100%"	 border="0"	cellspacing="0"	cellpadding="0">

<!--공통 타이틀/버튼 -->
<%@	include	file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

  <tr>
	<td	class="PT01	PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
	  <tr>
		<td><table width="100%"	border="0" cellpadding="0" cellspacing="0" class="s_table">
		<tr>
			<th	width="60" class="point">점</th>
			<td	>
				<comment id="_NSID_">
					<object	id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO	%> width=100 tabindex=1	align="absmiddle"></object>
				</comment><script>_ws_(_NSID_);</script>
			</td>
			<th	width="60" class="point">협력사</th>
			<td >
				<comment id="_NSID_"> 
					<object	id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=55 tabindex=1 align="absmiddle"></object> 
				</comment><script> _ws_(_NSID_);</script>
					<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VEN" class="PR03"	align="absmiddle" onclick="javascript:getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM, true);" />
				<comment id="_NSID_"> 
					<object	id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=130	tabindex=1 align="absmiddle"></object> 
				</comment><script>_ws_(_NSID_);</script>
			</td>	
			<th	width="60">품번</th>
			<td	colspan="3">
				<comment id="_NSID_"> 
					<object	id=EM_S_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=55 tabindex=1 align="absmiddle"></object> 
				</comment><script> _ws_(_NSID_);</script>
					<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VEN" class="PR03"	align="absmiddle" onclick="javascript:searchPumbunPop();"  />
				<comment id="_NSID_"> 
					<object	id=EM_S_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=145 tabindex=1 align="absmiddle"></object> 
				</comment><script>_ws_(_NSID_);</script>
			</td> 
		</tr>
		
		<tr>
			<th	>고객명</th>
			<td>
				<comment id="_NSID_">
					<object	id=EM_CUST_NAME	classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1	align="absmiddle"></object>
				</comment><script> _ws_(_NSID_);</script>
			</td>
			<th	>카드번호</th>
			<td>
				<comment id="_NSID_">
					<object	id=EM_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width=225 tabindex=1 align="absmiddle"></object> 
				</comment><script> _ws_(_NSID_);</script>
			</td>
			<th	class="point">매출기간</th>
			<td	colspan="3">
				<comment id="_NSID_">
					<object	id=EM_S_SALE_S_DT classid=<%=Util.CLSID_EMEDIT%> width="90" onblur="javascript:checkDateTypeYMD(this);" tabindex=1 align="absmiddle"></object>
				</comment><script>_ws_(_NSID_);</script>
				<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_SALE_S_DT)" />
				~
				<comment id="_NSID_">
					<object id=EM_S_SALE_E_DT classid=<%=Util.CLSID_EMEDIT%> width="90" onblur="javascript:checkDateTypeYMD(this);" tabindex=1 align="absmiddle"></object>
				</comment><script>_ws_(_NSID_);</script>
				<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_SALE_E_DT)" align="absmiddle" />
			</td>	  
		</tr>
 		<tr>
			<th>
				지역
			</th>
			<td>
				<comment id="_NSID_">
					<object	id=homeaddr1	classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1	align="absmiddle"></object>
				</comment><script> _ws_(_NSID_);</script>
			</td>
			<th>
				생월
			</th>
			<td>
				<comment id="_NSID_">
					<object	id=birth_s classid=<%= Util.CLSID_LUXECOMBO	%> width=70 tabindex=1	align="absmiddle"></object>
				</comment><script>_ws_(_NSID_);</script> ~ 
				<comment id="_NSID_">
					<object	id=birth_e classid=<%= Util.CLSID_LUXECOMBO	%> width=70 tabindex=1	align="absmiddle"></object>
				</comment><script>_ws_(_NSID_);</script>
			</td>
			<th>
				구매금액
			</th>
			<td>
				<comment id="_NSID_">
					<object	id=sale_s	classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1	align="absmiddle"></object>
				</comment><script> _ws_(_NSID_);</script> ~ 
				<comment id="_NSID_">
					<object	id=sale_e	classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1	align="absmiddle"></object>
				</comment><script> _ws_(_NSID_);</script>
			</td>
			<th>
				연령별
			</th>
			<td>
				<comment id="_NSID_">
					<object	id=age classid=<%= Util.CLSID_LUXECOMBO	%> width=100 tabindex=1	align="absmiddle"></object>
				</comment><script>_ws_(_NSID_);</script>
			</td>
		</tr>
		</table></td>
	  </tr>
	</table></td>
  </tr>
  
  <tr>
	<td	class="dot"></td>
  </tr>
  
	<tr	valign="top">
		<td>
		<table width="100%"	border="0" cellspacing="0" cellpadding="0">
			<tr	valign="top">
				<td>
				<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
					<tr>
					<td>
						<comment id="_NSID_"> 
							<OBJECT	id=GR_MASTER width=100%	height=200 classid=<%=Util.CLSID_GRID%>>
							   <param name="DataID"	value="DS_IO_MASTER">
							</OBJECT> 
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
		<td>
		<table width="100%"	border="0" cellspacing="0" cellpadding="0">
			<tr	valign="top">
				<td>
				<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
					<tr>
					<td>
						<comment id="_NSID_"> 
							<OBJECT	id=GR_DETAIL width=100%	height=200 classid=<%=Util.CLSID_GRID%>>
							   <param name="DataID"	value="DS_IO_DETAIL">
							</OBJECT> 
						</comment><script>_ws_(_NSID_);</script>
					</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr> 
</table>

 <!-----------------------------------------------------------------------------
  Gauce	Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
	<object	id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
		<param name=DataID			value=DS_I_SEARCH>
		<param name="ActiveBind"	value=true>
		<param name=BindInfo		value='
			<c>Col=STR_CD			   Ctrl=LC_S_STR_CD				param=BindColVal</c>
			<c>Col=TERM_S_DT		   Ctrl=EM_S_SALE_S_DT			param=Text</c>
			<c>Col=TERM_E_DT		   Ctrl=EM_S_SALE_E_DT			param=Text</c>		
			<c>Col=VEN_CD			   Ctrl=EM_S_VEN_CD				param=Text</c>	
		'>
	</object>
</comment><script>_ws_(_NSID_);</script>

</body>
</html>
