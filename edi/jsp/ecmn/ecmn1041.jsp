<!-- 
/*******************************************************************************
 * 시스템명 :  경영지원 > EDI 협력사 > 커뮤니티 > Q&A 리스트 팝업 
 * 작 성 일 : 2011.04.14
 * 작 성 자 : 오형규
 * 수 정 자 : 
 * 파 일 명 : ecmn1021.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 : 2011.01.14 (오형규) 신규작성
           
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"
 import="kr.fujitsu.ffw.base.BaseProperty,kr.fujitsu.ffw.util.String2,kr.fujitsu.ffw.control.ActionForm" %>
<%@ page import="ecom.util.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="ecom.vo.SessionInfo2"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    String dir = request.getContextPath();

    Map map = (Map)request.getAttribute("Map");
    String title = map.get("title") == null ? "" : map.get("title").toString();
    String buyerNm = map.get("BUYER_NAME") == null ? "" : map.get("BUYER_NAME").toString();
    String content = map.get("CONTENT") == null ? "" : map.get("CONTENT").toString();
    
%>
<html>
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링</title>
<link href="/edi/css/ds.css" rel="stylesheet" type="text/css" />
<script language="javascript"  src="<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/popup.js"  type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/global.js"    type="text/javascript"></script>

<script language="javascript">
var strcd  = dialogArguments[0];
var reqNo  = dialogArguments[1];
var regDt  = dialogArguments[2];
var row    = dialogArguments[3];

/**
 * doinit()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  해당 페이지 LOND 시 
 * return값 : void
 */
 
function doinit(){
	 document.getElementById("title").readonly = true;
	 document.getElementById("title").style.backgroundColor = "#dcdcdc";
	 document.getElementById("reg_nm").readonly = true;
     document.getElementById("reg_nm").style.backgroundColor = "#dcdcdc";
     document.getElementById("textarea_content").readonly = true;
     document.getElementById("textarea_content").style.backgroundColor = "#dcdcdc";
     document.getElementById("reply_title").focus();
}

/**
 * btn_save()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  저장
 * return값 : void
 */
 
function btn_save(){
	
	if( document.getElementById("reply_title").value == "" ){
		showMessage(INFORMATION, OK, "USER-1003", "댓글 제목");
        document.getElementById("reply_title").focus();
        return;
    }
	
	if( document.getElementById("textarea_reply").value == "" ){
	    showMessage(INFORMATION, OK, "USER-1003", "댓글 내용");
        document.getElementById("textarea_reply").focus();
        return;
	}
	
	if( showMessage(QUESTION, YESNO, "GAUCE-1000", "저장하시겠습니까?") != 1){
	       return;
	}
	
	
	var reply_title =  document.getElementById("reply_title").value;
	var reply_content = document.getElementById("textarea_reply").value;
	var strReply_regcd = document.getElementById("reply_reg").value;
	 
    var param = "&goTo=ins_reply&strcd="+strcd+"&reqNo="+reqNo+"&regDt="+regDt+"&reply="+encodeURIComponent(reply_content)
              + "&reply_title="+encodeURIComponent(reply_title) + "&reply_regcd=" +strReply_regcd;
    
    <ajax:open callback="on_INS_replyXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/ecmn104.em"/>
	
	<ajax:callback function="on_INS_replyXML">
		var cnt = rowsNode[0].childNodes[0].childNodes[0].nodeValue == null ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
		
	    if( Number(cnt) > 0 ){
	    	showMessage(INFORMATION, OK, "GAUCE-1000", cnt+"건이 저장되었습니다.");
	        window.returnValue = true;
	    }else {
	    	showMessage(INFORMATION, OK, "GAUCE-1000", cnt);
	        window.returnValue = false;
	    }
	    window.close(); 
     
    </ajax:callback>
    
}

/**
 * btn_close()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  팝업 닫기 
 * return값 : void
 */
 
 
function btn_close(){
    window.close();
}

function tabDn(){
	if(event.keyCode == 9) {
        document.getElementById("textarea_content").focus();
    }
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
                                <span id="title1" class="PL03">게시판 댓글등록</span>
                            </td>
                            <td>
                                <table border="0" align="right" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td><img src="/edi/imgs/btn/save.gif" width="50" height="22" id="save" onclick="javascript:btn_save();" /></td>
                                        <td><img src="/edi/imgs/btn/close.gif" width="50" height="22" onclick="javascript:btn_close();" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="6"></td>
            </tr>            
            <tr>
                <td>
                    
                    <input type="hidden" name="strcd" id="strcd" />
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                        <tr>
                            <td>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                                    <tr>
                                        <th width="80">제목</th>
                                        <td width="450"><input  type="text" name="title" id="title" value="<%=title%>" size="72" onkeyup="checkByteLength(this, 50);"  tabIndex="1" /></td>
                                        <th width="80">등록자</th>
                                        <td><input type="text" name="reg_nm" id="reg_nm" size="24" value="<%=buyerNm%>" tabIndex="1" /></td>
                                    </tr>
                                    <tr>
                                        <th>내용</th>
                                        <td colspan="3">
                                            <textarea rows="20" style="width: 100%;" name="textarea_content" id="textarea_content"  onkeyup="checkByteLength(this, 4000);" tabIndex="1"  ><%=content%></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="point">댓글 제목</th>
                                        <td >
                                            <input type="text" name="reply_title" id="reply_title" size="72" tabIndex="1" onkeyup="checkByteLength(this, 50);"  />
                                        </td>
                                        <th class="point">댓글 등록자</th>
                                        <td>
                                            <select name="reply_reg" id="reply_reg" style="width: 155;">
                                                <c:if test="${ !empty reglist }" >
                                                    <c:forEach items="${reglist}" var="regnm" >
                                                        <option value="${regnm.PUMBUN_CD}">${regnm.PUMBUNNM }</option>
                                                    </c:forEach>
                                                </c:if>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="point">댓글 내용</th>
                                        <td colspan="3">
                                            <textarea rows="10" style="width: 100%;" name="textarea_reply" id="textarea_reply" onkeyup="checkByteLength(this, 4000);" tabIndex="1" ></textarea>
                                        </td>
                                    </tr>
                                </table>
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
