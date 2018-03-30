<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상품권관리 > 상품권판매/회수 > 상품권 판매 리스트
 * 작 성 일 : 2011.03.14
 * 작 성 자 : 신익수
 * 수 정 자 : 
 * 파 일 명 : mgif3160.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 상품권 판매 내역을 조회 한다.
 * 이    력 : 2011.03.14 (신익수) 신규개발
 *         
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정 
<!--*************************************************************************-->
<loginChk:islogin />
<%
    String dir = BaseProperty.get("context.common.dir");

	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

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
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
 //디테일 두번 조회 막기 위해
 var old_Row = 0;
 var old_Row1 = 0;
 
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var strUserID = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.21
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 400;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_DETAIL_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	
	  // Input Data Set Header 초기화
    DS_SEL_GIFT_SALE_MST.setDataHeader('<gauce:dataset name="H_GIFT_SALE_MST"/>');
    DS_SEL_GIFT_SALE_DETAIL.setDataHeader('<gauce:dataset name="H_GIFT_SALE_DETAIL"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_SALE_DT_FROM, "SYYYYMMDD", PK);         //판매기간 from
    initEmEdit(EM_S_SALE_DT_TO, "TODAY", PK);         //판매기간 to
   
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점
    initComboStyle(LC_SALE_FLAG,DS_O_SALE_FLAG, "CODE^0^30,NAME^0^150", 1, NORMAL);  //판매구분      
    
    //점코드 가져오기
    getStore("DS_O_STR_CD", "Y", "", "Y");
    getEtcCode("DS_O_SALE_FLAG","D", "M067", "Y","N",LC_SALE_FLAG);
    
    //점코드 셋팅
    LC_STR_CD.index = 0;
    
    LC_STR_CD.Focus();
  //종료시 데이터 변경 체크 (common.js )
  //registerUsingDataset("mcae101","DS_IO_MASTER" );
    
}

function gridCreate(){
    var hdrProperies = '<FC>id={currow}     name="NO"          width=25   align=center</FC>'
                     + '<FC>id=STR_CD       name="점코드"       width=30  show=false  </FC>'
                     + '<FC>id=STR_NM       name="점"          width=90  align=left </FC>'
                     + '<FC>id=SALE_DT      name="판매일자"     width=90   align=center  mask="XXXX/XX/XX" sumtext="합계"</FC>'
                     + '<FC>id=SALE_FLAG 	name="판매구분"        width=50   align=center show=false </FC>'
                     + '<FC>id=SALE_FLAG_NM     name="판매구분" width=100   align=center</FC>'
                     + '<FC>id=GIFT_AMT_NAME 	name="금종"     	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=100   align=center</FC>'
                     + '<FC>id=GIFTCERT_AMT     name="상품권금액"   gte_columntype="number:0:true" gte_Summarytype="number:0:true"	  width=100   align=center </FC>'
                     + '<FC>id=SALE_QTY 		name="판매수량"     gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=80   align=light sumtext=@sum </FC>'
                     + '<FC>id=SALE_AMT 		name="판매금액"     gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=100   align=light sumtext=@sum </FC>'
                     ;
    initGridStyle(GD_MASTER, "common", hdrProperies, false);

    var hdrProperies2 = '<FC>id={currow}     		name="NO"          width=25   align=center</FC>'
				    	 + '<FC>id=STR_CD       	name="점코드"       width=30  show=false  </FC>'
				         + '<FC>id=STR_NM       	name="점"          width=90  align=left show=false</FC>'
				         + '<FC>id=SALE_DT      	name="판매일자"     width=90   align=center  mask="XXXX/XX/XX" sumtext="합계"</FC>'
				         + '<FC>id=SALE_FLAG 		name="판매구분"        width=50   align=center show=false </FC>'
				         + '<FC>id=SALE_FLAG_NM     name="판매구분" width=100   align=center</FC>'
				         + '<FC>id=GIFT_AMT_NAME    name="금종"     	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	  width=80   align=center </FC>'
	                     + '<FC>id=GIFTCERT_AMT     name="상품권금액"   gte_columntype="number:0:true" gte_Summarytype="number:0:true"	  width=100   align=center </FC>'
				        + '<FC>id=GIFTCARD_NO       name="상품권번호"          width=130  align=center </FC>'
				        + '<FC>id=SALE_QTY      	name="판매수량"     gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=52   align=right   sumtext=@sum</FC>'
				        + '<FC>id=SALE_AMT     		name="판매금액"     gte_columntype="number:0:true" gte_Summarytype="number:0:true"	   width=80   align=right sumtext=@sum </FC>'
				        ;
   initGridStyle(GD_DETAIL_MASTER, "common", hdrProperies2, false);
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
 * 작 성 일 : 2011.02.21
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 if(LC_STR_CD.BindColVal.length == 0){ 
	     showMessage(INFORMATION, OK, "USER-1001", "점");
	     LC_STR_CD.focus();
	     return;
	  }
	  
	  if(LC_SALE_FLAG.BindColVal.length == 0){  
	     showMessage(INFORMATION, OK, "USER-1001", "판매구분");
	     LC_SALE_FLAG.focus();
	     return;
	  }
	  
	  // 조회조건 셋팅
	  var strStrCd        = LC_STR_CD.BindColVal;           //점코드
	  var strSaleDtFrom          = EM_S_SALE_DT_FROM.Text;  //판매일자 FROM
	  var strSaleDtTo          = EM_S_SALE_DT_TO.Text;      //판매일자 TO
	  var strSaleFlag          = LC_SALE_FLAG.BindColVal;   //판매구분
	  
	  if(strSaleDtFrom > strSaleDtTo) {
	         showMessage(INFORMATION, OK, "USER-1015");
	         EM_S_SALE_DT_FROM.Focus();
	         return;
	  }
	  
	  //데이타 셋 클리어
      DS_SEL_GIFT_SALE_MST.ClearData();
      DS_SEL_GIFT_SALE_DETAIL.ClearData();
	  
	  var goTo       = "getGiftSaleMst" ;    
	  var action     = "O";     
	  var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
	                 + "&strSaleDtFrom="+ encodeURIComponent(strSaleDtFrom)
	                 + "&strSaleDtTo="  + encodeURIComponent(strSaleDtTo)
	                 + "&strSaleFlag="  + encodeURIComponent(strSaleFlag);
	  
	  TR_MAIN.Action="/mss/mgif316.mg?goTo="+goTo+parameters;  
	  TR_MAIN.KeyValue="SERVLET("+action+":DS_SEL_GIFT_SALE_MST=DS_SEL_GIFT_SALE_MST)"; //조회는 O
	  TR_MAIN.Post();
	  
	  old_Row = 1;
	  
	  // 조회결과 Return
	  setPorcCount("SELECT", GD_MASTER);
	  
	  getGiftDtlAmtMst(strStrCd,strSaleDtFrom,strSaleDtTo,strSaleFlag);
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
     
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.21
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
   
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.21
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
   
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.21
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    var parameters = "판매점="+LC_STR_CD.BindColVal
        + "판매시작일자="+EM_S_SALE_DT_FROM.Text
		+ "판매종료일자="+EM_S_SALE_DT_TO.Text;

	var ExcelTitle = "상품권판매리스트"
	
	//openExcel2(GD_DETAIL_MASTER, ExcelTitle, parameters, true );
	
		var rtnVal = showMessage(STOPSIGN, CHOOSEUD, "USER-1000", "다운로드 할 그리드를 선택해 주세요.");
		
		if(rtnVal == "1"){
			openExcel5(GD_MASTER, ExcelTitle, parameters, true , "",g_strPid );
    	}else if(rtnVal == "2"){
    		openExcel5(GD_DETAIL_MASTER, ExcelTitle, parameters, true , "",g_strPid );
    	}else{
    		return;	 
    	}
		
		
	
	GD_DETAIL_MASTER.Focus();
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 .
 * 작 성 일 : 2011.02.21
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
	  if(LC_STR_CD.BindColVal.length == 0){ 
	     showMessage(INFORMATION, OK, "USER-1001", "점");
	     LC_STR_CD.focus();
	     return;
	  }
	  
	  if(LC_SALE_FLAG.BindColVal.length == 0){  
	     showMessage(INFORMATION, OK, "USER-1001", "판매구분");
	     LC_SALE_FLAG.focus();
	     return;
	  }
	  
	  // 조회조건 셋팅
	  var strStrCd        = LC_STR_CD.BindColVal;		//점코드
	  var strSaleDtFrom   = EM_S_SALE_DT_FROM.Text;		//판매일자 FROM
	  var strSaleDtTo     = EM_S_SALE_DT_TO.Text;		//판매일자 TO
	  var strSaleFlag     = LC_SALE_FLAG.BindColVal;	//판매구분
	  
	  if(strSaleDtFrom > strSaleDtTo) {
	         showMessage(INFORMATION, OK, "USER-1015");
	         EM_S_SALE_DT_FROM.Focus();
	         return;
	  }	 
	 
	  var parameters = "&strStrCd="  + LC_STR_CD.BindColVal 		//점코드
				     + "&strSaleDtFrom=" + EM_S_SALE_DT_FROM.Text   //조회일자
					 + "&strSaleDtTo=" + EM_S_SALE_DT_TO.Text      	//조회일자
					 + "&strSaleFlag=" + LC_SALE_FLAG.BindColVal	//판매구분
					 ;	
	  window.open("/mss/mgif316.mg?goTo=print"+parameters, "OZREPORT", 1000, 700);     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2011.02.21
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getGiftAmtMst()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-14
  * 개    요 : 금종 조회
  * return값 : void
  */
  /*
function getGiftAmtMst(strStrCd,strSaleDt,strSaleSlipNo) {
	  
	var goTo       = "getGiftAmtMst" ;    
    var action     = "O";     
    var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
                   + "&strSaleDt="    + encodeURIComponent(strSaleDt)
                   + "&strSaleSlipNo="+ encodeURIComponent(strSaleSlipNo);
    
    TR_MAIN2.Action="/mss/mgif316.mg?goTo="+goTo+parameters;  
    TR_MAIN2.KeyValue="SERVLET("+action+":DS_SEL_GIFT_AMT_MST=DS_SEL_GIFT_AMT_MST)"; //조회는 O
    TR_MAIN2.Post();
    
    old_Row1 = 1;
    
    // 조회결과 Return
    setPorcCount("SELECT",GD_DETAIL_MASTER);
}
*/

function getGiftDtlAmtMst(strStrCd,strSaleDtFrom,strSaleDtTo,strSaleFlag) {
	var goTo       = "getGiftDtlAmtMst" ;    
    var action     = "O";     
    var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
                   + "&strSaleDtFrom="+ encodeURIComponent(strSaleDtFrom)
                   + "&strSaleDtTo="  + encodeURIComponent(strSaleDtTo)
                   + "&strSaleFlag="  + encodeURIComponent(strSaleFlag);
    
    TR_MAIN3.Action="/mss/mgif316.mg?goTo="+goTo+parameters;  
    TR_MAIN3.KeyValue="SERVLET("+action+":DS_SEL_GIFT_SALE_DETAIL=DS_SEL_GIFT_SALE_DETAIL)"; //조회는 O
    TR_MAIN3.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", GD_DETAIL_MASTER);
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
<script language=JavaScript for=TR_MAIN2 event=onSuccess>
    for(i=0;i<TR_MAIN2.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN2.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_MAIN3 event=onSuccess>
    for(i=0;i<TR_MAIN3.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN3.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
  /*  showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN2 event=onFail>
  /*  showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN2.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN2.ErrorMsg);
    for(i=1;i<TR_MAIN2.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN2.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN2.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN3 event=onFail>
  /*  showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN3.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN3.ErrorMsg);
    for(i=1;i<TR_MAIN3.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN3.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN3.ErrorMsg);
</script>


<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_SEL_GIFT_SALE_MST event=OnRowPosChanged(row)>
if(row > 0 && old_Row != row ){
    //점코드
    var strStrCd = DS_SEL_GIFT_SALE_MST.NameValue(row, "STR_CD");
    var strSaleDt = DS_SEL_GIFT_SALE_MST.NameValue(row, "SALE_DT");
    var strSaleSlipNo = DS_SEL_GIFT_SALE_MST.NameValue(row, "SALE_SLIP_NO");
    
    //상품권 금종 정보 조회
    //getGiftAmtMst(strStrCd,strSaleDt,strSaleSlipNo);
}
old_Row = row;
</script>


<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝
<!--*************************************************************************-->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
   //그리드 정렬기능
   if( row < 1) {
       sortColId( eval(this.DataID), row , colid );
   }
</script><script language=JavaScript for=GD_AMT_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script><script language=JavaScript for=GD_DETAIL_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_SALE_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR_CD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEL_GIFT_SALE_MST"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEL_GIFT_SALE_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
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
<!--* D. 가우스 DataSet & Transaction 정의 끝
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_DETAIL_MASTER");
    
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
<!--* E. 본문시작
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="PT01 PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
            <tr>
                <td><!-- search start -->
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                    <tr>
                        <th width="80" >점</th>
                        <td width="150">
                          <comment id="_NSID_">
                            <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=150 align="absmiddle"></object>
		                  </comment>
		                  <script>_ws_(_NSID_);</script> 
                        </td>
                        <th width="80" class="POINT">기간</th>
                        <td width="230">
                           <comment id="_NSID_">
			                   <object id=EM_S_SALE_DT_FROM classid=<%=Util.CLSID_EMEDIT%> width="70" onblur="javascript:checkDateTypeYMD(this);" align="absmiddle"> 
			                   </object>
			                </comment><script>_ws_(_NSID_);</script>
			                <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_SALE_DT_FROM)" /> ~ 
			                <comment id="_NSID_">
			                   <object id=EM_S_SALE_DT_TO classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width="70" align="absmiddle">
			                   </object>
			                </comment><script>_ws_(_NSID_);</script>
			                <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_SALE_DT_TO)" align="absmiddle" />
                        </td>
                        <th width="80" >판매구분</th>
                        <td>
                            <comment id="_NSID_">
			                   <object id=LC_SALE_FLAG classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=150 align="absmiddle">
			                   </object>
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
        <td class="dot"></td>
    </tr>
    <tr valign="top">
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                    <tr>
                        <td width="100%">
                          <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=280 classid=<%=Util.CLSID_GRID%>>
				              <param name="DataID" value="DS_SEL_GIFT_SALE_MST">
				              <Param Name="ViewSummary"   value="1" >
				          </OBJECT></comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td height="4"></td>
    </tr>
    <tr>
        <td class="dot"></td>
    </tr>
    <tr>
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">

                <td class="PL05">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                    <tr>
                         <td width="100%">
                          <comment id="_NSID_"><OBJECT id=GD_DETAIL_MASTER width=100% height=300 classid=<%=Util.CLSID_GRID%>>
                                  <param name="DataID" value="DS_SEL_GIFT_SALE_DETAIL">
                                  <Param Name="ViewSummary"   value="1" >
                          </OBJECT></comment><script>_ws_(_NSID_);</script>
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
</body>
</html>
