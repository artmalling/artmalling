<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 포인트정산 > 월별 사용수수료 정산내역
 * 작 성 일 : 2010.05.04
 * 작 성 자 : 장형욱
 * 수 정 자 : 
 * 파 일 명 : dmtc6020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.05.04 (장형욱) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	request.setCharacterEncoding("utf-8");
	String dir = BaseProperty.get("context.common.dir");

	String fromDate = (String) request.getAttribute("fromDate");
	String toDate   = (String) request.getAttribute("fromDate");
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
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var EXCEL_PARAMS = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-06
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터

    //-- 검색 필드
    initEmEdit(EM_S_DT_S,       "YYYYMM", PK);           //시작일
    initEmEdit(EM_E_DT_S,       "YYYYMM", PK);           //종료일    
    
    EM_S_DT_S.Text = <%=fromDate%>;
    EM_E_DT_S.Text = <%=toDate%>;
    
    btn_Search();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}      name="NO"          width=30     align=center</FC>'
                     + '<FC>id=BRCH_NAME     name="가맹점명"      width=167    align=left</FC>'
                     + '<FC>id=FINC_CD       name="회계단위"      width=130    align=left</FC>'
                     + '<FC>id=SUM_YM        name="년월"         width=70     align=center mask="XXXX/XX"</FC>'
                     + '<FC>id=USE_POINT     name="사용액"        width="90"  align=right</FC>'
                     + '<FC>id=USE_FEE_AMT   name="적립수수료"     width="100"  align=right</FC>'
                     + '<FC>id=CURR_POINT    name="적립잔액"       width="100"  align=right</FC>'
                     + '<FC>id=ACCNT_MIG_DT  name="회계이관"       width="90"  align=center mask="XXXX/XX/XX"</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
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
 * 작 성 일 : 2010-05-06
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    var strSdt    = EM_S_DT_S.text;
    var strEdt    = EM_E_DT_S.text;
    
    EXCEL_PARAMS  = "시작일자="  + strSdt;
    EXCEL_PARAMS += "-종료일자=" + strEdt;
    
    if (trim(EM_S_DT_S.text).length == 0){
        showMessage(STOPSIGN, OK, "USER-1003",  "시작일자");
        EM_S_DT_S.Focus();
        return;
    } else if (trim(EM_E_DT_S.text).length == 0){
        showMessage(STOPSIGN, OK, "USER-1003",  "종료일자");
        EM_E_DT_S.Focus();
        return;
    }
    
    if (eval(strSdt) > eval(strEdt) ) {
        showMessage(EXCLAMATION, OK, "USER-1015",  "종료일자");
        EM_E_DT_S.Focus();
        return;     
    }    
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strSdt="      + encodeURIComponent(strSdt)
                    + "&strEdt="      + encodeURIComponent(strEdt);
                  
    TR_MAIN.Action  = "/dcs/dmtc602.dc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    if (DS_O_MASTER.CountRow > 0 ) {
        GD_MASTER.Focus();        
    }
    else {
        EM_S_DT_S.Focus();
    }    
}

/**
 * btn_Excel()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-06
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    var ExcelTitle = "월별 사용수수료 정산내역"
    openExcel2(GD_MASTER, ExcelTitle, EXCEL_PARAMS, true );
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
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
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
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
<script language='javascript'>
<!--

window.onresize = function(){
    var obj   = document.getElementById("testdiv"); 
    obj.style.height  = (parseInt(window.document.body.clientHeight)-20) + "px";
}

//-->
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
                        <th width="80" class="point">조회년월</th>
                        <td><comment id="_NSID_"> <object id=EM_S_DT_S
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('M',EM_S_DT_S)" />- <comment
                            id="_NSID_"> <object id=EM_E_DT_S
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('M',EM_E_DT_S)" /></td>
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
                <td><object id=GD_MASTER width="100%" height=504
                    classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_O_MASTER">
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
