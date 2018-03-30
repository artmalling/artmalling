<!-- 
/*******************************************************************************
 * 시스템명 : 영업지원 > 타사카드 > 청구관리 > 직불카드 매입실적 조회
 * 작  성  일  : 2011.08.11
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : psal9490.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2011.08.11 (김영진) 신규작성
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

	String strToMonth = new java.text.SimpleDateFormat("yyyyMM")
			.format(new java.util.Date());
	strToMonth = strToMonth + "01";
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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var bfListRowPosition  = 0;                             // 이전 List Row Position
var bfListRowPosition2 = 0;                             // 이전 List Row Position
var strPostNo1  = "";
var strPostNo2  = "";
var EXCEL_PARAM = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2011-08-11
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
	 
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    DS_O_DETAIL2.setDataHeader('<gauce:dataset name="H_DETAIL2"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2();
    gridCreate3();
    
    //EMedit에 초기화
    initEmEdit(EM_COND_SALE_DT1,     "YYYYMMDD",  PK);           //조회 종료기간
    initEmEdit(EM_COND_SALE_DT2,     "TODAY",     PK);           //조회 종료기간
    initEmEdit(EM_COND_POS_NO1,      "0000",      NORMAL);       //조회 종료
    initEmEdit(EM_COND_POS_NO2,      "0000",      NORMAL);       //조회 종료

    initComboStyle(LC_COND_STR_CD,   DS_COND_STR_CD,   "CODE^0^30, NAME^0^120", 1, PK);

    getStore("DS_COND_STR_CD", "Y", "", "N");

    //초기값설정
    setComboData(LC_COND_STR_CD,  DS_COND_STR_CD.NameValue(0, "CODE"));  //
    
    //조회일자 초기값.
    EM_COND_SALE_DT1.text  = '<%=strToMonth%>';
    EM_COND_SALE_DT2.text  = addDate("D", "-1", EM_COND_SALE_DT2.text);

    showMaster();
}

function gridCreate1(){
    var hdrProperies    = '<FC>id={currow}   name="NO"            width=30   align=center</FC>'    
    	                + '<FC>id=STR_CD     name="STR_CD"        width=0    show=false</FC>'    
    	                + '<FC>id=SALE_DT    name="매출일자"      width=80    align=center   mask="XXXX/XX/XX"  SumText= "합계"</FC>'    
				    	+ '<FC>id=CNT        name="건수"          width=60    align=right    SumText=@sum</FC>'    
				    	+ '<FC>id=AMT        name="매출액"        width=100   align=right    SumText=@sum</FC>'    
				    	+ '<FC>id=FEE_AMT    name="수수료"        width=80    align=right    SumText=@sum</FC>';    
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    GR_MASTER.ViewSummary = "1";
}

function gridCreate2(){
    var hdrProperies    = '<FC>id={currow}    name="NO"            width=30    align=center</FC>'
    	                + '<FC>id=STR_CD      name="STR_CD"        width=0    show=false</FC>'    
                        + '<FC>id=SALE_DT     name="매출일자"      width=80    align=center  mask="XXXX/XX/XX"  SumText= "합계"</FC>'
                        + '<FC>id=POS_NO      name="POS번호"       width=60    align=center  </FC>'
                        + '<FC>id=CNT         name="건수"          width=50    align=right   SumText=@sum</FC>'
                        + '<FC>id=AMT         name="매출액"        width=90   align=right   SumText=@sum</FC>'
                        + '<FC>id=FEE_AMT     name="수수료"        width=70    align=right   SumText=@sum</FC>'; 
                     
    initGridStyle(GR_DETAIL, "common", hdrProperies, false);
    GR_DETAIL.ViewSummary = "1";
}

function gridCreate3(){
    var hdrProperies    = '<FC>id={currow}    name="NO"           width=30     align=center</FC>'
    	                + '<FC>id=TRAN_NO     name="거래번호"      width=56    align=center  SumText= "합계"</FC>'
                        + '<FC>id=SEQ_NO      name="순번"          width=40    align=center  </FC>'
                        + '<FC>id=CARD_NO     name="카드번호"      width=120   align=center  </FC>'
                        + '<FC>id=AMT         name="매출액"        width=70    align=right   SumText=@sum</FC>'
                        + '<FC>id=FEE_AMT     name="수수료"        width=64    align=right   SumText=@sum</FC>'; 
                     
    initGridStyle(GR_DETAIL2, "common", hdrProperies, false);
    GR_DETAIL2.ViewSummary = "1";
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
 * 작 성 자     : 김영진
 * 작 성 일     : 2011-08-11
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if(trim(LC_COND_STR_CD.BindColVal).length == 0){
	    showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
	    LC_COND_STR_CD.Focus();
	    return false;
	}
	if(trim(EM_COND_SALE_DT1.Text).length == 0){          // 조회시작일
	    showMessage(EXCLAMATION, OK, "USER-1001","매출시작일");
	    EM_COND_SALE_DT1.Focus();
	    return;
	}
	if(trim(EM_COND_SALE_DT2.Text).length == 0){          // 조회시작일
	    showMessage(EXCLAMATION, OK, "USER-1001","매출종료일");
	    EM_COND_SALE_DT2.Focus();
	    return;
	}
	if(EM_COND_SALE_DT1.Text > EM_COND_SALE_DT2.Text){      // 조회일 정합성
	    showMessage(EXCLAMATION, OK, "USER-1015");
	    EM_COND_SALE_DT1.Focus();
	    return;
	}
    //조회
    showMaster();
    bfListRowPosition = 0;
}

/**
 * btn_Excel()
 * 작   성   자 : 김영진
 * 작   성   일 : 2011-08-11
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
 function btn_Excel() {
     var ExcelTitle = "직불카드 매출실적 조회";
     openExcel2(GR_MASTER, ExcelTitle, EXCEL_PARAM, true );
     GR_MASTER.Focus();
 }
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2011-08-11
 * 개       요     : 직불카드 매출실적 조회
 * return값 : void
 */
function showMaster(){           

	strPostNo1 = EM_COND_POS_NO1.text;
	strPostNo2 = EM_COND_POS_NO2.text;
	if(trim(strPostNo1).length == 0){
		strPostNo1 = "0000";
	}
	if(trim(strPostNo2).length == 0){
	    strPostNo2 = "9999";
	}
	
	EXCEL_PARAM = "점포명="      + LC_COND_STR_CD.Text
	            + " 매출일자="   + EM_COND_SALE_DT1.Text +"~"+ EM_COND_SALE_DT2.Text
	            + " POS시작번호="+ strPostNo1
	            + " POS종료번호="+ strPostNo2;
	  
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&paramStrCd="   + encodeURIComponent(LC_COND_STR_CD.BindColVal)
				    + "&paramSaleDt1=" + encodeURIComponent(EM_COND_SALE_DT1.text)
				    + "&paramSaleDt2=" + encodeURIComponent(EM_COND_SALE_DT2.text)
                    + "&paramPosNo1="  + encodeURIComponent(strPostNo1)
                    + "&paramPosNo2="  + encodeURIComponent(strPostNo2);
    TR_MAIN.Action  ="/dps/psal949.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //그리드 첫 row 상세조회
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	DS_O_DETAIL.ClearData();
    	DS_O_DETAIL2.ClearData();
        LC_COND_STR_CD.Focus();
        
    }
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * doClick()
 * 작 성 자     : 김영진
 * 작 성 일     : 2011-08-11
 * 개       요     : 선택된 직불카드 매출실적 상세 조회 (우측상단)
 * return값 : void
 */
function doClick(row){
    
    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;
    
    var paramStrCd  = DS_O_MASTER.NameValue(row ,"STR_CD");
    var paramSaleDt = DS_O_MASTER.NameValue(row ,"SALE_DT");

    var goTo        = "searchDetail";    
    var action      = "O";     
    var parameters  = "&paramStrCd="   + encodeURIComponent(paramStrCd)
                    + "&paramSaleDt="  + encodeURIComponent(paramSaleDt)
                    + "&paramPosNo1="  + encodeURIComponent(strPostNo1)
                    + "&paramPosNo2="  + encodeURIComponent(strPostNo2);
    TR_DETAIL.Action  = "/dps/psal949.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    bfListRowPosition2 = 0;
}

/**
 * doChangeDetail()
 * 작 성 자     : 김영진
 * 작 성 일     : 2011-08-11
 * 개       요     : 선택된 직불카드 매출실적 상세 조회(우측 하단)
 * return값 : void
 */
function doChangeDetail(row){
    
    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;
    
    var paramStrCd  = DS_O_DETAIL.NameValue(row ,"STR_CD");
    var strPostNo   = DS_O_DETAIL.NameValue(row ,"POS_NO");
    var paramSaleDt = DS_O_DETAIL.NameValue(row ,"SALE_DT");
    
    var goTo        = "searchDetail2";    
    var action      = "O";     
    var parameters  = "&paramStrCd="  + encodeURIComponent(paramStrCd)
                    + "&paramSaleDt=" + encodeURIComponent(paramSaleDt)
                    + "&paramPosNo="  + encodeURIComponent(strPostNo);
    TR_DETAIL2.Action  = "/dps/psal949.ps?goTo="+goTo+parameters;  
    TR_DETAIL2.KeyValue= "SERVLET("+action+":DS_O_DETAIL2=DS_O_DETAIL2)"; //조회는 O
    TR_DETAIL2.Post();
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
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
    bfListRowPosition = DS_O_MASTER.RowPosition;
</script>
<script language=JavaScript for=TR_DETAIL2 event=onSuccess>
    for(i=0;i<TR_DETAIL2.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL2.SrvErrMsg('UserMsg',i));
    }
    bfListRowPosition2 = DS_O_DETAIL.RowPosition;
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL2 event=onFail>
    trFailed(TR_DETAIL2.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--DS_O_MASTER  OnRowPosChanged(row)(row,colid)-->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    //그리드 첫 row 상세조회
    if(row != 0){
    	if( bfListRowPosition == row)
            return;
        doClick(row);
    }
</script>

<!--DS_O_MASTER  OnRowPosChanged(row)(row,colid)-->
<script language=JavaScript for=DS_O_DETAIL event=OnRowPosChanged(row)> 
    //그리드 첫 row 상세조회
    if(row != 0){
    	if( bfListRowPosition2 == row)
            return;
        doChangeDetail(row);
    }
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<!-- 매출일자 Start onKillFocus() -->
<script language=JavaScript for=EM_COND_SALE_DT1 event=onKillFocus()>
    if(!checkDateTypeYMD(EM_COND_SALE_DT1)){
    	EM_COND_SALE_DT1.text = '<%=strToMonth%>';
    }
</script>
<!-- 매출일자 End onKillFocus() -->
<script language=JavaScript for=EM_COND_SALE_DT2 event=onKillFocus()>
    if(!checkDateTypeYMD(EM_COND_SALE_DT2)){
    	initEmEdit(EM_COND_SALE_DT2,     "TODAY",     PK);  
    	EM_COND_SALE_DT2.text   = addDate("D", "-1", EM_COND_SALE_DT2.text);
    }
</script>  
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리    끝                                                                                                                                *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
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
<object id="DS_O_DETAIL2" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_STR_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
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
<comment id="_NSID_">
<object id="TR_DETAIL2" classid=<%=Util.CLSID_TRANSACTION%>>
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
						<th width="90" class="point">점포명</th>
						<td width="290"><comment id="_NSID_"> <object
							id=LC_COND_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=120
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="90" class="point">매출일자</th>
						<td ><comment id="_NSID_"> <object
							id=EM_COND_SALE_DT1 classid=<%=Util.CLSID_EMEDIT%> width=70
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_COND_SALE_DT1)" />-<comment
							id="_NSID_"> <object id=EM_COND_SALE_DT2
							classid=<%=Util.CLSID_EMEDIT%> width=70 align="absmiddle"
							tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_COND_SALE_DT2)" /></td>
					</tr>
					<tr>
						<th width="90">POS시작번호</th>
						<td><comment id="_NSID_"> <object
							id=EM_COND_POS_NO1 classid=<%=Util.CLSID_EMEDIT%> width=90
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="90">POS종료번호</th>
						<td><comment id="_NSID_"> <object
							id=EM_COND_POS_NO2 classid=<%=Util.CLSID_EMEDIT%> width=90
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
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td valign="top">
                <table width="390" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <object id=GR_MASTER
                            width="100%" height=479 classid=<%=Util.CLSID_GRID%> tabindex=1>
                            <param name="DataID" value="DS_O_MASTER">
                        </object> </comment> <script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
                <td align="center" class="PL05 PR05" width="30">&nbsp;</td>
                <td width="100%">
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <object id=GR_DETAIL
                            width="100%" height=237 classid=<%=Util.CLSID_GRID%> tabindex=1>
                            <param name="DataID" value="DS_O_DETAIL">
                        </object> </comment> <script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <object id=GR_DETAIL2
                            width="100%" height=238 classid=<%=Util.CLSID_GRID%> tabindex=1>
                            <param name="DataID" value="DS_O_DETAIL2">
                        </object> </comment> <script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
</table>

<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</div>
<body>
</html>
    
