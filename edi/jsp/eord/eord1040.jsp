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
    String pumbunCd = sessionInfo.getPUMBUN_CD();
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
<script language="javascript" src="<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/global.js"    type="text/javascript"></script>

<script type="text/javascript">
var userid = '<%=userid%>';
var gb = '<%=gb%>';
var vencd = '<%=vencd%>';
var venNm = '<%=venNm%>';
var g_strcd = '<%=strcd%>';
var pumbunCd    = '<%=pumbunCd%>';
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
    
    /* 구분 값이 브랜드로 로그인시 "전체" 값 없음 */
    if(gb=="1"){
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "Y", pumbunCd);             //점별 브랜드	
    }else{
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "N", pumbunCd);             //점별 브랜드
    }
    
    
    
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
           emp_opt.setAttribute("value", "%");
           var emp_text = document.createTextNode("전체");
           emp_opt.appendChild(emp_text); 
           pumbun.appendChild(emp_opt);
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
        /*
    if( pumbencd.length == 0 ){
        alert("브랜드은 반드시 입력해야 합니다.");
        document.getElementById("pubumCd").focus();
        return;
    }
    */
    if( sDate.length == 0 ){
        showMessage(INFORMATION, OK, "USER-1003", "시작일");
        document.getElementById("em_S_Date").focus();
        return;
    }
    
    if( eDate.length == 0 ){
        showMessage(INFORMATION, OK, "USER-1003", "종료일");
        document.getElementById("em_E_Date").focus();
        return;
    }
    
    var em_sdate = getRawData(trim(sDate));
    var em_edate = getRawData(trim(eDate));   
    
    if (em_sdate > em_edate) { //시작일은 종료일보다 커야 합니다.
     
    	showMessage(StopSign, OK, "USER-1008", "종료일", "시작일");
        document.getElementById("em_S_Date").focus();
        return;
    }
    g_last_row = -1;
    g_pre_row = -1;
   // chBak();
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
	 

    // 스크롤 위치 초기화     
    document.all.DIV_TITLE.scrollLeft = 0;
    document.all.DETAIL_TITLE.scrollLeft = 0; 
    document.all.DIV_Content.scrollLeft = 0;
    document.all.DETAIL_CONTETN.scrollLeft = 0; 
    
    var strStrcd = document.getElementById("strcd").value;
    var strVencd = document.getElementById("vencd").value;
    var strPumbuncd = document.getElementById("pubumCd").value;
    var strSlipFlag = document.getElementById("in_slip_flag").value;
    var strShGb = document.getElementsByName("sh_gb")[1].checked == true ? "2" : "1";
    var sDate = getRawData(trim(document.getElementById("em_S_Date").value));
    var eDate = getRawData(trim(document.getElementById("em_E_Date").value));
    
    var de_content = "<table width='798' border='0' cellspacing='0' cellpadding='0' class='g_table'></table>";
    document.getElementById("DETAIL_CONTETN").innerHTML = de_content;
     
    var param = "&goTo=getMaster&strStrcd="+ strStrcd
                                           + "&strVencd=" + strVencd 
                                           + "&strPumbuncd=" + strPumbuncd
                                           + "&strSlipFlag=" + strSlipFlag
                                           + "&strShGb=" + strShGb
                                           + "&sDate=" + sDate
                                           + "&eDate=" + eDate;    
    
    
    <ajax:open callback="on_SearchXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/eord104.eo"/>
        

    <ajax:callback function="on_SearchXML"> 
    
       var Master_content = "";
       if( rowsNode.length > 0 ){
           var m_ordtot = 0;
           var m_ordNewCost = 0;
           var m_ordNewSale = 0;
           var m_chkTot = 0;
           var m_chkTotCost = 0;
           var m_chkTotSale = 0;
           
           Master_content += "<table width='1060' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
           
           
           for( i =0; i < rowsNode.length; i++ ){
               var m_slipNo = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
               var m_ordDt = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
               var m_strcd = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
               var m_strNm = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
               var m_pumbun_cd = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
               var m_pumbunNm = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
               var m_slipFlag = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
               var m_slipFlagNm = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
               var m_slipProcStat = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
               var m_slipProcStatNm = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
               var m_chkDt = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
               var m_ordTotQty = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
               var m_newCostTamt = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
               var m_newSaleTamt = rowsNode[i].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[13].childNodes[0].nodeValue;
               var m_chkTotQty = rowsNode[i].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[14].childNodes[0].nodeValue;
               var m_chkCostTamt = rowsNode[i].childNodes[15].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[15].childNodes[0].nodeValue;
               var m_chkSaleTamt = rowsNode[i].childNodes[16].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[16].childNodes[0].nodeValue;
               var m_sku_flag = rowsNode[i].childNodes[17].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[17].childNodes[0].nodeValue;
               
               m_ordtot +=  Number(m_ordTotQty);
               m_ordNewCost += Number(m_newCostTamt);
               m_ordNewSale += Number(m_newSaleTamt);
               m_chkTot += Number(m_chkTotQty);
               m_chkTotCost += Number(m_chkCostTamt);
               m_chkTotSale += Number(m_chkSaleTamt);
               
               Master_content += "<tr onclick='chBak("+i+");getDetail("+i+");' style='cursor:hand;' >";
               Master_content += "<input type='hidden' name='m_slipNo' id='m_slipNo"+i+"' value='"+m_slipNo+"' />";
               Master_content += "<input type='hidden' name='m_strcd' id='m_strcd"+i+"' value='"+m_strcd+"' />";
               Master_content += "<input type='hidden' name='m_sku_flag' id='m_sku_flag"+i+"' value='"+m_sku_flag+"' />";
               Master_content += "<td width='25' id='1tdId"+i+"' class='r1'>"+(i+1)+"</td>";
               Master_content += "<td width='75' id='2tdId"+i+"' class='r1'>"+getDateFormat(m_ordDt)+"</td>";
               Master_content += "<td width='65' id='3tdId"+i+"' class='r3'>"+m_strNm+"</td>";
               Master_content += "<td width='75' id='4tdId"+i+"' class='r3'>"+m_pumbunNm+"</td>";
               Master_content += "<td width='55' id='5tdId"+i+"' class='r3'>"+m_slipFlagNm+"</td>";
               Master_content += "<td width='75' id='6tdId"+i+"' class='r3'>"+m_slipProcStatNm+"</td>";
               Master_content += "<td width='75' id='7tdId"+i+"' class='r1'>"+m_slipNo+"</td>";
               if( m_chkDt != "" ){
                   Master_content += "<td width='75' id='8tdId"+i+"' class='r1'>"+getDateFormat(m_chkDt)+"</td>";      
               } else {
                   Master_content += "<td width='75' id='8tdId"+i+"' class='r1'>"+m_chkDt+"</td>";
               }
               
               Master_content += "<td width='45' id='9tdId"+i+"' class='r4'>"+convAmt(m_ordTotQty)+"</td>";
               Master_content += "<td width='95' id='10tdId"+i+"' class='r4'>"+convAmt(m_newCostTamt)+"</td>";
               Master_content += "<td width='95' id='11tdId"+i+"' class='r4'>"+convAmt(m_newSaleTamt)+"</td>";
               Master_content += "<td width='45' id='12tdId"+i+"' class='r4'>"+convAmt(m_chkTotQty)+"</td>";
               Master_content += "<td width='95' id='13tdId"+i+"' class='r4'>"+convAmt(m_chkCostTamt)+"</td>";
               Master_content += "<td width='95' id='14tdId"+i+"' class='r4'>"+convAmt(m_chkSaleTamt)+"</td>";
               Master_content += "</tr>";
               
           }
           
           Master_content += "<tr>";
           Master_content += "<td colspan='8' class='sum1'>합계</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(m_ordtot))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(m_ordNewCost))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(m_ordNewSale))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(m_chkTot))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(m_chkTotCost))+"</td>";
           Master_content += "<td class='sum2' >"+convAmt(String(m_chkTotSale))+"</td>";
           Master_content += "</tr>";
               
           Master_content += "</table>";
           
           document.getElementById("DIV_Content").innerHTML = Master_content;
           setPorcCount("SELECT", rowsNode.length);  
           
           // 2011.07.15 kjm 추가
           // 조회버튼 클릭시 하단그리드도 같이 조회
           chBak(0);
           getDetail2(0); 
          

       } else {  
    	   Master_content += "<table width='1060' border='0' cellspacing='0' cellpadding='0' class='g_table'></table>"; 
           document.getElementById("DIV_Content").innerHTML = Master_content;

           setPorcCount("SELECT", 0);  
       }
       
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
    var m_strcd = document.getElementById("m_strcd"+row).value;        //점코드
    var m_slipNo = document.getElementById("m_slipNo"+row).value;      //전표번호
    var m_sku_flag = document.getElementById("m_sku_flag"+row).value;  //단품구분
    
    var de_title = "";
    if( m_sku_flag == "1" ){       //단품
        
        de_title += "<table width='994' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
        de_title += "<tr>";
        de_title += "<th width='34' rowspan='2'>NO</th>";
        de_title += "<th width='200' rowspan='2'>단품코드</th>";
        de_title += "<th width='45' rowspan='2'>마진율</th>";
        de_title += "<th rowspan='2' width='85'>원가단가 </th>";
        de_title += "<th rowspan='2' width='85'>매가단가 </th>";
        de_title += "<th colspan='3' width='195'>발주</th>";
        de_title += "<th colspan='3' width='195'>매입확정</th>"
        de_title += "<th rowspan='2' width='15'>&nbsp;</th>"; 
        de_title += "</tr>";
        de_title += "<tr>";
        de_title += "<th width='45'>수량</th>";
        de_title += "<th width='95'>원가금액</th>";
        de_title += "<th width='95'>매가금액</th>";
        de_title += "<th width='45'>수량</th>";
        de_title += "<th width='95'>원가금액</th>";
        de_title += "<th width='95'>매가금액</th>";
        de_title += "</tr>";
        de_title += "</table>";
    } else if( m_sku_flag == "2" ){//품목
        de_title += "<table width='994' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
        de_title += "<tr>";
        de_title += "<th width='34' rowspan='2'>NO</th>";
        de_title += "<th width='200' rowspan='2'>품목코드</th>";
        de_title += "<th width='45' rowspan='2'>마진율</th>";
        de_title += "<th rowspan='2' width='85'>원가단가 </th>";
        de_title += "<th rowspan='2' width='85'>매가단가 </th>";
        de_title += "<th colspan='3' width='195'>발주</th>";
        de_title += "<th colspan='3' width='195'>매입확정</th>"
        de_title += "<th rowspan='2' width='15'>&nbsp;</th>"; 
        de_title += "</tr>";
        de_title += "<tr>";
        de_title += "<th width='45'>수량</th>";
        de_title += "<th width='95'>원가금액</th>";
        de_title += "<th width='95'>매가금액</th>";
        de_title += "<th width='45'>수량</th>";
        de_title += "<th width='95'>원가금액</th>";
        de_title += "<th width='95'>매가금액</th>";
        de_title += "</tr>";
        de_title += "</table>";
    }
    document.getElementById("DETAIL_TITLE").innerHTML = de_title;
    
    var param = "&goTo=getDetail&strcd=" + m_strcd
                                        + "&slipNo=" +  m_slipNo;
    
    <ajax:open callback="on_DetailSearchXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/eord104.eo"/>
        

    <ajax:callback function="on_DetailSearchXML">
        
        var d_content = "";
        if( rowsNode.length > 0 ){
            var d_ordQtySum = 0;
            var d_new_costSum = 0;
            var d_new_saleSum = 0;
            var d_chkQtySum = 0;
            var d_chk_costSum = 0;
            var d_chk_saleSum = 0;
            
            d_content += "<table width='974' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
            
            for(i = 0; i < rowsNode.length; i++){
                var d_strcd = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                var d_pummokcd = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                var d_pummokNm = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
                var d_sku_cd = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                var d_sku_nm = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
                var d_mg_rate = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
                var d_new_cost_prc = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
                var d_new_sale_prc = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
                var d_ord_qty = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
                var d_new_cost_amt = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
                var d_new_sale_amt = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
                var d_chk_qty = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
                var d_chk_cost_amt = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
                var d_chk_sale_amt = rowsNode[i].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[13].childNodes[0].nodeValue;
                
                d_ordQtySum += Number(d_ord_qty);
                d_new_costSum += Number(d_new_cost_amt);
                d_new_saleSum += Number(d_new_sale_amt);
                d_chkQtySum += Number(d_chk_qty);
                d_chk_costSum += Number(d_chk_cost_amt);
                d_chk_saleSum += Number(d_chk_sale_amt);
                
                
                
                d_content += "<tr  onclick='chBak2("+i+");' style='cursor:hand;' >";
                d_content += "<td class='r1' width='34' id='1tdId2"+i+"'>"+(i+1)+"</td>";
                if( m_sku_flag == "2" ){
                    var pummokSum = d_pummokcd+"-"+d_pummokNm;
                    
                    if( pummokSum.length > 22 ){
                        pummokSum = pummokSum.substring(0,22) + " ..";
                    }
                    d_content += "<td class='r3' width='200' id='2tdId2"+i+"' title='"+d_pummokcd+"-"+d_pummokNm+"'>"+pummokSum+"</td>";
                } else {
                    var danpumSum = d_sku_cd+"-"+d_sku_nm;
                    if( danpumSum.length > 22 ){
                        danpumSum = danpumSum.substring(0,22) + " ..";
                    }
                    d_content += "<td class='r3' width='200' id='2tdId2"+i+"' title='"+d_sku_cd+"-"+d_sku_nm+"'>"+danpumSum+"</td>";
                }
                d_content += "<td class='r4' width='45' id='3tdId2"+i+"'>"+d_mg_rate+"</td>";
                d_content += "<td class='r4' width='85' id='4tdId2"+i+"'>"+convAmt(d_new_cost_prc)+"</td>";
                d_content += "<td class='r4' width='85' id='5tdId2"+i+"'>"+convAmt(d_new_sale_prc)+"</td>";
                d_content += "<td class='r4' width='45' id='6tdId2"+i+"'>"+convAmt(d_ord_qty)+"</td>";
                d_content += "<td class='r4' width='95' id='7tdId2"+i+"'>"+convAmt(d_new_cost_amt)+"</td>";
                d_content += "<td class='r4' width='95' id='8tdId2"+i+"'>"+convAmt(d_new_sale_amt)+"</td>";
                d_content += "<td class='r4' width='45' id='9tdId2"+i+"' >"+convAmt(d_chk_qty)+"</td>";
                d_content += "<td class='r4' width='95' id='10tdId2"+i+"'>"+convAmt(d_chk_cost_amt)+"</td>";
                d_content += "<td class='r4' width='95' id='11tdId2"+i+"'>"+convAmt(d_chk_sale_amt)+"</td>";
                d_content += "</tr>";
            }
            
            d_content += "<tr>";
            d_content += "<td colspan='5' class='sum1'>합계</td>";
            d_content += "<td class='sum2' >"+convAmt(String(d_ordQtySum))+"</td>";
            d_content += "<td class='sum2' >"+convAmt(String(d_new_costSum))+"</td>";
            d_content += "<td class='sum2' >"+convAmt(String(d_new_saleSum))+"</td>";
            d_content += "<td class='sum2' >"+convAmt(String(d_chkQtySum))+"</td>";
            d_content += "<td class='sum2' >"+convAmt(String(d_chk_costSum))+"</td>";
            d_content += "<td class='sum2' >"+convAmt(String(d_chk_saleSum))+"</td>";
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
    var m_strcd = document.getElementById("m_strcd"+row).value;        //점코드
    var m_slipNo = document.getElementById("m_slipNo"+row).value;      //전표번호
    var m_sku_flag = document.getElementById("m_sku_flag"+row).value;  //단품구분
    
    var de_title = "";
    if( m_sku_flag == "1" ){       //단품
        
        de_title += "<table width='994' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
        de_title += "<tr>";
        de_title += "<th width='34' rowspan='2'>NO</th>";
        de_title += "<th width='200' rowspan='2'>단품코드</th>";
        de_title += "<th width='45' rowspan='2'>마진율</th>";
        de_title += "<th rowspan='2' width='85'>원가단가 </th>";
        de_title += "<th rowspan='2' width='85'>매가단가 </th>";
        de_title += "<th colspan='3' width='195'>발주</th>";
        de_title += "<th colspan='3' width='195'>매입확정</th>"
        de_title += "<th rowspan='2' width='15'>&nbsp;</th>"; 
        de_title += "</tr>";
        de_title += "<tr>";
        de_title += "<th width='45'>수량</th>";
        de_title += "<th width='95'>원가금액</th>";
        de_title += "<th width='95'>매가금액</th>";
        de_title += "<th width='45'>수량</th>";
        de_title += "<th width='95'>원가금액</th>";
        de_title += "<th width='95'>매가금액</th>";
        de_title += "</tr>";
        de_title += "</table>";
    } else if( m_sku_flag == "2" ){//품목
        de_title += "<table width='994' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
        de_title += "<tr>";
        de_title += "<th width='34' rowspan='2'>NO</th>";
        de_title += "<th width='200' rowspan='2'>품목코드</th>";
        de_title += "<th width='45' rowspan='2'>마진율</th>";
        de_title += "<th rowspan='2' width='85'>원가단가 </th>";
        de_title += "<th rowspan='2' width='85'>매가단가 </th>";
        de_title += "<th colspan='3' width='195'>발주</th>";
        de_title += "<th colspan='3' width='195'>매입확정</th>"
        de_title += "<th rowspan='2' width='15'>&nbsp;</th>"; 
        de_title += "</tr>";
        de_title += "<tr>";
        de_title += "<th width='45'>수량</th>";
        de_title += "<th width='95'>원가금액</th>";
        de_title += "<th width='95'>매가금액</th>";
        de_title += "<th width='45'>수량</th>";
        de_title += "<th width='95'>원가금액</th>";
        de_title += "<th width='95'>매가금액</th>";
        de_title += "</tr>";
        de_title += "</table>";
    }
    document.getElementById("DETAIL_TITLE").innerHTML = de_title;
    
    var param = "&goTo=getDetail&strcd=" + m_strcd
                                        + "&slipNo=" +  m_slipNo;
    
    <ajax:open callback="on_DetailSearchXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/eord104.eo"/>
        

    <ajax:callback function="on_DetailSearchXML">
        
        var d_content = "";
        if( rowsNode.length > 0 ){
            var d_ordQtySum = 0;
            var d_new_costSum = 0;
            var d_new_saleSum = 0;
            var d_chkQtySum = 0;
            var d_chk_costSum = 0;
            var d_chk_saleSum = 0;
            
            d_content += "<table width='974' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
            
            for(i = 0; i < rowsNode.length; i++){
                var d_strcd = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                var d_pummokcd = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                var d_pummokNm = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
                var d_sku_cd = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                var d_sku_nm = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
                var d_mg_rate = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
                var d_new_cost_prc = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
                var d_new_sale_prc = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
                var d_ord_qty = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
                var d_new_cost_amt = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
                var d_new_sale_amt = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
                var d_chk_qty = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
                var d_chk_cost_amt = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
                var d_chk_sale_amt = rowsNode[i].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[13].childNodes[0].nodeValue;
                
                d_ordQtySum += Number(d_ord_qty);
                d_new_costSum += Number(d_new_cost_amt);
                d_new_saleSum += Number(d_new_sale_amt);
                d_chkQtySum += Number(d_chk_qty);
                d_chk_costSum += Number(d_chk_cost_amt);
                d_chk_saleSum += Number(d_chk_sale_amt);
                
                
                
                d_content += "<tr  onclick='chBak2("+i+");' style='cursor:hand;' >";
                d_content += "<td class='r1' width='34' id='1tdId2"+i+"'>"+(i+1)+"</td>";
                if( m_sku_flag == "2" ){
                    var pummokSum = d_pummokcd+"-"+d_pummokNm;
                    
                    if( pummokSum.length > 22 ){
                        pummokSum = pummokSum.substring(0,22) + " ..";
                    }
                    d_content += "<td class='r3' width='200' id='2tdId2"+i+"' title='"+d_pummokcd+"-"+d_pummokNm+"'>"+pummokSum+"</td>";
                } else {
                    var danpumSum = d_sku_cd+"-"+d_sku_nm;
                    if( danpumSum.length > 22 ){
                        danpumSum = danpumSum.substring(0,22) + " ..";
                    }
                    d_content += "<td class='r3' width='200' id='2tdId2"+i+"' title='"+d_sku_cd+"-"+d_sku_nm+"'>"+danpumSum+"</td>";
                }
                d_content += "<td class='r4' width='45' id='3tdId2"+i+"'>"+d_mg_rate+"</td>";
                d_content += "<td class='r4' width='85' id='4tdId2"+i+"'>"+convAmt(d_new_cost_prc)+"</td>";
                d_content += "<td class='r4' width='85' id='5tdId2"+i+"'>"+convAmt(d_new_sale_prc)+"</td>";
                d_content += "<td class='r4' width='45' id='6tdId2"+i+"'>"+convAmt(d_ord_qty)+"</td>";
                d_content += "<td class='r4' width='95' id='7tdId2"+i+"'>"+convAmt(d_new_cost_amt)+"</td>";
                d_content += "<td class='r4' width='95' id='8tdId2"+i+"'>"+convAmt(d_new_sale_amt)+"</td>";
                d_content += "<td class='r4' width='45' id='9tdId2"+i+"' >"+convAmt(d_chk_qty)+"</td>";
                d_content += "<td class='r4' width='95' id='10tdId2"+i+"'>"+convAmt(d_chk_cost_amt)+"</td>";
                d_content += "<td class='r4' width='95' id='11tdId2"+i+"'>"+convAmt(d_chk_sale_amt)+"</td>";
                d_content += "</tr>";
            }
            
            d_content += "<tr>";
            d_content += "<td colspan='5' class='sum1'>합계</td>";
            d_content += "<td class='sum2' >"+convAmt(String(d_ordQtySum))+"</td>";
            d_content += "<td class='sum2' >"+convAmt(String(d_new_costSum))+"</td>";
            d_content += "<td class='sum2' >"+convAmt(String(d_new_saleSum))+"</td>";
            d_content += "<td class='sum2' >"+convAmt(String(d_chkQtySum))+"</td>";
            d_content += "<td class='sum2' >"+convAmt(String(d_chk_costSum))+"</td>";
            d_content += "<td class='sum2' >"+convAmt(String(d_chk_saleSum))+"</td>";
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
        for(i=1;i<15;i++) {
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
        for(i=1;i<12;i++) {
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
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>발주매입조회</td>
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
            <th width="80">브랜드코드</th>
            <td>
                <select name="pubumCd" id="pubumCd" style="width: 203;">
                
                </select>
            </td>
          </tr>
          <tr>
            <th >전표구분</th>
            <td>
                <select id="in_slip_flag" name="in_slip_flag" style="width: 132;">
                        <option value="%">전체</option>
                        <option value="A">매입</option>
                        <option value="B">반품</option>
                </select>
            </td>
            <th >조회구분</th>
            <td>
                <input  type="radio" name="sh_gb" id="sh_gb" size="15" checked="checked" value="1"/>발주확정
                <input  type="radio" name="sh_gb" id="sh_gb" size="15" value="2" />검품확정
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
                    <table width="1080" border="0" cellspacing="0" cellpadding="0" class="g_table"> 
                                <tr>
                                  <th  rowspan="2" width="25">No</th>
                                  <th rowspan="2" width="75">발주일자</th>
                                  <th rowspan="2" width="65">점</th>
                                  <th rowspan="2" width="75">브랜드</th>
                                  <th rowspan="2" width="55">전표구분</th>
                                  <th rowspan="2" width="75">전표상태</th>
                                  <th rowspan="2" width="75">전표번호</th>
                                  <th rowspan="2" width="75">검품확정</th>
                                  <th colspan="3" width="235">발주</th>
                                  <th colspan="3" width="235">매입확정</th>
                                  <th rowspan="2" width="15">&nbsp;</th>
                                </tr>
                                <tr>
                                      <th width="45">수량</th>
                                      <th width="95">원가금액</th>
                                      <th width="95">매가금액</th>
                                      <th width="45">수량</th>
                                      <th width="95">원가금액</th>
                                      <th width="95">매가금액</th>
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
                        <table width="994" border="0" cellspacing="0" cellpadding="0" class="g_table">
                            <tr>
                                <th width="34" rowspan="2"  >NO </th>
                                <th width="200" rowspan="2">품목코드</th>
                                <th width="45" rowspan="2">마진율</th>
                                <th rowspan="2" width="85">원가단가 </th>
                                <th rowspan="2" width="85">매가단가 </th>
                                <th colspan="3" width="235">발주</th>
                                <th colspan="3" width="235">매입확정</th>
                                <th rowspan="2" width="15">&nbsp;</th>
                              </tr>
                              <tr>
                                <th width="45">수량</th>
                                <th width="95">원가금액</th>
                                <th width="95">매가금액</th>
                                <th width="45">수량</th>
                                <th width="95">원가금액</th>
                                <th width="95">매가금액</th>
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

