<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"
 import="kr.fujitsu.ffw.base.BaseProperty,kr.fujitsu.ffw.util.String2,kr.fujitsu.ffw.control.ActionForm" %>
<%@ page import="ecom.util.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="sun.misc.FormattedFloatingDecimal.Form"%>
<%@ page import="ecom.vo.SessionInfo2"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
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
<script language="javascript">
    var today    = new Date();
    var old_Row = 0;
    var searchChk = "";

    // 오늘 일자 셋팅 
    var now = new Date();
    var mon = now.getMonth()+1;
    if(mon < 10)mon = "0" + mon;
    var day = now.getDate();
    if(day < 10)day = "0" + day;
    var varToday = now.getYear().toString()+ mon + day;
    var varToMon = now.getYear().toString()+ mon;
</script>

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
var strCond	= "";


var dayDays = new Array();                      //날짜의 일
var dayEvtSaleAmt = new Array();                //행사
var dayNormSaleAmt = new Array();              //정상매출

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 
function doinit(){
     
    /*  버튼비활성화  */
    enableControl(search,true);   //신규   
    enableControl(newrow,false);   //신규    
    enableControl(del,false);      //삭제
    enableControl(save,false);     //저장
    enableControl(excel,true);    //엑셀
    enableControl(prints,false);    //프린터
    enableControl(set,false);    //프린터 
   
    /*  조회부 */
    /* 구분 값이 브랜드로 로그인시 "전체" 값 없음 */
    if(gb=="1"){
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "Y", pumbunCd);             //점별 브랜드
    }else{
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "N", pumbunCd);             //점별 브랜드
    }
    
    initDateText("YYYYMM", "selMon");        //조회월
    document.getElementById("strcd").value = '<%=strcd%>';  
    
    
    getCalandal();      //달력 
    
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

function btn_Sch(){
	
	var strStrcd = document.getElementById("strcd").value;                        //점코드
    var strVencd = document.getElementById("vencd").value;                        //협력사코드
    var strPumbuncd = document.getElementById("pubumCd").value;                   //브랜드코드
    var strselYMon = getRawData(document.getElementById("selMon").value);          //조회월
	
	if( document.getElementById("selMon").value == "" ){
		
		showMessage(INFORMATION, OK, "USER-1003", "조회월");
		document.getElementById("selMon").focus();
		return;
	}
    	
	
	
	dayDays = new Array();                      //날짜의 일 초기화
	dayEvtSaleAmt = new Array();                //행사 초기화
	dayNormSaleAmt = new Array();              //정상매출 초기화
	
	var param = "&goTo=getDaynorevt" + "&strcd=" + strStrcd
                                     + "&vencd=" + strVencd
                                     + "&pumbuncd=" + strPumbuncd
	                                 + "&selDate=" + strselYMon;
	   
	// 조건확인을 위한 전역변수에 param 초기화.
    strCond = param;
	
	<ajax:open callback="on_calenDalXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/esal104.es"/>
        

    <ajax:callback function="on_calenDalXML">
	    
    	if (rowsNode.length == 0) {
    		strCond = "";
    		return;
    	}
    	
        for(i = 0; i < rowsNode.length; i++){
        	dayDays[i] = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
        	dayEvtSaleAmt[i] = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
        	dayNormSaleAmt[i] = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
        }
        getCalandal2();
        
    </ajax:callback>
	
	
	
}

function getCalandal2(){
    
   // callDetailPop();
    
    var strDate  = getRawData(document.getElementById("selMon").value)+"01";
    
    var Lday = new Date(strDate.substr(0,4), strDate.substr(4,2), 0);
    var lastday  = Lday.getDate();
    
    var year = strDate.substr(0,4);
    var month = strDate.substr(4,2);
    
    var firstday = new Date(strDate.substr(0,4), strDate.substr(4,2)-1, strDate.substr(6,2));
    var firstdayweek = firstday.getDay();//0:일 ~6:토
    var strWeekNum = firstdayweek+1;//1:일 ~7:토
    var strWeek = "";
    
    var lastDay2 = new Date(strDate.substr(0,4), strDate.substr(4,2)-1, lastday);
    var lastDay2week = lastDay2.getDay();//0:일 ~6:토
    var strlastDay2 = lastDay2week+1;//1:일 ~7:토

    var tempRow;
    count = 0;
    line = 1;
    
    var h=1;
    
    var strevtSaleAmtSum  = 0;      //주간합계 행사
    var strNormSaleAmt  = 0;        //주간합계 정상
    
    

    var content = "";
    content += "<table width='100%' height='100%' cellpadding=0 cellspacing=0 style='border-collapse:collapse; empty-cells:show; ' >";
    content += "<tr>";
    content += "<td COLSPAN=7 class='d_date' width='100%'  align='center'>";
    content += "<table width='100%' align='center'>";
    content += "<td>";
    
    content += "</tr>";
    content += "<tr><td class='d_com' width='60'>구분</td><td class='d_red' width='85'>SUN(일)</td><td class='d_com' width='85'>MON(월)</td><td class='d_com' width='85'>TUE(화)</td><td class='d_com' width='85'>WED(수)</td><td class='d_com' width='85'>THU(목)</td><td class='d_com' width='85'>FRI(금)</td><td class='d_blue' width='85'>SAT(토)</td><td class='d_com' >주간/전체합계</td></tr>";
    content += "<tr align=center>";
    content += "<td class='d_comh' ><div align=left>&nbsp;</div><br>행사<br>&nbsp;정상&nbsp;<br></a></td>";
    
    for( i = 0; i < firstdayweek; i++ ){
    	content += "<td class='d_day' >&nbsp;</td>"; 
       line++;  
    }
    for(j = 1; j <= lastday; j++ ){
        
        if( line == 8 ){
        	
            
        	content += "<td id='td"+j+"' class='d_num'  ><div align=left>&nbsp;</div><br><span class='red' >"+convAmt(String(strevtSaleAmtSum))+"<br>"+convAmt(String(strNormSaleAmt))+"</sapn></a></td>";
            content += "</tr><tr align=center>";
            content += "<td class='d_comh'><div align=left>&nbsp;</div><br>행사&nbsp;<br>&nbsp;정상&nbsp;<br></a></td>";
            
            strevtSaleAmtSum = 0; 
            strNormSaleAmt = 0;
            line = 1;
        }
        
        if( dayDays.length < 1  ){
        	content += "<td id='td"+j+"' class='d_num'   ><div align=left>"+j+"</div><br><span class='red' >0 <br> 0</span> </td>";
        }else {
	        for( k = 0; k < dayDays.length; k++ ){
	        	if( dayDays[k] == j ){
	        		tempRow = k;
	        		break;
	        	} else {
	        		tempRow = -1;
	        	}
	        }
	        
	        
	        if( tempRow != -1 ){
	        	content += "<td id='td"+j+"' class='d_num'   ><div align=left>"+j+"</div><br><span class='red' >"+convAmt(dayEvtSaleAmt[tempRow])+" <br> "+convAmt(dayNormSaleAmt[tempRow])+"</span> </td>";
	        	
	        	strevtSaleAmtSum +=  Number(dayEvtSaleAmt[tempRow]);
	        	strNormSaleAmt += Number(dayNormSaleAmt[tempRow]);
	        } else {
	        	content += "<td id='td"+j+"' class='d_num'   ><div align=left>"+j+"</div><br><span class='red' >0 <br> 0</span> </td>";
	        }
        
        }
        
        line++; 
        
        if(j == lastday ){
            for( m = 1; m <= 7 - strlastDay2; m++ ){
                content += "<td class='d_day'>&nbsp;</td>";   
                line++;  
            }
            
            content += "<td id='td"+j+"' class='d_num' ><div align=left>&nbsp;</div><br><span class='red' >"+convAmt(String(strevtSaleAmtSum))+"<br>"+convAmt(String(strNormSaleAmt))+"</sapn></a></td>";
            line = 1;
        } 
        
    }
    content += "</tr>"        
        
    content += "</tr>";
    content += "</table>"
    document.getElementById('calandal').innerHTML = content;    
}


function getCalandal(){
    
	   // callDetailPop();
	    
	    var strDate  = getRawData(document.getElementById("selMon").value)+"01";
	    
	    var Lday = new Date(strDate.substr(0,4), strDate.substr(4,2), 0);
	    var lastday  = Lday.getDate();
	    
	    var year = strDate.substr(0,4);
	    var month = strDate.substr(4,2);
	    
	    var firstday = new Date(strDate.substr(0,4), strDate.substr(4,2)-1, strDate.substr(6,2));
	    var firstdayweek = firstday.getDay();//0:일 ~6:토
	    var strWeekNum = firstdayweek+1;//1:일 ~7:토
	    var strWeek = "";
	    
	    var lastDay2 = new Date(strDate.substr(0,4), strDate.substr(4,2)-1, lastday);
	    var lastDay2week = lastDay2.getDay();//0:일 ~6:토
	    var strlastDay2 = lastDay2week+1;//1:일 ~7:토

	    var tempRow;
	    count = 0;
	    line = 1;
	    
	    var h=1;
	    
	    var strSaleTamt  = 0;
	    var strCustCntT  = 0;
	    var strProfTamt  = 0;
	    var strCmprTamt  = 0;
	    var strCustDanga = 0;
	    var strIRate     = 0;
	    

	    var content = "";
	    content += "<table width='100%' height='100%' cellpadding=0 cellspacing=0 style='border-collapse:collapse; empty-cells:show; ' >";
	    content += "<tr>";
	    content += "<td COLSPAN=7 class='d_date' width='100%'  align='center'>";
	    content += "<table width='100%' align='center'>";
	    content += "<td>";
	    
	    content += "</tr>";
	    content += "<tr><td class='d_com' width='60'>구분</td><td class='d_red' width='85'>SUN(일)</td><td class='d_com' width='85'>MON(월)</td><td class='d_com' width='85'>TUE(화)</td><td class='d_com' width='85'>WED(수)</td><td class='d_com' width='85'>THU(목)</td><td class='d_com' width='85'>FRI(금)</td><td class='d_blue' width='85'>SAT(토)</td><td class='d_com' >주간/전체합계</td></tr>";
	    content += "<tr align=center>";
	    content += "<td class='d_comh' ><div align=left>&nbsp;</div><br>행사<br>&nbsp;정상&nbsp;<br></a></td>";
	    
	    for( i = 0; i < firstdayweek; i++ ){
	        content += "<td class='d_day' >&nbsp;</td>"; 
	       line++;  
	    }
	    for(j = 1; j <= lastday; j++ ){
	        
	        if( line == 8 ){
	            
	            content += "<td id='td"+j+"' class='d_num'  ><div align=left>&nbsp;</div></a></td>";
	            content += "</tr><tr align=center>";
	            content += "<td class='d_comh'><div align=left>&nbsp;</div><br>행사&nbsp;<br>&nbsp;정상&nbsp;<br></a></td>";  
	            
	            line = 1;
	        }
	        content += "<td id='td"+j+"' class='d_num'   ><div align=left>"+j+"</div><br><span class='red' >&nbsp;<br>&nbsp;</span> </td>";
	        
	        line++; 
	        
	        if(j == lastday ){
	            for( m = 1; m <= 7 - strlastDay2; m++ ){
	                content += "<td class='d_day'>&nbsp;</td>";   
	                line++;  
	            }
	            //strSaleTamt = comma(strSaleTamt);
	            //strCustCntT = comma(strCustCntT);
	            //strProfTamt = comma(strProfTamt);
	            //strCmprTamt = comma(strCmprTamt);
	            //strCustDanga = comma(strCustDanga);
	            //content += "<td id='td"+j+"' class='d_num' ><div align=left>&nbsp;</div><br><span class='red' >"+strSaleTamt+"<br>"+strCustCntT+"</sapn></a></td>";
	            line = 1;
	        } 
	        
	    }
	    content += "</tr>"        
	        
	    content += "</tr>";
	    content += "</table>"
	    document.getElementById('calandal').innerHTML = content;    
	}




</script>
</head>
<body  class="PL10 PR07 PT15" onLoad="doinit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>영업카렌더</td>
        <td><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onClick="javascript:btn_Sch();"/></td>
            <td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow"  /></td>
            <td><img src="<%=dir%>/imgs/btn/del.gif" width="50" height="22" id="del" /></td>
            <td><img src="<%=dir%>/imgs/btn/save.gif" width="50" height="22" id="save" /></td>
			<td><img src="<%=dir%>/imgs/btn/excel.gif" width="61" height="22" id="excel" onclick="javascript: excelExport('영업카렌더','TBL',pumbunCd,strCond);"/></td>
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
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="POINT">점</th>
            <td width="120" ><input type="text"  name="strnm" id="strnm" size="17" maxlength="10" value="<%=strNm%>" disabled="disabled" /><input type="hidden" name="strcd" id="strcd"  ></td>
            <th width="80" class="POINT">협력사코드</th>
            <td width="160">
                <input type="hidden" name="vencd" id="vencd" value="<%=vencd%>" disabled="disabled"  />
                <input type="text" name="venNM" id="venNM" size="24" value="<%=venNm %>" disabled="disabled" />
            </td>
            <th width="80" class="POINT">브랜드코드</th>
            <td>
                <select name="pubumCd" id="pubumCd" style="width: 193;">
                    <!--  
                    <option value="%">전체</option>
                    <c:forEach items="${PUMBUNCOMBO}" var="it" varStatus="a">
                        <option value="<c:out value="${it.PUMBUN_CD}" />"><c:out value="${it.PUMBUN_NAME}" /></option>
                    </c:forEach>
                    -->
                </select>
            </td>
          </tr>
          <tr>
            <th >조회월</th>
            <td colspan="5" >
                <input type="text" name="selMon" id="selMon" size="13" onkeypress="javascript:onlyNumber();" onblur="dateOnblur(this);" onfocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' maxlength="6" />
                <img src="<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',selMon)" align="absmiddle" />
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
  <tr valign="top">
    <td >
	    <div id="TBL">
	    <table width="100%"  border="0" cellspacing="0" cellpadding="0" >
	        <tr valign="top">
		        <td>
		           <div id="calandal">
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

