<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 신용카드대금청구 > 청구관리 > 청구데이터 조회
 * 작  성  일  : 2010.05.25
 * 작  성  자  : 조형욱
 * 수  정  자  : 
 * 파  일  명  : psal9550.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.05.25 (조형욱) 신규작성
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
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    String dir = BaseProperty.get("context.common.dir");

	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

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
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strFlag           = "INS";
var strChangFlag      = false;
var bfListRowPosition = 0;                             // 이전 List Row Position
var strBefore         = "";  
var strAfter          = "";
var intChangRow       = 0;
var today    = new Date();
var old_Row = 0;
var searchChk = "";

// 오늘 일자 셋팅 
var now = new Date();
var mon = now.getMonth()+1;
if(mon < 10)mon = "0" + mon;
var day = now.getDate();
if(day < 10)day = "0" + day;
var varToday = now.getYear().toString()+ mon + day;
var varToMon = now.getYear().toString()+ mon;
var g_strPid           = "<%=pageName%>";                 // PID

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-05-19
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 150;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GR_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input, Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    
    initEmEdit(EM_COND_CCOMP_CD,    "00",                   NORMAL);       //카드발급사코드
    initEmEdit(EM_COND_CCOMP_NM,    "GEN^40",               READ);         //카드발급사명    
    initEmEdit(EM_COND_REQ_DT,      "TODAY",                PK);           //조회 from
    initEmEdit(EM_REQ_TO_DT,        "TODAY",                PK);           //조회 to
    
    //
    initComboStyle(LC_COND_STR_CD, DS_COND_STR_CD, "CODE^0^30, NAME^0^120", 1, PK);
    initComboStyle(LC_COND_BCOMP_CD, DS_COND_BCOMP_CD, "CODE^0^30, NAME^0^120", 1, NORMAL);
    
    
    
    var	strOrgFlag='<c:out value="${sessionScope.sessionInfo.ORG_FLAG}"	/>';
    //getStore("DS_COND_STR_CD", "Y", "", "N");
    getStore2("DS_COND_STR_CD", "Y",	"1", "Y", strOrgFlag);
    getBcompCode("DS_COND_BCOMP_CD", "", "", "Y");
    getEtcCodeRefer("DS_O_VAN",   "D", "P095", "Y");	// 회계전송구분
    //초기값설정
    setComboData(LC_COND_STR_CD,  DS_COND_STR_CD.NameValue(0, "CODE"));  //
    setComboData(LC_COND_BCOMP_CD,  "%");  //
    DS_O_VAN.Filter();
      
    //
    EM_COND_REQ_DT.text =  varToMon+"01";

    EM_REQ_TO_DT.text =  varToday;
}

function gridCreate1(){
    var hdrProperies    = '<FC>id=STR_NAME              name="관구분"        width=150    align=left SumText="합계"</FC>'
				    	+ '<FC>id=KSNET                name="KSNET"          width=150  align=right mask="#,###" SumText=@sum</FC>'
				    	+ '<FC>id=NICE                name="NICE"          width=150  align=right mask="#,###" SumText=@sum</FC>'
				    	+ '<FC>id=KFTC                name="금융결제원"          width=150  align=right mask="#,###" SumText=@sum</FC>'
				    	+ '<FC>id=KEYIN                name="수기등록"          width=150  align=right mask="#,###" SumText=@sum</FC>'
				    	+ '<FC>id=TOT                name="합계"          width=150  align=right mask="#,###" value={KSNET+NICE+KFTC+KEYIN} SumText=@sum</FC>'
				    	;
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    
    GR_MASTER.ViewSummary = "1";
    
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
    if(trim(LC_COND_STR_CD.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "점");
        LC_COND_STR_CD.Focus();
        return false;
    }
    if(trim(EM_COND_REQ_DT.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","청구일자");
        EM_COND_REQ_DT.Focus();
        return;
    }
    if(trim(EM_REQ_TO_DT.Text).length == 0){         
        showMessage(EXCLAMATION, OK, "USER-1001","청구일자To");
        EM_REQ_TO_DT.Focus();
        return;
    }
    //조회
    showMaster();
}

/**
 * btn_Excel()
 * 작   성   자 : 조형욱
 * 작   성   일 : 2010-02-22
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
 function btn_Excel() {
	 var parameters  = "점="+ LC_COND_STR_CD.Text;
     parameters = parameters + " 기간="+ EM_COND_REQ_DT.Text;
     parameters = parameters + "  ~ "+ EM_REQ_TO_DT.Text;
     parameters = EM_COND_CCOMP_CD.text.length > 0? parameters + " 카드발급사="+ EM_COND_CCOMP_CD.text: parameters;
     parameters = parameters + " 카드매입사="+ LC_COND_BCOMP_CD.Text;
     
     
     var ExcelTitle = "VAN사 기간별 승인건수";

     //openExcel2(GR_MASTER, ExcelTitle, parameters, true );
     openExcel5(GR_MASTER, ExcelTitle, parameters, true  , "",g_strPid );
     
     GR_MASTER.Focus();
 }
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-05-23
 * 개       요     : 가맹점번호 리스트 조회 
 * return값 : void
 */
function showMaster(){    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&paramStrCd="   + encodeURIComponent(LC_COND_STR_CD.BindColVal)
				    + "&paramReqDt="   + encodeURIComponent(EM_COND_REQ_DT.text)
				    + "&paramReqToDt=" + encodeURIComponent(EM_REQ_TO_DT.text)
				    + "&paramCcompCd=" + encodeURIComponent(EM_COND_CCOMP_CD.text)
				    + "&paramBcompCd=" + encodeURIComponent(LC_COND_BCOMP_CD.BindColVal)
				    ;
    
    TR_MAIN.Action  ="/dps/psal955.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //그리드 첫 row 상세조회
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
        //setEnable(true);
    }else{
        LC_COND_STR_CD.Focus();
        //setEnable(false);
        
    }
    //bfListRowPosition = 0;
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-31
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
     EM_COND_CCOMP_NM.Text = "";//조건입력시 코드초기화
    if (EM_COND_CCOMP_CD.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_COND_CCOMP_CD.Text.length == 2) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_CARDBIN", EM_COND_CCOMP_CD.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
                EM_COND_CCOMP_CD.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
                EM_COND_CCOMP_NM.Text   = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getCcompPop(EM_COND_CCOMP_CD, EM_COND_CCOMP_NM);
            }
        }
    }
}
 
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                            *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                         *-->
<!--*    1. TR Success 메세지 처리                                        *-->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        var strMsg = TR_MAIN.SrvErrMsg('UserMsg',i).split('|');
        //EM_BRCH_ID.Text = strMsg[0]; 
        showMessage(INFORMATION, OK, "USER-1000", strMsg[0]);
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<!-- 카드발급사 onKillFocus() -->
<script language=JavaScript for=EM_CCOMP_CD event=onKillFocus()>
    if ((EM_COND_CCOMP_CD.Modified) && (EM_COND_CCOMP_CD.Text.length != 2)) {
        EM_COND_CCOMP_NM.Text = "";
    }
</script>

<!-- 청구일자 onKillFocus() -->
<script language=JavaScript for=EM_COND_REQ_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_COND_REQ_DT)){
        initEmEdit(EM_COND_REQ_DT,    "TODAY",     PK);        
    }
</script>  

<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=DS_O_VAN event=onFilter(row)>
    if (DS_O_VAN.NameValue(row,"CODE") == "%"
    	||DS_O_VAN.NameValue(row,"REFER_CODE") == "1"){
    	return true;
    }else{ 
    	return false;
    }

</script>


<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리    끝                                                *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                    *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_STR_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_BCOMP_CD" classid=<%=Util.CLSID_DATASET%>> </object>
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

<comment id="_NSID_">
<object id=DS_O_VAN classid=<%=Util.CLSID_DATASET%>> 
    <param name=DataID      value="Filter_s1.csv">
    <param name=UseFilter   value=true>
</object>
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
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
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
<!--* E. 본문시작                                                            *-->
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
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                    <tr>
                        <th width="80" class="point">점</th>
                        <td width="160"><comment id="_NSID_"> 
                            <object id=LC_COND_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=145 align="absmiddle" tabindex=1> 
                            </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width="80" class="point">매출일자</th>
                        <td width="210"><comment id="_NSID_"> 
                            <object id=EM_COND_REQ_DT classid=<%=Util.CLSID_EMEDIT%> width=70 align="absmiddle" tabindex=1> 
                            </object> </comment> <script> _ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_COND_REQ_DT)" />
                            ~
						    <comment id="_NSID_"> <object
							id=EM_REQ_TO_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						    <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_REQ_TO_DT)" />
                        </td>
                    </tr>
                    <tr>
                        <th width="80">카드발급사</th>
                        <td width="180"><comment id="_NSID_"> <object
                            id=EM_COND_CCOMP_CD classid=<%=Util.CLSID_EMEDIT%> width=35
                            tabindex=1 onKillFocus="javascript:onKillFocus()"
                            onKeyUp="javascript:keyPressEvent(event.keyCode);"></object> </comment> <script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
                            align="absmiddle"
                            onclick="getCcompPop(EM_COND_CCOMP_CD, EM_COND_CCOMP_NM)" /> <comment
                            id="_NSID_"> <object id=EM_COND_CCOMP_NM
                            classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width="80" >카드매입사</th>
                        <td width="180"><comment id="_NSID_"> 
                            <object id=LC_COND_BCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=145 align="absmiddle" tabindex=1> 
                            </object> </comment> <script> _ws_(_NSID_);</script>
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
    
    <tr>
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"> <object id=GR_MASTER width="100%" height=455 classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_O_MASTER">
                </object> </comment> <script>_ws_(_NSID_);</script></td>
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
    
