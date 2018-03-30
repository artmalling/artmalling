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
    String vencd = sessionInfo.getVEN_CD();         //협력사코드
    String venNm = sessionInfo.getVEN_NAME();       //협력사명
    String gb = sessionInfo.getGB();                //1. 협력사     2.브랜드
     
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
var g_strcd = '<%=strcd%>';     //점코드
var gb_flag = false;
var g_pre_row = -1;
var g_last_row = -1;

/* 댓글 등록시 */
var ins_strcd;
var ins_reqno;
var ins_regDt;
var ins_row;
/* 댓글 수정, 삭세지*/
var reply_strcd; 
var reply_no;
var reply_dt;
var reply_vencd;//권한 비교 (수정, 삭제)시 사용

/**
 * doit()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  로딩시 초기화
 * return값 : void
 */ 
function doit(){
    
    /*  버튼비활성화  */
    enableControl(newrow,false);   //신규
    enableControl(del,false);      //삭제
    enableControl(save,false);     //저장
    enableControl(excel,false);    //엑셀
    enableControl(prints,false);    //프린터
    enableControl(reply,false);    //댓글버튼
    enableControl(re_modify,false);    //수정버튼
    enableControl(re_del,false);    //수정버튼
    
    
    /*  조회 항목  */
    initDateText('SYYYYMMDD', 'em_S_Date');        //시작일
    initDateText("TODAY", "em_E_Date");        //종료일
    
    getPumbunCombo(g_strcd, vencd, "pubumCd", "Y");             //점별 브랜드
    
    document.getElementById("strcd").value = '<%=strcd%>';
    document.getElementById("read_cnt").value = "100";
    document.getElementById("em_io_title").readOnly = "true";
    document.getElementById("em_io_title").style.backgroundColor="#dcdcdc";
    document.getElementById("content").readOnly = "true";
    document.getElementById("content").style.backgroundColor="#dcdcdc";
    document.getElementById("pubumCd").focus();
    

    //화면로딩시 바로 조회 2011.07.13 추가 kjm
    btn_Search();
    
    
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
 * btn_Search()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  조회
 * return값 : void
 */ 
function btn_Search(){
    
    
    if( document.getElementById("strnm").value == "" ){
        showMessage(INFORMATION, OK, "USER-1003", "점");
        document.getElementById("strnm").focus();
        return;
    }
    
    if( document.getElementById("em_S_Date").value == "" ){
    	showMessage(INFORMATION, OK, "USER-1003", "시작일");
        document.getElementById("em_S_Date").focus();
        return;
    }
    
    if( document.getElementById("em_E_Date").value == "" ){
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
    
	document.getElementById("em_io_title").readOnly = "true";
    document.getElementById("em_io_title").style.backgroundColor="#dcdcdc";
    document.getElementById("content").readOnly = "true";
    document.getElementById("content").style.backgroundColor="#dcdcdc";
	    
    var strcd = document.getElementById("strcd").value;
    var vencd = document.getElementById("vencd").value;
    var pumbencd = document.getElementById("pubumCd").value;
    var sDate = document.getElementById("em_S_Date").value;
    var eDate = document.getElementById("em_E_Date").value;
    var title = document.getElementById("em_title").value;
    var read_cnt = document.getElementById("read_cnt").value;
    
    var em_sdate = getRawData(trim(sDate));
    var em_edate = getRawData(trim(eDate));
    
    var param = "&goTo=getMaster&strcd="+strcd
              + "&vencd=" + vencd 
              + "&pumben=" + encodeURIComponent(pumbencd)
              + "&title=" + encodeURIComponent(title)
              + "&read_cnt=" + read_cnt
              + "&sDate=" + em_sdate
              + "&eDate=" + em_edate;
    
    <ajax:open callback="on_boardSearchXML" 
        param="param" 
        method="POST" 
        urlvalue="/edi/ecmn104.em"/>
    
    
    <ajax:callback function="on_boardSearchXML">
        var content = "";
        if( rowsNode.length > 0 ){
           
           document.getElementById("em_io_title").value = "";
           document.getElementById("regi").value = "";
           document.getElementById("content").value = "";
            
   	       content += "<table width='795' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
   	      
   	       
   	       for(i = 0; i < rowsNode.length; i++){
   	    	   
   	    	   var Gb = rowsNode[i].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[0].childNodes[0].nodeValue;
   	    	   var db_strcd = rowsNode[i].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[1].childNodes[0].nodeValue;
   	    	   var str_nm = rowsNode[i].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[2].childNodes[0].nodeValue;
   	    	   var reg_seq_no = rowsNode[i].childNodes[3].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[3].childNodes[0].nodeValue;
   	    	   var reg_dt = rowsNode[i].childNodes[4].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[4].childNodes[0].nodeValue;
   	    	   var repl_dt = rowsNode[i].childNodes[5].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[5].childNodes[0].nodeValue;
   	    	   var repl_seqno = rowsNode[i].childNodes[6].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[6].childNodes[0].nodeValue;
   	    	   var time = rowsNode[i].childNodes[7].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[7].childNodes[0].nodeValue;
   	    	   var title = rowsNode[i].childNodes[8].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[8].childNodes[0].nodeValue;
   	    	   var buyercd = rowsNode[i].childNodes[9].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[9].childNodes[0].nodeValue;
   	    	   var buyerNm = rowsNode[i].childNodes[10].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[10].childNodes[0].nodeValue;
   	    	   var read_cnt = rowsNode[i].childNodes[11].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[11].childNodes[0].nodeValue;
   	    	   var ven_cd = rowsNode[i].childNodes[12].childNodes[0].nodeValue == "null" ? "" : rowsNode[i].childNodes[12].childNodes[0].nodeValue;
   	    	   
   	    	   if( title.length > 40 ){
   	    		   title = title.substring(0, 40) + " ..";
   	    	   }
   	    	   
   	    	   
   	    	   content += "<tr onclick='chBak("+i+");getDetail("+i+");' style='cursor:hand;' >";
   	    	   content += "<input type='hidden' name='Gb"+i+"' value='"+Gb+"' />";
   	    	   content += "<input type='hidden' name='strcd"+i+"' value='"+db_strcd+"' />";
   	    	   content += "<input type='hidden' name='reg_seq_no"+i+"' value='"+reg_seq_no+"' />";
   	    	   content += "<input type='hidden' name='reg_dt"+i+"' value='"+reg_dt+"' />";
   	    	   content += "<input type='hidden' name='repl_dt"+i+"' value='"+repl_dt+"' />";
   	    	   content += "<input type='hidden' name='repl_seqno"+i+"' value='"+repl_seqno+"' />";
   	    	   content += "<input type='hidden' name='buyercd"+i+"' value='"+buyercd+"' />";
   	    	   content += "<input type='hidden' name='ven_cd"+i+"' id='ven_cd"+i+"' value='"+ven_cd+"' />";
   	    	   content += "<td class='r1' id='1tdId"+i+"' width='35' >"+(i+1)+"</td>";
   	    	   content += "<td class='r1' id='2tdId"+i+"' width='45'>"+reg_seq_no+"</td>";
   	    	   if( Gb == "1" ){    //게시판
	               content += "<td class='r1' id='3tdId"+i+"' width='95'>"+getDateFormat(reg_dt)+"</td>";   
   	    	   } else if( Gb == "2" ){  //댓글
                   content += "<td class='r1' id='3tdId"+i+"' width='95'>"+getDateFormat(repl_dt)+"</td>";
   	    	   }
   	    	   
   	    	   content += "<td class='r1' id='4tdId"+i+"' width='65'>"+time+"</td>";
   	    	   content += "<td class='r3' id='5tdId"+i+"' width='363'>"+title+"</td>";
   	    	   content += "<td class='r3' id='6tdId"+i+"' width='85'>"+buyerNm+"</td>";
   	    	   content += "<td class='r4' id='7tdId"+i+"' width='72'>"+read_cnt+"</td>";
   	    	   content += "</tr>"; 
   	    	//   alert(i);
   	       }
   	       
   	      content += "</table>";    
   	      
       }else {
    	   
    	   document.getElementById("em_io_title").value = "";
           document.getElementById("regi").value = "";
           document.getElementById("content").value = "";
           /*
           content += "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='g_table'>";
    	   content += "<tr>";
    	   content += "<th width='30'>NO </th>";
    	   content += "<th width='60'>순번</th>";
    	   content += "<th width='90'>일자 </th>";
    	   content += "<th width='60'>시간</th>";
    	   content += "<th>제목</th>";
    	   content += "<th width='80'>등록자 </th>";
    	   content += "<th width='70'>조회수</th>";
    	   content += "</tr>";
    	   content += "</table>";
    	   */
       }
       document.getElementById("DIV_CONTETN").innerHTML = content;
       setPorcCount("SELECT", rowsNode.length);
       enableControl(reply,false);    //댓글버튼
       enableControl(re_modify,false);    //수정버튼
       enableControl(re_del,false);    //수정버튼
       if( rowsNode.length > 0 ) { 
           chBak(0);
           getDetail(0);
       }       
    </ajax:callback>

}

function chBak(val) {
	 g_last_row = val;
	    
	    if (g_pre_row != g_last_row){
	        for(i=1;i<8;i++) {
	            document.getElementById(i+"tdId"+val).style.backgroundColor="#ffff00";
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
 * 개    요 :  상세조회
 * return값 : void
 */ 
 
function getDetail( i ){
	var dt_Gb = document.getElementById("Gb"+i).value;
	var dt_strcd = document.getElementById("strcd"+i).value;
	var dt_seqno = document.getElementById("reg_seq_no"+i).value;
	var dt_regdt = document.getElementById("reg_dt"+i).value;
	var dt_replyDt = document.getElementById("repl_dt"+i).value;
	var dt_replyNo = document.getElementById("repl_seqno"+i).value;
	var dt_buyer = document.getElementById("buyercd"+i).value;
	var dt_ven_cd = document.getElementById("ven_cd"+i).value;
	
	var param = "";
	
	if( dt_Gb == "1" ){        //게시판
		document.getElementById("em_io_title").readOnly = "true";
        document.getElementById("em_io_title").style.backgroundColor="#dcdcdc";
		document.getElementById("content").readOnly = "true";
		document.getElementById("content").style.backgroundColor="#dcdcdc";
		enableControl(reply,true);    //댓글버튼
		enableControl(re_modify,false);    //수정버튼
		enableControl(re_del,false);    //수정버튼
		gb_flag = true;
		ins_strcd = dt_strcd;
		ins_reqno = dt_seqno; 
		ins_regDt = dt_regdt;
		ins_row = i;
		param = "&goTo=getDetail&strFlag=board&strcd="+dt_strcd+"&reg_seqNo="+dt_seqno+"&regDt="+dt_regdt+"&Gb="+dt_Gb;
	}else if( dt_Gb == "2" ){      //댓글
		
		reply_strcd = dt_strcd;
        reply_no = dt_replyNo;
        reply_dt = dt_replyDt;
        reply_vencd = dt_ven_cd;
        
        if( reply_vencd != userid ){
        	 enableControl(reply,false);    //댓글버튼
             enableControl(re_modify,false);    //수정버튼
             enableControl(re_del,false);    //수정버튼
             
             document.getElementById("em_io_title").readOnly = "true";
             document.getElementById("em_io_title").style.backgroundColor="#dcdcdc";
             document.getElementById("content").readOnly = "true";
             document.getElementById("content").style.backgroundColor="#dcdcdc";
        }else {
        	 document.getElementById("em_io_title").readOnly = "";
             document.getElementById("em_io_title").style.backgroundColor="#ffffff";
             document.getElementById("content").readOnly = "";
             document.getElementById("content").style.backgroundColor="#ffffff";
             enableControl(reply,false);    //댓글버튼
             enableControl(re_modify,true);    //수정버튼
             enableControl(re_del,true);    //수정버튼 	
        }
        
		param = "&goTo=getDetail&strFlag=reply&reply_dt="+dt_replyDt+"&replyNo="+dt_replyNo+"&Gb="+dt_Gb+"&strcd="+dt_strcd;
	}  
  
    <ajax:open callback="on_boardDetailXML" 
                        param="param" 
                        method="POST" 
                        urlvalue="/edi/ecmn104.em"/>
    
    <ajax:callback function="on_boardDetailXML">
        
        var title = rowsNode[0].childNodes[0].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
        var regi = rowsNode[0].childNodes[1].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[1].childNodes[0].nodeValue;
        var content = rowsNode[0].childNodes[2].childNodes[0].nodeValue == "null" ? "" : rowsNode[0].childNodes[2].childNodes[0].nodeValue;
        
        document.getElementById("em_io_title").value = title;
        document.getElementById("regi").value = regi;
        document.getElementById("content").value = content;
        setPorcCount("SELECT", rowsNode.length);
    </ajax:callback> 
    
}
/**
 * pop_reply()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  댓글 팝업
 * return값 : void
 */ 
 
function pop_reply(){   
    
	if( gb_flag ){
		
		
		var arrArg  = new Array();
		    
	    arrArg.push(ins_strcd);//게시글의 점코드    
	    arrArg.push(ins_reqno);//게시글의 순번
	    arrArg.push(ins_regDt);//게시글의 일자
	    arrArg.push(ins_row);//게시글의 순서(row)
			    
	    var returnVal= window.showModalDialog("/edi/ecmn104.em?goTo=popReply&strcd="+ins_strcd+"&reqNo="+ins_reqno+"&regDt="+ins_regDt,
	                   arrArg,
	                   "dialogWidth:840px;dialogHeight:485px;scroll:no;" +
	                   "resizable:no;help:no;unadorned:yes;center:yes;status:no");
	    
	    if( returnVal ){
	    	
	    	getSearch();
	    	enableControl(reply,false);    //댓글버튼
	        enableControl(re_modify,false);    //수정버튼
	        enableControl(re_del,false);    //수정버튼
	    } else {
	    	return;
	    }
	    gb_flag = false;
	}else {
		showMessage(INFORMATION, YESNO, "GAUCE-1000", "삭제할 수 없습니다.")
		return;
	}
}
/**
 * reply_modify()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  댓글 수정
 * return값 : void
 */ 
function reply_modify(){
	
	var reply_title = document.getElementById("em_io_title").value;
	var reply_content = document.getElementById("content").value;
	 
	if( reply_vencd != userid ){
		showMessage(INFORMATION, OK, "GAUCE-1000", "댓글 수정 권한이 없습니다.");
		return;
	}
	
	if( document.getElementById("em_io_title").value == "" ){
		showMessage(INFORMATION, OK, "USER-1003", "제목");
		document.getElementById("em_io_title").focus();
		return;
	}
	
   if( document.getElementById("content").value == "" ){
	   showMessage(INFORMATION, OK, "USER-1003", "내용");
       document.getElementById("content").focus();
       return;
   }
	
   if( showMessage(QUESTION, YESNO, "GAUCE-1000", "수정하시겠습니까?") != 1){
       return;
   }
	
    var param = "&goTo=updReply&strcd="+reply_strcd+"&replyNo="+reply_no+"&replyDt="+reply_dt
              + "&reply_title="+encodeURIComponent(reply_title)
              + "&reply_content="+encodeURIComponent(reply_content);
       
       <ajax:open callback="on_replyModifyXML" 
           param="param" 
           method="POST" 
           urlvalue="/edi/ecmn104.em"/>
       
       <ajax:callback function="on_replyModifyXML">
	        var cnt = rowsNode[0].childNodes[0].childNodes[0].nodeValue == null ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
	        
	        if( Number(cnt) > 0 ){
	        	showMessage(INFORMATION, OK, "GAUCE-1000", cnt+"건이 수정되었습니다.");
	        }else {
	        	showMessage(INFORMATION, OK, "GAUCE-1000", cnt);
	        }
	        
	        getSearch();
	        enableControl(reply,false);    //댓글버튼
	        enableControl(re_modify,false);    //수정버튼
	        enableControl(re_del,false);    //수정버튼
       </ajax:callback>
        
	
	
}
/**
 * reply_del()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  댓글 삭제
 * return값 : void
 */ 
function reply_del(){
	
	if( reply_vencd != userid ){
        showMessage(INFORMATION, OK, "GAUCE-1000", "댓글 삭제 권한이 없습니다.");
        return;
    }
	
	if( showMessage(QUESTION, YESNO, "GAUCE-1000", "삭제하시겠습니까?") != 1){
	       return;
	}
	
	var param = "&goTo=delReply&strcd="+reply_strcd+"&replyNo="+reply_no+"&replyDt="+reply_dt;
	
	<ajax:open callback="on_replyDeleteXML" 
						param="param" 
						method="POST" 
						urlvalue="/edi/ecmn104.em"/>
	
	<ajax:callback function="on_replyDeleteXML">
		var cnt = rowsNode[0].childNodes[0].childNodes[0].nodeValue == null ? "" : rowsNode[0].childNodes[0].childNodes[0].nodeValue;
		
		if( Number(cnt) > 0 ){
		  showMessage(INFORMATION, OK, "GAUCE-1000", cnt+"건이 삭제되었습니다.");
		}else {
		  showMessage(INFORMATION, OK, "GAUCE-1000", cnt);
		}
		
		getSearch();
		enableControl(reply,false);    //댓글버튼
	    enableControl(re_modify,false);    //수정버튼
	    enableControl(re_del,false);    //수정버튼
	</ajax:callback>

	
}


function scrollAll(){
    document.all.DIV_TITLE.scrollLeft = document.all.DIV_CONTETN.scrollLeft;
}

</script>

</head>

<body  class="PL10 PR07 PT15" onload="doit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>게시판</td>
        <td ><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="/edi/imgs/btn/search.gif" width="50" height="22" id="search" onclick="btn_Search();" /></td>
            <td><img src="/edi/imgs/btn/new.gif" width="50" height="22" id="newrow" /></td>
            <td><img src="/edi/imgs/btn/del.gif" width="50" height="22" id="del" /></td>
            <td><img src="/edi/imgs/btn/save.gif" width="50" height="22" id="save" /></td>
            <td><img src="/edi/imgs/btn/excel.gif" width="61" height="22" id="excel" /></td>
            <td><img src="/edi/imgs/btn/print.gif" width="50" height="22" id="prints"  /></td>
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
            <td width="210"><input type="text" name="strnm" id="strnm" size="30" maxlength="10" value="<%=strNm %>" disabled="disabled" /><input type="hidden" name="strcd" id="strcd" ></td>
            <th width="80" class="POINT">협력사코드</th>
            <td width="140">
                <input type="hidden" name="vencd" id="vencd" value="<%=vencd %>" disabled="disabled" />
                <input type="text" name="venNM" id="venNM" size="20" value="<%=venNm %>" disabled="disabled" />
            </td>
            <th width="80">브랜드코드</th>
            <td>
                <select name="pubumCd" id="pubumCd" style="width: 143;">
                
                </select>
            </td>
          </tr>
          <tr>
            <th width="80" class="POINT">기간</th>
            <td ><input type="text" name="em_S_Date" id="em_S_Date" size="10" title="YYYY-MM-DD" maxlength="10" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' /> 
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onclick="openCal('G',em_S_Date);return false;" /> ~
                 <input type="text" name="em_E_Date" id="em_E_Date" size="10" maxlength="10" onblur="dateCheck(this);" onfocus="dateValid(this);" onkeypress="javascript:onlyNumber();" style='text-align:center;IME-MODE: disabled'/>
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="종료일" align="absmiddle" onclick="openCal('G',em_E_Date);return false;" />
            </td>
            <th width="80">제목</th>
            <td ><input type="text" name="em_title" id="em_title" onkeyup="checkByteLength(this, 50);" /></td>
            <th width="80">조회건수</th>
            <td><input type="text" name="read_cnt" id="read_cnt" onkeypress="javascript:onlyNumber();" size="22" maxlength="3"  style='text-align:right;IME-MODE: disabled' /></td>
          </tr>
        </table></td>
        </tr>
    </table>
    </td>
  </tr>
   <tr>   
    <td class="dot"></td>
  </tr>
  <tr>   
    <td></td>
  </tr>
   <tr>
     <td class="PT01 PB03"><table width="100%" border="1" cellspacing="0" cellpadding="0">
       <tr>
         <td><table width="100%" border="1" cellpadding="0" cellspacing="0" class="s_table" >
           <tr>
             <th width="80" class="POINT">제목</th>
             <td width="441"><input type="text" name="em_io_title" id="em_io_title" size="70" onkeyup="checkByteLength(this, 50);" /></td>
             <th width="80">등록자 </th>
             <td><input type="text" name="regi" id="regi" readonly="readonly" style="width: 173;"  style="background-color:dcdcdc; " /></td>
           </tr>
           <tr>
             <th width="80" class="POINT">내용</th>
             <td colspan="3">
                <textarea name="content" id="content" rows="12" style="width: 100%;"  onkeyup="checkByteLength(this, 4000);" ></textarea>
             </td>
             </tr>
         </table></td>
       </tr>
     </table></td>
   </tr>
   <tr>
    <td></td>
  </tr>
  <tr>
    <td align="right">
        <img src="<%=dir%>/imgs/btn/reply.gif" title="댓글" id="reply" onclick="pop_reply();" />
        <img src="<%=dir%>/imgs/btn/modify.gif" title="수정" id="re_modify" onclick="reply_modify();" />
        <img src="<%=dir%>/imgs/btn/del.gif" title="삭제" id="re_del" onclick="reply_del();" />
    </td>
  </tr>
  <tr valign="top">
    <td>    
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr valign="top">
        <td>
	        <div id="DIV_TITLE" style=" width:815px;  overflow:hidden;">
	           <table width="815" border="0" cellspacing="0" cellpadding="0" class="g_table">
	               <tr>
	                   <th width="35">NO</th>
	                   <th width="45">순번</th>
	                   <th width="95">일자</th>
	                   <th width="65">시간</th>
	                   <th width="363">제목</th>
	                   <th width="85">등록자</th>
	                   <th width="72">조회수</th>
	                   <th width="15">&nbsp;</th>
	               </tr>
	           </table> 
	        </div>
        </td>
        </tr>
        <tr>
            <td>
                <div id="DIV_CONTETN" style="width:815px;height:255px;overflow:scroll" onscroll="scrollAll();">
                        <table width="795" border="0" cellspacing="0" cellpadding="0" class="g_table">
                        </table>
                </div>
            </td>
        </tr>
    </table></td>
  </tr>
 
</table>

</body>
</html>

