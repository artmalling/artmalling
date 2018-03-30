
<!-- 
/*******************************************************************************
 * 시스템명 : 협력사EDI > 임대정보> 임대청구내역조회
 * 작 성 일 : 2011.06.10
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : eren1010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 임대 청구내역 조회
 * 이    력 : 2011.06.10 (김정민) 신규작성 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="kr.fujitsu.ffw.base.BaseProperty,kr.fujitsu.ffw.util.String2,kr.fujitsu.ffw.control.ActionForm"%>
<%@ page import="ecom.util.Util"%>
<%@ page import="java.util.*"%>
<%@ page import="sun.misc.FormattedFloatingDecimal.Form"%>
<%@ page import="ecom.vo.SessionInfo2"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>
<%
	String dir = request.getContextPath();

	SessionInfo2 sessionInfo = (SessionInfo2) session
			.getAttribute("sessionInfo2");
	String userid = sessionInfo.getUSER_ID(); //사용자아이디
	String strcd = sessionInfo.getSTR_CD(); //점코드
	String strNm = sessionInfo.getSTR_NM(); //점명
	String vencd = sessionInfo.getVEN_CD(); //협력사코드
	String venNm = sessionInfo.getVEN_NAME(); //협력사명
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링</title>
<link href="<%=dir%>/css/ds.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="<%=dir%>/js/common.js"
	type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/popup.js"
	type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/message.js"
	type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/gauce.js"
	type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/global.js"
	type="text/javascript"></script>

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
var vencd = '<%=vencd%>';
var venNm = '<%=venNm%>';
var g_strcd = '<%=strcd%>';
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
    initDateText("YYYYMM", "sDate");                        //시작월
    initDateText("YYYYMM", "eDate");                        //종료월
      
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

	//    alert();
    var strStrcd = document.getElementById("strcd").value;                      //점코드
    var strVencd = document.getElementById("vencd").value;                      //협력사코드
    var sDate = getRawData(document.getElementById("sDate").value);             //시작월
    var eDate = getRawData(document.getElementById("eDate").value);             //종료월
   
    if( strVencd == "") {
    	showMessage(StopSign, Ok,  "USER-1000", "협력사는 반드시 입력하셔야 합니다.");  
        document.getElementById("strVencd").focus();
        return;	
    }
    
    if( strStrcd == "") {
        showMessage(StopSign, Ok,  "USER-1000", "점은 반드시 입력하셔야 합니다.");   
        document.getElementById("strStrcd").focus();
        return;  
    }
    
    
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
        document.getElementById("DIV_MASTER").innerHTML = "";  
        document.getElementById("DIV_DETAIL").innerHTML = "";  
        return;
    } 
    
    var param = "&goTo=getMaster" + "&strcd=" +   strStrcd
                                  + "&vencd=" +   strVencd
                                  + "&sDate=" + sDate
                                  + "&eDate=" + eDate;
    var Urleren = "/edi/eren101.er";  
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
			content += "<table width='230' cellspacing='0' cellpadding='0' border='0' class='g_table'> ";
            var strDetail = "<table width='280' border='0' cellspacing='0' cellpadding='0' id='tb_list' class='g_table'>"; 
            // 조회된 데이터가 없을땐 그리드를 그리지 않고 return
            if(strMst == undefined) { 
            	document.getElementById("DIV_MASTER").innerHTML = content;  
                document.getElementById("DIV_DETAIL").innerHTML = strDetail;  
                content += "</table>";
               setPorcCount("SELECT", 0);
               return; 
             }
             
             for( i = 0; i < strMst.length; i++ ){ 
            	 content += "<tr onclick='chBak("+i+");getMaster("+i+");' style='cursor:hand;'>";
                 content += "<td width='35'  class='r1' id='1tdId"+i+"'>"+(i+1)+"</td>";
                 content += "<td width='80'  class='r3' id='2tdId"+i+"'>"+strMst[i].STR_NM+"</td>";
                 content += "<td width='100' class='r1' id='3tdId"+i+"'>"+getDateFormat(strMst[i].CAL_YM)+"</td>"; 
                 content += "</tr>";  

              //   getMaster(i); 
             }
			   document.getElementById("DIV_MASTER").innerHTML = content; 
			   setPorcCount("SELECT", strMst.length);  
		     content += "</table>";

	       // 2011.07.15 kjm 추가
	       // 조회버튼 클릭시 하단그리드도 같이 조회
		     chBak(0);
		     getMaster(0);
		     getDetail2(0);
            
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
 * getMaster()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  마스터 조회 
 * return값 : void
 */ 
function getMaster( i ){    
	    document.getElementById("IN_STR_CD").value          = strMst[i].STR_CD;                         //점코드
        document.getElementById("IN_STR_NAME").value        = strMst[i].STR_NM;                         //점명
        document.getElementById("IN_S_DT").value            = getDateFormat(strMst[i].CNTR_S_DT);       //계약기간FROM
        document.getElementById("IN_E_DT").value            = getDateFormat(strMst[i].CNTR_E_DT);       //계약기간TO
        document.getElementById("IN_RENT_TYPE").value       = strMst[i].RENT_TYPE;                      //임대형태
        document.getElementById("IN_RENT_FLAG").value       = strMst[i].RENT_FLAG;                      //임대구분
        document.getElementById("IN_RENT_DEPOSIT").value    = convAmt(strMst[i].RENT_DEPOSIT);          //임대보증금
        document.getElementById("IN_MM_RENTFEE").value      = convAmt(strMst[i].MM_RENTFEE);            //임대료
        document.getElementById("IN_RENT_AMT").value        = convAmt(strMst[i].RENT_AMT);              //당월임대료
        document.getElementById("IN_RENT_VAT_AMT").value    = convAmt(strMst[i].RENT_VAT_AMT);          //당월임대료VAT
        document.getElementById("IN_TAX_AMT").value         = convAmt(strMst[i].TAX_AMT);               //당월과세관리비
        document.getElementById("IN_TAX_VAT_AMT").value     = convAmt(strMst[i].TAX_VAT_AMT);           //당월관리비VAT
        document.getElementById("IN_NTAX_AMT").value        = convAmt(strMst[i].NTAX_AMT);              //당월면세관리비
        document.getElementById("IN_BAL_AMT").value         = convAmt(strMst[i].BAL_AMT);               //미수관리비
        document.getElementById("IN_ARREAR_AMT").value      = convAmt(strMst[i].ARREAR_AMT);            //미수연체이자
        document.getElementById("IN_MOD_AMT").value         = convAmt(strMst[i].MOD_AMT);               //조정금액
        document.getElementById("IN_MOD_REASON").value      = strMst[i].MOD_REASON;                     //조정사유
        document.getElementById("IN_REAL_CHAREG_AMT").value = convAmt(strMst[i].REAL_CHAREG_AMT);       //청구액
             
        if( strMst.length > 0 ){
        	//alert();
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
 
	 var strStrCd   = strMst[i].STR_CD;
	 var strCalYm   = strMst[i].CAL_YM;
	 var strCntrId  = strMst[i].CNTR_ID;
	 var strCalType = strMst[i].CAL_TYPE; 
	 
	 var param = "&goTo=getDetail" 
	 + "&strStrCd="     +  strStrCd
     + "&strCalYm="     +  strCalYm
     + "&strCntrId="    + strCntrId
     + "&strCalType="   + strCalType;

	var Urleren = "/edi/eren101.er"; 
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
              content += "<table width='280' border='0' cellspacing='0' cellpadding='0' id='tb_list' class='g_table'>"; 
              USE_AMT = 0;
              
              if(strDtl == undefined) {
            	  alert();
                  document.getElementById("DIV_DETAIL").innerHTML = "";   
                  setPorcCount("SELECT", 0);
                  return; 
                }
              
              for( i = 0; i < strDtl.length; i++ ){ 
                  content += "<tr onclick='chBak2("+i+");' style='cursor:hand;'>";
                  content += "<td width='35'  class='r1' id='1tdId2"+i+"'>"+(i+1)+"</td>";
                  content += "<td width='100'  class='r3' id='2tdId2"+i+"'>"+strDtl[i].MNTN_ITEM_NM+"</td>";
                  content += "<td width='100' class='r4' id='3tdId2"+i+"'>"+convAmt(strDtl[i].USE_QTY)+"</td>";
                  content += "<td width='100' class='r4' id='4tdId2"+i+"'>"+convAmt(strDtl[i].USE_AMT)+"</td>";  
                  content += "</tr>";   
                  
                  USE_AMT += Number(strDtl[i].USE_AMT);
               //   getMaster(i); 
              }
              
              content += "<tr>";
              content += "<td class='sum1'>&nbsp;</td>"
              content += "<td class='sum1' colspan='2'>합 계</td>"
              content += "<td class='sum2'>"+convAmt(String(USE_AMT))+"</td>"; 
              content += "</tr>";
              
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
  
      var strStrCd   = strMst[i].STR_CD;
      var strCalYm   = strMst[i].CAL_YM;
      var strCntrId  = strMst[i].CNTR_ID;
      var strCalType = strMst[i].CAL_TYPE; 
      
      var param = "&goTo=getDetail" 
      + "&strStrCd="     +  strStrCd
      + "&strCalYm="     +  strCalYm
      + "&strCntrId="    + strCntrId
      + "&strCalType="   + strCalType;

     var Urleren = "/edi/eren101.er"; 
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
               content += "<table width='283' border='0' cellspacing='0' cellpadding='0' id='tb_list' class='g_table'>";
               content += "<tr>";
               content += "<th width='35'>NO</th>";
               content += "<th width='100'>관리항목</th>";
               content += "<th width='100'>사용량</th>";
               content += "<th width='100'>금액</th>";  
               content += "</tr>";
               
               USE_AMT = 0;
               
               if(strDtl == undefined) {
                   setPorcCount("SELECT", 0);
                   return; 
                 }
               
               for( i = 0; i < strDtl.length; i++ ){ 
                   content += "<tr onclick='chBak2("+i+");' style='cursor:hand;'>";
                   content += "<td width='35'  class='r1' id='1tdId2"+i+"'>"+(i+1)+"</td>";
                   content += "<td width='100'  class='r3' id='2tdId2"+i+"'>"+strDtl[i].MNTN_ITEM_NM+"</td>";
                   content += "<td width='100' class='r4' id='3tdId2"+i+"'>"+convAmt(strDtl[i].USE_QTY)+"</td>";
                   content += "<td width='100' class='r4' id='4tdId2"+i+"'>"+convAmt(strDtl[i].USE_AMT)+"</td>";  
                   content += "</tr>";   
                   
                   USE_AMT += Number(strDtl[i].USE_AMT);
                //   getMaster(i); 
               }
               
               content += "<tr>";
               content += "<td class='sum1'>&nbsp;</td>"
               content += "<td class='sum1' colspan='2'>합 계</td>"
               content += "<td class='sum2'>"+convAmt(String(USE_AMT))+"</td>"; 
               content += "</tr>";
               
               document.getElementById("DIV_DETAIL").innerHTML = content; 
               content += "</table>"; 
            } 
       }
  } 
 
 
/**
 * chBak(val)
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  그리드에서 마우스 포인터가 있을때 그리드 row 색상변경
 * return값 : void
 */  
function chBak(val) {
    for(i=1;i<4;i++) {
        document.getElementById(i+"tdId"+val).style.backgroundColor="#ffff00";
    }
}

/**
 * reBak(val)
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 : 그리드에서 마우스 포인터가 벗어났을때 그리드 row 색상변경
 * return값 : void
 */  
function reBak(val) {
    for(i=1;i<4;i++) {
        document.getElementById(i+"tdId"+val).style.backgroundColor="#ffffff";
    }
}
 
/**
 * chBak2(val)
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  그리드에서 마우스 포인터가 있을때 그리드 row 색상변경
 * return값 : void
 */  
function chBak2(val) { 
	g_last_row = val;
   // alert(g_pre_row);
 //   alert(g_last_row);
    if (g_pre_row != g_last_row){
        for(i=1;i<5;i++) {
            document.getElementById(i+"tdId2"+val).style.backgroundColor="#fff56E";
      //      alert("1");
            if (g_pre_row != -1) {
                document.getElementById(i+"tdId2"+g_pre_row).style.backgroundColor="#ffffff";
            }
        }
    }
    g_pre_row = g_last_row; 
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
	 content += "<table width='233' border='0' cellspacing='0' cellpadding='0' id='tb_list' class='g_table'>";
     content += "<tr>";
     content += "<th width='35'>NO</th>";
     content += "<th width='80'>점</th>";
     content += "<th width='100'>청구년월</th>";  
     content += "</tr>"; 
     
     document.getElementById("DIV_MASTER").innerHTML = content;
     content += "</table>";
     
     //DETAIL부분 헤더세팅
     var content = "";
     content += "<table width='283' border='0' cellspacing='0' cellpadding='0' id='tb_list' class='g_table'>";
     content += "<tr>";
     content += "<th width='35'>NO</th>";
     content += "<th width='100'>관리항목</th>";
     content += "<th width='100'>사용량</th>";
     content += "<th width='100'>금액</th>";  
     content += "</tr>"; 
     
     document.getElementById("DIV_DETAIL").innerHTML = content;
     content += "</table>";
     
     //컨트롤 초기화
     document.getElementById("IN_STR_CD").value          = "";  //점코드
     document.getElementById("IN_STR_NAME").value        = "";  //점명
     document.getElementById("IN_S_DT").value            = "";  //계약기간FROM
     document.getElementById("IN_E_DT").value            = "";  //계약기간TO
     document.getElementById("IN_RENT_TYPE").value       = "";  //임대형태
     document.getElementById("IN_RENT_FLAG").value       = "";  //임대구분
     document.getElementById("IN_RENT_DEPOSIT").value    = "";  //임대보증금
     document.getElementById("IN_MM_RENTFEE").value      = "";  //임대료
     document.getElementById("IN_RENT_AMT").value        = "";  //당월임대료
     document.getElementById("IN_RENT_VAT_AMT").value    = "";  //당월임대료VAT
     document.getElementById("IN_TAX_AMT").value         = "";  //당월과세관리비
     document.getElementById("IN_TAX_VAT_AMT").value     = "";  //당월관리비VAT
     document.getElementById("IN_NTAX_AMT").value        = "";  //당월면세관리비
     document.getElementById("IN_BAL_AMT").value         = "";  //미수관리비
     document.getElementById("IN_ARREAR_AMT").value      = "";  //미수연체이자
     document.getElementById("IN_MOD_AMT").value         = "";  //조정금액
     document.getElementById("IN_MOD_REASON").value      = "";  //조정사유
     document.getElementById("IN_REAL_CHAREG_AMT").value = "";  //청구액
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
					align="absmiddle" class="PR05" /> 임대청구내역조회</td>
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
						<th width="80" class="POINT">점</th>
						<td width="130"><input name="strcd" id="strcd" size="3"
							maxlength="2" value="<%=strcd%>" disabled="disabled" /> <input
							type="text" name="strnm" id="strnm" size="13" maxlength="40"
							value="<%=strNm%>" disabled="disabled" /></td>
						<th width="80" class="POINT">협력사코드</th>
						<td width="160"><input name="vencd" id="vencd"
							value="<%=vencd%>" size="7" disabled="disabled" /> <input
							type="text" name="venNM" id="venNM" size="14" value="<%=venNm%>"
							disabled="disabled" /></td>
						<th width="80" class="POINT">청구년월</th>
						<td><input type="text" name="sDate" id="sDate" size="11"
							onkeypress="javascript:onlyNumber();" onblur="dateOnblur(this);"
							onfocus="dateValid(this);"
							style='text-align: center; IME-MODE: disabled' maxlength="6" />
						<img src="<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('M',sDate)" align="absmiddle" />~ <input
							type="text" name="eDate" id="eDate" size="11"
							onkeypress="javascript:onlyNumber();" onblur="dateOnblur(this);"
							onfocus="dateValid(this);"
							style='text-align: center; IME-MODE: disabled' maxlength="6" />
						<img src="<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('M',eDate)" align="absmiddle" /></td>
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
			cellpadding="0">
			<tr>
				<td width="250px">
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="BD4A">
					<tr valign="top">
			        <td><div id="topTitle" style="width:250px;overflow:hidden;">
			                <table width="250" cellpadding="0" cellspacing="0" border="0" class="g_table" >
			                    <tr>
	                                <th width="35">NO</th>
	                                <th width="80">점</th>
	                                <th width="100">청구년월</th>
			                        <th width="15">&nbsp;</th>
			                    </tr>
			                </table>
			            </div>        
			        </td>
			      </tr>
			      <tr>
			          <td ><div id="DIV_MASTER" style="width:250px;height:482px;overflow:scroll" onscroll="scrollAll();">
			                  <table width="230" cellspacing="0" cellpadding="0" border="0" class="g_table"> 
			                  </table>  
			              </div>
			          </td>  
			      </tr> 
				</table>
				</td>
				<td width="3px"></td>
				<td class="PB03">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="2"></td>
					</tr>
					<tr>
						<td class="PT5" colspan=2>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title">&nbsp;<img
									src="<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
									align="absmiddle" />계약정보
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="2"></td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="100">점</th>
								<td width="160"><input name="IN_STR_CD" id="IN_STR_CD"
									size="3" maxlength="10" disabled="disabled" /> <input
									type="text" name="IN_STR_NAME" id="IN_STR_NAME" size="19"
									maxlength="40" disabled="disabled" /></td>
								<th width="100">계약기간</th>
								<td><input name="IN_S_DT" id="IN_S_DT" size="10"
									disabled="disabled" style="text-align: center;" /> ~ <input
									name="IN_E_DT" id="IN_E_DT" size="10" disabled="disabled"
									style="text-align: center;" /></td>
							</tr>
							<tr>
								<th>임대형태</th>
								<td><input name="IN_RENT_TYPE" id="IN_RENT_TYPE" size="24"
									disabled="disabled" /></td>
								<th>임대구분</th>
								<td><input name="IN_RENT_FLAG" id="IN_RENT_FLAG" size="24"
									disabled="disabled" /></td>
							</tr>
							<tr>
								<th>임대보증금</th>
								<td><input type="text" size="24" id="IN_RENT_DEPOSIT"
									name="IN_RENT_DEPOSIT" style="text-align: right;"
									disabled="disabled" /></td>
								<th>임대료</th>
								<td><input type="text" size="24" id="IN_MM_RENTFEE"
									name="IN_MM_RENTFEE" style="text-align: right;"
									disabled="disabled" /></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="2"></td>
					</tr>
					<tr class="PT10">
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="300px">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td class="sub_title">&nbsp;<img
											src="<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
											align="absmiddle" />관리비항목별 내역</td>
									</tr>
								</table>
								</td>
								<td width="3px"></td>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td class="sub_title">&nbsp;<img
											src="<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
											align="absmiddle" />관리비정산 내역</td>
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
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr valign="top">
								<td width="300px">
								<table width="300px" border="0" cellpadding="0" cellspacing="0"
									class="BD4A">
									<tr valign="top">
				                    <td><div id="topTitleD" style="width:300px;overflow:hidden;">
				                            <table width="300" cellpadding="0" cellspacing="0" border="0" class="g_table" >
				                                <tr>
	                                                <th width="35">NO</th>
	                                                <th width="100">관리항목</th>
	                                                <th width="100">사용량</th>
	                                                <th width="100">금액</th>
				                                    <th width="15">&nbsp;</th>
				                                </tr>
				                            </table>
				                        </div>        
				                    </td>
				                  </tr>
				                  <tr>
				                      <td ><div id="DIV_DETAIL" style="width:300px;height:365px;overflow:scroll" onscroll="scrollAll();">
				                              <table width="280" cellspacing="0" cellpadding="0" border="0" class="g_table"> 
				                              </table>  
				                          </div>
				                      </td>  
				                  </tr>  
								</table>
								</td>
								<td width="3px"></td>
								<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0"
									class="s_table">
									<tr>
										<th width="20px" rowspan="5">당<BR>
										월</th>
										<th width="80px">임대료</th>
										<td><input type="text" size="18" id="IN_RENT_AMT"
											name="IN_RENT_AMT" style="text-align: right;"
											disabled="disabled" /></td>
									</tr>
									<tr>
										<th>임대료VAT</th>
										<td><input type="text" size="18" id="IN_RENT_VAT_AMT"
											name="IN_RENT_VAT_AMT" style="text-align: right;"
											disabled="disabled" /></td>
									</tr>
									<tr>
										<th>과세관리비</th>
										<td><input type="text" size="18" id="IN_TAX_AMT"
											name="IN_TAX_AMT" style="text-align: right;"
											disabled="disabled" /></td>
									</tr>
									<tr>
										<th>관리비VAT</th>
										<td><input type="text" size="18" id="IN_TAX_VAT_AMT"
											name="IN_TAX_VAT_AMT" style="text-align: right;"
											disabled="disabled" /></td>
									</tr>
									<tr>
										<th>면세관리비</th>
										<td><input type="text" size="18" id="IN_NTAX_AMT"
											name="IN_NTAX_AMT" style="text-align: right;"
											disabled="disabled" /></td>
									</tr>
									<tr>
										<th rowspan="2">미<BR>
										수</th>
										<th>관리비</th>
										<td><input type="text" size="18" id="IN_BAL_AMT"
											name="IN_BAL_AMT" style="text-align: right;"
											disabled="disabled" /></td>
									</tr>
									<tr>
										<th>연체이자</th>
										<td><input type="text" size="18" id="IN_ARREAR_AMT"
											name="IN_ARREAR_AMT" style="text-align: right;"
											disabled="disabled" /></td>
									</tr>
									<tr>
										<th rowspan="2">조<BR>
										정</th>
										<th>조정금액</th>
										<td><input type="text" size="18" id="IN_MOD_AMT"
											name="IN_MOD_AMT" style="text-align: right;"
											disabled="disabled" /></td>
									</tr>
									<tr>
										<th>조정사유</th>
										<td><input name="IN_BJHJDATE" id="IN_MOD_REASON"
											size="18" disabled="disabled" /></td>
									</tr>
									<tr>
										<th colspan="2">청구액</th>
										<td><input type="text" size="18" id="IN_REAL_CHAREG_AMT"
											name="IN_REAL_CHAREG_AMT" style="text-align: right;"
											disabled="disabled" /></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
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
