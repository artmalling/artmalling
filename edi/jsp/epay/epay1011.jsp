<!-- 
/*******************************************************************************
 * 시스템명 :  경영지원 > EDI 협력사 > 대금지불 > 대금지불정보내역조회POPUP
 * 작 성 일 : 2011.04.14
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : ecmn1021.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 : 2011.01.14 (김슬기) 신규작성
           
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
<script language="javascript"  src="/edi/js/common.js"  type="text/javascript"></script>
<script language="javascript"  src="/edi/js/PopupCalendar.js"  type="text/javascript"></script>

<script type="text/javascript">
function btn_close(){
	window.close();
}

function scrollAll1(){
	document.all.divtitle.scrollLeft = document.all.divContent.scrollLeft;
}
function scrollAll2(){
    document.all.divTitlep.scrollLeft = document.all.divContentp.scrollLeft;
}
function scrollAll3(){
	document.all.divTitleK.scrollLeft = document.all.divContentK.scrollLeft;
}
</script>


</head>

<body >
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
                                <span id="title1" class="PL03">대금지불정보내역조회</span>
                            </td>
                            <td>
                                <table border="0" align="right" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td><img src="/edi/imgs/btn/close.gif" width="50" height="22" onclick="javascript:btn_close();" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="6"></td>
            </tr>            
            <tr>
                <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                        <tr>
                            <td class="sub_title "><img src="<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>선급내역</td>
                            <td class="sub_title PL10"><img src="<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>보류내역</td>
                        </tr>
                        <tr>
                            <td>
                                 <table width="425px"  border="0" cellspacing="0" cellpadding="0" class="BD4A">
                                    <tr valign="top">
                                        <td>
                                            <div id="divtitle" style="width:425px;overflow:hidden;">
                                                <table width="530" cellpadding="0" cellspacing="0" border="0" class="g_table" >
                                                    <tr>
                                                        <th width="35">NO</th>
                                                        <th width="85">지불일자</th>
                                                        <th width="55">순번</th>
                                                        <th width="95">선급금코드</th>
                                                        <th width="95">입금금액</th>
                                                        <th width="115">비고</th>
                                                        <th width="15">&nbsp;</th>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="divContent" style="width:425px;height:180px;overflow:scroll" onscroll="scrollAll1();">
							                  <table width="510" cellspacing="0" cellpadding="0" border="0" class="g_table">
							                     <c:if test="${!empty list}">
                                                        <c:set var="inputAmtSum" value="0" />
                                                        <c:forEach items="${list}" var="it" varStatus="inx">
                                                            <tr>
                                                                <td width="35" class="r1">${inx.index + 1}</td>
			                                                    <td width="85" class="r1">${it.INPUT_DT }</td>
			                                                    <td width="55" class="r1">${it.SEQ_NO }</td>
			                                                    <c:choose>
	                                                              <c:when test="${fn:length(it.REASON_NM) > 7 }">
	                                                                  <td width="95" class="r3" title="${it.REASON_NM }" style="cursor:hand">${fn:substring(it.REASON_NM, 0, 7)}..</td>
	                                                              </c:when>
	                                                              <c:otherwise>
	                                                                  <td width="95" class="r3">${it.REASON_NM}</td>
	                                                              </c:otherwise>
	                                                            </c:choose>   
			                                                    <td width="95" class="r4">${it.INPUT_AMT }</td>
			                                                    <c:choose>
			                                                         <c:when test="${fn:length(it.REMARK) > 9 }">
			                                                             <td width="115" class="r3" title="${it.REMARK}" style="cursor:hand">${fn:substring(it.REMARK, 0, 9)}..</td>
			                                                         </c:when>
			                                                         <c:otherwise>
			                                                             <td width="115" class="r3">${it.REMARK }</td>
			                                                         </c:otherwise>
			                                                    </c:choose>
			                                                    
                                                            </tr>
                                                            <c:set var="inputAmtSum" value="${inputAmtSum + it.INPUTAMTSUM }" />
                                                        </c:forEach>
                                                            <tr>
                                                                <td class="sum1">&nbsp;</td>
                                                                <td class="sum1">합 계</td>
                                                                <td class="sum2" >&nbsp;</td>
                                                                <td class="sum2" >&nbsp;</td>
                                                                <td class="sum2" ><fmt:formatNumber value="${inputAmtSum}" type="number" /></td>
                                                                <td class="sum2" >&nbsp;</td>
                                                            </tr>    
                                                  </c:if>
							                  </table>  
							              </div>
                                        </td>
                                    </tr>
                                 </table>
                            </td>
                            <td class="PL10">
                                <table width="425px"  border="0" cellspacing="0" cellpadding="0" class="BD4A">
                                    <tr>
                                        <td>
                                            <div id="divTitlep" style="width:425px;overflow:hidden;">
                                                <table width="530" cellpadding="0" cellspacing="0" border="0" class="g_table" >
                                                    <tr>
                                                        <tr>
	                                                        <th width="35">NO</th>
	                                                        <th width="85">지불일자</th>
	                                                        <th width="55">순번</th>
	                                                        <th width="95">보류코드</th>
	                                                        <th width="95">입금금액</th>
	                                                        <th width="115">비고</th>
	                                                        <th width="15">&nbsp;</th>
                                                        </tr>
                                                    </tr>
                                                    
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="divContentp" style="width:425px;height:180px;overflow:scroll" onscroll="scrollAll2();">
                                              <table width="510" cellspacing="0" cellpadding="0" border="0" class="g_table">
                                                <c:if test="${!empty list2 }">
                                                    <c:set var="inputAmtSum" value="0" />
                                                    <c:forEach items="${list2 }" var="it"  varStatus="inx" >
                                                        <tr>
                                                            <td width="35" class="r1">${inx.index + 1}</td>
		                                                    <td width="85" class="r1">${it.INPUT_DT}</td>
		                                                    <td width="55" class="r1">${it.SEQ_NO}</td>
		                                                     <c:choose>
		                                                      <c:when test="${fn:length(it.REASON_NM) > 7 }">
		                                                          <td width="95" class="r3" title="${it.REASON_NM }" style="cursor:hand">${fn:substring(it.REASON_NM, 0, 7)}..</td>
		                                                      </c:when>
		                                                      <c:otherwise>
		                                                          <td width="95" class="r3">${it.REASON_NM}</td>
		                                                      </c:otherwise>
		                                                    </c:choose>
		                                                    <td width="95" class="r4"><fmt:formatNumber value="${it.INPUT_AMT}" type="number" /></td>
		                                                    <c:choose>
		                                                      <c:when test="${fn:length(it.REMARK) > 9 }">
									                              <td width="115" class="r3" title="${it.REMARK}" style="cursor:hand">${fn:substring(it.REMARK, 0, 9)} ..</td>
									                          </c:when>
									                          <c:otherwise>
								                                 <td width="115" class="r3">${it.REMARK}</td>
								                               </c:otherwise>
		                                                    </c:choose>
                                                        </tr>
                                                         <c:set var="inputAmtSum" value="${inputAmtSum + it.INPUT_AMT }" />
                                                    </c:forEach>
                                                        <tr>
                                                            <td class="sum1">&nbsp;</td>
                                                            <td class="sum1">합 계</td>
                                                            <td class="sum2" >&nbsp;</td>
                                                            <td class="sum2" >&nbsp;</td>
                                                            <td class="sum2" ><fmt:formatNumber value="${inputAmtSum}" type="number" /></td>
                                                            <td class="sum2" >&nbsp;</td>
                                                        </tr>  
                                                </c:if>
                                              </table>  
                                          </div>
                                        </td>
                                    </tr>
                                 </table>
                            </td>
                        </tr>
                        <tr class="PT10">                        
                            <td colspan="2" >
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                                    <tr>
                                        <td class="sub_title"><img src="<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>공제내역</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table width="100%"  border="0" cellspacing="0" cellpadding="0" class="BD4A">
			                                    <tr>
			                                        <td>
			                                            <div id="divTitleK" style="width:865px;overflow:hidden;">
			                                                <table width="865" cellpadding="0" cellspacing="0" border="0" class="g_table" >
			                                                    <tr>
			                                                        <th width="35">NO</th>
			                                                        <th width="95">일자</th>
			                                                        <th width="55">순번</th>
			                                                        <th width="190">공제코드</th>
			                                                        <th width="95">공제금액</th>
			                                                        <th width="95">VAT여부</th>
			                                                        <th width="95">현금입금여부</th>
			                                                        <th width="95">공제등록구분</th>
			                                                        <th width="145">비고</th>
			                                                        <th width="15">&nbsp;</th>
			                                                    </tr>
			                                                </table>
			                                            </div>
			                                        </td>
			                                    </tr>
			                                    <tr>
			                                        <td>
			                                            <div id="divContentK" style="width:865px;height:190px;overflow:scroll" onscroll="scrollAll3();">
			                                              <table width="845" cellspacing="0" cellpadding="0" border="0" class="g_table">
			                                                 <c:if test="${!empty list3 }">
			                                                     <c:set var="inputAmtSum" value="0" />
			                                                     <c:forEach items="${list3 }" var="it" varStatus="inx" >
			                                                         <tr>
			                                                             <td width="37" class="r1">${inx.index + 1 }</td>
		                                                                 <td width="88" class="r1">${it.INPUT_DT }</td>
		                                                                 <td width="55" class="r1">${it.SEQ_NO }</td>
		                                                                 <c:choose>
			                                                              <c:when test="${fn:length(it.REASON_NM) > 17 }">
			                                                                  <td width="191" class="r3" title="${it.REASON_NM }" style="cursor:hand">${fn:substring(it.REASON_NM, 0, 17)}..</td>
			                                                              </c:when>
			                                                              <c:otherwise>
			                                                                  <td width="191" class="r3">${it.REASON_NM}</td>
			                                                              </c:otherwise>
			                                                            </c:choose>             
		                                                                 <td width="90" class="r4"><fmt:formatNumber value="${it.INPUT_AMT }" type="number" /></td>
		                                                                 <td width="95" class="r1">${it.VAT_YN }</td>
		                                                                 <td width="95" class="r3">${it.CASH_IN_YN }</td>
		                                                                 <td width="95" class="r3">${it.DED_REG_FLAG }</td>
		                                                                 <c:choose>
			                                                              <c:when test="${fn:length(it.REMARK) > 13 }">
			                                                                  <td width="145" class="r3" title="${it.REMARK}" style="cursor:hand">${fn:substring(it.REMARK, 0, 13)}..</td>
			                                                              </c:when>
			                                                              <c:otherwise>
			                                                                 <td width="145" class="r3">${it.REMARK}</td>

			                                                               </c:otherwise>
			                                                            </c:choose>
			                                                            <c:set  var="inputAmtSum" value="${inputAmtSum +it.INPUT_AMT}" />
			                                                         </tr>
			                                                     </c:forEach>
			                                                         <tr>
			                                                             <td class="sum1">&nbsp;</td>
			                                                             <td class="sum1">합 계</td>
			                                                             <td class="sum2">&nbsp;</td>
			                                                             <td class="sum2">&nbsp;</td>
			                                                             <td class="sum2"><fmt:formatNumber value="${inputAmtSum }" type="number" /></td>
			                                                             <td class="sum2">&nbsp;</td>
			                                                             <td class="sum2">&nbsp;</td>
			                                                             <td class="sum2">&nbsp;</td>
			                                                         </tr>
			                                                         
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
