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
    
 // PID 확인을 위한
    String pageName = request.getRequestURI();
    int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
    int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
    pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

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
var pumbunNm    = '<%=pumbunNm%>';
var g_pre_row   = -1;
var g_last_row  = -1;
var g_pre_row2  = -1;
var g_last_row2 = -1;
var strMst = "";

var	strToday = getTodayFormat("yyyymmdd");
var	strSDate = addDate('M',	-1,	strToday);
var g_strPid           = "<%=pageName%>";                 // PID

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-06-28 
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 
function doinit(){
     
    /*  버튼비활성화  */
    enableControl(newrow,false);	//신규    
    enableControl(del   ,false);    //삭제
    enableControl(save  ,false);    //저장
    enableControl(excel,true);    //엑셀
    enableControl(prints,false);    //프린터
    enableControl(set   ,false);    //프린터
    
    /*  조회 항목  */
    //initDateText('SYYYYMMDD', 'em_S_Date');		//시작일
    initDateText('TODAY', 'em_S_Date');		//시작일
    initDateText("TODAY"    , "em_E_Date");		//종료일
    
    /* 구분 값이 브랜드로 로그인시 "전체" 값 없음 */
    if(gb=="1"){
    	getPumbunCombo(g_strcd, vencd, "pumbunCd", "Y", pumbunCd);		//점별 브랜드
    }else{
    	getPumbunCombo(g_strcd, vencd, "pumbunCd", "N", pumbunCd);		//점별 브랜드
    }
//    getSelectCombo("D", "M100", "birth_s");
//    getSelectCombo("D", "M100", "birth_e");
    getSelectCombo("D", "P627", "age");
    
    
    document.getElementById("strcd").value = '<%=strcd%>';
}

/**
 * getPumbunCombo()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-06-28
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
 * getSelectCombo()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-06-28
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
 * 작 성 일 : 2012-06-28
 * 개    요 :  조회
 * return값 : void
 */ 
function btn_Sch(){
    var sDate = document.getElementById("em_S_Date").value;
    var eDate = document.getElementById("em_E_Date").value;
	
    if( sDate.length == 0 ){
        showMessage(INFORMATION, OK, "USER-1003", "시작일");
        sDate.Text = initDateText('SYYYYMMDD', 'em_S_Date');
        document.getElementById("em_S_Date").focus();
        return;
    }
    
    if( eDate.length == 0 ){
        showMessage(INFORMATION, OK, "USER-1003", "종료일");
        eDate.Text = initDateText("TODAY"    , "em_E_Date");
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

function btn_Excel(){
	if (strMst.length < 1) {
	    showMessage(INFORMATION, OK, "USER-1000", "조회 된 내역이 없습니다.");
	} else {
	    var strStrcd     = document.getElementById("strcd").value;
	    var strVencd     = document.getElementById("vencd").value;
	    var strPumbuncd  = document.getElementById("pumbunCd").value;
	    var strCustName  = document.getElementById("custname").value;
	    var strCardNo	 = document.getElementById("cardno").value;
	    var strSale_S	 = document.getElementById("sale_s").value;
	    var strSale_E	 = document.getElementById("sale_e").value;
	    var strHomeAddr1 = document.getElementById("homeaddr1").value;
	    var strAge		 = document.getElementById("age").value;
	    var pummokcd	 = document.getElementById("pummokcd").value;
	    
	    var sexcd;
	    var sex_btn = document.getElementsByName("IN_SEX_CD");
	    for (var i=0; i < sex_btn.length; i++) {
	    	
	    	if (sex_btn[i].checked == true) {
	    		sexcd = sex_btn[i].value;
	    		break;
	    	}
	    }
	    
	    var sDate       = getRawData(trim(document.getElementById("em_S_Date").value));
	    var eDate       = getRawData(trim(document.getElementById("em_E_Date").value));
	      
		var param = "&goTo=getExcel"  + "&strcd=" + strStrcd
        							  + "&vencd=" + strVencd
      								  + "&pumbunCd=" + strPumbuncd
      								  + "&custname=" + encodeURIComponent(strCustName)
     							      + "&cardno=" + strCardNo
     							      + "&em_S_Date=" + sDate
    							      + "&em_E_Date=" + eDate
   								      + "&strSale_S=" + strSale_S
     							      + "&strSale_E=" + strSale_E
//    							      + "&strBirth_S=" + strBirth_S
//     							      + "&strBirth_E=" + strBirth_E
    							      + "&strHomeAddr1=" + encodeURIComponent(strHomeAddr1)
     							      + "&strAge=" + strAge
   								      + "&sexcd=" + sexcd
									  + "&pummokcd=" + pummokcd;
	
	    var Urleren = "/edi/esal112.es?" + param; 
	    iFrame.location.href=Urleren;
	    
	   /* URL = Urleren + "?" +param;
	    strMst = getXMLHttpRequest();
	    strMst.onreadystatechange = responseGetSearch;
	    strMst.open("POST", URL, true);
	    strMst.setRequestHeader('Content-Type','application/x-www-form-urlencoded');   //한글 (POST시 반듯이 해당문구를 사용해야 Param으로인식)
	    strMst.send(null);*/
	    
	}
}
/**
 * getSearch()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-06-28
 * 개    요 :  마스터조회
 * return값 : void
 */ 

 
function getSearch(){
	g_row			= -1;
	g_pre_row		= -1;
	
	//"strcd" ~ "em_E_Date" body 안에 있는 값들이랑 매칭
	//document.getElementById("DIV_Content").innerHTML = "";
	//document.all.DivListTitle.scrollLeft = 0;
    //document.all.DivListContent.scrollLeft = 0;
    var strStrcd     = document.getElementById("strcd").value;
    var strVencd     = document.getElementById("vencd").value;
    var strPumbuncd  = document.getElementById("pumbunCd").value;
    var strCustName  = document.getElementById("custname").value;
    var strCardNo	 = document.getElementById("cardno").value;
    var strSale_S	 = document.getElementById("sale_s").value;
    var strSale_E	 = document.getElementById("sale_e").value;
    var strHomeAddr1 = document.getElementById("homeaddr1").value;
    var strAge		 = document.getElementById("age").value;
    var pummokcd	 = document.getElementById("pummokcd").value;
    
    var sexcd;
    var sex_btn = document.getElementsByName("IN_SEX_CD");
    for (var i=0; i < sex_btn.length; i++) {
    	
    	if (sex_btn[i].checked == true) {
    		sexcd = sex_btn[i].value;
    		break;
    	}
    }
    
    var sDate       = getRawData(trim(document.getElementById("em_S_Date").value));
    var eDate       = getRawData(trim(document.getElementById("em_E_Date").value));
    var param = "&goTo=getMaster" + "&strcd=" + strStrcd
                                  + "&vencd=" + strVencd
                                  + "&pumbunCd=" + encodeURIComponent(strPumbuncd)
                                  + "&custname=" + encodeURIComponent(strCustName)
                                  + "&cardno=" + strCardNo
                                  + "&em_S_Date=" + sDate
                                  + "&em_E_Date=" + eDate
                                  + "&strSale_S=" + strSale_S
                                  + "&strSale_E=" + strSale_E
//                                  + "&strBirth_S=" + strBirth_S
//                                  + "&strBirth_E=" + strBirth_E
                                  + "&strHomeAddr1=" + encodeURIComponent(strHomeAddr1)
                                  + "&strAge=" + strAge
                                  + "&sexcd=" + encodeURIComponent(sexcd)
    							  + "&pummokcd=" + pummokcd;
    
    var Urleren = "/edi/esal112.es";
    URL = Urleren + "?" +param;
    strMst = getXMLHttpRequest();
    strMst.onreadystatechange = responseGetSearch;
    strMst.open("POST", URL, true);
    strMst.setRequestHeader('Content-Type','application/x-www-form-urlencoded');   //한글 (POST시 반듯이 해당문구를 사용해야 Param으로인식)
    strMst.send(null);
 }
 
function responseGetSearch() {
		if (strMst.readyState == 4) {
			if (strMst.status == 200) {
				strMst = eval(strMst.responseText);
				var master_content = "";
				var d_content = "";
				tot = 0;
				
				master_content = "<table id ='tb1' width='880' border='0' cellspacing='0' cellpadding='0' class='g_table'>";

				if (strMst == undefined) {
					master_content += "	<tr>";
					master_content += "		<td class='r1' width='30'></td>";
					master_content += "		<td class='r1' width='70'></td>";
					master_content += "		<td class='r1' width='45'></td>";
					master_content += "		<td class='r1' width='45'></td>";
					master_content += "		<td class='r1' width='120'></td>";
					master_content += "		<td class='r1' width='85'></td>";
					master_content += "		<td class='r1' width='190'></td>";
					master_content += "		<td class='r1' width='50'></td>";
					master_content += "		<td class='r1' width='50'></td>";
					master_content += "		<td class='r1' width='155'></td>";
					master_content += "		<td class='r1' width='45'></td>";
					//master_content += "		<td class='r1' width='130'></td>";
					//master_content += "		<td class='r1' width='230'></td>";
					master_content += "	</tr>";
					master_content += "</table>";

					document.getElementById("DIV_Content").innerHTML = master_content;


					setPorcCount("SELECT", "0");
					return;
					
				} else if (strMst.length > 0) {
					for (i = 0; i < strMst.length; i++) {
						//String cols = "SALE_DT,CUST_NAME,CARDNO,AMT,HOME,SEX_CD,PUMMOK_CD,ITEM_NAME,SALE_QTY";  --강연식
						master_content += "<tr style='cursor:hand;'>";				
						master_content += "<td width='30' class='r1' id='1tdId"+i+"' align='center'>"	+ (i + 1);
						master_content += "</td>";
						master_content += "<td width='70' class='r1' id='2tdId"+i+"' align='center'>"	+ strMst[i].SALE_DT;
	//					master_content += "<input type='hidden' name='PUMBUN_CD'	id='PUMBUN_CD"+i+"'	value='"+strMst[i].PUMBUN_CD+"'/>"; //CUST_ID
						master_content += "</td>";
						master_content += "<td width='45' class='r1' id='3tdId"+i+"' align='center'>"	+ strMst[i].CUST_NAME + "XX</td>";
						master_content += "<td width='45' class='r1' id='4tdId"+i+"' align='center'>"	+ strMst[i].CUST_AGE + "</td>";
//						master_content += "<td width='120' class='r1' id='1tdId"+i+"' align='center'>"	+ getCardNo(strMst[i].CARDNO);
						master_content += "<td width='120' class='r1 msoTxt1' id='5tdId"+i+"' align='center' onclick='javascript:clk_card(this);'>"	+ (strMst[i].CARDNO);
	//					master_content += "<input type='hidden' name='CUST_ID'	id='CUST_ID"+i+"'	value='"+strMst[i].CUST_ID+"'/>"; //CUST_ID
						master_content += "</td>";
						
						master_content += "<td width='85' class='r4' id='6tdId"+i+"' align='center'>"	+ convAmt(strMst[i].AMT) + "</td>";
						tot += (parseInt(strMst[i].AMT));
						master_content += "<td width='190' class='r1' id='7tdId"+i+"' align='center'>"	+ strMst[i].HOME + "</td>";
						master_content += "<td width='50' class='r1' id='8tdId"+i+"' align='center'>"	+ strMst[i].SEX_CD + "</td>";
						master_content += "<td width='50' class='r1' id='9tdId"+i+"' align='center'>"	+ strMst[i].PUMMOK_CD + "</td>";
						master_content += "<td width='155' class='r1' id='10tdId"+i+"' align='center'>"	+ strMst[i].ITEM_NAME + "</td>";
						master_content += "<td width='45' class='r1' id='11tdId"+i+"' align='center'>"	+ strMst[i].SALE_QTY + "</td>";
						
						master_content += "</tr>";
					}
					master_content += "<tr style='cursor:hand;'>";
					master_content += "<td colspan ='5' class='r1' id='1tdIdtot1' align='center'>"	+ "합    계" + "</td>";
					master_content += "<td colspan ='4' class='r1' id='1tdIdtot2' align='center'>"	+ "￦  " +convAmt(tot.toString()) + "</td>";
					master_content += "<td colspan ='2' class='r1' id='1tdIdtot3' align='center'>"	+ "아트몰링" + "</td>";
					master_content += "</tr>";
					master_content += "</table>";
					document.getElementById("DIV_Content").innerHTML = master_content;
					setPorcCount("SELECT", strMst.length);				
				} 
			}
		}
	}

	/**
	 * getDetail()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2012-06-28
	 * 개    요 :  디테일 조회
	 * return값 : void
	 */
	function getDetail2(row) {

	}

	function getXMLHttpRequest() {
		if (window.ActiveXObject) {
			try {
				return new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e1) {
				try {
					return new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e2) {
					return null;
				}
			}
		} else if (window.XMLHttpRequest) {
			return new XMLHttpRequest();
		} else {
			return null;
		}
	}


	function scrollAll() {
		document.all.DIV_TITLE.scrollLeft = document.all.DIV_Content.scrollLeft;
	}

	function scrollAll2() {
		document.all.DETAIL_TITLE.scrollLeft = document.all.DETAIL_CONTENT.scrollLeft;
	}
	
	// CARD_NO 자리수 나누기
 	function getCardNo(val) {
		var rtnVal = "";
		if(val.indexOf("-")<1) {
			rtnVal = val.substr(0, 4) + "-" + val.substr(4, 4) + "-" + val.substr(8, 4) + "-" + val.substr(12);
		}
		return rtnVal;
	}
	

 	//숫자 체크
 	function NumChk() {
 		if(event.keyCode < 45 || event.keyCode > 57)
 			event.returnValue = false
 	}
 	function fn_setCombo(objVal, val) {
 		var obj = document.getElementById(objVal);

 		if(val != "") {
 			for(var i=0;i<obj.length;i++) {
 				if(obj[i].value == val) {
 					obj[i].selected = true;
 					break;
 				}
 			}
 		}
 	}
 	
 	//카드번호 클릭 시 카드번호 form 에 입력
 	function clk_card(obj){
 		var can = obj.innerText;
 		document.getElementById("cardno").value = can;
 	}
 	
</script>
</head>
<body  class="PL10 PR07 PT15" onload="doinit();">
<iframe id=iFrame name=iFrame src="about:blank" width=0 height=0></iframe>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>
        	보너스카드회원매출조회
        </td>
        <td>
	        <table border="0" align="right" cellpadding="0" cellspacing="0">
	          <tr>
	            <td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onclick="javascript:btn_Sch();"/></td>
	            <td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow" onclick="addRow();" /></td>
	            <td><img src="<%=dir%>/imgs/btn/del.gif" width="50" height="22" id="del" /></td>
	            <td><img src="<%=dir%>/imgs/btn/save.gif" width="50" height="22" id="save" /></td>
	            <td><img src="<%=dir%>/imgs/btn/excel.gif" width="61" height="22" id="excel" onclick="javascript: if(!chBakClr(11)){ excelExport('보너스카드회원매출조회','TBL',pumbunCd);}"/></td>
	            <td><img src="<%=dir%>/imgs/btn/print.gif" width="50" height="22" id="prints" /></td>
	            <td><img src="<%=dir%>/imgs/btn/set.gif" width="50" height="22" id="set" /></td>      
	          </tr>
	        </table>
        </td>
      </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="50" class="POINT">점</th>
            <td width="100"><input type="text"  name="strNm" id="strNm" size="13" maxlength="8" value="<%=strNm%>" disabled="disabled" /><input type="hidden" name="strcd" id="strcd"  ></td>
            <th width="80" class="POINT">협력사코드</th>
            <td width="140">
                <input type="hidden" name="vencd" id="vencd" value="<%=vencd%>" disabled="disabled"  />
                <input type="text" name="venNm" id="venNm" size="20" value="<%=venNm %>" disabled="disabled" />
            </td>
            <th width="80">브랜드코드</th>
            <td colspan="3">
                <select name="pumbunCd" id="pumbunCd" style="width: 200;"></select>
            </td>
          </tr>
          <tr>
            <th width="50">고객명</th>
            <td width="100">
            	<input type="text"  name="custname" id="custname" size="13" maxlength="10" />
            </td>
            
            <th width="120">카드번호</th>
            <td width="120">
            	<input type="text" name="cardno" id="cardno" size="20" maxlength="16"/>
				
            </td>
          
            <th >기간</th>
            <td colspan="3">
                <input type="text" name="em_S_Date" id="em_S_Date" size="9" title="YYYY/MM/DD" value="" maxlength="9" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);"  style='text-align:center;IME-MODE: disabled' /> 
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onclick="openCal('G',em_S_Date);return false;" /> ~
                 <input type="text" name="em_E_Date" id="em_E_Date" size="9" maxlength="9" value="" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' />
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="종료일" align="absmiddle" onclick="openCal('G',em_E_Date);return false;" />
            </td>
            
            <th width = "40">성별</th>
            <td>
            <input type="radio" name="IN_SEX_CD" id="IN_SEX_CD" value="M" />남&nbsp;
				<input type="radio" name="IN_SEX_CD" id="IN_SEX_CD" value="F" />여 &nbsp;
				<input type="radio" name="IN_SEX_CD" id="IN_SEX_CD" value="%" checked />전체&nbsp;
		    </td>
          </tr>
          <tr>
			<th width="50">
				지역
			</th>
			<td width ='100'>
				<input type="text"  name="homeaddr1" id="homeaddr1" size="13" maxlength="10" />
			</td>
			<th width="50">
				품목코드
			</th>
			<td>
				<input type="text" size="7" maxlength ="4" name = "pummokcd" id ="pummokcd" />
			<!--  <select name="birth_s" id="birth_s" style="width: 60;"></select> ~ 
				<select name="birth_e" id="birth_e" style="width: 60;"></select>
			-->
			</td>
			<th width="80">
				구매금액
			</th>
			<td width="250" colspan = "3">
				<input type="text"  name="sale_s" id="sale_s" size="10" maxlength="10" /> ~ 
				<input type="text"  name="sale_e" id="sale_e" size="10" maxlength="10" />
			</td>
			<th width="40">
				연령별
			</th>
			<td>
				<select name="age" id="age" style="width: 60;"></select>
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
	                <div id="DIV_TITLE" style=" width:900px;  overflow:hidden;">
	                   <table width="900" border="0" cellspacing="0" cellpadding="0" class="g_table">
	                                <tr>
	                                  <th width="30">No</th>
	                                  <th width="70">매출일자</th>
	                                  <th width="45">회원명</th>
	                                  <th width="45">나이</th>
	                                  <th width="120">카드번호</th>
	                                  <th width="85">회원매출</th>
	                                  <th width="190">회원지역</th>
	                                  <th width="50">회원성별</th>
	                                  <th width="50">품목코드</th>
	                                  <th width="160">품목명</th>
	                                  <th width="50">품목수량</th>
	                                  <th width="15">&nbsp;</th>
	                                </tr>
	                     </table>
	                </div>
	             </td>
	          </tr>
	          <tr>
	              <td>
	                  <div id="DIV_Content" style="width:900px;height:420px;overflow:scroll" onscroll="scrollAll();">
	                       <table width="895" border="0" cellspacing="0" cellpadding="0" class="g_table">
	                      </table>
	                  </div>
	              </td>
	          </tr>
	    </table>
	    </div>
	    </td>
  </tr>
  <tr><td height="8"></td></tr>
</table>
</body>
</html>

