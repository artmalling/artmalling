<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽관리 > 포인트관리 > 부정적립예상통계조회(브랜드)
 * 작 성 일 : 2010.05.29
 * 작 성 자 : kj
 * 수 정 자 : 
 * 파 일 명 : dmbo6200.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.05.29 (kj) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"          prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    request.setCharacterEncoding("utf-8");
    String dir = BaseProperty.get("context.common.dir");
  
    String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date()); 
    strToMonth = strToMonth + "01";
    
    String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>		
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var EXCEL_PARAMS = "";
var CUR_GR;
var parameters = "";
var bfListRowPosition = 0;                             // 이전 List Row Position
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : kj
 * 작 성 일 : 2010-04-01
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 80;		//해당화면의 동적그리드top위치
 
var	today	 = new Date();
var	old_Row	= 0;
var	searchChk =	"";

// 오늘	일자 셋팅 
var	now	= new Date();
var	mon	= now.getMonth()+1;
if(mon < 10)mon	= "0" +	mon;
var	day	= now.getDate();
if(day < 10)day	= "0" +	day;
var	varToday = now.getYear().toString()+ mon + day;
var	varToMon = now.getYear().toString()+ mon;
 
function doInit(){
	 
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    CUR_GR = GD_MASTER;

    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
	
    
    initEmEdit(EM_SALE_DT_S,					"YYYYMMDD",				PK);	//매출일자
	EM_SALE_DT_S.alignment = 1;
	
	initEmEdit(EM_SALE_DT_E,					"YYYYMMDD",				PK);	//대비일자1(2011.08.27 MARIO OUTLET)
	EM_SALE_DT_E.alignment = 1;
	
	EM_SALE_DT_S.text  = varToMon+"01"; //매출일자 당일 
	EM_SALE_DT_E.text  = varToday; //매출일자 당일
    
    //그리드 초기화
    gridCreate1(); //마스터

    
}

function gridCreate1(){
    var hdrProperies = '<FC>id=CUST_NAME    name="회원명"          width=80    align=center    SumText="합계"</FC>'
                     + '<FC>id=CARD_NO      name="카드번호"        width=150   align=center  mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=ADD_POINT    name="적립포인트"      width=120   align=right   SumText=@sum </FC>'
                     + '<FC>id=SALE_DT      name="매출일자"        width=110   align=center  mask="XXXX-XX-XX"   </FC>'
                     + '<FC>id=POS_NO       name="포스번호"        width=110   align=center     </FC>'
                     + '<FC>id=TRAN_NO      name="거래번호"        width=110   align=center     </FC>'
                     + '<FC>id=PUMBUN_NAME  name="브랜드"          width=150   align=left     </FC>'
                     + '<FC>id=TYPE_NAME    name="결제수단"        width=200   align=left     </FC>'
                     ;
    initGridStyle(GD_MASTER, "common", hdrProperies, false);

    GD_MASTER.ViewSummary = "1";
}
 
/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
     (3) 출력       - btn_Print()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : kj
 * 작 성 일 : 2010-04-01
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    DS_O_MASTER.ClearData();    
    
    EXCEL_PARAMS  = "";
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    parameters      = "&S_DT="      + encodeURIComponent(EM_SALE_DT_S.TEXT)
    parameters      += "&E_DT="      + encodeURIComponent(EM_SALE_DT_E.TEXT)		
    ;    				
    				
    TR_MAIN.Action  = "/dcs/dmbo620.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    
        GD_MASTER.Focus();        
     	 
}

/**
 * btn_Excel()
 * 작 성 자 : kj
 * 작 성 일 : 2010-04-01
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	var ExcelTitle = "부정적립예상통계조회(브랜드)"
	
	openExcel2(CUR_GR, ExcelTitle, EXCEL_PARAMS, true );
}

/**
 * btn_Print()
 * 작  성  자 : 김영진
 * 작  성  일 : 2010-05-02
 * 개        요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
    if (DS_O_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, Ok, "USER-1031");
        return false;
    }
    window.open("/dcs/dmbo620.do?goTo=print"+parameters,"OZREPORT", 1000, 700);
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * doOnClick()
  * 작 성 자 : kj
  * 작 성 일 : 2010-02-21
  * 개       요 : 선택된 기부정보 상세 조회
  * return값 : void
  */
 function doClick(row){
           
     if( row == undefined ) 
          row = DS_O_MASTER.RowPosition;
       
     var goTo        = "searchDetail";    
     var action      = "O";     
     var parameters  = "&strCardNo=" + encodeURIComponent(DS_O_MASTER.NameValue(row ,"CARD_NO"))
                     + "&strSdt="    + encodeURIComponent(EM_S_DT_S.text)
                     + "&strEdt="    + encodeURIComponent(EM_E_DT_S.text);
     
     TR_DETAIL.Action  = "/dcs/dmbo620.do?goTo="+goTo+parameters;  
     TR_DETAIL.KeyValue= "SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
     TR_DETAIL.Post();
     
     setPorcCount("SELECT", DS_O_DETAIL.CountRow);
     
 }   
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                        *-->
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

<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    //그리드 첫 row 상세조회
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        
    }else{
        DS_O_DETAIL.ClearData();
    }
</script>

<script language=JavaScript for=LC_CUST_TYPE event=OnSelChange()>

	//if(LC_CUST_TYPE.BindColVal == "30"){
		//EM_O_PUMBUN_CD.Enabled = true;
		//enableControl(IMG_PUMBUN_CD, true);
	//}else{
//		EM_O_PUMBUN_CD.Enabled = false;
		//enableControl(IMG_PUMBUN_CD, false);
	//}
	//EM_O_PUMBUN_CD.Text = "";
	//EM_O_PUMBUN_NM.Text = "";
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
    setPorcCount("SELECT", document.getElementById(this.DataId).RealCount(1, document.getElementById(this.DataId).CountRow));
    CUR_GR = this;
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
    setPorcCount("SELECT", document.getElementById(this.DataId).RealCount(1, document.getElementById(this.DataId).CountRow));
    CUR_GR = this;
</script>

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_S_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_DT_S)){
        EM_S_DT_S.text = addDate("M", "-1", '<%=strToMonth%>');
    }
</script>
    
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_E_DT_S event=onKillFocus()>
	if(!checkDateTypeYMD(EM_E_DT_S)){
	    EM_E_DT_S.text = <%=toDate%>;
	}
</script>

<!-- 품번(조회) -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=onKillFocus()>
	//변경된 내역이 없으면 무시
	if(!this.Modified)
	    return;
	    
	if(this.text==''){
		EM_O_PUMBUN_NM.Text = "";
	    return;
	}          
	setPumbunCdCombo("NAME");
</script> 

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_SEARCH_NM"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_CUST_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
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

<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
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
<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
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
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
									class="s_table">
			    <tr>
				<th class="point" width="150">매출일자</th>
										<td colspan="3"><comment id="_NSID_"> <object
												id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72
												tabindex=1 align="absmiddle"> </object> </comment> <script>
													_ws_(_NSID_);
												</script>
											<img src="/<%=dir%>/imgs/btn/date.gif"
											onclick="javascript:openCal('G',EM_SALE_DT_S)"
											align="absmiddle" />~ <comment id="_NSID_"> <object
												id="EM_SALE_DT_E" classid=<%=Util.CLSID_EMEDIT%> width=72
												tabindex=1 align="absmiddle"> </object> </comment> <script>
													_ws_(_NSID_);
												</script>
											<img src="/<%=dir%>/imgs/btn/date.gif"
											onclick="javascript:openCal('G',EM_SALE_DT_E)"
											align="absmiddle" /></td>
				</tr>
			</table>
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
				<td><object id=GD_MASTER width="100%" height=320
					classid=<%=Util.CLSID_GRID%> tabindex=1>
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
