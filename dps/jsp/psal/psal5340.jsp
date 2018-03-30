<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > POS정산 > 월별대행업체 지불대상액 조회
 * 작 성 일  : 2012.07.05
 * 작 성 자  : 홍종영
 * 수 정 자  : 
 * 파 일 명  : psal5340.jsp
 * 버    전   : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요   : 
 * 이    력   : 2012.07.05 홍종영
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                               							*-->
<!--*************************************************************************-->
<loginChk:islogin />
<% String dir = BaseProperty.get("context.common.dir"); %>

<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        								*-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');      
    
    //그리드 초기화
    gridCreate1(); //마스터
        
    // EMedit에 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);    
    initEmEdit(EM_I_ORDERER_CD, "CODE^30", NORMAL);								//제휴몰코드
    initEmEdit(EM_I_ORDERER_NAME, "GEN", READ);									//제휴몰명
    initEmEdit(EM_S_DT, "YYYYMM", PK);											//년월
	initEmEdit(EM_PUMBUN_CD, "000000", NORMAL);									//브랜드코드
	initEmEdit(EM_PUMBUN_NM, "GEN^40", READ);									//브랜드명
    
    //현재년도 셋팅
    EM_S_DT.text =  varToday;

    //콤보 초기화
    getStore("DS_STR_CD", "Y", "", "N");                                        // 점        

    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';         // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    
    GD_MASTER_CROSSTAB.focus();
    LC_STR_CD.Focus();
    
    EM_S_DT.alignment = 1;
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal534","DS_O_MASTER" );
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}                name="NO"           width=30    align=center    </FC>'
    	             + '<FC>id=ORDERER_NM              name="제휴몰"          width=80    align=right      </FC>'
                     + '<R>'
                     + '<G>                            name=$xkeyname_$$'
                     + '<C>id=DED_AMT_$$         name="금액"          width=100    align=right    mask="###,###"    </C>'
                     + '</G>'
                     + '</R>';
                     
    initGridStyle(GD_MASTER_CROSSTAB, "common", hdrProperies, false);    
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
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-16
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
    //마스터 그리드 클리어
    DS_O_MASTER.ClearData();
        
    var strStrCd          = LC_STR_CD.BindColVal;		//점
    var strSaleYm         = EM_S_DT.text;				//시작일자
    var strOriginAreaCd   = EM_I_ORDERER_CD.text;		//제휴몰코드
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strSaleYm="          +encodeURIComponent(strSaleYm)
                   + "&strOriginAreaCd="    +encodeURIComponent(strOriginAreaCd);
    
    TR_MAIN.Action="/dps/psal534.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //GD_MASTER.DoMethod("GetClickGridArea", "true");
    
    GD_MASTER_CROSSTAB.focus();
    // 조회결과 Return
    //setPorcCount("SELECT", DS_O_MASTER_CROSSTAB.CountRow);

    //스크롤바 위치 조정
    GD_MASTER_CROSSTAB.SETVSCROLLING(0);
    GD_MASTER_CROSSTAB.SETHSCROLLING(0);
}

/**
 * btn_New()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :   
 * return값 : 
 */
function btn_New() {
}
/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개    요 : 
 * return값 : 
 */
function btn_Delete() {
}
/**
 * btn_Save()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :  
 * return값 : void
 */
function btn_Save() {
}
/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Excel() {
}
/**
 * btn_Print()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Print() {
}
/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : void
 */
 function btn_Conf() { 
 }

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * setCommonPop()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 필수 공통코드/명을 등록한다.
 * return값 : void
 */
/* function setIndiCommonPop(title, comId, evnflag, codeObj, nameObj, svcFlg){
  //setIndiCommonPop('제휴몰', 'P613', 'POP', EM_I_ORDERER_CD, EM_I_ORDERER_NAME,'I')
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
} */

function setInitCommonPop(title, comId, evnflag, codeObj, nameObj, svcFlg){
    if(codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;
    }
    var comSqlId = svcFlg == 'S' ? 'SEL_COMM_CODE_USE_NONE_ONLY' : 'SEL_COMM_CODE_ONLY';
    if( evnflag == "POP" ){
        commonPop(title,comSqlId,codeObj ,nameObj,'D',comId);
        return;
    }
    
    setNmWithoutPop('DS_SEARCH_NM',title,comSqlId,codeObj ,nameObj,'D',comId);
    
    if( DS_SEARCH_NM.CountRow == 1){
        codeObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_CD");
        nameObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_NM");
        return;
    }
    commonPop(title,comSqlId,codeObj ,nameObj,'D',comId);
}



/**
 *	searchPumbunPop()
 *	작 성	자 :	홍종영
 *	작 성	일 :	2010-03-18
 *	개	 요 :  조회조건 브랜드팝업
 *	return값	: void
 */
 function searchPumbunPop(){
	  var tmpOrgCd		  =	LC_STR_CD.BindColVal;
	  var strUsrCd		  =	'<c:out	value="${sessionScope.sessionInfo.USER_ID}"	/>';	// 세션 사원번호
	  var strStrCd		  =	LC_STR_CD.BindColVal;										// 점
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

</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     								*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 								*-->
<!--*    1. TR Success 메세지 처리			                 					*-->
<!--*    2. TR Fail 메세지 처리                 										*-->
<!--*    3. DataSet Success 메세지 처리                 								*-->
<!--*    4. DataSet Fail 메세지 처리                 									*-->
<!--*    5. DataSet 이벤트 처리                 										*-->
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
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language="javascript">
    var today    = new Date();
    var old_Row = 0;
    var searchChk = "";

    // 오늘 일자 셋팅 
    var now = new Date();
    var mon = now.getMonth()+1;
    if(mon < 10)mon = "0" + mon;
    var day = now.getDate();
    if(day < 10)day = "0" + day;
    var varToday = now.getYear().toString()+ mon + day;
    var varToMon = now.getYear().toString()+ mon;
</script>

<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid); 
</script>

<!-- 제휴몰 팝업없이 바로 조회 -->
<script language=JavaScript for=EM_I_ORDERER_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    var result = null;
    result = setNmWithoutPop('DS_SEARCH_NM', 'FKL', 'SEL_COMM_CODE_ONLY', EM_I_ORDERER_CD, EM_I_ORDERER_NAME,'D','P613');
    
    if( result != null){
        EM_I_ORDERER_CD.Text = DS_SEARCH_NM.NameValue(1,"CODE_CD");
        EM_I_ORDERER_NAME.Text = DS_SEARCH_NM.NameValue(1,"CODE_NM");
    }else{
    	EM_I_ORDERER_CD.Text = "";
    	EM_I_ORDERER_NAME.Text = "";
    }
</script>

<!-- 브랜드 팝업없이 바로 조회 -->
<script language=JavaScript for=EM_PUMBUN_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    //코드가 존재 하지 않으면 명을 클리어 후 리턴
    if(EM_PUMBUN_CD.Text == ""){
    	EM_PUMBUN_NM.Text = "";
        return;
    }
    var result = null;
    EM_PUMBUN_NM.Text     = "";
    result = setStrPbnNmWithoutToGridPop("DS_SEARCH_NM",EM_PUMBUN_CD.Text,EM_PUMBUN_NM.Text,"Y",'1');

    if( result != null){
    	EM_PUMBUN_CD.Text = result.get("PUMBUN_CD");
        EM_PUMBUN_NM.Text = result.get("PUMBUN_NAME");
    }else{
    	EM_PUMBUN_CD.Text = "";
        EM_PUMBUN_NM.Text = "";
    } 
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               							*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                 					*-->
<!--*    1. DataSet                                 						*-->
<!--*    2. Transaction                                 					*-->
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<!-- 검색용 -->

<comment id="_NSID_"> 
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>></object> 
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_O_POSNOMM" classid=<%=Util.CLSID_DATASET%>></object> 
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_POS_FLOOR" classid=<%=Util.CLSID_DATASET%>></object> 
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_POS_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object> 
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object> 
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object> 
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_O_POSNOH"	classid=<%=Util.CLSID_DATASET%>></object> 
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_O_POSFLORH"	classid=<%=Util.CLSID_DATASET%>></object> 
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_O_POSFLORMM"	classid=<%=Util.CLSID_DATASET%>></object> 
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_O_POSFLOR"	classid=<%=Util.CLSID_DATASET%>></object> 
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_SEARCH_NM"	classid=<%= Util.CLSID_DATASET %>></object> 
</comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_SALE_DATE" classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_IO_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object> 
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
	<object id="DS_O_MASTER_CROSSTAB" classid=<%=Util.CLSID_DATASET%>>
		<param name=DataID value="DS_O_MASTER">
		<param name=Logical value="true">
		<param name=GroupExpr value="ORDERER_NM:,DED_NM,:DED_AMT">
	</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_O_DETAIL"	classid=<%=Util.CLSID_DATASET%>></object> 
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_O_POSNO"	classid=<%=Util.CLSID_DATASET%>></object> 
</comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_"> 
	<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
		<param name="KeyName" value="Toinb_dataid4">
	</object> 
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
	<object id="TR_DETAIL"	classid=<%=Util.CLSID_TRANSACTION%>>
		<param name="KeyName" value="Toinb_dataid4">
	</object> 
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_REASON_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_VAT_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                               					*-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* E. 본문시작                                                          								*-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

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
										<th width="70" class="point">점</th>
										<td width="160">
											<comment id="_NSID_"> 
												<object	id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=170	tabindex=1 align="absmiddle"></object> 
											</comment><script>_ws_(_NSID_);</script>
										</td>
										<th width="70" class="point">매출월</th>
										<td>
											<comment id="_NSID_"> 
												<object	id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%> width=75 tabindex=1 align="absmiddle"> </object> 
											</comment><script>_ws_(_NSID_);</script>
											
											<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',EM_S_DT)" align="absmiddle" />
									</tr>
									<tr>
										<th>브랜드</th>
										<td>
											<comment id="_NSID_">
												<object	id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width="60" align="absmiddle"></object> 
											</comment><script>_ws_(_NSID_);</script> 
											
											<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" align="absmiddle" onclick="javascript:searchPumbunPop(); EM_PUMBUN_CD.focus();" />
											
											<comment id="_NSID_"> 
												<object id=EM_PUMBUN_NM	classid=<%=Util.CLSID_EMEDIT%> width="80" align="absmiddle"></object>
											</comment><script>_ws_(_NSID_);</script>
										</td>
										<th>제휴몰</th>
										<td>
											<comment id="_NSID_"> 
												<object	id=EM_I_ORDERER_CD classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object> 
											</comment><script>_ws_(_NSID_);</script> 
											
											<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_ORIGIN_AREA_CD	
												 onclick="javascript:setInitCommonPop('제휴몰', 'P613', 'POP', EM_I_ORDERER_CD, EM_I_ORDERER_NAME,'I');" align="absmiddle" /> 
											
											<comment id="_NSID_"> 
												<object	id=EM_I_ORDERER_NAME classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object> 
											</comment><script>_ws_(_NSID_);</script></td>
									</tr>
								</table></td>
						</tr>
					</table></td>
			</tr>
			<tr>
				<td class="dot"></td>
			</tr>
			<tr valign="top">
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr valign="top">
							<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="BD4A">
									<tr>
										<td width="100%"><comment id="_NSID_"> <object
												id=GD_MASTER_CROSSTAB width=100% height=480
												classid=<%=Util.CLSID_GRID%> tabindex=1>
												<param name="DataID" value="DS_O_MASTER_CROSSTAB">
											</object> </comment>
											<script>_ws_(_NSID_);</script>
										</td>
									</tr>
								</table></td>
						</tr>
					</table></td>
			</tr>
		</table>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

	</div>
<body>
</html>
