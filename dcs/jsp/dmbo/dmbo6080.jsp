<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽운영 > 승인처리 > 상품권교환 집계표
 * 작  성  일  : 2010.01.14
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dmbo6080.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :  
 *           2010.01.14 (김영진) 신규작성
 *           2010.03.03 (김영진) 기능추가
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"    prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<%
    String strProcDt = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date()); 
    strProcDt = strProcDt + "01";
    
    String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
 // PID 확인을 위한
    String pageName = request.getRequestURI();
    int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
    int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
    pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

%>
<script LANGUAGE="JavaScript">
<!--
var EXCEL_PARAMS = "";
var strProcSDt   = "";
var strProcEDt   = "";
var parameters   = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-03
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 150;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
/* 	var obj   = document.getElementById("GR_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px"; */

	 
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1();
    
    // EMedit에 초기화
    initEmEdit(EM_PROC_S_DT,    "YYYYMMDD",  PK);           // 조회 시작기간    
    initEmEdit(EM_PROC_E_DT,    "TODAY",     PK);           // 조회 종료기간
    
    //조회일자 초기값.
    EM_PROC_S_DT.Text = '<%=strProcDt%>';
    //showMaster();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"              width=30      align=center</FC>'
                     + '<FC>id=BRCH_NAME        name="가맹점명"         width=120     align=left SumText="합계" </FC>'
                     + '<FC>id=PROC_DT          name="교환일"          width=100     align=center mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=CONV_POINT       name="사용포인트"       width=113     align=right SumText=@sum </FC>'
                     + '<FC>id=CONV_GIFTCD_AMT  name="상품권금액(지급)"       width=113     align=right SumText=@sum </FC>'
                     + '<FC>id=GIFTCD_DTL_AMT   name="상품권금액(등록)"       width=113     align=right SumText=@sum </FC>'
                     + '<FC>id=ERR_GIFT_AMT     name="상품권금액(차이)"       width=113     align=right SumText=@sum </FC>'
                     + '<FC>id=QTY_5            name="5천원권매수"      width=100     align=right SumText=@sum </FC>'
                     + '<FC>id=QTY_10           name="1만원권매수"      width=100     align=right SumText=@sum </FC>'
                     + '<FC>id=QTY_50           name="5만원권매수"      width=100     align=right SumText=@sum </FC>'
                     + '<FC>id=QTY_100          name="10만원권매수"     width=100     align=right SumText=@sum </FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    GR_MASTER.ViewSummary = "1";
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
     (3) 출력       - btn_Print()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-03
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
     
    if(trim(EM_PROC_S_DT.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_PROC_S_DT.Focus();
        return;
    }
    if(trim(EM_PROC_E_DT.Text).length == 0){    // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_PROC_E_DT.Focus();
        return;
    }
    if(EM_PROC_S_DT.Text > EM_PROC_E_DT.Text){   // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_PROC_S_DT.Focus();
        return;
    }
    showMaster();
 }

/**
 * btn_Excel()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-03
 * 개       요     : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    var ExcelTitle = "상품권교환 집계표"
    var params = "조회기간=" + strProcSDt+ "~" + strProcEDt;
    //openExcel2(GR_MASTER, ExcelTitle, params, true );
    openExcel5(GR_MASTER, ExcelTitle, params, true , "",g_strPid );

}

/**
 * btn_Print()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-03
 * 개       요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
    if (DS_O_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, Ok, "USER-1031");
        return false;
    }
    var strPgmId    = '<c:out value="${sessionScope.sessionInfo.PGM_ID}" />';

    parameters  += "&strPgmId="  + strPgmId;

    window.open("/dcs/dmbo608.do?goTo=print"+parameters,"OZREPORT", 1000, 700);
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-03
 * 개       요     : 상품권교환 집계표 조회 
 * return값 : void
 */
function showMaster(){

    strProcSDt  = EM_PROC_S_DT.Text;
    strProcEDt  = EM_PROC_E_DT.Text;
    var goTo    = "searchMaster";    
    var action  = "O";     
    parameters  = "&strProcSDt="   + encodeURIComponent(strProcSDt)
                + "&strProcEDt="   + encodeURIComponent(strProcEDt);
    TR_MAIN.Action  ="/dcs/dmbo608.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_O_MASTER.CountRow > 0){
    	GR_MASTER.Focus();
    }else{
    	EM_PROC_S_DT.Focus();
    }
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                         *-->
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
<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_PROC_S_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_PROC_S_DT)){
        EM_PROC_S_DT.text =  addDate("M", "-1", '<%=strProcDt%>');
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_PROC_E_DT event=onKillFocus()>
	if(!checkDateTypeYMD(EM_PROC_E_DT)){
		EM_PROC_E_DT.text = <%=toDate%>;
	}
</script>

<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- ===============- Output용 -->
<comment id="_NSID_">
  <object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>>
  </object>
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

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
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
						<td><comment id="_NSID_"> <object id=EM_PROC_S_DT
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_PROC_S_DT)" />- <comment
							id="_NSID_"> <object id=EM_PROC_E_DT
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_PROC_E_DT)" /></td>
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
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=780 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script> _ws_(_NSID_);</script></td>
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
