<!-- 
/*******************************************************************************
 * 시스템명 : 건의사항 팝업
 * 작 성 일 : 2010.06.07
 * 작 성 자 : 정지인
 * 수 정 자 : 
 * 파 일 명 : tcom0060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 건의사항 팝업
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
    String strUserId = Util.getUsrCd(request);
    String strUserNm = Util.getUserNm(request);
    String strDeptNm = Util.getDeptNm(request);
    String strTelNo  = Util.getTelNo(request);
    String strEmail  = Util.getEMail(request);
%>
<html>
<head>
<title>건의사항</title>
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
/**
 * doInit()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010-06-07
 * 개    요 : initialize
 * return값 : void
 */
function doInit(){
    //////////헤더 초기화////////////////////////////////////////////////////
    DS_SUGGEST.setDataHeader('<gauce:dataset name="H_DS_SUGGEST"/>');
    DS_SUGGEST.AddRow();
	//EMEDIT 설정
	setEmEdit();
    
	//그리드 초기화
    gridCreate();
            
    EM_TITLE.Focus();
} 

/**
 * setEmEdit()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010-06-07
 * 개    요    : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
	 initEmEdit(EM_USER_ID,  "GEN",  READ);
	 initEmEdit(EM_USER_NM,  "GEN",  READ);
	 initEmEdit(EM_DEPT_NM,  "GEN",  READ);
	 initEmEdit(EM_PHONE_NO, "GEN",  READ);
	 initEmEdit(EM_E_MAIL,   "GEN",  READ);
	 initEmEdit(EM_TITLE,    "GEN^50",  NORMAL);
	 initEmEdit(EM_FILE,     "GEN",  READ);
	 initTxtAreaEdit(TEXT_CON, NORMAL);
     
	 EM_USER_ID.Text  = "<%=strUserId%>";
	 EM_USER_NM.Text  = "<%=strUserNm%>";
	 EM_DEPT_NM.Text  = "<%=strDeptNm%>";
	 EM_PHONE_NO.Text = "<%=strTelNo%>";
	 EM_E_MAIL.Text   = "<%=strEmail%>";
}

/**
 * gridCreate()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010-06-07
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
}    
    
/**
 * btn_Search()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010-06-07
 * 개       요 : 조회
 * return값 : void
 */
function btn_Search(){
}

/**
 * btn_Conf()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010-06-07
 * 개       요 : 확인버튼 클릭 처리
 * return값 : void
 */  
function btn_Conf(){
	if (isNull(EM_USER_ID.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "사번"); //(사번)은/는 반드시 입력해야 합니다.
        EM_USER_ID.focus();
        return;
    }
	
	if (isNull(EM_TITLE.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "제목"); //(제목)은/는 반드시 입력해야 합니다.
        EM_TITLE.focus();
        return;
    }
	
	if (isNull(TEXT_CON.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "내용"); //(내용)은/는 반드시 입력해야 합니다.
        TEXT_CON.focus();
        return;
    }
	TR_MAIN.Action   = "/pot/tcom006.tc?goTo=suggest";  
    TR_MAIN.KeyValue = "SERVLET(I:DS_SUGGEST=DS_SUGGEST)"; 
    TR_MAIN.Post();
    
    //window.close();
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * btn_Close()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010.02.21
 * 개    요 : Close
 * return값 : void
 */  
function btn_Close() {
    window.close();
}
 
/**
 * openFile()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010.02.21
 * 개    요 : 첨부파일선택
 * return값 : void
 */  
function openFile() {
	INF_UPLOAD.Open();
    
	if (INF_UPLOAD.SelectState) {
		var fileLoc   = INF_UPLOAD.Value;
		var fileNm    = fileLoc.substring(fileLoc.lastIndexOf("\\") + 1);

		 DS_SUGGEST.NameValue(DS_SUGGEST.RowPosition, "FILE_NAME") = fileNm;
		 DS_SUGGEST.NameValue(DS_SUGGEST.RowPosition, "FILE_PASS") = fileLoc; 
	}
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
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<script language=JavaScript for=DS_SUGGEST event=OnLoadCompleted(rowcnt)>
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_SUGGEST  event=OnLoadError()>
    if (this.ErrorCode == 0 ) showMessage(STOPSIGN, OK, "GAUCE-1010");
    else showMessage(STOPSIGN, OK, "GAUCE-1000", this.ErrorMsg);
</script>
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                         
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_">
    <object id=DS_SUGGEST classid=<%=Util.CLSID_DATASET%>></object>
</comment><script>_ws_(_NSID_);</script>

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
                  <SPAN id="title1" class="PL03">건의사항</SPAN>
                </td>
                <td>
                  <table border="0" align="right" cellpadding="0" cellspacing="0">
                    <tr>
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
                      <th width="60">사번</th>
                      <td width="140">
                        <comment id="_NSID_">
                          <object id=EM_USER_ID classid=<%=Util.CLSID_EMEDIT%> height=20 width=100%></object>
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                      <th width="60">이름</th>
                      <td width="140">
                        <comment id="_NSID_">
                          <object id=EM_USER_NM classid=<%=Util.CLSID_EMEDIT%> height=20 width=140></object>
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                    <tr>
                      <th width="60">부서</th>
                      <td width="140">
                        <comment id="_NSID_">
                          <object id=EM_DEPT_NM classid=<%=Util.CLSID_EMEDIT%> height=20 width=140></object>
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                      <th width="60">연락처</th>
                      <td width="140">
                        <comment id="_NSID_">
                          <object id=EM_PHONE_NO classid=<%=Util.CLSID_EMEDIT%> height=20 width=140></object>
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                    <tr>
                      <th width="63">이메일</th>
                      <td colspan=3>
                        <comment id="_NSID_">
                          <object id=EM_E_MAIL classid=<%=Util.CLSID_EMEDIT%> height=20 width=140></object>
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                    <tr>
                      <th width="63">제목</th>
                      <td colspan=3>
                        <comment id="_NSID_">
                          <object id=EM_TITLE classid=<%=Util.CLSID_EMEDIT%> onkeyup="checkByteStr(this, 50, 'Y');" height=20 width=280 tabindex=1></object>
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                    <tr>
                      <td colspan=4>
                        <comment id="_NSID_">
                          <object id=TEXT_CON classid=<%=Util.CLSID_TEXTAREA%> onkeyup="checkByteStr(this, 4000, 'Y');" height=247   width=100% tabindex=1 > 
                          </object>
                        </comment>
                        <script>_ws_(_NSID_);</script>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                    <tr>
                      <th width="63">첨부파일</th>
                      <td colspan=3>
                        <comment id="_NSID_">
                          <object id=EM_FILE classid=<%=Util.CLSID_EMEDIT%> height=20 width=300 ></object>
                        </comment><script>_ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/file_search.gif" onclick="openFile();" align="absmiddle" tabindex=1/>
                      </td>
                    </tr>
                  </table>
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
<comment id="_NSID_">
    <object id=BN_LIST classid=<%= Util.CLSID_BIND %>>
        <param name=DataID value=DS_SUGGEST>
        <param name="ActiveBind" value=true>
        <param name=BindInfo
            value='            
                <c>col=USER_ID    ctrl=EM_USER_ID   param=Text </c>
                <c>col=USER_NM    ctrl=EM_USER_NM   param=Text </c>                         
                <c>col=DEPT_NM    ctrl=EM_DEPT_NM   param=Text </c>   
                <c>col=PHONE_NO   ctrl=EM_PHONE_NO  param=Text </c>            
                <c>col=E_MAIL     ctrl=EM_E_MAIL    param=Text </c>
                <c>col=TITLE      ctrl=EM_TITLE     param=Text </c>            
                <c>col=CONTENTS   ctrl=TEXT_CON     param=Text </c>
                <c>col=FILE_NAME  ctrl=EM_FILE      param=Text </c>
        '>
    </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
    <object id="INF_UPLOAD" classid=<%=Util.CLSID_INPUTFILE%> width="0" height="0">
	    <param name="Text"     			value='FileOpen'>
	    <param name="Enable"   			value="true">
        <param name="FileFilterString"  value="1">
    </object> 
</comment><script> _ws_(_NSID_);</script>
</body>
</html>
