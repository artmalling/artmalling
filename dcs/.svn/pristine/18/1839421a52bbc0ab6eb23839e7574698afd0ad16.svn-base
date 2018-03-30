<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 클럽관리 > 클럽가입신청조회승인
 * 작  성  일  : 2010.05.19
 * 작  성  자  : 
 * 수  정  자  : 
 * 파  일  명  : dctm1320.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.05.19 (장형욱) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
	String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
    strToMonth = strToMonth + "01";
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
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var strFlag           = "INS";
var strChangFlag      = false;
var bfListRowPosition = 0;                             // 이전 List Row Position
var strBefore         = "";  
var strAfter          = "";

//엑셀용
var strClubId   = "";
var strName     = "";
var strFromDt   = "";
var strToDt     = "";
var intChangRow = 0;
//
var isFirstSearch     = 0;
var LAST_MOD_ROW      = 0;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 장형욱
 * 작 성 일     : 2010-05-20
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    // Input, Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //마스터
     
    // EMedit에 초기화
    initEmEdit(EM_NAME_S,       "GEN^10",       NORMAL);         //
    initEmEdit(EM_S_DT_S,       "YYYYMMDD",     NORMAL);         //
    initEmEdit(EM_E_DT_S,       "TODAY",        NORMAL);         //
    

    //조회일자 초기값.
    EM_S_DT_S.text = addDate("M", "-1", '<%=strToMonth%>');
    EM_E_DT_S.text = addDate("D", "-1", EM_E_DT_S.text);
    
    btn_Search();
}

function gridCreate1(){
    var hdrProperies    = '<FC>id={currow}          name="NO"            width=30   align=center</FC>'
                        + '<FC>id=CLUB_ID           name="클럽ID"         width=50    align=center</FC>'
                        + '<FC>id=CLUB_NAME         name="클럽명"         width=140   align=left</FC>'
                        + '<FC>id=CLUB_INFO         name="클럽설명"        width=295  align=left</FC>'
                        + '<FC>id=REQ_CNT           name="가입신청회원수"   width=90    align=right</FC>'
                        + '<FC>id=SREQ_CNT          name="탈퇴신청회원수"   width=90    align=right</FC>'
                        + '<FC>id=CUST_CNT          name="보유회원수"       width=80    align=right</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies    = '<FC>id={currow}          name="NO"              width=30   align=center</FC>'
                        + '<FC>id=CLUB_ID           name="클럽ID"           width=50    align=center</FC>'
                        + '<FC>id=CLUB_NAME         name="클럽명"           width=130    align=left</FC>'
                        + '<FC>id=CUST_ID           name="회원ID"           width=100    align=left</FC>'
                        + '<FC>id=CUST_NAME         name="회원명"           width=100    align=left</FC>'
                        + '<G> name="주거형태"'
                        + '<FC>id=HOUSE_TYPE        name="코드"             width=40    align=center</FC>'
                        + '<FC>id=HOUSE_NAME        name="명"               width=40    align=center</FC>'
                        + '</G>'
                        + '<G> name="선호부문"'
                        + '<FC>id=FAVOR_DEPT1_YN    name="백화점쇼핑"        width=80    align=center</FC>'
                        + '<FC>id=FAVOR_DEPT2_YN    name="문화센터"          width=80    align=center</FC>'
                        + '<FC>id=FAVOR_DEPT3_YN    name="아트센터"          width=80    align=center</FC>'
                        + '<FC>id=FAVOR_DEPT4_YN    name="호텔"             width=80    align=center</FC>'
                        + '<FC>id=FAVOR_DEPT5_YN    name="테마파크"          width=80    align=center</FC>'
                        + '</G>'
                        + '<G> name="월평균소득"'
                        + '<FC>id=INCOME_AMT        name="코드"             width=40    align=center</FC>'
                        + '<FC>id=INCOME_NAME       name="명"               width=40    align=center</FC>'
                        + '</G>'
                        + '<FC>id=POINT             name="보유포인트"        width=80    align=right</FC>'
                        + '<FC>id=PROC_NAME         name="구분"             width=40    align=center</FC>'
                        + '<FC>id=REQ_DATE          name="신청일자"          width=150   align=center</FC>';  
                     
    initGridStyle(GR_DETAIL, "common", hdrProperies, false);
}

/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 저장       - btn_Save()
     (4) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-02-10
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(trim(EM_S_DT_S.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_S_DT_S.Focus();
        return;
    }
    if(trim(EM_E_DT_S.Text).length == 0){    // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_E_DT_S.Focus();
        return;
    }
    if(EM_S_DT_S.Text > EM_E_DT_S.Text){      // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_S_DT_S.Focus();
        return;
    } 
    //
    isFirstSearch = 0;
    showMaster();
}

/**
 * btn_Save()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-19
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
     saveData();
}


/**
 * btn_Excel()
 * 작   성   자 : 조형욱
 * 작   성   일 : 2010-05-20
 * 개           요 : 엑셀로 다운로드
 * return값 : void   DS_O_MASTER.NameValue(row ,"CLUB_ID")
 */ 

 function btn_Excel() {
    var parameters = " -클럽ID="      + DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"CLUB_ID")
                   + " -성명="        + EM_NAME_S.text
                   + " -신청시작일자="  + EM_S_DT_S.text
                   + " -신청종료일자="  + EM_E_DT_S.text
                   + " -구분="         + RD_PROC_FLAG.DataValue;
    
     var ExcelTitle = "클럽가입신청승인";
     openExcel2(GR_DETAIL, ExcelTitle, parameters, true);
     GR_DETAIL.Focus();
 }

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 조형욱
 * 작   성   일 : 2010-05-20
 * 개       요     : 클럽가입신청조회승인 리스트 조회 
 * return값 : void
 */
function showMaster(){        
    var goTo        = "searchMaster";    
    var action      = "O";     
   
  //  var parameters  = "";
    var parameters = "&strSdt="      + encodeURIComponent(EM_S_DT_S.text)
                   + "&strEdt="      + encodeURIComponent(EM_E_DT_S.text)
                   + "&strName="     + encodeURIComponent(EM_NAME_S.text);

    TR_MAIN.Action  ="/dcs/dctm132.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	EM_S_DT_S.Focus();	
    }
    /*
    bfListRowPosition = 0;
    intChangRow = 0;
    */
    // 
    DS_O_MASTER.RowPosition = LAST_MOD_ROW>0?LAST_MOD_ROW : DS_O_MASTER.RowPosition;
    isFirstSearch = 1;
    
    
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * doClick()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-19
 * 개       요 : 클럽가입신청조회승인 상세 조회 
 * return값 : void
 */
function doClick(row){
     
    var goTo          = "searchDetail";    
    var action        = "O";     
    /*
    var parameters    = "&strClubId="   + DS_O_MASTER.NameValue(row ,"CLUB_ID")
                      + "&strName="     + EM_NAME_S.text
                      + "&strSdt="      + EM_S_DT_S.text
                      + "&strEdt="      + EM_E_DT_S.text
                      + "&strProcFlag=" + RD_PROC_FLAG.CodeValue;
    */
    
    DS_I_DATA.ClearAll();
    DS_I_DATA.setDataHeader('CLUB_ID:STRING(40),NAME:STRING(40),BEG_DT:STRING(12),END_DT:STRING(12),PROC_FLAG:STRING(1)');
    DS_I_DATA.Addrow();
    DS_I_DATA.NameValue(DS_I_DATA.CountRow, "CLUB_ID")      = DS_O_MASTER.NameValue(row ,"CLUB_ID");
    DS_I_DATA.NameValue(DS_I_DATA.CountRow, "NAME")         = EM_NAME_S.text;
    DS_I_DATA.NameValue(DS_I_DATA.CountRow, "BEG_DT")       = EM_S_DT_S.text;
    DS_I_DATA.NameValue(DS_I_DATA.CountRow, "END_DT")       = EM_E_DT_S.text;
    DS_I_DATA.NameValue(DS_I_DATA.CountRow, "PROC_FLAG")    = RD_PROC_FLAG.CodeValue;
    
    TR_DETAIL.Action    = "/dcs/dctm132.dm?goTo="+goTo;  
    TR_DETAIL.KeyValue  = "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.KeyValue  = "SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL,I:DS_I_DATA=DS_I_DATA)"; //조회는 O
    TR_DETAIL.Post();
}  

/**
 * saveData()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-19
 * 개       요 : 기부기획 등록
 * return값 : void
 */
function saveData(){
    
    if(DS_IO_DETAIL.CountRow <= 0) {
    	showMessage(EXCLAMATION, OK, "USER-1028"); //저장할 내용이 없습니다	  
    	return;
	}    
     
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }   
    DS_IO_DETAIL.UseChangeInfo  = "false";
    var goTo        = "saveData";
    var action      = "I";  //조회는 O
    var parameters  = "&strClubId="   + encodeURIComponent(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition ,"CLUB_ID"))
                    + "&strName="     + encodeURIComponent(EM_NAME_S.text)
                    + "&strSdt="      + encodeURIComponent(EM_S_DT_S.text)
                    + "&strEdt="      + encodeURIComponent(EM_E_DT_S.text)
                    + "&strProcFlag=" + encodeURIComponent(RD_PROC_FLAG.CodeValue);
   
    TR_MAIN.Action  = "/dcs/dctm132.dm?goTo="+goTo+parameters;   
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_MAIN.Post();

    btn_Search();
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
    intChangRow = 0;
    bfListRowPosition = DS_O_MASTER.RowPosition;    
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
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    //그리드 첫 row 상세조회
    /*
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        doClick(row);
    }else{
        DS_IO_DETAIL.ClearData();
    }
    */
    //상세조회
    if(row != 0 && isFirstSearch > 0){
    	doClick(row);
        LAST_MOD_ROW = DS_O_MASTER.RowPosition;
    }
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    CUR_GD = 0;
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>
    CUR_GD = 1;
    sortColId(eval(this.DataID), row, colid);
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
        initEmEdit(EM_E_DT_S,       "TODAY",        NORMAL); 
        EM_E_DT_S.text = addDate("D", "-1", EM_E_DT_S.text);
    }
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
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_CLUB" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_DATA" classid=<%=Util.CLSID_DATASET%>> </object>
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
				<td><!-- search start -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80">구분</th>
						<td width="170"><comment id="_NSID_"> <object
							id=RD_PROC_FLAG classid=<%=Util.CLSID_RADIO%>
							style="height: 20; width: 140" tabindex=1>
							<param name=Cols value="3">
							<param name=Format value="^전체,0^가입,1^탈퇴">
							<param name=CodeValue value="">
						</object> </comment><script> _ws_(_NSID_);</script></td>
						<th width="80">신청일자</th>
						<td width="200"><comment id="_NSID_"> <object
							id=EM_S_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DT_S)" />- <comment
							id="_NSID_"> <object id=EM_E_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_E_DT_S)" /></td>
						<th width="80">성명</th>
						<td><comment id="_NSID_"> <object id=EM_NAME_S
							classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
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
					width="100%" height=283 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
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
					width="100%" height=216 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_IO_DETAIL">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
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
