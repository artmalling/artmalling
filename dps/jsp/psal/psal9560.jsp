<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"          prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    request.setCharacterEncoding("utf-8");
    String dir = BaseProperty.get("context.common.dir");
  
    String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date()); 
    strToMonth = strToMonth + "01";
    
    String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
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
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
	type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var EXCEL_PARAMS = "";
var CUR_GR;
var parameters = "";
var bfListRowPosition = 0;                             // 이전 List Row Position
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-04-01
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 
 var top = 450;		//해당화면의 동적그리드top위치

function doInit(){
	 
	var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";


    CUR_GR = GD_MASTER;

    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2();
    
    // 검색 필드
    initEmEdit(EM_S_DT_S,       "YYYYMMDD", PK);            
    initEmEdit(EM_E_DT_S,       "TODAY", PK);            
    initEmEdit(EM_CNT_S1,        "NUMBER^3^0", PK);
    initEmEdit(EM_CNT_S2,        "NUMBER^3^0", PK);
    initEmEdit(EM_CNT_S3,        "NUMBER^3^0", PK);
    //initEmEdit(EM_ADD_POINT,    "NUMBER^9^0", NORMAL);        
    
    //조회일자 초기값.
    EM_S_DT_S.text  = addDate("M", "-1", '<%=strToMonth%>');
    //EM_CNT_S.text   = "10";
    //btn_Search();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}				name="NO"			width=30	align=center	</FC>'
    	             + '<FC>id=STR_CD     name="점코드"       width=120 SHOW=FALSE  </FC>'
    				 + '<FC>id=STR_NAME     name="점명"           width=120  suppress=1 </FC>'
                     + '<FC>id=PUMBUN_CD    name="브랜드코드"   width=80    align=left SumText="합계"</FC>'
                     + '<FC>id=PUMBUN_NAME  name="브랜드명"     width=150   align=left </FC>'
                     + '<C>id=SALE_QTY     name="객수"     width=120   		gte_columntype="number:0:true" gte_Summarytype="number:0:true"	align=RIGHT  SumText=@sum  </C>'
                     + '<C>id=TOT_SALE_AMT name="총매출"       width=120   		gte_columntype="number:0:true" gte_Summarytype="number:0:true"	align=RIGHT  SumText=@sum  </C>'
                     + '<C>id=CASH_CNT      name="현금건수"          width=80   gte_columntype="number:0:true" gte_Summarytype="number:0:true"	 align=right SumText=@sum </C>'
                     + '<C>id=CASH_AMT      name="현금매출"        width=120    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	align=right SumText=@sum </C>'
                     + '<C>id=CASH_CANCEL_CNT    name="현금취소건수"            gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=80    align=right SumText=@sum </C>'
                     + '<C>id=CASH_CANCEL_AMT    name="현금취소금액"            gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120   align=right SumText=@sum </C>'
                     + '<C>id=CARD_CANCEL_CNT    name="카드취소건수"            gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=80    align=right SumText=@sum </C>'
                     + '<C>id=CARD_CANCEL_AMT    name="카드취소금액"            gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120   align=right SumText=@sum </C>'
                     + '<C>id=CASH_RATE    name="현금매출비중"        width=120 gte_columntype="number:2:true" gte_Summarytype="number:2:true"	  align=right SumText={ROUND(CASH_AMT/TOT_SALE_AMT*100,2)} </C>'
                     ;
    initGridStyle(GD_MASTER, "common", hdrProperies, false);

    GD_MASTER.ViewSummary = "1";
}
 
function gridCreate2(){
    var hdrProperies = '<FC>id={currow}		  name="NO"			width=30	align=center	</FC>'
                     + '<FC>id=SALE_DT        name="매출일자"      width=80   align=center mask="XXXX-XX-XX" SumText="합계"  </FC>'
                     + '<FC>id=POS_NO         name="포스번호"      width=60  align=left</FC>'
                     + '<FC>id=TRAN_NO        name="거래번호"      width=60   align=left</FC>'
                     + '<FC>id=TRAN_FLAG      name="거래구분"      width=80   align=left </FC>'
                     + '<FC>id=TYPE_NAME      name="거래형태"      width=80   align=left </FC>'
                     + '<FC>id=PAY_AMT        name="매출금액"      width=120   gte_columntype="number:0:true" gte_Summarytype="number:0:true"	align=right SumText=@sum </FC>'
                     + '<FC>id=CARD_NO        name="카드번호"      width=150   align=left </FC>'
                     + '<FC>id=ADD_POINT      name="적립포인트"      width=120  gte_columntype="number:0:true" gte_Summarytype="number:0:true"	 align=right SumText=@sum </FC>'
                     + '<FC>id=MBSH_NO        name="마리오포인트카드"      width=120   align=left </FC>'
                     + '<FC>id=CUST_NAME      name="회원명"      width=120   align=left </FC>'
                     ;
                     
    initGridStyle(GD_DETAIL, "common", hdrProperies, false);

    GD_DETAIL.ViewSummary = "1";
}
/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
     (3) 출력       - btn_Print()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-04-01
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    DS_O_DETAIL.ClearData();    
    bfListRowPosition = 0;
    if (trim(EM_S_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "시작일자");
        EM_S_DT_S.Focus();
        return;
    } else if (trim(EM_E_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "종료일자");
        EM_E_DT_S.Focus();
        return;
    }       

    if (eval(EM_S_DT_S.text) > eval(EM_E_DT_S.text) ) {
        showMessage(EXCLAMATION, OK, "USER-1015",  "종료일자");
        EM_S_DT_S.Focus();
        return;     
    }    
    
    //if (trim(EM_CNT_S.text).length == 0){
        //showMessage(EXCLAMATION, OK, "USER-1003",  "포인트 적립 횟수");
        //EM_CNT_S.Focus();
        //return;
    //}
    
    i//f(parseInt(trim(EM_CNT_S.Text)) < 0){
        //showMessage(EXCLAMATION, OK, "USER-1004",  "포인트 적립 횟수");
        //EM_CNT_S.Focus();
        //return;
    //}
    EXCEL_PARAMS  = "시작일자=" + EM_S_DT_S.text;
    EXCEL_PARAMS += "-종료일자=" + EM_E_DT_S.text;
    //EXCEL_PARAMS += "-포인트적립횟수=" + EM_CNT_S.text;
    //EXCEL_PARAMS += "-적립포인트=" + EM_ADD_POINT.text;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    parameters      = "&strSdt="      + encodeURIComponent(EM_S_DT_S.text)
                    + "&strEdt="      + encodeURIComponent(EM_E_DT_S.text)
                    + "&strCnt1="      + encodeURIComponent(EM_CNT_S1.text)
                    + "&strCnt2="      + encodeURIComponent(EM_CNT_S2.text)
                    + "&strCnt3="      + encodeURIComponent(EM_CNT_S3.text)
                    //+ "&strAddPoint=" + EM_ADD_POINT.text
                    ;
    TR_MAIN.Action  = "/dps/psal956.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    if (DS_O_MASTER.CountRow > 0 ) {
        GD_MASTER.Focus();        
    }
    else {
        EM_S_DT_S.Focus();
    }    	 
}

/**
 * btn_Excel()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-04-01
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	var ExcelTitle = "부정적립예상통계조회"
	CUR_GR.GridToExcelExtProp("HideColumn") = "CUST_ID";       // GridToExcel 사용시 숨길 컬럼지정
	openExcel2(CUR_GR, ExcelTitle, EXCEL_PARAMS, true );
}

/**
 * btn_Print()
 * 작  성  자 : 김영진
 * 작  성  일 : 2010-05-02
 * 개        요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
    if (DS_O_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, Ok, "USER-1031");
        return false;
    }
    window.open("/dps/psal956.ps?goTo=print"+parameters,"OZREPORT", 1000, 700);
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * doOnClick()
  * 작 성 자 : 장형욱
  * 작 성 일 : 2010-02-21
  * 개       요 : 선택된 기부정보 상세 조회
  * return값 : void
  */
 function doClick(row){
           
     if( row == undefined ) 
          row = DS_O_MASTER.RowPosition;
       
     var goTo        = "searchDetail";    
     var action      = "O";     
     var parameters  = "&strSdt="    + encodeURIComponent(EM_S_DT_S.text)
                     + "&strEdt="    + encodeURIComponent(EM_E_DT_S.text)
                     + "&strStrCd=" + encodeURIComponent(DS_O_MASTER.NameValue(row ,"STR_CD"))
                     + "&strPumbunCd=" + encodeURIComponent(DS_O_MASTER.NameValue(row ,"PUMBUN_CD"))
                     ;

     
     TR_DETAIL.Action  = "/dps/psal956.ps?goTo="+goTo+parameters;  
     TR_DETAIL.KeyValue= "SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
     TR_DETAIL.Post();
     
     setPorcCount("SELECT", DS_O_DETAIL.CountRow);
     
 }   
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                        *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                        *-->
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

<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    //그리드 첫 row 상세조회
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        doClick(row);
    }else{
        DS_O_DETAIL.ClearData();
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
    setPorcCount("SELECT", document.getElementById(this.DataId).RealCount(1, document.getElementById(this.DataId).CountRow));
    CUR_GR = this;
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
    setPorcCount("SELECT", document.getElementById(this.DataId).RealCount(1, document.getElementById(this.DataId).CountRow));
    CUR_GR = this;
</script>

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_S_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_DT_S)){
        EM_S_DT_S.text = addDate("M", "-1", '<%=strToMonth%>');
    }
</script>
    
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_E_DT_S event=onKillFocus()>
	if(!checkDateTypeYMD(EM_E_DT_S)){
	    EM_E_DT_S.text = <%=toDate%>;
	}
</script> 
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
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
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">
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
						<th width="80" class="point">조회기간</th>
						<td width="280"><comment id="_NSID_"> <object
							id=EM_S_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DT_S)" />- <comment
							id="_NSID_"> <object id=EM_E_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_E_DT_S)" /></td>

						<th width="100" >현금매출건수</th>
						<td><object id=EM_CNT_S1 classid=<%=Util.CLSID_EMEDIT%>
							width=30 align="right" tabindex=1> </object>건 이상</td>
						<th width="100" >현금취소건수</th>
						<td><object id=EM_CNT_S2 classid=<%=Util.CLSID_EMEDIT%>
							width=30 align="right" tabindex=1> </object>건 이상</td>
						<th width="100" >카드취소건수</th>
						<td><object id=EM_CNT_S3 classid=<%=Util.CLSID_EMEDIT%>
							width=30 align="right" tabindex=1> </object>건 이상</td>
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
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><object id=GD_MASTER width="100%" height=350
					classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><object id=GD_DETAIL width="100%" height=277
					classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_DETAIL">
				</object></td>
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
