<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 카드청구 > 청구제외조회
 * 작 성 일 : 2010.05.25
 * 작 성 자 : 김영진
 * 수 정 자 : 
 * 파 일 명 : psal9120.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.05.25 (김영진) 신규작성
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
	request.setCharacterEncoding("utf-8");
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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작   *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strChangFlag      = false;
var bfListRowPosition = 0;                             // 이전 List Row Position
var EXCEL_PARAMS = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-25
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
          
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    
    
    //그리드 초기화
    gridCreate1();  
    gridCreate2(); 
    
    initEmEdit(EM_REG_DT_S,    "YYYYMMDD",  PK);           //청구제외 시작기간    
    initEmEdit(EM_REG_DT_E,    "TODAY",     PK);           //청구제외 종료기간
    initEmEdit(EM_DUE_DT_S,    "YYYYMMDD",  PK);           //청구예정 시작기간    
    initEmEdit(EM_DUE_DT_E,    "YYYYMMDD",     PK);           //청구예정 종료기간
    EM_DUE_DT_E.text = "99991231";
    initComboStyle(LC_S_STR, DS_O_S_STR, "CODE^0^30,NAME^0^80", 1, PK);
    initComboStyle(LC_COND_BCOMP_CD, DS_O_COND_CARDCOMP_CODE, "CODE^0^20,NAME^0^100", 1, NORMAL);

    getStore("DS_O_S_STR", "Y", "", "N");
    getBcompCode("DS_O_COND_CARDCOMP_CODE", "", "", "Y");    
    
    
    EM_REG_DT_S.text = <%=strToMonth%>;
    EM_DUE_DT_S.text = <%=strToMonth%>;

    setComboData(LC_COND_BCOMP_CD,  "%");
    LC_S_STR.Index = 0; 
    
    initComboStyle(LC_COND_CHRG_YN, DS_COND_CHRG_YN, "CODE^0^20,NAME^0^100", 1, NORMAL);
    DS_COND_CHRG_YN.setDataHeader('CODE:STRING(2), NAME:STRING(8)');
    DS_COND_CHRG_YN.ClearData();
    DS_COND_CHRG_YN.Addrow();
    DS_COND_CHRG_YN.NameValue(1, "CODE")          = '%';
    DS_COND_CHRG_YN.NameValue(1, "NAME")          = '전체';
    DS_COND_CHRG_YN.Addrow();
    DS_COND_CHRG_YN.NameValue(2, "CODE")          = 'Y';
    DS_COND_CHRG_YN.NameValue(2, "NAME")          = '청구';
    DS_COND_CHRG_YN.Addrow();
    DS_COND_CHRG_YN.NameValue(3, "CODE")          = 'N';
    DS_COND_CHRG_YN.NameValue(3, "NAME")          = '미청구';    
    setComboData(LC_COND_CHRG_YN,  "%");
    
    //화면 OPEN시 조회
    btn_Search();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"               width=30       align=center</FC>'                                                    
                     + '<FC>id=STR_CD      name="점포 코드"         width=100      align=center    show=false</FC>'                                                    
                     + '<FC>id=STR_NM      name="점포명"           width=130      align=left</FC>'                                                    
                     + '<FC>id=REG_DT      name="청구제외일자"      width=100     align=center    mask="XXXX/XX/XX"</FC>'                                                    
                     + '<FC>id=DUE_DT      name="청구예정일자"      width=100     align=center    mask="XXXX/XX/XX"</FC>'                                        
                     + '<FC>id=BCOMP_CD    name="카드매입사코드"    width=90      align=center     show=false</FC>'                                        
                     + '<FC>id=BCOMP_NM    name="카드매입사"        width=90      align=center     show=false</FC>'                                        
                     + '<FC>id=REG_COUNT   name="청구보류등록건수"  width=120      align=right</FC>'                                        
                     + '<FC>id=BUY_COUNT   name="청구건수"          width=100      align=right</FC>'
                     + '<FC>id=REST_COUNT  name="청구잔여건수"      width=100      align=right</FC>'
                     + '<FC>id=ERR_COUNT   name="청구누락건수"      width=100      align=right</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}    name="NO"                width=30      align=center</FC>'                                                              
                     + '<FC>id=RECP_NO     name="영수증번호"        width=120     align=center</FC>'                                                              
                     + '<FC>id=APPR_AMT    name="총매출"            width=120     align=right</FC>'                                                              
                     + '<FC>id=CARD_NO     name="카드번호"          width=170     align=center     mask="XXXX-XXXX-XXXX-XXXX-XXXX"</FC>'                                                              
                     + '<FC>id=CCOMP_CD    name="카드발급사코드"    width=230     align=center     show=false</FC>'                                                  
                     + '<FC>id=CCOMP_NM    name="카드발급사"        width=90      align=left</FC>'                                                  
                     + '<FC>id=APPR_NO     name="승인번호"          width=90      align=center</FC>'                                                  
                     + '<FC>id=DIV_MONTH   name="할부"              width=50      align=right</FC>'                                                  
                     + '<FC>id=BCOMP_CD    name="카드매입사"        width=90      align=center     show=false</FC>'          
                     + '<FC>id=BCOMP_NM    name="카드매입사"        width=90      align=left</FC>'          
                     + '<FC>id=REG_DT      name="청구제외일자"      width=90      align=center      mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=REASON_CD   name="청구제외사유코드"  width=90      align=left        show=false</FC>'
                     + '<FC>id=REASON_NM   name="청구제외사유"      width=150     align=left</FC>'
                     + '<FC>id=DUE_DT      name="청구예정일자"      width=90      align=center      mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=CHRG_YN     name="상태"             width=90      align=center</FC>';
                     
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
 * 작 성 일 : 2010-05-25
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
     
    if(trim( EM_REG_DT_S.Text).length == 0){          //청구제외 시작일
        showMessage(EXCLAMATION, OK, "USER-1001","청구제외일자");
        EM_REG_DT_S.Focus();
        return;
    }
    if(trim(EM_REG_DT_E.Text).length == 0){           //청구제외 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","청구제외일자");
        EM_REG_DT_E.Focus();
        return;
    }
    if( EM_REG_DT_S.Text > EM_REG_DT_E.Text){         //조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_REG_DT_S.Focus();
        return;
    }
    
    if(trim( EM_DUE_DT_S.Text).length == 0){          //청구예정 시작일
        showMessage(EXCLAMATION, OK, "USER-1001","청구예정일자");
        EM_DUE_DT_S.Focus();
        return;
    }
    if(trim(EM_DUE_DT_E.Text).length == 0){          //청구예정 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","청구예정일자");
        EM_DUE_DT_E.Focus();
        return;
    }
    if( EM_DUE_DT_S.Text > EM_DUE_DT_E.Text){        //조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_DUE_DT_S.Focus();
        return;
    }
    
    showMaster();
 }

/**
 * btn_Excel()
 * 작  성 자    : 김영진
 * 작  성 일    : 2010-05-25
 * 개        요    : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
        
    if(DS_O_MASTER.CountRow == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회 후 엑셀다운 하십시오.");
        return false;
    }

    var ExcelTitle = "청구제외조회";
    openExcel2(GR_MASTER, ExcelTitle, EXCEL_PARAMS, true );
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-25
 * 개       요     : 조회시 호출
 * return값 : void
 */
function showMaster(){

    var strRegDtS   = EM_REG_DT_S.Text; 
    var strRegDtE   = EM_REG_DT_E.Text; 
    var strDueDtS   = EM_DUE_DT_S.Text; 
    var strDueDtE   = EM_DUE_DT_E.Text; 
    var strCondStrCd= LC_S_STR.BindColVal;
    var strBcompCd  = LC_COND_BCOMP_CD.BindColVal;
    var strChrgYn   = LC_COND_CHRG_YN.BindColVal;
    
    EXCEL_PARAMS = "조회구분="       + LC_COND_CHRG_YN.Text
                 + " -점포명="       + LC_S_STR.Text
                 + " -카드매입사="   + LC_COND_BCOMP_CD.Text
                 + " -청구제외일자=" + strRegDtS
                 + "~" + strRegDtE
                 + " -청구예정일자=" + strDueDtS
                 + "~" + strDueDtE;

    var goTo        = "searchMaster";    
    var action      = "O";   
    var parameters  = "&strRegDtS="    + encodeURIComponent(strRegDtS)
                    + "&strRegDtE="    + encodeURIComponent(strRegDtE)
                    + "&strDueDtS="    + encodeURIComponent(strDueDtS)
                    + "&strDueDtE="    + encodeURIComponent(strDueDtE)
                    + "&strCondStrCd=" + encodeURIComponent(strCondStrCd)
                    + "&strBcompCd="   + encodeURIComponent(strBcompCd)
                    + "&strChrgYn="    + encodeURIComponent(strChrgYn);
    
    TR_MAIN.Action  = "/dps/psal912.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    if (DS_O_MASTER.CountRow > 0 ) {
        GR_MASTER.Focus();        
    }else{
    	LC_COND_CHRG_YN.Focus();
    }
    
    bfListRowPosition = 0;
} 
/**
 * doOnClick()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-25
 * 개       요 : 선택된 클럽관리 정보 상세 조회 
 * return값 : void
 */
function doClick(row){
     
    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;
     
    var strRegDt    = DS_O_MASTER.NameValue(row ,"REG_DT");
    var strDueDt    = DS_O_MASTER.NameValue(row ,"DUE_DT");
    var strCondStrCd= DS_O_MASTER.NameValue(row ,"STR_CD");
    var strBcompCd  = DS_O_MASTER.NameValue(row ,"BCOMP_CD");

    var goTo        = "searchDetail";    
    var action      = "O";     
    var parameters  = "&strRegDt="     + encodeURIComponent(strRegDt)
                    + "&strDueDt="     + encodeURIComponent(strDueDt)
                    + "&strCondStrCd=" + encodeURIComponent(strCondStrCd)
                    + "&strBcompCd="   + encodeURIComponent(strBcompCd);
    
    TR_DETAIL.Action  = "/dps/psal912.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
}  
-->
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                        *-->
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
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
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
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
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

<!-- 청구제외일자 Start onKillFocus() -->
<script language=JavaScript for=EM_REG_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_REG_DT_S)){
    	EM_REG_DT_S.text = <%=strToMonth%>;
    }
</script>
    
<!-- 청구제외일자 End onKillFocus() -->
<script language=JavaScript for=EM_REG_DT_E event=onKillFocus()>
    if(!checkDateTypeYMD(EM_REG_DT_E)){
        initEmEdit(EM_REG_DT_E,    "TODAY",     PK);         
    }
</script>  

<!-- 청구예정일자 Start onKillFocus() -->
<script language=JavaScript for=EM_DUE_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_DUE_DT_S)){
    	EM_DUE_DT_S.text = <%=strToMonth%>;
    }
</script>
    
<!-- 청구예정일자 End onKillFocus() -->
<script language=JavaScript for=EM_DUE_DT_E event=onKillFocus()>
    if(!checkDateTypeYMD(EM_DUE_DT_E)){
        initEmEdit(EM_DUE_DT_E,    "TODAY",     PK);   
    }
</script>  

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
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
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_S_STR" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_COND_CARDCOMP_CODE" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_CHRG_YN" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>> </object>
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
				<td><!-- search start -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80">조회구분</th>
						<td width="200"><comment id="_NSID_"> <object
                            id=LC_COND_CHRG_YN classid=<%=Util.CLSID_LUXECOMBO%> width=158
                            align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
						<th width="80" class="point">점포명</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LC_S_STR classid=<%=Util.CLSID_LUXECOMBO%> width=158
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">카드매입사</th>
						<td><comment id="_NSID_"> <object
							id=LC_COND_BCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=120
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width="80" class="point">청구제외일자</th>
						<td width="200"><comment id="_NSID_"> <object id=EM_REG_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_REG_DT_S)" />- <comment
							id="_NSID_"> <object id=EM_REG_DT_E
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_REG_DT_E)" /></td>
						<th width="80" class="point">청구예정일자</th>
						<td colspan="3"><comment id="_NSID_"> <object id=EM_DUE_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_DUE_DT_S)" />- <comment
							id="_NSID_"> <object id=EM_DUE_DT_E
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_DUE_DT_E)" /></td>
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
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=250 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_DETAIL
					width="100%" height=224 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_DETAIL">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
</body>
</html>
