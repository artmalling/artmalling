

<!-- 
/*******************************************************************************
 * 시스템명 : 협력사EDI > 커뮤니티 > 협력사원관리
 * 작 성 일 : 2018.03.05
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : esal1160.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 : 2018.03.05 (jyk) 신규작성 
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
    String PumbunCd          = sessionInfo.getPUMBUN_CD();      //브랜드코드
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
var PumbunCd    = '<%=PumbunCd%>';
var g_pre_row = -1;
var g_last_row = -1;
var strMst = "";
var strDel = "";

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
    enableControl(del,false);      //삭제
    enableControl(save,false);     //저장
    enableControl(excel,true);    //엑셀
    enableControl(prints,false);    //프린터
    enableControl(set,false);    //프린터
     
    
    /*  조회 항목  */
    initDateText('SYYYYMMDD', 'EntrDt');                                     //시작일
    initDateText("TODAY", "RetrDt");                                         //종료일

    
    /* 구분 값이 브랜드로 로그인시 "전체" 값 없음 */
    if(gb=="1"){
    	getPumbunCombo(g_strcd, vencd, "PumbunCd", "Y", PumbunCd);             //점별 브랜드
    }else{
    	getPumbunCombo(g_strcd, vencd, "PumbunCd", "N", PumbunCd);             //점별 브랜드
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
 function getPumbunCombo(strcd, vencd, target, YN, PumbunCd){
     var param = "";
    
     param = "&goTo=getPumbunCombo&strcd=" + strcd
              + "&vencd=" + vencd
              + "&PumbunCd=" + PumbunCd
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
    
    var sDate = document.getElementById("EntrDt").value;
    var eDate = document.getElementById("RetrDt").value;
        /*
    if( pumbencd.length == 0 ){
        alert("브랜드은 반드시 입력해야 합니다.");
        document.getElementById("pubumCd").focus();
        return;
    }
    */
    
    if( sDate.length == 0 ){
    	showMessage(INFORMATION, OK, "USER-1003", "시작일");
        document.getElementById("EntrDt").focus();
        return;
    }
    
    if( eDate.length == 0 ){
    	showMessage(INFORMATION, OK, "USER-1003", "종료일");
        document.getElementById("RetrDt").focus();
        return;
    }
    
    var em_sdate = getRawData(trim(sDate));
    var em_edate = getRawData(trim(eDate));   
    
    if (em_sdate > em_edate) { //시작일은 종료일보다 커야 합니다.
    	showMessage(StopSign, OK, "USER-1008", "종료일", "시작일");
        document.getElementById("EntrDt").focus();
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
	 
    var strStrCd 	= document.getElementById("StrCd").value;
    var strPumbunCd = document.getElementById("PumbunCd").value;
    var strEmpName 	= document.getElementById("EmpName").value;
    /*
    var strEmpFlag 	= document.getElementById("EmpFlag").value;
    var strHpNo 	= document.getElementById("HpNo").value;
    var strIsuYn 	= document.getElementById("IsuYn").value;
    var strDelYn 	= document.getElementById("DelYn").value;
    */
    var strEntrDt 	= document.getElementById("EntrDt").value;
    strEntrDt = strEntrDt.replace(/\//gi, ""); 
    var strRetrDt 	= document.getElementById("RetrDt").value;
    strRetrDt = strRetrDt.replace(/\//gi, "");
    
    var param = "&goTo=getMaster" + "&strStrCd="  	+ encodeURIComponent(strStrCd)
							    + "&strPumbunCd=" + encodeURIComponent(strPumbunCd)
							    + "&strEmpName=" 	+ encodeURIComponent(strEmpName)
							    + "&strEmpFlag="  + encodeURIComponent("%")
							    + "&strHpNo="  	+ encodeURIComponent("%")
							    + "&strIsuYn="  	+ encodeURIComponent("%")
							    + "&strDelYn="  	+ encodeURIComponent("%")
							    + "&strEntrDt="  	+ encodeURIComponent(strEntrDt)
							    + "&strRetrDt="  	+ encodeURIComponent(strRetrDt)
							    + "&strSearchGb=" + encodeURIComponent("1")
							    ;
	var Urleren = "/edi/esal116.es";  
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

     var EMP_CNT       	= 0;
     var ISU_CNT       	= 0;
     var strDelImg 		= "";
     var strUpdImg 		= "";

     var str			= "";
     var pbn			= "";
     var seq			= "";
     var strStyle		= "";
     
     if(strMst.readyState==4)
     {
          if(strMst.status == 200)
          {
              strMst = eval(strMst.responseText); 
              var content = "";
              content += "<table width='950' cellspacing='0' cellpadding='0' border='0' class='g_table'>";
              
             // 조회된 데이터가 없을땐 그리드를 그리지 않고 return
              if(strMst == undefined) { 
                  document.getElementById("DIV_Content").innerHTML = content;   
                  content += "</table>";
                 setPorcCount("SELECT", 0);
                 return; 
               }
              for( i = 0; i < strMst.length; i++ ){   
            	  
            	  var str			= strMst[i].STR_CD;
            	  var pbn			= strMst[i].PUMBUN_CD;
            	  var seq			= strMst[i].EMP_SEQ;
            	  var del			= strMst[i].DEL_YN;
            	  var str
            	  
            	  if (del == "Y")
            		 strStyle = "style='color:red;'";
            	  else 
            		 strStyle = "";
            	  
            	  if (strMst[i].DEL_YN == "Y")
            		  strDelImg = "<img src='<%=dir%>/imgs/btn/del_off.gif'/>"; 
	              else
            		  strDelImg = "<img src='<%=dir%>/imgs/btn/del.gif' onClick='javascript:delRow(" + str +","+ pbn +","+ seq + ");'/>";
            	  strUpdImg = "<img src='<%=dir%>/imgs/btn/modify.gif' onClick='javascript:updRow(" + str +","+ pbn +","+ seq + ");'/>";
				  
            	  /*
            	  		엑셀 변환시 서식적용을 위해 class 명 뒤에 아래와 같은 class명 추가. 2018.03.09
            	  		msoTxt : 텍스트
            	  		(추후 추가되는 내용은 excelExport.js 의 스타일태그 참고.)
            	  */
            	  content += "<tr onclick='chBak("+i+");' style='cursor:hand;'>";    
                  content += "<td width='40'   class='r1' id='1tdId"+i+"' "+strStyle+">"+(i+1)+"</td>";
                  content += "<td width='40'   class='r1 msoTxt' id='2tdId"+i+"' "+strStyle+">"+strMst[i].STR_CD +"</td>";
                  content += "<td width='80'   class='r1 msoTxt' id='3tdId"+i+"' "+strStyle+">"+strMst[i].PUMBUN_CD+"</td>"; 
                  content += "<td width='120'  class='r1 msoTxt`' id='4tdId"+i+"' "+strStyle+">"+strMst[i].PUMBUN_NAME+"</td>"; 
                  content += "<td width='70'   class='r1' id='5tdId"+i+"' "+strStyle+">"+strMst[i].EMP_FLAG+"</td>";
                  content += "<td width='60'   class='r1' id='6tdId"+i+"' "+strStyle+">"+strMst[i].EMP_NAME+"</td>";
                  content += "<td width='60'   class='r1 msoTxt' id='7tdId"+i+"' "+strStyle+">"+strMst[i].HP_NO+"</td>";
                  content += "<td width='60'   class='r1' id='8tdId"+i+"' "+strStyle+">"+getDateFormat(strMst[i].ENTR_DT) +"</td>";
                  content += "<td width='60'   class='r1' id='9tdId"+i+"' "+strStyle+">"+getDateFormat(strMst[i].RETR_DT) +"</td>";
                  content += "<td width='60'   class='r1' id='10tdId"+i+"' "+strStyle+">"+strMst[i].ISU_YN+"</td>";
                  content += "<td width='60'   class='r1' id='11tdId"+i+"' "+strStyle+">"+getDateFormat(strMst[i].ISU_DATE) +"</td>";
                  content += "<td width='60'   class='r1' id='12tdId"+i+"' "+strStyle+">"+strMst[i].DEL_YN+"</td>";
                  content += "<td width='60'   class='r1' id='13tdId"+i+"' "+strStyle+">"+strUpdImg+"</td>";
                  content += "<td width='60'   class='r1' id='14tdId"+i+"' "+strStyle+">"+strDelImg+"</td>";
                  content += "</tr>";   
                  //alert(content);
                  EMP_CNT = EMP_CNT + 1;
                  if (strMst[i].ISU_YN == "Y")
                	  ISU_CNT = ISU_CNT + 1;
                  
               //   getMaster(i); 
              }   
              
              content += "<tr>";
              content += "<td class='sum1' colspan='3'>&nbsp;</td>";
              content += "<td class='sum1' colspan='2'>계</td>"; 
              content += "<td class='sum1' ><b>"+convAmt(String(EMP_CNT))+"</b></td>";  //convAmt(String(SUM_SUP_AMT))
              content += "<td class='sum1' colspan='3'>이수 계</td>";
              content += "<td class='sum1' ><b>"+convAmt(String(ISU_CNT))+"</b></td>";  //convAmt(String(SUM_SUP_AMT))
              content += "<td class='sum1' colspan='4'></td>";
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
       for(i=1;i<15;i++) {
           document.getElementById(i+"tdId"+val).style.backgroundColor="#ffff00";
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

function delRow(str, pbn, seq) {
	
	//alert("Delete Row Proc : "+str+","+pbn+","+ seq);
	//["USER-1023", "선택한 항목을 삭제하겠습니까?"], // Question    , YesNo
	var rtnVal = showMessage(Question, YESNO , "USER-1023");
	
	if (rtnVal != 1) return;
    var param = "&goTo=delete" + "&strStrCd="  	+ encodeURIComponent(str)
							    + "&strPumbunCd=" + encodeURIComponent(pbn)
							    + "&strEmpSeq=" + encodeURIComponent(seq)
							    ;
    
	var Urleren = "/edi/esal116.es";  
	URL = Urleren + "?" +param; 
	strDel = getXMLHttpRequest(); 
	strDel.onreadystatechange = responseDelete;
	strDel.open("POST", URL, true); 
	strDel.send(null); 
	}
	
/**
 * responseDelete()
 * 작 성 자 : jyk
 * 작 성 일 : 2018-03-05
 * 개    요 :  삭제처리
 * return값 : void
 */ 
 function responseDelete(){
	    if(strDel.readyState==4) {
	        if(strDel.status == 200) {
	        	strDel = eval(strDel.responseText); 
	            if (strDel == undefined) {
	                showMessage(INFORMATION, OK, "GAUCE-1000",  strDel[0].MSG);
	            } else {
	            	 
	                showMessage(QUESTION, OK, "GAUCE-1000", strDel[0].MSG);
	                
	                if (strDel[0].CD == "T") {
		                //doinit();
		                //document.getElementById("TXT_CARD_NO").focus();
		                getSearch();
	            	}
	            }
	        } 
	    }
	 }	
	
function updRow(str, pbn, seq) {
	
	//alert("Update Row Proc : "+str+","+pbn+","+ seq);
	
	var arrArg  = new Array("U",str, pbn, seq);
	//alert(arrArg);
	var rtn =  window.showModalDialog("/edi/jsp/esal/esal1161.jsp?",
            				arrArg,
    				"dialogWidth:800px;dialogHeight:200px;scroll:no;");
	
	if (rtn !=1) return;
	
	getSearch();
	
	}
	
function btn_New() {
	
	var arrArg  = new Array("I",g_strcd, PumbunCd, "");
	//alert(arrArg);
	var rtn =  window.showModalDialog("/edi/jsp/esal/esal1161.jsp?",
            				arrArg,
    				"dialogWidth:800px;dialogHeight:200px;scroll:no;");
	if (rtn !=1) return;
	
	getSearch();
	
	}	

</script>
</head>
<body  class="PL10 PR07 PT15" onLoad="doinit();">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05" />협력사원관리</td>
        <td><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onClick="javascript:btn_Sch();"/></td>
            <td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow" onClick="javascript:btn_New();" /></td>
            <td><img src="<%=dir%>/imgs/btn/del.gif" width="50" height="22" id="del" /></td>
            <td><img src="<%=dir%>/imgs/btn/save.gif" width="50" height="22" id="save" /></td>
            <td><img src="<%=dir%>/imgs/btn/excel.gif" width="61" height="22" id="excel" onclick="javascript:chBakClr(14); excelExport('협력사원관리','TBL',PumbunCd);"/></td>
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
            <td width="120"><input type="text"  name="strnm" id="strnm" size="17" maxlength="10" value="<%=strNm%>" disabled="disabled" /><input type="hidden" name="strcd" id="StrCd"  ></td>
            <th width="80" class="POINT">협력사코드</th>
            <td width="160">
                <input type="hidden" name="vencd" id="vencd" value="<%=vencd%>" disabled="disabled"  />
                <input type="text" name="venNM" id="venNM" size="24" value="<%=venNm %>" disabled="disabled" />
            </td>
            <th width="80">브랜드코드</th>
            <td>
                <select name="PumbunCd" id="PumbunCd" style="width: 193;">
                
                </select>
            </td>
          </tr>
          <tr>
            <th>입사일자</th>
            <td colspan="3">
                <input type="text" name="EntrDt" id="EntrDt" size="10" title="YYYY/MM/DD" value="" maxlength="10" onKeyPress="javascript:onlyNumber();" onBlur="dateCheck(this);" onFocus="dateValid(this);"  style='text-align:center;IME-MODE: disabled' /> 
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onClick="openCal('G',EntrDt);return false;" /> ~
                 <input type="text" name="RetrDt" id="RetrDt" size="10" maxlength="10" value="" onKeyPress="javascript:onlyNumber();" onBlur="dateCheck(this);" onFocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' />
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="종료일" align="absmiddle" onClick="openCal('G',RetrDt);return false;" />
            </td>
            <th>사원명</th>
            <td >
            	<input type="text" name="EmpName" id="EmpName" size="24" />
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
        <td><div id="topTitle" style="width:810px;overflow:hidden;">
                <table width="945" cellpadding="0" cellspacing="0" border="0" class="g_table" >
                    <tr>
                        <th width="40">NO</th>
                        <th width="40">점코드</th>
                        <th width="80">브랜드코드</th>
                        <th width="120">브랜드명</th>
                        <th width="70">사원구분</th>
                        <th width="60">사원명</th>
                        <th width="60">연락처</th>
                        <th width="60">입사일자</th>
                        <th width="60">퇴사일자</th>
                        <th width="60">교육이수</th>
                        <th width="60">이수일자</th>
                        <th width="60">삭제구분</th>
                        <th width="60">수정</th>
                        <th width="60">삭제</th>
                    </tr>
                </table>
            </div>        
        </td>
      </tr>
      <tr> 
          <td ><div id="DIV_Content" style="width:810px;height:455px;overflow:scroll" onscroll="scrollAll();">
                  <table width="780" cellspacing="0" cellpadding="0" border="0" class="g_table">
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


