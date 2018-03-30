

<!-- 
/*******************************************************************************
 * 시스템명 : 협력사EDI > 영업실적 > 일일거래현황 조회
 * 작 성 일 : 2011.09.14
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : esal1130.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 기간별단품매출현황 조회
 * 이    력 : 2011.09.14 (김정민) 신규작성 
 *            2011.10.26 (하진영) 수정
 ******************************************************************************/
-->

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
var strMst = "";

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
    
    
    /*  조회 항목  */
    //initDateText('SYYYYMMDD', 'em_S_Date');                                     //시작일
    initDateText('TODAY', 'em_S_Date');                                     //시작일
    initDateText("TODAY", "em_E_Date");                                         //종료일

    
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
	 
	// 스크롤 위치 초기화        
    document.all.topTitle.scrollLeft = 0;
    document.all.DIV_Content.scrollLeft = 0; 
    

    

	 
    g_row = -1;
    g_pre_row = -1;
    
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
  //  var strVencd = document.getElementById("vencd").value;
    var strPumbuncd = document.getElementById("pubumCd").value;
    var sDate = getRawData(trim(document.getElementById("em_S_Date").value));
    var eDate = getRawData(trim(document.getElementById("em_E_Date").value));
    
    
    var param = "&goTo=getMaster" + "&strcd="  +strStrcd
							      + "&vencd="  + vencd 
							      + "&strPumbuncd=" + encodeURIComponent(strPumbuncd)
							      + "&sDate="  + sDate
							      + "&eDate="  + eDate;
    
	var Urleren = "/edi/esal113.es";  
	URL = Urleren + "?" +param;
	searchSetWait("B");
	strMst = getXMLHttpRequest();
	strMst.onreadystatechange = responseMaster;
	strMst.open("POST", URL, true); 
	strMst.send(null); 
}


/**
 * responseDetail()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  디테일 조회 시 조회 그리드에 데이터 넣기
 * return값 : void
 */ 
function responseMaster()
{

     var SUM_RCP	   	= 0;
     var SUM_ITEM      	= 0;
     var SUM_CASH      	= 0;
     var SUM_CARD      	= 0;
     var SUM_IGIFT     	= 0;
     var SUM_OGIFT     	= 0;
     var SUM_ETC       	= 0;
     var SUM_CASHRECP	= 0;
     var SUM_RECPCNT	= 0;
     var strTd		   	= "";
     var strTd_Recp	   	= "";
     
     var tfChk = CHK_CASHRECP.checked;
     
     
     if(strMst.readyState==4)
     {
          if(strMst.status == 200)
          {
              strMst = eval(strMst.responseText); 
            //   alert(str); 
            //   alert(eval(str)[0].STR_CD);
              var content = "";
              if (tfChk) 
              	content += "<table width='1400' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
              else 
             	content += "<table width='1120' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
              
             // 조회된 데이터가 없을땐 그리드를 그리지 않고 return
              if(strMst == undefined) { 
                  document.getElementById("DIV_Content").innerHTML = content;   
                  content += "</table>";
                  searchDoneWait();
                 setPorcCount("SELECT", 0);
                 
                 return; 
               }
              
              for( i = 0; i < strMst.length; i++ ){ 
            	  
            	  strTd 		= "style='";
            	  strTd_Recp	= "style='background-Color:#FAFAFA;'";  // 현금영수증내용 그리드
            	  
            	  if (strMst[i].TRAN_FLAG == "반품"){
            		  strTd		   = strTd + "color:red;";
            	  }else{
            		  strTd		   = strTd + "";
            	  }
            	  
            	  if (convAmt(strMst[i].RCP_AMT) != convAmt(strMst[i].ITEM_AMT)){
            		  strTd		   = strTd + "background-Color:#F6CECE;";
            	  }else{
            		  strTd		   = strTd + "";
            	  }
            	  
            	  strTd = strTd +"'";
            	  
            	  
                  content += "<tr onclick='chBak("+i+");' style='cursor:hand;'>";    
                  content += "<td width='40' "+strTd+"  class='r1' id='1tdId"+i+"'>"+(i+1)+"</td>";
                  content += "<td width='80' "+strTd+"  class='r1' id='2tdId"+i+"'>"+getDateFormat(strMst[i].SALE_DT) +"</td>";
                  content += "<td width='80' "+strTd+"  class='r1' id='3tdId"+i+"'>"+strMst[i].POS_NO+"</td>"; 
                  content += "<td width='80' "+strTd+"  class='r1 msoTxt1' id='4tdId"+i+"'>"+strMst[i].TRAN_NO+"</td>";
                  content += "<td width='80' "+strTd+"  class='r1' id='5tdId"+i+"'>"+strMst[i].PUMBUN_CD+"</td>";
                  content += "<td width='120' "+strTd+"  class='r1' id='6tdId"+i+"'>"+strMst[i].PUMBUN_NAME+"</td>";
                  content += "<td width='80'  "+strTd+"  class='r1' id='7tdId"+i+"'>"+strMst[i].TRAN_FLAG+"</td>";
                  content += "<td width='80'  "+strTd+" class='r4' id='8tdId"+i+"'>"+convAmt(strMst[i].RCP_AMT)+"</td>";
                  content += "<td width='80'  "+strTd+" class='r4' id='9tdId"+i+"'>"+convAmt(strMst[i].ITEM_AMT)+"</td>";
                  content += "<td width='80'  "+strTd+" class='r4' id='10tdId"+i+"'>"+convAmt(strMst[i].CASH_AMT)+"</td>";
                  content += "<td width='80'  "+strTd+" class='r4' id='11tdId"+i+"'>"+convAmt(strMst[i].CARD_AMT)+"</td>";
                  content += "<td width='80'  "+strTd+" class='r4' id='12tdId"+i+"'>"+convAmt(strMst[i].IGIFT_AMT)+"</td>";
                  content += "<td width='80'  "+strTd+" class='r4' id='13tdId"+i+"'>"+convAmt(strMst[i].OGIFT_AMT)+"</td>";
                  content += "<td width='80'  "+strTd+" class='r4' id='14tdId"+i+"'>"+convAmt(strMst[i].ETC_AMT)+"</td>";
                  
                  if (tfChk) {	// 현금영수증의 경우
                	  content += "<td width='80'  "+strTd_Recp+" class='r4' id='15tdId"+i+"'>"+convAmt(strMst[i].CASH_RECP_AMT)+"</td>";
                      content += "<td width='100'  "+strTd_Recp+" class='r1 msoTxt1' id='16tdId"+i+"'>"+strMst[i].MSKD_CASH_RECP_ID+"</td>";
                      content += "<td width='100'  "+strTd_Recp+" class='r1 msoTxt1' id='17tdId"+i+"'>"+strMst[i].CASH_RECP_APPR_NO+"</td>";
                      
                      SUM_CASHRECP += Number(strMst[i].CASH_RECP_AMT);
                      SUM_RECPCNT += Number(strMst[i].APPR_CNT);
                  }
                   
                  content += "</tr>";   
                   
                  
                  SUM_RCP	+= Number(strMst[i].RCP_AMT);    
                  SUM_ITEM  += Number(strMst[i].ITEM_AMT);
                  SUM_CASH  += Number(strMst[i].CASH_AMT);
                  SUM_CARD  += Number(strMst[i].CARD_AMT);
                  SUM_IGIFT += Number(strMst[i].IGIFT_AMT);
                  SUM_OGIFT += Number(strMst[i].OGIFT_AMT);
                  SUM_ETC   += Number(strMst[i].ETC_AMT);
                  
                  
               //   getMaster(i); 
              }   
              
              content += "<tr>";
              content += "<td class='sum1' colspan='5'>&nbsp;</td>";
              content += "<td class='sum1' colspan='2'>합계</td>"; 
              content += "<td class='sum1' ><b>"+convAmt(String(SUM_RCP))+"</b></td>";  //convAmt(String(SUM_SUP_AMT))
              content += "<td class='sum1' ><b>"+convAmt(String(SUM_ITEM))+"</b></td>";  //convAmt(String(SUM_SUP_AMT))
              content += "<td class='sum1' ><b>"+convAmt(String(SUM_CASH))+"</b></td>";  //convAmt(String(SUM_SUP_AMT))
              content += "<td class='sum1' ><b>"+convAmt(String(SUM_CARD))+"</b></td>";  //convAmt(String(SUM_SUP_AMT))
              content += "<td class='sum1' ><b>"+convAmt(String(SUM_IGIFT))+"</b></td>";  //convAmt(String(SUM_SUP_AMT))
              content += "<td class='sum1' ><b>"+convAmt(String(SUM_OGIFT))+"</b></td>";  //convAmt(String(SUM_SUP_AMT))
              content += "<td class='sum1' ><b>"+convAmt(String(SUM_ETC))+"</b></td>";  //convAmt(String(SUM_SUP_AMT))
              
              if (tfChk) { // 현금영수증의 경우
            	  content += "<td class='sum1' ><b>"+convAmt(String(SUM_CASHRECP))+"</b></td>";  //convAmt(String(SUM_SUP_AMT))
            	  content += "<td class='sum1' ><b>승인건수</b></td>";  //convAmt(String(SUM_SUP_AMT))
                  content += "<td class='sum1' ><b>"+convAmt(String(SUM_RECPCNT))+"</b></td>";  //convAmt(String(SUM_SUP_AMT))  
              }
              
              content += "</tr>";
              
                document.getElementById("DIV_Content").innerHTML = content; 
             //   alert(strMst.length);
              content += "</table>";

              setPorcCount("SELECT", strMst.length);
              searchDoneWait();
              chBak(0);
          } 
     }
     
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
  * 개    요 :  로우 선택시 색깔
  * return값 : void
  */


function chBak(val) {
	   
   var tfChk = CHK_CASHRECP.checked;
   var nColNum = 15;
   
   if (tfChk)
	   nColNum = nColNum + 3;
  
   g_last_row = val;
   
   
   
   
   
   if (g_pre_row != g_last_row){
       for(i=1;i<nColNum;i++) {
    	   
           document.getElementById(i+"tdId"+val).style.backgroundColor="#ffff00";

           
           if (g_pre_row != -1) {
        	   if (i > 14) 
               	 document.getElementById(i+"tdId"+g_pre_row).style.backgroundColor="#FAFAFA";
        	   else
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
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>거래형태별매출</td>
        <td><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onClick="javascript:btn_Sch();"/></td>
            <td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow"  /></td>
            <td><img src="<%=dir%>/imgs/btn/del.gif" width="50" height="22" id="del" /></td>
            <td><img src="<%=dir%>/imgs/btn/save.gif" width="50" height="22" id="save" /></td>
            <td><img src="<%=dir%>/imgs/btn/excel.gif" width="61" height="22" id="excel" onclick="javascript: if(!chBakClr(14)){ excelExport('거래형태별매출','TBL',pumbunCd);}"/></td>
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
            <th>기간</th>
            <td width="250">
                <input type="text" name="em_S_Date" id="em_S_Date" size="10" title="YYYY/MM/DD" value="" maxlength="10" onKeyPress="javascript:onlyNumber();" onBlur="dateCheck(this);" onFocus="dateValid(this);"  style='text-align:center;IME-MODE: disabled' /> 
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onClick="openCal('G',em_S_Date);return false;" /> ~
                 <input type="text" name="em_E_Date" id="em_E_Date" size="10" maxlength="10" value="" onKeyPress="javascript:onlyNumber();" onBlur="dateCheck(this);" onFocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' />
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onClick="openCal('G',em_E_Date);return false;" />
            </td>
            <td colspan="4">
            	<input type="checkbox" id=CHK_CASHRECP> 현금영수증내역조회
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
    <td height="4"></td>
  </tr>
  <tr valign="top">
    <td >
        <div id="TBL">
	    <table width="100%"  border="0" cellspacing="0" cellpadding="0" class="BD4A">
	      <tr valign="top">
	        <td><div id="topTitle" style="width:815px;overflow:hidden;">
	                <table width="1413" cellpadding="0" cellspacing="0" border="0" class="g_table" >
	                    <tr>
	                        <th width="40">NO</th>
	                        <th width="80">매출일자</th>
	                        <th width="80">장비번호</th>
	                        <th width="80">거래번호</th>
	                        <th width="80">브랜드코드</th>
	                        <th width="120">브랜드명</th>
	                        <th width="80">거래구분</th>
	                        <th width="80">영수증금액</th>
	                        <th width="80">상품금액</th>
	                        <th width="80">현금</th>
	                        <th width="80">카드</th>
	                        <th width="80">자사상품권</th>
	                        <th width="80">타사상품권</th>
	                        <th width="80">기타</th>
	                        <th width="80">승인금액</th>
	                        <th width="100">영수번호</th>
	                        <th width="100">승인번호</th>
	                        <th width="13"></th>
	                    </tr>
	                </table>
	            </div>        
	        </td>
	      </tr>
	      <tr> 
	          <td ><div id="DIV_Content" style="width:815px;height:455px;overflow:scroll" onscroll="scrollAll();">
	                  <!--table width="510" cellspacing="0" cellpadding="0" border="0" class="g_table">
	                  </table-->  
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

