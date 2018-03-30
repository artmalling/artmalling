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
<script language="javascript" src="<%=dir%>/js/global.js"
	type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/gauce.js"
	type="text/javascript"></script>

<script language="javascript">
var strcd = '<%=strcd%>';       //점코드
var userid = '<%=userid%>';
var gb = '<%=gb%>';
var vencd = '<%=vencd%>';
var venNm = '<%=venNm%>';
var g_strcd = '<%=strcd%>';
var g_pre_row = -1;                 //현재로우
var g_last_row = -1;                //이전로우


var g_gs_gbn = new Array();         //관세 코드
var g_gs_gbn_nm = new Array();      //관세 명
var strToday;                       //DB 현재일
var reg_rate;                       //등록일
var sel_up = 0;

//master 조회 
var gl_strcd;   //점코드
var gl_slip_no; //전표번호
var g_pumbun_cd; //브랜드코드
var norm_mg_rate;      //행사 마진율
var g_tax_flag;         //택구분

var g_hs_gbn = new Array();         //행사 구분 value
var g_hs_gbn_nm = new Array();      //행사 구분 text

var dtlCount          = 0;                              // 상세 Row 수
var dtlIdCount        = 0;                              // 상세 생성된 ID Count
var venRoundFlag      = "";                             // 협력사 반올림 구분
var strSlip_no_new = "";


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
    
    /*  버튼비활성화  */
    enableControl(frm.search,true);   //신규
    enableControl(frm.newrow,true);   //신규
    enableControl(frm.del,true);      //삭제
    enableControl(frm.save,true);     //저장
    enableControl(frm.excel,false);    //엑셀
    enableControl(frm.prints,false);    //프린터   
    
    /*  조회 항목  */
    initDateText('SYYYYMMDD', 'em_S_Date');        //시작일
    initDateText("TODAY", "em_E_Date");        //종료일
    
    
    /*조회부*/
   // getPumbunCombo(g_strcd, vencd, "pubumCd", "Y", "2");                        //점별 브랜드 select box
    getSelectCombo("D", "P214", "gjDate");                                      //기준일
    getSelectCombo("D", "P207", "Sel_slip_proc_falg");                          //전표상태
    getEtcEm("D", "P004");                                                      //과세구분
    
    /* 입력부 */
    strToday        = getTodayDB2();                                            //db 오늘일자
  //  getPumbunCombo(g_strcd, vencd, "IN_PB_CD", "N","2");                            //입력부 브랜드
  
    document.getElementById("strVenCd").focus();
     
    
    // 입력부 비활성화
    setObject(false);
    //사후구분이 재고조정일때 발주일, 납품예정일, 마진적용일 달력컨트롤 사용막는다
    setCalImgDis(false);
    enableControl(frm.IMG_ADD, false);
    enableControl(frm.IMG_DEL, false);
    
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
function getPumbunCombo(strcd, vencd, target, YN, skuFlag){
     var param = "";
     var strVenCd = document.getElementById("strVenCd").value;
    
     param = "&goTo=getPumbunCombo&strcd=" + strcd
              + "&vencd=" + strVenCd
              + "&gb=" + gb
              + "&skuFlag=" + skuFlag;
    
    
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
       }

       getpumbunGbBu();
       
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
    var b_strcd = document.getElementById("strcd").value;                    //점코드
    var vencd = document.getElementById("strVenCd").value;                    //협력사코드
    var pubumCd = document.getElementById("strPbCd").value;                //브랜드코드
    var slip_proc_falg = document.getElementById("Sel_slip_proc_falg").value;      //전표 상태
    var gjDate = document.getElementById("gjDate").value;                  //기준일
    var sDate = document.getElementById("em_S_Date").value;                //시작일
    var eDate = document.getElementById("em_E_Date").value;                //종료일
    var slip_falg = "";                                                    //전표구분
   
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
        document.getElementById("strVenCd").focus();
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
    

    getPumbunCombo(strcd, vencd, "IN_PB_CD", "N","2");  
 
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
    new_row = "1";
    g_remark_ch = "1";
    var b_strcd = document.getElementById("strcd").value;                    //점코드
    var vencd = document.getElementById("strVenCd").value;                    //협력사코드
    var pubumCd = document.getElementById("strPbCd").value;                //브랜드코드
    var slip_proc_falg = document.getElementById("Sel_slip_proc_falg").value;      //전표 상태
    var gjDate = document.getElementById("gjDate").value;                  //기준일
    var sDate = document.getElementById("em_S_Date").value;                //시작일
    var eDate = document.getElementById("em_E_Date").value;                //종료일
    var slip_falg = "";
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
        urlvalue="/edi/eord107.eo"/>
    
    <ajax:callback function="on_ListXML"> 

    // 스크롤 위치 초기화      
    document.all.DivListTitle.scrollLeft = 0;
    document.all.DivListContent.scrollLeft = 0;
    document.all.DETAIL_Title.scrollLeft = 0;
    document.all.DETAIL_CONTENT.scrollLeft = 0; 
        
    var tmpArr = new Array(); 
    var content =  "";
    frm.last_row.value = -1;
    if( rowsNode.length > 0 ){
        content =  "<table width='380' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_list'>";
        for( var i = 0; i < rowsNode.length; i++ ){
            for( var j = 0; j < rowsNode[i].childNodes.length; j++ ){
                tmpArr[j] = rowsNode[i].childNodes[j].childNodes[0].nodeValue == "null" ? "" : String(rowsNode[i].childNodes[j].childNodes[0].nodeValue);
            }
            // 조회내용리스트 스크립트 생성
            content += setList(i, tmpArr);
        }
        content += "</table>";
        document.getElementById("DivListContent").innerHTML = content;
        
        // 2011.07.15 kjm 추가
        // 조회버튼 클릭시 하단그리드도 같이 조회  
        if( sel_up == "3" ){      //전표 신규 등록 
            ch_new(strSlip_no_new);
        }
        else if ( sel_up == "1" ) {  
            ch_update(strSlip_no_new);
        } 
        else { 
          //  ch_new("");  
            setRowBgColor(-1, 5);                       // 조회시 첫번째 로우 색깔 변경
            getMaster(0);                               // Master Data 조회
        }
         
        setPorcCount("SELECT", rowsNode.length);
    }else{
        content =  "<table width='380' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_list'>";
        content += "</table>";
        document.getElementById("DivListContent").innerHTML = content;
        clearData();
        content =  "<table width='860' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_detail'>";
        content += "</table>";
        document.getElementById("DETAIL_CONTENT").innerHTML = content;
        setPorcCount("SELECT", 0);
      //  setMstObjControl(false);        // Master 활성화/비활성화
      //  setDtlObjControl();             // Detail 활성화/비활성화
    } 
    </ajax:callback> 
}

/**
 * getMaster(row)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-12
 * 개    요   : 마스터 조회
 *         row : 선택 Row
 * return: void
 */
 function getMaster(row){ 
     var strcd              =  document.getElementById("strCd"+row).value; 
     var strSlip_no         = document.getElementById("slip_no"+row).value;
 
     var param   = "&goTo=getMaster"
                 + "&strcd="        + strcd
                 + "&strSlip_no="   + strSlip_no;
     
     <ajax:open callback="on_getMasterXML" 
         param    ="param" 
         method   ="POST" 
         urlvalue ="/edi/eord107.eo"/>
     
     <ajax:callback function="on_getMasterXML"> 
 
     var tmpArr = new Array();  
     if( rowsNode.length > 0 ){ 
         for( var i = 0; i < rowsNode.length; i++ ){
             for( var j = 0; j < rowsNode[i].childNodes.length; j++ ){
                 tmpArr[j] = rowsNode[i].childNodes[j].childNodes[0].nodeValue == "null" ? "" : String(rowsNode[i].childNodes[j].childNodes[0].nodeValue);
             } 
         } 
         
         strSlip_no_new = strSlip_no;
         
         setMaster(tmpArr);        // Master 화면세팅
         getDetail(row);           // Detail Data 조회(단품정보)
     } 
     else {
    	 setPorcCount("SELECT", 0);  
     }
    
     </ajax:callback>
 }
 
 /**
  * getDetail(row)
  * 작 성 자 : 김경은
  * 작 성 일 : 2011-08-12
  * 개    요   : 마스터 조회
  *         row : 선택 Row
  * return: void
  */
  function getDetail(row){
      var strcd              =  document.getElementById("strCd"+row).value; 
      var strSlip_no         = document.getElementById("slip_no"+row).value;
      
      var param   = "&goTo=getDetail"
                  + "&strcd="         + strcd
                  + "&slip_no="        + strSlip_no;
      
      <ajax:open callback="on_getDetailXML" 
          param    ="param" 
          method   ="POST" 
          urlvalue ="/edi/eord107.eo"/>
      
      <ajax:callback function="on_getDetailXML"> 
      var tmpArr  = new Array(); 
      var content =  "";
      dtlCount    = 0;
      dtlIdCount  = 0;
      frm.del_detail.value = "";     // 삭제된 상세(ord_seq_no)
      if( rowsNode.length > 0 ){
          content =  "<table width='860' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_detail'>";
          for( var i = 0; i < rowsNode.length; i++ ){
              for( var j = 0; j < rowsNode[i].childNodes.length; j++ ){
                  tmpArr[j] = rowsNode[i].childNodes[j].childNodes[0].nodeValue == "null" ? "" : String(rowsNode[i].childNodes[j].childNodes[0].nodeValue);
              }
              // 조회내용리스트 스크립트 생성
              content += setDetail(i, tmpArr);
          }
          content += "</table>";
          document.getElementById("DETAIL_CONTENT").innerHTML = content;
          dtlCount   = rowsNode.length;   // 상세정보(단품)의 전체 Row수
          dtlIdCount = rowsNode.length;   // 상세 ID Count 
        //  setMstObjControl(false);        // Master 활성화/비활성화
        //  setDtlObjControl();             // Detail 활성화/비활성화
      }else {
          content =  "<table width='860' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_detail'>";
          content += "</table>"; 
          document.getElementById("DETAIL_CONTENT").innerHTML = content;
          dtlCount   = rowsNode.length;   // 상세정보(단품)의 전체 Row수
          dtlIdCount = rowsNode.length;   // 상세 ID Count 
      }
      
      </ajax:callback>
  }
 
 /**
  * setList(row, tmpArr)
  * 작 성 자 : 김경은
  * 작 성 일 : 2011-08-10
  * 개    요   : 리스트 조회내용 리스트 생성 
  * return : void
  */
  function setList(row, tmpArr){
      
      var tmpContent = "";
      var col        = 0;
      // tmpArr[]
      //  전표번호[0]  ,점코드[1]        ,점명[2]       ,전표구분[3]  ,전표구분명[4] 
      // ,발주일자[5]    ,전표진행상태[6]  ,전표진행상태명[7] 
        
      tmpContent += "   <tr onclick='setRowBgColor("+row+",5); getMaster("+row+");' style='cursor:hand;'>";
      tmpContent += "       <input type='hidden'       id='slip_no"+row+"'        name='slipNo'         value='"+tmpArr[0]+"' />";             // 전표번호
      tmpContent += "       <input type='hidden'       id='strCd"+row+"'          name='strCd'          value='"+tmpArr[1]+"' />";             // 점
      tmpContent += "       <input type='hidden'       id='slip_flag"+row+"'      name='slipFlag'       value='"+tmpArr[3]+"' />";             // 전표구분
      tmpContent += "       <input type='hidden'       id='slip_proc"+row+"'      name='slip_proc'      value='"+tmpArr[6]+"' />";             // 전표진행상태
      tmpContent += "       <td class='r1' width='75'  id='column"+row+"_"+(col++)+"'>"+tmpArr[2]+"</td>";   
      tmpContent += "       <td class='r1' width='65'  id='column"+row+"_"+(col++)+"'>"+tmpArr[4]+"</td>";   // 전표구분명
      tmpContent += "       <td class='r1' width='75'  id='column"+row+"_"+(col++)+"'>"+slip_format(tmpArr[0])+"</td>";                        // 전표번호
      tmpContent += "       <td class='r1' width='75'  id='column"+row+"_"+(col++)+"'>"+getDateFormat(tmpArr[5])+"</td>";                      // 발주일
      tmpContent += "       <td class='r3' width='65'  id='column"+row+"_"+(col++)+"' title="+tmpArr[7]+">"+cutTitleText(tmpArr[7],5)+"</td>"; // 전표진행상태명
      tmpContent += "    </tr>";
      return tmpContent; 
  } 
 
 /**
  * setMaster(tmpArr)
  * 작 성 자 : 김경은
  * 작 성 일 : 2011-08-16
  * 개    요   : 조회된 마스트 내용 화면에 세팅
  *         tmpArr : 조회내역
  * return: void
  */
  function setMaster(tmpArr){ 

// 점코드(STR_CD)[0],                  점명(STR_NM)[1],              전표번호(SLIP_NO)[2],                브랜드코드(PUMBUN_CD)[3],  
// 브랜드명(PUMBUN_NM)[4],               협력사코드(VEN_CD)[5],         협력사명(VEN_NM)[6],                 마진적용일(MG_APP_DT)[7],     
// 행사구분(EVENT_FLAG)[8],            행사구분명(EVENT_FLAG_NM)[9], 행사율(EVENT_RATE)[10],             전표구분(SLIP_FLAG)[11], 
// 전표구분명(SLIP_FLAG_NM)[12],        발주주체구분(ORD_OWN_FLAG)[13], 발주주체구분명(ORD_OWN_FLAG_NM)[14], 발주구분(ORD_FLAG)[15], 
// 사전사후구분(AFT_ORD_FLAG)[16],       발주일자(ORD_DT)[17],         납품예정일(DELI_DT)[18],            검품일자(CHK_DT)[19], 
// SM확정일자(SM_CONF_DT)[20],          SM ID(SM_ID)[21],            바이어ID(BUYER_CONF_ID)[22],        발주확정일(ORD_CF_DT)[23],
// 바이어코드(BUYER_CD)[24],             바이어명(BUYER_NM)[25],       경리승인일(ACC_CONF_DT)[26],   전표진행상태(SLIP_PROC_STAT)[27],
// 전표진행상태명(SLIP_PROC_STAT_NM)[28], 명세건수(DTL_CNT)[29],        발주수량(ORD_TOT_QTY)[30],     신원가금액합(NEW_COST_TAMT)[31], 
// 신매가금액합(NEW_SALE_TAMT)[32],       신차익액합(GAP_TOT_AMT)[33],  신차익율(NEW_GAP_RATE)[34],        지불조건(PAY_COND)[35],
// 비고(REMARK)[36],                     거래형태(BIZ_TYPE)[37],       과세구분(TAX_FLAG)[38],          과세구분명(TAX_FLAG_NM)[39],
// 등록일자(REG_DATE)[40],               부가세액합(VAT_TAMT)[41],      정상마진율(NORM_MG_RATE)[42]
  
 /* 
 IN_SLIP_FLAG(전표구분A,B)              IN_SH_GBN_NM(사후구분명)       IN_SH_GBN(사후구분:H)          IN_PB_CD(브랜드코드:콤)
 IN_BALJUJC(발주주체:H)                 ord_own_falg_nm(발주주체구분몀) IN_BJDATE(발주일:IMG_BJDATE) IN_BJHJDATE(발주확정일)
 HRS_CD(협력사:H)                      HRS_NM(협력사명)                IN_GS_GBN(과세구분:H)         IN_GS_GBN_NM(과세구분명)
 IN_NPYJDATE(납품예정일:IMG_NPYJDATE)   IN_BUYER_CD(바이어코드)          IN_BUYER_NM(바이어명)
 IN_MAJINDATE(마진적용일:IMG_MAJINDATE) IN_HS_GBN(행사구분:콤)           IN_HS_RATE(행사율:콤)
 IN_GPWJ_DATE(검품확정일)               IN_SRG(수량계)      IN_WGG(원가계)     IN_MGG(매가계)               IN_ETC(비고)
 */  

 // 입력부 비활성화
  setObject(false);
  //사후구분이 재고조정일때 발주일, 납품예정일, 마진적용일 달력컨트롤 사용막는다
  setCalImgDis(false);
      if( tmpArr[11] == "B" ){
           document.getElementsByName("IN_SLIP_FLAG")[1].checked = true;
      }else {
            document.getElementsByName("IN_SLIP_FLAG")[0].checked = true;
      }                                                                                 // 전표구분
      document.getElementById("IN_SH_GBN_NM").value     = "사전전표";                    // 사후구분명
      document.getElementById("IN_SH_GBN").value        = tmpArr[16];                   // 사후구분 
      document.getElementById("IN_PB_CD").value         = tmpArr[3];                    // 브랜드
      document.getElementById("IN_BALJUJC").value       = tmpArr[13];                   // 발주주체
      document.getElementById("ord_own_falg_nm").value  = tmpArr[14];                   // 발주주체명
      document.getElementById("IN_BJDATE").value        = getDateFormat(tmpArr[17]);    // 발주일
      document.getElementById("IN_BJHJDATE").value      = getDateFormat(tmpArr[23]);    // 확정일
      document.getElementById("HRS_CD").value           = tmpArr[5];                    // 협력사
      document.getElementById("HRS_NM").value           = tmpArr[6];                    // 협력사명
      document.getElementById("IN_GS_GBN").value        = tmpArr[38];                   // 과세구분
      document.getElementById("IN_GS_GBN_NM").value     = tmpArr[39];                   // 과세구분명
      document.getElementById("IN_NPYJDATE").value      = getDateFormat(tmpArr[18]);    // 납품예정일
      document.getElementById("IN_BUYER_CD").value      = tmpArr[24];                   // 바이어ID
      document.getElementById("IN_BUYER_NM").value      = tmpArr[25];                   // 바이어명
      document.getElementById("IN_MAJINDATE").value     = getDateFormat(tmpArr[7]);     // 마진적용일
      document.getElementById("IN_HS_GBN").value        = tmpArr[8];                    // 행사구분
      document.getElementById("IN_HS_RATE").value       = tmpArr[10];                   // 행사율
      norm_mg_rate                                      = tmpArr[42];                   // 마진율
      document.getElementById("IN_SLIP_NO").value       = tmpArr[2];                   // 전표번호
          
      document.getElementById("IN_HS_GBN").length = 0;
      // 
      if( tmpArr[8] != "" ){ 
          var IN_HS_GBN = document.getElementById("IN_HS_GBN");
          var opt = document.createElement("option");  
          opt.setAttribute("value", tmpArr[8]); 
          var text = document.createTextNode(tmpArr[8]);
          opt.appendChild(text); 
          IN_HS_GBN.appendChild(opt);
      }
      document.getElementById("IN_HS_RATE").length = 0;
      if( tmpArr[10] != "" ){
          var IN_HS_RATE = document.getElementById("IN_HS_RATE");
          var opt = document.createElement("option");  
          opt.setAttribute("value", tmpArr[10]);
          
          var text = document.createTextNode(tmpArr[10]);
          opt.appendChild(text); 
          IN_HS_RATE.appendChild(opt);
      }
      
      document.getElementById("IN_GPWJ_DATE").value     = getDateFormat(tmpArr[19]);    // 검품확정일
      document.getElementById("IN_SRG").value         = convAmt(tmpArr[30]);                     // 수량계
      document.getElementById("IN_WGG").value         = convAmt(tmpArr[31]);                     // 원가계
      document.getElementById("IN_MGG").value          = convAmt(tmpArr[32]);                    // 매가계
      document.getElementById("IN_ETC").value          = tmpArr[36];                    // 비고 
 
      if( tmpArr[27] == "00" || tmpArr[27] == "" ){
          document.getElementById("IN_ETC").disabled = false;
          setTimeout("detailEditable(false);", 100);
          enableControl(frm.IMG_ADD, true);
          enableControl(frm.IMG_DEL, true);
      } else {
          document.getElementById("IN_ETC").disabled = true;
          setTimeout("detailEditable(true);", 100);
          enableControl(frm.IMG_ADD, false);
          enableControl(frm.IMG_DEL, false);
          
      } 
      
  }
 
  /**
   * setDetail(row, tmpArr)
   * 작 성 자 : 김경은
   * 작 성 일 : 2011-08-10
   * 개    요   : 상세(단품) 조회내용 리스트 생성 
   * return : void
   */
   function setDetail(row, tmpArr){
       
       var tmpContent = "";
       var col        = 0;
       // tmpArr[]
/*
  CHECK1(체크)[0]                  , STR_CD(점코드)[1]                     , SLIP_NO(전표번호)[2]         , ORD_SEQ_NO(전표상세번호)[3]
, PUMMOK_CD(품목코드)[4]           , PUMMOK_NM(품목코드)[5]                , ORD_UNIT_CD(발주단위)[6]     , MG_RATE(마진율)[7]
, SLIP_FLAG(전표구분)[8]           , ORD_QTY(발주수량)[9]                  , NEW_GAP_RATE(신차익율)[10]   , NEW_GAP_AMT(신차익액)[11]
, NEW_COST_PRC(신원가단가)[12]     , NEW_COST_AMT(신원가금액)[13]          , NEW_SALE_PRC(신매가단가)[14] , NEW_SALE_AMT(신매가금액)[15]
, PUMBUN_CD(브랜드)[16]              , VEN_CD(협력사)[17]                    , TAG_FLAG(택구분)[18]         , TAG_FLAG_NM(택구분명)[19]
, TAG_PRT_OWN_FLAG(택발행주체)[20] , TAG_PRT_OWN_FLAG_NM(택발행주체명)[21] , VAT_AMT(부가세)[22]
       
       선택, 품목코드, 품목명, 단위, 수량, 마진율, 원가단가, 원가금액, 매가단가, 매가금액, tag구분, tag발행주체
*/
		tmpContent += "<tr>";
		tmpContent += "     <td class='r1' width='35' id='d_no'>"+(row+1)+"</td>";   
		tmpContent += "     <td class='r1' width='25'><input type='checkbox' name='d_check1'  id='d_check1"+row+"'  value='"+tmpArr[0]+"' style='width:25;text-align:center;'/ disabled='disabled'></td>";
		tmpContent += "     <td class='r1' width='85'><input type='text'    name='d_pummok_cd'  id='d_pummok_cd"+row+"'  value='"+tmpArr[4]+"' style='width:55;text-align:center;' maxlength='13' onkeypress='javascript:onlyNumber();' disabled='disabled' />";
		tmpContent += "                                <input type='button'  name='pummokImg' id='pummokImg"+row+"' onclick='getPbnPmkPop("+row+");' value='..' disabled='disabled'  />";
		tmpContent += "     </td>";
		tmpContent += "     <td class='r1' width='85' id='d_pummok_nm' title="+tmpArr[5]+" ><input type='text' name='d_pummok_nm'      id='d_pummok_nm"+row+"'      value='"+tmpArr[5]+"' style='width:85;text-align:left;' maxlength='40' disabled='disabled'/></td>";
		tmpContent += "     <td class='r1' width='45'><input type='text' name='d_ord_unit_cd'  id='d_ord_unit_cd"+row+"'  value='"+tmpArr[6]+"' style='width:45;text-align:left;' maxlength='3' disabled='disabled' /></td>";
		tmpContent += "     <td class='r4' width='45'><input type='text' name='d_ord_qty'     id='d_ord_qty"+row+"'     value='"+convAmt(tmpArr[9])+"' onkeypress='javascript:onlyNumber();' style='width:45;text-align:right; IME-MODE: disabled;' maxlength='7'  onblur='javascript:calcDetail("+row+");'  disabled='disabled'/></td>";
		tmpContent += "     <td class='r4' width='45'><input type='text' name='d_mg_rate'     id='d_mg_rate"+row+"' value='"+tmpArr[7]+"' style='width:45;text-align:right;' maxlength='9' disabled='disabled' /></td>";
		tmpContent += "     <td class='r4' width='85'><input type='text' name='d_new_cost_prc' id='d_new_cost_prc"+row+"' value='"+convAmt(tmpArr[12])+"' style='width:85;text-align:right;' maxlength='13' disabled='disabled' /></td>";
		tmpContent += "     <td class='r4' width='85'><input type='text' name='d_new_cost_amt' id='d_new_cost_amt"+row+"' value='"+convAmt(tmpArr[13])+"' onkeypress='javascript:onlyNumber();' onblur='javascript:calcDetail("+row+");' style='width:85;text-align:right;IME-MODE: disabled' maxlength='9'  disabled='disabled';' /></td>";
		tmpContent += "     <td class='r4' width='85'><input type='text' name='d_new_sale_prc' id='d_new_sale_prc"+row+"' value='"+convAmt(tmpArr[14])+"' style='width:85;text-align:right;' maxlength='13' onblur='javascript:calcDetail("+row+");'  disabled='disabled' /></td>";
		tmpContent += "     <td class='r4' width='85'><input type='text' name='d_new_sale_amt' id='d_new_sale_amt"+row+"' value='"+convAmt(tmpArr[15])+"' style='width:85;text-align:right;' maxlength='13' disabled='disabled' /></td>";
		tmpContent += "     <td class='r1' width='35'><input type='text' name='d_tag_flag' id='d_tag_flag"+row+"' value='"+tmpArr[19]+"' style='width:25;text-align:right;' disabled='disabled' /></td>";
		tmpContent += "     <td class='r1' width='55'><input type='text' name='d_tag_prt_own_flag' id='d_tag_prt_own_flag"+row+"' value='"+tmpArr[21]+"' style='width:45;text-align:right;' disabled='disabled' /></td>";
		
		tmpContent += "     <input type='hidden' name='d_strCd'      id='d_strCd"+row+"'      value='"+tmpArr[1]+"'  />";   // 점
		tmpContent += "     <input type='hidden' name='d_slip_no'    id='d_slip_no"+row+"'    value='"+tmpArr[2]+"'  />";   // 전표번호
		tmpContent += "     <input type='hidden' name='d_ord_seq_no' id='d_ord_seq_no"+row+"' value='"+tmpArr[3]+"'  />";   // 전표상세번호
		tmpContent += "     <input type='hidden' name='d_pummokCd'   id='d_pummokCd"+row+"'   value='"+tmpArr[4]+"'  />";   // 품목
		tmpContent += "     <input type='hidden' name='d_ordUnitCd'  id='d_ordUnitCd"+row+"'  value='"+tmpArr[5]+"'  />";   // 발주단위
		tmpContent += "     <input type='hidden' name='d_newGapAmt'  id='d_newGapAmt"+row+"'  value='"+tmpArr[11]+"'  />";   // 신차익액
		tmpContent += "     <input type='hidden' name='d_newGaprate'  id='d_newGaprate"+row+"'  value='"+tmpArr[10]+"'  />";   // 신차익율
		tmpContent += "     <input type='hidden' name='d_pumbunCd'   id='d_pumbunCd"+row+"'   value='"+tmpArr[16]+"' />";   // 브랜드
		tmpContent += "     <input type='hidden' name='d_venCd'      id='d_venCd"+row+"'      value='"+tmpArr[17]+"' />";   // 협력사
		tmpContent += "     <input type='hidden' name='d_slipFlag'   id='d_slipFlag"+row+"'   value='"+tmpArr[8]+"' />";   // 전표구분
		tmpContent += "     <input type='hidden' name='d_mgRate'     id='d_mgRate"+row+"'     value='"+tmpArr[7]+"' />";   // 마진율
		tmpContent += "     <input type='hidden' name='d_vatAmt'     id='d_vatAmt"+row+"'     value='"+tmpArr[22]+"' />";   // 부가세 
		
		tmpContent += "</tr>";
		return tmpContent; 
       
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
    var d_pummok_cd = document.getElementsByName("d_pummok_cd");
    var d_ord_qty = document.getElementsByName("d_ord_qty");
    var d_new_sale_prc = document.getElementsByName("d_new_sale_prc");
    
    if( !Flag ){           //flase 일 경우
        
        document.getElementById("check1").disabled = false;
       
        for( i = 0; i < d_no.length; i++ ){ 
            d_check1[i].disabled = false;
            d_ord_qty[i].disabled = false;
            d_new_sale_prc[i].disabled = false;
            
        }
        
    } else {               //true 일 경우
       
        document.getElementById("check1").disabled = true;
       
        for( i = 0; i < d_no.length; i++ ){
       
            document.getElementsByName("d_check1")[i].disabled = true;
            d_ord_qty[i].disabled = true;
            d_new_sale_prc[i].disabled = true;
            
        }
    }
} 
 
 /**
  * clearData()
  * 작 성 자     : 김경은
  * 작 성 일     : 2011-08-11
  * 개    요        : 데이터를 지운다.
  * return값 : void
  */
  function clearData(){ 
      /* 
      IN_SLIP_FLAG(전표구분A,B)              IN_SH_GBN_NM(사후구분명)       IN_SH_GBN(사후구분:H)          IN_PB_CD(브랜드코드:콤)
      IN_BALJUJC(발주주체:H)                 ord_own_falg_nm(발주주체구분몀) IN_BJDATE(발주일:IMG_BJDATE) IN_BJHJDATE(발주확정일)
      HRS_CD(협력사:H)                      HRS_NM(협력사명)                IN_GS_GBN(과세구분:H)         IN_GS_GBN_NM(과세구분명)
      IN_NPYJDATE(납품예정일:IMG_NPYJDATE)   IN_BUYER_CD(바이어코드)          IN_BUYER_NM(바이어명)
      IN_MAJINDATE(마진적용일:IMG_MAJINDATE) IN_HS_GBN(행사구분:콤)           IN_HS_RATE(행사율:콤)
      IN_GPWJ_DATE(검품확정일)               IN_SRG(수량계)      IN_WGG(원가계)     IN_MGG(매가계)               IN_ETC(비고)
      */   
       
       frm.IN_SLIP_FLAG.value       = "A";           // 전표구분
       frm.IN_SH_GBN_NM.value       = "";           // 사전사후구분명
       frm.IN_SH_GBN.value          = "";           // 사전사후구분
       frm.IN_PB_CD.value           = "";           // 브랜드 
       frm.IN_BALJUJC.value         = "";           // 발주주체
       frm.ord_own_falg_nm.value    = "";           // 발주주체명
       frm.IN_BJDATE.value          = "";           // 발주일
       frm.IN_BJHJDATE.value        = "";           // 확정일
    //   frm.HRS_CD.value             = "";           // 협력사
     //  frm.HRS_NM.value             = "";           // 협력사명
       frm.IN_GS_GBN.value          = "";           // 과세구분
       frm.IN_GS_GBN_NM.value       = "";           // 과세구분명
       frm.IN_NPYJDATE.value        = "";           // 납품예정일
       frm.IN_BUYER_CD.value        = "";           // 바이어ID
       frm.IN_BUYER_NM.value        = "";           // 바이어명
       frm.IN_MAJINDATE.value       = "";           // 마진적용일
       frm.IN_HS_GBN.value          = "";           // 행사구분
       frm.IN_HS_RATE.value         = "";           // 행사율
       frm.IN_GPWJ_DATE.value       = "";           // 검품확정일
       frm.IN_SRG.value             = 0;           // 수량계
       frm.IN_WGG.value             = 0;           // 원가계
       frm.IN_MGG.value             = 0;           // 매가계
       frm.IN_ETC.value             = "";           // 비고
        
       frm.reg_date.value          = "99999999";   // 전표등록일자 
       frm.vat_tamt.value          = "";           // 부가세합
     //  frm.chkAll.checked          = false;        // 전체선택 초기화
       frm.del_detail.value        = "";           // 상세삭제 Row (ord_seq_no)
       dtlCount                    = 0;            // 상세건수
       dtlIdCount                  = 0;            // 상세 ID Count 
       // 상세 초기화
       var content = "";
       content =  "<table width='860' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_detail'>";
       content += "</table>";
       document.getElementById("DETAIL_CONTENT").innerHTML = content;
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
      
      if(frm.reg_date.value == "99999999"){
          //저장할 내용이 없습니다
          showMessage(EXCLAMATION, OK, "USER-1028");
          return; 
     }

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
          return;
      }
      
      if(!checkValidation("Save"))  return; 
    
      for(var j = 0; j < document.getElementsByName("d_pummok_cd").length; j++ ) { 
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
      //마감체크
      closeCheck();
      
      if(new_row == "3") { 
          SaveSlip_No(strcd, frm.IN_BJDATE.value)
      } 
      
     //변경또는 신규 내용을 저장하시겠습니까?
      if( showMessage(QUESTION, YESNO, "USER-1010") == 1 ){    // validation 체크 
          var param = getParam();
          <ajax:open callback="on_saveXML"
              param="param" 
              method="POST" 
              urlvalue="/edi/eord107.eo"/>
          
          <ajax:callback function="on_saveXML">
            
          if( rowsNode.length > 0 ){
              ret = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
              if( ret > 0 ){
                  showMessage(INFORMATION, OK, "GAUCE-1000", "정상적으로 저장되었습니다.");
                  getSearch(new_row);
                  new_row = "1";
              }else {
                  showMessage(INFORMATION, OK, "GAUCE-1000", ret);
              }  
          }
          </ajax:callback>
      }   
  }
   
/**
 * setRowBgColor(row,colCount)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-12
 * 개    요   : 선택된 Row의 BGColor를 변경한다.
 *         row      : 선택 Row
 *         colCount : 전체컬럼수
 * return : void
 */
 function setRowBgColor(row,colCount){
     var lastRow = frm.last_row.value;   // 마지막 선택 Row
     row         = row == -1 ? 0:row;    // 현재 선택 Row
     if(lastRow != row){
         for(var j=0;j<colCount;j++) {
             document.getElementById("column"+row+"_"+j).style.backgroundColor     = "#fff56E";
             if(lastRow != -1)
                 document.getElementById("column"+lastRow+"_"+j).style.backgroundColor = "#ffffff";
         } 
         frm.last_row.value = row;
     }
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
                                    + "&strSlip_no="             + strSlip_no;

     var Urleren = "/edi/eord107.eo"; 
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
 
/**
 * getParam()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-20
 * 개    요 :  param 생성
 * return값 : void
 */ 
 function getParam(){      
     var str = "";
     str = "&goTo=save"
         + "&rowStatus="             + new_row
         + "&sv_strcd="              + strcd
         + "&sv_slip_no="            + strSlip_no_new   
         + "&sv_slip_flag="          + getRadioValue("IN_SLIP_FLAG")      // 전표구분 
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
         + "&sv_dtl_cnt="            + dtlCount           
         + "&d_sv_strcd="            + getObjArrData("strcd") 
         + "&d_sv_slip_no="          + getObjArrData("strSlip_no_new")  
         + "&d_sv_ord_seqno="        + getObjArrData("d_ord_seq_no") 
         + "&d_sv_pummok_cd="        + getObjArrData("d_pummok_cd")
         + "&d_sv_ord_unit_cd="      + getObjArrData("d_ord_unit_cd")
         + "&d_sv_ord_qty="          + getObjArrData("d_ord_qty")
         + "&d_sv_mg_rate="          + getObjArrData("d_mg_rate")
         + "&d_sv_new_cost_prc="     + getObjArrData("d_new_cost_prc")
         + "&d_sv_new_cost_amt="     + getObjArrData("d_new_cost_amt")
         + "&d_sv_new_sale_prc="     + getObjArrData("d_new_sale_prc")
         + "&d_sv_new_sale_amt="     + getObjArrData("d_new_sale_amt") 
         + "&d_sv_tag_flag="         + getObjArrData("d_tag_flag")
         + "&d_sv_tag_prt_own_flag=" + getObjArrData("d_tag_prt_own_flag")
         + "&d_sv_new_gat_amt="      + getObjArrData("d_newGapAmt")
         + "&d_newGaprate="          + getObjArrData("d_newGaprate") 
         + "&d_sv_vat_amt="          + getObjArrData("d_vatAmt")
         + "&del_detail="            + frm.del_detail.value
         ;    
     return str;
 }
 
 
 /**
  * getRadioValue(target)
  * 작 성 자 : 김경은
  * 작 성 일 : 2011-08-10
  * 개    요   : 라디오박스의 선택된값을 가져온다.
  *  - target : 라디오박스 이름
  * return : void
  */
  function getRadioValue(target){
      if (frm.elements(target).length) {
          for (var j = 0; j < frm.elements(target).length; j++) {
              if (frm.elements(target)[j].checked) {
                  return frm.elements(target)[j].value;
              }
          }
      }
  }
 
  /**
   * getObjArrData(objNm)
   * 작 성 자 : 김경은
   * 작 성 일 : 2011-08-20
   * 개    요 :  배열Object데이터 String변환
   * return값 : void
   */ 
   function getObjArrData(objNm){
       var tmpVal = document.getElementsByName(objNm);
       var rtnVal = ""; 
       var gb     = tmpVal.length>1 ? "/":"" ;
       for(var i = 0; i < tmpVal.length; i++){ 
           if(tmpVal[i].value.length ==0){
               tmpVal[i].value=" ";
           }
           rtnVal += removeComma2(tmpVal[i].value) + gb;
       }  
       return rtnVal;
   }

function key_click(row) { 
	 if(event.keyCode == 13 || event.keyCode == 9){  
	        document.getElementById("d_pummok_cd"+row).focus();
	 } 
}

function SaveSlip_No(sv_strcd, strbjsate){ 
	
    var param = "&goTo=slipno&sv_strcd="             + sv_strcd
    + "&sv_bjdate="             + strbjsate;
    
    var Urleren = "/edi/eord107.eo"; 
    URL = Urleren + "?" +param; 
    strMst = getXMLHttpRequest(); 
    strMst.onreadystatechange = responseSlipno;
    strMst.open("GET", URL, true); 
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
                  }    
              }
          } 
     }
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
          var strCount = document.getElementsByName("strcd").length; //- 1; 
            for(var i=0;i<strCount;i++) { 
                    for(var j=0;j<5;j++) {   
                     document.getElementById("column"+i+"_"+j).style.backgroundColor     = "#fff56E";
                        g_pre_row = i;
                        frm.last_row.value = i;
                    }
                    getMaster(i); 
                    break; 
            } 
            strSlip_no_new = "";
            
      }
      else {
          var strCount = document.getElementsByName("strcd").length; // - 1; 
             for(var i=0;i<strCount;i++) { 
                 var strSlip = document.getElementById("slip_no"+i).value;  
                 if(strSlip == strSlip_no_new) { 
                     for(var j=0;j<5;j++) {  
                         document.getElementById("column"+i+"_"+j).style.backgroundColor     = "#fff56E"; 
                         g_pre_row = i;
                            frm.last_row.value = i;
                     }
                     getMaster(i); 
                     break;
                 }  
             } 
             strSlip_no_new = "";
      } 
 }
 
 /**
  * ch_update()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  마스터 로우 선택시  색
  * return값 : void
  */ 
 function ch_update(update_slipno) { 
      if(update_slipno == "") { 
        chBak(0);
        getMaster(0); 
      }
      else {
          var strCount = document.getElementsByName("strcd").length; // - 1; 
             for(var i=0;i<strCount;i++) {   
                 var strSlip = document.getElementById("slip_no"+i).value;  
                 
                 if(strSlip == update_slipno) { 
                     for(var j=0;j<5;j++) {  
                         document.getElementById("column"+i+"_"+j).style.backgroundColor     = "#fff56E";   
                         frm.last_row.value = i;
                     }
                     getMaster(i);
                     return;
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
	var tb_list = document.getElementById("tb_list");
    var tr_cnt = tb_list.rows.length;
    var strStrcd = document.getElementById("IN_STR_CD").value;
    var strSlipNo = document.getElementById("IN_SLIP_NO").value; 
    if( tr_cnt < 1 || document.getElementById("IN_SLIP_NO").value == "" ){
        showMessage(StopSign, OK, "USER-1019");
        return;
    }
      
    if(!checkValidation("Delete"))  return;
    
    var param = "&goTo=slip_flag&strcd=" + strcd + "&slip_no=" + strSlipNo;

    <ajax:open callback="on_slip_flagXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/eord107.eo"/>
    
    <ajax:callback function="on_slip_flagXML">
     SLIP_PROC_STAT = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
      
     if(SLIP_PROC_STAT != "00") {
         showMessage(Information, Ok, "GAUCE-1000", "해당전표는 삭제 할 수 없습니다.");
         return;
     }
     
     if( showMessage(QUESTION, YESNO, "GAUCE-1000", "선택한 항목을 삭제하겠습니까?") != 1){
         return;
     }
     var param = "&goTo=delete&strcd=" + strcd + "&slip_no=" + strSlipNo;
     
     <ajax:open callback="on_DeleteXML" 
         param="param" 
         method="POST" 
         urlvalue="/edi/eord107.eo"/>
     
     <ajax:callback function="on_DeleteXML">
     
     ret = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
     if( ret > 0 ){
         showMessage(INFORMATION, OK, "GAUCE-1000", ret + " 건 정상적으로 삭제되었습니다.");
 
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
        
    var strStrcd = document.getElementById("IN_STR_CD").value;      // 점
    var strCloseDt = getRawData(document.getElementById("IN_BJDATE").value);    // 마감체크일자
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
	        }  
	    }
    </ajax:callback>
    
}

function calcDetail(row){  
    /*
     tmpContent += "     <td class='r1' width='45'><input type='text' name='d_ord_unit_cd'  id='d_ord_unit_cd"+row+"'  value='"+tmpArr[6]+"' style='width:45;text-align:left;' maxlength='3' disabled='disabled' /></td>";
     tmpContent += "     <td class='r4' width='45'><input type='text' name='d_ord_qty'     id='d_ord_qty"+row+"'     value='"+convAmt(tmpArr[9])+"' onkeypress='javascript:onlyNumber();' style='width:45;text-align:right; IME-MODE: disabled;' maxlength='7'  onblur='javascript:calcDetail("+row+");'  disabled='disabled'/></td>";
     tmpContent += "     <td class='r4' width='45'><input type='text' name='d_mg_rate'     id='d_mg_rate"+row+"' value='"+tmpArr[7]+"' style='width:45;text-align:right;' maxlength='9' disabled='disabled' /></td>";
     tmpContent += "     <td class='r4' width='85'><input type='text' name='d_new_cost_prc' id='d_new_cost_prc"+row+"' value='"+convAmt(tmpArr[12])+"' style='width:85;text-align:right;' maxlength='13' disabled='disabled' /></td>";
     tmpContent += "     <td class='r4' width='85'><input type='text' name='d_new_cost_amt' id='d_new_cost_amt"+row+"' value='"+convAmt(tmpArr[13])+"' onkeypress='javascript:onlyNumber();' onblur='javascript:calcDetail("+row+");' style='width:85;text-align:right;IME-MODE: disabled' maxlength='9'  disabled='disabled';' /></td>";
     tmpContent += "     <td class='r4' width='85'><input type='text' name='d_new_sale_prc' id='d_new_sale_prc"+row+"' value='"+convAmt(tmpArr[14])+"' style='width:85;text-align:right;' maxlength='13' disabled='disabled' /></td>";
     tmpContent += "     <td class='r4' width='85'><input type='text' name='d_new_sale_amt' id='d_new_sale_amt"+row+"' value='"+convAmt(tmpArr[15])+"' style='width:85;text-align:right;' maxlength='13' disabled='disabled' /></td>";
     tmpContent += "     <td class='r1' width='35'><input type='text' name='d_tag_flag' id='d_tag_flag"+row+"' value='"+tmpArr[19]+"' style='width:25;text-align:right;' disabled='disabled' /></td>";
     tmpContent += "     <td class='r1' width='55'><input type='text' name='d_tag_prt_own_flag' id='d_tag_prt_own_flag"+row+"' value='"+tmpArr[21]+"' style='width:45;text-align:right;' disabled='disabled' /></td>";

     tmpContent += "     <input type='hidden' name='d_strCd'      id='d_strCd"+row+"'      value='"+tmpArr[1]+"'  />";   // 점
     tmpContent += "     <input type='hidden' name='d_slip_no'    id='d_slip_no"+row+"'    value='"+tmpArr[2]+"'  />";   // 전표번호
     tmpContent += "     <input type='hidden' name='d_ord_seq_no' id='d_ord_seq_no"+row+"' value='"+tmpArr[3]+"'  />";   // 전표상세번호
     tmpContent += "     <input type='hidden' name='d_pummokCd'   id='d_pummokCd"+row+"'   value='"+tmpArr[4]+"'  />";   // 품목
     tmpContent += "     <input type='hidden' name='d_ordUnitCd'  id='d_ordUnitCd"+row+"'  value='"+tmpArr[5]+"'  />";   // 발주단위
     tmpContent += "     <input type='hidden' name='d_newGapAmt'  id='d_newGapAmt"+row+"'  value='"+tmpArr[11]+"'  />";   // 신차익액
     tmpContent += "     <input type='hidden' name='d_pumbunCd'   id='d_pumbunCd"+row+"'   value='"+tmpArr[16]+"' />";   // 브랜드
     tmpContent += "     <input type='hidden' name='d_venCd'      id='d_venCd"+row+"'      value='"+tmpArr[17]+"' />";   // 협력사
     tmpContent += "     <input type='hidden' name='d_slipFlag'   id='d_slipFlag"+row+"'   value='"+tmpArr[8]+"' />";   // 전표구분
     tmpContent += "     <input type='hidden' name='d_mgRate'     id='d_mgRate"+row+"'     value='"+tmpArr[7]+"' />";   // 마진율
     tmpContent += "     <input type='hidden' name='d_vatAmt'     id='d_vatAmt"+row+"'     value='"+tmpArr[22]+"' />";   // 부가세   
    */  
    
    if(row == "D") {  
        if(document.getElementsByName("d_ord_qty").length == 0) {
            return;
        } 
        else {
        	var strTaxFlag  = g_tax_flag; 
            var by_ord_qty = document.getElementsByName("d_ord_qty");
            var by_new_gat_amt = document.getElementsByName("d_newGapAmt");
            var by_new_cost_amt = document.getElementsByName("d_new_cost_amt");
            var by_new_sale_amt = document.getElementsByName("d_new_sale_amt"); 
            var by_vatAmt       = document.getElementsByName("d_vatAmt");
            var sum_srg = 0;
            var sum_wgg = 0;
            var sum_mgg = 0;
            var sum_mgy = 0;
            
            var totCostAmt = 0;
            var totSaleAmt = 0; 
            var totGapAmt = 0;
            
            for( j = 0; j < document.getElementsByName("d_ord_qty").length; j++ ){ 
                sum_srg = sum_srg + parseInt(removeComma2(by_ord_qty[j].value)); 
                sum_wgg = sum_wgg + parseInt(removeComma2(by_new_cost_amt[j].value));
                sum_mgg = sum_mgg + parseInt(removeComma2(by_new_sale_amt[j].value));
                sum_mgy = sum_mgy + parseInt(removeComma2(by_vatAmt[j].value));
                totGapAmt = totGapAmt + parseInt(removeComma2(by_new_gat_amt[j].value));
                totCostAmt = totCostAmt + parseInt(removeComma2(by_new_cost_amt[j].value));
                totSaleAmt = totSaleAmt + parseInt(removeComma2(by_new_sale_amt[j].value));
                //totSaleAmt = totSaleAmt + parseInt(removeComma2(by_new_sale_amt[j].value)); 
            } 
             
            document.getElementById("IN_SRG").value = convAmt(String(sum_srg));
            document.getElementById("IN_WGG").value = convAmt(String(sum_wgg));
            document.getElementById("IN_MGG").value = convAmt(String(sum_mgg));
            document.getElementById("IN_VAT_TAMT").value = convAmt(String(sum_mgy));
 
            //20110524 차익액합계 
            document.getElementById("IN_GAP_TOT_AMT").value  = totGapAmt;
            
            //20110524 차익율 추가           
            var totGapRate = getCalcPord("GAP_RATE", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
            document.getElementById("IN_NEW_GAP_RATE").value = totGapRate;
              
            //20110523 부가세 추가
          //  var vatAmt = getCalcPord("VAT_AMT", cost_amt, "", "", strTaxFlag, roundFlag);
          //  document.getElementById("d_vatAmt"+row).value = vatAmt; 
         //   document.getElementById("IN_VAT_TAMT").value = vatAmt;      // 부가세 
        }  
    } 
    else{
        
        var strTaxFlag  = g_tax_flag; 
        var ord_qty = parseInt(removeComma2(document.getElementById("d_ord_qty"+row).value));     //발주수량 
        var cost_prc = parseInt(removeComma2(document.getElementById("d_new_cost_prc"+row).value)); // 원가단가
        var sale_prc = parseInt(removeComma2(document.getElementById("d_new_sale_prc"+row).value));// 매가단가
        
        //if(ord_qty == "") {
        //    cost_prc = 0;
        //    return;
        //}
        
        // 조회된 디데일 내역이 수정된 체크 수정전 매가금액을 변수에 담아 수정된 매가금액을 비교한다.
        var Fsale_amt = parseInt(removeComma2(document.getElementById("d_new_sale_amt"+row).value));
        
        var cost_amt    = cost_prc * ord_qty;                             // 원가금액 
        var gcost_prc   = 0;                                              // 원가단가(차익액, 차익율 위한)
        var sale_amt    = 0;                                              // 매가금액
        var gcost_amt   = 0;                                              // 원가금액(차익액, 차익율 위한)
        var strmargin = document.getElementById("d_mg_rate"+row).value;       //마진율
        var vatAmt = 0;                                                     //부가세
   
        //원가단가
        sale_amt     = sale_prc * ord_qty;   
        cost_amt     = getCalcPord("COST_PRC", "", sale_amt, strmargin, strTaxFlag, roundFlag);     // 원가금액(부가제제외)
        cost_amt_vat = getCalcPord("COST_PRC", "", sale_amt, strmargin, "2", roundFlag);            // 원가금액(부가제포함)
        
        // 발주수량이 0인경우 원가단가는 0처리
        if(ord_qty == ""){
            cost_prc     = "0";                                        // 원가단가
        }
        else{
            cost_prc     = getRoundDec("1", cost_amt / ord_qty);                                        // 원가단가
        }

        // 조회된 디데일 내역이 수정된 체크 수정전 매가금액을 변수에 담아 수정된 매가금액을 비교한다.
        if(Fsale_amt != sale_amt){
            frm.reg_date.value = "";
        }
        
        document.getElementById("d_new_cost_prc"+row).value = convAmt(String(cost_prc));             // 원가단가 
        document.getElementById("d_new_cost_amt"+row).value = convAmt(String(cost_amt));             // 원가금액 
        document.getElementById("d_new_sale_amt"+row).value = convAmt(String(sale_amt));             // 매가금액
        vatAmt = cost_amt_vat - cost_amt;
        document.getElementById("d_vatAmt"+row).value = vatAmt;                                        //부가세
        
        
        //디테일 차익액
        var gapAmt = getCalcPord("GAP_AMT", cost_amt, sale_amt, "", strTaxFlag, roundFlag);       
        document.getElementById("d_newGapAmt"+row).value  = gapAmt;      // 차익액
        
        var by_ord_qty = document.getElementsByName("d_ord_qty");
        var by_new_gat_amt = document.getElementsByName("d_newGapAmt");
        var by_new_cost_amt = document.getElementsByName("d_new_cost_amt");
        var by_new_sale_amt = document.getElementsByName("d_new_sale_amt"); 
        var by_vatAmt       = document.getElementsByName("d_vatAmt");
        var sum_srg = 0;
        var sum_wgg = 0;
        var sum_mgg = 0;
        var sum_mgy = 0;
        
        var totCostAmt = 0;
        var totSaleAmt = 0; 
        var totGapAmt = 0;
        
        for( j = 0; j < document.getElementsByName("d_ord_qty").length; j++ ){ 
            sum_srg = sum_srg + parseInt(removeComma2(by_ord_qty[j].value)); 
            sum_wgg = sum_wgg + parseInt(removeComma2(by_new_cost_amt[j].value));
            sum_mgg = sum_mgg + parseInt(removeComma2(by_new_sale_amt[j].value));
            sum_mgy = sum_mgy + parseInt(removeComma2(by_vatAmt[j].value));
            totGapAmt = totGapAmt + parseInt(removeComma2(by_new_gat_amt[j].value));
            totCostAmt = totCostAmt + parseInt(removeComma2(by_new_cost_amt[j].value));
            totSaleAmt = totSaleAmt + parseInt(removeComma2(by_new_sale_amt[j].value));
            //totSaleAmt = totSaleAmt + parseInt(removeComma2(by_new_sale_amt[j].value)); 
        } 
         
        document.getElementById("IN_SRG").value = convAmt(String(sum_srg));
        document.getElementById("IN_WGG").value = convAmt(String(sum_wgg));
        document.getElementById("IN_MGG").value = convAmt(String(sum_mgg));
        document.getElementById("IN_VAT_TAMT").value = convAmt(String(sum_mgy));
        

        
        //20110524 차익액합계 
        document.getElementById("IN_GAP_TOT_AMT").value  = totGapAmt;
        
        //20110524 차익율 추가                   
        
        var totGapRate = getCalcPord("GAP_RATE", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
        document.getElementById("IN_NEW_GAP_RATE").value = totGapRate;
         
        
        //20110523 부가세 추가
       // var vatAmt = getCalcPord("VAT_AMT", cost_amt, "", "", strTaxFlag, roundFlag);
      //  var vatAmt = cost_amt_vat - cost_amt;
      //  document.getElementById("d_vatAmt"+row).value = vatAmt; 
     //   document.getElementById("IN_VAT_TAMT").value = vatAmt;      // 부가세
    }
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
  
function add_del_row(flag) {
	if(flag == false) {
		enableControl(frm.IMG_BJDATE, false);
        enableControl(frm.IMG_NPYJDATE, false);
        enableControl(frm.IMG_MAJINDATE, false);
        document.getElementById("IN_PB_CD").disabled = true;                 //브랜드 입력부
        document.getElementById("IN_BJDATE").disabled = true;                //발주일 
        document.getElementById("IN_NPYJDATE").disabled = true;            //납품예정일 
        document.getElementById("IN_MAJINDATE").disabled = true;           //마진적용일 
        document.getElementById("IN_HS_GBN").disabled = true;              //행사구분 
        document.getElementById("IN_HS_RATE").disabled = true;             //행사율 
	}
	else {
		enableControl(frm.IMG_BJDATE, true);
        enableControl(frm.IMG_NPYJDATE, true);
        enableControl(frm.IMG_MAJINDATE, true);
        document.getElementById("IN_PB_CD").disabled = false;                 //브랜드 입력부
        document.getElementById("IN_BJDATE").disabled = false;                //발주일 
        document.getElementById("IN_NPYJDATE").disabled = false;            //납품예정일 
        document.getElementById("IN_MAJINDATE").disabled = false;           //마진적용일 
        document.getElementById("IN_HS_GBN").disabled = false;              //행사구분 
        document.getElementById("IN_HS_RATE").disabled = false;             //행사율 
	}
}

/**
 * add_row()
 * 작 성 자     :김경은
 * 작 성 일     : 2011-08-16
 * 개    요        : 발주매입 상세(단품) ROW 추가
 * return값 : void
 */
 function add_row() { 
     if(dtlCount == 0){
      //   frm.chkAll.disabled = false;
         if(!checkValidation("Save"))
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

         // 스크롤 위치 초기화       
         document.all.DETAIL_Title.scrollLeft = 0;
         document.all.DETAIL_CONTENT.scrollLeft = 0; 
         
         if (dtlIdCount == 0) {
             var lastIndex = 0;
             var rowIndex = 0;
         } else { 
             var lastIndexId = document.getElementsByName("d_pummok_cd")[dtlIdCount-1].id
             var lastIndex = eval(lastIndexId.replace("d_pummok_cd", "")); 
             var rowIndex = eval(lastIndex) + 1; 
         }
 
    //  setMstObjControl(false);   // Master 활성화/비활성화
      var oRow    = tb_detail.insertRow();
      var oCell1  = oRow.insertCell();
      var oCell2  = oRow.insertCell();
      var oCell3  = oRow.insertCell();
      var oCell4  = oRow.insertCell();
      var oCell5  = oRow.insertCell();
      var oCell6  = oRow.insertCell();
      var oCell7  = oRow.insertCell();
      var oCell8  = oRow.insertCell();
      var oCell9  = oRow.insertCell();
      var oCell10 = oRow.insertCell();
      var oCell11 = oRow.insertCell();
      var oCell12 = oRow.insertCell();
      var oCell13 = oRow.insertCell(); 
 
      oCell1.id          = "d_no"; 
      oCell1.className   = "r1";
      oCell1.style.width = "35";
      oCell1.innerHTML  =  dtlCount+1 ; 
      oCell2.className   = "r1";
      oCell2.style.width = "25"; 
      oCell2.innerHTML  += "<input type='hidden' name='d_strCd'      id='d_strCd"+rowIndex+"'      value=''/>";    // 점
      oCell2.innerHTML  += "<input type='hidden' name='d_slip_no'    id='d_slip_no"+rowIndex+"'    value='' />";   // 전표번호
      oCell2.innerHTML  += "<input type='hidden' name='d_ord_seq_no' id='d_ord_seq_no"+rowIndex+"' value='' />";   // 전표상세번호
      oCell2.innerHTML  += "<input type='hidden' name='d_pummokCd'   id='d_pummokCd"+rowIndex+"'   value='' />";   // 품목
      oCell2.innerHTML  += "<input type='hidden' name='d_ordUnitCd'  id='d_ordUnitCd"+rowIndex+"'  value='' />";   // 발주단위
      oCell2.innerHTML  += "<input type='hidden' name='d_newGapAmt'  id='d_newGapAmt"+rowIndex+"'  value='' />";   // 신차익액
      oCell2.innerHTML  += "<input type='hidden' name='d_pumbunCd'   id='d_pumbunCd"+rowIndex+"'   value='' />";   // 브랜드
      oCell2.innerHTML  += "<input type='hidden' name='d_venCd'      id='d_venCd"+rowIndex+"'      value='' />";   // 협력사
      oCell2.innerHTML  += "<input type='hidden' name='d_slipFlag'   id='d_slipFlag"+rowIndex+"'   value='' />";   // 전표구분
      oCell2.innerHTML  += "<input type='hidden' name='d_mgRate'     id='d_mgRate"+rowIndex+"'     value='' />";   // 마진율
      oCell2.innerHTML  += "<input type='hidden' name='d_vatAmt'     id='d_vatAmt"+rowIndex+"'     value='' />";   // 부가세 
      
      oCell2.innerHTML  += "<input type='checkbox' name='d_check1' id='d_check1"+rowIndex+"' value='' style='width:25;text-align:center;'/>";
      
      oCell3.className   = "r1";
      oCell3.style.width = "85";
      oCell3.innerHTML   = "<input type='text'    name='d_pummok_cd'  id='d_pummok_cd"+rowIndex+"'  value='' style='width:55;text-align:center;' maxlength='13' onkeypress='javascript:onlyNumber();' onblur='pummokBlur("+rowIndex+");' />";
      oCell3.innerHTML  += " <input type='button' name='pummokImg' id='pummokImg"+rowIndex+"'  onclick='getPbnPmkPop("+rowIndex+");' onkeydown='if(event.keyCode == 13){ getPbnPmkPop("+rowIndex+");}' value='..' />";
      
      oCell4.id          = "td_skuNm";
      oCell4.className   = "r1";
      oCell4.style.width = "85";
      oCell4.innerHTML   = "<input type='text' name='d_pummok_nm'      id='d_pummok_nm"+rowIndex+"'      value='' style='width:85;text-align:left;' maxlength='40' disabled='disabled'/>";
      
      oCell5.className   = "r1";
      oCell5.style.width = "45";
      oCell5.innerHTML   = "<input type='text' name='d_ord_unit_cd'  id='d_ord_unit_cd"+rowIndex+"'  value='' style='width:45;text-align:left;' maxlength='3' disabled='disabled' />";
      
      oCell6.className   = "r1";
      oCell6.style.width = "45";
      oCell6.innerHTML   = "<input type='text' name='d_ord_qty'     id='d_ord_qty"+rowIndex+"'     value='0' onkeypress='javascript:onlyNumber();' style='width:45;text-align:right; IME-MODE: disabled;' maxlength='7'  onblur='javascript:calcDetail("+rowIndex+");' />";
      
      oCell7.className   = "r1";
      oCell7.style.width = "45";
      oCell7.innerHTML   = "<input type='text' name='d_mg_rate' id='d_mg_rate"+rowIndex+"' value='' style='width:45;text-align:right;' maxlength='5' disabled='disabled' />";
      
      oCell8.className   = "r1";
      oCell8.style.width = "85";
      oCell8.innerHTML   = "<input type='text' name='d_new_cost_prc' id='d_new_cost_prc"+rowIndex+"' value='0' style='width:85;text-align:right;' maxlength='13' disabled='disabled' />";
      
      oCell9.className   = "r1";
      oCell9.style.width = "85";
      oCell9.innerHTML   = "<input type='text' name='d_new_cost_amt' id='d_new_cost_amt"+rowIndex+"' value='0' style='width:85;text-align:right;IME-MODE: disabled' maxlength='9' disabled='disabled' />";
      
      oCell10.className   = "r1";
      oCell10.style.width = "85";
      oCell10.innerHTML   = "<input type='text' name='d_new_sale_prc' id='d_new_sale_prc"+rowIndex+"' value='0' onkeypress='javascript:onlyNumber();' onblur='javascript:calcDetail("+rowIndex+");' onkeydown=' if(event.keyCode == 13){ calcDetail("+rowIndex+"); add_row("+dtlIdCount+"); } ' style='width:85;text-align:right;IME-MODE: disabled' maxlength='9'  />";

      oCell11.className   = "r1";
      oCell11.style.width = "85";
      oCell11.innerHTML   = "<input type='text' name='d_new_sale_amt' id='d_new_sale_amt"+rowIndex+"' value='0' style='width:85;text-align:right;' disabled='disabled' />";
      
      oCell12.className   = "r1";
      oCell12.style.width = "35";
      oCell12.innerHTML   = "<input type='text' name='d_tag_flag' id='d_tag_flag"+rowIndex+"' value='' style='width:25;text-align:right;' disabled='disabled' />";
      
      oCell13.className   = "r1";
      oCell13.style.width = "55";
      oCell13.innerHTML   = "<input type='text' name='d_tag_prt_own_flag' id='d_tag_prt_own_flag"+rowIndex+"' value='' style='width:45;text-align:right;' maxlength='40' disabled='disabled' />";
  
      if (dtlIdCount < 0) {
          return; 
      }
      else if (dtlIdCount == 0) {
         //var pre_cnt        = detailRowCnt-1;                            // 이전row   
          var strPre_PumCd   = document.getElementById("d_pummok_cd"+lastIndex).value;             // 이전 row의 품목코드 
          var strPre_PumNm   = document.getElementById("d_pummok_nm"+lastIndex).value;             // 이전 row의 품목명
          var strPre_Dan     = document.getElementById("d_ord_unit_cd"+lastIndex).value;           // 이전 row의 단위
          var strPre_TagFlag = document.getElementById("d_tag_flag"+lastIndex).value;              // 이전 row의 TAG구분
          var strPre_OwnFlag = document.getElementById("d_tag_prt_own_flag"+lastIndex).value;      // 이전 row의 TAG발행주체 

          document.getElementById("d_mg_rate"+rowIndex).value            = norm_mg_rate;
          document.getElementById("d_pummok_cd"+rowIndex).value          = strPre_PumCd;
          document.getElementById("d_pummok_nm"+rowIndex).value          = strPre_PumNm;
          document.getElementById("d_ord_unit_cd"+rowIndex).value        = strPre_Dan;
          document.getElementById("d_tag_flag"+rowIndex).value = strPre_TagFlag;
          document.getElementById("d_tag_prt_own_flag"+rowIndex).value   = strPre_OwnFlag;
          frm.reg_date.value = "";
           
          setTimeout("document.getElementById('d_pummok_cd"+rowIndex+"').focus();", 100);
      }
      else {  
          var strPre_PumCd   = document.getElementById("d_pummok_cd"+lastIndex).value;             // 이전 row의 품목코드 
          var strPre_PumNm   = document.getElementById("d_pummok_nm"+lastIndex).value;             // 이전 row의 품목명
          var strPre_Dan     = document.getElementById("d_ord_unit_cd"+lastIndex).value;           // 이전 row의 단위
          var strPre_TagFlag = document.getElementById("d_tag_flag"+lastIndex).value;              // 이전 row의 TAG구분
          var strPre_OwnFlag = document.getElementById("d_tag_prt_own_flag"+lastIndex).value;      // 이전 row의 TAG발행주체 
          
          document.getElementById("d_mg_rate"+rowIndex).value            = norm_mg_rate;
          document.getElementById("d_pummok_cd"+rowIndex).value          = strPre_PumCd;
          document.getElementById("d_pummok_nm"+rowIndex).value          = strPre_PumNm;
          document.getElementById("d_ord_unit_cd"+rowIndex).value        = strPre_Dan;
          document.getElementById("d_tag_flag"+rowIndex).value = strPre_TagFlag;
          document.getElementById("d_tag_prt_own_flag"+rowIndex).value   = strPre_OwnFlag;
     //     g_tax_flag         
          frm.reg_date.value = "";
           
         setTimeout("document.getElementById('d_pummok_cd"+rowIndex+"').focus();", 100);
          
      }
      setTimeout("document.getElementById('d_pummok_cd"+rowIndex+"').focus();", 1);
      dtlCount++;                // No
      dtlIdCount++;              // 상세ID Count
 }
  
 /**
  * btn_new()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  신규 등록
  * return값 : void
*/ 
function btn_new(){
	  
	    if(document.getElementById("strVenCd").value == "") {
	        showMessage(INFORMATION, OK, "USER-1003", "협력사코드");
	        document.getElementById("strVenCd").focus();
	        return;
       }
    
    new_row = "3";
    strSlip_no_new = "";
    clearData();   //전체 초기화
    detailRowCnt = 0;
    frm.reg_date.value          = "";                 // 전표등록일자
    document.getElementById("IN_STR_CD").value = '<%=strcd%>';
    document.getElementsByName("IN_SLIP_FLAG")[0].checked = true;
    document.getElementById("IN_SH_GBN").value = "0";
    document.getElementById("IN_SH_GBN_NM").value = "사전전표";
    document.getElementById("IN_PB_CD").options[0].selected = true;
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
  //  document.getElementById("HRS_CD").value = "";
  //  document.getElementById("HRS_NM").value = "";
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
    document.getElementById("IN_MGG").value = "";
    document.getElementById("IN_ETC").value = "";
    document.getElementById("IN_GAP_TOT_AMT").value = "0";
    document.getElementById("IN_NEW_GAP_RATE").value = "0";
    document.getElementById("IN_VAT_TAMT").value = "0";
    

    // 스크롤 위치 초기화        
    document.all.DETAIL_Title.scrollLeft = 0;
    document.all.DETAIL_CONTENT.scrollLeft = 0; 
    
    getpumbunGbBu();
    
    var div_detail = "<table width='860' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_detail'>";
    div_detail += "</table>";
    document.getElementById("DETAIL_CONTENT").innerHTML = div_detail;
    
    setObject(true);
    enableControl(frm.IMG_ADD, true);
    enableControl(frm.IMG_DEL, true);
    document.getElementById('IN_PB_CD').focus();    
}
 
/**
 * getpumbunGbBu()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  브랜드에 따라 활성화, 비활성화 , 관세, 바이이 설정
 * return값 : void
 */ 
function getpumbunGbBu(){
 //   alert();
     var strcd = '<%=strcd%>';                                                        //점코드
     var vencd = document.getElementById("HRS_CD").value;                             //협력사코드
     var pumbuncd = document.getElementById("IN_PB_CD").value;                        //브랜드코드
 
 //    document.getElementById("IN_PB_CD").value = "";
 //    getPumbunCombo(strcd, vencd, "IN_PB_CD", "N","2");   
//     document.getElementById("IN_PB_CD").options[0].selected = true;
     
     var param = "&goTo=getpumbunGbBun&strcd=" + strcd
                                              + "&vencd=" + vencd
                                              + "&pumbuncd=" + pumbuncd;
                                              
     <ajax:open callback="on_getMasterXML" 
         param="param" 
         method="POST" 
         urlvalue="/edi/eord107.eo"/>
     
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
                   //     alert(tax_flag);
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
          //  document.getElementById("HRS_CD").value = vencd;
          //  document.getElementById("HRS_NM").value = venNm;
            
            //협력사 반올림 구분
            getVenRound(strcd, vencd);
            
            // 저장시 다시 한번 브랜드의 존재여부를 확인하기 위해
            getMarginFlag();
            
          //  document.getElementById("IN_BJDATE").focus();
            
            
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
             
             
        	 if(document.getElementById("HRS_CD").length < 0) {
        		 document.getElementById("HRS_CD").focus();
        		 return;
        	 }
        	 else { 
                 document.getElementById("HRS_CD").focus();
                
                  document.getElementById("IN_PB_CD").disabled = false;                 //브랜드 입력부
                
                  return;
        	 }
        	  
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
     
     var param = "&goTo=getMarginFlag&strcd="                    + strStrCd
                                              + "&pumbuncd="     + strPumbunCd
                                              + "&marginAppdt="  + strMarginAppDt;
     
     <ajax:open callback="on_getMarginFlagXML" 
         param="param" 
         method="POST" 
         urlvalue="/edi/eord107.eo"/>
     
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
        urlvalue="/edi/eord107.eo"/>
    
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
     var strBjDt = getRawData(trim( document.getElementById("IN_BJDATE").value ));              //발주일
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
    
     var strBjDt = getRawData(trim( document.getElementById("IN_BJDATE").value ));              //발주일
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
    var strBjDt = getRawData(trim( document.getElementById("IN_BJDATE").value ));              //발주일
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
         
         if( tr_cnt > 0 ){
             
             var j = 0;
             var PumMokCds   = document.getElementsByName("d_pummok_cd");
             var intQty  = document.getElementsByName("d_ord_qty");
             var intNewSalePrc   = document.getElementsByName("d_new_sale_prc");
             
             
             for( i = 0; i < PumMokCds.length; i++ ){
                 j = i;
                 if( PumMokCds[i].value == "" ){
                     showMessage(INFORMATION, OK, "USER-1003", "품목코드");
                     document.getElementsByName("d_pummok_cd")[i].focus();
                     return false;
                 }
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
                 
             }
             
             
         }
         
     } else if(gbun == "Delete"){
    	 var strBj = document.getElementById("IN_BJDATE").value;
    	 
         if(replaceStr(strBj,"/", "") != strToday){
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
    //  alert(falg);
     if( !falg ){
    //	 alert("1");
         document.getElementsByName("IN_SLIP_FLAG")[0].disabled = true;       //전표구분1
         document.getElementsByName("IN_SLIP_FLAG")[1].disabled = true;       //전표구분2
         document.getElementById("IN_PB_CD").disabled = true;                 //브랜드 입력부
         document.getElementById("IN_BJDATE").disabled = true;                //발주일 
         document.getElementById("IN_NPYJDATE").disabled = true;            //납품예정일 
         document.getElementById("IN_MAJINDATE").disabled = true;           //마진적용일 
         document.getElementById("IN_HS_GBN").disabled = true;              //행사구분 
         document.getElementById("IN_HS_RATE").disabled = true;             //행사율 
         document.getElementById("IN_ETC").disabled = true;                 //비고 
         
     } else {
   //      alert("2");
         document.getElementsByName("IN_SLIP_FLAG")[0].disabled = false;       //전표구분1
         document.getElementsByName("IN_SLIP_FLAG")[1].disabled = false;       //전표구분2
         document.getElementById("IN_PB_CD").disabled = false;                 //브랜드 입력부
         document.getElementById("IN_BJDATE").disabled = false;                //발주일 
         document.getElementById("IN_NPYJDATE").disabled = false;            //납품예정일 
         document.getElementById("IN_MAJINDATE").disabled = false;           //마진적용일 
         document.getElementById("IN_HS_GBN").disabled = false;              //행사구분 
         document.getElementById("IN_HS_RATE").disabled = false;             //행사율 
         document.getElementById("IN_ETC").disabled = false;                 //비고  
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
         enableControl(frm.IMG_BJDATE, false);
         enableControl(frm.IMG_NPYJDATE, false);
         enableControl(frm.IMG_MAJINDATE, false);
     } else {
         enableControl(frm.IMG_BJDATE, true);
         enableControl(frm.IMG_NPYJDATE, true);
         enableControl(frm.IMG_MAJINDATE, true);
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
        var strVenCd = document.getElementById("HRS_CD").value;
        if( ven_cd != ""){
            
            var param = "&goTo=getVenRoundFlag" + "&strcd=" + strcd
                                                + "&ven_cd=" + strVenCd;
            
            <ajax:open callback="on_getVenRoundFlagXML" 
                param="param" 
                method="POST" 
                urlvalue="/edi/eord107.eo"/>
            
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
 * 작 성 자     :김경은
 * 작 성 일     : 2011-08-16
 * 개    요        : 발주매입 상세 ROW 삭제
 * return값 : void
 */
 function row_delete() {
     var chkLen = document.getElementsByName("d_check1").length;   
     if(chkLen == 0){
         // 삭제할 내역이 없습니다.
         showMessage(EXCLAMATION, OK, "USER-1019");
         return;
     }

     for(var i = chkLen; i > 0; i--){
         if(document.getElementsByName("d_check1")[i-1].checked){
             var ord_seq_no = document.getElementsByName("d_ord_seq_no")[i-1].value;
             var gb         = frm.del_detail.value == "" ? "":"/"; 
             if(ord_seq_no != " "){
               frm.del_detail.value +=  gb + ord_seq_no;
             }  
             tb_detail.deleteRow(i-1);
             calcDetail("D");
             dtlCount--; 
             dtlIdCount--;
         }
     }
     frm.reg_date.value = "";
    if(dtlCount != 0){
        setNo(d_no);                 // No을 다시 세팅
    }else{
     //   frm.chkAll.checked = false;
        setObject(true); // Master 활성화/비활성화
    }
 } 

 /**
  * setNo(obj)
  * 작 성 자 : 김경은
  * 작 성 일 : 2011-08-19
  * 개    요   : Row 삭제시 상세내역 (단품정보)의 순번을 변경한다.
  * return : void
  */
  function setNo(obj){
      var len = obj.length;
      if(len == undefined){
          obj.innerHTML = 1;
      }else{
          for(var i = 0; i < len; i++){ 
              obj[i].innerHTML = i+1;
          }
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

function scrollAll(){
    document.all.DivListTitle.scrollLeft = document.all.DivListContent.scrollLeft;
}
function scrollAll2(){
    document.all.DETAIL_Title.scrollLeft = document.all.DETAIL_CONTENT.scrollLeft;
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



///품목팝업 띄우기//////////////////////////////////////////////////////////////////////////////////////////////////////                                                                                    //
/**
* pumbunSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2011-04-18
* 개    요 :  품목  팝업
* return값 : void
*/  
function pumbunSelPop(strVenCd, strStrCd, strPumbunCd, strPumbunNm, strGb){
     
  var rtnList  = new Array();
  var arrArg  = new Array();
  
  arrArg.push(rtnList);
  arrArg.push(strStrCd);
  arrArg.push(strVenCd); 
  arrArg.push(strPumbunCd); 
  arrArg.push(strPumbunNm); 
  arrArg.push(strGb); 
  arrArg.push("D"); 
  
     var returnVal = window.showModalDialog("/edi/ccom012.cc?goTo=PumbunPop",
                                            arrArg,
                                            "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
      
     if (returnVal){
         
         return arrArg[0];
     }
     return null;
}

/**
* getPbmbunPop()
* 작 성 자 : FKL
* 작 성 일 : 2011-04-18
* 개    요 :  품목코드 
* return값 : void
*/ 
function getPbmbunPop(strPumbunCd, strPumbunNm, strGb){ 
  var strStrCd = document.getElementById("strcd").value;
  var strVenCd = document.getElementById("strVenCd").value;
  var strGb = "2";
 // var strPumbun = document.getElementById("pumbunCd").value;
  if(strPumbunCd == undefined){
      strPumbunCd = "";
  }  
  
  if(strVenCd == ""){
       showMessage(INFORMATION, OK, "GAUCE-1000", "협력사 코드를 입력하세요");  
       document.getElementById("venCd").focus();
       return;
  }
  
  var rtnList = pumbunSelPop(strVenCd, strStrCd, strPumbunCd, strPumbunNm, strGb, "", "", "N");
  
   if(rtnList != null){
        
       var returnList = rtnList; 
       if( returnList.length == 1 ){
          var returnValue =  returnList[0].split(":");
          
          document.getElementById("strPbCd").value = returnValue[0];
          document.getElementById("strPbNm").value = returnValue[1]; 
          
       }
   }  
   else { 
       if(strPumbunCd.length < 6){  //브랜드코드가 6자리 미만 입력시 선택 안하고 팝업 닫으면 브랜드코드, 브랜드명 초기화
           document.getElementById("strPbCd").value = "";
           document.getElementById("strPbNm").value = "";
       }
   }
} 

//브랜드코드 onblur 이벤트 발생시 브랜드팝업 호출
function pumbun() {
  var strPumbunCd = document.getElementById("strPbCd").value;
  var strPumbunNm = document.getElementById("strPbNm").value;
  var strStrCd = document.getElementById("strcd").value;
  var strVenCd = document.getElementById("strVenCd").value; 
  var strGb = "2";
  
/*  if(strVenCd == ""){
      showMessage(INFORMATION, OK, "GAUCE-1000", "협력사 코드를 입력하세요");  
      document.getElementById("pumbunCd").value = "";
      document.getElementById("venCd").focus();
      return;
 }*/

  if(strPumbunCd.length > 0 || strPumbunNm.length > 0){
  
      var param = "&goTo=getPumbunBlur" + "&strStrCd="       + strStrCd
                                        + "&strVenCd="       + strVenCd
                                        + "&strPumbunCd="    + strPumbunCd
                                        + "&strPumbunNm="    + strPumbunNm
                                        + "&strGb="          + strGb;

          <ajax:open callback="on_getPumbunBlurXML" 
          param="param" 
          method="POST" 
          urlvalue="/edi/ccom012.cc"/>
          
          <ajax:callback function="on_getPumbunBlurXML">
        //  alert(rowsNode.length);
          if( rowsNode.length < 1 ){ 
              getPbmbunPop(strPumbunCd, strPumbunNm, strGb);
          }
          else {
          
              document.getElementById("strPbCd").value = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
              document.getElementById("strPbNm").value = rowsNode[0].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[1].childNodes[0].nodeValue;   
          } 
          </ajax:callback> 
  }
  else {
      document.getElementById("strPbNm").value = "";
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///협력사 팝업 띄우기//////////////////////////////////////////////////////////////////////////////////////////////////////                                                                                    //
/**
* venSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2011-04-18
* 개    요 :  협력사 팝업
* return값 : void
*/  
function venSelPop(strVenCd, strVenNm, strStrCd){
  
  var rtnList  = new Array();
  var arrArg  = new Array(); 
  
  arrArg.push(rtnList);
  arrArg.push(strVenCd);
  arrArg.push(strVenNm);
  arrArg.push(strStrCd); 
  arrArg.push("D");
   
     var returnVal = window.showModalDialog("/edi/ccom016.cc?goTo=VenPop",
                                            arrArg,
                                            "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
      
     if (returnVal){
         
         return arrArg[0];
     }
     return null;
}

/**
* getVenPop()
* 작 성 자 : FKL
* 작 성 일 : 2011-04-18
* 개    요 :  협력사 코드팝업
* return값 : void
*/ 
function getVenPop(strVenCd, strVenNm){ 
  var strStrCd = document.getElementById("strcd").value;
  if(strVenCd == undefined){
      strVenCd = "";
  }
  var rtnList = venSelPop(strVenCd, strVenNm, strStrCd, "", "", "N");
  
   if(rtnList != null){
        
       var returnList = rtnList; 
       if( returnList.length == 1 ){
          var returnValue =  returnList[0].split(":");
          
          document.getElementById("strVenCd").value = returnValue[0];
          document.getElementById("strVenNm").value = returnValue[1]; 
          document.getElementById("HRS_CD").value = returnValue[0];
          document.getElementById("HRS_NM").value = returnValue[1]; 
          
       }
   } 
   else { 
       if(strVenCd.length < 6){  //협력사 코드가 6자리 미만 입력시 선택 안하고 팝업 닫으면 협력사코드, 협력사명 초기화
           document.getElementById("strVenCd").value = "";
           document.getElementById("strVenNm").value = "";
           document.getElementById("HRS_CD").value = "";
           document.getElementById("HRS_NM").value = "";
       }
   }
} 

//브랜드코드 onblur 이벤트 발생시 브랜드팝업 호출
function ven() {  
 //   alert("1");
      var strStrCd = document.getElementById("strcd").value; 
      var strVenCd = document.getElementById("strVenCd").value; 
      var strVenNm = document.getElementById("strVenNm").value; 
      
      if(strVenCd.length > 0 || strVenNm.length > 0){
      
          var param = "&goTo=getVenBlur" + "&strStrCd="       + strStrCd
                                            + "&strVenCd="       + strVenCd
                                            + "&strVenNm="       + strVenNm;

              <ajax:open callback="on_getVenBlurXML" 
              param="param" 
              method="POST" 
              urlvalue="/edi/ccom016.cc"/>
              
              <ajax:callback function="on_getVenBlurXML">
            //  alert(rowsNode.length);
              if( rowsNode.length < 1 ){ 
                  getVenPop(strVenCd, strVenNm);
              }
              else {
              
                  document.getElementById("strVenCd").value = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
                  document.getElementById("strVenNm").value = rowsNode[0].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[1].childNodes[0].nodeValue;   
              } 
              </ajax:callback> 
      }
      else {
          document.getElementById("strVenNm").value = "";
      }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function clear_text(strCd, strGbn) { 
    var strCdlen = strCd.value;
    if(strGbn == "1"){ 
      //  alert(strCdlen.length);
        if(strCdlen.length < 6){ 
            document.getElementById("strVenNm").value = ""; 
        }
        if(strCd.value == "") {
            document.getElementById("strVenNm").value = ""; 
        }
    }
    else if (strGbn == "2") {
        if(strCd.value == "") {
            document.getElementById("strVenCd").value = ""; 
        }
    }
    else if (strGbn == "3") {
        if(strCdlen.length < 6){ 
            document.getElementById("strPbNm").value = ""; 
        }
        if(strCd.value == "") {
            document.getElementById("strPbNm").value = ""; 
        }
    }
    else {
        if(strCd.value == "") {
            document.getElementById("strPbCd").value = ""; 
        }
    }
     
}



///협력사 팝업 띄우기//////////////////////////////////////////////////////////////////////////////////////////////////////                                                                                    //
/**
* venSelPop2()
* 작 성 자 : FKL
* 작 성 일 : 2011-04-18
* 개    요 :  협력사 팝업
* return값 : void
*/  
function venSelPop2(strVenCd, strVenNm, strStrCd){
  
  var rtnList  = new Array();
  var arrArg  = new Array(); 
  
  arrArg.push(rtnList);
  arrArg.push(strVenCd);
  arrArg.push(strVenNm);
  arrArg.push(strStrCd); 
  arrArg.push("D");
   
     var returnVal = window.showModalDialog("/edi/ccom016.cc?goTo=VenPop",
                                            arrArg,
                                            "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
      
     if (returnVal){
         
         return arrArg[0];
     }
     return null;
}

/**
* getVenPop()
* 작 성 자 : FKL
* 작 성 일 : 2011-04-18
* 개    요 :  협력사 코드팝업
* return값 : void
*/ 
function getVenPop2(strVenCd, strVenNm){ 
  var strStrCd = document.getElementById("strcd").value;
  if(strVenCd == undefined){
      strVenCd = "";
  }
  var rtnList = venSelPop2(strVenCd, strVenNm, strStrCd, "", "", "N");
  
   if(rtnList != null){
        
       var returnList = rtnList; 
       if( returnList.length == 1 ){
          var returnValue =  returnList[0].split(":");
          
          //alert();
          document.getElementById("HRS_CD").value = returnValue[0];
          document.getElementById("HRS_NM").value = returnValue[1]; 
          
       }
        
       getPumbunCombo(strcd, vencd, "IN_PB_CD", "N","2");  
      
   } 
   else { 
       if(strVenCd.length < 6){  //협력사 코드가 6자리 미만 입력시 선택 안하고 팝업 닫으면 협력사코드, 협력사명 초기화
           document.getElementById("HRS_CD").value = "";
           document.getElementById("HRS_NM").value = "";
       }
   }
} 

//브랜드코드 onblur 이벤트 발생시 브랜드팝업 호출
function ven2() { 
	//alert("2");
      var strStrCd = document.getElementById("strcd").value; 
      var strVenCd = document.getElementById("HRS_CD").value; 
      var strVenNm = document.getElementById("HRS_NM").value; 
      
      if(strVenCd.length > 0 || strVenNm.length > 0){
      
          var param = "&goTo=getVenBlur" + "&strStrCd="       + strStrCd
                                            + "&strVenCd="       + strVenCd
                                            + "&strVenNm="       + strVenNm;

              <ajax:open callback="on_getVenBlurXML" 
              param="param" 
              method="POST" 
              urlvalue="/edi/ccom016.cc"/>
              
              <ajax:callback function="on_getVenBlurXML">
            //  alert(rowsNode.length);
              if( rowsNode.length < 1 ){ 
                  getVenPop2(strVenCd, strVenNm);
              }
              else {
              
                  document.getElementById("HRS_CD").value = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
                  document.getElementById("HRS_NM").value = rowsNode[0].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[1].childNodes[0].nodeValue;   
              } 
              </ajax:callback> 
      }
      else {
          document.getElementById("HRS_NM").value = "";
      }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function clear_text2(strCd, strGbn) { 
    var strCdlen = strCd.value;
    if(strGbn == "1"){ 
      //  alert(strCdlen.length);
        if(strCdlen.length < 6){ 
            document.getElementById("HRS_NM").value = ""; 
        }
        if(strCd.value == "") {
            document.getElementById("HRS_NM").value = ""; 
        }
    }
    else if (strGbn == "2") {
        if(strCd.value == "") {
            document.getElementById("HRS_CD").value = ""; 
        }
    } 
}

</script>

</head>
<body class="PL10 PT15" onload="doinit();">

<form name="frm">
<table width="97%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="396" class="title"><img
					src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13"
					align="absmiddle" class="PR05" /> EDI 발주등록(대행업체)</td>
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
						<td width="100"><input type="text" name="strnm" id="strnm"
							size="15" maxlength="10" value="<%=strNm%>" disabled="disabled" />
						<input type="hidden" name="strcd" id="strcd" value="<%=strcd%>">
						</td>
						<th width="80" class="point input_pk">협력사코드</th>
						<td width="200"><input type="text" name="strVenCd"
							id="strVenCd" size="10" maxlength="6" align="absmiddle"
							onkeydown='if(event.keyCode == 13 || event.keyCode == 9){ clear_text(this,"1"); ven(); }'
							onblur="clear_text(this,'1');" onkeyup="clear_text(this,'1');" />
						<img src="<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							onclick="getVenPop(document.getElementById('strVenCd').value, document.getElementById('strVenNm').value);" />
						<input type="text" name="strVenNm" id="strVenNm" size="15"
							align="absmiddle"
							onkeydown='if(event.keyCode == 13|| event.keyCode == 9){ clear_text(this,"2"); ven(); }'
							onblur="clear_text(this,'2');" /></td>
						<th>브랜드코드</th>
						<td><input type="text" name="strPbCd" id="strPbCd" size="10"
							maxlength="6" align="absmiddle"
							onkeydown='if(event.keyCode == 13|| event.keyCode == 9){ clear_text(this,"3"); pumbun(); }'
							onblur="clear_text(this,'3');" onkeyup="clear_text(this,'3');" />
						<img src="<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							onclick="getPbmbunPop(document.getElementById('strPbCd').value, document.getElementById('strPbNm').value);" />
						<input type="text" name="strPbNm" id="strPbNm" size="15"
							align="absmiddle"
							onkeydown='if(event.keyCode == 13|| event.keyCode == 9){ clear_text(this,"4"); pumbun(); }'
							onblur="clear_text(this,'4');" /></td>
					</tr>
					<tr>
						<th width="80">전표상태</th>
						<td width="100"><!--  <input type="text"  name="strnm" id="strnm" size="20" maxlength="10" value="" disabled="disabled" />-->
						<select name="Sel_slip_proc_falg" id="Sel_slip_proc_falg"
							style="width: 100;">
							<input type="hidden" name="slip_no_new" id="slip_no_new">
						</select></td>
						<th width="80">기준일</th>
						<td width="140"><select name="gjDate" id="gjDate"
							style="width: 132;"></select></td>
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
								<th width="65">전표구분</th>
								<th width="75">전표번호</th>
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

										<th width="70" class="point">전표구분</th>
										<td width="100"><input type="radio" name="IN_SLIP_FLAG"
											id="IN_SLIP_FLAG" value="A" checked="checked" /> 매입 <input
											type="radio" name="IN_SLIP_FLAG" id="IN_SLIP_FLAG" value="B" />
										반품</td>
										<th width="85" class="point">사후구분</th>
										<td width="95"><input type="text" name="IN_SH_GBN_NM"
											id="IN_SH_GBN_NM" size="13" class="input_pk"
											disabled="disabled" value="사전전표" /> <input type="hidden"
											name="IN_SH_GBN" id="IN_SH_GBN" value="0" /></td>
										<th width="70">과세구분</th>
										.
										<td><input type="hidden" name="IN_GS_GBN" id="IN_GS_GBN"
											size="8" /> <input type="text" name="IN_GS_GBN_NM"
											id="IN_GS_GBN_NM" size="14" disabled="disabled" /></td>
									</tr>
									<tr>
										<th class="point">협력사</th>
										<td colspan="3"><input type="text" name="HRS_CD" disabled="disabled"
											id="HRS_CD" size="15" maxlength="6" align="absmiddle"
											onkeydown='if(event.keyCode == 13 || event.keyCode == 9){ clear_text2(this,"1"); ven2(); }'
											onblur="clear_text2(this,'1');"
											onkeyup="clear_text2(this,'1');" /> <img id="Iven_Img" disabled="disabled"
											src="<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
											onclick="getVenPop2(document.getElementById('HRS_CD').value, document.getElementById('HRS_NM').value);" />
										<input type="text" name="HRS_NM" id="HRS_NM" size="25"
											align="absmiddle" disabled="disabled"
											onkeydown='if(event.keyCode == 13|| event.keyCode == 9){ clear_text2(this,"2"); ven(); }'
											onblur="clear_text2(this,'2');" /></td>
										<th class="point">브랜드</th>
										<td>
										<select name="IN_PB_CD" id="IN_PB_CD"
                                            class="combo_pk" onchange="getpumbunGbBu();"
                                            style="width: 92;">
                                        </select>
									</tr>
									<tr>
										<th>발주주체</th>
										<td><input type="hidden" name="IN_BALJUJC"
											id="IN_BALJUJC" size="10" value="1" /> <input type="text"
											name="ord_own_falg_nm" id="ord_own_falg_nm"
											disabled="disabled" size="14" value="EDI발주" /></td>
										<th class="point" width="90">발주일</th>
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
										<th class="point">행사구분/행사율</th>
										<td colspan="3"><select name="IN_HS_GBN" class="combo_pk"
											id="IN_HS_GBN" style="width: 60" onchange="getMarginRate();">
										</select> <select name="IN_HS_RATE" class="combo_pk" id="IN_HS_RATE"
											style="width: 70">
										</select></td>
									</tr>
									<tr>
										<th>검품확정일</th>
										<td><input type="text" name="IN_GPWJ_DATE"
											id="IN_GPWJ_DATE" size="14" disabled="disabled" /></td>
										<th>수량계</th>
										<td><input type="text" name="IN_SRG" id="IN_SRG"
											size="13" style="text-align: right;" disabled="disabled">
										</td>
										<th>원가계</th>
										<td><input type="text" size="10" id="IN_WGG"
											name="IN_WGG" style="text-align: right;" disabled="disabled" />
										</td>
									</tr>
									<tr>
										<th>매가계</th>
										<td colspan="5"><input type="text" name="IN_MGG"
											id="IN_MGG" size="14" style="text-align: right;"
											disabled="disabled" /></td>
									</tr>
									<tr>
										<th>비고</th>
										<td colspan="5"><input type="text" size="74"
											name="IN_ETC" id="IN_ETC" onblur="remarkCh(this);"
											onkeyup="checkByteLength(this, 100);" /></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr></tr>
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
									onclick="add_row();" /> <img
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
										<th rowspan="2" width="25">선택 <input type="checkbox"
											name="check1" id="check1" onclick="allChk();"></th>
										<th rowspan="2" width="85">품목코드</th>
										<th rowspan="2" width="85">품목명</th>
										<th rowspan="2" width="45">단위</th>
										<th rowspan="2" width="45">* 수량</th>
										<th rowspan="2" width="45">마진율</th>
										<th colspan="2" width="170">원가</th>
										<th colspan="2" width="170">매가</th>
										<th rowspan="2" width="35">TAG<br>
										구분</th>
										<th rowspan="2" width="55">TAG발<br>
										행주체</th>
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
								<div id="DETAIL_CONTENT"
									style="width: 560px; height: 170px; overflow: scroll"
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
			</tr>
		</table>
		</td>
	</tr>

	<input type="hidden" name="last_row" id="last_row" value=-1>
	<!-- List 이전 선택 Row -->
	<input type="hidden" name="reg_date" id="reg_date" value="99999999">
	<!-- 전표등록일자 -->
	<input type="hidden" name="vat_tamt" id="vat_tamt" value="">
	<!-- 부가세합 -->
	<input type="hidden" name="del_detail" id="del_detail" value="">
	<!-- 삭제된 상세순번 -->
	</form>
</body>
</html>

