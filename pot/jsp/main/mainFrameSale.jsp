<%@page import="kr.fujitsu.ffw.util.Date2"%>
<%@page import="java.util.Date"%>
<%
/*******************************************************************************
 * 시스템명 : 한국후지쯔 통합정보시스템_매출속보
 * 작 성 일 : 2010.12.12
 * 작 성 자 : FKL
 * 수 정 자 :
 * 파 일 명 : mainFrameSale.jsp
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
    String today            = Date2.YYYYMMDDHHMMSS("");
    String today2           = Date2.YYYYMMDD("");
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
<!--* B. 스크립트 시작                                                      *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var nowDate     = '<%=today%>';
var strCd       = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';
var strUserId   = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
var varCompday  = addDate("d", -364, nowDate);
var top = 50;		//해당화면의 동적그리드top위치

function doInit(){
	alert("1");
	
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
	var tmpStr = TD_TIME_VIEW.innerText;
	var tmpTimeStr  = nowDate.substring(0,4)+"년 "+nowDate.substring(4,6)+"월 "+nowDate.substring(6,8)+"일 "+nowDate.substring(8,10)+":"+nowDate.substring(10,12);
	var tmpcompDate = varCompday.substring(0,4)+"년 "+varCompday.substring(5,7)+"월 "+varCompday.substring(8,10)+"일 "
	
	TD_TIME_VIEW.innerText = "현재 : " + tmpTimeStr + "  " + " 대비 일자 : " + tmpcompDate + tmpStr ;

    gridCreate();	
    
    searchSale();
}

function gridCreate(){
    var hdrProperies = '<C>id=ORG_NAME                                                        name="조직명"        width=200   align=left     BgColor={decode(ORG_LEVEL,4,"#FFFFE0",3,"#FFFACD",1,"#FFF7B1")}                   </C>'
                     + '<C>id=ORIGIN_SALE_TAMT        value={round(ORIGIN_SALE_TAMT/1000,0)}  name="매출목표"      width=70    align=right    BgColor={decode(ORG_LEVEL,4,"#FFFFE0",3,"#FFFACD",1,"#FFF7B1")} mask="###,###"     sumtext={sum(decode(ORG_LEVEL, 1, ORIGIN_SALE_TAMT, 0))/1000}</C>'//Truncate
                     + '<C>id=TOT_SALE_AMT            value={round(TOT_SALE_AMT/1000,0)}      name="총매출"        width=70    align=right    BgColor={decode(ORG_LEVEL,4,"#FFFFE0",3,"#FFFACD",1,"#FFF7B1")} mask="###,###"     sumtext={sum(decode(ORG_LEVEL, 1, TOT_SALE_AMT, 0))/1000}</C>'
                     + '<C>id=ACHIEVERATE                                                     name="달성률"        width=50    align=right    BgColor={decode(ORG_LEVEL,4,"#FFFFE0",3,"#FFFACD",1,"#FFF7B1")} mask="#,###.00"    sumtext={decode(sum(decode(ORG_LEVEL, 1, ORIGIN_SALE_TAMT, 0)), 0, 0, sum(decode(ORG_LEVEL, 1, TOT_SALE_AMT, 0))/sum(decode(ORG_LEVEL, 1, ORIGIN_SALE_TAMT, 0))*100)}</C>'
                     + '<C>id=TOT_SALE_AMT_CMPR       value={round(TOT_SALE_AMT_CMPR/1000,0)} name="대비실적"      width=70    align=right    BgColor={decode(ORG_LEVEL,4,"#FFFFE0",3,"#FFFACD",1,"#FFF7B1")} mask="###,###"     sumtext={sum(decode(ORG_LEVEL, 1, TOT_SALE_AMT_CMPR, 0))/1000}</C>'
                     + '<C>id=SALEIRATE                                                       name="신장률"        width=50    align=right    BgColor={decode(ORG_LEVEL,4,"#FFFFE0",3,"#FFFACD",1,"#FFF7B1")} mask="#,###.00"    sumtext={decode(sum(decode(ORG_LEVEL, 1, TOT_SALE_AMT_CMPR, 0)), 0, 0, sum(decode(ORG_LEVEL, 1, TOT_SALE_AMT - TOT_SALE_AMT_CMPR, 0))/sum(decode(ORG_LEVEL, 1, TOT_SALE_AMT_CMPR, 0))*100)}</C>'
                     + '<C>id=DC_AMT                  value={round(DC_AMT/1000,0)}            name="에누리"        width=70    align=right    BgColor={decode(ORG_LEVEL,4,"#FFFFE0",3,"#FFFACD",1,"#FFF7B1")} mask="###,###"     sumtext={sum(decode(ORG_LEVEL, 1, DC_AMT, 0))/1000}</C>'
                     + '<C>id=NET_SALE_AMT            value={round(NET_SALE_AMT/1000,0)}      name="순매출"        width=70    align=right    BgColor={decode(ORG_LEVEL,4,"#FFFFE0",3,"#FFFACD",1,"#FFF7B1")} mask="###,###"     sumtext={sum(decode(ORG_LEVEL, 1, NET_SALE_AMT, 0))/1000}</C>'
                     + '<C>id=SALE_PROF_AMT           value={round(SALE_PROF_AMT/1000,0)}     name="이익액"        width=70    align=right    BgColor={decode(ORG_LEVEL,4,"#FFFFE0",3,"#FFFACD",1,"#FFF7B1")} mask="###,###"     sumtext={sum(decode(ORG_LEVEL, 1, SALE_PROF_AMT, 0))/1000}</C>'
                     + '<C>id=PROFRATE                                                        name="이익율"        width=50    align=right    BgColor={decode(ORG_LEVEL,4,"#FFFFE0",3,"#FFFACD",1,"#FFF7B1")} mask="#,###.00"    sumtext={decode(sum(decode(ORG_LEVEL, 1, TOT_SALE_AMT, 0)), 0, 0, sum(decode(ORG_LEVEL, 1, SALE_PROF_AMT, 0))/sum(decode(ORG_LEVEL, 1, TOT_SALE_AMT, 0))*100)}</C>'
                     + '<C>id=CUST_CNT                                                        name="객수"          width=50    align=right    BgColor={decode(ORG_LEVEL,4,"#FFFFE0",3,"#FFFACD",1,"#FFF7B1")} mask="###,###"     sumtext={sum(decode(ORG_LEVEL, 1, CUST_CNT, 0))}</C>'
                     + '<C>id=CUST_DANGA              value={round(CUST_DANGA/1000,0)}        name="객단가"        width=70    align=right    BgColor={decode(ORG_LEVEL,4,"#FFFFE0",3,"#FFFACD",1,"#FFF7B1")} mask="###,###"     sumtext={decode(sum(decode(ORG_LEVEL, 1, CUST_CNT, 0)), 0, 0, sum(decode(ORG_LEVEL, 1, TOT_SALE_AMT, 0))/sum(decode(ORG_LEVEL, 1, CUST_CNT, 0))/1000)}</C>'
                     ;
	
	initGridStyle(GD_MASTER, "common", hdrProperies, false);
	GD_MASTER.DecRealData = true;
}



function searchSale(){

    var parameters = "&strStrCd="+strCd
                   + "&strDt="+nowDate.substring(0,8)
                   + "&strcmpDt="+varCompday.substring(0,4)+varCompday.substring(5,7)+varCompday.substring(8,10) ;    

    TR_MAIN.Action="/pot/tcom001.tc?goTo=searchSale2"+parameters; 
    TR_MAIN.KeyValue="SERVLET(O:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();

} 
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

 
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	
}
</script>

<body onload="doInit();" >
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
  <tr>
  	<td>
	    <table width="100%" border="0" cellpadding="0" cellspacing="0">
	    	<tr>
		      <td class="sub_title PB03 " ><img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle" /> 매출속보</td>
		      <!-- MARIO OUTLET -->
		      <td class="right">(단위 : 천원, 명)
		      <!-- MARIO OUTLET -->
		      </td>
	      	</tr>
	    </table>
    </td>
  </tr>
  <tr>
    <td  valign="top">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">      
        <tr>
          <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" >
              <tr>
                <td id=TD_TIME_VIEW ></td>     
              </tr>
            </table>
          </td>
          <td  class="right">
          <img src="/pot/imgs/btn/search.gif" border="0" id="btnSearch" onClick="searchSale();">
          </td>
        </tr>
      </table>
    </td>
    
  </tr>
  
  <tr>
    <td valign="top" colspan="2">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">      
        <tr>
          <td valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
              <tr>
                <td>
                  <comment id="_NSID_">
                    <object id=GD_MASTER width=100% height=100% classid=<%=Util.CLSID_GRID%>>
                      <param name="DataID" value="DS_MASTER">
                    </object>
                  </comment>
                  <script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
