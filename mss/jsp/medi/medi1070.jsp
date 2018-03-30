<!--
/*******************************************************************************
 * 시스템명 : 영업관리 > 협력사EDI > 단골고객관리 > 단골고객조회
 * 작 성 일 : 2012.07.11
 * 작 성 자 : 홍종영
 * 수 정 자 :
 * 파 일 명 : medi1070.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 협력사의 사원 정보를 관리한다.
 * 이    력 :
 *        2012.07.11 (홍종영) 신규작성
  ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                							*-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" 		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" 	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                       							    *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 해당 페이지 LOAD 시
 * return값 : void
 */
function doInit() {
	// Input Data Set Header 초기화

	// Output Data Set Header 초기화
	DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_LIST"/>');

	gridCreate1();

	//콤보 초기화
	//1. 조회조건
	initComboStyle(LC_S_STR_CD,			DS_O_STR_CD,		"CODE^0^30,NAME^0^80",	1,	PK);		// 점(조회)
	
	//2. 본문내용
	initComboStyle(LC_IO_DOMAIN_FLAG,	DS_IO_DOMAIN_FLAG, 	"CODE^0^30,NAME^0^80",	1,	NORMAL);	//도메인 구분
	initComboStyle(IN_GRADE_FLAG,	DS_IN_GRADE_FLAG, 	"CODE^0^30,NAME^0^80",	1,	NORMAL);		//등급 구분


	//EMEDIT 초기화
	//1. 조회조건
	initEmEdit(EM_S_VEN_CD,				"000000",			PK);				//협력사코드
	initEmEdit(EM_S_VEN_NM,				"GEN^40",			READ);				//협력사명
	initEmEdit(EM_S_PUMBUN_CD,			"000000",			PK);				//품번코드
	initEmEdit(EM_S_PUMBUN_NM,			"GEN^40",			READ);				//품번명
	initEmEdit(EM_S_CUST_NAME,			"GEN^40",			NORMAL);			//고객명
	initEmEdit(EM_S_CARD_NO,			"####-####-####-####",NORMAL);			//카드번호
	initEmEdit(EM_S_DT,					"YYYYMMDD",			PK);				//등록 시작일
	initEmEdit(EM_E_DT,					"YYYYMMDD",			PK);				//등록 종료일

	//2. 본문내용
	initEmEdit(EM_IO_CARD_NO,			"####-####-####-####",READ);  			//카드번호
	initEmEdit(EM_IO_PUMBUN_CD,			"CODE^6^0",			READ);  			//브랜드코드
	initEmEdit(EM_IO_PUMBUN_NM,			"GEN^40",			READ);  			//브랜드명
	initEmEdit(EM_IO_CUST_NAME,			"GEN",				READ);  			//성명(한글)
	initEmEdit(EM_IO_BIRTH_DT,			"YYYYMMDD",			READ);				//생년월일
	initEmEdit(EM_IO_WED_DT,			"YYYYMMDD",			READ);				//결혼기념일
	initEmEdit(EM_IO_HOME_ZIP_CD1,		"NUMBER2^3^0",		READ);				//집우편번호1
	initEmEdit(EM_IO_HOME_ZIP_CD2,		"NUMBER2^3^0",		READ);				//집우편번호2
	initEmEdit(EM_IO_HOME_ADDR1,		"GEN^100",			READ);				//집주소1
	initEmEdit(EM_IO_HOME_ADDR2,		"GEN^100",			READ);				//집주소2
	initEmEdit(EM_IO_HOME_PH1,			"NUMBER3^4^0",		READ);				//자택전화1
	initEmEdit(EM_IO_HOME_PH2,			"NUMBER3^4^0",		READ);				//자택전화2
	initEmEdit(EM_IO_HOME_PH3,			"NUMBER3^4^0",		READ);				//자택전화3
	initEmEdit(EM_IO_MOBILE_PH1,		"NUMBER3^3^0",		READ);				//핸드폰번호1
	initEmEdit(EM_IO_MOBILE_PH2,		"NUMBER3^4^0",		READ);				//핸드폰번호2
	initEmEdit(EM_IO_MOBILE_PH3,		"NUMBER3^4^0",		READ);				//핸드폰번호3
	initEmEdit(EM_IO_OFFI_ZIP_CD1,		"NUMBER2^3^0",		READ);				//직장우편번호1
	initEmEdit(EM_IO_OFFI_ZIP_CD2,		"NUMBER2^3^0",		READ);				//직장우편번호2
	initEmEdit(EM_IO_OFFI_ADDR1,		"GEN^100",			READ);				//직장주소1
	initEmEdit(EM_IO_OFFI_ADDR2,		"GEN^100",			READ);				//직장주소2
	initEmEdit(EM_IO_OFFI_PH1,			"NUMBER3^4^0",		READ);				//직장전화1
	initEmEdit(EM_IO_OFFI_PH2,			"NUMBER3^4^0",		READ);				//직장전화2
	initEmEdit(EM_IO_OFFI_PH3,			"NUMBER3^4^0",		READ);				//직장전화3
	initEmEdit(EM_IO_OFFI_FAX1,			"NUMBER3^3^0",		READ);				//FAX번호1
	initEmEdit(EM_IO_OFFI_FAX2,			"NUMBER3^4^0",		READ);				//FAX번호2
	initEmEdit(EM_IO_OFFI_FAX3,			"NUMBER3^4^0",		READ);				//FAX번호3
	initEmEdit(EM_IO_EMAIL1,			"GEN",				READ);				//이메일1
	initEmEdit(EM_IO_EMAIL2,			"GEN",				READ);				//이메일2
	initEmEdit(EM_IO_HOBBY,				"GEN",				READ);				//취미
	initEmEdit(EM_IO_RELIGION,			"GEN",				READ);				//종교
	initEmEdit(EM_IO_REG_DATE,			"YYYYMMDD",			READ);				//등록일
	initEmEdit(EM_IO_SALE_AMT,			"NUMBER^10^0",		READ);				//3개월매출	
	initEmEdit(EM_IO_ETC,				"GEN^100",			READ);				//기타
 	initEmEdit(EM_IO_FAMILY1,			"GEN^40",			READ);				//가족관계1
	initEmEdit(EM_IO_FAMILY1_NM,		"GEN^40",			READ);				//가족이름1
	initEmEdit(EM_IO_FAMILY2,			"GEN^40",			READ);				//가족관계2
	initEmEdit(EM_IO_FAMILY2_NM,		"GEN^40",			READ);				//가족이름2
	initEmEdit(EM_IO_FAMILY3,			"GEN^40",			READ);				//가족관계3
	initEmEdit(EM_IO_FAMILY3_NM,		"GEN^40",			READ);				//가족이름3
	initEmEdit(EM_IO_FAMILY4,			"GEN^40",			READ);				//가족관계4
	initEmEdit(EM_IO_FAMILY4_NM,		"GEN^40",			READ);				//가족이름4
	initTxtAreaEdit(TX_IO_ETC2,			"WINTER",			READ);				//특이사항

	//점콤보 가져오기 ( gauce.js )
	getStore("DS_O_STR_CD", "Y", "", "N");

	setComboData(LC_S_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />');	//점

	getEtcCode("DS_IO_DOMAIN_FLAG",	"D", "D013", "N");							//도메인 값 불러오기
	setComboData(LC_IO_DOMAIN_FLAG,"99");										//도메인 시작 값
	
	getEtcCode("DS_IN_GRADE_FLAG",	"D", "P626", "N");							//도메인 값 불러오기
	setComboData(IN_GRADE_FLAG,"01");										//도메인 시작 값

	LC_S_STR_CD.index = 0;
	LC_S_STR_CD.Focus(); 
	setEnable();
	
}


/**
 * gridCreate1()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 그리드 생성
 * return값 : void
 */
function gridCreate1() {
	var hdrProperies = '<FC>id={currow}		name="NO"		width=30	align=center</FC>'
					 + '<FC>id=CUST_NAME	name="이름"		width=70	align=center</FC>'
					 + '<FC>id=BIRTH_DT		name="생년월일"	width=90	align=center</FC>'
					 + '<FC>id=CARD_NO		name="카드번호"	width=140	align=center	mask=XXXX-XXXX-XXXX-XXXX</FC>'
					 + '<FC>id=MOBILE_PH1	name="PH1"		width=50	align=center</FC>'
					 + '<FC>id=MOBILE_PH2	name="PH2"		width=50	align=center</FC>'
					 + '<FC>id=MOBILE_PH3	name="PH3"		width=50	align=center</FC>'
					 + '<FC>id=REG_DATE		name="등록일"		width=90	align=center</FC>';

	initGridStyle(GD_MASTER, "common", hdrProperies, false);
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
 * 작 성 일 : 2012-07-06
 * 개    요 : 조회
 * return값 : void
 */
function btn_Search() {
	
	if(EM_S_VEN_CD.Text == "" && EM_S_VEN_NM.Text == ""){
		showMessage(EXCLAMATION , OK, "USER-1000", "협력사코드를 입력하여 주세요");
		EM_S_VEN_CD.focus();
	}else{
		if(EM_S_PUMBUN_CD.Text == "" && EM_S_PUMBUN_NM.Text == ""){
			showMessage(EXCLAMATION , OK, "USER-1000", "품번코드를 입력하여 주세요");
			EM_S_PUMBUN_CD.focus();
		}
	}

	if(EM_S_DT.Text > EM_E_DT.Text){
		showMessage(EXCLAMATION , OK, "USER-1000", "등록 시작일은 등록 종료일 보다 작아야 합니다");
		EM_S_DT.focus();
	}
	
	if(LC_S_STR_CD.BindColVal != "" && EM_S_VEN_CD.Text != "" && EM_S_PUMBUN_CD.Text != ""){
	
		// 조회조건 셋팅
		var	strStrCd	= LC_S_STR_CD.BindColVal;	// 점
		var	strVenCd	= EM_S_VEN_CD.Text;			// 협력사
		var	strPumbunCd	= EM_S_PUMBUN_CD.Text;		// 품번
		var	strCustName	= EM_S_CUST_NAME.Text;		// 고객명
		var	strCardNo	= EM_S_CARD_NO.Text			// 카드번호
		var	strSdt		= EM_S_DT.Text;				// 매출기간시작
		var	strEdt 		= EM_E_DT.Text;				// 매출기간종료
		
		var	goTo		= "searchList";	 
		var	action		= "O";	  
		var	parameters	= "&strStrCd="   +encodeURIComponent(strStrCd)
					  	+ "&strVenCd="   +encodeURIComponent(strVenCd)
					  	+ "&strPumbunCd="+encodeURIComponent(strPumbunCd)
					  	+ "&strCustName="+encodeURIComponent(strCustName)
					  	+ "&strCardNo="  +encodeURIComponent(strCardNo)
					  	+ "&strSdt="     +encodeURIComponent(strSdt)
					  	+ "&strEdt="     +encodeURIComponent(strEdt);
		TR_MAIN.Action	= "/mss/medi107.md?goTo="+goTo+parameters;	
		TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
		TR_MAIN.Post();
		
		setPorcCount("SELECT" ,GD_MASTER);
		EM_IO_PUMBUN_NM.text = EM_S_PUMBUN_NM.text;
	}
	
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 신규
 * return값 : void
 */
function btn_New() {
	
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 삭제
 * return값 : void
 */
function btn_Delete() {
	
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 저장
 * return값 : void
 */
function btn_Save() {
	
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 엑셀
 * return값 : void
 */
function btn_Excel() {
	
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 출력
 * return값 : void
 */
function btn_Print() {
	
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 확정
 * return값 : void
 */
function btn_Conf() {
	
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
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
	var tmpOrgCd		= LC_S_STR_CD.BindColVal;
	var strUsrCd		= '<c:out	value="${sessionScope.sessionInfo.USER_ID}"	/>';	// 세션 사원번호
	var strStrCd		= LC_S_STR_CD.BindColVal;										// 점
	var strOrgCd		= tmpOrgCd + "00000000";										// 조직코드
	var strVenCd		= EM_S_VEN_CD.Text;												// 협력사
	var strBuyerCd		= "";															// 바이어
	var strPumbunType	= "";															// 품번유형
	var strUseYn		= "Y";															// 사용여부
	var strSkuFlag		= "";															// 단품구분
	var strSkuType		= "";															// 단품종류(1:규격단품)
	var strItgOrdFlag	= "";															// 통합발주여부
	var strBizType		= "";															// 거래형태(2:특정)	
	var strSaleBuyFlag	= "";															// 판매분매입구분
	
	var rtnMap = strPbnPop( EM_S_PUMBUN_CD
						  , EM_S_PUMBUN_NM, 'Y'
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
 * 작 성 자 : 홍종영
 * 작 성 일 : 2010-03-18
 * 개	  요	:  조회조건	품번팝업
 * return값 : void
 */
function searchPumbunNonPop(){
	var tmpOrgCd		= LC_S_STR_CD.BindColVal;
	var strUsrCd		= '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';	// 세션 사원번호
	var strStrCd		= LC_S_STR_CD.BindColVal;									// 점
	var strOrgCd		= tmpOrgCd +	"00000000";									// 조직코드
	var strVenCd		= EM_S_VEN_CD.Text;											// 협력사
	var strBuyerCd		= "";														// 바이어
	var strPumbunType   = "";														// 품번유형
	var strUseYn		= "Y";														// 사용여부
	var strSkuFlag		= "";														// 단품구분
	var strSkuType		= "";														// 단품종류(1:규격단품)
	var strItgOrdFlag	= "";														// 통합발주여부
	var strBizType		= "";														// 거래형태(2:특정) 
	var strSaleBuyFlag	= "";														// 판매분매입구분
	
	
	var rtnMap =	setStrPbnNmWithoutPop( "DS_O_RESULT", EM_S_PUMBUN_CD, EM_S_PUMBUN_NM, "Y", "1"
				  ,	strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
				  ,	strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
				  ,	strBizType,	strSaleBuyFlag);		   
	
	if(rtnMap != null){
		return true;
	}else{
		return false;
	}
} 

function setEnable(){
/* 	EM_IO_CARD_NO.Enable			= false;
	EM_IO_CUST_NAME.Enable			= false;

	EM_IO_BIRTH_DT.Enable			= false;

	EM_IO_WED_DT.Enable				= false;

	EM_IO_HOME_ADDR1.Enable			= false;
	EM_IO_HOME_ADDR2.Enable			= false;
	EM_IO_HOME_PH1.Enable			= false;
	EM_IO_HOME_PH2.Enable			= false;
	EM_IO_HOME_PH3.Enable			= false;
	EM_IO_MOBILE_PH1.Enable			= false;
	EM_IO_MOBILE_PH2.Enable			= false;
	EM_IO_MOBILE_PH3.Enable			= false;
	EM_IO_OFFI_ADDR1.Enable			= false;
	EM_IO_OFFI_ADDR2.Enable			= false;
	EM_IO_OFFI_PH1.Enable			= false;
	EM_IO_OFFI_PH2.Enable			= false;
	EM_IO_OFFI_PH3.Enable			= false;
	EM_IO_OFFI_FAX1.Enable			= false;
	EM_IO_OFFI_FAX2.Enable			= false;
	EM_IO_OFFI_FAX3.Enable			= false;
	EM_IO_EMAIL1.Enable				= false;
	EM_IO_EMAIL2.Enable				= false;

	EM_IO_HOBBY.Enable				= false;
	EM_IO_RELIGION.Enable			= false;
	EM_IO_REG_DATE.Enable			= false;
	EM_IO_SALE_AMT.Enable			= false;
	EM_IO_ETC.Enable				= false;
	EM_IO_FAMILY1.Enable			= false;
	EM_IO_FAMILY1_NM.Enable			= false;
	EM_IO_FAMILY2.Enable			= false;
	EM_IO_FAMILY2_NM.Enable			= false;
	EM_IO_FAMILY3.Enable			= false;
	EM_IO_FAMILY3_NM.Enable			= false;
	EM_IO_FAMILY4.Enable			= false;
	EM_IO_FAMILY4_NM.Enable			= false;*/
	LC_IO_DOMAIN_FLAG.Enable		= false;	
	IN_GRADE_FLAG.Enable			= false;	
	RD_IO_SEX_CD.Enable				= false;
	RD_IO_BIRTH_LUNAR_FLAG.Enable	= false;
	RD_IO_WED_FLAG.Enable			= false;
	TX_IO_ETC2.Enable				= false; 
	IN_SMS_FLAG.Enable				= false;
	IN_EMAIL_FLAG.Enable			= false;
	
}	

// MARIO OUTLET END
//-->

</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                    									*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 								*-->
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
	trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!--  ===================SEARCH CONDITION AREA START ================= -->

<!--  ===================DS_MASTER START ============================ -->

<!-- 협력사 KillFocus -->
<script	language=JavaScript	for=EM_S_VEN_CD	event=onKillFocus()>
	//변경된 내역이 없으면 무시
	if(!this.Modified){
		return;
	}
	if(EM_S_VEN_CD.Text	!= ""){
		getVenInfo(EM_S_VEN_CD,	EM_S_VEN_NM, false);
	}else{
		EM_S_VEN_NM.Text = "";
	}
</script>

<!-- 조회부 품번	KillFocus -->
<script	language=JavaScript	for=EM_S_PUMBUN_CD event=onKillFocus()>
	if(!this.Modified){
		return;
	}
	if(EM_S_PUMBUN_CD.Text != ""){
		searchPumbunNonPop();
	}else{
		EM_S_PUMBUN_NM.Text	= "";
	}
		  
</script>


<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               							*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   					*-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_O_STR_CD"		classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"		classid=<%= Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== Input/Output 겸용 -->
<comment id="_NSID_"><object id="DS_IO_DOMAIN_FLAG" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IN_GRADE_FLAG" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
	<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
		<param name="KeyName" value="Toinb_dataid4">
	</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                 	*-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                         *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">

	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
					<tr>
						<th	width="60" class="point">점</th>
						<td	width="100">
							<comment id="_NSID_">
								<object	id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO	%> width=100 tabindex=1	align="absmiddle"></object>
							</comment><script>_ws_(_NSID_);</script>
						</td>
						<th	width="60" class="point">협력사</th>
						<td width="210">
							<comment id="_NSID_"> 
								<object	id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=55 tabindex=1 align="absmiddle"></object> 
							</comment><script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VEN" class="PR03"	align="absmiddle" onclick="javascript:getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM, true);" />
							<comment id="_NSID_"> 
								<object	id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=125	tabindex=1 align="absmiddle"></object> 
							</comment><script>_ws_(_NSID_);</script>
						</td>	
						<th	width="60">품번</th>
						<td>
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
						<th	width="60">고객명</th>
						<td	width="100">
							<comment id="_NSID_">
								<object	id=EM_S_CUST_NAME	classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1	align="absmiddle"></object>
							</comment><script> _ws_(_NSID_);</script>
						</td>
						<th	width="60">카드번호</th>
						<td>
							<comment id="_NSID_">
								<object	id=EM_S_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width=205 tabindex=1 align="absmiddle"></object> 
							</comment><script> _ws_(_NSID_);</script>
						</td>
						<th	width="60" class="point">등록일</th>
						<td>
							<comment id="_NSID_">
								<object	id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%> width="84" onblur="javascript:checkDateTypeYMD(this);" tabindex=1 align="absmiddle"></object>
							</comment><script>_ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_DT)" />
							~
							<comment id="_NSID_">
								<object id=EM_E_DT classid=<%=Util.CLSID_EMEDIT%> width="84" onblur="javascript:checkDateTypeYMD(this);" tabindex=1 align="absmiddle"></object>
							</comment><script>_ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_E_DT)" align="absmiddle" />
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
				<td width="280">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
						<tr>
							<td>
								<comment id="_NSID_">
									<object id=GD_MASTER width="100%" height="453" classid=<%=Util.CLSID_GRID%>>
										<param name="DataID" value="DS_IO_MASTER">
									</object>
								</comment>
								<script>_ws_(_NSID_);</script>
							</td>
						</tr>
					</table>
				</td>
				<td class="PL10">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="sub_title PB03 PT10">
								<img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PB03" align="absmiddle" /> 기본정보
							</td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table_1">
								<tr>
									<th width="70">카드번호</th>
									<td width="150">
										<comment id="_NSID_">
											<object id=EM_IO_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width=144 tabindex=1 align="left"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
									<th width="70" class="point">브랜드</th>
									<td colspan="3">
										<comment id="_NSID_">
											<object id=EM_IO_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" align="absmiddle" />
										<comment id="_NSID_">
											<object id=EM_IO_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=55% tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
									<th class="point">성명</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_CUST_NAME classid=<%=Util.CLSID_EMEDIT%> width=144 tabindex=1 align="left"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
									</td>
									<th class="point">성별</th>
									<td colspan="3">
										<comment id="_NSID_">
											<object id=RD_IO_SEX_CD classid=<%=Util.CLSID_RADIO%> width=90 height="20" tabindex=1>
												<param name=Cols value="2">
												<param name=Format value="M^남,F^여">
												<param name="AutoMargin" value="true">
												<param name=CodeValue value="M">
											 </object>
										</comment>
										<script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
									<th class="point">생년월일</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_BIRTH_DT classid=<%=Util.CLSID_EMEDIT%> width=124 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" />
									</td>
									<th class="point">생일구분</th>
									<td colspan="3">
										<comment id="_NSID_">
											<object id=RD_IO_BIRTH_LUNAR_FLAG classid=<%=Util.CLSID_RADIO%> width=140 height="20" tabindex=1>
												<param name=Cols value="2">
												<param name=Format value="S^양력,L^음력">
												<param name="AutoMargin" value="true">
												<param name=CodeValue value="S">
											 </object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
									<th>결혼여부</th>
									<td>
										<comment id="_NSID_">
											<object id=RD_IO_WED_FLAG classid=<%=Util.CLSID_RADIO%> width=140 height="20" tabindex=1>
												<param name=Cols value="2">
												<param name=Format value="0^미혼,1^기혼">
												<param name="AutoMargin" value="true">
												<param name=CodeValue value="S">
											 </object>
										</comment><script>_ws_(_NSID_);</script>
										
									</td>
									<th>결혼기념일</th>
									<td colspan="3">
										<comment id="_NSID_">
											<object id=EM_IO_WED_DT classid=<%=Util.CLSID_EMEDIT%> width=124 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" />
									</td>
								</tr>

								<tr>
									<th rowspan="2">자택주소</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_HOME_ZIP_CD1 classid=<%=Util.CLSID_EMEDIT%> width=56 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										-
										<comment id="_NSID_">
											<object id=EM_IO_HOME_ZIP_CD2 classid=<%=Util.CLSID_EMEDIT%> width=56 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" align="absmiddle" />
									</td>
									<td colspan="4">
										<comment id="_NSID_">
											<object id=EM_IO_HOME_ADDR1 classid=<%=Util.CLSID_EMEDIT%> width=280 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
									<td colspan="5">
										<comment id="_NSID_">
											<object id=EM_IO_HOME_ADDR2 classid=<%=Util.CLSID_EMEDIT%> width=435 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
									<th class="point">자택전화</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_HOME_PH1 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										-
										<comment id="_NSID_">
											<object id=EM_IO_HOME_PH2 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										-
										<comment id="_NSID_">
											<object id=EM_IO_HOME_PH3 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
									<th class="point">핸드폰번호</th>
									<td colspan="3">
										<comment id="_NSID_">
											<object id=EM_IO_MOBILE_PH1 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>-										
										<comment id="_NSID_">
											<object id=EM_IO_MOBILE_PH2 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>-
										<comment id="_NSID_">
											<object id=EM_IO_MOBILE_PH3 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
									<th rowspan="2">직장주소</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_OFFI_ZIP_CD1 classid=<%=Util.CLSID_EMEDIT%> width=56 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>-
										<comment id="_NSID_">
											<object id=EM_IO_OFFI_ZIP_CD2 classid=<%=Util.CLSID_EMEDIT%> width=56 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" align="absmiddle" />
									</td>
									<td colspan="4">
										<comment id="_NSID_">
											<object id=EM_IO_OFFI_ADDR1 classid=<%=Util.CLSID_EMEDIT%> width=280 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
									<td colspan="5">
										<comment id="_NSID_">
											<object id=EM_IO_OFFI_ADDR2 classid=<%=Util.CLSID_EMEDIT%> width=435 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
									<th>직장전화</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_OFFI_PH1 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>-
										<comment id="_NSID_">
											<object id=EM_IO_OFFI_PH2 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>-
										<comment id="_NSID_">
											<object id=EM_IO_OFFI_PH3 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
									<th>FAX번호</th>
									<td colspan="3">
										<comment id="_NSID_">
											<object id=EM_IO_OFFI_FAX1 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>-										
										<comment id="_NSID_">
											<object id=EM_IO_OFFI_FAX2 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>-
										<comment id="_NSID_">
											<object id=EM_IO_OFFI_FAX3 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
									<th>E-MAIL</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_EMAIL1 classid=<%=Util.CLSID_EMEDIT%> width=144 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
									<td>
										<comment id="_NSID_">
											<object id=LC_IO_DOMAIN_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=100% tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
									</td>
									<td colspan="3">
										<comment id="_NSID_">
											<object id=EM_IO_EMAIL2 classid=<%=Util.CLSID_EMEDIT%> width=194 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
									<th>취미</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_HOBBY classid=<%=Util.CLSID_EMEDIT%> width=144 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
									<th>종교</th>
									<td colspan="3">
										<comment id="_NSID_">
											<object id=EM_IO_RELIGION classid=<%=Util.CLSID_EMEDIT%> width=194 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
									<th>등록일</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_REG_DATE classid=<%=Util.CLSID_EMEDIT%> width=124 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" />
									</td>
									<th>3개월 매출</th>
									<td colspan="3">
										<comment id="_NSID_">
											<object id=EM_IO_SALE_AMT classid=<%=Util.CLSID_EMEDIT%> width=194 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
									<th>기타</th>
									<td colspan="5">
										<comment id="_NSID_">
											<object id=EM_IO_ETC classid=<%=Util.CLSID_EMEDIT%> width=435 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
								<th class="right" >등급</th>
								<td>
							<comment id="_NSID_">
								<object	id=IN_GRADE_FLAG classid=<%= Util.CLSID_LUXECOMBO	%> width=100 tabindex=1	align="absmiddle"></object>
							</comment><script>_ws_(_NSID_);</script>
								
								</td>
								<th class="right" >SMS 발신</th>
								<td>
									<comment id="_NSID_">
										<object id=IN_SMS_FLAG classid=<%=Util.CLSID_RADIO%> width=140 height="20" tabindex=1>
											<param name=Cols value="2">
											<param name=Format value="Y^동의,N^비동의">
											<param name="AutoMargin" value="true">
											<param name=CodeValue>
										 </object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								<th class="right" >E-MAIL 발신</th>
								<td>
									<comment id="_NSID_">
										<object id=IN_EMAIL_FLAG classid=<%=Util.CLSID_RADIO%> width=140 height="20" tabindex=1>
											<param name=Cols value="2">
											<param name=Format value="Y^동의,N^비동의">
											<param name="AutoMargin" value="true">
											<param name=CodeValue>
										 </object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								</tr>
								<tr>
									<th colspan="2">가족사항</th> <th colspan="4">특이사항</th>
								</tr>
								<tr>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_FAMILY1 classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_FAMILY1_NM classid=<%=Util.CLSID_EMEDIT%> width=144 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
									<td colspan="4" rowspan="4" >
										<comment id="_NSID_">
											<object id=TX_IO_ETC2 classid=<%=Util.CLSID_TEXTAREA%> width=100% height=100% tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>								
								<tr>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_FAMILY2 classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_FAMILY2_NM classid=<%=Util.CLSID_EMEDIT%> width=144  tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>	
								<tr>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_FAMILY3 classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_FAMILY3_NM classid=<%=Util.CLSID_EMEDIT%> width=144 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>	
								<tr>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_FAMILY4 classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_FAMILY4_NM classid=<%=Util.CLSID_EMEDIT%> width=144 tabindex=1 align="absmiddle"></object>
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
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object	id=BO_HEADER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
			<c>col=CARD_NO				ctrl=EM_IO_CARD_NO				param=Text	</c>									
			<c>col=PUMBUN_CD			ctrl=EM_IO_PUMBUN_CD			param=Text	</c>
			<c>col=CUST_NAME			ctrl=EM_IO_CUST_NAME			param=Text	</c>
			<c>col=SEX_CD				ctrl=RD_IO_SEX_CD				param=CodeValue	</c>
			<c>col=BIRTH_DT				ctrl=EM_IO_BIRTH_DT				param=Text	</c>
			<c>col=BIRTH_LUNAR_FLAG		ctrl=RD_IO_BIRTH_LUNAR_FLAG		param=CodeValue	</c>
			<c>col=WED_DT				ctrl=EM_IO_WED_DT				param=Text	</c>
			<c>col=WED_FLAG		ctrl=RD_IO_WED_FLAG		param=CodeValue	</c>			
			<c>col=HOME_ZIP_CD1			ctrl=EM_IO_HOME_ZIP_CD1			param=Text	</c>
			<c>col=HOME_ZIP_CD2			ctrl=EM_IO_HOME_ZIP_CD2			param=Text	</c>
			<c>col=HOME_ADDR1			ctrl=EM_IO_HOME_ADDR1			param=Text	</c>
			<c>col=HOME_ADDR2			ctrl=EM_IO_HOME_ADDR2			param=Text	</c>
			<c>col=HOME_PH1				ctrl=EM_IO_HOME_PH1				param=Text	</c>
			<c>col=HOME_PH2				ctrl=EM_IO_HOME_PH2				param=Text	</c>
			<c>col=HOME_PH3				ctrl=EM_IO_HOME_PH3				param=Text	</c>
			<c>col=MOBILE_PH1			ctrl=EM_IO_MOBILE_PH1			param=Text	</c>
			<c>col=MOBILE_PH2			ctrl=EM_IO_MOBILE_PH2			param=Text	</c>
			<c>col=MOBILE_PH3			ctrl=EM_IO_MOBILE_PH3			param=Text	</c>
			<c>col=OFFI_ZIP_CD1			ctrl=EM_IO_OFFI_ZIP_CD1			param=Text	</c>
			<c>col=OFFI_ZIP_CD2			ctrl=EM_IO_OFFI_ZIP_CD2			param=Text	</c>
			<c>col=OFFI_ADDR1			ctrl=EM_IO_OFFI_ADDR1			param=Text	</c>
			<c>col=OFFI_ADDR2			ctrl=EM_IO_OFFI_ADDR2			param=Text	</c>			
			<c>col=OFFI_PH1				ctrl=EM_IO_OFFI_PH1				param=Text	</c>
			<c>col=OFFI_PH2				ctrl=EM_IO_OFFI_PH2				param=Text	</c>
			<c>col=OFFI_PH3				ctrl=EM_IO_OFFI_PH3				param=Text	</c>
			<c>col=OFFI_FAX1			ctrl=EM_IO_OFFI_FAX1			param=Text	</c>
			<c>col=OFFI_FAX2			ctrl=EM_IO_OFFI_FAX2			param=Text	</c>
			<c>col=OFFI_FAX3			ctrl=EM_IO_OFFI_FAX3			param=Text	</c>
			<c>col=EMAIL1				ctrl=EM_IO_EMAIL1				param=Text	</c>
			<c>col=EMAIL2				ctrl=EM_IO_EMAIL2				param=Text	</c>
			<c>col=DOMAIN_FLAG			ctrl=LC_IO_DOMAIN_FLAG			param=BindColVal	</c>
			<c>col=HOBBY				ctrl=EM_IO_HOBBY				param=Text	</c>
			<c>col=RELIGION				ctrl=EM_IO_RELIGION				param=Text	</c>
			<c>col=REG_DATE				ctrl=EM_IO_REG_DATE				param=Text	</c>
			<c>col=SALE_AMT				ctrl=EM_IO_SALE_AMT				param=Text	</c>
			<c>col=ETC					ctrl=EM_IO_ETC					param=Text	</c>
			<c>col=FAMILY1				ctrl=EM_IO_FAMILY1				param=Text	</c>
			<c>col=FAMILY1_NM			ctrl=EM_IO_FAMILY1_NM			param=Text	</c>
			<c>col=FAMILY2				ctrl=EM_IO_FAMILY2				param=Text	</c>
			<c>col=FAMILY2_NM			ctrl=EM_IO_FAMILY2_NM			param=Text	</c>
			<c>col=FAMILY3				ctrl=EM_IO_FAMILY3				param=Text	</c>
			<c>col=FAMILY3_NM			ctrl=EM_IO_FAMILY3_NM			param=Text	</c>
			<c>col=FAMILY4				ctrl=EM_IO_FAMILY4				param=Text	</c>
			<c>col=FAMILY4_NM			ctrl=EM_IO_FAMILY4_NM			param=Text	</c>
			<c>col=ETC2					ctrl=TX_IO_ETC2					param=Text	</c>
			<c>col=GRADE				ctrl=IN_GRADE_FLAG				param=BindColVal	</c>
			<c>col=SMS_FLAG				ctrl=IN_SMS_FLAG				param=CodeValue	</c>
			<c>col=EMAIL_FLAG			ctrl=IN_EMAIL_FLAG				param=CodeValue	</c>
	'>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

