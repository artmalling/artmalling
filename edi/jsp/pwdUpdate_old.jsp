<!-- 
/*******************************************************************************
 * 시스템명 : EDI 협력사
 * 작 성 일 : 2011.04.22
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pwdUpdate.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 비밀번호 변경
 * 이    력 :
 *        
          2011.03.22 박래형(프로그램 작성) 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="ecom.vo.SessionInfo2, kr.fujitsu.ffw.base.BaseProperty" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>
<%@ page import="java.util.*" %>
<%@ page import="ecom.util.Util" %>
<% 
    String dir = request.getContextPath();
	SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
	String userid = sessionInfo.getUSER_ID();       //사용자아이디
	String strcd = sessionInfo.getSTR_CD();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<ajax:library />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링</title>
<link href="<%=dir%>/css/ds_edi2.css" rel="stylesheet" type="text/css" />
<script language="javascript"  src="/edi/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/global.js"    type="text/javascript"></script>

<script language="javascript">
var id = '<%=userid%>';
var strcd = '<%=strcd%>';
var pwd_no= "";
var last_conn_dt = "";
var yn = "";
var strMst = ""; 
var strOut = "";

function doinit(){
	document.getElementById("pwd1").focus(); 
	 
}


/* noEvent()
 * 새로고침(F5)버튼 사용못하게 막음
 */
function noEvent() {
    if (event.keyCode == 116) {
        event.keyCode= 2;
        return false;
    }
    else if(event.ctrlKey && (event.keyCode==78 || event.keyCode == 82))
    {
        return false;
    }
}
document.onkeydown = noEvent;
 

function nowpwdcheck(pwd){
    
    if( pwd.length < 1 ){
        return;
    }
     
    var param = "&goTo=xmlPwd" + "&id=" +   id
    + "&strcd=" +   strcd
    + "&pwd=" + pwd;

    var Urleren = "/edi/ecom004.ec"; 
    URL = Urleren + "?" +param; 
    strMst = getXMLHttpRequest(); 
    strMst.onreadystatechange = responseMaster;
    strMst.open("GET", URL, true); 
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

/*
 * 비밀번호 유효성 체크
 
 */
function pwdCheck(pwd){
    
    var frm = document.form;
    
     if( pwd.length < 1 ){
            return;
        }
     
    if( pwd != "" && pwd.length < 8 ){
        showMessage(QUESTION, Ok, "GAUCE-1000", "비밀번호는 8자 이상으로 영문 대/소문자, 숫자, 특수문자를 혼용해서 사용해야 합니다.");
        frm.pwd2.value = "";
        frm.pwd2.focus();
    }else {
        
         var alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
         var number = "1234567890";
         //var sChar = "!@#$%^&*";
         var sChar = "\"~!@#$%^&*()_+|}{][;:'><,./\?-=";

         var sChar_Count = 0;
         var alphaCheck = false;
         var numberCheck = false;   
         
         var retVal = checkSpace(pwd);
         
         if( retVal ){
             showMessage(QUESTION, Ok, "GAUCE-1000", "비밀번호는 공백 없이 입력해 주세요");
             frm.pwd2.value = "";
             frm.pwd2.focus();
             return;
         }
         
         for(var i=0; i< pwd.length; i++){
             
             if(sChar.indexOf(pwd.charAt(i)) != -1){
                sChar_Count++;
             }
             if(alpha.indexOf(pwd.charAt(i)) != -1){
                alphaCheck = true;
             }
             if(number.indexOf(pwd.charAt(i)) != -1){
                numberCheck = true;
             }
         }//for
         
         if(sChar_Count < 1 || alphaCheck != true || numberCheck != true){
             showMessage(QUESTION, Ok, "GAUCE-1000", "비밀번호는 8자 이상으로 영문 대/소문자, 숫자, 특수문자를 혼용해서 사용해야 합니다.");
             frm.pwd2.value = "";
             frm.pwd2.focus();
             return;
         }     
         
    }
    
    
}

/*
 * 비밀번호 저장
 
 */
function Action(){
    var frm = document.form;
    var pw2 = frm.pwd2.value;
    var pw3 = frm.pwd3.value;
    
    if( frm.pwd1.value == "" ){
        showMessage(StopSign, Ok, "USER-1003", "현재비밀번호");
        frm.pwd1.focus();
        return;
    }
    if( pw2 == "" ){
        showMessage(StopSign, Ok, "USER-1003", "변경비밀번호");
        frm.pwd2.focus();
        return;
    }
    if( pw3 == "" ){
        showMessage(StopSign, Ok, "USER-1003", "비밀번호확인");
        frm.pwd3.focus();
        return;
    }
    
    
    var strPwd = document.getElementById("pwd1").value;
    //alert(strMst.length);             
    if( strMst.length > 0 ){ 
        if(strMst[0].PW_CHK_YN == "N") {
            showMessage(QUESTION, Ok, "GAUCE-1000", "현재 비밀번호가  틀렸습니다.");
            document.form.pwd1.focus();
            return;
          
        } 
    } 
   // if(frm.pwd1.value == )
    
    /*
    if( last_conn_dt != "1" ){   //현재 비밀번호의 최초 로그인이 아닐시
        
        if( yn != 'Y' ){
            showMessage(QUESTION, Ok, "GAUCE-1000", "현재 비밀번호가  틀렸습니다.");
            document.form.pwd1.focus();
            return;
        }
        
        
    }else { //최초 로그인시 
        if(  yn != 'Y' ){
            showMessage(QUESTION, Ok, "GAUCE-1000", "현재 비밀번호가  틀렸습니다.");
            document.form.pwd1.focus();
            return;
        }
       
    }*/
    
    
    if( pw2 != "" &&  pw3 != "" ){ //변경 비밀번호와 비밀번호 확인 체크 같은지 
        if( pw2 == pw3 ){
            //frm.action="/edi/ecom001.ec?goTo=pwdSave&userid="+id+"&strcd="+strcd+"&pw2="+pw2;
            frm.action="/edi/ecom001.ec?goTo=pwdSave&strcd="+strcd;
            frm.submit();
            
            
        }else {
            showMessage(QUESTION, Ok, "GAUCE-1000", "변경 비밀번호와 비밀번호 확인 란이 틀립니다.");
            document.form.pwd2.focus();
            return;
        }
        
    }
}


//space 가 있으면 true, 없으면 false 공백 체크
function checkSpace( str )
{
     if(str.search(/\s/) != -1){
        return true;
     } else {
        return false;
     }
} 


//아이디/비밀번호 value
function change_value(obj){
 var pwd1 = document.getElementById('pwd1');
 var pwd2 = document.getElementById('pwd2'); 
 var pwd3 = document.getElementById('pwd3'); 
  
 if(obj == 'pwd1'){ 
	 pwd1.style.background   = "";
 }
 if(obj == 'pwd2'){ 
     pwd2.style.background   = ""; 
 }
 if(obj == 'pwd3'){ 
     pwd3.style.background   = "";   
 }
}

//아이디/비밀번호 out
function change_re(obj){
	 var pwd1 = document.getElementById('pwd1');
	 var pwd2 = document.getElementById('pwd2'); 
	 var pwd3 = document.getElementById('pwd3'); 
 
 if(obj == 'pwd1' && pwd1.value == ""){ 
	 pwd1.style.background   = "url(<%=dir%>/imgs/edi/password_now.jpg)";
 }
 if(obj == 'pwd2' && pwd2.value == ""){
     pwd2.style.background   = "url(<%=dir%>/imgs/edi/password_new.jpg)";
 }
 if(obj == 'pwd3' && pwd3.value == ""){
     pwd3.style.background   = "url(<%=dir%>/imgs/edi/password_ok.jpg)";
 }
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
 * responseMaster()
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
        	  strOut = eval(strOut.responseText); 
          } 
     }
}


//function noAction(){
//return false;
//}

//document.onmousedown=clickMouse;
//document.onkeydown=clickKey;
//document.oncontextmenu=noAction;
//document.ondragstart=noAction;
//document.onselectstart=noAction;


</script>

</head>
<body style="background-image:url(<%=dir%>/imgs/edi/edi_bg.gif); background-repeat:repeat-x;" onload="doinit();"  onContextmenu="return false" >
<form  name="form" method="post">
<input type="hidden" name="dbPwd" />
<input type="hidden" name="last_dt" />

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="51" class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="PL10"><img src="<%=dir%>/imgs/edi/edi_logo.gif" width="238" height="37" show="false" /></td>
        <td valign="bottom" class="PB03 PR05"><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><a href="http://dcubecity.com" target="_blank">아트몰링 홈페이지</a></td>
            <td class="PR05 PL05"><img src="<%=dir%>/imgs/edi/login_tx_bar.gif" width="1" height="9" /></td>
            <td><a href="http://ethics.daesung.co.kr" target="_blank"> 윤리경영</a></td>
            <td class="PR05 PL05"><img src="<%=dir%>/imgs/edi/login_tx_bar.gif" width="1" height="9" /></td>
            <td><a href="http://www.dcubecity.com/buying" target="_blank"> 협력사 온라인채널</a></td>
            <td class="PR05 PL05"><img src="<%=dir%>/imgs/edi/login_tx_bar.gif" width="1" height="9" /></td>
            <td><a href="http://www.daesung.co.kr" target="_blank"> 아트몰링 홈페이지</a></td>
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
            <td class="PT15 PL10 PB20"><img src="<%=dir%>/imgs/edi/pw_tx.gif" width="385" height="68" show="false"/></td>
            </tr>
          <tr>
            <td><table width="460" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="21" valign="top"><img src="<%=dir%>/imgs/edi/edi_login_bx_01.gif" width="21" height="336" /></td>
                <td valign="top" class="edi_login_bx" ><table width="380" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td height="30">&nbsp;</td>
                    </tr>
                  <tr>
                    <td height="40" ><img src="<%=dir%>/imgs/edi/edi_login_tx_02.gif" width="155" height="17" show="false"/></td>
                    </tr>
                  <tr>
                    <td><table width="340" border="0" align="center" cellpadding="0" cellspacing="0">
                      <tr>
                        <td height="35">
                            <input type="password"  name="pwd1" id="pwd1" class="edi_login_input" maxlength="50" onblur="javascript:nowpwdcheck(this.value); change_re('pwd1');"
                                   onclick="change_value('pwd1');"  style="height: 22px; background-image:url(<%=dir%>/imgs/edi/password_now.jpg);" 
                                   onkeyup="change_value('pwd1');"/>
                        </td>
                        <td rowspan="3" class="right">
                            <img src="<%=dir%>/imgs/edi/login_confirm.gif" width="113" height="110" onclick="javascript:Action();"/>
                        </td>
                        </tr>
                      <tr>
	                        <td height="35">
	                            <input type="password"" name="pwd2" id="pwd2" class="edi_login_input" maxlength="50" onblur="javascript:pwdCheck(this.value);  change_re('pwd2');"
	                            onclick="change_value('pwd2');"  style="height: 22px; background-image:url(<%=dir%>/imgs/edi/password_new.jpg);" 
                                onkeyup="change_value('pwd2');"/>
	                        </td>
                        </tr>
                      <tr>
                        <td height="35" valign="bottom">
                            <input type="password" name="pwd3" id="pwd3" class="edi_login_input" onblur="change_re('pwd3');"
                                onclick="change_value('pwd3');"  style="height: 22px; background-image:url(<%=dir%>/imgs/edi/password_ok.jpg);" 
                                onkeyup="change_value('pwd3');"/>
                        </td>
                        </tr>
                      </table></td>
                    </tr>
                  </table></td>
                <td width="21" valign="top"><img src="<%=dir%>/imgs/edi/edi_login_bx_03.gif" width="21" height="336" show="false"/></td>
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
                    <td><img src="<%=dir%>/imgs/edi/edi_login_img.gif" width="491" height="376" show="false"/></td>
                  </tr>
                  <tr>
                    <td><table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                      <tr>
                        <td><a href="http://www.dcubecity.com/buying" target="_blank"><img src="<%=dir%>/imgs/edi/edi_link_01.gif" width="191" height="49" /></a></td>
                        <td class="PL20"><a href="http://rsup.net/kaha" target="_blank"><img src="<%=dir%>/imgs/edi/edi_link_02.gif"  width="191" height="49" /></a></td>
                      </tr>
                    </table></td>
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
</body>
</html>
