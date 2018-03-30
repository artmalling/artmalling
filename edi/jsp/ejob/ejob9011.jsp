<!-- 
/*******************************************************************************
 * 시스템명 : 온라인> 협력사관리> 협력사EDI관리> 구인상세보기 / 등록
 * 작 성 일 : 2011.04.20
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : ejob9011.jsp
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
    String dir = request.getContextPath();
    SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
    String gb                = sessionInfo.getGB();             //협력사 1, 브랜드 2,
    String userId           =   sessionInfo.getUSER_ID();

    String mode             = request.getParameter("mode");

    String titleName        = "구인정보 등록/수정";

    String title            = "";
    String brand            = "";
    String wanted_job       = "";
    String end_dt           = "";
    String person_charge    = "";
    String tel_1            = "";
    String tel_2            = "";
    String tel_3            = "";
    String submit_doc       = "";
    String content          = "";
    String strcd            = request.getParameter("strcd");
    String strnm            = request.getParameter("strnm");
    String userid           = request.getParameter("userid");
    String vennm            = request.getParameter("vennm");
    String vencd            = request.getParameter("vencd");
    String ym               = "";
    String reg_date         = "";
    String seq              = "";
    String reg_id           = "";
    
    
    Date date = new Date();
    SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy/MM/dd");
    String strdate = simpleDate.format(date);
    String strdateYY = strdate.substring(0,4);
    String strdateMM = strdate.substring(5,7);
    String strdateDD = strdate.substring(8,10);
    
    ym = strdateYY + strdateMM;
    
    
    // 상세보기경우
    if(mode.equals("U")) {
        Map infoMap     = (Map)request.getAttribute("infoMap");
        title           = String.valueOf(infoMap.get("TITLE"));
        brand           = String.valueOf(infoMap.get("BRAND"));
        wanted_job      = String.valueOf(infoMap.get("WANTED_JOB"));
        end_dt          = String.valueOf(infoMap.get("END_DT"));
        System.out.println("============");
        System.out.println(end_dt);
        person_charge   = String.valueOf(infoMap.get("PERSON_CHARGE"));
        submit_doc      = String.valueOf(infoMap.get("SUBMIT_DOC"));
        tel_1           = String.valueOf(infoMap.get("TEL_1"));
        tel_2           = String.valueOf(infoMap.get("TEL_2"));
        tel_3           = String.valueOf(infoMap.get("TEL_3"));
        content         = String.valueOf(infoMap.get("CONTENT"));
        strcd           = String.valueOf(infoMap.get("STR_CD"));
        strnm           = String.valueOf(infoMap.get("STR_NM"));
        vennm           = String.valueOf(infoMap.get("VEN_NM"));
        vencd           = String.valueOf(infoMap.get("VEN_CD"));
        ym              = String.valueOf(infoMap.get("YM"));
        seq             = String.valueOf(infoMap.get("SEQ"));
        reg_date        = String.valueOf(infoMap.get("REG_DATE")).substring(0,10);
        reg_id          = String.valueOf(infoMap.get("REG_ID"));
        
    }
    
%>

<html>
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링</title>
<link href="/edi/css/ds.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script> 
<script language="javascript"  src="<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/popup.js"  type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/global.js"    type="text/javascript"></script>

<script type="text/javascript">

<% if(mode.equals("I")) { %>
var strcd    = dialogArguments[0];
var strnm    = dialogArguments[1];
var vencd    = dialogArguments[2];
var vennm    = dialogArguments[3];
var userid   = dialogArguments[4];
<%}%>

function doit(){
    /*  버튼비활성화  */
    <%if(mode.equals("I")) { %>
    enableControl(del,false);   //삭제
    <% } %>
    enableControl(search,false);   //조회
    enableControl(newrow,false);   //신규
    enableControl(excel,false);    //엑셀
    enableControl(prints,false);   //프린터
    
    //getSearch();           //상세조회
    <% if (mode.equals("U") && !gb.equals("1") && !gb.equals("2")) { %>
    enableControl(document.getElementById("btn_Vencd"),false);   //협력업체
    <% } %>
    
    document.getElementById("end_dt").focus();
    document.getElementById("title").focus();
}

function btn_Save()
{
    var strcd           = document.getElementById("strcd").value;
    var strnm           = document.getElementById("strnm").value;
    var vencd           = document.getElementById("vencd").value;
    var vennm           = document.getElementById("vennm").value;
    var title           = document.getElementById("title").value;
    var content         = document.getElementById("content").value;
    var brand           = document.getElementById("brand").value;
    var wanted_job      = document.getElementById("wanted_job").value;
    var end_dt          = document.getElementById("end_dt").value;
    var person_charge   = document.getElementById("person_charge").value;
    var submit_doc      = document.getElementById("submit_doc").value;
    var tel_1           = document.getElementById("tel_1").value;
    var tel_2           = document.getElementById("tel_2").value;
    var tel_3           = document.getElementById("tel_3").value;
    var ym              = document.getElementById("ym").value;
    var msgMode         = document.getElementById("msgMode").value;
    var userid          = '<%=userId%>';
    var seq             = document.getElementById("seq").value;
    
    // validation check
    if (title == "") {
        showMessage(STOPSIGN, OK, "USER-1003",  "제목");
        document.getElementById("title").focus();
        return false;
    }
    if (brand == "") {
        showMessage(STOPSIGN, OK, "USER-1003",  "브랜드명");
        document.getElementById("brand").focus();
        return false;
    }
    if (wanted_job == "") {
        showMessage(STOPSIGN, OK, "USER-1003",  "구인직무명");
        document.getElementById("wanted_job").focus();
        return false;
    }
    if (end_dt == "") {
        showMessage(STOPSIGN, OK, "USER-1003",  "마감일");
        document.getElementById("end_dt").focus();
        return false;
    }
    if (person_charge == "") {
        showMessage(STOPSIGN, OK, "USER-1003",  "담당자명");
        document.getElementById("person_charge").focus();
        return false;
    }
    if (tel_1 == "") {
        showMessage(STOPSIGN, OK, "USER-1003",  "연락처");
        document.getElementById("tel_1").focus();
        return false;
    }
    if (tel_2 == "") {
        showMessage(STOPSIGN, OK, "USER-1003",  "연락처");
        document.getElementById("tel_2").focus();
        return false;
    }
    if (tel_3 == "") {
        showMessage(STOPSIGN, OK, "USER-1003",  "연락처");
        document.getElementById("tel_3").focus();
        return false;
    }
    if (submit_doc == "") {
        showMessage(STOPSIGN, OK, "USER-1003",  "제출서류");
        document.getElementById("submit_doc").focus();
        return false;
    }
    if (content == "") {
        showMessage(STOPSIGN, OK, "USER-1003",  "내용");
        document.getElementById("content").focus();
        return false;
    }
    
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1){                         
        return;
    }
    
    var param = "&goTo=saveDetail&mode="+msgMode+"&strcd="+strcd+"&vencd="+vencd+"&vennm="+vennm
          + "&title="+title+"&content="+content+"&userid="+userid+"&submit_doc="+submit_doc+"&person_charge="+person_charge
          + "&seq="+seq
          + "&end_dt="+end_dt+"&wanted_job="+wanted_job+"&brand="+brand+"&tel_1="+tel_1+"&tel_2="+tel_2+"&tel_3="+tel_3+"&ym="+ym;
    <ajax:open callback="on_loadedXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/ejob901.ej"/>
    
    <ajax:callback function="on_loadedXML">
        cnt = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
        if( cnt == "1" ){
            showMessage(INFORMATION, OK, "USER-1000", "정상적으로 처리되었습니다.");
            window.returnValue = true;
            
            self.close();
        }else {
            window.returnValue = false;
        }
    </ajax:callback>
}

function btn_Del()
{
    var strcd           = document.getElementById("strcd").value;
    var vencd           = document.getElementById("vencd").value;
    var ym              = document.getElementById("ym").value;
    var seq             = document.getElementById("seq").value;
    
    if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ) return;
    
    var param = "&goTo=delDetail&mode=D&strcd="+strcd+"&vencd="+vencd
          + "&seq="+seq
          + "&ym="+ym;
    <ajax:open callback="on_loadedXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/ejob901.ej"/>
    
    <ajax:callback function="on_loadedXML">
        cnt = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
        if( cnt == "1" ){
            showMessage(INFORMATION, OK, "USER-1000", "정상적으로 처리되었습니다.");
            window.returnValue = true;
            self.close();
        }else {
            window.returnValue = false;
        }
    </ajax:callback>
}

function searchVencd()
{
    var arrArg  = new Array();
    arrArg.push(strcd);
    arrArg.push(strnm);
    arrArg.push(vencd);
    arrArg.push(vennm);
    var returnVal= window.showModalDialog("/edi/ejob901.ej?goTo=openVendorPop"
/*                 + "&strcd="+strcd
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
                                <td><img src="/edi/imgs/btn/print.gif" width="50" height="22" id="prints"/></td>
                                <td align="right"><img src="/edi/imgs/btn/close.gif" width="50" height="22" onclick="self.close();" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr><td height="23px" colspan="2"></td></tr>
                <tr>
                    <td colspan="2">
                        <form name="frm" method="post">
                        <input type="hidden" name="ym" id="ym" value="<%=ym%>" />
                        <input type="hidden" name="strcd" id="strcd" value="" />
                        <input type="hidden" name="msgMode" id="msgMode" value="" />
                        <input type="hidden" name="seq" id="seq" value="<%=seq%>" />
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="g_table">
                            <tr>
                                <th width="80">점명 </th>
                                <td><input type="text"  value="" name="strnm" id="strnm" style="width:100%" onKeyDown="checkByteLength(this,40);" readOnly/></td>
                                <th>협력사코드</th>
                                <td>
                                    <table border="0" align="center" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td><input type="text" value="" name="vencd" id="vencd" style="width:100%" onKeyDown="checkByteLength(this,6);" readOnly/></td>
                                            <%if (!gb.equals("1") && !gb.equals("2")) { %>
                                            <td><img src="/edi/imgs/btn/search.gif" width="50" height="22" id="btn_Vencd" onclick="searchVencd();"/></td>
                                            <% } %>
                                        </tr>
                                    </table>
                                </td>
                                <th >협력사명</th>
                                <td ><input type="text" value="" name="vennm" id="vennm" style="width:100%" onKeyDown="checkByteLength(this,40);" readOnly/></td>
                            </tr>
                        </table>
                        
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                            <tr>
                                <th style="width:15%">구인번호</th>
                                <td colspan="3">&nbsp;&nbsp;<%=ym%>-<%=seq%>
                                
                                </td>
                            </tr>
                            <tr>
                                <th>* 제 목</th>
                                <Td colspan="3">
                                <input type="text" name="title" id="title" style="width:100%;" value="<%=title%>" onKeyUp="checkByteLength(this,100);">
                                </Td>
                            </tr>
                            <tr>
                                <th>* 브랜드명</th>
                                <Td colspan="3">
                                <input type="text" name="brand" id="brand" style="width:100%;" value="<%=brand%>" onKeyUp="checkByteLength(this,40);">
                                </Td>
                            </tr>
                            <tr>
                                <th>* 구인직무</th>
                                <Td colspan="3">
                                <input type="text" name="wanted_job" id="wanted_job" style="width:100%;" value="<%=wanted_job%>" onKeyUp="checkByteLength(this,30);">
                                </Td>
                            </tr>
                            <tr>
                                <th>* 마감일</th>
                                <Td colspan="3">
                                <input type="text" name="end_dt" id="end_dt" size="10" title="YYYY/MM/DD" value="<%=end_dt%>" maxlength="10" style='IME-MODE: disabled' onblur="dateCheck(this);" onfocus="dateValid(this);" /> 
                                <img src="/edi/imgs/icon/ico_calender.gif" alt="마감일" id="popCalendar" align="absmiddle" onclick="openCal('G',end_dt);return false;" />
                                </Td>
                            </tr>
                            <tr>
                                <th>* 담당자</th>
                                <Td>
                                <input type="text" name="person_charge" id="person_charge" style="width:120px;" value="<%=person_charge%>" onKeyUp="checkByteLength(this,40);">
                                </Td>
                                <th>* 연락처</th>
                                <Td>
                                <input type="text" name="tel_1" id="tel_1" style="width:50px;" value="<%=tel_1%>" onkeypress="javascript:onlyNumber();" onKeyDown="checkByteLength(this,4);" maxlength="4" style="text-align:center;IME-MODE: disabled">  
                                 - <input type="text" name="tel_2" id="tel_2" style="width:50px;" value="<%=tel_2%>" onkeypress="javascript:onlyNumber();" onKeyDown="checkByteLength(this,4);" maxlength="4" style="text-align:center;IME-MODE: disabled">
                                 - <input type="text" name="tel_3" id="tel_3" style="width:50px;" value="<%=tel_3%>" onkeypress="javascript:onlyNumber();" onKeyDown="checkByteLength(this,4);" maxlength="4" style="text-align:center;IME-MODE: disabled">
                                </Td>
                            </tr>
                            <tr>
                                <th>* 제출서류</th>
                                <Td colspan="3">
                                <input type="text" name="submit_doc" id="submit_doc" style="width:100%;" value="<%=submit_doc%>" onKeyUp="checkByteLength(this,100);">
                                </Td>
                            </tr>
                            <tr>
                                <th>* 내용</th>
                                <Td colspan="3">
                                <textarea name="content" cols="100" rows="10" wrap onKeyUp="checkByteLength(this,4000);"><%=content%></textarea>
                                </Td>
                            </tr>
                            <tr>
                                <th>등록자</th>
                                <Td><%=reg_id%></Td>
                                <th>등록일</th>
                                <td><%=reg_date%></td>
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
<script>
<% if (mode.equals("I")) { %>
document.getElementById("strcd").value = strcd;
document.getElementById("vennm").value = vennm;
document.getElementById("vencd").value = vencd;
document.getElementById("strnm").value = strnm;
document.getElementById("msgMode").value = "I";

<% } else {%>
document.getElementById("vennm").value = '<%=vennm%>';
document.getElementById("vencd").value = '<%=vencd%>';
document.getElementById("strnm").value = '<%=strnm%>';
document.getElementById("strcd").value = '<%=strcd%>';
document.getElementById("msgMode").value = "U";
<% } %>
</script>
