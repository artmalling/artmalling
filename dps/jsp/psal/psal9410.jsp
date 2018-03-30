<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 신용카드대금청구 > 실적조회 > 전자서명조회
 * 작  성  일  : 2010.06.09
 * 작  성  자  : 
 * 수  정  자  : 
 * 파  일  명  : psal9410.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.06.09 (김영진) 신규작성
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
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache"); 
	response.setDateHeader("Expires",0);

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
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var bfListRowPosition = 0;                             // 이전 List Row Position
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-09
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    // Input, Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    //EMedit에 초기화
    initEmEdit(EM_SALE_DT,     "TODAY",    PK);
    initEmEdit(EM_POS_NO,      "0000",     PK);
    initEmEdit(EM_TRAN_NO_S,   "00000",    NORMAL);
    initEmEdit(EM_TRAN_NO_E,   "00000",    NORMAL);  
    
    //조회용
    initEmEdit(EM_SALE_DT_I,   "0000/00/00",    READ);
    initEmEdit(EM_POS_NM_I,   "GEN^40",    READ);
    initEmEdit(EM_TRAN_NO_I,   "GEN^40",    READ);
    initEmEdit(EM_POS_SEQ_NO_I,   "GEN^40",    READ);
    initEmEdit(EM_WORK_FLAG_I,   "GEN^40",    READ);
    initEmEdit(EM_CARD_NO_I,   "0000-0000-0000-0000",    READ);
    initEmEdit(EM_EXP_DT_I,   "GEN^40",    READ);
    initEmEdit(EM_DIV_MONTH_I,     "GEN^40",    READ);
    initEmEdit(EM_APPR_AMT_I,      "GEN^40",    READ);
    initEmEdit(EM_SVC_AMT_I,       "GEN^40",    READ);
    initEmEdit(EM_APPR_NO_I,       "GEN^40",    READ);
    initEmEdit(EM_APPR_DT_I,       "0000/00/00",    READ);
    initEmEdit(EM_APPR_TIME_I,     "00:00:00",    READ);
    initEmEdit(EM_CAN_DT_I,        "0000/00/00",    READ);
    initEmEdit(EM_CAN_TIME_I,      "00:00:00",    READ);
    initEmEdit(EM_VAN_NM_I,        "GEN^40",    READ);
    initEmEdit(EM_CCOMP_NM_I,      "GEN^40",    READ);
    initEmEdit(EM_BCOMP_CD_I,      "GEN^40",    READ);
    initEmEdit(EM_JBRCH_ID_I,      "GEN^40",    READ);
    initEmEdit(EM_KEYIN_GB_I,      "GEN^40",    READ);
    initEmEdit(EM_FILLER_I,        "GEN^40",    READ);
    initEmEdit(EM_PAY_TYPE_NM_I,   "GEN^40",    READ);
    initEmEdit(EM_POS_FLAG_NM_I,   "GEN^40",    READ);    
    initEmEdit(EM_ORG_APPR_DT_I,   "0000/00/00",    READ);
    initEmEdit(EM_ORG_APPR_NO_I,   "GEN^40",    READ);
    initEmEdit(EM_ORG_POS_NO_I,    "GEN^40",    READ);
    initEmEdit(EM_ORG_SALE_DT_I,   "0000/00/00",    READ);
    initEmEdit(EM_ORG_TRAN_NO_I,   "GEN^40",    READ);
    initEmEdit(EM_SEND_DATE_I,     "0000/00/00",    READ);
    //initEmEdit(EM_SEND_STAT_I,     "GEN^40",    READ);

    initComboStyle(LC_STR_CD, DS_COND_STR_CD, "CODE^0^30, NAME^0^80", 1, PK);
    
    initComboStyle(LC_STR_CD_I, DS_STR_CD_I, "CODE^0^30, NAME^0^120", 1, READ);

    getStore("DS_COND_STR_CD", "Y", "", "N");
    getStore("DS_STR_CD_I", "Y", "", "N");

    //초기값설정
    setComboData(LC_STR_CD,  DS_COND_STR_CD.NameValue(0, "CODE"));
    
    LC_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies    = '<FC>id={currow}       name="NO"         width=30    align=center</FC>'
				    	+ '<FC>id=POS_NO         name="POS번호"     width=76    align=center</FC>'
				    	+ '<FC>id=TRAN_NO        name="거래번호"    width=76    align=center</FC>'
				    	+ '<FC>id=SEQ_NO         name="일련번호"    width=70    align=right</FC>'
				    	+ '<FC>id=REG_DATE       name="등록일시"    width=136   align=center mask="XXXX/XX/XX XX:XX:XX"</FC>'
				    	+ '<FC>id=STR_CD         name="점코드"      width=136   align=center show=false</FC>'
				    	+ '<FC>id=SALE_DT        name="매출일자"    width=136   align=center show=false</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
 *************************************************************************/
 /**
  * btn_Search()
  * 작 성 자     : 김영진
  * 작 성 일     : 2010-06-09
  * 개       요     : 조회시 호출
  * return값 : void
  */
 function btn_Search() {
	  
	if(trim(LC_STR_CD.BindColVal).length == 0){
	    showMessage(EXCLAMATION, OK, "USER-1003",  "점코드");
	    LC_STR_CD.Focus();
	    return false;
	}
    if(trim(EM_SALE_DT.Text).length == 0){         
        showMessage(EXCLAMATION, OK, "USER-1001","매출일자");
        EM_SALE_DT.Focus();
        return;
    }
    if(trim(EM_POS_NO.Text).length == 0){    
        showMessage(EXCLAMATION, OK, "USER-1001","POS번호");
        EM_POS_NO.Focus();
        return;
    }
    
    if( trim(EM_TRAN_NO_S.Text).length == 0 && trim(EM_TRAN_NO_E.Text).length != 0){    
        showMessage(EXCLAMATION, OK, "USER-1000","거래번호범위를 정확히 입력하세요.");
        EM_TRAN_NO_S.Focus();
        return;
    }
    bfListRowPosition = 0;
    
    //조회
    showMaster();
 }

 /*************************************************************************
  * 3. 함수
  *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-09
 * 개       요     : 전자서명조회 
 * return값 : void
 */
function showMaster(){    

    var strStrCd    = LC_STR_CD.BindColVal;
    var strSaleDt   = EM_SALE_DT.Text; 
    var strPosNo    = EM_POS_NO.Text;  
    var strTranNoS  = EM_TRAN_NO_S.Text;    
    var strTranNoE  = EM_TRAN_NO_E.Text;  

    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strStrCd="   + encodeURIComponent(strStrCd)
                    + "&strSaleDt="  + encodeURIComponent(strSaleDt)
                    + "&strPosNo="   + encodeURIComponent(strPosNo)
                    + "&strTranNoS=" + encodeURIComponent(strTranNoS)
                    + "&strTranNoE=" + encodeURIComponent(strTranNoE);
    
    TR_MAIN.Action  ="/dps/psal941.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //그리드 첫 row 상세조회
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	LC_STR_CD.Focus();
    }
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}
 
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-09
 * 개       요     : 전자서명조회 
 * return값 : void
 */
function showDetail(row){    

    var strStrCd    = DS_O_MASTER.NameValue(row, "STR_CD");
    var strSaleDt   = DS_O_MASTER.NameValue(row, "SALE_DT");
    var strPosNo    = DS_O_MASTER.NameValue(row, "POS_NO");
    var strTranNo   = DS_O_MASTER.NameValue(row, "TRAN_NO");
      

    var goTo        = "searchDetail";    
    var action      = "O";     
    var parameters  = "&strStrCd="   + encodeURIComponent(strStrCd)
                    + "&strSaleDt="  + encodeURIComponent(strSaleDt)
                    + "&strPosNo="   + encodeURIComponent(strPosNo)
                    + "&strTranNo="  + encodeURIComponent(strTranNo);
    
    TR_SUB.Action  ="/dps/psal941.ps?goTo="+goTo+parameters;  
    TR_SUB.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_SUB.Post();
    
    setPorcCount("SELECT", DS_O_DETAIL.CountRow);
}

/**
 * fn_GetSignImg()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-09
 * 개       요     : TMP PATH 생성
 * return값 : void
 */
function fn_GetSignImg(row) {
    if( row == undefined ) 
	    row = DS_O_MASTER.RowPosition;
    
    document.images.signdata2.src = "";
	var sign_data = DS_O_MASTER.NameValue(row, "E_SIGN_DATA");
	
	var goTo        = "searchSignbmp";
    var action      = "I";
    
    DS_I_DATA.ClearAll();
    DS_I_DATA.setDataHeader('E_SIGN_DATA:STRING(1600)');
    DS_I_DATA.Addrow();
    DS_I_DATA.NameValue(DS_I_DATA.CountRow, "E_SIGN_DATA")    = sign_data;
    
    TR_SIGNIMG.Action  ="/dps/psal941.ps?goTo="+goTo;  
    TR_SIGNIMG.KeyValue="SERVLET("+action+":DS_I_DATA=DS_I_DATA)"; //조회는 O
    TR_SIGNIMG.Post();
    
	/*
    document.getElementById("signdata").value = sign_data;
    document.form1.signImg.value = sign_data;
	document.form1.target = "iframeImg"; 
	document.form1.action="/dps/jsp/psal/psal9411.jsp";	
	document.form1.method= "post"; 
	document.form1.submit();
	*/
}

/**
 * fn_Imagemake()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-09
 * 개       요     : 이미지 생성 
 * return값 : void
 */
function fn_Imagemake(resultPath)
{   
	 //alert("resultPath>>>"+resultPath);
  	
	 //document.images.signdata2.src = resultPath;
	 //alert(document.images.signdata2.src);
	//var sign = document.getElementById("signdata").value;
    
	//alert(sign);
	//if(sign == ""){
    //    alert( '서명데이터가 존재하지 않습니다.');   
    //}else{
    
    //    document.images.signdata2.src = resultPath;
    //}
    //alert(document.images.signdata2.src);
    document.images.signdata2.src = resultPath;
    //alert(document.images.signdata2.src);
}

/**
 * fn_Imagemake_Path()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-09
 * 개       요     : 이미지 경로  생성
 * return값 : void
 */
function fn_Imagemake_Path()
{   
	var strpath =    '<%=BaseProperty.get("signImgRoot") + "sign.bmp"%>'; 
	
	fn_Imagemake(strpath);
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

<script language=JavaScript for=TR_SUB event=onSuccess>
	for(i=0;i<TR_SUB.SrvErrCount('UserMsg');i++) {
  	  showMessage(INFORMATION, OK, "USER-1000", TR_SUB.SrvErrMsg('UserMsg',i));
	}
</script>

<script language=JavaScript for=TR_SIGNIMG event=onSuccess>
    var timestamp = new Date().getTime();
    setTimeout("fn_Imagemake_Path();", 500);
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_SUB event=onFail>
    trFailed(TR_SUB.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        showDetail(row);
        fn_GetSignImg(row);
        
        document.getElementById("signdata2").style.display = "";
      
        
    }else{
    	document.getElementById("signdata2").style.display = "none";
    	document.images.signdata2.src = "";
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 청구일자  onKillFocus() -->
<script language=JavaScript for=EM_SALE_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_SALE_DT)){
    	initEmEdit(EM_SALE_DT,     "TODAY",    PK);
    }
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
<object id="DS_COND_STR_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_STR_CD_I" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_DATA" classid=<%=Util.CLSID_DATASET%>> </object>
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
<object id="TR_SUB" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_SIGNIMG" classid=<%=Util.CLSID_TRANSACTION%>>
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
						<th width="80" class="point">점코드</th>
						<td width="180"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=136
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80" class="point">매출일자</th>
						<td width="180"><comment id="_NSID_"> <object
							id=EM_SALE_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_SALE_DT)" /></td>
						<th width="80" class="point">POS번호</th>
						<td><comment id="_NSID_"> <object id=EM_POS_NO
							classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"
							tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="80">거래번호범위</th>
						<td colspan="5"><comment id="_NSID_"> <object
							id=EM_TRAN_NO_S classid=<%=Util.CLSID_EMEDIT%> width=60
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						~ <comment id="_NSID_"> <object id=EM_TRAN_NO_E classid=<%=Util.CLSID_EMEDIT%> width=60
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
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
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="300" valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"><object id=GR_MASTER
							width="300" height=480 classid=<%=Util.CLSID_GRID%> tabindex=1>
							<param name="DataID" value="DS_O_MASTER">
						</object></comment> <script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
				<td class="PL10">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<table width=100% height=284 border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">점코드</th>
						<td width="135"><comment id="_NSID_"> <object
							id=LC_STR_CD_I classid=<%=Util.CLSID_LUXECOMBO%> width=135
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80" class="point">매출일자</th>
						<td width="135"><comment id="_NSID_"> <object
							id=EM_SALE_DT_I classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>						
					</tr>
					<tr>
						<th>POS번호</th>
						<td><comment id="_NSID_"> <object
							id=EM_POS_NM_I classid=<%=Util.CLSID_EMEDIT%> width=135
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>거래번호</th>
						<td><comment id="_NSID_"> <object
							id=EM_TRAN_NO_I classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>						
					</tr>
					<tr>
						<th>일련번호</th>
						<td><comment id="_NSID_"> <object
							id=EM_POS_SEQ_NO_I classid=<%=Util.CLSID_EMEDIT%> width=135
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>거래구분</th>
						<td><comment id="_NSID_"> <object
							id=EM_WORK_FLAG_I classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>						
					</tr>
					<tr>
						<th>카드번호</th>
						<td><comment id="_NSID_"> <object
							id=EM_CARD_NO_I classid=<%=Util.CLSID_EMEDIT%> width=135
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>유효기간</th>
						<td><comment id="_NSID_"> <object
							id=EM_EXP_DT_I classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>						
					</tr>
					<tr>
						<th>할부개월</th>
						<td><comment id="_NSID_"> <object
							id=EM_DIV_MONTH_I classid=<%=Util.CLSID_EMEDIT%> width=135
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>승인금액</th>
						<td><comment id="_NSID_"> <object
							id=EM_APPR_AMT_I classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>						
					</tr>
					<tr>
						<th>봉사료</th>
						<td><comment id="_NSID_"> <object
							id=EM_SVC_AMT_I classid=<%=Util.CLSID_EMEDIT%> width=135
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>승인번호</th>
						<td><comment id="_NSID_"> <object
							id=EM_APPR_NO_I classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>						
					</tr>
					<tr>
						<th>승인일자</th>
						<td><comment id="_NSID_"> <object
							id=EM_APPR_DT_I classid=<%=Util.CLSID_EMEDIT%> width=135
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>승인시간</th>
						<td><comment id="_NSID_"> <object
							id=EM_APPR_TIME_I classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>						
					</tr>
					<tr>
						<th>취소일자</th>
						<td><comment id="_NSID_"> <object
							id=EM_CAN_DT_I classid=<%=Util.CLSID_EMEDIT%> width=135
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th >취소시간</th>
						<td><comment id="_NSID_"> <object
							id=EM_CAN_TIME_I classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>						
					</tr>
					<tr>
						<th>승인밴사</th>
						<td><comment id="_NSID_"> <object
							id=EM_VAN_NM_I classid=<%=Util.CLSID_EMEDIT%> width=135
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>발급사</th>
						<td><comment id="_NSID_"> <object
							id=EM_CCOMP_NM_I classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>	
						<th>매입사</th>
						<td><comment id="_NSID_"> <object
							id=EM_BCOMP_CD_I classid=<%=Util.CLSID_EMEDIT%> width=135
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>가맹점번호</th>
						<td><comment id="_NSID_"> <object
							id=EM_JBRCH_ID_I classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>수기입력구분</th>
						<td><comment id="_NSID_"> <object
							id=EM_KEYIN_GB_I classid=<%=Util.CLSID_EMEDIT%> width=135
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>거래브랜드품목</th>
						<td><comment id="_NSID_"> <object
							id=EM_FILLER_I classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>결제유형</th>
						<td><comment id="_NSID_"> <object
							id=EM_PAY_TYPE_NM_I classid=<%=Util.CLSID_EMEDIT%> width=135
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>POS구분</th>
						<td><comment id="_NSID_"> <object
							id=EM_POS_FLAG_NM_I classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>원거래승인일자</th>
						<td><comment id="_NSID_"> <object
							id=EM_ORG_APPR_DT_I classid=<%=Util.CLSID_EMEDIT%> width=135
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>원거래승인번호</th>
						<td><comment id="_NSID_"> <object
							id=EM_ORG_APPR_NO_I classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>					
					</tr>
					<tr>
						<th>원거래POS번호</th>
						<td><comment id="_NSID_"> <object
							id=EM_ORG_POS_NO_I classid=<%=Util.CLSID_EMEDIT%> width=135
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>원거래매출일자</th>
						<td><comment id="_NSID_"> <object
							id=EM_ORG_SALE_DT_I classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>					
					</tr>
					<tr>
						<th>원거래거래번호</th>
						<td><comment id="_NSID_"> <object
							id=EM_ORG_TRAN_NO_I classid=<%=Util.CLSID_EMEDIT%> width=135
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>매입요청일자</th>
						<td><comment id="_NSID_"> <object
							id=EM_SEND_DATE_I classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>					
					</tr>
					<!-- 
					<tr>
						<th>가져오기상태</th>
						<td><comment id="_NSID_"> <object
							id=EM_SEND_STAT_I classid=<%=Util.CLSID_EMEDIT%> width=135
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>					
					</tr> -->					
				</table>
				</td>
				</tr>				
      			<td>
      			<tr>
					<td>
					<table width="100%" height=105 border="1" cellspacing="0"
						cellpadding="0" class="BD2A">
						<tr>
							<td align="center">
							<img src="" id="signdata2" style="display:none"/> 
							<input type="hidden" id="signdata" style="width: 1000px; height: 20px;" />
							</td>						
						</tr>
					</table>
					</td>
				</tr>
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
<form name="form1"><input name="signImg" type="hidden" value="">
</form>
<iframe src="" width=0 height=0 scrolling=no frameborder=0
	name=iframeImg></iframe>
	

 <comment id="_NSID_"> <object id=BO_DETAIL classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_O_DETAIL>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
        <c>Col=STR_CD               Ctrl=LC_STR_CD_I         param=BindColVal</c>
        <c>Col=SALE_DT              Ctrl=EM_SALE_DT_I        param=Text</c>
        <c>Col=POS_NM               Ctrl=EM_POS_NM_I         param=Text</c>
        <c>Col=TRAN_NO              Ctrl=EM_TRAN_NO_I        param=Text</c>
        <c>Col=POS_SEQ_NO           Ctrl=EM_POS_SEQ_NO_I     param=Text</c>
        <c>Col=WORK_FLAG            Ctrl=EM_WORK_FLAG_I      param=Text</c>
        <c>col=CARD_NO              Ctrl=EM_CARD_NO_I        param=Text </c>
        <c>Col=EXP_DT               Ctrl=EM_EXP_DT_I         param=Text</c>
        <c>Col=DIV_MONTH            Ctrl=EM_DIV_MONTH_I      param=Text</c>
        <c>Col=APPR_AMT             Ctrl=EM_APPR_AMT_I       param=Text</c>
        <c>Col=SVC_AMT              Ctrl=EM_SVC_AMT_I        param=Text</c>
        <c>Col=APPR_NO              Ctrl=EM_APPR_NO_I        param=Text</c>
        <c>Col=APPR_DT              Ctrl=EM_APPR_DT_I        param=Text</c>
        <c>Col=APPR_TIME            Ctrl=EM_APPR_TIME_I      param=Text</c>
        <c>Col=CAN_DT               Ctrl=EM_CAN_DT_I         param=Text</c>
        <c>Col=CAN_TIME             Ctrl=EM_CAN_TIME_I       param=Text</c>
        <c>Col=VAN_NM               Ctrl=EM_VAN_NM_I         param=Text</c>
        <c>Col=CCOMP_NM             Ctrl=EM_CCOMP_NM_I       param=Text</c>
        <c>Col=BCOMP_CD             Ctrl=EM_BCOMP_CD_I       param=Text</c>
        <c>Col=JBRCH_ID             Ctrl=EM_JBRCH_ID_I       param=Text</c>
        <c>Col=KEYIN_GB             Ctrl=EM_KEYIN_GB_I       param=Text</c>
        <c>Col=FILLER               Ctrl=EM_FILLER_I         param=Text</c>        
        <c>Col=PAY_TYPE_NM          Ctrl=EM_PAY_TYPE_NM_I    param=Text</c>
        <c>Col=POS_FLAG_NM          Ctrl=EM_POS_FLAG_NM_I    param=Text</c>
        <c>Col=ORG_APPR_DT          Ctrl=EM_ORG_APPR_DT_I    param=Text</c>
        <c>Col=ORG_APPR_NO          Ctrl=EM_ORG_APPR_NO_I    param=Text</c>
        <c>Col=ORG_POS_NO           Ctrl=EM_ORG_POS_NO_I     param=Text</c>
        <c>Col=ORG_SALE_DT          Ctrl=EM_ORG_SALE_DT_I    param=Text</c>
        <c>Col=ORG_TRAN_NO          Ctrl=EM_ORG_TRAN_NO_I    param=Text</c>
        <c>Col=SEND_DATE            Ctrl=EM_SEND_DATE_I      param=Text</c>
        
        '>
</object> </comment><script>_ws_(_NSID_);</script> 

</body>
</html>

