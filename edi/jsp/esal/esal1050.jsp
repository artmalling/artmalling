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
    String gb = sessionInfo.getGB();                //1. 협력사     2.브랜드
    String vencd = sessionInfo.getVEN_CD();         //협력사코드
    String venNm = sessionInfo.getVEN_NAME();       //협력사명
    String pumbunCd          = sessionInfo.getPUMBUN_CD();      //브랜드코드
    String pumbunNm          = sessionInfo.getPUMBUN_NAME();    //브랜드명
 
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
<script language="javascript" src="<%=dir%>/js/excelExport.js"    type="text/javascript"></script>
<script type="text/javascript">
var userid = '<%=userid%>';
var gb = '<%=gb%>';
var vencd = '<%=vencd%>';
var venNm = '<%=venNm%>';
var g_strcd = '<%=strcd%>';
var pumbunCd    = '<%=pumbunCd%>';
var pumbunNm    = '<%=pumbunNm%>';
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
    enableControl(excel,true);    //엑셀
    enableControl(prints,false);   //프린터
    enableControl(set,false);      //출력
    
    /*  조회부 */
    /* 구분 값이 브랜드로 로그인시 "전체" 값 없음 */
    if(gb=="1"){
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "Y", pumbunCd);             //점별 브랜드
    }else{
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "N", pumbunCd);             //점별 브랜드
    }
    
    initDateText('TODAY', 'sDate');    //시작일
    document.getElementById("strcd").value = '<%=strcd%>';  
    
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
 function getPumbunCombo(strcd, vencd, target, YN, pumbunCd){
     var param = "";
    
     param = "&goTo=getPumbunCombo&strcd=" + strcd
              + "&vencd=" + vencd
              + "&pumbunCd=" + pumbunCd
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
           emp_opt.setAttribute("value", "9999999999999");
           var emp_text = document.createTextNode("선택");//조회된 브랜드가 없으면 999999999 처리.
           emp_opt.appendChild(emp_text); 
           pumbun.appendChild(emp_opt);
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
    var strPumbuncd = document.getElementById("pubumCd").value;                 //브랜드코드
    var strSDate = getRawData(document.getElementById("sDate").value);          //일자
    var baseFlag = "";                                                          //구분
    
    for( i = 0; i < document.getElementsByName("baseFlag").length; i++ ){
        if( document.getElementsByName("baseFlag")[i].checked == true ){
        	baseFlag = document.getElementsByName("baseFlag")[i].value;
        }	
    }
    
    var toDay = getTodayFormat("YYYYMMDD");             //현재일 YYYYMMDD
    
    /* 일자 체크 */
    if( strSDate > toDay ){
    	showMessage(StopSign, OK, "USER-1009", "일자", "현재일");
    	document.getElementById("sDate").focus();
    	return;
    }
    
    var param = "&goTo=getMaster" + "&strStrcd=" + strStrcd
                                  + "&strVencd=" + strVencd
                                  + "&strPumbuncd=" + strPumbuncd
                                  + "&baseFlag=" + baseFlag
                                  + "&sDate=" + strSDate;
    
    <ajax:open callback="on_SearchXML" 
            param="param" 
            method="POST" 
            urlvalue="/edi/esal105.es"/>
    
    <ajax:callback function="on_SearchXML">
        
        var content = "<table width='940' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
        if( rowsNode.length > 0 ){
        	
        	var baseQtySum = 0;
        	var buyQtySum = 0;
        	var frdQtySum = 0;
        	var saleQtySum = 0;
        	var totCountSum = 0;
        	
	        for( i = 0; i < rowsNode.length; i++){
	        	var strcd = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                var strnm = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                var pumbuncd = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
                var pumbunNm = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                var pummokcd = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
                var pummokNm = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
                var eventFlag = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
                var eventRate = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
                var baseQty = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
                var buyQty = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
                var rfdQty = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
                var saleQty = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
                var totCount = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
                
                baseQtySum += Number(baseQty);
                buyQtySum += Number(buyQty);
                frdQtySum += Number(rfdQty);
                saleQtySum += Number(saleQty);
                totCountSum += Number(totCount);
                
                content += "<tr onclick='chBak("+i+");'>";
                content += "<td width='25' class='r1' id='1tdId"+i+"'>"+(i+1)+"</td>";
                content += "<td width='85' class='r3' id='2tdId"+i+"'>"+strnm+"</td>";
                content += "<td width='95' class='r3' id='3tdId"+i+"'>"+pumbunNm+"</td>";
                content += "<td width='95' class='r3' id='4tdId"+i+"'>"+pummokNm+"</td>";
                content += "<td width='55' class='r4' id='5tdId"+i+"'>"+eventFlag+"</td>";
                content += "<td width='55' class='r4' id='6tdId"+i+"'>"+eventRate+"</td>";
                content += "<td width='95' class='r4' id='7tdId"+i+"'>"+convAmt(baseQty)+"</td>";
                content += "<td width='95' class='r4' id='8tdId"+i+"'>"+convAmt(buyQty)+"</td>";
                content += "<td width='95' class='r4' id='9tdId"+i+"'>"+convAmt(rfdQty)+"</td>";
                content += "<td width='95' class='r4' id='10tdId"+i+"'>"+convAmt(saleQty)+"</td>";
                content += "<td width='95' class='r4' id='11tdId"+i+"'>"+convAmt(totCount)+"</td>";
                content += "</tr>";
	        }    
	        content += "<tr>";
	        content += "<td class='sum1'>&nbsp;</td>";
	        content += "<td class='sum1' colspan='5'>합계</td>";
	        content += "<td class='sum2'>"+convAmt(String(baseQtySum))+"</td>";
	        content += "<td class='sum2'>"+convAmt(String(buyQtySum))+"</td>";
	        content += "<td class='sum2'>"+convAmt(String(frdQtySum))+"</td>";
	        content += "<td class='sum2'>"+convAmt(String(saleQtySum))+"</td>";
	        content += "<td class='sum2'>"+convAmt(String(totCountSum))+"</td>";
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
        for(i=1;i<12;i++) {
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
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>재고현황조회</td>
        <td><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onClick="javascript:btn_Sch();"/></td>
            <td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow" onClick="addRow();" /></td>
            <td><img src="<%=dir%>/imgs/btn/del.gif" width="50" height="22" id="del" /></td>
            <td><img src="<%=dir%>/imgs/btn/save.gif" width="50" height="22" id="save" /></td>
			<td><img src="<%=dir%>/imgs/btn/excel.gif" width="61" height="22" id="excel" onclick="javascript: if(!chBakClr(11)){ excelExport('재고현황조회','TBL',pumbunCd);}"/></td>
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
            <th width="80">브랜드코드</th>
            <td>
                <select name="pubumCd" id="pubumCd" style="width: 193;">
                
                </select>
            </td>
          </tr>
          <tr>
            <th >일자</th>
            <td>
                <input type="text" name="sDate" id="sDate" size="16"  title="YYYY/MM/DD"  maxlength="8" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);"  style='text-align:center;IME-MODE: disabled'/>
                <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onclick="openCal('G',sDate);return false;" />
            </td>
           <th>구분</th>
           <td colspan=3">
               <input type="radio" name="baseFlag" id="baseFlag" value="1"  checked="checked" />수량
               <input type="radio" name="baseFlag" id="baseFlag" value="2" />원가
               <input type="radio" name="baseFlag" id="baseFlag" value="3" />매가
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
	    <div id="TBL">
	    <table width="100%"  border="0" cellspacing="0" cellpadding="0" class="BD4A">
	      <tr valign="top">
	        <td><div id="topTitle" style="width:815px;overflow:hidden;">
	                <table width="960" cellpadding="0" cellspacing="0" border="0" class="g_table" >
	                    <tr>
	                        <th width="25">NO</th>
	                        <th width="85">점</th>
	                        <th width="95">브랜드</th>
	                        <th width="95">품목</th>
	                        <th width="55">행사구분</th>
	                        <th width="55">행사율</th>
	                        <th width="95">기초재고</th>
	                        <th width="95">매입</th>
	                        <th width="95">반품</th>
	                        <th width="95">매출</th>
	                        <th width="95">현재고</th>
	                        <th width="15">&nbsp;</th>
	                    </tr>
	                </table>
	            </div>        
	        </td>
	      </tr>
	      <tr>
	          <td ><div id="DIV_Content" style="width:815px;height:460px;overflow:scroll" onscroll="scrollAll();">
	                  <table width="940" cellspacing="0" cellpadding="0" border="0" class="g_table">
	                  </table>  
	              </div>
	          </td>  
	      </tr>
	    </table>
	    </div>
    </td>
  </tr>
</table>

</body>
</html>

