<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 회원관리 > 무기명카드 발급매수 등록
 * 작 성 일 : 2010.01.14
 * 작 성 자 : 김영진
 * 수 정 자 : 
 * 파 일 명 : dctm0010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 무기명카드의 발급매수를 등록한다
 * 이    력 :
 *        2010.01.14 (김영진) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
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
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<%
	String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String toDate2 = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	toDate2 = toDate2 + "01";
%>
<script LANGUAGE="JavaScript">
<!--
var strChangFlag = false;
var bfListRowPosition = 0;                             // 이전 List Row Position
var strCardCreDt = "";
var strCardSeq   = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-12
 * 개       요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    // Input Data Set Header 초기화
	DS_IO_DATA.setdataHeader  ('<gauce:dataset name="H_INS"/>');
    // Output Data Set Header 초기화
    DS_O_MASTER.setdataHeader('<gauce:dataset name="H_MASTER"/>');
	DS_O_MASTER2.setdataHeader('<gauce:dataset name="H_MASTER2"/>');

    //그리드 초기화
    gridCreate1(); //마스터
	gridCreate2(); //내역
    
    // EMedit에 초기화
    initEmEdit(EM_FROM_DT,     "YYYYMMDD", PK);		   //조회기간
	initEmEdit(EM_TO_DT,       "YYYYMMDD", PK);		   //조회기간
	initEmEdit(EM_CARD_CRE_DT, "YYYYMMDD", READ);	   //카드발급일자
	initEmEdit(EM_CARD_SEQ,    "GEN^3",    READ);		
	initComboStyle(LC_CARD_GRADE,DS_O_CARD_GRADE, "CODE^0^30,NAME^0^100", 1, PK);    //카드등급
	initEmEdit(EM_CDREG_CNT, "NUMBER^6^0", PK);     //무기명카드발급매수
	    
	EM_FROM_DT.Text = "<%=toDate2%>";
	EM_TO_DT.Text   = "<%=toDate%>";
	EM_CARD_CRE_DT.Text = "<%=toDate%>";

	getEtcCode("DS_O_CARD_GRADE", "D", "D011", "N");
	setComboData(LC_CARD_GRADE,"");
    GD_MASTER2.Visible = "false";

    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dctm101","DS_O_MASTER,DS_O_MASTER2");
    
    //화면 OPEN 시 조회
    showMaster();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}			    name="NO"				width=30	align=center</FC>'
                     + '<FC>id=CARD_CRE_DT          name="카드발급일자"     Mask="XXXX/XX/XX" width=90	align=center</FC>'
                     + '<FC>id=CARD_CRE_SEQ			name="순번"				width=45	align=center</FC>'
                     + '<FC>id=CARD_GRADE			name="카드등급"			width="100" </FC>'
					 + '<FC>id=CARD_QTY				name="카드발급매수"		width="80" </FC>'
					 + '<FC>id=S_CARD_NO			name="시작카드번호"		Mask="XXXX-XXXX-XXXX-XXXX" align=center width="160" </FC>'
					 + '<FC>id=E_CARD_NO			name="종료카드번호"		Mask="XXXX-XXXX-XXXX-XXXX" align=center width="160" </FC>'
					 + '<FC>id=CARD_CNT				name="카드번호건수"		width="115" </FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies = '<FC>id=CARD_NO			name="카드번호"		Mask="XXXX-XXXX-XXXX-XXXX" align=center width="160" </FC>'
                     + '<FC>id=CARD_GRADE		name="등급코드"		align=center width="80" </FC>'
                     + '<FC>id=CARD_GRADE_NM	name="등급"		    align=center width="100" </FC>';
                     
    initGridStyle(GD_MASTER2, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-16
 * 개       요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	 if ( strChangFlag == false && (DS_O_MASTER.IsUpdated || DS_IO_DATA.IsUpdated )){
        if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
          setTimeout("LC_CARD_GRADE.Focus();",50);
            return false;
        }else{
          strChangFlag = true;
        }
    }
    if(trim(EM_FROM_DT.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_FROM_DT.Focus();
        return;
    }
    if(trim(EM_TO_DT.Text).length == 0){    // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_TO_DT.Focus();
        return;
    }
	if(EM_FROM_DT.text > EM_TO_DT.text){
	    showMessage(EXCLAMATION, OK, "USER-1000",  "조회종료일자가 조회시작일자보다 작습니다.");
	    EM_FROM_DT.Focus();
	    return false;
	}	    
	showMaster();
	strChangFlag = true;
}

/**
 * btn_New()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-16
 * 개       요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {

	if ( strChangFlag == false && DS_O_MASTER.IsUpdated || DS_IO_DATA.IsUpdated ){
        if(showMessage(EXCLAMATION, YESNO, "USER-1072") != 1 ){
            setTimeout("LC_CARD_GRADE.Focus();",50);
            return false;
        }else{
            strChangFlag = true;
            if(DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "CARD_CRE_DT") == ""){
                DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition);
            }
        }
    }
    DS_O_MASTER.Addrow(); 
    DS_IO_DATA.ClearData();
    DS_IO_DATA.Addrow();
    newData();
}

/**
 * btn_Delete()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-16
 * 개       요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
	
	if(DS_O_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1019");
        return false;
    } 
	
	if(EM_CARD_SEQ.Text == ""){
		showMessage(EXCLAMATION, OK, "USER-1000",  "삭제할 ROW를 선택 바랍니다.");
		return false;
	}
	if(EM_CARD_CRE_DT.Text!="<%=toDate%>"){
		showMessage(EXCLAMATION, OK, "USER-1000",  "오늘 이전에 발급된 카드번호는 삭제할 수 없습니다.");
		return false;
	}
    if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
        return;
    }
    delData();
    btn_Search();
    strChangFlag = true;
}

/**
 * btn_Save()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-16
 * 개       요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

    if(EM_CARD_SEQ.Text != ""){
        showMessage(EXCLAMATION, OK, "USER-1000",  "신규버튼 클릭 후에 저장하시기 바랍니다.");
        return false;
    }
	if(LC_CARD_GRADE.BindColVal == ""){
		showMessage(EXCLAMATION, OK, "USER-1003",  "카드등급");
		LC_CARD_GRADE.Focus();
		return false;
	}
	if(EM_CDREG_CNT.Text == ""){
		showMessage(EXCLAMATION, OK, "USER-1003",  "카드발급매수");
		EM_CDREG_CNT.Focus();
		return false;
	}
	//카드발급매수 제한 300,000장
	var intCdregCnt = eval(EM_CDREG_CNT.Text);
	if(intCdregCnt > 300000){
		showMessage(EXCLAMATION, OK, "USER-1000",  "카드발급 1회 매수는 300,000장 이하입니다.");
        return false;
	}
	
    //저장여부 QUESTION
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
    
	saveData();
	showMaster();
	strChangFlag = true;
}

/**
 * btn_Excel()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-16
 * 개       요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

	if(EM_CARD_SEQ.Text == ""){
		showMessage(EXCLAMATION, OK, "USER-1000",  "엑셀로 저장할 발급내역을 클릭 후 엑셀다운 하십시오.");
		return false;
	}
    showMaster2();
    var parameters = "카드번호발급일자=" + strCardCreDt
                   + " -순번="          + strCardSeq;

    //var ExcelTitle = "무기명카드 발급내역"
    var ExcelTitle = "보너스카드 발급내역"
    openExcel2(GD_MASTER2, ExcelTitle, parameters, true );
  
    GD_MASTER.Focus();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
* saveData()
* 작 성 자 : 김영진
* 작 성 일 : 2010-02-16
* 개       요 : 카드발급매수등록
* return값 : void
*/
function saveData(){	
	TR_MAIN.Action="/dcs/dctm101.dm?goTo=saveData";
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_DATA=DS_IO_DATA)";
    searchSetWait("B");
    TR_MAIN.Post();  
    bfListRowPosition = 0;

}

/**
* delData()
* 작 성 자 : 김영진
* 작 성 일 : 2010-02-16
* 개       요 : 카드발급매수 삭제
* return값 : void
*/
function delData(){	

	//날짜와 순번보내기...
	var strCardCreDt = EM_CARD_CRE_DT.Text;
	var strCardSeq	 = EM_CARD_SEQ.Text;
	var strCardCnt	 = EM_CDREG_CNT.Text;
	var parameters = "&strCardCreDt="+encodeURIComponent(strCardCreDt)+
					 "&strCardSeq="+encodeURIComponent(strCardSeq)+
					 "&strCardCnt="+encodeURIComponent(strCardCnt);
	TR_MAIN.Action="/dcs/dctm101.dm?goTo=delData"+parameters;
    TR_MAIN.Post();  
    DS_IO_DATA.ClearData();
    bfListRowPosition = 0;

}

/**
* showMaster()
* 작 성 자 : 김영진
* 작 성 일 : 2010-02-16
* 개       요 : 무기명카드 발급매수 조회
* return값 : void
*/
function showMaster(){

    var strFromDt  = EM_FROM_DT.text;
	var strToDt    = EM_TO_DT.text;
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strFromDt="+encodeURIComponent(strFromDt)+
    				 "&strToDt="+encodeURIComponent(strToDt);
    TR_MAIN.Action="/dcs/dctm101.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)";
    TR_MAIN.Post();

    if(DS_O_MASTER.CountRow > 0){
        GD_MASTER.Focus();
    }else{
        EM_FROM_DT.Focus();
    }
    //선택비활성화
    LC_CARD_GRADE.Enable = false;
    EM_CDREG_CNT.Enable  = false;
    bfListRowPosition = 0;
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
* showMaster2()
* 작 성 자 : 김영진
* 작 성 일 : 2010-02-16
* 개    요 : 무기명카드 발급 내역조회
* return값 : void
*/
function showMaster2(){

	strCardCreDt = EM_CARD_CRE_DT.Text;
	strCardSeq	 = EM_CARD_SEQ.Text;
    var goTo       = "searchMaster2" ;    
    var action     = "O";     
    var parameters = "&strCardCreDt="+encodeURIComponent(strCardCreDt)+"&strCardSeq="+encodeURIComponent(strCardSeq);
    TR_MAIN.Action="/dcs/dctm101.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER2=DS_O_MASTER2)";
    TR_MAIN.Post();

}

/**
  * doClick()
  * 작 성 자 : 김영진
  * 작 성 일 : 2010-02-11
  * 개       요 : 선택된 카드발급 내역 조회 
  * return값 : void
  */
 function doClick(row){
     if( row == undefined ) {
		row = DS_O_MASTER.RowPosition;
     }
	
     var strCardCreDt = DS_O_MASTER.NameValue(row ,"CARD_CRE_DT");
     var strCardSeq   = DS_O_MASTER.NameValue(row ,"CARD_CRE_SEQ"); 
     var goTo       = "searchDetail" ;    
     var action     = "O";     
     var parameters = "&strCardCreDt="+encodeURIComponent(strCardCreDt)+"&strCardSeq="+encodeURIComponent(strCardSeq);
     TR_DETAIL.Action="/dcs/dctm101.dm?goTo="+goTo+parameters;  
     TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DATA=DS_IO_DATA)";
     TR_DETAIL.Post();
     
}

/**
 * newData()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.04.13
 * 개      요  : 설정 초기화 
 * return값 :
 */
function newData(){
    //DS_IO_DATA.NameValue(DS_IO_DATA.RowPosition, "" )  = EM_CARD_CRE_DT.Text;         // 카드번호발급일자
    EM_CARD_CRE_DT.Text = "<%=toDate%>";
    EM_CARD_SEQ.Text = "";
    LC_CARD_GRADE.BindColVal = "";
    EM_CDREG_CNT.Text = "";
    LC_CARD_GRADE.Enable = true;
    EM_CDREG_CNT.Enable  = true;
    LC_CARD_GRADE.Focus();
    strChangFlag = false;
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
    searchDoneWait();
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
    searchDoneWait();
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
    if ( strChangFlag == false && (DS_O_MASTER.IsUpdated || DS_IO_DATA.IsUpdated)){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            setTimeout("LC_CARD_GRADE.Focus();",50);
            return false;
        }else {
            if(DS_O_MASTER.NameValue(row, "CARD_CRE_DT") == "")
                DS_O_MASTER.DeleteRow(row);
                LC_CARD_GRADE.Enable = false;
                EM_CDREG_CNT.Enable  = false;
            return true;
        }
    }else{
         return true;
    }
</script>
<!--DS_O_MASTER  OnRowPosChanged(row)(row,colid)-->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    if(clickSORT) return;
    //그리드 첫 row 상세조회
    if(row != 0){
    	if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        doClick(row);
    }else{
        DS_O_MASTER.ClearData();
        //설정초기화
        newData();
        EM_FROM_DT.Focus();
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_FROM_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_FROM_DT)){
    	EM_FROM_DT.Text = "<%=toDate2%>";
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_TO_DT event=onKillFocus()>
    checkDateTypeYMD(EM_TO_DT);
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->
<!-- 무기명카드 발급매수 Head sort oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_DATA" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_MASTER2" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CARD_GRADE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝 *-->
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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
							<th width="100" class="point">조회기간</th>
							<td><comment id="_NSID_"> <object id=EM_FROM_DT
								classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
								align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
								src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',EM_FROM_DT)" />- <comment
								id="_NSID_"> <object id=EM_TO_DT
								classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
								align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
								src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',EM_TO_DT)" /></td>
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
					<td><comment id="_NSID_"> <object id=GD_MASTER
						width="100%" height=422 classid=<%=Util.CLSID_GRID%> tabindex=1>
						<param name="DataID" value="DS_O_MASTER">
					</object> </comment> <script>_ws_(_NSID_);</script> <comment id="_NSID_"> <object
						id=GD_MASTER2 width="0" height=0 classid=<%=Util.CLSID_GRID%>>
						<param name="DataID" value="DS_O_MASTER2">
					</object> </comment> <script>_ws_(_NSID_);</script></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td class="PT03">
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				class="s_table">
				<tr>
					<th width="100">카드번호발급일자</th>
					<td><comment id="_NSID_"> <object id=EM_CARD_CRE_DT
						classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> - <comment
						id="_NSID_"> <object id=EM_CARD_SEQ
						classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
						src="/<%=dir%>/imgs/btn/add_cardnum_s.gif" align="absmiddle"
						onclick="javascript:btn_Save()" /></td>
				</tr>
				<tr>
					<th width="100" class="point">카드등급</th>
					<td><comment id="_NSID_"> <object id=LC_CARD_GRADE
						classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=130
						align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
					</td>
				</tr>
				<tr>
					<th width="100" class="point">카드발급매수</th>
					<td><comment id="_NSID_"> <object id=EM_CDREG_CNT
						classid=<%=Util.CLSID_EMEDIT%> width=126 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
					</td>
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
    <object id=BO_I_DATA classid=<%=Util.CLSID_BIND%>>
        <param name=DataID value=DS_IO_DATA>
        <param name="ActiveBind" value=true>
        <param name=BindInfo
            value='
            <c>col=CARD_CRE_DT            ctrl=EM_CARD_CRE_DT           Param=Text</c>
            <c>col=CARD_GRADE             ctrl=LC_CARD_GRADE            Param=BindColVal</c>
            <c>col=CARD_CNT               ctrl=EM_CDREG_CNT             Param=Text</c>
            <c>col=CARD_CRE_SEQ           ctrl=EM_CARD_SEQ              Param=Text</c>
        '>
    </object>
    </comment>
    <script>_ws_(_NSID_);</script>
</body>
</html>
