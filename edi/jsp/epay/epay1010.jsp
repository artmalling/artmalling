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
<script language="javascript" src="<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/global.js"    type="text/javascript"></script>

<script type="text/javascript">
var userid = '<%=userid%>';
var vencd = '<%=vencd%>';
var venNm = '<%=venNm%>';
var g_strcd = '<%=strcd%>';
var gb          = '<%=gb%>';
var pumbunCd    = '<%=pumbunCd%>';
var g_pre_row = -1;
var g_last_row = -1;

var bizType;                //협력사 거래형태

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
    /* 구분 값이 브랜드로 로그인시 "전체" 값 없음 */
    if(gb=="1"){
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "Y", pumbunCd);             //점별 브랜드
    }else{
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "N", pumbunCd);             //점별 브랜드
    }
    
    initDateText("YYYYMM", "sDate");                        //시작월
    initDateText("YYYYMM", "eDate");                        //종료월
    getSelectCombo("D", "P052", "payCyc", "Y");             //지불주기  Y: 전체 혀용
    getSelectCombo("D", "P407", "pay_cnt", "Y");            //지불회차  Y: 전체 혀용
    
    getBizType();                                           //협력사 거래형태 
    
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
 * getBizType()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  협력사 거래형태 1.직매입, 2.특정매입 3.임대을  
 * return값 : void
 */
function getBizType(){
	
	var param = "&goTo=getBizType" + "&strcd=" + g_strcd
                                   + "&vencd=" + vencd;
	
	<ajax:open callback="on_BizTypeXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/ccom001.cc"/>
    
    
    <ajax:callback function="on_BizTypeXML">
        if( rowsNode.length > 0 ){
        	bizType = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
        } else {
        	bizType = "0";
        }
        createDivDra();
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
    
    
    var divTitle = "";
    var divContent = "";
    
    if( bizType == "0" || bizType == "1" || bizType == "4" || bizType == "5"  ){           //직매입
    	
    	divTitle += "<table width='1350' cellpadding='0' cellspacing='0' border='0' class='g_table'>";
    	divTitle += "<tr>";
    	divTitle += "<th width='35'>NO</th>";
    	divTitle += "<th width='85'>점</th>";
    	divTitle += "<th width='75'>해당년월</th>";
    	divTitle += "<th width='55'>지불주기</th>";
    	divTitle += "<th width='55'>지불회차</th>";
    	divTitle += "<th width='95'>전월이월잔액</th>";
    	divTitle += "<th width='95'>공급가</th>";
    	divTitle += "<th width='95'>부가세</th>";
    	divTitle += "<th width='95'>이익액</th>";
    	divTitle += "<th width='95'>지불대상금액</th>";
    	divTitle += "<th width='95'>공제액</th>";
    	divTitle += "<th width='95'>공제금액(입금)</th>";
    	divTitle += "<th width='95'>보류액</th>";
    	divTitle += "<th width='95'>선급금액</th>";
    	divTitle += "<th width='95'>실지불액</th>";
    	divTitle += "<th width='95'>지불후잔액</th>";
    	divTitle += "<th width='15'>&nbsp;</th>";
    	divTitle += "</tr>";
    	
    	divContent += "<table width='1330' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
    	
    } else if( bizType == "2" ){    //특정매입
    	
    	divTitle += "<table width='1650' cellpadding='0' cellspacing='0' border='0' class='g_table'>";
    	divTitle += "<tr>";
    	divTitle += "<th width='35'>NO</th>";
    	divTitle += "<th width='85'>점</th>";
        divTitle += "<th width='75'>해당년월</th>";
        divTitle += "<th width='55'>지불주기</th>";
        divTitle += "<th width='55'>지불회차</th>";
        divTitle += "<th width='95'>전월이월잔액</th>";
        divTitle += "<th width='95'>공급가</th>";
        divTitle += "<th width='95'>부가세</th>";
        divTitle += "<th width='95'>총매출</th>";
        divTitle += "<th width='95'>할인</th>";
        divTitle += "<th width='95'>매출</th>";
        divTitle += "<th width='95'>이익액</th>";
        divTitle += "<th width='95'>지불대상금액</th>";
        divTitle += "<th width='95'>공제액</th>";
        divTitle += "<th width='95'>공제금액(입금)</th>";
        divTitle += "<th width='95'>보류액</th>";
        divTitle += "<th width='95'>선급금액</th>";
        divTitle += "<th width='95'>실지불액</th>";
        divTitle += "<th width='95'>지불후잔액</th>";
        divTitle += "<th width='15'>&nbsp;</th>";
    	divTitle += "</tr>";
    	
    	divContent += "<table width='1630' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
    	
    } else if( bizType == "3" ){    //임대을
    	
    	divTitle += "<table width='1450' cellpadding='0' cellspacing='0' border='0' class='g_table'>";
    	divTitle += "<tr>";
    	divTitle += "<th width='35'>NO</th>";
    	divTitle += "<th width='85'>점</th>";
        divTitle += "<th width='75'>해당년월</th>";
        divTitle += "<th width='55'>지불주기</th>";
        divTitle += "<th width='55'>지불회차</th>";
        divTitle += "<th width='95'>전월이월잔액</th>";
        divTitle += "<th width='95'>총매출</th>";
        divTitle += "<th width='95'>할인</th>";
        divTitle += "<th width='95'>매출</th>";
        divTitle += "<th width='95'>이익액</th>";
        divTitle += "<th width='95'>지불대상금액</th>";
        divTitle += "<th width='95'>공제액</th>";
        divTitle += "<th width='95'>공제금액(입금)</th>";
        divTitle += "<th width='95'>보류액</th>";
        divTitle += "<th width='95'>선급금액</th>";
        divTitle += "<th width='95'>실지불액</th>";
        divTitle += "<th width='95'>지불후잔액</th>";
        divTitle += "<th width='15'>&nbsp;</th>";
    	divTitle += "</tr>";
    	
    	divContent += "<table width='1430' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
    	
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
    
    var strStrcd = document.getElementById("strcd").value;                      //점코드
    var strVencd = document.getElementById("vencd").value;                      //협력사코드
    var sDate = getRawData(document.getElementById("sDate").value);             //시작월
    var eDate = getRawData(document.getElementById("eDate").value);             //종료월
    var strPayCyc = document.getElementById("payCyc").value;                    //지불주기 
    var strPayCnt = document.getElementById("pay_cnt").value;                   //지불회차
    var strPumbuncd = document.getElementById("pubumCd").value;                 //품번
   
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
   // getDetailPopUp(2);
   
    var param = "&goTo=getMaster" + "&strcd=" + strStrcd
                                  + "&vencd=" + strVencd
                                  + "&bizType=" + bizType
                                  + "&sDate=" + sDate
                                  + "&eDate=" + eDate
                                  + "&strPayCyc=" + strPayCyc
                                  + "&strPayCnt=" + strPayCnt
                                  + "&strPumbuncd=" + strPumbuncd
                                  ;
    
    <ajax:open callback="on_SearchXML" 
            param="param" 
            method="POST" 
            urlvalue="/edi/epay101.ea"/>
    
    <ajax:callback function="on_SearchXML">
       // bizType = "1"; 
        
	    // 스크롤 위치 초기화
	    document.all.topTitle.scrollLeft = 0;
	    document.all.DIV_Content.scrollLeft = 0;
    
        var content = "";
        if( rowsNode.length > 0 ){
        	
        	if( bizType == "0" || bizType == "1" || bizType == "4" || bizType == "5"  ){           //직매입
        		
        		var biz1SupamtSum = 0;
        		var biz1NtimeVatAmtSum = 0;
        		var biz1ComisSaleAmtSum = 0;
        		var biz1NtimePayAmtSum = 0;
        		var biz1NtimeDedAmtSum = 0;
        		var biz1NtimeHoldAmtSum = 0;
        		var biz1NtimeBfpayAmtSum = 0;
        		var biz1NtimeRlpayAmtSum = 0;
        		var biz1BalAmtSum = 0;	
        		
        		content += "<table width='1330' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
        		
        		for( i = 0; i < rowsNode.length; i++ ){
        			var strcd = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
        			var strNm = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
        			var vencd = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
        			var venNm = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
        			var payYM = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
        			var payCYC = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
        			var payCNT = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
        			var btime_bal_amt = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
        			var ntime_sup_amt = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
        			var ntime_vat_amt = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
        			var comis_sale_amt = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
        			var ntime_pay_amt = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
        			var ntime_ded_amt = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
        			var ntime_ded_amt2 = rowsNode[i].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[13].childNodes[0].nodeValue;
        			var ntime_hold_amt = rowsNode[i].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[14].childNodes[0].nodeValue;
        			var ntime_bfpay_amt = rowsNode[i].childNodes[15].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[15].childNodes[0].nodeValue;
        			var ntime_rlpay_amt = rowsNode[i].childNodes[16].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[16].childNodes[0].nodeValue;
        			var ntime_bal_amt = rowsNode[i].childNodes[17].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[17].childNodes[0].nodeValue;
        			
        			
        			biz1SupamtSum += Number(ntime_sup_amt);
        			biz1NtimeVatAmtSum += Number(ntime_vat_amt);
        			biz1ComisSaleAmtSum += Number(comis_sale_amt);
        			biz1NtimePayAmtSum += Number(ntime_pay_amt);
        			biz1NtimeDedAmtSum += Number(ntime_ded_amt);
        			biz1NtimeDedAmtSum += Number(ntime_ded_amt2);
        			biz1NtimeHoldAmtSum += Number(ntime_hold_amt);
        			biz1NtimeBfpayAmtSum += Number(ntime_bfpay_amt);
        			biz1NtimeRlpayAmtSum += Number(ntime_rlpay_amt);
        			biz1BalAmtSum += Number(ntime_bal_amt);
        			
        			 content += "<tr onclick='chBak("+i+");getDetailPopUp("+i+");' style='cursor:hand;' >";
        			 content += "<input type='hidden' name='m_strcd' id='m_strcd"+i+"' value='"+strcd+"' />";
        			 content += "<input type='hidden' name='m_vencd' id='m_vencd"+i+"' value='"+vencd+"' />";
        			 content += "<input type='hidden' name='m_payYM' id='m_payYM"+i+"' value='"+payYM+"' />";
        			 content += "<input type='hidden' name='m_payCYC' id='m_payCYC"+i+"' value='"+payCYC+"' />";
        			 content += "<input type='hidden' name='m_payCNT' id='m_payCNT"+i+"' value='"+payCNT+"' />";
                     content += "<td width='34' class='r1' id='1tdId"+i+"'>"+(i+1)+"</td>";
                     content += "<td width='79' class='r3' id='2tdId"+i+"'>"+strNm+"</td>";
                     content += "<td width='69' class='r1' id='3tdId"+i+"'>"+getDateFormat(payYM)+"</td>";
                     content += "<td width='55' class='r1' id='4tdId"+i+"'>"+payCYC+"주기</td>";
                     content += "<td width='55' class='r1' id='5tdId"+i+"'>"+payCNT+"회차</td>";
                     content += "<td width='95' class='r4' id='6tdId"+i+"'>"+convAmt(btime_bal_amt)+"</td>";
                     content += "<td width='95' class='r4' id='7tdId"+i+"'>"+convAmt(ntime_sup_amt)+"</td>";
                     content += "<td width='95' class='r4' id='8tdId"+i+"'>"+convAmt(ntime_vat_amt)+"</td>";
                     content += "<td width='95' class='r4' id='9tdId"+i+"'>"+convAmt(comis_sale_amt)+"</td>";
                     content += "<td width='95' class='r4' id='10tdId"+i+"'>"+convAmt(ntime_pay_amt)+"</td>";
                     content += "<td width='95' class='r4' id='11tdId"+i+"'>"+convAmt(ntime_ded_amt)+"</td>";
                     content += "<td width='95' class='r4' id='11tdId"+i+"'>"+convAmt(ntime_ded_amt2)+"</td>";	 
                     content += "<td width='95' class='r4' id='12tdId"+i+"'>"+convAmt(ntime_hold_amt)+"</td>";
                     content += "<td width='95' class='r4' id='13tdId"+i+"'>"+convAmt(ntime_bfpay_amt)+"</td>";
                     content += "<td width='95' class='r4' id='14tdId"+i+"'>"+convAmt(ntime_rlpay_amt)+"</td>";
                     content += "<td width='95' class='r4' id='15tdId"+i+"'>"+convAmt(ntime_bal_amt)+"</td>";
                     content += "</tr>"; 
                     
        		}
        		
        		content += "<tr>";
        		content += "<td class='sum1'>&nbsp;</td>";
        		content += "<td class='sum1' colspan='5'>합계</td>";
        		content += "<td class='sum2'>"+convAmt(String(biz1SupamtSum))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(biz1NtimeVatAmtSum))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(biz1ComisSaleAmtSum))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(biz1NtimePayAmtSum))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(biz1NtimeDedAmtSum))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(biz1NtimeDedAmtSum2))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(biz1NtimeHoldAmtSum))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(biz1NtimeBfpayAmtSum))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(biz1NtimeRlpayAmtSum))+"</td>";
        		content += "<td class='sum2'>"+convAmt(String(biz1BalAmtSum))+"</td>";
        		content += "</tr>";
               
                
                
        	} else if( bizType == "2" ){                       //특정매입
        		
        		var supAmtSum = 0;
        		var vatAmtSum = 0;
        		var saleTotAmtSum = 0;
        		var reduAmtSum = 0;
        		var saleAmtSum = 0;
        		var comisSaleAmtSum = 0;
        		var ntimePayAmtSum = 0;
        		var ntimeDedAmtSum = 0;
        		var ntimeDedAmtSum2 = 0;
        		var ntimeHoldAmtSum = 0;
        		var ntimeBfpayAmtSum = 0;
        		var ntimeRlpayAmtSum = 0;
        		var ntimeBalAmtSum = 0;
        		
        		content += "<table width='1630' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
        		
        		
        		for( i = 0; i < rowsNode.length; i++ ){
        			
        			var strcd = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                    var strNm = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                    var vencd = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
                    var venNm = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                    var payYM = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
                    var payCYC = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
                    var payCNT = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
                    var btime_bal_amt = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
                    var supAmt = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
                    var vatAmt = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
                    var saleTotAmt = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
                    var reduAmt = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
                    var saleAmt = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
                    var comisSaleAmt = rowsNode[i].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[13].childNodes[0].nodeValue;
                    var ntimePayAmt = rowsNode[i].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[14].childNodes[0].nodeValue;
                    var ntimeDedAmt = rowsNode[i].childNodes[15].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[15].childNodes[0].nodeValue;
                    var ntimeDedAmt2 = rowsNode[i].childNodes[16].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[16].childNodes[0].nodeValue;
                    var ntimeHoldAmt = rowsNode[i].childNodes[17].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[17].childNodes[0].nodeValue;
                    var ntimeBfpayAmt = rowsNode[i].childNodes[18].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[18].childNodes[0].nodeValue;
                    var ntimeRlpayAmt = rowsNode[i].childNodes[19].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[19].childNodes[0].nodeValue;
                    var ntimeBalAmt = rowsNode[i].childNodes[20].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[20].childNodes[0].nodeValue;
        			
                    supAmtSum += Number(supAmt);
                    vatAmtSum += Number(vatAmt);
                    saleTotAmtSum += Number(saleTotAmt);
                    reduAmtSum += Number(reduAmt);
                    saleAmtSum += Number(saleAmt);
                    comisSaleAmtSum += Number(comisSaleAmt);
                    ntimePayAmtSum += Number(ntimePayAmt);
                    ntimeDedAmtSum += Number(ntimeDedAmt);
                    ntimeDedAmtSum2 += Number(ntimeDedAmt2);
                    ntimeHoldAmtSum += Number(ntimeHoldAmt);
                    ntimeBfpayAmtSum += Number(ntimeBfpayAmt);
                    ntimeRlpayAmtSum += Number(ntimeRlpayAmt);
                    ntimeBalAmtSum += Number(ntimeBalAmt);
                    
        			content += "<tr onclick='chBak2("+i+");getDetailPopUp("+i+");' style='cursor:hand;' >";
                    content += "<input type='hidden' name='m_strcd' id='m_strcd"+i+"' value='"+strcd+"' />";
                    content += "<input type='hidden' name='m_vencd' id='m_vencd"+i+"' value='"+vencd+"' />";
                    content += "<input type='hidden' name='m_payYM' id='m_payYM"+i+"' value='"+payYM+"' />";
                    content += "<input type='hidden' name='m_payCYC' id='m_payCYC"+i+"' value='"+payCYC+"' />";
                    content += "<input type='hidden' name='m_payCNT' id='m_payCNT"+i+"' value='"+payCNT+"' />";
                    content += "<td width='34' class='r1' id='1atdId"+i+"'>"+(i+1)+"</td>";
                    content += "<td width='81' class='r3' id='2atdId"+i+"'>"+strNm+"</td>";
                    content += "<td width='70' class='r1' id='3atdId"+i+"'>"+getDateFormat(payYM)+"</td>";
                    content += "<td width='53' class='r1' id='4atdId"+i+"'>"+payCYC+"주기</td>";
                    content += "<td width='54' class='r1' id='5atdId"+i+"'>"+payCNT+"회차</td>";
                    content += "<td width='90' class='r4' id='6atdId"+i+"'>"+convAmt(btime_bal_amt)+"</td>";//
                    content += "<td width='90' class='r4' id='7atdId"+i+"'>"+convAmt(supAmt)+"</td>";//
                    content += "<td width='90' class='r4' id='8atdId"+i+"'>"+convAmt(vatAmt)+"</td>";//
                    content += "<td width='90' class='r4' id='9atdId"+i+"'>"+convAmt(saleTotAmt)+"</td>";//
                    content += "<td width='92' class='r4' id='10atdId"+i+"'>"+convAmt(reduAmt)+"</td>";
                    content += "<td width='90' class='r4' id='11atdId"+i+"'>"+convAmt(saleAmt)+"</td>";
                    content += "<td width='90' class='r4' id='12atdId"+i+"'>"+convAmt(comisSaleAmt)+"</td>";
                    content += "<td width='90' class='r4' id='13atdId"+i+"'>"+convAmt(ntimePayAmt)+"</td>";
                    content += "<td width='90' class='r4' id='14atdId"+i+"'>"+convAmt(ntimeDedAmt)+"</td>";
                    content += "<td width='90' class='r4' id='15atdId"+i+"'>"+convAmt(ntimeDedAmt2)+"</td>";
                    content += "<td width='90' class='r4' id='16atdId"+i+"'>"+convAmt(ntimeHoldAmt)+"</td>";
                    content += "<td width='90' class='r4' id='17atdId"+i+"'>"+convAmt(ntimeBfpayAmt)+"</td>";
                    content += "<td width='90' class='r4' id='18atdId"+i+"'>"+convAmt(ntimeRlpayAmt)+"</td>";
                    content += "<td width='90' class='r4' id='19atdId"+i+"'>"+convAmt(ntimeBalAmt)+"</td>";
                    content += "</tr>"; 
        			
        		}
        		content += "<tr>";
                content += "<td class='sum1'>&nbsp;</td>";
                content += "<td class='sum1' colspan='5'>합계</td>";
                content += "<td class='sum2'>"+convAmt(String(supAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(vatAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(saleTotAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(reduAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(saleAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(comisSaleAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntimePayAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntimeDedAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntimeDedAmtSum2))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntimeHoldAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntimeBfpayAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntimeRlpayAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntimeBalAmtSum))+"</td>";
                content += "</tr>";
        		
        	} else if( bizType == "3" ){
                
                var saleTotAmtSum = 0;
        		var reduAmtSum = 0;
        		var saleAmtSum = 0;
        		var comisSaleAmtSum = 0;
        		var ntimePayAmtSum = 0;
        		var ntimeDedAmtSum = 0;
        		var ntimeDedAmtSum2 = 0;
        		var ntimeHoldAmtSum = 0;
        		var ntimeBfpayAmtSum = 0;
        		var ntimeRlpayAmtSum = 0;
        		var ntimeBalAmtSum = 0;
        		
                
                content += "<table width='1430' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
                
        		for( i = 0; i < rowsNode.length; i++ ){
        			
        			var strcd = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                    var strNm = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                    var vencd = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
                    var venNm = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                    var payYM = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
                    var payCYC = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
                    var payCNT = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
                    var btime_bal_amt = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
                    var saleTotAmt = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
                    var reduAmt = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
                    var saleAmt = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
                    var comisSaleAmt = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
                    var ntimePayAmt = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
                    var ntimeDedAmt = rowsNode[i].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[13].childNodes[0].nodeValue;
                    var ntimeDedAmt2 = rowsNode[i].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[14].childNodes[0].nodeValue;
                    var ntimeHoldAmt = rowsNode[i].childNodes[15].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[15].childNodes[0].nodeValue;
                    var ntimeBfpayAmt = rowsNode[i].childNodes[16].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[16].childNodes[0].nodeValue;
                    var ntimeRlpayAmt = rowsNode[i].childNodes[17].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[17].childNodes[0].nodeValue;
                    var ntimeBalAmt = rowsNode[i].childNodes[18].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[18].childNodes[0].nodeValue;
        			
                    saleTotAmtSum += Number(saleTotAmt);
                    reduAmtSum += Number(reduAmt);
                    saleAmtSum += Number(saleAmt);
                    comisSaleAmtSum += Number(comisSaleAmt);
                    ntimePayAmtSum += Number(ntimePayAmt);
                    ntimeDedAmtSum += Number(ntimeDedAmt);
                    ntimeDedAmtSum2 += Number(ntimeDedAmt2);
                    ntimeHoldAmtSum += Number(ntimeHoldAmt);
                    ntimeBfpayAmtSum += Number(ntimeBfpayAmt);
                    ntimeRlpayAmtSum += Number(ntimeRlpayAmt);
                    ntimeBalAmtSum += Number(ntimeBalAmt);
                    
        			content += "<tr onclick='chBak3("+i+");getDetailPopUp("+i+");' style='cursor:hand;' >";
                    content += "<input type='hidden' name='m_strcd' id='m_m_strcd"+i+"' value='"+strcd+"' />";
                    content += "<input type='hidden' name='m_vencd' id='m_vencd"+i+"' value='"+vencd+"' />";
                    content += "<input type='hidden' name='m_payYM' id='m_payYM"+i+"' value='"+payYM+"' />";
                    content += "<input type='hidden' name='m_payCYC' id='m_payCYC"+i+"' value='"+payCYC+"' />";
                    content += "<input type='hidden' name='m_payCNT' id='m_payCNT"+i+"' value='"+payCNT+"' />";
                    content += "<td width='34' class='r1' id='1btdId"+i+"'>"+(i+1)+"</td>";
                    content += "<td width='79' class='r3' id='2btdId"+i+"'>"+strNm+"</td>";
                    content += "<td width='69' class='r1' id='3btdId"+i+"'>"+getDateFormat(payYM)+"</td>";
                    content += "<td width='55' class='r1' id='4btdId"+i+"'>"+payCYC+"주기</td>";
                    content += "<td width='55' class='r1' id='5btdId"+i+"'>"+payCNT+"회차</td>";
                    content += "<td width='95' class='r4' id='6btdId"+i+"'>"+convAmt(btime_bal_amt)+"</td>";
                    content += "<td width='95' class='r4' id='7btdId"+i+"'>"+convAmt(saleTotAmt)+"</td>";
                    content += "<td width='95' class='r4' id='8btdId"+i+"'>"+convAmt(reduAmt)+"</td>";
                    content += "<td width='95' class='r4' id='9btdId"+i+"'>"+convAmt(saleAmt)+"</td>";
                    content += "<td width='95' class='r4' id='10btdId"+i+"'>"+convAmt(comisSaleAmt)+"</td>";
                    content += "<td width='95' class='r4' id='11btdId"+i+"'>"+convAmt(ntimePayAmt)+"</td>";
                    content += "<td width='95' class='r4' id='12btdId"+i+"'>"+convAmt(ntimeDedAmt)+"</td>";
                    content += "<td width='95' class='r4' id='12btdId"+i+"'>"+convAmt(ntimeDedAmt2)+"</td>";
                    content += "<td width='95' class='r4' id='13btdId"+i+"'>"+convAmt(ntimeHoldAmt)+"</td>";
                    content += "<td width='95' class='r4' id='14btdId"+i+"'>"+convAmt(ntimeBfpayAmt)+"</td>";
                    content += "<td width='95' class='r4' id='15btdId"+i+"'>"+convAmt(ntimeRlpayAmt)+"</td>";
                    content += "<td width='95' class='r4' id='16btdId"+i+"'>"+convAmt(ntimeBalAmt)+"</td>";
                    content += "</tr>"; 
                    
        		}
        		
        		content += "<tr>";
                content += "<td class='sum1'>&nbsp;</td>";
                content += "<td class='sum1' colspan='5'>합계</td>";
                content += "<td class='sum2'>"+convAmt(String(saleTotAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(reduAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(saleAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(comisSaleAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntimePayAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntimeDedAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntimeDedAmtSum2))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntimeHoldAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntimeBfpayAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntimeRlpayAmtSum))+"</td>";
                content += "<td class='sum2'>"+convAmt(String(ntimeBalAmtSum))+"</td>";
                content += "</tr>";
        		
        	}
        	content += "</table>";	
        }
        else { 
            content += "<table width='1330' cellspacing='0' cellpadding='0' border='0' class='g_table'></table>"; 
        }
        
        document.getElementById("DIV_Content").innerHTML = content;
        setPorcCount("SELECT", rowsNode.length);
    </ajax:callback>
    
    
    
    
}
/**
 * getDetailPopUp()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  상세조회 팝업 생성  
 * return값 : void
 */
function getDetailPopUp( row ){
	 
	var strStrcd = document.getElementById("m_strcd"+row).value;                //점코드
	var strVencd = document.getElementById("m_vencd"+row).value;                //협력사코드
	var strPayYm = document.getElementById("m_payYM"+row).value;                //일자
	var strPayCyc = document.getElementById("m_payCYC"+row).value;              //지불주기
	var strPayCnt = document.getElementById("m_payCNT"+row).value;              //지불회차
	
	
	//var strStrcd = "01";
    //var strVencd = "000002";
    //var strPayYm = "201106";
    //var strPayCyc = "1";
    //var strPayCnt = "1";
	
	var returnVal= window.showModalDialog("/edi/epay101.ea?goTo=popPredef&strStrcd="+strStrcd+"&strVencd="+strVencd+"&strPayYm="+strPayYm+"&strPayCyc="+strPayCyc+"&strPayCnt="+strPayCnt,
								          "",
								          "dialogWidth:900px;dialogHeight:525px;scroll:no;" +
								          "resizable:no;help:no;unadorned:yes;center:yes;status:no");
	
	
}

function chBak(val) {
    g_last_row = val;
    
    if (g_pre_row != g_last_row){
        for(i=1;i<16;i++) {
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
        for(i=1;i<19;i++) {
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
        for(i=1;i<17;i++) {
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
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/> 대금지불정보</td>
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
            <th width="80">브랜드코드</th>
            <td>
                <select name="pubumCd" id="pubumCd" style="width: 132;">
                </select>
            </td>
          </tr>
          <tr>
            <th width="80">년월</th>
            <td width="210">
                <input type="text" name="sDate" id="sDate" size="10" onkeypress="javascript:onlyNumber();" onblur="dateOnblur(this);" onfocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' maxlength="6" />
                <img src="<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',sDate)" align="absmiddle" />~
                <input type="text" name="eDate" id="eDate" size="10" onkeypress="javascript:onlyNumber();" onblur="dateOnblur(this);" onfocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' maxlength="6" />
                <img src="<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',eDate)" align="absmiddle" />
                
            </td>
            <th >지불주기</th>
            <td>
                <select name="payCyc" id="payCyc" style="width: 132;">
                
                </select> 
            </td>
           <th>지불회차</th>
           <td colspan=3">
               <select name="pay_cnt" id="pay_cnt" style="width: 132;">
                
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
    <td >
    <table width="100%"  border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr valign="top">
        <td><div id="topTitle" style="width:815px;overflow:hidden;">
                <table width="1350" cellpadding="0" cellspacing="0" border="0" class="g_table" >
                    <tr>
                        <th width="34">NO</th>
                        <th width="79">점</th>
                        <th width="69">해당년월</th>
                        <th width="55">지불주기</th>
                        <th width="55">지불회차</th>
                        <th width="95">전월이월잔액</th>
                        <th width="95">공급가</th>
                        <th width="95">부가세</th>
                        <th width="95">이익액</th>
                        <th width="95">지불대상금액</th>
                        <th width="95">공제액</th>
                        <th width="95">공제금액(입금)</th>
                        <th width="95">보류액</th>
                        <th width="95">선급금액</th>
                        <th width="95">실지불액</th>
                        <th width="95">지불후잔액</th>
                        <th width="15">&nbsp;</th>
                    </tr>
                </table>
            </div>        
        </td>
      </tr>
      <tr>
          <td ><div id="DIV_Content" style="width:815px;height:460px;overflow:scroll" onscroll="scrollAll();">
                  <table width="1330" cellspacing="0" cellpadding="0" border="0" class="g_table">
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

