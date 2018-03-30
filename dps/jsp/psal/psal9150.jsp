<!-- 
/*******************************************************************************
 * 시스템명 : 타사카드  > 청구관리 > 청구대상 데이터 마감
 * 작  성  일  : 2010.05.31
 * 작  성  자  : 
 * 수  정  자  : 
 * 파  일  명  : psal9150.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.05.31 (김영진) 신규작성
 *           2011.07.28 fkl 수정
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="common.vo.SessionInfo" %>
<%@ page import="common.util.Util"  %>
<%@ page import="kr.fujitsu.ffw.base.BaseProperty"  %>

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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strExlParam = "";
var bfListRowPosition = 0;                             // 이전 List Row Position
var strToday = '<%=Util.getToday("yyyyMMdd")%>'
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010.05.31
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    //Input, Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //디테일
    
    //EMedit에 초기화
    initEmEdit(EM_JBRCH_ID,    "GEN^15",               NORMAL);  

    initComboStyle(LC_STR_CD,   DS_STR_CD,   "CODE^0^30,NAME^0^80", 1, PK);
    initComboStyle(LC_BCOMP_CD, DS_BCOMP_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);

    getStore("DS_STR_CD", "Y", "", "N");
    getBcompCode("DS_BCOMP_CD", "", "", "Y");

    //초기값설정
    setComboData(LC_STR_CD,  DS_STR_CD.NameValue(0, "CODE")); 
    setComboData(LC_BCOMP_CD,  "%"); 

    //showMaster();
}

function gridCreate1(){
    var hdrProperies    = '<FC>id={currow}     name="NO"              width=30   edit=none  align=center</FC>'
    	                + '<FC>id=CHECK1       name="선택"            width=40    align=center   HeadCheckShow=false EditStyle=CheckBox  edit=true</FC>'
    	                + '<FC>id=PROC_DT      name="처리일시"        width=80  edit=none  align=center    mask="XXXX-XX-XX"</FC>'
    	                + '<FC>id=STR_CD       name="시설구분"         width=145  edit=none  align=center  show="false"</FC>'
                        + '<FC>id=BCOMP_CD     name="카드매입사코드"   width=145  edit=none  align=center  show="false"</FC>'
                        + '<FC>id=BCOMP_NM     name="카드매입사"       width=145  edit=none  align=center</FC>'
                        + '<FC>id=JBRCH_ID     name="가맹점번호"       width=145  edit=none  align=center</FC>'
                        + '<FC>id=APPR_COUNT   name="승인건수"         width=100  edit=none  align=right</FC>'
                        + '<FC>id=APPR_AMT     name="승인금액"         width=145  edit=none  align=right</FC>'
                        + '<FC>id=HOLD_YN      name="청구보류여부"     width=80    align=center   edit=none</FC>';                     
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
}

function gridCreate2(){
    var hdrProperies    = '<FC>id={currow}     name="NO"              width=30   align=center</FC>'
                        + '<FC>id=REC_FLAG     name="레코드구분"       width=70   align=center</FC>'
                        + '<FC>id=DEVICE_ID    name="단말기번호"       width=70   align=center</FC>'
                        + '<FC>id=WORK_FLAG    name="작업구분"         width=60   align=center show=false</FC>'
                        + '<FC>id=WORK_FLAG_NM name="작업구분"         width=100  align=left</FC>'
                        + '<FC>id=COMP_NO      name="사업자번호"       width=100  align=center mask="XXX-XX-XXXXX"</FC>'
                        + '<FC>id=CARD_NO      name="카드번호"         width=170  align=center mask="XXXX-XXXX-XXXX-XXXX-XXXX"</FC>'
                        + '<FC>id=EXP_DT       name="유효기간"         width=100  align=center mask="XX/XX"</FC>'
                        + '<FC>id=DIV_MONTH    name="할부"             width=40   align=right</FC>'
                        + '<FC>id=APPR_AMT     name="승인금액"         width=100   align=right</FC>'
                        + '<FC>id=SVC_AMT      name="봉사료"           width=90   align=right</FC>'
                        + '<FC>id=APPR_NO      name="승인번호"         width=80   align=center</FC>'
                        + '<FC>id=APPR_DT      name="승인일자"         width=80   align=center mask="XXXX/XX/XX"</FC>'
                        + '<FC>id=APPR_TIME    name="승인시간"         width=80   align=center mask="XX:XX"</FC>'
                        + '<FC>id=CAN_DT       name="취소일자"         width=80   align=center mask="XXXX/XX/XX"</FC>'
                        + '<FC>id=CAN_TIME     name="취소시간"         width=80   align=center mask="XX:XX" show=false</FC>'
                        + '<FC>id=CCOMP_NM     name="발급사코드/명"    width=100  align=left</FC>'
                        + '<FC>id=BCOMP_NM     name="매입사코드/명"    width=100  align=left</FC>'
                        + '<FC>id=JBRCH_ID     name="가맹점번호"       width=80   align=center</FC>'
                        + '<FC>id=DOLLAR_FLAG  name="달러구분"         width=80   align=center</FC>'
                        + '<FC>id=FILLER       name="Filler"          width=100   align=left</FC>';
                     
    initGridStyle(GD_DETAIL, "common", hdrProperies, false);
}
/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010.05.31
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(trim(LC_STR_CD.BindColVal).length == 0){
	    showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
	    LC_STR_CD.Focus();
	    return false;
	}
   
    //조회
    showMaster();
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : DB에 저장 / 수정 
 * return값 : void
*/
function btn_Save() {
	// 저장할 데이터 없는 경우
    if (!DS_O_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(INFORMATION , OK, "USER-1028"); 
        return;
    } 
	/*
    for( var i=1; i<=DS_O_MASTER.CountRow; i++){
    	var strCheck      = DS_O_MASTER.NameValue(i, "CHECK1");
    	var strDueDt      = DS_O_MASTER.NameValue(i, "DUE_DT");
    	
    	if (strDueDt == "" && strCheck == "T"){
            showMessage(EXCLAMATION, Ok,  "USER-1003", "청구예정일자");            
            setFocusGrid(GD_MASTER,DS_O_MASTER,i,"DUE_DT");
            return;
        }
    	
    	if(strCheck == "F" && DS_O_MASTER.IsUpdated && strDueDt != ""){
    		showMessage(EXCLAMATION, Ok,  "USER-1041", "선택 체크 여부");            
            setFocusGrid(GD_MASTER,DS_O_MASTER,i,"CHECK1");
            return;
    	}
    }*/
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION , YESNO, "USER-1010") != 1 )
        return;
    
    var strStrCd   = LC_STR_CD.BindColVal;
    var parameters  = "&strStrCd="   + encodeURIComponent(strStrCd);
    
    TR_MAIN.Action="/dps/psal915.ps?goTo=save"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();        
    }else{
    	setFocusGrid(GD_MASTER,DS_O_MASTER,DS_O_MASTER.RowPosition,"CHECK1");
    }
 }
 
/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {	
	    // 선택한 항목을 삭제하겠습니까?
	    if( showMessage(INFORMATION, YESNO, "USER-1023") != 1 ){
	        GD_MASTER.Focus();
	        return;
	    }  
	    //alert(1);
	    DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition); 
	    
	    // parameters
	    //alert(2);
	    var goTo = "delete";
	    
	    TR_MAIN.Action = "/dps/psal915.ps?goTo=" + goTo;
	    TR_MAIN.KeyValue = "SERVLET(I:DS_O_MASTER=DS_O_MASTER)";
	    TR_MAIN.Post();
	    //alert(3);
	
}

/**
 * btn_Excel()
 * 작   성   자 : 김영진
 * 작   성   일 : 2010.05.31
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    var ExcelTitle = "청구대상 데이터 마감";
    //openExcel3(GD_MASTER, GD_DETAIL, ExcelTitle, strExlParam, '', '');
    openExcel2(GD_MASTER, ExcelTitle, strExlParam, true );
    GD_MASTER.Focus();
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010.05.31
 * 개       요     : 청구대상 데이터 조회 
 * return값 : void
 */
function showMaster(){    
	 
	var strStrCd   = LC_STR_CD.BindColVal;	
		
	var strBcompCd = LC_BCOMP_CD.BindColVal;
	var strJbrchId = EM_JBRCH_ID.Text;  
	var strDueDtYn   = "";
	if (CHK_DUE_DT_YN.checked) {
		strDueDtYn = "Y";
    }
	
	strExlParam = "점포명="       + LC_STR_CD.Text
                + " -카드매입사=" + LC_BCOMP_CD.Text
                + " -가맹점번호=" + strJbrchId;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strStrCd="   + encodeURIComponent(strStrCd)
                    + "&strBcompCd=" + encodeURIComponent(strBcompCd)
                    + "&strJbrchId=" + encodeURIComponent(strJbrchId)
                    + "&strDueDtYn=" + encodeURIComponent(strDueDtYn);
    
    TR_MAIN.Action  ="/dps/psal915.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //그리드 첫 row 상세조회
    if(DS_O_MASTER.CountRow > 0){
        GD_MASTER.Focus();
        showDetail();
    }else{
    	LC_STR_CD.Focus();
    }
    
    bfListRowPosition = 0;

    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * showDetail()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-02-21
 * 개       요 : 선택된 상세 조회
 * return값 : void
 */
function showDetail(){
      
    //var strApprDt    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition ,"APPR_DT");
    var strStrCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition ,"STR_CD");
    //var strApprNo    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition ,"APPR_NO");
    var strBcompCd   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition ,"BCOMP_CD");
    var strJbrchId   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition ,"JBRCH_ID");
    
    var goTo        = "searchDetail";    
    var action      = "O";     
    var parameters  = "&strStrCd="   +  encodeURIComponent(strStrCd)                         
                    + "&strBcompCd=" +  encodeURIComponent(strBcompCd)
                    + "&strJbrchId=" +  encodeURIComponent(strJbrchId);
    
    TR_DETAIL.Action  = "/dps/psal915.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
    if(DS_O_DETAIL.CountRow > 1){
        setPorcCount("SELECT", DS_O_DETAIL.CountRow);
    }
}   

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.05.31
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
	 /*
     EM_CCOMP_NM.Text = "";//조건입력시 코드초기화
    if (EM_CCOMP_CD.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_CCOMP_CD.Text.length == 2) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_CARDBIN", EM_CCOMP_CD.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
                EM_CCOMP_CD.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
                EM_CCOMP_NM.Text   = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getCcompPop(EM_CCOMP_CD, EM_CCOMP_NM);
            }
        }
    }
     */
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
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<!-- 카드발급사 onKillFocus() 
<script language=JavaScript for=EM_CCOMP_CD event=onKillFocus()>
    if ((EM_CCOMP_CD.Modified) && (EM_CCOMP_CD.Text.length != 2)) {
        EM_CCOMP_NM.Text = "";
    }
</script>
-->

<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    switch (colid) { 
    case "DUE_DT":
        openCal(GD_MASTER, row, colid, "G");   //그리드 달력    
        break;
} 
</script>

<script language=JavaScript for=DS_O_MASTER event=OnColumnChanged(row,colid)> 
    if(row < 1)
        return true;
    
    switch(colid){
    case "DUE_DT":    	
        if (DS_O_MASTER.NameValue(row, "DUE_DT") == ""){
        	setFocusGrid(GD_MASTER,DS_O_MASTER,row,"DUE_DT");
        	return true;  
        }       
            
        if(!checkDateTypeYMD(GD_MASTER,colid,'')) {
        	setFocusGrid(GD_MASTER,DS_O_MASTER,row,"DUE_DT");
        	DS_O_MASTER.NameValue(row, "DUE_DT") = strToday;
        	return;
        }    
            
        if(DS_O_MASTER.NameValue(row, "DUE_DT") < strToday) {
        	setFocusGrid(GD_MASTER,DS_O_MASTER,row,"DUE_DT");
        	showMessage(EXCLAMATION, Ok,  "USER-1030", "청구예정일자");
        	DS_O_MASTER.NameValue(row, "DUE_DT") = strToday;
        	return;
        }    
        break; 
    }
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    //그리드 첫 row 상세조회
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        showDetail();
    }else{
        DS_O_DETAIL.ClearData();
    }
</script>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>    
    sortColId(eval(this.DataID), row, colid);
</script>
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리    끝                                                                                                                               *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                             *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_BCOMP_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

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
<!--* E. 본문시작                                                                                                                                                              *-->
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
						<th width="140" class="point">점포명</th>
						<td width="170"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=165
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>				
						<th width="140">매입사</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=LC_BCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=165
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>						
						<th width="140">가맹점번호</th>
						<td width="170"><comment id="_NSID_"> <object
							id=EM_JBRCH_ID classid=<%=Util.CLSID_EMEDIT%> width=170
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="140">당일청구보류조회</th>
						<td colspan="3"><input type="checkbox" id="CHK_DUE_DT_YN" tabindex=1></td>
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
    <tr>
        <td></td>
    </tr>
    <tr valign="top">
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"> <object id=GD_MASTER
                    width="100%" height=250 classid=<%=Util.CLSID_GRID%> tabindex=1>
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
                <td><object id=GD_DETAIL width="100%" height=222
                    classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_O_DETAIL">
                </object></td>
            </tr>
        </table>
        </td>
    </tr>

</table>
</div>
<body>
</html>

