<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 포인트정산 > 월별포인트 잔액관리
 * 작  성  일  : 2010.05.02
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dmtc6030.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.05.02 (김영진) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>
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
%>
<script LANGUAGE="JavaScript">
<!--
var parameters  = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-02
 * 개       요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_SUM_YM,       "YYYYMM",  PK);           //조회월
    initEmEdit(EM_BRCH_ID_S,    "GEN^10",  NORMAL);       //가맹점ID
    initEmEdit(EM_BRCH_NAME_S,  "GEN^40",  READ);         //가맹점명
    
    //조회년월 초기값.
    EM_SUM_YM.text = addDate("M", "0", '<%=strToMonth%>');
    
    //화면 OPEN시 자동 조회
    btn_Search();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"               width=30        align=center</FC>'
                     + '<FC>id=BRCH_ID          name="가맹점CD"         width=100       align=center show=false</FC>'
                     + '<FC>id=BRCH_NAME        name="가맹점명"         width=126       align=left</FC>'
                     + '<FC>id=PREV_POINT       name="전월이월"         width=140       align=right</FC>'
                     + '<FC>id=ADD_POINT        name="당월적립"         width=140       align=right</FC>'
                     + '<FC>id=USE_POINT        name="당월사용"         width=170       align=right</FC>'
                     + '<FC>id=CURR_POINT       name="당월누계"         width=170       align=right</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
     (3) 출력       - btn_Print()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-02
 * 개       요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if(trim(EM_SUM_YM.Text).length == 0){   // 조회년월
	    showMessage(EXCLAMATION, OK, "USER-1001","조회년월");
	    EM_SUM_YM.Focus();
	    return;
	}
    showMaster();
	//조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.RealCount(1, DS_O_MASTER.CountRow));
}

/**
 * btn_Excel()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-02
 * 개       요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    if (strBrchId == "") strBrchId = "전체";
    if (strBrchNm == "") strBrchNm = "전체";
    
    var params = "조회년월="     + strSumSMonth
               + " -가맹점코드=" + strBrchId
               + " -가맹점명="   + strBrchNm;
    
    var ExcelTitle = "월별 포인트 잔액 관리"

    openExcel2(GR_MASTER, ExcelTitle, params, true );
    
    GR_MASTER.Focus();
}

/**
 * btn_Print()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-02
 * 개       요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
	if (DS_O_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, Ok, "USER-1031");
        return false;
    }

    window.open("/dcs/dmtc603.dc?goTo=print"+parameters,"OZREPORT", 1000, 700);
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-02
 * 개       요     : 월별 포인트 잔액 관리조회
 * return값 : void
 */
function showMaster(){
    strBrchId   = EM_BRCH_ID_S.Text;
    strBrchNm   = EM_BRCH_NAME_S.Text;
    strSumSMonth= EM_SUM_YM.Text;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    parameters      = "&strBrchId="   + encodeURIComponent(strBrchId)
                    + "&strSumSMonth="+ encodeURIComponent(strSumSMonth);
    TR_MAIN.Action  ="/dcs/dmtc603.dc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
        EM_SUM_YM.Focus();
    }
}

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-02
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
    EM_BRCH_NAME_S.Text = "";//조건입력시 코드초기화
    if (EM_BRCH_ID_S.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_BRCH_ID_S.Text.length == 10) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_ID_S.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
                EM_BRCH_ID_S.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
                EM_BRCH_NAME_S.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getBrchPop(EM_BRCH_ID_S,EM_BRCH_NAME_S);
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
<!--* C. 가우스 이벤트 처리                                                                                                                                         *-->
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
    if ((EM_BRCH_ID_S.Modified) && (EM_BRCH_ID_S.Text.length != 10)) {
        EM_BRCH_NAME_S.Text = "";
    }
</script>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 조회년월 onKillFocus() -->
<script language=JavaScript for=EM_SUM_YM event=onKillFocus()>
    if(!checkDateTypeYM(EM_SUM_YM)){
        EM_SUM_YM.text = addDate("M", "0", '<%=strToMonth%>');
    }
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
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>> </object>
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
						<th width="100" class="point">조회년월</th>
						<td width="250"><comment id="_NSID_"> <object
							id=EM_SUM_YM classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('M',EM_SUM_YM)" /></td>
						<th width="100">가맹점명</th>
                        <td><comment id="_NSID_"> <object id=EM_BRCH_ID_S
                            classid=<%=Util.CLSID_EMEDIT%> width=71
                            onKeyUp="javascript:keyPressEvent(event.keyCode);" tabindex=1>
                        </object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
                            onclick="getBrchPop(EM_BRCH_ID_S,EM_BRCH_NAME_S)" /> <comment
                            id="_NSID_"> <object id=EM_BRCH_NAME_S
                            classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
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
				<td><comment id="_NSID_"><object id=GR_MASTER width="100%" height=504
					classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_O_MASTER">
				</object></comment> <script> _ws_(_NSID_);</script></td>
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