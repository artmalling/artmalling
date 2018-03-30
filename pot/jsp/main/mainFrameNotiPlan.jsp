<%
/*******************************************************************************
 * 시스템명 : 한국후지쯔 통합정보시스템_영업기획공지사항
 * 작 성 일 : 2010.12.12
 * 작 성 자 : FKL
 * 수 정 자 :
 * 파 일 명 : mainFrameNotiPlan.jsp
 * 버    전 : 1.0
 * 개    요 : 메인 화면
 * 이    력 : 
 ******************************************************************************/
%>
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty, java.util.List, java.util.Map, common.util.PagingHelper"   %>
   
<%@ taglib prefix="ajax" uri="/WEB-INF/tld/ajax-lib.tld"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"     prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"  prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"      prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"   prefix="button" %>

<ajax:library /> 
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정												*-->
<!--*************************************************************************--> 
<%
	String dir       		= BaseProperty.get("context.common.dir");
	String viewLevel 		= Util.getViewLevel(request); 

    //Paging처리
    Map  noticeMapTotCnt 	= (Map)  request.getAttribute("noticeTotCnt");  
    int plTotalCntAll 	 	= Integer.parseInt(noticeMapTotCnt.get("TOTAL_ALL").toString());   
    int plCurrPage 			= Integer.parseInt((String) request.getAttribute("plCurrPage").toString());	// 현재페이지    
	int plRowRange   		= Integer.parseInt(request.getAttribute("plRowRange").toString()) ; 		// 한페이지당 로우건수
    int plPageRange 		= 5;  // 페이지출력범위 
    
    // 게시판
	List tempList    		= null;
    List noticeListPlan 	= (List) request.getAttribute("noticePlan"); 

    String strNotiId = null;
    String strTitle  = null;
    String strWriter = null;
    String strRegDt  = null;
    String strNewYn  = null;
    String strNotiGbn= null; 
%>
<HTML> 
<HEAD> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"  type="text/javascript"></script>
</HEAD>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--

function viewNotice(notiId){
    var arrArg  = new Array(); 
    arrArg.push("READ");
    arrArg.push(notiId); 
    arrArg.push(window.self);  
   
    NoticeMainPop(notiId); 
}

function goPage(curr_page_all)
{
	this.location.href = "/pot/tcom001.tc?goTo=showNotiPlan&iCurrRow="+curr_page_all;
}
 
 
-->
</script>
</head> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" height="100%">  
<tr><td>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" height="100%">
    	<tr>
			<td width="30" bgcolor="#eeeeee" ></td>
			<td bgcolor="#eeeeee" height="2"></td>
			<td width="70" bgcolor="#eeeeee"></td>
			<td width="50" bgcolor="#eeeeee"></td>
		</tr>
<%     
     for(int i=0; i <  plRowRange; i++){ 
         if(i < noticeListPlan.size()) {
       	  tempList  = (List) noticeListPlan.get(i);
       	  strNotiId = tempList.get(0).toString();
       	  strTitle  = tempList.get(1).toString();
       	  strWriter = tempList.get(2).toString();
       	  strRegDt  = tempList.get(3).toString();
       	  strNotiGbn= tempList.get(4).toString();
       	  strNewYn	= tempList.get(5).toString();
%>
    	<tr>
    		<td class="news" ><%=strNotiGbn%></td> 
    		<td class="news" valing="absMiddle">
				<div style='cursor:hand; color:#58595B;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;
					height:20px;width:300px;padding-top:4px;
                     onMouseOver=this.style.backgroundColor=#efefef; 
                     onMouseOut=this.style.backgroundColor=''; 
                     onClick="viewNotice('<%=strNotiId%>')">
                     <% if(strNewYn.equals("Y")) %><img src="./imgs/icon/icon_new.gif" width="5" height="5">
		    		<nobr><%=strTitle%></nobr>
				</div>
			</td>
			<td class="news" ><%=strWriter%></td>
			<td class="news" ><%=strRegDt%></td>
		</tr> 
<% if(i != plRowRange-1) {%>
		<tr><td class="dot" height="1" colspan="4"></td></tr>
<%	} %> 

<%                
	} else {		
%>
		<tr>
	        <td class="news">&nbsp;</td>
	        <td class="news">&nbsp;</td>
	        <td class="news">&nbsp;</td>
	        <td class="news">&nbsp;</td>
		</tr>
<% if(i != plRowRange-1) {%>
		<tr><td class="nodot" height="1" colspan="4"></td></tr>
<%} %>
<% 
			} 
	}
%>
		<tr>
        	<td colspan=4 height="2" bgcolor="#eeeeee"></td>
        </tr>
		<tr><td colspan=4 height="5" ></td></tr>
        <tr valign="bottom">
        	<td colspan=4 align="center"> 
          		<%=  PagingHelper.instance.autoPaging(plTotalCntAll, plCurrPage, plRowRange, plPageRange)%>  
          	</td>
		</tr>
	</table>
</td></tr>
</table>  
