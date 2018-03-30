<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, kr.fujitsu.ffw.util.Date2"  %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>

<html>
<head>
<title></title>
</head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<% request.setCharacterEncoding("utf-8"); %>
<link href="/pot/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/pot/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/pot/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/pot/js/gauce.js"   type="text/javascript"></script>
<script language="javascript"  src="/pot/js/message.js" type="text/javascript"></script>

<script language="javascript"><!--
//

  

    
  function window_close(args){
    document.myForm_.action = "/pot/tcom001.tc?goTo=selectOrg";
    document.myForm_.orgFlag.value = document.myForm_.inputOrgFlag[0].checked == true? '1':'2';
    document.myForm_.submit();
  }
  
  function KeyDown(keyCode){

  }
    
  

//
--></script>


<body onKeyDown="KeyDown();">
<form name="myForm_" method="post">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0"> 
    <tr height="200"><td></td></tr>
     
    <tr><td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="100%">
        <tr>
          <td height="3" ><img src="/img/line/line_1.gif" width="1" height="3"></td>
        </tr>
        <tr height="50">      
          <td align="center" >
          
	          <table width="203" border="0" align="center" cellpadding="0" cellspacing="0">
	          <tr> 
                  <td height="20" align="center" ><b>조직구분  선택 :</b></td>
              </tr>
              <tr height ="2"><td></td></tr>
	          <tr> 
		          <td class="PR05" align="center" >
		              <input type="radio" name="inputOrgFlag" checked value="1"> 판매
		              <input type="radio" name="inputOrgFlag" value="2"> 매입<input type="hidden" name="orgFlag"></td>
		          </td>
		       </tr>
		       </table>
	       </td>
        </tr> 
         <tr  height="50">
            <td align="center">
               <img src='/pot/imgs/btn/confirm.gif' onClick="window_close(1);" >
            </td>
         </tr>
        </table>
    </td></tr>  
    <tr height="100%"><td></td></tr>
  

</table>
</form>
</body>

</html>   
