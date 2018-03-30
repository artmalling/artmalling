<!-- 
/*******************************************************************************
 * 시스템명 :  경영지원 > EDI 협력사 > 커뮤니티 > 법률자문Q&A 리스트 
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

<%
    String dir = request.getContextPath();    
 
%>

<html>
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링</title>
<link href="/edi/css/ds.css" rel="stylesheet" type="text/css" />
<script language="javascript"  src="<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/PopupCalendar.js"  type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/global.js"    type="text/javascript"></script>

<script language="javascript">
var strCd  = dialogArguments[0];
var vencd  = dialogArguments[1];
var venNm  = dialogArguments[2];
var gb     = dialogArguments[3];
var userid     = dialogArguments[4];

function doinit(){
	
	getPumbunCombo(strCd, vencd, "reg_nm", "N");             //점별 브랜드   
     
    document.getElementById("title").focus();
}

/**
 * getPumbunCombo()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  점별브랜드콤보
 * return값 : void
 0. strcd : 점코드
 1. vencd : 협력사코드
 2. target : 진행 할 항목
 4. YN : Y 전체 포함        N 전체 포함 안함
 */ 
function getPumbunCombo(strcd, vencd, target, YN){
     var param = "";
    
     param = "&goTo=getPumbunCombo&strcd=" + strcd
              + "&vencd=" + vencd
              + "&gb=" + gb;
    
    
    <ajax:open callback="on_loadedXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/ccom001.cc"/>
    
    <ajax:callback function="on_loadedXML">
       
       var pumbun = document.getElementById(target);
       
       if( rowsNode.length > 0 ){
           
           if( YN == "Y" ){
               var emp_opt = document.createElement("option");
               emp_opt.setAttribute("value", "%");
               var emp_text = document.createTextNode("전체");
               emp_opt.appendChild(emp_text); 
               pumbun.appendChild(emp_opt);
           }
           
           for( i =0; i < rowsNode.length; i++){
               var opt = document.createElement("option");  
               opt.setAttribute("value", rowsNode[i].childNodes[0].childNodes[0].nodeValue);
               
               var text = document.createTextNode(rowsNode[i].childNodes[1].childNodes[0].nodeValue);
               opt.appendChild(text); 
               pumbun.appendChild(opt);
           }
       } else {
           var emp_opt = document.createElement("option");
           emp_opt.setAttribute("value", "%");
           var emp_text = document.createTextNode("전체");
           emp_opt.appendChild(emp_text); 
           pumbun.appendChild(emp_opt);
       }
       
       
    </ajax:callback>
}

/**
 * btn_save()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  팝업 리스트 등록 
 * return값 : void
 */
 
function btn_save(){
    var title = document.getElementById("title").value;
    var content = document.getElementById("textarea_content").value;
    var reg_cd = document.getElementById("reg_nm").value;
    var cnt = "";
    
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
    
    if( showMessage(QUESTION, YESNO, "GAUCE-1000", "저장하시겠습니까?") != 1){
        return;
    }
    
    var param = "&goTo=save&strFlag=insert&strcd="+strCd+"&vencd="+vencd+"&userid="+userid
              + "&title="+title+"&content="+content+"&pumbuncd="+reg_cd;
    
    <ajax:open callback="on_SaveXML" 
          param="param" 
          method="POST" 
          urlvalue="/edi/ecmn103.em"/>
    
    <ajax:callback function="on_SaveXML">
        cnt = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
        if( cnt == "1" ){
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

</script>

</head>
<body onload="doinit();" >
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
                                <span id="title1" class="PL03">법률자문Q&A등록</span>
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
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                        <tr>
                            <td>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                                    <tr>
                                        <th width="80" class="POINT">제목</th>
                                        <td width="500"><input  type="text" name="title" id="title" size="80" onkeyup="checkByteLength(this, 50);" /></td>
                                        <th width="80">등록자</th>
                                        <td>
                                            <select id="reg_nm" name="reg_nm" style="width: 105">
                                            
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="POINT">내용</th>
                                        <td colspan="3">
                                            <textarea rows="32" style="width: 100%;" name="textarea_content" id="textarea_content" onkeyup="checkByteLength(this, 4000);"></textarea>
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
