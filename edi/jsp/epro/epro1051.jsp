<!-- 
/*******************************************************************************
 * 시스템명 :  경영지원 > EDI 협력사 > 약속관리 > 약속분석상세 POPUP 
 * 작 성 일 : 2011.06.18
 * 작 성 자 : 오형규
 * 수 정 자 : 
 * 파 일 명 : epro105.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 : 2011.01.14 (오형규) 신규작성
           
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"
 import="kr.fujitsu.ffw.base.BaseProperty,kr.fujitsu.ffw.util.String2,kr.fujitsu.ffw.control.ActionForm" %>
<%@ page import="ecom.util.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="ecom.vo.SessionInfo2"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>

<%
    String dir = request.getContextPath();    
 
%>

<html>
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링</title>
<link href="/edi/css/ds.css" rel="stylesheet" type="text/css" />
<script language="javascript"  src="<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/popup.js"  type="text/javascript"></script>

<script language="javascript">
var strcd  = dialogArguments[0];        //점코드
var vencd  = dialogArguments[1];        //협력사코드
var pumbuncd  = dialogArguments[2];     //브랜드코드
var date   = dialogArguments[3];        //일자
var g_pre_row = -1;                             //
var g_last_row = -1;

var strMst = "";

function doinit(){
	document.getElementById("date").value = getDateFormat(date);
	
	  
    // 2011.07.15 kjm 추가
    // 조회버튼 클릭시 하단그리드도 같이 조회
   //   chBak(0);
   // alert(strMst[0].STR_CD);
   //   getDetail(strMst[0].STR_CD, strMst[0].TAKE_DT, strMst[0].TAKE_SEQ);
   document.getElementById("trEnt0").onclick();
}

/**
 * btn_close()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  약속분석상세 POPUP 창 닫기
 * return값 : void
 */
function btn_close(){
    window.close();
}

function getDetail(strcd, take_dt, takeSeq){
    
    var param = "&goTo=getPromissDetail" + "&strcd=" + strcd
    + "&take_dt=" + take_dt
    + "&takeSeq=" + takeSeq;
    
    var Urleren = "/edi/epro105.ep"; 
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
             
              
              document.getElementById("STR_CD").value = strMst[0].STR_CD;
              document.getElementById("STRNM").value = strMst[0].STR_NM;
              document.getElementById("TAKEDT").value = getDateFormat(strMst[0].TAKE_DT);
              document.getElementById("TAKESEQ").value = strMst[0].TAKE_SEQ;
              document.getElementById("TAKEUSERNM").value = strMst[0].TAKE_USER_NM;
              document.getElementById("PUMBUNCD").value = strMst[0].PUMBUN_CD;
              document.getElementById("PUMBUNNM").value = strMst[0].PUMBUN_NM;
              document.getElementById("ORD_CD").value = strMst[0].ORG_CD;
              document.getElementById("ORD_NM").value = strMst[0].ORG_NM;
              document.getElementById("CUST_NM").value = strMst[0].CUST_NM;
              
              if( strMst[0].SMS_YN == "Y" ){
            	  document.getElementById("CHK_SMS_YN").checked = true;            
              } else {
            	  document.getElementById("CHK_SMS_YN").checked = false;
              }
              
              document.getElementById("POST_NO").value = convertZip(strMst[0].POST_NO);
              document.getElementById("ADDR").value = strMst[0].ADDR;
              document.getElementById("DETLADDR").value = strMst[0].DTL_ADDR;
              document.getElementById("MOBILE_PH1").value = strMst[0].MOBILE_PH1;
              document.getElementById("MOBILE_PH2").value = strMst[0].MOBILE_PH2;
              document.getElementById("MOBILE_PH3").value = strMst[0].MOBILE_PH3;
              document.getElementById("HOME_PH1").value = strMst[0].HOME_PH1;
              document.getElementById("HOME_PH2").value = strMst[0].HOME_PH2;
              document.getElementById("HOME_PH3").value = strMst[0].HOME_PH3;
              document.getElementById("FRST_PROM_DT").value = getDateFormat(strMst[0].FRST_PROM_DT);
              document.getElementById("FRST_HH").value = strMst[0].FRST_PROM_HH;
              document.getElementById("FRST_MM").value = strMst[0].FRST_PROM_MM;
              document.getElementById("PROM_TYPE").value = strMst[0].PROM_TYPE;
              document.getElementById("DELI_TYPE").value = strMst[0].DELI_TYPE;
              document.getElementById("MOD_PROM_DT").value = getDateFormat(strMst[0].LAST_PROM_DT);
              document.getElementById("MOD_PROM_HH").value = strMst[0].LAST_PROM_HH;
              document.getElementById("MOD_PROM_MM").value = strMst[0].LAST_PROM_MM;
              
              document.getElementById("DELI_STR").value = strMst[0].DELI_STR;
              document.getElementById("DELI_STRNM").value = strMst[0].LAST_PROM_MM;
              document.getElementById("IN_DELI_DT").value = getDateFormat(strMst[0].IN_DELI_DT);
              document.getElementById("SKU_NM").value = strMst[0].SKU_NM;
              document.getElementById("TXT_PROM_DTL").value = strMst[0].PROM_DTL;
              document.getElementById("COUR_CUST_NM").value = strMst[0].COUR_CUST_NM;
              document.getElementById("COUR_POST_NO").value = convertZip(strMst[0].COUR_POST_NO);
              document.getElementById("COUR_ADDR").value = strMst[0].COUR_ADDR;
              document.getElementById("COUR_DTL_ADDR").value = strMst[0].COUR_DTL_ADDR;
              document.getElementById("COUR_MOBILE_PH1").value = strMst[0].COUR_MOBILE_PH1;
              document.getElementById("COUR_MOBILE_PH2").value = strMst[0].COUR_MOBILE_PH2;
              document.getElementById("COUR_MOBILE_PH3").value = strMst[0].COUR_MOBILE_PH3;
              document.getElementById("COUR_HOME_PH1").value = strMst[0].COUR_HOME_PH1;
              document.getElementById("COUR_HOME_PH2").value = strMst[0].COUR_HOME_PH2;
              document.getElementById("COUR_HOME_PH3").value = strMst[0].COUR_HOME_PH3;
              document.getElementById("COUR_COMP_NM").value = strMst[0].COUR_COMP_NM;
              document.getElementById("COUR_SEND_NO").value = strMst[0].COUR_SEND_NO;
              
              if( strMst[0].PROC_STAT == "1"  ){
            	document.getElementsByName("RD_PROC_STAT")[0].checked = true;   
              } else if(strMst[0].PROC_STAT == "2"){
            	  document.getElementsByName("RD_PROC_STAT")[1].checked = true;  
              }else if(strMst[0].PROC_STAT == "3"){
            	  document.getElementsByName("RD_PROC_STAT")[2].checked = true;
              }else if(strMst[0].PROC_STAT == "4"){
            	  document.getElementsByName("RD_PROC_STAT")[3].checked = true;
              }
              
              if( Number(strMst[0].HAPPY_CALL_YN) > 0 ){
            	  document.getElementById("CHK_HAPPY_CALL_YN").checked = true;  
              } else {
            	  document.getElementById("CHK_HAPPY_CALL_YN").checked = false;
              } 
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
 * scrollAll()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  그리드 테이블이 div 크기 보다 클 경우 스크롤 작동 
 * return값 : void
 */
function scrollAll(){
    document.all.LIST_TITLE.scrollLeft = document.all.LIST_CONTETN.scrollLeft;
}
/**
 * chBak()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  그리드에서 포커스 컨트롤 (색상변경)
 * return값 : void
 */
function chBak(val) {
	
	g_last_row = val;
	
    if (g_pre_row != g_last_row){
        for(i=1;i<7;i++) {
            document.getElementById(i+"tdId"+val).style.backgroundColor="#fff56E";
    
            if (g_pre_row != -1) {
                document.getElementById(i+"tdId"+g_pre_row).style.backgroundColor="#ffffff";
            }
        }
    }
    g_pre_row = g_last_row;
}

 
</script>

</head>
<body onload="doinit();">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="pop01"></td>
        <td class="pop02" ></td>
        <td class="pop03" ></td>
    </tr>
    <tr>
        <td class="pop04"></td>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="title">
                                <img src="/edi/imgs/comm/title_head.gif" width="15" height="13"  align="absmiddle" class="popR05 PL03" /> 
                                <span id="title1" class="PL03">약속분석상세 POPUP</span>
                            </td>
                            <td>
                                <table border="0" align="right" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td><img src="/edi/imgs/btn/close.gif" width="50" height="22" onclick="javascript:btn_close();" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                         <tr>
                            <td height="6"></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                                    <tr valign="top">
                                        <td class="PB03" width="260">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0" >
                                                <tr>
                                                    <td width="260" class="PB03 PT10">
                                                        <table border="0" cellspacing="0" cellpadding="0" class="s_table">
                                                            <tr>
                                                                <th width="90">선택일자</th>
                                                                <td width="170">
                                                                    <input type="text" name="date" id="" size="date" style="width: 100%" disabled="disabled"/>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                     <td class="dot"></td>
                                                </tr>
                                                    <tr>
                                                        <td class="sub_title"><img src="<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 약속목록</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="PB03 PT05">
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
                                                                <tr >
                                                                    <td>
                                                                        <div id="LIST_TITLE" style=" width:260px; overflow:hidden;"> 
                                                                            <table width="445" border="0" cellspacing="0" cellpadding="0" class="g_table" >
                                                                                <tr>
                                                                                    <th width="35">NO</th>
                                                                                    <th width="95">점</th>
                                                                                    <th width="85">접수일자</th>
                                                                                    <th width="55">SEQ</th>
                                                                                    <th width="55">고객명</th>
                                                                                    <th width="70">약속유형</th>
                                                                                    <th width="15">&nbsp;</th>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <div id="LIST_CONTETN" style="width:260px;height:559px;overflow:scroll" onscroll="scrollAll();">
                                                                            <table width="425" border="0" cellspacing="0" cellpadding="0" class="g_table" id="tb_master">
                                                                                  <c:if test="${ !empty PROMISSLISTPOPUP }">
                                                                                      <c:forEach items="${PROMISSLISTPOPUP}" var="it" varStatus="inx">
                                                                                      <fmt:parseDate value="${it.TAKE_DT}" var="teke_dt" pattern="yyyymmdd" />
                                                                                          <tr id='trEnt${inx.index}' onclick="chBak('${inx.index}');getDetail('${it.STR_CD}', '${it.TAKE_DT}', '${it.TAKE_SEQ}');" style='cursor:hand;'>
                                                                                              <td width="35" class="r1" id='1tdId${inx.index}'>${inx.index + 1 }</td>
                                                                                              <td width="95" class="r3" id='2tdId${inx.index}'>${it.STR_NM }</td>
                                                                                              <td width="85" class="r1" id='3tdId${inx.index}'><fmt:formatDate value="${teke_dt}" pattern="yyyy/mm/dd"  /> </td>
                                                                                              <td width="55" class="r1" id='4tdId${inx.index}'>${it.TAKE_SEQ }</td>
                                                                                              <td width="55" class="r3" id='5tdId${inx.index}'>${it.CUST_NM }</td>
                                                                                              
                                                                                              <c:choose>
                                                                                                  <c:when test="${it.PROM_TYPE == '01' }">
                                                                                                      <td width="70" class="r1" id='6tdId${inx.index}'>수선</td>
                                                                                                  </c:when>
                                                                                                  <c:when test="${it.PROM_TYPE == '02' }">
                                                                                                      <td width="70" class="r1" id='6tdId${inx.index}'>주문</td>
                                                                                                  </c:when>
                                                                                                  <c:when test="${it.PROM_TYPE == '03' }">
                                                                                                      <td width="70" class="r1" id='6tdId${inx.index}'>배송</td>
                                                                                                  </c:when>
                                                                                                  <c:when test="${it.PROM_TYPE == '04' }">
                                                                                                      <td width="70" class="r1" id='6tdId${inx.index}'>기타</td>
                                                                                                  </c:when>
                                                                                              </c:choose>  
                                                                                          </tr>
                                                                                      </c:forEach>
                                                                                  </c:if>
                                                                            </table>
                                                                        </div>
                                                                    </td>
                                                                </tr>   
                                                            </table>
                                                        </td>
                                                    </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                 <tr>
                                                    <td class="sub_title">&nbsp;<img src="<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>기본사항</td>
                                                </tr>
                                                <tr valign="top">
                                                    <td class="PL05">
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td>
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
                                                                        <tr>
                                                                            <th width="80">점</th>
                                                                            <td width="170">
                                                                                <input type="text" id="STR_CD" name="STR_CD" size="6" style="text-align: left;" disabled="disabled" />
                                                                                <input type="text" id="STRNM" name="STRNM" size="17" style="text-align: left;" disabled="disabled" />
                                                                            </td>
                                                                            <th width="80">접수일자</th>
                                                                            <td>
                                                                                <input type="text" id="TAKEDT" name="TAKEDT" style="width:100%;text-align: center;" disabled="disabled"/>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <th>접수순번</th>
                                                                            <td>
                                                                                <input type="text" id="TAKESEQ" name="TAKESEQ" style="width:166;text-align: left;" disabled="disabled" />
                                                                            </td>
                                                                            <th>접수자</th>
                                                                            <td>
                                                                                <input type="text" id="TAKEUSERNM" name="TAKEUSERNM" style="width:166;text-align: left;" disabled="disabled" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <th>브랜드</th>
                                                                            <td colspan="3">
                                                                                <input type="text" id="PUMBUNCD" name="PUMBUNCD" style="width:165;text-align: left;" disabled="disabled" />
                                                                                <input type="text" id="PUMBUNNM" name="PUMBUNNM" style="width:268;text-align: left;" disabled="disabled" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <th>조직코드</th>
                                                                            <td colspan="3">
                                                                                <input type="text" id="ORD_CD" name="ORD_CD" style="width:165;text-align: left;" disabled="disabled" />
                                                                                <input type="text" id="ORD_NM" name="ORD_NM" style="width:268;text-align: left;" disabled="disabled" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr height=20>
                                                                 <td class="sub_title">&nbsp;<img src="<%=dir%>/imgs/comm/ring_blue.gif" id="custimpo" class="PR03" align="absmiddle"/>고객정보</td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                   <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                       <tr>
                                                                            <td>
                                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
			                                                                        <tr>
			                                                                            <th width="80">고객명</th>
			                                                                            <td width="170">
			                                                                                <input type="text" id="CUST_NM" name="CUST_NM" style="width:165;text-align: left;" disabled="disabled" />
			                                                                            </td>
			                                                                            <th width="80">SMS수신여부 </th>
			                                                                            <td>
			                                                                                <input id="CHK_SMS_YN" name="CHK_SMS_YN" type="checkbox" disabled="false" />
			                                                                            </td>
			                                                                        </tr>
			                                                                        <tr>
			                                                                            <th>우편번호</th>
			                                                                            <td colspan="3">
			                                                                                <input type="text" id="POST_NO" name="POST_NO"  style="width:166;text-align: center;" disabled="false" />
			                                                                            </td>
			                                                                        </tr>
			                                                                         <tr>
			                                                                            <th>주소</th>
			                                                                            <td colspan="3">
			                                                                                <input type="text" id="ADDR" name="ADDR"  style="width:100%;text-align: left;" disabled="false" />
			                                                                            </td>
			                                                                        </tr>
			                                                                        <tr>
                                                                                        <th>상세주소</th>
                                                                                        <td colspan="3">
                                                                                            <input type="text" id="DETLADDR" name="DETLADDR"  style="width:100%;text-align: left;" disabled="false" />
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <th>휴대폰번호</th>
                                                                                        <td>
                                                                                            <input type="text" name="MOBILE_PH1" id="MOBILE_PH1" style="width:40;text-align: center;" disabled="disabled" />-
                                                                                            <input type="text" name="MOBILE_PH2" id="MOBILE_PH2" style="width:55;text-align: center;" disabled="disabled" />-
                                                                                            <input type="text" name="MOBILE_PH3" id="MOBILE_PH3" style="width:55;text-align: center;" disabled="disabled" />
                                                                                        </td>
                                                                                        <th>전화번호</th>
                                                                                        <td>
                                                                                            <input type="text" name="HOME_PH1" id="HOME_PH1" style="width:40;text-align: center;" disabled="disabled" />-
                                                                                            <input type="text" name="HOME_PH2" id="HOME_PH2" style="width:55;text-align: center;" disabled="disabled" />-
                                                                                            <input type="text" name="HOME_PH3" id="HOME_PH3" style="width:55;text-align: center;" disabled="disabled" />
                                                                                        </td>
                                                                                    </tr>
			                                                                    </table>
                                                                            </td>
                                                                       </tr>
                                                                   </table>
                                                                </td>
                                                            </tr>
                                                            <tr height=20>
										                        <td>
										                            <table width="100%">
											                              <tr>
											                                <td class="sub_title">&nbsp;<img src="<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle" />약속내역
											                                </td>                                
											                              </tr>
										                              </table>
										                        </td>
										                    </tr>
										                    <tr>
                                                                <td>
                                                                   <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td>
                                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
                                                                                    <tr>
                                                                                        <th width="80">최초약속일</th>
                                                                                        <td colspan="3">
                                                                                            <input type="text" id="FRST_PROM_DT" name="FRST_PROM_DT" style="width:165;text-align: center;" disabled="disabled" />
                                                                                            <input type="text" id="FRST_HH" name="FRST_HH" style="width:60;text-align: center;" disabled="disabled" />시
                                                                                            <input type="text" id="FRST_MM" name="FRST_MM" style="width:60;text-align: center;" disabled="disabled" />분
                                                                                        </td>
                                                                                    </tr>
                                                                                     <tr>
														                                <th width="80">약속유형</th>
														                                <td width="170">
                                                                                            <select id="PROM_TYPE" name="PROM_TYPE" style="width:160;" disabled="disabled">
                                                                                                <option value=""></option>
                                                                                                <option value="01">수선</option>
                                                                                                <option value="02">주문</option>
                                                                                                <option value="03">배송</option>
                                                                                                <option value="04">기타</option>
                                                                                            </select>
														                                </td>
														                                <th width="80">인도방식</th>
														                                <td>
                                                                                            <select id="DELI_TYPE" name="DELI_TYPE" style="width:160;" disabled="disabled">
                                                                                                <option value=""></option>
                                                                                                <option value="01">고객내방</option>
                                                                                                <option value="02">택배수령</option>
                                                                                            </select>
                                                                                        </td>
                                                                                     </tr>
                                                                                     <tr>
                                                                                        <th width="80">변경약속일</th>
                                                                                        <td colspan="3">
                                                                                            <input type="text" id="MOD_PROM_DT" name="FRST_PROM_DT" style="width:165;text-align: center;" disabled="disabled" />
                                                                                            <input type="text" id="MOD_PROM_HH" name="MOD_PROM_HH" style="width:60;text-align: center;" disabled="disabled" />시
                                                                                            <input type="text" id="MOD_PROM_MM" name="MOD_PROM_MM" style="width:60;text-align: center;" disabled="disabled" />분
                                                                                        </td>
                                                                                     </tr>
                                                                                     <tr>
                                                                                        <th>인도점</th>
                                                                                        <td width="170">
                                                                                            <input type="text" id="DELI_STR" name="DELI_STR" style="width:60;text-align: left;" disabled="disabled" />
                                                                                            <input type="text" id="DELI_STRNM" name="DELI_STRNM" style="width:100;text-align: left;" disabled="disabled" />
                                                                                        </td>
                                                                                        <th >입고예정일</th>
				                                                                            <td>
				                                                                                <input type="text" id="IN_DELI_DT" name="IN_DELI_DT" style="width:100%;text-align: center;" disabled="disabled"/>
				                                                                            </td>
                                                                                     </tr>
                                                                                     <tr>
                                                                                        <th>상품명</th>
                                                                                        <td colspan="3">
                                                                                            <input type="text" id="SKU_NM" name="SKU_NM"  style="width:100%;text-align: left;" disabled="false" />
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <th>약속내역</th>
                                                                                        <td colspan="3">
                                                                                            <textarea name="TXT_PROM_DTL" id="TXT_PROM_DTL" style="width:100%;height:50;" readonly="readonly" class="input_pk" ></textarea>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                   </table>
                                                                </td>
                                                            </tr>
                                                            <tr height=20>
										                        <td class="sub_title">&nbsp;<img src="<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>배송정보&nbsp;&nbsp;</td>
										                    </tr>
                                                            <tr>
                                                                <td>
                                                                   <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                       <tr>
                                                                            <td>
                                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
                                                                                    <tr>
														                                <th width="80">고객명</th>
														                                <td width="170">
														                                    <input type="text" id="COUR_CUST_NM" name="COUR_CUST_NM" style="width:165;text-align: left;" disabled="disabled" />
														                                </td>
														                                <th width="80">우편번호</th>
                                                                                         <td>
                                                                                            <input type="text" id="COUR_POST_NO" name="COUR_POST_NO" style="width:166;text-align: center;" disabled="disabled" />
                                                                                         </td>
                                                                                     </tr>
                                                                                     <tr>
                                                                                        <th>주소</th>
                                                                                        <td colspan="3">
                                                                                            <input type="text" id="COUR_ADDR" name="COUR_ADDR"  style="width:100%;text-align: left;" disabled="false" />
                                                                                        </td>
                                                                                    </tr>
                                                                                   <tr>
                                                                                        <th>상세주소</th>
                                                                                        <td colspan="3">
                                                                                            <input type="text" id="COUR_DTL_ADDR" name="COUR_DTL_ADDR"  style="width:100%;text-align: left;" disabled="false" />
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <th>휴대폰번호</th>
                                                                                        <td>
                                                                                            <input type="text" name="COUR_MOBILE_PH1" id="COUR_MOBILE_PH1" style="width:40;text-align: center;" disabled="disabled" />-
                                                                                            <input type="text" name="COUR_MOBILE_PH2" id="COUR_MOBILE_PH2" style="width:55;text-align: center;" disabled="disabled" />-
                                                                                            <input type="text" name="COUR_MOBILE_PH3" id="COUR_MOBILE_PH3" style="width:55;text-align: center;" disabled="disabled" />
                                                                                        </td>
                                                                                        <th>전화번호</th>
                                                                                        <td>
                                                                                            <input type="text" name="COUR_HOME_PH1" id="COUR_HOME_PH1" style="width:40;text-align: center;" disabled="disabled" />-
                                                                                            <input type="text" name="COUR_HOME_PH2" id="COUR_HOME_PH2" style="width:55;text-align: center;" disabled="disabled" />-
                                                                                            <input type="text" name="COUR_HOME_PH3" id="COUR_HOME_PH3" style="width:55;text-align: center;" disabled="disabled" />
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <th>택배회사</th>
                                                                                        <td>
                                                                                            <input type="text" id="COUR_COMP_NM" name="COUR_COMP_NM" style="width:165;text-align: left;" disabled="disabled" />
                                                                                        </td>
                                                                                        <th width="80">운송장번호</th>
                                                                                         <td>
                                                                                            <input type="text" id="COUR_SEND_NO" name="COUR_SEND_NO" style="width:166;text-align: left;" disabled="disabled" />
                                                                                         </td>
                                                                                     </tr>
                                                                                </table>
                                                                            </td>
                                                                       </tr>
                                                                   </table>
                                                                </td>
                                                            </tr>
                                                            <tr height=20>
										                        <td class="sub_title">&nbsp;<img src="<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>진행상태</td>
										                    </tr>
										                    <tr>
                                                                <td>
                                                                   <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                       <tr>
                                                                            <td>
                                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
                                                                                    <tr>
                                                                                        <th>
                                                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="RD_PROC_STAT" id="RD_PROC_STAT" value="1" disabled="disabled" />접수&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                                            <input type="radio" name="RD_PROC_STAT" id="RD_PROC_STAT" value="2" disabled="disabled" />입고/수선완료&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                                            <input type="radio" name="RD_PROC_STAT" id="RD_PROC_STAT" value="3" disabled="disabled" />인도완료&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                                            <input type="radio" name="RD_PROC_STAT" id="RD_PROC_STAT" value="4" disabled="disabled" />취소완료  
                                                                                        </th>
                                                                                        <th>
													                                        <input id=CHK_HAPPY_CALL_YN name="CONTENTS" type="checkbox" disabled="false" /> 해피콜 완료
													                                    </th>
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
                                            </table>
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
        
        <td class="pop06" ></td>        
    </tr>
    <tr>
        <td class="pop07" ></td>
        <td class="pop08" ></td>
        <td class="pop09" ></td>
    </tr>
</table>
</body>
</html>
