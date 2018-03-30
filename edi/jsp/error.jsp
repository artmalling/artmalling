<%@ page language="java" contentType="text/html;charset=utf-8" import="ecom.util.Util, kr.fujitsu.ffw.util.Date2"  %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>

<html>
<head>
<title></title>
</head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<% request.setCharacterEncoding("utf-8"); %>
<link href="/edi/css/ds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/edi/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/edi/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/edi/js/gauce.js"   type="text/javascript"></script>
<script language="javascript"  src="/edi/js/message.js" type="text/javascript"></script>

<script language="javascript"><!--
//
  var strIcon      = dialogArguments[0];
  var strButton    = dialogArguments[1];
  var strMsgCode   = dialogArguments[2];
  var strMsg       = dialogArguments[3];
  var strSvrMsg    = dialogArguments[4];
  if (dialogArguments[5] != null) {
    var strScreenId  = dialogArguments[5].substr(dialogArguments[5].indexOf(".do") -7, 7);
    var strScreenUrl = dialogArguments[5];
    }
  var strErrorType = strMsgCode.substring(0, strMsgCode.indexOf("-"));
  var strSvrMsgHTML = "";
  var strButtonHTML = "";
  var strServerTagHTML = "";
  var strHeader    = "";
  var blnHidden    = true;
  var occ_date     = '<%=Date2.getDateByPattern("yyyyMMdd")%>';
  var occ_time     = '<%=Date2.getDateByPattern("HHmmss")%>';

  var   usrId  = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';       // 
  var   usrNm  = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />';       // 

  //redirect page
  dialogArguments[6] = "";
  
  function ssCheck() {
    if(usrId==null || usrId=="") {
        usrId = "sripterror";
        usrNm = "스크립트 에러";
    }
  }
  
  function viewDetail(){
    var windowsXPSP2 = false;
    if(navigator.userAgent.indexOf("SV1")) windowsXPSP2 = true;
    if (blnHidden){
      if (windowsXPSP2){
        window.dialogHeight = "400px";
        SERVERMSG.style.display = "";
        blnHidden    = false;
      } else {
        window.dialogHeight = "380px";
        SERVERMSG.style.display = "";
        blnHidden    = false;
      }
    } else {
      if (windowsXPSP2){
        window.dialogHeight = "180px";
        SERVERMSG.style.display = "none";
        blnHidden    = true;
      } else {
        window.dialogHeight = "160px";
        SERVERMSG.style.display = "none";
        blnHidden    = true;
      }
    }
  }
    
  switch (strErrorType){
    case "SERVER" :
      strHeader = "서버 ";
      break;
    case "GAUCE" :
      strHeader = "일반";
      break;
    case "SCRIPT" :
      strHeader = "스크립트 ";
      if(strMsgCode == "SCRIPT-1001"){
          strSvrMsgHTML = strSvrMsg;
      }
        break;
    case "USER" :
      strHeader = "일반";
      break;
    default :
      break;
  } 
    
  function window_close(args){
    if ((DEBUG || strErrorType == "SERVER" || strMsgCode == "SCRIPT-1001") && args == 2){
        // 헤더 초기화
        DS_I_MAILFORM.setDataHeader('usrId:STRING(9),name:STRING(50),sndMail:STRING(50),tel:STRING(50),filePath:STRING(200),fileName:STRING(200),rcvMail:STRING(100),suggestOne:STRING(1000)');
        //TRANSACTION 초기화 
        initTR(TR_MAIN, "0");
        
        ssCheck();
        
        usrNm = usrNm+"("+usrId+")";
        
     // 데이타셋 셋팅.
        DS_I_MAILFORM.Addrow();
        DS_I_MAILFORM.NameValue(DS_I_MAILFORM.RowPosition, "usrId"      ) = usrId;
        DS_I_MAILFORM.NameValue(DS_I_MAILFORM.RowPosition, "name"       ) = usrNm;
        DS_I_MAILFORM.NameValue(DS_I_MAILFORM.RowPosition, "sndMail"    ) = "script@error-dcube.com";
        DS_I_MAILFORM.NameValue(DS_I_MAILFORM.RowPosition, "tel"        ) = "%";
        DS_I_MAILFORM.NameValue(DS_I_MAILFORM.RowPosition, "filePath"   ) = "%";
        DS_I_MAILFORM.NameValue(DS_I_MAILFORM.RowPosition, "fileName"   ) = "%";
        //DS_I_MAILFORM.NameValue(DS_I_MAILFORM.RowPosition, "rcvMail"    ) = "bmjun@kahaholdings.com; bmjun@kahaholdings.com";
        DS_I_MAILFORM.NameValue(DS_I_MAILFORM.RowPosition, "rcvMail"    ) = "gin75@naver.com";
        DS_I_MAILFORM.NameValue(DS_I_MAILFORM.RowPosition, "suggestOne" ) = strSvrMsg;

        
        TR_MAIN.Action="/edi/ecom107.ec?goTo=sendSuggestEmail";
        TR_MAIN.KeyValue="SERVLET(I:DS_I_MAILFORM=DS_I_MAILFORM)";
        TR_MAIN.Post();
        window.returnValue = 1;
        window.close();
    } else {
      window.returnValue = args;
      window.close();
    }
  }
  
  function KeyDown(keyCode){
    if(event.keyCode == 13){ // Enter
      switch(strButton){
        case OK :
        case OKCANCEL : 
        case YESNO :
        case YESNOCANCEL :
          window.returnValue = 1;
          window.close();
          break;
        case RETRYCANCEL :
          window.returnValue = 1;
          window.close();
          break;
        case ABORTRETRYIGNORE :
          window.returnValue = 1;
          window.close();
          break;
        default :
          break;
      }
    } else if (event.keyCode == 27){
      switch(strButton){
        case OK :
          window.returnValue = 1;
          window.close();
          break;
        case OKCANCEL : 
          window.returnValue = 2;
          window.close();
          break;
        case YESNO :
          window.returnValue = 2;
          window.close();
          break;
        case YESNOCANCEL :
          window.returnValue = 3;
          window.close();
          break;
        case RETRYCANCEL :
          window.returnValue = 2;
          window.close();
          break;
        case ABORTRETRYIGNORE :
          window.returnValue = 3;
          window.close();
          break;
        default :
          break;
      }
    }
  }
    
  
  if (strErrorType == "SERVER" || (strErrorType == "SCRIPT" && strMsgCode == "SCRIPT-1001")) {
/*      var strTmp = '<OBJECT id="DS_ERR" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB"></OBJECT>' +
          '<OBJECT id="DS_ID" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB"></OBJECT>' +
          '<OBJECT id="TR_ERR" classid="clsid:78E24950-4295-43d8-9B1A-1F41CD7130E5"></OBJECT>';
*/    
      
      var strTmp = '<object id="DS_ERR" classid=<%= Util.CLSID_DATASET %>></object>' +
          '<object id="DS_ID" classid=<%= Util.CLSID_DATASET %>></object>' +
          '<object id="TR_ERR" classid=<%= Util.CLSID_TRANSACTION %>></object>';
        document.write(strTmp);
  }
//
--></script>


<!----------------------------------------------------------------------------->
<!---------------------- 媛
<!----------------------------------------------------------------------------->
<!-- =============== Input -->
<comment id="_NSID_"><object id="DS_I_MAILFORM"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> <!-- 由ъ 議곌굔  -->

<!-- ============== Output -->

<!-----------------------------------------------------------------------------
  Gauce Transaction Component Declaration
------------------------------------------------------------------------------>
<object id="TR_MAIN"         classid="<%= Util.CLSID_TRANSACTION %>">
  <param name="KeyName"      value="Toinb_dataid4">
</object>

<!----------------------------------------------------------------------------->
<!----------------------------가우스 이벤트 처리-------------------------------->
<!----------------------------------------------------------------------------->

<!------------ 트랜잭션 처리 성공여부를 alert로 알림처리 : 성공했을 경우 ----------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(Information, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!------------ 트랜잭션 처리 성공여부를 alert로 알림처리 : 실패했을 경우 ----------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!!!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "USER-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<body onKeyDown="KeyDown();">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td class="mp01"></td>
    <td class="mp02"></td>
    <td class="mp03"></td>
  </tr>
  <tr>
    <td class="mp04"></td>
    <td class="mp05">
    
    <table border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td>
        <table width="320" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><div class="mp"><div class="img"><img id=ICON src= "/img/icon/p_information.gif"></div></div></td>
        </TR>
        <TR>  
          <td class="mp5_bx" id=MESSAGE valign="middle" height="55px" style="width:100%; border:1 #F1F1F1 solid; overflow:auto;"></td>
        </tr>
        <TR></TR>
      </table>
      </td>
      </tr>
      <tr>
      <td>
     
      <table width="320" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td height="3" ><img src="/img/line/line_1.gif" width="1" height="3"></td>
        </tr>
        <tr>      
          <td align="center" >
            <table id=SERVERMSG width="100%" border="0" cellpadding="0" cellspacing="0" style="vertical-align:top;display:none;">
              <tr>
                <td class="txt"  width="100%" align="center">
                  <textarea id=MESSAGEDESC cols="" rows=" wrap="OFF" style="width:100%; height:200px; border:1 #F1F1F1 solid; overflow:auto;" readOnly="true">
                  </textarea>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr valign="middle" height="25px">
          <td align="center"  width="100%" height="100%" valign="middle">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr valign="middle">
                <td height="25" align="center" valign="middle">
                  <table width="100%" heigth="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td align="center">
                        <img id=BUTTON_ONE src='/edi/imgs/bg/blank.gif' onClick="window_close(1);" style=" margin-top:4px;">
                        <img id=BUTTON_TWO src='/edi/imgs/bg/blank.gif' onClick="window_close(2);" style=" margin-top:4px;">
                        <img id=BUTTON_THREE src='/edi/imgs/bg/blank.gif' onClick="window_close(3);" style=" margin-top:4px;">
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
      </tr>
      </table>
      
    </td>
    <td class="mp06" ></td>
  </tr>
  

  <tr>
     <td class="mp07" ></td>
     <td class="mp08" ></td>
     <td class="mp09" ></td>
  </tr>
</table>
</body>

<script language="JavaScript">
  switch (strIcon.toUpperCase()){
    case INFORMATION :
      strHeader = strHeader + "정보";       
      ICON.src = '/edi/imgs/comm/ms02.gif';
      break;
    case STOPSIGN :
      strHeader = strHeader + "에러";       
      ICON.src = '/edi/imgs/comm/ms04.gif';
      break;
    case EXCLAMATION :
      strHeader = strHeader + "확인";       
      ICON.src = '/edi/imgs/comm/ms03.gif';
      break;
    case QUESTION :
      strHeader = strHeader + "질문";       
      ICON.src = '/edi/imgs/comm/ms01.gif';
      break;
    case NONE :
      strHeader = strHeader + "";     
      IICON.src = '';
      break;
    default :
      break;
  }

  document.title = strHeader;

  switch(strButton){
    case OK :
      BUTTON_ONE.src = '/edi/imgs/btn/confirm.gif';
      break;
    case OKCANCEL :
      BUTTON_ONE.src = '/edi/imgs/btn/confirm.gif';
      BUTTON_TWO.src = '/edi/imgs/btn/cancel.gif';
      break;
    case YESNO : 
      BUTTON_ONE.src = '/edi/imgs/btn/yes.gif';
      BUTTON_TWO.src = '/edi/imgs/btn/no.gif';
      break;
    case YESNOCANCEL :
      BUTTON_ONE.src = '/edi/imgs/btn/yes.gif';
      BUTTON_TWO.src = '/edi/imgs/btn/no.gif';
      BUTTON_THREE.src = '/edi/imgs/btn/cancel.gif';
      break;
    case RETRYCANCEL :
      BUTTON_ONE.src = '/edi/imgs/btn/btn_retry.gif';
      BUTTON_TWO.src = '/edi/imgs/btn/cancel.gif';
      break;
    case ABORTRETRYIGNORE :
      BUTTON_ONE.src = '/edi/imgs/btn/btn_abort.gif';
      BUTTON_TWO.src = '/edi/imgs/btn/btn_retry.gif';
      BUTTON_THREE.src = '/edi/imgs/btn/cancel.gif';
      break;
    default :
       break;
  }  
    
  if (DEBUG || strErrorType == "SERVER" || strMsgCode == "SCRIPT-1001"){
    MESSAGEDESC.value = strSvrMsgHTML;
    BUTTON_TWO.src = '/edi/imgs/btn/btn_err_send.gif';
  }
  MESSAGE.innerHTML = strMsg;
</script>
</html>   
