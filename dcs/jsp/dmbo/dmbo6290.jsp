<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 멤버쉽운영 > EXCEL SMS 중지등록
 * 작 성 일    : 2010.03.29
 * 작 성 자    : jinjung.kim
 * 수 정 자    : 
 * 파 일 명    : DMBO6280.jsp
 * 버       전    : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개       요    :  
 * 이       력    :
 *           2010.03.29 (jinjung.kim) 신규작성
 *
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"        prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"            prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                              *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dcs.js"  type="text/javascript"></script>


<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.29
 * 개       요  : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    gridCreate1(); //그리드 초기화
    
    initEmEdit(EM_FILE, "GEN^400", PK); 

    btn_Search();
    
    EM_FILE.focus();
}

/**
 * gridCreate1()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.29
 * 개       요  : Grid 초기화
 * return값 : void
 */ 
function gridCreate1() {
	    var hdrProperies = '<FC>id={currow}     name="NO"           width=30   align=center   BgColor={if(ERR_MSG = "","white","orange")} </FC>'
            + '<FC>id=CARD_NO name="CARD_NO"   width=180  align=center   BgColor={if(ERR_MSG = "","white","orange")}</FC>'
            + '<FC>id=MOBILE   name="휴대폰1"       width=120  align=center   BgColor={if(ERR_MSG = "","white","orange")}</FC>'
            + '<FC>id=SMSYN   name="SMSYN"       width=120  align=center   BgColor={if(ERR_MSG = "","white","orange")}</FC>';

                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);

    GR_MASTER.ViewSummary = "1";
}


/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search()
     (2) 신규       - btn_New()
     (3) 저장       - btn_Save()
     (4) 확정       - btn_Conf()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.29
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    var goTo        = "searchMaster";    
    var parameters  = "";

    TR_SEARCH.Action   = "/dcs/dmbo629.do?goTo=" + goTo + parameters;  
    TR_SEARCH.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)"; 
    TR_SEARCH.Post();
    
    EM_FILE.Text = "";
    INF_FILE.value = "";

    //조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
}

/**
 * btn_New()
 * 작 성 자 : jinjung.kim
 * 작 성 일 : 2010.03.29
 * 개    요 : Grid 클리어 및 신규입력 대기.
 * return값 : void
 */
function btn_New() {
    EM_FILE.Text = "";
    DS_IO_MASTER.ClearData();
    DS_IO_MASTER.ResetStatus();
    INF_FILE.value = "";
    EM_FILE.focus();
}


/**
 * btn_Conf()
 * 작 성 자 : jinjung.kim
 * 작 성 일 : 2010.03.29
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {
  /*  if (DS_IO_MASTER.CountRow <= 0) return;
    
    var INSERT_COUNT = 0;
    for (var i = 1; i <= DS_IO_MASTER.CountRow; i++) {
        if (DS_IO_MASTER.RowStatus(i) == 1) {
            INSERT_COUNT++;
        }
    }
    if (INSERT_COUNT > 0) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "EXCEL UPLOAD된 자료를 선저장 후 확정처리가 가능합니다.");
        return;
    }

    if( showMessage(QUESTION, YESNO, "USER-1024") != 1 ){
       return;
    }
    var goTo = "confData";
    TR_MASTER.Action  ="/dcs/dmbo629.do?goTo="+goTo;
    TR_MASTER.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
    TR_MASTER.Post();*/
}

/**
 * btn_Excel()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.25
 * 개       요     : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    if(DS_IO_MASTER.CountRow <= 0){
        showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
          return;
      }
      var strTitle = "SMS내역확인";
      
      
      GR_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
      openExcel2(GR_MASTER, strTitle, "", true );
  }






/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
 * searchFile()
 * 작 성 자 : jinjung.kim
 * 작 성 일 : 2010.03.29
 * 개    요 : Excel File 선택 및 Grid load
 * return값 : void
 */
function searchFile() {
    if (DS_IO_MASTER.CountRow > 0) {
        for (var i = 1; i <= DS_IO_MASTER.CountRow; i++) {
            if (DS_IO_MASTER.RowStatus(i) == 0) {//미확정건
                showMessage(EXCLAMATION, OK, "USER-1000",  "이전 작업 잔여 데이터가 존재합니다. 확정처리 후 다른 작업이 가능합니다.");
                return;
            }
        }
    }
    INF_FILE.open();
    if (true == INF_FILE.selectState) {
        var excelFilePath = INF_FILE.value;
        if ("" != excelFilePath) {
            var arrData = excelFilePath.split(".");
            if ("XLS" != arrData[arrData.length-1].substring(0,3).toUpperCase()) {
                showMessage(EXCLAMATION, OK, "USER-1000",  "EXCEL 포맷 파일만 업로드 가능합니다.");
                return;
            }
            EM_FILE.Text = excelFilePath;
            
            var strStartRow   = 1; //시작Row
            var strEndRow     = 0; //끝Row
            var strReadType   = 0; //읽기모드
            var strBlankCount = 0; //공백row개수
            var strLFTOCR     = 0; //줄바꿈처리 
            var strFireEvent  = 1; //이벤트발생
            var strSheetIndex = 1; //Sheet Index 추가
            var strtrEtc      = "0,0";//기타

            var strOption  = "'" + excelFilePath + "'";
                 strOption += "," + strStartRow;
                 strOption += "," + strEndRow ;
                 strOption += "," + strReadType ;
                 strOption += "," + strBlankCount;
                 strOption += "," + strLFTOCR;
                 strOption += "," + strFireEvent;
                 strOption += "," + strSheetIndex;
                 strOption += "," + strtrEtc;
          DS_IO_MASTER.Do("Excel.Application", strOption);
        }
    }
}

/**
 * uploadFile()
 * 작 성 자 : jinjung.kim
 * 작 성 일 : 2010.03.29
 * 개       요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function uploadFile() {

    if (DS_IO_MASTER.CountRow <= 0) return;
    if (!DS_IO_MASTER.IsUpdated) return;
    
    var INSERT_COUNT = 0;
    for (var i = 1; i <= DS_IO_MASTER.CountRow; i++) {
        if (DS_IO_MASTER.RowStatus(i) == 1) {
            INSERT_COUNT++;
        }
    }
    if (INSERT_COUNT == 0) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "UPLOAD된 자료가 없습니다.");
        return;
    }

    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
       return;
    }

    var goTo = "saveData";
    TR_MASTER.Action  ="/dcs/dmbo629.do?goTo="+goTo;
    TR_MASTER.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
    TR_MASTER.Post(); 
}

function downFile() {
	if(showMessage(Question, YESNO, "USER-1023") == 1){  
		
    var goTo = "delData";
    TR_MASTER.Action  ="/dcs/dmbo629.do?goTo="+goTo;
    TR_MASTER.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
    TR_MASTER.Post();
	}
}

-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                        *-->
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
<script language=JavaScript for=TR_SEARCH event=onSuccess>
    for(var i = 0; i < this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    }
    if (DS_IO_MASTER.CountRow > 0) {
        GR_MASTER.focus();
    } else {
        EM_FILE.focus();
    }
</script>
<script language=JavaScript for=TR_MASTER event=onSuccess>
    for(var i = 0; i < this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    }
    btn_Search();  
</script>
<script language=JavaScript for=TR_CHECK event=onSuccess>
    for(var i = 0; i < this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    } 
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_SEARCH event=onFail>
    trFailed(TR_SEARCH.ErrorMsg);
</script>
<script language=JavaScript for=TR_MASTER event=onFail>
	alert("정상 삭제 되었습니다.");
	btn_Search();
	//trFailed(TR_SEARCH.ErrorMsg);
	//trFailed(TR_MASTER.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid DETAIL oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                              *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                  *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_">
  <object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
  <object id="TR_SEARCH" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
  </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="TR_MASTER" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
  </object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                 *-->
<!--*************************************************************************-->



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
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
        <tr>
          <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="80" class="point">EXCEL FILE</th>
                <td>
                  <comment id="_NSID_">
                    <object id=EM_FILE classid=<%=Util.CLSID_EMEDIT%> width=470 tabindex=1 align="absmiddle"></object> 
                 </comment>
                 <script> _ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/file_search.gif" align="absmiddle" onclick="searchFile();"/>
                 &nbsp;&nbsp;&nbsp;&nbsp;
                 <img src="/<%=dir%>/imgs/btn/excel_s.gif" align="absmiddle" onclick="uploadFile();"/> 
                 <img src="/<%=dir%>/imgs/btn/excel_down.gif" align="absmiddle" onclick="downFile();"/> 
                 
                 <!-- <a href="/dcs/samplefiles/DMBO629_EXCEL_SMS_form.xls"> <img
                    style="vertical-align: middle;"
                    src="/<%=dir%>/imgs/btn/excel_down.gif" width="82" height="18" /></a>-->
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
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GR_MASTER width="100%" height=508 classid=<%=Util.CLSID_GRID%> tabindex=1>
                  <param name="DataID" value="DS_IO_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<table style="display:none">
    <tr>
        <td>
            <comment id="_NSID_">
            <object id=INF_FILE classid=<%=Util.CLSID_INPUTFILE%> Width=0 Height=0>
                 <param name="FileFilterString"   value=16>
                 
            </object>
            </comment>
            <script> _ws_(_NSID_);</script>
        </td>
    </tr>
</table>
</body>
</html>

