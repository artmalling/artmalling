<!-- 
/*******************************************************************************
 * 시스템명 :  경영지원 > EDI 협력사 > 커뮤니티 > Q&A 리스트 
 * 작 성 일 : 2011.04.14
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : ecmn1021.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 : 2011.01.14 (김슬기) 신규작성
           
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"
 import="kr.fujitsu.ffw.base.BaseProperty,kr.fujitsu.ffw.util.String2,kr.fujitsu.ffw.control.ActionForm" %>
<%@ page import="ecom.util.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="ecom.vo.SessionInfo2"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>

<%
    String dir = request.getContextPath();    
 
%>

<html>
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링</title>
<link href="/edi/css/ds.css" rel="stylesheet" type="text/css" />
<script language="javascript"  src="/edi/js/common.js"  type="text/javascript"></script>
<script language="javascript"  src="/edi/js/PopupCalendar.js"  type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/global.js"    type="text/javascript"></script>

<script language="javascript">
var str_strCd    = dialogArguments[0];
var str_regDt    = dialogArguments[1];
var strSeqno     = dialogArguments[2];
var userid     = dialogArguments[3];
var pumbunNm     = dialogArguments[4];
var strcd = "";

/**
 * doinit()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  해당 페이지 LOND 시 
 * return값 : void
 */
 
function doinit(){
	
	getSearch();           //상세조회
	document.getElementById("title").focus();
}

/**
 * getSearch()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  조회
 * return값 : void
 */
 
function getSearch(){
	var frm = document.frm;
    var param = "&goTo=getDetail&strcd="+str_strCd+"&regDt="+str_regDt+"&seqno="+strSeqno;
    
    <ajax:open callback="on_loadedXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/ecmn102.em"/>
    
    <ajax:callback function="on_loadedXML">
        strcd = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
        var reply_yn = rowsNode[0].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[8].childNodes[0].nodeValue;     //답변 yn
        var any_contnet = rowsNode[0].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[5].childNodes[0].nodeValue;  //리플 답변
        
        document.getElementById("title").value = rowsNode[0].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[3].childNodes[0].nodeValue;
        document.getElementById("textarea_content").value = rowsNode[0].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[4].childNodes[0].nodeValue;
        document.getElementById("reg_nm").value = rowsNode[0].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[7].childNodes[0].nodeValue;
        
        if( reply_yn == "N" ){
            document.getElementById("textarea_reply").value = "";         
            enableControl(save,true);     //저장버튼 활성화
            enableControl(del,true);     //삭제버튼 활성화
        }else {
            document.getElementById("textarea_reply").value = any_contnet;
            enableControl(save,true);     //저장버튼 비활성화
            enableControl(del,false);     //삭제버튼 비활성화
        }

    </ajax:callback>
}

/**
 * btn_save()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  저장
 * return값 : void
 */
 
function btn_save(){
	
	var cnt = "";
	var title = document.getElementById("title").value;
	var content = document.getElementById("textarea_content").value;	
	
	if( trim(document.getElementById("title").value) == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "제목");
        document.getElementById("title").focus();
        return;
    }
    if( trim(document.getElementById("textarea_content").value) == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "내용");
        document.getElementById("textarea_content").focus();
        return;
    }
    
    if( showMessage(QUESTION, YESNO, "GAUCE-1000", "저장하시겠습니까?") != 1 ){
        return;
    }
	
	var param = "&goTo=save&strFlag=save&strcd="+strcd+"&regDt="+str_regDt+"&seq_no="+strSeqno
	      + "&title="+title+"&content="+content+"&userid="+userid;
	
	<ajax:open callback="on_loadedXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/ecmn102.em"/>
    
    <ajax:callback function="on_loadedXML">
        cnt = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
        if( cnt == "1" ){
        	showMessage(INFORMATION, OK, "GAUCE-1000", cnt+"건이 저장되었습니다.")
        	window.returnValue = true;
        }else {
        	showMessage(INFORMATION, OK, "GAUCE-1000", cnt)
        	window.returnValue = false;
        }
        window.close();
    </ajax:callback>
	
}

/**
 * btn_del()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  삭제
 * return값 : void
 */
 
function btn_del(){
    
    if( showMessage(QUESTION, YESNO, "GAUCE-1000", "삭제하시겠습니까?") != 1 ){
        return;
    }
    
	var param = "&goTo=save&strFlag=delete&strcd="+strcd+"&regDt="+str_regDt+"&seq_no="+strSeqno;
	
	<ajax:open callback="on_loadedXML" 
               param="param" 
               method="POST" 
               urlvalue="/edi/ecmn102.em"/>
	
	<ajax:callback function="on_loadedXML">
	    cnt = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
	    if( cnt == "1" ){
	    	showMessage(INFORMATION, OK, "GAUCE-1000", cnt+"건이 삭제되었습니다.")
	        window.returnValue = true;
	    }else {
	    	showMessage(INFORMATION, OK, "GAUCE-1000", cnt)
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
                                <span id="title1" class="PL03">Q&A상세조회</span>
                            </td>
                            <td>
                                <table border="0" align="right" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td><img src="/edi/imgs/btn/save.gif" width="50" height="22" id="save" onclick="javascript:btn_save();" /></td>
                                        <td><img src="/edi/imgs/btn/del.gif" width="50" height="22" id="del" onclick="javascript:btn_del();" /></td>
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
                    <form name="frm" method="post" action="#">
                    <input type="hidden" name="strcd" id="strcd" />
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                        <tr>
                            <td>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                                    <tr>
                                        <th width="80" class="POINT" >제목</th>
                                        <td width="450" height="20"><input  type="text" name="title" id="title" size="70" onkeyup="checkByteLength(this, 50);"  /></td>
                                        <th width="80">등록자</th>
                                        <td><input type="text" name="reg_nm" id="reg_nm" size="24"  disabled="disabled" /></td>
                                    </tr>
                                    <tr>
                                        <th class="POINT" >내용</th>
                                        <td colspan="3">
                                            <textarea rows="20" style="width: 100%;" name="textarea_content" id="textarea_content" onkeyup="checkByteLength(this, 4000);"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>답변</th>
                                        <td colspan="3">
                                            <textarea rows="10" style="width: 100%;"  name="textarea_reply" id="textarea_reply" disabled="disabled"></textarea>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    </form>
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
