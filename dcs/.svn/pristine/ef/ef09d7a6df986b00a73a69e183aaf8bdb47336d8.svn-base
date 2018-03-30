<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 포인트정산 > 데이터검증 > 데이터 검증 현황 조회
 * 작 성 일 : 2010.03.31
 * 작 성 자 : 장형욱
 * 수 정 자 : 
 * 파 일 명 : dmtc2010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.03.31 (장형욱) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    request.setCharacterEncoding("utf-8");
    String dir = BaseProperty.get("context.common.dir");
    
    String fromDate = (String)request.getAttribute("fromdate");
    
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
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var EXCEL_PARAMS = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-31
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // 검색 필드
    initEmEdit(EM_S_DT_S,       "YYYYMMDD", PK);  
    
    //조회일자 초기값.
    EM_S_DT_S.text = <%=fromDate%>;
    btn_Search();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"              width=30       align=center</FC>'
                     + '<FC>id=CHK_NAME    name="체크항목"         width=250      align=left</FC>'
                     + '<FC>id=TOT_CNT     name="전체건수"         width=80       align=right</FC>'
                     + '<FC>id=DAY_CNT     name="대상건수"         width=80       align=right</FC>'
                     + '<FC>id=ERR_CNT     name="오류건수"         width="82"     align=right</FC>'
                     + '<FC>id=REMARK      name="비고"            width="252"     align=left</FC>';
                     
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
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-31
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if (trim(EM_S_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "조회일자");
        EM_S_DT_S.Focus();
        return;
    }
    EXCEL_PARAMS = "조회일자=" + EM_S_DT_S.text;
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strSdt="      + encodeURIComponent(EM_S_DT_S.text);
    
    TR_MAIN.Action  = "/dcs/dmtc201.dc?goTo="+goTo+parameters;  
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
 * 작 성 일 : 2010-03-31
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	 
    var ExcelTitle = "데이터 검증 현황 조회"
    GD_MASTER.GridToExcelExtProp("HideColumn") = "";       // GridToExcel 사용시 숨길 컬럼지정
    openExcel2(GD_MASTER, ExcelTitle, EXCEL_PARAMS, true );	 
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

-->
</script>
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
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_S_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_DT_S)){
        EM_S_DT_S.text = <%=fromDate%>;
    }
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
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
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
						<th width="80" class="point">조회일자</th>
						<td><comment id="_NSID_"> <object id=EM_S_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DT_S)" /></td>
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
				<td><object id=GD_MASTER width="100%" height=502
					classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
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
