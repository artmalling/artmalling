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

/* 저장, 신규 등록시 사용할 키값 */
var g_master_strcd = "";
var g_master_strTakeDt = "";
var g_master_strTakeSeq = "";

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
    enableControl(del,true);      //삭제
    enableControl(save,true);     //저장
    enableControl(excel,false);    //엑셀
    enableControl(prints,false);    //프린터
    enableControl(set,false);    //프린터
    
    
    /*  조회 항목  */
    
    
    initDateText('SYYYYMMDD', 'em_S_Date');        //시작일
    initDateText("TODAY", "em_E_Date");        //종료일
    
    initDateText('TODAY', 'call_dt_i');        //시작일
    
    getPumbunCombo(g_strcd, vencd, "pubumCd", "Y");             //점별 브랜드
    
    /* 조회부 */
    getSelectCombo("D", "M061", "in_sch_flag", "");         //조회구분
    getSelectCombo("D", "M021", "in_prom_ty", "1");          //약속유형
    /* 입력부 */
    getSelectCombo("D", "M059", "call_hh", "");             //통화일자 시간
    getSelectCombo("D", "M060", "call_mm", "");             //통화일자 분
    getSelectCombo("D", "M026", "call_flag", "");             //통화구분
    
    document.getElementById("strcd").value = '<%=strcd%>';
    
    //상세 입력부 활성화 비활성화
    setObjec("onLoad");
}
/**
 * setObjec()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  활성화, 비활성화
 * return값 : void
 */ 
function setObjec(Flag){
	
	if( Flag == "onLoad" ){    //최초로드시
		document.getElementById("call_dt_i").disabled = true;
		enableControl(in_callImg,false);
		document.getElementById("call_hh").disabled = true;
		document.getElementById("call_mm").disabled = true;
		document.getElementById("call_mm").disabled = true;
		document.getElementById("sendNM").disabled = true;
		document.getElementById("recvNM").disabled = true;
		document.getElementById("call_flag").disabled = true;
		document.getElementById("call_desc").readOnly = true;
	} else if( Flag == "Content" ){   //마스터 조회 건수가 있을시
		document.getElementById("call_dt_i").disabled = true;
		enableControl(in_callImg,false);
		document.getElementById("call_hh").disabled = true;
		document.getElementById("call_mm").disabled = true;
        document.getElementById("sendNM").disabled = false;
        document.getElementById("recvNM").disabled = false;
        document.getElementById("call_flag").disabled = false;
        document.getElementById("call_desc").readOnly = false;
	} else if( Flag == "ContentF" ){  //마스터 조회 건수가 없을시
		document.getElementById("call_hh").disabled = true;
		document.getElementById("call_mm").disabled = true;
        document.getElementById("sendNM").disabled = true;
        document.getElementById("recvNM").disabled = true;
        document.getElementById("call_flag").disabled = true;
        document.getElementById("call_desc").readOnly = true;
	} else if( Flag == "noList" ){
		
		document.getElementById("call_dt_i").disabled = true;
		enableControl(in_callImg,false);
        document.getElementById("call_hh").disabled = true;
        document.getElementById("call_mm").disabled = true;
        document.getElementById("call_mm").disabled = true;
        document.getElementById("sendNM").disabled = true;
        document.getElementById("recvNM").disabled = true;
        document.getElementById("call_flag").disabled = true;
        document.getElementById("call_desc").readOnly = true;
	} else if( Flag == "CententNew" ){
		document.getElementById("call_dt_i").disabled = false;
		enableControl(in_callImg,true);
        document.getElementById("call_hh").disabled = false;
        document.getElementById("call_mm").disabled = false;
        document.getElementById("call_mm").disabled = false;
        document.getElementById("sendNM").disabled = false;
        document.getElementById("recvNM").disabled = false;
        document.getElementById("call_flag").disabled = false;
        document.getElementById("call_desc").readOnly = false;
	}
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
	
	
	 new_row = "1";
    
    
    
    var sDate = document.getElementById("em_S_Date").value;
    var eDate = document.getElementById("em_E_Date").value;
    
    if( document.getElementById("in_sch_flag").value == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "조회구분");
        document.getElementById("in_sch_flag").focus();
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
 * 개    요 :  조회  
 * return값 : void
 */
function getSearch(){
	
	 document.getElementById("call_seq_no").value = "";
     document.getElementById("call_dt_i").value = getTodayFormat("YYYY/MM/DD");
     document.getElementById("call_hh").selectedIndex = 0;
     document.getElementById("call_mm").selectedIndex = 0;
     document.getElementById("sendNM").value = "";
     document.getElementById("recvNM").value = "";
     document.getElementById("call_flag").selectedIndex = 0;
     document.getElementById("call_desc").value = "";
     
     document.getElementById("MASTER_CONTETN").innerHTML = "";
     
    var strStrcd = document.getElementById("strcd").value;                      //점코드
    var strVencd = document.getElementById("vencd").value;                      //협력사코드
    var strPumbuncd = document.getElementById("pubumCd").value;                 //브랜드코드
    var strSchFlag = document.getElementById("in_sch_flag").value;              //조회구분
    var sDate = getRawData(trim(document.getElementById("em_S_Date").value));   //기간 시작일
    var eDate = getRawData(trim(document.getElementById("em_E_Date").value));   //기간 종료일
    var strCustNm = document.getElementById("custNm").value;                    //고객명
    var strPromTy = document.getElementById("in_prom_ty").value;                //약속유형
    
    var param = "&goTo=getList" + "&strcd=" + strStrcd
                                + "&strVencd=" + strVencd
                                + "&strPumbuncd=" + strPumbuncd
                                + "&strSchFlag=" + strSchFlag
                                + "&sDate=" + sDate
                                + "&eDate=" + eDate
                                + "&strCustNm=" +strCustNm
                                + "&strPromTy=" + strPromTy;
               
    
    <ajax:open callback="on_getPhListXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/epro104.ep"/>
        

    <ajax:callback function="on_getPhListXML">
       
       var master_content = "<table width='1360' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_Litable'>";
       if( rowsNode.length > 0 ){
           
           for( i = 0; i < rowsNode.length; i++  ){
        	   
        	   /*
        	     0.신도림점 1.점코드 2.접수일자 3.접수순번 4.접수자 사번  5.약속유형 6.인도방식 7.주소 8.최종약속일 9.인도점
        	     10.고객명 11.전화번호 12.
        	     
        	   */
        	   
        	   var d_strNm = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
        	   var d_strcd = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
        	   var d_takeDt = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
        	   var d_takeSeq = rowsNode[i].childNodes[16].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[16].childNodes[0].nodeValue;
        	   var d_takeUserid = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
        	   var d_promType = rowsNode[i].childNodes[15].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[15].childNodes[0].nodeValue;
        	   var d_deliType = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
        	   var d_addr = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
        	   var d_lastPromdt = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
        	   var d_deli_str = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
        	   var d_custNm = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
        	   var d_phone = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
        	   var d_phone1 = rowsNode[i].childNodes[19].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[19].childNodes[0].nodeValue;
        	   var d_phone2 = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
        	   var d_phone3 = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
        	   var d_pumbuncd = rowsNode[i].childNodes[17].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[17].childNodes[0].nodeValue;
        	   var d_pumbunNm = rowsNode[i].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[14].childNodes[0].nodeValue;
        	   var d_deliDt = rowsNode[i].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[13].childNodes[0].nodeValue;
        	   var d_skuNM = rowsNode[i].childNodes[18].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[18].childNodes[0].nodeValue;
        	   var d_prom_dtl = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
        	   
        	   g_li_take_dt[i] = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;             //list 접수일자 
        	   g_li_strcd[i] = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;          //list 점코드
        	   g_li_takeSeq[i] =  d_takeSeq = rowsNode[i].childNodes[16].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[16].childNodes[0].nodeValue;         //master 순번
        	   
        	   var addr = ""
        	   if( d_addr.length > 9 ){
        		   addr = d_addr.substring(0,9) + " ..";
        	   }
        	   
        	   
        	   var phone = d_phone1 + "-" + d_phone2 + "-" + d_phone3;
        	  
        	   
        	   master_content += "<tr onclick='chBak("+i+");getMaster("+i+");' style='cursor:hand;'>";
        	   master_content += "<input type='hidden' name='d_strcd' id='d_strcd"+i+"' value='"+d_strcd+"' />";
        	   master_content += "<input type='hidden' name='d_takeDt' id='d_takeDt"+i+"' value='"+d_takeDt+"' />";
        	   master_content += "<input type='hidden' name='d_takeSeq' id='d_takeSeq"+i+"' value='"+d_takeSeq+"' />";
        	   master_content += "<td class='r1' id='1tdId"+i+"' width='75' >"+d_strNm+"</td>";
        	   master_content += "<td class='r1' id='2tdId"+i+"' width='85'>"+getDateFormat(d_takeDt)+"</td>";
        	   master_content += "<td class='r1' id='3tdId"+i+"' width='35'>"+d_takeSeq+"</td>";
        	   master_content += "<td class='r1' id='4tdId"+i+"' width='75'>"+d_takeUserid+"</td>";
        	   master_content += "<td class='r1' id='5tdId"+i+"' width='65'>"+d_promType+"</td>";
        	   master_content += "<td class='r1' id='6tdId"+i+"' width='75'>"+d_deliType+"</td>";
        	   master_content += "<td class='r1' id='7tdId"+i+"' title='"+d_addr+"' width='115' >"+addr+"</td>";
        	   master_content += "<td class='r1' id='8tdId"+i+"' width='85'>"+getDateFormat(d_lastPromdt)+"</td>";
        	   master_content += "<td class='r1' id='9tdId"+i+"' width='75' >"+d_deli_str+"</td>";
        	   master_content += "<td class='r3' id='10tdId"+i+"' width='75' >"+d_custNm+"</td>";
        	   master_content += "<td class='r1' id='11tdId"+i+"' width='85'>"+phone+"</td>";
        	   master_content += "<td class='r1' id='12tdId"+i+"' width='75'>"+d_pumbuncd+"</td>";
        	   master_content += "<td class='r1' id='13tdId"+i+"' width='95'>"+d_pumbunNm+"</td>";
        	   master_content += "<td class='r1' id='14tdId"+i+"' width='85' >"+getDateFormat(d_deliDt)+"</td>";
        	   master_content += "<td class='r1' id='15tdId"+i+"' width='75' >"+d_skuNM+"</td>";
        	   master_content += "<td class='r1' id='16tdId"+i+"' width='105' >"+d_prom_dtl+"</td>";
        	   master_content += "</tr>";   
           }
           //자동 조회 
           //getMaster2(g_li_take_dt[0], g_li_strcd[0], g_li_takeSeq[0]);
       
       } else {
    	   
           //document.getElementById("MASTER_CONTETN").innerHTML = "";
           
           document.getElementById("call_seq_no").value = "";
           document.getElementById("call_dt_i").Index = getTodayFormat("YYYY/MM/DD");;
           document.getElementById("call_hh").selectedIndex = 0;
           document.getElementById("call_mm").selectedIndex = 0;
           
           document.getElementById("sendNM").value = "";
           document.getElementById("recvNM").value = "";
           document.getElementById("call_flag").selectedIndex = 0;
           document.getElementById("call_desc").value = "";
           
           
           setObjec("ContentF");
           
           
       }
       master_content += "</table>";
       document.getElementById("DIV_CONTETN").innerHTML = master_content;
       
       if( g_last_row != -1){
    	   for(i=1;i<17;i++) {
               document.getElementById(i+"tdId"+0).style.backgroundColor="#fff56E";
           }
    	   g_pre_row = 0;
       }
       
       setPorcCount("SELECT", rowsNode.length);  
       

       // 2011.07.15 kjm 추가
       // 조회버튼 클릭시 하단그리드도 같이 조회
       chBak(0);
       getMaster2(0);
       
    </ajax:callback>
    
    
}

function getMaster( row ){
    var strStrcd = document.getElementById("d_strcd"+row).value;               //점코드
    var strTakeDt = document.getElementById("d_takeDt"+row).value;             //접수일자
    var strTakeSeq = document.getElementById("d_takeSeq"+row).value;           //접수순번
    
    g_master_strcd = strStrcd;
    g_master_strTakeDt = strTakeDt;
    g_master_strTakeSeq = strTakeSeq;
    
    var param = "&goTo=getMaster" + "&strStrcd=" + strStrcd
                                + "&strTakeDt=" + strTakeDt
                                + "&strTakeSeq=" + strTakeSeq;

    <ajax:open callback="on_getMasterXML" 
                        param="param" 
                        method="POST" 
                        urlvalue="/edi/epro104.ep"/>
    
    
    <ajax:callback function="on_getMasterXML">
        
        var content = "";
        if( rowsNode.length > 0 ){
            
            content += "<table width='325' border='0' cellspacing='0' cellpadding='0' class='g_table'>"; 
              
            for( i= 0; i < rowsNode.length; i++  ){
                var m_call_dt = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                var m_sendNm = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                var m_seqno = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                var m_strcd = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
                
                content += "<tr onclick='chBak2("+i+");getMasterContent("+i+");' style='cursor:hand;' >";
                content += "<input type='hidden' name='call_dt' id='call_dt"+i+"' value='"+m_call_dt+"' />";
                content += "<input type='hidden' name='seqNo' id='seqNo"+i+"' value='"+m_seqno+"' />";
                content += "<input type='hidden' name='m_strcd' id='m_strcd"+i+"' value='"+m_strcd+"' />";
                content += "<td class='r1' id='1matdId"+i+"' width='40' >"+(i+1)+"</td>";
                content += "<td class='r1' id='2matdId"+i+"' width='115'>"+getDateFormat(m_call_dt)+"</td>";
                
                if( m_sendNm.length > 6 ){
                    content += "<td class='r3' id='3matdId"+i+"' width='95' title='"+m_sendNm+"' >"+m_sendNm.substring(0,6)+" ..</td>"; 
                } else {
                    content += "<td class='r3' id='3matdId"+i+"' width='95'>"+m_sendNm+"</td>";
                }
                
                content += "<td class='r1' id='4matdId"+i+"' width='55'>"+convAmt(m_seqno)+"</td>";
                content += "</tr>";
                
            }
            
            
            content += "</table>";
            document.getElementById("MASTER_CONTETN").innerHTML = content;
            
            if( g_last_row2 != -1){
                for(i=1;i<5;i++) {
                    document.getElementById(i+"matdId"+0).style.backgroundColor="#fff56E";
                }
                g_pre_row2 = 0;
            }
            
        } else { 
            
            setObjec("ContentF");
            
            
            document.getElementById("call_seq_no").value = "";
            document.getElementById("call_dt_i").value = getTodayFormat("YYYY/MM/DD");
            document.getElementById("call_hh").selectedIndex = 0;
            document.getElementById("call_mm").selectedIndex = 0;
            document.getElementById("sendNM").value = "";
            document.getElementById("recvNM").value = "";
            document.getElementById("call_flag").selectedIndex = 0;
            document.getElementById("call_desc").value = "";
            
            
            content += "</table>";
            document.getElementById("MASTER_CONTETN").innerHTML = content;
            
        } 
        setPorcCount("SELECT", rowsNode.length);  
    </ajax:callback>
}




function getMaster2( row ){
	var strStrcd = document.getElementById("d_strcd"+row).value;               //점코드
	var strTakeDt = document.getElementById("d_takeDt"+row).value;             //접수일자
	var strTakeSeq = document.getElementById("d_takeSeq"+row).value;           //접수순번
	
	g_master_strcd = strStrcd;
	g_master_strTakeDt = strTakeDt;
	g_master_strTakeSeq = strTakeSeq;
	
	var param = "&goTo=getMaster" + "&strStrcd=" + strStrcd
                                + "&strTakeDt=" + strTakeDt
                                + "&strTakeSeq=" + strTakeSeq;

	<ajax:open callback="on_getMasterXML" 
						param="param" 
						method="POST" 
						urlvalue="/edi/epro104.ep"/>
	
	
	<ajax:callback function="on_getMasterXML">
        
        var content = "";
        if( rowsNode.length > 0 ){
        	
            content += "<table width='325' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
            
            for( i= 0; i < rowsNode.length; i++  ){
            	var m_call_dt = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
            	var m_sendNm = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
            	var m_seqno = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
            	var m_strcd = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
            	
            	content += "<tr onclick='chBak2("+i+");getMasterContent("+i+");' style='cursor:hand;' >";
                content += "<input type='hidden' name='call_dt' id='call_dt"+i+"' value='"+m_call_dt+"' />";
                content += "<input type='hidden' name='seqNo' id='seqNo"+i+"' value='"+m_seqno+"' />";
                content += "<input type='hidden' name='m_strcd' id='m_strcd"+i+"' value='"+m_strcd+"' />";
                content += "<td class='r1' id='1matdId"+i+"' width='40' >"+(i+1)+"</td>";
                content += "<td class='r1' id='2matdId"+i+"' width='115'>"+getDateFormat(m_call_dt)+"</td>";
                
                if( m_sendNm.length > 6 ){
                	content += "<td class='r3' id='3matdId"+i+"' width='95' title='"+m_sendNm+"' >"+m_sendNm.substring(0,6)+" ..</td>";	
                } else {
                	content += "<td class='r3' id='3matdId"+i+"' width='95'>"+m_sendNm+"</td>";
                }
                
                content += "<td class='r1' id='4matdId"+i+"' width='55'>"+convAmt(m_seqno)+"</td>";
                content += "</tr>";
            	
            }
            
            
            content += "</table>";
            document.getElementById("MASTER_CONTETN").innerHTML = content;
            
            if( g_last_row2 != -1){
                for(i=1;i<5;i++) {
                    document.getElementById(i+"matdId"+0).style.backgroundColor="#fff56E";
                }
                g_pre_row2 = 0;
            }
            
        } else {
        	
            
            setObjec("ContentF");
            
            
            document.getElementById("call_seq_no").value = "";
            document.getElementById("call_dt_i").value = getTodayFormat("YYYY/MM/DD");
            document.getElementById("call_hh").selectedIndex = 0;
            document.getElementById("call_mm").selectedIndex = 0;
            document.getElementById("sendNM").value = "";
            document.getElementById("recvNM").value = "";
            document.getElementById("call_flag").selectedIndex = 0;
            document.getElementById("call_desc").value = "";
            
            
            content += "</table>";
            document.getElementById("MASTER_CONTETN").innerHTML = content;
            setPorcCount("SELECT", 0);  
            
        } 
      //  setPorcCount("SELECT", rowsNode.length);  
	</ajax:callback>
}


function getMasterContent( row ){
	/*
	if( new_row == "3"){
        if( confirm("변경 된  상세내역이 존재 합니다. 이동 하시겠습니까?") != 1 ){
            return;
        }
    }
	*/
	new_row = "1";  
	var strCallDt = document.getElementById("call_dt"+row).value;
	var strSeqno = document.getElementById("seqNo"+row).value;
	
	
	var param = "&goTo=getMasterContent" + "&strCallDt=" + strCallDt
                                  + "&strSeqno=" + strSeqno;
                                  

	<ajax:open callback="on_getMasterContentXML" 
						param="param" 
						method="POST" 
						urlvalue="/edi/epro104.ep"/>
	
	
	<ajax:callback function="on_getMasterContentXML">
	   
	   if( rowsNode.length > 0 ){
		   var mc_call_dt = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
           var mc_sendNm = rowsNode[0].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[1].childNodes[0].nodeValue;
           var mc_seqno = rowsNode[0].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[3].childNodes[0].nodeValue;
           var mc_recv_nm = rowsNode[0].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[6].childNodes[0].nodeValue;
           var mc_callHH = rowsNode[0].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[7].childNodes[0].nodeValue;
           var mc_callMM = rowsNode[0].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[8].childNodes[0].nodeValue;
           var mc_CallFalg = rowsNode[0].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[9].childNodes[0].nodeValue;
           var mc_CallDesc = rowsNode[0].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[10].childNodes[0].nodeValue;
           var mc_strcd = rowsNode[0].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[12].childNodes[0].nodeValue;
           
           document.getElementById("call_seq_no").value = mc_seqno;
           document.getElementById("call_dt_i").value = getDateFormat(mc_call_dt);
           document.getElementById("call_hh").value = mc_callHH;
           document.getElementById("call_mm").value = mc_callMM;
           document.getElementById("sendNM").value = mc_sendNm;
           document.getElementById("recvNM").value = mc_recv_nm;
           document.getElementById("call_flag").value = mc_CallFalg;
           document.getElementById("call_desc").value = mc_CallDesc;
           
           
           setObjec("Content");
           
	   } 
	  
	   
	</ajax:callback>
	
}
function VailCheckSave(){
	if( trim(document.getElementById("call_dt_i").value) == "" ){
		showMessage(INFORMATION, OK, "USER-1003", "통화일자");
		document.getElementById("call_dt_i").focus();
		return false;
	}
	if( document.getElementById("call_hh").value == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "통화일자시간");
        document.getElementById("call_hh").focus();
        return false;
    }
	if( document.getElementById("call_mm").value == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "통화일자분");
        document.getElementById("call_mm").focus();
        return false;
    }
	if( trim(document.getElementById("sendNM").value) == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "발신자");
        document.getElementById("sendNM").focus();
        return false;
    }
	if( trim(document.getElementById("recvNM").value) == "" ){
		showMessage(INFORMATION, OK, "USER-1003", "수신자");
        document.getElementById("recvNM").focus();
        return false;
    }
	if( trim(document.getElementById("call_desc").value) == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "통화내역");
        document.getElementById("call_desc").focus();
        return false;
    }
	return true;
}
function btn_save(){
	
    if( document.getElementsByName("d_strcd").length < 1 ){
        showMessage(QUESTION, OK, "GAUCE-1004")
        return;
    } 
    
	
	if( !VailCheckSave() ) return;
	
	
	if( showMessage(QUESTION, YESNO, "GAUCE-1000", "저장하시겠습니까?") != 1){
        return;
    }
	
	if( new_row == "3" ){
		
        var in_callDt = getRawData(document.getElementById("call_dt_i").value);
        var in_call_hh = document.getElementById("call_hh").value;
        var in_call_mm = document.getElementById("call_mm").value;
        var in_sendNm = document.getElementById("sendNM").value;
        var in_recvNm = document.getElementById("recvNM").value;
        var in_callFlag = document.getElementById("call_flag").value;
        var in_callDesc = document.getElementById("call_desc").value;
        
        var param = "&goTo=save&gbFlag=insert" + "&g_master_strcd=" + g_master_strcd
                                               + "&g_master_strTakeDt=" + g_master_strTakeDt
                                               + "&g_master_strTakeSeq=" + g_master_strTakeSeq
                                               + "&in_callDt=" + in_callDt
                                               + "&in_call_hh=" + in_call_hh
                                               + "&in_call_mm=" + in_call_mm
                                               + "&in_sendNm=" + in_sendNm
                                               + "&in_recvNm=" + in_recvNm
                                               + "&in_callFlag=" + in_callFlag
                                               + "&in_callDesc=" + in_callDesc;
        

		<ajax:open callback="on_SaveXML" 
							param="param" 
							method="POST" 
							urlvalue="/edi/epro104.ep"/>
		
		
		<ajax:callback function="on_SaveXML">
	        
	        var cnt = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
	        
	        if( Number(cnt) > 0 ){
	        	showMessage(INFORMATION, OK, "GAUCE-1000", cnt+"건이 저장되었습니다.");
	            getSearch();
           }else {
        	   showMessage(INFORMATION, OK, "GAUCE-1000", cnt);
           }
	        
		</ajax:callback>
        
		
	} else {
		var mo_seqNo = document.getElementById("call_seq_no").value;
		var mo_callDt = getRawData(document.getElementById("call_dt_i").value);
		var mo_call_hh = document.getElementById("call_hh").value;
		var mo_call_mm = document.getElementById("call_mm").value;
		var mo_sendNm = document.getElementById("sendNM").value;
		var mo_recvNm = document.getElementById("recvNM").value;
		var mo_callFlag = document.getElementById("call_flag").value;
		var mo_callDesc = document.getElementById("call_desc").value;
		
		
		var param = "&goTo=save&gbFlag=Modify" + "&mo_seqNo=" + mo_seqNo
										       + "&mo_callDt=" + mo_callDt
										       + "&mo_call_hh=" + mo_call_hh
										       + "&mo_call_mm=" + mo_call_mm
										       + "&mo_sendNm=" + mo_sendNm
										       + "&mo_recvNm=" + mo_recvNm
										       + "&mo_callFlag=" + mo_callFlag
										       + "&mo_callDesc=" + mo_callDesc;
										       
		
		<ajax:open callback="on_ModifyXML" 
            param="param" 
            method="POST" 
            urlvalue="/edi/epro104.ep"/>


		<ajax:callback function="on_ModifyXML">
			 var cnt = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
	         
	         if( Number(cnt) > 0 ){
	        	 showMessage(INFORMATION, OK, "GAUCE-1000", cnt+"건이 저장되었습니다.");
	             getSearch();
	         }else {
	        	 showMessage(INFORMATION, OK, "GAUCE-1000", cnt);
	         }
		</ajax:callback>
	}
	
}

function btn_del(){
	
	if(document.getElementById("sendNM").value == "" &&  document.getElementById("call_seq_no").value == "" ){
		
	    showMessage(StopSign, OK, "USER-1019");
		return;
	}
	
	if( showMessage(QUESTION, YESNO, "GAUCE-1000", "삭제하시겠습니까?") != 1){
        return;
    }
	
	var de_CallDt = getRawData(document.getElementById("call_dt_i").value);
	var de_Seqno  = document.getElementById("call_seq_no").value;
	
	var param = "&goTo=delete" + "&strCallDt=" + de_CallDt
							   + "&strSeqno=" + de_Seqno;
							    

	<ajax:open callback="on_deleteXML" 
						param="param" 
						method="POST" 
						urlvalue="/edi/epro104.ep"/>
	
	
	<ajax:callback function="on_deleteXML">
		var cnt = rowsNode[0].childNodes[0].childNodes[0].nodeValue == null ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
	    
	    if( Number(cnt) > 0 ){
	      showMessage(INFORMATION, OK, "GAUCE-1000", cnt+"건이 삭제되었습니다.");
	      getSearch();
	    }else {
	    	showMessage(INFORMATION, OK, "GAUCE-1000", cnt);
	    }
	</ajax:callback>
	
}

function btn_new(){
	
	new_row = "3";
    
   if( document.getElementsByName("d_strcd").length < 1 ){
	   showMessage(QUESTION, OK, "USER-1013");
	   return;
   }else {
	   
	   if( g_pre_row == -1){
		   showMessage(INFORMATION, OK, "GAUCE-1000", "마스터 행의 데이타를 선택 한 후 신규 등록이 가능합니다.");
	       return;
	   }
	   
	   
       setObjec("CententNew");
       
	   document.getElementById("call_seq_no").value = "";
	   document.getElementById("call_dt_i").value = getTodayFormat("YYYY/MM/DD");
	   document.getElementById("call_hh").options[0].selected = true ;
	   document.getElementById("call_mm").options[0].selected = true ;
	   document.getElementById("sendNM").value = "";
	   document.getElementById("recvNM").value = "";
	   document.getElementById("call_flag").options[0].selected = true ;
	   document.getElementById("call_desc").value = "";
	   document.getElementById("sendNM").focus();
	   
	   
	   
   }
    
	
	
}



function chBak(val) {
    g_last_row = val;
    
    if (g_pre_row != g_last_row){
        for(i=1;i<17;i++) {
            document.getElementById(i+"tdId"+val).style.backgroundColor="#fff56E";
    
            if (g_pre_row != -1) {
                document.getElementById(i+"tdId"+g_pre_row).style.backgroundColor="#ffffff";
            }
        }
    }
    g_pre_row = g_last_row;
}

function chBak2(val) {
    g_last_row2 = val;
    
    if (g_pre_row2 != g_last_row2){
        for( j = 1; j < 5; j++) {
            document.getElementById(j+"matdId"+val).style.backgroundColor="#fff56E";
    
            if (g_pre_row2 != -1) {
                document.getElementById(j+"matdId"+g_pre_row2).style.backgroundColor="#ffffff";
            }
        }
    }
    g_pre_row2 = g_last_row2;
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
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>전화통화관리</td>
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
                  <th class="point">조회구분</th>
                  <td>
                      <select id="in_sch_flag" name="in_sch_flag" style="width:138;">
                      
                      </select>
                  </td>
                  <th width="80" class="point">기간</th>
                  <td colspan="3">
                     <input type="text" name="em_S_Date" id="em_S_Date" size="10" title="YYYY-MM-DD" maxlength="10" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' /> 
                     <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onclick="openCal('G',em_S_Date);return false;" /> ~
                     <input type="text" name="em_E_Date" id="em_E_Date" size="10" maxlength="10" onblur="dateCheck(this);" onfocus="dateValid(this);" onkeypress="javascript:onlyNumber();" style='text-align:center;IME-MODE: disabled'/>
                     <img src="<%=dir%>/imgs/btn/date.gif" alt="종료일" align="absmiddle" onclick="openCal('G',em_E_Date);return false;" />
                    </td>
              </tr>
              <tr>
                  <th>고객명</th>
                  <td>
                      <input type="text" name="custNm" id="custNm" size="21" onkeyup="checkByteLength(this, 40);"/>
                  </td>
                  <th>약속유형</th>
                  <td colspan="3">
                      <select id="in_prom_type" name="in_prom_ty" style="width:138;">
                      
                      </select>
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
                     <table width="1380" border="0" cellspacing="0" cellpadding="0" class="g_table"  >
                        <tr>
                            <th width="75">점</th>
                            <th width="85">접수일자</th>
                            <th width="35">SEQ</th>
                            <th width="75">접수자</th>
                            <th width="65">약속유형</th>
                            <th width="75">인도방식</th>
                            <th width="115">주소</th>
                            <th width="85">최초약속일</th>
                            <th width="75">인도점</th>
                            <th width="75">고객명</th>
                            <th width="85">전화번호</th>
                            <th width="75">브랜드코드</th>
                            <th width="95">브랜드명</th>
                            <th width="85">입고예정일</th>
                            <th width="75">상품명</th>
                            <th width="105">약속상세</th>
                            <th width="15">&nbsp;</th>
                        </tr>
                     </table>
                </div>
            </td>
          </tr>
          <tr>
              <td>
                  <div id="DIV_CONTETN" style="width:815px;height:230px;overflow:scroll" onscroll="scrollAll();">
                        <table width="1360" border="0" cellspacing="0" cellpadding="0" class="g_table" id="tb_Litable">
                        </table>
                  </div>
              </td>
          </tr>
          
        </table></td>
        </tr>
       </table></td> 
    </tr>
    
     <tr>
    <td class="PT05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="sub_title "><img src="<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 전화통화리스트</td>
                <td class="sub_title">&nbsp;<img src="<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>전화통화상세</td>
            </tr>
            <tr>
                <td height="5" ><td>
            </tr>
            <tr valign="top">
                <td width="350">
                <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
                    <tr >
                        <td>
                            <div id="MASTER_TITLE" style=" width:345px; overflow:hidden;"> 
                                <table width="345" border="0" cellspacing="0" cellpadding="0" class="g_table" >
                                    <tr>
                                        <th width="40">NO</th>
                                        <th width="115">전화통화일자</th>
                                        <th width="95">발신자</th>
                                        <th width="55">순번</th>
                                        <th width="15">&nbsp;</th>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="MASTER_CONTETN" style="width:345px;height:156px;overflow:scroll" onscroll="scrollAll2();">
		                        <table width="325" border="0" cellspacing="0" cellpadding="0" class="g_table" id="tb_master">
		                              
		                        </table>
		                    </div>
                        </td>
                    </tr>
                </table>
                </td>
                <td class="PL05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
                            <tr>
                                <th width="50">순번</th>
                                <td width="70">
                                      <input type="text" name="call_seq_no" id="call_seq_no" size="10" disabled="disabled" >
                                </td>
                                <th width="70" class="POINT">전화통화일자</th>
                                <td>
                                      <input type="text" name="call_dt_i" id="call_dt_i" size="10" maxlength="10" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);" style='text-align:center;IME-MODE: disabled'>
                                      <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onclick="openCal('G',call_dt_i);return false;" id="in_callImg" />
                                      <select  name="call_hh" id="call_hh" style="width: 55; ">
                                      </select>
                                      <select  name="call_mm" id="call_mm" style="width: 55;">
                                      </select>
                                      
                                </td>
                            </tr>
                            <tr>
                                <th class="POINT" width="60">발신자</th>
                                <td> 
                                      <input type="text" name="sendNM" id="sendNM" size="10" onkeyup="checkByteLength(this, 40);"><input type="hidden" name="sendcd" id="sendcd" />
                                </td>
                               
                                <th class="POINT" width="60">통화구분</th>
                                <td  >
                                     <select id="call_flag" name="call_flag" style="width:95;">
                                     
                                     </select>
                                </td>
                            </tr>
                            <tr>
                                <th class="POINT" >수신자</th>
                                <td colspan="3">
                                      <input type="text" name="recvNM" id="recvNM" size="10" onkeyup="checkByteLength(this, 40);"><input type="hidden" name=""recvCd id="recvCd" /> 
                                </td>
                            </tr>
                            <tr>
                                <th class="POINT">통화내역</th>
                                <td colspan="3" class="PT02 PB02" >
                                    <textarea style="height:105;width: 100%; "  name="call_desc" id="call_desc" onkeyup="checkByteLength(this, 4000);" ></textarea>
                                </td>
                            </tr>
                            
                        </table></td>
                    </tr>
                </table></td>
            </tr>
    </table></td>
  </tr>
     
</table>
</body>
</html>

