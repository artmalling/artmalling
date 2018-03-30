

<!-- 
/*******************************************************************************
 * 시스템명 : 협력사EDI > 영업실적 > 정산기입금조회
 * 작 성 일 : 2017.09.01
 * 작 성 자 : jyk
 * 수 정 자 : 
 * 파 일 명 : esal1140.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 무인정산기 입금 내역 조회 및 비교자료
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
var strCond = "";
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
   initDateText('SYYYYMMDD', 'em_S_Date');                                     //시작일
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
	 //alert("!!!");
	// 스크롤 위치 초기화        
    document.all.topTitle.scrollLeft = 0;
    document.all.DIV_Content.scrollLeft = 0; 
	 
    g_row = -1;
    g_pre_row = -1;
    
    var sDate 	 = document.getElementById("em_S_Date").value;
    var eDate 	 = document.getElementById("em_E_Date").value;
    var strGrpGb = ""; 
    
    if (document.getElementById("grpgb0").checked) 
    	strGrpGb = "0";
    else
    	strGrpGb = "1";

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
    
	if (strGrpGb=="0") {
		document.getElementById("col2").innerHTML = "POS번호";
		document.getElementById("col3").innerHTML = "POS명";
	}
	else {
		document.getElementById("col2").innerHTML = "브랜드코드";
		document.getElementById("col3").innerHTML = "브랜드명";
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
    //var strVencd = document.getElementById("vencd").value;
    var strPumbuncd = document.getElementById("pubumCd").value;
    var sDate = getRawData(trim(document.getElementById("em_S_Date").value));
    var eDate = getRawData(trim(document.getElementById("em_E_Date").value));
    var strGrpGb = "";
    
    if (document.getElementById("grpgb0").checked) 
    	strGrpGb = "0";
    else
    	strGrpGb = "1";
    
    
    var param = "&goTo=getMaster" + "&strcd="  +strStrcd
							      + "&strGrpGb="  + strGrpGb 
							      + "&strPumbuncd=" + encodeURIComponent(strPumbuncd)
							      + "&sDate="  + sDate
							      + "&eDate="  + eDate
							      ;
    // 조건확인을 위한 전역변수에 param 초기화.
    strCond = param;
    
	var Urleren = "/edi/esal114.es";  
	URL = Urleren + "?" +param; 
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
	 
	 var SUM_CAL_01       = 0;
	 var SUM_NORM_01      = 0;
	 var SUM_DIFF_01      = 0;
	 var SUM_CAL_11       = 0;
	 var SUM_NORM_11      = 0;
	 var SUM_DIFF_11      = 0;
	 var SUM_CAL_21       = 0;
	 var SUM_NORM_21      = 0;
	 var SUM_DIFF_21      = 0;
    
     if(strMst.readyState==4)
     {
          if(strMst.status == 200)
          {
              strMst = eval(strMst.responseText); 
            //   alert(str); 
            //   alert(eval(str)[0].STR_CD);
            
              var content = "";
              content += "<table width='792' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
              
             // 조회된 데이터가 없을땐 그리드를 그리지 않고 return
              if(strMst == undefined) { 
                  document.getElementById("DIV_Content").innerHTML = content;   
                  content += "</table>";
                 setPorcCount("SELECT", 0);
                 strCond = "";
                 return; 
               }
              
              
              for( i = 0; i < strMst.length; i++ ){  
                  content += "<tr onclick='chBak("+i+");' style='cursor:hand;'>";  
                  content += "<td width='35'   class='r1' id='1tdId"+i+"'>"+(i+1)+"</td>";
                  content += "<td width='65'   class='r1 msoTxt1' id='2tdId"+i+"'>"+getDateFormat(strMst[i].SALE_DT)+"</td>";
                  content += "<td width='65'  class='r1 msoTxt1' id='3tdId"+i+"'>"+strMst[i].POS_NO+"</td>";
                  content += "<td width='75'  class='r1 msoTxt1' id='4tdId"+i+"'>"+strMst[i].POS_NM+"</td>";
                  content += "<td width='55'   class='r4' id='5tdId"+i+"'>"+convAmt(strMst[i].CAL_01)+"</td>"; 
                  content += "<td width='55'   class='r4' id='6tdId"+i+"'>"+convAmt(strMst[i].NORM_01)+"</td>";
                  content += "<td width='55'   class='r4' id='7tdId"+i+"'>"+convAmt(strMst[i].DIFF_01)+"</td>";
                  content += "<td width='55'   class='r4' id='8tdId"+i+"'>"+convAmt(strMst[i].CAL_11)+"</td>";
                  content += "<td width='55'   class='r4' id='9tdId"+i+"'>"+convAmt(strMst[i].NORM_11)+"</td>";
                  content += "<td width='55'   class='r4' id='10tdId"+i+"'>"+convAmt(strMst[i].DIFF_11)+"</td>";
                  content += "<td width='55'   class='r4' id='11tdId"+i+"'>"+convAmt(strMst[i].CAL_21)+"</td>";
                  content += "<td width='55'   class='r4' id='12tdId"+i+"'>"+convAmt(strMst[i].NORM_21)+"</td>";
                  content += "<td width='55'   class='r4' id='13tdId"+i+"'>"+convAmt(strMst[i].DIFF_21)+"</td>";
                  content += "</tr>";   
                   
                                   
             	  SUM_CAL_01       += Number(strMst[i].CAL_01);
            	  SUM_NORM_01      += Number(strMst[i].NORM_01);
            	  SUM_DIFF_01      += Number(strMst[i].DIFF_01);
            	  SUM_CAL_11       += Number(strMst[i].CAL_11);
            	  SUM_NORM_11      += Number(strMst[i].NORM_11);
            	  SUM_DIFF_11      += Number(strMst[i].DIFF_11);
            	  SUM_CAL_21       += Number(strMst[i].CAL_21);
            	  SUM_NORM_21      += Number(strMst[i].NORM_21);
            	  SUM_DIFF_21      += Number(strMst[i].DIFF_21);
               //   getMaster(i);
              }   
              
              content += "<tr>";
              content += "<td class='sum1'>&nbsp;</td>";
              content += "<td class='sum1' colspan='3'>합계</td>"; 
              content += "<td class='sum2' >"+convAmt(String(SUM_CAL_01))+"</td>";  
              content += "<td class='sum2' >"+convAmt(String(SUM_NORM_01))+"</td>";  
              content += "<td class='sum2' >"+convAmt(String(SUM_DIFF_01))+"</td>";
               
              content += "<td class='sum2' >"+convAmt(String(SUM_CAL_11))+"</td>";  
              content += "<td class='sum2' >"+convAmt(String(SUM_NORM_11))+"</td>";  
              content += "<td class='sum2' >"+convAmt(String(SUM_DIFF_11))+"</td>";
               
              content += "<td class='sum2' >"+convAmt(String(SUM_CAL_21))+"</td>";  
              content += "<td class='sum2' >"+convAmt(String(SUM_NORM_21))+"</td>";  
              content += "<td class='sum2' >"+convAmt(String(SUM_DIFF_21))+"</td>";
              //content += "<td class='sum1' >&nbsp;</td>";
              content += "</tr>";
              
                document.getElementById("DIV_Content").innerHTML = content; 
             //   alert(strMst.length);
              content += "</table>";
				
              setPorcCount("SELECT", strMst.length);  
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
	   g_last_row = val;
	   
	   if (g_pre_row != g_last_row){
	       for(i=1;i<14;i++) {
	           document.getElementById(i+"tdId"+val).style.backgroundColor="#fff56E";
        	  
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
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>정산기입금내역</td>
        <td><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onClick="javascript:btn_Sch();"/></td>
            <td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow"  /></td>
            <td><img src="<%=dir%>/imgs/btn/del.gif" width="50" height="22" id="del" /></td>
            <td><img src="<%=dir%>/imgs/btn/save.gif" width="50" height="22" id="save" /></td>
            <td><img src="<%=dir%>/imgs/btn/excel.gif" width="61" height="22" id="excel" onclick="javascript:chBakClr(13); excelExport('정산기입금내역('+pumbunNm+')','TBL',pumbunCd,strCond);"/></td>
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
            <td colspan="3">
                <input type="text" name="em_S_Date" id="em_S_Date" size="10" title="YYYY/MM/DD" value="" maxlength="10" onKeyPress="javascript:onlyNumber();" onBlur="dateCheck(this);" onFocus="dateValid(this);"  style='text-align:center;IME-MODE: disabled' /> 
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onClick="openCal('G',em_S_Date);return false;" /> ~
                 <input type="text" name="em_E_Date" id="em_E_Date" size="10" maxlength="10" value="" onKeyPress="javascript:onlyNumber();" onBlur="dateCheck(this);" onFocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' />
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onClick="openCal('G',em_E_Date);return false;" />
            </td>
            <th>구분</th>
            <td colspan="0">
                <input type="radio" name="grpgb" id="grpgb0" value="0"> 장비별
  				<input type="radio" name="grpgb" id="grpgb1" value="1" checked> 일자별합
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
        <td><div id="topTitle" style="width:810;overflow:hidden;">
                <table width="810" cellpadding="0" cellspacing="0" border="0" class="g_table" >
                    <tr>
                    	<th width="35" rowspan="2">NO</th>
                        <th width="70" rowspan="2">일자</th>
                        <th width="70" rowspan="2"><p id="col2"></p></th>
                        <th width="80" rowspan="2"><p id="col3"></p></th>
                        <th width="180" colspan="3"> 현금</th>
                        <th width="180"colspan="3">자사상품권</th>
                        <th width="180" colspan="3">타사상품권</th>
                        <th width="15"></th>
                    </tr>
                    <tr>
                        <th width="60">정산기</th>
                        <th width="60">시스템</th>
                        <th width="60">차이</th>
                        <th width="60">정산기</th>
                        <th width="60">시스템</th>
                        <th width="60">차이</th>
                        <th width="60">정산기</th>
                        <th width="60">시스템</th>
                        <th width="60">차이</th>
                        <th width="15"></th>
                    </tr>
                </table>
            </div>        
        </td>
      </tr>
      <tr> 
          <td ><div id="DIV_Content" style="width:810px;height:445px;overflow:scroll" onscroll="scrollAll();">
                  <table width="810" cellspacing="0" cellpadding="0" border="0" class="g_table">
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

