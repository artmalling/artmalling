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
<script language="javascript"  src="<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/popup.js"     type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/global.js"    type="text/javascript"></script>
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
var g_pre_row2  = -1;
var g_last_row2 = -1;
var pumbunNm    = '<%=pumbunNm%>';
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
    enableControl(del   ,false);      //삭제
    enableControl(save  ,false);     //저장
    enableControl(excel,true);    //엑셀
    enableControl(prints,false);    //프린터
    enableControl(set   ,false);    //프린터
    
    /*  조회 항목  */
    initDateText('SYYYYMMDD', 'em_S_Date');    //시작일
    initDateText("TODAY"    , "em_E_Date");        //종료일
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
 * 개    요 :  조회
 * return값 : void
 */ 
function btn_Sch(){
    var sDate = document.getElementById("em_S_Date").value;
    var eDate = document.getElementById("em_E_Date").value;
       
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
    
    getSearch();
}

/**
 * getSearch()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  마스터조회
 * return값 : void
 */ 
function getSearch(){

     g_row          = -1;
     g_pre_row      = -1;
    var strStrcd    = document.getElementById("strcd").value;
    var strVencd    = document.getElementById("vencd").value;
    var strPumbuncd = document.getElementById("pubumCd").value;
    var sDate       = getRawData(trim(document.getElementById("em_S_Date").value));
    var eDate       = getRawData(trim(document.getElementById("em_E_Date").value));
    
    var param = "&goTo=getMaster" + "&strcd=" + strStrcd
                                  + "&vencd=" + strVencd
                                  + "&strPumbuncd=" + strPumbuncd
                                  + "&sDate=" + sDate
                                  + "&eDate=" + eDate;
    
    <ajax:open callback="on_SearchXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/esal101.es"/>
        

    <ajax:callback function="on_SearchXML">

       // document.getElementById("DETAIL_CONTETN").innerHTML = "<table width='795' border='0' cellspacing='0' cellpadding='0' class='g_table'></table>";
       //document.getElementById("DETAIL_CONTETN").innerHTML = "<table width='845' border='0' cellspacing='0' cellpadding='0' class='g_table'></table>";
       //document.getElementById("DETAIL_CONTETN").innerHTML = "<table width='860' border='0' cellspacing='0' cellpadding='0' class='g_table'></table>";
       //document.getElementById("DETAIL_CONTETN").innerHTML = "<table width='845' border='0' cellspacing='0' cellpadding='0' class='g_table'></table>";
        var master_content = "";
        
        if( rowsNode.length > 0 ) {
            
            var saleQtySum      = 0;
            var totSaleAmtSum   = 0;
            var dcAmtSum        = 0;
            var reduAmtSum      = 0;
            var netSaleAmtSum   = 0;
            var saleAmtSum      = 0;
            /*
             master_content += "<table width='795' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
            */
            /*
            master_content += "<table width='845' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
            */
            master_content += "<table width='880' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
            for( i = 0; i < rowsNode.length; i++ ){
                /* 
                    2011.10.03 
                       - 매출일자 점 브랜드 매출수량 할인 매출(총매출-할인) 에누리 순매출 총매출
                       - ChildNodes Number Setting
                */
                /*
                var m_strcd        = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                var m_strNm        = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                var m_sale_dt      = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
                var m_pumbuncd     = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                var m_pumbunNm     = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
                var m_sale_qty     = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
                var m_tot_sale_amt = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
                var m_dc_amt       = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
                var m_redu_amt     = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
                var m_net_sale_amt = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
                var m_sale_amt     = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
                */
                /*
                var m_strcd        = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                var m_strNm        = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                var m_sale_dt      = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
                var m_pumbuncd     = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                var m_pumbunNm     = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
                var m_sale_qty     = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
                var m_redu_amt     = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
                var m_sale_amt     = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
                var m_dc_amt       = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
                var m_net_sale_amt = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
                var m_tot_sale_amt = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
                */
                /*
                    2011.10.08
                    매출일자    점   브랜드  매출수량    매출  에누리 순매출 할인  총매출
                */
                var m_strcd        = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                var m_strNm        = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                var m_sale_dt      = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
                var m_pumbuncd     = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                var m_pumbunNm     = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
                var m_sale_qty     = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
                var m_sale_amt     = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
                var m_dc_amt       = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
                var m_net_sale_amt = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
                var m_redu_amt     = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
                var m_tot_sale_amt = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
                
                saleQtySum     += Number(m_sale_qty);
                totSaleAmtSum  += Number(m_tot_sale_amt);
                dcAmtSum       += Number(m_dc_amt);
                reduAmtSum     += Number(m_redu_amt);
                netSaleAmtSum  += Number(m_net_sale_amt);
                saleAmtSum     += Number(m_sale_amt);
                /*
                master_content += "<tr onclick='chBak("+i+");getDetail("+i+");' style='cursor:hand;'>";
                master_content += "<input type='hidden' name='m_strcd' id='m_strcd"+i+"' value='"+m_strcd+"' />";
                master_content += "<input type='hidden' name='m_pumbuncd' id='m_pumbuncd"+i+"' value='"+m_pumbuncd+"' />";
                master_content += "<input type='hidden' name='m_sale_dt' id='m_sale_dt"+i+"' value='"+m_sale_dt+"' />";
                master_content += "<td width='45' class='r1' id='1tdId"+i+"' >"+(i+1)+"</td>";
                master_content += "<td width='95' class='r1' id='2tdId"+i+"'>"+getDateFormat(m_sale_dt)+"</td>";
                master_content += "<td width='75' class='r1' id='3tdId"+i+"'>"+m_strNm+"</td>";
                master_content += "<td width='90' class='r3' id='4tdId"+i+"'>"+m_pumbunNm+"</td>";
                master_content += "<td width='85' class='r4' id='5tdId"+i+"'>"+convAmt(m_sale_qty)+"</td>";
                master_content += "<td width='90' class='r4' id='6tdId"+i+"'>"+convAmt(m_tot_sale_amt)+"</td>";
                master_content += "<td width='90' class='r4' id='7tdId"+i+"'>"+convAmt(m_dc_amt)+"</td>";
                master_content += "<td width='90' class='r4' id='8tdId"+i+"'>"+convAmt(m_redu_amt)+"</td>";
                master_content += "<td width='90' class='r4' id='9tdId"+i+"'>"+convAmt(m_net_sale_amt)+"</td>";
                */
                /* 
                   2011.10.03 
                   매출일자 점 브랜드 매출수량 할인 매출(총매출-할인) 에누리 순매출 총매출 
                */
                /*
                master_content += "<tr onclick='chBak("+i+");getDetail("+i+");' style='cursor:hand;'>";
                master_content += "<input type='hidden' name='m_strcd' id='m_strcd"+i+"' value='"+m_strcd+"' />";
                master_content += "<input type='hidden' name='m_pumbuncd' id='m_pumbuncd"+i+"' value='"+m_pumbuncd+"' />";
                master_content += "<input type='hidden' name='m_sale_dt' id='m_sale_dt"+i+"' value='"+m_sale_dt+"' />";
                master_content += "<td width='47' class='r1' id='1tdId"+i+"'>"+(i+1)+                   "</td>";
                master_content += "<td width='95' class='r1' id='2tdId"+i+"'>"+getDateFormat(m_sale_dt)+"</td>";
                master_content += "<td width='78' class='r1' id='3tdId"+i+"'>"+m_strNm+                 "</td>";
                master_content += "<td width='94' class='r3' id='4tdId"+i+"'>"+m_pumbunNm+              "</td>";
                master_content += "<td width='90' class='r4' id='5tdId"+i+"'>"+convAmt(m_sale_qty)+     "</td>";
                master_content += "<td width='90' class='r4' id='6tdId"+i+"'>"+convAmt(m_redu_amt)+     "</td>";
                master_content += "<td width='90' class='r4' id='7tdId"+i+"'>"+convAmt(m_sale_amt)+     "</td>";
                master_content += "<td width='90' class='r4' id='8tdId"+i+"'>"+convAmt(m_dc_amt)+       "</td>";
                master_content += "<td width='88' class='r4' id='9tdId"+i+"'>"+convAmt(m_net_sale_amt)+ "</td>";
                master_content += "<td width='90' class='r4' id='10tdId"+i+"'>"+convAmt(m_tot_sale_amt)+"</td>";
                */
                /*
                    2011.10.08
                    매출일자    점   브랜드  매출수량    매출  에누리 순매출 할인  총매출
                */
                master_content += "<tr onclick='chBak("+i+");getDetail2("+i+");' style='cursor:hand;'>";
                master_content += "<input type='hidden' name='m_strcd' id='m_strcd"+i+"' value='"+m_strcd+"' />";
                master_content += "<input type='hidden' name='m_pumbuncd' id='m_pumbuncd"+i+"' value='"+m_pumbuncd+"' />";
                master_content += "<input type='hidden' name='m_sale_dt' id='m_sale_dt"+i+"' value='"+m_sale_dt+"' />";
                master_content += "<td width='45' class='r1' id='1tdId"+i+"'>"+(i+1)+                   "</td>";
                master_content += "<td width='95' class='r1' id='2tdId"+i+"'>"+getDateFormat(m_sale_dt)+"</td>";
                master_content += "<td width='75' class='r3' id='3tdId"+i+"'>"+m_strNm+                 "</td>";
                master_content += "<td width='90' class='r3' id='4tdId"+i+"'>"+m_pumbunNm+              "</td>";
                master_content += "<td width='85' class='r4' id='5tdId"+i+"'>"+convAmt(m_sale_qty)+     "</td>";
                master_content += "<td width='90' class='r4' id='6tdId"+i+"'>"+convAmt(m_sale_amt)+     "</td>";
                master_content += "<td width='90' class='r4' id='7tdId"+i+"'>"+convAmt(m_redu_amt)+     "</td>";
                master_content += "<td width='90' class='r4' id='8tdId"+i+"'>"+convAmt(m_net_sale_amt)+ "</td>";
                master_content += "<td width='90' class='r4' id='9tdId"+i+"'>"+convAmt(m_dc_amt)+       "</td>";
                master_content += "<td width='90' class='r4' id='10tdId"+i+"'>"+convAmt(m_tot_sale_amt)+"</td>";
                
                master_content += "</tr>";
                
            }
            master_content += "<tr>";
            master_content += "<td class='sum1' colspan='4'>합계</td>";
            master_content += "<td class='sum2'>"+convAmt(String(saleQtySum))+"</td>";
            master_content += "<td class='sum2'>"+convAmt(String(saleAmtSum ))+"</td>";
            master_content += "<td class='sum2'>"+convAmt(String(reduAmtSum))+"</td>";
            master_content += "<td class='sum2'>"+convAmt(String(netSaleAmtSum))+"</td>";
            master_content += "<td class='sum2'>"+convAmt(String(dcAmtSum))+"</td>";
            master_content += "<td class='sum2'>"+convAmt(String(totSaleAmtSum))+"</td>";
            master_content += "</tr>";
            master_content += "</table>";
            
            
        }
        document.getElementById("DIV_Content").innerHTML = master_content;
        setPorcCount("SELECT", rowsNode.length);  

        // 2011.07.15 kjm 추가
        // 조회버튼 클릭시 하단그리드도 같이 조회
        chBak(0);
        getDetail2(0);
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
     var strStrcd = document.getElementById("m_strcd"+row).value;
     var strPumbun = document.getElementById("m_pumbuncd"+row).value;
     var strSaleDt = document.getElementById("m_sale_dt"+row).value;
     
     
      
     var param = "&goTo=getDetail" + "&strcd=" + strStrcd
                                   + "&strSaleDt=" + strSaleDt
                                   + "&strPumbuncd=" + strPumbun;
                                   
     
     <ajax:open callback="on_getDetailXML" 
                         param="param" 
                         method="POST" 
                         urlvalue="/edi/esal101.es"/>
     
     
     <ajax:callback function="on_getDetailXML">
         
          var d_content = "";
         if( rowsNode.length > 0 ){
             
             var saleQtySum = 0;
             var totSaleAmtSum = 0;
             var dcAmtSum = 0;
             var reduAmtSum = 0;
             var netSaleAmtSum = 0;
             var saleAmtSum = 0;
             //d_content += "<table width='795' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
             d_content += "<table width='877' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
             
             for( i = 0; i < rowsNode.length; i++ ){
                 
                 var pummokcd    = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                 var pummokNm    = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                 var eventFlag   = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
                 var EventRate   = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                 var saleQty     = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
                 var saleAmt     = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
                 var dcAmt       = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
                 var netSaleAmt  = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;                 
                 var reduAmt     = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
                 var totSaleAmt  = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
                 
                 var pummokSum = pummokcd + "-" +pummokNm;
                 if( pummokSum.length > 11 ){
                     pummokSum = pummokSum.substring(0,11)+" ..";
                 }
                 
                 saleQtySum      += Number(saleQty);
                 totSaleAmtSum   += Number(totSaleAmt);
                 dcAmtSum        += Number(dcAmt);
                 reduAmtSum      += Number(reduAmt);
                 netSaleAmtSum   += Number(netSaleAmt);
                 saleAmtSum      += Number(saleAmt);
                 /*
                 d_content += "<tr onclick='chBak2("+i+");' style='cursor:hand;'>";
                 d_content += "<td width='45' class='r1' id='1tdId2"+i+"'>"+(i+1)+"</td>";
                 d_content += "<td width='100' title='"+pummokcd+"-"+pummokNm+"' class='r1' id='2tdId2"+i+"' >"+pummokSum+"</td>";
                 d_content += "<td width='75' class='r4' id='3tdId2"+i+"'>"+eventFlag+"</td>";
                 d_content += "<td width='85' class='r4' id='4tdId2"+i+"'>"+EventRate+"%</td>";
                 d_content += "<td width='85' class='r4' id='5tdId2"+i+"'>"+convAmt(saleQty)+"</td>";
                 d_content += "<td width='90' class='r4' id='6tdId2"+i+"'>"+convAmt(totSaleAmt)+"</td>";
                 d_content += "<td width='90' class='r4' id='7tdId2"+i+"'>"+convAmt(dcAmt)+"</td>";
                 d_content += "<td width='90' class='r4' id='8tdId2"+i+"'>"+convAmt(reduAmt)+"</td>";
                 d_content += "<td width='90' class='r4' id='9tdId2"+i+"'>"+convAmt(netSaleAmt)+"</td>";
                 */
                 d_content += "<tr onclick='chBak2("+i+");' style='cursor:hand;'>";
                 d_content += "<td width='45' class='r1' id='1tdId2"+i+"'>"+(i+1)+"</td>";
                 d_content += "<td width='95' title='"+pummokcd+"-"+pummokNm+"' class='r1' id='2tdId2"+i+"' >"+pummokSum+"</td>";
                 d_content += "<td width='75' class='r4' id='3tdId2" +i+"'>"+eventFlag+"</td>";
                 d_content += "<td width='90' class='r4' id='4tdId2" +i+"'>"+EventRate+"%</td>";
                 d_content += "<td width='85' class='r4' id='5tdId2" +i+"'>"+convAmt(saleQty)+"</td>";
                 d_content += "<td width='90' class='r4' id='6tdId2" +i+"'>"+convAmt(saleAmt)+"</td>";
                 d_content += "<td width='90' class='r4' id='7tdId2" +i+"'>"+convAmt(dcAmt)+"</td>";
                 d_content += "<td width='90' class='r4' id='8tdId2" +i+"'>"+convAmt(netSaleAmt)+"</td>";
                 d_content += "<td width='90' class='r4' id='9tdId2" +i+"'>"+convAmt(reduAmt)+"</td>";
                 d_content += "<td width='90' class='r4' id='10tdId2"+i+"'>"+convAmt(totSaleAmt)+"</td>";
                 d_content += "</tr>";
             }
             
             d_content += "<tr>";
             d_content += "<td class='sum1' colspan='4'>합계</td>"
             d_content += "<td class='sum2'>"+convAmt(String(saleQtySum))+"</td>";
             d_content += "<td class='sum2'>"+convAmt(String(saleAmtSum))+"</td>";
             d_content += "<td class='sum2'>"+convAmt(String(dcAmtSum))+"</td>";
             d_content += "<td class='sum2'>"+convAmt(String(netSaleAmtSum))+"</td>";
             d_content += "<td class='sum2'>"+convAmt(String(reduAmtSum))+"</td>";
             d_content += "<td class='sum2'>"+convAmt(String(totSaleAmtSum))+"</td>";
              
             d_content += "</tr>";
             
         }
         d_content += "</table>"
         document.getElementById("DETAIL_CONTETN").innerHTML = d_content; 
        // setPorcCount("SELECT", rowsNode.length);
     </ajax:callback>
     
 }
/**
 * chBak()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  데이타 로우 클릭시 선택 색
 * return값 : void
 */ 
function chBak(val) {
    g_last_row = val;
    
    if (g_pre_row != g_last_row){
        for(i=1;i<11;i++) {
            document.getElementById(i+"tdId"+val).style.backgroundColor="#ffff00";
            if (g_pre_row != -1) {
                document.getElementById(i+"tdId"+g_pre_row).style.backgroundColor="#ffffff";
            }
        }
    }
    g_pre_row = g_last_row;
}

/**
 * chBak()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  디테일 데이타 로우 클릭시 선택 색
 * return값 : void
 */ 
function chBak2(val) {
    g_last_row2 = val;
    
    if ( g_pre_row2 != g_last_row2 ){
        for(i=1;i<11;i++) {
            document.getElementById(i+"tdId2"+val).style.backgroundColor="#ffff00";
    
            if ( g_pre_row2 != -1 ) {
                document.getElementById(i+"tdId2"+g_pre_row2).style.backgroundColor="#ffffff";
            }
        }
    }
    g_pre_row2 = g_last_row2;
}

function scrollAll() {
    document.all.DIV_TITLE.scrollLeft = document.all.DIV_Content.scrollLeft;
  }

function scrollAll2() {
    document.all.DETAIL_TITLE.scrollLeft = document.all.DETAIL_CONTETN.scrollLeft;
  }
  
</script>
</head>
<body  class="PL10 PR07 PT15" onload="doinit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>일매출현황</td>
        <td ><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onclick="javascript:btn_Sch();"/></td>
            <td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow" onclick="addRow();" /></td>
            <td><img src="<%=dir%>/imgs/btn/del.gif" width="50" height="22" id="del" /></td>
            <td><img src="<%=dir%>/imgs/btn/save.gif" width="50" height="22" id="save" /></td>
            <td><img src="<%=dir%>/imgs/btn/excel.gif" width="61" height="22" id="excel" onclick="javascript: excelExport('일매출현황','TBL',pumbunCd);"/></td>
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
                <select name="pubumCd" id="pubumCd" style="width: 200;">
                
                </select>
            </td>
          </tr>
          <tr>
            <th >기간</th>
            <td colspan="5">
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
            <td>
                <!--  -->
                <div id="DIV_TITLE" style=" width:815px;  overflow:hidden;">
                 
                    <!-- 
                    <table width="815" border="0" cellspacing="0" cellpadding="0" class="g_table">
                     -->
                    <!-- 
                    <table width="855" border="0" cellspacing="0" cellpadding="0" class="g_table">
                     -->
                    <table width="900" border="0" cellspacing="0" cellpadding="0" class="g_table">
                                <tr>
                                  <!-- 
                                  <th width="45">No</th>
                                  <th width="95">매출일자</th>
                                  <th width="75">점</th>
                                  <th width="90">브랜드</th>
                                  <th width="90">매출수량</th>
                                  <th width="90">할인</th>
                                  <th width="90">매출</th>
                                  <th width="90">에누리</th>
                                  <th width="90">순매출</th>
                                  <th width="90">총매출</th>
                                  <th width="15">&nbsp;</th>
                                   -->
                                   
                                  <th width="45">No</th>
                                  <th width="95">매출일자</th>
                                  <th width="75">점</th>
                                  <th width="90">브랜드</th>
                                  <th width="85">매출건수</th>
                                  <th width="90">매출</th>
                                  <th width="90">에누리</th>
                                  <th width="90">순매출</th>
                                  <th width="90">할인</th>
                                  <th width="90">총매출</th>
                                  <th width="15">&nbsp;</th>
                                  
                                </tr>
                
                     </table>
                </div>
            </td>
          </tr>
          <tr>
              <td>
              <!-- 
                  <div id="DIV_Content" style="width:815px;height:182px;overflow:scroll" >
                  -->
                  <div id="DIV_Content" style="width:815px;height:182px;overflow:scroll" onscroll="scrollAll();">
                      <!-- 
                      <table width="795" border="0" cellspacing="0" cellpadding="0" class="g_table">
                       -->
                       <table width="845" border="0" cellspacing="0" cellpadding="0" class="g_table">
                      </table>
                  </div>
              </td>
          </tr>
    </table>
        </div>
        </td>
  </tr>
  <tr><td height="8"></td></tr>
  <tr valign="top">
    <td>
        <table width="100%"  border="0" cellspacing="0" cellpadding="0" class="BD4A">
            <tr valign="top">
                <td>
                     <div id="DETAIL_TITLE" style=" width:815px;  overflow:hidden;">
                        <!-- <table width="815" border="0" cellspacing="0" cellpadding="0" class="g_table">
                         -->
                        <table width="900" border="0" cellspacing="0" cellpadding="0" class="g_table">
                            <tr>
                                <th width="44">NO</th>
                                <th width="93" >품목코드</th>
                                <th width="74" >행사구분</th>
                                <th width="87">행사율</th>
                                <th width="83">매출건수 </th>
                                <th width="86">매출</th>
                                <th width="87">에누리</th>
                                <th width="88">순매출</th>
                                <th width="88">할인</th>
                                <th width="90">총매출</th>
                                <th width="15">&nbsp;</th>
                              </tr>
                        </table>
                     </div>
                </td>
            </tr>
            <tr>    
                <td>
                     
                    <!-- <div id="DETAIL_CONTETN" style="width:815px;height:233px;overflow:scroll" >  -->
                    <div id="DETAIL_CONTETN" style="width:815px;height:233px;overflow:scroll" onscroll="scrollAll2();">
                        <!-- <table width="795" border="0" cellspacing="0" cellpadding="0" class="g_table">
                         -->
                        <table width=845 border="0" cellspacing="0" cellpadding="0" class="g_table">
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
