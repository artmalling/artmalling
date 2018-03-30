<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"
 import="kr.fujitsu.ffw.base.BaseProperty,kr.fujitsu.ffw.util.String2,kr.fujitsu.ffw.control.ActionForm" %>
<%@ page import="ecom.util.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="sun.misc.FormattedFloatingDecimal.Form"%>
<%@ page import="ecom.vo.SessionInfo2"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>
 
<%
    String dir = request.getContextPath();

    SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
    String userid = sessionInfo.getUSER_ID();       //사용자아이디
    String strcd = sessionInfo.getSTR_CD();         //점코드
    String strNm = sessionInfo.getSTR_NM();         //점명
    String vencd = sessionInfo.getVEN_CD();         //협력사코드
    String venNm = sessionInfo.getVEN_NAME();       //협력사명
 
%>
<html>
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링</title>
<link href="<%=dir%>/css/ds.css" rel="stylesheet" type="text/css" />
<script language="javascript"  src="<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/popup.js"  type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/global.js"    type="text/javascript"></script>

<script type="text/javascript">
var userid = '<%=userid%>';
var vencd = '<%=vencd%>';
var venNm = '<%=venNm%>';
var g_strcd = '<%=strcd%>';
var g_pre_row = -1;
var g_last_row = -1;

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 
function doinit(){
     
    /*  버튼비활성화  */
    enableControl(search,true);    //조회 
    enableControl(newrow,false);   //신규    
    enableControl(del,false);      //삭제
    enableControl(save,false);     //저장
    enableControl(excel,false);    //엑셀
    enableControl(prints,false);   //프린터
    enableControl(set,false);      //출력
    
    
    /*  조회부 */
    
    document.getElementById("strcd").value = '<%=strcd%>';  //점코드 
    initDateText("YYYYMM", "sDate");                        //시작월
    initDateText("YYYYMM", "eDate");                        //종료월
     
    
}

/**
 * getSelectCombo()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  조회 (기준일 , 전표구분)
 * return값 : void
 */ 
function getSelectCombo(syspat,compart, target, YN){
    
    var param = "&goTo=getEtcCode&syspat="+syspat+"&compart="+compart;
    <ajax:open callback="on_SelectComboXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/ccom001.cc"/>
    
    
    <ajax:callback function="on_SelectComboXML"> 
    
    var sel_box = document.getElementById(target);
    if( rowsNode.length > 0){
        if( YN == "Y" ){
             var opt = document.createElement("option");  
             opt.setAttribute("value", "%");
             
             var text = document.createTextNode("전체");
             opt.appendChild(text); 
             sel_box.appendChild(opt);
        }
        for( i =0; i < rowsNode.length; i++){
            var opt = document.createElement("option");  
            opt.setAttribute("value", rowsNode[i].childNodes[0].childNodes[0].nodeValue);
            
            var text = document.createTextNode(rowsNode[i].childNodes[1].childNodes[0].nodeValue);
            opt.appendChild(text); 
            sel_box.appendChild(opt);
        }
        
    } else {
        var opt = document.createElement("option");  
        opt.setAttribute("value", "%");
        
        var text = document.createTextNode("전체");
        opt.appendChild(text); 
        sel_box.appendChild(opt);
    }    
    
    
    
    </ajax:callback>
}
 



 
/**
 * btn_Sch()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  조회  
 * return값 : void
 */
function btn_Sch(){
    
    var strStrcd = document.getElementById("strcd").value;                      //점코드
    var strVencd = document.getElementById("vencd").value;                      //협력사코드
    var sDate = getRawData(document.getElementById("sDate").value);             //시작월
    var eDate = getRawData(document.getElementById("eDate").value);             //종료월
   
    if( sDate == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "시작월");
        document.getElementById("sDate").focus();
        return;
    }
    
    if( eDate == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "종료월");
        document.getElementById("eDate").focus();
        return;
    }
    
    if( sDate > eDate ){
        showMessage(StopSign, OK, "USER-1008", "종료월", "시작월");
        document.getElementById("sDate").focus();
        return;
    }
    
    var param = "&goTo=getMaster" + "&strcd=" + strStrcd
                                  + "&vencd=" + strVencd
                                  + "&sDate=" + sDate
                                  + "&eDate=" + eDate;
    
    <ajax:open callback="on_SearchXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/eren102.er"/>
    
    <ajax:callback function="on_SearchXML">
        
        var content = "<table width='795' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
        if( rowsNode.length > 0 ){
        	var payAmtSum = 0;
        	for( i = 0; i < rowsNode.length; i++ ){
        		var strcd = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
        		var strNm = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
        		var vencd = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
        		var calYm = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
        		var payDt = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
        		var paySeqNo = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
        		var payAmt = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
        		var remark = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
        		
        		payAmtSum += Number(payAmt);
        		
        		content += "<tr onclick='chBak("+i+");' style='cursor:hand;'>";
        		content += "<td width='35' class='r1' id='1tdId"+i+"'>"+(i+1)+"</td>";
        		content += "<td width='95' class='r3' id='2tdId"+i+"'>"+strNm+"</td>";
        		content += "<td width='95' class='r1' id='3tdId"+i+"'>"+getDateFormat(calYm)+"</td>";
        		content += "<td width='95' class='r1' id='4tdId"+i+"'>"+getDateFormat(payDt)+"</td>";
        		content += "<td width='55' class='r1' id='5tdId"+i+"'>"+paySeqNo+"</td>";
        		content += "<td width='145' class='r4' id='6tdId"+i+"'>"+convAmt(payAmt)+"</td>";
        		content += "<td width='240' class='r3' id='7tdId"+i+"'>"+remark+"</td>";
        		content += "</tr>";
        		
        	}
        	content += "<tr>";
        	content += "<td class='sum1'>&nbsp;</td>"
            content += "<td class='sum1' colspan='4'>합 계</td>"
            content += "<td class='sum2'>"+convAmt(String(payAmtSum))+"</td>";
            content += "<td class='sum1'>&nbsp;</td>"
        	content += "</tr>";
        }
        content += "</table>";
        document.getElementById("DIV_Content").innerHTML = content;
        setPorcCount("SELECT", rowsNode.length);  
    </ajax:callback>
}

function chBak(val) {
    g_last_row = val;
    
    if (g_pre_row != g_last_row){
        for(i=1;i<8;i++) {
            document.getElementById(i+"tdId"+val).style.backgroundColor="#fff56E";
    
            if (g_pre_row != -1) {
                document.getElementById(i+"tdId"+g_pre_row).style.backgroundColor="#ffffff";
            }
        }
    }
    g_pre_row = g_last_row;
}


function scrollAll() {
    document.all.topTitle.scrollLeft = document.all.DIV_Content.scrollLeft;
}
  

</script>
</head>
<body  class="PL10 PR07 PT15" onLoad="doinit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/> 임대입금내역조회</td>
        <td><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onClick="javascript:btn_Sch();"/></td>
            <td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow" onClick="addRow();" /></td>
            <td><img src="<%=dir%>/imgs/btn/del.gif" width="50" height="22" id="del" /></td>
            <td><img src="<%=dir%>/imgs/btn/save.gif" width="50" height="22" id="save" /></td>
            <td><img src="<%=dir%>/imgs/btn/excel.gif" width="61" height="22" id="excel" /></td>
            <td><img src="<%=dir%>/imgs/btn/print.gif" width="50" height="22" id="prints" /></td>
            <td><img src="<%=dir%>/imgs/btn/set.gif" width="50" height="22" id="set" /></td>      
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="POINT">점</th>
            <td width="140"><input type="text"  name="strnm" id="strnm" size="20" maxlength="10" value="<%=strNm%>" disabled="disabled" /><input type="hidden" name="strcd" id="strcd"  ></td>
            <th width="80" class="POINT">협력사코드</th>
            <td width="140">
                <input type="hidden" name="vencd" id="vencd" value="<%=vencd%>" disabled="disabled"  />
                <input type="text" name="venNM" id="venNM" size="20" value="<%=venNm %>" disabled="disabled" />
            </td>
            <th width="80">년월</th>
            <td>
                <input type="text" name="sDate" id="sDate" size="10" onkeypress="javascript:onlyNumber();" onblur="dateOnblur(this);" onfocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' maxlength="6" />
                <img src="<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',sDate)" align="absmiddle" />~
                <input type="text" name="eDate" id="eDate" size="10" onkeypress="javascript:onlyNumber();" onblur="dateOnblur(this);" onfocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' maxlength="6" />
                <img src="<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',eDate)" align="absmiddle" />
                
            </td>
          </tr>
        </table>
        </td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td height="2"></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr>
    <td height="2"></td>
  </tr>
  <tr valign="top">
    <td >
    <table width="100%"  border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr valign="top">
        <td><div id="topTitle" style="width:815px;overflow:hidden;">
                <table width="815" cellpadding="0" cellspacing="0" border="0" class="g_table" >
                    <tr>
                        <th width="35">NO</th>
                        <th width="95">점</th>
                        <th width="95">청구년월</th>
                        <th width="95">입금일자</th>
                        <th width="55">순번</th>
                        <th width="145">입금금액</th>
                        <th width="240">비고</th>
                        <th width="15">&nbsp;</th>
                    </tr>
                </table>
            </div>        
        </td>
      </tr>
      <tr>
          <td ><div id="DIV_Content" style="width:815px;height:485px;overflow:scroll" onscroll="scrollAll();">
                  <table width="795" cellspacing="0" cellpadding="0" border="0" class="g_table"> 
                  </table>  
              </div>
          </td>  
      </tr>
    </table>
    </td>
  </tr>
</table>

</body>
</html>

