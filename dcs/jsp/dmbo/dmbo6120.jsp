<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 승인처리 > 포인트 승인내역 조회
 * 작  성  일  : 2010.01.14
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dmbo6120.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.01.14 (김영진) 신규작성
 *           2010.03.23 (김영진) 기능추가
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %>  
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"        prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"            prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
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
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<%
    String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date()); 
    strToMonth = strToMonth + "01";
    
    String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    
 // PID 확인을 위한
    String pageName = request.getRequestURI();
    int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
    int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
    pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

%>
<script LANGUAGE="JavaScript">
<!--
var EXCEL_PARAMS = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-23
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 270;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	var GET_USER_AUTH_VALUE = getBrchUserAuth('<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />');
	
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); 
    
    // EMedit에 초기화
    initEmEdit(EM_CUST_NAME,   "GEN^40",              READ);       //회원명 
    initEmEdit(EM_HOME_PH,     "GEN^40",              READ);       //자택전화
    initEmEdit(EM_HOME_PH1,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH2,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH3,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_MOBILE_PH,   "GEN^40",              READ);       //이동전화 
    initEmEdit(EM_MOBILE_PH1,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH2,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH3,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_SS_NO,       "000000",      		  READ);       //생년월일
    initEmEdit(EM_HOME_ADDR,   "GEN^400",             READ);       //회원주소 
    initEmEdit(EM_POINT,       "NUMBER^9^0",          READ);       //누적포인트
//     initEmEdit(EM_OCCURS_POINT,"NUMBER^9^0",          READ);       //발생포인트
//     initEmEdit(EM_SUM_POINT,   "NUMBER^9^0",          READ);       //누적+발생포인트
    initEmEdit(EM_EMAIL,       "GEN^80",              READ);       //이메일주소
    initEmEdit(EM_EMAIL1,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_EMAIL2,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_CUST_GTADE,  "GEN^40",              READ);       //회원등급
    initEmEdit(EM_CUST_TYPE,   "GEN^40",     		  READ);       //회원유형
     
    initEmEdit(EM_SALE_F_DT,    "YYYYMMDD",           PK);         //조회 시작기간    
    initEmEdit(EM_SALE_T_DT,    "TODAY",              PK);         //조회 종료기간
    initEmEdit(EM_CARD_NO_S,   "0000-0000-0000-0000", PK);         //카드번호
    initEmEdit(EM_BRCH_NM_S,   "GEN^40",              READ);       //가맹점명
    initEmEdit(EM_ENTR_DT,    "YYYYMMDD",             READ);       //가입일자 추가 16.12.22

    
    //검색조건
    /*
    if ("B" == GET_USER_AUTH_VALUE) {
        initEmEdit(EM_BRCH_ID_S,    "GEN^10", READ);       //가맹점코드
        enableControl(IMG_BRCH,     false);
    } else {
        initEmEdit(EM_BRCH_ID_S,    "GEN^10", NORMAL);     //가맹점코드
        enableControl(IMG_BRCH,     true); 
    }
    */
    initEmEdit(EM_BRCH_ID_S,    "GEN^10", PK);     //가맹점코드
    
    //default ;
    EM_BRCH_ID_S.Text = '<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />'; //소속가맹점 
    setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_ID_S.Text);
    if (DS_O_RESULT.CountRow == 1 ) {
    	EM_BRCH_ID_S.Text = DS_O_RESULT.NameValue(1, "CODE_CD");
    	EM_BRCH_NM_S.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
    } 
    
    
    EM_SALE_F_DT.Text = addDate("M", "-1", '<%=strToMonth%>');
    EM_SALE_F_DT.Focus();

    //활성화 비활성화 화면 초기 설정
    EM_HOME_PH1.style.display    = "none";
    EM_HOME_PH2.style.display    = "none"; 
    EM_HOME_PH3.style.display    = "none";
    EM_MOBILE_PH1.style.display  = "none";
    EM_MOBILE_PH2.style.display  = "none";
    EM_MOBILE_PH3.style.display  = "none";
    EM_EMAIL1.style.display      = "none"; 
    EM_EMAIL2.style.display      = "none";
}


function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"            width=30      align=center</FC>'
                     + '<FC>id=SALE_DT          name="일자"           width=80     align=center     mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=CARD_NO          name="카드번호"       width=140    align=center     mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=BRCH_NAME        name="가맹점명"       width=100    align=left</FC>'
                     + '<FC>id=TRADE_NM         name="구분"           width=60     align=center</FC>'
                     + '<FC>id=POINT            name="포인트"         width=84     align=right</FC>'
                     + '<FC>id=ADD_USE_FLAG_NM  name="유형"           width=80     align=left</FC>'
                     + '<FC>id=RECP_NO          name="거래고유번호"   width=147     align=center</FC>'
                     + '<FC>id=CAN_FLAG         name="취소여부"       width=66      align=center</FC>'
                     + '<FC>id=O_RECP_NO        name="취소원거래번호"   width=147     align=center</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-23
 * 개        요    : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if(trim(EM_SALE_F_DT.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_SALE_F_DT.Focus();
        return;
    } 
    if(trim(EM_SALE_T_DT.Text).length == 0){    // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_SALE_T_DT.Focus();
        return;
    }
    if(EM_SALE_F_DT.Text > EM_SALE_T_DT.Text){  // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_SALE_F_DT.Focus();
        return;
    }
    
    if(trim(EM_CARD_NO_S.Text).length == 0){          // 카드번호
        showMessage(EXCLAMATION, OK, "USER-1001","카드번호");
        EM_CARD_NO_S.Focus();
        return;
    }
    
    // MARIO OUTLET
    //if (trim(EM_CARD_NO_S.Text).length > 0 && trim(EM_CARD_NO_S.Text).length < 16) {
    if(trim(EM_CARD_NO_S.Text).length != 0 && trim(EM_CARD_NO_S.Text).length != 13 && trim(EM_CARD_NO_S.Text).length != 16 ) {	
        showMessage(EXCLAMATION, OK, "USER-1000",  "카드번호는 13자리 또는 16자리입니다.");
        EM_CARD_NO_S.Focus();
        return;
    }
    
    if(trim(EM_BRCH_ID_S.Text).length == 0){          // 가맹점
        showMessage(EXCLAMATION, OK, "USER-1001","가맹점");
        EM_BRCH_ID_S.Focus();
        return;
    }
    
    EXCEL_PARAMS  = "시작일자="  + EM_SALE_F_DT.Text;
    EXCEL_PARAMS += "-종료일자=" + EM_SALE_T_DT.Text;
    EXCEL_PARAMS += "-카드번호=" + EM_CARD_NO_S.Text;
    EXCEL_PARAMS += "-가맹점="   + EM_BRCH_ID_S.Text;
    EXCEL_PARAMS += "-가맹점명=" + EM_BRCH_NM_S.Text;
    
    if(srchCustInfoEvent())showMaster();
}

/**
* btn_Excel()
* 작 성 자     : 김영진
* 작 성 일     : 2010-03-23
* 개       요     : 엑셀로 다운로드
* return값 : void
*/
function btn_Excel() {
    var ExcelTitle = "포인트승인내역조회"
               
    GR_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
    //openExcel2(GR_MASTER, ExcelTitle, EXCEL_PARAMS, true );
    openExcel5(GR_MASTER, ExcelTitle, EXCEL_PARAMS, true , "",g_strPid );

}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-23
 * 개       요     : 포인트 승인내역 조회
 * return값 : void
 */
function showMaster(){

    var strSaleFDt = EM_SALE_F_DT.Text;
    var strSaleTDt = EM_SALE_T_DT.Text;
    var strBrchId  = EM_BRCH_ID_S.Text;
    var strCardNo  = EM_CARD_NO_S.Text;
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strSaleFDt=" + encodeURIComponent(strSaleFDt)
                    + "&strSaleTDt=" + encodeURIComponent(strSaleTDt)
                    + "&strBrchId="  + encodeURIComponent(strBrchId)
                    + "&strCardNo="  + encodeURIComponent(strCardNo);    
    TR_MAIN.Action  ="/dcs/dmbo612.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //Focus이동
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	EM_SALE_F_DT.Focus();
    }
    
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
}
 
/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-23
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
    EM_BRCH_NM_S.Text = "";//조건입력시 코드초기화
    if (trim(EM_BRCH_ID_S.Text).length > 0 ) {
        if (kcode == 13 || kcode == 9 || trim(EM_BRCH_ID_S.Text).length == 10) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_ID_S.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
                EM_BRCH_ID_S.Text = DS_O_RESULT.NameValue(1, "CODE_CD");
                EM_BRCH_NM_S.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getBrchPop(EM_BRCH_ID_S,EM_BRCH_NM_S);
            }
        }
    }
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
<script language=JavaScript for=EM_BRCH_ID_S event=onKillFocus()>
    if ((EM_BRCH_ID_S.Modified) && (trim(EM_BRCH_ID_S.Text).length != 10)) {
        EM_BRCH_NM_S.Text = "";
    }
</script>
<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_SALE_F_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_SALE_F_DT)){
    	EM_SALE_F_DT.Text = addDate("M", "-1", '<%=strToMonth%>');
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_SALE_T_DT event=onKillFocus()>
	if(!checkDateTypeYMD(EM_SALE_T_DT)){
		EM_SALE_T_DT.text = <%=toDate%>;
	}
</script>

<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
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
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_CUSTDETAIL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
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

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
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
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="77" class="point">조회기간</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_SALE_F_DT classid=<%=Util.CLSID_EMEDIT%> width=67
							tabindex=1 align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_SALE_F_DT)" />- <comment
							id="_NSID_"> <object id=EM_SALE_T_DT
							classid=<%=Util.CLSID_EMEDIT%> width=67 tabindex=1
							align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_SALE_T_DT)" /></td>
					</tr>
					<tr>
						<th width="77" class="point">카드번호</th>
						<td width="160"><comment id="_NSID_"> <object
							id=EM_CARD_NO_S classid=<%=Util.CLSID_EMEDIT%> width=140
							tabindex=1 align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script>
						</td>
						<th width="80" class="point">가맹점</th>
						<td><comment id="_NSID_"> <object id=EM_BRCH_ID_S
							classid=<%=Util.CLSID_EMEDIT%> width=72 tabindex=1
							align="absmiddle"
							onKeyUp="javascript:keyPressEvent(event.keyCode);"> </object> </comment> <script>_ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_BRCH"
							align="absmiddle" onclick="getBrchPop(EM_BRCH_ID_S,EM_BRCH_NM_S)" />
						<comment id="_NSID_"> <object id=EM_BRCH_NM_S
							classid=<%=Util.CLSID_EMEDIT%> width=158 tabindex=1
							align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script></td>
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
	<%@ include file="/jsp/common/memView.jsp"%>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=650 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_CUSTDETAIL classid=<%= Util.CLSID_BIND %>>
	<param name=DataID value=DS_O_CUSTDETAIL>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=CUST_NAME     ctrl=EM_CUST_NAME    Param=Text</c>
            <c>col=HOME_PH1      ctrl=EM_HOME_PH1     Param=Text</c>
            <c>col=HOME_PH2      ctrl=EM_HOME_PH2     Param=Text</c>
            <c>col=HOME_PH3      ctrl=EM_HOME_PH3     Param=Text</c>
            <c>col=MOBILE_PH1    ctrl=EM_MOBILE_PH1   Param=Text</c>
            <c>col=MOBILE_PH2    ctrl=EM_MOBILE_PH2   Param=Text</c>
            <c>col=MOBILE_PH3    ctrl=EM_MOBILE_PH3   Param=Text</c>
            <c>col=SS_NO         ctrl=EM_SS_NO        Param=Text</c>
            <c>col=HOME_ADDR     ctrl=EM_HOME_ADDR    Param=Text</c>
            <c>col=POINT         ctrl=EM_POINT        Param=Text</c>
            <c>col=OCCURS_POINT  ctrl=EM_OCCURS_POINT Param=Text</c>
            <c>col=SUM_POINT     ctrl=EM_SUM_POINT    Param=Text</c>
            <c>col=EMAIL1        ctrl=EM_EMAIL1       Param=Text</c>
            <c>col=EMAIL2        ctrl=EM_EMAIL2       Param=Text</c>
            <c>col=GRADE_NAME    ctrl=EM_CUST_GTADE   Param=Text</c>
            <c>col=CUST_TYPE_NM  ctrl=EM_CUST_TYPE    Param=Text</c>
            <c>col=ENTR_DT  	 ctrl=EM_ENTR_DT     Param=Text</c>
            
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
