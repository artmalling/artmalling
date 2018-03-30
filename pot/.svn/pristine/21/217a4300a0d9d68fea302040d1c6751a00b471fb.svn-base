<!-- 
/*******************************************************************************
 * 시스템명 : 비밀번호 변경
 * 작 성 일 : 2010.02.15
 * 작 성 자 : FKL
 * 수 정 자 : 
 * 파 일 명 : tcom0080.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 ******************************************************************************/
--> 
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<title>비밀번호 변경</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_pot.js"   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/ 
 /**
 * doInit()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-15
 * 개    요 : initialize
 * return값 : void
 */

var defaultMsg = "업무용으로만 사용해주세요.";
var firstClick = 0;
function doInit() 
{ 
    // Data Set Header 초기화
    DS_IO_SMS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
    initEmEdit(EM_NAME      , "GEN" , READ);       // 성명 
    initEmEdit(EM_ID        , "GEN" , READ);       // 사번 

    EM_NAME.Text = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />'; 
    EM_ID.Text   = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
} 


/*************************************************************************
 * 3. 함수
*************************************************************************/
/**
 * sendSMS()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.07.04
 * 개    요 : PASSWORD 변경
 * return값 : void
 */  
function btn_Save()
{
	if (!validData()) return;  

	var f = document.all; 
	
	DS_IO_SMS_MASTER.ClearData();
	DS_IO_SMS_MASTER.Addrow();
	
	DS_IO_SMS_MASTER.NameValue(DS_IO_SMS_MASTER.RowPosition, "USER_ID") = EM_ID.Text;
	DS_IO_SMS_MASTER.NameValue(DS_IO_SMS_MASTER.RowPosition, "OLD_PASS_WD") = f.inputPwd1.value;
	DS_IO_SMS_MASTER.NameValue(DS_IO_SMS_MASTER.RowPosition, "NEW_PASS_WD") = f.inputPwd3.value;

    var goTo       = "savePassword" ;    

    TR_MAIN.Action="/pot/tcom008.tc?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_SMS_MASTER=DS_IO_SMS_MASTER)"; 
    TR_MAIN.Post();
}



function validData()
{
	var f = document.all; 
	
	if (f.inputPwd1.value == "") {
        f.inputPwd1.focus();
        return;
    }
    // 패스워드를 Check 한다 
//     if (!validatePwd(f.inputPwd2)) {
//     	f.inputPwd2.value = "";
//     	f.inputPwd3.value = "";
//     	f.inputPwd2.focus();
//         return;
//     }
    if(f.inputPwd2.value==""){
    	alert("비밀번호는 반드시 입력해야 합니다.");
        f.inputPwd2.value = "";
        f.inputPwd2.focus();
        return;
    }
    /* 아트몰링 2017-01-03 패스워드 숫자만 and 4자리 */
    if(f.inputPwd2.value.length != 4){
//     	showMessage(STOPSIGN, OK, "US-1000", "비밀번호는 4자리만 입력 가능합니다.");
 		alert("비밀번호는 4자리만 입력 가능합니다.");
        f.inputPwd2.value = "";
        f.inputPwd2.focus();
        return;
    	
    }
    /* 아트몰링 2017-01-03 패스워드 숫자만 and 4자리 */
    if(!isNumberStr(f.inputPwd2.value)){
//     	showMessage(STOPSIGN, OK, "US-1000", "비밀번호는 수자만 입력 가능합니다.");
		alert("비밀번호는 숫자만 입력 가능합니다.");
        f.inputPwd2.value = "";
        f.inputPwd2.focus();
        return;
    	
    }
    
    if(f.inputPwd3.value==""){
    	alert("비밀번호는 반드시 입력해야 합니다.");
        f.inputPwd3.value = "";
        f.inputPwd3.focus();
        return;
    }
    /* 아트몰링 2017-01-03 패스워드 숫자만 and 4자리 */
    if(f.inputPwd3.value.length != 4){
//     	showMessage(STOPSIGN, OK, "US-1000", "비밀번호는 4자리만 입력 가능합니다.");
		alert("비밀번호는 4자리만 입력 가능합니다.");
        f.inputPwd3.value = "";
        f.inputPwd3.focus();
        return;
    	
    }
    /* 아트몰링 2017-01-03 패스워드 숫자만 and 4자리 */
    if(!isNumberStr(f.inputPwd3.value)){
//     	showMessage(STOPSIGN, OK, "US-1000", "비밀번호는 수자만 입력 가능합니다.");
		alert("비밀번호는 숫자만 입력 가능합니다.");
        f.inputPwd3.value = "";
        f.inputPwd3.focus();
        return;
    	
    }

    
    if (f.inputPwd2.value != f.inputPwd3.value) {
//         showMessage(STOPSIGN, OK, "US-1000", "새로운 비밀번호가 일치하지 않습니다.");
		alert("새로운 비밀번호가 일치하지 않습니다.");
        f.inputPwd3.value = "";
        f.inputPwd3.focus();
        return;
    }
    
    if (EM_ID.Text == f.inputPwd3.value) {
//         showMessage(STOPSIGN, OK, "US-1000", "사번과 동일한 비밀번호는 사용할 수 없습니다.");
        alert("사번과 동일한 비밀번호는 사용할 수 없습니다.");
        f.inputPwd2.value = "";
        f.inputPwd3.value = "";
        f.inputPwd2.focus();
        return;
    }

	return true;
	
}

/**
 * btn_Close()
 * 작 성 자 : FKL
 * 작 성 일 : 2006.07.12
 * 개    요 : Close
 * return값 : void
 */  
function btn_Close()
{
    window.close();
}

function enter() {
	if (event.keyCode == 13) {
		chk();
	}
}    

function chk() {
    if(inputPwd1.value == "" || inputPwd2.value == "" || inputPwd3.value == "") {
        alert("비밀번호를 입력 해 주세요. ");
        return;
    }
}


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
        btn_Close();
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
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
<!-- =============== Output용 -->
<comment id="_NSID_"><object id=DS_IO_SMS_MASTER classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_"><object id="TR_MAIN"        classid="<%=Util.CLSID_TRANSACTION%>"><param name="KeyName"   value="Toinb_dataid4"></object></comment><script> _ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();">
<table width="600" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="pop01"></td>
    <td class="pop02" ></td>
    <td class="pop03" ></td>
  </tr>
  <tr>
    <td class="pop04" ></td>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td class="PB05 PT05">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="" class="title">
                  <img src="/<%=dir%>/imgs/comm/title_head.gif" align="absmiddle" class="popR05 PL03" />
                  <SPAN id="title1" class="PL03">비밀번호 변경</SPAN>
                </td>
                <td>
                  <table border="0" align="right" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td><img src="/<%=dir%>/imgs/btn/save.gif"    onClick="btn_Save();" /></td>
                      <td><img src="/<%=dir%>/imgs/btn/close.gif"   onClick="btn_Close();" /></td>
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
          <td class="PT10 PL20 PR20 PB20">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
              <tr>
                <td>
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                  
                    <tr>
                      <th width="100" class="point">성명</th>
                      </td>
                      <td class="PL05 PR05 left">
                        <comment id="_NSID_"><object id=EM_NAME classid=<%=Util.CLSID_EMEDIT%> width=130> </object> </comment> <script> _ws_(_NSID_);</script>
                      </td>
                    </tr>
                    <tr>
                      <th width="100" class="point">사번</th>
                      </td>
                      <td class="PL05 PR05 left">
                        <comment id="_NSID_"><object id=EM_ID classid=<%=Util.CLSID_EMEDIT%> width=130> </object> </comment> <script> _ws_(_NSID_);</script>
                      </td>
                    </tr>
                    <tr>
                      <th width="100" class="point">현재 비밀번호</th>
                      </td>
                      <td class="PL05 PR05 left">
                        <input type="password" id="inputPwd1"  value=""  class="input1" tabindex="1" onKeyDown="javascript:enter();"><input type="hidden" name="pwd">
                        
                      </td>
                    </tr>
                    <tr>
                      <th width="100" class="point">새 비밀번호</th>
                      </td>
                      <td class="PL05 PR05 left">
                        <input type="password" id="inputPwd2"  value=""  class="input1" tabindex="2" onKeyDown="javascript:enter();"><input type="hidden" name="pwd">
                        (영문과 숫자조합6~20자 )   
                      </td>
                    </tr>
                    <tr>
                      <th width="100" class="point">새 비밀번호 확인</th>
                      </td>
                      <td class="PL05 PR05 left">
                        <input type="password" id="inputPwd3"  value=""  class="input1" tabindex="3" onKeyDown="javascript:enter();"><input type="hidden" name="pwd">
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
    <td class="pop06" ></td>
  </tr>
  <tr>
    <td class="pop07" ></td>
    <td class="pop08" ></td>
    <td class="pop09" ></td>
  </tr>
</table>
</body>
</html>
