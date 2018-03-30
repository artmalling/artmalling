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

<HTML>
<HEAD>
<TITLE>형지 아트몰링  통합정보시스템 </TITLE>
<link rel="stylesheet" href="/pot/css/mds.css" type="text/css">
<meta http-equiv="pragma" content="no-cache">
<script language="javascript">
<!--
	self.moveTo(0,0);
	//self.resizeTo(screen.availWidth,screen.availHeight);
	self.resizeTo(1024,768);
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

	height = height - 55 ;
	width  = width  - 8;

	myWin = window.open(url, name, 'left='+left+',top='+top+',width='+width+',height='+height+',toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);

	//----------- 팝업 차단 설정이 되어 있는 경우
	if(!myWin) {
		alert("팝업 차단 상태입니다. [도구] >> [팝업차단] >> 팝업 차단 사용 안함으로 설정하십시오.");
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
	myWinServer = winOpen( userId,'', 0, 0, 1024, 768, 0, 0, 1, 0, 1);
	//myWinServer = winOpen( userId,'', 0, 0, 1024, 768, 1, 1, 1, 1, 1);
	document.myForm.target = userId;
	document.myForm.action = "/pot/tcom001.tc?goTo=login";

	document.myForm.id.value = userId;
	document.myForm.pwd.value = pwdNo;
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
</HEAD>

<!-- Barcode 콤포넌트 설치 -->
<!--
<OBJECT CLASSID="clsid:5220cb21-c88d-11cf-b347-00aa00a28331">
	<PARAM NAME="LPKPath" VALUE="CEN-SQU.LPK">
</OBJECT>
-->

<!-- OBJECT ID="BarCode" CLASSID="CLSID:08DE7A89-0157-4C0A-85D5-B7E3E3D89344" CODEBASE="CEN-SQU.CAB#version=1,0,0,0" height="0" width="0">
</OBJECT-->
<body onLoad="doInit();">
<form name="myForm" method="post">
	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="100%" valign="middle" align="center">
				<table width="875" height="667" border="0" align="center" cellpadding="0" cellspacing="0" style="background-image:url('../imgs/login/login_logo2.gif'); background-repeat:no-repeat; position:center; ">
					<!-- tr>
						<td align="center">
							<img src="../imgs/login/login_logo2.jpg" width="514" height="380" con="3600, 2666" />
						</td>
					</tr-->
					<tr>
						<td class="PT50">
							<table border="0" align="center" cellpadding="0" cellspacing="0">
								<tr>
									<td height="300"></td>
								</tr>
								<tr>
									<td>
										<table border="0" align="center" cellpadding="0" cellspacing="0">
											<tr>
												<!-- td colspan="2" class="gray PB05"> 아이디와 비밀번호를 입력해주시기 바랍니다.
													<br/>
													<!-- 초기비밀번호는.....입니다.  -->
												</td-->
												<td colspan="2" bgcolor="gray"><font color="black"><b>아이디와 비밀번호를 입력해주시기 바랍니다.</b></font>
													<br/>
													<!-- 초기비밀번호는.....입니다.  -->
												</td>
											</tr>
											<tr>
												<td>
													<input type="text" name="inputId"  value="" class="login_input" tabindex="1" style="ime-mode:disabled;">
													<input type="hidden" name="id">
												</td>
												<td rowspan="2" class="PL10">
													<table border="0" align="center" cellpadding="0" cellspacing="0">
														<tr>
															<td>
																<input type="checkbox" id="chkCookie">&nbsp;<font color="black"><b>ID 저장</b></font>
															</td>
														</tr>
														<tr>
															<td>
																<a href="javascript:chk()"><img src="../imgs/login/login_btn2.gif" width="74" height="47" /></a>
															</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td>
													<input type="password" name="inputPwd"  value=""  class="login_input" tabindex="2" onKeyDown="javascript:enter();">
													<input type="hidden" name="pwd">
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
</form>
</body>
</HTML>
