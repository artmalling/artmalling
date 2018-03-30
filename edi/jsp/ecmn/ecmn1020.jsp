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

<script type="text/javascript">
var userid = '<%=userid%>';
var gb = '<%=gb%>';
var vencd = '<%=vencd%>';
var venNm = '<%=venNm%>';
var g_strcd = '<%=strcd%>';
var pumbunCd    = '<%=pumbunCd%>';
var g_pre_row = -1;
var g_last_row = -1;
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
    
    /* 구분 값이 브랜드로 로그인시 "전체" 값 없음 */
    if(gb=="1"){
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "Y", pumbunCd);             //점별 브랜드	
    }else{
    	getPumbunCombo(g_strcd, vencd, "pubumCd", "N", pumbunCd);             //점별 브랜드
    }
    
    
    
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
		      

	<ajax:open callback="on_loadedXML" 
		param="param" 
		method="POST" 
		urlvalue="/edi/ecmn102.em"/>
	
	<ajax:callback function="on_loadedXML">	    
	    var content = "";
		if( rowsNode.length > 0 ){
		 
		  content += "<table width='795' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
		  
		  
		  for( i = 0; i < rowsNode.length; i++ ){
			  var node0 = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
			  var node1 = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
			  var node2 = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
			  var node3 = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
			  var node4 = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
			  var node5 = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
			  var node6 = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
			  var node7 = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
			  var node8 = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
			  var node9 = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
			  var node10 = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
			  
		      content += "<tr onclick='chBak("+i+");' ondblclick='getDetail("+i+");' style='cursor:hand;'>";
		      content += "<input type='hidden' name='hid0"+i+"' value='"+node0+"' />";
		      content += "<input type='hidden' name='hid3"+i+"' value='"+node3+"' />";
		      content += "<input type='hidden' name='hid5"+i+"' value='"+node5+"' />";
		      content += "<input type='hidden' name='hid4"+i+"' value='"+node4+"' />";
		      content += "<td class='r1' id='1tdId"+i+"' width='45'>"+(i+1)+"</td>";
		      content += "<td class='r3' id='2tdId"+i+"' width='85'>"+node1+"</td>";
		      content += "<td class='r3' id='3tdId"+i+"' width='85'>"+node3+"</td>";
		      content += "<td class='r1' id='4tdId"+i+"' width='45'>"+node4+"</td>";
		      if( node6.length > 17 ){
		    	  content += "<td class='r3' id='5tdId"+i+"' style='text-decoration:underline;' width='223' title='"+node6+"' >"+node6.substring(0,17)+" ..</td>";  
		      }else {
		    	  content += "<td class='r3' id='5tdId"+i+"' style='text-decoration:underline;' width='223'>"+node6+"</td>";
		      }
		      
		      if( node9.length > 6 ){
		    	  content += "<td class='r3' id='6tdId"+i+"' width='85' title='"+node9+"'>"+node9.substring(0, 6)+" ..</td>";  
		      } else {
		    	  content += "<td class='r3' id='6tdId"+i+"' width='85' title='"+node9+"'>"+node9+"</td>";
		      }
		      
		      
		      content += "<td class='r1' id='7tdId"+i+"' width='102'>"+getDateFormat(node5)+"</td>";
		      content += "<td class='r1' id='8tdId"+i+"' width='85'>"+node10+"</td>";        
		      content += "</tr>";
		  }
		  content += "</table>"; 
		  
		}
		document.getElementById("DIV_CONTETN").innerHTML = content;
		setPorcCount("SELECT", rowsNode.length);
    </ajax:callback>
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



/**
 * getDetail()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  팝업 생성  
 * return값 : void
 */
function getDetail(i){
		
	var strcd = document.getElementById("hid0"+i).value;
	var pumbuncd = document.getElementById("hid3"+i).value;
    var reg_dt = document.getElementById("hid5"+i).value;
    var seq_no = document.getElementById("hid4"+i).value;
    
    var arrArg  = new Array();
    
    arrArg.push(strcd);
    arrArg.push(reg_dt);
    arrArg.push(seq_no);
    arrArg.push(userid);
    arrArg.push(pumbuncd);
	
	var returnVal= window.showModalDialog("/edi/ecmn102.em?goTo=listDtl",
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
 * 개    요 :  리스트 등록  
 * return값 : void
 */
function btn_create(){
	
	 
    var arrArg  = new Array(); 
    
    var pumbuncd = document.getElementById("pubumCd").value;   //물어보고 설정이 필요
    arrArg.push(g_strcd);
    arrArg.push(vencd);
    arrArg.push(venNm);
    arrArg.push(gb);
    arrArg.push(userid);
    
    
    
    var returnVal= window.showModalDialog("/edi/ecmn102.em?goTo=insertDtl",
    		arrArg,
            "dialogWidth:840px;dialogHeight:475px;scroll:no;" +
            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    
    if( returnVal ){
        getSearch();
    }else {
        return;
    }
	
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
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>Q&A리스트</td>
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

