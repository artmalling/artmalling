<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 포인트정산 > 포인트 월정산 > 마감일자 관리
 * 작 성 일 : 2010.03.24
 * 작 성 자 : 장형욱
 * 수 정 자 : 
 * 파 일 명 : dmtc6050.jsp
 * 버       전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개       요 : 
 * 이       력 :
 *          2010.03.24 (장형욱) 신규작성
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

    String fromDate = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) + "01";
    String toDate = (String) request.getAttribute("toDate");
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
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var bfListRowPosition = 0;                             // 이전 List Row Position
var strChangFlag    = false;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-24
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    // Output Data Set Header 초기화
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    //-- 검색 필드
    initEmEdit(EM_S_DT_S,       "YYYYMM", PK);           //시작일
    initEmEdit(EM_E_DT_S,       "YYYYMM", PK);           //종료일    
    
    //-- 입력필드
    initEmEdit(EM_CLOSE_YM,     "YYYYMM",     PK);      //마감일자    
    initComboStyle(LC_CLOSE_YN,DS_COM_TYPE, "CODE^0^30,NAME^0^80", 1, PK);    //상태    
    initEmEdit(EM_CLOSE_DT,     "YYYYMMDD",   NORMAL);      //마감일자    
    initEmEdit(EM_FLAG,         "GEN^1",      NORMAL);      //hidden    
    EM_FLAG.style.display = "none";
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_COM_TYPE", "D", "D022", "N");    
    

    //조회일자 초기값.
    EM_S_DT_S.text = <%=fromDate%>;
    EM_E_DT_S.text = <%=toDate%>;        
    
    btn_Search();
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dmtc605","DS_O_MASTER,DS_IO_DETAIL");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}           name="NO"        width=30      align=center</FC>'
                     + '<FC>id=CLOSE_YM           name="처리년월"    width=120     align=center mask="XXXX/XX"</FC>'
                     + '<FC>id=CLOSE_YN           name="마감여부"    width=123     align=center </FC>'
                     + '<FC>id=CLOSE_DT           name="마감일자"    width=130     align=center mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=MOD_DATE           name="수정일시"    width="180"   align=center mask="XXXX/XX/XX XX:XX:XX"</FC>'
                     + '<FC>id=USER_NAME          name="수정자"     width="190"   align=left</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 저장       - btn_Save()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-24
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if (DS_O_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated){
        if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
            setTimeout("LC_CLOSE_YN.Focus();",50);
            return false;
        }else{
            strChangFlag = true;
        }
    }
    
    if (trim(EM_S_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "시작일자");
        EM_S_DT_S.Focus();
        return;
    } else if (trim(EM_E_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "종료일자");
        EM_E_DT_S.Focus();
        return;
    }     
    
    showMaster();
}

/**
 * btn_New()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-24
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
     
    if (DS_O_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated){
       if(showMessage(STOPSIGN, YESNO, "USER-1072") != 1 ){
           setTimeout("LC_CLOSE_YN.Focus();",50);
           return false;
       }else{
           strChangFlag = true;
           if(DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "CLOSE_YM") == ""){
               DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition);
           }
       }
    }
    DS_O_MASTER.Addrow(); 
    DS_IO_DETAIL.ClearData();
    DS_IO_DETAIL.AddRow();
    EM_CLOSE_YM.Text       = "";
    LC_CLOSE_YN.BindColVal = "";
    EM_CLOSE_DT.Text       = "";
    EM_FLAG.Text           = "I";
    EM_CLOSE_YM.Enable     = true;
    enableControl(IMG_CLOSE_YM, true);
    strChangFlag = false;
    
    EM_CLOSE_YM.Focus();
}

/**
 * btn_Save()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    saveData();
}

/*************************************************************************
 * 3. 함수
*************************************************************************/
/**
 * showMaster()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-02-16
 * 개       요 : 기부기획 조회
 * return값 : void
 */
function showMaster(){
     
    var strSdt    = EM_S_DT_S.text;
    var strEdt    = EM_E_DT_S.text;
        
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strSdt="      + encodeURIComponent(strSdt)
                    + "&strEdt="      + encodeURIComponent(strEdt);
                  
    TR_MAIN.Action  = "/dcs/dmtc605.dc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    bfListRowPosition = 0;
    
    if (DS_O_MASTER.CountRow > 0 ) {
        GD_MASTER.Focus();        
    } else {
        EM_S_DT_S.Focus();
        DS_IO_DETAIL.ClearData();
        EM_CLOSE_YM.Enable     = true;
        enableControl(IMG_CLOSE_YM, true);
    }    
}
/**
 * saveData()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-02-16
 * 개       요 : 기부기획 등록
 * return값 : void
 */
function saveData(){

    //신규버튼 누르세요.
    if (DS_IO_DETAIL.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1000","신규버튼 클릭 후 저장 가능합니다.");
        return;
    }
    
    //저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }
    
   if (trim(EM_CLOSE_YM.text).length == 0){
       showMessage(EXCLAMATION, OK, "USER-1003",  "처리년월");
       EM_CLOSE_YM.Focus();
       return;
   }
   
   if (trim(LC_CLOSE_YN.BindColVal).length == 0){
       showMessage(EXCLAMATION, OK, "USER-1003",  "마감여부");
       LC_CLOSE_YN.Focus();
       return;
   }   

   var CLOSE_YM = DS_IO_DETAIL.NameValue(1, "CLOSE_YM");
   var CLOSE_DT = DS_IO_DETAIL.NameValue(1, "CLOSE_DT");
   if (DS_IO_DETAIL.RowStatus(1) == 1) {
       for (var i = 1 ; i <= DS_O_MASTER.CountRow; i++) {
            if (DS_O_MASTER.NameValue(i, "CLOSE_YM") == CLOSE_YM) {
                showMessage(EXCLAMATION, OK, "USER-1000","처리년월[" + CLOSE_YM + "]은 이미 등록되어 있습니다.");
                EM_CLOSE_YM.focus();
                return;
            }
       }
   }
   if (DS_IO_DETAIL.RowStatus(1) == 1 || DS_IO_DETAIL.RowStatus(1) == 3) {
       if (CLOSE_DT != "") {
           if (CLOSE_YM > CLOSE_DT.substring(0, 6)) {
               showMessage(EXCLAMATION, OK, "USER-1000","마감일자는 처리년월의 이후 날짜이어야 합니다.");
               return;
           }
       }
   }
   
   if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
       return;
   }   
   var strFlag     = EM_FLAG.Text;
   var goTo        = "saveData";
   var action      = "I";  //조회는 O
   var parameters  = "&strFlag="+encodeURIComponent(strFlag);
   TR_MAIN.Action  ="/dcs/dmtc605.dc?goTo="+goTo+parameters;   
   TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; 
   TR_MAIN.Post();
}

/**
 * doOnClick()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-24
 * 개       요 : 선택된 마감일자 관리 정보 상세 조회 
 * return값 : void
 */
function doClick(row){
     
    if( row == undefined ) {
       row = DS_O_MASTER.RowPosition;
    }
    
    var strCloseYM = DS_O_MASTER.NameValue(row ,"CLOSE_YM");
    var goTo       = "searchDetail" ;    
    var action     = "O";     
    var parameters = "&strCloseYM="+encodeURIComponent(strCloseYM);
    TR_DETAIL.Action="/dcs/dmtc605.dc?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)";
    TR_DETAIL.Post();
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
        showMaster();
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
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
    if ( strChangFlag == false && (DS_O_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated)){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            setTimeout("LC_CLOSE_YN.Focus();",50);
            return false;
        }else {
            if(DS_O_MASTER.NameValue(row, "CLOSE_YM") == "")
                DS_O_MASTER.DeleteRow(row);
            return true;
        }
    }else{
         return true;
    }
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    //그리드 첫 row 상세조회
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        doClick(row);
        EM_CLOSE_YM.Enable = false;
        enableControl(IMG_CLOSE_YM   , false);
    }else{
      //DS_O_DETAIL.ClearData();
    }
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_S_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_DT_S)){
        EM_S_DT_S.text = addDate("M", "-1", '<%=fromDate%>');
    }
</script>
    
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_E_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_E_DT_S)){
        EM_E_DT_S.text = <%=toDate%>;
    }
</script>  
   
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_CLOSE_DT event=onKillFocus()>
	if(!checkDateTypeYMD(EM_CLOSE_DT)){
		EM_CLOSE_DT.text = <%=toDate%>;
	}
</script> 
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

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- 공통콤보용 -->
<comment id="_NSID_">
<object id="DS_COM_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
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
<!--* E. 본문시작                                                           *-->
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
                <td><object id=GD_MASTER width="100%" height=423
                    classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_O_MASTER">
                </object></td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td class="PT01 PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"
                    class="s_table">
                    <tr>
                        <th width="80" class="point">처리년월</th>
                        <td><comment id="_NSID_"> <object id=EM_CLOSE_YM
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            id=IMG_CLOSE_YM onclick="javascript:openCal('M',EM_CLOSE_YM)" /></td>
                    </tr>
                    <tr>
                        <th width="80" class="point">마감여부</th>
                        <td><comment id="_NSID_"> <object id=LC_CLOSE_YN
                            classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=93 tabindex=1>
                        </object></comment><script> _ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th width="80">마감일자</th>
                        <td><comment id="_NSID_"> <object id=EM_CLOSE_DT
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_CLOSE_DT)" /> <comment
                            id="_NSID_"> <object id=EM_FLAG
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
                    </tr>
                </table>
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
<object id=BD_HEADER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_IO_DETAIL>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
          <c>col=CLOSE_YM         ctrl=EM_CLOSE_YM             Param=Text</c>
          <c>col=CLOSE_YN         ctrl=LC_CLOSE_YN             Param=BindColVal</c>
          <c>col=CLOSE_DT         ctrl=EM_CLOSE_DT             Param=Text</c>
          <c>col=FLAG             ctrl=EM_FLAG                 Param=Text</c>
         '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
