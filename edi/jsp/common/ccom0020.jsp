<!-- 
/*******************************************************************************
 * 시스템명 : 우편번호 조회 팝업
 * 작  성  일  : 2011.06.23
 * 작  성  자  : 김성미
 * 수  정  자  : 
 * 파  일  명  : ccom0020.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 우편번호 팝업 관리(신주소/구주소)
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
var returnParam    = dialogArguments[0];


/**
 * doInit()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-06-24
 * 개    요 : initialize
 * return값 : void
**/
function doinit(){
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

function chBak(val) {
    for(i=1;i<4;i++) {
        document.getElementById(i+"tdId"+val).style.backgroundColor="#ffff00";
    }
}

function reBak(val) {
    for(i=1;i<4;i++) {
        document.getElementById(i+"tdId"+val).style.backgroundColor="#ffffff";
    }
}

function doOnClick( row ){
    if (row > -1) 
    {
    	returnParam.put("POST_NO", document.getElementById("d_post_no"+row).value);
    	returnParam.put("ADDR1", document.getElementById("d_addr1"+row).value);
    	returnParam.put("ADDR2", document.getElementById("d_addr2"+row).value);
        window.returnValue = returnParam;
        window.close();
    }
    return false;   
}

function btn_Search(){
	if(document.getElementById("search").value == ""){
		showMessage(INFORMATION, OK, "USER-1003", "동");
        document.getElementById("search").focus();
        return;
	}
	
    var param = "&goTo=getOldAddr&search="+ document.getElementById("search").value;
	<ajax:open callback="on_getOldAddrXML" 
						param="param" 
						method="POST" 
						urlvalue="/edi/ccom002.cc"/>
	
	<ajax:callback function="on_getOldAddrXML">
	    var content = "";
		if( rowsNode.length > 0 ){
			  
			   content += "<table width='500' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
			   for( i= 0; i < rowsNode.length; i++  ){  
				    var strPostNo = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : convertZip(rowsNode[i].childNodes[0].childNodes[0].nodeValue);  //품목 코드
				    var strFullAddr = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;  //품목명
				    var strAddr1 = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;  //단위
				    var strAddr2 = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;  //택구분
				    var strPostNo1 = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;  //택구분
				    var strPostNo2 = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;  //택구분
                    var strGubun = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;  //택구분
                    
				    
				    content += "<tr   onMouseOver='chBak("+i+");' onMouseOut='reBak("+i+");' >";
				    content += "<input type='hidden' name='d_post_no' id='d_post_no"+i+"' value='"+strPostNo+"' />";
				    content += "<input type='hidden' name='d_addr1' id='d_addr1"+i+"' value='"+strAddr1+"' />";
				    content += "<input type='hidden' name='d_addr2' id='d_addr2"+i+"' value='"+strAddr2+"' />";
				    content += "<td class='r1' id='1tdId"+i+"' onclick='doOnClick("+i+");' style='cursor:hand;' width='25'>"+(i+1)+"</td>";
				    content += "<td class='r1' id='2tdId"+i+"' onclick='doOnClick("+i+");' style='cursor:hand;' width='60'>"+strPostNo+"</td>";
				    content += "<td class='r3' id='3tdId"+i+"' onclick='doOnClick("+i+");' style='cursor:hand;' width='400'>"+strFullAddr+"</td>";
				    content += "</tr>";
			   }
			   
		} else {
            content += "<table width='500' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
          /*  content += "<tr>";
            content += "<th width='25'>NO</th>";
            content += "<th width='60'>우편번호</th>";
            content += "<th width='400'>주소</th>";
            content += "</tr>";*/
		}
		 content += "</table>";
	     document.getElementById("DIV_Content").innerHTML = content;
	
	</ajax:callback>

}

function getKeyCode(){
	if(window.event.keyCode == 13){
		btn_Search();
	}
}
function scrollAll(){
    document.all.topTitle.scrollLeft = document.all.DIV_Content.scrollLeft;
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
                <tr>
                    <td>
                         <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
	                            <td class="title">
	                                <img src="/edi/imgs/comm/title_head.gif" width="15" height="13"  align="absmiddle" class="popR05 PL03" /> 
	                                <span id="title1" class="PL03">우편번호 조회</span>
	                            </td>
	                            <td>
	                                <table border="0" align="right" cellpadding="0" cellspacing="0">
	                                    <tr>
	                                        <td><img src="/edi/imgs/btn/search.gif" width="50" height="22"  onClick="btn_Search();"/></td>
							                <td><img src="/edi/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
	                                    </tr>
	                                </table>
	                            </td>
                            </tr>
                         </table>
                    </td>
                </tr>
                <tr>
                    <td class="popT01 PB03">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
                            <tr>
                                <td>
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                                        <tr>
                                            <th width="50">동</th>
                                            <td>
                                            <input type="text" name="search" id="search" onkeyup="checkByteLength(this, 40);" onkeydown="getKeyCode();">
                                            </td>
                                    </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%"  border="0" cellspacing="0" cellpadding="0" class="BD4A">
					      <tr valign="top">
					        <td><div id="topTitle" style="width:510px;overflow:hidden;">
					                <table width="510" cellpadding="0" cellspacing="0" border="0" class="g_table" >
					                    <tr>
                                            <th width="25">NO</th>
					                        <th width="60">우편번호</th>
					                        <th width="380">주소</th>
					                        <th width="15">&nbsp;</th>
					                    </tr>
					                </table>
					            </div>        
					        </td>
					      </tr>
					      <tr>
					          <td ><div id="DIV_Content" style="width:510px;height:330px;overflow:scroll" onscroll="scrollAll();">
					                  <table width="500" cellspacing="0" cellpadding="0" border="0" class="g_table">
					                  </table>  
					              </div>
					          </td>  
					      </tr>
					    </table> 
                    </td>
                </tr>
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
