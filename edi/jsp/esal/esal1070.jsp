<!-- 
/*******************************************************************************
 * 시스템명 : 협력사EDI > 영업실적 > 장부재고조회
 * 작 성 일 : 2011.08.30
 * 작 성 자 : 김 경 은
 * 수 정 자 : 
 * 파 일 명 : esal1070.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 단품의 장부재고를 조회한다.
 * 이    력 :
 * 
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
    String USER_ID = sessionInfo.getUSER_ID();                      // 사용자아이디
    String STR_CD  = sessionInfo.getSTR_CD();                       // 점코드
    String STR_NM  = sessionInfo.getSTR_NM();                       // 점명
    String VEN_CD  = sessionInfo.getVEN_CD();                       // 협력사코드
    String VEN_NM  = sessionInfo.getVEN_NAME();                     // 협력사명
    String GB      = sessionInfo.getGB();                           // 1. 협력사     2.브랜드
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

var base_qty    = 0;
var base_amt    = 0;
var buy_qty     = 0;
var buy_amt     = 0;
var sale_qty    = 0;
var sale_amt    = 0;
var stk_adj_qty = 0;
var stk_adj_amt = 0;
var srvy_e_qty  = 0;
var srvy_e_amt  = 0;
var gb = '<%=GB%>';
var pumbunNm    = '<%=pumbunNm%>';
var pumbunCd    = '<%=pumbunCd%>';
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
    enableControl(excel,true);    //엑셀
    enableControl(prints,false);   //프린터
    enableControl(set,false);      //출력
    
    /*  조회부 */
    //getPumbunCombo(g_strcd, vencd, "pumbun_cd", "Y");             //점별 브랜드
    /* 구분 값이 브랜드로 로그인시 "전체" 값 없음 */
    if(gb=="1"){
    	getPumbunCombo('<%=STR_CD%>', '<%=VEN_CD%>', 'pumbun_cd', 'Y', '1','1','<%=pumbunCd%>');        // 브랜드 조회조건	
    }else{
    	getPumbunCombo('<%=STR_CD%>', '<%=VEN_CD%>', 'pumbun_cd', 'N', '1','1','<%=pumbunCd%>');        // 브랜드 조회조건
    }
    
    
    initDateText('TODAY', 'sDate');    //시작일
    document.getElementById("str_cd").value = '<%=STR_CD%>';  
    
}

/**
 * getPumbunCombo()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-10
 * 개    요    : 점별브랜드콤보
 *          strcd   : 점코드
 *          vencd   : 협력사코드
 *          target  : 진행 할 항목
 *          allGB   : Y 전체 포함,N 전체 포함 안함
 *          skuFlag : 단품구분 (1: 단품조건, 2: 비단품조건)
 *          skuType : 단품종류 (1:규격, 2:신선, 3:의류)
 * return : void
 */ 
 function getPumbunCombo(str_cd, venCd, target, allGB, skuFlag, skuType, pumbunCd){
      var param = "";
     
      param = "&goTo=getPumbunSTK&strcd=" + str_cd
               + "&vencd="                  + venCd
               + "&skuFlag="                + skuFlag
               + "&skuType="                + skuType
               + "&pumbunCd="                + pumbunCd;
     
     <ajax:open callback="on_loadedXML" 
         param="param" 
         method="POST" 
         urlvalue="/edi/ccom001.cc"/>
     
     <ajax:callback function="on_loadedXML">
        
        var pumbun    = document.getElementById(target);   // object
        var optLen    = 0;                                 // option Length
        var pumbun_cd = "";                                // 브랜드
        var pumbun_nm = "";                                // 브랜드명
        
        if( allGB == "Y" )
            pumbun.options[optLen] = new Option('전체', '');
        else
            pumbun.options[optLen] = new Option('', '');
        
        optLen = pumbun.options.length;
        
        if( rowsNode.length > 0 ){

            
            for( i =0; i < rowsNode.length; i++){
                pumbun_cd = rowsNode[i].childNodes[0].childNodes[0].nodeValue;
                pumbun_nm = rowsNode[i].childNodes[1].childNodes[0].nodeValue;
                pumbun.options[optLen+i] = new Option(pumbun_nm, pumbun_cd);
            }
        }else{
        	 pumbun.options[0] = new Option('선택', '9999999999999');//조회된 브랜드가 없으면 999999999 처리.
        } 
        
     </ajax:callback>
 }

/**
 * btn_Search()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-10
 * 개    요    : 조회시 필수 조회조건을 체크한 후 조회한다.
 * return : void
 */ 
 function btn_Search(){
      // Validation Check
      if(!checkValidation("Search")) 
          return;

      base_qty    = 0;
      base_amt    = 0;
      buy_qty     = 0;
      buy_amt     = 0;
      sale_qty    = 0;
      sale_amt    = 0;
      stk_adj_qty = 0;
      stk_adj_amt = 0;
      srvy_e_qty  = 0;
      srvy_e_amt  = 0;
      // 리스트 조회
      getList();
 }
 
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * getList()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-10
 * 개    요   : 리스트 조회
 * return : void
 */
 function getList(){
     var strCd        = str_cd.value;                       // 점
     var venCd        = ven_cd.value;                       // 협력사
     var pumbunCd     = pumbun_cd.value;                    // 브랜드
     //var pummokCd     = pummok_cd.value;                    // 품목
     var sDate        = getRawData(document.getElementById("sDate").value);      // 조회일자
     var stkYm        = sDate.substring(0, 6);              // 조회년도
     var stkSDt       = sDate.substring(0, 6) + "01";       // 시작일
     var param        = "&goTo=getMaster"
                      + "&strCd="         + strCd
                      + "&venCd="         + venCd
                      + "&pumbunCd="      + pumbunCd
                      + "&sDate="         + sDate
                      + "&stkYm="         + stkYm
                      + "&stkSDt="        + stkSDt ;
     <ajax:open callback="on_getMasterXML" 
     
         param   ="param" 
         method  ="POST" 
         urlvalue="/edi/esal107.es"/>
     
     <ajax:callback function="on_getMasterXML"> 
     
     document.all.divTitle.scrollLeft     = 0;
     document.all.DivContent.scrollLeft   = 0;
     
     var tmpArr = new Array(); 
     var content =  "";
     last_row.value = -1;
     if( rowsNode.length > 0 ){
         content =  "<table width='1590' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_list'>";
         for( var i = 0; i < rowsNode.length; i++ ){
             for( var j = 0; j < rowsNode[i].childNodes.length; j++ ){
                 tmpArr[j] = rowsNode[i].childNodes[j].childNodes[0].nodeValue == "null" ? "" : String(rowsNode[i].childNodes[j].childNodes[0].nodeValue);
             }
             // 조회내용리스트 스크립트 생성
             content += setList(i, tmpArr);
         }
         
         content += "<tr>";
         content += "<td class='sum1'>&nbsp;</td>";
         content += "<td class='sum1' colspan='6'>합계</td>";
         content += "<td class='sum2'>"+convAmt(String(base_qty   ))+"</td>";
         content += "<td class='sum2'>"+convAmt(String(base_amt   ))+"</td>";
         content += "<td class='sum2'>"+convAmt(String(buy_qty    ))+"</td>";
         content += "<td class='sum2'>"+convAmt(String(buy_amt    ))+"</td>";
         content += "<td class='sum2'>"+convAmt(String(sale_qty   ))+"</td>";
         content += "<td class='sum2'>"+convAmt(String(sale_amt   ))+"</td>";
         content += "<td class='sum2'>"+convAmt(String(stk_adj_qty))+"</td>";
         content += "<td class='sum2'>"+convAmt(String(stk_adj_amt))+"</td>";
         content += "<td class='sum2'>"+convAmt(String(srvy_e_qty ))+"</td>";
         content += "<td class='sum2'>"+convAmt(String(srvy_e_amt ))+"</td>";
         content += "<td class='sum2' colspan='3'></td>";
         
         content += "</tr>";
         content += "</table>";
         document.getElementById("DivContent").innerHTML = content;
         
         setRowBgColor(-1, 20);                       // 조회시 첫번째 로우 색깔 변경
         setPorcCount("SELECT", rowsNode.length);
     }else{
         content =  "<table width='1590' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_list'>";
         content += "</table>";
         document.getElementById("DivContent").innerHTML = content;
         setPorcCount("SELECT", rowsNode.length);
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
     //  브랜드코드[0]       ,브랜드명[1]         ,품목[2]           ,품목명[3]          ,단품코드[4] 
     // ,단품명[5]         ,기초재고수량[6]   ,기초재고금액[7]    ,매입수량[8]        ,매입금액[9]
     // ,매출수량[10]      ,매출금액[11]      ,재고조정수량[12]   ,재고조정금액[13]   ,기말재고수량[14]
     // ,기말재고금액[15]  ,소스마킹[16]      ,판매단위[17]       ,구성단위[18]    
     
     tmpContent += "   <tr onclick='setRowBgColor("+row+",20);' style='cursor:hand;'>";
     tmpContent += "       <td class='r1' width='25'  id='column"+row+"_"+(col++)+"'>"+(row+1)+"</td>";
     tmpContent += "       <td class='r1' width=75'  id='column"+row+"_"+(col++)+"'>"+tmpArr[0]+"</td>";            
     tmpContent += "       <td class='r3' width=105' id='column"+row+"_"+(col++)+"' title="+tmpArr[1]+">"+cutTitleText(tmpArr[1],8)+"</td>";
     tmpContent += "       <td class='r1' width=75'  id='column"+row+"_"+(col++)+"'>"+tmpArr[2]+"</td>";
     tmpContent += "       <td class='r3' width=85'  id='column"+row+"_"+(col++)+"' title="+tmpArr[3]+">"+cutTitleText(tmpArr[3],6)+"</td>";
     tmpContent += "       <td class='r1' width=110'  id='column"+row+"_"+(col++)+"'>"+tmpArr[4]+"</td>";
     tmpContent += "       <td class='r3' width=105'  id='column"+row+"_"+(col++)+"' title="+tmpArr[5]+">"+cutTitleText(tmpArr[5],9)+"</td>";
     tmpContent += "       <td class='r4' width=65'  id='column"+row+"_"+(col++)+"'>"+convAmt(tmpArr[6])+"</td>";
     tmpContent += "       <td class='r4' width=85'  id='column"+row+"_"+(col++)+"'>"+convAmt(tmpArr[7])+"</td>";
     tmpContent += "       <td class='r4' width=65'  id='column"+row+"_"+(col++)+"'>"+convAmt(tmpArr[8])+"</td>";
     tmpContent += "       <td class='r4' width=85'  id='column"+row+"_"+(col++)+"'>"+convAmt(tmpArr[9])+"</td>";
     tmpContent += "       <td class='r4' width=65'  id='column"+row+"_"+(col++)+"'>"+convAmt(tmpArr[10])+"</td>";
     tmpContent += "       <td class='r4' width=85'  id='column"+row+"_"+(col++)+"'>"+convAmt(tmpArr[11])+"</td>";
     tmpContent += "       <td class='r4' width=65'  id='column"+row+"_"+(col++)+"'>"+convAmt(tmpArr[12])+"</td>";
     tmpContent += "       <td class='r4' width=85'  id='column"+row+"_"+(col++)+"'>"+convAmt(tmpArr[13])+"</td>";
     tmpContent += "       <td class='r4' width=65'  id='column"+row+"_"+(col++)+"'>"+convAmt(tmpArr[14])+"</td>";
     tmpContent += "       <td class='r4' width=85'  id='column"+row+"_"+(col++)+"'>"+convAmt(tmpArr[15])+"</td>";
     tmpContent += "       <td class='r1' width=85'  id='column"+row+"_"+(col++)+"'>"+tmpArr[16]+"</td>";
     tmpContent += "       <td class='r3' width=45'  id='column"+row+"_"+(col++)+"'>"+tmpArr[17]+"</td>";
     tmpContent += "       <td class='r3' width=45'  id='column"+row+"_"+(col++)+"'>"+tmpArr[18]+"</td>";
     tmpContent += "    </tr>";
     
     base_qty    +=  Number(tmpArr[6]);
     base_amt    +=  Number(tmpArr[7]);
     buy_qty     +=  Number(tmpArr[8]);
     buy_amt     +=  Number(tmpArr[9]);
     sale_qty    +=  Number(tmpArr[10]);
     sale_amt    +=  Number(tmpArr[11]);
     stk_adj_qty +=  Number(tmpArr[12]);
     stk_adj_amt +=  Number(tmpArr[13]);
     srvy_e_qty  +=  Number(tmpArr[14]);
     srvy_e_amt  +=  Number(tmpArr[15]);
     
     return tmpContent; 
 }
 
/**
 * checkValidation()
 * 작 성 자     : 김경은
 * 작 성 일     : 2011-08-10
 * 개    요        : Validation Check
 * return값 : void
 */
 function checkValidation(Gubun){
      switch (Gubun) {
      // 조회
      case "Search": 
          var strCd      = str_cd.value;                         // 점
          var venCd      = ven_cd.value;                         // 협력사
          var strDate    = getRawData(trim(sDate.value));        // 조회일자
                   
          var toDay = getTodayFormat("YYYYMMDD");             //현재일 YYYYMMDD
          
          if( strDate == "" ){
              showMessage(INFORMATION, OK, "USER-1003", "조회일자");
              document.getElementById("sDate").focus();
              return false;
          }
          
          /* 일자 체크 */
          if( strDate > toDay ){
              showMessage(StopSign, OK, "USER-1009", "조회일자", "현재일");
              document.getElementById("sDate").focus();
              return false;
          }
          break;
      }
      return true; 
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
      var lastRow = last_row.value;   // 마지막 선택 Row
      row         = row == -1 ? 0:row;    // 현재 선택 Row
      if(lastRow != row){
          for(var j=0;j<colCount;j++) {
              document.getElementById("column"+row+"_"+j).style.backgroundColor     = "#fff56E";
              if(lastRow != -1)
                  document.getElementById("column"+lastRow+"_"+j).style.backgroundColor = "#ffffff";
          } 
          last_row.value = row;
      }
  }

 
function scrollAll() {
    document.all.divTitle.scrollLeft = document.all.DivContent.scrollLeft;
}
  
/**
 * getPbnPmkPop(objCd, objNm)
 * 작 성 자 : FKL
 * 작 성 일 : 2011-08-30
 * 개    요 :  품목코드 
 * return값 : void
 */ 
function getPbnPmkPop(objCd, objNm ){
    var strPummokcd = document.getElementById(objCd).value;
    var strPumbuncd = document.getElementById("pumbun_cd").value;
     
    alert(strPummokcd+":"+strPumbuncd);
    var rtnList = pbnPmkMultiSelPop(strPummokcd, "", strPumbuncd, "", "", "N");
    
     if(rtnList != null){ 
         var returnList = rtnList;
         
         if( returnList.length == 1 ){
            var returnValue =  returnList[0].split(":");
            document.getElementById(objCd).value = returnValue[0];
            document.getElementById(objNm).value = returnValue[1];
         }
     }
     else { 
         var strPummock_len =document.getElementById("d_pummok_cd"+row).value;
         //alert(strPummock_len.length);
         if(strPummock_len.length < 8) {
             document.getElementById(objCd).value = "";
             document.getElementById(objNm).value = "";
             
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
 
function pbnPmkMultiSelPop(strPummokcd, pummok_nm, strPumbuncd){
    
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
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  저장  
 * return값 : void
 */
function btn_Excel(){
	var objTable = document.getElementById("tb_list"); 
    if (objTable.rows.length < 1) {
        showMessage(INFORMATION, OK, "USER-1000", "조회 된 내역이 없습니다.");
    } else {
        var strCd        = str_cd.value;                       // 점
        var venCd        = ven_cd.value;                       // 협력사
        var pumbunCd     = pumbun_cd.value;                    // 브랜드
        //var pummokCd     = pummok_cd.value;                    // 품목
        var sDate        = getRawData(document.getElementById("sDate").value);      // 조회일자
        var stkYm        = sDate.substring(0, 6);              // 조회년도
        var stkSDt       = sDate.substring(0, 6) + "01";       // 시작일
        var param        = "&goTo=getExcel"
                         + "&strCd="         + strCd
                         + "&venCd="         + venCd
                         + "&pumbunCd="      + pumbunCd
                         + "&sDate="         + sDate
                         + "&stkYm="         + stkYm
                         + "&stkSDt="        + stkSDt ;
    
        var url = "/edi/esal107.es?" + param; 
        iFrame.location.href=url;
    }
}

</script>
</head>
<body  class="PL10 PR07 PT15" onLoad="doinit();">
<iframe id=iFrame name=iFrame src="about:blank" width=0 height=0></iframe>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>단품별장부재고조회</td>
        <td><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onClick="javascript:btn_Search();"/></td>
            <td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow" onClick="addRow();" /></td>
            <td><img src="<%=dir%>/imgs/btn/del.gif" width="50" height="22" id="del" /></td>
            <td><img src="<%=dir%>/imgs/btn/save.gif" width="50" height="22" id="save" /></td>
            <td><img src="<%=dir%>/imgs/btn/excel.gif" width="61" height="22" id="excel" onclick="javascript:excelExport('단품별장부재고조회','TBL',pumbunCd);"/></td>
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
            <td width="140">
            <input type="text"  name="str_nm" id="str_nm" size="20" maxlength="10" value="<%=STR_NM%>" disabled="disabled" />
            <input type="hidden" name="str_cd" id="str_cd"  ></td>
            <th width="80" class="POINT">협력사코드</th>
            <td width="140" colspan=3>
                <input type="hidden" name="ven_cd" id="ven_cd" value="<%=VEN_CD%>" disabled="disabled"  />
                <input type="text" name="ven_nm" id="ven_nm" size="20" value="<%=VEN_CD %>" disabled="disabled" />
            </td>
            <th width="80">브랜드코드</th>
            <td>
                <select name="pumbun_cd" id="pumbun_cd" style="width: 193;">
                
                </select>
            </td>
          </tr>
          <tr>
            <th >일자</th>
            <td colspan=7> 
                <input type="text" name="sDate" id="sDate" size="16"  title="YYYY/MM/DD"  maxlength="8" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);"  style='text-align:center;IME-MODE: disabled'/>
                <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onclick="openCal('G',sDate);return false;" />
            </td>
            
           <!--  <th width="80">품목코드</th>
            <td colspan=5>
                <input type="text" name="pummok_cd" id="pummok_cd" value="" disabled="disabled"  />
                <img src="<%=dir%>/imgs/btn/detail_search_s.gif" alt="품목코드" align="absmiddle" onclick="javascript:getPbnPmkPop('pummok_cd', 'pummok_nm');" />
                <input type="text" name="pummok_nm" id="pummok_nm" size="20" value="" disabled="disabled" />
            </td>
          <th>구분</th>
               <td colspan=3">
                   <input type="radio" name="baseFlag" id="baseFlag" value="1"  checked="checked" />수량
                   <input type="radio" name="baseFlag" id="baseFlag" value="2" />원가
                   <input type="radio" name="baseFlag" id="baseFlag" value="3" />매가
               </td>
           -->
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
  <tr valign="top">
    <td >
        <div id="TBL">
	    <table width="100%"  border="0" cellspacing="0" cellpadding="0" class="BD4A">
	      <tr valign="top">
	        <td><div id="divTitle" style="width:815px;overflow:hidden;">
	                <table width="1610" cellpadding="0" cellspacing="0" border="0" class="g_table" >
	                    <tr>
	                        <th rowspan="2" width="25">NO</th>
	                        <th rowspan="2" width="75">브랜드코드</th>
	                        <th rowspan="2" width="105">브랜드명</th>
	                        <th rowspan="2" width="75">품목</th>
	                        <th rowspan="2" width="85">품목명</th>
	                        <th rowspan="2" width="110">단품코드</th>
	                        <th rowspan="2" width="105">단품명</th>
	                        <th colspan="2" width="150">기초재고</th>
	                        <th colspan="2" width="150">매입</th>
	                        <th colspan="2" width="150">매출</th>
	                        <th colspan="2" width="150">재고조정</th>
	                        <th colspan="2" width="150">기말재고</th>
	                        <th rowspan="2" width="85">소스마킹</th>
	                        <th rowspan="2" width="45">판매단위</th>
	                        <th rowspan="2" width="45">구성단위</th>
	                        <th rowspan="2" width="15">&nbsp;</th>
	                    </tr>
	                    <tr>
	                        <th width="65">수량</th>
	                        <th width="85">금액</th>
	                        <th width="65">수량</th>
	                        <th width="85">금액</th>
	                        <th width="65">수량</th>
	                        <th width="85">금액</th>
	                        <th width="65">수량</th>
	                        <th width="85">금액</th>
	                        <th width="65">수량</th>
	                        <th width="85">금액</th>
	                    </tr>
	                </table>
	            </div>        
	        </td>
	      </tr>
	      <tr>
	          <td ><div id="DivContent" style="width:815px;height:435px;overflow:scroll" onscroll="scrollAll();">
	                  <table width="1590" cellspacing="0" cellpadding="0" border="0" class="g_table" id="tb_list">
	                  </table>  
	              </div>
	          </td>  
	      </tr>
	    </table>
	    </div>
    </td>
  </tr>
</table>
<input type="hidden" name="last_row"        id="last_row"       value=-1>          <!-- List 이전 선택 Row -->
</body>
</html>

