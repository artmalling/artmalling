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
    String pumbuncd = sessionInfo.getPUMBUN_CD();
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
var g_row = -1;

var new_row = "1";   //저장시 1.일반저장 2. 신규

/* master  */

var g_ma_call_dt = new Array();             //master 접수일자
var g_ma_seq_no = new Array();              //master 순번

/* 리스트  */
var g_take_dt = "";             
var g_strcd = '<%=strcd%>';                                                  
var g_takeSeq = "";        
var g_procStat = "";
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
    enableControl(newrow,true);   //신규    
    enableControl(del,false);      //삭제
    enableControl(save,true);     //저장
    enableControl(excel,false);    //엑셀
    enableControl(prints,false);    //프린터
    enableControl(set,false);    //프린터
    
    
    /*  조회 항목  */
    
    
    initDateText('SYYYYMMDD', 'em_S_Date');        //시작일
    initDateText("TODAY", "em_E_Date");        //종료일
    
    initDateText('TODAY', 'take_dt');        //시작일
    
    if( gb == "2" ){
        pumbuncd = '<%=pumbuncd%>';
    }
    getPumbunCombo(g_strcd, vencd, gb, pumbuncd, "s_pumbun_cd",  true);
    getPumbunCombo(g_strcd, vencd, gb, pumbuncd, "pumbun_cd", false);
    
    /* 조회부 */
    getSelectCombo("D", "M061", "in_sch_flag", "");         //조회구분
    getSelectCombo("D", "M021", "s_in_prom_type", "1");          //약속유형
    /* 입력부 */
    getSelectCombo("D", "M021", "prom_type", "");          //약속유형
    getSelectCombo("D", "M022", "deli_type", "");          //인도방식
    getStrCd("deli_str", "");          //인도점
    
    getSelectCombo("D", "M059", "frst_prom_hh", "");             //최초약속  시간
    getSelectCombo("D", "M060", "frst_prom_mm", "");             //최초약속 분
    getSelectCombo("D", "M059", "last_prom_hh", "");             //변경약속  시간
    getSelectCombo("D", "M060", "last_prom_mm", "");             //변경약속 분
    
    document.getElementById("strcd").value = '<%=strcd%>';
    
    //상세 입력부 활성화 비활성화
    setObjec("onLoad");
}

function setObjec(Flag){
	var contents = document.getElementsByName("contents");
    var courContents = document.getElementsByName("cour_contents");
	if( Flag == "onLoad" ){    //최초로드시
		for(var i=0;i<contents.length;i++){
            contents[i].disabled="disabled";
        }
       // 배송정보 
        for(var j=0;j<courContents.length;j++){
            courContents[j].disabled="disabled";
        }
       // 이미지 
        enableControl(img_take_dt, false);
        enableControl(img_post_no , false);
        enableControl(img_frst_dt, false);
        enableControl(img_last_dt, false);
        enableControl(img_in_dt, false);
        enableControl(img_cour_post_no, false);
        

        document.getElementsByName("sel_proc_stat")[0].disabled="disabled";
        document.getElementsByName("sel_proc_stat")[1].disabled="disabled";
        document.getElementsByName("sel_proc_stat")[2].disabled="disabled";
        document.getElementsByName("sel_proc_stat")[3].disabled="disabled";
	} else if( Flag == "new" ) {
		for(var i=0;i<contents.length;i++){
			contents[i].value="";
            contents[i].disabled="";
        }
       // 배송정보 [2011.07.18] 신규시 배송정보 비활성화
       /*
        for(var j=0;j<courContents.length;j++){
        	courContents[j].value="";
            courContents[j].disabled="";
        }
       enableControl(img_cour_post_no, true);
       */
       // 이미지 
        enableControl(img_take_dt, true);
        enableControl(img_post_no , true);
        enableControl(img_frst_dt, true);
        enableControl(img_last_dt, true);
        enableControl(img_in_dt, true);
        
        // 기본사항
        document.getElementById("str_nm").value         =  '<%=strNm%>' ;
        g_take_dt = "";             
        g_strcd = '<%=strcd%>';    
        g_takeSeq = "";        
        g_procStat = "";

        document.getElementsByName("sel_proc_stat")[0].checked = true; 
        document.getElementsByName("sel_proc_stat")[0].disabled="";
        document.getElementsByName("sel_proc_stat")[1].disabled="";
        document.getElementsByName("sel_proc_stat")[2].disabled="";
        document.getElementsByName("sel_proc_stat")[3].disabled="";  
        
        document.getElementById("cour_cust_nm").value="";
        document.getElementById("cour_post_no").value="";
        document.getElementById("cour_addr1").value="";
        document.getElementById("cour_addr2").value="";
        document.getElementById("cour_m_phone1").value="";
        document.getElementById("cour_m_phone2").value="";
        document.getElementById("cour_m_phone3").value="";
        document.getElementById("cour_phone1").value="";
        document.getElementById("cour_phone2").value="";
        document.getElementById("cour_phone3").value="";
        document.getElementById("cour_comp_nm").value="";
        document.getElementById("cour_send_no").value="";
        
	} else if( Flag == "Detail" ){   //마스터 조회 건수가 있을시
		// 취소 및 해피콜 완료시  수정불가 
		if(g_procStat == "4" || g_procStat ==  "5"){
			for(var i=0;i<contents.length;i++){
	            contents[i].disabled="disabled"
	        }
	       // 배송정보 
	        for(var j=0;j<courContents.length;j++){
	            courContents[j].disabled="disabled"
	        }
	       // 이미지 
	        enableControl(img_take_dt, false);
	        enableControl(img_post_no , false);
	        enableControl(img_frst_dt, false);
	        enableControl(img_last_dt, false);
	        enableControl(img_in_dt, false);
	        enableControl(img_cour_post_no, false);
	        document.getElementsByName("sel_proc_stat")[0].disabled="disabled";
            document.getElementsByName("sel_proc_stat")[1].disabled="disabled";
            document.getElementsByName("sel_proc_stat")[2].disabled="disabled";
            document.getElementsByName("sel_proc_stat")[3].disabled="disabled";
		}else{
			for(var i=0;i<contents.length;i++){
                contents[i].disabled="";
            }
			
			//[2011.07.18]인도방식이 택배발송인 경우만 배송정보 활성화
            if (document.getElementById("deli_type").value == "02" ) { // 02:택배수령
                for(var j=0;j<courContents.length;j++){ // 배송정보 
                    courContents[j].disabled="";
                }
                enableControl(img_cour_post_no, true);  // 우편번호 이미지
            } else {
                for(var j=0;j<courContents.length;j++){ // 배송정보 
                    courContents[j].disabled="disabled";    
                }
                enableControl(img_cour_post_no, false); // 우편번호 이미지
            }		

           // 이미지 
            enableControl(img_take_dt, false);
            enableControl(img_post_no , true);
            enableControl(img_frst_dt, false);
            enableControl(img_last_dt, false);
            enableControl(img_in_dt, false);
            
            // 약속내역 수정 불가 (접수일자, 브랜드, 최초약속일, 약속유형, 최종약속일, 인도방식, 인도점, 입고예정일 )
            document.getElementById("take_dt").disabled="disabled";
            document.getElementById("pumbun_cd").disabled="disabled";
            document.getElementById("frst_prom_dt").disabled="disabled";
            document.getElementById("frst_prom_hh").disabled="disabled";
            document.getElementById("frst_prom_mm").disabled="disabled";
            document.getElementById("prom_type").disabled="disabled";
            document.getElementById("last_prom_dt").disabled="disabled";
            document.getElementById("last_prom_hh").disabled="disabled";
            document.getElementById("last_prom_mm").disabled="disabled";
            document.getElementById("deli_type").disabled="disabled";
            document.getElementById("deli_str").disabled="disabled";
            document.getElementById("in_deli_dt").disabled="disabled";
            
            document.getElementsByName("sel_proc_stat")[0].disabled="disabled";
            document.getElementsByName("sel_proc_stat")[1].disabled="";
            document.getElementsByName("sel_proc_stat")[2].disabled="";
            document.getElementsByName("sel_proc_stat")[3].disabled="disabled";
		}
	} 
}

/**
 * getPumbunCombo()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  점별브랜드콤보
 * return값 : void
 */ 
function getPumbunCombo(strcd, vencd, gb, pumbuncd, target, flag){
     var param = "";
    if( gb == "2" ){       //로그인 시 브랜드
        
        param = "&goTo=getPumbunCombo&strcd=" + strcd
              + "&vencd=" + vencd
              + "&gb=" + gb
              + "&pumbuncd=" + pumbuncd;
    
    }else if( gb == "1" ){
        param = "&goTo=getPumbunCombo&strcd=" + strcd
              + "&vencd=" + vencd
              + "&gb=" + gb;
    }
    
    <ajax:open callback="on_loadedXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/ccom001.cc"/>
    
    <ajax:callback function="on_loadedXML">
       var pumbun = document.getElementById(target);
       if( rowsNode.length == 1){
           var opt = document.createElement("option");  
           opt.setAttribute("value", rowsNode[0].childNodes[0].childNodes[0].nodeValue);
           
           var text = document.createTextNode(rowsNode[0].childNodes[1].childNodes[0].nodeValue);
           opt.appendChild(text);            
           pumbun.appendChild(opt);
       }else if( rowsNode.length > 1){
           if(flag){
        	   var emp_opt = document.createElement("option");
               emp_opt.setAttribute("value", "%");
               var emp_text = document.createTextNode("전체");
               emp_opt.appendChild(emp_text); 
               pumbun.appendChild(emp_opt)
           }else{
        	   var emp_opt = document.createElement("option");
               emp_opt.setAttribute("value", "");
               var emp_text = document.createTextNode("");
               emp_opt.appendChild(emp_text); 
               pumbun.appendChild(emp_opt) 
           }
           for( i =0; i < rowsNode.length; i++){
               var opt = document.createElement("option");  
               opt.setAttribute("value", rowsNode[i].childNodes[0].childNodes[0].nodeValue);
               
               var text = document.createTextNode(rowsNode[i].childNodes[1].childNodes[0].nodeValue);
               opt.appendChild(text); 
               pumbun.appendChild(opt);
           }
       }else if( rowsNode.length < 1 && flag == true){
           var opt = document.createElement("option");
           var emp_text = document.createTextNode("전체");
           opt.setAttribute("value", "%");           
           opt.appendChild(emp_text); 
           pumbun.appendChild(opt);
       }
       
       
    </ajax:callback>
}

/**
 * getStrCd()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  조회부 공통 부문
 * return값 : void
 */ 
function getStrCd(target, gb){
    
    var param = "&goTo=getStrCd";
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
	 g_row = -1;
	 g_pre_row = -1;
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
    
    getMaster();
    
}


/**
 * getMaster()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-06-24
 * 개    요 :  조회  
 * return값 : void
 */
function getMaster(){
	
    document.getElementById("MASTER_CONTETN").innerHTML = "";
     
    var strStrcd = '<%=strcd%>';                                                    //점코드
    var strVencd = '<%=vencd%>';                                                    //협력사코드
    var strPumbuncd = document.getElementById("s_pumbun_cd").value;                 //브랜드코드
    var strSchFlag = document.getElementById("in_sch_flag").value;                  //조회구분
    var sDate = getRawData(trim(document.getElementById("em_S_Date").value));       //기간 시작일
    var eDate = getRawData(trim(document.getElementById("em_E_Date").value));       //기간 종료일
    var strCustNm = document.getElementById("s_cust_nm").value;                     //고객명
    var strPromTy = document.getElementById("s_in_prom_type").value;                //약속유형

    var param = "&goTo=getMaster" + "&strcd=" + strStrcd
                                  + "&strVencd=" + strVencd
                                  + "&strPumbuncd=" + strPumbuncd
                                  + "&strSchFlag=" + strSchFlag
                                  + "&sDate=" + sDate
                                  + "&eDate=" + eDate
                                  + "&strCustNm=" +strCustNm
                                  + "&strPromTy=" + strPromTy;
               
    
    <ajax:open callback="on_getMasterXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/epro101.ep"/>
        

    <ajax:callback function="on_getMasterXML">
       
       var master_content = "<table width='385' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_Litable'>";
       if( rowsNode.length > 0 ){
           
           for( i = 0; i < rowsNode.length; i++  ){
        	   
        	   /*
        	     0.접수일 1.점코드 2.점명 3.신청순번4.약속유형 5.약속유형명
        	     
        	   */
        	   
        	   var strTakeDt = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
        	   var strStrCd = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
        	   var strStrNm = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
        	   var strTakeSeq = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
        	   var strPromType = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
        	   var strPromTypeMn = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
        	   var strCustNm = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
        	   
        	   master_content += "<tr onclick='chBak("+i+");getDetail("+i+");' style='cursor:hand;'>";
        	   master_content += "<input type='hidden' name='d_strcd' id='d_strcd"+i+"' value='"+strStrCd+"' />";
        	   master_content += "<input type='hidden' name='d_takeDt' id='d_takeDt"+i+"' value='"+strTakeDt+"' />";
        	   master_content += "<input type='hidden' name='d_takeSeq' id='d_takeSeq"+i+"' value='"+strTakeSeq+"' />";
        	   master_content += "<td class='r1' id='1tdId"+i+"' width='25' >"+(i+1)+"</td>";
        	   master_content += "<td class='r1' id='2tdId"+i+"' width='80'>"+strStrNm+"</td>";
        	   master_content += "<td class='r1' id='3tdId"+i+"' width='80'>"+getDateFormat(strTakeDt)+"</td>";
        	   master_content += "<td class='r1' id='4tdId"+i+"' width='40'>"+strTakeSeq+"</td>";
        	   master_content += "<td class='r1' id='5tdId"+i+"' width='60'>"+strPromTypeMn+"</td>";
        	   master_content += "<td class='r3' id='6tdId"+i+"' width='70'>"+strCustNm+"</td>";
        	   master_content += "</tr>";   
           }
           master_content += "</table>";
           document.getElementById("MASTER_CONTETN").innerHTML = master_content;
           setPorcCount("SELECT", rowsNode.length);  
           
           if(g_row == -1){
        	   chBak(0);
               getDetail( 0 );
           }else {
        	   g_pre_row = -1;
        	   chBak(g_row);
               getDetail( g_row );
           }
           
       } else {
    	   
           document.getElementById("MASTER_CONTETN").innerHTML = ""; 
           setPorcCount("SELECT", 0);
           setObjec("onLoad");
       }
    </ajax:callback>
    
    
}

function getDetail( row ){
	g_take_dt = document.getElementById("d_takeDt"+row).value;
	g_strcd = document.getElementById("d_strcd"+row).value;       
	g_takeSeq = document.getElementById("d_takeSeq"+row).value;     
	g_row = row;
	
	var param = "&goTo=getDetail" + "&strStrcd=" + g_strcd
								  + "&strTakeDt=" + g_take_dt
								  + "&strTakeSeq=" + g_takeSeq;

	<ajax:open callback="on_getDetailXML" 
		param="param" 
		method="POST" 
		urlvalue="/edi/epro101.ep"/>
	
	
	<ajax:callback function="on_getDetailXML">
		if( rowsNode.length == 1 ){
	           // 기본사항
			   document.getElementById("str_nm").value         = rowsNode[0].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[14].childNodes[0].nodeValue;    // 점
	           document.getElementById("take_dt").value        = rowsNode[0].childNodes[40].childNodes[0].nodeValue == "null" ? "" : getDateFormat(rowsNode[0].childNodes[40].childNodes[0].nodeValue);  // 접수일자
	           document.getElementById("take_seq").value       = rowsNode[0].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[11].childNodes[0].nodeValue;    // 접수순번
	           document.getElementById("pumbun_cd").value      = rowsNode[0].childNodes[30].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[30].childNodes[0].nodeValue;    // 브랜드
	           
	           // 고객정보
	           
	           document.getElementById("chk_sms").checked      = rowsNode[0].childNodes[49].childNodes[0].nodeValue == "T" ? true : false;     //SMS 수신여부
	           document.getElementById("cust_nm").value        = rowsNode[0].childNodes[31].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[31].childNodes[0].nodeValue;    // 고객명
	           document.getElementById("post_no").value        = rowsNode[0].childNodes[16].childNodes[0].nodeValue == "null" ? "" : convertZip(rowsNode[0].childNodes[16].childNodes[0].nodeValue);   // 우편번호  
	           document.getElementById("addr1").value          = rowsNode[0].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[3].childNodes[0].nodeValue;      // 주소 1
	           document.getElementById("addr2").value          = rowsNode[0].childNodes[35].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[35].childNodes[0].nodeValue;  //주소 2
	           document.getElementById("m_phone1").value       = rowsNode[0].childNodes[18].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[18].childNodes[0].nodeValue; //휴대폰번호 1
               document.getElementById("m_phone2").value       = rowsNode[0].childNodes[22].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[22].childNodes[0].nodeValue;//휴대폰번호 2
               document.getElementById("m_phone3").value       = rowsNode[0].childNodes[38].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[38].childNodes[0].nodeValue;//휴대폰번호 3
               document.getElementById("phone1").value         = rowsNode[0].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[6].childNodes[0].nodeValue; //전화번호 1
               document.getElementById("phone2").value         = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;//전화번호 2
               document.getElementById("phone3").value         = rowsNode[0].childNodes[27].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[27].childNodes[0].nodeValue;//전화번호 3
               
               // 약속내역
               document.getElementById("frst_prom_dt").value   = rowsNode[0].childNodes[48].childNodes[0].nodeValue == "null" ? "" : getDateFormat(rowsNode[0].childNodes[48].childNodes[0].nodeValue); //최초약속일
               document.getElementById("frst_prom_hh").value   = rowsNode[0].childNodes[39].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[39].childNodes[0].nodeValue; // 약속유형
               document.getElementById("frst_prom_mm").value   = rowsNode[0].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[2].childNodes[0].nodeValue; // 약속유형
               document.getElementById("prom_type").value      = rowsNode[0].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[9].childNodes[0].nodeValue; // 약속유형
               document.getElementById("last_prom_dt").value   = rowsNode[0].childNodes[7].childNodes[0].nodeValue == "null" ? "" : getDateFormat(rowsNode[0].childNodes[7].childNodes[0].nodeValue);    // 최종약속일
               document.getElementById("last_prom_hh").value   = rowsNode[0].childNodes[37].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[37].childNodes[0].nodeValue;    // 최종약속일
               document.getElementById("last_prom_mm").value   = rowsNode[0].childNodes[28].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[28].childNodes[0].nodeValue;    // 최종약속일
               document.getElementById("deli_type").value      = rowsNode[0].childNodes[44].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[44].childNodes[0].nodeValue;   // 인도방식
               document.getElementById("deli_str").value       = rowsNode[0].childNodes[47].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[47].childNodes[0].nodeValue;   // 인도점
               document.getElementById("in_deli_dt").value     = rowsNode[0].childNodes[25].childNodes[0].nodeValue == "null" ? "" : getDateFormat(rowsNode[0].childNodes[25].childNodes[0].nodeValue);    // 입고예정일
               document.getElementById("sku_nm").value         = rowsNode[0].childNodes[15].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[15].childNodes[0].nodeValue;   // 상품명
               document.getElementById("prom_dtl").value       = rowsNode[0].childNodes[43].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[43].childNodes[0].nodeValue;   // 약속내역
				  
               // 배송정보
               document.getElementById("cour_cust_nm").value        = rowsNode[0].childNodes[32].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[32].childNodes[0].nodeValue;    // 고객명
               document.getElementById("cour_post_no").value        = rowsNode[0].childNodes[13].childNodes[0].nodeValue == "null" ? "" : convertZip(rowsNode[0].childNodes[13].childNodes[0].nodeValue);   // 우편번호  
               document.getElementById("cour_addr1").value          = rowsNode[0].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[5].childNodes[0].nodeValue;      // 주소 1
               document.getElementById("cour_addr2").value          = rowsNode[0].childNodes[17].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[17].childNodes[0].nodeValue;  //주소 2
               document.getElementById("cour_m_phone1").value       = rowsNode[0].childNodes[36].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[36].childNodes[0].nodeValue; //휴대폰번호 1
               document.getElementById("cour_m_phone2").value       = rowsNode[0].childNodes[20].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[20].childNodes[0].nodeValue;//휴대폰번호 2
               document.getElementById("cour_m_phone3").value       = rowsNode[0].childNodes[41].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[41].childNodes[0].nodeValue;//휴대폰번호 3
               document.getElementById("cour_phone1").value         = rowsNode[0].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[1].childNodes[0].nodeValue; //전화번호 1
               document.getElementById("cour_phone2").value         = rowsNode[0].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[12].childNodes[0].nodeValue;//전화번호 2
               document.getElementById("cour_phone3").value         = rowsNode[0].childNodes[21].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[21].childNodes[0].nodeValue;//전화번호 3
               document.getElementById("cour_comp_nm").value        = rowsNode[0].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[10].childNodes[0].nodeValue;//전화번호 2
               document.getElementById("cour_send_no").value        = rowsNode[0].childNodes[29].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[29].childNodes[0].nodeValue;//전화번호 3
               g_procStat                                           = rowsNode[0].childNodes[34].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[34].childNodes[0].nodeValue;//진행상태
             
               for( i = 0; i < document.getElementsByName("sel_proc_stat").length; i++ ){
            	   if(document.getElementsByName("sel_proc_stat")[i].value == g_procStat){
            		   document.getElementsByName("sel_proc_stat")[i].checked = true;
            	   }
               }
           
               if(rowsNode[0].childNodes[26].childNodes[0].nodeValue == "Y"){
            	   document.getElementById("chk_happyCall").checked = true; 
               }else{
            	   document.getElementById("chk_happyCall").checked = false;
               }
               
            setObjec("Detail");
		} else {
			
		}
	</ajax:callback>
}

function VailCheckSave(){
	if( g_strcd == "" ){
		showMessage(INFORMATION, OK, "USER-1003", "점");
		//document.getElementById("str_cd").focus();
		return false;
	}
	if( document.getElementById("take_dt").value == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "접수일자");
        document.getElementById("take_dt").focus();
        return false;
    } 
	if( document.getElementById("take_dt").value > getTodayFormat("YYYY/MM/DD") ){ 
        showMessage(INFORMATION, OK, "USER-1000", "접수일자는 오늘보다 클 수 없습니다.");
        document.getElementById("take_dt").focus();
        return false;
    } 
	if( document.getElementById("pumbun_cd").value == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "브랜드");
        document.getElementById("pumbun_cd").focus();
        return false;
    }
	if( document.getElementById("cust_nm").value == "" ){
		showMessage(INFORMATION, OK, "USER-1003", "고객명");
        document.getElementById("cust_nm").focus();
        return false;
    }
	if( document.getElementById("m_phone1").value == ""  
			|| document.getElementById("m_phone2").value == ""
			|| document.getElementById("m_phone3").value == ""
			|| document.getElementById("m_phone1").value.length < 3){
        showMessage(INFORMATION, OK, "USER-1003", "휴대폰번호");
        document.getElementById("m_phone1").focus();
        return false;
    }  
    if( document.getElementById("m_phone2").value.length < 3 ){
       showMessage(INFORMATION, OK, "USER-1000", "휴대폰번호를 확인하세요");
       document.getElementById("m_phone2").focus();
       return false;
    } 
    if( document.getElementById("m_phone3").value.length < 4 ){ 
        showMessage(INFORMATION, OK, "USER-1000", "휴대폰번호를 확인하세요");
        document.getElementById("m_phone3").focus();
        return false;
     }
	if( document.getElementById("frst_prom_dt").value == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "최초약속일");
        document.getElementById("frst_prom_dt").focus();
        return false;
    }
	if( document.getElementById("frst_prom_dt").value > getTodayFormat("YYYY/MM/DD") ){ 
        showMessage(INFORMATION, OK, "USER-1000", "최초약속일자는 오늘보다 클 수 없습니다.");
        document.getElementById("frst_prom_dt").focus();
        return false;
    }  
	if( document.getElementById("frst_prom_hh").value == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "최초약속시간");
        document.getElementById("frst_prom_hh").focus();
        return false;
    }
	if( document.getElementById("frst_prom_mm").value == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "최초약속분");
        document.getElementById("frst_prom_mm").focus();
        return false;
    }
	if( document.getElementById("prom_type").value == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "약속유형");
        document.getElementById("prom_type").focus();
        return false;
    }
	if( document.getElementById("deli_type").value == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "인도방식");
        document.getElementById("deli_type").focus();
        return false;
    }
	if( document.getElementById("deli_str").value == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "인도점");
        document.getElementById("deli_str").focus();
        return false;
    }
	if( document.getElementById("in_deli_dt").value == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "입고예정일");
        document.getElementById("in_deli_dt").focus();
        return false;
    }
	if(document.getElementById("deli_type").value == "02" ){
		// 배송일경우 
	    if( document.getElementById("cour_cust_nm").value == "" ){
	        showMessage(INFORMATION, OK, "USER-1003", "고객명");
	        document.getElementById("cour_cust_nm").focus();
	        return false;
	    }
	    if( document.getElementById("cour_m_phone1").value == ""
	            || document.getElementById("cour_m_phone2").value == ""
	            || document.getElementById("cour_m_phone3").value == ""
	                || document.getElementById("m_phone1").value.length < 3 ){
	        showMessage(INFORMATION, OK, "USER-1003", "휴대폰번호");
	        document.getElementById("cour_m_phone1").focus();
	        return false;
	    }
	    if( document.getElementById("cour_m_phone2").value.length < 3 ){
	        showMessage(INFORMATION, OK, "USER-1000", "휴대폰번호를 확인하세요");
	        document.getElementById("cour_m_phone2").focus();
	        return false;
	     }
	     if( document.getElementById("cour_m_phone3").value.length < 4 ){
	         showMessage(INFORMATION, OK, "USER-1000", "휴대폰번호를 확인하세요");
	         document.getElementById("cour_m_phone3").focus();
	         return false;
	      }
	}
	
	
	
	return true;
}
function btn_save(){                                                              
	                                                                              
	if( !VailCheckSave() ) return;                                              
	      
	if( showMessage(QUESTION, YESNO, "USER-1010") != 1){                         
        return;
    }
                   
	if(document.getElementById("chk_sms").checked){
		var strSmsYn = "T";
	}  else{
		var strSmsYn = "F";
	}

    for( i = 0; i < document.getElementsByName("sel_proc_stat").length; i++ ){
        if(document.getElementsByName("sel_proc_stat")[i].checked){
            var strProcStat = document.getElementsByName("sel_proc_stat")[i].value;
        }
    }
	
	        var param = "&goTo=save" + "&strTakeDt="                 +  document.getElementById("take_dt").value    
                                     + "&strStrCd="                  +  g_strcd
                                     + "&strTakeSeq="                +  document.getElementById("take_seq").value  
                                     + "&strTakeUserId="             +  userid
                                     + "&strCustNm="                 +  document.getElementById("cust_nm").value        
                                     + "&strPostNo="                 +  document.getElementById("post_no").value   
                                     + "&strAddr="                   +  document.getElementById("addr1").value       
                                     + "&strDtaAddr="                +  document.getElementById("addr2").value    
                                     + "&strMobileNo1="              +  document.getElementById("m_phone1").value 
                                     + "&strMobileNo2="              +  document.getElementById("m_phone2").value 
                                     + "&strMobileNo3="              +  document.getElementById("m_phone3").value 
                                     + "&strHomeNo1="                +  document.getElementById("phone1").value   
                                     + "&strHomeNo2="                +  document.getElementById("phone2").value   
                                     + "&strHomeNo3="                +  document.getElementById("phone3").value   
                                     + "&strFrstPromDt="             +  document.getElementById("frst_prom_dt").value 
                                     + "&strFrstPromTime="           +  (document.getElementById("frst_prom_hh").value +  document.getElementById("frst_prom_mm").value) 
                                     + "&strLastPromDt="             +  document.getElementById("last_prom_dt").value
                                     + "&strLastPromTime="           +  (document.getElementById("last_prom_hh").value  + document.getElementById("last_prom_mm").value) 
                                     + "&strPromType="               +  document.getElementById("prom_type").value 
                                     + "&strPromDtl="                +  document.getElementById("prom_dtl").value  
                                     + "&strDeliType="               +  document.getElementById("deli_type").value   
                                     + "&strDeliStr="                +  document.getElementById("deli_str").value 
                                     + "&strPumbunCd="               +  document.getElementById("pumbun_cd").value
                                     + "&strSkuNm="                  +  document.getElementById("sku_nm").value 
                                     + "&strInDeliDt="               +  document.getElementById("in_deli_dt").value  
                                     + "&strSmsYn="                  +  strSmsYn 
                                     + "&strCourCustNm="             +  document.getElementById("cour_cust_nm").value     
                                     + "&strCourPostNo="             +  document.getElementById("cour_post_no").value   
                                     + "&strCourAddr="               +  document.getElementById("cour_addr1").value 
                                     + "&strCourDtaAddr="            +  document.getElementById("cour_addr2").value 
                                     + "&strCourMobileNo1="          +  document.getElementById("cour_m_phone1").value             
                                     + "&strCourMobileNo2="          +  document.getElementById("cour_m_phone2").value             
                                     + "&strCourMobileNo3="          +  document.getElementById("cour_m_phone3").value           
                                     + "&strCourHomeNo1="            +  document.getElementById("cour_phone1").value             
                                     + "&strCourHomeNo2="            +  document.getElementById("cour_phone2").value             
                                     + "&strCourHomeNo3="            +  document.getElementById("cour_phone3").value             
                                     + "&strCourCompNm="             +  document.getElementById("cour_comp_nm").value           
                                     + "&strCourSendNo="             +  document.getElementById("cour_send_no").value           
                                     + "&strProcStat="               +  strProcStat         
                                    ;                                                 
		<ajax:open callback="on_SaveXML" 
							param="param" 
							method="POST" 
							urlvalue="/edi/epro101.ep"/>
		
		
		<ajax:callback function="on_SaveXML">
	        
	        var cnt = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
	        
	        if( Number(cnt) > 0 ){
	        	showMessage(INFORMATION, OK, "GAUCE-1000", cnt+"건이 저장되었습니다.");
	        	getMaster();
           }else {
        	   showMessage(INFORMATION, OK, "GAUCE-1000", cnt);
           }
	        
		</ajax:callback>
}



function btn_del(){
}

function btn_new(){
    setObjec("new");
   //  alert(document.getElementById("take_seq").value);
    document.getElementById("take_seq").value="";
    document.getElementById("post_no").value="";
    document.getElementById("addr1").value="";
    document.getElementById("chk_sms").checked = false; 
    
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

function scrollAll(){
    document.all.MASTER_TITLE.scrollLeft = document.all.MASTER_CONTETN.scrollLeft;
}


//고객정보 동일 선택시 배송정보 자동 채움
function chkCour(){
    if(document.getElementById("chk_cour").checked){
    	document.getElementById("cour_cust_nm").value        = document.getElementById("cust_nm").value;
    	document.getElementById("cour_post_no").value        = document.getElementById("post_no").value;
    	document.getElementById("cour_addr1").value          = document.getElementById("addr1").value;
    	document.getElementById("cour_addr2").value          = document.getElementById("addr2").value;
    	document.getElementById("cour_m_phone1").value       =  document.getElementById("m_phone1").value;
        document.getElementById("cour_m_phone2").value       =  document.getElementById("m_phone2").value;
        document.getElementById("cour_m_phone3").value       =  document.getElementById("m_phone3").value;
        document.getElementById("cour_phone1").value         =  document.getElementById("phone1").value;
        document.getElementById("cour_phone2").value         =  document.getElementById("phone2").value;
        document.getElementById("cour_phone3").value         =  document.getElementById("phone3").value;
    }else{
    	document.getElementById("cour_cust_nm").value        = "";
        document.getElementById("cour_post_no").value        = "";
        document.getElementById("cour_addr1").value          = "";
        document.getElementById("cour_addr2").value          = "";
        document.getElementById("cour_m_phone1").value       = "";
        document.getElementById("cour_m_phone2").value       = "";
        document.getElementById("cour_m_phone3").value       = "";
        document.getElementById("cour_phone1").value         = "";
        document.getElementById("cour_phone2").value         = "";
        document.getElementById("cour_phone3").value         = "";
    }
}

function openHistory(){

	if(g_row < 0){
		showMessage(INFORMATION, OK, "USER-1000", "변경할 약속 내용을 조회 해주세요.");	
		return;
	}
	
	if(g_takeSeq == ""){
        showMessage(INFORMATION, OK, "USER-1000", "신규약속 내용입니다. 먼저 저장 해주세요.");   
        return;
    }
	
	var arrArg  = new Array();
	  arrArg.push(g_take_dt);
	  arrArg.push(g_strcd);
	  arrArg.push(g_takeSeq);
	  arrArg.push(g_procStat);

	  var returnVal = window.showModalDialog("/edi/epro101.ep?goTo=popup",
                                           arrArg,
                                           "dialogWidth:950px;dialogHeight:600px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
	  
	  if(returnVal == "save"){
		  //저장이 된경우 상세 내용 재 조회
		  getDetail( g_row );
	  }
}

/**
 * selChangDeilTp()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-07-18
 * 개    요 :  조회  
 * return값 : void
 */
function selChangDeilTp(){
	var courContents = document.getElementsByName("cour_contents");
	
	//[2011.07.18]인도방식이 택배발송인 경우만 배송정보 활성화
	if (document.getElementById("deli_type").value == "02" ) { // 02:택배수령
	    for(var j=0;j<courContents.length;j++){ // 배송정보 
	        courContents[j].disabled="";
	    }
	    enableControl(img_cour_post_no, true);  // 우편번호 이미지
	} else {
	    for(var j=0;j<courContents.length;j++){ // 배송정보 
	        courContents[j].disabled="disabled";    
	    }
	    enableControl(img_cour_post_no, false); // 우편번호 이미지
	}   
}

function numberCheck() { 
//	firstTelFormatAll(document.getElementById("m_phone1").value);
	var strPhone1 = document.getElementById("m_phone1").value;
	if(strPhone1.length ==3) {
		if(strPhone1 == "010" || strPhone1 == "011" || strPhone1 == "016" || strPhone1 == "017" || strPhone1 == "018" || strPhone1 == "019") {
			
		}
		else { 
			if(strPhone1.length == 0) {
			//	alert();
				return;
			}
	        showMessage(StopSign, Ok, "USER-1000", "핸드폰 번호를 확인하세요");  
	        document.getElementById("m_phone1").focus();
	        return;
		}
    } 
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
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>약속대장관리</td>
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
                <td width="140"><input type="text" name="s_str_nm" id="s_str_nm" size="21" maxlength="10" value="<%=strNm %>" disabled="disabled" /><input type="hidden" name="strcd" id="strcd" ></td>
                <th width="80" class="point">협력사코드</th>
                <td width="140">
                    <input type="hidden" name="s_ven_cd" id="s_ven_cd" value="<%=vencd %>" disabled="disabled" />
                    <input type="text" name="s_ven_nm" id="s_ven_nm" size="21" value="<%=venNm %>" disabled="disabled" />
                </td>
                <th width="80">브랜드코드</th>
                <td>
                    <select name="s_pumbun_cd" id="s_pumbun_cd" style="width: 143;">
                    
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
                      <input type="text" name="s_cust_nm" id="s_cust_nm" size="21" onkeyup="checkByteLength(this, 40);"/>
                  </td>
                  <th>약속유형</th>
                  <td colspan="3">
                      <select id="s_in_prom_type" name="s_in_prom_type" style="width:138;">
                      </select>
                  </td>
              </tr>
          </table>
        </td>
      </tr>
    </table></td>
  </tr> 
    <tr>
        <td class="dot"></td>
    </tr>
     <tr>
    <td class="PT05">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
        <td width="300"><!-- 약속목록 -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td class="sub_title "><img src="<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 약속목록</td>
            </tr>
            <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
                    <tr >
                        <td>
                            <div id="MASTER_TITLE" style=" width:300px; overflow:hidden;"> 
                                <table width=405 border="0" cellspacing="0" cellpadding="0" class="g_table" >
                                    <tr>
                                        <th width="25">NO</th>
                                        <th width="80">점</th>
                                        <th width="80">접수일자</th>
                                        <th width="40">순번</th>
                                        <th width="60">약속유형</th>
                                        <th width="70">고객명</th>
                                        <th width="15">&nbsp;</th>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="MASTER_CONTETN" style="width:300px;height:410px;overflow:scroll" onscroll="scrollAll();">
                                <table width="325" border="0" cellspacing="0" cellpadding="0" class="g_table" id="tb_master">
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
            </tr>
            </table>
        </td><!-- 약속목록 -->
        <td width=5>
        </td>
        <td valign="top"> <!-- 약속 상세 내역 -->
        <div id="DETAIL_CONTETN" style="width=510px;height:455px;overflow:scroll">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
        <td class="sub_title">&nbsp;<img src="<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>기본사항</td>
        </tr>
        <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
               <tr>
                   <th width="70"  class="POINT">점</th>
                   <td width="150">
                         <input type="text" name="str_nm" id="str_nm" size="23" disabled="disabled" >
                   </td>
                   <th width="70" class="POINT">접수일자</th>
                   <td>
                         <input type="text" name="contents" id="take_dt" size="10" maxlength="15" onkeypress="javascript:onlyNumber();" 
                         onblur="dateCheck(this);" onfocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' tabindex="1">
                         <img src="<%=dir%>/imgs/btn/date.gif" alt="접수일자" align="absmiddle" onclick="openCal('G',take_dt);return false;" id="img_take_dt" />
                   </td>
               </tr>
               <tr>
                   <th class="POINT">접수순번</th>
                   <td>
                         <input type="text" name="take_seq" id="take_seq" size="23" disabled="disabled">
                   </td>
                  
                   <th class="POINT">브랜드</th>
                   <td  >
                        <select id="pumbun_cd" name="contents" style="width:150;"  tabindex="1">
                        </select>
                   </td>
               </tr>
           </table>
        </td>
        </tr>
        <tr height="20" valign="bottom">
        <td class="sub_title">&nbsp;<img src="<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>고객정보
         <input type="checkbox" name="contents" id="chk_sms" >  SMS 수신여부
        </td>
        </tr>
       <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
               <tr>
                   <th width="70"  class="POINT">고객명</th>
                   <td width="150">
                         <input type="text" name="contents" id="cust_nm" size="23" onkeyup="checkByteLength(this, 40);"  tabindex="1">
                   </td>
                   <th width="70">우편번호</th>
                   <td>
                         <input type="text" name="post_no" id="post_no" size="10" maxlength="10" style='text-align:center;IME-MODE: disabled' disabled="disabled" >
                         <img src="<%=dir%>/imgs/btn/detail_search_s.gif" alt="우편번호" align="absmiddle" onclick="javascript:getPostPop('post_no', 'addr1', 'addr2');"  tabindex="1" id="img_post_no" name="img_post_no"/>
                   </td>
               </tr>
               <tr>
                   <th>주소</th>
                   <td>
                         <input type="text" name="addr1" id="addr1" size="23" disabled="disabled">
                   </td>
                  
                   <th>상세주소</th>
                   <td  >
                        <input type="text" name="contents" id="addr2" size="23" onkeyup="checkByteLength(this, 80);"  tabindex="1">
                   </td>
               </tr>
               <tr>
                   <th class="POINT">휴대폰번호</th>
                   <td  > 
                         <input type="text" name="contents" id="m_phone1" size="5" maxlength=3 onkeypress="javascript:onlyNumber();" onblur="numberCheck()"  tabindex="1" style='text-align:center;IME-MODE: disabled'>
                         - <input type="text" name="contents" id="m_phone2" onkeypress='javascript:onlyNumber();'  size="5" maxlength=4 style='text-align:center;IME-MODE: disabled' tabindex="1" >
                         - <input type="text" name="contents" id="m_phone3" size="5" onkeypress='javascript:onlyNumber();' maxlength=4 style='text-align:center;IME-MODE: disabled'  tabindex="1" >
                   </td>
                  
                   <th>전화번호</th>
                   <td  >
                        <input type="text" name="contents" id="phone1" size="5" onkeypress='javascript:onlyNumber();'  tabindex="1" maxlength=3 style='text-align:center;IME-MODE: disabled'>
                         - <input type="text" name="contents" id="phone2" size="5" onkeypress='javascript:onlyNumber();'  tabindex="1" maxlength=4 style='text-align:center;IME-MODE: disabled'>
                         - <input type="text" name="contents" id="phone3" size="5" onkeypress='javascript:onlyNumber();'  tabindex="1"  maxlength=4 style='text-align:center;IME-MODE: disabled'>
                   </td>
               </tr>
           </table>
        </td>
        </tr>
         <tr height="20" valign="bottom">
         <td>
         <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
        <td class="sub_title">&nbsp;<img src="<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>약속내역
        </td>
        <td align=right>
        <!--  약속변경 팝업 -->
        <img src="<%=dir%>/imgs/btn/change_promise.gif" id="img_popup"  align="absmiddle" onclick="javascript:openHistory();"/>
        </td>
        </tr>
        </table>
        </td>
        </tr>
       <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
               <tr>
                   <th width="70"  class="POINT">최초약속일</th>
                   <td >
                         <input type="text" name="contents" id="frst_prom_dt" size="10" maxlength="10" onkeypress="javascript:onlyNumber();" 
                         onblur="dateCheck(this);" onfocus="dateValid(this);"  tabindex="1" style='text-align:center;IME-MODE: disabled'>
                         <img src="<%=dir%>/imgs/btn/date.gif" alt="최초약속일" align="absmiddle" onclick="openCal('G',frst_prom_dt);return false;" id="img_frst_dt" />
                         <select id="frst_prom_hh" name="contents" style="width:50;"  tabindex="1" >
                        </select>
                        <select id="frst_prom_mm" name="contents" style="width:50;"  tabindex="1" >
                        </select>
                   </td>
                   <th width="70" class="POINT">약속유형</th>
                   <td>
                         <select  name="contents" id="prom_type" style="width: 55;"  tabindex="1" >
                         </select>
                   </td>
               </tr>
               <tr>
                   <th>최종약속일</th>
                   <td>
                         <input type="text" name="contents" id="last_prom_dt" size="10" maxlength="10" onkeypress="javascript:onlyNumber();" 
                         onblur="dateCheck(this);" onfocus="dateValid(this);"  tabindex="1" style='text-align:center;IME-MODE: disabled'>
                         <img src="<%=dir%>/imgs/btn/date.gif" alt="최종약속일" align="absmiddle" onclick="openCal('G',last_prom_dt);return false;" id="img_last_dt" />
                         <select id="last_prom_hh" name="contents" style="width:50;"  tabindex="1" >
                        </select>
                        <select id="last_prom_mm" name="contents" style="width:50;"  tabindex="1" >
                        </select>
                   </td>
                  
                   <th class="POINT">인도방식</th>
                   <td>
                        <select id="deli_type" name="contents" style="width:95;"  tabindex="1" onChange="javascript:selChangDeilTp();">
                        </select>
                   </td>
               </tr>
               <tr>
                   <th class="POINT">인도점</th>
                   <td  >
                         <select id="deli_str" name="contents"  tabindex="1" style="width:95;">
                        </select>
                   </td>
                  
                   <th class="POINT">입고예정일</th>
                   <td  >
                        <input type="text" name="contents" id="in_deli_dt" size="10" maxlength="10" onkeypress="javascript:onlyNumber();" 
                         onblur="dateCheck(this);" onfocus="dateValid(this);"  tabindex="1" style='text-align:center;IME-MODE: disabled'>
                         <img src="<%=dir%>/imgs/btn/date.gif" alt="입고예정일" align="absmiddle" onclick="openCal('G',in_deli_dt);return false;" id="img_in_dt" />
                   </td>
               </tr>
                <tr>
                   <th>상품명</th>
                   <td colspan=3>
                         <input type="text" name="contents" id="sku_nm" size=60"  tabindex="1" onkeyup="checkByteLength(this, 40);">
                   </td>
               </tr>
               <tr>
                  <th>약속내역</th>
                  <td  colspan=3 class="PT02 PB02" >
                      <textarea style="height:105;width:100%;"  name="contents" id="prom_dtl" tabindex="1"  onkeyup="checkByteLength(this, 4000);" ></textarea>
                  </td>
              </tr>
           </table>
        </td>
        </tr>  
         <tr height="20" valign="bottom">
        <td class="sub_title">&nbsp;<img src="<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>배송정보
        <input type="checkbox" name="cour_contents" id="chk_cour" onclick="javascrip:chkCour();">  고객정보와 동일
        </td>
        </tr>
       <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
               <tr>
                   <th width="70"  class="POINT">고객명</th>
                    <td width="150">
                         <input type="text" name="cour_contents"  tabindex="1" id="cour_cust_nm" size="23" onkeyup="checkByteLength(this, 40);">
                   </td>
                   <th width="70">우편번호</th>
                   <td>
                         <input type="text" name="cour_post_no" id="cour_post_no"  size="10" maxlength="10" style='text-align:center;IME-MODE: disabled' disabled="disabled" >
                         <img src="<%=dir%>/imgs/btn/detail_search_s.gif" alt="우편번호" tabindex="1" align="absmiddle" onclick="javascript:getPostPop('cour_post_no', 'cour_addr1', 'cour_addr2');" id="img_cour_post_no" />
                   </td>
               </tr>
               <tr>
                   <th>주소</th>
                   <td>
                         <input type="text" name="cour_addr1" id="cour_addr1" size="23" disabled="disabled">
                   </td>
                  
                   <th>상세주소</th>
                   <td  >
                        <input type="text" name="cour_contents" id="cour_addr2" size="23" onkeyup="checkByteLength(this, 80);" tabindex="1" >
                   </td>
               </tr>
               <tr>
                   <th class="POINT">휴대폰번호</th>
                   <td  > 
                         <input type="text" name="cour_contents" id="cour_m_phone1" size="5"  tabindex="1" onkeypress='javascript:onlyNumber();'  maxlength=3 style='text-align:center;IME-MODE: disabled'>
                         -<input type="text" name="cour_contents" id="cour_m_phone2" size="5"  tabindex="1" onkeypress='javascript:onlyNumber();'  maxlength=4 style='text-align:center;IME-MODE: disabled'>
                         -<input type="text" name="cour_contents" id="cour_m_phone3" size="5"  tabindex="1" onkeypress='javascript:onlyNumber();'  maxlength=4 style='text-align:center;IME-MODE: disabled'>
                   </td>
                  
                   <th>전화번호</th>
                   <td  > 
                        <input type="text" name="cour_contents" id="cour_phone1" size="5"  tabindex="1" onkeypress='javascript:onlyNumber();'  maxlength=3 style='text-align:center;IME-MODE: disabled'>
                         -<input type="text" name="cour_contents" id="cour_phone2" size="5"  tabindex="1" onkeypress='javascript:onlyNumber();'  maxlength=4 style='text-align:center;IME-MODE: disabled'>
                         -<input type="text" name="cour_contents" id="cour_phone3" size="5"  tabindex="1" onkeypress='javascript:onlyNumber();'  maxlength=4 style='text-align:center;IME-MODE: disabled'>
                   </td>
               </tr>
               <tr>
                   <th>택배회사</th>
                   <td  >
                         <input type="text" name="cour_contents" id="cour_comp_nm" size="23"  tabindex="1" onkeyup="checkByteLength(this, 40);">
                   </td>
                  
                   <th>운송장번호</th>
                   <td>
                        <input type="text" name="cour_contents" id="cour_send_no" size="23"  tabindex="1" onkeyup="checkByteLength(this, 40);">
                   </td>
               </tr>
           </table>
        </td>
        </tr>
        <tr height="20" valign="bottom">
        <td class="sub_title">&nbsp;<img src="<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>진행상태</td>
        </tr>
       <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
               <tr>
                   <td width=350px align="center">
	                   <input type="radio" name="sel_proc_stat" id="sel_proc_stat"  tabindex="1"  value="1" checked="true" disabled="disabled"/>  접수 
	                   <input type="radio" name="sel_proc_stat" id="sel_proc_stat" tabindex="1"  value="2" />  입고/수선완료
	                   <input type="radio" name="sel_proc_stat" id="sel_proc_stat" tabindex="1"  value="3" />  인도완료
	                   <input type="radio" name="sel_proc_stat" id="sel_proc_stat" tabindex="1"  value="4" disabled="disabled" />  취소완료
                   </td>
                   <td>
                         <input type="checkbox" name="chk_happyCall" id="chk_happyCall" size="10" disabled="disabled" > 해피콜완료
                   </td>
           </table>
        </td>
        </tr>
        </table>
        </div>
        </td>
        </tr><!-- 약속 상세 내역 -->
        </table>
    
    </td>
  </tr>
     
</table>
</body>
</html>

