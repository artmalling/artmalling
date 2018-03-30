<!-- 
/*******************************************************************************
 * 시스템명 :  협력사 EDI > 협력사팝업
 * 작 성 일 : 2011.07.21
 * 작 성 자 : 김정민
 * 수 정 자 : 
 * 파 일 명 : ccom0160.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 : 2011.07.21 (김정민) 신규작성
           
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

<script language="javascript">
var returnParam    = dialogArguments[0];
var strVenCd       = dialogArguments[1];
var strVenNm       = dialogArguments[2]; 
var strStrCd       = dialogArguments[3]; 
var multiGb        = dialogArguments[4];


/**
 * doInit()
 * 작 성 자 : 정진영
 * 작 성 일 : 2011-02-16
 * 개    요 : initialize
 * return값 : void
**/
function doinit(){
   
     document.getElementById("VENCD").value    = strVenCd;
     document.getElementById("VENNM").value    = strVenNm;
      
	 if(strVenCd.length > 0){
		 btn_Search();
	 }
	 
	 document.getElementById("VENCD").focus();
	 
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
	 alert("sdas :" + document.getElementsByName("VENCD").length );
	 
	 var idx = 0;
	 //var objJson;
	 var rowCnt = 0;
	 var objJson = "";
	 
	 var strVenCd = document.getElementsByName("d_venCd");
     var strVenNm = document.getElementsByName("d_venNm"); 
	    
     for( i = 0; i < document.getElementsByName("d_venCd").length; i++ ){
    	  
   		 var objJson = "[{";
   		 objJson += ""+strVenCd[i].value+":"+strVenNm[i].value+"";
   		 
   		 objJson += "}]";
   		 alert("aa : " + objJson);
   		 returnParam[idx++] = eval(objJson)[0];
 
     }
     alert(objJson);
      
     window.returnValue = true;
     window.close();
      
}    

function chBak(val) {
    for(i=1;i<3;i++) {
        document.getElementById(i+"tdId"+val).style.backgroundColor="#ffff00";
    }
}

function reBak(val) {
    for(i=1;i<3;i++) {
        document.getElementById(i+"tdId"+val).style.backgroundColor="#ffffff";
    }
}

function doOnClick( row ){
	var rowCnt = document.getElementsByName("d_venCd").length;
	
	var strVenCd = document.getElementsByName("d_venCd");
	var strVenNm = document.getElementsByName("d_venNm"); 

	if( rowCnt > 0 ){
		var objJson = "";
 
		objJson += ""+strVenCd[row].value+":"+strVenNm[row].value+"";
			  
		returnParam[0] = objJson;
		
		window.returnValue = true;
        window.close();
	}
	return;
}

// 조회
function btn_Search(){ 
    var VenCd    = document.getElementById("VENCD").value; 
    var VenNm    = document.getElementById("VENNM").value;
     
/*    if(VenCd.length == 0 || VenNm.length == 0) {
    	return;
    }*/
    var param = "&goTo=getVenPop" + "&strStrCd="    + strStrCd
                                  + "&strVenCd="    + VenCd
                                  + "&strVenNm="    + VenNm;
      
	<ajax:open callback="on_getVenPopXML" 
						param="param" 
						method="POST" 
						urlvalue="/edi/ccom016.cc"/>
	
	<ajax:callback function="on_getVenPopXML">
	    
	var content = "";
		if( rowsNode.length > 0 ){
			  
		 content += "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
			   content += "<tr>"; 
			   content += "<th width='90'>협력사코드</th>";
			   content += "<th>협력사명</th>";
			   content += "</tr>";
			    
			   for( i = 0; i < rowsNode.length; i++ ){ 
				    var strVenCd = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;  //품목 코드
				    var strVenNm = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;  //품목명
				//    alert(strPumbunCd); 
				 //   alert(strPumbunNm); 
				    content += "<tr   onMouseOver='chBak("+i+");' onMouseOut='reBak("+i+");' >"; 
				    //content += "<td class='r1'><input  type='checkbox' name='PUMMOKCHB' id='PUMMOKCHB"+i+"'  /></td>";
				    content += "<td class='r1' id='1tdId"+i+"' onclick='doOnClick("+i+");' style='cursor:hand;' ><input type='hidden' name='d_venCd' id='d_venCd"+i+"' value='"+strVenCd+"' /> "+strVenCd+"</td>";
				    content += "<td class='r3' id='2tdId"+i+"' onclick='doOnClick("+i+");' style='cursor:hand;'><input type='hidden' name='d_venNm' id='d_venNm"+i+"' value='"+strVenNm+"'  /> "+strVenNm+"</td>";
				    content += "</tr>";
			   }    
			   
		} else {
			content += "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
            content += "<tr>"; 
            content += "<th width='90'>협력사코드</th>";
            content += "<th>협력사명</th>";
            content += "</tr>";
		}
		
		 content += "</table>";
	     document.getElementById("DIV_CONTENTS").innerHTML = content;
	     
	</ajax:callback>

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
	                                <span id="title1" class="PL03">협력사 팝업</span>
	                            </td>
	                            <td>
	                                <table border="0" align="right" cellpadding="0" cellspacing="0">
	                                    <tr>
	                                        <td><img src="/edi/imgs/btn/search.gif" width="50" height="22"  onClick="btn_Search();"/></td>
							              <!--    <td><img src="/edi/imgs/btn/confirm.gif" width="50" height="22" onClick="btn_Conf()"/></td>-->
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
                                            <th width="60">협력사코드</th>
                                            <td width="80">
                                                <input type="text" name="VENCD" id="VENCD" size="11" maxlength="6" onkeypress="javascript:onlyNumber();" style='text-align:left;IME-MODE: disabled' onkeydown='if(event.keyCode == 13){ btn_Search();}'  />
                                            </td>
                                            <th width="50">협력사명</th>
                                            <td >
                                                <input type="text" name="VENNM" id="VENNM" size="13"  style="text-align:left;"  onkeydown='if(event.keyCode == 13){ btn_Search();}' />
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
                       
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                            <tr valign="top">
                                <td>    
                                <div id="DIV_CONTENTS" style=" width:100%; height:295; overflow-y:scroll;">
                                    <table width='100%' border='0' cellspacing='0' cellpadding='0' class='g_table'>
                                        <tr> 
                                            <th width="90">협력사코드</th>
                                            <th>협력사명</th>
                                        </tr>
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
