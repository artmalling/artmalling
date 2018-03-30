<%
/*******************************************************************************
  * 시스템명 : 공통 > 로그인 화면
  * 작 성 일 : 2007-12-13
  * 작 성 자 : 김혜경
  * 수 정 자 :
  * 파 일 명 : login.jsp
  * 버    전 : 1.0
  * 개    요 : 로그인 화면 입니다.
  * 이    력 : 
  *****************************************************************************/
%>  
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ page import="kr.fujitsu.ffw.util.Date2"%>
<%@ page import="common.util.Util"%>
<%@ page import="java.net.InetAddress" %>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ page import="common.ccom.action.CCom001Action,common.ccom.vo.*,ks.cipher.RSAKey,javax.servlet.http.HttpSession,javax.servlet.http.HttpServletRequest"%>
<%@ page import="common.util.SessionBindManager"%>
<%!
    SessionBindManager loginManager = SessionBindManager.getInstance();
%>
<%
	//HttpServletRequest request = new HttpServletRequest();
	
	HttpSession session1  = request.getSession();         
	SessionInfo rsaInfo   = null;
	rsaInfo               = (SessionInfo)session1.getAttribute("rsaInfo");
	SessionInfo user      = new SessionInfo();
	String modulus        = "";
	String publicExponent = "";
	RSAKey rsaKey         = null;
	user.setKey();
	modulus        = RSAKey.toHex(user.getKey().getModulus());
	publicExponent = RSAKey.toHex(user.getKey().getPublicExponent());
	session1.setAttribute("rsaInfo", user);
	
    //정상적으로 로그인을 하지 않을경우 세션에 남아있는 userId를 제거한다.
    session1.removeAttribute("userId");
	
    String sSvrGb = "";
    InetAddress inetServerIp= InetAddress.getLocalHost(); // Server Ip
    String strServerAddrTemp = inetServerIp.getHostAddress();
    String strRemoteAddrTemp = request.getRemoteAddr().toString();
    String strSvrLastIp = strServerAddrTemp.substring(strServerAddrTemp.lastIndexOf("."),strServerAddrTemp.length());
    //out.println("strRemoteAddrTemp ==>"+strRemoteAddrTemp);
    //out.println("strServerAddrTemp ==>"+strServerAddrTemp);
    //out.println("strSvrLastIp ==>"+strSvrLastIp);
    if(strRemoteAddrTemp.matches("127.0.0.1")||strRemoteAddrTemp.matches("localhost")||strRemoteAddrTemp.indexOf("0:0:0:0")>-1){
        sSvrGb = "LC";
    }else if(strSvrLastIp.equals(".94")){
        sSvrGb = "QA";
    }else {
        sSvrGb = "RL";
    }
    //out.println("sSvrGb ==>"+sSvrGb);


// 	out.print("<p>Remote Addr: " + request.getRemoteAddr() + "</p>");
// 	out.print("<p>Remote Host: " + request.getRemoteHost() + "</p>");
// 	out.print("<p>X-Forwarded-For: " + request.getHeader("x-forwarded-for") + "</p>");
			 
//     String aaa = getClientIpAddress(request);

//     System.out.println("%%%%%%%로그인페이지%%%%%%%");
//     System.out.println("aaa = " + aaa);
//     System.out.println("%%%%%%%로그인페이지%%%%%%%");
	
%>
<%
    
%>
<html>
<head>
<title>▒ 공항 면세점 통합정보시스템 ▒</title>
<link rel="stylesheet" href="/dfree/css/style.css" type="text/css"> 
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html;charset=euc-kr">

<script language="javascript" src="/dfree/js/gauce.js"         type="text/javascript"></script>
<script language="javascript" src="/dfree/js/global.js"        type="text/javascript"></script>
<script language="javascript" src="/dfree/js/common.js"        type="text/javascript"></script>
<script language="javascript" src="/dfree/js/message.js"       type="text/javascript"></script>
<script language="javascript" src="/dfree/js/sale.js"          type="text/javascript"></script>
<script language="javascript" src="/dfree/js/rsa/tea-block.js" type="text/javascript"></script>
<script language="javascript" src="/dfree/js/rsa/base64.js"    type="text/javascript"></script>
<script language="javascript" src="/dfree/js/rsa/utf8.js"      type="text/javascript"></script>
<script language="javascript" src="/dfree/js/rsa/jsbn.js"      type="text/javascript"></script>
<script language="javascript" src="/dfree/js/rsa/rsa.js"       type="text/javascript"></script>
                                                               

<script language="javascript">
<!-- 
self.moveTo(0,0); 
self.resizeTo(screen.availWidth,screen.availHeight); 
self.opener = "";
//--> 
</script>   
<script language="javascript">
    //var myWinLocal  = "";
    var myWinServer      = "";
    
    function GenerateKey(){
        time = new Date().getTime();
        //random = Math.floor(65536*Math.random());
        random = "iia";
        return (time*random).toString();    
    }
    
    function EncryptTEA(k, text){   
        return Tea.encrypt(text, k);    
    }
    
    function EncryptRSA(m, e, text){
        var rsa = new RSAKey();
        rsa.setPublic(m, e);
        return rsa.encrypt(text);
    }
    function doInit() {
        // --------- 공지 사항 쿠키가 있는지 확인
        //if(getCookie("GJ_PopUp_CK") != "no"){
        //--------- 공지사항 팝업 화면
        //  window.showModalDialog('/dfree/jsp/common/ccom/ccom9990.jsp', 'pop' ,'dialogWidth:480px;dialogheight:340px;dialogLeft:20px;toolbar=no;status:no;help:no;scroll:no');
        //}
        //setFocus(document.myForm);
        //document.myForm.inputId.value = 'sale';
        //document.myForm.inputPwd.value = '1234';
        
        document.myForm.inputId.focus();
        window.dialogLeft = 0;
        
        //chk();
    }


    /**
     * searCh()
     * 작 성 자 : 박래형 
     * 작 성 일 : 2015-07-23
     * 개    요 : 조회시 호출
     * return값 : void
     */
    function searCh(strId){
         
        // 조회조건
        var parameters  = "&strId=" + strId
                        ;
        // 호출
        TR_SEARCH.Action   = "/dfree/ccom001.cc?goTo=searchUserInfo" + parameters;
        TR_SEARCH.KeyValue = "SERVLET(O:DS_MASTER=DS_MASTER)";        // 조회는 O
        TR_SEARCH.Post();  

//      alert("COUNT = " + DS_MASTER.CountRow);
    }
    
    // ------------- 아이디 셋팅 및 포커스
    function setFocus(form) {
         form.checksaveid.checked = ((form.inputId.value = getCookie("saveid")) != "");
        if ( form.inputId.value == '')
            document.myForm.inputId.focus();
        else
            document.myForm.inputPwd.focus();
    }
    
    //------------- 윈도우 오픈
    function winOpen(name, url, left, top, width, height, toolbar, menubar, statusbar, scrollbar, resizable) {
        toolbar_str    = toolbar   ? 'yes' : 'no';
        menubar_str    = menubar   ? 'yes' : 'no';
        statusbar_str  = statusbar ? 'yes' : 'no';
        scrollbar_str  = scrollbar ? 'yes' : 'no';
        resizable_str  = resizable ? 'yes' : 'no';
        
        //height = height - 55 ;
        //width  = width  - 10;    
        
        height = height - 55 ;
        width  = width  - 8;    
        
        myWin      = window.open(url, name, 'left='+left+',top='+top+',width='+width+',height='+height+',toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);

        //----------- 팝업 차단 설정이 되어 있는 경우
        if(!myWin) {
            alert("팝업 차단 상태입니다... [도구] -> [팝업차단] - > 팝업 차단 사용 안 함으로  설정하세요...");
        } 
   
        return myWin;           
    }
    
    //------------- 로그인 버튼을 눌렀을 때
    function chk() {     
        
        var winName = document.myForm.inputId.value;
        if(document.myForm.inputId.value == "") {
            alert(" ID를 입력 해 주세요. ");
            return;
        }
        
        if(document.myForm.inputPwd.value == "") {
            alert(" Password를 입력 해 주세요. ");
            return;
        }   
        
        var key     = GenerateKey();
        var ePasswd = EncryptTEA(key, document.myForm.inputPwd.value);
        
        var m = document.getElementById('iFormCommon').m.value;
        var e = document.getElementById('iFormCommon').e.value;
        eKey  = EncryptRSA(m, e, key);

		// 사용자 조회
		searCh(document.myForm.inputId.value);
		
		var strUserDataIp  = DS_MASTER.NameValue(DS_MASTER.rowposition, "USR_IP_ADDR");
		var strUserGroupCd = DS_MASTER.NameValue(DS_MASTER.rowposition, "GROUP_CD");
		
		//alert("strUserDataIp    = " + strUserDataIp);
		//alert("strUserGroupCd   = " + strUserGroupCd);
		  
        myWinServer = winOpen(winName,'', 0, 0, screen.availWidth, screen.availHeight, 0, 0, 1, 0, 1);
        myWinServer.document.write("<form name=myForm id=myForm>");
        myWinServer.document.write("<input type=hidden name=id          value=''    />");
        myWinServer.document.write("<input type=hidden name=pwd         value=''    />");
        myWinServer.document.write("<input type=hidden name=key         value=''    />");
        myWinServer.document.write("<input type=hidden name=ipAddress   value=''    />");
        myWinServer.document.write("<input type=hidden name=inputId     value=''    />");
        myWinServer.document.write("<input type=hidden name=inputPwd    value=''    />");
        myWinServer.document.write("<input type=hidden name=failCnt     value='0'   />");
        myWinServer.document.write("</form>");
        
        var f = myWinServer.document.getElementById("myForm");
        f.action          = '/dfree/ccom001.cc?goTo=login';
        f.method          = 'post';
        f.target          = '_self';
        f.id.value        = document.myForm.inputId.value;
        f.pwd.value       = ePasswd;
        f.key.value       = eKey;
        f.ipAddress.value = "";
        f.inputId.value   = '';
        f.inputPwd.value  = '';
        f.failCnt.value   = '';    // 20150709 추가
        f.submit();
       
        myWinServer.focus();
        
        //자동창닫기 기능
        window.opener = 'Self';
        window.open('', '_parent', '');
        window.close();
    }
    
    //----------- Enter Key를 입력 했을 때
    function enter () {
        if(event.keyCode == 13) {
            chk();
        }
    }   
    
    //--------- 승인 요청 팝업 화면
    function showRequest() {
        openDialogWin('/dfree/ccom002.cc?goTo=list','request',439, 463, 'no', 'center');        
    }

    //--------- 쿠키 설정하기
    function setCookie (name, value, expires) {
        document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
    }
    
    //--------- 쿠키 가져오기
    function getCookie(Name) {
        var search = Name + "="
        //--------- 쿠키의 정보가 있는지 검사
        if (document.cookie.length > 0) { 
            offset = document.cookie.indexOf(search)
            //--------- 찾고자하는 이름의 쿠키가 있다면
            if (offset != -1) {
                offset += search.length
                end = document.cookie.indexOf(";", offset)
                if (end == -1)
                    end = document.cookie.length
             return unescape(document.cookie.substring(offset, end))
             }
        }
        return "";
    }
    
    function saveid(form) {
        var expdate = new Date();

        if (form.checksaveid.checked){
            //--------- 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
            expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); 
        }
        else{
            //--------- 쿠키의 저장시간을 이전으로 저장한다
            expdate.setTime(expdate.getTime() - 1); 
        }
        setCookie("saveid", form.inputId.value, expdate);
    }
    
    function selfClose() { 
        if (/MSIE/.test(navigator.userAgent)) { 
            if(navigator.appVersion.indexOf("MSIE 7.0")>=0) {
                //IE7에서는 아래와 같이
                window.open('about:blank','_self').close();
            }
            else { 
                //IE7이 아닌 경우
                window.opener = self; 
                self.close(); 
            }                       
        } else { 
            window.name = '__t__'; 
            var w = window.open('about:blank'); 
            w.document.open(); 
            w.document.write('<html><body><script type="text/javascript">function _(){var w=window.open("about:blank","'+window.name+'");w.close();self.close();}</'+'script></body></html>'); 
            w.document.close(); 
            w._(); 
        } 
    } 
    
    function handGinstallWinOpen()
    {
        var myWin = winOpen('myWin','/dfree/html/ginstall_hand.html' , 50, 0,1024 , 768, 0, 0, 1, 1, 1);
        myWin.focus();       

    }
    
    
</script>

<comment id="_NSID_"><object id="DS_MASTER"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- 메인 -->
<comment id="_NSID_">
    <object id="TR_MAIN" classid="<%=Util.CLSID_TRANSACTION%>">
        <param name="KeyName" value="Toinb_dataid4">
    </object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 조회 -->
<comment id="_NSID_">
    <object id="TR_SEARCH" classid="<%=Util.CLSID_TRANSACTION%>">
        <param name="KeyName" value="Toinb_dataid4">
    </object>
</comment>
<script>_ws_(_NSID_);</script>
</head>

<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onLoad="doInit();">
<!---///로고--->
<form  name="myForm" method="post">
<input type="hidden" name="key" value="" />
<table width="100%" height="416" border="0" cellspacing="0" cellpadding="0" align=center>
<tr> 
    <td align="center" valign="top" >
    <table width="728" border="0" cellspacing="0" cellpadding="0" align=center> 
    <tr>
        <td height="100">
        </td>
    </tr>
      <tr>
       <td align="center" valign="middle" width="718" height="416"  background="/dfree/img/common/login_01.gif"><table width="718" border="0">
          <tr>
            <td height="207"><p>&nbsp;</p>
              <p>&nbsp;</p>
              <p>&nbsp;</p>
              <p>&nbsp;</p>
              <p>&nbsp;</p>
              <p>&nbsp;</p>
              <p>&nbsp;</p>
              <p>&nbsp;</p></td>
          </tr>
          <tr>
            <td height="15"><table width="718" border="0">
              <tr>
                <td width="194" height="21">&nbsp;</td>
                <td width="66"><img src="/dfree/img/common/login_02.gif" width="50" height="16" /></td>
                <td width="168"><input type="text" size="18"  class="input5" name="inputId" value="dev_prh" tabindex="1" style='IME-MODE:disabled;'><input type="hidden" name="id"></td>
                <td width="85" rowspan="2"><img src="/dfree/img/common/login_04.gif" width="84" height="43"  onClick="javascript:chk();" style="cursor:hand" /></td>
                <td width="183">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><img src="/dfree/img/common/login_03.gif" width="50" height="16" /></td>
                <td><input type="password" size="18" class="input5" name="inputPwd" value="160102!@" tabindex="2" onKeyDown="javascript:enter();">
                <input type="hidden" name="pwd"></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>
                    <input type="hidden" name="failCnt" value="0" />
                    <input type="hidden" name="ipAddress">
                </td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr> 
        <!---///--->
        <!---///카피라이트---> 
      <tr>
<!--         <td width="718" height="16" align="center"><img src="/dfree/img/common/login_06.gif"></td> -->
      </tr>
      <tr>
          <td width="100%" align="right"><a onclick="javascript:handGinstallWinOpen()"><u style="cursor:hand">☞수동설치</u></a></td>
      </tr>
    </table></td>
      </tr> 
    </table>
</form>
<form id="iFormCommon">
    <input type="hidden" name="base" value="/" />   
    <input type="hidden" name="e" value="<%=publicExponent%>" />            
    <input type="hidden" name="m" value="<%=modulus%>" />  
</form>
</body>
</html>