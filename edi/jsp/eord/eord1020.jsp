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
<script language="javascript"  src="<%=dir%>/js/message.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script type="text/javascript">
var userid = '<%=userid%>';
var gb = '<%=gb%>';
var vencd = '<%=vencd%>';
var venNm = '<%=venNm%>';
var g_strcd = '<%=strcd%>';
var g_pre_row = -1;
var g_last_row = -1;


var g_popUp         = false;

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
    
    /* 구분 값이 브랜드로 로그인시 "전체" 값 없음 */
    if(gb=="1"){
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "Y", '<%=pumbunCd%>');             //점별 브랜드	
    }else{
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "N", '<%=pumbunCd%>');             //점별 브랜드
    }
    document.getElementById("strcd").value = '<%=strcd%>';
    //document.getElementById("read_cnt").value = "100";
    
    
    
}

/**
 * getPumbunCombo()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  점별브랜드콤보
 * return값 : void
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
 * btn_Sch()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  조회  
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
    var strStrcd = document.getElementById("strcd").value;
    var strVencd = document.getElementById("vencd").value;
    var strPumbuncd = document.getElementById("pubumCd").value;
    var strSlip_flag = document.getElementById("in_slip_flag").value;
    var strShGb = document.getElementsByName("sh_gb")[0].checked == true ? "1" : "2";
    var sDate = getRawData(trim(document.getElementById("em_S_Date").value));
    var eDate = getRawData(trim(document.getElementById("em_E_Date").value));
    
    var param = "&goTo=getMaster&strcd="+strStrcd
    + "&vencd=" + strVencd 
    + "&pumben=" + strPumbuncd
    + "&slip_flag=" + strSlip_flag
    + "&strShGb=" + strShGb
    + "&sDate=" + sDate
    + "&eDate=" + eDate;    
    
    <ajax:open callback="on_boardSearchXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/eord102.eo"/>
        

    <ajax:callback function="on_boardSearchXML">
       
       var content = "";
       if( rowsNode.length > 0 ){
           
           content += "<table width='885' border='0' cellspacing='0' cellpadding='0' class='g_table' align='right'>";
           
           
           for( i = 0; i < rowsNode.length; i++ ){
               
               var Gb = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
               var m_strcd = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
               var m_str_nm = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
               var m_ordDt = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
               var m_slip_flag = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
               var m_slip_flag_nm = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
               var m_slip_no = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
               var m_pumbuncd = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
               var m_pumbunNm = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
               var m_vencd = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
               var m_venNm = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
               var slp_tqty = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;   //수량계
               var slp_cost_tamt = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;   //수량계
               var slp_ord_tamt = rowsNode[i].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[13].childNodes[0].nodeValue;   //수량계
               var slp_new_tamt = rowsNode[i].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[14].childNodes[0].nodeValue;   //수량계
               var slp_gap_rate = rowsNode[i].childNodes[15].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[15].childNodes[0].nodeValue;   //수량계
               var sku_flag = rowsNode[i].childNodes[16].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[16].childNodes[0].nodeValue;   //수량계
               
               var pumbunSum = m_pumbuncd+","+m_pumbunNm;
               var venSum = m_vencd+","+m_venNm;
               
               if( pumbunSum.length > 12 ) {
            	   pumbunSum = pumbunSum.substring(0,12) + " ..";
               }
               
               if( venSum.length > 12 ){
            	   venSum = venSum.substring(0, 12) + " ..";
               }

               content += "<tr onclick='chBak("+i+");' style='cursor:hand;'>";
               content += "<input type='hidden' name='p_strcd'      id='p_strcd"+i+"'       value='"+m_strcd+"' />";
               content += "<input type='hidden' name='p_slip_no'    id='p_slip_no"+i+"'     value='"+m_slip_no+"' />";
               content += "<input type='hidden' name='p_slip_flag'  id='p_slip_flag"+i+"'   value='"+m_slip_flag+"' />";
               content += "<input type='hidden' name='p_sku_flag'   id='p_sku_flag"+i+"'    value='"+sku_flag+"' />";
               content += "<td class='r1' width='25' id='1tdId"+i+"' >"+(i+1)+"</td>";
               content += "<td class='r1' width='25' id='2tdId"+i+"' ><input type='checkbox' name='chBox' id='chBox'  ></td>";
               content += "<td class='r1' width='85' id='3tdId"+i+"' >"+getDateFormat(m_ordDt)+"</td>";
               content += "<td class='r1' width='65' id='4tdId"+i+"' >"+m_slip_flag_nm+"</td>";
               content += "<td class='r1' width='95' id='5tdId"+i+"' >"+slip_format(m_slip_no)+"</td>";
               content += "<td class='r3' width='115' title='"+(m_pumbuncd+","+m_pumbunNm)+"' id='6tdId"+i+"' >"+pumbunSum+"</td>";
               content += "<td class='r3' width='115' title='"+(m_vencd+","+m_venNm)+"' id='7tdId"+i+"' >"+venSum+"</td>";
               content += "<td class='r4' width='45' id='8tdId"+i+"' >"+convAmt(slp_tqty)+"</td>";
               content += "<td class='r4' width='95' id='9tdId"+i+"' >"+convAmt(slp_cost_tamt)+"</td>"; 
               content += "<td class='r4' width='95' id='10tdId"+i+"' >"+convAmt(slp_new_tamt)+"</td>";
               content += "<td class='r4' width='55' id='11tdId"+i+"' >"+slp_gap_rate+"</td>";
               content += "</tr>";
               
               
           } 
           content += "</table>";
       
       } else {
           /*
           content += "<table width='900' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
           content += "<tr>";
           content += "<th width='30' >NO </th>";
           content += "<th width='30' >선택<input type='checkbox' name='MA_Chbox' id='MA_Chbox'></th>";
           content += "<th width='80' >발주일</th>";
           content += "<th width='50'>전표구분 </th>";
           content += "<th width='90' >전표번호</th>";
           content += "<th width='119'>브랜드</th>";
           content += "<th width='119'>협력사</th>";
           content += "<th width='41'>수량계</th>";
           content += "<th width='70'>원가계</th>";
           content += "<th width='70'>(구)매가계</th>";
           content += "<th width='80'>(신)매가계</th>";
           content += "<th width='50'>차익율</th>";
           content += "</tr>";
           */
       }
       
       document.getElementById("DIV_Content").innerHTML = content;
       setPorcCount("SELECT", rowsNode.length);
    </ajax:callback>
    
    
}

/**
 * chbOnclick()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  전체 항목 선택 , 해제  
 * return값 : void
 */
 
function chbOnclick(){
    
    if( document.getElementById("MA_Chbox").checked == true ){
        //document.getElementById().checked = true;
        for( i = 0; i < document.getElementsByName("chBox").length; i++ ){
            document.getElementsByName("chBox")[i].checked = true;
        }   
    } else {
        for( i = 0; i < document.getElementsByName("chBox").length; i++ ){
            document.getElementsByName("chBox")[i].checked = false;
        }
    }
    
    
}
 /**
  * chBak()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  로우 선택시 색깔
  * return값 : void
  */
  
function chBak(val) {
    g_last_row = val;
    
    if (g_pre_row != g_last_row){
        for(i=1;i<11;i++) {
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
    
    
function btn_Print() { 
//	btn_PrintPopup();
   var str_chBox     = document.getElementsByName("chBox"); 
	var str_p_strcd     = document.getElementsByName("p_strcd"); 
    var str_p_slip_no   = document.getElementsByName("p_slip_no"); 
    var str_p_slip_flag = document.getElementsByName("p_slip_flag"); 
    var str_p_sku_flag  = document.getElementsByName("p_sku_flag");  
    
    var s_p_strcd = "";
    var s_p_slip_no = "";
    var s_p_slip_flag = "";
    var s_p_sku_flag = "";
	
    var strCnt = 0;
    
    for(var j = 0; j < str_p_strcd.length; j++){  
    	if(document.getElementsByName("chBox")[j].checked == true) {
    		strCnt = strCnt + 1;
    	}
    } 
    
    if(strCnt > 100) { 
        showMessage(StopSign, Ok,  "USER-1000", "100건이상 출력 하실수 없습니다."); 
    	return;
    } else if ( strCnt == 0 ){
        showMessage(StopSign, Ok,  "USER-1000", "출력할 내용이 없습니다."); 
        return; 
    }
    
	for(var i = 0; i < str_p_strcd.length; i++){  
		if(document.getElementsByName("chBox")[i].checked == true) {
			if(s_p_strcd == "") { 
	            s_p_strcd      = str_p_strcd[i].value;
	            s_p_slip_no    = str_p_slip_no[i].value;
	            s_p_slip_flag  = str_p_slip_flag[i].value;
	            s_p_sku_flag   = str_p_sku_flag[i].value;
	          //  alert(s_p_strcd);
			}
			else {
				s_p_strcd       = s_p_strcd + "," + str_p_strcd[i].value;
				s_p_slip_no     = s_p_slip_no + "," + str_p_slip_no[i].value;
				s_p_slip_flag   = s_p_slip_flag + "," + str_p_slip_flag[i].value;
				s_p_sku_flag    = s_p_sku_flag + "," + str_p_sku_flag[i].value;
			}  
	    } 
	} 
	
	var totCount = strCnt * 3;
	
    var params  = "&StrCd="+s_p_strcd
                + "&SlipNo="+s_p_slip_no
                + "&SlipFlag="+s_p_slip_flag
                + "&SkuFlag="+s_p_sku_flag
                + "&Loop="+strCnt
                + "&totCount="+totCount;
    //alert();
    g_popUp = window.showModalDialog("/edi/eord102.eo?goTo=print"+params,"OZREPORT",
                          "width:0px;height:0px;scroll:no;" +
                          "resizable:no;help:no;unadorned:yes;center:yes;status:no");
           
  //  updateData();      
  //  DS_CHECKMASTER.ClearData();
}

function btn_PrintPopup() {
    var str_chBox       = document.getElementsByName("chBox");
    var str_p_strcd     = document.getElementsByName("p_strcd");
    var str_p_slip_no   = document.getElementsByName("p_slip_no");
    var str_p_slip_flag = document.getElementsByName("p_slip_flag");
    var str_p_sku_flag  = document.getElementsByName("p_sku_flag");

    var s_p_strcd = "";
    var s_p_slip_no = "";
    var s_p_slip_flag = "";
    var s_p_sku_flag = "";

    var strCnt = 0;

    for (var j = 0; j < str_p_strcd.length; j++) {
        if (document.getElementsByName("chBox")[j].checked == true) {
            strCnt = strCnt + 1;
        }
    }

    if(strCnt > 100) {
        showMessage(StopSign, Ok,  "USER-1000", "100건이상 출력 하실수 없습니다.");
        return;
    } else if ( strCnt == 0 ){
        showMessage(StopSign, Ok,  "USER-1000", "출력할 내용이 없습니다.");
        return;
    }

    for(var i = 0; i < str_p_strcd.length; i++){
        if(document.getElementsByName("chBox")[i].checked == true) {
            if(s_p_strcd == "") {
                s_p_strcd     = str_p_strcd[i].value;
                s_p_slip_no   = str_p_slip_no[i].value;
                s_p_slip_flag = str_p_slip_flag[i].value;
                s_p_sku_flag  = str_p_sku_flag[i].value;
                // alert(s_p_strcd);
            } else {
                s_p_strcd     = s_p_strcd + "," + str_p_strcd[i].value;
                s_p_slip_no   = s_p_slip_no + "," + str_p_slip_no[i].value;
                s_p_slip_flag = s_p_slip_flag + "," + str_p_slip_flag[i].value;
               s_p_sku_flag   = s_p_sku_flag + "," + str_p_sku_flag[i].value;
            }
        }
    }

    var params  = "&StrCd="+g_strcd
                + "&SlipNo="+s_p_slip_no
                + "&SlipFlag="+s_p_slip_flag
                + "&SkuFlag="+s_p_sku_flag
                + "&Loop="+strCnt;
    
    var g_popUp = window.showModalDialog("/edi/eord102.eo?goTo=printPopup"+params,
                                         "PRINT_POPUP",
                                         "dialogWidth:1000px;dialogHeight:600px;scroll:no;" +
                                         "resizable:no;help:no;unadorned:yes;center:yes;status:no");

    // window.open("/edi/eord102.eo?goTo=printPopup"+params, "PRINT_POPUP", "width=1000, height=600, scrollbars=0, resizable=1, menubar=0");
}
</script>
</head>
<body  class="PL10 PR07 PT15" onLoad="doinit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>전표출력</td>
        <td><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onClick="javascript:btn_Sch();"/></td>
            <td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow" onClick="addRow();" /></td>
            <td><img src="<%=dir%>/imgs/btn/del.gif" width="50" height="22" id="del" /></td>
            <td><img src="<%=dir%>/imgs/btn/save.gif" width="50" height="22" id="save" /></td>
            <td><img src="<%=dir%>/imgs/btn/excel.gif" width="61" height="22" id="excel" /></td>
            <td><img src="<%=dir%>/imgs/btn/print.gif" width="50" height="22" id="prints" onClick="btn_Print();"/></td>
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
            <th>전표구분</th>
            <td>
                <select id="in_slip_flag" name="in_slip_flag" style="width: 114;">
                    <option value="%" selected="selected">전체</option>
                    <option value="A">매입</option>
                    <option value="B">반품</option>
                </select>
            </td>
            <th>조회구분</th>
            <td>
                <input type="radio" name="sh_gb" id="sh_gb" value="1" checked="checked" /> 발주일자
                <input type="radio" name="sh_gb" id="sh_gb" value="2"  /> 납품예정일
            </td>
            <th>기간</th>
            <td>
                <input type="text" name="em_S_Date" id="em_S_Date" size="10" title="YYYY/MM/DD" value="" maxlength="10" onKeyPress="javascript:onlyNumber();" onBlur="dateCheck(this);" onFocus="dateValid(this);"  style='text-align:center;IME-MODE: disabled' /> 
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onClick="openCal('G',em_S_Date);return false;" /> ~
                 <input type="text" name="em_E_Date" id="em_E_Date" size="10" maxlength="10" value="" onKeyPress="javascript:onlyNumber();" onBlur="dateCheck(this);" onFocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' />
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onClick="openCal('G',em_E_Date);return false;" />
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
<!--     <td height="20" style="color: red">※ 출력이 안될때는 신뢰할수있는 사이트로 등록해 주세요(인터넷 ▶도구 ▶인터넷옵션 ▶신뢰할수있는사이트 [이 영역에 적용할 보안수준:최소])</td> -->
  </tr>
  <tr valign="top">
    <td >
    <table width="100%"  border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr valign="top">
        <td><div id="topTitle" style="width:815px;overflow:hidden;">
                <table width="905" cellpadding="0" cellspacing="0" border="0" class="g_table" >
                <colgroup>
                  <col width="25">
                  <col width="25">
                  <col width="85">
                  <col width="65">
                  <col width="95">
                  <col width="115">
                  <col width="115">
                  <col width="45">
                  <col width="95"> 
                  <col width="95"> 
                  <col width="55">
                  <col width="15">
                </colgroup>
                    <tr>
                        <th>NO </th>
                        <th>선택<input type='checkbox' name='MA_Chbox' id='MA_Chbox' onclick="chbOnclick();" ></th>
                        <th>발주일</th>
                        <th>전표구분</th>
                        <th>전표번호</th>
                        <th>브랜드</th>
                        <th>협력사</th>
                        <th>수량계</th>
                        <th>원가계</th> 
                        <th>매가계</th>
                        <th>차익율</th>
                        <th>&nbsp;</th>
                    </tr>
                </table>
            </div>        
        </td>
      </tr>
      <tr>
          <td ><div id="DIV_Content" style="width:815px;height:448px;overflow:scroll" onscroll="scrollAll();">
                  <table width="885" cellspacing="0" cellpadding="0" border="0" class="g_table">
                  <colgroup>
                  <col width="25">
                  <col width="25">
                  <col width="85">
                  <col width="65">
                  <col width="95">
                  <col width="115">
                  <col width="115">
                  <col width="45">
                  <col width="95"> 
                  <col width="95">
                  <col width="55">
                </colgroup>
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

