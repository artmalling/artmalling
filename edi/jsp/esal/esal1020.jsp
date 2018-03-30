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
    String userid            = sessionInfo.getUSER_ID();        //사용자아이디
    String strcd             = sessionInfo.getSTR_CD();         //점코드
    String strNm             = sessionInfo.getSTR_NM();         //점명
    String gb                = sessionInfo.getGB();             //1. 협력사     2.브랜드
    String vencd             = sessionInfo.getVEN_CD();         //협력사코드
    String venNm             = sessionInfo.getVEN_NAME();       //협력사명
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
var userid      = '<%=userid%>';
var gb          = '<%=gb%>';
var vencd       = '<%=vencd%>';
var venNm       = '<%=venNm%>';
var g_strcd     = '<%=strcd%>';
var pumbunCd    = '<%=pumbunCd%>';
var g_pre_row   = -1;
var g_last_row  = -1;

var Rollno      = "";

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 
function doinit(){
    /*  버튼비활성화  */
    enableControl(newrow,false);   //신규    
    enableControl(del,false);      //삭제
    enableControl(save,false);     //저장
    enableControl(excel,true);    //엑셀
    enableControl(prints,false);    //프린터
    enableControl(set,false);    //프린터
    
    /*  조회부 */
    /* 구분 값이 브랜드로 로그인시 "전체" 값 없음 */
    if(gb=="1"){
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "Y", pumbunCd);             //점별 브랜드
    }else{
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "N", pumbunCd);             //점별 브랜드
    }
    
    
    getTodayDb();                                   //현재일의 시간분초
    
    document.getElementById("strcd").value = '<%=strcd%>';  
    
}
/**
 * getTodayDb()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 : 현재일의 시간분초
 * return값 : void
 */     
function getTodayDb(){
	var param = "&goTo=getTodayTimeDB";
	
	<ajax:open callback="on_TodayTimeDb" 
		          param="param" 
		         method="POST" 
		       urlvalue="/edi/ccom001.cc"/>
	
	<ajax:callback function="on_TodayTimeDb">
	   document.getElementById("toDayTime").innerHTML = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
	</ajax:callback>
	
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
function getPumbunCombo(strcd, vencd, target, YN, pumbunCd  ){
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
	g_pre_row = -1;
	var strStrcd = document.getElementById("strcd").value;
    var strVencd = document.getElementById("vencd").value;
    var strPumbuncd = document.getElementById("pubumCd").value;
    
    var param = "&goTo=getMaster" + "&strStrcd=" + strStrcd
                                  + "&strVencd=" + strVencd
                                  + "&strPumbuncd=" + strPumbuncd;
    
    
    <ajax:open callback="on_SearchXML" 
	        param="param" 
	        method="POST" 
	        urlvalue="/edi/esal102.es"/>
    
    <ajax:callback function="on_SearchXML">
        getTodayDb(); 
        var content = "";
            content += "<table width='940' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
        if( rowsNode.length > 0 ){ 
        	for( i = 0; i < rowsNode.length; i++ ){ 
        		var strcd         = rowsNode[i].childNodes[0].childNodes[0].nodeValue   == "null" ? "" :  rowsNode[i].childNodes[0].childNodes[0].nodeValue;
        		var strNm         = rowsNode[i].childNodes[1].childNodes[0].nodeValue   == "null" ? "" :  rowsNode[i].childNodes[1].childNodes[0].nodeValue;
        		var pumbuncd      = rowsNode[i].childNodes[2].childNodes[0].nodeValue   == "null" ? "" :  rowsNode[i].childNodes[2].childNodes[0].nodeValue;
        		var pumbunNM      = rowsNode[i].childNodes[3].childNodes[0].nodeValue   == "null" ? "" :  rowsNode[i].childNodes[3].childNodes[0].nodeValue;
        		var Event_gbn     = rowsNode[i].childNodes[4].childNodes[0].nodeValue   == "null" ? "" :  rowsNode[i].childNodes[4].childNodes[0].nodeValue;
        		var Event_yul     = rowsNode[i].childNodes[5].childNodes[0].nodeValue   == "null" ? "" :  rowsNode[i].childNodes[5].childNodes[0].nodeValue;
        		var cust_cnt      = rowsNode[i].childNodes[6].childNodes[0].nodeValue   == "null" ? "" :  rowsNode[i].childNodes[6].childNodes[0].nodeValue;
                var sale_Qty      = rowsNode[i].childNodes[7].childNodes[0].nodeValue   == "null" ? "" :  rowsNode[i].childNodes[7].childNodes[0].nodeValue;
                var saleAmt       = rowsNode[i].childNodes[8].childNodes[0].nodeValue   == "null" ? "0" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
                var dcAmt         = rowsNode[i].childNodes[9].childNodes[0].nodeValue  == "null" ? "" :  rowsNode[i].childNodes[9].childNodes[0].nodeValue;
                var net_sale_amt  = rowsNode[i].childNodes[10].childNodes[0].nodeValue  == "null" ? "" :  rowsNode[i].childNodes[10].childNodes[0].nodeValue;
                var redu_amt      = rowsNode[i].childNodes[11].childNodes[0].nodeValue   == "null" ? "" :  rowsNode[i].childNodes[11].childNodes[0].nodeValue;
        		var totSaleAmt    = rowsNode[i].childNodes[12].childNodes[0].nodeValue  == "null" ? "0" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
        		var Rollno        = rowsNode[i].childNodes[13].childNodes[0].nodeValue  == "null" ? "" :  rowsNode[i].childNodes[13].childNodes[0].nodeValue;
                  
        		if (Rollno == "0") {
        			content += "<tr onclick='chBak("+i+");' style='cursor:hand;'>";
                    content += "<input type='hidden' name='Rollno' id='Rollno"+i+"' value='"+Rollno+"' />"; 
	                content += "<td width='35' class='r1' id='1tdId"+i+"'>"+(i+1)                  +"</td>";
	                content += "<td width='95' class='r1 msoTxt' id='2tdId"+i+"'>"+strNm                  +"</td>";
	                content += "<td width='95' class='r1 msoTxt' id='3tdId"+i+"'>"+pumbunNM               +"</td>";
	                content += "<td width='95' class='r1 msoTxt' id='4tdId"+i+"'>"+Event_gbn              +"</td>";
	                content += "<td width='50' class='r1 msoTxt' id='5tdId"+i+"'>"+Event_yul              +"</td>";
	                content += "<td width='68' class='r1 msoAmt' id='6tdId"+i+"'>"+convAmt(cust_cnt)      +"</td>";
	                content += "<td width='96' class='r1 msoAmt' id='7tdId"+i+"'>"+convAmt(sale_Qty)      +"</td>";
	                content += "<td width='96' class='r1 msoAmt' id='8tdId"+i+"'>"+convAmt(saleAmt)       +"</td>";
	                content += "<td width='97' class='r1 msoAmt' id='9tdId"+i+"'>"+convAmt(dcAmt)        +"</td>";
	                content += "<td width='97' class='r1 msoAmt' id='10tdId"+i+"'>"+convAmt(net_sale_amt) +"</td>";
	                content += "<td width='70' class='r1 msoAmt' id='11tdId"+i+"'>"+convAmt(redu_amt)      +"</td>";	                
	                content += "<td width='96' class='r1 msoAmt' id='12tdId"+i+"'>"+convAmt(totSaleAmt)   +"</td>";
	                content += "</tr>"; 
        		}else if (Rollno == "1") {
                    content += "<tr onclick='chBak("+i+");' style='cursor:hand;'>";
                    content += "<input type='hidden' name='Rollno' id='Rollno"+i+"' value='"+Rollno+"' />"; 
                    content += "<td width='35' class='r1' style='background-Color: #EAFDCB' id='1tdId"+i+"'>"+(i+1)                 +"</td>";
                    content += "<td width='95' class='r1 msoTxt' style='background-Color: #EAFDCB' id='2tdId"+i+"'>"+strNm                 +"</td>";
                    content += "<td width='95' class='r1 msoTxt' style='background-Color: #EAFDCB' id='3tdId"+i+"'>"+pumbunNM              +"</td>";
                    content += "<td width='95' class='r1 msoTxt' style='background-Color: #EAFDCB' id='4tdId"+i+"'>"+Event_gbn             +"</td>";
                    content += "<td width='50' class='r1 msoTxt' style='background-Color: #EAFDCB' id='5tdId"+i+"'>"+Event_yul             +"</td>";
                    content += "<td width='68' class='r1 msoAmt' style='background-Color: #EAFDCB' id='6tdId"+i+"'>"+convAmt(cust_cnt)     +"</td>";
                    content += "<td width='96' class='r1 msoAmt' style='background-Color: #EAFDCB' id='7tdId"+i+"'>"+convAmt(sale_Qty)     +"</td>";
                    content += "<td width='96' class='r1 msoAmt' style='background-Color: #EAFDCB' id='8tdId"+i+"'>"+convAmt(saleAmt)      +"</td>";
                    content += "<td width='97' class='r1 msoAmt' style='background-Color: #EAFDCB' id='9tdId"+i+"'>"+convAmt(dcAmt)       +"</td>";
                    content += "<td width='97' class='r1 msoAmt' style='background-Color: #EAFDCB' id='10tdId"+i+"'>"+convAmt(net_sale_amt)+"</td>";
                    content += "<td width='70' class='r1 msoAmt' style='background-Color: #EAFDCB' id='11tdId"+i+"'>"+convAmt(redu_amt)     +"</td>";                    
                    content += "<td width='96' class='r1 msoAmt' style='background-Color: #EAFDCB' id='12tdId"+i+"'>"+convAmt(totSaleAmt)  +"</td>";
                    content += "</tr>"; 
        			
        		}else if (Rollno == "3") {
                    content += "<tr onclick='chBak("+i+");' style='cursor:hand;'>";
                    content += "<input type='hidden' name='Rollno' id='Rollno"+i+"' value='"+Rollno+"' />"; 
                    content += "<td width='35' class='r1' style='background-Color: #DFFDAF' id='1tdId"+i +"'>"+(i+1)                +"</td>";
                    content += "<td width='95' class='r1 msoTxt' style='background-Color: #DFFDAF' id='2tdId"+i +"'>"+strNm                +"</td>";
                    content += "<td width='95' class='r1 msoTxt' style='background-Color: #DFFDAF' id='3tdId"+i +"'>"+pumbunNM             +"</td>";
                    content += "<td width='95' class='r1 msoTxt' style='background-Color: #DFFDAF' id='4tdId"+i +"'>"+Event_gbn            +"</td>";
                    content += "<td width='50' class='r1 msoTxt' style='background-Color: #DFFDAF' id='5tdId"+i +"'>"+Event_yul            +"</td>";
                    content += "<td width='68' class='r1 msoAmt' style='background-Color: #DFFDAF' id='6tdId"+i +"'>"+convAmt(cust_cnt)    +"</td>";
                    content += "<td width='96' class='r1 msoAmt' style='background-Color: #DFFDAF' id='7tdId"+i +"'>"+convAmt(sale_Qty)    +"</td>";
                    content += "<td width='96' class='r1 msoAmt' style='background-Color: #DFFDAF' id='8tdId"+i +"'>"+convAmt(saleAmt)     +"</td>";
                    content += "<td width='97' class='r1 msoAmt' style='background-Color: #DFFDAF' id='9tdId"+i+"'>"+convAmt(dcAmt)       +"</td>";
                    content += "<td width='97' class='r1 msoAmt' style='background-Color: #DFFDAF' id='10tdId"+i+"'>"+convAmt(net_sale_amt)+"</td>";
                    content += "<td width='70' class='r1 msoAmt' style='background-Color: #DFFDAF' id='11tdId"+i +"'>"+convAmt(redu_amt)    +"</td>";
                    content += "<td width='96' class='r1 msoAmt' style='background-Color: #DFFDAF' id='12tdId"+i+"'>"+convAmt(totSaleAmt)  +"</td>";
                    content += "</tr>"; 
        			
        		}else if (Rollno == "7") {
                    content += "<tr onclick='chBak("+i+");' style='cursor:hand;'>";
                    content += "<input type='hidden' name='Rollno' id='Rollno"+i+"' value='"+Rollno+"' />"; 
                    content += "<td width='35' class='r1' style='background-Color: #CEF392' id='1tdId"+i +"'>"+(i+1)                +"</td>";
                    content += "<td width='95' class='r1 msoTxt' style='background-Color: #CEF392' id='2tdId"+i +"'>"+strNm                +"</td>";
                    content += "<td width='95' class='r1 msoTxt' style='background-Color: #CEF392' id='3tdId"+i +"'>"+pumbunNM             +"</td>";
                    content += "<td width='95' class='r1 msoTxt' style='background-Color: #CEF392' id='4tdId"+i +"'>"+Event_gbn            +"</td>";
                    content += "<td width='50' class='r1 msoTxt' style='background-Color: #CEF392' id='5tdId"+i +"'>"+Event_yul            +"</td>";
                    content += "<td width='68' class='r1 msoAmt' style='background-Color: #CEF392' id='6tdId"+i +"'>"+convAmt(cust_cnt)    +"</td>";
                    content += "<td width='96' class='r1 msoAmt' style='background-Color: #CEF392' id='7tdId"+i +"'>"+convAmt(sale_Qty)    +"</td>";
                    content += "<td width='96' class='r1 msoAmt' style='background-Color: #CEF392' id='8tdId"+i +"'>"+convAmt(saleAmt)     +"</td>";
                    content += "<td width='97' class='r1 msoAmt' style='background-Color: #CEF392' id='9tdId"+i+"'>"+convAmt(dcAmt)       +"</td>";
                    content += "<td width='97' class='r1 msoAmt' style='background-Color: #CEF392' id='10tdId"+i+"'>"+convAmt(net_sale_amt)+"</td>";
                    content += "<td width='70' class='r1 msoAmt' style='background-Color: #CEF392' id='11tdId"+i +"'>"+convAmt(redu_amt)    +"</td>";                    
                    content += "<td width='96' class='r1 msoAmt' style='background-Color: #CEF392' id='12tdId"+i+"'>"+convAmt(totSaleAmt)  +"</td>";
                    content += "</tr>"; 
        			
        		}else if (Rollno == "15") {
                    content += "<tr onclick='chBak("+i+");' style='cursor:hand;'>";
                    content += "<input type='hidden' name='Rollno' id='Rollno"+i+"' value='"+Rollno+"' />"; 
                    content += "<td width='35' class='r1' style='background-Color: #B1D17E' id='1tdId"+i +"'>"+(i+1)                +"</td>";
                    content += "<td width='95' class='r1 msoTxt' style='background-Color: #B1D17E' id='2tdId"+i +"'>"+strNm                +"</td>";
                    content += "<td width='95' class='r1 msoTxt' style='background-Color: #B1D17E' id='3tdId"+i +"'>"+pumbunNM             +"</td>";
                    content += "<td width='95' class='r1 msoTxt' style='background-Color: #B1D17E' id='4tdId"+i +"'>"+Event_gbn            +"</td>";
                    content += "<td width='50' class='r1 msoTxt' style='background-Color: #B1D17E' id='5tdId"+i +"'>"+Event_yul            +"</td>";
                    content += "<td width='68' class='r1 msoAmt' style='background-Color: #B1D17E' id='6tdId"+i +"'>"+convAmt(cust_cnt)    +"</td>";
                    content += "<td width='96' class='r1 msoAmt' style='background-Color: #B1D17E' id='7tdId"+i +"'>"+convAmt(sale_Qty)    +"</td>";
                    content += "<td width='96' class='r1 msoAmt' style='background-Color: #B1D17E' id='8tdId"+i +"'>"+convAmt(saleAmt)     +"</td>";
                    content += "<td width='97' class='r1 msoAmt' style='background-Color: #B1D17E' id='9tdId"+i+"'>"+convAmt(dcAmt)       +"</td>";
                    content += "<td width='97' class='r1 msoAmt' style='background-Color: #B1D17E' id='10tdId"+i+"'>"+convAmt(net_sale_amt)+"</td>";
                    content += "<td width='70' class='r1 msoAmt' style='background-Color: #B1D17E' id='11tdId"+i +"'>"+convAmt(redu_amt)    +"</td>";
                    content += "<td width='96' class='r1 msoAmt' style='background-Color: #B1D17E' id='12tdId"+i+"'>"+convAmt(totSaleAmt)  +"</td>";
                    content += "</tr>"; 
        			
        		} 
        	}  
        }
        content += "</table>";
        document.getElementById("DIV_Content").innerHTML = content;
        setPorcCount("SELECT", rowsNode.length);  
    </ajax:callback>
    
    
    
    
}

function chBak(val) {
    g_last_row = val; 
    if (g_pre_row != g_last_row){
        for(i=1;i<=12;i++) {
            document.getElementById(i+"tdId"+val).style.backgroundColor="#fff56E";
            if (g_pre_row != -1) {  
                if (document.getElementById("Rollno"+g_pre_row).value == "0") 
                {
                    document.getElementById(i+"tdId"+g_pre_row).style.backgroundColor="#FFFFFF";
                
                } else if (document.getElementById("Rollno"+g_pre_row).value == "1") 
                {
                    document.getElementById(i+"tdId"+g_pre_row).style.backgroundColor="#EAFDCB"; 
                
                } else if (document.getElementById("Rollno"+g_pre_row).value == "3") 
                {
                    document.getElementById(i+"tdId"+g_pre_row).style.backgroundColor="#DFFDAF";  
                
                }else if (document.getElementById("Rollno"+g_pre_row).value == "7") 
                {
                    document.getElementById(i+"tdId"+g_pre_row).style.backgroundColor="#CEF392";   
                
                }else if (document.getElementById("Rollno"+g_pre_row).value == "15") 
                {
                    document.getElementById(i+"tdId"+g_pre_row).style.backgroundColor="#B1D17E";  
                } 
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
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>당일매출속보</td>
        <td><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onClick="javascript:btn_Sch();"/></td>
            <td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow" onClick="addRow();" /></td>
            <td><img src="<%=dir%>/imgs/btn/del.gif" width="50" height="22" id="del" /></td>
            <td><img src="<%=dir%>/imgs/btn/save.gif" width="50" height="22" id="save" /></td>
			<td><img src="<%=dir%>/imgs/btn/excel.gif" width="61" height="22" id="excel" onclick="javascript:excelExport('당일매출속보','TBL',pumbunCd);"/></td>
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
            <td width="120"><input type="text"  name="strnm" id="strnm" size="17" maxlength="10" value="<%=strNm%>" disabled="disabled" /><input type="hidden" name="strcd" id="strcd"  ></td>
            <th width="80" class="POINT">협력사코드</th>
            <td width="160">
                <input type="hidden" name="vencd" id="vencd" value="<%=vencd%>" disabled="disabled"  />
                <input type="text" name="venNM" id="venNM" size="24" value="<%=venNm %>" disabled="disabled" />
            </td>
            <th width="80">브랜드코드</th>
            <td>
                <select name="pubumCd" id="pubumCd" style="width: 193;">
                
                </select>
            </td>
          </tr>
          <tr>
            <th >현재시간</th>
            <td colspan="5" id="toDayTime" style="font-weight: bold;"  >
                
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
   <!--   <td align="right""><img src="<%=dir%>/imgs/btn/q_a_regi.gif" title="Q&A저장" onclick="javascript:btn_create();" /></td> -->
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
                        <th width="33">NO</th>
                        <th width="93">점</th>
                        <th width="93">브랜드</th>
                        <th width="93">행사구분</th>
                        <th width="50">행사율</th>
                        <th width="65">객수</th> 
                        <th width="93">매출건수</th>
                        <th width="96">매출</th>
                        <th width="90">에누리</th>
                        <th width="97">순매출</th>
                        <th width="67">할인</th>
                        <th width="96">총매출</th>
                        <th width="15">&nbsp;</th>
                    </tr>
                </table>
            </div>        
        </td>
      </tr>
      <tr>
          <td ><div id="DIV_Content" style="width:815px;height:458px;overflow:scroll" onscroll="scrollAll();" >
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

