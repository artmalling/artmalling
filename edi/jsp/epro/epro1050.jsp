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

/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var userid = '<%=userid%>';                     //아이디
var gb = '<%=gb%>';                             //구분 : 1.협력사 2.브랜드
var vencd = '<%=vencd%>';                       //협력사코드
var venNm = '<%=venNm%>';                       //협력사명
var g_strcd = '<%=strcd%>';                     //점코드
var g_pre_row = -1;                             
var g_last_row = -1;

var dayDays = new Array();                      //날짜의 일
var promiss = new Array();                      //약속건수
var strMst = "";        

today = new Date();
var year = today.getYear();      //현재 년
var month = today.getMonth()+1;  //현재 월
var day = today.getDate();       //현재일   

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
    enableControl(excel,false);    //엑셀
    enableControl(prints,false);    //프린터
    enableControl(set,false);    //프린터
    
    /*  조회부 */
    getPumbunCombo(g_strcd, vencd, "pubumCd", "Y");             //점별 브랜드
    document.getElementById("strcd").value = '<%=strcd%>';  
    
    btn_Sch(year, month);             //조회
     
    //getCalandal(year, month);      //달력
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
 * btn_Sch()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  최초 로딩 시 약속현황 조회
 * return값 : void
 */ 
function btn_Sch(year, mon){
    
    var strStrcd = document.getElementById("strcd").value;                        //점코드
    var strVencd = document.getElementById("vencd").value;                        //협력사코드
    var strPumbuncd = document.getElementById("pubumCd").value;                   //브랜드코드
    var strYYYYMM = "";
    var month = "";
    
    if( strPumbuncd == "" ){
    	strPumbuncd = "%";
    }
    if( String(mon).length == 1 ){
    	month = "0" + String(mon);
    }
    strYYYYMM = String(year) + month;
    
    dayDays = new Array();                //날짜의 일 초기화
    promiss = new Array();                //약속 건수 초기화
    
    var param = "&goTo=getDayPromiss" + "&strcd=" + strStrcd
                                     + "&vencd=" + strVencd
                                     + "&pumbuncd=" + strPumbuncd
                                     + "&strYYYYMM=" + strYYYYMM;
    
    
    <ajax:open callback="on_CalendalXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/epro105.ep"/>
    
    <ajax:callback function="on_CalendalXML">
        
        for( i = 0; i < rowsNode.length; i++ ){
        	dayDays[i] = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
        	promiss[i] = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
        }
        
        getCalandal(year, mon); 
    </ajax:callback>
    
}

/**
 * btn_Sch2()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  조회 버튼 클릭시 약속현황 조회
 * return값 : void
 */ 
function btn_Sch2(){
    
    var strStrcd = document.getElementById("strcd").value;                        //점코드
    var strVencd = document.getElementById("vencd").value;                        //협력사코드
    var strPumbuncd = document.getElementById("pubumCd").value;                   //브랜드코드
    var strYYYY = document.getElementById("selyear").value;                       //년
    var strMM = document.getElementById("selmon").value;                          //월
    var strYYYYMM = "";                                                           //년월
    
    if( strMM.length == 1 ){
    	strMM = "0" + strMM; 
    }
    strYYYYMM = strYYYY + strMM;
    
    dayDays = new Array();                //날짜의 일 초기화
    promiss = new Array();                //약속 건수 초기화
    
    var param = "&goTo=getDayPromiss" + "&strcd=" + strStrcd
                                     + "&vencd=" + strVencd
                                     + "&pumbuncd=" + strPumbuncd
                                     + "&strYYYYMM=" + strYYYYMM;
    
    
    <ajax:open callback="on_CalendalXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/epro105.ep"/>
    
    <ajax:callback function="on_CalendalXML">
        
        for( i = 0; i < rowsNode.length; i++ ){
            dayDays[i] = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
            promiss[i] = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
        }
        
        getCalandal(strYYYY, Number(strMM)); 
    </ajax:callback>
    
}


/**
 * getCalandal()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 : 달력 그리기
 * return값 : void
 */ 
function getCalandal(year, month){
	    
	    var firstday = new Date(parseInt(year), parseInt(month)-1, 1);    
	    var firstdayweek = firstday.getDay();    
	    var Lday = new Date(year, month, 0);
	    var lastday = Lday.getDate();        
	    
	    var lastDay2 = new Date(year, month-1, lastday);
	    var lastDay2week = lastDay2.getDay();//0:일 ~6:토
	    var strlastDay2 = lastDay2week+1;//1:일 ~7:토
	    
	    var tempRow;
	    count = 0;
	    line = 1;
	    var h=1;        

        var content = "";
        content = "<table width='100%' height='100%' cellpadding=0 cellspacing=0 style='border-collapse:collapse; empty-cells:show; ' >";
        content += "<tr>";
        content += "<td COLSPAN=7 class='d_date' width='100%'  align='center'>";
        content += "<table width='100%' align='center'>";
        content += "<td  align='right' width='64%'>";
        
        content += "<a href='javascript:void(0);' onclick='perYear("+year+", "+month+");'><img src='<%=dir%>/imgs/btn/first.gif' align=absmiddle hspace='2'></a><a href='javascript:void(0);' onclick='PerMonth("+year+","+month+");'><img src='<%=dir%>/imgs/btn/before2.gif' align=absmiddle hspace='2'></a> ";
        content += "<input type='text' id='selyear' ReadOnly value='"+year+"' class='d_nu' >";
        content += "<input type='text' id='selmon' ReadOnly value='"+month+"' class='d_nu' >";
        content += "<a href='javascript:void(0);' onclick='nextMonth("+year+","+month+");' ><img src='<%=dir%>/imgs/btn/next2.gif' align=absmiddle hspace='2'></a><a href='javascript:void(0);' onclick='nextYear("+year+", "+month+");' ><img src='<%=dir%>/imgs/btn/last.gif' align=absmiddle hspace='2'></a>";
        
        content +="</td>"
        content += "<td  class='right' valign='bottom'>" 
        content += "<img src='<%=dir%>/imgs/comm/square_red.gif' align=absmiddle hspace='2'>접수건수(<span class='red'>처리예정건수</span> / <span class='sky'>완료건수</span>)</td>";
        content += "</table>"
        content +="</td>"
                 
      
        content += "</tr>";
        content += "<tr><td class='d_red' >일</td><td class='d_com'>월</td><td class='d_com'>화</td><td class='d_com'>수</td><td class='d_com'>목</td><td class='d_com'>금</td><td class='d_blue'>토</td></Tr>";
        content += "<tr align=center>";
        
        for( i = 0; i < firstdayweek; i++ ){
        content += "<td class='d_day'>&nbsp;</td>";   
           line++;  
        }
        for(j = 1; j <= lastday; j++ ){
            if( line == 8 ){
                content += "</tr><tr align=center>";
                line = 1;
            }
            
            if( dayDays.length < 1){
            	content += "<td id='td"+j+"' class='d_day'>"+j+"<br> 0 (0/0)</td>";	
            }else {
            	for( k = 0; k < dayDays.length; k++ ){
                    if( dayDays[k] == j ){
                        tempRow = k;
                        break;
                    } else {
                        tempRow = -1;
                    }
                }
            	
            	 if ( tempRow != -1 ){
                     content += "<td id='td"+j+"' class='d_day' >"+j+"<br><a href='javascript:void(0);' onclick='callDetailPop("+year+", "+month+", "+j+");' ><span class='red'>"+promiss[tempRow]+"</sapn></a></td>";
                     
                 }else {
                     content += "<td id='td"+j+"' class='d_day'>"+j+"<br> 0 (0/0) </td>";
                 }
            }
            
            line++;  
            
            if(j == lastday ){
                for( m = 1; m <= 7 - strlastDay2; m++ ){
                    content += "<td class='d_day'>&nbsp;</td>";   
                    line++;  
                }
                line = 1;
            } 
            
        }
        
        
        
        content += "</tr>"        
            
        content += "</tr>";
        content += "</table>"
        document.getElementById('calandal').innerHTML = content;    
}
/**
 * callDetailPop()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  약속건수 상세팝업
 * return값 : void
 */
function callDetailPop(year , month , day){   
	    
    var strStrcd = document.getElementById("strcd").value;                        //점코드
    var strVencd = document.getElementById("vencd").value;                        //협력사코드
    var strPumbuncd = document.getElementById("pubumCd").value;                   //브랜드코드
    var mon = String(month);                                                      //월
    var day = String(day);                                                        //일
    
    if( mon.length == 1 ){
        mon = "0" + mon;
    }
    if( day.length == 1 ){
        day = "0" + day;
    }
    
    var date = String(year) + mon + day;    
    var arrArg  = new Array();
    
    arrArg.push(strStrcd);
    arrArg.push(strVencd);
    arrArg.push(strPumbuncd);
    arrArg.push(date);
    
    var returnVal= window.showModalDialog("/edi/epro105.ep?goTo=listDtl&strcd="+strStrcd+"&vencd="+strVencd+"&pumbuncd="+strPumbuncd+"&date="+date+"",
            arrArg,
            "dialogWidth:840px;dialogHeight:715px;scroll:no;" +
            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    
}

/**
 * perYear()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  달력 전년도 이미지 버튼 클릭시 1년 빼기  예) 2006년 -> 2005년
 * return값 : void
 */
function perYear(year, month){
    
    var cYear;
    var cMonth;
    
    cYear = round(year, 0) - 1;
    cMonth = month;
    
    btn_Sch(cYear, cMonth);
}
 /**
  * PerMonth()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  달력 이전 월 이미지 버튼 클릭시 이전달 달력 그리기    
  * return값 : void
  */
function PerMonth( year , month ){
    
    var mm = month;  
    var cYear;
    var cMonth;
    
    if( mm == "1" ){    
       cYear = round(document.getElementById('selyear').value, 0) - 1;
       cMonth = "12"; 
       
    }else {     
        cYear = document.getElementById('selyear').value;
        cMonth = round(document.getElementById('selmon').value, 0) - 1;     
    }
   
    
    btn_Sch(cYear, cMonth);
}
/**
 * nextMonth()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  달력 다음 월 이미지 버튼 클릭시 다음달 달력   그리기
 * return값 : void
 */ 
function nextMonth(year, month){
    var mm = month;  
    var cYear;
    var cMonth;    
    
    if( mm == "12" ){
        cYear = round(document.getElementById('selyear').value, 0) + 1;
        cMonth = "1";
    }else {
        cYear = document.getElementById('selyear').value;
        cMonth = round(document.getElementById('selmon').value, 0) + 1;
    }
        
    
    btn_Sch(cYear, cMonth);
}
/**
 * nextYear()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  달력 다음 년 이미지 버튼 클릭시 다음년 달력   그리기
 * return값 : void
 */ 
function nextYear(year, month){
    var cYear;
    var cMonth;
    
    cYear = round(year, 0) + 1;
    cMonth = month;
    
    btn_Sch(cYear, cMonth);
}

</script>
</head>
<body  class="PL10 PR07 PT15" onLoad="doinit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>약속분석현황</td>
        <td><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onClick="javascript:btn_Sch2();"/></td>
            <td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow"  /></td>
            <td><img src="<%=dir%>/imgs/btn/del.gif" width="50" height="22" id="del" /></td>
            <td><img src="<%=dir%>/imgs/btn/save.gif" width="50" height="22" id="save" /></td>
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
    <table width="100%"  border="0" cellspacing="0" cellpadding="0" >
        <tr valign="top">
            <td>
               <div id="calandal">
               </div>
            </td>
        </tr>
    </table>
    </td>
  </tr>
</table>

</body>
</html>
