<!-- 
/*******************************************************************************
 * 시스템명 : 도움말 팝업
 * 작  성  일  : 2011.06.23
 * 작  성  자  : FKL
 * 수  정  자  : 
 * 파  일  명  : ccom0030.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 도움말 팝업 관리
 * 이         력  :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"
 import="kr.fujitsu.ffw.base.BaseProperty,kr.fujitsu.ffw.util.String2,kr.fujitsu.ffw.control.ActionForm" %>
<%@ page import="ecom.util.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="sun.misc.FormattedFloatingDecimal.Form"%>
<%@ page import="ecom.vo.SessionInfo2"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>


<html>
<head>
<ajax:library />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링</title>
<link href="/edi/css/ds.css" rel="stylesheet" type="text/css" />
<script language="javascript"  src="/edi/js/common.js"  type="text/javascript"></script>
<script language="javascript"  src="/edi/js/message.js"  type="text/javascript"></script>
<script language="javascript"  src="/edi/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/edi/js/gauce.js"     type="text/javascript"></script>

<script language="javascript">
var returnParam    = dialogArguments;


/**
 * doInit()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-06-24
 * 개    요 : initialize
 * return값 : void
**/
function doinit(){ 
	
    var param = "&goTo=getHelpMsg&strPid="+ dialogArguments;
	<ajax:open callback	= "on_getHelpMsgXML" 
			   param	= "param" 
			   method	= "POST" 
			   urlvalue	= "/edi/ccom003.cc"/>
	
	<ajax:callback function="on_getHelpMsgXML">
	    var content = "";
		if( rowsNode.length > 0 ){
			  
			   content += "<table width='715' height='643' border='1' cellspacing='0' cellpadding='0' class='g_table'>";
			   for( i= 0; i < rowsNode.length; i++  ){  
				    var sttHelpUrl = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;  // 도움말url
				     
				    content += "<tr><td>";
				    content += "   <br><iframe id='frmid' name='frm'  width='715'  height='643' frameborder='0' marginwidth='0' marginheight='0'scrolling='auto' src='"+sttHelpUrl+"'></iframe>"; 
				    content += "</td></tr>";
			   }
			   
		} else {
            content += "<table width='715' height='643' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
		    content += "<tr><td valign=top>";
            content += "<br>도움말이 존재하지 않습니다."; 
		    content += "</td></tr>";
		}
		 content += "</table>";
	     document.getElementById("DIV_Content").innerHTML = content;
	</ajax:callback>

}
/**
 * btn_close()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  팝업 닫기 
 * return값 : void
 */ 
function btn_Close(){
    window.close();
}

/**
 * btn_Conf()
 * 작 성 자 : 정진영
 * 작 성 일 : 2011.02.21
 * 개    요 : 확인버튼 클릭 처리
 * return값 : void
 * */ 

function btn_Conf()
{
}    
 
function btn_Search(){

}

</script>

</head>
<body onload="doinit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="pop01"></td>
        <td class="pop02" ></td>
        <td class="pop03" ></td>
    </tr>
    <tr>
        <td class="pop04"></td>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr><td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                   <tr>
                    <td class="title">
                        <img src="/edi/imgs/comm/title_head.gif" width="15" height="13"  align="absmiddle" class="popR05 PL03" /> 
                        <span id="title1" class="PL03">도움말</span>
                    </td>
                    <td>
                        <table border="0" align="right" cellpadding="0" cellspacing="0">
                            <tr>
                                <td><img src="/edi/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
                            </tr>
                        </table>
                    </td>
                   </tr>
                </table>
                </td></tr> 
                <tr><td>
                	<table width="100%" height="100%" cellpadding=0 cellspacing=0 border=0>
                		<tr><td>
                			<div id="DIV_Content" style="width:710px;height:643px;" ></div>
                		</td></tr>
		             </table>
		        </td></tr>
            </table>
        </td>
        <td class="pop06" ></td>        
    </tr>
    <tr>
        <td class="pop07" ></td>
        <td class="pop08" ></td>
        <td class="pop09" ></td>
    </tr>
</table>
</body>
</html>
