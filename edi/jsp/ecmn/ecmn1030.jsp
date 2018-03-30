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

<script type="text/javascript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var userid = '<%=userid%>';
var gb = '<%=gb%>';
var vencd = '<%=vencd%>';
var venNm = '<%=venNm%>';
var g_strcd = '<%=strcd%>';
var g_pre_row = -1;
var g_last_row = -1;

/*************************************************************************
 *  전역변수
 *************************************************************************/
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
    enableControl(excel,false);    //엑셀
    enableControl(prints,false);    //프린터
    enableControl(set,false);    //프린터
    
    
    /*  조회 항목  */
    
    
    initDateText('SYYYYMMDD', 'em_S_Date');        //시작일
    initDateText("TODAY", "em_E_Date");        //종료일
    
    getPumbunCombo(g_strcd, vencd, "pubumCd", "Y");             //점별 브랜드
    
    document.getElementById("strcd").value = '<%=strcd%>';
    document.getElementById("read_cnt").value = "100";
 
    //화면로딩시 바로 조회 2011.07.13 추가 kjm
      btn_Sch();
    
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
 * 개    요 :  조회  
 * return값 : void
 */
function btn_Sch(){
    
    var sDate = document.getElementById("em_S_Date").value;
    var eDate = document.getElementById("em_E_Date").value;
    
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
    
    var strcd = document.getElementById("strcd").value;
    var vencd = document.getElementById("vencd").value;
    var pumbencd = document.getElementById("pubumCd").value;
    var sDate = document.getElementById("em_S_Date").value;
    var eDate = document.getElementById("em_E_Date").value;
    var title = document.getElementById("em_title").value;
    var readCnt = document.getElementById("read_cnt").value;
    
    var em_sdate = getRawData(trim(sDate));
    var em_edate = getRawData(trim(eDate));   
    
    var param = "&goTo=getMaster&strcd="+strcd+"&vencd="+vencd
              + "&pumbencd=" + pumbencd
              + "&sDate=" + em_sdate
              + "&eDate=" + em_edate
              + "&title=" + encodeURIComponent(title)
              + "&readCnt=" + readCnt;
    
    var Urleren = "/edi/ecmn103.em"; 
    URL = Urleren + "?" +param; 
    strMst = getXMLHttpRequest(); 
    strMst.onreadystatechange = responseMaster;
    strMst.open("GET", URL, true); 
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
     if(strMst.readyState==4)
     {
          if(strMst.status == 200)
          {
              strMst = eval(strMst.responseText); 
              
              
              var content = "<table width='795' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
              
              if( strMst == undefined ){
            	  content += "</table>";
                  document.getElementById("DIV_CONTETN").innerHTML = content;
                  setPorcCount("SELECT", 0);
            	  return;
              }
              
              if( strMst.length > 0 ){
            	  
            	  for( i = 0; i < strMst.length; i++ ){
            		  
            		              		  
            		  
            		  content += "<tr onclick='chBak("+i+")' ondblclick='getDetail("+i+");'  style='cursor:hand;'>";
            		  content += "<input type='hidden' name='m_strcd' id='m_strcd"+i+"' value='"+strMst[i].STR_CD+"' >";
            		  content += "<input type='hidden' name='m_regDt' id='m_regDt"+i+"' value='"+strMst[i].REG_DT+"' >";
            		  content += "<input type='hidden' name='m_seqNo' id='m_seqNo"+i+"' value='"+strMst[i].SEQ_NO+"' >";
            		  content += "<td width='45' class='r1' id='1tdId"+i+"'>"+(i+1)+"</td>"
            	      content += "<td width='85' class='r3' id='2tdId"+i+"'>"+strMst[i].STR_NM+"</td>"
            		  if( strMst[i].PUMBUN_NM.length > 7 ){
            			  content += "<td width='85' class='r3' id='3tdId"+i+"' title='"+strMst[i].PUMBUN_NM+"'>"+strMst[i].PUMBUN_NM.substring(0,5)+"..</td>"  
            		  } else {
            			  content += "<td width='85' class='r3' id='3tdId"+i+"'>"+strMst[i].PUMBUN_NM+"</td>"
            		  }
            	      
            		  content += "<td width='45' class='r1' id='4tdId"+i+"'>"+strMst[i].SEQ_NO+"</td>"
            		  
            		  if( strMst[i].TITLE.length > 17 ){
            			  content += "<td width='223' class='r3' id='5tdId"+i+"'  style='text-decoration:underline;'  title='"+strMst[i].TITLE+"' >"+strMst[i].TITLE.substring(0,17)+"..</td>"  
            		  }else {
            			  content += "<td width='223' style='text-decoration:underline;' class='r3' id='5tdId"+i+"' >"+strMst[i].TITLE+"</td>"
            		  }
            		  
            		  if( strMst[i].BUYERNAME.length > 6 ){
            			  content += "<td width='85' class='r3' id='6tdId"+i+"' title='"+strMst[i].BUYERNAME+"'>"+strMst[i].BUYERNAME.substring(0,6)+"..</td>"  
            		  } else {
            			  content += "<td width='85' class='r3' id='6tdId"+i+"'>"+strMst[i].BUYERNAME+"</td>"
            		  }
            		  
            		  
            		  content += "<td width='102' class='r1' id='7tdId"+i+"'>"+getDateFormat(strMst[i].REG_DT)+"</td>"
            	      content += "<td width='85' class='r1' id='8tdId"+i+"'>"+strMst[i].TIME+"</td>"
            		  content += "</tr>";
            	  }

              }
              content += "</table>";
              document.getElementById("DIV_CONTETN").innerHTML = content; 
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
  * getDetail()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  팝업 생성  
  * return값 : void
*/
function getDetail(i){
         
     var strcd = document.getElementById("m_strcd"+i).value;
     var reg_dt = document.getElementById("m_regDt"+i).value;
     var seq_no = document.getElementById("m_seqNo"+i).value;
     
     var arrArg  = new Array();
     
     arrArg.push(strcd);
     arrArg.push(reg_dt);
     arrArg.push(seq_no);
     arrArg.push(userid);
     
     var returnVal= window.showModalDialog("/edi/ecmn103.em?goTo=listDtl",
                    arrArg,
                    "dialogWidth:840px;dialogHeight:478px;scroll:no;" +
                    "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
     if( returnVal ){
         getSearch();
     }else {
         return;
     }
     
}
 
 /**
  * btn_create()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  법률자문 등록 팝업
  * return값 : void
  */ 
function btn_create(){
    
	var arrArg  = new Array();
    
    arrArg.push(g_strcd);
    arrArg.push(vencd);
    arrArg.push(venNm);
    arrArg.push(gb);
    arrArg.push(userid);
    
    var returnVal= window.showModalDialog("/edi/ecmn103.em?goTo=insertDtl",
            arrArg,
            "dialogWidth:840px;dialogHeight:475px;scroll:no;" +
            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    
    if( returnVal ){
        getSearch();
    }else {
        return;
    }
}

function chBak(val) {
    g_last_row = val;
    
    if (g_pre_row != g_last_row){
        for(i=1;i<9;i++) {
            document.getElementById(i+"tdId"+val).style.backgroundColor="#fff56E";
    
            if (g_pre_row != -1) {
                document.getElementById(i+"tdId"+g_pre_row).style.backgroundColor="#ffffff";
            }
        }
    }
    g_pre_row = g_last_row;
}






function scrollAll(){
    document.all.DIV_TITLE.scrollLeft = document.all.DIV_CONTETN.scrollLeft;
}


</script>
</head>
<body  class="PL10 PR07 PT15" onload="doinit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>법률자문Q&A리스트</td>
        <td ><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<%=dir%>/imgs/btn/search.gif" width="50" height="22" id="search" onclick="javascript:btn_Sch();"/></td>
            <td><img src="<%=dir%>/imgs/btn/new.gif" width="50" height="22" id="newrow" onclick="addRow();" /></td>
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
        <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="POINT">점</th>
            <td width="210"><input type="text"  name="strnm" id="strnm" size="30" maxlength="10" value="<%=strNm%>" disabled="disabled" /><input type="hidden" name="strcd" id="strcd" ></td>
            <th width="80" class="POINT">협력사코드</th>
            <td width="140">
                <input type="hidden" name="vencd"  id="vencd" value="<%=vencd%>" disabled="disabled"  />
                <input type="text" name="venNM" id="venNM" size="20" value="<%=venNm %>" disabled="disabled" />
            </td>
            <th width="80">브랜드코드</th>
            <td>
                <select name="pubumCd" id="pubumCd" style="width: 133;">
                
                </select>
            </td>
          </tr>
          <tr>
            <th width="80" class="POINT">기간</th>
            <td ><input type="text" name="em_S_Date" id="em_S_Date" size="10" title="YYYY-MM-DD" value="" maxlength="10" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);"  style='text-align:center;IME-MODE: disabled' /> 
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onclick="openCal('G',em_S_Date);return false;" /> ~
                 <input type="text" name="em_E_Date" id="em_E_Date" size="10" maxlength="10" value="" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' />
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onclick="openCal('G',em_E_Date);return false;" />
            </td>
            <th width="80">제목</th>
            <td ><input type="text" name="em_title" id="em_title" value="" onkeyup="checkByteLength(this, 50);" /></td>
            <th width="80">조회건수</th>
            <td><input type="text" name="read_cnt" id="read_cnt" onkeypress="javascript:onlyNumber();" value=""  style='text-align:right;IME-MODE: disabled' maxlength="3" /></td>
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
    <td align="right""><img src="<%=dir%>/imgs/btn/q_a_regi.gif" title="Q&A저장" onclick="javascript:btn_create();" /></td>
  </tr>
  <tr>
    <td height="4"></td>
  </tr>
  <tr valign="top">
    <td >
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr valign="top">
        <td>
            <div id="DIV_TITLE" style=" width:815px;  overflow:hidden;">
               <table width="815" border="0" cellspacing="0" cellpadding="0" class="g_table">
                   <tr>
                       <th width="45">NO</th>
                       <th width="85">점</th>
                       <th width="85">브랜드</th>
                       <th width="45">순번</th>
                       <th width="223">질문제목</th>
                       <th width="85">담당바이어</th>
                       <th width="102">일자</th>
                       <th width="85">시간</th>
                       <th width="15">&nbsp;</th>
                   </tr>
               </table> 
           </div>
        </td>
        </tr>
        <tr>
            <td>
                <div id="DIV_CONTETN" style="width:815px;height:437px;overflow:scroll" onscroll="scrollAll();">
                    <table width="795" border="0" cellspacing="0" cellpadding="0" class="g_table">
                    </table>
                </div>
            </td>
        </tr>
    </table>
    </td>
  </tr>
</table>

</body>
</html>

