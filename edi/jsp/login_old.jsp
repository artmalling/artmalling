
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="ecom.vo.SessionInfo2, kr.fujitsu.ffw.base.BaseProperty" %>
<%@ page import="ecom.util.Util" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>
<%@ page import="java.util.*" %>

<%
     request.setCharacterEncoding("utf-8");
     String dir = request.getContextPath();
     SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
     String userid = sessionInfo == null ? "" : sessionInfo.getUSER_ID();

%>

<ajax:library />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링 EDI 시스템</title>
<link href="<%=dir%>/css/ds_edi2.css" rel="stylesheet" type="text/css" />
<script language="javascript"  src="<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/global.js"    type="text/javascript"></script>

<script language="javascript">
<!--
//윈도우 위치 이동(절대좌표)
self.moveTo(0,0);
//윈도우 크기 결정(절대좌표)
self.resizeTo('1024','768');
self.opener = "";
//-->
</script>

<script language="javascript">
//윈도우 오픈 함수 선언
var myWinServer = "";
var strGbn = "";
var strMst = "";
var strLogin = "";
var strOut = "";
/**************************************
 * 초기화                                                            *
 **************************************/
function doInit() {
	// [긴급]공지사항 POP
	//openPopNotice();

    // 공지 사항 쿠키가 있는지 확인
    window.dialogLeft = 0
    // 점코드가져오는 함수
    getStrcd()
    // 시스템 담당자가져오는 함수
    getSystem();
    // 점콤보에 포커스
    document.myForm.strcd.focus();

}

/**
 * [긴급]공지사항 POP
 */
function openPopNotice() {
    // [긴급]공지사항 POP
    var strPopName  = "/edi/html/popup/popup_20110919.html";
    var strToday    = getTodayFormat("YYYYMMDD");
    if ( (notice_getCookie( "noticePopOpen" ) != "done" ) &&    // 쿠키 체크
         (eval(strToday) <= 20110919) ) {                       // 일자 체크
    	window.showModalDialog(strPopName ,"" ,"dialogWidth:337px;dialogHeight:339px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
    }
}

/**************************************
 *  점코드                                                          *
 **************************************/
function getStrcd(useYn, flag, str_flag){

   var param = "&goTo=getStrcd";
   <ajax:open callback="on_loadedXML"
       param="param"
       method="POST"
       urlvalue="/edi/ecom001.ec"/>

   <ajax:callback function="on_loadedXML">

       var strcd = document.getElementById("strcd");
       for( i = 0; i < rowsNode.length; i++ ){
           var opt = document.createElement("option");
           opt.setAttribute("value", rowsNode[i].childNodes[0].childNodes[0].nodeValue);

           var text = document.createTextNode(rowsNode[i].childNodes[1].childNodes[0].nodeValue);
           opt.appendChild(text);
           strcd.appendChild(opt);
       }

   </ajax:callback>
}

/*
 * 시스템 담당자
 */

function getSystem(){
    var param = "&goTo=getSystem";
       <ajax:open callback="on_loadedXML"
           param="param"
           method="POST"
           urlvalue="/edi/ecom001.ec"/>

    <ajax:callback function="on_loadedXML">

       var name = rowsNode[0].childNodes[3].childNodes[0].nodeValue;
       var phone = rowsNode[0].childNodes[4].childNodes[0].nodeValue;

       document.getElementById("systemNm").value = name;
       document.getElementById("systemph").value = phone;

    </ajax:callback>

}

//------------- 로그인 버튼을 눌렀을 때
function chk() {
    if(document.myForm.userid.value == "") {
        showMessage(StopSign, Ok, "USER-1003", "ID");
        document.myForm.userid.focus();
        return;
    }
    if(document.myForm.pwd.value == "") {
        showMessage(StopSign, Ok, "USER-1003", "PASSWORD");
        document.myForm.pwd.focus();
        return;
    }

   //if('<%=userid%>' != ""){
//     alert("이미로그인되어있습니다.");
//     return;
 //  }
    exit();
  // 로그인 로직 시작전 아이디 패스워드 유효 여부 체크
   chkIdPwd();

}

/*
 * 아이디 비번 유효성체크
 */
function chkIdPwd(){
    var strcd = document.getElementById("strcd").value;
    var userId = document.getElementById("userid").value;
    var password = document.getElementById("pwd").value;
    var orgCode = "1";//document.myForm.orgCode[0].checked == true ? "2" : "1";

    var param = "&goTo=chkIdPwd" + "&strcd=" +   strcd
    + "&userId=" +   userId
    + "&password=" + encodeURIComponent(password)
    + "&orgCode=" + orgCode;

    var Urleren = "/edi/ecom004.ec";
    URL = Urleren + "?" +param;
    strMst = getXMLHttpRequest();
    strMst.onreadystatechange = responseMaster;
    strMst.open("POST", URL, true);
    strMst.send(null);

}

/**
 * responseMaster()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  디테일 조회 시 조회 그리드에 데이터 넣기
 * return값 : void
 */
function responseMaster()
{
     if(strMst.readyState==4)
     {
          if(strMst.status == 200)
          {
              strMst = eval(strMst.responseText);
              var orgCode = "1";//document.myForm.orgCode[0].checked == true ? "2" : "1";
              if (strMst == undefined) {
                    var userId = document.getElementById("userid").value;
                    if(userId.length > 5) {
                        pwd_cnt();
                        document.getElementById("login_error").style.display = "inline";
                        showMessage(Information, Ok, "GAUCE-1000", "비밀번호가 틀렸습니다.");
                        return;
                    } else {
                        pwd_cnt();
                        document.getElementById("login_error").style.display = "none";
                        showMessage(Information, Ok, "GAUCE-1000", "비밀번호가 틀렸습니다.");
                        return;
                    }

              } else {
                  if( orgCode == "2" ){
                      if(strMst[0].PWD_CNT >= 20){
                          if(strMst[0].GB == "@") {
                              document.getElementById("login_error").style.display = "none";
                          }
                          else {
                              document.getElementById("login_error").style.display = "inline";
                          }
                          showMessage(QUESTION, Ok, "GAUCE-1000", "비밀번호 20회 틀리셨습니다.<br> 로그인 하실 수 없습니다. <br> 관리자에게 문의 하시기 바랍니다.");
                          return;
                      }else{
                          chkLogin();
                      }
                  }else if( orgCode == "1" ){
                      if(strMst[0].PWD_CNT >= 20){
                          if(strMst[0].GB == "@") {
                              document.getElementById("login_error").style.display = "none";
                          }
                          else {
                              document.getElementById("login_error").style.display = "inline";
                          }
                          showMessage(QUESTION, Ok, "GAUCE-1000", "비밀번호 20회 틀리셨습니다.<br> 로그인 하실 수 없습니다. <br> 관리자에게 문의 하시기 바랍니다.");
                          return;
                      }else{
                          chkLogin();
                      }
                  }
              }
          }
     }
}

/**
 * getXMLHttpRequest()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  인터넷 유효성 체크??
 * return값 : void
 */
function pwd_cnt(){
    // alert();
     var strcd = document.getElementById("strcd").value;
     var userId = document.getElementById("userid").value;

    var param = "&goTo=idUpSelect" + "&strcd=" +   strcd
    + "&userId=" +   userId;

    strLogin = createXMLHttpRequest();
    var url = "/edi/ecom004.ec?"+param;//URL
    strLogin.onreadystatechange = responseLogin;  //콜백 함수  등록
    strLogin.open("POST", url, true);//연결
    strLogin.setRequestHeader('Content-Type','application/x-www-form-urlencoded');   //한글 (POST시 반듯이 해당문구를 사용해야 Param으로인식)
    strLogin.send(null);//전송

}


 /**
  * responseLogin()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :
  * return값 : void
  */
 function responseLogin()
 {
      if(strLogin.readyState==4)
      {
           if(strLogin.status == 200)
           {
               strLogin = eval(strLogin.responseText);
           }
      }
 }

/**
 * getXMLHttpRequest()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  인터넷 유효성 체크??
 * return값 : void
 */
function getXMLHttpRequest(){
    if(window.ActiveXObject){
    try{
           return new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch(e1){
     try{
          return new ActiveXObject("Microsoft.XMLHTTP");
     }
     catch (e2){
          return null;
     }
    }
   }
   else if(window.XMLHttpRequest){
        return new XMLHttpRequest();
   }
   else
   {
        return null;
   }
}

function chkLogin(){
    var message = '';
    var winName = document.myForm.userid.value;
  //  alert("1");
   /* if(strGbn != "" || strGbn != null){
        alert();
        return;
    }
    */
    myWinServer = winOpen(winName,'', 0, 0, 1024, 768, 0, 0, 1, 0, 1);
    document.myForm.target = winName;
    document.myForm.action = '/edi/ecom001.ec?goTo=login';
    document.myForm.strcd.value = document.myForm.strcd.value;
    document.myForm.id.value = document.myForm.userid.value;
    document.myForm.pwd.value = document.myForm.pwd.value;
    document.myForm.org.value = "1";
    //document.myForm.orgCode[0].checked == true ? "2" : "1";
    document.myForm.submit();

    myWinServer.focus();

  	//창묻지않고 닫기
	//손영대과장님 요청 2010.03.28
	if (/MSIE/.test(navigator.userAgent)) {
		//Explorer 7일때
		if (navigator.appVersion.indexOf("MSIE 7.0") >= 0) {
			window.open('about:blank', '_self').close();
		} //Explorer 8일때
		else if (navigator.appVersion.indexOf("MSIE 8.0") >= 0) {
			window.open('about:blank', '_self').close();
		} //Explorer 9일때
		else if (navigator.appVersion.indexOf("MSIE 9.0") >= 0) {
			window.open('about:blank', '_self').close();
		} //Explorer 7,8,9  가 아닐 때
		else {
			(self.opener = self).close();
		}
	}
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
    //alert("1");
    myWin = window.open(url, name, 'left='+left+',top='+top+',width='+width+',height='+height+',toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);

    //----------- 팝업 차단 설정이 되어 있는 경우
    if(!myWin) {
        alert("팝업 차단 상태입니다. [도구] >> [팝업차단] >> 팝업 차단 사용 안함으로 설정하십시오.");
    }

    return myWin;
}


/*
 * 브랜드 담당자
 */
function blandNm(){

    var strcd = document.getElementById("strcd").value;
    var userId = document.getElementById("userid").value;
    var orgCode = "1";//document.myForm.orgCode[0].checked == true ? "2" : "1";

    if( userId.length == 0 ){
        return;
    }

    var param = "&goTo=brandNm&strcd="+strcd+"&userId="+userId+"&orgCode="+orgCode;

    <ajax:open callback="on_loadedXML"
        param="param"
        method="POST"
        urlvalue="/edi/ecom001.ec"/>

    <ajax:callback function="on_loadedXML">

        if( rowsNode.length > 0 ){
            var usrName = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
            var phone = rowsNode[0].childNodes[1].childNodes[0].nodeValue;

            document.getElementById("BlandName").value = usrName;
            document.getElementById("BlandPhone").value = phone;
        }else {
            return;
        }

    </ajax:callback>

}

function loginGb() {
    var strcd = document.getElementById("strcd").value;
    var strUser = document.getElementById("userid").value;

    var param = "&goTo=getGBN&strUser="+strUser+"&strcd="+strcd;

    <ajax:open callback="on_loadedXML"
        param="param"
        method="POST"
        urlvalue="/edi/ecom001.ec"/>

    <ajax:callback function="on_loadedXML">

        if( rowsNode.length > 0 ){
            strGbn = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
        }else {
            return;
        }

    </ajax:callback>

}


/*
 * 에러 이미지 파일 (사라지기)
 */
function displays(){
    document.getElementById("login_error").style.display = "none";
}
function enter () {
    if(event.keyCode == 13) {
        chk();
    }
}

// 아이디/비밀번호 value
function change_value(obj){
    var userid = document.getElementById('userid');
    var pwd = document.getElementById('pwd');

    if(obj == 'userid'){
        userid.style.background   = "";
    }
    if(obj == 'pwd'){
        pwd.style.background   = "";  //background-image
    }
}

// 아이디/비밀번호 out
function change_re(obj){
    var userid = document.getElementById('userid');
    var pwd = document.getElementById('pwd');

    if(obj == 'userid' && userid.value == ""){
        userid.style.background   = "url(<%=dir%>/imgs/edi/id.jpg)";
    }
    if(obj == 'pwd' && pwd.value == ""){
        pwd.style.background   = "url(<%=dir%>/imgs/edi/password.jpg)";
    }
}



function exit() {
    //alert();
    var param = "&goTo=logout";

    var Urleren = "/edi/ecom001.ec";
    URL = Urleren + "?" +param;
    strOut = getXMLHttpRequest();
    strOut.onreadystatechange = responselogout;
    strOut.open("POST", URL, true);
    strOut.send(null);
}

/**
 * responselogout()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  디테일 조회 시 조회 그리드에 데이터 넣기
 * return값 : void
 */
function responselogout()
{
     if(strOut.readyState==4)
     {
          if(strOut.status == 200)
          {
          //    strOut = eval(strOut.responseText);
          }
     }
}

/**
 * getXMLHttpRequest()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  인터넷 유효성 체크??
 * return값 : void
 */
function getXMLHttpRequest(){
    if(window.ActiveXObject){
    try{
           return new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch(e1){
     try{
          return new ActiveXObject("Microsoft.XMLHTTP");
     }
     catch (e2){
          return null;
     }
    }
   }
   else if(window.XMLHttpRequest){
        return new XMLHttpRequest();
   }
   else
   {
        return null;
   }
}

/*쿠키값 체크*/
function notice_getCookie( name ) {
    var nameOfCookie = name + "=";
    var x = 0;
    while ( x <= document.cookie.length ) {
        var y = (x+nameOfCookie.length);
        if ( document.cookie.substring( x, y ) == nameOfCookie ) {
            if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
                endOfCookie = document.cookie.length;
            return unescape( document.cookie.substring( y, endOfCookie ) );
        }
        x = document.cookie.indexOf( " ", x ) + 1;
        if ( x == 0 )  break;
    }
    return "";
}
</script>

</head>
<body style="background-image:url(<%=dir%>/imgs/edi/edi_bg.gif); background-repeat:repeat-x;" onload="doInit();">
<form  name="myForm" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="51" class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="PL10"><img src="<%=dir%>/imgs/edi/edi_logo.gif" width="238" height="37" show="false"/></td>
        <td valign="bottom" class="PB03 PR05"><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <!-- td><a href="http://www.mariooutlet.co.kr" target="_blank">아트몰링 홈페이지</a></td>
            <td class="PR05 PL05"><img src="<%=dir%>/imgs/edi/login_tx_bar.gif" width="1" height="9" /></td>
            <td><a href="http://www.mariooutlet.co.kr" target="_blank"> 윤리경영</a></td>
            <td class="PR05 PL05"><img src="<%=dir%>/imgs/edi/login_tx_bar.gif" width="1" height="9" /></td>
            <td><a href="http://www.mariooutlet.com" target="_blank"> 협력사 온라인채널</a></td-->
            <td class="PR05 PL05"><img src="<%=dir%>/imgs/edi/login_tx_bar.gif" width="1" height="9" /></td>
            <td> <a href="http://www.mariooutlet.co.kr" target="_blank">아트몰링 홈페이지</a></td>
            </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="100">&nbsp;</td>
  </tr>
  <tr>
    <td class="PB20"><table width="960" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="460" valign="top"><table width="460" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="PT10 PL10"><img src="<%=dir%>/imgs/edi/login_title.gif" width="343" height="49" show="false"/></td>
            </tr>
          <tr>
            <td class="PT15 PL10 PB20"><img src="<%=dir%>/imgs/edi/login_tx01.gif" width="343" height="65" show="false" /></td>
            </tr>
          <tr>
            <td><table width="460" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="21" valign="top"><img src="<%=dir%>/imgs/edi/edi_login_bx_01.gif" width="21" height="336" show="false" /></td>
                <td valign="top" class="edi_login_bx" ><table width="380" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td height="30">&nbsp;</td>
                    </tr>
                  <tr>
                    <td height="40" ><img src="<%=dir%>/imgs/edi/edi_login_tx_01.gif" width="155" height="17" show="false" /></td>
                    </tr>
                  <tr>
                  <!-- Login 입력정보 (점, ID, PW) -->
                    <td><table width="340" border="0" align="center" cellpadding="0" cellspacing="0">
                      <tr>
                      <!-- Login 점콤보 -->
                        <td height="35">
                          <select name="strcd" id="strcd" class="edi_login_combo" style="font-weight: bold">
                          </select>
                        </td>
                      </tr>
                      <tr>
                        <td height="35">
                            <input type="hidden" name="org" id="org" />
                            <!-- Login ID 입력부 -->
                            <input type="text"  id="userid" name="userid" class="edi_login_input" align="absmiddle" onblur="blandNm(); loginGb(); change_re('userid');" onkeyup="displays(); change_value('userid');" onkeypress="onlyNumber2();" onclick="change_value('userid');" style="ime-mode:disabled; height: 22px; background-image:url(<%=dir%>/imgs/edi/id.jpg);"  maxlength="6" />
                        </td>
                        <!-- Login(로그인 버튼 이미지) -->
                        <td rowspan="2" class="right">
                            <img src="<%=dir%>/imgs/edi/login_btn.gif" width="113" height="70"  onclick="javascript:chk();"   />
                        </td>
                      </tr>
                      <tr>
                        <td height="35" valign="bottom">
                            <input type="password" id="pwd" name="pwd" class="edi_login_input" onKeyDown="javascript:enter();" onkeyup="displays(); change_value('pwd');" onblur="change_re('pwd');"
                                   onclick="change_value('pwd');" maxlength="50" style="height: 22px; background-image:url(<%=dir%>/imgs/edi/password.jpg);" /></td>
                        </tr>
                      </table></td>
                    </tr>
                  <tr>
                    <td  class="PB20 PT20"><img src="<%=dir%>/imgs/edi/bar.gif" width="382" height="8" show="false" /></td>
                    </tr>
                  <tr>
                    <td>
                        <div id="login_error" style="display:none">
                        <table border="0" align="center" cellpadding="0" cellspacing="0">
                          <tr>
                            <td height="30" class="b">브랜드담담자</td>
                            <td class="PL15">
                                <input type="text" name="BlandName" id="BlandName" class="edi_login_input2" style="width:60px;" disabled="disabled" />
                                <input type="text" name="BlandPhone" id="BlandPhone" class="edi_login_input2" style="width:135px;" disabled="disabled" />
                            </td>
                          </tr>
                          <tr>
                            <td height="30" class="b">시스템담당자</td>
                            <td class="PL15">
                                <input type="text" name="systemNm" id="systemNm" class="edi_login_input2" style="width:60px;" disabled="disabled" />
                                <input type="text" name="systemph" id="systemph" class="edi_login_input2" style="width:135px;" disabled="disabled" />
                            </td>
                          </tr>
                        </table>
                        </div>
                    </td>
                    </tr>
                  <tr>
                    <td>&nbsp;</td>
                    </tr>
                  <tr>
                    <td>&nbsp;</td>
                    </tr>
                  <tr>
                    <td>&nbsp;</td>
                    </tr>
                  </table></td>
                <td width="21" valign="top"><img src="<%=dir%>/imgs/edi/edi_login_bx_03.gif" width="21" height="336"  show="false" /></td>
                </tr>
              </table>
            </td>
            </tr>
          </table></td>
        <td valign="top" class="right PL05"><table border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td class="PL20"><table border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td>
                        <img src="<%=dir%>/imgs/edi/edi_login_img2.gif" width="500" height="381" show="false" />
                    </td>
                  </tr>
                  <tr>
                    <td>
                    	<!-- table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                      	<tr>
	                        <td><a href="http://www.mariooutlet.co.kr" target="_blank"><img src="<%=dir%>/imgs/edi/edi_link_01.gif" width="191" height="49" /></a></td>
	                        <td class="PL20"><a href="http://www.mariooutlet.co.kr" target="_blank"><img src="<%=dir%>/imgs/edi/edi_link_02.gif" width="191" height="49" /></a></td>
                      	</tr>
                    	</table-->
                    </td>
                  </tr>
                </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="BD2T PT05 center">Copyright ©<span class="blue b"> D-cubecity</span>. All rights reserved.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
</body>
</html>
