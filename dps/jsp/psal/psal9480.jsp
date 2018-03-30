<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 신용카드대금청구 > 청구관리 > VAN사 승인내역 조회
 * 작 성 일 : 2010.06.03
 * 작 성 자 : 장형욱
 * 수 정 자 : 
 * 파 일 명 : psal9480.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.06.03 (장형욱) 신규작성
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
	String fromDate = new java.text.SimpleDateFormat("yyyyMM")
			.format(new java.util.Date()) + "01";
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
var CUR_GD = "1";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-06-03
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 400;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

          
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1();  
    gridCreate2();
    
    //-- 입력필드
    initEmEdit(EM_S_APPR_DT_S, "YYYYMMDD",    PK);    
    initEmEdit(EM_E_APPR_DT_S, "today",       PK);      
    initEmEdit(EM_APPR_NO_S,   "0000000000",  NORMAL);               //-- 승인번호
    
    initComboStyle(LC_JBRCH_ID_S, DS_O_JBRCH_ID,  "CODE^0^120, NAME^0^180",   1, NORMAL);//가맹점번호
    initComboStyle(LC_STR_CD_S,   DS_O_S_STR,     "CODE^0^20, NAME^0^80",     1, PK);
    initComboStyle(LC_BCOMP_S,    DS_O_BCOMP,     "CODE^0^20, NAME^0^80",     1, NORMAL);
    initComboStyle(LC_VANGUBUN_S, DS_O_VAN,       "CODE^0^20, NAME^0^80",     1, NORMAL);

    getBcompCode("DS_O_BCOMP", "", "", "Y");    
    getStore("DS_O_S_STR", "Y", "", "N");
//    getEtcCode("DS_O_VAN",   "D", "P095", "Y");
    getEtcCodeRefer("DS_O_VAN",   "D", "P095", "Y");	// 회계전송구분
    LC_BCOMP_S.BindColVal = "%";  
    LC_STR_CD_S.index = 0;      
    LC_VANGUBUN_S.BindColVal = "%";  
    DS_O_VAN.Filter();
    EM_S_APPR_DT_S.text = <%=fromDate%>;
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}   name="NO"          width=30     align=center</FC>'
                     + '<FC>id=APPR_DT    name="승인일자"     width=85      align=center mask="XXXX/XX/XX" SumText= "합계"</FC>'
                     + '<FC>id=BCOMP_NM   name="카드매입사"    width=90     align=left</FC>'
                     + '<FC>id=JBRCH_NM   name="가맹점번호명"  width=120    align=left </FC>'
                     + '<FC>id=POS_CNT    name="POS승인건수"   width=90     align=right   SumText=@sum</FC>'
                     + '<FC>id=POS_AMT    name="POS승인금액"   width=90     align=right   SumText=@sum</FC>'
                     + '<FC>id=VAN_CNT    name="VAN승인건수"   width=90     align=right   SumText=@sum</FC>'
                     + '<FC>id=VAN_AMT    name="VAN승인금액"   width=90     align=right   SumText=@sum</FC>'
                     + '<FC>id=CHA_CNT    name="차이건수"      width=90     align=right   SumText=@sum</FC>'
                     + '<FC>id=CHA_AMT    name="차이금액"      width=90     align=right   SumText=@sum</FC>'
                     + '<FC>id=STR_CD     name="HIDEEN"       width=90     align=right show=false </FC>'
                     + '<FC>id=APPR_NO    name="HIDEEN"       width=90     align=right show=false </FC>'
                     + '<FC>id=BCOMP_CD   name="HIDEEN"       width=90     align=right show=false </FC>'
                     + '<FC>id=JBRCH_ID   name="HIDEEN"       width=90     align=right show=false </FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    GD_MASTER.ViewSummary = "1";
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}   name="NO"           width=30  align=center </FC>'
                     + '<FC>id=RECP_NO    name="POS영수증번호"  width=160  align=center SumText= "합계"</FC>'
                     + '<FC>id=POS_ANO    name="POS승인번호"    width=120  align=center </FC>'
                     + '<FC>id=POS_AMT    name="POS승인금액"    width=128  align=right  SumText=@sum</FC>'
                     + '<FC>id=VAN_AMT    name="VAN승인금액"    width=128  align=right  SumText=@sum</FC>'
                     + '<FC>id=CHA_AMT    name="차이금액"       width=120  align=right  SumText=@sum</FC>'
                     + '<FC>id=REMARK     name="비고"           width=95  align=right </FC>';
                     
    initGridStyle(GD_DETAIL, "common", hdrProperies, false);
    GD_DETAIL.ViewSummary = "1";
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
     (6) 출력       - btn_Print()
     (7) 확정       - btn_Conf()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-06-03
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {  
    
    if (trim(LC_STR_CD_S.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
        LC_STR_CD_S.Focus();
        return;
    } 
    if (trim(EM_S_APPR_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1001",  "승인일자");
        EM_S_APPR_DT_S.Focus();
        return;
    }
    if (trim(EM_E_APPR_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1001",  "승인일자");
        EM_E_APPR_DT_S.Focus();
        return;
    }  
    if(EM_S_APPR_DT_S.Text > EM_E_APPR_DT_S.Text){   // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_E_APPR_DT_S.Focus();
        return;
    }

    EXCEL_PARAMS  = "점포명="      + LC_STR_CD_S.text;
    EXCEL_PARAMS += "-승인일자="   + EM_S_APPR_DT_S.text + " ~ " + EM_E_APPR_DT_S.text;
    EXCEL_PARAMS += "-VAN구분="    + LC_VANGUBUN_S.text;
    EXCEL_PARAMS += "-매입사="     + LC_BCOMP_S.text;
    EXCEL_PARAMS += "-가맹점번호=" + LC_JBRCH_ID_S.BindColVal;
    EXCEL_PARAMS += "-승인번호="   + EM_APPR_NO_S.text;
        
        
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strStrCd="     +  encodeURIComponent(LC_STR_CD_S.BindColVal)   
                    + "&strSapprDt="   +  encodeURIComponent(EM_S_APPR_DT_S.text)  
                    + "&strEapprDt="   +  encodeURIComponent(EM_E_APPR_DT_S.text) 
                    + "&strBcomp="     +  encodeURIComponent(LC_BCOMP_S.BindColVal)     
                    + "&strJbrchId="   +  encodeURIComponent(LC_JBRCH_ID_S.BindColVal) 
                    + "&strApprNo="    +  encodeURIComponent(EM_APPR_NO_S.text)
                    + "&strVanGubun="  +  encodeURIComponent(LC_VANGUBUN_S.BindColVal);
    
    TR_MAIN.Action  = "/dps/psal948.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    if (DS_O_MASTER.CountRow > 0 ) {
        doClick(1);
        GD_MASTER.Focus();       
    }

    bfListRowPosition = 0;
}

/**
 * btn_Excel()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-06-03
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    var ExcelTitle = "VAN사 승인내역 조회"
    openExcel2(GD_DETAIL, ExcelTitle, EXCEL_PARAMS, true );     
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * doOnClick()
  * 작 성 자 : 장형욱
  * 작 성 일 : 2010-02-21
  * 개       요 : 선택된 기부정보 상세 조회
  * return값 : void
  */
 function doClick(row){
           
     if( row == undefined ) 
          row = DS_O_MASTER.RowPosition;
       
     var strApprDt    = DS_O_MASTER.NameValue(row ,"APPR_DT");
     var strStrCd     = DS_O_MASTER.NameValue(row ,"STR_CD");
     var strApprNo    = EM_APPR_NO_S.text;
     var strBcompCd   = DS_O_MASTER.NameValue(row ,"BCOMP_CD");
     var strJbrchId   = DS_O_MASTER.NameValue(row ,"JBRCH_ID");

     var goTo        = "searchDetail";    
     var action      = "O";     
     var parameters  = "&strApprDt="   +  encodeURIComponent(strApprDt)   
                     + "&strStrCd="    +  encodeURIComponent(strStrCd)  
                     + "&strApprNo="   +  encodeURIComponent(strApprNo)     
                     + "&strBcompCd="  +  encodeURIComponent(strBcompCd)
                     + "&strJbrchId="  +  encodeURIComponent(strJbrchId)
                     + "&strVanGubun=" +  encodeURIComponent(LC_VANGUBUN_S.BindColVal);
     
     TR_DETAIL.Action  = "/dps/psal948.ps?goTo="+goTo+parameters;  
     TR_DETAIL.KeyValue= "SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
     TR_DETAIL.Post();
     
     if(row > 1){
         setPorcCount("SELECT", DS_O_DETAIL.CountRow);
     }
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
<script language=JavaScript for=DS_O_VAN event=onFilter(row)>
    if (DS_O_VAN.NameValue(row,"CODE") == "%"
    	||DS_O_VAN.NameValue(row,"REFER_CODE") == "1"){
    	return true;
    }else{ 
    	return false;
    }

</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 

    if(clickSORT)
        return;
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

<!-- 매입사콤보 선택이벤트 처리 -->
<script language=JavaScript for=LC_BCOMP_S event=OnSelChange()>
    DS_O_JBRCH_ID.ClearData();
    if(this.BindColVal != "%"){
        LC_JBRCH_ID_S.Enable = true;
        getJbrchCode("DS_O_JBRCH_ID", this.BindColVal, "N");
    }else{
        LC_JBRCH_ID_S.Enable = false;
    }
</script>

<!-- 승인일자 Start onKillFocus() -->
<script language=JavaScript for=EM_S_APPR_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_APPR_DT_S)){
    	EM_S_APPR_DT_S.text = <%=fromDate%>;
    }
</script>
<!-- 승인일자 End onKillFocus() -->
<script language=JavaScript for=EM_E_APPR_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_E_APPR_DT_S)){
    	 initEmEdit(EM_E_APPR_DT_S, "TODAY",       PK); 
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
<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_VAN classid=<%=Util.CLSID_DATASET%>> 
    <param name=DataID      value="Filter_s1.csv">
    <param name=UseFilter   value=true>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_S_STR classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_BCOMP classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_JBRCH_ID classid=<%=Util.CLSID_DATASET%>> </object>
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

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>
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
						<th width="80" class="point">점포명</th>
						<td width="165"><comment id="_NSID_"> <object
							id=LC_STR_CD_S classid=<%=Util.CLSID_LUXECOMBO%> width=150
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>

						<th width="80" class="point">승인일자</th>
						<td width="210"><comment id="_NSID_"> <object
							id=EM_S_APPR_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_APPR_DT_S)" />- <comment
							id="_NSID_"> <object id=EM_E_APPR_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_E_APPR_DT_S)" /></td>
					    <th width="80">VAN구분</th>
                        <td><comment id="_NSID_"> <object
                            id=LC_VANGUBUN_S classid=<%=Util.CLSID_LUXECOMBO%> width=120
                            align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
					
					</tr>
					<tr>
						<th width="80">매입사</th>
						<td width="165"><comment id="_NSID_"> <object id=LC_BCOMP_S
							classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=150
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">가맹점번호</th>
						<td width="210"><comment id="_NSID_"> <object id=LC_JBRCH_ID_S
							classid=<%=Util.CLSID_LUXECOMBO%> width=194 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>

						<th width="80">승인번호</th>
						<td><comment id="_NSID_"> <object
							id=EM_APPR_NO_S classid=<%=Util.CLSID_EMEDIT%> width=115 
							tabindex=1></object> </comment> <script> _ws_(_NSID_);</script></td>
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
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>
