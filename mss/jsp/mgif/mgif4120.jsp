<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상품권관리 > 상품권 재고관리 > 상품권마스터 현황 조회(특판)
 * 작 성 일 : 2011.03.18
 * 작 성 자 : 신익수
 * 수 정 자 : 
 * 파 일 명 : mgif4120.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 자사상품권 회수 내역을 조회 합니다.
 * 이    력 : 2011.03.14 (신익수) 신규개발
 *         
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var old_Row = 0;

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    // Output Data Set Header 초기화
    
    getGiftCd("getGiftAmt", "DS_O_GIFTAMT"); //금종조회
    getGiftCd("getGiftTpm", "DS_O_GIFTTPM"); //상품권종류 조회
    
    //그리드 초기화
    gridCreate(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_DRAWL_YMD_FROM, "SYYYYMMDD", PK);   //회수일자 from
    initEmEdit(EM_S_DRAWL_YMD_TO, "TODAY", PK);         //회수일자 to
    
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점
    getStore("DS_O_STR_CD", "Y", "", "N");
    getEtcCode("DS_DRAWL_FLAG",    "D", "M076", "N"); //회수구분
    LC_STR_CD.index = 0;
    LC_STR_CD.Focus();
}

function gridCreate(){
	 var hdrProperies = '<FC>id={currow}     		name="NO"          width=25   align=center</FC>'
				         + '<FC>id=STAT_FLAG 		name="상태구분"        width=50   align=center show=false </FC>'
				         + '<FC>id=GIFT_AMT_NAME 	name="금종"     width=100   align=center</FC>'
				         + '<FC>id=GIFTCERT_AMT     name="상품권금액"     width=100   align=center </FC>'
				         + '<FC>id=STAT_FLAG_NM     name="현재상태"     width=100   align=center</FC>'
				         + '<FC>id=QTY 		        name="현재수량"     width=80   align=light sumtext=@sum </FC>'
				         + '<FC>id=AMT 		        name="현재금액"     width=100   align=light sumtext=@sum </FC>'
				         + '<FC>id=SUM_QTY 		    name="누적수량"     width=80   align=light  </FC>'
				         + '<FC>id=SUM_AMT 		    name="누적금액"     width=100   align=light  </FC>'
				         ;
	initGridStyle(GD_MASTER, "common", hdrProperies, false);
	
	var hdrProperiesD = '<FC>id={currow}     		name="NO"          	width=25   align=center</FC>'
				        + '<FC>id=STAT_FLAG 		name="상태구분"        width=50   align=center show=false </FC>'
				        + '<FC>id=GIFT_AMT_NAME 	name="금종"     width=100   align=center</FC>'
				        + '<FC>id=GIFTCERT_AMT     name="상품권금액"     width=100   align=center </FC>'
				        + '<FC>id=STAT_FLAG_NM     name="현재상태"     width=100   align=center</FC>'
				        + '<FC>id=POUT_FLAG_NM     name="불출유형"     width=100   align=center</FC>'
				        + '<FC>id=POUT_TYPE_NM     name="불출구분"     width=100   align=center</FC>'
				        + '<FC>id=SALE_FLAG_NM     name="판매유형"     width=100   align=center</FC>'
				        + '<FC>id=DRAWL_FLAG_NM     name="회수유형"     width=100   align=center</FC>'
				        + '<FC>id=DRAWL_STR         name="회수점"     width=50   align=center</FC>'
				        + '<FC>id=QTY 		        name="현재수량"     width=80   align=light sumtext=@sum </FC>'
				        + '<FC>id=AMT 		        name="현재금액"     width=100   align=light sumtext=@sum </FC>'
				        ;
	initGridStyle(GD_DETAIL, "common", hdrProperiesD, false);
	GD_DETAIL.ViewSummary = "1"; 
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
	if(LC_STR_CD.BindColVal.length == 0){ 
        showMessage(INFORMATION, OK, "USER-1001", "점");
        LC_STR_CD.focus();
        return;
     }
    
     // 조회조건 셋팅
     var strStrCd           = LC_STR_CD.BindColVal;     //점코드
     var strDrawlYmdFrom    = EM_S_DRAWL_YMD_FROM.Text; //회수일자 FROM
     var strDrawlYmdTo      = EM_S_DRAWL_YMD_TO.Text;   //회수일자 TO
     
     if(strDrawlYmdFrom > strDrawlYmdTo) {
         showMessage(INFORMATION, OK, "USER-1015");
         EM_S_DRAWL_YMD_FROM.Focus();
         return;
     }
     
     //데이타 셋 클리어
     DS_O_MASTER.ClearData();
     DS_O_DETAIL.ClearData();
     
     var goTo       = "getGiftDrawlMst" ;    
     var parameters = "&strStrCd="       + encodeURIComponent(strStrCd)
                    + "&strDrawlYmdFrom="+ encodeURIComponent(strDrawlYmdFrom)
                    + "&strDrawlYmdTo="  + encodeURIComponent(strDrawlYmdTo);
     
     TR_MAIN.Action="/mss/mgif412.mg?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET(O:DS_O_MASTER=DS_O_MASTER)"; //조회는 O
     TR_MAIN.Post();
     
     old_Row = 1;
     
     // 조회결과 Return
     setPorcCount("SELECT", GD_MASTER);
     
     getDrawlDtl(strStrCd,strDrawlYmdFrom,strDrawlYmdTo);
}
/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.21
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    /*
	 var parameters = "회수점="+LC_STR_CD.BindColVal
    	+ "회수시작일자="+EM_S_REQ_YMD_FROM.Text
		+ "회수종료일자="+EM_S_REQ_YMD_TO.Text;
    	*/
    var parameters = "";
	var ExcelTitle = "상품권마스터현황조회"
	
	openExcel2(GD_DETAIL, ExcelTitle, parameters, true );
		
	GD_DETAIL.Focus();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
function getDrawlDtl(strDrawStr,strDrawlYmdFrom,strDrawlYmdTo){
   
    var goTo       = "getGiftDrawlDtl" ;    
    var parameters = "&strDrawStr="      + encodeURIComponent(strDrawStr)
				    + "&strDrawlYmdFrom="+ encodeURIComponent(strDrawlYmdFrom)
				    + "&strDrawlYmdTo="  + encodeURIComponent(strDrawlYmdTo);
    
    TR_MAIN1.Action="/mss/mgif412.mg?goTo="+goTo+parameters;  
    TR_MAIN1.KeyValue="SERVLET(O:DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_MAIN1.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", GD_DETAIL);
}

/**
 * getGiftCd()
 * 작 성 자 : 
 * 작 성 일 : 2011.08.05
 * 개    요 : 상품권종류/금종 가져오기
 * return값 : void
 */
function getGiftCd(strTarget, strDateSet){
    var strParam = strTarget;
    //상품권관리 > 상품권 판매/회수> 가맹점 제휴상품권 회수관리의 함수를 이용
    TR_MAIN.Action="/mss/mgif312.mg?goTo="+strParam;  
    TR_MAIN.KeyValue="SERVLET(O:DS_O_CODE="+ strDateSet +")";
    TR_MAIN.Post();
}
-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝 
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 
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
<script language=JavaScript for=TR_MAIN1 event=onSuccess>
    for(i=0;i<TR_MAIN1.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN1 event=onFail>
    trFailed(TR_MAIN1.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝
<!--*************************************************************************-->

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1)  sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1)  sortColId( eval(this.DataID), row , colid );
</script>


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_O_STR_CD"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DETAIL"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DRAWL_FLAG"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFTTPM"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFTAMT"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN1" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* E. 본문시작
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr style="display:none">
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80"  class="POINT">점</th>
						<td width="150"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100
							width=150 align="absmiddle"></object> </comment> <script>_ws_(_NSID_);</script>
						</td>
						<th style="display:none" width="80" class="POINT">기간</th>
						<td style="display:none"><comment id="_NSID_"> <object
							id=EM_S_DRAWL_YMD_FROM classid=<%=Util.CLSID_EMEDIT%> width="70"
							onblur="javascript:checkDateTypeYMD(this);" align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DRAWL_YMD_FROM)" /> ~ <comment
							id="_NSID_"> <object id=EM_S_DRAWL_YMD_TO
							classid=<%=Util.CLSID_EMEDIT%>
							onblur="javascript:checkDateTypeYMD(this);" width="70"
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',EM_S_DRAWL_YMD_TO)"
							align="absmiddle" /></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->
	<tr>
		<td class="dot"></td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->

	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><OBJECT id=GD_MASTER
					width=100% height=250 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_O_MASTER">
					<Param Name="ViewSummary" value="1">
				</OBJECT></comment><script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->
	<tr>
		<td class="dot"></td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->

	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><OBJECT id=GD_DETAIL
					width=100% height=268 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_O_DETAIL">
				</OBJECT></comment><script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>

