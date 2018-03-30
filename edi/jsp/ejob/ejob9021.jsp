<!-- 
/*******************************************************************************
 * 시스템명 : 온라인> 협력사관리> 협력사EDI관리> 구직상세보기 
 * 작 성 일 : 2011.04.20
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : ejob9021.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 공지사항 관리 
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
	SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
	String userid = sessionInfo.getUSER_ID();       //사용자아이디
	String gb	 = sessionInfo.getGB();       		//협력사 1, 브랜드 2,
	
	// 관리자가 아닌 경우에는 검색창에 점, 협력사코드, 협력사명을 readonly 로 설정
	String readStr = "";
    if (gb.equals("1") || gb.equals("2")) {
    	readStr = "readOnly";
    }
    
	String mode = "U";		
	String titleName = "구직정보 상세보기";
	
	
	String strcd = request.getParameter("strcd");
	String vencd = request.getParameter("vencd");
	
    // 상세보기경우
    Map infoMap = (Map)request.getAttribute("infoMap");
    
    String hunt_seq		= String.valueOf(infoMap.get("hunt_seq")) == "null" ? "" : String.valueOf(infoMap.get("hunt_seq"));
    String strnm		= String.valueOf(infoMap.get("str_nm")) == "null" ? "" : String.valueOf(infoMap.get("str_nm"));
    String vennm		= String.valueOf(infoMap.get("ven_nm")) == "null" ? "" : String.valueOf(infoMap.get("ven_nm"));
    String title		= String.valueOf(infoMap.get("title")) == "null" ? "" : String.valueOf(infoMap.get("title"));
    String cust_nm		= String.valueOf(infoMap.get("cust_name")) == "null" ? "" : String.valueOf(infoMap.get("cust_name"));
    String age			= String.valueOf(infoMap.get("age")) == "null" ? "" : String.valueOf(infoMap.get("age"));
    String career_yy	= String.valueOf(infoMap.get("career_yy")) == "null" ? "" : String.valueOf(infoMap.get("career_yy"));
    String career_mm	= String.valueOf(infoMap.get("career_mm")) == "null" ? "" : String.valueOf(infoMap.get("career_mm"));
    String tel_1		= String.valueOf(infoMap.get("tel_1")) == "null" ? "" : String.valueOf(infoMap.get("tel_1"));
    String tel_2		= String.valueOf(infoMap.get("tel_2")) == "null" ? "" : String.valueOf(infoMap.get("tel_2"));
    String tel_3		= String.valueOf(infoMap.get("tel_3")) == "null" ? "" : String.valueOf(infoMap.get("tel_3"));
    String hope_salary	= String.valueOf(infoMap.get("hope_salary")) == "null" ? "" : String.valueOf(infoMap.get("hope_salary"));
    String reg_cdate	= String.valueOf(infoMap.get("reg_cdate")) == "null" ? "" : String.valueOf(infoMap.get("reg_cdate"));
    String content		= String.valueOf(infoMap.get("content")) == "null" ? "" : String.valueOf(infoMap.get("content"));
    String attatch_file	= String.valueOf(infoMap.get("attatch_file")) == "null" ? "" : String.valueOf(infoMap.get("attatch_file"));
    String attatch_path	= String.valueOf(infoMap.get("attatch_path")) == "null" ? "" : String.valueOf(infoMap.get("attatch_path"));
    String seq 			= String.valueOf(infoMap.get("seq")) == "null" ? "" : String.valueOf(infoMap.get("seq"));
    String ymd			= String.valueOf(infoMap.get("ymd")) == "null" ? "" : String.valueOf(infoMap.get("ymd"));
	
%>

<html>
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링</title>
<link href="/edi/css/ds.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script> 
<script language="javascript"  src="/edi/js/common.js"  type="text/javascript"></script>
<script language="javascript"  src="/edi/js/PopupCalendar.js"  type="text/javascript"></script>

<script type="text/javascript">

function doit(){
	/*  버튼비활성화  */
	enableControl(del,false);   	//삭제
	enableControl(search,false);    //조회
	enableControl(newrow,false);    //신규
	enableControl(save,false);    	//신규
	enableControl(excel,false);     //엑셀
}

function searchVencd(){
	var arrArg  = new Array();
	arrArg.push(strcd);
	arrArg.push(strnm);
    arrArg.push(vencd);
    arrArg.push(vennm);
	var returnVal= window.showModalDialog("/edi/ejob902.ej?goTo=openVendorPop"
/*				   + "&strcd="+strcd
				   + "&strnm="+strnm
				   + "&vencd="+vencd
				   + "&vennm="+vennm*/
				   ,
			       arrArg,
                   "dialogWidth:800px;dialogHeight:500px;scroll:no;" +
                   "resizable:no;help:no;unadorned:yes;center:yes;status:no");
	
	if(returnVal != undefined) {
	    retVal = returnVal.split("/");
	    
	    // 총 3개의 값을 전달 받아야 한다.
	    document.getElementById("strcd").value = retVal[0];
	    document.getElementById("strnm").value = retVal[1];
	    document.getElementById("vencd").value = retVal[2];
	    document.getElementById("vennm").value = retVal[3];
	}
}

function btn_Print() {
	window.showModalDialog("/edi/ejob902.ej?goTo=printPop&strcd=<%=strcd%>&vencd=<%=vencd%>&ymd=<%=ymd%>&seq=<%=seq%>",
		    "",
            "dialogWidth:800px;dialogHeight:380px;scroll:yes;" +
            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
} 

// 파일 다운로드
function fileDown(filePath, fileName) {
	document.frm.action = "/edi/ejob902.ej?goTo=ejobFileDown&filePath="+filePath+"&fileName="+fileName;
	document.frm.target = "hiddenIfrm";
	document.frm.submit();
}
</script>

</head>

<body  class="PL10 PT15" onload="doit();">
<table width="97%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="396" class="title"><img src="/edi/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/><%=titleName%></td>
					<td width="414">
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="/edi/imgs/btn/search.gif" width="50" height="22" id="search" onclick="btn_Search();" /></td>
								<td><img src="/edi/imgs/btn/new.gif" width="50" height="22" id="newrow" onclick="btn_New();" /></td>
								<td><img src="/edi/imgs/btn/del.gif" width="50" height="22" id="del" onclick="btn_Del();" /></td>
								<td><img src="/edi/imgs/btn/save.gif" width="50" height="22" id="save" onclick="btn_Save();"/></td>
								<td><img src="/edi/imgs/btn/excel.gif" width="61" height="22" id="excel"/></td>
								<td><img src="/edi/imgs/btn/print.gif" width="50" height="22" id="prints" onclick="btn_Print();"/></td>
								<td><img src="/edi/imgs/btn/close.gif" width="50" height="22" onclick="self.close();" /></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr><td height="23px" colspan="2"></td></tr>
				<tr>
					<td colspan="2">
						<form name="frm" method="post">
						<input type="hidden" name="ymd" id="ymd" value="<%=ymd%>" />
						<input type="hidden" name="strcd" id="strcd" value="" />
						<input type="hidden" name="msgMode" id="msgMode" value="" />
						<input type="hidden" name="seq" id="seq" value="<%=seq%>" />
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="g_table">
							<tr>
								<th width="80">점명 </th>
								<td><input type="text"  value="" name="strnm" id="strnm" style="width:120px" onKeyDown="checkByteLength(this,40);" <%=readStr%>/></td>
								<th>협력사코드</th>
								<td>
									<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td><input type="text" value="" name="vencd" id="vencd" style="width:80px" onKeyDown="checkByteLength(this,6);" <%=readStr%>/></td>
										</tr>
									</table>
								</td>
								<th >협력사명</th>
								<td ><input type="text" value="" name="vennm" id="vennm" style="width:120px" onKeyDown="checkByteLength(this,40);" <%=readStr%>/></td>
							</tr>
						</table>
						
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
							<tr>
								<th style="width:15%">구직번호</th>
								<td colspan="3">&nbsp;&nbsp;<%=ymd%> - <%=hunt_seq%>
								
								</td>
							</tr>
							<tr>
								<th>제 목</th>
								<Td colspan="3">
								<input type="text" name="title" id="title" style="width:550px;" value="<%=title%>" onKeyDown="checkByteLength(this,100);" readOnly/>
								</Td>
							</tr>
							<tr>
								<th>구직자명</th>
								<Td>
								<input type="text" name="cust_nm" id="cust_nm" style="width:100px;" value="<%=cust_nm%>" onKeyDown="checkByteLength(this,40);" readOnly/>
								</Td>
								<th>연령</th>
								<Td>
								<input type="text" name="age" id="age" style="width:50px;" value="<%=age%>" onKeyDown="checkByteLength(this,40);" readOnly/> 세
								</Td>
							</tr>
							<tr>
								<th>경력</th>
								<Td>
								<input type="text" name="career_yy" id="career" style="width:50px;" value="<%=career_yy%>" onKeyDown="checkByteLength(this,30);" readOnly/>년
								<input type="text" name="career_mm" id="career_mm" style="width:50px;" value="<%=career_mm %>" onKeyDown="checkByteLength(this,30);" readOnly/>개월
								</Td>
								<th>연락처</th>
								<Td>
								<input type="text" name="tel_1" id="tel_1" style="width:60px;" value="<%=tel_1%>" onKeyDown="checkByteLength(this,30);" readOnly/> - 
								<input type="text" name="tel_2" id="tel_2" style="width:60px;" value="<%=tel_2%>" onKeyDown="checkByteLength(this,30);" readOnly/> - 
								<input type="text" name="tel_3" id="tel_3" style="width:60px;" value="<%=tel_3%>" onKeyDown="checkByteLength(this,30);" readOnly/>
								</Td>
							</tr>
							<tr>
								<th>희망연봉</th>
								<Td colspan="3">
								<input type="text" name="hope_salary" id="hope_salary"  style="width:80px;" value="<%=hope_salary%>" maxlength="40" readOnly/> 
								</Td>
							</tr>
							<tr>
								<th>등록일</th>
								<Td colspan="3">
								<input type="text" name="reg_date" id="reg_date" size="10" title="YYYY-MM-DD" value="<%=reg_cdate%>" maxlength="12" onblur="dateCheck(this);" readOnly/> 
								</Td>
							</tr>
							<tr>
								<th>내용</th>
								<Td colspan="3">
								<textarea name="content" cols="100" rows="15" wrap onKeyDown="checkByteLength(this,4000);" readOnly><%=content%></textarea>
								</Td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<Td colspan="3">
								<%
								List fList = (List)request.getAttribute("fList");
								if (fList != null && fList.size() > 0) {
									for(int i=0; i < fList.size(); i++)
									{
										Map map = (Map)fList.get(i);
								%>
										<a href="javascript:fileDown('<%=map.get("ATTATCH_PATH")%>', '<%=map.get("ATTATCH_FILE")%>');"><%=map.get("ATTATCH_FILE")%></a>
								<%
									}
								}
								%>
								
								</Td>
							</tr>
						</table>
						</form>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
<iframe name="hiddenIfrm" id="hiddenIfrm" style="display:none;" width="10" height="10"></iframe>
<script>
document.getElementById("vennm").value = '<%=vennm%>';
document.getElementById("vencd").value = '<%=vencd%>';
document.getElementById("strnm").value = '<%=strnm%>';
document.getElementById("strcd").value = '<%=strcd%>';
document.getElementById("msgMode").value = "U";
</script>
