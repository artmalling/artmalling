<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽운영  > 주차할인  > 무료주차시간조회
 * 작  성  일  : 2010.01.14
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dmbo3030.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.01.14 (김영진) 신규작성
 *           2010.03.18 (김영진) 기능추가
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"    prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>
<!--*********************************************************
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
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
<%
    String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date()); 
    strToMonth = strToMonth + "01";
    
    String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>
<script LANGUAGE="JavaScript">
<!--
var EXCEL_PARAMS = "";

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-18
 * 개       요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1();
    gridCreate2(); 
    
    //EMedit에 초기화
    initEmEdit(EM_USE_F_DT,    "YYYYMMDD",  PK);           // 조회 시작기간    
    initEmEdit(EM_USE_T_DT,    "TODAY",     PK);           // 조회 종료기간
    initComboStyle(LC_STR, DS_STR, "CODE^0^30,NAME^0^80", 1, PK);  //소속점코드
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getStore("DS_STR", "Y", "", "N");
    setComboData(LC_STR,  DS_STR.NameValue(0, "CODE"));  //
    
    // 초기값 설정
    EM_USE_F_DT.Text = addDate("M", "-1", '<%=strToMonth%>');
    EM_USE_F_DT.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}   name="NO"                width=30       align=center</FC>'
                     + '<FC>id=CUST_ID    name="회원 ID"            width="100"    align=center  show=false</FC>'
                     + '<FC>id=CUST_NAME  name="회원명"             width="100"     align=left</FC>'
                     + '<FC>id=SS_NO      name="생년월일"            width="140"     align=center   mask="XXXXXX"</FC>'
                     + '<FC>id=CUST_GRADE name="회원등급"            width="100"     align=center   show=false</FC>'
                     + '<FC>id=GRADE_NM   name="회원등급"            width="110"     align=center</FC>'
                     + '<FC>id=DT_COUNT   name="무료주차이용일수"     width="140"     align=right</FC>'
                     + '<FC>id=PARKING_TIME name="무료주차사용시간"    width="140"    align=right</FC>'
                     + '<FC>id=REMARK     name="비고"                width="120"    align=left</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}   name="NO"                     width=30        align=center</FC>'
                     + '<FC>id=CUST_ID    name="회원 ID"                 width="100"     align=center   show=false</FC>'
                     + '<FC>id=CUST_NAME  name="회원명"                 width="70"     align=left</FC>'
                     + '<FC>id=SS_NO      name="생년월일"               width="120"     align=center    mask="XXXXXX"</FC>'
                     + '<FC>id=CUST_GRADE name="회원등급"               width="90"     align=center    show=false</FC>'
                     + '<FC>id=GRADE_NM   name="회원등급"               width="80"     align=center    </FC>'
                     + '<FC>id=USE_DT     name="무료주차사용일자"        width="100"     align=center    mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=USE_TIME   name="무료주차승인시간"         width="120"     align=center    mask="XX:XX:XX"</FC>'
                     + '<FC>id=PARKING_TIME name="무료주차사용시간"         width="120"     align=right   </FC>'
                     + '<FC>id=REMARK     name="비고"                   width="140"     align=left</FC>';
                     
    initGridStyle(GR_DETAIL, "common", hdrProperies, false);
}
/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-18
 * 개       요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if(trim(EM_USE_F_DT.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_USE_F_DT.Focus();
        return;
    }
    if(trim(EM_USE_T_DT.Text).length == 0){    // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_USE_T_DT.Focus();
        return;
    } 
    if(EM_USE_F_DT.Text > EM_USE_T_DT.Text){      // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_USE_F_DT.Focus();
        return;
    } 
    if(trim(LC_STR.Text).length == 0){
	   showMessage(EXCLAMATION, OK, "USER-1002","점코드");
	   LC_STR.Focus();
       return;
    }
    showMaster();
}

/**
 * btn_Excel()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-18
 * 개       요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	 var ExcelTitle = "무료주차시간조회"
	            
	 GR_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
	 openExcel2(GR_MASTER, ExcelTitle, EXCEL_PARAMS, true );
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-18
 * 개       요     : 무료주차시간조회
 * return값 : void
 */
function showMaster(){
    var strUseFDt   = EM_USE_F_DT.Text;
    var strUseTDt   = EM_USE_T_DT.Text;
    var strStrCd    = LC_STR.BindColVal;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strUseFDt="  + encodeURIComponent(strUseFDt)
                    + "&strUseTDt="  + encodeURIComponent(strUseTDt)
                    + "&strStrCd="   + encodeURIComponent(strStrCd);    
    
    
    EXCEL_PARAMS  = "시작일자="  + strUseFDt;
    EXCEL_PARAMS += "-종료일자=" + strUseTDt;
    EXCEL_PARAMS += "-점포="     + strStrCd;
    
    TR_MAIN.Action  ="/dcs/dmbo303.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //Focus이동
    if(DS_O_MASTER.CountRow > 0){
    	//상단 Grid Focus이동
        GR_MASTER.Focus();
    }else{
    	EM_USE_F_DT.Focus();
    }
    
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * searchDetail()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-21
 * 개       요     : 무료주차시간조회 상세조회
 * return값 : void
 */
function searchDetail(row){
	 
    var strUseFDt   = EM_USE_F_DT.Text;
    var strUseTDt   = EM_USE_T_DT.Text;
    var strStrCd    = LC_STR.BindColVal;
    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;
    var strCurtId   = DS_O_MASTER.NameValue(row ,"CUST_ID");
    var goTo        = "searchDetail";    
    var action      = "O";     
    var parameters  = "&strUseFDt="  + encodeURIComponent(strUseFDt)
                    + "&strUseTDt="  + encodeURIComponent(strUseTDt)
                    + "&strStrCd="   + encodeURIComponent(strStrCd)
                    + "&strCurtId="  + encodeURIComponent(strCurtId);    
    TR_DETAIL.Action  ="/dcs/dmbo303.do?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
    //조회결과 Return
    setPorcCount("SELECT", DS_O_DETAIL.CountRow);
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
<!--DS_O_MASTER  OnRowPosChanged(row)(row,colid)-->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
    if(clickSORT) return;
    //그리드 첫 row 상세조회
    if(row != 0){
    	searchDetail(row);
    }else{
        DS_O_DETAIL.ClearData();
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_USE_F_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_USE_F_DT)){
    	EM_USE_F_DT.Text = addDate("M", "-1", '<%=strToMonth%>');
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_USE_T_DT event=onKillFocus()>
	if(!checkDateTypeYMD(EM_USE_T_DT)){
		EM_USE_T_DT.text = <%=toDate%>;
	}
</script>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
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
<!-- =============== 공통콤보용 -->
<comment id="_NSID_">
<object id="DS_STR" classid=<%= Util.CLSID_DATASET %>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%= Util.CLSID_DATASET %>> </object>
</comment>
<script>_ws_(_NSID_);</script>

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
<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
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
						<th width="80" class="point">조회기간</th>
						<td width="320"><comment id="_NSID_"> <object
							id=EM_USE_F_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_USE_F_DT)" />- <comment
							id="_NSID_"> <object id=EM_USE_T_DT
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_USE_T_DT)" /></td>
						<th width="80" class="point">점포명</th>
						<td><comment id="_NSID_"> <object id=LC_STR
							classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=125 tabindex=1>
						</object> </comment> <script> _ws_(_NSID_);</script></td>
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
					width="100%" height=250 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script> _ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_DETAIL
					width="100%" height=247 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_DETAIL">
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
