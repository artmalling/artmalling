<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 회원관리 > 제휴사 회원탈퇴 현황
 * 작  성  일  : 2010.01.14
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dctm1130.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *          2010.01.14 (김영진) 신규작성
 *          2010.02.24 (김영진) 기능추가
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
%>
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
	String strToDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String strToDate2 = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	strToDate2 = strToDate2 + "01";
%>
<script LANGUAGE="JavaScript">
<!--
var bfListRowPosition = 0;                             // 이전 List Row Position
var strJcompScedSDt   = "";
var strJcompScedEDt   = "";
var strTag            = "";
var strTagNm          = "";
var intChangRow       = 0;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-24
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    // Input,Output Data Set Header 초기화
	DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터

    //EMedit에 초기화
    initEmEdit(EM_JCOMP_SCED_DT_S, "YYYYMMDD",  PK);     //탈퇴일자 S
    initEmEdit(EM_JCOMP_SCED_DT_E, "YYYYMMDD",  PK);     //탈퇴일자 E  
    
    //상세 EMedit에 초기화
    initEmEdit(EM_CUST_ID_D,       "GEN^9",     READ);    //회원ID
    initEmEdit(EM_CUST_NAME_D,     "GEN^40",    READ);    //회원명
    initEmEdit(EM_BRCH_NAME_D,     "GEN^40",    READ);    //제휴카드구분
    initEmEdit(EM_JCOMP_SCED_DT_D, "####/##/##",READ);    //탈퇴일자
    initEmEdit(EM_HOME_PH_D,       "GEN^14",    READ);    //자택전화
    initEmEdit(EM_MOBILE_PH_D,     "GEN^14",    READ);    //휴대전화
    initEmEdit(EM_GRADE_NM_D,      "GEN^30",    READ);    //회원등급
    initEmEdit(EM_CALL_NAME_D,     "GEN^20",    READ);    //통화자
    initEmEdit(EM_CALL_DATE_D,     "GEN^19",    READ);    //통화일시
    initEmEdit(TXT_CALL_DESC_D,    "GEN^400",   PK);      //메모내용

    //조회일자 초기값.
    EM_JCOMP_SCED_DT_S.text = addDate("M", "-1", '<%=strToDate2%>');
    EM_JCOMP_SCED_DT_E.text = '<%=strToDate%>'; 
    RD_TAG_S.CodeValue = 'A';
    
    EM_CUST_ID_D.style.display = 'none';
    
    //화면 OPEN시 자동 조회
    btn_Search();
 }

function gridCreate1(){
	var hdrProperies = '<FC>id={currow}        name="NO"            width=30    align=center</FC>'
		             + '<FC>id=CUST_ID         name="회원(법인)ID"   width=90   align=center  show=false</FC>' 
                     + '<FC>id=CUST_NAME       name="회원(법인)명"   width=88   align=left</FC>' 
                     + '<FC>id=BRCH_NAME       name="제휴카드구분"   width=88   align=left</FC>'
                     + '<FC>id=JCOMP_SCED_DT   name="탈퇴일자"       width=82   align=center mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=HOME_PH1        name="자택전화"       width=95   align=center</FC>'
                     + '<FC>id=MOBILE_PH1      name="휴대전화"       width=95   align=center</FC>'
                     + '<FC>id=GRADE_NM        name="회원등급"       width=70   align=center  show=false</FC>'
                     + '<FC>id=CALL_DATE       name="통화일시"       width=130  align=center  mask="XXXX/XX/XX XX:XX:XX"</FC>'
                     + '<FC>id=CALL_NAME       name="통화자"         width=70   align=left</FC>'
                     + '<FC>id=CALL_DESC       name="메모"           width=100   align=left</FC>';
                     
             initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 저장       - btn_Save()
     (3) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-24
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if (DS_IO_DETAIL.IsUpdated){
	    if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
	        setTimeout("TXT_CALL_DESC_D.Focus();",50);
	        return false;
	    }
	}
    if(trim(EM_JCOMP_SCED_DT_S.Text).length == 0){            // 탈퇴일자 시작일
        showMessage(EXCLAMATION, OK, "USER-1001","탈퇴일자 ");
        EM_JCOMP_SCED_DT_S.Focus();
        return;
    }
    if(trim(EM_JCOMP_SCED_DT_E.Text).length == 0){           // 탈퇴일자 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","탈퇴일자");
        EM_JCOMP_SCED_DT_E.Focus();
        return;
    }
    if(EM_JCOMP_SCED_DT_S.Text > EM_JCOMP_SCED_DT_E.Text){   // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_JCOMP_SCED_DT_S.Focus();
        return;
    }
    bfListRowPosition = 0;
    intChangRow = 0;
    showMaster();

    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * btn_Save()
 * 작   성   자 : 김영진
 * 작   성   일 : 2010-03-02
 * 개           요 : 통화내역 저장 처리
 * return값 : void
 */
function btn_Save() {
	 
    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }
	if(trim(TXT_CALL_DESC_D.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "메모내용");
        TXT_CALL_DESC_D.Focus();
        return;
    }
    
    //저장여부 QUESTION
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
    intChangRow = DS_O_MASTER.RowPosition;
    saveData();
}

/**
 * btn_Excel()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-24
 * 개       요     : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    var ExcelTitle = "제휴카드사 회원탈퇴 현황";
    var parameters = "탈퇴일자=" + strJcompScedSDt + "~" + strJcompScedEDt
                   + " -조회구분=" + strTagNm;

    openExcel2(GR_MASTER, ExcelTitle, parameters, true );
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-24
 * 개       요     : 회원메모 리스트 조회 
 * return값 : void
 */
function showMaster(){
 
    strJcompScedSDt = EM_JCOMP_SCED_DT_S.text;
    strJcompScedEDt = EM_JCOMP_SCED_DT_E.text;
    strTag          = RD_TAG_S.CodeValue;
    strTagNm        = RD_TAG_S.DataValue;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strJcompScedSDt=" + encodeURIComponent(strJcompScedSDt)
                    + "&strJcompScedEDt=" + encodeURIComponent(strJcompScedEDt)
                    + "&strTag="          + encodeURIComponent(strTag);
    TR_MAIN.Action  ="/dcs/dctm113.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post(); 
    
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
        if(intChangRow > 0){
            bfListRowPosition = DS_O_MASTER.RowPosition;
            setFocusGrid(GR_MASTER, DS_O_MASTER, intChangRow);
            doClick(intChangRow);
        }
        TXT_CALL_DESC_D.Enable = true;
    }else{
        EM_JCOMP_SCED_DT_S.Focus();
        TXT_CALL_DESC_D.Enable = false;
    }
}  

/**
 * doClick()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-02
 * 개       요     : 선택된 통화내역 상세 조회 
 * return값 : void
 */
function doClick(row){
    if( row == undefined ) 
	    row = DS_O_MASTER.RowPosition;
    
    var strCallDate = DS_O_MASTER.NameValue(row ,"CALL_DATE");
    var strCustId   = DS_O_MASTER.NameValue(row ,"CUST_ID");
    var strJcompScedSDt = EM_JCOMP_SCED_DT_S.text;
    var strJcompScedEDt = EM_JCOMP_SCED_DT_E.text;
    
    var goTo        = "searchDetail";    
    var action      = "O";     
    var parameters  = "&strCustId="   + encodeURIComponent(strCustId)
                    + "&strCallDate=" + encodeURIComponent(strCallDate)
                    + "&strJcompScedSDt=" + encodeURIComponent(strJcompScedSDt)
                    + "&strJcompScedEDt=" + encodeURIComponent(strJcompScedEDt);
    TR_DETAIL.Action  = "/dcs/dctm113.dm?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
   
}

/**
 * saveData()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-02
 * 개       요     : 통화내역 저장
 * return값 : void
 */
function saveData(){
    var strTag = "N";
    if(trim(EM_CALL_DATE_D.Text).length != 0){
        strTag = "Y";	
    }
    var goTo        = "save";
    var action      = "I";  //조회는 O
    var parameters  = "&strTag="   + encodeURIComponent(strTag);
    TR_MAIN.Action  ="/dcs/dctm113.dm?goTo="+goTo+parameters;    
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_MAIN.Post();

    showMaster();
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
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
    if (DS_IO_DETAIL.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
        	setTimeout("TXT_CALL_DESC_D.Focus();",50);
            return false;
        }else {
            return true;
        }
    }
</script>
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    if(clickSORT) return;
    // 그리드 클릭이벤트에서 처리 할 내역 추가        
    if(row != 0){
    	if( bfListRowPosition == row)
            return;
    	if( intChangRow == 0 ){
            bfListRowPosition = row;
            doClick(row);
    	}
    }else{
        DS_IO_DETAIL.ClearData();
    } 
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_JCOMP_SCED_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_JCOMP_SCED_DT_S)){
    	EM_JCOMP_SCED_DT_S.text = addDate("M", "-1", '<%=strToDate2%>');
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_JCOMP_SCED_DT_E event=onKillFocus()>
    checkDateTypeYMD(EM_JCOMP_SCED_DT_E);
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
<!-- ===============- Input,Output용  -->
<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
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
						<th width="80" class="point">탈퇴일자</th>
						<td width="260"><comment id="_NSID_"> <object
							id=EM_JCOMP_SCED_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1">
						</object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_JCOMP_SCED_DT_S)" /> ~ <comment
							id="_NSID_"> <object id=EM_JCOMP_SCED_DT_E
							classid=<%=Util.CLSID_EMEDIT%> width=70
						    tabindex=1>
						</object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_JCOMP_SCED_DT_E)" /></td>
						<th width="80">조회구분</th>
						<td><comment id="_NSID_"> <object id=RD_TAG_S
							classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 180"
							tabindex=1>
							<param name=Cols value="3">
							<param name=Format value="A^전체,Y^통화,N^미통화">
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
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=375 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script> _ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PT03">
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			class="s_table">
			<tr>
				<th width="80">회원명</th>
				<td width="170"><comment id="_NSID_"> <object
					id=EM_CUST_ID_D classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1>
				</object> </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_"> <object
					id=EM_CUST_NAME_D classid=<%=Util.CLSID_EMEDIT%> width=130
					tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
				<th width="80">제휴카드구분</th>
				<td width="170"><comment id="_NSID_"> <object
					id=EM_BRCH_NAME_D classid=<%=Util.CLSID_EMEDIT%> width=130
					tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
				<th width="80">탈퇴일자</th>
				<td><comment id="_NSID_"> <object
					id=EM_JCOMP_SCED_DT_D classid=<%=Util.CLSID_EMEDIT%> width=100
					tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
			</tr>
			<tr>
				<th>자택전화</th>
				<td><comment id="_NSID_"> <object id=EM_HOME_PH_D
					classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
				</td>
				<th>휴대전화</th>
				<td><comment id="_NSID_"> <object id=EM_MOBILE_PH_D
					classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
				</td>
				<th>회원등급</th>
				<td><comment id="_NSID_"> <object id=EM_GRADE_NM_D
					classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
				</td>
			</tr>
			<tr>
				<th>통화자</th>
				<td><comment id="_NSID_"> <object id=EM_CALL_NAME_D
					classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
				</td>
				<th>통화일시</th>
				<td colspan="3"><comment id="_NSID_"> <object id=EM_CALL_DATE_D
					classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
				</td>
			</tr>
			<tr>
				<th class="point" width="80">메모내용</th>
				<td colspan="5"><comment id="_NSID_"> <object
					id=TXT_CALL_DESC_D classid=<%=Util.CLSID_TEXTAREA%>
					style="width: 100%; height: 45px;" tabindex=1
					onkeyup="javascript:checkByteStr(TXT_CALL_DESC_D, 400,'Y');">
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
<comment id="_NSID_">
<object id=BD_DETAIL classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_DETAIL>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=CUST_ID        ctrl=EM_CUST_ID_D         Param=Text</c>
            <c>col=CUST_NAME      ctrl=EM_CUST_NAME_D       Param=Text</c>
            <c>col=BRCH_NAME      ctrl=EM_BRCH_NAME_D       Param=Text</c>
            <c>col=JCOMP_SCED_DT  ctrl=EM_JCOMP_SCED_DT_D   Param=Text</c>
            <c>col=HOME_PH1       ctrl=EM_HOME_PH_D         Param=Text</c>
            <c>col=MOBILE_PH1     ctrl=EM_MOBILE_PH_D       Param=Text</c>
            <c>col=GRADE_NM       ctrl=EM_GRADE_NM_D        Param=Text</c>
            <c>col=CALL_DATE      ctrl=EM_CALL_DATE_D       Param=Text</c>
            <c>col=CALL_NAME      ctrl=EM_CALL_NAME_D       Param=Text</c>
            <c>col=CALL_DESC      ctrl=TXT_CALL_DESC_D      Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
