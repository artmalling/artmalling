<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상품권관리 > 상품권 판매/회수 > 상품권판매 결재내역 조회
 * 작 성 일 : 2011.08.30
 * 작 성 자 : 김성미
 * 수 정 자 : 
 * 파 일 명 : mgif3230.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 자사상품권 회수 내역을 조회 합니다.
 * 이    력 : 2011.08.30 (김성미) 신규개발
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
 var top = 330;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate(); //마스터

    // EMedit에 초기화
    initEmEdit(EM_S_DATE, "SYYYYMMDD", PK);   //회수일자 from
    initEmEdit(EM_E_DATE, "TODAY", PK);         //회수일자 to
    
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점
    getStore("DS_O_STR_CD", "Y", "", "N");
    getEtcCode("DS_DRAWL_FLAG",    "D", "M076", "N"); //회수구분
    LC_STR_CD.index = 0;
    LC_STR_CD.Focus();
}

function gridCreate(){
	 var hdrProperies = ''
						+ '<FC>ID={CURROW}            NAME="NO"' 
						+ '                                             WIDTH=35        ALIGN=CENTER</FC>'
						+ '<FC>ID=SALE_DT            NAME="판매일자"'         
						+ '                                             WIDTH=135       ALIGN=CENTER SUMTEXT="합계"    MASK="XXXX/XX/XX"</FC>'
						+ '<G>                        NAME="정상판매"'
						+ '<FC>ID=SALE_AMT1               NAME="판매"'           
						+ '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=90        ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
						+ '<FC>ID=REFUND_AMT1               NAME="반품"'           
						+ '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
						+ '<G>                        NAME="특판판매"'
						+ '<FC>ID=SALE_AMT2               NAME="판매"'           
						+ '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=120       ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
						+ '<FC>ID=REFUND_AMT2               NAME="반품"'           
						+ '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
						+ '<G>                        NAME="포인트판매"'
						+ '<FC>ID=SALE_AMT3               NAME="판매"'           
						+ '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=120       ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
						+ '<FC>ID=REFUND_AMT3               NAME="반품"'           
						+ '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
						+ '<G>                        NAME="OCB상품권교환판매"'
						+ '<FC>ID=SALE_AMT5               NAME="판매"'           
						+ '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=120       ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
						+ '<FC>ID=REFUND_AMT5               NAME="반품"'           
						+ '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
						+ '<G>                        NAME= "계(교환제외)"'
                        + '<FC>ID=SALE_TOT               NAME="판매"'           
                        + '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=120       ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
                        + '<FC>ID=REFUND_TOT               NAME="반품"'           
                        + '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
                        + '<FC>ID=TOT            NAME="합계"'         
                        + '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=135       ALIGN=RIGHT SUMTEXT=@SUM</FC>'
						+ '<G>                        NAME="교환판매"'
						+ '<FC>ID=SALE_AMT4               NAME="판매"'           
						+ '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=120       ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
						+ '<FC>ID=REFUND_AMT4               NAME="반품"'           
						+ '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
						+ '<G>                        NAME= "계"'
						+ '<FC>ID=TOT_SALE_AMT               NAME="판매"'           
						+ '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=120       ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
						+ '<FC>ID=TOT_REFUND_AMT               NAME="반품"'           
						+ '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
						+ '<FC>ID=TOT_AMT            NAME="합계"'         
                        + '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=135       ALIGN=RIGHT SUMTEXT=@SUM</FC>'
						;
	initGridStyle(GD_MASTER, "common", hdrProperies, false);
	
	var hdrProperiesD = ''
						+ '<FC>ID={CURROW}            NAME="NO"' 
						+ '                                             WIDTH=35        ALIGN=CENTER</FC>'
						+ '<FC>ID=SALE_DT             NAME="판매일" '         
						+ '                                             WIDTH=80       ALIGN=CENTER SUMTEXT="합계"    MASK="XXXX/XX/XX"</FC>'
						+ '<FC>ID=CASH_AMT       NAME="현금"'         
						+ '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=90       ALIGN=RIGTH   SUMTEXT=@SUM</FC>'
						+ '<FC>ID=SPS_SALE_AMT         NAME="특판외상"'         
						+ '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=90       ALIGN=RIGTH SUMTEXT=@SUM</FC>'
						+ '<FC>ID=POINT_AMT           NAME="포인트"       sumtext=@sum '         
						+ '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=90       ALIGN=RIGTH SUMTEXT=@SUM</FC>'
					    + '<FC>ID=DCARD_AMT          NAME="직불카드"'         
                        + '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=145       ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
                        + '<FG>                        NAME="신용카드"'
                        + '<FC>ID=SHINHAN           NAME="신한"'           
                        + '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=90        ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
                        + '<FC>ID=KOOKMIN           NAME="국민"'           
                        + '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=90        ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
                        + '<FC>ID=BC           NAME="BC"'           
                        + '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=90        ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
                        + '<FC>ID=SAMSUNG           NAME="삼성"'           
                        + '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=90        ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
                        + '<FC>ID=EXCHAGE           NAME="외환"'           
                        + '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=90        ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
                        + '<FC>ID=HYUNDAI           NAME="현대"'           
                        + '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=90        ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
                        + '<FC>ID=LOTTE           NAME="롯데"'           
                        + '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=90        ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
                        + '<FC>ID=HANA           NAME="하나"'           
                        + '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=90        ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
                        + '<FC>ID=NONGHYUB           NAME="농협"'           
                        + '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=90        ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
                        + '<FC>ID=ETCCARD_AMT         NAME="기타"'           
                        + '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></FG>'
                        + '<FC>ID=TOT_AMT          NAME="계"'         
                        + '                            gte_columntype="number:0:true" gte_Summarytype="number:0:true"                 WIDTH=145       ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
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
     var strSDate       = EM_S_DATE.Text;           //조회시작일
     var strEDate       = EM_E_DATE.Text;           //조회종료일
     
     if(strSDate > strEDate) {
         showMessage(INFORMATION, OK, "USER-1015");
         EM_S_DATE.Focus();
         return;
     }
     
     //데이타 셋 클리어
     DS_O_MASTER.ClearData();
     DS_O_DETAIL.ClearData();
     
     var goTo       = "getMaster" ;    
     var parameters = "&strStrCd="+ encodeURIComponent(strStrCd)
                    + "&strSDate="+ encodeURIComponent(strSDate)
                    + "&strEDate="+ encodeURIComponent(strEDate);
     
     TR_MAIN.Action="/mss/mgif323.mg?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET(O:DS_O_MASTER=DS_O_MASTER)"; //조회는 O
     TR_MAIN.Post();
     
     old_Row = 1;
     
     getDetail();
     // 조회결과 Return
     setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.21
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	 
    if(DS_O_MASTER.CountRow <= 0){
        showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
          return;
      }

    var strStrCd           = LC_STR_CD.Text;     //점코드
    var strSDate       = EM_S_DATE.Text;           //조회시작일
    var strEDate       = EM_E_DATE.Text;           //조회종료일
    
    var parameters = " 점="+strStrCd
    	+ " , 기간="+strSDate
		+ " ~ "+strEDate;

	var ExcelTitle = "상품권판매결재내역조회"
	
	openExcel2(GD_MASTER, ExcelTitle, parameters, true );
	
	var ExcelTitle = "상품권판매결재내역조회"

	openExcel2(GD_DETAIL, ExcelTitle, parameters, true );
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
function getDetail(){
   
	// 조회조건 셋팅
    var strStrCd           = LC_STR_CD.BindColVal;     //점코드
    var strSDate       = EM_S_DATE.Text;           //조회시작일
    var strEDate       = EM_E_DATE.Text;           //조회종료일
    
    var goTo       = "getDetail" ;    
    var parameters = "&strStrCd=" + encodeURIComponent(strStrCd)
				    + "&strSDate="+ encodeURIComponent(strSDate)
				    + "&strEDate="+ encodeURIComponent(strEDate);
    
    TR_MAIN1.Action="/mss/mgif323.mg?goTo="+goTo+parameters;  
    TR_MAIN1.KeyValue="SERVLET(O:DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_MAIN1.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", GD_DETAIL);
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
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
if(row > 0 && old_Row != row ){
    var strStr = DS_O_MASTER.NameValue(row, "STR_CD");
}
old_Row = row;
</script>
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
<!--* E. 본문시작
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">
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
						<td width="150"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100
							width=150 align="absmiddle"></object> </comment> <script>_ws_(_NSID_);</script>
						</td>
						<th width="80" class="POINT">기간</th>
						<td><comment id="_NSID_"> <object
							id=EM_S_DATE classid=<%=Util.CLSID_EMEDIT%> width="70"
							onblur="javascript:checkDateTypeYMD(this);" align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DATE)" /> ~ <comment
							id="_NSID_"> <object id=EM_E_DATE
							classid=<%=Util.CLSID_EMEDIT%>
							onblur="javascript:checkDateTypeYMD(this);" width="70"
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',id=EM_E_DATE)"
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
					width=100% height=220 classid=<%=Util.CLSID_GRID%>>
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

