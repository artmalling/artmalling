<!-- 
 * 시스템명 : 포인트카드 > 포인트정산 > 포인트일정산 > 일변 POS 마감조회
 * 작  성  일  : 2010.03.25
 * 작  성  자  : 장형욱
 * 수  정  자  : 
 * 파  일  명  : dmtc6060.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.03.25 (장형욱) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"    prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    request.setCharacterEncoding("utf-8");
    String dir = BaseProperty.get("context.common.dir");
    
    String fromDate = (String)request.getAttribute("fromDate");   
    String toDate   = (String)request.getAttribute("toDate");   
    
 // PID 확인을 위한
    String pageName = request.getRequestURI();
    int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
    int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
    pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
	type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-25
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 95;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	 
	var GET_USER_AUTH_VALUE = getBrchUserAuth('<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />');

    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    //-- 검색 필드
    initEmEdit(EM_S_DT_S,       "YYYY", PK);      //시작일
    
    
    
    //default ;
    
    
    //조회일자 초기값.

    EM_S_DT_S.text = <%=fromDate%>;
    //EM_E_DT_S.text = <%=toDate%>;    
    
    
    EM_S_DT_S.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id=TYPE         	name="구분"      width=50    align=left  suppress=1 bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</FC>'
                     + '<FC>id=COMM_NAME1       name="적립,사용명"   width=100   align=left   bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</FC>'
                     + '<C>id=MON01	        	name="1월 포인트"       width=100   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON01_CNT         name="1월 건수"       width=70   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON02	        	name="2월 포인트"       width=100   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON02_CNT         name="2월 건수"       width=70   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON03	        	name="3월 포인트"       width=100   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON03_CNT         name="3월 건수"       width=70   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON04	        	name="4월 포인트"       width=100   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON04_CNT         name="4월 건수"       width=70   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON05	        	name="5월 포인트"       width=100   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON05_CNT         name="5월 건수"       width=70   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON06	        	name="6월 포인트"       width=100   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON06_CNT         name="6월 건수"       width=70   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON07	        	name="7월 포인트"       width=100   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON07_CNT         name="7월 건수"       width=70   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON08	        	name="8월 포인트"       width=100   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON08_CNT         name="8월 건수"       width=70   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON09	        	name="9월 포인트"       width=100   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON09_CNT         name="9월 건수"       width=70   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON10	        	name="10월 포인트"       width=100   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON10_CNT         name="10월 건수"       width=70   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON11	        	name="11월 포인트"       width=100   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON11_CNT         name="11월 건수"       width=70   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON12	        	name="12월 포인트"       width=100   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     + '<C>id=MON12_CNT         name="12월 건수"       width=70   align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true"	mask="#,###" bgcolor={decode(COMM_NAME1,"잔여포인트","#FAED7D",white)}</C>'
                     ;
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);

}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
     (6) 출력       - btn_Print()
     (7) 확정       - btn_Conf()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-25
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    var strSdt    = EM_S_DT_S.text;
    
    
    if (trim(EM_S_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "시작일자");
        EM_S_DT_S.Focus();
        return;
    } 
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strSdt="      + encodeURIComponent(strSdt);
                  
    TR_MAIN.Action  = "/dcs/dmtc606.dc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    setPorcCount("SELECT", DS_O_MASTER.RealCount(1, DS_O_MASTER.CountRow));
    
    if (DS_O_MASTER.CountRow > 0 ) {
        GD_MASTER.Focus();        
    }
    else {
    	EM_S_DT_S.Focus();    
    }    
    
    DS_O_MASTER.Addrow();
    
    DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TYPE") = "합계";
    DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "COMM_NAME1") = "잔여포인트";
    
    
    Tot_calc();
    
    
}


function Tot_calc() {
	
	
	GD_MASTER.redraw = false;
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON01") = 	  DS_O_MASTER.NameSum("MON01",1,11)    - DS_O_MASTER.NameSum("MON01",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON01_CNT") = DS_O_MASTER.NameSum("MON01_CNT",1,11)- DS_O_MASTER.NameSum("MON01_CNT",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON02") = 	  DS_O_MASTER.NameSum("MON02",1,11)    - DS_O_MASTER.NameSum("MON02",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON02_CNT") = DS_O_MASTER.NameSum("MON02_CNT",1,11)- DS_O_MASTER.NameSum("MON02_CNT",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON03") = 	  DS_O_MASTER.NameSum("MON03",1,11)    - DS_O_MASTER.NameSum("MON03",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON03_CNT") = DS_O_MASTER.NameSum("MON03_CNT",1,11)- DS_O_MASTER.NameSum("MON03_CNT",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON04") = 	  DS_O_MASTER.NameSum("MON04",1,11)    - DS_O_MASTER.NameSum("MON04",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON04_CNT") = DS_O_MASTER.NameSum("MON04_CNT",1,11)- DS_O_MASTER.NameSum("MON04_CNT",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON05") = 	  DS_O_MASTER.NameSum("MON05",1,11)    - DS_O_MASTER.NameSum("MON05",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON05_CNT") = DS_O_MASTER.NameSum("MON05_CNT",1,11)- DS_O_MASTER.NameSum("MON05_CNT",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON06") = 	  DS_O_MASTER.NameSum("MON06",1,11)    - DS_O_MASTER.NameSum("MON06",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON06_CNT") = DS_O_MASTER.NameSum("MON06_CNT",1,11)- DS_O_MASTER.NameSum("MON06_CNT",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON07") = 	  DS_O_MASTER.NameSum("MON07",1,11)    - DS_O_MASTER.NameSum("MON07",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON07_CNT") = DS_O_MASTER.NameSum("MON07_CNT",1,11)- DS_O_MASTER.NameSum("MON07_CNT",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON08") = 	  DS_O_MASTER.NameSum("MON08",1,11)    - DS_O_MASTER.NameSum("MON08",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON08_CNT") = DS_O_MASTER.NameSum("MON08_CNT",1,11)- DS_O_MASTER.NameSum("MON08_CNT",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON09") = 	  DS_O_MASTER.NameSum("MON09",1,11)    - DS_O_MASTER.NameSum("MON09",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON09_CNT") = DS_O_MASTER.NameSum("MON09_CNT",1,11)- DS_O_MASTER.NameSum("MON09_CNT",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON10") = 	  DS_O_MASTER.NameSum("MON10",1,11)    - DS_O_MASTER.NameSum("MON10",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON10_CNT") = DS_O_MASTER.NameSum("MON10_CNT",1,11)- DS_O_MASTER.NameSum("MON10_CNT",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON11") = 	  DS_O_MASTER.NameSum("MON11",1,11)    - DS_O_MASTER.NameSum("MON11",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON11_CNT") = DS_O_MASTER.NameSum("MON11_CNT",1,11)- DS_O_MASTER.NameSum("MON11_CNT",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON12") = 	  DS_O_MASTER.NameSum("MON12",1,11)    - DS_O_MASTER.NameSum("MON12",12,DS_O_MASTER.countrow-2);
	DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MON12_CNT") = DS_O_MASTER.NameSum("MON12_CNT",1,11)- DS_O_MASTER.NameSum("MON12_CNT",12,DS_O_MASTER.countrow-2);
	GD_MASTER.redraw = true;
	
	
}

/**
 * btn_Excel()
 * 작 성 자	: 
 * 작 성 일	: 
 * 개	  요 : 
 * return값	: 
 */
function btn_Excel() {

	if(DS_O_MASTER.CountRow	<= 0){
	  showMessage(INFORMATION, OK, "USER-1000","다운 할	내용이 없습니다. 조회 후 엑셀다운 하십시오.");
		return;
	}
	var	strTitle = "월별 포인트 적립사용현황";

	
	var	strSaleDt		= EM_S_DT_S.text;		//시작년월
	
	
	var	parameters = "조회연도 - "			 + strSaleDt;
	
	//openExcel2(GD_MASTER, strTitle,	parameters,	true );
	openExcel5(GD_MASTER, strTitle,	parameters,	true , "",g_strPid );
	
}


/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * keyPressEvent()
  * 작 성 자 : 장형욱
  * 작 성 일 : 2010.02.24
  * 개      요  : Enter, Tab키 이벤트
  * return값 :
  */
 function keyPressEvent(kcode) {
     
 }
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                        *-->
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
<!-- 가맹점명 onKillFocus() -->





    

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
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
<body onLoad="doInit();" class="PL10 PT15 ">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">조회연도</th>
						<td><comment id="_NSID_"> <object
							id=EM_S_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script> </td>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="dot"></td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><object id=GD_MASTER width="100%" height=505
					classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_O_MASTER">
				</object></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>