<!-- 
/*******************************************************************************
 * 시스템명 : 계정/예산항목 코드 조회 팝업
 * 작 성 일 : 2010.05.18
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : ccom2211.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 계정/예산항목 코드 조회 팝업
 * 이    력 : 
 ******************************************************************************/
--> 
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,
                                                                       common.vo.SessionInfo,
                                                                       kr.fujitsu.ffw.base.BaseProperty" %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
<!--*************************************************************************-->
<loginChk:islogin />
<%
    String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<title>계정/예산항목 조회-POPUP</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var strPopFlag = dialogArguments[0];
var strCon1    = dialogArguments[1];
var strCon2    = dialogArguments[2];
/**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-05-18
 * 개    요 : initialize
 * return값 : void
 */
function doInit(){
    
	//EMEDIT 설정
	setEmEdit();
    
	//그리드 초기화
    gridCreate();
            
    EM_SEL_CODE.Focus();
    
    if(strCon2.length > 0){
        btn_Search();
    }
} 

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-05-18
 * 개    요    : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
	initEmEdit(EM_SEL_CODE, "GEN^8",  NORMAL);
    initEmEdit(EM_SEL_NAME, "GEN^40", NORMAL);
    EM_SEL_CODE.Text = strCon2;
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-05-18
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
	var hdrProperies = '<C>id={currow} width=30  align=center name="NO"</C>'
                     + '<C>id=CODE     width=90  align=center name="계정/예산항목" </C>'
                     + '<C>id=NAME     width=170 align=left   name="계정/예산항목명" </C>'
                     ;

    initGridStyle(GD_SEARCH, "common", hdrProperies, false);
}    
    
/**
 * btn_Search()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-05-18
 * 개       요 : 조회
 * return값 : void
 */
function btn_Search(){
	//2. 데이터셋 초기화
	DS_RESULT.ClearData();
	    
	//3. 조회시작
	var goTo       = "getAccList";
	var action     = "O";
	var parameters = "&strFlag="    + encodeURIComponent(strPopFlag)
	               + "&strCode="    + encodeURIComponent(EM_SEL_CODE.Text) //코드
	               + "&strName="    + encodeURIComponent(EM_SEL_NAME.Text) //명
	               + "&strCon1="    + encodeURIComponent(strCon1)
	               ;

	DS_RESULT.DataID = "/pot/ccom221.cc?goTo="+goTo+parameters;
	DS_RESULT.Reset();
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-05-18
 * 개       요 : 확인버튼 클릭 처리
 * return값 : void
 */  
function btn_Conf(){
    var row = DS_RESULT.RowPosition;
    if (row > 0){
        var rtn = new Array();
        rtn[0]  = DS_RESULT.NameValue(row,"CODE");
        rtn[1]  = DS_RESULT.NameValue(row,"NAME");
        rtn[2]  = DS_RESULT.NameValue(row,"RPT_YN");
        rtn[3]  = DS_RESULT.NameValue(row,"PRT_SEQ");
        rtn[4]  = DS_RESULT.NameValue(row,"USE_YN");
        window.returnValue = rtn;
        window.close();
    }
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * btn_Close()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.21
 * 개    요 : Close
 * return값 : void
 */  
function btn_Close() {
    window.close();
}
    
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝 
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<script language=JavaScript for=DS_RESULT event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    GD_SEARCH.focus();
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_RESULT  event=OnLoadError()>
    dsFailed(this);
</script>
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!-- Grid sorting event 처리 -->
<script language=JavaScript for=GD_SEARCH event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_SEARCH event=OnDblClick(row,colid)>
    if (row > 0){
        var rtn = new Array();
        rtn[0]  = DS_RESULT.NameValue(row,"CODE");
        rtn[1]  = DS_RESULT.NameValue(row,"NAME");
        rtn[2]  = DS_RESULT.NameValue(row,"RPT_YN");
        rtn[3]  = DS_RESULT.NameValue(row,"PRT_SEQ");
        rtn[4]  = DS_RESULT.NameValue(row,"USE_YN");
        window.returnValue = rtn;
        window.close();
    }
</script> 
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                         
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<comment id="_NSID_"><object id=DS_I_CONDITION   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== Output용 -->
<comment id="_NSID_"><object id=DS_RESULT classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid="<%=Util.CLSID_TRANSACTION%>">
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작
<!--*************************************************************************-->
<body onLoad="doInit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="pop01"></td>
    <td class="pop02"></td>
    <td class="pop03"></td>
  </tr>
  <tr>
    <td class="pop04"></td>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="" class="title">
                  <img src="/<%=dir%>/imgs/comm/title_head.gif" align="absmiddle" class="popR05 PL03" />
                  <SPAN id="title1" class="PL03">계정/예산항목</SPAN>
                </td>
                <td>
                  <table border="0" align="right" cellpadding="0" cellspacing="0">
                    <tr>
                      <td><img src="/<%=dir%>/imgs/btn/search.gif"  onClick="btn_Search();" /></td>
                      <td><img src="/<%=dir%>/imgs/btn/confirm.gif" onClick="btn_Conf()" /></td>
                      <td><img src="/<%=dir%>/imgs/btn/close.gif"   onClick="btn_Close();" /></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td class="popT01 PB03">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
              <tr>
                <td>
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                    <tr>
                      <th width="45">코드</th>
                      <td>
                        <comment id="_NSID_">
                          <object id=EM_SEL_CODE classid=<%=Util.CLSID_EMEDIT%> height=20 width=70
                            onKeyDown="if(event.keyCode == 13) btn_Search();"></object>
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                      <th width="45">명</th>
                      <td>
                        <comment id="_NSID_">
                          <object id=EM_SEL_NAME classid=<%=Util.CLSID_EMEDIT%> height=20 width=130
                            onKeyDown="if(event.keyCode == 13) btn_Search();"></object>
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="g_table">
              <tr>
                <td>
                  <!-- 마스터 -->
                  <comment id="_NSID_">
                    <OBJECT id=GD_SEARCH height="300px" width="100%" classid=<%=Util.CLSID_GRID%>>
                      <param name="DataID" value="DS_RESULT">
                    </OBJECT>
                  </comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
    <td class="pop06"></td>
  </tr>
  <tr>
    <td class="pop07"></td>
    <td class="pop08"></td>
    <td class="pop09"></td>
  </tr>
</table>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>
