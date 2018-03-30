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
	String gb = sessionInfo.getGB(); //1. 협력사     2.브랜드
    String pumbunCd          = sessionInfo.getPUMBUN_CD();      //브랜드코드
    String pumbunNm          = sessionInfo.getPUMBUN_NAME();    //브랜드명
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>마리오 아울렛</title>
<link href="<%=dir%>/css/ds.css" rel="stylesheet" type="text/css" />
<script language="javascript"  src="<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/popup.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/message.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/gauce.js"  type="text/javascript"></script>

<script language="javascript">
var strcd = '<%=strcd%>';           //점코드
var userid = '<%=userid%>';
var gb = '<%=gb%>';
var vencd = '<%=vencd%>';
var venNm = '<%=venNm%>';
var g_strcd = '<%=strcd%>';
var pumbunCd    = '<%=pumbunCd%>';
var g_pre_row = -1;                 //현재로우
var g_last_row = -1;                //이전로우


var g_gs_gbn = new Array();         //관세 코드
var g_gs_gbn_nm = new Array();      //관세 명
var strToday;                       //DB 현재일
var reg_rate;                       //등록일

//master 조회 
var gl_strcd;                       //점코드
var gl_slip_no;                     //전표번호
var g_pumbun_cd;                    //브랜드코드
var norm_mg_rate;                   //행사 마진율
var g_tax_flag;                     //택구분
var roundFlag = "";                 //원가단가 반올림 구분 (1:반올림 2:올림 3:내림)
var g_hs_gbn = new Array();         //행사 구분 value
var g_hs_gbn_nm = new Array();      //행사 구분 text
var g_event_rate;                   //행사율 value
var g_event_rate_nm;                //행사율 text
var gl_remark_gb = "";              //input의 비교 내용
var g_remark_ch = "1";              //input의 비고란의 내용이 변경 되엇을시 3 으로 세팅 아닐경우 1로

var detailRowCnt = 0;               //디테일 건수
var new_row = "1";                  //신규 저장시 3 세팅
var strSlip_no_new = "";
var update_slipno = "";
var strMst = "";
var strPro = "";
var str_cnt = 0;
var sel_up = 0;
var sumQty = 0;                     //저장시 DETAIL 수량
var SLIP_PROC_STAT = "";
var slip_proc_stat_save = "";


function remarkCh(obj){
    
    if( gl_remark_gb !=  obj.value ){          //비고 내용 변경
        g_remark_ch = "3";
    } else {                                   //비고 내용 변경 안되었음.
        g_remark_ch = "1";
    }
}
/**
 * doinit()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  최초로딩시 
 * return값 : void
 */ 
function doinit(){
    
    /* 버튼비활성화  */
    enableControl(search,true);     //신규
    enableControl(newrow,true);     //신규
    enableControl(del,true);        //삭제
    enableControl(save,true);       //저장
    enableControl(excel,false);     //엑셀
    enableControl(prints,false);    //프린터   
    
    /* 조회 항목  */
    initDateText('SYYYYMMDD', 'em_S_Date');        //시작일
    initDateText("TODAY", "em_E_Date");            //종료일
    
    
    /*조회부*/
    
    /* 구분 값이 브랜드로 로그인시 "전체" 값 없음 */
    if(gb=="1"){
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "Y", "2", pumbunCd);                        //점별 브랜드 select box	
    }else{
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "N", "2", pumbunCd);                        //점별 브랜드 select box
    }
    
    getSelectCombo("D", "P214", "gjDate");                                      //기준일
    getSelectCombo("D", "P207", "Sel_slip_proc_falg");                          //전표상태
    getEtcEm("D", "P004");                                                      //과세구분
    
    /* 입력부 */
    strToday        = getTodayDB2();                                            //db 오늘일자
    getPumbunCombo(g_strcd, vencd, "IN_PB_CD", "N","2", pumbunCd);                        //입력부 브랜드
  
    document.getElementById("pubumCd").focus();
     
    
    // 입력부 비활성화
    setObject(false);
    //사후구분이 재고조정일때 발주일, 납품예정일, 마진적용일 달력컨트롤 사용막는다
    setCalImgDis(false);
    enableControl(IMG_ADD, false);
    enableControl(IMG_DEL, false);
    
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
function getPumbunCombo(strcd, vencd, target, YN, skuFlag, pumbunCd){
     var param = "";
    
     param = "&goTo=getPumbunCombo&strcd=" + strcd
              + "&vencd=" + vencd
              + "&gb=" + gb
              + "&skuFlag=" + skuFlag
              + "&pumbunCd=" + pumbunCd
              ;
    
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
 * getEtcEm()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  과세구분
 * return값 : void
 */ 
function getEtcEm(syspat, compart){
    var param = "&goTo=getEtcCode&syspat="+syspat+"&compart="+compart;
    <ajax:open callback="on_SelectComboXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/ccom001.cc"/>
    
    <ajax:callback function="on_SelectComboXML"> 
    
        for( i = 0; i < rowsNode.length; i++ ){
            g_gs_gbn[i] = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
            g_gs_gbn_nm[i] = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
            
        } 
    
    </ajax:callback>
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
        if( target != "gjDate" ){
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
 * getSearch()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  조회 
 * return값 : void
 */ 
function btn_Search(){
    var b_strcd = document.getElementById("strcd").value;                      //점코드
    var vencd = document.getElementById("vencd").value;                        //협력사코드
    var pubumCd = document.getElementById("pubumCd").value;                    //브랜드코드
    var slip_proc_falg = document.getElementById("Sel_slip_proc_falg").value;  //전표 상태
    var gjDate = document.getElementById("gjDate").value;                      //기준일
    var sDate = document.getElementById("em_S_Date").value;                    //시작일
    var eDate = document.getElementById("em_E_Date").value;                    //종료일
    var slip_falg = "";                                                        //전표구분
   
    for( i = 0; i < document.getElementsByName("Sel_slip_falg").length; i++ ){
        if( document.getElementsByName("Sel_slip_falg")[i].checked ){
            slip_falg = document.getElementsByName("Sel_slip_falg")[i].value;
        }
    }
    
    if( strcd == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "점");
        document.getElementById("strnm").focus();
        return;
    }
    
    if( vencd == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "협력사코드");
        document.getElementById("vencd").focus();
        return;
    }
    
    if( sDate == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "시작일");
        document.getElementById("em_S_Date").focus();
        return;
    }
    if( eDate == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "종료일");
        document.getElementById("em_E_Date").focus();
        return;
    }
    
  //시작, 종료일 일자체크
    var em_sdate = getRawData(trim(document.getElementById("em_S_Date").value));
    var em_edate = getRawData(trim(document.getElementById("em_E_Date").value));   
    
    if (em_sdate > em_edate) { //시작일은 종료일보다 커야 합니다.
        showMessage(StopSign, OK, "USER-1008", "종료일", "시작일");
        document.getElementById("em_S_Date").focus();
        return;
    }
 
    getSearch(sel_up);
    
}

/**
 * getSearch()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  리스트 조회 
 * return값 : void
 */ 
function getSearch(sel_up){
	 
	// 스크롤 위치 초기화      
    document.all.DivListTitle.scrollLeft = 0;
    document.all.DivListContent.scrollLeft = 0;
    document.all.DETAIL_Title.scrollLeft = 0;
    document.all.DETAIL_CONTETN.scrollLeft = 0; 
	    
    new_row = "1";
    g_remark_ch = "1";
    var b_strcd = document.getElementById("strcd").value;                      //점코드
    var vencd = document.getElementById("vencd").value;                        //협력사코드
    var pubumCd = document.getElementById("pubumCd").value;                    //브랜드코드
    var slip_proc_falg = document.getElementById("Sel_slip_proc_falg").value;  //전표 상태
    var gjDate = document.getElementById("gjDate").value;                      //기준일
    var sDate = document.getElementById("em_S_Date").value;                    //시작일
    var eDate = document.getElementById("em_E_Date").value;                    //종료일
    var slip_falg = "";                                                        //전표구분
    str_cnt = 0;
    for( i = 0; i < document.getElementsByName("Sel_slip_falg").length; i++ ){
        if( document.getElementsByName("Sel_slip_falg")[i].checked ){
            slip_falg = document.getElementsByName("Sel_slip_falg")[i].value;
        }
    }
     
    var param = "&goTo=getList&strcd=" + b_strcd
                                       + "&vencd="              + vencd
                                       + "&pubumCd="            + pubumCd
                                       + "&slip_proc_falg="     + slip_proc_falg
                                       + "&gjDate="             + gjDate
                                       + "&sDate="              + sDate
                                       + "&eDate="              + eDate
                                       + "&slip_falg="          + slip_falg;
                                       
    <ajax:open callback="on_ListXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/eord101.eo"/>
    
    <ajax:callback function="on_ListXML">
    
        var content = "<table width='380' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_list'>";
        if( rowsNode.length > 0 ){
             
            for( i = 0; i < rowsNode.length; i++ ){
                
            	str_cnt = i;
                /* 전표번호 */
                /* 점코드 */
                /* 점명 */
                /* 전표구분 */
                /* 전표구분명 */
                /* 발주일자(점출일, 시행일) */
                /* 전표진행상태 */
                /* 전표진행상태명 */                                
                
                var slip_no = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : String(rowsNode[i].childNodes[0].childNodes[0].nodeValue);
                var strcd = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                var strNm = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
                var slip_falg = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                var slip_flag_nm = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
                var ord_dt = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
                var slip_proc_stat = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
                var slip_proc_stat_nm = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
                
                content += "<tr onclick='chBak("+i+");getMaster("+i+");' style='cursor:hand;'>";
                content += "<input type='hidden' name='strcd' id='strcd"+i+"' value='"+strcd+"' />";
                content += "<input type='hidden' name='slip_no' id='slip_no"+i+"'  value='"+slip_no+"' />";
                content += "<input type='hidden' name='slip_proc_stat' id='slip_proc_stat"+i+"'  value='"+slip_proc_stat+"' />";
                content += "<td class='r3' width='75' id='1listtdId"+i+"' >"+strNm+"</td>";
                content += "<td class='r3' width='40' id='2listtdId"+i+"'>"+slip_flag_nm+"</td>";
                content += "<td class='r1' width='90' id='3listtdId"+i+"'>"+slip_format(slip_no)+"</td>";
                content += "<td class='r1' width='75' id='4listtdId"+i+"'>"+getDateFormat(ord_dt)+"</td>";
                content += "<td class='r3' width='65' id='5listtdId"+i+"'>"+slip_proc_stat_nm+"</td>";
                content += "</tr>";
                
            }
              
            enableControl(IMG_ADD, true);
            enableControl(IMG_DEL, true);
        }else {
            enableControl(IMG_ADD, false);
            enableControl(IMG_DEL, false);
        }
        
        content += "</table>";
        document.getElementById("DivListContent").innerHTML = content;
        setPorcCount("SELECT", rowsNode.length);
        
        if( slip_falg == "B" ){
            document.getElementsByName("IN_SLIP_FLAG")[1].checked = true;
        }else {
            document.getElementsByName("IN_SLIP_FLAG")[0].checked = true;
        }
        
        document.getElementById("IN_SH_GBN").value = "0";
        document.getElementById("IN_SH_GBN_NM").value = "사전전표";
        
        document.getElementById("IN_PB_CD").index = 0;
        document.getElementById("IN_BALJUJC").value = "1";
        document.getElementById("ord_own_falg_nm").value = "EDI발주";
        
        if( document.getElementById("IN_SH_GBN").value == "0" ) {
            var nextDay = addDate("d", 1, strToday);
            document.getElementById("IN_BJDATE").value = getDateFormat(strToday);
            document.getElementById("IN_NPYJDATE").value = nextDay;
            document.getElementById("IN_MAJINDATE").value = nextDay;
            setCalImgDis(true);
        }
        
        document.getElementById("HRS_CD").value = '<%=vencd%>';
        document.getElementById("HRS_NM").value = '<%=venNm%>';
        document.getElementById("IN_BJHJDATE").value = "";
        
        /* 수정 해야 할 부분   */
        document.getElementById("HRS_CD").value = "";
        document.getElementById("HRS_NM").value = "";
        document.getElementById("IN_GS_GBN_NM").value = "";
        document.getElementById("IN_GS_GBN").value = "";
        document.getElementById("IN_BUYER_CD").value = "";
        document.getElementById("IN_BUYER_NM").value = "";
        
        
        document.getElementById("IN_HS_GBN").length = 0;
        document.getElementById("IN_HS_RATE").length = 0;
        document.getElementById("IN_GPWJ_DATE").value = "";
        document.getElementById("IN_SRG").value = "";
        document.getElementById("IN_WGG").value = "";
        //document.getElementById("IN_VAT").value = "";
        document.getElementById("IN_MGG").value = "";
        document.getElementById("IN_ETC").value = "";
        
        detail_content = "<table width='860' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_detail'></table>";
        document.getElementById("DETAIL_CONTETN").innerHTML = detail_content;
     	// 입력부 비활성화
        setObject(false);
        //사후구분이 재고조정일때 발주일, 납품예정일, 마진적용일 달력컨트롤 사용막는다
        setCalImgDis(false);
        
        // 2011.07.15 kjm 추가
        // 조회버튼 클릭시 하단그리드도 같이 조회 
     	//   alert("slipno : " + update_slipno );
        //alert("sel_up : " + sel_up );
        if( sel_up == "3" ){         // ?꾪몴 ?좉퇋 ?깅줉
        	//alert("1");
            ch_new(strSlip_no_new);
        }
        else if ( sel_up == "1" ) { 
            //alert("2");
            //   alert(update_slipno);
            ch_update(update_slipno); // ?꾪몴 ?낅뜲?댄듃
        } 
        else {
            //alert("3");              // 議고쉶 諛??좉퇋
            ch_new("");                
        }
        
     //   chBak(0);
    //    getMaster2(0);
    </ajax:callback>
    
    
  
}

/**
 * getMaster()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  마스터 조회 
 * return값 : void
 */ 
function getMaster( i ){
     /*
     if( new_row == "3" ){
         if( confirm("변경 내역이 존재 합니다. 조회 하시겠습니까?") != 1 ){
             return;
         }
     }
     */
     // 비고 란의 내용이 변경 되었을 경우 리스트 마스터 로우 클릭시 
     if( g_remark_ch == "3" ){
         if( showMessage(QUESTION, YESNO, "GAUCE-1000", "변경 내역이 존재 합니다. 조회 하시겠습니까?") != 1){
                return;
         }
         g_remark_ch = "1";
     }
     
     
     new_row = "1";
    // 입력부 비활성화
     setObject(false);
     //사후구분이 재고조정일때 발주일, 납품예정일, 마진적용일 달력컨트롤 사용막는다
     setCalImgDis(false);
        
    var strcd = document.getElementById("strcd"+i).value;
    var strSlip_no = document.getElementById("slip_no"+i).value;
    var strSlip_procStat = document.getElementById("slip_proc_stat"+i).value;
    
    
    var param = "&goTo=getMaster&strcd="+strcd+"&slip_no="+strSlip_no;
    <ajax:open callback="on_getMasterXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/eord101.eo"/>
    
    <ajax:callback function="on_getMasterXML">
    
    /* 0.점코드  1.점명  2.전표번호 3.브랜드코드 4.브랜드명 5.협력사코드 6.협력사명 7.마진적용일 8.행사구분 8.행사명 10.행사율 11.전표구분 12.전표명 13.발주주체구분
      14.발주주체명 15.발주주체 16.사전사후구분 17.발주일자 18.납품예정일 19.검품일자 20.sm확정일자 21.sm id 22.바이어 아이디 23.바이어확정일 
      24.바이어코드 25.바이어명 26.경리승인일 27.전표진행상테 28.전표진행상태명 29.명세건수 30.발주수량합 31.신원가금액합 32.신매가금액합
      33.차익액합 34.신차익율 35.지불조건 36.비고 37.거래형태  38.택구분 39.택명 40.등록일
    */
             
       
        var strcd = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
        var strNm = rowsNode[0].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[1].childNodes[0].nodeValue;
        var slip_no = rowsNode[0].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[2].childNodes[0].nodeValue;
        gl_strcd     = strcd;
        gl_slip_no   = slip_no;
        var pumbuncd = rowsNode[0].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[3].childNodes[0].nodeValue;
        var pumbunNm = rowsNode[0].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[4].childNodes[0].nodeValue;
        var vencd = rowsNode[0].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[5].childNodes[0].nodeValue;
        var venNm = rowsNode[0].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[6].childNodes[0].nodeValue;
        var mg_app_dt = rowsNode[0].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[7].childNodes[0].nodeValue;
        var event_falg = rowsNode[0].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[8].childNodes[0].nodeValue;
        var event_falgNm = rowsNode[0].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[9].childNodes[0].nodeValue;
        var event_rate = rowsNode[0].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[10].childNodes[0].nodeValue;
        var slip_falg = rowsNode[0].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[11].childNodes[0].nodeValue;
        var slip_falg_nm = rowsNode[0].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[12].childNodes[0].nodeValue;
        var ord_own_falg = rowsNode[0].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[13].childNodes[0].nodeValue;
        var ord_own_falg_nm = rowsNode[0].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[14].childNodes[0].nodeValue;
        var ord_falg = rowsNode[0].childNodes[15].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[15].childNodes[0].nodeValue;
        var aft_ord_falg = rowsNode[0].childNodes[16].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[16].childNodes[0].nodeValue;
        var org_dt = rowsNode[0].childNodes[17].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[17].childNodes[0].nodeValue;
        var deli_dt = rowsNode[0].childNodes[18].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[18].childNodes[0].nodeValue;
        var chk_dt = rowsNode[0].childNodes[19].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[19].childNodes[0].nodeValue;
        var sm_conf_dt = rowsNode[0].childNodes[20].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[20].childNodes[0].nodeValue;
        var sm_id = rowsNode[0].childNodes[21].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[21].childNodes[0].nodeValue;
        var buyer_conf_id = rowsNode[0].childNodes[22].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[22].childNodes[0].nodeValue;
        var ord_conf_dt = rowsNode[0].childNodes[23].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[23].childNodes[0].nodeValue;
        var buyer_cd = rowsNode[0].childNodes[24].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[24].childNodes[0].nodeValue;
        var buyerNm = rowsNode[0].childNodes[25].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[25].childNodes[0].nodeValue;
        var acc_conf_dt = rowsNode[0].childNodes[26].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[26].childNodes[0].nodeValue;
        var slip_proc_stat = rowsNode[0].childNodes[27].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[27].childNodes[0].nodeValue;
        var slip_proc_stat_nm = rowsNode[0].childNodes[28].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[28].childNodes[0].nodeValue;
        var dtl_cnt = rowsNode[0].childNodes[29].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[29].childNodes[0].nodeValue;
        var ord_tot_qty = rowsNode[0].childNodes[30].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[30].childNodes[0].nodeValue;
        var new_cost_tamt = rowsNode[0].childNodes[31].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[31].childNodes[0].nodeValue;
        var new_sale_tamt = rowsNode[0].childNodes[32].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[32].childNodes[0].nodeValue;
        var gam_tot_amt = rowsNode[0].childNodes[33].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[33].childNodes[0].nodeValue;
        var new_gam_rate = rowsNode[0].childNodes[34].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[34].childNodes[0].nodeValue;
        var pay_cond = rowsNode[0].childNodes[35].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[35].childNodes[0].nodeValue;
        var remark = rowsNode[0].childNodes[36].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[36].childNodes[0].nodeValue;
        var biz_type = rowsNode[0].childNodes[37].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[37].childNodes[0].nodeValue;
        var tax_falg = rowsNode[0].childNodes[38].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[38].childNodes[0].nodeValue;
        var tax_falg_nm = rowsNode[0].childNodes[39].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[39].childNodes[0].nodeValue;
        var regDate = rowsNode[0].childNodes[40].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[40].childNodes[0].nodeValue;
        var vatAmt = rowsNode[0].childNodes[41].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[41].childNodes[0].nodeValue;
        norm_mg_rate = rowsNode[0].childNodes[42].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[42].childNodes[0].nodeValue;;        //마스터 마진율
        
        reg_rate = rowsNode[0].childNodes[40].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[40].childNodes[0].nodeValue;
        g_pumbun_cd = pumbuncd              //선택 로우 브랜드
        g_tax_flag = tax_falg;              //택구분
        gl_remark_gb = remark;              //비고 내용이 변경 되었을시 체크
        
        document.getElementById("IN_STR_CD").value = strcd;
        document.getElementById("IN_SLIP_NO").value = slip_no; 
        if( slip_falg == "B" ){
            
            document.getElementsByName("IN_SLIP_FLAG")[1].checked = true;
        }else {
            document.getElementsByName("IN_SLIP_FLAG")[0].checked = true;
        }
          
        document.getElementById("IN_SH_GBN").value = aft_ord_falg;
        document.getElementById("IN_SH_GBN_NM").value = "사전전표";
        
        document.getElementById("IN_PB_CD").value = pumbuncd;
        document.getElementById("IN_BALJUJC").value = "1";
        document.getElementById("ord_own_falg_nm").value = "EDI발주";
        document.getElementById("IN_BJDATE").value = getDateFormat(org_dt);
        if( ord_conf_dt != ""){
            document.getElementById("IN_BJHJDATE").value = getDateFormat(ord_conf_dt);
        }else {
            document.getElementById("IN_BJHJDATE").value = ord_conf_dt;
        }
        document.getElementById("HRS_CD").value = '<%=vencd%>';
        document.getElementById("HRS_NM").value = '<%=venNm%>';
        document.getElementById("IN_GS_GBN").value = tax_falg;
        document.getElementById("IN_GS_GBN_NM").value = tax_falg_nm;
        if( deli_dt != ""){
            document.getElementById("IN_NPYJDATE").value = getDateFormat(deli_dt);
        }else {
            document.getElementById("IN_NPYJDATE").value = deli_dt;
        }
        document.getElementById("IN_BUYER_CD").value = buyer_cd;
        document.getElementById("IN_BUYER_NM").value = buyerNm;
        if( mg_app_dt != ""){
            document.getElementById("IN_MAJINDATE").value = getDateFormat(mg_app_dt);
        }else {
            document.getElementById("IN_MAJINDATE").value = mg_app_dt;
        }
        if( chk_dt != ""){
            document.getElementById("IN_GPWJ_DATE").value = getDateFormat(chk_dt);
        }else {
            document.getElementById("IN_GPWJ_DATE").value = chk_dt; 
        }
        document.getElementById("IN_HS_GBN").length = 0;
        if( event_falg != "" ){
            
            var IN_HS_GBN = document.getElementById("IN_HS_GBN");
            var opt = document.createElement("option");  
            opt.setAttribute("value", event_falg);
            
            var text = document.createTextNode(event_falg);
            opt.appendChild(text); 
            IN_HS_GBN.appendChild(opt);
        }
        document.getElementById("IN_HS_RATE").length = 0;
        if( event_rate != "" ){
            var IN_HS_RATE = document.getElementById("IN_HS_RATE");
            var opt = document.createElement("option");  
            opt.setAttribute("value", event_rate);
            
            var text = document.createTextNode(event_rate);
            opt.appendChild(text); 
            IN_HS_RATE.appendChild(opt);
        }
        
        document.getElementById("IN_SRG").value = convAmt(ord_tot_qty); 
        document.getElementById("IN_WGG").value = convAmt(new_cost_tamt);      
        document.getElementById("IN_MGG").value = convAmt(new_sale_tamt);
        //document.getElementById("IN_VAT").value = convAmt(vatAmt);
        document.getElementById("IN_ETC").value = remark;                      //비고
        document.getElementById("IN_GAP_TOT_AMT").value = gam_tot_amt;         //차익액합
        document.getElementById("IN_NEW_GAP_RATE").value = new_gam_rate;       //차익율
        document.getElementById("IN_VAT_TAMT").value = vatAmt;                 //부가세  
        
        if( rowsNode.length > 0 ){
            getDetail(strcd, slip_no);
            
            if( strSlip_procStat == "00" || strSlip_no == "" ){
                document.getElementById("IN_ETC").disabled = false;
                setTimeout("detailEditable(false);", 100);
                enableControl(IMG_ADD, true);
                enableControl(IMG_DEL, true);
            } else {
                document.getElementById("IN_ETC").disabled = true;
                setTimeout("detailEditable(true);", 100);
                enableControl(IMG_ADD, false);
                enableControl(IMG_DEL, false);
                
            }
            
        }
        
    </ajax:callback>
    
}


/**
 * getMaster2()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  마스터 조회 - 처음 조회시 사용
 * return값 : void
 */ 
function getMaster2( i ){
     /*
     if( new_row == "3" ){
         if( confirm("변경 내역이 존재 합니다. 조회 하시겠습니까?") != 1 ){
             return;
         }
     }
     */
     // 비고 란의 내용이 변경 되었을 경우 리스트 마스터 로우 클릭시 
     if( g_remark_ch == "3" ){
         if( showMessage(QUESTION, YESNO, "GAUCE-1000", "변경 내역이 존재 합니다. 조회 하시겠습니까?") != 1){
                return;
         }
         g_remark_ch = "1";
     }
     
     
     new_row = "1";
    // 입력부 비활성화
     setObject(false);
     //사후구분이 재고조정일때 발주일, 납품예정일, 마진적용일 달력컨트롤 사용막는다
     setCalImgDis(false);
        
    var strcd = document.getElementById("strcd"+i).value;
    var strSlip_no = document.getElementById("slip_no"+i).value;
    var strSlip_procStat = document.getElementById("slip_proc_stat"+i).value;
    
    
    var param = "&goTo=getMaster&strcd="+strcd+"&slip_no="+strSlip_no;
    <ajax:open callback="on_getMasterXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/eord101.eo"/>
    
    <ajax:callback function="on_getMasterXML">
    
    /* 0.점코드  1.점명  2.전표번호 3.브랜드코드 4.브랜드명 5.협력사코드 6.협력사명 7.마진적용일 8.행사구분 8.행사명 10.행사율 11.전표구분 12.전표명 13.발주주체구분
      14.발주주체명 15.발주주체 16.사전사후구분 17.발주일자 18.납품예정일 19.검품일자 20.sm확정일자 21.sm id 22.바이어 아이디 23.바이어확정일 
      24.바이어코드 25.바이어명 26.경리승인일 27.전표진행상테 28.전표진행상태명 29.명세건수 30.발주수량합 31.신원가금액합 32.신매가금액합
      33.차익액합 34.신차익율 35.지불조건 36.비고 37.거래형태  38.택구분 39.택명 40.등록일
    */
             
       
        var strcd = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
        var strNm = rowsNode[0].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[1].childNodes[0].nodeValue;
        var slip_no = rowsNode[0].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[2].childNodes[0].nodeValue;
        gl_strcd     = strcd;
        gl_slip_no   = slip_no;
        var pumbuncd = rowsNode[0].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[3].childNodes[0].nodeValue;
        var pumbunNm = rowsNode[0].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[4].childNodes[0].nodeValue;
        var vencd = rowsNode[0].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[5].childNodes[0].nodeValue;
        var venNm = rowsNode[0].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[6].childNodes[0].nodeValue;
        var mg_app_dt = rowsNode[0].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[7].childNodes[0].nodeValue;
        var event_falg = rowsNode[0].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[8].childNodes[0].nodeValue;
        var event_falgNm = rowsNode[0].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[9].childNodes[0].nodeValue;
        var event_rate = rowsNode[0].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[10].childNodes[0].nodeValue;
        var slip_falg = rowsNode[0].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[11].childNodes[0].nodeValue;
        var slip_falg_nm = rowsNode[0].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[12].childNodes[0].nodeValue;
        var ord_own_falg = rowsNode[0].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[13].childNodes[0].nodeValue;
        var ord_own_falg_nm = rowsNode[0].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[14].childNodes[0].nodeValue;
        var ord_falg = rowsNode[0].childNodes[15].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[15].childNodes[0].nodeValue;
        var aft_ord_falg = rowsNode[0].childNodes[16].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[16].childNodes[0].nodeValue;
        var org_dt = rowsNode[0].childNodes[17].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[17].childNodes[0].nodeValue;
        var deli_dt = rowsNode[0].childNodes[18].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[18].childNodes[0].nodeValue;
        var chk_dt = rowsNode[0].childNodes[19].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[19].childNodes[0].nodeValue;
        var sm_conf_dt = rowsNode[0].childNodes[20].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[20].childNodes[0].nodeValue;
        var sm_id = rowsNode[0].childNodes[21].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[21].childNodes[0].nodeValue;
        var buyer_conf_id = rowsNode[0].childNodes[22].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[22].childNodes[0].nodeValue;
        var ord_conf_dt = rowsNode[0].childNodes[23].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[23].childNodes[0].nodeValue;
        var buyer_cd = rowsNode[0].childNodes[24].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[24].childNodes[0].nodeValue;
        var buyerNm = rowsNode[0].childNodes[25].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[25].childNodes[0].nodeValue;
        var acc_conf_dt = rowsNode[0].childNodes[26].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[26].childNodes[0].nodeValue;
        var slip_proc_stat = rowsNode[0].childNodes[27].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[27].childNodes[0].nodeValue;
        var slip_proc_stat_nm = rowsNode[0].childNodes[28].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[28].childNodes[0].nodeValue;
        var dtl_cnt = rowsNode[0].childNodes[29].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[29].childNodes[0].nodeValue;
        var ord_tot_qty = rowsNode[0].childNodes[30].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[30].childNodes[0].nodeValue;
        var new_cost_tamt = rowsNode[0].childNodes[31].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[31].childNodes[0].nodeValue;
        var new_sale_tamt = rowsNode[0].childNodes[32].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[32].childNodes[0].nodeValue;
        var gam_tot_amt = rowsNode[0].childNodes[33].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[33].childNodes[0].nodeValue;
        var new_gam_rate = rowsNode[0].childNodes[34].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[34].childNodes[0].nodeValue;
        var pay_cond = rowsNode[0].childNodes[35].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[35].childNodes[0].nodeValue;
        var remark = rowsNode[0].childNodes[36].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[36].childNodes[0].nodeValue;
        var biz_type = rowsNode[0].childNodes[37].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[37].childNodes[0].nodeValue;
        var tax_falg = rowsNode[0].childNodes[38].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[38].childNodes[0].nodeValue;
        var tax_falg_nm = rowsNode[0].childNodes[39].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[39].childNodes[0].nodeValue;
        var regDate = rowsNode[0].childNodes[40].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[40].childNodes[0].nodeValue;
        var vatAmt = rowsNode[0].childNodes[41].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[41].childNodes[0].nodeValue;
        norm_mg_rate = rowsNode[0].childNodes[42].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[42].childNodes[0].nodeValue;;        //마스터 마진율
        
        reg_rate = rowsNode[0].childNodes[40].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[40].childNodes[0].nodeValue;
        g_pumbun_cd = pumbuncd              //선택 로우 브랜드
        g_tax_flag = tax_falg;              //택구분
        gl_remark_gb = remark;              //비고 내용이 변경 되었을시 체크
        
        document.getElementById("IN_STR_CD").value = strcd;
        document.getElementById("IN_SLIP_NO").value = slip_no; 
        if( slip_falg == "B" ){
            
            document.getElementsByName("IN_SLIP_FLAG")[1].checked = true;
        }else {
            document.getElementsByName("IN_SLIP_FLAG")[0].checked = true;
        }
          
        document.getElementById("IN_SH_GBN").value = aft_ord_falg;
        document.getElementById("IN_SH_GBN_NM").value = "사전전표";
        
        document.getElementById("IN_PB_CD").value = pumbuncd;
        document.getElementById("IN_BALJUJC").value = "1";
        document.getElementById("ord_own_falg_nm").value = "EDI발주";
        document.getElementById("IN_BJDATE").value = getDateFormat(org_dt);
        if( ord_conf_dt != ""){
            document.getElementById("IN_BJHJDATE").value = getDateFormat(ord_conf_dt);
        }else {
            document.getElementById("IN_BJHJDATE").value = ord_conf_dt;
        }
        document.getElementById("HRS_CD").value = '<%=vencd%>';
        document.getElementById("HRS_NM").value = '<%=venNm%>';
        document.getElementById("IN_GS_GBN").value = tax_falg;
        document.getElementById("IN_GS_GBN_NM").value = tax_falg_nm;
        if( deli_dt != ""){
            document.getElementById("IN_NPYJDATE").value = getDateFormat(deli_dt);
        }else {
            document.getElementById("IN_NPYJDATE").value = deli_dt;
        }
        document.getElementById("IN_BUYER_CD").value = buyer_cd;
        document.getElementById("IN_BUYER_NM").value = buyerNm;
        if( mg_app_dt != ""){
            document.getElementById("IN_MAJINDATE").value = getDateFormat(mg_app_dt);
        }else {
            document.getElementById("IN_MAJINDATE").value = mg_app_dt;
        }
        if( chk_dt != ""){
            document.getElementById("IN_GPWJ_DATE").value = getDateFormat(chk_dt);
        }else {
            document.getElementById("IN_GPWJ_DATE").value = chk_dt; 
        }
        document.getElementById("IN_HS_GBN").length = 0;
        if( event_falg != "" ){
            
            var IN_HS_GBN = document.getElementById("IN_HS_GBN");
            var opt = document.createElement("option");  
            opt.setAttribute("value", event_falg);
            
            var text = document.createTextNode(event_falg);
            opt.appendChild(text); 
            IN_HS_GBN.appendChild(opt);
        }
        document.getElementById("IN_HS_RATE").length = 0;
        if( event_rate != "" ){
            var IN_HS_RATE = document.getElementById("IN_HS_RATE");
            var opt = document.createElement("option");  
            opt.setAttribute("value", event_rate);
            
            var text = document.createTextNode(event_rate);
            opt.appendChild(text); 
            IN_HS_RATE.appendChild(opt);
        }
        
        document.getElementById("IN_SRG").value = convAmt(ord_tot_qty);
        document.getElementById("IN_WGG").value = convAmt(new_cost_tamt);
        //document.getElementById("IN_VAT").value = convAmt(vatAmt);
        document.getElementById("IN_MGG").value = convAmt(new_sale_tamt);
        document.getElementById("IN_ETC").value = remark;                      //비고
        document.getElementById("IN_GAP_TOT_AMT").value = gam_tot_amt;         //차익액합
        document.getElementById("IN_NEW_GAP_RATE").value = new_gam_rate;       //차익율
        document.getElementById("IN_VAT_TAMT").value = vatAmt;                 //부가세  
        
        if( rowsNode.length > 0 ){
            getDetail2(strcd, slip_no);
            
            if( strSlip_procStat == "00" || strSlip_no == "" ){
                document.getElementById("IN_ETC").disabled = false;
                setTimeout("detailEditable(false);", 100);
                enableControl(IMG_ADD, true);
                enableControl(IMG_DEL, true);
            } else {
                document.getElementById("IN_ETC").disabled = true;
                setTimeout("detailEditable(true);", 100);
                enableControl(IMG_ADD, false);
                enableControl(IMG_DEL, false);
                
            }
            
        }
        
    </ajax:callback>
    
}
/**
 * detailEditable()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  디테일 활성화, 비활성화
 * return값 : void
 */ 
 
function detailEditable( Flag ){
     
    var d_no = document.getElementsByName("d_no");
    var d_check1 = document.getElementsByName("d_check1");
    var d_pmksrt_cd = document.getElementsByName("d_pmksrt_cd");
    var d_pummok_cd = document.getElementsByName("d_pummok_cd");
    var d_ord_qty = document.getElementsByName("d_ord_qty");
    var d_new_sale_prc = document.getElementsByName("d_new_sale_prc");
    var d_new_cost_prc = document.getElementsByName("d_new_cost_prc");
    
    if( !Flag ){           //flase 일 경우
        
        document.getElementById("check1").disabled = false;
       
        for( i = 0; i < d_no.length; i++ ){ 
            d_check1[i].disabled = false;
            d_ord_qty[i].disabled = false;
            d_new_sale_prc[i].disabled = false;
            d_new_cost_prc[i].disabled = false;
        }
        
    } else {               //true 일 경우
       
        document.getElementById("check1").disabled = true;
       
        for( i = 0; i < d_no.length; i++ ){
       
            document.getElementsByName("d_check1")[i].disabled = true;
            d_ord_qty[i].disabled = true;
            d_new_sale_prc[i].disabled = true;
            d_new_cost_prc[i].disabled = true;
            
        }
    }
} 
 
/**
 * getDetail()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  상세조회
 * return값 : void
 */ 
function getDetail(strcd , slip_no){
     var ven_cd = document.getElementById("HRS_CD").value;
     var param = "&goTo=getDetail&strcd="+strcd+"&slip_no="+slip_no;
     
     <ajax:open callback="on_getDetailXML" 
            param="param" 
            method="POST" 
            urlvalue="/edi/eord101.eo"/>
        
     <ajax:callback function="on_getDetailXML">
         
         var content = "<table width='860' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_detail'>";
         // alert("getDetail rowsNode.length : " + rowsNode.length);
         if( rowsNode.length > 0 ){ 
             for( i =0; i < rowsNode.length; i++ ){
                /* 
                0.체크 1.점코드 2.전표번호 3.전표상세번호 3-1.품목단축코드 4.품목코드 5.품목명 6.발주단위 7.마진율 8.전표구분 9.발주수량 10.신차익율 11.신차익액 12.신원가단가
                13.신원가금액 14.신매가단가 15.신매가금액 16.브랜드 코드 17.협력사코드 18.택구분 19.택구분명 20.택발행주체 21.택발행주체명
                 */
                var check1 = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                var strcd = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                var slip_no = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
                var ord_seq_no = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                var pmksrt_cd = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
                var pummok_cd = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
                var pummok_nm = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
                var ord_unit_cd = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
                var mg_rate = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
                var slip_flag = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
                var ord_qty = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
                var new_gap_rate = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
                var new_gap_amt = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
                var new_cost_prc = rowsNode[i].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[13].childNodes[0].nodeValue;
                var new_cost_amt = rowsNode[i].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[14].childNodes[0].nodeValue;
                var new_sale_prc = rowsNode[i].childNodes[15].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[15].childNodes[0].nodeValue;
                var new_sale_amt = rowsNode[i].childNodes[16].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[16].childNodes[0].nodeValue;
                var pumbuncd = rowsNode[i].childNodes[17].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[17].childNodes[0].nodeValue;
                var ven_cd = rowsNode[i].childNodes[18].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[18].childNodes[0].nodeValue;
                var tag_flag = rowsNode[i].childNodes[19].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[19].childNodes[0].nodeValue;
                var tag_flag_nm = rowsNode[i].childNodes[20].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[20].childNodes[0].nodeValue;
                var tag_prt_own_flag = rowsNode[i].childNodes[21].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[21].childNodes[0].nodeValue;
                var tag_prt_own_flag_nm = rowsNode[i].childNodes[22].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[22].childNodes[0].nodeValue;
                var vatAmt = rowsNode[i].childNodes[23].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[23].childNodes[0].nodeValue;
                var old_cost_prc = rowsNode[i].childNodes[24].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[24].childNodes[0].nodeValue;
                
                content += "<tr>";
                content += "<input type='hidden' name='RowStatus' id='RowStatus"+i+"' value='3' />";
                content += "<input type='hidden' name='d_strcd' id='d_strcd"+i+"' value='"+strcd+"' />";
                content += "<input type='hidden' name='d_slip_no' id='d_slip_no"+i+"' value='"+slip_no+"' />";
                content += "<input type='hidden' name='d_ord_seq_no' id='d_ord_seq_no"+i+"' value='"+ord_seq_no+"' />";
                content += "<input type='hidden' name='d_pumbuncd' id='d_pumbuncd"+i+"' value='"+pumbuncd+"' />";
                content += "<input type='hidden' name='d_new_gat_amt' id='d_new_gat_amt"+i+"' value='"+new_gap_amt+"' />";
                content += "<input type='hidden' name='d_vatAmt' id='d_vatAmt"+i+"' value='"+vatAmt+"' />";
                content += "<td class='r1' width='35'><input type='text' name='d_no' id='d_no"+i+"' value='"+(i+1)+"' size='4' style='text-align:center;' disabled='disabled' /></td>";
                content += "<td class='r1' width='25'><input type='checkbox' name='d_check1' id='d_check1"+i+"' value='"+(i+2)+"' /></td>";
                content += "<td class='r1' width='60'><input type='text' name='d_pmksrt_cd' id='d_pmksrt_cd"+i+"' value='"+pmksrt_cd+"' size ='5' style='text-align:center;' maxlength='4' disabled='disabled' /><input type='button' id='pmkSrtImg' name='pmkSrtImg' size='10' onclick='getPbnPmkSrtPop("+i+");' value='..' disabled='disabled'  /></td>";
                content += "<td class='r1' width='70'><input type='text' name='d_pummok_cd' id='d_pummok_cd"+i+"' value='"+pummok_cd+"' size ='8' style='text-align:center;' maxlength='8' disabled='disabled' /></td>"; // <input type='button' id='pummokImg' name='pummokImg' size='10' onclick='getPbnPmkPop("+i+");' value='..' disabled='disabled'  />
                content += "<td class='r1' width='90'><input type='text' name='d_pummok_nm' id='d_pummok_nm"+i+"' value='"+pummok_nm+"' size='12'  style='text-align:left;' maxlength='40' disabled='disabled'/></td>";
                content += "<td class='r1' width='45'><input type='text' name='d_ord_unit_cd' id='d_ord_unit_cd"+i+"' value='"+ord_unit_cd+"' size='5' style='text-align:right;' maxlength='3' disabled='disabled' /></td>";
                content += "<td class='r1' width='45'><input type='text' name='d_ord_qty' id='d_ord_qty"+i+"' value='"+ord_qty+"' size='5' onkeypress='javascript:onlyNumber();' style='text-align:right; IME-MODE: disabled;' maxlength='7' onkeydown=' if(event.keyCode == 13){ calDetail2("+i+"); }'  onblur='javascript:calDetail2("+i+");' /></td>";
                content += "<td class='r1' width='45'><input type='text' name='d_mg_rate' id='d_mg_rate"+i+"' value='"+mg_rate+"' size='4' style='text-align:right;' disabled='disabled' /></td>";
                content += "<td class='r1' width='85'><input type='text' name='d_new_cost_prc' id='d_new_cost_prc"+i+"' value='"+convAmt(new_cost_prc)+"' size='11' style='text-align:right;' maxlength='9' onkeydown=' if(event.keyCode == 13){ onCostPrcChg("+i+"); } ' onblur='javascript:onCostPrcChg("+i+");' /></td>"; // onblur='javascript:onCostPrcChg("+i+");' 
                content += "<td class='r1' width='85'><input type='text' name='d_new_cost_amt' id='d_new_cost_amt"+i+"' value='"+convAmt(new_cost_amt)+"' size='11' style='text-align:right;' maxlength='13' disabled='disabled' /></td>";
                content += "<td class='r1' width='85'><input type='text' name='d_new_sale_prc' id='d_new_sale_prc"+i+"' value='"+convAmt(new_sale_prc)+"' size='11' onkeypress='javascript:onlyNumber();' style='text-align:right;IME-MODE: disabled' maxlength='9' onkeydown=' if(event.keyCode == 13){ calDetail2("+i+"); }' onblur='javascript:calDetail2("+i+");' /></td>"; // onblur='javascript:calDetail2("+i+");'
                content += "<td class='r1' width='85'><input type='text' name='d_new_sale_amt' id='d_new_sale_amt"+i+"' value='"+convAmt(new_sale_amt)+"' size='11' style='text-align:right;' maxlength='13' disabled='disabled' /></td>";
                content += "<td class='r1' width='35'><input type='text' name='d_tag_flag' id='d_tag_flag"+i+"' value='"+tag_flag_nm+"' size='4' style='text-align:center;' maxlength='2' disabled='disabled' /></td>";
                content += "<td class='r1' width='55'><input type='text' name='d_tag_prt_own_flag' id='d_tag_prt_own_flag"+i+"' value='"+tag_prt_own_flag+"' size='7' style='text-align:left;' maxlength='40' disabled='disabled' /></td>";
                content += "<td class='r1' width='85'><input type='hidden' name='d_old_cost_prc' id='d_old_cost_prc"+i+"' value='"+convAmt(new_cost_prc)+"' size='11' style='text-align:right;' maxlength='9' disabled='disabled' /></td>";
                content += "</tr>";
                
             }
             content += "</table>";
             document.getElementById("DETAIL_CONTETN").innerHTML = content; 
             setPorcCount("SELECT", rowsNode.length);
         } 
         else {
	         content += "</table>";
	         document.getElementById("DETAIL_CONTETN").innerHTML = content; 
	         setPorcCount("SELECT", rowsNode.length);
        	 
         }
         detailRowCnt = rowsNode.length;
         getVenRound(strcd, vencd);
     </ajax:callback>
 }
 
/**
 * getDetail()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  상세조회
 * return값 : void
 */ 
function getDetail2(strcd , slip_no){
     var ven_cd = document.getElementById("HRS_CD").value;
    
     var param = "&goTo=getDetail&strcd="+strcd+"&slip_no="+slip_no;
     
  
     <ajax:open callback="on_getDetailXML" 
            param="param" 
            method="POST" 
            urlvalue="/edi/eord101.eo"/>

     <ajax:callback function="on_getDetailXML">
         
         var content = "<table width='860' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_detail'>";
         //alert("getDetail2 rowsNode.length : " + rowsNode.length);
         if( rowsNode.length > 0 ){
             
            
             for( i =0; i < rowsNode.length; i++ ){
                /* 
                0.체크 1.점코드 2.전표번호 3.전표상세번호 3-1.품목단축코드  4.품목코드 5.품목명 6.발주단위 7.마진율 8.전표구분 9.발주수량 10.신차익율 11.신차익액 12.신원가단가
                13.신원가금액 14.신매가단가 15.신매가금액 16.브랜드 코드 17.협력사코드 18.택구분 19.택구분명 20.택발행주체 21.택발행주체명
                 */
                
                var check1 = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                var strcd = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                var slip_no = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
                var ord_seq_no = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
                var pmksrt_cd = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
                var pummok_cd = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
                var pummok_nm = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
                var ord_unit_cd = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
                var mg_rate = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
                var slip_flag = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
                var ord_qty = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
                var new_gap_rate = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
                var new_gap_amt = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
                var new_cost_prc = rowsNode[i].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[13].childNodes[0].nodeValue;
                var new_cost_amt = rowsNode[i].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[14].childNodes[0].nodeValue;
                var new_sale_prc = rowsNode[i].childNodes[15].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[15].childNodes[0].nodeValue;
                var new_sale_amt = rowsNode[i].childNodes[16].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[16].childNodes[0].nodeValue;
                var pumbuncd = rowsNode[i].childNodes[17].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[17].childNodes[0].nodeValue;
                var ven_cd = rowsNode[i].childNodes[18].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[18].childNodes[0].nodeValue;
                var tag_flag = rowsNode[i].childNodes[19].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[19].childNodes[0].nodeValue;
                var tag_flag_nm = rowsNode[i].childNodes[20].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[20].childNodes[0].nodeValue;
                var tag_prt_own_flag = rowsNode[i].childNodes[21].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[21].childNodes[0].nodeValue;
                var tag_prt_own_flag_nm = rowsNode[i].childNodes[22].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[22].childNodes[0].nodeValue;
                var vatAmt = rowsNode[i].childNodes[23].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[23].childNodes[0].nodeValue;
                var old_cost_prc = rowsNode[i].childNodes[24].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[24].childNodes[0].nodeValue;
                
                content += "<tr>";
                content += "<input type='hidden' name='RowStatus' id='RowStatus"+i+"' value='3' />";
                content += "<input type='hidden' name='d_strcd' id='d_strcd"+i+"' value='"+strcd+"' />";
                content += "<input type='hidden' name='d_slip_no' id='d_slip_no"+i+"' value='"+slip_no+"' />";
                content += "<input type='hidden' name='d_ord_seq_no' id='d_ord_seq_no"+i+"' value='"+ord_seq_no+"' />";
                content += "<input type='hidden' name='d_pumbuncd' id='d_pumbuncd"+i+"' value='"+pumbuncd+"' />";
                content += "<input type='hidden' name='d_new_gat_amt' id='d_new_gat_amt"+i+"' value='"+new_gap_amt+"' />";
                content += "<input type='hidden' name='d_vatAmt' id='d_vatAmt"+i+"' value='"+vatAmt+"' />";
                content += "<td class='r1' width='35'><input type='text' name='d_no' id='d_no"+i+"' value='"+(i+1)+"' size='4' style='text-align:center;' disabled='disabled' /></td>";
                content += "<td class='r1' width='25'><input type='checkbox' name='d_check1' id='d_check1"+i+"' value='"+(i+2)+"' /></td>";
                content += "<td class='r1' width='60'><input type='text' name='d_pmksrt_cd' id='d_pmksrt_cd"+i+"' value='"+pmksrt_cd+"' size ='5' style='text-align:center;' maxlength='4' disabled='disabled' /><input type='button' id='pmkSrtImg' name='pmkSrtImg' size='10' onclick='getPbnPmkSrtPop("+i+");' value='..' disabled='disabled'  /></td>";
                content += "<td class='r1' width='70'><input type='text' name='d_pummok_cd' id='d_pummok_cd"+i+"' value='"+pummok_cd+"' size ='8' style='text-align:center;' maxlength='8' disabled='disabled' /></td>";  // <input type='button' id='pummokImg' name='pummokImg' size='10' onclick='getPbnPmkPop("+i+");' value='..' disabled='disabled'  />
                content += "<td class='r1' width='90'><input type='text' name='d_pummok_nm' id='d_pummok_nm"+i+"' value='"+pummok_nm+"' size='12'  style='text-align:left;' maxlength='40' disabled='disabled'/></td>";
                content += "<td class='r1' width='45'><input type='text' name='d_ord_unit_cd' id='d_ord_unit_cd"+i+"' value='"+ord_unit_cd+"' size='5' style='text-align:right;' maxlength='3' disabled='disabled' /></td>";
                content += "<td class='r1' width='45'><input type='text' name='d_ord_qty' id='d_ord_qty"+i+"' value='"+ord_qty+"' size='5' onkeypress='javascript:onlyNumber();' style='text-align:right; IME-MODE: disabled;' maxlength='7' onkeydown=' if(event.keyCode == 13){ calDetail2("+i+"); }' onblur='javascript:calDetail2("+i+");' /></td>"; // onblur='javascript:calDetail2("+i+");' 
                content += "<td class='r1' width='45'><input type='text' name='d_mg_rate' id='d_mg_rate"+i+"' value='"+mg_rate+"' size='4' style='text-align:right;' disabled='disabled' /></td>";
                content += "<td class='r1' width='85'><input type='text' name='d_new_cost_prc' id='d_new_cost_prc"+i+"' value='"+convAmt(new_cost_prc)+"' size='11' style='text-align:right;' maxlength='9'  onkeydown=' if(event.keyCode == 13){ onCostPrcChg("+i+"); }' onblur='javascript:onCostPrcChg("+i+");'/></td>"; // onblur='javascript:onCostPrcChg("+i+");' 
                content += "<td class='r1' width='85'><input type='text' name='d_new_cost_amt' id='d_new_cost_amt"+i+"' value='"+convAmt(new_cost_amt)+"' size='11' style='text-align:right;' maxlength='13' disabled='disabled' /></td>";
                content += "<td class='r1' width='85'><input type='text' name='d_new_sale_prc' id='d_new_sale_prc"+i+"' value='"+convAmt(new_sale_prc)+"' size='11' onkeypress='javascript:onlyNumber();' style='text-align:right;IME-MODE: disabled' maxlength='9'  onkeydown=' if(event.keyCode == 13){ calDetail2("+i+"); }' onblur='javascript:calDetail2("+i+");' /></td>"; // onblur='javascript:calDetail2("+i+");' 
                content += "<td class='r1' width='85'><input type='text' name='d_new_sale_amt' id='d_new_sale_amt"+i+"' value='"+convAmt(new_sale_amt)+"' size='11' style='text-align:right;' maxlength='13' disabled='disabled' /></td>";
                content += "<td class='r1' width='35'><input type='text' name='d_tag_flag' id='d_tag_flag"+i+"' value='"+tag_flag_nm+"' size='4' style='text-align:center;' maxlength='2' disabled='disabled' /></td>";
                content += "<td class='r1' width='55'><input type='text' name='d_tag_prt_own_flag' id='d_tag_prt_own_flag"+i+"' value='"+tag_prt_own_flag+"' size='7' style='text-align:left;' maxlength='40' disabled='disabled' /></td>";
                content += "<td class='r1' width='85'><input type='hidden' name='d_old_cost_prc' id='d_old_cost_prc"+i+"' value='"+convAmt(old_cost_prc)+"' size='11' style='text-align:right;' maxlength='9' disabled='disabled' /></td>";                
                content += "</tr>";
                
             }
             content += "</table>";
             document.getElementById("DETAIL_CONTETN").innerHTML = content; 
             setPorcCount("SELECT", rowsNode.length);
         } 
         detailRowCnt = rowsNode.length;
         getVenRound(strcd, vencd);
     </ajax:callback>
 }

/**
 * btn_save()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  저장
 * return값 : void
* 
*/
function btn_save(){
	sumQty = 0;
	var sumcost_amt = 0;
	var sumsale_amt = 0;
	var sumGapAmt = 0;
    var tb_detail = document.getElementById("tb_detail");
    var tr_cnt = tb_detail.rows.length; 

    //저장시점 전표진행상태
   // if(!chkSlipProdStat()) return ;     
    chkSlipProdStat();
    
    if(strPro.length != 0){
    	if(slip_proc_stat_save == 1){
            showMessage(INFORMATION, OK, "GAUCE-1000", "이미 확정된 발주전표 입니다. <br> 확정된 발주전표는 수정 할 수 없습니다.");    
            return false;
        } 
    } 
    
    if( tr_cnt < 1){
        showMessage(INFORMATION, OK, "GAUCE-1000", "상세데이터 등록후 저장하십시오.");
        return;
    }
    
    if(getByteValLength(document.getElementById("IN_ETC").value) > 100){
        showMessage(EXCLAMATION , OK, "USER-1020" , "비고", "100Byte");
        document.getElementById('IN_ETC').focus();
        //setFocusGrid(GD_DETAIL, DS_IO_DETAIL, i, "GIFT_AMT_NAME");
        return;
    }
    
    if(!checkValidation("Save"))  return;
   
   // alert(document.getElementById("IN_SRG").value);
    //디테일 품목코드 중복 체크
  //  for( j = 0; j < document.getElementsByName("d_pummok_cd").length; j++ ){
//        for( k = (j + 1 ); k <  document.getElementsByName("d_pummok_cd").length; k++ ){
  //          if( document.getElementsByName("d_pummok_cd")[j].value == document.getElementsByName("d_pummok_cd")[k].value ){
    //            showMessage(INFORMATION, OK, "GAUCE-1000", k + " 에 중복된 데이터가 있습니다.");
      //          document.getElementsByName("d_pummok_cd")[k].focus();
        //        return;
       //     }
  //      }
  //  }
    // 20120611 * DHL 수정 -->
    // for(var j = 0; j < document.getElementsByName("d_pummok_cd").length; j++ ) {
    for(var j = 0; j < document.getElementsByName("d_pmksrt_cd").length; j++ ) { 
    // 20120611 * DHL 수정 <--
    	var strCnt = 0; 
    	if(document.getElementsByName("d_new_sale_amt")[j].value == 0 ){
    		strCnt = strCnt + 1;
    	}
    	else { 
            strCnt=0;   
    	} 
    	
    	if(strCnt != 0){
            showMessage(INFORMATION, OK, "GAUCE-1000", "수량과 단가를 확인하세요"); 
            return;
    	} 
    	 
    }
    
            
    //마감 체크 하삼 ???setTimeout("LC_I_HS_RATE.Enable = false", 50);
                  
    //if( !closeCheck() ) alert("rerturn false"); return;
    
    //마감체크
    closeCheck();
}

function key_click(row) { 
	 if(event.keyCode == 13 || event.keyCode == 9){  
	        //document.getElementById("d_pummok_cd"+row).focus();
	        document.getElementById("d_pmksrt_cd"+row).focus();
	 } 
}

function SaveSlip_No(sv_strcd, strbjsate, sv_slip_flag){ 
	
    var param = "&goTo=slipno&sv_strcd="    + sv_strcd
                          + "&sv_bjdate="   + strbjsate
                          + "&sv_slip_flag=" + sv_slip_flag ;    
    
    var Urleren = "/edi/eord101.eo"; 
    URL = Urleren + "?" +param; 
    strMst = getXMLHttpRequest(); 
    strMst.onreadystatechange = responseSlipno;
    strMst.open("POST", URL, true); 
    strMst.send(null);

 //   alert(strMst.length);
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
	    try {
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
 * responseSlipno()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  마스터 조회 시 조회 그리드에 데이터 넣기
 * return값 : void
 */ 
function responseSlipno()
{
     if(strMst.readyState==4)
     {
          if(strMst.status == 200)
          {
              strMst = eval(strMst.responseText); 
              
              if(strMst.length != 0){ 
                  for(i=0; i<strMst.length; i++) { 
                      strSlip_no_new = strMst[i].SLIP_NO;  
                      if( new_row == "3" ){      //전표 신규 등록 
                          Save_new(strSlip_no_new);
                      }
                      else { 
                          save_update();
                      } 
                  }    
              }
          } 
     }
}

/*
function on_slipnoXML(oj) {
    var xmlDoc = oj.responseXML;
    var rows = 0;
    var cols = 0;
    var tableNode = xmlDoc.getElementsByTagName('t'); //root node
    var rowsNode = xmlDoc.getElementsByTagName('r');  //sub node
    var colsNode = xmlDoc.getElementsByTagName('c');  //last node
 
    rows = rowsNode.length; //the number of rows
    cols = colsNode.length/rows //the number of cols
 
    var xml = xmlDoc.xml;

    if( rowsNode.length > 0 ){
    
        var strSlipNo = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
    } 
}
*/

/**
 * btn_save2()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  마감체크 후 화면 데이터 저장
 * return값 : void
* 
*/
function btn_save2(){
    
    var tb_detail   = document.getElementById("tb_detail");
    // var tr_cnt = tb_detail.rows.length;
    var tr_cnt      = document.getElementsByName("d_strcd").length;
    var tb_lsit     = document.getElementById("tb_list");
    var list_cnt    = tb_lsit.rows.length; 
    var sv_dtl_cnt  = tr_cnt; // 명세건수
    var d_sv_cnt    = 0; 
    
    var d_sv_rowStatus          = "";
    var d_sv_strcd              = "";
    var d_sv_slip_no            = "";
    var d_sv_ord_seqno          = "";
    var d_sv_no                 = "";
    var d_sv_pmksrt_cd          = "";
    var d_sv_pummok_cd          = "";
    var d_sv_ord_unit_cd        = "";
    var d_sv_ord_qty            = "";
    var d_sv_mg_rate            = "";
    var d_sv_new_cost_prc       = "";
    var d_sv_new_cost_amt       = "";
    var d_sv_new_sale_prc       = "";
    var d_sv_new_sale_amt       = "";
    var d_sv_tag_flag           = "";
    var d_sv_tag_prt_own_flag   = "";
    var d_sv_new_gat_amt        = "";
    var d_sv_vat_amt            = "";
    //var d_sv_old_cost_prc       = "";
    
    var by_d_sv_rowStatus       = document.getElementsByName("RowStatus");
    var by_d_sv_strcd           = document.getElementsByName("d_strcd");
    var by_d_sv_slip_no         = document.getElementsByName("d_slip_no");
    var by_d_sv_ord_seqno       = document.getElementsByName("d_ord_seq_no");
    var by_d_sv_no              = document.getElementsByName("d_no");
    var by_d_sv_pmksrt_cd       = document.getElementsByName("d_pmksrt_cd");
    var by_d_sv_pummok_cd       = document.getElementsByName("d_pummok_cd");
    var by_d_sv_ord_unit_cd     = document.getElementsByName("d_ord_unit_cd");
    var by_d_sv_ord_qty         = document.getElementsByName("d_ord_qty");
    var by_d_sv_mg_rate         = document.getElementsByName("d_mg_rate");
    var by_d_sv_new_cost_prc    = document.getElementsByName("d_new_cost_prc");
    var by_d_sv_new_cost_amt    = document.getElementsByName("d_new_cost_amt");
    var by_d_sv_new_sale_prc    = document.getElementsByName("d_new_sale_prc");
    var by_d_sv_new_sale_amt    = document.getElementsByName("d_new_sale_amt");
    var by_d_sv_tag_flag        = document.getElementsByName("d_tag_flag");
    var by_d_tag_prt_own_flag   = document.getElementsByName("d_tag_prt_own_flag");
    var by_d_new_gat_amt        = document.getElementsByName("d_new_gat_amt");
    var by_d_vat_amt            = document.getElementsByName("d_vatAmt");
    //var by_d_sv_old_cost_prc    = document.getElementsByName("d_old_cost_prc");
    var param = "";    

    
    if( showMessage(QUESTION, YESNO, "GAUCE-1000", "저장하시겠습니까?") != 1){
        return;
    } 

    var sv_strcd = '<%=strcd%>';
    var strbjsate = document.getElementById("IN_BJDATE").value;
    var sv_slip_flag = "";
    
    for(i = 0; i < document.getElementsByName("IN_SLIP_FLAG").length; i++){
        if( document.getElementsByName("IN_SLIP_FLAG")[i].checked == true ){
            sv_slip_flag = document.getElementsByName("IN_SLIP_FLAG")[i].value;
        }
    }

    // alert(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> strSlip_no_new (1) : " + strSlip_no_new);
    
    if( new_row == "3" ){      //전표 신규 등록 
    	strSlip_no_new = "";
    // alert(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> strSlip_no_new (2) : " + strSlip_no_new);
    	SaveSlip_No(sv_strcd, strbjsate, sv_slip_flag);
    }
    else {
    	update_slipno = ""; 
        save_update();
    } 
    
    
     
}
 
 function Save_new(strSlip_no_new) {

	    var sv_strcd = '<%=strcd%>';
        var tb_detail   = document.getElementById("tb_detail");
        //var tr_cnt = tb_detail.rows.length;
        var tr_cnt      = document.getElementsByName("d_strcd").length;
        var tb_lsit     = document.getElementById("tb_list");
        var list_cnt    = tb_lsit.rows.length; 
        var sv_dtl_cnt  = tr_cnt;//명세건수
        var d_sv_cnt    = 0; 
        
        var d_sv_rowStatus          = "";
        var d_sv_strcd              = "";
        var d_sv_slip_no            = "";
        var d_sv_ord_seqno          = "";
        var d_sv_no                 = "";
        var d_sv_pmksrt_cd          = "";
        var d_sv_pummok_cd          = "";
        var d_sv_ord_unit_cd        = "";
        var d_sv_ord_qty            = "";
        var d_sv_mg_rate            = "";
        var d_sv_new_cost_prc       = "";
        var d_sv_new_cost_amt       = "";
        var d_sv_new_sale_prc       = "";
        var d_sv_new_sale_amt       = "";
        var d_sv_tag_flag           = "";
        var d_sv_tag_prt_own_flag   = "";
        var d_sv_new_gat_amt        = "";
        var d_sv_vat_amt            = "";
        //var d_sv_old_cost_prc       = "";
        
        var by_d_sv_rowStatus       = document.getElementsByName("RowStatus");
        var by_d_sv_strcd           = document.getElementsByName("d_strcd");
        var by_d_sv_slip_no         = document.getElementsByName("d_slip_no");
        var by_d_sv_ord_seqno       = document.getElementsByName("d_ord_seq_no");
        var by_d_sv_no              = document.getElementsByName("d_no");
        var by_d_sv_pmksrt_cd       = document.getElementsByName("d_pmksrt_cd");
        var by_d_sv_pummok_cd       = document.getElementsByName("d_pummok_cd");
        var by_d_sv_ord_unit_cd     = document.getElementsByName("d_ord_unit_cd");
        var by_d_sv_ord_qty         = document.getElementsByName("d_ord_qty");
        var by_d_sv_mg_rate         = document.getElementsByName("d_mg_rate");
        var by_d_sv_new_cost_prc    = document.getElementsByName("d_new_cost_prc");
        var by_d_sv_new_cost_amt    = document.getElementsByName("d_new_cost_amt");
        var by_d_sv_new_sale_prc    = document.getElementsByName("d_new_sale_prc");
        var by_d_sv_new_sale_amt    = document.getElementsByName("d_new_sale_amt");
        var by_d_sv_tag_flag        = document.getElementsByName("d_tag_flag");
        var by_d_tag_prt_own_flag   = document.getElementsByName("d_tag_prt_own_flag");
        var by_d_new_gat_amt        = document.getElementsByName("d_new_gat_amt");
        var by_d_vat_amt            = document.getElementsByName("d_vatAmt");
        //var by_d_sv_old_cost_prc    = document.getElementsByName("d_old_cost_prc");
        
        var param = "";    
            
        var sv_slip_no = "";
        var sv_slip_flag = "";
         
        // alert(strSlip_no_new);
         
        for(i = 0; i < document.getElementsByName("IN_SLIP_FLAG").length; i++){
            if( document.getElementsByName("IN_SLIP_FLAG")[i].checked == true ){
                sv_slip_flag = document.getElementsByName("IN_SLIP_FLAG")[i].value;
            }
        }
 
        if( tr_cnt > 0){ 
             for( i = 0; i < by_d_sv_strcd.length; i++ ){
            	 
                 if( d_sv_cnt == 0 ){ 
                     d_sv_rowStatus         = by_d_sv_rowStatus[i].value;
                     d_sv_strcd             = by_d_sv_strcd[i].value;
                     d_sv_slip_no           = by_d_sv_slip_no[i].value;
                     d_sv_ord_seqno         = by_d_sv_ord_seqno[i].value;
                     
                     d_sv_no                = by_d_sv_no[i].value;
                     d_sv_pummok_cd         = by_d_sv_pummok_cd[i].value;
                     d_sv_pmksrt_cd         = by_d_sv_pmksrt_cd[i].value;
                     d_sv_ord_unit_cd       = by_d_sv_ord_unit_cd[i].value;
                     d_sv_ord_qty           = by_d_sv_ord_qty[i].value;
                     d_sv_mg_rate           = by_d_sv_mg_rate[i].value;
                     d_sv_new_cost_prc      = by_d_sv_new_cost_prc[i].value;
                     d_sv_new_cost_amt      = by_d_sv_new_cost_amt[i].value;
                     d_sv_new_sale_prc      = by_d_sv_new_sale_prc[i].value;
                     d_sv_new_sale_amt      = by_d_sv_new_sale_amt[i].value;
                     d_sv_tag_flag          = by_d_sv_tag_flag[i].value;   
                     d_sv_tag_prt_own_flag  = by_d_tag_prt_own_flag[i].value;
                     d_sv_new_gat_amt       = by_d_new_gat_amt[i].value;
                     d_sv_vat_amt           = by_d_vat_amt[i].value;
                     //d_sv_old_cost_prc      = by_d_sv_old_cost_prc[i].value;
                 }else {
                    
                     d_sv_rowStatus         = d_sv_rowStatus + "/" + by_d_sv_rowStatus[i].value;
                     d_sv_strcd             = d_sv_strcd + "/" + by_d_sv_strcd[i].value;
                     d_sv_slip_no           = d_sv_slip_no + "/" + by_d_sv_slip_no[i].value;
                     d_sv_ord_seqno         = d_sv_ord_seqno + "/" + by_d_sv_ord_seqno[i].value;
                     
                     d_sv_no                = d_sv_no + "/" + by_d_sv_no[i].value;
                     d_sv_pmksrt_cd         = d_sv_pmksrt_cd + "/" + by_d_sv_pmksrt_cd[i].value;
                     d_sv_pummok_cd         = d_sv_pummok_cd + "/" + by_d_sv_pummok_cd[i].value;
                     d_sv_ord_unit_cd       = d_sv_ord_unit_cd + "/" + by_d_sv_ord_unit_cd[i].value;
                     d_sv_ord_qty           = d_sv_ord_qty + "/" + by_d_sv_ord_qty[i].value;
                     d_sv_mg_rate           = d_sv_mg_rate + "/" + by_d_sv_mg_rate[i].value;
                     d_sv_new_cost_prc      = d_sv_new_cost_prc + "/" + by_d_sv_new_cost_prc[i].value;
                     d_sv_new_cost_amt      = d_sv_new_cost_amt + "/" + by_d_sv_new_cost_amt[i].value;
                     d_sv_new_sale_prc      = d_sv_new_sale_prc + "/" + by_d_sv_new_sale_prc[i].value;
                     d_sv_new_sale_amt      = d_sv_new_sale_amt + "/" + by_d_sv_new_sale_amt[i].value;
                     d_sv_tag_flag          = d_sv_tag_flag + "/" + by_d_sv_tag_flag[i].value;  
                     d_sv_tag_prt_own_flag  = d_sv_tag_prt_own_flag + "/" + by_d_tag_prt_own_flag[i].value;
                     d_sv_new_gat_amt       = d_sv_new_gat_amt + "/" + by_d_new_gat_amt[i].value;
                     d_sv_vat_amt           = d_sv_vat_amt + "/" + by_d_vat_amt[i].value;
                     //d_sv_old_cost_prc      = d_sv_old_cost_prc + "/" + by_d_sv_old_cost_prc[i].value;
                 } 
                 d_sv_cnt++;
             }
        } 
        
        param = "&goTo=save&m_rowStatus=3" + "&sv_strcd="               + sv_strcd
        + "&sv_slip_no="            + strSlip_no_new
        + "&sv_slip_flag="          + sv_slip_flag
        + "&sv_sh_gbn="             + document.getElementById("IN_SH_GBN").value
        + "&sv_pb_cd="              + document.getElementById("IN_PB_CD").value
        + "&sv_baljujc="            + document.getElementById("IN_BALJUJC").value
        + "&sv_bjdate="             + document.getElementById("IN_BJDATE").value
        + "&sv_bjhjdate="           + document.getElementById("IN_BJHJDATE").value
        + "&sv_hrs_cd="             + document.getElementById("HRS_CD").value
        + "&gs_gbn="                + document.getElementById("IN_GS_GBN").value
        + "&sv_npyjdate="           + document.getElementById("IN_NPYJDATE").value
        + "&buyercd="               + document.getElementById("IN_BUYER_CD").value
        + "&majindate="             + document.getElementById("IN_MAJINDATE").value
        + "&sv_hs_gbn="             + document.getElementById("IN_HS_GBN").value
        + "&sv_hs_rate="            + document.getElementById("IN_HS_RATE").value
        + "&sv_gpwjDate="           + document.getElementById("IN_GPWJ_DATE").value
        + "&sv_spg="                + document.getElementById("IN_SRG").value
        + "&sv_wgg="                + document.getElementById("IN_WGG").value
        + "&sv_mgg="                + document.getElementById("IN_MGG").value
        + "&sv_etc="                + document.getElementById("IN_ETC").value
        + "&norm_mg_rate="          + norm_mg_rate                                      //행사마진율
        + "&sv_gap_tot_amt="        + document.getElementById("IN_GAP_TOT_AMT").value   //차익액합
        + "&sv_new_gap_rate="       + document.getElementById("IN_NEW_GAP_RATE").value  //차익율
        + "&sv_vat_tamt="           + document.getElementById("IN_VAT_TAMT").value      //부가세
        + "&sv_biz_type="           + document.getElementById("IN_BIZ_TYPE").value      //biz_type
        + "&sv_dtl_cnt="            + tr_cnt                                            //명세건수
        + "&d_sv_rowStatus="        + d_sv_rowStatus
        + "&d_sv_strcd="            + d_sv_strcd
        + "&d_sv_slip_no="          + d_sv_slip_no
        + "&d_sv_ord_seqno="        + d_sv_ord_seqno
        + "&d_sv_no="               + d_sv_no
        + "&d_sv_pmksrt_cd="        + d_sv_pmksrt_cd
        + "&d_sv_pummok_cd="        + d_sv_pummok_cd
        + "&d_sv_ord_unit_cd="      + d_sv_ord_unit_cd
        + "&d_sv_ord_qty="          + d_sv_ord_qty
        + "&d_sv_mg_rate="          + d_sv_mg_rate
        + "&d_sv_new_cost_prc="     + d_sv_new_cost_prc
        + "&d_sv_new_cost_amt="     + d_sv_new_cost_amt
        + "&d_sv_new_sale_prc="     + d_sv_new_sale_prc
        + "&d_sv_new_sale_amt="     + d_sv_new_sale_amt
        + "&d_sv_tag_flag="         + d_sv_tag_flag
        + "&d_sv_tag_prt_own_flag=" + d_sv_tag_prt_own_flag
        + "&d_sv_new_gat_amt="      + d_sv_new_gat_amt
        + "&d_sv_vat_amt="          + d_sv_vat_amt;
        
        <ajax:open callback="on_saveXML" 
            param="param" 
            method="POST" 
            urlvalue="/edi/eord101.eo"/>
        
       <ajax:callback function="on_saveXML">
          
          if( rowsNode.length > 0 ){
              ret = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
              if( ret > 0 ){
                  new_row = "1";
                  showMessage(INFORMATION, OK, "GAUCE-1000", "정상적으로 저장되었습니다.");
                  getSearch("3");
                  // alert("new_slipno : " + strSlip_no_new);  
                  // ch_new(strSlip_no_new);
                  return;
              }else {
                  showMessage(INFORMATION, OK, "GAUCE-1000", ret);
              }  
          } else {
              return;
          }
           
       </ajax:callback>
         
 }
 
 function save_update() {      
	
	var sv_strcd = '<%=strcd%>';
    var tb_detail   = document.getElementById("tb_detail");
    // var tr_cnt = tb_detail.rows.length;
    var tr_cnt      = document.getElementsByName("d_strcd").length;
    var tb_lsit     = document.getElementById("tb_list");
    var list_cnt    = tb_lsit.rows.length; 
    var sv_dtl_cnt  = tr_cnt;//명세건수
    var d_sv_cnt    = 0; 
    
    var d_sv_rowStatus          = "";
    var d_sv_strcd              = "";
    var d_sv_slip_no            = "";
    var d_sv_ord_seqno          = "";
    var d_sv_no                 = "";
    var d_sv_pmksrt_cd          = "";
    var d_sv_pummok_cd          = "";
    var d_sv_ord_unit_cd        = "";
    var d_sv_ord_qty            = "";
    var d_sv_mg_rate            = "";
    var d_sv_new_cost_prc       = "";
    var d_sv_new_cost_amt       = "";
    var d_sv_new_sale_prc       = "";
    var d_sv_new_sale_amt       = "";
    var d_sv_tag_flag           = "";
    var d_sv_tag_prt_own_flag   = "";
    var d_sv_new_gat_amt        = "";
    var d_sv_vat_amt            = "";
    //var d_sv_old_cost_prc       = "";
    
    var by_d_sv_rowStatus       = document.getElementsByName("RowStatus");
    var by_d_sv_strcd           = document.getElementsByName("d_strcd");
    var by_d_sv_slip_no         = document.getElementsByName("d_slip_no"); 
    var by_d_sv_ord_seqno       = document.getElementsByName("d_ord_seq_no");
    var by_d_sv_no              = document.getElementsByName("d_no");
    var by_d_sv_pummok_cd       = document.getElementsByName("d_pummok_cd");
    var by_d_sv_pmksrt_cd       = document.getElementsByName("d_pmksrt_cd");
    var by_d_sv_ord_unit_cd     = document.getElementsByName("d_ord_unit_cd");
    var by_d_sv_ord_qty         = document.getElementsByName("d_ord_qty");
    var by_d_sv_mg_rate         = document.getElementsByName("d_mg_rate");
    var by_d_sv_new_cost_prc    = document.getElementsByName("d_new_cost_prc");
    var by_d_sv_new_cost_amt    = document.getElementsByName("d_new_cost_amt");
    var by_d_sv_new_sale_prc    = document.getElementsByName("d_new_sale_prc");
    var by_d_sv_new_sale_amt    = document.getElementsByName("d_new_sale_amt");
    var by_d_sv_tag_flag        = document.getElementsByName("d_tag_flag");
    var by_d_tag_prt_own_flag   = document.getElementsByName("d_tag_prt_own_flag");
    var by_d_new_gat_amt        = document.getElementsByName("d_new_gat_amt");
    var by_d_vat_amt            = document.getElementsByName("d_vatAmt");
    //var by_d_sv_old_cost_prc    = document.getElementsByName("d_old_cost_prc");
    
    var param = "";    
        
    var sv_slip_no = "";
    var sv_slip_flag = "";
    
     for(i = 0; i < document.getElementsByName("IN_SLIP_FLAG").length; i++){
         if( document.getElementsByName("IN_SLIP_FLAG")[i].checked == true ){
             sv_slip_flag = document.getElementsByName("IN_SLIP_FLAG")[i].value;
         }
     }
     
     if( tr_cnt > 0){
          for( i = 0; i < tr_cnt; i++ ){
              if( d_sv_cnt == 0 ){
                  d_sv_rowStatus         = by_d_sv_rowStatus[i].value;
                  d_sv_strcd             = by_d_sv_strcd[i].value;
                  d_sv_slip_no           = by_d_sv_slip_no[i].value;
                  d_sv_ord_seqno         = by_d_sv_ord_seqno[i].value;

                  d_sv_no                = by_d_sv_no[i].value;
                  d_sv_pmksrt_cd         = by_d_sv_pmksrt_cd[i].value;
                  d_sv_pummok_cd         = by_d_sv_pummok_cd[i].value;
                  d_sv_ord_unit_cd       = by_d_sv_ord_unit_cd[i].value;
                  d_sv_ord_qty           = by_d_sv_ord_qty[i].value;
                  d_sv_mg_rate           = by_d_sv_mg_rate[i].value;
                  d_sv_new_cost_prc      = by_d_sv_new_cost_prc[i].value;
                  d_sv_new_cost_amt      = by_d_sv_new_cost_amt[i].value;
                  d_sv_new_sale_prc      = by_d_sv_new_sale_prc[i].value;
                  d_sv_new_sale_amt      = by_d_sv_new_sale_amt[i].value;
                  d_sv_tag_flag          = by_d_sv_tag_flag[i].value;   
                  d_sv_tag_prt_own_flag  =  by_d_tag_prt_own_flag[i].value;
                  d_sv_new_gat_amt       =  by_d_new_gat_amt[i].value;
                  d_sv_vat_amt           =  by_d_vat_amt[i].value;
                  //d_sv_old_cost_prc      = by_d_sv_old_cost_prc[i].value;
              } else {
                  d_sv_rowStatus         = d_sv_rowStatus + "/" + by_d_sv_rowStatus[i].value;
                  d_sv_strcd             = d_sv_strcd + "/" + by_d_sv_strcd[i].value;
                  d_sv_slip_no           = d_sv_slip_no + "/" + by_d_sv_slip_no[i].value;
                  d_sv_ord_seqno         = d_sv_ord_seqno + "/" + by_d_sv_ord_seqno[i].value;

                  d_sv_no                = d_sv_no + "/" + by_d_sv_no[i].value;
                  d_sv_pmksrt_cd         = d_sv_pmksrt_cd + "/" + by_d_sv_pmksrt_cd[i].value;
                  d_sv_pummok_cd         = d_sv_pummok_cd + "/" + by_d_sv_pummok_cd[i].value;
                  d_sv_ord_unit_cd       = d_sv_ord_unit_cd + "/" + by_d_sv_ord_unit_cd[i].value;
                  d_sv_ord_qty           = d_sv_ord_qty + "/" + by_d_sv_ord_qty[i].value;
                  d_sv_mg_rate           = d_sv_mg_rate + "/" + by_d_sv_mg_rate[i].value;
                  d_sv_new_cost_prc      = d_sv_new_cost_prc + "/" + by_d_sv_new_cost_prc[i].value;
                  d_sv_new_cost_amt      = d_sv_new_cost_amt + "/" + by_d_sv_new_cost_amt[i].value;
                  d_sv_new_sale_prc      = d_sv_new_sale_prc + "/" + by_d_sv_new_sale_prc[i].value;
                  d_sv_new_sale_amt      = d_sv_new_sale_amt + "/" + by_d_sv_new_sale_amt[i].value;
                  d_sv_tag_flag          = d_sv_tag_flag + "/" + by_d_sv_tag_flag[i].value;  
                  d_sv_tag_prt_own_flag  = d_sv_tag_prt_own_flag + "/" + by_d_tag_prt_own_flag[i].value;
                  d_sv_new_gat_amt       = d_sv_new_gat_amt + "/" + by_d_new_gat_amt[i].value;
                  d_sv_vat_amt           = d_sv_vat_amt + "/" + by_d_vat_amt[i].value;
                  //d_sv_old_cost_prc      = d_sv_old_cost_prc + "/" + by_d_sv_old_cost_prc[i].value;
              } 
              d_sv_cnt++;
          }
          
     }  
    
     update_slipno = by_d_sv_slip_no[0].value;
    
     param = "&goTo=save&m_rowStatus=1" + "&sv_strcd="                + sv_strcd
                                        + "&sv_slip_no="              + update_slipno
                                        + "&sv_slip_flag="            + sv_slip_flag
                                        + "&sv_sh_gbn="               + document.getElementById("IN_SH_GBN").value
                                        + "&sv_pb_cd="                + document.getElementById("IN_PB_CD").value
                                        + "&sv_baljujc="              + document.getElementById("IN_BALJUJC").value
                                        + "&sv_bjdate="               + document.getElementById("IN_BJDATE").value
                                        + "&sv_bjhjdate="             + document.getElementById("IN_BJHJDATE").value
                                        + "&sv_hrs_cd="               + document.getElementById("HRS_CD").value
                                        + "&gs_gbn="                  + document.getElementById("IN_GS_GBN").value
                                        + "&sv_npyjdate="             + document.getElementById("IN_NPYJDATE").value
                                        + "&buyercd="                 + document.getElementById("IN_BUYER_CD").value
                                        + "&majindate="               + document.getElementById("IN_MAJINDATE").value
                                        + "&sv_hs_gbn="               + document.getElementById("IN_HS_GBN").value
                                        + "&sv_hs_rate="              + document.getElementById("IN_HS_RATE").value
                                        + "&sv_gpwjDate="             + document.getElementById("IN_GPWJ_DATE").value
                                        + "&sv_spg="                  + document.getElementById("IN_SRG").value
                                        + "&sv_wgg="                  + document.getElementById("IN_WGG").value
                                        + "&sv_mgg="                  + document.getElementById("IN_MGG").value
                                        + "&sv_etc="                  + document.getElementById("IN_ETC").value
                                        + "&norm_mg_rate="            + norm_mg_rate                                      //행사마진율
                                        + "&sv_gap_tot_amt="          + document.getElementById("IN_GAP_TOT_AMT").value   //차익액합
                                        + "&sv_new_gap_rate="         + document.getElementById("IN_NEW_GAP_RATE").value  //차익율
                                        + "&sv_vat_tamt="             + document.getElementById("IN_VAT_TAMT").value      //부가세
                                        + "&sv_biz_type="             + document.getElementById("IN_BIZ_TYPE").value      //biz_type
                                        + "&sv_dtl_cnt="              + tr_cnt                                            //명세건수
                                        + "&d_sv_rowStatus="          + d_sv_rowStatus
                                        + "&d_sv_strcd="              + d_sv_strcd
                                        + "&d_sv_slip_no="            + update_slipno
                                        + "&d_sv_ord_seqno="          + d_sv_ord_seqno
                                        + "&d_sv_no="                 + d_sv_no
                                        + "&d_sv_pmksrt_cd="          + d_sv_pmksrt_cd
                                        + "&d_sv_pummok_cd="          + d_sv_pummok_cd
                                        + "&d_sv_ord_unit_cd="        + d_sv_ord_unit_cd
                                        + "&d_sv_ord_qty="            + d_sv_ord_qty
                                        + "&d_sv_mg_rate="            + d_sv_mg_rate
                                        + "&d_sv_new_cost_prc="       + d_sv_new_cost_prc
                                        + "&d_sv_new_cost_amt="       + d_sv_new_cost_amt
                                        + "&d_sv_new_sale_prc="       + d_sv_new_sale_prc
                                        + "&d_sv_new_sale_amt="       + d_sv_new_sale_amt
                                        + "&d_sv_tag_flag="           + d_sv_tag_flag
                                        + "&d_sv_tag_prt_own_flag="   + d_sv_tag_prt_own_flag
                                        + "&d_sv_new_gat_amt="        + d_sv_new_gat_amt
                                        + "&d_sv_vat_amt="            + d_sv_vat_amt;
     
     
     <ajax:open callback="on_saveXML" 
         param="param" 
         method="POST" 
         urlvalue="/edi/eord101.eo"/>
     
    <ajax:callback function="on_saveXML">
       
       if( rowsNode.length > 0 ){
           ret = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
           if( ret > 0 ){
               new_row = "1";
               showMessage(INFORMATION, OK, "GAUCE-1000", "정상적으로 저장되었습니다.");
               getSearch("1");
           //    ch_update(update_slipno);
               return;
           }else {
               showMessage(INFORMATION, OK, "GAUCE-1000", ret);
           }  
       } else {
           return;
       }
       
    
    </ajax:callback>
     
 }
 
 /**
  * ch_new()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  마스터 로우 선택시  색
  * return값 : void
  */ 
 function ch_new(strSlip_no_new) { 
	  if(strSlip_no_new == "") {  
	  //  getMaster2(0); 
	  //  chBak(0);
		  var strCount = document.getElementsByName("strcd").length - 1;
          //  alert("COUNT : " + strCount);
            for(var i=0;i<strCount;i++) {
          //    alert(i); 
               //     alert(strSlip + "::" + strSlip_no_new); 
                    for(var j=1;j<6;j++) { 
                 //       alert(i + " :: " + j); 
                     document.getElementById(j+"listtdId"+i).style.backgroundColor="#fff56E";   
                        g_pre_row = i;
                    }
                    getMaster2(i);
                    //alert(i);
                    break; 
            } 
            strSlip_no_new = "";
            
	  }
	  else {
		  var strCount = document.getElementsByName("strcd").length - 1;
	       //  alert("COUNT : " + strCount);
	         for(var i=0;i<strCount;i++) {
	       // 	 alert(i);
	             var strSlip = document.getElementById("slip_no"+i).value;  
	             if(strSlip == strSlip_no_new) {
	            //     alert(strSlip + "::" + strSlip_no_new); 
	                 for(var j=1;j<6;j++) { 
	              //       alert(i + " :: " + j); 
	                  document.getElementById(j+"listtdId"+i).style.backgroundColor="#fff56E";   
	                     g_pre_row = i;
	                 }
	                 getMaster2(i);
	                 //alert(i);
	                 break;
	             }
	             else {

	              //   alert("else : " + strSlip + "::" + update_slipno); 
	            // return;
	                 
	             }  
	         } 
	         strSlip_no_new = "";
	  } 
 }
 
 /**
  * ch_new()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  마스터 로우 선택시  색
  * return값 : void
  */ 
 function ch_update(update_slipno) { 
      if(update_slipno == "") { 
        chBak(0);
        getMaster2(0); 
      }
      else {
          var strCount = document.getElementsByName("strcd").length - 1;
            // alert("COUNT : " + strCount);
             
             for(var i=0;i<strCount;i++) {   
                 var strSlip = document.getElementById("slip_no"+i).value;  
                 
                 if(strSlip == update_slipno) {
               //      alert(strSlip + "::" + update_slipno); 
                     for(var j=1;j<6;j++) { 
                    //     alert(i + " :: " + j); 
                      document.getElementById(j+"listtdId"+i).style.backgroundColor="#fff56E";   
                     }
                     getMaster2(i);
                     return;
                 }
                 else { 
//                     alert("else : " + strSlip + "::" + update_slipno); 
                // return;
                     
                 }  
             }  
             update_slipno = "";
      } 
 }
 
/**
 * btn_delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  삭제
 * return값 : void
* 
*/ 
function btn_delete(){
	// alert(slip_falg);
    var tb_list = document.getElementById("tb_list");
    var tr_cnt = tb_list.rows.length;
    var strStrcd = document.getElementById("IN_STR_CD").value;
    var strSlipNo = document.getElementById("IN_SLIP_NO").value;
    
    if( tr_cnt < 1 || document.getElementById("IN_SLIP_NO").value == "" ){
        showMessage(StopSign, OK, "USER-1019");
        return;
    }
    
    if(!checkValidation("Delete"))  return;
    
    var param = "&goTo=slip_flag&strcd=" + strStrcd + "&slip_no=" + strSlipNo;

    <ajax:open callback="on_slip_flagXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/eord101.eo"/>
    
    <ajax:callback function="on_slip_flagXML">
     SLIP_PROC_STAT = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
     
    // alert(SLIP_PROC_STAT);
     if(SLIP_PROC_STAT != "00") {
         showMessage(Information, Ok, "GAUCE-1000", "해당전표는 삭제 할 수 없습니다.");
         return;
     }
     
     if( showMessage(QUESTION, YESNO, "GAUCE-1000", "선택한 항목을 삭제하겠습니까?") != 1){
         return;
     }
     var param = "&goTo=delete&strcd=" + strStrcd + "&slip_no=" + strSlipNo;
     
     <ajax:open callback="on_DeleteXML" 
         param="param" 
         method="POST" 
         urlvalue="/edi/eord101.eo"/>
     
     <ajax:callback function="on_DeleteXML">
     
     ret = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
     if( ret > 0 ){
         showMessage(INFORMATION, OK, "GAUCE-1000", ret + " 건 정상적으로 삭제되었습니다.");
         strSlip_no_new = ""; 
         update_slipno = "";
        // new_row = "4";
         getSearch("");  
         return;
     }else {
         showMessage(INFORMATION, OK, "GAUCE-1000", ret);
     }
     </ajax:callback>
    </ajax:callback>
    
  
    
    
    
}

/**
 * closeCheck()
 * 작 성 자 : 박래형
 * 작 성 일 : 2011-03-10
 * 개    요    : 저장시 일마감체크를 한다.
 * return값 : void
 */
function closeCheck(){
        
    var strStrcd = document.getElementById("IN_STR_CD").value;                 // 점
    var strCloseDt = getRawData(document.getElementById("IN_BJDATE").value);   // 마감체크일자
    var strCloseTaskFlag = "PORD";                 // 업무구분(매입월마감)
    var strCloseUnitFlag = "42";                   // 단위업무
    var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
    var strCloseFlag     = "M";                    // 마감구분(월마감:M)
    
    var param = "&goTo=getCloseCheck" + "&strcd=" + strStrcd
                                      + "&closeDt=" + strCloseDt
                                      + "&strCloseTaskFlag=" + strCloseTaskFlag
                                      + "&strCloseUnitFlag=" + strCloseUnitFlag
                                      + "&strCloseAcntFlag=" + strCloseAcntFlag
                                      + "&strCloseFlag=" + strCloseFlag
                                      
    
    <ajax:open callback="on_getCloseCheckXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/ccom001.cc"/>
    
    <ajax:callback function="on_getCloseCheckXML">
        
        
        if( rowsNode.length > 0 ){
            
            var closeFlag = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
            
            if( closeFlag == "TRUE"){
                showMessage(INFORMATION, OK, "GAUCE-1000", "매입일 마감되어 발주매일 등록/수정이 불가능합니다.");
                return ;
            }  else if( closeFlag == "FALSE" ){
            	//마감이 안되었을때
                btn_save2();
                return true;
            }
        }
    </ajax:callback>
    
}

function calDetail2(row){  
	
    var row_cnt = 0;
	//alert("calDetail2 detailRowCnt : " + detailRowCnt);
	row_cnt = detailRowCnt-1;
	//alert("calDetail2 row_cnt : " + row_cnt);

	if(row == "D") { 
    	//alert("1 : " + row);
    	//alert("**** : " + document.getElementsByName("d_ord_qty").length);
    	if(document.getElementsByName("d_ord_qty").length == 0) {
    		return;
    	} 
    	else {
    		dispTotAmt();
    		/* 20120614 * DHL -->
    		var by_ord_qty = document.getElementsByName("d_ord_qty");
            var by_new_gat_amt  = document.getElementsByName("d_new_gat_amt");
            var by_new_cost_amt = document.getElementsByName("d_new_cost_amt");
            var by_new_sale_amt = document.getElementsByName("d_new_sale_amt");
            var by_vat_amt = document.getElementsByName("d_vatamt");
            
            var sum_srg = 0;
            var sum_wgg = 0;
            var sum_mgg = 0;
            var sum_vat = 0;
            
            var oldCostAmt = 0;
            var totCostAmt = 0;
            var totSaleAmt = 0; 
            var totGapAmt = 0;
            var totVatAmt = 0;
            
            for( j = 0; j < document.getElementsByName("d_ord_qty").length; j++ ){
                //alert("for j : "+document.getElementsByName("d_ord_qty").length);
                sum_srg = sum_srg + parseInt(removeComma2(by_ord_qty[j].value));
                sum_wgg = sum_wgg + parseInt(removeComma2(by_new_cost_amt[j].value));
                sum_mgg = sum_mgg + parseInt(removeComma2(by_new_sale_amt[j].value));
                sum_vat = sum_vat + parseInt(removeComma2(by_vat_amt[j].value));
                totGapAmt = totGapAmt + parseInt(removeComma2(by_new_gat_amt[j].value));
                totCostAmt = totCostAmt + parseInt(removeComma2(by_new_cost_amt[j].value));
                totSaleAmt = totSaleAmt + parseInt(removeComma2(by_new_sale_amt[j].value));
                totVatAmt = totVatAmt + parseInt(removeComma2(by_vat_amt[j].value));                
                //alert("for sum_srg : "+sum_srg+" sum_wgg : "+sum_wgg+" sum_mgg : "+sum_mgg+" sum_vat : "+sum_vat+" totGapAmt : "+totGapAmt+" totCostAmt : "+totCostAmt+" totSaleAmt : "+totSaleAmt+" totVatAmt : "+totVatAmt);
            } 
            
            document.getElementById("IN_SRG").value = convAmt(String(sum_srg));
            document.getElementById("IN_WGG").value = convAmt(String(sum_wgg));
            document.getElementById("IN_MGG").value = convAmt(String(sum_mgg));
           // document.getElementById("IN_VAT").value = convAmt(String(vatAmt));      // 부가세
            
            //20110524 차익액합계 
            document.getElementById("IN_GAP_TOT_AMT").value  = totGapAmt;
            
            //20110524 차익율 추가                   
            
            var totGapRate = getCalcPord("GAP_RATE", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
            document.getElementById("IN_NEW_GAP_RATE").value = totGapRate;
            
            totVatAmt = getCalcPord("VAT_AMT", totCostAmt, "", "", strTaxFlag, roundFlag);
            document.getElementById("IN_VAT_TAMT").value = totVatAmt;      // 부가세
            //alert("totVatAmt : " + totVatAmt);
        	//  20120614 * DHL <--
            */

            /*
            //  20120614 * DHL -->
            //20110523 부가세 추가
            var vatAmt = getCalcPord("VAT_AMT", cost_amt, "", "", strTaxFlag, roundFlag);
            document.getElementById("d_vatAmt"+row).value = vatAmt; 
            
            document.getElementById("IN_VAT_TAMT").value = vatAmt;      // 부가세
            alert("vatAmt : " + vatAmt);
            //  20120614 * DHL <--
            */

          /*  document.getElementById("IN_GAP_TOT_AMT").value = totGapAmt;                //마스터 gap_tot_amt 신차익액합 
            var totGapRate = getCalcPord("GAP_RATE", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
            
            document.getElementById("IN_NEW_GAP_RATE").value = totGapRate;                //마스터 gap_tot_amt 차익율 
            //20110523 부가세 추가
            var vatAmt      = getCalcPord("VAT_AMT",  cost_amt,   "", "", strTaxFlag, roundFlag); 
            
            var by_vat_amt = document.getElementsByName("d_vatAmt");
            var sum_vatAmt = 0;
            for( m = 0; m < by_vat_amt.length; m++ ){
                sum_vatAmt = sum_vatAmt + parseInt(removeComma2(by_vat_amt[m].value));
            }
            
            document.getElementById("IN_VAT_TAMT").value = sum_vatAmt;    */
    		
    	} 
       
    } 
    else {
        //alert("calDetail2 row : " +row);
        var cost_prc    = 0;
        var cost_amt    = 0;                                                                        // 원가금액
                                                                                                    // 원가단가(차익액, 차익율 위한)
        var sale_prc    = 0;
        var sale_amt    = 0;                                                                        // 매가금액
        var vatAmt      = 0;
        
        var gcost_prc   = 0;
        var gcost_amt   = 0;                                                                        // 원가금액(차익액, 차익율 위한)
        
        var ord_qty     = 0;
        var old_prc     = 0;
        var strTaxFlag  = g_tax_flag;
        var strmargin = document.getElementById("d_mg_rate"+row).value;                             // 마진율
        
        ord_qty = parseInt(removeComma2(document.getElementById("d_ord_qty"+row).value));           // 발주수량
        sale_prc = parseInt(removeComma2(document.getElementById("d_new_sale_prc"+row).value));     // 매가단가
        cost_prc = parseInt(removeComma2(document.getElementById("d_new_cost_prc"+row).value));     // 원가단가
        old_prc = parseInt(removeComma2(document.getElementById("d_old_cost_prc"+row).value));      // 기존원가단가
        cost_amt = parseInt(removeComma2(document.getElementById("d_new_cost_amt"+row).value));     // 원가단가
        
        //alert("calDetail2 ord_qty : " + ord_qty + " sale_prc : " + sale_prc + " cost_prc : " + cost_prc + " old_prc : " + old_prc);

        if (ord_qty == 0 && cost_prc == 0) {
        	document.getElementById("d_ord_qty"+row).focus();
        	return;
        } else {
        	if (sale_prc == 0 && cost_prc == 0) {
         	    document.getElementById("d_new_sale_prc"+row).focus();
         	    return;
         	} else {
         		if (cost_prc == 0 && old_prc == 0) {         			
         			sale_amt = sale_prc * ord_qty;
         			document.getElementById("d_new_sale_prc"+row).value = convAmt(String(sale_prc));
         			document.getElementById("d_new_sale_amt"+row).value = convAmt(String(sale_amt));
         			
         			cost_prc = getCalcPord("COST_PRC", "", sale_prc, strmargin, strTaxFlag, roundFlag);
                    document.getElementById("d_new_cost_prc"+row).value = convAmt(String(cost_prc)); 
                    //alert("calDetail2 d_new_cost_prc00 = " + cost_prc);

         			cost_amt = cost_prc * ord_qty;
                    document.getElementById("d_new_cost_amt"+row).value = convAmt(String(cost_amt)); 
                    //alert("calDetail2 d_new_cost_amt00 = " + cost_amt);

                    document.getElementById("d_old_cost_prc"+row).value = convAmt(String(cost_prc));            // 원가단가
        	        //alert("calDetail2 d_old_cost_prc00 = " + document.getElementById("d_old_cost_prc"+row).value);

        	        vatAmt = getCalcPord("VAT_AMT", cost_amt, "", "", strTaxFlag, roundFlag);
        	        document.getElementById("d_vatAmt"+row).value = vatAmt; 
        	        //alert("calDetail2 d_vatAmt00 : " + vatAmt);
        	        
        	        dispTotAmt();

                    document.getElementById("d_new_cost_prc"+row).focus();
         			return;
         		} else if (cost_prc != 0 && old_prc == 0) {
                    //document.getElementById("d_new_cost_prc"+row).focus();
         			return;
         		} else if (cost_prc == 0 && old_prc != 0) {
                    //document.getElementById("d_new_cost_prc"+row).focus();
         			return;
         		} else if (cost_prc != 0 && old_prc != 0) {
         			if (sale_prc != 0 && cost_prc==old_prc){
             			sale_amt = sale_prc * ord_qty;
             			document.getElementById("d_new_sale_prc"+row).value = convAmt(String(sale_prc));
             			document.getElementById("d_new_sale_amt"+row).value = convAmt(String(sale_amt));

             			cost_prc = getCalcPord("COST_PRC", "", sale_prc, strmargin, strTaxFlag, roundFlag);
                        document.getElementById("d_new_cost_prc"+row).value = convAmt(String(cost_prc)); 
                        //alert("calDetail2 d_new_cost_prc01 = " + cost_prc);

             			cost_amt = cost_prc * ord_qty;
                        document.getElementById("d_new_cost_amt"+row).value = convAmt(String(cost_amt)); 
                        //alert("calDetail2 d_new_cost_amt01 = " + cost_amt);

                        document.getElementById("d_old_cost_prc"+row).value = convAmt(String(cost_prc));            // 원가단가
            	        //alert("calDetail2 d_old_cost_prc01 = " + document.getElementById("d_old_cost_prc"+row).value);

            	        vatAmt = getCalcPord("VAT_AMT", cost_amt, "", "", strTaxFlag, roundFlag);
            	        document.getElementById("d_vatAmt"+row).value = vatAmt; 
            	        //alert("calDetail2 d_vatAmt01 : " + vatAmt);
            	        dispTotAmt();

                        document.getElementById("d_new_cost_prc"+row).focus();
	         			return;
         			} else if (sale_prc !=0 && cost_prc!=old_prc){
             			sale_amt = sale_prc * ord_qty;
             			document.getElementById("d_new_sale_prc"+row).value = convAmt(String(sale_prc));
             			document.getElementById("d_new_sale_amt"+row).value = convAmt(String(sale_amt));

             			cost_prc = getCalcPord("COST_PRC", "", sale_prc, strmargin, strTaxFlag, roundFlag);
                        document.getElementById("d_new_cost_prc"+row).value = convAmt(String(cost_prc)); 
                        //alert("calDetail2 d_new_cost_prc02 = " + cost_prc);

             			cost_amt = cost_prc * ord_qty;
                        document.getElementById("d_new_cost_amt"+row).value = convAmt(String(cost_amt)); 
                        //alert("calDetail2 d_new_cost_amt02 = " + cost_amt);

                        document.getElementById("d_old_cost_prc"+row).value = convAmt(String(cost_prc));            // 원가단가
            	        //alert("calDetail2 d_old_cost_prc02 = " + document.getElementById("d_old_cost_prc"+row).value);

            	        vatAmt = getCalcPord("VAT_AMT", cost_amt, "", "", strTaxFlag, roundFlag);
            	        document.getElementById("d_vatAmt"+row).value = vatAmt; 
            	        //alert("calDetail2 d_vatAmt02 : " + vatAmt);
            	        
            	        dispTotAmt();

            	        document.getElementById("d_new_cost_prc"+row).focus();
	         			return;
         			}
         		}
         	}
        }
    }
}

function dispTotAmt() {
		var by_ord_qty = document.getElementsByName("d_ord_qty");
        var by_new_gat_amt  = document.getElementsByName("d_new_gat_amt");
        var by_new_cost_amt = document.getElementsByName("d_new_cost_amt");
        var by_new_sale_amt = document.getElementsByName("d_new_sale_amt");
        var by_vat_amt = document.getElementsByName("d_vatamt");
        
        var sum_srg = 0;
        var sum_wgg = 0;
        var sum_mgg = 0;
        var sum_vat = 0;
        
        var oldCostAmt = 0;
        var totCostAmt = 0;
        var totSaleAmt = 0; 
        var totGapAmt  = 0;
        var totVatAmt  = 0;
        var strTaxFlag = g_tax_flag;
        
        for( j = 0; j < document.getElementsByName("d_ord_qty").length; j++ ){
            //alert("for j : "+document.getElementsByName("d_ord_qty").length);
            sum_srg = sum_srg + parseInt(removeComma2(by_ord_qty[j].value));
            sum_wgg = sum_wgg + parseInt(removeComma2(by_new_cost_amt[j].value));
            sum_mgg = sum_mgg + parseInt(removeComma2(by_new_sale_amt[j].value));
            sum_vat = sum_vat + parseInt(removeComma2(by_vat_amt[j].value));
            totGapAmt = totGapAmt + parseInt(removeComma2(by_new_gat_amt[j].value));
            totCostAmt = totCostAmt + parseInt(removeComma2(by_new_cost_amt[j].value));
            totSaleAmt = totSaleAmt + parseInt(removeComma2(by_new_sale_amt[j].value));
            totVatAmt = totVatAmt + parseInt(removeComma2(by_vat_amt[j].value));                
            //alert("for sum_srg : "+sum_srg+" sum_wgg : "+sum_wgg+" sum_mgg : "+sum_mgg+" sum_vat : "+sum_vat+" totGapAmt : "+totGapAmt+" totCostAmt : "+totCostAmt+" totSaleAmt : "+totSaleAmt+" totVatAmt : "+totVatAmt);
        } 
        
        document.getElementById("IN_SRG").value = convAmt(String(sum_srg));
        document.getElementById("IN_WGG").value = convAmt(String(sum_wgg));
        document.getElementById("IN_MGG").value = convAmt(String(sum_mgg));
        // document.getElementById("IN_VAT").value = convAmt(String(sum_vat));
        
        //20110524 차익액합계 
        document.getElementById("IN_GAP_TOT_AMT").value  = totGapAmt;
        
        //20110524 차익율 추가                   
        var totGapRate = getCalcPord("GAP_RATE", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
        document.getElementById("IN_NEW_GAP_RATE").value = totGapRate;
        
        
        //20110523 부가세 추가
        totVatAmt = getCalcPord("VAT_AMT", totCostAmt, "", "", strTaxFlag, roundFlag);
        document.getElementById("IN_VAT_TAMT").value = totVatAmt;      // 부가세
        //alert("vatAmt : " + vatAmt);
        
        /*
        if (old_prc == 0) {
            cost_prc = getCalcPord("COST_PRC", "", sale_prc, strmargin, strTaxFlag, roundFlag);
            document.getElementById("d_new_cost_prc"+row).value = convAmt(String(cost_prc)); 
            alert("calDetail2 cost_prc = " + cost_prc);
            old_prc = document.getElementById("d_old_cost_prc"+row).value;
            alert("calDetail2 old_prc = " + old_prc);
	        document.getElementById("d_old_cost_prc"+row).value = convAmt(String(cost_prc));            // 원가단가
	        alert("calDetail2 d_old_cost_prc = " + document.getElementById("d_old_cost_prc"+row).value);
        } else {
        	//if () 
        }
        */
        
/*         
        if (ord_qty == 0) {
        	document.getElementById("d_ord_qty"+row).focus();
        	return;
        } else {
        }
 */
    	/*
        if(strTaxFlag == "1"){         //과세
            cost_prc  = (((sale_prc * 10)/11) * (100 - strmargin))/ 100;
            gcost_prc = (((sale_prc * 10)/11) * (100 - strmargin))/ 100;
            
        }else{                          //비과세, 영세
            cost_prc  = (sale_prc * (100 - strmargin) / 100);     
            gcost_prc = (sale_prc * (100 - strmargin) / 100);     
        }  
        
        gcost_prc = gcost_prc * ord_qty;
        
        cost_prc = getRoundDec(roundFlag,cost_prc);                      //반올림 구분 받아 계산 공통함수 
         
        document.getElementById("d_new_cost_prc"+row).value = convAmt(String(round(cost_prc, 0)));                // 원가단가
        document.getElementById("d_new_cost_amt"+row).value = convAmt(String(round((cost_prc * ord_qty), 0)));    // 원가금액
        sale_amt = sale_prc * ord_qty;                                                                            // 매가금액
        document.getElementById("d_new_sale_amt"+row).value = convAmt(String(round(sale_amt, 0)));                // 매가금액
        
       
        sale_amt = sale_prc * ord_qty;                                                               //매가금액
        //alert("######### sale_prc="+sale_prc);
        cost_prc = getCalcPord("COST_PRC", "", sale_prc, strmargin, strTaxFlag, roundFlag);    
        //alert("######### cost_prc="+cost_prc);
        document.getElementById("d_new_cost_prc"+row).value = convAmt(String(cost_prc));             // 원가단가
        document.getElementById("d_old_cost_prc"+row).value = convAmt(String(cost_prc));             // 원가금액
        
        cost_amt  = cost_prc * ord_qty; 
        //alert("######### cost_amt="+cost_amt);
        document.getElementById("d_new_cost_amt"+row).value = convAmt(String(cost_amt));             // 원가금액

        sale_amt  = sale_prc * ord_qty;
        //alert("######### sale_amt="+sale_amt);
        document.getElementById("d_new_sale_amt"+row).value = convAmt(String(sale_amt));             // 매가금액
        
        //디테일 차익액
        var gapAmt = getCalcPord("GAP_AMT", cost_amt, sale_amt, "", strTaxFlag, roundFlag);       
        document.getElementById("d_new_gat_amt"+row).value  = gapAmt;      // 차익액
        
        var by_ord_qty = document.getElementsByName("d_ord_qty");
        var by_new_gat_amt = document.getElementsByName("d_new_gat_amt");
        var by_new_cost_amt = document.getElementsByName("d_new_cost_amt");
        var by_new_sale_amt = document.getElementsByName("d_new_sale_amt");
        var sum_srg = 0;
        var sum_wgg = 0;
        var sum_mgg = 0;
        
        var totCostAmt = 0;
        var totSaleAmt = 0; 
        var totGapAmt = 0;
        
        for( j = 0; j < document.getElementsByName("d_ord_qty").length; j++ ){
            //alert(document.getElementsByName("d_ord_qty").length);
            sum_srg = sum_srg + parseInt(removeComma2(by_ord_qty[j].value));
            //alert(sum_srg);
            sum_wgg = sum_wgg + parseInt(removeComma2(by_new_cost_amt[j].value));
            sum_mgg = sum_mgg + parseInt(removeComma2(by_new_sale_amt[j].value));
            totGapAmt = totGapAmt + parseInt(removeComma2(by_new_gat_amt[j].value));
            totCostAmt = totCostAmt + parseInt(removeComma2(by_new_cost_amt[j].value));
            totSaleAmt = totSaleAmt + parseInt(removeComma2(by_new_sale_amt[j].value));
        } 
         
        document.getElementById("IN_SRG").value = convAmt(String(sum_srg));
        document.getElementById("IN_WGG").value = convAmt(String(sum_wgg));
        document.getElementById("IN_MGG").value = convAmt(String(sum_mgg));

        
        //20110524 차익액합계 
        document.getElementById("IN_GAP_TOT_AMT").value  = totGapAmt;
        
        //20110524 차익율 추가                   
        
        var totGapRate = getCalcPord("GAP_RATE", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
        document.getElementById("IN_NEW_GAP_RATE").value = totGapRate;
         
        
        //20110523 부가세 추가
        var vatAmt = getCalcPord("VAT_AMT", cost_amt, "", "", strTaxFlag, roundFlag);
        document.getElementById("d_vatAmt"+row).value = vatAmt; 
        document.getElementById("IN_VAT_TAMT").value = vatAmt;      // 부가세
        //alert("######### vatAmt : " + vatAmt);
//        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VAT_TAMT") = DS_IO_DETAIL.Sum(23,0,0);

//        EM_O_SRG.Text   = DS_IO_DETAIL.NameSum("ORD_QTY",0,0);
//        EM_O_WGG.Text   = DS_IO_DETAIL.NameSum("NEW_COST_AMT",0,0);
//        EM_O_MGG.Text   = DS_IO_DETAIL.NameSum("NEW_SALE_AMT",0,0);
      
        /*
        if(strTaxFlag == "1"){        // 과세
       document.getElementById("d_new_gat_amt"+row).value = getRoundDec(roundFlag,((sale_amt*10)/11) - (cost_prc * ord_qty));   // 차익액 = (매가합계/1.1) - 원가합계

        }else if(strTaxFlag == "2" || strTaxFlag == "3"){  // 면세,영세
            document.getElementById("d_new_gat_amt"+row).value = sale_amt - (cost_prc * ord_qty);       // 차익액 = 매가합계 - 원가합계
        }
        
        cost_amt = parseInt(removeComma2(document.getElementById("d_new_cost_prc"+row).value)) * parseInt(removeComma2(document.getElementById("d_ord_qty"+row).value));
        
        var by_ord_qty = document.getElementsByName("d_ord_qty");
        var by_new_gat_amt = document.getElementsByName("d_new_gat_amt");
        var by_new_cost_amt = document.getElementsByName("d_new_cost_amt");
        var by_new_sale_amt = document.getElementsByName("d_new_sale_amt");
        var sum_srg = 0;
        var sum_wgg = 0;
        var sum_mgg = 0;
        
        var totCostAmt = 0;
        var totSaleAmt = 0; 
        var totGapAmt = 0;
        
        for( j = 0; j < document.getElementsByName("d_ord_qty").length; j++ ){
     //  alert(document.getElementsByName("d_ord_qty").length);
            sum_srg = sum_srg + parseInt(removeComma2(by_ord_qty[j].value));
            //alert(sum_srg);
            sum_wgg = sum_wgg + parseInt(removeComma2(by_new_cost_amt[j].value));
            sum_mgg = sum_mgg + parseInt(removeComma2(by_new_sale_amt[j].value));
            totGapAmt = totGapAmt + parseInt(removeComma2(by_new_gat_amt[j].value));
            totCostAmt = totCostAmt + parseInt(removeComma2(by_new_cost_amt[j].value));
            totSaleAmt = totSaleAmt + parseInt(removeComma2(by_new_sale_amt[j].value));
        } 
        
        document.getElementById("IN_SRG").value = convAmt(String(sum_srg));
        document.getElementById("IN_WGG").value = convAmt(String(sum_wgg));
        document.getElementById("IN_MGG").value = convAmt(String(sum_mgg));
             
        
        //var totGapAmt = getCalcPord("GAP_AMT",  totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
        document.getElementById("IN_GAP_TOT_AMT").value = totGapAmt;                //마스터 gap_tot_amt 신차익액합
      
        //20110524 차익율 추가
       // alert("totCostAmt : " + totCostAmt);
       // alert("totSaleAmt : " + totSaleAmt);
        var totGapRate = getCalcPord("GAP_RATE", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
        document.getElementById("IN_NEW_GAP_RATE").value = totGapRate;                //마스터 gap_tot_amt 차익율
      //  alert("totGapRate : " + totGapRate);
        //20110523 부가세 추가
        var vatAmt      = getCalcPord("VAT_AMT",  cost_amt,   "", "", strTaxFlag, roundFlag);

    //    alert("2_vatAmt : " + vatAmt);
        document.getElementById("d_vatAmt"+row).value = vatAmt; 
      //  alert(document.getElementById("d_pummok_nm"+row).value);
        //alert("매가 : " +  document.getElementById("d_new_sale_amt"+row).value);
        
        var by_vat_amt = document.getElementsByName("d_vatAmt");
        var sum_vatAmt = 0;
        for( m = 0; m < by_vat_amt.length; m++ ){
            sum_vatAmt = sum_vatAmt + parseInt(removeComma2(by_vat_amt[m].value)); 
        }
        
        document.getElementById("IN_VAT_TAMT").value = sum_vatAmt;    

       // alert("2_sum_vatAmt : " + sum_vatAmt);
       
        //document.getElementById("d_new_cost_prc"+row).disabled = true;
		//document.getElementById("d_new_cost_prc"+row).focus();
         */
}


/**
 * allChk()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  디테일 체크박스 전체선택, 전체해제
 * return값 : void
*/ 
function allChk(){
   
    if( document.getElementById("check1").checked == true ){                    //전체 선택
        
        for( i = 0; i < document.getElementsByName("d_slip_no").length; i++ ){
        
            document.getElementsByName("d_check1")[i].checked = true;
        }
        
    }else {//전체 해제
        
        for( i = 0; i < document.getElementsByName("d_slip_no").length; i++ ){
        
           document.getElementsByName("d_check1")[i].checked = false;
        }
        
    }
}
 
/**
 * add_row_dtl(strCnt)
 * 작 성 자 : 김정민  
 * 작 성 일 : 2011-07-18
 * 개    요 :  행추가 이전에 row에 필수값이 입력 되었는지 check
 * return값 : void
*/ 
function add_row_dtl(strCnt){  
	 //alert(strCnt);
   // var strPum       = document.getElementById("d_pummok_cd"+strCnt).value;      // 해당 row의 품목코드
   // var strOrdQty    = document.getElementById("d_ord_qty"+strCnt).value;        // 해당 row의 수량
   // var strSalePrc   = document.getElementById("d_new_sale_prc"+strCnt).value;   // 해당 row의 매가 단가
    //var strSaleAmt   = document.getElementById("d_new_sale_amt"+strCnt).value;   // 해당 row의 매가 금액
      
    //if(strPum == ""){ 
     //   showMessage(EXCLAMATION, OK, "USER-1003", "품목코드");
     //   document.getElementById("d_pummok_cd"+strCnt).focus();
     //   return false;
    //}
    
  /*  if(strOrdQty == 0){ 
        showMessage(EXCLAMATION, OK, "USER-1003", "수량");
        document.getElementById("d_ord_qty"+strCnt).focus();
        return false;
    }
    
    if(strSalePrc == 0){ 
        showMessage(EXCLAMATION, OK, "USER-1003", "단가");
        document.getElementById("d_new_sale_prc"+strCnt).focus();
        return false;
    }*/ 
   // if(strPum != "" && strSaleAmt != 0){   
     add_row();
   //}
   
}

function add_del_row(flag) {
	if(flag == false) {
		enableControl(IMG_BJDATE, false);
        enableControl(IMG_NPYJDATE, false);
        enableControl(IMG_MAJINDATE, false);
        document.getElementById("IN_PB_CD").disabled = true;                 //브랜드 입력부
        document.getElementById("IN_BJDATE").disabled = true;                //발주일
        //document.getElementById("IN_BJDATE").style.backgroundColor = "#ffffff";
        document.getElementById("IN_NPYJDATE").disabled = true;            //납품예정일
        //document.getElementById("IN_NPYJDATE").style.backgroundColor = "#ffffff";
        document.getElementById("IN_MAJINDATE").disabled = true;           //마진적용일
        //document.getElementById("IN_MAJINDATE").style.backgroundColor = "#ffffff";
        document.getElementById("IN_HS_GBN").disabled = true;              //행사구분
        //document.getElementById("IN_HS_GBN").style.backgroundColor = "#ffffff";
        document.getElementById("IN_HS_RATE").disabled = true;             //행사율
        //document.getElementById("IN_HS_RATE").style.backgroundColor = "#ffffff"; 
	}
	else {
		enableControl(IMG_BJDATE, true);
        enableControl(IMG_NPYJDATE, true);
        enableControl(IMG_MAJINDATE, true);
        document.getElementById("IN_PB_CD").disabled = false;                 //브랜드 입력부
        document.getElementById("IN_BJDATE").disabled = false;                //발주일
        //document.getElementById("IN_BJDATE").style.backgroundColor = "#ffffff";
        document.getElementById("IN_NPYJDATE").disabled = false;            //납품예정일
        //document.getElementById("IN_NPYJDATE").style.backgroundColor = "#ffffff";
        document.getElementById("IN_MAJINDATE").disabled = false;           //마진적용일
        //document.getElementById("IN_MAJINDATE").style.backgroundColor = "#ffffff";
        document.getElementById("IN_HS_GBN").disabled = false;              //행사구분
        //document.getElementById("IN_HS_GBN").style.backgroundColor = "#ffffff";
        document.getElementById("IN_HS_RATE").disabled = false;             //행사율
        //document.getElementById("IN_HS_RATE").style.backgroundColor = "#ffffff"; 
	}
}

 /**
  * allChk()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  
  * 개    요 :  행추가
  * return값 : void
 */ 
 function add_row(){ 
	 // add_del_row( false );    
	 /* 
     if( document.getElementById("HRS_NM").value == "" || document.getElementById("IN_BUYER_CD").value == ""  ){
         showMessage(INFORMATION, OK, "GAUCE-1000", "전표 마스터 내용을 먼저 추가해 주세요.");
         return;
     }
     */
     
     if( document.getElementById("HRS_NM").value == ""){
         showMessage(INFORMATION, OK, "GAUCE-1000", "전표 마스터 내용을 먼저 추가해 주세요.");
         return;
     }

     if(document.getElementById("IN_HS_GBN").value == "" ){                                       // 점
         showMessage(INFORMATION, OK, "USER-1003", "행사구분"); 
         add_del_row( true );
         document.getElementById("IN_HS_GBN").focus();
         return false;                                                      
     }
     else { 
         add_del_row( false );     
     }
     if(document.getElementById("IN_HS_RATE").value == "" ){                                       // 점
         showMessage(INFORMATION, OK, "USER-1003", "행사율");
         add_del_row( true );
         document.getElementById("IN_HS_RATE").focus();
         return false;                                                      
     }
     else { 
         add_del_row( false );     
     }

     if(!checkValidation("Save"))  return;

     // 스크롤 위치 초기화       
     document.all.DETAIL_Title.scrollLeft = 0;
     document.all.DETAIL_CONTETN.scrollLeft = 0; 

     var tb_detail = document.getElementById("tb_detail");
     
     var tr;
     var td; 
     
 //    var strCnt = document.getElementById("d_pummok_cd").value+detailRowCnt;
     
 //    alert(strCnt);
 //alert("detailRowCnt : " + detailRowCnt);
     detailRowCnt = eval(document.getElementsByName("d_ord_qty").length); //No표기용
     if (detailRowCnt == 0) {
         var lastIndex = 0;
         var rowIndex = 0;
     } else {
    	 //var lastIndexId = document.getElementsByName("d_pummok_cd")[detailRowCnt-1].id
    	 //var lastIndex = eval(lastIndexId.replace("d_pummok_cd", ""));
    	 var lastIndexId = document.getElementsByName("d_pmksrt_cd")[detailRowCnt-1].id
	     var lastIndex = eval(lastIndexId.replace("d_pmksrt_cd", ""));
	     var rowIndex = eval(lastIndex) + 1;
     }

 //   alert("lastIndex : " + lastIndex);
 //   alert("rowIndex : " + rowIndex);
     tr = tb_detail.insertRow();
     
     td = tr.insertCell(0);
     td.style.width = "35";
     td.className = "r1";
     td.innerHTML = "<input type='hidden' name='RowStatus' id='RowStatus"+rowIndex+"' value='1'  />";//상태
     td.innerHTML += "<input type='hidden' name='d_strcd' id='d_strcd"+rowIndex+"' value='"+strcd+"'  />";
     td.innerHTML += "<input type='hidden' name='d_slip_no' id='d_slip_no"+rowIndex+"' value='"+gl_slip_no+"'  />";
     td.innerHTML += "<input type='hidden' name='d_ord_seq_no' id='d_ord_seq_no"+rowIndex+"' value='0' />";
     if( new_row == "3" ){
         td.innerHTML += "<input type='hidden' name='d_pumbuncd' id='d_pumbuncd"+rowIndex+"' value='"+document.getElementById("IN_PB_CD").value+"' />";    
     } else {
         td.innerHTML += "<input type='hidden' name='d_pumbuncd' id='d_pumbuncd"+rowIndex+"' value='"+g_pumbun_cd+"' />";
     }
     td.innerHTML += "<input type='hidden' name='d_vatAmt' id='d_vatAmt"+rowIndex+"' value='0' />";
     td.innerHTML += "<input type='hidden' name='d_new_gat_amt' id='d_new_gat_amt"+rowIndex+"' value='0' />";
     td.innerHTML += "<input type='text' name='d_no' id='d_no"+rowIndex+"' value='"+(detailRowCnt+1)+"' size='4' style='text-align:center;' disabled='disabled' />";
     
     td1 = tr.insertCell(1);
     td1.style.width = "25";
     td1.className = "r1";
     td1.innerHTML = "<input type='checkbox' name='d_check1' id='d_check1"+rowIndex+"' style='text-align:center;' />";
     
     td2 = tr.insertCell(2);
     td2.style.width = "60";
     td2.className = "r1";
     td2.innerHTML = "<input type='text' name='d_pmksrt_cd' id='d_pmksrt_cd"+rowIndex+"' size ='5' style='text-align:right;IME-MODE: disabled;text-align:center;' onkeypress='javascript:onlyNumber();' maxlength='4' /><input type='button' id='pmkSrtImg' name='pmkSrtImg' size='15' onclick='getPbnPmkSrtPop("+rowIndex+");' onkeydown='if(event.keyCode == 13){ getPbnPmkSrtPop("+rowIndex+");}' value='..' />"; // onblur='pmkSrtBlur("+rowIndex+");'
     
     td3 = tr.insertCell(3);
     td3.style.width = "70";
     td3.className = "r1";
     td3.innerHTML = "<input type='text' name='d_pummok_cd' id='d_pummok_cd"+rowIndex+"' size ='8' style='text-align:center;' maxlength='8' disabled='disabled'  />";

     td4 = tr.insertCell(4);
     td4.style.width = "90";
     td4.className = "r1";
     td4.innerHTML = "<input type='text' name='d_pummok_nm' id='d_pummok_nm"+rowIndex+"' size='12'  style='text-align:left;' maxlength='40' disabled='disabled'  />";
     
     td5 = tr.insertCell(5);
     td5.style.width = "45";
     td5.className = "r1"; 
     td5.innerHTML = "<input type='text' name='d_ord_unit_cd' id='d_ord_unit_cd"+rowIndex+"' size='5' style='text-align:right;' maxlength='3' value='0' disabled='disabled' />";
     
     td6 = tr.insertCell(6);
     td6.style.width = "45";
     td6.className = "r1";
     td6.innerHTML = "<input type='text' name='d_ord_qty' id='d_ord_qty"+rowIndex+"' size='5' onkeypress='javascript:onlyNumber();' style='text-align:right; IME-MODE: disabled;' maxlength='7' value='0' onkeydown=' if(event.keyCode == 13){ calDetail2("+rowIndex+"); } ' onblur='javascript:calDetail2("+rowIndex+");'/>"; // onblur='javascript:calDetail2("+rowIndex+");'
     
     td7 = tr.insertCell(7);
     td7.style.width = "45";
     td7.className = "r1";
     td7.innerHTML = "<input type='text' name='d_mg_rate' id='d_mg_rate"+rowIndex+"' size='4' style='text-align:right;' value='0' disabled='disabled' />";
     
     td8 = tr.insertCell(8);
     td8.style.width = "85";
     td8.className = "r1";
     td8.innerHTML = "<input type='text' name='d_new_cost_prc' id='d_new_cost_prc"+rowIndex+"' size='11' style='text-align:right;' maxlength='9' value='0' onkeypress='javascript:onlyNumber();'  onkeydown=' if(event.keyCode == 13){ onCostPrcChg("+rowIndex+"); } ' onblur='javascript:onCostPrcChg("+rowIndex+");' />"; // onblur='javascript:onCostPrcChg("+rowIndex+");'  
     
     td9 = tr.insertCell(9);
     td9.style.width = "85";
     td9.className = "r1";
     td9.innerHTML = "<input type='text' name='d_new_cost_amt' id='d_new_cost_amt"+rowIndex+"' size='11' style='text-align:right;' maxlength='13' value='0' disabled='disabled' />";
     
     td10 = tr.insertCell(10);
     td10.style.width = "85";
     td10.className = "r1";
     td10.innerHTML = "<input type='text' name='d_new_sale_prc' id='d_new_sale_prc"+rowIndex+"' size='11' onkeypress='javascript:onlyNumber();' style='text-align:right;IME-MODE: disabled' maxlength='9' value='0' onkeydown=' if(event.keyCode == 13){ calDetail2("+rowIndex+");  } ' />";  // add_row("+rowIndex+"); //onblur='javascript: calDetail2("+rowIndex+");'  
     
     td11 = tr.insertCell(11);
     td11.style.width = "85";
     td11.className = "r1";
     td11.innerHTML = "<input type='text' name='d_new_sale_amt' id='d_new_sale_amt"+rowIndex+"' size='11' style='text-align:right;' maxlength='13' value='0' disabled='disabled' />";
     
     td12 = tr.insertCell(12);
     td12.style.width = "35";
     td12.className = "r1";
     td12.innerHTML = "<input type='text' name='d_tag_flag' id='d_tag_flag"+rowIndex+"' size='4' style='text-align:center;' maxlength='2'  disabled='disabled' />";
     
     td13 = tr.insertCell(13);
     td13.style.width = "55";
     td13.className = "r1"; 
     td13.innerHTML = "<input type='text' name='d_tag_prt_own_flag' id='d_tag_prt_own_flag"+rowIndex+"' size='7' style='text-align:left;' maxlength='40' disabled='disabled'  />";

     td14 = tr.insertCell(14);
     td14.style.width = "85";
     td14.className = "r1";
     td14.innerHTML = "<input type='hidden' name='d_old_cost_prc' id='d_old_cost_prc"+rowIndex+"' size='11' style='text-align:right;' maxlength='9' value='0' disabled='disabled' />";

     td.appendChild(td);
     td1.appendChild(td1);
     td2.appendChild(td2);
     td3.appendChild(td3);
     td4.appendChild(td4);
     td5.appendChild(td5);
     td6.appendChild(td6);
     td7.appendChild(td7);
     td8.appendChild(td8);
     td9.appendChild(td9);
     td10.appendChild(td10);
     td11.appendChild(td11);
     td12.appendChild(td12);
     td13.appendChild(td13);
     td14.appendChild(td14);

     if (detailRowCnt < 0) {
    	 return; 
     }
     else if (detailRowCnt == 0) {
    	 //var pre_cnt        = detailRowCnt-1;                            // 이전row   
         var strPre_PmkSrt  = document.getElementById("d_pmksrt_cd"+lastIndex).value;             // 이전 row의 단축코드 
    	 var strPre_PumCd   = document.getElementById("d_pummok_cd"+lastIndex).value;             // 이전 row의 품목코드 
         var strPre_PumNm   = document.getElementById("d_pummok_nm"+lastIndex).value;             // 이전 row의 품목명
         var strPre_Dan     = document.getElementById("d_ord_unit_cd"+lastIndex).value;           // 이전 row의 단위
         var strPre_TagFlag = document.getElementById("d_tag_flag"+lastIndex).value;              // 이전 row의 TAG구분
         var strPre_OwnFlag = document.getElementById("d_tag_prt_own_flag"+lastIndex).value;      // 이전 row의 TAG발행주체 
         
         //alert("@@@ : " +norm_mg_rate);
         document.getElementById("d_mg_rate"+rowIndex).value            = norm_mg_rate;
         document.getElementById("d_pmksrt_cd"+rowIndex).value          = strPre_PmkSrt;
         document.getElementById("d_pummok_cd"+rowIndex).value          = strPre_PumCd;
         document.getElementById("d_pummok_nm"+rowIndex).value          = strPre_PumNm;
         document.getElementById("d_ord_unit_cd"+rowIndex).value        = strPre_Dan;
         document.getElementById("d_tag_flag"+rowIndex).value           = strPre_TagFlag;
         document.getElementById("d_tag_prt_own_flag"+rowIndex).value   = strPre_OwnFlag;
         
         //setTimeout("document.getElementById('d_pummok_cd"+rowIndex+"').focus();", 100);
         setTimeout("document.getElementById('d_pmksrt_cd"+rowIndex+"').focus();", 100);
     }
     else { 
         //alert(document.getElementById("d_pummok_cd"+pre_cnt).id);

         //var pre_cnt        = aaaa.replace("d_pummok_cd", "");//detailRowCnt-1; // 이전row  document.getElementById("d_no").value-1;
         //alert(pre_cnt);
         //alert("~~~~ : " +norm_mg_rate);
         var strPre_PmkSrt  = document.getElementById("d_pmksrt_cd"+lastIndex).value;             // 이전 row의 단축코드
         var strPre_PumCd   = document.getElementById("d_pummok_cd"+lastIndex).value;             // 이전 row의 품목코드 
         var strPre_PumNm   = document.getElementById("d_pummok_nm"+lastIndex).value;             // 이전 row의 품목명
         var strPre_Dan     = document.getElementById("d_ord_unit_cd"+lastIndex).value;           // 이전 row의 단위
         var strPre_TagFlag = document.getElementById("d_tag_flag"+lastIndex).value;              // 이전 row의 TAG구분
         var strPre_OwnFlag = document.getElementById("d_tag_prt_own_flag"+lastIndex).value;      // 이전 row의 TAG발행주체 
         
         document.getElementById("d_mg_rate"+rowIndex).value            = norm_mg_rate;
         document.getElementById("d_pmksrt_cd"+rowIndex).value          = strPre_PmkSrt;
         document.getElementById("d_pummok_cd"+rowIndex).value          = strPre_PumCd;
         document.getElementById("d_pummok_nm"+rowIndex).value          = strPre_PumNm;
         document.getElementById("d_ord_unit_cd"+rowIndex).value        = strPre_Dan;
         document.getElementById("d_tag_flag"+rowIndex).value = strPre_TagFlag;
         document.getElementById("d_tag_prt_own_flag"+rowIndex).value   = strPre_OwnFlag;
          
         //setTimeout("document.getElementById('d_pummok_cd"+rowIndex+"').focus();", 100);
         setTimeout("document.getElementById('d_pmksrt_cd"+rowIndex+"').focus();", 100);
     }

     //setTimeout("document.getElementById('d_pummok_cd"+rowIndex+"').focus();", 100);
     setTimeout("document.getElementById('d_pmksrt_cd"+rowIndex+"').focus();", 100);
     
     detailRowCnt++;
     
     //setObject(false);
     //setCalImgDis(false);
     
}
 
 
 /**
  * btn_new()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  신규 등록
  * return값 : void
*/ 
function btn_new(){
    new_row = "3";
    
    detailRowCnt = 0;
    document.getElementById("IN_STR_CD").value = '<%=strcd%>';
    document.getElementsByName("IN_SLIP_FLAG")[0].checked = true;
    document.getElementById("IN_SH_GBN").value = "0";
    document.getElementById("IN_SH_GBN_NM").value = "사전전표";
    //document.getElementById("IN_PB_CD").options[0].selected = true;
    document.getElementById("IN_PB_CD").index = 0;
    document.getElementById("IN_BALJUJC").value = "1";
    document.getElementById("ord_own_falg_nm").value = "EDI발주";
    if( document.getElementById("IN_SH_GBN").value == "0" ) {
        var nextDay = addDate("d", 1, strToday);
        document.getElementById("IN_BJDATE").value = getDateFormat(strToday);
        document.getElementById("IN_NPYJDATE").value = nextDay;
        document.getElementById("IN_MAJINDATE").value = nextDay;
        setCalImgDis(true);
    }
    
    document.getElementById("IN_BJHJDATE").value = "";
    
    /* 수정 해야 할 부분   */
    document.getElementById("HRS_CD").value = "";
    document.getElementById("HRS_NM").value = "";
    document.getElementById("IN_GS_GBN_NM").value = "";
    document.getElementById("IN_GS_GBN").value = "";
    document.getElementById("IN_BUYER_CD").value = "";
    document.getElementById("IN_BUYER_NM").value = "";
    //=====================
    
    document.getElementById("IN_HS_GBN").length = 0;
    document.getElementById("IN_HS_RATE").length = 0;
    document.getElementById("IN_HS_RATE").disabled = true;
    document.getElementById("IN_GPWJ_DATE").value = "";
    document.getElementById("IN_SRG").value = "";
    document.getElementById("IN_WGG").value = "";
    // document.getElementById("IN_VAT").value = "";
    document.getElementById("IN_MGG").value = "";
    document.getElementById("IN_ETC").value = "";
    document.getElementById("IN_GAP_TOT_AMT").value = "0";
    document.getElementById("IN_NEW_GAP_RATE").value = "0";
    document.getElementById("IN_VAT_TAMT").value = "0";
    

    // 스크롤 위치 초기화        
    document.all.DETAIL_Title.scrollLeft = 0;
    document.all.DETAIL_CONTETN.scrollLeft = 0; 
    
    //alert('1');
    getpumbunGbBu();
    
    var div_detail = "<table width='860' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_detail'>";
    div_detail += "</table>";
    document.getElementById("DETAIL_CONTETN").innerHTML = div_detail;
    
    setObject(true);
    enableControl(IMG_ADD, true);
    enableControl(IMG_DEL, true);
    document.getElementById('IN_PB_CD').focus();
    
    gl_strcd   = " ";     
    gl_slip_no = " ";
      
}
 
/**
 * getpumbunGbBu()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  브랜드에 따라 활성화, 비활성화 , 관세, 바이이 설정
 * return값 : void
 */ 
function getpumbunGbBu(){
    
     var vencd = "<%=vencd%>" ;          //협력사코드
     var strcd = "<%=strcd%>" ;          //점코드
     var pumbuncd = document.getElementById("IN_PB_CD").value;                        //브랜드코드
     
     var param = "&goTo=getpumbunGbBun&strcd=" + strcd
                                   + "&vencd=" + vencd
                                   + "&pumbuncd=" + pumbuncd;
                                              
     <ajax:open callback="on_getMasterXML" 
         param="param" 
         method="POST" 
         urlvalue="/edi/eord101.eo"/>
     <ajax:callback function="on_getMasterXML">
         
         if( rowsNode.length > 0 ){
             // 입력부 비활성화
             setObject(true);
             //사후구분이 재고조정일때 발주일, 납품예정일, 마진적용일 달력컨트롤 사용막는다
             setCalImgDis(true);
             
             var sel = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
             var pumbuncd = rowsNode[0].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[1].childNodes[0].nodeValue;
             var pumbunNm = rowsNode[0].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[2].childNodes[0].nodeValue;
             var recpNm = rowsNode[0].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[3].childNodes[0].nodeValue;
             var sku_flag = rowsNode[0].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[4].childNodes[0].nodeValue;
             var rep_pumbuncd = rowsNode[0].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[5].childNodes[0].nodeValue;
             var sku_type = rowsNode[0].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[6].childNodes[0].nodeValue;
             var biz_type = rowsNode[0].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[7].childNodes[0].nodeValue;
             var tax_flag = rowsNode[0].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[8].childNodes[0].nodeValue;
             var char_buyercd = rowsNode[0].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[9].childNodes[0].nodeValue;
             var buyerNm = rowsNode[0].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[10].childNodes[0].nodeValue;
             var char_sm_cd = rowsNode[0].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[11].childNodes[0].nodeValue;
             var char_sm_name = rowsNode[0].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[12].childNodes[0].nodeValue;
             var vencd = rowsNode[0].childNodes[13].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[13].childNodes[0].nodeValue;
             var venNm = rowsNode[0].childNodes[14].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[14].childNodes[0].nodeValue;
             var style_type = rowsNode[0].childNodes[15].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[15].childNodes[0].nodeValue;
             var buyer_emp_Nm = rowsNode[0].childNodes[16].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[16].childNodes[0].nodeValue;
             g_tax_flag = tax_flag;
             
            if( tax_flag != "" ){
                for( i = 0; i < g_gs_gbn.length; i++ ){           //과세 구분 
                    if( g_gs_gbn[i] == tax_flag ){
                        strTaxFlag = tax_flag;
                        document.getElementById("IN_GS_GBN").value = tax_flag;
                        document.getElementById("IN_GS_GBN_NM").value = g_gs_gbn_nm[i];
                    }
                }
            }else {
                strTaxFlag = "";
                document.getElementById("IN_GS_GBN").value = "";
                document.getElementById("IN_GS_GBN_NM").value = "";
            }
            document.getElementById("IN_BIZ_TYPE").value = biz_type;
            document.getElementById("IN_BUYER_CD").value = char_buyercd;
            document.getElementById("IN_BUYER_NM").value = buyerNm;
            document.getElementById("HRS_CD").value = vencd;
            document.getElementById("HRS_NM").value = venNm;
            
            //협력사 반올림 구분
            getVenRound(strcd, vencd);
            
            // 저장시 다시 한번 브랜드의 존재여부를 확인하기 위해
            getMarginFlag();
            
            document.getElementById("IN_BJDATE").focus();
            
            
         } else {
             
             if( new_row == "3" ){
                 document.getElementById("IN_GS_GBN").value = "";
                 document.getElementById("IN_GS_GBN_NM").value = "";
                 document.getElementById("IN_BIZ_TYPE").value = "";
                 document.getElementById("IN_BUYER_CD").value = "";
                 document.getElementById("IN_BUYER_NM").value = "";
                 document.getElementById("HRS_CD").value = "";
                 document.getElementById("HRS_NM").value = "";
                 document.getElementById("IN_HS_GBN").length = 0;
                 document.getElementById("IN_HS_RATE").length = 0;
             }
             
             showMessage(INFORMATION, OK, "GAUCE-1000", "브랜드 정보가 존재 하지 않아 등록 할 수 없습니다.");
             
             document.getElementById("IN_HS_GBN").length = 0;
             document.getElementById("IN_HS_RATE").length = 0;
             
             document.getElementById("IN_PB_CD").focus();
            
             document.getElementById("IN_PB_CD").disabled = false;                 //브랜드 입력부
            
             return;
         }
     </ajax:callback>
     
     
}
 /**
  * getMarjinFlag()
  * 작 성 자 : 박래형
  * 작 성 일 : 2011-02-21
  * 개    요 :  마진적용일에 대한 행사구분 콤보로 조회
  * return값 : void
  */
function getMarginFlag(){
     // 조회조건 셋팅
     var strStrCd        = g_strcd;      //점
     var strPumbunCd     = document.getElementById("IN_PB_CD").value;          //브랜드
     var strMarginAppDt  = document.getElementById("IN_MAJINDATE").value;      //마진적용일
     
     var param = "&goTo=getMarginFlag&strcd="        + strStrCd
                                  + "&pumbuncd="     + strPumbunCd
                                  + "&marginAppdt="  + strMarginAppDt;
     
     <ajax:open callback="on_getMarginFlagXML" 
         param="param" 
         method="POST" 
         urlvalue="/edi/eord101.eo"/>
     
     <ajax:callback function="on_getMarginFlagXML">
     
     document.getElementById("IN_HS_GBN").length = 0;
     document.getElementById("IN_HS_RATE").length = 0;
     
         if( rowsNode.length > 0 ){
             var hs_gbn = document.getElementById("IN_HS_GBN");
             var opt = document.createElement("option");  
             opt.setAttribute("value", "");
             
             var text = document.createTextNode("");
             opt.appendChild(text);            
             hs_gbn.appendChild(opt);
             
             for( i = 0; i < rowsNode.length; i++ ){
                 g_hs_gbn[i] = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                 g_hs_gbn_nm[i] = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                 
                 var opt = document.createElement("option");  
                 opt.setAttribute("value", rowsNode[i].childNodes[0].childNodes[0].nodeValue);
                  
                 var text = document.createTextNode(rowsNode[i].childNodes[1].childNodes[0].nodeValue);
                 opt.appendChild(text);            
                 hs_gbn.appendChild(opt);
             }
             
              document.getElementById("IN_GS_GBN").disabled = false;     
         }else {
             
             var hs_gbn = document.getElementById("IN_HS_GBN");
             var opt = document.createElement("option");  
             opt.setAttribute("value", "");
             
             var text = document.createTextNode("");
             opt.appendChild(text);            
             hs_gbn.appendChild(opt);
             document.getElementById("IN_GS_GBN").disabled = true; 
         }
        
     </ajax:callback>
     
}

/**
 * getMarjinRate()
 * 작 성 자 : 박래형
 * 작 성 일 : 2011-02-21
 * 개    요 :  마진적용일에 대한 행사구분의행사율을 콤보로 조회
 * return값 : void
 */
function getMarginRate(){
    // 조회조건 셋팅
    var strStrCd        = g_strcd;      //점
    var strPumbunCd     = document.getElementById("IN_PB_CD").value;          //브랜드
    var strMarginAppDt  = getDateFormat(document.getElementById("IN_MAJINDATE").value);      //마진적용일
    var strMarginGbn    = document.getElementById("IN_HS_GBN").value;   //행사구분
    
    document.getElementById("IN_HS_RATE").length = 0;

    g_event_rate = "";
    g_event_rate_nm = "";
    norm_mg_rate = "";
    
    var param = "&goTo=getMarginRate" + "&strcd="          + strStrCd
                                      + "&pumbuncd="       + strPumbunCd
                                      + "&marginAppdt="    + strMarginAppDt
                                      + "&marginGbn="      + strMarginGbn;
    
    <ajax:open callback="on_getMarginRateXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/eord101.eo"/>
    
    <ajax:callback function="on_getMarginRateXML">
        
        if( rowsNode.length > 0 ){
                var hs_gbn_rate = document.getElementById("IN_HS_RATE");
            
                g_event_rate = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
                g_event_rate_nm = rowsNode[0].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[1].childNodes[0].nodeValue;
                norm_mg_rate = rowsNode[0].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[2].childNodes[0].nodeValue;
                
                var opt = document.createElement("option"); 
                opt.setAttribute("value", g_event_rate);
                var text = document.createTextNode(g_event_rate_nm);
                opt.appendChild(text);            
                hs_gbn_rate.appendChild(opt);
                
                document.getElementById("IN_HS_RATE").disabled = false;
            
        } else {
            var hs_gbn_rate = document.getElementById("IN_HS_RATE");
            var opt = document.createElement("option"); 
            opt.setAttribute("value", "");
            var text = document.createTextNode("");
            opt.appendChild(text);            
            hs_gbn_rate.appendChild(opt);
            
            document.getElementById("IN_HS_RATE").disabled = true;
        }
        
    </ajax:callback>

}


/**
 * onBjDateChage()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  발주일  변경시 
 * return값 : void
* 
*/

function onBjDateChage(){
 //   alert();
     var strBjDt = getRawData(trim( document.getElementById("IN_BJDATE").value ));             //발주일
     var strNpDt = getRawData(trim( document.getElementById("IN_NPYJDATE").value ));           //납품예정일
     var strMgDt = getRawData(trim( document.getElementById("IN_MAJINDATE").value ));          //마진적용일
        
     dateCheck( document.getElementById("IN_BJDATE") );
     
     if( strToday > strBjDt ){
         showMessage(INFORMATION, OK, "GAUCE-1000", "발주일은/는 금일 이후로 입력해야 합니다.");
         document.getElementById("IN_BJDATE").value = getDateFormat(strToday);
         document.getElementById("IN_NPYJDATE").value = addDate("d", 1, strToday);
         document.getElementById("IN_MAJINDATE").value = addDate("d", 1, strToday);
        
     } else {
         document.getElementById("IN_NPYJDATE").value = addDate("d", 1, strBjDt);
         document.getElementById("IN_MAJINDATE").value = addDate("d", 1, strBjDt);
     }

}

/**
 * onNpyjChage()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  납품예정일 변경시
 * return값 : void
* 
*/
function onNpyjChage(){
    
     var strBjDt = getRawData(trim( document.getElementById("IN_BJDATE").value ));             //발주일
     var strNpDt = getRawData(trim( document.getElementById("IN_NPYJDATE").value ));           //납품예정일
     var strMgDt = getRawData(trim( document.getElementById("IN_MAJINDATE").value ));          //마진적용일
     
     dateCheck( document.getElementById("IN_NPYJDATE") );
     
     if( strBjDt > strNpDt ){ 
         showMessage(INFORMATION, OK, "GAUCE-1000", "납품예정일은  발주일보다  크거나 같아야 합니다.");
         document.getElementById("IN_NPYJDATE").value = addDate("d", 1, strBjDt);
         document.getElementById("IN_MAJINDATE").value = getDateFormat(strNpDt);
            
     }
  //    document.getElementById("IN_MAJINDATE").value = getDateFormat(strNpDt);
     
}

/**
 * onMajinChage()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  마진적용일 변경시 
 * return값 : void
* 
*/

function onMajinChage(){
    var strBjDt = getRawData(trim( document.getElementById("IN_BJDATE").value ));             //발주일
    var strNpDt = getRawData(trim( document.getElementById("IN_NPYJDATE").value ));           //납품예정일
    var strMgDt = getRawData(trim( document.getElementById("IN_MAJINDATE").value ));          //마진적용일
    
    dateCheck( document.getElementById("IN_MAJINDATE") );
    
    if( strNpDt > strMgDt ){
        showMessage(INFORMATION, OK, "GAUCE-1000", "마진적용일은(는) 납품예정일보다  크거나 같아야 합니다.");
        document.getElementById("IN_MAJINDATE").value = getDateFormat(strNpDt);
        
    }
    if( document.getElementById("IN_PB_CD").value != ""  ) {
        document.getElementById("IN_HS_GBN").disabled = false;
        getMarginFlag();
    }
   
}

/**
 * onCostPrcChage(row)
 * 작 성 자 : DHL
 * 작 성 일 : 2012-06-11
 * 개    요 :  마진적용일 변경시 
 * parameter : rowid
 * return값 : void
* 
*/
function onCostPrcChg(row) {
	// alert("onCostPrcChg row : " + row);
    var cost_amt  = 0;                                                                             // 원가금액
    var sale_prc  = 0;                                                                             // 매가금액
    var ord_qty   = 0;
    var old_cost  = 0;
    var new_cost  = 0;
    var gap_cost  = 0;
    var row_cnt   = 0;
    var strTaxFlag = g_tax_flag;
    //alert("g_tax_flag : " + g_tax_flag);

    // 신규입력시  매가단가가 입력안되면 스킵
    // alert("onCostPrcChg new_row : " + new_row);
	// alert("onCostPrcChg detailRowCnt : " + detailRowCnt);
	row_cnt = detailRowCnt-1;
	// alert("onCostPrcChg row_cnt : " + row_cnt);
	
    if( new_row == "3" ){
    	sale_prc = parseInt(removeComma2(document.getElementById("d_new_sale_prc"+row).value));
    	// alert("onCostPrcChg sale_prc00 : " + sale_prc);
    	if (sale_prc == 0) {
    		// alert("onCostPrcChg sale_prc01 : " + sale_prc);
    		document.getElementById("d_new_sale_prc"+row).focus();
    		return true;
    	} else {
    		ord_qty = parseInt(removeComma2(document.getElementById("d_ord_qty"+row).value));          // 발주수량
    		new_cost = parseInt(removeComma2(document.getElementById("d_new_cost_prc"+row).value));    // 신규원가단가
    		old_cost = parseInt(removeComma2(document.getElementById("d_old_cost_prc"+row).value));    // 기존원가단가
    		// alert("onCostPrcChg old_cost00 : "+old_cost);
    		// alert("onCostPrcChg new_cost00 : "+new_cost);

    		if (new_cost != old_cost) {
    			
    			gap_cost = old_cost - new_cost;
    			// alert("onCostPrcChg gap_cost02 = "+gap_cost);
    	
    	    	if (Math.abs(gap_cost) != 1) 
    	    	{ 
    	    		showMessage(EXCLAMATION, OK, "USER-1000", "입력하신 매입 단가는 입력하신 단가와 1원이상 차이가 납니다.");
    	    		document.getElementById("d_new_cost_prc"+row).value = convAmt(String(old_cost));
	        		cost_amt = old_cost * ord_qty;
	        		document.getElementById("d_new_cost_amt"+row).value = convAmt(String(cost_amt));
    	    		document.getElementById("d_new_cost_prc"+row).focus();
    	    		// alert("onCostPrcChg old_cost01 : "+old_cost);
    	    		// alert("onCostPrcChg cost_amt01 : "+cost_amt);
    	    		return false;
    	    	} else {
	        		cost_amt = new_cost * ord_qty;
	        		document.getElementById("d_new_cost_amt"+row).value = convAmt(String(cost_amt));
	        		// alert("onCostPrcChg cost_amt00 : " + cost_amt);
	    			// document.getElementById("d_no"+row_cnt).focus();
	    			document.getElementById("d_pmksrt_cd"+row_cnt).focus();
	    			return true;
    	    	}
    		} else {
        		cost_amt = new_cost * ord_qty;
        		document.getElementById("d_new_cost_amt"+row).value = convAmt(String(cost_amt));
        		// alert("onCostPrcChg cost_amt02 : " + cost_amt);
    			// document.getElementById("d_pmksrt_cd"+row_cnt).focus();
    		}
    	}

        ord_qty = parseInt(removeComma2(document.getElementById("d_ord_qty"+row).value));          // 발주수량
    	new_cost = parseInt(removeComma2(document.getElementById("d_new_cost_prc"+row).value));    // 신규원가단가
    	// alert("onCostPrcChg d_old_cost_prc01 = "+removeComma2(document.getElementById("d_old_cost_prc"+row).value));
    	old_cost = parseInt(removeComma2(document.getElementById("d_old_cost_prc"+row).value));    // 기존원가단가
    	
    	// alert("onCostPrcChg old_cost01 = "+old_cost);
    	// alert("onCostPrcChg new_cost01 = "+new_cost);
    	
        ord_qty = parseInt(removeComma2(document.getElementById("d_ord_qty"+row_cnt).value));     // 발주수량
        // alert("onCostPrcChg ord_qty = " + ord_qty);
        if (ord_qty != 0) {
        	// alert("add_row Start -->");
        	add_row();
        	// alert("add_row  End <--");
        	// alert("onCostPrcChg sucess..!!" );
        } else {
        	document.getElementById("d_pmksrt_cd"+row_cnt).focus();
        }
    } else {
		ord_qty = parseInt(removeComma2(document.getElementById("d_ord_qty"+row).value));          // 발주수량
		new_cost = parseInt(removeComma2(document.getElementById("d_new_cost_prc"+row).value));    // 신규원가단가
		old_cost = parseInt(removeComma2(document.getElementById("d_old_cost_prc"+row).value));    // 기존원가단가
		// alert("onCostPrcChg old_cost00 : "+old_cost);
		// alert("onCostPrcChg new_cost00 : "+new_cost);

		if (new_cost != old_cost) {
			
			gap_cost = old_cost - new_cost;
			// alert("onCostPrcChg gap_cost02 = "+gap_cost);
	
	    	if (Math.abs(gap_cost) != 1) 
	    	{ 
	    		showMessage(EXCLAMATION, OK, "USER-1000", "입력하신 매입 단가는 입력하신 단가와 1원이상 차이가 납니다.");
	    		document.getElementById("d_new_cost_prc"+row).value = convAmt(String(old_cost));
        		cost_amt = old_cost * ord_qty;
        		document.getElementById("d_new_cost_amt"+row).value = convAmt(String(cost_amt));
	    		document.getElementById("d_new_cost_prc"+row).focus();
	    		// alert("onCostPrcChg old_cost01 : "+old_cost);
	    		// alert("onCostPrcChg cost_amt01 : "+cost_amt);
	    		return false;
	    	} else {
        		cost_amt = new_cost * ord_qty;
        		document.getElementById("d_new_cost_amt"+row).value = convAmt(String(cost_amt));
        		// alert("onCostPrcChg cost_amt00 : " + cost_amt);
    			// document.getElementById("d_pmksrt_cd"+row_cnt).focus();
	    	}
		} else {
    		cost_amt = new_cost * ord_qty;
    		document.getElementById("d_new_cost_amt"+row).value = convAmt(String(cost_amt));
    		// alert("onCostPrcChg cost_amt02 : " + cost_amt);
			// document.getElementById("d_pmksrt_cd"+row_cnt).focus();
		}
		
		/*
		// 20120614 * DHL *  행추가로직 -->
        ord_qty = parseInt(removeComma2(document.getElementById("d_ord_qty"+row).value));          // 발주수량
    	new_cost = parseInt(removeComma2(document.getElementById("d_new_cost_prc"+row).value));    // 신규원가단가
    	// alert("onCostPrcChg d_old_cost_prc01 = "+removeComma2(document.getElementById("d_old_cost_prc"+row).value));
    	old_cost = parseInt(removeComma2(document.getElementById("d_old_cost_prc"+row).value));    // 기존원가단가
    	
    	// alert("onCostPrcChg old_cost01 = "+old_cost);
    	// alert("onCostPrcChg new_cost01 = "+new_cost);
    	
        ord_qty = parseInt(removeComma2(document.getElementById("d_ord_qty"+row_cnt).value));          // 발주수량
        // alert("onCostPrcChg ord_qty = " + ord_qty);
        if (ord_qty != 0) {
        	// alert("add_row Start -->");
        	add_row();
        	// alert("add_row  End <--");
        	// alert("onCostPrcChg sucess..!!" );
        } else {
        	document.getElementById("d_pmksrt_cd"+row_cnt).focus();
        }
        // 20120614 * DHL * 행추가로직 <--
        */
    }

 }


 /**
  * checkValidation()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  저장시 유효성체크
  * return값 : void
 * 
 */

 function checkValidation(gbun){
     
     if( gbun == "Save" ){       
         if(document.getElementById("IN_PB_CD").value == "" ){                                       // 브랜드
             showMessage(INFORMATION, OK, "USER-1003", "브랜드");
             document.getElementById("IN_PB_CD").focus();
             return false;                                                      
         }
         if(document.getElementById("IN_BJDATE").value == "" ){                                       // 발주일
             showMessage(INFORMATION, OK, "USER-1003", "발주일");
             document.getElementById("IN_BJDATE").focus();
             return false;                                                      
         }
         
         if(document.getElementById("IN_NPYJDATE").value == "" ){                                       // 납품예정일
             showMessage(INFORMATION, OK, "USER-1003", "납품예정일");
             document.getElementById("IN_NPYJDATE").focus();
             return false;                                                      
         }
         if(document.getElementById("IN_MAJINDATE").value == "" ){                                       // 점
             showMessage(INFORMATION, OK, "USER-1003", "마진적용일");
             document.getElementById("IN_MAJINDATE").focus();
             return false;                                                      
         }
          
       	 if (document.getElementById("IN_NPYJDATE").value > document.getElementById("IN_MAJINDATE").value) {  
       	        showMessage(StopSign, OK, "USER-1008", "마진적용일", "납품예정일");
       	        document.getElementById("IN_MAJINDATE").focus();
       	        return;
       	    }
         
         if(document.getElementById("IN_HS_GBN").value == "" ){                                       // 점
             showMessage(INFORMATION, OK, "USER-1003", "행사구분");
             document.getElementById("IN_HS_GBN").focus();
             return false;                                                      
         }
         if(document.getElementById("IN_HS_RATE").value == "" ){                                       // 점
             showMessage(INFORMATION, OK, "USER-1003", "행사율");
             document.getElementById("IN_HS_RATE").focus();
             return false;                                                      
         }
         
         var tb_detail = document.getElementById("tb_detail");
         var tr_cnt = tb_detail.rows.length;
         
         //alert("tr_cnt : " + tr_cnt);
         if( tr_cnt > 0 ){
             
             var j = 0;
             var PmkSrtCds   = document.getElementsByName("d_pmksrt_cd");
             var PumMokCds   = document.getElementsByName("d_pummok_cd");
             var intQty      = document.getElementsByName("d_ord_qty");
             var intNewSalePrc = document.getElementsByName("d_new_sale_prc");
             
             for( i = 0; i < PmkSrtCds.length; i++ ){
                 j = i;
                 if( PmkSrtCds[i].value == "" ){
                     showMessage(INFORMATION, OK, "USER-1003", "단축코드");
                     document.getElementsByName("d_pmksrt_cd")[i].focus();
                     return false;
                 }
                 if(intQty[i].value <= 0 || intQty[i].value == "" ){
	                 showMessage(INFORMATION, OK, "USER-1003", "수량");
	                 document.getElementsByName("d_ord_qty")[i].focus();
	                 return false;
                 }
            
	             if( intNewSalePrc[i].value <= 0 || intNewSalePrc[i].value == "" ){
	                 showMessage(INFORMATION, OK, "USER-1003", "매가단가");
	                 document.getElementsByName("d_new_sale_prc")[i].focus();
	                 return false;
	             }

             }
             
             /*
             for( i = 0; i < PumMokCds.length; i++ ){
                 j = i;
                 if( PumMokCds[i].value == "" ){
                     showMessage(INFORMATION, OK, "USER-1003", "품목코드");
                     document.getElementsByName("d_pummok_cd")[i].focus();
                     return false;
                 }
             */
                 /*//유효 품목 체크
                 if( !getpummokCh( i ) ){
                     i = j;
                      alert("유효하지 않는 품목코드 입니다. \n확인 바랍니다.");
                      document.getElementsByName("d_pummok_cd")[i].focus();
                      return false;
                 } 
                 i = j;  
                 */
                 
              /*   if(intQty[i].value <= 0 || intQty[i].value == "" ){
                     showMessage(INFORMATION, OK, "USER-1003", "수량");
                     document.getElementsByName("d_ord_qty")[i].focus();
                     return false;
                  }*/
                
               /*  if( intNewSalePrc[i].value <= 0 || intNewSalePrc[i].value == "" ){
                     showMessage(INFORMATION, OK, "USER-1003", "매가단가");
                     document.getElementsByName("d_new_sale_prc")[i].focus();
                     return false;
                 }*/
                 
             //}
         }
         
     } else if(gbun == "Delete"){
         
         
         /*
         
         
         
         if( list_slip_proc_stat == "00" ){
             alert("확정된 발주전표는 삭제 할 수 없습니다.");
             return false;
         }
         */
         
         if(reg_rate != strToday){
             showMessage(StopSign, OK, "GAUCE-1000", "당일 등록건만 삭제할 수 있습니다.");
             return false;
         }
         
         return true; 
         
         
     }
     return true;
}
 
 /**
  * setObject()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  활성화, 비활성화 
  * return값 : void
  */ 
 function setObject( falg ){
      
     if( !falg ){
         document.getElementsByName("IN_SLIP_FLAG")[0].disabled = true;       //전표구분1
         document.getElementsByName("IN_SLIP_FLAG")[1].disabled = true;       //전표구분2
         document.getElementById("IN_PB_CD").disabled = true;                 //브랜드 입력부
         document.getElementById("IN_BJDATE").disabled = true;                //발주일
         //document.getElementById("IN_BJDATE").style.backgroundColor = "#dcdcdc";
         document.getElementById("IN_NPYJDATE").disabled = true;            //납품예정일
         //document.getElementById("IN_NPYJDATE").style.backgroundColor = "#dcdcdc";
         document.getElementById("IN_MAJINDATE").disabled = true;           //마진적용일
         //document.getElementById("IN_MAJINDATE").style.backgroundColor = "#dcdcdc";
         document.getElementById("IN_HS_GBN").disabled = true;              //행사구분
         //document.getElementById("IN_HS_GBN").style.backgroundColor = "#dcdcdc";
         document.getElementById("IN_HS_RATE").disabled = true;             //행사율
         //document.getElementById("IN_HS_RATE").style.backgroundColor = "#dcdcdc";
         document.getElementById("IN_ETC").disabled = true;                 //비고
         //document.getElementById("IN_ETC").style.backgroundColor = "#dcdcdc";
         
     } else {
         document.getElementsByName("IN_SLIP_FLAG")[0].disabled = false;       //전표구분1
         document.getElementsByName("IN_SLIP_FLAG")[1].disabled = false;       //전표구분2
         document.getElementById("IN_PB_CD").disabled = false;                 //브랜드 입력부
         document.getElementById("IN_BJDATE").disabled = false;                //발주일
         //document.getElementById("IN_BJDATE").style.backgroundColor = "#ffffff";
         document.getElementById("IN_NPYJDATE").disabled = false;            //납품예정일
         //document.getElementById("IN_NPYJDATE").style.backgroundColor = "#ffffff";
         document.getElementById("IN_MAJINDATE").disabled = false;           //마진적용일
         //document.getElementById("IN_MAJINDATE").style.backgroundColor = "#ffffff";
         document.getElementById("IN_HS_GBN").disabled = false;              //행사구분
         //document.getElementById("IN_HS_GBN").style.backgroundColor = "#ffffff";
         document.getElementById("IN_HS_RATE").disabled = false;             //행사율
         //document.getElementById("IN_HS_RATE").style.backgroundColor = "#ffffff";
         document.getElementById("IN_ETC").disabled = false;                 //비고
         //document.getElementById("IN_ETC").style.backgroundColor = "#ffffff";
     }
     
 }
  

 /**
  * setCalImgDis()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  이미지 활성화, 비활성화 
  * return값 : void
  */ 
 function setCalImgDis(falg){
     if( !falg ){
         enableControl(IMG_BJDATE, false);
         enableControl(IMG_NPYJDATE, false);
         enableControl(IMG_MAJINDATE, false);
     } else {
         enableControl(IMG_BJDATE, true);
         enableControl(IMG_NPYJDATE, true);
         enableControl(IMG_MAJINDATE, true);
     }
 }
  
/**
 * getVenRound()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  반올림 구분 
 * return값 : void
 */   
function getVenRound( strcd, ven_cd){
        var returnRound = "";
        if( ven_cd != ""){
            
            var param = "&goTo=getVenRoundFlag" + "&strcd=" + strcd
                                                + "&ven_cd=" + ven_cd;
            
            <ajax:open callback="on_getVenRoundFlagXML" 
                param="param" 
                method="POST" 
                urlvalue="/edi/eord101.eo"/>
            
         <ajax:callback function="on_getVenRoundFlagXML">
         
             if( rowsNode.length > 0 ){   
                    roundFlag = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
             } else {
                 roundFlag = "";
             }    
         </ajax:callback>
            
        }
        
}  
/**
 * row_delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  행삭제
 * return값 : void
*/ 
function  row_delete(){
    
    var tb_detail = document.getElementById("tb_detail");
    var tr_cnt = tb_detail.rows.length;
    var check_cnt = 0;
    
    if( tr_cnt < 1 ){
        showMessage(StopSign, OK, "USER-1019");
        return;
    }
    
    for(j = 0; j < document.getElementsByName("d_check1").length; j++){
        if( document.getElementsByName("d_check1")[j].checked == true ){
            check_cnt++;
        }
    }
    
    if( check_cnt < 1 ){
        showMessage(INFORMATION, OK, "GAUCE-1000","하나 이상  선택하신 후 삭제를 진행하여 주세요");
        return;
    }
    // for( i = 0; i < document.getElementsByName("d_check1").length; i++ )
    
    for( i = 0; i < document.getElementsByName("d_check1").length; i++ ) {  
    	//alert(i);
        if( document.getElementsByName("d_check1")[i].checked == true ){
        //  alert(i); 
        //	var strStatus = document.getElementsByName("d_no")[i].value; 
        //	alert(strStatus-1);
        	tb_detail.deleteRow(i); 
            calDetail2("D");
            detailRowCnt--;
            i--;
        } 
    }
    no_count();

    var tr_cnt_d = tb_detail.rows.length;
 
    
    if(tr_cnt_d == 0) { 
        add_del_row( true ); 
    }  
    else { 
        add_del_row( false ); 
    }
}

/**
 * no_count()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  행삭제시 no 재 정렬 
 * return값 : void
 */ 
function no_count() { 
     var cnt = 0;
	for( i = 0; i < document.getElementsByName("d_no").length; i++ ){ 
		//alert(i); 
		cnt = cnt + 1;  
		document.getElementsByName("d_no")[i].value = cnt;
		
	} 
}

/**
 * getPbnPmkPop()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  품목코드 
 * return값 : void
 */ 
function getPbnPmkPop( row ){
    
    var strPummokcd = document.getElementById("d_pummok_cd"+row).value;
    var strPumbuncd = document.getElementById("IN_PB_CD").value;
     
    var rtnList = pbnPmkMultiSelPop(strPummokcd, "", strPumbuncd, "", "", "N");
    
     if(rtnList != null){ 
         var returnList = rtnList;
         
         if( returnList.length == 1 ){
            var returnValue =  returnList[0].split(":");
            
            document.getElementById("d_pummok_cd"+row).value = returnValue[0];
            document.getElementById("d_pummok_nm"+row).value = returnValue[1];
            document.getElementById("d_ord_unit_cd"+row).value = returnValue[2];
            document.getElementById("d_tag_flag"+row).value = returnValue[3];
            document.getElementById("d_tag_prt_own_flag"+row).value = returnValue[4];

            document.getElementById("d_ord_qty"+row).focus();
         }
         
     }
     else { 
    	 var strPummock_len =document.getElementById("d_pummok_cd"+row).value;
    	 //alert(strPummock_len.length);
         if(strPummock_len.length < 8) {
        	 document.getElementById("d_pummok_cd"+row).value = "";
             document.getElementById("d_pummok_nm"+row).value = "";
             document.getElementById("d_ord_unit_cd"+row).value = "0";
             document.getElementById("d_tag_flag"+row).value = "";
             document.getElementById("d_tag_prt_own_flag"+row).value = ""; 

             document.getElementById("d_pummok_cd"+row).focus();
             
         } 
     }
}

/**
 * pbnPmkMultiSelPop()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  품목  팝업
 * return값 : void
 */ 
 
function pbnPmkMultiSelPop(strPummokcd, pummokNm, strPumbuncd){
    
    var rtnList  = new Array();
    var arrArg  = new Array();
    

    arrArg.push(rtnList);
    arrArg.push(strPummokcd);
    arrArg.push(strPumbuncd);
    arrArg.push("M");
    

       var returnVal = window.showModalDialog("/edi/ccom010.cc?goTo=pbnPmkPop",
                                              arrArg,
                                              "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                              "resizable:no;help:no;unadorned:yes;center:yes;status:no");
        
       if (returnVal){
           
           return arrArg[0];
       }
       return null;
}
 
/**
 * pummokBlur()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  품목  항목에서 포커스가 나갔을때 
 * return값 : void
 */ 
function pummokBlur(row){
    var strPumbuncd = document.getElementById("IN_PB_CD").value;
    var strPummokCd  = document.getElementById("d_pummok_cd"+row).value; //품목코드
    
    if( strPumbuncd == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "브랜드");
        document.getElementById("IN_PB_CD").focus();
        return;
    }
    
    if( strPummokCd.length != 8 ){
    //	document.getElementById("d_pummok_cd"+row).value = "";
        document.getElementById("d_pummok_nm"+row).value = "";
        document.getElementById("d_ord_unit_cd"+row).value = "0";
        document.getElementById("d_tag_flag"+row).value = "";
        document.getElementById("d_tag_prt_own_flag"+row).value = ""; 

     //   document.getElementById("d_pummok_cd"+row).focus();
        return;
    }
    if( strPummokCd == ""){
        showMessage(INFORMATION, OK, "USER-1003", "품목");
        document.getElementById("d_pummok_cd"+row).focus();
        return;
    }
  /*  if( strPummokCd.length < 8 ){
        showMessage(StopSign, OK, "USER-1047", "8");
        document.getElementById("d_pummok_cd"+row).focus();
        return;
    }
    */
    
    var param = "&goTo=getPummokBlur" + "&strPumbuncd=" + strPumbuncd
                                      + "&strPummokCd=" + strPummokCd;

    <ajax:open callback="on_getPummokBlurXML" 
                        param="param" 
                        method="POST" 
                        urlvalue="/edi/ccom010.cc"/>
    
    <ajax:callback function="on_getPummokBlurXML">
       
       if( rowsNode.length < 1 ){
    	   getPbnPmkPop(row);
          /* showMessage(INFORMATION, OK, "GAUCE-1000", "일치 하는 브랜드이 없습니다.");
           document.getElementById("d_pummok_cd"+row).value = "";
           document.getElementById("d_pummok_nm"+row).value = "";
           document.getElementById("d_ord_unit_cd"+row).value = "0";
           document.getElementById("d_tag_flag"+row).value = "";
           document.getElementById("d_tag_prt_own_flag"+row).value = "";
           document.getElementById("d_pummok_cd"+row).focus();
           return;*/
           
       } else {
        
           document.getElementById("d_pummok_cd"+row).value = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
           document.getElementById("d_pummok_nm"+row).value = rowsNode[0].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[1].childNodes[0].nodeValue;
           document.getElementById("d_ord_unit_cd"+row).value = rowsNode[0].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[2].childNodes[0].nodeValue;
           document.getElementById("d_tag_flag"+row).value = rowsNode[0].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[3].childNodes[0].nodeValue;
           document.getElementById("d_tag_prt_own_flag"+row).value = rowsNode[0].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[4].childNodes[0].nodeValue;
           
       }
       
    </ajax:callback>
}

/**
 * getPbnPmkSrtPop()
 * 작 성 자 : DHL
 * 작 성 일 : 2012-06-08
 * 개    요 :  품목단축코드 
 * return값 : void
 */ 
function getPbnPmkSrtPop( row ){
    
    var strPmkSrtcd = document.getElementById("d_pmksrt_cd"+row).value;
    var strPumbuncd = document.getElementById("IN_PB_CD").value;
     
    var rtnList = pbnPmkSrtMultiSelPop(strPmkSrtcd, "", strPumbuncd); //, "", "", "N");
    
     if(rtnList != null){ 
         var returnList = rtnList;
         
         if( returnList.length == 1 ){
            var returnValue =  returnList[0].split(":");
            
            document.getElementById("d_pmksrt_cd"+row).value = returnValue[0];
            document.getElementById("d_pummok_cd"+row).value = returnValue[1];
            document.getElementById("d_pummok_nm"+row).value = returnValue[2];
            document.getElementById("d_ord_unit_cd"+row).value = returnValue[3];
            document.getElementById("d_tag_flag"+row).value = returnValue[4];
            document.getElementById("d_tag_prt_own_flag"+row).value = returnValue[5];

            document.getElementById("d_ord_qty"+row).focus();
         }
         
     }
     else { 
    	 var strPmkSrt_len =document.getElementById("d_pmksrt_cd"+row).value;
    	 //alert(strPummock_len.length);
         if(strPmkSrt_len.length < 4) {
        	 document.getElementById("d_pummok_cd"+row).value = "";
             document.getElementById("d_pummok_nm"+row).value = "";
             document.getElementById("d_ord_unit_cd"+row).value = "0";
             document.getElementById("d_tag_flag"+row).value = "";
             document.getElementById("d_tag_prt_own_flag"+row).value = ""; 

             document.getElementById("d_pmksrt_cd"+row).focus();
             
         } 
     }
}

/**
 * pbnPmkSrtMultiSelPop()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  품목  팝업
 * return값 : void
 */ 
 
function pbnPmkSrtMultiSelPop(strPmkSrtcd, pummokNm, strPumbuncd){
    
    var rtnList  = new Array();
    var arrArg  = new Array();
    

    arrArg.push(rtnList);
    arrArg.push(strPmkSrtcd);
    arrArg.push(strPumbuncd);
    arrArg.push("M");
    
    //alert("strPmkSrtcd="+strPmkSrtcd+ " strPumbuncd="+strPumbuncd);

    var returnVal = window.showModalDialog("/edi/ccom222.cc?goTo=pbnPmkSrtPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
    if (returnVal){
        
        return arrArg[0];
    }
    return null;
}
 
/**
 * pmkSrtBlur()
 * 작 성 자 : DHL
 * 작 성 일 : 2011-04-18
 * 개    요 :  품목 단축코드 항목에서 포커스가 나갔을때 
 * return값 : void
 */ 
function pmkSrtBlur(row){
    var strPumbuncd = document.getElementById("IN_PB_CD").value;
    var strPmkSrtcd = document.getElementById("d_pmksrt_cd"+row).value; //품목단축코드
    
    if( strPumbuncd == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "브랜드");
        document.getElementById("IN_PB_CD").focus();
        return;
    }
    
    if( strPmkSrtCd.length != 4 ){
        document.getElementById("d_pummok_cd"+row).value = "";
        document.getElementById("d_pummok_nm"+row).value = "";
        document.getElementById("d_ord_unit_cd"+row).value = "0";
        document.getElementById("d_tag_flag"+row).value = "";
        document.getElementById("d_tag_prt_own_flag"+row).value = ""; 

     //   document.getElementById("d_pummok_cd"+row).focus();
        return;
    }
    if( strPmkSrtCd == ""){
        showMessage(INFORMATION, OK, "USER-1003", "단축코드");
        document.getElementById("d_pmksrt_cd"+row).focus();
        return;
    }
  /*  if( strPummokCd.length < 8 ){
        showMessage(StopSign, OK, "USER-1047", "8");
        document.getElementById("d_pummok_cd"+row).focus();
        return;
    }
    */
    
    var param = "&goTo=getPmkSrtBlur" + "&strPmkSrtcd=" + strPmkSrtcd
                                      + "&strPumbuncd=" + strPumbuncd ;

    <ajax:open callback="on_getPmkSrtBlurXML" 
                        param="param" 
                        method="POST" 
                        urlvalue="/edi/ccom222.cc"/>
    
    <ajax:callback function="on_getPmkSrtBlurXML">
       
       if( rowsNode.length < 1 ){
    	   getPbnPmkSrtPop(row);
          /* showMessage(INFORMATION, OK, "GAUCE-1000", "일치 하는 브랜드이 없습니다.");
           document.getElementById("d_pummok_cd"+row).value = "";
           document.getElementById("d_pummok_nm"+row).value = "";
           document.getElementById("d_ord_unit_cd"+row).value = "0";
           document.getElementById("d_tag_flag"+row).value = "";
           document.getElementById("d_tag_prt_own_flag"+row).value = "";
           document.getElementById("d_pummok_cd"+row).focus();
           return;*/
           
       } else {
        
           document.getElementById("d_pmksrt_cd"+row).value = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
           document.getElementById("d_pummok_cd"+row).value = rowsNode[0].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[1].childNodes[0].nodeValue;
           document.getElementById("d_pummok_nm"+row).value = rowsNode[0].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[2].childNodes[0].nodeValue;
           document.getElementById("d_ord_unit_cd"+row).value = rowsNode[0].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[3].childNodes[0].nodeValue;
           document.getElementById("d_tag_flag"+row).value = rowsNode[0].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[4].childNodes[0].nodeValue;
           document.getElementById("d_tag_prt_own_flag"+row).value = rowsNode[0].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[5].childNodes[0].nodeValue;
           
       }
       
    </ajax:callback>
}

function scrollAll(){
    document.all.DivListTitle.scrollLeft = document.all.DivListContent.scrollLeft;
}
function scrollAll2(){
    document.all.DETAIL_Title.scrollLeft = document.all.DETAIL_CONTETN.scrollLeft;
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
        for(i=1;i<6;i++) {
        	 
            document.getElementById(i+"listtdId"+val).style.backgroundColor="#fff56E";
    //       alert(g_pre_row);
            if (g_pre_row != -1) {
                document.getElementById(i+"listtdId"+g_pre_row).style.backgroundColor="#ffffff";
            }
        }
    }
    g_pre_row = g_last_row;
}


/**
 * chkSlipProdStat()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  마스터 조회 - 처음 조회시 사용
 * return값 : void
 */ 
function chkSlipProdStat(){
    var strcd      = gl_strcd;
    var strSlip_no = gl_slip_no;
    var slip_proc_stat = "";
    
    var param = "&goTo=chkSlipProdStat&strcd="             + strcd
                                   + "&strSlip_no="        + strSlip_no;

	var Urleren = "/edi/eord101.eo"; 
	URL = Urleren + "?" +param; 
	strPro = getXMLHttpRequest(); 
	strPro.onreadystatechange = responseProc;
	strPro.open("POST", URL, false); 
	strPro.send(null);
  
}

/**
 * responseProc()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  마스터 조회 시 조회 그리드에 데이터 넣기
 * return값 : void
 */ 
function responseProc()
{
     if(strPro.readyState==4)
     {
          if(strPro.status == 200)
          {
        	  strPro = eval(strPro.responseText); 
              
        	  slip_proc_stat_save = strPro[0].SLIP_PROC_STAT; 
          } 
     }
}


</script>

</head>
<body class="PL10 PT15" onload="doinit();">
<table width="97%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="396" class="title"><img
					src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13"
					align="absmiddle" class="PR05" /> EDI 발주등록</td>
				<td>
				<table border="0" align="right" cellpadding="0" cellspacing="0">
					<tr>
						<td><img src="/edi/imgs/btn/search.gif" width="50"
							height="22" id="search" onclick="btn_Search();" /></td>
						<td><img src="/edi/imgs/btn/new.gif" width="50" height="22"
							id="newrow" onclick="btn_new();" /></td>
						<td><img src="/edi/imgs/btn/del.gif" width="50" height="22"
							id="del" onclick="btn_delete();" /></td>
						<td><img src="/edi/imgs/btn/save.gif" width="50" height="22"
							id="save" onclick="btn_save();" /></td>
						<td><img src="/edi/imgs/btn/excel.gif" width="61" height="22"
							id="excel" /></td>
						<td><img src="/edi/imgs/btn/print.gif" width="50" height="22"
							id="prints" /></td>
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
						<th width="80" class="point">점</th>
						<td width="140"><input type="text" name="strnm" id="strnm"
							size="20" maxlength="10" value="<%=strNm%>" disabled="disabled" /><input
							type="hidden" name="strcd" id="strcd" value="<%=strcd%>"></td>
						<th width="80" class="point input_pk">협력사코드</th>
						<td width="140"><input type="hidden" name="vencd" id="vencd"
							value="<%=vencd%>" disabled="disabled" /> <input type="text"
							name="venNM" id="venNM" size="20" value="<%=venNm%>"
							disabled="disabled" /></td>
						<th>브랜드코드</th>
						<td><select name="pubumCd" id="pubumCd" style="width: 193;">

						</select></td>
					</tr>
					<tr>
						<th width="80">전표상태</th>
						<td width="140"><!--  <input type="text"  name="strnm" id="strnm" size="30" maxlength="10" value="" disabled="disabled" />-->
						<select name="Sel_slip_proc_falg" id="Sel_slip_proc_falg"
							style="width: 132;"> <input type="hidden" name="slip_no_new" id="slip_no_new" >
						</select></td>
						<th width="80">기준일</th>
						<td width="140"><select name="gjDate" id="gjDate"
							style="width: 132;">
						</select></td>
						<th width="80">기간</th>
						<td><input type="text" name="em_S_Date" id="em_S_Date"
							size="10" title="YYYY/MM/DD" value="" maxlength="10"
							onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);"
							onfocus="dateValid(this);"
							style='text-align: center; IME-MODE: disabled' /> <img
							src="<%=dir%>/imgs/icon/ico_calender.gif" alt="시작일"
							align="absmiddle" onclick="openCal('G',em_S_Date);return false;" />
						~ <input type="text" name="em_E_Date" id="em_E_Date" size="10"
							maxlength="10" value="" onkeypress="javascript:onlyNumber();"
							onblur="dateCheck(this);" onfocus="dateValid(this);"
							style='text-align: center; IME-MODE: disabled' /> <img
							src="<%=dir%>/imgs/icon/ico_calender.gif" alt="시작일"
							align="absmiddle" onclick="openCal('G',em_E_Date);return false;" />
						</td>
					</tr>
					<tr>
						<th width="80">전표구분</th>
						<td colspan="5"><input type="radio" name="Sel_slip_falg"
							id="Sel_slip_falg" value="%" checked="checked" /> 전체 <input
							type="radio" name="Sel_slip_falg" id="Sel_slip_falg" value="A" />
						매입 <input type="radio" name="Sel_slip_falg" id="Sel_slip_falg"
							value="B" /> 반품</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>

	<tr>
		<td class="dot"></td>
	</tr>

	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td width="250">
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="BD4A">
					<tr valign="top">
						<td>
						<div id="DivListTitle" style="width: 250; overflow: hidden;">
						<table width="400" border="0" cellpadding="0" cellspacing="0"
							class="g_table">
							<tr>
								<th width="75">점</th>
								<th width="40">구분</th>
								<th width="90">전표번호</th>
								<th width="75">발주일</th>
								<th width="65">전표상태</th>
								<th width="15">&nbsp;</th>
							</tr>
						</table>
						</div>
						</td>
					</tr>
					<tr>
						<td>
						<div id="DivListContent"
							style="width: 250px; height: 438px; overflow: scroll"
							onscroll="scrollAll();">
						<table width="380" border="0" cellspacing="0" cellpadding="0"
							class="g_table" id="tb_list">

						</table>
						</div>
						</td>
					</tr>
				</table>
				</td>
				<td class="PL05">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="PB03">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0"
									class="s_table">
									<tr>
										<input type="hidden" name="IN_STR_CD" id="IN_STR_CD" />
										<input type="hidden" name="IN_SLIP_NO" id="IN_SLIP_NO" />
										<input type="hidden" name="IN_GAP_TOT_AMT" id="IN_GAP_TOT_AMT" />
										<!-- 차익액합-->
										<input type="hidden" name="IN_NEW_GAP_RATE"
											id="IN_NEW_GAP_RATE" />
										<!-- 차익율-->
										<input type="hidden" name="IN_VAT_TAMT" id="IN_VAT_TAMT" />
										<!-- 부가세 -->
										<input type="hidden" name="IN_BIZ_TYPE" id="IN_BIZ_TYPE" />
										<!-- biz_type -->

										<th width="75" class="point">전표구분</th>
										<td width="100"><input type="radio" name="IN_SLIP_FLAG"
											id="IN_SLIP_FLAG" value="A" checked="checked" /> 매입 <input
											type="radio" name="IN_SLIP_FLAG" id="IN_SLIP_FLAG" value="B" />
										반품</td>
										<th width="75" class="point">사후구분</th>
										<td width="95"><input type="text" name="IN_SH_GBN_NM"
											id="IN_SH_GBN_NM" size="13" class="input_pk"
											disabled="disabled" value="사전전표" /><input type="hidden"
											name="IN_SH_GBN" id="IN_SH_GBN" value="0" /></td>
										<th width="75" class="point">브랜드</th>
										<td><select name="IN_PB_CD" id="IN_PB_CD"
											class="combo_pk" onchange="getpumbunGbBu();"
											style="width: 72;">
										</select> <!--  <input name="IN_PB_CD" id="IN_PB_CD" size="2"/> --></td>
									</tr>
									<tr>
										<th>발주주체</th>
										<td><input type="hidden" name="IN_BALJUJC"
											id="IN_BALJUJC" size="10" value="1" /><input type="text"
											name="ord_own_falg_nm" id="ord_own_falg_nm"
											disabled="disabled" size="14" value="EDI발주" /></td>
										<th class="point">발주일</th>
										<td><input type="text" name="IN_BJDATE" id="IN_BJDATE"
											size="10" maxlength="10"
											onkeypress="javascript:onlyNumber();"
											onblur="onBjDateChage();" onfocus="dateValid(this);"
											style='text-align: center; IME-MODE: disabled' /> <img
											src="<%=dir%>/imgs/icon/ico_calender.gif" id="IMG_BJDATE"
											alt="발주일" align="absmiddle"
											onclick="openCal('G',IN_BJDATE);return false;" /></td>
										<th>발주확정일</th>
										<td><input name="IN_BJHJDATE" id="IN_BJHJDATE" size="10"
											disabled="disabled" /></td>
									</tr>
									<tr>
										<th>협력사</th>
										<td><input type="hidden" name="HRS_CD" id="HRS_CD" /><input
											type="text" name="HRS_NM" id="HRS_NM" size="14"
											disabled="disabled" /></td>
										<th>과세구분</th>
										<td colspan="3"><input type="hidden" name="IN_GS_GBN"
											id="IN_GS_GBN" size="8" /><input type="text"
											name="IN_GS_GBN_NM" id="IN_GS_GBN_NM" size="14"
											disabled="disabled" /></td>
									</tr>
									<tr>
										<th class="point">납품예정일</th>
										<td><input type="text" name="IN_NPYJDATE"
											id="IN_NPYJDATE" class="input_pk" size="11" maxlength="10"
											onkeypress="javascript:onlyNumber();" onblur="onNpyjChage();"
											onfocus="dateValid(this);"
											style='text-align: center; IME-MODE: disabled' /> <img
											src="<%=dir%>/imgs/icon/ico_calender.gif" id="IMG_NPYJDATE"
											alt="납품예정일" align="absmiddle"  
											onclick="openCal('G',IN_NPYJDATE);return false;" /></td>
										<th>바이어</th>
										<td colspan="3"><input type="text" name="IN_BUYER_CD"
											id="IN_BUYER_CD" size="8" disabled="disabled" /> <input
											type="text" name="IN_BUYER_NM" id="IN_BUYER_NM" size="10"
											disabled="disabled" /></td>
									</tr>
									<tr>
										<th class="point">마진적용일</th>
										<td><input type="text" name="IN_MAJINDATE"
											id="IN_MAJINDATE" class="input_pk" size="11" maxlength="10"
											onkeypress="javascript:onlyNumber();"
											onblur="onMajinChage();" onfocus="dateValid(this);"
											style='text-align: center; IME-MODE: disabled;' /> <img
											src="<%=dir%>/imgs/icon/ico_calender.gif" id="IMG_MAJINDATE"
											alt="마진적용일" align="absmiddle" 
											onclick="openCal('G',IN_MAJINDATE);return false;" /></td>
										<th class="point">행사구분 /<br> 행사율</th>
										<td colspan="3"><select name="IN_HS_GBN" class="combo_pk"
											id="IN_HS_GBN" style="width: 60" onchange="getMarginRate();">
										</select> <select name="IN_HS_RATE" class="combo_pk" id="IN_HS_RATE"
											style="width: 70">
										</select></td>

									</tr>
									<tr>
										<th>검품확정일</th>
										<td colspan="5"><input type="text" name="IN_GPWJ_DATE"
											id="IN_GPWJ_DATE" size="14" disabled="disabled" /></td>
										<!-- 
										<th>부가세</th>
										<td><input type="hidden" size="14" id="IN_VAT"
											name="IN_VAT" style="text-align: right;" disabled="disabled" />
										</td>
										 -->
									</tr>
									<tr>
										<th>수량계</th>
										<td><input type="text" name="IN_SRG" id="IN_SRG"
											size="14" style="text-align: right;" disabled="disabled">
										</td>
										<th>원가계</th>
										<td><input type="text" size="14" id="IN_WGG"
											name="IN_WGG" style="text-align: right;" disabled="disabled" />
										</td>
										<th>매가계</th>
										<td><input type="text" name="IN_MGG"
											id="IN_MGG" size="14" style="text-align: right;"
											disabled="disabled" /></td>

									</tr>
									<tr>
										<th>비고</th>
										<td colspan="5"><input type="text" size="78"
											name="IN_ETC" id="IN_ETC" onblur="remarkCh(this);" onkeyup="checkByteLength(this, 100);" />
											<input type="hidden" name="strSlipProcStat" id="strSlipProcStat" ></td>
											
									</tr>

								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>

					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="right PB03"><img
									src="<%=dir%>/imgs/btn/add_row.gif" id="IMG_ADD"
									onclick="add_row();" /><img
									src="<%=dir%>/imgs/btn/del_row.gif" id="IMG_DEL"
									onclick="row_delete();" /></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="BD4A">
							<tr valign="top"> 
								<td width="100%">
								<div id="DETAIL_Title" style="width: 560px; overflow: hidden;">
								<table width="880" border="0" cellspacing="0" cellpadding="0"
									class="g_table">
									<tr> 
										<th rowspan="2" width="35">No</th>
										<th rowspan="2" width="25">선택<input type="checkbox"
											name="check1" id="check1" onclick="allChk();"></th>
										<th rowspan="2" width="60">단축코드</th>	
										<th rowspan="2" width="70">품목코드</th>
										<th rowspan="2" width="90">품목명</th>
										<th rowspan="2" width="45">단위</th>
										<th rowspan="2" width="45">* 수량</th>
										<th rowspan="2" width="45">마진율</th>
										<th colspan="2" width="170">원가</th>
										<th colspan="2" width="170">매가</th>
										<th rowspan="2" width="35">TAG<br>구분</th>
										<th rowspan="2" width="55">TAG발<br>행주체</th>
										<th rowspan="2" width="15">&nbsp;</th>
									</tr>
									<tr>
										<th width="85">단가</th>
										<th width="85">금액</th>
										<th width="85">* 단가</th>
										<th width="85">금액</th>
									</tr>
								</table>
								</div>
								</td>
							</tr>
							<tr>
								<td>
								<div id="DETAIL_CONTETN"
									style="width: 560px; height: 100px; overflow: scroll"
									onscroll="scrollAll2();">
								<table width="860" border="0" cellspacing="0" cellpadding="0"
									class="g_table" id="tb_detail">

								</table>
								</div>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
		</table>
		
</body>
</html>