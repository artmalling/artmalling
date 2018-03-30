<!-- 
/*******************************************************************************
 * 시스템명 : 고객관리 > 가맹점관리 > 회원 연령별성별 매출 현황(일)
 * 작  성  일  : 2012.05.30
 * 작  성  자  : kj
 * 수  정  자  : 
 * 파  일  명  : dbri3150.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *          2012.05.30 (kj) 신규작성
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
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<%
	String strFromDate = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	strFromDate = strFromDate + "01";

	String strToDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>
<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : kj
 * 작 성 일     : 2012.05.30
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
 function doInit(){
	 
	    //Output Data Set Header 초기화
	    DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
	    
	    //그리드 초기화
	    gridCreate1(); //마스터
	    
	    GR_MASTER.GTitleHeight = 20;
	    GR_MASTER.TitleHeight  = 40;
	    
	    // EMedit에 초기화
	    initEmEdit(EM_FROM_BS_DT, "YYYYMMDD",  PK);           // 기준조회일
	    initEmEdit(EM_TO_BS_DT, "YYYYMMDD",  PK);           // 기준조회일
	    initEmEdit(EM_FROM_CS_DT, "YYYYMMDD",  PK);           // 대비조회일
	    initEmEdit(EM_TO_CS_DT, "YYYYMMDD",  PK);           // 대비조회일    
	    
	    //조회기간 초기값.
	    EM_FROM_BS_DT.text = <%=strFromDate%>;
	    EM_TO_BS_DT.text = <%=strToDate%>;
	    EM_FROM_CS_DT.text = <%=strFromDate%>;
	    EM_TO_CS_DT.text = <%=strToDate%>;    
	    
	    //화면 OPEN시 자동 조회
	    //btn_Search();
	}

function gridCreate1(){
     var hdrProperies = '<FC>id={currow}      	name="NO"             		width=30    align=center</FC>'
			          + '<FC>id=AGE_NM  		name="년령대"					width=60    align=center suppress=1</FC>'
			          + '<FC>id=SEX_NM  		name="성별"					width=40    align=center</FC>'
    	 			  + '<FG>id=TITLE           name="매출일자"'
                      + '<FC>id=SALE_AMT       	name="매출"       			width=100    align=right SumText=@sum<</FC>'
                      + '<FC>id=AGE_AMT       	name="년령대;합매출"       	width=100    align=right  suppress=1</FC>'
                      + '<FC>id=TOT_AMT       	name="총매출"       			width=100    align=right </FC>'
                      + '<FC>id=SALE_RATE       name="매출/총;매출구성비"      width=100    align=right </FC>'
                      + '<FC>id=AGE_RATE       	name="년령대/총;매출구성비"  	width=100    align=right suppress=1</FC>'
                      + '<FC>id=SEX_RATE     	name="성별/년령대;매출구성비"   width=100    align=right </FC>'
                      + '</FG>'
                      + '<FG>id=TITLE           name="대비일자"'
                      + '<FC>id=PRE_SAEL_AMT    name="매출"   				width=100    align=right SumText=@sum</FC>'
                      + '<FC>id=PRE_AGE_AMT    	name="년령대;합매출"   		width=100    align=right suppress=1</FC>'
                      + '<FC>id=PRE_TOT_AMT   	name="총매출"   				width=100    align=right </FC>'
                      + '<FC>id=PRE_SALE_RATE   name="매출/총;매출구성비"   	width=100    align=right </FC>'
                      + '<FC>id=PRE_AGE_RATE    name="년령대/총;매출구성비"   	width=100    align=right suppress=1</FC>'
                      + '<FC>id=PRE_SEX_RATE   	name="성별/년령대;매출구성비"   width=100    align=right </FC>'                      
                      + '</FG>'
                      + '<FC>id=ADD_SAEL_AMT   	name="매출;증감액"   		width=100    align=right SumText=@sum</FC>'
                      + '<FC>id=ADD_SAEL_RATE   name="매출;증감율"  		width=100    align=right</FC>';            
                      
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    GR_MASTER.ViewSummary = "1";
}

/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자     : kj
 * 작 성 일     : 2012.05.30
 * 개       요     : 조회시 호출
 * return값 : void
 */
 function btn_Search() {

	    if(trim(EM_FROM_BS_DT.Text).length == 0){   // 조회기간
	        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	        EM_FROM_BS_DT.Focus();
	        return;
	    }
	    if(trim(EM_TO_BS_DT.Text).length == 0){   // 조회기간
	        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	        EM_TO_BS_DT.Focus();
	        return;
	    }
	    if(trim(EM_FROM_CS_DT.Text).length == 0){   // 조회기간
	        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	        EM_FROM_CS_DT.Focus();
	        return;
	    }
	    if(trim(EM_TO_CS_DT.Text).length == 0){   // 조회기간
	        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	        EM_TO_CS_DT.Focus();
	        return;
	    } 
	    showMaster();
	    //조회결과 Return
	    setPorcCount("SELECT", DS_MASTER.RealCount(1, DS_MASTER.CountRow));
	}

/**
 * btn_Excel()
 * 작 성 자     : kj
 * 작 성 일     : 2012.05.30
 * 개       요     : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

	var parameters = "매출조회시작일자="     + EM_FROM_BS_DT.Text
				   + "매출조회종료일자="     + EM_TO_BS_DT.Text
				   + "대비조회시작일자="     + EM_FROM_CS_DT.Text
				   + "대비조회종료일자="     + EM_TO_CS_DT.Text;
    
    var ExcelTitle = "회원 연령별성별 매출 현황(일)"

    openExcel2(GR_MASTER, ExcelTitle, parameters, true );
    
    GR_MASTER.Focus();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : kj
 * 작 성 일     : 2010-02-16
 * 개       요     : 일단위 포인트 현황 조회 
 * return값 : void
 */
function showMaster(){
    var goTo        = "searchMaster";    
    var action      = "O";
    var parameters  = "&strFromBSDate="+ encodeURIComponent(EM_FROM_BS_DT.Text)
					+ "&strToBSDate="  + encodeURIComponent(EM_TO_BS_DT.Text)
					+ "&strFromCSDate="+ encodeURIComponent(EM_FROM_CS_DT.Text)
					+ "&strToCSDate="  + encodeURIComponent(EM_TO_CS_DT.Text);
    TR_MAIN.Action  ="/dcs/dbri315.db?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	EM_FROM_BS_DT.Focus();
    }
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
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
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 기준조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_FROM_BS_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_FROM_BS_DT)){
    	EM_FROM_BS_DT.text = <%=strFromDate%>;
    }
</script>
    
<!-- 기준조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_TO_BS_DT event=onKillFocus()>
	if(!checkDateTypeYMD(EM_TO_BS_DT)){
		EM_TO_BS_DT.text = <%=strToDate%>;
	}
</script>

<!-- 대비조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_FROM_CS_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_FROM_CS_DT)){
    	EM_FROM_CS_DT.text = <%=strFromDate%>;
    }
</script>
    
<!-- 대비조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_TO_CS_DT event=onKillFocus()>
	if(!checkDateTypeYMD(EM_TO_CS_DT)){
		EM_TO_CS_DT.text = <%=strToDate%>;
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
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_">
<object id="DS_MASTER" classid=<%= Util.CLSID_DATASET %>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
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
						<th width="100" class="point">매출일자</th>
						<td><comment id="_NSID_"> <object
							id=EM_FROM_BS_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_FROM_BS_DT)" />-
							<comment id="_NSID_"> <object 
							id=EM_TO_BS_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_TO_BS_DT)" /></td>
						<th width="100" class="point">대비일자</th>
						<td><comment id="_NSID_"> <object
							id=EM_FROM_CS_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_FROM_CS_DT)" />-
							<comment id="_NSID_"> <object 
							id=EM_TO_CS_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_TO_CS_DT)" /></td>							
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
					width="100%" height=504 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_MASTER">
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
