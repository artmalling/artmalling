<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="ecom.vo.SessionInfo2, kr.fujitsu.ffw.base.BaseProperty" %>
<%@ page import="ecom.util.Util" %>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>
<%@ page import="java.util.*" %>

<%
     request.setCharacterEncoding("utf-8");
     String dir = request.getContextPath();
     SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
     String userid = sessionInfo == null ? "" : sessionInfo.getUSER_ID();
%>

<html>
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="x-ua-compatible" content="IE=edge" />
<title>협력사EDI</title>
<link href="<%=dir%>/css/ds3.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="<%=dir%>/js/common.js"	type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/message.js"	type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/gauce.js"	type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/global.js"	type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/jquery-1.4.2.min.js"></script>


<!--<script language="javascript">

//윈도우 위치 이동(절대좌표)
self.moveTo(0,0);
//윈도우 크기 결정(절대좌표)
self.resizeTo('1024','768');
self.opener = "";

</script>//-->

<script language="javascript">
//윈도우 오픈 함수 선언
var myWinServer = "";
var strGbn = "";
var strMst = "";
var strLogin = "";
var strOut = "";

/**************************************
 * help page                          *
 **************************************/
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
/**************************************
 * 초기화                                                            *
 **************************************/
function doInit() {
	// [긴급]공지사항 POP
	//openPopNotice();

    // 공지 사항 쿠키가 있는지 확인
    window.dialogLeft = 0;
    
    // 점코드가져오는 함수
    getStrcd();
    
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
    var strPopName  = "/edi/html/popup/popup_20130122.html";
    var strToday    = getTodayFormat("YYYYMMDD");
    if ( (notice_getCookie( "noticePopOpen_20130123" ) != "done" ) &&    // 쿠키 체크
         (eval(strToday) <= 20130131) ) {                       // 일자 체크
    	window.showModalDialog(strPopName ,"" ,"dialogWidth:350px;dialogHeight:220px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
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

	//exit();
	
	// 로그인 로직 시작전 아이디 패스워드 유효 여부 체크
	chkIdPwd();

}

/*
 * 아이디 비번 유효성체크
 */
function chkIdPwd(){
    var strcd    = document.getElementById("strcd").value;
    var userId   = document.getElementById("userid").value;
    var password = document.getElementById("pwd").value;
    var chkCnt   = document.getElementsByName('chk_info');
    var orgCode  = "";
    
    /* 로그인 사번 구분 값이 협력사 인지 브랜드 인지  */
    for(var i=0; i<chkCnt.length;i++){
    	if(chkCnt[i].checked == true){
    		orgCode = chkCnt[i].value;
    	}
    }
    
   //var orgCode = "2";//document.myForm.orgCode[0].checked == true ? "2" : "1";

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
    var chkCnt = document.getElementsByName('chk_info');
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
    /* 로그인 사번 구분 값이 협력사 인지 브랜드 인지  */
    for(var i=0; i<chkCnt.length;i++){
    	if(chkCnt[i].checked == true){
    		document.myForm.org.value = chkCnt[i].value;
    	}
    }
    
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


function exit() {
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

function enter () {
    if(event.keyCode == 13) {
        chk();
    }
}
</script>


<style>
.help_page {
				width: 580px;
				height: 640px;
				position: absolute;
				left:-600px;
				top:18%;
				background-color:white;
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
				width: 45px;
				height: 3px;
				padding:8px;
				position:relative;
				float:right;
				display:block;
				border:1px solid #E6E6E6;
}
</style>
</head>
<body ID="login_bg" onload="doInit();">
<form  name="myForm" method="post">
<div class="help_page">
		<div class="help_content">
			<br>
		  	1. 인터넷 익스플로러 상단 메뉴 <b>"도구(T)" > "인터넷옵션(O)"</b> 클릭.
		  	<br>
		  	상단 "보안" 탭 선택 후 <b>"신뢰할 수 있는 사이트"</b> 클릭 후 적용.
		  	<br>
		  	<img src ="../imgs/login/help2.png"/>
		  	<br><br>
		  	2. 인터넷 익스플로러 상단 메뉴 <b>"도구(T)" > "호환성보기설정(B)"</b> 클릭.
			<br>
		  	호환성 보기 설정창 우측 <b>"추가(A)"</b> 버튼을 눌러 하단 목록에 <b>"artmalling.com"</b> 추가.
		  	<br>
		  	<img src ="../imgs/login/help1.png"/>
		  	<br>
		  	<div class="help_close">닫기</div>
		</div>
	</div>
<div class="wrap" >
<!-- login box S-->
<div class="wrap_div01">
	<div class="login_box" >        
        <div class="L_img"></div>
        <div class="R_box">
        	<div class="login_box01" style="margin-top=345px">          
                  <div class="box01_01">
                            <dl>
             			   		 <dd  style="margin-left=0px" >
                            		<input type="radio" name="chk_info" id ="chk_info" value="1" disabled="true">협력사
                            		&nbsp;
                            		<input type="radio" name="chk_info" id ="chk_info" value="2" checked="checked">브랜드
                            	</dd>
                              <!--<dt></dt>-->
                                <dd class="r_01"><select name="strcd" id="strcd" class="selectbx" tabindex="1"></select></dd>
                              <!--<dt></dt>-->
                                <dd class="r_01"><input type="text" name="userid" id="userid" class="inputbx" onblur="blandNm(); loginGb();" onkeypress="onlyNumber2();" tabindex="2">
						<input type="hidden" name="org" id="org" /></dd>
                              <!--<dt></dt>-->
                                <dd class="r_01"><input type="password" name="pwd" id="pwd" class="inputbx" onKeyDown="javascript:enter();" tabindex="3"></dd>
                            </dl>
                  </div>
                  <div class="box01_02" style="margin-top=18px"><a href="javascript:chk()" tabindex="4"><img src="<%=dir%>/imgs/login/btn_login.gif"   ></a></div>
            </div>
       	    <div class="login_box03">
       	    	<div class="link_box">
       	    		<div class="link_01"><a href="#" target="_blank" ><img src="<%=dir%>/imgs/login/link_04.gif" alt="홈페이지" /></a></div>
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
<div id="login_error" style="display:none"></div>

</div>
</form>
</body>
</html>

