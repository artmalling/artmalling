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
<meta http-equiv="x-ua-compatible" content="IE=edge" />

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
<!-- script language="javascript"  src="/pot/js/jquery-1.3.2.min.js"></script-->
<script language="javascript"  src="/pot/js/jquery-1.4.2.min.js"></script>
<script language="javascript"  src="/pot/js/jquery.timers.js"></script>
<script language="javascript">
//var myWinLocal  = "";
var myWinServer = "";
var gsCookieKey = "mariooutlet";

$(function() {
	$( ".help_btn" ).click(
		function() {
			if ($(".help_page").css("left") == "-600px") { 
					$( ".help_page" ).animate({left: 0}, 300 ); //애니메이션시켜서 위치를 -200에서 0으로 이동합니다. 500은 애니메이션 되는 시간으로 밀리(mili)초로 0.5초입니다. 
			} else {
					$( ".help_page" ).animate({left: '-600px'}, 300 ); //이곳을 클릭하면 다시 원위치로 갑니다.
			}
		}
	);
	$( ".help_close" ).click(
			function() {
				$( ".help_page" ).animate({left: '-600px'}, 300 );  
			}
	);
});



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
	
//	chk();
	
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
// 	height = screen.availHeight - 55;
// 	width = screen.availWidth - 20;

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
	


	if(document.myForm.inputPwd.value == "") {
		/* 임시로 fkl 로그인 패스워드 입력 없이 통과 처리 */
		if(document.myForm.inputId.value != "fkl"){
			alert(" Password를 입력 해 주세요. ");
			return;
		}
	}

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
	/* 임시로 fkl 로그인 패스워드 입력 없이 통과 처리 */
	if(userId=="fkl"){
	 	pwdNo = "1111";		
	}

	// 기존 프로그램
// // 	myWinServer = winOpen( userId,'', 0, 0, 1280, 768, 0, 0, 1, 0, 1);
// 	myWinServer = winOpen( userId,'', 0, 0, screen.availWidth, screen.availHeight, 0, 0, 1, 0, 1);
// 	document.myForm.target    = userId;
// 	document.myForm.action    = "/pot/tcom001.tc?goTo=login";
// 	document.myForm.id.value  = userId;
// 	document.myForm.pwd.value = pwdNo;
// 	document.myForm.submit();
// 	myWinServer.focus();

// 	창묻지않고 닫기
// 	손영대과장님 요청 2010.03.28
// 	if (/MSIE/.test(navigator.userAgent)) {
// 		//Explorer 7일때
// 		if (navigator.appVersion.indexOf("MSIE 7.0") >= 0) {
// 			window.open('about:blank', '_self').close();
// 		} //Explorer 8일때
// 		else if (navigator.appVersion.indexOf("MSIE 8.0") >= 0) {
// 			window.open('about:blank', '_self').close();
// 		} //Explorer 9일때
// 		else if (navigator.appVersion.indexOf("MSIE 9.0") >= 0) {
// 			window.open('about:blank', '_self').close();
// 		} //Explorer 7,8,9  가 아닐 때
// 		else {
// 			(self.opener = self).close();
// 		}
// 	}
	

	// 수정 프로그램
    myWinServer = winOpen2(userId,'', 0, 0, screen.availWidth, screen.availHeight, 0, 0, 1, 0, 1);
    myWinServer.document.write("<form name=myForm id=myForm>");
    myWinServer.document.write("<input type=hidden name=id          value=''    />");
    myWinServer.document.write("<input type=hidden name=pwd         value=''    />");
    myWinServer.document.write("</form>");
    
    var f = myWinServer.document.getElementById("myForm");
    f.target    = '_self';
    f.action    = "/pot/tcom001.tc?goTo=login";
    f.method    = 'post';
    f.id.value  = userId;
    f.pwd.value = pwdNo;
    f.submit(); 
   
    myWinServer.focus();
    
    //자동창닫기 기능
    window.opener = 'Self';
    window.open('', '_parent', '');
    window.close();
    
}

//------------- 윈도우 오픈
function winOpen2(name, url, left, top, width, height, toolbar, menubar, statusbar, scrollbar, resizable) {
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

<style>
.help_page {
				width: 580px;
				height: 680px;
				position: absolute;
				left:-600px;
				top:18%;
				background-color:rgba(255,255,255,0.9);
				border:2px solid #848484;
}
.help_content {
				padding: 10px;
				font-size: 14px;
				color:#848484;
}
.help_box{
				width:350px;
				height:15px;
				margin:auto;
				position:relative;
}
.help_btn{
				width:350px;
				height:15px;
				margin:auto;
				padding-top:0px;
				float:left;
				layout:fixed;
				margin-left:0px;
				color:#ffffff;
				font-size:15px;
				cursor:help;
}
.help_close{
				width: 24px;
				height: 8px;
				padding:10px;
				position:relative;
				float:right;
				display:block;
				border:1px solid #E6E6E6;
}


</style>

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
<div class="wrap">

<!-- login box S-->
<div class="wrap_div01">
	<div class="help_page">
		<div class="help_content">
			<br>
			1. 최초 접속시 ActiveX 파일을 설치해 주세요.<br>
			( 재설치 할 경우 "로그인" 버튼 하단 "ERP재설치파일"을 클릭해주세요. )
			<br><br>
		  	2. 인터넷 익스플로러 상단 메뉴 <b>"도구(T)" > "인터넷옵션(O)"</b> 클릭.
		  	<br>
		  	상단 "보안" 탭 선택 후 <b>"신뢰할 수 있는 사이트"</b> 클릭 후 적용.
		  	<br>
		  	<img src ="../imgs/login/help2.png"/>
		  	<br><br>
		  	3. 인터넷 익스플로러 상단 메뉴 <b>"도구(T)" > "호환성보기설정(B)"</b> 클릭.
			<br>
		  	호환성 보기 설정창 우측 <b>"추가(A)"</b> 버튼을 눌러 하단 목록에 <b>"artmalling.com"</b> 추가.
		  	<br>
		  	<img src ="../imgs/login/help1.png"/>
		  	<br>
		  	<div class="help_close" style="color:black;">닫기</div>
		</div>
	</div>
	<div class="login_box">
        
        <div class="L_img"></div>
        <div class="R_box">
        	<div class="login_box01">          
                  <div class="box01_01">
                        <dl>
                          <!--<dt></dt>-->
                            <dd class="r_01"><input type="text" name="inputId" id="inputId" class="inputbx" style="ime-mode:disabled;" tabindex="1"/>
                            				 <input type="hidden" name="id"></dd>
                          <!--<dt></dt>-->
                            <dd class="r_01"><input type="password" name="inputPwd" id="inputPwd" class="inputbx" onKeyDown="javascript:enter();" tabindex="2"/>
                            			     <input type="hidden" name="pwd"></dd>
                        </dl>
                  </div>
                  <div class="box01_02"><a href="javascript:chk()" tabindex="3"><img src="../img/btn_login.gif" ></a></div>
          </div>
          
          <div class="login_box02">
                  <div class="txt_box">
                        <div class="txt_01"><input type="checkbox" name="chkCookie" id="chkCookie"/> 아이디저장</div>
<!-- 						<div class="txt_02 link_blt"><a href=./file/siteSet.reg>신뢰사이트추가</a></div> -->
                        <div class="txt_03 link_blt"><a href=/pot/index.html>ERP재설치파일</a></div>
                  </div>
           </div>
           
          <div class="login_box03">
                 <div class="link_box">
                   	  <div class="link_01"><a href="http://cube.hyungji.com"   target="_blank"> <img src="../img/link_01.gif" alt="형지그룹웨어"/></a></div>
                      <div class="link_02"><a href="http://www.artmalling.com" target="_blank"> <img src="../img/link_02.gif" alt="아트몰링홈페이지"/></a></div>
                      <div class="link_03"><a href="http://edi.artmalling.com" target="_blank"> <img src="../img/link_03.gif" alt="협력사EDI"/></a></div>
                 </div>
                 <br><br><br>
                 <div class="help_box">
                 	  <div class="help_btn">
                 	  * 접속에 문제가 있으시다면 눌러주세요.<img src="../imgs//btn/search_s.gif" alt="도움말 보기" style="width:20px; height:20px;"/>
                 	  </div>	
                 </div>
          </div>      
          
         
  	    </div>

	</div>
</div>
<!-- login box E-->

<!-- Copyright S-->
<div class="wrap_div02"><span class="font01">Copyright © Hyungji ArtMalling. All rights reserved.</span></div>
<!-- Copyright E-->


</div>
</form>
</body>
</html>

