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
    
    //기본 URL
    String u = javax.servlet.http.HttpUtils.getRequestURL(request).toString(); 
    String webDir = u.substring(0, u.lastIndexOf("edi")-1);
 
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
/*************************************************************************
 *  초기설정
 *************************************************************************/
var userid = '<%=userid%>';
var gb = '<%=gb%>';
var vencd = '<%=vencd%>';
var venNm = '<%=venNm%>';
var g_strcd = '<%=strcd%>';
var g_pre_row = -1;
var g_last_row = -1;
var g_pre_row2 = -1;
var g_last_row2 = -1;

/*************************************************************************
 *  전역변수
 *************************************************************************/
var strMst = "";        //마스터 
var strDtl = "";        //디테일 
var strPrt = "";
var g_SkuFlag = "";     //마스터 클릭시 그건의 단품 구분
var g_SkuType = "";     //마스터 클릭시 해당 건의 단품종류
var g_tag_Falg = "";    //마스터 클릭시 해당 건의 택구분
var strToday  = "";     //시스템 일자
var g_str_cd = "";      //마스터 클릭시 해당건의 점코드
var g_slipNO = "";      //마스터 클릭시 해당건의 전표번호
var strCnt = 0;
var strMonth ="";       //해당달의 주 차수조회
var g_strMonthWeek = "";      //해당달의 주 차수 전역변수


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
    enableControl(set,false);    //확정
    
    /*  조회 항목  */
    initDateText('SYYYYMMDD', 'em_S_Date');                                     //시작일
    initDateText("TODAY", "em_E_Date");                                         //종료일
    
    getPumbunCombo(g_strcd, vencd, "pubumCd", "Y");                             //점별 브랜드
    getSelectCombo("D", "P207", "Sel_slip_proc_falg", "1");                     //전표상태
    getSelectCombo("D", "P063", "in_tag_flag", "");                             //택구분
    
    document.getElementById("strcd").value = '<%=strcd%>';                      //점코드
    
    strToday        = getTodayDB2();                                            //db 오늘일자
    
    getMonthWeek();                                                             //해당달의 주 차수 리턴
}
/**
 * getTodayDB2()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  시스템 일자
 * return값 : void
 */ 
function getTodayDB2(){
        var param = "&goTo=getTodayDB";
        
        <ajax:open callback="on_getTodayDBXML" 
            param="param" 
            method="POST" 
            urlvalue="/edi/ccom001.cc"/>
        
         <ajax:callback function="on_getTodayDBXML">
             strToday = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : String(rowsNode[0].childNodes[0].childNodes[0].nodeValue);
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
 * getSelectCombo()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  select box 조회부 공통 코드
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
            //1단 스티커 제외
            if (rowsNode[i].childNodes[0].childNodes[0].nodeValue != "1S") {
                opt.setAttribute("value", rowsNode[i].childNodes[0].childNodes[0].nodeValue);
                var text = document.createTextNode(rowsNode[i].childNodes[1].childNodes[0].nodeValue);
                opt.appendChild(text); 
                sel_box.appendChild(opt);
            }
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
     
    if( document.getElementById("in_tag_flag").value == 0 ){
    	showMessage(INFORMATION, OK, "USER-1003", "택구분");
        document.getElementById("in_tag_flag").focus();
        return;
    }
    
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
 * 개    요 :  마스터 조회
 * return값 : void
 */ 
function getSearch(){
    
	 var strcd = document.getElementById("strcd").value;                             //점코드
	 var vencd = document.getElementById("vencd").value;                               //협력사코드
	 var pubumCd = document.getElementById("pubumCd").value;                           //브랜드코드
	 var strSlipProcFlag = document.getElementById("Sel_slip_proc_falg").value;        //전표상태
	 var strSlip_flag = document.getElementById("in_slip_flag").value;                 //전표구분
	 var strShgb = document.getElementsByName("sh_gb")[0].checked == true ? "1" : "2"; //조회구분
	 var strTagFlag = document.getElementById("in_tag_flag").value;                    //택구분
	 var sDate = getRawData(document.getElementById("em_S_Date").value);               //시작일
	 var eDate = getRawData(document.getElementById("em_E_Date").value);               //종료일
	 
	 var param = "&goTo=getMaster" + "&strcd=" + strcd
	                               + "&vencd=" + vencd
	                               + "&pubumCd=" + encodeURIComponent(pubumCd)
	                               + "&SlipProcFlag=" + encodeURIComponent(strSlipProcFlag)
	                               + "&Slip_flag=" + encodeURIComponent(strSlip_flag)
	                               + "&Shgb=" + strShgb
	                               + "&TagFlag=" + strTagFlag
	                               + "&sDate=" + sDate
	                               + "&eDate=" + eDate;
	 
	 var Urleren = "/edi/eord103.eo"; 
     URL = Urleren + "?" +param; 
     strMst = getXMLHttpRequest(); 
     strMst.onreadystatechange = responseMaster;
     strMst.open("GET", URL, true); 
     strMst.send(null);
     
     
}

/**
 * responseDetail()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  마스터 조회 시 조회 그리드에 데이터 넣기
 * return값 : void
 */ 
function responseMaster()
{
     if(strMst.readyState==4)
     {
          if(strMst.status == 200)
          {
              strMst = eval(strMst.responseText);
              
              var content = "<table width='1140' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
              // 조회된 데이터가 없을땐 그리드를 그리지 않고 return
              if( strMst == undefined ) { 
            	  content += "</table>";
                  document.getElementById("DIV_Content").innerHTML = content;

                  setPorcCount("SELECT", 0);  
                  
                  var de_content = "<table width='795' border='0' cellspacing='0' cellpadding='0' class='g_table'></table>";
                  document.getElementById("DETAIL_CONTETN").innerHTML = de_content;
            	  return;
              }
              
             var de_content = "<table width='795' border='0' cellspacing='0' cellpadding='0' class='g_table'></table>";
              document.getElementById("DETAIL_CONTETN").innerHTML = de_content;
              
              
              if( strMst.length > 0 ){
            	  
            	  var ordTotQtySum = 0;    //수량 합계
            	  var newCostTamtSum = 0;  //원가금액 합계
            	  var newSaleTamtSum = 0;  //매가금액합계
            	  
            	  for( i = 0; i < strMst.length; i++ ){
            		  content += "<tr onclick='chBak("+i+");getDetail("+i+");' style='cursor:hand;'>";
            		  content += "<input type='hidden' name='m_strcd' id='m_strcd"+i+"' value='"+strMst[i].STR_CD+"' />";
            		  content += "<input type='hidden' name='m_slipNo' id='m_slipNo"+i+"' value='"+strMst[i].SLIP_NO+"' />";
            		  content += "<input type='hidden' name='m_skuFlag' id='m_skuFlag"+i+"' value='"+strMst[i].SKU_FLAG+"' />";
            		  content += "<input type='hidden' name='m_skuType' id='m_skuType"+i+"' value='"+strMst[i].SKU_TYPE+"' />";
            		  content += "<input type='hidden' name='m_tagFlag' id='m_tagFlag"+i+"' value='"+strMst[i].TAG_FLAG+"' />";
                      content += "<td width='25' class='r1' id='1tdId"+i+"' >"+(i+1)+"</td>";
                      content += "<td width='40' class='r1' id='2tdId"+i+"' ><input type='checkbox' name='chBox' id='chBox' ></td>";
                      content += "<td width='75' class='r1' id='3tdId"+i+"' >"+getDateFormat(strMst[i].ORD_DT)+"</td>";
                      content += "<td width='75' class='r1' id='4tdId"+i+"'>"+getDateFormat(strMst[i].DELI_DT)+"</td>";
                      content += "<td width='95' class='r3' id='5tdId"+i+"'>"+strMst[i].STR_NM+"</td>";
                      content += "<td width='95' class='r3' id='6tdId"+i+"'>"+strMst[i].PUMBUN_NM+"</td>";
                      if( strMst[i].TAG_PRT_YN == "Y" ){
                    	  content += "<td width='70' class='r3' id='7tdId"+i+"'>발행</td>";  
                      }else if( strMst[i].TAG_PRT_YN == "N" ){
                    	  content += "<td width='70' class='r3' id='7tdId"+i+"'>미발행</td>";
                      }
                      content += "<td width='55' class='r3' id='8tdId"+i+"'>"+strMst[i].SLIP_FLAG_NM+"</td>";
                      content += "<td width='65' class='r3' id='9tdId"+i+"'>"+strMst[i].SLIP_PROC_STAT_NM+"</td>";
                      content += "<td width='95' class='r1' id='10tdId"+i+"'>"+slip_format(strMst[i].SLIP_NO)+"</td>";
                      content += "<td width='55' class='r4' id='11tdId"+i+"'>"+convAmt(strMst[i].ORD_TOT_QTY)+"</td>";
                      content += "<td width='100' class='r4' id='12tdId"+i+"'>"+convAmt(strMst[i].NEW_COST_TAMT)+"</td>";
                      content += "<td width='100' class='r4' id='13tdId"+i+"'>"+convAmt(strMst[i].NEW_SALE_TAMT)+"</td>";
                      content += "</tr>"; 
                      
                      ordTotQtySum += Number(strMst[i].ORD_TOT_QTY);
                      newCostTamtSum += Number(strMst[i].NEW_COST_TAMT);
                      newSaleTamtSum += Number(strMst[i].NEW_SALE_TAMT);
            	  }
            	  
            	  content += "<tr>";
            	  content += "<td class='sum1'>&nbsp;</td>";
            	  content += "<td colspan='9' class='sum1'>합계</td>";
            	  content += "<td class='sum2'>"+convAmt(String(ordTotQtySum))+"</td>";
            	  content += "<td class='sum2'>"+convAmt(String(newCostTamtSum))+"</td>";
            	  content += "<td class='sum2'>"+convAmt(String(newSaleTamtSum))+"</td>";
            	  content += "</tr>";
            	  
            	  if ( g_last_row != -1 ){
            		  g_last_row = -1;
            		  g_pre_row = -1;
            	        
            	    } 
            	  
              } 
              content += "</table>";
              document.getElementById("DIV_Content").innerHTML = content; 
              setPorcCount("SELECT", strMst.length);  
              

              // 2011.07.15 kjm 추가
              // 조회버튼 클릭시 하단그리드도 같이 조회
              chBak(0);
              getDetail2(0);
          } 
     }
}

/**
 * getDetail()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  디테일 조회 
 * return값 : void
 */ 
function getDetail( row ){
	// alert(g_last_row2);
	 if ( g_last_row2 != -1 ){
	        g_last_row2 = -1;
	        g_pre_row2 = -1;
	          
	      }
	 
	var strStrcd = document.getElementById("m_strcd"+row).value;                //점코드
	var strSlipno = document.getElementById("m_slipNo"+row).value;              //전표번호
	var strSkuFlag = document.getElementById("m_skuFlag"+row).value;            //단품구분
	g_str_cd = document.getElementById("m_strcd"+row).value;                    //택발행시 시 사용    점코드
	g_slipNO = document.getElementById("m_slipNo"+row).value;                   //택발행시 사용          전표번호
	g_SkuFlag = document.getElementById("m_skuFlag"+row).value;                 //디테일 시 사용 단품구분
	g_SkuType = document.getElementById("m_skuType"+row).value;                 //디테일 시 사용 단품종류
	g_tag_Falg = document.getElementById("m_tagFlag"+row).value;                 //디테일 시 사용 tag_flag
	
	
	var de_title = "<table width='815' border='0' cellspacing='0' cellpadding='0' class='g_table'>";             //디테일 제목
    if( strSkuFlag == "1" ){       //단품
    	de_title += "<tr>";
        de_title += "<th rowspan='2' width='40'>NO</th>";
        de_title += "<th rowspan='2' width='115'>브랜드코드</th>";
        de_title += "<th rowspan='2' width='195'>단품코드</th>";
        de_title += "<th rowspan='2' width='95'>단위</th>";
        de_title += "<th rowspan='2' width='75'>수량</th>";
        de_title += "<th colspan='2' width='240'>매가</th>";
        de_title += "<th rowspan='2' width='15'>&nbsp;</th>";
        de_title += "</tr>";
        de_title += "<tr>";
        de_title += "<th width='95'>단가</th>";
        de_title += "<th width='145'>금액</th>";
        de_title += "</tr>";
    } else if( strSkuFlag == "2" ){//품목
    	de_title += "<tr>";
        de_title += "<th rowspan='2' width='40'>NO</th>";
        de_title += "<th rowspan='2' width='115'>브랜드코드</th>";
        de_title += "<th rowspan='2' width='195'>품목코드</th>";
        de_title += "<th rowspan='2' width='95'>단위</th>";
        de_title += "<th rowspan='2' width='75'>수량</th>";
        de_title += "<th colspan='2' width='240'>매가</th>";
        de_title += "<th rowspan='2' width='15'>&nbsp;</th>";
        de_title += "</tr>";
        de_title += "<tr>";
        de_title += "<th width='95'>단가</th>";
        de_title += "<th width='145'>금액</th>";
        de_title += "</tr>";
    }
    de_title += "</table>";
    document.getElementById("DETAIL_TITLE").innerHTML = de_title;
	
    var param = "&goTo=getDetail" + "&strcd=" + strStrcd
                                  + "&slipno=" + strSlipno
                                  + "&SkuFlag=" + strSkuFlag;
	
    var Urleren = "/edi/eord103.eo"; 
    URL = Urleren + "?" +param; 
    strDtl = getXMLHttpRequest(); 
    strDtl.onreadystatechange = responseDetail;
    strDtl.open("GET", URL, true); 
    strDtl.send(null);
    
}
/**
 * responseDetail()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  디테일 조회 시 조회 그리드에 데이터 넣기
 * return값 : void
 */ 
function responseDetail(){
	if(strDtl.readyState==4)
    {
         if(strDtl.status == 200)
         {
        	 strDtl = eval(strDtl.responseText); 
             
        	 var de_content = "<table width='795' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
        	 
        	 if( strDtl == undefined ){
        		 de_content += "</table>";
        		 document.getElementById("DETAIL_CONTETN").innerHTML = de_content;
        		 return;
        	 }
        	 
        	 if( strDtl.length > 0 ){
        		 
        		 var ordQtySum = 0; //수량
        		 var newSalePrcSum = 0; //매가단가
        		 var newSaleAmt = 0; //매가금액
        		 
        		 if( g_SkuFlag == "1" ){  //단품
        			 
        			 for( i = 0; i < strDtl.length; i++ ){
                         de_content += "<tr onclick='chBak2("+i+");' style='cursor:hand;'>";
                         de_content += "<input type='hidden' name='detail_pumbuncd' id='detail_pumbuncd"+i+"'  value='"+strDtl[i].PUMBUN_CD+"' /> ";
                         de_content += "<td width='40' class='r1' id='1ddid"+i+"' >"+(i+1)+"</td>";
                         de_content += "<td width='115' class='r3' id='2ddid"+i+"' >"+strDtl[i].PUMBUN_NM+"</td>";
                         de_content += "<td width='195' class='r3' id='3ddid"+i+"' >"+strDtl[i].SKU_NM+"</td>";
                         de_content += "<td width='95' class='r4' id='4ddid"+i+"' >"+strDtl[i].ORD_UNIT_CD+"개</td>";
                         de_content += "<td width='75' class='r4' id='5ddid"+i+"' >"+convAmt(strDtl[i].ORD_QTY)+"</td>";
                         de_content += "<td width='95' class='r4' id='6ddid"+i+"' >"+convAmt(strDtl[i].NEW_SALE_PRC)+"</td>";
                         de_content += "<td width='145' class='r4' id='7ddid"+i+"' >"+convAmt(strDtl[i].NEW_SALE_AMT)+"</td>";
                         de_content += "</tr>";
                         
                         ordQtySum += Number(strDtl[i].ORD_QTY);
                         newSalePrcSum += Number(strDtl[i].NEW_SALE_PRC);
                         newSaleAmt += Number(strDtl[i].NEW_SALE_AMT);
                     }
        			 
        		 } else if( g_SkuFlag == "2" ){   //품목
        			 for( i = 0; i < strDtl.length; i++ ){
                         de_content += "<tr onclick='chBak2("+i+");' style='cursor:hand;'>";
                         de_content += "<input type='hidden' name='detail_pumbuncd' id='detail_pumbuncd"+i+"'  value='"+strDtl[i].PUMBUN_CD+"' /> ";
                         de_content += "<td width='40' class='r1' id='1ddid"+i+"' >"+(i+1)+"</td>";
                         de_content += "<td width='115' class='r3' id='2ddid"+i+"' >"+strDtl[i].PUMBUN_NM+"</td>";
                         de_content += "<td width='195' class='r3' id='3ddid"+i+"' >"+strDtl[i].PUMMOK_NM+"</td>";
                         de_content += "<td width='95' class='r4' id='4ddid"+i+"' >"+strDtl[i].ORD_UNIT_CD+"개</td>";
                         de_content += "<td width='75' class='r4' id='5ddid"+i+"' >"+convAmt(strDtl[i].ORD_QTY)+"</td>";
                         de_content += "<td width='95' class='r4' id='6ddid"+i+"' >"+convAmt(strDtl[i].NEW_SALE_PRC)+"</td>";
                         de_content += "<td width='145' class='r4' id='7ddid"+i+"' >"+convAmt(strDtl[i].NEW_SALE_AMT)+"</td>";
                         de_content += "</tr>";
                         
                         ordQtySum += Number(strDtl[i].ORD_QTY);
                         newSalePrcSum += Number(strDtl[i].NEW_SALE_PRC);
                         newSaleAmt += Number(strDtl[i].NEW_SALE_AMT);
                         
                     }   
        		 }
        		 
        		 de_content += "<tr>";
        		 de_content += "<td class='sum1'>&nbsp;</td>";
        		 de_content += "<td class='sum1' colspan='3' >합계</td>";
        		 de_content += "<td class='sum2'>"+convAmt(String(ordQtySum))+"</td>";
        		 de_content += "<td class='sum2'>"+convAmt(String(newSalePrcSum))+"</td>";
        		 de_content += "<td class='sum2'>"+convAmt(String(newSaleAmt))+"</td>";
        		 de_content += "</tr>";
        		 
        		 
        	 }
        	 de_content += "</table>";
        	 document.getElementById("DETAIL_CONTETN").innerHTML = de_content;
             setPorcCount("SELECT", strDtl.length);  
         } 
    }
}

/**
 * getDetail2()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  디테일 조회 
 * return값 : void
 */ 
function getDetail2( row ){
	 
//alert(g_last_row2);

    if ( g_last_row2 != -1 ){
        g_last_row2 = -1;
        g_pre_row2 = -1;
          
      }
	 
    var strStrcd = document.getElementById("m_strcd"+row).value;                //점코드
    var strSlipno = document.getElementById("m_slipNo"+row).value;              //전표번호
    var strSkuFlag = document.getElementById("m_skuFlag"+row).value;            //단품구분
    g_str_cd = document.getElementById("m_strcd"+row).value;                    //택발행시 시 사용    점코드
    g_slipNO = document.getElementById("m_slipNo"+row).value;                   //택발행시 사용          전표번호
    g_SkuFlag = document.getElementById("m_skuFlag"+row).value;                 //디테일 시 사용 단품구분
    g_SkuType = document.getElementById("m_skuType"+row).value;                 //디테일 시 사용 단품종류
    g_tag_Falg = document.getElementById("m_tagFlag"+row).value;                 //디테일 시 사용 tag_flag
    
    
    var de_title = "<table width='815' border='0' cellspacing='0' cellpadding='0' class='g_table'>";             //디테일 제목
    if( strSkuFlag == "1" ){       //단품
        de_title += "<tr>";
        de_title += "<th rowspan='2' width='40'>NO</th>";
        de_title += "<th rowspan='2' width='115'>브랜드코드</th>";
        de_title += "<th rowspan='2' width='195'>단품코드</th>";
        de_title += "<th rowspan='2' width='95'>단위</th>";
        de_title += "<th rowspan='2' width='75'>수량</th>";
        de_title += "<th colspan='2' width='240'>매가</th>";
        de_title += "<th rowspan='2' width='15'>&nbsp;</th>";
        de_title += "</tr>";
        de_title += "<tr>";
        de_title += "<th width='95'>단가</th>";
        de_title += "<th width='145'>금액</th>";
        de_title += "</tr>";
    } else if( strSkuFlag == "2" ){//품목
        de_title += "<tr>";
        de_title += "<th rowspan='2' width='40'>NO</th>";
        de_title += "<th rowspan='2' width='115'>브랜드코드</th>";
        de_title += "<th rowspan='2' width='195'>품목코드</th>";
        de_title += "<th rowspan='2' width='95'>단위</th>";
        de_title += "<th rowspan='2' width='75'>수량</th>";
        de_title += "<th colspan='2' width='240'>매가</th>";
        de_title += "<th rowspan='2' width='15'>&nbsp;</th>";
        de_title += "</tr>";
        de_title += "<tr>";
        de_title += "<th width='95'>단가</th>";
        de_title += "<th width='145'>금액</th>";
        de_title += "</tr>";
    }
    de_title += "</table>";
    document.getElementById("DETAIL_TITLE").innerHTML = de_title;
    
    var param = "&goTo=getDetail" + "&strcd=" + strStrcd
                                  + "&slipno=" + strSlipno
                                  + "&SkuFlag=" + strSkuFlag;
    
    var Urleren = "/edi/eord103.eo"; 
    URL = Urleren + "?" +param; 
    strDtl = getXMLHttpRequest(); 
    strDtl.onreadystatechange = responseDetail2;
    strDtl.open("GET", URL, true); 
    strDtl.send(null);
    
}


/**
 * responsePrint()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  마스터 조회 시 조회 그리드에 데이터 넣기
 * return값 : void
 */ 
function responsePrint()
{ 
     if(strPrt.readyState==4)
     { 
          if(strPrt.status == 200)
          {
              strPrt = eval(strPrt.responseText); 
          }         
     }
}

/**
 * responseDetail()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  디테일 조회 시 조회 그리드에 데이터 넣기
 * return값 : void
 */ 
function responseDetail2(){
    if(strDtl.readyState==4)
    {
         if(strDtl.status == 200)
         {
             strDtl = eval(strDtl.responseText); 
             
             var de_content = "<table width='795' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
             
             if( strDtl == undefined ){
                 de_content += "</table>";
                 document.getElementById("DETAIL_CONTETN").innerHTML = de_content;
                 return;
             }
             
             if( strDtl.length > 0 ){
                 
                 var ordQtySum = 0; //수량
                 var newSalePrcSum = 0; //매가단가
                 var newSaleAmt = 0; //매가금액
                 
                 if( g_SkuFlag == "1" ){  //단품
                     
                     for( i = 0; i < strDtl.length; i++ ){
                         de_content += "<tr onclick='chBak2("+i+");' style='cursor:hand;'>";
                         de_content += "<input type='hidden' name='detail_pumbuncd' id='detail_pumbuncd"+i+"'  value='"+strDtl[i].PUMBUN_CD+"' /> ";
                         de_content += "<td width='40' class='r1' id='1ddid"+i+"' >"+(i+1)+"</td>";
                         de_content += "<td width='115' class='r3' id='2ddid"+i+"' >"+strDtl[i].PUMBUN_NM+"</td>";
                         de_content += "<td width='195' class='r3' id='3ddid"+i+"' >"+strDtl[i].SKU_NM+"</td>";
                         de_content += "<td width='95' class='r4' id='4ddid"+i+"' >"+strDtl[i].ORD_UNIT_CD+"개</td>";
                         de_content += "<td width='75' class='r4' id='5ddid"+i+"' >"+convAmt(strDtl[i].ORD_QTY)+"</td>";
                         de_content += "<td width='95' class='r4' id='6ddid"+i+"' >"+convAmt(strDtl[i].NEW_SALE_PRC)+"</td>";
                         de_content += "<td width='145' class='r4' id='7ddid"+i+"' >"+convAmt(strDtl[i].NEW_SALE_AMT)+"</td>";
                         de_content += "</tr>";
                         
                         ordQtySum += Number(strDtl[i].ORD_QTY);
                         newSalePrcSum += Number(strDtl[i].NEW_SALE_PRC);
                         newSaleAmt += Number(strDtl[i].NEW_SALE_AMT);
                     }
                     
                 } else if( g_SkuFlag == "2" ){   //품목
                     for( i = 0; i < strDtl.length; i++ ){
                         de_content += "<tr onclick='chBak2("+i+");' style='cursor:hand;'>";
                         de_content += "<input type='hidden' name='detail_pumbuncd' id='detail_pumbuncd"+i+"'  value='"+strDtl[i].PUMBUN_CD+"' /> ";
                         de_content += "<td width='40' class='r1' id='1ddid"+i+"' >"+(i+1)+"</td>";
                         de_content += "<td width='115' class='r3' id='2ddid"+i+"' >"+strDtl[i].PUMBUN_NM+"</td>";
                         de_content += "<td width='195' class='r3' id='3ddid"+i+"' >"+strDtl[i].PUMMOK_NM+"</td>";
                         de_content += "<td width='95' class='r4' id='4ddid"+i+"' >"+strDtl[i].ORD_UNIT_CD+"개</td>";
                         de_content += "<td width='75' class='r4' id='5ddid"+i+"' >"+convAmt(strDtl[i].ORD_QTY)+"</td>";
                         de_content += "<td width='95' class='r4' id='6ddid"+i+"' >"+convAmt(strDtl[i].NEW_SALE_PRC)+"</td>";
                         de_content += "<td width='145' class='r4' id='7ddid"+i+"' >"+convAmt(strDtl[i].NEW_SALE_AMT)+"</td>";
                         de_content += "</tr>";
                         
                         ordQtySum += Number(strDtl[i].ORD_QTY);
                         newSalePrcSum += Number(strDtl[i].NEW_SALE_PRC);
                         newSaleAmt += Number(strDtl[i].NEW_SALE_AMT);
                         
                     }   
                 }
                 
                 de_content += "<tr>";
                 de_content += "<td class='sum1'>&nbsp;</td>";
                 de_content += "<td class='sum1' colspan='3' >합계</td>";
                 de_content += "<td class='sum2'>"+convAmt(String(ordQtySum))+"</td>";
                 de_content += "<td class='sum2'>"+convAmt(String(newSalePrcSum))+"</td>";
                 de_content += "<td class='sum2'>"+convAmt(String(newSaleAmt))+"</td>";
                 de_content += "</tr>";
                 

                 
             }
             de_content += "</table>";
             document.getElementById("DETAIL_CONTETN").innerHTML = de_content; 
         } 
    }
}

/**
 * getMonthWeek()
 * 작 성 자 : 박래형
 * 작 성 일 : 2011-08-17
 * 개    요 :  현재달의 몇째쭈인지 리턴
 * return값 : void
 */
 function getMonthWeek(){  
	 
    var param = "&goTo=getMonthWeek";

	var Urleren = "/edi/eord103.eo"; 
	URL = Urleren + "?" +param;  
	strMonth = getXMLHttpRequest(); 
	strMonth.onreadystatechange = responseMonth; 
	strMonth.open("GET", URL, true);  
	strMonth.send(null); 
	  
 }
 
 /**
  * responseMonth()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  현재달의 몇째쭈인지 리턴
  * return값 : void
  */ 
 function responseMonth()
 { 
	  
      if(strMonth.readyState==4)
      { 
           if(strMonth.status == 200)
           { 
        	   strMonth = eval(strMonth.responseText); 

        	   g_strMonthWeek = strMonth[0].MONTH_WEEK;
        	   //alert("g_strMonthWeek : " + g_strMonthWeek);
           }         
      }
 }


/**
 * print()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  출력 (택발행)
 * return값 : void
 */ 
function print(){ 
     
     var strCnt2 = 0;          //마스터 선택 갯수 체크
        var j = 0;
        strCheck_Slipno = "";
        
        for(var i=0; i<strMst.length; i++) {
            if(document.getElementsByName("chBox")[i].checked == true) {   
               if(strCnt == 0){ 
                    strCnt = 1;
                    j = 1;
               }
               else {
                    strCnt = strCnt + 1; 
                    j= j+1;
                }
               
               if(strCnt2 == 0){ 
                   strCnt2 = 1;
              }
              else {
                  strCnt2 = strCnt2 + 1; 
               }
            }
            
        } 
       // alert(strCnt2);
        if(strCnt2 == 0){ 
        	showMessage(StopSign, Ok,  "USER-1000", "출력할 전표를 선택 후 출력해 주세요");  
            return;
        }
        
        if(strCnt2 > 100){ 
               showMessage(StopSign, Ok,  "USER-1000", "100건이상 발행 하실수 없습니다.");  
               return;
        } 
        else { 
             for(var i=0; i<strMst.length; i++) {
                    if(document.getElementsByName("chBox")[i].checked == true) {
                        if(strCnt == 1){ 
                             strCheck_Slipno = "'" + strMst[i].SLIP_NO + "'";
                        } else { 
                            if(strCheck_Slipno != "") strCheck_Slipno += ",";
                            strCheck_Slipno += "'" + strMst[i].SLIP_NO + "'";
                        }  
                    } 
                }  
             
                var param = "&goTo=getPrint"  + "&strcd="     + g_strcd
                                              + "&slipno="    + strCheck_Slipno
                                              + "&SkuFlag="   + g_SkuFlag;

                   var Urleren = "/edi/eord103.eo"; 
                   URL = Urleren + "?" +param;  
                   strPrt = getXMLHttpRequest();  
                   strPrt.onreadystatechange = responsePrint; 
                   strPrt.open("GET", URL, true);  
                   strPrt.send(null);  
        }
         
        var updFlag = false;                 //택발행시 성공, 실패 구분 
        var strMMYY     = strToday.substring(4,6) + strToday.substring(2,4); 
        var arrStrCd    = new Array();       // 점코드
        var arrSlipNo   = new Array();       // 전표번호    
        var strSkuflag  = "";                // 단품구분             
        var strSkuType  = "";                // 1:규격단품 3:의류단품
        var strTagType  = "";                // 1S:단품(규격, 의류))  2M,2H,2S:비단품
        var strTagSize  = "";                // 택사이즈
        var tempBarCode = "";                // 바크드에 체크 코드 및 12자기 코드 만들기
        var tempBarCode2 = "";               // 바크드에 체크 코드 및 12자기 코드 만들기
        var dataset     = "";                // 택발행할 데이터셋 정하기 위한 가상데이터셋 셋팅(단품VS품목)
       
        // 단품(규격, 의류)
        var arrLines1   = new Array();       // 브랜드명 + 발행년월
        var arrLines2   = new Array();       // 단품코드
        var arrLines3   = new Array();       // 단품명(영수증명)
        var arrLines4   = new Array();       // 판매가
        var arrLines5   = new Array();       // 단품명 + 칼라 + 사이즈(의류단품만 사용)
        var arrLines6   = new Array();       // 
        var arrLines7   = new Array();       // 
        var arrLines8   = new Array();       // 
        var arrCnts     = new Array();       // 수량
       
        // 품목
        var arrLines1   = new Array();       // 발행년월(출력시점의 날짜) + 거래형태(1)
        var arrLines2   = new Array();       // RECP_NAME 브랜드 영수증명
        var arrLines3   = new Array();       // 21 + PUMBUN_CD  + PUMMOK_SRT_CD + c/d(공통함수 찾아서 처리)!!!!!!!
        var arrLines4   = new Array();       // 21 + EVENT_FLAG + SALE_PRC      + c/d(공통함수 찾아서 처리)!!!!!!!
        var arrLines5   = new Array();       // PMK_RECP_NAME
        var arrLines6   = new Array();       // SALE_PRC
        var arrLines7   = new Array();       // 
        var arrLines8   = new Array();       // 
        var arrCnts     = new Array();       // 수량
        
        strSkuflag      = g_SkuFlag;      // 품목인지 단품인지 알기위함
        strTagType      = g_tag_Falg;      // 택구분 1S:단품(규격, 의류))  2M,2H,2S:비단품
        
        var intLoofCount    = 0;    // 데이터셋의 총로우
        var arrSkuTypeIndex = 0;    // 선택된 마스터별 단품종류(단품일때만 사용 1:규격, 3:의류)
        var arrayIndex      = 0;    // 배열 변수의 인덱스
        var detailCnt       = 0;    // 디테일 조회수(하나의 마스터에 대한)
    //    intLoofCount        = strMst.length;        //마스터 총 조회 수
        
        var tempIndex       = 0;
        
        if( document.getElementsByName("detail_pumbuncd").length < 1 ){
            showMessage(StopSign, OK, "USER-1031");
            return;
        }
        
        if( showMessage(StopSign, YESNO, "GAUCE-1000", "출력 하시겠습니까?") != 1 ){
            return;
        }
        
        
        if(strSkuflag == "1"){  //단품
            strSkuType =  g_SkuType;   //단품종류(1:규격, 3:의류)
     
            for( detailCnt = 0; detailCnt < strPrt.length; detailCnt++){
                if(strSkuType == "1"){                //규격단품
                 //  arrLines1[arrayIndex] = strPrt[detailCnt].RECP_NAME + "(" + strPrt[detailCnt].BIZ_TYPE_NM.substring(0,1) + strPrt[detailCnt].TAX_FLAG_NM.substring(0,1) + ")";
                 //  arrLines2[arrayIndex] = strPrt[detailCnt].SKU_CD; 
                 //  arrLines3[arrayIndex] = strPrt[detailCnt].SKU_RECP_NAME;
                 //  arrLines4[arrayIndex] = strPrt[detailCnt].NEW_SALE_PRC;
                    
                    if(strPrt[detailCnt].PUMBUN_CD == ""){ 
                        arrLines1[arrayIndex] = strPrt[detailCnt].RECP_NAME; 
                        arrLines2[arrayIndex] = " "; 
                        arrLines3[arrayIndex] = " "; 
                        arrLines4[arrayIndex] = " "; 
                    }
                    else {  
                        arrLines1[arrayIndex] = strPrt[detailCnt].RECP_NAME + "(" + strPrt[detailCnt].BIZ_TYPE_NM.substring(0,1) + strPrt[detailCnt].TAX_FLAG_NM.substring(0,1) + ")";
                        arrLines2[arrayIndex] = strPrt[detailCnt].SKU_CD; 
                        arrLines3[arrayIndex] = strPrt[detailCnt].SKU_RECP_NAME;
                        arrLines4[arrayIndex] = strPrt[detailCnt].NEW_SALE_PRC;
                    } 
                    
                    //arrLines4[arrayIndex] = lpad(strPrt[detailCnt].NEW_SALE_PRC + "", 8, " ");                            
                    arrCnts[arrayIndex]   = strPrt[detailCnt].ORD_QTY;
                    arrLines8[arrayIndex] = g_SkuType;
                    
                    if(arrCnts[arrayIndex] % 2 == 0){
                        arrCnts[arrayIndex] = arrCnts[arrayIndex] / 2;
                    }else{
                        arrCnts[arrayIndex] = (parseInt(arrCnts[arrayIndex]) + 1) / 2;
                    }                
                    
                    arrayIndex = arrayIndex + 1;
                    tempIndex  = tempIndex  + 1;        //총데이터 건수 확인 위한 임시 변수
                    
                    if( arrayIndex == 50 ){
                        arrayIndex = 0;     
                        arrLines1 = new Array();
                        arrLines2 = new Array();
                        arrLines3 = new Array();
                        arrLines4 = new Array();
                        arrLines5 = new Array();
                        arrLines6 = new Array();
                        arrLines7 = new Array();
                        arrLines8 = new Array();
                        arrCnts   = new Array();
                        BarCode.PrintParallel(1, strSkuType, strTagType , strTagSize , arrLines1, arrLines2, arrLines3, arrLines4, arrLines5, arrLines6, arrLines7,  arrLines8,  arrCnts);
                    }
                    
                    
                }else if(strSkuType == "3"){          //의류단품
                    
                //    arrLines1[arrayIndex] = strPrt[detailCnt].RECP_NAME + " " + strMMYY;
                //    arrLines2[arrayIndex] = strPrt[detailCnt].SKU_CD;
                //    arrLines3[arrayIndex] = strPrt[detailCnt].SKU_RECP_NAME + strPrt[detailCnt].COLOR_NM + strPrt[detailCnt].SIZE_NM;
                //    arrLines4[arrayIndex] = strPrt[detailCnt].NEW_SALE_PRC;
                    //arrLines4[arrayIndex] = lpad(strPrt[detailCnt].NEW_SALE_PRC+"", 8, " ");
                    
                    if(strPrt[detailCnt].PUMBUN_CD == ""){ 
                        arrLines1[arrayIndex] = strPrt[detailCnt].RECP_NAME; 
                        arrLines2[arrayIndex] = " "; 
                        arrLines3[arrayIndex] = " "; 
                        arrLines4[arrayIndex] = " "; 
                        arrLines5[arrayIndex] = " "; // 라인2(시즌+품목)
                        arrLines8[arrayIndex] = g_SkuType;
                    }
                    else {  
                        arrLines1[arrayIndex] = strPrt[detailCnt].RECP_NAME + " " + strMMYY;
                        arrLines2[arrayIndex] = strPrt[detailCnt].SKU_CD;
                        arrLines3[arrayIndex] = strPrt[detailCnt].SKU_RECP_NAME + strPrt[detailCnt].COLOR_NM + strPrt[detailCnt].SIZE_NM;
                        arrLines4[arrayIndex] = strPrt[detailCnt].NEW_SALE_PRC;
                        arrLines5[arrayIndex] = rpad(strPrt[detailCnt].SEASON_NM+"", 4, " ") + strPrt[detailCnt].PUMMOK_NM; // 라인2(시즌+품목)
                        arrLines8[arrayIndex] = g_SkuType;
                    } 
                    
                    arrCnts[arrayIndex]   = strPrt[detailCnt].ORD_QTY; 
                  //  arrLines5[arrayIndex] = rpad(StrPrt[detailCnt].SEASON_NM+"", 4, " ") + strPrt[detailCnt].PUMMOK_NM; // 라인2(시즌+품목)
                //    arrLines8[arrayIndex] = g_SkuType;
                    
                    if(arrCnts[arrayIndex] % 2 == 0){
                        arrCnts[arrayIndex] = arrCnts[arrayIndex] / 2;
                    }else{
                        arrCnts[arrayIndex] = (parseInt(arrCnts[arrayIndex]) + 1) / 2;
                    }
                    
                    arrayIndex = arrayIndex + 1;  
                    
                    if(arrayIndex == 50){
                        BarCode.PrintParallel(1, strSkuType, strTagType , strTagSize , arrLines1, arrLines2, arrLines3, arrLines4, arrLines5, arrLines6, arrLines7,  arrLines8,  arrCnts);
                        arrayIndex = 0;   
                        arrLines1 = new Array();
                        arrLines2 = new Array();
                        arrLines3 = new Array();
                        arrLines4 = new Array();
                        arrLines5 = new Array();
                        arrLines6 = new Array();
                        arrLines7 = new Array();
                        arrLines8 = new Array();
                        arrCnts   = new Array();                 
                    }
                    
                    
                }
            } 
            
        }else{                  //품목 
            //alert(strTagType);
            if(strTagType == "2M"){ 
                for(detailCnt=1; detailCnt<=DS_TMP.CountRow; detailCnt++){
                     arrLines1[arrayIndex] = strMMYY + strPrt[detailCnt].BIZ_TYPE_NM.substring(0,1);
                    // arrLines2[arrayIndex] = strPrt[detailCnt].RECP_NAME;
                     tempBarCode           = "21" + strPrt[detailCnt].PUMBUN_CD + strPrt[detailCnt].PUMMOK_SRT_CD;
                   //  arrLines3[arrayIndex] = tempBarCode + getSkuCdCheckSum(tempBarCode);
                     tempBarCode2          = "29" + strPrt[detailCnt].EVENT_FLAG + lpad(strPrt[detailCnt].NEW_SALE_PRC+"", 8, "0");
                   //  arrLines4[arrayIndex] = tempBarCode2 + getSkuCdCheckSum(tempBarCode2);  
                   //  arrLines5[arrayIndex] = strPrt[detailCnt].PMK_RECP_NAME
                   //  arrLines6[arrayIndex] = strPrt[detailCnt].NEW_SALE_PRC;
                     
                     if(strPrt[detailCnt].PUMBUN_CD == ""){ 
                         arrLines2[arrayIndex] = strPrt[detailCnt].PUMBUN_NM; 
                         arrLines3[arrayIndex] = " "; 
                         arrLines4[arrayIndex] = " ";
                         arrLines5[arrayIndex] = " ";
                         arrLines6[arrayIndex] = " ";
                     }
                     else {  
                         arrLines2[arrayIndex] = strPrt[detailCnt].RECP_NAME; 
                         arrLines3[arrayIndex] = tempBarCode + getSkuCdCheckSum(tempBarCode); 
                         arrLines4[arrayIndex] = tempBarCode2 + getSkuCdCheckSum(tempBarCode2);
                         arrLines5[arrayIndex] = strPrt[detailCnt].PMK_RECP_NAME;
                         arrLines6[arrayIndex] = strPrt[detailCnt].NEW_SALE_PRC;
                     } 
                     
                     
                     //arrLines6[arrayIndex] = lpad(StrPrt[detailCnt].NEW_SALE_PRC+"", 8, " ");  
                     arrCnts[arrayIndex]   = strPrt[detailCnt].ORD_QTY;
                     
                     
                     if(arrCnts[arrayIndex] % 2 == 0){
                         arrCnts[arrayIndex] = arrCnts[arrayIndex] / 2;
                     }else{
                         arrCnts[arrayIndex] = (parseInt(arrCnts[arrayIndex]) + 1) / 2;
                     }
                        
                     arrayIndex = arrayIndex + 1;
                     
                     
                     if(arrayIndex == 50){
                         BarCode.PrintParallel(2, strSkuType, strTagType , strTagSize , arrLines1, arrLines2, arrLines3, arrLines4, arrLines5, arrLines6, arrLines7,  arrLines8,  arrCnts);
                         arrayIndex = 0;   
                         arrLines1 = new Array();
                         arrLines2 = new Array();
                         arrLines3 = new Array();
                         arrLines4 = new Array();
                         arrLines5 = new Array();
                         arrLines6 = new Array();
                         arrLines7 = new Array();
                         arrLines8 = new Array();
                         arrCnts   = new Array();                 
                     }
                     
                }
                 
            }else if(strTagType == "2H"){ 
                for(detailCnt=0; detailCnt < strPrt.length; detailCnt++){
                 
                	if(g_strMonthWeek == 1){
                        arrLines1[arrayIndex] = lpad(">"+"", 5, " ")     + lpad(strPrt[detailCnt].BIZ_TYPE_NM.substring(0,1)+"", 10, " ");                           
                    }else if(g_strMonthWeek == 2){
                        arrLines1[arrayIndex] = lpad(">>"+"", 5, " ")    + lpad(strPrt[detailCnt].BIZ_TYPE_NM.substring(0,1)+"", 10, " ");                           
                    }else if(g_strMonthWeek == 3){
                        arrLines1[arrayIndex] = lpad(">>>"+"", 5, " ")   + lpad(strPrt[detailCnt].BIZ_TYPE_NM.substring(0,1)+"", 10, " ");                           
                    }else if(g_strMonthWeek == 4){
                        arrLines1[arrayIndex] = lpad(">>>>"+"", 5, " ")  + lpad(strPrt[detailCnt].BIZ_TYPE_NM.substring(0,1)+"", 10, " ");                           
                    }else if(g_strMonthWeek == 5){
                        arrLines1[arrayIndex] = lpad(">>>>"+"", 5, " ")  + lpad(strPrt[detailCnt].BIZ_TYPE_NM.substring(0,1)+"", 10, " ");                           
                    }    
                	
                 //   arrLines1[arrayIndex] = strMMYY + strPrt[detailCnt].BIZ_TYPE_NM.substring(0,1);
                 //  arrLines2[arrayIndex] = strPrt[detailCnt].RECP_NAME; 
                    tempBarCode           = "21" + strPrt[detailCnt].PUMBUN_CD + strPrt[detailCnt].PUMMOK_SRT_CD;
                    tempBarCode2          = "29" + strPrt[detailCnt].EVENT_FLAG + lpad(strPrt[detailCnt].NEW_SALE_PRC+"", 8, "0");
                    if(strPrt[detailCnt].PUMBUN_CD == ""){ 
                        arrLines2[arrayIndex] = strPrt[detailCnt].RECP_NAME; 
                        arrLines3[arrayIndex] = " "; 
                        arrLines4[arrayIndex] = " ";
                        arrLines5[arrayIndex] = " ";
                        arrLines6[arrayIndex] = " ";  
                        arrLines7[arrayIndex] = " ";   
                    }
                    else {  
                        arrLines2[arrayIndex] = strPrt[detailCnt].RECP_NAME; 
                        arrLines3[arrayIndex] = tempBarCode + getSkuCdCheckSum(tempBarCode); 
                        arrLines4[arrayIndex] = tempBarCode2 + getSkuCdCheckSum(tempBarCode2);
                        arrLines5[arrayIndex] = strPrt[detailCnt].PMK_RECP_NAME;
                        arrLines6[arrayIndex] = strPrt[detailCnt].NEW_SALE_PRC;  
                        arrLines7[arrayIndex] = strPrt[detailCnt].EVENT_FLAG;   
                    } 
                 //   arrLines5[arrayIndex] = strPrt[detailCnt].PMK_RECP_NAME;
                 //   arrLines6[arrayIndex] = strPrt[detailCnt].NEW_SALE_PRC;
                    //arrLines6[arrayIndex] = lpad(strPrt[detailCnt].NEW_SALE_PRC+"", 8, " ");   
                    arrCnts[arrayIndex]   = strPrt[detailCnt].ORD_QTY;
                    
                    if(arrCnts[arrayIndex] % 2 == 0){
                        arrCnts[arrayIndex] = arrCnts[arrayIndex] / 2;
                    }else{
                        arrCnts[arrayIndex] = (parseInt(arrCnts[arrayIndex]) + 1) / 2;
                    }
                    
                    arrayIndex = arrayIndex + 1;
 
                    if(arrayIndex == 50){
                        BarCode.PrintParallel(2, strSkuType, strTagType , strTagSize , arrLines1, arrLines2, arrLines3, arrLines4, arrLines5, arrLines6, arrLines7,  arrLines8,  arrCnts);
                        arrayIndex = 0;   
                        arrLines1 = new Array();
                        arrLines2 = new Array();
                        arrLines3 = new Array();
                        arrLines4 = new Array();
                        arrLines5 = new Array();
                        arrLines6 = new Array();
                        arrLines7 = new Array();
                        arrLines8 = new Array();
                        arrCnts   = new Array();                 
                   }
                    
                } 
                
            }else if(strTagType == "2S"){
                for( detailCnt=0; detailCnt < strPrt.length; detailCnt++){
                	
                	if(g_strMonthWeek == 1){
                        arrLines1[arrayIndex] = lpad(">"+"", 5, " ")     + lpad(strPrt[detailCnt].BIZ_TYPE_NM.substring(0,1)+"", 10, " ");                          
                    }else if(g_strMonthWeek == 2){
                        arrLines1[arrayIndex] = lpad(">>"+"", 5, " ")    + lpad(strPrt[detailCnt].BIZ_TYPE_NM.substring(0,1)+"", 10, " ");                          
                    }else if(g_strMonthWeek == 3){
                        arrLines1[arrayIndex] = lpad(">>>"+"", 5, " ")   + lpad(strPrt[detailCnt].BIZ_TYPE_NM.substring(0,1)+"", 10, " ");                           
                    }else if(g_strMonthWeek == 4){
                        arrLines1[arrayIndex] = lpad(">>>>"+"", 5, " ")  + lpad(strPrt[detailCnt].BIZ_TYPE_NM.substring(0,1)+"", 10, " ");                           
                    }else if(g_strMonthWeek == 5){
                        arrLines1[arrayIndex] = lpad(">>>>"+"", 5, " ")  + lpad(strPrt[detailCnt].BIZ_TYPE_NM.substring(0,1)+"", 10, " ");                          
                    }  
                   // arrLines1[arrayIndex] = strMMYY + strPrt[detailCnt].BIZ_TYPE_NM.substring(0,1);
                 //   arrLines2[arrayIndex] = strPrt[detailCnt].RECP_NAME;
                    tempBarCode           = "21" + strPrt[detailCnt].PUMBUN_CD + strPrt[detailCnt].PUMMOK_SRT_CD;
                 ///   arrLines3[arrayIndex] = tempBarCode + getSkuCdCheckSum(tempBarCode);  
                    tempBarCode2          = "29" + strPrt[detailCnt].EVENT_FLAG + lpad(strPrt[detailCnt].NEW_SALE_PRC+"", 8, "0");
               //    arrLines4[arrayIndex] = tempBarCode2 + getSkuCdCheckSum(tempBarCode2);
               //     arrLines5[arrayIndex] = strPrt[detailCnt].PMK_RECP_NAME;
               //     arrLines6[arrayIndex] = strPrt[detailCnt].NEW_SALE_PRC;
                    
                    if(strPrt[detailCnt].PUMBUN_CD == ""){ 
                        arrLines2[arrayIndex] = strPrt[detailCnt].RECP_NAME; 
                        arrLines3[arrayIndex] = " "; 
                        arrLines4[arrayIndex] = " ";
                        arrLines5[arrayIndex] = " ";
                        arrLines6[arrayIndex] = " ";
                        arrLines7[arrayIndex] = " ";
                    }
                    else {  
                        arrLines2[arrayIndex] = strPrt[detailCnt].RECP_NAME; 
                        arrLines3[arrayIndex] = tempBarCode + getSkuCdCheckSum(tempBarCode); 
                        arrLines4[arrayIndex] = tempBarCode2 + getSkuCdCheckSum(tempBarCode2);
                        arrLines5[arrayIndex] = strPrt[detailCnt].PMK_RECP_NAME;
                        arrLines6[arrayIndex] = strPrt[detailCnt].NEW_SALE_PRC;
                        arrLines7[arrayIndex] = strPrt[detailCnt].EVENT_FLAG;   
                    } 
                    //arrLines6[arrayIndex] = lpad(strPrt[detailCnt].NEW_SALE_PRC+"", 8, " ");   
                    arrCnts[arrayIndex]   = strPrt[detailCnt].ORD_QTY;
                    
                    if(arrCnts[arrayIndex] % 2 == 0){
                        arrCnts[arrayIndex] = arrCnts[arrayIndex] / 2;
                    }else{
                        arrCnts[arrayIndex] = (parseInt(arrCnts[arrayIndex]) + 1) / 2;
                    }
                    
                    arrayIndex = arrayIndex + 1;
                       
                    if(arrayIndex == 50){
                        BarCode.PrintParallel(2, strSkuType, strTagType , strTagSize , arrLines1, arrLines2, arrLines3, arrLines4, arrLines5, arrLines6, arrLines7,  arrLines8,  arrCnts);
                        arrayIndex = 0;   
                        arrLines1 = new Array();
                        arrLines2 = new Array();
                        arrLines3 = new Array();
                        arrLines4 = new Array();
                        arrLines5 = new Array();
                        arrLines6 = new Array();
                        arrLines7 = new Array();
                        arrLines8 = new Array();
                        arrCnts   = new Array();                 
                    }
                    
                }
                
                
            }
            
            
        }
        
       
        updFlag = BarCode.PrintParallel( strSkuflag, strSkuType, strTagType , strTagSize , arrLines1, arrLines2, arrLines3, arrLines4, arrLines5, arrLines6, arrLines7,  arrLines8,  arrCnts);
        
        if(updFlag){
            updTagFlagData();
        } else {
            showMessage(StopSign, OK, "GAUCE-1000", "택발행에 실패 했습니다.")
            return;
        } 
    
} 
 
/**
  * updTagFlagData()
  * 작 성 자 : 박래형
  * 작 성 일 : 2011.06.14
  * 개       요 : 택발행한 데이터 정보 수정
  * return값 : void
*/
function updTagFlagData(){             
	  
	  var param = "&goTo=updTagFlagData" + "&strcd=" + g_str_cd
	                                     + "&slipNo=" + g_slipNO;
	  
	  
	  <ajax:open callback="on_upTagFlagXML" 
	        param="param" 
	        method="POST" 
	        urlvalue="/edi/eord103.eo"/>
	        

     <ajax:callback function="on_upTagFlagXML">
	     cnt = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
	     if( cnt == "1" ){
	         showMessage(INFORMATION, OK, "GAUCE-1000", "저장되었습니다.")
	         btn_Sch();
	     }else {
	         showMessage(INFORMATION, OK, "GAUCE-1000", cnt)
	         return;
	     }
     </ajax:callback>
	  
	  
}
 

/**
 * getXMLHttpRequest()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  인터넷 유효성 체크??
 * return값 : void
 */ 
function getXMLHttpRequest(){
    if(window.ActiveXObject){
    try{
           return new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch(e1){
     try{
          return new ActiveXObject("Microsoft.XMLHTTP");
     }
     catch (e2){
          return null;
     }
    }
   }
   else if(window.XMLHttpRequest){
        return new XMLHttpRequest();
   }
   else
   {
        return null;
   }
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
        for(i=1;i<14;i++) {
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
  //alert(val);
    if ( g_pre_row2 != g_last_row2 ){
        for(i=1;i<8;i++) { 
            document.getElementById(i+"ddid"+ val).style.backgroundColor="#fff56E";
   
            if (g_pre_row2 != -1) {
                document.getElementById(i+"ddid"+g_pre_row2).style.backgroundColor="#ffffff";
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


/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  저장  
 * return값 : void
 */
function btn_Excel(){
	var strTagFlag= document.getElementById("in_tag_flag").childNodes[in_tag_flag.selectedIndex].text;    //전송타입
	var strChk_Slipno = "";
	for(var i=0; i<strMst.length; i++) {
	    if(document.getElementsByName("chBox")[i].checked == true) {
	        if(strCnt == 1){ 
	            strChk_Slipno = "'" + strMst[i].SLIP_NO + "'";
	        } else { 
	            if(strChk_Slipno != "") strChk_Slipno += ",";
	            strChk_Slipno += "'" + strMst[i].SLIP_NO + "'";
	        }  
	    } 
	}  
	
	if (strDtl.length < 1) {
	    showMessage(INFORMATION, OK, "USER-1000", "조회 된 내역이 없습니다.");
	} else {
		if (strChk_Slipno.length < 1) {
			showMessage(INFORMATION, OK, "USER-1000", "출력할 내용이 없습니다.");
			return;
		}
		
	    var param = "&goTo=excelDowns"  + "&strcd=" + g_str_cd
	            + "&slipno=" + strChk_Slipno
	            + "&SkuFlag=" + g_SkuFlag
	            + "&strTagFlag=" + encodeURI(encodeURIComponent(strTagFlag)); //택발행 택 구분
	    var url = "/edi/eord105.eo?" + param; 
	    iFrame.location.href=url;
	}
}
</script>
</head>

<!-- 택발행 OCX  -->  
<!-- <OBJECT ID="BarCode"
CLASSID="CLSID:AE98B4B6-3080-4ACA-84D5-926213C6F84C"
CODEBASE="<%=webDir%>/edi/jsp/eord/DCUBE.CAB" style="display: none;">
</OBJECT> -->

<body  class="PL10 PR07 PT15" onload="doinit();">
<iframe id=iFrame name=iFrame src="about:blank" width=0 height=0></iframe>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05" show="false" />택발행</td>
        <td width=""><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onclick="javascript:btn_Sch();"/></td>
            <td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow" /></td>
            <td><img src="<%=dir%>/imgs/btn/del.gif" width="50" height="22" id="del" /></td>
            <td><img src="<%=dir%>/imgs/btn/save.gif" width="50" height="22" id="save" /></td>
            <td><img src="<%=dir%>/imgs/btn/excel.gif" width="61" height="22" id="excel"/></td>
            <td><img src="<%=dir%>/imgs/btn/print.gif" width="50" height="22" id="prints" onclick="print();" /></td>
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
                <select name="pubumCd" id="pubumCd" style="width: 153;">
                </select>
            </td>
          </tr>
          <tr>
            <th>전표상태</th>
            <td>
                <select id="Sel_slip_proc_falg" name="Sel_slip_proc_falg" style="width: 132;">
                        
                </select>
            </td>
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
                <input  type="radio" name="sh_gb" id="sh_gb" size="15" checked="checked" value="1"/>발주일자
                <input  type="radio" name="sh_gb" id="sh_gb" size="15" value="2" />납품예정일
            </td>
          </tr>
          <tr>
              <th class="point">택구분</th>
              <td>
                  <select id="in_tag_flag" name="in_tag_flag" style="width: 132;">
                  </select>
              </td>
             <th class="point">기간</th>
             <td>
                <input type="text" name="em_S_Date" id="em_S_Date" size="10" title="YYYY/MM/DD" value="" maxlength="10" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);"  style='text-align:center;IME-MODE: disabled' /> 
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onclick="openCal('G',em_S_Date);return false;" /> ~
                 <input type="text" name="em_E_Date" id="em_E_Date" size="10" maxlength="10" value="" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' />
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="종료일" align="absmiddle" onclick="openCal('G',em_E_Date);return false;" />
             </td>
             <td colspan="2" align="right">
                 <img src="<%=dir%>/imgs/btn/file_down2.gif" alt="텍스트로 내려받기 " align="absmiddle" onclick="javascript:btn_Excel();" />
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
                    <table width="1165" border="0" cellspacing="0" cellpadding="0" class="g_table">
                                <tr> 
                                  <th width="25">No</th>
                                  <th width="40">선택</th>
                                  <th width="75">발주일자</th>
                                  <th width="75">납품예정일</th>
                                  <th width="95">점</th>
                                  <th width="95">브랜드</th>
                                  <th width="70">택발행여부</th>
                                  <th width="55">전표구분</th>
                                  <th width="65">전표상태</th>
                                  <th width="95">전표번호</th>
                                  <th width="55">수량</th>
                                  <th width="100">원가금액</th>
                                  <th width="100">매가금액</th>
                                  <th width="15">&nbsp;</th>
                                </tr>
                     </table>
                </div>
            </td>
          </tr>
          <tr>
              <td>
                  <div id="DIV_Content" style="width:815px;height:182px;overflow:scroll" onscroll="scrollAll();">
                      <table width="1150" border="0" cellspacing="0" cellpadding="0" class="g_table">
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
                        <table width="815" border="0" cellspacing="0" cellpadding="0" class="g_table">
                            <tr>
                                <th rowspan="2" width="40">NO</th>
                                <th rowspan="2" width="115">브랜드코드</th>
                                <th rowspan="2" width="195" >품목코드</th>
                                <th rowspan="2" width="95">단위</th>
                                <th rowspan="2" width="85">수량</th>
                                <th colspan="2" width="240">매가</th>
                                <th rowspan="2" width="15">&nbsp;</th>
                             </tr>
                             <tr>
                                <th width="95">단가</th>
                                <th width="145">금액</th>
                             </tr> 
                        </table>
                     </div>
                </td>
            </tr>
            <tr>    
                <td>
                    <div id="DETAIL_CONTETN" style="width:815px;height:188px;overflow:scroll" onscroll="scrollAll2();">
                        <table width="795" border="0" cellspacing="0" cellpadding="0" class="g_table">
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

