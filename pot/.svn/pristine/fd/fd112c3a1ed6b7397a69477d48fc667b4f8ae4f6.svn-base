<%
/*******************************************************************************
 * 시스템명 : 한국후지쯔 통합정보시스템
 * 작 성 일 : 2010.12.12
 * 작 성 자 : 정지인
 * 수 정 자 :
 * 파 일 명 : login.jsp
 * 버    전 : 1.0
 * 개    요 : 로그인 화면
 * 이    력 :
 *****************************************************************************/
%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,
																	   kr.fujitsu.ffw.base.BaseProperty,
																	   kr.fujitsu.ffw.util.*"%>
<%@ page import="java.util.Properties"%>

<%
	String SSOFlag   = BaseProperty.get("SSO.flag");
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>형지 아트몰링  통합정보시스템</title>
<link href="../css/ds.css" rel="stylesheet" type="text/css" />

<script language="javascript">
<!--
	self.moveTo(0,0);
	self.resizeTo(screen.availWidth,screen.availHeight);
	//self.resizeTo(1024,768);
	//self.resizeTo(1280,768);
	self.opener = "";
//-->
</script>
<script language="javascript"  src="/pot/js/common.js"  type="text/javascript"></script>
<script language="javascript"  src="/pot/js/jquery-1.3.2.min.js"></script>
<script language="javascript"  src="/pot/js/jquery.timers.js"></script>
<script language="javascript">
//var myWinLocal  = "";
var myWinServer = "";
var gsCookieKey = "mariooutlet";

function doInit() {
	
	// --------- 공지 사항 쿠키가 있는지 확인
	setFocus(document.myForm);
	window.dialogLeft = 0;
	
	//쿠키에 저장된 ID값 조회
	var loginId = getCookie(gsCookieKey);
	
	//alert(loginId);
	if(loginId != undefined && loginId != "") {
		document.myForm.chkCookie.checked = true;
		document.myForm.inputId.value = loginId;
		document.myForm.inputPwd.focus();	//passwd 입력창으로 focus 이동
	} else {
		// ID 입력창 Focus 이동 EJS (2011.08.03)
		document.myForm.inputId.focus();
	}
	
	//self.resizeto(x,y);

}

// ------------- 아이디 셋팅 및 포커스
function setFocus(form) {

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

	//height = height - 55 ;
	//width  = width  - 8;
	height = screen.availHeight - 55;
	width = screen.availWidth - 20;

	myWin = window.open(url, name, 'left='+left+',top='+top+',width='+width+',height='+height+',toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);
	//myWin = window.open(url, name, 'fullscreen=yes,toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);

	//----------- 팝업 차단 설정이 되어 있는 경우
	if(!myWin) {
		alert("팝업 차단 상태입니다. [도구] >> [팝업차단] >> 팝업 차단 사용 안함으로 설정하십시오.");
	}

	return myWin;
}

//------------- 로그인 버튼을 눌렀을 때
function chk() {
	
	//if(!confirm("현재 접속한 서버는 테스트용입니다.\n로그인 하시겠습니까?")) {
		//return;
	//}
	
	var winName = document.myForm.inputId.value;
	
	if(document.myForm.inputId.value == "") {
		alert(" ID를 입력 해 주세요. ");
		return;
	}
	
	//id 쿠키에 저장
	if(document.myForm.chkCookie.checked) {
		setCookie(gsCookieKey, document.myForm.inputId.value);
	} else {
		delCookie(gsCookieKey);
	}
	

/*
	if(document.myForm.inputPwd.value == "") {
		alert(" Password를 입력 해 주세요. ");
		return;
	}
*/
	OnSuccess(winName, document.myForm.inputPwd.value);

}

//----------- Enter Key를 입력 했을 때
function enter() {
	if (event.keyCode == 13) {
		chk();
	}
}

//--------- 승인 요청 팝업 화면
function showRequest() {
}

//--------- 조직 변경 팝업 화면
function showJojikChange() {
}

//--------- 쿠키 설정하기
//function setCookie(name, value, expires) {
//}

//--------- 쿠키 가져오기
//function getCookie(Name) {
//}

function saveid(form) {
}

function getid(form) {
}


//--------- 통합인증 소스 시작
// 1. 통합인증 연동모듈 존재여부 체크 S
function IsActiveControlNoneMessage() {
	// SSOLOGIN ACTIVEX 설치 체크
	try {
		var objCtrl = document.getElementById("SSOLoginCtrl");
		objCtrl.GetVersion();
	} catch (e) {
		return false;
	}

	// SSOSETUP ACTIVEX 설치 체크
	try {
		var objCtrl = document.getElementById("SSOSetupCtrl");
		objCtrl.GetVersion();
	} catch (e) {
		return false;
	}

	return true;
}
// 1. 통합인증 연동모듈 존재여부 체크 E

// 2. 로그인 체크 S
function AutoSSOLogin() {

}
// 2. 로그인 체크 E

// 3. 통합인증버튼으로 로그인 S
function OnSSOLoginUrl() {


}
// 3. 통합인증버튼으로 로그인 E


// 4. 로그인성공시 이동페이지
function OnSuccess(userId, pwdNo) {
	//document.location.href = "/SSOWeb/Case1NextPage.jsp";
	//
	//document.location.href = "pot/tcom001.tc?goTo=login";
	//myWinServer = winOpen( userId,'', 0, 0, 1024, 768, 0, 0, 1, 0, 1);
	////myWinServer = winOpen( userId,'', 0, 0, 1024, 768, 1, 1, 1, 1, 1);
	myWinServer = winOpen( userId,'', 0, 0, 1280, 768, 0, 0, 1, 0, 1);
	document.myForm.target = userId;
	document.myForm.action = "/pot/tcom001.tc?goTo=login";

	document.myForm.id.value = userId;
	//pcs
	//document.myForm.pwd.value = pwdNo;
	document.myForm.pwd.value = "BC76361D6B0874E5A4B78A874BDC7471";
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

//쿠키 조회
function getCookie(Name) { 
	var search = Name + "="; 
	if (document.cookie.length > 0) {                    // if there are any cookies 
		offset = document.cookie.indexOf(search); 
    
		if (offset != -1){                                              // if cookie exists 
			offset += search.length;                            // set index of beginning of value 
			end = document.cookie.indexOf(";", offset);  // set index of end of cookie value 
			if (end == -1) 
				end = document.cookie.length; 
			return unescape(document.cookie.substring(offset, end)); 
		} 
	}
}

//쿠키 등록
function setCookie(name, value) {
	var expires = new Date();
	
	//쿠키 1달
	//expires.setTime(today.getTime() + 1000*60*60*24*31); 
	expires.setDate(expires.getDate() + 31);
	
	document.cookie = name + "=" + escape(value) + ((expires == null) ? "" : ("; expires=" + expires.toGMTString()));
}

//쿠키 삭제
function delCookie(name){
	var expires = new Date();   

    //어제 날짜를 쿠키 소멸 날짜로 설정한다.   
	expires.setDate(expires.getDate() - 1);
    
	document.cookie = name + "= ; expires=" + expires.toGMTString();
}


// 5. 페이지 로딩시 시작하는 로직
$(document).ready(function() {
	//통합인증 자동로그인 다이얼로그
	$('#loadingbar').css({ top: ($(window).height() - 140) / 2,
	left: ($(window).width() - 341) / 2, width: 341, height: 140
	});
	//alert("여기서 호출 AutoSSOLogin");
	AutoSSOLogin();
});

</script>

<object id="TR_MAIN"    classid="<%=Util.CLSID_TRANSACTION%>">
	<param name="KeyName" value="Toinb_dataid4">
</object>

<script type="text/javascript">
function winMaximize() {
var obj = document.getElementById('winmsize');
var winSwidth = screen.availWidth;
var winDwidth = document.body.offsetWidth;

  if(winDwidth < winSwidth)
	obj.Click();
}

window.onload = winMaximize;
</script>



</head>
<body ID="login_bg" onLoad="doInit();">
<!-- 
<OBJECT ID="Z4MPlus"
CLASSID="CLSID:C12096F8-B343-4C9D-B046-3497EE436732" 
CODEBASE="../ocx/Z4MPlus.CAB#version=1,0,0,0">
<PARAM NAME="LPKPath" VALUE="../ocx/Z4MPlus.LPK">
</OBJECT>
 -->
 
<object id="winmsize" type="application/x-oleobject" classid="clsid:adb880a6-d8ff-11cf-9377-00aa003b7a11"> 
<param name="Command" value="Maximize"> 
</object>
 
<form name="myForm" method="post">
<div class="login_logo"></div>
<div class="login_body">
	<div class="login_box"></div>
	<div class="login_box2"> 
		<table width="400" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td height="40">&nbsp;</td>
			</tr>
			<tr>
				<td><img src="../imgs/login/login_tx01_1.gif" width="268" height="22" /></td>
			</tr>
			<tr>
				<td height="31">&nbsp;</td>
			</tr>
			<tr>
				<td>
					<table border="0" align="center" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<input type="text" name="inputId" id="inputId" class="login_input" style="ime-mode:disabled;" tabindex="1" />
								<input type="hidden" name="id">
							</td>
							<td rowspan="2" width="120" class="PL05"><a href="javascript:chk()" tabindex="3"><img src="../imgs/login/login_btn.gif" width="113" height="70" /></a></td>
						</tr>
						<tr>
							<td>
								<input type="password" name="inputPwd" id="inputPwd" class="login_input" onKeyDown="javascript:enter();" tabindex="2" />
								<input type="hidden" name="pwd">
							</td>
						</tr>
						<tr>
							<td class="FS11"><input type="checkbox" name="chkCookie" id="chkCookie" />아이디저장</td>
							<td class="PL05">&nbsp;</td>
						</tr>
						<tr>
							<td class="PL05">&nbsp;</td><td class="FS11"><a href=./file/siteSet.reg>신뢰사이트추가</a></td>
						</tr>
						<tr>
							<td class="PL05">&nbsp;</td><td class="FS11"><a href=./file/erp_install.zip>ERP재설치파일</a></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="66">&nbsp;</td>
			</tr>
			<tr>
				<td class="PL20"><img src="../imgs/login/login_tx02.gif" width="63" height="31"></td>
			</tr>
			<tr>
				<td>
					<table  border="0" align="center" cellpadding="0" cellspacing="0">
						<tr>
							<td class="PR30"><a href="http://www.hyungji.co.kr/" target="_blank"><img src="../imgs/login/login_icon01.gif" width="78" height="109" /></a></td>
							<td ><img src="../imgs/login/login_icon_bar.gif" width="2" height="74"></td>
							<td class="PL20 PR20"><a href="http://www.hyungji.co.kr/" target="_blank"><img src="../imgs/login/login_icon02.gif" width="78" height="109" /></a></td>
							<td><img src="../imgs/login/login_icon_bar.gif" width="2" height="74"></td>
							<td class="PL30"><a href="http://www.hyungji.co.kr/" target="_blank"><img src="../imgs/login/login_icon03.gif" width="78" height="109" /></a></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
</div>

<div class="login_bottom"> Copyright ©<strong> Hyungji ArtMalling.</strong> All rights reserved. </div>
</form>
</body>
</html>

