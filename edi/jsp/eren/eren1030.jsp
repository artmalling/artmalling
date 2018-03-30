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
    String pumbuncd = sessionInfo.getPUMBUN_CD();
    String pumbunNm = sessionInfo.getPUMBUN_NAME();
    
 
%>
<html>
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링</title>
<link href="<%=dir%>/css/ds.css" rel="stylesheet" type="text/css" />
<script language="javascript"  src="<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/popup.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/message.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script type="text/javascript">
var userid = '<%=userid%>';
var vencd = '<%=vencd%>';
var venNm = '<%=venNm%>';
var g_strcd = '<%=strcd%>';
var g_pre_row = -1;
var g_last_row = -1;
var g_pre_row2 = -1;
var g_last_row2 = -1;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 
function doinit(){
    
    var pumbuncd = "";
     
    /*  버튼비활성화  */
    enableControl(newrow,true);   //신규
    enableControl(newrow,false);   //신규    
    enableControl(del,false);      //삭제
    enableControl(save,false);     //저장
    enableControl(excel,false);    //엑셀
    enableControl(prints,false);    //프린터
    enableControl(set,false);    //프린터
    
    
    /*  조회 항목  */
  initDateText('SYYYYMMDD', 'em_S_Date');        //시작일
  initDateText("TODAY", "em_E_Date");        //종료일
  getSelectCombo("D", "M039", "gaug_type", "1");          //전표구분
  document.getElementById("strcd").value = '<%=strcd%>';   
}

/**
 * getPumbunCombo()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  점별브랜드콤보
 * return값 : void
 */ 
function getPumbunCombo(strcd, vencd, gb, pumbuncd){
     var param = "";
    if( gb == "2" ){       //로그인 시 브랜드
        
        param = "&goTo=getPumbunCombo&strcd=" + strcd
              + "&vencd=" + vencd
              + "&gb=" + gb
              + "&pumbuncd=" + pumbuncd;
    
    }else if( gb == "1" ){
        param = "&goTo=getPumbunCombo&strcd=" + strcd
              + "&vencd=" + vencd
              + "&gb=" + gb;
    }
    
    <ajax:open callback="on_loadedXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/ccom001.cc"/>
    
    <ajax:callback function="on_loadedXML">
       
       var pumbun = document.getElementById("pubumCd");
        
       
       if( rowsNode.length == 1){
           var opt = document.createElement("option");  
           opt.setAttribute("value", rowsNode[0].childNodes[0].childNodes[0].nodeValue);
           
           var text = document.createTextNode(rowsNode[0].childNodes[1].childNodes[0].nodeValue);
           opt.appendChild(text);            
           pumbun.appendChild(opt);
       }else if( rowsNode.length > 1){
           var emp_opt = document.createElement("option");
           emp_opt.setAttribute("value", "%");
           var emp_text = document.createTextNode("전체");
           emp_opt.appendChild(emp_text); 
           pumbun.appendChild(emp_opt)
           for( i =0; i < rowsNode.length; i++){
               var opt = document.createElement("option");  
               opt.setAttribute("value", rowsNode[i].childNodes[0].childNodes[0].nodeValue);
               
               var text = document.createTextNode(rowsNode[i].childNodes[1].childNodes[0].nodeValue);
               opt.appendChild(text); 
               pumbun.appendChild(opt);
           }
       }else if( rowsNode.length < 1){
           var opt = document.createElement("option");
           var emp_text = document.createTextNode("전체");
           opt.setAttribute("value", "%");           
           opt.appendChild(emp_text); 
           pumbun.appendChild(opt);
       }
       
       
    </ajax:callback>
}

/**
 * getSelectCombo()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  조회부 공통 부문
 * return값 : void
 */ 
function getSelectCombo(syspat,compart, target, gb){
    
    var param = "&goTo=getEtcCode&syspat="+syspat+"&compart="+compart;
    <ajax:open callback="on_SelectComboXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/ccom001.cc"/>
    
    
    <ajax:callback function="on_SelectComboXML"> 
    
    var sel_box = document.getElementById(target);
    if( rowsNode.length > 0){
        if( gb == "1" ){
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
 * 개    요 :  마스터 조회
 * return값 : void
 */ 
function btn_Sch(){
	var sDate = document.getElementById("em_S_Date").value;
    var eDate = document.getElementById("em_E_Date").value;

    if( sDate.length == 0 ){
        showMessage(EXCLAMATION , OK, "USER-1001", "기간");
        document.getElementById("em_S_Date").focus();
        return;
    }
    
    if( eDate.length == 0 ){
        showMessage(EXCLAMATION , OK, "USER-1001", "기간");
        document.getElementById("em_E_Date").focus();
        return;
    }
    
    var em_sdate = getRawData(trim(sDate));
    var em_edate = getRawData(trim(eDate));   
    
    if (em_sdate > em_edate) { //시작일은 종료일보다 커야 합니다.
        showMessage(EXCLAMATION , OK, "USER-1009", "종료일","시작일");
        document.getElementById("em_S_Date").focus();
        return;
    }
    
    getSearch();
}
/**
 * getSearch()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  마스터 조회
 * return값 : void
 */ 
function getSearch(){
	var strStrcd = document.getElementById("strcd").value;
    var strVencd = document.getElementById("vencd").value;
    var strGaugType = document.getElementById("gaug_type").value;
    var sDate = getRawData(trim(document.getElementById("em_S_Date").value));
    var eDate = getRawData(trim(document.getElementById("em_E_Date").value));
    
    var de_content = "<table width='798' border='0' cellspacing='0' cellpadding='0' class='g_table'></table>";
    document.getElementById("DETAIL_CONTETN").innerHTML = de_content;
    var param = "&goTo=getMaster&strStrcd="+ strStrcd
										   + "&strVencd=" + strVencd 
										   + "&strGaugType=" + strGaugType
										   + "&sDate=" + sDate
										   + "&eDate=" + eDate;    
    
    <ajax:open callback="on_SearchXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/eren103.er"/>

    <ajax:callback function="on_SearchXML">
       var Master_content = "";
       if( rowsNode.length > 0 ){
    	   var sum_time_00 = 0;
    	   var sum_time_01 = 0;
    	   var sum_time_02 = 0;
    	   var sum_time_03 = 0;
    	   var sum_time_04 = 0;
    	   var sum_time_05 = 0;
    	   var sum_time_06 = 0;
    	   var sum_time_07 = 0;
    	   var sum_time_08 = 0;
    	   var sum_time_09 = 0;
    	   var sum_time_10 = 0;
    	   var sum_time_11 = 0;
    	   var sum_time_12 = 0;
    	   var sum_time_13 = 0;
    	   var sum_time_14 = 0;
    	   var sum_time_15 = 0;
    	   var sum_time_16 = 0;
    	   var sum_time_17 = 0;
    	   var sum_time_18 = 0;
    	   var sum_time_19 = 0;
    	   var sum_time_20 = 0;
    	   var sum_time_21 = 0;
    	   var sum_time_22 = 0;
    	   var sum_time_23 = 0;
    	   var sum_use_tot = 0;
    	   
    	   
    	   Master_content += "<table width='1995' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
    	   
    	   
    	   for( i =0; i < rowsNode.length; i++ ){
    		   var gaug_type = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
    		   var gaug_type_nm = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue; 
    		   var gaug_id = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
    		   var tot_use = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue; 
    		   var time_00 = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
    		   var time_01 = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
    		   var time_02 = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
    		   var time_03 = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
    		   var time_04 = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
    		   var time_05 = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
    		   var time_06 = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
    		   var time_07 = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
    		   var time_08 = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
    		   var time_09 = rowsNode[i].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[13].childNodes[0].nodeValue;
    		   var time_10 = rowsNode[i].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[14].childNodes[0].nodeValue;
    		   var time_11 = rowsNode[i].childNodes[15].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[15].childNodes[0].nodeValue;
    		   var time_12 = rowsNode[i].childNodes[16].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[16].childNodes[0].nodeValue;
    		   var time_13 = rowsNode[i].childNodes[17].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[17].childNodes[0].nodeValue;
    		   var time_14 = rowsNode[i].childNodes[18].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[18].childNodes[0].nodeValue;
    		   var time_15 = rowsNode[i].childNodes[19].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[19].childNodes[0].nodeValue;
    		   var time_16 = rowsNode[i].childNodes[20].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[20].childNodes[0].nodeValue;
    		   var time_17 = rowsNode[i].childNodes[21].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[21].childNodes[0].nodeValue;
    		   var time_18 = rowsNode[i].childNodes[22].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[22].childNodes[0].nodeValue;
    		   var time_19 = rowsNode[i].childNodes[23].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[23].childNodes[0].nodeValue;
    		   var time_20 = rowsNode[i].childNodes[24].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[24].childNodes[0].nodeValue;
    		   var time_21 = rowsNode[i].childNodes[25].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[25].childNodes[0].nodeValue;
    		   var time_22 = rowsNode[i].childNodes[26].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[26].childNodes[0].nodeValue;
    		   var time_23 = rowsNode[i].childNodes[27].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[27].childNodes[0].nodeValue;
    		   
    		   sum_time_00 += Number(time_00);
    		   sum_time_01 += Number(time_01);
    		   sum_time_02 += Number(time_02);
    		   sum_time_03 += Number(time_03);
    		   sum_time_04 += Number(time_04);
    		   sum_time_05 += Number(time_05); 
    		   sum_time_06 += Number(time_06); 
    		   sum_time_07 += Number(time_07); 
    		   sum_time_08 += Number(time_08); 
    		   sum_time_09 += Number(time_09); 
    		   sum_time_10 += Number(time_10); 
    		   sum_time_11 += Number(time_11); 
    		   sum_time_12 += Number(time_12); 
    		   sum_time_13 += Number(time_13); 
    		   sum_time_14 += Number(time_14); 
    		   sum_time_15 += Number(time_15); 
    		   sum_time_16 += Number(time_16); 
    		   sum_time_17 += Number(time_17); 
    		   sum_time_18 += Number(time_18); 
    		   sum_time_19 += Number(time_19); 
    		   sum_time_20 += Number(time_20); 
    		   sum_time_21 += Number(time_21); 
    		   sum_time_22 += Number(time_22); 
    		   sum_time_23 += Number(time_23); 
    		   sum_use_tot += Number(tot_use); 
    		   
    		   Master_content += "<tr onclick='chBak("+i+");getDetail("+i+");' style='cursor:hand;' >";
    		   Master_content += "<input type='hidden' name='h_gaug_type' id='h_gaug_type"+i+"' value='"+gaug_type+"' />";
    		   Master_content += "<input type='hidden' name='h_gaug_id' id='h_gaug_id"+i+"' value='"+gaug_id+"' />";
    		   Master_content += "<td width='25' id='1tdId"+i+"' class='r1'>"+(i+1)+"</td>";
    		   Master_content += "<td width='75' id='2tdId"+i+"' class='r3'>"+gaug_type_nm+"</td>";
    		   Master_content += "<td width='100' id='3tdId"+i+"' class='r1'>"+gaug_id+"</td>";
    		   Master_content += "<td width='95' id='4tdId"+i+"' class='r4'>"+convAmt(tot_use)+"</td>"; 
    		   Master_content += "<td width='65' id='5tdId"+i+"' class='r4'>"+convAmt(time_00)+"</td>";
    		   Master_content += "<td width='65' id='6tdId"+i+"' class='r4'>"+convAmt(time_01)+"</td>";
    		   Master_content += "<td width='65' id='7tdId"+i+"' class='r4'>"+convAmt(time_02)+"</td>";
    		   Master_content += "<td width='65' id='8tdId"+i+"' class='r4'>"+convAmt(time_03)+"</td>";
    		   Master_content += "<td width='65' id='9tdId"+i+"' class='r4'>"+convAmt(time_04)+"</td>";
    		   Master_content += "<td width='65' id='10tdId"+i+"' class='r4'>"+convAmt(time_05)+"</td>";
    		   Master_content += "<td width='65' id='11tdId"+i+"' class='r4'>"+convAmt(time_06)+"</td>";
    		   Master_content += "<td width='65' id='12tdId"+i+"' class='r4'>"+convAmt(time_07)+"</td>";
    		   Master_content += "<td width='65' id='13tdId"+i+"' class='r4'>"+convAmt(time_08)+"</td>";
    		   Master_content += "<td width='65' id='14tdId"+i+"' class='r4'>"+convAmt(time_09)+"</td>";
    		   Master_content += "<td width='65' id='15tdId"+i+"' class='r4'>"+convAmt(time_10)+"</td>";
    		   Master_content += "<td width='65' id='16tdId"+i+"' class='r4'>"+convAmt(time_11)+"</td>";
   	           Master_content += "<td width='65' id='17tdId"+i+"' class='r4'>"+convAmt(time_12)+"</td>";
               Master_content += "<td width='65' id='18tdId"+i+"' class='r4'>"+convAmt(time_13)+"</td>";
               Master_content += "<td width='65' id='19tdId"+i+"' class='r4'>"+convAmt(time_14)+"</td>";
               Master_content += "<td width='65' id='20tdId"+i+"' class='r4'>"+convAmt(time_15)+"</td>";
               Master_content += "<td width='65' id='21tdId"+i+"' class='r4'>"+convAmt(time_16)+"</td>";
               Master_content += "<td width='65' id='22tdId"+i+"' class='r4'>"+convAmt(time_17)+"</td>";
               Master_content += "<td width='65' id='23tdId"+i+"' class='r4'>"+convAmt(time_18)+"</td>";
               Master_content += "<td width='65' id='24tdId"+i+"' class='r4'>"+convAmt(time_19)+"</td>";
               Master_content += "<td width='65' id='25tdId"+i+"' class='r4'>"+convAmt(time_20)+"</td>";
               Master_content += "<td width='65' id='26tdId"+i+"' class='r4'>"+convAmt(time_21)+"</td>";
               Master_content += "<td width='65' id='27tdId"+i+"' class='r4'>"+convAmt(time_22)+"</td>";
               Master_content += "<td width='65' id='28tdId"+i+"' class='r4'>"+convAmt(time_23)+"</td>";
    		   Master_content += "</tr>";    
    		   
    	   }
    	   
    	   Master_content += "<tr>";
    	   Master_content += "<td colspan='3' class='sum1'>합계</td>";
    	   Master_content += "<td class='sum2' >"+convAmt(String(sum_use_tot))+"</td>";
    	   Master_content += "<td class='sum2' >"+convAmt(String(sum_time_00))+"</td>";
    	   Master_content += "<td class='sum2' >"+convAmt(String(sum_time_01))+"</td>";
    	   Master_content += "<td class='sum2' >"+convAmt(String(sum_time_02))+"</td>";
    	   Master_content += "<td class='sum2' >"+convAmt(String(sum_time_03))+"</td>";
    	   Master_content += "<td class='sum2' >"+convAmt(String(sum_time_04))+"</td>";
    	   Master_content += "<td class='sum2' >"+convAmt(String(sum_time_05))+"</td>";
    	   Master_content += "<td class='sum2' >"+convAmt(String(sum_time_06))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(sum_time_07))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(sum_time_08))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(sum_time_09))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(sum_time_10))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(sum_time_11))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(sum_time_12))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(sum_time_13))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(sum_time_14))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(sum_time_15))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(sum_time_16))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(sum_time_17))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(sum_time_18))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(sum_time_19))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(sum_time_20))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(sum_time_21))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(sum_time_22))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(sum_time_23))+"</td>";
    	   Master_content += "</tr>";
    		   
    	   Master_content += "</table>";
    	   
    	   // 2011.07.15 kjm 추가
           // 조회버튼 클릭시 하단그리드도 같이 조회
           chBak(0);
           getDetail2(0);
       } else {
    	   
       }
       document.getElementById("DIV_Content").innerHTML = Master_content;
       setPorcCount("SELECT", rowsNode.length); 
 
       
       
      
    </ajax:callback>
    
    
    
}

/**
 * getDetail()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  디테일 조회
 * return값 : void
 */ 
 
function getDetail( row ){
	var strStrcd = document.getElementById("strcd").value;
	var strVencd = document.getElementById("vencd").value;
	var sDate = getRawData(trim(document.getElementById("em_S_Date").value));
	var eDate = getRawData(trim(document.getElementById("em_E_Date").value));
	var gaug_id = document.getElementById("h_gaug_id"+row).value;      // 계량기 ID
	
	
	
	var param = "&goTo=getDetail&strStrcd="+ strStrcd
									    + "&strVencd=" + strVencd 
									    + "&gaug_id=" + gaug_id
									    + "&sDate=" + sDate
									    + "&eDate=" + eDate;  
	
	var de_content = "<table width='1895' border='0' cellspacing='0' cellpadding='0' class='g_table'></table>";
    document.getElementById("DETAIL_CONTETN").innerHTML = de_content;
    
	<ajax:open callback="on_DetailSearchXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/eren103.er"/>
        

    <ajax:callback function="on_DetailSearchXML">
        
        var d_content = "";
        if( rowsNode.length > 0 ){
            var sum_time_00 = 0;
            var sum_time_01 = 0;
            var sum_time_02 = 0;
            var sum_time_03 = 0;
            var sum_time_04 = 0;
            var sum_time_05 = 0;
            var sum_time_06 = 0;
            var sum_time_07 = 0;
            var sum_time_08 = 0;
            var sum_time_09 = 0;
            var sum_time_10 = 0;
            var sum_time_11 = 0;
            var sum_time_12 = 0;
            var sum_time_13 = 0;
            var sum_time_14 = 0;
            var sum_time_15 = 0;
            var sum_time_16 = 0;
            var sum_time_17 = 0;
            var sum_time_18 = 0;
            var sum_time_19 = 0;
            var sum_time_20 = 0;
            var sum_time_21 = 0;
            var sum_time_22 = 0;
            var sum_time_23 = 0;
            var sum_use_tot = 0;
        	
        	d_content += "<table width='1895' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
        	
        	for(i = 0; i < rowsNode.length; i++){
                var use_dt = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                var tot_use = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue; 
                var time_00 = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
                var time_01 = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                var time_02 = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
                var time_03 = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
                var time_04 = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
                var time_05 = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
                var time_06 = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
                var time_07 = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
                var time_08 = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
                var time_09 = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
                var time_10 = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
                var time_11 = rowsNode[i].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[13].childNodes[0].nodeValue;
                var time_12 = rowsNode[i].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[14].childNodes[0].nodeValue;
                var time_13 = rowsNode[i].childNodes[15].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[15].childNodes[0].nodeValue;
                var time_14 = rowsNode[i].childNodes[16].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[16].childNodes[0].nodeValue;
                var time_15 = rowsNode[i].childNodes[17].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[17].childNodes[0].nodeValue;
                var time_16 = rowsNode[i].childNodes[18].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[18].childNodes[0].nodeValue;
                var time_17 = rowsNode[i].childNodes[19].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[19].childNodes[0].nodeValue;
                var time_18 = rowsNode[i].childNodes[20].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[20].childNodes[0].nodeValue;
                var time_19 = rowsNode[i].childNodes[21].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[21].childNodes[0].nodeValue;
                var time_20 = rowsNode[i].childNodes[22].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[22].childNodes[0].nodeValue;
                var time_21 = rowsNode[i].childNodes[23].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[23].childNodes[0].nodeValue;
                var time_22 = rowsNode[i].childNodes[24].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[24].childNodes[0].nodeValue;
                var time_23 = rowsNode[i].childNodes[25].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[25].childNodes[0].nodeValue;
                
                sum_time_00 += Number(time_00);
                sum_time_01 += Number(time_01);
                sum_time_02 += Number(time_02);
                sum_time_03 += Number(time_03);
                sum_time_04 += Number(time_04);
                sum_time_05 += Number(time_05); 
                sum_time_06 += Number(time_06); 
                sum_time_07 += Number(time_07); 
                sum_time_08 += Number(time_08); 
                sum_time_09 += Number(time_09); 
                sum_time_10 += Number(time_10); 
                sum_time_11 += Number(time_11); 
                sum_time_12 += Number(time_12); 
                sum_time_13 += Number(time_13); 
                sum_time_14 += Number(time_14); 
                sum_time_15 += Number(time_15); 
                sum_time_16 += Number(time_16); 
                sum_time_17 += Number(time_17); 
                sum_time_18 += Number(time_18); 
                sum_time_19 += Number(time_19); 
                sum_time_20 += Number(time_20); 
                sum_time_21 += Number(time_21); 
                sum_time_22 += Number(time_22); 
                sum_time_23 += Number(time_23); 
                sum_use_tot += Number(tot_use); 
                
                
                d_content += "<tr  onclick='chBak2("+i+");' >";
                d_content += "<td class='r1' width='25' id='1tdId2"+i+"'>"+(i+1)+"</td>";
                d_content += "<td class='r1' width='80' id='2tdId2"+i+"'>"+getDateFormat(use_dt)+"</td>";
                d_content += "<td width='95' id='3tdId2"+i+"' class='r4'>"+convAmt(tot_use)+"</td>"; 
                d_content += "<td width='65' id='4tdId2"+i+"' class='r4'>"+convAmt(time_00)+"</td>";
                d_content += "<td width='65' id='5tdId2"+i+"' class='r4'>"+convAmt(time_01)+"</td>";
                d_content += "<td width='65' id='6tdId2"+i+"' class='r4'>"+convAmt(time_02)+"</td>";
                d_content += "<td width='65' id='7tdId2"+i+"' class='r4'>"+convAmt(time_03)+"</td>";
                d_content += "<td width='65' id='8tdId2"+i+"' class='r4'>"+convAmt(time_04)+"</td>";
                d_content += "<td width='65' id='9tdId2"+i+"' class='r4'>"+convAmt(time_05)+"</td>";
                d_content += "<td width='65' id='10tdId2"+i+"' class='r4'>"+convAmt(time_06)+"</td>";
                d_content += "<td width='65' id='11tdId2"+i+"' class='r4'>"+convAmt(time_07)+"</td>";
                d_content += "<td width='65' id='12tdId2"+i+"' class='r4'>"+convAmt(time_08)+"</td>";
                d_content += "<td width='65' id='13tdId2"+i+"' class='r4'>"+convAmt(time_09)+"</td>";
                d_content += "<td width='65' id='14tdId2"+i+"' class='r4'>"+convAmt(time_10)+"</td>";
                d_content += "<td width='65' id='15tdId2"+i+"' class='r4'>"+convAmt(time_11)+"</td>";
                d_content += "<td width='65' id='16tdId2"+i+"' class='r4'>"+convAmt(time_12)+"</td>";
                d_content += "<td width='65' id='17tdId2"+i+"' class='r4'>"+convAmt(time_13)+"</td>";
                d_content += "<td width='65' id='18tdId2"+i+"' class='r4'>"+convAmt(time_14)+"</td>";
                d_content += "<td width='65' id='19tdId2"+i+"' class='r4'>"+convAmt(time_15)+"</td>";
                d_content += "<td width='65' id='20tdId2"+i+"' class='r4'>"+convAmt(time_16)+"</td>";
                d_content += "<td width='65' id='21tdId2"+i+"' class='r4'>"+convAmt(time_17)+"</td>";
                d_content += "<td width='65' id='22tdId2"+i+"' class='r4'>"+convAmt(time_18)+"</td>";
                d_content += "<td width='65' id='23tdId2"+i+"' class='r4'>"+convAmt(time_19)+"</td>";
                d_content += "<td width='65' id='24tdId2"+i+"' class='r4'>"+convAmt(time_20)+"</td>";
                d_content += "<td width='65' id='25tdId2"+i+"' class='r4'>"+convAmt(time_21)+"</td>";
                d_content += "<td width='65' id='26tdId2"+i+"' class='r4'>"+convAmt(time_22)+"</td>";
                d_content += "<td width='65' id='27tdId2"+i+"' class='r4'>"+convAmt(time_23)+"</td>";
                d_content += "</tr>";
        	}
        	
        	d_content += "<tr>";
            d_content += "<td class='sum1' colspan=2> 합계</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_use_tot))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_00))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_01))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_02))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_03))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_04))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_05))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_06))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_07))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_08))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_09))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_10))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_11))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_12))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_13))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_14))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_15))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_16))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_17))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_18))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_19))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_20))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_21))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_22))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_23))+"</td>";
            d_content += "</tr>";
        }
        d_content += "</table>";
        document.getElementById("DETAIL_CONTETN").innerHTML = d_content;
        setPorcCount("SELECT", rowsNode.length);  
        
    </ajax:callback>
	
	
}

/**
 * getDetail()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  디테일 조회
 * return값 : void
 */ 
 
function getDetail2( row ){
    var strStrcd = document.getElementById("strcd").value;
    var strVencd = document.getElementById("vencd").value;
    var sDate = getRawData(trim(document.getElementById("em_S_Date").value));
    var eDate = getRawData(trim(document.getElementById("em_E_Date").value));
    var gaug_id = document.getElementById("h_gaug_id"+row).value;      // 계량기 ID
    
    
    
    var param = "&goTo=getDetail&strStrcd="+ strStrcd
                                        + "&strVencd=" + strVencd 
                                        + "&gaug_id=" + gaug_id
                                        + "&sDate=" + sDate
                                        + "&eDate=" + eDate;  
    
    var de_content = "<table width='1895' border='0' cellspacing='0' cellpadding='0' class='g_table'></table>";
    document.getElementById("DETAIL_CONTETN").innerHTML = de_content;
    
    <ajax:open callback="on_DetailSearchXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/eren103.er"/>
        

    <ajax:callback function="on_DetailSearchXML">
        
        var d_content = "";
        if( rowsNode.length > 0 ){
            var sum_time_00 = 0;
            var sum_time_01 = 0;
            var sum_time_02 = 0;
            var sum_time_03 = 0;
            var sum_time_04 = 0;
            var sum_time_05 = 0;
            var sum_time_06 = 0;
            var sum_time_07 = 0;
            var sum_time_08 = 0;
            var sum_time_09 = 0;
            var sum_time_10 = 0;
            var sum_time_11 = 0;
            var sum_time_12 = 0;
            var sum_time_13 = 0;
            var sum_time_14 = 0;
            var sum_time_15 = 0;
            var sum_time_16 = 0;
            var sum_time_17 = 0;
            var sum_time_18 = 0;
            var sum_time_19 = 0;
            var sum_time_20 = 0;
            var sum_time_21 = 0;
            var sum_time_22 = 0;
            var sum_time_23 = 0;
            var sum_use_tot = 0;
            
            d_content += "<table width='1895' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
            
            for(i = 0; i < rowsNode.length; i++){
                var use_dt = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                var tot_use = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue; 
                var time_00 = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
                var time_01 = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                var time_02 = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
                var time_03 = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
                var time_04 = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
                var time_05 = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
                var time_06 = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
                var time_07 = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
                var time_08 = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
                var time_09 = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
                var time_10 = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
                var time_11 = rowsNode[i].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[13].childNodes[0].nodeValue;
                var time_12 = rowsNode[i].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[14].childNodes[0].nodeValue;
                var time_13 = rowsNode[i].childNodes[15].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[15].childNodes[0].nodeValue;
                var time_14 = rowsNode[i].childNodes[16].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[16].childNodes[0].nodeValue;
                var time_15 = rowsNode[i].childNodes[17].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[17].childNodes[0].nodeValue;
                var time_16 = rowsNode[i].childNodes[18].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[18].childNodes[0].nodeValue;
                var time_17 = rowsNode[i].childNodes[19].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[19].childNodes[0].nodeValue;
                var time_18 = rowsNode[i].childNodes[20].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[20].childNodes[0].nodeValue;
                var time_19 = rowsNode[i].childNodes[21].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[21].childNodes[0].nodeValue;
                var time_20 = rowsNode[i].childNodes[22].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[22].childNodes[0].nodeValue;
                var time_21 = rowsNode[i].childNodes[23].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[23].childNodes[0].nodeValue;
                var time_22 = rowsNode[i].childNodes[24].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[24].childNodes[0].nodeValue;
                var time_23 = rowsNode[i].childNodes[25].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[25].childNodes[0].nodeValue;
                
                sum_time_00 += Number(time_00);
                sum_time_01 += Number(time_01);
                sum_time_02 += Number(time_02);
                sum_time_03 += Number(time_03);
                sum_time_04 += Number(time_04);
                sum_time_05 += Number(time_05); 
                sum_time_06 += Number(time_06); 
                sum_time_07 += Number(time_07); 
                sum_time_08 += Number(time_08); 
                sum_time_09 += Number(time_09); 
                sum_time_10 += Number(time_10); 
                sum_time_11 += Number(time_11); 
                sum_time_12 += Number(time_12); 
                sum_time_13 += Number(time_13); 
                sum_time_14 += Number(time_14); 
                sum_time_15 += Number(time_15); 
                sum_time_16 += Number(time_16); 
                sum_time_17 += Number(time_17); 
                sum_time_18 += Number(time_18); 
                sum_time_19 += Number(time_19); 
                sum_time_20 += Number(time_20); 
                sum_time_21 += Number(time_21); 
                sum_time_22 += Number(time_22); 
                sum_time_23 += Number(time_23); 
                sum_use_tot += Number(tot_use); 
                
                
                d_content += "<tr  onclick='chBak2("+i+");' >";
                d_content += "<td class='r1' width='25' id='1tdId2"+i+"'>"+(i+1)+"</td>";
                d_content += "<td class='r1' width='80' id='2tdId2"+i+"'>"+getDateFormat(use_dt)+"</td>";
                d_content += "<td width='95' id='3tdId2"+i+"' class='r4'>"+convAmt(tot_use)+"</td>"; 
                d_content += "<td width='65' id='4tdId2"+i+"' class='r4'>"+convAmt(time_00)+"</td>";
                d_content += "<td width='65' id='5tdId2"+i+"' class='r4'>"+convAmt(time_01)+"</td>";
                d_content += "<td width='65' id='6tdId2"+i+"' class='r4'>"+convAmt(time_02)+"</td>";
                d_content += "<td width='65' id='7tdId2"+i+"' class='r4'>"+convAmt(time_03)+"</td>";
                d_content += "<td width='65' id='8tdId2"+i+"' class='r4'>"+convAmt(time_04)+"</td>";
                d_content += "<td width='65' id='9tdId2"+i+"' class='r4'>"+convAmt(time_05)+"</td>";
                d_content += "<td width='65' id='10tdId2"+i+"' class='r4'>"+convAmt(time_06)+"</td>";
                d_content += "<td width='65' id='11tdId2"+i+"' class='r4'>"+convAmt(time_07)+"</td>";
                d_content += "<td width='65' id='12tdId2"+i+"' class='r4'>"+convAmt(time_08)+"</td>";
                d_content += "<td width='65' id='13tdId2"+i+"' class='r4'>"+convAmt(time_09)+"</td>";
                d_content += "<td width='65' id='14tdId2"+i+"' class='r4'>"+convAmt(time_10)+"</td>";
                d_content += "<td width='65' id='15tdId2"+i+"' class='r4'>"+convAmt(time_11)+"</td>";
                d_content += "<td width='65' id='16tdId2"+i+"' class='r4'>"+convAmt(time_12)+"</td>";
                d_content += "<td width='65' id='17tdId2"+i+"' class='r4'>"+convAmt(time_13)+"</td>";
                d_content += "<td width='65' id='18tdId2"+i+"' class='r4'>"+convAmt(time_14)+"</td>";
                d_content += "<td width='65' id='19tdId2"+i+"' class='r4'>"+convAmt(time_15)+"</td>";
                d_content += "<td width='65' id='20tdId2"+i+"' class='r4'>"+convAmt(time_16)+"</td>";
                d_content += "<td width='65' id='21tdId2"+i+"' class='r4'>"+convAmt(time_17)+"</td>";
                d_content += "<td width='65' id='22tdId2"+i+"' class='r4'>"+convAmt(time_18)+"</td>";
                d_content += "<td width='65' id='23tdId2"+i+"' class='r4'>"+convAmt(time_19)+"</td>";
                d_content += "<td width='65' id='24tdId2"+i+"' class='r4'>"+convAmt(time_20)+"</td>";
                d_content += "<td width='65' id='25tdId2"+i+"' class='r4'>"+convAmt(time_21)+"</td>";
                d_content += "<td width='65' id='26tdId2"+i+"' class='r4'>"+convAmt(time_22)+"</td>";
                d_content += "<td width='65' id='27tdId2"+i+"' class='r4'>"+convAmt(time_23)+"</td>";
                d_content += "</tr>";
            }
            
            d_content += "<tr>";
            d_content += "<td class='sum1' colspan=2> 합계</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_use_tot))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_00))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_01))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_02))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_03))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_04))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_05))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_06))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_07))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_08))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_09))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_10))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_11))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_12))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_13))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_14))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_15))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_16))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_17))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_18))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_19))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_20))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_21))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_22))+"</td>";
            d_content += "<td class='sum2'>"+convAmt(String(sum_time_23))+"</td>";
            d_content += "</tr>";
        }
        d_content += "</table>";
        document.getElementById("DETAIL_CONTETN").innerHTML = d_content;
   
    </ajax:callback>
    
    
}

/**
 * chBak()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  마스터 로우 선택시  색
 * return값 : void
 */ 
function chBak(val) { 
	  g_last_row = val;
	    if (g_pre_row != g_last_row){
	        for(i=1;i<28;i++) {
	            document.getElementById(i+"tdId"+val).style.backgroundColor="#fff56E";
	           
	            if (g_pre_row != -1) {
	                document.getElementById(i+"tdId"+g_pre_row).style.backgroundColor="#ffffff";
	            }
	        }
	    }
	    g_pre_row = g_last_row;
	  
}

/**
 * chBak2()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  디테일 로우 선택시  색
 * return값 : void
 */ 
function chBak2(val) {
    g_last_row2 = val;
    if ( g_pre_row2 != g_last_row2 ){
        for(i=1;i<28;i++) {
            document.getElementById(i+"tdId2" + val).style.backgroundColor="#fff56E";
            if (g_pre_row2 != -1) {
                document.getElementById(i+"tdId2"+g_pre_row2).style.backgroundColor="#ffffff";
            }
        }
    }
    
    g_pre_row2 = g_last_row2;
}

function scrollAll(){
	document.all.DIV_TITLE.scrollLeft = document.all.DIV_Content.scrollLeft;
}

function scrollAll2(){
	document.all.DETAIL_TITLE.scrollLeft = document.all.DETAIL_CONTETN.scrollLeft;
}


</script>
</head>
<body  class="PL10 PR07 PT15" onload="doinit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>시간대별 유틸리티사용량추이현황</td>
        <td width=""><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onclick="javascript:btn_Sch();"/></td>
            <td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow" onclick="addRow();" /></td>
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
          </tr>
          <tr>
            <th >계량기구분</th>
            <td>
                <select id="gaug_type" name="gaug_type" style="width: 132;">
                </select>
            </td>
            <th>기간</th>
            <td>
                <input type="text" name="em_S_Date" id="em_S_Date" size="10" title="YYYY/MM/DD" value="" maxlength="10" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);"  style='text-align:center;IME-MODE: disabled' /> 
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onclick="openCal('G',em_S_Date);return false;" /> ~
                 <input type="text" name="em_E_Date" id="em_E_Date" size="10" maxlength="10" value="" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' />
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="종료일" align="absmiddle" onclick="openCal('G',em_E_Date);return false;" />
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
        <table width="100%" height="182px" border="0" cellspacing="0" cellpadding="0" class="BD4A">
	      <tr valign="top">
	        <td>
		        <div id="DIV_TITLE" style=" width:815px;  overflow:hidden;"> 
		            <table width="2015" border="0" cellspacing="0" cellpadding="0" class="g_table">
		                        <tr>
		                          <th rowspan="2" width="25">No</th>
		                          <th rowspan="2" width="75">계량기구분</th>
		                          <th rowspan="2" width="100">계량기ID</th>
		                          <th rowspan="2" width="95">총사용량</th>
		                          <th colspan="24">시간대</th>
		                          <th rowspan="2" width="15">&nbsp;</th>
		                        </tr>
		                        <tr>
		                              <th width="65">00시</th>
		                              <th width="65">01시</th>
		                              <th width="65">02시</th>
		                              <th width="65">03시</th>
		                              <th width="65">04시</th>
		                              <th width="65">05시</th>
		                              <th width="65">06시</th>
		                              <th width="65">07시</th>
		                              <th width="65">08시</th>
		                              <th width="65">09시</th>
		                              <th width="65">10시</th>
		                              <th width="65">11시</th>
		                              <th width="65">12시</th>
		                              <th width="65">13시</th>
		                              <th width="65">14시</th>
		                              <th width="65">15시</th>
		                              <th width="65">16시</th>
		                              <th width="65">17시</th>
		                              <th width="65">18시</th>
		                              <th width="65">19시</th>
		                              <th width="65">20시</th>
		                              <th width="65">21시</th>
		                              <th width="65">22시</th>
		                              <th width="65">23시</th>
		                        </tr>
		             </table>
		        </div>
	        </td>
	      </tr>
	      <tr>
	          <td>
	              <div id="DIV_Content" style="width:815px;height:182px;overflow:scroll" onscroll="scrollAll();">
	                  <table width="1060" border="0" cellspacing="0" cellpadding="0" class="g_table">
	                            
	                  </table>
	              </div>
	          </td>
	      </tr>
    </table></td>
  </tr>
  <tr><td height="8"></td></tr>
  <tr valign="top">
    <td>
        <table width="100%"  border="0" cellspacing="0" cellpadding="0" class="BD4A">
            <tr valign="top">
                <td>
                     <div id="DETAIL_TITLE" style=" width:815px;  overflow:hidden;">
                        <table width="1915" border="0" cellspacing="0" cellpadding="0" class="g_table">
                            <tr>
					            <th rowspan="2" width="25">NO </th>
					            <th rowspan="2" width="80">일자</th>
					            <th rowspan="2" width="95">총사용량</th>
					            <th colspan="24">시간대</th>
					            <th rowspan="2" width="15">&nbsp;</th>
					          </tr>
					          <tr>
                                 <th width="65">00시</th>
                                 <th width="65">01시</th>
                                 <th width="65">02시</th>
                                 <th width="65">03시</th>
                                 <th width="65">04시</th>
                                 <th width="65">05시</th>
                                 <th width="65">06시</th>
                                 <th width="65">07시</th>
                                 <th width="65">08시</th>
                                 <th width="65">09시</th>
                                 <th width="65">10시</th>
                                 <th width="65">11시</th>
                                 <th width="65">12시</th>
                                 <th width="65">13시</th>
                                 <th width="65">14시</th>
                                 <th width="65">15시</th>
                                 <th width="65">16시</th>
                                 <th width="65">17시</th>
                                 <th width="65">18시</th>
                                 <th width="65">19시</th>
                                 <th width="65">20시</th>
                                 <th width="65">21시</th>
                                 <th width="65">22시</th>
                                 <th width="65">23시</th>
                              </tr>
                        </table>
                     </div>
                </td>
            </tr>
            <tr>    
                <td>
                    <div id="DETAIL_CONTETN" style="width:815px;height:188px;overflow:scroll" onscroll="scrollAll2();">
                        <table width="974" border="0" cellspacing="0" cellpadding="0" class="g_table">
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
