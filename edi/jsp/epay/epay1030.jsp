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
    String bizType = sessionInfo.getBIZ_TYPE();     //협력사 거래형태 
    String gb                = sessionInfo.getGB();             //1. 협력사     2.브랜드
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
<script language="javascript"  src="<%=dir%>/js/message.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script type="text/javascript">
var userid = '<%=userid%>';
var vencd = '<%=vencd%>';
var venNm = '<%=venNm%>';
var g_strcd = '<%=strcd%>';
var gb          = '<%=gb%>';
var pumbunCd    = '<%=pumbunCd%>';
var g_pre_row = -1;
var g_last_row = -1;

var bizType = '<%=bizType%>';                //협력사 거래형태

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
    /* 구분 값이 브랜드로 로그인시 "전체" 값 없음 */
    if(gb=="1"){
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "Y", pumbunCd);             //점별 브랜드
    }else{
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "N", pumbunCd);             //점별 브랜드
    }
    document.getElementById("strcd").value = '<%=strcd%>';  //점코드 
    initDateText("YYYYMM", "sDate");                        //시작월
    
    createDivDra();
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
           emp_opt.setAttribute("value", "9999999999999");//조회된 브랜드가 없으면 999999999 처리.
           var emp_text = document.createTextNode("선택");
           emp_opt.appendChild(emp_text); 
           pumbun.appendChild(emp_opt);
       }
       
       
    </ajax:callback>
}

/**
 * createDivDra()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  거래형태에 따라 그리드 형태 변경  
 * return값 : void
 */
 
function createDivDra(){
  //  alert("거래형태 : " + bizType);
    
    var divTitle = "";
    var divContent = "";
    
    if( bizType == "0" || bizType == "1" || bizType == "4" || bizType == "5"  ){           //직매입
    	
    	divTitle += "<table width='1310' cellpadding='0' cellspacing='0' border='0' class='g_table'>";
    	divTitle += "<tr>";
    	divTitle += "<th width='35'>NO</th>";
    	divTitle += "<th width='85'>점</th>";
        divTitle += "<th width='80'>지불주기</th>";
        divTitle += "<th width='80'>지불회차</th>";
    	divTitle += "<th width='95'>전월이월잔액</th>";
    	divTitle += "<th width='95'>공급가</th>";
    	divTitle += "<th width='95'>부가세</th>";
    	divTitle += "<th width='95'>이익액</th>";
    	divTitle += "<th width='95'>지불대상금액</th>";
    	divTitle += "<th width='95'>공제액</th>";
    	divTitle += "<th width='95'>보류액</th>";
    	divTitle += "<th width='95'>선급금액</th>";
    	divTitle += "<th width='95'>실지불액</th>";
    	divTitle += "<th width='95'>지불후잔액</th>";
    	divTitle += "<th width='15'>&nbsp;</th>";
    	divTitle += "</tr>";
    	
    	divContent += "<table width='1290' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
    	/*
    	divContent += "<tr>";
        divContent += "<td width='35'>&nbsp;</td>";
        divContent += "<td width='85'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "</tr>";
    	*/
    } else if( bizType == "2" ){    //특정매입
    	
    	divTitle += "<table width='1610' cellpadding='0' cellspacing='0' border='0' class='g_table'>";
    	divTitle += "<tr>";
    	divTitle += "<th width='35'>NO</th>";                         
    	divTitle += "<th width='85'>점</th>";   
        divTitle += "<th width='80'>지불주기</th>";
        divTitle += "<th width='80'>지불회차</th>";                       
        divTitle += "<th width='95'>전월이월잔액</th>";                     
        divTitle += "<th width='95'>공급가</th>";                        
        divTitle += "<th width='95'>부가세</th>";                        
        divTitle += "<th width='95'>총매출</th>";                        
        divTitle += "<th width='95'>할인</th>";                         
        divTitle += "<th width='95'>매출</th>";                         
        divTitle += "<th width='95'>이익액</th>";                        
        divTitle += "<th width='95'>지불대상금액</th>";                     
        divTitle += "<th width='95'>공제액</th>";                        
        divTitle += "<th width='95'>보류금액</th>";                       
        divTitle += "<th width='95'>선급금액</th>";                       
        divTitle += "<th width='95'>실지불액</th>";                       
        divTitle += "<th width='95'>지불후잔액</th>";                      
        divTitle += "<th width='15'>&nbsp;</th>";
    	divTitle += "</tr>";
    	
    	divContent += "<table width='1590' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
    	/*
    	divContent += "<tr>";
    	divContent += "<td width='35'>&nbsp;</td>";
    	divContent += "<td width='85'>&nbsp;</td>";
    	divContent += "<td width='95'>&nbsp;</td>";
    	divContent += "<td width='95'>&nbsp;</td>";
    	divContent += "<td width='95'>&nbsp;</td>";
    	divContent += "<td width='95'>&nbsp;</td>";
    	divContent += "<td width='95'>&nbsp;</td>";
    	divContent += "<td width='95'>&nbsp;</td>";
    	divContent += "<td width='95'>&nbsp;</td>";
    	divContent += "<td width='95'>&nbsp;</td>";
    	divContent += "<td width='95'>&nbsp;</td>";
    	divContent += "<td width='95'>&nbsp;</td>";
    	divContent += "<td width='95'>&nbsp;</td>";
    	divContent += "<td width='95'>&nbsp;</td>";
    	divContent += "<td width='95'>&nbsp;</td>";
    	divContent += "</tr>";
    	*/
    } else if( bizType == "3" ){    //임대을
    	
    	divTitle += "<table width='1320' cellpadding='0' cellspacing='0' border='0' class='g_table'>";
    	divTitle += "<tr>";
    	divTitle += "<th width='35'>NO</th>";
    	divTitle += "<th width='85'>점</th>";
        divTitle += "<th width='80'>지불주기</th>";
        divTitle += "<th width='80'>지불회차</th>";
        divTitle += "<th width='85'>전월이월잔액</th>";
        divTitle += "<th width='55'>총매출</th>";
        divTitle += "<th width='55'>할인</th>";
        divTitle += "<th width='95'>매출</th>";
        divTitle += "<th width='95'>매출수수료</th>";
        divTitle += "<th width='95'>지불대상금액</th>";
        divTitle += "<th width='95'>공제액</th>";
        divTitle += "<th width='95'>보류액</th>";
        divTitle += "<th width='95'>선급금액</th>";
        divTitle += "<th width='95'>실지불액</th>";
        divTitle += "<th width='95'>지불후잔액</th>";
        divTitle += "<th width='15'>&nbsp;</th>";
    	divTitle += "</tr>";
    	
    	divContent += "<table width='1300' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
    	/*
    	divContent += "<tr>";
        divContent += "<td width='35'>&nbsp;</td>";
        divContent += "<td width='85'>&nbsp;</td>";
        divContent += "<td width='85'>&nbsp;</td>";
        divContent += "<td width='55'>&nbsp;</td>";
        divContent += "<td width='55'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "<td width='95'>&nbsp;</td>";
        divContent += "</tr>";   
    	*/
    }
    divTitle += "</table>";
    divContent += "</table>"  
    
    // 스크롤 위치 초기화
    document.all.topTitle.scrollLeft = 0;
    document.all.DIV_Content.scrollLeft = 0;
    document.getElementById("topTitle").innerHTML = divTitle;
    document.getElementById("DIV_Content").innerHTML = divContent;
}
 
/**
 * btn_Sch()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  조회  
 * return값 : void
 */
function btn_Sch(){
	 
	 //조회시 header 재선언& 스크롤 위치 초기화
	 createDivDra();
	 
    var strStrcd = document.getElementById("strcd").value;                      //점코드
    var strVencd = document.getElementById("vencd").value;                      //협력사코드
    var sDate = getRawData(document.getElementById("sDate").value);             //조회월
    var strPumbuncd = document.getElementById("pubumCd").value;                 //품번
   
    if( sDate == "" ){
    	showMessage(EXCLAMATION , OK, "USER-1001", "년월");
    	document.getElementById("sDate").focus();
    	return;
    }
    
    var param = "&goTo=getMaster" + "&strcd=" + strStrcd
                                  + "&vencd=" + strVencd
                                  + "&bizType=" + bizType
                                  + "&sDate=" + sDate
                                  + "&strPumbuncd=" + strPumbuncd
                                  ;
    
    <ajax:open callback="on_SearchXML" 
            param="param" 
            method="POST" 
            urlvalue="/edi/epay103.ea"/>
    
    <ajax:callback function="on_SearchXML">
        var content = "";
        if( rowsNode.length > 0 ){

           // createDivDra();
        	if( bizType == "0" || bizType == "1" || bizType == "4" || bizType == "5"  ){           //직매입
        		
        		var btime_bal_amt_sum = 0;
        		var ntime_sup_amt_sum = 0;
        		var ntime_vat_amt_sum = 0;
        		var comis_sale_amt_sum  = 0;
        		var ntime_pay_amt_sum = 0;
        		var ntime_bfpay_amt_sum = 0;
        		var ntime_hold_amt_sum = 0;
        		var ntime_ded_amt_sum = 0;
        		var ntime_rlpay_amt_sum = 0;	
        		var ntime_bal_amt_sum = 0;
        		    	
        		content += "<table width='1290' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
        		
        		for( i = 0; i < rowsNode.length; i++ ){
        			var strcd = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
        			var strNm = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
        			var pay_cyc = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
        			var pay_cnt = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                    var btime_bal_amt = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
        			var ntime_sup_amt = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
        			var ntime_vat_amt = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
        			var comis_sale_amt = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
        			var ntime_pay_amt = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
        			var ntime_bfpay_amt = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
        			var ntime_hold_amt = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
        			var ntime_ded_amt = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
        			var ntime_rlpay_amt = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
        			var ntime_bal_amt = rowsNode[i].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[13].childNodes[0].nodeValue;
        			
        			
        			btime_bal_amt_sum += Number(btime_bal_amt);
        			ntime_sup_amt_sum += Number(ntime_sup_amt);
        			ntime_vat_amt_sum += Number(ntime_vat_amt);
        			comis_sale_amt_sum += Number(comis_sale_amt);
        			ntime_pay_amt_sum += Number(ntime_pay_amt);
        			ntime_bfpay_amt_sum += Number(ntime_bfpay_amt);
        			ntime_hold_amt_sum += Number(ntime_hold_amt);
        			ntime_ded_amt_sum += Number(ntime_ded_amt);
        			ntime_rlpay_amt_sum += Number(ntime_rlpay_amt);
        			ntime_bal_amt_sum += Number(ntime_bal_amt);
        			
        			 content += "<tr onclick='chBak("+i+");'>";
                     content += "<td width='35' class='r1' id='1tdId"+i+"'>"+(i+1)+"</td>";
                     content += "<td width='85' class='r3' id='2tdId"+i+"'>"+strNm+"</td>";
                     content += "<td width='80' class='r1' id='3tdId"+i+"'>"+pay_cyc+"</td>";
                     content += "<td width='80' class='r1' id='4tdId"+i+"'>"+pay_cnt+"</td>";
                     content += "<td width='95' class='r4' id='5tdId"+i+"'>"+convAmt(btime_bal_amt)+"</td>";
                     content += "<td width='95' class='r4' id='6tdId"+i+"'>"+convAmt(ntime_sup_amt)+"</td>";
                     content += "<td width='95' class='r4' id='7tdId"+i+"'>"+convAmt(ntime_vat_amt)+"</td>";
                     content += "<td width='95' class='r4' id='8tdId"+i+"'>"+convAmt(comis_sale_amt)+"</td>";
                     content += "<td width='95' class='r4' id='9tdId"+i+"'>"+convAmt(ntime_pay_amt)+"</td>";
                     content += "<td width='95' class='r4' id='10tdId"+i+"'>"+convAmt(ntime_bfpay_amt)+"</td>";
                     content += "<td width='95' class='r4' id='11tdId"+i+"'>"+convAmt(ntime_hold_amt)+"</td>";
                     content += "<td width='95' class='r4' id='12tdId"+i+"'>"+convAmt(ntime_ded_amt)+"</td>";
                     content += "<td width='95' class='r4' id='13tdId"+i+"'>"+convAmt(ntime_rlpay_amt)+"</td>";
                     content += "<td width='95' class='r4' id='14tdId"+i+"'>"+convAmt(ntime_bal_amt)+"</td>";
                     content += "</tr>"; 
                     
        		}
        		
        		content += "<tr>";
        		content += "<td class='sum1'>&nbsp;</td>";
        		content += "<td class='sum1' colspan='3'>합계</td>";
        		content += "<td class='sum2'>"+convAmt(String(btime_bal_amt_sum))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(ntime_sup_amt_sum))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(ntime_vat_amt_sum))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(comis_sale_amt_sum))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(ntime_pay_amt_sum))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(ntime_bfpay_amt_sum))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(ntime_hold_amt_sum))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(ntime_ded_amt_sum))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(ntime_rlpay_amt_sum))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(ntime_bal_amt_sum))+"</td>";
        		content += "</tr>";                           
               
                
                
        	} else if( bizType == "2" ){                       //특정매입
        		
        		var btime_bal_amt_sum = 0;
        		var sup_amt_sum = 0;
        		var vat_amt_sum = 0;
        		var sale_tot_amt_sum = 0;
        		var redu_amt_sum = 0;
        		var sale_amt_sum = 0;
        		var comis_sale_amt_sum = 0;
        		var ntime_pay_amt_sum = 0;
        		var ntime_bfpay_amt_sum = 0;
        		var ntime_hold_amt_sum = 0;
        		var ntime_ded_amt_sum = 0;
        		var ntime_rlpay_amt_sum = 0;
        		var ntime_bal_amt_sum = 0; 
        		    	
        		content += "<table width='1590' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
        		
        		
        		for( i = 0; i < rowsNode.length; i++ ){
        			
        			var strcd = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                    var strNm = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                    var pay_cyc = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
                    var pay_cnt = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                    var btime_bal_amt = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
                    var sup_amt = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
                    var vat_amt = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
                    var sale_tot_amt = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
                    var redu_amt = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
                    var sale_amt = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
                    var comis_sale_amt = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
                    var ntime_pay_amt = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
                    var ntime_bfpay_amt = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
                    var ntime_hold_amt = rowsNode[i].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[13].childNodes[0].nodeValue;
                    var ntime_ded_amt = rowsNode[i].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[14].childNodes[0].nodeValue;
                    var ntime_rlpay_amt = rowsNode[i].childNodes[15].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[15].childNodes[0].nodeValue;
                    var ntime_bal_amt = rowsNode[i].childNodes[16].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[16].childNodes[0].nodeValue;
        			
                    btime_bal_amt_sum += Number(btime_bal_amt);
                    sup_amt_sum += Number(sup_amt);
                    vat_amt_sum += Number(vat_amt);
                    sale_tot_amt_sum += Number(sale_tot_amt);
                    redu_amt_sum += Number(redu_amt);
                    sale_amt_sum += Number(sale_amt);
                    comis_sale_amt_sum += Number(comis_sale_amt);
                    ntime_pay_amt_sum += Number(ntime_pay_amt);
                    ntime_bfpay_amt_sum += Number(ntime_bfpay_amt);
                    ntime_hold_amt_sum += Number(ntime_hold_amt);
                    ntime_ded_amt_sum += Number(ntime_ded_amt);
                    ntime_rlpay_amt_sum += Number(ntime_rlpay_amt);
                    ntime_bal_amt_sum += Number(ntime_bal_amt);      
                   
        			content += "<tr onclick='chBak2("+i+");'>";
                    content += "<td width='35' class='r1' id='1atdId"+i+"'>"+(i+1)+"</td>";
                    content += "<td width='85' class='r3' id='2atdId"+i+"'>"+strNm+"</td>";
                    content += "<td width='80' class='r1' id='3tdId"+i+"'>"+pay_cyc+"</td>";
                    content += "<td width='80' class='r1' id='4tdId"+i+"'>"+pay_cnt+"</td>";
                    content += "<td width='95' class='r4' id='5atdId"+i+"'>"+convAmt(btime_bal_amt)+"</td>";
                    content += "<td width='95' class='r4' id='6atdId"+i+"'>"+convAmt(sup_amt)+"</td>";
                    content += "<td width='95' class='r4' id='7atdId"+i+"'>"+convAmt(vat_amt)+"</td>";
                    content += "<td width='95' class='r4' id='8atdId"+i+"'>"+convAmt(sale_tot_amt)+"</td>";
                    content += "<td width='95' class='r4' id='9atdId"+i+"'>"+convAmt(redu_amt)+"</td>";
                    content += "<td width='95' class='r4' id='10atdId"+i+"'>"+convAmt(sale_amt)+"</td>";
                    content += "<td width='95' class='r4' id='11atdId"+i+"'>"+convAmt(comis_sale_amt)+"</td>";
                    content += "<td width='95' class='r4' id='12atdId"+i+"'>"+convAmt(ntime_pay_amt)+"</td>";
                    content += "<td width='95' class='r4' id='13atdId"+i+"'>"+convAmt(ntime_bfpay_amt)+"</td>";
                    content += "<td width='95' class='r4' id='14atdId"+i+"'>"+convAmt(ntime_hold_amt)+"</td>";
                    content += "<td width='95' class='r4' id='15atdId"+i+"'>"+convAmt(ntime_ded_amt)+"</td>";
                    content += "<td width='95' class='r4' id='16atdId"+i+"'>"+convAmt(ntime_rlpay_amt)+"</td>";
                    content += "<td width='95' class='r4' id='17atdId"+i+"'>"+convAmt(ntime_bal_amt)+"</td>";
                    content += "</tr>"; 
        		}
        		content += "<tr>";
                content += "<td class='sum1'>&nbsp;</td>";
                content += "<td class='sum1' colspan='3'>합계</td>";
                content += "<td class='sum2'>"+convAmt(String(btime_bal_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(sup_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(vat_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(sale_tot_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(redu_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(sale_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(comis_sale_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntime_pay_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntime_bfpay_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntime_hold_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntime_ded_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntime_rlpay_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntime_bal_amt_sum))+"</td>";
                content += "</tr>";
        		
        	} else if( bizType == "3" ){
                
        		var btime_bal_amt_sum = 0;
                var sale_tot_amt_sum = 0;
                var redu_amt_sum = 0;
                var sale_amt_sum = 0;
                var comis_sale_amt_sum = 0;
                var ntime_pay_amt_sum = 0;
                var ntime_bfpay_amt_sum = 0;
                var ntime_hold_amt_sum = 0;
                var ntime_ded_amt_sum = 0;
                var ntime_rlpay_amt_sum = 0;
                var ntime_bal_amt_sum = 0; 
        		
                
                content += "<table width='1300' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
                
        		for( i = 0; i < rowsNode.length; i++ ){
        			
        			var strcd = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                    var strNm = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                    var pay_cyc = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
                    var pay_cnt = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                    var btime_bal_amt = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
                    var sale_tot_amt = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
                    var redu_amt = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
                    var sale_amt = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
                    var comis_sale_amt = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
                    var ntime_pay_amt = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
                    var ntime_bfpay_amt = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
                    var ntime_hold_amt = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
                    var ntime_ded_amt = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
                    var ntime_rlpay_amt = rowsNode[i].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[13].childNodes[0].nodeValue;
                    var ntime_bal_amt = rowsNode[i].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[14].childNodes[0].nodeValue;
                    
        			
                    btime_bal_amt_sum += Number(btime_bal_amt);
                    sale_tot_amt_sum += Number(sale_tot_amt);
                    redu_amt_sum += Number(redu_amt);
                    sale_amt_sum += Number(sale_amt);
                    comis_sale_amt_sum += Number(comis_sale_amt);
                    ntime_pay_amt_sum += Number(ntime_pay_amt);
                    ntime_bfpay_amt_sum += Number(ntime_bfpay_amt);
                    ntime_hold_amt_sum += Number(ntime_hold_amt);
                    ntime_ded_amt_sum += Number(ntime_ded_amt);
                    ntime_rlpay_amt_sum += Number(ntime_rlpay_amt);
                    ntime_bal_amt_sum += Number(ntime_bal_amt);    
                    
                    content += "<tr  onclick='chBak3("+i+");'>";
                    content += "<td width='35' class='r1' id='1atdId"+i+"'>"+(i+1)+"</td>";
                    content += "<td width='85' class='r3' id='2atdId"+i+"'>"+strNm+"</td>";
                    content += "<td width='80' class='r1' id='3tdId"+i+"'>"+pay_cyc+"</td>";
                    content += "<td width='80' class='r1' id='4tdId"+i+"'>"+pay_cnt+"</td>";
                    content += "<td width='85' class='r4' id='5atdId"+i+"'>"+convAmt(btime_bal_amt)+"</td>";
                    content += "<td width='55' class='r4' id='6atdId"+i+"'>"+convAmt(sale_tot_amt)+"</td>";
                    content += "<td width='55' class='r4' id='7atdId"+i+"'>"+convAmt(redu_amt)+"</td>";
                    content += "<td width='95' class='r4' id='8atdId"+i+"'>"+convAmt(sale_amt)+"</td>";
                    content += "<td width='95' class='r4' id='9atdId"+i+"'>"+convAmt(comis_sale_amt)+"</td>";
                    content += "<td width='95' class='r4' id='10atdId"+i+"'>"+convAmt(ntime_pay_amt)+"</td>";
                    content += "<td width='95' class='r4' id='11atdId"+i+"'>"+convAmt(ntime_bfpay_amt)+"</td>";
                    content += "<td width='95' class='r4' id='12atdId"+i+"'>"+convAmt(ntime_hold_amt)+"</td>";
                    content += "<td width='95' class='r4' id='13atdId"+i+"'>"+convAmt(ntime_ded_amt)+"</td>";
                    content += "<td width='95' class='r4' id='14atdId"+i+"'>"+convAmt(ntime_rlpay_amt)+"</td>";
                    content += "<td width='95' class='r4' id='15atdId"+i+"'>"+convAmt(ntime_bal_amt)+"</td>";
                    content += "</tr>";   
                    
        		}
        		
        		content += "<tr>";
                content += "<td class='sum1'>&nbsp;</td>";
                content += "<td class='sum1' colspan='3' >합계</td>";
                content += "<td class='sum2'>"+convAmt(String(btime_bal_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(sale_tot_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(redu_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(sale_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(comis_sale_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntime_pay_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntime_bfpay_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntime_hold_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntime_ded_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntime_rlpay_amt_sum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntime_bal_amt_sum))+"</td>";
                content += "</tr>";
        		
        	}
        	content += "</table>";	
        } 
        
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
function chBak2(val) {
    g_last_row = val;
    if (g_pre_row != g_last_row){
        for(i=1;i<15;i++) {
            document.getElementById(i+"atdId"+val).style.backgroundColor="#fff56E";
            if (g_pre_row != -1) {
                document.getElementById(i+"atdId"+g_pre_row).style.backgroundColor="#ffffff";
            }
        }
    }
    g_pre_row = g_last_row;
}
function chBak3(val) {
    g_last_row = val;
    if (g_pre_row != g_last_row){
        for(i=1;i<13;i++) {
            document.getElementById(i+"btdId"+val).style.backgroundColor="#fff56E";
            if (g_pre_row != -1) {
                document.getElementById(i+"btdId"+g_pre_row).style.backgroundColor="#ffffff";
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
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/> 잔액조회</td>
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
            <th width="80" class="POINT">년월</th>
            <td width="110">
                <input type="text" name="sDate" id="sDate" size="10" onkeypress="javascript:onlyNumber();" onblur="dateOnblur(this);" onfocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' maxlength="6" />
                <img src="<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',sDate)" align="absmiddle" />
                
            </td>
            <th width="80">브랜드코드</th>
            <td>
                <select name="pubumCd" id="pubumCd" style="width: 132;">
                </select>
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
    <td>
       <table width="100%"  border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr valign="top">
        <td><div id="topTitle" style="width:815px;overflow:hidden;">
                <table width="1310" cellpadding="0" cellspacing="0" border="0" class="g_table" >
                    <tr>
                         
                    </tr>
                </table>
            </div>        
        </td>
      </tr>
      <tr>
          <td ><div id="DIV_Content" style="width:815px;height:480px;overflow:scroll" onscroll="scrollAll();">
                  <table width="1390" cellspacing="0" cellpadding="0" border="0" class="g_table">
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

