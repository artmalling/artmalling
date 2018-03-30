
<!-- 
/*******************************************************************************
 * 시스템명 : 협력사EDI > 약속관리> 약속변경이력조회
 * 작 성 일 : 2011.06.20
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : epro102.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 약속변경이력조회
 * 이    력 : 2011.06.20 (김정민) 신규작성 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
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
    String pumbuncd = sessionInfo.getPUMBUN_CD();
    String pumbunNm = sessionInfo.getPUMBUN_NAME();
 
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<ajax:library /> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링</title>
<link href="<%=dir%>/css/ds.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="<%=dir%>/js/common.js"	type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/popup.js"    type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/message.js"  type="text/javascript"></script>  
<script language="javascript" src="<%=dir%>/js/gauce.js"    type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/global.js"   type="text/javascript"></script>

<script type="text/javascript">
/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
 var strMst = ""; 
 var strDtl = "";
 var USE_AMT = 0;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var userid = '<%=userid%>';
var strcd = '<%=strcd%>';       //점코드
var gb = '<%=gb%>';
var vencd = '<%=vencd%>';
var venNm = '<%=venNm%>';  
var g_pre_row = -1;
var g_last_row = -1;
var g_pre_row2 = -1;
var g_last_row2 = -1;

var bizType;                //협력사 거래형태

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
    enableControl(search,true);    //조회 
    enableControl(newrow,false);   //신규    
    enableControl(del,false);      //삭제
    enableControl(save,false);     //저장
    enableControl(excel,false);    //엑셀
    enableControl(prints,false);   //프린터
    enableControl(set,false);      //출력
     
    /*  조회부 */ 
    document.getElementById("strcd").value = '<%=strcd%>';  //점코드 
    
    if( gb == "2" ){
        pumbuncd = '<%=pumbuncd%>';
    }
  
    getPumbunCombo(strcd, vencd, "pubumCd", "Y");             //점별 브랜드
    getSelectCombo("D", "M061", "selectgbn");                                      //조회구분
    getSelectCombo("D", "M021", "promise");                                      //약속유형 
    initDateText('SYYYYMMDD', 'em_S_Date');    //시작일
    initDateText("TODAY", "em_E_Date");        //종료일
      
} 
 
/**
 * btn_Sch()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  조회  
 * return값 : void
 */
function btn_Sch(){
	 //조회시 그리드&컨트롤 초기화
	 init_click();
	 
    var strStrcd    = document.getElementById("strcd").value;                     //점코드
    var strPumbun   = document.getElementById("pubumCd").value;                   //브랜드코드
    var strGbn      = document.getElementById("selectgbn").value;                 //조회구분
    var sDate       = getRawData(document.getElementById("em_S_Date").value);     //시작일
    var eDate       = getRawData(document.getElementById("em_E_Date").value);     //종료일
    var strcustomnm = document.getElementById("customnm").value;                  //고객명
    var strpromise  = document.getElementById("promise").value;                   //약속유형
   
    if( strPumbun == "") {
    	showMessage(StopSign, Ok,  "USER-1000", "브랜드코드는 반드시 입력하셔야 합니다.");  
        document.getElementById("strVencd").focus();
        return;	
    }
    
    if( strStrcd == "") {
        showMessage(StopSign, Ok,  "USER-1000", "점은 반드시 입력하셔야 합니다.");   
        document.getElementById("strStrcd").focus();
        return;  
    }
    if( sDate == "" ){
        showMessage(StopSign, Ok,  "USER-1000", "기간은 반드시 입력하셔야 합니다."); 
        document.getElementById("em_S_Date").value = getTodayFormat("SYYYYMMDD");
        document.getElementById("em_S_Date").focus();
        return;
    }
    
    if( eDate == "" ){
        showMessage(StopSign, Ok,  "USER-1000", "기간은 반드시 입력하셔야 합니다."); 
        document.getElementById("em_E_Date").value = getTodayFormat("YYYYMMDD");
        document.getElementById("em_E_Date").focus();
        return;
    } 
    
    if (sDate > eDate) { //시작일은 종료일보다 커야 합니다.
        showMessage(StopSign, OK, "USER-1008", "종료일", "시작일");
        document.getElementById("em_S_Date").focus();
        return;
    }
    
    var param = "&goTo=getMaster" + "&strStrcd="    + strStrcd
                                  + "&strPumbun="   + strPumbun    //"300001"
                                  + "&strGbn="      + strGbn
                                  + "&sDate="       + sDate
                                  + "&eDate="       + eDate
                                  + "&strcustomnm=" + encodeURIComponent(strcustomnm)
                                  + "&strpromise="  + strpromise
                                  + "&vencd="  + vencd;
      
    var Urleren = "/edi/epro102.ep"; 
    URL = Urleren + "?" +param; 
    strMst = getXMLHttpRequest(); 
    strMst.onreadystatechange = responseMaster;
    strMst.open("GET", URL, true); 
    strMst.send(null);
} 

/**
 * responseMaster()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  디테일 조회 시 조회 그리드에 데이터 넣기
 * return값 : void
 */ 
function responseMaster()
{
	 if(strMst.readyState==4)
	 {
		  if(strMst.status == 200)
		  {
			  strMst = eval(strMst.responseText); 
			//   alert(str); 
			//   alert(eval(str)[0].STR_CD);
			var content = "";
			 content += "<table width='485' border='0' cellspacing='0' cellpadding='0' id='tb_list' class='g_table'>";
             content += "<tr>";
             content += "<th width='35'>NO</th>";
             content += "<th width='100'>점</th>";
             content += "<th width='90'>접수일자</th>"; 
             content += "<th width='80'>SEQ</th>";  
             content += "<th width='90'>약속유형</th>";  
             content += "<th width='90'>고객명</th>";  
             content += "</tr>"; 
             
             // 조회된 데이터가 없을땐 그리드를 그리지 않고 return
              if( strMst == undefined ) { 
                  content += "</table>";
                  document.getElementById("DIV_MASTER").innerHTML = content;

                  setPorcCount("SELECT", 0);   
                  
                  return;
              }
             
             for( i = 0; i < strMst.length; i++ ){ 
            	 content += "<tr onclick='chBak("+i+");getMaster("+i+");' style='cursor:hand;'>";
                 content += "<td width='35'  class='r1' id='1tdId"+i+"'>"+(i+1)+"</td>";
                 content += "<td width='100'  class='r3' id='2tdId"+i+"'>"+strMst[i].STR_NM+"</td>";
                 content += "<td width='90' class='r1' id='3tdId"+i+"'>"+getDateFormat(strMst[i].TAKE_DT)+"</td>"; 
                 content += "<td width='80'  class='r1' id='4tdId"+i+"'>"+strMst[i].TAKE_SEQ+"</td>"; 
                 content += "<td width='90'  class='r3' id='5tdId"+i+"'>"+strMst[i].PROM_TYPE+"</td>"; 
                 content += "<td width='90'  class='r3' id='6tdId"+i+"'>"+strMst[i].CUST_NM+"</td>"; 
                 content += "</tr>";  

              //   getMaster(i); 
              
                 if ( g_last_row != -1 ){
                     g_last_row = -1;
                     g_pre_row = -1;
                       
                   } 
             }
			   document.getElementById("DIV_MASTER").innerHTML = content;
	           setPorcCount("SELECT", strMst.length);  
		     content += "</table>";
		  } 
		  

	      // 2011.07.15 kjm 추가
	      // 조회버튼 클릭시 하단그리드도 같이 조회
		  chBak(0);
		  getDetail2(0);
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
 * getMaster()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  마스터 조회 
 * return값 : void
 */ 
function getMaster( i ){      
        if( strMst.length > 0 ){
        	//alert();
        	if ( g_last_row2 != -1 ){
                g_last_row2 = -1;
                g_pre_row2 = -1;
                  
              } 
        	
            getDetail(i);  
        }  
}

/**
 * getDetail()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  디테일 조회 
 * return값 : void
 */ 
 function getDetail(i) {
 
	 var strStrCd    = strMst[i].STR_CD;
	 var strTakeDt   = strMst[i].TAKE_DT;
	 var strTakeSeq  = strMst[i].TAKE_SEQ; 
	 
	 // 디테일 클리어
	 detail_clear();
	 
	 var param = "&goTo=getDetail" 
	 + "&strStrCd="      + strStrCd
     + "&strTakeDt="     + strTakeDt    //"20110525"
     + "&strTakeSeq="    + strTakeSeq ; //"42"
	var Urleren = "/edi/epro102.ep"; 
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
 function responseDetail()
 {  
	  if(strDtl.readyState==4)
      {
           if(strDtl.status == 200)
           {
        	   strDtl = eval(strDtl.responseText);  
                 
             var content = "";
              content += "<table width='493' border='0' cellspacing='0' cellpadding='0' id='tb_list' class='g_table'>";
              content += "<tr>";
              content += "<th width='35'>NO</th>";
              content += "<th width='90'>이력항목</th>";
              content += "<th width='80'>이전약속</th>";
              content += "<th width='80'>변경약속</th>";  
              content += "<th width='100'>변경사유</th>";  
              content += "<th width='100'>변경접수일자</th>";  
              content += "</tr>";  
           // 조회된 데이터가 없을땐 그리드를 그리지 않고 return
              if( strDtl == undefined ) { 
                  content += "</table>";
                  document.getElementById("DIV_DETAIL").innerHTML = content; 
                  setPorcCount("SELECT", 0);
                  
                  return;
              }
           
              for( i = 0; i < strDtl.length; i++ ){  
                  content += "<tr onclick='chBak2("+i+");' style='cursor:hand;'>";
                  content += "<td width='35'  class='r1' id='1tdId2"+i+"'>"+(i+1)+"</td>";
                  content += "<td width='90'  class='r3' id='2tdId2"+i+"'>"+strDtl[i].MOD_LISE+"</td>";
                  content += "<td width='80'  class='r3' id='3tdId2"+i+"'>"+strDtl[i].ORG_PROM+"</td>";
                  content += "<td width='80'  class='r3' id='4tdId2"+i+"'>"+strDtl[i].MOD_PROM+"</td>";
                  content += "<td width='100' class='r3' id='5tdId2"+i+"'>"+strDtl[i].MOD_REASON+"</td>"; 
                  content += "<td width='100' class='r1' id='6tdId2"+i+"'>"+getDateFormat(strDtl[i].MOD_TAKE_DT)+"</td>"; 
                  content += "</tr>";    
              } 
              
              document.getElementById("DIV_DETAIL").innerHTML = content; 
              setPorcCount("SELECT", strDtl.length);  
              content += "</table>";
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
  function getDetail2(i) {
  
      var strStrCd    = strMst[i].STR_CD;
      var strTakeDt   = strMst[i].TAKE_DT;
      var strTakeSeq  = strMst[i].TAKE_SEQ; 
      
      // 디테일 클리어
      detail_clear();
      
      var param = "&goTo=getDetail" 
      + "&strStrCd="      + strStrCd
      + "&strTakeDt="     + strTakeDt    //"20110525"
      + "&strTakeSeq="    + strTakeSeq ; //"42"
     var Urleren = "/edi/epro102.ep"; 
     URL = Urleren + "?" +param;  
     strDtl = getXMLHttpRequest();  
     strDtl.onreadystatechange = responseDetail2; 
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
  function responseDetail2()
  { 
       if(strDtl.readyState==4)
       {
            if(strDtl.status == 200)
            {
                strDtl = eval(strDtl.responseText);  
                  
              var content = "";
               content += "<table width='493' border='0' cellspacing='0' cellpadding='0' id='tb_list' class='g_table'>";
               content += "<tr>";
               content += "<th width='35'>NO</th>";
               content += "<th width='90'>이력항목</th>";
               content += "<th width='80'>이전약속</th>";
               content += "<th width='80'>변경약속</th>";  
               content += "<th width='100'>변경사유</th>";  
               content += "<th width='100'>변경접수일자</th>";  
               content += "</tr>"; 
               
            // 조회된 데이터가 없을땐 그리드를 그리지 않고 return
               if( strDtl == undefined ) { 
                   content += "</table>";
                   document.getElementById("DIV_DETAIL").innerHTML = content; 
                   return;
               }
            
               for( i = 0; i < strDtl.length; i++ ){ 
                   content += "<tr onclick='chBak2("+i+");' style='cursor:hand;'>";
                   content += "<td width='35'  class='r1' id='1tdId2"+i+"'>"+(i+1)+"</td>";
                   content += "<td width='90'  class='r3' id='2tdId2"+i+"'>"+strDtl[i].MOD_LISE+"</td>";
                   content += "<td width='80'  class='r3' id='3tdId2"+i+"'>"+strDtl[i].ORG_PROM+"</td>";
                   content += "<td width='80'  class='r3' id='4tdId2"+i+"'>"+strDtl[i].MOD_PROM+"</td>";
                   content += "<td width='100' class='r3' id='5tdId2"+i+"'>"+strDtl[i].MOD_REASON+"</td>"; 
                   content += "<td width='100' class='r1' id='6tdId2"+i+"'>"+getDateFormat(strDtl[i].MOD_TAKE_DT)+"</td>"; 
                   content += "</tr>";    
               } 
               
               document.getElementById("DIV_DETAIL").innerHTML = content;
               content += "</table>";
            } 
       }
  }

 function chBak(val) {
    g_last_row = val;
    if (g_pre_row != g_last_row){
        for(i=1;i<7;i++) {  
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
         for(i=1;i<7;i++) {
             document.getElementById(i+"tdId2" + val).style.backgroundColor="#fff56E";
    
             if (g_pre_row2 != -1) {
                 document.getElementById(i+"tdId2"+g_pre_row2).style.backgroundColor="#ffffff";
             }
         }
     }
     
     g_pre_row2 = g_last_row2;
 }
 
/**
 * init_click()
 * 작 성 자 : 김정민
 * 작 성 일 : 2011-06-10
 * 개    요 :  재 조회시 그리드와 컨트롤 초기화
 * return값 : void
 */
 function init_click(){
	 
	 //MASTER부분 헤더세팅
	 var content="";
	 content += "<table width='283' border='0' cellspacing='0' cellpadding='0' id='tb_list' class='g_table'>";
     content += "<tr>";
     content += "<th width='35'>NO</th>";
     content += "<th width='90'>점</th>";
     content += "<th width='110'>접수일자</th>"; 
     content += "<th width='80'>SEQ</th>";  
     content += "</tr>"; 
     
     document.getElementById("DIV_MASTER").innerHTML = content;
     content += "</table>";
     
     //DETAIL부분 헤더세팅
     var content = "";
     content += "<table width='493' border='0' cellspacing='0' cellpadding='0' id='tb_list' class='g_table'>";
     content += "<tr>";
     content += "<th width='35'>NO</th>";
     content += "<th width='90'>이력항목</th>";
     content += "<th width='80'>이전약속</th>";
     content += "<th width='80'>변경약속</th>";  
     content += "<th width='100'>변경사유</th>";  
     content += "<th width='100'>변경접수일자</th>";   
     content += "</tr>"; 
     
     document.getElementById("DIV_DETAIL").innerHTML = content;
     content += "</table>";
      
 }
 
 /**
  * detail_clear()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011-06-10
  * 개    요 :  재 조회시 그리드와 컨트롤 초기화
  * return값 : void
  */
  function detail_clear(){
      
      
      //DETAIL부분 헤더세팅
      var content = "";
      content += "<table width='493' border='0' cellspacing='0' cellpadding='0' id='tb_list' class='g_table'>";
      content += "<tr>";
      content += "<th width='35'>NO</th>";
      content += "<th width='90'>이력항목</th>";
      content += "<th width='80'>이전약속</th>";
      content += "<th width='80'>변경약속</th>";  
      content += "<th width='100'>변경사유</th>";  
      content += "<th width='100'>변경접수일자</th>";   
      content += "</tr>"; 
      
      document.getElementById("DIV_DETAIL").innerHTML = content;
      content += "</table>";
       
  }
 
 /**
  * getSelectCombo()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  조회 (기준일 , 전표구분)
  * return값 : void
  */ 
 function getSelectCombo(syspat,compart, target){
     
     var param = "&goTo=getEtcCode&syspat="+syspat+"&compart="+compart;
     <ajax:open callback="on_SelectComboXML" 
         param="param" 
         method="POST" 
         urlvalue="/edi/ccom001.cc"/>
     
     
     <ajax:callback function="on_SelectComboXML"> 
     
     var sel_box = document.getElementById(target);
     if( rowsNode.length > 0){
         if( target == "promise" ){
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
  
</script>
</head>
<body class="PL10 PR07 PT15" onLoad="doinit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="396" class="title"><img
					src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13"
					align="absmiddle" class="PR05" /> 약속변경이력조회</td>
				<td>
				<table border="0" align="right" cellpadding="0" cellspacing="0">
					<tr>
						<td><img src="<%=dir%>/imgs/btn/search.gif" width="50"
							height="22" id="search" onClick="javascript:btn_Sch();" /></td>
						<td><img src="<%=dir%>/imgs/btn/new.gif" width="50"
							height="22" id="newrow" onClick="addRow();" /></td>
						<td><img src="<%=dir%>/imgs/btn/del.gif" width="50"
							height="22" id="del" /></td>
						<td><img src="<%=dir%>/imgs/btn/save.gif" width="50"
							height="22" id="save" /></td>
						<td><img src="<%=dir%>/imgs/btn/excel.gif" width="61"
							height="22" id="excel" /></td>
						<td><img src="<%=dir%>/imgs/btn/print.gif" width="50"
							height="22" id="prints" /></td>
						<td><img src="<%=dir%>/imgs/btn/set.gif" width="50"
							height="22" id="set" /></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="60" class="POINT">점</th>
						<td width="180">
						<input name="strcd" id="strcd"
						    size="3" maxlength="2" value="<%=strcd%>" disabled="disabled" />
						<input type="text" name="strnm" id="strnm"
							size="22" maxlength="40" value="<%=strNm%>" disabled="disabled" />
					    </td>
						<th width="60" class="POINT">협력사코드</th>
						<td width="220"><input name="vencd" id="vencd"
							value="<%=vencd%>"  size="7" disabled="disabled" /> <input type="text"
							name="venNM" id="venNM" size="25" value="<%=venNm %>"
							disabled="disabled" /></td>
					    <th width="60">브랜드코드</th>
			            <td>
			                <select name="pubumCd" id="pubumCd" style="width: 150;"> 
			                </select>
			            </td> 
					</tr>
					<tr> 
					   <th class="POINT" >조회구분</th>
                        <td>
                            <select name="selectgbn" id="selectgbn" style="width: 180;"> 
                            </select>
                        </td> 
                        <th class="POINT">기간</th>
			            <td colspan="3">
			                 <input type="text" name="em_S_Date" id="em_S_Date" size="11" title="YYYY/MM/DD" value="" maxlength="10" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);"  style='text-align:center;IME-MODE: disabled' /> 
			                 <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onclick="openCal('G',em_S_Date);return false;" />  ~ 
			                 <input type="text" name="em_E_Date" id="em_E_Date" size="11" maxlength="10" value="" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' />
			                 <img src="<%=dir%>/imgs/btn/date.gif" alt="종료일" align="absmiddle" onclick="openCal('G',em_E_Date);return false;" />
			            </td>
					</tr>
					<tr>
					   <th>고객명</th>
                        <td>
                            <input name="customnm" id="customnm"  size="28" maxlength="40" /> 
                        </td>
                        <th>약속유형</th>
                        <td colspan="3">
                            <select name="promise" id="promise" style="width: 220;"> 
                            </select>
                        </td> 
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
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
		<table width="100%" height="100%" border="0" cellspacing="0"
			cellpadding="0"  >
			<tr>
                <td width="300px"> 
                   <table width="300px" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="sub_title">&nbsp;<img
                                    src="<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                                    align="absmiddle" />고객약속대장</td>
                        </tr>
                    </table> 
                </td>
                 <td width="1%">
                 </td>
                 <td width="100%"> 
                    <table width="480px" border="0" cellspacing="0" cellpadding="0">
                         <tr>
                             <td class="sub_title">&nbsp;<img
                                    src="<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                                    align="absmiddle" />변경이력</td>
                         </tr>
                     </table>
                 </td>  
            </tr>
            <tr>
                <td height="2"></td>
            </tr>
			<tr>
				<td width="300px">
				<table width="300px" border="0" cellpadding="0" cellspacing="0"  class="BD4A">
					<tr valign="top">
						<td>
							<div id="DIV_MASTER"
								style="width: 300px; height: 447; overflow:scroll" >
							<table width="485" border="0" cellpadding="0" id="tb_list"
								cellspacing="0" class="g_table"> 
								<tr>
									<th width="35">NO</th>
									<th width="100">점</th>
									<th width="90">접수일자</th> 
                                    <th width="80">SEQ</th> 
						            <th width='90'>약속유형</th> 
						            <th width='90'>고객명</th> 
								</tr>
							</table>
							</div>
						</td>  
					</tr>
				</table>
				</td> 
                <td width="1%"></td>
				<td width="100%"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="BD4A">
                        <tr>
                            <td>
                                <div id="DIV_DETAIL"
                                    style="width: 510px; height: 447;  overflow:scroll">
                                <table width="493px" border="0" cellpadding="0" id="tb_list"
                                    cellspacing="0" class="g_table">
                                    <tr>
                                        <th width="35">NO</th>
                                        <th width="90">이력항목</th>
                                        <th width="80">이전약속</th>
                                        <th width="80">변경약속</th> 
                                        <th width="100">변경사유</th> 
                                        <th width="100">변경접수일자</th> 
                                    </tr>
                                </table>
                                </div>
                            </td>
                        </tr>
                    </table> 
                </td>  
			</tr>
		</table>
		</td>
	</tr>
</table>

</body>
</html>

