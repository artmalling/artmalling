<%@ page contentType="text/html;charset=utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script>
/**
* logout()
* 작 성 자 : 권홍재
* 작 성 일 : 2006-12-18
* 개    요  : 브라우저가 닫길시 호출
* return값 : void
*/
function logout(){
    /***********************************************************************/
    /* 정상적으로 로그인 한 창일경우에만 로그아웃 한다.                    */
    /***********************************************************************/
    try{
        var temp = top.opener.top.isWindowAlive;
     if(temp != true){
         location.href = '/edi/ecom001.ec?goTo=logout';
         
     }           
    }catch(e){
        location.href = '/edi/ecom001.ec?goTo=logout';
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
              strOut = eval(strOut.responseText); 
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


//------------- 윈도우 오픈
function winOpen(name, url, left, top, width, height, toolbar, menubar, statusbar, scrollbar, resizable) {
    toolbar_str    = toolbar   ? 'yes' : 'no';
    menubar_str    = menubar   ? 'yes' : 'no';
    statusbar_str  = statusbar ? 'yes' : 'no';
    scrollbar_str  = scrollbar ? 'yes' : 'no';
    resizable_str  = resizable ? 'yes' : 'no';    
    height = height - 55 ;
    width  = width  - 8;
    
    var myWin = window.open(url, name, 'left='+left+',top='+top+',width='+width+',height='+height+',toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);

    return myWin;            
}    
</script>

</head>
<body OnUnload="logout()"  onbeforeunload="exit();">
</body>
</html>
