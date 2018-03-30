<!-- 
/*******************************************************************************
 * 시스템명 : 온라인> 협력사관리> 협력사EDI관리> 구인리스트
 * 작 성 일 : 2011.04.20
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : ejob9010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 구인 관리 
 * 이    력 : 2011.04. (이윤희) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"
 import="kr.fujitsu.ffw.base.BaseProperty,kr.fujitsu.ffw.util.String2,kr.fujitsu.ffw.control.ActionForm" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="ecom.util.Util" %>
<%@ page import="ecom.vo.SessionInfo2"%>
<%@ page import="sun.misc.FormattedFloatingDecimal.Form"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>


<%
	String dir = request.getContextPath();
	SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
	String userid = sessionInfo.getUSER_ID();       //사용자아이디
	String strcd = sessionInfo.getSTR_CD();         //점코드
	String strnm = sessionInfo.getSTR_NM();         //점명
	String vencd = sessionInfo.getVEN_CD();         //협력사코드
	String vennm = sessionInfo.getVEN_NAME();       //협력사명
	String gb	 = sessionInfo.getGB();       		//협력사 1, 브랜드 2,
	
	// 관리자가 아닌 경우에는 검색창에 점, 협력사코드, 협력사명을 readonly 로 설정
	String readStr = "";
    if (gb.equals("1") || gb.equals("2")) {
    	readStr = "readOnly";
    }
    
    // test
    /*String userid = "";
    String strcd = "";
    String strnm = "";
    String vencd = "";
    String vennm = "";*/

    // 날짜 세팅 시작일 : 현재월의 1일 / 종료일 : 금일
    String strSDate = "";
    String strEDate = "";
    
    Date date = new Date();
    SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy/MM/dd");
    String strdate = simpleDate.format(date);
    String strdateYY = strdate.substring(0,4);
    String strdateMM = strdate.substring(5,7);
    String strdateDD = strdate.substring(8,10);
    
    strSDate = strdateYY + "/" + strdateMM + "/" + "01";
    strEDate = strdate;
    
%>

<html>
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링</title>
<link href="<%=dir%>/css/ds.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script> 
<script language="javascript"  src="<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/popup.js"  type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/global.js"    type="text/javascript"></script>

<script type="text/javascript">
function doit(){
	/*  버튼비활성화  */
	enableControl(save,false);     //저장
	enableControl(excel,false);    //엑셀
	enableControl(prints,false);    //프린터
	
	var content = "";
  	content += "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
    content += "	<tr>";
    content += "		<th>NO</th>";
    content += "		<th><input type='checkbox' value='' name=''/></th>";
    content += "		<th>구직번호</th>";
    content += "		<th >점명</th>";
    content += "		<th >협력사코드</th>";
    content += "		<th >협력사명</th>";
    content += "		<th >제목</th>";
    content += "		<th >담당자</th>";
    content += "		<th >마감일</th>";
    content += "		<th >조회수</th>";
    content += "	</tr>";
    content += "</table>";
    
    document.getElementById("DIV_CONTENTS").innerHTML = content;
    
    document.getElementById("title").focus();
}

function btn_Search(){
	var frm = document.frm;
	
	if( frm.sDate.value == "" ){
		showMessage(EXCLAMATION, OK, "USER-1003",  "시작일자");
		frm.sDate.focus();
        return;
	}
	
	if( frm.eDate.value == "" ){
		showMessage(EXCLAMATION, OK, "USER-1003",  "종료일자");
        frm.eDate.focus();
        return;
    }
	//시작, 종료일 일자체크
    var sdate = getRawData(trim(frm.sDate.value));
    var edate = getRawData(trim(frm.eDate.value));   
    
    if (sdate > edate) { //시작일은 종료일보다 커야 합니다. 
    	showMessage(INFORMATION, OK, "USER-1015");
        document.getElementById("sdate").focus(); 
        return;
    }
    getSearch(1);
}

function chBak(val) {
	for(i=1;i<11;i++) {
		document.getElementById(i+"tdId"+val).style.backgroundColor="#fff56E";
	}
}

function reBak(val) {
	for(i=1;i<11;i++) {
		document.getElementById(i+"tdId"+val).style.backgroundColor="#ffffff";
	}
}

function allChkFnc(leng) {
	if (document.getElementById("allChk").checked == true) {
		for(i=0; i< leng; i++) {
			document.getElementById("keySeq" + i).checked = true;
		}
	} else {
		for(i=0; i< leng; i++) {
			document.getElementById("keySeq" + i).checked = false;
		}
	}
}
/**
 * getSearch()
 * 작 성 자 : LYH
 * 작 성 일 : 2011-04-18
 * 개    요 :  조회  
 * return값 : void
 */
function getSearch(pageNum){
	
	//var strcd = document.getElementById("strcd").value;
	var strnm = document.getElementById("strnm").value;
    var vencd = document.getElementById("vencd").value;
    var vennm = document.getElementById("vennm").value;
    var sDate = document.getElementById("sDate").value;
    var eDate = document.getElementById("eDate").value;
    var title = document.getElementById("title").value;
    
    var param = "&goTo=getSearch"
    		  + "&vencd=" + vencd
    		  + "&strnm=" + strnm
    		  + "&vennm=" + vennm
    		  + "&title=" + title
		      + "&sDate=" + sDate
		      + "&eDate=" + eDate
    		  + "&pageNum="  + pageNum;
	
	<ajax:open callback="on_loadedXML" 
		param="param" 
		method="POST" 
		urlvalue="/edi/ejob901.ej"/>
	
	<ajax:callback function="on_loadedXML">
		if( rowsNode.length > 0 ){
			var totalcount = rowsNode[0].childNodes[19].childNodes[0].nodeValue;
			var currentpage = rowsNode[0].childNodes[20].childNodes[0].nodeValue;
			
			createPageing(totalcount,currentpage, 10, 10);
			
			var content = "";
		  	content += "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='t_table'>";
		    content += "	<tr>";
		    content += "		<th style='width:4%'>NO</th>";
		    content += "		<th style='width:3%'><input type='checkbox' value='1' name='allChk' id='allChk' OnClick='allChkFnc(" + rowsNode.length + ");'/></th>";
		    content += "		<th style='width:10%'>구직번호</th>";
		    content += "		<th style='width:14%' >점명</th>";
		    content += "		<th style='width:9%' >협력사코드</th>";
		    content += "		<th style='width:11%' >협력사명</th>";
		    content += "		<th style='width:26%' >제목</th>";
		    content += "		<th style='width:8%' >담당자</th>";
		    content += "		<th style='width:10%' >마감일</th>";
		    content += "		<th style='width:5%' >조회수</th>";
		    content += "	</tr>";
		    
		    
		    for( i = 0; i < rowsNode.length; i++ ){
		    	  var node0  = rowsNode[i].childNodes[0].childNodes[0].nodeValue  == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
				  var node1  = rowsNode[i].childNodes[1].childNodes[0].nodeValue  == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
				  var node2  = rowsNode[i].childNodes[2].childNodes[0].nodeValue  == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
				  var node3  = rowsNode[i].childNodes[3].childNodes[0].nodeValue  == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
				  var node4  = rowsNode[i].childNodes[4].childNodes[0].nodeValue  == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
				  var node5  = rowsNode[i].childNodes[5].childNodes[0].nodeValue  == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
				  var node6  = rowsNode[i].childNodes[6].childNodes[0].nodeValue  == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
				  var node7  = rowsNode[i].childNodes[7].childNodes[0].nodeValue  == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
				  var node8  = rowsNode[i].childNodes[8].childNodes[0].nodeValue  == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
				  var node9  = rowsNode[i].childNodes[9].childNodes[0].nodeValue  == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
				  var node10 = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
				  var node11 = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
				  var node12 = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
				  var node13 = rowsNode[i].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[13].childNodes[0].nodeValue;
				  var node14 = rowsNode[i].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[14].childNodes[0].nodeValue;
				  var node15 = rowsNode[i].childNodes[15].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[15].childNodes[0].nodeValue;
				  var node16 = rowsNode[i].childNodes[16].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[16].childNodes[0].nodeValue;
				  var node17 = rowsNode[i].childNodes[17].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[17].childNodes[0].nodeValue;
				  var node18 = rowsNode[i].childNodes[18].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[18].childNodes[0].nodeValue;
				  var node19 = rowsNode[i].childNodes[19].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[19].childNodes[0].nodeValue;
				  
				  if(node7.length > 15) {
					  node7 = node7.substring(0,13) + "..";
				  }
				  
			      content += "	<tr ondblclick='getDetail("+i+");' id='trId"+i+"' style='cursor:hand;' onMouseOver='chBak("+i+");' onMouseOut='reBak("+i+");'>";
			      content += "		<td id='1tdId"+i+"' style='text-align:center;'>"+(i+1)+"</td>";
			      content += "		<td id='2tdId"+i+"' style='text-align:center;'><input type='checkbox' id='keySeq"+i+"' name='keySeq' value='"+node6+"'/></td>";
			      content += "		<input type='hidden' name='keyStrcd' id='keyStrcd"+i+"' value='"+node1+"'/>";
			      content += "		<input type='hidden' name='keyVencd' id='keyVencd"+i+"' value='"+node3+"'/>";
			      content += "		<input type='hidden' name='keyYm' id='keyYm"+i+"' value='"+node5+"'/>";
			      content += "		<input type='hidden' name='keyUserId' id='keyUserId"+i+"' value='"+node5+"'/>";
			      content += "		<td id='3tdId"+i+"' style='text-align:center'>"+node5+ "-" +node6+"</td>";
			      content += "		<td style='text-align:left;' id='4tdId"+i+"'>"+node2+"</td>";
			      content += "		<td id='5tdId"+i+"' style='text-align:center'>"+node3+"</td>";
			      content += "		<td style='text-align:left' id='6tdId"+i+"'>"+node4+"</td>";
			      content += "		<td style='text-align:left' id='7tdId"+i+"'>"+node7+"</td>";
			      content += "		<td style='text-align:center' id='8tdId"+i+"'>"+node11+"</td>";
			      content += "		<td style='text-align:center' id='9tdId"+i+"'>"+getDateFormat(node10)+"</td>";
			      content += "		<td style='text-align:center' id='10tdId"+i+"'>"+node17+"</td>";
			      content += "	</tr>";
			      content += "	<tr>";
			      content += "		<td bgcolor='#cccccc' style='width:100%; height:1px' colspan='10'></td>";
			      content += "	</tr>";
			  }
			  content += "</table>";
			
			  document.getElementById("DIV_CONTENTS").innerHTML = content;
			  document.getElementById("listCnt").value = rowsNode.length;
			  
		}else {
			createPageing(totalcount,currentpage,10,10);
		  var content = "";
		  	content += "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
		    content += "	<tr>";
		    content += "		<th>NO</th>";
		    content += "		<th><input type='checkbox' value='' name=''/></th>";
		    content += "		<th>구인번호</th>";
		    content += "		<th >점명</th>";
		    content += "		<th >협력사코드</th>";
		    content += "		<th >협력사명</th>";
		    content += "		<th >제목</th>";
		    content += "		<th >담당자</th>";
		    content += "		<th >마감일</th>";
		    content += "		<th >조회수</th>";
		    content += "	</tr>";
		    content += "	<tr>";
 	        content += "		<td class='r1' colspan='10'>조회된 내용이 없습니다</td>";
		    content += "	</tr>";
		    content += "</table>";
		    document.getElementById("DIV_CONTENTS").innerHTML = content;
		    document.getElementById("listCnt").value = 0;
		}
		
		setPorcCount("SELECT", rowsNode.length);

    </ajax:callback>
}

function btn_New(strcd, vencd, vennm){
    var userid  = '<%=userid%>';
    var strnm	= '<%=strnm%>';
	var arrArg  = new Array();
    arrArg.push(strcd);
    arrArg.push(strnm);
    arrArg.push(vencd);
    arrArg.push(vennm);
    arrArg.push(userid);
	var returnVal= window.showModalDialog("/edi/ejob901.ej?goTo=openJobPop&mode=I",
			       arrArg,
                   "dialogWidth:800px;dialogHeight:500px;scroll:no;" +
                   "resizable:no;help:no;unadorned:yes;center:yes;status:no");
	if (returnVal){
		getSearch(1);
	}
//	window.open("/edi/ejob901.ej?goTo=openJobPop&mode=I");
	
}

<ajax:callback function="on_loadedXML">

    var strcd = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
    var seqNo = rowsNode[0].childNodes[1].childNodes[0].nodeValue;
    var reg_dt = rowsNode[0].childNodes[2].childNodes[0].nodeValue;
    var title = rowsNode[0].childNodes[3].childNodes[0].nodeValue;
    var buyercd = rowsNode[0].childNodes[4].childNodes[0].nodeValue;
    var buyerNM = rowsNode[0].childNodes[5].childNodes[0].nodeValue;
    var content = rowsNode[0].childNodes[6].childNodes[0].nodeValue;
    
    document.getElementById("em_io_title").value = title;
    document.getElementById("regi").value = buyerNM;
    document.getElementById("content").value = content;
	
</ajax:callback>


function btn_Del()
{
	var paramSeq = "";
	var paramStrcd = "";
	var paramVencd = "";
	var paramYm = "";
	
	if(document.getElementById("keySeq") == null)	{
		showMessage(StopSign, OK, "USER-1019");   //삭제할 데이터가 없습니다.
		return false;
	}
	else {
		
		var chkCnt = 0;
		for(i =0; i < document.getElementById("listCnt").value; i++) {
			if(document.getElementById("keySeq"+i).checked == true) {
				if(chkCnt == 0) {
					paramSeq = document.getElementById("keySeq"+i).value;
					paramStrcd = document.getElementById("keyStrcd"+i).value;
					paramVencd = document.getElementById("keyVencd"+i).value;
					paramYm = document.getElementById("keyYm"+i).value;
				} else {
					paramSeq 	= paramSeq + "/" + document.getElementById("keySeq"+i).value;
					paramStrcd 	= paramStrcd + "/" + document.getElementById("keyStrcd"+i).value;
					paramVencd 	= paramVencd + "/" + document.getElementById("keyVencd"+i).value;
					paramYm 	= paramYm + "/" + document.getElementById("keyYm"+i).value;	
				}
				chkCnt++;
			}
		}
		if (chkCnt == 0) {
			showMessage(StopSign, OK, "USER-1019");   //삭제할 데이터가 없습니다.
			return false;
		} else {		// 삭제 실행
			if( showMessage(QUESTION, YESNO, "GAUCE-1000", "선택한 항목을 삭제하겠습니까?") != 1){
	            return;
	        }
			var paramSize = chkCnt;
			
			var param = "&goTo=delList"
		   		  + "&paramSeq=" 	+ paramSeq
		   		  + "&paramStrcd=" 	+ paramStrcd
		   		  + "&paramVencd=" 	+ paramVencd
		   		  + "&paramYm=" 	+ paramYm
		   		  + "&paramSize=" 	+ paramSize;

		    <ajax:open callback="on_loadedXML" 
			param="param" 
			method="POST" 
			urlvalue="/edi/ejob901.ej"/>
			
			<ajax:callback function="on_loadedXML">
			ret = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
		    if( ret > 0 ){
		    	showMessage(INFORMATION, OK, "USER-1000", "정상적으로 처리되었습니다.");
		    	getSearch(1);
		    }else {
		    	showMessage(INFORMATION, OK, "USER-1000", "삭제처리 시 에러가 발생 되었습니다.");
		    }
		</ajax:callback>
		}
	}
}

/**
 * getDetail()
 * 작 성 자 : LYH
 * 작 성 일 : 2011-04-18
 * 개    요 :  팝업 생성  
 * return값 : void
 */

function getDetail(i)
{
	var paramSeq = document.getElementById("keySeq"+i).value;
	var paramStrcd = document.getElementById("keyStrcd"+i).value;
	var paramVencd = document.getElementById("keyVencd"+i).value;
	var paramYm = document.getElementById("keyYm"+i).value;
	var paramUserId = document.getElementById("keyUserId"+i).value;
	
	var returnVal= window.showModalDialog("/edi/ejob901.ej?goTo=openJobPop&mode=U&seq="+paramSeq+"&strcd="+paramStrcd+"&vencd="+paramVencd+"&ym="+paramYm,
			       "",
                   "dialogWidth:800px;dialogHeight:500px;scroll:no;" +
                   "resizable:no;help:no;unadorned:yes;center:yes;status:no");
	if(returnVal == true){
		var currentPageNumVal = document.getElementById("currentPageNum").value;
		getSearch(currentPageNumVal);
	}
}

</script>

</head>

<body class="PL10 PR07 PT15" onload="doit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>구인 관리</td>
					<td width="414">
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="/edi/imgs/btn/search.gif" width="50" height="22" id="search" onclick="btn_Search();" /></td>
								<td><img src="/edi/imgs/btn/new.gif" width="50" height="22" id="newrow" onclick="btn_New('<%=strcd%>','<%=vencd%>','<%=vennm%>');" /></td>
								<td><img src="/edi/imgs/btn/del.gif" width="50" height="22" id="del"  onclick="btn_Del();"/></td>
								<td><img src="/edi/imgs/btn/save.gif" width="50" height="22" id="save"/></td>
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
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
				<tr>
					<td>
						<form name="frm" method="post">
						<input type="hidden" value="" name="listCnt" />
						<input type="hidden" value="1" name="currentPageNum" id="currentPageNum"/>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
							<tr>
								<th width="80">* 마감일</th>
								<td><input type="text" name="sDate" id="sDate" size="10" title="YYYY-MM-DD" value="<%=strSDate%>" maxlength="10" onKeyPress="onlyNumber();" style='text-align:center;IME-MODE: disabled' onblur="dateCheck(this);" onFocus="dateValid(this);"/> 
								<img src="/edi/imgs/icon/ico_calender.gif" alt="시작일" align="absmiddle" onclick="openCal('G', sDate);return false;" /> ~
								<input type="text" name="eDate" id="eDate" size="10" maxlength="10" value="<%=strEDate%>" onblur="dateCheck(this);" onFocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' />
								<img src="/edi/imgs/icon/ico_calender.gif" alt="종료일" align="absmiddle" onclick="openCal('G', eDate);return false;"/>
								</td>
								<th width="80">점</th>
								<td width="150"><input type="text" name="strnm" id="strnm" style="width:100%" maxlength="10" value="<%=strnm%>" <%=readStr%>/><input type="hidden" name="strcd" id="strcd" onKeyDown="checkByteLength(this,40);"></td>
								<th width="80">협력사코드</th>
								<td width="150">
								<input type="text" name="vencd" id="vencd" style="width:100%" maxlength="10" value="<%=vencd%>" onKeyDown="checkByteLength(this,6);" <%=readStr%>/>
								</td>
							</tr>
							<tr>
								<th width="80">협력사명</th>
								<td ><input type="text" name="vennm" id="vennm" style="width:100%" maxlength="10" value="<%=vennm%>" onKeyDown="checkByteLength(this,40);" <%=readStr%>/></td>
								<th width="80">제목</th>
								<td colspan="3"><input type="text" name="title" id="read_cnt" style="width:100%;" onKeyDown="checkByteLength(this,100);"/></td>
							</tr>
						</table>
					</td>
				</tr>
				</form>
			</table>
		</td>
	</tr>
	<tr>
		<td class="dot" colspan="2"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style=" width:100%; height:486;">
				<tr style="vertical-align:top">
					<Td align="center">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="g_table">
							<tr style="vertical-align:top">
								<td>
								<div id="DIV_CONTENTS"> 
			       				</div>
			       				</td>
			       			</tr>
			       		</table>
			       		<table style="text-align:center;">
        					<tr style="vertical-align:bottom">
			       				<td id="pageing" style="width:100%; height:26px; vertical-align:center;">
			       				</td>
			       			</tr>
        				</table>
       				</Td>
       			</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
