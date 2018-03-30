<!-- 
/*******************************************************************************
 * 시스템명 : 온라인> 협력사관리> 협력사EDI관리> 구인상세보기 / 등록  > 협력업체검색
 * 작 성 일 : 2011.04.20
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : ejob9012.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 공지사항 관리 
 * 이    력 : 2011.04. (이윤희) 신규작성
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"
 import="kr.fujitsu.ffw.base.BaseProperty,kr.fujitsu.ffw.util.String2,kr.fujitsu.ffw.control.ActionForm" %>
<%@ page import="java.util.*" %>
<%@ page import="sun.misc.FormattedFloatingDecimal.Form"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>

<html>
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링</title>
<link href="/edi/css/ds.css" rel="stylesheet" type="text/css" />
<script language="javascript"  src="/edi/js/common.js"  type="text/javascript"></script>
<script language="javascript"  src="/edi/js/PopupCalendar.js"  type="text/javascript"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script> 
<script type="text/javascript">
var g_pre_row = -1;
var g_last_row = -1;
function doit(){
	/*  버튼비활성화  */
	enableControl(newrow,false);   //신규
	enableControl(del,false);      //삭제
	enableControl(save,false);     //저장
	enableControl(excel,false);    //엑셀
	enableControl(prints,false);    //프린터
	
	var content = "";
    content += "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
    content += "	<tr>";
    content += "		<th >점명</th>";
    content += "		<th >협력사코드</th>";
    content += "		<th >협력사명</th>";
    content += "	</tr>";
    content += "</table>";
    
    document.getElementById("DIV_CONTENTS").innerHTML = content;
    
    //getSearch();
	
}

function setArg(arg0,arg1,arg2,arg3)
{
	window.returnValue=arg0 + "/" + arg1 + "/" + arg2 + "/" + arg3; 
	self.close();
}

function btn_Search(){
	var frm = document.frm;
	
	/*if( frm.strnm.value == "" ){
		alert("점은 반드시 입력해야 합니다.");
		frm.strnm.focus();
		return;
	}
	
	if( frm.sDate.value == "" ){
		
		alert("기간은 반드시 입력해야 합니다.");
        frm.sDate.focus();
        return;
	}
	
	if( frm.eDate.value == "" ){
        alert("기간은 반드시 입력해야 합니다.");
        frm.eDate.focus();
        return;
    }
	//시작, 종료일 일자체크
    var sdate = getRawData(trim(frm.sDate.value));
    var edate = getRawData(trim(frm.eDate.value));   
    
    if (sdate > edate) { //시작일은 종료일보다 커야 합니다.
     
        alert("시작일은 종료일보다 커야 합니다.");
        frm.sDate.focus();
        return;
    }*/

    getSearch();

}

function trColorCh(idi) {
}

function trColorRe(idi) {
}

/**
 * getSearch()
 * 작 성 자 : LYH
 * 작 성 일 : 2011-04-18
 * 개    요 :  조회  
 * return값 : void
 */
function getSearch(){
	
	var strnm = document.getElementById("strnm").value;
    var vencd = document.getElementById("vencd").value;
    var vennm = document.getElementById("vennm").value;
    
    var param = "&goTo=getSearchOpenVendor"
    		  + "&strnm=" + strnm
    		  + "&vencd=" + vencd
    		  + "&vennm=" + vennm;

	<ajax:open callback="on_loadedXML" 
		param="param" 
		method="POST" 
		urlvalue="/edi/ejob901.ej"/>
	
	<ajax:callback function="on_loadedXML">
		if( rowsNode.length > 0 ){
		  var content = "";
		  content += "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
		    content += "	<tr>";
		    content += "		<th >점명</th>";
		    content += "		<th >협력사코드</th>";
		    content += "		<th >협력사명</th>";
		    content += "	</tr>";
		    
		  
		  for( i = 0; i < rowsNode.length; i++ ){
			  var arg0 = rowsNode[i].childNodes[0].childNodes[0].nodeValue;		// strcd
			  var arg1 = rowsNode[i].childNodes[1].childNodes[0].nodeValue;		// strnm
			  var arg2 = rowsNode[i].childNodes[2].childNodes[0].nodeValue;		// vencd
			  var arg3 = rowsNode[i].childNodes[3].childNodes[0].nodeValue;		// vennm

			  arg1 = arg1.replace(";","");
			  arg1 = arg1.replace("'","");
			  arg1 = arg1.replace("\"","");
			  
			  arg2 = arg2.replace(";","");
			  arg2 = arg2.replace("'","");
			  arg2 = arg2.replace("\"","");

			  arg3 = arg3.replace(";","");
			  arg3 = arg3.replace(" ","&nbsp;");
			  arg3 = arg3.replace("'","");
			  arg3 = arg3.replace("\"","");
			  content += "<tbody>"
		      content += "	<tr id='idTr"+i+"' onclick='chBak("+i+");' ondblclick=setArg('"+arg0+"','"+arg1+"','"+arg2+"','"+arg3+"'); style='cursor:hand;' onMouseOver='trColorCh("+i+");' onMouseOut='trColorRe("+i+");'>";
		      content += "		<td class='r1' id='1tdId"+i+"'>"+arg1+"</td>";
		      content += "		<td class='r1' id='2tdId"+i+"'>"+arg2+"</td>";
		      content += "		<td class='r1' id='3tdId"+i+"'>"+arg3+"</td>";
		      content += "	</tr>";
		      content += "	<tr>";
		      content += "		<td bgcolor='#cccccc' style='width:100%; height:1px' colspan='3'></td>";
		      content += "	</tr>";
		      content += "</tbody>"
		  }
		  content += "</table>";
		
		  document.getElementById("DIV_CONTENTS").innerHTML = content;
		  
		 // alert(""+rowsNode.length+"건이 조회 되었습니다.");
		}else {
		  alert("조회 내용이 없습니다.");
		}

    </ajax:callback>
}

function chBak(val) {
    g_last_row = val;
    
    if (g_pre_row != g_last_row){
        for(i=1;i<4;i++) {
            document.getElementById(i+"tdId"+val).style.backgroundColor="#fff56E";
            //alert("1");
            if (g_pre_row != -1) {
                document.getElementById(i+"tdId"+g_pre_row).style.backgroundColor="#ffffff";
            }
        }
    }
    g_pre_row = g_last_row;
}
</script>

</head>

<body class="PL10 PR07 PT15" onload="doit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="396" class="title"><img src="/edi/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>협력사검색</td>
					<td width="414">
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="/edi/imgs/btn/search.gif" width="50" height="22" id="search" onclick="btn_Search();" /></td>
								<td><img src="/edi/imgs/btn/new.gif" width="50" height="22" id="newrow" onclick="btn_New();" /></td>
								<td><img src="/edi/imgs/btn/del.gif" width="50" height="22" id="del" /></td>
								<td><img src="/edi/imgs/btn/save.gif" width="50" height="22" id="save" onclick="btn_Save();"/></td>
								<td><img src="/edi/imgs/btn/excel.gif" width="61" height="22" id="excel"/></td>
								<td><img src="/edi/imgs/btn/print.gif" width="50" height="22" id="prints"/></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="PT01 PB03">
			<form name="frm" method="post">     
			<input type="hidden" name="ym" id="ym" value="1104" />
			<input type="hidden" name="strcd" id="strcd" value="" />
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
				<tr>
					<td colspan="2">
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
							<tr>
								<th width="12%">점명 </th>
								<td width="21%"><input type="text"  value="" name="strnm" id="strnm" style="width:100%" onkeydown="checkByteLength(this,40);"/></td>
								<th width="12%">협력사코드</th>
								<td width="21%">
								<input type="text" value="" name="vencd" id="vencd" style="width:100%" onkeydown="checkByteLength(this,6);"/>
								</td>
								<th width="12%">협력사명</th>
								<td width="22%"><input type="text" value="" name="vennm" id="vennm" style="width:100%" onkeydown="checkByteLength(this,40);"/></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="dot"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style=" width:100%;">
				<tr>
					<Td colspan="2">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="g_table">
							<tr>
								<td>
								<div id="DIV_CONTENTS" style=" width:100%; height:360; overflow-y:scroll;"> 
			        
			       				</div>
			       				</Td>
			       			</tr>
						</table>
					</td>
				</tr>
			</table>
			</form>
		</td>
	</tr>
	<tr>
		<td align="right" height="40"><img src="/edi/imgs/btn/close.gif" width="50" height="22" onclick="self.close();" /></td>
	</tr>
</table>
</body>
</html>
