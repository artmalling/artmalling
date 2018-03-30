<!-- 
 * 시스템명 : 영업지원관리>사은행사관리>사은품지급>VIP 커피 증정 조회
 * 작 성 일 : 2014.05.14
 * 작 성 자 : 강진실
 * 수 정 자 : 
 * 파 일 명 : dctm4360.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    request.setCharacterEncoding("utf-8");
    String dir = BaseProperty.get("context.common.dir");
    
    String toDate   = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());    
  
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
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var strSdt = "";
var strEdt = "";
var strPlaceNm ="";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 강진실
 * 작 성 일 : 2014-05-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
var top = 90;		//해당화면의 동적그리드top위치
 
function doInit(){
	
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    //조회일자 초기값.
    initEmEdit(EM_S_DT_S,       "YYYYMMDD", PK);           //시작일
    initEmEdit(EM_E_DT_S,       "YYYYMMDD", PK);           //종료일    
    initComboStyle(LC_PLACE_NM_S, DS_PLACE_NM_S, "CODE^0^80,NAME^0^80", 1, NORMAL);    //상태
    
    getPlaceNm("DS_PLACE_NM_S");  
    LC_PLACE_NM_S.BindColVal = "%";
    
    EM_S_DT_S.text = addDate("D", "-1", '<%=toDate%>');
    EM_E_DT_S.text = <%=toDate%>;    
  	
    //화면OPEN시 조회
    btn_Search();
}
 
function gridCreate1(){
    var hdrProperies = '<FC>id={currow}		  name="NO"				  width=30	  align=center	</FC>'
    				 + '<FC>id=EXCH_TIME      name="일자(증정일자)"   width=150   align=center   mask="XXXX/XX/XX XX:XX:XX" sumtext="합계" </FC>'
    				 + '<FC>id=CUST_ID        name="회원번호"      	  width=100   align=center  </FC>'
                     + '<FC>id=CARD_NO        name="카드번호"      	  width=150   align=center  </FC>'
                     + '<FC>id=CUST_NAME      name="회원명"      	  width=80    align=left    </FC>'
                     + '<FC>id=USER_NAME      name="증정장소"         width=100   align=center  </FC>'
                     + '<FC>id=EXCH_CNT       name="증정수량"         width=70    align=right    sumtext={subsum(EXCH_CNT)}  </FC>'
                     + '<FC>id=TOT_SALE_AMT   name="당일구매금액"     width=100   align=right    sumtext={subsum(TOT_SALE_AMT)}  </FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    GD_MASTER.ViewSummary = "1";
    GD_MASTER.DecRealData = true;
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
 * 작 성 자 : 강진실
 * 작 성 일 : 2014-05-14
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    if (trim(EM_S_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "시작일자");
        EM_S_DT_S.Focus();
        return;
    } else if (trim(EM_E_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "종료일자");
        EM_E_DT_S.Focus();
        return;
    }     
    
    if (eval(EM_S_DT_S.text) > eval(EM_E_DT_S.text) )
    {
        showMessage(EXCLAMATION, OK, "USER-1015",  "종료일자");
        EM_E_DT_S.Focus();
        return;     
    } 
    
    strSdt = EM_S_DT_S.text;
    strEdt = EM_E_DT_S.text;
    strPlaceNm = LC_PLACE_NM_S.BindColVal;

    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strSdt="   + encodeURIComponent(strSdt)
                    + "&strEdt="   + encodeURIComponent(strEdt)
                    + "&strPlaceNm=" + encodeURIComponent(strPlaceNm);
    
    TR_MAIN.Action  = "/dcs/dctm436.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; 
    TR_MAIN.Post();    
    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    if (DS_O_MASTER.CountRow > 0 )
        GD_MASTER.Focus();
    else 
    	EM_S_DT_S.Focus();
}

/**
 * btn_Excel()
 * 작 성 자 : 강진실
 * 작 성 일 : 2014-05-14
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    var ExcelTitle = "VIP 커피 증정";
    var parameters = "조회기간=" + strSdt + "~" + strEdt
                   + " -장소=" + strPlaceNm;    
    openExcel2(GD_MASTER, ExcelTitle, parameters, true );
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

function getPlaceNm(strDataSet) { 
	DS_PLACE_NM_S.ClearData();
	DS_PLACE_NM_S.Addrow();
	
	TR_MAIN.Action	= "/dcs/dctm436.dm?goTo=getPlaceNm";
	TR_MAIN.KeyValue= "SERVLET(O:DS_PLACE_NM_S="+strDataSet+")";
    TR_MAIN.Post();
}

-->
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

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_S_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_DT_S)){
    	EM_S_DT_S.text = addDate("D", "-1", '<%=toDate%>');
    }
</script>

<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_E_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_E_DT_S)){
        initEmEdit(EM_E_DT_S,    "TODAY",     PK);         
    }
</script>  

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 공통콤보용 -->
<comment id="_NSID_">
<object id="DS_PLACE_NM_S" classid=<%= Util.CLSID_DATASET %>></object>
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
						<th width="80" class="point">일자별 조회</th>
						<td width="280"><comment id="_NSID_"> <object
							id=EM_S_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DT_S)" />- <comment
							id="_NSID_"> <object id=EM_E_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_E_DT_S)" /></td>
						<th width="80">장소별 조회</th>
						<td><comment id="_NSID_"> <object id=LC_PLACE_NM_S
							classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=200 tabindex=1></object>
						</comment> <script> _ws_(_NSID_);</script></td>
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
				<td><object id=GD_MASTER width="100%" height=504
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
