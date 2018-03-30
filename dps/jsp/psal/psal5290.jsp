<!-- 
/*******************************************************************************
 * 시스템명	: 매출관리 -> POS정산 -> 온라인몰 매출/정산 비교
 * 작 성 일	: 2012.07.03
 * 작 성 자	: 홍종영
 * 수 정 자	: 
 * 파 일 명	: psal5290.jsp
 * 버	 전	: 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개	 요	: 경품행사 당첨자를	등록 조회한다.
 * 이	 력	: 2012.07.03 (홍종영) 신규개발
 ******************************************************************************/
-->
<%@	page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@	taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@	taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@	taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@	taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<% request.setCharacterEncoding("utf-8"); %>

<!--*************************************************************************-->
<!--* A. 로그인	유무, 기본설정												  	*-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet"	type="text/css">
<script	language="javascript" src="/<%=dir%>/js/common.js"	type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/gauce.js"	type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/global.js"	type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/message.js"	type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/popup.js"	type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/popup_dps.js"	type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/popup_mss.js"	type="text/javascript"></script>


<!--*************************************************************************-->
<!--* B. 스크립트 시작															*-->
<!--*************************************************************************-->

<script	LANGUAGE="JavaScript"><!--

/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
 var	strToday = getTodayFormat("yyyymm");
 var	strSDate = addDate('M',	-1,	strToday);
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자	: 홍종영
 * 작 성 일	: 2012-07-03
 * 개	 요	: 해당 페이지 LOAD 시  
 * return값	: void
 */
 var top = 450;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";


	// Input Data Set Header 초기화
	DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
	DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
	// Output Data Set Header 초기화 

	//그리드 초기화
 	gridCreate1(); //Master
	gridCreate2(); //Detail
	
	//콤보 초기화
	initComboStyle(LC_S_STR_CD,DS_S_STR_CD,	"CODE^0^30,NAME^0^80", 1, PK);				//점(조회) 
	initComboStyle(LC_S_MAPPING_YN,DS_S_MAPPING_YN,	"CODE^0^30,NAME^0^80", 1, PK);		//확정여부
	
	// EMedit에	초기화
	initEmEdit(EM_COND_SALE_YM,	"YYYYMM", PK);									//정산월
	initEmEdit(EM_S_DT, "SYYYYMMDD", PK);										//기간FROM(조회)
	initEmEdit(EM_E_DT, "TODAY", PK);											//기간TO(조회) 
    initEmEdit(EM_ORDERER_CD, "CODE^30", NORMAL);								//제휴몰코드
    initEmEdit(EM_ORDERER_NAME, "GEN", READ);									//제휴몰명
	initEmEdit(EM_PUMBUN_CD, "000000", NORMAL);									//브랜드코드
	initEmEdit(EM_PUMBUN_NM, "GEN^40", READ);									//브랜드명

	//공통코드에서 가져	오기
	getStore("DS_S_STR_CD",	"Y", "1", "N");				//점
	
	getEtcCode("DS_S_MAPPING_YN", "D", "P300", "Y");	//확정여부
	
	LC_S_STR_CD.Index = 0;		//콤보 초기값(전체)  
	LC_S_MAPPING_YN.Index = 0;  //콤보 초기값(전체)
	
	LC_S_STR_CD.Focus();
	
	EM_COND_SALE_YM.text = strToday;
	EM_COND_SALE_YM.alignment = 1;
	//registerUsingDataset("psal529","DS_O_MASTER" );
	//registerUsingDataset("psal529","DS_O_DETAIL" );

}

function gridCreate1(){	
	var	hdrProperies = '<C>id={currow}				name="NO"		width=35	align=center	</C>'
					 + '<C>id=SEL					name="선택"		width=50	align=center 	EditStyle=CheckBox	 HeadCheckShow="true" sumtext="합계"</C>'
					 + '<C>id=STR_CD				name="점"		width=50	align=center				show=false</C>'
					 + '<C>id=STR_NM				name="점명"		width=80	align=center	edit=none</C>'
					 + '<C>id=ORDERER_CD			name="제휴몰코드"	width=80	align=center	edit=none</C>'
					 + '<C>id=ORDERER_NM			name="제휴몰명"	width=80	align=center	edit=none</C>'
					 + '<C>id=PUMBUN_CD				name="브랜드코드"	width=80	align=center	edit=none</C>'
					 + '<C>id=PUMBUN_NM				name="브랜드명"	width=110	align=center	edit=none</C>'
					 + '<C>id=MAPPING_YN			name="확정여부"	width=55	align=center	edit=none</C>'
					 + '<G> 						name="월정산"'
					 + '<C>id=MONTH_SALE_QTY		name="수량"		width=50	align=center	edit=none				sumtext=@sum	sumplustext=" 개"</C>'
					 + '<C>id=MONTH_SALE_AMT		name="매출액"		width=100	align=RIGHT		edit=none				sumtext=@sum	sumplustext=" 원"</C>'
					 + '</G>'
					 + '<G> 						name="일매출"'
					 + '<C>id=DAY_SALE_QTY			name="수량"		width=50	align=center	edit=none				sumtext=@sum	sumplustext=" 개"</C>'
					 + '<C>id=DAY_SALE_AMT			name="매출액"		width=100	align=RIGHT		edit=none				sumtext=@sum	sumplustext=" 원"</C>'
					 + '</G>'
					 + '<C>id=COND_STR_CD			name="1"		width=50	align=center	edit=none	show=false</C>'
					 + '<C>id=COND_SALE_YM			name="2"		width=50	align=center	edit=none	show=false</C>'
					 + '<C>id=COND_SALE_S_DT		name="3"		width=50	align=center	edit=none	show=false</C>'
					 + '<C>id=COND_SALE_E_DT		name="4"		width=50	align=center	edit=none	show=false</C>'
					 + '<C>id=COND_MAPPING_YN		name="5"		width=50	align=center	edit=none	show=false</C>';
					 
	initGridStyle(GD_MASTER, "common", hdrProperies, true);
	GD_MASTER.ViewSummary = "1";
}

function gridCreate2(){
	var	hdrProperies1 =	'<C>id={currow}				name="NO"		width=35	align=center	</C>'
					  +	'<C>id=MON_MAPPING_YN		name="확정여부"	width=55	align=center	sumtext="합계"</C>'
					  + '<G> 						name="월정산"'
					  +	'<C>id=MON_SALE_YM			name="정산월"		width=65	align=center	mask="XXXX-XX"		suppress="1"</C>'
					  +	'<C>id=MON_ORDERER_NO		name="주문번호"	width=65	align=center						suppress="1"</C>'
					  +	'<C>id=MON_PRODUCT_CD		name="상품코드"	width=105	align=center    </C>'
					  +	'<C>id=MON_PRODUCT_NM		name="상품명"		width=280	align=center	</C>'
 					  +	'<C>id=MON_MONTH_SALE_QTY	name="수량"		width=50	align=center	sumtext=@sum	sumplustext=" 개"</C>'
					  +	'<C>id=MON_MONTH_SALE_AMT	name="금액"		width=70	align=RIGHT		sumtext=@sum	sumplustext=" 원"</C>'
					  + '</G>'
					  + '<G> 						name="일매출"'	
					  +	'<C>id=SALE_DT				name="매출일"		width=80	align=center	mask="XXXX/XX/XX"</C>'
					  +	'<C>id=ORDER_NO				name="주문번호"	width=65	align=center	</C>'
					  +	'<C>id=PRODUCT_CD			name="상품코드"	width=100	align=center	</C>'
					  +	'<C>id=PRODUCT_NM			name="상품명"		width=300	align=center	</C>'
					  +	'<C>id=DAY_SALE_QTY			name="수량"		width=50	align=center	sumtext=@sum	sumplustext=" 개"</C>'
					  +	'<C>id=DAY_SALE_AMT			name="금액"		width=70	align=RIGHT		sumtext=@sum	sumplustext=" 원"</C>'
					  + '</G>';
					  
   initGridStyle(GD_DETAIL,	"common", hdrProperies1, false);
   GD_DETAIL.ViewSummary = "1";
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
	if (DS_O_DETAIL.IsUpdated) {
		if (showMessage(Question, YesNo, "USER-1059") != "1") {	//아니요 
		 //	  DS_O_DETAIL.RowPosition =	gv_preRownoDetail;
			return;
		}	   
	} 
	
	if (EM_S_DT.Text > EM_E_DT.Text){ 
		showMessage(INFORMATION, OK, "USER-1008", "일매출 종료기간", "일매출 시작기간");
		EM_E_DT.Focus();
		return;
	}
	
	DS_O_MASTER.ClearData();
	DS_O_DETAIL.ClearData(); 

	var	strStrCd		= LC_S_STR_CD.BindColVal;		//점
	var strCondSaleYm	= EM_COND_SALE_YM.text;			//정산월
	var	strSdt			= EM_S_DT.Text;					//시작기간
	var	strEdt			= EM_E_DT.Text;					//종료기간	  
	var	strOrder		= EM_ORDERER_CD.Text;			//제휴몰코드
	var strPumbunCd		= EM_PUMBUN_CD.Text;			//브랜드코드
	var strMappingYn	= LC_S_MAPPING_YN.BindColVal; 	// 확정여부
	   
	var	goTo = "getMaster";
	var	action = "O";
	var	parameters = "&strStrCd="		+ encodeURIComponent(strStrCd) 
				   + "&strCondSaleYm="	+ encodeURIComponent(strCondSaleYm)	
				   + "&strSdt="			+ encodeURIComponent(strSdt)	
				   + "&strEdt="			+ encodeURIComponent(strEdt)
				   + "&strOrder="		+ encodeURIComponent(strOrder)
				   + "&strPumbunCd="	+ encodeURIComponent(strPumbunCd)
				   + "&strMappingYn="	+ encodeURIComponent(strMappingYn);
	TR_MAIN.Action = "/dps/psal529.ps?goTo=" + goTo	+ parameters;
	TR_MAIN.KeyValue = "SERVLET(" +	action + ":DS_O_MASTER=DS_O_MASTER)";
	TR_MAIN.Post();

	// 조회결과	Return
	setPorcCount("SELECT", GD_MASTER); 
	getDetail();
}

function btn_New(){
}
function btn_Delete(){
}
function btn_Save(){
}
function btn_Excel(){
}
function btn_Print(){
}
function btn_Conf(){
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
 /**
  *	getDetail()
  *	작 성 자 : 홍종영
  *	작 성 일 : 2012-07-03
  *	개	  요 : DETAIL조회
  *	return값 : void
  */
function getDetail() {	 
	if (DS_O_DETAIL.IsUpdated) {
		if (showMessage(Question, YesNo, "USER-1059") != "1") { //아니요 
			return;
		}		
	}	 

	var	strStrCd		= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");			//점
	var strCondSaleYm	= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"COND_SALE_YM");	//정산월
	var	strSdt			= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"COND_SALE_S_DT");	//시작기간
	var	strEdt			= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"COND_SALE_E_DT");	//종료기간	  
	var	strOrder		= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"ORDERER_CD");		//제휴몰코드
	var strPumbunCd		= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"PUMBUN_CD");		//브랜드코드
	var strMappingYn	= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"MAPPING_YN");		// 확정여부
	   
	var	goTo = "getDetail";
	var	action = "O";
	var	parameters = "&strStrCd="		+ encodeURIComponent(strStrCd)
				   + "&strCondSaleYm="	+ encodeURIComponent(strCondSaleYm)	
				   + "&strSdt="			+ encodeURIComponent(strSdt)	
				   + "&strEdt="			+ encodeURIComponent(strEdt)
				   + "&strOrder="		+ encodeURIComponent(strOrder)
				   + "&strPumbunCd="	+ encodeURIComponent(strPumbunCd)
				   + "&strMappingYn="	+ encodeURIComponent(strMappingYn);
 
	TR_MAIN.Action= "/dps/psal529.ps?goTo="+goTo+parameters;	
	TR_MAIN.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
	TR_MAIN.Post();
	
	setPorcCount("SELECT", GD_DETAIL);
}


 /**
 * setCommonPop()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 필수 공통코드/명을 등록한다.
 * return값 : void
 */
function setIndiCommonPop(title, comId, evnflag, codeObj, nameObj, svcFlg){
  //setIndiCommonPop('제휴몰', 'P613', 'POP', EM_ORDERER_CD, EM_ORDERER_NAME,'I');"
    if(codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;
    }

    var comSqlId = svcFlg == 'S' ? 'SEL_COMM_CODE_USE_NONE_ONLY' : 'SEL_COMM_CODE_ONLY';
    
    if( evnflag == "POP" ){
    	var Map =commonPop(title, comSqlId,codeObj ,nameObj,'D',comId);
    	return Map;
    }
    return Map;
}
 
 
/**
 *	searchPumbunPop()
 *	작 성	자 :	홍종영
 *	작 성	일 :	2010-03-18
 *	개	 요 :  조회조건 브랜드팝업
 *	return값	: void
 */
 function searchPumbunPop(){
	  var tmpOrgCd		  =	LC_S_STR_CD.BindColVal;
	  var strUsrCd		  =	'<c:out	value="${sessionScope.sessionInfo.USER_ID}"	/>';	// 세션 사원번호
	  var strStrCd		  =	LC_S_STR_CD.BindColVal;										// 점
	  var strOrgCd		  =	tmpOrgCd + "00000000";										// 조직코드
	  var strVenCd		  =	"";															// 협력사
	  var strBuyerCd	  =	"";															// 바이어
	  var strPumbunType	  =	"";															// 브랜드유형
	  var strUseYn		  =	"Y";														// 사용여부
	  var strSkuFlag	  =	"2";														// 단품구분
	  var strSkuType	  =	"";															// 단품종류(1:규격단품)
	  var strItgOrdFlag	  =	"";															// 통합발주여부
	  var strBizType	  =	"";															// 거래형태(2:특정)	
	  var strSaleBuyFlag  =	"";															// 판매분매입구분

	  var rtnMap = strPbnPop( EM_PUMBUN_CD, EM_PUMBUN_NM, 'Y'
							 , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
							 , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
							 , strBizType,strSaleBuyFlag);
	  if(rtnMap	!= null){
		  return true;
	  }else{
		  return false;
	  }
 }
 
/* 
 function checkLenByte(objDateSet, row,	colid) {
	//byte체크
	var	intByte	= 0;
	var	strTemp	= objDateSet.NameValue(row,	colid);

	for	(k = 0;	k <	strTemp.length;	k++) {
		var	onechar	= strTemp.charAt(k);
		if (escape(onechar).length > 4)	{
			intByte	+= 2;
		} else {
			intByte++;
		}
	}
	return intByte;
} */
-->

</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝													 		*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스	이벤트 처리													*-->
<!--*	 1.	TR Success 메세지 처리												*-->
<!--*	 2.	TR Fail	메세지 처리												*-->
<!--*	 3.	DataSet	Success	메세지 처리										*-->
<!--*	 4.	DataSet	Fail 메세지 처리											*-->
<!--*	 5.	DataSet	이벤트 처리												*-->
<!--*************************************************************************-->
<!---------------------	1. TR Success 메세지 처리  ---------------------------->
<script	language=JavaScript	for=TR_MAIN	event=onSuccess>
	for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
	}
</script>
<!---------------------	2. TR Fail 메세지 처리	------------------------------->
<script	language=JavaScript	for=TR_MAIN	event=onFail>
	trFailed(TR_MAIN.ErrorMsg);
</script>
<!---------------------	3. DataSet Success 메세지 처리	----------------------->
<!---------------------	4. DataSet Fail	메세지 처리	 -------------------------->
<!---------------------	5. DataSet 이벤트 처리	------------------------------->
<script	language=JavaScript	for=GD_MASTER event=OnClick(row,colid)>
	//정렬
	if (row	== 0){
		sortColId(eval(this.DataID), row, colid);
	}else{
		getDetail();	
	}
</script>

<script	language=JavaScript	for=GD_DETAIL event=OnClick(row,colid)>
	//정렬
	if (row	== 0){
		sortColId(eval(this.DataID), row, colid);
	}
</script>
<script	language=JavaScript	for=DS_O_DETAIL	event=OnRowPosChanged(row)>
	if(clickSORT)return;
</script>

<script language="javascript" for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
	//전체 체크 & 전체 체크 해제
	if (bCheck == '1'){ 
	    for(var i=1; i<=DS_O_MASTER.CountRow; i++){
            DS_O_MASTER.NameValue(i, "SEL") = 'T';
	    }
	}else{  
	    for (var i=1; i<=DS_O_MASTER.CountRow; i++){
            DS_O_MASTER.NameValue(i, "SEL") = 'F';
	    }
	}
</script>
<!-- 


-------------------	6. 컴포넌트	이벤트 처리	 ----------------------------
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
<comment id="_NSID_">
<object	id="DS_S_STR_CD" classid=<%= Util.CLSID_DATASET	%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object	id="DS_S_MAPPING_YN" classid=<%= Util.CLSID_DATASET	%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<!-- ===============- Output용 -->
<comment id="_NSID_">
<object	id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET	%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object	id="DS_O_DETAIL" classid=<%= Util.CLSID_DATASET	%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값	가져오기  -->
<comment id="_NSID_">
<object	id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object	id=DS_I_CONDITION classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object	id="DS_O_RESULT" classid=<%= Util.CLSID_DATASET	%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object	id="DS_O_MBSH_NO" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>


<!---------------------	2. Transaction	--------------------------------------->
<comment id="_NSID_">
<object	id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object></comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스	DataSet	& Transaction 정의 끝									*-->
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_DETAIL");
    
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
<!--* E. 본문시작																*-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@	include	file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 //	-->

<DIV id="testdiv" class="testdiv">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="PT01	PB03">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
					<tr>
						<td>
							<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
								<tr>
									<th width="40" class="point">점</th>
									<td width="170"><comment id="_NSID_"> <object
											id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="165"
											tabindex=1 align="absmiddle"> </object> </comment>
										<script>_ws_(_NSID_);</script></td>
									<th width="40" class="point">정산월</th>
									<td width="170"><comment id="_NSID_"> <object
											id=EM_COND_SALE_YM classid=<%=Util.CLSID_EMEDIT%> width=140
											tabindex=1 onblur="javascript:checkDateTypeYM(this);"
											align="absmiddle"></object> </comment>
										<script>_ws_(_NSID_);</script> <img
										src="/<%=dir%>/imgs/btn/date.gif"
										onclick="javascript:openCal('M',EM_COND_SALE_YM)"
										align="absmiddle" /></td>
									<th width="60" class="point">일매출기간</th>
									<td width="260"><comment id="_NSID_"> <object
											id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%> width=100
											tabindex=1 onblur="javascript:checkDateTypeYMD(this);"
											align="absmiddle"></object> </comment>
										<script>_ws_(_NSID_);</script> <img
										src="/<%=dir%>/imgs/btn/date.gif"
										onclick="javascript:openCal('G',EM_S_DT)" align="absmiddle" />
										~ <comment id="_NSID_"> <object id=EM_E_DT
											classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
											align="absmiddle"
											onblur="javascript:checkDateTypeYMD(this);"></object> </comment>
										<script>_ws_(_NSID_);</script> <img
										src="/<%=dir%>/imgs/btn/date.gif"
										onclick="javascript:openCal('G',EM_E_DT)" align="absmiddle" />
									</td>
								</tr>
								<tr>
									<th>제휴몰</th>
									<td><comment id="_NSID_"> <object
											id=EM_ORDERER_CD classid=<%=Util.CLSID_EMEDIT%> width="60"
											tabindex=1 align="absmiddle"></object> </comment>
										<script> _ws_(_NSID_);</script> <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_ORIGIN_AREA_CD	onclick="javascript:setIndiCommonPop('제휴몰', 'P613', 'POP', EM_ORDERER_CD, EM_ORDERER_NAME,'I');"	 align="absmiddle" />
										<comment id="_NSID_"> <object id=EM_ORDERER_NAME
											classid=<%=Util.CLSID_EMEDIT%> width="80" tabindex=1
											align="absmiddle"></object> </comment>
										<script> _ws_(_NSID_);</script></td>
									<th>브랜드</th>
									<td><comment id="_NSID_"> <object
											id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width="60"
											align="absmiddle"></object> </comment>
										<script> _ws_(_NSID_);</script> <img
										src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
										align="absmiddle"
										onclick="javascript:searchPumbunPop(); EM_PUMBUN_CD.focus();" />
										<comment id="_NSID_"> <object id=EM_PUMBUN_NM
											classid=<%=Util.CLSID_EMEDIT%> width="80" align="absmiddle"></object>
										</comment>
										<script> _ws_(_NSID_);</script></td>
									<th width="40" class="point">확정여부</th>
									<td width="170"><comment id="_NSID_"> <object
											id=LC_S_MAPPING_YN classid=<%=Util.CLSID_LUXECOMBO%> width="165"
											tabindex=1 align="absmiddle"> </object> </comment>
										<script>_ws_(_NSID_);</script></td>
								</tr>
							</table></td>
					</tr>
				</table></td>
		</tr>
		<!--  그리드의 구분dot & 여백  -->
		<tr height=2>
			<td></td>
		</tr>
		<tr>
			<td class="dot"></td>
		</tr>
		<!--  그리드의 구분dot & 여백  -->
		<tr>
			<td class="PT5" colspan=2>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="sub_title"><img
							src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
							align="absmiddle" class="PR03" />확정여부 표시</td>
					</tr>
				</table></td>
		</tr>
		<tr>
			<td class="PT01	PB03">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_">
							<OBJECT id=GD_MASTER width=100% height=200
								classid=<%=Util.CLSID_GRID%>>
								<param name="DataID" value="DS_O_MASTER">
							</OBJECT></comment>
							<script>_ws_(_NSID_);</script>
						</td>
					</tr>
				</table></td>
		</tr>
		<!--  그리드의 구분dot & 여백  -->
		<tr height=2>
			<td class="dot"></td>
		</tr>
		<!--  그리드의 구분dot & 여백  -->
		<td class="PT01	PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				class="BD4A">
				<tr>
					<td><comment id="_NSID_">
						<OBJECT id=GD_DETAIL width=100% height=230
							classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_O_DETAIL">
						</OBJECT></comment>
						<script>_ws_(_NSID_);</script>
					</td>
				</tr>
			</table></td>
		</tr>
	</table>
</DIV>

</body>
</html>

