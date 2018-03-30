<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 마스터 관리> 발행입고확정
 * 작 성 일 : 2011.04.20
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif1140.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.04.20 (김성미) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
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
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"><!--
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
var CUR_GR;
var EXCEL_PARAMS = "";
var top = 490;		//해당화면의 동적그리드top위치
var g_strPid           = "<%=pageName%>";                 // PID
function doInit(){
	
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_DT, "SYYYYMMDD", PK);                 //기간 : 시작
    initEmEdit(EM_E_DT, "TODAY", PK);                 //기간 : 종료
  
	//콤보 초기화
	initComboStyle(LC_S_STR,DS_O_MAIN_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점구분
	initComboStyle(LC_GIFT_TYPE_FLAG,DS_O_S_COMBO, "CODE^0^40,NAME^0^90", 1, NORMAL);      //상품권종류 구분
	
    getStore("DS_O_MAIN_STR_CD", "N", "", "N");
    DS_O_MAIN_STR_CD.Filter();     //점구분 : 본사점만 셋팅
    getGiftCommCode();
    insComboData( LC_GIFT_TYPE_FLAG, "%", "전체",1);
    LC_GIFT_TYPE_FLAG.Index = 0;
    LC_S_STR.Index = 0;
    LC_S_STR.focus();
    
    CUR_GR = GD_MASTER;
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"         width=30   align=center</FC>'
                     + '<FC>id=STR_NM    name="점"    sumtext="합계"     width=90   align=left</FC>'
                     + '<FC>id=REQ_DT      name="발행신청일자"  width=100 mask="XXXX/XX/XX"  align=center</FC>'
                     + '<FC>id=REQ_SLIP_NO name="발행신청번호"  width=100  align=center</FC>'
                     + '<FC>id=REQ_QTY    name="수량"   sumtext=@sum       width=110   align=right</FC>'
                     + '<FC>id=REQ_AMT name="발행금액"  sumtext=@sum    width=120   align=right</FC>'
                     + '<FC>id=IN_QTY name="입고수량"  sumtext=@sum    width=110   align=right</FC>'
                     + '<FC>id=IN_AMT name="입고금액"  sumtext=@sum    width=120   align=right</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    
    var hdrProperies1 = '<FC>id={currow}            name="NO"    width=30   align=center</FC>'
                      + '<FC>id=STR_NAME       name="점"  width=60   align=left</FC>'
			          + '<FC>id=IN_DT             name="입고일자"  mask="XXXX/XX/XX"  sumtext="합계"  width=80  align=center</FC>'  
			          + '<FC>id=IN_SLIP_NO           name="입고전표번호" width=80 SUBSUMTEXT="전표소계" align=center</FC>'  
			          + '<FC>id=GIFT_TYPE_NAME           name="상품권종류" width=100  align=left</FC>'  
			          + '<FC>id=GIFT_AMT_NAME             name="금종" width=80  align=left</FC>'  
			          + '<FC>id=IN_QTY          name="수량"  sumtext=@sum width=50  align=right</FC>'  
			          + '<FC>id=GIFT_S_NO        name="시작번호"  width=140  align=center</FC>'  
			          + '<FC>id=GIFT_E_NO        name="종료번호"  width=140  align=center</FC>'  
			          + '<FC>id=TOT_AMT              name="발행입고금액" sumtext=@sum width=80  align=right</FC>';  
		        
        initGridStyle(GD_DETAIL, "common", hdrProperies1, false);
        DS_IO_DETAIL.SubSumExpr  = "1:IN_SLIP_NO" ;
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
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-18
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	// 조회조건 셋팅
    var strStrCd        = LC_S_STR.BindColVal;  //점코드
    var strSdt          = EM_S_DT.Text;         //신청기간 from
    var strEdt          = EM_E_DT.Text;         //신청기간 to
    var strGiftTypeCd   = LC_GIFT_TYPE_FLAG.BindColVal;  //상품권종류코드
   
    if(strSdt > strEdt) {
        showMessage(EXCLAMATION , OK, "USER-1015");
        EM_S_DT.Focus();
        return;
    }
    if(strStrCd == "") {
        showMessage(EXCLAMATION , OK, "USER-1002", "점");
        LC_S_STR.Focus();
        return;
    }
    
    //데이타 셋 클리어
    DS_IO_MASTER.ClearData();
    DS_IO_DETAIL.ClearData();
  
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
                   + "&strSdt="       + encodeURIComponent(strSdt)
                   + "&strEdt="       + encodeURIComponent(strEdt)
                   + "&strGiftTypeCd="+ encodeURIComponent(strGiftTypeCd);
    TR_MAIN.Action="/mss/mgif114.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
    
    EXCEL_PARAMS  = "시작일자=" + strSdt;
    EXCEL_PARAMS += "-종료일자=" + strEdt;
    EXCEL_PARAMS += "-상품권종류구분=" + strGiftTypeCd;
    
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
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-18
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : kj
 * 작 성 일 : 2010-04-01
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	var ExcelTitle = "발행입고내역조회(점)"
	//openExcel2(CUR_GR, ExcelTitle, EXCEL_PARAMS, true );
	openExcel5(CUR_GR, ExcelTitle, EXCEL_PARAMS, true , "",g_strPid );
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getGiftCommCode()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-03-28
  * 개    요 : 상품권공통코드 조회  :s_flag => 조회용 상품권종류 구분, flag => 상품권종류 구분, payrec => 수수료 구분, issue => 발행형태
  * return값 : void
  */

 function getGiftCommCode() {
     TR_MAIN.Action="/mss/mgif114.mg?goTo=getCombo";  
     TR_MAIN.KeyValue="SERVLET(O:DS_O_S_COMBO=DS_O_S_COMBO)"; 
     TR_MAIN.Post();
 }
 /**
  * getDetail()
  * 작 성 자 : 
  * 작 성 일 : 2011-04-18
  * 개    요 : 하단 상세 조회
  * return값 : void
  */
 function getDetail () {
    var row = DS_IO_MASTER.RowPosition;
	var strReqDt = DS_IO_MASTER.NameValue(row, "REQ_DT");
    var strStrCd = DS_IO_MASTER.NameValue(row, "STR_CD");
    var strReqSlipNo = DS_IO_MASTER.NameValue(row, "REQ_SLIP_NO");
    var strGiftTypeCd   = LC_GIFT_TYPE_FLAG.BindColVal;  //상품권종류코드
    
    var goTo       = "getDetail" ;    
    var action     = "O";     
    var parameters = "&strReqDt="      + encodeURIComponent(strReqDt)
                    + "&strStrCd="     + encodeURIComponent(strStrCd)
                    + "&strReqSlipNo=" + encodeURIComponent(strReqSlipNo)
                    + "&strGiftTypeCd="+ encodeURIComponent(strGiftTypeCd);
    
    TR_DETAIL.Action="/mss/mgif114.mg?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
 }

--></script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
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
<script language=JavaScript for=DS_O_MAIN_STR_CD event=OnFilter(row)>
if (DS_O_MAIN_STR_CD.NameValue(row, "GBN") == "0") {// 본사점
    return false;
}
return true;
</script>
<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
if(DS_IO_DETAIL.IsUpdated){
    if (showMessage(QUESTION , YESNO, "USER-1074") != 1) return false;
        return true;
}
return true;
</script>
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
if (DS_IO_MASTER.CountRow > 0) {
    //디테일 조회
    getDetail();
 // 조회결과 Return
    setPorcCount("SELECT", GD_DETAIL);
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
CUR_GR = this;
if(row == 0) sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
CUR_GR = this;
if(row == 0) sortColId( eval(this.DataID), row , colid );
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_">
<object id="DS_O_MAIN_STR_CD" classid=<%=Util.CLSID_DATASET%>>
	<param name=UseFilter value=true>
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_COMBO"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

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
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">
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
						<th width="80" class="point">점</th>
						<td width="110"><comment id="_NSID_"> <object
							id=LC_S_STR classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=140 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80" class="point">신청기간</th>
						<td width="210"><comment id="_NSID_"> <object id=EM_S_DT
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 onblur="javascript:checkDateTypeYMD(this);"
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',EM_S_DT)" align="absmiddle" /> ~
						&nbsp; <comment id="_NSID_"> <object id=EM_E_DT
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 onblur="javascript:checkDateTypeYMD(this);"
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',EM_E_DT)" align="absmiddle" /></td>
						<th width="90">상품권종류구분</th>
                        <td>
		                <comment id="_NSID_">
		                   <object id=LC_GIFT_TYPE_FLAG classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=160 align="absmiddle" tabindex=1 >
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
	<tr height=15 valign="bottom">
		<td class="dot"></td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><OBJECT id=GD_MASTER
					width=100% height=390 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_IO_MASTER">
					<Param Name="ViewSummary"   value="1" >
				</OBJECT></comment><script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<!--  그리드의 구분dot 여백  -->
	<tr>
		<td class="dot"></td>
	</tr>
	<!-- 그리드의 구분dot 여백  -->
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><OBJECT id=GD_DETAIL
					width=100% height=390 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_IO_DETAIL">
					<Param Name="ViewSummary"   value="1" >
				</OBJECT></comment><script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</DIV>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

