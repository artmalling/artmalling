<!-- 
/*******************************************************************************
 * 시스템명 : 고객관리 > 가맹점관리 > 지역별 회원 매출 현황(월)
 * 작  성  일  : 2012.05.30
 * 작  성  자  : kj
 * 수  정  자  : 
 * 파  일  명  : dbri3020.jsp
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
	String strFromMonth = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) + "01";
	String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date()); 
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
    GR_MASTER.TitleHeight = 40;
    
    // EMedit에 초기화
    initEmEdit(EM_FROM_S_YYYYMM, "YYYYMM",  PK);           // 조회월
    initEmEdit(EM_TO_S_YYYYMM, "YYYYMM",  PK);           // 조회월
    
    //조회년월 초기값.
    EM_FROM_S_YYYYMM.text = <%=strFromMonth%>;
    EM_TO_S_YYYYMM.text = <%=strToMonth%>;
    
    //화면 OPEN시 자동 조회
    //btn_Search();
}

function gridCreate1(){
     var hdrProperies = '<FC>id={currow}      	name="NO"           width=30    align=center 										SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                      + '<FC>id=YYYYMM  		name="년월"			width=80    align=center align=center mask="XXXX/XX" suppress=2 SubSumText={decode(curlevel,2,"년월 소계","")} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                      + '<FC>id=BUSI_AREA    	name="상권"     		width=50    align=center suppress=1 SubSumText="" 				SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                      + '<FC>id=BUSI_AREA_NM    name="상권명"     	width=200    align=center SubSumText={decode(curlevel,1,"상권 소계","")} 	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                      + '<FC>id=SALE_AMT    	name="매출액"			width=110    align=right sumtext={subsum(SALE_AMT)} 	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                      + '<FC>id=SALE_RATE     	name="구성비"   		width=80    align=right  SubSumText="" 					SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                      + '<FC>id=PRE_SALE_AMT   	name="전월매출"   	width=120    align=right sumtext={subsum(PRE_SALE_AMT)} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                      + '<FC>id=ADD_SALE_AMT   	name="매출;증감액"   	width=120    align=right sumtext={subsum(ADD_SALE_AMT)} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                      + '<FC>id=ADD_SALE_RATE   name="매출;증감율"     width=80    align=right SubSumText="" 					SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                      + '<FC> id=level          name=레벨 Value={CurLevel}    width=50   show=false</FC>'
                      ;
                      
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    GR_MASTER.ViewSummary = "1";
    GR_MASTER.DecRealData = true;
    DS_MASTER.SubSumExpr  = "2:YYYYMM, 1:BUSI_AREA" ; 
    GR_MASTER.ColumnProp("BUSI_AREA", "sumtext")        = "합계";
       
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

    if(trim(EM_FROM_S_YYYYMM.Text).length == 0){   // 조회년월
        showMessage(EXCLAMATION, OK, "USER-1001","조회년월");
        EM_FROM_S_YYYYMM.Focus();
        return;
    }
    if(trim(EM_TO_S_YYYYMM.Text).length == 0){   // 조회년월
        showMessage(EXCLAMATION, OK, "USER-1001","조회년월");
        EM_TO_S_YYYYMM.Focus();
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

    var parameters = "조회시작년월="     + EM_FROM_S_YYYYMM.Text
    			   + "조회종료년월="     + EM_TO_S_YYYYMM.Text;
    
    var ExcelTitle = "월단위 포인트 현황 조회"

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
    var parameters  = "&strFromSMonth="+ encodeURIComponent(EM_FROM_S_YYYYMM.Text)
    				+ "&strToSMonth="  + encodeURIComponent(EM_TO_S_YYYYMM.Text);
    TR_MAIN.Action  ="/dcs/dbri302.db?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	EM_FROM_S_YYYYMM.Focus();
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

<!-- 조회년월 onKillFocus() -->
<script language=JavaScript for=EM_FROM_S_YYYYMM event=onKillFocus()>
    if(!checkDateTypeYM(EM_FROM_S_YYYYMM)){
    	EM_FROM_S_YYYYMM.text = <%=strFromMonth%>;
    }
</script>
<script language=JavaScript for=EM_TO_S_YYYYMM event=onKillFocus()>
    if(!checkDateTypeYM(EM_TO_S_YYYYMM)){
    	EM_TO_S_YYYYMM.text = <%=strToMonth%>;
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
						<th width="100" class="point">조회년월</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_FROM_S_YYYYMM classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('M',EM_FROM_S_YYYYMM)" />-
							<comment id="_NSID_"> <object 
							id=EM_TO_S_YYYYMM classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('M',EM_TO_S_YYYYMM)" /></td>
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
