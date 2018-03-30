<!-- 
 * 시스템명 : 포인트카드 > 포인트정산 > 포인트일정산 > 일변 POS 마감조회
 * 작  성  일  : 2010.03.25
 * 작  성  자  : 장형욱
 * 수  정  자  : 
 * 파  일  명  : dmtc4010.jsp
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
function doInit(){
	 
	var GET_USER_AUTH_VALUE = getBrchUserAuth('<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />');

    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    //-- 검색 필드
    initEmEdit(EM_S_DT_S,       "YYYYMMDD", PK);      //시작일
    initEmEdit(EM_E_DT_S,       "YYYYMMDD", PK);      //종료일
    initEmEdit(EM_BRCH_NAME_S,  "GEN",      READ);    //가맹점명    
    
    //검색조건
    if ("B" == GET_USER_AUTH_VALUE) {
        initEmEdit(EM_BRCH_ID_S,    "GEN^10", READ);       //가맹점코드
        enableControl(IMG_BRCH,     false);
    } else {
        initEmEdit(EM_BRCH_ID_S,    "GEN^10", NORMAL);     //가맹점코드
        enableControl(IMG_BRCH,     true); 
    }
    //default ;
    EM_BRCH_ID_S.Text = '<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />'; //소속가맹점 
    setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_ID_S.Text);
    if (DS_O_RESULT.CountRow == 1 ) {
        EM_BRCH_ID_S.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
        EM_BRCH_NAME_S.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
    } 
    
    //조회일자 초기값.
    EM_S_DT_S.text = <%=fromDate%>;
    EM_E_DT_S.text = <%=toDate%>;    
    
    btn_Search();
    
    EM_S_DT_S.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        name="NO"           width=30   align=center</FC>'
                     + '<FC>id=BRCH_NAME       name="가맹점명"      width=130  align=left SumText= "합계" </FC>'
                     + '<FC>id=SUM_DT          name="마감일자"      width=80   align=center mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=ADD_CNT         name="적립건수"      width=70   align=right SumText=@sum</FC>'
                     + '<FC>id=ADD_POINT       name="총적립포인트"  width=110  align=right SumText=@sum</FC>'
                     + '<FC>id=RECP_POINT      name="영수증포인트"  width=110  align=right SumText=@sum</FC>'
                     + '<FC>id=USE_CNT         name="사용건수"      width=80   align=right SumText=@sum</FC>'
                     + '<FC>id=USE_POINT       name="사용포인트"    width=90   align=right SumText=@sum</FC>'
                     + '<FC>id=RESIDUE_POINT   name="잔여포인트"    width=100  align=right SumText=@sum</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);

    GD_MASTER.ViewSummary = "1";
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
    var strEdt    = EM_E_DT_S.text;
    var strBrchCd = EM_BRCH_ID_S.text;
    
    if (trim(EM_S_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "시작일자");
        EM_S_DT_S.Focus();
        return;
    } else if (trim(EM_E_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "종료일자");
        EM_E_DT_S.Focus();
        return;
    }     
    if (trim(EM_S_DT_S.text).length != 8){
        showMessage(EXCLAMATION, OK, "USER-1004",  "시작일자");
        EM_S_DT_S.Focus();
        return;
    }
    if (trim(EM_E_DT_S.text).length != 8){
        showMessage(EXCLAMATION, OK, "USER-1004",  "종료일자");
        EM_E_DT_S.Focus();
        return;
    }     
    if (trim(EM_S_DT_S.text) > trim(EM_E_DT_S.text)) { 
        showMessage(EXCLAMATION, OK, "USER-1015",  "");
        EM_S_DT_S.Focus();
        return;
    }
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strSdt="      + encodeURIComponent(strSdt)
                    + "&strEdt="      + encodeURIComponent(strEdt)
                    + "&strBrchCd="   + encodeURIComponent(strBrchCd);
                  
    TR_MAIN.Action  = "/dcs/dmtc401.dc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    setPorcCount("SELECT", DS_O_MASTER.RealCount(1, DS_O_MASTER.CountRow));
    
    if (DS_O_MASTER.CountRow > 0 ) {
        GD_MASTER.Focus();        
    }
    else {
    	EM_S_DT_S.Focus();    
    }    
    
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
<script language=JavaScript for=EM_BRCH_ID_S event=onKillFocus()>
    if ((EM_BRCH_ID_S.Modified) && (EM_BRCH_ID_S.Text.length != 10)) {
        EM_BRCH_NAME_S.Text = "";
    }
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_S_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_DT_S)){
        EM_S_DT_S.text = addDate("M", "-1", '<%=fromDate%>');
    }
</script>
    
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_E_DT_S event=onKillFocus()>
	if(!checkDateTypeYMD(EM_E_DT_S)){
	    EM_E_DT_S.text = <%=toDate%>;
	}
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
						<th width="80" class="point">조회기간</th>
						<td width="310"><comment id="_NSID_"> <object
							id=EM_S_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DT_S)" />- <comment
							id="_NSID_"> <object id=EM_E_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_E_DT_S)" /></td>
						<th width="80">가맹점명</th>
						<td><comment id="_NSID_"> <object id=EM_BRCH_ID_S
							classid=<%=Util.CLSID_EMEDIT%> width=75 tabindex=1
							align="absmiddle"
							onKeyUp="javascript:keyPressEvent(event.keyCode);"></object> </comment><script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_BRCH"
							align="absmiddle" onclick="getBrchPop(EM_BRCH_ID_S,EM_BRCH_NAME_S)" />
						<comment id="_NSID_"> <object id=EM_BRCH_NAME_S
							classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
							align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
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
