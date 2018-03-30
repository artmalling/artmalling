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
    String gb = sessionInfo.getGB();                //1. 협력사     2.브랜드 
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


<script language="javascript">

var userid = '<%=userid%>';
var gb = '<%=gb%>';
var vencd = '<%=vencd%>';
var venNm = '<%=venNm%>';
var g_strcd = '<%=strcd%>';
var g_pre_row = -1;
var g_last_row = -1;
var g_pre_row2 = -1;
var g_last_row2 = -1;


var new_row = "1";   //저장시 1.일반저장 2. 신규

/* master  */

var g_ma_call_dt = new Array();             //master 접수일자
var g_ma_seq_no = new Array();              //master 순번

/* 리스트  */
var g_li_take_dt = new Array();             //list 접수일자 
var g_li_strcd = new Array();          //list 점코드
var g_li_takeSeq = new Array();          //master 순번

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
    enableControl(excel,false);    //엑셀
    enableControl(prints,false);    //프린터
    enableControl(set,false);    //프린터
    
    
    /*  조회 항목  */
    
    
    initDateText('SYYYYMMDD', 'em_S_Date');        //시작일
    initDateText("TODAY", "em_E_Date");        //종료일
    
    getPumbunCombo(g_strcd, vencd, "pubumCd", "Y");             //점별 브랜드
    
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
 * btn_Sch()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  조회  
 * return값 : void
 */
function btn_Sch(){
	
	
	 new_row = "1";
    
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
 * 개    요 :  조회  
 * return값 : void
 */
function getSearch(){
     
    var strCd = document.getElementById("strcd").value;                      //점코드
    var strPumbunCd = document.getElementById("pubumCd").value;                 //브랜드코드
    var em_sDate = getRawData(trim(document.getElementById("em_S_Date").value));   //기간 시작일
    var em_eDate = getRawData(trim(document.getElementById("em_E_Date").value));   //기간 종료일
    
    var param = "&goTo=getMaster" + "&strCd=" + strCd
                                + "&strPumbunCd=" + strPumbunCd
                                + "&em_sDate=" + em_sDate
                                + "&em_eDate=" + em_eDate
                                +  "&vencd=" + vencd
                                ;
    
    <ajax:open callback="on_getPhListXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/epro106.ep"/>
        

    <ajax:callback function="on_getPhListXML">
       
       var master_content = "<table width='797' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_Litable'>";
       if( rowsNode.length > 0 ){
           
    	   var Sum_prom_repair      = 0;
           var Sum_prom_orders      = 0;
           var Sum_prom_deliver     = 0;
           var Sum_prom_other       = 0;
           var Sum_deli_from        = 0;
           var Sum_deli_receive     = 0;
           var Sum_cnt1             = 0;
           var Sum_proc_stat        = 0;
           var Sum_proc_stat_mi     = 0;
           var Sum_cnt2             = 0;
    	   
           for( i = 0; i < rowsNode.length; i++  ){
        	   
        	   /*
        	     0.신도림점 1.점코드 2.접수일자 3.접수순번 4.접수자 사번  5.약속유형 6.인도방식 7.주소 8.최종약속일 9.인도점
        	     10.고객명 11.전화번호 12.
        	   
        	   */ 
        	   var d_strNm = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
        	   var d_takeDt = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
        	   var d_prom_repair = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
        	   var d_prom_orders = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
        	   var d_prom_deliver = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
        	   var d_prom_other = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
        	   var d_deli_from = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
        	   var d_deli_receive = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
        	   var d_cnt1 = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
        	   var d_proc_stat = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
        	   var d_proc_stat_mi = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
        	   var d_cnt2 = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
        	   
               Sum_prom_repair      += Number(d_prom_repair);
               Sum_prom_orders      += Number(d_prom_orders);
               Sum_prom_deliver     += Number(d_prom_deliver);
               Sum_prom_other       += Number(d_prom_other);
               Sum_deli_from        += Number(d_deli_from);
               Sum_deli_receive     += Number(d_deli_receive);
               Sum_cnt1             += Number(d_cnt1);
               Sum_proc_stat        += Number(d_proc_stat);
               Sum_proc_stat_mi     += Number(d_proc_stat_mi);
               Sum_cnt2             += Number(d_cnt2);
        	   
        	   master_content += "<td class='r1' id='1tdId"+i+"'  width='73' >"+d_strNm+"</td>";
        	   master_content += "<td class='r1' id='2tdId"+i+"'  width='73'>"+getDateFormat(d_takeDt)+"</td>";
        	   master_content += "<td class='r4' id='3tdId"+i+"'  width='56'>"+d_prom_repair+"</td>";
        	   master_content += "<td class='r4' id='4tdId"+i+"'  width='56'>"+d_prom_orders+"</td>";
        	   master_content += "<td class='r4' id='5tdId"+i+"'  width='56'>"+d_prom_deliver+"</td>";
        	   master_content += "<td class='r4' id='6tdId"+i+"'  width='56'>"+d_prom_other+"</td>";
        	   master_content += "<td class='r4' id='7tdId"+i+"'  width='56' >"+d_deli_from+"</td>";
        	   master_content += "<td class='r4' id='8tdId"+i+"'  width='56'>"+d_deli_receive+"</td>";
        	   master_content += "<td class='r4' id='9tdId"+i+"'  width='70' >"+d_cnt1+"</td>";
        	   master_content += "<td class='r4' id='10tdId"+i+"' width='56' >"+d_proc_stat+"</td>";
        	   master_content += "<td class='r4' id='11tdId"+i+"' width='50'>"+d_proc_stat_mi+"</td>";
        	   master_content += "<td class='r4' id='12tdId"+i+"' width='70'>"+d_cnt2+"</td>";
        	   master_content += "</tr>";   
           }
           //자동 조회 
           //getMaster2(g_li_take_dt[0], g_li_strcd[0], g_li_takeSeq[0]);
           master_content += "<tr>";
           master_content += "<td class='sum1' colspan='2'>합계</td>";
           master_content += "<td class='sum2'>"+convAmt(String(Sum_prom_repair))+"</td>";
           master_content += "<td class='sum2'>"+convAmt(String(Sum_prom_orders))+"</td>";
           master_content += "<td class='sum2'>"+convAmt(String(Sum_prom_deliver))+"</td>";
           master_content += "<td class='sum2'>"+convAmt(String(Sum_prom_other))+"</td>";
           master_content += "<td class='sum2'>"+convAmt(String(Sum_deli_from))+"</td>";
           master_content += "<td class='sum2'>"+convAmt(String(Sum_deli_receive))+"</td>";
           master_content += "<td class='sum2'>"+convAmt(String(Sum_cnt1))+"</td>";
           master_content += "<td class='sum2'>"+convAmt(String(Sum_proc_stat))+"</td>";
           master_content += "<td class='sum2'>"+convAmt(String(Sum_proc_stat_mi))+"</td>";
           master_content += "<td class='sum2'>"+convAmt(String(Sum_cnt2))+"</td>";
           master_content += "</tr>";
           master_content += "</table>";
       } 
       
     //  master_content += "</table>";
       document.getElementById("DIV_CONTETN").innerHTML = master_content;
       setPorcCount("SELECT", rowsNode.length);  
       
    </ajax:callback>
    
    
}

function btn_save(){
	
}

function btn_del(){
	
}

function btn_new(){
	
}


function scrollAll(){
    document.all.DIV_TITLE.scrollLeft = document.all.DIV_CONTETN.scrollLeft;
}

function scrollAll2(){
    document.all.DIV_TITLE.scrollLeft = document.all.DIV_CONTETN.scrollLeft;
} 
</script>


</head>


<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body  class="PL10 PR07 PT15" onload="doinit();">
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>일자별약속현황</td>
        <td ><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onclick="javascript:btn_Sch();"/></td>
            <td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow" onclick="btn_new();" /></td>
            <td><img src="<%=dir%>/imgs/btn/del.gif" width="50" height="22" id="del" onclick="btn_del();" /></td>
            <td><img src="<%=dir%>/imgs/btn/save.gif" width="50" height="22" id="save" onclick="btn_save();"/></td>
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
        <td >
          <!-- search start -->
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="80" class="point">점</th>
                <td width="140"><input type="text" name="strnm" id="strnm" size="21" maxlength="10" value="<%=strNm %>" disabled="disabled" /><input type="hidden" name="strcd" id="strcd" ></td>
                <th width="80" class="point">협력사코드</th>
                <td width="140">
                    <input type="hidden" name="vencd" id="vencd" value="<%=vencd %>" disabled="disabled" />
                    <input type="text" name="venNM" id="venNM" size="21" value="<%=venNm %>" disabled="disabled" />
                </td>
                <th width="80">브랜드코드</th>
                <td>
                    <select name="pubumCd" id="pubumCd" style="width: 143;">
                    
                    </select>
                </td>
              </tr>
              <tr>
                  <th width="80" class="point">기간</th>
                  <td colspan="5">
                     <input type="text" name="em_S_Date" id="em_S_Date" size="10" title="YYYY-MM-DD" maxlength="10" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' /> 
                     <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onclick="openCal('G',em_S_Date);return false;" /> ~
                     <input type="text" name="em_E_Date" id="em_E_Date" size="10" maxlength="10" onblur="dateCheck(this);" onfocus="dateValid(this);" onkeypress="javascript:onlyNumber();" style='text-align:center;IME-MODE: disabled'/>
                     <img src="<%=dir%>/imgs/btn/date.gif" alt="종료일" align="absmiddle" onclick="openCal('G',em_E_Date);return false;" />
                    </td>
              </tr>
          </table>
        </td>
      </tr>
    </table></td>
  </tr> 
    <tr>
        <td class="dot"  ></td>
    </tr>
     <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
          <tr valign="top">
            <td >
                <div id="DIV_TITLE" style=" width:815px; overflow:hidden;" > 
                     <table width="815" border="0" cellspacing="0" cellpadding="0" class="g_table"  >
                        <tr>
                            <th rowspan="2" width="73">점</th>
                            <th rowspan="2" width="73">일자</th>
                            <th colspan="4" >약속유형</th>
                            <th colspan="2" >인도방식</th>
                            <th rowspan="2" width="70">총건수</th>
                            <th colspan="2" >인도상태</th>
                            <th rowspan="2" width="70">총건수</th>
                            <th rowspan="2" width="12">&nbsp;</th>
                        </tr>
                        <tr>    
                            <th width="56">주문</th>
                            <th width="56">예약</th>
                            <th width="56">수선</th>
                            <th width="56">기타</th>
                            <th width="56">내방</th>
                            <th width="56">수령</th>
                            <th width="56">인도</th>
                            <th width="50">미인도</th>
                        </tr>
                     </table>
                </div>
            </td>
          </tr>
          <tr>
              <td>
                  <div id="DIV_CONTETN" style="width:815px;height:460px;overflow:scroll" onscroll="scrollAll();">
                        <table width="1360" border="0" cellspacing="0" cellpadding="0" class="g_table" id="tb_Litable">
                        </table>
                  </div>
              </td>
          </tr>
          
        </table></td>
        </tr>
       </table></td> 
    </tr>
    
</table>
</body>
</html>

