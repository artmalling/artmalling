<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽운영 > VIP 라운지 > 시간대별 VIP 방문고객조회
 * 작 성 일    : 2010.06.30
 * 작 성 자    : 김영진
 * 수 정 자    : 
 * 파 일 명    : dmbo7130.jsp
 * 버    전       : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가) 
 * 개    요       : 
 * 이    력       :
 *           2010.06.30 (김영진) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%
	request.setCharacterEncoding("utf-8");
%> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"        prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"            prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
    String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
    strToMonth = strToMonth + "01";
    
    String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var EXCEL_PARAMS = "";
var strLastDay   = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-30
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
	var GET_USER_AUTH_VALUE = getBrchUserAuth('<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />');
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');

    //그리드 초기화
    gridCreate1(); //마스터
    
    //검색조건
    if ("B" == GET_USER_AUTH_VALUE) {
        initEmEdit(EM_BRCH_ID_S,    "GEN^10",   READ);       //가맹점코드
        enableControl(IMG_BRCH,   false);
    } else {
        initEmEdit(EM_BRCH_ID_S,    "GEN^10",   PK);        //가맹점코드
        enableControl(IMG_BRCH,   true); 
    }
    
    //EMedit에 초기화
    initEmEdit(EM_VISIT_IN_DATE_S,  "YYYYMMDD",     PK);         //조회 시작기간    
    initEmEdit(EM_VISIT_IN_DATE_E,  "YYYYMMDD",     PK);         //조회 종료기간
    initEmEdit(EM_BRCH_NM_S,        "GEN^40",       READ);       //가맹점명

    //default ;
    EM_BRCH_ID_S.Text = '<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />'; //소속가맹점 
    setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_ID_S.Text);
    if (DS_O_RESULT.CountRow == 1 ) {
        EM_BRCH_ID_S.Text = DS_O_RESULT.NameValue(1, "CODE_CD");
        EM_BRCH_NM_S.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
    }
    
    EM_VISIT_IN_DATE_S.Text = addDate("M", "-1", '<%=strToMonth%>');
    strLastDay = EM_VISIT_IN_DATE_S.Text.substring(0, 6) + getLastDay( EM_VISIT_IN_DATE_S.Text.substring(0, 4), EM_VISIT_IN_DATE_S.Text.substring(5, 6) );
    EM_VISIT_IN_DATE_E.Text = strLastDay;
    
    btn_Search();
}
 
function gridCreate1(){
   
    var hdrProperies = '<FC>id={currow}     name="NO"         width=30   align=center</FC>'
    	             + '<FC>id=IN_DATE      name="일자"       width=80   align=center  mask="XXXX/XX/XX" SumText= "합계"</FC>'
    	             + '<FC>id=VISIT_TQTY   name="방문자수"   width=70   align=right   SumText=@sum</FC>'
                     + '<FC>id=H11B         name="11이전"     width=60   align=right   SumText=@sum</FC>'  
                     + '<FC>id=H12 　       name="~12"        width=60   align=right   SumText=@sum</FC>'  
                     + '<FC>id=H13 　       name="~13"        width=60   align=right   SumText=@sum</FC>'  
                     + '<FC>id=H14 　       name="~14"        width=60   align=right   SumText=@sum</FC>'  
                     + '<FC>id=H15 　       name="~15"        width=60   align=right   SumText=@sum</FC>'  
                     + '<FC>id=H16 　       name="~16"        width=60   align=right   SumText=@sum</FC>'  
                     + '<FC>id=H17 　       name="~17"        width=60   align=right   SumText=@sum</FC>'  
                     + '<FC>id=H18 　       name="~18"        width=60   align=right   SumText=@sum</FC>'  
                     + '<FC>id=H19 　       name="~19"        width=60   align=right   SumText=@sum</FC>'  
                     + '<FC>id=H19A　  　　       name="19시이후"    width=60   align=right   SumText=@sum</FC>';  
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    GR_MASTER.ViewSummary = "1";
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-25
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if(trim(EM_VISIT_IN_DATE_S.Text).length == 0){          // 조회시작일
	    showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	    EM_VISIT_IN_DATE_S.Focus();
	    return;
	}
	if(trim(EM_VISIT_IN_DATE_E.Text).length == 0){          // 조회 종료일
	    showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	    EM_VISIT_IN_DATE_E.Focus();
	    return;
	}
	if(EM_VISIT_IN_DATE_S.Text > EM_VISIT_IN_DATE_E.Text){  // 조회일 정합성
	    showMessage(EXCLAMATION, OK, "USER-1015");
	    EM_VISIT_IN_DATE_S.Focus();
	    return;
	} 
	if(trim(EM_BRCH_ID_S.Text).length == 0){          // 가맹점명
	    showMessage(EXCLAMATION, OK, "USER-1001","가맹점명");
	    EM_BRCH_ID_S.Focus();
	    return;
    }
	showMaster();
	
	//조회결과 Return
	setPorcCount("SELECT", DS_O_MASTER.CountRow);
}


/**
 * btn_Excel()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-30
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
   
    var ExcelTitle = "시간대별 VIP 방문 고객조회"
    openExcel2(GR_MASTER, ExcelTitle, EXCEL_PARAMS, true );
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-25
 * 개       요     : 개인카드 리스트 조회 
 * return값 : void
 */
function showMaster(){
 
	var strVisitInDtS = EM_VISIT_IN_DATE_S.Text;
    var strVisitInDtE = EM_VISIT_IN_DATE_E.Text;
    var strBrchId     = EM_BRCH_ID_S.Text;
    var strFlag       = RD_FLAG_S.CodeValue;

    var strFlagNm = ""; 
    if(strFlag == "T"){
    	strFlagNm = "총방문자수";
    }else{
    	strFlagNm = "VIP방문횟수";
    }
    
    EXCEL_PARAMS  = "조회기간="  + strVisitInDtS + "~" + strVisitInDtE;
    EXCEL_PARAMS += "-가맹점="   + strBrchId;
    EXCEL_PARAMS += "-가맹점명=" + EM_BRCH_NM_S.Text;
    EXCEL_PARAMS += "-구분="     + strFlagNm;

    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strVisitInDtS=" + encodeURIComponent(strVisitInDtS)
                    + "&strVisitInDtE=" + encodeURIComponent(strVisitInDtE)
                    + "&strBrchId="     + encodeURIComponent(strBrchI)
                    + "&strFlag="       + encodeURIComponent(strFlag);
    TR_MAIN.Action  ="/dcs/dmbo713.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
        EM_VISIT_IN_DATE_S.Focus();
    }
}

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-30
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
<script language=JavaScript for=EM_BRCH_ID_S event=onKillFocus()>
    if ((EM_BRCH_ID_S.Modified) && (trim(EM_BRCH_ID_S.Text).length != 10)) {
        EM_BRCH_ID_S.Text = "";
        EM_BRCH_NM_S.Text = "";
    }
</script>
<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_VISIT_IN_DATE_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_VISIT_IN_DATE_S)){
        EM_VISIT_IN_DATE_S.Text = addDate("M", "-1", '<%=strToMonth%>');
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_VISIT_IN_DATE_E event=onKillFocus()>
    if(!checkDateTypeYMD(EM_VISIT_IN_DATE_E)){
        EM_VISIT_IN_DATE_E.Text = strLastDay;
    }
</script>  
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *--> 
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
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
						<th width="68" class="point">조회기간</th>
						<td width="192"><comment id="_NSID_"> <object
							id=EM_VISIT_IN_DATE_S classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_VISIT_IN_DATE_S)" />- <comment
							id="_NSID_"> <object id=EM_VISIT_IN_DATE_E
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_VISIT_IN_DATE_E)" /></td>
						<th width="68" class="point">가맹점</th>
						<td width="180"><comment id="_NSID_"> <object id=EM_BRCH_ID_S
                            classid=<%=Util.CLSID_EMEDIT%> width=76 tabindex=1
                            align="absmiddle"
                            onKeyUp="javascript:keyPressEvent(event.keyCode);"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							align="absmiddle" id="IMG_BRCH"
							onclick="getBrchPop(EM_BRCH_ID_S,EM_BRCH_NM_S)" /> <comment
							id="_NSID_"> <object id=EM_BRCH_NM_S
							classid=<%=Util.CLSID_EMEDIT%> width=76 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="68">구분</th>
						<td><comment id="_NSID_"> <object id=RD_FLAG_S
							classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 170"
							tabindex=1>
							<param name=Cols value="2">
							<param name=Format value="T^총방문자수,V^VIP방문횟수">
							<param name=CodeValue value="T">
							<param name="AutoMargin" value="true">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
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
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=503 classid=<%=Util.CLSID_GRID%> tabindex=1>
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
</body>
</html>
