<!-- 
/*******************************************************************************
 * 시스템명 : 온라인> 협력사관리> 협력사EDI관리> 구직리스트
 * 작 성 일 : 2011.04.20
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : ejob9020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 공지사항 관리 
 * 이    력 : 2011.04. (이윤희) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"
 import="kr.fujitsu.ffw.base.BaseProperty,kr.fujitsu.ffw.util.String2,kr.fujitsu.ffw.control.ActionForm" %>
<%@ page import="ecom.util.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="sun.misc.FormattedFloatingDecimal.Form"%>
<%@ page import="ecom.vo.SessionInfo2"%>
<%@ page import="java.text.*" %>
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
	enableControl(newrow,false);  //신규
	enableControl(del,false);     //삭제
	enableControl(save,false);    //저장
	enableControl(excel,false);   //엑셀
	enableControl(prints,false);  //프린터
	
	var content = "";
  	content += "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
    content += "	<tr>";
    content += "		<th style='width:4%'>NO</th>";
    content += "		<th style='width:12%'>구직번호</th>";
    content += "		<th style='width:28%'>제목</th>";
    content += "		<th style='width:12%'>구직자명</th>";
    content += "		<th style='width:8%'>연령</th>";
    content += "		<th style='width:12%'>경력</th>";
    content += "		<th style='width:12%'>희망연봉</th>";
    content += "		<th style='width:12%'>등록일</th>";
    content += "	</tr>";
    content += "</table>";
    
    document.getElementById("DIV_CONTENTS").innerHTML = content;

    document.getElementById("sCareer").focus();
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
        showMessage(StopSign, OK, "USER-1008", "종료일", "시작일");
        document.getElementById("sdate").focus(); 
        return;
    }
    getSearch(1);
}

function chBak(val) {
	for(i=1;i<9;i++) {
		document.getElementById(i+"tdId"+val).style.backgroundColor="#eeeeee";
	}
}

function reBak(val) {
	for(i=1;i<9;i++) {
		document.getElementById(i+"tdId"+val).style.backgroundColor="#ffffff";
	}
}
/**
 * getSearch()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  조회  
 * return값 : void
 */
function getSearch(pageNum){
	
	 
	var strnm = document.getElementById("strnm").value;
    var vencd = document.getElementById("vencd").value;
    var vennm = document.getElementById("vennm").value;
    var sDate = document.getElementById("sDate").value;
    var eDate = document.getElementById("eDate").value;
    var sCareer = document.getElementById("sCareer").value;
    var eCareer = document.getElementById("eCareer").value;
    var sAge = document.getElementById("sAge").value;
    var eAge = document.getElementById("eAge").value;
    var cust_nm = document.getElementById("cust_nm").value;
    
    var param = "&goTo=getSearch"
    		  + "&vencd=" + vencd
    		  + "&strnm=" + strnm
    		  + "&vennm=" + vennm
		      + "&sDate=" + sDate
		      + "&eDate=" + eDate
		      + "&sCareer=" + sCareer
		      + "&eCareer=" + eCareer
		      + "&sAge=" + sAge
		      + "&eAge=" + eAge
		      + "&cust_nm=" + cust_nm
    		  + "&pageNum="  + pageNum;

	<ajax:open callback="on_loadedXML" 
		param="param" 
		method="POST" 
		urlvalue="/edi/ejob902.ej"/>
	
	<ajax:callback function="on_loadedXML">
		if( rowsNode.length > 0 ){
			var totalcount = rowsNode[0].childNodes[25].childNodes[0].nodeValue;
			var currentpage = rowsNode[0].childNodes[26].childNodes[0].nodeValue;
			
			createPageing(totalcount,currentpage, 10, 10);
			
			var content = "";
		  	content += "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='t_table'>";
		    content += "	<tr>";
		    content += "		<th style='width:4%'>NO</th>";
		    content += "		<th style='width:12%'>구직번호</th>";
		    content += "		<th style='width:28%'>제목</th>";
		    content += "		<th style='width:12%'>구직자명</th>";
		    content += "		<th style='width:8%'>연령</th>";
		    content += "		<th style='width:12%'>경력</th>";
		    content += "		<th style='width:12%'>희망연봉</th>";
		    content += "		<th style='width:12%'>등록일</th>";
		    content += "	</tr>";
		    
		  
		    for( i = 0; i < rowsNode.length; i++ ){
				  
				  var node0	= rowsNode[i].childNodes[0].childNodes[0].nodeValue;
				  var node1	= rowsNode[i].childNodes[1].childNodes[0].nodeValue;
				  var node2 = rowsNode[i].childNodes[2].childNodes[0].nodeValue;
				  var node3 = rowsNode[i].childNodes[3].childNodes[0].nodeValue;
				  var node4 = rowsNode[i].childNodes[4].childNodes[0].nodeValue;
				  var node5 = rowsNode[i].childNodes[5].childNodes[0].nodeValue;
				  var node6 = rowsNode[i].childNodes[6].childNodes[0].nodeValue;
				  var node7 = rowsNode[i].childNodes[7].childNodes[0].nodeValue;
				  var node8 = rowsNode[i].childNodes[8].childNodes[0].nodeValue;
				  var node9 = rowsNode[i].childNodes[9].childNodes[0].nodeValue;
				  var node10 = rowsNode[i].childNodes[10].childNodes[0].nodeValue;
				  var node11 = rowsNode[i].childNodes[11].childNodes[0].nodeValue;
				  var node12 = rowsNode[i].childNodes[12].childNodes[0].nodeValue;
				  var node13 = rowsNode[i].childNodes[13].childNodes[0].nodeValue;
				  var node14 = rowsNode[i].childNodes[14].childNodes[0].nodeValue;
				  var node15 = rowsNode[i].childNodes[15].childNodes[0].nodeValue;
				  var node16 = rowsNode[i].childNodes[16].childNodes[0].nodeValue;
				  var node17 = rowsNode[i].childNodes[17].childNodes[0].nodeValue;
				  var node18 = rowsNode[i].childNodes[18].childNodes[0].nodeValue;
				  var node19 = rowsNode[i].childNodes[19].childNodes[0].nodeValue;
				  var node20 = rowsNode[i].childNodes[20].childNodes[0].nodeValue;
				  var node21 = rowsNode[i].childNodes[21].childNodes[0].nodeValue;
				  var node22 = rowsNode[i].childNodes[22].childNodes[0].nodeValue;
				  var node23 = rowsNode[i].childNodes[23].childNodes[0].nodeValue;
				  var node24 = rowsNode[i].childNodes[24].childNodes[0].nodeValue;
				  var node25 = rowsNode[i].childNodes[25].childNodes[0].nodeValue;
				  var node26 = rowsNode[i].childNodes[26].childNodes[0].nodeValue;
				  
				  if(node0 == "null"){ node0 = "";} else { node0 = node0;}
				  if(node1 == "null"){ node1 = "";} else { node1 = node1;}
				  if(node2 == "null"){ node2 = "";} else { node2 = node2;}
				  if(node3 == "null"){ node3 = "";} else { node3 = node3;}
				  if(node4 == "null"){ node4 = "";} else { node4 = node4;}
				  if(node5 == "null"){ node5 = "";} else { node5 = node5;}
				  if(node6 == "null"){ node6 = "";} else { node6 = node6;}
				  if(node7 == "null"){ node7 = "";} else { node7 = node7;}
				  if(node8 == "null"){ node8 = "";} else { node8 = node8;}
				  if(node9 == "null") { node9 = "";} else { node9 = node9;}
				  if(node10 == "null"){ node10 = "";} else { node10 = node10;}
				  if(node11 == "null"){ node11 = "00";} else { node11 = node11;}
				  if(node12 == "null"){ node12 = "00";} else { node12 = node12;}
				  if(node13 == "null"){ node13 = "";} else { node13 = node13;}
				  if(node14 == "null"){ node14 = "";} else { node14 = node14;}
				  if(node15 == "null"){ node15 = "";} else { node15 = node15;}
				  if(node16 == "null"){ node16 = "";} else { node16 = node16;}
				  if(node17 == "null"){ node17 = "";} else { node17 = node17;}
				  if(node18 == "null"){ node18 = "";} else { node18 = node18;}
				  if(node19 == "null"){ node19 = "";} else { node19 = node19;}
				  if(node20 == "null"){ node20 = "";} else { node20 = node20;}
				  if(node21 == "null"){ node21 = "";} else { node21 = node21;}
				  if(node22 == "null"){ node22 = "";} else { node22 = node22;}
				  if(node23 == "null"){ node23 = "";} else { node23 = node23;}
				  if(node24 == "null"){ node24 = "";} else { node24 = node24;}
				  if(node25 == "null"){ node25 = "";} else { node25 = node25;}
				  if(node26 == "null"){ node26 = "";} else { node26 = node26;}

			      content += "	<tr ondblclick='getDetail("+i+");' id='trId"+i+"' style='cursor:hand;' onMouseOver='chBak("+i+");' onMouseOut='reBak("+i+");'>";
			      content += "		<td style='width:4%' class='r1' id='1tdId"+i+"'>"+node0+"</td>";
			      content += "		<td style='width:12%' class='r1' id='2tdId"+i+"'>"+node6+"-"+node1+"</td>";
			      content += "		<input type='hidden' name='keySeq' id='keySeq"+i+"' value='"+node7+"'/>";
			      content += "		<input type='hidden' name='keyStrcd' id='keyStrcd"+i+"' value='"+node2+"'/>";
			      content += "		<input type='hidden' name='keyVencd' id='keyVencd"+i+"' value='"+node4+"'/>";
			      content += "		<input type='hidden' name='keyYm' id='keyYm"+i+"' value='"+node6+"'/>";
			      content += "		<td class='r1' style='width:28%; text-align:left;%' id='3tdId"+i+"'>"+node8+"</td>";
			      content += "		<td class='r1' style='width:12%; text-align:left;%' id='4tdId"+i+"'>"+node9+"</td>";
			      content += "		<td style='width:8%' class='r1' id='5tdId"+i+"'>"+node10+" 세</td>";
			      content += "		<td style='width:12%' class='r1' id='6tdId"+i+"'>"+node11+"년"+node12+"개월</td>";
			      content += "		<td style='width:12%' class='r1' id='7tdId"+i+"'>"+node16+"</td>";
			      content += "		<td style='width:12%' class='r1' id='8tdId"+i+"'>"+node20+"</td>";
			      content += "	</tr>";
			      content += "	<tr>";
			      content += "		<td bgcolor='#cccccc' style='width:100%; height:1px' colspan='10'></td>";
			      content += "	</tr>";
			  }
			  content += "</table>";
			
			  document.getElementById("DIV_CONTENTS").innerHTML = content;
			  document.getElementById("listCnt").value = rowsNode.length;
			  
		}else {
			createPageing(totalcount,currentpage, 10, 10);
		  var content = "";
		  	content += "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
		    content += "	<tr>";
		    content += "		<th style='width:4%'>NO</th>";
		    content += "		<th style='width:12%'>구직번호</th>";
		    content += "		<th style='width:28%'>제목</th>";
		    content += "		<th style='width:12%'>구직자명</th>";
		    content += "		<th style='width:8%'>연령</th>";
		    content += "		<th style='width:12%'>경력</th>";
		    content += "		<th style='width:12%'>희망연봉</th>";
		    content += "		<th style='width:12%'>등록일</th>";
		    content += "	</tr>";
		    content += "	<tr>";
 	        content += "		<td class='r1' colspan='10'>조회된 내용이 없습니다</td>";
		    content += "	</tr>";
		    content += "</table>";
		    document.getElementById("DIV_CONTENTS").innerHTML = content;
		    document.getElementById("listCnt").value = 0;
		}

    </ajax:callback>
}

function getDetail(i)
{
	var paramSeq = document.getElementById("keySeq"+i).value;
	var paramStrcd = document.getElementById("keyStrcd"+i).value;
	var paramVencd = document.getElementById("keyVencd"+i).value;
	var paramYm = document.getElementById("keyYm"+i).value;
	
	var returnVal= window.showModalDialog("/edi/ejob902.ej?goTo=openJobPop&mode=U&seq="+paramSeq+"&strcd="+paramStrcd+"&vencd="+paramVencd+"&ymd="+paramYm,
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
					<td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>구직리스트</td>
					<td width="414">
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onclick="btn_Search();" /></td>
								<td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow" onclick="btn_New('<%=strcd%>','<%=vencd%>','<%=vennm%>');" /></td>
								<td><img src="<%=dir%>/imgs/btn/del.gif" width="50" height="22" id="del"  onclick="btn_Del();"/></td>
								<td><img src="<%=dir%>/imgs/btn/save.gif" width="50" height="22" id="save"/></td>
								<td><img src="<%=dir%>/imgs/btn/excel.gif" width="61" height="22" id="excel"/></td>
								<td><img src="<%=dir%>/imgs/btn/print.gif" width="50" height="22" id="prints"/></td>
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
					<td colspan="2">
						<form name="frm" method="post">
						<input type="hidden" value="" name="listCnt" />
						<input type="hidden" value="1" name="currentPageNum" />
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
							<tr>
								<th style="width:10%">* 등록일</th>
								<td style="width:29%"><input type="text" name="sDate" id="sDate" size="10" title="YYYY-MM-DD" value="<%=strSDate%>" maxlength="10" onKeyPress="onlyNumber();" style='IME-MODE: disabled' onblur="dateCheck(this);" onFocus="dateValid(this);"/> 
								<img src="/edi/imgs/icon/ico_calender.gif" alt="시작일" align="absmiddle" onclick="openCal('G', sDate);return false;"  /> ~
								<input type="text" name="eDate" id="eDate" size="10" maxlength="10" value="<%=strEDate%>" onblur="dateCheck(this);" onFocus="dateValid(this);" />
								<img src="/edi/imgs/icon/ico_calender.gif" alt="종료일" align="absmiddle" onclick="openCal('G', eDate);return false;" />
								</td>
								<th style="width:10%">점</th>
								<td style="width:20%"><input type="text" name="strnm" id="strnm" style="width:100%" maxlength="10" value="<%=strnm%>" <%=readStr%>/><input type="hidden" name="strcd" id="strcd" onKeyDown="checkByteLength(this,40);"></td>
								<th style="width:11%">협력사코드</th>
								<td style="width:20%">
								<input type="text" name="vencd" id="vencd" style="width:100%" value="<%=vencd%>" onKeyDown="checkByteLength(this,6);" <%=readStr%>/>
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
							<tr>
								<th style="width:10%">협력사명</th>
								<td style="width:13%"><input type="text" name="vennm" id="vennm" style="width:100%" value="<%=vennm%>" onKeyDown="checkByteLength(this,40);" <%=readStr%>/></td>
								<th style="width:9%">경력</th>
								<td style="width:20%">
								<select name="sCareer" id="sCareer">
									<option value="">선택</option>
									<% for (int i = 0; i < 30; i ++) { %>
									<option value="<%=i%>"><%=i %></option>
									<% } %>
								</select> 년 ~ 
								<select name="eCareer" id="eCareer">
									<option value="">선택</option>
									<% for (int i = 0; i < 30; i ++) { %>
									<option value="<%=i%>"><%=i %></option>
									<% } %>
								</select> 년
								</td>
								<th style="width:9%">구직자명</th>
								<td style="width:10%"><input type="text" name="cust_nm" id="cust_nm" style="width:100%;" onKeyDown="checkByteLength(this,100);"/></td>
								<th style="width:9%">연령</th>
								<td style="width:20%">
								<select name="sAge" id="sAge">
									<option value="">선택</option>
									<% for (int i = 10; i < 60; i ++) { %>
									<option value="<%=i%>"><%=i %></option>
									<% } %>
								</select> 세 <font size="2">~</font> 
								<select name="eAge" id="eAge">
									<option value="">선택</option>
									<% for (int i = 10; i < 60; i ++) { %>
									<option value="<%=i%>"><%=i %></option>
									<% } %>
								</select> 세
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				</form>
					<td class="dot"></td>
				</tr>
			</table>
		</td>
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
