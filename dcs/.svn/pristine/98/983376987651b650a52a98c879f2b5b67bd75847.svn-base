<!-- 
/*******************************************************************************
 * 시스템명 : SMS전송 팝업
 * 작 성 일 : 2015.04.28
 * 작 성 자 : 전주원
 * 수 정 자 : 
 * 파 일 명 : dctm2034.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : SMS전송
 * 이    력 :
 ******************************************************************************/
--> 
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 

<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"          prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<title>SMS전송-POPUP</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var returnMap   	= dialogArguments[0];
var sName  			= dialogArguments[1];
var sId   				= dialogArguments[2];
var sSMSYn     		= dialogArguments[3];
var sMobile1			= dialogArguments[4];
var sMobile2			= dialogArguments[5];
var sMobile3		= dialogArguments[6];

var sendType = "";

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 
 function doInit(){	
	
	 initEmEdit(EM_CUST_NAME,    "GEN^40",     PK);         //성명
	 
	 initEmEdit(EM_MOBILE_PH2,   "0000",       PK);
	 initEmEdit(EM_MOBILE_PH3,   "0000",       PK);
	 
	RD_SMS_YN.CodeValue = sSMSYn;
	 
	 if (RD_SMS_YN.CodeValue == "Y")
 		sendType = "002"; // SMS수신동의
 	else if (RD_SMS_YN.CodeValue == "N")
 		sendType = "003"; // SMS수신거부
 		
	 RD_SMS_YN.Enable= false;
 		
	 EM_CUST_NAME.text = 	sName;
	 document.getElementById("EM_MOBILE_PH1").value = sMobile1;
	 EM_MOBILE_PH2.text = sMobile2;
	 EM_MOBILE_PH3.text = sMobile3;
 }	
 
/*************************************************************************
 * 2. 함수
*************************************************************************/

   /**
    * btn_Close()
    * 작 성 자 : kj
    * 작 성 일 : 2012.05.08
    * 개    요 : Close
    * return값 : void
    */  
    function btn_Close()
    {
        window.returnValue = false; 
        window.close();
    }
   
    function btn_Conf()
    {	
    	
    	if(trim(EM_CUST_NAME.text).length == 0) {
            showMessage(EXCLAMATION, OK, "USER-1003",  "이름");
            return false;
        }
    	
    	if(trim(EM_MOBILE_PH2.text).length == 0 || trim(EM_MOBILE_PH3.text).length == 0) {
            showMessage(EXCLAMATION, OK, "USER-1003",  "휴대폰번호");
            return false;
        }
    	
    	if (RD_SMS_YN.CodeValue == "Y")
    		sendType = "002"; // SMS수신동의
    	else if (RD_SMS_YN.CodeValue == "N")
    		sendType = "003"; // SMS수신거부
    	
    	
    	var parameters  = "sendType=" + sendType
    								  + "&strMobilePh=" + document.getElementById("EM_MOBILE_PH1").value + trim(EM_MOBILE_PH2.text) + trim(EM_MOBILE_PH3.text);    	
        
    	var msg = EM_CUST_NAME.text +  " [" + document.getElementById("EM_MOBILE_PH1").value + "-" + trim(EM_MOBILE_PH2.text) + "-" +  trim(EM_MOBILE_PH3.text) + "] 님께 SMS를 전송 하시겠습니까?";    	
    	
    	if (confirm(msg) != 0) {
    		
    		document.getElementById("realMobile").src = '/dcs/jsp/dctm/dctm1025.jsp?' + parameters;
    		
    	} else {
    		// cancel
    	}
    	
    }
    
    
	function sendClose(strConfYn){
   		
    	returnMap.put("CONF_YN", strConfYn);
    	
   		
    	window.returnValue = true;
    	window.close();    	
    }
    
    function insSendMobileLog(strSMSMsg) {
    	
    	var goTo       = "insRealMobile" ;    
  	     var action     = "O";
	   	 
  	     /*
  	     	strSendType = 001 (본인인증 인증번호)
  	     							= 002 (수신동의)
  	     							= 003 (수신거부)
  	     */
  	     
	   	 var parameters = "&strSendSite=001"
	   					+ "&strSendType=" + encodeURIComponent(sendType)
	   	 				+ "&strCustName=" + encodeURIComponent(EM_CUST_NAME.text)
	   	 				+ "&strCustId="
	   	 				+ "&strMobilePh1=" + encodeURIComponent(document.getElementById("EM_MOBILE_PH1").value)
						+ "&strMobilePh2=" + encodeURIComponent(EM_MOBILE_PH2.text)
						+ "&strMobilePh3=" + encodeURIComponent(EM_MOBILE_PH3.text)
						+ "&strHP="+ encodeURIComponent(document.getElementById("EM_MOBILE_PH1").value+EM_MOBILE_PH2.text+EM_MOBILE_PH3.text))
	   					+ "&strCellPhoneService="
	   					+ "&strSMSMsg=" + encodeURIComponent(strSMSMsg);
	   	 
  	     TR_MAIN.Action="/dcs/dctm102.dm?goTo="+goTo+parameters;  
  	     TR_MAIN.KeyValue="SERVLET("+action+":DS_LOG=DS_LOG)"; //조회는 O
  	     TR_MAIN.Post();
  	     
  	     sendClose("Y");
    }
    
    /*
    var authNum = "";
    function sendAuthNum() {
    	
    	if(trim(EM_CUST_NAME.text).length == 0) {
            showMessage(EXCLAMATION, OK, "USER-1003",  "이름");
            return false;
        }
    	
    	if(trim(EM_MOBILE_PH2.text).length == 0 || trim(EM_MOBILE_PH3.text).length == 0) {
            showMessage(EXCLAMATION, OK, "USER-1003",  "휴대폰번호");
            return false;
        }
    	
    	authNum = "";
    	
    	var RandVal = Math.random() * (999999-100000) + 100000;
    	authNum = Math.floor(RandVal) + "";
    	
    	var parameters  = "authNum=" + authNum
    								  + "&strMobilePh=" + document.getElementById("EM_MOBILE_PH1").value + trim(EM_MOBILE_PH2.text) + trim(EM_MOBILE_PH3.text);
    	
        
    	var msg = "휴대폰[" + document.getElementById("EM_MOBILE_PH1").value + "-" + trim(EM_MOBILE_PH2.text) + "-" +  trim(EM_MOBILE_PH3.text) + "]으로  인증번호를 전송 하시겠습니까?";
    	
    	
    	if (confirm(msg) != 0) {
    		
    		document.getElementById("realMobile").src = '/dcs/jsp/dctm/dctm1025.jsp?' + parameters;
    		
    	} else {
    		// cancel
    	}
    }
    */
    
   
    
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                        *-->
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
    //for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
    //	showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    //}
    
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    //trFailed(TR_MAIN.ErrorMsg);
    //alert(TR_MAIN.ErrorMsg);
    
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_LOG" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();">

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="pop01"></td>
    <td class="pop02" ></td>
    <td class="pop03" ></td>
  </tr>
  <tr>
    <td class="pop04" ></td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="30" class="title">
              <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
              <span id="title1" class="PL03">SMS전송</span>
            </td>
            <td>
            <table border="0" align="right" cellpadding="0" cellspacing="0">
              
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="popT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="70">이름</th>
                <td>
                	<comment id="_NSID_"> 
                		<object
								id=EM_CUST_NAME classid=<%=Util.CLSID_EMEDIT%> width=120
								tabindex=1
								onkeyup="javascript:checkByteStr(EM_CUST_NAME, 40, '');"
								align="absmiddle">
						</object> 
					</comment> <script> _ws_(_NSID_);</script>
				</td>
              </tr>
              <tr>
                <th width="70">휴대폰번호</th>
                <td>
                	<select name="EM_MOBILE_PH1" id="EM_MOBILE_PH1" style="width: 42px;">
                		<option value="010">010</option>
                		<option value="010">011</option>
                		<option value="016">016</option>
                		<option value="017">017</option>
                		<option value="018">018</option>
                		<option value="019">019</option>
                	</select>
                	&nbsp;-&nbsp; 
	               <comment id="_NSID_">
                		<object id=EM_MOBILE_PH2 classid=<%=Util.CLSID_EMEDIT%> width=40 align="absmiddle" tabindex=2> </object>&nbsp;&nbsp;-&nbsp;&nbsp; 
                		<object id=EM_MOBILE_PH3 classid=<%=Util.CLSID_EMEDIT%> width=40 align="absmiddle" tabindex=3> </object>
                	</comment> 
                	<script> _ws_(_NSID_);</script>
                </td>
              </tr>
              
              <tr>
                <th width="90">SMS 수신동의</th>
                <td>
                	<comment id="_NSID_"> <object id=RD_SMS_YN
                         classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
                         tabindex=1>
                         <param name=Cols value="2">
                         <param name=Format value="Y^예,N^아니오">
                         <param name="AutoMargin" value="true">
                     </object> </comment> <script> _ws_(_NSID_);</script>
                </td>
              </tr>
              
              
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="" class="title">
              
            </td>
            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td></td>
                <td><img src="/<%=dir%>/imgs/btn/confirm.gif" width="50" height="22" onClick="btn_Conf()"/></td>
                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
     <td class="pop06" ></td>
  </tr>
  <tr>
     <td class="pop07" ></td>
     <td class="pop08" ></td>
     <td class="pop09" ></td>
  </tr>
</table>
 
 <div style=position:absolute;left:0px;margin-top:0px;margin-left:0px;float:left;> 
	<iframe id="realMobile" src="" scrolling="no" frameborder="0" width="0" height="0" topmargin="0" leftmargin="0" ></iframe> 
</div> 
 
</body>
</html>
