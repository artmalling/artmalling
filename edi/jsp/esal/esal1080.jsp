

<!-- 
/*******************************************************************************
 * 시스템명 : 협력사EDI > 영업실적 > 일일거래현황 조회
 * 작 성 일 : 2011.09.14
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : esal1080.jsp
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
    
	var Urleren = "/edi/esal108.es";  
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

     var SUM_AMT       = 0; 
     
     if(strMst.readyState==4)
     {
          if(strMst.status == 200)
          {
              strMst = eval(strMst.responseText); 
            //   alert(str); 
            //   alert(eval(str)[0].STR_CD);
              var content = "";
              content += "<table width='920' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
              
             // 조회된 데이터가 없을땐 그리드를 그리지 않고 return
              if(strMst == undefined) { 
                  document.getElementById("DIV_Content").innerHTML = content;   
                  content += "</table>";
                  searchDoneWait();
                 setPorcCount("SELECT", 0);
                 return; 
               }
              
              for( i = 0; i < strMst.length; i++ ){   
                  content += "<tr onclick='chBak("+i+");' style='cursor:hand;'>";    
                  content += "<td width='35'   class='r1' id='1tdId"+i+"'>"+(i+1)+"</td>";
                  content += "<td width='80'   class='r1' id='2tdId"+i+"'>"+getDateFormat(strMst[i].SALE_DT)+"</td>";
                  content += "<td width='120'  class='r3' id='3tdId"+i+"'>"+strMst[i].POS_NAME+"</td>"; 
                  content += "<td width='70'   class='r1 msoTxt1' id='4tdId"+i+"'>"+strMst[i].TRAN_CD+"</td>"; 
                  content += "<td width='85'   class='r1' id='5tdId"+i+"'>"+strMst[i].SALE_TIME+"</td>";  
                  content += "<td width='100'  class='r1' id='6tdId"+i+"'>"+strMst[i].TRAN_MODE+"</td>"; 
                  content += "<td width='60'   class='r1' id='7tdId"+i+"'>"+strMst[i].TRAN_FLAG+"</td>"; 
                  content += "<td width='80'   class='r4' id='8tdId"+i+"'>"+convAmt(strMst[i].AMT)+"</td>";  
                  content += "<td width='120'  class='r1' id='9tdId"+i+"'>"+strMst[i].O_POS_NO+"</td>"; 
                  content += "<td width='85'   class='r1' id='10tdId"+i+"'>"+getDateFormat(strMst[i].O_SALE_DT)+"</td>";  
                  content += "<td width='85'   class='r1 msoTxt1' id='11tdId"+i+"'>"+strMst[i].O_TRAN_NO+"</td>";  
                  content += "</tr>";   
                   
                  SUM_AMT += Number(strMst[i].AMT);
               //   getMaster(i); 
              }   
              
              content += "<tr>";
              content += "<td class='sum1'>&nbsp;</td>";
              content += "<td class='sum1' colspan='6'>합계</td>"; 
              content += "<td class='sum2' >"+convAmt(String(SUM_AMT))+"</td>";  //convAmt(String(SUM_SUP_AMT)) 
              content += "<td class='sum1' colspan='3'>&nbsp;</td>";
              content += "</tr>";
              
                document.getElementById("DIV_Content").innerHTML = content; 
             //   alert(strMst.length);
              content += "</table>";
              searchDoneWait();
              setPorcCount("SELECT", strMst.length);  
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
    g_last_row = val;
    //alert(g_pre_row);
    //alert(g_last_row);
    if (g_pre_row != g_last_row){
        for(i=1;i<12;i++) {
            document.getElementById(i+"tdId"+val).style.backgroundColor="#fff56E";
            //alert("1");
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

</script>
</head>
<body  class="PL10 PR07 PT15" onLoad="doinit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>일일거래내역조회</td>
        <td><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onClick="javascript:btn_Sch();"/></td>
            <td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow"  /></td>
            <td><img src="<%=dir%>/imgs/btn/del.gif" width="50" height="22" id="del" /></td>
            <td><img src="<%=dir%>/imgs/btn/save.gif" width="50" height="22" id="save" /></td>
            <td><img src="<%=dir%>/imgs/btn/excel.gif" width="61" height="22" id="excel" onclick="javascript: if(!chBakClr(11)){ excelExport('일일거래내역조회','TBL',pumbunCd);}"/></td>
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
            <td colspan="5">
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
    <td height="4"></td>
  </tr>
  <tr valign="top">
    <td >
        <div id="TBL">
	    <table width="100%"  border="0" cellspacing="0" cellpadding="0" class="BD4A">
	      <tr valign="top">
	        <td><div id="topTitle" style="width:815px;overflow:hidden;">
	                <table width="940" cellpadding="0" cellspacing="0" border="0" class="g_table" >
	                    <tr>
	                        <th width="35">NO</th>
	                        <th width="80">일자</th>
	                        <th width="120">POS번호</th>
	                        <th width="70">거래번호</th>
	                        <th width="85">판매시간</th>
	                        <th width="100">거래모드</th>
	                        <th width="60">거래구분</th>
	                        <th width="80">매출금액</th>
	                        <th width="120">원거래POS번호</th>
	                        <th width="85">원거래일자</th>
	                        <th width="85">원거래번호</th> 
	                        <th width="15">&nbsp;</th>
	                    </tr>
	                </table>
	            </div>        
	        </td>
	      </tr>
	      <tr> 
	          <td ><div id="DIV_Content" style="width:815px;height:455px;overflow:scroll" onscroll="scrollAll();">
	                  <table width="920" cellspacing="0" cellpadding="0" border="0" class="g_table">
	                  </table>  
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

